Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFC759A07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjGSPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjGSPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DA71701;
        Wed, 19 Jul 2023 08:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 366D961763;
        Wed, 19 Jul 2023 15:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C52C433C7;
        Wed, 19 Jul 2023 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689781234;
        bh=VHgF1bTcOvcb/8pCRZRg1ZSHoMzSjJRqBK8i/jC32uQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1oGVNf61A0zOzmqRqKK+/H2eLb/Oi9s95XoJnVr5QppcVZiDfnhnJwJthWGIdhlW
         0ys197Oi8jGpOBgLJgWVrBb8pLFcV5Eg22TYbwQ7imLcLSitltQfUmTBwDue2bRLkG
         1B6w7rlz/DNwwNbZ8BmVF5wTCmVroWPDErJdOsHQ=
Date:   Wed, 19 Jul 2023 17:40:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 2/4] fs/9p: fix typo in comparison logic for cache mode
Message-ID: <2023071924-alright-prepaid-e5e4@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-2-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-2-769791f474fd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:17:06PM +0000, Eric Van Hensbergen wrote:
> There appears to be a typo in the comparison statement for the logic
> which sets a file's cache mode based on mount flags.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/fid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
