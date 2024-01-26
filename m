Return-Path: <linux-kernel+bounces-40613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D799483E330
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947CA28960F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65422EF3;
	Fri, 26 Jan 2024 20:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="X7YmOrJ5"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B122EE6;
	Fri, 26 Jan 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300108; cv=none; b=l67EXN/Ir4OUdJbzUddYMGxkM6xWSMfKtZ/AxpzOnJPDd6gUk21b2/t+Df4dZhdf4OH4WtLi/Avv7EZguuqB1BKIiaLy+v++ZjBqQFRZjl64O6cFv0l8im+s5SQEf48oIom/g+TuncjDYgJCYsXMnz9wuU6Ei+Np8DEep3r3ZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300108; c=relaxed/simple;
	bh=4sEMq0puBME/237eMZk3ovA7X8MRhuki13KbJQyBrEQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2Lg0YIZpCA1oN6o6OoU/iB7mFEhmmic+36rSfXzauo4MSw9Ul9LFwcp+J716I5glVQ23g9DGvnRBkCL7huA0Ov3WOrAso7nGB8iSyY031s8te/d2N/NVuyagXeb4+r6GRDJrMLY8jY/935yaP+qPac4LxS45SZeZKjmCATyKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=X7YmOrJ5; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id DB211100008;
	Fri, 26 Jan 2024 23:14:58 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DB211100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1706300098;
	bh=YSHUVKqeGq3nTAxTTeI0cf6HT4MFk+fExmZZ2XSG68c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=X7YmOrJ5G6dUon2EuzxLn6/s319RkRH6lJYmu8PHniJ0bZ8wTCqMhPBh3MuWXfCrI
	 yPX6e4Js4QAij//7mIpLH/9u3zLbbWcowxFzXbekvkHMiiOD6ZtmK0//Ql+AXHWqvJ
	 8awp9guqUt/lcjPEfZPhWFOlvOVX8+xQ8C8lORVY5Vl17TkXmhT2Ob+zTSfibGJXXg
	 e7R91UZZmOp2B7b6bJ7kKmTpF0mbDZZ7pOBw6Vn/3ZoccjGM6leuUNpEFfIkjWDYFT
	 3yFsP0mfw0Sz9eyq+OKbbGdJtpxteRhQbXggiyT0dI3miFLleTOJcdXotvBGzJYFWA
	 dgGTv+VDceiXg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 26 Jan 2024 23:14:58 +0300 (MSK)
Received: from CAB-WSD-0003115.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 23:14:57 +0300
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <kernel@salutedevices.com>, Jan Dakinevich
	<jan.dakinevich@salutedevices.com>
Subject: [PATCH] clk: allow to skip clk_core_req_round_rate_nolock()
Date: Fri, 26 Jan 2024 23:14:33 +0300
Message-ID: <20240126201433.1830600-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182973 [Jan 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/01/26 14:25:00 #23442014
X-KSMG-AntiVirus-Status: Clean, skipped

Calling of clk_core_req_round_rate_nolock() can be time-consuming in a
case of deep hierarchy with multiple dividers/parents. But if the clock
already has exactly the same rate as desired, there is no need to
determine how it could be rounded.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2253c154a824..04f0ddced932 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2423,6 +2423,12 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (!core)
 		return 0;
 
+	/* skip calculation of rounded rate if the clock already has exactly
+	 * the same rate as desired
+	 */
+	if (req_rate == clk_core_get_rate_nolock(core))
+		return 0;
+
 	rate = clk_core_req_round_rate_nolock(core, req_rate);
 
 	/* bail early if nothing to do */
-- 
2.34.1


