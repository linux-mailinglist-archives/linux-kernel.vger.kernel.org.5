Return-Path: <linux-kernel+bounces-27168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D890882EB70
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090541C2122D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7BB12E75;
	Tue, 16 Jan 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLTd2vUX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F06812E40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d47fae33e0so355745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705397121; x=1706001921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ldaou0SopW3YPUF7h9Xp2XJkhpv0thNyO8g3pB+Rug=;
        b=qLTd2vUXmXpl/G0rk5kGNSrk118RE/jBBzxu0nd+OLF+MHUWuZfTKHfAOwz20nt0mo
         71tSNHyv7IplMhF9FQU4U/fFokRO/5t/3PSfuKlnhIkScjpWNYlfyqLmj+gosAWLCnKA
         0Tc64YCaQ9rxlxHTbiOJw5wgL137pAQAfHQaMKSeK3HhmE/Hzb57h2lBdBru/1SU6A08
         Wn7VVfPcIksDiOUnzBRlDTw4eMSb6V+394W7fYwb0LisaTEy/bqiGrFt6c2mm+eFVzx/
         nP4FlqYOH7XHo7srCEHPx9xw7Xcszhn186fFdAei+7mRGK+v/hJNVHPLYm3DkZwzMp0g
         Dxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705397121; x=1706001921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ldaou0SopW3YPUF7h9Xp2XJkhpv0thNyO8g3pB+Rug=;
        b=hWkR7dyrRdVkrg42iuXcDeXUyekFZ7sCoA/qa+yGZU/ahEgq7zkXcs1Fqt7oCT3NpG
         yb9brivHF/sAjM3TlkxK2X14fk1s1JS7kvHofhiroFgDiJHFymjXdo9f6HzmS1NDlFNQ
         xb/Fdr8q3snwD8sl8BG4xKeTzES30kXU6/4/WSMs2Hf04kKwC7VwReeUo45YrkdaF+rI
         wvpN0uM+/V3s1GAKNe0MGSDxJHZ0HuKhWE8i/aIOKeWXWrQrcSpuGWiOQ/pOOQnkNtzf
         IDsg0MdBtYH5+y7RZOywsrrLzPMBFJEfadTcLpUMvXIP2UlglUUrAvachj0gh4JiU1cm
         JeFA==
X-Gm-Message-State: AOJu0YwiXD7fz4xW3vJHbCy26CJdHOpZsuB9LuFIKMy0Hop9aGrc2roP
	j2hNksm+y/R5AFDOzXLxRTVh4cVREodaRDYL6aoJE3fHad49
X-Google-Smtp-Source: AGHT+IHQIh0Ut+zYujtKYPxQZjerEi1xBbCKfEzixFRbxoOtZgJ0hLL/D11Fm/oz92mHELEz8luqmQL6mlYLkGotB2I=
X-Received: by 2002:a17:902:7d94:b0:1d4:c2bd:eff1 with SMTP id
 a20-20020a1709027d9400b001d4c2bdeff1mr841414plm.8.1705397120410; Tue, 16 Jan
 2024 01:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b26907060cb9f1f5@google.com> <0000000000008e38b0060f0708bb@google.com>
In-Reply-To: <0000000000008e38b0060f0708bb@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 10:25:08 +0100
Message-ID: <CANp29Y5SSDgQYufDjvU01_NUfMmRsUSKKwu+WULS2JG_2ubkaA@mail.gmail.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
To: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, bp@alien8.de, brauner@kernel.org, 
	dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, mingo@redhat.com, reiserfs-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 3:39=E2=80=AFAM syzbot
<syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D152ab62be8=
0000
> start commit:   88035e5694a8 Merge tag 'hid-for-linus-2023121201' of git:=
/..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dbe2bd0a72b52d=
4da
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Da3981d3c93cde53=
224be
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15befbfee80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D17b20006e8000=
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

