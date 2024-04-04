Return-Path: <linux-kernel+bounces-131223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D298984CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038551C2144E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7876025;
	Thu,  4 Apr 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afcAcSgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAD1B7F4;
	Thu,  4 Apr 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712225463; cv=none; b=IcMX3r8HZGl4eZo7NJZAku35u9TSQrln2ur8ddx8ANwr89uheWCcJ3dhjiQXjXWtVJnkriaTLoOHc8MOCXGxuswM3sDugbQLgInSfyy0tI7XprTj/lO/NBOBwXwAosc62ncTpiG10Qq1hbOZBUJITalbHjO+C86ihHv+i5sXShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712225463; c=relaxed/simple;
	bh=2ICbELwnFGH+a0N7gJ1LBKZFvxxZnlHWv/8MCXufs+k=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=twxbFVe2B2lgUIZ0mLPj+J4wYdye1Wh5o3je+mS5HDZHayMJBWO8EzRtBiXY4A/mGlxoMCgnlwQmkwouEmRbCKEHnszL7WqB1r0fS/BOD2StDbaPC83x1kxBBF+uEvH9F/TV1+fB+U8FDZSwaA4bQECHYZ2TFFoU7H+7aJRy3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afcAcSgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D078C433C7;
	Thu,  4 Apr 2024 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712225462;
	bh=2ICbELwnFGH+a0N7gJ1LBKZFvxxZnlHWv/8MCXufs+k=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=afcAcSgjXrXmctBSAV8A90nVsSdGsh4iUp3glik9135/662NTYSgRfh4QL0ffe3ue
	 42eI70RY4kYnfBjI9nF8kWeHJCFSYGy/ZJVEnVHJ84wEG3PvRKL3Vb5KtgoFj4etML
	 BVfmxieaaj3LIecYBCiWMPtYKck/6qn7AEEUL+PVd1/duhbO5CMR/VvULehl7zY8aA
	 JRO2RE14PQkbcImPCQaSGhoMQPiJYhHe+Mv0WD3CUivKpG1YviUUQG0aEC5mkFHtc3
	 EDIL9KdnIlBr6oBEOE/MtRX2TdNfyHT9+araegpgK4dqEKErt1iwe1GtSB+USLr3Ov
	 eOk/L+Xu0Sn7w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: fix hal_rx_buf_return_buf_manager
 documentation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240329-hal_rx_buf_return_buf_manager-v1-1-e62ec9dc2af9@quicinc.com>
References: 
 <20240329-hal_rx_buf_return_buf_manager-v1-1-e62ec9dc2af9@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>, Jeff Johnson
	<quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171222545973.1806092.2233111780041686983.kvalo@kernel.org>
Date: Thu,  4 Apr 2024 10:11:01 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> kernel-doc flagged the following issue, so fix it:
> 
> drivers/net/wireless/ath/ath11k/hal.h:668: warning: missing initial short description on line:
>  * enum hal_rx_buf_return_buf_manager
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

68d1beaf3ebb wifi: ath11k: fix hal_rx_buf_return_buf_manager documentation
024c4ab0415f wifi: ath12k: fix hal_rx_buf_return_buf_manager documentation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240329-hal_rx_buf_return_buf_manager-v1-1-e62ec9dc2af9@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


