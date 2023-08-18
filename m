Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE94A7814C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjHRV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbjHRV3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1066F2D7D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A233D66C39
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 21:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCFEC433C7;
        Fri, 18 Aug 2023 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692394159;
        bh=Ld7OvNcBpdhDtYB6f5Vz2x6nCNmcy7lhHr3Kic6B/hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CdAbnkEQIJAwW5HV+oFMSJO1NKurSvFQc7LHdf1Z/6mDnoRZIVDanq6kS+jJsqRVc
         Z1M7/HZubi/mWQOxJHILU90DflKCD4Dn5/L+ommWPPE61ri1u3l0srGwGVpBBzfd4S
         nwS3G++AYJ4wo19KPjkwIoX4EkrJY4i6aIQsdFi6I+pBPE72jm0xfowSpzZgBVFZ7V
         QaAfW2d86sj8T5ODEF+qLmkKmk+3u5l7YNrNyCkjSbgf1xsVZNmE9rLa4ztIvUI9s0
         YYmzhsS39Z+922hMPLTUTVuq5Wi9IE6RjlOYQSyeMMX4V6Hbt0LpA0oj479R1HDHW6
         5iMHHxtG4jSNw==
Date:   Fri, 18 Aug 2023 14:29:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: doc: fix description of max_small_discards
Message-ID: <ZN/ira/IW3Qm6NvY@google.com>
References: <20230730142552.3918623-1-chao@kernel.org>
 <90ccff97-5c2e-3dd0-8f96-05c6f3402334@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ccff97-5c2e-3dd0-8f96-05c6f3402334@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me apply this and see what'll happen later, since no luck to reproduce.

On 08/17, Chao Yu wrote:
> Ping,
> 
> On 2023/7/30 22:25, Chao Yu wrote:
> > The description of max_small_discards is out-of-update in below two
> > aspects, fix it.
> > - it is disabled by default
> > - small discards will be issued during checkpoint
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index ad3d76d37c8b..36c3cb547901 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -102,9 +102,9 @@ What:		/sys/fs/f2fs/<disk>/max_small_discards
> >   Date:		November 2013
> >   Contact:	"Jaegeuk Kim" <jaegeuk.kim@samsung.com>
> >   Description:	Controls the issue rate of discard commands that consist of small
> > -		blocks less than 2MB. The candidates to be discarded are cached until
> > -		checkpoint is triggered, and issued during the checkpoint.
> > -		By default, it is disabled with 0.
> > +		blocks less than 2MB. The candidates to be discarded are cached during
> > +		checkpoint, and issued by issue_discard thread after checkpoint.
> > +		It is enabled by default.
> >   What:		/sys/fs/f2fs/<disk>/max_ordered_discard
> >   Date:		October 2022
