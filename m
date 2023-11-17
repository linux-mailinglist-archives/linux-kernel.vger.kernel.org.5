Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8107EF597
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjKQPsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjKQPsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:48:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34299A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:48:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D22C433C8;
        Fri, 17 Nov 2023 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700236085;
        bh=iDn1ilq24Nw2UhEOzSj9ioh4lMDDBSXuQ5k5enzYlkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hcab/2ZunhI2WwBM2Zp2m/C9Y9W9EPWXnlBJkweDTV6uEjnq90odDd8crcUCoike7
         epQzNqJTvHbRE52Gb4pZJd5nrv93QFkCA7eBWRb5ZWY56LNp8GKDFJHZkg+Hfp152E
         DPV3F7/gEZ/DL4jqXJifiMb1OiPQ6aJ+J07881ZU=
Date:   Fri, 17 Nov 2023 07:48:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+604424eb051c2f696163@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        phillip@squashfs.org.uk, squashfs-devel@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Message-Id: <20231117074804.d475cadb2c5adbcbdb28f679@linux-foundation.org>
In-Reply-To: <b28b25ab-87eb-4905-855a-7809dda11f39@samsung.com>
References: <000000000000b1fda20609ede0d1@google.com>
        <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
        <CGME20231117131718eucas1p13328b32942cce99a99197eb28e14a981@eucas1p1.samsung.com>
        <b28b25ab-87eb-4905-855a-7809dda11f39@samsung.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 14:17:17 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> > Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
> > Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> 
> This patch, merged to linux-next as commit 1ff947abe24a ("squashfs: fix 
> oob in squashfs_readahead"), breaks mounting squashfs volumes on all my 
> test systems. Let me know if you need more information to debug this issue.

Thanks.  The patch has been dropped.
