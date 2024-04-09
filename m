Return-Path: <linux-kernel+bounces-136956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C189DA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13B31C2150B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB71F135A56;
	Tue,  9 Apr 2024 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC2ntJhT"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCB613541A;
	Tue,  9 Apr 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669173; cv=none; b=Hx4nXku9XEcT6eBv5ewohFlL1n8S3YdpepLCJ2nTjLKz9GK5VI4GxfVbx+8UMS6ZKMjHZjv5AkxGq7QDOWmJvvUa/q1L9ZlFSyvYgWdoFkTIDn3tLMctyGZLYx/6lQ6l8O1eKqvbtE3LzZSMkWu7+bdZy8Jn2XeOzn7yZVswMJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669173; c=relaxed/simple;
	bh=NRfonwhpoIHlyGTCngWwrNE/NRmaYKM3LIAHKHkw2ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhAJseAPmUMDwUatU3vWFRywazXgOG0DoiJ+X0RbP6PIzTpP9ssT2FMfZw8k5cL2XbcJ6pLQ+btLEGHqX72MUC4K0X4H6MKRqUTVkGoF3gsq2spIoV/OGhpDK5QUsGjEVQD4caRRiuVC29hNpfpTm9OFmEi5qCtlj8fQB8go78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC2ntJhT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so79257751fa.0;
        Tue, 09 Apr 2024 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712669169; x=1713273969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRfonwhpoIHlyGTCngWwrNE/NRmaYKM3LIAHKHkw2ak=;
        b=LC2ntJhT05GfrRp8yCBzBJhiTIM83cChFNknn/f+34utFUnPedY9bJZEo7R4vE6KEA
         B4iy+ed9QSHwbzqRz2w/BcjbdyVYXuRgLJ/rLRmnBj8EcJF70Zi2JriWe22SR9dzaDBZ
         8J1IQW0G9/1fAefXkVUO7NE8aw42XvvuaK6qcBapRwDnYX2lwZhRSRHi6d8xv2lovQUQ
         jTrccqeSRRE7PqmxWhsyofP+Az7iHS4dnkgSCK/hzMGXynWLTk+J0IxQNGhEv4aUP1i3
         gk+ekNZjGFDPJKMNxSbdKMC71sTNzNIVQON1LjijVO7qXaAOeD9i2S14HH4nRH4vSXF3
         H6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712669169; x=1713273969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRfonwhpoIHlyGTCngWwrNE/NRmaYKM3LIAHKHkw2ak=;
        b=I1uoXklv81Jbs9F3Qa960EW86oE4YehCigkOBQjE3mpsSY68g0UiVPMZ0EHam62iN4
         ywXFK+Cg8xOZkuwk6ZGkN+qKAnQLApE/W5OvlVHIxruIco2I3dpQjE+APVlnESs60Jue
         fentgPt047SvL7m3x7ggpJjDrOhJ/4c+IrV29yg0BYGOOojpGH2bgs8f12S7xRR81T3R
         Ec39ZbInZjc2E8lNleqfSItMVfrWk65Ip/zk7snAzmlOS3mIYcRpUtnVv5pJQY8yD2nL
         rw6K7WWn1/dYXH/MZSA//miXhsqLH6OAJ78mdcuET4HoHKb0coW2AeAk93BPF2UCrUdi
         v2YA==
X-Forwarded-Encrypted: i=1; AJvYcCVjuRKnCa10KADetygJ8cKPid2vvS76EmCjsOjY74Jq3ukRnqFyfWZosyRmshkRsrQMHhNyBgir5EgL8FJjYC88wGOVh/QZuL2P4ka00G/jigJ2p+Vy58UP/FbGiBsWBmhmfHHbFdMGFvbQrONBu4sTYjjz8D/2fAvobVYTQnnrP/ej/B0J
X-Gm-Message-State: AOJu0YyzZaLvxFKrFM7bZSADw68yJH/tksH7a8x7IOESQ7pyLWQr8gF5
	syXP6GNXkhHhA/HYVzN+s9s9qKDYscqS/ANn3io7kgTNvy8KIVeEYiOarC3URxJTvZPmSW27jd/
	/b0X8KfHNxs/aXJaSN35ZFo4pKoY=
X-Google-Smtp-Source: AGHT+IHAPHXHtgUs1qAu/E5SZP8WJRLPM9FzA79lxB78vKF9mD5MkB/RXLIGH/UeMbfELkRBzsmtbxm7HxUeige5O2M=
X-Received: by 2002:a2e:9b84:0:b0:2d6:cbf2:ed2b with SMTP id
 z4-20020a2e9b84000000b002d6cbf2ed2bmr8075321lji.30.1712669169282; Tue, 09 Apr
 2024 06:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <234da60a-709f-4430-b594-386b7c2b65f5@molgen.mpg.de>
 <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com> <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
In-Reply-To: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Apr 2024 09:25:56 -0400
Message-ID: <CABBYNZJ2hGRAaPOkyC8vHrsqNtfMS2N4cMAMQTY6M9gdYdthog@mail.gmail.com>
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param >= sizeof(int)
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Edward Adam Davis <eadavis@qq.com>, pmenzel@molgen.mpg.de, edumazet@google.com, 
	netdev@vger.kernel.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org, syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 9, 2024 at 9:07=E2=80=AFAM Eric Dumazet <eric.dumazet@gmail.com=
> wrote:
>
>
> On 4/9/24 14:15, Edward Adam Davis wrote:
> > The optlen value passed by syzbot to _sys_setsockopt() is 2, which resu=
lts in
> > only 2 bytes being allocated when allocating memory to kernel_optval, a=
nd the
> > optval size passed when calling the function copy_from_sockptr() is 4 b=
ytes.
> > Here, optlen is determined uniformly in the entry function __sys_setsoc=
kopt().
> > If its value is less than 4, the parameter is considered invalid.
> >
> > Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> > Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> > Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>
>
> I think I gave my feedback already.
>
> Please do not ignore maintainers feedback.
>
> This patch is absolutely wrong.
>
> Some setsockopt() deal with optlen =3D=3D 1 just fine, thank you very muc=
h.

+1, I don't think the setsockopt interface has a fixed minimum of
sizeof(int), so this is a nak from me as well.

--=20
Luiz Augusto von Dentz

