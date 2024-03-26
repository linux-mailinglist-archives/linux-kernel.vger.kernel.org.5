Return-Path: <linux-kernel+bounces-120001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062988CFF1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F571C67228
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4913D2B6;
	Tue, 26 Mar 2024 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlOs0o7Q"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6090413D528
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488270; cv=none; b=RrhbkAfiBKj+izbNuYyYvAiIJqaAZTZ7AEM+Z0TTs4O59xyHPWs1krxM5VrgoPGb1iJjCXZ9pFsuh7PGZrVh7GykFh8Ej7s1FCHYs2z9yEBMg2MqREOUw/wutlSTf+twX2FaTVwLWoFQJjZApijMwB+/18sNdQ7tTzYLZ61uYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488270; c=relaxed/simple;
	bh=gOajk2iNWyP+O2AHmKvHxVTPbsYOBpiVOI2qazoxc28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyGUjY5QJR9YLGu5lz+TO9woR1eKRvK7szv8cgVoGYB8CrrpfsHiXUwFgDoiskAFaUtV075WkcZPcgcn/2zcWt3nQWhikwKRF+Pp5bAXY8Z8caQ5KScgEajTHjtAamJC5P4XtyFvbOk6WShMyxJlDwbhn+lPfD22t/aKKh+ijtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlOs0o7Q; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a474c4faf5eso358027566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711488266; x=1712093066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GoDGazPiRgb9L75Xk/2NTAz5erShDCuLjlFhO/Pzeh4=;
        b=VlOs0o7Qs7Lkz9J4R11fWFstXVFvhwpGuuoSwux0FFeqvhOSrcGvfTBI8OvCvkNJnY
         kHz4HI6o8mBphiWl13cpKiKLjr6dHMaR5tLxnrT0pICOPCyByrV3gh+XRZHUrCLuakqD
         0UGWvwRx0Fpgyqh1AMGHSiivni+LVfN+M5F35PTp/xID8t2D2JveIN1Z2IneiQWf3PIm
         wNNcnX7Ikha8ON3lnJgkwBYoNhMEppUtWBTul2jf/i/VaMm81yu8xrcjZij19cfYT5so
         8wwJYbcaCqy3ejv7Blb5hfgADw9pc4MPRl6FnW2h8iC1DgkVShVhr/6wPOX6hQ8rhxQO
         i3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711488266; x=1712093066;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoDGazPiRgb9L75Xk/2NTAz5erShDCuLjlFhO/Pzeh4=;
        b=LZYcar8raURs0+/UUDYdc9XRKolSMhWRfkWUczTY9MG2Fr7Chsbpm7cZoWUY/0/Nah
         9FeUQKeomQdqU6ShMS36/aV9uvQssf+3ZHXDawEV0IinZ+tjNsvD0MMzUDtKdvQEfKXN
         jmE1We4JO6j5h+6P5eT9DXU78N1ndZVwUksPdjc3EWMrDI7Ztpe7LCdhMcwaw0I1ADmH
         FsERiDWElE3gilpT3D9gzhRs3uGDa/02khk4KfSZj6Ns1MD2FejAG3CWeVtWVRPHMwdF
         0NWeCUHj7mb0/8baJrz8/Y0JovTsywVfqvybJ6F7+qzcLWl5JNWfJOb09xD3X3bC1rmi
         KsmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Y0n+lCxrZi8L7oIczFScKbVUlgJeoCrjnRJd04hF7ijXfOy0W4phGlAA6XhY3SEEekkr/119lgDMiiZ9nQsNWLNpDPjZvo3sUgm8
X-Gm-Message-State: AOJu0Yz0mivNk8itmDvlpOxzUvjg0t2cK+nDLszSrV5UZNjTWznyU2Ts
	jobpqBX4NUjVT9ifFWjkxN/32Dr8ZydQLrihYcZGfEqdFGIZEVEROb9F8K+0ftA=
X-Google-Smtp-Source: AGHT+IGQmWXLuKqe5r0N2xqKwjaLvSyI4OspMR18XZhZsSs97TfxFzQ3jiTy4XasT9UTRKm8rarCdg==
X-Received: by 2002:a17:907:2d9f:b0:a4a:20df:e032 with SMTP id gt31-20020a1709072d9f00b00a4a20dfe032mr6132998ejc.66.1711488266550;
        Tue, 26 Mar 2024 14:24:26 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709065f8500b00a46478fbbbesm4608980eju.153.2024.03.26.14.24.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:24:25 -0700 (PDT)
Message-ID: <a5c7004e-c938-45b3-9cb5-cdd89eb52293@linaro.org>
Date: Tue, 26 Mar 2024 22:24:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] media: venus: pm_helpers: Rename core_clks_get
 to venus_clks_get
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-2-3dac84b88c4b@linaro.org>
 <ebe234db-73e0-46db-b377-6b9f960597c8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ebe234db-73e0-46db-b377-6b9f960597c8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6.03.2024 12:48 PM, Bryan O'Donoghue wrote:
> On 09/02/2024 21:09, Konrad Dybcio wrote:
>> "core" is used in multiple contexts when talking about Venus, rename
>> the function to save on confusion.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index 8bd0ce4ce69d..ac7c83404c6e 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -23,7 +23,7 @@
>>     static bool legacy_binding;
>>   -static int core_clks_get(struct venus_core *core)
>> +static int venus_clks_get(struct venus_core *core)
>>   {
>>       const struct venus_resources *res = core->res;
>>       struct device *dev = core->dev;
>> @@ -294,7 +294,7 @@ static int core_get_v1(struct venus_core *core)
>>   {
>>       int ret;
>>   -    ret = core_clks_get(core);
>> +    ret = venus_clks_get(core);
>>       if (ret)
>>           return ret;
>>   @@ -961,7 +961,7 @@ static int core_get_v4(struct venus_core *core)
>>       const struct venus_resources *res = core->res;
>>       int ret;
>>   -    ret = core_clks_get(core);
>> +    ret = venus_clks_get(core);
>>       if (ret)
>>           return ret;
>>  
> 
> We have vcodec_clks_get(). It seems a bit nit-picky but if you are tidying up the namepsace, then I'd suggest venus_core_clks_get() or vcore_clks_get().
> 
> Seems more consistent.

No, that's not the point, you got confused by the inconsistent namespace :/

These are not any "core clocks", they're either "all clocks except vcodec" or
"all clocks", depending on the binding type used

Konrad

