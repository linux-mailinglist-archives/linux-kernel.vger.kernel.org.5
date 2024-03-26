Return-Path: <linux-kernel+bounces-118264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88A88B705
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043FD1F3F353
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8AC2D7A8;
	Tue, 26 Mar 2024 01:44:07 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54E20B3E;
	Tue, 26 Mar 2024 01:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711417447; cv=none; b=BOOZ3Dv3+rwzZZ3CdKFSaAmMJesMC3Bnu9sJW64lBZdV4ezZD7arh/ljeqX3v/9rWZpRrrpAcLFr46uxCSftvvo5o+3ucsvaREi/ZdsJ6gOPUfg3Kahcegv/t7U99jA26WyjiUZYnvC5Y23HctJA7qfY7X/lALtODT9DRJIsNsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711417447; c=relaxed/simple;
	bh=0uKuPuHOu15SAOYOE+MCS7cUDeqBNLoUYczrHEoMxXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mff4amvFgzlAD3qGBqebtW7IzaCov+JQ6yeS2xLCUxNv+7ERDJWkkbf2pL5ly5XvWtRMMHnw3Ll6kutCmervMNko8r8lKUFjN3Y+95ztwPBxu6u+QzVmIrENHcgg5zxBY+4197rai60wmcjFb4rb97lpKmw46ctD64jQ9AnJp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V3Xdk0SPxz4f3jdT;
	Tue, 26 Mar 2024 09:43:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3B1331A0BF6;
	Tue, 26 Mar 2024 09:44:00 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgB3lA1dKAJmPQpfIA--.9979S2;
	Tue, 26 Mar 2024 09:43:58 +0800 (CST)
Message-ID: <c812aed1-8659-4cdf-bcee-89d100ded9d4@huaweicloud.com>
Date: Tue, 26 Mar 2024 09:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] bpf,riscv: Implement bpf_addr_space_cast
 instruction
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Puranjay Mohan <puranjay12@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
 Xi Wang <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Manu Bretelle <chantra@meta.com>,
 Mykola Lysenko <mykolal@meta.com>, Nikolay Yurin <yurinnick@meta.com>
References: <20240325155434.65589-1-puranjay12@gmail.com>
 <20240325155434.65589-3-puranjay12@gmail.com>
 <20240325-nineteen-unvaried-cb5cb5fd3a73@spud>
 <CANk7y0gWtwN7EJ24aoY9-RB9629d5Ks-9fMc3wnAAjjERcZhFw@mail.gmail.com>
 <20240325-perpetual-liking-25f26e485b65@spud>
 <CANk7y0jtURUC6PWx5nSDigMpScUT+p3qd=hTtqJkCqAN+Nq32A@mail.gmail.com>
 <878r263vg3.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <878r263vg3.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgB3lA1dKAJmPQpfIA--.9979S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8AryUAw4UXw48AF1DWrg_yoW8GryUpF
	W5KFyFyws5Ca9rJ395Ka18Jr4rCrs5ta4UA3WkJrWUZr1agF1jgryIkFZ0ka43ZrZ7GFya
	yFnIvw1UG3Z8uaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1rMa5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/26 4:31, Björn Töpel wrote:
> Puranjay Mohan <puranjay12@gmail.com> writes:
> 
>> Is there a separate CI for RISCV related stuff? is it public?
>>
>> I would be interested in adding RISC-V support in
>> https://github.com/kernel-patches/bpf
>> Is someone already working on this?
> 
> +Cc Manu/Mykola/Nico who's doing all of the awesome BPF CI work at Meta,
> and can keep me honest. ;-)
> 
> I did some early hacks for to add RISC-V support for the BPF CI, but
> haven't had time to work on it recently. :-(
> 
>    [1] https://github.com/libbpf/ci/pull/87
>    [2] https://github.com/kernel-patches/vmtest/pull/194
> 
> I've been talking recently to Lehui about it as well.
> 
> Two major things are missing:
> 
> 1. Cross-compilation support (expand on [1])
> 2. Align the rootfs with what the other arch are using, to run the tests
>     on Qemu/TCG (and proper HW at some point!). RISC-V does not have
>     Debian Stable support, and would probably need Ubuntu or Debian Sid
>     snapshop. Manu outlines some issues here:
>     https://github.com/libbpf/ci/pull/83

yeah, the current issue below is fixed and I think we can move forward.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=443574b033876c85a35de4c65c14f7fe092222b2

> 
> Having to manually run BPF tests ("non-official RISC-V BPF CI") is a
> mess!
> 
> 
> Björn


