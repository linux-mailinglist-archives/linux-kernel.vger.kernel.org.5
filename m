Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145B078293D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjHUMfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjHUMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:35:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C491
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:35:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fee51329feso11124845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692621337; x=1693226137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Psh1Yg7aHq2F7Ayg3BGMUuPWMlj2ugXpanVVFkKCEuQ=;
        b=wVLQitoO44zGDSIkeuTGrmXWXy4m/ccIYC2yFJRkTiA5uNLT+1Vtcp0ZWrnXsPHigu
         mS7iU954kNWzcx5zaWSNABfT5BZWyK1Mi+VwkHYdRxwECF6Q+WL7pYCKcrs0EQ+d4aZc
         Y8w6QGqtZ6GnzW6yV/b2L1BC06III5CYmCF6HzZ70BCxL6CQ/c6DGhpzOXU8Wg2O9rXf
         cWil4Zq/X4ibnBkog8X4EvRgOifd++368bzJW48Ro5XTM3+0ikgjnWu8B+2scLB74Afd
         BoEVWyEnnt/qd8/4MaH6xvGDrfbXb8E+7PVfhUUs2atkG0WhHDtDgSHyPdRt6QDaEIcc
         7xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692621337; x=1693226137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Psh1Yg7aHq2F7Ayg3BGMUuPWMlj2ugXpanVVFkKCEuQ=;
        b=T1OAVWVqvdqQjh6fk2ZcUunZGgdnpCIq6V8IHmMnVpEK+BTNw81QYS39WMq2oeqxUP
         GoQ3ROf0Pbolxxr1GsSNzRb2iZaWBtHrj70c2EHA7FvM67S3shqi4vRDaByRWrZ2prGU
         9E6h3HIGw9LlBXGSwWMdXas/WX0eghUfWp0a0Z+5VqPKO6sHr0YxyKLp94tHBYmDlbYg
         kV33O3awwM7wBlcXiWnDuNZUBRqPaNbOd+sXvBA3SDKx8xI+ujGX2yfDbZ3MEjJ0TBz2
         hQ0BWpKs1zA5wc/uszNrKFTQA1d8CMiLpVQk5yIosGwxoaCR+0wUE8TevFzXWz8SVNEc
         Fa4A==
X-Gm-Message-State: AOJu0Yzg8TeY+niEJfMGc05EzwIm16BCxIvXfdwJSUnnMxFMKvyJrvMC
        XAf3Y9g6JpylTWAyNyHMlqQGHQ==
X-Google-Smtp-Source: AGHT+IHJqN4nMiwLfU9x7kJBC0WVgqhplnduP2Vx5BXbnBtiFqUiiZX1EmQ7ZHdvMKsKKnYkVGhazg==
X-Received: by 2002:a05:600c:690e:b0:3fb:c257:9f48 with SMTP id fo14-20020a05600c690e00b003fbc2579f48mr4863816wmb.16.1692621337636;
        Mon, 21 Aug 2023 05:35:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:86ea:e59d:2685:7a39? ([2a01:e0a:3cb:7bb0:86ea:e59d:2685:7a39])
        by smtp.gmail.com with ESMTPSA id c1-20020a7bc001000000b003fee567235bsm8457053wmb.1.2023.08.21.05.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:35:37 -0700 (PDT)
Message-ID: <e46f177e-b35d-f6a8-35b1-d260f498c5cf@linaro.org>
Date:   Mon, 21 Aug 2023 14:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
Content-Language: en-US
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-scsi@vger.kernel.org,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd.bergmann@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Tyler Hicks <code@tyhicks.com>,
        "Srivatsa S . Bhat" <srivatsa@csail.mit.edu>,
        Paul Moore <paul@paul-moore.com>,
        Allen Pais <apais@linux.microsoft.com>
References: <20230722014037.42647-1-shyamsaini@linux.microsoft.com>
 <20230722014037.42647-2-shyamsaini@linux.microsoft.com>
 <CAPDyKFoBC+GaGerGDEAjg9q4ayV9mMBKkfFk3nO-zcQzOZ_H6Q@mail.gmail.com>
 <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com>
 <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
 <CAFA6WYNPViMs=3cbNsEdhqnjNOUCsHE_8uqiDTzwCKDNNiDkCw@mail.gmail.com>
 <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
From:   Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAHUa44Ek0k2b-igA6Gd1ZXVzibTh2sNDMnE-weQwFFKEZ_1jOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 13:18, Jens Wiklander wrote:
> On Mon, Aug 21, 2023 at 12:03 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>>
>>>
>>> On 8/17/23 01:31, Shyam Saini wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
>>>>> <shyamsaini@linux.microsoft.com> wrote:
>>>>>>
>>>>>> From: Alex Bennée <alex.bennee@linaro.org>
>>>>>>
>>>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>>>>>> originally proposed by [2]Thomas Winkler ]
>>>>>>
>>>>>> A number of storage technologies support a specialised hardware
>>>>>> partition designed to be resistant to replay attacks. The underlying
>>>>>> HW protocols differ but the operations are common. The RPMB partition
>>>>>> cannot be accessed via standard block layer, but by a set of specific
>>>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>>>>>> partition provides authenticated and replay protected access, hence
>>>>>> suitable as a secure storage.
>>>>>>
>>>>>> The initial aim of this patch is to provide a simple RPMB Driver which
>>>>>> can be accessed by Linux's optee driver to facilitate fast-path for
>>>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>>>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>>>>>
>>>>>> A TEE device driver can claim the RPMB interface, for example, via
>>>>>> class_interface_register(). The RPMB driver provides a series of
>>>>>> operations for interacting with the device.
>>>>>
>>>>> I don't quite follow this. More exactly, how will the TEE driver know
>>>>> what RPMB device it should use?
>>>>
>>>> I don't have complete code to for this yet, but i think OP-TEE driver
>>>> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
>>>> specific implementation for RPMB operations.
>>>>
>>>> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
>>>>
>>
>> It would be better to have this OP-TEE use case fully implemented. So
>> that we can justify it as a valid user for this proposed RPMB
>> subsystem. If you are looking for any further suggestions then please
>> let us know.
> 
> +1
> 
>>
>>>> [1] U-Boot has mmc specific implementation
>>>>
>>>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
>>>> CFG_RPMB_FS_DEV_ID=1 for /dev/mmcblk1rpmb,
>>>
>>> Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
>>> is given and use the specified RPMB instead (the CID is a non-ambiguous way
>>> to identify a RPMB device).
>>>
>>>> but in case if a
>>>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
>>>> should be declared as secure storage and optee should access that one only.
>>>
>>> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
>>>
>>>> Sumit, do you have suggestions for this ?
>>>
>>
>> I would suggest having an OP-TEE secure DT property that would provide
>> the RPMB CID which is allocated to the secure world.
> 
> Another option is for OP-TEE to iterate over all RPMBs with a
> programmed key and test if the key OP-TEE would use works. That should
> avoid the problem of provisioning a device-unique secure DTB. I'd
> expect that the RPMB key is programmed by a trusted provisioning tool
> since allowing OP-TEE to program the RPMB key has never been secure,
> not unless the OP-TEE binary is rollback protected.

+1 if we can assume the same key won't be used for several devices, which
is probably reasonable.

> 
> Cheers,
> Jens
> 
>>
>> -Sumit
>>
>>>
>>> --
>>> Jerome
