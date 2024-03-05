Return-Path: <linux-kernel+bounces-92685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79349872459
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6B5285655
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FF08F49;
	Tue,  5 Mar 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWK5eHJ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A253F10F7;
	Tue,  5 Mar 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656257; cv=none; b=PsuN09kEtIzsXCcCD702/Lq45LW8YKt58Ru9D6ZpooJz2hYbsaUKbNs1BmLNAxyUzU2/vmVw3HV4bq8jkla28DwnrPsc1psOongHwinzB4c9OEvF/27FVumMfbpaMvzkBpPvJccCbRPeDo9jfD89UAP+U1uTR6/Y+bjtMoFwJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656257; c=relaxed/simple;
	bh=UjBEAVMdzvLalmwGNh/rQJ83m5pRMJtn7UmSXJVcmGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmUV+xMkShm0Ti8MN5K2XnfUCWLX+2eYVhFxQTy+3FgtKfeSjnVNA8YviMYxh4NLcqFEp5krekmoX9IVq0GqIroMmVt6VfetLHGv/JQcUwpfYS9gFkHehTmWTB2yB1Nr6PELQS15vQkKdvAAERt7Z5J5TnuQI7iLw++zZMaiDlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWK5eHJ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28259C43390;
	Tue,  5 Mar 2024 16:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709656257;
	bh=UjBEAVMdzvLalmwGNh/rQJ83m5pRMJtn7UmSXJVcmGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SWK5eHJ4KFwRb8vJnqk+5C4fZJ3mEn28cZBqaF1lX37hvkVB3K3d0X3piXIm0dyzr
	 eML+41LdnPvg8nEuDVfF2xQP5UijhgpSzK7hh7EPOmUcf264YABeq3gT4YfUj4z2pz
	 sI9UYi5rVd3MkthV8G5cQnsf9FYfzEBxsGVEucCMEkXiNYYxOfUoHkRmvn6x1sjEMl
	 zHsW3c39Ig2Q9cY20bU8AvDAyQPLVnhmA/Xiem9LSJDdg31Cb459NBi09tBqSuyY6C
	 7YB068rgyNLcITfhtt6TYwmvkCnn8Uxurec6M4Jmkub6RXrkpsmylXcF2dE4JhCCXE
	 rvEK9l6L/igDQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513173e8191so7355317e87.1;
        Tue, 05 Mar 2024 08:30:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+NCS9XUXUj0JW+6IWTg+MDWsWHMLMtdX3ANslDs+Ty6njAU+2/3AVNfNVYjcQp3P/Hw3ygrAiDADCuqihcWxZX+zsb5HwR8lz52fkg6P+YR1A+eNh0SVWaoHqCpZ+tbF4kUOQhAAxdOGr
X-Gm-Message-State: AOJu0YzJ77Q6iBjmd/kOo+UPiZ5z3H7BokFDku+3AiEQHLifVol9CGmi
	hx3n3ODFb/SUG/2Deopvuxzn1rluaSXnrXY/xhYZzEqqZHcgEXCfLAjT/OK2HGj3unG/zm8hCj8
	qYGrk9OPrl+wm6D+PGUTuQriGmrI=
X-Google-Smtp-Source: AGHT+IFiPqEUjF7c5/b6AJpP+FSGeN2AXinKrPbenG+dYSxMtaeqEQP1fyxt+zhygfGtBe3r3ewBs2xKBH/PgUB//p0=
X-Received: by 2002:a05:6512:219:b0:513:2caf:15ee with SMTP id
 a25-20020a056512021900b005132caf15eemr1652548lfo.28.1709656255566; Tue, 05
 Mar 2024 08:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223092338.2433632-1-wenst@chromium.org> <CAK7LNAQmvyftnFJaByyjH+f4nxcNUKpjkDXwebEH5AhMF6U0Kw@mail.gmail.com>
 <CAGXv+5GmkZdqpNZDFN4dcTyZ-qVS0TjrrqBrBAei6DP+eXLnJg@mail.gmail.com>
 <CAK7LNAS8tLuHYcPTb5pJZixn5Hb0yjo0nmbrfSUr5Cd_pc+WMg@mail.gmail.com> <CAGXv+5HB7gXJ0x1uVdgbWaRWS8+rN6FwEgyGLObxr_cfyLty6A@mail.gmail.com>
In-Reply-To: <CAGXv+5HB7gXJ0x1uVdgbWaRWS8+rN6FwEgyGLObxr_cfyLty6A@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 6 Mar 2024 01:30:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARADnpCHvNWHLqb9acVNqzwDRuLiKbKe4XZwM4_Ts+ypg@mail.gmail.com>
Message-ID: <CAK7LNARADnpCHvNWHLqb9acVNqzwDRuLiKbKe4XZwM4_Ts+ypg@mail.gmail.com>
Subject: Re: [PATCH RFC] kbuild: create a list of all built DTB files
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 1:37=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> On Thu, Feb 29, 2024 at 11:35=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > On Thu, Feb 29, 2024 at 11:38=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.o=
rg> wrote:
> > >
> > > On Sun, Feb 25, 2024 at 4:21=E2=80=AFPM Masahiro Yamada <masahiroy@ke=
rnel.org> wrote:
> > > >
> > > > On Fri, Feb 23, 2024 at 6:23=E2=80=AFPM Chen-Yu Tsai <wenst@chromiu=
m.org> wrote:
> > > > >
> > > > > It is useful to have a list of all composite *.dtb files, along w=
ith
> > > > > their individual components, generated from the current build.
> > > > >
> > > > > With this commit, 'make dtbs' creates arch/*/boot/dts/dtbs-compon=
ents,
> > > > > which lists the composite dtb files created in the current build.=
 It
> > > > > maintains the order of the dtb-y additions in Makefiles although =
the
> > > > > order is not important for DTBs.
> > > > >
> > > > > This compliments the list of all *.dtb and *.dtbo files in dtbs-l=
ist,
> > > > > which only includes the files directly added to dtb-y.
> > > > >
> > > > > For example, consider this case:
> > > > >
> > > > >     foo-dtbs :=3D foo_base.dtb foo_overlay.dtbo
> > > > >     dtb-y :=3D bar.dtb foo.dtb
> > > > >
> > > > > In this example, the new list will include foo.dtb with foo_base.=
dtb and
> > > > > foo_overlay.dtbo on the same line, but not bar.dtb.
> > > > >
> > > > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > ---
> > > > > Hi,
> > > > >
> > > > > I hacked up this new thing to list out the individual components =
of each
> > > > > composite dtb. I think this information would be useful for FIT i=
mage
> > > > > generation or other toolchains to consume. For example, instead o=
f
> > > > > including each dtb, a toolchain could realize that some are put t=
ogether
> > > > > using others, and if the bootloader supports it, put together com=
mands
> > > > > to reassemble the end result from the original parts.
> > > > >
> > > > > This is based on and complements Masahiro-san's recent dtbs-list =
work.
> > > >
> > > >
> > > >
> > > > This is another format of my previous per-dtb "*.dtlst"
> > > > (but I did not pick up 3/4, 4/4 because I did not know what we need=
 after all).
> > > >
> > > > This should be discussed together with how Simon's script will look=
 like.
> > > >
> > > > I can understand your Makefile code, but I still do not know
> > > > how the entire overlay stuff will work in a big picture.
> > >
> > > How would you like to proceed? I can through together some changes on=
 top
> > > of Simon's patches as an initial proposal if that helps?
> > >
> > > I can use your format if you prefer.
> >
> >
> > How would you select base+addonX among
> > other base+addonY or base+addonZ configurations?
>
> I assume you are alluding to the existing in-tree composite DTs that
> share the same board compatible strings?


Yes.
It is possible to implement it, but I do not see a point
to implement what we do not know how to use.



>
> Under the current FIT image design with compatible strings populated from
> the FDTs, I don't think there's any way to automatically select among the=
m.
> The FIT image simply does not have the information available. Nor do the
> overlays themselves. The toolchain can only either include all of them
> and let the bootloader figure things out, or filter out all the duplicate=
s.
> With the composite list, at least it will be able to consistently keep
> only the base DT and drop the ones with the addons.

It makes the purpose of this work even more obscure.

For the purpose of avoiding duplication,
we can take the first DTB (or the smallest size)
when we encounter a duplicated compatible string.



>
> In one of my previous replies to v9 I mentioned adding a user provided
> mapping between "configuration" compatible string and FDT filename. The
> mapping could be maintained in-tree for those base+addonXYZ FDTs if
> desired.


That is one way, but I do not think such a configuration file
is maintainable.

Rob suggested overwriting the compatible string,
but I do not think we got consensus.



> Also, Simon's FIT image "extensions" proposal [1] adds more metadata to
> the FIT image to cover these addons that currently don't have distinct
> compatible strings.

I think this is yet another way, but I am not sure
how to derive the extension compatible string.






Even if we decide to implement base/overlay split,
we may not need to add anything to Makefile.

We already have .*.cmd files, and we can know
if it is a combined DTB or not, by parsing the .*.cmd
from the python script.

It might be a bit messy, but it is what we do
in scripts/clang-tools/gen_compile_commands.py









>
>
> ChenYu
>
> [1] https://lore.kernel.org/u-boot/CAPnjgZ06s64C2ux1rABNAnMv3q4W++sjhNGCO=
_uPMH_9sTF7Mw@mail.gmail.com/
--
Best Regards
Masahiro Yamada

