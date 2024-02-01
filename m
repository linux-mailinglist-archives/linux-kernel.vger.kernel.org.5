Return-Path: <linux-kernel+bounces-47480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E661844E78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8264294218
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F2215E9C;
	Thu,  1 Feb 2024 01:10:25 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDBFBFA;
	Thu,  1 Feb 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749824; cv=none; b=I+QRV7bbp8FpnSwcApRG4f5H4XuR2NJ29FD4x9xXm140NN2jffADQLQVC/g5PohmVlM5LZF95McKQmaeuZe1agYfOvWLDdo/7ilKX+gmdZaRRshnnLRruEkC+myAqYysVurh09PNCTnrWwM6/M4z+SELAy1ROwEOS/44Zyp+s3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749824; c=relaxed/simple;
	bh=oXyZ94HQjIDlcU47fwE4bXXm8+FGbxZrkGWQO9/D9rM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lEG+xnYC0LMSoH3hzcE/jAxFwY2C9QLswNV0EK3lgP63yCjz4MjSy+8Fsfu0bd/LYQK3ta8dEXRKyvv2eJ0AChqjnP77J96bs9W1G5bcHFVJHY52EsS1q6WWKhu9C7TQ91fkWMEO5pWlx3pj04mGL+oYfZ/KXqfOkQcvuiwVmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41119nYoA1198478, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41119nYoA1198478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 09:09:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 1 Feb 2024 09:09:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 09:09:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 1 Feb 2024 09:09:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Martin Kaistra
	<martin.kaistra@linutronix.de>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtl8xxxu: fix error messages
Thread-Topic: [PATCH] wifi: rtl8xxxu: fix error messages
Thread-Index: AQHaVBSKyusWX7FLnUifv/dz8Jm+y7D0rgxQ
Date: Thu, 1 Feb 2024 01:09:49 +0000
Message-ID: <05fc965bb66746d196c2da08a0455fdf@realtek.com>
References: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
In-Reply-To: <7b144531-a8da-4725-8911-9b614a525a35@moroto.mountain>
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



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, January 31, 2024 3:10 PM
> To: Martin Kaistra <martin.kaistra@linutronix.de>
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.k=
ernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH] wifi: rtl8xxxu: fix error messages
>=20
> The first parameter of WARN_ONCE() is a condition so this code will end
> up printing the function name instead of the proper message.
>=20
> Fixes: 3ff7a05996f9 ("wifi: rtl8xxxu: support setting bssid register for =
multiple interfaces")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>


