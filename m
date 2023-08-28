Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFAB78B5E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjH1RGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjH1RFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:05:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7191E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:05:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so7181337a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693242346; x=1693847146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pwIO6R7Jqbmu9L5I/5/GRG7saX3Pv4HW6F7LDeJGUI=;
        b=CCHnzBttPlwHlsqlDIhPus+alcfuqMStm/P54UY8QrKoXV0108/d7JI+XO6qO8NyjK
         NQobWI/Jo3gLPTRKzUueOL481skRliJDd8xAgrIin5VSOwyq+KLlbDi5H2VUArkVieIB
         SXoJvEQFfRIyLHFfsFjjlYwFJ4rv/rFTrkBpGzS406sq+OHVQeu9gleOGpzgCEZRo6wX
         R8LlMD2M/J4qa4DEzjhf/1eM4BGz+2wd+ICNsWMzro7s1J9fo80r52ssC5mR9wc0Mj6J
         ljzzwi8g8sSdmwdMOypmlOSjMeHeo7e02TgewlGuFvzaDtt5bBJTSY0u7Xbv72faW1ka
         UVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693242346; x=1693847146;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pwIO6R7Jqbmu9L5I/5/GRG7saX3Pv4HW6F7LDeJGUI=;
        b=L1qCHEvy2Qg08Rd3BLqWDbmybV4Akb1uZDntPe/V+BZvIGfQJpNRYE9NzbsajKVDI/
         fu5mPds02BrWKaLspEAQrOoLIsZyVeiHQ0iL0ohjF0SA4ezgBgG2fuE0Wmyr80DXTVcy
         7SdAPdBis/U4f3BpgxmPchD/+RPfoK/kk7iMQsn6C0zFRWO8gOdIrTkm4Jmu/GzhRAJr
         trsK56RasWdHi5p4NvHgGp7xsR9U5mFuYFoSJwGSSlTPdTIXxeK42DlcuizCI1UfN/Ew
         PbVqXygjpOo1zMEv7gr52uC8IBpHaNCrRHh0Dr375SlfkYcLcR3tNeRRED/lUO6wG6F3
         wT1w==
X-Gm-Message-State: AOJu0YxdeBx9xb11g/VgfPUPTtRf9OTvPOjdEnMqOGA4b3Z0EOkLh74X
        a+fCqPbLbFvkeKnYi9YP/eI8Qg==
X-Google-Smtp-Source: AGHT+IHQp/okA1PNTfAJua7UtawTROTLsevYnJuR49B+mPdHq1+Isl83lZjfOMRBu1sVOlpzAjry1Q==
X-Received: by 2002:aa7:d316:0:b0:523:37f0:2d12 with SMTP id p22-20020aa7d316000000b0052337f02d12mr247233edq.17.1693242346189;
        Mon, 28 Aug 2023 10:05:46 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7c94c000000b00528922bb53bsm4652059edt.76.2023.08.28.10.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 10:05:45 -0700 (PDT)
Message-ID: <faf53a03-341c-994e-e66f-46cf88aeaa8e@linaro.org>
Date:   Mon, 28 Aug 2023 19:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] misc: bm92txx: Add driver for the ROHM BM92Txx
Content-Language: en-US
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc:     azkali <a.ffcc7@gmail.com>, Adam Jiang <chaoj@nvidia.com>,
        CTCaer <ctcaer@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230824153059.212244-1-linkmauve@linkmauve.fr>
 <20230824153059.212244-3-linkmauve@linkmauve.fr>
 <f79087c0-cc44-4fb6-fa2e-b43db5dfd6d4@linaro.org> <ZOy33RB8aj3455ZQ@desktop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZOy33RB8aj3455ZQ@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 17:06, Emmanuel Gil Peyrot wrote:
> Hi,
> 
> On Thu, Aug 24, 2023 at 06:28:07PM +0200, Krzysztof Kozlowski wrote:
>> On 24/08/2023 17:30, Emmanuel Gil Peyrot wrote:
>>> From: azkali <a.ffcc7@gmail.com>
>>>
>>> This is used as the USB-C Power Delivery controller of the Nintendo
>>> Switch.
>>>
>>> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
>>> Signed-off-by: azkali <a.ffcc7@gmail.com>
>>> Signed-off-by: Adam Jiang <chaoj@nvidia.com>
>>> Signed-off-by: CTCaer <ctcaer@gmail.com>
>>
>> These do not look like real identities. In this and previous patchset
>> your author emails bounces, so I propose to drop all stale addresses and
>> all anonymous entries.
> 
> I and the authors find that policy inacceptable, our work should be
> credited and our copyright should hold despite our choice of name.

Which authors? The ones who do not want to give real, working email? Or
the ones who do not want to provide known identity, which is required by
our submission process?


Best regards,
Krzysztof

