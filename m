Return-Path: <linux-kernel+bounces-80474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2829D8668CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9206AB20FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866E819470;
	Mon, 26 Feb 2024 03:42:04 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2092.outbound.protection.partner.outlook.cn [139.219.17.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE24D11737;
	Mon, 26 Feb 2024 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918924; cv=fail; b=pUOLEsK8N2COKrik+tmKKUgV59bNXzwiTcd2dcq5k62iqxg2s1uteAGlABdXwuF+wIaRL/0Dysg0SYXe4IsYotLCE4kBqYWuxMTq0HMo65T6zMYpDb3kVXX1w6RO76JT8iHqRienvBrfWtwn8oGsHcUtezMRifyg0Qn1vAJgJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918924; c=relaxed/simple;
	bh=v3Yjh1SMDNZLHi6TYObZGWsRWwX80V1vmrlv7EhVMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J1UwWmMXeP5Qj8NxULMhVlgrUf+UdoYiweL+57C8gSqzwVGwr3C4a1v1FnqdaAQseSGcOmnVV0E5V1kBEmFNh/SR6Gnp39mvLv4NRRWKe9ASmh/DRk3/DbWeYDcS8QcoOQKeWUdTa0dlxNZ5n42C+Pnjmj1OiSbr2TbyMXHE8qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiXdRT0E8Csk9XwWF7tM4xH02ZIct2MLJyjXI7jdRjOpeYk6+0DYQuuWagvJkw/Wm73Yj5IYNwzQewdw2zFcLQrdFFdUFiVk3Qp+5GxRhiQiuzfFCQd01N5POQ+b2XVsMzNYS2w7Nc3pUfqmW7yQSGDjeHzOE3vA235WxUenM3dNaXN3H1Wpc1NuvMUHqib2oYx44Tjy/2KD1gzslBzyqgcj0Fz77stI02s6Cn+/2rZ4tJV8Wi+zTZwosq+mDEhL6JUmpDW44wToqGqbezfIkYQdT9Orb3oLNyo81Aq68YucELULX4keAutDRzPOyQqeZAk3ypL34+ZnLU7S9PMyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYk9dwd+yZMVuVtJcySlzSb2Q2EM8dQK6yUJq+8ALv0=;
 b=PEq0lhr+OSXsetdL6txn4mU4NT7RCEaE0VIJAzAU6oQJeKU1WmVXMHgX8NymyO7CKHqyVD4dhtGG+RUE0PG7HQm20CbMtldfLtlMovsyLT4mMaQJVSbn0i7YoE0juIEdBckDq210fzHxAy6Q/nhjKn34pTE6ug/gcqx8gjqlA+WjpNTtqfOITru+RrsCSyedrqx8B9PpROYNzMvYmYWPWesbMBPA0JUnFpBML/5t42mvCHrEgNfTGQc7rTURXVXwFOMDRD0/Vz8H8mlgmkH9KnZB44EhPqXxCb950ck2nFiC+24gcmZP+0ApWRYEc+5ET2eVstwk5PjBdDW7k1hcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Mon, 26 Feb
 2024 03:41:51 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0fb:daf7:3f8b:868c]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::d0fb:daf7:3f8b:868c%3])
 with mapi id 15.20.7270.047; Mon, 26 Feb 2024 03:41:51 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] dt-bindings: pwm: opencores: Add compatible for StarFive JH8100
Date: Mon, 26 Feb 2024 11:39:45 +0800
Message-ID: <20240226033945.816974-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1063:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd6ee04-37af-4115-d4b6-08dc367cde2d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1veJGaj9i4mQDGYHNk9MtyjZdJ1DXPBf9V3SdFbVq8LubOfve4paOLs/2eATdPitD3+FfvMm3ZrhQI9a3NJCDUKnou6OfvWFkmMvkKD4Nq9v1XHhML/du1TmY0amrVeZJ5ObHcKLf0jsCx3N13H3owqtYG1mBAnANMgPays5a///2RmC0BtOKbMCI6xzTv1kwF3Lf32VRgVlKAXQA58GY+Y7DCyXYpjb4liuXMy1+GWlmk6oV9OJd0mLdlvR/VFapORiGqjnXOMRtjceIvSxIkXgvi7mbwD2pq0zYoQYnr2gnOzQIK4P41HI2ZI7gIrDhQTgsi7RMRGACwGvQeC4n+U+wuU1JlVbvuUi1byiygCd1zoBLKLgjJEf2leEE0qIoVdXJzap2BMs2Wwb7tOnYaexytwbK6JTxv8edmM6rmhrqkYZ7aJ3o+9KxTpa47DwsCEUXWK9l2IdiLxspedJEj2CEypMFvDKJ6che1obhdXYEzCLVWnE4Yo03wZFC55gvtcLjEui3PCWX613JdYzZFPczonoTHMeaJFrSRIs18gskVD69fibt49jNUDCxBK1uvPR8jPwJ2paGJbDMl6Hz05mrIr8EbNaBza6/eeYtcbaOdzOLmOeziZlqQIxpExk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hPMzxJeTJzEyGfCEym4QScS4IG12GVvrDRlyLpAhD/iItk0yE7ypflku/jtU?=
 =?us-ascii?Q?C/6M2wyXGnNQYzDPlabK40bGvvPvUWEQa7dz1cR/tzooX193bU6+pv4lq8Ru?=
 =?us-ascii?Q?4Ev9dihnHoNMAPsf6drv4cGsIaOkK3EoG+zKcnoj/8lSITWthV/+Uzc9EA9Y?=
 =?us-ascii?Q?B1Mydyv5b4QkPJyYREOmySmrx74SwMPRWWvE6m/J1TXCt/PPH1ElNTi2r0kg?=
 =?us-ascii?Q?OvUVncjYrpSmaPu6CVk7JGj0UDY9uhIIS8JQPs56ynAGDu+cqRQpiiEvWtLZ?=
 =?us-ascii?Q?1Ev9Yt6mtooW0dSLDdIGo6UmNgJHhcT27kGbuvllbplqtfn4/EjqLBZxgGLa?=
 =?us-ascii?Q?bJY1P9FCUkP55Ev4P1IwHcNQtgpxEYOQ6eNyxJLOHl023c8OS1Cqx8l34FVt?=
 =?us-ascii?Q?GNXX/TRbOAWGMScZ8H0Nnp66XD2yRG330+sMDXszANxq46jBpzeSJwzoMUK2?=
 =?us-ascii?Q?Ru/rw11vjPUqROOryix3y1aTpYDOWWjQD5vobzlOLkyYNPNym78vXZ55ONCF?=
 =?us-ascii?Q?WLHinjF69xq+EsmNg8nQy7F3CiejuokJxjPSaYA8bOylq9aQ4Ugd1CFtQH1j?=
 =?us-ascii?Q?Q6F/JamKPhcOGNhGPDAlzexwSxABDNQRDiM0wvRqIAruRsLYMtERX+jLunYR?=
 =?us-ascii?Q?QLjJmaPBt6B0dtfJPN4JNsquL8laSYKAVbv06Nw3Qn9RTLmToK14axjJlc8A?=
 =?us-ascii?Q?cNcDcfBJpZOWV704zhXg6bVJg/LjZsI63KmlghundSFmcLnT7tte93LVwbtH?=
 =?us-ascii?Q?+JVEtia7t1/xvToK5/kboIBT1sFJ3aD0VjKaIEarhSbuhTGgYUTVsKc8O9k+?=
 =?us-ascii?Q?ltftL0sNVcNlI0e79n/oTKjwOh+CtHLh8g+595p3rdPMT5GGOTLij0c2u3lU?=
 =?us-ascii?Q?FSawdE1FWja4Y40Iv+yBhXwd85n+sYSkSmOr5tnpAbje8h1DotBo4AYiyVtK?=
 =?us-ascii?Q?kpT3l5ZXhYRaZ7auL3/a4y1XEVOKS2WJU7yElzJTcY6bztyrgCmbyVJqWyGA?=
 =?us-ascii?Q?sOZs1fE/rWjjXmT0ob36lpk2XqsQW9lCa0Gh514LM47YT2f2+CYkgQS9MzlT?=
 =?us-ascii?Q?mWAwgn8DYyByFB4BPWiR5Mf8Yq7KxQfxejaJ462s21qMkJN/FaPfE+6IQ1Sl?=
 =?us-ascii?Q?7xBflgzMWw3KA1LpNfG270gfHIaFRZrDhmSXZcMafGzK+zvhxsBwsYttcJkb?=
 =?us-ascii?Q?MeSJ4Fd82vvGRxwCJrjb391zwEUtUx+92HPiq+zw2TBYK6iTeG8PsT7EtSUe?=
 =?us-ascii?Q?JWVvqst0Oz9pfe9T/W4G6ABDE5ZOH2vyuleyt0OzQ1NZLLv27U4nbIoOWr53?=
 =?us-ascii?Q?lr7UHfbuG0dg9Qto11ucqyzUyuw37++tXscl+QGOnu0a4RbgeW+BkHcbfrSi?=
 =?us-ascii?Q?vCdFmS8N0mm/+y1OllN3zEGiNiRX0GeCuzT5AXd07RhDQnw39KzzCE8mdG9t?=
 =?us-ascii?Q?K21cbaCFqy+/zTxoQF8obAPx4+vQUKfbDnsqj5tYml/3xqBLMjL0fFQ+EmeZ?=
 =?us-ascii?Q?CU0nI7CtqTxbHpDm1kMCs27ryfUR39ZVUYZOwlaR+yeX2ahfHFGRZhYmh7YI?=
 =?us-ascii?Q?uUHynUODGGjq2s8bzLcnoeKEQM1idJ37JUqCmAoEQQ4hnSQNhv/XR2Es122G?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd6ee04-37af-4115-d4b6-08dc367cde2d
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 03:41:51.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX19UHCwlk+A+WRDCa1F3tKrOgGJJ1hbGWARuOuJJjtNHTu8d/+ofox3CmiKkC6sQ3cmE1qfqUs9+tNJvyEfjJGbdPKZ+IpdwM5OkA5se/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1063

StarFive JH8100 uses the same OpenCores PWM controller as JH7110.
Mark JH8100 as compatible to the OpenCores PWM controller.

Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

---

This patch depends on patch [1] ("dt-bindings: pwm: Add bindings for
OpenCores PWM Controller") in Conor's riscv-dt-for-next branch.
[1] https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=riscv-dt-for-next&id=2529085831b01fcd02ff58ab4e2596d3b31bcf80

---
 Documentation/devicetree/bindings/pwm/opencores,pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
index 0b85dd861dfd..52a59d245cdb 100644
--- a/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - starfive,jh7100-pwm
           - starfive,jh7110-pwm
+          - starfive,jh8100-pwm
       - const: opencores,pwm-v1
 
   reg:
-- 
2.43.0


