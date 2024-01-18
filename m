Return-Path: <linux-kernel+bounces-30129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B48319F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B2EB2298C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734225105;
	Thu, 18 Jan 2024 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5Varki2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3624B57;
	Thu, 18 Jan 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705583104; cv=none; b=stcRkhqB1+emP6oAEcYbHqKo9Ml3Zsn2sP6G6JR8bHzGZ9SknAB9/4iP0GTs+a8GdoQQLb3xLYohC5UpsKElA4yILCA2TCX0KN0rQBk83wnSqDkolPOU9lBtmQdRrDJQC1pfen9wbHMF9qJMK/HTSLdE+YPkaEz4G4APVCDAI2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705583104; c=relaxed/simple;
	bh=N0E3M1FXEk/M8+abhwlanetMGkMmya/Ds9xC17DAntA=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=MsrLJWQ1V6Pr5WletODLwnWYXhE42d3IqmRERWhTq1HuKkxBK2SeU0od4f7tY6f/9nr/FFDnQ2d9TXzZNEn/8DbXedIEODCi+7z8ayNheK89lk+xcYxsoS/9lg0E5WkC+1XKvXBrGIs4PQe2PB+aiSKnKxHTihr8G+OHUGGNKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5Varki2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE060C433C7;
	Thu, 18 Jan 2024 13:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705583104;
	bh=N0E3M1FXEk/M8+abhwlanetMGkMmya/Ds9xC17DAntA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=L5Varki2auyKh0ktZANIc+BPFQQa6dIJxVFhDdUzUz+Q2cuL5Bpmm0cEH/Fw0a/Y1
	 IN6wGdjYP/lP4X4/k8Uf6QsMBTy/fepkRMhtWSGTMWO+bARq0P2KrMUgRlR/VIOhWH
	 FWP/1DdUWENTxIkwYdaOboWhtrZ45/IFLdnhHOLFkmVMoTbwjDbAeKuvwHRLTSssYl
	 vcqBgWPUQmH6P1j6fxWcZWamtEU3L8ieSPPd9txwy4+3G//7FVTgyLebh1G9uTOvaJ
	 +TMsVnOjqodbeRVuduuo3Ot6uH76h6weEcMU7SZ105ulBNYEEHGtvGzUDg7URsMxsp
	 9f205sagdwHiQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: brcmsmac: phy: Remove unreachable code
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230814093621.289754-1-artem.chernyshev@red-soft.ru>
References: <20230814093621.289754-1-artem.chernyshev@red-soft.ru>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: Jonas Gorski <jonas.gorski@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170558309941.2924528.648376255659040623.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 13:05:01 +0000 (UTC)

Artem Chernyshev <artem.chernyshev@red-soft.ru> wrote:

> wlc_phy_txpwr_srom_read_nphy() in wlc_phy_attach_nphy() can not 
> return false, so it's impossible to get true value in this
> if-statement. Also change those functions return types to void
> since no one using it.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

Patch applied to wireless-next.git, thanks.

47f0e32ffe4e wifi: brcmsmac: phy: Remove unreachable code

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230814093621.289754-1-artem.chernyshev@red-soft.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


