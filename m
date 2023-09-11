Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A96879B6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354642AbjIKVys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240423AbjIKOnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:43:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0718CF0;
        Mon, 11 Sep 2023 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694443427; x=1725979427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MH97cnF+5Qv+emz25BekGtjCyzMk4NnbKgG4Dj56NPg=;
  b=U29c6b7GE1r3RdCiEwarM2RqnkAXXoGbutBoMP5C8vpyZMlVACK0fKSD
   MtjCa3sknDdCMI7GSmBEDVWe/LKoMyyo5yKHg0bobk3Qe0KM6o0GIsX6x
   C2dxaGmofSqd/aaYl+XozW9RtCrYfuZmtRYuqKcyZjDAEtg8lSLELCzIE
   Bg5V6jDDVNhw+p/du/Zf8CPBftH/JJYMpQr6KVSoyGOTkQkWgdr08Jdm+
   NRv+H4iSiHoHPNIgZl9I2TNZG8v0Rxrtp7Xr77q2gdVF6Zh873AZ1bNvG
   IS3pOr4zEEx4/7632uh3cJbkdyKLnDcQ3gvC8jUTcPGXDKy9a1uZdPsPn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375449407"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375449407"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990106653"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="990106653"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 07:43:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 07:43:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 07:43:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 07:43:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGulvxBXRAI4y9szbCaym3VjOD/2kiHXZ9EwFfJMMmaqxkzgXATq++sdApbF1xGOwO/y3UgkCPsbawGb+YiYkfy+iGI/f6M306i/CvkeUF1ho5y/OW3iBmoYNGSXShI05NdIjT3lbQmLiwXwU3MKwcvE38NeUSBEYKOGlHTqZePCEtJnQXYVx6ErMopIDi5f2KfcI1lBJtWBWnAfexrneVacT3OEOfkD9sd9Ba7EZQqZmvuO6aAqTdC9RxPjCNAKBhxMz7Px/+qU9ALptsrDKCzQ9LYGDisyng0A9jzI6IDYR7EZYI1uom068hoKil+yNwBP90e+Mo2FVjDIjfv01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiXw83iaIKHTbIZL8lfPB6/uc40sP5zp/S5kEM9XJLQ=;
 b=gUru1iDk5h51psYJ7RBZF+bhC0pIJs7BklxKndIB4tdyeFDsbKaffjE9mpcm4/gSimvKE2+gBN9Ff0QDy0VaNakQi2ARIts+NA7LPKGmBYDBrTRkWM2+ooJPmdEUGH+15Lb3RpccxcdIOrK1UgrRvAQqziQiAZkSpB+HKgABghk2ITE1CIisrVAko8yfjFnpmr9kCBW/a3DqhbS++aUX/lNQ2xmQcnNRkQx0p/O63LDanc7NFcMWX24nqrIOoQA5gEu0ZmqxsYVSvs9mbWBZjDvYAFbR2o6ryZOrQSuJLOiwij1t2W0mRE4qWu3X+qLI/Zec9h3hX/a+Vw1W0Jae7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 14:43:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 14:43:34 +0000
Message-ID: <75000ef9-4ab6-9777-8497-8f786c30a2fe@intel.com>
Date:   Mon, 11 Sep 2023 16:42:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
 <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
 <ZPCT2vV0r8l/wxim@smile.fi.intel.com>
 <05febba8-49a5-5f9d-34b0-d85d976e1416@intel.com>
 <ZPiSogB2GdyM+oJx@smile.fi.intel.com> <ZP3NlPOGtbT7CGQ1@yury-ThinkPad>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZP3NlPOGtbT7CGQ1@yury-ThinkPad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 040bbfdf-a734-4ffa-b0e3-08dbb2d57992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zOBeqsJL8OPz+ondQw0qvatfhSAjHYS8TB+l7IKYItpQ4UgvcvWCk+OWohCVdtedzo8MZoS4ZE7NVaY8fmkl1YpPKKtaLqg3W41T8UdwlarcJUXY8leu53Hxz4ct0JRLnR0Bo4qfg5TacXG6gHx8ndAVKa707HYwufXNK3gWCIE879tTHe0qMmGi5DdhQasbpQa5cboLsDh6q+6Yo6Jg4/wTGR8r91JhinViSCNZB6zn/KhxeIc9RIiTiedYGFbGvyY6PKrlQho6DAZWSbxpQnsJ5qfOYjVW51M+rn5kZgwdx4tc4K9GOwfkn4aIV8Z/vXhnaIH03Vx1VGVY+iGRHzUtdrRVYtQ0+8bUVvQnYcnR6LOeBtL77QyxeNHQdu8X03qLm75uyJFnDK9Y3U9q6sadGAIhSk9LXv9f8fJEDBeiCVC8JbtRoHv1hT3kxih6iGKETpRIdPa+XECfF8jy4a9OLFumx+hhuAHS6o9dXPR56JNUJKHliIv4CqXS7cgXK1ZLx7MgZCQZ6OHPmqGGupxRFiYcb8KCoQmCnSG3MOc5mRJ2whwe+Wa9OTgWn0unti7hueGV+33NV4mCZ3ZlnPmjR8iyktIdOlH0wqcFdB+WK2zfkJvgZN0hvJOv68E0vajdxY2fCvR1ma/pyfpiAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(41300700001)(31686004)(6486002)(6506007)(6666004)(86362001)(36756003)(31696002)(38100700002)(82960400001)(2616005)(2906002)(6512007)(83380400001)(478600001)(110136005)(316002)(8676002)(8936002)(4326008)(5660300002)(26005)(66946007)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVEd2FGOW5QLzNDb1ExZU51aFVtZmlnd0tzMTdaRkU2WGd5Q2hRYjhGZ3hO?=
 =?utf-8?B?WE9iUGczdTB0ME13NHZHdUlyYlZHYzMvUmVkenl4My83Qjc0OXA2M3Z5eXUr?=
 =?utf-8?B?VHV1a05TSlEzZE5JNWFmQ0NPVUhwSVhDLzEyWXJPQzNQazViQ3pFMTRZTTND?=
 =?utf-8?B?S2o4TDI5ai9vVmx6YmxGKzhTQkdVcFYyTDVEM0ZkV2VGbmVWNmNPTHZ5cEV0?=
 =?utf-8?B?ZTJ4dXk2bVAxZlo3NFUveWF5dVRhUkZmTEhWOGU1VU9OYzQxUDI1bk9UZVFC?=
 =?utf-8?B?ZVI4eWNhUlNHVWZHcFNJWXZDSVJmNmxTd0gzZjNySFlMSURnQWNpZnBtZis3?=
 =?utf-8?B?RWVHRzI2dlFjRXUrdCtQdEhnQVlBSEJ4dFBpclg4amNkeVI0Q1UyeGxtWVR3?=
 =?utf-8?B?dkU0amNNemN3UVN5N3ptUi9qRm4wQnV6TjVWbkt5ZXkvMDNGdENBUmF1YkhH?=
 =?utf-8?B?T0VRZG00dk1OclZ6K09uR1ppZjkrSGIxdWNJNEtQSWJMQXJKMVpRNG1Md3dO?=
 =?utf-8?B?ZHAyRE5ndFZKazNWczQzWnVqL1YrNkJTQ3QvL2Q3YkkvRlh6UTY5eitoTVdi?=
 =?utf-8?B?Y1NaUWdkS2FUZFl4b1NKNW9ueUU5L0JiMTEwZVVXTVgvT29rbFNrQVhQY1Z2?=
 =?utf-8?B?eU9WSDQvZi9jeGtpYlZKSzZnNDVoUGJkVG0zTTlVc1RiTE82Y1pjNmJVaG5w?=
 =?utf-8?B?eStBYXB4eGdRMUdhUG0zeWI5MmdHRDdKaElrb3BLS3ZlVTF5WURrNXBpbmZV?=
 =?utf-8?B?NE8xcFRFOVpwYzVlRHdlQkN3MmdZeFFzYXZRQ09PczE5cFQ0U25OL2U2dGlE?=
 =?utf-8?B?YTNXY3djNHlvcXozNFFLSUhpVTVGWjUrYkNodTd5VFczRGo2QTBsUHVkQ09R?=
 =?utf-8?B?bUxyckNyeE9UVG5Nd3p6R0JnRW12MHpkNSt1VjgxbXczcCsxaXloQ1pRRU90?=
 =?utf-8?B?c041UXRmRWtaSzYvMU1xUVE4clArOVZPUGJMbWhYVjBIUzczYVRnbWpRT05r?=
 =?utf-8?B?VEtINDFVYmRuNHJpQTRyaklvZkZSdVArT3ZUcXBLMmZMKzNXamRmY2JSVDhh?=
 =?utf-8?B?MUhqb3BTUzFaZ0VZNysyMG8vK2lMTWwyc2V6ZlNYTFRrN0dGTXY5OGE1SFdw?=
 =?utf-8?B?cG1wKzZYeEdHSjcyL0FDMFZYUnU5aWdCeE40cHVZWGdWTWk0eUNMalhMK3VP?=
 =?utf-8?B?MzJqbUZ5UUtTOUpwRUZBaUNDR2VYb3RvNEFkVzV6b3NSQVJSUnVXTE5JNDRk?=
 =?utf-8?B?MGtFVms4VWtyYUE0WFRwaGhuSkpvb2c2bWxsNTdUbVIxRTI5SmpydjVRM2Ix?=
 =?utf-8?B?SHVpL2UvaWZnblhONk9TLzQvSHFVb2FtWDlKcmhNNVYySWtyMHBpQWRoUjh6?=
 =?utf-8?B?OHlJSERRdHBvTkFOVG1IQnRBMFNoSy9rUGRndlNPTU5URDhxQ3VUcFZXY0Z5?=
 =?utf-8?B?SDFOMmszdmh5Z1ZkdTl4ckRyZmFEdlVBamxBWnE3eEw4ZjF5emFPWXJGMll6?=
 =?utf-8?B?S1J2RHZnclVLQ1ZVTVZpZFpJUk9QZUMxdEcwL2xURHNWdEFNTllYMlhTTVhk?=
 =?utf-8?B?bUVrNGQrendzUERQbVN2dDdQcVB1TkdnUktDU1FQL0tRYXFsZ0VOb2NFTTF5?=
 =?utf-8?B?cGdoanBSUEtWbnBwRGxTdkdKdk9tbkx2S0VlbDVYNkl2S3V2eE9CUmxBQTFR?=
 =?utf-8?B?QnBIY0djYXp0M1dMbzVSSzNTRk0rM1lON043VUZOUjR1QlpheUZTYzhreVRE?=
 =?utf-8?B?dGEyemxJdDlDd0YwSXVIZkpGOTdIek9ZSUdLbmlMdUMwN3Y2M2x4cE5XNFFP?=
 =?utf-8?B?dmZ5QWlzcllGM0VSRWVoZHB5RGFCb1o2UVV6OTR2V3pCWWpQRTZpZFNYWUtY?=
 =?utf-8?B?bENOVFRiQXk1bGRaNFBKYlBIaXp4VHJPSkxtKzdRNVVvM3BuQW5CM2pEamJr?=
 =?utf-8?B?Yzl1a3FFK3JlNDFkNUdzTVJIMnVCK2hUMzBKdGdCWWZvQnpxRitJY1VYbHNr?=
 =?utf-8?B?UW5QSXJOQ3Z6R2NLSzdGeDlYblY4R1VGMmpTak5YcUJqZHFBaE9yTW04TGh6?=
 =?utf-8?B?YU5MWW8wN3Y4Z0J0QUFXcGdTdVJMQXptOWsra2krUW9LZUNWLzU5YVpTUjJL?=
 =?utf-8?B?YnhyaUk4UDVvc3p4SDhHR0tycG9xZWtyWmxBZXZOM1RHQnZubEZRbDA1NjdD?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 040bbfdf-a734-4ffa-b0e3-08dbb2d57992
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 14:43:34.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTvpjAAMowxt1Bna6ItaF5DpQL1YVXpgOxIOjohNFSE5Idfv3wYUTkSedwniWOPPgPPXOAmB4fPVzbxEVIvd++Brulf2UuI9560pPQnP2HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <yury.norov@gmail.com>
Date: Sun, 10 Sep 2023 07:07:16 -0700

> On Wed, Sep 06, 2023 at 05:54:26PM +0300, Andy Shevchenko wrote:
>> On Wed, Sep 06, 2023 at 04:40:39PM +0200, Alexander Lobakin wrote:
>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>> Date: Thu, 31 Aug 2023 16:21:30 +0300
>>>> On Fri, Aug 25, 2023 at 04:49:07PM +0200, Alexander Lobakin wrote:
>>>>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>>> Date: Thu, 24 Aug 2023 15:37:28 +0300
>>>>>
>>>>>> It may be new callers for the same macro, share it.
>>>>>>
>>>>>> Note, it's unknown why it's represented in the current form instead of
>>>>>> simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
>>>>>> bitfield type") doesn't explain that neither. Let leave it as is and
>>>>>> we may improve it in the future.
>>>>>
>>>>> Maybe symmetrical change in tools/ like I did[0] an aeon ago?
>>>>
>>>> Hmm... Why can't you simply upstream your version? It seems better than mine.
>>>
>>> It was a part of the Netlink bigint API which is a bit on hold for now
>>> (I needed this macro available treewide).
>>> But I can send it as standalone if you're fine with that.
>>
>> I'm fine. Yury?
> 
> Do we have opencoded BYTES_TO_BITS() somewhere else? If so, it should be
> fixed in the same series.

Treewide -- a ton.
We could add it so that devs could start using it and stop open-coding :D

> 
> Regarding implementation, the current:
> 
>         #define BYTES_TO_BITS(nb)      ((BITS_PER_LONG * (nb)) / sizeof(long))
> 
> looks weird. Maybe there are some special considerations in a tracing
> subsystem to make it like this, but as per Masami's email - there's
> not. 
> 
> For a general purpose I'd suggest a simpler:
>         #define BYTES_TO_BITS(nb)      ((nb) * BITS_PER_BYTE)

I also didn't notice anything that would require using logic more
complex than this one. It would probably make more sense to define
it that way when moving.

> 
> Thanks,
> Yury

Thanks,
Olek
