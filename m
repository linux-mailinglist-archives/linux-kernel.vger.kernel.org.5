Return-Path: <linux-kernel+bounces-152114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684498AB950
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 06:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C44B20D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 04:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EB6D52E;
	Sat, 20 Apr 2024 04:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLxi9+UI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A622C883D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585601; cv=fail; b=p8OVn2lUe9oV9JRYR5ti2ptBPTzk+DWSkun0gWY44U/tmD8muKsQhCL29wKzxbIv/Gh8LHvhz8FocM8ECEvYo74jNlvs0v7wI9VHsvuEm19+1WkIODlbquQk1LLpLnttBlDxCzCbV024oOQt3vzrmh0H6ohrS02MnuUM1Kgy+yA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585601; c=relaxed/simple;
	bh=+Yu3n8j+l9tU5gwPrX1CirpFU84AQ4CKratAYstmFYo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DHf3eqCDQ53lH7j9vfvwq7k4P4+GMlKoMhNYavKuSoLQQr9sY+7P+4TKQT605QEAjhpYelu0kMiyu4Z4rAKlRI+q5BwrdtXvi8EUAker/zZ2vC9cK5eX57QhGvZRAM/OvZAYp+H2qNDVGV2/7AWep4usEVdowGvriz6x1OSMBSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLxi9+UI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713585600; x=1745121600;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Yu3n8j+l9tU5gwPrX1CirpFU84AQ4CKratAYstmFYo=;
  b=gLxi9+UIg7eFLY5je1CzEhq9HUv23vWZt+W8eAnw2DNaxD9WX6mD6ZC9
   4P2D8aK4MKF/SJTergNpNs0vTcWn5hM8XpXy/Bb4BVCiB+u32zfkDjAJ8
   9u/OEVgIgkw5WhQhdz2bvivrVKOvc1dvjltTInAlZCcIUjVH5oZa87AEQ
   U/E8XV7+ssBse4iyOdRTUJrzR3lqu+IlGiRGPvIr5KXmupG6nCe9k9UYw
   OkVFQA3qGBYcw8POAnB2kusuAnAXIz2vsw/okQah/u4aRvxrd51tUpOqq
   AWIrb6IsHdPJkdA/GHFl06TUiieafd8DuNC5fChTMpaUCxvBdvCAM+Zw2
   w==;
X-CSE-ConnectionGUID: xP+qgnn9QVGY9CTYWV67Jw==
X-CSE-MsgGUID: r6KZkqpFR7uSpYFKwx+J3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9120326"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9120326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 20:59:59 -0700
X-CSE-ConnectionGUID: 8FVblEYyRQCssHDwo9bkfQ==
X-CSE-MsgGUID: 6/AEzTd+SvuWgvMnLwqimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="28170765"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Apr 2024 20:59:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 20:59:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 19 Apr 2024 20:59:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 20:59:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmgKMR+mMVjCZKoQ4W1Hr8Ospork2WqHxSvEr7yUBeLeUx4BccLiRWeNWoV93rposItdzlkJPhbHgvnq6r2YjGNmbgUO0jrC7Pu94X4EZiB/6nqTQKGqPpwvvw27W3KA9//1UGd/UKV0hYg/1taraoGy3987O2chOckUxRVa+Cd9IBkfXTiT6h/DmfgIvZBY3IxBuVjCO3DcSQRjZIajH6cfJS9p/zpPP2p9ITQsMMpSqnp9sL3RFA+Upy15s/h3vzp46MX4xhCcpEv/hKRPMZX2f2hgpVjJNpxGvV311Z5uf5iF+tOR49F2gX5HtMGA2TXVjbwU45BTVzEq4lkOwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkTog1KT30VxbK72VUbvXFn5YAhFonyAEWjDD8cqz6E=;
 b=mQE1yh7jt67S8FSNQ3ybuM+1bISMCglyAHy6EE7/PCq3RF/o8nK8zkFY3K1wEn/b6xEd1FlMUzh8IoUAHSe6QvxJfiW7FkCnxqfMtOYWJhqS82DyR8n1fChWBjXgart260LUDxRDTy3ElMUDo4Oz3yJhsqjkg/Q/k7Vk1catI8Ogd/C6T4j7NzvoVnqnzHBb3SYXqJ1p0kd/eoq8ugw0+Y9MEiruf/tRyu7OkG/7hBPxdXuFHkklEPmNmhWig07UOEmnQf6PbTk9ntcRVH2RnWtTztqCsMqUVwNjGDrFSnZd6PO/fVfGYmtES9zoMKPiZ68Xn1JPKFmp1Gaz0h4hXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6267.namprd11.prod.outlook.com (2603:10b6:208:3e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.14; Sat, 20 Apr
 2024 03:59:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.010; Sat, 20 Apr 2024
 03:59:54 +0000
Message-ID: <7e44410a-895a-4364-82b5-2fc21c88f892@intel.com>
Date: Fri, 19 Apr 2024 20:59:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
To: Dave Martin <Dave.Martin@arm.com>
CC: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
 <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
 <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>
 <Zh6k9uagoaj9oTl6@e133380.arm.com>
 <a32acb5a-a6e1-4de1-841e-9a1372d624a5@intel.com>
 <ZiE7gritCvxF1XS5@e133380.arm.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZiE7gritCvxF1XS5@e133380.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e0aa3d-c597-4ee6-c83b-08dc60ee5646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUFtbjRCbXFYeWIxUUhZSTJEdnZmTlN4R1BNblVpNmtCR2wrY2VLNnlyTDlw?=
 =?utf-8?B?UUcrckRKaFhVc2FXT0tVUmJHY0VIdjN1aWtYVDdITVF4U2JFWkhXcGU2VzNC?=
 =?utf-8?B?WVhLaDJzazdjbnFIZjZnYnQxU3l2MWNjQ3oraHZVS0VNYUQwdGZxMWV0aHJ2?=
 =?utf-8?B?T1VDRnBFY1dIaW5JeEw3TUcwWXhtM01yN2twaHFpdklBamFGUjVQczBOdy9P?=
 =?utf-8?B?SzJHU1dRRFpjR0N2am9WMStxOVdvdExrWnI3aUZpOC8ySitiQnNic3l1RWgy?=
 =?utf-8?B?clY3TWZLcm5UUzh5Z0FJZDV4OUhleU9sR3ZUYnFwcE9sLzJRalJQYTkydlJG?=
 =?utf-8?B?UjFrZlMrajFwL092Q3BYaWdhMnNnQXU1M1ltcWJyVnZnKzE0YUd3eWJybll4?=
 =?utf-8?B?by9GNkJSV1NPVXAzQ2dZREFBdHdkY2x2SmpBWUdUM3NiVS9zRFRxRFVsTzRJ?=
 =?utf-8?B?dEF4dVBtRGppR1pWM2JBMDRyK2FOTkhLVkpUckF1ZDlxVGxsbGdQR1BZaHE0?=
 =?utf-8?B?YWcvd1p4MTVxdE9lbXNZOHA3d0UwTlhGUHpFYUxUeTJnSHFQWWJHQXVzWmFt?=
 =?utf-8?B?RDFUU3JuOVdneUo4L2c5TkVtUGhrWUw4ek51MGM4WENYTkdWaWFZZURUQ2li?=
 =?utf-8?B?dWlUcnZmTWJRTTIvOUt0bHpDaW1URm1URkFhdEh0by9oam1lcUVaY2xMejFh?=
 =?utf-8?B?aDdxb1gybFRaMUxtUEQrcFRVamRTNGNpZEt2WXBub2p0eUE5SjlGeTFGN1VL?=
 =?utf-8?B?cTZHTG11cGNaZHRPZ0hNNDNxaHZRYjdYZ284MmQrRTdndG9Jb2FSMi9FbDIv?=
 =?utf-8?B?cG9rNlFiTFhJWC9WZGg0RmNUTThCVS9PY09uQ0EwRWY2U1RIek11K3NTSzVq?=
 =?utf-8?B?eUVtZEpqYWdkajZ6UkltdTdlOG9uMCtCWEpMeXo0Q2ZpaDJycExoWGRoWVZ5?=
 =?utf-8?B?VjN0cnoxOS93WkN3NmJSTTVGbGY0MllsRVBwaEw4cTFMdFlySWMvNUNMZjF3?=
 =?utf-8?B?dTdCSVI1dytSZjdWMXJTMk1zbzdpOGs5ZHpoQlNQcUEvUWJvMVdZb0twTkNm?=
 =?utf-8?B?UGNjNzZYRXVsMHVWRE9vVHRwYmJERmNqa2g1Y0xGNll1bU5nUU9Td0EvcGM5?=
 =?utf-8?B?MjkvTFNOM0JpSzdsL0h5YmZtV2E5dlN5eUhIWittZnBLT2tmaUJCamprNFFn?=
 =?utf-8?B?V212TkNJSjM0bXNEYXkzNzhOZzJQd1ZNNVFqbmVXWDFiaTRYa3NzeWJLelRu?=
 =?utf-8?B?UFIrWUNKd3JiVy9ONWRleCs4M1hUdEhhNElNVHByOVpVMlltSmUxaVJGZ28y?=
 =?utf-8?B?eXJaTVlmSGJaOVdBeVl3MTlseElTQWFCd2tEdnBOOGU5ZWpXUnV3M3V2MWZj?=
 =?utf-8?B?dVErSTJ0UUNsN2lCSXg1ajlSblRydlRkc1U0WVVGR1BrMGk1NVFXek9tRHhk?=
 =?utf-8?B?NmdQM3cxalppcHpuR3h4Y1NhS0haTjUrVzQwN1dQNnZxaDZuQk0xS29UeWZG?=
 =?utf-8?B?Z0NsUU8xNDJ0MVZLR1RLamRrdFBicVFpQTJERlVObTl2VTg3VGQxcjlDUkZJ?=
 =?utf-8?B?WUxMYVplTTNFcVVmU2dxNGRydktDNmN6QU90SXcvanJQTkg1cWRJUWJBOW51?=
 =?utf-8?B?aHlvVnREWUlrZWlMKytaZll0NDhMZ1dUTXJWcGdhb0Z4UlpqOFNVZlVNWHl5?=
 =?utf-8?B?ZlNrQ0x6YTF1UlpzWHl4V1JUV202a0RsTHJ4MVhVR3pTbVJHY002UGt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlZa0p5cEFRNnFmSUxJWDB6cUM3L29mbGpLVGxvaDB0Wmt1eEx2ekVMMjRT?=
 =?utf-8?B?UUtlUTR2TmlPR0x4elRaM1VxbUF0dHFMTGNMdmxmYmlqdE5LdVhQV3Y0Sjgw?=
 =?utf-8?B?Z04vQnM1MzVKYnE2Z1N3cFBidExxOTRieWwwWjBYQ0tPYW02ZW1XY0UrVW95?=
 =?utf-8?B?RTFDcmtpbGFGc1p1ajBtVndHZUh1NzB2RmY1dDgrbW5wdXBQbkg0T28xVmVa?=
 =?utf-8?B?N1FTZGVjZzJyTThjYXFmUVQwM1J1akdnN2EvS1NZcGRJSklncGZ0NG9Dc3VB?=
 =?utf-8?B?Y2dwbFo5SHd5b3hvR3JtNjcwR3hGalhvZWpSOFBxOG5kNlA0OUZnUmd3SVkz?=
 =?utf-8?B?eVhIUWtRWUxBV1lOQzJQNmlsN09iM2M2OTdOd0hOV05ZN0pJUXRnNWdpaWpw?=
 =?utf-8?B?NU5ESVY2S0U2MDRwbW11VmpUNGRMc0FObmU1ZTdZeEJoVVd6U3BLYk9DUVV3?=
 =?utf-8?B?Y0FTOU4xYmxpYXYyMkpiUWpXZk4vRTlsOUI4ZFYreEt1cE9mNFNtcUNMRDBs?=
 =?utf-8?B?V0VsVFZxNnMyd0NtUDkvQ0xOOG1Fc09SWXgwUlgrK2NmN2JXNWx2Z1hJbUFM?=
 =?utf-8?B?QStCRmUrTGxqRVRBZkZzSzNBbG9DK0VIL0gwU002M1dtUFVLTmhRS0JldkNq?=
 =?utf-8?B?QUtHcUlxeTQzbDdqaXFDejdIV0w4bnlNUm9GajRJWC8rR3JObUpyYk9VbFpF?=
 =?utf-8?B?SElaWDhvYi9FY3EwNGhSZWhuQWV5M2lCU2RmMlN6SENWYTZ4UFo1dnAzNXBx?=
 =?utf-8?B?ZzZrbVBXNWFsYmF5UzZvMEoxeVc5WHVhcSt2VTNiZjhYeHUxYkdvZkFXbVd1?=
 =?utf-8?B?a2RjMWlHQ1lJaHpYNks1eUk5VHV3OEx6S1JNVnliRVhsUW1OU2h6ZmQ0azk1?=
 =?utf-8?B?dG9ERHYvdVBnaHFsVWphWXJtOHZNeWlOV29uQy9JeG8vOWowYThoc3lGNTBC?=
 =?utf-8?B?dlRINzJ6bkJDV0hTMTRlR1kycGhhci9ndm9hZmVFSk1hY2VhL1ZYU2xZTEIr?=
 =?utf-8?B?ZjFIcTNONVU5Ky9vVG5sN2lUWGdpeXVlNDI0aWpiR3ZuSkF5WkJlQnpIaEFt?=
 =?utf-8?B?LzBBMEdiV3dhUVFmaTNXKzVkeXllLzczZTBabmNIbkRDUzQxenFveXRtdHRB?=
 =?utf-8?B?SFJVMWpXQzJNeS9LV3MyVmdXamN4ekZYSjhvN3IvVHNYd01URFY5d1Fyek4v?=
 =?utf-8?B?QVIzYVFySUdpQjk2eXptTjRiZENZekROK1lOcGdnQ3QvN0hDb0h4SnRlN2tY?=
 =?utf-8?B?OVI5dDg3VWZzRUp3dGk4OWNZakF1RDZXdWdBeFkrTjhVUFhkdHhXTEpPYVhM?=
 =?utf-8?B?akZqR1Y1OU15NC9kc3FCWWJTUkxIK3dmaGhnZHRocDYvTituQ1BiZ3IyRTRk?=
 =?utf-8?B?SXpSNkZYK1VUZlExc215SDZIVW1UL2x0OU1UZUFSYTY3eFB3d3I2bkNKNE1E?=
 =?utf-8?B?cDFYNmtMelFvU1ZWTFIrTmd2Y0VNcUZzUHpPMHlidmhDK2N6WWNTbkhQOU93?=
 =?utf-8?B?TW1KdGFWYVRhemozTHNwSTZNQlFMU2ZXbEIyWi90cE9EdGlVdkxUNW8zS296?=
 =?utf-8?B?M3BHcDdUa3Q1MytsaHNIcnYzb1JaazZxTUxFRXVJaTZ5NWVPWThEYlpxcWdZ?=
 =?utf-8?B?Y0lwNjF5OVdKRHhXNFFBaHhTdDlTVWxGY1hCemxpbFMvSW5nb0ErNHpWY1Nl?=
 =?utf-8?B?Qnh5eEZCbTBkR25RNkpoQ080ZE9ia2l5RE1tSHM3R1F5MDVMZ0J4dmF1T2NR?=
 =?utf-8?B?a05mcVA3b3k3K0phMmJLM0lDR2tsSkdwMFVmSGk2TzJlcXBwdnJJSXNPUGZW?=
 =?utf-8?B?Ny9JM0g5cUhzeEtiU1BhTmc4bXF2bzlOMDlydkdiM3d3SU9yQ043UEh3cXRB?=
 =?utf-8?B?RkF0UXo1b0JoWFZaYVRBc0dVUXRFbmlaZXc4QlJreUhnM2FmVVU1MlRyZ0ZK?=
 =?utf-8?B?R2pXNGdqNGJOelJrS3ViOTl3UnBNMENEZVVnV2hneEZyVldFNmtWaUhZVUpX?=
 =?utf-8?B?TitOb0VKVFpER0I2T3ZySmtjd3grYXBnMkVXV2d5RkRlY2Joc05OWFdHNDF5?=
 =?utf-8?B?VjRGaDJhR2pFNWFxN2VYVXQwNExWOHk2MDBXMTN6MG5FVEhuUTdIR3JvMTEr?=
 =?utf-8?B?WldKNnZ1aUhrYmNWejE0bGlidlpjVE0vWWczNER2QmpkUGRBd1J5WW1JWWI0?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e0aa3d-c597-4ee6-c83b-08dc60ee5646
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2024 03:59:54.7034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0tEQToumJqvPEh0rHZ3MFdIZ9Od/91GLQQqefEjhtokdeyWu6FPfxYpsNYe8ewrRRh0mJM/rpiP4n4/retJviTCUHj2gSMIGnu3Lhhkdms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6267
X-OriginatorOrg: intel.com

Hi Dave,

On 4/18/2024 8:25 AM, Dave Martin wrote:
> On Wed, Apr 17, 2024 at 10:15:57PM -0700, Reinette Chatre wrote:
>> On 4/16/2024 9:19 AM, Dave Martin wrote:
>>> On Mon, Apr 15, 2024 at 11:03:05AM -0700, Reinette Chatre wrote:
>>>> On 4/12/2024 9:17 AM, Dave Martin wrote:
>>>>> On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre
>>>>> wrote:
>>>>>> On 3/21/2024 9:50 AM, James Morse wrote:
>>>>>>> To avoid sticky problems in the mpam glue code, move the
>>>>>>> resctrl enums into a separate header.
>>>>>> 
>>>>>> Could you please elaborate so that "sticky problems in the
>>>>>> mpam glue code" is specific about what problems are
>>>>>> avoided?
>>>>> 
>>>>> Maybe just delete the the sticky clause, and leave:
>>>>> 
>>>>> Move the resctrl enums into a separate header.
>>>>> 
>>>>> ...since the next paragraph explains the rationale?
>>>> 
>>>> In the x86 area changelogs start with a context paragraph to 
>>>> provide reader with foundation to parse the subsequent problem
>>>> and solution statements (that are also expected to be in
>>>> separate paragraphs in that order).
>>> 
>>> Acknowledged; I was hoping to avoid a rewrite, but ...
>>>> 
>>>>>>> This lets the arch code declare prototypes that use these
>>>>>>> enums without creating a loop via asm<->linux resctrl.h
>>>>>>> The same logic applies to the monitor-configuration
>>>>>>> defines, move these too.
>>> 
>>> [...]
>>> 
>>> OK, how about the following:
>>> 
>>> --8<--
>>> 
>>> When resctrl is fully factored into core and per-arch code, each
>>> arch will need to use some resctrl common definitions in order to
>>> define its own specialisations and helpers.  Following
>>> conventional practice,
>> 
>> specializations
> 
> Debatable, but OK, fine.

ah British spelling, apologies.

> 
>>> it would be desirable to put the dependent arch definitions in
>>> an <asm/resctrl.h> header that is included by the common
>>> <linux/resctrl.h> header.  However, this can make it awkward to
>>> avoid a circular dependency between <linux/resctrl.h> and the
>>> arch header.
>>> 
>>> To avoid solving this issue via conditional inclusion tricks that
>>> are likely to be tricky to maintain, move the affected common
>>> types and
>> 
>> To help with motivation please be specific (somebody may interpret
>> above that it may not be tricky to maintain). So just ... "that are
>> difficult to maintain ...".
> 
> Rather than the text encouraging questions about whether there are 
> reasonable alternative approaches, perhaps this can just be, simply:
> 
> "To avoid such dependencies, move the affected types into a new 
> header [...]"
> 
> ?

Sure.

> 
>> 
>>> constants into a new header that does not need to depend on 
>>> <linux/resctrl.h> or on the arch headers.
>>> 
>>> The same logic applies to the monitor-configuration defines,
>>> move these too.
>>> 
>>> -->8--
>>> 
>> 
>> This explains the motivation for this file well, but its contents 
>> is not obvious to me and after reading [1] I am more weary of
>> including code before use. Not all of these definitions are needed 
>> by the end of this series so there needs to be a good motivation
>> for making things global without any visible user.
> 
> That's fair.  I guess we need to review the contents of this header
> and make sure that everything that's here really should be here.
> 
> However, this is not user ABI and there are only 1.5 users of this 
> interface (given that MPAM is not yet merged).  So, the penalty for 
> not getting this quite right and fixing it later seems low.
> 
> If you agree that adding this header is appropriate, are you OK with 
> some post-merge cleanup, or do you think it's essential to sanitise
> this fully up-front?
> 

I think you may have sent this before your response to patch #17 where you
are talking about keeping some definitions x86 specific until their usage is
clear.

I understand this is not user ABI and as I also stated previously I recognize
that these changes are easier now than later when changes need to cross two
subsystems. I do not think the goal should be to have the perfect header file
but I would like to understand why each definition in it needs to be global.

Unfortunately, based on learnings during the four year history of this work,
I do not have confidence that there will be post-merge cleanup. 

Reinette

