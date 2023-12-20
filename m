Return-Path: <linux-kernel+bounces-7278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F004681A4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7861C25A86
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FE49F7F;
	Wed, 20 Dec 2023 16:17:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE56498AE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7ce620dd9so573100739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089023; x=1703693823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePigEZAq5BnZgreV+wgFg82AjByKY2Kndpr9l1JWH+w=;
        b=rQLaqntaEq6w5dk2RFq8OIalws1mSz1e00th0x/aaFehnfGOCjhlPlM4Rb10ZcYZxL
         rlriPO5fwh/uMTV6kEzTpBEjRiUyHyO5Z8wSdnKagFq7J8FIWR0RUb1OjtWnAVhxATNS
         SJfxp1QGsXySk+AA0bVSzSkNrYOaETGpkHaAiWb2t6lbm5+vO1685CIkj9R+lfsC0lax
         i64w4Lwn2t2LS1RvGfhs1McRZvA00sA+Tk7usoxVU9L8NmHGY3iofi1R6domsCt0HNL9
         c4tqg75/gloj9Wx2Th2Llyq6t8/YRgPIlzPZbEg63cSbePFHpdex2VY7NqF7ijvO9O4t
         Au8A==
X-Gm-Message-State: AOJu0YxrJAgTJxntin8xZhD8XyQ7f/HhUrihvmwbph27nQkJjwdBmgdM
	9nBpzV4sqeXqNaZGfzgiEcQR0GknNBw+B0kBvi0vmXBCTN9X
X-Google-Smtp-Source: AGHT+IFHKwfH2IHn0ucfOfQLWJ7IO8d6xzg6ZjuoqrqIBxtJm8L9TM5Z9H7LACNuG7uyVIK3EKaG6SrFEFkgJUGUVdkhG7l4WZ/n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411c:b0:468:fc2b:d008 with SMTP id
 ay28-20020a056638411c00b00468fc2bd008mr1494219jab.1.1703089022944; Wed, 20
 Dec 2023 08:17:02 -0800 (PST)
Date: Wed, 20 Dec 2023 08:17:02 -0800
In-Reply-To: <tencent_4EF87A266D302E216D9094D8EA06EDBACD0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bd36b060cf350f0@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in arc4_crypt
From: syzbot <syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8ffb0839a24e9c6bfa76@syzkaller.appspotmail.com

Tested on:

commit:         17cb8a20 Add linux-next specific files for 20231215
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=162b1ac9e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec104439b5dbc583
dashboard link: https://syzkaller.appspot.com/bug?extid=8ffb0839a24e9c6bfa76
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179117d1e80000

Note: testing is done by a robot and is best-effort only.

