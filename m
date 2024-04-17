Return-Path: <linux-kernel+bounces-149040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0C78A8AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9051C23019
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AA917333B;
	Wed, 17 Apr 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qs7s/U33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AA4146D7F;
	Wed, 17 Apr 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377580; cv=none; b=TjZ4JVNt3fjM/J7LS+U+beSTxwlYKDsywkGZZro9wt+qJXFA8zgvryv06EbY/lHpuVuWAfejzNiHkT+Pe53+NpuyFkEx18+OxAeorqIHIGoiwnOBFiLWwq88nS1U4Kiv9dl2kralwXMKLpi+1yOS1+lGBITRMNfSj+liRKy+sXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377580; c=relaxed/simple;
	bh=+QqZIxQ8UlhnEmUdS1HJUIQc1KETk2//TWOKmBcq1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=me2Udq1ePNbHy2X38qgOdLqL7VkdvIghyO9qKrlVTcna7M6EEU2PyW7BfDN0hW7jHwjq0fHvKqtgLI2OXoBgy7VRFz+7J+yNrjxmOhRA9nwM4HFsidaarcg8ctrYedultiIzQK76mDiryPG9nsiQdGRGAZYXzIyLVTNaFESLeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qs7s/U33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64067C072AA;
	Wed, 17 Apr 2024 18:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713377579;
	bh=+QqZIxQ8UlhnEmUdS1HJUIQc1KETk2//TWOKmBcq1yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qs7s/U33jKkoO6fTSIvWPF98FJeWk9FRSo6ex2nV7//YcFOfYLle3tz42e3PyHo1K
	 73MkXeI4MUUnqClLeVpdd3+PSkjp15ZdoetD6qpr3MJDoYlwpN+56vi8B30gB7xOSY
	 AeezwTtpZ7LNNa+uI8RGOHS1IgrPuBlQMDO8xsMSKFczvJ0NLdTTXRycx1QUxWZWY7
	 Vd1Ep+JZ7mOPAZZlorwnJd3eKifgKbVJ0lzMibz1s1k2zBeJDjQ4VZEfetj3X8zM4Q
	 4Eljj+C90Eu/ySegZOnD9uAWewMrVlDP8UtzYgerKppJOoaK8VWz5gsq27XoNUFkif
	 Dv+9crxRcKLSQ==
Date: Wed, 17 Apr 2024 13:12:57 -0500
From: Rob Herring <robh@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: oxffffaa@gmail.com, Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Conor Dooley <conor+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>, linux-mtd@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>, kernel@sberdevices.ru,
	linux-amlogic@lists.infradead.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <171337756287.2947093.12060380819740476831.robh@kernel.org>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
 <20240416085101.740458-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416085101.740458-2-avkrasnov@salutedevices.com>


On Tue, 16 Apr 2024 11:51:00 +0300, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


