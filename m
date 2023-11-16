Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B207EE2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbjKPOVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjKPOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:21:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2351C130;
        Thu, 16 Nov 2023 06:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700144505; x=1731680505;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sUO3Xxn1Xkrns4jPQSiMtj3EQd7PI9vIn2WIDpU5b6E=;
  b=nr5Yr/ROm80xON6SI/qj7R3HrkDdPhkZv5QCuv1R7hrSYofmWsGCfvGy
   oc9DiHNMMSVkp9483AuIAmm+QLStTTpWl0qJx4/zy5jJtPEJpZi9VVlpK
   +zuedELm1TCV6eQbkYFQMoyOs9Qwn84LKQLL2snU/Y4WQfokL+gtwiznL
   W/6cIQtcppzywM3gljtItTlaPh1zEpuLVwhVy2FwH8iVmoEWkXdOl+HNd
   ZkTrh5kvgh+Qo6HgDEl6MgjlsyjK4WS4/9296Hq0OtX9seAEXo2FbiHQA
   y88x+nvncGnccxOROdU/o/7Q92E0NzIRXOHf6LS+MnoPgFD2094AhTcA6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4177937"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="4177937"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:21:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="888929352"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="888929352"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 06:21:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:21:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:21:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 06:21:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 06:21:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3CTIHz2zDOnuZrldRCcvm9Te3AC30bIazpPM5WgloVkdnTms8gaLogzaB+V5iux8TPA3UMgO1SX82rOngO2r5xi/XUC14rwoJfpUn6ZppxHyngQtVZTQluRwmbAZ6fQdYlOSQ3v/1iBZpVTISrPhSsYRbM6LV7spXeT+K9EVrOc4UEnnsa28T75UxORCVj6QbWYBHiEdVV1DhxTJ7HgaTg13d9G16iBTNgSvHhsO56YwbAnNXoINTDiddSrbERUo/Z9zfzO11ANxEnWOz9G0lPPbwJUxAXe1cJj7H10orEegIYfUcPqxPD+bqXXNx2a9vqhppiOmrYcf9oiL3Lpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4EKsAkTGtTSCVZTr+MhJm4ol+llcQ/MeDN9KSXTt9I=;
 b=jFEDBwvzUqxq7HgCW4lsLiS/0PJGl1zI29640TuSi/slNXtCAFid9kBNgDvPD7i0iUZ3K6t2XJQZvN2k7rD0h8deAPcvTWaw9VTpMF2LkbaAXQ1+SIcXnwsNtHoKrDUdB8QkdhDSpt1z6H1JJQkNs8LQ1kQV2f4gEd4B2NvaIXFRmCtQDfCK8311339NGizbuAQFeDCyG1yisIH/7lU0lPt9npNkrd063Dn6tITrVoGB2GFY0Wgdh+HT2ruWKzc+ki1KrJIKKSJM3rr1evqAqGY8WHqpkxXKzSIZyujJFZPVD+J8lfJNwtQ5/3trl/J9a124eqCBOochLtcItAVnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB6772.namprd11.prod.outlook.com (2603:10b6:510:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 14:21:27 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 14:21:27 +0000
Message-ID: <f307b4f1-4dff-4925-829f-20459d25bdcf@intel.com>
Date:   Thu, 16 Nov 2023 15:21:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, <mschmidt@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-4-ivecera@redhat.com>
 <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
 <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
 <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
 <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <483acf53-fe96-4ef3-933a-c5fd446042f6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH7PR11MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd68347-b8f6-4b77-45fd-08dbe6af522f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUUfrOGIKbU8bzwEfqG0MUL1VZ9oZeb7vUo+FAFJRhP7BK2CNGq38Th0RtcJcoTOXHc3/bOLrmNev3JAm9hhZIdUFGqEIHEQDgS/GK7LIN/IrjNsd12DIiU0raLBs91fGAFSiD4jYmutDrR/+oespKItzOzfHSNtyiJR3IL5wQkuhorlTiZpqhq1hf884GG4ZpuNbu3vCd4rO7BcDLDCbbT1rUQ5Krw/cbw18JiA+TQ7mFiqBQckQnd9EhSpwv2re663Od+wIZA2q6k48e3nuRThgliMBP6iKuuXw0zzlhTkDuMchxKU2PqKvOxOx1IHS9mn6/iUnr8nRJmsXX8y0WDYThugsafGMejVZGA4YrQqGRmgAhvHcMvzhs2IcqnDAcdwks/Gsfg+zrrALRjHLmQE7FapsGOAVMcZrsBSqZlZlF1AxtKUKXnzJLyBz+NX3RFQr3T8FSB/4D2kXHnO3vFqpy6OdftvRSIEwR/26hZP0ioC6HXp1IYqSrSSjdQGGWGhlVM5JmN39Bb03JVwBn9GW77eXWxitLMz0Guv5XOxHJzu9kZY4roxCxchwcjQ1TrZT3hDPUmqe7ishxHr8gi9OqmhNUPi4TbTHJ2AsPun4Sgonu0SqXWrtb/QYouZt8slC6sQRJ9X2v0bfzXs1Wq0iWlj7qK6bcqLHi04Xyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(478600001)(6486002)(2616005)(6666004)(82960400001)(26005)(38100700002)(31696002)(44832011)(66946007)(66556008)(66476007)(54906003)(316002)(4326008)(8676002)(8936002)(36756003)(41300700001)(2906002)(5660300002)(86362001)(31686004)(53546011)(7416002)(6506007)(6512007)(37363002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVlQzdSNUJSeXBLR3MvcTdzSVpYSGNqakN4d1NlU0lsSFJwaDdFaWpsVGNl?=
 =?utf-8?B?elRMR1R6MEY3SE56UkE5dCtDa0VDUFNCY3NDS09Wa1ErR01XSVl3anRrUjla?=
 =?utf-8?B?VnhCaFpvRFZpYkxUTm4xQlVWaHJKdEtHV2FjV1A5QW0xMmZ2UmNZbjB0akpT?=
 =?utf-8?B?TGdOVzRPQVltQTJGSGNpWDdQTTZFT0pmTk5nVDBzcjlxbGg5SDhHSS9JWUI1?=
 =?utf-8?B?MFZVQkdmbnpOc3V6Ykh0eUcveG45b0oxOGFKWlNnQmg3dHJFMUFQRVlQajAz?=
 =?utf-8?B?eDZhMmhxQUxsY1VWT25RY1VHdTJXbFRPM1ZXaTU5WVlPRVA5YU5JWEY0S1p1?=
 =?utf-8?B?R2xSSUNqUzdVdTlkNmdocCsxYWRSUTJUYjIzc1U3L0JmSFNPK0plOXRUUWVh?=
 =?utf-8?B?MmcwSWxha3locmMzT1ZxdlhDZk5XZi9rU0ZtM2FPNkVjSzNZQnAyb29KUWxJ?=
 =?utf-8?B?R3J5RG5nVDh0MCtENmJ4ZDVUbnBIMzlmWWgrM1Y2a3B0eDZRM2ltRml0VXlq?=
 =?utf-8?B?QnNHaVR1RE5abGFrbVpIek1BWFozNjRORGY2NzRaVlljeU1RdmFmVVNLYldm?=
 =?utf-8?B?N2Rpa2tRdnd2V1BZTEt3dVhQTmZpSittN0NJNXl0bmc5dXNJSGpyQnZ4T3VJ?=
 =?utf-8?B?SGJKM08wQUtQTUhjS3R6dFJWSitrVnNxNFBFZGcyQnIzeHQzdzhoTlJsRzdM?=
 =?utf-8?B?bXFwRDRZdmxpK2c3QjVOcCtHZUhvTktCdGRaODhrYVNUWEN1d094eGEwK2sv?=
 =?utf-8?B?WXBhYTBTZ3MzNTBWbDJHUStoQ1UxY29kai9JaWtWcC8xTTJYTDdtWWNMMW9N?=
 =?utf-8?B?ZTZYOFpCaFdMOXN0T1c1bVdwUUJBUS9kQ1NJOVdmeXdzd29wSFB3bk1Oazgz?=
 =?utf-8?B?Q3N1Rlk1SStzaEtiRjJaRFVLOWJqUXJvS2JZQnRoMnkrajE5Z1JFcUh0MlZV?=
 =?utf-8?B?UGhvUW0vbWhlZW5HU3ZZNW8zYmRGLzFKZXNvWUxNYlFJbVFnRFVEb01UcHZG?=
 =?utf-8?B?dVZTNnc0VVFndGpxRWd5bkp1S1I0RWN6NHBpdzBpNmd6T2cvM0k2NnhRWUZq?=
 =?utf-8?B?OUJPZ1R6aXM5bzRjeVY4MTNCOUpmNG03KzREdXRJOGFTNDZjbzNHbHJkT2pW?=
 =?utf-8?B?UGdDbW1zUUFmdWJOa1NzeXY0R3MwZEhnQmN5bXNrSjlYTUFYT3EvRUdOQ25j?=
 =?utf-8?B?STIveTFzR1dzSUFiWnk5OGJBSkc1WllLcDZtclpwZXZqL2JsTE9DS3dPTENh?=
 =?utf-8?B?Ykx0aEpJVW13QW5jcWM2ZVlPdWNvb1dhNXBRTmtiTStBaGdBakk0U1lxU2JB?=
 =?utf-8?B?NE1tRXRIOU5aaHdrckdxaEhJY0JvS0Y1dHBpV1JVMHdxejZyVTFXMzArRGIy?=
 =?utf-8?B?SmdOZGFxTzdjV0l1NjE0UjJDRUU2cXp3VTltQXgwWnlUakxjaEFpZ1JlU3JB?=
 =?utf-8?B?bzBSZmpIOVhvYjFsaE1OZ1UvZVI4MktCdE16RkxiSzBNeGIzS0dJejFIRDFM?=
 =?utf-8?B?MjJVYXZWV0cvWWQrNktBYi9rRldFMTZER1lQZDFVSk5WNDEwNFh5QzBseURv?=
 =?utf-8?B?VjIzdWZtZ1RlcUpYeG5HUzUwQjd2NFBWWWZCRHRGR01aQ25sL0ZPZXN3Y0tP?=
 =?utf-8?B?bWZpOWxBZ09RYzVUMU9rcURjUU8ybFhGYkdqU2dvb0ZvdmNKczk4Qlk0UndT?=
 =?utf-8?B?b1JoS250eWNBa2Q2QzZoL2NyQkhPbTRqVjB0Rld2YlFyNUtOMjVGUSs2OCsz?=
 =?utf-8?B?aGRIT2tmTmtwYTgxWlJjZ0RDa21zWk5OQXBVY3R3RDQ3N2NoYU92N3UxamRW?=
 =?utf-8?B?WElacFNubmRkT0dLOUh3enhvcEFjUDY0MlRGOVJMT0ZJSmVzVXk0RWxCN21a?=
 =?utf-8?B?aVNiOFJ1R3VVWWtYTXlXWVUwQXZUeHZJcDNvQ3kwOHV5MFovOFlkVmY1Snc1?=
 =?utf-8?B?TThpUVFiU1dpbGdrbHEwTEwwRWtPSThxK3Mwc1dXcjY4MHRJcEVqMWNHWnlX?=
 =?utf-8?B?QUxNM1FQN0pDa3ZpUTZUR2ZmVnhkbUVGM0ZjOTJqaHpzWlZTcmo3L0ROUkY2?=
 =?utf-8?B?blV5TUVYUjZGM0FVOEVnTGl1K1ZnanZmc2kwS3Z6V1NHOUdmdG9hVnMwVGhK?=
 =?utf-8?B?a2RrM1JVc0NDVjRmbHJsWEs4d2hwQmJlTnE0ekRhT1N0NHgyT3Z5M3puUTE3?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd68347-b8f6-4b77-45fd-08dbe6af522f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:21:27.6743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8S96/42WwalFzHrEZJyxgfZk4cHxbGYS/HHCnfYp/tE/VIKlhnssdiLafIlKW9I/rT8sq3FDgjJiJPpwztH+M57FSdJpZxknmMz7VJM4lfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.11.2023 14:59, Ivan Vecera wrote:
> 
> On 16. 11. 23 13:37, Wojciech Drewek wrote:
>>
>>
>> On 15.11.2023 18:01, Ivan Vecera wrote:
>>>
>>> On 13. 11. 23 14:27, Wojciech Drewek wrote:
>>>>
>>>> On 13.11.2023 13:58, Ivan Vecera wrote:
>>>>> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
>>>>> VEB or VSI by their SEID value and use these helpers to replace
>>>>> existing open-coded loops.
>>>>>
>>>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>>>>> ---
>>>> Only one nit
>>>> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
>>>>
>>>>>    drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
>>>>>    .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
>>>>>    drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
>>>>>    3 files changed, 64 insertions(+), 84 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> index 1e9266de270b..220b5ce31519 100644
>>>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>>>> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>>>>>      struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>>>>>    +/**
>>>>> + * i40e_vsi_get_by_seid - find VSI by SEID
>>>>> + * @pf: pointer to a PF
>>>>> + **/
>>>>> +static inline struct i40e_vsi *
>>>>> +i40e_vsi_get_by_seid(struct i40e_pf *pf, u16 seid)
>>>>> +{
>>>>> +    struct i40e_vsi *vsi;
>>>>> +    int i;
>>>>> +
>>>>> +    i40e_pf_for_each_vsi(pf, i, vsi)
>>>>> +        if (vsi->seid == seid)
>>>>> +            return vsi;
>>>>> +
>>>>> +    return NULL;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * i40e_veb_get_by_seid - find VEB by SEID
>>>>> + * @pf: pointer to a PF
>>>>> + **/
>>>>> +static inline struct i40e_veb *
>>>>> +i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
>>>>> +{
>>>>> +    struct i40e_veb *veb;
>>>>> +    int i;
>>>>> +
>>>>> +    i40e_pf_for_each_veb(pf, i, veb)
>>>>> +        if (veb->seid == seid)
>>>>> +            return veb;
>>>>> +
>>>>> +    return NULL;
>>>>> +}
>>>> I would prefer i40e_get_{veb|vsi}_by_seid but it's my opinion.
>>>
>>> I'd rather use i40e_pf_ prefix...
>>>
>>> What about i40e_pf_get_vsi_by_seid() and i40e_pf_get_veb_by_seid() ?
>>
>> Sounds good, my point was that I prefer to have "get" before "{veb|vsi}"
> 
> OK, got it... Will repost v2 with this change + "too many also..." issue ;-)

Thanks

> 
> Btw. what about the last patch?

Reviewed :)

> 
> Ivan
> 
