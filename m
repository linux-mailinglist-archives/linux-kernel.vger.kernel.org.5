Return-Path: <linux-kernel+bounces-86247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF486C2C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647FE1F251FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0D482F4;
	Thu, 29 Feb 2024 07:46:02 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F280A481DF;
	Thu, 29 Feb 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192762; cv=fail; b=crlG++pcYjVbJNY+FlSPgy9EeHLZivna6gmH9VrLEQMPBvnsoCk+KoRGJIB4q7AFe5BkwcFN4aoHGUDMUaqWWX+SFUubuZQs2wIUvSl69//qzhVUZGsSPpWAYM+/BRJUo7dKLgWl9+5NskKZOVNwbMfIgJm2X+d8e3VKllIaiGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192762; c=relaxed/simple;
	bh=2YZfhxXTrz6dqRa0HmtIdyOb2+I/bCk2fq1+oynN3gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb76Kuidhuxb/sqwir17zdh6vqea1hZktF713tHynxRKJixU4xVOSVeFiq4GCX0fBRzHMn3DrLNnpThncJiJiujHQdFWfWtX03XC7YPtp17yjdlHilQLpEWe9lDC4+LdEkbXd4hD7cfCEVyPSucdBEJDJc1eJfZY6DFMIOMC6WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZFVhsX8JBBLXxWhvtNSbe1elYezfgQhGaQ/PjfrVsqYHXPPTPdOXFb5eCnvbJRiDBswTANDtL4xzOaMyGrImGXzB6YFAUcvBAZxZBduQjjSc5w/rT4wznsk/86hg0gmDyV1qR6SkxQ8Zt/oVq/3l5d05W0JbZgUY8i0rYPxL4TYQSjtKQwhxqtiai8TlDjf0jwoo9sIZ74VW69MkVxzMMrdWl4Z1zlweFJHdYtoRXtWAqqHpDK0Zrdkgm5/iO0nXkahcJNVBcWApBCeCEIg7HjCv4i3yCMr/QPTeWrKMY5HLezBnhis5U1g9T7hDCh4H/9v0AaadM9bUED3w8H6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKPbgEYhEJkMDhzGNyMD+jRvD2wxpI5aGwtJ0B1ETZc=;
 b=dEIk5KkKsQP7oanCkTyUb+ojZed3euuqHySBFoDgCd/PyYA4n39XVjudR1/7dwVyeF7Hh3L48SbfYAliU76hl3JoBHD3zm6QzUAu2HQ3Hu/PbsJj71UA1Nw/tQGD2FtpX6z5qahKc8zGTYPtgy3iDE88wgCjEL8cF1qFmWmPTMW2OuvNC4UI8BQByr9D/0a4fGgM9FEDsRNioOSk4l0R9HTXu+ytmSa8VRy/3wyHg12bMJcS0f3frSmPJrcPPoIrQAUQGjfA9lX85zpxdvrkS992e3YSdXumQtcmzK99LHycRmEx7aGina2Jt87JaZsKwtc8gGhM4zLGCRrSo83N5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1077.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Thu, 29 Feb
 2024 07:30:23 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b]) by ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::2f41:68f:6f07:6c8b%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:30:23 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v7 4/4] MAINTAINERS: Add entry for StarFive StarLink PMU
Date: Thu, 29 Feb 2024 15:27:20 +0800
Message-ID: <20240229072720.3987876-5-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
References: <20240229072720.3987876-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::21) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1077:EE_
X-MS-Office365-Filtering-Correlation-Id: fa44f997-82f3-4caf-ce00-08dc38f84a8d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LqLg6IhE7nG/DiaNTTAcZK7vBYnYjf3pNA2bpGsF+Ov30ddGtJFQ/mh/nl//qXl7BOYKhVdZpadGuK6xk2bl9mHXqCEHZqJEu04XYEV7xB/5uAknFUyphWidjCMJevZtAUSNkcnwo3C0J++i7HF04S0DS0RlFuL0kfP8y4qJH8wRTpTdVAPMh9Y7B9mTZlhkYitcJ5tjTGfS2zj/H3xsBed6/aNb5CZ6L/TnYe0uNGea0NB1S5i9ye5oKuGCXZ9d95Q0ZVtNiH1ookXgJE8/hJKPvNQApXFAwiR3PUpQbJ/hc7Z1/9SLqEREaGy9Z9X5C/foWGryRIrJJiAACkg/36kHOnhZsgAySbfDF7KzAMY+uNOUBNJUcOuXBFbNt454jRab/bJUFE0anhXjDdUv0qkIp8mtR4/C+PjDxttSLTs5RLpCO7svdQcw52K9mMietJVvZNERLm2GjiAA9CXYJLUHPjbbYKIQ55Z3CNO7E5NsHoVPI3KW+p+xv0Ie+cvsMxzRmh2mM5chAenZT/jlsygF6J8nG9LXp30aq4IyGBVJQtku9NIk3TDhOa6sZ41uXMkwHnaCEEoKhziOwDH5b4RWoe9ZgBfcArusdWPn5se2auf5SqFp6ZmjB4IhakEkElNxQ9/HMsUok4HR1EAx0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Bn/lEo3Xpgm3QLv/CMZYmYbhrVtao3YvOuQ95l1N9AhMr232tQBPHiBs5ZH?=
 =?us-ascii?Q?yx7BwAPa54Z5PIbJTjGoDuoxJ357r4FtOSTx79H47cb6u6ePwrAiUMv24B0M?=
 =?us-ascii?Q?3TUfFfaLv6b1JA9bgbxHIZJpyhdmzejXihiJmk9SM//LDEnfl7Z3Z9P5Nlie?=
 =?us-ascii?Q?izVtd2hdFiPoN2bHGsChsqTXrqWFMpOwNJRfwkBMt20enKiVm3rRgYzFBSk6?=
 =?us-ascii?Q?gsdsK1hsYuH93XkB9Ytw5wLsj43bjWKPUpg2TtqRRbAcyn3D+77+vdfUvk7g?=
 =?us-ascii?Q?Ji6dd0SqADikLqiCrZDH6fNLLqCF5jXOH/thzkZpOrvboi8/C0HzTbKBHjxh?=
 =?us-ascii?Q?wmzSsAZW+NDPyqjLshdft5GahjT0/yTddZPafifMUWfAkbBgvUbhS757wIYH?=
 =?us-ascii?Q?zUgsS1DvDpv8vbsNl/fYdTuTefWPICY8sWvLXQoU13EyqRfUEL/Ft3ORbyek?=
 =?us-ascii?Q?3W7/APZ+Krfc6irV0GCiO/Ex/0QD5lcQnl3iG7RL+CCQNFZ/nAb/kUmqy5Vg?=
 =?us-ascii?Q?QnNo5BwVENqVYEZjhkJ2b+WpUhxYwFh2ueo4MNAzs0VG+7dYG+6bGqreIFMn?=
 =?us-ascii?Q?hnxryNN0eBri5N6v2fMscn+PmaEpwglGTkxh803qJ6l+mGasB8vsrz8O7JY2?=
 =?us-ascii?Q?NslKQsUITHitqiC1lVQ5o1IanORq2iLOf665rfA1yPQnYeQl18IjAMGbLj9j?=
 =?us-ascii?Q?dANuq8gHBVCJ5qoh7JvS6RdccXqTcmZ7d2sZ3WszEuHmjCQoY1K5VfoRCK/i?=
 =?us-ascii?Q?6W8h3bkQlkJ5EJzjHMXXt8CwsKZc1Fik1W1IiWoO974CLUQ2AO3GLFShei7h?=
 =?us-ascii?Q?gz0JlQNjdGbMo/uJwFRL+3BEMe7ZSu7uRdsuykhkkJqNqzT0x46VQMfzKhgS?=
 =?us-ascii?Q?IyaSs6QlXkJnCmHah+xFGBhYk9+q8o1OPWJlf5xT/g7ePC/dMxokilU+9s/C?=
 =?us-ascii?Q?h91d/XVrZ1UhRxppvJV6zTjANRpvuTdmxwBsLoZlfiCaIFk6cNhJAlr7e6d/?=
 =?us-ascii?Q?s3AD6HkT0gP8N4BW21zLxiadydmS9LWnWuEsxtyB6CUpy6J9bg52REj5UUWM?=
 =?us-ascii?Q?pzfqsDbdnQu3icVZTMyzkERp82RFG+Xfopq6f1PZzvJEisi6TdJY2V2mN0Nz?=
 =?us-ascii?Q?mg5pH4teOFQmHW0Wx9ybhLbSGBfN2n46DcWq2RYia1//Cw9vIblgr1BuSPsE?=
 =?us-ascii?Q?QZG93Ge6jXQ4/Hy9JT9qw+TF40qWWn+xx7lxD0u5pVoPZ/EEBXEUP3vSfIcq?=
 =?us-ascii?Q?P42fgqSUs1RBc0vu8szssM+Qd/s82yjuTteMILz6LChOpKMjIZc86jIItAeI?=
 =?us-ascii?Q?/Lx5cMT5/lYGK5jgFioDuTcRZTTD1/4ADAEGvsJOPYmDWBIHPBPKBylP2a9W?=
 =?us-ascii?Q?8oLPN7Ptu1tgnSogJOjrG0xk49qBHiSAiW0Rp3TL/ae1fgKlem5i8rKfBsNH?=
 =?us-ascii?Q?FzIYndnaYUxfDYXFIKv1gn6ZiIaf2LZWgNXEP8gNM4g2KBYCdB6rhlvmbljx?=
 =?us-ascii?Q?ogeacy2VaSnCQDptyi7Cb0OOB+lf6u4Wls7nhT1ZnnxqSpfsCrq8Hz4fm1g0?=
 =?us-ascii?Q?E31RgHrHPDq1MbLJqkJZNiuulu37jEJe+rHFJvBfm3FrSrOp+FUtGVD6Ivzc?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa44f997-82f3-4caf-ce00-08dc38f84a8d
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 07:30:23.5523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdVpWc6Do7Z5aGTguVB0O22WX/6wwUj63lDRXZrDjHhCEkN1yXPHOFfaIPKnl5muw+ZtK99v0vMyfAjvlXuXX9PgT3gWeujrQBxnJLW1sEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1077

Add maintainer entry for StarFive StarLink PMU driver, and mark it as
"Maintained"

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f51d5ec1cf..5c4b2ae90823 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20742,6 +20742,13 @@ S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
 F:	Documentation/devicetree/bindings/soc/starfive/
 
+STARFIVE STARLINK PMU DRIVER
+M:	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+S:	Maintained
+F:	Documentation/admin-guide/perf/starfive_starlink_pmu.rst
+F:	Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
+F:	drivers/perf/starfive_starlink_pmu.c
+
 STARFIVE TRNG DRIVER
 M:	Jia Jie Ho <jiajie.ho@starfivetech.com>
 S:	Supported
-- 
2.43.0


