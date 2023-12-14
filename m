Return-Path: <linux-kernel+bounces-244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CDB813E34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11102834F1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AB46C6F2;
	Thu, 14 Dec 2023 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SLrLOTbe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2125.outbound.protection.outlook.com [40.107.237.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1286C6DC;
	Thu, 14 Dec 2023 23:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HReOnvJnXr4AnsKbSEz+03/0dwAgkaSQqPL+KPrCeacsZlRXndV+JRm1QYsU7gdDmY3QGPD6tEZG+THl9R+eM4XWJmN00kRCaUcwNYlQHUVm9hZ23K6kigNj7kyI/gcNwlV2jKyOTPE2eIa4QIC21+ZZhoH9ShMk9Hjh6mVVCWURecdy0/89c5AuKKYzOhtiqeryxsrOdaUVZhO3qaezE5KMuBQNZT+zPbmirsmDt+N2xSx5qxVNelgxYrM8lPvX7B9U86lppXHxhroaPrStCQSAW7kWlcmi07NyAp1gcfh8obvstc8oHCOGDJlJkpsstn/sGprgpIgvb9vJHPDTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuOcNbqKy8De4K1d8lgrz0FFUECj+pufxWS01Q1xl5I=;
 b=O59t8uMhmYAiJ/WK/JlJcxmQexTnG2x8A4TpjsyBLZYxDq5WghTpGRD+dYVptJBd0zyAkODjAJNlLDRXlOMwyeY3SEQ0cczlNl+98m46DlS+KuNcF1tW9msdaiAsnzlSmkJjoYAPKo7fMdueyYGhG0C+vzLPkxfaME8l58OMko3kir1Y0e720IzpTuTX9sAF2Ps1p6vvHByJXjN9hFerwPXKdQdCT+bSxE7m1Hi0fV28qFZdcHjf7muovgkyt9sQqNtjBQ6pcV8it2YO0xKu6JHg9Hz+JXnlePFjz7l3zEqZCRg7j8OOvuCwvVV5W7fEOSi5KG3tu1W2pUFLMEgDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuOcNbqKy8De4K1d8lgrz0FFUECj+pufxWS01Q1xl5I=;
 b=SLrLOTbew53DRraJmFDqQ4Xl91cF7UkioutwOiKoscZeO1WFYe1gyxOWBkTH348Ttnoupu5AabTAxvIvhRieXTg5r2ekaJ8R7S5+RZrHvpZdDkkGCZtFM2n0n9xWhVHU89mdjAhIgqH4ihVxQCiEJURRb0yEAngBH8eWLa/2DTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB8113.prod.exchangelabs.com (2603:10b6:806:35a::6) by
 DM4PR01MB7547.prod.exchangelabs.com (2603:10b6:8:5e::10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.28; Thu, 14 Dec 2023 23:23:36 +0000
Received: from SN7PR01MB8113.prod.exchangelabs.com
 ([fe80::7ba0:ac52:84a0:caa0]) by SN7PR01MB8113.prod.exchangelabs.com
 ([fe80::7ba0:ac52:84a0:caa0%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 23:23:36 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	pabeni@redhat.com,
	linmiaohe@huawei.com,
	rostedt@goodmis.org,
	leoyang.li@nxp.com,
	luoshengwei@huawei.com
Cc: linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 0/1] RAS: Report ARM processor information to userspace
Date: Thu, 14 Dec 2023 15:23:29 -0800
Message-ID: <20231214232330.306526-1-danielf@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::10) To SN7PR01MB8113.prod.exchangelabs.com
 (2603:10b6:806:35a::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB8113:EE_|DM4PR01MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e960366-4e66-498f-143b-08dbfcfbb23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eYO5FqHTTLiW4zgjuEinx6b0kwm4tbpzLQy/2/ZYtxMKoTZOwPTvw1z3fxOxWtNNlxMXwi+TrJEifd1P6bPzuCHzTy+Pm9RX6cD9dTXx8IVz81GOyQCn0m8smUh6Uxr3dIocK5KZVmgal8TTsKxcr72FBRNnnsngW4zeG92IoULelfY7MozprXFUG89MdnM0DIuA+lrAqED7/5FrRqR/at/CpHW4RpFqGTjgaRQYmer/Kcw0aJKRTaOxhMW7SCvvHliEQd8pJNW91/bH8raPCBPPUb1TffGa+xbi9jb7Xzp/VLZP2So4qnquBqdR4i75xWyjX1aYZLId3ZNne/EFRA6/vOsz6nqPAYDSF9qpUFokcaJcaHOyija8XLk9yaH8TzB4WE67qOharpYT2ErWLvZpeu1wAgxQ4luHIeLZ1t1aq++hDDNQKpPkXgoRar9tcHmwuQQy4mu3MfyKJvsVH6uFUofYD3Bhk4FIoQy6J3vby0zUr+Kw77zdLrddQTfNTYXnokV7Mt/7k/DdZE89HiZwa3JuwbZ3lpQZciGC5ZW5AAok/uHmW8N3gZWyW16fs2qn/jArNZL9Cfc4+m8MgGQIhaylIKSVy23FDrvKJxgOo5U52qHd0bggQZB6Dk8E
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB8113.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39850400004)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(316002)(66556008)(66946007)(66476007)(6512007)(83380400001)(26005)(6506007)(52116002)(4326008)(8936002)(8676002)(2616005)(6486002)(1076003)(966005)(478600001)(6666004)(4744005)(7416002)(2906002)(38100700002)(5660300002)(38350700005)(921008)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7f4yK0ujZgKIICM6SjQd21mEx+J3r3axQh1gKnM2b+NZjlgtGKghQZyLuz3?=
 =?us-ascii?Q?RaIrzmeeYFPSnDVZSrMGpsZtOFji852VPRASZmjYlyVuySYq5JHmYMaJ9Og8?=
 =?us-ascii?Q?pGgrIWXunC3qE9fFRa1EHntXEfvOa6pk+J0Jx98P1ZkMeOv3nLl/4vdOlCPX?=
 =?us-ascii?Q?etFpXFPBBZg1EVAzfxn0zOn6Bl9I+rIsU4O97wkyCjPMGCqHpReHOzcdWqEh?=
 =?us-ascii?Q?dTw3vZ1+igRhBrG4BRIQxj530n2d/w4BV1rgpmWatIg/d+QsCZUgAlh9R0r/?=
 =?us-ascii?Q?8t5Is1vpwiTRzddcHdbZfFiWNMAI2vMHM6Ou8Wyhmi6j45WuxVVZHqHyBxUC?=
 =?us-ascii?Q?gKJlXHBd56eo+E/aR8xCoos5ZWCPIOW8OXBUZ7RfWoASv/XNhqJcWtq+/Dkn?=
 =?us-ascii?Q?TfHll9vuUBgmAmuQg9Jq3p18gfJSGT3CR7Qekp6bVeR7Eo+uq9yisANMWzkM?=
 =?us-ascii?Q?Ift1yn+JgCrXc+1F7NFqx4D/dk79ntOwahcrXYYbe1OGHifTt/nk+STg2fuK?=
 =?us-ascii?Q?3U3MjSHixoQpGt3jRcqmzeNSn35jAHnCvi64Y9nT/O30OovXiDrzJlGmXhNn?=
 =?us-ascii?Q?GmBJAPXreNcLiaX9cJP+gBAnOKeLbePZtolc49ZrslLUexObep5Tme0UULlv?=
 =?us-ascii?Q?+T+lfctPUr04pK0J2YsHiX0ikDX0Cjw3RNzB3m+lwtQqL9BJVXx4Mx+Vxlsl?=
 =?us-ascii?Q?kzSLmCDMNenjXNkRcmE0gakCvU8DAtw4bKVHteNvjrl9uhu2ZCYY48ajtcKh?=
 =?us-ascii?Q?y2AflsL71QG26eX0fRsF6/CbdyrycdOITnqtLXdgFIIdM+pSPxvxYw/9N+NF?=
 =?us-ascii?Q?ePBcl2NL5we2a4aQgBI/VXGPFmN8u7fzrUuiE8r2hbr+twcuGmmpxZpkU0i1?=
 =?us-ascii?Q?awjMDSY/yrvLDW2fWAvUhxwCRcNDktuRRZh64aJUy7S6D8HPg5vX/5xYWMeI?=
 =?us-ascii?Q?pUons0Gr0o8e7RdyA8kCfddqdxcQmHJC+PBH8otlatinYg/7JDsr+YUAdgoJ?=
 =?us-ascii?Q?BMVSJcUlHBFkgsDwEMTfxNrzQhmC2vv+1drLbGPqYxNcsrqJ1BOILyhlcmRl?=
 =?us-ascii?Q?FDZilD9JScP9qQczS9MDYhNZF/1WcXMBNnCwrTiv4N9baVgEci9mHSxQEBKh?=
 =?us-ascii?Q?5S2o5hujuUugRBHifcNBeXEx50l9ndlI6AI8L1tefHgnj14PmrufqOGsKu8X?=
 =?us-ascii?Q?cp3op7bOtZYjEUEeS448R3PKFffi2ST3kXbwWxKl3p2F8SyneNqFFQncyQle?=
 =?us-ascii?Q?BkitKCj+ccyYrdCaYD/6ZAp7ztsE77rSTDN/5+Y4bqHuGKSLWCkGiRHLFe/F?=
 =?us-ascii?Q?2aJVpMZ9cO6+H/FTUWLbQknyjz22rRHo3Ns1weByznRydqBrKp5ca32Ab7Rg?=
 =?us-ascii?Q?FdqQKNvdrfREX5ykTD4bdioW6LPV/SO44Ieh7EFIOpA6RAF7U7Y02tVQVYrT?=
 =?us-ascii?Q?Q6Rj3usV6O4zuOcSmmlyq3QVTm9XKPNPkWVWJ/utCROZookcM72evUoXhUY+?=
 =?us-ascii?Q?zgAKey5Zs9qCvuWJKFjWJ0SZhAVeBwIIvfosoTGqd2+AC7g3qH5dd5llyJG8?=
 =?us-ascii?Q?8ErFK7FGD+6N1NHIHtSbSG9xeOtIkzW9jeIFnPJC8xVPMUyGNp9ThzKPKh3Q?=
 =?us-ascii?Q?wD+xbw/cnQOi3bSBOEuOGF0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e960366-4e66-498f-143b-08dbfcfbb23a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB8113.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 23:23:36.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aorF1tuhuszNf5qznn2RZbNg8yk0S1ruzvoLM4SgmXgqtmoBC6QmKx+LdcnaSFtHZDKKyysjjpKJeKNrObVn4BV+zLAbbudDo2wR2po5c5BwJW+JYe+FAcqClUOebq02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7547

The original patch remain unmodified. This is merely a resubmission
of the patch to get it moving forward again.

Links:
https://lore.kernel.org/lkml/20220214030813.135766-1-lostway@zju.edu.cn/T/

Shengwei Luo (1):
  RAS: Report ARM processor information to userspace

 drivers/acpi/apei/ghes.c |  3 +--
 drivers/ras/ras.c        | 46 ++++++++++++++++++++++++++++++++++++--
 include/linux/ras.h      | 15 +++++++++++--
 include/ras/ras_event.h  | 48 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 101 insertions(+), 11 deletions(-)

-- 
2.43.0


