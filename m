Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91967F12A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjKTMCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjKTMCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:02:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F175B98;
        Mon, 20 Nov 2023 04:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700481754; x=1732017754;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=acGWDxNtd3EG+2MZx5ZXCYbseWXlGQTlQBZ+MuKJN2s=;
  b=NGE7Gr7bkWIhrwLxrDnRJ0fQ4Ks4IYEJd+T7LJuq5YJzrOfwpIcXGlH4
   yr8uDEPaZcm5p6kqPcU5XxMhrRH932u9xvPx7IgJ9glDpyokpMd8x01tR
   4nlNfejRUgee+PaHHAlkWdA0QRJj6qQi3SIBWiqO1OgAIxq2heczFlCqd
   bfn4SBJYK8j3H6tS8OglBiTUxbqYt2lkjNJ/H1aq7nh2MyHh2nds7mzft
   XCHzQQEYiDMpOXi0LvP+AcvajVgvZnPxikpAdG4ph1QEQrVSPxjrn0Y7e
   i/ZTQ0OMOUC6lbX681GSNQc1jqJuudizqJGxcwLKwuJ23cqlTpktmfzBP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394454231"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394454231"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 04:02:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7697095"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 04:02:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 04:02:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 04:02:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 04:02:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLgZDlRbjHc/KP0HxSOSJ1pkbzHf1PDfK3Mq9L98MFcONSBVmqa1YRv3GYfKi15JNLx8f7WMShQSldEOb42ETfFI7P+pfCg6EfPaoZ26i8MR3dVQ2hX1C0cWvoIKLPlUCP+FWYAJBf9R6JRKMTzO4uzuIRuEwJOsU2CC3P6uBHblPbrzWXt4PUxx1aDdo3P6KntSWyofMKqMI0CFJLiqURSmjE950G4RVJM31yb8WhM9uYTjQGixxGAi+BPsPrxN2xOA3S298d+dYfzahT9hkUaIzxduxXfsdwvuF7BwGlYhPgKIEYHzN7BtmajkAoPWSSH8DipeHR5IvRwtBMfV8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIZsYJD4q8d2IUMPVNpO/07FS2RqAx7qjmYM54WkKEo=;
 b=RTNIUgBvS+jrh58FYnA/bNNxBd5TxkDjSakfAbdQb8JVg/1DJI52K0JJFE/hlU6R7DjvQ2ySIJAc/xTR8IgU7zWO8qaenY+q10XpJKrBO25XR1TCjlPF/O5jofcS40RS3V4WxW7fvS88noAl/ox9GUXSF040DgPUEKXkgNAucDm8nGKfGzR4b/fivoO8yvDMzS6K7Bxry1Mvuipu0d6SWCYLHEklQ/ejq8itYa3r3Lr1oCNp6dDxerbxgEwNDVjSxXgzxm8B+I8Mr1b8kRxoS1Lhjwb5P6wttJkynlQx3jQBksH2zMTUhuO8rgJOWdHt178MJDOIVbHg5K7pO6TQJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 12:02:29 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 12:02:29 +0000
Message-ID: <745e6518-6253-4ef0-8f05-1421ee4e1fef@intel.com>
Date:   Mon, 20 Nov 2023 13:02:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH] octeontx2-pf: Fix ntuple rule creation to direct
 packet to VF with higher Rx queue than its PF
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>
References: <20231120055138.3602102-1-sumang@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231120055138.3602102-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d8e302-c10f-4350-3965-08dbe9c09183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ftQU9LHcd8rToAGdc9jPlW/GCGIa8Hi0O4oSllKXe5t5caU+OjbLwk2LYbokMhkIml0Z+WhFM+/VHfTlQ72uQB5ngyZnGAE03k4KWsu1C1zMnOrzul+8FTc6cLMDzlD7vONBNZXpRgDxbZ9HsD5lQPwCqlsdcgPHG2X/qTvwOobLf3n1Md9RbotyI19Cdh400Px+YqGtCHvlkgyoGs/Ta+jkrbL1hFYz23z+5x//jLMJgYxTl+rasfxQ+OJU/OpYTWj0rT4CApKQGA9Ff+aBjjmUNfzLzgWhyeV2kMsrJSz1egk5WWCbLbrV9X5bZYc42RB271cD9trlHP0dhW6DNHrF68eMKWxv+aU+K9BpUBPyju5PHy25rArRPPz7115PX1BEy6SvCVDHyU9Yu0t1Yz17aiUCrdnZyZIZdB0a7v9r/eKeZwNlxLEXczoiqPrgRCTx8uBbnICp/XInhc0LqJ/KDM//xD0+Fn4wC/hA5t5UjnyUUf4OrO/WEGpGPFoqkXHL9pDuBhNrFitSebKqWBpsp+e8lW8TnGkqDKwhc8wjEtR6IGJZtAI+gutdtyLso4gyaPfZnwtR4BUCJ+wGAjGVRWT+GL9b1WTisUpyMBQzfmm2cWYoJVLDT1SdZysyjKJzazfqgW3X9GoND7mOIieW/f4PysczXvERqHJU7+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(41300700001)(44832011)(2906002)(6666004)(7416002)(5660300002)(83380400001)(921008)(8676002)(36756003)(8936002)(316002)(66476007)(66556008)(66946007)(6486002)(478600001)(86362001)(6506007)(53546011)(6512007)(2616005)(26005)(31696002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnNWSnJ5eWJTRTRlUUJQWnNENzNxTzEybFBmRlBTWUdwMUx3VkhLTmFzaGpE?=
 =?utf-8?B?QlNGalphTGNPRFhqSjRkMUs4MHlsRGprcUJCd3lCaUJwbEdoUkpNQy9sSlFK?=
 =?utf-8?B?MWRYZjVmM1o1M3RLaUJuMlR6bXBJamVWeE9MT3c0SEhRcC9WWnA2clB4VXBI?=
 =?utf-8?B?akZsTGJMLzdyK2ozdUlla2tQcUdIaFVjTWUxWEdPOEhacjJQUG13NmM1TmtI?=
 =?utf-8?B?N0ljY1FhYzRqN0NrNDlMaStWRkV2SGFkVXZiWWxkcExVU0lqK1BXMXQxRm04?=
 =?utf-8?B?czZhdVhac0NiaFZvSU8xaW1kNjArelhQKzhzd1BWbUVpK0lFbklDUGJxSmE2?=
 =?utf-8?B?WnJ5NnlDSGEya3RUaXBEckpSWkZuY2NPL0RZaFpGQnZxRkc5L0JVaExDQ2J3?=
 =?utf-8?B?akdTOGdPb3VRUTVWK3NWeVBmS0RDRW1mWkJ4SUl3a3lxcmxJaXI1eXFVR2hz?=
 =?utf-8?B?bG5nVTlWUlUza0ZZaVBlMjJTZUFVRHhQc2R6dVIxNkFNLzFpMnRHSEl5YzFT?=
 =?utf-8?B?cUxLQk5HV2t6RW1tOTQvZ1RzWFdIVW5BeFl3VDFBV2hTUE1JRHQxWkw4TURu?=
 =?utf-8?B?c1MyaWwrL2QyZCtwNFUvV3RCTjFrYUwrN2hXdGdjbzliWUJmell5REdaSEQ4?=
 =?utf-8?B?YXlGSE81ODhXUWUzMUxxZDNTRERjMkNnTWJhRTVIQlppY0dvNmxrWWJuaTRG?=
 =?utf-8?B?Y3NEaWFTYjI1emovdkh0SitoM1M3Rm83VEo0Zi9XeDV6ak1qWDhnSUJiM2lt?=
 =?utf-8?B?T2JoU0QzOGlqQmYzcmFJd0FqSHR5djh6SUdvQXZWUVlPZkVlL3A5MDhxYlFu?=
 =?utf-8?B?QVh4TTNBNnNlbDIvYUNsMFUzSDhNR1ZHRU5Bb3dQVEx5RzV2QTVyWkJWd1p2?=
 =?utf-8?B?V0U4eXAxaTRoMm1aQTlCcEo4YUJ4eS9JUjBiSEtLaklONUtoMC9SZXpiS256?=
 =?utf-8?B?Zk5WVGRFZUNDWTBxb05XZzE3dWQ0THltdlAvM0lVUS9FSXlacStBbXdXU2JC?=
 =?utf-8?B?TzBnZ3phL2x6dWFzaHUrSmRTdHZXRXZ0YWh4bzBGNWFqcXNCdDQzR0tPbG5F?=
 =?utf-8?B?MFcwQk1zeUZDL3B3T1FjQWE4LzFEYituNGplNHZXY1RrdmNmNERTdG1UTVZo?=
 =?utf-8?B?MDdrMG1Mb1JiTTlpbk80UkNSTDhRWG01M0xBd3VkaktGQ0hjVUkrdTU4aFp5?=
 =?utf-8?B?aUZkNDdxdlZKV3ZSUFhodlJudVJQcXkwZ29rZWFJSkVZdTgyN0tNQWNGNGdZ?=
 =?utf-8?B?QkJGSWxmcE1YSDJCNklYN3hzb01HOGdnNFo1cEZJSUlhSjVyUm9JK3F1Q0tz?=
 =?utf-8?B?TXpXN2dvc0dWSDIzZXZBVVRhcTVPVjYzNkE4OGJ0M2xlY3BpZ1A5RjBFZUdu?=
 =?utf-8?B?aWNxdCtTZWNxdXVuaHhJc3pJS001NndxeVBoOEZCYkZJLzd1amsybk5pR2xU?=
 =?utf-8?B?TVl4Y2JyQUdSSEpQOE52MkF4RXRRNUIwYjQwM0g0bW1DdGQ0RUtuelVWRjI3?=
 =?utf-8?B?M3JmNGZORklYbnFCSVdVNkgxMVBKYWdPRjFnNi9lTkM1Q3pGTmhJQjFHR2o2?=
 =?utf-8?B?eis3aytxVFpwS3RYVk9hVXYrZ0ZoMzhsTzlBVzRoN0tYbXUrZ2JFYlBHK01q?=
 =?utf-8?B?Z3gvbDdRcDQwYWFySEwvRlNWV3VmQ3IxenQwQSt5U2hhaWlqa0s5OEJpRENH?=
 =?utf-8?B?MzArTGV4UVo5RWcxQzRoWTFWa2ROaTRVSmxqM2RkUkF2Vzl6RUNIQlhiVEdW?=
 =?utf-8?B?M2hUdG9hL2VEQTJWRnBsL2dEMFlCVFBkZS94aVlsSDlablluQzNKVVVqZ0o2?=
 =?utf-8?B?QWY5ZWNnVjR1S2VFcVdtOHFrdTJSWVdiY09uaGpMbGFMd1paa25rT1NKeHpM?=
 =?utf-8?B?bXZXcVJTd3lsejluU3VRL2N6aHdFbU5vRkV6Yk1XUXlHSkI4Z21WV2ZtY09a?=
 =?utf-8?B?dnVRNkpoZm9rckt0WUFwcm5kemNuV1NIVFA5Tk12Tk04Slc1WGlLdGFybVVE?=
 =?utf-8?B?WU5FOENZc2hvdU9WVHJFRGx5Q0x0WGYwR2w2NGtVbDZuZjk4dXFTWklydksw?=
 =?utf-8?B?anFtVHdSVXdjNkFSMk9YMGhkV2pGa0d3UDVoR25RbEVqdUs0MHVodk92Y2VX?=
 =?utf-8?B?eDJQeTgxVWlidXU2cUpveS85dllmbVVDUHV0ZWc3TzFnenpCSngrT1NZU2lk?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d8e302-c10f-4350-3965-08dbe9c09183
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:02:28.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBAkZmyt2m8elkZizkEuobZfYobS4AZw5k5u3b+ezD5SdKBCbjdyrlAuR3XvsYbaEPtyNXdJvZBpuDZa8dWlKXI4U0Ceymc1mFbYmCSstY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.2023 06:51, Suman Ghosh wrote:
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
>  .../marvell/octeontx2/nic/otx2_flows.c        | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> index 4762dbea64a1..4200f2d387f6 100644
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
> @@ -1100,9 +1101,26 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
>  	if (!(pfvf->flags & OTX2_FLAG_NTUPLE_SUPPORT))
>  		return -ENOMEM;
>  
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
> +	if (!is_otx2_vf(pfvf->pcifunc) && vf_num)
> +		goto bypass_queue_check;

Let's just add this condition to the next if, no need for goto.

> +
>  	if (ring >= pfvf->hw.rx_queues && fsp->ring_cookie != RX_CLS_FLOW_DISC)
>  		return -EINVAL;
>  
> +bypass_queue_check:
>  	if (fsp->location >= otx2_get_maxflows(flow_cfg))
>  		return -EINVAL;
>  
> @@ -1182,6 +1200,9 @@ int otx2_add_flow(struct otx2_nic *pfvf, struct ethtool_rxnfc *nfc)
>  		flow_cfg->nr_flows++;
>  	}
>  
> +	if (flow->is_vf)
> +		netdev_info(pfvf->netdev,
> +			    "Make sure that VF's queue number is within its queue limit\n");
>  	return 0;
>  }
>  
