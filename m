Return-Path: <linux-kernel+bounces-91515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112D87127C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E971F23764
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFACB17C9E;
	Tue,  5 Mar 2024 01:50:40 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5280C17C76
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709603440; cv=none; b=Rv0ekZ/f2ax3KmuNs3pyDtIvRmVu6RE65muhsHUfMxZYM9QrUDupsXvejwfK7UQLAM4z2PqON7p9kJGB1sVQL/9fQRHa5wZzlhsc0LIJNheW57Y/USgF5cm9iFj2YimBQQT9eNGQwIUr8lzspNjZ4RywvVNdPZFZyLJ8SrpxgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709603440; c=relaxed/simple;
	bh=fdNDQ1U9N/yDQkVjOe/xzJ3JKO1ZOkr5iCU9O3ao6mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEPZSMWZMA4HgwCEIAVi3qjRH/WCGIWMToNX+d4oAbQvwgBzG6dJPSeMvAiQwiZUTSk0+tvaGSfVg51JNKtc9oqlWcSTUW/bcaoaIDz8bgIpXWisHxg5tbNrwzAVc4D6EdenT+qOzI+owjEBSt5QWHyOPWPFia5MXyMNkEKvMKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp62t1709603425tlfm1u6g
X-QQ-Originating-IP: bOfoihEMseawlWRMJfUotn4eIapOK4hJzqa7PVtpX9M=
Received: from localhost ( [112.22.30.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 05 Mar 2024 09:50:24 +0800 (CST)
X-QQ-SSF: 01400000000000505000000A0001000
X-QQ-FEAT: aBJFcW+uBGaR7RCsuQoBy5eXJ1KZuuHUtRBZZSI216HiitWH8P8cUz2Cg2MDR
	6WqYitRnkgbwfvlT/0blMffY3wNXYkK5uMhGTeLXZ3Iuzb+eFyMN2aEkk9guJSpYlgC3KxY
	z+w2R2C5Q6fQKuRLC2DGW2tGX9dDFRnhESPT9CPgwTyYsM6nuhviYA7jYWR/uu6q8X2SsM3
	7Ji4l8FhFdCRxux7wuDMywVd5qLLnOfHlVjTv/OWCNiKTuJjcblHWtQ4FiOXZPSWLn84LRu
	/5vh0+dzeb+rr68ICK34GULzlCh0ayPn7SqzI+y7JkGRd/4NlmebYRru5ssz+XRYCb9T937
	PaGtuXjfD72hrxLllYKzb/3SWJKOct2fU9SMMw9uclhD8X3uPfUPkIgQ+ofXsCGeORpxxN7
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14154700281966297232
Date: Tue, 5 Mar 2024 09:50:23 +0800
From: Dawei Li <dawei.li@shingroup.cn>
To: lucas.demarchi@intel.com, ogabbay@kernel.org,
	thomas.hellstrom@linux.intel.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/xe: Declare __xe_lrc_*_ggtt_addr with __maybe__unused
Message-ID: <1543D46042445CE9+ZeZ6X5Ng2rq3swoo@centos8>
References: <20240204062324.3548268-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204062324.3548268-1-dawei.li@shingroup.cn>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

Hi,

On Sun, Feb 04, 2024 at 02:23:24PM +0800, Dawei Li wrote:
> Kernel test robot reports building error:
> 
> drivers/gpu/drm/xe/xe_lrc.c:544:1: error: unused function
> '__xe_lrc_regs_ggtt_addr' [-Werror,-Wunused-function]
> 544 | DECL_MAP_ADDR_HELPERS(regs)
>     | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/gpu/drm/xe/xe_lrc.c:536:19: note: expanded from macro
> 'DECL_MAP_ADDR_HELPERS'
> 536 | static inline u32 __xe_lrc_##elem##_ggtt_addr(struct xe_lrc *lrc) \
>     |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> <scratch space>:54:1: note: expanded from here
> 54 | __xe_lrc_regs_ggtt_addr
>    | ^~~~~~~~~~~~~~~~~~~~~~~
> 
> 1 error generated.
> 
> Declare __xe_lrc_*_ggtt_addr with __maybe_unused to address it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402010928.g3j2aSBL-lkp@intel.com/
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  drivers/gpu/drm/xe/xe_lrc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Just a gentle ping.

Thanks,

    Dawei

> 
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 0ec5ad2539f1..f70e60a2f8a3 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -614,7 +614,7 @@ static inline struct iosys_map __xe_lrc_##elem##_map(struct xe_lrc *lrc) \
>  	iosys_map_incr(&map, __xe_lrc_##elem##_offset(lrc)); \
>  	return map; \
>  } \
> -static inline u32 __xe_lrc_##elem##_ggtt_addr(struct xe_lrc *lrc) \
> +static inline u32 __maybe_unused __xe_lrc_##elem##_ggtt_addr(struct xe_lrc *lrc) \
>  { \
>  	return xe_bo_ggtt_addr(lrc->bo) + __xe_lrc_##elem##_offset(lrc); \
>  } \
> -- 
> 2.27.0
> 

