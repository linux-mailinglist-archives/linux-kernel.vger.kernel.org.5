Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD7C7570AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjGQXuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGQXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:50:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD2495;
        Mon, 17 Jul 2023 16:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689637801; x=1721173801;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=E/xWh39JXrznhctYnwvn3+XJ5aLLUMAOomYqpkX59yY=;
  b=M7iG71s4uhhK12mVRYdUu20T0AwGY9ssFh7F2087YMgnonZsmfUPLaqJ
   mTPY5V9LIqLJjgnbYwueW55CaVmu+fhiCLZ9ZV0hDGn4S1lfj8I6h1iUQ
   JxC4PeQ7syz9DMIgcu23kcSpHpdrWtxibmPla7T8mfaU/wCb+VMu2/YL0
   j90vVR3gbksHVeKEaiyMRp/ld8xyyDge4sRmVJi4xqhLxpCLSqkWaa545
   k/B2LA8LTH7itHaJzk/tnWVM54Eg3EgZI+u5anKPTAzDT6JpAus+dVmGj
   nCyp04KqQzYrEQa8QRkvwDR3iVYgvRXhxVdKnMDytJQ3Z/KFYB+7vfaeq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368708222"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368708222"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 16:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723383660"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723383660"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 16:49:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 16:49:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 16:49:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 16:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm2pm2Ukinp/r3wd1ObXBrK/F7bczZDl45vMNqSy3BmDiJ6x9dIZGJhcFhvRH1EOqqS7IcgowVLWC2IivhVFPw1/PHX4Ogt1zjd8A9/cAlpcVJ1mz5LlugJF3LOHLkDmTv9QhgOicL7r6/7zMvYtrEcvST3pIVPW2/13bwK2H2S9SNUNocDWdwkzyNQgXUseHnVjujXRNBN56b+CnwyRo5qzj5GwOiORyVTdGS4PzFLaaB+/YPB+NWm4mN55BH0Wom3ddj6UsRgRgFOx302E7sFZAfiDW2AqWx7o+ayhLnj0qLHccR57z0KHwnmOPOgYjJo9/sPejINo8eJwbHLEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHRBthdkzpZYrrBsmURQrNbq4Ek2MUunAgUQnyJ09GA=;
 b=H9zuDq0iOTLoH+beoY+6RPjG+VPSjovwZqHOwXDY80FKkWmnXHUbAW1vDkyED+saazSYlr/jusyV8KEI5CFnlgIiHYM7Jbqv2Ul1fBhvwL7Xl7JAxxkN/IfClF3yzFxcSdvMJMfXrv9bri9Y4hW7TzB8dZOTStiQWwfNgypC0uDfoi/7fu5lAxpnWGSIdJBmwxmOzCLzugC8vEnGjfCnqd6qqbld7cvsGMr6WHA7W2qIbvsRF7cx9pv4RCbFyK5sNpj17LvzxhYLfTQyAN1yV0CilEaumtuT1AlZ0jo/1m/YnRzqapfe1hdhE6iV8CKVa2G/97JdLfP0cdI1Gzm3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 17 Jul
 2023 23:49:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Mon, 17 Jul 2023
 23:49:56 +0000
Date:   Mon, 17 Jul 2023 16:49:52 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Chenyuan Mi <michenyuan@huawei.com>, <dan.j.williams@intel.com>
CC:     <Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
        <rrichter@amd.com>, <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH] cxl: Fix memory leak bug in alloc_mock_res()
Message-ID: <64b5d3a033e5c_45a6294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230717041609.1162445-1-michenyuan@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230717041609.1162445-1-michenyuan@huawei.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: ba069380-9b79-4675-73eb-08db87208610
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rTJJ8XSglQVAP0EdwcHS8K9L4VR+cdwW9ok/lJJiKuFLHsFrk9kT5Hbp3o/zHD8RR31KKv8RNov7NDZp22EAxCiNVL3jCLgYAeyxkDVqXJfalQQxhKh+ZQme8DDTH3qjQJsgv0roXQJiM/0PHFdrU7UywLxqFJ21BdCIEXdqXaRk3jiOYXr9hz14TqLYuBWF99sf3AoLkmYE5aEaxKxQvvIvZiFV/6dBdL/QnAs8pO/wwP9yKat9DddGb40I6aCLbq/ghjwcZj9PQ5YfQ3qu4jDEgfEFIlc9SaNWlZZWXQdye/b7z5DZg88d4TRdZFNSoUm2EJVSmWEhmr1q+8AviJjsBUUtHsl/iwmpNLpNdNmLZi3Gg4ij2eyHS7pekia3KTa21nZdJWMkMOcEOpQ9u+7aDcIL5OgQnLXF+z3Ri/B2lTeiejWTlfNV1s7qygi4KJluq3aKjLhpxo9CwXjdnROCXP44680HdC75N4EdKhCd5JSTHSlLQPeiQrtLtcKzd2G4SMdxL5QDx9tS0JdxMPqjSwN+AEpDcGw/yjb82Hltz7VYvvYI4Revbn74jqZB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(38100700002)(86362001)(478600001)(82960400001)(6666004)(8936002)(66476007)(6512007)(9686003)(6486002)(66946007)(2906002)(5660300002)(316002)(66556008)(4326008)(8676002)(6506007)(186003)(41300700001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzm9+tx59GgtSUUO3ojnKY6Vcgj3s1RTOzPnHPbvUcx1r27ZaI8UgRMC6San?=
 =?us-ascii?Q?q8F2uHPtrXum2H0WdCR3JgZxddcGvR+8U4aK9pOiQHzvA+ICj+BN2ETLXQVR?=
 =?us-ascii?Q?xKmgw4mLgo59WPSOwxRBFry+6I+BSUEVb3rt/LJfBdJnmyf9w2HlRlziMIod?=
 =?us-ascii?Q?co9fFw/ATpGge65eeyDYJJ6/f8N5byu6hEqexTLyrrGjnagCdM7KYottTSrW?=
 =?us-ascii?Q?Lp8NHBJnkl+ekbWE2ZZB6ZAHk1z8JvFCdM8x3wquCKOSEWcc9GLS6ee+4FdZ?=
 =?us-ascii?Q?4ZsKHYIXGsrHAl+DsuxuAf8JGJ0xW49saLgF7oEJm4OMCB1CQze3Tlm8wi5o?=
 =?us-ascii?Q?qo64X+ROR8OUggKFnGzoQAUSIrbpYtalOw3aRKBi4/GgxWERkPkltMykU0vX?=
 =?us-ascii?Q?ljwpvBiBmBHjOChpxvlsOv4f3yKM/FqpTSk6utB+6FknMXunppDW6Xf05/fw?=
 =?us-ascii?Q?YOA0zbhRx/pj7FJukVz3NSSEvHzJJEUUlOQjWnzCo91biaUa9aeUQE3OkEJL?=
 =?us-ascii?Q?OCZlDMaDK18lrJwFi/VMEF/8E9xnc5szFqCeX/ylRDmtaFixtJFZhQ9AqeeV?=
 =?us-ascii?Q?0mHLOm7W6jJaw2I3cbKJMT6xqH9b1oi/RQH9yHjI9EYYwm3/HKuHeMslJ6RY?=
 =?us-ascii?Q?Bwp7jP68j/V/erC2VdR1hTcC+9fNTc/RR9mau7d2rPNxzf/ZA6shBWrGNaOh?=
 =?us-ascii?Q?VCg16zdXoIDRm49YEZ4OqcOA61JqzE52f5h3wmrtfTKI9ztu1GQ/x9s/kU5N?=
 =?us-ascii?Q?fAv/knbyampLtYMpENk2RnDLn8FQgyOSwxjq5Ii5o7IYoeitvVaVAqdK5w4o?=
 =?us-ascii?Q?t19C+mUe1zOMi8qvPvjKmeIHA3ewk38aDhd9tClRcGh3Xj8D9RgH+gz4g1We?=
 =?us-ascii?Q?5K6yqaOkEzYKtehOG3WU8Ei+H+xLwpjY38SglH3k94iKRlz+qFkS9JqBboYa?=
 =?us-ascii?Q?pPOdzUJdRFi7xc+FIGZ09m40eZz5yxSi3UF0u6Hw4DEWBnQJDRF3WLuLWEer?=
 =?us-ascii?Q?2b/7sWJ+Oay4BFX1V7Ep4LMe4JN0Fi/HbL50pgOZ48c9n28Tc26UmazJG+6d?=
 =?us-ascii?Q?pti/W09s0e393L43v6Ca5KSCcHZLpgqfhSMecqN1BjY6j3iC75JEU9bgtlS7?=
 =?us-ascii?Q?gCjsFh73XW7gw55yvXc/Yv+MK8HlWI9UTm62j4gBWl7K1QdRjE1N1KuVJHU8?=
 =?us-ascii?Q?62MDNpnMj8I8gYP7ZUMlOWZcguOpkTYkIFNoC3TeinyGZqBJ3c2tXwzT7zD8?=
 =?us-ascii?Q?sd6HyIXkQj8P8pETFm7j+Mi4cwTUoCp8ZhvMdcx8475ct3cw//crss4J7EIU?=
 =?us-ascii?Q?rsWJeZh8XvfQBoygAQi5OMTbFaFTcXCWE7MIL5u4LnxYZClzjwadq6tYNhPF?=
 =?us-ascii?Q?vM/HxZ8Y3tK437o0+e2TmqggNp9bbCLeEDS50i/fLeiroEFdCmIfjrHGU4lU?=
 =?us-ascii?Q?lClYmvaOVMJe1peRGHsLKks3slyK5X8eouoDC1DVJOVpMBCPemXfLV3fX1DP?=
 =?us-ascii?Q?TARBHarVya6Wmcg/VkpzJHpa7D3HFSILEyyu7WrTVaGZWcqYjGxcCp1tG1mU?=
 =?us-ascii?Q?FoDGzVcReTjCX4lT/n98BFRHy9mL+c1UyNO5hTyRIYPpvEx31+IWaD5f6Yyr?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba069380-9b79-4675-73eb-08db87208610
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 23:49:56.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ildRdWF6RceYq2EkjTJNWhjegnglICW/0ehaGzaCVgclwF89OrCYBcKNS/nG74qZFXvf4QmkziANkIGB8SjIeLtG5Q8uTp+MZBlcY4ejVcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chenyuan Mi wrote:
> When gen_pool_alloc_algo() fails, the error handling path
> forgets to free 'res'. It would cause a memory leak bug.
> 
> Fix it by add kfree() in error handling path.

Going forward I want to set the policy that any error path resource leaks be
fixed by converting to using __free() and associated helpers.

So in this case it would be:

-- >8 --
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 0e78d8e19895..ea04995fe42c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -396,7 +396,8 @@ static void depopulate_all_mock_resources(void)
 
 static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 {
-	struct cxl_mock_res *res = kzalloc(sizeof(*res), GFP_KERNEL);
+	struct cxl_mock_res *res __free(kfree) =
+		kzalloc(sizeof(*res), GFP_KERNEL);
 	struct genpool_data_align data = {
 		.align = align,
 	};
@@ -416,7 +417,7 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
 	list_add(&res->list, &mock_res);
 	mutex_unlock(&mock_res_lock);
 
-	return res;
+	return_ptr(res);
 }
 
 static int populate_cedt(void)
