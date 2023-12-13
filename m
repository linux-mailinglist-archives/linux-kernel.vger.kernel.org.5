Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6970810E97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjLMKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjLMKi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:38:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82CDB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:38:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8CFC433C7;
        Wed, 13 Dec 2023 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702463912;
        bh=mOX0bb/Ghlw3wwfWH5n74d2gryvgQgvS90ps961NIUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNH49ZWOQmm9gwW0vJZr+Qrvx1puyT4HLTBbfCaztM43gW04j1oWZA8o9q0CU3ICv
         PVDIhVSpLcJTs87anBZrpEsjfF9HODAy6bf/vAOsyKsX0C23dkOdNBJPR7CNRegrCJ
         ldKD6iBcF/hCqvFAT/mHjm8axnUiVNGuRj/9LqQO7y2pyUK/C1Y+3g/J4O0C2l3zI0
         BoHxn2AxyFP0MIekq6I66dwCdnpdqAvGHjAWHUSy0gh/J6pQ3FjddQlluGM2BfJ01h
         leikwN84SzHR5UiszgPmidW/TVzgawqtq4+jGYITkZr4ObgGByThz5G3hvl1NPgjJA
         lbBVu9Mijl7Nw==
Date:   Wed, 13 Dec 2023 11:38:28 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     syzbot+0c64a8706d587f73409e@syzkaller.appspotmail.com,
        gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [gfs2] WARNING in vfs_utimes
Message-ID: <20231213-drehen-einquartieren-56bbdda1177e@brauner>
References: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABOYnLwGoNXXzvvn+YmCcjLu6ttAJGGTaN8+O_tNdPqcjHnfUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 02:35:58PM +0800, xingwei lee wrote:
> Hello, I reproduced this bug with repro.c and repro.txt since it
> relatively large please see
> https://gist.github.com/xrivendell7/b3b804bbf6d8c9930b2ba22e2dfaa6e6
> 
> Since this bug in the dashboard
> https://syzkaller.appspot.com/bug?extid=0c64a8706d587f73409e use
> kernel commit: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=aed8aee11130a954356200afa3f1b8753e8a9482
> kernel config: https://syzkaller.appspot.com/text?tag=KernelConfig&x=df91a3034fe3f122
> 
> my repro.c use the seem config and it crash report like below, and
> it’s almost can make sure it the same as bug reported by syzobt.

Uh, can you reproduce this on mainline?
I so far fail to even with your repro.
