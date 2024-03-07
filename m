Return-Path: <linux-kernel+bounces-95943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D8875535
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58786B21F4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23905130E53;
	Thu,  7 Mar 2024 17:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JXWx3fcS"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39861130AF1;
	Thu,  7 Mar 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832706; cv=none; b=RRnSRX1waA97wAXiTMwUvE7ST/2XdbaQq2u7kSnEBfmhjbp/X20ZUm6oQTvTi7ml22mI5DTKHEFM0W4tWhwHeYXI6aFQLMsz5l4NyzSor1O0+8VxO9URrpjJmlAKM4e99tI30deVh84bOkzTcM35nz8OYYBrZDDdV6ZLKLQhaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832706; c=relaxed/simple;
	bh=Pw1wjnfdkstP4sMjq/SqSIfAkxHM4ROpPhW1adlHMZI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MDWyNvEjUmqvPxv7Uaq5B2Vz3L76Z4uIx5LL6iFzhA/P/jST/DGfDUVj2d6oVCo463fCad9k7jifgRkBum7kL7BaJaVM1MTlACkNz1cQofWGYkzaXe9vF/XOYeaJVUTKxgwyzyrH/xV1fECr/YkISD2KrQE3DQ2Jsz7ubFuZcw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JXWx3fcS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6GKHuULFobI/veCzO71hJuFZMvHW2DBWIwJthjIFZt0=; b=JXWx3fcSvqEd2usjf0tQN1DMCi
	vSO6xR4WJptmR2KKeHQgwZrwN8Kcxo2SsAwQYU3GqG1uUhHegfI3SUUIcj3xuPPVcnq4qvvd9Z59E
	QEXIJexwsh/xmTHCzcD+vFT4djVEoZUoeVEOEWDbhnGjDhNOexCanK8oqtsXqubWrWGy58R7eCA5a
	KMkwOmTd6RBHYUW7MOdrUMkaxa0IBDN9EMKZ1xegBgTvPlxJM2R9eO51SJIrfnnNNvBIZE0Kisxb1
	7MM1fiEoUnsAibMICY+p3wL4QPlBDDx84amzwvLXj1OsBgSDB7e/8IGpBSO57JhZs1rwQ14crw6Zx
	jCusX5Yw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1riHZL-000J8N-R9; Thu, 07 Mar 2024 18:30:11 +0100
Received: from [77.58.94.13] (helo=localhost.localdomain)
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1riHZI-0034Od-1I;
	Thu, 07 Mar 2024 18:30:08 +0100
Subject: Re: [PATCH bpf-next RESEND v2 1/2] bpf: Take return from
 set_memory_ro() into account with bpf_prog_lock_ro()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Puranjay Mohan <puranjay12@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Hengqi Chen <hengqi.chen@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Johan Almbladh <johan.almbladh@anyfinetworks.com>,
 Paul Burton <paulburton@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Wang YanQing <udknight@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 netdev@vger.kernel.org,
 "linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>
References: <8f3b3823cce2177e5912ff5f2f11381a16db07db.1709279661.git.christophe.leroy@csgroup.eu>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <093da237-50c1-5898-1637-7a9a84e1076c@iogearbox.net>
Date: Thu, 7 Mar 2024 18:30:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8f3b3823cce2177e5912ff5f2f11381a16db07db.1709279661.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27207/Thu Mar  7 10:27:12 2024)

On 3/1/24 8:57 AM, Christophe Leroy wrote:
> set_memory_ro() can fail, leaving memory unprotected.
> 
> Check its return and take it into account as an error.
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Sorry for the resend, I forgot to flag patch 2 as bpf-next
> 
> Note: next patch is autonomous, it is sent as a follow-up of this one to minimize risk of conflict on filter.h because the two changes are too close to each other.
> 
> v2: No modification (Just added link in patch message), patchwork discarded this series due to failed test of s390 but it seems unrelated, see https://lore.kernel.org/bpf/wvd5gzde5ejc2rzsbrtwqyof56uw5ea3rxntfrxtkdabzcuwt6@w7iczzhmay2i/T/#m2e61446f42d5dc3d78f2e0e8b7a783f15cfb109d
> ---
>   include/linux/filter.h | 5 +++--
>   kernel/bpf/core.c      | 4 +++-
>   kernel/bpf/verifier.c  | 4 +++-
>   3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 36cc29a2934c..7dd59bccaeec 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -884,14 +884,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>   
>   #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
>   
> -static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> +static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>   {
>   #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>   	if (!fp->jited) {
>   		set_vm_flush_reset_perms(fp);
> -		set_memory_ro((unsigned long)fp, fp->pages);
> +		return set_memory_ro((unsigned long)fp, fp->pages);
>   	}
>   #endif
> +	return 0;
>   }
>   
>   static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..c49619ef55d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>   	}
>   
>   finalize:
> -	bpf_prog_lock_ro(fp);
> +	*err = bpf_prog_lock_ro(fp);
> +	if (*err)
> +		return fp;
>   
>   	/* The tail call compatibility check can only be done at
>   	 * this late stage as we need to determine, if we deal
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c34b91b9583..6ec134f76a11 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19096,7 +19096,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>   	 * bpf_prog_load will add the kallsyms for the main program.
>   	 */
>   	for (i = 1; i < env->subprog_cnt; i++) {
> -		bpf_prog_lock_ro(func[i]);
> +		err = bpf_prog_lock_ro(func[i]);
> +		if (err)
> +			goto out_free;

How does the error path take out the subprogs from kallsyms in your case? Suppose some of
the loop iterations succeed before we hit an error. I believe the subprogs still exist in
kallsyms here.

>   		bpf_prog_kallsyms_add(func[i]);
>   	}
>   
> 


