Return-Path: <linux-kernel+bounces-75118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EFE85E379
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECE62819BF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E481AA5;
	Wed, 21 Feb 2024 16:37:06 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE65A41C63;
	Wed, 21 Feb 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533425; cv=none; b=kTpFYDaWbZgA+HzcE0nbK3lsTk1EpPDdzE1lg/ty1gx/i8xlIYZMPAgc1l9Bxp/JhbwbnzxFqztFSGYj4HSNHQuqGvZKLdMwqlISyr6Mex1aY2E9oVKSEREX3+Z+JjtOfVPXaX20Yvu1f46zJ/qIrss+rwWu6VMa+PsRMPLmRlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533425; c=relaxed/simple;
	bh=KyoFdkhPhVx2X21LEnK6J0yQNvf79ZpKTCuq2mcbnwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdOohHTauLstgY/WdklkEmzL7e9kjo42oluqbbJOs8cyEXssdJuZD6XkdqsFUvujZujCPxLzq01hGxrtdsg49CiVcjNAqWSTq0S080pPF48izCpxoZfU8HGmm+3B4Vf96gvOK+x3+KHOVGqY+azNYy40jXcNtaR+Wb6Ey/iQh6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6083cabc2f9so35114777b3.1;
        Wed, 21 Feb 2024 08:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533421; x=1709138221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twqtosx/XS6UyapcvN5tx0BuONfs97aPLereAOKTsBA=;
        b=wdX+3Vd9JPI/QPHTWgACRiZHzh4Qg/rpDQYF0slahODHuM387B5B8pwyxmCnV9qeLr
         0Bgbx4CwtB2gbcr7+0azdQTQsZsSp1u2Ejh2GnX+SLZWlejVcNMNzgwIBs5FW05CRWUR
         b+GwKA/b3LybM+UbObtrlCcyPDa7ogK3DJTJoaa0iIQMnH4AGFfZEB+h5ikXAINevtLS
         7I+JtT8hZxybNvHFecGNk395hTsZHu9HQn2ZHNAaqirzDXBLWz8Ji5KrFfw4bvpOaEUk
         95HBZbc1ED0jenc+s1ERnv2j9x1eZwTlYtC9Rb6ZAnztHMv9pDZ/nio8AGv2BmHzMipz
         Yh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjOX98nSVF0X8PHo/2TwT1aClyCBQZ+y35yXxI5Cx0+9T+qiOCeZRTf7gAJ7NW92xm1GzdY2E3nTsZcYyIEtyHicGB1kuzxS0mTjj6s7RuiT2EouR6kJGd3TXrm9dOWt02Vb/fgKXaZw==
X-Gm-Message-State: AOJu0YyOoUA1mUM3yYR+2g6fORg2gkIw3z9JXuwq6WZ02XaX23Yx0pOC
	b6wDlVzR/zP9u0GpCkx4EQ1+UO2EJiWB2sWVbyS/BAE/MFQWSzPwTUHjAIXgV6w=
X-Google-Smtp-Source: AGHT+IH6qmNd770DmHtL0Pjx2o2gctveDztbXRWQxUE9Qt/VpwFTnldDDneI7gaST+nLm9iWQt0nCQ==
X-Received: by 2002:a5b:c81:0:b0:dcb:fb49:cb93 with SMTP id i1-20020a5b0c81000000b00dcbfb49cb93mr16047401ybq.45.1708533421294;
        Wed, 21 Feb 2024 08:37:01 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x38-20020a25a029000000b00dc25528fe9fsm2504177ybh.9.2024.02.21.08.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 08:37:00 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-607d9c4fa90so71126247b3.2;
        Wed, 21 Feb 2024 08:37:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNTCU94HsZrcF9T8cjaZ//cpXT/m2bX6yjv11P6S2xV5KkgXE60A5hr0EoqT7OAFfxJCA9JlCLthZqLz7g6NU4hv7FGA4UOVmTYPH58n/eNLzym/u/CjTrzJf8uL2hi1KpaO381cqHAw==
X-Received: by 2002:a5b:207:0:b0:dc7:4367:2527 with SMTP id
 z7-20020a5b0207000000b00dc743672527mr15948569ybl.49.1708533420179; Wed, 21
 Feb 2024 08:37:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092826.748e70c4@canb.auug.org.au> <CAL_JsqKw9OXb=aOMni1qprzeWDBgmjdJef-6VAjwx0R--D+URw@mail.gmail.com>
 <ac9ddf79-6bc9-4daf-a271-82f8b3bca988@app.fastmail.com> <CAL_Jsq+L7uPimQfATs14EWCbqRO1vxDUmPie7=cChTLCf2od2g@mail.gmail.com>
 <CAMuHMdXNyU0eBcMe3EhhfahcRo2KtXzwdr+d_6AC-2529R3bmQ@mail.gmail.com> <7178ea35-da8d-4f25-9193-78dd11902eef@app.fastmail.com>
In-Reply-To: <7178ea35-da8d-4f25-9193-78dd11902eef@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Feb 2024 17:36:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX0G90D4ifV1OVpjPX6q0d0UyMa5iu7-s+12KiAD9zL8w@mail.gmail.com>
Message-ID: <CAMuHMdX0G90D4ifV1OVpjPX6q0d0UyMa5iu7-s+12KiAD9zL8w@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Olof Johansson <olof@lixom.net>, 
	ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Feb 21, 2024 at 4:58=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Wed, Feb 21, 2024, at 15:51, Geert Uytterhoeven wrote:
> > On Wed, Feb 21, 2024 at 3:27=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> >> On Wed, Feb 21, 2024 at 7:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> =
wrote:
> >> > On Wed, Feb 21, 2024, at 14:53, Rob Herring wrote:
> >> > > On Tue, Feb 20, 2024 at 3:28=E2=80=AFPM Stephen Rothwell <sfr@canb=
auug.org.au> wrote:
> >> > >> arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_ma=
p): Failed prerequisite 'interrupt_provider'
> >> > >>
> >> > >> Introduced/exposed by commit
> >> > >>
> >> > >>   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> >> > >>
> >> > >> I guess you missed some :-(
> >> > >
> >> > > No, Geert separately posted fixes for already.
> >> >
> >> > I did make the mistake of applying the final patch "dtc:
> >> > Enable dtc interrupt_provider check" to the arm/fixes branch
> >> > for 6.8 along with the other fixes.
> >> >
> >> > Clearly that should be separate and only go into mainline
> >> > after there are no more regressions, but now I'm unsure
> >> > about the other patches -- did you intend the dts fixes
> >> > for 6.8 or for the coming merge window?
> >>
> >> Either is fine with me. My intent was the whole series plus the
> >> Renesas fix to be applied together. Anything new that crops up we can
> >> fix on top.
> >
> > If you want me to move commit b4f97d1b5aeb6166 ("ARM: dts: renesas:
> > rcar-gen2: Add missing #interrupt-cells to DA9063 nodes") to
> > renesas-fixes, please tell me.
>
> Up to you. I have done some merges yesterday but have not started
> merging the dt branches, so you can still send an updated v2
> if you prefer (or have this patch in both branches). Please
> let me know how you decide.

OK, will move it to renesas-fixes.
Note that b4f97d1b5aeb6166 was not included yet in the last PR
I sent to soc, so you can continue merging DT branches.

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

