Return-Path: <linux-kernel+bounces-158082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF118B1B37
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7FAB217E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34835A7AB;
	Thu, 25 Apr 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="YoGAAaHZ"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B541757;
	Thu, 25 Apr 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027515; cv=none; b=MJ1uyT4MlE7ffWgnF8/KwIoJGil3I8i1Ct7SQ6oduSqGQDOnGd0v/JVjmFPUGOUneiP8EazVeionSxzWk6L8enXrvzbFCjOVJ6XNwIwjebObuiojyHwLSvzaSP442mohApYtXVDeA5UYwUcv9yM+M173k5p91XJTimaey1xR0QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027515; c=relaxed/simple;
	bh=fXaXB/7WilQeiVeGRljODJClcYMb/jVpprpbj15TX3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB6XdR88ziNZVpAKuzlksliNH7u9GL5EflN5idhVqGwuVtt8Wx88YgKMf0GSIDZOVrB6voG9Xvg1bsE3DHl8EWVvDb17d7vrJXSyYGwSwaTaBocqZ+HSy4/DGzHwZUF0ELRIgKEuqNO8V5BGfErFS8j5POEHJ6rPRsIE66hMojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=YoGAAaHZ; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/0pD2LgYGt6bFsW0PFLDHfzM62bQBRByvMP3Eq5XtXQ=;
	b=YoGAAaHZjr/D4GeyxXrsDkLmLguzwqgG06ThUmZmx6Blo04GEyRPEdBa85ympK
	89KDavY2wSRqpoNHI+A9/CB6gujuIit4gv3lvhyUxdAfkZlOCxGvZ54yfcMeUcm6
	iiTqKnHtL403aIzEyPMP/gez3tfKFsup6xQeVyORbbzPU=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrAD331bm+ylm031sAw--.3307S3;
	Thu, 25 Apr 2024 14:44:55 +0800 (CST)
Date: Thu, 25 Apr 2024 14:44:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: freescale: LS1028a PCI fixes
Message-ID: <Zin75vhL27mZ+6le@dragon>
References: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418-dt-ls1028a-pci-fixes-v1-0-95f17405e481@kernel.org>
X-CM-TRANSID:ClUQrAD331bm+ylm031sAw--.3307S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UKryxKryxXw13XFWfGrg_yoW8Gw1kpF
	WYkasxWrsaqFn3Gw18K3W8tF9xtrs5AF98tF18Kws7K3s2v3Wjqrsrtay5Cry5X3yUWryU
	Xr1xtFy5Kas8JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFksgUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRjLZVsVCfraiAABsd

On Thu, Apr 18, 2024 at 03:09:24PM -0500, Rob Herring (Arm) wrote:
> This short series addresses a couple of schema warnings with the 
> embedded PCI devices in the LS1028a:
> 
> pcie@1f0000000: rcec@1f,0:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
> pcie@1f0000000: rcec@1f,0:interrupts:0: [0, 94, 4] is too long
> pcie@1f0000000: mdio@0,3:compatible: ['fsl,enetc-mdio'] does not contain items matching the given schema
> pcie@1f0000000: ethernet@0,6:compatible: ['fsl,enetc'] does not contain items matching the given schema
> pcie@1f0000000: ethernet@0,4:compatible: ['fsl,enetc-ptp'] does not contain items matching the given schema
> pcie@1f0000000: ethernet@0,2:compatible: ['fsl,enetc'] does not contain items matching the given schema
> pcie@1f0000000: ethernet@0,1:compatible: ['fsl,enetc'] does not contain items matching the given schema
> pcie@1f0000000: ethernet@0,0:compatible: ['fsl,enetc'] does not contain items matching the given schema
> pcie@1f0000000: ethernet-switch@0,5:interrupts:0:0: 0 is not one of [1, 2, 3, 4]
> pcie@1f0000000: ethernet-switch@0,5:interrupts:0: [0, 95, 4] is too long
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Rob Herring (Arm) (2):
>       arm64: dts: freescale: ls1028a: Fix embedded PCI interrupt mapping
>       arm64: dts: freescale: ls1028a: Add standard PCI device compatible strings to ENETC

Applied both, thanks!


