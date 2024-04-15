Return-Path: <linux-kernel+bounces-145385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC18A558E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB428452D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD474439;
	Mon, 15 Apr 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHxNZKKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAB2119;
	Mon, 15 Apr 2024 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192522; cv=none; b=jhdtCMYa2c2m/8nnPA3RTLvUpPQq7x/soRN6xyK0vBXj+acO5As8ZYUPR9q3Bgdfx0hIxP7f6RUJZAndKjzE9WJLwBZNu0ItF+smEpMZ0AlX8rWuy+G5gQzapz92EgUSToo32iUOPw13Njsa3ZttSgTMu+m1fHHL+hup7CW+Tqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192522; c=relaxed/simple;
	bh=ogpbZ9xNksQ+p1/2BEXp3imOyyJTQHkyfqcNvWF10aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFTc/uCY4NI4erGryZE/ycx6jRJwPtT0/GN9x11Mb7BExWQkgjWaq4IlICrI5U5pslhGYmDnl2TkSTi3KJJGp4/8gaml+l5+n21WJvCvMhyLoqkjb1Qdu7r6pfE2SLe4nrEKYYdV2g3Rln+kQdfK29aoSDmO+uSzZuxFAUH/06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHxNZKKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E2EC113CC;
	Mon, 15 Apr 2024 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713192522;
	bh=ogpbZ9xNksQ+p1/2BEXp3imOyyJTQHkyfqcNvWF10aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHxNZKKIppeBSC3JQu3ygrnZyXklvG7/pkDk/jSlNlpA7gGaLQQqTyDt4sdwUqqCY
	 mPjGWgSv6YacD9SisNO+liVkQ+ezivKaoc6zV4gyOlJStEJay7IBWOCbNhi3EQVJl+
	 nuGFLLfV4d/XM5s7ueWjRbUQeQ7bmPWGwSTuM7StSE6+PCTLCKvQjqpNoIHKAnLdLm
	 nSmovcOLbnT0UQGRF7RPCuuokxTouVBpC+eBsfMfLwY/NVLfh14BcKjUSqYU30lcTW
	 hcXSL3qqiGY38y/nmocNRhe+iqmY4a3OdGvldLdIkliGgBMhnvChHx7Oacp9e8UJFM
	 gsbJZQTzYL8Tw==
Date: Mon, 15 Apr 2024 15:48:34 +0100
From: Simon Horman <horms@kernel.org>
To: Yi-De Wu <yi-de.wu@mediatek.com>
Cc: Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
	Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <peilun.suei@mediatek.com>,
	Liju Chen <liju-clr.chen@mediatek.com>,
	Willix Yeh <chi-shen.yeh@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v10 06/21] virt: geniezone: Add set_user_memory_region
 for vm
Message-ID: <20240415144834.GC2320920@kernel.org>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
 <20240412065718.29105-7-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412065718.29105-7-yi-de.wu@mediatek.com>

On Fri, Apr 12, 2024 at 02:57:03PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Direct use of physical memory from VMs is forbidden and designed to be
> dictated to the privilege models managed by GenieZone hypervisor for
> security reason. With the help of gzvm-ko, the hypervisor would be able
> to manipulate memory as objects. And the memory management is highly
> integrated with ARM 2-stage translation tables to convert VA to IPA to
> PA under proper security measures required by protected VMs.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

..

> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c

..

> +/* gzvm_vm_ioctl() - Ioctl handler of VM FD */
> +static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
> +			  unsigned long arg)
> +{
> +	long ret;
> +	void __user *argp = (void __user *)arg;
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	switch (ioctl) {
> +	case GZVM_SET_USER_MEMORY_REGION: {
> +		struct gzvm_userspace_memory_region userspace_mem;
> +
> +		if (copy_from_user(&userspace_mem, argp, sizeof(userspace_mem)))
> +			return -EFAULT;
> +
> +		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
> +		break;
> +	}
> +	default:
> +		ret = -ENOTTY;
> +	}
> +out:

nit: the out label as added here, but it does not seem to be used
     (until [PATCH v10 11/21] virt: geniezone: Add irqfd support).

     Although it probably isn't hurting anything - other than automated
     testing - it would be best to add as part of a patch that uses it.

Flagged by gcc-13 and clang-18 W=1 builds.

> +	return ret;
> +}
> +
>  static void gzvm_destroy_vm(struct gzvm *gzvm)
>  {
>  	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);

..

