Return-Path: <linux-kernel+bounces-112656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B874887C9E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A263C281B15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188917BB6;
	Sun, 24 Mar 2024 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b="Bbvs2KiV"
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11C175A9;
	Sun, 24 Mar 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711281853; cv=none; b=KfLYKXnPmDA0xlAnOSbaDd9rDmn8N3oEPzXcjXvjl1qkfZQ8cKoxfmtIeg5XEwjxd9U8i3EBUdWuVM4D3iiG9HnRXF+RvGvpXiy5IZE9dOeBVdiD8VCgbrXQFFGhnKoJg4pg3uQrQMfRW2Y+5KfiBf1nckFsJ5SJVk7mdZbLViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711281853; c=relaxed/simple;
	bh=a7LNXZGyhTHnJdRFDQFiEyndGv76THAe6Z6KbddtEB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUV1VTKcTJM8FmrknEIFXQMK+5nbWsifMl5rtgxhAzv/hm8o899d0ZH0BpB1pMJ3UmU+ixnbYFpeZPSxwTxX8WsMxuGmX2LklAV5NswuyAFEQcIMMtcv5xUdzjh5mlPocVerkxRZSgCDSTk1uTmCAAVRS+aEmR6TsV09pez6qRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.one; spf=pass smtp.mailfrom=bigler.one; dkim=pass (2048-bit key) header.d=bigler.one header.i=@bigler.one header.b=Bbvs2KiV; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bigler.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bigler.one
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4V2ZJZ0JBpz810r;
	Sun, 24 Mar 2024 12:55:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.one; s=key2;
	t=1711281342; bh=a7LNXZGyhTHnJdRFDQFiEyndGv76THAe6Z6KbddtEB4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Bbvs2KiVc2rRfF8yA37KDFw+fEJ3kIEcife3kStcavleVNza/wVp/sjF6LfNkHRCa
	 7fCe8KE6MyFhZb8N+hvmKpCemytQZBLq/rCSeK/mYI0lHNOMYqK2DtvPNYXc4Knp3N
	 TpvlNy8mPlWq2Fk2Z/a8IPzNJUYbm42rhOdEVLziH5+K6lp0lEk5l9zgdSQFT0NN3Q
	 12/vpyqxzR5Qp0V9T1DThtnY0erF3ysnThWAvcnmtFEw2sglSMNfqck71MvmZRnWSQ
	 j8sPdxmLlJNFQW/3puTq48Udt8oZ+1jhQIh7IQ+HrEeDamoOaI3HJrlwQ5opFjE1UF
	 +QDVIsxdRoIgw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4V2ZJY700fz810G;
	Sun, 24 Mar 2024 12:55:41 +0100 (CET)
Received: from mx2fc6.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4V2ZJW4Rp1z8sb7;
	Sun, 24 Mar 2024 12:55:39 +0100 (CET)
Received: from [192.168.1.24] (xdsl-188-155-38-242.adslplus.ch [188.155.38.242])
	by mx2fc6.netcup.net (Postfix) with ESMTPSA id 5B868405C9;
	Sun, 24 Mar 2024 12:55:34 +0100 (CET)
Authentication-Results: mx2fc6;
        spf=pass (sender IP is 188.155.38.242) smtp.mailfrom=benjamin@bigler.one smtp.helo=[192.168.1.24]
Received-SPF: pass (mx2fc6: connection is authenticated)
Message-ID: <ea86159bb555336ae21311770e3a1a6374092e64.camel@bigler.one>
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
From: Benjamin Bigler <benjamin@bigler.one>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
 Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com, davem@davemloft.net,
 edumazet@google.com,  kuba@kernel.org, pabeni@redhat.com,
 robh+dt@kernel.org,  krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net,  steen.hegelund@microchip.com,
 rdunlap@infradead.org, horms@kernel.org,  casper.casan@gmail.com,
 andrew@lunn.ch
Date: Sun, 24 Mar 2024 12:55:34 +0100
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-PPP-Message-ID: <171128133508.28970.8297446260616691683@mx2fc6.netcup.net>
X-Rspamd-Queue-Id: 5B868405C9
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: v2WY1NJuJOavqDS6N+mo2HKZCu2cke6cX3NwrAx0Pn64kxU=

Hi Parthiban

I hope I send this in the right context as it is not related to just one pa=
tch or
some specific code.

I conducted UDP load testing using three i.MX8MM boards in conjunction with=
 the
LAN8651. The setup involved one board functioning as a server, which is jus=
t
echoing back received data, while the remaining two boards acted as clients=
,
sending UDP packets of different sizes in various bursts to the server.
Due to hardware constraints, the SPI bus speed was limited to 15 MHz, which=
 might
have influenced the results.

During the tests I experienced some issues:

- The boards just start receiving after first sending something (ping anoth=
er board).
  Some measurements showed that the irq stays asserted after init. This mak=
es sense
  as far as I understand the chapter 7.7 of the specification, the irq is d=
easserted
  on reception of the first data header following CSn being asserted. As a =
workaround
  I trigger the thread at the end of oa_tc6_init.

- If there is a lot of traffic, the receive buffer overflow error spams the=
 log.

- If there is a lot of traffic, I got various kernel panics in oa_tc6_updat=
e_rx_skb.
  Mostly because more data to rx_skb is added than allocated and sometimes =
because
  rx_skb is null in oa_tc6_update_rx_skb or oa_tc6_prcs_rx_frame_end. Some =
debugging
  with a logic analyzer showed that the chip is not behave correctly. There=
 is more
  bytes between start_valid and end_valid than there should be. Also there
  seems to be 2 end_valid without a start_valid between. What is common is =
that the incorrect
  frame starts in a chunk where end_valid and start_valid is set.
  In my opinion its a problem in the chip (maybe related to the errata in t=
he next point)
  but the driver should be resilent and just drop the packet and not cause =
a kernel panic.

- Sometimes the chip stops working. It always asserts the irq but there is =
no data (rca=3D0)
  and also exst is not active. I found out that there is an errata (DS80001=
075) point s3
  that explains this. I set the ZARFE bit in CONFIG0. This also fixes the p=
oint above.
  The driver now works since about 2.5 weeks with various load with just on=
e loss of frame
  error where I had to reboot the system after about 4 days.

Is there a reason why you removed the netdev watchdog which was active in v=
2?

Thanks,
Benjamin Bigler


