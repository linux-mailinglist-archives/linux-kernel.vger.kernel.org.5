Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488CC800D63
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379196AbjLAOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379192AbjLAOim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:38:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353810F4;
        Fri,  1 Dec 2023 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701441529; x=1732977529;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+D9ZXJt9dFTu0cHaH1GpikKy6GcMVOfN8rEMQQ3+vuo=;
  b=ZbuceuAAbHxCozcXxg+uuvxHNhLciYS6XGEPy2+Jv+y814yE0RK/gHAR
   YtIZkQdrsPfvoajKUBt9X99/Ra4wQY5oS5kP+/ZYTI/Mw3EPTc/WrLMBZ
   yw0ICpwhTt9DEr2ybDkfK74FBygeuB3LaHHt5b9+8vOsU77t3tGOhGjq7
   rxgDZkOfI+2cOqytk3Bo2PC3ADJzoMXt4MrA5LB1zR8Yd4eC3T9mKRkPQ
   Xe/ZC8CzDWCOnKY+jJ0SCaGk33iQzVYgbrm1ZacFa6vYx4FnJSY3kFwYU
   BZv0GErZysB1cayeR9oOSIrdm4DYKrpJ9YpiO54tidMVcnThnh+srDg89
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="424661737"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="424661737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 06:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="860575279"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="860575279"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 06:38:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 06:38:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 06:38:47 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 06:38:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhKZG1NR6sdchN3dwtOM7LzTEwh5tjmqTS+OZQNhahUUqcdVKq6xXQMJNRuqHjKZ5YgOI3aFZwM1Q/wCXFOFfOPAKNzuV6WHPBb8Rz/HFoDFkY/kWavn/rUjrxHdIN8qk8SiUd71sZ27usKRigF0t8S0qZwzntfR1Pd8PeA3zTNR2CUcR4tRoio3TWC3qe5EPDHEHAUKanOTlK3u+dbkXRMpReC7FCUvvOlXFKMhVItwnozXY0EiXyXAL6duCR9Zokvw/fMh5kZ6BioDzMlCV0maVbh7Sl2ZKcjnacj7bOeLRRdmQbbR5b8MDTqLDvw5VYOKqrHeB5FMK/jpkR+zCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPd1fvafhxJHe0UMPc/QDa4EDBn4YC1nuDhbeZ++HVc=;
 b=gNk1eHwEdQLU2NJPY4hAfFEWpi3zJ8Vb7ljFO3ZgNLsJH5ImX4pmk2jTlLLb6Pl2nFJ3CKOpNMZweGHU+L8u2Kyntoudjh3dOE/l7qBIryT+G4KiOWiHg0+IlNG2LNTDXMk2QW68c0/XlBbeNmIZRwohTdfCIg7hlhcthHV4u5igE3BB4i4l+l6ep0hHT6Y1t3oO6PyTRwHx6H7cmlz2uDvoGqzwa5Mu81AhRIPakwgJbRHJxM0GqYrPuYKJ+OyLOPTY3aSFCOU0/+RcZVj1YmVSLaxX3iJw9JLBfowSnZO9MgSo2n8CykGl1pKSUZE9v+tETtQxFN793mlSHCm+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by LV3PR11MB8696.namprd11.prod.outlook.com (2603:10b6:408:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 14:38:45 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 14:38:45 +0000
Message-ID: <c0a4b430-291b-4de8-a655-2f768e95fe5e@intel.com>
Date:   Fri, 1 Dec 2023 15:37:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v5 03/14] page_pool: avoid
 calling no-op externals when possible
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        David Christensen <drc@linux.vnet.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
 <20231124154732.1623518-4-aleksander.lobakin@intel.com>
 <6bd14aa9-fa65-e4f6-579c-3a1064b2a382@huawei.com>
 <a1a0c27f-f367-40e7-9dc2-9421b4b6379a@intel.com>
 <534e7752-38a9-3e7e-cb04-65789712fb66@huawei.com>
 <8c6d09be-78d0-436e-a5a6-b94fb094b0b3@intel.com>
 <4814a337-454b-d476-dabe-5035dd6dc51f@huawei.com>
 <d8631d76-4bb3-41a4-a2b2-86725867d2a9@intel.com>
 <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <6c234df1-d20a-812e-3c58-7e3941d8309b@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|LV3PR11MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: fe02a8ab-d344-4570-df31-08dbf27b38d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8S3ligm3pe9lXvDobGxIFzBsiTidNzbHmYhqUlqAp2HWKyH1qpXUQFPVlY1jE09n7wYg4Gj7PUqtniSFHDUKS/TpJKtwxEipsuzV7LeTyaUc/e1cvnS4W0kpuZEH9RqvC2ZqX/Pi07Pj1eG5wqUwfnOMVUEVEhqThPwj+KS7yRfx768o858Sv6XAn+3Rz3PwfLxPFCH1YnoO90bL8jzR7FrOo3uR/RfNmmFeHmOjrJCW1moVsAUawlzUltHjoWTl7Gqit2nBWeGiC2AyonK9bdjlIM9IZb5ChbC9MgB/erE04cVm+38PbFr+de2LV8CUTiLAwz/wF5ka49jNloFme1sXMiqce/N1p0Stn74Q1UhYobRZ6+9kRr+yAhyAvUxaTn2Vi/vBdriiADSfnAUS4clIAQVGWuCZFTgGfTJuxUgjOLJkJyu4O5y+fwsfKPl0fpwA5UpvpiZpoNBIMKnYd37Lal1GvvyqDYWBwDVDrz6yHC6P1+ILu7e+op5nCF5ziJSq0WVLKyv0/MPruBnJuPd/u0Nm6YNkUcoNTNfmxDwB0WRSqIDrZsQrvqag2vImtILfwWVs/DIa/6tnGUnJ7NetwoVUFPVg3Wsuj3x3g12NocTpLHo9zpGeB1I3k3OlRlQ+Cn10KPQkzNqb6cwiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(7416002)(5660300002)(2906002)(8676002)(4326008)(6916009)(54906003)(66476007)(316002)(66556008)(8936002)(66946007)(26005)(41300700001)(6506007)(966005)(6486002)(478600001)(6512007)(53546011)(31686004)(2616005)(83380400001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05IRlhvQUZHK0RCamM3NkRmODlJNFp3SVNvUDhOQmhQRUNucjAwellLVWFl?=
 =?utf-8?B?SFlaMWUxYTEvM3ZMUVFYbXRsdUE0dnc2S25SYjltSnFpbEJONDRmR3ZjSDd4?=
 =?utf-8?B?UGwvaGp5RmVLYmR0b2ZBd3czdnNES2wzdXBxOFI5Tmx0eVo1RXlDRFRKaysz?=
 =?utf-8?B?TWE4K3h4Z1JUb3pINjdYSjVGbXIwR3hGdHZDdktVNGwvcWNjNHFKVVpZbi9M?=
 =?utf-8?B?TlhlZzhBRFlNV3RGbGFlOVVzeWZVUEZraHk1Tiswb2pYeFFXcXZBNUd5WERR?=
 =?utf-8?B?VktsbE5OR0VCbkZYNk9lbUNUSU9MMTErVFVqUTBpUG5QdEdZME5jOExIanFw?=
 =?utf-8?B?aER5Z0tLeHZZbnVXcEVicXF0WlE2UjNUdHJyV1FnRjByNUdDWWlXc3BFZlNu?=
 =?utf-8?B?dEdLZXo1NDV6TWZQV2tUeWZFbDFoWGQzeExlMlNjeSs2OENsbytLSjY4NFEy?=
 =?utf-8?B?OGhYenhlTit3b3VIZEFNUStxRzRaRjZyTjlMUVAwSzJGWEVPNnhWcC9iRldS?=
 =?utf-8?B?dE1xQ29SNzFHR1JEeWxMNEhBc1dUWk84TE9sdzliVGp5MStTYzB3M1ZuWEFB?=
 =?utf-8?B?OWluZzJDVzFZekM0LzJHSzBSTDkvUW9qNG1RamZKTzlMTG1IdVR0UUtTT1Jt?=
 =?utf-8?B?bjFOejc3YUU1NlhMSTNrSEhEbmJsVG16MnFuZDBEamN4TkFnOE4ySEdyYW4r?=
 =?utf-8?B?UEFHWmx3SXhTS1dyL3AzOVpaaVl4VURNMFBCcmFNNzRvN3BoMFl4TDVzZ0lH?=
 =?utf-8?B?cTRkL1NrUE5tREZhbGFHeEMwM1hlMEYyYlp0aGxqNjh4Q0ZMQy8zYmhrWkVp?=
 =?utf-8?B?bk1NL05KcWRrT3lrcFUyT2lGc0dhQXVSTUhuOVVlOXpnVURjMzMrNFpHN2k3?=
 =?utf-8?B?eW5LUWZKS2dKOXY4UEJYcXhpdEN2aGp6YTNja2w4dGNmYktCODhzYVRBVm5T?=
 =?utf-8?B?TEFqa3VpaXFSc0N2WUhVZVdFZEVYLzhKYW1IUUgzOUIzajlpdDB2OStHMUk5?=
 =?utf-8?B?WUFib2djTTBCdWREMU9iSHp0WktwdUlVaUE2MmUrRW53Z01SOERkaElaTkhH?=
 =?utf-8?B?L3UxcWliZUEvbWF2a09MR0xBeVJzUHViQmY1RXFNNVdJZE5hS04xaldUS1Vl?=
 =?utf-8?B?V0E1RkoxVTJKWDhJU0YySEVzMGlpT3RudzdERVU0eXdLa09OOG5WRk41OTc3?=
 =?utf-8?B?ei9OdzZTc0FjSkxZV05sRi82d045N29SVU5lTUhuRWdpaS9LcW9ZcHZiWktL?=
 =?utf-8?B?UERRVXlSamtKRFkzcmdFSlJBbXZkY1paRTJTcWszL1JIODJHOFdLaTBLRERW?=
 =?utf-8?B?VDI2VE1GTlVQdWUrT2IrTEFnbmczL3BZcGZoWU9mQUVmN1RFYXJCVlMrUlps?=
 =?utf-8?B?RnRBVlNsL3k4WDAzMEVJamhBRWttb0d2ZTVteHZpdGFDRkF5TktxdS9QM015?=
 =?utf-8?B?NkUzbFdiZE1zMnU5TVVkcERKcVhOYThjKzAzMHM0VWlPck9CYkc2UGRLUEI1?=
 =?utf-8?B?Mm1NYlYrQXlKOGFDYUtQWlkzV1VzWVBXK0daNUNYL2txNXk1ampPQXBtckRn?=
 =?utf-8?B?SGUvNzNtVVpBUEszdTVnM1BROFNUeWpMZjU3UGc2elhKVWp1aTN4Zk4vNkxQ?=
 =?utf-8?B?OUgrSUxyeWcyai9Kd0I4Rm9JbXMzTndHMkN4MVpxTXdtaGdDS3hQRnV4MmF6?=
 =?utf-8?B?T2FEQlBFaWZ6dnk4eE0vNUx5SWFLcDh0dFp5NE5oMTEzeVV3ZUJhNThvZElk?=
 =?utf-8?B?M2MzYWlybHY5d0lOVlRTd1RBUUZNRUUxVXpQSDhWZU9WK1ovWTVOZTRrOTNH?=
 =?utf-8?B?WVdFTnh5Z1VqZ010cGcrTFl1RENSdDdBNG5HdWJac0U1OW5lUFBOOGFTRmU1?=
 =?utf-8?B?YTZPV0lyNUE3WTVLbXRXajNRaE1BSzRQTDBVd2dBeWVhVEZiNENGVys0RFor?=
 =?utf-8?B?ODQxNjM3SUs1b2lidWhWcXZGT0tudXh4dkFEN2Z5a0VCVlE5VDZGSDU4SGdM?=
 =?utf-8?B?a2tpM3dTYUc2SGhYdDJzSWhOREVGTlNIUTRvUmlBdXhqQnF0dGNlQUhmdmNF?=
 =?utf-8?B?dlJDbHpMejNLWGpON28xeWloZXF5K04zSDdHd0xtMWZNQnRETWpwYWNQa3M5?=
 =?utf-8?B?WmRsSmQ3b3hCZmhtc3oya2lrdVBIbGxkSWQ3eXlVS2JsakhUYlFZN2p5cGVt?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fe02a8ab-d344-4570-df31-08dbf27b38d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 14:38:45.4569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eATsXZCludrwVVFmcB9ZLDHQciyMCw40A71CI7EtVmBBmdq3zZrrBXrPab0lO4gFZSjmpgjLwxKQIDmTRzS4UzCgLuq59kY+iBA9McY9BmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8696
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

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Thu, 30 Nov 2023 20:20:44 +0800

> On 2023/11/30 19:58, Alexander Lobakin wrote:
>> From: Yunsheng Lin <linyunsheng@huawei.com>
>> Date: Thu, 30 Nov 2023 16:46:11 +0800
>>
>>> On 2023/11/29 21:17, Alexander Lobakin wrote:
>>>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>>> Date: Wed, 29 Nov 2023 11:17:50 +0800
>>>>
>>>>> On 2023/11/27 22:32, Alexander Lobakin wrote:
>>>>>>
>>>>>> Chris, any thoughts on a global flag for skipping DMA syncs ladder?
>>>>>
>>>>> It seems there was one already in the past:
>>>>>
>>>>> https://lore.kernel.org/netdev/7c55a4d7-b4aa-25d4-1917-f6f355bd722e@arm.com/T/
>>>>
>>>> It addresses a different problem, meaningless indirect calls, while this
>>>> one addresses meaningless direct calls :>
>>>> When the above gets merged, we could combine these two into one global,
>>>> but Eric wasn't active with his patch and I remember there were some
>>>> problems, so I wouldn't count on that it will arrive soon.
>>>
>>> I went through the above patch, It seems to me that there was no
>>> fundamental problem that stopping us from implementing it in the dma
>>> layer basing on Eric' patch if Eric is no longer interested in working
>>> on a newer version?
>>
>> I'm somewhat interested in continuing working on Eric's patch, but not
>> now. Have some urgent projects to work on, I could take this in January
>> I guess...
>> This PP-specific shortcut was done earlier and gives good boosts. It
>> would be trivial to remove it together with the XSk shortcut once a
>> generic both indirect and direct call DMA shortcut lands.
>> Does this sounds good / justified enough? Or you and other
>> reviewers/maintainers would prefer to wait for the generic one without
>> taking this patch?
>>
> 
> I would prefer we could wait for the generic one as there is only about one
> month between now and january:)

Ok, let's do it this way. I'll try to revive Eric's idea soon and get it
taken if he doesn't mind :>

Thanks,
Olek
