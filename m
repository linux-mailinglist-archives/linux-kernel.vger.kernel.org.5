Return-Path: <linux-kernel+bounces-118940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEDF88C1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383E01F3456E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F49171731;
	Tue, 26 Mar 2024 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDKDmqtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC1C6E61B;
	Tue, 26 Mar 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454887; cv=none; b=lGvO87JXZStxjNqYnXydNvWPWo/55Vv69p8Hyr7gZ7QscucUEOse1ucxY5UsZ2XkvVMvYnOlbFBShsuKqMplbVPVsJxVVUBxngVICOOCsvOZKp44YvmqxHDiSFM97S3oEHazjbNK8KSwa5mIDxBVfvWjcQiYztxftxg8NadAAys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454887; c=relaxed/simple;
	bh=+JYnu5emNgwEhffD7wjz6RfzwF5VDV57vHflFSPkjQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw3VAW56+OELMDQ5kgwGQ1DGQicq1051Rgnix2Aokqsen34kZoUErySDHksNh+XqXjjdFpKN80Tww9tlWnFXAXo24KCDmw2n5IeaTaTBV5qHllAIcLAo8oqr2D2jqhfaLx4HnV6beSFu6SKosm35PhllJyZdUwJIs8PgNT5e0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDKDmqtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324EBC433F1;
	Tue, 26 Mar 2024 12:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454887;
	bh=+JYnu5emNgwEhffD7wjz6RfzwF5VDV57vHflFSPkjQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tDKDmqtNz6pQZIugZvH6fEiUGmGcfgZc+0HcylzuD03kRmdgjSTMJjtPXgkooZqE4
	 K75IvqV1VA0a6Fc7W59kkjN24unq0udazgM9ZJM4lsKgEwcg1GWrzJYz4AvIVzdjHG
	 5+DBKk9tmA8mmxT1tOK6Kk3uMp+fMNI//GMZLEaWtC+6MyOb8cO476/vXiIkUL4XWq
	 8a8ieQrIog3Jty7r+Zd0bufmrpaEIV4vUk7yrktrXGtpMLIQ6CdMKkr8CGFWkqyQP7
	 RctvWgpzGN9L1OR0lJqrCY6wPBWYiq2oIQ30F4fo9DVBMn5J8ZR8YFQaPz0qjIxAYI
	 sze2/6FdUAy9Q==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a46ad0d981so1266871eaf.1;
        Tue, 26 Mar 2024 05:08:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrx7erH3FOiGVpNwXYUpw9DTCAqF22/vZERynTzqmdIAJSbWpY5pWEvqLJODe/HIEVGNT/wLtjgKDknA9aBc1o0WxVdElPAO0AgHaT6VBjDQYRe9NZ0hilkAE266fYopHeLiI0OyGIEg==
X-Gm-Message-State: AOJu0YwmLkNLx1Vnyao73eZSL2ZF8zAAKrgp4cN8Om1NTu4RjTByoEi7
	2mgSlER4jaSP4hdoc9wynOSE9iIBl9EThME4kDXOr9jkcQxh4gyLDd1Z0sLPbiTTEY0acJ5ykMf
	auYc97bOb0LUhybK3Pr+wbTC9jDM=
X-Google-Smtp-Source: AGHT+IEX7/3bqP2g4RhkkN03lYfLqGuaIjY5MPN5VZV2xraUgKf1Irx0etz7kkJgjwvEIwCKtzXzqfKw+8ET1f5pR10=
X-Received: by 2002:a05:6820:820:b0:5a4:7300:b57f with SMTP id
 bg32-20020a056820082000b005a47300b57fmr9614933oob.1.1711454886495; Tue, 26
 Mar 2024 05:08:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0i7LYzF13M0qdeYWXZ7uO6HUpAS7pE5RJnOAJtKB8o88A@mail.gmail.com>
 <20240322180753.5612-1-kiryushin@ancud.ru>
In-Reply-To: <20240322180753.5612-1-kiryushin@ancud.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Mar 2024 13:07:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmO8_cosZ5j6iLRFaBEscxTGtfb5JTmnDeRqTOS-6-JQ@mail.gmail.com>
Message-ID: <CAJZ5v0gmO8_cosZ5j6iLRFaBEscxTGtfb5JTmnDeRqTOS-6-JQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: debugger: check status of acpi_evaluate_object
 in acpi_db_walk_for_fields
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:23=E2=80=AFPM Nikita Kiryushin <kiryushin@ancud.r=
u> wrote:
>
> ACPICA commit 9061cd9aa131205657c811a52a9f8325a040c6c9
>
> Errors in acpi_evaluate_object can lead to incorrect state of buffer.
> This can lead to access to data in previously ACPI_FREEd buffer and
> secondary ACPI_FREE to the same buffer later.
>
> Handle errors in acpi_evaluate_object the same way it is done earlier
> with acpi_ns_handle_to_pathname.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Link: https://github.com/acpica/acpica/commit/9061cd9a
> Fixes: 5fd033288a86 ("ACPICA: debugger: add command to dump all fields of=
 particular subtype")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
> v2: Add ACPICA project git links for corresponding changes
>  drivers/acpi/acpica/dbnames.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.=
c
> index b91155ea9c34..c9131259f717 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -550,8 +550,12 @@ acpi_db_walk_for_fields(acpi_handle obj_handle,
>         ACPI_FREE(buffer.pointer);
>
>         buffer.length =3D ACPI_ALLOCATE_LOCAL_BUFFER;
> -       acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> -
> +       status =3D acpi_evaluate_object(obj_handle, NULL, NULL, &buffer);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_os_printf("Could Not evaluate object %p\n",
> +                              obj_handle);
> +               return (AE_OK);
> +       }
>         /*
>          * Since this is a field unit, surround the output in braces
>          */
> --

Applied as 6.10 material, thanks!

