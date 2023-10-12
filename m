Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66CF7C78E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347413AbjJLV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjJLV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:59:10 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 14:59:06 PDT
Received: from second.openwall.net (second.openwall.net [193.110.157.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BC48DD8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:59:06 -0700 (PDT)
Received: (qmail 21923 invoked from network); 12 Oct 2023 21:51:43 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 12 Oct 2023 21:51:43 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id DD58DA064D; Thu, 12 Oct 2023 23:51:22 +0200 (CEST)
Date:   Thu, 12 Oct 2023 23:51:22 +0200
From:   Solar Designer <solar@openwall.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, corbet@lwn.net, workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] Documentation: security-bugs.rst: linux-distros relaxed their rules
Message-ID: <20231012215122.GA8245@openwall.com>
References: <20231007140454.25419-1-w@1wt.eu> <5ae47535-b6e0-8b48-4d59-a167e37c7fcc@oracle.com> <20231007163936.GA26837@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007163936.GA26837@1wt.eu>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Thank you (especially Willy) for your effort on this.

Out of the 3 paragraphs, the first one looks good to me as-is, but for
the last two I propose the slightly edited versions below.

On Sat, Oct 07, 2023 at 04:04:54PM +0200, Willy Tarreau wrote:
> +Please note that the respective policies and rules are different since
> +the 3 lists pursue different goals.  Coordinating between the kernel
> +security team and other teams is difficult since occasional embargoes
> +start from the availability of a fix for the kernel security team, while
> +for other lists they generally start from the initial post to the list,
> +regardless of the availability of a fix.

---
Please note that the respective policies and rules are different since
the 3 lists pursue different goals.  Coordinating between the kernel
security team and other teams is difficult since for the kernel security
team occasional embargoes (as subject to a maximum allowed number of
days) start from the availability of a fix, while for "linux-distros"
they start from the initial post to the list regardless of the
availability of a fix.
---

I added the part in braces to explain why the difference in when
embargoes start matters.  I also moved part of that sentence for
consistency.  Finally, I replaced "other lists" with specific reference
to "linux-distros" because this paragraph talks only about 3 specific
lists and on "oss-security" there are no embargoes.

On Sat, Oct 07, 2023 at 06:39:36PM +0200, Willy Tarreau wrote:
> On Sat, Oct 07, 2023 at 06:30:11PM +0200, Vegard Nossum wrote:
> > On 07/10/2023 16:04, Willy Tarreau wrote:
> > > +As such, the kernel security team strongly recommends that reporters of
> > > +potential security issues DO NOT contact the "linux-distros" mailing
> > > +list BEFORE a fix is accepted by the affected code's maintainers and you
> > 
> > is s/BEFORE/UNTIL/ clearer?
> 
> Probably, yes.

I agree.  Also, the sentence jumps from "reporters" to "you" implying
that "you" is a reporter, but maybe it's better to make that explicit.

> > > +have read the linux-distros wiki page above and you fully understand the
> > > +requirements that doing so will impose on you and the kernel community.
> > > +This also means that in general it doesn't make sense to Cc: both lists
> > > +at once, except for coordination if a fix remains under embargo. And in
> > > +general, please do not Cc: the kernel security list about fixes that
> > > +have already been merged.

This implies that in general a fix does not remain under embargo.
However, contacting "linux-distros" only makes sense when a fix does
remain under embargo (either not yet pushed to a public list/repo, or
under the Linux kernel exception for a public not-too-revealing fix) -
otherwise, the issue should be brought to "oss-security" right away.

Edited:

---
As such, the kernel security team strongly recommends that as a reporter
of a potential security issue you DO NOT contact the "linux-distros"
mailing list UNTIL a fix is accepted by the affected code's maintainers
and you have read the distros wiki page above and you fully understand
the requirements that contacting "linux-distros" will impose on you and
the kernel community.  This also means that in general it doesn't make
sense to Cc: both lists at once, except maybe for coordination if and
while an accepted fix has not yet been merged.  In other words, until a
fix is accepted do not Cc: "linux-distros", and after it's merged do not
Cc: the kernel security team.
---

This allows possible Cc'ing of both lists in the time window between
"fix is accepted by the affected code's maintainers" and "merged".
Makes sense?  I worry this distinction between accepted and merged may
be overly complicated for some, but I don't have better wording.

> > I was thinking about this Cc: thing and would it make sense to:
> > 
> > 1) have LKML and other public vger lists reject messages that include
> > s@k.o or (linux-)distros@ on Cc? The idea being that this is probably a
> > mistake -- I believe it has happened a few times recently by mistake.
> > 
> > 2) have (linux-)distros@ reject NEW threads (i.e. no In-Reply-To:) that
> > also include s@k.o on Cc? We could include a nice message explaining why
> > and to please resend when a patch has been developed and/or a disclosure
> > is planned in the next 7 days.
> 
> I don't know, maybe it would add extra config burden, but on the other
> hand it could avoid the mistake from newcomers who have not read the
> docs first (which happened a few times already), but if l-d becomes a
> bit more flexible and tolerant to reporters' mistakes, as now documented,
> it should also be less of a problem.
> 
> > I guess the problem with this would be if
> > somebody on s@k.o does a reply-all which would add distros right back in
> > the loop -OR- a patch has already been developed and included.
> 
> Then this would be deliberate, there would an in-reply-to so that would
> not be a problem. I really doubt anyone from s@k.o would Cc linux-distros
> anyway since it would imply disclosing some details from a reporter, and
> we do not do that, it's up to the reporter to do it if they want.

I think we don't want to complicate the setup, which we'd then have to
explain somewhere.  With my concern/edit above, also the logic isn't
that simple.

Alexander
