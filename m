Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259247997CA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345487AbjIIL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbjIIL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:59:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9444E49
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 04:59:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bcb8b199aso3807987a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 04:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694260779; x=1694865579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPDmWuhnFdHyVJsaLOg1TlvNz7Ol1/y8/dbdTjH2H8Y=;
        b=DeqsedZEpCig0at0HRcPaEXADG8zfpp+c/nzYmoeygAE67z6ZplRj7w6MLuPKnFq5j
         5ebBepIbsLRT/azVi7MEYLGQtq+vMRv1VwpSXDX7SJp7cZjT1tu9TzwFwMwj9vTouBCL
         xA6bPRyitYKA5QkCC9IR7De5q17u1YOkYeChpNcEH+5S4y3Gt1xHmvUE3U4j1N8XInPX
         ghUWa3/EpFd3Wj9L6yFhtJn/5BgFCC+o8xmXFImABlyLPJtolGcRr5M4O/40JedrJIV+
         JiVmuH1W25vtuakSY51VEU9G42ulkd1DLoCuZlpfKlCwGcqmIQSeI0kw0L1HwL0Z2NHm
         TzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694260779; x=1694865579;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FPDmWuhnFdHyVJsaLOg1TlvNz7Ol1/y8/dbdTjH2H8Y=;
        b=pUXoGWML1B/sMLBcxDwt1z0GtAZt0UGM8waw2hhoNtJCHpvlrwEVssw4LI8WGhrYd/
         Pv+7N6Sa6hhL1GZaYuDzabrz4IAzTs4HtxWqURc4jq1eMRqJd+REjaorT63xDCo/0v4P
         K7vLPzFxqZL25+dmshT82A4s/gF0ZBeR2OXS+WfafAfFPv/nYY2t5EzvVfoFRjSjaBk+
         QfjU4MV9lxoG2rqStbYP4MSu1mTcA2RuxwcM0nNhXpRQcqRbFTLt+vzxRpW9+9uS3jQw
         Ud92d0WYWoh/knaRkt9cglhOAsj9p36VBTA/BdZnIVMICm+bTsM3qd5cr/wkOegkhFTm
         MSgg==
X-Gm-Message-State: AOJu0YxQFEN3XtFOAFAXziBfVAermZTRa/Te0Kl43FZr1LDthQfHGP52
        kln84MeF6GbEykJdqnssxmM/QA==
X-Google-Smtp-Source: AGHT+IGp5hXduhdVMpjDOYG5qVShxWo5y5Lb6fsQtfIQ+VPOoDgC4/7ca/YsGqHwI6uancdrmm8/Og==
X-Received: by 2002:aa7:d40b:0:b0:523:a45f:419a with SMTP id z11-20020aa7d40b000000b00523a45f419amr3772231edq.41.1694260779197;
        Sat, 09 Sep 2023 04:59:39 -0700 (PDT)
Received: from [192.168.37.232] (178235177205.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.205])
        by smtp.gmail.com with ESMTPSA id e2-20020a50ec82000000b0052a48f4065esm2109463edr.39.2023.09.09.04.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 04:59:38 -0700 (PDT)
Message-ID: <6d8def60-3b88-4c05-a2c3-aba0f83314e6@linaro.org>
Date:   Sat, 9 Sep 2023 13:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/9] soc: qcom: cpr: Move common functions to new file
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-4-9fd23241493d@linaro.org>
 <20230829151509.GN818859@hu-bjorande-lv.qualcomm.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230829151509.GN818859@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2023 17:15, Bjorn Andersson wrote:
> On Mon, Aug 28, 2023 at 01:42:16PM +0200, Konrad Dybcio wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
> 
> It seems reasonable to update the subject prefix, now that things have
> moved to the genpd subsystem.
Right..

> 
>> In preparation for implementing a new driver that will be handling
>> CPRv3, CPRv4 and CPR-Hardened, format out common functions to a new
>> file.
>>
>> Update cpr_get_fuses in preparation for CPR3 implementation, change
>> parameters where necessary to not take cpr.c private data structures.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: rebase, apply review comments, improve msg, split]
>> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/genpd/qcom/Makefile     |   2 +-
>>  drivers/genpd/qcom/cpr-common.c | 350 ++++++++++++++++++++++++++++++++++++
>>  drivers/genpd/qcom/cpr-common.h | 103 +++++++++++
>>  drivers/genpd/qcom/cpr.c        | 384 +++-------------------------------------
>>  4 files changed, 475 insertions(+), 364 deletions(-)
>>
>> diff --git a/drivers/genpd/qcom/Makefile b/drivers/genpd/qcom/Makefile
>> index 403dfc5af095..b28c8d9128c4 100644
>> --- a/drivers/genpd/qcom/Makefile
>> +++ b/drivers/genpd/qcom/Makefile
>> @@ -1,4 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -obj-$(CONFIG_QCOM_CPR)		+= cpr.o
>> +obj-$(CONFIG_QCOM_CPR)		+= cpr-common.o cpr.o
> 
> Is there a reason for this to be split in two drivers? Would it make
> sense to rewrite this such that the result ends up as a single .ko?
"meh"

These are separate major revisions of the hardware that achieves the
same result but requires rather different handling.

Konrad
> 
> Then you shouldn't need to EXPORT_SYMBOL between the two parts of the
> same "driver".
> 
> Regards,
> Bjorn
