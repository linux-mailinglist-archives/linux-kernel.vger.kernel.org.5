Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3B7B0C08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjI0Sdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0Sdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:33:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9503EE6;
        Wed, 27 Sep 2023 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695839618; x=1727375618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cd+NMLYQi5LerzAguoXoXjl7QCW0Lj6TnXxvqUCJjjw=;
  b=XnEZrYB5e+6nMhPdZivoqkUeI8XY1Z5ZeVQgiJOeEGPi9iiW/u0mKFNM
   /rXjOYcOwgaRTVHbRgnpJC8PESp2gKaLvUMdTJn3Se0/eL2D0SDD8AAYH
   NMy6/tf8lL7W1HuQ98vlfEcZY7JFd6xubn0KWSLVY/19sAYH93MnhmUXp
   kxKODgkVPHpm5kT+IrZoC1nED25G5W2VGy0c4q3PY+mKmbK2r4S9cV42v
   /9Y3s8rSBNgh8RY/NNira3wzdnb2tTkFXrDn85xkuDZeVjgEbwSjNVu01
   Wo5xAel+Py2pfPJ0eIWfVv8uJQ3s3hlmBcWklkfpv31JBMhyP3HFF8f0G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468182602"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="468182602"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 11:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="725923637"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="725923637"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 11:32:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 11:32:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 11:32:17 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 11:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpcBK/INpf4molmdn9WqPyvOfpkZ9KsRLyMWTgyPS49/mE1hjSZ6dxBxyU6stADGjSVUVgdu+uGGGN7sTtaXg4RsVFRbn7aaQMj/2SXV+SY7Ho75Gv4OguMVN8z6nj/DrmWOCvklBdE03LqEwL6Rstivozre6nX7mPAXIDo3WPpLbmaAteqHBm3Clt39HeQUps3mt2uq7lAhUGZSF6ej8S9qU8CFPjTIFZaBkAvAdoKwZXfW+7kzRFVOnmomz0gWshnwS+iqpSWasiOhD5Mncjn1YMm7d/Q8GnRYm3iblEdqkoONIQxjHBl3UjlnXL0GyX4VgVEmnM42utG1mEO3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aatKWTu9zwwYF3wTDKvkOiO3GTeSgZLQ3ImTL0nPM0I=;
 b=dj9tFDs3g4nOq4lCKsy1V95Vqbkz2WIrV4uV5WUkpFxTkhHLxt1HSLBKWwMPo9s+MkLgG21L0DMYMYW1iB98ABfcIiMP0i0BfZYtafiudI3ulRPlsK4byJ0vIBS5F11MRGhgMlfBOMVPfRNTniAR2zgS+z0qNgoi6wEdLvAFueEAs51kX0/iwQir43rdLk0XdgsU6Lg4RHsMrREz7CbGu+MxK3jawkTuAz9BBW3ZGZLvuC99dotAuo/y7QdgCGCR+g/m9zS92qDsckYqRExhlRAlXFzXGvmJjgPCGnMZZvAAoWnVuUze8up90vwktaoLHXmuQp8+wQgbcABHQwgowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:32:14 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 18:32:14 +0000
Message-ID: <8d16c0fa-a328-4985-378e-05c7486c0aa5@intel.com>
Date:   Wed, 27 Sep 2023 11:32:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 08/10] x86/resctrl: Display CLOSID for resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-9-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915224227.1336967-9-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:303:b6::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ccf7b3-a14f-4222-bf52-08dbbf881205
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gs17AyB73L/bf9VyEvhgSLCELgixlWuJH8LG2D6VxJ7R9mTu/bwalSdztHMRP6uIyg6QBuo6uvUoEsmVojBAmMxQIFE3siquTaPJvH1CbPEGCzdNMYihMOLikaXoEHq/Dk9u8YerqGL8ve+uffZiopK86yaShGnDmJn9GmMA5l3aueza+OJ1JBJDLMWeoNjmoeDMl43DiIxRXHQntDBdIwAlAnd9iaHQoHDsdK2gqRf/seC0JACXS5E3xwjjilbOLyNSvB2AOqBQzuPudFpo+7x+xZgYoTqJnI8IbLttOMZpFTeknWeJocpuZsBb+0KHnP5FU8gqOLk4CuUtj+xj5SobgFMI2C/hzKUr6N3bAhrE+cLXnY+5JPS8bm5DfB8XfOv/4WgqrczRWYQxOptjTRUR3gvmB239UlNeuB8zeeTSfyH6Q8S8D9EWufMAEmOLiXQUTk28xjey9bB0xi5SaXL5L1IQSlLHoJkxQxd4Oxy3iJO2orXnxSIeiJs/5xwov3vg6tYN23X4jXRq5xZiZdrU8H9TE7Hk0B8evk4ps9X5vUjOww+7yM2AiyBLbwZWsoEZvPu7L2bSy2fSVcPgwN9AqLYFmwHpYZtQNh8AQ2wELeaOcstkKRgI1yALKNECq3LdjGPvu3d1bfzedje/1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(31686004)(6506007)(26005)(5660300002)(7416002)(7406005)(44832011)(4744005)(2906002)(316002)(41300700001)(36756003)(8936002)(8676002)(4326008)(6512007)(86362001)(66946007)(6666004)(6486002)(66556008)(31696002)(66476007)(82960400001)(2616005)(53546011)(38100700002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2Nxbm0yWTNqVzcyazZ0aVVyNmRTdUdiVDdDb1d1eU4rKy9Ma3JRZTQvNXdW?=
 =?utf-8?B?WWluVHlXZG9SdjNlaG5kM2NCTkMvUkhTS0Fwd2taOU9KR3kvQWQwd1RDdVds?=
 =?utf-8?B?bFk3aExML1pmSXZJcVo2T1cxRjBXYTFrRWgxOHR4L3M2bXhpMkd0d2M3L2kr?=
 =?utf-8?B?amY4d1FzTTlwQWxMZ0tPN3cyd3FSNHhXaE1VNUZtdjZrOFF3RHlUdlJJczdL?=
 =?utf-8?B?TSs0eHZDbERBMXNXVXRnTkRTMkFWbXRwM0RLT2Q0QktLajdDZWZMWWVyTzFB?=
 =?utf-8?B?R3MrT1RhL0JGTHRDYWw5RUNxblhtWUJrY2F6dmd3eTNJQWdvYUQ2bVNFVGRt?=
 =?utf-8?B?cE5pLzlQUElqS0R2V2trZEpHVVF6anMxZHdSdDVMdldwdXl2VXY0dGxEcEN4?=
 =?utf-8?B?cmwrYVM3Wk81U3lWclYwQUlLa0RNQnJrbWhOZ2xCem1uaFhpSkltYjBWOE9O?=
 =?utf-8?B?VXJraDhPQkUvY3MvYitqbjg4MVlFcm5sWDBzQmFwbGNEQVBQc0NTck1ZSThL?=
 =?utf-8?B?T2dZTkV4c0VUUFRjTUtaLzRkbDFzYWZsYXRVcmtkNGtJODA3djlRRFRoTXVk?=
 =?utf-8?B?a0hHUXVrbFQ0elZRZDQreDhaQlk1RDcvaGRuSXNnK2pvK2ZpNFIyTkV0b01n?=
 =?utf-8?B?WGFhNVpqQ2FYSlZiVXpnTWM1RWRUN3YvT2RPa3BqdFZxMXRNMWxCNC9mcHdN?=
 =?utf-8?B?L0ZWTmVmNXBLSTdieGpsMVRNNi9zMWlpaU54ZDYydytyc2UxNnhpWXIwL0JU?=
 =?utf-8?B?ZVFZd29XVU0wZ1BLNndJRFlwRmowQ2t0ZGhxZGVDTWF4QW9KekZnaklUbEJ1?=
 =?utf-8?B?M2FVNWNjb0R5bkVIMEtjakY4SXpEbGdVMW9wTVk5YUZtSnNSYlg0alpnNEJO?=
 =?utf-8?B?anEwS0JvWUpPMCtCKy9jQzRGM1VjaFpzcXdJTmdRUkVnZmxxUWJsTnhGMFh1?=
 =?utf-8?B?MXdVRGY0TnlSaWNMaFhjMVlrd21KL3Noa3lSbDRBcUdtLzZOOTFQWC95eXEv?=
 =?utf-8?B?c1FUa0xPRnFlV0xzR1NnTGROaENkc1FhVjMwdWhTbEI0YjJXL3BmR2lIbWpH?=
 =?utf-8?B?eHZweVB1Mk9lVGwwMFYycEREUW1QVm41b1lYRFJnRHVyQTVRWmh6S1N5b091?=
 =?utf-8?B?OHZJc083M08wR25zckhCRll4QjF5RFJTODNJY3J1TmN6aWdZZjNNWWtMMFpV?=
 =?utf-8?B?Z0YzWnlrdDhKdEdsSERXMTB3eXNlQmY2Znp0NlBtOVJiOVFRL2h2TjR4RDEv?=
 =?utf-8?B?UnY1K1BRZnQwbC81NVRmK3BQZEFBMUhFc1laSjJva1BEZ3dIcG5SSXVTSklG?=
 =?utf-8?B?QmR1eWFBczhLcERSb2FGeGFSc0F5RklaSkVvUE9XeVNsdW1nZlNIdG5tZXhq?=
 =?utf-8?B?U0ozZCtteHZFNmM3N3ZRY1FTOHBneDA3dDU0ZjdVWGM2bWJaVXZ0U3BqaDhw?=
 =?utf-8?B?ZTJ2OWU1dzlJcnhyUUVyOCtYaEFBNnBBdE5zbFRnZVVQYmNHTVVPN2g4TklL?=
 =?utf-8?B?dnhyUmszbFNLdnRmcGJLZEc1RmpOb1FRdEl2Rlh0ekZQd2FlN3BPelVwN2ZD?=
 =?utf-8?B?MmoyM09HRkJRb2hHczlrajJZZXVQMzFISUdxTGQwbUZ1S1VPOWtIOUJ4ZGNG?=
 =?utf-8?B?MUw0bER1d3lTay9ydVlSRGFSNlFqWHFhd056eWNNeVpxajZ5YzlyN3JsQlNL?=
 =?utf-8?B?VmRZQmJpSllZZVk1Z250VEJ1QXl4LzRJQTZBOEhESHM0TE1tV1k1Y2dMUFVD?=
 =?utf-8?B?SFJtYm1DZFZtZ3BJamJCWUJZM3kzYkdhanBYcHFsUnl4bWdqeHpKK2JGbG1m?=
 =?utf-8?B?bjZlSkNPcWtSRDhLa3R5bDlxc1RrbkRhYXJkZCtMdzYvbDh5ZGsxKzBoRklG?=
 =?utf-8?B?WGcwSXlLT2VTdlAvVHNqVHpHVlY3Q0NHaDR1djZEbnEzUTB6ZU9VVDAzbWpJ?=
 =?utf-8?B?dUtiQjJhTGFzUHMybUkzaG9NYXMvUGl6eC9MRFA0R3JGNDlUQ3B1eGNzMll1?=
 =?utf-8?B?QWgrZFpzK3lhVDJpTXlMQi9UcEJyVzFqZk1sRTNiampURjZwMlFWVUxQOG9j?=
 =?utf-8?B?WHZOMkJ3Y0lJTFcvVGpBTmFRVFVDZGp6ZWtCdEtKOWk1d3NHdFN0cXYyREt0?=
 =?utf-8?B?dTl4T3hlUTVEdEFQZEhjOHVzL3VKQTZwQ3JTYmFtM0JNaG41dWN4eGZRWVBv?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ccf7b3-a14f-4222-bf52-08dbbf881205
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:32:14.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUcIWxLDf0vZoFIZAAVjSzOXGoko0ZS4UT7O/vaYvDnXoqo3BkDGuLc2H0hWYXH8rCQHpasG5zvW/OzpBCqunDNZRBgL6FXrr7dnvbXHRU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/15/2023 3:42 PM, Babu Moger wrote:
> In x86, hardware uses CLOSID to identify a control group. When a user
> creates a control group this information is not visible to the user.
> It can help resctrl debugging.
> 
> Add CLOSID(ctrl_hw_id) to the control groups display in resctrl
> interface. Users can see this detail when resctrl is mounted with
> "-o debug" option.
> 
> Other architectures do not use "CLOSID". Use the names ctrl_hw_id
> to refer to "CLOSID" in an effort to keep the naming generic.
> 
> For example:
>  $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>  1
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
