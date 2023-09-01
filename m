Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6537903A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbjIAWfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350829AbjIAWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:35:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6E41BD4;
        Fri,  1 Sep 2023 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693607721; x=1725143721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YuU9h140OgYwqL9rGdFaQg3z9IXZjV3KLLtGj1EdEh0=;
  b=VIU4e5UNoYBfu8t6ISSf8SA5DhxxI31lniWazdTJiISJhuFGoAQsj7Fp
   6ewpYtISShWnrs2dvp2iAcGwUDG3PWzseMZUgnJnQMKJv/M5qFODFRi81
   x98M8WEw4rRXKWnRKQ97OpFe2VORlg1YkJv8GTpvyxSBaWKlPWhj98bZt
   0Elj3fGiVTIjxPL4Bf/mW5eHPg8cipWApgOaIXHEkZfGd3BMiy5HYG7zW
   g9U0C5kj1jlelBo6NtT4ClpfM/zlrlLm2GlNNB5xmpzL36IforqI2inG4
   JBDnt0kEFxuDE1174esk/yVW2KrwJHhwQk8xRoV9tG9cy2QdwxmO0fZD0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375222887"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="375222887"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 15:35:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="769340114"
X-IronPort-AV: E=Sophos;i="6.02,221,1688454000"; 
   d="scan'208";a="769340114"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2023 15:35:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 1 Sep 2023 15:35:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 1 Sep 2023 15:35:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 1 Sep 2023 15:35:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8sdcWQTfV7vs8g9wbkcAuTKQ1OCGoG9X9tSM/ebWV1xGUqgq08JcQH1XSTt5+DpZtzRL1g8enf6YRrKclm+IyWGZ/MllIkIS1LVK9SX8QM6+1unBVEFIgwOzyxIuVpoKVNNsyHXe/usTYVgAfQ/y2WcN1C4Zb7yTk/H6nUgDS4zEyhGHE+VnRZbRFYYlqvlyHjnyR4jVMYWQwz2woJq60nheRigo2WVaKKtuZgJ0otoHdqL4G77IAUJfqUoFQH6028bGO1kmPR9NEl5OIcKkFDGsLZ/AIjbpXzX33QIGwGXUiNemPDt2gsZQI2doerENRNf+8u0jxMXOoShVkYvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyJGG1xlLnScRy/0sbl1t+t1AbibQuOFPFLwBN00unc=;
 b=Lj3Aws21HKbiKSO6Ieh8LY6vajysB5DM2KQNFV12dzzDcFnyjlIu0yKejX0hOuVHHLb6h2yeQxoPRRsfuEqWpsTTRamzwjio9wEZDNavKhJ+ybEML23b6xCp2VIK2nv3Kpv78J7eS1TApUpfjX7xpToGBdkyBovomQ3vLk5FNBAcOVA+BETBaRbJD6HNVXILzS2Mjg15+2ZydhbYALGJh2+Sh9/QTDC1JiL2+vFoABYesaT/c1U87zFP7teQDltnoCrZAW2txr0Yq4bQtZRf/Xr/AAkBnnRAynTl4cBWQQUsDBfJJ31MRPGCRb3gDHvk4aGsivxzCc91B9tqAqyUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH8PR11MB7967.namprd11.prod.outlook.com (2603:10b6:510:25e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Fri, 1 Sep
 2023 22:35:15 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::7109:4aa5:6a6d:c3d4%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 22:35:15 +0000
Message-ID: <30b2873c-e813-82b2-c9b1-2768ac433b67@intel.com>
Date:   Fri, 1 Sep 2023 15:35:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 7/8] x86/resctrl: Introduce "-o debug" mount option
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-8-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230821233048.434531-8-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH8PR11MB7967:EE_
X-MS-Office365-Filtering-Correlation-Id: 57548309-0cdc-41ae-6e8d-08dbab3bb619
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ha18WtLCHaEUIdZYVTKvOQJcttt+mCpwJa0Z3ZCNEXSSqW/p+zrP5ond+WykjtwhSaa17ZrgvuEUUJCpCNrTBtc/ScXoBOKsY9D9tISCyUjRGw7hialJoEouvqxtSSCE74r8bAqoMVxwUA00gHZQxcH0jpiXjO7ensr7/HOr7sMCmaA96xc6Ic0LGfOOwsEzWA0bbUJxyrq1SbB7+GdkmZh6wW94NEagz52hJ52y/kS2pvckoAbqI3O7eCHUhEGIPbDAntCM+w5NHoQMP2qaBJmY1dkSuCp34d9jCssgzTu0rsXH+/VwI8qncaaY8mBK+C1jdil6h90xSEp9+6B8VBOOLQ/IMK11drgdLAYrmjgRiRLG17GFHgGJyEnaxk5NgzHQrBzNxSQ9/RB0JjIanP50BuZ41oPxM1chSBUASsogFoWUt9R12H2S7/2t6dZnV1hyDAme2prmmK1UDWncVHR8Lksibp7u4dInHo6VBDT46hMDqsL7jzTTksl7r6MiqIStW1BptjcdQ+QxZIcQhWcZsZYCTvMU9kbpCsKFmXeVahTkhSyfM5jf7tdglfTGO+LZ8QKLh5MtiOwmbNkEGqUVlonl6nYv6shSoLE2Rdmj6mR+o9mSigZSWP26bJwFCDouHVwo+Jg0smfLmnhc4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6512007)(38100700002)(41300700001)(316002)(82960400001)(7406005)(4326008)(7416002)(2616005)(2906002)(86362001)(36756003)(558084003)(26005)(5660300002)(44832011)(31696002)(8676002)(8936002)(6666004)(6486002)(66476007)(66946007)(66556008)(6506007)(53546011)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bS9wZW9rN2JGaGNEQVZwbWdjY0FacmJYcUFRci9sb2dIai9nblFCQWkwMlI3?=
 =?utf-8?B?MTFUektjM0s0SlJweHgyZTdqRkY1bW1GeUNxcW1MQ09zelVoRXhJdlRkY0lB?=
 =?utf-8?B?Y1dnN2YwNnZVUVY2WGJpWjNRcExjd2UwTDg0aG9rczYxTUM5LzJORFZ2Wnd6?=
 =?utf-8?B?RlRxREtPSEl4QnlqUXQyVCtseldLdm9HcGtiVXM1ek5uc3Nld2hxc0h2RVYx?=
 =?utf-8?B?aThuNzV1SVpBY0JyVDU4L3FKS25yZVphbVQzVW5wck1Tdnlla0JoTHhJVEVr?=
 =?utf-8?B?Z1NlYkx3UG9yQ2hjLzRqK24vc3hpMVpsQnd3MG5Ic1RTYXo1WlpxUjltU3NJ?=
 =?utf-8?B?WmxkWGRXN1FXcWRxY0JGRVRiRm1ScEhBSzFFYmh1MHB3TGx6MHQzamlMOWtm?=
 =?utf-8?B?MFA0TlJwaXAxZGh4YmVJL2V1MCtoVS80Wm5EYmNUeEpWVHlaRk8yTjhFQlVt?=
 =?utf-8?B?ckJ3K2wwSmZkMzZhdGFyTDNraGdDTWF6VktPSmJsS20yTG9YdUlCUlRMYnpM?=
 =?utf-8?B?QXdBckphaFVOVjkyWitDdHNIT0haTXRiNDBrTTZXNVY5TDl4YVBCbVNwbklV?=
 =?utf-8?B?YnlGMmw3Ylk5SnZYYWsvVExWenN4bHVHNDF3N2lmZWFGZjZWSTF5L05kelhs?=
 =?utf-8?B?M0FPYjAvY0paOTdoQk84WUFQcmkyNERUSFEzejVRRHFEV3ZYOFpyWWVTMDly?=
 =?utf-8?B?WWNjajdPS3cybmFiN3A0VEFBc1ppamtTTTdNcFRuUFlUcC9QUWZsODIySldG?=
 =?utf-8?B?STBGVkNsaFFrT1hkSjJIVUtYS2ZuRlpBbmNRU3VlRGtvWERCN2tBZFFXRk5k?=
 =?utf-8?B?c3c2VCtYWFJCbEVkY1pWaEVTV0JrUkx5QnZyUTRQM2pBQzZpTjhPUzF1Tk1H?=
 =?utf-8?B?UFVTR3dYNVJKNnkyc0I2bVVsVWFzYUxrNkh5N2dNQ1FaMCtwSU1xb2hZaEhN?=
 =?utf-8?B?OHFCcytUWVhJYnR1c2xuMnR2TUZ6TW54dTRuTzFrT2l1b2RCSnlNS0E1VjZy?=
 =?utf-8?B?WmJZNFBNUjlSQU1pNDN2cWRpUVV5a1VaLytZOFg3d1BUWnhUdFpyWTZNL1dC?=
 =?utf-8?B?Z1UzZGxvbEVnK3N0aFZUeDkwV2h1WHdMVDVZVkdueHNOSUxpSmQrdjFucHgv?=
 =?utf-8?B?WGw4M0pjdWlVbE5YdlN0QVRTQjlsR3gzUjd0ajVyNkdBTVRlUWxCWkc4aUsr?=
 =?utf-8?B?R09WTTk2L3hkMWpCWmhNenRlQW8rdGs3STdRNkgrNmpsRDEvTVd5Mzk3bnc2?=
 =?utf-8?B?cU9NK0tjbTlUdlVaanNJQnlTWm80NVdWaWh3NktDOEdKRFNIYXAvQVVQWW95?=
 =?utf-8?B?bWFvd1M5bjRZZFhQMFJ3WVR4UTZ0UEdYZzE2NmU4eGQ1Q25BMktxUFV1LzMv?=
 =?utf-8?B?MW83RlZsdnBHSHV4WjBEYVFWcHpxME5Kenp4YzROMnlSMjk0SEp5ekgybU55?=
 =?utf-8?B?eGh4K3dDSlJ4TkxkbHVtTDh6aUVleDExOHc0MEJUMHhOQXd1SkxQUVR1ZjVM?=
 =?utf-8?B?dlhEOWd0TjZnTEFNZmpqeEFaNjluNkp3R2ZYU0t2cU5zVG40NmNJMEhZMDRo?=
 =?utf-8?B?Y0FqemIxUEFWSjY3MWR4amlCb0FML1Y4emZSRVJyTmNDSCs1dXZBY1A2Tmhl?=
 =?utf-8?B?MWhWVzgxalBQNk51eEswd2lVOGlzVURVbEg3Q3BVc2dRUFpnNlNOL1JrTWZT?=
 =?utf-8?B?a0EzNkVPdEhHTTMyd0xKL0U2UFFjMDhtNENwcnFZYjJkeG1DUFdaMkN4VUNE?=
 =?utf-8?B?N2FjY1M1R1RBNmNLR1FUcEVVZGNVT0RJNDdjTW0yeUhaQTJzVHEzOE50eHFj?=
 =?utf-8?B?clEwQW1rVGF5MFRWUGlQREN1OGFHWENMWHJPRkhURGE5dW9qSms0RkplUzZa?=
 =?utf-8?B?aUc5cEduRE1KZVRQYTRzc214REZiWllPK2I1Y2NGQ0pkUVRUWHBRekJobXdH?=
 =?utf-8?B?enlPeEVvdkpqUUdkTGFOS0VNTjA4cEpnTGdPMklJR0YwRG5xSkwxSmdRVXV0?=
 =?utf-8?B?Y3dDeUQySndaSEx6NDlRWVhxd01OZHIrNG1sV3ZDRjVkcmR1TVdIakdJVkJ4?=
 =?utf-8?B?K1BKbWFtWDJ2S1F0d3RSekVQNjJVQ3IralBId2hwc3hBQnFDY3JiMTJsSWhl?=
 =?utf-8?Q?nncmCR39t+fGabcB55AnDejXG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57548309-0cdc-41ae-6e8d-08dbab3bb619
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 22:35:15.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AndsbP2vSorlWQXE5bkhEpSyRclzOjDjdiPFUrAP8fTClKORZdkjmEhCR9kmE6r1sxzztJTPwLohBk+Bh+4ioQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 16:30, Babu Moger wrote:
> Add "-o debug" option to mount resctrl filesystem in debug mode. This
> option is used for adding extra files to help resctrl debugging.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
