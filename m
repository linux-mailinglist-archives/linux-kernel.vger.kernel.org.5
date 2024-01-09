Return-Path: <linux-kernel+bounces-20444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5081A827F12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E271F245D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CAC127;
	Tue,  9 Jan 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsI0alcB"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05ABE4A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4298bd85e33so14884841cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704784132; x=1705388932; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWKZBm49HTKJsSVTqSFKBSK/qcMrSE6KA1YgsZXKd+s=;
        b=XsI0alcBIbC5KWOhXw92SV9e9mEed1N8Mr2Fqp1+NlGImqOwayPSgwrUWW879lwgYO
         YgsR6TRwLe7cauaH5JFCZeSe645xyfsYPv+9pZ07+uv5Z9CL2gdo8OPf/R9jO3Hmav7o
         KK7j1aiehcIqlWyiybp6Bf0JziCFLaaSNRbRu/BjWWPFCpSXccscUeo58gKioxnlSsXT
         lGbugmL+6m9CAOxtUff9pn0IHB2Lsl48fQfnZXY7/HJXrY5d/WNPkOVZ6YWzcnRQgpCB
         AXtI1mtUaQlGOvHAQHa/1PIyH1dlTNAWSgiADH9RpEOL15Bf0ICZnU/zLRAsqT9aaKW1
         TtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704784132; x=1705388932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWKZBm49HTKJsSVTqSFKBSK/qcMrSE6KA1YgsZXKd+s=;
        b=TdPwVQDSiK9wrrH3aRedpE8xX1IAmv52/k1l2V0etawBBxTNkj++2j3Un4HmJBOYrG
         EFaxS4/NkAipTDZWNTpP/0LtrKAXKpREtV4mPSD7HixCcZR+4LXHVNU8l7Xzko1UzhfO
         5YVTTy66NP6418pfofRaqFTOCH2heMC47rfwShKlvsb4AOxg+WutaWnbEggp0BAMPirZ
         k3w6AjSeIU46dH/b2zI6i44kJEKr7cKRnaGnQL3YUZEMizXaQW1+U5FmW77N0R2KQFfD
         sSDCJGvbhtPPFdLyeOVgpbntefnzjT+REmAnwVfazo0n2yqaEcZAstvXy8XYqjJB4qH0
         eNJg==
X-Gm-Message-State: AOJu0YzqfbN8egcWTEm51ixRIWSntVKtdPtenhHnwG5Fmsps2bAIQrl8
	uCP1IXUhstH4qTOtA62ziAbE09JPOZrdjqUAlC8=
X-Google-Smtp-Source: AGHT+IHyNz4lnf3pR9yAD3GY4+j+Tua6f4ik1QBbsJ0ck80NNcsn8VPe0EOqPlw5mtfd1rEUVcvQ8OKVe/7YPBGHXL8=
X-Received: by 2002:ac8:5a8b:0:b0:428:400c:ed0 with SMTP id
 c11-20020ac85a8b000000b00428400c0ed0mr6682061qtc.35.1704784132660; Mon, 08
 Jan 2024 23:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240107131236.625-1-qwjhust@gmail.com>
In-Reply-To: <20240107131236.625-1-qwjhust@gmail.com>
From: =?UTF-8?B?5LqT5paH5p2w?= <qwjhust@gmail.com>
Date: Tue, 9 Jan 2024 15:08:41 +0800
Message-ID: <CAGFpFsQsRm0s3OG1zENHSgPB+TcbGG6NKXKhugCYnzX=shf00A@mail.gmail.com>
Subject: Re: [PATCH] f2fs: fix NULL pointer dereference in f2fs_submit_page_write()
To: jaegeuk@kernel.org, chao@kernel.org, guoweichao@oppo.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been merged into the new patch.

[PATCH v2] f2fs: fix max open zone constraints
https://lore.kernel.org/linux-f2fs-devel/20240109035804.642-1-qwjhust@gmail=
com/


Wenjie <qwjhust@gmail.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=887=E6=97=A5=E5=91=
=A8=E6=97=A5 21:12=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Wenjie Qi <qwjhust@gmail.com>
>
> BUG: kernel NULL pointer dereference, address: 0000000000000014
> RIP: 0010:f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> Call Trace:
> <TASK>
> ? show_regs+0x6e/0x80
> ? __die+0x29/0x70
> ? page_fault_oops+0x154/0x4a0
> ? prb_read_valid+0x20/0x30
> ? __irq_work_queue_local+0x39/0xd0
> ? irq_work_queue+0x36/0x70
> ? do_user_addr_fault+0x314/0x6c0
> ? exc_page_fault+0x7d/0x190
> ? asm_exc_page_fault+0x2b/0x30
> ? f2fs_submit_page_write+0x6cf/0x780 [f2fs]
> ? f2fs_submit_page_write+0x736/0x780 [f2fs]
> do_write_page+0x50/0x170 [f2fs]
> f2fs_outplace_write_data+0x61/0xb0 [f2fs]
> f2fs_do_write_data_page+0x3f8/0x660 [f2fs]
> f2fs_write_single_data_page+0x5bb/0x7a0 [f2fs]
> f2fs_write_cache_pages+0x3da/0xbe0 [f2fs]
> ...
>
> It is possible that other threads have added this fio to io->bio
> and submitted the io->bio before entering f2fs_submit_page_write().
> At this point io->bio =3D NULL.
> If is_end_zone_blkaddr(sbi, fio->new_blkaddr) of this fio is true,
> then an NULL pointer dereference error occurs at bio_get(io->bio).
> In this case, the code to determine the zone end can simply be skipped.
>
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 1896928cae77..d08e92bb2621 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1100,7 +1100,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fi=
o)
>                 goto next;
>  out:
>  #ifdef CONFIG_BLK_DEV_ZONED
> -       if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
> +       if (io->bio && f2fs_sb_has_blkzoned(sbi) && btype < META &&
>                         is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
>                 spin_lock_bh(&sbi->available_active_zones_lock);
>                 if (sbi->available_active_zones > 0) {
> --
> 2.34.1
>

