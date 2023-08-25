Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0EB788657
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbjHYLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbjHYLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:50:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA710FF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:50:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso12336071fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692964202; x=1693569002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxvBycOD3m3+JRPg8JQcvqgFmakCth+Ze79t418up68=;
        b=SICRR6DFS69jWZbgUMh4ueiIFZgBKWqXAltzd1QP2oEOxkgYhm0yM2VrmyzPqcHZXn
         v2Y25HoloYtVkLeipUJrxPyWXTkYxPMvTyKCYg42Nbr+GYtRytcmMfRVdt3Q/1CY7RUn
         NRjZqvqACVkjMtUeaQFLEEnxZNDA/qDeRnkl2AnVpc9StgIDFbvRi5pmHAnfBjy8UHmW
         zhN7nB9GChDzsTO5CbW+gGqfzrRLaG8TdsUyTYC/rH/FLowei8KBrh4RKDEXJ6Aqej5n
         eQf2+uQq8UXPIazMPnuEI7toLLQTjmbDF9rLPTPvybWc8h9AQ3PGKdK6pEUsiPzlZsll
         fFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692964202; x=1693569002;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MxvBycOD3m3+JRPg8JQcvqgFmakCth+Ze79t418up68=;
        b=HyiDi9md1Mf4GjCZZqk2ZC9qslZ+owMJzamJdw7LbXusPaYwcB8CNMiuZou6yAvjUi
         dk9peJyCEoSi3MoQbORJIHDv7ds8+40sglH+f+MaYTu9bBNOlOiBEJ8XZhqHQakAMQh/
         0rVq5QxnkQzokAbjK4EHPhBFqBipdAe1A2RqxggGqytgpzAfHGrbmL9kb96LWswwO38t
         Ej/qTCbDwf2fjz9yII4yYit8BUP+glJ79Yl63gXeAEdzHOq8QADqwzWIDDIf1aJfoaNK
         ZT4GF/H9QFsHpzHzyR6azCEREjINvdBioF0KJlL0/Bx7KY6CIl4aGx5eu2yVRY+pgSJl
         kVMg==
X-Gm-Message-State: AOJu0YwyeAvlXYhRNHXGYbDSVMQ44g3mon8R971Lu54hu4zD7qJ+Vmup
        5Ztd6IQDh8/86vvWpcMIOgsATg==
X-Google-Smtp-Source: AGHT+IHhvxglhm3o7JtAPpmx1AD83QKJdd1rl8yyUn6dTJNNjHQb0RSablPobizwJZPVd6uvtpyIDA==
X-Received: by 2002:a2e:8704:0:b0:2b6:cf64:7a8e with SMTP id m4-20020a2e8704000000b002b6cf647a8emr13477822lji.19.1692964201900;
        Fri, 25 Aug 2023 04:50:01 -0700 (PDT)
Received: from [192.168.1.101] (abyk232.neoplus.adsl.tpnet.pl. [83.9.30.232])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e8755000000b002ba045496d0sm296540ljj.125.2023.08.25.04.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 04:50:01 -0700 (PDT)
Message-ID: <b46d8e10-5f25-4350-b5b9-77bf5885780f@linaro.org>
Date:   Fri, 25 Aug 2023 13:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC DNM] perf: Add support for Qualcomm Last-Level Cache
 Controller PMU
Content-Language: en-US
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
References: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
 <f71bc35a-c45c-0429-1164-d047d61ef061@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <f71bc35a-c45c-0429-1164-d047d61ef061@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2023 23:31, Trilok Soni wrote:
> On 8/9/2023 1:09 PM, Konrad Dybcio wrote:
>> Add support for the Qualcomm LLCC (Last-Level Cache Controller) PMU,
>> which provides a single event, expressing cache read misses.
>>
>> Based on the vendor driver found in the msm-5.10 downstream kernel.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>> Hi, I've been trying to get this driver going upstream by cleaning it
>> up and adding the necessary perf boilerplate (the original Qualcomm one
>> only pokes at the PMU from within the kernel itself) to use the
>> userspace tool.
>>
>> I can not however get it to cooperate.. in this iteration I get a PMU
>> event registered (though with only a "raw" name - no "x OR y" like with
>> other PMUs on the system) as:
>>
>> llcc_pmu/read_miss/                                [Kernel PMU event]
>>
>> but the .read callback is never called when I run:
>>
>> sudo perf stat -C 0 -a -e llcc_pmu/read_miss/ stress-ng -C 8 -c 8 -m 10
>>
>> which always returns 0
>>
>> if I add --always-kernel I get:
>> <not supported>      llcc_pmu/read_miss/
> 
> Which SOC you are trying this on?
8250

Konrad
