Return-Path: <linux-kernel+bounces-161312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB648B4A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912411C20AEA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58FB524A5;
	Sun, 28 Apr 2024 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="Wy6F5Sr6"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA175EED0;
	Sun, 28 Apr 2024 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714290585; cv=none; b=X77BZPVIS0kXAiFmaxH02T2YjghCbGAeywpJ8H1gzEobDGb6QBLi5DN9CSuZYch8JSaU9F0UxRSiZCa+mFpe1/IaGBU0dtFZZSxu+ZjUDTiwuiaZjrjCZc+0BvHd9yUvsCBQ0pAZ7PRDlbnOdJdur8Wj4z2Gs5aa0qfaD9D9ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714290585; c=relaxed/simple;
	bh=m7V7jvHgvsuWFgkI820O4oM2C5WDF0vNx8t+WNKqojg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGtOknIRExyOlKn2/xyrgn1InLHfnHuQfLP4Y2eoyslMhUmMu2Ew8y4N8MexmXx256gRu5o+JbDFaIorsqq5ySAmIIzSBEtLS21ao+kA/K9Zgy0A9Dmd+ZqpC8TCSVdVdU8v+EvyRGwAl4l3OMiCqlzrqdidIAb1k1pO7Aub6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=Wy6F5Sr6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714290563; x=1714895363; i=s.l-h@gmx.de;
	bh=JrYx2aaiStWZAeMooKfC3gS1mrOiBTegFz+AD3MqFbU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Wy6F5Sr6Klm92xnP6l4H601R+sLvYUVEGd8JjJrDSXy32CmbkcLMjt+9Ca0vzwfl
	 EnyH1QG0Tg9t9E0Eay4z0mzkSyjDm5FrdFLEzPnXwgFTienpIzjn1R5ISZEh3XC39
	 i36Zd+p18F0hEt8/zJdDV2EldvX83mRXcXTQTg3rR5KiZllLVSlP5D2yKc+sqZZp9
	 P2EyOZP4ahGRjJkq90Yzf8Q5D7/G05yxIbm5WG0D1MvOuh36K1M9u9WdBcTWx6F5A
	 3RTmQrMQsIpeavBT46+HdNPPD1SpQI+tS2yMa1nkqm2DIvKwNFRZkrmKLdcrxJ4T+
	 UgcJBoaCDRU0+1lVkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1sKPr13HPV-00Q9xC; Sun, 28
 Apr 2024 09:49:22 +0200
Date: Sun, 28 Apr 2024 09:49:16 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Wu Yunchuan
 <yunchuan@nfschina.com>, Johannes Berg <johannes.berg@intel.com>, "Breno
 Leitao" <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] wifi: ar5523: enable proper endpoint verification
Message-ID: <20240428094916.3d1e92b8@mir>
In-Reply-To: <20240428090404.2d300255@mir>
References: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
	<171406032921.2967849.6111681305541795423.kvalo@kernel.org>
	<87a5lhh1t0.fsf@kernel.org>
	<20240428090404.2d300255@mir>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7+/7J/CfzSJnvSF8fGnmSQ4nBXqQFCojEvCxXEd1GPgo9Sfz6Jb
 SuACmvALwBlupqSnAqTYtz0oEIYbVPC5heCTa/mXQ2tUX5i0shlDIzfXznXePe7CUVymJS5
 BdY7rehVy/B6jtqCpgyItJxsPqr7t5tHafGk05Q1jfMYdu1X9+akP52XKX5Y6z06a/nyV3i
 u6vKmJTdinqKJR1DKMpsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IB7ICdqf8UI=;B14qGQxYfS+CXf8sXT82BagxjAM
 z8N5q9jYyQdyDe5m6Qq/jtSDuGFdWrWkxiQc4yBejjGFDwlQJlNLCvl0lxN7hDNu3JvKvaaRn
 bjEfN7y3TszTd2HT9pSt7X+Yo5+q71Trium3cNyB5ZCH3+cFzQsfVurhSuj3TBkS0Mefw/X8d
 isuurXATiF1RIGHkvRHVA6flRulRQAJknBkwk/KStxZUNleND4uIapP3Lopyg1wMKRpJjG/P1
 dheUBz9QG6xwXyini2eZKGm+Xet1KPoyNtNC3HLQGhGwM6BeWMUIqoHtXiBTMlr2oWHtyScy9
 aCUpRKmwpJgWRVDDeoyksw1UjuSlr2HJu31meOdnSBy+4bXRB2cnLpvJ56aBJyQZPoBt6OC+j
 WFTwYGaU6i0igzQTuARlys4Mzq5L3go1XE6/1472yJqz7G2SzCI9ZXPxaCxbt7pCsbLz6jJYC
 ViiFuleaLefPF1ZHobtt7m8n6rei6P7K+m1SrlrIJmnKuDo9RxR23UcODIekOenEr5o7mCOit
 +1YxJm8Intx+mLPnGwHNZ1lLwKMhqT470kwvf4mAEwHcWi3g5u1RG40ep5yfJ0Sa/ajrYaMyO
 XUQSVVakQD1qkURdigryjdeBvz9Yng6HG0QlGlD3MishFmExBgM1TfYimbJAjEyZRGbLv7Zh7
 NT6k4gUdSZ/NIAtAOseuRejst3KNTLjFjYg/NSaK0tp1DqXpc7ayVh9s5G0tG+XKFwvjrqWVa
 pn5cCeQ0r2/GN7meDFMnQLO9p6QE9OsrBcjyA+be9O1hD9Ls7DdLAt9l/+Cpr8se3vcnQfcnt
 By+J7v5wKMROZ6a1b7AMb1RjihA9SH886gSdi2VOdhri0=

Hi

On 2024-04-28, Stefan Lippers-Hollmann wrote:
> On 2024-04-25, Kalle Valo wrote:
> > Kalle Valo <kvalo@kernel.org> writes:
> > > Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
> [...]
> > > Does anyone have a real device to test this? I have had so much prob=
lems with
> > > syzbot fixes in the past that I'm hesitant to take such patches with=
out
> > > testing.
> >
> > Actually should we just remove ar5523 driver? Has anyone heard anyone
> > using this driver still?
>
> While I'm not using it regularly, the driver does still work in plain
> v6.8.8 (and these Netgear WG111 and WG111T USB WLAN cards were quite
> common), tested against a qcn5024 AP.
>
> I'm just preparing a new kernel build with the proposed patch applied.

=E2=80=A6and now the same with this patch applied:

$ uname -r
6.9.0-rc5-gcc1380dd1882-dirty

wireless-next-2024-04-24-2112-gcc1380dd1882 with
https://patchwork.kernel.org/project/linux-wireless/patch/20240408121425.2=
9392-1-n.zhandarovich@fintech.ru/raw/
applied

[   22.303440] usb 1-5: new high-speed USB device number 5 using xhci_hcd
[   22.431672] usb 1-5: New USB device found, idVendor=3D1385, idProduct=
=3D4251, bcdDevice=3D 0.01
[   22.431678] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   22.431680] usb 1-5: Product: WG111T
[   22.431681] usb 1-5: Manufacturer: Atheros Communications Inc
[   22.431682] usb 1-5: SerialNumber: 1.0
[   22.537560] usbcore: registered new interface driver ar5523
[   22.686170] usb 1-5: USB disconnect, device number 5
[   22.935409] usb 1-5: new high-speed USB device number 6 using xhci_hcd
[   23.062746] usb 1-5: New USB device found, idVendor=3D1385, idProduct=
=3D4250, bcdDevice=3D 0.01
[   23.062762] usb 1-5: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   23.062767] usb 1-5: Product: WG111T
[   23.062771] usb 1-5: Manufacturer: Atheros Communications Inc
[   23.062775] usb 1-5: SerialNumber: 1.0
[   23.110548] usb 1-5: Cap: CAP_TARGET_VERSION=3D0x00000006
[   23.110837] usb 1-5: Cap: CAP_TARGET_REVISION=3D0x00000001
[   23.111146] usb 1-5: Cap: CAP_MAC_VERSION=3D0x00000008
[   23.111448] usb 1-5: Cap: CAP_MAC_REVISION=3D0x00000001
[   23.111739] usb 1-5: Cap: CAP_PHY_REVISION=3D0x00000046
[   23.112001] usb 1-5: Cap: CAP_ANALOG_5GHz_REVISION=3D0x00000046
[   23.112235] usb 1-5: Cap: CAP_ANALOG_2GHz_REVISION=3D0x00000000
[   23.112566] usb 1-5: Cap: CAP_REG_DOMAIN=3D0x00000000
[   23.112809] usb 1-5: Cap: CAP_REG_CAP_BITS=3D0x00000000
[   23.113120] usb 1-5: Cap: CAP_WIRELESS_MODES=3D0x00000000
[   23.113391] usb 1-5: Cap: CAP_CHAN_SPREAD_SUPPORT=3D0x0000001c
[   23.113663] usb 1-5: Cap: CAP_COMPRESS_SUPPORT=3D0x00000001
[   23.113912] usb 1-5: Cap: CAP_BURST_SUPPORT=3D0x00000001
[   23.114209] usb 1-5: Cap: CAP_FAST_FRAMES_SUPPORT=3D0x00000001
[   23.114480] usb 1-5: Cap: CAP_CHAP_TUNING_SUPPORT=3D0x00000001
[   23.114739] usb 1-5: Cap: CAP_TURBOG_SUPPORT=3D0x00000001
[   23.114987] usb 1-5: Cap: CAP_TURBO_PRIME_SUPPORT=3D0x00000001
[   23.115231] usb 1-5: Cap: CAP_DEVICE_TYPE=3D0x00000001
[   23.115538] usb 1-5: Cap: CAP_WME_SUPPORT=3D0x00000001
[   23.115804] usb 1-5: Cap: CAP_TOTAL_QUEUES=3D0x00000001
[   23.116081] usb 1-5: Cap: CAP_CONNECTION_ID_MAX=3D0x0000000a
[   23.116362] usb 1-5: Cap: CAP_LOW_5GHZ_CHAN=3D0x00000004
[   23.116614] usb 1-5: Cap: CAP_HIGH_5GHZ_CHAN=3D0x00001338
[   23.116889] usb 1-5: Cap: CAP_LOW_2GHZ_CHAN=3D0x000017d4
[   23.117123] usb 1-5: Cap: CAP_HIGH_2GHZ_CHAN=3D0x00000908
[   23.117387] usb 1-5: Cap: CAP_TWICE_ANTENNAGAIN_5G=3D0x00000001
[   23.117656] usb 1-5: Cap: CAP_TWICE_ANTENNAGAIN_2G=3D0x00000004
[   23.117906] usb 1-5: Cap: CAP_CIPHER_AES_CCM=3D0x00000001
[   23.118165] usb 1-5: Cap: CAP_CIPHER_TKIP=3D0x00000000
[   23.118429] usb 1-5: Cap: CAP_MIC_TKIP=3D0x00000000
[   23.118972] usb 1-5: MAC/BBP AR5523, RF AR2112
[   23.119638] usb 1-5: Found and initialized AR5523 device
[   23.127613] ar5523 1-5:1.0 wlx<MAC>: renamed from wlan0
[   79.014957] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:01 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.014962] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.047622] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:01 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.047635] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.050750] wlx<MAC>: authenticated
[   79.051329] wlx<MAC>: associate with 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.066715] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:01 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   79.067462] wlx<MAC>: associated
[   79.108615] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:01 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   79.459937] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:53 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.459941] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:53 (try 1/3)
[   81.468858] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:53 (try 2/3)
[   81.494179] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:53 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   81.494191] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:53 (try 1/3)
[   81.497337] wlx<MAC>: authenticated
[   81.499344] wlx<MAC>: associate with 9X:XX:XX:XX:XX:53 (try 1/3)
[   81.505833] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:53 (capab=3D0x10=
31 status=3D0 aid=3D1)
[   81.506372] wlx<MAC>: associated
[   81.543659] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:53 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   81.773371] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   81.773376] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   81.852279] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   81.852302] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   81.855407] wlx<MAC>: authenticated
[   81.857339] wlx<MAC>: associate with 9X:XX:XX:XX:XX:b1 (try 1/3)
[   81.869094] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:b1 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   81.869614] wlx<MAC>: associated
[   81.910697] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:b1 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   83.209701] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   83.209711] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   83.232421] wlx<MAC>: authenticated
[   83.233337] wlx<MAC>: associate with 9X:XX:XX:XX:XX:b1 (try 1/3)
[   83.240188] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:b1 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   83.240731] wlx<MAC>: associated
[   83.254365] wlx<MAC>: Limiting TX power to 20 (20 - 0) dBm as advertise=
d by 9X:XX:XX:XX:XX:b1
[   83.275542] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:b1 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   84.540669] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX53 (local address=
=3D0X:XX:XX:XX:XX:65)
[   84.540680] wlx<MAC>: send auth to 9X:XX:XX:XX:XX53 (try 1/3)
[   84.616128] wlx<MAC>: authenticated
[   84.617421] wlx<MAC>: associate with 9X:XX:XX:XX:XX53 (try 1/3)
[   84.622756] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX53 (capab=3D0x103=
1 status=3D0 aid=3D6)
[   84.623413] wlx<MAC>: associated
[   84.671424] wlx<MAC>: Limiting TX power to 20 (20 - 0) dBm as advertise=
d by 9X:XX:XX:XX:XX53

# wpa_cli -i wlx<MAC> status
bssid=3D9X:XX:XX:XX:XX53
freq=3D2437
ssid=3DXXX
id=3D2
id_str=3DXXX
mode=3Dstation
pairwise_cipher=3DCCMP
group_cipher=3DCCMP
key_mgmt=3DWPA2-PSK
wpa_state=3DCOMPLETED
address=3D0X:XX:XX:XX:XX:65
uuid=3DXXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX

$ iperf3 -c sawfly
Connecting to host sawfly, port 5201
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 39288 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   128 KBytes  1.05 Mbits/sec    2   1.39 KBytes
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    8   1.39 KBytes
[  5]   2.00-3.00   sec   128 KBytes  1.05 Mbits/sec    1   11.2 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   13.9 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   15.3 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   22.3 KBytes
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   29.3 KBytes
[  5]   7.00-8.00   sec   128 KBytes  1.05 Mbits/sec    0   34.9 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   34.9 KBytes
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   16.7 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   384 KBytes   315 Kbits/sec   11             send=
er
[  5]   0.00-10.00  sec   128 KBytes   105 Kbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c sawfly --reverse
Connecting to host sawfly, port 5201
Reverse mode, remote host sawfly is sending
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 54102 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   640 KBytes  5.24 Mbits/sec
[  5]   1.00-2.00   sec   768 KBytes  6.29 Mbits/sec
[  5]   2.00-3.00   sec  1.00 MBytes  8.39 Mbits/sec
[  5]   3.00-4.00   sec   896 KBytes  7.34 Mbits/sec
[  5]   4.00-5.00   sec  1.00 MBytes  8.39 Mbits/sec
[  5]   5.00-6.00   sec  1.12 MBytes  9.44 Mbits/sec
[  5]   6.00-7.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5]   7.00-8.00   sec   896 KBytes  7.34 Mbits/sec
[  5]   8.00-9.00   sec  1.00 MBytes  8.38 Mbits/sec
[  5]   9.00-10.00  sec  1.12 MBytes  9.44 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.21  sec  11.8 MBytes  9.66 Mbits/sec    0             send=
er
[  5]   0.00-10.00  sec  9.62 MBytes  8.07 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c sawfly --bidir
Connecting to host sawfly, port 5201
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 38694 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[  7] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 38704 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec    5   2.79 KByte=
s
[  7][RX-C]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec
[  5][TX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    4   2.79 KByte=
s
[  7][RX-C]   1.00-2.00   sec   512 KBytes  4.20 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    5   1.39 KByte=
s
[  7][RX-C]   2.00-3.00   sec   640 KBytes  5.24 Mbits/sec
[  5][TX-C]   3.00-4.00   sec   128 KBytes  1.05 Mbits/sec    3   1.39 KBy=
tes
[  7][RX-C]   3.00-4.00   sec  1.12 MBytes  9.44 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    2   4.18 KByte=
s
[  7][RX-C]   4.00-5.00   sec  1.00 MBytes  8.39 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    4   1.39 KByte=
s
[  7][RX-C]   5.00-6.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    2   2.79 KByte=
s
[  7][RX-C]   6.00-7.00   sec   768 KBytes  6.29 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    2   2.79 KByte=
s
[  7][RX-C]   7.00-8.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    2   1.39 KByte=
s
[  7][RX-C]   8.00-9.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    1   2.79 KByte=
s
[  7][RX-C]   9.00-10.00  sec  1.50 MBytes  12.6 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   128 KBytes   105 Kbits/sec   30           =
  sender
[  5][TX-C]   0.00-10.13  sec   128 KBytes   104 Kbits/sec                =
  receiver
[  7][RX-C]   0.00-10.00  sec  11.8 MBytes  9.86 Mbits/sec    0           =
  sender
[  7][RX-C]   0.00-10.13  sec  9.25 MBytes  7.66 Mbits/sec                =
  receiver

iperf Done.


Regards
	Stefan Lippers-Hollmann

