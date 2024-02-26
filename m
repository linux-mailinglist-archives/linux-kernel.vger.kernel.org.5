Return-Path: <linux-kernel+bounces-80372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC83886677A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35D3281195
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECC6D518;
	Mon, 26 Feb 2024 01:18:35 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2863B1;
	Mon, 26 Feb 2024 01:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708910315; cv=none; b=dmvWBApX1Qw+Dxde1tcXD5sZzy22OHeK6vuSa5h3lBP2kprAJczbItRZsgpEn+NhAPCm02pZn4Eflgyr9WtetwM8h+UxBdg8NcjCA7Zq8KW3HcMnqrqGA+7cLg6pKeqz3Ix829fTbz0Gkzc5Y+IvnjfJOJ6DG71zOO/7dowsCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708910315; c=relaxed/simple;
	bh=zgFi5HFXIGLekCnyN5/QrVsmTT6G3lncBn0Sub7vMT0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IM/nmUNpioyLGRHU5Sd/zn9loGHqCumX+XuefzURWVcqG3OJ99H80UiyKLRe4F5doxfcKx9nT+jyzqfUnOfImerzSLDDbJjw62u+Pq++Uj/rE78409wVj/0B0aueQQU2Nw2jYC2hEuAuuOywfo1wgEcnFHcISAdnlnMXW7xRauU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41Q1I5NQ03370148, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41Q1I5NQ03370148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 09:18:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 26 Feb 2024 09:18:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 09:18:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 26 Feb 2024 09:18:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shiji Yang <yangshiji66@outlook.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_aifs()
Thread-Topic: [PATCH] wifi: rtl8xxxu: fix mixed declarations in
 rtl8xxxu_set_aifs()
Thread-Index: AQHaZl1h2HbwH7TQQEG2gknoSwbFfrEb1M2g
Date: Mon, 26 Feb 2024 01:18:05 +0000
Message-ID: <f281e9b6073143e7912f5d9ddb6ee217@realtek.com>
References: <TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB03157A408E0D69F2F6FBD88ABC552@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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



> -----Original Message-----
> From: Shiji Yang <yangshiji66@outlook.com>
> Sent: Friday, February 23, 2024 9:35 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 linux-kernel@vger.kernel.org;
> Shiji Yang <yangshiji66@outlook.com>
> Subject: [PATCH] wifi: rtl8xxxu: fix mixed declarations in rtl8xxxu_set_a=
ifs()
>=20
> Moving struct ieee80211_sta *sta variable definition to the front
> of the code to fix the ISO C90 forbids mixed declarations and code
> warning.

I suppose there will be no this kind of warnings after
the commit b5ec6fd286df ("kbuild: Drop -Wdeclaration-after-statement") sinc=
e
v6.5. But as commit message mentioned --=20
" It will still be recommeneded to place declarations at the start of a
  scope where possible, but it will no longer be enforced."
Then, this patch looks good to me.=20

>=20
> Fixes: 43532c050f8e ("wifi: rtl8xxxu: support multiple interfaces in set_=
aifs()")
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>



