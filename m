Return-Path: <linux-kernel+bounces-20151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD810827AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2E21F23CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246022EB14;
	Mon,  8 Jan 2024 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h/0fEkRF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71458468
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27cd5850d6so245536966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 14:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704753390; x=1705358190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kp/QQnU6OqH2UQyKTVh3F3K1n7okkdJ17va/Cb7sw4E=;
        b=h/0fEkRFtZYgTNpVIODTOOb5MyargWi+bqSh9M9HCZilmQPdJw970RAhkm2wY8NEcd
         97g+qyzj6Kvp57Yw/1conm8/vqodbJmtixzVuG5zo4JKyVgtUZOcpA69XSbDpkI3VjQG
         A37fuAfPiSDyNC6huUb1xqACbHlZBVETuQEJ+r+iGmSLs9YUwKZS6rmetQA5Ae6jOISJ
         zYSG6bllS7pgFuApB+GpPiEpH0svdIQpnMWlvnzVLZ2U9vIPWoKqV0NkhFJNvl1TxMZs
         AzBkgAig1Z8dO6nCMEtTHAYvBKnVdZAXtUSSZlNFV/zl+7Vfpu2etwCEuAemcC5lXYPb
         NULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704753390; x=1705358190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kp/QQnU6OqH2UQyKTVh3F3K1n7okkdJ17va/Cb7sw4E=;
        b=R++NM5LHjShNExroiM/+KIK0P6WZdReEsYIl6jGj+sp4McNSg2rrP+IR0r0aAEvyns
         yZtU2qxmvKN7IHLnqmVK/cX/VVEhMqvn0Fdp2hEUNYIU05IHg29o5yuxM2fQWdTWw10e
         kX+FsAf49/UFw+Ufw+lIwIJcBapDLKsu/uSzOZGaowlZcgVz+W4A6EcIZ1VZk/Uey17O
         73dc/nWnvyqPFO21DIzwb2bXTUFhzrJVpxtOgHIqwwEg5TjxQCXQ5L4G1sqVZZnuPUEg
         zZ0kodR3idT6l7wYhlFcqi1QPJL4vVTqflSSIJKvtBlXB4O+LVGngQ081PL23aMoJv6r
         2DGQ==
X-Gm-Message-State: AOJu0YxXHa3knWc5BDkcbDA1xO9im68qPbqaGCYzGEamVMKj8GNF/IAj
	7PnlM7HFBFLf1l2Elqc4nMpfUHVPPbHSGEFNECEBjbyRqfF5
X-Google-Smtp-Source: AGHT+IH+01LiTm211gHpYVG2JZGM4SZKJyCiWiRXlviOXt1CIGYMdgBB979VmVNEKNlDdlkYtoP8P4P7IWI7ndK8mo0=
X-Received: by 2002:a17:906:6d17:b0:a2b:1efe:fbf1 with SMTP id
 m23-20020a1709066d1700b00a2b1efefbf1mr59532ejr.89.1704753390154; Mon, 08 Jan
 2024 14:36:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095006.608744-1-21cnbao@gmail.com> <20240103095006.608744-2-21cnbao@gmail.com>
In-Reply-To: <20240103095006.608744-2-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 8 Jan 2024 14:35:51 -0800
Message-ID: <CAJD7tkbB2Tni-xo5orxw-uDHzAcKocc7WeV2536LLbE=PC8=QA@mail.gmail.com>
Subject: Re: [PATCH 1/3] crypto: introduce acomp_is_async to expose if a acomp
 has a scomp backend
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	akpm@linux-foundation.org, ddstreet@ieee.org, sjenning@redhat.com, 
	vitaly.wool@konsulko.com, linux-crypto@vger.kernel.org, chriscli@google.com, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, zhouchengming@bytedance.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 1:50=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Almost all CPU-based compressors/decompressors are actually synchronous
> though they support acomp APIs. While some hardware has hardware-based
> accelerators to offload CPU's work such as hisilicon and intel/qat/,
> their drivers are working in async mode.
> Letting acomp's users know exactly if the acomp is really async will
> help users know if the compression and decompression procedure can
> sleep.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  crypto/acompress.c         | 8 ++++++++
>  include/crypto/acompress.h | 9 +++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/crypto/acompress.c b/crypto/acompress.c
> index 1c682810a484..99118e879a4a 100644
> --- a/crypto/acompress.c
> +++ b/crypto/acompress.c
> @@ -152,6 +152,14 @@ struct crypto_acomp *crypto_alloc_acomp_node(const c=
har *alg_name, u32 type,
>  }
>  EXPORT_SYMBOL_GPL(crypto_alloc_acomp_node);
>
> +bool acomp_is_async(struct crypto_acomp *acomp)

Is synchronous semantically the same as sleepable? IIUC synchronous
code may still sleep, at least generally. The purpose of this change
is to know whether we will sleep or not in the zswap code, so I
suggest the code should be explicit about sleep-ability instead (e.g.
acomp_is_sleepable or acomp_may_sleep).

