Return-Path: <linux-kernel+bounces-9308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA5281C3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B909A286473
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAA923D5;
	Fri, 22 Dec 2023 04:19:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3720FB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b739032bf6so160855039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703218745; x=1703823545;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fDxZ3Ga9/F0hvHkyVo3DPwY7VZI6+zrABkAy4JN6Qo=;
        b=HDdV0i9fdLmD5KA4CUUS+vYtb9PLaoEuzC306qaUTgdzYCS94YUeJc9HoSZjN6LWP2
         oELAwJhsrZpuBYfveT/epVjPefbwNGQthxP5G/2YOdGMbZ7bduqtUcT8ODAWnCVwOMNO
         6zY21mnFE20tiwqXsr18yAfPL63AL6JZ1O+hMMEdgD+4Hwlqa/yuTdZuFPXD3Z1z/O6y
         xQ6PpmCPsj0G0f3XW03BlcDp7kORZHPrV+dcYQ4IeKyOyBEH/83Tg7ve2JOTDx30iHgj
         CUzvC/vGJbF2Hl5XgG2y2422tBAFfUqwWHAEMq9Cmivp37HWDt1QZJ3KO7Jf/SGAJ9q9
         jQsQ==
X-Gm-Message-State: AOJu0YzHdNIg6M0l0T79NzLNrqduoRrL5I3MJ8A41VBsxQXieB7MnkwU
	NYubEFhFq6EHLL5O3sNUW9PYBAY+k7eJrHVAYPEkhxRq6TMx/Zs=
X-Google-Smtp-Source: AGHT+IHHAFisd4iKuXPGnRd5cvEw3S3NkNC0CiT8HJgouhiCZHXEHv/IJYl/vyICXsjYdzDdlvn2SxIhorrpdoiTMDayjucYiRx0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3395:b0:46b:3f0b:906 with SMTP id
 h21-20020a056638339500b0046b3f0b0906mr31342jav.1.1703218745594; Thu, 21 Dec
 2023 20:19:05 -0800 (PST)
Date: Thu, 21 Dec 2023 20:19:05 -0800
In-Reply-To: <20231222030654.849208-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e5a29060d118494@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in chmod_common (2)
From: syzbot <syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+83693dbba860b4f2e549@syzkaller.appspotmail.com

Tested on:

commit:         aafe7ad7 Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=117a15a5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=23ce86eb3d78ef4d
dashboard link: https://syzkaller.appspot.com/bug?extid=83693dbba860b4f2e549
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f83009e80000

Note: testing is done by a robot and is best-effort only.

