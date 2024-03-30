Return-Path: <linux-kernel+bounces-125757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8328F892BBB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0041F219C6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A51383A5;
	Sat, 30 Mar 2024 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="b0G1rSQ/"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010A1EA8F;
	Sat, 30 Mar 2024 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711811337; cv=none; b=TctqFxusdrjbLgarEJ91EfhnaciNUbXYPinfKs2yIqCHdXEB+XW+3PtkbVNfebqOlPudTORTNcfvPetyuo51tgPC3C7Efn+jhEYq8Ot1tp4XPZnEX1/xv//SOSsTFQr7iHoK29Bbs1HP9yHiyQw1GE23PzVmwTW1+JjqjrCE8ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711811337; c=relaxed/simple;
	bh=8K9T5cXijh5PAemB3gyEgmtxsfFrCAsbRFNmApRPeT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISkDowOAsTeI+WLliST9sGVZpVKW91amklCIKDhG9ssR8JDOvqFPKFkxWI/cc6HOvUeMZWtTc0l3oM1ii81x7xAq70UEBHtugCcfg+VkqPnE8pJ5dKRs5Jyzw31nKpdNAtrHFI90dHbO361fJ36KYciXZ5Gr6YSZDsBHSp/PuPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=b0G1rSQ/; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=7GmgPeUNLgbxwHZkwFXlYbsDYtn0gAkQOUe01m+BEAc=;
	b=b0G1rSQ/24Tk/8kakI25k8fADlq5vHqS8v6qmUeXZ9qaq9h8WutPLbprpO9G7i
	a4huoR0hDnIly9lRQICQu9HD64oA4BoaeRn1GtOg08xCCptNiF1+aDILxN8qUbqv
	GTG+lorL266ib712/7Ct0uRtTPCnu8g0L6XnVm6iQj41Y=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrAD3_0XIKghmcGh0AQ--.22525S3;
	Sat, 30 Mar 2024 23:07:53 +0800 (CST)
Date: Sat, 30 Mar 2024 23:07:52 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: fsl-lx2162a-som: add description for rtc
Message-ID: <ZggqyDuUAESc24Q6@dragon>
References: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-lx2162-rtc-v1-0-1f4cd431b1cf@solid-run.com>
X-CM-TRANSID:ClUQrAD3_0XIKghmcGh0AQ--.22525S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUx66zUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDgmxZVszYc2-OwAAsT

On Tue, Mar 12, 2024 at 08:56:53PM +0100, Josua Mayer wrote:
> Josua Mayer (2):
>       arm64: dts: fsl-lx2162a-som: add description for rtc
>       arm64: dts: fsl-lx2162a-clearfog: add alias for i2c bus iic6

Applied both, thanks!


