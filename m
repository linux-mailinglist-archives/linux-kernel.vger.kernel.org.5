Return-Path: <linux-kernel+bounces-18311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8E3825B55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635261C23A0A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F853608F;
	Fri,  5 Jan 2024 19:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykxk627v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916536AF3;
	Fri,  5 Jan 2024 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso23706651fa.0;
        Fri, 05 Jan 2024 11:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704484654; x=1705089454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRLMdfdFEFGxBekM0Ah4/mWBgPRmZGkIhZJOiMWzNJs=;
        b=Ykxk627vZgzRP2WO+/5xilXN5k5JLb2+vKIMO4tdy6gQ2OwM2PAti0Qwjs0g0v/dU5
         bF9BWe0jaC7X8BMnMMtaMASHBsssGk16M+8diw0rK9pkeyBrssmmG6nCUauU2VCaz+xF
         p+H7NjbBAsVBwPgc3yLxe2uFa1V5Wp89r346Givf3TMopo8s7hXDOIwjfDhlraC8wtVy
         4swHBD7iKgoONJxlVxHI7rxpY+WRRO11iylEQPDJfjRLRo3aazFpeJRnvLarqku9vEws
         TfztU/hQYXCtZuHCXc5ElFMcQEXyzALb1R8gNqdGp/EBmjkyhjHZIkzaUt+vVdsBIeOw
         v2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704484654; x=1705089454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRLMdfdFEFGxBekM0Ah4/mWBgPRmZGkIhZJOiMWzNJs=;
        b=jHsYLNHJml76FwpKvWkv2b4UicjzOQhI9hMrRx/BlHaVGf28JmuA7XhLF2uAqvOgPy
         t50RBLn/AAw8wvWSHiZ8IoS48kI0LSWv0rh273vNYNRTEael0/zh9Dwyc9PjgOmLuymb
         a5cc0ZLSAjN3nvTDmNp4siB7HyuLRUjMWBNJ/ZdXGOJMu8O8Oq7PPBzLdQlD/L0XZI5I
         eczciBbwU5KKfWi41tSau8/efeldfSt8739tkF3+dKZyC2QX8HHtVn/WTD83fLcKVeGa
         DGGqkrfq4YvPfokrg9pXNdweuaT/c1CGIANd5eybW+GqaZExCt4Tc2ABlI5Vk46nDjka
         hrwQ==
X-Gm-Message-State: AOJu0Yw0bJC+F3MzX7jqoqil9eTvWjs7uEVbk/S6TUK9OSchPHJ8nBam
	RPBR+RKwNsZZtKnuxQ6rbhyaL2B36UVBeDiHv3k=
X-Google-Smtp-Source: AGHT+IHGDXHjbGA05eHZAKK9YFIY2QI6JAgCi4NVMCV+oKA8gMgpFfW2yWE82rmCIYPb4lI2ZnakHtpo7zPlCtYX4B8=
X-Received: by 2002:a2e:a683:0:b0:2cc:6fbb:8b07 with SMTP id
 q3-20020a2ea683000000b002cc6fbb8b07mr565252lje.98.1704484653691; Fri, 05 Jan
 2024 11:57:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9e415e37-a5bf-459f-8b9c-a02431e8fcfd@web.de>
In-Reply-To: <9e415e37-a5bf-459f-8b9c-a02431e8fcfd@web.de>
From: Steve French <smfrench@gmail.com>
Date: Fri, 5 Jan 2024 13:57:22 -0600
Message-ID: <CAH2r5mtDbP3XZTdrT97KB8R4ujZ1qHOkn=4RUsvzsHEcmwLxwg@mail.gmail.com>
Subject: Re: [PATCH] smb3: Improve exception handling in allocate_mr_list()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	kernel-janitors@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Sat, Dec 30, 2023 at 3:47=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 29 Dec 2023 20:43:12 +0100
>
> The kfree() function was called in one case by
> the allocate_mr_list() function during error handling
> even if the passed variable contained a null pointer.
> This issue was detected by using the Coccinelle software.
>
> Thus use another label.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smbdirect.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index 94df9eec3d8d..d74e829de51c 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -2136,7 +2136,7 @@ static int allocate_mr_list(struct smbd_connection =
*info)
>         for (i =3D 0; i < info->responder_resources * 2; i++) {
>                 smbdirect_mr =3D kzalloc(sizeof(*smbdirect_mr), GFP_KERNE=
L);
>                 if (!smbdirect_mr)
> -                       goto out;
> +                       goto cleanup_entries;
>                 smbdirect_mr->mr =3D ib_alloc_mr(info->pd, info->mr_type,
>                                         info->max_frmr_depth);
>                 if (IS_ERR(smbdirect_mr->mr)) {
> @@ -2162,7 +2162,7 @@ static int allocate_mr_list(struct smbd_connection =
*info)
>
>  out:
>         kfree(smbdirect_mr);
> -
> +cleanup_entries:
>         list_for_each_entry_safe(smbdirect_mr, tmp, &info->mr_list, list)=
 {
>                 list_del(&smbdirect_mr->list);
>                 ib_dereg_mr(smbdirect_mr->mr);
> --
> 2.43.0
>
>


--=20
Thanks,

Steve

