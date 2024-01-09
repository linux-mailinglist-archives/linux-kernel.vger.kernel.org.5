Return-Path: <linux-kernel+bounces-20439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BB4827EFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF5284193
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A099442;
	Tue,  9 Jan 2024 07:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="It+HKYJt"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74B79C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso2601949e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704783759; x=1705388559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CIUb3fcPdkO1d5slw3lM6PxUfdrzjr/kVi5On1PQKpo=;
        b=It+HKYJtsB9FazHgWThY/bgCwzHrt6+l4zrnGIup8b3r1E6teF3qkT9uvlHNd29aCX
         PhvVJGCRx5hISQNXDVcPAfUAde4v9gyTGpAI7GOiVqZIk/5fzw6RcMBBxBTrKMOpgY24
         wLNctoMkOJbfbLIJFWoVCgsS476lFgLqF/XG0/MhGVzKgN5lY9aajZ1ygmEnXLvMUyRu
         gc4MUO0t0PyYyphgD5L2oHG+6hMBp+BUsqwPc9R8VvTCBSAV6vHfLWaX3PIaBw0xWaCo
         fRoCj/TVt87tmzrqWWdVkNwbPf8BHAWDjk4L7DzWLNQ5Ok48ObSrb9l4X6AGmAs2Z/jJ
         2zfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704783759; x=1705388559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CIUb3fcPdkO1d5slw3lM6PxUfdrzjr/kVi5On1PQKpo=;
        b=dNehRuke68AsQFKNb/3+HUFFNewoPf2klddt6l0tLAoMbOWTXOIKGkBsbV4+gsSfq2
         w2WT9WYpRghghoPN4/Zf3Qfxh8cuWSC9TWPB5L5IJAVEA+05CxZQm9G+z00WTEVIZKJ0
         hlNKhiDGayMu1rLgG3H9h8h2PzmtDTzwM88pQ9Y5K/2EbEzAEGSobqls8ZbTUttIhTJf
         HytPpp3s04lNXptB+yNcPzcfATSajZ3RMTR03Vc5ACZ3nhPA6FmrBC0C4EUgin5ZjF5X
         SwAluplVPZkpwkcwzWh0a8AHkGC1yShp0NMrqA6PsNMbeV5VXi3oPqH5p20IiOELrZwL
         Z43w==
X-Gm-Message-State: AOJu0Yw145xZdkGYW+gIw4Rn/3Mjx5dKC/WOfmwb3FBS/6BdNnSqdeoZ
	c0uQCVlf/9MBgbZ3rTmAR1Zer7+b3Du2lA6epgqBjt0n4tUYpQ==
X-Google-Smtp-Source: AGHT+IEgMo2mUb6Aj/7j7xOXqjUltJu9TEhDb21ULuFUtFc1SGjj28Nb5MGitUzJ0zi1A/h5DMeW67Gkll+DYgkAFYo=
X-Received: by 2002:ac2:52b4:0:b0:50e:6a31:130c with SMTP id
 r20-20020ac252b4000000b0050e6a31130cmr867975lfm.59.1704783759048; Mon, 08 Jan
 2024 23:02:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220080147.740134-1-ilias.apalodimas@linaro.org> <20240102153547.58b23d35@kernel.org>
In-Reply-To: <20240102153547.58b23d35@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 9 Jan 2024 09:02:02 +0200
Message-ID: <CAC_iWj+VM1vCDygvXkd6snuSO64iQCm48oahYa4wQQeM3QXiFg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] page_pool: Rename frag_users to pagecnt_bias
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linyunsheng@huawei.com, 
	Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

On Wed, 3 Jan 2024 at 01:35, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 20 Dec 2023 10:01:46 +0200 Ilias Apalodimas wrote:
> > -     long frag_users;
> > +     long pagecnt_bias;
>
> IDK :(
>
> pagecnt to mean suggests this is related to page refcount,
> not page pool specific refcount.
>
> More importantly bias is the large number by which we increment.
> This counter counts how many of the bias references we actually
> consumed. So how about bias_consumed? bias_used? bias_issued?
> frags_alloced?

I had similar concerns, that's why v1 used 'frag_cnt'.
I am fine with either frags_alloced or frag_cnt

Thanks
/Ilias

