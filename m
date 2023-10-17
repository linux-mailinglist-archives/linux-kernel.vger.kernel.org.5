Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1827B7CBE78
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbjJQJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:07:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C44FF5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697533672; x=1729069672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9vDmHKEfiJDrQrs2EXmcxg26MC5dTRN3dZebt82UOnQ=;
  b=mZyEvcPjWg/0qsJP0igA/D5xRYuOG03xq2ZKH18uFDaqHG0G/purOzP/
   0wwYh7gwyKA/zfJ83Y4wXN5nloxGryi+ToLU7108wLsDtECXReyyMsxEt
   aIIJTKSAXiB3/FpdjpJ3jyhGxekRwEfG/YmZEw1DVXS4r7wtsTtLTz7JW
   Ap3VVYuXisCA6Qm7FkNbK2m72XrrBeGPTk8GtWT0Zo5h4k45qB1FGjds0
   V6SGpNPlRGVKZqYXPkW977h+zSuTGORkXbwXN+8tLDUk2VHOmwsbkPQq4
   qKQpYjWuTTZozAmAU9bwQW8afy3iVYe9yrh/8n6ihuN/9KDxwO+CKFWu4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="416820240"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="416820240"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:07:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3848229"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 02:06:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 02:07:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 02:07:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 02:07:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZerCD0VdZMYZ+CnqGqNB0Q5VAGkbRwcqqOrYwTBduc14EvcjQ0Apb1LkkfKRSrJ3pnxA+oWv+XUKQ8nWo/C8fhHMf2fVsDLWdBRROeV8UJV5MkJblk6IX1laeXNQlGVEYRTkCyMenaVGYLaQI7ZXARCg+pzIrCq5mndg+8wCVi+h8W++aY/Ufa/JOHRzFT3DBuOAU777Qm1si+9FHWqbp+js21ghEBGIxoAFI7YPdskoif+QUADHOBTm2FOkLOfGACj2buOqOoyLmZZFYqCMc160BDKR96AMUwRjAOvwuwD7G407q6TSj22H2pHg4d82NwZgFCnUgJtZwf27SHrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPY+ox1pD6BAkHJMaU6foUNEz/kCfTvXP3j1uzYJB2w=;
 b=DlXLEdnReeHkYQ82hlRIPdFhRCBBrfYK89gJ9jzxUTl8faXh2zltlJwB1d9G9rWqT2Qs5c33lHYtvsFOUXa4QloTmVygwy5ffN9B6it7R26WXH/7MT3yAvJdSf4rZBv24e5VMcWd1xKDr8FnVf8ah+N4IF1QZVXulzGiaGFvZs8Jw11kPrkGy1ZWT7bG4zFq2qX/pJpGfCr2TNMHwKVoQeaTs964uIohXz3PmzmwZOsn4iTfkvsOQq9BoaLW3ILkuMps+UyE77noGCkvkgu+qsTZsF1fKk0Q0mOe1lRO3Vl5bmr7LTEYF0n4Ajp1iOx1PBVX9NUTyydGSeWx0UNzGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by DM4PR11MB6237.namprd11.prod.outlook.com (2603:10b6:8:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Tue, 17 Oct
 2023 09:07:49 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 09:07:48 +0000
Message-ID: <d77f35a3-5eec-d02f-459b-1968a58ff7d5@intel.com>
Date:   Tue, 17 Oct 2023 11:07:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] Rename variable bUpdateBBVGA, byCurrentCh, byCurPwr
 and byBBPreEDRSSI
Content-Language: en-US
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
CC:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        <outreachy@lists.linux.dev>, <forest@alittletooquiet.net>,
        <gregkh@linuxfoundation.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
 <0f6661a4-7281-4d26-8c26-ba03a567fcaa@gmail.com>
 <ZS41jFfwBJ672Rb7@gilbert-PC>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZS41jFfwBJ672Rb7@gilbert-PC>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::14) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|DM4PR11MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8768e11c-2730-4231-f4ff-08dbcef0871a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RoT2waDRbwN1KahbW71VMw9Jz29X9jNNOJigqvzBQOTd3Nr2MwTTgburQ9s/FSfL87SZlAU6EjcGYvppHu5u7RCAZxJJcFY+QALroBh3if1JivUjfBPRW1lKYNeAjehaLl5h3Rv1r/hmOKKWFx8pLWBcmiFU+saMF5L8yOIMdEUDCPvQsUpokngFEBmM9KA1Z/28crlVd9l32wyFijrV2RArZzG5/JsjiH6D6DGzFgd0jrWHDO3QH+YYerfYERnDHyr8MpIMXxdO/KviJhYHmiCMOUaYKN2lZ40ekE6AsJwuuAWqnCq5ERg97jJKCXyYzREMxpiNXbRnIZZTvgKe2rzaSiKvm5ZxEtOx+7CdiYZKsCo8sAOyww6jOkEt1XVqBwFo9ccobz6QES8TnaVbqGAM7rPfUmWsbGY0/Xu2KwtKnp8Ocs6JatyBZ9YZls/9Sk5IHqHPIpeI1reQg2nvvfh54l+LpntlvQ+vwRmJodsLqFXJltwY7cbC/feAD0OXs7lwdvldu8q6NkmTE9MqBPuIzY8LcDfvbplP/ez7t5VzMn+UlbvA/6wP5737qtHzWcF7f+l43PL8OHgUHIEr2SioMENBQVUxErDVjBXwYy0CpcOWolVkWx65Fv9ttF79NhoNv5fui8TSrDwja4hDJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2616005)(26005)(6506007)(36916002)(6512007)(53546011)(83380400001)(8936002)(41300700001)(44832011)(4326008)(8676002)(5660300002)(2906002)(478600001)(6486002)(66946007)(66556008)(316002)(6916009)(66476007)(82960400001)(31696002)(38100700002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERtc3lDREU2OXZkUnVva2QwNWpBanhKSnV4Qm1wZ3BMdUx2TUM2TUNPN0FK?=
 =?utf-8?B?Ni9XODJvZzJCNU1mV1htSjJBc2Y4VS9UU3R4Mkd4endpZ1UwNVFBbUFEa2NV?=
 =?utf-8?B?VlJoTk9ZamkyL01yVDcvemtCamFZSU9PYXZLUm5ETUZISWlqNFF6S3RPOW9Q?=
 =?utf-8?B?aFExZzhIVlpiSHdVZm5heUpoNU8reEk0YVZ1WWVBeVkzU1Rnby9BY3ZDZzAx?=
 =?utf-8?B?enBaRUdMUlU0TDgrU1NydVNxTkNvRFgyQTR4Q2JnR1MzeU1ZemVhKzg5YlpL?=
 =?utf-8?B?OE5NUzY5SGpFbjdsQVpiTDY2L2U5K3N4MkJHRGNQZkt0UTJueTRGL0pGQXhY?=
 =?utf-8?B?VXRpWVZNVGZtQ055Vm84WnUwdGhsRWhYSzRkc01tVlVkS3d6SmdIVGJGckFU?=
 =?utf-8?B?SStFVDkxeENFaGlWaU9vV0NuMU5SUkVHcVNSRDhLWlZZQlV5b1FhR3JITERW?=
 =?utf-8?B?MGN3MkdudjBQWDFBZHpjK0pWdmRzZlFLcmRxVXRINnFWNk9uYThvTm9BdkNQ?=
 =?utf-8?B?VDAxYVNxZzZML0Rjc2h6QVRzenh2TlRUNlBGenBGTWUwTEhTTm50ZU9FUmRw?=
 =?utf-8?B?aG9RN1NWT09nL0R2ditYZkV1Qm9tKytEVGRGQ3NWMVNEN2NtbWVpS3dzVWc4?=
 =?utf-8?B?WmpxV0lPbjFIZlZ5WUhnQUllaHYxSEpXTDllUzMzRXA4Q1JKekt6RGRmeWN2?=
 =?utf-8?B?UmNhNW1uOHFKU2NVeVM5dStVL2YrN2NrOGV3T09uaDJTTmhydFhhSzJRcEQ3?=
 =?utf-8?B?dEFsS3duK05EYTArVm5ubU5iYldIOVVCZHVvQVZjd0xmQitpbUlEL2hhaHoz?=
 =?utf-8?B?S09qbktXRHBsY2EwL2k2MGJsdjhqWnQ2UFJWcEljNGpqbFNsVmdTc2ppRzRj?=
 =?utf-8?B?T2dCM25Hd2tENmgvZEdhYzB2OVNjQ2lRaTV0aTk3S2NNdXZ5UzEraGZYOG1Z?=
 =?utf-8?B?bGxhS0xSYUxjdlUwN0pRcTFnZ3IwelVIMDh6a0NHOUEyeGs0V0Z2ZkJsdjlp?=
 =?utf-8?B?OXpPT25jUEFPeU0rczg1ekNCcGtRTFo2Zm5YK05uUFZneitzeXFkU0hidGZR?=
 =?utf-8?B?RnJNS1lnMEZmR3NZTnRjcm8rak5jay9wdTlmTTQ5VWRFbzRyTk4yclRlWEhl?=
 =?utf-8?B?NEpuclN0Y3FuSGxGOEFtVUpUaUhjTnA3bXRBNm5DelRYcVRZYitGTjNVQU5Y?=
 =?utf-8?B?T2hYNUZnSjRCeG9odmMyeW1rSmk2NUZHeWxodUg5cVp0MFJ3VlV5VjlqNlAz?=
 =?utf-8?B?dy9wYXFDM0hodHNKTkJ4WWlMMEFFd1lQTUQ2L2dNSGVFdGxoU1lFNUFPaWpY?=
 =?utf-8?B?NWhnUndTWEgzSTAzVk5YWHJTeGtVakVEZlBNa1hZc3J6U0NhR0VPNVh3b01N?=
 =?utf-8?B?Y0ZmMmRHTGl2bzNnZzYxTFZscWVuTXRFL0I0dklhZEVGRU9IRG9HN09DZ21v?=
 =?utf-8?B?R1FKRkdpNlJJZFJtdnVCcjhtZFRsQ0JDWUJRVTNjckY3UnIwL0ppVEpBWVJi?=
 =?utf-8?B?MnR0NDJySk5CWlR1SGo2TjNNNXl1TnlUMStwN3NFcFUycGxvV200WmR6em10?=
 =?utf-8?B?U0lmdGxlOVVjRldBNVc5V2pCemtsK1huWE43R1hqL1VBZi9jS2tyZlhFdTYv?=
 =?utf-8?B?UGdpZUZhK3hTWXNJZW9LK2ZJaHJsaHA5ek1PYjZXb2ovaEVGRWlXQktnZlNI?=
 =?utf-8?B?NWZrMFJINVVsVmQwS1crMFhKVW1VRVprVkMzai9BTW43ekk3VjlkeklmOHRj?=
 =?utf-8?B?N25oMzRNZ0krdGZqUTdFYll3MTB2bCtVT2FoN3ZoS2ZvenFobVFJVndxZ280?=
 =?utf-8?B?MUEycWFmaXNURFhsWEtTdjJTWDkvU3VHQXpDUEVtZ0w2VEdubTBqNFEvTEFr?=
 =?utf-8?B?N3UzNHM4WTdMWHNscmZyM2ltWFBYVlNQRGxDRCtoYm9EWUhsZ0VUM0xBeUNS?=
 =?utf-8?B?YzgrOG5OT2JqblpsdzVDQURSNWFXaXk2cWxPUWNpTUI5U2tnVHFxYW56bk1r?=
 =?utf-8?B?U1NmWUVIZU55OXhEUzlRZFdkbDRpSGN1MElUMU1pZm9kc0hmNkw1SUI4ZlZx?=
 =?utf-8?B?TTQ1bTBwS0tJMjJESEJSdlovdWhsMFlTektCQ2V2MEtCMXppRWo5T1NpOEU2?=
 =?utf-8?B?WnhQd2R5a3dqNlBqOE02bFYzZGoyeUdFN3ZvdU9jYjZNWWpwZmdha2dDRXdj?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8768e11c-2730-4231-f4ff-08dbcef0871a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:07:46.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1arWOu1m/QyLm1VhQWsV0l2FKuuftyaWDegIAasJjeGf3HlbiLetxLl+HayJ6waBMW/UxC5rVrJUUhic9nGHkTTpBo13Lyjwu597QUz1mac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6237
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2023 09:19, Gilbert Adikankwu wrote:
> On Tue, Oct 17, 2023 at 08:19:49AM +0200, Philipp Hortmann wrote:
>> On 10/17/23 00:58, Gilbert Adikankwu wrote:
>>> Make the variable names adhere to Linux kernel coding style and mute
>>> checkpatch.pl errors.

A small nit from my side -- "mute" suggests that you suppressed the 
warning/error, but your changes fix them, so why now say "fix 
checkpatch.pl errors"?

>>>
>>> Gilbert Adikankwu (4):
>>>     staging: vt6655: Rename variable bUpdateBBVGA
>>>     staging: vt6655: Rename variable byCurrentCh
>>>     staging: vt6655: Rename variable byCurPwr
>>>     staging: vt6655: Rename variable byBBPreEDRSSI
>>>
>>>    drivers/staging/vt6655/baseband.c    |  2 +-
>>>    drivers/staging/vt6655/channel.c     | 18 +++++++++---------
>>>    drivers/staging/vt6655/device.h      |  8 ++++----
>>>    drivers/staging/vt6655/device_main.c |  8 ++++----
>>>    drivers/staging/vt6655/dpc.c         |  2 +-
>>>    drivers/staging/vt6655/rf.c          |  4 ++--
>>>    6 files changed, 21 insertions(+), 21 deletions(-)
>>>
>>
>> Hi,
>>
>> -       if (priv->byCurrentCh == ch->hw_value)
>> +       if (priv->current_ch == ch->hw_value)^M
>>                  return ret;
>>
>> ERROR: DOS line endings
>>
>> What does the "^M" at the end of the new line?
>> Did you run checkpatch on your patches?
>>
>> Thanks
>>
>> Bye
>>
>> Philipp
> 
> Hello,
> 
> I do not know what this error means. If anything, I'm surprised there is
> an error. checkpatch is hooked to my git commit and all the patches
> built cleanly on my machine. I will resend now.

I'm not seeing that error when the patch is applied. You could 
double-check the patch files before sending by calling checkpatch.pl on 
them directly.

This could be also because of how some email clients change the endings 
on download, like Thunderbird, and the patch itself might be fine.

All the best,
Karolina

> 
> Thanks
> Gilbert
> 
