Return-Path: <linux-kernel+bounces-166770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF68B9F50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0182862A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD76B16FF31;
	Thu,  2 May 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjQrSC/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0913415E7F4;
	Thu,  2 May 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670033; cv=none; b=LE6suu6OanDurHstwWEIHcy1z+79+iKo0kmdzdE5DOumsRNt8sZCjcOLbPJcvlcaQFOZ6XKK9vvl1mqbf5cl3qk25sCdyyulidofR9zHuZAIXTLCZW2uJLhGiStCc96tueje1IMG75JMzcxrYdnt1JRNcrw45sAYf/POHXFEDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670033; c=relaxed/simple;
	bh=mEB1gRELdQnLF3NedpdthFU8hdoEXluhSN19HDNaTrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ueaHqd7SOxDrhxeb0Q1LM9hn+8MFarT+OQRpU9Fyb8gAC9BZ9SareDHtuuAqSsKRepTz9Z33XeYojVoCvFA6xBxiCOWSIiAiu3ezfV5Z3VzLGypXug6TE7/Sqv+xex7wUCyzkcfWNNd9C7j3TsDmKuVo19dxJar3YNzDJ4huJDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjQrSC/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EFAC113CC;
	Thu,  2 May 2024 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670032;
	bh=mEB1gRELdQnLF3NedpdthFU8hdoEXluhSN19HDNaTrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SjQrSC/pQ/NzYQi6sjZmmhaSFW2jaK9JBtL/Pp1TyjA+qh6dd40EzBHKsf5mp5V8k
	 lFa2C5sOhi3TBK6F1V+pu8Tav3o101aFwCmBb6/7i31py4vXFQBddsyd/q2SWlEKXJ
	 FgwlUeAT/RNFftUQ6x2isiDRf/Ix8raPqgpI6LiCydT/oxVea3kAH9XajS88S8jW1f
	 F0juaSyrgIFQNsLe/lAFdZqmNOhsDmsaS53Ej1R/JULwHuMTQugD94sQBDStU3ZJTj
	 X3rgf143EwgfhAOJUEcK89IlWC+UkwPvhBxLi8Rd/GWrPW5lKglzRH6LFnIbFd5O8V
	 sz9JEHFnTPkQg==
From: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
References: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] leds: mt6370: Remove an unused field in
 struct mt6370_priv
Message-Id: <171467003040.1220105.4821265051022211211.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:13:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sun, 28 Apr 2024 20:27:31 +0200, Christophe JAILLET wrote:
> In "struct mt6370_priv", the 'reg_cfgs' field is unused.
> 
> Moreover the "struct reg_cfg" is defined nowhere. Neither in this file, nor
> in a global .h file, so it is completely pointless.
> 
> Remove it.
> 
> [...]

Applied, thanks!

[1/1] leds: mt6370: Remove an unused field in struct mt6370_priv
      commit: f2994f5341e03b8680a88abc5f1dee950033c3a9

--
Lee Jones [李琼斯]


