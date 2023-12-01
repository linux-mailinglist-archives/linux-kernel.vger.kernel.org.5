Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09C4800D4A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbjLAOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbjLAOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:36:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C65F3;
        Fri,  1 Dec 2023 06:36:39 -0800 (PST)
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 59BAF21C98;
        Fri,  1 Dec 2023 14:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701441398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pReC4R8b5GqDVY3afS0evrMQ1O4RS3OjnRhpunQOyuo=;
        b=b9K6IHouq7sqO3BPBSWsaMyBuzrAnMVFKHmtN2I5WlywedInMvXxtoezaTsCqYpvDYMTY1
        Kb00E2kyC+f5H1IesoFNm4g+10HMhGk/GT5tHhqjY/mGBCclCJAeFNwuBxcbeZkVludk1m
        X0pAgPvG/X+bNZe3JQXT2KdzdkbAG0s=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B4F2E2C143;
        Fri,  1 Dec 2023 14:36:35 +0000 (UTC)
Date:   Fri, 1 Dec 2023 15:36:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add support for DEVNAME:0.0 style hardware based
 addressing
Message-ID: <ZWnvc6-LnXdjOQLY@alley>
References: <20231121113203.61341-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121113203.61341-1-tony@atomide.com>
X-Spamd-Bar: +++++++++++++++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [27.10 / 50.00];
         RDNS_NONE(1.00)[];
         BAYES_SPAM(5.10)[100.00%];
         SPAMHAUS_XBL(0.00)[149.44.160.134:from];
         TO_DN_SOME(0.00)[];
         RWL_MAILSPIKE_GOOD(-1.00)[149.44.160.134:from];
         HFILTER_HELO_IP_A(1.00)[relay2.suse.de];
         HFILTER_HELO_NORES_A_OR_MX(0.30)[relay2.suse.de];
         MX_GOOD(-0.01)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RDNS_DNSFAIL(0.00)[];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         VIOLATED_DIRECT_SPF(3.50)[];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[15];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HOSTNAME_UNKNOWN(2.50)[]
X-Spam-Score: 27.10
X-Rspamd-Queue-Id: 59BAF21C98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-11-21 13:31:54, Tony Lindgren wrote:
> Hi all,
> 
> With the recent serial core changes, we can now add DEVNAME:0.0 style
> addressing for the serial ports. When using DEVNAME:0.0 naming, we don't
> need to care which ttyS instance number is allocated depending on HSUART
> settings or if the devicetree has added aliases for all the ports.
> 
> This also allows us to also drop the old console_setup() parsing for
> character device names.
> 
> Tony Lindgren (3):
>   printk: Save console options for add_preferred_console_match()
>   serial: core: Add support for DEVNAME:0.0 style naming for kernel
>     console
>   serial: core: Move console character device handling from printk

First, I appreciate the effort to match aliases to the same console.

Well, my understanding is that it solves the problem only for the newly
added console=DEVICENAME:0.0 format. But it does not handle the
existing problems with matching console names passed via earlycon=
and console= parameters. Am I right?

Now, the bad news. This patchset causes regressions which are
not acceptable. I have found two so far but there might be more.

I used the following kernel command line:

   earlycon=uart8250,io,0x3f8,115200 console=ttyS0,115200 console=tty0 ignore_loglevel log_buf_len=1M


1. The patchset caused that /dev/console became associated with
   ttyS0 instead of tty0, see the "C" flag:

	original # cat /proc/consoles
	tty0                 -WU (EC    )    4:1
	ttyS0                -W- (E  p a)    4:64

   vs.

	patched # cat /proc/consoles
	ttyS0                -W- (EC p a)    4:64
	tty0                 -WU (E     )    4:1

   This is most likely caused by the different ordering of
   __add_preferred_console() calls.

   The ordering is important because it defines which console
   will get associated with /dev/console. It is a so called
   preferred console defined by the last console= parameter.

   Unfortunately also the ordering of the other parameters
   is important when a console defined by the last console=
   parameter is not registered at all. In this case,
   /dev/console gets associated with the first console
   with tty binding according to the order on the command line.

   If you think that it is weird behavior then I agree.
   But it is a historical mess. It is how people used it
   when the various features were added. Many changes
   in this code caused regressions and had to be reverted.

   See the following to get the picture:

       + commit c6c7d83b9c9e6a8 ("Revert "console: don't
	 prefer first registered if DT specifies stdout-path")

       + commit dac8bbbae1d0ccb ("Revert "printk: fix double
	 printing with earlycon"").


2. The serial console gets registered much later with this
   patchset:

	original # dmesg | grep printk:
	[    0.000000] printk: legacy bootconsole [uart8250] enabled
	[    0.000000] printk: debug: ignoring loglevel setting.
	[    0.016859] printk: log_buf_len: 1048576 bytes
	[    0.017324] printk: early log buf free: 259624(99%)
	[    0.141859] printk: legacy console [tty0] enabled
	[    0.142399] printk: legacy bootconsole [uart8250] disabled
	[    0.143032] printk: legacy console [ttyS0] enabled

   vs.

	patched # dmesg | grep printk:
	[    0.000000] printk: legacy bootconsole [uart8250] enabled
	[    0.000000] printk: debug: ignoring loglevel setting.
	[    0.018142] printk: log_buf_len: 1048576 bytes
	[    0.018757] printk: early log buf free: 259624(99%)
	[    0.160706] printk: legacy console [tty0] enabled
	[    0.161213] printk: legacy bootconsole [uart8250] disabled
	[    1.592929] printk: legacy console [ttyS0] enabled

   This is pretty bad because it would complicate or even prevent
   debugging of the boot stage via serial console.

   The graphical console is not usable when the system dies. Also
   finding the right arguments for the earlycon= parameter is
   tricky so that people enable it only when they have to debug
   very early messages.


I am going to look at the patches more closely to see if I could
provide some hints.

Best Regards,
Petr
