Return-Path: <linux-kernel+bounces-166372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B53098B99BA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032EEB21E76
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BED604B3;
	Thu,  2 May 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auWjptQk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35742044;
	Thu,  2 May 2024 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714648031; cv=none; b=Xb3f6Rs3kye2RbWoUbJQzAZXMs6DhAUWDPVq67tfjmArQ7b75oa/05iG+R0QEBMScjen+1UaK61lBaIs1LRbX7jktXCM0cDMkJlSFUPuBVZsgDKytokK/7Pn3xywIuui3vhs7Hpug0wU7naZEZSKDjWL9P7IGVSDDTB2Dk5b35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714648031; c=relaxed/simple;
	bh=Np9pvEsoFitSg29emT+0EpuitAMJ3ccV39LNm511Gss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5s+3dO45EibZjGj1Bg2D7Bi/jRhzuQTetTgDkdRxQQX/y+fO/GUyH21Lfk8etJaIwEgM8jF0DdbEkyqGfRzTZnlrQ8mwMXuUJfFm+KCexNOj13J9yyn+ZrwpPaIvrr4gqtoyZkqKY+Lujh/3hQypMHLeDv9pL+WMkKV+pCYGy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auWjptQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37EBC32789;
	Thu,  2 May 2024 11:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714648030;
	bh=Np9pvEsoFitSg29emT+0EpuitAMJ3ccV39LNm511Gss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=auWjptQk37oycIWeIeE8HIS7LneZ9hi+9rxCJxNCYFpAHBbrNrzj90nnVf1vEiC6y
	 OEQ0kNQgRuJTFU7jId3hs6SkqfldgszVbZPzRSAmILDPH0VC7/KPzlWJbsYFhiYY8X
	 MnxtD4oTbpxogAM2L50UA0QjTgcCfi5/kYTOFZ7nwAkPAifhVISLmhRvK8w03tcLuw
	 zAG2caimyP9PiAWR/6lykRzZnhqIbVVl2rAeKnMk5DzARmxzLCl5c9VLJaxqsvbpuu
	 RVh6S0G6exJk4I1VHMxZtjd7nYutrfarNuajJUAOdTVCnOOu4n73lwTMqU0wCEOVTN
	 4z7Omhl2iAZUg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518931f8d23so7827618e87.3;
        Thu, 02 May 2024 04:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt7tl3vu9hUD00ZF+Mg9/oUFkMUWQyQiYk/h6RRDbYdOhvgjHVLOKT0p2w8n0ik2TuIz5CRJLBRfM7o/gPxoAEPJULlF/ss8F6L6S24PmGjzokkQNQdZhLD+m4kU/1uJye4S5VzupmZs3EizPFdRbhtdcVp0zfq43Csg2ObNm2pthX0anTBw==
X-Gm-Message-State: AOJu0YzGH4e8Dh0MnoWFmjzxBKIoV1+aVie37o1aevamGXEA+LeFk6HB
	oZ8otE1ms03bC2KzcXRMSPkwspCjLJQHLC1UG0aVrZXgyH6Db1dOp97Bg3koSI0ZQYysHfBxsSz
	VMBSRRZZ95ip55K1dt6oxezICNLs=
X-Google-Smtp-Source: AGHT+IGglbNUcmY0tPy/2FfcGCZjTbOKNm3qt2fGG0t4e4fvLjpNRktw1NMsov0qlKycBZDrNlJq8PKuHtWWp4wr4O0=
X-Received: by 2002:a05:6512:1042:b0:51e:e846:2b6f with SMTP id
 c2-20020a056512104200b0051ee8462b6fmr2210297lfb.51.1714648029315; Thu, 02 May
 2024 04:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430202928.1143802-3-robh@kernel.org>
In-Reply-To: <20240430202928.1143802-3-robh@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 2 May 2024 20:06:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnr-L0Xwi2xCy1hcuPV=H=11+1bR=D0ji21exhprXRXg@mail.gmail.com>
Message-ID: <CAK7LNATnr-L0Xwi2xCy1hcuPV=H=11+1bR=D0ji21exhprXRXg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: kbuild: Fix dt_binding_check for arch
 without dts directory
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 5:30=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org> =
wrote:
>
> Commit 1d06c77d93da ("dt-bindings: kbuild: Add separate
> target/dependency for processed-schema.json") placed setting CHECK_DTBS
> for 'dt_binding_check' target within the section that depends on having
> arch/$ARCH/boot/dts/ which x86 doesn't have for example. That results in
> the schema checks not running for the examples. Move setting it back out
> of the conditional section as it was (CHECK_DT_BINDING is still
> replaced).
>
> Fixes: 1d06c77d93da ("dt-bindings: kbuild: Add separate target/dependency=
 for processed-schema.json")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> Cc: devicetree@vger.kernel.org
>
> Masahiro, Please take this as the above commit is in your tree.


I squashed this to the original commit.

Thanks.




>
>  Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f4fe5b0ea931..43a2a630436a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1403,7 +1403,7 @@ dtbs: dtbs_prepare
>  # dtbs_install depend on it as dtbs_install may run as root.
>  dtbs_prepare: include/config/kernel.release scripts_dtc
>
> -ifneq ($(filter dt_binding_check dtbs_check, $(MAKECMDGOALS)),)
> +ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
>  export CHECK_DTBS=3Dy
>  endif
>
> @@ -1422,6 +1422,10 @@ endif
>
>  endif
>
> +ifneq ($(filter dt_binding_check, $(MAKECMDGOALS)),)
> +export CHECK_DTBS=3Dy
> +endif
> +
>  PHONY +=3D scripts_dtc
>  scripts_dtc: scripts_basic
>         $(Q)$(MAKE) $(build)=3Dscripts/dtc
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

