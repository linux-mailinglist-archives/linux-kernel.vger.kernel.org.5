Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D440D80FBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378033AbjLMAIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 19:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377728AbjLMAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 19:08:24 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25F173D;
        Tue, 12 Dec 2023 16:08:11 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so5428750b3a.2;
        Tue, 12 Dec 2023 16:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702426090; x=1703030890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qKBBnDg1UUIS/KYipTQnXPk3zM7w4tV9LEKEnMlk//w=;
        b=CGME4tT3xai5YOoydX/MBQH01+txhWkelSk47y1AVqWmLVqA9Uf4zlhh27uZJMaqde
         Xy7SeZ5mA5A1yT6AlVLUWB0w5JEUIIBm8lv1W/vdTjMj2w5jDyxlcKfKu0aZCE/X34sU
         NgdI3xkSiMHuquiaQIKPJ8MbUU/mo8lvIg/gVdsuzviDPHPNBtuULHp2bKc7VuJZoaEQ
         Ck5kzPzkbKb7P9gA5LJSE85xncMP8BdCtgb6UD64pSNxAIxB5a8qiAQJoJcM/KhdUM2L
         8PGKtnUCSOrYaM65U5HI2xdTj1MXZa+vCaQ/PBWkRSxgeA9qjTCY078y3dBSe/GS9uPn
         RnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702426090; x=1703030890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKBBnDg1UUIS/KYipTQnXPk3zM7w4tV9LEKEnMlk//w=;
        b=eYMkg8LljEBXgTP0PWQwGGfXQLSRYfoaWCaQcNu8CXSDWbuH3qXweZ5ssaEffq47uY
         HCcz/oT1pEjTvqEmY3qzXV4LqWtNno8tQpBDmNmP+KY/w3FbPugnZUXHsqhpo3VNR6ZW
         TwNQGcY7d5ZFvk8OkKRKYROQqfnl1ii9q7p2m7C+IVPI8eB8zdzJSxP5cH6UBRsD7wfM
         r4wd+KQXP1eDWbT1S2JL1E6sjGp/IcwsIx97LrspBLQDNeiR0yGwjXGWSFISnBWWRHZC
         eungk3OS4hXsoDD3xoaC7hy7eg5MKVOyQo9uBcZpA2k+ZuyLZxDLfoWBPcfj9auZ1/gQ
         wuPg==
X-Gm-Message-State: AOJu0Ywcm/Irx5MCirCtgTt/oK+H1DFZZp2sQoN0kN2r8Dr4ryUEDjNr
        3rCt3dQKMwRL+QiACf9jaK8=
X-Google-Smtp-Source: AGHT+IF7m3+tVSh63CMfRBv8HKgwXy7mdsLpmniS4M9wrmn7Qr/17O/1jRDELASR0oM/P/jHUaqgBg==
X-Received: by 2002:a05:6a20:748f:b0:18f:97c:9769 with SMTP id p15-20020a056a20748f00b0018f097c9769mr8858642pzd.81.1702426090491;
        Tue, 12 Dec 2023 16:08:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 12-20020a17090a198c00b00286d905535bsm10550220pji.0.2023.12.12.16.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:08:09 -0800 (PST)
Message-ID: <5ced5a7e-61f6-4132-bc21-c6034830221e@gmail.com>
Date:   Tue, 12 Dec 2023 16:08:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mdio: mdio-bcm-unimac: Delay before first poll
Content-Language: en-US
To:     Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231213000249.2020835-1-justin.chen@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231213000249.2020835-1-justin.chen@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 16:02, Justin Chen wrote:
> With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> preamble & 16 bit control & 16 bit data), it is reasonable to assume
> the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> the first poll to reduce the chance of a 1000-2000 usec sleep.
> 
> Reduce the timeout from 1000ms to 100ms as it is unlikely for the bus
> to take this long.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks!
-- 
Florian

