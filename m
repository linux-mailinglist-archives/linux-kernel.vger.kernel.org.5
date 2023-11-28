Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2112D7FB608
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjK1Jjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjK1JjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:39:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1A519AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:39:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4744d603so13703075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701164355; x=1701769155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F35KnoNBRL3FeAGOoToZvSSFOaDEqHRjPz6QpcJHB9w=;
        b=ZMaIuiDaf2BIJ8TA6LGKFxcWbLL9syKWNzJ3Ab2xu01NIdx67piBqQEOonuYKnpPUD
         /lrpky9nLloZzH94OXpEcVGTuCB2gQdxvqnUOLw/4zpyqmaDBayDEEofnmQPYsX1/VkR
         irPkOexjYla3iGTUqAFj50fHnHs+hWY7lTzhDdmynQlNeJvP86JLRP5z08d/lAeBiQHu
         VhZnnzmTj4UbaUIbfS34iS+92hEm5cvlL0t1ihGJfZDXaqFfkVFUgqEPlMFQlP76eEMx
         5Bu2SNFQUPzaadtPT/2IcDVE1wyyMuJndsyHfTC0kKpQciGB9wK72wUQJIAaNicXul18
         wcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701164355; x=1701769155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F35KnoNBRL3FeAGOoToZvSSFOaDEqHRjPz6QpcJHB9w=;
        b=mGsviHO/wV6MLgswWkibXo6R6NSade1krSO1ONdhs8URLZCnM+p6iyV4vwLbgYn2KH
         rrpwu1D28DzT3fvXdCXa4+MTYzNfIMOgwOlEK4ccPUaA79/ConzA7UkEgqbCByL7tcak
         gB48ylfWniyIyc6TyKoIwipQGi4tDRREL1e4fOBXPPV9x1CxhkJgLULVRUFmE5UDOwMn
         yfwJaBaLBCRrlXcht/wOgdyU604V++pxM0kVZkbVIhIP9ZpF0aV7jZn0z3HHqf4GP2ws
         vzWaRvnV7BJkI7M4zsbXkQ6WNk8e7fYPKA++N0z05gMEWHWVfD75s1+uXsg1sqE+ch9t
         R3zA==
X-Gm-Message-State: AOJu0Yx1lnFYRFHjnURH1ODlsot8YzW/KVckEnwqeGAFY41k6z/Tyi+e
        y+ARAQkJh5bd/wQp4ORHMSgP3rdEXb+6cIkUGhb37w==
X-Google-Smtp-Source: AGHT+IEXQ9CWLukCvGCcAvDbOjjedJ0095mcnpHjjNGA+wRHrHmOcRQ67nOPBQ3Vl8R6qi5y7tkusQ==
X-Received: by 2002:a5d:4e0d:0:b0:332:eeb1:3e7b with SMTP id p13-20020a5d4e0d000000b00332eeb13e7bmr7582956wrt.7.1701164355522;
        Tue, 28 Nov 2023 01:39:15 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d4a46000000b003330b55b941sm1536039wrs.77.2023.11.28.01.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:39:15 -0800 (PST)
Message-ID: <d7bb4580-00b9-4206-bbfc-bd203c21a877@linaro.org>
Date:   Tue, 28 Nov 2023 09:39:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: stop printing superfluous debug info
Content-Language: en-US
To:     liao jaime <jaimeliao.tw@gmail.com>,
        Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, jaimeliao@mxic.com.tw,
        pratyush@kernel.org, richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231127165908.1734951-1-tudor.ambarus@linaro.org>
 <42c96d63d1ea4f7e8f16a3c8eb0a4cf1@walle.cc> <20231128100313.3c990f69@xps-13>
 <18ba4126dbd9e49846344b517ad2fbdd@walle.cc>
 <CAAQoYR=ZAEVeoCwkRmky2CHVeKGX55JijM8Q6D5msz_5iW+jtw@mail.gmail.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAAQoYR=ZAEVeoCwkRmky2CHVeKGX55JijM8Q6D5msz_5iW+jtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


cut

>>> Maybe we don't need this at all, as long as one message remains about
>>> the JEDEC ID, but keep in mind that spi-nors are commonly storing the
>>> rootfs and if your spi-nor does not boot you don't have a userspace yet
>>> and all the debugfs entries are purely useless.
>>
>> Good point.
>>
>> Just curious, do you know any boards which has the rootfs writable on
>> the spi-nor flash?
> I am also interested.
> 

Having the rootfs stored on SPI NOR is a poor design decision as you're
better of with a NAND, which is cheaper and faster on writes. I tried in
the past a ubifs on top of a large (64 and 128MB) SPI NOR flash. But
they were plug-able flashes, not something that is always tied to the
board. Microchip's sama7g5ek comes with a 128MB macronix SPI NOR flash
populated. But there are other vendors that provide large SPI NORs if
really needed.

Cheers,
ta
