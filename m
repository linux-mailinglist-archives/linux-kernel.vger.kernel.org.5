Return-Path: <linux-kernel+bounces-95615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48949875033
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003921F228AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7F12D20A;
	Thu,  7 Mar 2024 13:37:49 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F2412BEB6;
	Thu,  7 Mar 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818669; cv=none; b=kNB4KTold+tI0TY7uvOW0gGixYds+bGpC18cE5I1lv6EMHZzoelYwZ3vDC9KV10NChf8Mzn8voz8zXelpz+2F9nCu/vqgh8+Xb5ZnzNxo9bTj5hlguievBae18w2Fu/MywmydH28prAo55CNvN7OJhCz3Wh4KJwkfZGONQLcQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818669; c=relaxed/simple;
	bh=OVr0pI2pabYmwUQqqDKQMzljSj1CvAAHW3fslRAS1Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=JpkOn/bXZfVvcv3DVQ2+dgFRoSnXuQ3ba1gNIh3Psctx2HTyj6KwkF7SpFoDl3tBV/zGu3XnE2fcfdsQ3o9KSnt34o6UK5hr8GEPnhdm1Wq3WcMoof1+rFtH58o6Rl2zSf6ND5qYM8uUi1qncTlYI/YPfAoYOK1S1O7P0Qfj6/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Tr9MK5mltz1vvq5;
	Thu,  7 Mar 2024 21:37:01 +0800 (CST)
Received: from kwepemd100009.china.huawei.com (unknown [7.221.188.135])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B29B1A016C;
	Thu,  7 Mar 2024 21:37:42 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemd100009.china.huawei.com (7.221.188.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 7 Mar 2024 21:37:41 +0800
Message-ID: <6beb3f5a-5d72-4443-81bf-3c809b86f7e0@huawei.com>
Date: Thu, 7 Mar 2024 21:37:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] riscv64/cfi,bpf: Support kCFI + BPF on
 riscv64
Content-Language: en-US
To: Puranjay Mohan <puranjay12@gmail.com>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240303170207.82201-1-puranjay12@gmail.com>
 <20240303170207.82201-2-puranjay12@gmail.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Luke Nelson
	<luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sami Tolvanen
	<samitolvanen@google.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
	<keescook@chromium.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20240303170207.82201-2-puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100009.china.huawei.com (7.221.188.135)


On 2024/3/4 1:02, Puranjay Mohan wrote:
> The riscv BPF JIT doesn't emit proper kCFI prologues for BPF programs

[SNIP]

>   
> -void bpf_jit_build_prologue(struct rv_jit_context *ctx)
> +void bpf_jit_build_prologue(struct rv_jit_context *ctx, bool is_subprog)

Not tracked in time. Some nits, although it has been merged. We don't 
need to add new parameters here since we can fetch prog in ctx. Others, 
it looks great.

>   {
>   	int i, stack_adjust = 0, store_offset, bpf_stack_adjust;
>   
> @@ -1740,6 +1749,9 @@ void bpf_jit_build_prologue(struct rv_jit_context *ctx)
>   
>   	store_offset = stack_adjust - 8;


