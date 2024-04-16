Return-Path: <linux-kernel+bounces-146816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB428A6B66
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA2A1C211B9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453E12BF15;
	Tue, 16 Apr 2024 12:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JuvlYzxZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8C1292C9;
	Tue, 16 Apr 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271552; cv=fail; b=riGOxild9Z5rodQY54ZF4yVx4HB6hm6H36il1kLXkT4Q9qGXw8G8PHGANNPoKPAt4X57QsQ4hzuXECnMWwC1ccl4RcaeXdn4D7ajgAjMuPByYIDp8Cgzo5de3zd0xZBoFYh9ykF1DOoqIogCqhhgRosQLLphzQGejAC2ZjryejM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271552; c=relaxed/simple;
	bh=d0/RlB9de/Xqv88i7bHaYrBW/oDZw+TIUxrXc9TtFTU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewObJM++CC/1OAxyN2K0wrxqgTZRw8lgxZk8H3VvjHJQxwpGWWV09KhLXx3X+IY45EIfP/tYBc8VfXUDKhIru2Bpmh449m4wDwDNQ6KFRooTKtK4m7fYfH4ngneUolho4ZqFvfbARrXYznZylP2B51C1V4MxeOGTrU9LVFrmtYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JuvlYzxZ; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713271551; x=1744807551;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d0/RlB9de/Xqv88i7bHaYrBW/oDZw+TIUxrXc9TtFTU=;
  b=JuvlYzxZLaL7KR+2Bl0iVl4D6ivraJXOYqNV8rPFsULfyS2KoLysxHqH
   MPXXBjcDMgtLdi7KsGallcHZco5EioQvqOP2WKAZDF2enPXd3hKHQAmvX
   kDQONaUJuCcjLVEsaEswJyPIKXBUhI9LQv247qVJNxSGdFQnYn8hDQiGF
   yYCtfWpV6LvV7GyTrc+FcjsrpwpEmiaPN2HKkdoLGje+3l9bWIYrfhooQ
   h3Em8GDxl+VhBCUdyCPkC9xfwtUDdHemM6dbaxXXsg7p5Elgmw9lmmKo7
   QUID0L+93JxbAF3G1/mirfExWjlwxQLRdFkH6EV6J8lwyFYPGzVxzwmWt
   Q==;
X-CSE-ConnectionGUID: tTClEF09TJ+8zdbf3JaA4w==
X-CSE-MsgGUID: TOEYXCXFRPWOYecyDEHF7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8628096"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8628096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:45:50 -0700
X-CSE-ConnectionGUID: hSLpL0jbTnCX4f5xg36sGg==
X-CSE-MsgGUID: UZF3VsWuSjCgy5pU+vFZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22145573"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 05:45:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 05:45:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 05:45:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 05:45:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 05:45:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0QtsJ5cfRWS7zBibBi6nx8zvP3WVbXpm9bIBLaYFue2SSlNJ3XTnfcwAUdx2m/D/+ib9Vhwkdy4o9bYz/AOR8aELN1/h++KVqQk6tB4gGNierPUsrrp/1vDtmfh/hoL8NQPoaJQwg+gyHJQ7bhfYiYeQqsnuTkvjbNai/ishoof3gqMC3+YB4bE3Hg2T4OuwqPip6vQquVjhEMYVac1cxKGxUJ86coGpIUNAuHE6JQyC0cnzSk4BtPeZPAIG7vTHFAW1tvpKj48rTv+VrMn22tHa/PZTQnX//IQH+QSrNVC2qRBtf1RysakgzgwNwqJlvhfzp3L3/fDHKH0ekIk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXKer6+EVxhP6aMApu8PamUDGhsD/HaGQNn9v7VadSw=;
 b=OgPGuCZpln5ONAwWwIRWibqWptJevLMi+Hbb6hR9TlekzH4nKpLzVerHXDLeRixsylNGhOAT1SAH7RRqZouq/KDw1kkcR4zGFcSuSx1vc3OnjAQdWbKz+2IOtrrkMVbAZDPLQb7qqVu+IUzYWhnDhOsaVE7v06eS+cAQ7wvPdzO6J+j6hHMMAG+3jkGQceRt5Em63DuCzZbxSMQ3Q6Lo01y99p+xo/IE4188ZZed5jZqXPN8kvGPTPT4O8PRhPqAmnFS9JeS7LB7yMtq6tw9rxPO/b8dESROqGyouCpzDo/WVo5/xp4YFvSlNnqt33SYjWyIPccKT3oHRbM/rcxQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 12:45:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 12:45:47 +0000
Message-ID: <5fe95845-9cc6-4873-8748-b125cb310036@intel.com>
Date: Tue, 16 Apr 2024 14:45:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 7/7] netdev_features: convert
 NETIF_F_FCOE_MTU to IFF_FCOE_MTU
To: Jakub Kicinski <kuba@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
	<dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
	<andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-8-aleksander.lobakin@intel.com>
 <20240408193806.18e227c8@kernel.org>
 <1f14cb75-ee6b-4a7d-9041-23a8cfcd8476@intel.com>
 <20240411074709.249b3482@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240411074709.249b3482@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0117.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: e3843d3c-9956-4c33-90af-08dc5e132368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GKiTzxqw9iUeLOuFAMsdYpB4XOKyUp13CcS9cHhSt5OJj4UeBXs/qPL1CmX4nIS3/rj6aS95EkVDiDumajzZypnjV+nbqji8jpPGfdB20ccFnguzTpxTrGtDupINPqc8w8lHrbbeBBZ6d53HqwWMKlWEwhQrKt/DF8epVid2D0geKVAWMy3qvUV+63qo50JEfGBMp6dwdL40SGVGcwYM0L+h87RzAVpiAfy2557gtrSwcICkas4NdoSiQ4A9ujGtJXCUjfrWuy2cF1p0nzQdsF6b0dXuiWYq6OIOgjHO63YGA9gmp43W9vgc+hBpYsSmiZ4FZxMdlQfL0rIckYrTvO0opxFRRXJlTGaoNhwb6D2gCrB3q3U7yaFcE1v55avxrPAwGMbK+MFJt68HKdex3Da60o8CFdh/qPT5bmW3ywP6JPlJ3KjJVomAssnKwNPzzT5oLznVKI0CAYbfgWaa5D7Gjnh3FMP/b1+6cEFwEyXvsTqv8aBXdE62BFEhBOxkabhbToXiYuQEjDIuVpbPKJ+r2PN4Ocqvo19Y4VB5HcR+OQGuJ6bn3eTHBVGdeGEe2oxQRMz7P+anBPvmMaXo9raAN9+spDstaepuOKT0Buh8gykNFYXsnHZS+eqK1P9kXI5ktZ1gFdBulwv/HCAQlkd/lsHme2o83L+gmhZcjc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJDVnFhZ0FiY3EwVUNUMFZ0dGtHcDNTK2ZzVkVjbm1yU0hVa0ZaeERQaWk1?=
 =?utf-8?B?eU9KZ0l5ZkplanhnMXRHQzZPUENsMFlHTzdBV2gxREwyN3pvQm9ZUitjK0NJ?=
 =?utf-8?B?anJtcFB5aTUvempsOVhtV1NWOGZrZXdpcS9sRTdPT3JlcHlzcE9BcGl2d2ZL?=
 =?utf-8?B?SENXeDROV21DUEFYK3JINjJNUmk2U0dyNHp3UFBuZ3N1Q1hORi9BMFduUkNx?=
 =?utf-8?B?WDhjdHpTU24xZGVseFJWbWRGdXM5SVpjcmh6MjRFZ3kxVmhVSVo5M1F3aDZu?=
 =?utf-8?B?RjBBaWhQK0FjVE85VmtmbVhEQk9jdm5Zc3dyV0YyN0FHWTRKVkZrUiswYVMy?=
 =?utf-8?B?QnhrTHhNazBxWFV5SjN1Y091Z0h1YVd5TTdnVVlPWmhvQUI2WWZVanpYRi84?=
 =?utf-8?B?MWxleHkzVDQ5bm1LeXR5V3pFUE1CWTV6Yi84MHdYb0RQbGhkQWVHbUg4WGtY?=
 =?utf-8?B?VnVrcVQwaE1taFhFeHVpakl3K0thdC9jaWcwcEZ3VHJiTUs1VFJ2b0cvLzg3?=
 =?utf-8?B?cUN1L0ZKNjRkNU1TaFgvZ0JJR1lvdHpDZUJ1Qnd0b3FvaFpLeXRaYjVYcVht?=
 =?utf-8?B?QVpLeUI5cjhTUUlBRDVnVU92Y3BqUG95elNuMll6amdvaDYwSWl0dVVKL0Qr?=
 =?utf-8?B?Mi8wSVlrN0ZBbkVBQjBRK1ZGdHR3ajlQM1c4bzFMU2lnUFhRdGNUZmFFYnlS?=
 =?utf-8?B?dkJVaWpYdUIwRkR1OE04L3hUcmdBQXVpaFpUS1FoRUNJT3VJYjg0emJRQWZv?=
 =?utf-8?B?djM1Qk9La1N4M0p4YUluN3VXUVYydytDUnk1ZWNCSkwvQnBkM0FUYnZNdkth?=
 =?utf-8?B?QTlrTVNaZHZQUEI5L0V1WXMwNk9YVklxZTk4eUQ4ZHpmMlhKTnBQQzhIMEY1?=
 =?utf-8?B?YmdpWUhqakxLTFVudlVuOGo0NXpEc3YwemRDeFVHMDFZVi9aaVVtMkRWejhR?=
 =?utf-8?B?UGdNRWFnK01IcG5rSUJPbnlsaDhpcXNIVFp1dXcrdXp0dUJEVnNxczNaVEF4?=
 =?utf-8?B?SzZoSDNManI3VElJYmp2QVhKVE5qaUN2YjhUY2Vtc2tNSzIvM1JYaC9LSlhG?=
 =?utf-8?B?cWU3bVFmWHZpNytTdkxpdG1HRVNOQmtXcGFoTk5vOW8rV2E2VkRSTzVpQWZp?=
 =?utf-8?B?NHR3R05QSnoxZUljamk1NmhDenpXaDJVcXVBKzIzWFA4bXVaQlBBaURoUlFv?=
 =?utf-8?B?c0dYRXVhQ2VXdWVyYis0Tms2MTQ2TlNoT0hwV0xCeisya2s0dHBEU1ZEdVFn?=
 =?utf-8?B?VXB4R0RjSU4za1dRU3lKcGkyWUYzRWVSRmNaYUhzTnlNblVFbXFFYUY1ZjFq?=
 =?utf-8?B?ZHN1KzlRVXVrSzNUTjdBWVJsQXBXQmNYaTNCU3hmUjVUV1c5dEIwbFRuWjV4?=
 =?utf-8?B?aVVHNEpsOENTL24xRVkzcnZ6c3dUVkl4Tk95SzdSQXpnekhHa2FpR2FjU05X?=
 =?utf-8?B?R01GVFZtOXh4N2xJUllKVE00dVFzV3dDdG4veDVlM3UyWGxWWkhpblQ2blg0?=
 =?utf-8?B?TmtZaTFsT20wbHFDY0lZNGxENzhIODl0NVFDUDVYblFiVFFLd1VDcFVCMkY5?=
 =?utf-8?B?NzR0UFhPM1dDSzZKUG8xR0NIdFpiWHRQbFRzclVpYm9sNjhFNHQzaVZ5WHNR?=
 =?utf-8?B?VGhOODJ6MEg5SGdOd2pHQWExdVdjYlFMN0VkSzdjWktZSDZ6ZzlNTmdONlBm?=
 =?utf-8?B?R0xvMkQ4SWUyNnJXTEJwdTdpN0tneDBPZHpnZDAwK0QvZld3RXpPeURFTGJu?=
 =?utf-8?B?NnJzZG82ajlhZ2VTR25iZFlXcWhmMVdwZVo4TDlHVWw5andETmRGTzAyT29F?=
 =?utf-8?B?aXJTUFovWVY4amV0c3RQc2JMT0UxZXZEYWZYblUwQnhKV0I2SVVqeWQvQ0xG?=
 =?utf-8?B?NG1SWkhWdW0zZHByN2xJb3hsd01DS29aTmx0REFqSlJnMmY5UkV6SDdTNllT?=
 =?utf-8?B?SnRsanQzcXRwWkI0RkM2dUpjN1pBam0wU2loczNJdkNZZ3BZN3BneEpwYndS?=
 =?utf-8?B?em5WRWU1KzFBcFRmV1RlNU1XMjZYNnp5NFl3aURHdTQreThNMU81MkI3YmJV?=
 =?utf-8?B?V1BZYmM5MGVmQnEvQWVTa3VPYmp6VkNocHl2SzhFaUlkeUtlM05EemV4ZXVk?=
 =?utf-8?B?OStzU0h4aCtDU3hYRkszTUpxR01jamQwenlCcGZ1WTZLK2VKS2V2U1VLZisv?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3843d3c-9956-4c33-90af-08dc5e132368
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:45:47.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGdxCWOXb9qEm+izpMHV2PzmG7uSXh4fPLk1fE5GVLLQkhsVumNvGWsKGO3DyTZiHCe3DPTI9q8hhCMsSwDBspOyzwA52e1lIiKH/7Q74zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 11 Apr 2024 07:47:09 -0700

> On Thu, 11 Apr 2024 12:28:08 +0200 Alexander Lobakin wrote:
>>> Any reason not to make it a bitfield? I haven't looked at the longer
>>> patches but this one seems to be used like a basic bool.  
>>
>> This whole enum could be made as bitfields, should we convert it? Would
>> be a big patch tho ._.
> 
> As always, I haven't investigated closely :) But my thinking was -
> we are at 34 bits in priv. We just need to convert 2 of them to
> a bitfield, pick two with fewest uses. Then we can downgrade 
> the field to u32 from ulonglong, and we can carry on adding bitfields?

Hmm, sounds good. You mean convert the existing bits which don't fit
into u32 to bitfields and then add new priv flags as bitfields?

> 
>>> But this definitely _is_ a uAPI change, right?  
>>
>> Why?
> 
> It will be user visible, ethtool -k is losing a field.
> Whether that's actually going to break anything depends on how silly
> user space is.

ethtool -{k,K} output would definitely change, but it's not an ABI.
Rather some corpo scripts may break, OTOH those "features" never were
available for toggling.

> 
> As Andrew pointed out, definitely something that should be called out
> in the commit message.

Sure, good point.

Thanks,
Olek

