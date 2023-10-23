Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D337D4367
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 01:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjJWXoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 19:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjJWXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 19:44:12 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB2A4;
        Mon, 23 Oct 2023 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698104589; x=1698709389; i=s.l-h@gmx.de;
        bh=c12zjGhXuILXy6c+VS+yOhq4DSmbOBdAvoj+0IeHUlQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
         References;
        b=Uodw9CqcsXTaliZfm/92Z2xFBXYAK6IwOiSpfxl5KnqgPO9zffsF/iOpW5aelJ1k
         yhWRM264lMa/fA71okHLoSy8GgzcKYOIcRu6m8D+AzXproq/LKPRA+4r/6U6VotwI
         mI2GQzLg9nycZehhqu+w2y8AjaSW/svvI2hiXGr9YGLsY0s7LgqAoUj0UvPmMAwAu
         ZsLVePvXFK7qzEpZ+Iz2g3XwukOadO6Fs8td7rhgoarLW7KJmZjQsZLjy/69hddvj
         aNKUhKVP5TpxCB2Lzy0G/PML85S89U8BN0HQ2T7OTCc7NdrPCUb7Di3N8wySmf7SF
         Q1vyI5syus+wyQ4vhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mir ([94.31.85.155]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1qz2sh2Fog-00VT6g; Tue, 24
 Oct 2023 01:43:09 +0200
Date:   Tue, 24 Oct 2023 01:43:02 +0200
From:   Stefan Lippers-Hollmann <s.l-h@gmx.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geoff Levand <geoff@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Linux Wireless <ilw@linux.intel.com>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
Message-ID: <20231024014302.0a0b79b0@mir>
In-Reply-To: <20231023131953.2876682-11-arnd@kernel.org>
References: <20231023131953.2876682-1-arnd@kernel.org>
        <20231023131953.2876682-11-arnd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NpIw+SX94egfOhweBUAICPZH64XIjR12TC41Cr5kyAe3nCj2nJU
 W/jSlk3O9a/mEjYbsalglT8krptSsQttKV/p+nmGou04gTFwqgwY68JcCtrWE7Ewn+Q3yEk
 ixE9ud6+7BJVpxWJj+mqc751GtNMzj+UL9EbknOtywXW2D2SwmvVPgKQ7UPPg+khuD1jnvB
 joodVtXZ0hBJst/+AwO2Q==
UI-OutboundReport: notjunk:1;M01:P0:xeUZYqMe2kU=;VSobLSjvxv4e9KvKoWW3WapMQOz
 SvjhgYdRICj+oTFhwSCh31kra8F6DiJwdjPVsnQ/xjdYtA9TcXr9P/J1lLYc1dWloNCjLaQkZ
 N9mFuZUfdL6kUDoUPNrOFpcu0u+aVhYsEr75Z7QndpJRZMUDe19snVpb+j91cA4X7B9Dts2CR
 BQurgXV4F0o+EQbdCLJlSZBVgSLHws2xxRjAp+trAx6Xv3vw6adc3W0rz+geymeHMFR+bHXOf
 KChzfNUcWauwnRHTGdCXJgj3Q0n6Pod1y8SgfMuvvUTzVIjIvc+0/OFcuC0OzSALXlSbAIQwE
 t2pjiqQlQ96vrVpgb7b5mbMM6jAtLdLVDBGo6Bu7iCC0aEnnAzrLtwVDkA6c7EAKbBdulxEEs
 U1FkxKsNyMqszruBbV/n7mKjDzBKmVx7XAMq5Xd1DN3WX15ccUR7V5pEYpsfhL1V7Jsn5NfCQ
 HE3djfPPO67UnTeCn+eFTNSF//qvDpiWPc8WMEr0+yvMD5S4dcraEXLSi8gzQ/4Kpjb02XcaC
 MriGmTYE1HuFuKQ/47RkL73LyzBV1SezL5CSoweyAniRJH0nsDNAL5LsoE4ivdhkKhdIvj9mf
 okqS04G4KzNA19BBXIsHQix5cI4T90/x7Lqg+ArpszXIqdVKYfh9IG5LhXXBH+GwqctbeHJWR
 2AB1SsQ3L2KafT7Rdfx6oPgRNN1yMlY1Ci2ShPRAbzxT6fhee277CLYEPc9FvA5aeMJnjzTha
 /IcPh/Ob/o3mpHe//Rigfkfz1i8c0mhXZPOVKzVuU9vaI9aplolQso8qEFfbiCAzpWGJbnIFf
 s89jxCnwjLoEd8gkK8L/FfKRR44p4tNN6f83Vq+Xo4J4CvBH8oXbW1BrRX8EsWuD7QqNsRrZX
 I7At23qs2nCZnQW8vJh1KH6kJvZk50R3n515g07ALKD13OMfeKafnwfVrdi7kRzX9jr9jpWVB
 Uiqmfw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023-10-23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> These two drivers were used for the earliest "Centrino" branded Intel
> laptops during the late 32-bit Pentium-M era, roughly 2003 to 2005, whic=
h
> probably makes it the most modern platform that still uses the wireless
> extension interface instead of cfg80211. Unlike the other drivers that
> are suggested for removal, this one is still officially maintained.
>
> According to Johannes Berg, there was an effort to finish the move away
> from wext in the past, but the last evidence of this that I could find
> is from commit a3caa99e6c68f ("libipw: initiate cfg80211 API conversion
> (v2)") in 2009.
>
> Link: https://lore.kernel.org/all/87fs2fgals.fsf@kernel.org/
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Cc: Linux Wireless <ilw@linux.intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not convinced this should be in the same set of drivers as the
> rest, since this is clearly less obsolete than the other hardware
> that I would remove support for.

These have indeed been very common back in the day, I'm still using
a 2003-vintage 1.5 GHz Pentium-M 'Banias' Acer Travelmate 292LMi
notebook using ipw2200 (and have two spare ipw2200 mini-PCI cards).
Works still fine using v6.5.8-rc1 and WPA2PSK/ CCMP (sadly it does
not do WPA3) and I do use it semi-regularly (running the latest
stable- or stable-rc kernel of the day).

While it would be nice to replace it with an ath5k based card (to
get WPA3 support), the card isn't that easy to reach in the notebook,
so it would be sad to see this go.

Host/Kernel/OS  "acer-292lmi" running Linux 6.5.8-rc1 i686 [ Debian GNU/Li=
nux trixie/sid ]
System          Acer TravelMate 290
CPU Info        Intel Pentium M 1024 KB cache flags( sse2 ) clocked at [ 1=
400.000 MHz ]
Videocard       Advanced Micro Devices, [AMD/ATI] RV350/M10 / RV360/M11 [M=
obility Radeon 9600 (PRO) / 9700]  X.Org 1.23.2.1  [ 1024x768@60.00hz ]
Network cards   Realtek RTL-8100/8101L/8139 PCI Fast Ethernet Adapter, at =
port: a000
                Intel PRO/Wireless 2200BG [Calexico2] Network Connection
Processes 131 | Uptime 3:16 | Memory 125.2/493.1MB | HDD IC25N060ATMR04-0 =
Size 60GB (67%used) | GLX Renderer llvmpipe (LLVM 16.0.6, 128 bits) | GLX =
Version Yes

Yes, this is an old and slow system, but it's there, functional and
I rarely need a mobile notebook (my desktops are more current and
64 bit capable).

02:02.0 Network controller [0280]: Intel Corporation PRO/Wireless 2200BG [=
Calexico2] Network Connection [8086:4220] (rev 05)
        Subsystem: Intel Corporation WM3B2200BG Mini-PCI Card [8086:2701]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr=
- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
 <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 128 (750ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=3D4K=
]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D=
2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
        Kernel driver in use: ipw2200
        Kernel modules: ipw2200

[    0.000000] Linux version 6.5.8-rc1 (s.l-h@gmx.de) (gcc-13 (Debian 13.2=
.0-5) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41) #1 SMP PREEMPT_DYNAMI=
C 6.5-13 (2023-10-17)
...
[   23.886128] lib80211: common routines for IEEE802.11 drivers
[   23.886133] lib80211_crypt: registered algorithm 'NULL'
[   24.051575] libipw: 802.11 data/management/control stack, git-1.1.13
[   24.051586] libipw: Copyright (C) 2004-2005 Intel Corporation <jketreno=
@linux.intel.com>
...
[   24.735203] ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.=
2.2kmprq
[   24.735221] ipw2200: Copyright(c) 2003-2006 Intel Corporation
[   24.735825] ipw2200: Detected Intel PRO/Wireless 2200BG Network Connect=
ion
...
[   25.007359] ipw2200: Detected geography ZZE (13 802.11bg channels, 19 8=
02.11a channels)
...
[   27.027578] ipw2200 0000:02:02.0 wlp2s2: renamed from eth0
...
[   29.571384] NET: Registered PF_PACKET protocol family
...
[   42.603676] warning: `wpa_supplicant' uses wireless extensions which wi=
ll stop working for Wi-Fi 7 hardware; use nl80211
[   44.196736] lib80211_crypt: registered algorithm 'CCMP'

# iwconfig wlp2s2
wlp2s2    IEEE 802.11  ESSID:"xxx"
          Mode:Managed  Frequency:2.412 GHz  Access Point: xx:xx:xx:xx:xx:=
xx
          Bit Rate:54 Mb/s   Tx-Power=3D20 dBm   Sensitivity=3D8/0
          Retry limit:7   RTS thr:off   Fragment thr:off
          Encryption key:xxxx-xxxx-xxxx-xxxx-xxxx-xxxx-xxxx-xxxx   Securit=
y mode:open
          Power Management:off
          Link Quality=3D0/100  Signal level=3D-28 dBm  Noise level=3D-89 =
dBm
          Rx invalid nwid:0  Rx invalid crypt:6  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:100

# wpa_cli status
Selected interface 'wlp2s2'
bssid=3Dxx:xx:xx:xx:xx:xx
freq=3D0
ssid=3Dxxx
id=3D1
id_str=3Dxxx
mode=3Dstation
pairwise_cipher=3DCCMP
group_cipher=3DCCMP
key_mgmt=3DWPA2-PSK
wpa_state=3DCOMPLETED
ip_address=3D172.22.2.1
address=3Dxx:xx:xx:xx:xx:xx
uuid=3Dxxx

(performance against a wifi6 (ipq8071a AP isn't that great, but it works)

$ iperf3 -c 172.21.4.1
Connecting to host 172.21.4.1, port 5201
[  5] local 172.22.2.1 port 45288 connected to 172.21.4.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.97 MBytes  16.6 Mbits/sec    0    110 KBytes
[  5]   1.00-2.00   sec  1.74 MBytes  14.6 Mbits/sec    0    163 KBytes
[  5]   2.00-3.00   sec  1.68 MBytes  14.1 Mbits/sec    0    163 KBytes
[  5]   3.00-4.00   sec  1.68 MBytes  14.1 Mbits/sec    0    163 KBytes
[  5]   4.00-5.00   sec  1.86 MBytes  15.6 Mbits/sec    0    163 KBytes
[  5]   5.00-6.00   sec  1.49 MBytes  12.5 Mbits/sec    0    163 KBytes
[  5]   6.00-7.00   sec  1.86 MBytes  15.6 Mbits/sec    0    163 KBytes
[  5]   7.00-8.00   sec  1.93 MBytes  16.2 Mbits/sec    0    228 KBytes
[  5]   8.00-9.00   sec  1.49 MBytes  12.5 Mbits/sec    0    228 KBytes
[  5]   9.00-10.00  sec  1.99 MBytes  16.7 Mbits/sec    0    228 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  17.7 MBytes  14.8 Mbits/sec    0             send=
er
[  5]   0.00-10.13  sec  17.2 MBytes  14.3 Mbits/sec                  rece=
iver

iperf Done.

$ iperf3 -c 172.21.4.1 --reverse
Connecting to host 172.21.4.1, port 5201
Reverse mode, remote host 172.21.4.1 is sending
[  5] local 172.22.2.1 port 52246 connected to 172.21.4.1 port 5201
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.04   sec  1.88 MBytes  15.1 Mbits/sec
[  5]   1.04-2.04   sec  1.75 MBytes  14.8 Mbits/sec
[  5]   2.04-3.03   sec  1.62 MBytes  13.7 Mbits/sec
[  5]   3.03-4.05   sec  1.75 MBytes  14.5 Mbits/sec
[  5]   4.05-5.03   sec  1.75 MBytes  14.9 Mbits/sec
[  5]   5.03-6.06   sec  1.88 MBytes  15.3 Mbits/sec
[  5]   6.06-7.05   sec  1.75 MBytes  14.8 Mbits/sec
[  5]   7.05-8.01   sec  1.75 MBytes  15.3 Mbits/sec
[  5]   8.01-9.03   sec  1.88 MBytes  15.4 Mbits/sec
[  5]   9.03-10.02  sec  1.75 MBytes  14.8 Mbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.46  sec  21.4 MBytes  17.1 Mbits/sec    0             send=
er
[  5]   0.00-10.02  sec  17.8 MBytes  14.9 Mbits/sec                  rece=
iver

iperf Done.

While I'll cope if ipw2200 goes away (giving me the impetus to replace
the ipw2200 card with ath5k - or at least to use an ar5212/ar2414 ath5k
or bcm4306/2 b43 32 bit PCMCIA/ cardbus card (inconvenient, with the
antenna sticking out) until then), these have been so ubiquitous in
their days that there will be quite a few surviving specimens around
(and this one is actually still in semi-regular use with current
kernels/ userland, not daily, but 2-3+ times a month, mostly for
isolated firstboot configuration of various networking gear).

Regards
	Stefan Lippers-Hollmann
