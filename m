Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E3B776D34
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjHJAoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHJAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:44:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE741734
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 17:44:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso3197585e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 17:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1691628239; x=1692233039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDWx3DcxoKpJRctWjtj4pBlDkFLDSOylce44ZfHBSN8=;
        b=CIUlemqWEkXov35qJg0ru08Cw/3GWl41Olp0k7jGVUTpWa82P7dY0F+456s0sEdJkD
         wSO0+TQeQsOVmcD++1SsdKQQlSH9FWhLQIXUCIlOuQeK9kPeTKP0PSWy3hBbvlNdytS1
         WHD7TXI8AjOUNO7VzSEHjao6xhh3oEpSEITNUjT5n0Wzb/aSNgf63+aMXgDaB8nRRBS0
         3cLZYg8mf7+fCLcSlsf80XXwcFLMsB0bHKEU8vpckLLXeMIMxSB1Gj34G1eb/gZzuvFs
         elsWGI3WEQH4C121c5NA2vTLkXWf8x3VSE7xwQVFl/Mp+fDbANMLAqleKxUvA1DNlN+1
         g6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691628239; x=1692233039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDWx3DcxoKpJRctWjtj4pBlDkFLDSOylce44ZfHBSN8=;
        b=GBrD58k0h2Q41g4z0hXt6bvek6ha6RvcJd8Y/RWg6FfOSx09uEXVM4nY2Te9nq/dQc
         65Pt9R9mSF5Q6E2D9VOFzfPdzCVZy+Ggh1RF9O869isdHNVoPd6sfhDZt+hGmJTYmLpd
         g4BYE2tcoslLvbUXwZizr8UbhEucGMmRXDPgxiByANi1hxccwPG8pis+WL1GTamQ7+Qq
         jZaWuXKxQguZZMoOZdTjRBQULdRB1i+2SpEjRi9k/MK07rHo27dJqvp/m7zLv9PYRscr
         2FUdMFKDFywIyBg90xXxKx8luXN1vSRnYBpZxRQpxyZnMEExeWfPFc4s+bUNM9a2tBJy
         vrAg==
X-Gm-Message-State: AOJu0YwscoBfVFYBL5RAd1kFlXGmGV9CXsJriRfPkUrhort0DL8EfXDo
        SlTeoh6gVSN3+ArP7jgwiGDPBEOKCXb4sXoykdhWNWJkAqllKWqg
X-Google-Smtp-Source: AGHT+IGJzTPh4hKoh8q8sQMHEqYWOdntx3C6LEjObQGr4JoMpJL1QMoosxgOtqm8h3ZBXyuvoKpo7G4X590kGIAcyBs=
X-Received: by 2002:a7b:cc88:0:b0:3fc:9b:9e85 with SMTP id p8-20020a7bcc88000000b003fc009b9e85mr585060wma.18.1691628238843;
 Wed, 09 Aug 2023 17:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <002201d9ca0c$27606f70$76214e50$@telus.net> <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
 <CAAYoRsWfMTX_ifNG5w9LS50OcPx87yJHg_PSvROoQJJ605eJEA@mail.gmail.com> <4872c41b-c8fd-1f84-7940-d4944c667e6f@linutronix.de>
In-Reply-To: <4872c41b-c8fd-1f84-7940-d4944c667e6f@linutronix.de>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 9 Aug 2023 17:43:51 -0700
Message-ID: <CAAYoRsXZsbh0o5fTDjjvTN7bS2EQOY9XWwnM8_MGTiwkAS8pYQ@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Doug Smythies <dsmythies@telus.net>
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

On Wed, Aug 9, 2023 at 9:24=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
> On Tue, 8 Aug 2023, Doug Smythies wrote:
> > On Tue, Aug 8, 2023 at 9:43=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > > On Tue, Aug 8, 2023 at 5:22=E2=80=AFPM Doug Smythies <dsmythies@telus=
.net> wrote:
>
> [...]
>
> > > > Conclusions: Overall, I am not seeing a compelling reason to
> > > > proceed with this patch set.
> > >
> > > On the other hand, if there is a separate compelling reason to do
> > > that, it doesn't appear to lead to a major regression.
> >
> > Agreed.
> >
>
> Regarding the compelling reason:
>
> On a fully loaded machine with 256 CPUs tick_nohz_next_event() is execute=
d
> ~48000 times per second. With this patchset it is reduced to ~120 times p=
er
> second. The factor for the difference is 400. This is already an
> improvement.
>
> tick_nohz_next_event() marks timer bases idle, whenever possible - even i=
f
> the tick is not stopped afterwards. When a timer is enqueued remote into =
an
> idle timer base an IPI is sent. Calling tick_nohz_next_event() only when
> the system is not that busy, prevents those unnecessary IPIs.
>
> Beside of those facts, I'm working on the timer pull model [0]. With this=
,
> non pinned timers can also be expired by other CPUs and do not prevent CP=
Us
> from going idle. Those timers will be enqueued on the local CPU without a=
ny
> heuristics. This helps to improve behavior when a system is idle (regardi=
ng
> power). But the call of tick_nohz_next_event() will be more expensive whi=
ch
> led to a regression during testing. This regression is gone with the new
> teo implementation - it seems that there is also an improvement under
> load. I do not have finalized numbers, as it is still WIP (I came across
> some other possible optimizations during analyzing the regression, which
> I'm evaluating at the moment).
>
> Thanks,
>
>         Anna-Maria
>
>
> [0] https://lore.kernel.org/lkml/20230524070629.6377-1-anna-maria@linutro=
nix.de/

Thank you for the context and the link.

... Doug
