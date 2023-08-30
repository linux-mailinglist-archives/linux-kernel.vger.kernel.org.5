Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414C978DEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjH3T1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbjH3MoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:44:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86E7C2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:44:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693399446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEJ0kVid6YqL1aDp6RJNTR0lXoi8C1JegKTmw5SjuPE=;
        b=QZhzdJIkfj1YfdFg4Qyn4Z16vShF9sBoWGqtOZUic29tVNJ1iQERbQIEySMdN4h6fTl1mv
        IUNaSYZ3DyvPPR+MtWoawO9YlsEcOWEYVqSkHvNZ3mF4pXZxBpBSkBkBu7yPZSR/0Da02A
        3jfpmXLowIQi3APh7DY2KHCVJlwJRyx2vjNQLNUcjrl+7DfjaQ9QvNywmEwCrrxtiomuJR
        7qYzIdctvf8zW9gDxXxTtlN3sMbqO5iBmjW+1qlJ05ojYhbZUteg8SwCraWtkLjWr6gWJW
        JoNACggRd7J38oS/47miquUYYZUFYXimGdaY3siYSeAdjwV67p/4Lr89+E4HBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693399446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEJ0kVid6YqL1aDp6RJNTR0lXoi8C1JegKTmw5SjuPE=;
        b=PjDko05vyLXnVOTPrmRAuRJhGXfrA7lJyA0jlh/dbJcroQy3aYtj2zxUZt5Y4sxplJkyF5
        f5cw4Nf+UqcwfIBw==
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/core for v6.6-rc1
In-Reply-To: <20230830112742.GAZO8nrn75B2V5qIk2@fat_crate.local>
References: <169339202558.475946.15795543318941920393.tglx@xen13>
 <20230830112742.GAZO8nrn75B2V5qIk2@fat_crate.local>
Date:   Wed, 30 Aug 2023 14:44:06 +0200
Message-ID: <87o7io66p5.ffs@tglx>
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

On Wed, Aug 30 2023 at 13:27, Borislav Petkov wrote:
> On Wed, Aug 30, 2023 at 12:40:46PM +0200, Thomas Gleixner wrote:
>> Petr Pavlu (2):
>>       x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
>>       x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT
>
> So those two went upstream earlier, as part of the urgent lineup, see:
>
> commit bf98bae3d8a18745e54fef9fd71fd129f6e9f7e5
> Merge: 4e7ffde6984a 6405b72e8d17
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sat Aug 19 10:46:02 2023 +0200
>
> and I've zapped them from x86/core.

Duh.

> You probably should update your local x86/core copy and resend the pull.

Let me do that.
