Return-Path: <linux-kernel+bounces-12692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B06E81F8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C731F22672
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89264882F;
	Thu, 28 Dec 2023 13:54:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF18820
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baa6cc3af2so531255639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:54:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703771646; x=1704376446;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCRFAMWm9gynkMm+jgGhNfoN7+13CeMvz0iyQRZN3bM=;
        b=bPugHdIqQgPFbzRfO8b7TY/5gpcJzy/mKytTNecjQze9Z5hicZKvcCS/gvQ6Vk37Hm
         oFPTiZaw9xHCDhWEzEdOMS8pJAh9nheswUuMJHVSim9OfTvWTNoYLyM+eWj65y9rKLoJ
         qCRVNasPjK1zyHrE9H4RUbKSVqeBBaNZnZzH+VMejt0Xhz+FCKA1zn/0hMHneOkcxSy5
         VBsSaCmeVU79Nx+kYbM6xvP/IeV2ZOvg1NGcTEzPiYsDacv5SuyqKwHZ1jsO1B6WXJo1
         njpS4pLbrrQGqs/CeOxhgmCDwpNElHUsZmpbf4daTQBjtaBIEeLTWHDpt2ufyO54c0WI
         Rs0A==
X-Gm-Message-State: AOJu0Yxv+x0mHJpWUykCSDXJeBINU/Bz6hZaslpqrAakewbLJmJt6P96
	81JCW6GbJK+r2oTKslClLxIa933tdE9/sgcN+jEjiOohy8/7nbU=
X-Google-Smtp-Source: AGHT+IFAp988G6oLWEWmkBCr6l4GBBgGjEtU5iRG/NBWbBwRF1NNJygbUOIEdhJaUPjSmJzw48wjXK+ZxlzobSD3Thl6etPLNC7H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2768:b0:7b7:ae9f:e837 with SMTP id
 l8-20020a056602276800b007b7ae9fe837mr101838ioe.3.1703771646116; Thu, 28 Dec
 2023 05:54:06 -0800 (PST)
Date: Thu, 28 Dec 2023 05:54:06 -0800
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000becddb060d923f00@google.com>
Subject: Re: [syzbot] Re: [syzbot] [erofs?] KMSAN: uninit-value in
 z_erofs_lz4_decompress (2)
From: syzbot <syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [erofs?] KMSAN: uninit-value in z_erofs_lz4_decompress (2)
Author: eadavis@qq.com

please test uninit-value in z_erofs_lz4_decompress (2)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fbafc3e621c3

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..1c19731c8fc6 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -250,7 +250,7 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, ret > 0 ? ret : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);


