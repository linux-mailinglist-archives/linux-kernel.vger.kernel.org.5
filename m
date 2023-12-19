Return-Path: <linux-kernel+bounces-4615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6445F817FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9AD2853BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A64695;
	Tue, 19 Dec 2023 02:50:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E234409
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35facbf9690so23729035ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954204; x=1703559004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uy2hhP+dS3A2HK+K5yWeNNeihq9hnYUyD5rfUJhYI0Q=;
        b=XecTaxFaKpFcL/xkq7F1praGwtlqyFnhQrTKAH2b4zNDm8EWSCbFqKmn1/+CdcCoyz
         KZPtkPlKxo+JqZeW0Bf8vmBv4wrpDUYWTOHoDS8OdgAAimj2nTbbEv287lO+WYtQNENj
         t34AoDcvtH9eEZj3SRAqEb8shd6zyPUzGviZNfVR0fKota6xLcbo/RvYeFUYZJzXymZM
         4VeddiMcsBWVZ4/E7b0TF7AFMXcwnT5IobIjU9d/0HG3KgocIoRW82KFhelFY1dDkN9p
         9rjh53zRXWvCwJv7A2A/MbPI3tJ/pSr7bzWzK7GZLVPPA+deQqUlsOv8V6D/+IQb9sPi
         iuDw==
X-Gm-Message-State: AOJu0YxGcBi2CIqbsOQszb2oMZ8k3v+gBVsjkPqNPFz4GQwVere1t4qE
	XHcBl+4cD7H5Jlc0FtAisJt6HPFUk2cmoguJe064ZfrqZqxg
X-Google-Smtp-Source: AGHT+IHAN/aOZSdwJZOOXkZd1nbDb0t+ng/uRKBMjKhUBy156kW3hff5SKgpPeBq59fjnOJm5Zxa+41XThe+O8WmQW0jV1Oi4oG8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d05:b0:35f:b5b6:3edf with SMTP id
 i5-20020a056e021d0500b0035fb5b63edfmr247678ila.4.1702954204847; Mon, 18 Dec
 2023 18:50:04 -0800 (PST)
Date: Mon, 18 Dec 2023 18:50:04 -0800
In-Reply-To: <tencent_6AF1DDEC19024FA58DF5A59C8D8D1263DD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072e60f060cd3ec9a@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in
 getname_kernel (2)
From: syzbot <syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/btrfs/dev-replace.c:745:36: warning: empty character constant [-Winvalid-pp-token]
fs/btrfs/dev-replace.c:745:36: error: expected expression


Tested on:

commit:         3bd7d748 Merge tag 'io_uring-6.7-2023-12-15' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=53ec3da1d259132f
dashboard link: https://syzkaller.appspot.com/bug?extid=33f23b49ac24f986c9e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1392a8d6e80000


