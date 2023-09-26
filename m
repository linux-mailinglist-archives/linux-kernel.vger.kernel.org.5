Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC667AF478
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjIZTwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjIZTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:52:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208FCA3;
        Tue, 26 Sep 2023 12:52:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBSlC4pgAzzMx5CQc2GfwvF+RqWDpIAC7601Dwx6oazs3OVh0VvCiLKU0A4LOmVxsWE1jcOg/pOY/uNNgMfHXnbWNgqVgj6lpN5TEfYu9bF8JLTAM/yKctxw4T6hmYTjmMAO99LclgP/XlIDJwQLvYKujzTUtuG9TZXzZwkvvpc0vDHCr+z4tdN0hNMJPUbriIW/lHewnRUl6fHfFaWZQVjTF7aIGw8xh34Q133VUJFg22reS/iAOTWyggMNGqjgGQZ7o5t7uf2B/ZxrZgVzMDvb6MXFxsEXlaZw+eWAB8xekM217/shk3fcBbS7eEwRL00pB1hmvPkgsHlT6TMFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ/hC/ZZhxKScRwJXFmm0EQWkWbr5Aw8Tyv9wsk9xOo=;
 b=K4IMYNNyp+FDUDjV/1CUa3u3L3uueyGx69cLukdcKg9RoyFZu8MyNp2QdrG7fTGrYSzqU27cDPmkWnCHhJPQHao+DpAgM1j8cyrBiWUGlSgdIkjP10/eqJOpPy4P4daxKYeF42P6AS3mzTwQaKMoKg/HyfnHYulrCJijWzHeBHOs9R6TmEy+c/sEsxjlkwHlfyl7mGSUTOW9Z9R15JvL8YsM39EegbgUt+OEmrrcU+F6tI1+M6z81tLlxNUCAkWLeJ3LkC1Xv5pIRUwtz6HfsqXVRYTfVxgcm/opa9UNeXumt/rf+SQDC/i4ORlTy25hVNFahZnNjve5+snO6rLZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ/hC/ZZhxKScRwJXFmm0EQWkWbr5Aw8Tyv9wsk9xOo=;
 b=HSNDdCb1tz1CuULvweKOrFgmMNBIpjidJ7bjMKshk5cyjRVrNv6RCFp6wfK70q/D4OlX1suVItrxg8b1LPCPjuY8v/D2vpkPvxq1FUSCBA+zNoMCwe4rNiOrFYaKxI7+maTF+/XSMk15jS9hP+tH5irri0udHrcubVzbfUNW5Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 26 Sep
 2023 19:52:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 19:52:38 +0000
Message-ID: <0b739da2-97b7-5a48-70c2-4be6af8ca848@amd.com>
Date:   Tue, 26 Sep 2023 14:52:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 7/8] x86/resctrl: Update documentation with Sub-NUMA
 cluster changes
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-8-tony.luck@intel.com>
 <560710e3-ce47-db07-e81e-3abd61e6ffbe@amd.com>
 <SJ1PR11MB60831009ACAC814C4F2A6072FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <e2949d93-946f-51c5-dd08-64de4a272f3e@amd.com>
 <SJ1PR11MB608334D3FBD41B8635E1CBFAFCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB608334D3FBD41B8635E1CBFAFCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f2b9c50-cad8-4b5b-71db-08dbbeca22bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XrgADV+Tovj5fI6PM7zPHpCMRblchg1dMNzlQi8AcVU8ArCM5WH0jatNaQYYbMRniSyoIheOumWawtxkZr8V4p39aAO7mXeDV08f7U1fUB74LiDaj+Px36NfDSHvui5BnmdPs37LboJLDNc4M4RcfqnK24IdaM6BYoITfZZH4hvwcqXOxDW2EZOZu3PWxp/BFxSz4Tlz1Q3BJi9piqJryF1V7Omw7J9gOa8boyw4joLYCMm8qZu6KzbkoNgmuW6MbhQrwc5oamO6BBUbMpAc2urrlJ1UOzEw0giYebnFy3iHPkfUhhxThWOeJAUQRF6q0/JiOx2phh/2lQeTjan2d/hTurQjlE+xVTsZfekIj9WC5ILP7XLXhSvB/RSFkgBlyNh3uVPWLxZDV1YY8dXTUl10Ik5J5zpNl5wNCfHXCzLUpe1S+fkcTTZOJQZK7vMxpuRpehq5Cjyg4dy8nOeY57PMzCgGWiTeUN/+CiACKl/DTZBP7rypj9YMkMv5iDl3KeNQU52TwN6wJBZvOVJKE4if4jEoVLf8q7s7G1msMxwz7hIer+DDhAtrd/xI73YO+5x6RV32/gJam1CMAqhLPlQMtXKYN2JMHXjWueeRIq4uHA0AUzYvo9LwtxIDkQL0oS+ljBD2MbWiWYC/ghEiElPhTUb29NHk9nJJDVH8QJs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(26005)(53546011)(2616005)(6512007)(6666004)(6486002)(478600001)(7416002)(3450700001)(6506007)(2906002)(4744005)(110136005)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(41300700001)(316002)(5660300002)(921005)(36756003)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpucGdLZWFmZjN2dDNhckgyQXNmeDdBQTk1dTRRVVlvVS9GUXprTUpWYlRn?=
 =?utf-8?B?RWNtWjJDZWpGV040alFCUFdybStvU09FNHJVR0RZT3h2YkZXUzFlRjJrYWcy?=
 =?utf-8?B?SnRJVnB0SmRZaStESFJqc1Z4aXRjOUpBamlGYWhBckQ5M2FnNUtBNW1pbnF3?=
 =?utf-8?B?T3QvWFlUWXJ2amhoZXBYTFptbGVWV0JBcGhZcmtkQ29PM3dvRXFXV3hCTENY?=
 =?utf-8?B?QTFBcU03UVd1QlZkaTA5bXRiaHcyaThQU0Z2THY3dFJ3dkxzZmFTQk9TQkZj?=
 =?utf-8?B?QndubDFYQ25tRGlVdFNSbTNjYnV2aXN3b21Mby84SmVPNmx3UFBLSUxEU3Ba?=
 =?utf-8?B?SGVzZ0ZjMjBGR2UwZjFqamlOU1ZIL3orOUR5NUVyZW5tME1OcXFNNFVpc1M3?=
 =?utf-8?B?UExmNFRXb1RTZjZhakwxSmtnVFlvc2NCZFo1VW5jSTZBSm5kbzhnN2xJWFJT?=
 =?utf-8?B?K3R2dCt5THpwUUxzTDV3TFZ0ckNKLzg3LzZWQllPWTdGcS8wZmJsZHJ5L05a?=
 =?utf-8?B?a3NrVHV2NEU5MWVRaVVJWjFzYkg2eHA4NWtMRHZUMWdSNm1aQk9Hc0Y4dzY4?=
 =?utf-8?B?U0R3K1dMQTVIK2Z4UWYxdm9rbDBlRVM0SjNFZ3ZxUjVkNGRmRDVFMkFMdVAr?=
 =?utf-8?B?T3VYREhEZ05VeVJKdVJqRGtaeCtWQlMxZjg3NTBWVGd1VW5qeTgwZmtsbzFZ?=
 =?utf-8?B?NXRCYjlkUnpUNUwyUHNLYjNuS2luUUZvbHNhVGJ5R2JIbUVYRWJFdTN3RHhF?=
 =?utf-8?B?c05qV3JUK0RsUGdndEVXcjY5Zitsa0ZvREdGZTR5dUxPZjVvQlVqMWpCTm9J?=
 =?utf-8?B?MUZUb2lWOW85UG1BSTNmSTBMSTl5OGtIaUZna2VQR0VRVm9zU2NmUVhRK3Uw?=
 =?utf-8?B?WmdiZWRRbEs5ZXhnaTdQSTJLMXUrWUh6elVDeUZ6WDJUWDNMeWFUMmRydXl6?=
 =?utf-8?B?bVk2WEpyVmVYQkNmVmNZb3F1bDVDaUllZFNtNjlML0htZU5VbVNva1Q1eGxn?=
 =?utf-8?B?ZUhldHE3Z3U0Rmc0QjlMMVdRQmgyR2svWjVBM0hmQmd5SGsrbVNNallEVXRq?=
 =?utf-8?B?RUR3Y1paZVAxME9nNk9RcjhxMTJOWWNGb1BaeitHL0wrSGQvVk1pb051MEdX?=
 =?utf-8?B?UkI0VkE4aHhvYUltNGtsblFYS0tVcUFlSFVPT3krSmxuY292WElrM2NqbkVk?=
 =?utf-8?B?ZUc0OUcvbjJtcTVta0xjMDlnZEZHSG5UVHM5dUpzTVgwWFVTeVdRZ2JkcjVM?=
 =?utf-8?B?ajlDa3hJb2pzZEkxTjJKMjZHa0pmdllnMnFmM2ZFSzdKWWI4cktheTZzb1pi?=
 =?utf-8?B?QW9ONTNIZGJ4RlJia1pkV2VmYVcxT3pFUmQrbkZPYnVsSnpMdC9pc1hNWFM5?=
 =?utf-8?B?dlVXQUNybks0Ui9YZTZEYkRrYlp0WU9HQW1FOVVydC9WTFBuVVJ6d0MyVnda?=
 =?utf-8?B?OUJ3V2ZzNzhYanp3RlhpR24xbWY4SGpTajROaXFsT1Bpczd1L3FZejhzNFBM?=
 =?utf-8?B?K1BkU1JsV0N2SnptNkM4RDZYV3B3b3RnL0RQYkRxcG9uZ2Q5ODJtYk5oR01u?=
 =?utf-8?B?Szk2MDV1VjhvVlRlT3pIdmQ1KzdzdmM0UHdZVkRhZjZrUkorYWszdm1zUzBp?=
 =?utf-8?B?bmtQYmROaFl6d2t1dXA2VXVMQXZZM2VpY0hIUVA2NnkwR3BYQzlETnY3Y2Nu?=
 =?utf-8?B?Smw2L0RaVWVDMEYwa1FQR0MvNGpqY1BNNXQ4cDFiblk1VjRkaTlMQnR6cHZD?=
 =?utf-8?B?bDd1OGRiNG1BN2Y0Z2Y0NHJMUkY1U2hFV2xybFNTbnNQY0ZlU1p1ZlNGZU1Z?=
 =?utf-8?B?d3dvZHBQeXdFeFo3Rjg4bG1wMVZjYzQ0bHFyRTNxV05YZmVjTWZHTXJwaWkz?=
 =?utf-8?B?KzJQYnF1NTJmekdFMXFtQU9GcnRwM0lKckRxQm5tQXFCVXo4T3g0Zm0zTzgr?=
 =?utf-8?B?cS9PYmRoUWo1VzlyandFVFBtRU81eXN4MkhVWXUyQ2ZMNXZjR0ZPZ3JFRzdU?=
 =?utf-8?B?bG5NaHJYYUJtOGMzVW5nWmxWSkJTL1ZwOEtRaXRnYURyNzVLUnIyVlNtWHNz?=
 =?utf-8?B?LzVCLzdmYWZDWklGVDA3MjdlZ0pYM1BCSFNUbyt6cElZWE93cWpxWGNnTGdN?=
 =?utf-8?Q?K4hw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2b9c50-cad8-4b5b-71db-08dbbeca22bc
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 19:52:37.9680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukvhs+t015jcZTTKKZtG6UIp4fXRVeLQttvYNGkB82s4LgS5HUR79a5Err+NNoX2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 14:43, Luck, Tony wrote:
>>> My original patch series added an "snc_ways" file to the info/ directory
>>> to make this visible. But I was talked out of it because of a lack of clear
>>> user mode use case that needs it.
>>
>> ok. Lets go with it.
> 
> Babu,
> 
> I'm not sure whether you are voting to bring the snc_ways patch back into
> the series. Or to stick with the decision to drop that patch.
> 

Sorry.. for not being clear. Lets stick with the James comment to drop it.

-- 
Thanks
Babu Moger
