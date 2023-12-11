Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0080DB28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbjLKT6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344862AbjLKT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:58:00 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF070C4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:58:05 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E98DD3F043
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702324682;
        bh=6Elw3RSA8ypj0e2taUSUQHrh6YXprm2vvCPOxvcU7vE=;
        h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Type;
        b=CdlMZT/2iK6TADOSKZR6ivNNjaBTs2UUFoR8bYiJmtYZuc8ZdBRHkQiDJYxTNYKJ6
         h9mBetNZagihjGIzQiLKK6eNtpxWnH6omsJ6OcS0ED5mUZ74tKWQFKKq+hsjvayEOn
         e7AmaFTXtsPd3BSbKRwJugIN+t8tlA01kCWnIGPx32g6NmR0Hw4Wcjjmt9agIfkc2j
         8cZDte+fF+h3KYZKD/QL2vjE899U18RVW6ehjsrG0SPMWxOx5R3FNHuxJGUFbktsYB
         k2Wolpl0/+dfvcC2v6Uw+K/Bs1PGSQPf0yp8mtXSd0gje+oGrfeuRTxgtaeSfQQI2C
         mGmVKHMTa05FQ==
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ca31b054e4so37023601fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702324682; x=1702929482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Elw3RSA8ypj0e2taUSUQHrh6YXprm2vvCPOxvcU7vE=;
        b=ev6JsbYbbTrEkJutyuxSi/45jmUZaSJT5ZOd0G2AoBN5E0p6r5IK9xIIGcGl9vWI+b
         Ex2sXoHtUuEnxr/moqOj/PyMz5IVghTu6gWFDpx32KpGJn266YAaU+f/MWTcMt05ZwsX
         +Ikj2+hyIRalEMKO3zE3/zxdLUmuS8oGGhUB7z0LMZ8kFkNUSC4sL86sEJbGLyWwd1Qu
         xs3AEDmYi55s+nS4VKzNTjUoCrp0VYemnnOjMfVIb5PF8vhFl8q7yZmLUhhwQsxR3AVt
         NvSYymNbZLpBAUV7zXUVSYLq/tY4FzGXS7/p3zbh0/rDk2xaQh1/ElIGX3nwSQagTY4q
         CzmA==
X-Gm-Message-State: AOJu0Yz3zpMw3sAPTeXmizcbkezDcZmUMTLC/TeW6Hwwhnh7yZOCKgYW
        yV9WvJzj/h1aVd51VqrD7ANan0NpHZ9nJ+TOvVqTxyXe3llzIejfOtutkT8kioLaSur4EPdyv6L
        XExPAgDpwuNa64ZOZVDicLS/y7qedT6BQnh3L4ecfuA==
X-Received: by 2002:a2e:97d1:0:b0:2ca:2ab0:dd90 with SMTP id m17-20020a2e97d1000000b002ca2ab0dd90mr2360771ljj.95.1702324682377;
        Mon, 11 Dec 2023 11:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/CeO1FipLyO3ou+j9WJbzET82MGfv33wpWQkCffuQeoBR3m0RHQhFECwBnvhAAzM/3FYVeQ==
X-Received: by 2002:a2e:97d1:0:b0:2ca:2ab0:dd90 with SMTP id m17-20020a2e97d1000000b002ca2ab0dd90mr2360764ljj.95.1702324682026;
        Mon, 11 Dec 2023 11:58:02 -0800 (PST)
Received: from amikhalitsyn ([2a02:8109:8624:a300:8a21:8f36:2e85:27a6])
        by smtp.gmail.com with ESMTPSA id r10-20020a508d8a000000b0054cb88a353dsm3918472edh.14.2023.12.11.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 11:58:01 -0800 (PST)
Date:   Mon, 11 Dec 2023 20:57:59 +0100
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     Andrei Vagin <avagin@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        brauner@kernel.org
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in
 /proc/pid/maps
Message-Id: <20231211205759.583ca1ff4ea510061068027f@canonical.com>
In-Reply-To: <20231211193048.580691-1-avagin@google.com>
References: <20231211193048.580691-1-avagin@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 11:30:47 -0800
Andrei Vagin <avagin@google.com> wrote:

> Device and inode numbers in /proc/pid/maps have to match numbers returned by
> statx for the same files.
> 
> /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here is
> an issue. If a mapped file is on a stackable file system (e.g.,
> overlayfs), vma->vm_file is a backing file whose f_inode is on the
> underlying filesystem. To show correct numbers, we need to get a user
> file and shows its numbers. The same trick is used to show file paths in
> /proc/pid/maps.
> 
> But it isn't the end of this story. A file system can manipulate inode numbers
> within the getattr callback (e.g., ovl_getattr), so vfs_getattr must be used to
> get correct numbers.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>

We have discussed this with Andrei offlist, so LGTM.

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

+cc Christian

> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/proc/task_mmu.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 435b61054b5b..abbf96c091ad 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -273,9 +273,23 @@ show_map_vma(struct seq_file *m, struct vm_area_struct *vma)
>  	const char *name = NULL;
>  
>  	if (file) {
> -		struct inode *inode = file_inode(vma->vm_file);
> -		dev = inode->i_sb->s_dev;
> -		ino = inode->i_ino;
> +		const struct path *path;
> +		struct kstat stat;
> +
> +		path = file_user_path(file);
> +		/*
> +		 * A file system can manipulate inode numbers within the
> +		 * getattr callback (e.g. ovl_getattr).
> +		 */
> +		if (!vfs_getattr_nosec(path, &stat, STATX_INO, AT_STATX_DONT_SYNC)) {
> +			dev = stat.dev;
> +			ino = stat.ino;
> +		} else {
> +			struct inode *inode = d_backing_inode(path->dentry);
> +
> +			dev = inode->i_sb->s_dev;
> +			ino = inode->i_ino;
> +		}
>  		pgoff = ((loff_t)vma->vm_pgoff) << PAGE_SHIFT;
>  	}
>  
> -- 
> 2.43.0.472.g3155946c3a-goog
> 


-- 
Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
