Return-Path: <linux-kernel+bounces-2545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFC815EB2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DCF282CF9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD131A9E;
	Sun, 17 Dec 2023 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkHZ+kMD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6C18ED8;
	Sun, 17 Dec 2023 11:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92137C433C8;
	Sun, 17 Dec 2023 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702812321;
	bh=TmnrD4vc0nBG8oADqeg7z4TLXQC5wn/RLZ+koydjQZU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IkHZ+kMDsKcCB9CNMWFkeohhONco+WX37vTFyfbrsFR+I2zS5aG5xPiSxFqskcd9t
	 YNDChQtobblkG44+bOrlyPjCsa83j2JIyuhLU94qND+Pl+VBIEx0VTyMcLvDeAsfto
	 A13wv+TumMOApSm9nUv/i/mN/C57bKcxY846+pocLLdWExfngjz41c4gpv6ZWsexim
	 nKPRc1k1Ug89qcCJbnEBF1F6xaUwi2H9G8oDMAiJAGFyZGP5qhIGreeDVh6ox1kY7/
	 gvR6aB8Rh9CH7bcTc38NIps195/RZnP6keoAoD60QH3uHnnMYGOlTio35PfKiPcuV9
	 d9Lpl8iwT+gRg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
To: Hector Martin <marcan@marcan.st>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 Daniel Berlin <dberlin@dberlin.org>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Hector Martin <marcan@marcan.st>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
Date: Sun, 17 Dec 2023 11:25:18 +0000 (UTC)

Hector Martin <marcan@marcan.st> wrote:

> Using the WSEC command instead of sae_password seems to be the supported
> mechanism on newer firmware, and also how the brcmdhd driver does it.
> 
> According to user reports [1], the sae_password codepath doesn't actually
> work on machines with Cypress chips anyway, so no harm in removing it.
> 
> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
> patchset [2].
> 
> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Neal Gompa <neal@gompa.dev>

Arend, what do you think?

We recently talked about people testing brcmfmac patches, has anyone else
tested this?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


