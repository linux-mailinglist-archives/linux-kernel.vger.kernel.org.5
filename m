Return-Path: <linux-kernel+bounces-153806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537D08AD375
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C1A1C21177
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D90153BFB;
	Mon, 22 Apr 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2rbDkUw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17313146A6A;
	Mon, 22 Apr 2024 17:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808009; cv=none; b=GrDzO1UghCdBe4Ok5kl321lBcmV1sriy2zaQKAm7tGdZ0eJ3OJaID1KbIhv5qkPoi+TGCilICpb2cdwGxXAwLhbQIkUN0vDwc6dOzxOFmMUqWYAcwYCJLpUOtAwMSvEqFfR2ygkVfTGsMEPz+dFKK0I8Z+EDtYqpOwR1w7eL1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808009; c=relaxed/simple;
	bh=Z5JTz+fbhCcx7OUMHGHjanLIhMk+ui+KvE83U6SylYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiiyBRE0INQCXWky709EeDTURutF//brdIl1EJaYb/4Wj5fMJlXD/aoBGxChCdkZiiuk0UVFJ1UmlwgAdaCZnck/pZGoG0YKfimxhF16e6COdmV8QRoE9OQDG2lsDocOL9XpdUn52yeN5MlgJprWUDDtigtVDqjnAcdC7vR4Qh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2rbDkUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87098C32786;
	Mon, 22 Apr 2024 17:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713808008;
	bh=Z5JTz+fbhCcx7OUMHGHjanLIhMk+ui+KvE83U6SylYg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y2rbDkUwT5Uy0Vly0qsPuD0Y7C4dW/EOWAaZf0wsSoGioDA1AH517zg6YZKohESMm
	 ms8jHBFf0akuGut3SDBNG2lPHgh67LJnM8IuC/M0dE8r4Qro7Cw9uo9jjizB5PoLND
	 +qqrq/Df7gKeEGP9v861SnrwdWVNtxQY/CS8pyWGh/B4eC8Xs0lQ1wMW2YTmEC28Rg
	 +Kk0u9BGVb+uRTjU1C0pTBA2WJCPH86/kOZOH3aC4Zpu472mlCKnPtdeq51tKha3Nm
	 iH//fFLztvvCWQe2yJBEPncxQ53cBoT0JRZpPUhtTgl1eKtam7AUy6CosPskEVYMVb
	 SUf74bAADGn7g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso4912503e87.3;
        Mon, 22 Apr 2024 10:46:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpvm1+RXGvMOlfmLx5Eqx2xx0lE1mB6e8z/jd+KHM/9NzT90paoa68PK5b0eLLspnJ5ZV7cy+cc5SecRYKUgXKAG5Peunyyv0p0OZzdur69T5vLWe153q0K/fkmuHEI/tFIs0a+9L7AHPdBttA/KVuXcMSk5iiVShXTTiDfenOMXJ3h8vPew==
X-Gm-Message-State: AOJu0YxumDXoViJI76xDcaoCM2H069BQI+SvepPWCwzIOpUXPRrhsgYf
	wN1iNIw7w/O8xzmEqCWRMeW3k4VpAFkkdTtlhKGQb7H/c2bCVHqwS9EFdNee4O6I8ubKBtimX1t
	j8Z2V0wv4GIAgXEeGyChwxXs14g==
X-Google-Smtp-Source: AGHT+IH7EU29aZh1XfJa0wz1Q0FAXzkmy9VWXpwo1yYmeym435WIqBvUj1fQ4VUd9C/0GGJbZ2DQbro8bkS4o2YI2JQ=
X-Received: by 2002:ac2:5dc5:0:b0:516:7739:354c with SMTP id
 x5-20020ac25dc5000000b005167739354cmr6190001lfq.58.1713808006822; Mon, 22 Apr
 2024 10:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
 <20240405-dt-kbuild-rework-v2-2-3a035caee357@kernel.org> <CAK7LNATENrTeCt4bE+bXzq1-caMguiT+U0G5YyT09T032gNtWQ@mail.gmail.com>
In-Reply-To: <CAK7LNATENrTeCt4bE+bXzq1-caMguiT+U0G5YyT09T032gNtWQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 22 Apr 2024 12:46:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKiwtVwD6snXqyEuHTx7CB2aZcLGxo7xVL9pVD0qC+8qA@mail.gmail.com>
Message-ID: <CAL_JsqKiwtVwD6snXqyEuHTx7CB2aZcLGxo7xVL9pVD0qC+8qA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: kbuild: Split targets out to separate rules
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sat, Apr 6, 2024 at 7:56=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
> >
> > Masahiro pointed out the use of if_changed_rule is incorrect and comman=
d
> > line changes are not correctly accounted for.
> >
> > To fix this, split up the DT binding validation target,
> > dt_binding_check, into multiple rules for each step: yamllint, schema
> > validtion with meta-schema, and building the processed schema.
> >
> > One change in behavior is the yamllint or schema validation will be
> > re-run again when there are warnings present.
>
>
> Is this intentional?

Yes.

> I think it is annoying to re-run the same check
> when none of the schemas is updated.

But the *only* reason to run dt_binding_check is to check the
bindings. When a schema is updated and we re-run the checks, *all* the
schemas are checked so you will get unrelated warnings as well. That's
because doing validation a file at a time is too slow. We could fix
that if there was a way to pass only the out of date dependencies, but
I didn't see a way to do that with make.

> 'make dt_binding_check' is already warning-free.

Right, so normally it won't re-run. If a developer introduces
warnings, then they are the only ones annoyed by this behavior and
that's what we want.

> So, I think it is OK to make it fail if any warning occurs.

Well, it has certainly gotten a lot better and we don't seem to end up
with last minute things breaking rc1, but I'm not sure I want to go
back to that yet. We started not erroring out because in the past I've
gotten broken schemas with the submitter saying they couldn't run the
checks because of errors. I must be in the minority that runs make
with --keep-going...

It is also not warning free sometimes with new versions of dtschema. I
usually fix those in parallel, but if anyone runs newer dtschema on
older kernels that doesn't help.

I suppose it would be better to keep the current behavior in this
series and make any changes on erroring out or re-running with
warnings a separate change.

> Besides, yamllint exists with 0 even if it finds a format error.
> Hence  "|| true" is not sensible.

yamllint has errors and warnings. errors exit with non-zero. There is
an option for warnings to return error too. Since we currently don't
distinguish, I'm not sure if our config is exactly the mix we'd want
to error out or not. I'll have to look and see before we change that.

>
> I like this code:
>
> cmd_yamllint =3D $(find_cmd) | \
>         xargs -n200 -P$$(nproc) \
>         $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)/.yamllint >&2;=
 \
>          touch $@
>
>
> Same for  cmd_chk_bindings.
>
>
>
>
>
> >
> > Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> > Link: https://lore.kernel.org/all/20220817152027.16928-1-masahiroy@kern=
el.org/
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Separated rework of build rules to fix if_changed_rule usage from
> >    addition of top-level build rules.
> > ---
> >  Documentation/devicetree/bindings/Makefile | 25 ++++++++++++++--------=
---
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation=
/devicetree/bindings/Makefile
> > index 95f1436ebcd0..3779405269ab 100644
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -37,11 +37,13 @@ CHK_DT_EXAMPLES :=3D $(patsubst $(srctree)/%.yaml,%=
example.dtb, $(shell $(find_cm
> >  quiet_cmd_yamllint =3D LINT    $(src)
> >        cmd_yamllint =3D ($(find_cmd) | \
> >                       xargs -n200 -P$$(nproc) \
> > -                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)=
/.yamllint >&2) || true
> > +                    $(DT_SCHEMA_LINT) -f parsable -c $(srctree)/$(src)=
/.yamllint >&2) \
> > +                    && touch $@ || true
> >
> > -quiet_cmd_chk_bindings =3D CHKDT   $@
> > +quiet_cmd_chk_bindings =3D CHKDT   $(src)
>
>
> Nit.
>
> If you want to avoid the long absolute path
> when O=3D is given, you can do
> "CHKDT   $(obj)" instead.

I suppose that is only after your series on srctree/src because I
don't see that. But I will change it.

Rob

