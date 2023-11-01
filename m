Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED637DE660
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344949AbjKAT06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKAT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 15:26:57 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F0C10C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698866810; bh=YXFkgtkD+JSkVxV41gLhEvGPbnA99SH055m9qZIze48=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=BZ5VEAmbCd5kTagAqw17ZW67emMdP2BfzCDEaCKieeNOGJ0seG0FOsTR4OHLz6iYI
         q9NXRLcr+3VSmXFAgyIbBMS0eklD6SXNRJ+zJbjKu6sP8h/bCmnXf6+KWq3UJbGSJ9
         mEhojQbaHA2vGlJn7ln93UUEFHhRvwki1LjhjhLSzq1LnjkK6Be3GWqlCzoFg
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
  id 00000000000809BD.000000006542A67A.000048E1; Wed, 01 Nov 2023 14:26:50 -0500
Date:   Wed, 1 Nov 2023 14:26:49 -0500 (CDT)
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
In-Reply-To: <CAPY8ntCHde9hXdvsGCNrmHxEmBME_=yYWquq0HVNoo6EDJL6hQ@mail.gmail.com>
Message-ID: <ba291591-a733-78a6-f315-20e1c17e8677@isely.net>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com> <20231030162114.3603829-3-mike.isely@cobaltdigital.com> <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net> <CAPY8ntD1F=Lskoayc9YHKvvh59TcZe7zdfq5H=M5mbNHraGUDQ@mail.gmail.com>
 <750b1864-c271-fb64-dcca-e982f818e719@isely.net> <CAPY8ntCHde9hXdvsGCNrmHxEmBME_=yYWquq0HVNoo6EDJL6hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Comments interspersed...

  -Mike Isely
   isely@pobox.com

On Tue, 31 Oct 2023, Dave Stevenson wrote:

> Hi Mike
> 
> On Tue, 31 Oct 2023 at 16:44, Mike Isely <isely@isely.net> wrote:
> >
> > On Tue, 31 Oct 2023, Dave Stevenson wrote:
> >
> > > (Thanks Stefan for forwarding - linux-rpi-kernel seems to be a little
> > > too aggressive on spam filtering, and I'm not on the other lists
> > > cc'ed).
> > >
> > > Hi Mike
> > >
> > > On Tue, 31 Oct 2023 at 12:37, Stefan Wahren <wahrenst@gmx.net> wrote:
> > > >
> > > > [Forware to Dave and Phil]
> > > >
> > > > Am 30.10.23 um 17:21 schrieb mike.isely@cobaltdigital.com:
> > > > > From: Mike Isely <mike.isely@cobaltdigital.com>
> > > > >
> > > > > There is a race in the bcm2835 i2c hardware: When one starts a write
> > > > > transaction, two things apparently take place at the same time: (1) an
> > > > > interrupt is posted to cause the FIFO to be filled with TX data,
> > > > > and (2) an I2C transaction is started on the wire with the slave
> > > > > select byte.  The race happens if there's no slave, as this causes a
> > > > > slave selection timeout, raising the ERR flag in the hardware and
> > > > > setting DONE.  The setting of that DONE flag races against TXW.  If
> > > > > TXW gets set first, then an interrupt is raised if INTT was set.  If
> > > > > ERR gets set first, then an interrupt is raised if INTD was set.  It's
> > > > > one or the other, not both - probably because DONE being set disables
> > > > > the hardware INTT interrupt path.
> > >
> > > I'm not following the full sequence of events required here.
> > > If you only had a slave selection message, then num_msgs = 1 and INTD
> > > will be enabled immediately anyway.
> >
> > For an I2C read, there typically needs to first be a write, thus always
> > two messages.  This is of course the case for any I2C EEPROM read.  If
> 
> Terminology.
> Your mention of "slave select byte" is referencing writing an address
> to the EEPROM, not sending the I2C address which is also slave
> selection and one byte long.

Actually I am refering to the I2C slave address, not the first byte of 
the transfer after that byte.  Of course everything after the I2C slave 
address is specific to the target in question and therefore the I2C 
controller hardware can't know what it really means.

The ERR flag I have been referencing is coming from the I2C controller 
hardware, in response to a slave selection that fails - because the 
device in question isn't there, which is normal for us when the 
corresponding SFP cage has nothing inserted into it.


> You get a NAK on sending that EEPROM address selection byte due to the
> device not being present, not a specific error from the controller
> that is a "slave select timeout".

No, I am talking about the actual I2C slave address put on the bus as 
the very first byte of the message, as part of the required I2C wire 
protocol.  If the device is not present, then THAT gets nak'ed (i.e. 
data is not pulled down by the target on the 9th bit after the I2C slave 
address is clocked out), and the I2C controller hardware detects this 
and asserts ERR.


> 
> This is where my confusion comes from. Please use the I2C terminology.

I've been messing with I2C dark corners on & off for about 20 years.  I 
apologize if my use of the terminology might be confusing things, but I 
*AM* talking about the actual I2C slave address, not the first byte 
written after the device has been selected.


> 
> > the target is not present, then the slave select error happens on the
> > first message and since INTD only gets set on the second message in this
> > case, then you have the setup for the race (see my other reply).  If the
> > slave select "wins" instead of the TX interrupt, it sets DONE along with
> > ERR and I'm guessing that in doing so the TX interrupt is masked,
> > blocking it.  Without INTD also enabled then the ISR never fires - and
> > we hang.
> >
> > What I have observed empirically is that this "almost" never happens.
> > Almost.  For an I2C write in that first message there should always be a
> > TX interrupt to start filling the FIFO and the ISR in that case is
> > noticing ERR set along the way.  But if the ERR is set before the TX
> > interrupt, then we're in trouble.  It's rare but it does happen.
> >
> > Note also that this is only and issue when accessing a missing target.
> > For normal access this can't ever happen.  So the scenario itself is
> > also rare - normally you would only cause this by running a bus scan
> > (i2cdetect) at the CLI.  In our case the I2C target in question is a
> > device in an SFP cage that may or may not be populated, and when not
> > populated apparently the Linux kernel sfp module polls it, making this
> > rainy day scenario much more likely.
> 
> OK, at least we now know your scenario and can try to replicate.
> 
> I've never seen ERR set before the end of the I2C transaction. Are you
> sure this is definitely triggered by your main transaction, and isn't
> left around from a previous one as you've alluded to?
> Potentially it is this patch that allows ERR to be signalled earlier
> as the DONE interrupt is unmasked.

Yes, I'm absolutely positive that this is happening.

Your earlier comment about DONE usage has raised a good point though.  
The I2C controller works on a message-by-message basis, not the entire 
transaction.  So DONE should be asserted after every message, but the 
ISR will short-circuit the rest of the (multiple message) transaction 
once it sees that DONE is asserted.  I can't square that yet with what 
I've empirically observed here so I'm going to dig deeper.  Maybe 
there's another race here which has allowed things to work?

But yes I'm positive about this - the timeout is happening because the 
ISR never fires when it should have, and it was after an I2C slave 
select error which asserted ERR in the controller hardware - and since 
INTD wasn't enabled, it prevented an interrupt from being raised which 
caused the timeout.


> 
> > > I did investigate some I2C issues back in May due to observed issues
> > > between one of the camera modules and the DSI screen touch controller.
> > > If memory serves correctly, the biggest issue I found was that
> > > aborting the transaction when active just left SDA & SCL in whatever
> > > was the current state, including midway through a byte and no stop
> > > condition. I didn't find a valid way to do a controlled stop, and
> > > therefore ended up with a patch that will always complete the
> > > transaction before looking at the status flags [1]. (Yes, I really
> > > should upstream those patches).
> >
> > The key here is that we're actually not aborting the transaction, as far
> > as the silicon is concerned.  What's happening here is that the silicon
> > completed its operation, setting the DONE bit as one might expect, but
> > we never get the ISR due to the race in the hardware.  Thus, a timeout
> > happens.  Realize this is not a timeout on the I2C bus but a timeout
> > between the driver and the I2C controller.  The I2C bus is idle as it
> > should be.
> >
> > Given that the hardware can detect clock stretch problems then there
> > really should be no circumstance where the controller silicon can leave
> > the bus stuck.
> 
> I can't find my debug notes from May, but it was aborting part way
> through a multi-byte read from the touchscreen without a STOP
> condition, leaving the touch controller still thinking it was still
> clocking out the current byte, so it messed up the next transaction.
> Hitting BCM2835_I2C_C with BCM2835_I2C_C_CLEAR whilst BCM2835_I2C_S_TA
> is set will abort immediately with no STOP :-(

That's probably because the DLEN register still has a non-zero value and 
now the hardware is waiting for you to push more bytes into the FIFO 
(since you just cleared out what was already there).  Thus it won't 
release the bus until it has processed all expected bytes.  Setting DLEN 
to zero first then clearing the FIFO might be the way to fix that.


> 
> >
> > >
> > > For a linked thread[2] I think I found that the ERR flag wasn't
> > > signalled until the end of the complete transaction.
> >
> > That may be the case but we're talking about 2 transactions, a write and
> > a read.  If INTD is only set on the second transaction then we risk a
> > missed interrupt.
> >
> > The hardware doesn't count two messages and two transactions.  The
> > driver has to set each one up as a separate transaction.  So your point
> > is still correct, but from the POV of the driver it's at the end of the
> > *message* not the *transaction*.
> >
> >
> > >
> > >
> > > Hang on, if you're always enabling BCM2835_I2C_C_INTD, then if we have
> > > a write of N bytes and read of M bytes, don't we get a DONE after the
> > > write, meaning that the ISR completes then due to the clause at [3]
> > > and we never do the read? Something feels wrong here.
> >
> > The write and the read are separate transactions as far as the hardware
> > is concerned.
> 
> Yes and no. You keep the hardware busy so that you get a repeated
> start, rather than a stop and new start for two totally independent
> I2C operations.

Yes that is true.  But whether one releases the bus and issues a new 
start vs using a repeated start generally won't matter UNLESS your 
topology has multiple I2C bus masters - which these days is extremely 
rare and I notice that this controller explicitly doesn't support that 
anyway.  I2C slave devices generally won't care about this detail since 
it's really a thing for bus arbitration.  A repeated start while not 
freeing the bus first is the way to keep another I2C controller from 
jumping into the middle and messing things up.


> 
> >  DONE means the end of the message not the end of the
> > entire transaction.  I think there's a terminology disconnect here:
> 
> DONE is meant to signal the end of a transfer, but does this restart
> stop it sending the DONE? I really don't know, and don't immediately
> have the time to investigate.

That is part of what I'd like to dig further into, which I will do 
shortly.

But the important thing to keep in mind here is that the controller only 
knows about individual I2C messages not entire transfers.  The 
start_transfer() call in the driver works on a message-by-message basis 
and isn't providing anything to the hardware to even hint if there's 
another message to follow the current one.  The ISR calls 
start_transfer() again to begin the "next" message.  Therefore DONE has 
to be asserted after every message and that's the part that is causing 
me to scratch my head over this now.


> 
> > Hardware: transaction == a single message
> > Driver: transaction == all messages combined.
> >
> > Hmm, looking further at the ISR I see it's going to short-circuit the
> > entire transaction (driver P.O.V.) if DONE is set.  All I can say about
> > that is that with this change, everything *IS* working properly here.
> > Full EEPROM access is functioning fine and that requires 2
> > messages / transaction in the driver.  If DONE were short-circuiting
> > this, then that would break and it isn't.
> 
> This is my concern, and it'll need a lot of testing to confirm
> behaviour. (I doubt we can get Broadcom folks to dig into the RTL to
> confirm what the hardware actually does as the controller is obsolete
> and the designers have all left many years back).

We can figure it out empirically.  The datasheet that is available for 
this logic provides enough to go on.  I'm pretty sure I can suss this 
out.

Sadly while the controller may be obsolete, it is used on Raspberry PI4 
which uses a bcm2711 which is apparently using this same RTL.  We're 
using a CM4 here; this is why the whole thing caught my attention.


> 
> What happens with multiple writes in one master_xfer call? Or a single
> write or read?

Multiple writes are just multiple messages that are each an I2C write.  
Since the I2C controller hardware is only aware of each message at a 
time, then it should be blissfully ignorant of such variations.


> EEPROM access is one small subset of I2C access patterns, so it needs
> validating in the other potential ones.

I should add here that while I've been focusing upon EEPROM access here, 
that bus talks to other stuff as well, which (apparently) continues to 
work fine.  My focus on EEPROM access is just because that's where I've 
seen problems.


> 
> 
> When Phil investigated part of [1] to abort on ERR at the end of an
> i2c_msg (not complete master_xfer call), he had also observed that
> enabling INTD did work. However he caveated it with needing to prefill
> the FIFO and handle DONE appropriate in the ISR as it no longer means
> all complete. You've done the first of those three, so I'm wanting his
> view on this.

My gut feeling is that the ISR probably should look for the DONE state
only after the other checks, avoiding the short circuit.


> 
>   Dave
> 
> [1] https://github.com/raspberrypi/linux/issues/5429#issuecomment-1508364342
> 
> > I can probably instrument things further to determine what is really
> > going on with DONE in this case.  There has to be a better explanation.
> >
> >   -Mike
> >
> >
> > >
> > >   Dave
> > >
> > > [1] https://github.com/raspberrypi/linux/pull/5479/commits
> > > [2] https://forums.raspberrypi.com/viewtopic.php?p=2098691#p2098691
> > > [3] https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-bcm2835.c#L293-L306
> > >
> > > > >
> > > > > MOST of the time, TXW gets set first, the ISR runs, sees ERR is set
> > > > > and cleanly fails the transaction.  However some of the time DONE gets
> > > > > set first - but since the driver doesn't enable INTD until it's on the
> > > > > last message - there's no interrupt at all.  Thus the ISR never fires
> > > > > and the driver detects a timeout instead.  At best, the "wrong" error
> > > > > code is delivered to the owner of the transaction.  At worst, if the
> > > > > timeout doesn't propertly clean up the hardware (see prior commit
> > > > > fixing that), the next - likely unrelated - transaction will get
> > > > > fouled, leading to bizarre behavior in logic otherwise unrelated to
> > > > > the source of the original error.
> > > > >
> > > > > The fix here is to set INTD on for all messages not just the last one.
> > > > > In that way, unexpected failures which might set DONE earlier than
> > > > > expected will always trigger an interrupt and be handled correctly.
> > > > >
> > > > > The datasheet for this hardware doesn't describe any scenario where
> > > > > the hardware can realistically hang - even a stretched clock will be
> > > > > noticed if it takes too long.  So in theory a timeout should really
> > > > > NEVER happen, and with this fix I was completely unable to trigger any
> > > > > further timeouts at all.
> > > > >
> > > > > Signed-off-by: Mike Isely <isely@pobox.com>
> > > > > ---
> > > > >   drivers/i2c/busses/i2c-bcm2835.c | 6 +-----
> > > > >   1 file changed, 1 insertion(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> > > > > index 96de875394e1..70005c037ff9 100644
> > > > > --- a/drivers/i2c/busses/i2c-bcm2835.c
> > > > > +++ b/drivers/i2c/busses/i2c-bcm2835.c
> > > > > @@ -235,26 +235,22 @@ static void bcm2835_drain_rxfifo(struct bcm2835_i2c_dev *i2c_dev)
> > > > >
> > > > >   static void bcm2835_i2c_start_transfer(struct bcm2835_i2c_dev *i2c_dev)
> > > > >   {
> > > > > -     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN;
> > > > > +     u32 c = BCM2835_I2C_C_ST | BCM2835_I2C_C_I2CEN | BCM2835_I2C_C_INTD;
> > > > >       struct i2c_msg *msg = i2c_dev->curr_msg;
> > > > > -     bool last_msg = (i2c_dev->num_msgs == 1);
> > > > >
> > > > >       if (!i2c_dev->num_msgs)
> > > > >               return;
> > > > >
> > > > >       i2c_dev->num_msgs--;
> > > > >       i2c_dev->msg_buf = msg->buf;
> > > > >       i2c_dev->msg_buf_remaining = msg->len;
> > > > >
> > > > >       if (msg->flags & I2C_M_RD)
> > > > >               c |= BCM2835_I2C_C_READ | BCM2835_I2C_C_INTR;
> > > > >       else
> > > > >               c |= BCM2835_I2C_C_INTT;
> > > > >
> > > > > -     if (last_msg)
> > > > > -             c |= BCM2835_I2C_C_INTD;
> > > > > -
> > > > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_A, msg->addr);
> > > > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DLEN, msg->len);
> > > > >       bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, c);
> > > > >   }
> > > >
> > >
> 
