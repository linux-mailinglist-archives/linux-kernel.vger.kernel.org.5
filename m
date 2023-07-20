Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886575B3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjGTQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGTQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:09:01 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EEF10FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:08:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so1570211e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689869317; x=1690474117;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nDC3kRutQ6+vjtamcuCXqi/6iIJSg2kIJpmE5u5EiUU=;
        b=QAC9UDJucNu5qYhjRJ7lFj0k9adbzpu+0881PeDxOTOnTo0u+1w8cKlNZIfBiw0qTA
         rCfkIdmwGwKuX7O++47Ue42G3PzuElooEoDHK5eOHMKobi1j+9HUXZprzQ3pByXL7/SF
         /4O8CK6YrUPRHKBdLa98eiMztQo0OgCctK+FGnAuLqbzAtYlMyhUbl04hq6/F6aJRePL
         TaSWiZo1K/VDqTRXSaJEjgHD4zj1Pc6d0pN/Ezj0jtP1ITGypwD9V/4BrvqWAhMxQxU8
         st2kw915/cS6eqiEUdQbsDZeuO9DcypkG6BI8doLXsY5yY98DtM0I2KAfOICZrWWwNCT
         wzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689869317; x=1690474117;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDC3kRutQ6+vjtamcuCXqi/6iIJSg2kIJpmE5u5EiUU=;
        b=dbOof9mWGYrX7jKzy2avW/2RezRRqVthLhtwRg0UFojXFpIXU1tGsJAMcxk8EiqaSu
         e6+InjlMfVvRYos+MU3yinEkxy11xR+vC2loUKe2PfHzsluJxIQMyPw6VRn3rqvqdKWg
         j9myzCkxipc6P2Rlp2IsQ0QEPkcAXlYnPIDsXYSAqQRqea7pcq+A64QTfE09WFGKz1Hm
         QswBl8t9fUL/yXrSClglpsdRsmR7kdn8tHxZxmovdElcqt4J1BQQUM64ZCqc57XwRE7F
         56tehrsNvkwLngykZ9PmSCaPEyQE3waIwy8N1SxPqcqM9uKxLX/0n20dH6kYvSGxTC4g
         Gmsg==
X-Gm-Message-State: ABy/qLaWY5jKpTjTxUCklNW/YDgPu0LIyyFHr0s9NGc1zvTdT8JOmoY6
        qCw/dr7Eh54ocuslLEu0Yg1/9A==
X-Google-Smtp-Source: APBJJlFm41jED7P2hnqGPhWnmlBLD3SeaDnhLY01OfBL1f7yZjoEs7pk+azhEcBSin4pYJmqcG5KQg==
X-Received: by 2002:a19:435a:0:b0:4fb:7392:c72c with SMTP id m26-20020a19435a000000b004fb7392c72cmr2313018lfj.57.1689869317065;
        Thu, 20 Jul 2023 09:08:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id h22-20020ac25976000000b004fbb821959bsm265474lfp.303.2023.07.20.09.08.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:08:36 -0700 (PDT)
Message-ID: <e78c2ce8-b149-1f06-17a6-8568aaf47faa@linaro.org>
Date:   Thu, 20 Jul 2023 18:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: clk-rcg2: Fix wrong RCG clock rate for high
 parent frequencies
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_saahtoma@quicinc.com
References: <20230720083304.28881-1-quic_devipriy@quicinc.com>
 <d68cc9a4-d4a4-17b1-c6fd-d128b82a818e@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <d68cc9a4-d4a4-17b1-c6fd-d128b82a818e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2023 18:08, Konrad Dybcio wrote:
> On 20.07.2023 10:33, Devi Priya wrote:
>> If the parent clock rate is greater than unsigned long max/2 then
>> integer overflow happens when calculating the clock rate on 32-bit systems.
>> As RCG2 uses half integer dividers, the clock rate is first being
>> multiplied by 2 which will overflow the unsigned long max value. So, use
>> unsigned long long for rate computations to avoid overflow.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>  drivers/clk/qcom/clk-rcg2.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>> index e22baf3a7112..42d00b134975 100644
>> --- a/drivers/clk/qcom/clk-rcg2.c
>> +++ b/drivers/clk/qcom/clk-rcg2.c
>> @@ -156,18 +156,18 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
>>   *            hid_div       n
>>   */
>>  static unsigned long
>> -calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
>> +calc_rate(unsigned long parent_rate, u32 m, u32 n, u32 mode, u32 hid_div)
>>  {
>> +	u64 rate = parent_rate;
> This should not be necessary.. You're being passed a copy of
> the original value, which you can operate on.
> 
> Otherwise, LGTM
Well obviously no, as I hit enter I realized this is of a different
type..

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

