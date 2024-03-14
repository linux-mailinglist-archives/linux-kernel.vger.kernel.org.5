Return-Path: <linux-kernel+bounces-103323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5A87BE12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63FA01F230C6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CD6EB79;
	Thu, 14 Mar 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0ga1FK5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3125B5DD;
	Thu, 14 Mar 2024 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424377; cv=none; b=TvqIoMPoiKFT3OzNFLB+bg6Y+MWXvh5afSh8DAmtcFf0Rq2PZvoeNQnMMlKYvbKRrI1A3sU74KAy4ZH7OKv0hAjgzpc0M4OWm5sqnZUZDXid4dYE7Uo+JwYuQGUE6hvHmkcgOHu7bmzrjkz3BgmAIqwiqmk+9ayIUw8JkElWMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424377; c=relaxed/simple;
	bh=dzagUUNASVzuZpjkvZI9csv9wyIfQ6jRNw4sLWIkiEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1+1pPKX0uvfyHDhkIdXKuwBz4vNoxGlZPYGdCH7AcBTEt0WSHR/REy43Yxypr+lm2JV18ZQAFR1QlqzQEVBzJSTPu7akQWHLevm1BPyBly8h191Xrd7vAdFsdePlvYHcMUaEEpYW0iyOBERFMfnsxYVb3EWnle4iXRm6Wc9yHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0ga1FK5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33e9dfd343fso569477f8f.0;
        Thu, 14 Mar 2024 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710424374; x=1711029174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIl4vzYLu7H92myngevMJEPjqZCqCBPhgfD/SqnC3pE=;
        b=K0ga1FK5wV5hXkvHxoqzBM0QrCO55eO4zlvCthw1aRUnOSOwY+kUIdguKXRIFzrWOn
         zrnIPUMYR4/9877vssF/EjLpQ46yA4xwRlDovwIsyTSyb84jClNdVuuHO0B/NAxEE1CD
         mvtu1I3FrLfWdFt8LtH1XsmE5RQMp27mjG1REOLBKYXqkYpAa283KA633ipQSxPUWvQ7
         EsFtbdI4RDj5XLgIviVb40Er+ihF1LIYe7QmhdRebC3ZVVNiADHAMurNznGwovX5WDeo
         Uwm1Y6EPqJ+xNSSDuPFKvTOGunGW5bF/mWy4bN9biYa7gJUvCgadwAyADMCqvubtjCZ3
         U+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424374; x=1711029174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIl4vzYLu7H92myngevMJEPjqZCqCBPhgfD/SqnC3pE=;
        b=K+fVqaiRhr3yvm0Xxy7Lw//NkEqV1IxVsDaJUSJBRpUQ4JKc65ccZKCO+C/HdIBxaZ
         Av6O43tggVYi5SMiZtRWmWvXHtfq4GwAw7TstfjaggDZxscRjkA2oyhVRDSJ3/f5x+zn
         Ofk1COsUX7NEVUHitI7zXy/ZvKsgxcDqUmc/OjntrXzVN2Css4iBAIZyhIZGKEN5UYyu
         pxoVyHhZM35im0WBQ2hBNdtNJD/4vhIGTvYG691WaP+e7jIX9YUh5yxZ87Jgwwa7H+e+
         Q6U6W+Zl1vNL72wKchbDosKK8EE7qB78ghr6n+33sfdJcGnurzbukuSddt+NytB/Bn3V
         +WJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiypvQOV37qVw7XqvqGY0DrP4buHfO6Knp1Tz9HuSXct3u9lGB4U8aep0fCsv1kHVhLuvhdnusy18HgvV4nh4gvLA6bU9AmYSi+oKAhXsQYFvNEWDBswMl98LzXCSkV6YAd21SlDT0LTT1y88y2ZrR4Pp+y+LAe/jsGaVj5Ofg
X-Gm-Message-State: AOJu0Yylig2ckHmxtjroVC7JdN+hzKnnsbXmOfwX1fPF1GvRUFR8g6IM
	4bKT4b1TOkcFfqNRRYUrFQ3YC7sGsyaRo7QECVSwquOwAUXm/hig
X-Google-Smtp-Source: AGHT+IFf+kJk7xGcSVahe5u1ec7CBmGtIvekV5cmZjqxXpV9hnuLTiOLG8wA4rCJG7svPg7uDZ5MIg==
X-Received: by 2002:a5d:68cb:0:b0:33e:4590:8bd8 with SMTP id p11-20020a5d68cb000000b0033e45908bd8mr1060606wrw.60.1710424374339;
        Thu, 14 Mar 2024 06:52:54 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id az9-20020adfe189000000b0033e43756d11sm857939wrb.85.2024.03.14.06.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:52:53 -0700 (PDT)
Message-ID: <4f18053b-9e64-4437-8bdf-18e68b4835d9@gmail.com>
Date: Thu, 14 Mar 2024 14:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to
 fix boot failure
Content-Language: hu
To: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com>
 <219f3eeba68fd0542d4954205c35bafa.sboyd@kernel.org>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <219f3eeba68fd0542d4954205c35bafa.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Stephen,

2024. 03. 13. 23:57 keltezéssel, Stephen Boyd írta:
> Quoting Gabor Juhos (2024-03-11 08:06:36)
>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>> index 678b805f13d45..11f1ae59438f7 100644
>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>> @@ -55,6 +55,24 @@ static struct clk_alpha_pll ipq_pll_huayra = {
>>         },
>>  };
>>  
>> +static struct clk_alpha_pll ipq_pll_stromer = {
>> +       .offset = 0x0,
>> +       .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_STROMER_PLUS],
>> +       .flags = SUPPORTS_DYNAMIC_UPDATE,
>> +       .clkr = {
>> +               .enable_reg = 0x0,
>> +               .enable_mask = BIT(0),
>> +               .hw.init = &(struct clk_init_data){
> 
> const?

You are right, I will add it in the next version.

Thanks,
Gabor

