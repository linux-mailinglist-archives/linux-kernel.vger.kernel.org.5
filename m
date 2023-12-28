Return-Path: <linux-kernel+bounces-12696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90A81F8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C941C217F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A38838;
	Thu, 28 Dec 2023 14:08:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667948820
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc915c090so43685095ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 06:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703772528; x=1704377328;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1kypE1u8XyY4qPEIFPOxS4GpifqD08FK9VLBC2P33o=;
        b=eprsN51lLnfXAMPcO6cW2TLVIZiOZOz3Bt69Svq/pTXFwpiHvAGEBurkJHko/WEojI
         ZYRLh4cDQmI1ZCSLpgp0l1A62ONP5nVqNVBjxGQw/p6lxso5nAzp4/PxEKfVsIUlzU2H
         MJdplrcqTgMqCi71f0WT2MBPdbWGyL2AtECa2EgCoXq2YaCePG/Zyg6iHBCKctvime8E
         rBwfUX27EGbqd1ZT8cD1aM7BtKniwUp+BYfWEeI6aLgFkioknUk/i3HGmbu8LBC3AwDL
         7dz50sk1bvTfCFrdxSBnWzL5FBB67S0mrUGiIQuIMDpDa+/IpX9tgnIY0GXflmC1MM4+
         tHyw==
X-Gm-Message-State: AOJu0YybU9JDRjF/PYrby5pjrEH0LvwApNnjXZTGoeCNzjKztZXLNo8T
	ZnKVn/1cZHASlwGwW3IH6nGgMB6lOocGQJkjNp5o9IW24/Hy5m0=
X-Google-Smtp-Source: AGHT+IFPPnUQj+5aFVJATfuTKskSFhjnh3od8L7wN4IxkZr4lvYmR/Z9q7bvQPaujgdHIuB1ojVY7xxNpfT/FTOery99DsWlv4i+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:35f:e864:f6f with SMTP id
 y1-20020a056e021be100b0035fe8640f6fmr1528242ilv.0.1703772528597; Thu, 28 Dec
 2023 06:08:48 -0800 (PST)
Date: Thu, 28 Dec 2023 06:08:48 -0800
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005860a2060d9274da@google.com>
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
index 021be5feb1bc..c0983c3db77f 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -250,7 +250,8 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
 			       16, 1, src + inputmargin, rq->inputsize, true);
 		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
+			       16, 1, out, ret < 0 ? min_t(unsigned int, 
+				       rq->outputsize, rq->inputsize) : rq->outputsize, true);
 
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);


