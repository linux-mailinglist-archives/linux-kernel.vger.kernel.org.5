Return-Path: <linux-kernel+bounces-132236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BE8991E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0051F22924
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4881713BC17;
	Thu,  4 Apr 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYH0N46c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B12548FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272194; cv=fail; b=gidbl/Rbc3Hz4yzRKYRDO09BkERhgAWxwB6lP2VCMM7KOMaPZLLVxbW0MUKfpeYTLWIT6vscz3GlP1K0rzKQmBIMVvIC2bTIaNG/zHcOADacbVIwhISjanYwcn8grkGytlMPZysGNCPaLoEIA8XF9OvJktKKHUKsjd4YDWR2vDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272194; c=relaxed/simple;
	bh=mwFux/ofYJeRvK4QjbcqoQsEtHRC0tt4kE8YrnhmIQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j219e63U8VRNCUyc0HkXIWnj5wlaYh7HxRcKQLgtaVycETsAkZcvgndZwO2nn5isNicpJha/sy5xWq3cfY/sC5IU4fr5w2i4DjU8iK4nGZfXWPKzfOBzufqajU+D5dqAEr0AEjCeC1lQSXiTLK9VUCw8kN9X1U2t10GyA4Wbil8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYH0N46c; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712272193; x=1743808193;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mwFux/ofYJeRvK4QjbcqoQsEtHRC0tt4kE8YrnhmIQ0=;
  b=YYH0N46cbUKyHytq1Pxfu7G1hKv9JizjTQihb9GF5cbriwQ/VtKa1AeI
   W8D66P0cbYwi8wXUz66sgL6ztdB16f/zKXIlTteRNvo9GEJoqPA/0pYn+
   HYBv4iZSTidAu1tZU7BqshecIH3VtpAm+SNVmZUZ/OcigF85g//Z7kW/Z
   90MhSFW6lrf2oTD9V4T/UDl+W2zTb9U+kuTAfQ2dlG1ITK5yMTWz2QXvi
   P02GnjZCJh05619mkBB9CF37mB4a1g0HuypedvJIFkx+NlpbrasiEVIL4
   xKUbcry2dmE6Svlfea5d7Q1Sn2/WpM9CbEqgK4YglsZqndI1sbr5JiaCk
   Q==;
X-CSE-ConnectionGUID: SabjiaFcQDygUVCvBa4zCw==
X-CSE-MsgGUID: GCsz/gR8Trm1QGibj/si3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25096540"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25096540"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:09:30 -0700
X-CSE-ConnectionGUID: 24AJWlwPQcaV/xMHqFNnpg==
X-CSE-MsgGUID: FE/JZDW9T7ah0IhqYST55Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19408098"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 16:09:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:09:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 16:09:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 16:09:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 16:09:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jg69MxJW/Mf95kaN8Q5qm63o9lwKGxj0rl2Pz8B6fl4iDxtb5uAnBiw2ZDODZtfpU2nqRR2PZf+SYdpbs80Bl4HXK82QWYJcpwqzrp7maLVMjU4VJ3MuQeH88th2tspAqa+hEN3BHmwOHIlmE5YyxVszoZxhfxkQgVXtJeK3fZsfA33N9aO2i3J0mPhkuuK4nCcsIwz0jkAA/GNtxDX+afEJPS87HaASOlVa5IZ8Spy4Lf188AcgkUbK7NLoSSlTf2r1aEpPL0REOBOWb8AnQWgGz/0n/dv4W0s8yGU31C9g4WghGECIZb+PdlGFozO9autZ2PNmPeqsb8NJgoTztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJgQn7u8/G8vtwoIp0BAg4zKUFo3N0VW7TY2iQ7jlgc=;
 b=Sq8ASe0C2h1WlgvEEreQ+FwkSmtkFfHCnISqIWc/ffkCFsQ7Aj/CDjht8eagO8+Qb5L4Rqd8/3+m7BIg78Xe+Xjzs0bB7Z4RJfxjWOUhJw2txkcmE2yMGEMQPpchUQRSkscaLjX5ZHgosnNbpCo6cEBdYfu7zHNQT83GH+q9oysbwtbmhmQmaPw4dUS5Y2f9TRhRY4Pdt/HcFaFaaEvGvCdYCadIme8ZSKqjzN2MPOaVuk6br4u1Ulotjh4O/mFHplPmri7wikuUlWOqf1bQQoHDfYA3djz/B/b0jrTkt3e46QvGHfwfvqh4RkcUbh8ADS3k7HGdV8uAIfDKvFo+EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5069.namprd11.prod.outlook.com (2603:10b6:a03:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Thu, 4 Apr
 2024 23:09:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Thu, 4 Apr 2024
 23:09:27 +0000
Message-ID: <e2c479b6-43f0-4e2c-9ccd-2e5f322d1974@intel.com>
Date: Thu, 4 Apr 2024 16:09:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] x86/resctrl: Move __resctrl_sched_in() out-of-line
To: Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>
CC: Stephane Eranian <eranian@google.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, "Mel Gorman"
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, Mike
 Rapoport <rppt@kernel.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Rick Edgecombe
	<rick.p.edgecombe@intel.com>, Xin Li <xin3.li@intel.com>, Babu Moger
	<babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, "Maciej
 Wieczor-Retman" <maciej.wieczor-retman@intel.com>, Jens Axboe
	<axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, Oleg Nesterov
	<oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Tycho Andersen
	<tandersen@netflix.com>, Nicholas Piggin <npiggin@gmail.com>, Beau Belgrave
	<beaub@linux.microsoft.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240325172707.73966-1-peternewman@google.com>
 <20240325172707.73966-2-peternewman@google.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240325172707.73966-2-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0110.namprd04.prod.outlook.com
 (2603:10b6:303:83::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5069:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MpVRQ8PLmNa+RqXeRbzxKriw8TN6tK7QmCDWTtBhP7m174QWe/YU5Sc9w8jBECvc5bqRHbOuA8NfOziWGTE5z2UoYKU+BNLfeDLK4AEt7/cwxATkzUQyU/IWasyEx5i2egIz5OA+v9LI1HXmGPsRyt3760/QXDrr+1tWzSD1lgvnFWMHoem03tLe64Nina9qFsWaWhtxM23RxGEZ+yfSEiw204TTuKtWEqTKTLHO9BecSy28eMCgL2Ke9QBbADYFzBk2C4ptraECSB9wAO0SZD2TGSZJ0+z5otW/Y7MMgPcXpLlI9Kb2cOkv0/aH+pUDUjnhc7LzNCK/aX5lgrAsyqM0GUoqfJ59NtQn32fLtuFlA5k45CVdSQ+gE1V94D9DSj92Qiugjf8FdM2p0WBXqivCOzlBV9vZlDfmA8IJKXBCo90C/PFQTT4Fr1h95k+IXWrnnVLhq7wdIfYEU8TkFhKf6WEYKa66DN3FbjpueoZmnypJXi8RefOicIe/AnsRkGgMrP2e1M7Z+CGv/fKavGzspy1zqRYNeIFGtb3etMn0bX8cbJtljiWGJIh+1qckuZTsqeYU/lB30tFKK2DX89EU3FswvNB8VaUiUVPBe3Zo7+CI/QWId+LJmZAO3FBHjcJlT+ycosO/TDzJFQFK5dzOFnqA7A04WgVg0Mw8za8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW5wZ0NXL3pVMFg1WGNMdTRtTFZkR1R5M0hueW9YNUVPNi9DcXMvOTBZYVox?=
 =?utf-8?B?VGlqQnYvSjg0Wm9WYVZsUFZVaDFLK016M3Jsd01DTDJUVkRZdGZZNk5sUkE2?=
 =?utf-8?B?QnZFVFQ1dVh2NVpaNURsQklqSVRXTEJuLytwK05oay9kellmVGUxUkZHTlg3?=
 =?utf-8?B?SjUzRDhSZmVORis3eHZkWXZNS096Rmk0emR2ZXJZSmN1L1AyUUF5Q082OFNO?=
 =?utf-8?B?TVozaGcwM3NnL1NNYW4vTzc5UjJUZzlyRFI0R2hSbWw3ZXBLNmVRaWFnRDF1?=
 =?utf-8?B?TmJYWG5GejF2aHcvR01YNytITEo2SDZWRzJjTjhIZmYrVWsxWTlpUzd3eGQy?=
 =?utf-8?B?NXlUb0YzdHoyZ29wL1NjZ0VpUlVneWM3RnFBRXRPREhqUzJkU3hhQUNqWFpy?=
 =?utf-8?B?UC9LWXZVT1pCYWRzWHJKQWRFSWNkdjFwZmVRbE5EYlJVcjlVM1pVakFhSCt6?=
 =?utf-8?B?Z3BNN2dXZGZ0ZmIyS0FJVDlnQ3hCRlowcTU3SmZQN0t1QjRjeDArYWZWR1R5?=
 =?utf-8?B?NTI3ZmdlM0JiUUdZaEJUS21qcVdJVzVSVk43cTIxVTNQTER4ejJKTlNZZUxD?=
 =?utf-8?B?dWtaRC9qd2ZxdytORzVlRXh4enE2TGNIQnQzUkRkVklUbUpXaVhRQXFaT2JQ?=
 =?utf-8?B?dkMrbjFvZmJMcE5uN2NPTTNYMmJoTkJNVjg3N0JXSVA4THc0ZVVSRUExSWlB?=
 =?utf-8?B?bXFzaGR6RnIvbDBENTVmN2dTYVpJVVo5UEFqcDdUYkk5ckJ5QU1yL1ppRkl4?=
 =?utf-8?B?TnNKaXlSbWErWFB4ZEVJcGpNUVhGSmNYUVQ4VXJKNXFHQzdaQ0lHaXovVlVh?=
 =?utf-8?B?VlArbUJYNUcwa0FmY3d4Y0tzc3RRRXRlcStNY1V5SzhuK2RjazE2eU43YTU0?=
 =?utf-8?B?ZC9TYUVJTDBxQkZ4ZTlZSHJpUzVTdHBsNUlqTE1WUGRsb3VmRzcvRkRhSFQw?=
 =?utf-8?B?bWpFNHd2OGNXK3IzM3p1YStKREZRcVV0TjNXSytTQ1JQdnd5V0xvejBuK2dy?=
 =?utf-8?B?V2UyN2JjT2E3VUl3RXI0MEV5TXFWSGtTcDRYTDdvalMyc1dOL05qN2t0Vmc0?=
 =?utf-8?B?TDhkT1IvTGN2cU83c1RjVFNYTmIvblp0eERIaUlVR2R0My8xWkkwMFRrUHRE?=
 =?utf-8?B?MWp3YmhFS1M4TW1maFhreGxiQXlKKzFXN1g2V1VXQWc2RUNvZFVjVE4rQ2hV?=
 =?utf-8?B?TUhhQkw5dWFxRjBVdk8wTWM1d3BOQ1V1SG4yMWdtYkk1ellTL3lCQngySXdX?=
 =?utf-8?B?MmJTVUE5SVpZdzBNSnQzMkRIeXNoMjB6dXJkMFVxU21HaDJuY0FNdjVmazJn?=
 =?utf-8?B?MTI0ZXZZeVU4ZDcvQ2p0d09SNlpxQjh1T1lOWHpXWTgvZGdZNW5mbm9wU0VH?=
 =?utf-8?B?VDhQd2prMFdWY1lUcjNNak1pZmg3UnlDZUJHZFAvNVdkekpEeldaa3dObFNq?=
 =?utf-8?B?eDJxNXlIWUVYVnlWMjQwWXBTdnVlMFMzSTNCTUpwemZYZk54bUpOcG1qOUlY?=
 =?utf-8?B?bWttUkZ6YzRCOS80b1NzZmlPMmRNUHJVWEIzcVJtUWFRMmFyK0U0MnNqOWlF?=
 =?utf-8?B?VnN2cENkd3hpaHN4U05RUmRCbFN5OUxoL2hRSWFIZ0JkMXBabVErVFZWZkx6?=
 =?utf-8?B?dG5nTGVZMHVOZjJoUWZiV1gzdGszTWp5UFZNTnB3Qkt0TERWWFZZMVhBODg0?=
 =?utf-8?B?L3BGbkpkbCtMUVRZMVc0b1lORE1tK2Z5KzBzMFFwZWdlV2VyNGRUcHJpRWZO?=
 =?utf-8?B?SHduWlcwd0gxcVJPQUk2dW01Ukl5anV3MDlLUnd2WHNjcS9wbk8xMUZoWmJa?=
 =?utf-8?B?U1JMOFl3dWc5WlByMDRCU2NPMFcwMnVKdjFvVUZmYi9wWGNzR2xWOWNQV01G?=
 =?utf-8?B?dHlKbjBCQ3M4blRWclV5QzZVUE4wc0tCZWxWRkxpNkZsL09Rc09XMU9LdFBo?=
 =?utf-8?B?cFlJVFY2a3NkejkxanI0eGV6QXdCdkU0NTNLU2l3YitVTFlyTEhDYWxOMElm?=
 =?utf-8?B?Y2xWV2VlajRCSks0SjhxYndjNy9pb3BPZ1FJYVFTMXpoOXRBakdvdnZKU0Jq?=
 =?utf-8?B?cmg0U1lvWlNNSVJqeUpjZWozWGxuNmIzWTcvKzloN1VzcE1yaUVGSVExOVpv?=
 =?utf-8?B?TEsxQU43UTNPczhIY0JWRW8raGN5Q2VvUm1KNTArWk9vNExWaC9jSVBIdE11?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 29082866-c3b7-4284-075d-08dc54fc465f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:09:27.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08pO1rd3sl/00nAYDG0V/kx2BkgqFGmqh4EGyHjCH0ygZsS5vB0OlAxe5+znrZ0av62Mw0UqAu6t8XCU6Y7uB/5nXoCmbha3HQGNbCKESeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5069
X-OriginatorOrg: intel.com

Hi Peter,

On 3/25/2024 10:27 AM, Peter Newman wrote:
> __resctrl_sched_in() is unable to dereference a struct rdtgroup pointer
> when defined inline because rdtgroup is a private structure defined in
> internal.h.

Being inline has nothing to do with whether it can reference a struct rdtgroup
pointer, no?

> 
> This function is defined inline to avoid impacting context switch
> performance for the majority of users who aren't using resctrl at all.
> These benefits can already be realized without access to internal
> resctrl data structures.
> 
> The logic of performing an out-of-line call to __resctrl_sched_in() only
> when resctrl is mounted is architecture-independent, so the inline
> definition of resctrl_sched_in() can be moved into linux/resctrl.h.
> 
> Signed-off-by: Peter Newman <peternewman@google.com>

..

> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 0917c7f25720..8f92a87d381d 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -38,6 +38,7 @@
>  #include <linux/io.h>
>  #include <linux/kdebug.h>
>  #include <linux/syscalls.h>
> +#include <linux/resctrl.h>
>  
>  #include <asm/ldt.h>
>  #include <asm/processor.h>
> @@ -51,7 +52,6 @@
>  #include <asm/debugreg.h>
>  #include <asm/switch_to.h>
>  #include <asm/vm86.h>
> -#include <asm/resctrl.h>
>  #include <asm/proto.h>
>  
>  #include "process.h"
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 7062b84dd467..d442269bb25b 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -40,6 +40,7 @@
>  #include <linux/ftrace.h>
>  #include <linux/syscalls.h>
>  #include <linux/iommu.h>
> +#include <linux/resctrl.h>
>  
>  #include <asm/processor.h>
>  #include <asm/pkru.h>

With a change like this we should be very careful about what is included when
the kernel is not built with resctrl and in its current form linux/resctrl.h is
not ready for this.

If CONFIG_X86_CPU_RESCTRL is not set linux/resctrl.h should have the bare minimum,
just like asm/resctrl.h has.

> @@ -53,7 +54,6 @@
>  #include <asm/switch_to.h>
>  #include <asm/xen/hypervisor.h>
>  #include <asm/vdso.h>
> -#include <asm/resctrl.h>
>  #include <asm/unistd.h>
>  #include <asm/fsgsbase.h>
>  #include <asm/fred.h>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index a365f67131ec..62d607939a73 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -304,4 +304,25 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_domain *d);
>  extern unsigned int resctrl_rmid_realloc_threshold;
>  extern unsigned int resctrl_rmid_realloc_limit;
>  
> +DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
> +
> +void __resctrl_sched_in(struct task_struct *tsk);
> +
> +/*
> + * resctrl_sched_in() - Assigns the incoming task's control/monitor IDs to the
> + *			current CPU
> + *
> + * To minimize impact to the scheduler hot path, this will stay as no-op unless
> + * running on a system supporting resctrl and the filesystem is mounted.
> + *
> + * Must be called with preemption disabled.
> + */
> +static inline void resctrl_sched_in(struct task_struct *tsk)
> +{
> +#ifdef CONFIG_X86_CPU_RESCTRL
> +	if (static_branch_likely(&rdt_enable_key))
> +		__resctrl_sched_in(tsk);
> +#endif
> +}
> +

include/linux/resctrl.h should rather be divided to accommodate code
as below:

#ifdef CONFIG_X86_CPU_RESCTRL

static inline void resctrl_sched_in(struct task_struct *tsk)
{
	if (static_branch_likely(&rdt_enable_key))
		__resctrl_sched_in(tsk);
}

#else

static inline void resctrl_sched_in(struct task_struct *tsk) {}

#endif

so that core code does not get anything unnecessary when CONFIG_X86_CPU_RESCTRL
is not set.

Reinette


