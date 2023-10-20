Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67C7D17EF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjJTVUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJTVUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:20:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C68110C7;
        Fri, 20 Oct 2023 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697836808; x=1729372808;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bwl0dUqrgxTZS+qfdgygwYiONNdQjw4x0zRqX16ATPk=;
  b=mh6joqH3TFx+s64KsWxtjIFWt8JsXEhgtqx4lK3d9tS2fR5GT4sCKW4s
   y1kz1ShkQB0wTR48g3ymWfOwYzOGaUQQIJPzFxLujagAOxO2kSuS+TMgy
   kpEr8GZwLNl0VGq/uuOd6nJoiTq4XMjTUjvH1kbrWdWQilkD35XUnuT/J
   IedYWK0lpIQWCkcgY/3KtN3nWHoY9hULjcJ8GEbCKOc6daTHzWJBjeOIc
   UBUzBJmoNJoXaV38csylhJ+qlBa0QVWdpJarRLJAayGxvFTAZkXvlPIfk
   ycfV5dBAbJ50t7oLqRIAhqxTIt8uR5LIEczZVD53Plri9W1eaU5PUgbsx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366804940"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366804940"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 14:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="874043077"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="874043077"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 14:20:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:20:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 14:20:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 14:20:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 14:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGwd0uFnz/wJ3s8fOAy/rPIbiBld0H7NKfZ+lAnnrbyb8fogYdCA9mafs7o3xieDqWE1nfSYbu8e9oEUDNCnPj0Lyrc8LfBTjA5uAhsNgIPmxGTB5C/aP5OR5+MoDLvSlmlHea8V34F94nwuVqWdxXFOZBhB6yV9/K0gMjs3rSeQQteFeNaQFQ5mB6JIcDospuf9sg4quZfUp6WSC4zztsCNmpRVz/zgR18OuRJVzSyRjBGQqSoLDsZrhAo29Z2MVKb/hsc+mphLN6nWWfrBJRQTH/boVauhA296iEMrpbWrk+aMKBDTvEii8KAXWmGc+LBJgrmWyhfRsYJG0ZqhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=797akjR2hfrV2+sC5oep700dR/zPf/bIKGmO/sbpAH0=;
 b=YIz0fTYShfT2MR8T6agrXZyL97pIKUX2aWOd/S9dOXA0jCfWZ4Bm7jvCBWEt6uPzJkH4HRJML156pgwebt0jJjVb/yysgM4ASWwdLSROeOHPiLWeUW66uSjGnxl4C6g4wvkBWlfFC1Qa9Pj08OCfNeakZxLCuw7L8IQZVw+tWtXpWswt0g5xiE5OHYzn761oznKyIO6GWUyAxGkDy11NX1hxF8yHvKN1KHORXLsEH2YGs8DLW7cFVgffnCs6a8ebLh0yw9SKrAe8olVxMFgkyJIw4YnWJ0id9Pn6hbQ6LYWLtFdBFId1AODqGzsiGFFWmggVoM/pXav1y11K0jY38w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 21:19:59 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 21:19:59 +0000
Message-ID: <71530e57-49d6-4df8-8968-899c8777e86e@intel.com>
Date:   Fri, 20 Oct 2023 14:19:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/6] i40e: Remove unused flags
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <mschmidt@redhat.com>, <dacampbe@redhat.com>, <poros@redhat.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231020193746.2274379-1-ivecera@redhat.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231020193746.2274379-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0352.namprd04.prod.outlook.com
 (2603:10b6:303:8a::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 10a89346-9f8b-4b4c-5b90-08dbd1b250c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jn8L/JtvjzIZxDD+OQOdESivPS5+mcg6Wj4xmv9WPDeYTknCXXvzHiHSfbz+iXAn/rudCxdPxABPiuWqOaGapgFd4OxYt8OeWguPdVDKYWHCStjvoXd3D6oswN3BFwrwL8hWbVuYB1LU49u4Q+B8xumT5yrAky5wjGFv1R1aupAMJuXX8zcTFoeHTd3S4Z0/RiXzG4TvWBM9rGu/jfGgYVpHigwL0n3zqcXTPFdU32BO9o5haziJeiCSubnnbrZy8bO40aIZoKzxH2nGQgrL1hAjkdxGRvnDEMJ/LCFRvRqJ3bQiLY9kJb2dXTI2IaK4ZNbAUgsGGGd8oVKOFXUg/GxQfkEBFDxJTwh/fZQ12R8oflitEr77HnzZcIUj8dVsc4T0RtGedWdnchd5sXMbD2FkmC3sixpYN7wuplzIFYlxqNCg9+/Tanhcrpe5NzWW/AQ74duFIQv3KGEi4zf74Nfu5BOMTRYDiGkFx/OZqxQbX9uFEoH7n9POQDVdpeoA7n0XU5mPBV7psLSBcf6QF2iSBYCfA6+Bzy0UwP7CWPCv0fY8HevVRt6oftunR6OZ9iukcpn2itWmpcebwr2ChuyAYruogaSNTPexeLjQgaruMoEKQ9JNKLMQqGF/H1ssiKRE2JigYu016tPaIcGU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(7416002)(2906002)(4744005)(6486002)(478600001)(5660300002)(41300700001)(4326008)(8676002)(8936002)(316002)(66476007)(66556008)(54906003)(66946007)(31686004)(36756003)(38100700002)(86362001)(31696002)(82960400001)(53546011)(26005)(2616005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNIUStpRllRWU9GUm5lRktIQUs0aytDM2Q4TXhEUzBybUNqdkdUWEtueGF0?=
 =?utf-8?B?YkpUeHhaZUZoTm1nUkg0TVBCSWsyVUp2U0NxYURLR01oRmV6RERhbExneEtu?=
 =?utf-8?B?SUU3bGJ3VVJXcU9zN0FDK3BkcVU1Qklvd0tydEh3MEVNUHY0K3BhZzZGZk1J?=
 =?utf-8?B?SjVOUzJuS0wxOTJYQThabDZvenJMK3g0WGFJbTR0TGJNVE5VazRtUllnYlY3?=
 =?utf-8?B?bDdkYUN4SGJ5OWluNEFRVXBxVE0wOFE0TW9saDlZM2dUa254cVcveWZyTjRD?=
 =?utf-8?B?aGRmMDNxWVJJTHFNQVovdm9ySHZjOVV1UFI2MTZwTHpPQkhQV0RhY1hGV3I3?=
 =?utf-8?B?VitKa3Q4ajA3WVhXK1dIcDFnR1lvSjgrZ002RnJEKzRXZnl3QjVNcUtVZnpv?=
 =?utf-8?B?cWhQWVVydmt2T2JjeWZ3NjBhZVRKZGJUWTRiZFN2UGVraDFyRFRORnNDYm44?=
 =?utf-8?B?Mjk0NkRXeHc0MGFpTWlQdUxUZEgycmNMNlg2WFJyRVkvV1JEazFFa1hIRDNz?=
 =?utf-8?B?OGNEVVJlZW5hTFBlRlhyS3NpSGtRUTZCb29iMDA1YWlpcFdweVR0bDlLMkJ3?=
 =?utf-8?B?cXI0dC9jaHhITDhhTXY0c3BpY2ZmNWFFU3pMZGlUZVRld1gwMEsxTW8yeTJL?=
 =?utf-8?B?N0xKZ3lZc25takw5ekloUDdhUk1UWjQ0c2txUHFBVytQR3RQREhjaW16YWJP?=
 =?utf-8?B?eTFCdmpwRGcwSFAweWRMdjBQVk54dC9hcHdXZTEzRFgxYmhtU1VqSDdISGR2?=
 =?utf-8?B?SHpMRGRCQkZCWlRZR0NuTWIrbmt5amxPWjc4Wk9rbWxxOHcraVRsN0NON2Ey?=
 =?utf-8?B?ZnJOQnZGZWdMR0JLRkVydy9hZFI1K2owMlVyWGdEdk1FWThyVHBKSlJQNzBj?=
 =?utf-8?B?VGh1cEY0QkVtSXRobHhiU0JKcC9lc2IwMkFaRjJlcFFIZGlrQ0JXMjdTaGoz?=
 =?utf-8?B?eWZjUEw3R3FaS0s1cE9JaHNEb3VkYjJKZ0NjWlN5MmRNSWwrQ3BTbG84UVNM?=
 =?utf-8?B?dzg1WXhoQkVWSmh0YTdqb0o1WVo1bVoxNGE0dUdKZ2FTZ2RZMm9FQ3A0REhE?=
 =?utf-8?B?K2NXRXNZbXJtZFgrN0VSdlhzNlhPakl5ZjdETVRqdW5pRW1PSktCUmVoR0J3?=
 =?utf-8?B?SFpEYXNIMG1UV0h5NUx4dVBlN1RJOUsyWGlNd2gyTkdWZWRwb1RwdGdieVVj?=
 =?utf-8?B?UUFndkRsNlhSRzdVU3ljSGVET1N4UUViTGVQQVU3T2tEeW9FM1VtYzRCQVZ3?=
 =?utf-8?B?ZjY4bjZLYXROZFAzcmtUZ041UDZsZ2NkOXZHSHBtSGd1bnpXc2JyRnFmcTJO?=
 =?utf-8?B?Nm9XWlphUUtFRHM0dVUzUmZES0l6NEdNT21uUmw1TDNLakMyTXNzWXM1YlAz?=
 =?utf-8?B?S2g1R3d1cys0ZzREcVUzSlY4dDBmYXgzWldPWTlnRGRXWkxVdTNzYU8zVHVz?=
 =?utf-8?B?NlFvM3pSVzhKVTUyZXFTcWNVVnNVcEFUNzVSaitEK0JjVlhTcmp4dEN4YWJs?=
 =?utf-8?B?T3FoM09LUC9PcUlDUDJEczBxUC9xSDlkbDhZekwvdUpocVdVcVpsME9pR3Bo?=
 =?utf-8?B?T1Q0cWxCODNBZzc2OURPOTRFL0h4L3gyZlFtSXdFQ1dtM3ZZQmhHK3BJWHIy?=
 =?utf-8?B?bXlaRU1MWVVFRDI2TUxmbkMvYVlUTDlhbXI5YlpqbWc1WFJiOVVqdVYxMWQr?=
 =?utf-8?B?b2F3QXNGMEpQdmlHdTJ0Wm5NNFByd3dpejhSTTg1aElOMEc2cUVMUzBseWRK?=
 =?utf-8?B?RGRBTFBmWWErYXNwT3V5dDNKU1hzRDZsRXcvWFJVcExkTSsrYW5UWjJWeFli?=
 =?utf-8?B?eU04dW84WFY3cTJGcXlLYnJpVTBYbTN2SmVVYVlvUVB6cGNDTHlvcmtyMTNS?=
 =?utf-8?B?NlFnS1RRYXRXV3phUlJreXN6NEo4V1dvaHZ4T1NuNDVCUyt4WkNpS1FBU0V4?=
 =?utf-8?B?US9jT2hkakdENWtsM3VFNFgrQUt1c2s4dHg5b2NleHlZY3M2RFdMMlRnSHIy?=
 =?utf-8?B?QmRGMDVJZllXcnhjc0RlNE5FU1hHNXRvdE0vYWczZ1d5cFM2NHdaS2FMRlRs?=
 =?utf-8?B?QmpIbldIMDdMNzVreUJkUE1xY2d1YWZvWWJEVU1EbS96ZUdRdzFMazg1TWs1?=
 =?utf-8?B?dWVtWC9zc1JHbWV4eHZOTTVnaU5ZdUR4VUVZZWVpd29RSGVsMjhFYnoxTjFC?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a89346-9f8b-4b4c-5b90-08dbd1b250c5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:19:59.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC4iul0yQb1xIPCqINHbsK5/TMZffEmzje2yM1MfUO1OCNzLZs1fvAbCuRFZ0aI2GrMeZa9X7bNPCfZO4AgtLkpmokSon/5QdbkyymuPIg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5598
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 12:37 PM, Ivan Vecera wrote:
> The flag I40E_FLAG_RX_CSUM_ENABLED and I40E_HW_FLAG_DROP_MODE are
> set and never read. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

You could leave the bit positions as gaps in this patch to avoid the
clutter of re-numbering them since the series is converting them to be
automatically defined.

Not worth a re-roll over that though.

Thanks,
Jake
