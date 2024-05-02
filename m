Return-Path: <linux-kernel+bounces-166905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1558BA1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FE51F21BC6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386B01802AC;
	Thu,  2 May 2024 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsxNdteM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A031E86E;
	Thu,  2 May 2024 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683177; cv=fail; b=h9WuB48AyBFET/eX5xnmEi56h8K4BRzBfzx/CF5zOelsUF310pEblzZZ/LEHuQC1wkz9gX1SvEx6Iizzceo9V2OkwG83DBVbBeR6Xxq+YE2ckuEGRA6cHfbmmJsJm621NQyyym1V7bvAvnRdh/pPyR7EinhGgaTYLC6kRNxheV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683177; c=relaxed/simple;
	bh=53qV9NgEK8fDXXSfQc+5JpDPO5JvJl0YDFsufwBvz1A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=litRS8mMC+MZc1Atm6IJ6u3OKSdu8DsU1mlazsIcRvlCdi3ZLnRD+uoq4MRT1tGtdh82PXguOv3VImke7kxJ0QL4u/auxNp8Ap4QO7kaIVcOqJh5I10Jgo8Aw2iqK2L2gCkeiXzpUjKETlauyDXoJlQsyUMn7jrLNKM08ttmfJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsxNdteM; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714683176; x=1746219176;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=53qV9NgEK8fDXXSfQc+5JpDPO5JvJl0YDFsufwBvz1A=;
  b=nsxNdteMgQOeJvwBsat9+l/DpKS7TnaMj0YFjV3RUAJ67U34WVySnC/N
   5d5j5O7+b3+yFSGOotzTjfC+bi3XOiIsWWmVPVAvrQI8gNLiZ9NsbB9zP
   MxppHPnoxxRv1lUbR2We8lT8izmxMZZOwxlUYm1I6NUnK4RHDMkEBPd4p
   YmeQ8piHU+eH6CgXpEDqmT17yLiHX6JGwqvEhYE5sY0HS9W+qA0UDsQUi
   /5psUUgCk+xq4mGGr16D+UofO37fQZIKZKbr6rh8rxxb0Zn68ydLNg3Gp
   DcTlyYq3XxUwrB1wNNc6j04jvXpeP8VONUcpgyaedjqZ2gW9uNxfnAd06
   w==;
X-CSE-ConnectionGUID: +nGZyhl2QbydeX8EhgzO9Q==
X-CSE-MsgGUID: Eezz9XDVTn+uXzLweB/hGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="10327851"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="10327851"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 13:52:54 -0700
X-CSE-ConnectionGUID: Xabc+9kgTCqDpQT0RFI9Eg==
X-CSE-MsgGUID: J3Uo1vOYSb+750nwf/fyuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="31745514"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 May 2024 13:52:45 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 13:52:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 2 May 2024 13:52:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 13:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D098Q1nQwgrcqx6bNcvPFMJ18zuDo0+AIX7BQRGpPpU/fDuiZTlufngM0UzVc3DR7AAkmxVcf0Io2mlgHoPdL0ckJgNAFh57rUY/EEBt0y9tLRw2pnk3RYTj+TsZrAhfpc683NEujzMnb+L5DgJjcmzf9kLXfunopSX5dRizULaYUXDmggtfon+T3fuDcKtnINBrtCk7sFQZ6lnHtbkKsAr2HR3LB8yi/VVxwT/7Xn3CYIFB8qaE77rjH9rUnBO9RoijQ9h8s3ZFkCKpvTOngplrNPOixJ7k6ExEqGaMtTR0k8rkVKPrlHMpU1TQFxHbr16OS0DSCd1GGTpzvLgaMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84t/6AIML8fWlthvYy/4Juu6Iv+Ik1JofbJ2mHRo3NM=;
 b=HT+xfWJOIazwiJl4m4uBeUpOfEYJY2bCbT7tFQkebelZQC6YQjrEx9b9BOZQOPuPSyal5AtoG4i/iMYTOAdJc+M+WzvCgvzUZBvPI/Tr1uvhHjEoApsqAqSbjxDZLVEsNhMxtluR612/oiaxNyxuvjWUadV7ZdZpFkuRlaXPD2wFADTGWRhwW5MPRE9DUI97sTKQtHEDVZVwKiolZUcOU5jZnpmra1U/nQSYecPDnuxVFTYncn45pd1qPIfTRVDlX/xh43ZOa4ar9I62gKofqCNKeQjJvVf0ozMhTRm9RZzXu+dAlbAv1xGR6JRVdGUFOXDehjIV7kDrHU5Y2P/xkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 20:52:38 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::a972:1395:dd49:1dc5%6]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 20:52:38 +0000
Message-ID: <2ea9e144-7d94-4dee-b642-657306a0f9b3@intel.com>
Date: Thu, 2 May 2024 13:52:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] x86/fpu: Extend kernel_fpu_begin_mask() for the
 In-Field Scan driver
To: <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hdegoede@redhat.com>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>,
	<ashok.raj@intel.com>, <jithu.joseph@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20240430212508.105117-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::32) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6d3884-0de0-4a04-3005-08dc6ae9cd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0VwZXhyWk9tWFZDZXFyQ3FGYmx5Wi9UdklpbVNxWG9LSjJpZ2c5K1VzNkps?=
 =?utf-8?B?Y2VqcjRZSVRsZ1hCOEZFR1VQeTQwdDlsd3draVZ0a1REeWVrMEJ5c05KZFF4?=
 =?utf-8?B?R2srcmpLOVJKakl3dnduMGVjTm9QQTUrV3hqQnc3SURYK04rNUN0N3BSL3Vm?=
 =?utf-8?B?OFFLSEZ0cHc3TjRwd1NXbloySkNZVHRSUGVOeU5tQ1hBNncrdUVMZkxrZmNi?=
 =?utf-8?B?TnpXaDgyWGNJbHo2NUpIWVUyNXc3MHM5QzBMYlhraTJjbkxHdy9yUDQrWlBw?=
 =?utf-8?B?Skg3aFdNYytZRCt3WkZsUmQvMjJkN3BPcjRWNVd3M3UyRU50VWhwcS9JZmdn?=
 =?utf-8?B?ZjB4NWMyMlY1Qzl4MmlBM3lsUHFtQWZDeUVwTlgrMW5MbGpxZ3N5UEZBb2lL?=
 =?utf-8?B?VmVXVnpwNjF1aG1KN0VZd0R1YjVaVkxtRHp0RitBaFJpV29JRzdlNEpLdmdl?=
 =?utf-8?B?TzFCemQ4SWlyM3pIb2p0Snk4MXhjQk00aFRBUmRZV0hlSGpJL00wYUFMbW1n?=
 =?utf-8?B?a1lhVUk5dDZhbTJ2LzhCVE54cE9rWXh4amplU2Rjd2NJcGhqUjFRbDVQKzha?=
 =?utf-8?B?Y0VjM0FsK0VxUHNoNkM1cFBsUy84NWtuWnVZRWpRSmRMMHhpb2RyT25MdFZR?=
 =?utf-8?B?K2Q1NnlxOWJYZU9Qa2xGNU84eGFjaDIxVGRSdWN4QnNwbFk0LzRoTm9oQ3Ro?=
 =?utf-8?B?OENmWEtzYk95Z2h2ZXlEZmZiTUh4UU9UTGY4SFNzR1ZHZlJoVkptejNocldZ?=
 =?utf-8?B?cDNUYXM2R0JuekhlbGZFR3JEZVNjSFFlRzhsaFVxT21lVXZTTVpBR3R0blJq?=
 =?utf-8?B?cU1oRmFQNVJjSGF4ZVhtTDZ6b2w0UnJyenk5N0ZSV3UwNGJ6U3p5NWRLYWZL?=
 =?utf-8?B?S2FLZGNjdmllenY5TnhzdDhQb2g5VjkraEM3bmNKZ21ZT2gwNTZVbDNNY0Qw?=
 =?utf-8?B?a2Z2VS9LVklzUFJ0RVc3WEN4Y3BPdUpHeTUzb0xwUzhHSEZKVkxBaWNuMEl2?=
 =?utf-8?B?MFpEc1dRQWVTSXczdGZxUGI0TVhHVUMweFV4c3VXSy91UkY1elI2ZGREUzh4?=
 =?utf-8?B?Yk5vbThBVHJNVjhzK0d4MzRKTjZMdnF0YlJ3aFo3K25iMnlzTEU4dmh6V3ZY?=
 =?utf-8?B?MGlmbHluQnk1eVVmcFlBOTBQbDBHQkxSTkRvNVdTNzkwdG91b0NDZ1BtaStX?=
 =?utf-8?B?bEF6ZjRwSWx0UDdtcy9GbEVkeHhxc0VhcmZuaWVWbjZOSmZGd2JrSDgzelJL?=
 =?utf-8?B?UUlaclJQbDkzNWlocXRyRnI1emttTjREUjd1UHRETzBMUlRXZ3BXVzZadnlG?=
 =?utf-8?B?dG1DUzlwZ3JCQ2Vzcm1Wc2RJUlBudEpqa3M1Z3VCeHNWeVhRYTNQSS9xTmVk?=
 =?utf-8?B?UDhYVVBCbjdOMHdTcWxRcUJuZ2F2cEE3RkVxY0dpd1lTcHhiSGFQV2pXRmFo?=
 =?utf-8?B?Y3ltRTJHYThpN1M0UkgzSjFWZXhJMUtJU0haY2pQcDFzb05vVzljZkVyN01S?=
 =?utf-8?B?QWRvTjRIWTZTYmlmV2Zmb2U1Y2F2Sm5jZ3pXSDhMODM0czZzUGhaSFNoeC9W?=
 =?utf-8?B?VktSWnJGNGwxdnBHeVFlVkJqaGhzNTNybUxFZnc5ZWErU3JxWUpPR1B3c25T?=
 =?utf-8?B?Vy9FeWRBQUFCY1I3Zkd1YmNsNGdQeTZtYXZOaFdtRDJ6amExdnlqYVA3UnRI?=
 =?utf-8?B?Q3hEYUllL2NkbzI5V0tOcGgzeUQ3cndzTXphcFlYRjRmYllDM244c25BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlnd3dWd0k4UmU2STRqblNaWTF6NnBqcjlPQnJjUmgydWVaNkdMVWV6UFgv?=
 =?utf-8?B?SmJtN1lTelljNE5ESDFITEFwZi8raGFlTTk3QXpZRzFrR1N5cHU4bExDWHIy?=
 =?utf-8?B?Rm5aTktsMUxYdE8rdzNvNjJKKzlONnR1bDVaRjRveFV6UFFiYnhSVlQxa1ZY?=
 =?utf-8?B?V0wzV04weU9NbEs0dVRUeGxLVFQwb2IzUHlZZDhxcHNxRXhDMmI5QVE1ZmlG?=
 =?utf-8?B?VCs5MSt1SkVBbDBjNTJGa2VBU1RocWxFdGZQSXhadjVBUENhWUlsNjRLMThh?=
 =?utf-8?B?ZlJlTEdEU3IvaEQrQzlEd2VQbG9EdERKeHY5Yy94dmVONUZvQmo3ZzFPUGY0?=
 =?utf-8?B?UXF4VFZDeEY1RjYyVUxrU3VDcmFwclBvVjNXZzhDNWlGd1BvSncwTEFtR3VV?=
 =?utf-8?B?ZlNHbllseWQyTUVncjFzZ3dlVG1WUWxaZ2VUcUVkQXRzVjJSKy9uRENzdXhC?=
 =?utf-8?B?VW9sK3I3LzFyZHJIYjdZTWlLckpackt5V3BDOU5vNHlZdXJ6eXBEaVJ0dGdx?=
 =?utf-8?B?L2N3Y0Rhc2lVd3hNSHdHcTRTaTlERWI1OCtUOHhOWTdzeFlBZGhydUlod3Yx?=
 =?utf-8?B?YkRsRWdWenAxOWlQK1ZVS3hOajA3MjN6WmluZ0dTMHVSYXpJbW5TeVh3ZVBB?=
 =?utf-8?B?Z3VWMjVvbDlNYXRSMG1uQ0VLMWdLUWZia25PWDk0MVd0UkxuWmhGSWZTeEVQ?=
 =?utf-8?B?OXkvYkRuZThjKzhsMnV2d1lJa0d6QkJrOTh1NXFUYXJsaGJnMlA4cmh5ODR3?=
 =?utf-8?B?MUF1MCsyeWNaTit4TXNOWXdoUWRMRmdnL01oV0N4RUx3QkZhaDYvOVAwd0py?=
 =?utf-8?B?K05sSTNsWkl6OEFTbGgwS3EveWFVK20vSXlFcDRsTVAyR2UyNk5PYlR6Y3Zp?=
 =?utf-8?B?b1NtNFR0V0hNWThGblRxcDNiTUlBV0JsWU9RMHpTOW0rRmxtK0JIODlCWjFO?=
 =?utf-8?B?bGFRNHV1MlIwaEJ2b0p3ZndYYktaaDNYRVl3MUtrOTNlMlg4UzlFRnhuU1lD?=
 =?utf-8?B?N2lMYlF4UGM2eWhZaktBYUZjcFBiMldXOHE4WTdiNlV1Qmk4dEp5Q0xiRXFE?=
 =?utf-8?B?WnN0RmJ4akRZWGJzSnpRdnBFcjJ5N2ZEM1VPYS9uQ09YZmlSRWp4MXUxM1N1?=
 =?utf-8?B?U2l1SHZkNytsWHUycngrL2JYMWUxOWN2Z3oxL0JheG84cmFqNXgydnp1M1lP?=
 =?utf-8?B?ckVsNU5ocFF0Y0c3b2lUZnlBSzJkaFl2WGx2V2RWL2NIOXU4czVqa2F4QWo2?=
 =?utf-8?B?ZnJNbTYxK2xySlhwcjVFaVJibzZpTjQzdGRiNjJzV3BMd2NjZXFzcFlaV2pL?=
 =?utf-8?B?aURYcHp2cVdZL2huK1JkbUM3VTVaanJ3WDErVVNNUjk5VTBmTGxpRmV0L1Nl?=
 =?utf-8?B?eXZNZDBvSit1Mm1abTNiWWtBZkVZSU10ZVJMUFlSbjRJK2dNU3dLYlEzS2pC?=
 =?utf-8?B?djlTWlh2cWhXSCtXQW94SjUrTTZ1anN0Uyt5aFpQY3ZBcUVteHBmQk9xRm9a?=
 =?utf-8?B?bTlLY0pxYk9JcTkvcFZnZkw1MmNOeEhyNk1KZHh3UU02cjA2K2pXaE9XY3lU?=
 =?utf-8?B?S1p5a1g5bmJPR29Cc0R6eGFjVFFoaFdPckFiVWJvUHpWRkxFcGl5OHk5UFkz?=
 =?utf-8?B?UkFVUWo1aFMwZXpJRkVyRWllVGEwMVo1cjd1aFBaRkZOZTJjUlJSRG9NWWMz?=
 =?utf-8?B?SmFob1IzU3pOVzZ0QnRvVHRxTityeXcrc2c2TWRRRTNnckhlbTBNWGVWbXlt?=
 =?utf-8?B?eUZWdUJNN09OWFM1OWg3WDdMZTMwN01QbjN0Y3ZHYUc1S3h2dURxR2lqZzlh?=
 =?utf-8?B?Z1hjYlczSmdSL0d0MkNVMWx4bXZoNmJXdGdMRUc5UDRYMTFTUDJDbUM2Tmtj?=
 =?utf-8?B?bzVHM0hIV2QvUGp1bHVaNkVUdWs1V3dybjJjRHNnVE02U3JpYmk2UWdFTWNn?=
 =?utf-8?B?c2JsSE0xNVMzZVI5Mlk4bmE5eDhCNGdMaXBSVXMzNmc1WXdrQlZHcUs3MVZN?=
 =?utf-8?B?Wm5YbVljZGpUNVBtMmtUZnlGeXlOQlRUN29EUkpwN1pqUzZlclp5TXJ3WW1y?=
 =?utf-8?B?N3BOaHhZd3hVNlFBWlpCSkpybXh6bDJDczFTNkhES0dTNDRYVmhINXNxL1pI?=
 =?utf-8?B?WDU4Vk5FdUl3enE2UU5DbDFOK3E4VkpFUEpPWURDRmRXNGVpQXZOc0JYUitS?=
 =?utf-8?B?Unc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6d3884-0de0-4a04-3005-08dc6ae9cd22
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 20:52:38.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO89n0vM/VhKXP0xjMw/IMbFTAFVIw4j3Xav0FrpXE4hIyou9bwo/9ZQ64wmCoi9QSV/YCGKeS7zGQy4pLxi0GZ6+tWZtp9dR1xBdKW7QNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com

On 4/30/2024 2:25 PM, Chang S. Bae wrote:
> The recent update [1] in the SDM highlights the requirement of
> initializing the AMX state for executing the scan test:
>      "... maintaining AMX state in a non-initialized state ... will
>       prevent the execution of In-Field Scan tests."
> which is one of CPU state conditions required for the test's execution.

This brief mention may prompt questions about why the hardware must 
refuse to run the test under these conditions. Because this is part of 
its internal, we'd go back to folks who wrote this test and will grab 
their write-up to provide the logic behind this requirement.

Thanks,
Chang


