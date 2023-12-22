Return-Path: <linux-kernel+bounces-9198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADE81C234
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1AC51C242FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA3630;
	Fri, 22 Dec 2023 00:07:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE23186C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc8389a58so12815415ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:07:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703203633; x=1703808433;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=WCQrGvReLb/x8+3cu+B11Prbw83c2ZNNsvKIO8Fl9W/Bf8yo2Q6s5Fn3AXR+mE7ura
         1c8r/u3eUQTxuqnbR5sCPtiZpCC6dFguOMBcevQIz8EtLiMK6C9d5eoWP2KQ4hpAHbYw
         /VE+uWKr1bjVn8lTiObbXmxIJzQpRaO+rlAxITcp61CKPEMU0mOKM/8qi+Cy6W6vnkJs
         qLJ/QbbFdF2GJwACFzOgbPapgWgm6fwNe9CaAy+1ex83etfKvrgs1cV2K5wbFI9ZW1j6
         Lni3QQ/wDFNzdGiAmtrKtyveInH2E/7rY5ckdCiG7vUpfJ/HQEMJc3wVUf66KgUxZkWM
         Iwbw==
X-Gm-Message-State: AOJu0YxhkzRznK+SzkFxsnTcZNsAz3DT/FhNaeW9UlGrp1G4RgWQKb9t
	2oAUD16TuU/y7hOTaGY/vLojycg8pfsG0ymmuAgtGm8HKdqs
X-Google-Smtp-Source: AGHT+IGp4EqZUrHByv3JGf43xAerJwTcxk7SI0VR2iqYxAwG4CXwcStL3oz6hWVlRYsEgalewjyBe1u+W1Enno9VvFUHqbv56nQK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:35f:d4dc:1b1e with SMTP id
 i12-20020a056e021d0c00b0035fd4dc1b1emr54224ila.5.1703203633408; Thu, 21 Dec
 2023 16:07:13 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:13 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cb1ee060d0dffa7@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

