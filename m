Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9647BD3BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbjJIGoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjJIGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:44:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC57FAB;
        Sun,  8 Oct 2023 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696833891; x=1728369891;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Kgjop6GWgYHTE7VH3Ui8pmUjpDYJJXR+LLzN7jTlZbg=;
  b=PWEDfYLPVZqb5hRxkj/vnduJwTtz1CDUmbJRXk5Am1GVr8fhnPypz71x
   mmJuOdeqISNK8Vjlk5MTA20hI2nkeOx+nSLMmcABcOfwqrGzV0dZU+4iV
   d7e3YAsHQ48vM20HyF9xeHUdssRN+mNah26M3cYVJ/TuNIR7kDA3TfAwH
   x+gqPEX7scdDHb8pHlLDfkHx5FZGV4uwkWz2CWwGp9nt4305A2Oe2WanW
   dEj1VzgIvHIfzUi1nJlGlV/bcBMGj+0tdpARURr17Ng34fI3cmkUTDqc4
   VfB6FYp59EY7DTMN5A/rqpozD/5vUtFqddXSyqkmp7U0T7oxOgM+17ROT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="374405836"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="374405836"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 23:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1084226137"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="1084226137"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 23:44:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 23:44:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 23:44:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 23:44:50 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 23:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHavlNdj3psbxbOc4QAbDjJbFR2ERGCVQruMEEPCRH5wHGj5igT0ykiKxJaRddJLkf7lJ5dom5uVn9JSrnTGC5ORh5dMclCDRLAKYWG9YwRBKBv0mHoHh0z5Ib4110TOdn2/ERWkm5JA/BdchAhrMTHZe13/WlkXesOBgeMqkTPrZ37FHwf2Ynv3gq0uS9Cnj4BPEbgL0zCJEwujJSke+5R+I55KVsqA21O8C+Lvze2vz6m8PevAgof0Zohrj5K2qsTbTEjdpCnU8oDIXxjV89TJsdQebojdPGAdmxSnoU5/9Mzr7PCttHZ2r8yUwUYtsHIFKxBAb70IUiaaFel8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LWaxf1Dt45ct67KWFAfPMqIP/4xTZZjHDw8ZPNGZkg=;
 b=acphsJ7oK5sGdZnZV6MB4TIsP386iFA3I3+1nYoWmi9M/FIGJBctH3F5KUuEgMRbITmoEql43/JOmITC8LF0mqFC9nbH7YXI4wrTI8Z0wiUEgeL5JD6yHrVyzr4MTnrj7pHmf/vaMiyd7ldOOUYWn3rYk85VJDcMxtWXXO7J9VGN7k04cQeVF9GJ4sxV819urz7ujUC4urxX9+loH0svThGjVB7w1cdltt3SJ46iFWorqFpwGkl6VIjvXNzXpZbGAqm5Wx3M2Dz/iF02h8LptaJCtHb68rxTHrIVlhzc7mtvK7ZBeBf1X+6mLOCNwJdEBadAw89+Ux5USIx9JtGHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CY8PR11MB7241.namprd11.prod.outlook.com (2603:10b6:930:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 06:44:48 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::fd1b:a3b7:11a6:4bc3%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 06:44:48 +0000
Date:   Mon, 9 Oct 2023 08:44:40 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
CC:     <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <corbet@lwn.net>,
        <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <bmoger@amd.com>
Subject: Re: [PATCH v4 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Message-ID: <pve5jzaocwr6okpekrmtqut7gza2yeij4lbkweelk4ei7yxwvx@qrsqfhaebuza>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
 <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
X-ClientProxiedBy: FR4P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::12) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CY8PR11MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: f499bed6-de15-4c48-a68a-08dbc8933b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QkSX26y75pMO5Y06YRNuykh1WepYPiFGDPUVkNY/IDLGm5miqVxwJO692WkGYc9TKrra2miIx/bZpsZ07dHF1mD4iPWjEMl/uPhgRdlvCsQwNkuPfhQZCIRI40Vr7+xrQbI5Agws/5agLL/eG6r+Y6nIYpYrbP+RBg+qIVLSTluq+chr/AQ+6Xp+7llAhrFQHBF7CylyWQZnd36AUfgqYf72YFUu059HYQurw+Lc7obhF+zUYpxpALURhZAIIoYctNYk20Ps5+mGebxr5YgnWBHANN+fek1gk5iqXGy4lC5AxXURyM8n+cnnikpfgpYOcZXt3sE/Ju2mwEQbrwWUBsTaohebe4FRspW2+rcGg9TqMVZeH2+JRwdpq1SoM6XEn7WXHsoGE7fzKna3wOMCrnxl5TjQL4pqjKPR9Tx+opFcfre1Cgc4F1i3CfEULQt/RMcHprKk/MSLp0TMVOncnYENR73i8Njg75daHn89i1A5WGyxXFCcjWOjGnveVuFjNJDvXkeSBJeb8uydmtBVFayAVeUsz2I680zfu/hOSMFM8jsFVX2+YTJg7VGdnpJmPh8Isb272FEihJgmuDXvbRBSRVDMYPyeT5tn/foNbYK9dhbWBcSKn/lUzWx+vFMKHVz/lXtKtadRSPn0LqUvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(39860400002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(82960400001)(86362001)(33716001)(2906002)(9686003)(6512007)(6486002)(966005)(478600001)(41300700001)(8936002)(5660300002)(4326008)(6862004)(8676002)(6666004)(53546011)(6506007)(83380400001)(66946007)(66556008)(66476007)(316002)(6636002)(7416002)(26005)(66574015)(27256005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXM3SGM4WENlUGkyWVdrd3NyM0ZYeVNnd3E5cWxGb2RHdS9yQW81VnlpTFJE?=
 =?utf-8?B?ZUFVSGd6MnRFaHFPbDZBeXVVUGNhNjhacU9CMDkyZkhKU1hCcEs3ckNlNlZL?=
 =?utf-8?B?bis0WWJRVVFKMHc3LzNFNWpEUHZHdGFSTDRqaCswaVFwdm1mSTZ6ZExxZzJV?=
 =?utf-8?B?UXBicUgvRlFjRlQwWlNHbm9xL01TZE9vQUZKeEFTdnZBT3h6c2FIZzRIMTcr?=
 =?utf-8?B?ZThreEd5UWx4alRFSDNkcXZaWDRQOVJzbVE5RDJqUDIzd1NkazdHK3JCOHVS?=
 =?utf-8?B?bHZPY1VkZFBTRWcwS0tKVHQ0UXJJcHQ4YUV3UkFELzJOb0dnYUdmZElTbzNL?=
 =?utf-8?B?K2NvYUxFZ1pzQW5ZTUt4L0hESWs1bjRQaXFJbmE5RlVpZFpNdFdqbDlXaE5F?=
 =?utf-8?B?aXYxR0ZJRGFiQ0d3amdWVUdXSG96cXZBL2Q0c2V2cExHZEtrM2h1T1BaYzJt?=
 =?utf-8?B?d2pTK09TQVg5aVJYK2hIL2pYK0JnMTVNendhS2VnY1NwbHUrQTVpRGFrekd5?=
 =?utf-8?B?dVFDcVBpV0s4OHZVRWJiYjg3SUxFY1hCOUpuNDRVNzdXYzZ6T25qSkQ2RTVa?=
 =?utf-8?B?RzNxK1JRTEZJckVyUmFDSjNmK0VjSm1EMFdRc1lYMVU1S05IL21ZWE9tTTNn?=
 =?utf-8?B?QWNteFV5bFBKdThSdkJ5UHQ5V3Y0Qjd5cGx4ZlB2SFRpeFAzZW1JcVkvTXMz?=
 =?utf-8?B?c3drSjljclRqQVRTRVZabk5NbW1CYkk2UDZqYVhIRHc0T0JRU3JIamVjaDA5?=
 =?utf-8?B?dDNha2hsMmRrWklBdGZrMDFORUV2TFdTNkFxa3UwaDgrWkZhamxlNVV5NGFH?=
 =?utf-8?B?cWZDVms2dTJiUTVSaXM2TFFEQUVxSGp4ZXkzbFFwL3hnTEh4MnhnYkNyY2U0?=
 =?utf-8?B?akljdVVoWWZRUnFrTnQyZEhRWnRGUzY2WldDUW1CMjVDVDJjY1JaNFN0bUtL?=
 =?utf-8?B?eEpHbVRHQi9JbDBXdkltVjJNNVFqSFdGVVMxZHJYejVYZWpZY0hGUGVRcEVw?=
 =?utf-8?B?T0dxdnNvbndUaThOTFRabjMvaWZ2cyt6WExzbkpEK3N6U092MkdwdWZDK3Ni?=
 =?utf-8?B?NG1IeGVlRkljeUpSdzBadUYvVHJQODVkR2ZnK2hONVFLZzFoa3JQa1dNTUVL?=
 =?utf-8?B?dVFVWENJclk4V3g1YVg5NlpoVklJUk9pN3hLa29pRVdOM0o1dkMwM0RwMjRF?=
 =?utf-8?B?MmRQY2libWJEZEhTMEc1SjRSQ1doM1BicGhEbkpJMGlWOVdRL0RVR2NOVFRB?=
 =?utf-8?B?Q2pFa0J3enl0Q0M1anY2Y1lZOHFKMkJXeHhHejE2UDZNYWw1aFpUekNsN0xV?=
 =?utf-8?B?K2lSRmxaZEs3MXZtNHQ0Zjl4bHNvZS9RR1BqV3hjWVZ2KzAza0orRUM2NUZZ?=
 =?utf-8?B?WHdOaGRvbmdBVUNOWmQwWVY0bFZmcDhnVUNXN1NYSTM2SUp6eHNmaXl2TkRx?=
 =?utf-8?B?bWJvRVg2QjRremNyNnQwdWpsN2xTYml1ZWpxNFBLb3FmZjNhbWZ2TGJwbzIr?=
 =?utf-8?B?MzlYTHBjYkhHV3U2Qm8ySFg5cnZObVhNM3llSStoc1lWWjVDanYzOG1XSjFh?=
 =?utf-8?B?WFRWRGRtMUdNSS93d3BJTy9rMmJMbWs0ZVdqcElRaEV2ZkN4MXlFOTRZcXNj?=
 =?utf-8?B?QVh5ck5WaWQrMGdHZVJpQVQ2ZW1DcmhrLzBMcnlzaGJTL0dEWkxuTElyVm51?=
 =?utf-8?B?aFpBVkJSMlA5VE1HSmtwMm4vcFc2b2NVMmhDQjh0RElra2NrdzMvSTNnQ0U4?=
 =?utf-8?B?MS9ULzhJbW1uUjJoaUQyd0xCWCtMZ2E4WDNKdTNycUpxMmxHZWZTV3lnbk5L?=
 =?utf-8?B?cFcza20weHdjZWxHczQxOEh6N3ZLa1RxRXdmZlkvbklXSGVBNVU2b1krdC9I?=
 =?utf-8?B?MGU0R0RPUkRyTXBsVTBINHpWSWIrc3BjOENYMU9xeWJQeFByd1ptU1ptWU0y?=
 =?utf-8?B?eGM3NmFFRFV3VTJuUnJNRW9PRFdpN1Joa29CQ3cyQ3FmaDNYaVlnNnVia05x?=
 =?utf-8?B?SjFWdjRrenRQQ3JMdUxtdEhLb1hSSCsySUZVMDJrcUlEc2puMERCeldZeWIy?=
 =?utf-8?B?RTl1Vmg5YnBmckNpcEh6Wm1UUHVjY0ZBQ1pWNGdhbVRzWm9sVEVCNmFuazFw?=
 =?utf-8?B?MmtsdXo1REkyUDhzc0F5VHFxSE14OEd3LzB0OUFMeUdrMmJ2Q1NCMEtyK1d6?=
 =?utf-8?Q?bxt2Rp0nMKaz+1ISYHQjTlQ=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f499bed6-de15-4c48-a68a-08dbc8933b24
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:44:48.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XmYS+gttF2kNCnARtodlg8CyI56woj/AgOMZtfaIyZrIz8KWPwK/x+TrbXgFukAsS2zO4qhn7MVTNjbSnE6yAV4eLbpygTYl+zEQMw0Tn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7241
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-06 at 10:53:52 -0700, Reinette Chatre wrote:
>Hi Maciej,
>
>On 10/5/2023 1:14 AM, Maciej Wieczor-Retman wrote:
>> Until recently Intel CPUs didn't support using non-contiguous 1s
>> in Cache Allocation Technology (CAT). Writing a bitmask with
>> non-contiguous 1s to the resctrl schemata file would fail.
>> 
>> Intel CPUs that support non-contiguous 1s can be identified through a
>> CPUID leaf mentioned in the "Intel® 64 and IA-32 Architectures
>> Software Developer’s Manual" document available at:
>> https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
>> 
>> Add kernel support for detecting if non-contiguous 1s in Cache
>> Allocation Technology (CAT) are supported by the hardware. Also add a
>> new resctrl FS file to output this information to the userspace.
>> Keep the hardcoded value for Haswell CPUs only since they do not have
>> CPUID enumeration support for Cache allocation.
>> 
>> Since the selftests/resctrl files are going through many rewrites and
>> cleanups the appropriate selftest is still a work in progress. For
>> basic selftesting capabilities use the bash script attached below this
>> paragraph. It checks whether various bitmasks written into resctrl FS
>> generate output consistent with reported feature support.
>
>This work conflicts with Babu's series [1] that is also ready for inclusion.
>We could wait for outcome of next level review to determine who will need
>to rebase. It may help to provide a snippet of the conflict resolution
>in anticipation of Babu's series being merged first (I will propose exactly
>the same to Babu for the scenario of this work merged first).
>
>Reinette
>
>[1] https://lore.kernel.org/lkml/20231003235430.1231238-1-babu.moger@amd.com/

Thanks for fiding this issue. I can see how to resolve the conflict but
where can I put the solution?

I'm guessing in the cover letter?

I'm going to resend the series very soon to apply Babu's comment and
tags. I'll then attach the snippet you mentioned wherever you think it
would fit best.

-- 
Kind regards
Maciej Wieczór-Retman
