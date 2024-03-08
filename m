Return-Path: <linux-kernel+bounces-97208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B708766FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43041F225CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631561DDFA;
	Fri,  8 Mar 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUir5kyG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBC1D554;
	Fri,  8 Mar 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910321; cv=none; b=tm4+1Jpcit27mbiIEZU0p97YOVk4NtPuhRUI03zdwGIGxLnxX60t0vfbz99NRm6V8onJFIic9zn+eXybqW01a4qVnAyCicy58TGlpQg3y8LDb6OtOIpLEpGT3TEO+F906CGfMNGbKWf1r1hlMJ24y8PSEBvRZCh2zGIWotKlmoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910321; c=relaxed/simple;
	bh=1aTSQmB1Lqtv6HfbXy1Dq/89Mka4eQAhumaOmfFiNkU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=OYWCwFS2i99IZYEmghhcuJ7HoebjgkWL3WU5CzEhPC21TJc/TxRgQD1udXAQas5qNA8etwQo4oAioOqf2Lx5WmlryJk6H6pYFBXvPU0S+751qqR+5znld/uySwh1jR5swSj5ibu8LSjfCYqGGBfUvc2JGaDArASBYX84wC6d5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUir5kyG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18664C433F1;
	Fri,  8 Mar 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910321;
	bh=1aTSQmB1Lqtv6HfbXy1Dq/89Mka4eQAhumaOmfFiNkU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=nUir5kyGcQbspwaN9XpW5B369zLkl25EvQJuKpupORo56ZvVNGifEyLIIYEiZKZce
	 KPGqYNNKfleDoIsfb0NOMQ6IEgFVwxXSFZCrVRZvuDiaKiHPNPnH8ONsgxB0fu4qmm
	 zsv3iwMqoI2WrbuwcQXv6JwGS3ZxhWQNdipv5t9SHBTLuNI1BNbdqNHIgxnmpB7m7T
	 iYnzVmFZBsLT84sZhEA1/XT+w1Hb1VMXN68ULYpIWcbyXtYDuoe2Mp3rEgzuar+lBD
	 jPS6fmPlcqhMRAechsHpfHfDKHXZW7YTdSlf66mEwUdEYO6GSyAK7Ja4895n3wTSFj
	 KBHBoPl7bQKKw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: remove obsolete struct wmi_start_scan_arg
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240226-ath11k-obsolete-wmi_start_scan_arg-v1-1-c0b94c6e191d@quicinc.com>
References: 
 <20240226-ath11k-obsolete-wmi_start_scan_arg-v1-1-c0b94c6e191d@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170991031809.1311983.16811598893372933463.kvalo@kernel.org>
Date: Fri,  8 Mar 2024 15:05:19 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> ath11k inherited struct wmi_start_scan_arg from ath10k. However, in
> ath11k, this struct is unused -- struct scan_req_params is used for
> this functionality. So remove the unused struct.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

8b9853048357 wifi: ath11k: remove obsolete struct wmi_start_scan_arg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240226-ath11k-obsolete-wmi_start_scan_arg-v1-1-c0b94c6e191d@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


