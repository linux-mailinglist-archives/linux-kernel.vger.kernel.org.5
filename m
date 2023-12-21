Return-Path: <linux-kernel+bounces-8520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427A81B8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F28C1F21362
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FB362809;
	Thu, 21 Dec 2023 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3kZuJfC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E2058227;
	Thu, 21 Dec 2023 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso1036086a12.2;
        Thu, 21 Dec 2023 05:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703166418; x=1703771218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d1tAZ8GdByb8q0+1M5iM8QIUCHX6alVx7yOZ8zoIeaQ=;
        b=i3kZuJfCn3yhFaazQkbPcbHhrgHajoXjf2+yNM4z9ldlmVZ5QV4tVZ01IsJl+D0TCr
         NtTuth/AvRz/6rzUhH5RILWlkz2HKCeV9Nyp+hBqd9NmBUZ2fq0klg1ZmntWtc+QOU9u
         JyLwv4SdzadD/X1e+nYNFNfgU5ws1hvYaSuWsSXRdTvIZx/fd9PFtUlBwxiCXpZdoHcv
         MX070QgUA2PRpjW6CNLVGWEwCWw6o4eeKvEbo5jpqoS93GnMa0yibmW0yVZhzw+XfxE0
         bNVgAECy4mp5NfbyEYsRyKDfJO+8ovUvpKKD73fd5/Tb/9aWFsqXgG/CkuRLsgmU55ia
         ksBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166418; x=1703771218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1tAZ8GdByb8q0+1M5iM8QIUCHX6alVx7yOZ8zoIeaQ=;
        b=GaBERB5x5obPL7XALxxRDK5uILBQmADjYMON4h9ipoGEaAcYU2W5nYIRvvVWpi+pAn
         QYq2xi/aRsX4NQ795u7Kh7sBTIBjcWfSoY/s5R2TD3m04oLUOxqKzRPAwCkzh3LcLhvn
         xl63fzocqRzGDxB8pypDtBQj9cdyqQ6Yf52z3Tb9HM8mWSDBiXuxrozCfDf65NjtTZ4m
         0+hVauWFkWv0khwPqX5SUwFo2AyPPfiMdayKk/xiouLKmO3LXh7namd8vwjVpTtJbQlV
         czSNx2tNyWmRkL6ILdWuSa8ZAsfll+MKyy0oWoBx9Bu+QXC4JvGyxG+S1dHYZU6EWf+N
         A/lQ==
X-Gm-Message-State: AOJu0YyhiVHzL/5NauobS+bZ2zHyOwRY6VtcidYLel3+UkTGUStVKbr+
	cdIYO4M7AKChk9MCqvo0Hg==
X-Google-Smtp-Source: AGHT+IHXd7MayCVwis6kd4X/xob72svSWV/OODq5cZ/Go8Rd7wNoGd/LEEF1HL3PA7jhTNXGBqQP7A==
X-Received: by 2002:a50:8e17:0:b0:553:68b2:31e3 with SMTP id 23-20020a508e17000000b0055368b231e3mr3672745edw.30.1703166417679;
        Thu, 21 Dec 2023 05:46:57 -0800 (PST)
Received: from ?IPV6:2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0? ([2a02:810b:f40:4300:1c49:5d1e:f6f3:77a0])
        by smtp.gmail.com with ESMTPSA id i21-20020a0564020f1500b0055344b92fb6sm1185290eda.75.2023.12.21.05.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 05:46:57 -0800 (PST)
Message-ID: <b03a7ddc-65c5-44c3-a563-d52ee938148a@gmail.com>
Date: Thu, 21 Dec 2023 14:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Add support for video hardware codec of
 STMicroelectronics STM32 SoC series
Content-Language: en-US, de-DE
To: Adam Ford <aford173@gmail.com>
Cc: Hugues FRUCHET <hugues.fruchet@foss.st.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-kernel@vger.kernel.org,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Heiko Stuebner <heiko@sntech.de>, Hans Verkuil <hverkuil@xs4all.nl>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-media@vger.kernel.org, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
References: <20231221084723.2152034-1-hugues.fruchet@foss.st.com>
 <769a1510-f8d2-4095-9879-42f413141dee@gmail.com>
 <a240d2ac-db0e-481b-8d13-3ae76cfd2fe7@foss.st.com>
 <e5ba1e14-4bbf-43e3-933a-fee6d4b90641@gmail.com>
 <CAHCN7xJ3Ktn+TnoOYdnNvKTddGCfLp4OQ+gM0WonWj-aqnsGuA@mail.gmail.com>
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <CAHCN7xJ3Ktn+TnoOYdnNvKTddGCfLp4OQ+gM0WonWj-aqnsGuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 21.12.23 um 14:38 schrieb Adam Ford:
> On Thu, Dec 21, 2023 at 7:31 AM Alex Bee <knaerzche@gmail.com> wrote:
>> Hi Hugues,
>>
>> Am 21.12.23 um 14:08 schrieb Hugues FRUCHET:
>>> Hi Alex,
>>>
>>> This is because VDEC and VENC are two separated IPs with their own
>>> hardware resources and no links between both.
>>> On future SoCs, VDEC can ship on its own, same for VENC.
>>>
>> I think that's what the driver is/was designed for :)
>>
>> I don't  think there _has_ to be a link between variants in the same file.
>> For Rockchip we only had the issue that there _is_ a link (shared
>> resources) between encoder and decoder and they had (for that reason) to be
>> defined has a _single_ variant. And there is no reason you can ship decoder
>> and encoder seperated when you have two variants (with different
>> compatibles).
>> For Rockchip and iMX those files are even containing variants for completly
>> different generations / different SoCs. I had to cleanup this mess for
> The i.MX8M Mini and Plus have different power domains for encoder and
> decoders as well as different clocks.  Keeping them separate would
> almost be necessary.
I guess there is missunderstanding: I didn't say the two STM variants
should be merged in one variant, but the two variants should be within the
same _file_, like the other platforms are doing :)
> adam
>
>> Rockchip once - and it was no fun :) Anyways: It's up to the maintainers I
>> guess - I just wanted to ask if I missunderstand something here.
>>
>> Greetings,
>>
>> Alex
>>
>>> Hoping that this clarify.
>>>
>>> Best regards,
>>> Hugues.
>>>
>>> On 12/21/23 13:40, Alex Bee wrote:
>>>> Hi Hugues, Hi Nicolas,
>>>>
>>>> is there any specific reason I'm not understanding / seeing why this
>>>> is added in two seperate vdec* / venc* files and not a single vpu*
>>>> file? Is it only for the seperate clocks (-names) / irqs (-names) /
>>>> callbacks? Those are defined per variant and perfectly fit in a
>>>> single file holding one vdec and one venc variant.
>>>>
>>>> Alex
>>>>
>>>> Am 21.12.23 um 09:47 schrieb Hugues Fruchet:
>>>>> This patchset introduces support for VDEC video hardware decoder
>>>>> and VENC video hardware encoder of STMicroelectronics STM32MP25
>>>>> SoC series.
>>>>>
>>>>> This initial support implements H264 decoding, VP8 decoding and
>>>>> JPEG encoding.
>>>>>
>>>>> This has been tested on STM32MP257F-EV1 evaluation board.
>>>>>
>>>>> ===========
>>>>> = history =
>>>>> ===========
>>>>> version 5:
>>>>>      - Precise that video decoding as been successfully tested up to
>>>>> full HD
>>>>>      - Add Nicolas Dufresne reviewed-by
>>>>>
>>>>> version 4:
>>>>>      - Fix comments from Nicolas about dropping encoder raw steps
>>>>>
>>>>> version 3:
>>>>>      - Fix remarks from Krzysztof Kozlowski:
>>>>>       - drop "items", we keep simple enum in such case
>>>>>       - drop second example - it is the same as the first
>>>>>      - Drop unused node labels as suggested by Conor Dooley
>>>>>      - Revisit min/max resolutions as suggested by Nicolas Dufresne
>>>>>
>>>>> version 2:
>>>>>      - Fix remarks from Krzysztof Kozlowski on v1:
>>>>>       - single video-codec binding for both VDEC/VENC
>>>>>       - get rid of "-names"
>>>>>       - use of generic node name "video-codec"
>>>>>
>>>>> version 1:
>>>>>     - Initial submission
>>>>>
>>>>> Hugues Fruchet (5):
>>>>>     dt-bindings: media: Document STM32MP25 VDEC & VENC video codecs
>>>>>     media: hantro: add support for STM32MP25 VDEC
>>>>>     media: hantro: add support for STM32MP25 VENC
>>>>>     arm64: dts: st: add video decoder support to stm32mp255
>>>>>     arm64: dts: st: add video encoder support to stm32mp255
>>>>>
>>>>>    .../media/st,stm32mp25-video-codec.yaml       |  50 ++++++++
>>>>>    arch/arm64/boot/dts/st/stm32mp251.dtsi        |  12 ++
>>>>>    arch/arm64/boot/dts/st/stm32mp255.dtsi        |  17 +++
>>>>>    drivers/media/platform/verisilicon/Kconfig    |  14 ++-
>>>>>    drivers/media/platform/verisilicon/Makefile   |   4 +
>>>>>    .../media/platform/verisilicon/hantro_drv.c   |   4 +
>>>>>    .../media/platform/verisilicon/hantro_hw.h    |   2 +
>>>>>    .../platform/verisilicon/stm32mp25_vdec_hw.c  |  92 ++++++++++++++
>>>>>    .../platform/verisilicon/stm32mp25_venc_hw.c  | 115
>>>>> ++++++++++++++++++
>>>>>    9 files changed, 307 insertions(+), 3 deletions(-)
>>>>>    create mode 100644
>>>>> Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>>>>>    create mode 100644
>>>>> drivers/media/platform/verisilicon/stm32mp25_vdec_hw.c
>>>>>    create mode 100644
>>>>> drivers/media/platform/verisilicon/stm32mp25_venc_hw.c
>>>>>

