Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1274F7866AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 06:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjHXEYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 00:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbjHXEYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 00:24:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FECE3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 21:24:17 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F3621EC0136;
        Thu, 24 Aug 2023 06:24:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1692851055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=62YKB24sQjSmNv/uIoB2hKOaU5vGKUDENuzz7wflvv0=;
        b=C/weeCjo2vDzIxg1d7YVDTVBHLCPXEVZ2TLrz8xmeGYG9lAcaRFbGB+53TrRhxRwpgt1NT
        MXQ9hqFc4urnExEZyngAhmSFv+3cSo9p0+fDuZpw2MdAyPGLpDBj+O2GzS653Z0xiukuzu
        iPXbJ45gMYUj7rwgfENulp8SNxNOL/s=
Date:   Thu, 24 Aug 2023 06:24:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 02/22] x86/srso: Set CPUID feature bits independently of
 bug or mitigation status
Message-ID: <20230824042420.GAZObbdNb38eKaCPAm@fat_crate.local>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <caf4d0a1233ccc1c33f4ff8d3fe302c9289f4bea.1692580085.git.jpoimboe@kernel.org>
 <26a3421e-3a88-b326-4c4f-abdaa2262852@citrix.com>
 <20230821140619.GBZONvWz+iwQZwx/sC@fat_crate.local>
 <20230823052007.GBZOWXBymcCUOoMax3@fat_crate.local>
 <22eb07b3-6de4-9fc2-fb05-2c7ebe6dc951@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22eb07b3-6de4-9fc2-fb05-2c7ebe6dc951@citrix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:22:34PM +0100, Andrew Cooper wrote:
> In my previous reply, I explained why this goes wrong when Linux ignores
> the CPUID bit provided by the hypervisor and decides to probe manually.

Send a patch and explain in its commit message *why* this is needed.

> No.

Hell yeah!

How do you expect us to support use cases we don't know about?!

> You don't get to take my code, break it when integrating it into Linux,
> then dismiss the bug as something hypothetical that you don't want to fix.

I have no clue what you're talking about but it sounds like
a misunderstanding. All I'm saying is, the live migration use cases the
kernel should support, should be documented first. If there's no
documentation for them, *then* you have hypothetical.

So patches explaining what we're supporting are welcome.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
