Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744B07A17B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjIOHmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbjIOHmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:42:51 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF51BC5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:42:45 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-404539209ffso16421435e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 00:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694763764; x=1695368564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NmwZbuVF5EkCNAfwdejjaV7Uf9rQFqifdAcpKHOer9U=;
        b=OHu5TsiPNOP7SFFip9GVnSpGZWUBtFfLxUkiDujlxoVh23/OwcOL5Uq+9ZowN8Bs1g
         kxglwl2nBwrTLOALLwlim1Y1zW9fQntLXUvnArk99DtTq0KYOZvLD3rUMGmAVQV7ph82
         wei3qK79p1P1TtWqySeVqe/oIPIzRChI1c8PLUdH66vqctFTv5IZaOh8qDT/WGGqfNqm
         8qjp/QvoSNCsBZipzAufhLMNa1cHj4ZLBZK78D9hIsLQ13V+KuAcRwXgi4tl5OvokazW
         eWnxCLFcpQoZCDBD+cBHRjMcPcMpVHuWN02n6afr4RIUsz2ml0/jcV6RFvKyFbce7PHo
         gsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694763764; x=1695368564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmwZbuVF5EkCNAfwdejjaV7Uf9rQFqifdAcpKHOer9U=;
        b=qK6VELZyN+lh2NlXX9/WdDKtvRYk5sdxPsrloY8Lg+g/Y4L5emsWJPPt5ji1UE73Pf
         YIHtjZPVosrosLqCK8Hy/G1Sdt9ATV8p9RInEWHz/6smpSMfC6UAC/hqsDvN6Zo+U7yM
         zPcozTrIOqXdBrdQUdeE8Tkh+PL0OA9PJ4UwUWMVFBgV35zsFbdjBsSg5ZA1GbjpzMn1
         ylVHPLSBGOw9GK9PDuD5i//T55ftIVJfS7Nh4wiy2/wg0P2iDT7+3iG6ZP/DA3gtdwhJ
         FQD+bpR4nu6tgtUZ0e7XAh12v4YI6DHbPvzLgkcttPKUem/e+9ry4A8NZmL3lIxbB8El
         zmvQ==
X-Gm-Message-State: AOJu0YxPCBpMI+V6WMO0pPt8ymfOmfmTbGlXRR8Ekd/lkzqraJ8YWu+q
        kRx0C+6BYLxNtYigAyhs7FY8/w==
X-Google-Smtp-Source: AGHT+IFG4JeXkBIy1GSZbUKCdktOw8FSnTVZ0mrbg3uyuIOGwY3EKdvSFCt4TaM3ya+gui+z9YMC8A==
X-Received: by 2002:a1c:ed19:0:b0:403:bb04:2908 with SMTP id l25-20020a1ced19000000b00403bb042908mr768081wmh.23.1694763763891;
        Fri, 15 Sep 2023 00:42:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b003fc0505be19sm3867191wmc.37.2023.09.15.00.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 00:42:43 -0700 (PDT)
Message-ID: <9b72b8a7-be18-8014-f1b6-46cbef1e3d6f@linaro.org>
Date:   Fri, 15 Sep 2023 09:42:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, Claudiu <claudiu.beznea@tuxon.dev>,
        mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
 <20230912160330.GA864606-robh@kernel.org>
 <CAMuHMdWxKFrTi7c0Df0cHLrVFt3=a7UOy0jnKxsG8PEuD=15Pg@mail.gmail.com>
 <c199fb5e-927c-aa39-ff3a-3a7906fadec0@linaro.org>
 <CAMuHMdWwFnirDL7=06YofG5ON5U+eMUfe=JGAoU+X8rZWokS4g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdWwFnirDL7=06YofG5ON5U+eMUfe=JGAoU+X8rZWokS4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 09:38, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Fri, Sep 15, 2023 at 9:24 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> On 14/09/2023 17:26, Geert Uytterhoeven wrote:
>>> On Tue, Sep 12, 2023 at 6:03 PM Rob Herring <robh@kernel.org> wrote:
>>>> On Tue, Sep 12, 2023 at 07:51:41AM +0300, Claudiu wrote:
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
>>>>> clocks and resets.
>>>>
>>>> This is part of the binding, so it can be squashed with the previous
>>>> patch. The ack there still stands.
>>>
>>> Usually we keep it as a separate patch, to be queued in an immutable
>>> branch, as it is included by both the clock driver and by DTS, but
>>> not by the yaml bindings file.
>>
>> Binding also should be shared, so you get compatible documented in both
>> places (thus lack of checkpatch warnings). It still should be one patch.
> 
> Hmm, I see your point...
> 
> For core Renesas SoCs components where I am (sub)maintainer for both
> the driver subsystem and the DTS, I can take care of that.
> For the generic case, that will need a lot of cooperation with subsystem
> maintainers, to create lots of small immutable branches with DT bindings
> and DT binding definition updates.

Wait, I think I was too vague.
"Binding also should be shared..."
s/should/can/

I did not want to say that every time bindings should be shared, but
rather that if already sharing the headers, you can share the bindings
and you will get benefits - happy checkpatch in both places.

> 
> Alternatively, are you (the DT maintainers) prepared to handle all
> DT bindings and DT binding definition updates, and create immutable
> branches for all of them (in a timely manner, of course)?
> Then we can start enforcing the rule that driver and DTS updates must
> not cause checkpatch warnings for missing compatible values, and must
> not be applied without merging the corresponding immutable branch first.

I don't think we are ready for any of this, but it is just my incorrect
English or too fast typing before :)

Best regards,
Krzysztof

