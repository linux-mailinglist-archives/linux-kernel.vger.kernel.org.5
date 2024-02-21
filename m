Return-Path: <linux-kernel+bounces-74810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9C85DB27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 793C3B26884
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6613F7C08B;
	Wed, 21 Feb 2024 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQGe8UlL"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0277BB18
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522650; cv=none; b=K3NkoBpOwhBUWtlDEuQfsoiAzmRdeLRzCc+xBRC8wfmlgx7Xtr9h9Pf0BEJszXLOAs59HtFN2I7aC8jeSJPAvdn5mREoGpO09LGErT0zgGGkzNFARAqbe6Cib6+1cfpzd5hnLoVn7X6qllWh9LBpkVpJr4tSIbapLs5VGtgK8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522650; c=relaxed/simple;
	bh=rdN/6YII7vuoqoQ0M/mdYu6Vc/hmpn03eQ0O+V4PSVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjPdXUPd7EvqlcuW9o2zBUOid13veaJocn3lX7f+EVSZnHlqMu7+q82X5P8B7GEVZj1cHHJq6aqQNBU+daYDuz9TJVGmxQuAQ1gc25FnbOmYEvolfWPX+z8LMJZWgLzZY0/aA8nTV8ryExpmU0DSOfquF2ItCzMEMU43YMrxKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eQGe8UlL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3122b70439so829169966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708522647; x=1709127447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5eajfoTymGJwv3pZSD39+xNRSQER4xqy/S/sNmOZC4U=;
        b=eQGe8UlLa0rrKWQiw4jViMGv/0vi3l580D9u7GdG3dTBr5+vBKAyPV+BJ2iZcGbMiS
         1HNfOmjBjJIvQA028HiuV9TeV7UpuGu/afDCO+MhdqRJnd95dRKm12BKSdZ2r9ORGrrZ
         2E0eSpitx/Y9zdzgmTPNlZ7qBYNicg/cyaRKCl/P8KxNeJIZJgnn2LRJGSNzlgniUjFs
         heH9kL6C5+RUqsBB+i0RuCEiMekEHVQ2Aj85sw6fJ6LeGd7Bp53P1zLiaabHa39riIcm
         LXvLAFdhrljy7D6rVjj/mIJ4B2iZSrsMeO8DpCtshwweGpJaX6dcQMUnm8uDXKzp2/HO
         FagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708522647; x=1709127447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eajfoTymGJwv3pZSD39+xNRSQER4xqy/S/sNmOZC4U=;
        b=Bhk4TWWsI0P6om07tjaVMVoWgPF7xL3jagiYp+JmHj+b1D75layQOnSNmcoZlKDgiH
         6S5LVnTn81Mwy2kuw2fHo17NOIiBKUc/FTRcAYZoAtB2WqutDQ0xkXMC+TWf/BXzJMf7
         ZhJd+i/nj8WGweh9/3aT6rtxe4tVwB9s068Tr/iyLQqqHBprvhg7YAGonvULfaYbX3ho
         L37AGBEnBdyMLJaUC/QbThYC78KcOxexcRIa/LwnynYvbQHDqafUY0cIi78fLldTC0C+
         ONWZKMiD0e2m+O9rdeJxTDyqvjA/LosPiqvb3N75nnI9ZQ+5w3W0zZTEXDjr+WFaYK6K
         u+iw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcW/UCLGFveUJfOcbJ2bA2wZqOlYqBuJ3huN3mk6rbIUGT4dLZHO8iD+FFP7E9dIAKS/uUNWGzp7qnkBiLyxK3y4XmRdIiU69bK2r
X-Gm-Message-State: AOJu0Yx/BHeuqXo77tNpcLTDWoqDKS80JXNlfYMQx7rmlP06nbi2yRbh
	Xsh6L0LqZ1HUhnq6Er3r4cNrTDfhxxAQX7ua1I7QRkBEwheT/txGz1Nyszea4gQ=
X-Google-Smtp-Source: AGHT+IEIgR3cQ74TYoZyC61RuNeT+e7u1BkGFZFDGxQOH8KvSD7It6YYbD0Q2EyO71OLMdDyo8yuQg==
X-Received: by 2002:a17:906:48cc:b0:a3e:6501:339d with SMTP id d12-20020a17090648cc00b00a3e6501339dmr6557544ejt.61.1708522647151;
        Wed, 21 Feb 2024 05:37:27 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b00a3e059c5c5fsm4970319ejc.188.2024.02.21.05.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 05:37:26 -0800 (PST)
Message-ID: <466efa71-bd42-46b7-b81f-2a70d80e3f03@linaro.org>
Date: Wed, 21 Feb 2024 14:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/20] media: venus: pm_helpers: Use reset_bulk API
Content-Language: en-US
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-20-3dac84b88c4b@linaro.org>
 <a25224f5d28aa65e8bfd14fe0a8f599b9f9e3f40.camel@pengutronix.de>
 <ad20b872-0b50-4a16-b342-582d2f33eeca@linaro.org>
 <1cf19cf23ffd88d9ffb673e8f382f3b1d24545bb.camel@pengutronix.de>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1cf19cf23ffd88d9ffb673e8f382f3b1d24545bb.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2024 14:34, Philipp Zabel wrote:
> On Mi, 2024-02-14 at 22:20 +0100, Konrad Dybcio wrote:
>> On 14.02.2024 14:31, Philipp Zabel wrote:
>>> Hi Konrad,
>>>
>>> On Fr, 2024-02-09 at 22:10 +0100, Konrad Dybcio wrote:
>>>> All of the resets are toggled together. Use the bulk api to save on some
>>>> code complexity.
>>>>
>>>> The delay between resets is now correctly determined by the reset
>>>> framework.
>>>
>>> If this is a recent change, could you reference the commit?
>>
>> It's a series that recently landed in -next [1]
> 
> Missing link?

Yes, sorry!

Konrad

[1] https://lore.kernel.org/linux-arm-msm/20240105-topic-venus_reset-v2-0-c37eba13b5ce@linaro.org/



