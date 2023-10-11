Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612CA7C5269
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjJKLr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjJKLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:47:24 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B5CCC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:47:22 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7c7262d5eso18813487b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1697024841; x=1697629641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F2CO58cNkDLoM5uuHoWEqHDI+8aDNQ1qA3on6BCuTZk=;
        b=WXq0GO8q10iIiyT4pZkVOcdRFXFlVaEBvnF0h7Eajk8D/jtWXFsWbUV3LJY/ZyCVlf
         m2r0dgx0x4lDNLIwJFLuBMHXkyBahTWe1DPu+Ixc6hOXq/vcA+/kNIJDSLaEWZeb92xu
         7bvLL4oW9lZu/OEx3stniOPkfIeBm0jfyB7/TAnR0bLjJv4VchK5WAAj73VzLwB+1MBn
         hCrEQi0Gldiz4klw7ATqq/EjjVFgeWz2HI9riKUJrpKW9Ftl50EB09zMMpI8UH3byaTf
         FGgmvYkudJcTfsUlg4AmDzTJwbcOav25gqTNfVMvUVhU/sp7BvOHHr1Pr4ao3AmTzFLA
         52gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024841; x=1697629641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2CO58cNkDLoM5uuHoWEqHDI+8aDNQ1qA3on6BCuTZk=;
        b=ZIf6VxwgGSToOPOb2xnJ45+dNp1qStm5V3RvuKQwLlvNViIMN789w0tClDzHaLc6sO
         VrGyBrry0zuv4+dxd9hFun4kW3+rDQLkZA5drW2AW2qF19avfEZ+/eZP3/aSLQ/LWZDt
         KAGc/4pAE7XsMbMZl/uCBXpi47GmSmJY8UtKx9tgwBmBS7csK+NhZlesnOLPGvcfkK7T
         vicotblLwsGcFWxksxtFF8/KLSP70CSsLqDdKiBT0hrvJfaZd3QT2L2Nb5RjADmCq/og
         NDGjl1YRF360SclHyWRtImvZYawM1j7G8JMC4oiQoSnQgBREDBLcBsHgso0LPTAftK3S
         88hA==
X-Gm-Message-State: AOJu0Yx3tQSdZ9JyPS9ZFCQ5sV7+3JibYZlZr3JYSTKFc7yCKsSkiI5J
        Wz59827oz5t/ItqmsT5i6WozEaaK8w0VxfllvOO/MA==
X-Google-Smtp-Source: AGHT+IEXrl726KTwCoMXxA1mBIhJL2iH49mJ0WxzlwoEn3AUEKiO+Ze6qdfiQ8RSDTE2/HhIsAjgsjAIUKzuCUvwvPY=
X-Received: by 2002:a25:ac09:0:b0:d9a:63f5:10d6 with SMTP id
 w9-20020a25ac09000000b00d9a63f510d6mr4060901ybi.26.1697024841277; Wed, 11 Oct
 2023 04:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru> <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
 <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
 <87edi14fvp.fsf@kernel.org> <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
In-Reply-To: <cce5765d-342f-4811-ab7f-fb41ede0b3a1@marcan.st>
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Wed, 11 Oct 2023 12:47:10 +0100
Message-ID: <CAMEGJJ0=qM85F64ox5LLug5PWnBa4W9zDOqNay6ScU-aweSzHw@mail.gmail.com>
Subject: Re: On brcm80211 maintenance and support
To:     Hector Martin <marcan@marcan.st>
Cc:     Kalle Valo <kvalo@kernel.org>, Neal Gompa <neal@gompa.dev>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phil Elwell <phil@raspberrypi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 at 12:28, Hector Martin <marcan@marcan.st> wrote:
> I think we need to qualify this "no regressions" "rule". People regress
> our machines in mainline all the time. We catch it and get it fixed,
> sometimes in RCs, sometimes it goes all the way to stable and needs to
> get fixed there. We've had patches break everything from Bluetooth LE
> pairing to core memory management to the point we needed earlycon to
> diagnose it. That last one was a blatantly wrong patch to core Linux MM,
> it wasn't even something specific to our platform, but even that got
> past review (it just happened to break us specifically due to a
> coincidence).
>
> The review process doesn't magically avoid regressing things. "No
> regressions" is impossible without someone actually testing things.
> Claiming otherwise is dishonest. So if I end up as maintainer here I
> certainly am not going to promise "no regressions" for chips I can't
> test, without someone interested in those chips testing them. Of course
> I'll take regression fixes when they do happen and someone notices, but
> I can't know in advance until someone does.
>
> Consider a patch that changes some codepath in the driver. I can't know
> whether the original logic was always broken, or whether it worked on
> some chips, and whether the new logic works on those chips or will
> regress them, without testing. This is a regular occurrence with
> brcmfmac, due to the complexity and variability of the firmware
> interface. Often multiple versions of stuff are supported, or some
> structures can be extended, but sometimes they can't. It's a mess, and
> without firmware source code nor any official specs, there is no way to
> know exactly what is intended and what the backwards compatibility
> requirements are.
>
> The only way to avoid that is to gratuitously introduce version/chip
> gates for *every single change affecting behavior from the firmware
> POV*, which is a complete non-starter and would quickly yield a giant
> mess of spaghetti code. It's bad enough having to support explicit
> ABI-breaking changes in firmware, and having to deal with multiple
> versions of huge structures and convert between them. Trying to outright
> keep existing logic identical for "other chips" is just not going to
> happen, not without first having confirmation of what the requirements
> are from someone who has the required docs/source.
>
> I have a patch to enable WPA3 in Broadcom chipsets (yes, the driver is
> in such a sorry state it doesn't even support that yet). The current
> support attempt was added by a Cypress engineer and uses a completely
> different firmware mechanism. Is that supposed to actually work? Does it
> work currently? Is that the case for all Cypress firmwares? Or only
> some? Does the alternate mechanism we have for Broadcom chips work too?
> Only Cypress can answer those questions ahead of time, and they aren't
> (they ignored me last time I brought this up). So my current patch just
> replaces the mechanism with the known-working one for Broadcom chips.
>
> Next time I send a bunch of our downstream patches, I'm going to resend
> that WPA3 patch. And if it regresses Cypress WPA3 support, tough luck.
> If someone catches it (Phil?) and it turns out the existing support is
> the only way to do things on Cypress, I'll rework the patch to
> conditionally support both styles. But if nobody does, and nobody cares,
> then I'm sorry if I regress things, but there is no way to avoid it. We
> can't be gratuitously gating every single change just to hope to avoid
> regressions, without any confirmation of what is required. That just
> doesn't scale.
>
> Phil: Given Cypress' complete apathy towards this driver, if you want
> the Cypress chips in Raspberry Pi systems to continue working and catch
> potential problems ahead of time, it would be helpful if you can test
> the patches in this branch. This is our downstream brcmfmac patchset.
> Regardless of what ends up happening with the maintainer situation,
> giving this a whirl will be very helpful in catching problems with
> systems people actually use. It should be easy to bisect regressions too
> (we keep this rebased directly on recent kernels so you can apply it on
> top of your tree or whatever).
>
> https://github.com/asahilinux/linux/tree/bits/080-wifi

That sounds like a reasonable starting point - I'll take a look.

Phil
