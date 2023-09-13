Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221979DF80
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 07:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbjIMFkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 01:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjIMFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 01:40:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABF51734
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:40:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfb1167277so12908641fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 22:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1694583642; x=1695188442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71OlVQxE8cMBTPBAwgblkofANxXLnUttN6x83QKm24I=;
        b=SfKcgmdqm7OurFHu7ymtTy2m8s4Qa7E+feQU3rmoqVdE7vf34rKwehbNsxyB0e00Li
         fstfRZx2nM0MAzHNc3+fEoXi08tF0Ma6QfQl+jGfiCIhdHD4XNKgqpcJfMKHYRGUACIJ
         qoDQ5Et3Gag6xsaPILWtZu6RZ1Efkl0FR9v8yM5RA7PgcXOcKZXb4qNCyTZRYmDWI6Tx
         mxHufs6F6vdnBlLUxfmLBzPV3ku2ZYXoI2BzhC0x8TGhgAzy4yEkaIBG9r8uVqlFHGKU
         z6iTdjGaKnwUz++142FMLXPa+DMZHwZj4fM4/eCG9oRZaCUsSzINq74+5K0yJl0R5Skf
         V5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694583642; x=1695188442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71OlVQxE8cMBTPBAwgblkofANxXLnUttN6x83QKm24I=;
        b=dwj/4jl63Ht2yZ6ZfR5DZ8qVQzef3XhrieCr1mOpssJ91q9GZH32NTaNidAfDydEyy
         OfiOpq8bK+wcnErWECVha1k7x7uIPEpF6cyfZSYt/9ihDrKgKuIUxDxRcLyUB6yzZGON
         7qqEnIxWMpm+r4Cak4yD+uczHjW5krH6S7dhEZuky+s3Kh0Kg+iI10uz/VpsTDuah5aH
         M/umQ1cGRhhkEPNdO2mifL6qWSlnQmnOGc6BpCMt5o1+YzSlFEaabKfvNzLb3fxuSV+b
         FN6Q0IIl8dqYQFOod0CCLvQNtNcNSotCFqgqg6Jr6PukvAL5XxlF8kk1j7F5IxJrF/fh
         zJ1w==
X-Gm-Message-State: AOJu0Yxeat2SZePHI14kh/TlAjdl9srkYsv/U3UPAuXmPfYxlCwy0QRQ
        hs0lJTTVKkj8JY+W4VTG24kVww==
X-Google-Smtp-Source: AGHT+IF8hao+YolDUSCPtVx3Gw6N4Lx2rppYX6jWNMGbxXVG9WZR+2tZjXwkXTHdGRMIW8XhcdIuXA==
X-Received: by 2002:a2e:9216:0:b0:2bc:d097:2b72 with SMTP id k22-20020a2e9216000000b002bcd0972b72mr1522749ljg.48.1694583641685;
        Tue, 12 Sep 2023 22:40:41 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id os10-20020a170906af6a00b0099b921de301sm7764554ejb.159.2023.09.12.22.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 22:40:41 -0700 (PDT)
Message-ID: <dbf668bb-7682-fcbb-b159-8d036bfe3ff2@tuxon.dev>
Date:   Wed, 13 Sep 2023 08:40:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 00/37] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Ulrich Hecht <uli@fpond.eu>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <CACRpkdYL46wY_4dm2w45kdPqOJ8zU9X=SSAXv_K=9wfBZFqyDQ@mail.gmail.com>
 <CAMuHMdXi6PPFqgjvr6tBXQnXqNb3YL=87JeSiGN0+QqkAvziAA@mail.gmail.com>
 <CACRpkdYFzJD+F4v0DTfppGv39guL6YbeA=5aByxuu3u8Jp7u6A@mail.gmail.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CACRpkdYFzJD+F4v0DTfppGv39guL6YbeA=5aByxuu3u8Jp7u6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

On 12.09.2023 12:05, Linus Walleij wrote:
> On Tue, Sep 12, 2023 at 11:03 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Sep 12, 2023 at 10:55 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
>>> For new code try to use <linux/cleanup.h>.
>>> Or if you prefer take a sweep and introduce scoped guards
>>> everywhere (for spinlocks, mutexes..).
>>
>> Hmmm, <linux/cleanup.h> is only available in v6.5 and later.
>> I don't know whether the CiP machinery is planning to backport
>> <linux/cleanup.h> to e.g. v6.1 LTS...
> 
> Only for new code! (for-v6.7+)

Would you prefer <linux/cleanup.h> even if the new code just uses the
already existing spinlocks, mutexes? Or only for new code that introduces
new spinlocks, mutexes?

Thank you,
Claudiu Beznea

> 
> Yours,
> Linus Walleij
