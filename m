Return-Path: <linux-kernel+bounces-7817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25D81ADA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517D51C2299D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75D63D5;
	Thu, 21 Dec 2023 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLme7CEZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758565239;
	Thu, 21 Dec 2023 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28ad7a26f4aso325187a91.0;
        Wed, 20 Dec 2023 19:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703130592; x=1703735392; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RO0C/qx0Z2G0L/Qx5cv4RD2VJ4wMeiv02dG05G53QD8=;
        b=bLme7CEZiv6A4fsfsWAqEAGNO78FUZhBCDklTPAy6b3RN6WqbVcgHNSWuKFlDllhK8
         5ayXH5ScIBe6wKixlrTJof1EqBd0B5np1LS3ht91RYCuMQCyhzV3KBfXqZhLizCIeHN0
         bBL9jDwvfeKBAGtie0Md+wHV7Z3/d2KjpH6W7asda8nVeumSUGnsKHU1b0AIuSMslSD7
         CmcxS9Vv5WgO5N9jK/sH5fjQq/Xxd5QXN7AsWTcJJ8buOeYQYBiSrHLUwipvM1nnPxVm
         u2qB/cYMd+ZShanEpJMcqxhrhauQ71oknRAfPdx852tbQdErQIV+VM3oza6dhDh58gte
         3rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703130592; x=1703735392;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RO0C/qx0Z2G0L/Qx5cv4RD2VJ4wMeiv02dG05G53QD8=;
        b=gZilb/MNTFFId9NwXQr5BhJKSD9VvGJgpU7z/sQbm//EQ6hWvTA08wWWSDOoGwWTWm
         fOkpApMp/5bE+DajbfZLlBnAAQgg36eoWhJ839u1dEmKGl1WMBkcD2bV1Zuj9Djg3s5z
         6FaWnWsPObZ7eQOkR/rqq22BpzFnHO4q96dMb2kJAsWJSq55nY3mxgTThhH1PLvrJSHV
         UJR+q0K4RD98Y+Q0nFexaI6MYNH7JkrUG77h6TNgXyrEUy6860TRmG4X0VhOzv5w8Vkf
         tqh4pHm4h/FaRHIm4EK8jMP8zCFdfmAMzOz8ieii2LxL7h2G0WMWkV5is4JVth+EHoFZ
         mPnQ==
X-Gm-Message-State: AOJu0YyC5csK1/3zuKJadaW3fBnuEHdXK8P7RWj9gq+Ydz0WqM/kjW3Z
	flB7LzigD20GePDlAhGxKeI=
X-Google-Smtp-Source: AGHT+IF58I5Cpilp72LVsymbFf/NlBPYQ1bhw+Lpf6NnacSyfEYM8AVL7rk/xFQQw56h4UhncnM0rw==
X-Received: by 2002:a17:902:eb91:b0:1d3:c3f0:463a with SMTP id q17-20020a170902eb9100b001d3c3f0463amr7474532plg.137.1703130591641;
        Wed, 20 Dec 2023 19:49:51 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001d34126d64dsm482952plh.222.2023.12.20.19.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 19:49:51 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CE1061024D796; Thu, 21 Dec 2023 10:49:45 +0700 (WIB)
Date: Thu, 21 Dec 2023 10:49:45 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>,
	Linux ath11k <ath11k@lists.infradead.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Evgenii Ilchenko <evgenii.ilchenko@protonmail.com>
Subject: Fwd: ath11k: QCNFA765: Bug with non-standard router setting.
 Crashes, terrible latensy and speed.
Message-ID: <ZYO12aX3RpWzWuDs@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N3Q2B03KdscU10Yb"
Content-Disposition: inline


--N3Q2B03KdscU10Yb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Bugzilla [1], Evgenii Ilchenko <evgenii.ilchenko@protonmail.com> (Cc'ed)
wrote ath11k bug report with his non-standard router setup:

> Hardware:
> Lenovo Thinkpad P14s (21K5001JUS)
> AMD Ryzen 7450u with Qualcomm QCNFA765 Wireless Network Adapter
> Router: Huawei HG8245X6-10
>=20
> Software:
> Debian Testing (trixie).
> Testing with 6.1.0, 6.5.0, 6.5.13 kernels.
>=20
>=20
> The problem is reproduced in the following environment:
>=20
> 802.11ax is turned off on the router.
> In this case, a lot of messages like this are printed to the logs:
>=20
> ath11k_pci 0000:02:00.0: Received with invalid mcs in VHT mode 11
> ath11k_pci 0000:02:00.0: Received with invalid mcs in VHT mode 10
>=20
> and:
>=20
> [   19.498035] ------------[ cut here ]------------
> [   19.498039] Rate marked as a VHT rate but data is invalid: MCS: 10, NS=
S: 0
> [   19.498138] WARNING: CPU: 12 PID: 3107 at net/mac80211/rx.c:5337 ieee8=
0211_rx_list+0x2b3/0xda0 [mac80211]
> .........
> [   19.498631] RIP: 0010:ieee80211_rx_list+0x2b3/0xda0 [mac80211]
> [   19.498684] Code: 00 00 80 3d 96 a7 07 00 00 0f 85 2d ff ff ff 0f b6 5=
3 4a 40 0f b6 f7 48 c7 c7 e0 a4 e2 c1 c6 05 7a a7 07 00 01 e8 dd 5d b6 e3 <=
0f> 0b e9 0b ff ff ff 40 80 ff 0b 0f 86 26 03 00 00 80 3d 5c a7 07
> .......
> [   19.498724] Call Trace:
> [   19.498731]  <IRQ>
> [   19.498735]  ? ieee80211_rx_list+0x2b3/0xda0 [mac80211]
> [   19.498785]  ? __warn+0x81/0x130
> [   19.498799]  ? ieee80211_rx_list+0x2b3/0xda0 [mac80211]
> [   19.498852]  ? report_bug+0x171/0x1a0
> [   19.498861]  ? prb_read_valid+0x1b/0x30
> [   19.498871]  ? srso_alias_return_thunk+0x5/0x7f
> [   19.498882]  ? handle_bug+0x3c/0x80
> [   19.498891]  ? exc_invalid_op+0x17/0x70
> [   19.498897]  ? asm_exc_invalid_op+0x1a/0x20
> [   19.498910]  ? ieee80211_rx_list+0x2b3/0xda0 [mac80211]
> [   19.498941]  ? srso_alias_return_thunk+0x5/0x7f
> [   19.498944]  ? _dev_warn+0x79/0xa0
> [   19.498952]  ? srso_alias_return_thunk+0x5/0x7f
> [   19.498956]  ? ath11k_peer_find_by_id+0x100/0x1c0 [ath11k]
> [   19.498978]  ieee80211_rx_napi+0x53/0xe0 [mac80211]
> [   19.498999]  ath11k_dp_rx_process_received_packets+0x23e/0x660 [ath11k]
> [   19.499013]  ath11k_dp_process_rx+0x2cf/0x3c0 [ath11k]
> [   19.499026]  ath11k_dp_service_srng+0x2e0/0x320 [ath11k]
> [   19.499037]  ath11k_pcic_ext_grp_napi_poll+0x25/0x80 [ath11k]
> [   19.499047]  __napi_poll+0x28/0x1b0
> [   19.499055]  net_rx_action+0x2a4/0x380
> [   19.499058]  ? srso_alias_return_thunk+0x5/0x7f
> [   19.499060]  ? __napi_schedule+0xb0/0xc0
> [   19.499065]  __do_softirq+0xc7/0x2ae
> [   19.499070]  ? handle_edge_irq+0x8b/0x230
> [   19.499076]  __irq_exit_rcu+0x96/0xb0
> [   19.499083]  common_interrupt+0x86/0xa0
> [   19.499086]  </IRQ>
> [   19.499087]  <TASK>
> [   19.499089]  asm_common_interrupt+0x26/0x40
> .........
> [   19.499179] ---[ end trace 0000000000000000 ]---
> full dmesg are attached.
>=20
> Under these conditions, there is a high proportion of packet loss and ter=
rible
> network speed.
> --- 8.8.8.8 ping statistics ---
> 1897 packets transmitted, 1868 received, 1.52873% packet loss, time 18998=
29ms
> rtt min/avg/max/mdev =3D 8.361/19.235/182.594/10.237 ms
>=20
> Workaround: When you enable 802.11ax in the router settings, everything b=
ecomes
> fine.
>=20
> From my side, looks like router is sending incompatible in 802.11ac mode =
MCS
> setting and this cause the problem. But a lot of devices (include thinkpa=
d t14
> g2 with AX201 intel wi-fi) work well with this router and this setting.

To see full dmesg attachment, visit Bugzilla [1].

Later, after I asked to check mainline kernel, he could still reproduce
the bug:

> > Can you check current mainline (v6.7-rc5)?
> Of course.
> At first glance it seemed to be better, but the problem is still reproduc=
ible.
> 1800 packets transmitted, 1715 received, 4.72222% packet loss, time 18033=
70ms
>=20
> Dmesg:
> https://drive.proton.me/urls/ANXKYVSSE0#1UAg2yv5RbvD
> Ping with timestamps:
> https://drive.proton.me/urls/0X1YVJ0QEG#HWiaF4ZtM2YZ
>=20
> There appears to be a correlation between log messages (ath11k_pci ... Re=
ceived
> with invalid mcs) and packet loss.

Visit above Proton Drive links for full dmesg and ping test output.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218276

--=20
An old man doll... just what I always wanted! - Clara

--N3Q2B03KdscU10Yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZYO11gAKCRD2uYlJVVFO
o58bAP0YVKJa2zL9g2A/ZOkIwqtmOULNKJ/d349c6gblv/1/WAEAxbPkgjKhiHJT
x8YpaNRuNevTP72aVm8uimANZWiGQAk=
=0JS+
-----END PGP SIGNATURE-----

--N3Q2B03KdscU10Yb--

