Return-Path: <linux-kernel+bounces-29961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312938315D8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B449B1F28FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7FA1F93F;
	Thu, 18 Jan 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TusqEuOj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934191F5FF;
	Thu, 18 Jan 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570276; cv=none; b=pf8qcoP2TjR/l6D6kCTWDdOb25kfCrXJspjIO315+nv8qjyMRX7KRvRpYWe8tKP854yZF9nkxyoaF9OxmdjMRMTJNWVeUMFLFsnmLcQoRmM+wdsXpwcycdvHifwcHWhmNI9ZlmsmRjLO1i1DPpyy4OWeXvM4tfk5+4HFAHUFKIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570276; c=relaxed/simple;
	bh=3Ro5oDrOM89PXcFvsCKbt7YUP0R132LEtWDAKWQFa3U=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=JLtyMzLFjhqvMhMuNLeHLcvs5HTSysjPL0JJnmjtE4qLRIxoTdokFp9i8hr38D4hdaWR+Y4Uc8tV4xitW7kEXBUW5phf9aQSZedEvrWEJaJMF0nldLHM602ywQemGxrbuWo0PY7oNssklSQW9wuxVVoz7EZVXVjEjohnCYLwevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TusqEuOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F6E1C43390;
	Thu, 18 Jan 2024 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705570276;
	bh=3Ro5oDrOM89PXcFvsCKbt7YUP0R132LEtWDAKWQFa3U=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TusqEuOjSpvNpD3ixZ/hO2FutUweZUo2CdVZAQTGqwLlF7g+ep1f4JWs71ek9cKmG
	 OKEcMw+fIxv48HRaci9zNdbzgFbpcy+Znw5BpR6OzVa1Ug8x8fMYHs3a7qCOA4r6YE
	 9TXjo4t0e4vatc5O7T30+Dj8BR3xB0AjqNAyrfAHVh9sEtw+Wva/WIURxILRzbRyeS
	 VkHwwQmcipGM/l0hsJwecYp3mKArcf0+O7SZu2/Ip5TM7ch/3Pkv+EwptmDEhNyxDV
	 ZeoUDhAnVN1X8HwJPolvQAswm5bjUoUdpZr23uZ2FpLFS0l7KTXJt6E9s3P1kTLcT5
	 ox3pJCeTkFgNQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
References: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 David Mosberger-Tang <davidm@egauge.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:31:14 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Changed the default value preamble to WILC_FW_PREAMBLE_AUTO in
> wilc_init_fw_config().
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

The commit message should always answer to the question "Why?". I can add that
if you tell me what to add.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


