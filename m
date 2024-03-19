Return-Path: <linux-kernel+bounces-107327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BC87FB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05D61F21D08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052767E11E;
	Tue, 19 Mar 2024 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJju4ed9"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EBA7D079;
	Tue, 19 Mar 2024 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841877; cv=none; b=EXdhtMRsOzi3QHa3TJNWggn72rhpXqp5uz3XjgeyHt1yby0lFSrTveGNmD2ujHRVxfT7EcISZ48N6F5lzlB2iKBtDBpAyGdAqoLpiwf7h2F7IMhpeoFMX5bxHoerAdVuJ1HzFuhiRmimV4BsRPn+WoPfNv2h9UhPOR69iHUgYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841877; c=relaxed/simple;
	bh=JxehcCxVCci9hB9vvRL4/kO7jeL7y8Ew7zyQWMJsRtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOOZWnheGyhYWAkp69RpDFoGRaGw3vzqOxv73/hby0hML3rnFKUVd43K9TQdQMWh9fGSPePP4J0mBsvajGIX0K7GaCNF8C5SD2YSGr9O5C51W7i4P8KNWA1rss54hDkWOvvW10deSjKJHlUheSAQQBNK4EVsvePLY5jZQiZE65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJju4ed9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso7101221a12.2;
        Tue, 19 Mar 2024 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841874; x=1711446674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiOL3ZeQ5p28cPkTjDX06bUoAopPTJOQ4KCn7hfnHCM=;
        b=cJju4ed9RJVxQpRcsBplvXbe8T59yRsdvFxynoIMfqfFh+xRSwCNbA5AiFirXH1v+W
         7E+fzRoC7aN10zDCeEFt5kD6LP299TbpCZe+zDMATer8sVjZqbQnuWvlpuVA4+EOHcCV
         YOQSBbACdJKXTXKZmN7iDbIgHyHU2JUn1LIt2Smku7ylPyrF3xrjwPIuurEuKh58SgKa
         YSLefQuFBg12A9lB3avKzcz5eB0hpZhV4huxj2GG5gbhrGDY8WyLlCCOsb1rsPynHlH5
         9aORxUF7HDN9KkPzQUq9Pw0ftKxNleisYLxxJWsZkpoRzRwuByChmvk1Imn81h3EUtlQ
         m1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841874; x=1711446674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiOL3ZeQ5p28cPkTjDX06bUoAopPTJOQ4KCn7hfnHCM=;
        b=IpFOFZSnW/7tuFrNsYXKALfzpERhiJ1bRDU9GKP6O5f2eb8ddHYXZsraRppGz3jF62
         YoplE6EMHGNTgOBCxDV7r2b32HMgamzXJ5kZ7G4VOZH+/kTaKZFTLwPDrH8pw5fyeDa+
         N3g/ZRMoTVSsS6qygm7NK8j0LiXV02DmjgQlPE0nsPrOfPTkw09i+OQeQT6rT3PtBhDS
         8jok8ZrSyDOmaZebz5hcf30tnc6GCSBswljDqaCTPv3PfKyuyNst0MzTfxeSb3ITOesU
         3uqYOIAfvgTgVU6NytCML47tWAXR4XFozHobBtAOKSCA5qMwLsvKwE0Uu1jQmpWAJqLJ
         bupg==
X-Forwarded-Encrypted: i=1; AJvYcCX6vBLJT7oFivagErLf6Tnwk6wRJbIhWp6RLxr93nQRAZhGp7KyLpXIeQk2ujxUGJKvO1QYe/QuwzgdzyoJcamYCW6oBo1o4CmRtQZzCkbfFnP4bWRuzknbyvWQywFQiu1ZWdHfKY0+SHIrzS+DGhPebHu1hqRaON+EAzt6rk+Y6tsBZqOIaw==
X-Gm-Message-State: AOJu0Yx93qqjfWCjLFseyFlhjptSlRY8exUu7ptL5yqIdkVQKN6AYBHy
	iknrIVpPpYpzxBoC4/a9e/ns+OeCrQZq+Ve7QhsMP6E0N0U2nRcV
X-Google-Smtp-Source: AGHT+IGaNa8MmH5VMvbhTYffho95xdFBcg4tILM5madmPt8uqxtbEjuaqvHFZp+/KevR/1JD/RhVSg==
X-Received: by 2002:a17:907:369:b0:a46:22fc:74d3 with SMTP id rs9-20020a170907036900b00a4622fc74d3mr1100248ejb.72.1710841873873;
        Tue, 19 Mar 2024 02:51:13 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id hg9-20020a1709072cc900b00a46aef32642sm3149493ejc.170.2024.03.19.02.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:51:13 -0700 (PDT)
Message-ID: <b7467362-354b-460d-83b3-ced871c775d1@gmail.com>
Date: Tue, 19 Mar 2024 10:51:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] clk: qcom: apss-ipq-pll: use an 1-D array for Huayra
 pll register offsets
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com>
 <20240318-apss-ipq-pll-cleanup-v1-2-52f795429d5d@gmail.com>
 <CAA8EJpo2Vo-XqstNk69dWW8pqNkGi0tz3UmHY7j6LLKd-yH22w@mail.gmail.com>
 <09c91419-8bce-49dc-86d1-3ed1b9f28ee6@gmail.com>
 <CAA8EJpq+PUavezxAwpStm98_3uW7HQraFyUdr6uwZCNHJ4yU5w@mail.gmail.com>
Content-Language: hu
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <CAA8EJpq+PUavezxAwpStm98_3uW7HQraFyUdr6uwZCNHJ4yU5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 19. 1:09 keltezéssel, Dmitry Baryshkov írta:
> On Mon, 18 Mar 2024 at 23:23, Gabor Juhos <j4g8y7@gmail.com> wrote:
>>
>> 2024. 03. 18. 15:16 keltezéssel, Dmitry Baryshkov írta:
>>
>> ...
>>
>>>> +static const u8 ipq_pll_huayra_regs[PLL_OFF_MAX_REGS] = {
>>>> +       [PLL_OFF_L_VAL] = 0x08,
>>>> +       [PLL_OFF_ALPHA_VAL] = 0x10,
>>>> +       [PLL_OFF_USER_CTL] = 0x18,
>>>> +       [PLL_OFF_CONFIG_CTL] = 0x20,
>>>> +       [PLL_OFF_CONFIG_CTL_U] = 0x24,
>>>> +       [PLL_OFF_STATUS] = 0x28,
>>>> +       [PLL_OFF_TEST_CTL] = 0x30,
>>>> +       [PLL_OFF_TEST_CTL_U] = 0x34,
>>>>  };
>>>
>>> Can you please move this to clk_alpha_pll? We can then drop it from
>>> clk-cbf-8996.c too.
>>
>> Sure, I can do that. By any chance, do you have a suggestion for the name of the
>> new enum value to be used in the clk_alpha_pll_regs array?
>>
>> CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ seems too generic, and it would be a bit
>> misleading using that for MSM8996 CBF.
>>
>> CLK_ALPHA_PLL_TYPE_HUAYRA_IPQ6018_A53 is quite long and it is also misleading.
>>
>> Maybe we could use CLK_ALPHA_PLL_TYPE_IPQ6018_A53 which is short and unique
>> enough and we could add an alias for that like CLK_ALPHA_PLL_TYPE_MSM8996_CBF or
>> something similar.
> 
> HUAYRA_APSS ?

Ok, sounds good.

