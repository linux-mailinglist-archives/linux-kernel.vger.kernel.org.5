Return-Path: <linux-kernel+bounces-11981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895DD81EE77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E0281709
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74444397;
	Wed, 27 Dec 2023 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izwMHxgy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A444367;
	Wed, 27 Dec 2023 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb732e7d78so3944796b6e.0;
        Wed, 27 Dec 2023 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703675171; x=1704279971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EevuVU7B1VpO5whOxzp7/7YeGnwHG8aglB1XAt3LupU=;
        b=izwMHxgyAHcRsrrwS4nmGZJV+BWlE6t1c99jaEhhuIko5r/vNc4R4p2wCyYkkY42O0
         eo1pRigBKyZ/BRkzVI70IBGmYu+r4m9VIpEgYB76hJF2OQv8+iQgZRkv/LHBJ0wSzmCY
         wAS5fX7t4I8gRoCKu1IRPpxXZhAQvLiWifnxXMnFkoTJPFRX7DjwwVel67MRf3eRDiZ+
         zhnzRfW7Az1du9LWOuzLp+xHtyoRHKEpWL4MGPOxcBp85Bh7R6Fpuiov/R1gaWb3PJV4
         rMCmOLCmafD9kALIiYMETEoWrFLzAFDnrn6D73N3v1UMma10Or117UATgZX10sdQcRGA
         vbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703675171; x=1704279971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EevuVU7B1VpO5whOxzp7/7YeGnwHG8aglB1XAt3LupU=;
        b=e7dMTTKNK0fn+hY/j5y8SUmSBYtE8Fit4h5e1IKdT7ML/iNYGbdcLOn0xdKW+2Xir1
         d5CJt6F7Id6wNjt6yrnuf2CzLflZ+rjaQYb1FsRJ25tSINupDL2kWFYnkTwMQg+DJVJ3
         AomRK8vdYMFhjITTfpjBcsAVCcZsHuJucBkXf3YTgoddZz/I9wxk3WmZhF7nEuAjgKIu
         wwqvS84FH25coTAs2OyLvXZqed9bN+aKt0pUaK0ztCsKH5bxLnl8a1lIDFWtQEa3IDM1
         RzGOU2ds+StgfnKFvDdX3M9J4BgDD/wLJtiZlCuNzQxrNvv3aDzaEdT/o3IXLODZ2GdI
         IDgw==
X-Gm-Message-State: AOJu0YwCJBv/i5kEZEmWrFMskrC6WWcLu5buWAseYwjRzJxXF2R/hjPV
	GXH4dwyE56PFqD7eIXJiKIFjnk0kyClGhKQKjoE=
X-Google-Smtp-Source: AGHT+IE7c6RgoZ0Rzso0lnnv2BvbhdfJLe/NdPlCqK22iQiH4myB+Nhp1ElUFDpaxlfq6LyBoERNAR4yV0lCKmpIwgA=
X-Received: by 2002:a05:6808:3c93:b0:3bb:c935:3e0e with SMTP id
 gs19-20020a0568083c9300b003bbc9353e0emr416570oib.73.1703675171409; Wed, 27
 Dec 2023 03:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com> <20231227093523.2735484-1-chengming.zhou@linux.dev>
In-Reply-To: <20231227093523.2735484-1-chengming.zhou@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Dec 2023 19:05:57 +0800
Message-ID: <CAGsJ_4yDS+RMGf1DbCTfDzRTt83t7nugwNGiNWNO8tsZ75Th5Q@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: scompress - fix req->dst buffer overflow
To: chengming.zhou@linux.dev
Cc: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com, 
	zhouchengming@bytedance.com, 
	syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 5:35=E2=80=AFPM <chengming.zhou@linux.dev> wrote:
>
> From: Chengming Zhou <zhouchengming@bytedance.com>
>
> The req->dst buffer size should be checked before copying from the
> scomp_scratch->dst to avoid req->dst buffer overflow problem.
>
> Fixes: 1ab53a77b772 ("crypto: acomp - add driver-side scomp interface")
> Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000000b05cd060d6b5511@google.c=
om/
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - change error code to ENOSPC.

Reviewed-by: Barry Song <v-songbaohua@oppo.com>


> ---
>  crypto/scompress.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/crypto/scompress.c b/crypto/scompress.c
> index 442a82c9de7d..b108a30a7600 100644
> --- a/crypto/scompress.c
> +++ b/crypto/scompress.c
> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>         struct crypto_scomp *scomp =3D *tfm_ctx;
>         void **ctx =3D acomp_request_ctx(req);
>         struct scomp_scratch *scratch;
> +       unsigned int dlen;
>         int ret;
>
>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
>                 req->dlen =3D SCOMP_SCRATCH_SIZE;
>
> +       dlen =3D req->dlen;
> +
>         scratch =3D raw_cpu_ptr(&scomp_scratch);
>         spin_lock(&scratch->lock);
>
> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *=
req, int dir)
>                                 ret =3D -ENOMEM;
>                                 goto out;
>                         }
> +               } else if (req->dlen > dlen) {
> +                       ret =3D -ENOSPC;
> +                       goto out;
>                 }
>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->=
dlen,
>                                          1);
> --
> 2.40.1
>

