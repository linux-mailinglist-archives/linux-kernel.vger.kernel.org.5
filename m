Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8837F4149
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKVJMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbjKVJMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:12:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA63F9;
        Wed, 22 Nov 2023 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700644319; x=1732180319;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=YNrUPRhtMrgwYVcE4OSA5pwPGV7sv/WCTCaoNYNvia8=;
  b=e4dkubQ7M0viIS7iOoUwCUlDiLHfwbTCaIqqbEoJd7VmmUpxlU8jJXOI
   sN/NPuXBo8OGDA74P3jgUHQac6bsXCPmXbOsG7RJEoLhq3GgnishV8AJF
   YGJYXTcSbvWg/ZcAJZxlTh03Du//Y/pg1eIOO8dpoou6+l6X+tomf6le6
   KGtBQtU2XnwxKa5kq4trNsUd9MH9GdXviGZHG+EEoC3DPq6drsqgq4vJR
   jBgVFkCgGAYj4LdUH8FqxV35GRaEQsueJs/c2hhoLkPpX156Y7PbcUowm
   lVdaDohV3gQWYI1d8TUC5cTNSRXAIVJG8wBthELQZnY5fU9QslzBnD8Qx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5158169"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5158169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="857647160"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="857647160"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 01:11:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 01:11:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 01:11:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 01:11:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgaAYLOKW4ge3FQCd/ghuqGuFOjsKOs5UYtkHYdIErbfcGJ/MpMax/whCmnFfaXUwCK3yt6OiF0cTobju1mVQs6OhrGStMvZbzNlMyFzclxiVkvR62O3Ani6NAX156laN1T0kf3qxMnzRJPN1bFqCRbfWmPQbLPY4GrN2LWzScwNRPioDsw6oBq6eqrcNKRgBLUNKEMmim9mqA8eTp23qSFJuQwo4U7wMrT/7RWONtSM5lSznhHPxJ0r7CczZOdSZlW84t47WLnS286gJ9bh+PaQJJyQDW2N6wbGch5ASKNj63SN2Wm+PcwyFam4BSnNgc58Oi/KW2Cl5FnnXf62fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqQlQ37+38gH/4PDWQv8Ncisjf6w89+7pzkcBDLxl3g=;
 b=WYszSdIcn/zy1uYrPD35dZPcndQHF2hpCNHiTRCeHxLX2k7Hm5gu+aXOGuqBJ2zg8iNuu/NDazRogTi3OC0deuiMjRyP3JSl1xNM6DWi4DHZ1nHigbZw2w46WyDQA3ponSAGuyQ4aqwERkHJXWpVu0aI62GoVmjR5rvf7Pd9VkM8xxZ76HbWuEv1A+tvEgP8+b+9GX+tYH1DD8tmKfFEUjwGf8ZZwix3qEwGXJSSIExh/5HhjScV1iTJzViA3bHBufI1D8Ji/HSTrLyngdNSFKUU9jve4SEU0hbBtgiWU1jmcDirZ5wPXKNkfyvj1InjMkL4EDvQOcIKQ7TnEXdIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS7PR11MB6080.namprd11.prod.outlook.com (2603:10b6:8:84::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.19; Wed, 22 Nov 2023 09:11:54 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 09:11:54 +0000
Message-ID: <7dcd5d24-800b-4c58-a308-e0fda2b8dfbc@intel.com>
Date:   Wed, 22 Nov 2023 10:11:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v2] octeontx2-pf: Fix ntuple rule creation to direct
 packet to VF with higher Rx queue than its PF
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
References: <20231121165624.3664182-1-sumang@marvell.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121165624.3664182-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::10) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS7PR11MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f1cd7d3-14e8-4143-0197-08dbeb3b120b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6p/lLxzlO3ANrBBJ8W+mUcnpVrt/A45esobisYhd2kYEop7y57tqYtd4eBw8JNfMLS+wdM51qTx/Gdq7n1VdIa3mtzFmhQbYsQWkde/7t23+UCz7Jq1xvDZBGE2iomuO4tqNfCs2LAbUarwnoht0F2WLKwqJ4YqYgvnh5NmYHaSszqQz3FJ9/Y8MOi+8UmxAbOeVkDIYX3TKCl+ZaRX6U2BJvHFEtQlY8kb1QjwA0LWOKXW7zLTxHeO3pVsFwObpFnR8NuU7tfd/hkzNYwVWWbOdTScz1ON9XfdkXIob2rZGUDAzSgjo0300++k83I5xvpmnNmyEtz7h/P+g9cQjhoalxl7yH9TFxTWJlMmhhgj9u+kDPVpqVedvk2Y89D34T3yV54xk4IMwZpOLufc7HBnyixeGgyVVEdlSkOjjnrCMRHSDNcGhHTxtLCDbaPmq4OQt+vl1ySdEEqP9zvlESSrm9eLMWWVdOGOe1Xpla/yDqr5B8iVoGG47gBibBdsg7AH4cs+I2SdASKwQt+vheGXjNHpuKMWhkbqjVPQqn1hEIUIHhfnGQSYB/cBhca+8CscbSj7bEyBLhX2IhHQOiMnTVydBOHx3Itc0PDAhJU+Kaj/gJ7UJq9fsgugaMuZuwwARVegq6A4VdoCLJnzjiCzDSUnZwxGYKptXrJ+jcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(2616005)(26005)(6512007)(82960400001)(36756003)(86362001)(921008)(31696002)(38100700002)(7416002)(83380400001)(5660300002)(44832011)(2906002)(6506007)(6666004)(478600001)(53546011)(8676002)(316002)(66476007)(41300700001)(8936002)(66556008)(66946007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTNPNTlWTTM5U2JrV3dGbjZSWStaZ1FQbm9PekQ3L0NIcWVaL2RMQXpRcjds?=
 =?utf-8?B?WkdtWXRYaUoxVUEvYmtkMVdzTkFlOVZ6cWNmZ2RJbHdVY3dTWTlrK1o0YUR3?=
 =?utf-8?B?NTFGU3BkV3RRL0FtRFBKaE9HcTAyRVpTSmhGdTFvVWUzaGQ4azAxQTc5NVM2?=
 =?utf-8?B?M29SSjc5SVFzNTM0Y3ExWEhSVVlxN1I3YlBVeWRYU1hFMlRMWVdYVVJBeEVw?=
 =?utf-8?B?ZDRwZFNSWkhQZXdEcHhBcWx2d09ycU9Obm9JNWdHZCthQzdKWFJzOUNhYkFT?=
 =?utf-8?B?ZG5IQlVINHFXMXlITCs3clRLQWU0cldmZ2pyMU5lN2g3cHFSbGtwTlFvTTFL?=
 =?utf-8?B?QW1YQWtKcjZSRkY4K3cvN0NpQldteXd1bDNPS1VnZmkxVFlVRVhaR1FyWDZH?=
 =?utf-8?B?dUFvbFFNUmRFcE5hR1grbk9HWXRsNlllbW1pTzRwMVB0Z1lYQmdTVTNMK1JP?=
 =?utf-8?B?c3FtN2VzcFpBckw0OTRUdGJ4TklaK0thdUFobzdFdHFHcWVzR2k4VGpXbUdz?=
 =?utf-8?B?WVlSSUVkTjFJcS9SdmYvT2VqMGc0ZDVsdUZSUDg5SVF4NmRhYm1Sb3JHNnkr?=
 =?utf-8?B?S3VlZTBXUEdBcVJyZWNrMk1pUjNtblU4a0NoMEQzYUUxVmlMemZMNHJ1cnFy?=
 =?utf-8?B?Y083UUdCUk1udmxyVDdqMGJZMlZsOHY2SkNiTlFObXJVNWg4ZTdvY1lDMmF4?=
 =?utf-8?B?WnhqMllxa3BydEowblpMc2d3M1Z1WTE5VXVDSWxlMGgxQjQ4cUhZNDUrallh?=
 =?utf-8?B?aUhwN05qdFJZUDU5OFlGUkRubXlCNmpCc200THA0TytscGliUHlNQ2JKZ3ZG?=
 =?utf-8?B?a2pmczIraGhKWEVSdTgxRkFTVnpNMVB2WElPbk1CMjhFdFZHQUNoajFkWita?=
 =?utf-8?B?VVV1bkk3Z1JCNWw4ZXMwb3NNSEpuNllFRkpEbjBnQWNFNVlrM2NBOFRJMmVD?=
 =?utf-8?B?SzRhVUgwT2c2TVowMGxlZ01mWDQyelNtYTVNaXg4UWNtbWY3M2xQWDFNcmZ2?=
 =?utf-8?B?eHNiMGFJdE5NY0M1czNTUVpma3ZSYmI4WFhSWkU1VUtQdHpVb2FBSmhSM1h2?=
 =?utf-8?B?Uk9nVVV5UmpqNld6ZEhOZlpJOWl6TWFveGxaY1BWajRLNkVMb0c5QkRpNWNJ?=
 =?utf-8?B?a0NuY1IybEExdzBOa1J1QkIyZEZrM2dlOTZtZ0RoT2VPSm1xVmoyVGY3d1dh?=
 =?utf-8?B?c3dSSUhHZlRobWFFWGJoNVAxRGxob2FNV3F0UldFdnFtMW1BQXJrb3MrSDJr?=
 =?utf-8?B?cnZZL2w3M3F3QkJ2OEp4cUxCRmkzZmlNWHU2d0dSbkpoTjFLdlU1RnBuVW5G?=
 =?utf-8?B?NXBMaTdDMjRuRGVHZ0F2Qm9XRWVrTjl0SnBodmcwQWFacGJiZmR0V1Y5K1lP?=
 =?utf-8?B?bm9rNjBjM29wMEEwck1kZnVrcjllSTFidnltN2tWSUVuWlZRZ0JWSkNZc0JK?=
 =?utf-8?B?NWpqeHZZRVpCWktkU2xjMW5velIzTVlXQTlDS3FEbHYyeDJ0NHdHT0thVTNG?=
 =?utf-8?B?VjlvNGNDT3ptbFkxNVEvOFdtYkdOekR4K2hCcGZWS3NiUUVSV2p3czN6WHYw?=
 =?utf-8?B?dUtyMGNjZUFPTHB1OXFQNzBXNVB5Ymg0dVRjR0pPejBPRDI4cFhpYzR2VzVt?=
 =?utf-8?B?cDBVVG5XcHFLRFE1Y3Y2YXcvM290Q0U4NFlBZ0tYOGw1bkFJVVN0cGJsUUNF?=
 =?utf-8?B?TlpEclRaT1VBWjhuejAzTGl3WlhJZjltSEhyV20wM3Fmcjc3dmFycXh4WXhD?=
 =?utf-8?B?blJ0bi9NcnBoNjZOV3FlTFRzRWhvWnpEbVpkenh2eFFPNy83Y3VDMWxEazVh?=
 =?utf-8?B?RC9MN1pySk4wMTZlWUNkWkFTd3VqV2ZuOFFpVFdKZWVYcnM0d04xQjR3RW9S?=
 =?utf-8?B?eDQ5ODcvSDIvQWpZQlp5ZmNwMWlRVE5Pc0Vqa1Z0bUNaME5LM2QvVE0wVWQr?=
 =?utf-8?B?QmZ5Ly9WaEtSRFZxKzJ6ZmxZWlgrbGFwdUtETEM1NUFBSE41OEdNT0hRbDJY?=
 =?utf-8?B?TXUyVUNpTEFDRmN5a1pSUmV6cUVOU1JxVndRQld0NUFCYmRzdWh1R0NBUGhi?=
 =?utf-8?B?bGprTjZnYTM1YjFNc1M0bHhhUlJhZURCbnZ0ODJ5Sk1vbG1aWVBjNE9zdkI4?=
 =?utf-8?B?cnVqYkVndlBxMUNxSVRvek1hUytNeFFXcXhlVVNZWjk3clpFeHFQZ21wMWZH?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1cd7d3-14e8-4143-0197-08dbeb3b120b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:11:54.4067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i1AKET7lVbBesjfFhjzViu4MNGLE4GQPsysltbYMgjWCyC8F8BY/90/SBO3vjvflTXPmD1OiUxIf5oMkp3OE2JI59CZBgi7D5zPiARHJ7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6080
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.11.2023 17:56, Suman Ghosh wrote:
> It is possible to add a ntuple rule which would like to direct packet to
> a VF whose number of queues are greater/less than its PF's queue numbers.
> For example a PF can have 2 Rx queues but a VF created on that PF can have
> 8 Rx queues. As of today, ntuple rule will reject rule because it is
> checking the requested queue number against PF's number of Rx queues.
> As a part of this fix if the action of a ntuple rule is to move a packet
> to a VF's queue then the check is removed. Also, a debug information is
> printed to aware user that it is user's responsibility to cross check if
> the requested queue number on that VF is a valid one.
> 
> Fixes: f0a1913f8a6f ("octeontx2-pf: Add support for ethtool ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> v2 changes:
> - Removed 'goto' and added the new condition to existing if check.
> 
>  .../marvell/octeontx2/nic/otx2_flows.c        | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 4762dbea64a1..97a71e9b8563 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> @@ -1088,6 +1088,7 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
>  	struct ethhdr *eth_hdr;
>  	bool new = false;
>  	int err = 0;
> +	u64 vf_num;
>  	u32 ring;
>  
>  	if (!flow_cfg->max_flows) {
> @@ -1100,7 +1101,21 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
>  	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
>  		return -ENOMEM;
>  
> -	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
> +	/* Number of queues on a VF can be greater or less than
> +	 * the PF's queue. Hence no need to check for the
> +	 * queue count. Hence no need to check queue count if PF
> +	 * is installing for its VF. Below is the expected vf_num value
> +	 * based on the ethtool commands.
> +	 *
> +	 * e.g.
> +	 * 1. ethtool -U <netdev> ... action -1  ==> vf_num:255
> +	 * 2. ethtool -U <netdev> ... action <queue_num>  ==> vf_num:0
> +	 * 3. ethtool -U <netdev> ... vf <vf_idx> queue <queue_num>  ==>
> +	 *    vf_num:vf_idx+1
> +	 */
> +	vf_num = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
> +	if (!is_otx2_vf(pfvf->pcifunc) && !vf_num &&
> +	    ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
>  		return -EINVAL;
>  
>  	if (fsp->location >= otx2_get_maxflows(flow_cfg))
> @@ -1182,6 +1197,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
>  		flow_cfg->nr_flows++;
>  	}
>  
> +	if (flow->is_vf)
> +		netdev_info(pfvf->netdev,
> +			    "Make sure that VF's queue number is within its queue limit\n");
>  	return 0;
>  }
>  
