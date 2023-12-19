Return-Path: <linux-kernel+bounces-5411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B536818A64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED491C21806
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7459B1C288;
	Tue, 19 Dec 2023 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKM/Xn7g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F681BDCB;
	Tue, 19 Dec 2023 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-67f47b15fa3so14125876d6.1;
        Tue, 19 Dec 2023 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702997245; x=1703602045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlUxM8agQFht/Im8QSE/t73OtBt36Jo3dQYhethqDtk=;
        b=CKM/Xn7gcHG/SDJ8ARD/WpPVJ0qFEeIkcP3wAbXLgCmR4F8XxfALFthpZiP3AwiEV8
         iZjo1pkVQaKBTc++7EYONWwgoLjeMPrtX7SXBbwhXg7qpK2gYFcCPb2y2EtdkafJzh+4
         E6HVxxvI4AA+gWAJ99e1Vqlicmj+fuJlHVOObHsTtQUYyQZqYYYQWwGbEeTe9lTuHjoY
         8kLzD2QvrE2cWWeXLnTP5BL56VKtZW/XHXiODo5HOYBSKihqOXX3eA9LB3dff8LXmpXF
         Y5UT3aQhlti8rAOR0/rHGRpU/fPY1kbm6sThmV1TbqBDc+tlE7FnLR9+WB6r58MsGcSm
         WDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702997245; x=1703602045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlUxM8agQFht/Im8QSE/t73OtBt36Jo3dQYhethqDtk=;
        b=VuWlI8uFaUpwXN/kA4421fcRjcq4n7knfQZja4hqXIBUjC73ytSOFp+8tnIR7HgLZa
         KTie8epiRYPznrjfRm1Y2PFtqlpA8xfLxNbeR33lJ1BhTdVm9Be+YaldDUG8QN/OWKjK
         HtrpJw5ILwiOcI/NVw+ij5IBSymQCsImtRhULiwFclugcAo0vTAYRy2o4xUdDjOkUr0A
         m81QRdFPGYvmekBeY1mTcf7gMk83RIcdO4dAKfTWR+hg5QHQTYZiiohDTlj3H5A3dnqJ
         hnrGUkAR42IYDj7IazNhtA7G9xJ27VBZuSe8x/rAfa80fAIAAzvzlLI/KQcPisQ2mwuC
         eIdg==
X-Gm-Message-State: AOJu0YyuzOAlYSN4bKTVLLcGmORuFOWAd5VPX5PkBFnXlpNpFWHGK1s7
	Hv4UpCkzWYmFEnu0rDFki34zl/3BbUG+tjlIu0A=
X-Google-Smtp-Source: AGHT+IFgOnMLQDOxvtlxSolOpF3BG+QjC3iZIQoGyb7nHvaMJ3LbRonwYDI9SE8Yz2xE4dYji1sfPH+tvB/1DPL3iaM=
X-Received: by 2002:a05:6214:416:b0:67f:5152:705b with SMTP id
 z22-20020a056214041600b0067f5152705bmr2957837qvx.46.1702997245321; Tue, 19
 Dec 2023 06:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219134901.96300-1-zohar@linux.ibm.com> <20231219134901.96300-3-zohar@linux.ibm.com>
In-Reply-To: <20231219134901.96300-3-zohar@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 19 Dec 2023 16:47:14 +0200
Message-ID: <CAOQ4uxhti7BybvXKAxckQM3UghehVVEWD3Kod+55SL+i13-wog@mail.gmail.com>
Subject: Re: [PATCH 2/2] evm: add support to disable EVM on unsupported filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-unionfs@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 3:49=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Don't verify, write, remove or update 'security.evm' on unsupported
> filesystems.
>
> Temporarily define overlayfs as an unsupported filesystem until
> a complete solution is developed.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/evm/evm_main.c | 35 ++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 02adba635b02..aa6d32a07d20 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -151,6 +151,17 @@ static int evm_find_protected_xattrs(struct dentry *=
dentry)
>         return count;
>  }
>
> +static int is_unsupported_fs(struct dentry *dentry)
> +{
> +       struct inode *inode =3D d_backing_inode(dentry);
> +
> +       if (strcmp(inode->i_sb->s_type->name, "overlay") =3D=3D 0) {
> +               pr_info_once("overlayfs not supported\n");
> +               return 1;
> +       }

Please do not special case overlayfs in and please do not use the
fs name to detect support.

Please define an sb flag like SB_I_IMA_UNVERIFIABLE_SIGNATURE
to disable EVM and set this flag in ovl_fill_super().

Thanks,
Amir.

