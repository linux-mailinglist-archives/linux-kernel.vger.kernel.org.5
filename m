Return-Path: <linux-kernel+bounces-159877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B376B8B3560
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185CDB21882
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DB91422C6;
	Fri, 26 Apr 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sF+2+kM/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F970548FD;
	Fri, 26 Apr 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127765; cv=none; b=Lw7S/9diOCyKVV0F8clLcFfDq9Ev7sA3ewFz87IiYloIbA4LdiXRN8qjyoW6Llyt/etTbuO+wKh3g5dRClowpbr4i3WPceuY7g2iMb6nQBRIwSynAeQ+JEy0lUO7YY2egW50F9U4WHiEtV8geQ1YkbDp1p1Y7TsLLI2V/dQBZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127765; c=relaxed/simple;
	bh=5GbSiISWqXdxMOYUKun0/blFRS45P1mdzUfrz6DdkJg=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=teg7kUlLOtmIdozeoHz4iDEPb5QQS1VMAuuJpWpNjGtPfRm75TNApWEIu03VmDv95bp4Dlxkdrhrc56GnLwPSjqiAox8GqDHoVufSsGaiKZpi4XB9+PO3vcDIM6YcSv1mGMhrTfLhw7VzSygjqEc2b19DHesdiDApG+WDTv1K4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sF+2+kM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A483C113CD;
	Fri, 26 Apr 2024 10:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714127765;
	bh=5GbSiISWqXdxMOYUKun0/blFRS45P1mdzUfrz6DdkJg=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=sF+2+kM/vFG9jzWULCXQng2/XkOSD/JemoeosZOe5W8ALNHW9RI63aMoQ0NWYN/UD
	 OPQFKDUdej+HXwoQkevYJKZ/hpsGNXLHg3qAOMJI2h7rUmV2DcpCS0w9T8J5YHNjyd
	 Isvp+lUN0B/ztREZCsEYnrZqovMB0TvEV1kWaYE3mRj7ncEmV6bDRufq4sh15EhFO0
	 V1uMpJdR1GQ6Yv5PvwwMkU6nfTRzE2nHGQpNHP1lJ7LGz7SFiwGabnns348avTwcTQ
	 yu+2menCctwat50Rsc3UEihdit/ZfxgYbM2z5NDo5mIZuSFzrhjvyOBu7i2OOi0uxl
	 gitIrfEc7tA7g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmsmac: ampdu: remove unused cb_del_ampdu_pars
 struct
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <fa3b190b6e9cba65ecc36fc93121c6ed8704f704.1714036681.git.christophe.jaillet@wanadoo.fr>
References: 
 <fa3b190b6e9cba65ecc36fc93121c6ed8704f704.1714036681.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171412776163.3463676.6942143016366715125.kvalo@kernel.org>
Date: Fri, 26 Apr 2024 10:36:03 +0000 (UTC)

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> struct cb_del_ampdu_pars was added in the initial commit 5b435de0d7868
> ("net: wireless: add brcm80211 drivers") and its only usage was removed in
> commit e041f65d5f00 ("brcmsmac: Remove internal tx queue").
> 
> Remove the structure definition now. This saves a few lines of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

931c98463082 wifi: brcmsmac: ampdu: remove unused cb_del_ampdu_pars struct

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/fa3b190b6e9cba65ecc36fc93121c6ed8704f704.1714036681.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


