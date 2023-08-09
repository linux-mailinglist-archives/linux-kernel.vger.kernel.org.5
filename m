Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0CD7752A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjHIGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjHIGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774631FCA;
        Tue,  8 Aug 2023 23:14:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B774262678;
        Wed,  9 Aug 2023 06:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C63CC433C8;
        Wed,  9 Aug 2023 06:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691561650;
        bh=0zMrZj0u6BSryzx0If7FWJOOBvNEMBrRU8O0nHWkQa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSPsTShNQ9GHvAEVs8hKcpm6fmM6ejKuGcT8cPhVoOFdg/gp05NZlaGum91T/UDvG
         u4E77GJsxVig2VeHJkWYoJ3xOW/nYhpzs66uAFPlw9xd1SbNjUKCFJh85k3T7yg6a/
         VTC7Jyh6sb9gHham9O3HsxFgeFucy2Ro/KANwREWNAHIYWQNyDJ/WmEPlBeW6Msodw
         IoCcefDkd0hWjsvUrCWah9eIz/3VtIFdHqDZZVxMDTzYQTcJv49pKswkaWn8x+6SKB
         NpYXUUuZOXa9HYVvmsOxiwNZ0s9mzC/5aAN1GreteOoT1CAl/hEanfW1DDfQwHEPBB
         yXEiDDXmzsJLg==
Date:   Wed, 9 Aug 2023 08:14:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: vfs: clean up after the iterate() removal
Message-ID: <20230809-apparat-eiszeit-a1d57a1a4155@brauner>
References: <874jl945bv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874jl945bv.fsf@meer.lwn.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:00:52PM -0600, Jonathan Corbet wrote:
> Commit 3e3271549670 ("vfs: get rid of old '->iterate' directory operation")
> removed the iterate() file_operations member, but neglected to clean up the
> associated documentation.  Get rid of the leftovers.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
> If nobody objects (or beats me to it) I'll drop this into docs-next
> shortly.

Looks good to me and yes, feel free to take this through docs ofc,
Reviewed-by: Christian Brauner <brauner@kernel.org>

> 
>  Documentation/filesystems/locking.rst | 1 -
>  Documentation/filesystems/vfs.rst     | 7 +------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 0ca479dbb1cd..aeed0a5a80eb 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -509,7 +509,6 @@ prototypes::
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
>  	int (*iopoll) (struct kiocb *kiocb, bool spin);
> -	int (*iterate) (struct file *, struct dir_context *);
>  	int (*iterate_shared) (struct file *, struct dir_context *);
>  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
>  	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index cb2a97e49872..a751f6d01eb2 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1074,7 +1074,6 @@ This describes how the VFS can manipulate an open file.  As of kernel
>  		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
>  		int (*iopoll)(struct kiocb *kiocb, bool spin);
> -		int (*iterate) (struct file *, struct dir_context *);
>  		int (*iterate_shared) (struct file *, struct dir_context *);
>  		__poll_t (*poll) (struct file *, struct poll_table_struct *);
>  		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
> @@ -1126,12 +1125,8 @@ otherwise noted.
>  ``iopoll``
>  	called when aio wants to poll for completions on HIPRI iocbs
>  
> -``iterate``
> -	called when the VFS needs to read the directory contents
> -
>  ``iterate_shared``
> -	called when the VFS needs to read the directory contents when
> -	filesystem supports concurrent dir iterators
> +	called when the VFS needs to read the directory contents
>  
>  ``poll``
>  	called by the VFS when a process wants to check if there is
> -- 
> 2.41.0
> 
