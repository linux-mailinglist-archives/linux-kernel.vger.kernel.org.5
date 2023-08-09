Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A677620C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjHIOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjHIOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:06:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BEE1FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:06:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B2ECC1F38A;
        Wed,  9 Aug 2023 14:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691589988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CnA7zIGciiEg2PfazTZcIUvttJiVFHYu6GLsaiP/Bjg=;
        b=ClIz3Wn/KbcOjWChRfxNDarSibmEejZ8/KDOAvXwAgsZYoJ72bVyRt0Tex7/G2aJ71gs9H
        vwyIeTvZ/2ssuxp/vzm/pIGMEnyb0hJ2LFBAUjDEeBtPzFfn0NlfnnSk1d+6T3b0jHC7Lx
        9K5dM/v5KoH8p5rUo6yXDmXSDOGExX8=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D73A2C142;
        Wed,  9 Aug 2023 14:06:28 +0000 (UTC)
Date:   Wed, 9 Aug 2023 16:06:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 4/8] printk: nbcon: Add buffer management
Message-ID: <ZNOdYoCyFmf8UEL0@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:29, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In case of hostile takeovers it must be ensured that the previous
> owner cannot scribble over the output buffer of the emergency/panic
> context. This is achieved by:
> 
>  - Adding a global output buffer instance for the panic context.
>    This is the only situation where hostile takeovers can occur and
>    there is always at most 1 panic context.
> 
>  - Allocating an output buffer per console upon console
>    registration. This buffer is used by the console owner when not
>    in panic context.
> 
>  - Choosing the appropriate buffer is handled in the acquire/release
>    functions.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
