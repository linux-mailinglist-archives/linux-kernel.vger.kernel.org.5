Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEF1752E20
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjGNAFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGNAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:05:38 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35FC26B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:05:36 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 253FC100E6A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:05:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8A956100814
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 00:05:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689293135; a=rsa-sha256;
        cv=none;
        b=bd2NfzLDfgPaWoLTFL6q3TpTvoLtt3Qc0O2lxLSQVhrhcz6yMYXcWpGusyFrLy0tW5/9VG
        WR9N5z0M5pLvJj+OymCM9i6kZ/Rx+Ufm4eHLyNed5aLM5gh7mOX5hve8P8RIdFBVVysRzO
        mdyXxp0rf1+1mnX9S/L4CipfkfCp0BH0KZ0qt0OSidW0TxbhcITxpzVyle/81mGZdwbkvm
        EUoimlfufxJhk25DgL0Zy9ByrtG/evV8uVYXDNGDCAB4f8dxopNeSXooNWNRHAk+RO9UR4
        Gik4BNxrsr2M6p4ChUsDmO2eFvfxqkYAers5TVCdTuAAbeczyBUa5hSQhTQ9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689293135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=R8IPVAKRYoAh+2qBZdjxKyh15eT0GXaiYypTj4LP2gA=;
        b=FhFuDWOsfVWInyfMJ70oC2kISxRQtJeh1F0PCRDgFtyD5DaSYJcK900DbCZCT5j7hWZ1qZ
        j+fOaNBpnH1FN4mKfp9lT2HlwPVNl1QvtIBd7ctr6ziBHxDFKLO8x2YFxyM58hYQhgkZ7E
        KiVMfDJo1jnRSLuv/Gn6Q95UXLUIA0ntbe7sGdSXZFwtLxpj5gDuVhCYFsQEMAFHbr/Exd
        ipKJ253L3yPy0zAw0sDkSBRQTNh7qEGgz0WPX8yqjhCsTGotDgv9Wp3WSnnIv1n7Fu/w7P
        qeXkBC7XXJgqxZKHw9sErCxzsfa0fTInbTpb135TJY8ntv8asZaQgIjjNF8djA==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-7xcz9;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Turn-Unite: 605f0c241f56d143_1689293135864_1302128198
X-MC-Loop-Signature: 1689293135863:2415851277
X-MC-Ingress-Time: 1689293135863
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.120 (trex/6.9.1);
        Fri, 14 Jul 2023 00:05:35 +0000
Received: from kmjvbox (unknown [71.198.86.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R2BZP5rWJzyw
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 17:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1689293133;
        bh=R8IPVAKRYoAh+2qBZdjxKyh15eT0GXaiYypTj4LP2gA=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=FTUI5mVxk5yIpkR9Cj7ubkeVm6t9XunDqMWwtOmkdKrGFrvtMizro/R5MckVCw58/
         Y1OM3pUQqibVsiXtenaMMqYx0N8ecAB/VPC0qSeFNVx6Ft1G0fzdLk0dekeKap8az5
         t76G2oXgDgB4NQIdME84lhMZcWbkP6mHzqJLTAXg=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00cb
        by kmjvbox (DragonFly Mail Agent v0.12);
        Thu, 13 Jul 2023 17:05:30 -0700
Date:   Thu, 13 Jul 2023 17:05:30 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Shay Agroskin <shayagr@amazon.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Message-ID: <20230714000530.GA1982@templeofstupid.com>
References: <20230711013621.GE1926@templeofstupid.com>
 <pj41zllefmpbw7.fsf@u95c7fd9b18a35b.ant.amazon.com>
 <20230711225210.GA2088@templeofstupid.com>
 <pj41zlilao9rqt.fsf@u95c7fd9b18a35b.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pj41zlilao9rqt.fsf@u95c7fd9b18a35b.ant.amazon.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:46:55AM +0300, Shay Agroskin wrote:
> 
> Krister Johansen <kjlx@templeofstupid.com> writes:
> 
> > 
> > On Tue, Jul 11, 2023 at 08:47:32PM +0300, Shay Agroskin wrote:
> > > 
> > > Krister Johansen <kjlx@templeofstupid.com> writes:
> > > 
> > > > diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c
> > > > b/drivers/net/ethernet/amazon/ena/ena_com.c
> > > > index 451c3a1b6255..633b321d7fdd 100644
> > > > --- a/drivers/net/ethernet/amazon/ena/ena_com.c
> > > > +++ b/drivers/net/ethernet/amazon/ena/ena_com.c
> > > > @@ -35,6 +35,8 @@
> > > >  #define ENA_REGS_ADMIN_INTR_MASK 1
> > > > +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> > > > +
> > > >  #define ENA_MIN_ADMIN_POLL_US 100
> > > >  #define ENA_MAX_ADMIN_POLL_US 5000
> > > > @@ -536,6 +538,7 @@ static int >
> > > ena_com_comp_status_to_errno(struct
> > > > ena_com_admin_queue *admin_queue,
> > > >    static void ena_delay_exponential_backoff_us(u32 exp, u32 >
> > > delay_us)
> > > >  {
> > > > +   exp = min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);
> > > >     delay_us = max_t(u32, ENA_MIN_ADMIN_POLL_US, delay_us);
> > > >     delay_us = min_t(u32, delay_us * (1U << exp), >
> > > ENA_MAX_ADMIN_POLL_US);
> > > >     usleep_range(delay_us, 2 * delay_us);
> > > 
> > > Hi, thanks for submitting this patch (:
> > 
> > Absolutely; thanks for the review!
> > 
> > > Going over the logic here, the driver sleeps for `delay_us`
> > > micro-seconds in
> > > each iteration that this function gets called.
> > > 
> > > For an exp = 14 it'd sleep (I added units notation)
> > > delay_us * (2 ^ exp) us = 100 * (2 ^ 14) us = (10 * (2 ^ 14)) /
> > > (1000000) s
> > > = 1.6 s
> > > 
> > > For an exp = 15 it'd sleep
> > > (10 * (2 ^ 15)) / (1000000) = 3.2s
> > > 
> > > To even get close to an overflow value, say exp=29 the driver would
> > > sleep in
> > > a single iteration
> > > 53687 s = 14.9 hours.
> > > 
> > > The driver should stop trying to get a response from the device
> > > after a
> > > timeout period received from the device which is 3 seconds by
> > > default.
> > > 
> > > The point being, it seems very unlikely to hit this overflow. Did
> > > you
> > > experience it or was the issue discovered by a static analyzer ?
> > 
> > No, no use of fuzzing or static analysis.  This was hit on a production
> > instance that was having ENA trouble.
> > 
> > I'm apparently reading the code differently.  I thought this line:
> > 
> > > >     delay_us = min_t(u32, delay_us * (1U << exp), >
> > > ENA_MAX_ADMIN_POLL_US);
> > 
> > Was going to cap that delay_us at (delay_us * (1U << exp)) or
> > 5000us, whichever is smaller.  By that measure, if delay_us is 100 and
> > ENA_MAX_ADMIN_POLL_US is 5000, this should start getting capped after
> > exp = 6, correct?  By my estimate, that puts it at between 160ms and
> > 320ms of sleeping before one could hit this problem.
> > 
> > I went and pulled the logs out of the archive and have the following
> > timeline.  This is seconds from boot as reported by dmesg:
> > 
> >    11244.226583 - ena warns TX not completed on time, 10112000    usecs
> > since
> >     last napi execution, missing tx timeout val of 5000 msec
> > 
> >    11245.190453 - netdev watchdog fires
> > 
> >    11245.190781 - ena records Transmit timeout
> >    11245.250739 - ena records Trigger reset on
> > 
> >    11246.812620 - UBSAN message to console
> > 
> >    11248.590441 - ena reports Reset inidication didn't turn off
> >    11250.633545 - ena reports failure to reset device
> >    12013.529338 - last logline before new boot
> > 
> > While the difference between the panic and the trigger reset is more
> > than 320ms, it is definitely on the order of seconds instead of hours.
> > 
> 
> Yup you're right. I was so entangled in my exponent calculations that I
> completely missed the min_t expression there.
> 
> That's quite an awkward design to be honest, I hope to submit a re-write for
> it in one of the releases.
> 
> Thanks again for the work you've put into it

Totally welcome. I appreciate the speedy reviews from you and Leon.

Thanks again,

-K
