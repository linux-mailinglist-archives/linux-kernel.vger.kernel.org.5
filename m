Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B92805340
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbjLELoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345158AbjLELog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:44:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E34C6;
        Tue,  5 Dec 2023 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701776681; x=1733312681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YYMVFBhf6k+7J94VvW50O3q99SaGPEUbp8/omqQrsgo=;
  b=Ydd9M4FA/YX8076jh0v01lnnMVGolaZlbM8mGoBrmoa2NpSgXJtX1tiV
   ecXKh05jG76AAUvcPfQZcAUqXkn9+Kpc8suT6pMTBeQbA3oVS11MA7aOT
   LfbrHvj5aec6CdT6gLvrrFJDqc2uySVT43d+sDKoG7TCHStAw6atYl0IX
   TDUHDNNugBzOLSZ+/UHk7hbTvH5+6nKQ68HkgaV2xOmnHscPwTx1HpwT3
   y5S8LwghDu+isKyBQIDAasUsXv/cslg6txDHWOcW5d+YePXyhGdTUqtaH
   knwzvS1kFkW8Cq/qmrKouIQwTgPsHy2m7UKxgT+Wofe0uXgfMEf3a13oa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="373328552"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="373328552"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 03:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="770886036"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="770886036"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 03:44:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 03:44:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 03:44:39 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 03:44:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn2C0dWz3YnE42Z0t0lAyHUrrArq6d5coCBEwtr6K8LCWG2k8vPZwr7/Ti62pVXtDQnpzhdTIgR48h3iwvia9jcWbgmawFkUtjR1RolQR7u+Tkyj2evQqwwmHkeRssfnsd7teW4RVZwr+/ptyGkU4iWGd/wNYeJu0B0GRdG864F9qIovwWSfOdAa7RbXT1E5ZOU1J4NlLf4F4UsCTjbDHpF4Rqd0AkGediLmuo8RGqUklcg75yL58B9ioSgefGv885Un5IrLwwts01Gn2zjSy0kYmphAdB/VP3ys0vVZuioRnzMsJJwj7j9xofnl7ud6AG+2syi0PtGX5ySU//UIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUX75PcArKQZzLHRkMKeQNp7yaeYt+ZPYoGt8R6oxfs=;
 b=B8GAQrrjD3Jp6Ppj/JeAJ3eCEz/j/R/iatkNmeTIOiN0eaazZpjUj0ctVc32TCSGofvuydtZGtOvukOU2bSwXbXPfCUZEn7OhvR8Bys4aEE8qn/YZElFLccvRuG9paHFTejuCMLBVCKmxCD6UhrSHq2iL1NOFrB4ULlwBloH2LCVwHbuTorsrJwUerhQZIVaBK5L9o2vSlSzHWwFDGH+m3BzqvtA9SPBAJxwwx1bQdMeZCS1GCqfHIkTvUOBpoh7jtr3C0uqD5zluTzxSFh9Bv1JilyLjLoLQHafzKRa4auqgvmfqOixIj5N2FPG6ecCf/fCPa0ojoHsVxekrIB55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CO1PR11MB4945.namprd11.prod.outlook.com (2603:10b6:303:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:44:33 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:44:33 +0000
Message-ID: <43df8dd9-bcf9-4c69-9e26-5dfdf5c27e81@intel.com>
Date:   Tue, 5 Dec 2023 12:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 net 2/2] net: hns: fix fake link up on xge port
To:     Jijie Shao <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204143232.3221542-1-shaojijie@huawei.com>
 <20231204143232.3221542-3-shaojijie@huawei.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231204143232.3221542-3-shaojijie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CO1PR11MB4945:EE_
X-MS-Office365-Filtering-Correlation-Id: 76055fb7-011e-4fc4-e4f1-08dbf5878c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cW7cmV+YWm+kNKZ4w6110qLY83Kk/A+soLDaySG1JVg/69NnxU7u8zTHFLIASZnX+wsglUBzwPpNmtngoaceJ+DvamgdiokxHc9NzePIr5u+8dXDKAnOa5RD7cCu77ltynzUIPQkWO/HMrhuqARfav57kDPI7FrbzAQWGPKLh86nZOISQqXaKIZy1wQFqMomZKwrgjx5pMl9KjpwyDRkiN0NEl7H0KjkbVbdC7Y2txZH9NIb2h9DYIn2okjUyHN9bLssS+h16RaTWdH+/r3DMFBWncG6LvLoFxU1V0hOQoGp00NB1e6DWrFR2y9ibizcnwtn1ovh29rgdxqbjyYAabFWWQl2W3I4s4r/xlSxzvObGeCec8tiOksCTmcCYndBIk0BXSp07uKt8mn66ryMrG/msbawUUO47+V9uDJTG0+s0q6yINaoBO6GG9CAnQC4ifMFmEdhvddH2147Fjq4GL31nU58l4FW2rcCzioXRDpnim/rAQ4MDfO5v0f/iGxk07PbSzUJeAqvcSuBG5G0d213vnzEpOfp6GKKkX8WBSZlw/pHM21d9FZcZdnpdbHvd/AjFoQD0Zd43FLReNcBZrgntHVLDoo+kA11YJBOlR+w19t/NHzqAZaCH8koHP9dBoOAYnvg6NazrPf824s5Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(5660300002)(44832011)(7416002)(86362001)(4326008)(8936002)(8676002)(2906002)(41300700001)(6666004)(36756003)(82960400001)(2616005)(6506007)(6512007)(53546011)(478600001)(26005)(6486002)(38100700002)(31686004)(66556008)(66476007)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFlKYWh0TFE2RWVZcUdmQjU1QWVLVnYxSmhTWExjMEhvd3FtTEFYWlR2TmJh?=
 =?utf-8?B?eVVmT1JYSkV0dzNhK1lHTUQwRXp4MTRmWTc2cGRPMmp4eER0WGNmSHJWV3E1?=
 =?utf-8?B?QnFrelVvaFFRSFVZYUx6WDFGWW9tc3pGQzh4S3dRMkxUejc5elBaSlhJU2NG?=
 =?utf-8?B?VnBrODdnUDltVjl5bzdhMTl4TjRuQUJWb21DVkNETFZQVlAzQlZMeThPUXFm?=
 =?utf-8?B?R01VZjRnTjNkRW9ZZVJpalpzTlJMRmlNc1JHWDFhREdJSzlRM2JqN0dRTmUw?=
 =?utf-8?B?NW1sSjZWVTA4S0JlUkZjOXN2S1lqc2VPMEE0NlBXZm9KS0xQRDZTN0tYbFdk?=
 =?utf-8?B?cUp5aXVYK0VXUVk3ZTl0cGJubjQ5SFhhQTVUZ3FBQ1hZc0p6VFNzd2poa1pT?=
 =?utf-8?B?dGQyRmxPdXJDWlpEV0VTdkVvVUhXbWxCQjVrQXk4T0J3Q042M0V3OHA5WFI1?=
 =?utf-8?B?ZVJldXQ1bGlxc1JqOGZNTzc1cEVPakZkK1hmS3pwRzA3SWUydVMvS2FzanN0?=
 =?utf-8?B?MVR0UG5NeVpSSU5lYVN0S0NQQTRTdXcvVjk3K3hNWFoyY092d1ZWRjhuYTBF?=
 =?utf-8?B?YnJJUEdjeDBocWJEcUh2dG9HRGZHZ3dHVkhLNFlnYnlTTG1xejAvMzYvVHVy?=
 =?utf-8?B?YU5YVytRMkFYbVpWaVRzZlFTQjRUMVpOTTBWQ1Q2ZkNINnE3S2IvYmpBNnZQ?=
 =?utf-8?B?eFRIam82WngySzNvZ0ZSd1JqdEVrajB2S2JNRkpleTJMVjJ0VzVNbTI0cGtU?=
 =?utf-8?B?a2NRRVFSc1kxNlNOdk9UTzZ2S1NCZEs5U1hMMWlHTFJvT2NCTUp6emlweC9E?=
 =?utf-8?B?b1pocGhCaVV0MXNHTkY5NDI5NjhFWFoyZFlOclcySFpOZFZwRG9JN0pJaXhU?=
 =?utf-8?B?ejA2VDcvdkJ6L2pLVmxJNG8rUjdZNE9uSTZDNDNRdkRaU3hNeVhuYzcrRUF0?=
 =?utf-8?B?SVRtakVjMDhIaWErK3QyRG9VT3BkQ1ZRWk93cXZrWUJraVZJaGZINHAyTnAz?=
 =?utf-8?B?OHM3ZjhFaFZLNXIwdDdiSldvVXVTVWhYMklMMEdTYlhCdjl6QzZrb2pNdFBJ?=
 =?utf-8?B?T2FiL21qbUhMRnNxR1FmdVJSbmFHMlZkdHYxdWJBYnl1UGNpajN4dXAzclhX?=
 =?utf-8?B?cHFSUWhTbi9SbWp3VGQ2ZWd1SzJFN1NYa0Ziam9UYlpuMjN3U0EzYk9TYnF2?=
 =?utf-8?B?SUE0QjdLUEJPV3hSYXdsVVdhelo1U3ZrVHlJRHZ1OFpCY1gyWkZ1SmNaWkFU?=
 =?utf-8?B?SUF2ZENObndXdnQyc29wZGU4ZkwrZGJacERvck4xQjRBOUIwc2JmOFVrQzR0?=
 =?utf-8?B?ZUMxYVZuQnBvT2szVGhzZGIzdDhBcnlpKzV6WkxNVmpObzZoWlYwOFk5cTBY?=
 =?utf-8?B?QTR0aW1pTkxQT0tmQlFuTllQU00xMDh6WWYxOG54RDlRUWZqMGQxU21rUzVl?=
 =?utf-8?B?L3F1eFQ2dkVMbDlzcENsV1UwWW80SFJmaTJTKzdzbXo5Y2xOWTZiRVZxMGxx?=
 =?utf-8?B?bkpNSTYweHhsdFh6TnlEOXRCUmZ3dW0yNlE2VWhHT1c3QzVpR0V0YjRzUS9k?=
 =?utf-8?B?UWtrYTBBQ3llNXNHWVM3UG1LakFFRmNMNk9MNXBjRzlJdCtOOFNadE9hMWVn?=
 =?utf-8?B?emV0VHhhcW96bE1kc0xWZWJIQU5BK2pkZjBocldVRW01Q0lwTVcrVkZtZFVj?=
 =?utf-8?B?d3BBUk83YUxoM3F2cnFWTGo3WDZ0RFo1VWNCK2gwakxZdTdlNEZycmd0NW94?=
 =?utf-8?B?cWIwWFc1b0pKOXBhNVFwb0FRdzNCSSs1ZmVvQ21wREUxcmNORERvcStJRUNI?=
 =?utf-8?B?Vld4S2pEWUFBSEk2TXRkMW41eUFPUU1ic0wyYWVZWml0anNhVXpZZmFoK1lG?=
 =?utf-8?B?cVNRZ3lBek83c0dYVisvV2VoMVJxMDNKNFNpZGxnVjlhck9mcU94MHhBT2hG?=
 =?utf-8?B?SHErdVFHTk4vWlZoTWVueGV1b0kwbDNwamZxd1VTU21xMUNIOGRpZkNsaHNs?=
 =?utf-8?B?MC9ndi9NcXRrR3B5K3pmNmMxbXlkVXRvODBnS3NKQkFweFdMdTJZbUpFZC9L?=
 =?utf-8?B?T1B0c2EwL2ZndzU0bnFXTFcyRHU0bjRUWnBjZ1VTTnVnNHVEcDM5SkFDVXJh?=
 =?utf-8?B?VGxNRVJuUG1EamF6Qm84TEh5bXk0RnBTdGhSUXNGMUd6VzVzTjl2VktMVmgw?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 76055fb7-011e-4fc4-e4f1-08dbf5878c81
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 11:44:33.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qrq4IbmSBy/WCYH6wQnfx2/tx4iMrZR7utEyViJgsCZxg+FwVDGOf9pe1wZtAGMokIF3P5OmT0lc/mxaIWfyfn7mf2xb2g2SrR+jzgpioRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.12.2023 15:32, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> If a xge port just connect with an optical module and no fiber,
> it may have a fake link up because there may be interference on
> the hardware. This patch adds an anti-shake to avoid the problem.
> And the time of anti-shake is base on tests.
> 
> Fixes: b917078c1c10 ("net: hns: Add ACPI support to check SFP present")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---

Thanks!
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../net/ethernet/hisilicon/hns/hns_dsaf_mac.c | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> index 928d934cb21a..f75668c47935 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
> @@ -66,6 +66,27 @@ static enum mac_mode hns_get_enet_interface(const struct hns_mac_cb *mac_cb)
>  	}
>  }
>  
> +static u32 hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv)
> +{
> +#define HNS_MAC_LINK_WAIT_TIME 5
> +#define HNS_MAC_LINK_WAIT_CNT 40
> +
> +	u32 link_status = 0;
> +	int i;
> +
> +	if (!mac_ctrl_drv->get_link_status)
> +		return link_status;
> +
> +	for (i = 0; i < HNS_MAC_LINK_WAIT_CNT; i++) {
> +		msleep(HNS_MAC_LINK_WAIT_TIME);
> +		mac_ctrl_drv->get_link_status(mac_ctrl_drv, &link_status);
> +		if (!link_status)
> +			break;
> +	}
> +
> +	return link_status;
> +}
> +
>  void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
>  {
>  	struct mac_driver *mac_ctrl_drv;
> @@ -83,6 +104,14 @@ void hns_mac_get_link_status(struct hns_mac_cb *mac_cb, u32 *link_status)
>  							       &sfp_prsnt);
>  		if (!ret)
>  			*link_status = *link_status && sfp_prsnt;
> +
> +		/* for FIBER port, it may have a fake link up.
> +		 * when the link status changes from down to up, we need to do
> +		 * anti-shake. the anti-shake time is base on tests.
> +		 * only FIBER port need to do this.
> +		 */
> +		if (*link_status && !mac_cb->link)
> +			*link_status = hns_mac_link_anti_shake(mac_ctrl_drv);
>  	}
>  
>  	mac_cb->link = *link_status;
