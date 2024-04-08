Return-Path: <linux-kernel+bounces-135534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB389C747
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8D7B24C00
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820913F00A;
	Mon,  8 Apr 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+M1bBUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75F13E8A9;
	Mon,  8 Apr 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587305; cv=none; b=j7uK+oBFFvouGdsAAWhJf6hVTPCnvs9qIVQlPFkh2M8xRZUX63tZRCd1BXlx4bty/bX61NKJU/s+t2hY5V8DhB0P7mskPZXjAjd4hseCmuYBfBf652rY6zHD4kYpidJb5PK0yc2TJkoeKSf01GEdSJRXM5dcKREGfc/O52rtpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587305; c=relaxed/simple;
	bh=jbEWktGS8Ep13R3bVFaxKXrAOpmIt8ife9UyNU/Rcek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2nwrXer5eAadLJY/Qef777wMjQjzO2rjMPWtfD7xC7MLTSC479+yi4//ZDF2BnHqXfoi1WMvguN83GhkcMRQyCSY9Cf4zJNS+6ZefSu4EFKRh0H1CqeA6/bK+tlfnPNCuqXT4bjtKL3Oukdq82dZV4u99UnPIjO5xlRw9p4hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+M1bBUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC0FC43394;
	Mon,  8 Apr 2024 14:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587304;
	bh=jbEWktGS8Ep13R3bVFaxKXrAOpmIt8ife9UyNU/Rcek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I+M1bBUZx+UIwqb2ohb4+876hCluTB2H4sTqDkldz2ZqbqUpC3gIxFWLKx3dn0xgp
	 ihGNH6GojUPHEEf4HUem3J7nSH/p5E04AwOY7JcZB/M1DsR1Qe2FcXMsCSQYpWobQf
	 HJ/3xl3mY61klTHN4wX6dFJwYQa0WFHps/9DD84Ow0Zb3pSXY+voV9O/7Y99pHUjgc
	 rcuRQRNvMmQUiDCgQPFYb6codKrxr1NllK+SvejOYhXGTrtayfKlUkLR4rw5d4v3BO
	 oI+vJbMSOxozP8FdZrQiNtIr3eEbX3xIX8jrb7zrgiHCtTCPZdBgOBf/Czm+dLTGY7
	 P3srcEz9aiK7Q==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3da4140a2so23309b6e.0;
        Mon, 08 Apr 2024 07:41:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFbnvMzVFSbjVUvsWZroV1mUyzSeA9VjpLvQUbGdTQLxEmcv4lIeto+Jw5X/DI0XbyqVME20is0BSJN7pufn6FO+tSvP5VF7nfbA==
X-Gm-Message-State: AOJu0YwzEU2V4kSYSHcsuwCfUOE0PMrvGeZnrVF5wbn4ToTvCL+atUY0
	LiyYBXn9GEV7joqlOd1xxc03uYJB9Y+phEXyYqZSMep746ZckisGucqwdo/cIaaZmng4NuABdl2
	zUtM7PmVqSY88+ZOD0vM2Je5lfns=
X-Google-Smtp-Source: AGHT+IFSY6CfSrDc13Ub9zqdboR0p48m4YcnNknozWduUthGeYqqVzVsbWyjUe3FxoaIxSZdZxmq2ad8FKsv56rKp64=
X-Received: by 2002:a05:6808:15a2:b0:3c5:d3eb:2c1b with SMTP id
 t34-20020a05680815a200b003c5d3eb2c1bmr9382476oiw.2.1712587304034; Mon, 08 Apr
 2024 07:41:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328140512.4148825-1-arnd@kernel.org> <20240328140512.4148825-7-arnd@kernel.org>
In-Reply-To: <20240328140512.4148825-7-arnd@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:41:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFNLTBqCZMUxT50Q@mail.gmail.com>
Message-ID: <CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFNLTBqCZMUxT50Q@mail.gmail.com>
Subject: Re: [PATCH 06/11] acpi: avoid warning for truncated string copy
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc -Wstringop-truncation warns about copying a string that results in a
> missing nul termination:
>
> drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equ=
als destination size [-Werror=3Dstringop-truncation]
>    60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equ=
als destination size [-Werror=3Dstringop-truncation]
>    61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE=
_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
>
> This one is intentional, so rewrite the code in a way that avoids the
> warning. Since there is already an extra strlen() and an overflow check,
> the actual size to be copied is already known here.
>
> Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

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
>  drivers/acpi/acpica/tbfind.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..472ce2a6624b 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -36,7 +36,7 @@ acpi_tb_find_table(char *signature,
>  {
>         acpi_status status =3D AE_OK;
>         struct acpi_table_header header;
> -       u32 i;
> +       u32 len, i;
>
>         ACPI_FUNCTION_TRACE(tb_find_table);
>
> @@ -46,19 +46,18 @@ acpi_tb_find_table(char *signature,
>                 return_ACPI_STATUS(AE_BAD_SIGNATURE);
>         }
>
> -       /* Don't allow the OEM strings to be too long */
> -
> -       if ((strlen(oem_id) > ACPI_OEM_ID_SIZE) ||
> -           (strlen(oem_table_id) > ACPI_OEM_TABLE_ID_SIZE)) {
> -               return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> -       }
> -
>         /* Normalize the input strings */
>
>         memset(&header, 0, sizeof(struct acpi_table_header));
>         ACPI_COPY_NAMESEG(header.signature, signature);
> -       strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -       strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE=
);
> +       len =3D strlen(oem_id);
> +       if (len > ACPI_OEM_ID_SIZE)
> +               return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> +       memcpy(header.oem_id, oem_id, len);
> +       len =3D strlen(oem_table_id);
> +       if (len > ACPI_OEM_TABLE_ID_SIZE)
> +               return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> +       memcpy(header.oem_table_id, oem_table_id, len);
>
>         /* Search for the table */
>
> --
> 2.39.2
>
>

