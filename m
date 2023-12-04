Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058B680327A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343797AbjLDMWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLDMWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:22:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA402FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:22:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282F2C433C7;
        Mon,  4 Dec 2023 12:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701692538;
        bh=pzjF4BiZqDIILVuK6wtq+QRLEZJMUkFd/A1HbQe9doo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhjQhDYiq+QfWkSXH7X+Aw3zPQoZ31scwTt/oRP2n9WLBgi7hpxU0qfZ6Jp+K1yUB
         CgK0nP2oZDFco3kXqGYjDjMkAgwPp+hNOBsuyRTusUnygF0uJf/n2lG1CLGQHcpAOo
         nzqAeXF+t8eIYDDdg9zsESqeyWQm7JyDjqfn8HGk=
Date:   Mon, 4 Dec 2023 08:20:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs/kernfs/dir: obey S_ISGID
Message-ID: <2023120424-siren-catlike-eb00@gregkh>
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
 <20231201125638.1699026-2-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125638.1699026-2-max.kellermann@ionos.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:56:38PM +0100, Max Kellermann wrote:
> Handling of S_ISGID is usually done by inode_init_owner() in all other
> filesystems, but kernfs doesn't use that function.  In kernfs, struct
> kernfs_node is the primary data structure, and struct inode is only
> created from it on demand.  Therefore, inode_init_owner() can't be
> used and we need to imitate its behavior.
> 
> S_ISGID support is useful for the cgroup filesystem; it allows
> subtrees managed by an unprivileged process to retain a certain owner
> gid, which then enables sharing access to the subtree with another
> unprivileged process.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/kernfs/dir.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

I only see patch 2/2 here, what happened to patch 1/2?

Please send them as a full series, otherwise I don't know what to do
with just this one.

thanks,

greg k-h
