Return-Path: <linux-kernel+bounces-67242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C3856882
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861A71F229E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B810134733;
	Thu, 15 Feb 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pBAzmmSJ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41C1754B;
	Thu, 15 Feb 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012250; cv=none; b=J/BR1BAl5/84D02As2Cc0IsvDo+qClaP31AG08PPIT4WJaD99sPcPRlrkukSNVR1LRfcqS6VFMU2Jn5fyLyZ9ljnL6dkxrkNLOi7itpuq8N9C9EBVCPW3e8B1x5IZU2aUzui2OEJQZHiTi1Yz0UXmjxdMFElXvPFjf2Zu48D0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012250; c=relaxed/simple;
	bh=LggeN6h+WHY+0T/ae++CkDBWkvkomh6pdok7J2AYD5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjR243y+Okh91WdVHJOAVv3tNJI90HaPHT3uEf/r7vXi3ZzE2LI59BKF6z/a5/sTxTV7SG43JOCKMGqDH9brrEhPKxnEJvr8ktDozxS+f4pMK/UO82ZnV5Z04ZmML3rrbsX9lItdOFMobDb96Fjddv0bCJfEUzTi9b9K7XzSCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pBAzmmSJ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A11D60007;
	Thu, 15 Feb 2024 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708012241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtk48EznKmDX1rPnpNxOjf1ZSd+O3CpXHfHOgLG93Fs=;
	b=pBAzmmSJkIrrpIJCmMkXFXnnZuhytoqQDfJaAm7OvCfh1ZOEySWkDW33bzn32d82aX+A25
	8Y7cbAG6EqXMtDc53kf6t7tzT8ogGzFOuEqFH21ckm/vMOf6Cru83EWMYGYBtbkucF5+gX
	zAtyq8DGJxi57xI2fyuAB6KF4Pv9wzlUvbSXKKW1jFxFm/ngLQs9bN8a/nJbsqSv0h/E6K
	qKNQna6AHP+zyHtk1aAbmVIxrTazWmZ+9AUWf4eGoYt2ma3wtfxdOVLDHpUfEiipqdJqU8
	1T4XqNDFx/K7KuaNQIr4RJsiRxDdwuYImgyPgmsaiakzeciMOnR+BuHzDzZa8A==
Message-ID: <02c155ff-f880-4e88-b600-9d632019729f@bootlin.com>
Date: Thu, 15 Feb 2024 16:50:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: nl80211/wilc1000: force WLAN_AKM_SUITE_SAE to
 big endian in NL80211_CMD_EXTERNAL_AUTH
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ajay Singh <ajay.kathat@microchip.com>, Kalle Valo <kvalo@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, kernel test robot <lkp@intel.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240215-nl80211_fix_akm_suites_endianness-v1-0-57e902632f9d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 2/15/24 15:13, Alexis Lothoré wrote:
> This small series is the follow-up to discussions started around a sparse
> warning in wilc1000 driver ([1]) and implements the solution suggested by
> Johannes. It moves a historically needed conversion to be32 in nl80211 (in
> NL80211_CMD_EXTERNAL_AUTH, specifically on NL80211_ATTR_AKM_SUITES property
> _only_ when it is set to WLAN_AKM_SUITE_SAE) The user scenario affected by
> this update is a connect process on a WPA3-protected access point with
> authentication offloaded to user-space. Two drivers are affected by the
> update: wilc1000 and qtnfmac. wilc1000 case is handled by a small
> companion patch which also fixes the sparse warning.

Adding Claudio Beznea (co-maintainer for WILC), who got lost when I prepared the
series, sorry.

Also, my mail provider returns error 550 (No Such User Here) for quantenna
driver maintainer (<imitsyanko@quantenna.com>, taken from MAINTAINERS). I've
seen no recent activity from him on the ML, is he still around ?

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


