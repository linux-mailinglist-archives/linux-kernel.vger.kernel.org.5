Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1837C723A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347307AbjJLQP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbjJLQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:15:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD9ED3;
        Thu, 12 Oct 2023 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697127323; x=1728663323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YkFSOMXuF9ja5TUAKVX7IE4mauDHB+WXBmx4yuDivt0=;
  b=Z9B2CBP62YBXFK0r60Ir/weahKIznTqfEGkbvCzdJwMiHToB8Uw4jyj0
   1hUrRk66mlfkcgMj//ipaChNsPgLeNMHwC+VkFUZWoRfU+tRzot8TYog8
   lUbTiAPUvMh86ETIUfFzEtJ39gcqSQiPWkco4BRak0gNRfELSo5pbS5Bg
   TG5E7jbMqmO9eehoU0UMGkE8MVaoAv/KcEIDDCUVBXCbvIF2c4XgBRtKS
   m+AlchMcMYZCriQE+xpr6g/R5P7Sxr0puSf7md9ipP/cXpvMa7xMXQBaT
   lGwxJtQZw5+AprEKgtylhunt5angDxOAwurwPkXobmijILsZhQikOKxtR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="364327345"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="364327345"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 09:15:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="747937363"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="747937363"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 09:15:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:15:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 09:15:21 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 09:15:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 09:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHJfQ7iKr3JUT9YCQfoKZHNs8kXWb83fZ+BQFuk/K6b4qMe9zlquuiNikQeZY9l5FkDk8DCLNzdBB6v7wXwpBELxCgpPyx7MXaGYnXaGOSfn9lGnCirf4GgYD6e6BtsDk4X66/8Tby3o7mP+5qIkZ6mGyj/7yHfKoIY+0T6jG17aWE19Ab5IWz6+ynCiSyc6VuAbyLa0anwDPsXRRIfBYXc3Qfha249Zgg3dWeTsMqZvSCv9F157jeywd4yfjx8NrbCLI3RIIMgp7WfQL98wGuwfGvWy18bfZpx5DjWG4ZlIG38zJXYtNo1P5cpt/sfZo26Dj6zYPD99fEdU6r0PNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEZMd/1klNeL+FeewCl2mM6lR8+nZGFaZCz7qYuU7d8=;
 b=JeEBH/e4Tm3gvXD5+27waE+/Z3/lsHPx+8fK4V52NIHkqitSlqipWlN+iV/8PQf/vxdwUtkZCxoX3t7RmI6PdT4UJ4XEFfh2mZ90FJfDmZuNJKTy8Z0coLuGn5WdAohfKwhya2cg8c36YG24O+YUoznAPUXdNoRtxurYemZO0V8+3BzqGd8vhVOpw+pbf/eyEtonIZIlxA7JMFRCUAb6py7iZqJk4ZZyAdK6OB10fdkpyjEwQPcI5+rjG5EQYfJG5dniBTgEI0OpF+96O76RXOditSzPsYj9p/Hi+6OapJDq6uQCVPoN9X0Dq6sd0KGPpd5mnYH40plsxu4R11Pi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BN9PR11MB5388.namprd11.prod.outlook.com (2603:10b6:408:11d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 16:15:17 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.046; Thu, 12 Oct 2023
 16:15:17 +0000
Message-ID: <1aed1362-ef56-43ff-858a-07c575b8f0ca@intel.com>
Date:   Thu, 12 Oct 2023 18:13:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michal Michalik <michal.michalik@intel.com>,
        <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        "Arkadiusz Kubalewski" <arkadiusz.kubalewski@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Milena Olech <milena.olech@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
 <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
 <8eaece43-a30d-45e8-9610-28ed2af842fc@infradead.org>
 <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <b5c1030a-9831-4580-8684-7c68f5888131@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0041.eurprd09.prod.outlook.com
 (2603:10a6:802:1::30) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BN9PR11MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d32de6-aa95-4dde-8e09-08dbcb3e6c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38eaMD4gQ7il+5DtQnjnVe/CgzOrzlQ/Ga62qTPMscYC/NwU4bvjKSJr87QeiLxeny/8YKbCLg2qtvhrHFSiz9a6eHj75nvuZDGdAkPj+tZsi9IInj6YD5q4VRo0+tQpxwiXRx3LVGsHWbny17uhyUZvaw+CLrD0KJnbkWpjquigsMX9aN9TJZkWDt2WktkQIGN7xKOw0+8iAxUkoxzyt0nFNLm2Agk7BA02+ZY+U8Tr7zfb8JMCsASsnY2+xaxXY5CWeodpzH60/vYWxEiSUdmYRXEYDO5yVPkF7CXzixpFThs/pM74ojlF9G3Gcxid2PKvxkq7eOq+elQaEEO3Q2678Tu7YcbgFC/+vrTjUs1ahLiehvah/U7TN44NJnUq6nXPHSmlZkPWcG/Cz74zmUe9NnJ2cRlxddljs0KBEU3/XU+lIu1GMRbHPLRMvrjyfNNchOk1v38XhNhjvVu2IKTz6rsKmhOh2o8Vii9cxqy7M8ycWHFqPpES8KpqitFQvPcTl+TCaXbIJ1FsocU3fjNF9QizJGdlgHL9xTrrawWrVWZPkXDuw0fqvrvLlxKb83PcbOhPt+QserUALqImzjO7ZZXJ1gkQLlDm11XbeoKccRBUcO7fqy3HxqZ4VOlR6b95eun/JIulnwTACEq2Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(6636002)(66946007)(66556008)(66476007)(54906003)(107886003)(316002)(83380400001)(110136005)(2616005)(5660300002)(478600001)(86362001)(31696002)(53546011)(6506007)(6666004)(8936002)(8676002)(4326008)(82960400001)(6486002)(966005)(31686004)(2906002)(38100700002)(36756003)(6512007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c285Y2hzTDhKVzB3dGwrdnlxcTRld05VdnkvY1ovR3hmUjlnc1NYT3NtdEtm?=
 =?utf-8?B?QnJmbmFCMy9vcmxlOFZYTHl6Q1FjZmNlbzJGK051VHJnMlNBc1dqN3BITlJz?=
 =?utf-8?B?SDRyOHFVb3pIbmRwKzUwaXBhWHVoVEdTOGRBNWxKaGpYaGR2Tnh6N2xPMkVt?=
 =?utf-8?B?OVBvckhXbjZ4a2M3VjI1Z1NWc0lZL2JKc0JaTUgrK2dvdTZHY2FtZUxiRFA4?=
 =?utf-8?B?c3QrSW0vSERKU2JyRzdteHFCTEdYdDBTR3UrenhCTGpTQkFhQmZTcUpPVUNW?=
 =?utf-8?B?MGRPN0FsWGpLNlQwT3RCVWI5aWt1bHVxdzk1TzlYVFU4aHlVZzdSb3RUVHg5?=
 =?utf-8?B?cFNkSzhiRGNkT3M4QjA1ZmwvTEt2ZVI4UFhUQS9oNFFmVlRTK3pMQmN4SnFl?=
 =?utf-8?B?ODJ6UkRaUkVVY001Qk0zazg1SEhZNUIzTVp0TlBhK21tVXFlU1lmWkNMd25q?=
 =?utf-8?B?YzYrNHRZYkw1bVlGdHVNdlB3MlFpQXhZcHp1S0pNZ3FmaEF1dnVSdmp1RmdZ?=
 =?utf-8?B?bk4xUlpJWkRUdjFNZXlSdXFvRDRFM1djbmFGYXVQTE8za01mS1ZaNkd5OFRI?=
 =?utf-8?B?WDZhUFhBUkVTZXcwQk92Y01DU1NzeGNiVDZ4Q0x0LzlyU1VmWkY1b213T25X?=
 =?utf-8?B?UXRBQ0taVGZZM3lBWGhuUU8rMENlL1gwTWd2RWw3YzdudHlaWFk5OUkzSW5y?=
 =?utf-8?B?ZU1JYWZQa09oeExLUmpiRVNNdENwUFVUUUdaMTU4dTJucmp6Y014WFhLUGRo?=
 =?utf-8?B?Rm5vaVp2VzBZNThseWtxYXhnTnVDalJRSURaTmtaVzNUS3p5QytTNmo5VXA2?=
 =?utf-8?B?N1djMFNDdUxubklEcEtqUk4rOEhrelJOdGNzYlRSeU4vb0pRSW9PSEVXL283?=
 =?utf-8?B?SHdOb2tJWWN0dUpuRXMzZnJqRWNXOEhXVFdodjN4OGlJNGpKVUVUMVV2UFRO?=
 =?utf-8?B?NjhIUHl3dmlINHBMSEttdks0d2FuVjFHZXp4eE9yVnJpbHNtU0I1empkazlX?=
 =?utf-8?B?TFoyREZJZkV5M3VFcEkxMjRyTWV3MjZVSnVIWlNBallIUTZGQ2hLOVZFZlRm?=
 =?utf-8?B?WUxadVpvVFkyS2ZhK3RNdDBBM2RLakVRdjBrbHJ6NUtmS2t3YnBRRStveWRV?=
 =?utf-8?B?eklSdllveEhVMHJoOW5lZklCSEhIZUZjQjUvVDJUMXFIRDRYRjE5Rnp5RlJV?=
 =?utf-8?B?UkxndndoYlFORk9mYm9yTDZYU1daQ0FsVFFLd0hITG1FVHk3T1B6N013T2kz?=
 =?utf-8?B?K2NvcWhWUU9tMVg2dHdDaVhlMi85SFhTWW9iUlY0aW9JQVJacnVFMmpIMzcw?=
 =?utf-8?B?eG94VXlCTzBnSms0OGh2cDY2UDBadzFhd0R1Vkp0bjh5WkV6TzQvejZTQVRO?=
 =?utf-8?B?dXJ1bGpXTDVRTHUzZ0w5a0tGaytVcFFOSGlnbFdadEhrTmpVTitMZDEwQ1Na?=
 =?utf-8?B?QTlKMkZCMnYzME9tRkdoUC95M0lMTTlCdm4wOE1US2JtQ3E5NmRrQlkrSmlL?=
 =?utf-8?B?RG8zMWo2eG50SEozTkNSOTdRMElYd2FZK2l4eU4rdmpUVHoxQzMrY3RTUVNL?=
 =?utf-8?B?YlJBcnJ0S0ZpZVovT2tPSjZ2dVBvcy83eXZjUFAxY1EvM04zNU9JcGU5eFds?=
 =?utf-8?B?cVZNWWJRWEp4UGI1amRSZTF6bTdsa0g0NVh1dkRZamdOdks1VUg3NkpTMFQz?=
 =?utf-8?B?UTBFdUpPUUczdGRjNkNyT3V6a2UraXA3Sy9sWWhoZ1NRcE85WHI2MHVFdlQ5?=
 =?utf-8?B?TTg5RXpVWmJwUU5ydUZFRFFVMEVUS25QT0R1MWs4OG01dUpwNWlLMGJhemtK?=
 =?utf-8?B?WjJYNGsrVmd6ZWpiMzV2TDAra21QUmRzL2tFZFVRYnlVSDJTbUJFa1JZYmlN?=
 =?utf-8?B?NXJ4b2FaV0lZNmxwVlZuYnREWmZjSDlUNkpIQU11dTlaandDYUdPWVUxeG1v?=
 =?utf-8?B?NzFGMUdweEY1QXFTWVFqaVRvVlN6Nm1aUmxnRXB0QW9aTE1XbTVvRTd6ZFlT?=
 =?utf-8?B?NEFveWp5NUczZjczVTlCcG9kT0VGcE5xblVDeFhwUFBaMGFESVZ1TFdBdlpV?=
 =?utf-8?B?bE91U29zbUR0TEc2TXY0SnFhU05oUW9UQU1IeHQ2MjdiTEhYZU5YUGloV0hi?=
 =?utf-8?B?MUhXbHRTeUQ1bHJlc0hJaVJQK3NHVlhleHp2K3N6bXM3WktaUno1REg3ODZ3?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d32de6-aa95-4dde-8e09-08dbcb3e6c24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 16:15:16.8808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAo7Wvz7oSioUM/XeYLek+7HbKeEjEqdIvUriox68SrMxJyoE8ERArvDwDeJhWkLJrc7HPtTrBkJKSZzZ3dYuEhZwR+LQjfrloaZJK2oRA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 12 Oct 2023 08:47:12 -0700

> Hi,
> 
> On 9/20/23 18:30, Randy Dunlap wrote:
>>
>>
>> On 9/20/23 17:04, Jacob Keller wrote:
>>>
>>>
>>> On 9/20/2023 2:30 PM, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 9/20/23 11:07, Alexander Lobakin wrote:
>>>>> When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
>>>>> the drivers using it may still be compiled (spotted by Randy):
>>>>>
>>>>> aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
>>>>> in function `idpf_rx_rsc.isra.0':
>>>>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
>>>>> undefined reference to `tcp_gro_complete'
>>>>>
>>>>> The drivers need to guard the calls to it manually.
>>>>> Return early from the RSC completion function if !CONFIG_INET, it won't
>>>>> work properly either way. This effectively makes it be compiled-out
>>>>> almost entirely on such builds.
>>>>>
>>>>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>>>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>>>> Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
>>>>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
>>>>
>>>> That builds for me.  Thanks.
>>>>
>>>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> I hope that these patches can be merged into the v6.6 instead of
>>>> v6.7 kernel at some point (i.e., [PATCH net] instead of net-next).
>>>>
>>>
>>> Did any of the offending code make it into 6.6? I thought all of this
>>> was from recent merges after 6.6 closed.
>>>
>>> Thanks,
>>> Jake
>>
>> Oh, I think that you are correct. Sorry about my comment.
>> Thanks.
>>
> 
> Even if this is just > v6.6 kernels (i.e., linux-next),
> it would be very good to get a fix merged for these build errors.
> I keep getting build errors in linux-next....

I don't know what happened, Tony dropped this commit from his tree due
to that we agreed yours (which optimizes out IPv6 code if it's not
enabled) is better, then Tony asked the netdev maintainers whether it
can be taken directly, but no updates since then.
I also asked Tony why he took my patch into his tree while I wrote under
the commit message that it should've been taken directly, also no replies :D
And all that for the bug that breaks linux-next build, meh.

> 
>>>
>>>>
>>>>> ---
>>>>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>>> index 6fa79898c42c..aa45afeb6496 100644
>>>>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>>>>> @@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
>>>>>  	if (unlikely(!(ipv4 ^ ipv6)))
>>>>>  		return -EINVAL;
>>>>>  
>>>>> +	if (!IS_ENABLED(CONFIG_INET))
>>>>> +		return 0;
>>>>> +
>>>>>  	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
>>>>>  	if (unlikely(rsc_segments == 1))
>>>>>  		return 0;
>>>>
>>
> 
> Thanks.

Thanks,
Olek
