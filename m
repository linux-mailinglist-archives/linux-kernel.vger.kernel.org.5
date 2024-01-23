Return-Path: <linux-kernel+bounces-35214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B2838DD1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E5428AE13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ADF5D8F7;
	Tue, 23 Jan 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrEemFLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2E5D906;
	Tue, 23 Jan 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010426; cv=none; b=MJwawKsDYIp7k8wRD5iU2UVc0uMnDH5C6pMO+0okaXNYTdBpNKHm9aJ9t2TclgR9pB3OunXO2HxsW6NDQ3glolMoiXsrtFb6MTvUjYK5VWu9Bs7IWK9fnutRdhCmDfsbLcn135BeTvx55i9bsnxa129aCxUbphZWHgF5mPpw1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010426; c=relaxed/simple;
	bh=yyc0UBjK4EUFBLtUwuO/rwe82t1uGPWprWflRUnPq0c=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BBvEqDpSiVc5gh9+2eyJVL+aoBjbsNkSrXcajQUB0LpwTo1mwVcxyl9Ov9U4itZ/MsrvyMVXJ5PgpxTAy8RkZmOoRRcYoxIJv8ubWqdY5YYBK5yqkRkFyIO9kWqjPdwAZj9G5MqtJYh3f0EQOhlIOaFmWqSSENY2E3gS8cn36Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrEemFLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E8CC433C7;
	Tue, 23 Jan 2024 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706010426;
	bh=yyc0UBjK4EUFBLtUwuO/rwe82t1uGPWprWflRUnPq0c=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=HrEemFLRdXJWrzxmiy4hCQ4vp4pjIEjDTdRiPg4G8J/VQAYw8AcIHTPAqtNtu2O3w
	 yryVtlSEgRdHixuUkauNr+x6f/x0FBW+o04qdcqMBAGKqU7x3K1JD7U5vbb2CGxNIX
	 e6rIZ2cOrmfAybhhCg0TkSfjX8mQ75lJ5b/uZy0qCm0v+aWmTCPvyDhjYPYGGt82+i
	 4nJvzjqXdH0ppTI7VRzE3RCZ3mVp33Bxfo1gy4upZBdQ5rhOStyg6D1BnL5gkrwKd4
	 NMx2akrupbsOXNg8NcfAQKrW5e3KotnyIKoOS5uXw58J93dEyAEwQdpQJ2l3+d6WyS
	 LhHUaEMSiRiQQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for
 Broadcom WLAN
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240122184543.2501493-18-leitao@debian.org>
References: <20240122184543.2501493-18-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
 edumazet@google.com, Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, dsahern@kernel.org,
 weiwan@google.com,
 linux-wireless@vger.kernel.org (open list:BROADCOM BRCM80211 IEEE802.11n
 WIRELESS DRIVER),
 brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211 IEEE802.11n
 WIRELESS DRIVER), linux-kernel@vger.kernel.org (open list)
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170601042141.3962299.17995367561123702242.kvalo@kernel.org>
Date: Tue, 23 Jan 2024 11:47:03 +0000 (UTC)

Breno Leitao <leitao@debian.org> wrote:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Broadcom FullMac WLAN drivers.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Wireless patches should use "wifi: " prefix:

ERROR: 'wifi:' prefix missing: '[PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN'
ERROR: 'wifi:' prefix missing: '[PATCH net-next 18/22] net: fill in MODULE_DESCRIPTION()s for wlcore'
ERROR: 'wifi:' prefix missing: '[PATCH net-next 19/22] net: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx'

3 patches set to Changes Requested.

13526063 [net-next,17/22] net: fill in MODULE_DESCRIPTION()s for Broadcom WLAN
13526064 [net-next,18/22] net: fill in MODULE_DESCRIPTION()s for wlcore
13526065 [net-next,19/22] net: fill in MODULE_DESCRIPTION()s for wl1251 and wl12xx

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240122184543.2501493-18-leitao@debian.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


