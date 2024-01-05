Return-Path: <linux-kernel+bounces-18117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B5F82591A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33012285600
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40E6321B6;
	Fri,  5 Jan 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/h7HmRL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D634565;
	Fri,  5 Jan 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55739500b39so648813a12.0;
        Fri, 05 Jan 2024 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704476015; x=1705080815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fvRwdXp7STtyfwmA3TQz9ECnNAh+xTP7eSbKgSeWVxM=;
        b=e/h7HmRLeybLvD+M4D6177RZhmRM3NhDOUKkPUoaLHeV2079bawZnr95dENw6VZ6D6
         wvrtLBQ39YosdqjyWNRf/JOfF1tlPwDMnmuQ/yeU9ucLaBt1IPw37DyhCZLTAyb4o1t0
         fBwA3pVWHoumR4C6qoRG8pKUMsPpx6Y/gqk2ZixBlEhnYMXy9IUtYOfhN5RCfvuszr2l
         FPDiNPJoldyFY4yGTS9uQnhFUnj7y8VoU+7tZrkZgadBykeB9anuPkbPQZQIQFk9Dq0r
         cUbJPhS47jme52FFyek1+XYrLo6OaDu5gEkM8nm8H3CjR9ixkidzBvYyP13HUqE2HC5f
         TSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704476015; x=1705080815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvRwdXp7STtyfwmA3TQz9ECnNAh+xTP7eSbKgSeWVxM=;
        b=mbI5dmUZHoqd5CCBHy5e3C05RpRdOtHGAQrm0VvwHiiyAwWzHXE689q2RfgeJXnkSc
         W5MwQqIyVmOsdcgQPMELFlAA7m6TBgOdN7gOy8F+0F1G15gqMFqm6Eapt8TmoeStCV5W
         QcW7gxw2R8vkrAp1P/tEUxoi3Nu/QIVjkGdkt6curEdqGP8SF8Ox/XkqXY2dDF418Q9a
         Pr8/FWoJvXChrX/4ueyEU5gK6z2iFzUE2X2601huQQar168ksdD5kjm0oAuQXSK3poEC
         OoxV5n4RHdQAvLlDsQMIT9Tkgl18VeV1SFKcgIzvZf4aj83i2NiXv4cU55GqeZoJC2Fo
         gZPA==
X-Gm-Message-State: AOJu0YwJOsFSM5s7oi+6MHcxeZTfIHUONvGc7Qj+f3CbJKD8hn+6rfwe
	XEMWCeQWXGCCuis1ZYSHFw==
X-Google-Smtp-Source: AGHT+IG2qdAwRrF2BoWjNp5Yp1uIidtzoXmQan0J2+VlX6wkeQ0tdJCag6miAoGA8iKd/ZQLd4emvg==
X-Received: by 2002:a17:906:4116:b0:a29:1648:6030 with SMTP id j22-20020a170906411600b00a2916486030mr771950ejk.86.1704476015535;
        Fri, 05 Jan 2024 09:33:35 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:890b:36c3:934f:6f56? ([2a02:810b:f40:4300:890b:36c3:934f:6f56])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090791d800b00a235b01886dsm1102895ejz.10.2024.01.05.09.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 09:33:35 -0800 (PST)
Message-ID: <31af9449-67df-4a1d-942c-60405f653409@gmail.com>
Date: Fri, 5 Jan 2024 18:33:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 00/29] Add HDMI support for RK3128
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
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
 <3e7aa9f2-6e37-44c3-9361-5fa7c4ef203d@gmail.com> <2568547.3Lj2Plt8kZ@diego>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <2568547.3Lj2Plt8kZ@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 05.01.24 um 18:02 schrieb Heiko Stübner:
> Am Freitag, 5. Januar 2024, 17:47:21 CET schrieb Alex Bee:
>> Hi Heiko,
>>
>>
>> Am 04.01.24 um 09:14 schrieb Heiko Stuebner:
>>> On Fri, 22 Dec 2023 18:41:51 +0100, Alex Bee wrote:
>>>> This is version 4 of my series that aims to add support for the display
>>>> controller (VOP) and the HDMI controller block of RK3128 (which is very
>>>> similar to the one found in RK3036). The original intention of this series
>>>> was to add support for this slightly different integration but is by now,
>>>> driven by maintainer's feedback, exploded to be a rework of inno-hdmi
>>>> driver in large parts. It is, however, a change for the better.
>>>>
>>>> [...]
>>> Applied, thanks!
>>>
>>> [23/29] drm/rockchip: inno_hdmi: Add variant support
>>>           commit: 5f2e93e6719701a91307090f8f7696fd6b3bffdf
>>> [24/29] drm/rockchip: inno_hdmi: Add RK3128 support
>>>           commit: aa54f334c291effe321aa4b9ac0e67a895fd7b58
>>> [25/29] drm/rockchip: inno_hdmi: Add basic mode validation
>>>           commit: 701029621d4141d0c9f8b81a88a37b95ec84ce65
>>> [26/29] drm/rockchip: inno_hdmi: Drop custom fill_modes hook
>>>           commit: 50a3c772bd927dd409c484832ddd9f6bf00b7389
>>>
>>>
>>> For reference, Rob has applied the rk3128 compatible in
>>> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?id=21960bda59852ca961fcd27fba9f92750caccd06
>> thanks for keeping track on this.
>>
>> Is there any reason the DT paches aren't merged yet? From what I can see
>> they should be fine to be merged in your v6.8-armsoc/dts32 branch which is
>> 6.7-rc1 based. There was only a txt-binding at this point and it's very
>> likely that both the rockchip,inno-hdmi.yaml-conversion and the rk3128
>> additon will both land in 6.8 (they are both in linux-next). Linus' 6.8
>> merge-window will open earliest next week.
> Exactly ... and the arm subarchitectures (Rockchip, etc) feed into the
> more generic soc-tree[0]  and from there in a set of pull requests.
>
> Normally everything needs to go to the soc tree before -rc7 .
> With the whole xmas stuff, I sent some stragglers in a second pull
> request on monday, but that was already before Rob applied the
> binding on tuesday.
>
> So 6.8 devicetree stuff is essentially done and the dts patches
> from this series will go in to 6.9 .
>
>
> Hope that explains things a bit :-)
I assumed (for some reason) that sub-architecture maintainers are allowed
to send PRs to the respective upper tree until the merge window opens and
"all the rest" is done within this  ~2 weeks.
Thanks for explaining.

Alex
> Heiko
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/
>
>> I'm really not pressuring here and I'm fine if they land in 6.9 - it's just
>> for my understanding for further submissions.
>>
>> Alex
>>
>>> Best regards,
>
>
>

