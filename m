Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91C97AACB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjIVId5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:33:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D988F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:33:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30E8A21B4E;
        Fri, 22 Sep 2023 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695371628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0Sb/5Zc4jnMyvOYIuTGynHd4gTUJXJ8TiUqHAqxEkI8=;
        b=gpyeCkYLac/ut4aaXHbvmJ2u3lwCjh0H9A3BVTNlkks+nG6acV+yIaVu27cXlk17zYGZbG
        A90ObM/I2xeaISq481DJC1QasodlXwpgWYcvLYz0FKweq4MDr7YJbvwuw9EF0qGvyik20I
        i5G+reiiXpDZRfYoXUkOVqoa20XEzLM=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CAFDB2C142;
        Fri, 22 Sep 2023 08:33:47 +0000 (UTC)
Date:   Fri, 22 Sep 2023 10:33:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 01/11] printk: Make console_is_usable()
 available to nbcon
Message-ID: <ZQ1RaVue7AAHidg9@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:46, John Ogness wrote:
> Move console_is_usable() as-is into internal.h so that it can
> be used by nbcon printing functions as well.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

The function is relatively complex for being defined as inline
in a header file. IMHO, it is around a sane limit, especially
because it is not used in fast paths. Anyway...

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
