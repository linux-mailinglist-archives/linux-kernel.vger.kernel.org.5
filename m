Return-Path: <linux-kernel+bounces-131615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85403898A23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A636282775
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0484129E8C;
	Thu,  4 Apr 2024 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="rWyvnw6o"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DA1CD03;
	Thu,  4 Apr 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240976; cv=none; b=cz6tAw+8CIz1dEDlUxNxr4e80DAQtAPvgc2zR3vi3Xt3UGOBWBy6idG/UIOgxXpkSi7gzWZ/4qgBAzxdwvpDoI6BY+MSCmvhkmv+7CwTj2Fdk0dyM6b3oBtp58lIYgpr6MBYGpFqCCcWh49eBJ+vyRzQWDAwASnAoxxRLpnV1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240976; c=relaxed/simple;
	bh=gSn2QxVUMSt6DtUuen8wT0y+Bz6MyT//GDU+6tlw5Jw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J9I1LRVzxgEPeAOSdwfVlAv0bSHoya5bgtWRHn0LlOwiilj5pQqXiYjFgYxDru2wg7R4X6gSEA8XOWXbmzkBsyPgPq1mA4aUtFSghMz1AHweGC2PJjod8CU+tGGF0WQkL8ewxWjO0EFSrEiUPu36eDgsVLv1UXC7Lx0cT/JwjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=rWyvnw6o; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7D3JU+W2ZThhxENkFnOKanLxJxN9HSyjIsx2EIsO4IA=; b=rWyvnw6ozyjMfjRrqxeJvcmS+9
	SJtdQQO9qriT2svBzvuzSz+U9GhbieFs2BBn1coYpVmyDwOLy5z89qy/RYqoAKUtQVKQLnZy4AaS5
	fUWolnL61rL3FbILCxSBglw5Vi560+EArKbSNMYTj9bzx7wrXFtm5pzEr9PAVuF5UkBewq3BwGGDJ
	6UnGvZ04OsfROjXYcB3q/X8rbC+oGNtMajbwWQo04iZmwyWi4j9Ai+JZiHbxh/rNDVvn36V5XIvmy
	wgyeldplqNbIUcxDE0Z6z97MR1Otq+fp340zNbv/qyeEDjNPDeycCZ2FWsyd/RE6GCjdHO8/HXT5H
	tQeq4enw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsO4y-00023V-E3; Thu, 04 Apr 2024 16:28:36 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rsO4w-0006EC-SC; Thu, 04 Apr 2024 16:28:34 +0200
Subject: Re: [PATCH] bpf: x86: avoid link error with CONFIG_SMP=n
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Menglong Dong <imagedong@tencent.com>,
 Leon Hwang <hffilwlqm@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240404123346.2661488-1-arnd@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <22b3dcfd-458d-dde3-7025-10611b3c6ef3@iogearbox.net>
Date: Thu, 4 Apr 2024 16:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404123346.2661488-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

On 4/4/24 2:33 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On UP systems, this_cpu_off is not defined, so the new percpu code in bpf
> fails to link:
> 
> x86_64-linux-ld: vmlinux.o: in function `do_jit':
> bpf_jit_comp.c:(.text+0xbab14): undefined reference to `this_cpu_off'
> 
> Use offset zero on UP builds instead.
> 
> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I assume this is not the correct fix, or at least not the best one, so
> please treat this as a bug report. It does address the link failure for
> me, so I applied this to my randconfig build tree.
> ---
>   arch/x86/net/bpf_jit_comp.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d6ebb9136f3c..8b8eebb89a9b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1383,7 +1383,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>   				EMIT3(0x0F, 0x44, add_2reg(0xC0, AUX_REG, dst_reg));
>   				break;
>   			} else if (insn_is_mov_percpu_addr(insn)) {
> -				u32 off = (u32)(unsigned long)&this_cpu_off;
> +				u32 off = 0;
> +
> +				if (IS_ENABLED(CONFIG_SMP))
> +					off = (u32)(unsigned long)&this_cpu_off;
>   

Thanks, there was already a fix in bpf-next tree in here:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=1e9e0b85255e6eca6036b59d8a5fbca6501905ac

>   				/* mov <dst>, <src> (if necessary) */
>   				EMIT_mov(dst_reg, src_reg);
> 


