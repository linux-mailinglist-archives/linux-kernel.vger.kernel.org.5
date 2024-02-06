Return-Path: <linux-kernel+bounces-54487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 913C884AFDA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D898286ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6312B16F;
	Tue,  6 Feb 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="obkAvMEo"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE0712B143;
	Tue,  6 Feb 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207824; cv=none; b=XPDC+gq/fBYWFl8pgfXPPeuZYsggPInRsVbdcoqPnzN7UQyXg2mM3HfhJ4+73a5RfO8ZBIpYXLxOl7eP0PcBwuTYBM41eSSTrsxt4ahB+Dsw0vUVwnTegHfy1V5EhzDQSF7XhRAE5pliUZynztLX60EGMdwIuUwnlo0uUzj1sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207824; c=relaxed/simple;
	bh=i9hFvR6km0e5CxyY1KVcH+Lwlwx7jkTvADHXxQ7dquc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNZwviW23T6DqKUib414foulvoGP/reYkLJXh3vWWkbkn0jB/7ghwonOQrCqPyhceyTejf1wX0ilgkePlpKa8kjTbyhFH3bcArVueZj4NxyViQ5ijy7y8MM9PfmkXOwGGJvQ7OADE9wrN8s5Lks/dnMymZdgkrx6uHFQCoOJHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=obkAvMEo; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Pbdyx4n22pbANzKj3/aWdph+CDcRpO65zpnqqMmIz+M=;
	b=obkAvMEo1ZJnFmfS21FuDz0YhsIMqzN+R80bBA5ogCbo1oh9i/UoFSE89CYmZh
	6oGLy4bdrlBSxcR75W13ov+u6Tm92QrMmc/Xa8na2gixz4qCHwaD+DvlglhkWPO4
	nL7M7DYUt3EIwUfGlNIUiiMAmmQt3Y5mTBNxQyVDFeCYY=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrAD334nO6cFliiUAAw--.43171S3;
	Tue, 06 Feb 2024 16:11:59 +0800 (CST)
Date: Tue, 6 Feb 2024 16:11:58 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: defconfig: enable the vf610 gpio driver
Message-ID: <ZcHpzuagGIhz/mmM@dragon>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-5-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124205900.14791-5-martin@kaiser.cx>
X-CM-TRANSID:C1UQrAD334nO6cFliiUAAw--.43171S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcR6zUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBB8ZV6NngPDaAAAs0

On Wed, Jan 24, 2024 at 09:59:00PM +0100, Martin Kaiser wrote:
> The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
> Enable it in arm64 defconfig.
> 
> (vf610 gpio used to be enabled by default for all i.MX chips. This was
> changed recently as most i.MX chips don't need this driver.)
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Applied, thanks!


