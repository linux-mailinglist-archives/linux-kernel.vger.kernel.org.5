Return-Path: <linux-kernel+bounces-161294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8298B4A51
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3D62820E4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69650A6C;
	Sun, 28 Apr 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b="AdU3eBOm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFB02AF1D;
	Sun, 28 Apr 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714287876; cv=none; b=EX+WpE7qt4Bi0gD+G7XegUJrBoHGg/lzZn7XsGcTuyriD0pjQpQALKMGQSug1DLUI3qHnClq76sZLu+vdofVzMr4yUYXMi9BE/7KMmzZpx3DKAFwD3XWgt0z0Hl61ZKXt2NXrKiPR0Ns4NE/M5k06rkBHy+enydz1dxq6pJckJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714287876; c=relaxed/simple;
	bh=LY4f4zJhk0iQT/QVzV6bstlU1vcR/W/CDMW7g8gYJnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmNB0gx01FKK84BVUMD34MT4cf3eDSCtEHki7/O9l2lHIu6B3BeLXbCDBGqh23n3OOM8bPaGY79FoUYcXMpDB/uUKNyBCHYoUfTjblIIo4BsTlstoqa+PMoSb5FvzgX9vSMfNkKO5DPtS9cFfLPV6SUdzg8YZxk6omaUWqFPr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=s.l-h@gmx.de header.b=AdU3eBOm; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714287854; x=1714892654; i=s.l-h@gmx.de;
	bh=Q2OWwWgMhXVU65x1vGQbuEr/4YXlN5l4072z2iwRp5s=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AdU3eBOmBLt5oKHVMiYgbAaha6NQSDv7PqbV1AsVcDQeopV6Z6z4FGftnF/AmYdd
	 4mrdMO5zhMUFrqKHNSBuM4qJkRURBh6ebnYgrZKSMdLHIjtVCEmP0w6WiWXkOnKct
	 mHltPxrTL4X/E4snVns3UPlghKRijkZpTDwTfF9q1zHPhGX6vzclCX+KMsKMsV9GJ
	 Ti+LIcFgcxRXjkTo7aBNudk3F1TRq3W68hBOMVlfdu3Bn9FetknjOb095qxjSoGPm
	 REVObAxVOsGxKvs8sq4VSOT5XouqyhATi8J+CUF6GXqblk6Y6LIGa7X6Rb2QNU27h
	 C0QC08YasbnPQIZzuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.83.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgesQ-1sb7gI102e-00h2Dt; Sun, 28
 Apr 2024 09:04:14 +0200
Date: Sun, 28 Apr 2024 09:04:04 +0200
From: Stefan Lippers-Hollmann <s.l-h@gmx.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Wu Yunchuan
 <yunchuan@nfschina.com>, Johannes Berg <johannes.berg@intel.com>, "Breno
 Leitao" <leitao@debian.org>, <linux-wireless@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
 <syzbot+1bc2c2afd44f820a669f@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] wifi: ar5523: enable proper endpoint verification
Message-ID: <20240428090404.2d300255@mir>
In-Reply-To: <87a5lhh1t0.fsf@kernel.org>
References: <20240408121425.29392-1-n.zhandarovich@fintech.ru>
	<171406032921.2967849.6111681305541795423.kvalo@kernel.org>
	<87a5lhh1t0.fsf@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4gmO+zBDJxeZysSaFd0fB+Bh9NnTyXXtBwo+ZX9AZAVb5pD9iu2
 cl5jhtsaXK1RnDDVVMfjRZ3ELVZoIEA4M/PPAGATf6BWCZgX+SgK8m84nTQ1TJY2PmUw+IB
 JI1tCzETEY+0qnpT7OtLSEnAO5rh/9n9xMww//87T6/tzCEzC+Dr7ceyFbYCrLQSALHPvea
 fwKeQYJdxooheuVytxIQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sYyBQoSZoSY=;CAfyCaglsvcnevxmLFchAoVvn5P
 C8dljfs2HGciyuFxsdmHe/3qi5Tp8Cs3vgtrZXAd3DeC+GNnTNyapdLK+7o9hJlmTEAwN52iz
 sn9qcHy9MzjMlF4g7H0nLw7MCbwm1d1KfZsme+5O2AjdoLu/bLGZ9hV753GOCigpHz+U06rxZ
 SRsplIFn6utCcQf87Yd7OwNl5ZRmJvvINkYAqLiuEaKdvdUW9m07MWa/z26NBFSmde3CcdQDA
 5JRcNccl4W/nCx+WIv9Mxjb4qrImHfUn9+7GkziKXH6AHHVtqNDrKB3zyi4GUxjnUvUTLs5kW
 Ipnrsc6aRcVb9AEdiipb2SAXNEp8zHyjxHYim1NGRYSs8hrzOeuTCXK5VNKH77WSHxSIn7mOF
 czo7YbANNPOoX+Wbkm2Gaz8WEMxDHuvOaBDRwQ8KFXh+eF6CjZkYHD/sknD+Ry8ClPpNWZnrw
 HoD3iGx9kmcFSJKkEDuCu8iwSNpa7UvUoRqiA9ARlNzK4fG+RDKDseojGGkpjXb6MgfnUeDhU
 SMBObMJzQFyvpKjioL7W0iU6XB2TDKbV3qRML3MmU3XyVuRUUI0mkAnJF1JfKi3v82or0TmgG
 Ua/onnvqm3TB/7TLG8/zorwiKMFyDr9lvgKRFxw0VKX0k/zbzpcLDQAYU6tCZJDw5tjy02v2o
 0dx7dBFDJq8BxurMaFsGbZkezxBksLaDnwIQDUalV15yMr/VyjI/b9YXmR0bxiIXh2WyHXt19
 zA2uV8qftx4zFXTW60AqJUj9WawZ3frM7SctpqkCufbs9Wln7mED6Cp/Hmbs8XK9mv7zDPRLE
 VYlxD0tOZUkBltLtvXVlUB0b2az6NXXVWYohCeyGybGWQ=

Hi

On 2024-04-25, Kalle Valo wrote:
> Kalle Valo <kvalo@kernel.org> writes:
> > Nikita Zhandarovich <n.zhandarovich@fintech.ru> wrote:
[...]
> > Does anyone have a real device to test this? I have had so much proble=
ms with
> > syzbot fixes in the past that I'm hesitant to take such patches withou=
t
> > testing.
>
> Actually should we just remove ar5523 driver? Has anyone heard anyone
> using this driver still?

While I'm not using it regularly, the driver does still work in plain
v6.8.8 (and these Netgear WG111 and WG111T USB WLAN cards were quite
common), tested against a qcn5024 AP.

I'm just preparing a new kernel build with the proposed patch applied.

$ uname -r
6.8.8

[   54.027188] usb 3-5: new high-speed USB device number 5 using xhci_hcd
[   54.154514] usb 3-5: New USB device found, idVendor=3D1385, idProduct=
=3D4251, bcdDevice=3D 0.01
[   54.154531] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   54.154537] usb 3-5: Product: WG111T
[   54.154541] usb 3-5: Manufacturer: Atheros Communications Inc
[   54.154545] usb 3-5: SerialNumber: 1.0
[   54.262777] usbcore: registered new interface driver ar5523
[   54.411417] usb 3-5: USB disconnect, device number 5
[   54.660141] usb 3-5: new high-speed USB device number 6 using xhci_hcd
[   54.787463] usb 3-5: New USB device found, idVendor=3D1385, idProduct=
=3D4250, bcdDevice=3D 0.01
[   54.787478] usb 3-5: New USB device strings: Mfr=3D1, Product=3D2, Seri=
alNumber=3D3
[   54.787483] usb 3-5: Product: WG111T
[   54.787487] usb 3-5: Manufacturer: Atheros Communications Inc
[   54.787491] usb 3-5: SerialNumber: 1.0
[   54.835897] usb 3-5: Cap: CAP_TARGET_VERSION=3D0x00000006
[   54.836738] usb 3-5: Cap: CAP_TARGET_REVISION=3D0x00000001
[   54.836985] usb 3-5: Cap: CAP_MAC_VERSION=3D0x00000008
[   54.837269] usb 3-5: Cap: CAP_MAC_REVISION=3D0x00000001
[   54.837578] usb 3-5: Cap: CAP_PHY_REVISION=3D0x00000046
[   54.837828] usb 3-5: Cap: CAP_ANALOG_5GHz_REVISION=3D0x00000046
[   54.838114] usb 3-5: Cap: CAP_ANALOG_2GHz_REVISION=3D0x00000000
[   54.838364] usb 3-5: Cap: CAP_REG_DOMAIN=3D0x00000000
[   54.838635] usb 3-5: Cap: CAP_REG_CAP_BITS=3D0x00000000
[   54.838876] usb 3-5: Cap: CAP_WIRELESS_MODES=3D0x00000000
[   54.839138] usb 3-5: Cap: CAP_CHAN_SPREAD_SUPPORT=3D0x0000001c
[   54.839446] usb 3-5: Cap: CAP_COMPRESS_SUPPORT=3D0x00000001
[   54.839685] usb 3-5: Cap: CAP_BURST_SUPPORT=3D0x00000001
[   54.839954] usb 3-5: Cap: CAP_FAST_FRAMES_SUPPORT=3D0x00000001
[   54.840216] usb 3-5: Cap: CAP_CHAP_TUNING_SUPPORT=3D0x00000001
[   54.840467] usb 3-5: Cap: CAP_TURBOG_SUPPORT=3D0x00000001
[   54.840724] usb 3-5: Cap: CAP_TURBO_PRIME_SUPPORT=3D0x00000001
[   54.840975] usb 3-5: Cap: CAP_DEVICE_TYPE=3D0x00000001
[   54.841236] usb 3-5: Cap: CAP_WME_SUPPORT=3D0x00000001
[   54.841506] usb 3-5: Cap: CAP_TOTAL_QUEUES=3D0x00000001
[   54.841744] usb 3-5: Cap: CAP_CONNECTION_ID_MAX=3D0x0000000a
[   54.842039] usb 3-5: Cap: CAP_LOW_5GHZ_CHAN=3D0x00000004
[   54.842281] usb 3-5: Cap: CAP_HIGH_5GHZ_CHAN=3D0x00001338
[   54.842554] usb 3-5: Cap: CAP_LOW_2GHZ_CHAN=3D0x000017d4
[   54.842788] usb 3-5: Cap: CAP_HIGH_2GHZ_CHAN=3D0x00000908
[   54.843056] usb 3-5: Cap: CAP_TWICE_ANTENNAGAIN_5G=3D0x00000001
[   54.843343] usb 3-5: Cap: CAP_TWICE_ANTENNAGAIN_2G=3D0x00000004
[   54.843593] usb 3-5: Cap: CAP_CIPHER_AES_CCM=3D0x00000001
[   54.843851] usb 3-5: Cap: CAP_CIPHER_TKIP=3D0x00000000
[   54.844113] usb 3-5: Cap: CAP_MIC_TKIP=3D0x00000000
[   54.844677] usb 3-5: MAC/BBP AR5523, RF AR2112
[   54.845129] usb 3-5: Found and initialized AR5523 device
[   54.853451] ar5523 3-5:1.0 wlx<MAC>: renamed from wlan0
[   79.311092] wlx<MAC>: 80 MHz not supported, disabling VHT
[   79.314464] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:01 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.314472] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.365058] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:01 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.365073] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.368361] wlx<MAC>: authenticated
[   79.369488] wlx<MAC>: associate with 9X:XX:XX:XX:XX:01 (try 1/3)
[   79.376783] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:01 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   79.377789] wlx<MAC>: associated
[   79.412980] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:01 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   79.613018] wlx<MAC>: 80 MHz not supported, disabling VHT
[   79.618057] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:53 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.618068] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:53 (try 1/3)
[   79.672878] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:53 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.672885] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:53 (try 1/3)
[   79.675745] wlx<MAC>: authenticated
[   79.676415] wlx<MAC>: associate with 9X:XX:XX:XX:XX:53 (try 1/3)
[   79.682446] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:53 (capab=3D0x10=
31 status=3D0 aid=3D1)
[   79.683079] wlx<MAC>: associated
[   79.708364] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:53 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   79.913528] wlx<MAC>: 80 MHz not supported, disabling VHT
[   79.916480] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.916489] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   79.979005] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   79.979019] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   79.982175] wlx<MAC>: authenticated
[   79.983460] wlx<MAC>: associate with 9X:XX:XX:XX:XX:b1 (try 1/3)
[   79.990499] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:b1 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   79.991150] wlx<MAC>: associated
[   80.004037] wlx<MAC>: Limiting TX power to 20 (20 - 0) dBm as advertise=
d by 9X:XX:XX:XX:XX:b1
[   80.017058] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:b1 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   81.031824] wlx<MAC>: 80 MHz not supported, disabling VHT
[   81.036498] wlx<MAC>: authenticate with 9X:XX:XX:XX:XX:b1 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   81.036506] wlx<MAC>: send auth to 9X:XX:XX:XX:XX:b1 (try 1/3)
[   81.039194] wlx<MAC>: authenticated
[   81.040489] wlx<MAC>: associate with 9X:XX:XX:XX:XX:b1 (try 1/3)
[   81.047244] wlx<MAC>: RX AssocResp from 9X:XX:XX:XX:XX:b1 (capab=3D0x14=
31 status=3D0 aid=3D1)
[   81.047905] wlx<MAC>: associated
[   81.088917] wlx<MAC>: deauthenticating from 9X:XX:XX:XX:XX:b1 by local =
choice (Reason: 1=3DUNSPECIFIED)
[   82.086878] wlx<MAC>: 80 MHz not supported, disabling VHT
[   82.091343] wlx<MAC>: authenticate with aX:XX:XX:XX:XX:01 (local addres=
s=3D0X:XX:XX:XX:XX:65)
[   82.091351] wlx<MAC>: send auth to aX:XX:XX:XX:XX:01 (try 1/3)
[   82.101245] wlx<MAC>: authenticated
[   82.102400] wlx<MAC>: associate with aX:XX:XX:XX:XX:01 (try 1/3)
[   82.107565] wlx<MAC>: RX AssocResp from aX:XX:XX:XX:XX:01 (capab=3D0x14=
31 status=3D0 aid=3D2)
[   82.108175] wlx<MAC>: associated
[   82.196524] wlx<MAC>: Limiting TX power to 20 (20 - 0) dBm as advertise=
d by aX:XX:XX:XX:XX:01

# wpa_cli -i wlx<MAC> status
bssid=3DaX:XX:XX:XX:XX:01
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

$ iperf3 -c <remote_server_ipv6>
Connecting to host <remote_server_ipv6>, port 5201
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 47110 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   384 KBytes  3.14 Mbits/sec   14   13.9 KBytes
[  5]   1.00-2.00   sec   256 KBytes  2.10 Mbits/sec    8   13.9 KBytes
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.39 KBytes
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    1   18.1 KBytes
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   18.1 KBytes
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   23.7 KBytes
[  5]   6.00-7.00   sec   128 KBytes  1.05 Mbits/sec    0   23.7 KBytes
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   23.7 KBytes
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   23.7 KBytes
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    0   23.7 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   768 KBytes   629 Kbits/sec   23             send=
er
[  5]   0.00-10.19  sec   512 KBytes   411 Kbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c <remote_server_ipv6> --reverse
Connecting to host <remote_server_ipv6>, port 5201
Reverse mode, remote host <remote_server_ipv6> is sending
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 39628 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   768 KBytes  6.28 Mbits/sec
[  5]   1.00-2.00   sec  1.12 MBytes  9.44 Mbits/sec
[  5]   2.00-3.00   sec  1.12 MBytes  9.43 Mbits/sec
[  5]   3.00-4.00   sec  1.12 MBytes  9.45 Mbits/sec
[  5]   4.00-5.00   sec   896 KBytes  7.34 Mbits/sec
[  5]   5.00-6.00   sec  1.12 MBytes  9.43 Mbits/sec
[  5]   6.00-7.00   sec  1.38 MBytes  11.5 Mbits/sec
[  5]   7.00-8.00   sec  1.12 MBytes  9.44 Mbits/sec
[  5]   8.00-9.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5]   9.00-10.00  sec  1.50 MBytes  12.6 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.10  sec  13.6 MBytes  11.3 Mbits/sec    0             send=
er
[  5]   0.00-10.00  sec  11.4 MBytes  9.54 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c <remote_server_ipv6> --bidir
Connecting to host <remote_server_ipv6>, port 5201
[  5] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 38430 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[  7] local 2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX65 port 38446 connected to =
2aXX:XXX:XXXX:XXXX:XXXX:XXXX:XXX:XX01 port 5201
[ ID][Role] Interval           Transfer     Bitrate         Retr  Cwnd
[  5][TX-C]   0.00-1.00   sec   128 KBytes  1.05 Mbits/sec    6   4.18 KBy=
tes
[  7][RX-C]   0.00-1.00   sec   768 KBytes  6.28 Mbits/sec
[  5][TX-C]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec    7   1.39 KByte=
s
[  7][RX-C]   1.00-2.00   sec  1.00 MBytes  8.39 Mbits/sec
[  5][TX-C]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    3   1.39 KByte=
s
[  7][RX-C]   2.00-3.00   sec   896 KBytes  7.35 Mbits/sec
[  5][TX-C]   3.00-4.00   sec   128 KBytes  1.05 Mbits/sec    2   2.79 KBy=
tes
[  7][RX-C]   3.00-4.00   sec   896 KBytes  7.34 Mbits/sec
[  5][TX-C]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    3   2.79 KByte=
s
[  7][RX-C]   4.00-5.00   sec  1.12 MBytes  9.43 Mbits/sec
[  5][TX-C]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    3   1.39 KByte=
s
[  7][RX-C]   5.00-6.00   sec  1.38 MBytes  11.5 Mbits/sec
[  5][TX-C]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    3   2.79 KByte=
s
[  7][RX-C]   6.00-7.00   sec  1.25 MBytes  10.5 Mbits/sec
[  5][TX-C]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    3   2.79 KByte=
s
[  7][RX-C]   7.00-8.00   sec  1.38 MBytes  11.5 Mbits/sec
[  5][TX-C]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    2   2.79 KByte=
s
[  7][RX-C]   8.00-9.00   sec  1.50 MBytes  12.6 Mbits/sec
[  5][TX-C]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec    1   4.18 KByte=
s
[  7][RX-C]   9.00-10.00  sec  1.50 MBytes  12.6 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.00  sec   256 KBytes   210 Kbits/sec   33           =
  sender
[  5][TX-C]   0.00-10.06  sec   128 KBytes   104 Kbits/sec                =
  receiver
[  7][RX-C]   0.00-10.00  sec  13.8 MBytes  11.5 Mbits/sec    0           =
  sender
[  7][RX-C]   0.00-10.06  sec  11.6 MBytes  9.70 Mbits/sec                =
  receiver

iperf Done.

Regards
	Stefan Lippers-Hollmann

