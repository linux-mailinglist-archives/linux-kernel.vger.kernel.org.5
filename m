Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5397FDA52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjK2Otf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2Ote (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F91B0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701269380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyLQTp+JLssTFO7PTCnsYpTGzUnGh3A+zjTA8FqixQ4=;
        b=fMQotKFlKEnGDdOFrWspRBrN5pbg8YxlYqllO4uSuaQBjJK02yWi+wDUYff1MnXCnCRfgD
        3QYKDCSAk3jYqotRXutnV91Q5nWlpKu1Rs28xv6EBOrA4N25fdHPo87tcLYaCz+Qxga8Xz
        DryfsuL7loqTg4CjwYnryo63v9ccYjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-WY2o3njJNzC_159Nb6RHdg-1; Wed, 29 Nov 2023 09:49:34 -0500
X-MC-Unique: WY2o3njJNzC_159Nb6RHdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD99C185A782;
        Wed, 29 Nov 2023 14:49:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.161])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 957D4C1596F;
        Wed, 29 Nov 2023 14:49:32 +0000 (UTC)
Date:   Wed, 29 Nov 2023 08:49:31 -0600
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH v3] Documentation: xfs: consolidate XFS docs into its own
 subdirectory
Message-ID: <ZWdPewywDy_3UutV@redhat.com>
References: <20231129123947.4706-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129123947.4706-1-bagasdotme@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 07:39:47PM +0700, Bagas Sanjaya wrote:
> XFS docs are currently in upper-level Documentation/filesystems.
> Although these are currently 4 docs, they are already outstanding as
> a group and can be moved to its own subdirectory.
> 
> Consolidate them into Documentation/filesystems/xfs/.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Looks good to me.
Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

> ---
> Changes since v2 [1]:
> 
>   * Adjust MAINTAINERS pattern to include all docs in the subdirectory
>     by using wildcard.
> 
> [1]: https://lore.kernel.org/linux-doc/20231128124522.28499-1-bagasdotme@gmail.com/
> 
>  Documentation/filesystems/index.rst                |  5 +----
>  Documentation/filesystems/xfs/index.rst            | 14 ++++++++++++++
>  .../{ => xfs}/xfs-delayed-logging-design.rst       |  0
>  .../{ => xfs}/xfs-maintainer-entry-profile.rst     |  0
>  .../{ => xfs}/xfs-online-fsck-design.rst           |  2 +-
>  .../{ => xfs}/xfs-self-describing-metadata.rst     |  0
>  .../maintainer/maintainer-entry-profile.rst        |  2 +-
>  MAINTAINERS                                        |  4 ++--
>  8 files changed, 19 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/filesystems/xfs/index.rst
>  rename Documentation/filesystems/{ => xfs}/xfs-delayed-logging-design.rst (100%)
>  rename Documentation/filesystems/{ => xfs}/xfs-maintainer-entry-profile.rst (100%)
>  rename Documentation/filesystems/{ => xfs}/xfs-online-fsck-design.rst (99%)
>  rename Documentation/filesystems/{ => xfs}/xfs-self-describing-metadata.rst (100%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 09cade7eaefc8c..e18bc5ae3b35f8 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -121,8 +121,5 @@ Documentation for filesystem implementations.
>     udf
>     virtiofs
>     vfat
> -   xfs-delayed-logging-design
> -   xfs-maintainer-entry-profile
> -   xfs-self-describing-metadata
> -   xfs-online-fsck-design
> +   xfs/index
>     zonefs
> diff --git a/Documentation/filesystems/xfs/index.rst b/Documentation/filesystems/xfs/index.rst
> new file mode 100644
> index 00000000000000..ab66c57a5d18ea
> --- /dev/null
> +++ b/Documentation/filesystems/xfs/index.rst
> @@ -0,0 +1,14 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +XFS Filesystem Documentation
> +============================
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> +
> +   xfs-delayed-logging-design
> +   xfs-maintainer-entry-profile
> +   xfs-self-describing-metadata
> +   xfs-online-fsck-design
> diff --git a/Documentation/filesystems/xfs-delayed-logging-design.rst b/Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
> similarity index 100%
> rename from Documentation/filesystems/xfs-delayed-logging-design.rst
> rename to Documentation/filesystems/xfs/xfs-delayed-logging-design.rst
> diff --git a/Documentation/filesystems/xfs-maintainer-entry-profile.rst b/Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> similarity index 100%
> rename from Documentation/filesystems/xfs-maintainer-entry-profile.rst
> rename to Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
> diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> similarity index 99%
> rename from Documentation/filesystems/xfs-online-fsck-design.rst
> rename to Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> index a0678101a7d02d..352516feef6ffe 100644
> --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> @@ -962,7 +962,7 @@ disk, but these buffer verifiers cannot provide any consistency checking
>  between metadata structures.
>  
>  For more information, please see the documentation for
> -Documentation/filesystems/xfs-self-describing-metadata.rst
> +Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
>  
>  Reverse Mapping
>  ---------------
> diff --git a/Documentation/filesystems/xfs-self-describing-metadata.rst b/Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
> similarity index 100%
> rename from Documentation/filesystems/xfs-self-describing-metadata.rst
> rename to Documentation/filesystems/xfs/xfs-self-describing-metadata.rst
> diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
> index 7ad4bfc2cc038a..18cee1edaecb6f 100644
> --- a/Documentation/maintainer/maintainer-entry-profile.rst
> +++ b/Documentation/maintainer/maintainer-entry-profile.rst
> @@ -105,4 +105,4 @@ to do something different in the near future.
>     ../driver-api/media/maintainer-entry-profile
>     ../driver-api/vfio-pci-device-specific-driver-acceptance
>     ../nvme/feature-and-quirk-policy
> -   ../filesystems/xfs-maintainer-entry-profile
> +   ../filesystems/xfs/xfs-maintainer-entry-profile
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea790149af7951..5ad039cfe9c794 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23893,10 +23893,10 @@ S:	Supported
>  W:	http://xfs.org/
>  C:	irc://irc.oftc.net/xfs
>  T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> -P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
> +P:	Documentation/filesystems/xfs/xfs-maintainer-entry-profile.rst
>  F:	Documentation/ABI/testing/sysfs-fs-xfs
>  F:	Documentation/admin-guide/xfs.rst
> -F:	Documentation/filesystems/xfs-*
> +F:	Documentation/filesystems/xfs/*
>  F:	fs/xfs/
>  F:	include/uapi/linux/dqblk_xfs.h
>  F:	include/uapi/linux/fsmap.h
> 
> base-commit: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 

