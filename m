Return-Path: <linux-kernel+bounces-12096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB081EFF1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CFD282715
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7845BF8;
	Wed, 27 Dec 2023 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sqfGosFL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8B4596F;
	Wed, 27 Dec 2023 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703692813; x=1704297613; i=markus.elfring@web.de;
	bh=HvHevuA8OlpyyDwIVaTUzONXBPQ+x5nXY6hMxtcjTM0=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=sqfGosFLhe3P1dx7l4Bxvacu5snlCUSSYJ7ZzPC7IGCsxDtFm0YkEjtqu/OWJsuY
	 i0Za14D/8h0v2ExfTmNX8r3pNdahuDqF2sZcbFYJgC9KXTvMQ9n3rGXeWTIVfyyOc
	 y0F0kYJRwFYZqMCdPg6aZeGkuqxS34xdFwovAx9otLCOrl4wn9wxzD3g0t7NoaXpf
	 kjzXrU8mABYNXxCqIkE9W72yqXPbbKaBZc+JdYehb20OB7LBJaKA1+z03uu5fEWdT
	 CyPu1LOaxBevY/bqWzIPZ9Is+0yX4GqxZ/KNfCfgOvJJkZzy8Efd0/77c+c7DSRnv
	 EZ6rbxup7Nen08py5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZSFO-1rmknr2Zzq-00Wyi1; Wed, 27
 Dec 2023 17:00:13 +0100
Message-ID: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Date: Wed, 27 Dec 2023 17:00:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/2] nfc: mei_phy: Adjustments for two function
 implementations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/ZB+Xz9KfutVy44u7ATXxHfRoOlJu8VqT0njohBNmDTFTFN81VA
 58/ninWz2K2SQkMe/JLejpRDslxSPa5e2YPAMXXSKq4siFxsX0NOxum8dc+FtrmTr0gAgmj
 0l3tI0o1ZqwrQCxMA2dPbRWtxzIDhZ85XexQzqCd2wtfSwe1tTN1S3CEe3xuYBK87s9j4tL
 dpZPTGY0SXpR1GsSizd1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f0e9gz3eaHo=;WM8+2HVOJDENngzP+ReL8RQv+0I
 aUXrbcBV6KciL55pCAKg+ISAW3eTFRj5nZo6LhMQVpOM3DtGgFQzBFMzFy1cy2JFEfw/CjyTI
 bHPvWwDMBnTY0y7DD24b81M9PjlqOPg7bVIJAFIN+IBHqQeXc867FpD0DMACfJyWcxiR5fTPY
 J6OBUi3RMcY5TB6CXA0CcQg/OEr9woQmvjvm1fqZ9IWfbXs0+Fm4Qqokt+rWv43QZndgBmboz
 2PShqWL6Ji6bG0HzjNiNw9lOMXCxst7jchkMgi7ORFdz2G14NXQMHfcwUVg3ON9vTDcU3NpkU
 TBzNckgch1atGYKOebetXdtQUSx4BSbk5lAPcEynStw+An4s/Y8NbvZq1H/IuHizv+X2CKWlJ
 GcFepiVaLkKhB/sQEmDYQ/tZcXwRTpUJHIKUBeHXnJEY6/eVX/4Tg2mR4mSWjpmCEl2p9N5l7
 Sq5ZofrmWXIDZlvjGCS72iurOOhX0JKzBw06O6oCLBP5dzBLoh3PjJGhhAtsl8L/oSy6Bd0E7
 D/tejmehatFg1M7Ltkl7a0a6ZxHTkXj8r7sQ2YwhpxxTeSBMLLyxWEUojcNzk+qKK0GbT7R23
 pyDK0ny4ymBaHrsknHGXD1U5QXi/EGVnw597hoQRsfOHD5nqx9qlljXmgsXb8vc5NfPPC6lGo
 66BpDUWBH9aqJ1whSvuGVZME/hHT2X7vpKd8py1lwm3yhX8f1u7f4M0oJkNZJuOHL/C8Bjr6G
 PwneqTrXwX5/dLeXb7X3a+nddtb1dXiUnDodJzwf3tW0LmmhihEK7evONJNeAhFgGK5aWNSDQ
 MJRaAIaxCuh7Rnlvkd9vTbpytDsU4lUE6iQyPdFC0+fpy1Y82IaSDOtuduyxXKd8X8x0m/U+X
 LJBAO43F1W0f6VspGca7tH9sFAWEua7ZfeGusg+Pwf2DN8mIR+13SCeo681OIoo4WsxFX19EA
 agtDP2+Y0tQA3ivAsR/ymANKT+8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:53:21 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Return directly after a failed kzalloc() in mei_nfc_send()
  Use common code in mei_nfc_connect()

 drivers/nfc/mei_phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

=2D-
2.43.0


