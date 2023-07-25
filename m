Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D87762313
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGYULT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGYULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:11:17 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464921BCC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:11:16 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9540031acso85513991fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690315874; x=1690920674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O+I1J6EYVnwgKOmqsEKJkPBtq7V8p2nt+4NZWxtynA=;
        b=InoYR4rNPb/gWV8AqP/ZiBjK21BiUoNM8z5z9DSMKMLeT/TPWYc7wpuWpqa1IFiTdG
         RQQ37OMc6Jt0yGEO+g5OjRTrZ5SKIYNurDDLUksosIbMnLQ/IXl1amHJ+f7810h1uYmu
         2IJPM//OmJ6DuUXgCYeGig3Ph83RyfHhtuZHwlYwwh21ttcBfhh1qrlA2vB+jKdnHu1u
         swePhvo3T/+eXHF5btDs9TO1T1fH0qwfDIXbOjeLGBrzMlkVWno/kltdtGjJuaZYKfg2
         giuUn7vpUpUnLEaSIwsUmKNM+bjmH4L62diPocYG9uKpd36ruoLG4Rb6MAi0ZCF5j7nW
         cP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690315874; x=1690920674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7O+I1J6EYVnwgKOmqsEKJkPBtq7V8p2nt+4NZWxtynA=;
        b=FfpH/9Nxy0ssNj5exgQCyHZpqoV4SDSDyzw5/zcyoxgGXJTxcNa/A3zWifsTpn0glP
         J4y3BB5fQLKWmwq+gNvVS+7Xdb4vr5Py2hLsREFpLJG0yp9kBwLUXHl2HeqKww7jo40w
         zM9IKwXiqdBtTOsWsOkwaonx2B20p+5crHuSBNu/qLDQ2Grs3KAHyctMv7gO9QNjDl5r
         Sz1GlqAj/MN73sbr4jXKs3G8+EBcKjwZJbjACGc6aHU/Xxh1ZO2rQntUHd7+UUtFw8OC
         XKTDljcYhuu74u/kE4KtZzh6J62Y/sJth6P/3ofjiVZJsaMYjmcUxzh4uZMbBunsTJCa
         sArw==
X-Gm-Message-State: ABy/qLYQoHahG5ZosYmd7M0/rEqcwL8i7jt7jk/u1AlEuu0UG8V6BgKb
        4Fl5YqNE38OPlcou/K80ghf39IBFd2wNPQFL7k8=
X-Google-Smtp-Source: APBJJlHKZs34yLkzenFmeMhBQoMJmhzcYqDMZBPkq1CsuwmUNRZdK+Cs/MSP4YQ7u5mQC2SN7m9NAw==
X-Received: by 2002:a2e:808a:0:b0:2b3:4ea3:d020 with SMTP id i10-20020a2e808a000000b002b34ea3d020mr9317838ljg.17.1690315874458;
        Tue, 25 Jul 2023 13:11:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906164a00b00977cad140a8sm8601292ejd.218.2023.07.25.13.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:11:13 -0700 (PDT)
Message-ID: <3a75c310-1eb3-ebcf-82e0-99897e5e37c9@linaro.org>
Date:   Tue, 25 Jul 2023 22:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch RESEND 4/4] memory: tegra: make icc_set_bw return zero if
 BWMGR not supported
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, Sumit Gupta <sumitg@nvidia.com>,
        treding@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     bbasu@nvidia.com, talho@nvidia.com
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-5-sumitg@nvidia.com>
 <df57e126-fe89-8a43-42aa-f0b4a5a404dc@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <df57e126-fe89-8a43-42aa-f0b4a5a404dc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 20:29, Jon Hunter wrote:
> Hi Krzysztof,
> 
> On 21/06/2023 14:44, Sumit Gupta wrote:
>> Return zero from icc_set_bw() to MC client driver if MRQ_BWMGR_INT
>> is not supported by the BPMP-FW. Currently, 'EINVAL' is returned
>> which causes error message in client drivers even when the platform
>> doesn't support scaling.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/memory/tegra/tegra234.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
>> index bc73be7fe143..07aba301a173 100644
>> --- a/drivers/memory/tegra/tegra234.c
>> +++ b/drivers/memory/tegra/tegra234.c
>> @@ -951,7 +951,7 @@ static int tegra234_mc_icc_set(struct icc_node *src, struct icc_node *dst)
>>   		return 0;
>>   
>>   	if (!mc->bwmgr_mrq_supported)
>> -		return -EINVAL;
>> +		return 0;
>>   
>>   	if (!mc->bpmp) {
>>   		dev_err(mc->dev, "BPMP reference NULL\n");
>> @@ -998,7 +998,7 @@ static int tegra234_mc_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>   	struct tegra_mc *mc = icc_provider_to_tegra_mc(p);
>>   
>>   	if (!mc->bwmgr_mrq_supported)
>> -		return -EINVAL;
>> +		return 0;
>>   
>>   	if (node->id == TEGRA_ICC_MC_CPU_CLUSTER0 ||
>>   	    node->id == TEGRA_ICC_MC_CPU_CLUSTER1 ||
> 
> 
> I have also found that this change is needed for Linux v6.5 in order to 
> work with current BPMP firmware. Without this patch PCIe does not work 
> on Tegra234. We should probably also add the following fixes tag for 
> this patch ...
> 
> Fixes: 9365bf006f53 ("PCI: tegra194: Add interconnect support in Tegra234")

Thank you, I moved the commit to fixes branch. I hope other patches do
not depend on the order (it was part of the patchset as 3/4 commit).

Since I re-shuffled everything, I will send pull for current RC
tomorrow, not today.

Best regards,
Krzysztof

