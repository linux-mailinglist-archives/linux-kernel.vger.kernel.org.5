Return-Path: <linux-kernel+bounces-104518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AAB87CF07
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7014E2845E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B6D3BBD0;
	Fri, 15 Mar 2024 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="K1tfgcpo"
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433EA1E51A;
	Fri, 15 Mar 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513307; cv=none; b=raZJ02ZqCAT4dI7jj0a/xWiVLBymtXotBTgOd+pBGAdA5zb9SHja9mGfya36RdKPkZuz3aot4zSfk7tVUOH8kzgU9x3Qw7nhPO+V840oszxyyNW9Z+RYV5m0A9M/3vKD1/u6C93DUHvJqf18LLFkgoVq7plFvNGV98sb6K4Efos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513307; c=relaxed/simple;
	bh=9lCX9uCVcCKGVeQUcsFaYrfHs8+s1+5zrrS9EvTKNKs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t040X3/8vSl+4giVf9eD2NNq2P1LZiICaESbnIj2TqtHjesmsoanQh0b9LjWrRPbUnvXO3M6Igo55ens3OmspYUZakmlBJxNYSmsN5jJYKZ8jmqTVzxkQ59ofIV0+T3817XL9fRW8tm9M3HXlYJpsZVyELYbL2vPMvr7TChSbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=K1tfgcpo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BLd867ZVPv4mVVvXbZOK1Lv0TtFl95pZLBmlH7B3C9Q=; b=K1tfgcpoUjAvmSPbbCHp3FFVyK
	JjFAFHf5RmxpPZhCSApReVCyDQ1LN/LYC4zmXaHdmivuETYCv7zsPY3R724zViJuymjt/AV5lcy+k
	zjOxWzzKTeLkgwnP+flXaUU6nFtEc3tO2xulVfbil6QPMAzO4/U0NlHgMjncbzbl8iNLi+s4Re8Ge
	AWjLscrvnraeYQp/Z4t9sPr7jT5Glky6q0pObPOmdF+P8lw5r3EGHvtaFGs0Ts4qij+aDJlNNMcFF
	1usO9dIrPQD6OFa1wYxSA21gPmla7YPskBuaWt38FHzH6CJpi6IxDizFoKrQcRxtJNblcH5P2SiT2
	EWIAo7Dw==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl8dk-000464-He; Fri, 15 Mar 2024 15:34:32 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl8di-0001zc-2v;
	Fri, 15 Mar 2024 15:34:30 +0100
Subject: Re: [PATCH bpf-next v2] bpf: Check return from set_memory_rox() and
 friends
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <883c5a268483a89ab13ed630210328a926f16e5b.1708526584.git.christophe.leroy@csgroup.eu>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <14b840d4-631f-2ad9-fb92-540aa150250b@iogearbox.net>
Date: Fri, 15 Mar 2024 15:34:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <883c5a268483a89ab13ed630210328a926f16e5b.1708526584.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27215/Fri Mar 15 09:31:18 2024)

On 2/21/24 3:45 PM, Christophe Leroy wrote:
> arch_protect_bpf_trampoline() and alloc_new_pack() call
> set_memory_rox() which can fail, leading to unprotected memory.
> 
> Take into account return from set_memory_XX() functions and add
> __must_check flag to arch_protect_bpf_trampoline().
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - Move list_add_tail(&pack->list, &pack_list) at the end of alloc_new_pack()
> - Split 2 lines that are reported longer than 80 chars by BPF patchwork's checkpatch report.
> ---
>   arch/x86/net/bpf_jit_comp.c    |  6 ++++--
>   include/linux/bpf.h            |  4 ++--
>   kernel/bpf/bpf_struct_ops.c    |  9 +++++++--
>   kernel/bpf/core.c              | 29 ++++++++++++++++++++++-------
>   kernel/bpf/trampoline.c        | 18 ++++++++++++------
>   net/bpf/bpf_dummy_struct_ops.c |  4 +++-
>   6 files changed, 50 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e1390d1e331b..128c8ec9164e 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2780,12 +2780,14 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_prog_pack_free(image, size);
>   }
>   
> -void arch_protect_bpf_trampoline(void *image, unsigned int size)
> +int arch_protect_bpf_trampoline(void *image, unsigned int size)
>   {
> +	return 0;
>   }
>   
> -void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
> +int arch_unprotect_bpf_trampoline(void *image, unsigned int size)
>   {
> +	return 0;
>   }
>   
>   int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b86bd15a051d..bb2723c264df 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1116,8 +1116,8 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>   				void *func_addr);
>   void *arch_alloc_bpf_trampoline(unsigned int size);
>   void arch_free_bpf_trampoline(void *image, unsigned int size);
> -void arch_protect_bpf_trampoline(void *image, unsigned int size);
> -void arch_unprotect_bpf_trampoline(void *image, unsigned int size);
> +int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
> +int arch_unprotect_bpf_trampoline(void *image, unsigned int size);
>   int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
>   			     struct bpf_tramp_links *tlinks, void *func_addr);
>   
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 0decd862dfe0..d920afb0dd60 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -488,7 +488,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   			if (err)
>   				goto reset_unlock;
>   		}
> -		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +		err = arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +		if (err)
> +			goto reset_unlock;
>   		/* Let bpf_link handle registration & unregistration.
>   		 *
>   		 * Pair with smp_load_acquire() during lookup_elem().
> @@ -497,7 +499,10 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>   		goto unlock;
>   	}
>   
> -	arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +	err = arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
> +	if (err)
> +		goto reset_unlock;
> +
>   	err = st_ops->reg(kdata);
>   	if (likely(!err)) {
>   		/* This refcnt increment on the map here after
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index c49619ef55d0..eb2256ba6daf 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -898,23 +898,31 @@ static LIST_HEAD(pack_list);
>   static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
>   {
>   	struct bpf_prog_pack *pack;
> +	int err;
>   
>   	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
>   		       GFP_KERNEL);
>   	if (!pack)
>   		return NULL;
>   	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
> -	if (!pack->ptr) {
> -		kfree(pack);
> -		return NULL;
> -	}
> +	if (!pack->ptr)
> +		goto out;
>   	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
>   	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
> -	list_add_tail(&pack->list, &pack_list);
>   
>   	set_vm_flush_reset_perms(pack->ptr);
> -	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	err = set_memory_rox((unsigned long)pack->ptr,
> +			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
> +	if (err)
> +		goto out_free;
> +	list_add_tail(&pack->list, &pack_list);
>   	return pack;
> +
> +out_free:
> +	bpf_jit_free_exec(pack->ptr);
> +out:
> +	kfree(pack);
> +	return NULL;
>   }
>   
>   void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
> @@ -929,9 +937,16 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
>   		size = round_up(size, PAGE_SIZE);
>   		ptr = bpf_jit_alloc_exec(size);
>   		if (ptr) {
> +			int err;
> +
>   			bpf_fill_ill_insns(ptr, size);
>   			set_vm_flush_reset_perms(ptr);
> -			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
> +			err = set_memory_rox((unsigned long)ptr,
> +					     size / PAGE_SIZE);
> +			if (err) {
> +				bpf_jit_free_exec(ptr);
> +				ptr = NULL;
> +			}
>   		}
>   		goto out;
>   	}
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d382f5ebe06c..6e64ac9083b6 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -456,7 +456,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>   	if (err < 0)
>   		goto out_free;
>   
> -	arch_protect_bpf_trampoline(im->image, im->size);
> +	err = arch_protect_bpf_trampoline(im->image, im->size);
> +	if (err)
> +		goto out_free;
>   
>   	WARN_ON(tr->cur_image && total == 0);
>   	if (tr->cur_image)
> @@ -1072,17 +1074,21 @@ void __weak arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_jit_free_exec(image);
>   }
>   
> -void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
> +int __weak arch_protect_bpf_trampoline(void *image, unsigned int size)

nit: Should we add __must_check as well here?

>   {
>   	WARN_ON_ONCE(size > PAGE_SIZE);
> -	set_memory_rox((long)image, 1);
> +	return set_memory_rox((long)image, 1);
>   }
>   
> -void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
> +int __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
>   {
> +	int err;
>   	WARN_ON_ONCE(size > PAGE_SIZE);
> -	set_memory_nx((long)image, 1);
> -	set_memory_rw((long)image, 1);
> +
> +	err = set_memory_nx((long)image, 1);
> +	if (err)
> +		return err;
> +	return set_memory_rw((long)image, 1);
>   }

Do we still need this? It looks like this does not have an in-tree user anymore.

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda438..132c8ffba109 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2180,10 +2180,6 @@ void arch_protect_bpf_trampoline(void *image, unsigned int size)
  {
  }

-void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-}
-
  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
  				void *ro_image_end, const struct btf_func_model *m,
  				u32 flags, struct bpf_tramp_links *tlinks,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..7a56d2d84512 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3008,10 +3008,6 @@ void arch_protect_bpf_trampoline(void *image, unsigned int size)
  {
  }

-void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-}
-
  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
  				const struct btf_func_model *m, u32 flags,
  				struct bpf_tramp_links *tlinks,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..d89bdefb42e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1117,7 +1117,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
  void *arch_alloc_bpf_trampoline(unsigned int size);
  void arch_free_bpf_trampoline(void *image, unsigned int size);
  void arch_protect_bpf_trampoline(void *image, unsigned int size);
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size);
  int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
  			     struct bpf_tramp_links *tlinks, void *func_addr);

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index db7599c59c78..04fd1abd3661 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1078,13 +1078,6 @@ void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
  	set_memory_rox((long)image, 1);
  }

-void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-	WARN_ON_ONCE(size > PAGE_SIZE);
-	set_memory_nx((long)image, 1);
-	set_memory_rw((long)image, 1);
-}
-
  int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
  				    struct bpf_tramp_links *tlinks, void *func_addr)
  {

