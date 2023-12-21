Return-Path: <linux-kernel+bounces-7851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C67F81AE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 06:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DAF1F23141
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D7945A;
	Thu, 21 Dec 2023 05:02:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3627B8F47
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 05:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b711ddbf1aso51751539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 21:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703134926; x=1703739726;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoTgpIwQmRPapYLG1S/Wc3pmTPJUvTVGVk/Kw0DmP/0=;
        b=VZHWS+x3sYaQL7/0jbZvwKLYJc0jiibMBxGBkehqQGW2yynktzhiIq5Sloqne1hSnm
         V6x7YAm3TPBlMrDgK35qFMexYtyNqiPT+49evloCVRTOORo8XdO5THD2Lhs0gNjn7wiK
         y3HSPv5X5A95yo2nQJQa1Z7zjHmUg9epDtaqPgZheKeiJDkOKG3jrfuwEOcxS9BtyRqW
         lK9FJlwB/2cynTfP7ypG6s8Sr53r7QErmMjS79nnXBeu5UALcCOK33rKQAAxKGqywsV+
         /lS4qJ9daju1Jfx0cbU2EO6aE2oVu20NshGw8ga1q2+94B0rB4oFqcfgOzI9X1B/XkxA
         /lyA==
X-Gm-Message-State: AOJu0YxDdGr3ElmcDTmo7J+qhSJLWp/0gvoYGd/OOIbbNsIRPvPnnVGJ
	yX6VlkLH7vHxXtyrmPFqljzX8nRzfSTY1Cq5SrgK7ySWD2we
X-Google-Smtp-Source: AGHT+IGBJPSofT7YbyU1BW5v+QeQOWbPbt494vo9633iA0QpHJ1252vw9ZiCsxfCK9EkBLi25VzQdj5PbmZSLL5Ut8hN4oQ3lhgZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8e:0:b0:35f:989c:a85b with SMTP id
 r14-20020a92cd8e000000b0035f989ca85bmr1235336ilb.6.1703134926397; Wed, 20 Dec
 2023 21:02:06 -0800 (PST)
Date: Wed, 20 Dec 2023 21:02:06 -0800
In-Reply-To: <20231221043616.1182-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae62a060cfe00ad@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
From: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com

Tested on:

commit:         d5b235ec Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10924b06e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d8c0fd15a0abe39bcf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177ca826e80000

Note: testing is done by a robot and is best-effort only.

