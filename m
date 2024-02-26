Return-Path: <linux-kernel+bounces-80615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BFD866A66
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD7D283028
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C8F1BDC3;
	Mon, 26 Feb 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4+HbDHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482751C280;
	Mon, 26 Feb 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708931016; cv=none; b=NI83pDNnKzAd5jO1nlaxPTYW9eJMPwI7LnA8BsTwfN6IbUSkjaQTKk/1ehbiLerLfMryEZ1gIliJiv+e1l231wQV/FJplbJiUx3wd96SC59EX3zQKCAL4ZoDVPt5QNF1+N9WMXKQlB606SWDwOPWk5Zg+4UHpdGMMH33/olCM9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708931016; c=relaxed/simple;
	bh=McHriLc9VHpbi8pf3LEto0DWYbClS1FsZTk12Re/s0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeeWBZyt9+oPyFm7swaprWCTugCoz2CKZIb6KDjDN2O+NwVGPduKUjmXuDG0oZaNXSGnY0dUK7xgZXEAQ3+UjmBdUPRO4sj1/8H1ef+Y3bFfCJgxMfLOJDwPJZCjuc2VyHYhxwUx3egWvWe3x4G5EooCIIxhqSOcRxcFtk7d0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4+HbDHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F9BC433A6;
	Mon, 26 Feb 2024 07:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708931015;
	bh=McHriLc9VHpbi8pf3LEto0DWYbClS1FsZTk12Re/s0c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e4+HbDHZear95QoLvFW20iEIy9F7NnlszG53ezKs3SiYuUTGyxc30+wOZO0DwTm2l
	 IBHyq6YH67F20QwWj7nxTIg8R8o2gRGyLO7vtZLX/HFJPvI7Q2n9Yab5luNCRLHoAC
	 D2mYM5CkXnxmeht1WNuU5s/25nsZe1jgwoSqoezl3aLCHm/8MYDZF/SY9eyRWQnbiu
	 xacXwm2uxtzHy3LkjbBMxDcjCUdBeGbom1uX7yhhgqbyG4W/XOgo0fVzC1w4etdI24
	 a6Nt/BfrCJeDr9ZOdCxA1QpHbiKYm2UO9WBfUVVrdhmCNH3OrTmCbI4qeCBWz3jDnI
	 ruWZSUAZK4v+g==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2305589a2so40134381fa.1;
        Sun, 25 Feb 2024 23:03:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXh0567t+4EmQT861PMR/3SOa2JCTtGlTtrYGQc3DWY9LiM8cYMfG8fH81Rtq8zQamX8AToigllVWOoS9RZi3MhC29rbhDhHLzdPZRgoVv0O2lqiXaK8zt0w9olaioM4k83S2L1EGJYg11DGRf3WEcz8NnjF/XiJl9Di3YBmiZUZ91Wgd4vEg==
X-Gm-Message-State: AOJu0YwwYbs/6wMvUBqMCNa+nA2CxrcGsE9J66iWh7a6pPZ9GLpGFgyQ
	zW0PFfW4KY6+U2U5e1eek2XhWC6BSUMhPDufkYnsD97stA4XlgrE5whhhomqRUl/Ql7Pr4F77jz
	TuIyjK7STrhkSrUjaOT4YFJUwgNo=
X-Google-Smtp-Source: AGHT+IG7y3BqdCJ+sfjI74RCsEt3lLih8aIWurAWDnZJbN45ufZkQqGa++R+6q+3o5wNfprqbpIU7Nm9lSVNng2tJJY=
X-Received: by 2002:a2e:850a:0:b0:2d2:8ce0:215b with SMTP id
 j10-20020a2e850a000000b002d28ce0215bmr794228lji.0.1708931014170; Sun, 25 Feb
 2024 23:03:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225151209.343160-1-alexander.stein@mailbox.org>
In-Reply-To: <20240225151209.343160-1-alexander.stein@mailbox.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 26 Feb 2024 16:02:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNARxfhYm9WyDH-S0PT7Mb5Tj5tmbqGLs9NzNxzsi1_4OQw@mail.gmail.com>
Message-ID: <CAK7LNARxfhYm9WyDH-S0PT7Mb5Tj5tmbqGLs9NzNxzsi1_4OQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: Add DT schema check also when applying DT overlays
To: Alexander Stein <alexander.stein@mailbox.org>, Rob Herring <robh+dt@kernel.org>, 
	DTML <devicetree@vger.kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Rob Herring, DT List


On Mon, Feb 26, 2024 at 12:12=E2=80=AFAM Alexander Stein
<alexander.stein@mailbox.org> wrote:
>
> Add a similar mechanism as for regular DT files to call the DT checker
> after applying DT overlays to base DT files.
>
> Signed-off-by: Alexander Stein <alexander.stein@mailbox.org>
> ---
> I'm unsure if this is the "right" way, or if the multi-dtb-y lines
> should be moved. But checking for schemas in DT overlays is a nice thing.



There is no need to move the multi-dtb-y line.




>  scripts/Makefile.lib | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 038a12e15586..964892b18f95 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -406,10 +406,6 @@ cmd_dtc =3D $(HOSTCC) -E $(dtc_cpp_flags) -x assembl=
er-with-cpp -o $(dtc-tmp) $< ;
>  quiet_cmd_fdtoverlay =3D DTOVL   $@
>        cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(re=
al-prereqs)
>
> -$(multi-dtb-y): FORCE
> -       $(call if_changed,fdtoverlay)
> -$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
> -
>  ifneq ($(CHECK_DTBS)$(CHECK_DT_BINDING),)
>  DT_CHECKER ?=3D dt-validate
>  DT_CHECKER_FLAGS ?=3D $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
> @@ -418,9 +414,13 @@ DT_TMP_SCHEMA :=3D $(objtree)/$(DT_BINDING_DIR)/proc=
essed-schema.json
>
>  quiet_cmd_dtb =3D        DTC_CHK $@
>        cmd_dtb =3D        $(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) =
-u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
> +quiet_cmd_dtbo =3D DTOVL_CHK $@
> +      cmd_dtbo =3D $(cmd_fdtoverlay) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS)=
 -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
>  else
>  quiet_cmd_dtb =3D $(quiet_cmd_dtc)
>        cmd_dtb =3D $(cmd_dtc)
> +quiet_cmd_dtbo =3D $(quiet_cmd_fdtoverlay)
> +      cmd_dtbo =3D $(cmd_fdtoverlay)
>  endif
>
>  $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
> @@ -429,6 +429,10 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) F=
ORCE
>  $(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
>         $(call if_changed_dep,dtc)
>
> +$(multi-dtb-y): FORCE
> +       $(call if_changed,dtbo)
> +$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
> +
>  dtc-tmp =3D $(subst $(comma),_,$(dot-target).dts.tmp)
>
>  # Bzip2
> --
> 2.44.0
>


--=20
Best Regards
Masahiro Yamada

