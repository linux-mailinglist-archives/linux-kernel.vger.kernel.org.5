Return-Path: <linux-kernel+bounces-42291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5024883FF30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7A4EB20D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C4C51C4B;
	Mon, 29 Jan 2024 07:42:16 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2045.outbound.protection.partner.outlook.cn [139.219.17.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698074E1CF;
	Mon, 29 Jan 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706514135; cv=fail; b=lJRbJnRDPcV5FRFkC5xjwCJNt8OWzxgG5hgNomsSU2zGLA4JzehTUxpGip+yufivi/7iUHJr05y1Z3R20rVjMig6ANrviOrcpIVfGvmX3mvcBhkHUJ8BMEUeqm72OXmzKwddfknqw3A248ieG6VPMYwhaJsAlv1Weyr/p+msSBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706514135; c=relaxed/simple;
	bh=ZeLWf+MseEMrBo0u8Hp2vx5PONt+Xl710Asasp5NQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LkTaFDYV2gQptZ+QMbfS2B5xKZ8NP6Ietfmiol71rPCz9LcOqRBivLgJbCzAHajq3O5J/jdlywf2+pZq2PdH+B6S2v5AUw5OcStimCyLlFtkKSJJL/8/5xQIr5NF7EJe5J49iW0oqVUyQzaT7b4lo9OAXx0ZzSvRVOpbSwK6LmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuaV4vIfwDSJnmDFFEYcuotpnEdkShU0mLX+Jo1kM5zKtr+qsV5ZJYRpU0SnX4DBEqtdv2NOzntqR417gpZMEe2JWJRBJ2aX7oqaisG6in6mO+4oEj1NtG/WNuf+J/WmZ1NB3TiedI3Mw/49On4sp4SJhsB9Nz2TCUgOlVtrXRRNUk/9n4BV+3lA7eyQTsKsjgH5kSlRcHevHXJJNhEtasA3yL7C5Ma7iFW0v1D2CnrzL159Ln0qtcA5l+VkjmFfnyI/HwufCrLd5EYlVm/CeH38Y8lVB8+cxnGwDsbGC3wnJxmugy3riivS5vC93Rgsu7mY/I9yLOEpm+m4fbfKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g4WEAn0rY0ZEVQhmkCuqGfcNcmqR2OyJY4LtQfJRiU=;
 b=FB61Tsm6xRAptWay4tLpUrdv3iLt7deQ8anXkOfnHo88a/a8yNjpuXTMQVi+DnnNymyvR9+voOY7vBUcn51CYCTqZ//UEguyfuKSwh70TLECEJXaYpqaAnA8Yb1I9emk9PBIPFrKWExHnv01UiNz8QocgrXJie5LdQu/sTRBKqqL7O4uZ6rGsN7jchp7SESYOfTE8B/EnmOUVwUorjHjxoKAgIb7f/J8HR3mit7zAR2ZSj2PVzqZ8lZ3Ei+jgZXTHaYzBNnWRSlxT1W6wcL+WOirPOk+vHQkBp9u+L07I+dababC2ntdDECE3V5tahRIB8TVXzm0s/hup5D0BYT14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 07:26:42 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::8de6:348f:764f:293d]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::8de6:348f:764f:293d%4])
 with mapi id 15.20.7249.015; Mon, 29 Jan 2024 07:26:42 +0000
From: Ley Foon Tan <leyfoon.tan@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: atishp@rivosinc.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ley Foon Tan <lftan.linux@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] clocksource: timer-riscv: Clear timer interrupt on timer initialization
Date: Mon, 29 Jan 2024 15:26:25 +0800
Message-ID: <20240129072625.2837771-1-leyfoon.tan@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::19) To ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: ef82b62c-f28c-4d35-f8a4-08dc209ba3e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	23f87SfYaZN0HTGagOZJc3C9bxGrnmlkq8tGkDnetsxuPyWHi8YFuPRk97gh+jbph21f5Va7rT/LQNM3hWTW2GtwspKVrF8Y8AsSjyYn4d4dpdSnhpr5L4JEFtW6uYoCvETCrPmvmDi5WLb5p9Pd7a20wYULWhay+u9l1Z+WcloLULDkUKSWBvz+XYH01uoXzbkc0tdkSunXBlnw9c9Q0HFMSLu6Mzk+DpKWWLLTZbt2F9U00hmGdNNceUfLJRJZilRlTpTxbcgvl7XntmSCLpThfdRSILcv9SZrs6H1ENFegeNCSNiNP0sPOncySRPNbDV0MCZy7frh+yAnPkNZ/KGfs3GNYxInWUHbRAssM5/pFePr7dk1sRTbsY8LCsFAtKV3Iz9TuupJcneXtqEJh5AIdRXnXuVbJMGzv8Rk41W7erbmcRJXGm8fjXJretlBU5HOXN4FGy3qgqbhfT3vZMgKpzaW1VLETwi84rIDQPnd3mrzSgQiSYn51Mdap8WsMCSHpTxTEJqDT6uFZ+3XvHqHHcfUlrlxlawetcIEfinZImidJUhPDB+FT1Uusp/F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39830400003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(7416002)(8936002)(5660300002)(4326008)(8676002)(110136005)(66946007)(66556008)(66476007)(38350700005)(1076003)(508600001)(6666004)(41320700001)(36756003)(52116002)(2616005)(38100700002)(26005)(41300700001)(40160700002)(83380400001)(40180700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxA/akfTFG2gJZ91gWxUibmFZuGeBVlna4EeTxeStJpMqrBfo5/9yadSQZjT?=
 =?us-ascii?Q?3lq+Do6sXup+/UodeScWAHvteXsjZpqLm/YfX8c+lnQzJQlcgheM0NVtlO6S?=
 =?us-ascii?Q?fOrQ0d+U3eOUUG6IfP7aY3KomLYVxajmA85dVfMIDR+lpXGqrsnWeTN1sgZM?=
 =?us-ascii?Q?5oITezSYxJKTFoL+ndFnFDEC3a5h0YvUVfA0uOdSZsodlM0dLEJ+nQO7VS1Y?=
 =?us-ascii?Q?kWor2HRKsnW79bp+1X9nZMEcJwyuX27beCSY7R8cCiKPZmUpKeqerU8o+GiU?=
 =?us-ascii?Q?7F4LYv8tM2+b5CUFvzByJ6GVNxWLJ9Z7ZDkvgDY5ZWFmZGoJN1gd5I0zxwY7?=
 =?us-ascii?Q?uq9KAtKBRxLXW6kSg31/Vn9STUNDUJAsEsssrr3bsU13y7Y0rhvjlnH9JxT/?=
 =?us-ascii?Q?qLQPNKdrYLW42RaPIqIEwxAixZigBqjqr2IEhTultBsmJZQWr/Y2rENdOdpH?=
 =?us-ascii?Q?2s/+yCK/cyk3SbIUX1blfvyxCuIG6w0t5LV53gngEwl1iMXehGXuJP2XvQ/c?=
 =?us-ascii?Q?XaTrGZkJchsSH32dC0s2XblZM7y6c8dPcZ/ghXC+GirXCj8RhaAOoJNusyAr?=
 =?us-ascii?Q?+BjhIrZwTfHc390hUHk60Dr49kLCDFYugN4yuVfuDOzlcbfnJa4CXP4S5/y8?=
 =?us-ascii?Q?N1GoHZbVRyfSqeeIIlBPE637/Skep45yZMWpWxuL/NjngAZWtQyUIfQNIOcF?=
 =?us-ascii?Q?OKGXtYXN1hOjqzGJQdE9lgtgM1GWr91sHGkv9QfhKlAOSgDzOV4SQm9hFGu/?=
 =?us-ascii?Q?PfL4WkaLcEt7N/XBVyYsPeYyH/iCTgOO8wK5SzUmLPXTC6ER3/2fh34IS1PB?=
 =?us-ascii?Q?CLyrN+tqOju6m7nUe4TKBtvQJ3BX4p2PykAeIm1AAFLrMvhRsi9ylgQZOmw3?=
 =?us-ascii?Q?vwSJa1GFcz4ileU2gWFlY71qxYvApY5nsNwENTSJzrS6DK8dm9wmeDl002CM?=
 =?us-ascii?Q?jbNFowqpZEGiIsCfKwGavcbkGvJbOw4rXUcPsA/ECNti17AHmTdp3R/Cl4G9?=
 =?us-ascii?Q?a7yPsrYIC3YNsJAJLe0pcTKrGENa37W3918e4UJHoy46I+4l8Bj3QPAHtp/H?=
 =?us-ascii?Q?JniAts8H8G0HNqumHaAgFFVDkxZthirGdEAvBiMIBk4LcBReqcGGaR+pkDaa?=
 =?us-ascii?Q?pd6tMAWU9UOUCiaQFy4VwbiXs26G9K55qTzS6sg8yuchk2iPZzvAOWkKnGzu?=
 =?us-ascii?Q?AH49DQlZO6gUTFy2nnPfgDHWBTdR/lZbLHoyqBmMgBdEqS4GZfbgmlfWlILj?=
 =?us-ascii?Q?hH9YkMdcq8tZLbBQr+i6ktbvK05eWWw2s6qfjN9mCMwcX9v02/6tCEJukBfi?=
 =?us-ascii?Q?gqrqftmqO8FuLBLnt8grvYnwwyQi9qwlcblGZsa/9nuoCydl3SHe1QkBsago?=
 =?us-ascii?Q?+BWNiyirdPOPzr4CZnIccnWj2CM/7ZTQfOyRI6Qw4O5zMklKz6Alo3H1mwvO?=
 =?us-ascii?Q?8q5/WgvZ4ORktlkI4KVN2OUyRNGe3mxAu0D3Zad85NEGfBFpJxOD7QmuK6lz?=
 =?us-ascii?Q?WR3OxkQ3pNVdY9kSY2C4VkXmczim1Ixx+GsCgPSQn0jq6YzQd6glrnBYFxRi?=
 =?us-ascii?Q?XTrYwaU4Lkf8lOa0UIhzIw8pdpHTFzlESYAlH9MfT/pXs4HY/hX5rFukv0WO?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef82b62c-f28c-4d35-f8a4-08dc209ba3e6
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 07:26:42.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMWsN2HzEIvVH0pfhL7tA+rQ9PEL4apunBOpuWkY7SMPA6dYZ26UpWBMD8/YaWMCeATMxVwkhPuQ3LVdqvdiHdpXS+h1zXPXhmq+cOyldrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961

In the RISC-V specification, the stimecmp register doesn't have a default
value. To prevent the timer interrupt from being triggered during timer
initialization, clear the timer interrupt by writing stimecmp with a
maximum value.

Fixes: 9f7a8ff6391f ("RISC-V: Prefer sstc extension if available")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>

---
v2:
Resolved comments from Anup.
- Moved riscv_clock_event_stop() to riscv_timer_starting_cpu().
- Added Fixes tag
---
 drivers/clocksource/timer-riscv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index e66dcbd66566..672669eb7281 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -116,6 +116,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 		ce->rating = 450;
 	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
 
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	enable_percpu_irq(riscv_clock_event_irq,
 			  irq_get_trigger_type(riscv_clock_event_irq));
 	return 0;
-- 
2.43.0


