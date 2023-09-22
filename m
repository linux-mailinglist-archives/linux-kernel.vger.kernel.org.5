Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366C7AB471
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjIVPIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjIVPIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:08:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF4C6;
        Fri, 22 Sep 2023 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695395313; x=1726931313;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PJYeg2Lieff4OMVdp56TkjYYKpb8IUcbMGFsoxiUeRE=;
  b=hZX3akmwBVu5VrBmWkLtNcOzBYQ+/O2jFGaaPVGydEvqS8aJ7ktgXB8r
   Vf2tbnQ48LTy+jljoFqHJQwqXJkMsAvgv2QwBxU+HXN9udaQYUrnLWjIn
   WOKZJrQjE/bq8/TBJRouvszUtxQDXYE+Qqgw99TXNE07AGoyELZ/TOVCv
   VA35pR8P+gaWHaDyZlv/idOrNIVbi/FFrVjSqQmEjHNSDaKxeuBwbccgc
   SkgYPNVgUpa9khgUj/8Un9NQkY6PY1V1nyAMa9nGqrN/gMRa9hTJgjykG
   wpItwAnafKSCvh4uuXkTAj0D15Mx0nOeOqbuYsJYJCTjHsytUXXfaXmWv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="380749528"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="380749528"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 08:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="862972336"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862972336"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 08:08:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 08:08:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 08:08:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 08:08:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9p6TxaafZvmCRBrAlkPop98DmdII29xDCJSLWOjBMnRhOQkevVIlfe8i7Qd6ePQe+IGf0EMQJw+yAZehZu2GVsro2+guwg93Hcv3ViH11eD87LJQBHxZeFUeFoo3o22fzp5ZPWPXfQ+g3Luzh4VGYqKrQ2cuguAszxF9f4bdEyQIT002zlFOEf2Vc3PuScVUFZinBbllmGbXCXyBJMZ4+DLd4Ylhr0TERb6hkeJ3n6PukuRmNFuz59LDDPKKlg+tEmGEOwpv9TOiFVgWz9PW4i0xMg/b9kdYGRmdx7WatqooZ+uksqAAcGmX9ID3sh2Hil71plhDBO92JB2tbmP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJQ9t0cMpE2hACLqnJZ9bg1cipuTD7HwqhHqRr2Dy/4=;
 b=YfG30xzBu7VKZHYBAJOOqlNGnS9vjff3wa7w05Ht93ybHRR61vNMIGdCwMgygF1k+9DA9q/NwCggAhHAcGsFW9L4Ia0E+rfdvpoResSRi/dF1cGrkdPLNtctS7PFRcf+utmoyv8n6jgPpShwbi8OEkPnlydLsbUVIztNQGjXIEf2BoxizQHCotGarskUDsNiE9BgJt4R31GumX+BkVUy+QLnxmzm101VyEMzM6UH99QZ6/12FFh0G1GK8sa1R27XVk/81YbIS5HgZpc9227nDZ6DI5MdQkN3xSeInggztv7qkwVf0/pjai1D6flqN9L5hMds3ePpwXMgLByWvnp6NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7508.namprd11.prod.outlook.com (2603:10b6:8:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 15:08:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 15:08:03 +0000
Message-ID: <40dae8cc-2f13-846d-1e23-e7dc31c0e419@intel.com>
Date:   Fri, 22 Sep 2023 08:07:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH v2 7/7] cxl/memdev: Fix a whitespace warning
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <CGME20230922113404epcas2p3995ec7890319931c33b0a549214c95ca@epcas2p3.samsung.com>
 <20230922113650.3301992-1-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922113650.3301992-1-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0031.prod.exchangelabs.com (2603:10b6:a02:80::44)
 To PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 24683b85-2617-46dd-e8d4-08dbbb7db79c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JI1WSvyv+IKnxIXQ7XiQiAPj7f8el6PKOozGxuNGgPdpHXsGGD0ujJa63gL9q5UAwl2WeOXKq9jvGrjAtBWbXTFWHSPE0GK5wiwVnj7jQhmJku3uHk1JJ/F4nxPgCVeXTM45ho1NGI6Ya1CuFsbCbf5xH67/FypVDzkD1m7u/pIi+tKjWg2PJhzeOiMmp8ijGGpRDdlyj8yCIzxBeuDZhgj7dRHfFr6DsLf0jHdJ5wqat4HRusr6lI/gTzK/Flsc8sQjMuWRJfBKCPG+tHq9v3n26FLLQznMb6MRe6BGXEyfnbqJTW7JIokP3csDutC4+y/P3/qOR5kU2G3RvW8THm/VUkBoUO5FzwQxFc4XaRD6Ko6aPku2769RDyM/TEIye6PEaxpTsBPbRmCLXOKqRQygUdP8PsvfTCSjhQ6ZC5UVKZoTeb+73jFseE7b2DOWhjtxV3XUTUsSlQH1ntMW2/RYmFZYN2lkpOLRhsmPTB6rPjHJPMi05VsvaynDH9pgZ0vHl8UNh7MEi+k2H4AEaWQhZMrn15FSiNMhNu3jB1O+jP2wUrezbkMMGUSdJiWgCrNjOlCx+Qcf72HmaosZOpsJqkV0bDq3S31a+aSO0kXYC+M/rKekdbJ9FS72LL0WNwWwc8GVpsmj+Cqiigg41Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(186009)(451199024)(44832011)(7416002)(4744005)(2906002)(5660300002)(82960400001)(6512007)(31686004)(8676002)(8936002)(4326008)(31696002)(86362001)(26005)(54906003)(316002)(66476007)(38100700002)(41300700001)(83380400001)(36756003)(2616005)(6486002)(6666004)(66556008)(478600001)(66946007)(110136005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVZtQ1NmM3RUTklETFAralovYzRqbFI0RHVMcnU4dmxjTGo5S1ZrS3Z4UXl2?=
 =?utf-8?B?OUxDN2pSNUdmYjVmSnBHVkl3OW0wdHNkTllsRDRYeWNOSC9IYTBEV0dHaXhr?=
 =?utf-8?B?NlMyRUJXaC9yNE45SmZuZFZjRUkvU3RlSjZSSmdQallyNXRrUHc4eXdSZnVk?=
 =?utf-8?B?ejlXTS9IZ01zYUdBa2JOZDR6RjRjVkc3OXpZY1VkZEdVRGZhS3VtSDF0RU9S?=
 =?utf-8?B?aExjb2x1eW9aTmZHMUhBY0dkcjFPSk5PbDRsYnhWNnRFMTZhc295WWErbFhk?=
 =?utf-8?B?VksyekNMN2FBN0VHbFRyTTViY0xTQ1JycEd5M3IydDkvUTBINXlCbDVSZzBk?=
 =?utf-8?B?Wi9CZHF1eFZoMWxjWU5GWWx5QUxkVFM5bFBhRTV2YWFYUUZPbzdmTDhpZlYr?=
 =?utf-8?B?YUJFaXBvUVlpVW9NNGhINGx3aCtQdnRXUUdtaysvTUFuaHhPOWRoVS9rMDdG?=
 =?utf-8?B?MGh6N05VSFJ2SXN2Uk85ZFlWbEZzZVREZDdkRy9PcXJ5eE9FWmhXdmZtV0Ju?=
 =?utf-8?B?MHNRbi93R1lPMlpybTBMKzNRUUFIUTFVRTIvM1JxUWxZdmZ3TktqemlrR2lT?=
 =?utf-8?B?bmtabTNIZmRmOTBIVlFXSjlXdGNkTEMycFR6UzJkT0RqVER4Qm5hSmtsSldK?=
 =?utf-8?B?TEhVWWRPWWhnRVY2YjZ3bmdLQVRZcHhTSnI1cU82WGo2bm5CVWloOGR4dUFZ?=
 =?utf-8?B?UktqcGlIZTlaM0N3dkt1SWFBSTljNXRrSnBTVm91Zk8zamVCODZHTjYrK3Ax?=
 =?utf-8?B?ZFJWTW9JRG5tWTBlZ0lhVUExSGxoVUE4eWtaTnhiVVZyMUFpRFhNczBoYlIr?=
 =?utf-8?B?WTBIWE5aYjR0L253dTBLV3QwT0NiTlkwL3ZlZlpMakl1QkhKMkRNZnAzTnoy?=
 =?utf-8?B?V3d5WnVFUTRpSkJvSU1qdWprNHlQTmc1d1FXL0hVQ2hleHZpeXdRUnY4NFZD?=
 =?utf-8?B?WFdDY3FWOElFREZOaGRPMlBnaVI5WHlMdzg4OG1haDVURUFidlhCQ0xZeTkr?=
 =?utf-8?B?dEJxUVRtUTg0eXhobUE4SlA0OFdlcDdzRUpsZCtWYXZBR20wOWtpempEOUZF?=
 =?utf-8?B?czVBS1pGbkwzVkJodHJZVHRhZkplek5IYWhwSVZqS0I2aVFOeU8vWittRmRD?=
 =?utf-8?B?bFhwQ3NHNmM1ZVVWLytEZkN0L1kxR0ZRWnM5ZTJiZHhkQnFFYTl3SGNva2JT?=
 =?utf-8?B?OWorNUZPTHFXay9icHdJRkNlejRWdEh4UzVNbUl0RmNEY3dkdy9vZVRPei90?=
 =?utf-8?B?NzdsWk5QUHAxcm9BYmdCVnBXUGgwSHNGdy9SVFlCbkhXOW9XRkVpRGQ4S3Zu?=
 =?utf-8?B?aWYzMjB1elIwUDRyaTFoZzR6MURic3Y1NnJmY1UyenRnZzhwUGMxSDRJOFV0?=
 =?utf-8?B?dWtHc3NweHVjYmVPRlphWmFsWHkvU2MzdkNWbVlJeFFPejhqYktYb2IyeTFs?=
 =?utf-8?B?VjA4L3NyRytOaE1qa0s4Z0lSd0ExVXNKempiY2VpM2pKRHZ0S2FpbzFBckQy?=
 =?utf-8?B?RWlqWnl6RmpuYjFZMjYrOUVLTXc3ZXFYVVE0NzF2c0tmSXhFcnBkeERYZktv?=
 =?utf-8?B?OHVMMUpuZk1XanlZazJBbWlWRHcvRkZ3QURVUWlmMm9jbHM1by9PQ3hiMkNV?=
 =?utf-8?B?bGNld3VFc3VHUndjcUR0ekFtSDR4UmNvRGxZalVLNEZVUDE1dEUwbXFrWkRw?=
 =?utf-8?B?OWVEamlOTnhmZXE3dXdMd2JXL2M2d0Z0bTdKei9lOElqcWQvYWpSMm94cHEw?=
 =?utf-8?B?N1ZWY01SMEh1OTlzUk4wRFBIL2ZHbUpYZ1JES1RBVlQyWFY1V3ZIL3B6N0p0?=
 =?utf-8?B?aVlGWGgvLzMrMmFvdlhmSm9ROWNPemVzY0psNmxRRlpqZG1abnJ6ai9kNjUr?=
 =?utf-8?B?cWZiOVQ2SzhhSnROWFRNY2ViMzZHUFhDOXc3VDNvNXFSM09wbFpwRVBSSmYw?=
 =?utf-8?B?Yk92MnpBWHJmakpLM1NIaWZWRVBYVmVhSjk0bTUxNXdqYStzeWh2VGFyZG9n?=
 =?utf-8?B?NVJwQWVPZ1pVeWl5RURGZ1hEaGhvYlpPbjBsb2VQY3o1U3lPM0NqSjVrNWlk?=
 =?utf-8?B?aklPY0pFdm5RaFV0UU55SWRTdmxjem4xOTY4Z0RYb3hYNFl0bmVDbDhxcE9r?=
 =?utf-8?B?eTlsSFdSQWIrcU5OTjgxamdaZDZKeVdyT3BUeWwvNU96Z0RZY0dMVU1jMnZv?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24683b85-2617-46dd-e8d4-08dbbb7db79c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 15:08:03.0603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS0cvrp13zEB+Ani8hUT3u6rX7AaXzKMJKGGZPY3TWXbIvbrsgZ+VaEnLQgP/RXSDhraAx0Y4csUfoT5qRSdfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 04:36, Jeongtae Park wrote:
> WARNING: please, no spaces at the start of a line
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 7e8fca4707c0..ce67df163452 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1010,7 +1010,7 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>  
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  {
