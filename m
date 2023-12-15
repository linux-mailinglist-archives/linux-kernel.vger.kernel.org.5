Return-Path: <linux-kernel+bounces-1136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3E5814AFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9D81F24B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C63589F;
	Fri, 15 Dec 2023 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcY30Yw/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467B2364B6;
	Fri, 15 Dec 2023 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 507D1E0005;
	Fri, 15 Dec 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702651950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIbLLJK1qcEJamp9vjm8660v25/zU9yhpgwAGCYNgvo=;
	b=AcY30Yw/bHL+H2QYTDV3jrH8QGb+E1WL833hXl9FqflA6RkfJE3r2kVOISO9HNq4un0tF1
	aGBG8a+CdB+WMPJ0nh+METpxuM0EJBqHlFe2jWmNfwmicDuWai7HvPthCnpiXGDAMU9yjd
	3rXNBeO3M0P/66sU2lx6hwflHiVPIfrvMyVrGpOax05xGWzyu98OqVqZZE65kEJl/BMqpE
	TO/7f6bNB9ZE9ipDqq8IFKJ3JaOAFIEoXPXYHuuXF2n63uY1C9KLrIhWARynt13NMd9qos
	XDpm0moGZPgoJNgBitVfRXCw8kMgTuqV/M+yUTjreC4qeGlmKmZEY70LvBr0eQ==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, pali@kernel.org, mrkiko.rs@gmail.com,
 chris.packham@alliedtelesis.co.nz, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: enachman@marvell.com, cyuval@marvell.com
Subject: Re: [PATCH v8 0/3] arm64: dts: cn913x: add COM Express boards
In-Reply-To: <20231211171739.4090179-1-enachman@marvell.com>
References: <20231211171739.4090179-1-enachman@marvell.com>
Date: Fri, 15 Dec 2023 15:52:29 +0100
Message-ID: <87cyv7cyc2.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Elad Nachman <enachman@marvell.com> writes:

> From: Elad Nachman <enachman@marvell.com>
>
> Add support for CN9130 and CN9131 COM Express Type 7 CPU
> module boards by Marvell.
> Add device tree bindings for this board.
> Define these COM Express CPU modules as dtsi, and
> provide a dtsi file for a carrier board (Marvell AC5X RD
> COM Express type 7 carrier board).
> This Carrier board only utilizes the PCIe link, hence no
> special device / driver support is provided by this dtsi file.
> Finally, add dts file for the combined carrier and CPU module.
>
> v8:
>    1) swap enum for const in dt bindings
>
> v7:
>    1) update MAINTAINERS file to contain all marvell arm64
>       dts file in one line, covering all files
>    2) Add Documentation to carrier dtsi and combined carrier
>       and CPU module dts, explaining the configuration and
>       modes of operations of the carrier and the combined
>       system.
>
> v6:
>    1) Add cn9130 COM Express system
>
>    2) Drop with from compatibility name of COM Express system
>
>    3) Fix indentation issues of dt bindings
>
> v5:
>
>    1) List only carrier compatibility on carrier dtsi
>
>    2) Fix dt_bindings_check warnings using latest yamllint/dtschema
>
>    3) Fix subject lines to remove unnecessary wordings.
>
>    4) Remove dt bindings for standalone CPU modules
>
>    5) Move CN913x dt bindings to A7K dt bindings file
>
>    6) Fix dtbs_check warnings for dtb and bindings,
>       using latest yamllint/dtschema.
>
>    7) Move memory definition to main dts file, as memory
>       is socket based.
>
> v4:
>    1) reorder patches - dt bindings before dts/dtsi files
>
>    2) correct description in dt bindings
>
>    3) separate dt bindings for CPU module, carrier and combination
>
>    4) make carrier board dts into dtsi, make dts for combination of
>       carrier and CPU module
>
>    5) correct compatibility strings and file names to use dashes
>       instead of underscores
>
> v3:
>    1) Remove acronym which creates warnings for checkpatch.pl
>
>    2) Correct compatibility string for ac5x rd board
>
>    3) Add above compatibility string to dt bindings
>
>    4) update MAINTAINERS file with ac5 series dts files
>
>    5) remove memory property from carrier dts
>
>    6) add comment explaining that OOB RGMII ethernet port
>       connector and PHY are both on CPU module
>
> v2:
>    1) add compatibility string for the board
>
>    2) remove unneeded hard-coded PHY LED blinking mode initialization
>
>    3) Split the CPU portion of the carrier board to
>       dtsi files, and define a dts file for the AC5X RD
>       carrier board.
>
> Elad Nachman (3):
>   MAINTAINERS: add ac5 to list of maintained Marvell dts files
>   dt-bindings: arm64: add Marvell COM Express boards
>   arm64: dts: cn913x: add device trees for COM Express boards

Applied on mvebu/dt64

Thanks,

Gregory

>
>  .../bindings/arm/marvell/armada-7k-8k.yaml    |  22 ++++
>  MAINTAINERS                                   |   3 +-
>  arch/arm64/boot/dts/marvell/Makefile          |   1 +
>  .../dts/marvell/ac5x-rd-carrier-cn9131.dts    |  44 +++++++
>  .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  34 ++++++
>  .../dts/marvell/cn9130-db-comexpress.dtsi     |  96 ++++++++++++++++
>  .../dts/marvell/cn9131-db-comexpress.dtsi     | 108 ++++++++++++++++++
>  7 files changed, 306 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
>  create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
>  create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi
>
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

