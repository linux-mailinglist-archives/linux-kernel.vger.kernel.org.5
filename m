Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F277849F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHVTHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjHVTHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:07:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C344CCEA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:07:28 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31aeedbb264so2994549f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692731247; x=1693336047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obssRPZea66XUVKQdWwZ33dXszmaEL2LdLWjJbTk+Gw=;
        b=KUnAO4SW42IhcDBvVHqom6OK4Iq7p0gYwp5mGFxDT9egzI1LbAQcHqCtW0SstRVDeb
         1zbVVW5zPY+apawMt76dvbhZDZ8W8bKio0pkKSrqC5d7b79XY31RkYuocEX6QwBSYcC5
         l3ef6vUPSNCCP22pAytGYiQ/igsmjE8o5c3mH8RO5+0pZroLCqjZfZsVNORm8Z7LpSNi
         /QWEPTR80zllG1jA7pkcm+wXLNCTi/qXoFUgHMagt5Zv9qB8xeDwmLUDBYHsxCm9udlM
         +p7UVlLPYkR7KBGMASVpFEKAr81Vwuok63CqaS+lkOWiF1mghRCcQb+YcikrbTpgPdbc
         bKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692731247; x=1693336047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obssRPZea66XUVKQdWwZ33dXszmaEL2LdLWjJbTk+Gw=;
        b=fV4faWq+1gv2dhNAc/IPQKpnpfsTEu4uUKAARFcawVBqWbqNxXY2pofNOm5/ShPyQ2
         W1GbnZYXfBAHYteQ6zzguXDscuDvZHmXf5q/+T6Yjad0RbSzLhBGxinv+CEaPQxQYDXK
         +X2mAPvuQecBwAmmPSQ3hbIISVllZGw+G8RYEICuw6wXnmL5Za9WWBQ3159iPj5W1Qck
         mn0+xPKViG2X5El+gmduBC7pqyygpYj9UwGllfonhszxodxG6aaQdBjIUQ7MgI8GHcKg
         luKtE4qVqPkZCY8FeSl2oZXOiTd8XHbGqopUsUKks/JLCFJi522H8kgdRA/wmsogUtg6
         Z7DQ==
X-Gm-Message-State: AOJu0Yxyx2aJVwY0c6XqqskAEotmeieD3Yu3zUcPSBkev/DiWDd4Rzjk
        Y2bxeg8ODCGuxrNcmc3K4TgcHg==
X-Google-Smtp-Source: AGHT+IFM0hpeI/IXnPxfPzo186m7+lcVFbqtZnZp2Y5HLgb7U3nyZZ7vpWSmoR0OU/Yvxo01LBxECA==
X-Received: by 2002:a5d:65c5:0:b0:319:76a2:36e9 with SMTP id e5-20020a5d65c5000000b0031976a236e9mr8064149wrw.56.1692731246769;
        Tue, 22 Aug 2023 12:07:26 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k12-20020adfe3cc000000b0031ad5470f89sm16738544wrm.18.2023.08.22.12.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:07:26 -0700 (PDT)
Message-ID: <8a4db962-423a-16c1-5756-66878b50b264@linaro.org>
Date:   Tue, 22 Aug 2023 20:07:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 9/9] media: qcom: camss: Fix csid-gen2 for test pattern
 generator
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
 <20230822161620.1915110-10-bryan.odonoghue@linaro.org>
 <4f271226-c45a-42a8-95ff-8ec008ce7e72@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <4f271226-c45a-42a8-95ff-8ec008ce7e72@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 17:38, Konrad Dybcio wrote:
> On 22.08.2023 18:16, Bryan O'Donoghue wrote:
>> From: Andrey Konovalov <andrey.konovalov@linaro.org>
>>
>> In the current driver csid Test Pattern Generator (TPG) doesn't work.
>> This change:
>> - fixes writing frame width and height values into CSID_TPG_DT_n_CFG_0
>> - fixes the shift by one between test_pattern control value and the
>>    actual pattern.
>> So that TPG starts working, but with the below limitations:
>> - only test_pattern=9 works as it should
>> - test_pattern=8 and test_pattern=7 produce black frame (all zeroes)
>> - the rest of test_pattern's don't work (yavta doesn't get the data)
>> - regardless of the CFA pattern set by 'media-ctl -V' the actual pixel
>>    order is always the same (RGGB for any RAW8 or RAW10P format in
>>    4608x2592 resolution).
>>
>> Tested with:
>>
>> RAW10P format, VC0:
>>   media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
>>   media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
>>   media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>>   v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>>   yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video0
>>
>> RAW10P format, VC1:
>>   media-ctl -V '"msm_csid0":2[fmt:SRGGB10/4608x2592 field:none]'
>>   media-ctl -V '"msm_vfe0_rdi1":0[fmt:SRGGB10/4608x2592 field:none]'
>>   media-ctl -l '"msm_csid0":2->"msm_vfe0_rdi1":0[1]'
>>   v4l2-ctl -d /dev/v4l-subdev6 -c test_pattern=9
>>   yavta -B capture-mplane --capture=3 -n 3 -f SRGGB10P -s 4608x2592 /dev/video1
>>
>> RAW8 format, VC0:
>>   media-ctl --reset
>>   media-ctl -V '"msm_csid0":0[fmt:SRGGB8/4608x2592 field:none]'
>>   media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB8/4608x2592 field:none]'
>>   media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
>>   yavta -B capture-mplane --capture=3 -n 3 -f SRGGB8 -s 4608x2592 /dev/video0
>>
>> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Andrey Konovalov <andrey.konovalov@linaro.org>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> That's a whole lot to unroll..
> 
> [...]
>>   		if (tg->enabled) {
>> -			/* Config Test Generator */
>> -			vc = 0xa;
>> -
> Which part does this hunk correlate to?
> 
>>   			/* configure one DT, infinite frames */
>>   			val = vc << TPG_VC_CFG0_VC_NUM;
>>   			val |= INTELEAVING_MODE_ONE_SHOT << TPG_VC_CFG0_LINE_INTERLEAVING_MODE;
>> @@ -370,14 +367,14 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>>   
>>   			writel_relaxed(0x12345678, csid->base + CSID_TPG_LFSR_SEED);
>>   
>> -			val = input_format->height & 0x1fff << TPG_DT_n_CFG_0_FRAME_HEIGHT;
>> -			val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
>> +			val = (input_format->height & 0x1fff) << TPG_DT_n_CFG_0_FRAME_HEIGHT;
>> +			val |= (input_format->width & 0x1fff) << TPG_DT_n_CFG_0_FRAME_WIDTH;
>>   			writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
> This screams necessity for FIELD_PREP/GET! Could you please convert
> it in another series if you have time for it?

I mean yes I want to or want it done. To me 1 << somevalue is just silly 
when you can say BIT(somevalue).

There will be a "make it pretty series".

I'll do a V2 of this series and explain in the commit log what's 
happening with the removal of vc = 0xa; since if someone has to ask, its 
not obvious whats going on.

---
bod

