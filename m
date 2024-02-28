Return-Path: <linux-kernel+bounces-84935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3376286ADE7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647D41C20E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B74145351;
	Wed, 28 Feb 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvmBIxtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C0C130AFC;
	Wed, 28 Feb 2024 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120293; cv=none; b=F9y4DFXC2adCbTqMwowyiIEVJ/AFsZiwulKcqiD5pRuyDWmsKHESXWrJHiZP3pm4jRiUFCC0c2PwLrWisQIgaLzGAY2ZWekfGQvp+sckuPMAv1NRHsa30vusrz3FEpkJgUWS9ONq6M0qYNH6tn7K5+WeHGP7+ZsvmR+wUKJvxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120293; c=relaxed/simple;
	bh=I5yAhgbZLSun2xf7QlAHb8DWwr7otE2Ffvo7tBSEwOM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Q5dr29pnYuCHov4dvrWZ2Iyhe+EWWRpdGky0rtirG399bQ2vntOfY1eqPJht7+7TAFcGwdOLevi7ctl9bAhPLEgOIey/pQFYyg+gxKPGK5clUcxfzFkktiGsuJxcfdK6Hy/QT04yVymzmg2/LqE1mFIGXjgJpYAIjO8/TTujcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvmBIxtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34BDC433F1;
	Wed, 28 Feb 2024 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120292;
	bh=I5yAhgbZLSun2xf7QlAHb8DWwr7otE2Ffvo7tBSEwOM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=WvmBIxtNHoAkWNTil8JM7xuUS+kuOdReNgfC78lmo/ux2D+NS6boy90VYV+aRRnfi
	 qMzUpS4OoSBcZXXNeTTfSfPsfTMHHWJTDo11VdFlQgNvrD/gB6IBObTqv/mfw++8Pr
	 jxjstfUVNoAZFWHMztLJBri4C4+aGaWt4AAKPnt7l/3t488ToQD8evW7sAD93kMo0w
	 WIAysEpsclfKSGXIqNrQdJmWz6HWXEac7AYdlj3igeVZfa3snRq7yPkzEYtOEH/QQR
	 viY9A5VE9Rac6rhXwW2xDSU6YFCDkoRK4gDUFgEJh/R8gZG5ZZCISpMm1Ji18LW7nV
	 l3xLEqEUpb8YQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: fix mixed declarations in
 rtl8xxxu_set_aifs()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: 
 <TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-wireless@vger.kernel.org, Jes Sorensen <Jes.Sorensen@gmail.com>,
 linux-kernel@vger.kernel.org, Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912028951.3742961.9627228372705923099.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 11:38:11 +0000 (UTC)

Shiji Yang <yangshiji66@outlook.com> wrote:

> Moving struct ieee80211_sta *sta variable definition to the front
> of the code to fix the ISO C90 forbids mixed declarations and code
> warning.
> 
> Fixes: 43532c050f8e ("wifi: rtl8xxxu: support multiple interfaces in set_aifs()")
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

a7e178259c5b wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_aifs()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


