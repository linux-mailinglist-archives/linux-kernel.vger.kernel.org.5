Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D77BAB33
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjJEUGF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJEUGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:06:03 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722ACE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:05:58 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 72B9F160421;
        Thu,  5 Oct 2023 20:05:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 1BE892002D;
        Thu,  5 Oct 2023 20:05:54 +0000 (UTC)
Message-ID: <eea5087a2bd94b80b5a16af95a4caf20376bbc52.camel@perches.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching
 to patches
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 05 Oct 2023 13:05:53 -0700
In-Reply-To: <CAFhGd8rGZ6w7bz90LRnwd_1K3ibR2KsT6cJ2kiuO5mSAdnWjFw@mail.gmail.com>
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
         <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
         <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
         <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
         <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com>
         <a8b680c03379ed7a07418e471b29dccd801f23cb.camel@perches.com>
         <CAFhGd8rGZ6w7bz90LRnwd_1K3ibR2KsT6cJ2kiuO5mSAdnWjFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1BE892002D
X-Stat-Signature: pwf4o46ayjstbkyxc9z58umnspw6hctt
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/1VlcfI30pytACJfVJd+MYNwCJK4b7g5I=
X-HE-Tag: 1696536354-269339
X-HE-Meta: U2FsdGVkX1+WfrL/Nr/SqgpAzh0ggajZ0mOPMMrHUHfIroDj3aNY0pp04WVVAlpeFRzrXzYhTaQ+HRAN1VK7JjazQgHCnhdn8nYlEd/Ms2rv9llin/AlILVu2zBXh3q8MgyzRJb3lY9GgrrYC9sml/uihVH38p9RXc5Eb6dDdM/xvxAE36BgvPPkbemFCbyLwGN69dJ9d314PWsEtfJVi1vAlet4v2EyGT667m7vdqArQlsu0DfhD+D/G5zjUxyl3morSbdeVgVa3flbBvhsMBoTA2VG4msp1V56Xr5vgGczY4UafrX2E6w8Hf9c14VDXZosWgRe3k24LxZWqCFX1pBXj3r0QwanE+p4KZtwS8QCTiniCzTYgU+UFafw6dIg
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 12:52 -0700, Justin Stitt wrote:
> On Thu, Oct 5, 2023 at 11:42 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2023-10-05 at 11:30 -0700, Justin Stitt wrote:
> > > On Thu, Oct 5, 2023 at 11:15 AM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> > > > > On Wed, Oct 4, 2023 at 7:40 PM Joe Perches <joe@perches.com> wrote:
> > > > > > 
> > > > > > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > > > > > The current behavior of K: is a tad bit noisy. It matches against the
> > > > > > > entire contents of files instead of just against the contents of a
> > > > > > > patch.
> > > > > > > 
> > > > > > > This means that a patch with a single character change (fixing a typo or
> > > > > > > whitespace or something) would still to/cc maintainers and lists if the
> > > > > > > affected file matched against the regex pattern given in K:. For
> > > > > > > example, if a file has the word "clang" in it then every single patch
> > > > > > > touching that file will to/cc Nick, Nathan and some lists.
> > > > > > > 
> > > > > > > Let's change this behavior to only content match against patches
> > > > > > > (subjects, message, diff) as this is what most people expect the
> > > > > > > behavior already is. Most users of "K:" would prefer patch-only content
> > > > > > > matching. If this is not the case let's add a new matching type as
> > > > > > > proposed in [1].
> > > > > > 
> > > > > > I'm glad to know  you are coming around to my suggestion.
> > > > > :)
> > > > > 
> > > > > > 
> > > > > > I believe the file-based keyword matching should _not_ be
> > > > > > removed and the option should be added for it like I suggested.
> > > > > 
> > > > > Having a command line flag allowing get_maintainer.pl
> > > > > users to decide the behavior of K: is weird to me. If I'm a maintainer setting
> > > > > my K: in MAINTAINERS I want some sort of consistent behavior. Some
> > > > > patches will start hitting mailing list that DO have keywords in the patch
> > > > > and others, confusingly, not.
> > > > 
> > > > Not true.
> > > > 
> > > > If a patch contains a keyword match, get_maintainers will _always_
> > > > show the K: keyword maintainers unless --nokeywords is specified
> > > > on the command line.
> > > 
> > > ...
> > > 
> > > > 
> > > > If a file contains a keyword match, it'll only show the K:
> > > > keyword  if --keywords-in-file is set.
> > > 
> > > Right, what I'm saying is a patch can arrive in a maintainer's inbox
> > > wherein the patch itself has no mention of the keyword (if
> > > get_maintainer user opted for --keywords-in-file). Just trying to
> > > avoid some cases of the question: "Why is this in my inbox?"
> > 
> > Because the script user specifically asked for it.
> > 
> > > > > To note, we get some speed-up here as pattern matching a patch that
> > > > > touches lots of files would result in searching all of them in their
> > > > > entirety. Just removing this behavior _might_ have a measurable
> > > > > speed-up for patch series touching dozens of files.
> > > > 
> > > > Again, not true.
> > > > 
> > > > Patches do _not_ scan the original modified files for keyword matches.
> > > > Only the patch itself is scanned.  That's the current behavior as well.
> > > > 
> > > 
> > > Feel like I'm missing something here. How is K: matching keywords in
> > > files without reading them.
> > > 
> > > If my patch touches 10 files then all 10 of those files are scanned for
> > > K: matches right?
> > 
> > Nope.
> > 
> > Understand the patches are the input to get_maintainer and not
> > just files.
> > 
> > If a patch is fed to get_maintainer then any files modified by
> > the patch are _not_ scanned.
> > 
> > Only the patch _content_ is used for keyword matches.
> > 
> 
> Got it. I'll roll your patch into a v3.
> 

Actually, I have a slightly improved patch as
the actual keyword is shown too.

I'll get it uploaded and make sure you are credited
with the effort to make the change.

cheers, Joe
