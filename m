Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B57A676B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjISO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjISO6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:58:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441C19A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:57:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695135474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=biMdXwZKx0XqaJxaBPzPvHh0NwjTmBb+iPJs2kh0mkI=;
        b=1yCRL568mCyIub6U8JQXjH27jm/Ef906n+qhrdWGSSIXosgzBWDebDIQtu97dXLBpCvQho
        TPA2UYi1WuRUImn94SFCup5CNKxFbseixK77+IvAi0bZj7Lx7ldisE2kZ4nTeT1+2Kb1/R
        rtydYBKHSntiy8ZYkfdp6i7oCIRxw5QpYg70Vc9Oc0XKMYDfVuXOEdLQvE6VMKtHMLpbDk
        Y7tZ3Ff/njhIMYp7Ns5NpCl7OHbkM92L/LJsx++4eZzOOUUbGQIi7EnZ/cmgPtnhlQgoVK
        dVVEkl/fy1KCLw4brlzccgofAcI7hL/Hv7jCIGO6lh2KP9ZTWr+dDqbCKurxjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695135474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=biMdXwZKx0XqaJxaBPzPvHh0NwjTmBb+iPJs2kh0mkI=;
        b=Lqb4xPW88rRRiL1sai+Dh2digcY/QHbH40L6wdNMZGjNQ5w1UGbgGWq9HfvzPRA8BOVbrV
        mxz/QnqpCI2b4tDA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V3 07/30] x86/microcode/intel: Simplify early loading
In-Reply-To: <20230919143230.GDZQmw/kLc5nyu9CZV@fat_crate.local>
References: <20230912065249.695681286@linutronix.de>
 <20230912065501.208060138@linutronix.de>
 <20230919143230.GDZQmw/kLc5nyu9CZV@fat_crate.local>
Date:   Tue, 19 Sep 2023 16:57:54 +0200
Message-ID: <871qeuw6q5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 16:32, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 09:57:54AM +0200, Thomas Gleixner wrote:
>> +/* Load microcode on BSP from CPIO */
>
> Yeah, no need to say "from CPIO" everywhere. We load it from somewhere,
> it can be cpio but it can be builtin too.

Makes sense.

> But I can fix up too when applying.

Thanks a lot!
