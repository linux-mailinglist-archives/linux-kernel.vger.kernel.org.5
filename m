Return-Path: <linux-kernel+bounces-86932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3731D86CD1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14281F24DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8570E14A4CD;
	Thu, 29 Feb 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efLsujqI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36B214A0B1;
	Thu, 29 Feb 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220908; cv=none; b=E8fawCEsoCwdoIt04lkHzazqhRiCIrQ9wcyhOAVr34hiRnCgvOqYHavBT+VVDHM3Dt/YItVPUuCVSKrFjvjyDZWvifP8iCiuFOMwj+KmN29KppjQVey/ND3tG6mTXLRMZOC8HaWQ5mLHBu5G55SJ5HngQusLzlyjqSMbKlXhhNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220908; c=relaxed/simple;
	bh=l18CMgXdli5STPwKCBhLq0812Z2tTCH2Xar7VZSxkks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSnG3y9yTJ0QMImG2oL2w3NnY+5suqqWsivaJn1xI3J8n3zrfIBJIXnx9QQQ7+fbn3Rlj0puaWbU72k+LGZpJ4wdt9yJcNJNkpOJUfhqLT2TZj47w2hlrzLs8TYmdouoVPO2OFer740lpYtt2OySK7nrNaGKT/9am7nkVA6oot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efLsujqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38256C433F1;
	Thu, 29 Feb 2024 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709220908;
	bh=l18CMgXdli5STPwKCBhLq0812Z2tTCH2Xar7VZSxkks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=efLsujqIF3ljKLuLvNkv5VqcLN49SgY6P7mFVtq1WhUKrkd9tuwqvrSfJG8M6VdHD
	 fsWWu3iGBpnc2RxXWwrIiATggWE+N0jEiW4CaK63UMAvU1dC45RpAqk6G2wYK7cyT/
	 qSVrcfkhvgDoY6HNUGqpw/beOPBSE0raHNL2ODp55+tIrGnQvOFG+xT5CS0MlMe3D0
	 yxYamBLWRztV1C1kBRkvtNT37mzJQhBb/psWUBjY5hq2nQkq1XrUPTk3pNIwwJBz4d
	 nQ53p1Dc4XG5sUJIlWmXjk0xEKL+IqPf+cdpBa1UYEnPgEGvtZScL73J5XdzM5i+cF
	 AoHl2V2a/AKsg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513173e8191so1154945e87.1;
        Thu, 29 Feb 2024 07:35:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkwix50YwEuc0HLhKnVRf7AU6A8jOyPXVYEfyI3d+FRLv6iWglOh8lCgChukT4Qpe2INtprXCmGtU4yvoTD5U2LFrGjkm3/FIP/SGR2HWfoAc7JOTwjAaxt+W5ALURTDZ8+bRMUXgot3iF
X-Gm-Message-State: AOJu0YzAMXzcdbiTBPKmjICupRRQ0nOBn3ULJ6WDtgSFZz0JRiAREqUn
	dhNavViC8y2Y/dLhxSVt4juA43MPD+ZlJQpKeDD+2DeAdbqVF3dMH1ReqbNlMi0YTzcp06JiRwE
	VUrTr+MGJMKE10XXYQU2TtGomjBc=
X-Google-Smtp-Source: AGHT+IHsPm1DP53fkDMID5DY4f73drdJTcrZi2yhUcZSZ9wkEDHG01rfp3WGkZAheyE6MmID345CT7JTxjbwcTUxPuk=
X-Received: by 2002:a05:6512:1d1:b0:512:d554:f1df with SMTP id
 f17-20020a05651201d100b00512d554f1dfmr1740856lfp.65.1709220906626; Thu, 29
 Feb 2024 07:35:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223092338.2433632-1-wenst@chromium.org> <CAK7LNAQmvyftnFJaByyjH+f4nxcNUKpjkDXwebEH5AhMF6U0Kw@mail.gmail.com>
 <CAGXv+5GmkZdqpNZDFN4dcTyZ-qVS0TjrrqBrBAei6DP+eXLnJg@mail.gmail.com>
In-Reply-To: <CAGXv+5GmkZdqpNZDFN4dcTyZ-qVS0TjrrqBrBAei6DP+eXLnJg@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 1 Mar 2024 00:34:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS8tLuHYcPTb5pJZixn5Hb0yjo0nmbrfSUr5Cd_pc+WMg@mail.gmail.com>
Message-ID: <CAK7LNAS8tLuHYcPTb5pJZixn5Hb0yjo0nmbrfSUr5Cd_pc+WMg@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: create a list of all built DTB files
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:38=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Sun, Feb 25, 2024 at 4:21=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Fri, Feb 23, 2024 at 6:23=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> > >
> > > It is useful to have a list of all composite *.dtb files, along with
> > > their individual components, generated from the current build.
> > >
> > > With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-components=
,
> > > which lists the composite dtb files created in the current build. It
> > > maintains the order of the dtb-y additions in Makefiles although the
> > > order is not important for DTBs.
> > >
> > > This compliments the list of all *.dtb and *.dtbo files in dtbs-list,
> > > which only includes the files directly added to dtb-y.
> > >
> > > For example, consider this case:
> > >
> > >     foo-dtbs :=3D foo_base.dtb foo_overlay.dtbo
> > >     dtb-y :=3D bar.dtb foo.dtb
> > >
> > > In this example, the new list will include foo.dtb with foo_base.dtb =
and
> > > foo_overlay.dtbo on the same line, but not bar.dtb.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > > Hi,
> > >
> > > I hacked up this new thing to list out the individual components of e=
ach
> > > composite dtb. I think this information would be useful for FIT image
> > > generation or other toolchains to consume. For example, instead of
> > > including each dtb, a toolchain could realize that some are put toget=
her
> > > using others, and if the bootloader supports it, put together command=
s
> > > to reassemble the end result from the original parts.
> > >
> > > This is based on and complements Masahiro-san's recent dtbs-list work=
.
> >
> >
> >
> > This is another format of my previous per-dtb "*.dtlst"
> > (but I did not pick up 3/4, 4/4 because I did not know what we need aft=
er all).
> >
> > This should be discussed together with how Simon's script will look lik=
e.
> >
> > I can understand your Makefile code, but I still do not know
> > how the entire overlay stuff will work in a big picture.
>
> How would you like to proceed? I can through together some changes on top
> of Simon's patches as an initial proposal if that helps?
>
> I can use your format if you prefer.


How would you select base+addonX among
other base+addonY or base+addonZ configurations?


--=20
Best Regards
Masahiro Yamada

