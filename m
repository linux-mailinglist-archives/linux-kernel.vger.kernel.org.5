Return-Path: <linux-kernel+bounces-143172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C67A8A3558
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05809282432
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF2914EC7D;
	Fri, 12 Apr 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BembhugX"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE7148313;
	Fri, 12 Apr 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945113; cv=none; b=rcmBnW2yc/rTF/tdFwTXiNEuIhS2LN+O5usb81TNhFxTg32FuuilO4+bHTG12LCQvUKJQtAbe/6y9KaJlut9LuJ1n8g5Gkj0GqtITwm92uu0P+KUktNADw/drVFTRUGdTYAwYIKU4agMf6UUAjmUauc7vS6DGzq1Q0NkygEL630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945113; c=relaxed/simple;
	bh=+OOlDC7Xxm6MIaBGhJg19XXHllnLQ9JmPImaSQkrJ18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jl8ETz37UbaHP0asWL+8fZu7om9iQnZHWwgOl+DakmD7359PJTzd0KIZLlxH/vAldgRYRE1SMK4thjbaBrhwxPIZHBJrsrOQeV8zXER5lT0upm95Occ5D4EmdMEdePM82rdGOodDk4vmFjh5zInpvqV1rpUUErPPlqC1Sco/BME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BembhugX; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-696315c9da5so10005116d6.2;
        Fri, 12 Apr 2024 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945111; x=1713549911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXIp91wOih9CoCfNDEheAqOA0zoVihgOT0Xf+EbLOzs=;
        b=BembhugXcDGLgv5SQW5FFSr67EiA2p7ltSOkEPfLeb0NtSglFEemLAKwky1e2FCO9S
         wokQlMwMS8meeMbfpFXIJ/up+v5ndGPydNqDCnDYRHAF+4YhX1BD4bDbfrXUSCS3t1Xo
         K5/K4pHc06tHEdecuw+0IxMm6Mt8hcNoZSpsCOrmFfJ4oKLc/baxTK0EH+U4SF7H3HmG
         eeu3xVFZFV+a7/0nNv2gA/vtVcTENoDfvgArkOqzoVYhycwM34N5XOGE/aXfR5WY1kBF
         fydUTDgx5ad7W1+9oNMe/neUrAEeYoR+kp9qM96XQMHQyc38gigo0ov3hmQoa6Ag7moY
         2sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945111; x=1713549911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXIp91wOih9CoCfNDEheAqOA0zoVihgOT0Xf+EbLOzs=;
        b=EJG8Sr/O/4f/bftFinYBx81ZDmrFTVTjoFP/YGz/ygYWmsfw14iGnOPXCBTmaRHhW1
         P99+Y4OIgzA3MxgRvi/+tZ+gXaVd1AEkve7TBwrG0Y259IiIUEzEsYHS5o6/oSM67JbB
         lKUtdSufzcvThfh2L3SErcPKbPLliJaLFwPNKtDMJjB5Il0Jp5rhfr1Vp380D3/M0nkj
         kzMuQ0xZAbkg0EedQBiD+xoWH4xquEWqlBG0J0nyAxv2PdVaPXPVfmXzvXar2ajGHVDI
         RDkAKIkQeVHJd9V4E2jDSpVus/FwhpShvHiq5TaiGQZgDxBq8IWS7K5HnqOZrf2j12JX
         95Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXbwphoZTssr9yRCbR6UYEbVzDaljdMtfSNLnAevACoo+POhKf67DHiJXEwPhlAIJGJffUHwRHDcM4DiRnwcfSspatSu6nyVw9uw4X8PXCcvpoBV1WQlBTqL3q5jxrIPQ/usDITjcON87TpoA==
X-Gm-Message-State: AOJu0YxEWZqhqPjBm2Gl3QjgUw60vl12qNNr02chhLVp4YL51m5iaKVd
	D+ybczWjgv/WouEiTdLI2Us/WZQeFtDQGLV2YzamIfcMxfGuJ12IE+mXBsKIl6kYd1X7RPdySou
	ygj36fmuSuqWKzyLpVQJLSZ50fxI=
X-Google-Smtp-Source: AGHT+IG/8HJwtDYDi7eVF5555tvAtRnoSP6wV0lzz7X8Ji2t5zDXvQOTMLyRxapB9H3x4DDuD5pCvPEYTWgU020ambk=
X-Received: by 2002:a0c:e852:0:b0:699:2274:b229 with SMTP id
 l18-20020a0ce852000000b006992274b229mr3779676qvo.14.1712945111598; Fri, 12
 Apr 2024 11:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com> <20240412140122.2607743-2-stefanb@linux.ibm.com>
In-Reply-To: <20240412140122.2607743-2-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 12 Apr 2024 21:05:00 +0300
Message-ID: <CAOQ4uxgNRYi-mYo=LZ5yiWch2zwDeTG2q9ZYD0ysEN6XaJkVhw@mail.gmail.com>
Subject: Re: [RFC 1/2] ovl: Define D_REAL_FILEDATA for d_real to return dentry
 with data
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:01=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
> Define D_REAL_FILEDATA which is to be used as a parameter for d_real()
> to return the dentry that is holding the file data, which is either the

D_REAL_DATA already does that

> upper or the lower denry. The caller is expected to call d_real() again
> on the returned dentry to get to lower layers of a stacked filesystem,
> if available.
>
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

This one is already the returned value for D_REAL_DATA

> +               return ovl_dentry_lower(dentry);

And this one is a wrong value, because the lower file's data is at
ovl_dentry_lowerdata(), which is what D_REAL_DATA
returns.

So it is not clear to me what it is that you tried to do here.

Thanks,
Amir.

