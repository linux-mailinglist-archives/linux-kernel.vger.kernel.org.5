Return-Path: <linux-kernel+bounces-146426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E108A650E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7C5283C69
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B058005B;
	Tue, 16 Apr 2024 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6oV3cls"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE433B78B;
	Tue, 16 Apr 2024 07:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713252497; cv=none; b=V2lLqdpFB3RL9vTyxhJ+XczvoXXabAtUlTA8oFR0ChfrjzXfaHAtlXKGgbfD6MLtlvCqV4FrcnvZtWShLE/LPyxnROGgHL1quwGriyhkc5PQuLZ+9BIU0x3QTTlnr+PWq6vM8f9JEdrFfiMjvDV3HLdLeW88UipVNWBscKieQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713252497; c=relaxed/simple;
	bh=F1ZY/I6/nCY7bzIXAtOKE5cqSyOxKiOJFgMz5yMepl4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RcMES2l5fuhVp8XTubU9KgOl099Sr3xOOg5HjXA78I5WPXAPo2iAvY7rC100dPJUPZFjahU5YJA2pedYV8dSb4tdMu8IWcjsTyzvEVn8j65x6njX8EYX3U6avLqxsRaI9I4SQsMEsseCEmQM/7axTxF+nOo0hXZ6gHhOS0G5c/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6oV3cls; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44f2d894b7so442182266b.1;
        Tue, 16 Apr 2024 00:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713252494; x=1713857294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yxVv0LhJm5HT/6Ae8eAzf3XoGU2gXg4O6Y8MwCsSeJw=;
        b=R6oV3clsZc1IFIBnI9ZJt1hyQXVjD9GfsjjK9P4tKlabK9lknsz6o4NlqxZYSWnNrR
         GKrkod1yPKYKbg62CHIBilBMKreFzXqAcL4BBq34h2yQueRsGFwFBhNEcGQpS2QFXqdh
         7rPeu5lFJ8/nfHXZCWNxYx84lbs2+BiWGiwhLH4VYFD6meGUcdIdyYYKFxmkP9ZAajSH
         4VW30dHp1oNlpD2ek/jsPObXEx+LSBPOjD13V+OxTdAP9Zyfhfz7i/01wxRwsdo+O+wh
         yzL3jWDSC1fyJb8eSL0Vjft9vzfAr/379eR0lQHZuKvTW/0MXzrgcLUiAgINemTZNBgA
         vDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713252494; x=1713857294;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxVv0LhJm5HT/6Ae8eAzf3XoGU2gXg4O6Y8MwCsSeJw=;
        b=R1Ceo9zOyyVFH5IixRg0f6XNhYKw9PpTCOuhAieQaWMfYeQOvqdTwzb7Wv+PvjEzV7
         aV2NwW12eW397mZJen7VEA+d9Cvl5G+jG4JZW23WamcKqE7CjG4AxTnA9momNiDY2bZ7
         UYpQPJjAbyj8qsDbNbl8Ixtunp3NO8uJrrNk8IjoPJK6rv7QB100V9UEIeboZZJTZakO
         neOGaMYXhceV2I9x74OrhFR1DBNQSBFsGxDDFPRULqsAKHi2fy9WmGHwjSA3NpgXXPxa
         PWDWht2VRwauVQEHG9fJO/V8jxO7roakJRSfG+jFNh/9UqpIzY5pLnDU7bZ8QCEz+2Qf
         SNqQ==
X-Gm-Message-State: AOJu0YyniLXIyPQVD/mvOioycCajhspmVDMeGxwZtPhzMXjZrcqaGg53
	MQ1iRl98fenNtSm4ntn5I/9cx0N7Lfqd910+U7+jmD76+hokO+yjWB0hLIqEN26IXElTU6SMQEU
	BgNDCTaTDM0UE4OeQeVkT/WCamxGnbmIH7gIHHg==
X-Google-Smtp-Source: AGHT+IF+XT79nJii8BhDLY6zr3LkvmkUDI3E8OtlpbQLfk/XlGWZpP6kF/DOSxok1XxT5Nq+n2ltK570QbQMOTQVqD8=
X-Received: by 2002:a17:906:d936:b0:a52:5916:da16 with SMTP id
 rn22-20020a170906d93600b00a525916da16mr5047765ejb.37.1713252494118; Tue, 16
 Apr 2024 00:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 16 Apr 2024 15:28:02 +0800
Message-ID: <CAEkJfYMdDQKY1C-wBZLiaJ=dCqfM9r=rykwwf+J-XHsFp7D9Ag@mail.gmail.com>
Subject: [PATCH net v2] drivers/net/bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	pabeni@redhat.com, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

In function bond_option_arp_ip_targets_set(), if newval->string is an
empty string, newval->string+1 will point to the byte after the
string, causing an out-of-bound read.

BUG: KASAN: slab-out-of-bounds in strlen+0x7d/0xa0 lib/string.c:418
Read of size 1 at addr ffff8881119c4781 by task syz-executor665/8107
CPU: 1 PID: 8107 Comm: syz-executor665 Not tainted 6.7.0-rc7 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 strlen+0x7d/0xa0 lib/string.c:418
 __fortify_strlen include/linux/fortify-string.h:210 [inline]
 in4_pton+0xa3/0x3f0 net/core/utils.c:130
 bond_option_arp_ip_targets_set+0xc2/0x910
drivers/net/bonding/bond_options.c:1201
 __bond_opt_set+0x2a4/0x1030 drivers/net/bonding/bond_options.c:767
 __bond_opt_set_notify+0x48/0x150 drivers/net/bonding/bond_options.c:792
 bond_opt_tryset_rtnl+0xda/0x160 drivers/net/bonding/bond_options.c:817
 bonding_sysfs_store_option+0xa1/0x120 drivers/net/bonding/bond_sysfs.c:156
 dev_attr_store+0x54/0x80 drivers/base/core.c:2366
 sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2020 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x96a/0xd80 fs/read_write.c:584
 ksys_write+0x122/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
---[ end trace ]---

Fix it by adding a check of string length before using it. Remove
target address in netdev_err message since target is not initialized
in error path and will not provide useful information.

Fixes: 4fb0ef585eb2 ("bonding: convert arp_ip_target to use the new option API")
Signed-off-by: Yue Sun <samsun1006219@gmail.com>
---
 drivers/net/bonding/bond_options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c
b/drivers/net/bonding/bond_options.c
index 4cdbc7e084f4..8f3fb91897b3 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1214,9 +1214,9 @@ static int bond_option_arp_ip_targets_set(struct
bonding *bond,
     __be32 target;

     if (newval->string) {
-        if (!in4_pton(newval->string+1, -1, (u8 *)&target, -1, NULL)) {
-            netdev_err(bond->dev, "invalid ARP target %pI4 specified\n",
-                   &target);
+        if (!(strlen(newval->string)) ||
+            !in4_pton(newval->string + 1, -1, (u8 *)&target, -1, NULL)) {
+            netdev_err(bond->dev, "invalid ARP target I4 specified\n");
             return ret;
         }
         if (newval->string[0] == '+')
-- 
2.34.1

