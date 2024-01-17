Return-Path: <linux-kernel+bounces-29378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAA830D83
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949B0B20DA8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4652924B36;
	Wed, 17 Jan 2024 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrLT9Lqj"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0A24B21
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521245; cv=fail; b=XZOU8ViQ3vWNuXPOSZpOKWiV052IZPWInoIRjA+EaTmDJowMXtWdWUizUgCntvgxLhx3OuIzSGTXGKL7UI7u/Jw3no5AI7ZobgsnfBP+47MvhDPwinTNeJhRL6RBX3M1ft+DHJ5UZE+Og53bggYu+d94T3AbMo40Q+tJz6DrETo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521245; c=relaxed/simple;
	bh=9+KRo+0D/IkuEAT4CvhXtwtCx9/8DkP1GUe8Eqtj8ko=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=mHqGtzo/PZxaQm9Dlv2juTkAdJ0ild/W2Kbg8Xxi2KMIe7fIqzn6/R6HraGseu81kaMFjra75VO35M24r9C38wbwK8hgtSn41ExyB30CiVjC1oP0XzQfUnIYVraxMuLPfQYdxydcTcwt0IrZw2knA2PO4o9Svfs13MzUN8mmc28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrLT9Lqj; arc=fail smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705521243; x=1737057243;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=9+KRo+0D/IkuEAT4CvhXtwtCx9/8DkP1GUe8Eqtj8ko=;
  b=hrLT9LqjfnpDUZBOpDrwR27NjtQNZ4zqhCBVlwO9d3r3ZWBDDgkj8KrK
   81Pwgp4MsxLlZ+FOXHrN1hWWz/ITECax6ev85RsyuAzxE8S51BvyZmonM
   MqyLPaM8l2ERwtua8dhoMG71UdcinPo0BsbNn3A4/ZkDOS4MUZN8XUCjo
   HdPwHUG/vidyIymp+jJ6u1fAquCH8tDnGKzG+cUqEG599XujAr7FswQL0
   uiwXiwkoXBdbVY2ts0DyUYyuY+McBNWcfxaa24vaAb2mmY+umcjXolxVF
   AVk0lhO4zsiJEep5w8qSVMPhBKr4tMAc2OsapgWgIDYszzoGWVKb6RgWW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="466641655"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="466641655"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 11:54:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="907841326"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="907841326"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 11:54:02 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 11:54:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 11:54:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 11:54:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDog6ZXO9s9ZHTIutVdkOGMSdC7hw4t95GzgZvoh2Kb5C1W7U1GMSyZ8KOW/JdbckBYUOnMYp4/LFOioTsf/1JA254gh+nRL2mtIaJSnU69p7v1L+NSonrBGdXzaaiPXUkIsTviZZorzC7CqHCBTPrNg1n+ruseoQVUfearqxofeCEYq9DSUx1tkv2d5PUtPjM+n+K8F1WPHFxViemrcZ551nuKz2ApnaqIMWJQYXu0rXN4Esyo5IAWTo6/5fiLK5lvpVj0SEIj+WRHHq7PQtgWlmKrTXYSuF8FSOoFgwLHITn5zW6dBhL0kh8v4yMKGbVvy9xxy4pGgjCo5UQHNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpTdsr4MJQrrwYcPpckxeHVuL9qeQUHxG+0uzLeCQm8=;
 b=gyhHMepmGnbczClKSWbkBnoq6G0WZrNiqy1V26z+xPZuJaFX+C+MIuQCJDc+gAvjuw56po0sh+aR+3j8QIE5G/7tHYyFhOB3q8jTZHPXjAyYeC1/hw2HGQvBJ9NnD3wWEc+8ALFkeyTBTc/CgOy55uu8n+24qLT/XOvaiUywdW51WPaVZ0tHRBp4XzNPuJG7HZYcMVupPMD7q4tjQw1cnFcf5xkNvZecgaJKjsQ/AQjutdKyi5fjLZm+5HLtoO36Hs/EazY7RmFZfVj6SaP1qlwouPJLY/LBv2TZj5vOtbCOmKOMl1YwQ3GFrPVloUlZP0E8Cx3AsyfQHaASpiouIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9)
 by CO1PR11MB4884.namprd11.prod.outlook.com (2603:10b6:303:6c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 19:53:53 +0000
Received: from MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d]) by MN0PR11MB6059.namprd11.prod.outlook.com
 ([fe80::a7f1:384c:5d93:1d1d%4]) with mapi id 15.20.7181.031; Wed, 17 Jan 2024
 19:53:53 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, Jose Souza <jose.souza@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Johannes Berg
	<johannes@sipsolutions.net>
Subject: [PATCH] devcoredump: Remove devcoredump device if failing device is gone
Date: Wed, 17 Jan 2024 14:53:49 -0500
Message-ID: <20240117195349.343083-1-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To MN0PR11MB6059.namprd11.prod.outlook.com
 (2603:10b6:208:377::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6059:EE_|CO1PR11MB4884:EE_
X-MS-Office365-Filtering-Correlation-Id: f10dd9ba-c041-43bc-cd58-08dc17960842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wNw2C2wcoehYy/NsWQ8JxaEM1Sq8HxgkTrW5be9hy2CdHsvkKvvY47oHCfghiWwqxWANAzJistG5jTmpplkFZBbLNZ/d1saJGh2L7QYcNJAc/Voo2J3zbjaCq8itbPv91Ng6546idbzVKRa5E6mUqP3WIMyvyyZ4um6QDB9qCdlDlce1b7ZFvJ7n7SdyNj8NABbRO+a1NjdWryjBsFaqByNeB0OOTYqemd48pjJmZ0AVrjq6YUpbRKSHUIltH8yZWMoAsj6y29BARvaJk/dc+GWka+Gl84j5inunPuZsHkvzJCrj+ip8u9xIpFa9NzrWy3MUuY/0X4A5dvJCh/rgst7Duy6eYhJ3rHh4NZ+QWLsFjc+OTAUd73a7f19VWnyUkMF5NVYjzH8Z1lAey1jutYkofEXSsjdsmGdnjmqNw0eQx2GQKzLZqXpaP3iTpOvRrNUTGcHIxJ5FQQasQhWN0YmqZz8x1X5sIwNcfeHdqaAmfrFI7HKUa/rCys6OaLJ2ULe2N8FzHIlQ7I991Pt6ad3fybFNcj8BOmshROPAss94BrYxC2A7y7JTfX54RLM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6059.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(1076003)(83380400001)(6666004)(6512007)(66556008)(38100700002)(6916009)(2616005)(44832011)(8676002)(4326008)(5660300002)(54906003)(41300700001)(2906002)(6486002)(8936002)(478600001)(316002)(66476007)(66946007)(86362001)(36756003)(82960400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JrZs27Ny0i6U9BuxgIdy/J7Boh9OxGeenNh4VtzeKFRQLpoIEoZ8NjRF4+fQ?=
 =?us-ascii?Q?+tose+wI5fTV3JbQgpCpbrAdBFtNtZnXj4FK5uJewBi6r7XUWsmFYOurOtqh?=
 =?us-ascii?Q?3L2qpDZiIt6Mp9Xpy5LBCbjfD2F4LZvY/UEAgFWx8rk5wbJCWA63IX0JiodT?=
 =?us-ascii?Q?2fT15kvMEHF6fuhTvqCeqUc8hFfgTIHWwUmV2hpIIsoV6ebP+vHKmP7VFK0v?=
 =?us-ascii?Q?vIdB9xovD+AcNVLsTUwvdgpwPLlhXH7PTSncQIuBalyBxRW6cud6AVEnICb9?=
 =?us-ascii?Q?2gMS8sCoGpaKSS9+SB51YY34zM4UlI4yQ4RL6+/wDlEmOt+Y7E4ZLengpL5W?=
 =?us-ascii?Q?ZGMyoSvZ/AegrRUf56506ASqJhohTmrZg9u3blK9n62t8QzbkrPQ+6wZDNRu?=
 =?us-ascii?Q?6d0CF+gKMUNPuwOTEle65WeajHyp3xim8wJ87oc8Ok8vAoeJ9JReWootInMr?=
 =?us-ascii?Q?Nt/LNVQ077s2PLbyQx7IDs0sR5LZBvrRcLzoCvgMhimS3lTgnbyNl0bQO1Ci?=
 =?us-ascii?Q?EqEzh6zuW8vzdZr2y2LlRwCqoAVf034Ru7NVSir7mx2p7HZ3qn5VUIO9ydhC?=
 =?us-ascii?Q?q+2gqWYc99iHxFT7MSme8qsXrqKHHTSv2DFLkAou3KO0USDZ5GhKYEBPkhiN?=
 =?us-ascii?Q?OWXWAFbnVZA2zLOX8t3wjrE+G00MXQbFs+nGqdLxNINOZ3u4uRoqMo5xK1Co?=
 =?us-ascii?Q?KwmocWE/UtCk+eZo9ldd+bAc9aG/ZDAG76QYzBFG1E1gEw/2mr1Vn36a/bnP?=
 =?us-ascii?Q?Ds2e9QP2P9JQnV6oQSYCLkUj3e2g8j3QjL462a7As1KYvO3uNwk8w08d/ZHZ?=
 =?us-ascii?Q?CFtxVloCco7HBI/HUZpAUmM1GzVZZV59h/pMYl0jtN0der/BE/RF6/0vwvqQ?=
 =?us-ascii?Q?AIECdEhRGKdL9jVLSToBFFAipaIjf7emw0JyJGt9vHAJ8eIr0h86Pq7QCrjK?=
 =?us-ascii?Q?bH/QW59trUal+6s9YdEF6it6UXHRfPrnLCZzuSJSF4Cq8lcS18fnyRkSRJfZ?=
 =?us-ascii?Q?PrLE8psMCwdrEgmoMUNPFDgwLKN5KzkMNf7Cuvg+vBOqL04obMAyCMFn6Uhc?=
 =?us-ascii?Q?dY/We8lciNVZ8hV1l3ICetCMe184O1sbnTdWbcK0wfhrSzp/C82gJNHHlp8w?=
 =?us-ascii?Q?6de0DciVxHQcwi46FxGWFsKzDrp+qngyr16G+eNWPZlGqDnJBCcYe/LiiXpK?=
 =?us-ascii?Q?nJkLHzw1S2qdDhIPcyEjqYDxSzv44n/4DpufqqwVdS9M/sP5MjWkisIjK5J/?=
 =?us-ascii?Q?+7xOkfO7XCUzuTuMvdTttTSmvC6gP+9LvSKUzC18yeEwSgyGiMx+QwFcckiC?=
 =?us-ascii?Q?UEcB5eCULU6tGk+nBN2UDak4oTZDB3lBk8HaJgD2Isq/+DN/l48HikfuEbuR?=
 =?us-ascii?Q?1Kzq4l/jMUSVKkDrPsUGVGqaXfG2e4PVBh8pzOfHmf2gmhg31w+gn+AM35+u?=
 =?us-ascii?Q?5RhExNbRY5k0vrkwMFPQRs5H5Gy/DUb+u0uLr2c8qtESeRv0h314DqNTYpyj?=
 =?us-ascii?Q?EeOiXhRUDwstWeHznoQPFfk6EN6Wz9ccJjW5rne2EY66NDBQEVUQXn9pifJh?=
 =?us-ascii?Q?9ZUCnIfdMvin0soFwBsejpQ61mbJyIK6MJcTUu29?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f10dd9ba-c041-43bc-cd58-08dc17960842
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6059.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 19:53:53.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgSrqZ8WLavII28Bt5Z7Sc0eVMvN2CWHwlF5Pr/07KX6EsaqTf7n+horeX+NycMmOkgCeL7pk3rAUHppE97Sag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4884
X-OriginatorOrg: intel.com

Make dev_coredumpm a real device managed helper, that not only
frees the device after a scheduled delay (DEVCD_TIMEOUT), but
also when the failing/crashed device is gone.

The module remove for the drivers using devcoredump are currently
broken if attempted between the crash and the DEVCD_TIMEOUT, since
the symbolic sysfs link won't be deleted.

On top of that, for PCI devices, the unbind of the device will
call the pci .remove void function, that cannot fail. At that
time, our device is pretty much gone, but the read and free
functions are alive trough the devcoredump device and they
can get some NULL dereferences or use after free.

So, if the failing-device is gone, let's cancel the scheduled
work and remove devcoredump-device immediately.

Cc: Jose Souza <jose.souza@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/base/devcoredump.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
index 7e2d1f0d903a..6db7a2fd9a02 100644
--- a/drivers/base/devcoredump.c
+++ b/drivers/base/devcoredump.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/devcoredump.h>
+#include <linux/devm-helpers.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
@@ -118,19 +119,24 @@ static ssize_t devcd_data_read(struct file *filp, struct kobject *kobj,
 	return devcd->read(buffer, offset, count, devcd->data, devcd->datalen);
 }
 
-static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
-				char *buffer, loff_t offset, size_t count)
+static void devcd_remove_now(struct devcd_entry *devcd)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct devcd_entry *devcd = dev_to_devcd(dev);
-
 	mutex_lock(&devcd->mutex);
 	if (!devcd->delete_work) {
 		devcd->delete_work = true;
 		mod_delayed_work(system_wq, &devcd->del_wk, 0);
 	}
 	mutex_unlock(&devcd->mutex);
+}
+
+static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr,
+				char *buffer, loff_t offset, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct devcd_entry *devcd = dev_to_devcd(dev);
+
+	devcd_remove_now(devcd);
 
 	return count;
 }
@@ -304,6 +310,12 @@ static ssize_t devcd_read_from_sgtable(char *buffer, loff_t offset,
 				  offset);
 }
 
+static void devcd_remove(void *data)
+{
+	struct devcd_entry *devcd = data;
+	devcd_remove_now(devcd);
+}
+
 /**
  * dev_coredumpm - create device coredump with read/free methods
  * @dev: the struct device for the crashed device
@@ -379,7 +391,10 @@ void dev_coredumpm(struct device *dev, struct module *owner,
 
 	dev_set_uevent_suppress(&devcd->devcd_dev, false);
 	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
-	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
+	if (devm_add_action(dev, devcd_remove, devcd))
+		dev_warn(dev, "devcoredump managed auto-removal registration failed\n");
+	if (devm_delayed_work_autocancel(dev, &devcd->del_wk, devcd_del))
+		dev_warn(dev, "devcoredump managed autocancel work failed\n");
 	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
 	mutex_unlock(&devcd->mutex);
 	return;
-- 
2.43.0


