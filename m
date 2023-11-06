Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41E7E1E16
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjKFKQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKFKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:16:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B9C93;
        Mon,  6 Nov 2023 02:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699265759; x=1730801759;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XkU6mZe3hFmG5QBkrZ1bM4ms1hYf7JSgEBV+sx2D4S0=;
  b=mcBIJTUPeVZ+VEUFBOvQSAMBFmueSGglUmLpoJlESziucWnTzPiiE0ff
   xHVnujZ1zv8lBGHGROeDFc7JL3hzWWLw3fds10HqTswTrTyw5hMgKSSy5
   g0KRJ6Nd1fI+VXB0b4DL1qmnmiBJSIz5lwWSHsyxaDRzLHmoyMU9D7YcO
   X2BPzKhbBggini60tpj87NxJfswvrF33WFSdJ0wTRV+K/WYZjRTq9gfoo
   DwoNweSnp7KH2F4XHSMYx51o+Pw5XraEewR5IYKRVlq7AfMiSl5ko7kjv
   bziGoyDvciAVHxWgYflbZY8pEk0DQdF50zdM7EpVXXIKtceVOpmFYNnvE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="7879091"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="7879091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 02:15:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="10412943"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 02:15:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:15:56 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 02:15:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 02:15:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 02:15:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnRY07Frzizh8Bb8Wm0gamBIj2fInSgmgl9GyT+xHubisLh8hiB775zoLX/STmFJkwS1y4vQiEd5Fk3JA9fdHKoTB7YSh3ErHWDljA7bZ1LfZygoBnjJhyWRMEGtQQe9dvRVyLVAOevjRZfu8kLAFhGUYfFLfq21fVB25FzhmJ6iZ5VHP+2OTaZZM8jhc448TEX2xEkfv46wvtKQMAeOACtovyNiI7lpaqx81klxjvQ32Lhpwt5UiDHrbwBzvE5f2McyckGmgmJ8wz2f8xqfga30DGXI5NNL2TOMsnHgnPdWe/1BmWhq38QsSMlaT34+94PVyO/0rQn01biyDGy1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY/adPMHhSzt8PZMYaJbz6Pswp5vKF0R63OJYFpGcX8=;
 b=I782HLEpM8qwjZPkkbNnq+cpcceMPheNK/tJ8v/b1fAXlM0/PZhF3NEB9awAbDA2mVCZg89jOJ4fIMRnmav0/3ArXo2MGVgTLjIdqPFEFsXXrUJ6koPyyVQTDutdm69UOmwNcLvQLSVB1qIW6gZbM9UpMCWqT0alYkV2vGcBQ3LzU7d/F+Cb934UT7Xj2yrvg6Hzjye1G/1cpk2t0d9zrztDEQKVoMdy7DVlnN4dIiq18L8MBoa7KUFzYKBwbn5GvqaM1ZBRJvJ8faGnIazRCdvJipP+9Sj4xMLB3X6NhDJiFxy/fGma+BRTUyXqiD9HWS/UXOahAXKlUx11sdxWLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 10:15:52 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 10:15:52 +0000
Message-ID: <d7806b70-12f2-405f-a875-61137a9c6490@intel.com>
Date:   Mon, 6 Nov 2023 11:15:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Add missing icss_iep_put to
 error path
Content-Language: en-US
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lopes Ivo, Diogo Miguel (T CED IFD-PT)" <diogo.ivo@siemens.com>,
        Nishanth Menon <nm@ti.com>,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <c8081537-f26a-4147-83f3-0c890e824192@siemens.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <c8081537-f26a-4147-83f3-0c890e824192@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fdd307-2379-480d-e29e-08dbdeb15ace
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Ghrvv1I8q4dvgPGZjPy3WBrhnx+Pn+y6b70VFJm99zEFkkV5s31hH3h/0gzsb8N2h+v8DHMJMLuW/18Py43jL7iaafi1UQrLg0rix/Tf8eSqVI0xg8IndZAijUf5YV67PtA+FzoplFg2xaBmq/wVAKIB77UNlwCePcjN52JEIjxoeEkyMKjVmzuysqJyCrNpfqJXD62GZZnlg8m7x7SozuVJo+G2Y6GavdiIeYu+Fw1ExCsc9I3t22ku3DXfxtIAJXvTIXdar9ZuzaxPIGB0uHDULJ1zIV1g4q0jj8JG9U/YL932ccJEskueSgTKJRlxDjk3Ff/emrQmeMVwOaJ4CJe+lBMmO6tZmTOREPqEnuF2RU73x+6MhHe8TxEV4CKmecqFLH/9QHULqWVyIqkTn9HW9FfxvNrj74PzoFvpSVtfJ4yw01h71GZGd10+tCDzGPe7KvMaEezu55lyyQM1OgHm1/50ji72a/E7RcUF+4KAPpw3v1P/WVwOBwuhvHwD2lAfoAIoB0uoUZN5IAsJaTIFVVOMhBhHMi+Cl4Fbdj8ZgqlYtYJYP6DmlHsXStYZ7KAAWsUWcJgM2nAuHR7YSd2zsVmjPVXXkVij0HXLb4ObRrF57PnZvunlwwYGlrQK2wMcgGDj7Q9m4Fw4JbcYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(38100700002)(86362001)(36756003)(31696002)(82960400001)(26005)(6506007)(53546011)(110136005)(8936002)(8676002)(4326008)(6666004)(41300700001)(6512007)(6486002)(478600001)(66556008)(54906003)(66946007)(316002)(44832011)(66476007)(31686004)(7416002)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enNuVXJZTFU1L3pXbzBSbUcvUWZTQWtuMTc5UEZSTm92aXl4NUZRN3NxRWFP?=
 =?utf-8?B?L3hzdjZ0Uzh4T2k3ci84MVFubzVrWk53aTJTbnJhVzVqQmdQZzZYREhCdFNT?=
 =?utf-8?B?QVFvYnRLeXBSci9qU1JwdVQramdrK2R1Y2RUUDBYQWhOT0xxcHhJUVpZeVBG?=
 =?utf-8?B?ZVJibFo5UXZMZmVwbXB2TndGYXNKZHJtaDBkSTVuYnVpWHpuRU1RWGJUZkFO?=
 =?utf-8?B?TDFvWFpUUTVnRGpicTNvNDFFZkFEamh3MExSYnpaZEE4cmNYb0kzM2RHSTJJ?=
 =?utf-8?B?R1U5WGVUZzdCdkF3VEtaRFNVZGV0ZXh2Q0VuZ0lQUEpiQTV1WkcrWGRxbk1C?=
 =?utf-8?B?MnZROUZOZGdYazRhdVN2QWJLMW9BS1B1bEExRUJXZWRrZDU5ZEFRR0lxbmtD?=
 =?utf-8?B?cVE4eCtlcElteHFjYnFobldsSk5lQVdNSThlcUFqWDlxSGR4bDVXTXN1M0xW?=
 =?utf-8?B?NGI1WndTNjBKenVESktLSWlHTzBrQzd5bWYvVGNTa0NQVW92UzN6MEJpYmRQ?=
 =?utf-8?B?eVJqNWN1NlhpSzdrOWU1c2I4UjlNREJkazluQ0hFNUJNMVg4d2ZCUWR1RjdR?=
 =?utf-8?B?SlpuVUltK0JRTEVIVW9ramVybGpFVVhaWkZmZVVhUHFMUDUvTUI4eSt0TkM2?=
 =?utf-8?B?OVZxUklyNGV6WXJtY2VIVms1aTlVd09PQUl5cFV6dHRGLzk2czJDMk80NEY1?=
 =?utf-8?B?R1A2NTVwRUU0MVBvWnJyQTlVaFhUSUtOK1MrZTF1WGU5Y2lGK0RTR1A2SzJY?=
 =?utf-8?B?WjNLQ0Y1ajRkUXVUK0UveGRmRjFxWFZSaHdhaEVEU1pOTUsxWVk4emNaL0J0?=
 =?utf-8?B?S1dqRk9OWGVIejRYWmhENEU1d1J3MG5RMXdCTHFlVnUwdDhRS1VsNWx2d1Rw?=
 =?utf-8?B?dkxnOGk5Y2U0MGpkWUQvOHdTaERZcmRLazF3RGI2TkpVWVRyVVVVUkR2S3hG?=
 =?utf-8?B?Sk1ZdnB1dUV0WDd1VW1FNlVyTG9SNW13clhpQWlXajZOZDY4aThBSFNGM0dh?=
 =?utf-8?B?QjQ5dCtnckNzVUVlU0l3RkljUVBVRjlLSHJKTTdyZjlWYTV1U1B1bVBwSGxI?=
 =?utf-8?B?MUV4cTJRaFRZbmQ0NlJDZzd2VkpITWhaNDFIQTBGeGZnSERod1F2UXd1aU0x?=
 =?utf-8?B?S09najBKcjVoVi8zdVVia2xaWHZYTWUvaFN4UUxYa0p3aU5iRFI5NHRGM1pJ?=
 =?utf-8?B?SWUwcnRUVExVZXdjeFh5V1ZpR0MzNXltN3g0OElKaHNhU1lOSW9rbmdMb3Q3?=
 =?utf-8?B?cElUOWxCK3hSemw2OW5aaFplY2tOZXgwcVZEcjdBcWwzYk9XREkydXFtU0ZX?=
 =?utf-8?B?VHRoenRuT2ozRGVOeFpPbkg0SEh0aXJhbHJsZzhtYjhHR0xmaFA3d2h1NDRR?=
 =?utf-8?B?elRwNGpRZzdyVUVvbWhtWDJYUGVOeGtaVE56RU5HMnRvZ3kyVjJJTE1PZE9n?=
 =?utf-8?B?RGU3WFBHVElTeE55Zng4SkVwM3hKRUlRRllEaS9mZ21RUWorb2s2Um8yejM0?=
 =?utf-8?B?SkdHaEJLWXdYdzc3Um9yOXZzdHlzdEJselExTTRiNzZzSmE4Q21PbWFZZytN?=
 =?utf-8?B?L0JidGRFYm9tMGRFUXUxZGVXaTJHajFnRUNub2ZlQUI1bVpUYmxQZy9aZkxX?=
 =?utf-8?B?NDdaMUtxb01FVjBYdGN5Z2tTWThVZ2wzVjRuZnFocFVIeXhlYkhDZzRrWVBJ?=
 =?utf-8?B?a1dGbnVaeTVvdytZdUZvdmxsRWJpUTRVUjFPNThCeC9QQTJzM3RkYW50a3hW?=
 =?utf-8?B?d2RkMllRMzZjMEJVWi9YdnFrWEJpMU5GLzNGUXNJSXRGNFVsdXRpWGIwMm9C?=
 =?utf-8?B?cGNLejQxUm5wR0l6YWhNdDhZTVp0cGM2WjFOSGFoNVhIWXNFcVFpb3lCYXM1?=
 =?utf-8?B?dkhmNlUxdVYyV1NsNG5sY1RkVzZxTGFwR3B4dWpDeVAwZFZFTmpVVk00TEpT?=
 =?utf-8?B?cWU5VXhKNTVIYUg5K1FiV3hMaDBla0FwSFJuYkpUd0dzZ0h6YVRpMlZVdHJE?=
 =?utf-8?B?UFlpNHdZbk1OWG9ZcFFkQ3N6NWQ0a3hBdDU4bUNsK0o4R211dXE3R041aHVP?=
 =?utf-8?B?RUc3OFEwZVhDSE4yOGhkekQ1YlpjVlBvcHJkYjVFczcwMklQVERaOFFnTVhZ?=
 =?utf-8?B?MjhsbkxvZ1pQMCtHSnQrdWhNajRTUXNYU0tsYkNHb1IxdDBkUE9kaWlJdUNS?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fdd307-2379-480d-e29e-08dbdeb15ace
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 10:15:51.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKQMBmCNhf5WcuHsHaNiPwb375nl4IChu/pXJNNJnUXtIgbxq6RgN3pr+Bu5CP05VDxPRiVeB+0YnQHrmh2n9GZ7vq4zyFgxFvzUzrEg3sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.11.2023 10:51, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Analogously to prueth_remove.
> 
> Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
> Fixes: 443a2367ba3c ("net: ti: icssg-prueth: am65x SR2.0 add 10M full duplex support")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - add proper tags
> 
> This was lost from the TI SDK version while ripping out SR1.0 support - 
> which we are currently restoring for upstream.
> 
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 6c4b64227ac8..d119b2bb8158 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2206,6 +2206,9 @@ static int prueth_probe(struct platform_device *pdev)
>  	if (prueth->pdata.quirk_10m_link_issue)
>  		icss_iep_exit_fw(prueth->iep1);
>  
> +	icss_iep_put(prueth->iep1);
> +	icss_iep_put(prueth->iep0);

We could improve it even more IMO.
If we fail to get prueth->iep0 we go to the free_pool (already done)
If we fail to get prueth->iep1 we should go to something like "put_iep0" which calls icss_iep_put(prueth->iep0);
And in case of exit_iep we can call icss_iep_put(prueth->iep1);

> +
>  free_pool:
>  	gen_pool_free(prueth->sram_pool,
>  		      (unsigned long)prueth->msmcram.va, msmc_ram_size);
