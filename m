Return-Path: <linux-kernel+bounces-102384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C3087B175
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF9A1F2702B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438D3537E3;
	Wed, 13 Mar 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="oYAAN2Cy"
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36A495F0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355650; cv=none; b=oPectv1WS8wTJBa8KEn/k3PDuB1sLYDRsu/CaVVcaxPl1qSE5t3hZ+w048G2IGLNkh91qY2Ctpz18/91qH9CZJYLWK+wxBWQgc/X2w++bb0Go9ad7sVncXjsXIzIJ7Suw8+bmQWC8Xwnk1UdkS1QHcwwCo3shqdBDsYtZ+bw/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355650; c=relaxed/simple;
	bh=2251ikvWdPMlqi5xbxTBSf33KyzLUDpjezbwNx4ZjUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/q8d5Zjog4BpV0YCaa9MdyUaHngPjPgnZs9U5bANGjVkqyNZDljMSNDdm0EpnC1IePmjya1gGXyC6lwC9yt+xaEnWBwspgmBAyNcgfRba1IcKpshQev7sWTWaAdhq1UvGyZSp/j53ccFsJyvAYGCMxgr1T9bf4Q2QN65Zudewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=oYAAN2Cy; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Tvzyd6D47z9tJs;
	Wed, 13 Mar 2024 18:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1710355642; bh=2251ikvWdPMlqi5xbxTBSf33KyzLUDpjezbwNx4ZjUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oYAAN2Cyip9Gck7IiIBhIBeHOMAvpckXj0D8mE5HmH1otlCjZynvUFCtK8gPOdLco
	 3Iai7fsa9m84FaTWX4R+JaCs1DFXK4me7PtR2J+buh8RrLfzR2zpVBSAZENJ8WRZaX
	 Xrr2B+sibHjMidkxUrMiM+fJww35MnX9DrPRS8ic=
X-Riseup-User-ID: 6FD4C10D02BAAE4E66CFC01A5A1821683586697382E1A5F6321CA09D508FA355
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TvzyV1b1lzJrqD;
	Wed, 13 Mar 2024 18:47:13 +0000 (UTC)
Message-ID: <16f8867c-147a-4149-ba96-ae70f8eaf903@riseup.net>
Date: Wed, 13 Mar 2024 15:47:11 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] drm: Fix drm_fixp2int_round() making it add 0.5
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Haneen Mohammed <hamohammed.sa@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi, Louis Chauvet <louis.chauvet@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com, Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20240306-louis-vkms-conv-v1-0-5bfe7d129fdd@riseup.net>
 <20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net>
 <yyrvbqpmqplwtqfdsjkhzmx7wrk4h67kn5443bdou7c7uciouy@hac7zfxiff7t>
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <yyrvbqpmqplwtqfdsjkhzmx7wrk4h67kn5443bdou7c7uciouy@hac7zfxiff7t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/03/24 15:27, Melissa Wen wrote:
> On 03/06, Arthur Grillo wrote:
>> As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
>> To round a number, you need to add 0.5 to the number and floor that,
>> drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
>>
>> [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
>>
> Hi Arthur,
> 
> thanks for addressing this issue.
> 
> Please, add a fix tag to the commit that you are fixing, so we can
> easily backport. Might be this commit:
> https://cgit.freedesktop.org/drm/drm-misc/commit/drivers/gpu/drm/vkms?id=ab87f558dcfb2562c3497e89600dec798a446665
>> Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>> ---
>>  include/drm/drm_fixed.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
>> index 0c9f917a4d4b..de3a79909ac9 100644
>> --- a/include/drm/drm_fixed.h
>> +++ b/include/drm/drm_fixed.h
>> @@ -90,7 +90,7 @@ static inline int drm_fixp2int(s64 a)
>>  
>>  static inline int drm_fixp2int_round(s64 a)
>>  {
>> -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
> Also, this is the only usage of DRM_FIXED_POINT_HALF. Can you also
> remove it as it won't be used anymore?
> 
>> +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
> Would this division be equivalent to just shifting 1ULL by 31 instead of
> 32 as done in DRM_FIXED_ONE?

Yes, but I think the division makes it easier to understand what is
going on.

Best Regards,
~Arthur Grillo

> 
> Melissa
> 
>>  }
>>  
>>  static inline int drm_fixp2int_ceil(s64 a)
>>
>> -- 
>> 2.43.0
>>

