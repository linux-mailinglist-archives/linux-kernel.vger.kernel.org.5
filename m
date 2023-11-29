Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B347FCE39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjK2FX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2FXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:23:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF01BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:24:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928D0C433C7;
        Wed, 29 Nov 2023 05:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701235440;
        bh=0RjlCL8ZpHOp9jN53bdGFyIhRGuacuo/NihvRqf9ep8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjkTUBkkvuiepU3/L/B7LqhGvH6OXLqvyWlSpZFV/AYQxim0dYpGTjbAFj6ZsqwaM
         FLDfKb2KpO18FJwoSHsZIjxWVHfdJHUd6l1Djmk/WvFyRfIKF3tdzV4N17LkWlwitl
         NtXM2ZN1l5FEU/tURcGsliHz8ThEokdX1t4UUIVaaWg7ZyxiubI9mpgkI2/8/DokDc
         +1PHXs2LXxiVsAodh8eI3gGJLf1hRxANAntFy3VCQqs8B/sAq9+yGWtqWBlot7r/ix
         y4Fm4IG515HvkMgIEVeGg10JKN0QOISOVDyPQJRA2bHZ82LPkBDVKjK6O0bgqpNCu1
         VUUxRhDooeqaA==
Date:   Tue, 28 Nov 2023 21:24:00 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH RESEND v2] Documentation: xfs: consolidate XFS docs into
 its own subdirectory
Message-ID: <20231129052400.GS4167244@frogsfrogsfrogs>
References: <20231128124522.28499-1-bagasdotme@gmail.com>
 <20231128163255.GV2766956@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128163255.GV2766956@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:32:55AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 28, 2023 at 07:45:22PM +0700, Bagas Sanjaya wrote:
> > XFS docs are currently in upper-level Documentation/filesystems.
> > Although these are currently 4 docs, they are already outstanding as
> > a group and can be moved to its own subdirectory.
> > 
> > Consolidate them into Documentation/filesystems/xfs/.
> > 
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> > Changes since v1 [1]:
> > 
> >   * Also update references to old doc path to address kernel test robot
> >     warnings [2].
> > 
> > [1]: https://lore.kernel.org/linux-doc/20231121095658.28254-1-bagasdotme@gmail.com/
> > [2]: https://lore.kernel.org/linux-doc/a9abc5ec-f3cd-4a1a-81b9-a6900124d38b@gmail.com/
> > 
> >  Documentation/filesystems/index.rst                |  5 +----
> >  Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
> >  .../{ => xfs}/xfs-delayed-logging-design.rst       |  0
> >  .../{ => xfs}/xfs-maintainer-entry-profile.rst     |  0
> >  .../{ => xfs}/xfs-online-fsck-design.rst           |  2 +-
> >  .../{ => xfs}/xfs-self-describing-metadata.rst     |  0
> >  .../maintainer/maintainer-entry-profile.rst        |  2 +-
> >  MAINTAINERS                                        |  4 ++--
> >  8 files changed, 19 insertions(+), 8 deletions(-)
> >  create mode 100644 Documentation/filesystems/xfs/index.rst
> >  rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
> >  rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
> >  rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (99%)
> >  rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)
> 
> I think the rst filename should drop the 'xfs-' prefix, e.g.
> 
> 	Documentation/filesystems/xfs/delayed-logging-design.rst
> 
> since that seems to be what most filesystems do:

Actually, ignore this suggestion.  I forgot that I have vim paths
trained on the Documentation/filesystems/ directory, which means I'll
lose the ability to

:f xfs-online-fsck-design.rst

and pop it open.  Not that I expect many more filesystems to grow online
fsck capabilities, but you get the point...

> Documentation/filesystems/caching/backend-api.rst
> Documentation/filesystems/caching/cachefiles.rst
> Documentation/filesystems/caching/fscache.rst
> Documentation/filesystems/caching/index.rst
> Documentation/filesystems/caching/netfs-api.rst
> Documentation/filesystems/cifs/cifsroot.rst
> Documentation/filesystems/cifs/index.rst
> Documentation/filesystems/cifs/ksmbd.rst
> Documentation/filesystems/ext4/about.rst
> Documentation/filesystems/ext4/allocators.rst
> Documentation/filesystems/ext4/attributes.rst
> <snip>
> Documentation/filesystems/ext4/special_inodes.rst
> Documentation/filesystems/ext4/super.rst
> Documentation/filesystems/ext4/verity.rst
> Documentation/filesystems/nfs/client-identifier.rst
> Documentation/filesystems/nfs/exporting.rst
> Documentation/filesystems/nfs/index.rst
> Documentation/filesystems/nfs/knfsd-stats.rst
> Documentation/filesystems/nfs/nfs41-server.rst
> Documentation/filesystems/nfs/pnfs.rst
> Documentation/filesystems/nfs/reexport.rst
> Documentation/filesystems/nfs/rpc-cache.rst
> Documentation/filesystems/nfs/rpc-server-gss.rst
> Documentation/filesystems/smb/cifsroot.rst
> Documentation/filesystems/smb/index.rst
> Documentation/filesystems/smb/ksmbd.rst
> Documentation/filesystems/spufs/index.rst
> Documentation/filesystems/spufs/spu_create.rst
> Documentation/filesystems/spufs/spufs.rst
> Documentation/filesystems/spufs/spu_run.rst
> 
> > diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> > index 09cade7eaefc8c..e18bc5ae3b35f8 100644
> > --- a/Documentation/filesystems/index.rst
> > +++ b/Documentation/filesystems/index.rst
> > @@ -121,8 +121,5 @@ Documentation for filesystem implementations.
> >     udf
> >     virtiofs
> >     vfat
> > -   xfs-delayed-logging-design
> > -   xfs-maintainer-entry-profile
> > -   xfs-self-describing-metadata
> > -   xfs-online-fsck-design
> > +   xfs/index
> >     zonefs
> > diff --git a/Documentation/filesystems/xfs/index.rst b/Documentation/filesystems/xfs/index.rst
> > new file mode 100644
> > index 00000000000000..ab66c57a5d18ea
> > --- /dev/null
> > +++ b/Documentation/filesystems/xfs/index.rst
> > @@ -0,0 +1,14 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============================
> > +XFS Filesystem Documentation
> > +============================
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +   :numbered:
> > +
> > +   xfs-delayed-logging-design
> > +   xfs-maintainer-entry-profile
> > +   xfs-self-describing-metadata
> > +   xfs-online-fsck-design
> > diff --git a/Documentation/filesystems/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
> > similarity index 100%
> > rename from Documentation/filesystems/xfs-delayed-logging-design.rst
> > rename to Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
> > diff --git a/Documentation/filesystems/xfs-maintainer-entry-profile.rst b/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> > similarity index 100%
> > rename from Documentation/filesystems/xfs-maintainer-entry-profile.rst
> > rename to Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > similarity index 99%
> > rename from Documentation/filesystems/xfs-online-fsck-design.rst
> > rename to Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > index a0678101a7d02d..352516feef6ffe 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > @@ -962,7 +962,7 @@ disk, but these buffer verifiers cannot provide any consistency checking
> >  between metadata structures.
> >  
> >  For more information, please see the documentation for
> > -Documentation/filesystems/xfs-self-describing-metadata.rst
> > +Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
> >  
> >  Reverse Mapping
> >  ---------------
> > diff --git a/Documentation/filesystems/xfs-self-describing-metadata.rst b/Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
> > similarity index 100%
> > rename from Documentation/filesystems/xfs-self-describing-metadata.rst
> > rename to Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
> > diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
> > index 7ad4bfc2cc038a..18cee1edaecb6f 100644
> > --- a/Documentation/maintainer/maintainer-entry-profile.rst
> > +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> > @@ -105,4 +105,4 @@ to do something different in the near future.
> >     ../driver-api/media/maintainer-entry-profile
> >     ../driver-api/vfio-pci-device-specific-driver-acceptance
> >     ../nvme/feature-and-quirk-policy
> > -   ../filesystems/xfs-maintainer-entry-profile
> > +   ../filesystems/xfs/xfs-maintainer-entry-profile
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea790149af7951..fd288ac57e19fb 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23893,10 +23893,10 @@ S:	Supported
> >  W:	http://xfs.org/
> >  C:	irc://irc.oftc.net/xfs
> >  T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > -P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
> > +P:	Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> >  F:	Documentation/ABI/testing/sysfs-fs-xfs
> >  F:	Documentation/admin-guide/xfs.rst
> > -F:	Documentation/filesystems/xfs-*
> > +F:	Documentation/filesystems/xfs/xfs-*
> 
> Shouldn't this be "Documentation/filesystems/xfs/*" ?

...though this suggestion remains standing.

--D

> --D
> 
> >  F:	fs/xfs/
> >  F:	include/uapi/linux/dqblk_xfs.h
> >  F:	include/uapi/linux/fsmap.h
> > 
> > base-commit: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02
> > -- 
> > An old man doll... just what I always wanted! - Clara
> > 
> > 
> 
