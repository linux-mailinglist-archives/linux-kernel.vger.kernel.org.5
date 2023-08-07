Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D874C77293D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjHGPbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHGPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:31:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A769D;
        Mon,  7 Aug 2023 08:31:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so28796345ad.3;
        Mon, 07 Aug 2023 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691422279; x=1692027079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3t3bqscy3WQ1ZHKk3TawW56eOEGzmCU0ozcUehoKFHA=;
        b=pKLMs5PPUdYnsVBRcQvcO/gGgACELGYHtTOxCivbG/vNNRL8C6dEQHNBxEtvpdt9ba
         WDM0VjO6PHZnV2pPhZKsHTJGG+16s84WYxx9oH6JUzt+52uuepl3PQ0IYqQX5w7WAHqw
         y7dQaIc+Yn3btbjqS7EIg/W1XBpxz+QHkHr8duU10NCRSwEI3MrCw0geG1qTsPWMb6JW
         Tpp/ftlkRoSqxLVY4803C0FV1YGqlFbVlZiMRf2Q47YUoOeCsuyRNmOQv77RJ7e2BLX3
         IEhi0Te6MdQa00HkheuIBRQ/7oIMFZmgkthgel8s6iwcYubiFROktUrpgHDVpXQ8lpy1
         izzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691422279; x=1692027079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3t3bqscy3WQ1ZHKk3TawW56eOEGzmCU0ozcUehoKFHA=;
        b=Njip4ISkmuUm1NwYWM8PhJP+v8zmQULVCXQtaFOyi4vWLmZQJfeZtmbXweRvby7hG/
         eq5E6t26ABMDJO1ANITYCnsnL9wbwEDUQ28OcUcE6bv+Y7tR84L6nOiv4Cr2MT40qCcl
         TtfEAs7nxJ/0ZAbx1Cww/2GH2BOMbC2DaF/VRoUYWGmyP9yHOigo5xNjCS8LS+BCNi4m
         UHa47f9YZJ1VYXjSByJtHvMcpFiXDidpbIdzzKTMe8kwYV8bLgZjWlEe5PpFDVZk5BMS
         y9ssLyp2lGLHwjPz6b6q+GRImMbddIyu/mPeQf888groX219PuNdJznvK+ElGRrx/q2R
         hSSA==
X-Gm-Message-State: AOJu0YzF8Is2+Suc8EvzbVwuyWJlqjVBz+xDUKlw9q4C/srSDPRq9nPB
        nQVmn5eh2DGMLtgl32eWxKPdSfwC1W4JQdAA
X-Google-Smtp-Source: AGHT+IFyhr6u9s2soovfCRmnzc495lIpnL12W6fHEvmBCbeMhZnZX++395CTXDeyds1tePQluIef2Q==
X-Received: by 2002:a17:90a:4587:b0:269:155a:c936 with SMTP id v7-20020a17090a458700b00269155ac936mr7287464pjg.28.1691422278647;
        Mon, 07 Aug 2023 08:31:18 -0700 (PDT)
Received: from ?IPV6:2601:204:df00:9cd0::c121? ([2601:204:df00:9cd0::c121])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090add9300b0026596b8f33asm8861465pjv.40.2023.08.07.08.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 08:31:18 -0700 (PDT)
Message-ID: <7fab4b8b-5809-49d1-a7cc-2c93bb2bbda1@gmail.com>
Date:   Mon, 7 Aug 2023 08:31:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ath6kl: replace one-element array with flexible-array
 member
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230804045554.6934-1-rauji.raut@gmail.com>
 <2023080433-patio-staining-2cfe@gregkh> <87sf8zs2oi.fsf@kernel.org>
 <2023080410-unadorned-vertigo-c0b8@gregkh>
 <47f1a06b-8bfe-911a-3a05-da7d522b588f@quicinc.com>
Content-Language: en-US
From:   Atul Raut <rauji.raut@gmail.com>
In-Reply-To: <47f1a06b-8bfe-911a-3a05-da7d522b588f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Considering everyone's input/comments, will refrain from altering this or

other submitted patches, as advised.

-Atul

On 8/7/23 07:13, Jeff Johnson wrote:
> On 8/4/2023 2:30 AM, Greg KH wrote:
>> On Fri, Aug 04, 2023 at 10:10:37AM +0300, Kalle Valo wrote:
>>> Greg KH <gregkh@linuxfoundation.org> writes:
>>>
>>>> On Thu, Aug 03, 2023 at 09:55:54PM -0700, Atul Raut wrote:
>>>>
>>>>> One-element arrays are no longer relevant, and their
>>>>> place has been taken by flexible array members thus,
>>>>> use a flexible-array member to replace the one-element
>>>>> array in struct ath6kl_usb_ctrl_diag_cmd_write
>>>>>
>>>>> This fixes warnings such as:
>>>>> ./drivers/net/wireless/ath/ath6kl/usb.c:109:8-12: WARNING use 
>>>>> flexible-array member instead 
>>>>> (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
>>>>>
>>>>> Signed-off-by: Atul Raut <rauji.raut@gmail.com>
>>>>> ---
>>>>>   drivers/net/wireless/ath/ath6kl/usb.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath6kl/usb.c 
>>>>> b/drivers/net/wireless/ath/ath6kl/usb.c
>>>>> index 5220809841a6..c8ecc9e85897 100644
>>>>> --- a/drivers/net/wireless/ath/ath6kl/usb.c
>>>>> +++ b/drivers/net/wireless/ath/ath6kl/usb.c
>>>>> @@ -106,7 +106,7 @@ struct ath6kl_usb_ctrl_diag_cmd_write {
>>>>>       __le32 cmd;
>>>>>       __le32 address;
>>>>>       __le32 value;
>>>>> -    __le32 _pad[1];
>>>>> +    __le32 _pad[];
>>>>
>>>> Are you sure this is actually a variable length array?
>>>
>>> It's not, it's just padding. We both told this in v1:
>>>
>>> https://patchwork.kernel.org/project/linux-wireless/patch/20230731012941.21875-1-rauji.raut@gmail.com/ 
>>>
>>
>> Hey, I'm consistent, nice!  :)
>>
>> But Atul, that's not good to ignore our review comments. Usually that
>> ends up meaning that everyone will then just ignore your submissions,
>> generally a not-good resolution.
>>
>> thanks,
>>
>> greg k-h
>
> Since the 'pad' field is never directly accessed, suggest the author 
> respin this this to use simply:
>     __le32 _pad;
>
> That will prevent others from trying to "fix" this actual one-element 
> array in the future.
