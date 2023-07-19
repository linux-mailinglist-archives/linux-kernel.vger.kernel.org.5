Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3EF7599FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjGSPkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGSPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70DE47;
        Wed, 19 Jul 2023 08:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EDFF61764;
        Wed, 19 Jul 2023 15:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B56C433C7;
        Wed, 19 Jul 2023 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689781201;
        bh=zY5bS398x+p4X13200NMBqcTChbgpAxmHByrPgj4TII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hk4FhDe1b3I2vPMzMxGNqcd5gx6PRmoCsmsj7FAgkGbQc1cP2TeUs+21DCch8bcZh
         cW39BpMidA8vwqa0rXcNW/QhR7usOy21e++7GphbRvFDnKdTQLxxC41SuiGOqOxj9L
         /QNZJ0TlqJHbyZzVsMj8ef1xZLT8oE7w2LQFJUSQ=
Date:   Wed, 19 Jul 2023 17:39:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 1/4] fs/9p: remove unnecessary and overrestrictive
 check
Message-ID: <2023071940-aground-kilometer-ab18@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-1-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-1-769791f474fd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:17:05PM +0000, Eric Van Hensbergen wrote:
> This eliminates a check for shared that was overrestrictive and
> duplicated a check in generic_file_readonly_mmap.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/vfs_file.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
