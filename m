Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E165C7525D4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjGMO6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjGMO6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512962D6A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:58:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE31F61861
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B49C433C8;
        Thu, 13 Jul 2023 14:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689260304;
        bh=iX5N4lE4KxY1+QurnpsBhAWrrYlJ3UK4/HtyY/Fl9r4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2bsQGyG72H86hiUhtA+0fbARJwTDmdBtfogG0HfwCJcJzTo/H0Z4NF41T9OJyJhME
         EJ6O+EI/ZGegyF5aA41yrWNJIJEpmXq2INifT+P2ByzxnjzkAHjt5W78gnLq155K3H
         VYJ8NgPv4WN5Ymc6Uw2Dn+00hqFlJsTqjVGMj0p8=
Date:   Thu, 13 Jul 2023 16:58:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <2023071329-persevere-pursuant-e631@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
 <875y6o429i.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y6o429i.fsf@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 10:57:45AM +0200, Vitaly Kuznetsov wrote:
> FWIW,
> 
> this was an RFC to answer a fairly straitforward question: is upstream
> Linux interested in / is a suitable place for having SBAT revocation
> mechanism or not.

As Peter said, there was no questions in this patch, so how were we to
know that this was something that you all were asking?

Also, you need to provide lots of information in the changelog itself
about whatever "SBAT" is, as that is not anything that anyone should be
forced to look up (links go dead over time.)

> We can, of course, iron out the details whether it
> should be "linux.org"/"linux.com"/"lore.kernel.org/lkml/" or
> "linux.onion" and where to put objcopy call, whether to silence its
> output or not but these are rather implemntation details.

It's a sign that this change was not thought out at all, as the
follow-up questions, and lack of answers, showed in detail.

> I don't
> particularly see why anyone would need to get additional sign-offs to
> just ask a question (which I don actually think was asked before!) and
> IMO an RFC/patch is usually the best way to do so.

Again, no questions were asked.

And when I asked questions, no one knowledgable answered them (hint, we
release more than 3 kernels a year...)

> Following the discussion, it seems that at least x86 maintainer[s] are
> opposed to the very idea of having SBAT revocation mechanism integrated
> upstream because it's hard to meaningfully define what epoch is.

You all did not even consider how this might work with our existing
release process OR how we handle security fixes today.  In fact, you
totally ignored it, and didn't even do some basic research into our past
history to see how this new feature would actually work had it been
present 10 years ago.

You need to convince us "of course we would be foolish to not accept
this patch because you properly researched it, documented it, and tied
it all into our existing release and security and other policies and
proceedures".  But none of that happened here, so we would be foolish to
ACCEPT this patch, right?

Turn it around, what would you do if you got this patch in your inbox to
review and you were responsible for doing kernel releases and security
fixes?

> This is
> OK (which doesn't mean we all agree to that) but as there's real need to
> revoke "bad" (in UEFI SecureBoot sense) kernels, distros will likely
> come up with their custom, downstream only ways to do it. Without an
> upstream reference, however, they may come up with very differently
> looking SBAT sections, this may or may not be problematic in the future,
> who knows.

You all haven't even properly defined what "bad" means!  Or who would
determine it!  Or how it would work with our decades-old release process
that has evolved over time.  Or how it would tie into our existing
security fixing policies and processes.

In fact, it is a complete end-run around all of that, with only a "trust
us, we will update the number when we want to" statement.  Also
without even defining who "us" is.

And if a security policy doesn't even define who is going to be
determining the security policy at all, is it a security policy you want
in Linux?

thanks,

greg k-h
