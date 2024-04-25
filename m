Return-Path: <linux-kernel+bounces-158168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662208B1C78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282EA284FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E96EB76;
	Thu, 25 Apr 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="S6ywIAmw"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6C6D1A7;
	Thu, 25 Apr 2024 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032475; cv=none; b=bylnVd9ZBew+2rIeduOJeIm2OThhyaldBC4TVtZL2HcGNpH0ON7cM0Vbrrgaahip+zBFsMZ7855Gc+P/5cwyDMMFwt29UqGttqKyKnJPcc+Aj8nXQheWsnWeycD8a60wOVkmrEN2dS+OXu21hzDkuzr3L6aMT7eVhSiNY/Xwp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032475; c=relaxed/simple;
	bh=wp5kaSMWtrLAyYi/sZF44DEmAm3ihsfy0gFH/r+YS2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMIx/Y6lsXewHxv0MRLA/kH7ClPZSKb5FOT3TwvRGY8b6ZzMVai4dxFufMyOdCghRfPxsU5W/qYMJlfHz3uPtXEpabNCRHQlhNv6NNX++LusI9LarFAcC8Pyj3hHQYCH7AdqqsW/ACu4Mi3fAPrks+oJ9Ue6WiOyFC3nQG+YzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=S6ywIAmw; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=KdjNt2TnhxKbifbJKzzfpVaBrLHcmT2EvlkMxfTkoMw=;
	b=S6ywIAmw3HZawDpkVl/GzQO2vAEdU9CSx844YtgQw5hUx5GMtLJIDFM5DqTH7s
	93nfd1vNZJYFHAw8Hzq3uedpTICdQtfe8CYemPUz27jgQNjeYg+amY0u6vSb7co0
	gkfWEX9UZpNJ9rILUdG1WaFYJE4XWu+ErWhv17NQCGeKA=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrAD3H4w6DypmIPV0BA--.2450S3;
	Thu, 25 Apr 2024 16:07:23 +0800 (CST)
Date: Thu, 25 Apr 2024 16:07:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] arm64: dts: imx8qm-mek: add lsio mu5 and mu6
Message-ID: <ZioPOeq2VmaWf329@dragon>
References: <20240422-dts_8qm_audio-v3-0-680cee731ced@nxp.com>
 <20240422-dts_8qm_audio-v3-8-680cee731ced@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422-dts_8qm_audio-v3-8-680cee731ced@nxp.com>
X-CM-TRANSID:C1UQrAD3H4w6DypmIPV0BA--.2450S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW8uw45Jr48tryUXr4ruFg_yoW3CFg_Xw
	4fuw1UtFZ3AFnFga45X3yxX3srK3yUCrs3Jw1UXrn7GayfX3ZFyFW8KayfKrsxCFWIkrZr
	ArsxAF1DG3sIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8E1v3UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGB3LZV6Nnu0WQgAAsf

On Mon, Apr 22, 2024 at 03:50:10PM -0400, Frank Li wrote:
> Add lsio mu5 and mu6.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> index 62ea3efd1ee2c..cef395e919395 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
> @@ -259,6 +259,14 @@ &sai7 {
>  	status = "okay";
>  };
>  
> +&lsio_mu5 {
> +	status = "okay";
> +};
> +
> +&lsio_mu6 {
> +	status = "okay";
> +};
> +
>  &cm41_i2c {

Can we try to get labeled nodes sort alphabetically?

Shawn

>  	#address-cells = <1>;
>  	#size-cells = <0>;
> 
> -- 
> 2.34.1
> 


