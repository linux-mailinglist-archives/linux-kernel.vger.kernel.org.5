Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E77E25D9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjKFNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:42:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F689BF;
        Mon,  6 Nov 2023 05:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699278128; x=1730814128;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nZSbw9SwhD0oHTHCXkR4p5rUFrx9HSKvvBm/8vGjXQ8=;
  b=Cem3lD5wOv7BFhNtY37XOriJm4hjeVU6zsq3d7tG30fV/11lsJ74PBsQ
   MeyVfBlg4I5lJW/xPUBiWp9rtvNdiRQz/AtDCs1/HviJUvzRAesGBm8sQ
   k3XKpN94KGf60BAVoGPNB8hZMQecs67uOj31l0+h+FCxmwMDEpNAZP6xe
   5DCKEQvNkyBgEP+A/NCAdwrdu3hUQAs0OwZiFdDKNiL+LqOFt2DgJx8dx
   Qi1MPEstWPcGin8oNV7sDYeXmEMj/TKdlxEFs9ljQnNONP2tbZo02sUy4
   AKqZZLcNqBQGejrSIil2kZc2h60dNck3ZapvK/QKpsj002Mx8p0yx7zZu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="420387475"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="420387475"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 05:42:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="832718209"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="832718209"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 05:42:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 05:42:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 05:42:06 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 05:42:06 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 05:42:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2xZPL0NwgYS+FfdTcqOXBp4leVL+6VknLFChd1IIQvkey8wi+HZdZW5wtIOxKdoLURsJCTAjuAJvSjUqqCIa82xpwasWrw7wwk5nq5Y3QMnsvrvOhXGgxW8ICNW7nSOA8Y0NAL5GUPzceiUfHCEGLv6AgSyxvI23a/ogZWxvd22lX0Cqi7+6tM5XIwBjKKNUSIgFy8uLAzW4Z/Rb6s6vr/JQoouL9J52N5LT8Go9J1eQjut2tbJChTyDap8p7zZ9rrOC3DgXuSWvFV2piajDMmeEgYTQmYiDBNyEKlEzSJjQNNJwdxfjuWwnaktzR2OlYu6uP/pniLTNcfR1Fd5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuaviLG0AjPf3lKIfSHhs9ptH/e2LFPYgfU93oKyRYA=;
 b=cCFnwFvsQ+vIF/NuqdGUvhOHrhG71eCm0I1JwgKOwmpETVjAkLDv4s6OAKlIJWExJnfhtf5SztXDwi2wh1ushPlXb1H0DZTOAn/guceox1evut9GxyV7+ZXlkCQNvOMakDnlsMiWoT/+KqYjZNH0jLQcU9aHfA7oUiFrCZTYv2GTVwkL/RbprLTlP8zNHD5jFWAWZbt3N3ah0y8H1+a1BrMdARqM22WmV5+RZyDdcZ0acV2iFEkRnSLG5sakyqMJZneXwaVQWIsT8XpYpYD++NYk+5iqmdwzVzY1/0dhJXX2mdVbjPbkUJIHfeoCa3hh1S0xwWiOjioluJCiNnm6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 13:42:04 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 13:42:03 +0000
Message-ID: <41eff9b4-3041-4a1e-ba28-b16d866cd894@intel.com>
Date:   Mon, 6 Nov 2023 14:39:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 5/20] drivers/iio/imu/adis16475.c:363
 adis16475_set_freq() warn: set_bit() takes a bit number
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
 <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
 <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
 <bf2b6899-fad0-4ac7-a906-e8d361e5a46d@intel.com>
 <e29dc510c78205d87b573e0fe185dc7c7d509310.camel@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <e29dc510c78205d87b573e0fe185dc7c7d509310.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::25) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5560e23f-f5ad-4e32-babf-08dbdece28b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isoBIuXrLWNA9HjUiWzyxKRYmJQbxFYDowKAHDLpH0VERtEaaeDuGa2vcBFptlxKuy62HrfCnJH+63XooS6OYgF4XQWa5bFTTuTZPhFJFJiBSW2ZS5VXnUv9JvzxkMZ7OVP0B5wZQmdb3qkDGJsM099Leet63dHWmjXpoukHIgHEVKN0Qw2AiI7I+vsLclc+BLWjaGW8YTueWVSNLNVQrKkKLvS4HF/HvIyK27baZ1Qk47S04mFSIpnvhLliXlOHtRMco5znRV1KpmiHci65H3oJxsvohYnRalOInvQeFlDIjQiacHRIQ4DdET2HgENcy+FHKYOM9UUkoVEOKu3FCPKuwfXwtS4vEVVD+ba0HgTp3nxs1UQS1AFLe95cdAsgig74KwmSvcjmyWDtIsELEzyDI8MUEhdk60yZtgvFFHGes68cI7kFXpOdV8nAboYd+mhM3+U8v05m734psylSG+At3kH/JLLE7qjWzhWZNoFvAWnHVB5RExSaIfn17HBa2e1w0b+zXikHJD2PKLj0sfP60k1feTl06f82hLpUsUCyop3H+3xDaRjpjAzF/m0Yb9NkcPZZPj1S25KRSQpFRQjX1oSQkwjil/y4VPjcveW9DqFNPug93QyDM+gqSC5pCslD1V2sLsOOsAWdPD8SKQxi8gxq1ssi3ObzmbNn/oBH5QpQudeLPkDoUw1MRUhm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799009)(64100799003)(451199024)(83380400001)(316002)(38100700002)(82960400001)(110136005)(478600001)(6486002)(6666004)(6506007)(54906003)(26005)(66556008)(66476007)(6512007)(66946007)(2616005)(5660300002)(2906002)(8676002)(36756003)(4326008)(31696002)(41300700001)(86362001)(8936002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFvZXE2M0Z4RDJrN2RVNUZCL09ZQTdNTi81R1V6VEt4aUNqZE1GK1F4Tlkr?=
 =?utf-8?B?UzBpZExzR3BaU1pUYit4VkNhVTNZZHJlTDhxOSt0bHVUNzhCL2d0WlhFS3h1?=
 =?utf-8?B?alRSSFVYV2VET09MUlREaldneFRCclVPREc1M3dtMlNyK09oWHQwc3F2cmNh?=
 =?utf-8?B?WmVNTTJTcFRhellMMk13STllNDZ5bVJhY1p4OU5uTDZEK2Nta05LVGdBUnc4?=
 =?utf-8?B?MGdSM2JHRmR2QjlkMDBLUXlZWFplVjk3YzVYd2c0V1JpVlFlTmF0RDlEVENv?=
 =?utf-8?B?cjVHWGpRYXpQY2orN0xLaG1SRkNLRWM5ZEJJRk9rditTenNtZmRld3pNand5?=
 =?utf-8?B?c1NWVnZvejBCdDVHMlRZRUxPRmdJZTlqOVEzMGppUHBxZ3FRc25NMWp1MUpn?=
 =?utf-8?B?K0Y5U1RjUmdmeHdJSWxlTjVycGhLVGRCVFU1SlVKQ00yTXhvWnFFRjRJQU5q?=
 =?utf-8?B?Y1BRdDNDM2Q4SmRld2FwZTZoM2MraGVleGNFQldKemlzb083M01Ld3EzK0VX?=
 =?utf-8?B?YXZhdWJUVWZ1MmJVS3IrK0lYMnlSdVBpb2Z1SkFBU3VoUGZrc3Y0WW5yT0pM?=
 =?utf-8?B?MGZ1V2thRFJEYlo0QnBLZGpXQjh1Y04xTmJsQzZCTVZDT05uR1QwekZhV0ZE?=
 =?utf-8?B?QkZ2UkJKa2JteDg5R09XRE5SNXBtaXZOV2VFWmlQRXR0cVc0S1FhWXI0N3hX?=
 =?utf-8?B?THZ0YWxObFowZkpZcHY4V2lpaWkzTGdzSWxSSWJsZERuckVZUFR4MUdwRVJy?=
 =?utf-8?B?WUE2bFlETjFuUkRKRVpEaWtuUEthdWNLUUg4YVo3V0I0MjlpVTBjVGxqTFh3?=
 =?utf-8?B?UDR1VmdWSHZXK1Q1MG9wSXpxVnRJVTBnZTR3QnQyMy9OQ1NyN0VObWFkYXQx?=
 =?utf-8?B?RXFPWGFsa2d6NjJ4NSsyQnBXSkN0TndPVEdDV2Fra0l2Nm93ek5Oblk0cFVs?=
 =?utf-8?B?T1NzMHZnUEtsYUhTSlFhTGN2Ylgxc2dsQXJlN0g4SkR0Mng2N2VjMmZDVzVU?=
 =?utf-8?B?UmxXdlZxSEplRk9VNittdmh3eDBzQ0FsMWJMdVFoOStYdVp0MHBGMEdUeGNl?=
 =?utf-8?B?WXI5WE1pU20rRlpzZVdKQXFuSjE2M2tLZkp3NFhFTVFMNmU0VUVEZHB0OHh2?=
 =?utf-8?B?c1dhejhMMTFxVGxPMUNGRStBRlF5T3hJeXhseVFwQ1JhbGx6QnZoeklrM1Nq?=
 =?utf-8?B?dXhTa09jTlArK0JFQ3R2aWlnb2Z6cXBpYTloYUFHRlQvTEhlRnk1bWNUV2pp?=
 =?utf-8?B?M2ozVGRXd01mZERDRlZZaE9rOG9USVhMaFNEZ2QxRTN3RG5WbFZMdE5UeHZP?=
 =?utf-8?B?cDRKUjUwL3loeHRvYURwQnVCZTJqeDhmZ0FlS1ZtNGkrMWJBQWgvdjZ3bFNu?=
 =?utf-8?B?YVBkQWN6bG1hUDFPV3FlblZRaHNqSHkwRmo0YWQrK3B3VkFUaVRBSlIrTEUx?=
 =?utf-8?B?VElQNnh1blBLbFJCT05LdzU0MHdLTHZ1dkt1SU9zQk1wVW1XTDJaL0x4U1lx?=
 =?utf-8?B?R3BTU2xvVVVrMHJISVVCT3dYamF2QUxmTjBaRGhMMklubVVmdnBQOUYvTVR3?=
 =?utf-8?B?R0MvYk4xajk1OG9ESEd1NTRBNzVBVGtGZ2hrcGdCRGVrNlcyN0kyYTlDZWJl?=
 =?utf-8?B?VzBKNFJtMnJ3T1JoUDdOK1pqWHFBMzdDL2Jyb3ZWMDQweHIyNk05ejZJUG83?=
 =?utf-8?B?QTlLQkpnaTBrb1lHMnhyL3ZRWVFxQ3VwN3U3U0lZVWFkdmtxVSt2TUlSTVZF?=
 =?utf-8?B?d2pRRmhDb09RYTV6dXBDbi9yNy96M0VpWVQvd3pZZlNZMlYwdGlwS1hkYlFr?=
 =?utf-8?B?dGljTUxZbTNldWMvQ2UyUW4zY2NLbXF4YTRZWGtNd2d4YWdza1lySEYxV2tx?=
 =?utf-8?B?VGF3QTFyVVlQeDJyb2wzNHNUMUxQWnUzS2NEL1dqUmF5RTJXQjRhajJsWW9I?=
 =?utf-8?B?NWo2NmJEUE9TdGg3NkU0L0svT3ZQeDZWMElpMGZiUGFnSEY4S0ZQR0cwd2VP?=
 =?utf-8?B?NjEvejFldWJpakh6YkJMdDVxS3I3NkZNRkFTbmNFbk9VWmJFaHY3ci9pWVVl?=
 =?utf-8?B?emJDOERBVFd1empYb1F2Yy96d2VYanlxdGt6R0R0b1cxczFjdVc0QmFnZm5V?=
 =?utf-8?B?ZEhIYmx5TnFXVDZ5NlY3SFpPY3RYRWdwcnFvK0VFaW83SUQzVW85TnBQMzhq?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560e23f-f5ad-4e32-babf-08dbdece28b4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 13:42:03.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lJ9Tm4ZFEK+zQWsZYtgzLLJFOrofj8QVU1jo0pxy7A6vqAhOQc0QrOV+OPbNfnlRHBSrwn9t1c+tH/1rJRj0FSrPiYYSMwD9Tom+eRRCFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sá <noname.nuno@gmail.com>
Date: Mon, 06 Nov 2023 13:02:58 +0100

> On Mon, 2023-11-06 at 12:18 +0100, Alexander Lobakin wrote:
>> From: Nuno Sá <noname.nuno@gmail.com>
>> Date: Mon, 06 Nov 2023 11:07:16 +0100

[...]

>> assign_bit() does not take a bitmask as a first argument, but a bit number.
>>
>> I.e. if you want to switch BIT(0), you call it like assign_bit(0, ...),
>> not assign_bit(BIT(0), ...). Same for the bit nr 1.
>>
> 
> Yes, I know... if you look at my reply to Dan you can see I realized that already :) 

Oh okay :)

> 
> I guess by the time I first sent this time I didn't knew or maybe just a dumb
> mistake...
> 
> I'll send a patch later today removing the BIT() from the #define, thx!

Nice! Don't forget the tags the build bot asked for :p

BTW, I believe the reason why this warning triggered after my commit is
that before it, assign_bit() is a static inline, but becomes a macro
then. smatch becomes able to see through it that it indeed is a wrapper
around set_bit()/clear_bit() and realizes the first argument is invalid.

> 
> - Nuno Sá
> 

Thanks,
Olek
