Return-Path: <linux-kernel+bounces-56692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C5184CDAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87E41F23C76
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244487F7C7;
	Wed,  7 Feb 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X20Otscc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE047E77F;
	Wed,  7 Feb 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707318473; cv=none; b=uJhQJFDqSEapsAVZU87qFLwdXvDjUe7ruZz64EwMUdd5WF/ZMBNiDbQb9zJLpNKyaMm/bi+KiQyppLsX55EFOorrPSFeP/ZFBjjtFL2m2BWRQkXvYB+qxJTZbJfjyPNVfHzX3HG8d4NEd8w5SaAQIZcj+qSAK0Jh8t+sAjPEPK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707318473; c=relaxed/simple;
	bh=e8ZPTLBiG4EhvRswyFxjA28H3ywaFhr8kyDAQdHgczI=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fdMcs7F/ISHl6SFd+XERTaxcnwv2xtkn+6TGgB1UeSAheUnCbUTsvEDuq1hE10ArY1tJe+YRr563YLz/OJ4pMQeT7vyOltz0ThJVYoYCqg17v20mYMQq0gih4S7gCWNZ6PScxmx0pzqewWp8TziAyB4xAjZ7huIWkIpn/hLCDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X20Otscc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2AC433F1;
	Wed,  7 Feb 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707318472;
	bh=e8ZPTLBiG4EhvRswyFxjA28H3ywaFhr8kyDAQdHgczI=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=X20OtsccAeo3DwMltzHcMivL6XbkHNDm0ibarOqcMOwUYdMbe17Jh/yl8QlKLBl0t
	 fmXyH09p0z7FNfqDL9iBpPygypzgeSOBML6U9HqjAfTV6rRvKdowrVJ1jWfvVCA71V
	 qYaRkNy12XFZCS7isZ4acuIAwTYY4NVYTEF2YOwh85jgx8HtDZEZfGayQXRtmpmUB2
	 OllkPBO9v6AgmbOQqGsQTkihfN4/iNQ5SGQVwlXKQdVhJLtsVtwf/6DrST25SCoQjm
	 UAsj/xGNWLv6G2KGQErmmZFySmp7QTkAfCZVSCx/wKOplJwfH9hOst2n3B4M1VnDo/
	 ptBQ+Jy/tZCwQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Really consistently use
 ath11k_vif_to_arvif()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240205-ath11k_vif_to_arvif-v1-1-7c41313c8318@quicinc.com>
References: <20240205-ath11k_vif_to_arvif-v1-1-7c41313c8318@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170731846999.2220494.5799872642523142596.kvalo@kernel.org>
Date: Wed,  7 Feb 2024 15:07:51 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Commit 9476cda44c13 ("wifi: ath11k: Consistently use ath11k_vif_to_arvif()")
> previously replaced all open coding of the ath11k_vif_to_arvif()
> functionality. Subsequently two more instances of open coding were
> introduced, one in commit 92425f788fee ("wifi: ath11k: fill parameters for
> vdev set tpc power WMI command") and one in commit 6f4e235be655 ("wifi:
> ath11k: add parse of transmit power envelope element"), so fix those as
> well.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d7a5c7cde2cb wifi: ath11k: Really consistently use ath11k_vif_to_arvif()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240205-ath11k_vif_to_arvif-v1-1-7c41313c8318@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


