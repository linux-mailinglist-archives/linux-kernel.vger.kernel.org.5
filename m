Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5816802E53
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjLDJRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjLDJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:16:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57130186;
        Mon,  4 Dec 2023 01:17:02 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb74a527ceso2886513b3a.2;
        Mon, 04 Dec 2023 01:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701681421; x=1702286221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9D3kW2Aojjv4RqGRthj2b1rTnXc6ubMuseBwhuWQ0QI=;
        b=Pill59r3s/8zuGiFoB+iMnKcQdsPXdVS5tLZ6FNveePjxLYU4fyE30yzugeDR4EhsW
         M6VEXKi5swY6PWalptyZqj5XT3FLrCxhXhu0B2sV2N+uq1cQkc1urxz4GfyeVkIgPI94
         aziV4pRPcohRYSVyH21Ia6M06Hihnvpfb/3cH/bZAWMT5CKnGBjhBuvWAG/mXG6c1WAo
         0Z81Mdbrym6SxnSFl/QYkGsA5P3TTYZCW2Irr8cXB9filctjfJ7rlcoQMf/SSuoto7pQ
         pw4knqJBqd3OUaWQOiHXKXyb9yCGg5Sy+ZvA2/gIKvl1IB9bg3RYjcQuR4TlrTwBHQsT
         CFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681421; x=1702286221;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D3kW2Aojjv4RqGRthj2b1rTnXc6ubMuseBwhuWQ0QI=;
        b=CHZRcyrRD1aEwGy2BccX1tF1KQ2Dab0JGuCBHNIzQog8xCAFUBoG1MDymBrmRLb9jO
         Iu1BZjwGfamT5l9AHtS6Fpl5YfPd2O8vk5E2RrABgbN0tSa31sRTE348z73F+DsbnblT
         CEg2mkJtB9UMSxfjreXkq/8VH7gP1Z1okHrQPJsgONpG0u9IFqvSl0tNFPmRcp5c0wI7
         4YBgO6mfO4FAGrFwjM49eceUebo/uAxauoZLdnHiZ1cWzOwEwYtYdwJGASk5uKatzsdG
         cCI7qRnUQJjmqqAyirtD4CiUYq92LnnpF8GKpyB29cjhN1kma6fqR1ilKBYN3Se2A7OJ
         p4gQ==
X-Gm-Message-State: AOJu0Yx6KVBfkaZT8H+kLcXxGUNJYRhT4num0CrgVvJoG18IzOHINZU6
        /gwGNkuKWhiqWQQ7qOWt0DYGYYvh9uw=
X-Google-Smtp-Source: AGHT+IHyM39DQ3WajW7PhaikQO34qZT7BP0+23uV4Oo4Za/YodiTkb9bgMI4pdUXIRTv0cLmFYUxWQ==
X-Received: by 2002:a05:6a00:2e12:b0:6b5:86c3:ccaf with SMTP id fc18-20020a056a002e1200b006b586c3ccafmr29556613pfb.22.1701681421517;
        Mon, 04 Dec 2023 01:17:01 -0800 (PST)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id t14-20020aa7938e000000b006ce5bb61a5fsm670762pfe.3.2023.12.04.01.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:17:01 -0800 (PST)
Message-ID: <bf3f2195-2d26-4817-ac5d-1608722c23f6@gmail.com>
Date:   Mon, 4 Dec 2023 17:16:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   PeterYin <peteryin.openbmc@gmail.com>
Subject: Re: [PATCH v5 0/2] Add Facebook Minerva Harma (AST2600) BMC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20231204081029.2272626-1-peteryin.openbmc@gmail.com>
 <fddcbad4-5368-4c2a-ba87-f4c4326a8385@linaro.org>
 <3ff5dcd7-69a3-4098-92c6-ed1e8f0bd8f9@gmail.com>
 <f2519d16-1b34-4d77-be69-cf80fa3415a1@linaro.org>
Content-Language: en-US
In-Reply-To: <f2519d16-1b34-4d77-be69-cf80fa3415a1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski 於 12/4/23 17:06 寫道:
> On 04/12/2023 09:46, PeterYin wrote:
>>
>> Krzysztof Kozlowski 於 12/4/23 16:20 寫道:
>>> On 04/12/2023 09:10, Peter Yin wrote:
>>>> Summary:
>>>> Add linux device tree entry related to Minerva Harma
>>>> specific devices connected to BMC SoC.
>>>>
>>>> v4:https://lore.kernel.org/all/20231204054131.1845775-3-peter.yin@quantatw.com/
>>>> v3:https://lore.kernel.org/all/20231123050415.3441429-3-peteryin.openbmc@gmail.com/
>>>> v2:https://lore.kernel.org/all/cdbc75b9-3be1-4017-9bee-c8f161b6843c@linaro.org/
>>>> v1:https://lore.kernel.org/all/20231024082404.735843-3-peteryin.openbmc@gmail.com/
>>>>
>>>> Change log
>>>> v4 -> v5
>>>>     - Rename document and file from minerva-harma to harma.
>>>
>>> You must explain that you dropped people's review for some reason.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Due to changes in the project name and content, please assist in
>> reviewing it.
> 
> When dropping people's tag, the patch changelog (---) should say that
> you dropped people's tag.
> 
> Best regards,
> Krzysztof
> 
Thank you for your explanation. I will pay attention to it next time.

Thanks,
Peter.
