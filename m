Return-Path: <linux-kernel+bounces-12749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A505B81F997
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 16:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D9B23507
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F47F4F8;
	Thu, 28 Dec 2023 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8iJNXoZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CFF4E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7aed09adso3555557e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 07:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703776785; x=1704381585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ha+pAOWsoDIh9rt3FhMOiZJHiegkUy/cwMrNu3tQCw=;
        b=W8iJNXoZsT5Zl76aQtyUJ/vpVAZBaTmp/LrV+HOIYpAxsxyn1S4mlig4MqykBoDesl
         zUhSh7JGPING5uUohfG/fsuZAu1zZvgtIk1r2hzihvEsARKc4xYr9ISJdMBujuBKSiun
         zpaegR2Mpff7IIw3vhNMs/xFUTAt8fiQ258oC8JAvJdZrTxBzKk/p5HdJdmNUqmJedV+
         UnE9gmbK6Lzle3GXryE/MIOFPRsscam9FTyRGB/jT7EGhO/hlDqOq/cWHpQHdDDTcBAf
         RKzNlbxp/V7lVcTlPPIJsQW0oMFpnfRcR5y4yYzabd5UpToZCn2NHarbokhwoNkZg3eM
         rJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703776785; x=1704381585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ha+pAOWsoDIh9rt3FhMOiZJHiegkUy/cwMrNu3tQCw=;
        b=NYMu7/8tTInafRhc1hNEyAGyCbdKUiiPtEFUwvZ35/kOUJcd7li9Elu/nHvKAd40Cz
         DzTyr4Q6A/no2KN/mDOJg3k5jbR6RZZTmtGAZkYg6QHwaKDeiJOgL3hr5TrV170QDnDd
         iOMSLpcNt6qkCbnFDcG+kuuDPYrB01GXZKBQklOwzo2lx+rqJJUWElNKbwsGnfllOyqP
         +BmmXqzkPe+O5JsSd8ZLDyV8kZch0Trth9zk92pLjtPgKN2fq2IsflvvXc/VKmbKLPyp
         HERZytjgL1qk3j5vZZ+w235iJTOnrOpwwtneho7zSPtPKZziR3feZvKA0n/dawmBCJ/a
         qF0Q==
X-Gm-Message-State: AOJu0Yyb9RjuTb1IAaDVshxg3fMe/snECvdkL6w5xVOBQk5rQupb4lSg
	dcN0enzImzk2kCdV6RJsxxCZw3NUvaL9RW4cPnTnVS0M7d6K
X-Google-Smtp-Source: AGHT+IFNY57uXAYiuNoisdfoK3o+0pMDBpwcVA50bsXFgyoyptZU2V5fBdcVs9EEPUiT5eyE1TLUAMSGFGCrTXBHPEQ=
X-Received: by 2002:a05:6512:1329:b0:50e:8ccc:6df5 with SMTP id
 x41-20020a056512132900b0050e8ccc6df5mr554370lfu.27.1703776784726; Thu, 28 Dec
 2023 07:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v5-0-9382162bbf05@bytedance.com> <20231213-zswap-dstmem-v5-5-9382162bbf05@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v5-5-9382162bbf05@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 28 Dec 2023 07:19:08 -0800
Message-ID: <CAJD7tkber7UL7F-ZghNvVig=7zoAB9cPMjaQpWm8c6Y9OrmBFQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Barry Song <21cnbao@gmail.com>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chris Li <chriscli@google.com>, Seth Jennings <sjenning@redhat.com>, Chris Li <chrisl@kernel.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> First of all, we need to rename acomp_ctx->dstmem field to buffer,
> since we are now using for purposes other than compression.
>
> Then we change per-cpu mutex and buffer to per-acomp_ctx, since
> them belong to the acomp_ctx and are necessary parts when used
> in the compress/decompress contexts.
>
> So we can remove the old per-cpu mutex and dstmem.
>
> Acked-by: Chris Li <chrisl@kernel.org> (Google)
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Instead of hardcoding PAGE_SIZE * 2 multiple times, can we define a
constant for this and document the need for the buffer size there?
Even better if that constant is based on WORST_COMPR_FACTOR and shared
between zswap and zram -- but this can be a follow up change.

