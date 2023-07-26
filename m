Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484DC763818
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjGZNwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjGZNwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:52:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E2118;
        Wed, 26 Jul 2023 06:52:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso7546965e9.0;
        Wed, 26 Jul 2023 06:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690379522; x=1690984322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbfW0N1EHg8LOIbiDZBCl2zrM+4CsT7HnV7dWADAoqs=;
        b=kYzo7L2O7pRSVlNwaklHki4LcUsRc3JHXcJA4c/ruBb3y5/0QG1CM3Ddmb0Gi66XFp
         Xhr/+dyGtPg128h+XpxakXvi9Vq+5fxMQqiVnhh9FSEqFL5An35srShVnyfgDTyEqt6n
         GHvsELKvdiUFKPBpTjuNVi6aRcPBAt+NdCKILnyH6cnWmSJy5s/VtJkDpBFgJ4SHw+7N
         3arFkAhmIz6+a+EPmO10f1VC7ywb2ev7j/PSLyLCr6oAR2aUdGUwvEc16hspysTomt+9
         tKd8wqpWG7Mg/N1PWfALmcFg8LqqHFTrcec5CjYQbvCrzIpnuYpn9gdTjuwzyerrRKuv
         FB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690379522; x=1690984322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbfW0N1EHg8LOIbiDZBCl2zrM+4CsT7HnV7dWADAoqs=;
        b=eYagbXWs92uiSgwcGynsQXQPnv2bASMyltAs8WFXG3Y4+SDm6A+in1d+DRGGLOpNqi
         /JGwmzl/k8pGn0LcHyFVx+ImBFMP4C3tZIdW/Xm897txNe/wilMLe0HxqktatZ0m/saq
         wmYdnVJK099b06+wwjW04ZGFsEhVVf7tvjoJYl1HoeByUJvzaD5h+6Jjo5s8ZxNQKa6S
         pqUOnCsQh6Qt5PR0oEuZBR83gBcW/QBGNsI0PyAuoY+5guxSBhHai7Quwof0mmGBhFac
         G+BLOLxoy/MGBKVhWhXbipcSHzYNnKhNrsiGj6e0ODFwdy5dKQlyBxpd95EQFOmeou9B
         84gg==
X-Gm-Message-State: ABy/qLYsxsa7kmLR82FUml85TMPOjj7Cjsf+WFwKJE1HbXqHTOcGpcLO
        FcYzzSpMmCGu0zU58FcVw3Y=
X-Google-Smtp-Source: APBJJlEsd0Wc7zCB/Slio2qe6Rve/NHUsRJn82qdYKWEvmI4Ht+aOyal05u4oDWx5QGmAdP//tILQA==
X-Received: by 2002:a05:600c:b59:b0:3f7:c92:57a0 with SMTP id k25-20020a05600c0b5900b003f70c9257a0mr2074345wmr.14.1690379522199;
        Wed, 26 Jul 2023 06:52:02 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id v1-20020a5d6781000000b0031434c08bb7sm19841025wru.105.2023.07.26.06.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 06:52:01 -0700 (PDT)
Message-ID: <721c0d6e-0a28-ae84-1425-a04d95349e05@gmail.com>
Date:   Wed, 26 Jul 2023 14:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][next] accel/qaic: remove redundant assignment to pointer
 pexec
Content-Language: en-US
To:     Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725114037.36806-1-colin.i.king@gmail.com>
 <e457b416-3e63-0bae-0cd7-7788b43f30c1@quicinc.com>
 <c0b314db-bd29-7211-2a70-667405eb5bd0@quicinc.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <c0b314db-bd29-7211-2a70-667405eb5bd0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 14:38, Pranjal Ramajor Asha Kanojiya wrote:
> 
> 
> On 7/26/2023 8:30 AM, Jeffrey Hugo wrote:
>> On 7/25/2023 5:40 AM, Colin Ian King wrote:
>>> Pointer pexec is being assigned a value however it is never read. The
>>> assignment is redundant and can be removed.
>>>
>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>> ---
>>>   drivers/accel/qaic/qaic_data.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/accel/qaic/qaic_data.c 
>>> b/drivers/accel/qaic/qaic_data.c
>>> index e9a1cb779b30..8a6cb14f490e 100644
>>> --- a/drivers/accel/qaic/qaic_data.c
>>> +++ b/drivers/accel/qaic/qaic_data.c
>>> @@ -1320,7 +1320,6 @@ static int __qaic_execute_bo_ioctl(struct 
>>> drm_device *dev, void *data, struct dr
>>>       user_data = u64_to_user_ptr(args->data);
>>>       exec = kcalloc(args->hdr.count, size, GFP_KERNEL);
>>> -    pexec = (struct qaic_partial_execute_entry *)exec;
>>>       if (!exec)
>>>           return -ENOMEM;
>>
>> It does look like pexec is not used in this function after it was 
>> refactored.  Shouldn't the declaration at the beginning of the 
>> function also be removed?
> 
> Yeah we should remove the declaration as well. Although it is used some 
> where to calculate its size i.e. sizeof(*pexec). We need to directly use 
> the type in sizeof() i.e. sizeof(struct qaic_partial_execute_entry).

I didn't remove the variable because of the sizeof(), but it makes sense 
to remove it. I'll send a V2 today
