Return-Path: <linux-kernel+bounces-22212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD6829AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4AD1F22B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA84879E;
	Wed, 10 Jan 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="bmxA38PG"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085348790
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (p5de453e7.dip0.t-ipconnect.de [93.228.83.231])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 1C8582FC0057;
	Wed, 10 Jan 2024 14:09:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1704892153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjmCj0ca8jaa062CnfpuGDxA7/7+921oq64gB2rF+Ig=;
	b=bmxA38PGD1K6FPTSKTedfnYmsEGQy/MDis1bHTG7qt2F6Bkt7VAsjrUQ3P0tRW4d7z3+mA
	701MaIPi4w3uhfMbYOG4k1yqcC5vx9SY+iyX3XK+da1Qt7CN7eAM64ikLSjKcTpwXi2SUM
	5t0Zf0znq0run9e7S5M4qnzgEUgapis=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <92e20f9b-2cbf-4efe-b61b-989da0cc1668@tuxedocomputers.com>
Date: Wed, 10 Jan 2024 14:09:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] drm/uAPI: Add "preferred color format" drm property
 as setting for userspace
Content-Language: en-US
To: Andri Yngvason <andri@yngvason.is>, Maxime Ripard <mripard@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Simon Ser <contact@emersion.fr>, Dan Carpenter <dan.carpenter@oracle.com>
References: <20240109181104.1670304-1-andri@yngvason.is>
 <20240109181104.1670304-6-andri@yngvason.is>
 <qdwv7sagqs5nmmsy5lko5hypldanfodafyzamrs3loj3n7jzlr@n5bacxkknkj4>
 <CAFNQBQzijyE4wR34AOLM45m+ryx128igVKO9zPJ5-M3afFQMxQ@mail.gmail.com>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAFNQBQzijyE4wR34AOLM45m+ryx128igVKO9zPJ5-M3afFQMxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 10.01.24 um 11:11 schrieb Andri Yngvason:
> Hi,
>
> mið., 10. jan. 2024 kl. 09:27 skrifaði Maxime Ripard <mripard@kernel.org>:
>> On Tue, Jan 09, 2024 at 06:11:02PM +0000, Andri Yngvason wrote:
>>> From: Werner Sembach <wse@tuxedocomputers.com>
>>>
>>> Add a new general drm property "preferred color format" which can be used
>>> by userspace to tell the graphic drivers to which color format to use.
>>>
>>> Possible options are:
>>>      - auto (default/current behaviour)
>>>      - rgb
>>>      - ycbcr444
>>>      - ycbcr422 (not supported by both amdgpu and i915)
>>>      - ycbcr420
>>>
>>> In theory the auto option should choose the best available option for the
>>> current setup, but because of bad internal conversion some monitors look
>>> better with rgb and some with ycbcr444.
>> I looked at the patch and I couldn't find what is supposed to happen if
>> you set it to something else than auto, and the driver can't match that.
>> Are we supposed to fallback to the "auto" behaviour, or are we suppose
>> to reject the mode entirely?
>>
>> The combination with the active output format property suggests the
>> former, but we should document it explicitly.
> It is also my understanding that it should fall back to the "auto"
> behaviour. I will add this to the documentation.

Yes, that was the intention, and then userspace can check, but it wasn't well 
received: https://gitlab.freedesktop.org/drm/amd/-/issues/476#note_964530

Actually a lot of the thoughts that went into the original patch set can be 
found in that topic.

There was another iteration of the patch set that I never finished and sent to 
the LKML because I got discouraged by this: 
https://lore.kernel.org/dri-devel/20210623102923.70877c1a@eldfell/

I can try to dig it up, but it is completely untested and I don't think I still 
have the respective TODO list anymore, so I don't know if it is a better or 
worst starting point than the last iteration I sent to the LKML.

Greetings

Werner

>
> Thanks,
> Andri

