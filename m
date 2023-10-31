Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DED17DC78E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343740AbjJaHqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343732AbjJaHqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:46:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660ABE6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:45:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698738355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5viE4mY1oifpaOAIMkc6x6ev3/JECOTw6bRcrUWWqHI=;
        b=4tJu5+VTHlywIyYFqYr4Bwm0yR5bBJ2TRQiYjYH1VJ9YGiDpNjYZyBTbR1kc5yU7mVmEu1
        cyufuzfMXPysH6I1xUCmqG8xmVNE2He2LDwaFwD73f86LhI/+N8hLL+0soYHd4aXs0DYzS
        epRXrpgDKDWWK78kLwxbUk2NfcPm+nhcPBx1hckMNrh8gFZaBhoPkswTP3COt087ZMFa4t
        TD4UiT4NGtA4sHfrt0kqCwOUqZNOO2OADLu/g1wbW3uTg8MQy7sdFD1XV4ADUm/wGvuR9w
        cv0hpOA3M6MvAS0AsoxIfhn70rqgxGa8Kga9U7pkeRnzrABwqj7GXsEHGEwsHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698738355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5viE4mY1oifpaOAIMkc6x6ev3/JECOTw6bRcrUWWqHI=;
        b=pnDdCyYOBEd+uDbTzi327eUIc57zs4kaei9JtqnHCZlr+qjDtf8K4zGmL44uNXZQwgXkrQ
        r4JBPZeEYo/NiNCQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [GIT PULL] x86/boot changes for v6.7
In-Reply-To: <CAHk-=whiZvO3r+RbX71qxPgFYm0TGWMkPkNXNHcwPrhxLq633Q@mail.gmail.com>
References: <ZT0IY1INe8Jls7EC@gmail.com>
 <CAHk-=whiZvO3r+RbX71qxPgFYm0TGWMkPkNXNHcwPrhxLq633Q@mail.gmail.com>
Date:   Tue, 31 Oct 2023 08:45:54 +0100
Message-ID: <87pm0vxmj1.ffs@tglx>
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

On Mon, Oct 30 2023 at 14:10, Linus Torvalds wrote:
> On Sat, 28 Oct 2023 at 03:11, Ingo Molnar <mingo@kernel.org> wrote:
>>  - Pulling this tree will generate a conflict in
>>    drivers/firmware/efi/libstub/x86-stub.c, due to a fix we wanted upstream
>>    without related cleanups, which is resolved by picking this resolution:
>>
>>         boot_params_ptr = boot_params;
>
> Hmm. I think I should also remove the now legacy line of
>
>    extern struct boot_params *boot_params_pointer asm("boot_params");
>
> from drivers/firmware/efi/libstub/x86-stub.h, no?

Indeed.
