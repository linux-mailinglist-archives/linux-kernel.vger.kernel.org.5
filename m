Return-Path: <linux-kernel+bounces-855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE639814716
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572A61F22CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25203250FA;
	Fri, 15 Dec 2023 11:37:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9D250E3;
	Fri, 15 Dec 2023 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9db92bd71so162836a34.1;
        Fri, 15 Dec 2023 03:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702640243; x=1703245043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chmxXCVKTjnWRwvktM7WJmrnV0qr6vYgbWjqnpS7IJo=;
        b=Fe7aChh+3ejMtqF5Om8aJGgVcLkq5rNdYcJ+DZu03zYkIvJCGN725P2rheWvJFiKAS
         DKRqdpILre21UTeyC2lO+Nrh1BDmmemd24LCAylcJea5/2m4YBv4RNTEGfyBmIMN8iF/
         YkF+mCIrPGSPAbNM4yx+y4sw6K5hoo1cLIe0kEtVRO+IM+H9hF662urcF7AUv6gs+i6H
         hA5K+TLDQdO5oXKxoKlY8zXkeHlKAPFcJrNgjjsbQZHId7w5ecjTNeOMO0QL3q+9qhpl
         2HSlSZ2KzwNntu+n8zsCX/YCnoAytPZyO9PsXYOQuQjHvajz+xDksJXw4Weh0ClHSSpr
         VGNQ==
X-Gm-Message-State: AOJu0YzkPDKskCsntnS5tOt7tSMHnJrCaCUV7Dwr93UBD64YbDdtFkks
	prSapoS3ifc+MzODZ82IPiqBVg50eiCGFNqztU4=
X-Google-Smtp-Source: AGHT+IHTDUq4BO4EjBrWxr3vF8ypXzDh/RIrRjQ+P+DlBmh/k3JHusO3Z8YMKWXD+gagQce78H4HrFlNyrnOYcvrN0k=
X-Received: by 2002:a05:6870:860c:b0:203:7c44:b622 with SMTP id
 h12-20020a056870860c00b002037c44b622mr225641oal.0.1702640243406; Fri, 15 Dec
 2023 03:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215112950.13916-1-colin.i.king@gmail.com>
In-Reply-To: <20231215112950.13916-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Dec 2023 12:37:12 +0100
Message-ID: <CAJZ5v0juh7nO-KenieqCRLnhmBSDUSNYRcYBDKpSsMORUiKseQ@mail.gmail.com>
Subject: Re: [PATCH][next] PM: hibernate: Fix spelling mistake "hiberantion"
 -> "hibernation"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:29=E2=80=AFPM Colin Ian King <colin.i.king@gmail=
.com> wrote:
>
> There is a spelling mistake in a pr_info message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/power/hibernate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index f8c81ef5b172..4b0b7cf2e019 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -671,7 +671,7 @@ static void power_down(void)
>                 if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
>                         swsusp_unmark();
>                         events_check_enabled =3D false;
> -                       pr_info("Wakeup event detected during hiberantion=
, rolling back.\n");
> +                       pr_info("Wakeup event detected during hibernation=
, rolling back.\n");
>                         return;
>                 }
>                 fallthrough;
> --

Thanks, I've fixed it in the tree in the meantime.

