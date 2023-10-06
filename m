Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132757BB9AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjJFNr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjJFNrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:47:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287310EC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696599992; x=1728135992;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=A7bCwxYX6MeWyBVSx6jZ4bD1I2OACc6MWLGm+zhxLdE=;
  b=jCRYkD28KfdUUuXVKxCN9W3YjbkKkJOEFSV5aC5pOZ1gsvbZ632DcVjR
   5inKchz+u2srN3DlpTGsGo3uACI4N1c35Xa5P8JLxFwCrZPkaZpUN6Fht
   VbhJp5Uuzlgcv/x1Lc5gQpbQCaRWCri+gz06Own0gSYLcPGbrmoIXBZ9Z
   8Hw6/8fj7zi3CBH4wG5emaH7WBFugEbSI73u6MDo7dGYxUiyWp8z0Pe95
   UZ4EooCTiDospWcL0hzOqJupb6c9Fv832HshnyA8gnVgjwL3iRqGGTljq
   THihIbjCW3JjqIQhSTJJPo+nb1Kd8alDLV97wUoVt9yyg7G2G6n2lEJau
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="363107700"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="363107700"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 06:46:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="895888880"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="895888880"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 06:44:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 06:46:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 06:46:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 06:46:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 06:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtL5RomhlGL+9VjaeQd6Q5TD1ltQ/YY1a3hu6afIWkiPV4e4+uqPUc5Rt4Yyry5b7paYLHZX/pVCUjvqJzs+8mjMZ+xeMxH4gA/RcgjlmkYs1yzjYwGPnogVQxfuRQ3YCT/g4D4DRt+SJsOZQNtdGxmL8XdjNCaHXVxB/q3xAtd5VDVFjyZbgoWtoBnREHxnSGidG96KwYf85RiK3lnSaiUTPej0qnDRpTNSf4Ynway05OyG+pYTPGMmddZbiw/V4QLSyKQDs+F7HLL4JrEiKMyzgjrS+y/3KlBDQnwxDLGzCMPrGeKNYAjBVjwhtgaR7PKAFuQcGNnueJ+/z2VFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d/ljYKnKnwsN9RHLLM1Cl4QRARwJZIlQm9KKMfhDc8=;
 b=Io2P1zOhjPdKoHvw/vQaiAiEx7jtteIPju3R6up7Q/780oTTgbvwBagib7C3yU9BGo+2J4813hmEmM4NJ6WBdiFVXq9YBsMzRZlUYFQS3cpzHYIfDEb8GIEvCYX9TQfAHEQt+53YikeI+0h78KEGnMnXBiTjqBOoNL4xGYmqDOjaWB6ThbUD9pONa4uOZ9SCkIYmVuf4orl75tuc46hagZEOaVe7pKMiissalQmAbraizySRooarG33dDlWRAkdBXxbZldsMwIF5agJXG5XI8uNhkdcKnBmbz6bH9KPefNo4FmTkQZ8nKLW6hLZYnF1iffh/OCnxq2YRHQaXiAnFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3094.namprd11.prod.outlook.com (2603:10b6:a03:87::25)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 6 Oct
 2023 13:46:27 +0000
Received: from BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::f6c2:449c:7191:984b]) by BYAPR11MB3094.namprd11.prod.outlook.com
 ([fe80::f6c2:449c:7191:984b%3]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 13:46:27 +0000
Date:   Fri, 6 Oct 2023 18:20:18 +0800
From:   Yi Sun <yi.sun@intel.com>
To:     Nikolay Borisov <nik.borisov@suse.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <peterz@infradead.org>,
        <x86@kernel.org>, <kirill.shutemov@linux.intel.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <kai.huang@intel.com>, <linux-kernel@vger.kernel.org>,
        <heng.su@intel.com>, <yi.sun@linux.intel.com>,
        Dongcheng Yan <dongcheng.yan@intel.com>
Subject: Re: [PATCH v4] x86/tdx: Dump TDX version During the TD Bootup
Message-ID: <ZR/fN5SDW5pFX1yR@ysun46-mobl.ccr.corp.intel.com>
References: <20231006062855.875631-1-yi.sun@intel.com>
 <2b222a2a-f749-46e8-8489-b590dc2061cb@suse.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b222a2a-f749-46e8-8489-b590dc2061cb@suse.com>
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To BYAPR11MB3094.namprd11.prod.outlook.com
 (2603:10b6:a03:87::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3094:EE_|MW6PR11MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e7ed9e8-ba9e-4e90-fb4a-08dbc672a333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3Pm5Azx4JMTsxg+z4BsoGp2yP1kKwDKAF1w12o84s+YpbxVSl4m7NsTEUmGlwYyY2SO6eKoweJEc9oARHZFcB9GVWePW/CtT+TcyPvqwSh3uAZMj9FMzSughlEBKaYrs8nVeFZcvwtT+FxxBK2YBFJt77GpfL9GcGEabFswkg+IKEK3dCUkPuTEQfuWwwZ+SgU8JfLpauEDAMEhjSHDRGlocSOf+YubHjVR9MJbJakDjwQvLg3DI4qJkPwk/BdO2n5hG7lOqTetDAJASOBSEpdnMwIA9cGTQNShGmrllWm6N1sGP02BjINCiacDYcn9y9UM5D7qw9BdFfKsrbY573BIY6BttZLgBKepUdrdYmOcIFGqnwVa0dIZrZbXNgudKSPRysi8FLMEsgnXdZvLNu0lQlfqR76iZdBr3Z9IWZqcuc7fbd9Im60FBQI74lDa2gILE66PteSuFFc4WNRBZdyKHx4JDMLpzHNRsoDBhwsXj/qEn5ZL4Ua+n0lTopLD+wRB4yaT/BU4RWU0aEqmjed8eERMjID0X6eKv7kUbMSMLRlLdwgM/mzK7YMhM2hu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3094.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(53546011)(6512007)(86362001)(38100700002)(82960400001)(83380400001)(26005)(4744005)(7416002)(2906002)(6666004)(6486002)(478600001)(6506007)(4326008)(6916009)(8936002)(8676002)(316002)(66476007)(66946007)(5660300002)(41300700001)(66556008)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJnM0tIWkJTZ1ZGL0duSW9SckV6T2R0MmVLYnZjMlYzOElkK0ZobzYrdVZM?=
 =?utf-8?B?Ymlaak1kTkxpY1BFd05kNndndHlTNHE1WXRzV0thM1BZNVNjT2l2RkNQdWdo?=
 =?utf-8?B?Wnptd2dpU0pobURtSUJ6Sm5VNklRbG8vc3pNVUY0MEtZZXJJUlNqQkdETVd1?=
 =?utf-8?B?Wk9BbmlhNUpycGpzNWFEbDRqcitIaHFrL2YydFB4V1Z5TURsVHFMWnJhdHlw?=
 =?utf-8?B?SmtwMEIrUzFlOTZEeEZRa2tqRm9xNGJDTXZidlBhb3R1NUV0VnYvQmNLZm40?=
 =?utf-8?B?TjA0cW5tNWQ4eUtZQmdRVXcwK0x0R1BONDhKNFIxNk1YY3pDSTBhWTQrWWdy?=
 =?utf-8?B?ZUhQdkpDRzFnWDBsYlhrUW1xVHd1Q2dSQ0hCRDRKM0RENXRaTHVxblMyMHFX?=
 =?utf-8?B?WXR5Y2RqSG43R3BNZnJ5a01SOCtudHQxOGhlMVlYQTI4UW5kYlVHdTNUa2xG?=
 =?utf-8?B?enhXSllKMUp6ZVJ0bDlTY292RXQ2NytQV25mcXVvZ1JiL1ZUT2tQdUg1Slc0?=
 =?utf-8?B?TVQ4NG1FaTZyUkJwV21UaldENkxQTSt6OVdnVXR6OWowaHZuSEZKRzRPYnJ0?=
 =?utf-8?B?WGdDTmE5RGkyekF2S0xrVHpaWGFzeUdnYjFwUVBrYmUxK1VQOXhnc2w1d1Jx?=
 =?utf-8?B?NTlUMEt6RUIweDNVZVNWRmYzYmc5ZUJnMGluZGp3SHVWNTU3bkNwWWVYVUhP?=
 =?utf-8?B?YWg3STBkSTIxK3pUVkRuMm4xbmtNS3hobnlnWk8vWWNTY1lKVE5UODFoaS9P?=
 =?utf-8?B?SjNvcDFZODBUTEc3Z0JMKzJjOHdxVmc3RzRqVUhYUW9RM3FHVFVXTmYzOFhl?=
 =?utf-8?B?QkpGbzFmM2IvQTZIYzYyYmV6QmphUy9PT2o3K1MrSXdaTVYvSnZJbndUZVdI?=
 =?utf-8?B?MTB0N0h2UkZNQlVMd0sxcm1xeHBLaXR0YnZuTlYxN2x0YkZRRlRHd0p2UGZR?=
 =?utf-8?B?TE1CRDJZQ3F6OGdLV1c0ZjJQMG9SQU5jZXY4cEhPNUZGQ2JPZXdsSjlOamxm?=
 =?utf-8?B?SW9PRXM2dVhBUzNOdG40QjFQRUc0cTFNanI4S1gxenZLR2pQY2M1MDl5TkYv?=
 =?utf-8?B?cHFsekQ1S25zcnVhbWtiR2EvRjNFdENNQWZqbkJoZy9NQ21TdzZpYVRrR29s?=
 =?utf-8?B?c2dsMytIUGFMM2xZK2pKZXRiOGRHKzVqNk5rejV5dFdkc0hxZ3BaRlc3L3FJ?=
 =?utf-8?B?SGIxODhqMVdYTTNZdkdjQ1ZXYWs2Tk4wS3cxWXVYNFAzREtrR1pSS0tic3Z6?=
 =?utf-8?B?ZDdHaENXeGh6MzNGTWllQU1YZE1QZlJUR1pScHMvNFZNVDhkdVZQcmxxd1pK?=
 =?utf-8?B?QzJNVU1FWXU1OGRjcnRDWlRJQ3dYSThOS0UrVU4wSm5tWk1pajZGcjB0bjFv?=
 =?utf-8?B?clcvRTZCQytHRkZZZlg1OG1sOUtVRGdSaGY4RnNscmhkQ1IxUGxLcW1Ra0tS?=
 =?utf-8?B?NTRzQTlQOUxiR1BkWnIzb1lMSXYxRjhBVHNDaXBYSkJMNFVjYmg1dGV1QUpI?=
 =?utf-8?B?YTQ5NndrL1RaVmY1WmF6eDBjZHEySm9ncE5PRVJaUGFzbWxwUG5iN0E2ekx4?=
 =?utf-8?B?VUVwb1hxRllJMjlLWGtOTURzNFl3NnhJTjBvTTdmNEJVZktBaDNtZEJGZllI?=
 =?utf-8?B?OWQ0UytXd0s3cjRqKzVaOG4xT0Jyb0hFQlJDNlZicXBUMFoxZUdvVnpVK09U?=
 =?utf-8?B?eCtYa2FROGNmV2xRQkVFSndLSnZsNjRqV1FKRlZkS2NpR1FKLzQ3N1ZEWmc4?=
 =?utf-8?B?Um1wTEdsMjBvWEhYNUtBT25JOXp6QWh3SXpoYVFCeGl0MDhHRTl2RTd1YUVi?=
 =?utf-8?B?RlMvMXZNSk9neHVJY1pOdzB1Ky82Q091ajFDTmJGNnJ2QTFPaDZ3QVhxMFB5?=
 =?utf-8?B?dWpmcW5PQklHSkpaRHpDRXY3dWJIUExGaDl2WldXdzltSGFRNDNIRFJQUk5q?=
 =?utf-8?B?NThYekxXS1JHNWZuRW9FZmM2Z2k0U0pXNHN6L0V2UFVZOTlYQ0R3L1hxWFNV?=
 =?utf-8?B?MGxOR1NxLzQ5THhyMW9TakxDbGZxR0U1SFRLS1JFOWFDMy9pVVNkT1JyRElF?=
 =?utf-8?B?Y21nUVUvVzJma29VWWtWUUFWQkRMR2RaaXRjZ1JmR2JrYnE1RFhWdTBSRGJ0?=
 =?utf-8?Q?sz7Tn+CE/MzF8b9Xow73sz4xZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7ed9e8-ba9e-4e90-fb4a-08dbc672a333
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3094.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 13:46:27.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deNK722hkl3IOt9VSaEltDmtfREYkwV2bGvp+HgBpfIllT5Umx+eGAvVA9OEeOL/mMeGes8GfZt5ttoA/8vPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2023 11:11, Nikolay Borisov wrote:
>
>
>On 6.10.23 г. 9:28 ч., Yi Sun wrote:
>>+static void tdg_get_sysinfo(struct tdg_sys_info *td_sys)
>>+{
>>+	u64 ret;
>>+	struct tdx_module_args args = {
>>+		.rdx = TDX_SYS_VENDOR_ID_FID,
>>+	};
>>+
>>+	if (!td_sys)
>>+		return;
>>+
>>+	memset(td_sys, 0, sizeof(struct tdg_sys_info));
>
>So in case of an error this function would effectively zero out 
>tdg_sys_info and not explicitly mention that something went wrong. 
>Dunno how sensible or likely it is to get an error while requesting 
>the ID_FID ? Also why don't you check for errors on subsequent calls 
>to TDG.SYS.RD ?
>
I'll add some error info before each error return to know what going
on when some error occurs.

Actually, I removed the error check for subsequent calls to TDG.SYS.RD
in this version, since it's probably not necessary when the first call
is successful. I can add them back with warning dumping when errors occurs.

Thanks
    --Sun, Yi
