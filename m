Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCD97DFAB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345059AbjKBTI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbjKBTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A472188;
        Thu,  2 Nov 2023 12:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698952101; x=1730488101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nq6MZBZ/bW0ImT+YCGvUB5thJ0+VikDIuP5fVGJBNEA=;
  b=AhIw8feZ57BW1c4UoxR7Ly2JhPfq68c0BQZLAM4ZPd3AIRV5KhyIfNJk
   jgXuSYHbXHVurEjx7ODxH5xMEKubOx6aGA6e76LkMH5VA78QGE81Aq20d
   sHy+cO81OXvBUoE6r3+k+SSswR2xKUF5Bkn4friAuGlL0M2kNMiJ+pELG
   y0RQlynfaY9Yh/8FsETv7416L89shphb/Gh38UPk1z6ww3jsvdvpbW0gp
   NnhzVdTpplo1J30bAjBmr4ZvAFdYzaKbwz8G+7Llmbn9XeVGPV7Q+Pjal
   fVL8L00M7gJmCXgdeuzsSzUXu3l5OBfESyY75vtm4KpTdJ/gNLn+S8AAa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="10324895"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="10324895"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:08:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="754892851"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="754892851"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 12:08:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 12:08:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 12:08:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 12:08:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dy0xFJM63qKorn3fu278qc7AuzH72VqSizpHQhk80HCj9Q62KssJtoJ+XYT/QQouX768DUKQsi+eJ81DavR8gv8DV4yMLJlNo5RPScpuZ6oIymyC4xxBopQqUP0t6OmAJm8XC73ApE98nJLoxlnSCAgVZIsC7aP9bqpamLKFkyDb4vNQ8zzdtpgHMJogT3mvp/CSMoxGx25xTPG6YdpNNjSDfM6RnuvHJQh7GNITpnC9WOqs/Nv42smU41sWf2Qa0RUmP3sUt6yxwC4OVx2GwrD8PkqFwirybeWbw26k5IJlBclrEY1080FJHZcRdfiErS2cadWSGy4ykTa/9NwyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvVUq0kS1zSoegFaPRwXCTwOq+4OI92hV7Y8fZGPokc=;
 b=SJPCgodxV4zKgugO5eU1l/KQ8kvYDavJrnDtLOMHoq5HpX9eKLyZ5FRVk4wrAApzUN0lWciNiI58lOQQcWl4/ZfGzBByaP6GTF0jBIu1avsLydrETujsg82fHsXDEHwpJbFfo5oi1iN1O7mS0hw+c8wryafvab5T3b+McGQVCYAlPs4B6S1T/iDwyUgNaxtER1Pwg5ARQzG3dhxTdw3TKP9yRC1VAVrI9UG4EixfV4dvShkthQZ+MAloMSG/h3fUQAT7w1VIR9RrxaUIR8aGyHpbm+lHJYmWXEmvOxusPDfoGEaJ8wzeVoRSjzRN7SflmEwd1zqLL7dbmCmPd7uvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM4PR11MB7351.namprd11.prod.outlook.com (2603:10b6:8:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 19:08:15 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::43a1:419e:8835:cd4d]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::43a1:419e:8835:cd4d%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 19:08:15 +0000
Message-ID: <0c87ab95-1727-4a02-92a3-3e0a14f5b715@intel.com>
Date:   Thu, 2 Nov 2023 12:08:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] platform/x86: wmi: Add wmidev_block_set()
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, <maurice.ma@intel.com>,
        <hdegoede@redhat.com>, <markgross@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>
CC:     <Dell.Client.Kernel@dell.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231102042959.11816-1-W_Armin@gmx.de>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <20231102042959.11816-1-W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM4PR11MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea64be1-c217-4292-8c49-08dbdbd71115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOREzfs5XWl1s8wEimy3dxrVB/V98rlcAVZQdlCwby3C/cfwD8hyRrP4k6GPAqbmVINo3uzTbrEAlJf6aHIOuPjVBg8Fm90gi6Qr9koFKT/li8k++csfP+W9cmEZCwA2d7xwTqsMOdyGUPT7WjuY8o9dfbHMot1taplefmyd8i9nYkb735uoq2PdQaL1yhqu3bKKADMoTvd/HeHmdns6xfWsPtmKm7O3LQeD2NqVicQqiAmsUcy8P3OheGP2MAWbhyaTzba4xwMKaA781UNoJCwbQaJDD+GbxornC7gkGV24YV99nAMFYP2E2/YLVuVL5bGMVIC7Qu0ZdKJ7jCk9y6lhD5ouXMAN8PC565wf6OGipMUvqxJAayqyRiavw6V5BHUReuY3IcIf33ApXeT9K+EMugdfkRgwA5ExxrXgP5rR1NRb/uQVSQkuoaO8sGriEQIQ7hXk9thzV3/cBt2swtVoQMdAWTQP/iR4WlzhxICNOV1FiXzorIg9mDXc+sDagWXjaBZLWhwsDzuOSixqVy+/RSjP5r/Tj+3PpU8jhj40V3OTxyqmaxbQGIClPq3H1Smat1mULHoWi9eCKOM4IuPA1b0zdtUCJCKhlYbk7N5X0+YyclFYb2F8RdmgvWe7Q+Z7QJNJj1I6PEKRyoPMfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(36756003)(26005)(6512007)(6506007)(53546011)(478600001)(6486002)(2616005)(31686004)(6666004)(83380400001)(316002)(38100700002)(66946007)(66556008)(66476007)(82960400001)(5660300002)(8676002)(4326008)(2906002)(8936002)(4744005)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXR0WkY5Zk8zaERQbGJSOTlHbW1QQVgybFFqYlZvQ2RoOG9PZGpuME1ucjFn?=
 =?utf-8?B?ZXI0OU1UcktzZVI3T3JDRVVjUUJKSHJVdVpSK3F2ZU81YjBFNmRpUkZIdjhS?=
 =?utf-8?B?czNMMUFSeUVTdHNoenBuN0t5a0xoMXorQ1VoRk1kbWxhbzhLNGVEVFE2alg5?=
 =?utf-8?B?VXBRVWdTT3VETlpxRm8rZ2hFMHhsOGd0K3RrTG9zV3JTeElscWMyaE5mNmk1?=
 =?utf-8?B?ektCNzhJcWpQZDg1K0VBT2ZHeHNTRDBUMFJjRU1jVEkyZC9PcWJMSnFiLzRM?=
 =?utf-8?B?dEFodGJPM2lNUFltN3Zldlord0Jpa0ZiL3FQb3BxR2hXTEpadXZpZ1V2VXQx?=
 =?utf-8?B?dFN5aDF0UUd2NWtNcnhyRlVZN21rTDFNb004M0hqRnJBUCtubkx0RVpSRFd0?=
 =?utf-8?B?RXJOekQrUGt4clA5c2UvRXRwTXNOWXRPeXA5ZUlHU2JFOUZ4c2JHMmpObE1j?=
 =?utf-8?B?Q0FNNHd0SG90UkY4UmhWTUtpOUEzNytFWm5SVllXTHVZZWxGdUhQcy9xTGEv?=
 =?utf-8?B?TE9xNVVxeUR1amswWGtKVFhJTk5FYjdLZ2ZJYzRGRGZqVkVGV05PWlo3WVN6?=
 =?utf-8?B?d2FGcGpYUHQ2K2VnNWVtQzhKRUVndk1UWEU3dFoxYThxUDk4eE1hT0w5dzFO?=
 =?utf-8?B?MVR0N2RQaTh0ajVvUVJYekdMNFVaN1MvYmV0cXBZVnhBQk51MG1FTjltMWxU?=
 =?utf-8?B?Y09kN0Z4czlEUjhRWXNXN29xV1hzTEtLRThQVG1OUUNONDRNNVFqK09WUmdL?=
 =?utf-8?B?Q1pqVzBRMitNcDVqWUI2cE8xU29MZDRPU3BwM0hiWDM5dk56SjBBSEdwL3lp?=
 =?utf-8?B?OHExM1dHT3dZaWgxTHJ5USt0UC9KalY0YVNoSFM1a3ZWSXVHMGR0LzZOaW13?=
 =?utf-8?B?cmhCSnVNWFEwakxKbDd2OGN4b1FvbytGQlFrVDF1V0lSbm0rSFBuVUNidFZt?=
 =?utf-8?B?dWRNUnV6MzhSK1VabHdjbFZWMGZ5NW5FVnRNTFQ1WUhXRzNmTjk1OUlEYXZx?=
 =?utf-8?B?bGNyNDgxMFhwT1cvRDMwSGNjclpOUm45VGhDRjNOeVNwYlQ3OGg0WVNLTGtK?=
 =?utf-8?B?RW5iNnkxWjBKTDV3NllpYTI4RHhrVUIrQUZXeVBOUGN1ZmNjUTVaQzN3TTM4?=
 =?utf-8?B?TFBpQmVZL1NlSFYxSGNjOE9CVU5jL3ZkMmk1L0tMWERWNk9saTduOUwxeHRE?=
 =?utf-8?B?b1U1KzN5YlVZQkNMdEFGNlBNRUc2ZHFIbmwwVTZMdGI0cFJKMkRJa2VZZjFy?=
 =?utf-8?B?RjBhYS92V05BaTRSbmdrcEFza0N2YkZqekN5d0JNWSt3N1BSaFVKSVFZeEo2?=
 =?utf-8?B?TTRjNllkQTAyN1VxRVpTZXpqeFdYR0FFdHNjd3FMZXhpeVdPUTUyOVpMK1VC?=
 =?utf-8?B?eWc0T2RLdEd0bW80QjdHNmtwbS9MMHpxZStBbWErbXdiaUt6NWI4eUxOVDR2?=
 =?utf-8?B?SEp4VmR0eDFDMmtnL0RLUW1uTHhQUllGdWwyY1VYREtzWTJ0MkpDS2hzc2lo?=
 =?utf-8?B?WkEzemlMeVNsRURHbS9sQ01vdm1Gb1p6QTVRWHNHMjVVN0JrS3lPV3BaWkdj?=
 =?utf-8?B?SVJaWnlQemxRRlBnakJvM0pST0xzRDY5RWJqUjhvWXZEQTdrOGY5WHBEQzA0?=
 =?utf-8?B?VUNSRCtUWXBKNVh6cGRKQkZ1WitZSE9qUVYveGY3dVY0WDI3WUV2RmdKamdm?=
 =?utf-8?B?MnZObURwcFlNUFlJbHVHOFg2WXBucG5KcTRlVXdGYndKNVYvL2tmMUpaYllF?=
 =?utf-8?B?L1c2VzF5T1M5eFV1em85ZlEwUU1OaDcvVGZGZHYwQUtNT3lMMHJNMExGSnF1?=
 =?utf-8?B?ZmxqczhRbHgwc2NrNlBiR1Z4ckRTV3hIdzJGR0t3QXBPdndSSVRZUmpkYzVk?=
 =?utf-8?B?SXVoRHVwemRnZVVSY2RCZzI4L0pCQnZieXAxNDBKR082Q3Y1aUF5ZVg1bkRC?=
 =?utf-8?B?M2NVZzlvY1JDYlhRN2FOL3hnTGhWSERoSTBxbU4zK1h2RHE4a3dCTTVMZDJT?=
 =?utf-8?B?R1hNUTRzcHlzdTc3SjFaa0NFWWw2SVJjcHlxVzlORzF1K3VLV1hLbFhxNDc5?=
 =?utf-8?B?WGdwaHExM1BsZzlFM3NlNUZUeU1KNlZjZ3ozVitvN3hwbjFuRGtvQjRWVkJu?=
 =?utf-8?B?TktVcXRnek9lZkI3M01vaXlhNVRLZkNWQ1VmVElFeTZJUUgyaFplU0FZYjVN?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea64be1-c217-4292-8c49-08dbdbd71115
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 19:08:15.5629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5thk7gq8EmCB3Ex5ml63msuuOPpK3ajf1Lfh+gpSObydmTn0IhYDINbv2IJ6nyo1nuPAUI/z3tIxpLK0Bl95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7351
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 9:29 PM, Armin Wolf wrote:
> Currently, WMI drivers have to use the deprecated GUID-based
> interface when setting data blocks. This prevents those
> drivers from fully moving away from this interface.
> 
> Provide wmidev_block_set() so drivers using wmi_set_block() can
> fully migrate to the modern bus-based interface.
> 
> Tested with a custom SSDT from the Intel Slim Bootloader project.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/wmi.c | 64 ++++++++++++++++++++------------------
>  include/linux/wmi.h        |  2 ++
>  2 files changed, 36 insertions(+), 30 deletions(-)
> 

I noticed that this patch doesn't apply ontop of the latest released tag (v6.6) (the other 3 applies)
Just a minor suggestion  :
Perhaps a note on which tree/base-commit the patch would apply would be helpful for reviewers

(After some digging around I found that the patch does indeed apply ontop of your patches submitted for the merge window)

Jithu
