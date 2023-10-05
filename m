Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045617BA952
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjJESml convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJESmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:42:39 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E390
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:42:38 -0700 (PDT)
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 6F96E16036E;
        Thu,  5 Oct 2023 18:42:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 8A6E017;
        Thu,  5 Oct 2023 18:42:35 +0000 (UTC)
Message-ID: <a8b680c03379ed7a07418e471b29dccd801f23cb.camel@perches.com>
Subject: Re: [PATCH] get_maintainer/MAINTAINERS: confine K content matching
 to patches
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 05 Oct 2023 11:42:34 -0700
In-Reply-To: <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com>
References: <20231004-get_maintainer_change_k-v1-1-ac7ced18306a@google.com>
         <3dca40b677dd2fef979a5a581a2db91df2c21801.camel@perches.com>
         <CAFhGd8oTHFDQ05M++E3ggAvs0567w5fSxovumX+vs8YXT8VXTA@mail.gmail.com>
         <6e13b9b1a964b49079a2f7814c0d65e767cd010a.camel@perches.com>
         <CAFhGd8rGr3fm-U3XCjRkJQRymvjqGFYzsPu61zbMZCebuN5Rww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8A6E017
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: w8mj68fryjwryhs3fkh9tf17urrmqt17
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18oXDOar4yt/N47eD+kR2UEjSpoU58Ncrk=
X-HE-Tag: 1696531355-289661
X-HE-Meta: U2FsdGVkX1+OC5I/6ZzcTiD5ckMsUG1NYzK05bfBylbiVdadYx9BgOuEII2PNGkPhaxwIx5ilLbuAeCAxrDTNwXvzBW3f69IY4krfo9il/NxW2g+zDxET3UZUpHvcnATaaX9YJEvchL2IQaZvey025uhtk+0ZXwBg7zULO4nCsFe3yccstvucoFCxsozA0gqMPVTTL16r65NPmRoUGn2PR7QB9bhXZ/fDMNbAWI2wAGd+DBEAdN12st/32zvOmTpHYiky3xV7QWyGT0F3lR7tFF2TGKjXIRVqf7tH7zSB4LoPx/xBbqPrDYVxgNLNU+GT8xGG0e5+Fsr9H/IeBieybFqToccfnekq1mYxHxUECR41vaISuiFqcvNHf9LrEjy
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-05 at 11:30 -0700, Justin Stitt wrote:
> On Thu, Oct 5, 2023 at 11:15 AM Joe Perches <joe@perches.com> wrote:
> > 
> > On Thu, 2023-10-05 at 11:06 -0700, Justin Stitt wrote:
> > > On Wed, Oct 4, 2023 at 7:40 PM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > On Wed, 2023-10-04 at 21:21 +0000, Justin Stitt wrote:
> > > > > The current behavior of K: is a tad bit noisy. It matches against the
> > > > > entire contents of files instead of just against the contents of a
> > > > > patch.
> > > > > 
> > > > > This means that a patch with a single character change (fixing a typo or
> > > > > whitespace or something) would still to/cc maintainers and lists if the
> > > > > affected file matched against the regex pattern given in K:. For
> > > > > example, if a file has the word "clang" in it then every single patch
> > > > > touching that file will to/cc Nick, Nathan and some lists.
> > > > > 
> > > > > Let's change this behavior to only content match against patches
> > > > > (subjects, message, diff) as this is what most people expect the
> > > > > behavior already is. Most users of "K:" would prefer patch-only content
> > > > > matching. If this is not the case let's add a new matching type as
> > > > > proposed in [1].
> > > > 
> > > > I'm glad to know  you are coming around to my suggestion.
> > > :)
> > > 
> > > > 
> > > > I believe the file-based keyword matching should _not_ be
> > > > removed and the option should be added for it like I suggested.
> > > 
> > > Having a command line flag allowing get_maintainer.pl
> > > users to decide the behavior of K: is weird to me. If I'm a maintainer setting
> > > my K: in MAINTAINERS I want some sort of consistent behavior. Some
> > > patches will start hitting mailing list that DO have keywords in the patch
> > > and others, confusingly, not.
> > 
> > Not true.
> > 
> > If a patch contains a keyword match, get_maintainers will _always_
> > show the K: keyword maintainers unless --nokeywords is specified
> > on the command line.
> 
> ...
> 
> > 
> > If a file contains a keyword match, it'll only show the K:
> > keyword  if --keywords-in-file is set.
> 
> Right, what I'm saying is a patch can arrive in a maintainer's inbox
> wherein the patch itself has no mention of the keyword (if
> get_maintainer user opted for --keywords-in-file). Just trying to
> avoid some cases of the question: "Why is this in my inbox?"

Because the script user specifically asked for it.

> > > To note, we get some speed-up here as pattern matching a patch that
> > > touches lots of files would result in searching all of them in their
> > > entirety. Just removing this behavior _might_ have a measurable
> > > speed-up for patch series touching dozens of files.
> > 
> > Again, not true.
> > 
> > Patches do _not_ scan the original modified files for keyword matches.
> > Only the patch itself is scanned.  That's the current behavior as well.
> > 
> 
> Feel like I'm missing something here. How is K: matching keywords in
> files without reading them.
> 
> If my patch touches 10 files then all 10 of those files are scanned for
> K: matches right?

Nope.

Understand the patches are the input to get_maintainer and not
just files.

If a patch is fed to get_maintainer then any files modified by
the patch are _not_ scanned.

Only the patch _content_ is used for keyword matches.

