Return-Path: <linux-kernel+bounces-100655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0327F879B57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E0B23CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40FE139585;
	Tue, 12 Mar 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LQf6rABS"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA471139571
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268160; cv=none; b=nvDeFCUWCdkmi36eW69RcJRSYHjxGFzDDijv36520wK2MG4pAZqLUnRA11lwlhuJWQ4aWsQi1m2dbh08AoKYgM84LqfnTz1wnvgCSdSbD54PyPPN1UhAyma/sl9xB2h0XLNCMNuzLKeq25tOMSyvZVQG8qx7CPioFpVfYmjQ+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268160; c=relaxed/simple;
	bh=IqMBeQoinj3qLZggdtQh3TofdcrNpcwKGbcBsFsYlnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td7vyn7jpzOuOfriXN9GrVXdQMtbneswYfq7YA75RkkM6IzEkSyp6vnIpZz7CS2Wc/etmyrmMCI6BRs32lHg4mOfON7gltG3xC6GGwNg+HYOL08drcu/wG21iGCGPtD9zgo1XSdHM6x2NNs/tF2eYLZdiHDAUvaG2xHkiHivrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LQf6rABS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EnwBgC7sqK5GJPH6z85eAMNz/YmnKPxbu0l4LtLf4hw=; b=LQf6rABSpj7A/tRu6vv+CQgxJJ
	md3j+iAzRXEcQv666Cx8WQL45ZQP+qydKbWITStW9u16qIDnY3GNy8gdvQzcvBgZ5YYRCaMe/5Lgo
	HHPZeVauQFcaM+m8e9ORliPEannvyx3BMbK9hn9vl6Ku92hZZstdllz9UREH941bGuRNJJXLKUsY2
	G2iuOY+Ao4Pyvk4PuEiFkkeQ9Q1yqjche+XyqgaX/TcX4Nd9K7UGxut9vPgRHhL8CxL+Vf0q15hTp
	YRGt803RpCzBCpcWv7c4Tkm7fkZIFBzAdZ0G5gbAQp7XPVY9VC3esV9XJsZki7WPbxJxSh/LgOEhm
	fILs/+LA==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rk6rs-009TZS-BR; Tue, 12 Mar 2024 19:28:52 +0100
Date: Tue, 12 Mar 2024 15:27:38 -0300
From: Melissa Wen <mwen@igalia.com>
To: Arthur Grillo <arthurgrillo@riseup.net>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, 
	Melissa Wen <melissa.srw@gmail.com>, =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, pekka.paalanen@haloniitty.fi, 
	Louis Chauvet <louis.chauvet@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com, 
	seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com, 
	Pekka Paalanen <pekka.paalanen@collabora.com>
Subject: Re: [PATCH 1/7] drm: Fix drm_fixp2int_round() making it add 0.5
Message-ID: <yyrvbqpmqplwtqfdsjkhzmx7wrk4h67kn5443bdou7c7uciouy@hac7zfxiff7t>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net>

On 03/06, Arthur Grillo wrote:
> As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
> To round a number, you need to add 0.5 to the number and floor that,
> drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
> 
> [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
> 
Hi Arthur,

thanks for addressing this issue.

Please, add a fix tag to the commit that you are fixing, so we can
easily backport. Might be this commit:
https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/vkms?id=ab87f558dcfb2562c3497e89600dec798a446665
> Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
>  include/drm/drm_fixed.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> index 0c9f917a4d4b..de3a79909ac9 100644
> --- a/include/drm/drm_fixed.h
> +++ b/include/drm/drm_fixed.h
> @@ -90,7 +90,7 @@ static inline int drm_fixp2int(s64 a)
>  
>  static inline int drm_fixp2int_round(s64 a)
>  {
> -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
Also, this is the only usage of DRM_FIXED_POINT_HALF. Can you also
remove it as it won't be used anymore?

> +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
Would this division be equivalent to just shifting 1ULL by 31 instead of
32 as done in DRM_FIXED_ONE?

Melissa

>  }
>  
>  static inline int drm_fixp2int_ceil(s64 a)
> 
> -- 
> 2.43.0
> 

