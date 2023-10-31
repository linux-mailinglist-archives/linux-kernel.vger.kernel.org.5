Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672167DD09F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbjJaPek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345071AbjJaPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:34:35 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D8F5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:34:30 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a877e0f0d8so59028937b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1698766469; x=1699371269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JuhKnmFrsUcWac+M+pPDxSwVN9t4JEGepkiIyf5XmSc=;
        b=hSyeTdYNalKvo5TnxNl+ed4dSsBZykY8g7idHq6CtpL2Ko5+I1CZFEGM9W7z5lrf96
         bOYSAaTNO4wwma+7wRTNDohWjTi6cWWZbydmZ71AxNpki7ksmkuP/2cc+7FBDi+7TA1G
         A2//Rwmi6D9sBATURx+jEQt1CLWGEtS1YI5n4fRlorSfzo/mgrjZknuXrxJnYxQCLNf6
         TjHc981S64Jqmt0pCHB7aArp+80CGedV0HYwhOVlG5qRYEhm8Am8riRx2dvOwCtsdpYw
         rwzntnemoHiG73Q1qelTrsHhK+cWRoIHs2JkQwQKPKR9dkuwDZLuN1YW4ARhv7H2lvwU
         3Rig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766469; x=1699371269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuhKnmFrsUcWac+M+pPDxSwVN9t4JEGepkiIyf5XmSc=;
        b=DCDDEqsoahkSdzYfb6qWrvld6eHrAflZJzthOzm0agpHG6thEQlRG95DIEYAuHyTHR
         VCveFRIldy9YR6xCp8Y2ltNsqh8id9rjH1K2Ve8Siyj/To2SYQKi0Bufr7mhhbLDdbcx
         0QV4B8pHDbeWT+Ejqo3pQneImOpbwJm14NlhkQgAe/YVINDUGgYTMT5Ywyc49b/EKbyq
         fMgWbp6ucMOTU6TVongv4ZCn21vjqNTC9Q7GvRtU/mjLpuR5YX2OhtFOnP50PfefMD9F
         NRRaYVaPs4/ZNat/eLGyIEWfuvNGHUc2tAp92XeKhthbQhFrU3NxkyULxHBSw1BEg35H
         ZSsQ==
X-Gm-Message-State: AOJu0Yw2sBsLBBp3KlUkUXP4L6JhPUvQwZ45nnQVPJEpcouOdQ9+kMyB
        kgGPSgP5JXhviuhtnO9XsSKOxaq0mQRDFwnsG/AhNw==
X-Google-Smtp-Source: AGHT+IEBhRuphAc7IszP/wt0/QQ3TtswxFJ0B0XQe7BIf2MfLiFrnJ1nPdmlmmo1ahB5VsscZt8+UzZlQauK7ua5jvA=
X-Received: by 2002:a81:8d14:0:b0:5af:97b6:9def with SMTP id
 d20-20020a818d14000000b005af97b69defmr2491642ywg.24.1698766469629; Tue, 31
 Oct 2023 08:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com>
 <20231030162114.3603829-3-mike.isely@cobaltdigital.com> <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net>
In-Reply-To: <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Tue, 31 Oct 2023 15:34:14 +0000
Message-ID: <CAPY8ntD1F=Lskoayc9YHKvvh59TcZe7zdfq5H=M5mbNHraGUDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
To:     Stefan Wahren <wahrenst@gmx.net>
Cc:     mike.isely@cobaltdigital.com, Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Isely <isely@pobox.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Thanks Stefan for forwarding - linux-rpi-kernel seems to be a little
too aggressive on spam filtering, and I'm not on the other lists
cc'ed).

Hi Mike

On Tue, 31 Oct 2023 at 12:37, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> [Forware to Dave and Phil]
>
> Am 30.10.23 um 17:21 schrieb mike.isely@cobaltdigital.com:
> > From: Mike Isely <mike.isely@cobaltdigital.com>
> >
> > There is a race in the bcm2835 i2c hardware: When one starts a write
> > transaction, two things apparently take place at the same time: (1) an
> > interrupt is posted to cause the FIFO to be filled with TX data,
> > and (2) an I2C transaction is started on the wire with the slave
> > select byte.  The race happens if there's no slave, as this causes a
> > slave selection timeout, raising the ERR flag in the hardware and
> > setting DONE.  The setting of that DONE flag races against TXW.  If
> > TXW gets set first, then an interrupt is raised if INTT was set.  If
> > ERR gets set first, then an interrupt is raised if INTD was set.  It's
> > one or the other, not both - probably because DONE being set disables
> > the hardware INTT interrupt path.

I'm not following the full sequence of events required here.
If you only had a slave selection message, then num_msgs = 1 and INTD
will be enabled immediately anyway.

I did investigate some I2C issues back in May due to observed issues
between one of the camera modules and the DSI screen touch controller.
If memory serves correctly, the biggest issue I found was that
aborting the transaction when active just left SDA & SCL in whatever
was the current state, including midway through a byte and no stop
condition. I didn't find a valid way to do a controlled stop, and
therefore ended up with a patch that will always complete the
transaction before looking at the status flags [1]. (Yes, I really
should upstream those patches).

For a linked thread[2] I think I found that the ERR flag wasn't
signalled until the end of the complete transaction.


Hang on, if you're always enabling BCM2835_I2C_C_INTD, then if we have
a write of N bytes and read of M bytes, don't we get a DONE after the
write, meaning that the ISR completes then due to the clause at [3]
and we never do the read? Something feels wrong here.

  Dave

[1] https://github.com/raspberrypi/linux/pull/5479/commits
[2] https://forums.raspberrypi.com/viewtopic.php?p=2098691#p2098691
[3] https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-bcm2835.c#L293-L306

> >
> > MOST of the time, TXW gets set first, the ISR runs, sees ERR is set
> > and cleanly fails the transaction.  However some of the time DONE gets
> > set first - but since the driver doesn't enable INTD until it's on the
> > last message - there's no interrupt at all.  Thus the ISR never fires
> > and the driver detects a timeout instead.  At best, the "wrong" error
> > code is delivered to the owner of the transaction.  At worst, if the
> > timeout doesn't propertly clean up the hardware (see prior commit
> > fixing that), the next - likely unrelated - transaction will get
> > fouled, leading to bizarre behavior in logic otherwise unrelated to
> > the source of the original error.
> >
> > The fix here is to set INTD on for all messages not just the last one.
> > In that way, unexpected failures which might set DONE earlier than
> > expected will always trigger an interrupt and be handled correctly.
> >
> > The datasheet for this hardware doesn't describe any scenario where
> > the hardware can realistically hang - even a stretched clock will be
> > noticed if it takes too long.  So in theory a timeout should really
> > NEVER happen, and with this fix I was completely unable to trigger any
> > further timeouts at all.
> >
> > Signed-off-by: Mike Isely <isely@pobox.com>
> > ---
> >   drivers/i2c/busses/i2c-bcm2835.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > index 96de875394e1..70005c037ff9 100644
> > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > @@ -235,26 +235,22 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
> >
> >   static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
> >   {
> > -     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> > +     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD;
> >       struct i2c_msg *msg = i2c_dev->curr_msg;
> > -     bool last_msg = (i2c_dev->num_msgs == 1);
> >
> >       if (!i2c_dev->num_msgs)
> >               return;
> >
> >       i2c_dev->num_msgs--;
> >       i2c_dev->msg_buf = msg->buf;
> >       i2c_dev->msg_buf_remaining = msg->len;
> >
> >       if (msg->flags & I2C_M_RD)
> >               c |= BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
> >       else
> >               c |= BCM2835_I2C_C_INTT;
> >
> > -     if (last_msg)
> > -             c |= BCM2835_I2C_C_INTD;
> > -
> >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
> >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
> >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
> >   }
>
