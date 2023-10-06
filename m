Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58067BB029
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 03:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjJFBsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 21:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjJFBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 21:48:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14210DE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 18:48:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d815354ea7fso2134562276.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 18:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696556901; x=1697161701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXc2O/7sCaxNCrmG6skLU9Fi8ZAb+bkQu9XTdeJPITM=;
        b=Id1JyKTE+DXe1zXADSJhMkgJCISFAetC0ZgprPpbixwdbVAHvTW2DZX+QEuizCEE63
         NCsq12r4rPcHxYzTd3xfdnNrBWpBxaAUF4/ifkRs/eLZ9mFZMmUQQ4KH4ZfsXl8zOi2X
         HXELmdYhtOxeqEAuM46HzRpt5jq+BzOTK9jx3USTt4tbnYsqLmpqRCnGxb1gldIOpCnV
         NfBUsW6MZURpD45b1/ZNqux+CMV4BgoY+C9N1oJzeTHvSG9vlCO1U16pI3yOJ1SAitWR
         LK/qvppVra3/3Uf7vhFg4fnowzPZ4QveTtDL/t6DdBmRTQnCwwbOSofUAO076cksFG2q
         z16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696556901; x=1697161701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXc2O/7sCaxNCrmG6skLU9Fi8ZAb+bkQu9XTdeJPITM=;
        b=Wnlivp7UtilBh4qGT5+ha54N7SJQlP6fkrQQRuO/CCK/mUfB7i278UCnlvQM3s8GPp
         jWBaPCVFUX8lvCQGAt5AhprXvOPzejYehmB2KP105vSTc30gnVr6ihBjnfhr4N6hPjjn
         P5PFRIASIHrTzxJbFKQCwSE0dnHTXU41h8XZyszntGy7IIgQRSFZwqHab8Msj/m5pcjG
         A8eCpEKUopVdNAZxnFndKezafPrpCkVUr0QbcTkGjxKxAnyTbRb/Zihx7LrdJMp9+wPf
         oi4LESDc7AbBUK4BDONvMMrXytJHkoJ6eLUFCLTCAixqxXsDchTGa3cBFwUWUBbP750P
         W6QQ==
X-Gm-Message-State: AOJu0Yw81b2rvgaNkvDepizueZnigtEVGQ0RUb9l0cqcKKUG+x522gMW
        i4tvWDxyiEl2gxu0P2rGBgK1Eec1qjo=
X-Google-Smtp-Source: AGHT+IG5kNlkia9mNVTpbkW4qVJ+ISAXuag8oe/q6O2fyloXPP+UYEYfKbsxwZ6+HCaMsJtpRYwGXiuE5ss=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:500c:0:b0:d81:fc08:29ea with SMTP id
 e12-20020a25500c000000b00d81fc0829eamr89926ybb.2.1696556901326; Thu, 05 Oct
 2023 18:48:21 -0700 (PDT)
Date:   Thu, 5 Oct 2023 18:48:19 -0700
In-Reply-To: <5fc0fbfe-72e8-44bf-bad2-92513f299832@xen.org>
Mime-Version: 1.0
References: <20231004174628.2073263-1-paul@xen.org> <ZR2vTN618U0UgtIA@google.com>
 <5fc0fbfe-72e8-44bf-bad2-92513f299832@xen.org>
Message-ID: <ZR9nYw53O21y0VYM@google.com>
Subject: Re: [PATCH v2] KVM: x86/xen: ignore the VCPU_SSHOTTMR_future flag
From:   Sean Christopherson <seanjc@google.com>
To:     paul@xen.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023, Paul Durrant wrote:
> On 04/10/2023 19:30, Sean Christopherson wrote:
> > On Wed, Oct 04, 2023, Paul Durrant wrote:
> > > ---
> > > Cc: David Woodhouse <dwmw2@infradead.org>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: x86@kernel.org
> > 
> > If you're going to manually Cc folks, put the Cc's in the changelog proper so that
> > there's a record of who was Cc'd on the patch.
> > 
> 
> FTR, the basic list was generated:
> 
> ./scripts/get_maintainer.pl --no-rolestats
> 0001-KVM-xen-ignore-the-VCPU_SSHOTTMR_future-flag.patch | while read line;
> do echo Cc: $line; done
> 
> and then lightly hacked put x86 at the end and remove my own name... so not
> really manual.
> Also not entirely sure why you'd want the Cc list making it into the actual
> commit.

It's useful for Cc's that *don't* come from get_maintainers, as it provides a
record in the commit of who was Cc'd on a patch. 

E.g. if someone encounters an issue with a commit, the Cc records provide additional
contacts that might be able to help sort things out.

Or if a maintainer further up the stream has questions or concerns about a pull
request, they can use the Cc list to grab the right audience for a discussion,
or be more confident in merging the request because the maintainer knows that the
"right" people at least saw the patch.

Lore links provide much of that functionality, but following a link is almost
always slower, and some maintainers are allergic to web browsers :-)

> > Or even better, just use scripts/get_maintainers.pl and only manually Cc people
> > when necessary.
> 
> I guess this must be some other way of using get_maintainers.pl that you are
> expecting?

Ah, I was just assuming that you were handcoding the Cc "list", but it sounds
like you're piping the results into each patch.  That's fine, just a bit noisy
and uncommon.

FWIW, my scripts gather the To/Cc for all patches in a series, and then use the
results for the entire series, e.g.

  git send-email --confirm=always --suppress-cc=all $to $bcc $cc ...

That way everyone that gets sent mail gets all patches in a series.  Most
contributors, myself included, don't like to receive bits and pieces of a series,
e.g. it makes doing quick triage/reviews annoying, especially if the patches I
didn't receive weren't sent to any of the mailing list to which I'm subscribed.
