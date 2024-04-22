Return-Path: <linux-kernel+bounces-152766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C27368AC3FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E35282A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0FF18C38;
	Mon, 22 Apr 2024 06:02:37 +0000 (UTC)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D498175AB;
	Mon, 22 Apr 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713765757; cv=none; b=LjGbs1udaqeVHEkg/8xgJ9eFoTJkKEP+zoMcnr0cYUvEgKCv1SlT1vjiQaEtvb10gITC0G0dizN6t9yu84iA7luJ6IfklQi1pwZjuu8+B8XZegN6vGEeRHvezqcTuzKoB+iCrdaFyoz3QyvyJLoIPlAGjhTG+DjkRK6IjSdCQRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713765757; c=relaxed/simple;
	bh=AJRjSxRJ+P5vsQS7ccNJkFMoIeeqauCdm7Wr4+3xWyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HOpvbZqn0xgIdMOmh/YC12yKAIZfkXjmp8023pLynhIm55nJBaMj9lL5paXHWA1bF2Xw5kptv4WugQCJ3zyxVyYh8JhcEPbq766hL1SqcVAzxs3laMJWWd6QjmqPK+TM7MmHqQbYbCqloIjHKtpPLXURFs3Iu9/ZMURlrS2qteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M62E3D03953822, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M62E3D03953822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:02:14 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 14:02:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 14:02:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 22 Apr 2024 14:02:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: RE: [PATCH] wifi: rtw89: Remove useless else
Thread-Topic: [PATCH] wifi: rtw89: Remove useless else
Thread-Index: AQHalHkJ1VGeiWLcV0S1xT409BU1hbFzyjGQ
Date: Mon, 22 Apr 2024 06:02:14 +0000
Message-ID: <cb9af3b7db9c464b80fbde62ec57f18e@realtek.com>
References: <20240422055022.33388-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240422055022.33388-1-jiapeng.chong@linux.alibaba.com>
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

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> Subject: [PATCH] wifi: rtw89: Remove useless else

Please point out the stuff like functions you are changing.=20

>=20
> The assignment of the else and if branches is the same, so the else
> here is redundant, so we remove it.
>=20
> ./drivers/net/wireless/realtek/rtw89/phy.c:6406:2-4: WARNING: possible co=
ndition with no effect (if =3D=3D
> else).
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D8812
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/wireless/realtek/rtw89/phy.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wirel=
ess/realtek/rtw89/phy.c
> index eaa18140d1a8..ca5a098c30a4 100644
> --- a/drivers/net/wireless/realtek/rtw89/phy.c
> +++ b/drivers/net/wireless/realtek/rtw89/phy.c
> @@ -6403,10 +6403,7 @@ enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct =
rtw89_dev *rtwdev,
>                         return RF_D;
>         case MLO_0_PLUS_2_1RF:
>         case MLO_2_PLUS_0_1RF:
> -               if (phy_idx =3D=3D RTW89_PHY_0)
> -                       return RF_AB;
> -               else
> -                       return RF_AB;
> +               return RF_AB;

The PHY configures to corresponding MLO modes are complicated, so RF people
always add branches of phy_idx to prevent missing something, and this is
intentionally to say two cases are identical. It is fine to apply your patc=
h,
but please add a comment to note that, like

/* for both PHY 0/1 */

>         case MLO_0_PLUS_2_2RF:
>         case MLO_2_PLUS_0_2RF:
>         case MLO_2_PLUS_2_2RF:
> --
> 2.20.1.7.g153144c
>=20


