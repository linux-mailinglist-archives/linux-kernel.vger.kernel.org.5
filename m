Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EF7B7327
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbjJCVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbjJCVOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:14:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3717AAB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367690; x=1727903690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HkChKasYfDZJXfxY3O6R0oGhN6HMI58NVdtI8CK6pMI=;
  b=VNkfqRei4bbZ9S8f/Le6z+lYhwdaidDPpUn2PlbgkhwgzyBpZ1XD/q//
   G8iX7dSCE+fXRsU4fLfPSo8KqaxFk5Ce9Xpul6IbVIfqeHn0CgYVmW8Xc
   19v3+r15maH9yVuJ9Fj/Cr+gc4huteGD4oE49Y38jM5EShn5E1NtX+9aa
   h2EFRKMcIoYnprzTQ/Muyz0PdUfFHox1nrfM9cRCyK8HOT9FLxPH43XmN
   inbhrZrYZYlCO16mVMGre6chgQUuV6xBCcF141xm/MoIaZ2c5QjuM8Z2k
   xZZ8BTfecZ6xIvnkpox5xgF9lekiV2qVqpS/WbixiIPJ2HTYuMGtWNZy9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381853949"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="381853949"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="816852471"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="816852471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:14:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:14:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:14:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH13sFcbqcqIaXzVDVyts9tosAhSdHAlQFdJqDs2Xej7NOlQ3dvm1ZcjpIS+3m2qEXPmYh8Cq8pio/sBYFFw4ZXIAyonPeWu+s1y0UsvV8SReHNmRw02O1Nl7TaMjr6TQzQYrhA/doc3rq0TjafG0+itMQqcwTch0jNiZ6/NuBqKTWolGlyjhHi+J/k2E5ZtVoSab0qLiK/cCTRmC+2yER9hfqVmmfLVhSrOqu5fgtzVUo4QuG7fNUt/p4AW0GVy7iD6/sWv1MWRil/mfyZ3PjaeomgWUta2RTrAmbkRkLaCAXvbZZQLNI/fMAgKg3wrnEKeZF+cTcvIiuhw+FRunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EYTXy4bOHxpywpNaNCHwMA19L1OqzucVLkCpW178Rc=;
 b=cOp33PG0DBBfcS/KhJc+h9Pl3nEg26YbtA9j3oCiU6ltUCKVG78J4nDP7uNQGRLoqK1wxxhAjg5yhXG3m4VL1eTCSVGPqvZE84I2jya2vmRqup8VdOZpgoiQMibtA/HOKNFX08ynWigooQiLRarC+wMONw7UCCVpTnnHftUV2rrQrk5oIh2wrcHDZWhb2XPCyW+EhHbiAGqRZKL3hvrDjU15KfVjYKUMs4PdOKvUmAnTxFdlt2Hp7TtDoip3mOzbQwwJc4UQxPTkJ9Om4COrkUTdm4LqvQZJhYRusFm+BoaUOTR96aXgY/3Xu42eBI0pw46Q7lNl4Ww1OZHeeqJwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB6059.namprd11.prod.outlook.com (2603:10b6:208:377::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 21:14:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:14:46 +0000
Message-ID: <015a4cac-f8d1-eeeb-a0f2-f423ab086e3b@intel.com>
Date:   Tue, 3 Oct 2023 14:14:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
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
 <20230914172138.11977-11-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-11-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:303:b8::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a662a03-1f41-4981-62c5-08dbc455c518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P56/eMArfGD9lwb/jhJZcIox3NO7acJWjmzfZXAe5gijXH1xT6CL2vKidKM51jyS4gTGuXzyJJM/LDfy1CbafwhRycF5cgimoHidEdjwnezyyeoYVriZT0fR8l9GzX+CLIoXIl84lt9Gb+XA7KJ3f8eFzGfU6rywPrJf/ecnjKPBt00O9SqRUBHjusApTf9IJuhNI9wRR2uBelPyW755GcN+UAf3ByA0slQns3ACyHeUfPxHaMJZtvEp6+y45wmC3TsSYlYwu9dKiMY/s4Hq2o597NjIHeQGi7CqGu95MuN30qLrq+lcRlFjrVY3o4LKOviDaMeUoZ2XlfxmF4MrRLBui1hTtgmQyNNB/Tgjy/NdRvMQZ12JOgNyAXWzdA07f96ovpekWc9vBC8UambbAppobJchwdmpccz7DUOWhn5HNbr2B1D7YY0M+yBIYTX6WUCl0WtXXn4wJA3izA/9vF8nDhzyglo82puyBcsbYoUjeMHlbJIo0nrJi+UcfoUWII0W0dKJh3ySenmQxM2wVQidp9WKN6aZsRc5ORyffHIWZI3B0Kb5rs+xCJ7tTFqWEvr+c+CcyEEAuvQpHsItJsxJLrugkrcnDdGojg/MMHfhYGnLt7RK3hsmd5Hzl2bbBpHt6pus63oLHQn5xxB8mBIf55uXqbDpKft9lS59/kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(66946007)(4744005)(8936002)(44832011)(5660300002)(54906003)(4326008)(66476007)(66556008)(8676002)(41300700001)(6486002)(6512007)(478600001)(53546011)(31686004)(7416002)(6666004)(6506007)(26005)(2616005)(316002)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExuZ2RIZkRPZlU1TElzZjh5V2xRVHJXZVlOa2gxZElEZVBQc2p1bXBxSWZi?=
 =?utf-8?B?QzVzdmJmSVoxd2FNYllZblZGa3ZaUkI0SmVnWVV6dmhFaW5iMEVMZGI4cVAw?=
 =?utf-8?B?YkhveWY1MVJYcVpZbVBWZi9MK3NiYUtILzRPQ1FSNDdFNUV6WE9XV2d1RExz?=
 =?utf-8?B?clpaWVBNb1l3dlpabGhXOG4rVEd3ZmQrd2U3MEs5Wng5NjRSMEFKY3l6aTV5?=
 =?utf-8?B?ZXVJN1BtYmo5ZHZOQkx5SHZ3NTNxelNZT2hpcFFRbnRaSGxQYWlXYldMMTdu?=
 =?utf-8?B?L3dHOGdCT2NCbElPek1YUTYxOFVwWk5scTBLZmEvRlZYTHpzbWcxTi85eUFH?=
 =?utf-8?B?eDhhc3hjSmV5ZVkybmk0anJyU01Vblc2UkF3TDJQSDROSEJGeHBpcmJTcWlS?=
 =?utf-8?B?NHBiQUlvd1cxZ0JEakxDZnpxUDE5MlkrYVNBR2wwdWlMVi9QS0hENVZUK245?=
 =?utf-8?B?OHloR3FvOVlLUGtKa0kwZXhxV25kQnhmMGV5QVcrQ29zVTdycUIyc2tKdytH?=
 =?utf-8?B?OFJsYkFwN05BM3Q2eGtTcjBFVk1tc2lDeThKYkZVci9JL2NzaUtMM2o0YnM3?=
 =?utf-8?B?QkU3dTRXVDZmV3hEdGhZb3dseTJXdmFJWnR3dXpKbVkxdU5JdERJd0NUYjJY?=
 =?utf-8?B?QlY3ckkwVEpFMHVEc3RMUVI5dWJaNnJ5R2NlVUV1M2hzSUpzbUQ4SG12MWkw?=
 =?utf-8?B?RTZjRnJ4clY4L0Z2aGpyOC9zSjFRci9ha0wzWDllelc5UkU3WHlzRDZxZ1gz?=
 =?utf-8?B?WFA5c2R3ak8vT2dVenNXZDFHTG1kRHBQWHBsdWtQaVFpN212Zkg5Tmdwemxk?=
 =?utf-8?B?M2dYallSVWM1akRSS1k0U1JSR3h2V0ZyU004YUNXZ0J2enp4MEV0dFo3Vklm?=
 =?utf-8?B?WlJ4STUxSVlNOHFvYVFldjVnVTVLU1U1RDQxbVZ4RlNsd2RXLy8rblhqNFp1?=
 =?utf-8?B?TTJmald3NGdRQjdxNExMTmFvMXJ3WUZEM0k0cUxvTkdyMmZMMWFNMk5hZ1Iv?=
 =?utf-8?B?WTkzNzdXUDh0dUF5SS8wVU5LOGNSWkwxUE9qckgwRk1GZFBKcVZGblpaWWp0?=
 =?utf-8?B?Ky9wdC9PY3ZvV3FyVkhCaFNTS0wvUzFXT0FETmpFRlU4dXl1VmthVE1aTUV1?=
 =?utf-8?B?VWNIZ2tacmVmYitDZmlOU1RqK2pkbGNYTjhzRW5Mc1RQcUVlcE94bm9qRlhD?=
 =?utf-8?B?cGVGcHpwUjl0azBPSXAySXk2L2hDQysxMld4TnM3RFhndCtZMVlzMFhabllr?=
 =?utf-8?B?UTBPMVhvUEJsUWdJN0wwQXZGc2pLMCtCN3UxVjlhNy85K0pJQ05sMVUzaHFE?=
 =?utf-8?B?ZG9ZcmR0a3luN1ZpWnJQemwxdmJvUzJvMG1kcFNKRnRkWEwvNCtXdzNNbE5n?=
 =?utf-8?B?ZnVsNjdsWmVaQ0dVd2ZBcUNtc2M1bUZ2RUdVTjUrV3ZkNnQyanJQYmg0YmpD?=
 =?utf-8?B?NytqZ1RGam5wcGFKU0FlWVN4UjNmYjVSdzgzM3lUQkFIbHFEUHkrdFNJVVBt?=
 =?utf-8?B?UHNIZWFkNWtyQ0ZEK0pzZlRBZGR1QUNiOGQ2MWliWDY5Y3h1ajZZdnZTbEVx?=
 =?utf-8?B?cWhvdXNQcTkzOTczZzJia1JGcDZxVFdBMktVa3JwZnZhU0RtVUZGb3V0R2cv?=
 =?utf-8?B?b3g0MWZIelhIaFQ0Kzk4OHM5WVFBOGhtOCtYbjM2THBIZkZ3MGVrZXlwa1hK?=
 =?utf-8?B?eFd3ZlIySjNXT0UreDJkNHRmc3pGVzdxbmE0eUpodFYzUkdiNkZNSEVxRVV5?=
 =?utf-8?B?UHRmM2ZUREhiNzZEanFraXk3dTQrckV2WkN3OHUwMFUwaGhlZy9WOWZIN3VC?=
 =?utf-8?B?ZmdUa2N2cFlybFc3QVJRR0JKOU1SbG9WRmIyQ04xeE9ocFU1RERyTjZEeFBM?=
 =?utf-8?B?R1N1NFFCTkFzV2lKU0ptV2w4VzdFUUt1T1VWSnhTeTRQVld2aGJCQ0VxV3dP?=
 =?utf-8?B?ajBobUtra3VQT09QK29WZ0QzU1FEbXpSdjFRWHgxNFdFbkZPeE0rOGJOVXZH?=
 =?utf-8?B?RjQrNUhkZmJhMEw0WlhqanBESDFsZDFVM2FjNzZnemJpZmZLYmpwNjltMUpU?=
 =?utf-8?B?RDV4MlhqeWxDQWRCcXRieUE5OERmeFVERjM5WGlnaW9HNVp4WFluUnFtSXMv?=
 =?utf-8?B?ejRRakxLSXdGTUpJb3pjaTk3cFNuSFk2V1pmWHU0eU9vZlE0VjhSb2ZpY0Vm?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a662a03-1f41-4981-62c5-08dbc455c518
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:14:46.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/3skRPlInhsj+PPqve8wCo1FBKyE6s1ATX5+QlQa3vx/5+S/r4ktaAlNPtwx9FMLOghDRipf+6/genXSCjeDTVicKCGNybMkKDAPYDgHfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6059
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
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
> 
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
> 
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
> 
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
