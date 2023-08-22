Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6DB783932
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjHVFX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjHVFX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:23:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FDA133
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 22:23:25 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA26C1EC0105;
        Tue, 22 Aug 2023 07:23:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692681803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XPMFThk9PKdFJoPKLkA8jQSGy3/DrDz71v2fkoZzRJ0=;
        b=W0W21L/BsDXKtj3SMby0g+TXP7O4s2zzxuIM9zz4OZETN9q78ixSZeclqwjsPULRnv525Q
        lUKkTHr26uotfWVEwYzAXqyHNftd8Wn+AiM5Bd4DyjRSKF5xIpgfPseaotqAM8bjLgxaBF
        EYGvrRgfsuWdDAS8JTVVUnZ+RmPq6ow=
Date:   Tue, 22 Aug 2023 07:23:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/22] x86/srso: Fix srso_show_state() side effect
Message-ID: <20230822052326.GAZORGTrM6N7+6l+sl@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
 <20230821060416.GBZOL+YJeVj4tbkT78@fat_crate.local>
 <20230821161706.s62ecp7zhiunt5oy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821161706.s62ecp7zhiunt5oy@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:17:06AM -0700, Josh Poimboeuf wrote:
> I could do that, but this check ends up getting replaced by a later
> patch anyway.
> 
> Would you want this comment in srso_select_mitigation()?  After the next
> patch it has:
> 
>   bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
> 
> Though that seems clear to me already.

Ok, good enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
