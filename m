Return-Path: <linux-kernel+bounces-150382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B3B8A9E44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5769E1C20F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AF16C6A3;
	Thu, 18 Apr 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJydt1Ou"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F515F321;
	Thu, 18 Apr 2024 15:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453863; cv=none; b=O4nzB6w0zHK9WWHLHuYQ/asBDU77gpDg7w/63plDiLfwA7ZTQNh6uJhGOXpb1NK431mT9kZF5UxJmk9rp54CvRG2n/+xNAQAl+CGlKtSnvkhmquTHkDtPtqN5vqEvFCj8o1nm4SyFmQjBGY4I4s5RmHeeTMuwWPbYZg3U19hZSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453863; c=relaxed/simple;
	bh=NCl35dkygku/r+9zzLNuYwTBleJeS28WvmRvBVpg6K8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rlgytYe1dVveTwW9GSU4ddEAZDXSqN6HM5ywjmlLMA0FVnC6wiI/TS+kAAQGahkAAfKObjJfYzy9Lbn+4C75VljDmALkhM/U8x7S5Lbd5b/o+5tMK2ffuZ5EcWsnhku32wxE5fjJC9s+h6YHQFsX5jXjGHDrmlcI4T4a/ntmMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJydt1Ou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0D6C113CC;
	Thu, 18 Apr 2024 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713453863;
	bh=NCl35dkygku/r+9zzLNuYwTBleJeS28WvmRvBVpg6K8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=gJydt1OuhDV2MDECYFzpdaXA5OfvutdSf38I+pW2T1wbOeGDYWHL0s7kMcWEw3He6
	 WQBk147gdj6S9XjirxQo+TksQcXPWNdvRUVOkMDxwlz/jw+akLLF9+mUm5FTvXRWd+
	 NFw0eZ7+IVHyHqPyIFLqJ8bijT8kKXRjlyZSLwYiUA7R4478ZbreBGmQdL1QXcvFTk
	 JMRioTPypeLC6E6jf0vGaMmQzkFL7KeCuHUNv/ggNEBZug/kthyHpZ+iaBEvIY+Yhd
	 jKJcbgupKRc8Zvs55G5ao7XiBosX4Pgt8r3bBjQWU0hKiSBfCSUgj5Tc8RrECX4d3U
	 7KI+F87mqesug==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: don't use %pK in dmesg format strings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240416-pk-v1-1-2c8852743e6d@quicinc.com>
References: <20240416-pk-v1-1-2c8852743e6d@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171345386046.934743.6076422265444894161.kvalo@kernel.org>
Date: Thu, 18 Apr 2024 15:24:21 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently, when debug logs are enabled, messages such as the following
> are found in the kernel log:
> 
> event mgmt rx skb         pK-error len 209 ftype 00 stype 50
> 
> The "pK-error" comes from using %pK to display an skb address in an
> interrupt context.
> 
> Per the guidance in the current "printk-formats" documentation, %pK
> "is only intended when producing content of a file read by userspace
> from e.g. procfs or sysfs, not for dmesg."
> 
> So replace %pK with %p in all of the ath12k_dbg() format strings.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2372c6d28032 wifi: ath12k: don't use %pK in dmesg format strings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240416-pk-v1-1-2c8852743e6d@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


