Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC55B752944
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGMQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGMQ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:59:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63295268B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:59:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C8361ADE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D1DC433C8;
        Thu, 13 Jul 2023 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689267540;
        bh=pW1JUGIXdjPSUFzlQ9hxjilOtc9B8ahtl0ZfNBtJcPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGe5yb2ylnSGBTLoccMeUrRCek93QPiG0iTs0WXYxi9JJ6uEWNBFmvaw2iaeXucEo
         lpQ8XRqL9xMjIfWFTZiU8MDFav+S5US96GDtWCUPC3cJBw8uDi31cBK/Hq4H8OVnmo
         o6Pa0ePDiYfifz338mqYzA8NpMSC6OnzB+ch8SoI=
Date:   Thu, 13 Jul 2023 18:58:57 +0200
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
Message-ID: <2023071356-royal-charter-a647@gregkh>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <2023071237-private-overhang-7f86@gregkh>
 <875y6o429i.fsf@redhat.com>
 <2023071329-persevere-pursuant-e631@gregkh>
 <87wmz33j36.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmz33j36.fsf@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 05:51:57PM +0200, Vitaly Kuznetsov wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> > On Thu, Jul 13, 2023 at 10:57:45AM +0200, Vitaly Kuznetsov wrote:
> >> I don't
> >> particularly see why anyone would need to get additional sign-offs to
> >> just ask a question (which I don actually think was asked before!) and
> >> IMO an RFC/patch is usually the best way to do so.
> >
> > Again, no questions were asked.
> >
> > And when I asked questions, no one knowledgable answered them (hint, we
> > release more than 3 kernels a year...)
> >
> 
> I think that getting these questions was actually the main reason to
> send out the RFC. (Personally, I don't think that stable@ is an
> insurmountable problem with an epoch-based revocation mechamism as we
> can e.g. switch module name from "linux" to e.g. "linux-stable-5.14"
> when screating a stable branch or do something like that but that's not
> the main/only problem we see here).

There was no "questions" asked about this RFC, so what should we respond
with except with what we did, "No way this is acceptable, as this was
not thought through at all"?

> > Turn it around, what would you do if you got this patch in your inbox to
> > review and you were responsible for doing kernel releases and security
> > fixes?
> >
> 
> I replied to the thread not to defend the idea as after the discussion
> it is clear there's a lot to take into consideration if anyone decides
> to pursue the SBAT idea ever again (and the discussion is now well
> preserved in the archive!). I replied to disagree with "get sign-offs
> from senior people before sending RFCs" idea, I believe that asking
> questions by sending a not-fully-ready patch as "RFC" should not be
> discouraged. 

On the contrary, this is EXACTLY what needs to happen here.

This developer (I'm not picking on them at all, it's not their fault),
should be taking advantage of the resources of their company when
dealing with core, critical, functionality of the kernel.

To just "throw them at the wolves" like Red Hat did, is a total
disservice to them, AND it wastes the time and resources of the
community, as it is not our job to train and teach them, it is the job
of the senior people at your company to do so.

We have a non-zero number of companies that right now who are in the
"penalty box" because their developers have had a history of throwing
crud over the wall, or having inexperienced developers submit changes
that are obviously wrong, which waste the time and energy of the kernel
community.  For companies that do this, we have instituted the
requirement that they get review and acceptance of kernel changes from
the experienced developers within the company BEFORE submitting their
changes to the community, for the basic fact that this actually saves
EVERYONE time and energy.

It allows the developer to grow and learn more quickly, it saves the
energy and time of the reviewers (which is our most valuable resource
right now) and it provides a solid path forward on the corporate ladder
of using mentors well, and lifting up your own employees.

I don't think you want us to put Red Hat into this type of policy at
this point in time, but if you all keep insisting that you can just "let
loose" inexperienced developers who wish to change the core
functionality of how we operate, that can easily change.

Remember, this proposed patch directly affects how the kernel is
released, how the security team works, and how the security of Linux is
viewed by the world.  Why would you NOT want your experienced developers
to review such a thing first?  To not want that, means that Red Hat just
doesn't care about their developers, nor the community, which I sure
hope is not the case.

So again, yes, I am INSISTING that the next version of this change be
properly reviewed, vetted, and signed-off-by, by the senior kernel
developers at your company BEFORE you submit it again for review by
anyone in the community.  Only that way can I hope that it will be
something that actually takes into account all of the questions we have
already had for this proposed 2 line change.

Funnily, I think this proposed patch takes the dubious record for "most
innocuous looking patch that will directly affect the development
procedures for the most people", an outstanding record that I hope never
gets broken :)

thanks,

greg k-h
