Return-Path: <linux-kernel+bounces-124458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9893891853
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BD41C21DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E785629;
	Fri, 29 Mar 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UT/XNlm2"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8FCF9E9;
	Fri, 29 Mar 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714144; cv=none; b=OjuTrrtrWPJFR3Pfc0r/szsCCl6rHT+iR4aT6FkWl7pMAQHiSpN/idRBYbt393vr9MKBmguMyMVo8Srms88zwJjayMoU5bK79eTosVhxbqD1yA4h4xW6TijssZswEemFPMMZmVusi1d62L7eMITIS8kkf9dpCaFF/MkVDLSf+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714144; c=relaxed/simple;
	bh=UZwESVgHsFJkSnGKj65uq0mbPO02f9sTTtJZXLlOAJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ixvfo2wolAH4iGboVomeU/N7jaNmLKXOxg3Osrp9ElzjVBp1aXhU60PTxqfDPd/KcWCpPUiF9BKNz724RBN/LS5dXHmQ30N2eskUfmrFH87qwco5oNkC5oyUf3as6Ncdzon+e245DbBl9it43jZnljXbKLBNw1q5FHKUfS1lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UT/XNlm2; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AcAWTmxTEyvUwfrV0N//gjIno0L4abvjebtF0L/ckPU=;
	b=UT/XNlm22MEBOfT2KgVEQrz2IwdIgxpzTLSZ4E9e/cOlul5OiU9HKJsla3xz7q
	8N7v2hl4Mb3lc2h4rxL8ByT/QWdqTKd9HA9y8HrL3GirPG08mYR8p72kGuSLdcln
	6ftSOr2Q27b2tGtY1myA+g/L9OpRn4kHdfkV/Yx/DAZpA=
Received: from dragon (unknown [183.213.196.225])
	by smtp1 (Coremail) with SMTP id ClUQrAD3v3YgrwZm2uJjAQ--.46807S3;
	Fri, 29 Mar 2024 20:08:03 +0800 (CST)
Date: Fri, 29 Mar 2024 20:08:00 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Parthiban Nallathambi <parthiban@linumiz.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add Seeed studio NPi based
 boards
Message-ID: <ZgavIBrSIBgtoRsJ@dragon>
References: <20240229082337.3090778-1-parthiban@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229082337.3090778-1-parthiban@linumiz.com>
X-CM-TRANSID:ClUQrAD3v3YgrwZm2uJjAQ--.46807S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxuWlDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDQOwZVszXXMAKQAAs0

On Thu, Feb 29, 2024 at 01:53:36PM +0530, Parthiban Nallathambi wrote:
> NPi i.MX6ULL eMMC/NAND is Seed Studios SoM using i.MX6ULL.
> Development baords can be either based on NAND or eMMC
> SoM.
> 
> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>

Applied both, thanks!


