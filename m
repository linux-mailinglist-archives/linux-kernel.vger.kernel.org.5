Return-Path: <linux-kernel+bounces-18142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654F8825961
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197FF1F241B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18038328CD;
	Fri,  5 Jan 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vEBLtejK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5B250E5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704476956;
	bh=oiTjNDE8zdxt2cMZq7xxs8JwiZDB7s9mhohrKDnY/2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vEBLtejKVsVkA/nSjHRUQnhjBOK6LO380L89stD1j4116VhjpGVphkIylt+u24RH5
	 su3sUhTwunOUMgAvc3PuMdxBgz47Z+Tx2RUIyCf/jBMiOLReJffKvaYL4Dqa0eVrq0
	 NfPodRzxZeUwMTlfId+M2rY6Sey7PidHirQaAtdXqQiQWYRvWDBI0kZW96OZ6iAr6W
	 XLzf1Krv7tefrzgj56aSnHBBv4dPouS5M+QcVvkBIAgeOyOsbHfTB5ifnj0h429a8n
	 2VQYwKnzc88v9ZEEhquHMlCzAzDzFUDDWHpGHudTEn9c/L2IS3Ok2g8h8r8FFW0/7m
	 pFZl80/dkBpcQ==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29C10378003D;
	Fri,  5 Jan 2024 17:49:15 +0000 (UTC)
Message-ID: <30114fa6-d83d-4563-9f3b-2975ddfd2752@collabora.com>
Date: Fri, 5 Jan 2024 19:49:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: vop2: Drop unused if_dclk_rate variable
Content-Language: en-US
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20240104143951.85219-1-cristian.ciocaltea@collabora.com>
 <5867171.29KlJPOoH8@diego>
 <acb52035-4f0c-430d-a2d2-26ab37805d7b@rock-chips.com>
 <13141620.VsHLxoZxqI@diego>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <13141620.VsHLxoZxqI@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/24 11:57, Heiko Stübner wrote:
> Hi,
> 
> Am Freitag, 5. Januar 2024, 10:04:55 CET schrieb Andy Yan:
>> On 1/4/24 23:58, Heiko Stübner wrote:
>>> Am Donnerstag, 4. Januar 2024, 15:39:50 CET schrieb Cristian Ciocaltea:
>>>> Commit 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
>>>> introduced a variable which ended up being unused.  Remove it.
>>>>
>>>> rockchip_drm_vop2.c:1688:23: warning: variable ‘if_dclk_rate’ set but not used [-Wunused-but-set-variable]
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[...]

>>> with the code continuing with those static constants but the comment
>>> showing a forumula, I do hope Andy can provide a bit of insight into
>>> what is happening here.
>>>
>>> I.e. I'd really like to understand if that really is just a remnant or
>>> something different is needed.
>>
>> This is not a remnant, in my V1, I calculate all the div by formula, but Sascha prefer
>> more for a constants value[0], so I keep this formula as comments to indicate how these value come from.
>>
>> [0]https://patchwork.kernel.org/project/linux-rockchip/patch/20231114112855.1771372-1-andyshrk@163.com/
> 
> thanks for referencing the source of the change.
> Leaving the formula in there was the right choice I think
> 
> That still leaves the issue with the "unused" warning.
> 
> @Christan: in the hdmi block itself can you move the 
> 	if_dclk_rate = dclk_core_rate / K;
> to the comment block please? And possibly reference the use
> of the static values in the comment message.
> 
> The if_dclk_rate var declaration at the top of the function can of course
> go away.
> 
> That way we still keep documenting how these values came to be:

Requested changes submitted via v2:

https://lore.kernel.org/lkml/20240105174007.98054-1-cristian.ciocaltea@collabora.com/

Thanks,
Cristian

