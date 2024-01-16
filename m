Return-Path: <linux-kernel+bounces-27548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883B82F1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E361C235F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318391C69D;
	Tue, 16 Jan 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBKMT6dU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B031C68C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d5ebcbe873so109355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705420600; x=1706025400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=QBKMT6dUgLRzgFYYm7KfYvmiVdMDDPRKLRQioHU4Xk4pVe0IR1ntkUAeOccIEMJ5ji
         7U0IIPd8Tf8cHxE8aRBzKv/PKIwaAKdWTm45aH4csGrMqkbUMZoydDqU5liiYI4EnUI0
         lCgCGUg2bwVN8WcZEa2ikKgldhQDRRiATB13oxtaYHd88/5rBzrvQUGKofdqNDHtQR3x
         LErFu/ETXgM+JRSZZ83NRKy8uDE7MLWkR/PLc/1UqvDp4q52G5WEIWNMb0tg/gKwDtDF
         JA+ljdgD8vF4JzW8qf35mi4gNqAj0EAXBKVEVX9G1LTr5fZxHKws7IYTKY5ZcEjm9ltd
         aC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420600; x=1706025400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=PqvaLNkQTY5DpFNx0Yh88W/Q1K6SAll2r3huE90kjyZI9kbng/ULdLeBmDHns1vCfu
         dspXUOFZYnw2Y8jEfCOHEU7fP05uOgjbHQC4BM0XoJYfJm+nLVb5eEXjGSwoAxc33Goe
         0EaND/fxkcEzEzicJ+vgyCZDp8zrurEnqLQW+UdBzOIwyyCgS8J/MSEUJp6B2H6kZK7Y
         KHEINwJQQetEkufdw0hgMRP6IFIFr5JfHToys3+jhwAHfCqiaiZMY9odysh4r9/Dq42O
         VNPHhNS2RLtG3VdM/pHmdkXh93WXhwFJqT95HGR0rJ6nryIu9G+bsqlD+ipLkuiRCeaq
         7H2Q==
X-Gm-Message-State: AOJu0YwT6aHCn7ap56gVHPJAtQNJ9QAbENokA5frudmTvT7siWjzDQDY
	+jZ1b3yUdACR9ih9wHsCNP+WfNYMPcs2J/jinL2gry7NbR/n
X-Google-Smtp-Source: AGHT+IEFpSNk4yBS3FQmOkIM6MlBaIX6qNQNXfqDHiHknuvALzTkBvr0USexOou2u5DTtKnzkASC4edoT/chV8i6aJg=
X-Received: by 2002:a17:903:191:b0:1d4:ceab:58ba with SMTP id
 z17-20020a170903019100b001d4ceab58bamr6868plg.10.1705420600448; Tue, 16 Jan
 2024 07:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008d00ec05f06bcb35@google.com> <000000000000ac2378060f12234c@google.com>
In-Reply-To: <000000000000ac2378060f12234c@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 16:56:28 +0100
Message-ID: <CANp29Y4J+bAFu5r8-hATpmsyNJ+insC5Qhws_qops5N38+Fiyw@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
To: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 4:54=E2=80=AFPM syzbot
<syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12452f7be8=
0000
> start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' o=
f..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e2d7bfa2d6d5=
a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2b32df23ff6b5b3=
07565
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14860f08480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D174d24b048000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>

