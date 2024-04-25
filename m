Return-Path: <linux-kernel+bounces-158036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D18B1A76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DFA1C21E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9693D0AF;
	Thu, 25 Apr 2024 05:53:34 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A543A1AC;
	Thu, 25 Apr 2024 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024414; cv=none; b=lh1KH0psS9IkNTEdMkH8IrPDZkTQ6xIJt6cc8pTFp7KyW3jMNlMB7pWyDyNqUCo6HdD/bMhDg9RvOPXGD72gfv2RyPB/Z0GYm7/k+/OEDfVK9UGlN7/gAs8SgyocmDAOHWQxXDvcA3wmTJ2COJz8NAabc9OwxfSMwyqqxGRPacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024414; c=relaxed/simple;
	bh=YYMOVp91SuvwZom2roKDYAG4LLwyceiJnfUnRkom83Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OV6QOLEj8rlUB6L6a8CYSuQJJAy/uzrqCzlT3RG7IrNKA2Zi8bCo94w86dux9AY+/vtSCd5e81k8A64aRn4ltvynvX+34tt3zeIT07Yx9+LTwP3NeZv3YcYmjkABPqnTeg8ZqDjlUvA9bH0ds9lww772xJwerY/UkK4hjdK9/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43P5qs0433233565, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43P5qs0433233565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 13:52:55 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 13:52:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 13:52:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 25 Apr 2024 13:52:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>
CC: "leit@meta.com" <leit@meta.com>,
        "open list:REALTEK WIRELESS DRIVER
 (rtw89)" <linux-wireless@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Topic: [PATCH wireless] wifi: rtw89: Un-embed dummy device
Thread-Index: AQHalnSYD4Tb/iMnEk2tnRSMUSm6/rF4e3YA
Date: Thu, 25 Apr 2024 05:52:54 +0000
Message-ID: <f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
References: <20240424182351.3936556-1-leitao@debian.org>
In-Reply-To: <20240424182351.3936556-1-leitao@debian.org>
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

I think this patch should go via net-next tree, because wireless-next tree
doesn't have patch of dummy devices yet.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw89/core.c | 11 ++++++++---
>  drivers/net/wireless/realtek/rtw89/core.h |  4 ++--
>  drivers/net/wireless/realtek/rtw89/pci.c  |  6 +++++-
>  3 files changed, 15 insertions(+), 6 deletions(-)
>=20
> PS: This is compile-tested only due to lack of hardware.

I picked this patch to local net-next tree, and tested on RTL8852BE, RTL885=
2C
and RTL8922AE.

Tested-by: Ping-Ke Shih <pkshih@realtek.com>



