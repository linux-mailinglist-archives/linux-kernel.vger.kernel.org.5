Return-Path: <linux-kernel+bounces-61908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11828851837
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A71D0B21F58
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00EA3C689;
	Mon, 12 Feb 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwWqQJK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CEE3B791;
	Mon, 12 Feb 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752212; cv=none; b=eYsJ5iiQ5uMucxznCXeNPBPoJo0XAqSFAD+JgLb8tV0PJwZ+YNO60difiNtj0T3HsOT/w2PXXqq1cOvlws8IhurjAszKhzPN8HSu68a7p4y8c/NgHe0ZjMnxRQI7XaWAo9pt/dfZVHC/EpRA2E2lmfyvzeMR9Qcu2lCliQlRt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752212; c=relaxed/simple;
	bh=/pb9BPyH4MQQj8AvjyK1GMvwFPDBbdG33B/k3t8+I/s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=prDgUZs+zagtw1eFhOVEFE6TTnYaz8Y1wmemdsYtZeg7FyfQB+CRbGGho7SEFeK5AgnDTuBTOlw2mlJChkAcEfNWBdw2xMSx3vl7tCZ4QMcI/9T1p4rLIpLxbUuyu/OsYLxYaJ8uLly80ScntlGA8RGxG+XivZnLYjmtdD5fecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwWqQJK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D8EC433F1;
	Mon, 12 Feb 2024 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752211;
	bh=/pb9BPyH4MQQj8AvjyK1GMvwFPDBbdG33B/k3t8+I/s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=TwWqQJK1cR8ZmTol+Wlsan7mo8yYS9OBr/1poAq4mZfQqFuD2KkSih1rp/OxbhDHJ
	 57txoko7imYBsuIRb9opcvtKXhFa7vyoy5aYVqAv+GGDjSWY/NPqzOHdY6WkewuvWO
	 pOeYVJUTSnW2bwbnaOH5jbs6THf7gAtQZUD2op5tcFxnzDmF0mGIa1hmrkuzx+B2oG
	 siXghZ+9edviemQtNWf/GG9lPOGMCnoIM4GCZd+S6aCrN9aJVjwLcur1ukaumk05pG
	 +vpU87DsuQ5PlmeoPZMqzFzb/JJzPLLCC00AiZ/XfjcirQwNLIF3c/uLjUAI4vOnYU
	 Wk15SebMyGB8w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [1/5] wifi: wilc1000: set preamble size to auto as default in
 wilc_init_fw_config()
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
Message-ID: <170775220812.2851594.12759275174081089304.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:36:49 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> WILC driver currently applies some default configuration whenever the firmware
> is initialized, and sets the default preamble size to short. However, despite
> this passed option, firmware is also able to successfully connect to access
> points only using long preamble, so this setting does not really enforce short
> preambles and is misleading regarding applied configuration.
> 
> Update default configuration and make it match the firmware behavior by passing
> the existing WILC_FW_PREAMBLE_AUTO value (2 instead of 0). The updated setting
> does not really alter firmware behavior since it is still capable to connect to
> both short preamble and long preamble access points, but at list the setting now
> expresses for real the corresponding firmware behavior.
> 
> More info: it has been implemented to address the transmission (Tx) blackout
> issue observed in the 802.11b mode. The modification has no impact on the other
> modes, which will continue to work as they did in the previous implementation.
> This change will allow the 802.11b transmission (2, 5.5, 11Mbps) to use long
> preamble.
> 
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

a8e5fefa9123 wifi: wilc1000: set preamble size to auto as default in wilc_init_fw_config()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


