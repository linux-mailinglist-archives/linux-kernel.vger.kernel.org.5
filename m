Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E587902B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350696AbjIAT7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjIAT7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:59:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7888410FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:59:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c0a4333e03so5015495ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 12:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693598350; x=1694203150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHUmiekk6WKdraJm0Z0JM2AxBlJzqMajC1C0+RJLAZg=;
        b=SZZhsrUunnZy4fKZX5GOYraVkrUzlKZ6R1Drza5A/zHpteuFzXfWYZsuJ3Ws9AUeV0
         1/mHRp5k5Pz5wUBeJFWgqp/3U04MiLZ5bQICljReoLII5yuGbJsughpB2OfIPVKL0KMl
         nS3NY7U4YIxWWvh9OWVSa7muMsEnwyheYp6nEredKgt1uQ+5SUdAIxZKMocwyBmWhSDS
         +UtTt6OF51Ol2OFgBJttulbVh1dhwTsYDCSEU0ArOIFMd74kuqhUn1Lu6lidc8l6TtGx
         Zs1X+sW1ecQcX/hnkQnhQCshyHVUiTJiCdPkUcSnI9SIeX8E1GVd6TB4+qkol8gel0w2
         fC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693598350; x=1694203150;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHUmiekk6WKdraJm0Z0JM2AxBlJzqMajC1C0+RJLAZg=;
        b=Kt/d2rdtr52+EeGraBR7V7QNfk9wloU1lq4G3pyuipQ5hjsxowLp29C5qaTLi+O62m
         M9x0N0UlzBAX7GcpNOrY/UAjcZTdWRc/bEVQkmjTR2Xu8OtywEfCPXuJbWGzXDZKNj8X
         LKoH3SPE2nwAuz0glcaSa7FnYJ0aBhC1raX98R17Qh5x86UkHCPv4iZy9zZyHmXvF9cC
         d7tsOwxyXfsarqFIsphiD9HCrqI53M47lWkgf+wc+z3MJnQFJwKIP7P0n55ggIGNqdvA
         KSrioeb7GFZgQh1yJwV5dHA921B+sexPu33uKBPeBf2ytSf32ikgE9DxwGhryGUCHeJc
         7ezw==
X-Gm-Message-State: AOJu0YzIONzM8UPfXl4TTWFqKQ/3ouhkuSFNNOSmeAoVt1YuoRouZ1u7
        3oKhbqr7pMT0I1YCU4FoG7U39w==
X-Google-Smtp-Source: AGHT+IEdqQlPRTKKgAzIXc4HZQL2gIIoDUYfkAU2EXMviLk1Qbbb9HR/XfCjbWpYW6nqACpcZpt4tw==
X-Received: by 2002:a17:902:d505:b0:1c1:fbec:bc32 with SMTP id b5-20020a170902d50500b001c1fbecbc32mr3952403plg.6.1693598349855;
        Fri, 01 Sep 2023 12:59:09 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc18-20020a17090325d200b001b89045ff03sm3337455plb.233.2023.09.01.12.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 12:59:08 -0700 (PDT)
Message-ID: <544a6062-1af4-4686-bc70-823a6dbca38b@kernel.dk>
Date:   Fri, 1 Sep 2023 13:59:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] general protection fault in
 io_uring_show_fdinfo
Content-Language: en-US
To:     syzbot <syzbot+216e2ea6e0bf4a0acdd7@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000466a6106044f6986@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <000000000000466a6106044f6986@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 11:22 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    99d99825fc07 Merge tag 'nfs-for-6.6-1' of git://git.linux-..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e9fc13a80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cce54b04d9a3d05b
> dashboard link: https://syzkaller.appspot.com/bug?extid=216e2ea6e0bf4a0acdd7
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1749fa10680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10211c10680000

This should fix it:

diff --git a/io_uring/fdinfo.c b/io_uring/fdinfo.c
index 300455b4bc12..c53678875416 100644
--- a/io_uring/fdinfo.c
+++ b/io_uring/fdinfo.c
@@ -93,6 +93,8 @@ __cold void io_uring_show_fdinfo(struct seq_file *m, struct file *f)
 		struct io_uring_sqe *sqe;
 		unsigned int sq_idx;
 
+		if (ctx->flags & IORING_SETUP_NO_SQARRAY)
+			break;
 		sq_idx = READ_ONCE(ctx->sq_array[entry & sq_mask]);
 		if (sq_idx > sq_mask)
 			continue;

-- 
Jens Axboe

