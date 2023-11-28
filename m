Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339237FB637
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjK1JrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjK1JrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:47:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C949BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:47:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332ff20ec45so1224923f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701164844; x=1701769644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17OVECw9ZyIvNd7UnMV0T6pf2VqgLZybeLe5F+y1r5M=;
        b=ATPNJGYMoER83R3sIthZj5IjgmWI7cBBQVQrRrov8y1gZVNrAdp16AyJBTPiBUIXAA
         zRB1wit6k0gYsHlVimH4ArKyuKwbTc3Up4O6LeFaf/kWSn3H7iSxPVBWPwwsC7l0cNol
         LeSpJ4QkFSvXVJHlpjnd7bDrOAnhDcYgTzAf5gLZBrApGiEiEvpCtwRrcoA+dqODt2kH
         DQOAc2D52SE8kOR9y4Ylv5IdZniPPqbdPrjlDLmY/FicySsw8QYbGa0f5btkp3GFIUX+
         FUxy5eKUB0CimPVcM1uL7mIMInECLtZJHBuVKVarNPFqfv6cpfzErJXvazQnX6s5kcMu
         JoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164844; x=1701769644;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17OVECw9ZyIvNd7UnMV0T6pf2VqgLZybeLe5F+y1r5M=;
        b=mNFWXFEucOHgh+wV8WzB9i5vh7wdw0CO2aNFCKbmxRhzhgmHKWdpoY5gS9zYxKJcnl
         hTwEsuh++VtUr80lEr/YfKmD658TupsR7hgluzgnCwepOMCnIAR+SDqWyfF/rOzQ5Cbi
         I+BQ2aV7yuwJbW2u4FPtd1jGZmk3c62NIOb/2ogq3+pfqaz0LPuYDvR84LA0mzYSqU/j
         YcO3UmKeoR8AYhrRwGYIimtd3QhYURl1JlzpAPdqYBh4ZcmiIA7ulE7sV1B88lszIQ8g
         tHwhHVzZf3cpogzTgYDTz4bPFUgR0+T3Jg46n1tjW0oMoCm/S/TFQ+SIOBKTZZU//Duh
         6LFw==
X-Gm-Message-State: AOJu0Yw0sL1MmszPBGGXV564EZoAzq6f2TnlbL136oVmIR6I6cxq8dFF
        a4BeuXa7FJDj3RG7bmrJRcS1fg==
X-Google-Smtp-Source: AGHT+IGGg08aCxfIPrzMMes/KxlsIWnf3kFNAcSKvy9WP3mscT+KwjnNLKMzqvCYrq32Thf9LIWDPA==
X-Received: by 2002:a5d:4e8c:0:b0:332:e75c:a3ae with SMTP id e12-20020a5d4e8c000000b00332e75ca3aemr13004949wru.13.1701164844114;
        Tue, 28 Nov 2023 01:47:24 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d69d0000000b00332cddd7468sm14399160wrw.40.2023.11.28.01.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:47:23 -0800 (PST)
Message-ID: <756aa94a-3237-4689-885a-1e17504e72b6@linaro.org>
Date:   Tue, 28 Nov 2023 09:47:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     liao jaime <jaimeliao.tw@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, jaimeliao@mxic.com.tw,
        pratyush@kernel.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
 <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc> <20231128100313.3c990f69@xps-13>
 <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
 <CAAQoYR=ZAEVeoCwkRmky2CHVeKGX55JijM8Q6D5msz_5iW+jtw@mail.gmail.com>
 <d7bb4580-00b9-4206-bbfc-bd203c21a877@linaro.org>
In-Reply-To: <d7bb4580-00b9-4206-bbfc-bd203c21a877@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/23 09:39, Tudor Ambarus wrote:
> 
> cut
> 
>>>> Maybe we don't need this at all, as long as one message remains about
>>>> the JEDEC ID, but keep in mind that spi-nors are commonly storing the
>>>> rootfs and if your spi-nor does not boot you don't have a userspace yet
>>>> and all the debugfs entries are purely useless.
>>>
>>> Good point.
>>>
>>> Just curious, do you know any boards which has the rootfs writable on
>>> the spi-nor flash?
>> I am also interested.
>>
> 
> Having the rootfs stored on SPI NOR is a poor design decision as you're
> better of with a NAND, which is cheaper and faster on writes. I tried in
> the past a ubifs on top of a large (64 and 128MB) SPI NOR flash. But
> they were plug-able flashes, not something that is always tied to the
> board. Microchip's sama7g5ek comes with a 128MB macronix SPI NOR flash
> populated. But there are other vendors that provide large SPI NORs if
> really needed.
> 

pressed sent too soon :). What I wanted to say is that it's not uncommon
for vendors to populate large SPI NOR flashes, there are others as well,
thus Miquel's concerns are valid. There may be people out there having
rootfs on top of SPI NORs.

Cheers,
ta
