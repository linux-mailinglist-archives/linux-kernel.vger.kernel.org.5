Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF883779FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbjHLMdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLMdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:33:08 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8F195;
        Sat, 12 Aug 2023 05:33:12 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34992fd567bso5476465ab.1;
        Sat, 12 Aug 2023 05:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691843591; x=1692448391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=buTwmFs6G1iGf0RG6iTrknTs+Tb6evZxD/fZtLpTWjQ=;
        b=MhlnN4IguU0L30QlPIUd/ceuZRiwQaPko8CjIbfXbU5AtB++rfQantIqwqMIxtsmuF
         ed4UoeDHz6M0l6t2kTieUez+QFZUCJIGH64rDaazKADE8j4lbZzKhxS0vbdiGNDNfaan
         NXXxRc4hEBO6Hch+aohXtRlMTeHnDinWshFHYp1QsfBykKeHfQjjGPi/+8URRqJ9Dlg+
         uIu6XugEDJiWyvLMADPpT+/SWuM7WQ8k3EGiqFr5i++Xt2l0ovcFhxtkvwWGa5emw6Yk
         LLkFbNMjpakrbNmgFRzSf51iUGMD/mIfV0Nv+aNVI3R5FaqVnIji4EJp3FVNIEAjLr8S
         vANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691843591; x=1692448391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buTwmFs6G1iGf0RG6iTrknTs+Tb6evZxD/fZtLpTWjQ=;
        b=EU+iM01ZYdFp507hoHwP8AENffHaTR8d2MX47VjhasXZn99zTSqBzz/Jt/ZSCU2P+V
         mW6Uat916rH6bqOaqCUHdBJw6K01EYT+OuiZEjhA9T3GhbuTAmTMZ7T9P8K6tGGLQ/3r
         jY6F6zXFHtqarRVzOgbMlbS2L2zKlSOa8UTTf8KQxh2ahCoiDCXWV6Qzh0lTHxceGFdm
         wbrwLQdGTBFDtt9iReuMGeThbaNpIf2W0xiKg0FvmUwRaOl+UphORzonhS8RD5dxRR2x
         S38ANr6midjpeOUVFxnylirAsyH1yRqPOI38WLgvG8ewLUEgggTGvskP/SgYDNg41uZJ
         T/+g==
X-Gm-Message-State: AOJu0YxBcRIvRqydmQfPnLpNFomSS+8qE/7ASv+vyto/xV35QEx71D5e
        VieaJahd1bsh6TibnV9jYTE=
X-Google-Smtp-Source: AGHT+IGf1Dlhj9ZcajRjK+XCTF10UNHSIvJolynSGJQNxbcIeYY4T6FqkmmZEcMk8bMtenOqqztkIw==
X-Received: by 2002:a05:6e02:1542:b0:348:a537:8e99 with SMTP id j2-20020a056e02154200b00348a5378e99mr10445894ilu.1.1691843591324;
        Sat, 12 Aug 2023 05:33:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h8-20020a02cd28000000b0042b3ad1656bsm1749690jaq.45.2023.08.12.05.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 05:33:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f3711620-d828-ed1b-f676-e5eea8fbe8a6@roeck-us.net>
Date:   Sat, 12 Aug 2023 05:33:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230802193155.2170935-3-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230802193155.2170935-3-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 12:31, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> TDA38640 can operate in either PMBus mode or SVID mode.
> In SVID mode, by design ENABLE pin is the only option for controlling
> the output rail.
> 
> In scenarios that utilizes the chip in SVID mode with ENABLE pin either
> grounded or tied to logic high & software control is desired then use
> dt property 'infineon,en-svid-control' to enable the below workaround.
> 
> The workaround utilizes ENABLE pin polarity flipping to control
> output rail.
> 
> If property 'infineon,en-svid-control' is specified then
> determine if chip is in SVID mode by checking BIT15 of MTP memory offset
> 0x44 as described in the datasheet.
> 
> If chip is in SVID mode then apply the workaround by
> 1. Determine EN pin level
> 2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
>     PB_ON_OFF_CONFIG.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

We still have to wait for dt patch approval.

Guenter

