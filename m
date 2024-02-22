Return-Path: <linux-kernel+bounces-76349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C685F5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 333E9B21E35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769283FE3D;
	Thu, 22 Feb 2024 10:45:46 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D73FE47;
	Thu, 22 Feb 2024 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598744; cv=none; b=qppBWUSfO7J5xm76oFUCxI//KHMO/ZDfGy2Rr2modWa7qHmaFSLVdGp4b0fnJbE+VGix2NfZKPdA8YFwJkKouA3thmbp1qR/G0Oz52gyLwLVaYR6TWjbQhh+1vjw8h/S8s46QhJTx66qthM2GQX3y7/aQ7dRHvkPQeT6ZWdn/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598744; c=relaxed/simple;
	bh=svIFK8g3OJaGYcfi9ddpJJtCOaE+QXYs7Dk3B7v8jno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqdz4hLL9yw4JpfbjUCt0c3sAlNixfqtl8f5/eU2YnGu6clhZYlxk79swcsgsgbYqcObX8UQsi/chRZ8FmHkHcRWOcLZ+BMqKltpPQyevP/FAEJFTjXRwY9W7ZYHsjcVSVvU7wFDAcktLaZayV1EvZRHV/2wfy6FcCkk3eooHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6785910276.3;
        Thu, 22 Feb 2024 02:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598727; x=1709203527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4VkjVhQFbw36Dc5vCR5db7ZoL62PwqiOAoaC/EBMYQ=;
        b=Tm77Fz3sEh8Ef+JFcaoGT9fUr3utNgvcxYbp6iWsxchgHy0u3GO/9vTVFu7fwpowNe
         KSeCy6PE0Hpu24yKAS55Zt1Od3dEQiKpuGzAQmsGcL9KfkoH8p7xzFv7D/1D+bzWnUGB
         PhIzE90/8PUM4s2E1GCQuAa/o24hC6ZBxD7q0wgvrIDc5oN3VcxFH+9Cz6VkkgeIvb01
         DaUC9bJFs51r7r4WMBLa7Xh/a318TYH0KVlewwAFkDnEmQskUgp9hbjygR5XDY2U1zhf
         oXPdVlNyoURubE/O8oZevpkdLoRM65c95/DDnUGyspv31lXIfGA6/MiKjXw6gxlmEKbt
         QaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRitni8kGJswaLymF8xa05Uxm6GHfx/T/xkfyl2pmyW+d/EV1A8P9ZSYq7srP4ikCKY1U8tC2/Db6a2RwR094+nRXwmzrtg4OhM4R/B2rcjMnbWWgX8wxlzjMBg1D9u7r4bGR6PRbVcw==
X-Gm-Message-State: AOJu0YzvmnsXvdeYwPFzQsuy/S+O55EdAyLOXJ+k4GQ9qKhT59CXj34Y
	f5sKlrt8lnsDXOdxNk4YhSKVFBKVviw5qoMF1WX0hBVzUjbuzfpfPOFsARwepKw=
X-Google-Smtp-Source: AGHT+IETwEXLo7fl1hRyScuq746SKmavvZUXp2ocbQlTcqV2ykNTKNjW7HCB7zn+XEKt/HW9mVaiUw==
X-Received: by 2002:a5b:38e:0:b0:dcd:905:3d17 with SMTP id k14-20020a5b038e000000b00dcd09053d17mr1875611ybp.32.1708598727432;
        Thu, 22 Feb 2024 02:45:27 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id u11-20020a258f8b000000b00dc22f4bf808sm2688569ybl.32.2024.02.22.02.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:45:27 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3a09e96daso6785881276.3;
        Thu, 22 Feb 2024 02:45:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnxoZg2eMjAYs9/svFWfXyBYPpqgWGem6IS58W9RxQ3Fel+BWL0EbQJtg9zOayqkLj6Npbuwz6erK3/dgDX36GGL0aAn2Ilspp+KSE9M0X4GdoTrDE13rrz2tGzYtuJBGUnjgjxIpeRw==
X-Received: by 2002:a25:ab24:0:b0:dca:a3e8:a25a with SMTP id
 u33-20020a25ab24000000b00dcaa3e8a25amr2064989ybi.62.1708598726440; Thu, 22
 Feb 2024 02:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
 <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com> <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
 <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com>
 <7178ea35-da8d-4f25-9193-78dd11902eef@app.fastmail.com> <CAMuHMdX0G90D4ifV1OVpjPX6q0d0UyMa5iu7-s+12KiAD9zL8w@mail.gmail.com>
In-Reply-To: <CAMuHMdX0G90D4ifV1OVpjPX6q0d0UyMa5iu7-s+12KiAD9zL8w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Feb 2024 11:45:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU4qk0xY228uNoDpB5oQESc_MZzVf8hwXVL3penneBPKQ@mail.gmail.com>
Message-ID: <CAMuHMdU4qk0xY228uNoDpB5oQESc_MZzVf8hwXVL3penneBPKQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Olof Johansson <olof@lixom.net>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Feb 21, 2024 at 5:36=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, Feb 21, 2024 at 4:58=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> > On Wed, Feb 21, 2024, at 15:51, Geert Uytterhoeven wrote:
> > > On Wed, Feb 21, 2024 at 3:27=E2=80=AFPM Rob Herring <robh@kernel.org>=
 wrote:
> > >> On Wed, Feb 21, 2024 at 7:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de=
> wrote:
> > >> > On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
> > >> > > On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@ca=
nb.auug.org.au> wrote:
> > >> > >> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_=
map): Failed prerequisite 'interrupt_provider'
> > >> > >>
> > >> > >> Introduced/exposed by commit
> > >> > >>
> > >> > >>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> > >> > >>
> > >> > >> I guess you missed some :-(
> > >> > >
> > >> > > No, Geert separately posted fixes for already.
> > >> >
> > >> > I did make the mistake of applying the final patch "dtc:
> > >> > Enable dtc interrupt_provider check" to the arm/fixes branch
> > >> > for 6.8 along with the other fixes.
> > >> >
> > >> > Clearly that should be separate and only go into mainline
> > >> > after there are no more regressions, but now I'm unsure
> > >> > about the other patches -- did you intend the dts fixes
> > >> > for 6.8 or for the coming merge window?
> > >>
> > >> Either is fine with me. My intent was the whole series plus the
> > >> Renesas fix to be applied together. Anything new that crops up we ca=
n
> > >> fix on top.
> > >
> > > If you want me to move commit b4f97d1b5aeb6166 ("ARM: dts: renesas:
> > > rcar-gen2: Add missing #interrupt-cells to DA9063 nodes") to
> > > renesas-fixes, please tell me.
> >
> > Up to you. I have done some merges yesterday but have not started
> > merging the dt branches, so you can still send an updated v2
> > if you prefer (or have this patch in both branches). Please
> > let me know how you decide.
>
> OK, will move it to renesas-fixes.
> Note that b4f97d1b5aeb6166 was not included yet in the last PR
> I sent to soc, so you can continue merging DT branches.

Moved to renesas-fixes, and PR sent.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

