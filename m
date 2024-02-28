Return-Path: <linux-kernel+bounces-85856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE63786BC4C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BEE51F23300
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8272909;
	Wed, 28 Feb 2024 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="i4fk+b1j"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E313D2E3;
	Wed, 28 Feb 2024 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163789; cv=none; b=agpUTWpvVLY9YGo+VHmCDTNx25ywclHPv5u5jsN7ZmiNMWQ91NVmco6g3eC9PdLEVoEmDBnIDNHyUpLYoNW+c5sadGN/BtVGIyGrHbkWX1D+OulkfTPdA5DBkoeDVc+hZRnMHGDis0vXrA1dfhgZDL833u3pS0PGuwxK5RKpOyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163789; c=relaxed/simple;
	bh=PP8PEC6rFh1DwcrVPHXVW/931c6ONXSblHZE9aVTqp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d15ZplBM6h/suArHTd7ukhOByTW05RCf6EsDK5DKobjt30hPAzyLQOhJtZhoPi2s34oJmdqmfKVpNZgAfWCVfKOHU8HMzlcB96r2PcRE3kPVG9ScR8sqnzgqNF80fT46tYv5BPhuMhb+tUGYGwlT3SmdNJkkI4fjiyXjLYJy8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=i4fk+b1j; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4TlWB21vmjzDq6T;
	Wed, 28 Feb 2024 23:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1709163781; bh=PP8PEC6rFh1DwcrVPHXVW/931c6ONXSblHZE9aVTqp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i4fk+b1jpnaGlH3cL5gWB/A8KeL08j9ZijONrP/WfY8cIVdC6zJQH6Dg21pBNrHPQ
	 Z6rwY7uTB94u7bBvg69unZNj+mb+sB9yBP+fz7HGuV1ZffwsIMPkehDs40x3I5Sd1l
	 1BgWhtqg2dDlId3bTLK+EXd3yXqBeNe3cP6lRQuw=
X-Riseup-User-ID: 2052F0A24D6BCE5ED2705508C577C34C275D6FB563886C45EEEF070D3EB3EA2F
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4TlW9w5nmszJrYk;
	Wed, 28 Feb 2024 23:42:44 +0000 (UTC)
Message-ID: <9e6ed0e5-c9aa-4fb9-a6d8-4c3b1d658ef2@riseup.net>
Date: Wed, 28 Feb 2024 20:42:41 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/7] Add YUV formats to VKMS
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Jonathan Corbet <corbet@lwn.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Melissa Wen <melissa.srw@gmail.com>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20240110-vkms-yuv-v2-0-952fcaa5a193@riseup.net>
 <20240115150600.GC160656@toolbox>
Content-Language: en-US
From: Arthur Grillo <arthurgrillo@riseup.net>
In-Reply-To: <20240115150600.GC160656@toolbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/01/24 12:06, Sebastian Wick wrote:
> On Wed, Jan 10, 2024 at 02:44:00PM -0300, Arthur Grillo wrote:
>> This patchset aims to add support for additional buffer YUV formats.
>> More specifically, it adds support to:
>>
>> Semi-planar formats:
>>
>> - NV12
>> - NV16
>> - NV24
>> - NV21
>> - NV61
>> - NV42
>>
>> Planar formats:
>>
>> - YUV440
>> - YUV422
>> - YUV444
>> - YVU440
>> - YVU422
>> - YVU444
>>
>> These formats have more than one plane, and most have chroma
>> subsampling. These properties don't have support on VKMS, so I had to
>> work on this before.
>>
>> To ensure that the conversions from YUV to RGB are working, I wrote a
>> KUnit test. As the work from Harry on creating KUnit tests on VKMS[1] is
>> not yet merged, I took the setup part (Kconfig entry and .kunitfile)
>> from it.
>>
>> Furthermore, I couldn't find any sources with the conversion matrices,
>> so I had to work out the values myself based on the ITU papers[2][3][4].
>> So, I'm not 100% sure if the values are accurate. I'd appreciate some
>> input if anyone has more knowledge in this area.
> 
> H.273 CICP [1] has concise descriptions of the required values for most
> widely used formats and the colour python framework [2] also can be used
> to quickly get to the desired information most of the time.
> 
> [1]: https://www.itu.int/rec/T-REC-H.273
> [2]: https://www.colour-science.org/

I want to thank you for suggesting the python framework, it helped
immensely now that I'm changing the precision from 8-bit to 32-bit[1].

If I'd known about this framework while developing this patch, I
would've saved myself a few weeks of pain and suffering recreating a
part of this library XD.

[1]: https://lore.kernel.org/all/b23da076-0bfb-48b2-9386-383a6dec1868@riseup.net/

Best Regards,
~Arthur Grillo

> 
>> Also, I used two IGT tests to check if the formats were having a correct
>> conversion (all with the --extended flag):
>>
>> - kms_plane@pixel_format
>> - kms_plane@pixel_format_source_clamping.
>>
>> The nonsubsampled formats don't have support on IGT, so I sent a patch
>> fixing this[5].
>>
>> Currently, this patchset does not add those formats to the writeback, as
>> it would require a rewrite of how the conversions are done (similar to
>> what was done on a previous patch[6]). So, I would like to review this
>> patchset before I start the work on this other part.
>>
>> [1]: https://lore.kernel.org/all/20231108163647.106853-5-harry.wentland@amd.com/
>> [2]: https://www.itu.int/rec/R-REC-BT.601-7-201103-I/en
>> [3]: https://www.itu.int/rec/R-REC-BT.709-6-201506-I/en
>> [4]: https://www.itu.int/rec/R-REC-BT.2020-2-201510-I/en
>> [5]: https://lists.freedesktop.org/archives/igt-dev/2024-January/066937.html
>> [6]: https://lore.kernel.org/dri-devel/20230414135151.75975-2-mcanal@igalia.com/
>>
>> Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
>> ---
>> Changes in v2:
>> - Use EXPORT_SYMBOL_IF_KUNIT instead of including the .c test
>>   file (Maxime)
>> - Link to v1: https://lore.kernel.org/r/20240105-vkms-yuv-v1-0-34c4cd3455e0@riseup.net
>>
>> ---
>> Arthur Grillo (7):
>>       drm/vkms: Use drm_frame directly
>>       drm/vkms: Add support for multy-planar framebuffers
>>       drm/vkms: Add range and encoding properties to pixel_read function
>>       drm/vkms: Add chroma subsampling
>>       drm/vkms: Add YUV support
>>       drm/vkms: Drop YUV formats TODO
>>       drm/vkms: Create KUnit tests for YUV conversions
>>
>>  Documentation/gpu/vkms.rst                    |   3 +-
>>  drivers/gpu/drm/vkms/Kconfig                  |  15 ++
>>  drivers/gpu/drm/vkms/Makefile                 |   1 +
>>  drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
>>  drivers/gpu/drm/vkms/tests/Makefile           |   3 +
>>  drivers/gpu/drm/vkms/tests/vkms_format_test.c | 156 ++++++++++++++++
>>  drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
>>  drivers/gpu/drm/vkms/vkms_formats.c           | 247 ++++++++++++++++++++++----
>>  drivers/gpu/drm/vkms/vkms_formats.h           |   9 +
>>  drivers/gpu/drm/vkms/vkms_plane.c             |  26 ++-
>>  drivers/gpu/drm/vkms/vkms_writeback.c         |   5 -
>>  11 files changed, 426 insertions(+), 49 deletions(-)
>> ---
>> base-commit: eeb8e8d9f124f279e80ae679f4ba6e822ce4f95f
>> change-id: 20231226-vkms-yuv-6f7859f32df8
>>
>> Best regards,
>> -- 
>> Arthur Grillo <arthurgrillo@riseup.net>
>>
> 

