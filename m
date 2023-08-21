Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1878267C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHUJtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHUJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:49:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C1791
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31c3df710bdso854273f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692611359; x=1693216159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sSvoRy7pHM24HvuKyCDk4ZOyjKwBTskjmD2ROspre9E=;
        b=tYxWADTkgBkCM3YwWAPugmBztT4bc8tXPky17DRaN53c3tT6ojyXUauUdsuO71dWSw
         xpIk6spPcjhbkzrtSCTgOsteMlb8AGlrmNmcbg03OjINB5IhoQm4/0y95OpyY9ojbQKB
         FmvFGKzdPc0+ppDAvCK5ix6hq0hv+FOuSkDbzMfeCkJEpABHHPnrxO+m/HeGoPVwBuyZ
         3vhIk8EEM8iqapb4gd3u2QtMXa6jq/HfhDuRTT8uLZJjPLaRt2hkplIRxTmw9QMx2UAj
         JDtjISCof3twuIM6wRvW2ljAGwIgCTQpqG0uGVp+9rmvllLQ4nAhmrjpVa6irghqgVTX
         tW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611359; x=1693216159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSvoRy7pHM24HvuKyCDk4ZOyjKwBTskjmD2ROspre9E=;
        b=On1O2bmVTtm1COH7FyE3wAlqQxriT/CD7+6FNFmXK7m1wHZjlluR7WU3MHbDhhon0y
         +PbWVWIIKAyJpIoiFX69JbrORKG9pzD1iFhir3VjV0TICQL6YTKc4HoOBSKoxo8iVv/A
         k0i5go8sZTcxq6yJLXqECpmHwinQx9603JGMfvPR70mD5nPlRz0SCseBX3YWCwyoh4Jw
         FO3b916C9cDE29oPxtKx4u6UFWvFNPufNoYhWm16XXHc7OxXbyM1LNzoSroekiLGwoNB
         7kPjH/T4nvl9QIscDVNCxGm6DbfrxQJXojDXj8xpvGkHuyNze7m2luSZBd8ZqdYn6DUB
         GJUg==
X-Gm-Message-State: AOJu0Yz8akWlOlKa5e7afrgAuZR5hj1B2ZfkhpWWxZ0V7xSJX6JyoZdz
        1ZG0MJR0F2ShaWCxi4ld7DQf8A==
X-Google-Smtp-Source: AGHT+IGR8J+UxmGlPhMYPoghyRo+W4JZb8uPZ1wIyKUB8DuWVNka4u16jKnVlBcMDbQgJIWDu8EQNw==
X-Received: by 2002:adf:f184:0:b0:314:1fd7:188b with SMTP id h4-20020adff184000000b003141fd7188bmr4440406wro.17.1692611359488;
        Mon, 21 Aug 2023 02:49:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:86ea:e59d:2685:7a39? ([2a01:e0a:3cb:7bb0:86ea:e59d:2685:7a39])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm11895702wrm.81.2023.08.21.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 02:49:19 -0700 (PDT)
Message-ID: <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
Date:   Mon, 21 Aug 2023 11:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB)
 driver
To:     Shyam Saini <shyamsaini@linux.microsoft.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
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
Content-Language: en-US
From:   Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <b875892c-1777-d84a-987e-1b0d5ac29df@linux.microsoft.com>
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



On 8/17/23 01:31, Shyam Saini wrote:
> 
> Hi Ulf,
> 
>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
>> <shyamsaini@linux.microsoft.com> wrote:
>>>
>>> From: Alex Bennée <alex.bennee@linaro.org>
>>>
>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>>> originally proposed by [2]Thomas Winkler ]
>>>
>>> A number of storage technologies support a specialised hardware
>>> partition designed to be resistant to replay attacks. The underlying
>>> HW protocols differ but the operations are common. The RPMB partition
>>> cannot be accessed via standard block layer, but by a set of specific
>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>>> partition provides authenticated and replay protected access, hence
>>> suitable as a secure storage.
>>>
>>> The initial aim of this patch is to provide a simple RPMB Driver which
>>> can be accessed by Linux's optee driver to facilitate fast-path for
>>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>>
>>> A TEE device driver can claim the RPMB interface, for example, via
>>> class_interface_register(). The RPMB driver provides a series of
>>> operations for interacting with the device.
>>
>> I don't quite follow this. More exactly, how will the TEE driver know
>> what RPMB device it should use?
> 
> I don't have complete code to for this yet, but i think OP-TEE driver
> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
> specific implementation for RPMB operations.
> 
> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
> 
> [1] U-Boot has mmc specific implementation
> 
> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
> CFG_RPMB_FS_DEV_ID=1 for /dev/mmcblk1rpmb,

Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
is given and use the specified RPMB instead (the CID is a non-ambiguous way
to identify a RPMB device).

> but in case if a
> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
> should be declared as secure storage and optee should access that one only.

Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.

> Sumit, do you have suggestions for this ?


-- 
Jerome
