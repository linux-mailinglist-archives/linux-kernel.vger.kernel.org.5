Return-Path: <linux-kernel+bounces-15829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13628233F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E41F25002
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628181C6A4;
	Wed,  3 Jan 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4nT7QdY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681321C684
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so451a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 09:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704304602; x=1704909402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVlTKPYO7lkIftOZJ8uU2692obLmgBxgcDPoOrfSxVk=;
        b=t4nT7QdYxT1rYfz1flWHiYE+gDxaa2rRUjdxZ3lvYw3ptVrURwnti4Q7b+fiD2eX2n
         i2eMkEaibm4TRQZFjA+YhHgx+dZqNfSq2RX4YmzydP2mQ/aWZdxt0RlZwLWA+SE6plyN
         FNnlzwd5+btjJKzW1sR/tsEM3CYysSLcA0GceGIwuwYZ22dDiLlDal+kFitVSOvXS1I5
         xx7TDLB9p2dgJ3x1/iSyn1VDt4xfwWKjtNK5KUufy+8O3Qk64atf1mBsW8w8ISOSFCLr
         K7TkcncUyUKLbB5xTrn5cAx1rWI+n0/A09VbN7Vs4nf7zSNKlgnUppTCNE6Aq6I2pU/K
         0n1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704304602; x=1704909402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVlTKPYO7lkIftOZJ8uU2692obLmgBxgcDPoOrfSxVk=;
        b=nOxBL6yplqQAykOdKoWOfjt7JOwVP83TvB3crbSpfqdr7U5uzp3prfHLaQGf4OmH1+
         nohzfhrzInJOr3t8/nBeP2LlpPW8mAtsdfCzvb16QQ2645J/W9UcD3OacTslEt4BtAjd
         Mmz+nDJCvIeQ48O3FiPjGRns7H/8COCFU2OJ7VSSQxozksIAj4JJft0CHWwa9XHExCFr
         q6gyEhbRruL7/f3ujxZztnq8OUBJpgi48BVyl9W7zkHFPWVRPgeHL8YxZBIOsn+FqUG2
         DqNZ/yY4zIGUP5zO9Jtnp+PcT9UAj5tRj+s5kr8JOQ7SvMkJ/jT15AYBKORqQjS/yZ6Q
         YWyQ==
X-Gm-Message-State: AOJu0YxWo0sOXtu8CwEfhcny8wj9ebLSrBBg+RLm3NWt1RdYv3HY7jbw
	8p8BKz1iUoVSUJVwbtmSxpcA4UGanjCsqVucIYHtBixVoBnR
X-Google-Smtp-Source: AGHT+IEE8iuFDDGdvAHdAw2DhH14Nxhsf3iV+U/GSamanvDz1pZTOeUwxLAUfHXnj90E8HCXIn5FfA5YiYASlxq/LkE=
X-Received: by 2002:a50:c34c:0:b0:553:d734:3f5a with SMTP id
 q12-20020a50c34c000000b00553d7343f5amr223616edb.4.1704304601628; Wed, 03 Jan
 2024 09:56:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220083224.3712113-1-visitorckw@gmail.com>
In-Reply-To: <20231220083224.3712113-1-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jan 2024 09:56:29 -0800
Message-ID: <CAP-5=fXwa-GSDJX3pO-LSz-D_X7qk2Ck1vtdddtV8ixzsO+5BA@mail.gmail.com>
Subject: Re: [PATCH 0/2] min_heap: Min heap optimizations
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 12:32=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Hello,
>
> The purpose of this patch series is to enhance the existing min heap
> implementation. The optimization focuses on both the heap construction
> process and the number of comparisons made during the heapify
> operation.
>
> Kuan-Wei Chiu (2):
>   min_heap: Optimize number of calls to min_heapify()
>   min_heap: Optimize number of comparisons in min_heapify()

Thanks Kuan-Wei,

The patch series looks good to me. Given the extra conditions should
there be some updates to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib=
/test_min_heap.c
to ensure coverage?

Thanks,
Ian

>
>  include/linux/min_heap.h | 44 +++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
>
> --
> 2.25.1
>

