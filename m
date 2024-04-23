Return-Path: <linux-kernel+bounces-154534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D98ADD3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC2A1C219DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE221A0D;
	Tue, 23 Apr 2024 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLMYWc7V"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFA1F94C;
	Tue, 23 Apr 2024 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851679; cv=none; b=QRHhswu8vVgngAZ5ddxPRddCs6pZxmh5BvDABdCr2EOQfLCyYs6dgjp4jR9BNPihbtZGHPdsFE6BlbxPz9258km1lMtvqemfqqsiy0xo2a+LlVTD13HzPUHkkxOP4lCByF56+ZIeSQSsvp/wRCzs0eJQ03Oo+ZOaNzVTyViJ1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851679; c=relaxed/simple;
	bh=9L+ipYI8qnAp7eUbDlbr4zcaItxYRGOATmFCWVnZhC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPONRaomAJ0C1yvR/YEyxphRn7KoPrr6U7CEbY2wWX9m7fyorlzkOF8E5Ww2nIagO0OsioTMKuVk1aC0lZmoURqVkBupL3aLfJ6GfVA3mbuF6zpw8WGyEZb1+P/XcKcX2/cCbJKlPziuOipDr69TZekg1oodCzXvwr3x1rrS/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLMYWc7V; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434d0e3f213so22189481cf.3;
        Mon, 22 Apr 2024 22:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713851677; x=1714456477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRiPqemyG657HWm31scapBiAfh8ghba+RBNXOeShCQs=;
        b=hLMYWc7VfdD4V4SDSAVjuCaDno1r1/5/P+66NvCVzm4KYRBsFSMDGW484LlgCmV4qu
         YqVY+HYrWSlDZBP8LamGOicgMCqhSw6LyU2NnLXMXIJiq4I7tLEJo3qw7iV+OnESdXjw
         qzVQe+j8OZzxvrNyIhNfORuV2JgU5TKm9ojkbb6AHhnTxnZT4Ga0vd2nP5Tky1bXwOG5
         VK7N3miYJpml7/eox5Av1Zgq+njRULY1q26sMh+vMU/Vk/4jHjz7D7beLjyGE912R/5n
         cvWUnoncZM81nSlIvBafrip9ihpaUV4drOSUMRRLHulwwlBsB0bkSx8TDuWx81uf1ihi
         HbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713851677; x=1714456477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRiPqemyG657HWm31scapBiAfh8ghba+RBNXOeShCQs=;
        b=tYASV5uAuvLMY0o9/G7up2R49INOx50zpjr8ZKWMgQ4YEOsF93p6K8o6GMGjM0+N1G
         Wc5tQX9RREZwYUlfB1YCMPuUXYJbB8ghILQbOKXR+3FFAHnYzXHlZz/T9tWbGAc9tgJ7
         PbKnl7qe8nMpqkqOsAJ+XIVjh5kPtexmaa/z1bHPR9Us1hPv5FbVbYIU968d0Kk4WC1o
         /GmCxBeTEs5oc43nbTlOaSJebJCfTfkBhbWGQoHI2t7rpKFi5Rg8AF0d3NEinClpMCIY
         g7/i/6vKkdDMhkDyW0Ul35a0AxQ6RfszYG7UOo60his1FOLGGLHseuI1kFCJ/+yK21cu
         A/PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGLgTF6vYsNnSkt50cPv/k4AXEX9i8N5CkQH6snHZesQ49oYNt6zhObXLhQAizpm3CIGnyoJxIYTUAIN0Y4N9ftky2mv5F/t195FywlzOEgiHjhsWuG5uphveZD+F5YWYnsmdr681zU7Xljw==
X-Gm-Message-State: AOJu0YzPer1ylkjqD1Lz2fJzlpdEW5Fs8BFWeLIgSH0OCY0sp4pkIEyE
	ugzlBGrzd0D7yqX9t4/FsTfkG45UhsY5ADesxFG3XK8lX075JbmYWXv66nw5MbfPB5gPK3NG5iL
	2isMw1cENUNtDYDiaK8v0cVRJt/0=
X-Google-Smtp-Source: AGHT+IE6SM0yjIkNKq3M/EE42pcJzqU6sZWg8aYOwNal+lAI9oU8pJ3H9043GFEY+qc+dsbyFuSCKMw50X5UQQ5iK6A=
X-Received: by 2002:a05:622a:453:b0:432:b84a:826e with SMTP id
 o19-20020a05622a045300b00432b84a826emr14476534qtx.35.1713851677116; Mon, 22
 Apr 2024 22:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422150651.2908169-1-stefanb@linux.ibm.com> <20240422150651.2908169-2-stefanb@linux.ibm.com>
In-Reply-To: <20240422150651.2908169-2-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Apr 2024 08:54:25 +0300
Message-ID: <CAOQ4uxhnU=bCPO1eSfagaNmwJVE0ea1wJoXiv1hRUzCnMzyM7A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] ovl: Define D_REAL_FILEDATA for d_real to
 return dentry with data
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	miklos@szeredi.hu, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:07=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> Define D_REAL_FILEDATA which is to be used as a parameter for d_real()
> to return the dentry that is holding the file data, which is either the
> upper or the lower denry. The caller is expected to call d_real() again
> on the returned dentry to get to lower layers of a stacked filesystem,
> if available. This allows a caller to get all dentries involved in hold
> a file's data and iterate through the layers.
>

Did you miss my comments on v1?
https://lore.kernel.org/linux-unionfs/CAOQ4uxgNRYi-mYo=3DLZ5yiWch2zwDeTG2q9=
ZYD0ysEN6XaJkVhw@mail.gmail.com/

Did you not understand them?
Or did you just decide to ignore them?

Thanks,
Amir.

> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/super.c   | 6 ++++++
>  include/linux/dcache.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 06a231970cb5..f466ad89b005 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -36,6 +36,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         switch (type) {
>         case D_REAL_DATA:
>         case D_REAL_METADATA:
> +       case D_REAL_FILEDATA:
>                 break;
>         default:
>                 goto bug;
> @@ -47,6 +48,11 @@ static struct dentry *ovl_d_real(struct dentry *dentry=
, enum d_real_type type)
>         }
>
>         upper =3D ovl_dentry_upper(dentry);
> +       if (type =3D=3D D_REAL_FILEDATA) {
> +               if (ovl_has_upperdata(d_inode(dentry)))
> +                       return upper;
> +               return ovl_dentry_lower(dentry);
> +       }
>         if (upper && (type =3D=3D D_REAL_METADATA ||
>                       ovl_has_upperdata(d_inode(dentry))))
>                 return upper;
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index bf53e3894aae..e4e54fb2cf4e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -128,6 +128,7 @@ enum dentry_d_lock_class
>  enum d_real_type {
>         D_REAL_DATA,
>         D_REAL_METADATA,
> +       D_REAL_FILEDATA,
>  };
>
>  struct dentry_operations {
> --
> 2.43.0
>

