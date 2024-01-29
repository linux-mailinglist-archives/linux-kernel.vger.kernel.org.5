Return-Path: <linux-kernel+bounces-42126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97083FCB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01CF1C217F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1911CBA;
	Mon, 29 Jan 2024 03:27:47 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2046.outbound.protection.partner.outlook.cn [139.219.17.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2D101C4;
	Mon, 29 Jan 2024 03:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498866; cv=fail; b=RcLViPlulG4kg9ttJWrHo+IoV4v5Mfj+n+4XbctO/B3YAyXAWnV544b2ziPeSq0k89dad2Tz59wt2eKyhYjqD7LXRhabkEnvDRcd7jaZZV+5opwigvR2kF1ZXR/rGF2mq92J750mojSebOo94L2hMiVtQT3Db7z8+ATEQik1Djw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498866; c=relaxed/simple;
	bh=QKqeHAbUT1Ej/GLbJoim88x+5yvxv9M/4fQzBzlitYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPjd+7Ii1zZoD+uGT0EAlUgdaA046J/apgpcIL5YDTO3PHNAiYzsVCI352MZC1OTgKAdDZbCpcfev/T752Kg4C7gRpZWF/KFC226S6sxCUR2OA+3xbBB6RL112Atu5AnzFProM4N4U5j6HJr4cbigLCsXDE9/6WeZjat53EZ1Z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX8hMNOKI0oP4PiNKPonvmB7tp7LFZXqR22+YdqOYqzfr+R+t9R3QgjfQVyaC5owCWjIwBe0rAbB3AYzj51kgf+SqlWEIaRFLL14x/mMFAurimOn1Q3k05AJbbCeyxfFuxoVVEJiFh+fGkdeyXx0+2RIvQQ9eBe7EIX8pWyHGEyEh6tsxt61VN9Xe1lcCnMqSoGQC8SkWycGtmpwehIarAOpkh8dMGu8diUVKT9sMt8cm37jpEtShycCkNu07ATIfOXBMLce+lh9IAfW71CzRRBX0AA9UQZqyvyA8JS1u/FyDZA50dN5Ht1zyCGCqIHU92zRnfkkTBFv3osAhJYhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EW6Po911gG5y8Ii8CnLc78jXPj93P27vQBuucUB8LVE=;
 b=eqlsjaz34w8YgEoPZHFob32NlJBSB/ovDnzFwkIO5f68v8iA9P8JKknobJqPfEkLn41ANcTTyz6kI0yvVsj26U8/2jGRavWXCS4qnsUDocdzs+zaGElxuw8FwlrM60v+8EdvafcSD2NpBNPfLA71HURNrFHNxnbWWWb0PsdF7h/YB/lS0wgWiyNbCzMfzWfHletNo8T8Vywn8BnGGX6S64XzcQeVx2aM8W6ataLClLig2Wj6UUqMip+zj6HOtj8TTuy+8EMgIQvhGD0voHDka+3CdsMkNjT1LeBbi6eONLo98l1F2aAReQmqZZUa3DHI3K5jw1xmRpOFXhce9MM7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 03:12:50 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a5c6:9ab0:d20f:cb78]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a5c6:9ab0:d20f:cb78%6])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 03:12:50 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 1/4] dt-bindings: vendor-prefixes: Add cast vendor prefix
Date: Mon, 29 Jan 2024 11:12:36 +0800
Message-Id: <20240129031239.17037-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129031239.17037-1-william.qiu@starfivetech.com>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::23) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8bea9c-7aa6-4fcd-dc6b-08dc20782cfe
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h0TH8pVxrN5GvcQp69dnsp1+Zx2QO/O9J1hDSUu5f5DOtZXjJ71hT/V1KCTR9XH8gFLQ+6JOg1Tw21hTulS+DPBV9v1aD2tg3zOCokZPU12+AtbyLYIvK8DFSd/yi/frtweVdXcW//18MO2qHpfJwaDgZo4VuX3FnKJwf0TMjytm6DW5qAVchbewbO6MAGzlQVcjbMdCBLYoIkZPjEKdNhidRSO6q5itDc9Z8afWF8GCgYJDuEingMd4Vivb5wr8BBJImRg3DEYHKUlnWAzSumA+tzo4iHnTH6m8CiXKjNCbKdoFLjB7EpFhFLScyhIa+sd5d+qqSx+04xH7YY2WgFuGLmj8SrQV7Fo7CRXHd+OKQDd7LFc0PaVRxqxpItgmv+Yh75XtaaB84GkAsdR3ubXqfMqqdWqRsawzcaA1XozosdZKhWqpnjt5hiNx0PRM8heBbQUDKzVy9hS17xB8rilm2CLNi685RI0DJmSSE6JP0is/3d8WpczcmEgAl7igFpTneSgxziAcraomqhBkOXRgdAbMtDhN9nyL8fzKN2HR648xcFrjBz3r3/luRPE+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41320700001)(4326008)(8936002)(8676002)(7416002)(5660300002)(44832011)(86362001)(54906003)(66946007)(66556008)(66476007)(38350700005)(4744005)(2906002)(40180700001)(41300700001)(36756003)(38100700002)(52116002)(508600001)(6666004)(2616005)(1076003)(40160700002)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZV/g2/gwM4RJE5cYO9hIafbZZ3IHSOXyiuI1AYUVbecfqPD/a8DEvrduVdG?=
 =?us-ascii?Q?oE7t1PGIuCRo+GhPzMWG/WbNP3stPUrA839pLaVT/6kqPAS3Sa7xibZDr11e?=
 =?us-ascii?Q?BiXKaepBXu9MF1CzkpkSXcQY1bpLDOe0/2xlJnwRZMNp3NWit+PeE/VZLk4r?=
 =?us-ascii?Q?cZF8csakjBu94wCZ5QtQVg339YrNVIMb79mLvOPhZKFFHpq0Giq2eCgHxpqt?=
 =?us-ascii?Q?P5WdlDm2ucWrnqwAHobUxcjY0U4IvaGg9CohhM7npqMt+ulUukwcHtWu1tlt?=
 =?us-ascii?Q?V+hDMM68lZFXOWl4xo0Bn2lpK8Jzk9sjUn8FLDGz81ywuvN2zsKniXf4i5rp?=
 =?us-ascii?Q?ayzjOy90zg7xwstlEdYg2cQC9fwQ9utQT5Pa0MxTtsvl0ewaK2Wa9Xj8tJGH?=
 =?us-ascii?Q?6YOuWktD9FhHN8mB8qB0D3Rxx6vzv3lKX9DzRPNKQHoRE+abpVHrKZBy0L8v?=
 =?us-ascii?Q?O8g9vLGd1T+zW0Nm42+0mG32AbTkmjN4mwxCicGxaiY+DbeMCXS3YC0tkAAk?=
 =?us-ascii?Q?gcK61Kc70W5Bve31cx2dj3g3YUaNGFkJJPouDXu7rXvlAM0wWV4XQPeaNWnR?=
 =?us-ascii?Q?7K7g7RJapaFWvMnpt7JXipXvO63qsFpYoBnLJqJoE59g+VLaJXJAZJt0BMV0?=
 =?us-ascii?Q?j8Zq7k7qGSUz9129PKRS/6Y+HSKfWIVnyOE5oBylEmZjgdTDURdBa0wKKrdd?=
 =?us-ascii?Q?3r9uxjE2VaMIVVsn7bLsFowTyKaQDXd32I18juUVyuSTRDeHBz0zs5KB8bDy?=
 =?us-ascii?Q?i37E0Sux+wvQW+WefeQo94Ed31z58xEEtJopJBT1lV8NawzoAN6wgJnNtA0b?=
 =?us-ascii?Q?5fjpE7KuCV3GPySgEauwsjpAqIncPnYJsRWWsp34/zu6ogTSMwMGQF3LHlF/?=
 =?us-ascii?Q?hQZSzPEmzzHYPg755dXqo5+UrtEhsgX1QNttm98RC30XR8kQ65kXznyEk1bk?=
 =?us-ascii?Q?OPJZs8Lp63o+FyrJ3Bpi2rpf2Zm7CkRGsyx/wVx/r0Htbtl0PMfVp2VJ9tKT?=
 =?us-ascii?Q?BtEL75YXFERZe+TMd8YDaB114JpQTPRsu4GqYhEm09sErDfQhRkX7MB4zRnf?=
 =?us-ascii?Q?4rWJCjoyEIp6hGNM54gh2806tQuOd0doz/UToz9dweirl1sbPNgWNaRT+gtO?=
 =?us-ascii?Q?RBLDnyLUAeJI7uZFOdoGAQ+rOJM8KIW4jZ7bHq4B4mvRHG4oM6Wtq2J61INb?=
 =?us-ascii?Q?lhUTwHu76Ii4LuaAZOZSexUXdXNddy6CUZRchw0mWJqQ5vwnXW4ca7YL+L2S?=
 =?us-ascii?Q?nC/jcJ85jBYG7m75cWys/DWg493sUQjYrvjRenRxjTEn/XI+KKspyqkxgCyc?=
 =?us-ascii?Q?ZoVL+PFUyj/RrAHDYHmUPj5wTUoGHwA+TFxWuQRDJ3Hb8RmQw32WB5hCirRi?=
 =?us-ascii?Q?fMA0fskS0Otq4Vh/LIOWbdKvp4/giFKdUUiHUwob25jRWYmgGo57nSQE71cZ?=
 =?us-ascii?Q?anJdJD9tH/KWKOEz6MrTla8bojmq43YlTo/Me0EtKfJwG6IncsooCdedkNZe?=
 =?us-ascii?Q?kXrPHweMRHcO0KGxcUTxgm1M9fQJOuUkuTFgiooInUcJPDeK6EVKY54gIHBX?=
 =?us-ascii?Q?KgM3rLNYu3551S5lGSrPrlUj5qjVgjy1YBd0VEqguc221LHHJYZcOM73VFIh?=
 =?us-ascii?Q?ng=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8bea9c-7aa6-4fcd-dc6b-08dc20782cfe
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 03:12:50.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N++BlREM8DqjTCOF56+59EqilmQkTqKnfm5ct0wlwZ8WuJo2BLQ77dGkrja3kJ4hhmnkNwiKxXc5lj9CcOeljCwnVXEpyFfrTYc69ciSg+c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1253

Add prefix for Computer-Aided Software Technologies, Inc.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1a0dc04f1db4..b9c6ce99d24d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -242,6 +242,8 @@ patternProperties:
     description: Capella Microsystems, Inc
   "^cascoda,.*":
     description: Cascoda, Ltd.
+  "^cast,.*":
+    description: Computer-Aided Software Technologies, Inc.
   "^catalyst,.*":
     description: Catalyst Semiconductor, Inc.
   "^cavium,.*":
-- 
2.34.1


