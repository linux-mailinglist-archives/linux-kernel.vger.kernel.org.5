Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510DC7B733D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbjJCVUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjJCVUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:20:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278EAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368049; x=1727904049;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4m66Tq1hSU9QY0FoJleAAYQZSqvNz/XaXZFgBrbBSRQ=;
  b=MZwzR0g1TpTfiPQxAVsn1zto9B36AybyGxqlN/z107Xn1GUppByno7EW
   Sjh9Gp2lXxE3Ha4s2JTCVO6U5fkxS6uJFwQBUsfwZIZdqGlc/3EHu3v1q
   IjtXNUNU/sMt77moNbrPupaZhIRN98KbOMpaU/aqusGeULJT2/PJFLdTm
   GCrD10x1CXMi0QMqRZfJg8mb+Chn5Dwsg8OZ3+Hr3peypZGaOPwXibt7Y
   pBHxinNVZtvAz9wPs9R4RR6TXWLSsu1iFkly5EYc4sc7EFUpQAmfJqRXN
   00XOkqcNrU/mMMd/EkEx2YOivaT8ddvx7pLRdXckAW9AlFZyDUpYT2vw+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1577950"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1577950"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:20:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082176332"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082176332"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:20:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:20:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:20:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbS5VrzXKiwJ8bsuTi1a2l/APVDF1NEXPEouA35ULsOt4AAkhhmuiaZjNrh45HLzJ2y0nlpF9nMzvGcErf+NBJ27y/QdL8+zWT9TUWtFm2WRvMlXN/l1brgS37Ts2uQ3tJAnceIJG3lYHwP5JZvbVTehCL2Q0mX8A22gJaHNMIsqEXX5JAFTp4yeMiZq6ZCbOw736QmQGjOCz6TDTDA7Fljt81N5c00opFfrn6lsJkCGXd2ttGY739DqOBpaz88LcfVXM294MThf0RV9Sy+WzJSZpvDYpXEvgF9CayW7oCvMcGgh9g9Ssr8Rq/olLOsNyZn89evl+PH/BbbdwOImuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZvwyJwthx5QAy+KJpFW7oOU5Z22DhnQlp8wxmcqgKY=;
 b=LLAZX0m/qBNrStfJe6A5Hs1+r6/zR8Rrf3cuQD+Q7uzIC/8kHyhk5KMRrrIgEvVjPjXyTrAO0IgsWqvsQhxhCIH7p1JRb0KIe5YubtFCZht9h1fACtVPEDK0YebFVcjUfkJ4ChdC2MKJd+bC5NAW2fKd4qj0FlfOgADPVS5MOhkNsZAg2AJvn0c8+sEqfjwIdQTAYexpgf5TfbPIhd0lS1iBq2GNoO/PsknUkMLugQvF5xBDoq1T0l1pkvoII9wl2Hzhc0mY3QsPoe0JuNBLdn6amTnh+SKrBWJgAp9e3wRzesmN8m5E0zcRkSJ3JEfhHR8U5qag+/1TOTV6oJaLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Tue, 3 Oct
 2023 21:19:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:19:51 +0000
Message-ID: <dbfce9dd-5195-50da-c752-ab0292217019@intel.com>
Date:   Tue, 3 Oct 2023 14:19:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 19/24] x86/resctrl: Add helpers for system wide
 mon/alloc capable
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
 <20230914172138.11977-20-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-20-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:303:8c::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: ec79c0b9-34c1-48ce-df9b-08dbc4567b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gOmOjbHtnrDDH1mwg6JP8Ux6SPUJdNhTfDQgw1rE8wrxSTzsiIO/LbqSY3JetJ68Jefji0Nz0VxB2qzy5tnu9dpWKzLmMp0JQTH1M99jPkEtn8fnm0Tae6hpfwhV9kVwxd1UZ1D4akFACd5lOld/QNH4TaZtxcl3jdw/z/8ssbwvqxAja03JHrZHLN38nc+gngC2aDarb+nJfi1sr7HidFH85loovnD9cNmlJjHQWRGJGn0K1p0A3xCVTZw9Pi4L2E4Pyn2LXlRxblK8NZ/DKKdLp9qCSWfhguLBKakcntLUoFJeUoQpunlyCE3R77MI8s0Z/a19kbxeO6If30+A+bebmrSNpAtmqtNZiphOCCME0vMKlicyOyhWoY8hTr2oclZ2nHgP/Wp/U06Y9kWrYou0PY+g0NyT42W4ZatANyiM5z22Qq0kbFgxF9YH2KCIefeNMJGto4fOcAVlrrVXN2aiFNc9TBAxFTwZjSb9x7Ny4KCz19fAYbS0iLQ/F3pSmfMyQKwGRSFtBUDUkwViW67Eiv3WGtRvmmMHdXMPhCPgtO6qxBuGOIKO0F19XnwxkxcIbhUXOUGrCxnvyGWfC0NqhQ8zRJPcfOfitECdKNYa+gY7Jy2kslceP303Qdx3I0d1+yAscCPW4sgfJguqUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6486002)(53546011)(6512007)(6506007)(478600001)(2616005)(82960400001)(2906002)(7416002)(26005)(41300700001)(316002)(44832011)(66946007)(5660300002)(66556008)(66476007)(8936002)(54906003)(4326008)(8676002)(36756003)(86362001)(38100700002)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRvb1BkL0lIYUtycG9mVTk2VXAwRmhZbjN5ZWk5azZmOWpFaG02S1B3M2x3?=
 =?utf-8?B?ZUwvd3ZZK1RIWU9kMkhGZUsxV01TZ1BGUTFGTjE4T0NDbW9vOHBxZ2dDYmNn?=
 =?utf-8?B?eGNGMUZnZHY0MlZyTmV6cGhLWDc1RlVkRTBGNkxIKzZKOEgyai90dVY4eFgy?=
 =?utf-8?B?U1B5L2JJZHU1elV3TTVhOFA2d01xbjhuUFg2U0JWZEVuUWtCYWFybCtSQmVQ?=
 =?utf-8?B?RlE5S292K1dMRjlKSGdZQUtVTWd4STB3UkErMHhWYUN1cEw3UUNIaGRXcmJp?=
 =?utf-8?B?RDVOeEk2Y2VNc3hOREx2bDZDYTcwMUUvN2JFMnN4VWZIMlNuQ3Z0ZUYzWEtU?=
 =?utf-8?B?Z0U3eFJNY0xvVVJIN3pXMEJQcld4d25wWGZyakoxNnJ3OHJxM0FkTDU3SUxW?=
 =?utf-8?B?ZXBUY1FNSkxNQ21jVzVxQUJ4MUhlWVo3RmMwcXZhUzVRUStKQU9nZWhab1BX?=
 =?utf-8?B?SllMTTd6MUxNTU9xREtFZDZUanhyNFI0TWxKOGVseHhEUmFQUENONnYzRnpH?=
 =?utf-8?B?Qk5NK3pkOVZGd1lvVC8yTXdvTVRrdERmakNtVXpxUHh4QjlleEJPMisxRGNX?=
 =?utf-8?B?T3FqblAxSEpmY2pwR2w0cTAvZktxdkJHNFVNV3dhWkRla1VLMjVXV2RRVXo0?=
 =?utf-8?B?Nld3ay9GRjJSVmprdUJINHRMME01OE9ZSWIrYzhhYlVEY2ZIV2xJSFhhZVdq?=
 =?utf-8?B?anVEWXJRREtYbG1ucTRMUldwSEl6cU1UTU1uK3Jkc25QZWVRV0Zza2RlcVNv?=
 =?utf-8?B?N2pycFlLdTZvWHovZThkWW40L2pZQjVhQ3RRa0tSc1dDZnZxLzA5WWdqdzZv?=
 =?utf-8?B?cWVyaWlzRkFFa25QYUY1YlgzMWdrUWVwUWpEYklITmRFNXdSR2VGcnYyYTFs?=
 =?utf-8?B?ZUhROENjL2w4c1RWbVdJYVFldzliWXkwbDNabFdwaXJkTmMyck1kRkdVaDRB?=
 =?utf-8?B?TENlY0N0N1d3L3ZvbzdiaGhEVVhkd3Z5allVbVg1NmVzSG1mSzYxcG1rR1Vq?=
 =?utf-8?B?Rkt6MEdrNkhDbUVaWXJtcWVTcndGdDVsTWR6dXZ3cStUaE8xY0pPU2JObFJj?=
 =?utf-8?B?bW1PaUJhRFVxUzZvS3F3d2lyUVMwamZJdnNpQlViTEhYd0dnZE9iVnhiNnho?=
 =?utf-8?B?b1A1MDlXa2oreXJwalNGSW1hR0hBZzMvRHM1MFhXdnlhZVVMQjBwVytOajlr?=
 =?utf-8?B?cTRyVVBxQzU5TkM1dkJnZWVtWVZtaFg0cEZIVjlEQ0ZKeitsVzZSVnFyWVpB?=
 =?utf-8?B?MFUvV01lK1hRNXpIWHQrMTdsT3BjSGJ1Z3c2RmhTNGlkMkhkNTRyZ042S01x?=
 =?utf-8?B?OW1zVGRScHc5aU41NnBRWURZanJoY3k3Wk0zcWViUzVjVnBUWkgxcU9DZ3Fs?=
 =?utf-8?B?WWhFYWw2S3B2M1JvdW9JV2c4USsyWXhiWDQxY3JLMzd6Q3BZVnY3RVJuZHVK?=
 =?utf-8?B?L3h4Rkh5MkJleUxobDRCZmc0UFI4Z0FUTXd4bzlFU3lDcE1vMzIxN1lTT1VO?=
 =?utf-8?B?RnRWUm1UVi8xQ01LUFpFcGFhb0tNWXVjZlFzU2dCM1Z4Zm1jOFlJcFdjUEFM?=
 =?utf-8?B?L1JQcHY2MktNMStoNVFUMXdvbHJLWnVBTm42MitxQmJBUHlUZ2hwdDhzVW15?=
 =?utf-8?B?UDUyNWpLdlVibFQ5UEpuYTlrMW9XcUVUd2tScm9uR3lCNkF4WkdIM2VmblpZ?=
 =?utf-8?B?RHM0K0VCMGtLMlJoSjExYVpoMEI4N1QyVVk5aitLRDNWdktyVXpuTFExeis2?=
 =?utf-8?B?TDVBdytwNjZWVEgrcm00Mjl3bWJ3YytDRHdrYWtFUyswWmQ1akhFVG8xOHlI?=
 =?utf-8?B?dGZGaU04Uzg0UWhqQ3R0T21tN1JUVDV6T1dTKzVOK2FhQzBtU2FCbDRaMFlv?=
 =?utf-8?B?RlhZYUw2UHdaSkdyZi9ieDRZUXd1UlNyYmtPcXZRUDBNNkZqaWRocDVsUzhV?=
 =?utf-8?B?S1RyR256YytsdDNhM2pOTnAwcnc5Q0VRNDRoNjlVQ1pjOGdBQUJCVVQzMHhB?=
 =?utf-8?B?QVNYbHZwN0RsaXlIeGZQREtzYjZNcGpOWlVwUUhXWnI1alBPU2gzT3BHRWx6?=
 =?utf-8?B?bmxTSCt0akpqLytlWHVUZU95YnNhV0FtNzNkQ0tBRGJGdTZnNlJGYXdnazZa?=
 =?utf-8?B?TlFqdWk4NDRJcnlwU1REazYyc1RkdHBjSzEySDhXQk9wR09OT3lCNnFkeFg3?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec79c0b9-34c1-48ce-df9b-08dbc4567b3e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:19:51.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBdB76miopOfoC6a3zE6VyLiUUBmpA4C3KlhK4ZLMrec3rh0YKttp4yqVPANf5HLIj8NDhv+VE/cGG1tU0SBO2AzIJ6IekREGKVz9modKvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> resctrl reads rdt_alloc_capable or rdt_mon_capable to determine
> whether any of the resources support the corresponding features.
> resctrl also uses the static-keys that affect the architecture's
> context-switch code to determine the same thing.
> 
> This forces another architecture to have the same static-keys.
> 
> As the static-key is enabled based on the capable flag, and none of
> the filesystem uses of these are in the scheduler path, move the
> capable flags behind helpers, and use these in the filesystem
> code instead of the static-key.
> 
> After this change, only the architecture code manages and uses
> the static-keys to ensure __resctrl_sched_in() does not need
> runtime checks.
> 
> This avoids multiple architectures having to define the same
> static-keys.
> 
> Cases where the static-key implicitly tested if the resctrl
> filesystem was mounted all have an explicit check added by a
> previous patch.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
