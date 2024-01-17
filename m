Return-Path: <linux-kernel+bounces-29171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014118309FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FA731F23343
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53821A19;
	Wed, 17 Jan 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Kn4viGP6"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB04521A04;
	Wed, 17 Jan 2024 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506434; cv=none; b=Hh5ggD4gPT0oDQglxdKKPKVox+xE6PL8m96+9W4Bao1vF9uHkSDu/IqykMTtWZv5teofhJWcWSr+/vFBfoBnylZk8JJEkWoQWz0d5FSmpWKz4SD1fnJdRpYmvy+U79gyqvv55h3BnyQ0lJyLXwWxoeNWPS9YeW3MYPH0uyC0aF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506434; c=relaxed/simple;
	bh=imkRlcEIxSECpvWrb/WZ1Fs6wTq5TbwnfYWP3f3j4fs=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport; b=i8U9CK6evj8Mb112wgAdSnnu5X/1FtfHFlt1aSMBkQcutkiGmofuysPuIfMR5kh1Cab7jFtRXzFSqvGKwJDDv0P555/F4Yb+lppaJH51HT56xkAHzkFkQ1jlhykwpxc21BzwSCZR9nSyjbxgAXvCmpAu71+d275iDsaiI7/zKAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Kn4viGP6; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705506412; x=1706111212; i=markus.elfring@web.de;
	bh=imkRlcEIxSECpvWrb/WZ1Fs6wTq5TbwnfYWP3f3j4fs=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Kn4viGP66uEY6hxKFeNR65Oofu8m8OWNSkAVv97ZrRaL3xBmOukZq/3bam2QshtB
	 1nrBQ3OexdBFfGQ6j3M5K4GmxcrE8VOjPgh7eSjWJNLgDBjQ7PGnRZfBWdH0UntT5
	 o2ee8PvtfTjQMVg0goDHGDtlZfsKsUyEtLwECsiu+Z2PxwAu3e2MGQ9vhD5itao2R
	 G0DoagToRPpXkEDCrQ5NgjmMnYnBvgEg5two8BQ2YElshGPux7N4t4UsBF4MIB+FM
	 LyiG6HaxdZWxzOg0NcBwbO8npi0aCEO9MAikPL1yVUYaZruveWE0ilNCLV+NO8l5w
	 6RD1dvU480Ce92AldA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1aDp-1rRVpv1iQN-003E2Y; Wed, 17
 Jan 2024 16:46:52 +0100
Message-ID: <75f302b2-9fe0-4b3d-a132-85186c4d9445@web.de>
Date: Wed, 17 Jan 2024 16:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Alex Helms <alexander.helms.jy@renesas.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saeed Nowshadi <saeed.nowshadi@amd.com>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: versaclock7: Return directly after a failed kasprintf()
 call in vc7_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NgCtdZimQ5H+nTibuBuhAhJQP71uJFO/lCYKigwy9yWfdEzQ2Ep
 1fS3Km4lhjngeIh1jGfZzmD7eygbbm+/eEn83smX2ZnuhHRfUp52GYqiyt6L23plZVUFIyG
 2ICbgu10T5UeGP0dUFjh2hqVETLRNOLNKuMz1OJQ1qJOmmEEQFBdUz6fk8jtQaBDjhQv/4z
 fupMtFMdwomMLhhTNlcTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+6buGsTWYV8=;2Fb2dSZsw8JVKKweUIItlQHbilk
 Wk0CGsJEH7Z2IcEqcPAq/BziG61Hr0kzofIqcQ4t7L//BagEXHq/qfmcmEM8wC/cwklC1O1EX
 EmbX0VnEV9yaRkTLv4sgoIyp7xc1SUVg1BkqX1BmkyqGVG/2Qbd9KYtT5J0GLU+1UQe86+Apq
 FobItahZnvZM8DwdeeWZB3fXfY2MTrVUAodpz0A6SOacvn7jRLx3w185+yhHLqmcdSTN06k37
 2lLALBFw3eL4gOu3/ozkjgv0m9732FI/QjoRG3w1gxqb9ngCrKqmW86dc6A8FPBFfcvKV5XXv
 LMF+eGv5Vfn4e02SRGTXLkVrkPXXERlJMLp/yRUjixdl1jCPR5h2wcxEtk7JVBLG+Y2kPwUyJ
 aHYyP5jNbavgKPXzBl81T8UGa0k52bJNFzb54RYEe/8dDS9cB85fGjinjxZCfMq9g22HgjdHN
 rwDiby9mpW1ppymx//U8ddACOLMW7imp7sgsGfOShY/wy4L0p2A0NnO2h0vcCJYxn6nEcgwxf
 KmZr3WzbY81m98hwiFdUcQjU+baiIf+HRQNlw92qGlEVdMUXf3a1MiT11bR3ENwQ6nxbdMBU/
 YW3C97YbFGP48PpM0vgSRmS2UoBaj2mCrSmy1ZObNh6wsd5p8jhJzn0v3MAj82S7YOuroeNd4
 SXhaJ3ny/OECH9On3sL9LHyGIeVmBvSxHW7SYq4jYn5S19eFGGUb8nhNyJLUwAy/vZAL9hg0X
 zq/PjSL2b7ndsKFFHeIJnCDaw7keTVPquSnzrCBCO7kC7Hf9BuT3gDVWTc0TEzM9tyAn55qsO
 Z94sEOJMjsFRwSng7ek60b/tueZKiHjzz+fj7AuS1X1nS9FEm22gqtO0WqSG7m5UHoLdGYJN5
 h8kFUaEQD0H8SJmDhqub59248Qxm6gYC5xa6YBZHFWfi7oo2yLZoWd1KFyCVYhrlzoDAR95jo
 481BJg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 17 Jan 2024 14:06:13 +0100

The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was pas=
sed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus return directly after a failed kasprintf() call.

Fixes: 48c5e98fedd9e ("clk: Renesas versaclock7 ccf device driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/clk-versaclock7.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index f323263e32c3..96e6b05f2aac 100644
=2D-- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -1127,8 +1127,11 @@ static int vc7_probe(struct i2c_client *client)
 		node_name =3D client->dev.of_node->name;

 	/* Register APLL */
-	apll_rate =3D vc7_get_apll_rate(vc7);
 	apll_name =3D kasprintf(GFP_KERNEL, "%s_apll", node_name);
+	if (!apll_name)
+		return -ENOMEM;
+
+	apll_rate =3D vc7_get_apll_rate(vc7);
 	vc7->clk_apll.clk =3D clk_register_fixed_rate(&client->dev, apll_name,
 						    __clk_get_name(vc7->pin_xin),
 						    0, apll_rate);
=2D-
2.43.0


