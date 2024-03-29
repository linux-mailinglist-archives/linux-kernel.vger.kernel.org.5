Return-Path: <linux-kernel+bounces-125262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3EA8922FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0ED1F25AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5050137765;
	Fri, 29 Mar 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxY7oCjP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB3A923;
	Fri, 29 Mar 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734360; cv=none; b=D/2Nmrcm6H/WSwNsyA+ktsLbxhMaAL1wyfaMLwFs2fGkQ16PwNCyBMBIBGsck8PUKhrG5n7cXISO/eDtsB2w0o5o2dHSYH3bPptxcW3fAKI5iU8HeBtSsMH8E0F3vL3VMKwjRPgyGBL8rH6okW7yD4hOwda1BTU9XYs1faYm49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734360; c=relaxed/simple;
	bh=HFcDQXQ4/V0olwInsRZS2sioZwVCn9Un9HBzhqOv1RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN6ZBJ/m3QgENynxI4kHHCqb8eHGZtaNFVM9k/SCcs3HNg/1d/kREYQkj1xXjxMgu/wtMoBTT/kv+tNa+041OwKHjQeaDypptuca0FTxAXgGP5YcyJhDnLbLOUcsgM+n066xl7JEqQcbd5/+GV6LSscryUF/ZIdHr/OsdsI4ePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxY7oCjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06549C433C7;
	Fri, 29 Mar 2024 17:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711734359;
	bh=HFcDQXQ4/V0olwInsRZS2sioZwVCn9Un9HBzhqOv1RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxY7oCjP2GoakWmVTJBFF2ww/W7egc/tuBsgT+LvgoNjXbz5XwsVTEma04/FTqDsl
	 bMa+jHbV8m8GxuR/3uOnxSXXX+bAFfM03hL9LrQr0zf2+8yyxEAHue0ZfUkbU/2NVv
	 HoTNsUjzowUTEggo897VrBoN5mjEpmUH6ImYGZdlTVBneXFff+v6O3ME9Yyf9hqfVy
	 qMWU0FY3zoN41h/ZZTnr4UZncWDr+X31eue4/IjvX72xqy/MpwyKmcbWboI2BDv8cU
	 IrtQTkRYd1Xw80UnleTlfuHSdGlTF6pbjU8sDFNyiCyRKGOfg0T1PRNuV8TMcvT8Rw
	 0w1jwraAZ1RDg==
Date: Fri, 29 Mar 2024 17:45:53 +0000
From: Simon Horman <horms@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	dan.carpenter@linaro.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3] octeontx2-pf: remove unused variables
 req_hdr and rsp_hdr
Message-ID: <20240329174553.GN651713@kernel.org>
References: <20240328020723.4071539-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328020723.4071539-1-suhui@nfschina.com>

On Thu, Mar 28, 2024 at 10:07:24AM +0800, Su Hui wrote:
> Clang static checker(scan-buid):
> drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c:503:2: warning:
> Value stored to 'rsp_hdr' is never read [deadcode.DeadStores]
> 
> Remove these unused variables to save some space.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v3:
>  - using net-next in subject
>  - split the v2 patchset into individual patches
> v2:
>  - add "net" in subject

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


