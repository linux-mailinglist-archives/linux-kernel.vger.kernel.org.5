Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A07DD26F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbjJaQoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbjJaQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:44:07 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CEFC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698770644; bh=WvhSDyOkZJO+iFaU/ZkUdOpZK5MOPFwO/ix89EUClEg=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=BbNeLhFvbaAssR82hQpknAEujJgyqR+DS5MC/XqtlP2vxS3EQ7xuOruFfOeZP3EgG
         Z230t4Jx6HlPd0S98v8pzvSl82FVZLKh5Ettl2q9ryJvRZl1XTR2vpaOSX5YOIm4JN
         NVQuOpBmLcqpooKS7SqVHCpvMCKxY2rFe9SLyADQzdj/aa1shxHac75vCAeKM
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: Re: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
Author: Mike Isely <isely@isely.net>
Original-cc: Stefan Wahren <wahrenst@gmx.net>, mike.isely@cobaltdigital.com,
  Andi Shyti <andi.shyti@kernel.org>,
  Florian Fainelli <florian.fainelli@broadcom.com>,
  Phil Elwell <phil@raspberrypi.com>,
  Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
  Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
  linux-rpi-kernel@lists.infradead.org,
  linux-arm-kernel@lists.infradead.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  Mike Isely at pobox <isely@pobox.com>
Received: from ts3-dock1.isely.net (ts3-dock1.isely.net [::ffff:192.168.23.13])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 0000000000080779.0000000065412ED4.00001D17; Tue, 31 Oct 2023 11:44:04 -0500
Date:   Tue, 31 Oct 2023 11:44:04 -0500 (CDT)
From:   Mike Isely <isely@isely.net>
Reply-To: Mike Isely at pobox <isely@pobox.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
cc:     Stefan Wahren <wahrenst@gmx.net>, mike.isely@cobaltdigital.com,
        Andi Shyti <andi.shyti@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH 2/2] [i2c-bcm2835] ALWAYS enable INTD
In-Reply-To: <CAPY8ntD1F=Lskoayc9YHKvvh59TcZe7zdfq5H=M5mbNHraGUDQ@mail.gmail.com>
Message-ID: <750b1864-c271-fb64-dcca-e982f818e719@isely.net>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com> <20231030162114.3603829-3-mike.isely@cobaltdigital.com> <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net> <CAPY8ntD1F=Lskoayc9YHKvvh59TcZe7zdfq5H=M5mbNHraGUDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023, Dave Stevenson wrote:

> (Thanks Stefan for forwarding - linux-rpi-kernel seems to be a little
> too aggressive on spam filtering, and I'm not on the other lists
> cc'ed).
> 
> Hi Mike
> 
> On Tue, 31 Oct 2023 at 12:37, Stefan Wahren <wahrenst@gmx.net> wrote:
> >
> > [Forware to Dave and Phil]
> >
> > Am 30.10.23 um 17:21 schrieb mike.isely@cobaltdigital.com:
> > > From: Mike Isely <mike.isely@cobaltdigital.com>
> > >
> > > There is a race in the bcm2835 i2c hardware: When one starts a write
> > > transaction, two things apparently take place at the same time: (1) an
> > > interrupt is posted to cause the FIFO to be filled with TX data,
> > > and (2) an I2C transaction is started on the wire with the slave
> > > select byte.  The race happens if there's no slave, as this causes a
> > > slave selection timeout, raising the ERR flag in the hardware and
> > > setting DONE.  The setting of that DONE flag races against TXW.  If
> > > TXW gets set first, then an interrupt is raised if INTT was set.  If
> > > ERR gets set first, then an interrupt is raised if INTD was set.  It's
> > > one or the other, not both - probably because DONE being set disables
> > > the hardware INTT interrupt path.
> 
> I'm not following the full sequence of events required here.
> If you only had a slave selection message, then num_msgs = 1 and INTD
> will be enabled immediately anyway.

For an I2C read, there typically needs to first be a write, thus always 
two messages.  This is of course the case for any I2C EEPROM read.  If 

the target is not present, then the slave select error happens on the 
first message and since INTD only gets set on the second message in this 
case, then you have the setup for the race (see my other reply).  If the 
slave select "wins" instead of the TX interrupt, it sets DONE along with 
ERR and I'm guessing that in doing so the TX interrupt is masked, 
blocking it.  Without INTD also enabled then the ISR never fires - and 
we hang.

What I have observed empirically is that this "almost" never happens.  
Almost.  For an I2C write in that first message there should always be a 
TX interrupt to start filling the FIFO and the ISR in that case is 
noticing ERR set along the way.  But if the ERR is set before the TX 
interrupt, then we're in trouble.  It's rare but it does happen.

Note also that this is only and issue when accessing a missing target.  
For normal access this can't ever happen.  So the scenario itself is 
also rare - normally you would only cause this by running a bus scan 
(i2cdetect) at the CLI.  In our case the I2C target in question is a 
device in an SFP cage that may or may not be populated, and when not 
populated apparently the Linux kernel sfp module polls it, making this 
rainy day scenario much more likely.


> 
> I did investigate some I2C issues back in May due to observed issues
> between one of the camera modules and the DSI screen touch controller.
> If memory serves correctly, the biggest issue I found was that
> aborting the transaction when active just left SDA & SCL in whatever
> was the current state, including midway through a byte and no stop
> condition. I didn't find a valid way to do a controlled stop, and
> therefore ended up with a patch that will always complete the
> transaction before looking at the status flags [1]. (Yes, I really
> should upstream those patches).

The key here is that we're actually not aborting the transaction, as far 
as the silicon is concerned.  What's happening here is that the silicon 
completed its operation, setting the DONE bit as one might expect, but 
we never get the ISR due to the race in the hardware.  Thus, a timeout 
happens.  Realize this is not a timeout on the I2C bus but a timeout 
between the driver and the I2C controller.  The I2C bus is idle as it 
should be.

Given that the hardware can detect clock stretch problems then there 
really should be no circumstance where the controller silicon can leave 
the bus stuck.


> 
> For a linked thread[2] I think I found that the ERR flag wasn't
> signalled until the end of the complete transaction.

That may be the case but we're talking about 2 transactions, a write and 
a read.  If INTD is only set on the second transaction then we risk a 
missed interrupt.

The hardware doesn't count two messages and two transactions.  The 
driver has to set each one up as a separate transaction.  So your point 
is still correct, but from the POV of the driver it's at the end of the 
*message* not the *transaction*.


> 
> 
> Hang on, if you're always enabling BCM2835_I2C_C_INTD, then if we have
> a write of N bytes and read of M bytes, don't we get a DONE after the
> write, meaning that the ISR completes then due to the clause at [3]
> and we never do the read? Something feels wrong here.

The write and the read are separate transactions as far as the hardware 
is concerned.  DONE means the end of the message not the end of the 
entire transaction.  I think there's a terminology disconnect here:

Hardware: transaction == a single message
Driver: transaction == all messages combined.

Hmm, looking further at the ISR I see it's going to short-circuit the 
entire transaction (driver P.O.V.) if DONE is set.  All I can say about 
that is that with this change, everything *IS* working properly here.  
Full EEPROM access is functioning fine and that requires 2 
messages / transaction in the driver.  If DONE were short-circuiting 
this, then that would break and it isn't.

I can probably instrument things further to determine what is really 
going on with DONE in this case.  There has to be a better explanation.

  -Mike


> 
>   Dave
> 
> [1] https://github.com/raspberrypi/linux/pull/5479/commits
> [2] https://forums.raspberrypi.com/viewtopic.php?p=2098691#p2098691
> [3] https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-bcm2835.c#L293-L306
> 
> > >
> > > MOST of the time, TXW gets set first, the ISR runs, sees ERR is set
> > > and cleanly fails the transaction.  However some of the time DONE gets
> > > set first - but since the driver doesn't enable INTD until it's on the
> > > last message - there's no interrupt at all.  Thus the ISR never fires
> > > and the driver detects a timeout instead.  At best, the "wrong" error
> > > code is delivered to the owner of the transaction.  At worst, if the
> > > timeout doesn't propertly clean up the hardware (see prior commit
> > > fixing that), the next - likely unrelated - transaction will get
> > > fouled, leading to bizarre behavior in logic otherwise unrelated to
> > > the source of the original error.
> > >
> > > The fix here is to set INTD on for all messages not just the last one.
> > > In that way, unexpected failures which might set DONE earlier than
> > > expected will always trigger an interrupt and be handled correctly.
> > >
> > > The datasheet for this hardware doesn't describe any scenario where
> > > the hardware can realistically hang - even a stretched clock will be
> > > noticed if it takes too long.  So in theory a timeout should really
> > > NEVER happen, and with this fix I was completely unable to trigger any
> > > further timeouts at all.
> > >
> > > Signed-off-by: Mike Isely <isely@pobox.com>
> > > ---
> > >   drivers/i2c/busses/i2c-bcm2835.c | 6 +-----
> > >   1 file changed, 1 insertion(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > > index 96de875394e1..70005c037ff9 100644
> > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > > @@ -235,26 +235,22 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
> > >
> > >   static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
> > >   {
> > > -     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> > > +     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD;
> > >       struct i2c_msg *msg = i2c_dev->curr_msg;
> > > -     bool last_msg = (i2c_dev->num_msgs == 1);
> > >
> > >       if (!i2c_dev->num_msgs)
> > >               return;
> > >
> > >       i2c_dev->num_msgs--;
> > >       i2c_dev->msg_buf = msg->buf;
> > >       i2c_dev->msg_buf_remaining = msg->len;
> > >
> > >       if (msg->flags & I2C_M_RD)
> > >               c |= BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
> > >       else
> > >               c |= BCM2835_I2C_C_INTT;
> > >
> > > -     if (last_msg)
> > > -             c |= BCM2835_I2C_C_INTD;
> > > -
> > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
> > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
> > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
> > >   }
> >
> 
