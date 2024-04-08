Return-Path: <linux-kernel+bounces-135584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291D589C7F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B641F23812
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0C13F451;
	Mon,  8 Apr 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FicLUnoP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF6D13F431
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589404; cv=none; b=gWXRXNidZZFUIKbuV6qHyr6XRLOQeTekTPberG1f2YvxZxHYU06QYSx1Sm0pb7q343oS2rJUNkzPjNFl5AQ3aaiGaiyWL8fLINkKQSpxK3azrsqjA+ZZ7OuJ8WAQZa+4LV4LZvtoXmQDyd2FQdToXA6YQzO4oRNGzSKWoc5fPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589404; c=relaxed/simple;
	bh=D+prau6GoZ0tpwd6GwwL9MiMRgR3PVQPusKaNXb8xHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XfEyzbT1wy39+KhMzSJ3R96gVieCmAIohdx/HK+HbJLeCkgwc4mgmpyvpxp7Vh8dckDXBmYTDjm8IK0mVVzfsS2L9XGvCq8+B2r27s25I5xFkuOLlGRyRihEfnhft7DEWEDL++1/5jcBRWB5k+1KFoG82/qnbxW8t9UqJzzNOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FicLUnoP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=mJAYc4PEvQcHsUZpWS27vPz5UG+6bl7Nu9InpRTebiI=; b=FicLUnoPwsHFvFaQuaBpfUoF/D
	2ZVa0wO4WJYCmwys6xw0Xva0fpdoYVGXiuqjEk0i5Bf/ztXkXzyV5pCpejCyUJV1kZWHMI9rseYFT
	rk+a/dACJXOf+zwevGx60mlwoIsjlVxEIYlh0s15Fe58xo3HADLw4b/tM3zUTCCxyXhjNbwpHdEUf
	oe9W2aR8hy6qhOrc+j3xo0JiBgoJxh11tpJCvPzNJo3mR3hFz27GZOFVU69fGc7mLrauZio+xWCod
	SMQmoyiGz2UDFtCC4wVwRReDBT8ZMxlrWbwM63QW4nU6FCsuDmOSbXLukg+cXBMNhLhERbxkGh3VR
	8tnXZTfw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtqjd-0000000G03s-014q;
	Mon, 08 Apr 2024 15:16:39 +0000
Message-ID: <8f0a4271-2957-4b4a-a63c-184062194075@infradead.org>
Date: Mon, 8 Apr 2024 08:16:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/3 v2] powerpc/rtas: Add kernel-doc comments to
 smp_startup_cpu()
To: Yang Li <yang.lee@linux.alibaba.com>, arnd@arndb.de, mpe@ellerman.id.au,
 npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org,
 naveen.n.rao@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240408053109.96360-1-yang.lee@linux.alibaba.com>
 <20240408053109.96360-2-yang.lee@linux.alibaba.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240408053109.96360-2-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/24 10:31 PM, Yang Li wrote:
> This commit adds kernel-doc style comments with complete parameter
> descriptions for the function smp_startup_cpu().
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/powerpc/platforms/cell/smp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
> index 30394c6f8894..fee638fd8970 100644
> --- a/arch/powerpc/platforms/cell/smp.c
> +++ b/arch/powerpc/platforms/cell/smp.c
> @@ -54,6 +54,7 @@ static cpumask_t of_spin_map;
>  
>  /**
>   * smp_startup_cpu() - start the given cpu
> + * @lcpu: Logical CPU ID of the CPU to be started.
>   *
>   * At boot time, there is nothing to do for primary threads which were
>   * started from Open Firmware.  For anything else, call RTAS with the

-- 
#Randy

