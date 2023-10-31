Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6027DC9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjJaJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjJaJr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:47:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D448FD8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698745673; x=1730281673;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0KvKdZL3nMkLOaVVzy2J5qOzwJcQ6uAnXGpOcGBptk=;
  b=c8koGfrx9Dup91zy+naer2vLbcs9NXVjYnQunOc1+RGnRBX2EwBM1I28
   YjzWwBBabL6V7ohQdocjyvm8WS8wmHX0kohC9x4RyLu9l78jLcy/Sklmb
   lqYsRJj2XXI3m48HCQjiKZLn5z7eYThqhdrFbOg6FsasSyxdTs5pjMBkg
   +xvI3NmQ+4s7Gv882K4WWUmYUE0bKkbb3RSldBojOaW2ywN71KMu72oZl
   3ZN0tNeyVetO/I6LLyiK0VzVzrPY1K4TQMtHDF7K+hgpA+sFS0OAeVeVb
   bGx8X1c1BIvMiK7zltNjL2shAEoTUcomX2jcSef1YaG+NX900usJ8ZVYq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419363905"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="419363905"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 02:47:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877451511"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="877451511"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2023 02:47:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 31 Oct 2023 02:47:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 31 Oct 2023 02:47:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 31 Oct 2023 02:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GziCnBPFXcyIj7pq3nfkVgDi1Sl0pvwtC5VrxkLuYSQQ78cmCX273y7INCkaPfgkI1rjn/YWK78xALIQBqlfx3fmtFY6TfP8U3Jm/M84LW9cx3vXd09l6w4gtRe56EeqN3FfQ4clFQAXp9NRZPANJKnv5CRSi2JifLhYTP3dcwPwWONOaPW2V6NV6jDlMl+odKtVqMRlQ+XfXl0ozBjP+PqjHiUHIgXI6lPmtPkNNLEfSd2U0B6cySoFj6O+F52C0bMtRh0ugBQzaXPK7KN0tozL9S/HtwoaSES15QAFjVtqAN2nfCwmkMGULrrAkscVaNOcRGmB3h2IyGiwbQTm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VY9lDLbFHgPm2/pj5kSYYFLpwxAHFUdkuh88Bq1JiE=;
 b=VM5CJlRgKDIMD9P3Q4usa6RWMAj0l0KRS9wAlHihkydBMgOoUgKZWEW7S8iPPH1aGaxBV28ZmRrAnkF/bqTbT4XmSId8A8La8vRWszzmikXSJUZ3eecex9ZoYL8FVCDy+rrhNit8fsRJBOM2Ejfn80MziOL/Yngagx61wFsa+Pb4iH/i3HznH8+mS2FFFExiK2HgrdUR2xmhPP4wT9AaG/JQxG6FX1Is7wHfPK8DtVtRncJS5dUPL7/4k7JssxZNQq/or6y9hefevUOgxhk463FgWxsR9b77QohRrnk3iLrair5shA+oy64V6P0foQh7E6mDvQSKnHBBI5b9kUha/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DS0PR11MB7850.namprd11.prod.outlook.com (2603:10b6:8:fe::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Tue, 31 Oct 2023 09:47:51 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019%3]) with mapi id 15.20.6933.026; Tue, 31 Oct 2023
 09:47:51 +0000
Message-ID: <9f8acb47-a951-53e8-5bf7-738970184733@intel.com>
Date:   Tue, 31 Oct 2023 10:47:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] ALSA: hda: intel-dsp-cfg: Use AVS driver on
 SKL/KBL/APL Chromebooks
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>,
        Brady Norander <bradynorander@gmail.com>
CC:     Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <2f5ffc3b-01be-413d-843e-8654d953f56f@gmail.com>
 <87bkcfw6y8.wl-tiwai@suse.de>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <87bkcfw6y8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0021.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::29) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|DS0PR11MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: e4837ae3-21cf-4a9b-581c-08dbd9f6729f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eazCGQ8S2DGSA93BVNprlW/2p3B7gd8FKtJYQcZP6w79Nn25B95uGmjA/U1xSflI0QjWzTPg+Q9VH74KpuzRwwN9xnP+pHvMbybilMTpuSbo5YqGhYSaOLfBPx7UfwDpcvZvh4mQfFxrzX8XSSjqc0+mTGiXjnbRvGlaCcihqebf9mcHRpBXmu6fMUpflzFIbun5QXElbkXttSgPeKHzpSVppBSNaVN6Z4SCKQRQAmvXMBS2RcM+paZ/eAnMnEFiL4Jyo7FCUxlSezXan1KrsNZ6XTyYmpYEXzfBfJtD1xxoj8090IIUMzfOSr/q0/YbncRWK+9TIfmKAtlrO/JoSA1xtDyrS3Zt7fiG0skv+r0eTajtPPg6+Ay8lSUhr9rQu6g60Y3zDIMngqd82FSy9ydpkSVT/XG4p+MLNtQL2zZeMN6cnp9tHNy4A1Hzmf8jWVEKMt8h5A31b8a7rWxFlATY0lhBp8poKdbENM4H2iSoN8U178L7RrVVHJIcCydeKzrC46XpCJfHCjYkTTWt0tB0p/R+DkHVHI4sfNzkXmxg/8qxZjhzfygBUjxgiHaYhPszRnYGVs19QrdqrZ768xxh0n5szUhfffcJ7fCNvHdzlSa1vfaPEVuK3p5KFUSgPEhIGHzdVP5X0qp3214N0m1Ug1fHoH47aLcA7Tv8Py3arHBh2YOhDLAkiz5MIxvo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(26005)(6512007)(38100700002)(36756003)(86362001)(31696002)(82960400001)(4001150100001)(7416002)(2906002)(83380400001)(53546011)(6506007)(478600001)(6666004)(8936002)(8676002)(2616005)(966005)(66476007)(6486002)(4326008)(54906003)(316002)(5660300002)(66556008)(110136005)(44832011)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZGaUJjVGlmQVhJZjFCTTl5MFFESFQxWndORkNJVHBDZjBZUmx0QmpNQkhV?=
 =?utf-8?B?bmRQY2RoUkFtY3ZORXlzaWZiVjBMcjZlbkxXaFVDMTRFcFlhYkVZTkl4djZm?=
 =?utf-8?B?TUNIczNiM1VJaXY5ZitWK2k1dEV3VFVzV3cwaEU4RWRxTU5ORkNIZldob29v?=
 =?utf-8?B?TFh2SlNmOUwrR05NRFNuWFVPZ1NmNk9ucHRaMUNvdHhZK3J4T1FqWndaclRn?=
 =?utf-8?B?UmIzL205NFpSWEpGcGdnT1Y3c3RIYXNqQnZWVDErZzZDc21WRVBVc1l3aTNl?=
 =?utf-8?B?UGJGVmdWQkZKbFJuZ3ZHM0lmNkZDTlMvS1dQNCs1RnpGaGxnY0NUd3pXL2xL?=
 =?utf-8?B?em9MQ1B1WXU2RGJUL09oVkRKeDYyMjZnaU0rcFpHcUM2dUJ3Nnc2Y29IS2o2?=
 =?utf-8?B?dGNsL0I4cDBScUlWbU9EdVJwNEgrTXI0Q0hncC9BT1kzWGFkQWxaZ0l1M2Vm?=
 =?utf-8?B?Z3JXRUJNUUJvUW1ZYXlJdlZsRFlKYUlFb0xZZzNxSFhkOE1qcmkxSlpiSDY0?=
 =?utf-8?B?TUx3VVhMMWJIb3FQQ3hqcWZTTERmV1lUVnBIRVBBOG1JWGYrRlRUVXl1Tlpm?=
 =?utf-8?B?SFhPaGovN3FmTEJqN0pud1RHM2xPV0RwdUxVNFh4Vzd3NFVubkY5K0pjOE9B?=
 =?utf-8?B?OGFpM243WXdzZmtSSnJqTFlnOHNlbEYxVmV0NGRJMy9PMHF3aUlsVDgrWHlP?=
 =?utf-8?B?QUtlMXBNU0dyblhvSVlTWjNtWVk4dm5xVkVaUlhIRlNFWGM0U0p1MjRJRVJE?=
 =?utf-8?B?SWFLUFRXNForNTREY2JzTVZQdVpRbnUvTUpaQUNLSTEyb25MbDZkSm9qOFA4?=
 =?utf-8?B?bW5oUko5b01CdHdUdStqTlFlWjhXSW9Nb1Zsd2ovd3llRk15SkpZejJTanJk?=
 =?utf-8?B?RU5YMHhxbXVGZjA0cFZzeXh6U1hEZDFiWmRQQWhGQ3lEV0UwQWpkcmpNUGpR?=
 =?utf-8?B?MmxTQit5N0JwQjhxcFhMWkpkRDBnd0YrckdJSW1kekNtUWE3ZWZORVdDN1lO?=
 =?utf-8?B?Q2ZqL1FuR0hwb1dQWk5GMVZlRmZrRTJ4VkM2YTF4VUFtNlc1dXI0dzMyVERK?=
 =?utf-8?B?YVNJWE5xTkRnd1RQUnFkbUk0L1JTR1JjdzRIMHNRRVhLQzVIZnM0b29nVWdt?=
 =?utf-8?B?elVjU20rdjlWRDk2OXhkcVdJdmdkS1AxaWNiekhIaGJmVnFxQ1Z3K2txOUNO?=
 =?utf-8?B?YmpkbzF6NkV4ckMrSnJCcGxQN0psRzY4ekZmaXdib0dVZDAzZmRPQzVTVGwv?=
 =?utf-8?B?WVNSRC8rcGhsY0ZtRWRVTnd2d01XYmVkWlFyTmhHbWx2UDVpbi9DUHJaNDRU?=
 =?utf-8?B?bTZnbmpJdGVwdnRyc3puOEJLREdtU0E3bGJDbEtUclRCQ0FNcnYvUDNldVdI?=
 =?utf-8?B?TzFtNXgrNUp4QkM4bFErVzZwQkVSMVdoMzhheWpWSWo3NVNwcENVV0VJaitK?=
 =?utf-8?B?ZE5LNGhoamFieXN6THIrNWZjUzFidVVlYzRoWjJaNVRSMmNicGtNSnJsSXQ5?=
 =?utf-8?B?SENJMkZPdW1HRnNiWUZOT3hZN0p2dmRSWnF0UVNxQ3Awamgwd3ZLNklrMG9G?=
 =?utf-8?B?d1IwaUhMWXZZUXNtSDQvRW1lUlZYU1pmS24vS0lIb1p0R3JNMWl2Y0k4NUF4?=
 =?utf-8?B?Ui9LWGI3NjFmWVZVeHVHUlNXSGJlK21hRzlvaUlSMEJyQWZmdGhXVkNoMzZk?=
 =?utf-8?B?bS82ZnN6VjFOd3BKRWVDV2p2enlFdEQ2SForZlU4MlpRZXIraHdSeTJkZlJw?=
 =?utf-8?B?QnZzci9zR1hOSnFZdHhtZ1RlOEVycVErME52aDVtckR6aGJiOEVyL01QbTRP?=
 =?utf-8?B?T3RFUlh4b1JXSU1iM0ZDSlZtNjVNaExYNU5odys0aCs5NVhIYmsxUTcwOVF5?=
 =?utf-8?B?bUlnekh6SHBsSGQ3MUNjOUFwSTgxbzNkdXgxbjdSZjlHRjNlY01SdzY1TVhv?=
 =?utf-8?B?UjlRb1NLbU5qdzhwQ08wNjI2SnhkTzZpT0cyd3ovcHkwTHhWNVdpME1sK1Vi?=
 =?utf-8?B?SGd1cTg4QlVTUXRIQmlISzR5QjJ2aTdOODdmbVZnRWUzbmRoejJsVmJ2TTJn?=
 =?utf-8?B?bE4xQ0J3VE5remJ1V0ZWU3JjMEV4MlB6eXlwUTg1aWliemg3bGxoNnNYMWV6?=
 =?utf-8?B?UjV6dHJwc3JRUWtxcGt2cnJPNXUyNzY1ZS9DNXJBRms4cFFnUmh6UDVkWjBT?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4837ae3-21cf-4a9b-581c-08dbd9f6729f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 09:47:51.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/ckpibTBSLXz2GzO3aYTyE2BqWhCUr2MkISSwfigvpEUaqLHm0H4aQcgC+8F+1OWhlzfhO13igrZ0T2iBxoO6teqGAu2XBsi3vsop4caCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7850
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-31 9:07 AM, Takashi Iwai wrote:
> On Mon, 30 Oct 2023 19:58:52 +0100,
> Brady Norander wrote:
>>
>> The legacy SKL driver no longer works properly on these Chromebook
>> platforms. Use the new AVS driver by default instead.
>>
>> Signed-off-by: Brady Norander <bradynorander@gmail.com>
> 
> It's fine to switch to the new and more maintained AVS (once after the
> topology is ready), but I wonder how the breakage of SKL happened.
> Was it our intentional breakage in the past?  If so, why can't we
> recover it?

To my knowledge, skylake-driver used in I2S configurations never worked 
on "bare" upstream. While I and the team have been sending plethora of 
fixes to upstream, it has always been done "after the fact".

Another topic is the topology. Again, from what I know, skylake-driver 
topology files were never pushed as an official package to any distro. 
In most cases, Chromebook-users were taking what we have done during 
recent up-revs for those devices onto their distros. Eventually 
avs-topology-xml/for-skylake-driver [1] and avsdk/for-skylake-driver [2] 
have been created to help downstream users. While the method is not 
perfect, it is certainly better than forcing users to switch to the 
avs-driver immediately without addressing any existing skylake-driver 
issues.


[1]: 
https://github.com/thesofproject/avs-topology-xml/tree/for-skylake-driver
[2]: https://github.com/thesofproject/avsdk/tree/for-skylake-driver

Czarek
