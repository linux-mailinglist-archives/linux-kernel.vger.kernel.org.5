Return-Path: <linux-kernel+bounces-34798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5F83878F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 860DDB20D37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F5F50A6F;
	Tue, 23 Jan 2024 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcNXm8Y7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330150261;
	Tue, 23 Jan 2024 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991914; cv=none; b=DyMaq/J59oe5vTeWWwY0SlzWqhRhWz2giod5aJTKiBeSjwmFxfzRfv+RjZlKGZQd6PqFv81QsPqACo8MC5cKUa+FGtHb20sFig/S316TKQST9HZqmIZkONvFpL9IROEVTiF0qAB/ixeOIZJseixpkRlH7Aw24aE9sKBo1j0EatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991914; c=relaxed/simple;
	bh=N4WnIJh6bc8rJ/bQ3UvGO2EO8A+M8+YdgxuTN4SYook=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=q11Ro2i2ruj70tUn0OKLGZDPI6yFl3RjhU+CkNCeibxi5oPX11jQV4FZYnyMmVoT9ywsth/vEfDMEGYhKlBKsWu5Yf+9euz5GuNjjGNIkvTrOYCJgJkcpCFSRxDjo8WUMmjbak5F2xp9TkZU2h0DgGo/wW57lKk7lCNIShrcpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcNXm8Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB45C433C7;
	Tue, 23 Jan 2024 06:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705991913;
	bh=N4WnIJh6bc8rJ/bQ3UvGO2EO8A+M8+YdgxuTN4SYook=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pcNXm8Y7Qd/7ow9BvzhuEt9tWbOxfKqdgM4llKfmdRaGfcAH9Xf9LpwYgNbWwqCGD
	 1M6TyMTWrFBic4HEttNUptLuWxjGdFEUhZnY0ZOHdx5aUh6mFPq5WFneAudtNw4PEe
	 i01BPYJNvDbaGQ9FeMZEfEHaQddmvdX74nL0UfSYK7QFyc4mir2pWYHUXVs7SjSb3j
	 4jEwAspdy7vWre3XB+o9CpdMaojdYANz5DlYCRG8yeaIxBuzuwjog3cIrLS+qIDl+M
	 Qp6yMGz6dEK21I7B0mdgHIeW4f9y/LJ0VI6b5cAfIWQWVirB835CI8uvGVnZvy4cu6
	 f13OIBF2KyyeQ==
From: Kalle Valo <kvalo@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org,  davem@davemloft.net,  abeni@redhat.com,
  edumazet@google.com,  Arend van Spriel <aspriel@gmail.com>,  Franky Lin
 <franky.lin@broadcom.com>,  Hante Meuleman <hante.meuleman@broadcom.com>,
  dsahern@kernel.org,  weiwan@google.com,  linux-wireless@vger.kernel.org
 (open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER),
  brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
 IEEE802.11n WIRELESS DRIVER),  linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 17/22] net: fill in MODULE_DESCRIPTION()s for
 Broadcom WLAN
References: <20240122184543.2501493-1-leitao@debian.org>
	<20240122184543.2501493-18-leitao@debian.org>
Date: Tue, 23 Jan 2024 08:38:29 +0200
In-Reply-To: <20240122184543.2501493-18-leitao@debian.org> (Breno Leitao's
	message of "Mon, 22 Jan 2024 10:45:38 -0800")
Message-ID: <877ck0eeqi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Breno Leitao <leitao@debian.org> writes:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the Broadcom FullMac WLAN drivers.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c | 1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c | 1 +
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/module.c | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> index d55f3271d619..c1f91dc151c2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bca/module.c
> @@ -20,6 +20,7 @@ static void __exit brcmf_bca_exit(void)
>  	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_BCA, THIS_MODULE);
>  }
>  
> +MODULE_DESCRIPTION("Broadcom FullMAC WLAN BCA driver");

It would be good to spell out BCA. I don't even know what it means :)

> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/module.c
> @@ -20,6 +20,7 @@ static void __exit brcmf_cyw_exit(void)
>  	brcmf_fwvid_unregister_vendor(BRCMF_FWVENDOR_CYW, THIS_MODULE);
>  }
>  
> +MODULE_DESCRIPTION("Broadcom FullMAC WLAN CYW driver");

Same for CYW.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

