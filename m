Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9575E275
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGWOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 10:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGWOLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 10:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0BB10E2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 07:11:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CD8760D33
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A667BC433C9;
        Sun, 23 Jul 2023 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690121481;
        bh=inYvgvKYYJKNx3G4HfgycJVN9oLGjVwFXM3dGHFeqd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPHBHCRlCnA5dZ01QK1CJwDW0sYEr0Hkx64TQaYkm97FgCTFaOJviESO5NY+sT4ou
         vSzvxxsMO5dpO13IIILC1hiVc2jNbHJjH6i52um+ZZ8HTjFHZC5lvFBV2asCAOwE8R
         pBVby2by/FQB5dAorgBi81MHWCFF97d8N1RaXO/Q=
Date:   Sun, 23 Jul 2023 16:11:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksei Filippov <halip0503@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: Re: [PATCH v4] jfs: validate max amount of blocks before allocation.
Message-ID: <2023072336-seventy-untangled-cbba@gregkh>
References: <2023072335-penniless-coleslaw-3aac@gregkh>
 <20230723135822.5362-1-halip0503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723135822.5362-1-halip0503@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 04:58:22PM +0300, Aleksei Filippov wrote:
> From: Alexei Filippov <halip0503@gmail.com>
> 
> The lack of checking bmp->db_max_freebud in extBalloc() can lead to
> shift out of bounds, so this patch prevents undefined behavior, because
> bmp->db_max_freebud == -1 only if there is no free space.
> 
> Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
> ---
> Changes:
> Fix commit message.
>  fs/jfs/jfs_extent.c | 5 +++++
>  1 file changed, 5 insertions(+)

{sigh}

Please, take some time, read the documentation for how to do this
correctly.  Wait a day, and then submit it again, properly.

Also, do you have a jfs system?  Isn't this filesystem obsolete?

thanks,

greg k-h
