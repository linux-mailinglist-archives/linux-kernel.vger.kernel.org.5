Return-Path: <linux-kernel+bounces-104060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2F87C866
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CADA42836BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E943DF71;
	Fri, 15 Mar 2024 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wX3fTx76"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28317DDA9;
	Fri, 15 Mar 2024 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478551; cv=none; b=V6kR6Or9z5QoIthFd9XGD0FTwI53YodPBTFoKHTxl6yHQnsHlVOUuUfYhCpDg/uRmb+0ec0LYZ8tUkoO66q2KtGJRM18CrIrEsK2Lo7KwwDLYTTPk445wLI4tUXZDUucXjIpT7wEhHmOJdXTtYoSa3hvwJD7yK9IQK/iNRbwAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478551; c=relaxed/simple;
	bh=+aFnlU8sVV7br4We/EkXYelHujQrdfZV21yVHMFaQqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HsyObmZLrlIsSevWu3Dbg/Jg8jdfHwmA4d/ImwOVs7hdcjrzb7f7qpgzjklM8SKH8vGk8wK1sypwSyTrg6yWbMHvsK4tUfPfC/WutSVRP/+jrli924gF1n5g1iDk6dHphzuRm76PA4fepU48iCvE2ouzYs+xGSV+ExZnp6fVobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wX3fTx76; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=t+bIzMjxJuGGhtOWha6ywfboWHnjmdtyGquxlI+CJQw=; b=wX3fTx76SdeNFG9qod3TY6OXyj
	wMV+UhX4QStLD+UwamXWaoTVemH5ygpYyBsH5/otnqt/C0N24JnhgK7YIY1O4O+PK2hKoX1wid9pa
	X+HDPoONM9O5OXf575OdkR4yw/ZGezZl98cyJMIND/MeAuGAq1nMFLfFW0j+/dPEj9SQa/byPRKLt
	w6q3QJp5saTAuR9kN87x3KjbkiH+BzUVvJCLUdhYr3p8neWb5D+m//EL/yJ+yTMGuCeHtmpFe44QV
	YM96/qw21mwNuldMlHRMzmvXZgDOwlMciCa+HOTacLvxHyIgYnfirB1O+AFCh6WZnSGE+S/UT1nr/
	XVuAN72Q==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkzbf-0000000Gfyd-3utH;
	Fri, 15 Mar 2024 04:55:48 +0000
Message-ID: <11706f70-539d-43b3-8b5d-e20bdd38d23b@infradead.org>
Date: Thu, 14 Mar 2024 21:55:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] ACPI: Add kernel-doc comments for ACPI suspend
 and hibernation functions
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, rafael@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240315003753.96173-1-yang.lee@linux.alibaba.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240315003753.96173-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/14/24 17:37, Yang Li wrote:
> This patch enhances the documentation for the ACPI power management
> functions related to system suspend and hibernation. This includes the
> use of kernel-doc style comments which provide developers with clearer
> guidance on the usage and expectations of these functions.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> change in v2:
> --According to Randy's suggestion, use a space between '*'
>   and function names, function parameters.
> 
>  drivers/acpi/sleep.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 

-- 
#Randy

