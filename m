Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA17D7619
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjJYU4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYU4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:56:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C09DE;
        Wed, 25 Oct 2023 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698267370; x=1729803370;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hgmQj6HwunU5WwoOJVwwoHhMSRBjDJ5DqP7WnH3AJsQ=;
  b=loOtBQDcBT+nn1MH2Z0JRWd+ijQ7wi4xkRDdQss+W/XNrFGG+BK3X3RG
   3QJPONd1dqHKHc2huaxvbQf3Q4Tk9bgEY9roSSqTemPJVl367WKy6aw/5
   WHQqKxK3PozcGSmc+XxIbsy3hV+1LSPlWQCMSaJuKg2UOdcT3f9a+Eq5C
   OnOLyTAINWWJPHJTwzoHPoVtWHey0pvnDzCdll6nvzLKCUkxKGQPR/cLw
   RFEICo7MysUMDkPJs/1cuVTmoO4XmrcKmse60x2ZGvCZzOdteH1Af3BTi
   ndERZb2wdV1NbqXvOMnJBKb3hoxcW+Hkc+KJXx+9UH3WID7iwqTK58HfW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="387222936"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="387222936"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882573434"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="882573434"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 13:55:57 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 13:55:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 13:55:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 13:55:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 13:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXsayYBc4TytvBGSozL+T8QongvQS+eMvjkGEJw//DE9wtC9lJqlWSotNulE34w1XJt2TN/K/hlrXzpeIu5M/WXccufuwEEJIvm0wTq7fLgRbq1DK0tI+v7fdiuSAsNU7ajGn/Vms0LGYSX8QUz+S89hJjkpa0K1XYA9HWHhIplmD7D6Ma7bsQXuoc7n3W1H7Wx/74PXH0ZtZ0qyEMOY7KP0jDgjbcFO/vrjpMVtGwItUi2qvHwimwdSVvhHSh23XQbdr0HO8gLoxkpZX3rq8qL3HToxZto9TKWTajeLY8Zh9UJxcG09MGXiaynXWtcaw2rZPtigYLXBpN5l05YC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ECsPJTbxJd+2Fw1nquyr1EmAbGX5u6aX9iIvQxfG08=;
 b=g8iURZ55RkGQwlyIiLASNGD8yTMY4KqTSETPZ9WnZo9XWkOQKe1pH0uJtCVPOrM402M7plSjwHpIjhfRUb7kCRr86necR7sxWP0wtItSgaAl5jYEAd4vBKQeFQXTRxMPyX1EQst/tT5Fik0Kph/3GHenQXf/FK2kfQR1u1OBu4ptGQqoaNM+vKkjTwZ9zZ2S2gqfJadF/vMzPPbaLNlnk+kA1zM8vCLo8ssQL7fmf8a+SUIB56+ecfy+6pYA1HJKspTdnFzTNOTmcUL3nqQr/WFeulIiif5b0LhO7CPvrdODtGPBxMekbyqZpnJD9vRfLzCaLksrI+gZ464sThtwZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6827.namprd11.prod.outlook.com (2603:10b6:806:2a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 20:55:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 20:55:54 +0000
Date:   Wed, 25 Oct 2023 13:55:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH] cxl/region: Fix cxl_region_rwsem lock held when
 returning to user space
Message-ID: <653980d35bdb1_14ef4e294e1@iweiny-mobl.notmuch>
References: <20231025085450.2514906-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025085450.2514906-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: SJ0PR03CA0082.namprd03.prod.outlook.com
 (2603:10b6:a03:331::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebe6d27-5def-4710-e2ad-08dbd59cc749
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bB6gpc1eqT1RrT6iJVtKf8Ar3Y/SGh3YPlBormvU+n4qo6ucJpR3KWmO9ZfznH/6nK/gN5yemVo6ORHmNrFwNlCVVa0IzdAGQD21FDSFWCoJAuo9M+f2NWy9c6PtYtgTwLXjfpw0DlIORLnplacvD7KPjb4jdq9quzWAVxdfHaEsVwuo9mIjRMEP3kIahEHf+xtuu7E/up+jVgs1CeHrIav7w0yaxv3ijWU4iGr7Br/g5SGTAKLs419JmOF2G+xqiRRUccXbPkT9okPW8mbnHTQrcaz7Y06FE4sP6T89ViMbGccJPCoTqF3Ef/JQ7Yn8bvXE36Dp0xRSiVkPKolpm57a93X8nVVz43zFCFkNsPew3HfHN/vP1W7eWEyh2pMDj6ZiKtH0003pCOhAeecJPD7gAoHaIjEZI4gm18eUK6Xz0NiwrVvhwclpYhnuNj6e9VDoYWlJ/OKCHHZwHAVqT9KCT62V1WL3gv4khnV8BCFmLbphr04xaSSv+F2EIF7NBDXCBpWhjksRJ2DhSYy7GoqSKwbWv7wxVo/yPS/37bsKk/CxosB/AAWz9tXNaL5a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(41300700001)(2906002)(44832011)(5660300002)(86362001)(8936002)(4326008)(478600001)(8676002)(82960400001)(66556008)(6666004)(6506007)(38100700002)(316002)(66946007)(66476007)(83380400001)(6512007)(6486002)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFl3RxsF4jLZLcgHq/o9ENdS1HLmoYoBsrUU6vok5YH2IgiGhlWCu4DPW6a3?=
 =?us-ascii?Q?Gw1Tc2QMRxqxGnpyq5XUUPUaE9kmmXp6T1Ek5qzv9d1+Q7oe5FHQuwhyhnuX?=
 =?us-ascii?Q?2PouPYtwEGGxMhpTj94k7+rhQVI3QsbDqedqC7s6e5vM6LXgVNDhixTZJTlm?=
 =?us-ascii?Q?yH2RJd7gkRetXKFWnckXsbU0ZrhAzaaneF9ef9WE3ciAc7WYdNsORjRLfw4y?=
 =?us-ascii?Q?1ljj5tZzz1V4Sd3yJnYcBmRyFiQ3oQKPqMaIX6PmgZuLfL0sl+fee7lfc2Q4?=
 =?us-ascii?Q?QvkULf1sUztorR/JQ7mAs3BH5hgHIC2fCMDv8mLatpNZs+4d+U/5shVVgnup?=
 =?us-ascii?Q?8Cok1XlkAUsnMGBQbnBXxHvXdasLYIKxk3trPPk2BPDLcFoZ3N/2dUv29rFd?=
 =?us-ascii?Q?U/W5lDEWQMD1Ek3oRUH2jrmPHNNC5lQPtgzLsM/tdyL1KBLVAsNAqToKsl+q?=
 =?us-ascii?Q?sTQp56WIKiS1fvdz7wddnuE+5UdJQWCMN1wgd12j3ozHdBz5vFSusjJ1/v3Q?=
 =?us-ascii?Q?myW2UpVp8I3K/CW6w39drfQN1WPNQ+yiqc3JqqFezJkdTNecFaGi8ToXkg/C?=
 =?us-ascii?Q?N/KAzqaq1rCYfAeR1S8rqu9vyxa24V6bA0MHKbbzLcBH02sYbEmdoBiGc+vG?=
 =?us-ascii?Q?lO8bwqvfE6mIOCrby/OS0K5yPXbyydAE4/uMNBPt0KkZdmKM1oYWrbARNm35?=
 =?us-ascii?Q?DYdWeCvRTrAhXbAgCq+AN54P/LmszmE+mVjBeUFjmOE6A8FffuIt8Zeg3NMz?=
 =?us-ascii?Q?49BF7YzfBHm6SbXFq1bdbs5V5QPS8hTx1vALtawym0dgKKONyIAPxAK7k+L3?=
 =?us-ascii?Q?KKlbZd7nYkzkxpmRTPaSrMnqm4+LB0y4G2idhNFTY4OsU7VnsKtTbyx7EuZD?=
 =?us-ascii?Q?x5hApqQqYKq8SqmpSnVkUzAIKEi+/oZMWSIKLBrDLIhBuwcUYEu2vDn/kBfQ?=
 =?us-ascii?Q?VaZFTiD2/37/4pTqxS84YaUPiBuvkihTC0tC/90mPba1B3r9Aw1Vtlgi7OZN?=
 =?us-ascii?Q?8dzhRN6M6AZrWcICDpXLqpM3xpkE1+veauNTb5v3w4V+ErpenZaf0L/+tthz?=
 =?us-ascii?Q?hAaDUNroxjfHhvlJVRLIXu80qsvCLmecRzlZb3vJwo4101hUUjq0qOxRclvn?=
 =?us-ascii?Q?jJTUz4Bvjo07N2WbFY35e1TNYUQVUut/WMAFQRmlfa/+zHjjoeUYJJXpYlfF?=
 =?us-ascii?Q?BrNaWQ8MppaSHH5X4yCZsOy8hyYzyhbLteL9qxCiCDA91SfxY6WEoUaKdU8C?=
 =?us-ascii?Q?ePVtwBfuol/EK6FHSN9Os2mTp62y12HLZzebYpWXwTcIFuL+VdFvaGMvUKoA?=
 =?us-ascii?Q?PPiC38vy60EMtoWakKuC0Mfx1xdoI0UtC82EfvFPCfNb5NkGUeQn67Az0zWc?=
 =?us-ascii?Q?4EswngeuxLczP3NvC2eYrJmgwFODm8DXoLrwKGB0GCrc6pEF8DEKp+5TLeuc?=
 =?us-ascii?Q?RNLiX59msfVamhTnZRps7ILyWbiF/ZCcW7oIjiHmok5KGft4VOPuOi4xdBmH?=
 =?us-ascii?Q?YDy6OqpWJrgBdy4tAYNL1ugroBl/g0XYsp+kd+BdyNGJj7zV9/VbPvPTwxP9?=
 =?us-ascii?Q?R7z5Tvhns4I1MFMax0jW9hTBJIZTyHmEh+p0JOu+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebe6d27-5def-4710-e2ad-08dbd59cc749
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 20:55:54.0557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15NA8YftPjteJanylO8BxzpgeDDzHopw6N58AsUZipcDEoESp9ytWixcQgGlneY8sSUpSBEnzVWAmHfEOguljA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6827
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li Zhijian wrote:
> goto out to release cxl_region_rwsem. Fix below warning:
> ================================================
> WARNING: lock held when returning to user space!
> 6.6.0-rc3-lizhijian+ #213 Not tainted
> ------------------------------------------------
> cxl/673 is leaving the kernel with locks still held!
> 1 lock held by cxl/673:
>  #0: ffffffffa013b9d0 (cxl_region_rwsem){++++}-{3:3}, at: commit_store+0x7d/0x3e0 [cxl_core]
> 
> Fixes: d1257d098a5a ("cxl/region: Move cache invalidation before region teardown, and before setup")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..18da77f8f22b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -294,7 +294,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  	 */
>  	rc = cxl_region_invalidate_memregion(cxlr);
>  	if (rc)
> -		return rc;
> +		goto out;
>  
>  	if (commit) {
>  		rc = cxl_region_decode_commit(cxlr);
> -- 
> 2.29.2
> 


