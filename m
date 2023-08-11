Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7B9778BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHKKWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjHKKWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:22:01 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5610EDA;
        Fri, 11 Aug 2023 03:22:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 869B580F1;
        Fri, 11 Aug 2023 10:22:00 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:21:59 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] serial: core: Fix serial core port id, including
 multiport devices
Message-ID: <20230811102159.GM11676@atomide.com>
References: <20230810065737.47294-1-tony@atomide.com>
 <ZNUBHaDTsAXVNNLZ@smile.fi.intel.com>
 <ZNUBvZQcbBbCziXU@smile.fi.intel.com>
 <20230811051121.GL11676@atomide.com>
 <ZNYAxb3eSJ63w7U9@smile.fi.intel.com>
 <ZNYA/JDs4cqC9CJn@smile.fi.intel.com>
 <ZNYBjafHuutSrN4B@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNYBjafHuutSrN4B@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@intel.com> [230811 09:40]:
> Hmm... Looking into the implementation code it seems better to have
> 
> 	/* Use -1 for max to apply IDA defaults */
> 	int min = 0, max = -1;
> 
> And supply like that.

OK let's use that, will send out v2.

Thanks,

Tony
