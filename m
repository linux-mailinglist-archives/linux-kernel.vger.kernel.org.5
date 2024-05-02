Return-Path: <linux-kernel+bounces-165940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD698B93A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5411C21331
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E521AAD7;
	Thu,  2 May 2024 03:19:10 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9314292;
	Thu,  2 May 2024 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714619950; cv=none; b=BgKkCa53sC/OfYhQocu9ntiNAQzfcVQJcjVlGqJ/4Mc9/Kaim91xYUXSspY0js1zi9p7iVctgYLckbFJ0rQcJ+zqjMlOwcOwxfi0r/yZCLbqzGOTZBgeiPBQ97sfaD6as1LosIEVzOMEyIkuSgFPVrFEZksQeI3UTiOdK/VZ1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714619950; c=relaxed/simple;
	bh=ns/XDlQAITvMcfVm1pszbVe1D2/+KAbdo5UWjSlJtso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luEqVCPUFBEsAI1aUxyCuCvvHqOGED/4l1j8/bSIMZhKOfzu5jDDejrFoxpi2sp8abzLHS+bRV9bIcWqEh8FSX5YRasD9WVIP2Y6bvy3ELMryU4wBabeM0oAnbMB9m5pNYgu4vhyqNk3V3YphzWefjD0mFELE8MpUJqH0WQWwJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4423J2Zc82061968, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4423J2Zc82061968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 May 2024 11:19:02 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 11:19:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 11:19:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 2 May 2024 11:19:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings
Thread-Topic: [PATCH][next] wifi: rtlwifi: Remove unused structs and avoid
 multiple -Wfamnae warnings
Thread-Index: AQHanBi/DxB0vdBiBEWl5nZVbN0KOLGDRp4A
Date: Thu, 2 May 2024 03:19:02 +0000
Message-ID: <2ebbd858571e4358ad4d3dfd0ceb4b73@realtek.com>
References: <ZjLFIa31BGPVCGh1@neat>
In-Reply-To: <ZjLFIa31BGPVCGh1@neat>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
> ready to enable it globally.
>=20
> So, remove unused structs and fix the following
> -Wflex-array-member-not-at-end warnings:
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>



