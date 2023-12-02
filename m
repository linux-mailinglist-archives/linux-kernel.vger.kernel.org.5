Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58286801EF3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjLBWHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 17:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjLBWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 17:07:49 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC9911F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 14:07:55 -0800 (PST)
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B537344446
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1701554872;
        bh=VhuiHjzGmesIrY/hSc2y05bK2i7Am6FUImDyu0cEMgU=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=DyHa6fTFxrMFdfW1mld8lFQEIwtgft806aM7Gp7qnP/CXyLGYLMm5DCkb8KAzxIqo
         7shdaaZODXsjTqNkkfRy3HBsCWhIwKN08OcVr0U6neOPpsXQZz0U7MJ/eXmQWjUYgM
         XwbnyWVqFWzjju1tZj0iWxvd5aOjd7Uj0pr+FUCAwhFuLQgBeOvVp5foN3jvTCv1c6
         Z5GYMS7hOPXDpTDHLMSRH5IyH5apPLVLYofDZ8Wofab1m7k/Qvzf6HLVbNtQKZtx6A
         Y/CYjALKLDxc/ak38EIV8hoXWcG6Y7A/roQkx42pGTJfgU9Pto4G+XQAL8duCDZDs2
         jPmMDDKY8Y5Og==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58db2015327so3791847eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 14:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701554871; x=1702159671;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhuiHjzGmesIrY/hSc2y05bK2i7Am6FUImDyu0cEMgU=;
        b=MYhftA2XT2Ue5euFCP7rdW2x0tfzokSoMtjZZ3dpP6EbE9GddcguiWtaLlhDb1IqWu
         BTJ9ccvB/4b3f6Uq4rB2tlxo6fXaHSUtVsqqJqtdGn9h3OxjF979kTJDGfTl9spL6XOH
         ovct/tbJvHmTUua2sCCg2RL2BdIfchfYB/CZEJTDbcEh0zA+erB1CHHePc+yjaQ+9yqz
         RgJK6hZtnFvbLSWTlgZEBRTBCQjo1q4FyyPAUsuY+2nSSIUiyHEocMkcXcAViwE04RXq
         T6HS+cDJKyP+58MMle1TJXfdUh/biKkFkyvfnTo+so/D1QLWlyfULgR+MW78YVZX0qFP
         DqnQ==
X-Gm-Message-State: AOJu0YzxlXhw6lXh/S8SSf21un7+S4wugnAKxY2hqyXsHHz/U698yBZt
        CB7KNCmacf86gk7PG+nO1uhJGFESudeMu6hjqdp8daul1GR0XwyZMI/5WL0+cV9lXjCSKWGpmPk
        d5ngytffwzmVb9q+6W2k15bFapzJbcodWcoBoZ/AQAUE9IToo1gUlII8j6A==
X-Received: by 2002:a05:6358:4e:b0:170:17eb:7c67 with SMTP id 14-20020a056358004e00b0017017eb7c67mr1396025rwx.58.1701554871290;
        Sat, 02 Dec 2023 14:07:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDgcC7p1ZVM37WrYOl9g6KwCFC9ba5aGWjLgxDGJ2WolVrkOMQ2nYCO3RuaqPRlAtCZA3dv3QColkp70DC18E=
X-Received: by 2002:a05:6358:4e:b0:170:17eb:7c67 with SMTP id
 14-20020a056358004e00b0017017eb7c67mr1396010rwx.58.1701554870917; Sat, 02 Dec
 2023 14:07:50 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 2 Dec 2023 14:07:50 -0800
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231202153353.635-1-jszhang@kernel.org>
References: <20231202153353.635-1-jszhang@kernel.org>
Mime-Version: 1.0
Date:   Sat, 2 Dec 2023 14:07:50 -0800
Message-ID: <CAJM55Z-9Y=QitvAX+z=XTTMM0CGRzGMD5z0H_Bzv=Q85b49rpQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] riscv: dts: starfive: add Milkv Mars board device tree
To:     Jisheng Zhang <jszhang@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang wrote:
> The Milkv Mars is a development board based on the Starfive JH7110 SoC.
> The board features:
>
> - JH7110 SoC
> - 1/2/4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 3x USB 3.0 host port
> - 1x USB 2.0 host port
> - 1x M.2 E-Key
> - 1x eMMC slot
> - 1x MicroSD slot
> - 1x QSPI Flash
> - 1x 1Gbps Ethernet port
> - 1x HDMI port
> - 1x 2-lane DSI and 1x 4-lane DSI
> - 1x 2-lane CSI
>
> patch1 adds 'cpus' label
> patch2 adds "milkv,mars" board dt-binding
> patch3 adds the devicetree file describing the currently supported
> features:
> Namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Ethernet.
>
> Since v1:
>  - add two new patches which add "cpus" label and board dt-binding
>  - adopt Krzysztof's suggestions, thanks
>
> Hi Conor,
>
> I see you have sent a patch which moves the timebase-frequency property
> to soc dtsi, but this series doesn't rebase on that. I can update it
> once your patch is merged.

Hi Jisheng,

Thanks for working on this! On the JH7110 the mtime derives almost directly
from the external oscillator like this:

osc (24MHz) -> rtc_toggle (div 6) -> mtime (4MHz)

So to me it makes sense to define the timebase-frequency in the same file as
the frequency of the external oscillator.

In general it looks good, but if you do

  diff -Naur jh7110-{starfive-visionfive-2.dtsi,milkv-mars.dts}

you'll see that those two files are almost identical. Even external clock
speeds and all the pin configuration are the same. I'd strongly prefer to have
all that factored out in a common .dtsi so fixes don't get out of sync.

/Emil
