Return-Path: <linux-kernel+bounces-99125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6BB8783B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D831F24245
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994645C04;
	Mon, 11 Mar 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UTumD/dR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1C143AD6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170691; cv=none; b=b02Lt4BfNcOZuoeOcbw7ZdOLP0GhX5YFBbwng+oE/hKwyhkzlqiH9m0rdJR5DGd/hjzpYVc0apvpShB0zbZ2EKiw/MhymJW1NZ6VlNzCv1JfLSS4GQ4v78kZwYA4vRUMrDBg/Oh1zRdDbi/0L1vkz4cD9q2UVay60s6TZkXjp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170691; c=relaxed/simple;
	bh=7LuloqQ6JZHohkMaoX6REYD2tGrPYtKK7SgA5+2qFPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBcbXPU37WLQ/K7IYXUYUfeFrjhF/4t/2dx8Fxcg2MIcUai6yZS9EbZsM8+P2vxsdt6tfkyXC1HFq+qAyagx1jVu6m1qnGzjBGiMinJeAm6JJGWU/PNTGDc05kfiYzP3mU0hBTcJKr5LNOPGH4PBfPcqIPPbPQ6cz/TVoC3KNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UTumD/dR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710170687;
	bh=7LuloqQ6JZHohkMaoX6REYD2tGrPYtKK7SgA5+2qFPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTumD/dRWYrZvRCLczuA4+CUdTIo5PXjQgjLEhqVhueejeAWcP0SrRFHoCWILu4QN
	 fuyLLWEf1LIGefQYAPcBlARySgoDMj3nGp0GDZWaEr4cKSqWXMdzVFvWQm4WLF///n
	 f4i7vq0fB0186u91+hUutvb1PZ2ctEMVgcpJ8fKdUaOmUKEstKlFBF7LWHsKMY/U1G
	 dPGR0bjWjAr36pDLW1yq4nymU+1CuT7T56yJ7ZULQftTfze3Wsipa/2Ah3o+yN4FM6
	 +OnOrCbVr0thGaqFpCZw5W4Axgj518Wx2tNzYUk0+9BAiUSMIS2h7QrA8LkA3NZ1vb
	 /A8FqnwH9dAGg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1C1CE3780C22;
	Mon, 11 Mar 2024 15:24:47 +0000 (UTC)
Date: Mon, 11 Mar 2024 16:24:46 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>,
	"nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
	Nas Chung <nas.chung@chipsnmedia.com>,
	"lafley.kim" <lafley.kim@chipsnmedia.com>
Subject: Re: [PATCH v2 0/4] wave5 codec driver
Message-ID: <20240311152446.xvqskyywx3j4fsuw@basti-XPS-13-9310>
References: <20240311042442.10755-1-jackson.lee@chipsnmedia.com>
 <20240311092953.bhddzoigalhoyydi@basti-XPS-13-9310>
 <20240311093854.ubvv6aqnuatta7uv@basti-XPS-13-9310>
 <SE1P216MB13037F3FBA11D30884DDD53AED242@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SE1P216MB13037F3FBA11D30884DDD53AED242@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>

Hey Jackson,

On 11.03.2024 11:01, jackson.lee wrote:
>Hello Sebastian
>
>Thanks for your review.

just to clarify, what I meant with the title is not that it needs to be a
mini summary, as that is what the body of the cover letter is for. But
it should show clearly what to expect in the series, like do you:
- introduce a new driver?
- fix bugs on an existing driver?
- add features to an existing driver?
- refactor code?
- add support for new hardware?

That makes it easier for a maintainer for example to quickly judge
priority of a patch set and makes it easy to distinguish the different
patch series in the mail reader.

So if you have a single change you can just describe that fully (if you
even need a cover letter in that case), otherwise try to basically
describe on a very broad level what you have done. For these patches a
title like: "additional features and formats for the Wave5 Codec" might
be fitting, but no need to RESEND for that again, just keep that in mind
for the future.

Greetings,
Sebastian

>
>
>> -----Original Message-----
>> From: Sebastian Fricke <sebastian.fricke@collabora.com>
>> Sent: Monday, March 11, 2024 6:39 PM
>> To: jackson.lee <jackson.lee@chipsnmedia.com>
>> Cc: mchehab@kernel.org; nicolas@ndufresne.ca; linux-kernel@vger.kernel.org;
>> hverkuil@xs4all.nl; Nas Chung <nas.chung@chipsnmedia.com>; lafley.kim
>> <lafley.kim@chipsnmedia.com>
>> Subject: Re: [PATCH v2 0/4] wave5 codec driver
>>
>> Hey Jackson,
>>
>> Ah and also you have to resend the series because you didn't send to:
>> linux-media@vger.kernel.org
>>
>> Here what I wrote on V0:
>> > you forgot to send this mail series to the media mailing list
>> > (linux-media@vger.kernel.org), which makes it a bit hard for people to
>> > review the patches.
>> >
>> > Please use either the `./scripts/get_maintainer.p` Script in the
>> > kernel root directory:
>> > ```
>> > ❯ ./scripts/get_maintainer.pl
>> > ~/Mail/patches/_PATCH_v0_1-5_wave5_Support_yuv422_input_format_for_enc
>> > oder.patch Nas Chung <nas.chung@chipsnmedia.com> (maintainer:WAVE5 VPU
>> > CODEC DRIVER) Jackson Lee <jackson.lee@chipsnmedia.com>
>> > (maintainer:WAVE5 VPU CODEC DRIVER) Mauro Carvalho Chehab
>> > <mchehab@kernel.org> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB))
>> > linux-media@vger.kernel.org (open list:WAVE5 VPU CODEC DRIVER)
>> > linux-kernel@vger.kernel.org (open list) ```
>> >
>> > Or use a tool like b4 to generate the list of receivers:
>> > https://b4.docs.kernel.org/en/latest/contributor/prep.html#prepare-the
>> > -list-of-recipients
>> >
>> > After that you can then add any additional receivers you like, but
>> > this makes sure that the most essential mails are present.
>> > also just noting in case you want to just resend the series without
>> > doing any actual changes to the patches, please add a RESEND tag to
>> > the mails, like here:
>> > https://lore.kernel.org/all/20240126192128.1210579-1-cristian.ciocalte
>> > a@collabora.com/T/#t
>> >
>> > e.g. [RESEND PATCH v0 0/5]
>> >
>> > This can be changed for example like this:
>> > `git format-patch --subject-prefix="RESEND PATCH" ...`
>>
>> Greetings,
>> Sebastian
>>
>> On 11.03.2024 10:29, Sebastian Fricke wrote:
>> >Hey Jackson,
>> >
>> >just as a quick info, I feel like the title of the cover letter is a
>> >bit confusing, as it sounds like it contains the source code for the
>> >wave5 codec driver, which we already have. Usually the title of the
>> >cover letter should indicate to the reader what to expect in the
>> >patch-set (which can also be a really nice indication for when you try
>> >to do too much in a single patch-set, because then it will be hard to
>> >make a concise title).
>> >
>> >Greetings,
>> >Sebastian
>> >
>> >On 11.03.2024 13:24, jackson.lee wrote:
>> >>From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
>> >>
>> >>The wave5 codec driver is a stateful encoder/decoder.
>> >>The following patches is for supporting yuv422 inpuy format,
>> >>supporting runtime suspend/resume feature and extra things.
>> >>
>> >>v4l2-compliance results:
>> >>========================
>> >>
>> >>v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>> >>
>> >>Buffer ioctls:
>> >>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
>> supported
>> >>	    warn: v4l2-test-buffers.cpp(693): VIDIOC_CREATE_BUFS not
>> supported
>> >>   test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>> >>   test VIDIOC_EXPBUF: OK
>> >>   test Requests: OK (Not Supported)
>> >>
>> >>Total for wave5-dec device /dev/video0: 45, Succeeded: 45, Failed: 0,
>> >>Warnings: 2 Total for wave5-enc device /dev/video1: 45, Succeeded: 45,
>> >>Failed: 0, Warnings: 0
>> >>
>> >>Fluster test results:
>> >>=====================
>> >>
>> >>Running test suite JCT-VC-HEVC_V1 with decoder GStreamer-H.265-V4L2-
>> Gst1.0 Using 1 parallel job(s)
>> >>Ran 132/147 tests successfully               in 94.782 secs
>> >>
>> >>(1 test fails because of not supporting to parse multi frames, 1 test
>> >>fails because of a missing frame and slight corruption, 2 tests fail
>> >>because of sizes which are incompatible with the IP, 11 tests fail
>> >>because of unsupported 10 bit format)
>> >>
>> >>Running test suite JVT-AVC_V1 with decoder GStreamer-H.264-V4L2-Gst1.0
>> Using 1 parallel job(s)
>> >>Ran 77/135 tests successfully               in 37.364 secs
>> >>
>> >>(58 fail because the hardware is unable to decode  MBAFF / FMO / Field
>> >>/ Extended profile streams.)
>> >>
>> >>
>> >>Chnage since v1:
>> >>=================
>> >>
>> >>* For [PATCH v2 0/4] media: chips-media: wave5: Support SPS/PPS
>> >>generation for each IDR
>> >>- define a macro for register addresses
>> >>
>> >>* For [PATCH v2 1/4] media: chips-media: wave5: Support runtime
>> >>suspend/resume
>> >>- add auto suspend/resume
>> >>
>> >>* For [PATCH v2 2/4] media: chips-media: wave5: Use helpers to
>> >>calculate bytesperline and sizeimage
>> >>- use helper functions to calculate bytesperline and sizeimage
>> >>
>> >>* For [PATCH v2 3/4] media: chips-media: wave5: Support YUV422 raw
>> >>pixel-formats on the encoder
>> >>- remove unnecessary codes
>> >>
>> >>Change since v0:
>> >>=================
>> >>The DEFAULT_SRC_SIZE macro was defined using multiple lines, To make a
>> >>simple define, tab and multiple lines has been removed, The macro is
>> >>defined using one line.
>> >>
>> >>
>> >>Jackson.lee (4):
>> >> media: chips-media: wave5: Support SPS/PPS generation for each IDR
>> >> media: chips-media: wave5: Support runtime suspend/resume
>> >> media: chips-media: wave5: Use helpers to calculate bytesperline and
>> >>   sizeimage.
>> >> media: chips-media: wave5: Support YUV422 raw pixel-formats on the
>> >>   encoder.
>> >>
>> >>.../platform/chips-media/wave5/wave5-helper.c |  24 ++
>> >>.../platform/chips-media/wave5/wave5-helper.h |   4 +
>> >>.../platform/chips-media/wave5/wave5-hw.c     |  23 +-
>> >>.../chips-media/wave5/wave5-vpu-dec.c         | 261 +++++-------------
>> >>.../chips-media/wave5/wave5-vpu-enc.c         | 260 +++++++++--------
>> >>.../platform/chips-media/wave5/wave5-vpu.c    |  43 +++
>> >>.../platform/chips-media/wave5/wave5-vpu.h    |   4 -
>> >>.../platform/chips-media/wave5/wave5-vpuapi.c |  14 +-
>> >>.../platform/chips-media/wave5/wave5-vpuapi.h |   1 +
>> >>.../chips-media/wave5/wave5-vpuconfig.h       |  25 +-
>> >>.../media/platform/chips-media/wave5/wave5.h  |   3 +
>> >>11 files changed, 329 insertions(+), 333 deletions(-)
>> >>
>> >>--
>> >>2.43.0
>> >>

