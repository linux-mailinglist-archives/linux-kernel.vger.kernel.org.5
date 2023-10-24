Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE67D50E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjJXNDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjJXNCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:02:14 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5311732
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:01:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ac9573274so4069132276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698152493; x=1698757293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdiQyW/DR0saP5hyzIEWBzZ94+Rea1U1vbWoFnm3Jwk=;
        b=yiDmmu1fMz8EXLYU231mPxIe/WZTzCpSnRY9wHniXSUz0Z3XATmxHRYzIOsG1uyACv
         b0ZnEFNLFtMDmprpBGv/vMfQ0OUnogf4r+foyAYYOgHiBTMZPRNI1KADPivor8wTOcYS
         Mc6Al5fUzWJL9Pwa8k+h3iEZU3WOTJJdDf9I/7LZRY9i707hCOzW2GBssQ8W9U0+qbaF
         qLWAAEPhV+Ak6tr+yVyLhgCwaNhssBLUVex8Wp3xPCgcMEPB/YNoTBDuOboTwKjm/V7R
         5RuTAVMvGCjtL6Dln4fHw2ROcq7l1VW2NmWv62zGFEA977CoX9CRLlJB4NJyJ36jUIOU
         L+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152493; x=1698757293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdiQyW/DR0saP5hyzIEWBzZ94+Rea1U1vbWoFnm3Jwk=;
        b=c5WYn2wp/qtt+N+D9XY8ruI6iwzlUZJXjMeVlve3wPaNwrgGPBBfOOf61bP82NSgzE
         vbUAXWSbwXaYA1CgqViHOFZ0MPDIE/QPzfrzXxZLAF8r5KPlyp1adQ6MsnGXE8AjW9Sm
         P787EP/kszkx3mdve9gg3U5zb+CmLKwQJm7HCDZDuJcWpom697jepduSyq/ZZkaBwPgX
         ufUQ0XC8EMOQq7No+OX5FKUHl2pruIDZoINb9TjU0HhmKLoVWaq9u074xl6Bycwnfz0w
         j3SLufcTTQkhaL77nkPtCL1ydBYW07PaeYTtfMNo5oGVPo85xnD6u/UnGFN1jnn8wJN5
         dKKg==
X-Gm-Message-State: AOJu0YxFb+kQyjkKsfD4D0o+doFDa0GIEcBo80N+kH4SAqY47OnGmZ0s
        HNDVWwShqrCqeNUk8Yy2MDmrQN8Q/yGYo58aR88SKw==
X-Google-Smtp-Source: AGHT+IGTYcmpmdeet3GcOIVCZdUeYXb/bVrngkL8EkuljSeAX1GNPGKhi8aceTk4IEt+bjxWe8gW2+TDsv4nvL3FDsI=
X-Received: by 2002:a25:b53:0:b0:d9a:ccdf:3873 with SMTP id
 80-20020a250b53000000b00d9accdf3873mr10818054ybl.48.1698152491198; Tue, 24
 Oct 2023 06:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org> <20231006132346.GA3426353-robh@kernel.org>
 <CACRpkdaLsfSBEG-h9ZNT2_Lm8tW8AZO7tedDVNeuZoQAqSkyjw@mail.gmail.com>
 <ZSTgTC4cFFpofYAk@octopus> <CACRpkdYD6pkccYoy90AfzV3KT7oYkBPD2_4ZW-AXzT1eUVpchA@mail.gmail.com>
 <ZS3yK/f12Mxw9rXe@octopus> <CACRpkdarDrVkPmyDawhZ+H94S4F=dtDSDVuKegi-eNfQNDY3rg@mail.gmail.com>
 <ZTduWx7CH1ifI5Uc@octopus> <CACRpkdba=echR=rZYKVbROfaOp4mzjTQ9RphHFyzqSNgE1jZqg@mail.gmail.com>
 <ZTeitAqfwyse9Vkj@pluto>
In-Reply-To: <ZTeitAqfwyse9Vkj@pluto>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Oct 2023 15:01:19 +0200
Message-ID: <CACRpkdYi5rLvXwhWnBRGg8hxZ_tNa0g92Q_fSLnCt_vetjeS8Q@mail.gmail.com>
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Rob Herring <robh@kernel.org>, sudeep.holla@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:55=E2=80=AFPM Cristian Marussi
<cristian.marussi@arm.com> wrote:

> ...a maybe dumb question from my side, BUT does the SCMI Pinctrl carry
> enough information as it stands for the driver to derive autonomously
> and efficently the possible/applicable gpio ranges ?

I don't know, that's part of the problem I suppose. But if the
pin controller can report functions supported by certain pins
or groups of pins, then certainly "gpio" should be one of those
functions or else the pin cannot be used for GPIO at all?

Then maybe that function is just a name convention, such
as "all pins are members of a 1-pin group named 'gpioN'
where N is the pin number" then you need to switch the pin
into this function in order to use the pin as a GPIO line.
Pins that do not have this group associated with them
cannot be used for GPIO.

This is incidentally exactly the method used by the Qualcomm
pin control driver (IIRC).

If the SCMI protocol has not though about GPIO as a special
function, or mentioned anything about group name
conventions for the GPIO function, then there is a hole
in the specification, and this is likely best filled by creating
one-pin groups as per above and feed this back to the
spec.

If the GPIO usecase isn't even considered a function by SCMI,
or (more likely) "nobody thought about that" then this is
a good time to send it back to the drawing board for
specification, right? It's normal for specs to run into a bit
of friction when confronted with the real world.

Yours,
Linus Walleij
