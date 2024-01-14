Return-Path: <linux-kernel+bounces-25414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E082CFF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FF9282EB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3401876;
	Sun, 14 Jan 2024 08:05:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E1185A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 08:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3608452488eso64018725ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 00:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705219506; x=1705824306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCgJR8szTpvCAmbZnVtBY/6XIAcuDV3FMLrupxiQWEo=;
        b=YM2BT1uh0MDuA9qA8sVcRPbBYqrAawbQb3pxo+0ewV3Rr8ymQG7Q+uFnShwNkhhorg
         eNk4uSTjMsZLbtzIRj85o38MFins/5ldc1PNSvjOotO1pvGXuDOoiVijpefY63Iv2F/L
         YddCC0v0+wYcKMQSVSyfpTCGgJyXS91BTIhRr+yb/Y9H7hBbxcjM4fMivh/98W/9JvOf
         QMrXWrHeUonj9llkUF0bfRFs0vL5hbgLkgNFxgAUJbExo90K10UarEMC4Y2bMFmFuXXI
         yI9crwepWzLdReQFAMoQ3HzRxSzPMAFJpa8wbBM7ipgH2sr7GQas1F05DjraW0J+Qu6R
         Z8Kg==
X-Gm-Message-State: AOJu0YxCjHHTAnZFVUE0FEU2vIeiqnnSkyGW+1Vu/El4UIOqzMDeGjS0
	+Yz75e2y09fGxgMiPII3sTUGibd9i8Eu0Ukqx2UBKHNMquqP
X-Google-Smtp-Source: AGHT+IGyydU9G8sZDV6Z1YG3fKMSi97wbtt7oIsLusUW/SlDX3Bqs42aSvS9jr3HgOLgduwHZLDLmTnpQtb002q0lWDQ4ERQnOJV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:360:62ba:610 with SMTP id
 15-20020a056e0216cf00b0036062ba0610mr522597ilx.5.1705219506044; Sun, 14 Jan
 2024 00:05:06 -0800 (PST)
Date: Sun, 14 Jan 2024 00:05:06 -0800
In-Reply-To: <tencent_A9EB66EDAACD207A7E6CA42D656F1097280A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec05d1060ee35a60@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
From: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com

Tested on:

commit:         acc65769 keys, dns: Fix size check of V1 server-list h..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12b062dbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c882ebde8a5f3b4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16749b35e80000

Note: testing is done by a robot and is best-effort only.

