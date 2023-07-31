Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A68769D17
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjGaQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjGaQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:46:10 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA7F1989;
        Mon, 31 Jul 2023 09:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V7LYZHk85S0LI4siidMWcKMqDbXK1bLv/yuz6F1RLm8=; b=Fy0Hz75EHjZzZBRkW56/NraHk5
        jYw5uhQqXHa0kn5P/EaDN/SYTYybe6vXj2uTSKzQGQUmzpQ04Bs0fWckI/8autDGyBDVmINv7G9m+
        VWmXLpm32civzImJrr1kQxPurp7pCVODEe73k0eGHGHofLlzNT3k1c0KLPGCsM4cRuwM=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:34026 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qQW1w-0006gy-VD; Mon, 31 Jul 2023 12:46:01 -0400
Date:   Mon, 31 Jul 2023 12:46:00 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Message-Id: <20230731124600.39eb8d5c132f9338c2897543@hugovil.com>
In-Reply-To: <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
References: <20230721161840.1393996-1-hugo@hugovil.com>
        <20230721161840.1393996-7-hugo@hugovil.com>
        <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
        <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com>
        <2023072240-supremacy-shallot-a77f@gregkh>
        <20230724115428.d191186852c0bd0ee0d78398@hugovil.com>
        <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 09:31:53 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Mon, Jul 24, 2023 at 9:54 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> >
> > On Sat, 22 Jul 2023 17:15:26 +0200
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > > On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> > > > On Fri, 21 Jul 2023 13:24:19 -0600
> > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > > On Fri, Jul 21, 2023 at 10:19 AM Hugo Villeneuve <hugo@hugovil.com> wrote:
> > > > > >
> > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > >
> > > > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines")
> > > > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > > > > changed the function of the GPIOs pins to act as modem control
> > > > > > lines without any possibility of selecting GPIO function.
> > > > >
> > > > > Requiring a new DT property is not fixing a kernel regression. You
> > > > > should be returning the kernel to original behavior and then have a
> > > > > new DT property for new behavior.
> > > >
> > > > Hi Rob,
> > > > please read the entire patch history starting from V1
> > > >  and you will understand why this course of action was
> > > >  not selected.
> > >
> > > That's not going to happen, sorry, you need to explain it here, in this
> > > patch series, why a specific action is being taken over another one, as
> > > no one has time to go dig through past history, sorry.
> >
> > Hi Rob,
> > I initially submitted a patch to revert the kernel to original
> > behavior, but it created more problems because the patch was
> > unfortunately split in two separate patches, and mixed with other non
> > closely-related changes. It was also noted to me that reverting to the
> > old behavior would break things for some users.
> >
> > It was suggested to me by a more experienced kernel developer to
> > "suggest a fix, instead of hurrying a revert":
> >
> >     https://lkml.org/lkml/2023/5/17/758
> 
> Do I have to go read this to decipher the justification and reasoning?
> When Greg says "in this patch series", he means in the commit messages
> of the patches. You send v9 already and it doesn't have that. The
> patchset needs to stand on its own summarizing any relevant prior
> discussions.
> 
> I never suggested doing a revert.

Hi Rob,
I am sorry, but this is exactly what I "deciphered" from your
original email.

I am trying very hard to understand exactly what you mean, but it is
not that obvious for me. If something is not clear in my commit message,
I will try to improve it. But before, let's try to focus on making sure
I understand more clearly what you want exactly.

> Obviously, someone still wants the
> new feature.

I assume that you refer to the "new feature" as what was added in
the commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
lines")?

Because I did not add a "new feature" myself, I simply restored (or
want to restore) what was working before commit 679875d1d880
(restore GPIO pins as GPIO functions).

I will wait for your clarification on this, and answer your other
comments after.

Hugo.


> The issue is a new feature was added to the kernel, but
> you are requiring a DT change to platforms NOT using the feature.
> Make
> the platforms wanting the new feature to need a DT change. That's
> still not great, but it's much better to affect new platforms rather
> than old, stable platforms. The period of time that regresses is much
> smaller (a few kernel releases vs. years potentially). Of course, if
> it's just those 3 platforms and their maintainers are fine with
> needing this DT change, then that works too. But there's no evidence
> here that they are okay with it. You didn't even do the update of the
> dts files and just left them broken.
