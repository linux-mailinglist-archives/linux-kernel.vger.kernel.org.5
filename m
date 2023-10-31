Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF87DCBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343823AbjJaLi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbjJaLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:38:23 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076ED8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:38:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40859c466efso42984915e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698752299; x=1699357099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0Atp27LZfRzmnYpBx5CazxCFjGuBvxzQl4UQFiRe54=;
        b=a9zgCis12cTMtE9IP7VOjnYivak3ftoij7/y8Ys1LFWm3U9cQ7UgnvWPv4fleY/VyE
         cYWE1BXcdgQCDzal2ttZyRq3vlbsgWugQ67fAnqVoK6QizFA+UO4pEHQRRWPqynY8IvS
         aIUJahrYCPxvG0ylgF06KW1e00j38v8BRUNavEWr8MPDkgrobJeJ05xRvwfQQOXzO8WH
         e33juV62vG2Je6bXfsrKYjtqkObbsRFpE67QT4xzITM2P5KiA2oXx/9AmBGli2aNh1Yw
         wfVgGSebpa74R9xcKc5xTaKst+9nUOFv44ZTTb78/bJT04mnbXqRHbdRR32D+sxTLLfi
         2fOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752299; x=1699357099;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0Atp27LZfRzmnYpBx5CazxCFjGuBvxzQl4UQFiRe54=;
        b=lzQETIdGUdPzRzMBPXrGMFrJZEHKMlDAHJFFNp7Qwnf4mI/1csSMeqZ6y62Er+lsAq
         80BcxQenugZ2KD+k0JN/mKi2YaiOy2U/a4RSbGlxX7MDMpIuaIlIonG7bvM1H90gVjMA
         K7spGIg/Np4BgMGapM9crzLSVHTu/Dlfg2lmc4RebFsz9U5SY3NSMrzoPfTEDcmLPnRV
         /pDVDwMgL0kKux1h094ahN/hA+0et087MRXTOACWme+yPARdqoBd4DAunb2Q4WO0peQx
         qa6A47WtZNyBYGiIiKvRy9IO1BoHeA79u3rt+Oo/FLhsWmj8e960+rlJ5esaUpqWrpyd
         gV/g==
X-Gm-Message-State: AOJu0YzPK5+yWHsQai3QYFdvtbXfUQCqSshP5V4Mehb4LKbl4IhnsvoL
        2KNmW80TxiePKvhVv1jqRA3kGg==
X-Google-Smtp-Source: AGHT+IGb/PBBH9uX4ZCP3I3lEgbPgZQf8px9qSYMcl1XUQI1jOkACWOw0SL+ILGYpQcTWBsY9KGXlw==
X-Received: by 2002:a05:600c:3501:b0:404:757e:c5ba with SMTP id h1-20020a05600c350100b00404757ec5bamr9487672wmq.26.1698752299429;
        Tue, 31 Oct 2023 04:38:19 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c248800b004060f0a0fdbsm1490423wms.41.2023.10.31.04.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:38:19 -0700 (PDT)
Message-ID: <5a6ba550-6115-47ab-b724-5e29d64a1b2e@linaro.org>
Date:   Tue, 31 Oct 2023 11:38:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        rfoss@kernel.org, todor.too@gmail.com, andersson@kernel.org,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231026155042.551731-1-bryan.odonoghue@linaro.org>
 <20231026155042.551731-6-bryan.odonoghue@linaro.org>
 <d411e561-b0d0-48db-959e-3347006bce77@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <d411e561-b0d0-48db-959e-3347006bce77@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 10:53, Konrad Dybcio wrote:
> On 26.10.2023 17:50, Bryan O'Donoghue wrote:
>> Right now we use fixed indexes to assign power-domains, with a
>> requirement for the TOP GDSC to come last in the list.
>>
>> Adding support for named power-domains means the declaration in the dtsi
>> can come in any order.
>>
>> After this change we continue to support the old indexing - if a SoC
>> resource declration or the in-use dtb doesn't declare power-domain names
>> we fall back to the default legacy indexing.
>>
>>  From this point on though new SoC additions should contain named
>> power-domains, eventually we will drop support for legacy indexing.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
>>   drivers/media/platform/qcom/camss/camss-vfe.c | 24 ++++++++++++++++-
>>   drivers/media/platform/qcom/camss/camss.c     | 26 +++++++++++++++----
>>   drivers/media/platform/qcom/camss/camss.h     |  2 ++
>>   3 files changed, 46 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
>> index ebd5da6ad3f2f..cb48723efd8a0 100644
>> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
>> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
>> @@ -1381,7 +1381,29 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>>   	if (!res->line_num)
>>   		return -EINVAL;
>>   
>> -	if (res->has_pd) {
>> +	/* Power domain */
> Unnecessary, I think
> 

Consistent with existing commentary in this function ->

/* Memory */

/* Interrupts */

>> +
>> +	if (res->pd_name) {
> No need to nullcheck, dev_pm_domain_attach_by_name seems to return
> NULL when the name is NULL

It looks so. Then again I'm sure checking here saves a few instructions 
and stack operations..

---
bod
