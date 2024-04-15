Return-Path: <linux-kernel+bounces-145895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC08A5C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC593283609
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CCB156F32;
	Mon, 15 Apr 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aA7yF7sY"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6FD15698B;
	Mon, 15 Apr 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214392; cv=none; b=rHBKUvBSXyz/R9E6Dx7OvJqw6j76P7XZKvqEx9rIL9d1pOSTpevPP9gl4YTakcn5LOF1kdSgB9ZRhyqmaXLBqSP80VIBfqLVWghNOlx8vetYqxuG8O93Jgg3QXfnWs+5xmrCY2QY/ZV6qM23Gg7H4FaLOsxi+q96XewRH2XkG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214392; c=relaxed/simple;
	bh=eQ6mIpO8IvV61oOpyU0EGmh73badk0+E9zTL/roh2bM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=kC+IgTnOgOQtieQdyITg2c9Cy9SiqMO/2wzdR1w/R3rz4X7NXcHT/JGccgJ/xSl9t7KWeVLGnB3JpWhWD+n4LNYCGATia/mJYpLnD/GigzNjp/q6nLCgVa9Y1TB+a5KkxxHVuGwDx6XR/crJuLJkDSDj+ceKNepFSzpdsktAXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aA7yF7sY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-43492c1a8a4so12392631cf.1;
        Mon, 15 Apr 2024 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713214389; x=1713819189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/z28nuurN3VVSoKVTAy5DTa5mcArLrVSxytPRVlZdI=;
        b=aA7yF7sYZrI60Ind1bejiAxv0X8ka0i/l6FDlsCLeF1NgjXg9X6Em6Mk+rcLSTLruS
         tp7zJh6/GbBzGGvkszZsQMUstuCQT8bt+VitMcwBEavRN5fYa4m0Au/J4/ripv8nsIcO
         ZlkF5dPIvHpufd+UXFPTtvvcWQZ2ytyRv67SPrwEQrbz8rGOzSODvjTGTstMvA21SubF
         vP2MGaPJXORr8phTbFFQl2NO0lYufyz62aHUfUNo7C5OK5M0os+tXADZb4lqrD1dqgM4
         4ngKGNToKVHuIZJIMaPa+P/DCMNAsMm1PrLeHBXBQGXpTVyU6cu5g6D9Im3wmbTdr+I/
         3Rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214389; x=1713819189;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n/z28nuurN3VVSoKVTAy5DTa5mcArLrVSxytPRVlZdI=;
        b=KszICfSntTlnwEIy6Efnil0kzVe6RwJ4D3LC0xFeSa6w78CDwMOZ4Hwa/t6ny3QPwn
         WJklvdWAiw5MRgEQfE4BBLTlOLB9dzFmxYBPn+7BPoK7o+/D3Os3/c3JRV+sZVQnAyFP
         tmZi2NGDuY53wf7NaQAdHZnNKCUcu1drjlmAgVbc1r0E4FoI0G3l7EULUEsp6WXyH5KA
         7oi2oKk5U0xGDH7OzoKfeRroXZnEugU6CZFmea+gO3THbrxz3MchpCrTaGH9QkOKljoB
         QZRTOGKpbKDkfhj2+qdQo1cTNVM6fgonKxcRDjRCa2wXKNqOnrx0t3x35WUkXx3trbnb
         zfmg==
X-Forwarded-Encrypted: i=1; AJvYcCWyefqRVAytYyYcxj8rQjpoPBOZRIsPjKNqpsDDrrhPEzSM3ydc6W+8TRqVBg6zWYCGK18j/aJmbEBvf1bCJHGAQ4BSQ9EZ
X-Gm-Message-State: AOJu0YzprdF11mjy2QelCHbkfrDsrk7VRfDlalHTs7qQymYMH+ift8Ce
	qQjuazsLYyiXeEe4zSQeaOIO1CIU/n5Lk3jh+fdGhZQejBAlBKK3
X-Google-Smtp-Source: AGHT+IFsze5aFlZkhehbgmAWJ8ALgQBX4UyFCbmxom+r/utiBb0wu2wVlA3F1I+hbM2n4bO72W+hrQ==
X-Received: by 2002:ac8:5dc7:0:b0:436:7e8d:8b5a with SMTP id e7-20020ac85dc7000000b004367e8d8b5amr14192038qtx.34.1713214389527;
        Mon, 15 Apr 2024 13:53:09 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id i6-20020ac84f46000000b004367bb1a200sm5685908qtw.70.2024.04.15.13.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:53:09 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:53:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: shiming.cheng@mediatek.com, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 matthias.bgg@gmail.com, 
 steffen.klassert@secunet.com
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 shiming.cheng@mediatek.com, 
 Lena Wang <lena.wang@mediatek.com>
Message-ID: <661d93b4e3ec3_3010129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240415150103.23316-1-shiming.cheng@mediatek.com>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

shiming.cheng@ wrote:
> From: Shiming Cheng <shiming.cheng@mediatek.com>
> 
> A GRO packet without fraglist is crashed and backtrace is as below:
>  [ 1100.812205][    C3] CPU: 3 PID: 0 Comm: swapper/3 Tainted:
> G        W  OE      6.6.17-android15-0-g380371ea9bf1 #1
>  [ 1100.812317][    C3]  __udp_gso_segment+0x298/0x4d4
>  [ 1100.812335][    C3]  __skb_gso_segment+0xc4/0x120
>  [ 1100.812339][    C3]  udp_rcv_segment+0x50/0x134
>  [ 1100.812344][    C3]  udp_queue_rcv_skb+0x74/0x114
>  [ 1100.812348][    C3]  udp_unicast_rcv_skb+0x94/0xac
>  [ 1100.812358][    C3]  udp_rcv+0x20/0x30
> 
> The reason that the packet loses its fraglist is that in ingress bpf
> it makes a test pull with to make sure it can read packet headers
> via direct packet access: In bpf_progs/offload.c
> try_make_writable -> bpf_skb_pull_data -> pskb_may_pull ->
> __pskb_pull_tail  This operation pull the data in fraglist into linear
> and set the fraglist to null.

What is the right behavior from BPF with regard to SKB_GSO_FRAGLIST
skbs?

Some, like SCTP, cannot be linearized ever, as the do not have a
single gso_size.

Should this BPF operation just fail?

> 
> BPF needs to modify a proper length to do pull data. However kernel
> should also improve the flow to avoid crash from a bpf function call.
> As there is no split flow and app may not decode the merged UDP packet,
> we should drop the packet without fraglist in skb_segment_list here.
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  net/core/skbuff.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index b99127712e67..f68f2679b086 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4504,6 +4504,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>  	if (err)
>  		goto err_linearize;
>  
> +	if (!list_skb)
> +		goto err_linearize;
> +
>  	skb_shinfo(skb)->frag_list = NULL;

In absense of plugging the issue in BPF, dropping here is the best
we can do indeed, I think.


