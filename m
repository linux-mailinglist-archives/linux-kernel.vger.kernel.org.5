Return-Path: <linux-kernel+bounces-27549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B5B82F200
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F591C2365B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BBA1C69C;
	Tue, 16 Jan 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZWKnw/v"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2972E1C68D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d47fae33e0so422455ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705420639; x=1706025439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4RhZpXa8cxxbTmltT2uMDAVbFEnYgLBeqxEfdznCVE=;
        b=UZWKnw/vXxHat+l12OSCVaBua2SyQ57xqGYCJMHMHIWDKQF+c7W0Y34z4gi3XZjqsx
         1KL8CPmEZd1WPVdsXqRqjkIXRbXy/2iBXDEizTgNjk+B7rpCDQWaHW4+4DTuE1yNvM8t
         Wg0N+spvT2vJlU0TsKnvBCIU37aoNW4Tr+SwbAwcHHaqvUXpOz8NoqxtQHp+EjnyeX9m
         E4HzE/h6VGYv4spbNDLQ+7p0ooiT2aUvZuHcT45/gryJ936btvdVeN683KbjbfrIn9ck
         3IDRlkW22b+W6nI1p9jB7y8pPeyUEMpEKWmd4vloaoPRriB4mQ6OEC9TQkD5tCWVnaEF
         8lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420639; x=1706025439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4RhZpXa8cxxbTmltT2uMDAVbFEnYgLBeqxEfdznCVE=;
        b=V5/Wfau4GNZEOJiCcd36/XFiQREYiu+pcnorDtXqqV5sv9f3SOFug7hJeIkjh/eVAb
         HnDg3QgXzqney70r7p/AEa/IwpvzgYDNoUpPI4cAM1NuAUB67HsVfYrDKL4UwjDZMghE
         8fMiwqy/M6YwdE37WaGSHlaiqNtdsGqbBRXzx4T/HZnMpg5QL8SsTm83+CFnvZRemj61
         IhCS9cVs9D6nKG0jPj7XfiM18lNlK3tgs6FRt/iQtlV77aTCF3i+9bWdbbsVFLeE+1Uu
         CYGWTeGuTqUjWBdVRdNtV5T3Ivg5xAcOU/hC/q2dExkDJvFyLDQDPKtrhT3O53F8EBD3
         oL4A==
X-Gm-Message-State: AOJu0YxeNzuzbOxYKtnrGta715uuGzrCqjVJ7ByUK7Y9vB6pdiQcd3Et
	+/PBKZ1zSp9WFkYO2D9yl18gKM2nmtckpMrnEZklCGfBb9i8
X-Google-Smtp-Source: AGHT+IGrbyVr57m05yfAu8DAczpHcQVB3Lxz6qUfOyq8g85sgXMAGkQW1/TuqiYzaCrBBz1c4ENLyLiHyHXiDaYhel4=
X-Received: by 2002:a17:903:248:b0:1d5:c390:af86 with SMTP id
 j8-20020a170903024800b001d5c390af86mr334255plh.25.1705420639260; Tue, 16 Jan
 2024 07:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000743ce2060060e5ce@google.com> <000000000000f447a1060f11e6ed@google.com>
In-Reply-To: <000000000000f447a1060f11e6ed@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 16:57:07 +0100
Message-ID: <CANp29Y7P2rNrriEFKZAOy=UZJ+D_khwS-rY4C9Xhy-ymeTBEBA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] INFO: task hung in find_inode_fast (2)
To: syzbot <syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 4:37=E2=80=AFPM syzbot
<syzbot+adfd362e7719c02b3015@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D17852f7be8=
0000
> start commit:   2a5a4326e583 Merge tag 'scsi-misc' of git://git.kernel.or=
g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd5e7bcb9a41fc=
9b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadfd362e7719c02=
b3015
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d27994680=
000
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

