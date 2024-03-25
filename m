Return-Path: <linux-kernel+bounces-116686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87788A28F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99502A7CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1BC148FED;
	Mon, 25 Mar 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBkduOB3"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7918D898;
	Mon, 25 Mar 2024 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354792; cv=none; b=g6eb0Sj4S07C87VpqepsyAVoyyR0BUWvAGrZFa4BUej4CR6YIwi7nDSkLUkSQXtSOcJBeH5y0z38/TUzdx7cocDXkdYQ40QjwTWp5SprSqQxgaJfTkoW1ZnVyO0k09NfSqnMUy6eDL/01DHgHts4Ngg1Ex1wNEla1CROAaSi9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354792; c=relaxed/simple;
	bh=lIpUYQJtPvS3BxEqA7zTq9KBEkYJ5PSk/erw1/XkCf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTkDwm5dheZsp+spExsWtZqYmO8gKkZm53Xtd+0ORmG3lJq56mKQNI2rWW2dKbXVsZRZLAIv2BejGUjIjKHdlS1py7Q6RV8mVv14ZDNVw0Cqo/eKakDwU0HXUFMZQnPTAOAR0766XQOGUdJSo6GD7Pm3bt2nS4VZwUrYVmAhrA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBkduOB3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4a901e284so80715921fa.1;
        Mon, 25 Mar 2024 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711354789; x=1711959589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyaog/ojigT48JKNMU9i5w4rtbwucwfAGNUHLnrxdoA=;
        b=HBkduOB3ndsNh8nfO3+gLVUtX2QPdXU2AypbHIJsWdmeO7R6UlSLw/C90CDFWF8IYv
         nAP2gEbqDc4Hp7JbdAU5HYY8OSKywqEG0K9RDVqX3mh2edPQ28s3ilj0rb2kr2l/FxiW
         bGxDpee69beInRLjC9V100QhNRHGklhcEDsfawVCHIXBj/gsdAgBqejoBdWYYhnNW9FN
         cHbH1Z4W/Fe4SbUodGN8r7FKZ43NMHuUM30NlB71dDVbnN0doNFf2QscZ5DpnDBzNVjK
         lqdUZkNtPI8x9fZG+TxslN26h2IheoJaTh0RDDVik8zsiQdOl27/HpqrBD9vMaGgI4hi
         /O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711354789; x=1711959589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyaog/ojigT48JKNMU9i5w4rtbwucwfAGNUHLnrxdoA=;
        b=h5pjVDGS7a3pshpTnJ5dZYrI14qcFR6zo/gCj9GiikOXry/5kDo2oZYUBDa/TFdjHu
         uVI/W3ckdGwLWdMz4vDq0QAimj+HbxYXGZxUjZ7XZV8W2qgMo352oyKyIkv3I+5cZgwO
         DFMz89BKwRt2lY5KQzBApJXrQt1hk+JKFgoNFYCpE7eUHqEJnp01Lq/9m0WyjCC1tMjZ
         k48gxo9vYuHg2aRR+KwVjUjwhTwzTkaZEbUCDHjsBzCsZ2nwArtbflW6vq9zDeMEUIuQ
         JZcDbAo9xomr1OM4M49pXn7zREMC76DOZwmjRLGU3fcmpSEJVwwuTOwffnrKPnhlpW0l
         8kcA==
X-Forwarded-Encrypted: i=1; AJvYcCVpLHyp+Gu8SgQIXUBrINAXyfj4c9q9i450Jpl59ph4zjArfgb3SnpisAMWU7O8gjbdnwXOxoPmgkbmenXKdYLNgasL2ZyGbiJ7qIxK
X-Gm-Message-State: AOJu0YyaP/PnRn6W3nVg8owOC6FiSYglKbrq7LxyHvnw/D+rfSMUFC2o
	jp/qvK+sS1+LDDHXcUYXOBQCHDLB3dXoSTpJIJJ45YNTPJ2YSAL3XCQ2iTT8PSObNrqczy+SRIp
	pz9BEw5/sQRsHSyLMHJ9qaJS0KjQJl/Tlfr4=
X-Google-Smtp-Source: AGHT+IERKZc9n0PabjTyQJRPIveAjnM6cvGj82VJT164+gkS1jNiwYxhEiYn3QgUTnfemm4WlRTNSptza4XrgKro6II=
X-Received: by 2002:a2e:9048:0:b0:2d4:6cde:fbe3 with SMTP id
 n8-20020a2e9048000000b002d46cdefbe3mr4579558ljg.24.1711354788449; Mon, 25 Mar
 2024 01:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325024628.101296-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240325024628.101296-1-yang.lee@linux.alibaba.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 25 Mar 2024 17:19:31 +0900
Message-ID: <CAKFNMon5w_AfJmdey-XY+wWK+yCqj9PuHVeJf4qa2TMNv_iPsg@mail.gmail.com>
Subject: Re: [PATCH -next 2/3 v2] fs: Add kernel-doc comments to nilfs_btree_convert_and_insert()
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:46=E2=80=AFAM Yang Li wrote:
>
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function nilfs_btree_convert_and_insert.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/nilfs2/btree.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
> index 65659fa0372e..de38012fd87c 100644
> --- a/fs/nilfs2/btree.c
> +++ b/fs/nilfs2/btree.c
> @@ -1857,13 +1857,21 @@ nilfs_btree_commit_convert_and_insert(struct nilf=
s_bmap *btree,
>  }
>
>  /**
> - * nilfs_btree_convert_and_insert -
> - * @bmap:
> - * @key:
> - * @ptr:
> - * @keys:
> - * @ptrs:
> - * @n:
> + * nilfs_btree_convert_and_insert - Convert and insert entries into a B-=
tree
> + * @btree: NILFS B-tree structure
> + * @key: Key of the new entry to be inserted
> + * @ptr: Pointer (block number) associated with the key to be inserted
> + * @keys: Array of keys to be inserted in addition to @key
> + * @ptrs: Array of pointers associated with @keys
> + * @n: Number of keys and pointers in @keys and @ptrs
> + *
> + * This function is used to insert a new entry specified by @key and @pt=
r, along
> + * with additional entries specified by @keys and @ptrs arrays, into a N=
ILFS B-tree.
> + * It prepares the necessary changes by allocating the required blocks a=
nd any
> + * necessary intermediate nodes. It converts configurations from other f=
orms of block
> + * mapping (the one that currently exists is direct mapping) to a B-tree=
.
> + *
> + * Return: 0 on success or a negative error code on failure.
>   */
>  int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
>                                    __u64 key, __u64 ptr,
> --
> 2.20.1.7.g153144c
>

Thank you for the revised version.  I'll take this one.

Ryusuke Konishi

