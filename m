Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C97E7078
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbjKIRkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344762AbjKIRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:40:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFB2702
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699551638; x=1731087638;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fay04LrSasGRnopiu2uboiKUeCDVPtmc6EHRvFsdRDQ=;
  b=BuKhgs2tn94x7H6I1faFc6k2jXhbR7C0qOy2QXQddp/UpuZgY5s8euqD
   otiUMcyZv1IIBhPaM7rZaYgitsNPDtbOI/ADL0Msfz2Of0JIYaHDSKYJS
   xc23dE9us9wxO0pqpD8KhyIUcR1RhJls4kD9626sR8nd+rnd8oD25UZPK
   Aa/8Ifr3qVlUMFVzdKJexyFv9UWYl2gi584KeaLD3lp7ExphFlWAGtvRI
   2MhX4By24N6leXNjgSPsDJWKQHJaKfvm4FEhQ2T/UuS0ZwgFnsNbqpMpH
   TexERLyJcsw8fW5yAlwb1VUDm3THfrB7SnZI6LTtYspEz+hMCiGtpr94B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="388895002"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="388895002"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:40:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010695092"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="1010695092"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:40:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:40:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:40:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:40:36 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:40:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxQZlrXphDbHtpcXukGq8d7t1UQ8AS1TqPMLWjrZcwHGdfNNd6Jjt3q/UKxkmFtb9I6f9k/TRTqR3uq+5Et4RO+AynQtpHKYaJImK2mGu84xFAXVvGLozEusOggNLGmY0+yyA8/uMr0gNoKiWqgiiF2XjHfHJwyCTyt5IMjv6wQcSd+THRnuf64DM1bIp8TOWGAf5zqzcfL2AJuzXt2v3tn9B8KTIDrg0J2Eq5iRGRMspX5td5H4Y+vN3JtvK/SJpECcQSjfPYhIzM58T+28+8mRgiVAYzkF6jVck5Qs/NJH+QOSEmNW/7q/sb3u1APoRo5YESZso4qzSpjXotsJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkYGptthBpd93+PiQEF/leitzCbrvwHHChadmOA8pMg=;
 b=KIPfaiqoeZ+bP4SEtr8fGbDB1gYfSO8UMaW0NuVqhh4Vn14xy1Xk6q9wdzUOCHDXvhENuU5gXyNi6sQlFE1iNv/JlLVsImylIlQVA2UiVQAwlhkT79zVm83BEKsxwcjOKvXraP92PZoMIFunFCwncXjf0GWh4I9GIE+xS7h3g68VsS492ByEPady4pti17wf6G4FqwAOuyw+vxSKtLcZlOp/NmvVRNFblBlANv2LHavniqH21qGwonYEQU3t4hx9JftKB0Xm8f0RRSvD+Mvy6g1MCkHrS07UKNLM6W6RR4QigKWXf066yw3zPWEGLh3bd8xBkZNjaOzfd42UygQAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4565.namprd11.prod.outlook.com (2603:10b6:208:26a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 17:40:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:40:34 +0000
Message-ID: <85f8756a-23a0-444e-b37d-a7817b600f46@intel.com>
Date:   Thu, 9 Nov 2023 09:40:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/24] x86/resctrl: Create helper for RMID allocation
 and mondata dir creation
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0225.namprd04.prod.outlook.com
 (2603:10b6:303:87::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3eaedc-b1ab-4f41-b720-08dbe14afa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9EFoCgZduG2SpvPC1DwE9Rh5EL1Em1w3GZM/k/HhRbkImFVWfb4q63/i1FDT4qwR/AtP4/V1AQCO60uEe3vntGV4qouTAlk6rmYHd0ga6CuoylanGG9Z7JZxDtkqcr7fkMsLGWrvHsUWQ/vJAGBHHzamA7J2k1dkdEpwunlBEP98FnNFhqCbm4GKG4afaih4QHU0kTKtpJuaOeAMsXzDycguAgIsoAyVRXg91UrUtUD7NtP+9q6AN4wLmnSAaARhG9xj+6mwm2FOT5/8SSMYBjAZnvrP81JuFnPPxnk9aA2blAuavXgDTRYTApexfSqe1duWpPKgiwC1Qo4kxWM7FR+VUt4b3ZkJbTTI7RJrFIqnxIYFayZxTex9kwwG+VqAiW0BAwUPtXMhpPmpZtlyL3XWrB2tymJ0SZnM6+N2MojneLNP3KzlD4Ucemn99TmYb4NIMK5rB7qT50z3BzQhY/fSByRxevyaKmOIhyo+ozwYJKxzumUcDrXCypY3oeplNbF3oQoIhHzWPgfjN+LE0oP3fg4L2XoryUkvsNlSDcDjN3ghMfMbayMLepB7JFTEUVyP3qsPdRpkfAMgxQIKIupd8oWHkDX2RfEWB6O/o8AKrkifp5AVCfRidU1oaDM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(26005)(82960400001)(38100700002)(83380400001)(5660300002)(31696002)(2616005)(966005)(6486002)(478600001)(53546011)(6512007)(6506007)(31686004)(36756003)(316002)(8936002)(66476007)(66946007)(66556008)(54906003)(8676002)(4326008)(86362001)(7416002)(44832011)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWpDVm5mUTJNYi80bDdDbm1qdHlkM2dETi9IMVh6OVMvT0h0UC8wd2dZYis2?=
 =?utf-8?B?UGlYcGZOWjdpanErNEFmalF1dUt6TS9tTTZlcmQ3b3NUZlVZWHVrTzJBcERF?=
 =?utf-8?B?Wm1Ldm9lQjlrMlBHRmZJc3IvUjJacTFZVW5kOXBBZUR1K1RlT3Q5NS94aVBE?=
 =?utf-8?B?ci9aYkRnMTVENHRtdSs5Y3pPYWZPamhDSHJHWFIzUWkvOGgrR3BacDBKUjhx?=
 =?utf-8?B?RGRudGpUdnlqY1RPM0FVaEg4U0Z1UXBTYXN2bEhUY2JtQkEveTloclBMeThq?=
 =?utf-8?B?NFg0TCtkbFh2VHc5ejI2SWFxd25waGUzNUMzVTB5KzdMMCtiUFNTeGJudDRW?=
 =?utf-8?B?RWFOT1h5bHppR2R3bUI5WGk2WlIwYXd1Z2hTTFN4Z2ptaUlybHE4QmoybXhQ?=
 =?utf-8?B?eEUza0p6dzI3OXo1c1g2Y3NVT1FzenZmL3d1alljcEVtcjc4QTUvWk4zREYz?=
 =?utf-8?B?eHd6MUdwa1pxVFlzb00vdTdLWG1wdXdiMDAzQkI1dFE0aUZWb0pFQS9NeGww?=
 =?utf-8?B?Wm9pRkZOSUx5M0l2aURiV0xpbnYvNkkvdk03R1FHd2J5VnQvS0tCc2hFSmdF?=
 =?utf-8?B?Q2Y1a1dWeWc4L01rSHd6c0dBQUYwQzdDQURMRjRHcWM4ZnhudzNHK1pmZm9s?=
 =?utf-8?B?RXlSaWx2c0o0OEx0alp3NkpKQ0Y1aXB5UVZjSXV5NGR1eHlCUWU5Y0xQYVUx?=
 =?utf-8?B?YWpGNU9HTjFaMGZRQXYwa0tpdFFyWTJUMnp2MXVqMkE4SFc2dEZkSUU3NmFR?=
 =?utf-8?B?Y0daUVRvbEorR05ESCtJUDFsTHR5Um5CUENxY2grWm9RM3lwZjlLNVZ2UXhl?=
 =?utf-8?B?ZTU5aTdWZ0VycXBsbTBMaXYwdzBIRDh3eWsyZWxVVitnd3poN2p4Z2JDY1ph?=
 =?utf-8?B?NmFQZ3NkT2hvRVh2TmkzRFo4MEZNYWZmZVBNV0dtcG9RcjA4ZWloWml6dnJk?=
 =?utf-8?B?TE0vS09EbEMwNzVPd1g1d2xGbW1ROWZBc3I3UmxmM3J2ZkZiSjQvbUxCNGI3?=
 =?utf-8?B?ZDBRSkx1SlRpaTFKeEpyNjdXQW9kTkdVNnRtMWpoaitmbGNjYkt0SC9TalFq?=
 =?utf-8?B?b09tYmdzUllDWUt6dm9MU2tmeUp2N2ZZZmFiMFBHZ1dDeXhRVTBoZGxzSUF6?=
 =?utf-8?B?WExjVDBlczVxeTBadkNVTXE1NFloR1NWRVJhcDk4TjdjUGVxK1lqN2x0ZjRT?=
 =?utf-8?B?ZTRxc1FobXZLR2g5cTQ4VVRxVzc1TWY5bnZCMGFuT3U5c3hNcWo2R09DbTNJ?=
 =?utf-8?B?S1VjaUs5R09KR1hoNW1KSDRvZVdYQnFoN3phUHdLNEtWcnR0cXo2MmQxYng3?=
 =?utf-8?B?eXZDQ1VzNkF6M1ZlTGZ2RU5Ua2VmQ09Oc3NQMDByKzZ5bFN3U0lvbUd1cUR1?=
 =?utf-8?B?UVlRbWpsOURPb3RBM0k4MUlOM0dSbFhCOWlBL1NBOVQzeGI4d1RMc2ZHZHlH?=
 =?utf-8?B?T2tKN1RmSk1NWDRZcUw2UjFNY3MvQXZIRFZLMjFSaUcrU2QrZXBzWTY1WEt1?=
 =?utf-8?B?Q0VRVytPek1HUzdFQXkrK29CZmMyUUgwdGN5K0NOWElaSDFOOFpiWTNOa2tR?=
 =?utf-8?B?YVJhU25CUzFoak9DVDFrNUtHUzRZNDRYblJzK0FLdjdzMDJURFZlcDI3Lys2?=
 =?utf-8?B?dmFDd3g2cHVIeW8vbkpzY1RnOE9UL3h2VmVwYzFvc1VZS1ZyOGJYSGFqamly?=
 =?utf-8?B?SXNmeVRZSzhIQzFVN1BTSUhVbEttVVk4djdvTlVxcGVTV2tCMmFDKzA4dTQ5?=
 =?utf-8?B?VzhpUElVZEVtaFkxdXBsZ21ZWk55eWIvalVmQjlOd2w1NUtuTGQ3NXF6aDkv?=
 =?utf-8?B?b2UzQk5rdWszMzhQbXY4VGh1VytFOEh2dTdyRnExNGxldUNjL2FKUU1MQ2g5?=
 =?utf-8?B?eDR5dCs1ZklMMjUzUFAxZnRqK2VVZ05IYnh0NndkUnJLMW5iQzZ0WGJQWUUv?=
 =?utf-8?B?NXVWYjNsZ1B2ci9rM3ZGSk9IN25jTkRjSzZNMElGTXNWOFdINE9xRDNBRUdZ?=
 =?utf-8?B?dEZnK3NLOFRHMzErTW5JNWtvbjZPeVc4dGdZNENNVk1IR2d4Q2RnUWswaklC?=
 =?utf-8?B?Q1J5NHorRmVwVWJGM1ArYUx3ZThBUFJmNE9UMnUvSCtKRkpleDVoTkxNRWVK?=
 =?utf-8?B?Z0twNWROTmkrU252cGVzQTVqMmI1bkxVSXpITTFBM2U5MnNDbThGaEc5S204?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3eaedc-b1ab-4f41-b720-08dbe14afa27
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:40:34.5103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMIA8XTEu3/SFS/hQjVOjJMQ5Vz9QAOGMav49d68WbYPUW4wvgBdQ9sZ0xQH0u8316gy3iCNUhKYWH6338vW2CmIcdjEuevE/ECzcrwjX1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4565
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> When monitoring is supported, each monitor and control group is allocated
> an RMID. For control groups, rdtgroup_mkdir_ctrl_mon() later goes on to
> allocate the CLOSID.
> 
> MPAM's equivalent of RMID are not an independent number, so can't be
> allocated until the CLOSID is known. An RMID allocation for one CLOSID
> may fail, whereas another may succeed depending on how many monitor
> groups a control group has.
> 
> The RMID allocation needs to move to be after the CLOSID has been
> allocated.
> 
> Move the RMID allocation and mondata dir creation to a helper, this
> makes a subsequent change easier to read.

Boris recently reminded us that text like "subsequent change" loses meaning
once the commit forms part of the kernel. This term is used in a couple of
places in this series. Please review all changelogs to remove this term
to avoid another re-spin.

For reference:
https://lore.kernel.org/lkml/20231009171918.GPZSQ2Frs%2Fqp129wsP@fat_crate.local/

> 
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Please have tags follow "Ordering of commit tags" in
Documentation/process/maintainer-tip.rst (author SOB
appears before the Tested-by/Reviewed-by/Acked-by).

Reinette
