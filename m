Return-Path: <linux-kernel+bounces-146809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CE8A6B4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302631C21675
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7545012BEB7;
	Tue, 16 Apr 2024 12:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnQvRhBP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880D5FEE3;
	Tue, 16 Apr 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271202; cv=fail; b=nVE/58tCR+gtU/03GbhpmsuWP/XNfEv5mZhA7NJxZLUQP5WqBCCZUYA/SqSpcV/RGfqJ/HdJvlQlRhMpJeHxzFsy/ykb0aqJb0sOjGqrnmb2XRN4efHP2h6uC8js1yDXeX58MnrMAZhHSzQJYM59esmDn3Y4bqoQAaiSHy1Jclo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271202; c=relaxed/simple;
	bh=35H5cdSdicWKjiKRRpfDt5TS8FDERHmDZ/2hLSZPZyU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iph2qVGOqXRjehOtEB0cxr/L3OS4Vw7P3nvPCaDvUcXclALkULnWTtpquDklMWQUvxr6PEDgdhpPLdgPh1vnpboHel52IBbuObQwWvZioMBKxScExJ4Ss3Y3oq1/eiX/2BfhHcnGJRSMAOeIXBW3dRpLxccqt/2SPnVYvgZw+xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnQvRhBP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713271200; x=1744807200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=35H5cdSdicWKjiKRRpfDt5TS8FDERHmDZ/2hLSZPZyU=;
  b=SnQvRhBPEG9mE84Zkx/B5/ACSj7dHfcL0XHOlfZZ+BR1GpODc9kb5gkP
   pDWf2mbU7F9eKzYl0poGuvwdSeQhdPlrZnMEzIyClGyC6w/Eogod32S0r
   tb0X4L56HPw3qLeXnAUKOKvcnzBA5TTN/zT/dp7IyiKzT1tdCBLdJv26U
   UYwyqUn/VUpRgSdRcJ7NU0yaRZWNDk5izoqRyzB9GJPbhV48t9jtG0Hjw
   qQ1ZNLGu+R1T1SLG7BqrI091/UpDQ2C2mVlE+Q+JUBbP3K7SHiSEGBxAB
   gzWJdCZ4TBjc6S3SOHz5OmZwOsdWSb+OnzNXXGv17+tTwRHJvtL4FCDsb
   g==;
X-CSE-ConnectionGUID: N6E3U0QAR7iSmj1B8GOcow==
X-CSE-MsgGUID: wu890Zq4SbyivpgJQVPTGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9256269"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="9256269"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 05:39:59 -0700
X-CSE-ConnectionGUID: AV0lJrY5R/G4FC1P9iPfxQ==
X-CSE-MsgGUID: /6nTLvZGRqWEdyUnP8KPOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22286504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 05:39:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 05:39:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 05:39:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 05:39:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 05:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSP6xItHJnM0VAWD5Lxo7f53bWsxx8Re2G/QFPSYjPUrbfMpSVMOf6O0/suWq4o/+xz+OYW93VxMX+PpgxJCrvopwCUZjehelis++mhqK6xL0RT4lCmZPJvPkJ65ZMHFvagC67ELYyqd2/Qtt2HWIGbKkRxxBUrV+pCUbckNI18LwCgrPTpUlwxFXFubEdJNjFyVkEZZW1FqDGP9DMcbIU/P8oef+nvM2fwn1+lPbdgtsxDe6AzABxTGcZ1X7E+7W5RngWyW8eQS4Bi7HfgJqCDR50fBqOuGvtMNRXOjn7dW+rW5enpNJr6l13RSOiU2aLTz4faWPWjzmyB8ynLrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eWk6+yqyJBpSSg5l+dv9ZyQE/lUI8RlB3s4wHRg9Hs=;
 b=XV81R9wFR5NfDy5Lvpe4gByMKY0HiWiZTwX6xidp1LWp3JQr/EZHyw0HWlsGlYhlRqec+NTvuGp1O3nc2HYNkoAB1qJq6hfAOhlKh3xXctHsqyl6/xcbpZT0tCQoxqr998KmRffUn6AocS/FeRpr7zYHAmchCzphF0iUko0U5Ux/HZo1Qn0m4voE6aB7WEvtDkyD0m87yxr5or5z22KUIbPf1DV1RVWhRHbqZzWLS+O8AsGOMpKq+I5ImQmDLTOpBBeNymU16GrZ6Quq8JUQdyt7/8UM30ZDqChJTJpVUoMH5hfnT6xyKBSyM/fO1UVLvDyFqKOXDCxersY534548g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV3PR11MB8506.namprd11.prod.outlook.com (2603:10b6:408:1bb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 12:39:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 12:39:55 +0000
Message-ID: <654f6737-78bd-4aa7-bb35-84515d5fe3f4@intel.com>
Date: Tue, 16 Apr 2024 14:39:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 2/7] netdev_features: convert NETIF_F_LLTX to
 priv_flag IFF_LLTX
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew@lunn.ch>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-3-aleksander.lobakin@intel.com>
 <20240415143728.GB2320920@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240415143728.GB2320920@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::6) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV3PR11MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: eefe7ace-4c50-4588-5c21-08dc5e1251ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/sI+018UUfKVmMIDhb+JiKrc1ouUNFi8eFzm/lucFZnC4HpOJ6doyQGpsYHlTizBQ9/vVTFEko2UnYr6AGy21KeZu87G09iDcmvcrDnHmVhdsydrkVqhAQJxJ1eYEZsP8IJEPRu2Xy80GxOG1LOUbk7mqnYlQDHNnvMpCYgltO4DW2/KFKQfJYExyR9hc6Kj2SEPdxR/bLslk4hMw9WA/eUtdIDR+AL2iH6Ro4TUde8cRm52lqvasYk8LT9ZXszhUacGpum4pXNr35kYuVPAn/JsWCNQ5OQEP2Ho68h6xvRmcgvnYG1gJcoKauICDyU24gVMWbFmsCXj4WsjpKXwFBTFw1cHp6z/irjhOnXy0hN1XMaxhN86rH07bZ/pX5zrvH9DF2J/JrCsl9jy3akHF9UirWXxKDIKPXrKYOLDUcYeQkn2NECpQ4+bMtWPczAyBYxZ3l924o8cvmEC41vS9Vmx1P1Lrf07KhR3f+tAG5rgL8a9xbSTHKb3Ci4kN/UrtZ+NtQc97q5pfEeXDUcbjIPasTthyo2faY9SGLk2nZIPWhV283E1DVojUgMpfcXVgU9XzvQYEa8cO73VW5b94zmv+BaxrcyFxoV7rrcMdN12OBqBMOdNZ3ApQ+ezmT7jpQuMMYxzdzc0+EjGY0Wqft/nZcbvk/1UbVnneNpK00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVLV0xZYkFmUmdXd0c3a2g5YzloQUJsMjJFSVVyUXJBRzlCZ2djZWpSUU9r?=
 =?utf-8?B?TjhENjBRalkzbzB4NmRaWVNQbEhVMVlHcnlncWRwVW9GQmhGemtQWVpEZTRZ?=
 =?utf-8?B?R2pocnBJV3c3L21XVjc0VXhOYlFHenhMMTJPa0FEN1h5VHI1andDRFNnQzRB?=
 =?utf-8?B?dkFwV252QzF0NGUzODQxbFpkdTdhVGR0RFRJQmFPdEdZbmxYamhxcEdqT2ZK?=
 =?utf-8?B?b0toak8wK1ZZdjN5b0c0THVzekNnTzdmN1ZyLzVFcHVuT0hTZDkrUmhyRDlP?=
 =?utf-8?B?VVFSaXNheFVscGxpaXJLQnBSaDJFd3dndnU2NDRMNEpFczUxUk5EYWxiVTIw?=
 =?utf-8?B?dUgrcjh2TGZJcUN4Mlk4QTFlbURzZG1TaGhkMzNWZzVmWklxTlh4WFhmZW5O?=
 =?utf-8?B?eHArRTBaVXBGU3JSQmI3Zzl2TFpYN3FXVmhTOTFrdFEreHJwS0pnTXVzN2Ft?=
 =?utf-8?B?Q3RKdlRPZE9KM2xYSU9IcmxNU1hjdEYvVUlQRU1Ndzgyd1UyRDlscWQ1bVFQ?=
 =?utf-8?B?VmdJTEo1TU5rclhrSWxWMXFwRm1yaWw5MzdxUFAvUmRIRjk5bGRmdmN6SjFZ?=
 =?utf-8?B?a0thdjNLcXhOeXhVOU9tVndiRXczeDBvZUh3QVhHNVdGNUZIek5HSnV2aS9l?=
 =?utf-8?B?ZS8rT1QrL05BS05BRDdQQk1YNllIcGNmVHJiVDJ2eGFyUGg0QWlCTVY5N0R4?=
 =?utf-8?B?SytydWp3MmRoNGlpcHJNZVFSNUdHQ3NjZHc1VGl0M3pMeE40WTBoMmhHdVVM?=
 =?utf-8?B?bVN3SDhBR3NmWmFKcXl1SDBPeUNRenF4WjhFR3YvdEZxYmxGTDBSRUhGWUVD?=
 =?utf-8?B?U3EwcXp6S3lqcWtTN0lteHBqUHdpekpxWnN2eWdtc0Z4V0d1WXNBTE5CRXF4?=
 =?utf-8?B?bkhRRXorbE1EbTNwQmFLUzhYdC93VFhNVkI3TncwZFR5K2ZVTGZpdVgxSFor?=
 =?utf-8?B?aGlYa1kzNzlGUDRiL3BYRExBaGdaVWN5cjRmMjFldkJoRWxaSGRZcEdRck4z?=
 =?utf-8?B?ajErSE55Q2o5R1I4RE9jNHNCR0plZGEwYnp0TjFlWUl1RlYvVjVhaC9KODN2?=
 =?utf-8?B?b0oyR0UzanRDWnhQL0FBUEVQbHU4TFJVeERta1pMc3B1UkVabE14MG9HMjdL?=
 =?utf-8?B?SXhYY0cyVXk2MW9BRUpaU1lXT0YwNmJUUnBXelNLLzlFeDBGQkNqK0pEVXpm?=
 =?utf-8?B?RkNpRTIxY2UzYi9wU1RWcDhXajZFTnRMNmhldlFFS0NuODZGZGVjaC84WHl2?=
 =?utf-8?B?dmxpU3o5WWxkamlWNzBheFRrOWZ5NFRCaE0vdmtIaXMwVUJWVXJYOTBDclVU?=
 =?utf-8?B?Qmh4S20vd0xESU44STV4RERJZVJ2OHQ0akxaaFBEMmcwdG5LaWsya3VzL0RM?=
 =?utf-8?B?L2svQ01rRmJmdEJHbkJMWFZoc2NlV2N2UEhiaWtxUEw4UTBQUmVFd1RiNDRi?=
 =?utf-8?B?WGpqdHJwSFpZL2VaZGhHTHdYU0tTUXlIWFlYVXp6bkg4bmVOc1JNcE50VjI4?=
 =?utf-8?B?TjRrdFdWeDNnWnNmQzFuamxLSW5hbzNJWjFoMlA1VFBybDJyTGRYd1orUGcy?=
 =?utf-8?B?dGJ0VnFYbzNTKythcE1BbkcrKzhuNlIzdEx0WU5NMURvUXNIeU91MkJmRkcz?=
 =?utf-8?B?WWp0YWJ3eGY3aVA0cDdhMjlBNnNqd2d3NU13NTREZzR2MFFEcy9UL2FCdlVF?=
 =?utf-8?B?c0NHOHhyeVcxMnJnQVk4bXZkZHdiU0lBY3NEem9iNkpQUnpHVG9sbXA1azMx?=
 =?utf-8?B?Y1pRK2RkdWNnNkdaSHVKcUVOTGZ2N3VrTXhtbHBiZzJGa05TWFJrUXZDWm9R?=
 =?utf-8?B?cDhWK3JBY01sK2dkUHAzUmUrTlZSUEJwMmcrRzJMYVQ2aFlycnNGQy9NV2tC?=
 =?utf-8?B?K2VuaThzMWFkdmI0ZDNXR3dsN2ptS2h3ZEVaQWZvNlNnczhKM09HWWZYbEJN?=
 =?utf-8?B?ZXZjd1NsYXBTQ21FYlZVMlgyNm84d1pnY3ZoUnNwcGpVbFppOHJFQjZpb2NH?=
 =?utf-8?B?Y2x6dk56VTlkejBaYzFrdXpUOWs4SmtsR3NKQnZDd2o1OUNmZ2xEbnBjZTQv?=
 =?utf-8?B?NXdicVpjVUpjS3VjNVExWUsxN0JuRisyeUM5ZjhHQStSejROMENmb0p2cHNG?=
 =?utf-8?B?amtwelQ4Z3NodlpDM0ZGYkJPdGI3Zys1MnBqTHRDQXNwcTBXdDhFUDVoTVpo?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eefe7ace-4c50-4588-5c21-08dc5e1251ed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:39:55.9027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brUlA64i3oiZ8KJ2Zx1DoRUeORBIznSFU62wulTYBFw3sfIjgW2Au8mY+V2iCtwEfYEg1UFoI3/8t1DZtSBaSbEUaVk9tGH07FnkIRjADsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8506
X-OriginatorOrg: intel.com

From: Simon Horman <horms@kernel.org>
Date: Mon, 15 Apr 2024 15:37:28 +0100

> On Fri, Apr 05, 2024 at 03:37:26PM +0200, Alexander Lobakin wrote:
>> NETIF_F_LLTX can't be changed via Ethtool and is not a feature, rather
>> an attribute, very similar to IFF_NO_QUEUE.
>> Free one netdev_features_t bit and make it a private flag.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> ...
> 
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 0c198620ac93..065dd68fe97c 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -1649,6 +1649,8 @@ struct net_device_ops {
>>   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>>   *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>>   *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
>> + @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,
> 
> Hi Alexander,
> 
> Sorry if this has already been flagged - I thought so but I can't find it now.
> 
> " @ @IFF_LLTX:" should probably be " * @IFF_LLTX:"

Sorry, yes, I messed it up.
It's an RFC though, I fixed it already for the next sub.

> 
> Flagged by ./scripts/kernel-doc -none
> 
>> + *	such as tunnels.
>>   */
>>  enum netdev_priv_flags {
>>  	IFF_802_1Q_VLAN			= 1<<0,
> 
> ...

Thanks,
Olek

