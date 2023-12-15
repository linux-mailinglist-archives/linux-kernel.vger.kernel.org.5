Return-Path: <linux-kernel+bounces-1008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A005814925
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCECB1F22C09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD052E650;
	Fri, 15 Dec 2023 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LawAyRwb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8022E416;
	Fri, 15 Dec 2023 13:25:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3086AC433C8;
	Fri, 15 Dec 2023 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702646702;
	bh=B5mkdMwDaQnB5bTZYj5vwz6563xv3c52j7DWyphB6cs=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LawAyRwbtZyiJinItWdg5oqA+kTvzO/zDaHNJlTc2h3afd9+46Mc3U1lhG3esm6Ju
	 mVUKEN/6aWhESjTIytVCyFK5FrRHhowwfbiZUC8E4+P4yn7pVgzziNPvyXQtiU/cs7
	 7ts539n6An9ir5y5jObk8x2tm6WwSxvy4OwKCjQeKRQhKh+x5OTdmpntrntBQoMABU
	 ETAHDbbdiEF1JLngVJnkSz/cKAPJItYWOEP1+Sv1fL3qwWVcO97svD+PESMsdj0PHu
	 bRjS1NiVKJE2lVPrypIm0jKIxwMfleDx7zH3cBX2S/4fdXZwc7H/L3hdkPPzZBR1C9
	 hkRFdQZo8drPw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: mwifiex: configure BSSID consistently when starting AP
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231215005118.17031-1-yu-hao.lin@nxp.com>
References: <20231215005118.17031-1-yu-hao.lin@nxp.com>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 briannorris@chromium.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 David Lin <yu-hao.lin@nxp.com>, stable@vger.kernel.org,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rafael Beims <rafael.beims@toradex.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170264669803.1759617.3948805099666949892.kvalo@kernel.org>
Date: Fri, 15 Dec 2023 13:25:00 +0000 (UTC)

David Lin <yu-hao.lin@nxp.com> wrote:

> AP BSSID configuration is missing at AP start.  Without this fix, FW returns
> STA interface MAC address after first init.  When hostapd restarts, it gets MAC
> address from netdev before driver sets STA MAC to netdev again. Now MAC address
> between hostapd and net interface are different causes STA cannot connect to
> AP.  After that MAC address of uap0 mlan0 become the same. And issue disappears
> after following hostapd restart (another issue is AP/STA MAC address become the
> same).
> 
> This patch fixes the issue cleanly.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 12190c5d80bd ("mwifiex: add cfg80211 start_ap and stop_ap handlers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Tested-by: Rafael Beims <rafael.beims@toradex.com> # Verdin iMX8MP/SD8997 SD
> Acked-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-next.git, thanks.

f0dd488e11e7 wifi: mwifiex: configure BSSID consistently when starting AP

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231215005118.17031-1-yu-hao.lin@nxp.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


