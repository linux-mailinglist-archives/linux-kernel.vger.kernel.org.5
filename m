Return-Path: <linux-kernel+bounces-6435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462678198C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0440B287A9E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353F13FF5;
	Wed, 20 Dec 2023 06:48:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0F6171AE;
	Wed, 20 Dec 2023 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK6lpqL7532004, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK6lpqL7532004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:47:52 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Dec 2023 14:47:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Dec 2023 14:47:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 14:47:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Su Hui <suhui@nfschina.com>, "kvalo@kernel.org" <kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH wireless-next 01/11] wifi: rtlwifi: add calculate_bit_shift()
Thread-Topic: [PATCH wireless-next 01/11] wifi: rtlwifi: add
 calculate_bit_shift()
Thread-Index: AQHaMki42VUjo40x+EmO6M2GdlhuqrCxuxhA
Date: Wed, 20 Dec 2023 06:47:51 +0000
Message-ID: <a8f4058de59540eda8ab7acd08ad0cb9@realtek.com>
References: <20231219065739.1895666-1-suhui@nfschina.com>
 <20231219065739.1895666-2-suhui@nfschina.com>
In-Reply-To: <20231219065739.1895666-2-suhui@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
> From: Su Hui <suhui@nfschina.com>
> Sent: Tuesday, December 19, 2023 2:57 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: Su Hui <suhui@nfschina.com>; linux-wireless@vger.kernel.org; linux-ke=
rnel@vger.kernel.org;
> kernel-janitors@vger.kernel.org
> Subject: [PATCH wireless-next 01/11] wifi: rtlwifi: add calculate_bit_shi=
ft()
>=20
> There are many same functions like _rtl88e_phy_calculate_bit_shift(),
> _rtl92c_phy_calculate_bit_shift() and so on. And these functions can
> cause undefined bitwise shift behavior. Add calculate_bit_shift() to
> replace them and fix undefined behavior in subsequent patches.
>=20
> Signed-off-by: Su Hui <suhui@nfschina.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtlwifi/wifi.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wi=
reless/realtek/rtlwifi/wifi.h
> index 31a481f43a07..5d842cc394aa 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
> @@ -3069,4 +3069,11 @@ static inline struct ieee80211_sta *rtl_find_sta(s=
truct ieee80211_hw *hw,
>         return ieee80211_find_sta(mac->vif, mac_addr);
>  }
>=20
> +static inline u32 calculate_bit_shift(u32 bitmask)
> +{
> +       if (WARN_ON_ONCE(!bitmask))
> +               return 0;
> +
> +       return __ffs(bitmask);
> +}
>  #endif

Basically, this patchset is to change from below example to above one.=20

static u32 _rtl92d_phy_calculate_bit_shift(u32 bitmask)
{
       u32 i =3D ffs(bitmask);

       return i ? i - 1 : 32;
}

And, bitmask is expected not 0, so all are fine to me.=20
(I don't reply all patches one-by-one to bother people)

Ping-Ke


