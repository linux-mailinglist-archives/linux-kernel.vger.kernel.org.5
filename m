Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EE3767751
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjG1VBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjG1VBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:01:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D47335B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:01:12 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690578070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UceUlWS7Yzd9COUx2am7MAGc24C7rk/CQ0rNrL2ZS4U=;
        b=VYTDy1qw6LTcnHTOFSj0KUQqP4ZblI0+Z9OPZPmgxnDZAhKdORaauqGPAWLEsZ0ilQLamg
        UsuZ2LvbwZ+7WLNtpNHQok5yOfpQ3P2x5eVU+rXgw2HBcDH6+oqMfNk41f/yiXmPuW0whM
        xgV2B3NIiyj5s7L6id7zLMc9JQBMWffyWcmkggwpng7qKRDDvwviE0M2b7vSDU9TG+KzoO
        kPDYIybl/K+fBUZmoJ0+2OESM1ePB1tfs5ytaih+PuV1TJjq5DU51SDDPYigZ80cbQj+6T
        8HiEnRmaPYGgerHGy4kHKHlzBTvtLjIDSrVmG3y1zDcC6LCx/6nyZiPCzKnJzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690578070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UceUlWS7Yzd9COUx2am7MAGc24C7rk/CQ0rNrL2ZS4U=;
        b=HLUMZ8vH+JbwLWcqSvT3+9MRYJxdeKu17BvWTPpn9qH46D2lg1sqrTkRB+xbp2WrlhFFac
        5+bmbsbPY5WDOTCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/8] printk: Provide debug_store() for nbcon
 debugging
In-Reply-To: <ZMPdRVXq3IybuvzN@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-3-john.ogness@linutronix.de>
 <ZMPdRVXq3IybuvzN@alley>
Date:   Fri, 28 Jul 2023 23:07:08 +0206
Message-ID: <87leez92ej.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28, Petr Mladek <pmladek@suse.com> wrote:
>> +	r = vprintk_store(2, 7, NULL, fmt, args);
>
> We should probably use one of the LOG_LOCALX numbers, e.g.
>
> #define        LOG_LOCAL0        (16<<3)
>
> Also, please use LOGLEVEL_DEBUG instead of the hard coded "7".

OK.

I am also open to dropping the function and its use. When developing the
ringbuffer I also had a similar function but never attempted to publish
it. It is useful for developing/testing/debugging, but once everything
works as it should it has no real purpose. I have no problems keeping
the debug stuff hidden in my own private toolbox.

John
