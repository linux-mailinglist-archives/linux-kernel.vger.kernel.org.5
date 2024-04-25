Return-Path: <linux-kernel+bounces-158607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1828B22DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087CBB27919
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF25149DFA;
	Thu, 25 Apr 2024 13:32:10 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66409149C64;
	Thu, 25 Apr 2024 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714051929; cv=fail; b=rXqmMdpETDyn+VZK41IA+2H7eGUbg6AzvTyCUezV40d9XgUPCgRs7IGQYgKKeHoYvfeauO3O0fkJ7e10usFSO0B7c2ulLWLpE5Yv4dMJvodUuMJFHmze/epGafuFv6+o1oGF8eBulTAlZ4Mwu1fU8o3CVpbiXDTM+WxQBLetqKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714051929; c=relaxed/simple;
	bh=Gzfjjvx5xUpjsCj0PK5vRaUI55Lg4WbwFr+njiE0qdU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dc9Fh4sCCICiqvU2eFE61s6VT9aMTGKpCqtdSfiuQq4H9hLLuGAUClG+6YkjVp/Sr2cbj1ZzGq4XMEMUmH2jQ89HHKBxtbaZFFaSTM8OlzFQU9DjAdPlR/wxzeepCj4Z6bSib662aDN6aMg+mqa6OgOsb4Z0aCcP+ddzzfI/6Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWYcpuWXIi85T1LbTYZNC006sLjuyd5XUmYu3ljnXLAYFm4S0Yib/0VpWRTNozmrGsIOYJiuREGJ/tNQ/LCQv1iaZLnf846JQN1d5z1Iv0kPe4pyK7Era+7mRbzsR1jLmPy14P6hF7TzoHkjHlIyYumakwnbaaxBHSJJhW02M7Mt1h4obXyKXzWU0xx0RVjqEeF2U8Poy04KgzhP10ujSv3r/JBIbWe1AIRtIzr0GWY4kKh3HatDo797zMntbDXJL+ctwZjkrPQmFPJPRhhsijA6YoYHedr7NbZxvMa5wxEjy6q+nx4IveiNOT4rjMHOL8wQCEkEFSQcnGOBR780ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MKf75HbMpPEk95Y+rEAI6Rdi5fP6GtswrPZ1dCC7G0=;
 b=G575VTFqSmqr+tuyr4exWBk0y1jqNSKYucG3AtzlFxwsEyQP/v97On9haOChQQoNiFlqKOX757iuWyETkm+qF/1W2lB1ivVjPMrBTQ5/rNbxt73PlczoBZnem6Dar9nhf0uCg8EbNQKByLEYik3t1F5lNhtpLApV8gJ9eEozjqnhTO9o/EtKKTYPSvpwSKfBj11h0x0ejVwWj5oVKZ/+1wBYcHf/d+QXOubFytXtHqcntS48WmDqFFDVcTGcgrUxb/+S2QAAx8ZWkW3TAQtsNBQUzTUsTw+8wblYkIiQqvNF1rr48iyuD4Pw/+/TZz79YFbRV6u3cbs9uSwuJiiDFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0875.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 11:00:44 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 11:00:44 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Yeong <joshua.yeong@starfivetech.com>
Subject: cpufreq: Fix printing large cpu and cpufreq number
Date: Thu, 25 Apr 2024 19:00:17 +0800
Message-Id: <20240425110017.75238-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0875:EE_
X-MS-Office365-Filtering-Correlation-Id: 482caf25-b8a9-4ed7-00e6-08dc6516f43b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9B0ywQOE8Lgty5cozACEqnVYLqbadgNbK85yvzvasmHvMAIFija2T4wLoXQjPeMqxk8gmM1xuDJndGJ4oDHlwCWT+aVCLlfZK/zqq3n08YdZ0VQCGzex1iLItXEMXEzocj6X6oqXYYB/xQK5rDFjtIJ7hmQVRIWZi6ojhbpnidHMstzkNJUdkHyQImI4hHK8FtJReWaU+Nt2oKJPwXLttmVggZxrQtAzZC8MnmCVhDZ8O3cn56+3zbOW1m3Y5cr1wXIV8cGnl1FhPM/Pf4rUYgNV2Y0QKbKqEpQlr8gUOpNAvhXZpTB9IzyYp2/JsDvHce2QSnp3bCUv/xQgWZzdjwJGi5o51voadsEC8M6DzA4liWLyPOE9SdH4ahe4FRAbcTek/N86jtzrXcH2ktxmu2SLkt7/hgGcw5z3WfnJeBrD458lxXG15RR4uz+3iu3m58eThQ02Cq/TRRxwY9ZO0mbJwCO28pviDickjDb/rdk5OZwfGUnKRJafteXsp1rcmALqn1r6UQod9of6fdUHqK8vv3jFhU9A0ResDQV3u5y12Xs0H5oxqrLT+ydV+XdVFSd+mJXey9CloQj5XrvaRz2RqbbAHqRUIdyoeZxCpRY/H5cnT0JtajPZ2FIK9Qt7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ipDg6Ucnps8mS7ZdrVpd/warDX5+zkwfou57ZHWm8t2M8TRi8fyuAqaqs9t9?=
 =?us-ascii?Q?K+B9pajDdmmDyPg6b/FYRO603r8QkWuEdXSQoLFTm28IVKmfFxxliIl8q/f5?=
 =?us-ascii?Q?44ZKR2iokuqI4UWXEymYyLlmbtYrMEM6MU/cPzW6Dn2RDPY8ErDVOd/FAH6A?=
 =?us-ascii?Q?7Z0rsWWDNvRjwDjd2Yqb834LaJhjHiZBH8IP3n9e879yHqhn6WDnT4wjBlEV?=
 =?us-ascii?Q?Fa8Th3O4vgIevqZ2gPPnUtMcJGNlidlDZ5BwYnFSHU31OZ1jcd8H9AvD/tq0?=
 =?us-ascii?Q?rUfEZr3vqWxn9H7eG/7sicBgVuxz7ffxBUALZe1T3EGkw0wAw07tsbZnWN6U?=
 =?us-ascii?Q?4dt3sUKYYhOZAtEtwqOvmlYOBl1Ccz8xxpO+HHjhRyy47PDQt1un8vRk020d?=
 =?us-ascii?Q?mvqTyRD6sKt6LBr1asQUgqz3xewp8VCwIlwfRtS8kGKPepYDk9vH73Eq3jwx?=
 =?us-ascii?Q?JdkLaKCPPoDr0TrARY8VtjTJoNNsNCH1rWHDO4E1zJDMQ0zPehXyAp3iQkgp?=
 =?us-ascii?Q?3YEUw5vOnkk0STk/tBgu2061aWfZhoHo7416cHjkM5S0fzNK8lIm6FFk99iR?=
 =?us-ascii?Q?eJKxb21dVWjcROKGJR+ZvpWQWVvdDG9BZJf+P4Ki9Oci9FUp0vsPiRYdDWjf?=
 =?us-ascii?Q?rvKZv3kruDhUBnSE0MBfyt8iXREiYVsRqa+xPhpojM4LjkHXSJZ+BYoJqvsC?=
 =?us-ascii?Q?O7RH03AhWLHknUGhxWTQLcto56AU01EgedKiEkpeuN90Z40JVtNyfj8toCig?=
 =?us-ascii?Q?Ci5hJAFovc82hHAOPwI2N2Ib6esoE7vWUkDCPx+U1GQsjOJXH4AxTSiszoV9?=
 =?us-ascii?Q?Ob9Bb0WGAINRhA6Xt3hCyxU9ffHNeEXK8aUgsYIilRrhcH16FvXSiIqc6gML?=
 =?us-ascii?Q?FOCB/BtKDZqtn5dU+0jfVhjmlIJEkIihPyTQMH0HLTPr1HL0aWMJTMUSPb7A?=
 =?us-ascii?Q?wpFpnoo5++ybQ50MRoluu/8BORVI8IajsidFLtwEQHVUmP6WH8S5hpGfEtyv?=
 =?us-ascii?Q?Uz2PV8N8+q/lulKJWWl1kdNtjMwp9yWUK4GzXdb92VfyS9Ch+a4fJwkkDClr?=
 =?us-ascii?Q?7hI+8NUZSZUyRtbzqj1JZKFIcvycZ5UDwNgYpAVjrVK/7gtKM2+OXwWVb4M1?=
 =?us-ascii?Q?1ALVCNuLbMxOwjSlamvWz9Og3PzUTp1eE5xOc+3Zvl7cuE2YVEuugyeEYwii?=
 =?us-ascii?Q?iUCNdWVnQy7yKKyfmWTn4fFukXjYBVS/3awkCOLJ+T0y3OP33uNWzjbuOdrj?=
 =?us-ascii?Q?ukWLV8p+im4xiWsy42ucf+rEp2K4H9rBoZbK1QHtFsBJfPIv84bB9zCxNLeO?=
 =?us-ascii?Q?tv5r9v0L33jYyXGJRr4MjQSyzKXlpV6OmwFPU8AG0lxTqT4VqdEBcDyGLiE/?=
 =?us-ascii?Q?+SZgP+AWf9RAqG1+aD5cHGYRCwtNXZ/t8MgD0SmCsLoR9dskZOxVR3U06bIK?=
 =?us-ascii?Q?wIVSIsbxNeF9BIciS86hMw5bF0FSJwjdUyiG5iuM6MZxOj/WtnuGYaqgkadx?=
 =?us-ascii?Q?pAHPoaE9BuVLsA88ycpuBDdWPeimpUOeO+UicReH8wlk4b8mSu6+SkvhE5kF?=
 =?us-ascii?Q?lJAmsokWHGwHxF3TPdVoPJbV1RIssr8fwre2OkvP0hY2icJzitfT+8ouoSPx?=
 =?us-ascii?Q?xNxJ3rxryGpRTODmQSdg7iw=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482caf25-b8a9-4ed7-00e6-08dc6516f43b
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 11:00:44.3352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcpR6DBlBGGycrsisighptH7JvwWMY3cmhBoNcyKgfLb9IIE/LMRhoQGol1jDytdcZ0dBuDS/CoxCXxAPI4mQetLPqT0xGzhl0TsHrpWdVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0875

Fix printing negative number when CPU frequency
with large number.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cpufreq/freq_table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index c17dc51a5a02..9b9568023f3c 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -194,7 +194,7 @@ int cpufreq_table_index_unsorted(struct cpufreq_policy *policy,
 	}
 	if (optimal.driver_data > i) {
 		if (suboptimal.driver_data > i) {
-			WARN(1, "Invalid frequency table: %d\n", policy->cpu);
+			WARN(1, "Invalid frequency table: %u\n", policy->cpu);
 			return 0;
 		}

@@ -254,7 +254,7 @@ static ssize_t show_available_freqs(struct cpufreq_policy *policy, char *buf,
 		if (show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
 			continue;

-		count += sprintf(&buf[count], "%d ", pos->frequency);
+		count += sprintf(&buf[count], "%u ", pos->frequency);
 	}
 	count += sprintf(&buf[count], "\n");

--
2.25.1

