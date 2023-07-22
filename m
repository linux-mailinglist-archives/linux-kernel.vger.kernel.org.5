Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2075DD5F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGVQER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGVQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:04:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867BD1FDC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 09:04:15 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so4448492276.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690041854; x=1690646654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVZ6NzayxzXpFimMdkely4EwHnUziZUeTBp/5CAHzRk=;
        b=ckbv8HLTzbWKDYOBtH4QamaaZ72LuV0sFGWspU6ES/aeUdO2iHDcJbrZCMPiEvWJqT
         OVpl+fH+iTMGQL4yM/agOM1yBSjdajOAA0sYxnTnHt2dobCQo8ogUDy2dFdYKLrFNKqo
         JZutEFwfRknlIbHAWXsN5QzilD68z9H0pQjLIcssMZ8AEvwS6cOYhIRYNq3uUh3M3wRq
         bMDO4MQieFANatnSKeQCwsxMNHLMVjQCrC2lNMN7vGpHjCUT6LHoS4uhW02YbinT6hUQ
         +dBd1bqf1rxtifVwGe8FWMSJk08yG6X0viCIKj0zW7fPLA21WmIHZOnazEQymalo17XR
         IAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690041854; x=1690646654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVZ6NzayxzXpFimMdkely4EwHnUziZUeTBp/5CAHzRk=;
        b=DGw98OWMyfDQi89l8+ftuKvlxmMZ7HfE3YaiFhepPrN9xaCp9qqg5V0enLqpkNUiNh
         pbWsp/DDSc1/mmqlNGRKfh/uvhoSeTirs9nrynBdSiqYZniQz8hxykqopDrKuYs/BCQM
         g/wDVhFtDz9QxpAB/t023vVcpW2PQWlv2IEEhX1d5A5TqyqooE/XRot7py+2Zff1XLhF
         jiwhMoP+mu87N7J4xnhnBYn47qHMRm9B0rqK6qPB5IEhRZwQY4V12LoIecM5rg+Fisie
         DoMi56vAJ/hDpNl/K+/7c7aLYnPUHtSZVY916T7biq4rzZuP5p8QyDhFoo/ICxrF00A4
         FAmg==
X-Gm-Message-State: ABy/qLbIDvel+JdIuySnLFcSgjEcJmf+MybjsMpzMB6Uyl7cMLf1P2HR
        uzEh0sdBeIiazfOJ4yrMdR7d0RqbKXcsfXTqLNJ6DwGH
X-Google-Smtp-Source: APBJJlHP9H5Ba2BEyTM0JLFViMk+a6FtqMnjxm54FINawY/J7qdrqPlk62bYTZCS2A6MKCfEkvyIdwJSGVqGSR6hzBw=
X-Received: by 2002:a25:5507:0:b0:d01:a2e6:a3be with SMTP id
 j7-20020a255507000000b00d01a2e6a3bemr3673395ybb.5.1690041854752; Sat, 22 Jul
 2023 09:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230706185100.84322-1-hugo@hugovil.com> <CANiq72kZ0cHxCKkm_781G__9tJxYCw3tpJarqvLOFB4Jw6ZONw@mail.gmail.com>
 <20230706154937.1380bdcf9d84e1cff78911fa@hugovil.com> <7eb2d50baf269310e51854f700936e94@lemonage.de>
 <86wmysknde.fsf@davidreaver.com>
In-Reply-To: <86wmysknde.fsf@davidreaver.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Jul 2023 18:04:03 +0200
Message-ID: <CANiq72nO04+2BcwBe_P0uD8pXJtTMG3djAFAj5Ucez6VvT4g7g@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: move cursor home after clear display command
To:     me@davidreaver.com
Cc:     poeschel@lemonage.de, Hugo Villeneuve <hugo@hugovil.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christian Meusel <christian.meusel@posteo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 4:54=E2=80=AFPM David Reaver <me@davidreaver.com> w=
rote:
>
> I was actually hooking up a 16x2 HD44780 on my BeagleBone Black last
> night before I came across this patch, so I was able to test this. It
> works fine for me. I tested with:
>
>     $ printf '\f' > /dev/lcd
>     $ printf 'Hello\nWorld!\n' > /dev/lcd
>     $ printf '\x1b[LR' > /dev/lcd
>     $ printf '\x1b[LR' > /dev/lcd
>     $ printf '\x1b[LR' > /dev/lcd
>     $ printf '\f' > /dev/lcd
>     $ printf 'Goodbye\nWorld!\n' > /dev/lcd
>
> As expected, "Goodbye World!" was correctly placed left-aligned on the
> display, split over both lines. Let me know if there is something else
> you would like me to do to test this!
>
> Tested-by: David Reaver <me@davidreaver.com>

Thanks a lot, that is very helpful!

I will wait a while in case Christian or somebody else wants to test
it, and send it for 6.6.

Cheers,
Miguel
