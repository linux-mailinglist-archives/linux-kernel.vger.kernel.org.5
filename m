Return-Path: <linux-kernel+bounces-136212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1889D141
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77029B233B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9554FA0;
	Tue,  9 Apr 2024 03:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EP41+CZk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3A54BCA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634132; cv=fail; b=iFPxtBFE2Sl3O6dR4TbdmYcExsTQH7cryFeJ23p4XmJO9aard+hKczC+bnTg+8kgGFfVcAn9LYD8r32lf90JYQT5M3DHjpCHZcB/utwU+7X4J9CjWt/ezxTKJoxXzj5VEpR3rQ0gar5M/5AhiuqoxF6I0srYbGHtKuQrgUBpUOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634132; c=relaxed/simple;
	bh=SJwG/guKeJ+xDu2jnRzmIhK8/QoLIw7mJyCNROt44q8=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O31pXVFRUOCCY+2N90BKXf+fUVRfS4NoUnP6JuPm0xWKLRpU2+BzA0Lz1PPwCH/8bXFIgDSt1vQUgtd1LlR569WvpcqKEkTqyFTs14ewUl30iaIrL/BdLfAvmIAWLHB4RvnVwwM9atYrdTJe2qAmXOTSXfzDNaahe829YqlP5tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EP41+CZk; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712634131; x=1744170131;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SJwG/guKeJ+xDu2jnRzmIhK8/QoLIw7mJyCNROt44q8=;
  b=EP41+CZkU4jv/xTQzi5oE7PlTT28b6wK8KfkhbyObvwZNGX1qOZrswHt
   NCyISoIlJy8aQRR+PBmnkzhFlLLR6dx/vYup8VIHgGYzSXjM6PX1Qh4u1
   xn8uqw8GJ42Ag51wWC3TJ0OcmUuBxa6RIZy8bdhtHAcjps1CQJuW4mz0K
   ztiI0JBer2OFIwE7+Nln59QJ3I8ncVRDvJv9hSLZ4PsdGzikdiS6Xmbzq
   6qp4co1XVbIbVuRdI7kUVX0Sfep8RCFSo++280eO2+dwnEOiqyJzCRJOY
   znZzDvbvY9ZRMn+FzjDZ8LhHrkZJ76+s+GYJF4kugYWWNoXAWf1XKSi8N
   g==;
X-CSE-ConnectionGUID: Ipdm3W5CTLaoF/n5KbFHDw==
X-CSE-MsgGUID: aUlhtn10RXKBqIUr7DOiww==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11734357"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="11734357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 20:42:11 -0700
X-CSE-ConnectionGUID: xz1/4TcLTkSvZgywhqtKGg==
X-CSE-MsgGUID: prXs5WUkRA6IuZAYO2XojQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="24582089"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 20:42:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:42:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 20:42:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 20:42:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 20:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeETFNiV1O9eJxkYKbu78DnpMBsgzC/Mld7SC2SvprIMMWWLGsAUlCx+bM7ecI1FR4cpRK8pNfiJ5d2XqM3MdftC2zBUpUpPPXAHSdYB6HfjN1AuwPwsEZoiHvMq54+onzCqGsCtPgMKMFiKJnb/iCA/Q3jyo/EStBL6sUTJVhw0CROmEoddwRSb5Wge/PL4TO6zV80VpkkeGDdpNmvfXKZ3LXVXRZdMX+bhX6T3eEL26HZaQx1vQU0q4KEuHb+DPc8TXUpVRf+7tzlm0m0yfIpT2YiCM8k5yk6s1PHUt0RWSJDEXO1xaaEh/VDmfrKDeOruzEiyyC19bcMmrD4iWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/uGM+pr/1gx6JsgeecoyEFaRZ8j7KD76krccmLdeGA=;
 b=aY9ZcfEl2LYaq1m+guAF9sm7M+2iX101wysIEKZ8/hIoX8IEN7CjQ55C6Lv6SOUjKCpBDdxg3AtC3mCCMDHnTzTL34Dlo+V6xA42ZOFUjeHMc8bjxxpoaBYw7PxBESwNnU5Z5kZmVxAQf1oq83XJK8eno4xZX+l+2Zcio00WhIlMNuHwcw3pq53BRvlTcD20OwPTN7EM1lnIcu0tHuR0krOwhpOPYJbG0roYVqBt6+MWS12kUileGfALoo8dBUjL0K/dwc/zTC3YYcUTEp+DglG6SXVtA0erIZRb4CqF1BHcnXqBFF+3oDGvgJCQ5XBPnWjbhhQAEYOaZgzyPgaWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 9 Apr
 2024 03:42:02 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 03:42:02 +0000
Message-ID: <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>
Date: Mon, 8 Apr 2024 20:42:00 -0700
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20240321165106.31602-31-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:303:b4::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gvuylqpfnGRcLIA7cElw+nfHnr8qbu2OJp7XM5REnyiuvgjzgzS1DfH8lUAwKlqJuz6Yl803bAqo4GTjKV9Dv2ilq01D+qAHVubWWozD+xLkuZL1jeWsERipzcUahKShnWHbZi6IKN3apkV6n4KGVNR0F3IlyNLE04oD30v5KfHahCBwxWQ2b2VSbs7Ry87sEmeiZjlaiacxmCmTTLafp2V6qYe44u7Rs30vw3JfSi97EZbwcbrNdKYC4mmHOcVQTbtL7R5+yypzgE//2KfH1OTLtdbgoFoe0TeB1nrux01mnoLzaz63kNWEgInE8oDXNSdC2YTIqTst1cKyaHp5lZO7NDv2ZNsVVKZoixwf6Eesn7/qE6Zokvp6aMP5fNUZwlg43jInCzXV093EAhSR5krdlx4pDWmSoWTTSbnsI5clUxZeMtNTLvLnfYP0niigRtz1qU4KqBsgMSTlsiSKKAGtOJZclDbwymkWbFIzicWxErvEqkr65NB+t1G2QkEDuIFRe0Wv3QAIhKMg+dOn/4+X4kWGO9nkJq/Cm8N9Gbg6U5/fSVwculgHzG1jXqFY76Nt5ZldmJd97vjmA10HlzzOWEVMre7WKaCOrh46S/C6KJHB1kX1JnX7IGPMT6DprUgOPuW/8tEq2cSbjwyrb2tLZvB96KEqaR202elEKRw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUg2dCt5WDRYWEZUSjBUYTgxSkVuS2ZDUzZXbTE0MUxteVVUTTMxdS9ZU2pI?=
 =?utf-8?B?WjJLWXMyeUl6YTdKMFNjNVVmbUNjSmhsUTZubzJpSGxzWmxjYktqQ3BFaHIr?=
 =?utf-8?B?M21CcmcyQ1k2Q29uZVduczNUWTJDTjhRa1lMcHJ1SklkakVwWkZBNWR3QlNB?=
 =?utf-8?B?dWhsenNTSjFzZlFVKzExd0R3NjErQk9wRE8rQ2pkUTRuWStXWS9KbERWcjMr?=
 =?utf-8?B?b0RSUm5nYXJuWkdseXh2azNRamptbm8xUGViSmtRWUtHU04yOXByT2JTTjkr?=
 =?utf-8?B?cVFwU0prTFVzL2JMcDNxaGFpUkRSbFE4Nm9hcy9odGI5QVlrNDZhdU05cFo5?=
 =?utf-8?B?cDZmd01NRk4yeUtOWDRVRDhBZjZOVjF0Rmk3eUdYS3E3bVlUUzhoU3doK0JD?=
 =?utf-8?B?L1BYdjN4Q1p0RG1uMTUxVzBrYzBIN09yVkdFcGQ0VDVWYzlhQ2pyRkdNL3lB?=
 =?utf-8?B?a0lPbS9YZDZOK1hGOER1VXY3cGNuQkdxYklvZWxhbmVVZzRFTnFwQzdyZDNx?=
 =?utf-8?B?Vkl4Rk0rbkk4NHBJVkU4dVJrY3dQMUQvT2JZRzVlRDk5UkxXWm9GU212NEpF?=
 =?utf-8?B?RVRoWEdOTFluVWczU0ZDVERPdm1DeTNvcVVFWkszK2FlR0c1OTBZc1lubnM3?=
 =?utf-8?B?SmNCRGNIV1FxancwdDBsMFQraTVrbGZEVWt2QjlRUnNCeTVGWnpHV0k0UVFs?=
 =?utf-8?B?d2FpWDlOUm9adDZiejlOZ1NWdUtpWmhDV1kvQWJvM3d3SllUczVpSUJHbndB?=
 =?utf-8?B?K0FGcHZKMmtrNkJSOXZEdFY2NS9FbnIzOCtNVDlaTHVIUTJ0eTRhMXMrVThP?=
 =?utf-8?B?RExTYkovWDRxKzg2NjlDdlhkL1ppQ2k5MHMxbUFiRDFyaThUVlgxYVI4cko5?=
 =?utf-8?B?WkJLcVg3K3k5VWJYU2hRKzBXeDAyaW5TY0RTbjMxaDc2bTZWWnJxZXljMnhI?=
 =?utf-8?B?anExdGgrV3gwMkRBUW9hWFlJWWo1QWgxZ1lsSlZsSVp0eFhDQ3EvWHRWVzNT?=
 =?utf-8?B?emtucVRhMWFVVCtTelBHNTZRVnBLa1l4Y2pJaWlzRk5kWE5mVGFKaWtnWUk1?=
 =?utf-8?B?Y2hCMHU4bEl6TExjcEg3RExmM1dJa1h3LzUyKzZOZ0Z2cnQwUFhkeitDOENt?=
 =?utf-8?B?U1lOM0hSVnBTQlEzRzlVV2w1ckl0OWJDWndzaWUyTktVT3FqRWhIRkUxZ2Nx?=
 =?utf-8?B?eE84VUk5MDA0WTFxaDRSZXoyNy85ckw0djZ3c2YzQkZMa1VoWTJaeldLbmVE?=
 =?utf-8?B?U2h2SzdFbFAxWEhLYjhCM2JsaVlhYVQxTkcvR3RlSmhhS0RCZGxEVE9sZk93?=
 =?utf-8?B?YnFXOXpwN1VGRVVYb3lDdjA2eVhXblQ5WWpzdTIzT2Zxa09YckMyUmRVeUJT?=
 =?utf-8?B?L1E1UVpiWHhoMnpMQUVZSWlxc1RXQURZS0RrT2JJQ1hqRzlrb0YvbktvMDlY?=
 =?utf-8?B?TExENEZ3aDVwcGk2OGVTNHpoYXJib3BpelkyY2lkT0orTWNBWHdQM2hTdW53?=
 =?utf-8?B?RXArd0Y4TVJHcU1Ka2lkZXMxUGQvWE1rTDVRY3RFczBNUUUrcHNNLzRxVTNU?=
 =?utf-8?B?RkpIUXNlUzVmYjlYcG82WnF2ZGp3SFJHbW5oNzF2T1didkd1RXdHdVpkTEJE?=
 =?utf-8?B?Q3ljSStTdGxZWXo4eWppTFBrRWxHeXRxL2ZIalhtYXNZRGxaZE5lMWdPSEc5?=
 =?utf-8?B?SWExSitmbERVVGlMczlTN2U4d2hFYTRnbnplMmRXVXZQZW5mTG11RW1HZlN4?=
 =?utf-8?B?elROZ3FBcVhhN2ozU2lwUEgzOHg2VlYvQjcvY0hNaVV6U0NBall4UG1FQTZ1?=
 =?utf-8?B?T0dMajFkblN1ZlQwaTVERTdYb1B4c2lDZlpGdWR0Yms2SXVieUdQWHF3WXZn?=
 =?utf-8?B?STZ6djBKWFZ3Y2RvaHZwclhVR29PSG01aFN0WVU0a0MrUG9TOFVZbVlSYXV6?=
 =?utf-8?B?UHBMSGNCSlhORFZWTHNBWm9jdSt6cjhnd09xTDBBM0xaajUrb1BSYks5UEVH?=
 =?utf-8?B?K3RONTg3TFhHT1Q5SUo5NUVicU9zQmlJMSs5c3ArZ0xsSUd3dnRVU0ZvU2Zq?=
 =?utf-8?B?d2w0WEhRamprWUNmc2tmclRtUUh2MFh6TVBHMXJ6b0lKeXYvdTJlbjRER0tk?=
 =?utf-8?B?QWpUWnU4TWVaN3lDUHhzL1hDS3VLQVBwYXlINHlnWVZwK2h0YStJdnlFdEJN?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 638337d3-ed0e-4f29-3703-08dc58470484
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 03:42:02.2548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5Mng5O6NnHRI9QVOTnE1yNcf4Qlt0Jt1MSIuRJOMO45m1KKj62/Ht3XeO4y6hzr/mYUVZebGBmiuXZRYzIyX+hlmDFkPdONzwkYpdtLX94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com

Hi James,

On 3/21/2024 9:51 AM, James Morse wrote:
..
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> index 4788bd95dac6..fe0b10b589c0 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -7,6 +7,36 @@
>  #ifndef __LINUX_RESCTRL_TYPES_H
>  #define __LINUX_RESCTRL_TYPES_H
>  
> +#define CQM_LIMBOCHECK_INTERVAL	1000
> +
> +#define MBM_CNTR_WIDTH_BASE		24
> +#define MBM_OVERFLOW_INTERVAL		1000
> +#define MAX_MBA_BW			100u
> +#define MBA_IS_LINEAR			0x4
> +
> +/* rdtgroup.flags */
> +#define	RDT_DELETED		1
> +
> +/* rftype.flags */
> +#define RFTYPE_FLAGS_CPUS_LIST	1
> +
> +/*
> + * Define the file type flags for base and info directories.
> + */
> +#define RFTYPE_INFO			BIT(0)
> +#define RFTYPE_BASE			BIT(1)
> +#define RFTYPE_CTRL			BIT(4)
> +#define RFTYPE_MON			BIT(5)
> +#define RFTYPE_TOP			BIT(6)
> +#define RFTYPE_RES_CACHE		BIT(8)
> +#define RFTYPE_RES_MB			BIT(9)
> +#define RFTYPE_DEBUG			BIT(10)
> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
> +
>  /* Reads to Local DRAM Memory */
>  #define READS_TO_LOCAL_MEM		BIT(0)
>  

Not all these new seem to belong in this file. Could you please confirm?

For example:
Earlier in series it was mentioned that struct rdtgroup is private to the
fs so having RDT_DELETED is unexpected as it implies access to struct rdtgroup.

CQM_LIMBOCHECK_INTERVAL seems private to the fs code, so too
RFTYPE_FLAGS_CPUS_LIST.

Reinette

