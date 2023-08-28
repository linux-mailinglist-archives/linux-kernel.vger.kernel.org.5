Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E678B4CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjH1PvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjH1Pui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:50:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E1E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693237835; x=1724773835;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LLpWn8iogsDM8+sGgpbRd4TUWuvW7ystlrRMZkmg16c=;
  b=Oq+PYR9a4ipG83umSrC4NaBf3vWLl+BHVKP5k2m337CtHBeY/uTVtuy0
   FkRoZDnczXaTqtNYV/QXEre8MF0H7Z4lR3g4iJj7nFZLBYsWSPihgaOZ/
   gSjyLKJryKscZHDEvHbzSj+rvlFk1v21411NA81kVOhZKCiwDbcB/WyIc
   mCglXRZLUJVsU7SAuw2c5Y5ec3r/QHEEXvqy+O8+sL+/qd89xDIsic1pN
   DoRq1Qx79LG7/0E5RAnS80ameq7tIIjrQWHCCaGm0qCYncovpqRdbqmkE
   L+BcqKa9sgQEMhoJzJaT4AtZQgauxJ9Zip3YWS9Rh0tBnL1vDqj7DL90T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441480926"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441480926"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 08:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="808323967"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="808323967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 28 Aug 2023 08:49:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 08:49:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 08:49:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 08:49:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 08:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7dFPmiRDNwJR4wpwdu/lGumCh9PXZSUoT8ySdoWIELQ3RdllN1iqwizMlFovFUf9uBb7eV0t5QXTo8AzuprlLJZbWXHgVgyV+KOUZY/ZwUT/o6trukaYlCHSWj3XA59hLCPdzeoRJGaFdJY2oqlqcuFke7AzgBR30o5XEDzO/U7dfShQwWpYossJ1viEuPjCD+ogkIj2Te1Bi9K44iYGvckkJ6qZ3s6fT0mGJOUTuVNrhZlHfE9L4fRVKF4DuPeGE0rPquekTF7FMIGwn5mAX9uODcHPWzF2m+SPGv63c+9vrR1QKyhK8rILI4OG47qjFG/yTT2xWKRcIW/kLEnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku47QR8J+6bN18v44ZSnsrZbX9+/2o+pbM38UIPmhik=;
 b=GtUHumggaH1MPylZXevMgVHEHevdScJNKACKR+YY6sviK5zrnTwgGsj9RQEI0ezM6foi8lY06gN312nPqG84mgGaDZl4TEG6Z3E3DTU8KQl6eIMqypJVb8trKARs6KQYxM5fWqP2nAH9VeFhLmavtywrvul18Wvfn5kFFGgWwpe07kQlLcSYEL4haS062C8BttIl0vZjFK+H7Y5Qcf/IZgpwr8OUt77dRDCMjzyGq3ELm//B3+Xa4b/STHdrisy6ydqfg/HmvrrpTrZ1wqhOpHj+8oO/vzsNLbRhlbjJYkFJa/neK1rXNlXAKhx827wV91tDIXzBWJXd69jrOP2dBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:49:45 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:49:45 +0000
Message-ID: <788c47b0-42f6-fc42-f293-00b14eee0673@intel.com>
Date:   Mon, 28 Aug 2023 08:49:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] nvdimm: of_pmem: Add kfree for kstrdup
To:     Chen Ni <nichen@iscas.ac.cn>, <oohall@gmail.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>
CC:     <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20230828062310.6802-1-nichen@iscas.ac.cn>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230828062310.6802-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::43) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 290cd5b1-5e02-4b5c-adab-08dba7de66c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBJvzuylb2vgmSRO7uuNaHxXuZwIj6q22g0Bd4D0ovOZQPFtlIOyAqwAT7seic3ZvKIFongTmajsNnEYjahr99iem5aTnLQLvBYduqNFiU283lVT63uqle1UiBEvRy4oGcpwbx5WY8YVnaiZo4AkGlc/XpfqoO8l9sgN72O/xNlRzJpIJkbX/QVQzYEEfIH61iImVLgG7TURmInn1n/FfMntqd2FJsQdPafs6VzOykA4MtjUaXVgRF0ElEC/FO/yJSISy+K4H4G0rZl55w0P+HjAH0zU2Yms5c6V2lI0jlpIZ9M1/DZwWi5YpjKOOY6rF8vXTaMdxVqoUP1n6z3hxaRIbNhH3lhCFUGrBR7dtp7lTsdNv5NVJ1r6MqaQsJZAQdwrPY7jDR35QLFm8DxuOc7HH0CcvqA9Qqo2Bb96PEAyU8pKygZ6kpSkm7SAV9Q5FAXVfrFgf0pyDeIWHDNSsvAuWDuTN9G+uh5zFeKlH6CsrpGXe6w0eSMy78HJkaBIxr13GE55Opv7ogbvyBAs6Wj4eZvl4/xn/IEIUBDxpG2/iqYuZoG8mbqqQmUbcGVs5I/0TrlLn/bKsEo+i0l1k+luG5nXO1549XJLO76pf0usMS4ZeUTKw8CTji/1efucnCR5bFmyeVpjN9HHGvw+2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(31686004)(6486002)(6506007)(6666004)(44832011)(66946007)(36756003)(31696002)(86362001)(38100700002)(82960400001)(83380400001)(26005)(4744005)(2906002)(53546011)(478600001)(6512007)(66476007)(5660300002)(8936002)(41300700001)(316002)(66556008)(2616005)(6636002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDY3dXdQSzV6R2dkRFJibmoxQXQxYkJ3WHAwN1V2bEFkTkx6SE54aldOWmth?=
 =?utf-8?B?cG1KNldCNzhWSmVqbjhacTBlaWtCREJkaXpaZ1RwZmJzUnlOZXJDZENxNEhn?=
 =?utf-8?B?RXNNUU45TE9IZkFXVEVVenRZSStlRVR5eCtTWEJURGMyOTdIV2c3aWtqNy9U?=
 =?utf-8?B?ZlB6L1hOOTRTNkdPR3ZuN0xsUkZ2eU9VUkRhdWNra3RiSldrWVBaT0tmQ0Q1?=
 =?utf-8?B?eng1UUpETnlHcFptK2h4RkNWU2NJK0VMQUNML2x0VHNJREowME1xTTBSdzJj?=
 =?utf-8?B?U1hZckNrNmlaZFRVa3NPUmdkVkN6dzRaL3hNY1hnWmVBQkJKRHVjakZCdUZK?=
 =?utf-8?B?NStHYUkvSTRLT2lSVGdQUk5RM3U1K3FKMG01Y0g3c2owWGtkR0VuSnhZVEty?=
 =?utf-8?B?YmhDREZQWGRkbFM0OTFqbnVWMjJrZ3UvMnJ4MlIrcDhhMzI4YXo2WDNSa2No?=
 =?utf-8?B?V0VqWTZQZ1d1bWJuZlB1RnJiK1RDbkhEZnpkYmpucGhVMmREbHR6c2crQkVm?=
 =?utf-8?B?K3YzMUd4aHBySUg2cTQrQ0dtSkx2bjlwRHFvVXE0MU5hQjNyRzZ1bERadkJG?=
 =?utf-8?B?azRVRHZzaEh5S3laeXpnN28xdzA5NjdHOW5La1d3RVV0ZXZXUHVwbEV6alVU?=
 =?utf-8?B?MDQvY0NzWWNJTUk3dW0yQ2x0U2hLUGZJU3VjZFkwZWVrYlFHTnRxUkdYNkw5?=
 =?utf-8?B?VTJEQzBsTm83V0F5dm02WDgxU0ZxdWd4UVZJMnNOeHNxMmo2blNGUEdlMFRF?=
 =?utf-8?B?ZDdmVjFDQlB2dWRjR2k4WTlKNGswbFlOMDdHTzBtenMyN2t0eW1WUldlQnRm?=
 =?utf-8?B?Y1EvWGhzYjVldVRoMktsSVEwQTJMdE55cStnM3gydTlVcklYWXp0WEZQWGU3?=
 =?utf-8?B?eHZDTGl4TmNKRDdRak1XS0pkeVVrdTBHU1F5Q3AzenIyRm04SExWdVZVaHdl?=
 =?utf-8?B?OG00Ymd1YWlyNjMzdkF0YnphbUFmaWF4RnNjVXNIWXVOQUVJOFhsOEZKQXNI?=
 =?utf-8?B?RDlpVXBYQ0NDaHVYekliTFd3Ui83NHQ0bHZmZldOalVQQTVydUMxTlZ3NlF2?=
 =?utf-8?B?M0dMK1J3bnhHWkhCT284M05qSk5KVDJMTDlYZnV3ekIvaXJhVU5CQ2w3OEZ6?=
 =?utf-8?B?Tkp6YWNCc3dOc0lDNER6aDlkNVZGbkg1SmNibk5oSjV0cHNWQW45eDM4YXQz?=
 =?utf-8?B?TzVGSFE0c1lzSzVBME1wb0s3Tzh1L1h1TitBQ3h0UE1yd2Vvd0FIa2FydThK?=
 =?utf-8?B?emFremYrTkZDTHlvNzJFRXNOL0JwamJJMThwWkQ4RFhHQXcySktReUZVeFlz?=
 =?utf-8?B?b09KRVh5MzRqTzY3THJnekdYN1RrVVd5MjVvZ2gzdDNLTzJ6RTZaQ0swLzJQ?=
 =?utf-8?B?N3BuRE91NnNjK1B1bTFPSEk2ZW00K0hPc21ZR0FJeHVIZ2o3eTBNUlRLaU9Y?=
 =?utf-8?B?NEY5ZW9KY3NBZzU0a2RpNUJIcG9ydFhOVWpDSE9ZTTYwckxCMUUxSXdUdzhW?=
 =?utf-8?B?aUkxcWkxK2JlbmZURCtlUEY1MW1RWFVKQTVTYUUrdzJqMGhlNkNpUTc5WXhO?=
 =?utf-8?B?RzNEMGdLQTk4TUR5c0hzZ21TRnJYZTFnRlpWVTNCZm1iQ2dpTnRsRXFBdy9K?=
 =?utf-8?B?a2pJN05nN2ZwRVpSQ2ordjErUXMyNWR0VmFReUtHZTFmRWZxWi9BNXdwaGF0?=
 =?utf-8?B?ZFNWa01XOFd5dkVLbzRWWFBQZU1RdTVEbUQwdDZCVUhlYWtYcU5JczVCUDZw?=
 =?utf-8?B?YjVUV1Q2aVg4SVc1S2dRL1Q4VVE3SFYwQ28yOUpDRlErclgzZ2J4dEpEQWlW?=
 =?utf-8?B?VVNVby9yZ0ZnNU9wMUNDYzZCK1pFbGxkYVZUZmYrWnhQZER1d0Fhd0ZGMnky?=
 =?utf-8?B?WlFCdWxHOU1EUmRTQllxeEFZRU9mV29KZkl3MU9VdTNzdFhlb01JSFI0elFh?=
 =?utf-8?B?bFFaT3FyWk5YOCtTL3p5VVFrRDVJLzJ5NHpiVmYwLzFRelpIOVdrcFREVmhS?=
 =?utf-8?B?dkFkQlJUTXdsRms5WnhaeGc0a0Q2eHkrQVJKK3lBeSs2VTZKUzJ0eDVUdERu?=
 =?utf-8?B?ZGNKcmovUXFiTWRvR1ovT3NaSFZCaU1VQmhvTEhlMmRvbjVlQ2dPSmN0MnBi?=
 =?utf-8?Q?RY9pWveVtQ4mhiCozUrHGxvR2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 290cd5b1-5e02-4b5c-adab-08dba7de66c4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:49:45.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3E0gkakH1NW2UkvWshCtqBQpYC5mlyOGrCm0E/SavytLke1LzbTmdXrOF69i9IBK0yfABjBud4cICK+qxRnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7024
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/23 23:23, Chen Ni wrote:
> Add kfree() for kstrdup() in order to avoid memory leak.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Can you please add a fixes tag? Thanks!

> ---
>   drivers/nvdimm/of_pmem.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce..fe6edb7e6631 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -31,11 +31,17 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   
>   	priv->bus_desc.provider_name = kstrdup(pdev->name, GFP_KERNEL);
> +	if (!priv->bus_desc.provider_name) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
>   	priv->bus_desc.module = THIS_MODULE;
>   	priv->bus_desc.of_node = np;
>   
>   	priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>   	if (!bus) {
> +		kfree(priv->bus_desc.provider_name);
>   		kfree(priv);
>   		return -ENODEV;
>   	}
