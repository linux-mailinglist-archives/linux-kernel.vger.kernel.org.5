Return-Path: <linux-kernel+bounces-155814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0988AF77E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EA2286544
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67171420B6;
	Tue, 23 Apr 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgHw39Ro"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC8323741
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901651; cv=none; b=TM142+fEU6cTXOSw2cg7NoxC/raOzGvuKaicPJNrilb/7NoL3B1MhSI+oVfn2OJa5yb+sJ+Ivs1MOPDacBZ88GAy/jpo4NThbsrxHUGWRnqQSliAX6TsAYY9r18gj/PFjaAske25bBNkvKyot2Ml0ZsAq3c5S8UAsqd7Ljnlyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901651; c=relaxed/simple;
	bh=ixbkj61yq5jbTMkoienzARGVh47pom0IUn0lmVoDn+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=toHgfX/YYHAr7cHF3KnREnwt3+RDppV4jJuLy1geHHh1NunVxNmGir8hJxdORLYMkT4qILqj8IzHeTOBJ8IF6QlRr66rrFEE7S3PZGnWHUk/SZwr9kOr+u8DHrNqLG31afcJnP4Dy96wtJSCO1rMsH8MEQe+bbSE0s9vnjzXDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgHw39Ro; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7ebe2a0e09eso1647828241.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713901648; x=1714506448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X1Pj4rvDW2qcTYjO5QNvL4SiyuRLUqGZU3rIwevn/g=;
        b=RgHw39Rod1QVwU2U6FJBU6bKnfohgxj3JJwN//jKEv+tV8wuceIToCtPFnDeMp2K0O
         zmgGM5h4oVGR+ZRthh2Hfv/RsKXTrqU1Lri1efy6QFy9ePpTx6b06zWvLvK7BAlxGSjO
         YvT+0GVnRE5eC0Ag4F6zepO1rU34w6SMkBNLSaDiUF/thr00FI6+WXr04rj7T1iCRspP
         gT1KlLggKV6l88PGG5CQsmWzVQYYy2bFujpUbgZO/of/Oz6ZwG25huK0Mjypx138c5Hl
         Ef2rgo1RNFlgIq0e1oYmVYsdZg33T7acH1m7hokhM7o1QrtfTp11qtXPIjh07Pttpv1b
         i4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713901648; x=1714506448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X1Pj4rvDW2qcTYjO5QNvL4SiyuRLUqGZU3rIwevn/g=;
        b=BvdMGHF7yBK/pfVMmS3vU9/Wmra/XtIaOYmQTlLk772FJQRi3B3o6TxDdiubQ+dcA0
         T+E9h6HdQOiScDD6WlmJ1zb9xOgn+WFnAvto8m9AV5QdAq+NNpAyjLUPk2ca9FWWMfW9
         tfj/v/52UnfvpcRCPnAVXsElcT4U1oRNhaixqU+vri3lpAy6D5VsakMcAZridTDkELNh
         yPnVdDJwdaOWjvqAJHCSvvpKoBKcENC/cCU2cZufIU97h8fDsf/i7rJW0QaibGC/R46L
         tCkEkKqEcyRt5Cl5zhAQQFPYXLluzjzX7rBQxOlTaxG1+SCIGkLVvXU0YX2dcE2LQ5Vb
         8BEw==
X-Gm-Message-State: AOJu0YyMAtuaWyCkybfCkMqTI7rtASd1eqddlpRYP30N9s6McekNPFQ4
	z+T0NQzimAvGn7OPxmV3NMKKhT3BPT3PzoBpMWFYWTFziT8eHzfUzx2nr+ncNjgyFq4+x/41u4e
	7sGoSKuCGpuVlCE9eZeByCnXFmmU=
X-Google-Smtp-Source: AGHT+IEDnwEBiAnsWON58YUBYpIr+20dclfUR56nUp7H83ShCPGLA4U6di9UDmPMhEf9toxB66zGdLZK/DE5OOZEqws=
X-Received: by 2002:a05:6102:3a6b:b0:47b:be9f:aec8 with SMTP id
 bf11-20020a0561023a6b00b0047bbe9faec8mr525981vsb.14.1713901648461; Tue, 23
 Apr 2024 12:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409203411.1885121-1-jaegeuk@kernel.org> <20240409203411.1885121-2-jaegeuk@kernel.org>
 <Zh6r_yLKOnNkMedZ@google.com>
In-Reply-To: <Zh6r_yLKOnNkMedZ@google.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 23 Apr 2024 12:47:17 -0700
Message-ID: <CACOAw_zn1BX=pw4+XpiT6XGK6iHm9tMLznziOVu8j6w3gmPsKA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 2/3 v2] f2fs: clear writeback when compression failed
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 9:50=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Let's stop issuing compressed writes and clear their writeback flags.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>
>  Now, I don't see any kernel hang for 24hours.
>
>  Change log from v1:
>   - fix bugs
>
>  fs/f2fs/compress.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index d67c471ab5df..b12d3a49bfda 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1031,6 +1031,31 @@ static void set_cluster_writeback(struct compress_=
ctx *cc)
>         }
>  }
>
> +static void cancel_cluster_writeback(struct compress_ctx *cc,
> +                       struct compress_io_ctx *cic, int submitted)
> +{
> +       int i;
> +
> +       /* Wait for submitted IOs. */
> +       if (submitted > 1) {
> +               f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
> +               while (atomic_read(&cic->pending_pages) !=3D
> +                                       (cc->valid_nr_cpages - submitted =
+ 1))
> +                       f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
> +       }
> +
> +       /* Cancel writeback and stay locked. */
> +       for (i =3D 0; i < cc->cluster_size; i++) {
> +               if (i < submitted) {
> +                       inode_inc_dirty_pages(cc->inode);
> +                       lock_page(cc->rpages[i]);
> +               }
> +               clear_page_private_gcing(cc->rpages[i]);
> +               if (folio_test_writeback(page_folio(cc->rpages[i])))
> +                       end_page_writeback(cc->rpages[i]);
> +       }
> +}
> +
>  static void set_cluster_dirty(struct compress_ctx *cc)
>  {
>         int i;
> @@ -1232,7 +1257,6 @@ static int f2fs_write_compressed_pages(struct compr=
ess_ctx *cc,
>                 .page =3D NULL,
>                 .encrypted_page =3D NULL,
>                 .compressed_page =3D NULL,
> -               .submitted =3D 0,
>                 .io_type =3D io_type,
>                 .io_wbc =3D wbc,
>                 .encrypted =3D fscrypt_inode_uses_fs_layer_crypto(cc->ino=
de) ?
> @@ -1358,7 +1382,16 @@ static int f2fs_write_compressed_pages(struct comp=
ress_ctx *cc,
>                         fio.compressed_page =3D cc->cpages[i - 1];
>
>                 cc->cpages[i - 1] =3D NULL;
> +               fio.submitted =3D 0;
>                 f2fs_outplace_write_data(&dn, &fio);
> +               if (unlikely(!fio.submitted)) {
> +                       cancel_cluster_writeback(cc, cic, i);
> +
> +                       /* To call fscrypt_finalize_bounce_page */
> +                       i =3D cc->valid_nr_cpages;
> +                       *submitted =3D 0;
> +                       goto out_destroy_crypt;
> +               }
>                 (*submitted)++;
>  unlock_continue:
>                 inode_dec_dirty_pages(cc->inode);
> @@ -1392,8 +1425,11 @@ static int f2fs_write_compressed_pages(struct comp=
ress_ctx *cc,
>  out_destroy_crypt:
>         page_array_free(cc->inode, cic->rpages, cc->cluster_size);
>
> -       for (--i; i >=3D 0; i--)
> +       for (--i; i >=3D 0; i--) {
> +               if (!cc->cpages[i])
> +                       continue;
>                 fscrypt_finalize_bounce_page(&cc->cpages[i]);
> +       }
>  out_put_cic:
>         kmem_cache_free(cic_entry_slab, cic);
>  out_put_dnode:
> --
> 2.44.0.683.g7961c838ac-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Reviewed-by: Daeho Jeong <daehojeong@google.com>

Thanks,

