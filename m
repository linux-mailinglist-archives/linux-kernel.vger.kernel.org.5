Return-Path: <linux-kernel+bounces-159382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544008B2DEF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185F628349C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6702136A;
	Fri, 26 Apr 2024 00:20:56 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB6364;
	Fri, 26 Apr 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090856; cv=none; b=EPkHXQF4YjfTzRctuNUusHeg1tNHUgQ3TxLor3vkdAWVbZowa/dfjBzFvBtsSSIOWh0QHA2iKyvhuyDWTGtgXOfUSaJoNrn9krSD379uSKB9ZwaZtOsX7bR/xAiGRUDLnlAIagz/YbngyX3i2mVgp0+/GjttcvfCV3K583HXYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090856; c=relaxed/simple;
	bh=LVYsEBS61PY5DisTX6nFqmgQoBw+HKA77HUgzB8hCjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RgVUYpGXeduJ+mk02GgftXYl4O9NubdzuJtWDm303YJ0EWIf0EWvPkdXzWKgdupzVsVCGpnw3N65fFoRweru+6HKVEFx4eXwG4F0RePmjgeF2ltkAY7OmjbmQDsZIPvJ6NdVAc9fqFbxk5sLzYb0SCjAJH4jG0/Kd4ZrAZ7w7gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q0KhAoA4054930, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q0KhAoA4054930
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:20:43 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 08:20:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 08:20:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Apr 2024 08:20:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Su
 Hui <suhui@nfschina.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtlwifi: rtl8723be: Make read-only arrays static const
Thread-Topic: [PATCH][next] wifi: rtlwifi: rtl8723be: Make read-only arrays
 static const
Thread-Index: AQHalylMRWLX/GODyEmoXpDaRjEoYbF5sLdA
Date: Fri, 26 Apr 2024 00:20:43 +0000
Message-ID: <85f1d9807b1947099dc9b2e96dec63a3@realtek.com>
References: <20240425155733.114423-1-colin.i.king@gmail.com>
In-Reply-To: <20240425155733.114423-1-colin.i.king@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Q29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiBEb24ndCBw
b3B1bGF0ZSB0aGUgcmVhZC1vbmx5IGFycmF5cyBjY2tfcmF0ZXMsIG9mZG1fcmF0ZXMsIGh0X3Jh
dGVzXzF0IGFuZA0KPiBjaGFubmVsX2FsbCBvbiB0aGUgc3RhY2sgYXQgcnVuIHRpbWUsIGluc3Rl
YWQgbWFrZSB0aGVtIHN0YXRpYyBjb25zdCBhbmQNCj4gY2xlYW4gdXAgdGhlIGZvcm1hdHRpbmcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWls
LmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoN
Cg==

