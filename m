Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7245175427D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjGNSU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjGNSU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:20:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1856109;
        Fri, 14 Jul 2023 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689358813; x=1720894813;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgUTd+4cc5vI7IljcLFWcuXVfqFdMP9Hq/NfGX5iXT0=;
  b=btFaLCBiMYg2EKg0VDHfUE/rBNy4FA3CiWvrcKK3rpwQq3tHYbvqcnP5
   xn4lMycBz9cBSIclbyjhZmsJ4HtUY3DFG1Pd8MGCFg4FitiRyOaIMmE/N
   gsZzRuxZBkiPrxQMhyn1RqUI6VZInZr+UKB38t+gka6npVLGi74oBrGJi
   pWxv6AZwPn3uoCTqAPkhIracEnC3CbGZS3+UVbXeXDwAvNRNIdNMZd5wd
   WXEOqvoEZ8EuCR5NfiwZdycwnI/PVgLRMV99UnuTQH5DUGxqkUoogR84C
   DHbzsdoC0fWFrBrknSXPRavEekwQ20yqhQXjA8+DBBjuzmKFsOoK8D1RS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345854381"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="345854381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 11:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="757628637"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="757628637"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2023 11:20:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 11:20:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 11:20:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 11:20:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 11:20:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WllYtMRPm2m+43xs++uLmzJOLqSurWTOKWPnutrxcrw/yhendn6htiYPBkv8+iFG4pJsYFCaEpxmfw+EmZ8PoJ3ZA5XN5TqH4iZbDfBjejS631lkH5D8PlvPHFZgJbZ1K0CnlcPo+iE6luinjkY2Oiqc7GjRaDq7vt2+wNJgdhq+B8FqiXobEMxJFok/fhb+kipN6GO254Lv6ANSfTWZ5tRylF5r3ehBlmLHBQ19MZzBa4X3CM6X6C7I5JcSFx/JGXwTB144M48sYi7y2tVtrhBkKv5plStSa+mlrvMl4X94pgt0Vufqh/gcx4ReBtEld0GJV3G/Kx9rgszXxKAZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6js34PYOJEHZFP/iQaOK9/KS6nwNtSvIkklUyw0dlzc=;
 b=OdrHppU62N9w8Onp5F1D/uksNI/ngqaeJuIDNq7s4dFMFlVmVA8m91mNJ9LvessY9TY7r0FutqqbU4E2lY/Lg2Cn45IsnV5quYZkmUnndFV8jFM71ICqZ9qo5WgQsg0/ImrW/48KRo9PtNnytbP+7Va3mVzg2m/rV04hP7mn0NJowbfSYDE3Ag9smEFfBysrLPWBonyr/a+OuVGad97tUdoU7J+GHQ0wljMBPfSBgOZtWaE0q6w5mNFEVHB2bDc13MB19omR/lM5DMtA+BVMLr8MJsQUuODZpmjXLXDQFg1VWdq/1jXmfqouDz6R/sulN2UoqupeuFa8Nmjhhj2MWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by DS0PR11MB7213.namprd11.prod.outlook.com (2603:10b6:8:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 18:20:00 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8bf3:72a2:a948:8a65]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::8bf3:72a2:a948:8a65%4]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 18:20:00 +0000
Message-ID: <71f62e49-3f2f-a8bf-2347-061902d39f7e@intel.com>
Date:   Fri, 14 Jul 2023 20:19:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: build failure after merge of the pm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20230714110051.4575ffbe@canb.auug.org.au>
From:   "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
In-Reply-To: <20230714110051.4575ffbe@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::16) To MW5PR11MB5810.namprd11.prod.outlook.com
 (2603:10b6:303:192::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5810:EE_|DS0PR11MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 71df92ac-a4d8-421c-684a-08db8496ef84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: keJGAY3I1UYmU4IdL7SKQeFv+/cewfbhUpX0WLNw/kS3BcABnie+f4ZnXjWeeRYtIV1m1SOyBR9HpG70wcQrJcvPwzAS8FuNBvxxOngwH3rzWjXOUsN2V/A0+naXxR9Zb1Oh/EMbP60v//916PpU5MY8dkR8g55KYVnC7pg0E7wptGz/+VTb7RBCc+LAcjK4qYvpzT9cO5kg88STwemsJumzps2cZ/fS3KjsBJZVUFokeN/hULXhHFFSauo2VC3UUADleMJeVZaP0vx386EuLA+4M6B7Dp5Xult+H7dOVdvDCSJ+QMjjwbHrLotM1rVwrRlQkGgUOvFR6+g8Z30w+XINgzaGJMx5eRTwwn8S7vCbbymJyf1sB+lN1Afi6QjULMNCI5dOVHLhs3tGBu6xkNxClTMeKJjnIaPhYQhqdM8KHPyhJbFlYuxr51uzIOtVvYlG2SrSZc7bKwfyqbGPVNDt+8tgKdO7cdjYdTbSPKGpaH/9ETgkMEuHojv+8leIcVEOst1C6KuDfjhjs5XZrPIt1ftXe1DREYST4B/z3MoBilzHJ//J9E70D074R3yvbRZd/zFI2xw5UH+a+aNOac9F4NaxHQOQfC4DKGR7u+CBhCRK7olwxWaoLByoEdy0DHfkgAFuNMOqfzh3TrmpOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199021)(82960400001)(478600001)(53546011)(6506007)(26005)(6512007)(6486002)(6666004)(8676002)(8936002)(83380400001)(5660300002)(316002)(2616005)(41300700001)(31696002)(86362001)(2906002)(4744005)(31686004)(186003)(38100700002)(66556008)(66476007)(36756003)(66946007)(4326008)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW0vaGZRcjNvT0VTbUtoL1U3QmY3NE9wcFVvL1dRNmNpY2hJZ1ZvQ3o5bFVN?=
 =?utf-8?B?TFUwcHd3ZWEyRU92dUlFcGFGVXJ5RVAyK1hLRVV4aUxaWDVGSHNjZkYrNHRi?=
 =?utf-8?B?SnFUOFFPbUVHcXc3RkZkdnBna2dXT3dpSGduMTdhM0tsUzBxRlhFME1ya09t?=
 =?utf-8?B?MStVU2IrZDJwSHI0S3NkTXQ3WEVSSFhSaUpDV0x0OExUaXlJaUMzNGR0MEN2?=
 =?utf-8?B?UkpWc3pBOC9FY012czQ1YmNEaDlwamNwZllmcnRFUGFUNW1ZNW1WaTltNWty?=
 =?utf-8?B?Uy84VjFJdTlvcnpQdWdOQnRuSFJLUUZxNXFDN0c2QXQrR3MxYy9tOHlITlBS?=
 =?utf-8?B?SmRhRVFSSi9MWS9WUEg4UUZHMzhUZ3M1REJMRFIzVTRrSktHaFBQVTVDRDM3?=
 =?utf-8?B?aEdFNjZQeWtscnVtQk1jQTBjZGxhc1RKbGR4N1ptL0ExeUNlMDEvUXFUTnVN?=
 =?utf-8?B?cWNZVXBoeFpHZTk0UlJhaHhsVGdoY0dCbWp6STRFdjlSUmt3SXcva3BqYzAy?=
 =?utf-8?B?bEtrWWprdHd4dXVCNlM3Y3NPUVV0b3ZDQzl3WlJvTFdlZDJtVVRWTUpjRnJH?=
 =?utf-8?B?bUdsZWlhOEFOakFQdGVZbzcvZ3RlbkVxeldnNXZIV0tpSC9JZ0JhUHpCSXdS?=
 =?utf-8?B?WVlLNStlM245dHlBN1VuVG9CbW5UZzN2NzRZRENUemcyNUJQU2VJMFpyZjFq?=
 =?utf-8?B?enRUTGNJQWVyOGVYbU5rN2drQ3VuWXBIZjVhUm5oR1RoK21IOVRycTRnK1hX?=
 =?utf-8?B?emhzRllqUlEyN1Vib0ZicmpWZmZDaDlKQTI5S2NkemUySCs5cFlnOUxIUWFC?=
 =?utf-8?B?WFpJQitCRXJCL2RRMUtpSjJTZENLY3NaYnJ3ZmdneVpkRUJxbm9YQ2VoY1R5?=
 =?utf-8?B?NzZONmVHL1puTVNEbW9jMGV4cm9ySEMwVzNQb3dyZ2doVzlkSG5BaUJKcnNO?=
 =?utf-8?B?cFh3eFNvOG8yU0Vab2k0Y2FqV1dsd29WTGY3TTMrMktoVVN5cS8ydGpVWXFL?=
 =?utf-8?B?bkpKUXVrSzNlYVZSWTM1UmFySU5vdjZNaklTbUhTVCtoOHJYSXZPQkxkU0dN?=
 =?utf-8?B?em9uRlNiR0wwVUJQbnJXSFdpRlk0NFFhMTlOdlNNRVNyNVBxbjNSMmZZS1hX?=
 =?utf-8?B?d3BuUEcwWUhkcVN6dFVkTlltWVVwTFJ0WjJ0RUJkLzRPOVg2c0U5NGE0UGxZ?=
 =?utf-8?B?aU5vemxFUUdNeXU4SWhORXZFak1ScFRlaFZUZHp1ZjIySy9BTXlLRDJSL3ZG?=
 =?utf-8?B?TExjeGdobmxHaXliSGpHVkpOTWhRM0tuN1RrRVZMMXRYUXlOaGZaSml4TUZl?=
 =?utf-8?B?ZHRSZnZMWWx6SlZqSXdGc3MyUENQS29EaHRwWGNqblhRN1NTOWlLQmFQdCs2?=
 =?utf-8?B?cnJtOGpTbXh4YjFsVHQwajg2alVybnlxR2gyTTFTZldlMzA4a2RlbDdnQUtZ?=
 =?utf-8?B?K1hUMzBhRm9vWDdBREpnd2Z5eWtnVHVHTEd3d1V5eTdRcnFadWRsQ3l2azBn?=
 =?utf-8?B?Z3RLNXk5MFR5STM0cXFWd0RObndXS1pSVGFRQ00reWp2M2J5WmxTelc3dW9V?=
 =?utf-8?B?RXJxcjM1R2xsczRFODhORlJoWUQ5ZkFpUDZBcFpJdWtoYTZ2eXRQYlBKczIv?=
 =?utf-8?B?VzJwWjFoWjlwYXFFcG9GL2c5bzFvZGQ2eEdNYzFDakpxQjR3aDBzSzg3enFJ?=
 =?utf-8?B?aW1oRVJoQWl1VkxxK09ueXMydElsdFljQWN0SlI4eDhwQ294UUhlcDkyOU00?=
 =?utf-8?B?bEZRUmRFMDVHTHhFYnVJaFU1N0o4Q1B1WWM0L1pQUFAzODMvRXJQaWpBeWQ0?=
 =?utf-8?B?c1pnc2o4TFZmMmUydXRJd0VmWVVNUkVnZ0l3YVl1eFlmQThzbmNMMlFuQStr?=
 =?utf-8?B?bXBzb09PS0tvS0Nqd3owYWJONkFWalVvd2tjVVVna2p1bHFma0ljdFU3Zi9D?=
 =?utf-8?B?b0dmTHVnOU9OT1RWYVFhZ3hBRVMzOVpkdThSR0wrOTFPS1VJRnFhdVdTNWVm?=
 =?utf-8?B?azdxaVZodEJDNjZ3STFmbjhmT0tCVFZtazNYM2VnOWdtK21aQ2ZEZk9sTmIy?=
 =?utf-8?B?VndubnMzdC9LbGtkSTlDY0tCTHJWSS9UUzBmaWxCZVBDcDZCZ1FuaFRPdW5Q?=
 =?utf-8?B?cjRjT1Y4dVIrU2dBYjQzSmEzVndCQ0s3SHNvVkdhT0Y2OWxJTmMxSVdMampC?=
 =?utf-8?B?Y0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df92ac-a4d8-421c-684a-08db8496ef84
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 18:20:00.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXIjMjyfo2f2xgLYH8hMa4LeU312r7OUZAX6bLzzzG+TTHi2brn39Y8NPndZCuPd/crHdajkmzwq0mjimm8GIir98xvA71QnyfFHkVk8Ewc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 7/14/2023 3:00 AM, Stephen Rothwell wrote:
> Hi all,
>
> After merging the pm tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> In file included from drivers/thermal/tegra/soctherm.c:36:
> drivers/thermal/tegra/../thermal_core.h:18:2: error: #warning This header can only be included by the thermal core code [-Werror-cpp]
>     18 | #warning This header can only be included by the thermal core code
>        |  ^~~~~~~
>
> Introduced by commit
>
>    bc1bb350b534 ("thermal/core: Hardening the self-encapsulation")

I'll drop this patch.  I think that the rest of the series doesn't 
really depend on it.


> I have used the pm tree from next-20230713 for today.

Thanks!


