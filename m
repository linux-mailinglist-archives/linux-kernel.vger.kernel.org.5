Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B348A7A1896
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjIOIYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjIOIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:24:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2C4C1C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:21:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D946B2185F;
        Fri, 15 Sep 2023 08:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694766064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZgXzmDwcApmJoueBiYmEnyctIBcVAVpj2XK2plbBnQ=;
        b=DAbxsENxRHr+HWKe7Pilg8t1GN0UxWpgjfmYB28cU0aPXfx+5A2PQP3u/jJ7wM9o1zlRiz
        IN6IzmX7PtIwQUk1u4kVS0Z+l/wusDfoo9/EVzauIKFEFT8zdPQqAx+yUmeS6/nQVcKooE
        nRrTSvDiYQXNhADiQ+YLBHe0G/kV8oE=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F71C2C142;
        Fri, 15 Sep 2023 08:21:04 +0000 (UTC)
Date:   Fri, 15 Sep 2023 10:21:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 7/8] printk: nbcon: Add emit function and
 callback function for atomic printing
Message-ID: <ZQQT8B2LGJWY2gm5@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:07, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Implement an emit function for nbcon consoles to output printk
> messages. It utilizes the lockless printk_get_next_message() and
> console_prepend_dropped() functions to retrieve/build the output
> message. The emit function includes the required safety points to
> check for handover/takeover and calls a new write_atomic callback
> of the console driver to output the message. It also includes
> proper handling for updating the nbcon console sequence number.
> 
> A new nbcon_write_context struct is introduced. This is provided
> to the write_atomic callback and includes only the information
> necessary for performing atomic writes.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
