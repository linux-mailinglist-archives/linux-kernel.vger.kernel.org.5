Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2BE75DD24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGVPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGVPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:16:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27A4269D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 08:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A8B260B87
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455AC433C8;
        Sat, 22 Jul 2023 15:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690038990;
        bh=+hYeT7T6DPZwTEKQlR3didhb4Jvj3drMs0VzlG3/1lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVdEekTxnTGAjwNai5zOnPmJ0F9Ybo4oPV4rfmkHNHALbj0Ff4R7UlK6FmR4nnUHL
         zIDhL1Ngn4CMukxGzQI5q90pkDfpQ16ad1TzMC1ne91tKpVRQPON7BiCKEj4UGpEKr
         9FgXWrRWZ+HPUJ8HPDdHt5lRWg9Xnal7U6pWMiBg=
Date:   Sat, 22 Jul 2023 17:16:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksei Filippov <halip0503@gmail.com>
Cc:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: validate max amount of blocks before allocation.
Message-ID: <2023072251-spokesman-zebra-908d@gregkh>
References: <20230722142401.71257-1-halip0503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722142401.71257-1-halip0503@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 05:24:01PM +0300, Aleksei Filippov wrote:
> From: Alexei Filippov <halip0503@gmail.com>
> 
> The lack of checking bmp->db_max_freebud in extBalloc() can lead to
> shift out of bounds, so this patch prevents undefined behavior,
> because bmp->db_max_freebud == -1 only if there
> is no free space.

Please wrap at 72 columns properly.


> 
> Signed-off-by: Aleksei Filippov <halip0503@gmail.com>
> Reported-and-tested-by: syzbot+5f088f29593e6b4c8db8@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=01abadbd6ae6a08b1f1987aa61554c6b3ac19ff2
> ---
>  fs/jfs/jfs_extent.c | 5 +++++
>  1 file changed, 5 insertions(+)

What commit id does this fix?

Is it needed for stable kernels?  If so, please tag it as such.

thanks,

greg k-h
