Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD867FDC4C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjK2QNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjK2QNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:13:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B0A10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:13:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F11C433C8;
        Wed, 29 Nov 2023 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701274409;
        bh=p+RQX74HwwmDvDtwcup4EpjJ5YUNoNydNJ2G0J9Vk7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MtBFHGVor1ZjdSoE6YY61j93TqDWBS7haGxokvvjSnzxe/6C3jAuiaUZkM0AeHx0t
         kLES4PgMni59ge3NXU9AicqBF3GO5S+C+JoxHazk6gOv9iEv9M/DmOaps6rCMkTQpj
         8JM38jGgoV6gSvVMMsLk9i2SO79lo0M9ApmpSFj40yE6uo68NqlSAYKHPgnmUvS9n9
         kN1PI/mih9b447Oo4tpqHwLE/JmppqKQYKZniubEnVzaKYDBBXKz2exiqj6jvozHd8
         p/B29PszXrO5hUzyT9wUiirdSNIDkVFOEEuqE9fP9wzavr7mjrk7LNh+hCzVRV3wJ+
         G/lLrabyGQXyg==
Date:   Wed, 29 Nov 2023 08:13:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux XFS <linux-xfs@vger.kernel.org>,
        Linux Kernel Workflows <workflows@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Chandan Babu R <chandan.babu@oracle.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Charles Han <hanchunchao@inspur.com>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH RESEND v2] Documentation: xfs: consolidate XFS docs into
 its own subdirectory
Message-ID: <20231129161329.GV36211@frogsfrogsfrogs>
References: <20231128124522.28499-1-bagasdotme@gmail.com>
 <20231128163255.GV2766956@frogsfrogsfrogs>
 <20231129052400.GS4167244@frogsfrogsfrogs>
 <ZWdilJHU2RqMwBUW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdilJHU2RqMwBUW@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:11:00PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 28, 2023 at 09:24:00PM -0800, Darrick J. Wong wrote:
> > Actually, ignore this suggestion.  I forgot that I have vim paths
> > trained on the Documentation/filesystems/ directory, which means I'll
> > lose the ability to
> > 
> > :f xfs-online-fsck-design.rst
> > 
> > and pop it open.  Not that I expect many more filesystems to grow online
> > fsck capabilities, but you get the point...
> 
> Wouldn't you instead do:
> 
> :f xfs/online-fsck-design.rst
> 
> ie change one character (- to /)

No, I'd change the vim paths to Documentation/xfs/ because I don't
need quick :find support for the rest of the kernel documentation.

--D
