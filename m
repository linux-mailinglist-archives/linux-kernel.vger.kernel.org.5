Return-Path: <linux-kernel+bounces-163133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1808B6632
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0C01C21665
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC539194C68;
	Mon, 29 Apr 2024 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivaldi.net header.i=@vivaldi.net header.b="HtobcFcy";
	dkim=pass (2048-bit key) header.d=vivaldi.net header.i=@vivaldi.net header.b="A2t+mgaE"
Received: from smtp.vivaldi.net (smtp.vivaldi.net [31.209.137.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071346CDD3;
	Mon, 29 Apr 2024 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.209.137.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714432977; cv=none; b=okjrtSu6Xh+XF4pHKTQs8XH44TX23rn8ZofAToW/ae1t+qlhnHDJ22n8HFPvGBWpQ2wnzNvKYv/zIpfkQtRuxDn+xQH7ETv1qNDutRh3IwW2t+/GGwaRbgQvqKoxghdo/wzhD3rr6gXIDDwvNDJ5den6nnh+i2Kfi9D4rsIP2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714432977; c=relaxed/simple;
	bh=byf9Z71+sb0GLOb3GdyWbm5OBgcDZx9meWJrrQxJ3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition; b=a+oOCDauaLElNvPxNDy8mbjeVoar86iemvnd3leRXtn6L05OIuI0ON32vXDK1U+auUNGr0KmRmBvI9uLGGE3ebVYHXT9R7HHTYETOZKOjSNB3MkqWIriljotCrlWXbC9ktwNV2gUn79rKqlnj4aADbwd1O+vwsLEhvcB+CBT2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivaldi.net; spf=pass smtp.mailfrom=vivaldi.net; dkim=pass (2048-bit key) header.d=vivaldi.net header.i=@vivaldi.net header.b=HtobcFcy; dkim=pass (2048-bit key) header.d=vivaldi.net header.i=@vivaldi.net header.b=A2t+mgaE; arc=none smtp.client-ip=31.209.137.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vivaldi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivaldi.net
Received: from localhost (localhost [127.0.0.1])
	by smtp.vivaldi.net (Postfix) with ESMTP id 0BB6ABD871;
	Mon, 29 Apr 2024 23:16:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.vivaldi.net 0BB6ABD871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivaldi.net;
	s=default; t=1714432588;
	bh=gmlOdeuOOqOrPjRFOowspShiT6SLu9pZIyUtwclj2CM=;
	h=Date:From:To:Cc:Subject:From;
	b=HtobcFcyrnUvMtU9i7nM2fVDAtYTPhl0TbvUYAgKthzbirMl+v09V2V5godpz/xV7
	 MFpZdHQqrhln6jlPdyWq4kM6o4Yec5TvtcD3mD6SqkLu02F6mRRnLVlJDy3Pv6m5vH
	 pkwzDQEAaTHqWTxCAw3eUu3FzWCLA5wV8KXpDB8D2vcWwh3P4qCgNuHbMlntIJMHA8
	 vP+ib7wlc+qHONW19xWhdYM65Y0knFMvSOPp4sLWCNG3oUTTNmZ/ywcAQkl5HRS15S
	 UqhJis+zHxw3whFWHzUspRitblMdgLw9SwLbpPr7nqJxW8+LKSA5BqNfmkWU20oXKk
	 ZbN9pS4DQ5hAA==
X-Virus-Scanned: Debian amavisd-new at smtp.vivaldi.net
Received: from smtp.vivaldi.net ([127.0.0.1])
	by localhost (mxo.viv.dc01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KXrbchY7OmMQ; Mon, 29 Apr 2024 23:16:24 +0000 (UTC)
Date: Mon, 29 Apr 2024 18:16:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.vivaldi.net 673B8BD6FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivaldi.net;
	s=default; t=1714432584;
	bh=gmlOdeuOOqOrPjRFOowspShiT6SLu9pZIyUtwclj2CM=;
	h=Date:From:To:Cc:Subject:From;
	b=A2t+mgaEWjnyp81IIVmf++ILe0m/k+aihZovm2QIzZfgZAfZ2WYIrDerKMGrFYncx
	 wm0YlasYu0ONoAChz5KaPa2rQ2C3zLjrjIO8HLw/0ndPtn+rjr8Xt3YCEnju+YTaji
	 5GFb6o1IxTMTCV67WtBx/a4pFunD39dlJSGj4aDWEM1WZmsqqtYgySbzKFVTeBvA+w
	 3iV5o2P8mG8GHQcp2JPPywYy2EjSSQQn8MXvd6KTRAoedJJE1ts4qJ1G3FVBbpjn56
	 UXEXSr1AMpblXrVRofOa6svAx7INUmcQupcukOU1/oWzwdAD1zgFxZVDg9e9HqtG1Z
	 cv++XT95GJucQ==
From: Isaac Ganoung <inventor500@vivaldi.net>
To: jtornosm@redhat.com
Cc: jtornosm@redhat.com, davem@davemloft.net, edumazet@google.com, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org
Subject: RE: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
Message-ID: <hzhomd7d7uc4dcnpvd6ki6v2f6camzm5ufqp2syqudrvzzfxi4@ykcirhonbqql>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n3kbqcmcqkpkrtj4"
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


--n3kbqcmcqkpkrtj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello,

I am using a TP-Link UE306 USB Ethernet adapter. The kernel detects it as an ASIX AX88179A USB Ethernet adapter. When using a different MAC address than the adapter's own (i.e. MAC address randomization), I am unable to send or receive packets unless set to promiscuous mode.

I am using NetworkManager to manage my connections. When I set 802-3-ethernet.cloned-mac-address to the device's MAC address in the connection settings (i.e. `nmcli con edit), the device works as expected. When that property is not set (null value), the device is only able to receive packets when set to promiscuous mode.

uname -a output: Linux hostname 6.8.8-arch1-1 #1 SMP PREEMPT_DYNAMIC Sun, 28 Apr 2024 18:53:26 +0000 x86_64 GNU/Linux
This is Arch Linux's kernel. The patches applied are here: <https://github.com/archlinux/linux/releases/tag/v6.8.8-arch1>

dmesg:
[37988.917741] usb 2-2: new SuperSpeed USB device number 4 using xhci_hcd
[37989.208722] usb 2-2: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
[37989.208744] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[37989.208753] usb 2-2: Product: AX88179A
[37989.208760] usb 2-2: Manufacturer: ASIX
[37989.208766] usb 2-2: SerialNumber: 0003B40D
[37989.481930] cdc_ncm 2-2:2.0: MAC-Address: <removed>
[37989.481949] cdc_ncm 2-2:2.0: setting rx_max = 16384
[37989.494646] cdc_ncm 2-2:2.0: setting tx_max = 16384
[37989.506072] cdc_ncm 2-2:2.0 eth1: register 'cdc_ncm' at usb-0000:00:14.0-2, CDC NCM (NO ZLP), <removed>

journalctl (from when not in promiscuous mode):
Apr 29 17:34:47 hostname kernel: usb 2-1: new SuperSpeed USB device number 5 using xhci_hcd
Apr 29 17:34:48 hostname kernel: usb 2-1: New USB device found, idVendor=0b95, idProduct=1790, bcdDevice= 2.00
Apr 29 17:34:48 hostname kernel: usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Apr 29 17:34:48 hostname kernel: usb 2-1: Product: AX88179A
Apr 29 17:34:48 hostname kernel: usb 2-1: Manufacturer: ASIX
Apr 29 17:34:48 hostname kernel: usb 2-1: SerialNumber: 0003B40D
Apr 29 17:34:48 hostname kernel: cdc_ncm 2-1:2.0: MAC-Address: <removed>
Apr 29 17:34:48 hostname kernel: cdc_ncm 2-1:2.0: setting rx_max = 16384
Apr 29 17:34:48 hostname kernel: cdc_ncm 2-1:2.0: setting tx_max = 16384
Apr 29 17:34:48 hostname kernel: cdc_ncm 2-1:2.0 eth1: register 'cdc_ncm' at usb-0000:00:14.0-1, CDC NCM (NO ZLP), <removed>
Apr 29 17:34:48 hostname NetworkManager[5652]: <info>  [1714430088.5005] manager: (eth1): new Ethernet device (/org/freedesktop/NetworkManager/Devices/14)
Apr 29 17:34:48 hostname mtp-probe[6423]: checking bus 2, device 5: "/sys/devices/pci0000:00/0000:00:14.0/usb2/2-1"
Apr 29 17:34:48 hostname mtp-probe[6423]: bus: 2, device: 5 was not an MTP device
Apr 29 17:34:49 hostname (udev-worker)[6422]: Network interface NamePolicy= disabled on kernel command line.
Apr 29 17:34:49 hostname NetworkManager[5652]: <info>  [1714430089.1558] device (eth1): state change: unmanaged -> unavailable (reason 'managed', sys-iface-state: 'external')
Apr 29 17:34:49 hostname mtp-probe[6456]: checking bus 2, device 5: "/sys/devices/pci0000:00/0000:00:14.0/usb2/2-1"
Apr 29 17:34:49 hostname mtp-probe[6456]: bus: 2, device: 5 was not an MTP device
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2247] device (eth1): carrier: link connected
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2255] device (eth1): state change: unavailable -> disconnected (reason 'carrier-changed', sys-iface-state: 'managed')
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2275] policy: auto-activating connection 'Wired connection 2' (e1106b48-8695-3ed4-b512-a0909ddaa247)
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2279] device (eth1): Activation: starting connection 'Wired connection 2' (e1106b48-8695-3ed4-b512-a0909ddaa247)
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2280] device (eth1): state change: disconnected -> prepare (reason 'none', sys-iface-state: 'managed')
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.2282] manager: NetworkManager state is now CONNECTING
Apr 29 17:34:51 hostname NetworkManager[5652]: <warn>  [1714430091.2284] platform-linux: do-change-link[9]: failure 16 (Device or resource busy)
Apr 29 17:34:51 hostname systemd[1]: NetworkManager-dispatcher.service: Deactivated successfully.
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.3634] device (eth1): set-hw-addr: set-cloned MAC address to 6A:0D:A2:E2:9D:A6 (random)
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.3646] device (eth1): state change: prepare -> config (reason 'none', sys-iface-state: 'managed')
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.3729] device (eth1): state change: config -> ip-config (reason 'none', sys-iface-state: 'managed')
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.3740] dhcp4 (eth1): activation: beginning transaction (timeout in 45 seconds)
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.3791] dhcp4 (eth1): dhclient started with pid 6459
Apr 29 17:34:51 hostname dhclient[6459]: DHCPREQUEST for 192.168.1.169 on eth1 to 255.255.255.255 port 67
Apr 29 17:34:51 hostname dhclient[6459]: DHCPNAK from 192.168.1.1
Apr 29 17:34:51 hostname NetworkManager[5652]: <info>  [1714430091.4578] dhcp4 (eth1): state changed no lease

Thanks,
Isaac Ganoung

--n3kbqcmcqkpkrtj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKkFABYIACkiIQWu9OejSHRObh6wRzaYOt2b+sY1MbPYEve6H7+92tvbBgUCZjAq
LgAALDEByM/RpJzrN4tsyayqlxQ6z1zu7GXBcKiNOWq4mkAk5ZNOS+EMr9Xm44S1
Pq44eyG79m3d2NHw2fIMAAHHez3UYwCShykJyyvbM/dRBY4LoMxfxV1fcuca9udH
Iosz4Sv/gnMLaxGkmS3cwLQ2RRSf3DEtdCYA
=gXUS
-----END PGP SIGNATURE-----

--n3kbqcmcqkpkrtj4--

