Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D535C7F1257
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjKTLms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbjKTLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:42:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC58E3;
        Mon, 20 Nov 2023 03:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700480554; x=1732016554;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OvSOmxdQj3EiGCraU125XPAOXvkdSgfQjEttLCg/BWM=;
  b=K8iPV90QWdnDgHueU8giA0o63QBs0Qdz7mpFmlrc4UGW8QXP2CGXV/JX
   pScB0PFXowOf9Klpq8rA0aM/2yi1espVCV+lPXn/OlD/xzt1RbrziALeD
   pQWGuy8iVhf/x+kLTFddXs9c3xLohMr3lGed0FXkzLN5Z2AOShGJuSmQ4
   RJknT6fTP8lCEtDEm5sMKWwxPCSOdyTqt9rbMyM9JsTvEHyUIUDONLC56
   yUFTLYdmJF5I5FshxpmRQzkCO/veccDg17Wuf5cqlMYaGzlFnOmouGddC
   OsMFZt7pB3nZ30/uyokAtefI3ilUEmsVISeDz+gdoRrsdUgIaLG14vVl2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="376636307"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="376636307"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="14136085"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 03:42:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 03:42:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 03:42:33 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 03:42:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnebNumb2HGIMBLbsF6SWiyrXI4LMQEbZDZbDI5S7oyZOBo4nxgdijCG9URnRj+PYbYMR3bABP28OUGmeIsnipmtJzkVIAJHEkt9sJxPqeWx8GS8qEa5Ule3pyW3Hsd2UKsvmaSCdtxJAzPtxbV5jKhQ7tjg02efoAd5TyzJIyrazfLYZ+iBTVdWsjkCnc2AolbhGkNGiurigJQVtYz4q0IiNDKg70yb3ncypoQ8zL3fHsIg5bRWniJMYOdglZN5mXevFtcdCehU6LvYANEl0/h1JVmahiSwF00xZX+Lrw8JXjjwt13/GiA1BYbhsYYq5nuIGzkdLPaF3lnvvvD+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BT5F9RWAAftVtnD+g11S9NtAMqGa57HMK6O+GT3//Xo=;
 b=leBKOsLryU7MzMJnuPzOXHuuhEAZR5OUfqqmtlM/FViovCkoMI7V/Mr4V8vBb8s0Mn8sl6uWWtcC/GsMTxZyMT3+cH3YZrlOPnxGmJz2JjsCnKuCvJ58bGai7oYtE+wqS6CCTGSAIsrtFr3d1UE4sGejhMLsEM3r4gWlWGZIlx3je9pB2LBbxcNALv4F9irocpALjmSjIas6kGxzhloR6Wf0RYkm4kfwYL4jbIPJXBUBJaxb2j/kjzdcM8N2kAjadCytebQKyApTvh9Xlx/fapzvrGVWWXZxs0XxIh52LH3HOZdIh4KtEPvkOfd6uBrG+3VQ8oZ+X5h64H1YjmQfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 11:42:31 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 11:42:31 +0000
Message-ID: <2c61c232-1bbb-4cae-bb7f-92a7f2298e97@intel.com>
Date:   Mon, 20 Nov 2023 12:41:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>
CC:     <horms@kernel.org>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <edumazet@google.com>,
        <intel-wired-lan@lists.osuosl.org>, <jeffrey.t.kirsher@intel.com>,
        <jesse.brandeburg@intel.com>, <kuba@kernel.org>,
        <kunwu.chan@hotmail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <shannon.nelson@amd.com>
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
 <55e07c56-da57-41aa-bc96-e446fad24276@intel.com>
 <4b551600-f1a3-4efe-b3e9-99cb4536f487@kylinos.cn>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <4b551600-f1a3-4efe-b3e9-99cb4536f487@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 9027d766-4f54-43b2-07cb-08dbe9bdc78a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4s44bXuEh2oNrPj/sT4Xx4j3tNpMc4oeewSVjwM6m0m7vvg6CjolRVMRNa91nCXlrm1J550kMaZW0dY6+61X1/qKyLg9+Ryy2TfHmI9pf4JUSb41k4vkexCtPZoo9i22tRl7lhIKHihpcH8xD2WQA4+xwkw8wN3TqcssRrCOhU2rR9vA/F8M7TJBy1SrGLNdwWo9RvApGYNVy98nTG99FjmtJ2naMj5zoYLuqlyo7D+9luGlJrD6/2HaOAVNu79Av8w50AeQ9NZFiwMCh+56VrkZFGhjMkJSszD584zoqsyd+gGRN8Vt2/nXMqzj9vketZLS8zUWWz2h/FBlbULZdoBpgkEAZoUFdmLMdMQTdKdMCR12O3lwAyy7pt9CjeyMpzUgcB4lPu8rAVk0FfXAYqK28r4nBxJrdBymcVxhuFvVbY63WQwsqcv0jnJekefUq7PYlKcarzfQORZsHR3+AnVXJ0k/It9tiYXd3kq1q5kkfZKaiO/ayEgx80VKuhDwZ3oahdFhsUmIM1kdmYJUyH6TbHLt4vpZyRn4qKIpDO+04svLIVywLNBNSzxPPnMea6VDty03c+he2y2+3rmalnY6cDN5PuCVPkRvUnlRgft9yikhOYEwWDhTwah+hhf3G4yhjKQF92PPyDRFAb+Qng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2616005)(53546011)(6506007)(41300700001)(6512007)(83380400001)(36756003)(26005)(82960400001)(4326008)(8676002)(8936002)(7416002)(478600001)(5660300002)(86362001)(6486002)(31696002)(6666004)(31686004)(2906002)(66946007)(38100700002)(66556008)(66476007)(316002)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnV5bmI3NTJtbUZWbmwrN3JCK1hwQlQrQ2twRktUUDU3WU80NXJxbk5TNHN5?=
 =?utf-8?B?MGZXd1JRTFlkVTcxQXY0L21zV2svR1I4OWdKMStkRDMxcHF4NEhJWUErTXpw?=
 =?utf-8?B?c2RJYWQyWVArUDZUZmhxb3N1bmk3a0h1TU56OEN5NlRrTUlPeUYvakxwc3RP?=
 =?utf-8?B?MWl0Q21iekhJc0hJN0JTZ2JQVWx2bWxSWlJQL0RLcFVqZXc5MlVPNEtPZFpk?=
 =?utf-8?B?c1JWWTZjQ1JhU2xrN2lqR0NhUWlkbk1oeHN2OTg1M3RWMWN0U1d2VDBBVGIz?=
 =?utf-8?B?ZmhkOU5TRlMvNDZlSkxiWlJ6T1NCeXBrN3k0VW9PMWZDQW5SWVM2VVZSRzB3?=
 =?utf-8?B?eG5ZakZHdTB3RGZ2VWxwa2pPajVYOHlNWFg0bVdCa0k4cmw3R0t5SWhBTnV6?=
 =?utf-8?B?eEliRWN3a0lDRjVzWFp4SVNYUXpiM0xHSVJMdEs4VldUYnhkMWx6ZExlYzJX?=
 =?utf-8?B?NGtaaFdhbFhuSFBsSGZYQTlJd2JTV2FzNWZUWkE4S0w0bTRWNERqRTdsSzNt?=
 =?utf-8?B?OTZkTjlOeDN1eDgwM01ML2JLYUFMdVpqQndEelZ2Qm9pTVVOOVFlVkV4UzZC?=
 =?utf-8?B?ZEFudlBKUFdLeDl6dCtLRE5SR1M5Z00xcnpRbFJkRGxRN004Zkg4OE44VjZp?=
 =?utf-8?B?NjBLOUt2MUZEZlZvYUZTSzI3SjRXVmpSaU5KRG5rYk12cTVJdGJpSkFVNTI2?=
 =?utf-8?B?N2NKSk1rVDlIM1JwUDBmN1FsUEgyS0wxdFRMN2R6Nlg0TXVXd09UNHJtN0JT?=
 =?utf-8?B?dmh1dUplM21XUGZsVDZUTGNXY3ZNRitENFlNOEhvRTRXUEdOWitHbnZsUzdj?=
 =?utf-8?B?Q1BRNXM3dU93czh1SXo5NHJkT0lBV0ZiaUJXUC92MEtTQkM3OVBPVDRNVnZo?=
 =?utf-8?B?YkhQU3B1dzB6NWE5RFVITS85T0FYdTlMcDc2SnQ2SThWdE5vM1UydGlyNTBx?=
 =?utf-8?B?Yll6eWtCTjM2TGwzRW8rYlNsM21xSWNZbFZOcDZYK1FDNWdQZjI0TWpLdjM3?=
 =?utf-8?B?MEd6bE9QcVdCVVUvekE4RS9Oa1c2OGEyNkVNWi9TY25KaWRNL2FYNlY1S2s3?=
 =?utf-8?B?ZlhPYWc2cWIrR29iS1loQUFaRUtZRno2aGFuZkVLSDRmdlBhZTlzTTgzczZK?=
 =?utf-8?B?RUtUOVloVGJpSGhSSS8rb0IvRC83NE5JcDYzVnhyS3lYUFdFOXZLUmh2OTkz?=
 =?utf-8?B?eTBFeXVSYjBFTWFhTW9wUURMRFdHQ0hvRGFISkh0RmI0VnlnbytZcExtalNO?=
 =?utf-8?B?dVAzMGtadW5wSkZ5SmFVdHhSU3VKejNreTlQcE4rY0tGdmY5VzlMOXlERksr?=
 =?utf-8?B?TlFuYldFWkFnait6ajRFSXppNC9YSGY1aGVRNEI5RWFEVEZkWEVXdVNkMEd6?=
 =?utf-8?B?YkZ3SHVFcWxTZVlIMmdrSXdDNm5CVVE3b2dEVFJyT0NPNlNNUHhvRG04N2hR?=
 =?utf-8?B?VllzZ1FpRTNsNFh2ajBSeHMxMEJaMlFqUHV5bWhZeTNyblRKeFk2RjB3bkJM?=
 =?utf-8?B?Vml0S1pGM3lyTWJzTkk2M0xNT292bmdMSEVPL04xOXFGL3RrRUF1T21oWlNn?=
 =?utf-8?B?SEFxUTgrUHN2TEwrNjNYVlo2bEUrNm11b1ZXcFR4NnNkYmZ1ZVkwTlREV0t0?=
 =?utf-8?B?aWN3bFhFeUE2eTJlTWY3ZXo4REdPOVRXdkg2eFNjMndDdHFxVHFrL1UwK3dt?=
 =?utf-8?B?TWNJT3JsalFSVEc5V3lCWXhRUGt5ZzQvbDRqcG13Qk9mVUxDSDFIOW9jNW8z?=
 =?utf-8?B?U21mMnB6aVhNaHNVT0k4aHNVRzEweEUwamlzQzJBYUR3cmUvUVlLWFdlVEcy?=
 =?utf-8?B?UTgzNUNUVFRUS3lHR0h0TXJJMUV2WS8zR2plZll4MWhVd0ZPcnk2d29TMU1q?=
 =?utf-8?B?QWpKNnFCNHZCUU16R1c1WkdzcnN3S1JrbXNJeTFkeURySzBjaE5oajEyaTBI?=
 =?utf-8?B?R3kxWWRLclB3WDNwbHlRbmxYVGVtTUZMM3A1TEZIVGREVi9CUUtiZFlVbWlR?=
 =?utf-8?B?NytWUW9XWDIyWUl2YWRCdzFpNXdES2RiQ29HaW1nSDBIdFRHSG9LOWlKTjdn?=
 =?utf-8?B?Zys3d3MrTEVOaFpMWGZXZmZaY0grcDc4djVvZHUxTXU3MTBTKzhxSVBQQW9D?=
 =?utf-8?B?bTUzeTBuZGc3NDFsL0VQMXY4SUxXdUhjVWh0UTBBZUNlMG51UDVIWlFmZDFh?=
 =?utf-8?B?L3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9027d766-4f54-43b2-07cb-08dbe9bdc78a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 11:42:31.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/BOECmCiwQVCA4/Ufzveg09ZZp6eHITTwfa8vxR01409cZJPZ8PccYSK/jkRXX49E+Sd47HHuinI/yOIBpXz3VjIUA09me3lVwgfRI+LnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
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

From: Kunwu Chan <chentao@kylinos.cn>
Date: Sun, 19 Nov 2023 23:12:09 +0800

> Hi Alexander,
> Thank you so much for your reply, I looked at the modification you
> mentioned, it's really cool. I'll definitely try it next time.
> 
> But when using it, will it be easy to forget to free up memory?

You have a kfree() at the end of the function.

Generally speaking, 'ka' stands for "[kernel] allocate" and you also
need to pass GPF_ as the second argument. Enough hints that you need to
free the pointer after using it I would say.

> Although 'kmalloc_track_caller' is used, according to my understanding,
> it is also necessary to release the memory at the end of use.
> 
> On 2023/11/15 23:39, Alexander Lobakin wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>> Date: Wed, 15 Nov 2023 11:14:44 +0800
>>
>>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>>> depends on "IFNAMSIZ", plus a null character and format size,
>>> the total size is more than 256, fix it.
>>>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>> Suggested-by: Simon Horman <horms@kernel.org>
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> index 999c9708def5..e3b939c67cfe 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>> @@ -72,7 +72,7 @@ static ssize_t i40e_dbg_command_read(struct file
>>> *filp, char __user *buffer,
>>>   {
>>>       struct i40e_pf *pf = filp->private_data;
>>>       int bytes_not_copied;
>>> -    int buf_size = 256;
>>> +    int buf_size = IFNAMSIZ + sizeof(i40e_dbg_command_buf) + 4;
>>
>> Reverse Christmas Tree style? Should be the first one in the declaration
>> list.
>>
>>>       char *buf;
>>>       int len;
>>
>> You can fix it in a different way. Given that there's a kzalloc() either
>> way, why not allocate the precise required amount of bytes by using
>> kasprintf() instead of kzalloc() + snprintf()? You wouldn't need to
>> calculate any buffer sizes etc. this way.
>>
>> Thanks,
>> Olek

Thanks,
Olek
