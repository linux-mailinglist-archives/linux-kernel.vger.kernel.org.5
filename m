Return-Path: <linux-kernel+bounces-98638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11053877D15
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2DF1F237F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E761B599;
	Mon, 11 Mar 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="x6BhrQhq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7F18B15
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149938; cv=none; b=ZvJFbMdGbVWplVzkT42BynT1MgL0ZDJsyShHbTuT5PvCoad0cc5g4W87CXCgCfEiK+1H7G3HMyuF2U4qCQKhQ3vssvaNqOQTQJkaKdMY4u7IGz9agTu9fwPJmD7qYeEFWv2CU+8QDqtY0abRwEKpp7+0tSCjdBe9ZFY3cenjlK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149938; c=relaxed/simple;
	bh=xCkTg0qFrws7vlj9ub0n2g7DmdEZFrSLKFffY07alNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM7y19q2xsNAcIStcHU5ifG7ClUQQ3vfcTAQIE8M8GGEOFCazDvgMRVARaB1WcBNglTT2ZRYeim06BucYZqqGgB2/iNa5jyPGkKH08j+4i1le7VICPTXYXiqmOS90eGsxbeTaDLmoe4E35N7COvCqgfCKKR2Gs4mPPdCdjXTWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=x6BhrQhq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710149935;
	bh=xCkTg0qFrws7vlj9ub0n2g7DmdEZFrSLKFffY07alNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x6BhrQhq+mtlKaZuVFOsQFsd8l4DZp7/ylQ5ouPvKvlJBZo5bKbOBEuL8huqV4UFL
	 OEVsdlDE1rZcrWsXc+pP6OTVjrdgLsoQ28oOsRCJm1RW6auVKUc+BKwVKrDwtd3qfm
	 48vZIS+0Ha/tFnltFP+Vr3pnS/UMNTU6YybMCW4GsRzTrj5fXgHInYv0VOF5ZlI9KA
	 C9ACtYwYaVAOLjeHQP+uHiwCesM/9Vk9k2ViPdwcHILZU3DZGJ01DR4XlwdZ75cWEx
	 KHOsP+pXjvL4XAC6cFviwRz/JrbRPp3GqBm/EMBkm6ini7dcyp9XA/4m2DlhtgjkJY
	 4dvFm2PDWNkSQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F31A13780C13;
	Mon, 11 Mar 2024 09:38:54 +0000 (UTC)
Date: Mon, 11 Mar 2024 10:38:54 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: mchehab@kernel.org, nicolas@ndufresne.ca, linux-kernel@vger.kernel.org,
	hverkuil@xs4all.nl, nas.chung@chipsnmedia.com,
	lafley.kim@chipsnmedia.com
Subject: Re: [PATCH v2 0/4] wave5 codec driver
Message-ID: <20240311093854.ubvv6aqnuatta7uv@basti-XPS-13-9310>
References: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
 <20240311092953.bhddzoigalhoyydi@basti-XPS-13-9310>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240311092953.bhddzoigalhoyydi@basti-XPS-13-9310>

Hey Jackson,

Ah and also you have to resend the series because you didn't send to:
linux-media@vger.kernel.org

Here what I wrote on V0:
> you forgot to send this mail series to the media mailing list
> (linux-media@vger.kernel.org), which makes it a bit hard for people
> to review the patches.
> 
> Please use either the `./scripts/get_maintainer.p` Script in the kernel
> root directory:
> ```
> ❯ ./scripts/get_maintainer.pl ~/Mail/patches/_PATCH_v0_1-5_wave5_Support_yuv422_input_format_for_encoder.patch 
> Nas Chung <nas.chung@chipsnmedia.com> (maintainer:WAVE5 VPU CODEC DRIVER)
> Jackson Lee <jackson.lee@chipsnmedia.com> (maintainer:WAVE5 VPU CODEC DRIVER)
> Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB))
> linux-media@vger.kernel.org (open list:WAVE5 VPU CODEC DRIVER)
> linux-kernel@vger.kernel.org (open list)
> ```
> 
> Or use a tool like b4 to generate the list of receivers:
> https://b4.docs.kernel.org/en/latest/contributor/prep.html#prepare-the-list-of-recipients
> 
> After that you can then add any additional receivers you like, but this
> makes sure that the most essential mails are present.
> also just noting in case you want to just resend the series without
> doing any actual changes to the patches, please add a RESEND tag to the
> mails, like here:
> https://lore.kernel.org/all/20240126192128.1210579-1-cristian.ciocaltea@collabora.com/T/#t
> 
> e.g. [RESEND PATCH v0 0/5]
> 
> This can be changed for example like this:
> `git format-patch --subject-prefix="RESEND PATCH" ...`

Greetings,
Sebastian

On 11.03.2024 10:29, Sebastian Fricke wrote:
>Hey Jackson,
>
>just as a quick info, I feel like the title of the cover letter is a bit
>confusing, as it sounds like it contains the source code for the wave5
>codec driver, which we already have. Usually the title of the cover
>letter should indicate to the reader what to expect in the patch-set
>(which can also be a really nice indication for when you try to do too
>much in a single patch-set, because then it will be hard to make a
>concise title).
>
>Greetings,
>Sebastian
>
>On 11.03.2024 13:24, jackson.lee wrote:
>>From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>>
>>The wave5 codec driver is a stateful encoder/decoder.
>>The following patches is for supporting yuv422 inpuy format, supporting
>>runtime suspend/resume feature and extra things.
>>
>>v4l2-compliance results:
>>========================
>>
>>v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>>
>>Buffer ioctls:
>>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
>>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not supported
>>   test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>>   test VIDIOC_EXPBUF: OK
>>   test Requests: OK (Not Supported)
>>
>>Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2
>>Total for wave5-enc device /dev/video1: 45, Succeeded: 45, Failed: 0, Warnings: 0
>>
>>Fluster test results:
>>=====================
>>
>>Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-Gst1.0 Using 1 parallel job(s)
>>Ran 132/147 tests successfully               in 94.782 secs
>>
>>(1 test fails because of not supporting to parse multi frames, 1 test fails because of a missing frame and slight corruption, 2 tests fail because of sizes which are incompatible with the IP, 11 tests fail because of unsupported 10 bit format)
>>
>>Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0 Using 1 parallel job(s)
>>Ran 77/135 tests successfully               in 37.364 secs
>>
>>(58 fail because the hardware is unable to decode  MBAFF / FMO / Field / Extended profile streams.)
>>
>>
>>Chnage since v1:
>>=================
>>
>>* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS generation for each IDR
>>- define a macro for register addresses
>>
>>* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime suspend/resume
>>- add auto suspend/resume
>>
>>* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to calculate bytesperline and sizeimage
>>- use helper functions to calculate bytesperline and sizeimage
>>
>>* For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw pixel-formats on the encoder
>>- remove unnecessary codes
>>
>>Change since v0:
>>=================
>>The DEFAULT_SRC_SIZE macro was defined using multiple lines,
>>To make a simple define, tab and multiple lines has been removed,
>>The macro is defined using one line.
>>
>>
>>Jackson.lee (4):
>> media: chips-media: wave5: Support SPS/PPS generation for each IDR
>> media: chips-media: wave5: Support runtime suspend/resume
>> media: chips-media: wave5: Use helpers to calculate bytesperline and
>>   sizeimage.
>> media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>>   encoder.
>>
>>.../platform/chips-media/wave5/wave5-helper.c |  24 ++
>>.../platform/chips-media/wave5/wave5-helper.h |   4 +
>>.../platform/chips-media/wave5/wave5-hw.c     |  23 +-
>>.../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
>>.../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
>>.../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
>>.../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>>.../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
>>.../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
>>.../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>>.../media/platform/chips-media/wave5/wave5.h  |   3 +
>>11 files changed, 329 insertions(+), 333 deletions(-)
>>
>>-- 
>>2.43.0
>>

