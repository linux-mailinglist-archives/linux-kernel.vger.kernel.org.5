Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A75788550
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbjHYLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjHYLB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:01:29 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BF21BC9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:01:24 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-79df12ff0f0so303390241.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692961284; x=1693566084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm1r4BFredFM9l2hXL1Ns0u9tVp5uce++0wcoYAEiXo=;
        b=jtZKDhVVLjB4WZC5b4LOqXOyPAgBX4rBa8ifrQgowNoz+rVUHfP1HmdXZ8Oka9gcxt
         KYkyUiTxGAK8Qooobp/dn28IluO4oR/Tr5A0zzOpu6UNdepiCNo5qJjitZPqKqrXcoX/
         NaGSKqjs4JtBx8FknEqeth65BhieB7hYIMz93i2xo244KiL9h209Ig3PxzRnDOsMZFuh
         gPpCTm7Ota1SSEgG6VSamCS33vxJ8bEOVj/9MWXbMubd0QO4goB4ee24Mfo703+xzm/7
         g1B2HYBBlO6rU5AjHeo374Y96GHf1lDjqc+DSxIwnA6NRYJYurlJqdE9/rWbvkPgKwNL
         r1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692961284; x=1693566084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm1r4BFredFM9l2hXL1Ns0u9tVp5uce++0wcoYAEiXo=;
        b=JAB8ba6NcClmd329nwkQkNjbIJ09ValdmmY3r1Z4A5qmFkZnBALbWwsKsI3GciwPTg
         5T2vqh2Fe+2MF5p+Q30mTJqlkDnbzYIfM5Y84TCfGYnU1K9GV6qLTGj8XCz68XjI2Yik
         9+kleOdA/hf9NdbNiukyUT+T1rGcQMtWv1eHtafpeuYSiKDn1qYRRqkqkojSr+G//qOt
         9d+P77gPqkzastIJwsPXCBBWP1en7vB7+aUfcXfvKl9IeAUiTSAE7mvYpOAnKS18bAqW
         acQLddPBbD41LviV4wGuW9QEl8lcSvMvEqe1GHVGKM+QBkeC/98DRpQETepJtoDEeiAK
         UjLA==
X-Gm-Message-State: AOJu0YzYAUbxkCUcoFC3CCXAqNrTFkS2ktNUS0jGf/jxV82ekx8iKOZW
        +VnE2pAYy7IDUSh9oLjO/ykl1MIBX7QtN5sJTFMG3w==
X-Google-Smtp-Source: AGHT+IEF09Ea5vepo76zoBbWYctMnJ3nQqBTwvvVbowG9g3EYhkla+ZqowrdT5614wYHglHhKhAJw3Lf26l9/fFO59w=
X-Received: by 2002:a05:6102:4b7:b0:44e:9313:b045 with SMTP id
 r23-20020a05610204b700b0044e9313b045mr5029333vsa.7.1692961283748; Fri, 25 Aug
 2023 04:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093621.23209-1-brgl@bgdev.pl> <20230814093621.23209-3-brgl@bgdev.pl>
 <875y54ci86.ffs@tglx> <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
In-Reply-To: <873507cziz.ffs@tglx>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Aug 2023 13:01:12 +0200
Message-ID: <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:11=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Fri, Aug 25 2023 at 00:36, brgl@bgdev.pl wrote:
> > On Thu, 24 Aug 2023 22:12:41 +0200, Thomas Gleixner <tglx@linutronix.de=
> said:
> > Here a GPIO device - that is also an irq chip - is unbound (this is a t=
esting
> > module unbound during a test-case but it can be anything else, like an =
I2C
> > expander for which the driver is unloaded) while some users called
> > request_irq() on its interrupts (this is orthogonal to gpiod_get() and =
doesn't
> > take a reference to the module, so nothing is stopping us from
> > unloading it)
>
> You just described the real problem in this sentence. So why are you
> trying to cure a symptom?
>

Cc: Linus Walleij

Honestly I'm not following. Even if we did have a way of taking the
reference to the underlying GPIO module (I'm 99% percent sure, it's
not possible: we're not using any of the GPIO interfaces for that,
just platform_get_irq() or similar and all the GPIO subsystem sees is
the call to .irq_map() but that doesn't look like a reliable place to
take that reference) - that wouldn't stop anyone from unbinding the
device elsewhere: from user-space over sysfs or maybe it's a GPIO
expander over USB that gets unplugged (I know that it would only be
described in DT if it was hard-wired but it's still within the realm
of possibility).

Because this situation (removing a device while it still has users) is
possible, we have a way of handling that in the GPIO subsystem, where
if a device you're using goes from under you, the GPIO descriptor (the
only interface consumers have to that device) is "numbed down" and no
longer functional but doesn't leak resources or crash.

I was under the impression that the whole irqnum-to-irq_desc mapping
was designed to handle this situation on purpose, hence a check for
!desc and a silent return in free_irq(). If a missing mapping was a
bug, then it would warrant at least a warning, right?

Bartosz
