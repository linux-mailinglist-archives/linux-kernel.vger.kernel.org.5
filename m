Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE179E7E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240409AbjIMM0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMM0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:26:46 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC9F19B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:26:42 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ad8bba8125so230153566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694608001; x=1695212801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8E6NTnrAXKpDewa3pGzDd8qfOwRsIkXDy/usDX+LrAg=;
        b=JBcOBfiM1eiShcLgRR4XdqxLoe4fY/Qwfk3fTG23JCUJK3x27K0odDpGrHq35u03DG
         G/bXwEsV5fMPNPbz6TcqPXKqjHo5BuepcyITcnPoyDYepzqjQ5tHlHxbk86FBWfd0lM2
         8AVo2ixwHRXjJg5Q6UWvYvWP0yd0bkvrm4OrX4g9JHU46hVuVMnU+E5bT5HmGzFFZFnx
         1oRQ5rUGyA0PN9I0oyAF9kpFZGLo9EupPH2e9pMBf2hn/QPppWPnDnP+dGGHlUS8qdq0
         9Y9+6KQzUBXWnmPfHvici9HK0rY7r5DnjKyXESf3OwdQNGvgX4KlLPibd9r7Q2xcAqlP
         lVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608001; x=1695212801;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8E6NTnrAXKpDewa3pGzDd8qfOwRsIkXDy/usDX+LrAg=;
        b=UVv1VOVTBMds9vJvSsZDPAlaIDfJw0mkVO1EX8rDAekYPL/LTDoau5VEAHd0SydHlx
         3xPar5KLE2kTutbG6/LSRVRGXF4d+Uhph24EhZitofwiR1TbEu7g9/7BBdKo6m65IzLF
         jfMikZT2TQoN7Hf+It2oc5/GmyJtTMO5ULmM2bNpE/CCgvqjl+9plws4j3ustSS8UE5r
         ZEzcS2HY+rivcDqGhpltbGdkQnENO4HcIo3mZq9ElHy2Mf4nfaiVuaS3znIDZ6fYl4KM
         NuliMo1oYmH4CoKV96BgAw0MtT11VU1aw9uZLcbojJDWLPJhQ9rMmMU4jIdaYVtgb25k
         ASVg==
X-Gm-Message-State: AOJu0YwEtfxe3sp08gq2ip+SUYdTdwdJvBqRHmxDct4gcumAJpQmvM3I
        ct2ohRYiUiN8pDp9CstI4jyVKQ==
X-Google-Smtp-Source: AGHT+IH/5F1hSY0BAv5EYN86McI3ASqRbm5sCuJy71SqYqBI6pY3zEpfJCSXerOM4dBZMkPUW/SpgQ==
X-Received: by 2002:a17:907:9686:b0:9a5:7887:ef09 with SMTP id hd6-20020a170907968600b009a57887ef09mr2243739ejc.32.1694608000944;
        Wed, 13 Sep 2023 05:26:40 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm8489928ejb.174.2023.09.13.05.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:26:40 -0700 (PDT)
Message-ID: <e91e7d74-c81b-4b72-85bd-be6a5d25b1e7@linaro.org>
Date:   Wed, 13 Sep 2023 13:26:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 00/20] Venus cleanups
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
 <5d13f9c7-665d-4ff5-962d-940898b24754@linaro.org>
 <c7c0a8af-30c5-49c9-8212-bf08abc7c3fe@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <c7c0a8af-30c5-49c9-8212-bf08abc7c3fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 13:03, Konrad Dybcio wrote:
> On 12.09.2023 08:19, Bryan O'Donoghue wrote:
>> On 11/09/2023 16:10, Konrad Dybcio wrote:
>>> With the driver supporting multiple generations of hardware, some mold
>>> has definitely grown over the code..
>>>
>>> This series attempts to amend this situation a bit by commonizing some
>>> code paths and fixing some bugs while at it.
>>>
>>> Only tested on SM8250.
>>>
>>> Definitely needs testing on:
>>>
>>> - SDM845 with old bindings
>>> - SDM845 with new bindings or 7180
>>> - MSM8916
>>> - MSM8996
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Don't we have both a db410c and db845c in Bjorn's lab you could test this on ?
> None that work
> 
> Konrad

If you agree to bring more Polish candy to Ams, I will test this series 
for you.

Fair exchange.

---
bod
