Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5D7C47E4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbjJKCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344853AbjJKCmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:42:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56659D;
        Tue, 10 Oct 2023 19:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696992130; x=1728528130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WfNA5Kuwu4S/2eGDRk8gw5vwBYz0z11eqD5WDswzdWA=;
  b=BJ82KLQDylE3Ab+8UoKbCLwGIbtfgW0eL8lIflkkujG3ojixNRnT0Woi
   rnnM66Fa0TGFferQ3WYmZUXEHSUqMHsfZDR/eObAUfxhhImfqp1E6rsSA
   72dNExaSca+SpK+B6lRahpJJiMdG16rh02/StIHq8+hUArTQT4dG5+mXM
   wU5gPpUMD7XESCDb0g7k8NEWhPYMWUshOHPZABxH1x3RZhRSt8Or72CDP
   i6EbfdpezpygMfmQolUalMHAEYeBPnFL8zmHSc7eCgmidxRIKvro0lVBx
   h3972CuSOgZ4CnxNAsUdfWnaJ8lDs6w8YCEuBYLNqDmDwtJ7oS04GSRVF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387405919"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="387405919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 19:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="783084337"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="783084337"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 19:42:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 19:42:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 19:42:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 19:42:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 19:42:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxbKY8rfpxb5z85Y/ms2UdqG0MV+2HbKjrFnJx6qqS8UlQ1xeCy6JWhwLF8qd1JphbD0QiG94foUIfuw/gOP8zr0f7gv+gt5lMqUvvB1Eg5M96Fcqps2y7ehhyXVZsCXz289A0KIoyfB2GS/3Nqiz6i8FW7Mq1TDORyxgfTSFiBwoJhvBS0qY+lSwBQUJXXfdDa0zIggytDqNTYhr47fhwF7ad8xePAPXNdYh01k0KDyzflkp0EX0jyj02qperbdFj95nDRQf6RJCVdOCvKKmcGyeQ+nzTDfJ27EAfgyVb+tURbMPxGgeZ3TBEGLPXHtfGWXMWF7nkWkxm9IrX2l6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1FLZxju0CQ3u1qII/3ZtQ5E7CgoVZYjpLAA5MFBq5o=;
 b=lyWIpdX1fgivwepZJCR/JAeCucUsfzein4GPGhWZ0S/FQnhqRkf0v1Uc91hzLnyLEXRCm1kZnBy0jxtFJy4wAJ6XNzo+58H/vw3diRiMG1hwdD8bV6ckaIErbMgJs6Qyzc0FeAPq3QqRWiZNaLBmxosSRD1IalNXKFnCx+qBzMtBmsbNwy04kUMgS5vZ5bzcplz+xjpNa31cGnBa5UfrwTTY9PUFmL2aUKq0n57bQ5E4QV1z4KqgraGG41e57hOZKLTatC64t/zcmHA4nzuX2JaLAzOYtTHds+1mcPBobp4ysvX5a+00+z1AuLTvd2bUPCTkJsJN/X/gx9cAoPypnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 11 Oct
 2023 02:42:00 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6%3]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 02:42:00 +0000
Message-ID: <3f9e9468-ec74-42ad-8d42-c3f6fb8b5f74@intel.com>
Date:   Wed, 11 Oct 2023 11:00:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <tony.luck@intel.com>, <naoya.horiguchi@nec.com>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
 <20231010082836.GDZSULNGto0cPRPU26@fat_crate.local>
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <20231010082836.GDZSULNGto0cPRPU26@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0081.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::21) To MN2PR11MB3728.namprd11.prod.outlook.com
 (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f32d8b-2243-4b9f-3f5f-08dbca03a3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzEUlxRPcoJZqGRGlq/MU9SN58NHbBo613KGGvVeFkgUrbKe8AiT9/x+hhe7x1iV2SMxq1OLI9RyK3yYXiLcOP7Yupybkl40zDnvHj5Jh1zsLB9Q5rAxPDg77DL5z7nfm4it8vAEnY6GQQxYcV6H15uyPBneXgH5vSmdVH0mDBSP67QWGIbj1/05mhCA6s9q7cqSw9BKo+oC5wYl6lrNzGa6h72myU7VPt6tCjFmadUX8D8NrTMYIWv8LPjjJvhz+/etCJeGJnpbqz4qRD9qqQzG0sZlYLJm+Jq/VaaB5YCW+bWT/1C/wF0yx2q1uxHCv+jq640pIDlBMAzbc3KIssLPHoBHnNPOFR2nEnSc8w+b1q6JC+7bu6/B66AwIVvCoBpIlbDnpW68gMRdwhtJjPi93AGrIrjpbTYLMsS71Fds29HMrF1/kiZ4lStkU3Bmy2dr1MYevm5E8yj6f6056v/WwUIkcWqemz3ga9G/z+99Mk5xgDYlDHJCKVROFdFzXwaBZkjpfi4/qMxHroqijR/oztP7HHqUlalBoUU/uQ1/gcnfWRQZQxhd8AzEvosW9PC3ZXKMKpQdvXO3gaXHqlKD815RYHN3AFSnFkPNx450t3gH4ZIpLIIZfbHvgt6WjbblaFrpre94GuqbH0fQi/9iqNXAFcf4JdaRjwnMAnY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6666004)(6506007)(6512007)(6486002)(53546011)(82960400001)(38100700002)(86362001)(31696002)(2616005)(26005)(66476007)(66946007)(66556008)(41300700001)(5660300002)(2906002)(8676002)(6916009)(4326008)(8936002)(83380400001)(316002)(31686004)(478600001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1VFbHFUTTV5ejgySkZKZGVzbXJESWJFMzhSR3QvSDZaaU5ZR0V4YXo2a0NB?=
 =?utf-8?B?cXRwYWVRdHM5QTBESEcyQXdDeWhxZmNsYVhqN2lFVWt6TklhMUFwWVFlSjls?=
 =?utf-8?B?Mi92Zm0zaDNxNGlLeE5KWEpWWW1hK3d2MVpjL1hsTFRsaTUzLzBoTkY1YzdB?=
 =?utf-8?B?SXo5NnJ2M3hHWnhjTEZ3RTlQVytlSGo5bTlFZjRBOWhWL2tkLzBpencwM2wy?=
 =?utf-8?B?ekdTelRMdWl4MGlTUWsyN1JCVG1Ib3JnOUxwajRKd2haMVd2WlV4dkw0R1dh?=
 =?utf-8?B?Q3N3cXh1ZlQ1eExjMVVsWC9IcHFvNUd1aDU4WDQ2ZXlHWkxyYi8wTFRSYURu?=
 =?utf-8?B?d3ExeFVpQmlaY0tIbEVNdlNoV0hzYkhkaFBIYi96VDBSbXhoTlArUkRqVVZZ?=
 =?utf-8?B?c0NnTXVrY2JnR21Cc2Z5NC9GOWs4QkZuNlNybVZNYmJaVzRldk5XU1ZBY2Zm?=
 =?utf-8?B?eTRHcng1NXFvVDNDakJHR2NRN3dWN1FJT0hxK0Y5cG1RMml5b09GZ3VMekE0?=
 =?utf-8?B?Tk5NUnUrTStlT2NOVDBWOVBicE1RbnBWSDhaWDFBbkxGWDVZUnpSNlV0UWo1?=
 =?utf-8?B?UzhnREgzT2x3bUNaTFVUM25lS1R0U3FwWWYzOGludDIyT3FuOXhqTnRWWHZp?=
 =?utf-8?B?TzQ5NVhaT0pRTmVnNncvczNUM3AwdzEwZjJKR1RYeFBVaGx1c28wVlRJYSth?=
 =?utf-8?B?TzQxcFR4eUVmQjF6dFJibStnQzZxSVhwY3BoNVFndy9zOHNhbDRvOSswR0lq?=
 =?utf-8?B?cnAxZUliV3A0b1pHOHBIaDM3aU5iU3Vhb3gxVTdjVFl3RlVZRDlWektwOXlB?=
 =?utf-8?B?QjV5cVRHZHlDS2R2M1c2QzZSWFA1aC9vNDd6em5WakwwU2IzZDZoTUNZckJo?=
 =?utf-8?B?VEtLWDVIT3NzekZvZmIvMzZZempEZkFFSXVBZzRvSEI4WnlKNVhlQndPU21N?=
 =?utf-8?B?bEZoZ0o1NFJOWGNLOE9KUWlwQTE5cldsQ1dkT0NCVit3ajZkSEFURFlha1BT?=
 =?utf-8?B?dVZZZWZ1UkFleEFlVEdtczloWjdwem9nY1c2a1ByTnRqbzMyTklUUUJUalpn?=
 =?utf-8?B?b0U3b1o3bnlwRml2aFNBYTVPaG12Wk1jaE9ibERlMWw5REJXbXZCVUJLYW00?=
 =?utf-8?B?Nkx3MWRDRXFENndCMVJDTGFxcXZycWNJNGpIcVJwNnMzT3dJdkk3N1JxVkxF?=
 =?utf-8?B?UCtvVnk1YThXSTBVb0pkYU9pVkMwL1MvNlB3L2k5SktFTEg0UDUyc3BJU0Jz?=
 =?utf-8?B?OHlMZVJlRC8xcUt6S3JOYW5Zb1B5NWdzNnVMQnE3VklIZnVxR0s3UXBXOTVP?=
 =?utf-8?B?Y0QxR0I0bkl3WXJqRjhibGprTHY3NDBUMElDOGVEamZyanJCcnF6ZE9tMTdk?=
 =?utf-8?B?bEdvbFBscEQvNWJEWHV6TWdJeTF3OUxhZHpvYWQ3RUJxT25mUlc3bFRtSnQx?=
 =?utf-8?B?eldJLzYvK3ArWTN3YzlDWnhIcEVZVlRUYmd2Qld0dlFPWGt5czdrU0o3Uytx?=
 =?utf-8?B?YysrQThXOExaZ2hJWGxtQ0JQSVZmUkhLcDRoZEpGZVdvSzh1TDUzWThrVFVT?=
 =?utf-8?B?c3NzSmJkZG1MUWVCYmhBOU40a0RIbjkxRGllenozcGZNZ0lnQ1JMM3NDN3RN?=
 =?utf-8?B?TUhuK3dsd2pTblBpZXZESmI0Mlo2ZG1tT1Z2WVVzaWxYKysxaGErcjJjd2tt?=
 =?utf-8?B?ZHZDNUMzQjRib3ZwLzdRUUF5Y1ZUODJreThJTEJwV1R6VXBKMFlTaDRSNnBS?=
 =?utf-8?B?L3Joc2hjWXJTTHJxbHBrNHpTaExqdXMvN0U4TFdrdnowcGFPNXgrRFJodFFk?=
 =?utf-8?B?NEg1YkZITHVjZlBnT0NxYlFBYVhuSTRhcUZ3VjJBSTIxRjZsZ3Z5djFNOHQr?=
 =?utf-8?B?S3ZPNmczV2RCbUtLNzVlWHEzaGQ4T09NZUs5MS9Bblh0UGJRWmxXRE1kWjk0?=
 =?utf-8?B?Z3MzeDcwT1NvSlNxNnJ1Yy9YUCtkZkhPVkFUMk04THdBekVvajZZL2cxNG1r?=
 =?utf-8?B?WHRVNXFUbFhPQW5oTUMvT2xXblo3eDBLb1FBOXB1ZjdqTURqWnpxMXJaQzYz?=
 =?utf-8?B?YzRqZ3pjc2g2YThPN3BrTUdSWWZUNEVQOWo3UXJObkNOVGRLYmtsR0IzeG4r?=
 =?utf-8?Q?0iQE3HKybzEcKSXLHnqsB4672?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f32d8b-2243-4b9f-3f5f-08dbca03a3ea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:41:59.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Cz1s6m7m78a4SSB3Rg8iiBM9M70ZT4X0QK4WKhNyM7krVPvVRwowToK1HaTQIdmRSXWf4A9NHoczI8LuL7usw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/10 16:28, Borislav Petkov wrote:
> This commit message should explain the full scenario, like you did in
> your other reply.
> 

Thanks for your review, Boris!

I'll improve the commit message in V3 as you said.  Just adding the full
scenario part, the paragraphs to introduce the considerations for the 3
solutions and how to validate the patch are unnecessary, right?

> Also explain how the poison flag is consumed by the kdump kernel and put
> that in the comment below.
> 

Aha, this is the neat thing about the patch.  The main task of kdump
kernel is providing a "window" - /proc/vmcore, for the dump program to
access old memory.  A dump program running in userspace determines the
"policy".  Which pages need to be dumped is determined by the
configuration of dump program, it reads out the pages that the
sustaining engineer is interested in and excludes the rest.  The de
facto dump program (makedumpfile) already supports to identify those
poisoned pages and exclude them a decade ago:

https://github.com/makedumpfile/makedumpfile/commit/030800d88d4baca5f60ade0acc1846a65608883c

That's why I said the solution 1 is remaking the wheels, scanning MCE
banks, checking the poison flag, and excluding error pages are
duplicated actions.  To set the HWPosion flag in the production kernel
before panics is the only missing step to make everything work.


>> [Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]
>>
>> Co-developed-by: Youquan Song <youquan.song@intel.com>
>> Signed-off-by: Youquan Song <youquan.song@intel.com>
>> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
>> Signed-off-by: Tony Luck <tony.luck@intel.com>
> What does Tony's SOB mean here?
> 
> If I read it correctly, it is him sending this patch now. But you're
> sending it so you folks need to read up on SOB chains.
> 

When we were developing the patch internally, Tony contributed a lot of
precious ideas and guidance, not only the code change he mentioned in
commit message.

The previous V2 sent by Tony missed the merge window of v6.5, so I
re-based it onto the latest v6.6 rc, re-validated and re-send the patch.
 And I will follow up the feedback from community.


>> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
>>
>> ---
>> V2 RESEND notes:
>> - No changes on this, just rebasing as v6.6-rc1 is out.
>> - Added the tag from Naoya.
>>   Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
>>
>> Changes since V1:
>> - Revised the commit message as per Naoya's suggestion.
>> - Replaced "TODO" comment in code with comments based on mailing list
>>   discussion on the lack of value in covering other page types.
>>   Link: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 6f35f724cc14..2725698268f3 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
>>  }
>>  EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
>>  
>> +/*
>> + * Kdump can exclude the HWPosion page to avoid touch the error page again,
>> + * the prerequisite is the PG_hwpoison page flag is set. However, for some
>> + * MCE fatal error cases, there are no opportunity to queue a task
>> + * for calling memory_failure(), as a result, the capture kernel panics.
>> + * This function marks the page as HWPoison before kernel panic() for MCE.
>> + */
>> +static void mce_set_page_hwpoison_now(unsigned long pfn)
>> +{
>> +	struct page *p;
>> +
>> +	p = pfn_to_online_page(pfn);
>> +	if (p)
>> +		SetPageHWPoison(p);
>> +}
> there's no need for that function - just put everything...
> 
>> +
>>  static void __print_mce(struct mce *m)
>>  {
>>  	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
>> @@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>>  	if (!fake_panic) {
>>  		if (panic_timeout == 0)
>>  			panic_timeout = mca_cfg.panic_timeout;
>> +		if (final && (final->status & MCI_STATUS_ADDRV))
>> +			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
> ... here, along with the comment.
> 

Good idea. I'll send V3 as you said.


Best Regards,
Zhiquan
