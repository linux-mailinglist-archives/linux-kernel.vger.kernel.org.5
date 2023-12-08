Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B2980A21E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 12:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjLHL0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 06:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHLZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 06:25:58 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D56A10D8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 03:26:04 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9bd3ec4f6so23298291fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702034762; x=1702639562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USaCJIxBwuygiC0IXQHw2FN2+OGuFtnYUDLOCzgwZLY=;
        b=RgNQCaMGBeGyLHbLgKO0+i0jmMslu1o4FtyUn6N9mAyFPE0e88j7bfSUF7wRQ9XWGk
         k3DivQTZHRmhUaf8zz6zZGAwjcOR3XP1u7BaoZHbvTZuZvKLae0q20JHMZdV+ACgyoOt
         TDjKAWmeutRgBvbLIqv1thx8JoLV94yHkA21ArIRlbdAuG9HegbNCX1spIBFGun1ou7K
         R2UnnecJvYobh2rZpFwt4bSwssM2K5+4Gb+WA3owenDGQ2Hd2gJLjVpPYUh8QcQPvx3s
         2GsET58sSLyM19o7wlThxWSoQUT61Q6SMThM6Jn+E9rFx+6lE3tP/h5hLwtEodptGIEQ
         7AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702034762; x=1702639562;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USaCJIxBwuygiC0IXQHw2FN2+OGuFtnYUDLOCzgwZLY=;
        b=ZJoS9IJgvl/c42RTUKb6overK2Gz06oL8Rz0tXSQ5vnVZW4bUjfyzoue0R528fJh5F
         6TqdImppavH3fJuk5a6frJQmmLYFPCKp7vDt+Ee/N4wzLR1wi+ZN0z0+dO9tgj5LcJu4
         GXB/cpziCHPCKKfQ+bCuNj50/bneYn2M4/WQMSKcB0qVCojNCWZGCQrP0hJsBJrjXCXW
         LXm6vXjC4mB99iCBj2gSDOkkgGafQPNahdUOPDPcEqfGl9HE0GeNtHvLgGXQM17h7yxB
         ZTcgMXA79WTe59parXdN3j8oDXzkEBTI1VYtUbpEoGwxWInKFbAY0MStUNIkCxQ5TL5C
         w92A==
X-Gm-Message-State: AOJu0YyvD4Z5+tIKRwsHH5BX3ls+7WcIlVkvxH+wHWaGNpD3dUnRl3ic
        YDMbl2uJkwXqN57X2rh4U305A4jzhatLweou55w=
X-Google-Smtp-Source: AGHT+IHXlUwwd4MUrg758rkG5iwg7wkS7ssfpX8wSmup5N+tEKROLHfGc6a4ZTBNpo1XoIB4vE9qPA==
X-Received: by 2002:a2e:a442:0:b0:2ca:667a:4c98 with SMTP id v2-20020a2ea442000000b002ca667a4c98mr541831ljn.70.1702034762606;
        Fri, 08 Dec 2023 03:26:02 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id q185-20020a2e2ac2000000b002ca2699f14bsm192713ljq.85.2023.12.08.03.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 03:26:02 -0800 (PST)
Message-ID: <28ece7fb-53a9-48d3-9e40-0ef06d5821ce@linaro.org>
Date:   Fri, 8 Dec 2023 11:26:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] nvmem: brcm_nvram: store a copy of NVRAM content
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
References: <20231102062848.23965-1-zajec5@gmail.com>
 <29d2f463-90c2-4c96-8828-96806679db8e@linaro.org>
 <7cb70a8ead5f6b74f0a287ac8832873c@milecki.pl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <7cb70a8ead5f6b74f0a287ac8832873c@milecki.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/12/2023 11:25, Rafał Miłecki wrote:
> On 2023-12-08 12:15, Srinivas Kandagatla wrote:
>> Thank you for the patch,
>>
>> On 02/11/2023 06:28, Rafał Miłecki wrote:
>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>
>>> This driver uses MMIO access for reading NVRAM from a flash device.
>>> Underneath there is a flash controller that reads data and provides
>>> mapping window.
>>>
>>> Using MMIO interface affects controller configuration and may break real
>>> controller driver. It was reported by multiple users of devices with
>>> NVRAM stored on NAND.
>>>
>>> Modify driver to read & cache NVRAM content during init and use that
>>> copy to provide NVMEM data when requested. On NAND flashes due to their
>>> alignment NVRAM partitions can be quite big (1 MiB and more) while
>>> actual NVRAM content stays quite small (usually 16 to 32 KiB). To avoid
>>> allocating so much memory check for actual data length.
>>>
>>> Link: 
>>> https://lore.kernel.org/linux-mtd/CACna6rwf3_9QVjYcM+847biTX=K0EoWXuXcSMkJO1Vy_5vmVqA@mail.gmail.com/
>>> Fixes: 3fef9ed0627a ("nvmem: brcm_nvram: new driver exposing 
>>> Broadcom's NVRAM")
>>
>> Any reason not to add
>> Cc: <Stable@vger.kernel.org>
>> ?
> 
> Not really. I believe stable team would pick this fix anyway (thanks to
> the Fixes:) but doing
> Cc: stable@vger.kernel.org
> is described as strongly preferred.
> 
> Do you think you can just ammend my patch while applying it and add
> Cc: stable@vger.kernel.org
> to it?
Will do.

--srini
> 
