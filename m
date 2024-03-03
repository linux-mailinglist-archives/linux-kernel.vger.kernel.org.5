Return-Path: <linux-kernel+bounces-89779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3486F59A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4241C20CDE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C2167A14;
	Sun,  3 Mar 2024 14:56:03 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274812EB09;
	Sun,  3 Mar 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709477763; cv=none; b=cUCa+cpNT7rrT3a/CWq96zMMLNP4mK4I8VntrAWQLlTS/9lre7abT83osOf4UQV/dhxofZZv/q+1F2tTLTy3nq7gaqoCtxgzm287GtafrY8U+0miXHKRuzmhw8rsxr9emE1RBKbUJhZO9C3ctk8MAnAW9TK+WKfGUqh7KK/Fwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709477763; c=relaxed/simple;
	bh=PDW3W9UUOB58picWGQF59vY7+3Fq1Mklcn3pNhiZtuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=cRU70etn8tZFDgkmy/EkUC9dWzfZz6U8qaUB0F1845y6BQTL+8Gdf4iKWQhhfdYF13Bh3PspJ9jr9UrYS8bYZlaNhMIHLFULHIcRhS6IM/BYkB0za/dvlr4HI1OJ8zzFqkV+ajOrW+KbAkv2XDTTmzO8n+qrb39X79yTjk1qEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 423Esgxl036017;
	Sun, 3 Mar 2024 23:54:42 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 03 Mar 2024 23:54:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 423Esf8G035999
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 3 Mar 2024 23:54:41 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
Date: Sun, 3 Mar 2024 23:54:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [integrity?] [lsm?] KMSAN: uninit-value in
 ima_add_template_entry
Content-Language: en-US
To: syzbot <syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>
References: <0000000000002be12a0611ca7ff8@google.com>
 <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <40746a9ae6d2e76d748ec0bf7710bba7e49a53ac.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/02/20 19:40, Roberto Sassu wrote:
> On Mon, 2024-02-19 at 22:41 -0800, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=135ba81c180000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
>> dashboard link: https://syzkaller.appspot.com/bug?extid=7bc44a489f0ef0670bd5
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

> I would add the VFS people in CC, in case they have some ideas.

This is an erofs bug. Since the filesystem image in the reproducer
is crafted, decompression generates bogus result and
z_erofs_transform_plain() misbehaves.

You can obtain a single-threaded reproducer from
https://syzkaller.appspot.com/x/repro.c?x=1256096a180000 with below diff.

----------------------------------------
--- old/1256096a180000.c
+++ new/1256096a180000.c
@@ -676,6 +676,6 @@
   syscall(__NR_mmap, /*addr=*/0x21000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul, /*fd=*/-1,
           /*offset=*/0ul);
-  loop();
+  execute_one();
   return 0;
 }
----------------------------------------

With CONFIG_EROFS_FS_DEBUG=y, the reproducer hits DBG_BUGON().
With debug printk() shown below, you can get output shown below.

----------------------------------------
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d4cee95af14c..f221133a0731 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
 	u8 *kin;
 
-	DBG_BUGON(rq->outputsize > rq->inputsize);
+	if (rq->outputsize > rq->inputsize) {
+		pr_err("rq->inputsize=%u rq->outputsize=%u\n", rq->inputsize, rq->outputsize);
+		pr_err("rq->pageofs_in=%u rq->pageofs_out=%u\n", rq->pageofs_in, rq->pageofs_out);
+		pr_err("nrpages_in=%u nrpages_out=%u\n", nrpages_in, nrpages_out);
+	}
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
 		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
@@ -352,7 +356,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		do {
 			no = (rq->pageofs_out + cur + pi) >> PAGE_SHIFT;
 			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
-			DBG_BUGON(no >= nrpages_out);
+			if (no >= nrpages_out)
+				pr_err("no=%u nrpages_out=%u\n", no, nrpages_out);
 			cnt = min(insz - pi, PAGE_SIZE - po);
 			if (rq->out[no] == rq->in[ni]) {
 				memmove(kin + po,
@@ -366,7 +371,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		} while (pi < insz);
 		kunmap_local(kin);
 	}
-	DBG_BUGON(ni > nrpages_in);
+	if (ni > nrpages_in)
+		pr_err("ni=%u nrpages_in=%u\n", ni, nrpages_in);
 	return 0;
 }
 
----------------------------------------

----------------------------------------
[  138.991810][ T2983] loop0: detected capacity change from 0 to 16
[  139.804002][ T2983] erofs: (device loop0): mounted with root inode @ nid 36.
[  139.810464][   T87] erofs: rq->inputsize=4096 rq->outputsize=8194
[  139.821540][   T87] erofs: rq->pageofs_in=0 rq->pageofs_out=0
[  139.824347][   T87] erofs: nrpages_in=1 nrpages_out=3
[  139.827008][   T87] erofs: ni=3 nrpages_in=1
[  139.873777][ T2983] =====================================================
[  139.881268][ T2983] BUG: KMSAN: uninit-value in ima_add_template_entry+0x626/0xa80
----------------------------------------

#syz set subsystems: erofs


