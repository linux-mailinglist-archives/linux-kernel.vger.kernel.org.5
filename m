Return-Path: <linux-kernel+bounces-152728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325348AC387
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B9EB20BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 04:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC485168B1;
	Mon, 22 Apr 2024 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="P6l7v6tW"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69297F9EB;
	Mon, 22 Apr 2024 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761839; cv=none; b=oAeWfI5GpwBfv6C3I56z2IJUtjswxSB4gc+PpaGKn+kyo1133ZvQkh84+m3dncIplLNtylvVkFp9jvcOGuWJnJ2rbkBN/KJKieEo2/jIDvwSucr7buaPnBWPNDSfu9v036lGy6Y1iffgXMYDv78ZI1yvbpXn9YmN8+7xx6/jqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761839; c=relaxed/simple;
	bh=GXqy0k4swdz+w1lUKUuK4O5KUzhOe4lHRPY5LIO/sBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNYlqMl0jVJZTftxFEgxihYK+JXYjARBrGu/kFbd/ffytMMsLBPBCmXXb9GCBq3cjIQxZcicyO/sbK1H5WZOYc57N0fvhu9wBNcodUWcP+yDb+reuO04EQc1TJL+c19oTDxcDC6BNjq51768w+mReO47vzONkufqJVfQouyt8G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=P6l7v6tW; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=q2TkRudaNP76VmwTokbEjaOWssB40dPyG47JDUjw+J0=;
	b=P6l7v6tWzJRy9Q9b51Wn6CqMWXuFcACLtwxuIsNv/DoDhKW8uLbmrvK2nrdZSD
	vRcCvZG8UJdMU21iV7C7hba063PogWl+zy3sir+jLsSNNg1wRjHtvCFDR22KziGy
	Paq6VXL5q5IO/HnSOCxVIOfI6lylwRN6MgC2Z/wjRjw3k=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADHTw8V7iVmRW4sAw--.29635S3;
	Mon, 22 Apr 2024 12:56:54 +0800 (CST)
Date: Mon, 22 Apr 2024 12:56:53 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	peng.fan@nxp.com, ping.bai@nxp.com, haibo.chen@nxp.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Varun Sethi <v.sethi@nxp.com>
Subject: Re: [PATCH v4] arm64: dts: imx8ulp: add caam jr
Message-ID: <ZiXuFVlB6uzji8Au@dragon>
References: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409092040.3870497-1-pankaj.gupta@nxp.com>
X-CM-TRANSID:ClUQrADHTw8V7iVmRW4sAw--.29635S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV0PSUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBbIZV6NnuI2vQAAsH

On Tue, Apr 09, 2024 at 02:50:40PM +0530, Pankaj Gupta wrote:
> Add crypto node in device tree for:
> - CAAM job-ring
> 
> Signed-off-by: Varun Sethi <v.sethi@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>

Applied, thanks!


