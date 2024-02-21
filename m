Return-Path: <linux-kernel+bounces-74943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64985E04C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76501C24030
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581698004A;
	Wed, 21 Feb 2024 14:52:06 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF20B3D393;
	Wed, 21 Feb 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527125; cv=none; b=LMKdXBpneo2+pzJ/w/THpqPYAdjNOQ4agoOcPCXFkn88pZ21ivtjc0o16TJzG91ESr/wilgac3MvUyXAbNvrPRyOVF/NCA/UUva0MToHtosHiYbJk9qdKX8e1r6bjXet3BH8l5Yk9j/twx9Q3Ram59IEyDCrLJq6hLi85rI/sb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527125; c=relaxed/simple;
	bh=dYqhxvGpBkoLMh7laZ8Pp5bbExsdnPPFLjMXeaKuTl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZpLx9B8J0k9V+2CrpGBukI7dSWpq3CUZMswyxB5REAuT9K1+UcIsuq0j0i1GfzRwY/Y/F+SVAAEZffnU7MJ07NXKDsjNXLHGDbNf2j6FRqDI+fuuTEaBvBGlS4L32W3TEk4zb34GFficj0Zn4JZkKgr6fNtiYimmNNjxXj0u5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-607f94d0b7cso57919727b3.3;
        Wed, 21 Feb 2024 06:52:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527122; x=1709131922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uN11UFtAgBpi/BZo2e/MPjOkd4Zyv9OPcg+zAzU/+s=;
        b=d5y6E1AT8yXgNomJ1sH1IBB6gA1/mEt/UV8KCvvIi4X+QD8yNa3jvrOlX0rK5fy/2z
         RydsMi82uhOKY99imr6zclwBLdlzhqvMOd+Bo2jPSW9oVyqXqBOVdoPsk650zdPdiFeO
         0UtqU4gx8HmzbLocTvdbTpSVH1XzsYCzVAdpkGk57VDnCRoIWEwWCw62onBi5CSookN0
         Re81yziMY0KQ7lZFd9ECNjFzfSZY4a+kD1yH01gJ8Qt0yVTWYkZKN7nWAlEOLGWTAF6w
         nPRb0pkphhCF94J1smQGgKb/Q35b1yaaVYUtFGUVqliEX14Md78xRlJuS2RG1HGdDiFI
         9a/g==
X-Forwarded-Encrypted: i=1; AJvYcCXp/0jcWjh8zafF2CMuqkXk1I4+9EphQQbVunVP2+kDaKAGOmnJjPjCy96QB+UuBnbAxsuAKfe+P8jOG6JdKRyDlaqvxITV8V7L1nnpf/aGAOezGex1qurgY3EiIWx3OMgiGZQKqkltGQ==
X-Gm-Message-State: AOJu0Yyqrv3uwiXIFpJzZrJfhU1yPFUF4Zd6KlwoeNuR2Dt8Tl4oJSU5
	V1l2YIZAfwGOZbZccZO+FDLa/wC+skCaNHAjr2spKZ+QtdAsycVNyx9B4Q6yA2A=
X-Google-Smtp-Source: AGHT+IG6zbYRcaLR4tw2JSlpBvD5t6q92s4vA1aW1JKhoO/6/Jkh45aWS9e1YW65V7s0cN+3zII9Dw==
X-Received: by 2002:a81:b71b:0:b0:604:3ee2:f258 with SMTP id v27-20020a81b71b000000b006043ee2f258mr16776988ywh.45.1708527122575;
        Wed, 21 Feb 2024 06:52:02 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id w71-20020a0dd44a000000b0060885da5f54sm198194ywd.121.2024.02.21.06.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 06:52:02 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso5620386276.0;
        Wed, 21 Feb 2024 06:52:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXlmLn3QICsDt+OcH1i1UtObBGjJFQaBSZ582zrc63QICFJavW35oJTIdZRdcU1kPQ6OyO/XgkFufI8zH9qr2E1X2Gs3M3Iwse8rHW3sBW1Yx9AVh3hCJekYx36gzp++ooHceqe7mGCPQ==
X-Received: by 2002:a25:ae1a:0:b0:dcc:8aaa:3ed3 with SMTP id
 a26-20020a25ae1a000000b00dcc8aaa3ed3mr16385906ybj.16.1708527121854; Wed, 21
 Feb 2024 06:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
 <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com> <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 15:51:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com>
Message-ID: <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Olof Johansson <olof@lixom.net>, ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob, Arnd,

On Wed, Feb 21, 2024 at 3:27=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
> On Wed, Feb 21, 2024 at 7:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
> > On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
> > > On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb.au=
ug.org.au> wrote:
> > >> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > >>
> > >> Introduced/exposed by commit
> > >>
> > >>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> > >>
> > >> I guess you missed some :-(
> > >
> > > No, Geert separately posted fixes for already.
> >
> > I did make the mistake of applying the final patch "dtc:
> > Enable dtc interrupt_provider check" to the arm/fixes branch
> > for 6.8 along with the other fixes.
> >
> > Clearly that should be separate and only go into mainline
> > after there are no more regressions, but now I'm unsure
> > about the other patches -- did you intend the dts fixes
> > for 6.8 or for the coming merge window?
>
> Either is fine with me. My intent was the whole series plus the
> Renesas fix to be applied together. Anything new that crops up we can
> fix on top.

If you want me to move commit b4f97d1b5aeb6166 ("ARM: dts: renesas:
rcar-gen2: Add missing #interrupt-cells to DA9063 nodes") to
renesas-fixes, please tell me.

Thanks!

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

