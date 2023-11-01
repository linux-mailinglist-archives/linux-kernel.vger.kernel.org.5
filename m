Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEF67DE74F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjKAVMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345140AbjKAVMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:12:20 -0400
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C6110
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1698873133; bh=LGvdfFN+4CI0ILsYYBUqVyLSwsn985/pmVLgko+fWgg=;
        h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
        b=CJ/o74tY7gVNPdAk9QyAn1daeydqENIFhNocIJQz5iTwKuzTxsmL7yCdpOcU6XJLN
         Anx5W6oTcySh61ZLX0wbuOEl3ww8jqkNjtybeGBlNfOStC8wtUabgZ3IhKGuk+2Sgg
         hNreVvd9mLJZl3+Qsyt267GuxjbazL90sW7ar3eKARWCewMofWk93mskjiSVq
Original-Reply-To: Mike Isely at pobox <isely@pobox.com>
Original-Subject: aborting i2c bcm2835 controller [was: [PATCH 2/2] [i2c-bcm2835]
 ALWAYS enable INTD]
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
  id 0000000000080569.000000006542BF2D.00005394; Wed, 01 Nov 2023 16:12:13 -0500
Date:   Wed, 1 Nov 2023 16:12:13 -0500 (CDT)
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
Subject: aborting i2c bcm2835 controller [was: [PATCH 2/2] [i2c-bcm2835]
 ALWAYS enable INTD]
In-Reply-To: <ba291591-a733-78a6-f315-20e1c17e8677@isely.net>
Message-ID: <2c8c3030-ede6-5283-a0a9-703df43245ac@isely.net>
References: <20231030162114.3603829-1-mike.isely@cobaltdigital.com> <20231030162114.3603829-3-mike.isely@cobaltdigital.com> <db49b19c-5bd3-4d4c-8e58-e81c19868458@gmx.net> <CAPY8ntD1F=Lskoayc9YHKvvh59TcZe7zdfq5H=M5mbNHraGUDQ@mail.gmail.com>
 <750b1864-c271-fb64-dcca-e982f818e719@isely.net> <CAPY8ntCHde9hXdvsGCNrmHxEmBME_=yYWquq0HVNoo6EDJL6hQ@mail.gmail.com> <ba291591-a733-78a6-f315-20e1c17e8677@isely.net>
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

On Wed, 1 Nov 2023, Mike Isely wrote:

  [...]


> > > Given that the hardware can detect clock stretch problems then there
> > > really should be no circumstance where the controller silicon can leave
> > > the bus stuck.
> > 
> > I can't find my debug notes from May, but it was aborting part way
> > through a multi-byte read from the touchscreen without a STOP
> > condition, leaving the touch controller still thinking it was still
> > clocking out the current byte, so it messed up the next transaction.
> > Hitting BCM2835_I2C_C with BCM2835_I2C_C_CLEAR whilst BCM2835_I2C_S_TA
> > is set will abort immediately with no STOP :-(
> 
> That's probably because the DLEN register still has a non-zero value and 
> now the hardware is waiting for you to push more bytes into the FIFO 
> (since you just cleared out what was already there).  Thus it won't 
> release the bus until it has processed all expected bytes.  Setting DLEN 
> to zero first then clearing the FIFO might be the way to fix that.

I just re-read the datasheet and it does indeed state that clearing the 
FIFO would abort the transaction.  But are you doing the clearing by 
just writing a word to the control register with CLEAR set or were you 
ensuring to preserve the state of I2CEN as well?  Because if you were 
also unintentionally writing a zero to I2CEN as well I can see that 
freezing the RTL's state machine and thus jamming the bus.  To actually 
do the abort still requires a few state transitions in order release the 
bus - and if the controller has been disabled then a jam would not be 
unexpected.  In all other cases in the driver, you're only writing to 
the control register after the hardware has idled, so disabling the 
controller in this way would be working ok.

I wonder if hitting CLEAR while also keeping I2CEN set and INTD on would 
then allow the hardware to sequence itself to release the bus then issue 
a DONE back to the driver once everything is idle.

  [...]

  -Mike

