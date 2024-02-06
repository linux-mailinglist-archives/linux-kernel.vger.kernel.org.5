Return-Path: <linux-kernel+bounces-54486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648E84AFD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1524AB23943
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B1C12B149;
	Tue,  6 Feb 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="JDKYdE8Z"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CF912A179;
	Tue,  6 Feb 2024 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207822; cv=none; b=meaioaZLKjjrjtdVlIZP/8lR6eZsTINcXQ87C3NNUfFDgrwJR8gcVjAscExRU+wvMCJwoAo8Jlq9MxVCtvSdMtLB8vJzlsEvS6avE6l3rPRRjBfEx8YowEuTFw4UJU8OEMPrghLjaSWD3WCCHlifftWV8hYUsiFIe7KWz4PgzZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207822; c=relaxed/simple;
	bh=zpYE8+x9stgG1+lU/ZYoU7oTimGeEsPVSAaV95caQ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRC8zFNkQntHevyYd3FioR5iob8bDj8Wv2pURuPAgNUdBAlXQz0osgVn57IYpJyUhy91/l3elet36gg2vGglAHqMzPHTEEgEGkD++Qx0Gsm9BMO9qWzjAxMz0qqTW5QMQyicSpEzyKcrEzr5HKYBUBFtI/+EhhDaHas8lZXxNkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=JDKYdE8Z; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=qUrsdUuxZU1UTyCYFyAMr+JUj6smaNTsmYy71PgQWEo=;
	b=JDKYdE8Z/XcQ4G5lgOwcAEc7YgBvX/DV/I3AUHRtFUFaPMrU7V++hd8S30bq4C
	ouEq2BpX+Fja/r+tHOKE68TCmanVc/Ry5KkaHASC+VyXXavE7pwbAUxHEhjb00y/
	Gi4zqtquYKQDxou+d2KliE56pcTHgezHzwdW1SQGopKyc=
Received: from dragon (unknown [183.213.196.254])
	by smtp1 (Coremail) with SMTP id ClUQrADHz9K06cFlt238Ag--.15896S3;
	Tue, 06 Feb 2024 16:11:33 +0800 (CST)
Date: Tue, 6 Feb 2024 16:11:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] ARM: imx_v6_v7_defconfig: enable the vf610 gpio
 driver
Message-ID: <ZcHptCbteajfAWL7@dragon>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-4-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124205900.14791-4-martin@kaiser.cx>
X-CM-TRANSID:ClUQrADHz9K06cFlt238Ag--.15896S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwl1vDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwZ8ZVnxccG7egABsI

On Wed, Jan 24, 2024 at 09:58:59PM +0100, Martin Kaiser wrote:
> The vf610 gpio driver is used in i.MX7ULP chips (Cortex A7, ARMv7-A
> architecture). Enable it in imx_v6_v7_defconfig.
> 
> (vf610 gpio used to be enabled by default for all i.MX chips. This was
> changed recently as most i.MX chips don't need this driver.)
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks!


