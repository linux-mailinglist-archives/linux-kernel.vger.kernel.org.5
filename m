Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C669E7A6E73
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjISWMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjISWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:12:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93AACD1;
        Tue, 19 Sep 2023 15:10:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D88C433C8;
        Tue, 19 Sep 2023 22:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695161357;
        bh=mNJJEkIfKj9W2HILl+lOn6Pdlxq4DCZMnfUy6sK8DDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbrPsf+B+yZBdbsAh9kqfi4hmsuEEgu0Hy1Vcsrxs5zmRVN6md+U7CS/wEX8PpRFw
         d4IREE+M0kHyYPph/lKyxviBQVVkDnD6TYI+X9aFNnOpP4gV1BEJWgoq2Q90K93m5w
         Bqthz7C1R/tjAAv3lTp//eIqdIlPaP/HM4Qd+MiWcK4QcTY5TRv8w4PVqPFw4I6PVt
         1SdBd8NacBZawZZCWdLaeaxkBzXPceWqCvsvfnjg8tBiqQN8l/aj2PRwYcqKyi1U6k
         /Txt9KwDS7US+lu4cuhkcvkwzOS25Jc2tVuXbxhlnhYaqONJMj/xYn7RmWs+EjxHcE
         VJrXL3JY3CZ3g==
Date:   Tue, 19 Sep 2023 15:09:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <dchinner@redhat.com>,
        Charles Han <hanchunchao@inspur.com>, corbet@lwn.net,
        allison.henderson@oracle.com, bhelgaas@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Message-ID: <20230919220916.GI348018@frogsfrogsfrogs>
References: <20230918071905.296081-1-hanchunchao@inspur.com>
 <ZQoMqI/QGPWEpkEi@rh>
 <ZQoPaXNAwtu4wl02@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQoPaXNAwtu4wl02@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:15:21PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 20, 2023 at 07:03:36AM +1000, Dave Chinner wrote:
> > [cc linux-xfs@vger.kernel.org]
> > 
> > Hi Charles,
> > 
> > For future reference, can you CC the XFS list on XFS documentation
> > changes please?  That's much preferable to sending patches to random
> > developers and hoping they notice it....
> > 
> > On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
> > > Remove the repeated word "the" in comments.
> > > 
> > > Signed-off-by: Charles Han <hanchunchao@inspur.com>
> > > ---
> > >  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
> 
> To be fair, this new file isn't listed in MAINTAINERS, so
> scripts/get_maintainer.pl doesn't know about it.  May I
> suggest the attached patch?

> From e0eb2f0d1425e6a5dae23c983eb793afa5d040c1 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Tue, 19 Sep 2023 17:12:45 -0400
> Subject: [PATCH] XFS: Update MAINTAINERS to catch all XFS documentation
> 
> Assumes that all XFS documentation will be prefixed with xfs-, which
> seems like a good policy anyway.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bf0f54c24f81..3554195022ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23640,8 +23640,7 @@ T:	git git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>  P:	Documentation/filesystems/xfs-maintainer-entry-profile.rst
>  F:	Documentation/ABI/testing/sysfs-fs-xfs
>  F:	Documentation/admin-guide/xfs.rst
> -F:	Documentation/filesystems/xfs-delayed-logging-design.rst
> -F:	Documentation/filesystems/xfs-self-describing-metadata.rst
> +F:	Documentation/filesystems/xfs-*
>  F:	fs/xfs/
>  F:	include/uapi/linux/dqblk_xfs.h
>  F:	include/uapi/linux/fsmap.h
> -- 
> 2.40.1
> 

