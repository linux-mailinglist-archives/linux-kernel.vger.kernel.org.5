Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B967713BE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 08:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjHFGXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 02:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFGXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 02:23:33 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63CC81FD3;
        Sat,  5 Aug 2023 23:23:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CBCDA80A0;
        Sun,  6 Aug 2023 06:23:31 +0000 (UTC)
Date:   Sun, 6 Aug 2023 09:23:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 1/1] serial: core: Fix serial_base_match() after
 fixing controller port name
Message-ID: <20230806062330.GM14799@atomide.com>
References: <20230803071034.25571-1-tony@atomide.com>
 <0e1bc27d-dc84-473d-bfdf-db0743c5d64a@roeck-us.net>
 <20230805044910.GJ14799@atomide.com>
 <a6973497-f45f-6456-ac2b-d3c0262d892b@roeck-us.net>
 <20230805114846.GK14799@atomide.com>
 <aeca6f69-49df-898c-e70b-afcc5427a29b@roeck-us.net>
 <095e0120-ba81-64e7-e5d0-c042fb64978f@roeck-us.net>
 <20230806043357.GL14799@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806043357.GL14799@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230806 07:34]:
> To me it seems we can't use port->port_id until multiport drivers
> initialize it, or set port->port_id automatically with ida_alloc().
> 
> Meanwhile, we can just change back to using port->line assuming that
> fixes the issue for your tests. This means the port names are broken
> like we had in -rc1 but that's a cosmetic issue for now.

Sent it with a proper patch description [0].

Regards,

Tony

[0] https://lore.kernel.org/linux-serial/20230806062052.47737-1-tony@atomide.com/T/#u
