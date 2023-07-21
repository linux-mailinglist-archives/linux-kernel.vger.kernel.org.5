Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC4E75D60D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGUU61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjGUU6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:58:25 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D497D30E1;
        Fri, 21 Jul 2023 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iPT7bUJUv+LkTmcOfbsPCo4EaIDTV5G6zktQKLjq8hg=; b=L6FuFsiarFCR0FP89J++B/EsYO
        Qe/CL36wu38ovPdRWh7nE3gKY4nizQFMnUtMkavqPBu1nS5i2FgLoToFqejbd7rsKI3Idbfr+bP2j
        ujfCqILKiGyXBrXfNyCcrOI6HzoVIE7mjPXm3JTmjbju34uH7/bPZqqS2YbrQqm4W6wEUzLJjV20T
        ArS2fuWEcWMj9eMqXGdtaa9gGp8CuP9YnhSTiDk/ubFH0ty/aSZfw3f/CKrjGkAvDivrWrup0iseX
        W4e8xH486AuI7FfGQQp/JkH6Ky+jVDCSQ0pxk/8xyu7b7nqFGJ8p4alp9muTxkfG27OZaY3fU983K
        Ute2mFfw==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qMxCV-002dPe-W8; Fri, 21 Jul 2023 20:58:12 +0000
Date:   Fri, 21 Jul 2023 20:58:11 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Tom Talpey <tom@talpey.com>
Cc:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Steve French <smfrench@gmail.com>, linkinjeon@kernel.org,
        shaggy@kernel.org, linux-cifs@vger.kernel.org,
        krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Message-ID: <ZLrxYzGXJzsLmGDs@gallifrey>
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
 <ZLhchajZaWEVM6D7@gallifrey>
 <79bbb44c-f3b1-5c5c-1ad4-bcaab0069666@oracle.com>
 <d1f7fbe9-8fe2-e3e3-d6ff-1544204202ff@talpey.com>
 <ZLnJzUynpTBvZGtA@gallifrey>
 <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8f4a2c5-05d3-0b2d-688f-b3274a98fc73@talpey.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 20:56:38 up 15 days,  6:28,  1 user,  load average: 0.17, 0.04, 0.01
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Talpey (tom@talpey.com) wrote:
> On 7/20/2023 7:57 PM, Dr. David Alan Gilbert wrote:
> > * Tom Talpey (tom@talpey.com) wrote:
> > > On 7/19/2023 6:06 PM, Dave Kleikamp wrote:
> > > > On 7/19/23 4:58PM, Dr. David Alan Gilbert wrote:
> > > > > * Steve French (smfrench@gmail.com) wrote:
> > > > > > The related question is which tree to send it from, if no problems
> > > > > > reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
> > > > > > and because there hasn't been activity in fs/nls for years)
> > > > > 
> > > > > That was my hope, given that ~half of the patches are directly on that
> > > > > code, and it's the only very active tree this touches as far as I can
> > > > > tell.
> > > > > 
> > > > > > On Wed, Jul 19, 2023 at 12:56 PM Steve French
> > > > > > <smfrench@gmail.com> wrote:
> > > > > > > 
> > > > > > > No objections to this on my part.  If Shaggy is ok with the JFS
> > > > > > > change, we could target it for 6.6-rc1 if it tests out ok
> > > > 
> > > > For the series:
> > > > Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> > > > 
> > > > Steve,
> > > > Feel free to pull in even the 4th patch into your tree with my consent.
> > > > Or if you're more comfortable, I could submit it after yours hits
> > > > mainline.
> > > > 
> > > > Shaggy
> > > 
> > > The changes look good to me but there is one quirk with the
> > > copyrights and SPDX in patch 2.
> > > 
> > > In the new fs/nls/nls_ucs2_utils.c, the SPDX line changes from
> > > a "/* ... */" form to "// ...", which may be a proper update, but
> > > then partway down, adds the same SPDX in "/* ... */ form. These
> > > should at least be consistent.
> > > 
> > > > +++ b/fs/nls/nls_ucs2_utils.c
> > > > @@ -1,19 +1,25 @@
> > > > -/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > 
> > > vs
> > > 
> > > > +++ b/fs/nls/nls_ucs2_utils.h
> > > > @@ -0,0 +1,297 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > 
> > Yeh that's an easy fix - so that's just the fact the .h has
> > the older /* where I'd fixed up the .c ?
> 
> Yep, for consistency that sounds good.

It does.... and I just fixed up my patches for it, and checkpatch
moans;

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n3737
	if ($realfile =~ /\.(h|s|S)$/) {
		$comment = '/*';
	} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
		$comment = '//';

I don't get where that idea came from.

Dave

> > > Second, the copyright in fs/nls/nls_ucs2_utils.c is a bit of
> > > a mash-up (adding 2009 especially).
> > > 
> > > I think it's better to keep the exact text of both copyrights,
> > > perhaps with a note as to which files had them previously, and
> > > adding some new note/blank line to separate the recent contributions
> > > from Namjae and you from the ancient history.
> > 
> > How about the following;
> > 
> >   * This file has taken chunks from a few other files
> >   * smb/server/uniupr.h had the declaration:
> 
> These two lines above aren't needed, because the lines below
> contain the copyright and where they originated. So just omit
> the two above.
> 
> >   *
> >   *   Some of the source code in this file came from fs/cifs/uniupr.h
> >   *   Copyright (c) International Business Machines  Corp., 2000,2002
> >   *
> >   * fs/smb/server/unicode.c had the declaration:
> 
> And this one above - not needed.
> 
> >   *
> >   *   Some of the source code in this file came from fs/cifs/cifs_unicode.c
> >   *
> >   *   Copyright (c) International Business Machines  Corp., 2000,2009
> >   *   Modified by Steve French (sfrench@us.ibm.com)
> >   *   Modified by Namjae Jeon (linkinjeon@kernel.org)
> >   *
> > 
> > I haven't added the extra line above Namjae's line, since it's now
> > a straight copy from the unicode.c entry.
> 
> Straight copy is what's important. No deletion, no edit in a copyright.
> So, ok.
> 
> > I'm not particularly fussed about adding my own line unless you think
> > it's needed; git keeps better history!
> 
> In fact, since you technically didn't add any code, just deleted,
> moved or renamed, I think it might be best to leave yourself out.
> But, totally your choice.
> 
> Tom.
> 
> > > > +++ b/fs/nls/nls_ucs2_utils.c
> > > > ...
> > > > - *   Some of the source code in this file came from fs/cifs/uniupr.h
> > > > - *   Copyright (c) International Business Machines  Corp., 2000,2002
> > > > - *
> > > > - * uniupr.h - Unicode compressed case ranges
> > > > + *   Some of the source code in this file came from fs/cifs/cifs_unicode.c
> > > > + *   via fs/smb/unicode.c and fs/smb/uniupr.h and fs/cifs/uniupr.h
> > > > + *   Copyright (c) International Business Machines  Corp., 2000,2002,2009
> > > > + *   Modified by Steve French (sfrench@us.ibm.com)
> > > > + *   Modified by Namjae Jeon (linkinjeon@kernel.org)
> > > > + *   Modified by Dr. David Alan Gilbert <linux@treblig.org>
> > > 
> > > Apart from considering these:
> > > 
> > > Reviewed-by: Tom Talpey <tom@talpey.com>
> > 
> > Thanks!
> > 
> > Dave
> > 
> > > Nice work!
> > > 
> > > > > 
> > > > > Thanks.
> > > > > 
> > > > > Dave
> > > > > 
> > > > > > > On Wed, Jul 12, 2023 at 6:28 PM Dr. David Alan Gilbert
> > > > > > > <dave@treblig.org> wrote:
> > > > > > > > 
> > > > > > > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > > > > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > > > > > > > 
> > > > > > > > > The smb client and server code have (mostly) duplicated code
> > > > > > > > > for unicode manipulation, in particular upper case handling.
> > > > > > > > > 
> > > > > > > > > Flatten this lot into shared code.
> > > > > > > > 
> > > > > > > > Gentle two week ping on this please.
> > > > > > > > 
> > > > > > > > Dave
> > > > > > > > 
> > > > > > > > (Apologies to the 3 of you who already got a copy of this ping,
> > > > > > > > recent due to a missing header ',' )
> > > > > > > > 
> > > > > > > > > There's some code that's slightly different between the two, and
> > > > > > > > > I've not attempted to share that - this should be strictly a no
> > > > > > > > > behaviour change set.
> > > > > > > > > 
> > > > > > > > > In addition, the same tables and code are shared in jfs, however
> > > > > > > > > there's very little testing available for the unicode in there,
> > > > > > > > > so just share the raw data tables.
> > > > > > > > > 
> > > > > > > > > I suspect there's more UCS-2 code that can be shared, in the NLS code
> > > > > > > > > and in the UCS-2 code used by the EFI interfaces.
> > > > > > > > > 
> > > > > > > > > Lightly tested with a module and a monolithic build,
> > > > > > > > > and just mounting
> > > > > > > > > itself.
> > > > > > > > > 
> > > > > > > > > This dupe was found using PMD:
> > > > > > > > >     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > > > > > > > > 
> > > > > > > > > Dave
> > > > > > > > > 
> > > > > > > > > Version 2
> > > > > > > > >     Moved the shared code to fs/nls after v1 feedback.
> > > > > > > > >     Renamed shared tables from Smb to Nls prefix
> > > > > > > > >     Move UniStrcat as well
> > > > > > > > >     Share the JFS tables
> > > > > > > > > 
> > > > > > > > > Dr. David Alan Gilbert (4):
> > > > > > > > >     fs/smb: Remove unicode 'lower' tables
> > > > > > > > >     fs/smb: Swing unicode common code from smb->NLS
> > > > > > > > >     fs/smb/client: Use common code in client
> > > > > > > > >     fs/jfs: Use common ucs2 upper case table
> > > > > > > > > 
> > > > > > > > >    fs/jfs/Kconfig               |   1 +
> > > > > > > > >    fs/jfs/Makefile              |   2 +-
> > > > > > > > >    fs/jfs/jfs_unicode.h         |  17 +-
> > > > > > > > >    fs/jfs/jfs_uniupr.c          | 121 -------------
> > > > > > > > >    fs/nls/Kconfig               |   8 +
> > > > > > > > >    fs/nls/Makefile              |   1 +
> > > > > > > > >    fs/nls/nls_ucs2_data.h       |  15 ++
> > > > > > > > >    fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
> > > > > > > > >    fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
> > > > > > > > >    fs/smb/client/Kconfig        |   1 +
> > > > > > > > >    fs/smb/client/cifs_unicode.c |   1 -
> > > > > > > > >    fs/smb/client/cifs_unicode.h | 330
> > > > > > > > > +----------------------------------
> > > > > > > > >    fs/smb/client/cifs_uniupr.h  | 239 -------------------------
> > > > > > > > >    fs/smb/server/Kconfig        |   1 +
> > > > > > > > >    fs/smb/server/unicode.c      |   1 -
> > > > > > > > >    fs/smb/server/unicode.h      | 325
> > > > > > > > > +---------------------------------
> > > > > > > > >    fs/smb/server/uniupr.h       | 268 ----------------------------
> > > > > > > > >    17 files changed, 467 insertions(+), 1293 deletions(-)
> > > > > > > > >    delete mode 100644 fs/jfs/jfs_uniupr.c
> > > > > > > > >    create mode 100644 fs/nls/nls_ucs2_data.h
> > > > > > > > >    create mode 100644 fs/nls/nls_ucs2_utils.c
> > > > > > > > >    create mode 100644 fs/nls/nls_ucs2_utils.h
> > > > > > > > >    delete mode 100644 fs/smb/client/cifs_uniupr.h
> > > > > > > > >    delete mode 100644 fs/smb/server/uniupr.h
> > > > > > > > > 
> > > > > > > > > -- 
> > > > > > > > > 2.41.0
> > > > > > > > > 
> > > > > > > > -- 
> > > > > > > >    -----Open up your eyes, open up your mind, open up your code -------
> > > > > > > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > > > > > > > \        dave @ treblig.org |                               | In Hex /
> > > > > > > >    \ _________________________|_____ http://www.treblig.org   |_______/
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > -- 
> > > > > > > Thanks,
> > > > > > > 
> > > > > > > Steve
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > Thanks,
> > > > > > 
> > > > > > Steve
> > > > 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
