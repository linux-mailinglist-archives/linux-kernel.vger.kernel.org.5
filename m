Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D10B7FE15F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjK2Uuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbjK2Uup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:50:45 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161FF10CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:50:51 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-46447559b88so40884137.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701291050; x=1701895850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRudQj2Sfvl8763B7G4OIzr5GVWbGpaCjlcn22UtovM=;
        b=l5F9ChCjm23piNt+umQ8fYdqmWhckcLh5uaAl586gQNpYCRu/+z1fHBe63t+OpzApB
         8IrYs97p3At1xY8KK588yTWTojFmXlw/AgcWSDiX7cHFov4N7LW2k/6nsJT/2eaaOmbW
         vOOGxaf0BF/B65lwC44ZAlyPhv++D5baI1fiBthGtcnIRmODwSrv7fevIAvuSyam+3yw
         aPqVG8bchiCzvl51qmKIsB/lABt6rhlED4HRfYZP5pT0mOHxf+a8GzjGciuRUWz3g6tm
         05yWBJ3lAAHs9nR7gjYtrXiBuW/irlfSLafs/AKV0mUdyKKbheqLM2edld9qn8DBpUbT
         H/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701291050; x=1701895850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRudQj2Sfvl8763B7G4OIzr5GVWbGpaCjlcn22UtovM=;
        b=lXSGIT27+VS1eTuPVxDrrFZY6hr04viOrf6hA+ocaZD2Wk2n5qIQxvW+6v+bdMWU8C
         /H/D3lQDehw8QmbXk8/AZBTUD/LP2VUKKzaK3uOLnb1tKtpnNXOarABnd8LxwOaqTj8K
         7Z0k7lqz0q8LVBbRTkf/bDnWgdubwFcVweEVZousqoTb05vs8RXFoSaWEvT61aJ+AmuT
         nHJ1z/+duFxXIHnACXvcGAd/k3Nc2bWOgNwpT4D8C30iL1adBIys03T1SeLcB7ep+d6S
         Gan+8mia0zFEotB7AeNV5vbdW0oQY0FWkBqy29yVySxj79qIi206h+cLVmTrxMnqEIH6
         BcfQ==
X-Gm-Message-State: AOJu0YzD//tcibOBuqc4PRCrhh6on0m5CaoDzqHOnaYWGYrGi5zROwDj
        ZSpdl1zkTwYj91BxuHWRptnUuGwlCDMBauJuZ7quTQ==
X-Google-Smtp-Source: AGHT+IFD0eT1lvn2YTfiznalgCyAUE9zsky5MpegMQkPYxHXziqnBprEE1cMdMhM3zu84Hx1Vg83n8wmZOOLG6XvBq8=
X-Received: by 2002:a67:eb52:0:b0:464:4f42:c195 with SMTP id
 x18-20020a67eb52000000b004644f42c195mr2247378vso.8.1701291050105; Wed, 29 Nov
 2023 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20231115165915.2936349-1-brgl@bgdev.pl> <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
 <ZWeXqtqJLKB02LWU@yury-ThinkPad>
In-Reply-To: <ZWeXqtqJLKB02LWU@yury-ThinkPad>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 21:50:39 +0100
Message-ID: <CAMRc=MdjoYjFzwoDhywx45asun+AyUho_U+cgZoETVP+VuvmBA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 8:59=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Wed, Nov 29, 2023 at 10:18:15AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 15, 2023 at 5:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Here are a couple of updates to the interrupt simulator. Two are mino=
r:
> > > remove an unused field and reorder includes for readability. The thir=
d
> > > one simplifies the error paths by using new cleanup macros. To that e=
nd
> > > we also add a cleanup definition for dynamic bitmaps.
> > >
> > > Resending rebased on top of v6.7-rc1 and with tags collected.
> > >
> > > v1 -> v2:
> > > - add a NULL-pointer check to the bitmap cleanup macro as advised by
> > >   Peter Zijlstra
> > > - initialize managed pointers when declaring them to create a clear p=
airing
> > >   between the type and the cleanup action
> > >
> > > Bartosz Golaszewski (4):
> > >   bitmap: define a cleanup function for bitmaps
> > >   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
> > >   genirq/irq_sim: order headers alphabetically
> > >   genirq/irq_sim: shrink code by using cleanup helpers
> > >
> > >  include/linux/bitmap.h |  3 +++
> > >  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
> > >  2 files changed, 15 insertions(+), 18 deletions(-)
> > >
> > > --
> > > 2.40.1
> > >
> >
> > It's been two weeks since this submission and ~2.5 months since the
> > first one so I guess, a gentle ping is in order. This is not a very
> > controversial series - can this be applied?
>
> Hi Bartosz,
>
> I'm the first in the list for this series, but really only 1st patch
> is related to bitmaps, and I already acked it. If you prefer that, I
> can pull it in the bitmap tree.
>
> Thanks,
> Yury

If there's a risk it will conflict then you can apply it and provide
Thomas with an immutable branch against the irq tree, otherwise I
think Thomas can pick up all the patches.

Bartosz
