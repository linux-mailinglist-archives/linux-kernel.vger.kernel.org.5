Return-Path: <linux-kernel+bounces-135525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2FB89C729
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7801F21DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2D813F434;
	Mon,  8 Apr 2024 14:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0Njdtbg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697A13F42C;
	Mon,  8 Apr 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586755; cv=none; b=T/ktwBjE1z12pysM8ZbLkLj0RQhzi5PUNSfp/4kcHcpC0fyQv2X1sQSHhEAaOZyKCoYM73YjEeeXRAK00Io/4eiIklx4PyHuDvB28V1bYM1buUXLC5BGQwWexUQtejWM07FmAts1HyWuusbu8FKXCCmYw69ZcY5b3dqr0oZaoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586755; c=relaxed/simple;
	bh=GorUcEBtXYyDfbB1UeZUkcg7USCD8pj7xfmi6TH0c9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cafZP3IyrRuGvVkEpGhtRHwrNOC6JXg5hcFavofTLCt3xqHGwDoxd73tqa5NrDNQBs4HE2a5z6sV65i1yMnCGkNNuv7aMI4k5NnNbdIkEnI1RVzsA5s0QIyTWOsqH0OT8uwnlkOR1JwxD69Ns+awxHTjzsEn2odcRwdboFBWP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0Njdtbg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F4C433F1;
	Mon,  8 Apr 2024 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712586754;
	bh=GorUcEBtXYyDfbB1UeZUkcg7USCD8pj7xfmi6TH0c9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t0NjdtbgBAY1oaeA7fpBU7GPvb7eVIuDwfMucnKlmlOKGN+NLrQ8dq8jLC13+eiUA
	 RlPrgOt+m4jbTndOYfweumXNQqfnHRW5z4rxsmY3YMQ+D8S0yzyoTTYE4plSWa+lWr
	 DSx8W/w8aOTo+ckhBgZaULNqNSdA/jXLPJdZERyealBbykAD1rJDfoVdfpqXktCIX0
	 Xkac+8/2LRJLtEjIGpygLBhpIT5w7BNt/MY2YF06eQdFSns+ZVKjO+20Lyyk3I/9lP
	 cQvGM5IqOgjH9bW7qU5ai+ZPbKVn5vzaGffhkeABmWjcP3ay42m/EYI7aKl3kb2f2u
	 LZdVpA+h2hu6g==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22ed9094168so77370fac.1;
        Mon, 08 Apr 2024 07:32:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWodZp5gc2ar1nuE+EXUGFaRZ9MUOKl/yt16vOXLQvJ0GVnmORmdzf1zqJ0THCnDHT+s5Z2oqkm34rhNQggMJBKnwOzyLhbcjYZ9QTiUICcLfj23I/hG7nw0r7KRHKYEtZPmN8vv3ymjg==
X-Gm-Message-State: AOJu0Yxzd7/KS2JjgaI+oYrfcmt4RABPyIjyZ2OA5x8ZjQKqxOLI3Crh
	7VfK9bii8SVVsejBrOh9nVRzGk4exRkc+YtT7dTebCeepzb9MUiAGPxVude/D8BJwk6IkdA1qPZ
	Na89zmHVxD/sqHnHI3rlHGKqqJgE=
X-Google-Smtp-Source: AGHT+IG+u1ISr73/uSJMxwF7LPacCeZeKrVirQ/ehRPW31puIHBK+pGdttJAar4GdVESogf5a5L8qxLT7Xd++wq99R8=
X-Received: by 2002:a05:6870:210c:b0:229:ee6d:77da with SMTP id
 f12-20020a056870210c00b00229ee6d77damr8582804oae.2.1712586754084; Mon, 08 Apr
 2024 07:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403014326.970237-1-qq810974084@gmail.com>
In-Reply-To: <20240403014326.970237-1-qq810974084@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:32:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g087vTJmgLHssedyCuhh61F_hR+TP3HQpoTACuzh+0jA@mail.gmail.com>
Message-ID: <CAJZ5v0g087vTJmgLHssedyCuhh61F_hR+TP3HQpoTACuzh+0jA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: debugger: dbconvert: add a null pointer check
To: Huai-Yuan Liu <qq810974084@gmail.com>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:43=E2=80=AFAM Huai-Yuan Liu <qq810974084@gmail.com=
> wrote:
>
> The memory allocation function ACPI_ALLOCATE_ZEROED does not guarantee a
> successful allocation, but the subsequent code directly dereferences the
> pointer that receives it, which may lead to null pointer dereference.
>
> To fix this issue, a null pointer check should be added. If it is null,
> return exception code AE_NO_MEMORY.
>
> Fixes: 995751025572 ("ACPICA: Linuxize: Export debugger files to Linux")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>

Because ACPICA is an external project supplying code to the Linux
kernel, the way to change the ACPICA code in the kernel is to submit a
pull request to the upstream ACPICA project on GitHub and once that PR
has been merged, submit a Linux patch corresponding to it including
the Link: tag pointing to the PR in question and the git ID of the
corresponding upstream ACPICA commit.

However, note that upstream ACPICA changes are applied to the Linux
kernel source code every time the upstream ACPICA project makes a
release, so it is not necessary to send the corresponding Linux
patches for them unless in the cases when timing matters.

> ---
>  drivers/acpi/acpica/dbconvert.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconv=
ert.c
> index 2b84ac093698..8dbab6932049 100644
> --- a/drivers/acpi/acpica/dbconvert.c
> +++ b/drivers/acpi/acpica/dbconvert.c
> @@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, =
union acpi_object *object)
>         elements =3D
>             ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
>                                  sizeof(union acpi_object));
> +       if (!elements)
> +               return (AE_NO_MEMORY);
>
>         this =3D string;
>         for (i =3D 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
> --
> 2.34.1
>
>

