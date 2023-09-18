Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330137A4EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjIRQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIRQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:25:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806CC25225
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:22:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CAFD521CD9;
        Mon, 18 Sep 2023 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695045394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOvkujhGcSMzt+lz8cL+HpQx31oe1nwxsAcNOKn7Yww=;
        b=cBIwNZ7o4uq1nMkujG6pQubbrljBZAhHJcKN+6xvSlIx/DH2+NEry1kv17mIy3YrBVGo48
        5ZzXX2qjBNj1NzPQiNJZ9T0NmiyATfLaqQATf4QxQmXcX5jKecXtQzmA8sjSLp1TwY8K8t
        6G/OEqvG1S/RdfGhHr3ohXsVt2tx/AU=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6C8992C142;
        Mon, 18 Sep 2023 13:56:34 +0000 (UTC)
Date:   Mon, 18 Sep 2023 15:56:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v5 2/8] printk: nbcon: Add acquire/release logic
Message-ID: <ZQhXEgGueDmFmaK6@alley>
References: <20230916192007.608398-1-john.ogness@linutronix.de>
 <20230916192007.608398-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916192007.608398-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-09-16 21:26:01, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality.
> 
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
