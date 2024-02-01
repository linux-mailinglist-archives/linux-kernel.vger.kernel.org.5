Return-Path: <linux-kernel+bounces-47906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EE845473
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680B41C28032
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA315B99B;
	Thu,  1 Feb 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s/tsIeBS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46715A4A1;
	Thu,  1 Feb 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780655; cv=none; b=YDvChZWVLmaJidqVKQe99OB0GTDC8D3j3L+I4jsvNIv9shO15Yp/Jg9dpf/89eXkbrP2w9Xu/4QWQ0mPuuqn6mOYqQe40GekrAt0+nkDme1wJZU30PbMxYrqf2imiRbkcOfFOzNjd+i1fqtH+lKqFaC1Rt5yIjK5QeRCJai5e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780655; c=relaxed/simple;
	bh=CQ+G0j9FxKWITjhQFY4SwZZur7CT0j14ogDVrgi21NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWqyRO7iU3SmWa+FgctvnfhN5ZFg7Q4Qgd4db8UzRnp/vQs4ZlEmsu43aa8ff+6DphxKoWJgEFOp6KnkucqkVvCVyGQAamiVko+qMz/1AzjAX8CZppuldj45xA2nkjLIdvgzWXkz9xPkzrNKO2r8svcinILcG24miLaGuwsdrYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s/tsIeBS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706780651;
	bh=CQ+G0j9FxKWITjhQFY4SwZZur7CT0j14ogDVrgi21NA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s/tsIeBSYEvrkvPa88cGQTK3vogxX2XYOiVZ7T2WQ5TTGXK0MTMj7ojoG5gvtGqbq
	 ScJHUt3KfpVJvV6ulBryKd6p15MCT+DKAElOyaVqJ2Do7hv8cVSuTevLIKPmuJRsnn
	 DNThtdUYQWjgC6K6l5F4gzofQBDwIB8Nrp808kxdi0q9Q86qMvo/tCf1DHOh9MNQ2/
	 tdCP4O4FdNtIHPoBgzzUAgMrZT2k3QxtCxFcDABONArRHjCm/b8+PlZt3Uh+nBCC6l
	 oYnTOrBdZcUuv+gQ2AaGsSN+3F6cR6ansvsTsaIvRpIxyEIDdQEL5rDi7sXasvHuOI
	 VUWV53PLn2DWg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 40B02378208E;
	Thu,  1 Feb 2024 09:44:10 +0000 (UTC)
Message-ID: <c027bf67-e9b2-4eb2-9dee-a47a9c3bdd8a@collabora.com>
Date: Thu, 1 Feb 2024 10:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/21] virt: geniezone: Add vm capability check
Content-Language: en-US
To: Yi-De Wu <yi-de.wu@mediatek.com>,
 Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
 Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 David Bradil <dbrazdil@google.com>, Trilok Soni <quic_tsoni@quicinc.com>,
 My Chuang <my.chuang@mediatek.com>, Shawn Hsiao <shawn.hsiao@mediatek.com>,
 PeiLun Suei <peilun.suei@mediatek.com>,
 Liju Chen <liju-clr.chen@mediatek.com>,
 Willix Yeh <chi-shen.yeh@mediatek.com>,
 Kevenny Hsieh <kevenny.hsieh@mediatek.com>
References: <20240129083302.26044-1-yi-de.wu@mediatek.com>
 <20240129083302.26044-8-yi-de.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240129083302.26044-8-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 29/01/24 09:32, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> Inquire the `capability support` on GenieZone hypervisor.
> Example:
> `GZVM_CAP_PROTECTED_VM` or `GZVM_CAP_VM_GPA_SIZE`.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
> Signed-off-by: kevenny hsieh <kevenny.hsieh@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/geniezone/gzvm_arch_common.h |   2 +
>   arch/arm64/geniezone/vm.c               | 122 ++++++++++++++++++++++++
>   drivers/virt/geniezone/gzvm_main.c      |  27 ++++++
>   drivers/virt/geniezone/gzvm_vm.c        |  21 ++++
>   include/linux/gzvm_drv.h                |   5 +
>   include/uapi/linux/gzvm.h               |  31 ++++++
>   6 files changed, 208 insertions(+)
> 
> diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
> index 2f66e496dfae..383af0829f11 100644
> --- a/arch/arm64/geniezone/gzvm_arch_common.h
> +++ b/arch/arm64/geniezone/gzvm_arch_common.h
> @@ -13,6 +13,7 @@ enum {
>   	GZVM_FUNC_DESTROY_VM = 1,
>   	GZVM_FUNC_SET_MEMREGION = 4,
>   	GZVM_FUNC_PROBE = 12,
> +	GZVM_FUNC_ENABLE_CAP = 13,

GZVM_FUNC_PROBE  = 12,
GZVM_FUNC_ENABLE_CAP,

>   	NR_GZVM_FUNC,
>   };
>   

Regards,
Angelo


