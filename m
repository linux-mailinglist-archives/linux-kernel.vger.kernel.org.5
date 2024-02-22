Return-Path: <linux-kernel+bounces-75916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A185F09B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09E41C213CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57500522F;
	Thu, 22 Feb 2024 04:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi80DSkD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2771C14;
	Thu, 22 Feb 2024 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577901; cv=none; b=e6BLy+WUrcDcx02c72AFi5/qy2YaZZhp74erq6NX2wSNboiKiyWyYZhiBhtYyPsXRVRXBFVd1vtnQ19YI/CWgcoXqlCi69Ysob3RAbQCXjuREJe5b91PXDcpmQde83pmq/82Mr44f3qJUAPfIESHWdLrz9RNwoLHLTSoXCMXdBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577901; c=relaxed/simple;
	bh=qckse1wgQF53FqHwKP6EtPGsZ/nc52Ki7tmtQVe8Ys4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6GZ2w0IueKnHWYS8WL0mA0YQDdQ5Q/rd+X5StqWr3EIhUHM+D/kcCNUvc8NtpxeyL9VMY+Uh2wDabi12SrdJD20sBmtvcxTnxSWNoChHmNqoVUMX/tYXmVPeHRw1vLNZUeQUc3KJKanvvwJKEhUaasTqV9L4c7lEF/rjpdN+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi80DSkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B4C433C7;
	Thu, 22 Feb 2024 04:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708577901;
	bh=qckse1wgQF53FqHwKP6EtPGsZ/nc52Ki7tmtQVe8Ys4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mi80DSkDY/wKkFJGX5AQk9PuAkWAxf+kvfbDoId2Gywfr9KhRxj7bYUIH1n5OciRM
	 vzfI42zwYNPuAXc6dMfRA3qRVeaOyOW8wZyulv7y4cWEwqX3ejt5pD/zkt10ZFzCgk
	 ZcXP0BJXY1DmixZmVFHqDafLcc3LWQwiRjVPFWmSqdEIG76/mOmN6yFyYaDzMSgi/4
	 NPkXBi2mCkXFjGv8EQKYZx1Nh+geFG4WpayaPBnpWFxNZ2v5RJgMJd2w2KsRQxXDzF
	 0TGYt50qJrcY7Gw4wQjSHbKPCaKXWohcq5qnX0Psk2JTMdUOGemB+8BuFsFKF5vtdj
	 novNS6HVyuzjw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d1080cba75so4662591fa.0;
        Wed, 21 Feb 2024 20:58:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0R4RezdPwtSNw2LfKcf3HaxWsZpim2YHyHcGuPPU08MkQf9SMXmpshL5sbw5YdIyF0IZSnl7/i+oWcusraGahHoZa4I9KYB17QJxj
X-Gm-Message-State: AOJu0Yw8YLjSjVFl62gS+ypoK3e7IBVHmnn1HRVKXa3oLj0pYhU0f9Hw
	DSEjwC1KSFmpBsBfBRpQ2hPM9g9SZBJzNkG829Xm8nnRYQpqLu6xyRLouKu099D6O66bDScFWac
	jqtsZnhD58/H3+1uxZhzFi9jikLw=
X-Google-Smtp-Source: AGHT+IEkoeuKdW22kXnwFyoVi24R3PbL9ya6u3TEmVkU7S321D/U0UzC6jwLp/9IUrS/b0WXDU0/Y3DEt+UCkcu1QLM=
X-Received: by 2002:a2e:809:0:b0:2d2:20bd:d386 with SMTP id
 9-20020a2e0809000000b002d220bdd386mr502946lji.7.1708577899631; Wed, 21 Feb
 2024 20:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222031801.GG11472@google.com> <20240222032559.496127-1-senozhatsky@chromium.org>
In-Reply-To: <20240222032559.496127-1-senozhatsky@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 22 Feb 2024 13:57:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
Message-ID: <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:26=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Add a new section "Configuration environment variables" to
> `make help` output in order to make it easier for people to
> discover KCONFIG_WERROR, etc.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  scripts/kconfig/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index ea1bf3b3dbde..0044d49e149c 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -158,6 +158,10 @@ help:
>                 if help=3D$$(grep -m1 '^# Help: ' $(f)); then \
>                         printf '  %-25s - %s\n' '$(notdir $(f))' "$${help=
#*: }"; \
>                 fi;)
> +       @echo  ''
> +       @echo  'Configuration environment variables:'
> +       @echo  '  KCONFIG_WERROR                 - Turn some Kconfig warn=
ings into error conditions'
> +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig warn abou=
t all unrecognized config symbols'
>
>  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  # object files used by all kconfig flavours
> --
> 2.44.0.rc0.258.g7320e95886-goog
>
>


Why only two, while Kconfig supports more env variables?




--=20
Best Regards
Masahiro Yamada

