Return-Path: <linux-kernel+bounces-17647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95682508F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847E8283E4D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C302E22328;
	Fri,  5 Jan 2024 09:05:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3822F00;
	Fri,  5 Jan 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40595Y9o82290263, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40595Y9o82290263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 17:05:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 5 Jan 2024 17:05:35 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 5 Jan 2024 17:05:34 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Fri, 5 Jan 2024 17:05:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: "kuba@kernel.org" <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v15 05/13] rtase: Implement hardware configuration function
Thread-Topic: [PATCH net-next v15 05/13] rtase: Implement hardware
 configuration function
Thread-Index: AQHaP7TzR1Pwa0RZA0mW//3lz45q0LDK7RgQ
Date: Fri, 5 Jan 2024 09:05:34 +0000
Message-ID: <f0265649af004c7a8a2ceb8451f3a650@realtek.com>
References: <20240105085439.376802-1-justinlai0215@realtek.com>
In-Reply-To: <20240105085439.376802-1-justinlai0215@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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



> -----Original Message-----
> From: Justin Lai <justinlai0215@realtek.com>
> Sent: Friday, January 5, 2024 4:55 PM
> To: kuba@kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; andrew@lunn.ch;
> Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu <larry.chiu@realtek.com>;
> Justin Lai <justinlai0215@realtek.com>
> Subject: [PATCH net-next v15 05/13] rtase: Implement hardware configurati=
on
> function
>=20
> Implement rtase_hw_config to set default hardware settings, including set=
ting
> interrupt mitigation, tx/rx DMA burst, interframe gap time, rx packet fil=
ter,
> near fifo threshold and fill descriptor ring and tally counter address, a=
nd
> enable flow control. When filling the rx descriptor ring, the first group=
 of
> queues needs to be processed separately because the positions of the firs=
t
> group of queues are not regular with other subsequent groups. The other
> queues are all newly added features, but we want to retain the original d=
esign.
> So they were not put together.
>=20
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> ---
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 228 ++++++++++++++++++
>  1 file changed, 228 insertions(+)
>=20

Sorry, this series of patches has not been sent completely, I will re-send =
it again.

