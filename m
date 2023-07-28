Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBB766801
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbjG1JAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjG1JAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:00:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D872106
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 02:00:20 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690534818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnmY0M8OuuhSiSh/x+he+nRFbUG1l3nvKg0ZHWRzi+Q=;
        b=AY5tD1omkM4ZkaDNWVQYQWflmux6ksKh4Bth/5nsZrIvkJP5e8qM5dxJOSTAcyQ7WAVCbN
        qZJvhv8k3KIwPZ4tK92bOAsMZiMmB4dfOV/dQ3Vy3zr/NJtedfJDUC09rtolx00mx9z73c
        Fsb9AwihdB8umuwQBEa2M938uGBl3Ot42Hojfb0kOorMzRPtfvZBz7HD2gwSOCzLl4ax8/
        W0bRqntrVzPLhCB9EssYPj1DHg/4dXfMDLFYEln/Tj4oWnPWoQsYqw91VtCU+vqGru9+jj
        zet/GVo53+t+07bEU4Pw+mGOy+tcCzsbjUjuE/DnY4fjY4cQnn5myDLAnSa0qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690534818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jnmY0M8OuuhSiSh/x+he+nRFbUG1l3nvKg0ZHWRzi+Q=;
        b=/fIDc4E8awRRUfh41aqLOsBZVfoRbacCbBLYyVy6kaXs4bY7rAZFXjutjNxHH8ZiHQ8mWC
        ZZcN3ute/jY2mhDw==
To:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
In-Reply-To: <202307280939.4IPb76dh-lkp@intel.com>
References: <20230728000233.50887-6-john.ogness@linutronix.de>
 <202307280939.4IPb76dh-lkp@intel.com>
Date:   Fri, 28 Jul 2023 11:06:17 +0206
Message-ID: <87bkfw1kda.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-28, kernel test robot <lkp@intel.com> wrote:
>>> kernel/printk/printk_nbcon.c:168: warning: expecting prototype for nbcon_read_seq(). Prototype was for nbcon_seq_read() instead
>    kernel/printk/printk_nbcon.c:182: warning: Function parameter or member 'seq' not described in 'nbcon_seq_force'

Thanks kernel test robot for spotting the 2 kerneldoc errors. I will fix
them for v3.

John
