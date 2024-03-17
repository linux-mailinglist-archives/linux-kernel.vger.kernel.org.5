Return-Path: <linux-kernel+bounces-105563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115E287E059
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B4B1C20B13
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE37208B8;
	Sun, 17 Mar 2024 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="q3Pazfd8"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D34208A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710710910; cv=none; b=Q1D7iQALaAX/AJMcP9CFqL/ae3j75RqoZzJHF41XMF2TBlJ6atph6pybKhQ6/4ivkBwwimQoZjAz6Lm2zzJqDv2YyiJ7wGprsCljDmx+63fanfzOqfnbqQxHyY9bigJx5aeA9GaoY3zhauOOgHxDn9vjOYyK/yCg+CXJaFcBV5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710710910; c=relaxed/simple;
	bh=Zn8xhUzB4YikWkPDKtaUzqYPt3SCVFEfxhNghZcrqx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ4dZBu4UNPIDyhXEkmcLh355/uwbC8XAAbWrfFSapmUxpyqY8WsijDriIIMP2LWpkeOu6HhZyh5cZZqBKLCEdzuyuipaFhXWSGp+ZnZN7uP/JldZ7R50Di7/4yign+BLzBJUepOmKnUxFApTVHrRSUtWeijTy8OzbE2O1dZDdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=q3Pazfd8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=spdhsreoGQYh5QziLgmG3lJveDp2POLjj7v3Ev7ShyQ=; b=q3Pazfd83vCX8KHmCezaVUG1vK
	xXJULLisfWgce4daq3jv6NolJJxdIDosMxzH43BHmUnAjXrg8HzBDh/dtZ8/6FNBi0hjQ73v8+iH6
	zToBpnwzquxv0e6FH3hGIRipUicj79zKE2Uxi/LssHRbd2YNzj+lyIcmNte/CBdu4jWIu4DvBxU/D
	iHzoMk5o4DYOyJK3/PgmSyaaGLMWGpOvh02J8bUI3XMKeTMUyZkrVvBZ/L9Z/Aj+8Mim3w1B4xVgJ
	Y/n8HMXl5rfBeZUKrKIzRULS7B3sqPNef0/R4lG467Pw160b5rBqOu6oMs6P7FjlrVqKrxw0VEBkj
	whdWL3vA==;
Received: from [177.34.169.255] (helo=[192.168.0.139])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1rly2z-00Bk6n-AV; Sun, 17 Mar 2024 22:28:01 +0100
Message-ID: <d296d1b2-7dcd-4dd3-a15c-678e29836063@igalia.com>
Date: Sun, 17 Mar 2024 18:27:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm: Fix drm_fixp2int_round() making it add 0.5
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, Arthur Grillo <arthurgrillo@riseup.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240316-drm_fixed-v2-1-c1bc2665b5ed@riseup.net>
 <7636b3tjifajvw63ux7xfjz4hjzhgjrf37mqgulneqzb7eukph@i6nnyietvxji>
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
In-Reply-To: <7636b3tjifajvw63ux7xfjz4hjzhgjrf37mqgulneqzb7eukph@i6nnyietvxji>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Melissa,

On 3/17/24 14:50, Melissa Wen wrote:
> On 03/16, Arthur Grillo wrote:
>> As well noted by Pekka[1], the rounding of drm_fixp2int_round is wrong.
>> To round a number, you need to add 0.5 to the number and floor that,
>> drm_fixp2int_round() is adding 0.0000076. Make it add 0.5.
>>
>> [1]: https://lore.kernel.org/all/20240301135327.22efe0dd.pekka.paalanen@collabora.com/
>>
>> Fixes: 8b25320887d7 ("drm: Add fixed-point helper to get rounded integer values")
>> Suggested-by: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
> 
> Great, thanks!
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> 
> I'll apply to drm-misc-next.

Shouldn't this patch be applied in drm-misc-fixes?

Best Regards,
- Maíra

> 
> Melissa
> 
>> ---
>> Changes in v2:
>> - Add Fixes tag (Melissa Wen)
>> - Remove DRM_FIXED_POINT_HALF (Melissa Wen)
>> - Link to v1: https://lore.kernel.org/all/20240306-louis-vkms-conv-v1-1-5bfe7d129fdd@riseup.net/
>> ---
>>   include/drm/drm_fixed.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
>> index 0c9f917a4d4b..81572d32db0c 100644
>> --- a/include/drm/drm_fixed.h
>> +++ b/include/drm/drm_fixed.h
>> @@ -71,7 +71,6 @@ static inline u32 dfixed_div(fixed20_12 A, fixed20_12 B)
>>   }
>>   
>>   #define DRM_FIXED_POINT		32
>> -#define DRM_FIXED_POINT_HALF	16
>>   #define DRM_FIXED_ONE		(1ULL << DRM_FIXED_POINT)
>>   #define DRM_FIXED_DECIMAL_MASK	(DRM_FIXED_ONE - 1)
>>   #define DRM_FIXED_DIGITS_MASK	(~DRM_FIXED_DECIMAL_MASK)
>> @@ -90,7 +89,7 @@ static inline int drm_fixp2int(s64 a)
>>   
>>   static inline int drm_fixp2int_round(s64 a)
>>   {
>> -	return drm_fixp2int(a + (1 << (DRM_FIXED_POINT_HALF - 1)));
>> +	return drm_fixp2int(a + DRM_FIXED_ONE / 2);
>>   }
>>   
>>   static inline int drm_fixp2int_ceil(s64 a)
>>
>> ---
>> base-commit: f89632a9e5fa6c4787c14458cd42a9ef42025434
>> change-id: 20240315-drm_fixed-c680ba078ecb
>>
>> Best regards,
>> -- 
>> Arthur Grillo <arthurgrillo@riseup.net>
>>

