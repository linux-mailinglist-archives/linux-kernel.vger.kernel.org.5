Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49247979F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbjIGR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbjIGRZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:25:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D28310FC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:25:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F25FC1F88F;
        Thu,  7 Sep 2023 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694075050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GH4PiUZYcvijfYYj1OSceP+YGw5s1jrw2RWCXM46kUA=;
        b=anr901eNGXzG3dapWm0njxehNGzt2qS/khCP9ao5rH/KcTVTENhTtEDIpxduW/sJsMtuld
        BEXobyoe8v0TobknYUDffDf3npHhNtaj8EF176sNwqf6cqIjw6AJgZiIQ2EY9ktVVxIF2D
        iaqYP9IYns3PJKgWr4JsZHvRO43pBhg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C78402C142;
        Thu,  7 Sep 2023 08:24:09 +0000 (UTC)
Date:   Thu, 7 Sep 2023 10:24:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 7/7] printk: nbcon: Add functions for drivers
 to mark unsafe regions
Message-ID: <ZPmIqa_WHzJV73S2@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:39, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> For the write_atomic callback, the console driver may have unsafe
> regions that need to be appropriately marked. Provide functions
> that accept the nbcon_write_context struct to allow for the driver
> to enter and exit unsafe regions.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
