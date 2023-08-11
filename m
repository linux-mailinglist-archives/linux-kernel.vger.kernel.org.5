Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97C4779610
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbjHKR1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHKR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:27:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61930C1;
        Fri, 11 Aug 2023 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691774830; x=1723310830;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1raeBTPSVvDjRXWLp9DACnDvpid5/Ja89KV4WMOz0K4=;
  b=cfYeUB/BJHqYKzx5FR5fJN/fAaOv1n1ZEF+FrSNf0FEpyCix0pDd/obM
   Hw2iEVUMUjxmMg7XjZfGD5Miw8ykwr5B3bt8TmN92zIhUMraOxWJjq7DI
   XhQQQrXOINTFNfUzPrv3xd1mO5u8ukaqOfC8VM3Jc6cGYVYcRmHySmJIP
   qsmmH7VIERVQWydFbruD8cIHc3m2TEk8SA0b/KJkpoCsfoVfLvU/ZHm3M
   F+jCrR5E8hW3QX14unchdWz9MRbLWxtsyShJkzp1qeZAwoxd2m0J+ajDS
   X7UDW04NYq09krm5wGp2EUfKBwS/Puc9dCUuX5wDDl5N7KvAKD86ghT9P
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="402698400"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="402698400"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:27:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="735851908"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="735851908"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 10:27:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:27:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 10:27:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 10:27:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 10:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=logARSYI32uKsovq+1OHiPlv4HIxXws3sgtMW2YC2sI2Qw7Nrxvkdlie9bKnwzaDvKyd8D9OPv7kmRkHYyNIV/M20EASWGVnQxzgE5FtpTVhFPW0NBvafg+05GTBXGaXY3+oretKGnJlSp5DRMqUb4zJfQKgEeJjuaSEZA1/qYJuoj+/9OC+febtBZ87yKtC4C7mK4WThBOpYIx8ZVR10KdB02NhUGQoYWUsQzErAvzY3bn65n4Q/oZEu7Tnz3IU1lQLrcFo92dxck2SYxucUmWykL5XG3XDyDaQy4EA/hLaCGoEh6m3R5M1wJkeGpPWHRAx/WjqQiqB7H1eAbP0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7P1Gz6Hv3+dCpOI2OxxzWor9uCpCimD4NLFHEIjljw=;
 b=KHEjjvd7DX5DXQ0sN7Q5jLQh7DEXm8GFIVUCZOh6kDDfOOfGfoC3/JFJK18N1TGclB3ySW+wcW9oBTr+N+1OaUyKBWT9BkrjcqUCBkYaNeMWGc+cp8b9ebf00VyEGl7nrKR8pWkPHnPQmxResIDUqaF5KGgRsUI8paR2xMRiDCaOXMiccLbKYwIRtDSndb2SEcB4tOus1uSzwkHu8Zq19NPhzFKhrVz+3PEEqjqv7gvT4C71vaCPqMIiqCtENXhh4IEX2yOgAem16UN1DRZkufIW6f5ynTw+6++JYlewr1VR8H4VjgRKUFFCo54LDx2AI2/vgrsUtDx70X8Aaefahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by LV8PR11MB8606.namprd11.prod.outlook.com (2603:10b6:408:1f7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:27:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:27:07 +0000
Message-ID: <e350514e-76ed-14ea-3e74-c0852658182f@intel.com>
Date:   Fri, 11 Aug 2023 10:27:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 0/7] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230722190740.326190-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|LV8PR11MB8606:EE_
X-MS-Office365-Filtering-Correlation-Id: 326015c8-90cf-4d7b-491a-08db9a902fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dSVWtjuAS36Yi5iT2+qgMoK6hUPGOIWQLjHWRzpgpUEZkIYqzd7oLU6vhqStCRYpahhQfBDoy725R8PlpeZJuqlA2jrPuJ0L1QuFkFXR57mhw4lGDgB5xQ2L1vwVjv646KrHA30GnlpHcS9L/dRuxmRZOcl4McgcgPt0Bw/zZSrGBGOMDXhaOwfH7yyw8eyuDXWHMxIrjz5BMRzGDRKOvo+o+2L0E5UlmljeVvImb64muLT+g9huL8uZ13RD+h4GQNZG7DhyNH85yv5y3nvVlVzkix6O2ShtmiPWpyXVLrtOwWP88BEEM0oUWIpXigIrlQ6vlrxetYQNhHFL4fza0nUav7DdiEZrOjHobvszwyU/NmuBuMFzWw8bttOcaq4hMENnOe2GomF0Oe0aoLQ9OUQV2beoz+3XYPQVBivCjcRNUwNB1bxiqW0aglZOuqQK4lUaeSnjsVV2TFHZf55HA/zfZL1ofj3Lv4utrSMT3YljsiyDdz7WGOPRwyW5zEA2N1mnu0xTddFwXVjsgsCkR82TxEHBjpCE6NSA9CDTsVTve+gljHIzAphC+Zbq1fIcG96XiRBG/zkoIIIvS9bZ22VBuDGm8+3TLeT5Q2sGqIRSDiaCiD1k5WtHw+PLkTJIPikyFRNRye8OuhVN7UlM1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(186006)(1800799006)(2616005)(478600001)(44832011)(31696002)(86362001)(6512007)(4744005)(36756003)(2906002)(6666004)(6486002)(7416002)(6506007)(26005)(53546011)(83380400001)(54906003)(316002)(66556008)(31686004)(66476007)(38100700002)(4326008)(66946007)(41300700001)(5660300002)(110136005)(8936002)(8676002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjM5aWZRLzlvMmFIZkJ0MHNiL0ZXdGdzZWVSdGRsN3VYOHc2VFpNS0xkd0x1?=
 =?utf-8?B?bHlObFcxbnpLb0c3VUJZdEdLdml1Z1MvRzZjRXBKTUo1YTB3OXJaUVZkWlpJ?=
 =?utf-8?B?WlZzM0gzZFpqeUpFS1N1Y2FkTjdoZjFWeXkwSDFGYThBK1lBT24vTDhOQUpj?=
 =?utf-8?B?YUxxQ01YeGxnenUzREtoN0p6cTFxOHNKYkZWYkFwaWRvWUtmek5uWko2RnZW?=
 =?utf-8?B?MlhHdjYzMUxsM0pLNE9BUGZPYWw5WlZTUXhoSUxuOVpFek9NdkZQSEQ5eit3?=
 =?utf-8?B?a0dGMTBneFJBanRGczZianpCbmgzM3J2czI0SmxxejFxbzNPSHBRNlRhOVRn?=
 =?utf-8?B?eU5PVGRuRFZBNzB6dzJuYTNZOHhBdjExTXFNQzg4dG4vcW5IWFlZekVYRHM2?=
 =?utf-8?B?Z25lZDRObVppQjF5SUlWeDhJY01VOTNVbnJ4OXF3SFc3WjF3T0ZpNm5ERWRw?=
 =?utf-8?B?eFdja2tlWkdxb3M1MFVJQ2lNYVF1YjA1d0ZvRCt3L21kMjNGTFgzcVhOYmk4?=
 =?utf-8?B?Z0Zjd2gvSDluNlc2VWFBdE9KSDJjbnByS0FTczJpMXhsV01scHhMTjVXQW1t?=
 =?utf-8?B?ZmI4UFlLcDFKZDAweXdZRHVMQk1HSGxEcUtJV0xhS0I2V3lLSTEyMW9jNWd2?=
 =?utf-8?B?YXhaOE0xSHFpeW4ydFFmaVpSNHVYSGVOUzQ0RzVLOXRVQjE5VGdwV1lqWnZS?=
 =?utf-8?B?TDZIUTc1YitiOCtHK01nQWxFeGYydG1GclZJZlNXd0twSThlU1J5NFRqWml2?=
 =?utf-8?B?VXZZQjRGWTNNSU1mTmJONENqWDdpUWJZQkorMStaaTdwcWNRS0txMkpYVGQ5?=
 =?utf-8?B?cE1PQmtYM1RCM3BKM2M4cHJPRVFqMDF4eldBeE5hWjRJWEZzaGlnQkR5UVF4?=
 =?utf-8?B?amdqVVo1eWxJd1ViL25EcDhGWG1NUU9wclJRN20wVkRhQWNZZzVDLzdGaWlk?=
 =?utf-8?B?NGxNYms3R0NTZVBuWUdseGhtMU1rZkhwd1I0bndGdjFkNmV4MGpIS0puakw2?=
 =?utf-8?B?RTliZWRBMWJGVEJkcG5aeU1tdkFxQzhMOXNiZ3N3dldRdkhQOTJLMEt5SmNk?=
 =?utf-8?B?MjVnVHFUZGRFaGU2MzVzVGtzMU9JR2k2aFNYSVBCZnhNU2dTVTNhQ3MycmN2?=
 =?utf-8?B?azFDTVYzcEtVZmVMNEkrcHlFYlZTdkw2bUpzSjJRdmYyTDk5MWl4TlpTMnpD?=
 =?utf-8?B?aWh0N0lXWG5zUmtxVWRxTWljeHhRNzBTNXEzSjdoWDFQM2UzQ0c1eTlnN3pT?=
 =?utf-8?B?TWpDS3hHbnA5eDEwWmlWQXRXQllnbFEyQmt5RFFWb0dQTEZBRWkySUdheWNQ?=
 =?utf-8?B?dUxGNTRueFJIZURWUjV6WUI0enBGazFVOStOYmVCaThMbStGQ2NsOW9ubWVL?=
 =?utf-8?B?RnZOZlpIZ3NkdVZtSm1Yb2dLK1hvcnpWM1RNdlJIWUpMQk9JcUlPQWtqVW8y?=
 =?utf-8?B?WlhwL28xNkQzdDdmVTFZVFBxSGo2R3VldlUyTFg3dzg3SmVLL1lrTmdvQXRm?=
 =?utf-8?B?em5kdm52WkU3c3h6bS84OHF3cFZLVUdHUE0rcFNZQ3NzNjdQaWZXa1pvS2k1?=
 =?utf-8?B?UXJML3pZbndnU21PS2VCT1ExOHpkc0hON0ZjRFRwb1k2OFRYZkp3eG5oVjNL?=
 =?utf-8?B?alM1VlJ5a044MlFCd0JUZm4wWlRSdGd3WURpdzFKL1lvZDd3R0VPakdjVSsv?=
 =?utf-8?B?clZhL0YweVlkbjVtQVJ5UEdXZVVMMHBUSmYyY3VnSGllQlIzR24wYWY3ajJr?=
 =?utf-8?B?OEY0c01nQTZUd3V3N3Evb2l5OXR2TzlMSE9lTS9nN1RpaDR6eUt6LytkWW9V?=
 =?utf-8?B?OHkrT3BMdzR4UjZJMHZXMGpaOEt0b2tPS1ZWT3JGYkhSeTdPV3BubmphR0sy?=
 =?utf-8?B?bVEwZXRtd1lGWFJ0d0FpcmZMYjJURDZNUlFISHZ0bFYrN1JpTGxSYkpxMTZF?=
 =?utf-8?B?dzlGNzFxbVVXa1NYVG5Cc0NKR3RkTkR0L0xwMTg1Tm9NYmhscnR3cS9meEVu?=
 =?utf-8?B?NnBya0FIbTBhazRnQmk0OFNDbk9VOWo3VWMwT05lVGtjcTl0SnVqclB0MVdh?=
 =?utf-8?B?MlVac0o2YkplNytzRDR4dll3SGNyQXFqU3BoVWtSTUp3aDE2V2ZxblZPTzlC?=
 =?utf-8?B?QTRLMEl1WkwreXY4YWYwQ1hzdUhsSDBwbXBpYzdUQUZDTTJNVEZHK1V2WGJW?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 326015c8-90cf-4d7b-491a-08db9a902fbb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:27:07.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdNY2dC2e48kFkMuHEqx2mf0YPCEctpT5XXN/HfCz3fCym/2ypo5V7bQyGMrVjqe2qS+DzG71JQGgRTTAo8TBdLPvBx9jEhzrQRSUhJw/Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/22/2023 12:07 PM, Tony Luck wrote:
> The Sub-NUMA cluster feature on some Intel processors partitions
> the CPUs that share an L3 cache into two or more sets. This plays
> havoc with the Resource Director Technology (RDT) monitoring features.
> Prior to this patch Intel has advised that SNC and RDT are incompatible.
> 
> Some of these CPU support an MSR that can partition the RMID
> counters in the same way. This allows for monitoring features
> to be used (with the caveat that memory accesses between different
> SNC NUMA nodes may still not be counted accuratlely.

accuratlely. -> accurately).

Is there any guidance on the scenarios under which memory accesses
may not be counted accurately, how users can detect when this
is the case, or any techniques users can use to avoid this?

Since this question has come up during this series I do think it
will help to document the impact of SNC on CAT.

Reinette
