Return-Path: <linux-kernel+bounces-97210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE538766FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172A528715E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6286A524A;
	Fri,  8 Mar 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtGcnHti"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C31D554;
	Fri,  8 Mar 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910369; cv=none; b=BVvbKxsrtD+JDZCtJZNFNB5WExQ/Ld8NWkNleCJENF32/w0fXy692ZJkLqNykJ35DjSobUtaRZGHkn9iLfjIMtszJ7Z6tYUXZHUI/48QtMSV71OSGN1y1HN+zUmQxD0vsYpK2j8u1Vbo/r7ZDqqZF0R3ENaIDHiGfTHr6FyuciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910369; c=relaxed/simple;
	bh=K47phgkDZNLRQ1Cerqn/YO0B/e7+sDQNzjKODd9H+eo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fG+IhG5/TeKov6a+f10Eg7VosmJDMvDw4xNtB6R9fEeh9Zr/yf7c3eanwLSnv7MPehYGfgiwezqYGbIsih+o584bm3YfipwWRW00XKV3npDo3dOLNH2ViRoHV38CDfrggKvnSkXp3kBwZcopkPSsuPrJdxiiFvnmv5KjzDp1w9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtGcnHti; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10628C433F1;
	Fri,  8 Mar 2024 15:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910369;
	bh=K47phgkDZNLRQ1Cerqn/YO0B/e7+sDQNzjKODd9H+eo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=ZtGcnHti66X/DljK+xp8+Cd7ys/5i3rMLmiURoCflEE3GePKT0Z5XCpcHkEWLs1oG
	 l2/zXlaH3ynKhWz7s5fN0pXOd/f8v0VjWaXd4ghd+5By67oeb7T6liJreLN0cqlfNS
	 Abi/LsQnbjVR61DwaUiSINWDmISKRm8znQbuQd1gVGeCEOkrvGDktE/wdt8YQy+CuF
	 fF8oj5dH+AM6Nr1OQeE7qdpjjUTulsKLAk/RgcksjUep6G+03Ubrf2bEGDPBUx6hoT
	 S/tBIjkKPN5yxcCks1DvM5QBRqSk+BhtAm+X7EzvGxbQk6urXbWJGn3L4n9tz6G+s0
	 gpMVGaxjKstaQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix soc_dp_stats debugfs file permission
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240305-fix-soc_dp_stats-permission-v1-1-2ec10b42f755@quicinc.com>
References: 
 <20240305-fix-soc_dp_stats-permission-v1-1-2ec10b42f755@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170991036603.1311983.8197697439450200231.kvalo@kernel.org>
Date: Fri,  8 Mar 2024 15:06:07 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently the soc_dp_stats debugfs file has the following permissions:
> 
> # ls -l /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
> -rw------- 1 root root 0 Mar  4 15:04 /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
> 
> However this file does not actually support write operations -- no .write()
> method is registered. Therefore use the correct permissions when creating
> the file.
> 
> After the change:
> 
> # ls -l /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
> -r-------- 1 root root 0 Mar  4 15:15 /sys/kernel/debug/ath11k/pci-0000:03:00.0/soc_dp_stats
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

fa645e663165 wifi: ath11k: fix soc_dp_stats debugfs file permission

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240305-fix-soc_dp_stats-permission-v1-1-2ec10b42f755@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


