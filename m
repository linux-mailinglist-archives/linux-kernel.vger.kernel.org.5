Return-Path: <linux-kernel+bounces-134622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741AC89B3C5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978451C20FAA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2CC3D3AC;
	Sun,  7 Apr 2024 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeBRP9gX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7E1E889
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517198; cv=fail; b=f1nLrOmTaPLo9j3A00wpU4WbDuO0tBTUJsdkRPL8pRwYu7AG43CKGR1yauuIpveB0HN802ZXl0RFkeZ/kcBOF0Ae3AaqCMcBmdGgqpPnXBxbfsNw17IuslE1O6+KZYnp2t8JbonvwOQStV+gJL56JEAxhcLSTkUXvUnhN7X89bQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517198; c=relaxed/simple;
	bh=+CN76UaTvzHHeArUu6x1qlxL/JGge9cD3TNXV0RxTPc=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dggUfpBTRXhUq8V1i0VuGAEiX+KAVJX+SywhexRpSbeA79CHUIB/rsmFXniqShn9LhgV2wLF2QXK8yTw6FukVsYsZU+IMZVcTw37OaAffczf380qqL43kSe444ndjNsRBpZjXlhJXyLcQhEp5WsgU8k8YmsSeMOeOwqIIILr8Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeBRP9gX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712517197; x=1744053197;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+CN76UaTvzHHeArUu6x1qlxL/JGge9cD3TNXV0RxTPc=;
  b=IeBRP9gXE5cQYmp3/REalCsOpx5BxHou9W/0e3wJ3cG9upBpWXDRM+sn
   mN3EdZG5xDB8Q7cnbxVLkex4GzjG5KcX3+M7oPLiL9EwQA4GoEepbqJNW
   5yfB4IONO8grwGWuflMxo0wza8CM/Lsurhw/p49HodXkfbyuiT0r9ucO4
   9noEvX461NnFxVpnFWFRLnS5FkJrgCp3+GDKTYiLyKEvqhUCdYm9fGch1
   6QorerEgh+rGSNRezjcjUNSPt2cRffEYLyqHUfvKFv1cm3WOh0PdjpBxJ
   mhWRX/gS8FX99T24jU/w6fuxVq5pfUZFh5tBnbs/HkfnwMD3sR3EWDryC
   A==;
X-CSE-ConnectionGUID: U7VrCYWGRECpbOh95/tZQg==
X-CSE-MsgGUID: kIMhhP/cRO25ub/EIqjV9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8016884"
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="8016884"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 12:13:16 -0700
X-CSE-ConnectionGUID: dKz8rVMAQ5GdGemywEPA/Q==
X-CSE-MsgGUID: +hxk41lQRFShciKBSocNtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,185,1708416000"; 
   d="scan'208";a="19624355"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Apr 2024 12:13:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:13:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 12:13:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 12:13:14 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 12:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX+icidqf5WzN0p747heeksxwnU5vCUGg9e8uuDyheYr6PdTOwUOBFRY9arR3bwJzWn8EEcfwD0SxWCc1RvHvL+rXGs9pLLze/IIMOXXcU3f459lVpC8wj9xPAY9MRk/uB/fmM/daaIyPKm1gT3nG/WC49hhPucPL4QVANqh8Vc+TbxB7WgRQ6A73cFZ57ki3+yWFlpRzlXrF67SvYmzq3C8qQq9PkR49T5VB1Y4/3n6SyZdipg/U1u+u+miTww/HLgI2EZKEw7o1nF6pVuWu33a8/KyWRs+crB/i+JCg5TfoDLVotdSP7Ti5uyuOdmdq9/K/Z8srxFEC7qUIJ3Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cde50UJGxB7tN0rtr4mQ7A80cZ68Qm5otE4kNW8vdgs=;
 b=hrs6GNUaFHn5lIq3nSYRaxZ5DrK5tYd1pCBYa0/qI1MmGSRO5GtVgv5bbyOL7atWw7emgdU6DuWBBKywdAWSWCv8GwC92VxZT+ebtwdAwTGVPYVPhlTcPIVRJV8pY0lAx6DcEwMLtVRj/lwPonw+osDQAKsZNgf2IcrB3cPyFQN3MfDOLdqrodfIG1OASw1Br2MF3HwaFrOSYW9cUDpnbzKIemT+O2zG0komDlcfrI2MXgEtwWTv232sgnTBrpNHPUDxIeegxVPC/9AwRIfgxKxKV3ex8LKorKLQ/wSodlEWwbxawFJelgEseiEji2Lh6oKB2JGdKHh02EcQj4mlBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7569.namprd11.prod.outlook.com (2603:10b6:510:273::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Sun, 7 Apr
 2024 19:13:12 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Sun, 7 Apr 2024
 19:13:12 +0000
Message-ID: <98b3144d-4519-4378-9121-c1538b4c5b68@intel.com>
Date: Sun, 7 Apr 2024 12:13:09 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 0/6] x86/resctrl: Avoid searching tasklist during
 mongrp_reparent
To: Peter Newman <peternewman@google.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, James Morse <james.morse@arm.com>,
	Stephane Eranian <eranian@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, "Valentin
 Schneider" <vschneid@redhat.com>, Uros Bizjak <ubizjak@gmail.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Kirill A. Shutemov"
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
 <4681c9c5-3364-4628-a581-0366d0024211@intel.com>
 <CALPaoCh0SbG1+VbbgcxjubE7Cc2Pb6QqhG3NH6X=WwsNfqNjtA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALPaoCh0SbG1+VbbgcxjubE7Cc2Pb6QqhG3NH6X=WwsNfqNjtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0257.namprd04.prod.outlook.com
 (2603:10b6:303:88::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7569:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5RgLz2wxXqF/pSeOI7ZNddUNpAhCuordYoaSGxoXc8izsVjVtWh6Ma9UD6KXxE8KZp1vdbHQB4GbM61O7sg0FkG/GCb51ssfwkHqz2K9SP9ZIDzIL2YYLZPRPKLF0DnBElBo+LC9tQthZG6Vl48/xqRek6RUoV/hxm++6JV4nrMY0kdhYtPLVmltVPAeeeX5ZsILHMcG6yxqENqbsmjOVBiUvD06nSKa7lzuiElX1t1JYT+OwyNV+iGWjaPIzumES9YjLXxhSztCwfDUZeRXolXQDZ5TvW5iM0C1cd55OS/qrsFLOjyH9BRYI1tY5zKJP5aftOnMpmtD4qSc+WqrJTrRcVAgQHmp416cWNFGuGSEPLol4r5GVVAF/QIwpDjP7hATTidP4q30quJvAX5f33hmmpKh2uBUXSM3AaTrF88BNmAdZklyBF4RgWKe8KtUQ+fwiVYy3U0WkoMNZMZ13rbO9pMi1gJFIA2xEH5uuAPeRGj2yR2u7Q6UqSHwNkpA26EK5ZxVTZ4Djrz7KLE8nTxn496iDWBXJzQLBOQg6paCKm3brQ9Bw08tEXdfxc0GUe3uA32eU5E8Qxgt4VsyE628Ev8Ia0z4Uynga+2B9e157fQTwwM/g5YMEsnmV24PKUxSgC2wrE/SQ4lth0qhfH/sy59fSR3lcgw2g+J1KU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXRNVU1ES1lpYUgwYW1DTnVmMU8vdGRBYUhCRnBMRW1PbW1mNzFwTVNSRmRF?=
 =?utf-8?B?K2MvTTZURkJJMGp0Vm5mc1ZQZjhSSzF1QkVpTDhUMG1CVGxBdGQzZFhRK0Z0?=
 =?utf-8?B?Uk1tVkFqZzF6ditNRStPMjhISDhvZUtOTzdaV1lOcnp1SnRlb2NPSStYaktW?=
 =?utf-8?B?OHFvSnlsZHVQdjRtOFErWG5pa1RPeExOZTZQRDByRUFpUDBCcGFkblc0Y2ZQ?=
 =?utf-8?B?c0dhL1JGUUhqZDR4dVBOenhMaXI1S2dHSzFJNlBzUm52L2lEeWpsREN0TVRL?=
 =?utf-8?B?UTVVZmNDYjdYY0labDFJVFd1YXlRUGZldlhkYTZ0M3hJZmpWZEU4ek5WQW9a?=
 =?utf-8?B?dTdxS2h2eEpjbFh0MGJQa2RkSmpNbFBEeEE2Q1UzWW4yZzVMN3ZJUXI3YVR6?=
 =?utf-8?B?UG1uWmdHeWVIK2tpV213cG1Gbkt6amN5TDFRbGFTVkhua0lQZHVOa01TN3Fi?=
 =?utf-8?B?eVAyNXNWT1p4RU9HeDNkTDNBOVpyTnlibFNheFJqTkpUUm94aHpCbVBwMlJI?=
 =?utf-8?B?cHVlYmdvMkZ1M0pXQUl4b1VTTXovSWx5Tk9tVFQ2SGRkajBQcFU5U2ZLY1NU?=
 =?utf-8?B?OHdKbnNEamNKNnBpOUw5RE9sc2FHemtCMmQ0YWxoUWw3ODE0ZXhJbDZKaUQ4?=
 =?utf-8?B?VHZDbVYydkZSVkMvVUROM2FBbTgxV3RFL3hYcFpTM1h1dGN2U3cvWWxuSnZu?=
 =?utf-8?B?Q3E1NVI0WU4zRzFZNEFTc1grSVdnWnVsU3FlNnN1Zmo0YU9vQ0drN0RKSjlJ?=
 =?utf-8?B?QlNwNWx2SzY3a2tkK0Z5dWRKTWpMT0JCMEtiMGNjNkZ6dGZxZndNd0lyMUwv?=
 =?utf-8?B?WlRvc1lkTGxhMzFNSzhVOGl5b2NGSWVCUUdiKzdYMDN3VUxBRkFPeUIxUWM2?=
 =?utf-8?B?N05QYm1pWjlMd2Q4b2phSjArUWRSSFFOMkU4a2pqeWlRbS9nS0pvWS9Hbnh5?=
 =?utf-8?B?MUQrOWNrK0t4dmJxN05HNjlWOU9oNlQxSDJxTjBDdGxDRW5RUTAyU2xSNDg1?=
 =?utf-8?B?Rk1pNGZBMFF5dE5tbGpWNmQvYXJBcGFKaEFrQU1UbXVFMVlRdy9kcFllNWJL?=
 =?utf-8?B?MWJZblN5UnVvckQ0akdJbUk4cGk4ZFIrOFhnUGlxL2dRU25jek9ZdXF2c2Fn?=
 =?utf-8?B?ZUlLVGk5YTM4R1duQlJHNVplZHBJVWZjZUt0MkM0UnJ2WHpMT04xWUEya2Rl?=
 =?utf-8?B?SjkreHVGTmhQNEpmUnA0QXhUOFlWWVRMWEdmSExwTlRNWFUrd21rUU9hMXlq?=
 =?utf-8?B?cVUxMjZ6bGdOZ1A3bGp3RnhieWZ1dVdZRFlSSlVYL21zL1JKdU1xdGdJRm5t?=
 =?utf-8?B?UThuQU1RcDY5dHRFTVpYNEpIS2F5MlIzZ2dTL05Od1F4ZTlvek9iNysxWmRh?=
 =?utf-8?B?cVFIdGZnNU9wU2p3dWtNelZOK2tBMGZKcUJZVGpDSFhUTlhXbkE3L2xJUGRP?=
 =?utf-8?B?Ry9lYWlWdjJmUStTZE1MRzh4L0c2R1RhNmhzNDJkYWw3VnRkRlY4Z2FRbW0r?=
 =?utf-8?B?N3dvcGxKWXNZdHc1R0FJS2s5WFN4OFRJWHRqU2cvN29CSStyVUhkZll1NTN2?=
 =?utf-8?B?OFp5ekZ6bzVvTDZWTG9RWnIzM2lyMjJpUUhwS1BVRjIyMEthQXV3aEV3K093?=
 =?utf-8?B?MXNOUCtMNS83bDZPeUtIOThLZk5idCt1UlZ6SWUvbDlzamNTd2lLa2M5N1h4?=
 =?utf-8?B?SDd0OEZoK0haZ2pRNDFOMXZheXJBcEhDbWYwNElpU2dPYlBTOVJxTHdDcXFJ?=
 =?utf-8?B?WXovdlZJRThzVmFkck1ROUJmYUpTMGJPNDVBL2N1Q3B0TXFnNFI4T3RVeXlT?=
 =?utf-8?B?Z1FRUmUyNlQzdWN1RGsxOXRhQ3dsU2U0U1NVSzZ0elVhY0ZKRFRwY0JTcFJE?=
 =?utf-8?B?bytIWGEwS1h5ZUZVMVBma3hKY0QrMlpkNUdJaEs1Y2J2bDE4UWVkUmdLZDNO?=
 =?utf-8?B?eXZ6NUUwT0xqTkpFdDg5MjBCaWVicTQ0em1McGxqeWx6TEpJUFhUMElIWFFC?=
 =?utf-8?B?Mi9LRVY4cnFlWlh5S2xpSWZqY1QyQkhNa0UxaEtMd29YUUtkUzJEL2tlRUM3?=
 =?utf-8?B?cVlRTmRGRTB0K1c4dmlHVFFjNHlaUDJteXBtb0dZMEtPdUVZTHlmRFl4ZUpy?=
 =?utf-8?B?OXRJNjB4dnBYRUkzVnh3eHRNeUFkQXhuWVp4S1RIT3dZRmZHT1UxUzVaNkFo?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4eb9ea-d57e-43f7-9d1c-08dc5736c4df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 19:13:12.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zPbtB46t4yTDqsC/fMG1vy+ob6uQ8d9H/NBpWLuEMdySyTPvmmoLubP7oNP8rESnDi4XprOvG1jKvJ17pCqOawAiS5nL7Cy37oQc5z58e8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7569
X-OriginatorOrg: intel.com

Hi Peter,

On 4/5/2024 2:30 PM, Peter Newman wrote:
> Hi Reinette,
> 
> On Thu, Apr 4, 2024 at 4:09 PM Reinette Chatre
> <reinette.chatre@intel.com> wrote:
>> On 3/25/2024 10:27 AM, Peter Newman wrote:
>>> I've been working with users of the recently-added mongroup rename
>>> operation[1] who have observed the impact of back-to-back operations on
>>> latency-sensitive, thread pool-based services. Because changing a
>>> resctrl group's CLOSID (or RMID) requires all task_structs in the system
>>> to be inspected with the tasklist_lock read-locked, a series of move
>>> operations can block out thread creation for long periods of time, as
>>> creating threads needs to write-lock the tasklist_lock.
>>
>> Could you please give some insight into the delays experienced? "long
>> periods of time" mean different things to different people and this
>> series seems to get more ominous as is progresses with the cover letter
>> starting with "long periods of time" and by the time the final patch
>> appears it has become "disastrous".
> 
> There was an incident where 99.999p tail latencies of a service
> increased from 100 milliseconds to over 2 seconds when the container
> manager switched from our legacy downstream CLOSID-reuse technique[1]
> to mongrp_rename().
> 
> A more focused study benchmarked creating 128 threads with
> pthread_create() on a production host found that moving mongroups
> unrelated to any of the benchmark threads increased the completion cpu
> time from 30ms to 183ms. Profiling the contention on the tasklist_lock
> showed that the average contention time on the tasklist_lock was about
> 70ms when mongroup move operations were taking place.
> 
> It's difficult for me to access real production workloads, but I
> estimated a crude figure by measuring the task time of "wc -l
> /sys/fs/resctrl" with perf stat on a relatively idle Intel(R) Xeon(R)
> Platinum 8273CL CPU @ 2.20GHz. As I increased the thread count, it
> converged to a line where every additional 1000 threads added about 1
> millisecond.

Thank you very much for capturing this. Could you please include this in
next posting? This data motivates this work significantly more than
terms that are not measurable.

> Incorporating kernfs_rename() into the solution for changing a group's
> class of service also contributes a lot of overhead (about 90% of a
> mongroup rename seems to be spent here), but the global impact is far
> less than that of the tasklist_lock contention.

Is the kernfs_rename() overhead in an acceptable range?

>>> context switch. Updating a group's ID then only requires the current
>>> task to be switched back in on all CPUs. On server hosts with very large
>>> thread counts, this is much less disruptive than making thread creation
>>> globally unavailable. However, this is less desirable on CPU-isolated,
>>> realtime workloads, so I am interested in suggestions on how to reach a
>>> compromise for the two use cases.
>>
>> As I understand this only impacts moving a monitor group? To me this sounds
>> like a user space triggered event associated with a particular use case that
>> may not be relevant to the workloads that you refer to. I think this could be
>> something that can be documented for users with this type of workloads.
>> (please see patch #6)
> 
> All of the existing rmdir cases seem to have the same problem, but
> they must not be used frequently enough for any concerns to be raised.
> 
> It seems that it's routine for the workload of hosts to be increased
> until memory bandwidth saturation, so applying and unapplying
> allocation restrictions happens rather frequently.

Thank you. 

Reinette

