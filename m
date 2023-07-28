Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7876760B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjG1TGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjG1TGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:06:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C563C00
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:06:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8ad356f03so15317955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1690571195; x=1691175995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NF0r9eMdsRlfx+fQNhsp0XsqZFCxcupFF3OG9UsICFo=;
        b=cmdPjnKZGl31IJIA7yqBzK039eXHjdL/oax5B08GDm2piQtz8J4/mxsW9NeOL/x1+t
         CvN/XCEeMge+mNEXXjV2jCCW/x67qrE7pVUVSVdrlxG6NcCo0YMevdqz0LFz27HbiOV2
         ng1WrFQrHvQw5mdPdNkQpYoM7SQI6zNln6248JVTfvcPQ2soODtq6r0UjFnaHNWvPuiY
         qxPIcU/4saAIRjZVfzTrEH3a/Yzvz7mU84cAQhFjGUcjWkFeHjGZkmGQMuEDtX8x1L7V
         XnOorLhjCtv4GF8qVWDtyXB1aRz9cEFz5hmfH/k/gDnZaTYGAGFiI7ThocBh6BjyZ+4e
         fXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690571195; x=1691175995;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NF0r9eMdsRlfx+fQNhsp0XsqZFCxcupFF3OG9UsICFo=;
        b=CF7/bkmDKOQK2hTj6idly2lyHJ+PmqSUXqMBoigYX4Ibu1Zu/aiNSDR7b2wnKRsP93
         svivH2BIWFh7au44FQdhFDi1U431nKArl/tbrUzwnFt5IgXmpMu0TghlyfuRnP/Ga9pG
         XdmZGrzyuq3qJ9TPKhhSVgtogXL+om6csDeXdY7F/vWAMYSur/fCJjC0ONhDXqSDS8o0
         TFfvq7VYJhU8EXW3GVj56UWORSmCtdzfV8BDzAzH5V5jSa74jTAMLPu1+PevsT+gk1zM
         9HatFc8lIISHpuvbgHCw98MX02lu0xFQEr0pOLVXumPcoktmU/r+fekPsdhUsNe4+VGW
         Dvmg==
X-Gm-Message-State: ABy/qLb0k3vDLzvj66tdYf6GuTIkLoeTDCd6ELF5VT4u28D1HWbWnCYj
        bGvN4wwvc5hNdr6/C6e4c3mJNA==
X-Google-Smtp-Source: APBJJlG6XFoP1LhFMTBznXGOJwP8YxSSulmHWjhYJ1NDAzk8KWNKByfw3HTiT206vlHYDjBoVhy7Yg==
X-Received: by 2002:a17:902:e741:b0:1b8:28f4:f259 with SMTP id p1-20020a170902e74100b001b828f4f259mr2501220plf.69.1690571195271;
        Fri, 28 Jul 2023 12:06:35 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b001ac5896e96esm3901266plf.207.2023.07.28.12.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:06:34 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: Replace the IRQ number with the IRQID
 macro definition
In-Reply-To: <9da24c47-341b-1581-0043-a6c1cdce462d@amlogic.com>
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
 <20230721073214.1876417-4-huqiang.qin@amlogic.com>
 <7hcz0ei9r4.fsf@baylibre.com>
 <9da24c47-341b-1581-0043-a6c1cdce462d@amlogic.com>
Date:   Fri, 28 Jul 2023 12:06:34 -0700
Message-ID: <7hh6pnhn45.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huqiang Qin <huqiang.qin@amlogic.com> writes:

> Hi Kevin Hilman,
>
> On 2023/7/27 6:33, Kevin Hilman wrote:
>>> Replacing IRQ numbers with IRQID macro definitions makes node properties
>>> easier to understand and also makes GPIO interrupts easier to use.
>>>
>>> Associated platforms:
>>> - Amlogic Meson-G12A
>>> - Amlogic Meson-G12B
>>> - Amlogic Meson-SM1
>> Does this mean you tested/validated these changes on those platforms
>> also?
>
> Amlogic's G12A/G12B/SM1 have the same GPIO, and the GPIO interrupt number
> is also the same, so I only tested on the SM1 platform, and the test results
> prove that these changes are good.

OK, thank you for the explanation.

For future reference, this kind of detail is helpful to describe in the
patch or cover letter so maintainers & reviewers better understand how
the changes were tested.

Thanks,

Kevin
