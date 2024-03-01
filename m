Return-Path: <linux-kernel+bounces-87883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A96386DA5F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44BFDB23DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A4F47A66;
	Fri,  1 Mar 2024 03:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP4QnNmW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41468405DB;
	Fri,  1 Mar 2024 03:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265062; cv=none; b=rxrXMuGrpkkMHnD33qzSTnKPvg8ZjRZXSt94uNBsdZDaMU1J2gVCglTF8I83yE13vhQBtfkAHIGRy9gJ/qo92l/8UsMVZ9YVCuwjamqtyvqnJNIA16nxvvoGM6x/fEKJqr8ZNGyoJHsd7XuPb0QErKA92eIrr+HU32Cf2rTaZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265062; c=relaxed/simple;
	bh=7xX2C2BQUxZg8aBPxe7nGBqr7gl92malGE7JwmKKut4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxG4/zmd27DFBerklHiHznkZUtZmS8BbxOKnPVEQ8HvpyMOa9mgPMV3NjDLAX7D44AyR8JGY1b+fxPMOxvCXPd5LoVwWTWsGnKJs/tqfaHH8eNqrD3WdPPhBRqr5Qb59ZLjY27UdL7sK5stQjMkHj1Wx6Lv5cmASqZRZqgaeFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP4QnNmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCFC433C7;
	Fri,  1 Mar 2024 03:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709265061;
	bh=7xX2C2BQUxZg8aBPxe7nGBqr7gl92malGE7JwmKKut4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP4QnNmW2TVAvhq8VEXA9oQWyF+vq3qDjPdtXasHXPR0uyhOb6lU6Vv0r3GiDCcJS
	 5zp7BInLoSyFh9uR0RZez2KrbY/xtFtkawXBy0PC6rv956IyqFsEM4L0SIaY4AGJBj
	 UAbxaNLA5c/zI1076IW8NjUNr2603FXGiUtYhQcsLG9jNreP7FAi/nuX33o7LbKySP
	 CtQL6Gzo/rhD+Ode8lFi77q0oLpRKsNocSKnwATBxgI/h33YQcWIrHpsDvN9wHG5fn
	 mNztbLoWgirVB9HKkdI4kVsky+wxaNP5YB6dbKQsFrXXAcfYjSIsJlkRVkM8MXPV2w
	 PGVc6SRxRNdbw==
Date: Thu, 29 Feb 2024 20:50:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Florian Westphal <fw@strlen.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: net/netfilter/nf_bpf_link.c:186:33: warning: bitwise operation
 between different enumeration types ('enum bpf_reg_type' and 'enum
 bpf_type_flag')
Message-ID: <20240301035059.GA577965@dev-arch.thelio-3990X>
References: <202403010842.hhJY5TFK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403010842.hhJY5TFK-lkp@intel.com>

Hi all,

On Fri, Mar 01, 2024 at 08:57:56AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   87adedeba51a822533649b143232418b9e26d08b
> commit: fd9c663b9ad67dedfc9a3fd3429ddd3e83782b4d bpf: minimal support for programs hooked into netfilter framework
> date:   10 months ago
> config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240301/202403010842.hhJY5TFK-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010842.hhJY5TFK-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403010842.hhJY5TFK-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

<snip>

While this change may introduce an instance of this warning, it is
actually a change on the clang side that causes this and I am still
looking for input on what to do about it:

https://github.com/ClangBuiltLinux/linux/issues/2002

I think this report can just be ignored for now. The Intel folks may
want to consider sending -Wenum-enum-conversion and
-Wenum-compare-conditional reports to our mailing list only until we can
sort this out. Sorry for the noise.

Cheers,
Nathan

> >> net/netfilter/nf_bpf_link.c:186:33: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
>      186 |         info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
>          |                          ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
>    22 warnings generated.
> 
> 
> vim +186 net/netfilter/nf_bpf_link.c
> 
>    170	
>    171	static bool nf_ptr_to_btf_id(struct bpf_insn_access_aux *info, const char *name)
>    172	{
>    173		struct btf *btf;
>    174		s32 type_id;
>    175	
>    176		btf = bpf_get_btf_vmlinux();
>    177		if (IS_ERR_OR_NULL(btf))
>    178			return false;
>    179	
>    180		type_id = btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
>    181		if (WARN_ON_ONCE(type_id < 0))
>    182			return false;
>    183	
>    184		info->btf = btf;
>    185		info->btf_id = type_id;
>  > 186		info->reg_type = PTR_TO_BTF_ID | PTR_TRUSTED;
>    187		return true;
>    188	}
>    189	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

