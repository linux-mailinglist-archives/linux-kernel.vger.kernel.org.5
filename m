Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DD379DBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237803AbjILWkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbjILWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:39:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0373510F7;
        Tue, 12 Sep 2023 15:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694558379; x=1726094379;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MvFAMXK+tAie9OGeJ82BQjX7Rk4WIZh0oOvL38ebwXk=;
  b=O20h3cBC8SHIxmDLL+e4ktNCoesJF2YuvxNR1JOaO1IY06dvJKx2rBwB
   hDfymSGNADlmkEaJ7mYut5lzV+1KbKBrgY7qGjMZeU+8w2FL7cFafqUmd
   7WNO/wrR+ienQib2AGAhlnMAFS32BXz6YRk8Icu6LtMk67+zr8iWMThwf
   airS7DW+yy+TuDsXDa69c3G0yd/i+Z5E6+ruM8FParsY1J6lU//qRYVqA
   LLgwXF+r4lkYMrD0jtcMOLyUbA45TP7i3/tKyF09a0S8vAUyhzV5I4HUL
   eBrbNnwpQa31sqJAGXhh5JyCYIpt+39fkJcdsWw5wbGMObMo9GZYJQVKY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442535230"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="442535230"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:39:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773211106"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="773211106"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:39:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:39:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:39:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:39:37 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:39:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDyEM3xNND44zaOaUN2hMfCXTpW+A/vRmK+cEc5Njb4iH5TKVfUXuiD21HD/nmK1T2HWwmzpXfBztxbmW2kw42LrB7yVUpAgBa1ZJHdbKrxkQj0L7HSZl3XCtO73EtNdvLQsXLEyGq68+KST8/H8/8jG9DDJTzMSSnpimpbiM1A62o5G2zEPtL55nusD32fYEit/gSraPZuII1/CauqmOVuS8GnhZWOwDcIRycQmRb9N1x0DVd2jszg9BIk0VN8c4RViamQdTTJR5qNCQd8ODu4Oc8kqUNaFIq5LK26LqZnDOvIIi3lP/45FkTHSPB6EyWcaiPZQn1mHqBQOZtg1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kwos7kSpRv1IorLvMztbdO8kXLB4axd53cfrSKgR6P4=;
 b=JFv6bXCGMc0ruoz/bvGQKlIuSSI/ndKy5fys7LKK001wTZ/mYL7B5Ab9Sxky80L8Teo0EUm9If0RKRlks6kniGpHzIKRQcqj3IX9DYq2B4ds+SWdjtDAlQs5I8M6vsUwqk7+6Ua2j46LgTKx+1O2mfsmtd6insjDzHShsXPi3vUTrc6EI1h8K7pU/KZXEERkx/prLctnkvl4Cx9BMh3KoFqZOw9C1HE4SpWBl1cl6ilkIJfITQgd4+R4r0nBIyZ6hGW3H5cGHBmFiYicE49vin3cAJ0Opm3TPEiS3ksGFtLz+YYCKTk8EEthtrtV6ukque2oIl95Y2RRucf7Apj6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 22:39:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:39:33 +0000
Date:   Tue, 12 Sep 2023 15:39:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/mbox: Fix CEL logic for poison and security commands
Message-ID: <6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
X-ClientProxiedBy: MW4PR03CA0355.namprd03.prod.outlook.com
 (2603:10b6:303:dc::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: a9035b49-18be-4f94-358d-08dbb3e1224a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBrX6UJi20dI8JXJZRT8w5f/oN6XzLcSffw/qD0Ce+p59apSE8kLRf96DYjd9EoxqZhychD/bGx7xE5TRbhwWEDwbP0eZSYnV3ytbzxO/kp/kpBXREisA37wnaqp9NVCEQN1XE9eFiLYvIDc9qDrqCl8vRv+slPHRnvyzW624ZtcPruJj0V0W/bW/frENVSWOOYE+iPHV1bmIHAq1bW45KZ1B/r5YKXk5bFdskJYGcInmvh5GX99cyMQj543TR+7GMH39/K6KC9HHeXWs8v7dNUo9q1SK4PHCONBM+YEtL5b8jekdvJTqnXoFI0w/4HpyoxMJRvJAqT99auydBuoE7hiBepFAcOektpSahMWu1eZfpaqIChq7xVovswz242CCAE4/xx9rQsuzEb1dTM5sibYKAgQHekGmqmnY4L9QqwMCJ1uOkohplmjBKCyg46EflSlAtzg3FEy/laJ+zP61flwzB82K/YFHecQ64ncy4bz+sVcn3rX16LZGzr3xCHNPv9oFSzfsxV9H/21AAmPc9v1zg2F3ZTSuIvbxRwqp9wyHbA7O6AjNuAokSkWWcbh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(8936002)(4326008)(26005)(8676002)(107886003)(83380400001)(5660300002)(15650500001)(9686003)(6512007)(41300700001)(6506007)(6486002)(66476007)(66556008)(66946007)(110136005)(82960400001)(6666004)(38100700002)(316002)(86362001)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VhZOAWTeEk+cCkclV6VrtLllcMXbZKm93XgcdNwofGxxDU2TwDF2zd+E/Xu?=
 =?us-ascii?Q?RJY3x6MJ0KiQvN8RCs/9BDCpCP8MUvvr/wSxZfab+htCQKwVw9kKhZ2pHJG3?=
 =?us-ascii?Q?MA7RtcEb/u9Hr9irbIo4m/hC8x+l06/fxtlXDRosZws7oGS0hU3z1TjTDjat?=
 =?us-ascii?Q?CTwysafpJXOJkMjVFmfYXLO/571QdXVgaqNv2Ax7c/90JHiFU2CemsuZe5yJ?=
 =?us-ascii?Q?woPO8pePFPWJj5f93Tev9qcj+FxRaWR9FHJxzxklRKG/ObSvTfB+fXgGbIc3?=
 =?us-ascii?Q?+Ytwaz1wUvO4ttwMu9x2bgW6375wlFS/lE/q1lVRoFgeis5ncGU9Q8BotNoU?=
 =?us-ascii?Q?epUEJNugIp9e+Pb4NZ4PDFddixdCLl1O+bw2BluhQ5Xw4761gw8EHdfVUf76?=
 =?us-ascii?Q?ZjZ0C09wARi6o9XW2YZ60clPW5V1Y751c24j31LfQ2kA/xqR28lohHAgwzvJ?=
 =?us-ascii?Q?FFz5elLJGHc8X47sTNat8yKlz0j9nezXiQI0/jc6aBOwCe9XF9y9aadzReGk?=
 =?us-ascii?Q?MIw3sRQUI9pNMfe3SzMeFwH+VhbV4c43uwLK12wGt6vfbEV/RsxSBfxOJ8Fq?=
 =?us-ascii?Q?6cHLbHa5xmLVd3uX6cf82v5J/2LLrjn9yocaNRv2gO/JDSC5npnqr4iy1yOy?=
 =?us-ascii?Q?GmCT/z8HTgHPxfqcENgbBI5SQf46eLNkzyx9Z8hDMcErAPk7XgAckBo7q0zt?=
 =?us-ascii?Q?7IdCcZaBu1dPBUd+M6rspC+McMQ4BHzND3qNF2N0bjcbpjbpat4776bRVOlU?=
 =?us-ascii?Q?zaQlHLqpwOYaNWmAwWf5+4mYOvUjPEts1Vfi/DYsnkQZX5tj03Sc/PmNP4oN?=
 =?us-ascii?Q?Qj0K9Xdb6sWOMhN/uJFZZm7f/goYSG/Gwi1OdnnS0tb4RdHVSDal1qfiAp6v?=
 =?us-ascii?Q?ylvhjZTsX+W+HfyLyGG/j5hEKcYYv/x9RCLULUVotNi0Hu0DivrNUXfwcC+E?=
 =?us-ascii?Q?BVEqy1lKWOlkhemTq4iWrUGPZiCFXRKK8SjDJ0gZDqfoqBliluTSz/0jxHeJ?=
 =?us-ascii?Q?xEdCnhJ8d6ldR3pp8MzulBdY+VMY2gDUxsre6i5SjrUkKibvW25P0jfiS/xg?=
 =?us-ascii?Q?iXwZSgCiQx+/xTlN0iQ06MMv4uOH6cEOKXYq5UQDBHvIjmDER+QJxLd9t5KI?=
 =?us-ascii?Q?Bhpy0rXD59g4xE0tZdWIHVUWJDpP2Wy4crx6PSZUmNtRuGfJzmm/aT58GzJW?=
 =?us-ascii?Q?cHbuxes6ihGQpU/SRylXouaIDY3RhOmdz4IcSCQWxoHksLxZqZTTEWRcLpgr?=
 =?us-ascii?Q?7uPDs8YlghGvhiF6CXN89ksKsSdBtwuQnj3ECm8i/wl/bSl8bFfgbCzs23PN?=
 =?us-ascii?Q?iqGZOlEP5fZNwpI+DHYJCCbZsZJq3r2wxu0LYKmFmheflnLuinvdFVDenG50?=
 =?us-ascii?Q?jOek96zzABIvvIJguz93wweBKWv0xffpWFmgGGYpqXtrUO4Xt+q6lvOmbUDN?=
 =?us-ascii?Q?5lBMxOj1PZ4NvB67LithjncXjjUf6YDz/4MOBduG56dzXhPHfSw8lLRSoXry?=
 =?us-ascii?Q?iQ9R7zo85xH85i7SNkdvU6taCwAm/vAShyPO+ib6TX60L6tJhssPvV8vedxi?=
 =?us-ascii?Q?kVVSuZkb9QuuSWCiJ9vtWk/D5KFrAubThCRr92m5waPrZrNctyCXsZWS4WGZ?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9035b49-18be-4f94-358d-08dbb3e1224a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:39:33.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGOysOPzhRGRuRUnrwZpJK7KCajtuCvQv4Ayvd83jKuvH2fRhBqRU9YV0Ye4SUL53ai+hqRnMS/YFHVRuRKyGVHQLEtr3WD/huG4Vs5AeLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> The following debug output was observed while testing CXL
> 
> cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver
> 
> opcode 0x4300 (Get Poison) is supported by the driver and the mock
> device supports it.  The logic should be checking that the opcode is
> both not poison and not security.
> 
> Fix the logic to allow poison and security commands.
> 
> Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..b315bdab9197 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd && (!cxl_is_poison_command(opcode) ||
> -			     !cxl_is_security_command(opcode))) {
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_security_command(opcode)) {

Given that this is going to be a recurring pattern to add optional
command support, I am not a fan of continuing to expand this boolean
algebra eye exam.

How about the following to only do the validation check and enabling in
one place:


diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ca60bb8114f2..4df4f614f490 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -715,24 +715,25 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	for (i = 0; i < cel_entries; i++) {
 		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
 		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
+		int enabled = 0;
 
-		if (!cmd && (!cxl_is_poison_command(opcode) ||
-			     !cxl_is_security_command(opcode))) {
-			dev_dbg(dev,
-				"Opcode 0x%04x unsupported by driver\n", opcode);
-			continue;
-		}
-
-		if (cmd)
+		if (cmd) {
 			set_bit(cmd->info.id, mds->enabled_cmds);
+			enabled++;
+		}
 
-		if (cxl_is_poison_command(opcode))
+		if (cxl_is_poison_command(opcode)) {
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
+			enabled++;
+		}
 
-		if (cxl_is_security_command(opcode))
+		if (cxl_is_security_command(opcode)) {
 			cxl_set_security_cmd_enabled(&mds->security, opcode);
+			enabled++;
+		}
 
-		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
+		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
+			enabled ? "enabled" : "unsupported by driver");
 	}
 }
 
