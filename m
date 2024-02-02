Return-Path: <linux-kernel+bounces-50242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C89847635
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A861C22017
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60E14AD07;
	Fri,  2 Feb 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0bkQFJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7968C14A4F4;
	Fri,  2 Feb 2024 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895313; cv=none; b=WuFV6g/pEg5fMjHet0lCp4LcAk/hXHhRQpS6zQe5HyeM6R77QgOJzZqKh/NM1Aa89ef4gL40EenFlPDr3KOHkKMv8hyyfsWGJFF//7X3DlZ+K0Zb/NsdCsqRvLKD6JmU0CmICT0R2FfEVu1ofkEFolcGSpsOsjvb9gmWOp1kQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895313; c=relaxed/simple;
	bh=1rJOo7x1whnWGQiUhalkGcWuWsaVMBadocMFkpj6LIw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=NMMnx0o264jZckmRXM8ENqqZcPn+eWvEqpUwR2/HsS+cws6PS+9tff/1YB8EeKT5j0s7rXv0cpcfcpVrEQ5A3e9bRk16q64RndRiyyqH2UdzlPDqXLHXLKOpbyh0iBognCPqDrsCediE9Oha24qXSElvqH+emtD1hlJ08WxDGIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0bkQFJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB460C433F1;
	Fri,  2 Feb 2024 17:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706895313;
	bh=1rJOo7x1whnWGQiUhalkGcWuWsaVMBadocMFkpj6LIw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=E0bkQFJc7H1VouFYrW/NSOhjffdU/nlxzg4FG7QCYBcDOLwcNWDMsSX+43eOMrARc
	 mAlCdpDn50IfaZUGElRj1YoNLzRueT024YE0Kd97swAJ/rLFhrcouYeQJmnvGIKMCF
	 nnSkuXULMSsqOs40SxPwSOBehLb9AMPULFzsTfWsWeoMTVPwGxYPWhB1siKDEgZEkD
	 y5jG+GCDhaGabTVOprwY4v8pt8FKbiM9ySwUM2ES2olIIBXvfPw/SxJqYwWHFdplN9
	 V04PI2gA30ncoeVgbgW0Z5i2IcNdsZuVnJnqyYE0RZ+gPecqsxEV13K4TmhbPig4Qd
	 JTeWMxtNQ4UAw==
Date: Fri, 02 Feb 2024 11:35:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>, 
 devicetree@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, Rob Herring <robh+dt@kernel.org>, 
 linux-rtc@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
References: <20240202-add-am64-som-v4-0-5f8b12af5e71@solid-run.com>
 <20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com>
Message-Id: <170689531068.307758.9231002727463263124.robh@kernel.org>
Subject: Re: [PATCH v4 2/5] dt-bindings: rtc: abx80x: convert to yaml


On Fri, 02 Feb 2024 17:10:49 +0100, Josua Mayer wrote:
> Convert the abracon abx80x rtc text bindings to dt-schema format.
> 
> In addition to the text description reference generic interrupts
> properties and add an example.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
>  .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 74 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 31 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dts:28.13-26: Warning (reg_format): /example-0/rtc@69:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/rtc/abracon,abx80x.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240202-add-am64-som-v4-2-5f8b12af5e71@solid-run.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


