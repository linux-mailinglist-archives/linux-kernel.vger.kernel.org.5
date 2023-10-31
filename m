Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC0B7DD055
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344733AbjJaPTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344626AbjJaPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:19:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D282720
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:16:22 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698765379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HX8FRR81n9jl4rlGd6QXQZhTc523YLl6a4k4uzDi/to=;
        b=l5iuV1TYKRaxFdPDvWduWbfSA011YDAND05tNcNg+FjWtcKTU9oJQ4YUnx19N2Sws9ULYn
        t2CiGMojJnaeR+939yWfgM9dNgXPpuub0DHLm9usGe5l0SihYz+qKa+wvmaoJp7ZkGwBPy
        IjLK5mLVaVieN5t1w32K+vjL9PGx8Hme+fqrUxqh11cl6KsdxhuTnGAlfpb+JgoiNUnOcl
        cQy0aLiPJJV26Pdqk7KFrah/BJpCMv/pU5hdNmV69Q4+hWb8ZNR4246dKpSEK+pjgjelTC
        4MmOqXg8SXodBvboX/0OE69xMFr/DvJqQKVMUm8L8H4qJtVerqHcEAev52LJQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698765379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HX8FRR81n9jl4rlGd6QXQZhTc523YLl6a4k4uzDi/to=;
        b=cQwReN4RB3crvG2B3IcblUDgOm9JP7pS2jlCokzMaZ4mGkU88uR9lxQyIYz7GBsPlWl3b9
        kWgH4GI1z0rt9bDg==
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] reboot: flush printk buffers before final shutdown
In-Reply-To: <8e31147e-f727-4354-8644-a4ff4b1431a4@geanix.com>
References: <20231030092432.3434623-1-martin@geanix.com>
 <20231030092432.3434623-2-martin@geanix.com>
 <87edhbf3lm.fsf@jogness.linutronix.de>
 <8e31147e-f727-4354-8644-a4ff4b1431a4@geanix.com>
Date:   Tue, 31 Oct 2023 16:22:17 +0106
Message-ID: <878r7ibz5q.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-31, Martin Hundeb=C3=B8ll <martin@geanix.com> wrote:
>> printk() tries to print directly from the calling context. Are you
>> experiencing problems where you do not see the restarting message?
>
> Yes, but only with rt-patches. Sorry I forgot to mention that in the
> commit message. I considered sending the patches to the "rt-tree", but
> figured they don't need more patches to maintain, when the same
> changes could live in mainline just as well.

Thanks for clarifying. These patches really are only appropriate for the
rt-tree.

John Ogness
