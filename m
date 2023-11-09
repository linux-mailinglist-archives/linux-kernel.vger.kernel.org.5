Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82D57E7083
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjKIRli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbjKIRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:41:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2A92
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551694; x=1731087694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYJkQoJqPLkXNqpN3l+Pi9Nx4LB5kxPoDG8Y/Ctpkqg=;
  b=PaVHrXXhIq8XCppaYSzxWnLDhzW7Em43P9WWSO707XHHIi12V+rYJHiU
   nTNct2cEKL+snBhx5HIZ8H4tbGiPGTrCxesTdNUkDwXOeiHQd9lNGzSFa
   ZoowtREG+CYN0wcT6Fp55MCEvdkWgDqFoyEEg25bYvNf/9dEozp+i0PZL
   oi9KXvHMcBJ3AxK/Ngb+HKtrgoyqM7DMKegzXPHFgCpg6bM4Ot7n4hgqg
   R3ERi20DzVjjAn55WS7VK+he32NdxzOxL/n2PP7/QQ3UL/zRQ+Wg2D1Cb
   bdpteKywtEwjVcsNxBoXvwR66uFXQZsxJrSW7QjOTOLPHLIxQelDM9Lwm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="388895312"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="388895312"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:41:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010695468"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="1010695468"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:41:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:41:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:41:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:41:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pj9jyacLFqt7TffgzNXZ3vBf+jZ1WGJ8iv7syFefEjbLy6xVkMOfNBrlhE9PrPollPLtgyBK14+Xs2329kRHMzjX85R81g97xVPmR8HblNL/3KCxPqi+EZE0KypsenxeW6hy4fb0bTNdP0IsFE79oXSSEUdaQxcF6l4fpUHgFp7OV/5nujMJQ64pnA3e7OXyq4obpv4PAll6baQ0jb5qmWl1xrFls1BRUzpRVimAjBJ/ul8WZg+yIcifhVdGeg1GY0rPFi1r1FXpvEa0pTFRcUMOOVW20U2eFz1I3sHE6byouH+eB6lBunDHgTpP3F+AUAKbOPhTvdEJ4Hyv35qxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koZXVCUkig0lWN0jEajyxc5ZhytNJ8rbELpQTntXaDk=;
 b=NiKSf0pnqqU0n52faecb15fgrLWObpgibXXD1V6OuzCq9a2nK+L3AQYEy9+nzO6CtvhhgnbWOqOyYUzGEv0Eqqs4PCrMGFs+zzVlg9cF3JzfGCTG5szU6Dj5CBhX9XK0x7Pa7zKGcxQ92CPhaE9AUtnq72TBd2Vn/o4uYWuBDgHa+pz+fhGbWPfcdJFYyibdnpd/ffjb979HVmKb1Ms3Sj/NxbUXs9jrsMyO1TChVEFRA190goXsom8yEEXROlkTsqnPVA5uRKfpKCL1bVPNGAi1/fTNKISbimPUx3dAin3L1VQ4Z5akbcyW/+xkHBfpBX+YwDjdqZZWJ6A9WW2qMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:41:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:41:31 +0000
Message-ID: <c4e18e30-1898-471e-8065-ebb85d654084@intel.com>
Date:   Thu, 9 Nov 2023 09:41:29 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/24] x86/resctrl: Track the closid with the rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2426dd83-69d7-4f8d-2c7c-08dbe14b1bbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ki65x9Ys+dotNjMszRm5PQsCQUmUkfeltMBPjM6bdGkE+FLiWf0p+R7Qilo0Mgt1Xv4uermJu/S/XtxdB2DLUI9ZNNrUiSLTExbBkyuKK4P3tRUbj1a0hKq26GBBmvqSw7Wwvp0GmebGW/m+AldbOn8CCHlZhnVYdKyj8yeiw0d80877/NjmzXJz/B/L/oPasabC6jP1ZHziQKMsRBqeZVR3MTQs3TbPYOhMYm0H5cg+m3ERZNP5VmRvt7LKhkZsDQ8rdkJHM9uL9LHhW7mmx8Yg5EPjewTnRAfrBPkfn6ja1bp5yeAb3sOdlWP+oPP1eYVZWUC0l0yhxRncGcvMjxw1gYkKNawvHFjwloyDtjacJ/v9NwHFU6WkwTVKjVRZawqzRxH6eJprtxTdqasOLYpnZroXfX4pOUY0gP7wyhz5777S6MT51T1F79jK6u/EattYPutMhm8kI3efbOKS5MovduaGBJ/NnFdbkxNVikT5GLPmJww5M54du8qKKRHS/+e47g5tVqXyLdVLy5PoomnElzcHOMY88kZ9YgkrPosn4Dt4orgDl00LxVWbkmv2ZgTo72atmeijB1RX5V9QWO1jHqC+f/PmVdV/CWscOxC3mqcyHyHE0osvz5CdUPnA2uDchCiSVePtmuyxvPXgSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(82960400001)(38100700002)(5660300002)(31696002)(2616005)(6486002)(478600001)(53546011)(6512007)(6506007)(31686004)(36756003)(316002)(8936002)(66476007)(66946007)(66556008)(54906003)(8676002)(4326008)(86362001)(7416002)(4744005)(44832011)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUxBZmE3UUlCR3VISTJtT1d0c0VZa1JlV0JXQlF6Q2lsM0syaWREanhFd3pV?=
 =?utf-8?B?c3VTbGNIdWtiOXBOcVBtYUY5U2phMjlXTHdHRWRYWVV6QTZmaTFodDVaWXpm?=
 =?utf-8?B?S1hMQS9UcHNNbmI4N2UrSFlSMm41czFHS2d0VzZqUFpJWksyTW5wNG9vQ2hy?=
 =?utf-8?B?SGJqUnZNTDdMWlI4WUo2OS9pSVlHMnBRQTV2bGtUMzE4dzR6S1hFc1Z1a3NY?=
 =?utf-8?B?VDRXTGNRMzM3U3pFMEs3TXpzMmxWdHdXTkZSaG1rZ0hTb0ZJWHF5Y0V5QVZK?=
 =?utf-8?B?M2VRZGcrSnRUK2xNTTVJaGNsaDg1NnE0dmdFcU15NUUvZ3F3NGsxODFsMS9x?=
 =?utf-8?B?ZkVZVmRhU1dCdUdxLzl2UGVVa2d4eXY5eU5BUGZBUTlYeE9SS2tSZ2R4SmlT?=
 =?utf-8?B?TGRkaUFuV1ViOGtHWktpVWpacFAxNkRCK2s4c2QrRXJDNHY5N1IxcmZRcFdk?=
 =?utf-8?B?U0FjM2hxbHZ1YUlrczRCTEM2YktHTlBMUlVCRFVxQmxnb2VKQ2lPVlNXemhp?=
 =?utf-8?B?VUR2VEozVGlWa0UwUDlBbzl0VjdFdVdKVFVQVG91L1pRVEl6L25OZnBNYXlL?=
 =?utf-8?B?eGwrUXVUR0RjL0R3WVdXeU5ZUmk4WUw0T2pSajRROXk2U3FsclpCUUd5Z2VH?=
 =?utf-8?B?alh3akIwYUtpVVBMc3d2d01OOVN0eUFlRkxSdUpQNjVxRTlQWHRhS3NEU2VR?=
 =?utf-8?B?WGlqVC9lMzA5VUQrYU1oVmZUOVpJUTJtTmthdDFwUFU0TnJQNTdzb2lMd1dm?=
 =?utf-8?B?R2tVeU9qVDRySmNyOHRyUDQ3WVB4cC9pWWRTQUxEaHJ3MUw2NlpnZmJsN2J3?=
 =?utf-8?B?dW5iV3hIcW0xQnN2K2pqdHhnMnZsVElsUDJ4VDNSR0hXSEM3VUpFcVNuMFVo?=
 =?utf-8?B?aTB4K1RGYWxoNTBsdEhXT0J6RkFvTWdsWXRDZjRqWktOemJIUk95ZCtUcEdN?=
 =?utf-8?B?bXFmc0hVcVR4RytYWHJraEE3MlJGdDlML1JtVUpFYlZsU0JrQXdmV2ZPelZ6?=
 =?utf-8?B?dXRGcVd5eE9NaXl2ajArTWlObkZFTE1Sek9VNitkNmVER2NKMHRPOHJ1bWRW?=
 =?utf-8?B?WHlmbWRFKzZMcXRoUmNiYmU5YjBrMnJoTERoa21tcG0xSER0S2FaT2Rpa1pK?=
 =?utf-8?B?REJvZERZRVJMTVlqb1Bqa25ydGlMYnpuUnhNcDhuclV1c280eFlCOStkanF0?=
 =?utf-8?B?UGZjVXIrRXZWNGU2SG9VYmtoOFBrZVBBNEZTNzQyRGFmaExVS1ZjMFZBUElX?=
 =?utf-8?B?QlNZQzFtNFE5bHZLTW1RcUdKWkswQVZtY0RTdjJBZEpOc3UxRHV2ZmhkVW5C?=
 =?utf-8?B?clQwTG1YbklmNjdzYjBPVTVwaXUxZ1VQWlVFQlk5UjArWWhvWDlPcE1ZaURY?=
 =?utf-8?B?ZzVyOFJuQjZVQTl4ajFLY09TZUc1WVVWZWtFMzJpcTkxS1M2blpYeUgwOG42?=
 =?utf-8?B?S0JaaEovejV0b3lnTjhRaFk3V3RDRGRKVVFzUTdNNElUSUVyUFc0akttQmVJ?=
 =?utf-8?B?UE5kamJCSXRPUVhNRS91d1BHTFlZRmRrS1FyaGpzZU5KOUZzVWlQTyt1VjIx?=
 =?utf-8?B?ZS90alJ2YWlIR0NrUzQxSkZTVXFWMlp1b3pZMTBWa0Q5UUlUalk4TE81NWpS?=
 =?utf-8?B?MWVibUl3cVdMdGNpNVptYWYzbFhoRDlXcXpjZ01mWlJBWFRpUlhRVWpRSGtu?=
 =?utf-8?B?NU1YR2h6NHdFeWlZU2htSTZaU3J4c0piaXlUM2plNXRyVUV5aldVanovUDBO?=
 =?utf-8?B?VTJsR1BhSCtDRkNBc3hBNTNZY0lmU0RnNTlueFlnc1lvV2toa0R0UnZ3Rnlh?=
 =?utf-8?B?MnhHSUJCcHUyZlJCUytSczlqZ0pmSHU2a3htblRTRjh6Z3BnVzRUYnBnMFVE?=
 =?utf-8?B?SlVKY0pReGtKMnNxbkt4Z3NnbFV1QXdjdGptMXNEYURPSmJlclNyMWtkbS9Q?=
 =?utf-8?B?SHFzZmVGcjFnNGZlVVk1WGl6bTNwb3BnMUVvTU5iaFhGaFg1YklYRDF5OTcv?=
 =?utf-8?B?VGQ4alBjNUJ2cW9DcFIzKytrdXB5SjgwNmhjUDFZVFBZdXlJWWdOdnJxSE45?=
 =?utf-8?B?VmdoMVZhZGRjek9vbjRKU1I4aW45RTJrUFg4N0FDQVNlcUF0SzhQeEIxNHNF?=
 =?utf-8?B?OHZTNkdFdVVnVUIrcFZlTEFHcHFrb1MzMjNzekxUSnlzNG1BRHlDWFQyOEZC?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2426dd83-69d7-4f8d-2c7c-08dbe14b1bbd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:41:30.9168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AydDUivBag9E0kWVkWqGwxTjvoTqCRUS0gTD5PxhiNaEVxpZTMTvhofvl6eIUbiyBg9bGseGvQm3PH2MzAq7BPDxZAK8F3OPvH//70lZC9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> @@ -732,10 +752,10 @@ static int dom_data_init(struct rdt_resource *r)
>  	}
>  
>  	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> -	 */
> -	entry = __rmid_entry(0);
> +	* These are used for rdtgroup_default control group, which will be
> +	* setup later in rdtgroup_init().

This sentence I provided was intended to just replace two sentences, not the
entire paragraph you had. Note that I explicitly stated "change last two
sentences". Without the original text the above "These" is not clear.
If you just want to copy&paste here is the entire intended comment:

	RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
	are always allocated. These are used for the rdtgroup_default
	control group, which will be setup later in rdtgroup_init().

Reinette
