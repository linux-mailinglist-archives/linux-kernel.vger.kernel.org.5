Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B237E70B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbjKIRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjKIRrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:47:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEEB1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699552060; x=1731088060;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wvRLVXHgkNNToHWj2Iz/6J5kxHmRz7r+ljfCXmOaFdY=;
  b=detwtDnEizE7+8PWEx2o+U3x8qrZXUn+o9pXouJD7ySmhimQrcnEQL1P
   JyHSevWi/QEhcQZliJAyTIeXgRftnfBHg/wrBzhnZ5Pn+3oBBjAi6/UC7
   7XDOp6ijzUJ29lrnIMjk4hfeVf+BnTSd2uHo8rfbR6cwBGJHMDK9fP5Gv
   QpeFUbufFpEdXO9KEZXurkCzC+DlAt4d3MIgUOMJTDUaP7OKt42O9pEYg
   hAoWuBhRtFpszPrtEONiJN39mMcjPc0XNRfL2IE/E8Y9hcDJFkN8XEsH7
   lpvYuos0h+GmqCignGlaNgGhPXUpj7Wz5zKDT3lmdJaN0CXiDMwTBET6S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11584236"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="11584236"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 09:47:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="739909079"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="739909079"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 09:47:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:47:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 09:47:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 09:47:36 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 09:47:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zlo9ruOWtdW4PuTVT7OHfbFs6hsPrKWGo86x1TG/1L1q06pSIysFF2ZfBaFvKuVDPubmgp1/QMqk+QPHN0zTl86BDYqUA0aiguXa1u+n7Yk+99lqOZ5hQ/yfXPapfy17jdhfM+hcc1jhQ7p0aSIxpAOmZxYogbTPKQ+7IEhrZ8s1x19cEUO2a9QpH35LYgZ5Acaax42v7nGLxDZMe6K6qXiT5AJAPXut/GrZwsN7znHvJjKkG5Fl0jAnEyK8gA0IgyG7DisHQPuB/6LUS0RcTbdcvJIHw/gxOvoaLKI4uTLy9fFaejU+TfEVC+zmSXcctAmIJ7zCBLd1SuVCp+daNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lV8DXm+LT4FsfpJohIsWo2USOOnIZHn2qNv4CbwP5xY=;
 b=M5uxYBsaRIJguOvDNocQK2oMsc/RkQctoH6+KO9VhhXGaTG8qoPiLM2U8Rgc9nqwSFoOOUShLu/K7IM1mm+xd79rXkjXzZdqeMBT4B+B5+Y/rULELObpdJdv36y5LKy8DlJWQkpORqoUeQHdn4pnpR2aJ76xqjxECv7v/pD1pqsQPi1yTHBLRn+/Vkq1LEmKFi9+AqC9TLdd1vPYPe2ZvTZMHCJVhOTuFidJmiL/VWG19DI1mJzY4eVliYO8RtsiZuSRGZptASlKrArhXbJtCyajyN5hA+Q6+Sz87Xo4wyOADmO7mTijY/MCsyvROgwY4Kklsdckkqav1aqUKL7bWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7303.namprd11.prod.outlook.com (2603:10b6:8:108::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:47:34 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 17:47:34 +0000
Message-ID: <73bcd9f2-7c2d-4e9e-bcd8-ce3de2f9a5a4@intel.com>
Date:   Thu, 9 Nov 2023 09:47:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/24] x86/resctrl: Allow resctrl_arch_rmid_read() to
 sleep
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
        <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-15-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231025180345.28061-15-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d15a6b4-c918-487a-48b4-08dbe14bf44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmHRSvXAA8B6jJkPi8DXzPaYTt5ckNcxlv1NRzUpDIKXa8eVcQ1vklOhbJhbuEo3ojx8wM3SvVR7VYG+1PYWkn4OKYVdhFBNL4f0sLWfFta71rvLktzdAt4qwshjqQjwNQ+LcPJ/55nHSav9ePDyE+1XGZ4ZzcehJjK6OWrSMPll/0Bwl0dHOOGixqaVZ57tOedNl7XbU9xxgN5m3bzLLNhHUQyqsvPhSTPSaTlPPg7O5WQRn97uFQKw14r+egyJ7Vbn/YLGOMWBu1EDvF4wH3UKzN2PM/MQmZwkIpOcU9r9sl9O3Q4biCW4J2HH3CHgi/3fMXaiN4mN8nzO0PMWWxopyUFxd5NwR76NW874V7Pled37s7BVy6qcWXN4DX5kTeMWiaLfCi6yuOxZHyC7OG2CRvXhUQW5RkEk3o4XwexpaLkM2FcFWvwlDUlu0iUFPD+A4ZeK7zP/9gTxyh6bAS0L0KhjwrtcUMUTCG8kokwuDwxxx1Ncq5fY2SSfDJNgwnkSlJRDV4CKU9louAiUe3iwAWW0xof8X8qSDo0I/Blkb/hDqhwEnEcXZfh1sY4hky5wgtplkKO1zHVQMI7006qmwbBkKoENUQGYln66Te19MBUKRQwiSYx0PVMo20gtQhYaLa6sVEs3x2AHSnroWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(82960400001)(83380400001)(6512007)(53546011)(36756003)(26005)(2616005)(38100700002)(6486002)(478600001)(31686004)(66946007)(8936002)(8676002)(4326008)(31696002)(66556008)(66476007)(54906003)(316002)(86362001)(5660300002)(7416002)(2906002)(44832011)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmV3L1JNVktSNVZ5N1pWclVKNWxKWlBEMkp3bG95N0l4dlJWKzNQMDMvWnoz?=
 =?utf-8?B?TzVTOFVpM0U1am10ZmJ5Z0hNWW1xbVdTcDVQYzcwV05PMmV4MCs3NDczZ0Z2?=
 =?utf-8?B?anJqd2d4RTY1NDNSSTV2SnJxdFFOcjhTNkJEUEt6UGFjZmE2ejVTYzBmblNS?=
 =?utf-8?B?U1FHaWVMVzVmOWpMOXg0UmI4L3M0OHhnYzU1RkV2RzRFZlM3SVhJb1k0b2ZL?=
 =?utf-8?B?WUtwOG82Unh4djBLaGpKQ3d6QXNoMUd3dE0xS0M1a2oybFFyY0ZBekhaSmZI?=
 =?utf-8?B?c1lzeVB1aGtwUSsrNWpML2cvOUs5RDJOOEZRWjZmY2VTQUpJSGI3Wml5MUJI?=
 =?utf-8?B?dnNlYll3dVVxWlF4c2dtcTBTdnBib1pOV1hWSGpGTTNxNVp0OVlzUDhLZ3Ry?=
 =?utf-8?B?bEpmYXZEdldTend4NEtPTDdNMWhNelNnaTJLVlkydzZ4MmdSK1ZzYi9SOHV0?=
 =?utf-8?B?QWE4ZStmUC9vRlN3dXhyRHpOZ1NpSDJTYU9SNk9IOUFWK0tBY1FnWnRYcFFp?=
 =?utf-8?B?akoyYmloMFAzSWg4YWY5ajRKd3JkbDRkTXhzNFBQam1lS0tHdGJQVnQrV1Nn?=
 =?utf-8?B?U1FuMjZORmQ3U1RYcU9SOUZUYTczMmovNC9hellKVVhvTzF4Z2NVV0FLRHFF?=
 =?utf-8?B?OTRlQU9aV3h6dVh0Y1l4SzNTRGFoL2dVQXp5dUFXeC9OZFJITnZFTlQzOUNs?=
 =?utf-8?B?L0tDcExMNit6SWVsNjhhQ3lHVkM3TzZQOXJqc1hyRWFYMFZnSGdmazFoY1hY?=
 =?utf-8?B?WnN4ZWRxNmZmOXRMeFl6Ymk4cEJyTERhallaeFpLQW45bU5ZSFg4cDEwMEpR?=
 =?utf-8?B?bzgreFZjbVUxNVRXY2RLY1FXTzBZVnIyWU1GdGZRaE1POHVSM1EzcWdCMDVD?=
 =?utf-8?B?ZWdhUEVvZ0lwaXp4R3hyZ20xYWFJZ29oeUQxQklWRXZ1N3dWNlNUOTNqMmxa?=
 =?utf-8?B?K3UwZWlQSmZoaEU3dm1BTGF3cSs3TjZuR2tpZmJUeE5ubHFqa3F2K2NIVi9y?=
 =?utf-8?B?Sk5iak9TTzJZVzdtU2cyS2U2Rkl3MFJ1akhTOUIzS0FaR1VxblA0cFN2cFFD?=
 =?utf-8?B?SzhMT1pwNWtZM1FGSWVlWXcvbXUxN2FneVI0STZuUTI1ZGVSeFpVWCtBTGtm?=
 =?utf-8?B?MGNxOWtUbUd2ZktYVWJOWU1qVmUxTjIyRElrWU9xWXBVVG96WTVuUWN0SHA3?=
 =?utf-8?B?eGEwOHF0YkUvNUV1R2lGTzNFN1MrTWZCS1ZoWEU5Mml0RFdRZjlLTjN2OWNK?=
 =?utf-8?B?b3VGYjJJUWt1cGk5TlQzaG1XVktTM3FmZXQ3MExEOGxsMk5uU0xRc1oxUEJk?=
 =?utf-8?B?aERsVkcrOEE0ME1UVm5HVm9JWEVhLzJaVDZwWVVkUmdNVTFRK1NFd0FrYmZV?=
 =?utf-8?B?Y2E0ck9ydUJyUnYvSFpuUng0dHBPT2I4OEc0cXoyVTlGQStpZ092aXVFUjhj?=
 =?utf-8?B?ZnY4amwzNjZYcXQ2ZFNqTE9zMmRmQkJxMndYRFc1NWhPcGdQMWRKUUFMYkxT?=
 =?utf-8?B?dlRtT2wwMVR6amhSd1hCV25hdHVkK0Z2QWtRanFDTlFJUFJpZHRBU1pKeDlo?=
 =?utf-8?B?bCtSQXcxaVc3RmhMM3RlZmZrYjRMQ21XWkNGMFFIMHdMdkVDclZxSUp5T1Ew?=
 =?utf-8?B?UmdXOTlTUmx5dldZZHhjcUdsYitjMUh0cGJkaVVpQWl3dk9kSlErUnBUM1Y2?=
 =?utf-8?B?dkZiNUhUYUxhSndzeFNiZVFOOUxvcmFSRlpSZk5OcS9jajZSUG40VVk5M0ND?=
 =?utf-8?B?anNPdEx5aE0xT0ZOM08zWGozdklkQ3RRbGNkOTNWM29tZk55RDgxRDlZVUlY?=
 =?utf-8?B?WG0wTGI5MTZwalg4QTZSemNLSTJrMHlJYkVmcmpVSlJubSszQzB0Zi9YbjRr?=
 =?utf-8?B?cndTREhpUllUVUpaNmFRbTcvUlJrbGhIK2lpSXhhT1h5aW1vZkw2cDV0L1R0?=
 =?utf-8?B?QVJVdURXMlJpRkhocFJSVVFoQ2FwSGdrdHFJUVZVWjFLQzdEek53TjQ1eFlF?=
 =?utf-8?B?N0JyRXdFOCt2ZjU2bkZZSVFVMWFPVmo1YTNqVWhPUDg3elAvazBuZEcxeFV0?=
 =?utf-8?B?cUFsZCtadEJpOW85SHZSaHNCWUNGalFLNkhmcDllNXBvVFZ3a3RESkhjUUhQ?=
 =?utf-8?B?cmtJSWhMSS9kNVVqd1M4V2pEZVJ5NDB0K3R3RXVPaWxSVSszeWJ2OVlMYU15?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d15a6b4-c918-487a-48b4-08dbe14bf44d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:47:34.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uihhBkfEr2C4oJiqswLbREUWzo1rRj0HI723X1/2xYZb+kTg/IwztUZ3OIF6lyq/2non2xhv0OLyafqql2RHQnSIh548bgsa9KKw3eeWOqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7303
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/25/2023 11:03 AM, James Morse wrote:
> MPAM's cache occupancy counters can take a little while to settle once
> the monitor has been configured. The maximum settling time is described
> to the driver via a firmware table. The value could be large enough
> that it makes sense to sleep. To avoid exposing this to resctrl, it
> should be hidden behind MPAM's resctrl_arch_rmid_read().
> 
> resctrl_arch_rmid_read() may be called via IPI meaning it is unable
> to sleep. In this case resctrl_arch_rmid_read() should return an error
> if it needs to sleep. This will only affect MPAM platforms where
> the cache occupancy counter isn't available immediately, nohz_full is
> in use, and there are no housekeeping CPUs in the necessary domain.
> 
> There are three callers of resctrl_arch_rmid_read():
> __mon_event_count() and __check_limbo() are both called from a
> non-migrateable context. mon_event_read() invokes __mon_event_count()
> using smp_call_on_cpu(), which adds work to the target CPUs workqueue.
> rdtgroup_mutex() is held, meaning this cannot race with the resctrl
> cpuhp callback. __check_limbo() is invoked via schedule_delayed_work_on()
> also adds work to a per-cpu workqueue.
> 
> The remaining call is add_rmid_to_limbo() which is called in response
> to a user-space syscall that frees an RMID. This opportunistically
> reads the LLC occupancy counter on the current domain to see if the
> RMID is over the dirty threshold. This has to disable preemption to
> avoid reading the wrong domain's value. Disabling pre-emption here
> prevents resctrl_arch_rmid_read() from sleeping.
> 
> add_rmid_to_limbo() walks each domain, but only reads the counter
> on one domain. If the system has more than one domain, the RMID will
> always be added to the limbo list. If the RMIDs usage was not over the
> threshold, it will be removed from the list when __check_limbo() runs.
> Make this the default behaviour. Free RMIDs are always added to the
> limbo list for each domain.
> 
> The user visible effect of this is that a clean RMID is not available
> for re-allocation immediately after 'rmdir()' completes, this behaviour
> was never portable as it never happened on a machine with multiple
> domains.
> 
> Removing this path allows resctrl_arch_rmid_read() to sleep if its called
> with interrupts unmasked. Document this is the expected behaviour, and
> add a might_sleep() annotation to catch changes that won't work on arm64.
> 
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> The previous version allowed resctrl_arch_rmid_read() to be called on the
> wrong CPUs, but now that this needs to take nohz_full and housekeeping into
> account, its too complex.
> 
> Changes since v3:
>  * Removed error handling for smp_call_function_any(), this can't race
>    with the cpuhp callbacks as both hold rdtgroup_mutex.
>  * Switched to the alternative of removing the counter read, this simplifies
>    things dramatically.
> 
> Changes since v4:
>  * Messed with capitalisation.
>  * Removed some dead code now that entry->busy will never be zero in
>    add_rmid_to_limbo().
>  * Rephrased the comment above resctrl_arch_rmid_read_context_check().
> 
> Changes since v5:
>  * Really rephrased the comment above resctrl_arch_rmid_read_context_check().
> 
> No changes since v6

If I trusted this I would not have taken the time to review this patch.

> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
