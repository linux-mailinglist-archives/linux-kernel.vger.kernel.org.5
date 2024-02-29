Return-Path: <linux-kernel+bounces-86026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F7086BEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8071C238AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF3364C7;
	Thu, 29 Feb 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktYDXtfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90936B1C;
	Thu, 29 Feb 2024 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709172244; cv=none; b=hzT/34zzzwLkU+3XcB2hQzyvuhbF+vLpuvL4Cjr9A/AYro135Q+DT3bTLzqAHQU7wFgTXObCIcqJyvq34Z8Oy8uEtr7lyA90eIW1Rgb6Tz4lBeiT5cUKARJR0uke7qN7d0YSpMofeMb4iemz/Vc58KIKFYln/GHBxYQBKwxdvv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709172244; c=relaxed/simple;
	bh=Hqt27iztKg8bH7+WN1AsbcYSqLKusd3MveKfLQx9J/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEUnpl7QdnfJsdtLhJb0YMrThvjN28KjxIOTiT85IX58Lw7o3PwLXak15YLWqqga1KdMgrFTrARbtNJcEgjbIUQiu0II71xCiqbHIfqAkRi/JNaq6vgy1++ISBY4+ioumjCoqchTsbdz2bIlhXwuoAzS+CWX6t9hjhOHt9ZQCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktYDXtfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD53C43390;
	Thu, 29 Feb 2024 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709172244;
	bh=Hqt27iztKg8bH7+WN1AsbcYSqLKusd3MveKfLQx9J/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ktYDXtfHUoCSzF5aFXxG3n9/eUi7LgtqEtaC6IPV+4ExMWbrpyZtGDnsyq/QuuIpH
	 oyaKDGTh694C+xGUSMj5yek8hNt3bkVrbOWMc6y1tK4AQUlQ9c6jsuo28/5nJLFLvv
	 vgpf6XXot7ngz5g0Jy9OqZ9XNyiZ+rLF+H1ntrq0yPXbixyD01+zQszfLW3KQY00Zm
	 D/oI3GcdVas6lZS0Z9e6gN3o1UBch18kjW1vrcXQfUJjNNtdJjJITT/o6HlSaaAGwp
	 /nCUa+WFWtQIceg/ZHa/UC6uzRS91kc1R7RIcG2tAbMdGTJy0aRGKVAZ41M1MIF9Wr
	 UakyA4j8TFNIA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51326436876so61854e87.1;
        Wed, 28 Feb 2024 18:04:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDxkzX/dlg3CNR/M3Uu3F6p4yLxnJ1lG9OQa/uJBLd70PT70Xl49QO1bs7DQu/ca7G4xsXmoJ6PiVVhkwerBSYerhdO66n5oPXD5jt
X-Gm-Message-State: AOJu0YwOpxwp2BGLknRdhYHW13kqV+/+RN2VdB5+iLEe+20itqaRpGRY
	TfmbtAXSw+CDH7RHbXZdQhFuqbd/dnee5ADRQKbidGF74ucYGsT3RZlTyrgKsuQAPKDrSGsdDdt
	3/JOlNIQN/WVlUzuDkm8iXrUn9B8=
X-Google-Smtp-Source: AGHT+IG9Y3Y320pwAwzwBrb6NW0R4FDMaXeUFqOdM2RAsjoBp/xnwruJM6OZRDZnzwJ6N4yei2OT/iXLsrVHbXS0Oj4=
X-Received: by 2002:ac2:4a8a:0:b0:512:bb33:2eab with SMTP id
 l10-20020ac24a8a000000b00512bb332eabmr382640lfp.58.1709172242808; Wed, 28 Feb
 2024 18:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222031801.GG11472@google.com> <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com> <20240228045652.GH11972@google.com>
In-Reply-To: <20240228045652.GH11972@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Feb 2024 11:03:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
Message-ID: <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:56=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/02/22 14:16), Sergey Senozhatsky wrote:
> > On (24/02/22 13:57), Masahiro Yamada wrote:
> > > On Thu, Feb 22, 2024 at 12:26=E2=80=AFPM Sergey Senozhatsky
> > > <senozhatsky@chromium.org> wrote:
> > > >
> > > > Add a new section "Configuration environment variables" to
> > > > `make help` output in order to make it easier for people to
> > > > discover KCONFIG_WERROR, etc.
> > > >
> > > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > > > ---
> > > >  scripts/kconfig/Makefile | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> > > > index ea1bf3b3dbde..0044d49e149c 100644
> > > > --- a/scripts/kconfig/Makefile
> > > > +++ b/scripts/kconfig/Makefile
> > > > @@ -158,6 +158,10 @@ help:
> > > >                 if help=3D$$(grep -m1 '^# Help: ' $(f)); then \
> > > >                         printf '  %-25s - %s\n' '$(notdir $(f))' "$=
${help#*: }"; \
> > > >                 fi;)
> > > > +       @echo  ''
> > > > +       @echo  'Configuration environment variables:'
> > > > +       @echo  '  KCONFIG_WERROR                 - Turn some Kconfi=
g warnings into error conditions'
> > > > +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig war=
n about all unrecognized config symbols'
> > > >
> > > >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > >  # object files used by all kconfig flavours
> > > > --
> > > > 2.44.0.rc0.258.g7320e95886-goog
> > > >
> > > >
> > >
> > > Why only two, while Kconfig supports more env variables?
> >
> > Right.  I wanted to add only those that we use (and familiar with) for
> > starters.  I'm not familiar with things like KCONFIG_PROBABILITY, for
> > instance, and not sure how to document it (its Documentation/kbuild/kco=
nfig.rst
> > description is pretty lengthy).
>
> Masahiro, any opinion?


I do not need this patch.



--=20
Best Regards
Masahiro Yamada

