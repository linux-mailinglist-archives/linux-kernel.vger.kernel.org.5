Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0F178DD91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbjH3Svy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbjH3L1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:27:48 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED504193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:27:44 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA2931EC08EB;
        Wed, 30 Aug 2023 13:27:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693394863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kk5WRjNybBcXubI1a/ilJK8QXpYsB4BNyiHst5XQ+TA=;
        b=TZl8K6pqajlNI4y7/8Tyo9r8sGyl36/LNZRMl6TJZKLjlK6EuRmTtaf6bsnWtQNMJwa4zl
        VVEUUuxqfGhJtkDO7k+Eq9gzzLeqW0J0v7+R58ajsCJ7w43Wu+qveSz+3kzto1O7f3rJ7X
        /fv3kumos4A6vXo3edSrqpeCKilc3LY=
Date:   Wed, 30 Aug 2023 13:27:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] x86/core for v6.6-rc1
Message-ID: <20230830112742.GAZO8nrn75B2V5qIk2@fat_crate.local>
References: <169339202558.475946.15795543318941920393.tglx@xen13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <169339202558.475946.15795543318941920393.tglx@xen13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:40:46PM +0200, Thomas Gleixner wrote:
> Petr Pavlu (2):
>       x86/retpoline,kprobes: Fix position of thunk sections with CONFIG_LTO_CLANG
>       x86/retpoline,kprobes: Skip optprobe check for indirect jumps with retpolines and IBT

So those two went upstream earlier, as part of the urgent lineup, see:

commit bf98bae3d8a18745e54fef9fd71fd129f6e9f7e5
Merge: 4e7ffde6984a 6405b72e8d17
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Aug 19 10:46:02 2023 +0200

and I've zapped them from x86/core.

You probably should update your local x86/core copy and resend the pull.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
