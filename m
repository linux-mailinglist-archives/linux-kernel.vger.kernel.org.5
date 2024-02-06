Return-Path: <linux-kernel+bounces-55245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE95184B9BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400AEB2B5FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8298B133423;
	Tue,  6 Feb 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtX7qbUH"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6897A132C3A;
	Tue,  6 Feb 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233631; cv=none; b=J9jnv6TgO6tJUICfISA/7GeoCyfycHvbt5qFGgCdro+m3LKBsiDJB1bux+CrReGPFyt8uYyFXkrDKo4xVIuO6QUR1LbaSFWQW+B250wio6HCFnvMuVyb1LDQOgzdduIVDzeFEGFtTIkox1gFwG/p6LclerCxYyPE8AvwjwBU9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233631; c=relaxed/simple;
	bh=Pq675YyLd2zT05WD6JVqAm14l+wk2+OREl+RR7JEuKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOcPWecZU5ldOzA1AV8GaXkx3P2v/cJUAEpmY8GseQy4pFtVajqEk1LxBXMNarBOSVplZZtDt2HYvJOCza0uXxCnMCMwQUEyoO02/wifwIMvwLmTaFh/AWCZjlU5t8nLDbnMWXt1FdwYrJpcGg1zxdGOoEBgOuNZ5X82XQZmKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtX7qbUH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68c8790aeadso29973666d6.1;
        Tue, 06 Feb 2024 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707233629; x=1707838429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsCHj3o7AvzybMtFe1QCWiHO2CXrsBDEsd537/xdmUc=;
        b=DtX7qbUHimmUdlP6/vlkbPtPxW8eLyYTeRbQstiYuOUN8c0ZGXm5NuRdRlGaCDb1Ay
         wQT4RP7uZ4ZDnyZ4EUo7AGX5yeEiWFjBZBJ+tzW4Lm1D0eX4A3u/5V/Gqmp7otyzP1uM
         yOO9HG688SyduVHbj3eax5+TMJuWDBbSk3aCKPmvR+p7jg8oAwI5dv6+mtx23aD+Fxne
         9dcEYSEi7PUFILslYFjm9VO6MU1uzGBi0ng8WMMptm5P9cS0HaiHALISvOVftoJAYJyj
         D2b6JIOSqb6h0xdGGAmhyvq5JhfBcMonYmOCCr590Q1cDDcmvsKA2MBYbr6Okc1wVzAs
         J7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233629; x=1707838429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsCHj3o7AvzybMtFe1QCWiHO2CXrsBDEsd537/xdmUc=;
        b=WolLrPEzMQ0ys6YrTzsjwEhu3uE2h190TdfdJN/aEX+TMu/aEZl0N9YmUMfZ/wVdtQ
         Kf8bh6+TVRRQiFknkzMuEqYw6wXCNgpz1oGl8o+K0iqowoKAlWDIMZXprRSjHzVmQMMS
         2nEpygr6qD0eBLqNKNCVSikfAJ0QXFnyfFzbGoEZMpQ3I1rBRB2I+Hmkes6YPOCxEaih
         H03WHHq0N5/dRPHyPCUwsfR8pwexGna0TsVoc/son4ZOswaIS3yfzyD+Mcq+LscdVsmA
         RUiQuhO/ZrPWk07tA5usdy9wDt8u9bSKHkvj2N8w2TBmwJWXxhBsl/nd4I4vTB7C9ov8
         IsYA==
X-Gm-Message-State: AOJu0YyKVgZci3BH+5DJbmxb3c08Y94PYtrwNMu/Wi7EQmbsIp2tz7CR
	Iy3+D2k+h5Tro4gmrru9pyod8iPvmpJNhbkfTQ6JrAt+XfHqJiNf7t8LmWhG5jrRnWVDRJ4rvt3
	x4jkei1fxp9nT6RS+9rhUBBrXcZE=
X-Google-Smtp-Source: AGHT+IGmSM9ZFMWDa22ikiTXuqAqMVu+DEw5ne3rtVqJanmk61QSXJoEdS9UumRX+As1rDxB5ImrAaje8zrMgMrR1l8=
X-Received: by 2002:a05:6214:519b:b0:68c:9b50:b839 with SMTP id
 kl27-20020a056214519b00b0068c9b50b839mr2980214qvb.61.1707233629215; Tue, 06
 Feb 2024 07:33:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-6-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-6-stefanb@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 17:33:38 +0200
Message-ID: <CAOQ4uxhhRo20oCrDvs42e4m=HzdUSZ+YtMv8JVykuNoHGP8ypA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] evm: Use the inode holding the metadata to
 calculate metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, brauner@kernel.org, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 8:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Changes to file attributes (mode bits, uid, gid) on the lower layer are
> not taken into account when d_backing_inode() is used when a file is
> accessed on the overlay layer and this file has not yet been copied up.
> This is because d_backing_inode() does not return the real inode of the
> lower layer but instead returns the backing inode which in this case
> holds wrong file attributes. Further, when CONFIG_OVERLAY_FS_METACOPY is
> enabled and a copy-up is triggered due to file metadata changes, then
> the metadata are held by the backing inode while the data are still held
> by the real inode. Therefore, use d_inode(d_real(dentry, D_REAL_METADATA)=
)
> to get to the inode holding the file's metadata and use it to calculate
> the metadata hash with.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  security/integrity/evm/evm_crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index b1ffd4cc0b44..51e24a75742c 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentr=
y,
>                                  size_t req_xattr_value_len,
>                                  uint8_t type, struct evm_digest *data)
>  {
> -       struct inode *inode =3D d_backing_inode(dentry);
> +       struct inode *inode =3D d_inode(d_real(dentry, D_REAL_METADATA));
>         struct xattr_list *xattr;
>         struct shash_desc *desc;
>         size_t xattr_size =3D 0;
> --
> 2.43.0
>

