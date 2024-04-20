Return-Path: <linux-kernel+bounces-152161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFD8ABA08
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76784281818
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4E12E5E;
	Sat, 20 Apr 2024 06:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wj0HTv6K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE096FD0;
	Sat, 20 Apr 2024 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713595857; cv=none; b=qkccArFCVeDHhc6yR7HII/xDf5nwbGpsUxRk596U+9Sa71q3XBvij/iT2jIGgDuNVgvu8IIpEyQmteaPSKQElaYmSPZg57ajtsbzS6Wi7T2r4NT5E7Mb4FjQsc4aina+M6RGThK6CqOmsG2yn3lnsxZTexdwgFRlph0sGS9Dhmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713595857; c=relaxed/simple;
	bh=snym6v7DHr/ZhRMpLFZQINKJvOzHnir8QzID0r2TtZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eds6Thxv0Rs2D6GzBzSDfzZ5QHSwpMVrZKHxu36aCSGN9OdfiyC8pxokVWU0MomRDf2tbJpMBsIyPn6vK5ubnewDpVKavvDweOiM/dOm4DacvW7lTCzwkBoGVTwR/J/FRm47UJoGBJApMQ6SolyYzj4F5iS4dxjwnf50L+SUX0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wj0HTv6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B41C32782;
	Sat, 20 Apr 2024 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713595857;
	bh=snym6v7DHr/ZhRMpLFZQINKJvOzHnir8QzID0r2TtZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Wj0HTv6KTjozQcVwiCLdNakWp6XwYTgOP7X1tC1tJcA+OQYjYm1GsyrIA2qMkmHQK
	 3ke50wkfEDySZ/3h0+YS/YGGDzP5ruI9UkmS7BSp93lpiLtwo1UY2gYkn0HEdTPBL1
	 rUzaASVRdkfeejoycPH0VufrB8B5npJNTIdDELF1GsZibW2dHHpTOvu7vgDn9db/M3
	 2SRjf96k6PQ3+R36XJ0rgUtDU0Q9A3018JkDjjpeVYRkjnyfb/9dNZVCZRxJLvLL09
	 KT67wIePvxLVq+j5QC+yzSDp0lwbtQtcBu3/2K0rOA7i4gaqEtqmwLni5O+hOPwCmq
	 AnvF4SiNh9qOQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso2590252e87.1;
        Fri, 19 Apr 2024 23:50:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8LY3ZwNRGUr8hXkIU8t6gr0sZIMGzdJyzupVW0XO6NGqf0A28UC+CA2eh9ru/TqK6uznM8SxlYr9aSSGenz8F92/+UqMYNKSDUuV6q/Bx/OBTtYwwb27AaM0sPXK3GcJ/grIRe/4aO+WCvGXROfbIDjGkzFGe0Nqa5cMOPQ/VQLkht0Ssdw==
X-Gm-Message-State: AOJu0Yzp89/9C0d3BP21MSYZpIrz0NKLGLIPVEaHeNO0eYhNmUPnLKSC
	F2McdUXSeWCwcmD4VvBpsUL5+vXQWP+lLZWcZyG/MLzV0ifEaKUFZpbKOOlo2QkkFajCafvCyq9
	YkHPCeV73NlNH2UYR2ktfwJeOij8=
X-Google-Smtp-Source: AGHT+IF8E6tEjqWZmwZbg0RPE1jOQ2stBPtD9ankZeN2tQz8zWnxTtv8IIW9LwtVj3uIgH/eFpbpitFiXLkycKmsVKM=
X-Received: by 2002:a05:6512:329c:b0:518:b91e:489b with SMTP id
 p28-20020a056512329c00b00518b91e489bmr2051776lfe.13.1713595855586; Fri, 19
 Apr 2024 23:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org> <20240405-dt-kbuild-rework-v2-2-3a035caee357@kernel.org>
In-Reply-To: <20240405-dt-kbuild-rework-v2-2-3a035caee357@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 15:50:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNATENrTeCt4bE+bXzq1-caMguiT+U0G5YyT09T032gNtWQ@mail.gmail.com>
Message-ID: <CAK7LNATENrTeCt4bE+bXzq1-caMguiT+U0G5YyT09T032gNtWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: kbuild: Split targets out to separate rules
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 7:56=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> Masahiro pointed out the use of if_changed_rule is incorrect and command
> line changes are not correctly accounted for.
>
> To fix this, split up the DT binding validation target,
> dt_binding_check, into multiple rules for each step: yamllint, schema
> validtion with meta-schema, and building the processed schema.
>
> One change in behavior is the yamllint or schema validation will be
> re-run again when there are warnings present.


Is this intentional?

I think it is annoying to re-run the same check
when none of the schemas is updated.

'make dt_binding_check' is already warning-free.
So, I think it is OK to make it fail if any warning occurs.

Besides, yamllint exists with 0 even if it finds a format error.
Hence  "|| true" is not sensible.



I like this code:

cmd_yamllint =3D $(find_cmd) | \
        xargs -n200 -P$$(nproc) \
        $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2; \
         touch $@


Same for  cmd_chk_bindings.





>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Link: https://lore.kernel.org/all/20220817152027.16928-1-masahiroy@kernel=
org/
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Separated rework of build rules to fix if_changed_rule usage from
>    addition of top-level build rules.
> ---
>  Documentation/devicetree/bindings/Makefile | 25 ++++++++++++++----------=
-
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/d=
evicetree/bindings/Makefile
> index 95f1436ebcd0..3779405269ab 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -37,11 +37,13 @@ CHK_DT_EXAMPLES :=3D $(patsubst $(srctree)/%.yaml,%.e=
xample.dtb, $(shell $(find_cm
>  quiet_cmd_yamllint =3D LINT    $(src)
>        cmd_yamllint =3D ($(find_cmd) | \
>                       xargs -n200 -P$$(nproc) \
> -                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.=
yamllint >&2) || true
> +                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.=
yamllint >&2) \
> +                    && touch $@ || true
>
> -quiet_cmd_chk_bindings =3D CHKDT   $@
> +quiet_cmd_chk_bindings =3D CHKDT   $(src)


Nit.

If you want to avoid the long absolute path
when O=3D is given, you can do
"CHKDT   $(obj)" instead.





>        cmd_chk_bindings =3D ($(find_cmd) | \
> -                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(=
srctree)/$(src)) || true
> +                         xargs -n200 -P$$(nproc) $(DT_DOC_CHECKER) -u $(=
srctree)/$(src)) \
> +                         && touch $@ || true
>
>  quiet_cmd_mk_schema =3D SCHEMA  $@
>        cmd_mk_schema =3D f=3D$$(mktemp) ; \
> @@ -49,12 +51,6 @@ quiet_cmd_mk_schema =3D SCHEMA  $@
>                        $(DT_MK_SCHEMA) -j $(DT_MK_SCHEMA_FLAGS) @$$f > $@=
 ; \
>                       rm -f $$f
>
> -define rule_chkdt
> -       $(if $(DT_SCHEMA_LINT),$(call cmd,yamllint),)
> -       $(call cmd,chk_bindings)
> -       $(call cmd,mk_schema)
> -endef
> -
>  DT_DOCS =3D $(patsubst $(srctree)/%,%,$(shell $(find_all_cmd)))
>
>  override DTC_FLAGS :=3D \
> @@ -64,8 +60,15 @@ override DTC_FLAGS :=3D \
>         -Wno-unique_unit_address \
>         -Wunique_unit_address_if_enabled
>
> -$(obj)/processed-schema.json: $(DT_DOCS) $(src)/.yamllint check_dtschema=
_version FORCE
> -       $(call if_changed_rule,chkdt)
> +$(obj)/processed-schema.json: $(DT_DOCS) check_dtschema_version FORCE
> +       $(call if_changed,mk_schema)
> +
> +always-$(CHECK_DT_BINDING) +=3D .dt-binding.checked .yamllint.checked
> +$(obj)/.yamllint.checked: $(DT_DOCS) $(src)/.yamllint FORCE
> +       $(if $(DT_SCHEMA_LINT),$(call if_changed,yamllint),)
> +
> +$(obj)/.dt-binding.checked: $(DT_DOCS) FORCE
> +       $(call if_changed,chk_bindings)
>
>  always-y +=3D processed-schema.json
>  always-$(CHECK_DT_BINDING) +=3D $(patsubst $(obj)/%,%, $(CHK_DT_EXAMPLES=
))
>
> --
> 2.43.0
>


--
Best Regards
Masahiro Yamada

