Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637D756AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGQRej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGQReY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:34:24 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504B6CC;
        Mon, 17 Jul 2023 10:34:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so3110098b3a.0;
        Mon, 17 Jul 2023 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689615262; x=1692207262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dUoi1Mmr8IMK534APH+CWG7qY8Kuyh2p4qso744suGo=;
        b=dnzydAvEN9YKARwMthDayszanj76dr67zlOjek2z19bKs+DhWqcD0TxQOdtYPy0yLC
         jtunZLbbV7avrJrx8DE05sppNwgr4k1WbozR5pICNcFaF4ohwYqi68Wwg0z3D2Z2tCJK
         BCwuyzaNwrLn9S55IX/Qm5+k67U47Baow+iVxhAKTocY/EhYr7FAsWQozYbSHYGJ+V7h
         hPy09nr4O6X38+slC+30vzZFCf1SxTpXsbbSiJUj4ChUA3t+jjmCS46i/pPKkCT75uBG
         zN4Lwy8Q/UPax6vRK7ApcFMuiypogMlfS2qKE1CQMxnyOQXMYHRoqUiNskeR69OmBtmp
         soqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689615262; x=1692207262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dUoi1Mmr8IMK534APH+CWG7qY8Kuyh2p4qso744suGo=;
        b=SxcGHGx/ayayCIIUOBUKXZNDU5fb0/8ArmIDAi8L+CyDuWJF0d5a2oQ8jU8KUnCboQ
         eiWDovH6p7652GqXpoZJwZBSo2DkM7U9cd7eUnVWbfxUcgttafT+0Lq3DSxVV6YDO7dL
         kmtC6EiGMdSegmgbbQIDZPX9X0Ad2ncT7d8uPD9G6qGulqhSkajFb0UgW9BnCUVzmKhN
         hAn2VC3+4JZT8E4DvjZWzuUY2oUFfOYIXH+BvG72Ux9Tlw6fDZb4ReVlDQxu/v084wBP
         LsxxFV4j1TU3yiqZoobaBDdGYJ9dze/LUUCVFhFTIQB4e1voq/m4HELG0zV+JeqPsDPx
         TEDA==
X-Gm-Message-State: ABy/qLYWJNqLMVwc0os5YfAu0n2foKNe5dgXt+hTxgChQcRcXOs7HQ9P
        OTVTghlNoMul7wQD0s/wSkY=
X-Google-Smtp-Source: APBJJlHgiE4S+MXfi6uaGWczHajeTCKhbKry4gKne+v0Nr5Vemydgez1HyMd0UNJpeoHBOwwOlVSZA==
X-Received: by 2002:a05:6a00:17a1:b0:682:4ef7:9b17 with SMTP id s33-20020a056a0017a100b006824ef79b17mr16331177pfg.32.1689615262353;
        Mon, 17 Jul 2023 10:34:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t5-20020a62ea05000000b0063b96574b8bsm58971pfh.220.2023.07.17.10.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:34:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a4b0115d-7a06-100c-ec77-027493c86206@roeck-us.net>
Date:   Mon, 17 Jul 2023 10:34:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, patches@opensource.cirrus.com
References: <20230714174607.4057185-1-robh@kernel.org>
 <e0e1b465-8419-419e-90ae-4b72f5189469@roeck-us.net>
 <CAL_JsqJZcxoQEhaGr34Mk1P_8vc8wctcfzswWc8VbRrsv0S7zg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAL_JsqJZcxoQEhaGr34Mk1P_8vc8wctcfzswWc8VbRrsv0S7zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 10:24, Rob Herring wrote:
> On Sat, Jul 15, 2023 at 10:55 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Jul 14, 2023 at 11:46:04AM -0600, Rob Herring wrote:
>>> The DT of_device.h and of_platform.h date back to the separate
>>> of_platform_bus_type before it as merged into the regular platform bus.
>>> As part of that merge prepping Arm DT support 13 years ago, they
>>> "temporarily" include each other. They also include platform_device.h
>>> and of.h. As a result, there's a pretty much random mix of those include
>>> files used throughout the tree. In order to detangle these headers and
>>> replace the implicit includes with struct declarations, users need to
>>> explicitly include the correct includes.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> Applied to hwmon-next.
> 
> I found there's a double include of of.h in lm75.c. Can you fix that
> up or do you want me to send a fix?
> 

I fixed it up. Thanks a lot for noticing.

Guenter


