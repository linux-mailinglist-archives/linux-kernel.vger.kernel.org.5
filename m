Return-Path: <linux-kernel+bounces-31433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABDD832E4F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEF5B21A41
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5151755E7A;
	Fri, 19 Jan 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLQGOxdf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738A41C98;
	Fri, 19 Jan 2024 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686215; cv=none; b=PpuAsnZ+C1VGFkf0OdRldxioEnLNATka6K1PK4vAGlTvCrXSCYqyDRwigBeCnT2wi+Hx3Y+fXX7g75vESh/up65bsLjKpVN/4wMRE8OCvB4nEAppti0FV/87hhJh0ibHWBtV2vJdO4Io1aiwQHNQn5aCt0qrgReKWVtZ+QjSAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686215; c=relaxed/simple;
	bh=8eib39R3f1kc8kZCT64S7x3ik4cRTqlb2P5ftC04SY0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TX1z1HEoU7VjpdeWzTDY3yVy/wmRS5MU7pJf+IKYKsxpch1mD1MLCbSTIf9YfFvOWr3iYjPrrqtPS7H6JC8dF3V7fZoCsDqUD0zZNDjohvY9+km3yt2jGNHNuCVeXJ9EJlBEOAJLy2AovZZCQcz15trgvaKBPLtl55GDj0raMdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLQGOxdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BBAC433C7;
	Fri, 19 Jan 2024 17:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705686215;
	bh=8eib39R3f1kc8kZCT64S7x3ik4cRTqlb2P5ftC04SY0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fLQGOxdf0pd1ILAovZrADoSukz1u0fMOgHcOvR2D0IaQZB/vsFSZGuX6sc2WVA618
	 iFkFWomAN8lfPQgG2QpQzPUYqU1L4Bp75diIbL46zygESfJX+iSKqe5F19dwvlH8I/
	 TvMddAMfwC5IaA+gHyro/WPhYpb6krnppGISim+IzMnVVKVNQ5M3Qc6HOLhjUn1noX
	 p3y35GfQFKlfzuVC9ycXRuYe6cYLw/WQmgvsrhH/YTRtfLwEgnjgx5vPO8WA9E+qpO
	 VsGXYpVSo2UcohIg8uiTaOzIJMlbkQQHXOj/BSpuMKxsd8PV33/XD4anmR/soCp1t1
	 O9sXKSzEO7tYQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: ath10k: add missing wmi_10_4_feature_mask
 documentation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240118-ath10k-kerneldoc-v1-1-99c7e8d95aad@quicinc.com>
References: <20240118-ath10k-kerneldoc-v1-1-99c7e8d95aad@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath10k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170568621204.3238594.1557348320781318513.kvalo@kernel.org>
Date: Fri, 19 Jan 2024 17:43:33 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently kernel-doc reports the following issues:
> drivers/net/wireless/ath/ath10k/wmi.h:3033: warning: Enum value 'WMI_10_4_EXT_PEER_TID_CONFIGS_SUPPORT' not described in enum 'wmi_10_4_feature_mask'
> drivers/net/wireless/ath/ath10k/wmi.h:3033: warning: Enum value 'WMI_10_4_REPORT_AIRTIME' not described in enum 'wmi_10_4_feature_mask'
> 
> Update the kernel-doc for enum wmi_10_4_feature_mask to add the
> missing documentation.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

5 patches applied to ath-next branch of ath.git, thanks.

1779487e72e0 wifi: ath10k: add missing wmi_10_4_feature_mask documentation
5f813b0447fe wifi: ath10k: correctly document enum wmi_tlv_tx_pause_id
75dd17fdef11 wifi: ath10k: fix htt_q_state_conf & htt_q_state kernel-doc
c80cc5cfefba wifi: ath10k: Fix htt_data_tx_completion kernel-doc warning
f020c3029932 wifi: ath10k: Fix enum ath10k_fw_crash_dump_type kernel-doc

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240118-ath10k-kerneldoc-v1-1-99c7e8d95aad@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


