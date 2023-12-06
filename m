Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E88F8066E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376773AbjLFF6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 00:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376738AbjLFF6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 00:58:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96831B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 21:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701842292; x=1733378292;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J75hvgMMccTr5yGjaTg4eVA4W7kpoQ1vS+7Iy/Tyv3s=;
  b=AKiIdiQpxsi6IUIJQymGxSG0Uf9TO5cufJK03Cez4nAdviPHPzYOTvlI
   qZ5CqLoQZsu5gz4CUXiApnOdCO7IxUDatTk76guKApk/pnvSmdkIIdQzH
   MPG1la+sxQvqJaoRILQ9gb0nvkf1n/mIohvUqLPdSazrKmw2LA4wN5v1+
   X89/p5iHnx1ngf324kJC8uxZtSIHE0TYC+xDSlBkDHVETkxk+rVmG0lwz
   oHNqGu1GSqmWyFeZtSNRSLreMZ8ySNRsv0ZNCZy5AoTsXoK2mXlLr5S3s
   ZPczJkP9m70Y/r+h/grVSzl5qkLG2Et4XfBH/nJj+sesiCUsWJOl3defW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="384413858"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="384413858"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 21:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="915064352"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="915064352"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 21:58:12 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 21:58:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 21:58:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 21:58:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ToM6KleowvBHJ7xpuCiXyM4rUkHwh4ob3zpxz+WUu150s2tIl+hnwQARZomSLendqJ7nkXfGksiqrUpawzk4S6RzysqLBME0RVS81vnvPIM7TRo5ATva6HCs2/jmUSSB23wb0soQSZ0dRmg5dzQ9PGAxhNSUJY8ILV/3ZohUEKTm/U7eDGnPE41DcUBXArBvo40EqPEl13wYe9niFKDgZC+ga/OWrM/kZ4dox3uNBrkoSgiVehzBjw1oGmuBw4chUaCsQRMZVx5SlD3wYviFwxu08Xt+QTIfzk2+BaxWlCHv+7d01fET/udkkzG2Ja7dA8381sxaf1arcOqAxCejRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhOONXMIBKs+YmX/F1k64I22Q903OgUjwz46ICvHrcU=;
 b=AfVyZP2iSocJO5OTMP6/aGP8Zbs1i7dDxzGTnaUFPwmWBZtWVf5WTN1gBxHwDrb+tj1OOHkCbbtOYFtDG4JqWVSyTHrZ6ba0QePUxhpdBEa7NxxzquoSTHw5tkO7OF327JcLqtBoq/jtdgWBE7zptKFfhPu91pvKZAERwyeOvZyf/kMlyX7K2pAlca4Zm/bZlaRnJSobY8xqS5qXpTxUqb08ZU4gjPtHtCGEwwqjmVKNcD1G4B1nt54umhSMUtT/HQld0GtrSkiPc1gooYOfCFKua8eKAaSLjevYE/ik8lUdRs409URwZJ60x8AoF0BYaf3P2V/WCTeULcJqXQo63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4071.namprd11.prod.outlook.com (2603:10b6:a03:18c::28)
 by CY5PR11MB6511.namprd11.prod.outlook.com (2603:10b6:930:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:58:08 +0000
Received: from BY5PR11MB4071.namprd11.prod.outlook.com
 ([fe80::9661:77fe:ef12:6189]) by BY5PR11MB4071.namprd11.prod.outlook.com
 ([fe80::9661:77fe:ef12:6189%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 05:58:08 +0000
Message-ID: <fdc7e70b-67a6-4e5d-a622-450cf4270690@intel.com>
Date:   Wed, 6 Dec 2023 13:58:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] misc: mei: Add support for IVSC device
Content-Language: en-US
To:     Wentong Wu <wentong.wu@intel.com>, <gregkh@linuxfoundation.org>,
        <tomas.winkler@intel.com>, <hdegoede@redhat.com>, <krzk@kernel.org>
CC:     <andriy.shevchenko@linux.intel.com>,
        <sakari.ailus@linux.intel.com>, <alexander.usyskin@intel.com>,
        <zhifeng.wang@intel.com>, <linux-kernel@vger.kernel.org>
References: <1701651344-20723-1-git-send-email-wentong.wu@intel.com>
From:   Hao Yao <hao.yao@intel.com>
In-Reply-To: <1701651344-20723-1-git-send-email-wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To BY5PR11MB4071.namprd11.prod.outlook.com
 (2603:10b6:a03:18c::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4071:EE_|CY5PR11MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da8b213-e48c-4b79-ebbd-08dbf6205239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EEveFiPlgFH9GP6QRNVaqhkZLlymyKJVm2KxlMvzKtqxlKIe20m6MSLJHYJPRCrZuWYJuinJWbp0mecuBO40/SPp1hHTPt7k1N46BPFMQG32CYATuoVCkzfrd2crfAyHCRcHoye3n/yqDEkFLhwEvJ4+anuo7HO1WeVdeBgyMzCJbjUKxf/aMizbO2VdZWrellc0SB+QawNlz6ujWJ9hzPiouHNQmYBC45dKK58hARdmphClB7O6PsOZQfMWEs3lAhlQ8fSgm/d9BSt2I1f630a/Jua3gR4Nvm0cIJ5057MAlU+LZIvUBnrMEBiyoaXp5q6OcSg1+7IdPBHiQl0Az/GmxXmo2lQ0A5FoqAU7VnBN0GhECpl4qwcBiRh2H3HCKjn1PnQ6PoniZZfyJhNiFxQ7bKOsIycktdnLWVjH6wqYtrxDJFNva6x4zL5o9l98D6OkyAZhnIGHrP1Rwl5jATPYgrpCLCqb5le6L/dhCU0xLpErQI1RLy7KQ2QkfcM+sxZqxH2m4V3rrAN6Xmc+bPkOS2YZ1MJxldCgOowIPAQ+fA6AFzvKNhPPt5UUf7JRa4pgZAwwwpV1Y2TR04ola3l/GB2uNdCOb1shDcjNJPU4KwGuncBLSjnd/NbB7pWnBzRZZA/FVdKn9So9+FmtCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(36756003)(41300700001)(5660300002)(2906002)(31696002)(44832011)(86362001)(82960400001)(83380400001)(6506007)(478600001)(53546011)(6666004)(6486002)(26005)(2616005)(6512007)(38100700002)(8676002)(8936002)(316002)(31686004)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejZYb3pPK0gzM3ozcUFrVExRSW9CVCtucTlVQmVQbEpHYnM5WjhCa29GdEhT?=
 =?utf-8?B?SmFSa3VKc0lMNjNMQ1JJTlpMWVJ3UFRheTNvVGdEMHR3cGk2eTVCMGxhb2NE?=
 =?utf-8?B?UVhqZVMzdWUxWlhDN1J2L0tmaUlUYjZRcCtqY0xWOVkwZ1dIZmV1c3pXcUNB?=
 =?utf-8?B?c2VTSXg2NXdlWXdFaTlVYWpGdjJWTGJsc2VZQUhYb2x6WFdZVzdlYVRrSE1S?=
 =?utf-8?B?MGUyakFlK0VuSmNNZlNVWnNrVllKU1ovbU5scXFRMm9wQ3lRSzdpN1JrVENT?=
 =?utf-8?B?K0VHN3NwQUVQcTZ2TVFuZkRvUXlvaVhtT1BhOGZFQUlhdGRzTExvR05jM1Zj?=
 =?utf-8?B?MmdTMk1Ra216MGdlVFpHS3plQ3RJT2IzZEp2RG1zMGhFeHUxUHlMcTdDSUtE?=
 =?utf-8?B?b3JwRzBNdjEzVFpBdEkyNzl6V28xT1Zta1Q5UkkzL0ZRVi9BQ1NvYXp6Zmp5?=
 =?utf-8?B?SWk4dEdVQXo1bGdGS3Y1MnRkbWxkSHYyNndJRlM2YjZjeUozUE9OTmxsUmh0?=
 =?utf-8?B?SkR4S2tJYnlBaCt4MDc5K05TMG5jcGpHejlwQ3NPUlF4MzBsSGlWSmRiZUhG?=
 =?utf-8?B?U3M0R1o1SnNZeFNIanJROVVWdDRtQzBYc3U5M0V0RU45a0d6WWg1V0ltWGg5?=
 =?utf-8?B?OHV0SXBMQjBxN1V1NGx1RFU5WHNvRDdTSzFOM1VDSjVVNzNRNXAwQzNDdWtr?=
 =?utf-8?B?VTdXL3lqZUVnTG5oTnJZZ25jclZZRXU0N3UyeFdWZVB4aHBsWHRSNHVMamRh?=
 =?utf-8?B?KzhkSVR6N3JoWHBUWGZaUlg1cVptR1l3M3RjVUxtWC9GMjlyMjlHZG5JSTZq?=
 =?utf-8?B?bWloS2E5Mzdnd1dOZFBxUFhJR04wNU5iZE50L1hSaVRqWWdpSzJFMXRISXNR?=
 =?utf-8?B?b2hTRy9CM2ptU0Q3R0pKRkRGeUZXOU43bTdwVEhhWUxYV0E0aHFSa1hROFBU?=
 =?utf-8?B?bEZZK1ZwSXcwQW1WcWZKQVM5ZG96T21jWjlWSFJ4WElrbytuNzBEODhibWJO?=
 =?utf-8?B?bjhzbHFBU3lidEJZTkpIQVdGYll4eTN5aDY0bDVEQ3hYckwrME1pbEJOMHNt?=
 =?utf-8?B?d0lqOU00NW9TNHAwbzM3SE5pOVR4UzJ6eTAxcWdWM1pUWUdJc0RxRVk1SkJU?=
 =?utf-8?B?dGhXZ0pNYUVjL0JYWWdYcU5abTRKdCtxc0VrckNuQTB1cnIzTUdTNENkMy9v?=
 =?utf-8?B?cHI1amQ4YjVHK2QzY2ZNUjB3eUhOSjVxb01kL054RXdHbzg1Qng3SjNFVFNX?=
 =?utf-8?B?ZnpIbXR6QnNpc25rZGVUOWx5WUltM1JidUZPVHZxTE80QXBiVVVFcG9OUktw?=
 =?utf-8?B?MGNPdnFnK0xoNCtKakVWRVBBZXBSUjRPb1VBdHVTM3dtOG9qSzVWaC9RMnBW?=
 =?utf-8?B?SlNhNi9hSVJVV2hGRmZEUUI3TVFrVmVQSzVaRFN5QU82UXdjMlVoNVFKU09W?=
 =?utf-8?B?cHVpNXlhTnEzVFlrM0pJdkU1SXFzVGp2SlhRZFQ4ZnJnamtlWi9nenJIUElY?=
 =?utf-8?B?S1M0UVlFa2FHeEtDNFBmcVVSWlRzOUd4Q2QxRmRWdW8yRis1WTU1U3A2ZGxV?=
 =?utf-8?B?SWZ0ekJwQWFzMnJxWWo3OUt2TmlpN0JLK21DTlIycVFlQ3lhZUxhQlY4N3Mw?=
 =?utf-8?B?Y1JHSmVaUVpySVAxS09vSUY2OFMvYzNwN1YwSHpkcUJIWXY4OUUrUGpNVUdS?=
 =?utf-8?B?RERnTFlqOEZPMXcvalQ2SjZiRFg4WFJrb0NadzhOMmovK0M4V3VreXRFcG1r?=
 =?utf-8?B?cWtpRUdheGdJNUhPenZWTU4xdm9ScXN3cXNlbnQ0WVVNdzlrTjhFRng4b3Zk?=
 =?utf-8?B?dDdoVzZjLzh3VllWeGR3VjdtWm9JUE5vNDhiODdpRHRFQU1DR0NWUGMxbjND?=
 =?utf-8?B?aXZYMVVIZ2FCUzM3YUNYMFlqcW1LSDhvTlNwT3ArT0Zrei9kK1pQbjJTd0s1?=
 =?utf-8?B?ZGQ3TlZaVkxvWisrZ2ZnQmNKQmV5TnNKRzFCNDJNSWRqVldDVTRyMFMzRXVJ?=
 =?utf-8?B?dlVnSnVITzhHc2o0bzRzT0V2T1FzY0tXWFFPMVdOQ0tjYmZCdFNxMjN3QWp1?=
 =?utf-8?B?aSthdkJsdE01TXpiYmMrWnF1QnVzRHJJZ1krNzI2TllLNm9xa3hSaUxOVnQ4?=
 =?utf-8?Q?qE5robXtEUdOM1xKDxwbVMVNf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da8b213-e48c-4b79-ebbd-08dbf6205239
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:58:08.5391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK3oPqC/UsI86ljfbJjVXuF2khc1A0n8oo2qGt/FO+n1FdsBJgof9BuT/M2BPlkl2i3bOrjden+rGIFVG2l9pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6511
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wentong,

On mainline v6.6, I cherry-picked IVSC/LCJA related patches and these v2 
patches, added Intel IPU6 driver on Github, then made some changes on 
IPU6 HAL to auto link IVSC device. I tested the build on a Dell Latitude 
7440 which is using HI556 camera sensor and it previews normally.

If it's properly, you can add my "Tested-by:" tag.

Tested-by: Hao Yao <hao.yao@intel.com>

On 2023/12/4 08:55, Wentong Wu wrote:
> The Intel visual sensing controller (IVSC) device is designed to
> control the camera sharing between host IPU for media usage and
> IVSC for context sensing (face detection).
> 
> IVSC is exposed to host as a SPI device and the protocol used
> for communicating with host is MEI. This driver implements the
> transport protocol and MEI hardware interfaces for IVSC device.
> 
> The firmware downloading for IVSC device is implemented as well.
> 
> ---
> v2:
>    - change to `depends on INTEL_MEI_VSC_HW` for INTEL_MEI_VSC Kconfig
>    - remove MODULE_ALIAS and add MODULE_DEVICE_TABLE in platform-vsc.c
> 
> Wentong Wu (2):
>    mei: Add transport driver for IVSC device
>    mei: Add MEI hardware support for IVSC device
> 
>   drivers/misc/mei/Kconfig         |  24 ++
>   drivers/misc/mei/Makefile        |   7 +
>   drivers/misc/mei/platform-vsc.c  | 450 +++++++++++++++++++++
>   drivers/misc/mei/vsc-fw-loader.c | 822 +++++++++++++++++++++++++++++++++++++++
>   drivers/misc/mei/vsc-tp.c        | 555 ++++++++++++++++++++++++++
>   drivers/misc/mei/vsc-tp.h        |  50 +++
>   6 files changed, 1908 insertions(+)
>   create mode 100644 drivers/misc/mei/platform-vsc.c
>   create mode 100644 drivers/misc/mei/vsc-fw-loader.c
>   create mode 100644 drivers/misc/mei/vsc-tp.c
>   create mode 100644 drivers/misc/mei/vsc-tp.h
> 
