Return-Path: <linux-kernel+bounces-97561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595B876BF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6ACEB21D87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428035E068;
	Fri,  8 Mar 2024 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P+psoRYM"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402311D52D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930338; cv=none; b=PGbHwUjVGlnfaWda6Z7lSjvLzAnw3fw54+vzgGbg6aE+7yDRIv2jqbpe1VEAx2NG2cFJa6Dy9+j7hq8FYmtZnUpq7lm1Rwf1PZJFzjFQtqW+3Vw6TsZBTI/+EFnMrNw/RUWJRTa6wP8adXJCQvbMf/0wxpKuVRZhEa+Gt3EsMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930338; c=relaxed/simple;
	bh=NCx5LITqLfd5IR5H/1MZ4bqNFQ5kjpffWRsXWLwGrH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dpj1vt1rrNn9dwkl+OP8a34nl8T5Pi9ngQ5VPS2+kKchDFdGwT6MjbgV6axKM+LSxR/ReKcVh56lhuV755Kx1aSKef+oJkCcXbLvQ/iQZo2XmsaAZSoddLInU8E+abxSqOJamZzZjCkBeOl9rzNOduChSrNEhSdgUUPqYeem9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P+psoRYM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/47zSNS8X3eOPzjZdvlkdHcgjIKBxlrq4BUs8maJTKI=; b=P+psoRYM5z3lfXYWFwEz/bAINB
	OPOxutLt5xDfXAWdDKQpYEoteejZVcbRTgwcL5gWxB6YQBIlcM928wCP3ORY0SB6AtDgpXfRmfJ6W
	O6WiGduHj8ETWuoDJElwDFkf7KtsF01vYBDlglzNb5jy9s3fp/XVi7qNDiYiAKJXJxduI9SBwA5AG
	FGFY6sBpwcAXQ+UjRfQ0IDlv5ENI+LPo1yeB6ObG0g9KgE3rMTNIrIsW0V9zYbLRlSnZ42GKeKc6p
	gmO20XmEZYn5mFQEt6pd/HVxnHy2yiQes02adum0ST3BaFnT7KbtZJHN9jpiiivU1aBZ0YPBbpQMY
	5YSHJUKg==;
Received: from [186.230.26.74] (helo=[10.39.29.45])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rigyw-007xOC-Fz; Fri, 08 Mar 2024 21:38:18 +0100
Message-ID: <4b01ba61-9184-4a17-9fe6-59eb88a21214@igalia.com>
Date: Fri, 8 Mar 2024 17:38:07 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Additions to "Reimplement line-per-line pixel
 conversion for plane reading" series
Content-Language: en-US
To: Arthur Grillo <arthurgrillo@riseup.net>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi, Louis Chauvet <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Autocrypt: addr=mcanal@igalia.com; keydata=
 xjMEZIsaeRYJKwYBBAHaRw8BAQdAGU6aY8oojw61KS5rGGMrlcilFqR6p6ID45IZ6ovX0h3N
 H01haXJhIENhbmFsIDxtY2FuYWxAaWdhbGlhLmNvbT7CjwQTFggANxYhBDMCqFtIvFKVRJZQ
 hDSPnHLaGFVuBQJkixp5BQkFo5qAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQNI+cctoYVW5u
 GAEAwpaC5rI3wD8zqETKwGVoXd6+AbmGfZuVD40xepy7z/8BAM5w95/oyPsHUqOsg/xUTlNp
 rlbhA+WWoaOXA3XgR+wCzjgEZIsaeRIKKwYBBAGXVQEFAQEHQGoOK0jgh0IorMAacx6WUUWb
 s3RLiJYWUU6iNrk5wWUbAwEIB8J+BBgWCAAmFiEEMwKoW0i8UpVEllCENI+cctoYVW4FAmSL
 GnkFCQWjmoACGwwACgkQNI+cctoYVW6cqwD/Q9R98msvkhgRvi18fzUPFDwwogn+F+gQJJ6o
 pwpgFkAA/R2zOfla3IT6G3SBoV5ucdpdCpnIXFpQLbmfHK7dXsAC
In-Reply-To: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Arthur,

Would it be possible for you to coordinate with Louis and create a
single series with all the modification?

I don't see a reason to submit fixes to a series that it is still
on review.

Best Regards,
- Maíra

On 3/6/24 17:03, Arthur Grillo wrote:
> These are some patches that add some fixes/features to the series by
> Louis Chauvet[1], it was based on top of the patches from v4.
> 
> Patches #2 and #3 should be amended to "[PATCH v4 11/14] drm/vkms: Add
> YUV support". To make patch #3 work, we need patch #1. So, please, add
> it before the patch that #2 and #3 amend to.
> 
> Patches #4 to #6 should be amended to "[PATCH v4 14/14] drm/vkms: Create
> KUnit tests for YUV conversions". While doing the additions, I found
> some compilation issues, so I fixed them (patch #4). That's when I
> thought that it would be good to add some documentation on how to run
> them (patch #7), this patch should be added to the series as new patch.
> 
> [1]: https://lore.kernel.org/r/20240304-yuv-v4-0-76beac8e9793@bootlin.com
> 
> To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> To: Melissa Wen <melissa.srw@gmail.com>
> To: Maíra Canal <mairacanal@riseup.net>
> To: Haneen Mohammed <hamohammed.sa@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> To: David Airlie <airlied@gmail.com>
> To: arthurgrillo@riseup.net
> To: Jonathan Corbet <corbet@lwn.net>
> To: pekka.paalanen@haloniitty.fi
> To: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: jeremie.dautheribes@bootlin.com
> Cc: miquel.raynal@bootlin.com
> Cc: thomas.petazzoni@bootlin.com
> Cc: seanpaul@google.com
> Cc: marcheu@google.com
> Cc: nicolejadeyee@google.com
> 
> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> ---
> Arthur Grillo (7):
>        drm: Fix drm_fixp2int_round() making it add 0.5
>        drm/vkms: Add comments
>        drm/vkmm: Use drm_fixed api
>        drm/vkms: Fix compilation issues
>        drm/vkms: Add comments to format tests
>        drm/vkms: Change the gray RGB representation
>        drm/vkms: Add how to run the Kunit tests
> 
>   Documentation/gpu/vkms.rst                    |  11 +++
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c |  81 +++++++++++++++++++--
>   drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
>   drivers/gpu/drm/vkms/vkms_formats.c           | 101 +++++++++++++++++++-------
>   include/drm/drm_fixed.h                       |   2 +-
>   5 files changed, 165 insertions(+), 34 deletions(-)
> ---
> base-commit: 9658aba38ae9f3f3068506c9c8e93e85b500fcb4
> change-id: 20240306-louis-vkms-conv-61362ff12ab8
> 
> Best regards,

