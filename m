Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D47B731B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241144AbjJCVM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjJCVMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:12:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9FFAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367542; x=1727903542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iY+kpTT4Ge+kVYqqvDkHMdwMUHmLR+tU6rOVEQf/nfg=;
  b=bvBVHWRcHGe1tfk9Cy2f4T1okc0sAsBwTNDRgqAhO2e5/BZNREgdtba6
   3CEeC4w6/L5hYZ/ZWW8QK2YZZVSoDnGgmtMfMe9Q5s85dsnGhM5ZwQOB5
   ZAjOJrnuQuNy3teR227W+8ZAcjh636U5KKi4Fua+oVTa7BeaW6xDmTEHx
   h1p2xfK3ydvda3dnZFY22iwzaDxV0C3v6Sht/Di2uW52mrbMWX9RgVDzd
   MAzwM3KLK9izV2xGWeGVN6JMQjEiK5t8bBGSzXwKL9h89coeDNxpSi3z4
   Zjf1eTUi9EJnX1suQLBH1ZmT03+OIyKkXGQ3mESAPwiCW0zuwOxGupaLP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385798066"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385798066"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786237494"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="786237494"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:12:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:12:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:12:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:12:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:12:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op3GDN40GQxzA7jEP4aXDTp82rFCPjMVqaz6/0ui9hhUdREJDAyMzFT8yD9diTYpGVqIEN0Z2S75FvnvErNgAewgCDejiUxhc8LSFVASQFKfbVpXqichvMIfz7gDUuUlmk1JrdOEOZ69yPHC9Dg8B0nShlI2iMPqKviTAp9rnhk7QQkSAOKegVEQ/S4X++histiFNiXXd+csWauXtxl1RBJr5vDrZAr73MA+WNIAMBpahPryzhI+RMMi1ZeY6jnbGXCvhXk9QczwWsvtEMGs688MuWUQKxokagOdD8rfu5GilOMozbObx24O4fXikHaJUYIGXaOfQU5Vnduar/I1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApvDRE+KsxjHkXg8RnYqIS7DnuoSoFuI0EfCZXxkagM=;
 b=T5lkBfdOrpl9aaGaD/ca4D86tHRalU7ArxdYN3EFuLPaVj0M8Ksz1kPXdxI9sjQwzb/8O+RGTGuTOX8Qj5COsnVJTf0h96qzZYaEdLE8Vtw7PE2G7Hwh/ZKz3SPGgMrRGHWpSh0DH9PI5bm5EymtcNXvfM9YofGwJ6bJhACV0ffEUHTol104R2y28m23f34vWN/DMJ35bRJ9nPGjpeypz5NQFOoOjMjto40UZc4m+m2bUAfIEZAWH1Dx6ik68jbHPIajk1Rt/xEQKugFkqiwDojo8BcDGVVaPwDYjsx45hkll0nZBNA7219QhbtZtfErbGA52GlBJsEQd0suQ4hwPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 21:12:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:12:18 +0000
Message-ID: <603835ae-b96a-6b42-b6bb-ea19699e38bc@intel.com>
Date:   Tue, 3 Oct 2023 14:12:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 06/24] x86/resctrl: Access per-rmid structures by index
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
 <20230914172138.11977-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-7-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:303:dc::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: a743b5b2-00fe-4d3d-55dd-08dbc4556d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PM/pXBiIx1DfSlO04WH01T5RedpfwifzpYkfxYP7xH4gMtDASnwpmavvPEJis5Iz8HSuF9ncBHZVygjmhEzRFhCwX5/TpXyV7sPUvGzX6OIE/Pn289mf1YkqiYrYvj3Qbt8552ELPAdURmTvfSb7XoaAxQCLJjLmGl8x/S8mufxoplC0AGDgKhi0Ed/URIOAMQmuS7BYL/NvfbYLASyi7b5kP8cPj5qFRx+oYyhY9gpWSpCZAexchRXvvaAGp2ijLxQRKdjCISlrNThnbgd1tpLP/O3jPrT8HQHqD5RN7HaDc9DaVIHj7AB0UO889cLOCwvPuhQ9xQ1Eof2E5mFx7r8aq165KJNA2Ur/QVMXt1bA08VTfKMOfEO2qsILkGwwA+fySd4KD839Chnim7UGFZeQ3Rk09SABH4XtDTX+0sHe7SENPS+FMM/upt+hhC80mB3wsa2fAY9QIX6HesSgGBmq+hIsU32ZaNVq9hKs5yW0Sv+AyK1Vw0wci62BFqbJAS1wqe385FDMIyPo+l9KTzjpA74/yarEJFKTSMHnuXsWZ2JUVHgUvP1iNh2k/Ws/Se4r1gwbhcOJXnrRev40UW6vcwBLY+cYboNZSO/oQsP13h6I+g+iO+ONduoR78Gpv+RwtwRD62Ffe4aY7jQJOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(66556008)(6486002)(66946007)(54906003)(2616005)(8676002)(41300700001)(8936002)(4326008)(26005)(36756003)(478600001)(6666004)(86362001)(38100700002)(31696002)(6506007)(82960400001)(6512007)(316002)(53546011)(2906002)(4744005)(7416002)(31686004)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZpd1h4SERuMEVpK3hXZnZFZUwrc1ZINFlGUHJSZlZVdjh0NDAyU0tNNXNI?=
 =?utf-8?B?U05xRzBReTgzaTZscm5YZlFHSitrMkVMRVJsQzg3SHFBQU8rTG5yVkNFakdv?=
 =?utf-8?B?Q1VKUmJjTUZVYVAwUU1wbGZ6Vll3QkNWWXFCbFFTM05GajlOSDRRUEU5TFZo?=
 =?utf-8?B?ckxIYm9Fc3JXY1hsK1hTMmErODdwL1dwQis2bnFkTTI4RUZ2NnhaTnlKZWJw?=
 =?utf-8?B?dGl0QzNjaTdQTWFqa2ovOVl2NHJVTHY5MEFmNjBFMjdyYi9DK0tKRTZqZ05W?=
 =?utf-8?B?OTNsV2ZOZFZoR0ZoNEx2NzJLSXdKQ0RaTkpEM0daR3l6TVdlaVZqKzBYcEVt?=
 =?utf-8?B?VzBJd1g1enQ1ZVRWb1lIcWlLQ2ZmQlJpakhsLzY5MkVvNHByS0U5aVhZNFBU?=
 =?utf-8?B?SzFBdFFHd3JpbTJSaG53VnhKVEZ5RjYzRzB2NllvUTVta0VJbHIyOWRYZjd5?=
 =?utf-8?B?MWM1T1Zzb0Zoekw2UzRURUxCM2ZSM3ZIRDlZeXN0UHQ2QkwzYXpISlF4Qjda?=
 =?utf-8?B?a3F2cHY0ajNIRE82d3djYjkrbnhHbG5GbVlGcG9JMDRuejNwZGs3c24wbWVy?=
 =?utf-8?B?Y1FieHBudVU4anBjNk9mbzFaQVVyV3VLdndoTmEwb0tTNWdhYmkwYnlvaUVC?=
 =?utf-8?B?UXQ4MkduSllYUHlyT3pmbkVLQWNEM2JtQjVlKzdobzNra1kvQnlxcjRzQTFX?=
 =?utf-8?B?VzU2c0RVTURQa0tEMFhaRWdkOXNvRjFSYUd1a0FlVWgxRHJMUTh3dGJGQVJr?=
 =?utf-8?B?V0xpU0djZjZuQzRWYkN1Q3Exek0yUnhoendGbmNqYmVDc3VYV3ZyWHZOODA4?=
 =?utf-8?B?bEF0Tk1wTXgyd0RCSDI0S2M4MVJuckpwYnByYVJ4bzJBbW00OEsvMFZFTkgv?=
 =?utf-8?B?ZzNHYWhvL0NwUjMwM3ZKa0NxcFREeVFxdTJZMmFRZit0amFHSmZsbk9XZVhV?=
 =?utf-8?B?a1c5YXRWaTlxWmlRT0ViSy93VVRvYmNJcjdaaXh1bUZWM0FXVUJaamhWdTRY?=
 =?utf-8?B?bFpxYmsrenFhU2loODYyRjhPdDlQeTEyUDYxTFBkUHQ1RjQ1TXJWVnVaUXB1?=
 =?utf-8?B?cmFMUG5QalZjakx1dHVITzZoaUlyVkVtMHF4dlowK1dXMElCbFFEV013VzJZ?=
 =?utf-8?B?RkpHVVdJbE9KWkRiUUI4VDRkekcxUlY5WkUrMk9XY2ZHYzRJZmgzcXd1R25z?=
 =?utf-8?B?L1B1bk9SY3RIeGZvT1lKbkwwTTVaTzVXWU1FeG5sakkzWXQzR3dsczMrYlh2?=
 =?utf-8?B?ZENJWmh0RWZUY0ZQbkEzamhJSktTbzBQM3hUM05ocHordldkb1I5K2pBWVBn?=
 =?utf-8?B?emNwMTAvS3krMGtBUUhQdzF3bU9YYUR2RklERnp4MW1oOU1WdzZwSG0rQzhx?=
 =?utf-8?B?T2cxMURSNExqbm1oOVpiZ2tQY3JXL2dEbWRHVDFHU2RuZnNqNnYzcEZEeG9Z?=
 =?utf-8?B?VXNSVmVZaWQ2MnFiK1pTemdsNnEyNkdEZCswUG8xa3BkcHFsREg4Q3Yrbno2?=
 =?utf-8?B?L01uZlMvWHBDT1oralBsa0Y3V3ExcTRlZWwrRVdLcUVkTVhxcjZyU0lpQ0hu?=
 =?utf-8?B?Sm5TODhKcVhPc3I3TDltOHBlYy9hRC9vRVNHMmM0QkxOdklGM3p2MzNDU1Rt?=
 =?utf-8?B?ZGh4UkxyUnl5UERUTDEvQ2pGUDA0OFVnYTNrdktPbWx0WEx5bmZTaEVkcGNN?=
 =?utf-8?B?eXVqc05nMHNDU0FyRm5XRWZNeTJhWGdLU0xzTFM4Sys4MnRWUS8zYTRHTEVX?=
 =?utf-8?B?UlF5TlgzakdQUVBRWUMyS090emUzYzJxZDJYTXMvK0RoMjZLWjdxT3dOV1pP?=
 =?utf-8?B?TWsydE9rYjJJd2VJVEgvNWlBRThXYXIvZGQrMFVmcXN1cVB1dktRRHk1QW16?=
 =?utf-8?B?WGpIUENNSDQ3MFFQT3crdjY5cEgwNTlLQlJhdXlrU0JTTU5vaWRUQWlsL1N1?=
 =?utf-8?B?aitUWGhrQTRjQ2EySkJRWGNTMlNEaG12ZWVUSWtNL1hvbG9lbFI1aWJkWTJu?=
 =?utf-8?B?cjN4V0VyZGt3d0RDOUZKSmRaRUZXL3c2WnRIOGppUXlMRWNEai9xeFYra3Jh?=
 =?utf-8?B?THJDNmJxVW9ycDVSKy9LMjM4M2tJRlhQbHdGWWxUemtMWExaUmh5YVoyQU1o?=
 =?utf-8?B?U1VwakhpeFlLWmFJSlFhSzVqWXhOQ1JWUTA0Tkdxbm8zN1FBcm50b1EwRWdy?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a743b5b2-00fe-4d3d-55dd-08dbc4556d47
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:12:18.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5GB6Zb2NHeBItxTP+r+Bna23CO7OgKJEK+nRlxkJZipgiEzDDXXRx9Odk5LVRxrAe5Nj1OFtrCoBJ/IOoLegjQ5nbabfuWZseYWGDhZGqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 91a6ea783200..ab96af8d9953 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -7,6 +7,7 @@
>  #include <linux/kernfs.h>
>  #include <linux/fs_context.h>
>  #include <linux/jump_label.h>
> +#include <asm/resctrl.h>
>  

Please use empty line between the different groups of headers.

The rest of the patch looks good to me.

Reinette
