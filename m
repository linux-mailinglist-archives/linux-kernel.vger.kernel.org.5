Return-Path: <linux-kernel+bounces-159378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F38B2DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5DC1C2176D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE8D3C0D;
	Fri, 26 Apr 2024 00:14:51 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EE723D2;
	Fri, 26 Apr 2024 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714090491; cv=none; b=jYjiUoCOIsBdA78rjzon9uA/ujCltH+trRPOv6ioL+05MEBy53IdOmtD5DYvaemLyZN+SEDMSEcO7Qs6AyH3dOqF+Q5B5X4VqeybEyR8FmNUSEIW6FcXEU15GU3ebPm2+0rtaDdzGbzY7LyHmLiWCIH3xqdX29sFRXlvIA0MSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714090491; c=relaxed/simple;
	bh=k6r6drPt42lh8qpYpj0tsTFHtAdn/42+65bkXtdamYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWKirnJyWC722i2dRDhEd+RJrHfwLD39ebKwGv84/SJcUQ9tuedEPxFWhHqV+zSnpJ+VKzcV5Wd0XFdPRcScLnKS6agFYBrldqJ8LwXtSJyjdnXBjZc1QPD8w7wRAezccMZOTytz6bTO05uwrfDq2bc0asHZYdNVucYQtrabx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q0EMX504051500, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q0EMX504051500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 08:14:22 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 08:14:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 08:14:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Apr 2024 08:14:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>
CC: "leit@meta.com" <leit@meta.com>,
        "open list:REALTEK WIRELESS DRIVER
 (rtw88)" <linux-wireless@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless-next] wifi: rtw88: Un-embed dummy device
Thread-Topic: [PATCH wireless-next] wifi: rtw88: Un-embed dummy device
Thread-Index: AQHaluqxs0A3huoTc0exV7lwy789V7F5rk7g
Date: Fri, 26 Apr 2024 00:14:22 +0000
Message-ID: <a581c6216456468e8695af38c985973d@realtek.com>
References: <20240425082910.2824393-1-leitao@debian.org>
In-Reply-To: <20240425082910.2824393-1-leitao@debian.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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

Breno Leitao <leitao@debian.org> wrote:
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
>=20
> Un-embed the net_device from the private struct by converting it
> into a pointer. Then use the leverage the new alloc_netdev_dummy()
> helper to allocate and initialize dummy devices.
>=20
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Like patch of rtw89, I will take it to my tree weeks later.

> ---
>  drivers/net/wireless/realtek/rtw88/pci.c | 17 +++++++++++++----
>  drivers/net/wireless/realtek/rtw88/pci.h |  2 +-
>  2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> PS: This is compile-tested only due to lack of hardware to do better
> testing.

Tested with real hardware RTL8723DE and RTL8822CE.=20

Tested-by: Ping-Ke Shih <pkshih@realtek.com>



