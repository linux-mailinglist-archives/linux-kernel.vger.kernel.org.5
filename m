Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8D7C88A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjJMP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJMP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:28:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66659C2;
        Fri, 13 Oct 2023 08:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697210931; x=1728746931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p3Ae6lZN7cuyrakdYE4sPueDIym/o2d0cPRxgT6lzXc=;
  b=M2glTCOfLvtE3rX6N9Pu/26qwvpAxyijzzGmD3nNuwldW7tUBlgQQwsp
   fFNf1GVhSMT1FxI8lvW3UkmaEKzcgS69g73aDhS2ZeeXf7J5htqdbwkKi
   6tLM2KrijWhfCDyZUCAvOmrK/CRFQFZqhFmov08pHGCRsImusc/RWCgKs
   pVt2lEdYSf4CLaU5pROAvfCAM4G8kUSkh1S+XQKXNH4xqQT+PUnCk78WR
   R8fBpNeRoa1dY6DJMZaQxMepD06keIp+Sml7auSxGKaKKgUR4pF9ryolP
   Ne9WjI90V9a95pvO2Mgb/n2pzOs1ztu5x411SM3uaP7qn0ruOS38/IWH1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370271589"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370271589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 08:28:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="748380002"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="748380002"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 08:28:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 08:28:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 08:28:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 08:28:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/MQXzW8R/k8VEEA9x47V0nNrrSXZm0lHaC2Hi3Zxs1RTlRWINxlBNUV+VT4Ng9FheKaTFCv9f8EH0iqc3hPiJTxFE9wgwWoynY6SQEm0Zoesi842smr3ckgmoXhvVfFjKY8thb9li+8nv40V02sfy33ASf3E4goAveUMA14MUlK/3WMK/BGZZ6vv5qjeWJLbm2to23X4tT/ZK3rFPFGbfaQXYclhXrOpJwTX3X+VEcrQGwIeMsQEmdXfZUPbWx1xUpMAwqUYZVn7+rQX8SFySiYvUvrd8TQwd7l1jK2WIbNJU2AB2NGkyQpQWE1xHMdVqRKy1Dh/VrdWJ8jsMA+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKSVCvBjlez/HjKcgpR6tDa8onE6/Ok9djokUPsZQ2U=;
 b=nrBZ0W0SPjC9kQD9FN+dPIvYGWOyLzB2SLZxwBRtDWQxP/EbjEqoU9z2o+cNYVuj4TsE475utqRgDq/HmE1ISmp2yxXd7FLUiAlM2aIXszFzoWBWHbR75aEJUlvZaKy4/vyfXD42ljsxJVHxlbQkLbd2hAgUTrmMJv0zNZsBhLqwF1Ui8EfGZ7CqWPb+0D+3CYFxyX19QbVZG69qw+JJDwRSH/k2VUN3umpPsThmVN4IR6AYT0iZonnMPVsRAX9KssGofiZJflmkDajwA78rhaf5m8UN72X7R7Xexl3azAw0Ilau5gR0r2I5IsFuVodBpzFVpA7J84vpVC1Czg7kFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6216.namprd11.prod.outlook.com (2603:10b6:8:a8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 15:28:47 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 15:28:47 +0000
Message-ID: <eb626b3e-21f5-4548-8674-3bf049e6cf9a@intel.com>
Date:   Fri, 13 Oct 2023 17:27:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ethernet: ti: Fix mixed module-builtin object
To:     MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@kernel.org>, Roger Quadros <rogerq@ti.com>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231013100549.3198564-1-danishanwar@ti.com>
Content-Language: en-US
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20231013100549.3198564-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0262.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::24) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: f9da27b6-4c1e-44e0-3312-08dbcc0117ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVQVcPGbfOwLchA81Wr0+qj78/4rpCdzrRL6+B1WDVZvyU7ZKGSubSOC8HzNxRLruwQKQlosG73prEf2i4h8v9l3Ai8ciq1QCPjb54c+Z2AnvxiehR+2J2wVo/zLxWip2zSEnmZGkkjYzwxZyyOHAhmSo/MR0diQ+7REx46P/WbcPzXdtaOqK4km4mp9ybzYVlhShf/ujg+T19foGtpgk0ttGN0FqbJ2AGH1fpjZWZpjRXzesWfEGw8zCclKdtVVqw9sp4jbudiDBoit4zYIDFXtAKIkcZACLTq+DY1qFhc4dgrtAnDMWx47PRb2OsDiUwdi/g7mRF10/K7AUHzN10+9+vsN/XclmrKxqK/ZpnCdmlM3fofMXCSWdp/kEJFsauVXwmxCg2oqaezSWE3LEwgqkrMi42F7y9YX6hwtaKMmRyhh7oLmqIWJAn84HdC0blcgP/mXFbIdCjP7UGA6L/+7+5Duyq6pEbANttTx0sGqKSsOcOTv+rYx4RicjaxoiEvN4GNtJOt4FNeVDQbfNNcvT933zAo32+a0vsfmUV4jYhmdgzaLpHf1Hp2DqdaPrS8bb619IBK8PsWZmkxiBRC5abc7/uhVODOuIQoMPbKQIjVKVpsexgR2qIUEnWLsBRrCJOiZZeLZ3zD1d459Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6486002)(966005)(6666004)(66946007)(110136005)(66556008)(66476007)(316002)(26005)(2616005)(6506007)(6512007)(4326008)(8936002)(8676002)(41300700001)(7416002)(4744005)(2906002)(5660300002)(36756003)(921005)(38100700002)(86362001)(31696002)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEFRYlYza2ticjZ4cXV1TE55N253bUJHQVR5ZFFpSDNUM25MZ2toYmJjek44?=
 =?utf-8?B?eTZ6RmdBRk9pQmgxNVlOZU9ET3R5cjJaWG9nMGliN2ZEZzhjMHh1cVRUd3ND?=
 =?utf-8?B?YjRuR1pWYXUvNHhQK1d4MVRJb3J6aW9xVXRNSXVSejJraHFTQjdyZTNRMDVP?=
 =?utf-8?B?UHBnMGVjek9MU0FiaXBYdVAvUFlQaEJMUHFOVmNCbFUxUzJiSGtsclVqeEFr?=
 =?utf-8?B?SWV0NnVLL0RxVHd6VnFYVktVY0VtOXBSU0crRDhOWjlScEtPamtrbk90ckpu?=
 =?utf-8?B?dWUzU2hWTGRLV0hhTkZSN0hzbzl5aDcweHVKdlFPdFR2eU11Z3pNWkdWc2Rm?=
 =?utf-8?B?Tm4rZDJkZGR5a1U4cEc1YVJJZ3VFa0dhVWdrZHl6QU1DZmt2VnRCV2JqSCtp?=
 =?utf-8?B?SmNUWU5tVjNIMEl0dk1YcW55REV2SVc2ZXdCd3JsUVhOeW9MeWo2aCtXMTM2?=
 =?utf-8?B?RVRxZm1DSzNjVVFZZWs0L1NmQmxiZnNXM3JXUEdTSzh0aFpWanV3WDhDWktG?=
 =?utf-8?B?aTAzWERqSmdSdlV6QXVqeU4xOHVXTHhEbnc2UDZRTGw0S21YWG1lQ2dySFVi?=
 =?utf-8?B?aWpJb1dPeStEZkxwLzFPQzcrT211UDBxNERkL3VNLzRpZXFHTEphaFRzYVdI?=
 =?utf-8?B?Q0t1SDlqb0xKYWgzbGh4ZXltTjlGbEtGN0p2T0FOU0o0M0ZsRTc1bVVvZ0xU?=
 =?utf-8?B?TGJTQUo1U0FXVERPOU9pYkVDOUxkRHBJOGdid2N5d00rUE9sRWpjRUhCbFAx?=
 =?utf-8?B?R01zUjhmVWFRazRpb1ZwWi9yYlh2MmNzSnNPM1JtS0hZakdTVFBDakN3Q0hU?=
 =?utf-8?B?eDVoZE50bXJ5TWFPK1dvTCtFME93eS96ZHhGb1l3bVFsMng1RjMwdHd1TFNw?=
 =?utf-8?B?Q2VjVEt5RFZYVVpIaWZLOGRhZnVtRUNrQm1BekZ5QzJCUlY4MEh0UkZ2NXFk?=
 =?utf-8?B?K0NWQkQ2bkxMTUZzTEc0VjZvRll0VE5CM3JucG4wRndkcW42K2I0cSt0R29r?=
 =?utf-8?B?aVFIdGpWWkpSdWgzdHZGQ0xLOE1rNWpTcVlCR3orSitwMW16TEE4Zkp5bFhY?=
 =?utf-8?B?YngwTERmd1IvbHRwa1N1YXpMcGJHU3RoT3ZxcU50dFBSci9KZzdPYndVWk1L?=
 =?utf-8?B?UFdzRit2cGhtK2d6NkJHV2FadnhyWVhiTkdvZjJyZXFGcis0WEkwdVIrai9o?=
 =?utf-8?B?V3VOajNoN1hoaVpBNmlpdnV1TWl1aC9ZbUI2eWJjTW5qcGdvaG12bVQ3YWxP?=
 =?utf-8?B?TVdtcjhIODJCSFdWRG9vNk4xNmpGWWxtYWU0UjExa3NZaW5UV0EwNWZZVFRW?=
 =?utf-8?B?YjliL2FUZklpNG1SY05ORTFtOVRxWXhsQjBJR04rYmE1RG9tRlJEZVA0ZFpZ?=
 =?utf-8?B?NlZiU0sxQ2RPc0lib0YvU1o4bjc5Y0VEdGVHazdjNHYzR0YrMFdWWGtPTTVP?=
 =?utf-8?B?Z09xaXF1SlBOK0tNdWowb1ppOHdyS2cvZkIxVUN0bTFLVTZSdlJYMHBIQVcr?=
 =?utf-8?B?MzhuQ01wSmZYc0VYYlpGdlQ1Nzh5bkJHOU1RSHpLeHA2NHc3MC85YzFoOUlR?=
 =?utf-8?B?QUNmaUY3T2JBcEpYQVBNM3hQLzdTUFJQQXpCRjk4VG5HcCtPRDdPNGMzdjNo?=
 =?utf-8?B?SDlqUnM4L2RXbTBXYUZnVWYzMEZISzh3eHMxRXVraXpTMHlUaW55bm9BQzRK?=
 =?utf-8?B?RCt0UFFidXM5UmcyeW1FSUhwVmNvNFQvMzZ6ODJ4R3kzcUw4bVJMRTJTNVV4?=
 =?utf-8?B?RXlleStyZ0tMU0huVXZSQlNTc1NDVFl0cU9UTEZuRjNydVV5UmNKS1Z6Q1Ns?=
 =?utf-8?B?S1BnQmFGbElrNUc3VXprbkNVcy9DSXNBSzRpSnhnbzVnRmZEbi9rL0g0SlVO?=
 =?utf-8?B?Zmpwc09IOE5OR0M1d04zRHNuTWlNRUpJS2lOZmcyUlE1UnNScTg3cWllTWcy?=
 =?utf-8?B?ZHg3SXdsMm1JV2pvZWJlemYxZTdSa1RzU0R0cWJxZmkrREtER044WjE3SGp6?=
 =?utf-8?B?NXNmak1Ed1VXa2NnOXRnd0JYZUdMOFBTNm15OFhoeW84bVZwWGdUakk1aXRI?=
 =?utf-8?B?anFBQ29SdjZaY2c3YWsrZ2psckRIUlYyOTlLQUhuWTNwQml6S016eEdnU2pP?=
 =?utf-8?B?Z01aNVZSaUd0RU5ISG1HRmdGQjMwL0ZLMHArb3BncTZBRzNNV052Z3dlSVBR?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f9da27b6-4c1e-44e0-3312-08dbcc0117ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:28:47.3757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AYl6YjqsGbQK7uCjaYhcmQ1Pvg24SfI2c42jkwJTZeFM/Subv7gsRlEeiahLy9O7GDqsDyTEjZ9mqYjJGza2mflFfsWJ0gEyzh8pEyaPBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6216
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Md Danish Anwar <danishanwar@ti.com>
Date: Fri, 13 Oct 2023 15:35:49 +0530

> With CONFIG_TI_K3_AM65_CPSW_NUSS=y and CONFIG_TI_ICSSG_PRUETH=m,
> k3-cppi-desc-pool.o is linked to a module and also to vmlinux even though
> the expected CFLAGS are different between builtins and modules.
> 
> The build system is complaining about the following:
> 
> k3-cppi-desc-pool.o is added to multiple modules: icssg-prueth
> ti-am65-cpsw-nuss

I also fixed a bunch of these in the ethernet/ti/ folder a year ago[0],
you can take a look. I never made it to the upstream branches since I
took a rest from my home Linux projects and never got back to them yet :P

> 
> Introduce the new module, k3-cppi-desc-pool, to provide the common
> functions to ti-am65-cpsw-nuss and icssg-prueth.

[...]

[0] https://lore.kernel.org/all/20221119225650.1044591-19-alobakin@pm.me

Thanks,
Olek
