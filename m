Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799C79C734
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjILGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjILGxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A429B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694501609; x=1726037609;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ksOAh9l1pWWuqQj8nKuO/B+EPF1brth0HTTuRE/NaZQ=;
  b=TLmuct+O7TGtN0Tq3d2qPNPbsz45xSDdZ0OhCBvYATptZ48LaINHBT6k
   2TqTivnbtrRytUkmyEiGT6Er/xXlRvohdQxMPlyrhfSsIE4fV+jqFzVia
   r41DU7gPYcXxZZDhUySpq6ZSeLoioYJ0LA4gTNkZ+d5lB9bX0mOCTS0Xm
   oSlMrDPQ/Rbrq2RrSN7+0znF8jSQsLitVpOAF0+K/3Lon5C6wZ7NMa83K
   N348D5woRYt6Ve6U4hxRSgiGnh5xUmSMeuJyw9/GSHulKEZs/29YJcvGm
   ULpmOEkZOW7dOCmTCbr7TearMdqAmKO6APc5Hsa2RhygS262irBjGCSUe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363325304"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="363325304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 23:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="809127506"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="809127506"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 23:53:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 23:53:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 23:53:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 23:53:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1U56nh1dDmmm4OQlh49khFlBjAnFOxxJ9w9eWd6QJShzrWHgDSVlf0ywrvn/W6GKV/RwSxe7cNgGvwfqI99sxlbEY29vwQpgyg+RQgR0Rv92ZtlEmuIWrWkKOU5lG25ZlgVU+aFJr87wdc5+SAc+QBnsDIuSdxRK5ih5Yk7W+xRSs3h18oc2LoJ8VXlDBq7IWyno7jeUE6ZDQq5+4sxqt+PeVKd5wbtq6BZlBebl4iaKvWSGvEKgcRqvOW73cIYxQ/64ghh/KW1JO0IMzM74g0qVBHgPlZiv9PUuDy3BuSd5Yk18v8+gWFwq5PWl21/epmUuxPLbFruI7cpygaysQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR3ltQVDSfBpECCHbdcHOljNJDQaFDpIaiDwa2L6ixU=;
 b=Cb7EXzRE5oITlQ0lpiFwA61rmPhftfpr4MWRmLaj4X4Q3Yt1RigfqNSyBEf+5cKWy6nuY6oiNuqfcYNJjbkEcotA3JlsIGiizcFNuH4o6daEDGqFdDSTtJNiqUrAA8jelyzWnOKObXKcmMcrzozqnUt4NnJKwQEV+NbIUecAY6RtYlumJQxxWDerZyjF+hv8H1UjNTOhY11Cs/PAHS4/cZXmP837AzsaqxM6VolQO9cQ3i+f11gnuwaeHb/V+w6CszHX1zHOAzHXZkZKbY4F82jI7lMSOWI7jQMNzr77Zk74kPJap7f396aYSwsbMaGHsUVry2jCBoF6cP3kPhqTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH7PR11MB6698.namprd11.prod.outlook.com (2603:10b6:510:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:53:25 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:53:25 +0000
Date:   Tue, 12 Sep 2023 08:53:19 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] x86/resctrl: Enable non-contiguous bits in Intel CAT
Message-ID: <ob4e7sb4pfitjn7arlt7f6be3hvdoyp5yecb4o5ub3i36u2qhv@4s6vzu5nk342>
References: <cover.1693557919.git.maciej.wieczor-retman@intel.com>
 <1bd3aab725a4e2948530095eb48b11bcc4028f8e.1693557919.git.maciej.wieczor-retman@intel.com>
 <4c89d09f-c5a9-892a-4c7d-bdef0204547a@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c89d09f-c5a9-892a-4c7d-bdef0204547a@intel.com>
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH7PR11MB6698:EE_
X-MS-Office365-Filtering-Correlation-Id: 249fb8c9-7033-4ac7-e28e-08dbb35cf5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFuvgXhsvwWpK7NHxlTFvducrBT2W/++fucleoZQZNe6kZ08O4eqjN2EU2jZGOKPjM9s+vNfuzPhkVzweslf4C957e0C7SObIZN7UaXrCWne7G5DOuGyWzMjLdBs2Ynk+FmY6UEAvTIoVXGIXF5nicB0fr0Id7ENmqSohfp5+mfsro8gQSKSq72QRlt52Cya9tDTbR05mCXFtEmEi9hbCDIOr0/KFLa/96rQWFls/qqBEJe1tmTQrlUuEzLj3m/Y5fxRqpgbkeqt3LeJ7VFJOQp8AAerz/7Ud24gIu216N7eNu7tbCEi3EytVC9tnJMTLqRlRCjgei0DPVbAp1dVfkJufXXXSiq6yItFjFweSWvBKf6OZf3gkatCpeWGt9R8f4M640b3iRN3kFeDgJx+Z+EKCggJzFRU/MK9WB7vPRAIc78ebzhHnvebux/haU5lxsBe3zUYBROT8TzISzvE+CePhSvUcQ+wDEwKEvjDYP3Baq7OFbC8Wevel263jI1Wpkz6YUCXY06YJTEeL8FZG3dXUZcNSeInOX7UmGLLkcBcrmcjgD7Td4IoUzGaN9TD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(376002)(346002)(186009)(451199024)(1800799009)(6512007)(8936002)(6862004)(316002)(5660300002)(6636002)(4326008)(54906003)(41300700001)(66946007)(66476007)(8676002)(66556008)(33716001)(478600001)(6666004)(6486002)(53546011)(9686003)(26005)(6506007)(83380400001)(86362001)(2906002)(66574015)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YTs+WL5EKrZWUpQxwaFi2/OBqURH/Xn5ac1VrsQOFqAprowZfaL7tLFh6X?=
 =?iso-8859-1?Q?T1yoh/J3VeaDYYvP1/cH8JWHn3CWIx9NEs353ysWE7WN5v9H3ogeoeZGfE?=
 =?iso-8859-1?Q?7hHUiq9y68K7bRL6LvdAzcml+aMHBl37HDd1Kh5//wSNxgaAcAFKoQ6u/R?=
 =?iso-8859-1?Q?PxDgkWiaPZS3KKP8hu31+OC7z4zkjtqqvn6KE7H5i47TL8+H2+1yPQ5In3?=
 =?iso-8859-1?Q?LgV0F7MWaItkixKIuiMAhyvfhKrkYedrwX3z1CaDv2UpR8sZ9Bq7LmqKa8?=
 =?iso-8859-1?Q?H9zJeVMCMmGG/67b3/Id0IWmIoxT2qgUfo9bbwkVVEd7J5yz8pGBK81Pdo?=
 =?iso-8859-1?Q?+pwZ72oYjGYGk0gwFJPNvRXLgaEhCyOyNPo/896P685jiT8IdQZtz/ZS19?=
 =?iso-8859-1?Q?2wju9yJCHovbBRduvpKpEbgXR9V5FdMQOenwGiYLS497BZPoDDR6J8S8Oi?=
 =?iso-8859-1?Q?PKfRMhYxtdJ/axhnhVMmi/JDdyN9mzZ8gJ/9u8TGTIQr2FeVa16imdHFO8?=
 =?iso-8859-1?Q?lPtfY/eBf9MBHW6naNigbqRFi3wf0t7KtRV8lxeYCabzSrveIVVBWbv+Gl?=
 =?iso-8859-1?Q?fyZaVbZ1Rx+ISL2OwNxEgLD/GXVbqeKVJBvYfWgamK1qQjlOUaiBew+pIG?=
 =?iso-8859-1?Q?SskRQG08iwa7sLh/gJcWU4NNZTuGRlylzK8QpnCE8xPuNGYpaktey0TofT?=
 =?iso-8859-1?Q?meyvg1wUGAFhxMHKSVgpUy9s9iIY9qOvqQTqkokcUpJ18WnCg2RIkNUkBo?=
 =?iso-8859-1?Q?S1GhZpK1jdCxO7eSQbnd8j22bRwkD8yrbVB5UmM7bKKAPbPE88KNkLmXJX?=
 =?iso-8859-1?Q?1HsfRjKKpjR834sduiHDtPxfcbKl4WI35bFh9K5hTq3vZFRiw6BpOxVng3?=
 =?iso-8859-1?Q?AH7FDXz4TYMZGM5QcITEXFuclWdckRF1yVBDSVKVW1NYTwoWRTYBog3Ik0?=
 =?iso-8859-1?Q?H0DccinPMMEL+n5lfUwvCXzV5rDQvD7kU87JTdGZDtuRcyJVnEgzHRs93y?=
 =?iso-8859-1?Q?NKkk80pdh4I4R6b7PaP5HoT6sF8TMF1VONSbS+uLO8zGvNlE3/PZEOuuwX?=
 =?iso-8859-1?Q?f8B71nVAH9mpfEvpGyddUmeS8WbKTtOx+Qlc4M64kGHeylYrSYwIkMHr64?=
 =?iso-8859-1?Q?JspSiSUfHNcHxnDFjRf7+HtaJ5GHCt8tRNegd09EtLASh5QPYAkP6ckmlR?=
 =?iso-8859-1?Q?/NC3nucBCWCfMaYJTB54tJMKL1XxoUVBLoG/fEoJJhCW9YoyGupVwS7g9i?=
 =?iso-8859-1?Q?qvLlO29a3AXTYYYhZE/Bo4gQfIKBhz5o1PNVrGA9a8oV+Zd/X/SJY415Ab?=
 =?iso-8859-1?Q?shCCNF01DvEFHdC2cEhoIecOpV26mrvTo1kqq2B9vRwA9uxgPW1Qu9DPOn?=
 =?iso-8859-1?Q?oauiyvW051ZPHUZ7BKFzUZGIUeAn5pwNKAIoPu4ls7lIofcKsYRETpO9R8?=
 =?iso-8859-1?Q?a/5xXFJyCPG972BHKnL3wEffAPLDp81iSb2psukJXCNGRT/reRGYu0QWqV?=
 =?iso-8859-1?Q?hG3a+ij+INUDANKDUsFoU5P7jBdbhmCdNCkCAiqtAuy2qb5od/pqZmlQZf?=
 =?iso-8859-1?Q?QjrPCOvg1ME+CEoKCFICyx3omTwJdpGOq2VrjmlKSh5GgtylrasmgwUOA2?=
 =?iso-8859-1?Q?mqgQOXarfpX9ZyvDtYdFaUop7e7pIKDVgjIplTgg6PbpTcMCY9MRwaiuvV?=
 =?iso-8859-1?Q?fRe9OCytnRuewqhFkjY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 249fb8c9-7033-4ac7-e28e-08dbb35cf5e7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:53:24.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Au83uRw4kx2vf72ImLu0qZowx8L52n3Ed6f1S17kX8prmQYk1kJ2kZGOL+A5gpPFP5iHMzK6WcXIrFYR63CHUhT1YDZtwiGV8IykmIeP9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6698
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 2023-09-11 at 13:05:16 -0700, Reinette Chatre wrote:
>Hi Maciej,
>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index b44c487727d4..782e2700290b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> @@ -87,10 +87,13 @@ int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
>>  
>>  /*
>>   * Check whether a cache bit mask is valid.
>> - * For Intel the SDM says:
>> - *	Please note that all (and only) contiguous '1' combinations
>> - *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
>> - * Additionally Haswell requires at least two bits set.
>> + * On Intel CPUs, non-contiguous 1s value support is indicated by CPUID:
>> + *   - CPUID.0x10.1:ECX[3]: L3 non-contiguous 1s value supported if 1
>> + *   - CPUID.0x10.2:ECX[3]: L2 non-contiguous 1s value supported if 1
>> + *
>> + * Additionally Haswell requires at least two bits set. Since it does not
>> + * have CPUID enumeration support for Cache allocation the non-contiguous 1s
>> + * value support is disabled.
>
>The second sentence can be misinterpreted. non-contiguous 1s value support is
>disabled on Haswell because Haswell does not support non-contiguous 1s value,
>not because it does not have CPUID enumeration for RDT.

Would phrasing it like this:

+ * Additionally Haswell requires at least two bits set. Since it does not
+ * allow the non-contiguous 1s for cache allocation the support is
+ * hardcoded to disabled.

be more sensible?

>>   * AMD allows non-contiguous bitmasks.
>
>(connecting to comments in following patch on this topic ... notice how the above
>comments use the term "bit mask" and "bitmasks")

I'll change it so the naming is unified, thanks.

>>   */
>>  static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 85ceaf9a31ac..c47ef2f13e8e 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -492,6 +492,15 @@ union cpuid_0x10_3_eax {
>>  	unsigned int full;
>>  };
>>  
>> +/* CPUID.(EAX=10H, ECX=ResID).ECX */
>> +union cpuid_0x10_x_ecx {
>> +	struct {
>> +		unsigned int reserved:3;
>> +		unsigned int noncont:1;
>> +	} split;
>> +	unsigned int full;
>> +};
>> +
>>  /* CPUID.(EAX=10H, ECX=ResID).EDX */
>>  union cpuid_0x10_x_edx {
>>  	struct {
>
>The core of the change looks good to me.
>
>Reinette

Thanks for reviewing!

-- 
Kind regards
Maciej Wieczór-Retman
