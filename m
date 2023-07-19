Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A2D7599FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjGSPkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjGSPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F110D2;
        Wed, 19 Jul 2023 08:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D2FC61763;
        Wed, 19 Jul 2023 15:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E25EC433C8;
        Wed, 19 Jul 2023 15:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689781214;
        bh=xNbruBqmHsICY//n4TOvdUjRXvhkYlxcSQDGD+e21c4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHlNWkFcwitKAVo5hGU1MQPh43L+YzWTNceZAIJj8J5IKkL50VqCb548IO/i3jXrM
         SNIyVlZsqHP0VGIKwqwcYdn8hCz1ymnn/RTtk+oWuH2IqgoIGh326IqJPGTB6GnUmX
         EN/EEglt2v9y5rXLe9VoXyZr3uxP8ZcP0aNsGeD0=
Date:   Wed, 19 Jul 2023 17:40:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH v3 4/4] fs/9p: remove unnecessary invalidate_inode_pages2
Message-ID: <2023071902-dropkick-deity-0f6f@gregkh>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v3-4-769791f474fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-4-769791f474fd@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:17:08PM +0000, Eric Van Hensbergen wrote:
> There was an invalidate_inode_pages2
> added to mmap that is unnecessary.
> 
> Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
> Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
> Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
> Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> ---
>  fs/9p/vfs_file.c | 1 -
>  1 file changed, 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
