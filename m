Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA547AFF10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjI0Izx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjI0Izp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:55:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B16A3;
        Wed, 27 Sep 2023 01:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695804944; x=1727340944;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ofcPMMvrnY0KroiHRUfuBv1kuAuSTfh/7mxDDfZ5r5I=;
  b=dDAAK0TWsq1Suj6zoKXhwj6mYra3E8BPu2X4OY8DOwyulN/lrLAf9Cwz
   d7Uo0R/fJNHo6ExWs90KMEzRyKHvnthr+HxEIgqpuO/8xmJVUDvsNnD+v
   Du7euITHdm8bUj1aJtzd2hVW3NeBH0pcT9tP1CktSNqWKGUikVE9aAKuO
   fhb+29JjK+rpHMTLAIEi7rbAke1KaSwfzhAP060e9rcJx97KO4rfqWTfi
   H2y3NJJowK87lAOTdF5MnMujVSgKPBQ1GkPkPP+E0NARy649EtTt2Y9aE
   blXShhJKzvjwJyg8XvtvOQd/VZL0YwgQ9SFH69zQa/dlgiqxUqXOoe9XN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445904150"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="445904150"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 01:54:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778469129"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778469129"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 01:53:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 01:53:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 01:53:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 01:53:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQXGmQo8XoefdVcvj1uPFpH6c4ObnJqQrK1GNCRIkmDWGzRXB/Ud+NVGoTfv1nE2WTAUXX/pSNQ3/Y+BiLy5DpE7PsEG8yX1ZQw4hoeOLz+Npm7sS1u7UEFvqP780oqeno99PHXkjVHImc9/ghywt47a611GqTSGHPTloLkYJ9Mv5JVhlAoERT1K9r8ffK1gX5et/CdSoSjyI7I4ddN2iCP4shgA+yC4+C5eOUkHCHYPNLykQ2cSjgV4cRO8Gn6llEjl4kgtKIt2eJDI61xFeyFI0DH4EIKMmHnIU1RYOYbnkfTho48qgTOK8fZn/4DHmb0w4lOowr5NjBAXHLRPfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkAHTr0BtqbEuUiftPQp9e3lp5FXNCWlMBxm1xGQuH4=;
 b=OdHeewa6FlRpLU1UGL/C2iFBmk7MvH14IM4B4fxUdPbtQv0tik7h1FyOc63TfaL1dCq0S8G7uOfpi+wPIwX6XihhJq/UTw93isVhV3Dnr/n0g2IDwt3Q4EBWtR+I1wZb0/4dPzbHbfuDuOq1MHl9Gz2kzDzfH6oRa2/djT1kOHgLwvhG1d6+5LT4ll6yr8nj39epvwMArTbqlOi3Lu8LVQ1TD6zbTFYspaM6kY1y4RuNqaN8eeSgsHcpsNZJJtBG44MFkGAd4+P/hCJTHoQtgu0X+L5I+tQEl/UiJACpISCOMcF7Rs9lkDBtWwqzv6ZnCc77Fre5HdvgAoCz4Qfy0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB7580.namprd11.prod.outlook.com (2603:10b6:8:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 27 Sep
 2023 08:53:28 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 08:53:27 +0000
Message-ID: <f6c4a6d8-0c3f-dbb1-17ca-3a594b456103@intel.com>
Date:   Wed, 27 Sep 2023 10:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v2 0/9] i40e: House-keeping and clean-up
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <poros@redhat.com>, <mschmidt@redhat.com>,
        <jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
        <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
References: <20230927083135.3237206-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230927083135.3237206-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ca9af6-b8b0-442b-db29-08dbbf37374c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0RO+NEbD7QV8AKMGGsvD9gkc0TFPSofVd8WEVazOHdYI3D9VKT0g23M6XD+fbzDZsitzvff1G+WPUGGe/JhviRNETjzGGlTsaBEg8qBKAQY9cUN6uwsxCtXi7LgrLzMXAOlhKFx0uqOWFqpTn5ybc7wv5otgMTMqR04Pijti/BmFtMMoLmMsDSJ2LTANx/uk/96ZbwgZsD3iIux7hPE/agq18Xh0libF7u5RGRZvr1uhIkplDs+YnbOdQ07uuX2c8kDaHiopmcHv/8DotJVkPAS654VU5ZDL8FCgDZRxKwcisKlX646x2ab1CdfVFBDanbumqovCwApakpZwkspdDlWzyleEQaCaoSg4QCaDfrl2O8yPcdFkKLREd1zHtLoGZzWAd4qzTbgY8I9d24YkZbZfq8/hsmNNNypDMZSj5PxRZsOZXOhELlCf9p9ntfXGTLU8LOefj7jbe3C/6wFrgN/gQju0VJxEOwMB+nXmSzjYvKvwMKEBYxPEBabt4xc03+GiglUSNXgCx5L+DRXBdVoEsCUh8FqOqJKkhVxZXoJXIQQyFsuNHiNQwAXYmuOo1m6+IjxpPengNEgHXftBUD74RF+0mKk3XhFXKjMU2J1b5awXohvPiD2UVdo1StvpMePX02YvDzbwQyiehWHkBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799009)(186009)(31686004)(36756003)(8676002)(2906002)(5660300002)(4326008)(7416002)(316002)(8936002)(86362001)(31696002)(478600001)(41300700001)(66476007)(66556008)(26005)(38100700002)(82960400001)(6486002)(53546011)(83380400001)(6512007)(6506007)(2616005)(6666004)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0l6WVRlaEU3dTdLSFF1MG1TM2Y1WUlPU2dSNGZHcjkvb0tsT21xTWtsMllN?=
 =?utf-8?B?K20vT3IxMi9YL3FxV3cxU3BGZVQ5eFVKK3NpcVVEK3RxMnRMQTdGWEZta0Jn?=
 =?utf-8?B?dlBLVGFXcjFGVkpucUh2ZWorV0F1Y1I2eXpVYzNVN0lyR3p4NVVlQ0RBWmY1?=
 =?utf-8?B?R2FMV2s1YjM3MU5jbEpidlNnWGNhRHd5L2JUVmEwZVZDS05panNIcnpqSFM1?=
 =?utf-8?B?dXd5SkdoMldreEtReUpndnp1UUJXMlpBRDBZNGFhdmsycURFTmtQUmFOSFN2?=
 =?utf-8?B?Z0k1eVRvNW0yZ1Z3NkFjVG9nY2p3elA4a0toVHJVc1pidGpudzJacnIrdzVT?=
 =?utf-8?B?UlFDQnlHNWtPM0s4TytTTDU0NVo3ZktvVjFvK21rb0J0c3kwdlNoa0lEWElU?=
 =?utf-8?B?OVNjY3NQeFVVVndRSElOdDdKVTJNSE8rRzZuQ3dNK1IzbW5YMEVmaTNscThB?=
 =?utf-8?B?bms2bVBPUjNiQmpYR20yNzl4RE11L3BIVlVpRktJR045WjBubk1PVTRqUE13?=
 =?utf-8?B?RDN5OUdaVHFoRldqUFdzc0lEcnBBc0RGYnNnWWxuemgyVkpzc0tTOEE2alo4?=
 =?utf-8?B?b1FiYUZ1K2RUOWlLNW5MM3YrUmRMQzRKZWRGWGI4Y25SdmlZRkQ3dlpOaU5V?=
 =?utf-8?B?aXU4cXBIbzc2OVdmZHR5VUNVTXNVOVpiNWNrZ004bHRQK1FIQlI4MlArblJH?=
 =?utf-8?B?QjF3dlRITUFqTlFLODBoeDRtRmlzaUlhSHdneGUybVk4Qnl1Y25lOUZ4RTE0?=
 =?utf-8?B?UGdXK2xwUTJrdVhsM2s5QjJITEVZcGxDd002cmhGdmVMMk1ienA0QjRWUXpR?=
 =?utf-8?B?OGk2Z01MWXhlQ2wwaW9abFV3QnRBSVBKNHhSVHhWd1hVNVYyYVpvSEt2eVVt?=
 =?utf-8?B?M2x5SVhjOUVsZU1GU2kwazFQU25kOTBNVnd6TUM0eUhEK0VkaWxVdGJnaHFT?=
 =?utf-8?B?dmFYQnJqVEZFS2lhWkN5bW5JRmhxLzVIS0JIaDhPWlp5a0ErdUVIQ1VUYWVr?=
 =?utf-8?B?UzA3QXUyRmlvSVczQmNzL0dURUoxTktGQ2JBcFlVdldRODd1TGVBUzJLZzNC?=
 =?utf-8?B?eXpVSE5SVVdzQ2ZUTmpMOUZlOXRTd1ZmdHRML0l5WHQrMCsya2I2MWRNRzdZ?=
 =?utf-8?B?U29tV0cvbkhEc3FxR2tRcnVOUTFLaG81SXBpODhwRHJkVHdPTUp0eHBnK3N4?=
 =?utf-8?B?cGFPRjFZOU5pUjFITnNIdFNjaUg2aHIzTG9FbXRRcWJoK09xQ2h1SUpRMHlm?=
 =?utf-8?B?ek9TOENmT2oydWg1RnF4UkYzZWdPOSsxNDRvdlRsMTVtUXdWU1dicXRrWmxt?=
 =?utf-8?B?RDhvdnZQd2xjM3VzaUxEN1lQM29vVkFEaVRnRnlMT3FWUC9GVW1qalNRNnB4?=
 =?utf-8?B?RitpazJ2NmdwWHM1bU9jOTdzbUpDN1dZVzNxRG40RTlHcHFOUmVUWHdGMVor?=
 =?utf-8?B?SnF2aE1DaXJLSFowU3g5eWZjREsvMk9iMm5EUkZpY21reFdiY0UxYk4raVFS?=
 =?utf-8?B?Qll4QmhTUEwwWWMrL0haVXo4VGZTcTJxY0I3eXNWRzk2K1htZm1MVnh3UWtL?=
 =?utf-8?B?Z29QQTNvSTN6SlNISWNUSnpxcWxmRmZOZVBzd1BpYUVseVoxTzBQb0p5ckVn?=
 =?utf-8?B?OHdFNVhqMDd0UFJPZ1czd2RyVlc5eE1OZVBrYzRpMXVRSlVralZHbGpkdWMr?=
 =?utf-8?B?WVk5NlpDOHRsY054Ujd3ZWdsYks5WGovc05DV1BreSs5Y1d6am5JdnphbytP?=
 =?utf-8?B?RGRzbklPQ2JWS3ZnUVFEeFdMYytHZ1NpQXkxcEdxRGNadFBtbng4czM2c1BG?=
 =?utf-8?B?Qm4zSUNySjFPb2xSR3lPOSt6UlRSOWM0QXVmV1gvVzh1c1FMNmVQVUwwa0pT?=
 =?utf-8?B?c2lWcG9nMWZmK2FIcXorMGJ3UXJWNGpFcUdBVHNkM0pnZjhUR0xQOTFid1BK?=
 =?utf-8?B?ZmhzeUpIN0syMUZUR1E1SzFJTGhaT09HSm9lNFdZRWF2aFh3NkpXcktYR01i?=
 =?utf-8?B?aGdOUTlZT29XMWRsWTAyZmUzTWJSRlNvalF3a29sQ2pxTmRhT0FZWncvVEdh?=
 =?utf-8?B?WkIvWUFncVZHaVdXbmRaVGQ1TG80WUF4UXZzVmVpZllicU1pbDNaV1BGb2FJ?=
 =?utf-8?B?MDVoNVRPckJCaXdrVGZEOUl3QkNoMVBUNkRLbzdOYUx0L2VlUVAvMng4L2JO?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ca9af6-b8b0-442b-db29-08dbbf37374c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:53:27.5995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SA8489Noglzc/1rLtUx9xDujOZVwLOEdn4l1g451sDmbBe9xXTYT5dNaczUZ+o8sqxYOb3XQMTzoTysNxdMBGrCfpOdbjj22kB8isLtXYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7580
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

On 9/27/23 10:31, Ivan Vecera wrote:
> The series makes some house-keeping tasks on i40e driver:
> 
> Patch 1: Removes unnecessary back pointer from i40e_hw
> Patch 2: Moves I40E_MASK macro to i40e_register.h where is used
> Patch 3: Refactors I40E_MDIO_CLAUSE* to use the common macro
> Patch 4: Add header dependencies to <linux/avf/virtchnl.h>
> Patch 5: Simplifies memory alloction functions
> Patch 6: Moves mem alloc structures to i40e_alloc.h
> Patch 7: Splits i40e_osdep.h to i40e_debug.h and i40e_io.h
> Patch 8: Removes circular header deps, fixes and cleans headers
> Patch 9: Moves DDP specific macros and structs to i40e_ddp.c
> 
> Changes:
> v2 - Fixed kdoc comment for i40e_hw_to_pf()
>     - Reordered patches 5 and 7-9 to make them simplier
> 
>   drivers/net/ethernet/intel/i40e/i40e.h        | 76 +++++--------------
>   drivers/net/ethernet/intel/i40e/i40e_adminq.c |  8 +-
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h |  3 +-
>   .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 24 +++---
>   drivers/net/ethernet/intel/i40e/i40e_client.c |  1 -
>   drivers/net/ethernet/intel/i40e/i40e_common.c | 11 ++-
>   drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  4 +-
>   drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  2 +-
>   drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 24 +++++-
>   drivers/net/ethernet/intel/i40e/i40e_debug.h  | 47 ++++++++++++
>   .../net/ethernet/intel/i40e/i40e_debugfs.c    |  3 +-
>   drivers/net/ethernet/intel/i40e/i40e_diag.h   |  5 +-
>   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  3 +-
>   drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 16 ++--
>   drivers/net/ethernet/intel/i40e/i40e_hmc.h    |  4 +
>   drivers/net/ethernet/intel/i40e/i40e_io.h     | 16 ++++
>   .../net/ethernet/intel/i40e/i40e_lan_hmc.c    |  9 +--
>   .../net/ethernet/intel/i40e/i40e_lan_hmc.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 57 ++++++++------
>   drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 59 --------------
>   .../net/ethernet/intel/i40e/i40e_prototype.h  |  9 ++-
>   drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  3 +-
>   .../net/ethernet/intel/i40e/i40e_register.h   |  5 ++
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  7 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>   .../ethernet/intel/i40e/i40e_txrx_common.h    |  2 +
>   drivers/net/ethernet/intel/i40e/i40e_type.h   | 59 +++-----------
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  2 +
>   .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  4 +-
>   drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  4 -
>   drivers/net/ethernet/intel/i40e/i40e_xsk.h    |  4 +
>   include/linux/avf/virtchnl.h                  |  4 +
>   34 files changed, 231 insertions(+), 251 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_debug.h
>   create mode 100644 drivers/net/ethernet/intel/i40e/i40e_io.h
>   delete mode 100644 drivers/net/ethernet/intel/i40e/i40e_osdep.h
> 

Thank you!
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
