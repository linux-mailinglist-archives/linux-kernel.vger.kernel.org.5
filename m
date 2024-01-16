Return-Path: <linux-kernel+bounces-27547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B4E82F1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ECC1C2333F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300C1C69E;
	Tue, 16 Jan 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOxs3Nei"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C11C68D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
	b=HOxs3Nei7lljq1SVh7G0LeW4rRAG7WaifigHaTdYXGtsGQYlbhGlkaLfbW9rvzT7NSUlqq
	DU6864YbXSwNOJz5qCOoyr+3ToPJZDfew0FWLhH7hIKBnUPw+CozCvXAQMwhHawsHqhhv7
	q8qfczitXSCF/HGuCoc9HUcyrlHHsKA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-0o-Ta8GrMdecWpoxD1yE-Q-1; Tue, 16 Jan 2024 10:55:57 -0500
X-MC-Unique: 0o-Ta8GrMdecWpoxD1yE-Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf4fdafb49so1226630a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420555; x=1706025355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkaObLRiZU2WVUtOEp3KCOMnmv+FaFDDWJ1dwMpQFZ4=;
        b=Z1Yo/xROzm+7c1u5yhwmfCZ13uYETn+Kl7q4+3K2hGcIsYH4BoHsdSau4ujygHVRsv
         dI5rmgq4XXVky7nNTT1Oaojqqr8WGvHHkkQBU/gAFK56B44iBbgeTRFfX7R7Ie2ddMt+
         tf2DykVZyT/Ecy/CR8V+9f7IXRjd8YqJVblQa1myO+qyaP/LgBTwgDF/PZYAzXRsIdoN
         u8Av1yXUpaNJNf1v+XHT6aZxXdhVAecAD6MAsCrJ30RJNXQPJNSNsf4XzZtU5jW/I3Ly
         IRLDEMs6hCEK8pkVtXwyiZoATJuZbd1PA7DntPwomho6JX7dLjLIHtCzXVAfb+Ow6iXr
         aaoA==
X-Gm-Message-State: AOJu0YzIeF33e5qCnOtFlrdl6FhN5SOPQUCBql8m7oqUm749H1rSTcbu
	hPeZ6TgvQK/IX1BfBJqf8YF5EmZRz0U+FhvGIqBL8GVFtzGOMSEyBf7sZM0h/Ee3PvCReDvrup2
	pI2v0pXdrbDXDpWJuCceKGIx5HJbDMgtD9rL78r1oa4BSlrahj3/6gAHa
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id bh11-20020a170902a98b00b001d4672f4809mr3966889plb.129.1705420555676;
        Tue, 16 Jan 2024 07:55:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQrzkzOTwvJXIqY16Mk/9F/L79khIzMK3iukN9JqmT78QTW3UdlrX8fmF1HTGkx/EuRv2R27m2byQtY34e3Y=
X-Received: by 2002:a17:902:a98b:b0:1d4:672f:4809 with SMTP id
 bh11-20020a170902a98b00b001d4672f4809mr3966881plb.129.1705420555426; Tue, 16
 Jan 2024 07:55:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000057049306049e0525@google.com> <000000000000fa7c3b060f07d0ab@google.com>
 <20240116103300.bpv233hnhvfk3uvf@quack3>
In-Reply-To: <20240116103300.bpv233hnhvfk3uvf@quack3>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 16 Jan 2024 16:55:43 +0100
Message-ID: <CAHc6FU6wzkniuMormDzthUpj3fCap-iFFRfa_skEAvp6fwBOJA@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in glock_hash_walk
To: Jan Kara <jack@suse.cz>
Cc: syzbot <syzbot+10c6178a65acf04efe47@syzkaller.appspotmail.com>, axboe@kernel.dk, 
	brauner@kernel.org, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:33=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> On Mon 15-01-24 19:35:05, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D165bebf5=
e80000
> > start commit:   3f86ed6ec0b3 Merge tag 'arc-6.6-rc1' of git://git.kerne=
l.o..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dff0db7a15ba=
54ead
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D10c6178a65acf=
04efe47
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13e4ea146=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13f76f10680=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
> >
>
> Makes sense.
>
> #syz fix: fs: Block writes to mounted block devices

Thank you, Jan.

Andreas


