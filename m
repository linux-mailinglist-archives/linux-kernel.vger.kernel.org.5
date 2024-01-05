Return-Path: <linux-kernel+bounces-18083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF72825899
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD6261F233E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93631735;
	Fri,  5 Jan 2024 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TojGoyr/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FA2E84A;
	Fri,  5 Jan 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55739500b39so605632a12.0;
        Fri, 05 Jan 2024 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704473243; x=1705078043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GhoWygouKwNF/i+Ar+uHKGYE9ZPPakZhcuyJ3HA+yM=;
        b=TojGoyr/pXqP9E4i0NJW+bJlS6MSm8U3Tmd8FcrteiIMP4gXAwUfap7keQbOIwzPHj
         M9ZfUCZoackAL/csP8lfvqU/05ensxDaaNz4j0EFFWrbnKDq2ba8jq77Nhcgbj7YI+Y2
         ulTvCs7VCCPv5sWBEkYmzkdqM5rCdz7HuUXRi197DQgCNQ5mjAWgWnNaQVCNFY0fQF+M
         CVilh6p4u23E2ZNAXqnGfexsCNgkeIPmGSqVbiKq97zzPrrgVHLFFA50ZeawmTWBU1yb
         YnDATvJXkvk7aR9rgbYs16HmQvXbmBoV3Fu5QxdknJyHuXx1sffGseT+fhxo4oWNe74E
         9F/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704473243; x=1705078043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GhoWygouKwNF/i+Ar+uHKGYE9ZPPakZhcuyJ3HA+yM=;
        b=PTjUGTuec/S3jHSueTDPAhoKb9pOXhtSlpsYY1WvR9IfX82TxUu5nx/1ECI9oLhi9O
         8LZ87PDE79LUVoFu5twRikX2b5J54edCGzkN5swHg60U+tKDslCRRKpGMPMY1iKhIKhv
         U6eRQKkSaZZyDNJPupbCJZq8EwK2/D9VHA2fx/CmyTUzR8W9K99J6xZ1WX+1CNZMS83j
         7/XvPAaozN9NYM36KztKI/j0OZYCQR/WvWiPwQkdwI0NC0aAOXU7l7s55UuxjMAhp4HR
         eb8QCP99SahM+W6tJy9tEE/G1Tz0lIqQIWw2Dx9Ylh8S/TfR2p5Svlfck3jdsk1khdsb
         ySzw==
X-Gm-Message-State: AOJu0YxzzXAJbWf23q8kmFRgKYA7/8iBf+adfI95wimQf4r1pp/4Z7XQ
	PtWenfrhyU88iJSimTW4EiU8BmrK0g==
X-Google-Smtp-Source: AGHT+IEmqVeHlv3hQC7rMHa0U1jc6f1uX/xyuXiZ6rLuFGn1h9XpROfBTFyH9I651Ze1bS12LJUPyw==
X-Received: by 2002:a17:906:2853:b0:a27:a258:f340 with SMTP id s19-20020a170906285300b00a27a258f340mr1240311ejc.65.1704473243418;
        Fri, 05 Jan 2024 08:47:23 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:890b:36c3:934f:6f56? ([2a02:810b:f40:4300:890b:36c3:934f:6f56])
        by smtp.gmail.com with ESMTPSA id r11-20020a1709062ccb00b00a26aa845084sm1064504ejr.17.2024.01.05.08.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 08:47:23 -0800 (PST)
Message-ID: <3e7aa9f2-6e37-44c3-9361-5fa7c4ef203d@gmail.com>
Date: Fri, 5 Jan 2024 17:47:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 00/29] Add HDMI support for RK3128
Content-Language: en-US, de-DE
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Sandy Huang <hjc@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>
References: <20231222174220.55249-1-knaerzche@gmail.com>
 <170435598418.3166964.9367277671989164237.b4-ty@sntech.de>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <170435598418.3166964.9367277671989164237.b4-ty@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Heiko,


Am 04.01.24 um 09:14 schrieb Heiko Stuebner:
> On Fri, 22 Dec 2023 18:41:51 +0100, Alex Bee wrote:
>> This is version 4 of my series that aims to add support for the display
>> controller (VOP) and the HDMI controller block of RK3128 (which is very
>> similar to the one found in RK3036). The original intention of this series
>> was to add support for this slightly different integration but is by now,
>> driven by maintainer's feedback, exploded to be a rework of inno-hdmi
>> driver in large parts. It is, however, a change for the better.
>>
>> [...]
> Applied, thanks!
>
> [23/29] drm/rockchip: inno_hdmi: Add variant support
>          commit: 5f2e93e6719701a91307090f8f7696fd6b3bffdf
> [24/29] drm/rockchip: inno_hdmi: Add RK3128 support
>          commit: aa54f334c291effe321aa4b9ac0e67a895fd7b58
> [25/29] drm/rockchip: inno_hdmi: Add basic mode validation
>          commit: 701029621d4141d0c9f8b81a88a37b95ec84ce65
> [26/29] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
>          commit: 50a3c772bd927dd409c484832ddd9f6bf00b7389
>
>
> For reference, Rob has applied the rk3128 compatible in
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=21960bda59852ca961fcd27fba9f92750caccd06
thanks for keeping track on this.

Is there any reason the DT paches aren't merged yet? From what I can see
they should be fine to be merged in your v6.8-armsoc/dts32 branch which is
6.7-rc1 based. There was only a txt-binding at this point and it's very
likely that both the rockchip,inno-hdmi.yaml-conversion and the rk3128
additon will both land in 6.8 (they are both in linux-next). Linus' 6.8
merge-window will open earliest next week.
I'm really not pressuring here and I'm fine if they land in 6.9 - it's just
for my understanding for further submissions.

Alex

>
> Best regards,

