Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852827EFD0D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjKRB4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjKRB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:56:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4C01727
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:56:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so771115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700272567; x=1700877367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXrHQ3w3ZeCgtpBw84c6HijlDU6o8dqFfZbTc1+ea3o=;
        b=WGmnCuGqc5Ub+lM5VFPb2IA93CAwgurh9bz78XY5vyKmEJbBKaLy3KKFXT/e4+7GCB
         BhPDqjnIqI6gogihds9Bm6M+gLFQgibPsMFVrkT1udBAlWgF3tQ8rFRPpBPHA4WR4oux
         XdrMdOr1GnYzwzP+KeMJqqx0QbYPcwdRRabf5oVm8+WHbUR3hOnofdK8/rJ85Huv7QiC
         C6DUgqmObF0wFgf+HGuOyisLZpZ0+Wae9JYTf4wC/0/u5otr1xLjTl4Htqhh73T4Gvox
         l1eovsFhh9/oiVEKw7hX9LN4a95EN7mjKQS9XlYl3ubqb+Lw64LNiwBq1HKJbNNOrkCW
         magA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700272567; x=1700877367;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXrHQ3w3ZeCgtpBw84c6HijlDU6o8dqFfZbTc1+ea3o=;
        b=aIEE3flPaM3r6sB7DG4DiG8rh45Kpa38Zk1ACqc4lBIvt6CLdqzedDV1u1zOX3IYYK
         x86nwsjTJq521JO5l6bRwDf0RgSYQq+jo93ouUKpaUP3MqwSE0kxx36JdnslMJOvkk4O
         hu7NiPbkWQA27S6Grb1WvukaZ4HuJzZKegSRNNYHHaHwobWjU/HcKE1DvQohzsYOPWmM
         lLwDUS2LlQl0I/28n1S+QglDINYJjN0Z01TRdK3dbeh94oQsQFHb7Ek7Ah6uSyUkY6oF
         CJ3HSvLNYtKske8znqKlRd/LPdFhNEvZ8QtGUFpAQ+izHf1C0guR2wbpScNL/NPqusOU
         ShbQ==
X-Gm-Message-State: AOJu0YxjyLYCIE5HEiwz68N1SNY24yXOBYRKdCVs0kYxzclPJfVuVGKD
        YeXkDwyNUhYK7DwyzlLUPVFTvw==
X-Google-Smtp-Source: AGHT+IGNlNdvBLqd0P+OKkTRipccHqp/1xRwscwSV6ZxHjV94jWhm/8MkJUHeAG/Rhk3tsFe8Yltrw==
X-Received: by 2002:a05:600c:4448:b0:40a:45ff:fd69 with SMTP id v8-20020a05600c444800b0040a45fffd69mr789470wmn.19.1700272566550;
        Fri, 17 Nov 2023 17:56:06 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b004064cd71aa8sm4666185wmq.34.2023.11.17.17.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 17:56:06 -0800 (PST)
Message-ID: <4b60b317-6961-45c7-a4dd-9fe73641a239@linaro.org>
Date:   Sat, 18 Nov 2023 01:56:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] media: qcom: camss: Add support for named
 power-domains
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        matti.lehtimaki@gmail.com, quic_grosikop@quicinc.com
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231103-b4-camss-named-power-domains-v4-0-33a905359dbc@linaro.org>
 <20231103-b4-camss-named-power-domains-v4-5-33a905359dbc@linaro.org>
 <9752f4ab-5e08-4d1b-9ed4-6aa280c87a36@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <9752f4ab-5e08-4d1b-9ed4-6aa280c87a36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2023 00:38, Konrad Dybcio wrote:
> On 3.11.2023 13:29, Bryan O'Donoghue wrote:
>> Right now we use fixed indexes to assign power-domains, with a
>> requirement for the TOP GDSC to come last in the list.
>>
>> Adding support for named power-domains means the declaration in the dtsi
>> can come in any order.
>>
>> After this change we continue to support the old indexing - if a SoC
>> resource declaration or the in-use dtb doesn't declare power-domain names
>> we fall back to the default legacy indexing.
>>
>>  From this point on though new SoC additions should contain named
>> power-domains, eventually we will drop support for legacy indexing.
>>
>> Tested-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> rg -l "&cc.* \{" arch/arm64/boot/dts/qcom # (the bus is named cci or cciN)
> 
> arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
> arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dts
> arch/arm64/boot/dts/qcom/apq8016-sbc-d3-camera-mezzanine.dts
> arch/arm64/boot/dts/qcom/qrb5165-rb5-vision-mezzanine.dts
> 
> the FP4 only has bus enablements (i.e. no attached sensors)
> the number of working DB845c/RB3s is probably single-digit today
> 
> 410c and rb5 are probably legit users.. part of me would like to
> get rid of this messy old binding ASAP.. but then are there really
> non-Bryans with these boards and the camera mezzs?
> 
> Konrad

The plan here is to follow the procedures as I understand them.

- Deprecate
- Wait a reasonable amount of time ~ 1 year or so
- Drop

We could go faster but, there's no need. Drawing a line on new SoCs and 
deprecating the old way will do fine.

---
bod
