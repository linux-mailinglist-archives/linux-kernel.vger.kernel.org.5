Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6385675C007
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjGUHms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGUHmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:42:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187772D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:42:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f122ff663eso2550185e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689925360; x=1690530160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6b2RlLMnUcUxkONDEOiGaaHL2LvD7/k1R8DHltB5lI=;
        b=sXxNhEZxGZhTW89/oH4zXhDNMdpeXroeiAsJPAvNTZIj9lD2Tt7XmEEo7GAkcQXYEh
         Mz6ca5/qddyAAhHZtom2S3PGTAe69N2fbi2tqYm49bcc+sRu4OJU/pP0cPTQHmi/9tEl
         0wHBq9PXAY3V/38vjG6M6LS2Au2Bmbw8U05ivvoOB2/7bvOJglPrv/IcFvK8Rsp8/mNT
         6rtvkGmT4ilqHGRqJCCh2N5zr0bVQbYCzGEfOaccacBbvh0ULF5s/+M3ZQCrKeFcg+GA
         XJiHRrskx+nit95N0NNz1dPDP+e5QGy9gWqM9mkFTIei/bdVSbOcXbQF0rt067jHEQiL
         1WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689925360; x=1690530160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6b2RlLMnUcUxkONDEOiGaaHL2LvD7/k1R8DHltB5lI=;
        b=ZCTIQjt+AvQ5K7zRgjOe4tYk0s9D/ooT3eOIBt+jNsl4RfUvGf29qeNCZcYjW8nUT3
         FoRZgsDkZOWsG9o2jzh+vFhAoXGNhHkWQzmYNJKeNAljQtvDpYxw9SMeSpRrx7h7gmVB
         lxMgfGyt3VRmabrcMGtaPEWS/n6EAPhIV2FBeLrsbEwOeR6uYlYDLusz64CWjDKDpR4p
         eeuIogF5Wa6O9nmOZ8Cnu81KJjcNGoOjUn2/UCpjJQrpyh886elCC2JqpWYgQBxZSc7j
         rEDQ+P84x88nU9QCdSWQyK+CWYUpfEnzDP99LHzudA/PvEnzrpz7BKPjNZdIf8TRVVxR
         4BpQ==
X-Gm-Message-State: ABy/qLYP8XrnLLfDQeeWjXnR6TykLW5ZRPfiRZjKaSiWPTmYUR+r2EvF
        yNDt9sH4Wo2B0XEyjc0WUe8E8Q==
X-Google-Smtp-Source: APBJJlEbYCNrn7C+6/E9uaWKDwNcBrYmJdLhv2uLorLqRu9XxP5utJItY7ejTIp1HFvL1ZgD9HM69w==
X-Received: by 2002:a05:6512:39cf:b0:4f9:54f0:b6db with SMTP id k15-20020a05651239cf00b004f954f0b6dbmr838258lfu.13.1689925360263;
        Fri, 21 Jul 2023 00:42:40 -0700 (PDT)
Received: from [192.168.0.173] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id z24-20020aa7c658000000b0051e166f342asm1732520edr.66.2023.07.21.00.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 00:42:39 -0700 (PDT)
Message-ID: <5cf51874-f622-fc3d-86cb-b12f09dc57d1@linaro.org>
Date:   Fri, 21 Jul 2023 10:42:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V1 1/1] linux: drivers: mtd: spi-nor: gigadevice.c
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Vlim <vlim@gigadevice.com>, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        akumarma@amd.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, vikhyat.goyal@amd.com
References: <20230720042834.12296-1-vlim@gigadevice.com>
 <62663146a51c2beac4eff48abe1f61f8@walle.cc>
 <TY0PR06MB56580D3FEE55389F41E33398BB3EA@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <55d60aec-3b20-d9d3-aeb2-77abbcc47d16@linaro.org>
 <TY0PR06MB56581B9A28DCD7A7270CFC0ABB3FA@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <130b3742-fe0b-2030-654f-0cf8863c1479@linaro.org>
 <3795b6594981a236481f70f9172d140b@walle.cc>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <3795b6594981a236481f70f9172d140b@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.07.2023 10:41, Michael Walle wrote:
>>>
>>> { "gd25q128", INFO(0xc84018, 0, 64 * 1024, 256)
>>>             FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>>
>> The locking support is not part of the JEDEC SFDP standard, but vendors
>> can define their own SFDP tables where they describe the locking
>> support. So for now, if you want to enable locking you have to specify
>> the locking flags, whatever they are. There are different flavors of
>> block protection locking, with 3 or 4 block protection bits, their
>> order, etc. You'll have to check the datasheet.
> 
> I've seen that gigadevice has their own proprietary SFDP table which
> also indicates locking. I'd prefer to have a parser for these, esp.
> because the patch is coming from the vendor itself :)
> 

Yes, I agree.
