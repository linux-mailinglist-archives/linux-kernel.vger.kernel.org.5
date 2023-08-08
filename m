Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EEA773735
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjHHDBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 23:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjHHDBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 23:01:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A2E10E9;
        Mon,  7 Aug 2023 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691463670; x=1722999670;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SuHoEiY4yjQx4acTSE9YWAZw9oQlS0nR2g2jvvb5k2k=;
  b=X3LOlp1GWM9agAk5j4z+9tyhI5n8HDdxHyIxeJ5H0n18HdKgYjUn3Q7L
   hU8FrWNtTbnA5miCvBnE3qEehMdcCzJzwNJRfWu5AcH5+zDN8XLywjMVK
   9HGWy3nPO9IQc0b7bFFoxyqTGdqkil23CxZYkl3GuofX22F1MkZzsghZG
   eD/IYMQd+Ue6XXeDEZpmBnWzOaWL/baUDMc+bOv5CFvVBnq25QVC4vt+Y
   AQ43VJ3aYwl8HABE16cUz06nE52qemfC+69Sm3aKcnDEHkp4fmFJxZvII
   ZcFpIn0u7gOzz1WV3xnx70mDCURQ0x0uw7QiHq5Lyu+0vfKpqIpEq4q3G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374377528"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="374377528"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 20:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="760738104"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="760738104"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 07 Aug 2023 20:00:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:00:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:00:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 20:00:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 20:00:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUn4U87HsY7EP6SYopMO4HNQQ7dFNb3q3WRSflYt297oA+Jo0rHzmXucWd4+i+RPkSXLuBSAucmH5gajDDGwVg82BTjR4XWsB8Cr89DTLYeu6NG6N/nMzDPm2gBOws2lcotdMEsSb03ZxfzFleLHqzFRPzp7QBx4Q2HDrlrMy4CBdam7VUSbp/hfs7piOsX29EXHVRN5pGt1iRH+yextme0T9wDny3/Ba+TfP3uRPCIt0Xyy4DRkyFR9k68xURQQ6Gg4jWL6BDdr7XQ996/nlQtgzbj2RKDY6afCLZtsgsGo9aBdIpis923lmeD5zITxbt//q9VcisBYHMWcuDEjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZPn1Lh3y/bgsiDqR4AzGMpGbPF2bPmadNrZ9AopaHE=;
 b=nMAjQ2gxB+z8N+phn47bx/9ELUYUPKP+uj5RTdr/AqQGzYuF/SApiNnP2+GGCy/skrPzq51krzjaOBdRP5P1b2RPm6qqN84kC1gLUwJffZB2Q/XBJLqgInK5L+WLvCXtcAleerm6kAHgz2Az67np3sqqBc9725djNi8ElFOlbgSNnQ+6eiC8nUySy4/m4hSpmTeQcAVDxBH6yfagy0SKr+sbqFcJUkRZie8uRR01FeWJGQKFTbEdhkHr5J/Dsj724O2CaiuBGL0sxuS26xlDDbyvGGZ6fAkUSCnTOA8bIJdNu91r+Cgj/Lnbjel14XydsEfJBaT0rldAYKb1mFfykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6162.namprd11.prod.outlook.com (2603:10b6:930:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 03:00:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::4556:2d4e:a29c:3712%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 03:00:44 +0000
Date:   Mon, 7 Aug 2023 20:00:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Robert Richter <rrichter@amd.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v8 03/14] cxl/hdm: Use stored Component Register mappings
 to map HDM decoder capability
Message-ID: <64d1afd97d33e_5ea6e2947e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
 <20230630231635.3132638-4-terry.bowman@amd.com>
 <64a36a4a39351_8e178294c5@dwillia2-xfh.jf.intel.com.notmuch>
 <ZLGJ2Nm1OD/HoqZ6@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZLGJ2Nm1OD/HoqZ6@rric.localdomain>
X-ClientProxiedBy: MW4PR04CA0390.namprd04.prod.outlook.com
 (2603:10b6:303:81::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 38aea18d-1c39-4a89-ad0c-08db97bba859
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H28mF5XVaUoAjAiKHBuvjn6rDrzcIkpdhARvqHn8b5HXjCDJVOCFVRCwJk5tKeoB9mcCS7dWotFTD1hZm/NgiQFEG+JaNH5i0av1hUw/SFU/j9//UNk4m6oH3b6mp2E1lHhA7CPKBETzFpwzYGuW34XkuLl5WFqF2tRJZOYEydq9PpDPTsNSI5Wtim6zLhbR/OFhQUg5RndDVE+63LDrE5R9YwRO2cBxVE25f6mhVBH7kT462ESu12n0SK5jgZ57gRGAv6lkYbrexPschsPyT/Ffp0ZIuspHWhIrmbJRZDHwgSqCc6DgElNQLcjXE4GDRWk4StaTqqpKfS87bdvC5H7fv4F1Ge2MMS6ZlTFpX/TrQWioQnZnifHR6gEVMvDbpU7RWUVF5y86xBPZRdayt8QyxImj5mvTg8G630oAWuF4Qn7LQrben6t/Rn2zoE4dk2pLcLxkG/OgBN7KqA02dvfbJrYKG88G9CPep6H2aCdUHmtcKBE0r0TTy1MFCY4e4rn/7Kw7UYUeI8OD5d5O1Nm18nNwzwEc/mJ5Z4K8dq5n23nO4+5RKKn+68m0m6msQikhmL09CwexqvosVlFstaw3CUIHoY5JTKrAQuPiiAjruT622iS4MZvRnNXBUDeg24cs0PjJpT1FDEXHXK8O9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(90011799007)(451199021)(90021799007)(186006)(1800799003)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(86362001)(83380400001)(2906002)(30864003)(9686003)(6512007)(6666004)(6486002)(6506007)(53546011)(26005)(66476007)(66556008)(66946007)(82960400001)(478600001)(110136005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7rVfZp6ySXa4CeNxGlT8u0hUwrDCuofbY4losWe8oW629yx4fOoQOyZcpWQp?=
 =?us-ascii?Q?VcL2WfB/DvRhsEcZzJ3lhOHFL5058mLqTbz3X7a6jtsFlE5gKGwtiXIiJENS?=
 =?us-ascii?Q?c/dqVbh2dKXYQgqKrmfE2wbou+Wmw2AX15/l/Q6icuV/Nz9FgS5OczcbIgZv?=
 =?us-ascii?Q?chXtwTWYhqLNmWXJnHYE87wACtxvoPyY58A+xgqHUUCI2g5Ob/tUiGgLRuXJ?=
 =?us-ascii?Q?Gey1BMJv8AaXX56q//bSVQAgiqiW1hpGsk0AA9ahjuIy8+q0vzt5qtK15nqZ?=
 =?us-ascii?Q?gAsijsNWJtATEHMIsp8RtBoCEmkH1mzuiWVD5hfayJHkRBeKki7C8vT73yuv?=
 =?us-ascii?Q?7l2fiLXctSskMlSQxhRmQDrEmjm2Po7jZWqftX3809dhogPakkC6ltg3JQKZ?=
 =?us-ascii?Q?iOWM2tl7vjx+TAFfTLicfI05dMjX/hP4uja7YWX18seex04kCfdwyXKteEs8?=
 =?us-ascii?Q?N5WKgKYBoVyYvuW3cUvymdOwIidOJNNqbFaOBqqxVB6ThQZGv6saTmBq8+E4?=
 =?us-ascii?Q?AHTdcUTiK2q2ztK6z1dOH6jSVn7fr+YUwGMNskatcN7d2cd9DM+eS+ctCIMa?=
 =?us-ascii?Q?R6R/zAG/lvlhK6DrGrJPOdIgCDBxpbndvZynH8JmAmW1MSphQmnqpps97ST5?=
 =?us-ascii?Q?Ni1pB90rZtn8fw1A/pJLl8BYz1H/6ZYRzrQ+Hk22xGKkCmnCTJCXuPpY3hk4?=
 =?us-ascii?Q?UAk/tOJEM+OpUrZgncIBXYmsY2WTyx2NMz7xX+Nv2pYNwrG90RFZ8F3Wp04N?=
 =?us-ascii?Q?g55T1nt8Eo5JfSIybKZFlHBVcX5eFlB6YUB+tFnZgiZAgndNqsbJB9Z9l40q?=
 =?us-ascii?Q?vRkl87cu/3VMfgq9IoiR7wUOcd5rcvW2sgQEFnLTr6mFNNogYbqJzYL8syYE?=
 =?us-ascii?Q?HAJlE1KXXprsCuh8/H3rQGy5M+msb7rlXkCihI7o3Tg2KAu/C26/TXzFOzEx?=
 =?us-ascii?Q?l62q6Wyw4knDD6mTdjkd0GHA/qTfHG1z/fbUEw/7CZ81Ii6LVkkpnaG4Yxwh?=
 =?us-ascii?Q?evM+bCvtwmB/3N+02h0jN8tIQQ3rf7CQB1OFAdItw4t9/H8MK6DbPnP1p8ZT?=
 =?us-ascii?Q?J4DVI7kHOEnslftof66jvT2BMTGDtGCnaNQSSCjQRaeTghJKwLTDMtNeaJ9I?=
 =?us-ascii?Q?GJFpu3+HN402e+bGUqEF2Lf3bxMdV/i8eyJ+EJ/85YqEI8excESidDCYKXj1?=
 =?us-ascii?Q?qn+12X6CFLVdnF+GAP/AgJ8sjY4PCWXjm2KQcmyEBVXOzbYiXPkAFz5liCky?=
 =?us-ascii?Q?a/X38AgReSen6c2WBsqnMnwIdgaPrq2qVzJh2BmCVbcTuTkKDBiN8LE8I+dM?=
 =?us-ascii?Q?Z4+qHLvjZdU+tOfw4LQhrJVWiCzvV4m+tW1pongmxNnmhECYtNfbsO2SUGol?=
 =?us-ascii?Q?0VMF7VtmLSkMiHZk05cB+xgRu38bJDxFdtyrzXHovKxNMonE8lN4PIXHoNuQ?=
 =?us-ascii?Q?ZytEb8a0hlSglNP9bOAjrp3D0led6szQ+INsFWmE155CWENEfTJzsuQSsj7N?=
 =?us-ascii?Q?mtUdaAvF6IUUQaCzgb/99WrH7PafD3HR1U3mX7AMT8/SzsOhbOQlmZzFRNdY?=
 =?us-ascii?Q?HhZ7s6yGYDIekzxVJvPlqAhkweEWkdcEDk7aRgy9lu36dJP7NgGnC7sgF8vH?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38aea18d-1c39-4a89-ad0c-08db97bba859
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 03:00:44.4383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8oZ0hqCC3YHQ8FvsGHkjgu7nz9wcB8MZ+8dxdx9B/I+SEbRMLGHEa7V0nxNHYFDxXqQwM5UTtaOOVAnmhyaF9J4rgYjIKJTZ3ClsIj8cQx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6162
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Richter wrote:
> Dan,
> 
> On 03.07.23 17:39:38, Dan Williams wrote:
> > Terry Bowman wrote:
> > > From: Robert Richter <rrichter@amd.com>
> > > 
> > > Now, that the Component Register mappings are stored, use them to
> > > enable and map the HDM decoder capabilities. The Component Registers
> > > do not need to be probed again for this, remove probing code.
> > > 
> > > The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
> > > Endpoint's component register mappings are located in the cxlds and
> > > else in the port's structure. Provide a helper function
> > > cxl_port_get_comp_map() to locate the mappings depending on the
> > > component's type.
> > 
> > This causes a regression that cxl_test tripped over. It's likely
> > something you could reproduce without cxl_test just be reloading the
> > cxl_port driver. Root cause below, but here is what I see on a test run:
> > 
> > # meson test -C build --suite cxl
> > ninja: no work to do.
> > ninja: Entering directory `/root/git/ndctl/build'
> > [113/113] Linking target ndctl/ndctl
> > 1/6 ndctl:cxl / cxl-topology.sh             OK              12.78s
> > 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK               7.72s
> > 3/6 ndctl:cxl / cxl-labels.sh               FAIL             1.53s   (exit status 129 or signal 1 SIGHUP)
> > >>> LD_LIBRARY_PATH=/root/git/ndctl/build/cxl/lib:/root/git/ndctl/build/ndctl/lib:/root/git/ndctl/build/daxctl/lib NDCTL=/root/git/ndctl/build/ndctl/ndctl DAXCTL=/root/git/ndctl/build/daxctl/daxctl MALLOC_PERTURB_=67 TEST_PATH=/root/git/ndctl/build/test DATA_PATH=/root/git/ndctl/test /bin/bash /root/git/ndctl/test/cxl-labels.sh
> 
> I have tried various combinations of revisions and setups (patch #3,
> #5 and #14, ndctl:pending/v77, cxl_test only with both, "ACPI0017" and
> cxl_pci_probe() disabled), but could not reproduce this. Tests always
> pass for me:

Apologies for the long delay in getting back to this. July had some
major personal interrupts to attend.

> 
> [51/51] Linking target ndctl/ndctl
> 1/6 ndctl:cxl / cxl-topology.sh             OK              18.59s
> 2/6 ndctl:cxl / cxl-region-sysfs.sh         OK              12.26s
> 3/6 ndctl:cxl / cxl-labels.sh               OK              28.25s
> 4/6 ndctl:cxl / cxl-create-region.sh        OK              19.56s
> 5/6 ndctl:cxl / cxl-xor-region.sh           OK              10.57s
> 6/6 ndctl:cxl / cxl-security.sh             OK               9.77s
> 
> Ok:                 6
> Expected Fail:      0
> Fail:               0
> Unexpected Pass:    0
> Skipped:            0
> Timeout:            0
> 
> Full log written to /root/ndctl/build/meson-logs/testlog.txt

So it turns out it is not cxl_test that is failing instead it is the
tests noticing a regression of the VH base case. I am running
cxl-topology.sh in a QEMU environment with a local device defined, and
that local device is hitting a probe regression.

When cxl_test goes to count the expected disabled devices it sees one
more because the QEMU device is also disabled.

++ jq 'map(select(.state == "disabled")) | length'
+ count=5
+ (( count == 4 ))
+ err 170
++ basename /root/git/ndctl/test/cxl-topology.sh
+ echo test/cxl-topology.sh: failed at line 170

...i.e. only 4 devices are expected to be disabled, not the 5th one that
was not on the cxl_test bus. I assume you are running without any other
CXL devices?

I will look into making that a more formalized case so that failure is
not QEMU configuration dependent, but please make sure that QEMU CXL
configs do not regress.

> > 
> > 4/6 ndctl:cxl / cxl-create-region.sh        OK              17.05s
> > 5/6 ndctl:cxl / cxl-xor-region.sh           OK               5.18s
> > 6/6 ndctl:cxl / cxl-security.sh             OK               4.68s
> > 
> > Ok:                 5   
> > Expected Fail:      0   
> > Fail:               1   
> > Unexpected Pass:    0   
> > Skipped:            0   
> > Timeout:            0   
> > 
> > Full log written to /root/git/ndctl/build/meson-logs/testlog.txt
> > 
> > It's not that cxl-labels.sh causes the error, it is loading and
> > unloading the port driver trips over the problem below:
> > 
> > > 
> > > Signed-off-by: Robert Richter <rrichter@amd.com>
> > > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > > ---
> > >  drivers/cxl/core/hdm.c | 64 +++++++++++++++++++++++-------------------
> > >  1 file changed, 35 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 4449b34a80cc..b0f59e63e0d2 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> > >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> > >  }
> > >  
> > > -static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> > > -				struct cxl_component_regs *regs)
> > > -{
> > > -	struct cxl_register_map map = {
> > > -		.dev = &port->dev,
> > > -		.resource = port->component_reg_phys,
> > > -		.base = crb,
> > > -		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> > > -	};
> > > -
> > > -	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> > > -	if (!map.component_map.hdm_decoder.valid) {
> > > -		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> > > -		/* unique error code to indicate no HDM decoder capability */
> > > -		return -ENODEV;
> > > -	}
> > > -
> > > -	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
> > > -}
> > > -
> > >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > >  {
> > >  	struct cxl_hdm *cxlhdm;
> > > @@ -145,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > >  	return true;
> > >  }
> > >  
> > > +static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > > +{
> > > +	/*
> > > +	 * HDM capability applies to Endpoints, USPs and VH Host
> > > +	 * Bridges. The Endpoint's component register mappings are
> > > +	 * located in the cxlds.
> > > +	 */
> > > +	if (is_cxl_endpoint(port)) {
> > > +		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > > +
> > > +		return &memdev->cxlds->comp_map;
> > 
> > ...but why? The issue here is that the @dev argument in that map is the
> > memdev parent PCI device. However, in this context the @dev for devm
> > operations wants to be &port->dev.
> 
> The cxl_pci driver stores the comp_map of the endpoint in the cxlds
> structure, struct cxl_port is not yet available at this point.

When you say "this point" you mean "that point" in cxl_pci, right? I
initially took that to mean literally "this" point in the quoted code
above.

> See patch #2 of this series ("cxl/pci: Store the endpoint's Component
> Register mappings in struct cxl_dev_state").
> 
> > 
> > > +	}
> > > +
> > > +	return &port->comp_map;
> > 
> > ...so this is fine, and folding in the following resolves the test
> > failure.
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index b0f59e63e0d2..6f111f487795 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -125,22 +125,6 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> >         return true;
> >  }
> >  
> > -static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
> > -{
> > -       /*
> > -        * HDM capability applies to Endpoints, USPs and VH Host
> > -        * Bridges. The Endpoint's component register mappings are
> > -        * located in the cxlds.
> > -        */
> > -       if (is_cxl_endpoint(port)) {
> > -               struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
> > -
> > -               return &memdev->cxlds->comp_map;
> > -       }
> > -
> > -       return &port->comp_map;
> > -}
> > -
> >  /**
> >   * devm_cxl_setup_hdm - map HDM decoder component registers
> >   * @port: cxl_port to map
> > @@ -160,8 +144,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
> >         cxlhdm->port = port;
> >         dev_set_drvdata(dev, cxlhdm);
> >  
> > -       comp_map = cxl_port_get_comp_map(port);
> > -
> > +       comp_map = &port->comp_map;
> 
> Can you check if the following works instead, I think the
> pre-initialization is missing in cxl_mock_mem_probe() for
> cxl_test:
> 
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..4c4e33de4d74 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1333,6 +1333,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mutex_init(&mds->mbox_mutex);
>  	mutex_init(&mds->event.log_lock);
>  	mds->cxlds.dev = dev;
> +	mds->cxlds.comp_map.dev = dev;
> +	mds->cxlds.comp_map.resource = CXL_RESOURCE_NONE;

This has the same problem. @dev is specifying the lifetime of the
mapping. The lifetime of the mapping needs to be relative to the driver
using the registers. So if the cxl_port driver is mapping the component
registers the only valid device in the comp_map is &port->dev.

I notice that cxl_port_get_comp_map() endpoint port as an argument. That
endpoint port was instantiated with @cxlmd, but it seems not with
@cxlmd->cxlds->comp_map information which is available. Lets just fix
that. I.e. move devm_cxl_add_endpoint() into the core and make it
initialize @endpoint->comp_map with @cxlds->comp_map while switching
@dev in the @endpoint->comp_map to be @endpoint->dev, and not
@cxlds->dev.

...but it turns out that is the second bug in this patch. As I went to
try to reproduce this failure for a single port VH configuration I
notice another bug, a regression of this fix:

   7bba261e0aa6 cxl/port: Scan single-target ports for decoders

...because there is no requirement for single port switches /
host-bridges to have HDM decoders per the specification, and the
original patch is turning HDM decoders not present as a hard failure.

>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>  
>  	return mds;
> -- 
> 2.30.2
> 
> The cxl_pci driver always has something valid or fails otherwise.

Understood, just copy that map at __devm_cxl_add_port() time. I am
thinking devm_cxl_add_endpoint() moves into core/port.c and it calls
__devm_cxl_add_port() directly with a new parameter to take a passed in
@comp_map or @component_reg_phys for the switch port case.

> 
> If that works the change should be merged into patch #2.
> 
> Thanks,
> 
> -Robert
> 
> 
> >         if (comp_map->resource == CXL_RESOURCE_NONE) {
> >                 if (info && info->mem_enabled) {
> >                         cxlhdm->decoder_count = info->ranges;
> > 
> > 
> > Am I missing why the cxlds->comp_map needs to be reused?
> > 
> > Note that I am out and may not be able to respond further until next
> > week.


