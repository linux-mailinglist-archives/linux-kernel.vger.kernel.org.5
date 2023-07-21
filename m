Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AE675BE40
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjGUGHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGUGGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:06:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C4630F4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:06:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso2176114a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689919564; x=1690524364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6oeLbJHQPHJsory0G8GdAQcnaceTRpuqb4t2hUd9W0M=;
        b=tPkbVibi9gAA9zTy0NeGUZK9jjXE7OpCmEEJK7A/SnKUcE6peRPSZ6/xHy0eUfg3na
         IbltclfrJbLUXEXLOqBa/X7DgVLj4GbImYIyx4K66G3QXSR29BseA+twrPO5Kyt4ShWW
         qYANRqontkuhFXq6LrLgvv+axP5IyCKQEZ6R43nnYnT1npy9hH8F0OeaXyXq6BYRdkoj
         McSXZzsEY1L7fVqMiSP5TV76psPy4eEGs9GBLgI8QcZuJN1jjJ00dhlvtyZE9YYocdgI
         Q/782AheKRaiXCG5wkpZeEJ/mX+rlgYcDw9khVnH5MdpJ/gm0I+9FqksxsvNiq/ZmxAi
         3rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919564; x=1690524364;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6oeLbJHQPHJsory0G8GdAQcnaceTRpuqb4t2hUd9W0M=;
        b=M2w6CSk2MV0nondgykjVSmt0I8YL2Za41OZiZeU1oJnCrMZkiMoH7nRjl9jn3xBQJ4
         MVER/RIDr05qEO6fi157oNUgMw62qvwDyYygVgKFbsCrFCs0xG9/i7tVlf19ORimDtO8
         JTjtsQBTAA9fzjIyH3SEkMJehYIa2/waBw/oF2ghCHu0T0Gzw9tuOr8A/lxWZBW9o2cT
         xf/NuTWLUl2l1n9elF88fv+rRA6pUAYEDWZAx+Fr24pe/3m1OWV+1kY1ZUSbOnfwfzVs
         ZFoDUAwJ85oj60yk+KIAb7u1aAnwqru7VjllnWNJe/FBEVJAEYdlryTEB8/qWtYMFtxm
         jomg==
X-Gm-Message-State: ABy/qLZRB4l1MquCkuG3YFReoq0lBE3hkN4h96D1Y9LTOsgZVVVZT/yz
        /VhDbyjsNRdsxv8ZmcSwD+prOQ==
X-Google-Smtp-Source: APBJJlEOfrxEKij+gBa5+uU7cDdpg8avuRUf+oyQLYh+lri5b0H7HfQ4hQ4KNnF/lTeU70iwGjk15w==
X-Received: by 2002:a05:6402:519:b0:51e:2974:f471 with SMTP id m25-20020a056402051900b0051e2974f471mr675962edv.42.1689919564253;
        Thu, 20 Jul 2023 23:06:04 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id n4-20020aa7d044000000b00521a7864e13sm1636497edo.90.2023.07.20.23.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 23:06:03 -0700 (PDT)
Message-ID: <55d60aec-3b20-d9d3-aeb2-77abbcc47d16@linaro.org>
Date:   Fri, 21 Jul 2023 09:06:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
To:     Vlim <vlim@gigadevice.com>, Michael Walle <michael@walle.cc>
Cc:     "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "akumarma@amd.com" <akumarma@amd.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>
References: <20230720042834.12296-1-vlim@gigadevice.com>
 <62663146a51c2beac4eff48abe1f61f8@walle.cc>
 <TY0PR06MB56580D3FEE55389F41E33398BB3EA@TY0PR06MB5658.apcprd06.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <TY0PR06MB56580D3FEE55389F41E33398BB3EA@TY0PR06MB5658.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.07.2023 00:48, Vlim wrote:
> Hi, Michael,
> 
> Our parts do support SFDP.
> Can you provide the guideline for the part definition?

There's none at the moment, you have to read the code.

> I do see these samples in the gigadevice.c file; but, not sure of the
> purpose of each parameter.

The flags are defined in drivers/mtd/spi-nor/core.h. Start from there.
> 

All the flashes that you proposed, but one probably (gd25lx256e) can be
probed using the generic spi-nor driver, thus you won't need to add
dedicated flash entries. See:
773bbe104497 mtd: spi-nor: add generic flash driver

Cheers,
ta
