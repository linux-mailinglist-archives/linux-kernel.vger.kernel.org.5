Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393677772D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbjHJLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjHJLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:35:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9067210D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:35:34 -0700 (PDT)
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F89E3F13B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691667333;
        bh=2n7sB/P+MVxtCrGdSlK3vHO7bX9b4hfYELYwbpKXbRE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=E5B/sVx5M6ziVs+k7F8P8onXPUE3All9dtxryUQ04dpn/UJb8IAvMF5ojpD0G5sGd
         yVDmL4WOLTlcvBsI8P1hcWkZKe5uK+sxpUhssoG9+op9xZLhmpsaOEDHWnUmOZAOL1
         ZP8i3RvH/9VoZGs1NXTCWq5eO3Go/S13W6gruXZD61QW1GeKHtmrbJ57E034py+eaX
         WN4ZJtMmV16Uri/HahnEqTJtkr7BRE8Px0u14tJvqbSAtd8Bi0Lqpo4gJE+k3rXCV2
         UqhkNljLS8BJLwFfo92bAymBuDpMO0MOgTwaCYJtuzE7jFbLGHlyh8M0p3bPCjeybu
         PjCxOT12Y84BA==
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40c10c73650so10292331cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667332; x=1692272132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n7sB/P+MVxtCrGdSlK3vHO7bX9b4hfYELYwbpKXbRE=;
        b=hqDDo0gJy/WBgkH6KbuwlMvimA03Ifip8Cyv6mB+s/YaUcLouCdZKozF3ROmYvo85a
         iaa4okj+Uc9933qIFKwBqgMXsrFf0T13/rPkeSg8wlMpxg+V8Vr55sJ3wlmLHdy6eWoI
         hUj4ryNOy0az0ODzBJnbzevoGGpLiFPiFwwyuPd6QyexvuuNSqTEvKEC6NCHkcG6bswP
         Kolp0EJmn+2uV+F5W9JjXaIu847pWZXcHBTuMugaAfo476ouiTYp9poEi5ad2cXtobFT
         ohqXoi3a1UYzXsZRBRcprgq91KOrnJ1FftlLd5VpDnWrc5Vug63Bi3al/rgRXsIJeEtM
         N3Dw==
X-Gm-Message-State: AOJu0YwTU2MnBA0l+97xkm1QCVtLlIKZnKNQ0M4cLVtJ6CbLB7KZy0L4
        qLIWkz20yY+PCfG+HEmkE8SSuY7Esudkw8F5CZ0mFvw1Ppv5e+JYRTVLNvJsPzORQF2F2L5x7wO
        7T6A0mPBkaEDwusna4c2QVj2iqRn+lGaD/f0wIp2dynMtw4K94KhT08a0JQ==
X-Received: by 2002:a05:622a:1648:b0:3ff:c677:a033 with SMTP id y8-20020a05622a164800b003ffc677a033mr2266443qtj.29.1691667332578;
        Thu, 10 Aug 2023 04:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8D2jRMka03WDcJfPuExlGjBBiL8v0s6iUaabJoidV44if4B92MIxNJM8K0yJh2I2+HR7DBIjvEpbhH7u6S8Y=
X-Received: by 2002:a05:622a:1648:b0:3ff:c677:a033 with SMTP id
 y8-20020a05622a164800b003ffc677a033mr2266430qtj.29.1691667332353; Thu, 10 Aug
 2023 04:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230718034937.92999-1-hal.feng@starfivetech.com>
 <20230718034937.92999-4-hal.feng@starfivetech.com> <20230718-progeny-edge-70b1a395f2aa@spud>
 <e63baeee-134c-db4f-f350-b3526a0ae571@starfivetech.com>
In-Reply-To: <e63baeee-134c-db4f-f350-b3526a0ae571@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 10 Aug 2023 13:35:16 +0200
Message-ID: <CAJM55Z_p4rFXVOUvXKRPH1r7KSXkVbSNtZAGA5Dyzw7TNfuLtA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] MAINTAINERS: Add Hal as a maintainer of SFCTEMP
 HWMON DRIVER
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 05:24, Hal Feng <hal.feng@starfivetech.com> wrote:
> On Tue, 18 Jul 2023 15:20:15 +0100, Conor Dooley wrote:
> > On Tue, Jul 18, 2023 at 11:49:37AM +0800, Hal Feng wrote:
> >> As he is the submitter of this driver, add his mail so he can
> >> maintain the driver and easily reply in the mailing list.
> >>
> >> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> >> ---
> >>  MAINTAINERS | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index aee340630eca..5056079ade77 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19256,6 +19256,7 @@ F:   drivers/net/ethernet/sfc/
> >>
> >>  SFCTEMP HWMON DRIVER
> >>  M:  Emil Renner Berthing <kernel@esmil.dk>
> >> +M:  Hal Feng <hal.feng@starfivetech.com>
> >>  L:  linux-hwmon@vger.kernel.org
> >>  S:  Maintained
> >>  F:  Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml
> >
> > Whatever about the other patches in this series, this one certainly
> > needs an Ack from Emil.
>
> Hi @Emil,
>
> Would you mind adding me as one of the maintainers of this driver?
> Within StarFive, I was appointed to maintain this driver.

Hey, sorry about the late reply. That's absolutely fine by me.

/Emil

> Best regards,
> Hal
