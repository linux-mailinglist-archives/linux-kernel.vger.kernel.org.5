Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5447B7308
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbjJCVHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjJCVHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:07:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F70CAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367261; x=1727903261;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Hbi8XrAzPcsOgIiR+ztouocxVFgvXSkF8temMe4s/0=;
  b=Aiatjie5uRv/tmlq48ZIp98nGNGupgEXDfS1qAIShCRThbO+BFP3juZ/
   JTCdjDCveIf3Tn6CNDMzUQoxwdgoNd3DFEpI4LfPDgZ70BhFFZnaCwCN9
   CFX3niDdNgf1B5DZ+SlCjE8/es05CRXLTSGlwTZ/xD2mZ9Wf7gCs7rcw0
   MO+noT4OdCWHYVMtQrziPq74nMGYJ39vnxSYosuV2lQEcpERF6Oq8VatP
   dc1r26xy13DdcsVR4CZzRYoMIL9kkabh+jt0ZW66zJ+A/16bTCRhrUmN/
   5Po7eKbQkbpNFMHLnP2OATgQcpPlVPhhyBSjWZRm88X19kggf+ewWSGVI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="368036197"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="368036197"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727771116"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="727771116"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:07:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:07:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:07:36 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMuwROjrrK2+luZmex/k31dOmuf4lZu7hf5XjAz4NL6uRtK5Eukjqk2HIo9nSvGrsQO1c15NdtGlbGAfsimDBFxubfZYVgeCgzpEaZEb4QInICLrek2koX5RRf2CGzblbqodn/i3lBjyNIFFn/ILj0+b8GLLE7M4NuOJXH6ftAMX0Roe7SHXt968f4Gz7CMybtM8b0Zjq/5s6HBASoxuPwugdoBNsF3TZd4VaGxhz5Oa2bneEhhZUmevOKoICGQLj/kv5cGw+q2PcfPyU8vD3LXZxZewziy2ubiUVBJLHtjx+VgFP2TzSKRYrKjbABrn3uKyDuS3xGwMUxvvbtyqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0eui64yc+qD58frutpFHJOyHH4D61YkMbXtvSO4iiA=;
 b=esLDElJqBquj2YJR4kT7L47FXcn6v/qg6zngAR+2gqWvn9HBtHf9eZUYrEt7ZBzpxvCuKyGXllh3PczUe2yzssJ1U+huyKdst+PK9mtnr4kOZO8J5t+NIg1SGtJhnXsj8JGdfr+0zaXh8dtVeB6W4KzO082MZIbmdAq38ftu4wFq0tgAmTV0nJPUSKSXdgwhdh136F2sK6kqLeBIYnm9JunIiWVY2wFE+/qXgRl3B4yFmAHL7xKSSsmUm4oDffbQ1d3KVy6oWbPkLvTrK4NT/WeIWbhgipyJ7F85xOoK5Es4yjeqoWlC34m8zfzb4h0qg1zxv1CBQLpSQjYtPofmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6908.namprd11.prod.outlook.com (2603:10b6:510:204::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 3 Oct
 2023 21:07:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:07:34 +0000
Message-ID: <c69f894f-9809-8ca0-b596-311e889cbcc1@intel.com>
Date:   Tue, 3 Oct 2023 14:07:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 03/24] x86/resctrl: Create helper for RMID allocation
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
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-4-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:303:b8::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: da4ecb1f-eaed-4c63-c607-08dbc454c3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DmxwkUkd1C1nxf7vZw+9YVORzJJ8dxapfZHfY+BVWW+M58jCTRXFUXAZlZWVWskRiDwtVoGiXz3PgLSWfGQuK0cZT4/ruCUte54pw4AWyuGI7qTswq9PdRnd+x1l6xqLraAbkF3PxY1BdyCX9xSP9av++xX6ZZo5hyD/kTf4OUmLAcs6LHPJVq4QP7Ru1366fyRhs1gjuYiaxN4/29S9Gjy7sHAUCZLbZpJnWeeecGW6i9LYjVPga4QexkCpnWoBb7ZxWRcypBvFoibEpzfzvkJXuV9E0CoiwmJQ1Tiv7EZFy0i1KZFOdOh8nPPrPYuUI54Y/Bof5SU02oHsQ/UUs8KVwjFT04pIpbPdYjLn1l4a7OpzYmqky/JtJjaM0JeFM+tpqCmrkIGsJXqdshnpPdJscoEFGbaOFJE0FS3i+A4mrgawp6IVu2TqlU9GFFVtNKr89Vc8qAB20EZBmEAiy7kciCGG+rdn0O5yygptQz1VzfvQcgS++d589gckj2zlOLRMjQ18XXGjDdyVyZAz3avL5t0OLPhJfYkKd3lzfQlBAwdyf4wxGUNqjq13seta344J6jlCUo4P9F5B+nM4aO5BJWy6LG+yZeiNXK8QxX//0CG8WMT0GNoqMkdHKPrGEiOuRJQKKpKpG7NA999Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(44832011)(5660300002)(66556008)(54906003)(66476007)(31686004)(41300700001)(4326008)(8676002)(66946007)(8936002)(316002)(82960400001)(38100700002)(2906002)(36756003)(83380400001)(478600001)(86362001)(53546011)(7416002)(31696002)(2616005)(66574015)(6512007)(26005)(6506007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmxJOFo1ODhRQ1dML2JYd0hKWm1IUlZWRkRVU3BWR1N1bnhkNm9QRWlxQW1R?=
 =?utf-8?B?VlUyWTgzV3hYVVJFTktMWFAyRzg0RXdYaFRXVFQyV24rUVpZL1VuK3RTRTRu?=
 =?utf-8?B?T0FjdXlhUStEcUdjQnpiUlFwQ0lEL1lUcS9aNlcvYit1bzVtNjdWOFFYTWxW?=
 =?utf-8?B?eHduZmo1S1liMUloMWR1MmV1dEU3YmE5RTB1MmFJV1ZJM3NPdnlFRGNtQmth?=
 =?utf-8?B?WEJkZlFBVm5vTTVSQlAwLzF3aWpSRDlLZlloN2VHWTJJdjJGamFwM3pCR2ps?=
 =?utf-8?B?RVdGaGEyVjgrU2tQdWNETDZFSXl4alFHTThZTU9PaW5HUHhKa3daeGUwUmto?=
 =?utf-8?B?eEpQanJEUzA2SEdqcEZWY1B0cXdPU2JESlBVbStiM254cWEvWTM4clVxcEhB?=
 =?utf-8?B?VUZXNndxWktsNzNxZDUxcGdDVERnem40MjZtQkk5S1RrYU1YM2p1NW9lUGZK?=
 =?utf-8?B?WmhvakZJVVEyMGZ1WUg1UWJFR1MzZm9jMzEyZWxrMHZsRU13RTh5MWcyK1NT?=
 =?utf-8?B?RkNjaU5xY3pHazR1bjdDVWpHZ3ZFcUpBNFVCTUIrYVBjMS9UbXJnMC9qR09Q?=
 =?utf-8?B?Tnl5RXVla2V1ZHA4VGtZUW1KUkZFbkJwQlJnbFNxOFkxckthNXdwR0FTcElp?=
 =?utf-8?B?M3RKaWlqb2xKV1VqdGRWaGRsaDdxbHJSaFlHNXJRU1hsbmxPUStOZWZKSkJW?=
 =?utf-8?B?c2pML05oWkpoeDVpcXZCZWV6RFFwNjdyN2J3eWRLaThySUExdW9kRFMrSllx?=
 =?utf-8?B?Y21ub21rdTFQeEgreFRHNGFMY0xseWQ4c3BlMy9HM0JIYjloMmxDYjhSc0pJ?=
 =?utf-8?B?anpia2dxT05QZzkxK1JjYWxBaXQ1NmNtQS9WYTRwSlJSMFZFNUkraDNjZGw4?=
 =?utf-8?B?K052bVo0OU9rRFFBeU4zV2tTTUFBMnIxdjlIVmI2Y1ErZjUzYjF1cUM3QXEz?=
 =?utf-8?B?VWxiQXRLbVV6Q3dzU1UrMkl3WFlCeXhBQU10UGxYWkMyQWpSR0hxSTV6amhV?=
 =?utf-8?B?amN1a1FSU2VjWGlkVCs1TVRXeXFhS3hyRDJyVzhFdXFzOFlkd2ZDL1JKLzV6?=
 =?utf-8?B?ZjZ3cW1iTEJIVVZiaUNielN3V2F3cEtaV1hDSzQrSisrb21aUDhJb3VyVWw3?=
 =?utf-8?B?b0czOHVDQmdzRHJ3K1VBTkkvbWFjNkgxV2J4U2NkdGpxVWFNSCs0SjY4VUNu?=
 =?utf-8?B?QU10R1JjOTUxUkV6eHlKS3dQZHlSWUN1NTVMUGl2cnpncUE5NGtoVS94cU5l?=
 =?utf-8?B?Uy80cGFtZ0txQVphTDhZTklEWDFnRTZJWlgyL3VrZHE5aVVEMW5EZytneG1i?=
 =?utf-8?B?VEFOand0RDlab3lNUnZEQ0VDckVFRGN1cnY1Q1ZwcDZUWTV0Vlh3UUFJZ0Z0?=
 =?utf-8?B?OVRvZzZiZFhoNGQyYjFtZzBEVFBBY3JuQnB3T2ZmZXMvcmRoc0JNMHBibEFS?=
 =?utf-8?B?a0lWZWdyU291Vkw1cWttMUlaRnFBcU1UTXJaaDh6eEhCZCtTTU1IcVZ2SDVp?=
 =?utf-8?B?Ky9WMnRPNm54U1lObHRjOVdGT1B5VE1mODBhUDVhejc1ZFNlVkRWTEs4NXlp?=
 =?utf-8?B?UkpwcW5GYlIyYmdsV2pVMkpHOWJRZFlQd3RIZGQwT05tdXVPZjU5bmFSSVhu?=
 =?utf-8?B?Z1FoV09WSW9VZi9lOUY4T3lNWWdHS0MraVRVMjJUNmxmNkdhMmpDVTJZNlly?=
 =?utf-8?B?QXo4bGNHRDFvUEMrSitpc2dILy80cjgvbmVRTEZRVWhxM0VXUVFwQllkRFRX?=
 =?utf-8?B?cWp3TFdYSFY5cUxkU2Jxb2N5VDFRSXVHTTJ0L2dCbDBKY2RMRVd0dEluTkNx?=
 =?utf-8?B?SUt4SmZHNXJmY0hWVytwZEd5Nk5vWTUvZnB3K3FVTXBBa1AxL2hka1NnYlIw?=
 =?utf-8?B?b1ZKZC94anJjd1NrUm16ai9jMFo5N1lvL0NiMWFGQ3dhalFnYXByMVBaeklT?=
 =?utf-8?B?cWJ5SzJQZTJGbzN1eHZrQVFyQVpJd0x5R3R0VDVscFVoM2M3QVJSQ2srVk91?=
 =?utf-8?B?eGpYRWtsNHM3Z01GSWxHUUpTRlhzeldYbnVhQU4rV0JHTGZxWDNoSG5wT2hw?=
 =?utf-8?B?TDhkdTE0ZGhjNjFrRzNYWWtvYmJrMmkrQW1JZXRZVkVrZit0ZDc5ZFdoU0V3?=
 =?utf-8?B?QVVQdkIrTXJwMFUyM216empjb0s4NXUxWkNYUkdFaTNxYXlCVG9oYnU4ak1q?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da4ecb1f-eaed-4c63-c607-08dbc454c3d3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:07:34.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txFKHXEBBW2AU8wrKWCHFX7MIpOVu01qGn4d72F4razqfe+vgxiNkbG4DNrfYavYRh8n849/dyl2oriUMDOHsMB2hC7av2kLJ6jz/ck5pMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
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
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Please follow the x86 custom for ordering of tags. You can
find this documented in section "Ordering of commit tags"
in Documentation/process/maintainer-tip.rst. Please do
so for all the x86 patches in this series. I believe this
also applies to the tick.h patch.

For this and following patches please consider when a review tag
is provided it is done with expectation that the commit tag ordering
is fixed. This is the only scenario I am doing it for.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
