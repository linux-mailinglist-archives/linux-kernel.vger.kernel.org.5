Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD107B219C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjI1Ppc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjI1Pp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:45:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E357CB7;
        Thu, 28 Sep 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695915924; x=1727451924;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=bmJWq4Kip+nBPXSdujnKAIzImtJ86SyS+vuIwOoNbKw=;
  b=A/6pgbMkKJov+NBovmO60ZKEr0MaSfXKBZeCkiCTV2H8zoiCXeHKlEnr
   sQonco0ySNuIElUMtmB/ekpcHmdwbRPIK5Y7vJLeT/Uy18s36n2tpW6ny
   EpeLS7VnkT51AUFn+z92vPWdA4iEa5WJIvfQwfOXRlRFNg2NxkdFzhzBV
   4K37+Ksm+2KUxrhaJJKXGxDD34gSiCJi/if98maERMiEinR2P3U0lJyah
   8t9tueAJY+cr8gEiEA0AapRQY+WSfJi3g3G5hgpot1uw8PxsZkZsIegEU
   Qsq13BD5qPOLK8ntTulPgblycGkVoSsMe8O+Yy9OXe4cK9cXUFPOvebPR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="413003668"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="413003668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 08:45:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="749636129"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="749636129"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 08:45:19 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 08:45:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 08:45:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 08:45:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 08:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gErZeVvKHwL3SWqLxEKcOigQHxTr0DVh1YPUMJ7Lt7jj883LuePVoWCA+cwFb3n7ckdGMvt9rauenmxd96cnSUSDCwIgsB/9tnT3dTqlSqi7YVaGpb0J9aAwKLazlfFyHUsyijTY9stcqRk/NHkYBL1TQM+WpdlstbOuUKOmzy6L6LNZS91RRvlMhIMJHkFmOfulGr3ZhS1kYBSzPBlL5ehUb7EwdzbjuiMc9Q5GIXiEHz2bF2YVbo0YlVbfQttz4RTeYtpEpNLHDMTQbDA1Y7nWC2Qa0X9hrhNSuhcvKFpc6Zj8T1irtBC2LV44bXXLlDz6Bg0Zg31UquVcA2qttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmOvgLXSDXhhVA1mFTXCU5fJBKXAWyHMGk46vBOr/YE=;
 b=HRMhVhr4vzScZt9771qR3vvrMEWwyrt/QWoKHkIg+EL4dJuBiUDcQ4svJmSUFjuXCcowdc7fsk7oMDzPzhcYO8TTIISgDAipUzMdBK7ATh/2jO7cpJL8tMogXuZrtMQ0mXo60hag66btYnxZz7l/kT39EQiPp2et7wuXfWp3oaLGQUhtztcGyr2G5PVadJrCT58I5nmVj7A4OzUvd/hT9FfnRFQUJVO8szo5PEAFiFYBDNaZTZdhqeCNoTMssyKSHepxx6WwKXKdygTsFed8zXb6jLyL33Ycegzuc2BvZiT4Oe9+LTouMCf2Q8qvPWpngPnBpwxgnBnn2MqcrUum9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 15:45:13 +0000
Received: from MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::1948:f795:4145:9bcc]) by MW4PR11MB6763.namprd11.prod.outlook.com
 ([fe80::1948:f795:4145:9bcc%3]) with mapi id 15.20.6792.024; Thu, 28 Sep 2023
 15:45:13 +0000
Message-ID: <9842e1cc-3e61-3759-30f0-b4968622e0a7@intel.com>
Date:   Thu, 28 Sep 2023 08:45:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND] fpga: region: Fix possible memory leak in
 fpga_region_register_full()
Content-Language: en-US
To:     Jinjie Ruan <ruanjinjie@huawei.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230928091636.1209914-1-ruanjinjie@huawei.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20230928091636.1209914-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:303:2b::14) To MW4PR11MB6763.namprd11.prod.outlook.com
 (2603:10b6:303:20b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB6763:EE_|PH8PR11MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 16516a39-3f47-4bf4-d2b3-08dbc039e78f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HEo/OT9PcCImmLH+w7LwXGBAPAth/PlVN45nVWrjBeb5nYY0/MKVhjxFFe0IMNBie7cx4/QI3oEI0Mtc63oyDX6WpSXEx2Xeuti0ro3EmAKQ+QGgh9Pkc44IE76DCm8zSOYg3xmCYJGVji0nkVuL7KJhVyEIHp4o+KYeNg6l+7zD5qRlrAFBuDaNZl8iQvEWHbkeLukWhQMXnAHw34Y60HWWwN3tM2YVxt+yqpqy5Gt6xor9pZpH5lwmJnazCowHNL7gSIgBpUwoM++gv5mx+EWQWXY2QltepmtUnonzB8fYUn9z9mocsTm2V1E9YbRyBxDH7BYlKN+oZAUzmRX7kzYIBux/mimpStGhApDsRYxe1fdCKpIo9Ifzuf3mDkVE/vYYBCalFnLlvpZXZQDlM+PE2nOF86gsglX6CU42ACCkunHz1AYXv5DqCaDgjCg/wsLQ+AwwLiN0L/BbNfG6hlPHAx1dN/Uqw9VTlk1DcpUG2F4ziBkH7qkWqOFsa1pYeadG6QnouPfhXRzumpyE87npHujk2TELt1ePBh9dKQOKfxfy1oOSVvDl9PIIdi00N8mSEYFSPXHB8CYR9xVOCuNw+hIOS7XaKe6I8c3HT5sEZ58rIhXSq0czmvZ9LQOrbiS76GZuEcfBEVmI3v4VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6763.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(478600001)(2616005)(86362001)(82960400001)(31696002)(36756003)(6486002)(5660300002)(83380400001)(38100700002)(53546011)(6506007)(6512007)(2906002)(8936002)(31686004)(8676002)(316002)(41300700001)(66946007)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHdyR09NNmluSlRmdEE2TkdxbitsdzJGM1hpUDZrQWVrQU1lWDExQ0N2RDhm?=
 =?utf-8?B?VUkyTmQ5RlJLUVR1YUIzWW1iZlVRaTB6UE50RFg4ZWRHYnExQkJwekFDdUM5?=
 =?utf-8?B?VExHVmdvRlVUcEo5UnMxZlBOd1J5cGtRdXVodHRlZmZMRGl0aHF0cXpGeXZi?=
 =?utf-8?B?NUhWeDJXTkNGa3BsQnlndEZkaVIxcEdUVkJhYzN3VGROUlhFTlhZNGNHVVE5?=
 =?utf-8?B?bis5UVhVUm9yTm9HNmdrWUpWcGNsWjdVT29WaGN1ZTA3eExHbW9SdkFyT1Bs?=
 =?utf-8?B?WGtWZXM4T2dNOGttOTh3QnhRVjc2V3NuWnkwYzlSQzh6ekttTGdDSFNsQTlO?=
 =?utf-8?B?aXNKcWZTU3VFck1MSmpBZDFUVzRoWlZmaHJ4NTB2eUlKSkdXRDBDMy8reGxD?=
 =?utf-8?B?ODFVeFpRaFVEQzJnZXFWcTNhM0FqaWV4RkFrVjhiMWZZTmhPYlp3VkxYaW1j?=
 =?utf-8?B?V1h3V0U5K00xRjdCN1VsRzdzcDQ1eVJ2SGZGU000cWVRQkpJdS9mdFJWRU5U?=
 =?utf-8?B?Qm56MDNaZGxtM0F6Z3F0SHFFU01hQXF1VGVKVk5zaUJSelpZRXloYXlkNk9Y?=
 =?utf-8?B?Rzc2SEFoRGtjMnJndEJzYjlBaFVFWlZseml2NUplZi9XdVplVCt1UmlzTTQ5?=
 =?utf-8?B?dXhlTm5DVmRUY3pHUGJZbGxYNjJOZHNOYTlyUGVxMkxCZGxKOE5CT25SKzMw?=
 =?utf-8?B?UG44QWE0bzFPVkFEcFZrNHNwWnFrZkc1RHVyTTQxc1BLOWlCTHBnMVhIOFVH?=
 =?utf-8?B?VEdmMG1vbTVwNlZPTGt5QWVUbGpuOXJEWFlac1BENFhscWE2ZkxCSjRvenpq?=
 =?utf-8?B?cDBqVG9OTWtERE92UE1weFE4aG40ajdhS2h0VVIyZlkwNWo3MTlIaFNabXU1?=
 =?utf-8?B?M2RlNWFMVngvQ29aS3F6UElxUmJxak1aNGx0V05yaHhzWEdKc3lhR3JJbFBT?=
 =?utf-8?B?aENBaUVlWmZLTm9aTEZTOUpKdnFFWU5tWXFuSUNiNUNkenFkZ3BPWFFQalpt?=
 =?utf-8?B?RUo5M2hhWmhYTHdMMTBJREhKZTJVRVE5S291L3BLUiswcE0zVUtCTkExaEF1?=
 =?utf-8?B?Rklad3dlQ25iYTg4bEtGYmdKMkxCdjh2UTd0Zjk3ZkZMVHllNEpqdC8wcUFU?=
 =?utf-8?B?WmxhRFAwWlhUS1JUZCs3TlpvTnc2VVlqcEJPWmZoVHoxUUJkeGdPdU5MRWlv?=
 =?utf-8?B?NkVzTWhmdWxYd1BjWDVVV3Awb0hRYUpTQVFsNExTQU5uajVpSEdhSkxTd25T?=
 =?utf-8?B?R2J5TjFzT3FSYzVwbmxaV3hiZ2dBOXZjTXRwdjU4VW5PbGF1a1NTQ003aGxr?=
 =?utf-8?B?RS95MTZHUysxNzhrdXMvck5vVkJ3b2s4OFhseWRyS0ZHd0cvUGRaZmhHN2ZH?=
 =?utf-8?B?U2o2YlkvNUFYaGZ6RkVVei8yc1J1eXltT2VaakNrZTFvOHVNWTR1K0ZOU1FQ?=
 =?utf-8?B?WkMyVXdZV05qcncwSFFHaFZPNzF2aFN1bERSQU9KSWV5US94WFRZVzhIZmQ3?=
 =?utf-8?B?UkRJT3RhNnhCMUJ6TjFOSjRJWDMwNDRXRWk0N2lxYUlwVDByc2hIQ1N2NklQ?=
 =?utf-8?B?UUFqZ0kyZTA4ZUxPam03aHVEMHo3NnN6b0k2eXpybTBXK1pPckNXTXdzcytz?=
 =?utf-8?B?dUlkQnRKZDBEQVVYTlFic2pFL3FIQUdWUGhZeG5IU3M4S0lJWnppajNyK1FJ?=
 =?utf-8?B?dVRtejVlaXZHR1NHNU9yWjlWZ3VkYTloM3F2cHhKK2NnT29nc0gwTTlURkVl?=
 =?utf-8?B?S1JJdEFGQktrNUhyemRCZnQvbXVHbUV5Z3ZFTXlxNXRDM1NscUgxZUJlM3Iv?=
 =?utf-8?B?RSs2cDdQVktwYml1Q0I2d1A2T2NWSUgrRlpudnJDQ1dRZVFLV204bjVxVWlh?=
 =?utf-8?B?ZHNaR1RGZEpIaWJMaHJBUys2Sk5MYWFFTFA4bzJWU083ZzY4VmZ6QWtFak9w?=
 =?utf-8?B?UEQwWWJHK05TK28rQkg0RmpIZG8wZ0ZiVWYzV3kwclFJeVQyK1JldDREamwz?=
 =?utf-8?B?S0Nmd3lTOFZRdm5KeXg0NE9JSzIwWUZXdU5ETEw1aVNNaEs4VE9kSFhjSCsv?=
 =?utf-8?B?Rzc1a2JyQkh4Z3ZWa0kxY08rdk1EREpNN0VQV3hVR0NlQm1nSGdJc24wZHRD?=
 =?utf-8?B?b1NEUXBTSXNhZHpRalZXdHF3N0lxZUZrV3dtK0hsb0diaU53NlZDQjVWY3NN?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16516a39-3f47-4bf4-d2b3-08dbc039e78f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6763.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 15:45:13.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPmkfTYLgXBY2DuENXqeBFy7rUfWCarYlewjLBbJyQ2v0RHVKfxJ+D/t4cSNGFRMaX/eTAUGQbZ2TGrmIc95Mfc+wEXYw5HwZqWmPF2FTfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/23 02:16, Jinjie Ruan wrote:
> If device_register() fails in fpga_region_register_full(), the region
> allocated by kzalloc() and the id allocated by ida_alloc() also need be
> freed otherwise will cause memory leak.
>
> Fixes: 8886a579744f ("fpga: region: Use standard dev_release for class driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/fpga/fpga-region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b364a929425c..9dc6314976ef 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -228,12 +228,13 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>  
>  	ret = device_register(&region->dev);

The comments for device_register() say:

 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.

Note that dev is embedded in the region structure, so freeing region
means freeing dev.

The expectation is that after device_register() has been called, even
if it returns an error, put_device() is used to lower the reference
count. When the reference count is zero, the fpga_region_dev_release()
function is called. fpga_region_dev_release() frees calls ida_free()
and frees the region.

Have you observed different behavior? Do you have evidence of a memory
leak?

Thanks,
- Russ

>  	if (ret) {
> -		put_device(&region->dev);
> -		return ERR_PTR(ret);
> +		goto err_put_device;
>  	}
>  
>  	return region;
>  
> +err_put_device:
> +	put_device(&region->dev);
>  err_remove:
>  	ida_free(&fpga_region_ida, id);
>  err_free:

