Return-Path: <linux-kernel+bounces-19362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B29B826BED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B64EB21C4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66A14016;
	Mon,  8 Jan 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nILIatRj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFC14003;
	Mon,  8 Jan 2024 10:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161AFC433C7;
	Mon,  8 Jan 2024 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704711515;
	bh=HKg/aeQkbMIOq3wkx1NaMuNsLLkYjHGvQ4ThyvQSM6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nILIatRj59nmYKSwZFVJbOXGcXA6JGAETSPxYBLJrAjZYoQcD2/Zv0a6T5DdVE5cC
	 CbY91S1aXPP4w6PeJIBP98azCcpKyJvi1F2yoW+CIzidq264XJdbLMyBXCJ3ZfSSSe
	 HltCMuWMOyPoawlZdwZ2V7b/MzUgBGWYxNF/VFO2JmrJ9HjCERUSBMdw6eh0RIhxdU
	 EeoyCwXWSOVZekf6Lw6nARR5LaeDbMbMuwoP/LBo2l37TN3S3MDuM6aKrKdOKuk2LZ
	 KAfGn2o+JNANmgaNAk82QSWsrhPxOHXJWripqZdCSDUbFo0rZzLoFh4cIngPHCFK0X
	 GuKQEnsprqTfw==
Date: Mon, 8 Jan 2024 10:58:30 +0000
From: Simon Horman <horms@kernel.org>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: CN10KB: Fix FIFO length calculation
 for RPM2
Message-ID: <20240108105830.GF132648@kernel.org>
References: <20240108073036.8766-1-naveenm@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108073036.8766-1-naveenm@marvell.com>

On Mon, Jan 08, 2024 at 01:00:36PM +0530, Naveen Mamindlapalli wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> RPM0 and RPM1 on the CN10KB SoC have 8 LMACs each, whereas RPM2
> has only 4 LMACs. Similarly, the RPM0 and RPM1 have 256KB FIFO,
> whereas RPM2 has 128KB FIFO. This patch fixes an issue with
> improper TX credit programming for the RPM2 link.
> 
> Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> ---
> v2:
>    - Added Fixes tag

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

