Return-Path: <linux-kernel+bounces-34156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9B837497
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4363128B0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60047F6F;
	Mon, 22 Jan 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="jDGuOYO5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCrcjoNX"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258BB47F52
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956714; cv=none; b=MAzWSp7j/lsQ9t4rmv5WtcZbyhXMxXNDP0hVRdpfFQ9rzb9q+9lpQi0oqp2lI7Ye2XG3XdpjBWzCweU8JHwpkf+wYEvypEHImq5l6OjvLJX8BgeOa0zzEUv3lr16Yh416ToQoxIFIBIH5ryrzRVPotViASTiTlLz3LwK0NykxuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956714; c=relaxed/simple;
	bh=SNkS2X6q9fGaWYeSsqPp4rlEidj+kB1FWNA/tIDRTo0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=no3dd5U8mH+gc4i5yq+zQQbvOHft9nPDApfMm1WjRf3lVdGuwYPavaAYnX1nbqxbtB2qnwU78B72QTb6Ua1o8YiXAlF9xIAQoNQp4JZsGj0ptzWqVR/RuPqjNjv3ymfJ1vADabFeNpDI74QDIm9/h4Gf1P0TeOqjZoDWNIDDETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=jDGuOYO5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCrcjoNX; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 4C0C53200A4B;
	Mon, 22 Jan 2024 15:51:51 -0500 (EST)
Received: from imap53 ([10.202.2.103])
  by compute1.internal (MEProxy); Mon, 22 Jan 2024 15:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705956710; x=1706043110; bh=DHf6F3i9HM
	03yZ5OjQEw3X+C9dEFZ+MMU1+PGpBxv8U=; b=jDGuOYO5vY+qkuxrXvqMkGWUf9
	VAobHuZZqSTuWTQSVVPCSnwlw0CPpWlE+otp4dLH9MZ37Eoz6I9KmmpL5+KTyTuu
	369vkZuLfj/HW1NPRr41yLB5a+SuTvr7O11S4YxpWsnf0HCkWtlpo6xeDzDmQHkU
	4O5eJm8J1KDhvVNYpPx1yk8lhtf6QxXEnqOYGXWibtSfJqto/zisPgFTG66a6Ajh
	Am469ijD1yXYdebthJKhgU/AIEZsjpL3+Vx66sayD85UMejOpxK5ItgK/wzjSM5P
	2EWNZMbl3qPN37AqlNtOLwkoMyAYtAvNG4K6GANWoXP4hnSKMruGc62y70oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705956710; x=1706043110; bh=DHf6F3i9HM03yZ5OjQEw3X+C9dEF
	Z+MMU1+PGpBxv8U=; b=CCrcjoNXZ0wuhMh0BD1AIco/t64rGJ4WftHn7YsM8W59
	9mepzD9oKiYPMGMbM2FRmjNvjPjf6Ed2XaksBEtspcs5ZdchwIJPX8idnuRSjmWw
	5AYq0TYV9cl+/a6XQN1CepiZiXFd47kYKpm9GWh0SvoOHsnEGGOkN1VEQMxYOAyK
	Jt/5BenNNvOY/dK8UmJ59yX3D+th0auGpoUlbkBjbirL1xRn9s/mtqSZKpttx+RL
	syFRrGJfXhPnZcEmAATQNtoGjYdIZIiR8rv38Irld2V4CfaQ7VOK7N8vckAIDJfm
	iRCuOep+ZYpqV8ZbtGYiCYrtPzo+r4Geg1KxR/Dgrw==
X-ME-Sender: <xms:ZtWuZdCw6UM81oJ5BrBILcdTpjklPYd_1Pht8QcLUIuo2XFi8xJYzA>
    <xme:ZtWuZbhEEYdvairXXuV_BS5UAELqTh3Y_XCcxsy68lFu2mkmODWO8tBFBxB4uRmoq
    fNzdrKlF10WogpXoQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfl
    rghnnhgvucfirhhunhgruhdfuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtth
    gvrhhnpeegteelvdfghedugefffeejgfehffdtffehgefhieelhfehffetteduteehieev
    feenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurdhnvght
X-ME-Proxy: <xmx:ZtWuZYnqF-e_RbB7zXp17YlPX4nzVCiicWBxrlf4-lES6m0JCWa9hA>
    <xmx:ZtWuZXxeFSvMqR9RewhubCofd57fqYzQYOKVYxVKc3lBaqWVFlIxSQ>
    <xmx:ZtWuZSRnkGkp0DWZc5JtliW-bWcX4oi7gECJQ-fvyBmL4b62Ah2LUQ>
    <xmx:ZtWuZXIKL7uBZ5ieUn1fW_plWZcn98W-X_20Vzv5l0HuD9UdkqqvCw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3FD0D364006B; Mon, 22 Jan 2024 15:51:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7c0ed806-b7c3-480c-820a-fb9b311d03f5@app.fastmail.com>
In-Reply-To: <20240122161233.125192-1-arnd@kernel.org>
References: <20240122161233.125192-1-arnd@kernel.org>
Date: Mon, 22 Jan 2024 21:51:29 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Arnd Bergmann" <arnd@kernel.org>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc: "Arnd Bergmann" <arnd@arndb.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "David Airlie" <airlied@gmail.com>, "Daniel Vetter" <daniel@ffwll.ch>,
 =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
 "Hector Martin" <marcan@marcan.st>, "Sven Peter" <sven@svenpeter.dev>,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: apple: use strscpy() in place of strlcpy()
Content-Type: text/plain

Hej,

On Mon, Jan 22, 2024, at 17:11, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Since commit d26270061ae6 ("string: Remove strlcpy()"), the strlcpy()
> function causes a build failure.
>
> Since the return value is ignored, changing it to the strscpy()
> causes no change in behavior but fixes the build failure.
>
> Fixes: f237c83e4302 ("drm: apple: DCP AFK/EPIC support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The apple drm driver is not in mainline linux yet, this patch
> is against https://github.com/AsahiLinux/linux/tree/bits/200-dcp
> ---
>  drivers/gpu/drm/apple/afk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/apple/afk.c b/drivers/gpu/drm/apple/afk.c
> index 99d579d5ce47..9fbcd18878e8 100644
> --- a/drivers/gpu/drm/apple/afk.c
> +++ b/drivers/gpu/drm/apple/afk.c
> @@ -236,7 +236,7 @@ static void afk_recv_handle_init(struct 
> apple_dcp_afkep *ep, u32 channel,
>  		return;
>  	}
> 
> -	strlcpy(name, payload, sizeof(name));
> +	strscpy(name, payload, sizeof(name));
> 
>  	/*
>  	 * in DCP firmware 13.2 DCP reports interface-name as name which starts

thanks, patch included in my dev branch and will be in the next pull request I'll send to Hector.

best regards,
Janne

