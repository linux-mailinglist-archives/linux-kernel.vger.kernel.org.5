Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944E476C72C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjHBHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjHBHk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:40:28 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786634EE3;
        Wed,  2 Aug 2023 00:38:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe1344b707so10394758e87.1;
        Wed, 02 Aug 2023 00:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690961912; x=1691566712;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hG6+YQ0tUDz48/03f7Nyeq0JCf007nOGlw47CxNzErA=;
        b=ho6VKHchKIecptzcDesrpXEbSnhlh14yTzt1/ddoGIW7N+NJKZi73ac7qQaztLtMuQ
         3QoiUN1MGh6hWVL2JPeX8ztzaEn3Ez2KIrW716wfFxX5mdvzgNtFce36FMNNd9p6NvMP
         Rp/9tSbD6nj7pmSAP5/fmbUJOCs+OymiKh5WJGapFqJmksqITXhs51ukWWtqL1g/t6fP
         JYAULICCKGSO4OEfZjnQ1bJUXw8ibs7fUQLGWYKNTk7V1g6d5OgWk01X9RfAg8lrdJm7
         ibdC5h8BZ/EdZT0PVlni5KF4lldYS1rGS1+DXHd4Ma3i3tD2LelgmtvLlz/ARI1DRtt3
         93tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690961912; x=1691566712;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hG6+YQ0tUDz48/03f7Nyeq0JCf007nOGlw47CxNzErA=;
        b=WpXmCVhdAwwTC9cHarq+daabZ+xapLUDaB4DxEpyIApQ58gyNJIJkjVoRyv7kLBHhS
         oOLlP4xioIi0onH3p4qt8BMkzCGJ/iS9ld0tJ4WruJjxfb3VruAuk9D/l15O8dRWrjcG
         HUDucE8stF/TrXxCUYyaaHFIUWnYTz9pr3eQU7i2dhF2tCRWWd0644SW9nAK0jY0eEmZ
         H8WfdyfZo5XEPjWWg8qAfbw7DWU06UpdOIKIctjFkqhqkmX67EReqt5zChMxlqTrnvE+
         E7w0HjeW39mLLaiZpn0WnIJ0X5zpyNFGJzOgLr/8eip7gqXK/6XeMZPuel5kSvTNG0Xk
         LPrg==
X-Gm-Message-State: ABy/qLZmxEUyblOZPNplT7/bqE4eOxI7kje/oTc8EmSjZ7mrS8KlPmfR
        rvngA1hmLYkyARMx0aHP8gs=
X-Google-Smtp-Source: APBJJlFyaHc0Ucy5XRq29FSH+BjvL/M0W/SK3cClfC4+ud7BbZuUQeiusKk9chXOhYjrMhIYGEFoKA==
X-Received: by 2002:a05:6512:3711:b0:4f8:67aa:4f03 with SMTP id z17-20020a056512371100b004f867aa4f03mr3683942lfr.1.1690961911447;
        Wed, 02 Aug 2023 00:38:31 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id x1-20020ac25dc1000000b004cc9042c9cfsm2169486lfq.158.2023.08.02.00.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 00:38:31 -0700 (PDT)
Message-ID: <285f419e-f8f2-c8da-6064-2a51e92ca3bc@gmail.com>
Date:   Wed, 2 Aug 2023 09:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <ZMmFeCBxhJOxZ575@shell.armlinux.org.uk>
 <60a553a2-85f3-d8c6-b070-ecd3089c3c5e@gmail.com>
In-Reply-To: <60a553a2-85f3-d8c6-b070-ecd3089c3c5e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.08.2023 09:00, Rafał Miłecki wrote:
> With your comment I decided to try CONFIG_PROVE_LOCKING anyway / again
> and this time on 1 of my BCM53573 devices I got something very
> interesting on the first boot.
> 
> FWIW following error:
> Broadcom B53 (2) bcma_mdio-0-0:1e: failed to register switch: -517
> is caused by invalid DT I sent fixes for just recently.
> 
> Please scroll through the first booting lines for the WARNING:
> 
> (...)
> [    1.167234] bgmac_bcma bcma0:5: Found PHY addr: 30 (NOREGS)
> [    1.173655] ------------[ cut here ]------------
> [    1.178374] WARNING: CPU: 0 PID: 1 at kernel/locking/mutex.c:950 __mutex_lock+0x6b4/0x8a0
> [    1.186721] DEBUG_LOCKS_WARN_ON(lock->magic != lock)

Ah, that mutex WARNING comes from my Tenda AC9 device which happens to
use a hacky OpenWrt downstream b53 driver. That driver uses wrong API
(it behaves as PHY driver instead of MDIO driver). It results in probing
against PHY device which isn't properly initialized.

Long story short: above WARNING is just a noise. Ignore it please. Sorry
for that.

Kernel compiled with CONFIG_PROVE_LOCKING still works fine on other
devices and on Tenda AC9 after fixing PHY<->MDIO thing. That kernel
option hides actual bug whatever it is.
