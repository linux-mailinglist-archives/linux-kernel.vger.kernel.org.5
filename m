Return-Path: <linux-kernel+bounces-132799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B42899A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7971F23824
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40325161914;
	Fri,  5 Apr 2024 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNCJdKY3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3D815FA99;
	Fri,  5 Apr 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311982; cv=fail; b=Ks69WHXosRl6WH0pNbCtn8CFRWJW+T4G2zSyPHFb6v9JkNHYbms4VBrwzUjbNRk4MidFRV3WCaKhR0ogOa2ztPOk9wYsE3hDAGDtsyuOFkBz53XnHrlePO6qGRIm+fhx/r+9yYi6tlS+QIQ0EMXamiE3FZbKM4ve7BTx3L2slhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311982; c=relaxed/simple;
	bh=4ufEReBR6f+0jvz75erO6pV8TUFaU42WCIfMRwt/d58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TZDsrkQzjdAyqQHrDlSNNXc+Hp+VQKO+LyTtjxidN3GnpQWc4p5xWzI1bdQSWkz6h8tnWnXNzSw8TNZhCZv0gEn+FKgWP/zhf69QsHQCnkbgPrMxrAWtfd27vHHHDi8bJFrDM28/Y8dmf5st4tQ4lN6s3JxEm38VOlMlcc7cDmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNCJdKY3; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712311981; x=1743847981;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4ufEReBR6f+0jvz75erO6pV8TUFaU42WCIfMRwt/d58=;
  b=BNCJdKY363mZ35YMUHL5+ou4kKylkGejXw9Dgk5y+Nqjkr5ewkRD+Pri
   tBFCxmEKTiY2ocFoNm+yIbcxjZG0uGcmON8N+XfwCzhj0mFsNJ1v3+J7+
   zfd/HwreGYhsdIBGjGQw3T9nLacU6+BhU7C2ktjGk2qwRJVavcB0xVfAB
   RwW5URhyORnc9m43vL7romJZ0eV0CQfj+xRlgb9w29HNtZvqVnxU8lv/l
   Y5l2AsrPJHNAXTgF0ZLfFs4EHqM0POiA+T8+mmbmFetyx8gr0FyAkGIjf
   IHd6tWsgMEpS8mg/z63uv7jHpgPGchMSmU/f6DWbE6OhQbQqsMvSgFGDE
   Q==;
X-CSE-ConnectionGUID: TwJMEVQNSy28y38vfszPlQ==
X-CSE-MsgGUID: vXNH+PldSDSuyGbiLjmk2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7793043"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7793043"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:13:00 -0700
X-CSE-ConnectionGUID: 1WAbX4sBSLi5ddOrQO2FGw==
X-CSE-MsgGUID: vpLXmEx4RY+7xxaXcb4swQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19114214"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 03:12:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 03:12:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 03:12:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 03:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXdVTC1IH9qSlYIlyyQXEdjYBGROGqr91bv4ZBHcsCQSNDwrh782jC+MPpeHuCYhSao80Pi/T5lO+CEPofJSf8ivMzo6mWJMGnl8fSf0JhvtrcrmSPVQ9K+W7OCbkBlwkxVqA1EAzLRgB5XYLA0fu31qpTw9d80bsm3y2BkcZ++wuPmg10uDLPeOqSgGydVmFfxqilCDmDw3n+Zu6WX2zdk/aoX3Z1ibDVHrk3hxyNIkNyFUUZI+/5STqYGES625dmz3oayhs8Vx4jAHY3jnm57XEqiWYoXxGfKjfrTYxFV5tPc6LQBEz9EvB7sZNANmGdrHt7Tr0uWprBs/iRN8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6uUsXi51xFsOqwmsjuMmI/ClFQ/VhReqjCzFbbWccE=;
 b=HH7z4fPBgCCsZ44Q36P0bMZuyHDA7rD5pccPBuyunof98GQRVNZCWLNATM7NOZxaFqbNrNODRoiO9GSQFD0s7IWBqLYmMscqHejALeEI6udIDQZcloE3NOEsL8dPB5mHdrPfbVLT7CHAYc5SQXtJRbl+m2lQeXqb94GQnDsUypSk9T7pIfxyGtdGYj2IGFSmvcoBFcUf0PwseWLz+kEkq1GmIDBLSFbT/ziVgbl3WseWNbBQBUh1mEjmCfhtxfwvSy5v9yxvBQfx+pcdOP5Je4UELXMwTVJurIwsRdtFrJy3RYxmihQPLPpJbWyjp59yW2AKFypvV5Oz7og4zdqgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Fri, 5 Apr
 2024 10:12:52 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 10:12:52 +0000
Message-ID: <569849e6-0bf5-485c-b22e-cbf05ddaa2b5@intel.com>
Date: Fri, 5 Apr 2024 12:12:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 4/9] slab: introduce kvmalloc_array_node() and
 kvcalloc_node()
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Alexander Duyck <alexanderduyck@fb.com>, Yunsheng Lin
	<linyunsheng@huawei.com>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
 <20240404154402.3581254-5-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240404154402.3581254-5-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MN2PR11MB4646:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyDEO1rrYFH1s0gqvM+blN9I65Z1oz+WZz9uU9D/eOo4XLFGx2aKwqdeIjHYpH/CVJ1kIWyFYiT+52FCml6Dc6CEBL7YBS3ZyCyLgYGQFXR9k6EfaM7e8GgD9+zpVzie4aDnWx7RRXhNqlyEoR12SezIipem/HaaqwN0yuwbkxshp8wCCtTkqKDjbVX/LYP4SusGGRRG4x1zTxUo0t7nFXtHqs/QHQC2ZbrRSjeEXF7sWM+2v37RNocGaCT5v1FlSFUEt16UAzGs/Vr3REexWwp3sxLqchoEIkNcotxlVyArA/s6TpLh46TWh3wjI4gYun+Z0VH1XLSTt8ElKtAhDepIQGa35vwJ49sC0BkzVkgfhuVWfarxZOsJaJRQAWzFSzhoXwAiRienm/hUz6m/JIHqPI5FP/tdQoXr1WBD9ZfI76mx6TFe8YpCidCp33IHZuELoV+dgCG7ldYylkXIUgh7Y/5lBm30hMy3+9VE/JyUYuIF/U31DIDsVs3l3wjxFSk0QY1Koeks5iEyybdON48nk0QP4NQDG0DXXfOU0k2xOv1nmrRfUgNazN3m7dcj2thtGYtYF1wAlph9RbErmqWGnKCpRDDehkZQgB99TuIr/U47FH7uc0wBRmpK5su9y934SHdJPAahj1dVJbOvmg4/O86qlIrPFCusuyJsCyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFE1QkNDZGMzSkZkUDZqM2kyTWVZTVZ0NVZ5ZXFTNzVYZEI5cFNBcU8zeGJI?=
 =?utf-8?B?VmVvc3pyQkJVUlVQczJjNXFQRHpXc1pqNERISC9FenNHLy84RTc1cjM5Y0hJ?=
 =?utf-8?B?ZEx6ZEFjWVFKMVg5cXpFQ3p6WGdkaTFEVjFzekJmM2FzODRFYldieDBoUUVq?=
 =?utf-8?B?VE8yMFdrellYd0VCbHYxYnhHSkxLRXFGVEowdXdZYmtPbU9lUmR0REFuck5h?=
 =?utf-8?B?MEVGbDIza1kyUEVXZ1I3VjJFZDdQTkYxZmpvUC9RbEx1aldxbzgzV1l2VStF?=
 =?utf-8?B?NE9QeTdMK1Z6dzAzeEQybFA5WlRDNnBFNHp0d1MvbytScnk0dC9HdC8wNjhz?=
 =?utf-8?B?dURnN25ZVW9EdExHeWczTFhsUEc3VXhyV1NpNjVSMG81bS9ydGxkR1I1OThw?=
 =?utf-8?B?eVRhaC9NbGZEcTg3UkpIM3E3NExFVHhHeGp4dFVraEhLam5HVnVvY1FUSWpC?=
 =?utf-8?B?YTI0Q3FEV2NtN3E4b2VSUVJmZEtveXBxRjJmcmpMbkgzL3lNaEc2aElUajJ3?=
 =?utf-8?B?TTUzc0dmYXRlQ2VkaTIzcDFwMXZETXhzQ1F6VmlEZ01JNEFsZHZvZVphWFN1?=
 =?utf-8?B?SlFHTS9oOEhKdEs2L1oyRWlpVjB4d2c1Snd1c0xQRFdyNmV6VDE0aDlweSsw?=
 =?utf-8?B?OStJOWpkUzMyTEZ6RWZWdmtlVDlpdWtndFhSc3R4aU9IRVZGMEd3WHJPZ0g3?=
 =?utf-8?B?U0JNM1Y0NHFpdUtPeFNjK042SGt2dlkwRDhYa2liR05FbEJGMWh3S3B1QVFZ?=
 =?utf-8?B?WFF4WlVLUThpc0dHOWV0K25FVGFKaWk0TVRwaU1xRkRpUHFvRS9yaWQycUNT?=
 =?utf-8?B?eXI0YW5XYjJJSnpyUFNGeEs1NEpKUi9RTDVxOVhDZllNVHRWZmdWSG8vZVlj?=
 =?utf-8?B?MTk3YzF5Y0t5MnpaKzNnM1VCMGhYamJJQ0ZIWnFUeUpRclNQUzFkZzJwOElr?=
 =?utf-8?B?Y1d0b1A0T2tuZGJseFRjTGRZR01yVXMrSktrZUVlQUZUZTV0L3FNOHh0VDI4?=
 =?utf-8?B?aEErK3JOdWc4akxNVGVteHFDUVlTSkxPalpCaFdnWElkVnp1d05aZlJFRjVa?=
 =?utf-8?B?TEFRMkVFUzdGSkRhZVJHYjFiM2h3RUgrS3NyT3pmbWxnWld0amMvWld4ZmhT?=
 =?utf-8?B?blpHcUxUYlFIOFNDOVJQb2Z5dHBmTGlnUVV0Wkcyek9KbHB0UjZldjEvNHJp?=
 =?utf-8?B?VE5MNXlBZDFjZElCOXZaUjJUcS9VNVorelRqU2FaUDE4UEMxNi9ScWt4dDVx?=
 =?utf-8?B?Mm1WRnA4VUUxeFI2K3VucS9USkpSWGxxWHNkNHZrSEdWb3BSbFJPQ29xem95?=
 =?utf-8?B?UXRPOVNKY1puZ0gzRmwwdXJ0dTd1alR5RlBzQXJDdmM3bWdOUTVsZGlzRmQ2?=
 =?utf-8?B?THduTFM4QVpBdGliWVFwQjBoT1ZBdmpKQnRtOTlXM2srK3VWbU5GTDRycDVF?=
 =?utf-8?B?YlRaTE1qQXl3VnlBME4zU0ZCVXBvUVFlQ1pqQVkxWnNqaVFVTVNTTjU3U0tm?=
 =?utf-8?B?WmtHcURBZFFPK2F0eCtramc4WVFNTG1Mc29oZUxNVWwwMXlJZitsUnh4bXJq?=
 =?utf-8?B?ZGppb0xzSVpSczZ0aEhjNlFnVFlYQUdwajM2Y1libytvWWNyaFZpRVdaQlhK?=
 =?utf-8?B?UlQxSGNvS09zM1BOazdES3FaaVk1L3hDK1l0dzMwemtYS1RrdU5kTmNjWC90?=
 =?utf-8?B?OHo5Y0syazB5UG1TZkd0RmkwQXlpbEhNWUQ5QU5vWG9LK3FpVUlwb2lqUFFq?=
 =?utf-8?B?ZXNBTTZiYlQvMjNqTFVtMXJTM1JVc0xwb1hDbXVNUWN1VWVzelRBOEUreG1q?=
 =?utf-8?B?WEJwVGhuYlR3K0RsOTJ5azYwQ0xWbzFDYWwxb3F2RmM4UE9DLytlVHl2dUlr?=
 =?utf-8?B?VzBUaXBjLzE4RG9WeUhwVGtNaU9ZK1ZMbGswSllRQU5IL0V2ZG1ZcG91WS9W?=
 =?utf-8?B?ZFc2d1pqeURMOW1OQ2lvNU5ValR4N0ZzN0RUbWdGUEorSWtGVXVYeUZVb3dP?=
 =?utf-8?B?R3F6UnFBVjR2UU9vZkxaKzZsS1l0OHBCVjRBUWRQUjBRSldDbUc0cThaK0di?=
 =?utf-8?B?MDdna0w5bEZSL211YS9xMHI2aEhOOUlkdHR4alFsQmROcnQ1VVBGaUdMVmF6?=
 =?utf-8?B?MVVUQVh3MGJaMnZWZjhPTi9Kc0dXcld4SVBxNXV5aUJ4bkJSR0lHaTZWRmxk?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ca8373-bb2b-4ba8-8f03-08dc5558f416
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:12:52.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkMraC9CyJXnzTm/BBtt67uwFXAr4zjmcbBItljvtG3Av0nRu5v8a3H/TB6gt2fBQ6m4xgNQTH9l2hmkdANhaeU7suWz4RTpF+g+rN/UiIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

On 4/4/24 17:43, Alexander Lobakin wrote:
> Add NUMA-aware counterparts for kvmalloc_array() and kvcalloc() to be
> able to flexibly allocate arrays for a particular node.
> Rewrite kvmalloc_array() to kvmalloc_array_node(NUMA_NO_NODE) call.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/slab.h | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index e53cbfa18325..d1d1fa5e7983 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -774,14 +774,27 @@ static inline __alloc_size(1) void *kvzalloc(size_t size, gfp_t flags)
>   	return kvmalloc(size, flags | __GFP_ZERO);
>   }
>   
> -static inline __alloc_size(1, 2) void *kvmalloc_array(size_t n, size_t size, gfp_t flags)
> +static inline __alloc_size(1, 2) void *
> +kvmalloc_array_node(size_t n, size_t size, gfp_t flags, int node)
>   {
>   	size_t bytes;
>   
>   	if (unlikely(check_mul_overflow(n, size, &bytes)))
>   		return NULL;
>   
> -	return kvmalloc(bytes, flags);
> +	return kvmalloc_node(bytes, flags, node);
> +}
> +
> +static inline __alloc_size(1, 2) void *
> +kvmalloc_array(size_t n, size_t size, gfp_t flags)
> +{
> +	return kvmalloc_array_node(n, size, flags, NUMA_NO_NODE);
> +}
> +
> +static inline __alloc_size(1, 2) void *
> +kvcalloc_node(size_t n, size_t size, gfp_t flags, int node)
> +{
> +	return kvmalloc_array_node(n, size, flags | __GFP_ZERO, node);
>   }
>   
>   static inline __alloc_size(1, 2) void *kvcalloc(size_t n, size_t size, gfp_t flags)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

