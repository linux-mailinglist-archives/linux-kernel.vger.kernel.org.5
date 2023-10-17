Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF37CC78C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344412AbjJQPfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbjJQPfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:35:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAC92;
        Tue, 17 Oct 2023 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697556932; x=1729092932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lLtOXfRzUbQav1QWJME3z7F3GBEOkb2gXCalRUv4PRg=;
  b=V2qOf1jALNNuSfV65gT7Iq9Zu/ysfOGoKjZBqaQuouERQoKVFdPHDL6j
   DHaFcDY03J/76fdSbyReN5DK9IVUNi17ERwg9UIQyoLpI2UvMZqtdFjhE
   pVYsUTm78cLMQyVN/R0ANZoN1JoET6+W+Xn58QGeKl1JuOxtURKyUCbYE
   YBhH7MA+ZKK/M8LxKLS7Mi5PM2ttptq74GA/LkBwyAyobVAqkiJ55os3N
   sj7kcLw4qJy4OrgYEdG9jkD3D3dRkvhI9LdAY0YZINJbjzGZVxAZxQ9h2
   6+xK3P51Hwtykct99jiT9MPJHFa1M3qXk6IXRDbAa+h2p0ywNco5ScAyS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384689743"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="384689743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:35:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="749736715"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749736715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 08:35:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 08:35:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 08:35:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 08:35:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 08:35:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggysIaP6FpPp6PzLcIe709rqJrvNta4iI7k8phYB3ZpGV46IrVNx93Q9Ga7SAWCJtP3cbIgPDNVNPbe7kTPOBeuHK5scjqDPqKx+SiLvsp5sTcPuqjFS4jU4jEI/DkPfQ0NjFo+w3jMZim6Q9VPGXSQUAADlh2DE9O2oTlxHkxd+CoPInyrhVIh5jVUXHjzV34ny8t2/LhkmpKpUjSF91MC+0GjFf9doe9DR+0HEUIU4r7TFSan3Ax9QR0iEVOha98QlXFp6Lpn/Q1zZxVgw/FQuXFywNrxOVQq0fvKC8Bd7IeyrkJpQb34CUX+xXVmzQ2lS7iGnT5+EkNO3fYqXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAYT9apEHoJwiFbTLMl1nrecj5w4PaPdngdAz92onTA=;
 b=aok6lHaNJA4Bo518WT7Wi06+G7WM75ebeBRl+aAffAAeZ8odDFFDblSB3hLrqr5pEU5ztrE5eKRoaFPk0Txkkyu8sjmIarAw4m7g9EODxL7jPYxyK4MsBE7tzk/2OWnD3ezey0bwBBJK8oSspml/BNBRnPAaWkqi2cqWYTGpwmjRgfnPvS74ffDBYiIvYSYPg2s7jvpiTfStPQ4AOj//iH5t1oZtjXpF2SkH15z+GLrhwOutdwhtyxt/vGmzqqNW7uYsfbAWDhkIVPYSqXsx+MTRPsBiRl+lQOrPVnjtGAGdC9KCY1Se8eYQUJ3j+sX4t7jMZqZY7AY7WrHrWJAynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6007.namprd11.prod.outlook.com (2603:10b6:510:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:35:13 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d04:2253:2a8b:5c67%5]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 15:35:13 +0000
Date:   Tue, 17 Oct 2023 08:35:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/pmu: Ensure put_device on pmu devices
Message-ID: <652ea9afdf5b_2b0d2929417@iweiny-mobl.notmuch>
References: <20231016-pmu-unregister-fix-v1-1-1e2eb2fa3c69@intel.com>
 <b62ded44-4432-4aee-a086-1171b89fd2ae@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b62ded44-4432-4aee-a086-1171b89fd2ae@intel.com>
X-ClientProxiedBy: SJ0PR03CA0118.namprd03.prod.outlook.com
 (2603:10b6:a03:333::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 9314882e-9b3b-4fc0-0383-08dbcf26a798
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0EJ7fL0l/ttxlJ0i7ASZsImYJ766JGhjCcPUYqR/PK2F4dXio29u55A9Mv+CyUKR2zzPI/elaA6ML665GRmiKMW/pDPSHqIQZzMmj4m35aiSG3wYoqDLoYiLtjmGRvJ4SLp7NQisbM2D44dLbRKghjLh/xwvW2lUH1GzyymsYBj4va6JzKssG3XnHZXVOyrbL7v0UW3xQfRZNAk9K3YhHU/8OKqua2WrAn8K+WiPBBr3uagJ32dXbDUimOih6bT6aRlvU+OT7WaKUrHbPElQFSQypJLBxOrCk0xG5ejtzM+k7HLArsHHo2FMs+1xQomxx+15Zri2wQVrDNS/NmM9HGoLO/gAZBIqZPHNT5cqYfSxksz+9kkfh79y1ati7RCisgd4nzIh5PLMB1++UBAPEZUFTajhVvmVIl0yY9I0pGBXB+g04PFS47aVW1KXO5jyZeXDJmOG/aknd1Y/Nnkgx7IUSQ3gYmXanFqgLDw498miYXlTU7Mr1lfhX9uvNuHto81+RIWcQjBzClrCIehc213w2DzISqjFX3HDCMOCimoBhS7gA82M5LzdbJeOuN+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6486002)(478600001)(6636002)(66556008)(110136005)(41300700001)(316002)(8936002)(8676002)(4326008)(66946007)(66476007)(44832011)(5660300002)(6506007)(82960400001)(38100700002)(86362001)(6512007)(9686003)(26005)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HtkPsQ8olv7bsS0NmT7880UXQkjNiEqyB+RFn96ur0iRQCrcDuXX0/+EEfE3?=
 =?us-ascii?Q?UwuzslD9JX/FLO42ajrSoiZ/4zk5vfXnGbh95iIrDl//BJRkrgXThjfHsgbv?=
 =?us-ascii?Q?zqn5lHngsYlFWKhphuVdvNqwprtB/vd8CbqzLoonb4ZMSTNDlk9yC2GFVg3c?=
 =?us-ascii?Q?Qqp4QuZP+We67s6wsPlYivp6SlvUxDDHw2vgWovfEZh9+ukFM3qpxyeeQmSR?=
 =?us-ascii?Q?XF5cragZSS4bAN52rnIc3Byvh6odhTOA32kVAXoy6/e4NAYiEuVVUu0UeYzV?=
 =?us-ascii?Q?O93UNcmzqOh4kqCGrRe8iqusLyjM/HOfnLyysyCN/X7Jhn9ElfML6Xbch6b5?=
 =?us-ascii?Q?16+HuawMO2nuQjd9J9cG091m7xaNG5PD0vxd/9RK5eJQVgdpYD1YLofkbg8u?=
 =?us-ascii?Q?Mypni1kY9IM4+LV7xYKSzAP0I+ZrrSDzS4oGBrloTqTjgEzt+iuKzbUJipDs?=
 =?us-ascii?Q?qe9xmx856qRGM4tAojgoJIbsNR61WKyojzuYNtHFfxv6FM7TO1X0drBV9WaO?=
 =?us-ascii?Q?9YS3v7Ti7YHodR0/CQ3PBexYAvU/AkwwzOQR7XHMqhmU+ooJKxKi7T0pyiJE?=
 =?us-ascii?Q?WZejXoLUS0rPG7vbPVJ4I8e/oKH0DGNa4s2cbTpkzsqRmwtUm6og5BmFuS14?=
 =?us-ascii?Q?R5GBa287uHu92E6RuEIOxbj90hUcxrUBVo+MzpiBOg2j8OoYq55yXq3hlAXH?=
 =?us-ascii?Q?52hFt0tTRwJBcbuKNLvFYStpeAyOwi4ygY9WcdUuCmXTF+envuNOfiYfQtys?=
 =?us-ascii?Q?c2VC/L3VuFA2TIFyYtV4Vys4qoA/aHEJEQqs3VoTyuDpAUiO5FPKHBgzX4wD?=
 =?us-ascii?Q?hIJxoaHQiPCujYwbgK5FbAahPe2MGOJsVP1VuvtqheTDEWTScYLVbyqHfZN7?=
 =?us-ascii?Q?K5/vnGrPn4rqjRknidcubNFrUhXogL01uE7HWvTpRda0GVzGW7QZhQ32FuZP?=
 =?us-ascii?Q?omYTVfsjB/7VxmQPPP98TIyj8Sx2lmr8xiSveH5hED22VxI26tn5GzGlDBQf?=
 =?us-ascii?Q?nL0m/rZsq+qd02P9RKhCI28fFfzIKwn1iYq4EHzMH4DGo9vOeP51aVPSRpyS?=
 =?us-ascii?Q?FP6uZPRbLbLU6Urzpwj6v6gt12kaQtTFINhfYRwVji+zcUFKmAx/xtTzpTmW?=
 =?us-ascii?Q?Z6L2TdoJbXZUuC5pEHFGvO26+kCKi9Sfs4wv/+z+J2Y//C/xNZW1YS7PzWy8?=
 =?us-ascii?Q?F4Runw6FBwLF5qGGY4JSoAC7Us/A2NjVJuJB/iiGuaN30/ReAaxT5ItI0KXf?=
 =?us-ascii?Q?CRrzg9Od/tnigW6WOSswka7bPpR5voMgnEWkPHL0S+aO32fF5BJhwdhDtoik?=
 =?us-ascii?Q?IGojWOuH82eo1nyL861OV3OE7OoYqaXLxOnEE8cr2t4lOkU4j3b83vpdkNXZ?=
 =?us-ascii?Q?stoE0SLdfxJzbPEm6J0alnD5NQSzOAzoP2x1WeInrFSrPzSNXCe+hrEVyX0S?=
 =?us-ascii?Q?Xr7JMX2IixJDYYgJIYlfHotL1yARVT4SQNenJMoepXFL0Gyz2MvAuPh6F4eZ?=
 =?us-ascii?Q?iMEdVD8VkeFqgwyNFmk6yu80/BJnArzhKUmXjXyoBnDgqqKALN1mLnggOWAU?=
 =?us-ascii?Q?g0Y/Z9N31d6tZTiWdIPZlIe4UVJCK0yFs17Q18/t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9314882e-9b3b-4fc0-0383-08dbcf26a798
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:35:13.2622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQdfNs1E7s/mtaFeHSGFKpWVgeJMK0RV01foCN25rpgKiq1FfEbqcliOwCzo5grzbxSXYfK8o5oA0Ax9SNAbDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 
> 

[snip]

> > 
> > Properly call device_unregister() to free up the memory associated with
> > the device.
> > 
> > Fixes: 1ad3f701c399 ("cxl/pci: Find and register CXL PMU devices")
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> Although I wonder if we can just give device_unregister() to devm_add_action_or_reset() directly. 
> 

No because the action callback takes void * and device_unregister() takes
a struct device *.

Ira

[snip]
