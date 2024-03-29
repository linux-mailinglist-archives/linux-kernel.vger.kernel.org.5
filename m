Return-Path: <linux-kernel+bounces-124208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E40A8913E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2201C2264C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6583CF7D;
	Fri, 29 Mar 2024 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oR7PvsaC"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEBB290E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694812; cv=none; b=XtxQpQYO4tSvXippR1TykOGA7vz/iRo+QI6VCJnXMJckKsVA9h1EjwT6ob12Tm6z4NeqNg0yN7rhvIY8nh9C4hZ2Jf53lQfl+qrfqSA7GG2DgsB06DmGJA06KwWk5jHuIxtsfFsrwyabkKMO/hrgeaIw2h4w0KRA68ASOEihvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694812; c=relaxed/simple;
	bh=gQLO6nbk5X7C1rjNiPoaIryOSL7V9S6SPG1JJ1CAIbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBjGYX7ZP/Kj8SkNGwDFPHPQywAuMhbGAlThDsiBXjqa6h+mgyuqYcoN1ZoiFpuWZuw1LCVyhB+o4+rG6/13e0C/XWHcaX6ljg5gvuDHN+04yvbrF2etUUW1Nh5OFLKHXF8Q7sTdi78gaCdt9DEKQzfigSv5o87t6UCLNB1RaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oR7PvsaC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56b0af675deso1959200a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1711694809; x=1712299609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sbaidfr8O89WQpFMQeYf+bI/yRRdxomnrj/0LkaKxhg=;
        b=oR7PvsaC3XKueUnPW8JQ4inhyh67yhMw/UArlvqgMyZoiSKBZiK2B+p5BVaGKvgTgi
         KASanjnPVXwVkB49p6SeR8TdnVRQvCNeKC+UVZ0afoZFOrWF2EeHlZtG6qvYMYi3DZgu
         zXW+nUwdnlJqjMGfMP0TLB6q8QyMAMPUxeI9goVCIwBmnLzoItatuG9J2XVcZPcPwOST
         HtQd6CSBFa1CFsTaWR23/RL8gu3TGzirCUYdBtuEx4c6XwPlcuatcoxXWWgXuHS8fXSP
         7OBt5Q+VkuTlr2gk3x0f6CnvCseWod8txxuvVqWk6XyHlM2dxATH5yzk1XRo1tXfo4DP
         eegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694809; x=1712299609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sbaidfr8O89WQpFMQeYf+bI/yRRdxomnrj/0LkaKxhg=;
        b=mLaoJHjJb3zBOQowzTgTkkPBrZyqZj48aqy5yrzB/eGNkMXUtWmCevzsk665RFSj9S
         7Qdt8R46XIVdPFLwLSbDmDS40N1rEPHqT7+gADimkiBwADOnnRZ7zApuisMHA1lBWCS5
         1FZ6rvVlsX1Yj5w1gE41ILzcdjL2jnTZ59H+6Z7chcGGUFrXFE45XB4S/fQN3OdJ09aB
         aXUjPBn3GI+6it/lwz9hIhkdp50FRYSwWXyvxT+hYnGUEt6ibCITHMEbtqmxOXdAKSg5
         2scEGY3AJTd1ZVACIU1jijblcQ0zrWk91AYYlG2ajLFAaF8c6DzxA74l66zI6WrGE6rd
         7IAg==
X-Forwarded-Encrypted: i=1; AJvYcCVKismJKkPbRCuC3UwDV7eLq4/LQSbB25kGPNHtHKjRj/XeeAvtLSVJ1+2+QYLKzqfLeIqDzyZJ0LPHeEJLEVy/HXnZPJ2pWBi9dQnS
X-Gm-Message-State: AOJu0YznLQgGzBAh3jm/8sgJEw67UdbGtAJZHj2Sn39QZRuSc3HYVtS+
	1yqkgyxJ5f6iD0VS4WTdtVJQr1Hcqw6C9sAxquUWhNKKbDgedTz9vLs+HP7KBdbvxVGW59jLppw
	pEMNfFqomlqK8kgMc7a0CZUes6GmVrgHhK2lpzOkaw6JNYGoZBRc=
X-Google-Smtp-Source: AGHT+IGIM5oN8E1SXUfbdQUXvLRfq6l9HxvWmiPlknc/i1EvF2LPXuH3k7UYzgJ38hkGGxzmtOG3mTT4NQ325KA7Q/k=
X-Received: by 2002:a05:6402:40c2:b0:56b:ff72:e6bb with SMTP id
 z2-20020a05640240c200b0056bff72e6bbmr764831edb.40.1711694809292; Thu, 28 Mar
 2024 23:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ttkro3b5.fsf@all.your.base.are.belong.to.us> <20240327-irrigate-unread-d9de28174437@spud>
In-Reply-To: <20240327-irrigate-unread-d9de28174437@spud>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 29 Mar 2024 07:46:38 +0100
Message-ID: <CAHVXubgMTe83sYaNO+SG=90=k5scaQrpApveTCO163MhUc1tdA@mail.gmail.com>
Subject: Re: RISC-V for-next/fixes (cont'd from PW sync)
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>, 
	Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 9:32=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Mar 27, 2024 at 08:57:50PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > Hi,
> >
> > I figured I'd put some words on the "how to update the RISC-V
> > for-next/fixes branches [1]" that came up on the patchwork call today.
> >
> > In RISC-V land, the for-next branch is used for features, and typically
> > sent as a couple of PRs to Linus when the merge window is open. The
> > fixes branch is sent as PR(s) between the RCs of a release.
> >
> > Today, the baseline for for-next/fixes is the CURRENT_RELEASE-rc1, and
> > features/fixes are based on that.
> >
> > This has IMO a couple of issues:
> >
> > 1. fixes is missing the non-RISC-V fixes from releases later than
> >    -rc1, which makes it harder for contributors.

The syzbot report [1] requires fixes in mm [2], if we don't update
fixes on top of the latest -rcX, we'll keep hitting this bug, so
rebasing -fixes on top of the latest -rcX is necessary to me.

[1] https://lore.kernel.org/linux-riscv/00000000000070a2660614b83885@google=
com/T/#t
[2] https://lore.kernel.org/all/20240326063036.6242-1-osalvador@suse.de/

> > 2. for-next does not have the fixes from RISC-V/rest of the kernel,
> >    and it's hard for contributors to test the work on for-next (buggy,
> >    no fixes, and sometime missing deps).
> >
> > I used to spend a whole lot of mine time in the netdev tree of the
> > kernel, and this is how they manage it (Thanks Kuba!):
> >
> > Netdev (here exchanged to RISC-V trees), fast-forward fixes, and then
> > cross-merge fixes into for-next -- for every -rc.
> >
> > E.g., say fixes is submitted for -rc2 to Linus, once he pulls, do:
> >
> >   git push --delete origin $SOMETAG
> >   git tag -d $SOMETAG
> >   git pull --ff-only --tags git://git.kernel.org/pub/scm/linux/kernel/g=
it/torvalds/linux.git
> >   build / test / push out.
> >
> > Then pull fixes into for-next:
> >
> >   git pull --tags git://git.kernel.org/pub/scm/linux/kernel/git/riscv/l=
inux.git fixes
> >
> >
> > Personally (obviously biased), I think this would be easier for
> > contributors. Any downsides from a RISC-V perspective?
>
> After you left, Palmer said he'd go for merging his fixes tag into
> for-next after they got merged by Linus. At least I think it was that,
> rather than Linus' -rcs...

