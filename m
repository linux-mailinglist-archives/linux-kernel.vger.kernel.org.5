Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49C07AD9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjIYOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIYOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:01:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F62DC0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:01:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32172f8a5dbso5434888f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695650506; x=1696255306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B65znnPKGc/kSnG351YXtEb2b6JUEftCxKy2HXeBLEs=;
        b=O1onFIGPnMoicI1+K/Bb6k+wx5ts7f2hbjzMy5IEIIyHB2Ls/9r44GuLBdZ5nHwiju
         dAcu2w5YMl12QN+WsnK27pR1mCgzGcliAehGsEc2OF2CPhHKL2/mQldGaXH7tFi+AauF
         RJEpatGn+pR+Lr+go8qD54SwzVPuM7JyFInSmjs8CLASl7jUI05RMf7xHmSEnUZR0Q0h
         A2tPJ4Oyt2ojrRTy9Ut4lCAHWtTj2eTP/hg9T44PGs5nCzrxo8KSzekV6ITkSXJssRy1
         sh9MnfNajMvGJSgEAxQL/ohkHtoN1S3+DzPhSNXPtr2muT86XS3t2IfyuVRWOiuyVggu
         tKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695650506; x=1696255306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B65znnPKGc/kSnG351YXtEb2b6JUEftCxKy2HXeBLEs=;
        b=gNaQOofxLmWqfC3weE1HD7SmGH03w4a4d3+cD0eN2C+tzIRSo4R5TYPvgXDbVmi4lx
         QqaT1Z7NAKVjUY6ETpSmvmqWxJnFWfMW6bdTgykZGvBdXBHRo598rAyCyg6vDCqu5563
         KRfcO2yaF+5xGmPgNj/LvxLXwc5tK8Q/IdE/hD3IZmQKHUy392j8JFrMxuCpCfbytSZj
         S2d8NkOho7nWJma2ovHliOExyV6s4lpZXCdLU4qSMcVrm0KVqpm1/RD5klsEQQAbHM9e
         vBCc7OMvoe2fWfbz9ZhFDE+6lqcEFhyNNkjCS6/oE7EtUl2hum1ry8CMBf/azRdm+ZCN
         1XUQ==
X-Gm-Message-State: AOJu0Yz/I1jnSOILElmEpMCSvDvZcPbd4SXC1FqwoGNu35GdFYzE7T3d
        ZTWsK1aMAwl71yW37h13hxhgTw==
X-Google-Smtp-Source: AGHT+IH6A3pXZQDF358jCVZZKD5lXk/EW6dIzhrStDEO3z42JkDq/nm/3gH9pTecMt9SP6HzX8xbxg==
X-Received: by 2002:a5d:58ee:0:b0:31f:f94f:e13f with SMTP id f14-20020a5d58ee000000b0031ff94fe13fmr6689312wrd.19.1695650505606;
        Mon, 25 Sep 2023 07:01:45 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d58f2000000b00317b0155502sm11943090wrd.8.2023.09.25.07.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 07:01:45 -0700 (PDT)
Message-ID: <a6991564-c496-4f87-9a32-c107de0214d7@linaro.org>
Date:   Mon, 25 Sep 2023 15:01:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] media: qcom: camss: Comment CSID dt_id field
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
 <20230911131411.196033-18-bryan.odonoghue@linaro.org>
 <1e815d41-719a-4ca1-98e3-872f882ed03e@xs4all.nl>
 <20230925081452.GA8583@pendragon.ideasonboard.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230925081452.GA8583@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2023 09:14, Laurent Pinchart wrote:
> On Mon, Sep 25, 2023 at 09:11:52AM +0200, Hans Verkuil wrote:
>> On 11/09/2023 15:14, Bryan O'Donoghue wrote:
>>> Digging into the documentation we find that the DT_ID bitfield is used to
>>> map the six bit DT to a two bit ID code. This value is concatenated to the
>>> VC bitfield to create a CID value. DT_ID is the two least significant bits
>>> of CID and VC the most significant bits.
>>>
>>> Originally we set dt_id = vc * 4 in and then subsequently set dt_id = vc.
>>>
>>> commit 3c4ed72a16bc ("media: camss: sm8250: Virtual channels for CSID")
>>> silently fixed the multiplication by four which would give a better
>>> value for the generated CID without mentioning what was being done or why.
>>>
>>> Next up I haplessly changed the value back to "dt_id = vc * 4" since there
>>> didn't appear to be any logic behind it.
>>>
>>> Hans asked what the change was for and I honestly couldn't remember the
>>> provenance of it, so I dug in.
>>>
>>> Link: https://lore.kernel.org/linux-arm-msm/edd4bf9b-0e1b-883c-1a4d-50f4102c3924@xs4all.nl/
>>>
>>> Add a comment so the next hapless programmer doesn't make this same
>>> mistake.
>>>
>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> ---
>>>   drivers/media/platform/qcom/camss/camss-csid-gen2.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
>>> index 6ba2b10326444..cee50fc87e9de 100644
>>> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
>>> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
>>> @@ -352,6 +352,11 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>>>   		phy_sel = csid->phy.csiphy_id;
>>>   
>>>   	if (enable) {
>>> +		/*
>>> +		 * A value caled 'CID' gets generated internal to CAMSS logic
>>
>> caled -> called
>>
>>> +		 * which is a concatenation of [vc:6 | dt_id:2] hence we reuse
>>
>> vc:6? Do you mean bit 6 or do you mean the least significant 6 bits?
>>
>> Regardless, since the vc variable <= 3 (since MSM_CSID_MAX_SRC_STREAMS is 4),
>> either interpretation makes little sense.
> 
> More recent versions of CSI-2 support up to 6 bits of VC (or possibly
> even more in versions I may not know about). It would probably make
> sense to write vc[5:0] | dt_id[1:0] or something similar.
> 
>> And what does "DT" stand for?
> 
> Data Type.
> 
>>> +		 * the least significant two bits of the VC to 'stuff' the CID value.
>>> +		 */
>>>   		u8 dt_id = vc;
>>
>> If dt_id should be the least significant two bits of vc, shouldn't
>> this say: "= vc & 3;"? Or, alternatively, have a comment that vc <= 3?
>>
>>>   
>>>   		if (tg->enabled) {
> 

I'll rewrite this comment since its still confusing people.

@Hans VC and DT are fields in the CSI protocol structure sections 
2.2.2.2 and 2.2.2.3

https://www.nxp.com/docs/en/application-note/AN5305.pdf

---
bod
