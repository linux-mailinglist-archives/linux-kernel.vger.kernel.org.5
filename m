Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC677BFFB8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJJOxl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjJJOxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:53:37 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AFBAF;
        Tue, 10 Oct 2023 07:53:35 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-9b29186e20aso983053866b.2;
        Tue, 10 Oct 2023 07:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949613; x=1697554413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2WcnQotkJYAWCE6CEWba043WY3ByyYClp8a0rZyMlw=;
        b=IL/+MoOu4lHRDpcRRt+6K2s9O9avOHU9X0cR3lTnhpMAcwUxnoks/2tAiH7nmfhy3k
         HVHZzLtwpwo0CZ6hDdOXUBR85qUmefdgw5w89xtFPpR+GZBrJeIMHWaxoGRk4uCALywR
         BJBDqBB4VDwFlGDEWFIAAciiop5hiUgygCICuWDgSqT8BGWicLBe92MlY7zWksxZNHMd
         WkWXzG7h7Po93hvtMsGmXF2NhFt+Yhv18u8l8NWUw7yRAhunBDiAvpI03rMv83U0YAWd
         VPtR6Uea3wvtEIcAlHfKsWDe1Z5/lf9CQZT6CkQn85ZmXZhPIGcXRh/Kk6hk6oEVojVO
         w9cg==
X-Gm-Message-State: AOJu0YxhOBg3ZgKqtwXQnGtq4+NCHDIsaz4ZRFUwhGQFMQEy0LriuQMR
        WrmSw9gIrMZuj2S58R3ld1NE3YYUwDVMsrcV
X-Google-Smtp-Source: AGHT+IGsIfK0Zy+vZKhBmDZIUZ4M/XAyefeAZ83TW23ZSGesPv12jfc3BywCGT/LL1knu6CYWMYUiw==
X-Received: by 2002:a17:906:20d8:b0:9a1:bebc:8282 with SMTP id c24-20020a17090620d800b009a1bebc8282mr15374190ejc.32.1696949613595;
        Tue, 10 Oct 2023 07:53:33 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ss7-20020a170907038700b009a9fbeb15f5sm8440056ejb.46.2023.10.10.07.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 07:53:33 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53da80ada57so757175a12.0;
        Tue, 10 Oct 2023 07:53:33 -0700 (PDT)
X-Received: by 2002:aa7:dd0c:0:b0:538:15df:d12f with SMTP id
 i12-20020aa7dd0c000000b0053815dfd12fmr15463803edv.18.1696949612893; Tue, 10
 Oct 2023 07:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org> <3c5a3e7a-b332-4a77-51ba-bed3cad1e79f@marcan.st>
 <e1ee4d76-f717-a67c-8099-7b91192ba1ca@yandex.ru> <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
In-Reply-To: <e470902a-35eb-9bb4-7a9e-167f985c98bb@marcan.st>
From:   Neal Gompa <neal@gompa.dev>
Date:   Tue, 10 Oct 2023 10:52:56 -0400
X-Gmail-Original-Message-ID: <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
Message-ID: <CAEg-Je-mpcrEoM_nD3_8A=gZhdWpn3hxfGZNEfGRNupGwRdetw@mail.gmail.com>
Subject: Re: On brcm80211 maintenance and support
To:     Hector Martin <marcan@marcan.st>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com,
        Asahi Linux <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Phil Elwell <phil@raspberrypi.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 8:51 AM Hector Martin <marcan@marcan.st> wrote:
>
> On 07/10/2023 00.48, Dmitry Antipov wrote:
> > On 10/6/23 18:34, Hector Martin wrote:
> >
> >> For better or worse, if nobody else does, I'm willing to sign up to
> >> maintain the chips shipping on Apple ARM64 machines (i.e. BCM4378,
> >> BCM4387, BCM4388 - that last one I have bringup for downstream, just got
> >> it done this week) and partially BCM4377 as a bonus (since I have access
> >> to an older Intel Mac with that one, and already did bringup for it,
> >> though my access is sporadic). I'm already playing part time maintainer
> >> anyway (other folks have already sent us patches I'll have to upstream),
> >> and we need this driver to keep working and continue to support new chips.
> >
> > Good news. Would you capable to consider some generic (not hooked to any
> > particular hardware) things like [1] ?
> >
> > [1] https://lore.kernel.org/linux-wireless/20230703162458.155942-1-dmantipov@yandex.ru/
> >
>
> Sure, I've done cleanup type stuff myself too.
>

Can we please get this done so that the pile of Broadcom patches can
actually start landing again? It's been frustrating watching patch
submissions be ignored for over a year now. At least add Hector as a
co-maintainer and allow him to land stuff people have been using
outside to get Broadcom Wi-Fi to *work*.

Having stuff sit on the pile and be *ignored* is frustrating for
contributors and users, and massively disincentivizes people from
working in upstream Linux.



--
真実はいつも一つ！/ Always, there's only one truth!
