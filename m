Return-Path: <linux-kernel+bounces-6348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFC4819792
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C66B1F25D67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1A1173D;
	Wed, 20 Dec 2023 04:13:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2808EFBF9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35d47e5863dso54843995ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703045585; x=1703650385;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RbIRtxKG9SQkDjs+Z7h76sXDUO1uJds9y6Sy8ONpjNg=;
        b=Qaw1ZChRIFlbRdVpabp7hRyd3qxVsq8Dno/rgxB7LzcVwM2V0/4tQAxJOU+mqH2XYP
         /rP2D+w+sux3YpTDiMRgb+BDhOPJzVf8FftJ43U9iUtV/+ROL0WGBfgL7mMzjXla5ICc
         m3hGLAWCjkQr9YKmV38Pg9kswIjfBaUIoLAgF82iI3GsliiuCmLIo10qWKqk926boSe9
         bcka/oI1uoiTC21H4YgcpYw1/J6u9cFviYyPXcArsS3QmrFVkVC52JJ+8IRp1pNx9l3I
         ZRhNuOOVwU/4ctMuVqi0+ty7sM0mFVH2Ks6kX8P9CR+AsWIiBKdUCV6ba9msLKySx61f
         FmRQ==
X-Gm-Message-State: AOJu0YzOsYdnv/O1/Lu1EsYoV0HP0o6rnTD8WPcdVmWgDG1+J452OAu8
	AIsh05bpeKb4cwVR9NfrUNsuruKQzyBgQwgvsw8I0AJXZtBz
X-Google-Smtp-Source: AGHT+IEz6EcBkaU6ZP6Uv3nEyANRnpGKfTlBukSjkw+TwT1c3hl3WcrOqMWNSzDcuvPwYiyY57+IHjXczOzCnJJcgH+F0CK13UeA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cac6:0:b0:35d:642a:dd2b with SMTP id
 m6-20020a92cac6000000b0035d642add2bmr1055484ilq.2.1703045585422; Tue, 19 Dec
 2023 20:13:05 -0800 (PST)
Date: Tue, 19 Dec 2023 20:13:05 -0800
In-Reply-To: <CAOQ4uxiUoWO10a7UH5UweQ_1f+Fu+jSKPO66yAv80izyx9hBGg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027d0d0060ce93328@google.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in seq_read_iter (2)
From: syzbot <syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com>
To: amir73il@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
	dhowells@redhat.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da4f9f61f96525c62cc7@syzkaller.appspotmail.com

Tested on:

commit:         d9e5d310 fsnotify: optionally pass access range in fil..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.rw
console output: https://syzkaller.appspot.com/x/log.txt?x=127b3016e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5300d21645bcd09
dashboard link: https://syzkaller.appspot.com/bug?extid=da4f9f61f96525c62cc7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

