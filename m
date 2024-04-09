Return-Path: <linux-kernel+bounces-137461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4189E273
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAAC1C22C0B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B374156C6C;
	Tue,  9 Apr 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnTCnBnr"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8AC156C4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686944; cv=none; b=aWBTnRU62iBLGIfEV0EIfZo6qmsGCs3sAOtwEMF4PXXmIQTxrpFsVVTKipDzIaIO7pogChVH+AyHEjJ0e4SC9QGQwlbLG6M5sy9Y1id0AXmWZc9B6QOCmSP7iZ2i5pXkgoRWHA3fhTDnVDsseGwZzeTtZK3jBkI9kNNI6BfaSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686944; c=relaxed/simple;
	bh=R9DZNLUvihF/0j3bu67pYVxV0LWbPEJ6hRj4T6N26Uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcrfu7DvVF+MilQFzNp1d1mMGFoom9IGKiD2TXcDKX+ROQ2/9RT6IymFs2luEUBDzfnfZ0/1uZFas9XME1gl47pQCGDBVIy+cJBXvz5+nM8MEgb4mWY3XXp/+6nJ1i4vWQjfwiG5PkuEM8OQ16nfpfKWmr6lEB+ljm7zO1zUuVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnTCnBnr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-516dbc36918so4318993e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712686940; x=1713291740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqU5kinVkYgX6Ul5/vMEToQj2v8t2TlPxIkdUFIbDKA=;
        b=WnTCnBnrqZycYn7QEm/5YqiVrH08CvCVgEsC62IUioola1C2GkpY0jdXbPP3c/8x2C
         hApP2bAemZ6zbyvNzub0Z+lP1MZLkTtaTRL0jmVxlVb1ecBPd/JZegcipPbe8H9mfoKm
         lwhkAT8cJ15fliWfxhYULfZfGu1qhPwrQb08Qzjy6h9PgRwGAeqBBvBV/voY5xbTxltv
         gzCZ9xH56IT9os0W8RT2OJ6+WzkE7vlc0mmerm8v8nQx/z5Eud7Q4dGIxGvhWcSXA4qq
         3tVheNOMWfcEY0ffjqcAbbSBIES/D1qUQ5/3yvGzXVnGtu6JaoRT9QnapiyxvxxH2BJK
         FJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686940; x=1713291740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XqU5kinVkYgX6Ul5/vMEToQj2v8t2TlPxIkdUFIbDKA=;
        b=km9k1/bEPl9NoA9X8sem4go211l+6NWZIWjHUM6I2Yx6BAN+b+8YjAjaFhrlKwXh1i
         WanjT4Nr8Kqn5eO7bt1Ve5yKzgB5xeb228th5PXvwfk31+J3b+AE8ayqcBTPW2drkOSD
         ZWd8U5yBi0m/AYhJy2YNrUY4jL8bAfC4mwcJm6tLZef/xXIZQwa6lldZe3XJ06E6JrP5
         eiN8cGbUmkU0gTe6QdUCbEpB8Cqn7n+64uRs2SrAbszVbm9uwP5U53evdAbeIJehPVap
         Jn8kramu9BfKgVV8ymwa6psSS2fwOIia9JF863fSnxCwjUhmoMHGGjblPrZMUBO1ohHk
         CiEg==
X-Forwarded-Encrypted: i=1; AJvYcCX9KyC2Yw04o4xWie27imQZbiExAr0tg7cBrIjpBdCoHEkS+BPrgqZ+WuChKHAQ4+ZuvfVz2MyCOPd6vRsqtEWR9ssnj35oaTUkHdU5
X-Gm-Message-State: AOJu0YyYgkGEihGrcEY7HASyY0gBZ3xoa7j5Uw7HjvYisuuVxg5ME1YN
	6Hj+MIbdJ7lFlLUTWsCpPzwsDdiuDzYXhEc9JjCjmT9/13enqNSVCAUKHLkVm9s=
X-Google-Smtp-Source: AGHT+IF8WoDWjHVt9X8A67BNNBX6KY67tFf3C7LO/8eXvn8MdtBStRcN0SEflWbW6WpVON+EE16RYA==
X-Received: by 2002:a05:6512:3ca5:b0:516:c099:e785 with SMTP id h37-20020a0565123ca500b00516c099e785mr202781lfv.20.1712686939738;
        Tue, 09 Apr 2024 11:22:19 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w1-20020ac25981000000b00516d6924bc6sm1503203lfn.175.2024.04.09.11.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:22:19 -0700 (PDT)
Message-ID: <b4c56cad-0a3c-4b74-b9fa-0931204d1514@linaro.org>
Date: Tue, 9 Apr 2024 20:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
 <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
 <66492657-3649-3bdb-b7df-0f5196418e06@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <66492657-3649-3bdb-b7df-0f5196418e06@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 14:44, Vikash Garodia wrote:
> Hi Konrad,
> 
> On 4/5/2024 1:56 PM, Dikshita Agarwal wrote:
>>
>>
>> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>>> To make it easier to understand the various clock requirements within
>>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>>
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> index ac7c83404c6e..cf91f50a33aa 100644
>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> @@ -23,6 +23,34 @@
>>>   
>>>   static bool legacy_binding;
>>>   
>>> +/**
>>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>>> + * @core: A pointer to the venus core resource
>>> + *
>>> + * The Venus block (depending on the generation) can be split into a couple
>>> + * of clock domains: one for main logic and one for each video core (0-2 instances).
> s/main logic/controller. Applies to below places as well.

Ok - so "controller" is the cortex-m3 (m5?) that power-sequences
the DSP etc.?

> 
>>> + *
>>> + * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
>>> + * domain, so this function is the only kind if clk_get necessary there.
> To be checked, unable to get the clock document to see why only core clocks 
> (VENUS0_VCODEC0_CLK). Will update.

FWIW 8916 only has GCC_VENUS0_VCODEC0_CLK (and _SRC) and AHB/AXI/TBU clocks,
no (currently registered) clock for the entire block.

> 
>>> + *
>>> + * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
>>> + * statically defined a decoder and core1 an encoder, with both having
>>> + * their own clock domains.
>>> + *
>>> + * SDM845 features two video cores, each one of which may or may not be
> s/two video cores/two identical video cores
>>> + * subdivided into two encoder/decoder threads.
> decoder cannot be split into core threads. you can keep it like "each of which
> is capable to do any encode or decode"

So it's not about any splitting, but rather the ability to do both encode
and decode, sort of like how the displayport controller can nowadays do both
eDP and DP, depending on what init data you send to it?

> 
>>> + *
>>> + * Other SoCs either feature a single video core (with its own clock domain)
>>> + * or one video core and one CVP (Computer Vision Processor) core. In both cases
>>> + * we treat it the same way (CVP only happens to live near-by Venus on the SoC).
>>> + *
>>> + * Due to unfortunate developments in the past, we need to support legacy
>> why unfortunate? please re-phrase this.
>>> + * bindings (MSM8996, SDM660, SDM845) that require specifying the clocks and
>>> + * power-domains associated with a video core domain in a bogus sub-node,
>>> + * which means that additional fluff is necessary.
> Some background:
> It was done that way to support decoder core with specific clocks and similarly
> for encoder. Earlier architectures use to have different clock source for these
> specific decoder/encoder core clocks, now there is a common clock source for
> both the cores. Hence if any one is enabled, others gets enabled as it is
> derived from same source.
> So if we see the later bindings, the clocks were moved out of sub node to main
> venus node.

Yeah and I don't really see the reason why the binding needed to be changed
for this, you can simply get the clocks by name and poke at the specific clk*
(or an array of them), no matter where they were _get()-ed from.

Konrad

