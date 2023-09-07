Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5208797421
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbjIGPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbjIGPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C41BC9;
        Thu,  7 Sep 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694100713; x=1725636713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vLvQ4zKn/oRHy7MXq96By2dVXlS0Z+CQliVfRpO+T9I=;
  b=A5BKHq3CgR8QPZp7eQrjIDUj7K0zXjyuKy/BWxD8Q4+0P9kAGSo5Ha+F
   JrrphHRmhiiKs3mE/Yqpf84bjqyKnT0EHWZvRr4GRc4C/t6YdfGZnmWX2
   T4d2ekuPiCiOywYm24hJJSASsMDQD1HG3a/qhyt3AlMpWLeomqWqk717s
   wXSg7tpB7mg0Dq2agmJX/T83Ngzifl/h5kRKTDnlfOILayVbKIpoQs4S9
   oEVWaUECrKxrZRF8MdbwNKhUjUAujCS5VhFXQFD3GnlmQKaNMIb3tZ5e8
   kwmDl1ccyZQ+aLbEjWSlAy+d+cuoP47UGwueE2sOd+65GM1Kp7a+srv+F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463730738"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="463730738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 06:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915734682"
X-IronPort-AV: E=Sophos;i="6.02,235,1688454000"; 
   d="scan'208";a="915734682"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Sep 2023 06:20:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 06:19:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 06:19:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 06:19:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 06:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVFzaN7IfAR/+uvZBgxHZv9+9wJLAOGyRiRRJ1YHIFsvIZn87xuiUqhV1YbmeXPaX5avCYz5YyPt2xdshHS21Q+IoGuY4seJVrq8xk8e2/HSKnc2NmiIqiaNiUb3y+O8Xxkk8ao9olQZ5imk/VNZ/U2ETGFYnau8NzWgjrYVVp6BDLp8XEiIRzH83Lml3YrlPeDD4irshG/v1Jw8TEv3YDMJzGUkuWwE9NLIOeP7A258b9FanwtfGsnUgp1oAk5nbUD0NEwEeisDhz8N4iCIWK9QCrV0x98H051b4vJ2KvByLj5Nirf+T3/3DL+Fo4quoXKYtXLMa9Ze5c8SOrQUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptDks/wodUORvy+EU0/HF65SkRwIz7z+/zZfjgAO3IM=;
 b=nRHmhEhky8qvnvIxj/9URae1HSZcgeJnsFeOUfTViJ+FPkjs8baADfKTxkjLNSHc9MOpwvixSSWdA2HqkSIwqO8z8H+1tzYQgnSsCzpigAedD+sDcfheHsdEULdqfeUjnzGm/gAWx6GNhiEM/iOe3r6/W0KrYVKxRk8SoMu0H8ycEghlonyeW8sRTDCHEYGmbNdpQO+fUoDGabtaJdQm4IiOO5LuEiokdeUYCtB6dP1vph6eHcAbubDOuyoC+WecZHomqRR/SkCuts4e4ihKmTLFWbQhCIGzrwUMr1gcL8gV4gXkQAiPMOfEAuDQ4/qGfwyQdR6mMytz4FYKrOjVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 13:19:56 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 13:19:56 +0000
Message-ID: <24a741a4-b305-c817-e8c3-34b213ad0ee5@intel.com>
Date:   Thu, 7 Sep 2023 15:19:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] acpi/processor: sanitize _PDC buffer bits when running
 as Xen dom0
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>, <stable@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20230906182125.48642-1-jandryuk@gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20230906182125.48642-1-jandryuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: b822507d-9976-4f29-9798-08dbafa520c5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1cp4Dw3gGOsxIF2jf051UpHTGbZSsb3DL4rtocYMNIylXPtcWyfaqipYoybXcJlOD4EBJGVbasFZlsLRPXpGczEneX23nnurQvNA8NpT35WhmPpW7Xo29zrqSK8ARu/dJ6qZyTpR/nORPiGzCkWQHYWlbo2JqRAokKJHWLzro+VvwUcKZtdIEqWZaJNFirutQsUhr7im5R948E7tbnppdv+dGY0CO9fgXCr8r14PzO7aNhwpPfzZtIBOPpcwcr6IJeOriz1BgJBWItmL0x4Y+eGyuQ9Pm8ee+QhiS0vWugBMD7HMLVmS6qVg+0FAtEdOPhP3euwsfYJiKays/sYeAWHmw7xVbHj6ygEa5bhkyD2WPsGlw1ZXZwZQzthzblMiAeUs30wnqUg+oeEx8ZP3F6dF0ee2EceHnSz+YuzLeeub59bA4JBYWcOZ1f8/SShX1K4pPRA6Ix8W4AedRhc2TFv/W08D93KfcbMeo9OHT7MfejvFVuLriEaH8GWB53TBjM9Wmv+mSvMlkjTc4SNhm5zNPr3T9Q5+sXIm+hC2vJArI2pVn3HXWGHCx3lf5zDeqCHv6HS7Sv4S0HgKbawb+MhrI99fbtxfLggV3PqNGIAEzAyx2ytc7/hfYwv63NYX9muu1ul6w/EU7KKoxk2Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(31686004)(66476007)(66946007)(316002)(66556008)(110136005)(54906003)(83380400001)(8676002)(2906002)(41300700001)(4326008)(8936002)(7416002)(5660300002)(6666004)(6486002)(6506007)(53546011)(6512007)(2616005)(26005)(38100700002)(31696002)(36756003)(82960400001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ellqUXZWRU1MbWtUK01PdkdnQTVYSlRpeXQzU3F4a0pXYmpteTdxdjFmZVl5?=
 =?utf-8?B?SmxTR3hCSXUzVEZMRnJETE4raXBERGN5ZkljbHd1N0syam1KNk9Qd2w4QmQv?=
 =?utf-8?B?OHEzcnBlQytYMkhUcEl3YkY0VDFmMVVOZlpmOGhkRFNXbmx3UzN6ZVMzeHk0?=
 =?utf-8?B?OFhJYlMzMUpyNmFicDdWb2RsVUVPU2ZBa08yaGZzTWt2OUo5QkV3aEVrNlZV?=
 =?utf-8?B?Q0o3VmpVNEdQcHBsNzZ1ZzVTSFE3cmJpMlg4Mlo5Yy95dEtueE9BaEJaMTdr?=
 =?utf-8?B?QmtwSXlXWU5hQklzTElqRWZmalAzS3RPa2RaR3d2djNPV2I0N1NMR2JNK0U3?=
 =?utf-8?B?cVNZUmNnendQb0NnWm41QUpCdG5jUFZzZDcrLzNzWkdtLzBKWDJFb0Q2bmMy?=
 =?utf-8?B?amJON0JHQnJQcGtjYUJqaDBnRXpBWHRlOU9iTlJRVXRtSnNWK1pNdkZNNXNW?=
 =?utf-8?B?QSs0NG5aSEpXMjBVMTFQYU9Db3ZkQVFvZk5VaE55cnNyTXloanV1VXMyWVJM?=
 =?utf-8?B?MTdudFYvNzN6L3JLRHRNejVqK2VRK2FUOWhPTXcvT0dUK2x2dThKNDZCdWk2?=
 =?utf-8?B?UnpSS2tETjd0dzFLNWFOeWlEamVGNVo2a1dZbkdlaVRyZDhMcEFEUmdxMitK?=
 =?utf-8?B?VVVkRXpUbUhWK3d6WDlUbWNiQVdMTHBwM1dJcFJLcTk2Q05ZcjU0Q3M0cFR0?=
 =?utf-8?B?UU91VlJIelBqVHVVR3VGc3hObEczZzlPdGJ6UVI4YkxQa2RkWDYvcjdDVkp3?=
 =?utf-8?B?VDl5ZWtMamN4MlpVNDF4eUlaVjdpOXhyVHBDM3JLOHcrRXZXa2dlRXZldW9z?=
 =?utf-8?B?bktraUZHNHVzZWRQWHNUOHd4OWIzQUtzZS9mRUxoSEQyMFF1R2R5K2pKaFp2?=
 =?utf-8?B?SDU1OUhOUzRVOW1rek42YVVkeEVtL3l2OGM0U3d0S0c3TjVaSFEwbEFqdWU5?=
 =?utf-8?B?c3FFVnJmYm1KQmE5UG1halZGQWxYUDNZdzNUVC9ieVRZTHpCNU15eFhXUjhi?=
 =?utf-8?B?OTVGd0llcHhyZFhwcDlQdFI5U3Y4SzM4WHJHcSt1UTF6b25BYXVVc3lTbXlY?=
 =?utf-8?B?TzdPOVBEdG9IdzNUUEFWTFM0VW1vanNiNnE3QnhKWWFWWkV6S3hNckQyMUhU?=
 =?utf-8?B?cHREUitLd1dmb2NqRVBtbmh5NlZ2cDlzcGQ2SHhVNXRjMkhZejNBL2trNkRp?=
 =?utf-8?B?bStocDIzeTB5RndxNGt0N3NWNU5HZldsZTk3U21Hc1IrSGFCT05JOUFoYnFQ?=
 =?utf-8?B?UmtsRDJLT01jbXdRaTRkUVVUNzJCZGw2QlBWZjZISFAwRzFqTWFOMk5BMnFy?=
 =?utf-8?B?dWUrY3NRT3J6L2ZLQi9UbEpaNTFrQnNCb2VTVVQyTFhHeU9iZ21jWGlmdG85?=
 =?utf-8?B?eHRLRGhOeG5SbHRvUnpOZWljbms1VHJUV1Mvbld3dzJReFBCcUNNSERXM01m?=
 =?utf-8?B?Zno1cy9lWk1kTUdUMkFMTG1OTUZhYjhRRXBleWNiN1owckppamxQYzZ6Vkk2?=
 =?utf-8?B?T3BxUFhHcFhuL1E0YnE5M0wyK2N6N3N6YnlzL3c4eldnQndtWDFnazJMTC9Z?=
 =?utf-8?B?TTRjeGVXOFRKMmFQTmVvdExBS2JXdXBkK2dCb1NIWXN4V3oyb3RSblJkQ2xt?=
 =?utf-8?B?ZVR2elAzVzRTdkVvR1c4aDVUNjJ5WlZZTG5GblRNRTd5bjB4SVRmOUpyN2tk?=
 =?utf-8?B?OHROZ2FaaVlEMGRZbkdoV011d2lBQVZYemxjSDRPWStiUlh0ZUROT2FYTVBC?=
 =?utf-8?B?bStoRFUydEdOYitybUV3dWNPeHluWGs1cWhabkk3ZXlvUW52R3hxR2oyQWF0?=
 =?utf-8?B?ZzNOVVVYZktxUklvQnFTOUFiWUtSMkcwdGZaUnk0REIxSVVnYURvc3gyRDZv?=
 =?utf-8?B?M28zanFQWDZMNG5LamNoRTFoTVRuYWRQVElxalpBRmRXVjl3aERFMTlRdnlY?=
 =?utf-8?B?UC9KT3BJRDNtNUJ3eFkwY3NWZUpHT2gvQVlzTnovaFZOYitRaUxpVnY4N0VN?=
 =?utf-8?B?TnpJeU5LUHJtaEVEdU5Wd0IrTE5PaklCZDJOamRjYzFTN25EOUZKUmhNMTZw?=
 =?utf-8?B?WlROL0V0R3lWdCt1TWhJdEwrMWNKbEtYcmZVZGVlVDZUVVByZHQvSGZaNGln?=
 =?utf-8?B?alRpZDQwc21vbnVIcWRMVFp1RDVwUGQ1OUFRTGRjbWp3enF0N0lmR3ZTZ3BR?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b822507d-9976-4f29-9798-08dbafa520c5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 13:19:55.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcUh7XMWXhjjN6uVMZfMo3OkPit/ekLz0TR31Yzg/6RovEg561dCaGKFjywraWE+tPWCFrRk8NBuWyZ6LL+APcHNEbCdmaZQdE/28HZKNsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 9/6/2023 8:21 PM, Jason Andryuk wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
>
> The Processor _PDC buffer bits notify ACPI of the OS capabilities, and
> so ACPI can adjust the return of other Processor methods taking the OS
> capabilities into account.

_PDC method is deprecated for this purpose, since 2018, and is dropped from
spec since 6.5

We made the switch in linux since 6.6:
95272641338a ("ACPI: processor: Use _OSC to convey OSPM processor support information")

>
> When Linux is running as a Xen dom0, it's the hypervisor the entity
> in charge of processor power management, and hence Xen needs to make
> sure the capabilities reported in the _PDC buffer match the
> capabilities of the driver in Xen.

So I guess you would need to sanitize buffer passed to _OSC method instead ?

>
> Introduce a small helper to sanitize the buffer when running as Xen
> dom0.
>
> When Xen supports HWP, this serves as the equivalent of commit
> a21211672c9a ("ACPI / processor: Request native thermal interrupt
> handling via _OSC") to avoid SMM crashes.  Xen will set bit 12 in the
> _PDC bits and the _PDC call will apply it.
>
> [ jandryuk: Mention Xen HWP's need.  Move local variables ]
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> v2:
> Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
> ---
>  arch/x86/include/asm/xen/hypervisor.h |  6 ++++++
>  arch/x86/xen/enlighten.c              | 19 +++++++++++++++++++
>  drivers/acpi/processor_pdc.c          | 22 ++++++++++++++++------
>  3 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 5fc35f889cd1..0f88a7e450d3 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -63,4 +63,10 @@ void __init xen_pvh_init(struct boot_params *boot_params);
>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
>  #endif
>  
> +#ifdef CONFIG_XEN_DOM0
> +void xen_sanitize_pdc(uint32_t *buf);
> +#else
> +static inline void xen_sanitize_pdc(uint32_t *buf) { BUG(); }
> +#endif
> +
>  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index b8db2148c07d..9f7fc11330a3 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -346,3 +346,22 @@ void xen_arch_unregister_cpu(int num)
>  }
>  EXPORT_SYMBOL(xen_arch_unregister_cpu);
>  #endif
> +
> +#ifdef CONFIG_XEN_DOM0
> +void xen_sanitize_pdc(uint32_t *buf)
> +{
> +	struct xen_platform_op op = {
> +		.cmd			= XENPF_set_processor_pminfo,
> +		.interface_version	= XENPF_INTERFACE_VERSION,
> +		.u.set_pminfo.id	= -1,
> +		.u.set_pminfo.type	= XEN_PM_PDC,
> +	};
> +	int ret;
> +
> +	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
> +	ret = HYPERVISOR_platform_op(&op);
> +	if (ret)
> +		pr_info("sanitize of _PDC buffer bits from Xen failed: %d\n",
> +		        ret);
> +}
> +#endif
> diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
> index 18fb04523f93..9393dd4a3158 100644
> --- a/drivers/acpi/processor_pdc.c
> +++ b/drivers/acpi/processor_pdc.c
> @@ -122,6 +122,11 @@ static acpi_status
>  acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
>  {
>  	acpi_status status = AE_OK;
> +	union acpi_object *obj;
> +	u32 *buffer = NULL;
> +
> +	obj = pdc_in->pointer;
> +	buffer = (u32 *)(obj->buffer.pointer);
>  
>  	if (boot_option_idle_override == IDLE_NOMWAIT) {
>  		/*
> @@ -129,14 +134,19 @@ acpi_processor_eval_pdc(acpi_handle handle, struct acpi_object_list *pdc_in)
>  		 * mode will be disabled in the parameter of _PDC object.
>  		 * Of course C1_FFH access mode will also be disabled.
>  		 */
> -		union acpi_object *obj;
> -		u32 *buffer = NULL;
> -
> -		obj = pdc_in->pointer;
> -		buffer = (u32 *)(obj->buffer.pointer);
>  		buffer[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> -
>  	}
> +
> +	if (xen_initial_domain()) {
> +		/*
> +		 * When Linux is running as Xen dom0, the hypervisor is the
> +		 * entity in charge of the processor power management, and so
> +		 * Xen needs to check the OS capabilities reported in the _PDC
> +		 * buffer matches what the hypervisor driver supports.
> +		 */
> +		xen_sanitize_pdc(buffer);
> +	}
> +
>  	status = acpi_evaluate_object(handle, "_PDC", pdc_in, NULL);
>  
>  	if (ACPI_FAILURE(status))

