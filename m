Return-Path: <linux-kernel+bounces-154794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936C8AE11C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5649F281C41
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B87C59148;
	Tue, 23 Apr 2024 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQPNrwK9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305621345;
	Tue, 23 Apr 2024 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864903; cv=none; b=D83Ex8ZQrTl4SDSN3WMCM3wQVn1PXnjTps5/Y6Qgw+Sm3i76FmspQwosWO/Nn4C8824WDmRiaQETLxjhCl9AugKj2ZjB0hB2xF/eJcSW6+KQipOsJuzfdA+H2w1WU7o/XsjfYzCo7mmQrzRnRL4hRgkQQRejTDyP1Db9T5cCCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864903; c=relaxed/simple;
	bh=klIiETnTnxaWeW/TDH+LjnnyIGIxg5GMHvZZIPFYws4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ur1fC8kkyWuEBmG1gz7znc5mQMkeEujShZWgL1xTB7IkR0gglRPpEVJtlZRSIakae0E8msz2Mi2YiatetLXPJZcj8Riy5DAoeRGquK0vOuqlXmrZMSQFeXp4BESykJ3tlU1s89062NyNRN2vGvY1NMrifKurj4GhCmZ5UZd9EWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQPNrwK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4419C2BD11;
	Tue, 23 Apr 2024 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713864902;
	bh=klIiETnTnxaWeW/TDH+LjnnyIGIxg5GMHvZZIPFYws4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cQPNrwK9PeihkrEQZhgiR1ff5Fudt3nes4njdhLzlKpi/RPuVnSe5E082lycX+Z6a
	 9Z9FPoVjdLaDpCINVRtV1tzky1Q95MJjs0Dej1WtK23M8GTpkuFD3B1OOdAi1r7RkV
	 C6zR2U/2jZsPqxV+Ay9JeySBxTZLoINSumgBSNchYb1U9BEaac5V6bF/YpCZkSkoRk
	 aAvWi2j6d4TciZ39panB+YypSXVubtK3bWhzAOkuH/POmRn8/Y7QJ0zMKdjXfDVDON
	 0dNV01xmHhBNSIoouSqJfwRf8Lz5nGK7NLVdxKebd5JHiCAZoirDfQkj35YPIJ068+
	 Pka305mOyMdOQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51b2f105829so2753477e87.3;
        Tue, 23 Apr 2024 02:35:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8FZzaDU/Tg4OXm31nmhZ2piZsHmYHgY+22R3OFYk1jrAuo4i9Yo4Na3bwFUm+TLdPTuDTaAb9X05fDtTaN66eXR8TbnPWE3X9vs2cP94VFjxcnDs72DQ8zkaSGB7JFYvtawE9VliMl+ysFI+a0S9JoXCM57i8+Bs+U6kcQ+WCIHXgoPJBUA==
X-Gm-Message-State: AOJu0YwqrjNF03/KY/t/F9lZ4P+y4tV8l/+vL6gXKic/1cPFuLSazZ5N
	QclsVAStzoXsEOIM+bVEn9t4Gjq0ZyWkjqBtluzBONKxZ76Z088n3Ba2jtt1chiMecDJ1iN5vHV
	C9zyqluE6PPdQN47tBI+x26OPUAY=
X-Google-Smtp-Source: AGHT+IHV2yW8TcP73Jg2HY2VjpHvBsjoML1KLg6RQX3kYiOBysqJTVjnPlVmvl1Vzoc/7e3OuAxZdrKrdvCbhrnxxGI=
X-Received: by 2002:a05:6512:7a:b0:516:d43f:898 with SMTP id
 i26-20020a056512007a00b00516d43f0898mr9962811lfo.21.1713864901563; Tue, 23
 Apr 2024 02:35:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405-dt-kbuild-rework-v2-0-3a035caee357@kernel.org>
 <20240405-dt-kbuild-rework-v2-2-3a035caee357@kernel.org> <CAK7LNATENrTeCt4bE+bXzq1-caMguiT+U0G5YyT09T032gNtWQ@mail.gmail.com>
 <CAL_JsqKiwtVwD6snXqyEuHTx7CB2aZcLGxo7xVL9pVD0qC+8qA@mail.gmail.com>
In-Reply-To: <CAL_JsqKiwtVwD6snXqyEuHTx7CB2aZcLGxo7xVL9pVD0qC+8qA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 23 Apr 2024 18:34:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCgcJ5hhbyyKsbg+1TgN=tJo9y4hNKrrykhQjef_xttg@mail.gmail.com>
Message-ID: <CAK7LNATCgcJ5hhbyyKsbg+1TgN=tJo9y4hNKrrykhQjef_xttg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: kbuild: Split targets out to separate rules
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 2:46=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sat, Apr 20, 2024 at 1:50=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Sat, Apr 6, 2024 at 7:56=E2=80=AFAM Rob Herring <robh@kernel.org> wr=
ote:
> > >
> > > Masahiro pointed out the use of if_changed_rule is incorrect and comm=
and
> > > line changes are not correctly accounted for.
> > >
> > > To fix this, split up the DT binding validation target,
> > > dt_binding_check, into multiple rules for each step: yamllint, schema
> > > validtion with meta-schema, and building the processed schema.
> > >
> > > One change in behavior is the yamllint or schema validation will be
> > > re-run again when there are warnings present.
> >
> >
> > Is this intentional?
>
> Yes.
>
> > I think it is annoying to re-run the same check
> > when none of the schemas is updated.
>
> But the *only* reason to run dt_binding_check is to check the
> bindings. When a schema is updated and we re-run the checks, *all* the
> schemas are checked so you will get unrelated warnings as well. That's
> because doing validation a file at a time is too slow. We could fix
> that if there was a way to pass only the out of date dependencies, but
> I didn't see a way to do that with make.
>
> > 'make dt_binding_check' is already warning-free.
>
> Right, so normally it won't re-run. If a developer introduces
> warnings, then they are the only ones annoyed by this behavior and
> that's what we want.
>
> > So, I think it is OK to make it fail if any warning occurs.
>
> Well, it has certainly gotten a lot better and we don't seem to end up
> with last minute things breaking rc1, but I'm not sure I want to go
> back to that yet. We started not erroring out because in the past I've
> gotten broken schemas with the submitter saying they couldn't run the
> checks because of errors. I must be in the minority that runs make
> with --keep-going...
>
> It is also not warning free sometimes with new versions of dtschema. I
> usually fix those in parallel, but if anyone runs newer dtschema on
> older kernels that doesn't help.
>
> I suppose it would be better to keep the current behavior in this
> series and make any changes on erroring out or re-running with
> warnings a separate change.
>
> > Besides, yamllint exists with 0 even if it finds a format error.
> > Hence  "|| true" is not sensible.
>
> yamllint has errors and warnings. errors exit with non-zero. There is
> an option for warnings to return error too. Since we currently don't
> distinguish, I'm not sure if our config is exactly the mix we'd want
> to error out or not. I'll have to look and see before we change that.


OK, then.


I applied all of this series to linux-kbuild.
Thanks.










--=20
Best Regards
Masahiro Yamada

