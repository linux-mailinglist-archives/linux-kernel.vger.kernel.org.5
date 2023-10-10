Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335007C0303
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbjJJRvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjJJRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:51:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC794;
        Tue, 10 Oct 2023 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696960296; x=1728496296;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MpBs7Dz38TnRVCwBYGnGGLz6w3ZLg7OwfX4AcGdFQW0=;
  b=QAO/eEgwcWHjn7GpYBxNXkPzPmyKx7pa5ID5hNMhS4/BiYgWYskWhf4G
   JRBBdNRgm0RN5xdZiQ0ulHM4Vk4kEoRDoePRSrEG5hpouxYTWKxbwRu9u
   0ljiDeiwxs8uDpb2D9v/W2ZuXtmp5wyKuJ7T3sxDg5gMz840i9R/5TTne
   zbz7E9S9WT6tA67AG2DaMD5uhnGK0ggdqQ57Em4p3ILJsjRoeMe1ZUKAw
   0MLu7+1aMZTMZE/hA6Yp7j+kPgdfOUqW6mW3qgk35NS7uP6ltpJDxrDfh
   6VBxImi5ENp3rNY9ZEHLmBkpOOmDyYL0jrE13ZGVmkBvlBdNKhufdgjba
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415495456"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="415495456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 10:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="844226172"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="844226172"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 10:50:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 10:50:28 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 10:50:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 10:50:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 10:50:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUB/cHVvRvRUK2oHMstux+WbY5Y1ddDFXGvpLXNY83IuBcmu3nD5NwjgsYVyzV/BhQPe09so1S4/ASgs3qbZNqtl7K9tkBdA/opTVD1ZRov8wkR4+i3gbTfoJYtIL8MCUkbnls0HEY6aXQAtJb3s4pvQCMkcYtLsldLHMoG8FpRMjIoV6tvH6zG67SgqHa1syL3PR3kW5qeyyQeMYa1g5ykeFaYMKNgANS4B/ABwhYruB8rgShqFUjjUs9xn9gbGzOugvkU3dd4GBFWIV34k+dwbPFDhPn4qQaFlFgPYmhkizMDR12kWQcm9KOmbeJFDDTV45UKX2tV3dTzdnyhc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r2xYgaagqcFXUremgGZ1V7n9kTsXs/oPKUCrlzLVJs=;
 b=U/vTX285wEfp+YUNhhIdWRrTTjRfocGqsyqmawWFv3T8Y1FqHf1CdztkD+2ZK8sh4vlpM+KfTxLoMBY763F0lZlPzJlODoMjmjijoN/rcewmBCbGa73lt4k1wgXXL1fNOFUQ7suw0XfUEuhcFBpquOTd1wFaADGL3wvYnSfHQ4XiRfEOPst7WSsmJBzXAmB6pTH0rg2D0XamcOqFbWg62JXxm1irK9cHfnf5aPzGfp862LmWv4P780CCH1mkQBqud5lRjiVxsV6yyqxcyrFI4lQslunwCNPXxgVRI2/w13LpDxXmkpC7fd4qP8mXtFoamFcW8PWey4VJRAtWX6RG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CO6PR11MB5667.namprd11.prod.outlook.com (2603:10b6:5:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 17:50:24 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 17:50:24 +0000
Message-ID: <476acf0a-afdf-455d-a127-320109604ce7@intel.com>
Date:   Tue, 10 Oct 2023 19:49:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/6] page_pool: fragment API support for
 32-bit arch with 64-bit DMA
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Liang Chen" <liangchen.linux@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>
References: <20230922091138.18014-1-linyunsheng@huawei.com>
 <20230922091138.18014-2-linyunsheng@huawei.com>
 <b70b44bec789b60a99c18e43f6270f9c48e3d704.camel@redhat.com>
 <20231003151216.1a3d6901@kernel.org>
 <c2ef79ea-468e-ce25-a597-cc1684389143@intel.com>
 <943e7a57-1285-4123-578c-1bb8d1a926c4@huawei.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <943e7a57-1285-4123-578c-1bb8d1a926c4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CO6PR11MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b38215d-7b2c-4dbc-145e-08dbc9b9608c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70jrwL7CoQhvrpUQeNumMh6ceFZ//edGX3/spmMGtxln+F2SKWogFVcPhDLwN7s0WKbPBSIyuI0/ZWgJO98LSHrQGsi+xEFNi20qbSAa//PnXt1thUbi9KyJ/SqGZ0RfrUTUeezZ3DAnLvEv/Kd9x51lDpaK920auO9ffvOU3OwYuGVbsP53/YV29ud1u6JupA1PeRvkrBQm4e4DiXH0eAsqeykIMtqLiZXScvegAURFQCLABf8WrzfaUODhGIqOgV4dqyLQNPj74pWR6Q8mUgbtF5aSYq5h6PVhPG3a8LQShGXUaOAHeMizflhH1bJK6YDkGXXhyPzokmbucJ4tvJLoU/baqmnaVhxOtUUUXuc1Jkw8G91fcUevWrdpC+KaaRJVDHe2CQspPUpcujPd9JN4bjnH2N+VaxSeT0RqjihrGU32RovCCxOETGt1yoX6JwzOhZ+kc1YtIdhToaonmXCgKg76eRz026U3lD6hfiQ2bZqD036DvJ1HQPr2chF3i8sgYccmsEo6xct++9sCuKhkUDSEBYw/xhZonKfGoJVNJYgYXOg7j4nx/l1zSK4L4wHEDJy4BXEjI3GVpGapkB7jv5oZCg39wKH+hVh5enX6BHZLZZlB/CgG/3tmHRxDRTQZYSOWnsDH+vIweSyI5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(2616005)(83380400001)(26005)(66556008)(66476007)(316002)(6916009)(7416002)(54906003)(66946007)(4326008)(53546011)(8936002)(6666004)(5660300002)(8676002)(6512007)(41300700001)(6506007)(6486002)(478600001)(966005)(36756003)(86362001)(31696002)(38100700002)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDhlcU9JKzdqN2JweWVkQUEzbjc4Uko5WFZ5UjVqdUp5WUJYclZhdkNOUUZC?=
 =?utf-8?B?Z3hYS2g4dkxaM2piWG5oL0xMQUc4SlNBZnFpZjI0WklBNERyODRLSDJpM0Zk?=
 =?utf-8?B?QnExOGNOUXJYUmRua1JnVTcvdUFNSGl4cEw1cDJJQklmN05HblpZR2RXWDNR?=
 =?utf-8?B?Z1pJKzgwRzhhVHVWKy84Q0JvVEkyTEdWM2lJaEUyL0FUSGdNTEdUUXM1S05y?=
 =?utf-8?B?N1lVMDZMY3FZMHY3cFpqN0V3ZkV6R0YrUE1JbDQvZUF4MlVLeDl5Wk81ZFNY?=
 =?utf-8?B?VTIrc1ZvQmFaQmFJekVqUW1SaGVSVVRrY1JBZ2xBYnRVS1o0UEdVclVXazJC?=
 =?utf-8?B?Zi84dit2dmRjR0tNaFBwa2UvdjVQZlZXUjFZWC80VkVXRWVVUkhtRmxtVXVq?=
 =?utf-8?B?UmhDVmw4SXlmQUZDNklRQXV0dVl4T25WUTJQa3g2c3N0aDV4UTUrV056SGZ2?=
 =?utf-8?B?UWI4R3Q5MzU4OUZvbmxCblBRMStFYTlvbmVyMEREbG1zUnhjU3BuV0dkZUZK?=
 =?utf-8?B?NzZUOTdpREZFUkhJV0VHYmF1b1NQdTh0VTJrMTEvVjRvNDU2bjVxamprMXpL?=
 =?utf-8?B?RlNFRjhUWG15bzkraDBoZktBbG5OVEd4VVJxM0d0SnVIck5WU1drUG04SHdE?=
 =?utf-8?B?OGw5N1QzZzQzMldDWnhhWG5EUW9hYkZaNFlLRzNERXhiQWhpb0FxTk9PNnNs?=
 =?utf-8?B?cGJENTJlOGVKOVJwYUdqTldwRVk5eUNvODI1ODBMMXFJVVcxV0ZSNnpxZTBI?=
 =?utf-8?B?NmY2ak1GU0tCL3JuRE1qR3VhTVg4RUYrQUlweVFtL0xRUXI1eEFtQ1hmNHZm?=
 =?utf-8?B?WUgzdDBEY01NbWsvMjlNWXZQbGlvY1BJK0JXMThJc3dkYXBtSGVUeWQvT25a?=
 =?utf-8?B?R0dtYkU2OHdUclRJd2x1b3NPZ0R3L1BsTXFrS2tNOVQ4M2swUEdOOG95aUFM?=
 =?utf-8?B?d0p2VmRzWFFDOXVrR0hsZWVYN2lXTklPZS9HcXo3clRmdTMrZVNkaWxpNHpZ?=
 =?utf-8?B?VjM2Z2Q0VFNMcFFPZExURlFiL3ZBUGorblZVdkN2VUhsdXVoUTVvbXZEc3dq?=
 =?utf-8?B?OWoxanFJU2JuU3lVMEp4c2RydnkrMm1sc0IwSGJoMksrT2k2RkRKaTZ1U3Vl?=
 =?utf-8?B?NTdyd1RyS2VNMjZacXViaHplZlM5V2M4clFnVGNYSHl4STZYNmx1MzJvOTB6?=
 =?utf-8?B?ZTJUVVllM09SakFhbGQrWVRFYTlFMGx2SE0rSUVXRmRMZzJ5bFMrVStjbjU5?=
 =?utf-8?B?WlVNWENMZi8vL25YZnVHa0hVOFpRaGJFZkFYSnZlNkVyeHJzMmpJa0s5aWs0?=
 =?utf-8?B?QlRRTElSQ2Zud1JlcnVvb0FOUWx6U1dhelk2UTUyWm1INVcxU1k3Rkl2TE9X?=
 =?utf-8?B?QVJMTDd3cnYwRW1yeWNIbk5nV3FST1dSdFFtbDE3MW9aWG03cmxUZ1hlaVhy?=
 =?utf-8?B?dWdqWVFnVDFoRXRFVWo4TUtnMERaajhMWFFoVWw4WXNyQUgwZkxnQjVtdlNN?=
 =?utf-8?B?U0I3ZTErR3ZEZ1VHdVlmMExlK2NmNzBsMVZ3S0J2UmFibFN6dUZnYnJQM0JO?=
 =?utf-8?B?T2M3Ky9CaXdWNDl2dEVsVVMrQ1RtLzdkdW5mbDl6akpHVVg4Nm1ZNWs3aUND?=
 =?utf-8?B?ekx2YytGb25GS2pEU1BPUDZGTXZJdGg5dVRndVpKbHN5Zy9TZ21WYTVJR29n?=
 =?utf-8?B?NkdML2I4TFFIMndWbUxBWGpGODBha0lpL01XWUp5WnVEUXFxbENnNkwzV0tt?=
 =?utf-8?B?M2ZjdnVUNUFTQ0J0TmNJY09kYjNVOHgzZHNJTVdrY0krUFNFTC9RSWdQQ0Mz?=
 =?utf-8?B?cVN4TGFha1hCd05hUXdrRGlKS2lVTVN1Z0MzT25BTmxNeG9HQ1NqNkpjb0xK?=
 =?utf-8?B?dUw1OWtRSXlhQVkrb0FhaUgyaVlvKzVza0JWK3lrYzFTOGovNUxzcTkvek9j?=
 =?utf-8?B?Q2ZCWlJtU2JvY0hHSjQ3bmxlME14U3JXL3JYTEhiR0ZaWUhQRzVSdHlWdGtz?=
 =?utf-8?B?SGZISzB5THAraVBYNWFHM3ZYSXI3Y05QQVhpR0RHQUxaL0hBUm1SQmZXSm1z?=
 =?utf-8?B?d01LQ2V3cSs0M2NNV2gySmp2dlhuaGxZWTZBRmQ0TFJ0dXpUVWR0ZzJDNHRj?=
 =?utf-8?B?OVdCdWhNNWIyaXc2ZGpOeWNFN1JUZHZCd09Ua1lvV3Z0Vmg4THJNcExaNW16?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b38215d-7b2c-4dbc-145e-08dbc9b9608c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:50:23.2356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdhrE+U12FU6Mt4WF0DT4Q7PKnJ1hXG7ytpY3OPsvs4nrSplD5LNvJz2/SQdiUNlCBQxtTm6A4zgmwMJuGScoGdiSOopv/EmdJOXpIt0kL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sun, 8 Oct 2023 17:36:59 +0800

> On 2023/10/4 17:31, Alexander Lobakin wrote:
>> From: Jakub Kicinski <kuba@kernel.org>
>> Date: Tue, 3 Oct 2023 15:12:16 -0700
>>
>>> On Tue, 03 Oct 2023 09:45:56 +0200 Paolo Abeni wrote:
>>>> I think it would be nice also an explicit ack from Jesper and/or Ilias.
>>>
>>> Also a review tag from one or both of the Alexanders would be great!
>>
>> I got back to libie/iavf this week, hoping I'll rebase without major
>> issues and will be able to give a Tested-by as well, will see :>
>>
> 
> It is great to have some Tested-by tag to confirm that this patchset
> works for other driver. Please let me know if there is any problem when
> rebasing and testing, thanks.

IAVF with PP on the latest net-next from [0]:

Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Still some stuff on my side to fix/improve before submitting a new
revision of libie / PP for IAVF, but at least the current code works
just as expected.

> 
> 
>> Thanks,
>> Olek
>>
>> .
>>

[0] https://github.com/alobakin/linux/commits/iavf-pp-frag

Thanks,
Olek
