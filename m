Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033E475A0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGSV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSV6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 17:58:46 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AD1FD9;
        Wed, 19 Jul 2023 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tQUQ8g2wvWfKqdq3ImlkFFwsTm+NbJDjAHJb9sGdEtY=; b=dhAPLaMaI6nD2w8TZ4h6p+i4KR
        8KK1CUw3yQncFjznKaVcz8gqM70x0vdh4L+jOFcgju+lkxzeb/Rksunzyw3G36/J/KXAlbgkEqdU4
        m2Qyo07acB1+rFDB3BQIfQYQAbrnQbEuz5EptkUGStU3rq438befzjUA4KiOd2aygzL/8KnpZOOys
        m0/cptotXKTSZN6jc3XsNEt4pjNhBgJY0GAE9+PgrvVSx8QKmVTp1dObkNrnN4mKJ1bV+HpeyH8mN
        9ckTMIv3aOEm2xipzPnQ/q/zEVtDpZDzcWuKa4bBN1M1cXdZA2uPBf0MmF6BAByOhb3vH3NKYBwG8
        apHt2w6A==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qMFBl-002EwK-41; Wed, 19 Jul 2023 21:58:29 +0000
Date:   Wed, 19 Jul 2023 21:58:29 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Steve French <smfrench@gmail.com>
Cc:     linkinjeon@kernel.org, tom@talpey.com, dave.kleikamp@oracle.com,
        shaggy@kernel.org, linux-cifs@vger.kernel.org,
        krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] dedupe smb unicode files
Message-ID: <ZLhchajZaWEVM6D7@gallifrey>
References: <20230628232417.120844-1-linux@treblig.org>
 <ZK80mu/YbHLEABAB@gallifrey>
 <CAH2r5mvrhr52hXFv87O9O=Qw45AXRXr0NQAsTk4Wj-6s19-2bA@mail.gmail.com>
 <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mss4RsEF1b6gJo8LFWsN9-YBSEP6GV7axsNhX7ihj5CqA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 21:57:15 up 13 days,  7:28,  1 user,  load average: 0.09, 0.02, 0.00
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

* Steve French (smfrench@gmail.com) wrote:
> The related question is which tree to send it from, if no problems
> reported (presumably mine since it mostly affect cifs.ko and ksmbd.ko,
> and because there hasn't been activity in fs/nls for years)

That was my hope, given that ~half of the patches are directly on that
code, and it's the only very active tree this touches as far as I can
tell.

> On Wed, Jul 19, 2023 at 12:56 PM Steve French <smfrench@gmail.com> wrote:
> >
> > No objections to this on my part.  If Shaggy is ok with the JFS
> > change, we could target it for 6.6-rc1 if it tests out ok

Thanks.

Dave

> > On Wed, Jul 12, 2023 at 6:28 PM Dr. David Alan Gilbert <dave@treblig.org> wrote:
> > >
> > > * linux@treblig.org (linux@treblig.org) wrote:
> > > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > >
> > > > The smb client and server code have (mostly) duplicated code
> > > > for unicode manipulation, in particular upper case handling.
> > > >
> > > > Flatten this lot into shared code.
> > >
> > > Gentle two week ping on this please.
> > >
> > > Dave
> > >
> > > (Apologies to the 3 of you who already got a copy of this ping,
> > > recent due to a missing header ',' )
> > >
> > > > There's some code that's slightly different between the two, and
> > > > I've not attempted to share that - this should be strictly a no
> > > > behaviour change set.
> > > >
> > > > In addition, the same tables and code are shared in jfs, however
> > > > there's very little testing available for the unicode in there,
> > > > so just share the raw data tables.
> > > >
> > > > I suspect there's more UCS-2 code that can be shared, in the NLS code
> > > > and in the UCS-2 code used by the EFI interfaces.
> > > >
> > > > Lightly tested with a module and a monolithic build, and just mounting
> > > > itself.
> > > >
> > > > This dupe was found using PMD:
> > > >   https://pmd.github.io/pmd/pmd_userdocs_cpd.html
> > > >
> > > > Dave
> > > >
> > > > Version 2
> > > >   Moved the shared code to fs/nls after v1 feedback.
> > > >   Renamed shared tables from Smb to Nls prefix
> > > >   Move UniStrcat as well
> > > >   Share the JFS tables
> > > >
> > > > Dr. David Alan Gilbert (4):
> > > >   fs/smb: Remove unicode 'lower' tables
> > > >   fs/smb: Swing unicode common code from smb->NLS
> > > >   fs/smb/client: Use common code in client
> > > >   fs/jfs: Use common ucs2 upper case table
> > > >
> > > >  fs/jfs/Kconfig               |   1 +
> > > >  fs/jfs/Makefile              |   2 +-
> > > >  fs/jfs/jfs_unicode.h         |  17 +-
> > > >  fs/jfs/jfs_uniupr.c          | 121 -------------
> > > >  fs/nls/Kconfig               |   8 +
> > > >  fs/nls/Makefile              |   1 +
> > > >  fs/nls/nls_ucs2_data.h       |  15 ++
> > > >  fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
> > > >  fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
> > > >  fs/smb/client/Kconfig        |   1 +
> > > >  fs/smb/client/cifs_unicode.c |   1 -
> > > >  fs/smb/client/cifs_unicode.h | 330 +----------------------------------
> > > >  fs/smb/client/cifs_uniupr.h  | 239 -------------------------
> > > >  fs/smb/server/Kconfig        |   1 +
> > > >  fs/smb/server/unicode.c      |   1 -
> > > >  fs/smb/server/unicode.h      | 325 +---------------------------------
> > > >  fs/smb/server/uniupr.h       | 268 ----------------------------
> > > >  17 files changed, 467 insertions(+), 1293 deletions(-)
> > > >  delete mode 100644 fs/jfs/jfs_uniupr.c
> > > >  create mode 100644 fs/nls/nls_ucs2_data.h
> > > >  create mode 100644 fs/nls/nls_ucs2_utils.c
> > > >  create mode 100644 fs/nls/nls_ucs2_utils.h
> > > >  delete mode 100644 fs/smb/client/cifs_uniupr.h
> > > >  delete mode 100644 fs/smb/server/uniupr.h
> > > >
> > > > --
> > > > 2.41.0
> > > >
> > > --
> > >  -----Open up your eyes, open up your mind, open up your code -------
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> > > \        dave @ treblig.org |                               | In Hex /
> > >  \ _________________________|_____ http://www.treblig.org   |_______/
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
> 
> 
> 
> --
> Thanks,
> 
> Steve
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
