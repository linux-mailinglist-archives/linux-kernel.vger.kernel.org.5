Return-Path: <linux-kernel+bounces-74567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B51085D613
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458FC1C226A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154513D0BF;
	Wed, 21 Feb 2024 10:52:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480E36AF1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512758; cv=none; b=V4ohEeV6VAbkPAN4T4iL3IjnRtAeW/Y17AvJAkOTqipHjzsjtW5gQ0CxVgupNx+gFQ6jvxBCEL0vq8lKXGpphc+xiXjAU+Lmgek8RjLQaJGHZXXzpo0i583ctDdYHb6IK/o7/vx/Fk4y17GMKJbh0ONrSVTwAUftLxNokDF52QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512758; c=relaxed/simple;
	bh=uvXbkZosPYVLvMB8OjtWlFeDeHphIil546tOGNUcpQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewYvnwQ992nlwGGq3m4xSLLwjFtdr46CBE997quSW6fBuP+Cq0PgwPB9M9E+9q0dlRBOwvbTlp3nz9fDIcip9fGroyY9TaYmQKctzXYnIwYQ00MgKNh7xXDGZQnvl6zKziu7ibslT4XgTwn6WsDDrVDFCS+mnL+xBJNr8dZ3zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7CD3FEC;
	Wed, 21 Feb 2024 02:53:14 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C68D3F73F;
	Wed, 21 Feb 2024 02:52:35 -0800 (PST)
Date: Wed, 21 Feb 2024 10:52:33 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: optee: fix struct kernel-doc warnings
Message-ID: <ZdXV8Tlig2qeIGD2@pluto>
References: <20240221062157.8694-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221062157.8694-1-rdunlap@infradead.org>

On Tue, Feb 20, 2024 at 10:21:57PM -0800, Randy Dunlap wrote:
> Fix the kernel-doc notation for the nested union in struct
> scmi_optee_channel to eliminate kerenl-doc warnings:
> 
> optee.c:130: warning: Excess struct member 'shmem' description in 'scmi_optee_channel'
> optee.c:131: warning: Function parameter or struct member 'req' not described in 'scmi_optee_channel'

Thanks for this, I've spotted it recently and didn't get time to address it.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Cristian

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Cristian Marussi <cristian.marussi@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/firmware/arm_scmi/optee.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff -- a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
> --- a/drivers/firmware/arm_scmi/optee.c
> +++ b/drivers/firmware/arm_scmi/optee.c
> @@ -109,8 +109,10 @@ enum scmi_optee_pta_cmd {
>   * @rx_len: Response size
>   * @mu: Mutex protection on channel access
>   * @cinfo: SCMI channel information
> - * @shmem: Virtual base address of the shared memory
> - * @req: Shared memory protocol handle for SCMI request and synchronous response
> + * @req: union for SCMI interface
> + * @req.shmem: Virtual base address of the shared memory
> + * @req.msg: Shared memory protocol handle for SCMI request and
> + *   synchronous response
>   * @tee_shm: TEE shared memory handle @req or NULL if using IOMEM shmem
>   * @link: Reference in agent's channel list
>   */

