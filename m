Return-Path: <linux-kernel+bounces-165324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C58B8B48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C83B214DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB32712E1E7;
	Wed,  1 May 2024 13:36:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7281F51C49
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570610; cv=none; b=lveG/BVKXQUWxwZRWSJKRRkb7pyrSepop0u+TplX5VOxDpuQNPBaF/37Vj7H5NN/wnXoreuAv0aCv1zlGRVcn2CEtaJZUeoHHMOu/7WmfHUrdK3pRmeLR83tMLnV55+LIgzXBzytCcfCqBgWFRtnBwvFGy1gRS2PjB9u07OyRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570610; c=relaxed/simple;
	bh=zTsdvuMoDV5ibhpwBED87HJwZ2l0YhEWLx3/N/6clNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8HjqL4UI6JAkajxw0HEnZtiDYJ2YuuTx8bLFs1JDWVCCH6K/VzadOfqBSrFZfGB7dn+V6Vz8Z5aslHB0D0Vx8P494WtMAXDB62jdOcvpF6jiWv0qO3UoMGRyxQ4Qa07+JuKFI/pxYJz9647mzp0bshdUCvWpxN03eGuxYDSOvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10912F4;
	Wed,  1 May 2024 06:37:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB9F3F73F;
	Wed,  1 May 2024 06:36:46 -0700 (PDT)
Date: Wed, 1 May 2024 14:36:44 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: power_control: support suspend
 command
Message-ID: <ZjJFLag-0ei0a3xM@pluto>
References: <20240428075105.2187837-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428075105.2187837-1-peng.fan@oss.nxp.com>

On Sun, Apr 28, 2024 at 03:51:05PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Support System suspend notification. Using a work struct to call
> pm_suspend. There is no way to pass suspend level to pm_suspend,
> so use MEM as of now.
> 
> - The choice of S2R(MEM) by default. The userspace can configure whatever
>   default behaviour expected as S2R, if issuing suspend from userspace.
> 
> - The userspace needs to keep the wakeup source enabled, otherwise the
>   system may never resume back.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Have you tried triggering a suspend with this on your setup ?

Anyway, LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian


