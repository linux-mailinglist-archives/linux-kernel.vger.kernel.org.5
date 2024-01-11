Return-Path: <linux-kernel+bounces-23582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BD82AEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9601C23126
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA82B15AC5;
	Thu, 11 Jan 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="BiX/OEh5"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326F156FA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIFQSVdN24QoLOs30i+7AXa1KYzXFoTW0WmfJzkgB3KxC1H4+t/Uqzx0OkCE4Z+WTrneNBIjChQsj/m4TP1Bmbp5Kp9NG4ggNUtZuG8qFo3CREL6GZQIyYe51zhHlC1vbiDUPYnU6SMhUVHiHTVdyg33ALQnUhPDP7fTSQAIU7fxAZJhyR5uQ9EjtKx+1MDst8cnzTRtLSCbC2nnlLGn8BQYiGWHAKGY416UHvTxklCieNk5ysF8r6lnVuRCna/IynCWxx/9Ft2wTKOKrqPeZW0+Jj10cdG1t3hI5QdlfVTe+coCngjm9tGkkIdGjJbUbSwDch43fMpYnDLLHa8QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MONQ5ooIGOhwMlVd57AaZEmedXnwBUN1ErV6/GWWVE=;
 b=R/MP6u6F/+IfiS3o0jI1R/Pw+eSyghHez/mPxuLNXKFVpY41zbq5LMCz484SmxPVp3QQXqwF+hv9pxf6uLwGT++R2DvpJPC7eZ2qpSvJGNPVdIOgbbqeEZvCH6+ZXEoANu7smRMoB1x2ubWJYDTrVhbTyeeSsHH12sV7PCzAoX3gaHwfemnPS0s5RKrEZw47pJGgKuNV4fEOVAG2Q2si8v4g3B111GdXNdsvxv/04R09/3fY5uaDB0dQR4rhTjBAS21y+bIdgvbt01sjh+WmkK4O1tWLWwulM0DOnnK2xAE87IvRzUHBaNW4NwBllf10FFLcPXEwD9QYsC7Eqp4eZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MONQ5ooIGOhwMlVd57AaZEmedXnwBUN1ErV6/GWWVE=;
 b=BiX/OEh5Q7FNYhbAesbwg7oYxl78Y5HAJEMzxfm7SjsObpqTTzHlpSrWaC8RSpTAqTMhOXHQlH36cd+vHWspXhZV8KekZMx3rCc7CVeQjGkPrF8xNo7iNhVyxHl+OydQh+qlZQB3kj1JjkiXreA8l/Ss349TExUM2LgNHlmwtIm5bQE77h6WatmuiuqmYz3BrNnn4O93WJwlZo3za2WpelkUIdj0ZJSkOX0O5IKy0Pe64EaIelW1uROrdaDxhZx3/sj2Ks60srauM3xDG4emK9sID1BPp2pkG+/LD/Na4mMOODNWsin9pW4Nucy3OvLfINYgrTDgLnlmNgaZfi7MKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
 by SEZPR06MB6958.apcprd06.prod.outlook.com (2603:1096:101:1ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 12:25:03 +0000
Received: from SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81]) by SEZPR06MB6871.apcprd06.prod.outlook.com
 ([fe80::e954:4698:8499:da81%3]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 12:25:03 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v1 0/2] *** SUBJECT HERE ***
Date: Thu, 11 Jan 2024 20:24:49 +0800
Message-ID: <20240111122451.682-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To SEZPR06MB6871.apcprd06.prod.outlook.com (2603:1096:101:197::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6871:EE_|SEZPR06MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 7137849c-31d9-48df-d9e2-08dc12a0566b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	goKF228tjTNzjZuuui4ZaifjxvuzebVweLGYRRUkb+As1a8i6zFyPCo6+TlTPAqilZFkpez5NoJtTs9PybsxYGu9JPGjZdd8iFl2spljpV/mx6G+w01jjKL+/AjHOKsTQ+FxhSc8tGXluqydWgBivEyJhLRMNWX659kWqGZMh92MH1Djo4KJJusMPwHnNeYwALFmsBg323rfS07svlh0prFZpcoWROKY77pMwL7KrbjQkbHbwBQHoL3gdmlRLgepCrj/Mj1keVOHQSF6lAx1aPtkAYJdUCgNB2jDe7RMRivsL196H+6PpSQ24CDpC8m1E719pRbrn7nJylLWmEnBMSdNtruwlzMhLmU/Y9Vetf6e+yn6EI2TWE3BRHMajX6AcDLFgQXn4hoteZqHRE27E4XgS22/nZW2Q2us36V+VRwnQSq+fxKymUK7IsXTLpoVO75vDfJnnCPb5SJJl25R0W0ZRMmXMRzvZLxsRcQpR1BdvkN9qxAMPZj9sQAMxnt/T8/iUtS1HKueT7wsfyVkay3CXnPVk1WkqvO/R2pCDRco+YNjKkfzuEwJM2OvEattkf2KgJSKIi5vpCza5qiHbuCC+oVRtGTkQ/tBIx/cFK9T/KTQAe7AkbSyM5q86MogygezegPHkx7GhY2V6gLmOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB6871.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(316002)(110136005)(6506007)(52116002)(8676002)(8936002)(6486002)(26005)(1076003)(41300700001)(107886003)(83380400001)(66476007)(66556008)(66946007)(4744005)(4326008)(7416002)(478600001)(6512007)(2616005)(5660300002)(6666004)(2906002)(38100700002)(36756003)(86362001)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zVjG5SLB41HmNjaBVXLJY4dx4uYUJF+HelTMNSNjtauqpefRdHmr2agE5b+0?=
 =?us-ascii?Q?9Ve+pfktr8EPbjuHjoWLDtl11/VX+4j39oybwYhCoUziLvf2+vAS922CxMlw?=
 =?us-ascii?Q?zSV9sPOZnlYwfjK8qKCRrwtmQGd//LHB39SIbaIgODvizEJZeR3zEEv0lRn9?=
 =?us-ascii?Q?SdnDjbr3JanImYYWiKf1YRM2v4ZcJQEjxfGlsrPXYnBMKReIX9J3CL40F9oS?=
 =?us-ascii?Q?fQ8iDc8Dd2uTbDSXemmJ4kQ4Zw7AneNc8M2buwos1DEZIv1cpWpz8nnYfdJu?=
 =?us-ascii?Q?C4hQzZFD4Bv2WTqAONTLgDbYtBTtaSq8sdWRDwqxjlAAhkZadZWUinFmnWaG?=
 =?us-ascii?Q?sYjEywkX9BvKZYtAVmp0tPwVbwGwAZ+DYRTplh8ziGRapxYeyIce9N9abHEe?=
 =?us-ascii?Q?ki/9usrkY2w/e0SFIt13S6zxl+H/PQ9jIZSXimKNFgCc4tPzuOzPfoLJaR8M?=
 =?us-ascii?Q?bmBmDn/TQj/TUw7IIS/Pwz2vs3mZMgGDbjHVUCAe+StINhKQ7NTu/UJ+IS+9?=
 =?us-ascii?Q?IgnEC44kyQSoShqozlkYn+KN0gsvlwRig24X8i91wl+8foTcsbkzQEahsdB7?=
 =?us-ascii?Q?YJQmh+0dg5zJCor85yXKDTVnE56SQDiXU2GNO/GPsdo0YsG2to5lHyavnuz3?=
 =?us-ascii?Q?hVNdXGnhDZrtD5zOtn7KC4Yqv93FB6cHTfCS8/1rSQtE1bBb4WujPnlyKyNw?=
 =?us-ascii?Q?b0fWEKnDUJGos/5XH3E1ul0qRoatBeltjdKBEbRRNJlTdD2Hs2KUlNieC4VJ?=
 =?us-ascii?Q?PTwB43r8CuWcZjaaZuhhxEHywYc9ewT3kWmhPEV8pqedkZXgA1QOMglh8sNA?=
 =?us-ascii?Q?A4CPUPVNNY2Lvtq1dpHXFHPX69aOaWGrY3LMfq1TDaVs+86MoZOz3SRly/I5?=
 =?us-ascii?Q?h4mHVIvE62D1oHOFkpGwNTJWwjYP5YnjrpNIcNSEJct/jawxmH/RxM33aotX?=
 =?us-ascii?Q?SdUM+lbEnSKjnDgk8oMHv795RJSLseVoXxXKxRX56e/feuNhWCDFhGHznOs/?=
 =?us-ascii?Q?77VI2FOGL3cPJg9l1H4ijO++3xPbrzjufv/KLQ4Gfs+yj8ZbWu3qXFKIHB7+?=
 =?us-ascii?Q?GvefZypqc9sX2PS3mA9clUrsEcsh2mUOMJ1Eph4H2z9lnm0brTgsFmalRSBF?=
 =?us-ascii?Q?HC092tcAfxtFmWvto7iteY+paSMbPbaeGVkKyyZDwgxOfyDBEciHn7irwctC?=
 =?us-ascii?Q?ifzFImi2+G+WuxewB59rjaPslyEjdzQKWYl6A0CXck4b+q5y+QxUnopcyl+c?=
 =?us-ascii?Q?6oZNJqiNasH/l/re2ORcZsROkTzQY5gGWpm28oEg9YXweVQ/MqmYwNPCmMkU?=
 =?us-ascii?Q?ROwlyLRBt6aLCHYbbTZu9+Sw+tpRp52JNgAWulpoMURwtPuWncBIRSylH/Zx?=
 =?us-ascii?Q?61DDAO5buI84ImyW1THBsQGGBZwHeB6BtaietTfiPJ4NO7QQV4Gj9I585M2t?=
 =?us-ascii?Q?EcbHyW+rnEwW0bxYwkt+K2da2il2ObKxny1gKFVJe/3vkhWbR2X4s8PwSyGS?=
 =?us-ascii?Q?//yNWkVk9ebtmEkdyCEdvyidMXkYfmgqC3D8GxW3sD4IsPix+t2FTUl4k1ap?=
 =?us-ascii?Q?y+zPp0IimH9LxtZK6bTyqnmRRgkDE/LZpiDJwb7V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7137849c-31d9-48df-d9e2-08dc12a0566b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6871.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 12:25:03.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljQysLh0AS1CXyGWatmVXURUflouTvL6avFCmvoIqR/63wXZf1V5rOzGX2Ri5vdOo94K0hwqBZHCeTTh/VMf/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6958

*** BLURB HERE ***

Zhiguo Jiang (2):
  mm:vmscan: fix workingset eviction memcg issue
  mm:vmscan: fix shrink sc parameters issue

 include/linux/swap.h |  2 +-
 mm/vmscan.c          | 46 ++++++++++++++++++++++----------------------
 mm/workingset.c      |  6 +++---
 3 files changed, 27 insertions(+), 27 deletions(-)
 mode change 100644 => 100755 include/linux/swap.h
 mode change 100644 => 100755 mm/vmscan.c
 mode change 100644 => 100755 mm/workingset.c

-- 
2.39.0


