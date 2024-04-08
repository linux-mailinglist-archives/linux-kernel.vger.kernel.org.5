Return-Path: <linux-kernel+bounces-135517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 715B989C711
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 122801F222B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAB127B7C;
	Mon,  8 Apr 2024 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BibektuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFB9126F3F;
	Mon,  8 Apr 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586570; cv=none; b=I4rlEsvi3EQpGZ8bnoNzw/OUVthZxkUBkCZyZwKC26c1H1wIbPcrWd5ach0xzc/1QR+RtjsIgg1/dA+a8iK4/iZL1JkHY9Q3fgZ2+E8HsQLvXwvgjSNd3uxC+e8sPGFpAqRWaBzKZIFmpHFTXaLxsJleqTos0ew2EVFBfGf1Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586570; c=relaxed/simple;
	bh=DbgXMyCHE8Wx/Fa+odUEeisTrN7s8C2INM07ftx/blw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaNOEp/IGJM7IGhocxrl5DofRERquT3kGD+ohP+Wv2Bnu5kYhHZYH1KmIWPsZ2ga+9DEBcfuLfZubscvbnk75tWUPhT9nLe/cxNkurB3GR/Ox+7lNOHf/U4XUYeh3OPkNCe7Uf1li3YVd7BYG4M543fXJgYwS6lAsIRicH/K4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BibektuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48ABC43390;
	Mon,  8 Apr 2024 14:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712586569;
	bh=DbgXMyCHE8Wx/Fa+odUEeisTrN7s8C2INM07ftx/blw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BibektuLLtArBrXYfKEcOlobHfI71PcexZdZw5MbuLk4QtO/zJ51A03LXXpo3av/A
	 PLd4HYaYqvaCV3yS20/CsSY8ctrWrh4NU1GHfmbMrotXua9nK8Qi3l28huFigWgDkC
	 DPnngR3b8g/qBfQ602OsrEcjEXjTVQcMxi9q+p8w1whq2HBaT6DFqlXvv+DZ0h/xIV
	 GrfkOGzHYEEKfPHMH7JQWYd9NIV42CLdEfMXi+b7LqmgqnpmEyJwR3ETZAGWzan4kf
	 gC3SLiwMkztb8MtKImoV9nsPjUeTM8E0Q+KZjtQcgLveTIgpd/Qg7CI9FCRmTnP6Eu
	 1n5Xctw4jJ6AA==
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ea0a6856d7so610883a34.1;
        Mon, 08 Apr 2024 07:29:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhmndsXIi3z5Sr9+Gj1NBH0AOTYWc9koDl0by3qazPW39SjP+NGcZHHs8GHokXEfjA3hYNubCbu4Ap+lMbKhgTAlL3CiUUwH6U9PqPPVYxw17hCuTIklNsJroIg1xULPUStM/dm3GqpQ==
X-Gm-Message-State: AOJu0YyJBsvRJJ19UFWyhUukG47g98Ml9r6GP5+Be0vsX2R0lxYZHbl0
	dywiDT3FOHDgLp2xOKkM5iNAWIT1gKLpYA6+m2kId5+ZbMVVDihruy+71mHggg2r5GZzHvEXgQw
	1djfjOR64RukCZasQ/gRGCo/l2NU=
X-Google-Smtp-Source: AGHT+IEr3QTeW3KL1Co0KvWLK0r/MBjs6UjG3WZiw6tFUu42vVwm3HBLRXNd99YZP5dEGbQU+zGB/VXoEXcia7caZqQ=
X-Received: by 2002:a05:6820:248e:b0:5aa:14ff:4128 with SMTP id
 cq14-20020a056820248e00b005aa14ff4128mr6134359oob.1.1712586568935; Mon, 08
 Apr 2024 07:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403004718.11902-1-W_Armin@gmx.de>
In-Reply-To: <20240403004718.11902-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:29:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i3TAyDERxCm5caud5x5kLbc6J6MKqXXFWecShYe-gCrA@mail.gmail.com>
Message-ID: <CAJZ5v0i3TAyDERxCm5caud5x5kLbc6J6MKqXXFWecShYe-gCrA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix memory leak then namespace lookup fails
To: Armin Wolf <W_Armin@gmx.de>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	dmantipov@yandex.ru, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 2:47=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> When acpi_ps_get_next_namepath() fails due to a namespace lookup
> failure, the acpi_parse_object is not freed before returning the
> error code, causing a memory leak.
>
> Fix this by freeing the acpi_parse_object when encountering an
> error.
>
> Tested-by: Dmitry Antipov <dmantipov@yandex.ru>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Because ACPICA is an external project supplying code to the Linux
kernel, the way to change the ACPICA code in the kernel is to submit a
pull request to the upstream ACPICA project on GitHub and once that PR
has been merged, submit a Linux patch corresponding to it including
the Link: tag pointing to the PR in question and the git ID of the
corresponding upstream ACPICA commit.

However, note that upstream ACPICA commits are automatically included
into the Linux kernel source code every time the upstream ACPICA
project makes a release, so it is not necessary to send the
corresponding Linux patches for them unless in the cases when timing
matters.

> ---
>  drivers/acpi/acpica/psargs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
> index 422c074ed289..7debfd5ce0d8 100644
> --- a/drivers/acpi/acpica/psargs.c
> +++ b/drivers/acpi/acpica/psargs.c
> @@ -820,6 +820,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_st=
ate,
>                             acpi_ps_get_next_namepath(walk_state, parser_=
state,
>                                                       arg,
>                                                       ACPI_NOT_METHOD_CAL=
L);
> +                       if (ACPI_FAILURE(status)) {
> +                               acpi_ps_free_op(arg);
> +                               return_ACPI_STATUS(status);
> +                       }
>                 } else {
>                         /* Single complex argument, nothing returned */
>
> @@ -854,6 +858,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_st=
ate,
>                             acpi_ps_get_next_namepath(walk_state, parser_=
state,
>                                                       arg,
>                                                       ACPI_POSSIBLE_METHO=
D_CALL);
> +                       if (ACPI_FAILURE(status)) {
> +                               acpi_ps_free_op(arg);
> +                               return_ACPI_STATUS(status);
> +                       }
>
>                         if (arg->common.aml_opcode =3D=3D AML_INT_METHODC=
ALL_OP) {
>
> --
> 2.39.2
>
>

