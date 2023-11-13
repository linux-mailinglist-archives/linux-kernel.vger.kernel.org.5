Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849CD7E9D1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjKMN1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjKMN1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:27:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28374D6F;
        Mon, 13 Nov 2023 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699882061; x=1731418061;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WhFJAMTXMBKTuyBlyh+KlEI1ENZjLmpIKuy6INKu1vU=;
  b=be7TQMBkxq2SkqvQ9X1SKrd+yMtSyg3u0baZqt3DFMglQWBkFnbQL2aj
   UYBKIbBOFTjiyRFfzFixeaWPfcXJNqlFC/S9LgffxPMT/OIaT6Yv6hn9X
   HxIwva5xMyhYzLmyfOt41WPTHdvmf/ZDRhfCYs3X51jaK+y7M8AEh6HA0
   rS2aw9/mtIhwkpRMek9N4RTF2AmhH/4kY1aq+dH4PMc2k0f92sWdRaAm1
   qZoKZg+kYz6603TQBz9ePEGGgRiZptg3xwNIZbRjZ/rtGq04bDIcQxcV2
   jP4v2sXzqqfXeEP/opegjH9U9Nkv0ALewSfaFQAV8s5LTNmB53RdmeGf+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="476654149"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="476654149"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:27:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="834717033"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="834717033"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 05:27:40 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 05:27:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 05:27:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 05:27:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkW1DPhl8sZ2MbrqMJOkAfZSOx8ZY5DexZsJjJyQEeIX12LlnYvjRc8MAqQMYp64bbcugfxP+yp9sQxytbl8ayGbl9MyEt7PB5ms9aZ281G2IaMxuciMoVLtDT1VH6AMMpvJ3cjUWfAmM+2REvAh/tPSdSkOlPb7M8qOpkgIcyGOOhLkUL5p7LyI8nSmAIHu4i1goqa8njJkzuXYzfBPpCMhAgBuVUqMr/JZV5DHPSZWt7aSbtC0v6RtRS+vPNAe3yMkkRNydc45vFOPeJTAB1JDrri1Z7/j2hh8VjUQD/7Gf9yFCyzEilRIxSZmoisN/pXZQvy1GpUHnDYMTZ9r1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hus9CXVC/a5dADmORvc9Ta6jXmjFBo3R7hp4xx9KEYw=;
 b=faepQa4VaBRclyqf+t9a/ak7CUt3pPAk2kbmRFOgwjMqxnbRqVZzE2o4320/1Ans04ICYb8KgBh5ZFcRdp+F8CBI9L4TGW8dZGwFjdx/4Tw1xP78TINBkx35Wy/SZrLWnvJonu8igOsMaUJTcu41TfWqQzAcH3v4FOGpY348e/BnOdOT1UllRunhNMPMVmuGicl6lJZS6hNZnEOdIJdsPUosAK9AVIbul7qJobIITpEgp38/XKPUIUaQhCewqf1/Oct45SG8MPwYCrCR2KzEvCSUb/loBqratqrQjg9dJBcbLhFdygu0t61WggA5tvd2HC96Qry3zJTi1wfJeUteSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6740.namprd11.prod.outlook.com (2603:10b6:303:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:27:36 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:27:34 +0000
Message-ID: <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
Date:   Mon, 13 Nov 2023 14:27:28 +0100
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
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231113125856.346047-4-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::23) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eea4227-7d2d-476d-e62c-08dbe44c4bd3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yju1P7xVe59ERhBdjJa1VVDbA2sGwJt5Qbk+lgjMKhQVraOoc6Qqo2OcoArFr9nA0tfITp3lBj4ZsLKNas2q4SGuM0r9wrKk4RErBCanAInRsypI2nMYlSOU6hLgNX4bFVwpmXLac91U7fHYYMKsmfYSb+TVsCoQayX3UsrM6vZ9IcNuXMP4fa/4OTSIpf2gDquyvc9CtNB1ynC8nBmGICkX++H1NE3LcgcF9sSqiqxRU9vdHMT55mpIs6fvj2YDs15mcB0SntdalkSTsuHjm5O7J8Ti75+ZGXnWyYm2vxvPHD7RPOHubPa8O8PdNIZdSzyjJ9yk3uc4tt15ZZZWdSxo4GReMiEEFfXzb9tktWr47mZE+cG/dWfi4l9RpohvKhLBdtkqK39EwGBEN/TmmLqtOCy0B/k3ZvZoDFPZZE9ACKliNiNca/MaBYIHLQ7JLUFiN4m+5Cm0xWNoRFtRj0NUSxsJRmWqXlqXtpcO1dsYRKzVX8UO/BFBR6HICl195HwUiUAbPaHaNLdtoUs+A41eSpOPmHrOBcL5GZrz19QkH5TNbz27h+D36Mj29dMCTgvq0O3zPJisulmGbDFrdLoJU3BbTe4JEkkJBnL/N46OCqZSJIJk3phFsgPrQwVeyuaNHu80HoV21a3nVLHksY3KEFGG4mexcPatLRgIguo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(36756003)(6506007)(82960400001)(6666004)(86362001)(31696002)(2616005)(478600001)(26005)(53546011)(6512007)(6486002)(83380400001)(4326008)(8676002)(8936002)(44832011)(54906003)(316002)(66476007)(66946007)(66556008)(31686004)(37363002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHV4cXpQcjlwVENEMTdaL2ZtNEkxM2dnaThmb0hFV2ZxdnVocXMwN1QxM2Nz?=
 =?utf-8?B?RlgzWnRDV012UmNDSlhscUdEK2NrcjRoSStsbWdMbllpNUhUdXZwNTRaMG9S?=
 =?utf-8?B?cWpNL3VJanNYUit5QUd4QXp5ejdMYVNvZ0hZVGJhTVZOUVc1WUxHR0xNTHlQ?=
 =?utf-8?B?UHJiTG14emtQMDAxWXZQd0ppWVpsVkk2cmhvektXblAwd3B4NGlRbnZrMFE3?=
 =?utf-8?B?citHR1p2MStLbVZzMUliSzJFaktQbUg1eVBoMStVTzU1QkEwWGVsTkNCdll4?=
 =?utf-8?B?Ulkrd01NSUQ1YkxxYXJmMURadTJRbllvc0pMcnFlMjFaS29KV3FrcjNwQ3N2?=
 =?utf-8?B?U3VML3Ftc2JyNzliWkRTelRYSk93dmw0UDBCdllNWk1NRnA5MVNPNjBFbVVm?=
 =?utf-8?B?RTVNZmxZRG5OUUtCOEs4T2tEaGpyRlFlQTMwY05LY0Z6ZTNzOGsvQkRtSnBW?=
 =?utf-8?B?Y0ZrN0JEc21Gdit5SFRMbzMyRGVlcEhBdkFNOGtrbTFFMDFJZWVOMXkvQlVU?=
 =?utf-8?B?Q3dkdmltVjZsYlVxQXNkT3hDOGJFczg5OXZ2RDBnQkk0M2JYRjJieHpWbGc5?=
 =?utf-8?B?STZQT2VqRFpseW5PcmVFUGFiclJFUHBqQkVUckFJdUdPQ3NjaEwzdDljeGs3?=
 =?utf-8?B?VXN2RWlMWkxpanJjMXo0YmoyOG5lWWtpdzkxZFhUd0hBV2dCVW1IYlVwWGNX?=
 =?utf-8?B?NGhkaUpZb1hORnNtRUhyT1kvdTN3TGQ3dmZBZDJUbE82TWhOWGxkbHVZdXRC?=
 =?utf-8?B?MFBiT3BlanU1bkJDKy96Sk15ZGljemRlWlFtbC9CRmUzZ2xhNmg2YW1uQXFm?=
 =?utf-8?B?c2RnbjlKWHZoWTc3VWgwT0NmaHJjRlV0dlhnU0RBWHhtQmlMenk3VlF6VHV1?=
 =?utf-8?B?bHkrSHhhTkdRQ2ZZOFQ2ZDdRNXhFL3ZJWDJMODRBejVvUGpDZG92K2dKanhp?=
 =?utf-8?B?QnRNVHdlM0J5ejNIdlk1Nzh0OXFQRm1Cb1JDVTg3UW53RDZaMlRaOUM4Tnd4?=
 =?utf-8?B?VXc1SWRmcjNtcC9VYTJJc2dUK0NoYVBDYXNObWdNWVZIcmtLbHo5NUUrZHNp?=
 =?utf-8?B?WldyMEU5Q05HL1dHWjlTMUZuTHlXWDA5aEZFUW5JK0Fhb1Y2WSt1Ujh1OTNL?=
 =?utf-8?B?ZjJhSjNXRldxMWlydzVQdUQyQ1E3Qkp5dXRXQytMVjFYZ01PWUt4eXkydFk3?=
 =?utf-8?B?Q1hIcUtTVlJmakM2RDJGMnlqanUzRFRuYmZDSitMaFR6a0R1Ym5IQjJnWDRq?=
 =?utf-8?B?QVpLTHlINE9pY3pHMTcyVTVwZVBxeVkxMjN4K0J0MUREbm8yS3NUeTdkemg2?=
 =?utf-8?B?U0JkdkhmVVRpa2E2VWR3MlN1SVZyRG5sSVloSEJiK2xhYnBnVEw0T2pxS3RE?=
 =?utf-8?B?QUtBU0E2K3lIQjZWb05CSjI1YndqYmtvZTI4RTFhKytaNnlqZFEzNXhqeXFa?=
 =?utf-8?B?NEk0cFlPcHF4cUhhV2VDUnAyVUZCL2RoUzBEUmYzUU56Vk1tWEdXZXNiSlZ6?=
 =?utf-8?B?OXJxN2hUMCs4anNhYUd2a1ZuSlBmOVc5a0tGaitBNC9yRXpFSmhlNW0raVIx?=
 =?utf-8?B?MjVpZnhqa3U2enFFazkxZE5sSUs2WU1ndGk3YVFQSy9rMWdwWDE1UDRxb1dH?=
 =?utf-8?B?Zm9vMFc3TGhrWTA2ekxSVmc1M2trRXp0eUtLN1ZzT1RjenlWSnpSRjhtTHFt?=
 =?utf-8?B?ZTNDMjhUNzFRZTRFck9rL2NnK3MwUE5wY1gycWV3NmlEaUx0RnVEWmM0Vk81?=
 =?utf-8?B?ZkVKUkVyTTMzbjBJYmptc2U0YW1PYTRGc3Q5WUkxR0dzYmFWUHczbW1HZWY1?=
 =?utf-8?B?WkZOb2tZSURUTXVPUXYwRk5KODJVRzN3OFBmRGoyN1dvaU00bHhNZ2twUDhL?=
 =?utf-8?B?dnZ0d2h3dlMrOUNXTHBaK0l3VEhQOUZoU0xabWRZT2V2UW5zWEozQmdHZDNs?=
 =?utf-8?B?VmlxaHJ3bVFRTlYzSkpSQWNDZ2lJUjBhNjF4Ry85QXBNKy94dTVkNzVKR3pk?=
 =?utf-8?B?RkVoWjhzbUx4Q1BWR0w4QlRiclMxT2VMZlluWW5mNjFqQnZFRVVhUFA4T0dJ?=
 =?utf-8?B?YmxyQmR3RHg2aE80T2FWdUR4SG5lMGdFUGthcmlDSjBFeVFob1ljTHFpd05j?=
 =?utf-8?B?NEZoalBWRElNOHZUUFpDSXJkMmxEV1dQUGd3cVdsWHdRdnoxK2kray9qQW1Y?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eea4227-7d2d-476d-e62c-08dbe44c4bd3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:27:34.6480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV19+k0mt/Dzf3CS5ZyYjbHlpgHO3EbbEUxmizl0L66idP0vLWkjFrTSlChHstOPtjos4zMGKrLg2hWOoJddAd759cqESVANEUiQMU9T7Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.2023 13:58, Ivan Vecera wrote:
> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
> VEB or VSI by their SEID value and use these helpers to replace
> existing open-coded loops.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Only one nit
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
>  3 files changed, 64 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index 1e9266de270b..220b5ce31519 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>  
>  struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>  
> +/**
> + * i40e_vsi_get_by_seid - find VSI by SEID
> + * @pf: pointer to a PF
> + **/
> +static inline struct i40e_vsi *
> +i40e_vsi_get_by_seid(struct i40e_pf *pf, u16 seid)
> +{
> +	struct i40e_vsi *vsi;
> +	int i;
> +
> +	i40e_pf_for_each_vsi(pf, i, vsi)
> +		if (vsi->seid == seid)
> +			return vsi;
> +
> +	return NULL;
> +}
> +
> +/**
> + * i40e_veb_get_by_seid - find VEB by SEID
> + * @pf: pointer to a PF
> + **/
> +static inline struct i40e_veb *
> +i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
> +{
> +	struct i40e_veb *veb;
> +	int i;
> +
> +	i40e_pf_for_each_veb(pf, i, veb)
> +		if (veb->seid == seid)
> +			return veb;
> +
> +	return NULL;
> +}

I would prefer i40e_get_{veb|vsi}_by_seid but it's my opinion.

> +
>  #endif /* _I40E_H_ */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index b236b0f93202..d26348db125f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -24,37 +24,13 @@ enum ring_type {
>   **/
>  static struct i40e_vsi *i40e_dbg_find_vsi(struct i40e_pf *pf, int seid)
>  {
> -	struct i40e_vsi *vsi;
> -	int i;
> -
>  	if (seid < 0) {
>  		dev_info(&pf->pdev->dev, "%d: bad seid\n", seid);
>  
>  		return NULL;
>  	}
>  
> -	i40e_pf_for_each_vsi(pf, i, vsi)
> -		if (vsi->seid == seid)
> -			return vsi;
> -
> -	return NULL;
> -}
> -
> -/**
> - * i40e_dbg_find_veb - searches for the veb with the given seid
> - * @pf: the PF structure to search for the veb
> - * @seid: seid of the veb it is searching for
> - **/
> -static struct i40e_veb *i40e_dbg_find_veb(struct i40e_pf *pf, int seid)
> -{
> -	struct i40e_veb *veb;
> -	int i;
> -
> -	i40e_pf_for_each_veb(pf, i, veb)
> -		if (veb->seid == seid)
> -			return veb;
> -
> -	return NULL;
> +	return i40e_vsi_get_by_seid(pf, seid);
>  }
>  
>  /**************************************************************
> @@ -701,7 +677,7 @@ static void i40e_dbg_dump_veb_seid(struct i40e_pf *pf, int seid)
>  {
>  	struct i40e_veb *veb;
>  
> -	veb = i40e_dbg_find_veb(pf, seid);
> +	veb = i40e_veb_get_by_seid(pf, seid);
>  	if (!veb) {
>  		dev_info(&pf->pdev->dev, "can't find veb %d\n", seid);
>  		return;
> @@ -853,7 +829,7 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  
>  	} else if (strncmp(cmd_buf, "add relay", 9) == 0) {
>  		struct i40e_veb *veb;
> -		int uplink_seid, i;
> +		int uplink_seid;
>  
>  		cnt = sscanf(&cmd_buf[9], "%i %i", &uplink_seid, &vsi_seid);
>  		if (cnt != 2) {
> @@ -875,12 +851,8 @@ static ssize_t i40e_dbg_command_write(struct file *filp,
>  			goto command_write_done;
>  		}
>  
> -		i40e_pf_for_each_veb(pf, i, veb)
> -			if (veb->seid == uplink_seid)
> -				break;
> -
> -		if (i >= I40E_MAX_VEB && uplink_seid != 0 &&
> -		    uplink_seid != pf->mac_seid) {
> +		veb = i40e_veb_get_by_seid(pf, uplink_seid);
> +		if (!veb && uplink_seid != 0 && uplink_seid != pf->mac_seid) {
>  			dev_info(&pf->pdev->dev,
>  				 "add relay: relay uplink %d not found\n",
>  				 uplink_seid);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index c410fc31a051..e7be145f298a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -13120,18 +13120,14 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
>  	struct i40e_pf *pf = vsi->back;
>  	struct nlattr *attr, *br_spec;
>  	struct i40e_veb *veb;
> -	int i, rem;
> +	int rem;
>  
>  	/* Only for PF VSI for now */
>  	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for PF VSI */
> -	i40e_pf_for_each_veb(pf, i, veb)
> -		if (veb->seid == vsi->uplink_seid)
> -			break;
> -	if (i == I40E_MAX_VEB)
> -		veb = NULL; /* No VEB found */
> +	veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
>  
>  	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>  	if (!br_spec)
> @@ -13197,17 +13193,14 @@ static int i40e_ndo_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
>  	struct i40e_veb *veb = NULL;
> -	int i;
>  
>  	/* Only for PF VSI for now */
>  	if (vsi->seid != pf->vsi[pf->lan_vsi]->seid)
>  		return -EOPNOTSUPP;
>  
>  	/* Find the HW bridge for the PF VSI */
> -	i40e_pf_for_each_veb(pf, i, veb)
> -		if (veb->seid == vsi->uplink_seid)
> -			break;
> -	if (i == I40E_MAX_VEB)
> +	veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
> +	if (!vsi)
>  		return 0;
>  
>  	return ndo_dflt_bridge_getlink(skb, pid, seq, dev, veb->bridge_mode,
> @@ -14382,8 +14375,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	struct i40e_vsi *vsi = NULL;
>  	struct i40e_veb *veb = NULL;
>  	u16 alloc_queue_pairs;
> -	int ret, i;
>  	int v_idx;
> +	int ret;
>  
>  	/* The requested uplink_seid must be either
>  	 *     - the PF's port seid
> @@ -14398,18 +14391,10 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	 *
>  	 * Find which uplink_seid we were given and create a new VEB if needed
>  	 */
> -	i40e_pf_for_each_veb(pf, i, veb)
> -		if (veb->seid == uplink_seid)
> -			break;
> -	if (i == I40E_MAX_VEB)
> -		veb = NULL;
> -
> +	veb = i40e_veb_get_by_seid(pf, uplink_seid);
>  	if (!veb && uplink_seid != pf->mac_seid) {
> -		i40e_pf_for_each_vsi(pf, i, vsi)
> -			if (vsi->seid == uplink_seid)
> -				break;
> -
> -		if (i == pf->num_alloc_vsi) {
> +		vsi = i40e_vsi_get_by_seid(pf, uplink_seid);
> +		if (!vsi) {
>  			dev_info(&pf->pdev->dev, "no such uplink_seid %d\n",
>  				 uplink_seid);
>  			return NULL;
> @@ -14437,10 +14422,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  			}
>  			i40e_config_bridge_mode(veb);
>  		}
> -		i40e_pf_for_each_veb(pf, i, veb)
> -			if (veb->seid == vsi->uplink_seid)
> -				break;
> -		if (i == I40E_MAX_VEB) {
> +		veb = i40e_veb_get_by_seid(pf, vsi->uplink_seid);
> +		if (!veb) {
>  			dev_info(&pf->pdev->dev, "couldn't add VEB\n");
>  			return NULL;
>  		}
> @@ -14835,7 +14818,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  {
>  	struct i40e_veb *veb, *uplink_veb = NULL;
>  	struct i40e_vsi *vsi;
> -	int vsi_idx, veb_idx;
> +	int veb_idx;
>  	int ret;
>  
>  	/* if one seid is 0, the other must be 0 to create a floating relay */
> @@ -14848,23 +14831,16 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	}
>  
>  	/* make sure there is such a vsi and uplink */
> -	i40e_pf_for_each_vsi(pf, vsi_idx, vsi)
> -		if (vsi->seid == vsi_seid)
> -			break;
> -
> -	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
> -		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
> -			 vsi_seid);
> -		return NULL;
> +	if (vsi_seid) {
> +		vsi = i40e_vsi_get_by_seid(pf, vsi_seid);
> +		if (!vsi) {
> +			dev_err(&pf->pdev->dev, "vsi seid %d not found\n",
> +				vsi_seid);
> +			return NULL;
> +		}
>  	}
> -
>  	if (uplink_seid && uplink_seid != pf->mac_seid) {
> -		i40e_pf_for_each_veb(pf, veb_idx, veb) {
> -			if (veb->seid == uplink_seid) {
> -				uplink_veb = veb;
> -				break;
> -			}
> -		}
> +		uplink_veb = i40e_veb_get_by_seid(pf, uplink_seid);
>  		if (!uplink_veb) {
>  			dev_info(&pf->pdev->dev,
>  				 "uplink seid %d not found\n", uplink_seid);
> @@ -14886,7 +14862,8 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
>  	ret = i40e_add_veb(veb, vsi);
>  	if (ret)
>  		goto err_veb;
> -	if (vsi_idx == pf->lan_vsi)
> +
> +	if (vsi && vsi->idx == pf->lan_vsi)
>  		pf->lan_veb = veb->idx;
>  
>  	return veb;
> @@ -14933,13 +14910,10 @@ static void i40e_setup_pf_switch_element(struct i40e_pf *pf,
>  			int v;
>  
>  			/* find existing or else empty VEB */
> -			i40e_pf_for_each_veb(pf, v, veb)
> -				if (veb->seid == seid) {
> -					pf->lan_veb = v;
> -					break;
> -				}
> -
> -			if (pf->lan_veb >= I40E_MAX_VEB) {
> +			veb = i40e_veb_get_by_seid(pf, seid);
> +			if (veb) {
> +				pf->lan_veb = veb->idx;
> +			} else {
>  				v = i40e_veb_mem_alloc(pf);
>  				if (v < 0)
>  					break;
