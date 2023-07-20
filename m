Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87B775A6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGTGun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjGTGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:50:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327622121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:50:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9922d6f003cso81893666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689835836; x=1692427836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P0g/IBsPZGY5PxZfIKc7/6gIDE3jbSDKqZLxVCtbNmM=;
        b=Oie91okDf4TmQaL1csHvGo+xD5lYbjqxP+Y/+z633ZjSv+gZcB9UuUtkVx48D2RSKW
         IgISxlpeI2YmFSX8NauVibHdDy9iX4npnCgThkBlcEjqvjYX1/lRDXT4pvYnBxFtpQ8J
         ko5Z4m6YgZ729LTBXrAru3IXv4D13BpEiEQbjrx8ig1l9m/qTGqCwDB7enDhHsOTurBf
         mzLfr34aLHxiuytOFDb/LGWeBnGk07kvoyZAa57IOqpW5L2d9pkCIvsARkakeyWVXhmI
         x1sM8YYJKGf+eAPBzgEiQMB3J36zBRXXWhOMSr/vXpNT5vGTErpFOpOE28bjOouV6wH5
         gx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835836; x=1692427836;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P0g/IBsPZGY5PxZfIKc7/6gIDE3jbSDKqZLxVCtbNmM=;
        b=ZyUlV3BhudmsLMT9tYAmpDeeE+Ef66RDyPQY/FrbZ13zycz2VZ2pp3hpQBzhXg31F4
         KugH4bP9niWo2/xMnR3FuOzvtBvoHESvfVKAQ/UzdWKvQm4Ug/1LZkuDUTTfAVRU864H
         soeDIU3RPJOSYpRv5lcrGnk7o203WEWYh0oDewqNm1U1bLYTIgKXj7GOKXjNsqc6sU8S
         1FyvCBRUIpfQ5vm31W2ZWLvKP1xUggkIzSBXEMcWWqMmCnEpL9NgX5GBXFjGFvnlu15D
         t4uFxC33ktJF1tM/2bBYmjZZ4OLha9hdw/YEllAdFf/F+r4ZfdcTKA3lQt/sUxd4g1YL
         Se8A==
X-Gm-Message-State: ABy/qLa1DiozYHmaUC/2rnSPo9ErKF41tsFJmA2cNGqwp9PJ02NTDe88
        gmnZVFcALD3E6OAXM0VKa9JZPg==
X-Google-Smtp-Source: APBJJlG4RR2sqWSSMq1ocs/VfVSVQ/+Fb3rMHZ5K+E5BQzoA0+73UAaCItdftmgHvay9ZoHLh1P6lw==
X-Received: by 2002:a17:907:779a:b0:99b:5689:1331 with SMTP id ky26-20020a170907779a00b0099b56891331mr575512ejc.59.1689835836589;
        Wed, 19 Jul 2023 23:50:36 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.16])
        by smtp.gmail.com with ESMTPSA id o23-20020a1709062e9700b009935aba3a9dsm225434eji.48.2023.07.19.23.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:50:36 -0700 (PDT)
Message-ID: <598bd9d8-249e-125c-bde3-7a63ba6dc5f7@linaro.org>
Date:   Thu, 20 Jul 2023 07:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mtd: spi-nor: avoid holes in struct spi_mem_op
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peter Foley <pefoley2@pefoley.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20230719190045.4007391-1-arnd@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230719190045.4007391-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/23 20:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc gets confused when -ftrivial-auto-var-init=pattern is used on sparse
> bit fields such as 'struct spi_mem_op', which caused the previous false
> positive warning about an uninitialized variable:
> 
> drivers/mtd/spi-nor/spansion.c: error: 'op' is used uninitialized [-Werror=uninitialized]
> 
> In fact, the variable is fully initialized and gcc does not see it being
> used, so the warning is entirely bogus. The problem appears to be
> a misoptimization in the initialization of single bit fields when the
> rest of the bytes are not initialized.
> 
> A previous workaround added another initialization, which ended up
> shutting up the warning in spansion.c, though it apparently still happens
> in other files as reported by Peter Foley in the gcc bugzilla. The
> workaround of adding a fake initialization seems particularly bad
> because it would set values that can never be correct but prevent the
> compiler from warning about actually missing initializations.
> 
> Revert the broken workaround and instead pad the structure to only
> have bitfields that add up to full bytes, which should avoid this
> behavior in all drivers.
> 
> I also filed a new bug against gcc with what I found, so this can
> hopefully be addressed in future gcc releases. At the moment, only
> gcc-12 and gcc-13 are affected.
> 
> Cc: Peter Foley <pefoley2@pefoley.com>
> Cc: Pedro Falcato <pedro.falcato@gmail.com>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110743
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=108402
> Link: https://godbolt.org/z/efMMsG1Kx
> Fixes: 420c4495b5e56 ("mtd: spi-nor: spansion: make sure local struct does not contain garbage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Miquel, would you please take this through mtd/fixes?

Cheers,
ta
