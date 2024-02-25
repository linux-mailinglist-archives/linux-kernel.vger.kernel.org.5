Return-Path: <linux-kernel+bounces-80070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BAC862A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113831C20AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791214292;
	Sun, 25 Feb 2024 13:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mNflBUWR"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EF14280
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708866816; cv=none; b=IYBqY5et34KiMAPfK5hIP00aLF38gkYIaNCXsLqcZflmCkxn11DQ/j5hVxqPVuL0gTW4c+3ksP1EQvwDV5lsELtxSnkJwjsYzXstUEIgmyjQ8BKOwknbIRnmfQ85tmflWTjTj30spKVoB75u5cUwUjzmhwexdo4MqSe4P0S9htM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708866816; c=relaxed/simple;
	bh=I4YgrIlgRHNkN4q75EL7uNvwYzEUuJ+SQMb1p51bIxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI/LOSM18iUnQUX73G7efISgQKmWwjxcFlTFd0gvolti7g6k2fCdNraCE0doTMB13NoNkjSONtuFZsP2wXQzWf98+FpZ04Yk8+7WNL9lGR7cdSLU/UE9fcJGA+B6b5VJrCu4S+Gua1RXxLARu4Ea+56UzEpqHd2NY+YOdhEbLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mNflBUWR; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=UMCpJX8qvyRn61fZpBD4XHJdLjxru621yHsZAv5md9M=;
	b=mNflBUWRv7D6ZJ9YCTgTzfPXpSBw750X4PrFR0dKBK71bkczd7SqO5yD4jEHcv
	EarDqvICjQr07Wrpdk/lv4xbeQrjvk/mosLPTTRylrwdrHN+V2VNUr4zfRr734RS
	9DL2B+dUGNUsrs6m/YTt4ov6bY7NdoxToYgd8ZjtuZbKo=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrABXfwfmPNtlAk1WBA--.11291S3;
	Sun, 25 Feb 2024 21:13:11 +0800 (CST)
Date: Sun, 25 Feb 2024 21:13:10 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, f.fainelli@gmail.com,
	kuba@kernel.org, abel.vesa@linaro.org, haibo.chen@nxp.com,
	peng.fan@nxp.com, shengjiu.wang@nxp.com, frank.li@nxp.com,
	laurentiu.palcu@nxp.com, mirela.rabulea@nxp.com,
	linux-kernel@vger.kernel.org, daniel.baluta@nxp.com,
	aisheng.dong@nxp.com, linux-imx@nxp.com, a.fatoum@pengutronix.de
Subject: Re: [PATCH v2] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Message-ID: <Zds85hOvo7cuDxtd@dragon>
References: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222130641.1213359-1-daniel.baluta@oss.nxp.com>
X-CM-TRANSID:C1UQrABXfwfmPNtlAk1WBA--.11291S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUSJ3vUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQqPZVsVCUNxygAAsa

On Thu, Feb 22, 2024 at 03:06:41PM +0200, Daniel Baluta (OSS) wrote:
> From: Daniel Baluta <daniel.baluta@nxp.com>
> 
> So far we used an internal linux-imx@nxp.com email address to
> gather all patches related to NXP i.MX development.
> 
> Let's switch to an open mailing list that provides ability
> for people from the community to subscribe and also have
> a proper archive.
> 
> List interface at: https://lists.linux.dev.
> Archive is at: https://lore.kernel.org/imx/
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Applied, thanks!


