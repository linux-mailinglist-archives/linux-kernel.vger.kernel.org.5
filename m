Return-Path: <linux-kernel+bounces-95368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A49E874CCB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958681F23B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8531272B1;
	Thu,  7 Mar 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5fvhh+y"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B210125DC;
	Thu,  7 Mar 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808980; cv=none; b=rOL+BIVGuk/6YKFuhdPqSe96plhxnzXP4qEKfVcN224DXGS9v+yRPZtRjz0eBprnC6oEpP84jGq1gF/xGucrgukWXmPQgx4xLt9xEQqkz0FErSKixZZESVp2W2K1+nEoCJC0sdQ/4WqYteSeJHJ9FWKO0iBzqtszljgxrp+g8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808980; c=relaxed/simple;
	bh=2GgQweUhzFLfzUjhti26P2U1kq5XmI/CYrNVeRbxi+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAAhpm7UpqvNKz62rNI6gxKgIx/CqLk39iqg6CIOeQ3okqVzcSRZS4LjkrEXoTZYvoWcb5bCYlZ161KZDC6Ptf2pWk2BA/FUE9BW1aVtDQd18X7TnNpRoGPoe75As5KC9CRPbeTEreHBWPXTpWjLOWvtyqjh/0EDtsKr9lfbQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5fvhh+y; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4d35b644c1bso231863e0c.3;
        Thu, 07 Mar 2024 02:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709808978; x=1710413778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APg0N8EtrD5ihsxq8VybDP8ajvEhmkrsMBzTGWpbS9c=;
        b=T5fvhh+y8uVwaLMrEYnaOyYOT7Ua2AocIGzkBp1T1wAo1TOPuoB8LI5h6/Vv8OPyFe
         1rTcuwdlrsi/Xl2ZLUZEVDiy5yd1SwiiXlj+KluYSzvjIkNIxr9qlRoN03TD8Hrr0MOI
         DcbAw8lHqFgDgsb92x0O9OxtnKr2sGJCYJ+ElCFtkB97Q0abi4kBS9LiT9XKHRVIpR/h
         ebMlkuzzdI9l6z6XFMZhgaRkmHZbBe54ANYDbqgF1XSXHWcqznKGK8LiIuewX+sKncjf
         gGGF4rvUZRl/ajQ9QAYB7P83kT0QQnB0ui8RRAhmZGo4dOFcQlTlqRccByAGQZHkSCVb
         T7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808978; x=1710413778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APg0N8EtrD5ihsxq8VybDP8ajvEhmkrsMBzTGWpbS9c=;
        b=N7xS82WdhZriDKLx6hpHopI+tGsPTLAM3yyzMzuYgbysFk+GL6jd4ihLlb/jWq907Y
         /BfCznTm4XdbUkkqE3bfR8ECESHhjTS0sjUB+2TkfsBIotNbLDkATkEWIC8gMfgpSzy1
         Z7iPzE8xVsmchg3RgG1BKUm5D9wtNvkoLmcZ8A7jsOc3w4s3QV3pHsaw4Uk2qXoftIbp
         oMqj6xtyiRGVRe4u7vprNgQ1DOkkhN2S/Ayt+8LQiVNfy+5YVibZCGS3bseFyImb4Fk8
         ZQP1WoJvzvBqSFyLQ0D4ogBd29gxhchuzzOCwtF/WD+gxjW9lfuQXXG3kcPA+aL1pwij
         VfdA==
X-Forwarded-Encrypted: i=1; AJvYcCWcCpU9jaaLGTC50FSnYv2yeBU0Wi1BFleASAgEyIOnN7zlsumxpupE+EiCtHnb+ST+YgIveBAiLYrj/4HvgXJslcxQcQ2Ucj4YaajqrcGkV5wltduldExo1j6BHnINyfjXbrbFsdZX/QLUit4QTDT8vf+CjLnFOkerM56oJhkjSe1O7Uf4Uxzx4oi/5+H+DUBnp9IRt3TaWrVHrKrxi0NUMoKZDrglzCVe
X-Gm-Message-State: AOJu0YwaJwfJocpTwTWYWXt0PLR5DgrpqFThCwpk8v763VTQapD2y5x5
	XaEc4u7xBuLBST4LZRKVaSdx9TIw0MbT48mbgfha0nOS8uXJtGdP5a2g+qrGOLdd6PL16TPuK9Y
	Ig1k4w7Bhg5cTclJzDS5gK5PlB3g=
X-Google-Smtp-Source: AGHT+IHwiECTYUsVDlle5F8w3ZHAzBBT1vnPBCdYReaj9r/gIrBvUM1my/kEbtph3MIKxEtZR711+TWUoBbC32iGjfY=
X-Received: by 2002:a05:6122:200d:b0:4d3:3878:a523 with SMTP id
 l13-20020a056122200d00b004d33878a523mr7038781vkd.12.1709808976570; Thu, 07
 Mar 2024 02:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
 <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
 <CAMuHMdWX=OZJ3DE0vb4=k=6yH_L5JhusLRpVqJkJ0Xv3oT8_TQ@mail.gmail.com>
 <CA+V-a8uq=gw0_EVT3_CZD0TO+-DnSqXJtFakFcNWHOfq58g4aA@mail.gmail.com>
 <CA+V-a8vunmsUfGkFO30nwvqFkiks7vceLgG1jo7TcsFajeckmQ@mail.gmail.com> <CAMuHMdU0pTGg72r4+PkwyTin6pp1kApHruJUE5oSrdGucLYV7Q@mail.gmail.com>
In-Reply-To: <CAMuHMdU0pTGg72r4+PkwyTin6pp1kApHruJUE5oSrdGucLYV7Q@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 Mar 2024 10:55:10 +0000
Message-ID: <CA+V-a8vmOv3qZEzz8jAHMmhT2d4kVTQ4ZZ5iOz4Lf3rN4nHbhg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Thu, Mar 7, 2024 at 10:18=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Mar 7, 2024 at 11:09=E2=80=AFAM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Wed, Mar 6, 2024 at 10:21=E2=80=AFAM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Wed, Mar 6, 2024 at 10:15=E2=80=AFAM Geert Uytterhoeven <geert@lin=
ux-m68k.org> wrote:
> > > > On Wed, Mar 6, 2024 at 11:06=E2=80=AFAM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@=
linux-m68k.org> wrote:
> > > > > > On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.cse=
ngg@gmail.com> wrote:
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Document support for the Serial Communication Interface with =
FIFO (SCIF)
> > > > > > > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF =
interface in
> > > > > > > the Renesas RZ/V2H(P) is similar to that available in the RZ/=
G2L
> > > > > > > (R9A07G044) SoC, with the only difference being that the RZ/V=
2H(P) SoC has
> > > > > > > three additional interrupts: one for Tx end/Rx ready and the =
other two for
> > > > > > > Rx and Tx buffer full, which are edge-triggered.
> > > > > > >
> > > > > > > No driver changes are required as generic compatible string
> > > > > > > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H=
(P) SoC.
> > > > > >
> > > > > > If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, y=
ou
> > > > > > state that the current driver works fine (but perhaps suboptima=
l),
> > > > > > without adding support for the extra 3 interrupts?
> > > > > >
> > > > > Yes the current driver works without using the extra interrupts o=
n the
> > > > > RZ/V2H. The extra interrupts on the RZ/V2H are just sort of dupli=
cate
> > > > > ie
> > > > > - Transmit End/Data Ready interrupt , for which we we have two
> > > > > seperate interrupts already
> > > > > - Receive buffer full interrupt (EDGE trigger), for which we alre=
ady
> > > > > have a Level triggered interrupt
> > > > > - Transmit buffer empty interrupt (EDGE trigger), for which we al=
ready
> > > > > have a Level triggered interrupt
> > > >
> > > > Thanks for the confirmation!
> > > >
> > > > > Are you suggesting to not fallback on RZ/G2L and instead make RZ/=
V2H
> > > > > an explicit one so that in future we handle these 3 extra interru=
pts?
> > > >
> > > > In light of the confirmation above, I am _not_ suggesting that.
> > > >
> > With the introduction of validation checks for interrupts, falling
> > back to "renesas,scif-r9a07g044" for RZ/V2H will be difficult for
> > validating interrupt count.
> >
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             enum:
> >               - renesas,scif-r7s9210
> >               - renesas,scif-r9a07g044
> >     then:
> >       properties:
> >         interrupts:
> >           minItems: 6
> >
> >         interrupt-names:
> >           minItems: 6
> >
> > With the above check RZ/V2H fall into this if block,
> >
> > Is there any way I can specify to match two compat strings?
>
> if r9a09g057 then ... else if r7s9210 || r9a07g044 then ...?
>
Thanks for the pointer (I was grepping for elif ;)).

Cheers,
Prabhakar

