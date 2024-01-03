Return-Path: <linux-kernel+bounces-15371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA5822AE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73892821E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012618AF3;
	Wed,  3 Jan 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaRB2lQ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866718AE5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so8021549a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 02:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704276231; x=1704881031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Xw4kZ8Fi36r1/u/ZGUNuZ1cdvJuSr+hlgdaJFJEbWc=;
        b=uaRB2lQ1sXWJ0nKHTgLFQ2mpRQ37B1lPdHSUnIH1Cp1ej3Kbs0t7uSg5A/2qEjxGLn
         OUgvamR5fX9sMoTjndxDBF2TJn5OueG76v/r0wvnB3RYIg5DPXtJyngtL+7/8BOVMbFn
         kvMcVp5fA/aPJXrXJ1y48Ggg5Hnuf6KRtyPSch7YVHpbdqqdOHz0zKCWyQunyhOOuYPA
         zLBtr0FcoBUBWlMxQqaF2IiQG8asBMshbqWhly+iJtaxlSDFNbdgCsuoc0wAxgILQan7
         t7EhmZmyV0KmWDOWEta9k3pyBpgaMgwOzEMSr3UHNzkZcwYZSO8GGzy6z3Pnslb8ploT
         ZZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704276231; x=1704881031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xw4kZ8Fi36r1/u/ZGUNuZ1cdvJuSr+hlgdaJFJEbWc=;
        b=tK4zUN6zKfAKUwt/64b/auvchtyKd/uSMjXC0CscHhGyShyrplhU4B+AqoVkTdo01m
         on9NaGHB+fLNzuCtYAuemKfS+b6otKwaQ9qKQ3Q2RsMufDoA0HPooTOwH3/qU0hxikr2
         pZtQOZ/XeQWnobbQavBVALrIuq0pz0lJ6vsuoAGm/Ico180TuLB7r7Z5wE/engjHr0Ly
         0byFepTlr/QSTbXGKEPeSFRwNH98CEnWK7QOaBuGAHNBmjHNCMV9DioyZ6hvmzO1Nm7X
         ChHsVkWc2nOvSQUX3IXML7Ce3yMwqzDK0jggjHT80SCMTxe/aMESWQzbwM407v2xfGQ6
         BClQ==
X-Gm-Message-State: AOJu0YxXoUCr+sTzYBizB+07Ueen9Yv0I2i29rOEuneBMWVZZal2dCmc
	004Y96+4AOpYNkFtsWl4L/ELbOOnNtMPnA==
X-Google-Smtp-Source: AGHT+IG7KfS6krtpHhI/8rKxNUfpOgBr+QWceVggrTnekCLC9ES8wo4v2rzI17wfLkIqA7cY2Yh3bw==
X-Received: by 2002:a17:907:3a10:b0:a1d:ec18:6ad7 with SMTP id fb16-20020a1709073a1000b00a1dec186ad7mr7595454ejc.53.1704276231312;
        Wed, 03 Jan 2024 02:03:51 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id ez21-20020a1709070bd500b00a26ac88d801sm11886723ejc.30.2024.01.03.02.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 02:03:50 -0800 (PST)
Message-ID: <8ef0364b-2649-4bef-81bf-30934afb1e38@linaro.org>
Date: Wed, 3 Jan 2024 11:03:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: qcom_smd: Keep one rpm handle for all vregs
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231227-topic-rpm_vreg_cleanup-v1-1-949da0864ac5@linaro.org>
 <ae1c1cb6-00f9-41ce-afd1-d557fbf3034f@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ae1c1cb6-00f9-41ce-afd1-d557fbf3034f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.12.2023 12:48, Dmitry Baryshkov wrote:
> On 27/12/2023 03:29, Konrad Dybcio wrote:
>> For no apparent reason (as there's just one RPM per SoC), all vregs
>> currently store a copy of a pointer to smd_rpm. Introduce a single,
>> global one to save up on space in each definition.
>>
>> bloat-o-meter reports:
>>
>> Total: Before=43944, After=43924, chg -0.05%
>>
>> plus sizeof(ptr) on every dynamically allocated regulator :)
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>>   @@ -1440,11 +1438,10 @@ static int rpm_reg_probe(struct platform_device *pdev)
>>       const struct rpm_regulator_data *vreg_data;
>>       struct device_node *node;
>>       struct qcom_rpm_reg *vreg;
>> -    struct qcom_smd_rpm *rpm;
>>       int ret;
>>   -    rpm = dev_get_drvdata(pdev->dev.parent);
>> -    if (!rpm) {
>> +    smd_vreg_rpm = dev_get_drvdata(pdev->dev.parent);
>> +    if (!smd_vreg_rpm) {
> 
> I thought about having a mutex around (I don't remember if secondary PMICs and/or chargers can be routed through RPM or not).

A mutex for assigning this?

Konrad
> 
> Then I went on checking other RPM and SMD-RPM drivers.
> 
> clk-rpm: global variable, field
> clk-smd-rpm: struct field
> regulator_qcom-smd-rpm: struct field
> 
> Probably it's worth using the same approach in all four drivers?



