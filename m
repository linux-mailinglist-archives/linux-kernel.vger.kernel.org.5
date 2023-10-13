Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAD87C8D82
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjJMTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJMTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:10:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CD2BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:10:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c5bf7871dcso19782825ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697224243; x=1697829043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lMbyNAYDyItK0nqbzPA6HNTwdTNDqzEz2uTLeRsQrI=;
        b=gTUDnusrc4bRSJTCWGB7k78On/9D9Ycu3mcdNBixbk0qkAn8evKEr8UI7YOARhKNUT
         CYhGHI6sIM3PwB9MkxVCLb4tELaQOqAZeY9uByzxZWEer+ByAuS61PGhOTEtqX9mNBIt
         2tV1JUvjbqIVYrM2eje73ZX42TwzhW8lmF+WbLEobdmt3BWfZL4i4XwMTGyAd80ZhsVm
         X2kW1inm2N2WoibhaZfG+c3nUDtPPWvCgV4KJ1hivZ9M0ry0fNW4sNNxDoNq3qO396z6
         BIaG/Mc/TNSnxUmimRJx7wqpdV/FWeyT/e7mqghFLGel6zjDqGMu9PTfufD+gu7yJlhu
         Iiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697224243; x=1697829043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lMbyNAYDyItK0nqbzPA6HNTwdTNDqzEz2uTLeRsQrI=;
        b=vltvIVGkdyK7VdY43BlRN1vIxROFTgFOvqDNgub1qus6ef9mLUmqSe4fr1FTutODaX
         BBhYnzmvgU6nF+GGsPr7DdeyrsZF1sushlECNmnLjzmwWZvLNnug3bAM7wBHTOrM3eyb
         gYEDaIDpzBdJlcgB/MOJG7a7Fkm/xLaN0Sxs0XQKnYakQIy8F2XTidvieelVrtunR6vi
         vGNEHBgl4z+lTvwHGWxeC4/vWTkXiymcKZkEl/sPd1T49AjHEAbSobAAaWCvEmzLUCHu
         RCFRIaRmIOTjckOhITrz6etaKQbf9VaUG+c1jXhq26o8zOrdH0QHvwqVm9lrDlx8lHLh
         5G2Q==
X-Gm-Message-State: AOJu0Yxw94Ot+KW4DNMw+tMxsbLdjLUZTK5LK8n0jGtt7TKLtOcN0uPc
        TPP6T0HsVqsICDRkTTgK57M=
X-Google-Smtp-Source: AGHT+IGR5R3Mo7tCTO13z/WFyagYGpxOx00S+5AcFWEHcqXQ8qUvXx8ZVSyfRWSdPerKX274Ep4ROA==
X-Received: by 2002:a17:903:25c3:b0:1c9:bca1:d70b with SMTP id jc3-20020a17090325c300b001c9bca1d70bmr10578679plb.39.1697224242709;
        Fri, 13 Oct 2023 12:10:42 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id b11-20020a170902d50b00b001c60a2b5c61sm4232901plg.134.2023.10.13.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 12:10:42 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>,
        syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
Subject: [PATCH] UBSAN: array-index-out-of-bounds in dtSplitRoot
Date:   Sat, 14 Oct 2023 00:10:28 +0500
Message-Id: <20231013191028.17382-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller reported the following issue:

oop0: detected capacity change from 0 to 32768

UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:1971:9
index -2 is out of range for type 'struct dtslot [128]'
CPU: 0 PID: 3613 Comm: syz-executor270 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dtSplitRoot+0x8d8/0x1900 fs/jfs/jfs_dtree.c:1971
 dtSplitUp fs/jfs/jfs_dtree.c:985 [inline]
 dtInsert+0x1189/0x6b80 fs/jfs/jfs_dtree.c:863
 jfs_mkdir+0x757/0xb00 fs/jfs/namei.c:270
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdirat fs/namei.c:4053 [inline]
 __se_sys_mkdirat fs/namei.c:4051 [inline]
 __x64_sys_mkdirat+0x85/0x90 fs/namei.c:4051
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcdc0113fd9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb8bc67d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcdc0113fd9
RDX: 0000000000000000 RSI: 0000000020000340 RDI: 0000000000000003
RBP: 00007fcdc00d37a0 R08: 0000000000000000 R09: 00007fcdc00d37a0
R10: 00005555559a72c0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>

The issue is caused when the value of fsi becomes less than -1.
The check to break the loop when fsi value becomes -1 is present
but syzbot was able to produce value less than -1 which cause the error.
This patch simply add the change for the values less than 0.

The patch is tested via syzbot.

Reported-and-tested-by: syzbot+d4b1df2e9d4ded6488ec@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d4b1df2e9d4ded6488ec
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 fs/jfs/jfs_dtree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 92b7c533407c..f3d3e8b3f50c 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -1970,7 +1970,7 @@ static int dtSplitRoot(tid_t tid,
 		do {
 			f = &rp->slot[fsi];
 			fsi = f->next;
-		} while (fsi != -1);
+		} while (fsi >= 0);
 
 		f->next = n;
 	}
-- 
2.34.1

