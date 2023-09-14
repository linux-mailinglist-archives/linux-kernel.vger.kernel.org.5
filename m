Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60FA7A0590
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjINN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjINN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:29:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B41BEB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:29:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B5B2521845;
        Thu, 14 Sep 2023 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694698153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PprJmMWm7Zpy5eHQl8DCLwo+he03ayOcv9Lbh57Ziuw=;
        b=gIexI2rRF6o0piVDVAa74M1gLvUm54yoFk087GRhMhbjZHG8XqFohbQ5je6qNz7mwNBZj5
        kZsUDOe+0/0ea0ILEnINqWkEly8KsQdnylpD8UrfVbOMWxUmwHeCCum+QqjRPpB1FWhf6w
        j6xbOiHj8gc4IudWWriyGp/C0J2RNhk=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C67C2C142;
        Thu, 14 Sep 2023 13:29:13 +0000 (UTC)
Date:   Thu, 14 Sep 2023 15:29:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v4 3/8] printk: Make static printk buffers
 available to nbcon
Message-ID: <ZQMKqWWcFLVLt3cn@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-09-08 20:56:03, John Ogness wrote:
> The nbcon boot consoles also need printk buffers that are available
> very early. Since the nbcon boot consoles will also be serialized
> by the console_lock, they can use the same static printk buffers
> that the legacy consoles are using.
> 
> Make the legacy static printk buffers available outside of printk.c
> so they can be used by nbcon.c.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
