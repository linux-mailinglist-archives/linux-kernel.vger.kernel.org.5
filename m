Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4C7F3E12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVGWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:22:16 -0500
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65F3BB;
        Tue, 21 Nov 2023 22:22:12 -0800 (PST)
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
        by mail5.25mail.st (Postfix) with ESMTPSA id 530B060852;
        Wed, 22 Nov 2023 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
        s=25mailst; t=1700634132;
        bh=IzPNJc1JTuqWO45Rxq17COGNEUpGUDxnGho6xDUJ+xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iluFk+PPWWXytS2xsj6IFeEAF0d3poODgAFNhyUdnh5cBXFUZJeQs6F98rCPaKd/t
         1DZc8N13h9WuIsLgza/COJTwTaAOqT5Z/6kc1+vqy9mQylJs2W78sfWfVMwMUVXgrU
         x7oQvxK5zbGZaVNIHDZ2jMBNZqPelr0JzaLq+4YA3JrQLUgqQ/70hMnA0M2VjpB9X2
         qAVNwBgxYH8Y7qMNG1IEblbe84+mDPprjjeZzDb3soZr1invzcyaSV2sXnKfBUbNBo
         fQ6Sbc12ghN2wzpd+jrozrvxdrDoaTV/kuBoZzprC5hKoMKAPPrMbarZe4dTZTtuxr
         LnBaY/S83yLOw==
Date:   Wed, 22 Nov 2023 08:21:38 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 1/3] printk: Save console options for
 add_preferred_console_match()
Message-ID: <20231122062138.GD5169@atomide.com>
References: <20231121113203.61341-1-tony@atomide.com>
 <20231121113203.61341-2-tony@atomide.com>
 <ZVzuih3Aw3hdfj2s@smile.fi.intel.com>
 <20231122061800.GC5169@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122061800.GC5169@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [231122 08:18]:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [231121 17:53]:
> > On Tue, Nov 21, 2023 at 01:31:55PM +0200, Tony Lindgren wrote:
> > > +int __init console_opt_save(char *str)
> > 
> > str is not const? Hmm...
> 
> Nice yes it can be const char *str here. Hmm maybe with the third patch
> also console_setup() can use const char * now.. Will check.

Nah console_setup() uses __setup().

Tony
