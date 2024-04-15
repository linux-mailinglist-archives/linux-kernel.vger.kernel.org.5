Return-Path: <linux-kernel+bounces-145555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD28A57CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E391285CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643382485;
	Mon, 15 Apr 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDAALKxn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4C1CD23;
	Mon, 15 Apr 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198740; cv=none; b=Ja2sahRhEdNuXNIixMGr/hu83BLxsZLWfnQPiv8W5UjLGpfnzrcJx+QQHR+1YC24cCdELmup5VKOI3dDqQuEKzM1E4/i+BsaREYcRpBqAQ8NUHwhICjotTfA0TNgEa63qzDVOxbwyl1sN0XMYUbqn3x6oeKZvTEBnTa3ycA+MRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198740; c=relaxed/simple;
	bh=Wsb9mO0IMUs6XyEA7C68rG60ROTwki5oNLgFkNQGVfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEb4L3hZx/kVXZ15ajtVDPRUXB1pekZkDMZOjwqnpViKSAL9NI35n1qzEPHb5U7M4fT4zlbuLgTe6Atd3DFQdghmJ6mnnuP/xhUAxQIIZ0Q/Nob3cFI9+FeI5n1O8nOjgg5YPk7sVqGm9tptBNKK+NzbfJpLgHEL2tlpsG7jXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDAALKxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B94C113CC;
	Mon, 15 Apr 2024 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713198740;
	bh=Wsb9mO0IMUs6XyEA7C68rG60ROTwki5oNLgFkNQGVfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDAALKxniYNrhPk7bGdZS6/mD+2lHE9dUHGMqBLvm6ZfPtEwssQoA88x2UurOeeN2
	 ltpjL7kJB+XXWqoHe229s83KYjjbNhr9s8SHH4V8sYGTU8jYDxwjJPZj6AePV4lA8b
	 ucSkbhHoj6CaQkA14qENjkLbGPeW4JGeF4hFAiuWTTcfNQAY1HQduj3z9VMS9GkycQ
	 DI7pojk9FqjWIQKB9JOzHezwyg3iSRcpIh6jRjb4u7T+xoW+knmBlCsRpL4PjkuKxt
	 3I4/YTgREcipydZmtPp5swjdQqI1Yiru8u7SZ6TNxrZoamRL8MZrxxYxDTBcD05esc
	 hq8v/xfZ4MvHQ==
Date: Mon, 15 Apr 2024 17:32:12 +0100
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
Subject: Re: [PATCH v10 19/21] virt: geniezone: Provide individual VM memory
 statistics within debugfs
Message-ID: <20240415163212.GE2320920@kernel.org>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
 <20240412065718.29105-20-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412065718.29105-20-yi-de.wu@mediatek.com>

On Fri, Apr 12, 2024 at 02:57:16PM +0800, Yi-De Wu wrote:
> From: "Jerry Wang" <ze-yu.wang@mediatek.com>
> 
> Created a dedicated per-VM debugfs folder under gzvm, providing
> user-level programs with easy access to per-VM memory statistics for
> debugging and profiling purposes. This enables users to effectively
> analyze and optimize the memory usage of individual virtual machines.
> 
> Two types of information can be obtained:
> 
> `cat /sys/kernel/debug/gzvm/<pid>-<vmid>/protected_hyp_mem` shows memory
> used by the hypervisor and the size of the stage 2 table in bytes.
> 
> `cat /sys/kernel/debug/gzvm/<pid>-<vmid>/protected_shared_mem` gives
> memory used by the shared resources of the guest and host in bytes.
> 
> For example:
> console:/ # cat /sys/kernel/debug/gzvm/3417-15/protected_hyp_mem
> 180328
> console:/ # cat /sys/kernel/debug/gzvm/3417-15/protected_shared_mem
> 262144
> console:/ #
> 
> More stats will be added in the future.
> 
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: Liju-Clr Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>

..

> diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c

..

> @@ -398,6 +409,113 @@ static void setup_vm_demand_paging(struct gzvm *vm)
>  	}
>  }
>  
> +static int debugfs_open(struct inode *inode, struct file *file)
> +{
> +	file->private_data = inode->i_private;
> +	return 0;
> +}

nit: Coccinelle suggests that simple_open() can be used in place
     of the debugfs_open() implementation above.

..

> +static const struct file_operations hyp_mem_fops = {
> +	.owner = THIS_MODULE,
> +	.open = debugfs_open,
> +	.read = hyp_mem_read,
> +	.llseek = no_llseek,
> +};
> +
> +static const struct file_operations shared_mem_fops = {
> +	.owner = THIS_MODULE,
> +	.open = debugfs_open,
> +	.read = shared_mem_read,
> +	.llseek = no_llseek,
> +};

..

