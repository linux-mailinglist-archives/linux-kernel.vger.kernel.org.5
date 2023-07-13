Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54E57529C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGMRVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGMRVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:21:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CC2686;
        Thu, 13 Jul 2023 10:21:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-553a1f13d9fso792418a12.1;
        Thu, 13 Jul 2023 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689268892; x=1691860892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MoXOEc1aWr3dwI0ksLlYt0n9zn9QMHI6ygtva43knIk=;
        b=sCbxgIQXcdA0IEPVvuUoCmwowEuiLuUQeLa7QqceEYk4UTV4WZNPnPARSsD5mXWsm3
         4vBqobcSvHDfjRjnftWhFlN7KGkotHNWnr0tX+qr7sz9q2pKt/RyXEHMhW5emuSQqlXi
         keYxb9FGC4WS50ZwuKoIPWbdXjAmP8Os+c47l6lM84re/8CiJ2bZ6B92QUYg5tK4sBns
         DS7cnufKinuAzr2o81wvq3dJXvvPvaXMTtkHSpbJeau1C20i59o9muwBcNSUkGSdgnu2
         QuEeLZGhq7yy/huBkWNYGRH5Xfe6BlW9Auz6RTrBgpOFo2DJ9cdIUJ/I1PTkDi8jic3a
         SWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268892; x=1691860892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MoXOEc1aWr3dwI0ksLlYt0n9zn9QMHI6ygtva43knIk=;
        b=ABekdh3gdPXmg1luPeu+Jt7I8wy788loWkIwLJVJ01PYMo4+fvdpi1ZybILpXp9SoY
         jkfuPUQEzQtQrfolqBgrPGUWXzzA9tHtycXZjHUqCAEy1QdHygITjmuO2YHBxzDhI0/V
         rP9+ukHH2NIOHJx/A6kYNsS7kduKuz3XcBfas+N2R6Su0KuUNfPuiaajSZJ8hah74Z9l
         eFZu3PBbeUyZRn0KqG6xwR1VMSZTf1Ysj37jAJuTy4LWq3Fr4qjWtO+ZszQqbNARktUb
         mqicN4ztmky0zrmzZhuHlgR8/mox6NxU28YTP6TEFhIf1CZsoiypF3uTPWW6IV497Iyp
         i+Gg==
X-Gm-Message-State: ABy/qLZc5sgkmKgkKBLHddIEXraf4LvnVnspvljg3cWFyvPaXU3KVp1b
        taqJSbjqQHz0afqE192w8b0=
X-Google-Smtp-Source: APBJJlGjVpPOhdng3VgjRXpoNaR7gSPxF2yyt2gRipzwWJhe5GKw6woKp4YhYuIL1Vy05Dewv4XtdA==
X-Received: by 2002:a17:90a:d3d0:b0:262:e821:b3f8 with SMTP id d16-20020a17090ad3d000b00262e821b3f8mr1894750pjw.38.1689268892074;
        Thu, 13 Jul 2023 10:21:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4-20020a17090adb8400b00262d662c9adsm12047088pjv.53.2023.07.13.10.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 10:21:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3eec9b79-0505-0b15-f7a0-fcc7f4031c85@roeck-us.net>
Date:   Thu, 13 Jul 2023 10:21:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230713095127.1230109-1-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 02:51, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> The watchdog hardware of TI AM65X platform does not support
> WDIOF_CARDRESET feature, add a reserved memory to save the watchdog
> reset cause, to know if the board reboot is due to a watchdog reset.
> 

One thing I keep wondering about: What prevents the Linux kernel from
treating the special memory area like normal memory ? I would have expected
some usage note, such as that the memory area must be reported as reserved
to the kernel, but I don't see anything like that.

Guenter

> Changes in v3:
> - Add memory-region back for the reserved memory, and remove reserved
>    memory from the watchdog IO address space.
> - Add changelog.
> - Link to v2:
>    https://lore.kernel.org/linux-watchdog/20230711091713.1113010-1-huaqian.li@siemens.com
> 
> Changes in v2:
> - Remove memory-region and memory-size properties, and bind the reserved
>    memory to watchdog IO address space.
> - Remove the unnecessary rti_wdt_ioctl.
> - Fix the mail list
> - Link to v1:
>    https://lore.kernel.org/all/3137d87e56ef75ba0b8a923d407b2fecace6ccbd.camel@siemens.com/
>    v1 had a wrong mail list at the beginning, and the mail thread was
>    messed up.
> 
> Li Hua Qian (3):
>    dt-bindings: watchdog: ti,rti-wdt: Add support for WDIOF_CARDRESET
>    arm64: dts: ti: Add reserved memory for watchdog
>    watchdog:rit_wdt: Add support for WDIOF_CARDRESET
> 
>   .../bindings/watchdog/ti,rti-wdt.yaml         | 12 +++++
>   .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 10 ++++
>   drivers/watchdog/rti_wdt.c                    | 51 +++++++++++++++++++
>   3 files changed, 73 insertions(+)
> 

