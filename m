Return-Path: <linux-kernel+bounces-143259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025938A3664
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC078285CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B853150980;
	Fri, 12 Apr 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bcju8Y4d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66CD14F9E9;
	Fri, 12 Apr 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950273; cv=fail; b=RvAsSn16dC4PD7tcsF8gTVXQ9Xo/BVuz0VQIMi8zS2gScGbrKUhiq+XiJPbkp1xX+A9QSR+mcUtEIWiKDbZhVHLcAo6zwTM/ymFKONxIkmWs6T3xHilRHOOJHXGG9VOupREUyQaEX+PPLCFQy11udUeQmMEj7UMMPZi8G2MA+Rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950273; c=relaxed/simple;
	bh=c5q1knspANiwJic+SwJAaqqIHfKhGlm8ZU+KSKordsY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q1QJZeIcOjZ5VLK2T6xZ6bNDfzFUHw/VJVQ1VJL5ZlqrfXshA5aLtuzLOkFPlnBG3Bi/Zr7YoEx8QdRqE90rhcDbstFpeepuwgBgwUG7qUD3XnEjOXTYSwEg1Y81VHl87Ygr9mjh2dQ+2EsrEqdCQ0iLZVrO+MuNtXLlj+Sgtlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bcju8Y4d; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712950273; x=1744486273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c5q1knspANiwJic+SwJAaqqIHfKhGlm8ZU+KSKordsY=;
  b=Bcju8Y4dODwVeFg8YnKCcp3aePjaetIoezDwVZkHh7f1/+OhGiXN851+
   CyuOUY1Ydu3QMROfeXsKDtHyKasv9X+34XH87pGZN5ta9WHlSJvQOCIcH
   /D90oHmNZIajtblgnXAjNzrxln9IvjSC6/sogt0CzYBLWZktjuHC6A5IN
   VPeL8ymSLW+5Z+fUKvsboGDBZbXtSVRMl8ICPDKW0eWnWigkSv6ffLTXP
   Hf4UGzsw4xx5dAzWCxBH7EzT9G+Vi+9HSUaLBGzBgkdwZaYhkIvSUMTvS
   /OB5PxIRyxUzsWgpffUKaIxubcCoJWYdcJtv3QSUt2+38Tzg800s6bwN0
   w==;
X-CSE-ConnectionGUID: f6vkKY6wQl+uALNgzf5v7Q==
X-CSE-MsgGUID: o4X4EHOUSq+QVtyZxHjaPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="30900810"
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="30900810"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 12:31:12 -0700
X-CSE-ConnectionGUID: 0pYyvVOWRJqzLme9eJpEjw==
X-CSE-MsgGUID: Ee7ydcryRFWfhTQJOkXfpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,197,1708416000"; 
   d="scan'208";a="52466768"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Apr 2024 12:31:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 12:31:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Apr 2024 12:31:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 12:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTFD5mxLGderfFnk+rTQbId7YmiuqHHzqeN0vqqMei1MU6i4kGHSujEk+tfhsDWC/JoDp6ja8GMaPIvWa6tNhP5JTrwRxaOjsqSkStzF0iZEOQ7yXyrRGyo0GC+bdrtmAS6fqsNfSM7X9qkywyFBYJWrUMG1GiqjhW/0IR2hmcwGafXkGs4Mb/DVXSETwexw6+FspaMo4tlnN96p1J7rH2Tb2E0YJE0dHmnucPHEr1CYLBkb9JxwPkE2CSR50Sv+qXsOL4vU6oqdmcyE7gB3CO7iFq7rODzArWABZUmGQbqxQB040eJCr96geVOXHayERDSyMPgDkDGArfdmBUuAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE44H//Res7/+3p2fv4LfQAV4NFBko3hxPOb5FcOb2s=;
 b=A9frBxY0+V7Z0cJWcN/8f6b5/hFVBtvdU0T6bSJPgGC4eYh0hx3p4uhUHMBiVzyrgdgh7NdKGGXSO9HQB6J1PAFWFZ8CVIDHHKjbCPiMbGvhVTPLy8Ok2r12c1qzveIkxrhEBDRSuE0mH21VDUvx+/MhzUEsywsmJnXh+xhg/pvagvfbkUf/JsGpRn/1YYNwDqS15/TMHfFZzGzXmOD3fZfo2pnG2gCkpkiHOhG5ryVXaMS4PXLlSzrO+SuUQkYHDNTeyGCcO9ADUr3gAo0oEhxsEZBxd0T3KriHgR1SLJa0fQ4kyF4BYhGRiBSbhmA+ju76YgpfcjwmGXhHOOxmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by MW4PR11MB6862.namprd11.prod.outlook.com (2603:10b6:303:220::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Fri, 12 Apr
 2024 19:31:07 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%5]) with mapi id 15.20.7472.025; Fri, 12 Apr 2024
 19:31:04 +0000
Message-ID: <57c32cfd-136d-4c72-9f4d-12599b508fb8@intel.com>
Date: Fri, 12 Apr 2024 12:31:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/intel/ifs: Classify error scenarios
 correctly
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<ilpo.jarvinen@linux.intel.com>, <hdegoede@redhat.com>,
	<markgross@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	<ashok.raj@intel.com>, <tony.luck@intel.com>, <rostedt@goodmis.org>,
	<ravi.v.shankar@intel.com>, <patches@lists.linux.dev>
References: <20240412172349.544064-1-jithu.joseph@intel.com>
 <20240412172349.544064-2-jithu.joseph@intel.com>
 <69d360fc-85e4-4a6d-8f08-9f90dd7ec583@linux.intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <69d360fc-85e4-4a6d-8f08-9f90dd7ec583@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|MW4PR11MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: c418ec49-a00d-4cc6-2164-08dc5b27181e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUcF8zOEvpATKNqqFXS9BZ8qUePyWf25d0tkx68Bb5bg1O0OI2Odq/SeONoucQqPVt7cithHhDY3v+1PhIAVvEEMBX5MURzm7FGTcL8/at4TNG/gf3ruxcpU8MxzKLzYp6BIx0MhEOg8ZOVNEvO0olWrQhMjOFsoy7DoRK+Cxd7Qb2gkpGfg3MNOo3KGxv5zp/uxD65ZNeZhaRMwGLLwYisdobZ/wGoqgNGTLuWojIwerMl6Vx2TDDywSYlVUOXkcFnecMU86bUs2PS7gqojxnD+TMeLGh6oxqEWJI9ZzQDEpkpNucrnYUZSH5NCD7SRQaozlmfVasXbLJElP/1mjCLKBzE+jbVf8U10QplmQTrJ2dukpceadWotuO+pDYzofqNf5OmF0g+qexAIybgXDQtjwBh1jC9x7zHEsh43jAISfqEg6mqgY3ldQEPWXZkZpr3JQQJno86lUnN0ydd0woXMgDC94Uum4R34HBOEIgUhUWh92aOkQtB9qkMkUCdllPYpyBxo28hik5ZOzHY/lpKOaoRTA8VTak2RfsCKGwivF22duvjzdnjIGj7WuvO8/D+4IAj4nQ1pIbXFcZwFzuumVgXmFl/KMcLCLRAPQ5Pefl+HOlEC8gpbyZwjoV9qBdsckd7ETKTcDN8plHZAuxxHQ+TksF23lMnUKRgYpd4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW51eENZSWRyYzcrMXBwUnUrOHFLRi92WDdsN0N0TmtQdzlHZ1N6bDVUZ3hE?=
 =?utf-8?B?dENxR2tuSmhYZFE1MTdOWmFLcUVDMU5IaTloNXpmb1lSNTExOVI3Q3ByZ3lP?=
 =?utf-8?B?eFJhQWdFNWtDb2NsM202RFdYWmd0VVBtRWQ4dTVUcFA4cTkrK2orRnVpZExp?=
 =?utf-8?B?bFNPNGw0UVAyOHNvQ0tZMVpZTnFpUmNRNjM3SXMzU2xhUU4zdFRZZ0REZ1A1?=
 =?utf-8?B?SFFwaTFiQ0pnYVppbWtUZU9CV3VrbENoZ1o0NDBvd09Oa3VpaGFCR1B6TTl3?=
 =?utf-8?B?M3k3OTh3NUFrZUVvUXBGTUhMRTRENVBQbitrZ2RYV2FaZ1dhRDFxTEJlUzRq?=
 =?utf-8?B?dDRkelEralRnSEJSMDhIVHY2TWg3aVpyMVdUQ2Y1MllDbkNzR2lOdWVXYk0v?=
 =?utf-8?B?NXllTGxKME1GYzI5R0g0SUk1Y0xqRTBEclpOYk5vR3hDVWxIbjkyWkFzd3o2?=
 =?utf-8?B?Y05XTzNEeWFwdWUyWUVOdytPTE1WSGpoZ1lFaS85VVpOSTdnNk1JbGdMbjhM?=
 =?utf-8?B?WFJ2b3JCeUhpTGZsV1dNbW9ZaWlVV3ZmaVR4cmpkZjEzWmlSb21id3ZGQ3Fh?=
 =?utf-8?B?QTBTWmEvRUxWR1o4VnlsdVNBSzlDK0NVZnBvak9ZYVNsSzNpWEgzWUIrOWgz?=
 =?utf-8?B?UURVTyt4cVA5ai9xWTUzeUNjRlRkdWxMb3BuTnFUK21DZjhONXptYUJlOVpw?=
 =?utf-8?B?REdHdG5FeTROYkhnNHBwTUJXVlEzWURlbDF5eEhMR1Vycng1T0luYk56RW4w?=
 =?utf-8?B?a1ljQVBTRFNKcVVVQ0hHL3ZDWjNlK3oxSkRmdjlsWFBPei80TVQyU2dWcSs1?=
 =?utf-8?B?WjJSOGNISXFHcU44Y2JBcDUzcU9TOE5xUkUyRnVTR243NmtKZXl4MmpVL3Vz?=
 =?utf-8?B?enNaNlJkSGpxRjg4b05ZNlRlaTFCUGlGeGNtY2o1TFcrSlZ3RG5CdVRDd2pt?=
 =?utf-8?B?UGs2cXMzSUI0YVlkb21PcUp4R0ZpSUxhV2NIUTZmWVIreHVGL2l1Y0xMV1Fz?=
 =?utf-8?B?STVJU1Y1TjF2RWtyWEdvV2hhalNKUDJtQTg3ak50djlvbHRNcFUvTUdieTB1?=
 =?utf-8?B?UGVTaytBWkpxRGJRbW40dHBod2NGMHduaWhkOFVLaDlKVmQzd3hYckEvN0kr?=
 =?utf-8?B?Rm0ySCt1TXRnb3lKa2F3OUd1NGRpMXJvZTl5bDZDdnB2QitkUVFzT3dRby9K?=
 =?utf-8?B?cTJYVzZONlZJa0Z4eng2VDErZVZraGRaN0tFYkt5UlV2VnVjRTBVUjdDSndV?=
 =?utf-8?B?Q0pIY2YvZFdzVVpEVUZqOFk1Y2VCQmw1c3E2WmxKWVhsM1M2dWVoYzdkMG1k?=
 =?utf-8?B?aWI4OTlBTDJxYUVyd0FMenEybURvRmFYaWxEeHp6UlpMQTZYMTlXc2pqa2Rk?=
 =?utf-8?B?YXZUWE5FSUsrMHFWN1M2ZmRyVEVrOGZDSGRFVDBGSSt5aTZkQ1htdCtBWmJQ?=
 =?utf-8?B?RjJVL2YyYlJSVE5PNzc5ZFdDczRpWUxTeHV1STdWRjBwdDVtM3k3Qkd5UGpG?=
 =?utf-8?B?enJLYzRNb1JVYmd3dFJkam5kZ3BxNGNFZ0RvdGU5dXE2eWMrRmNJWGNSWXVz?=
 =?utf-8?B?Ni9vaXNpYTl4UFNYUThZRlJnaXZyTkJhYmdheW9EaVh3aTRMZUVkTERDTklI?=
 =?utf-8?B?RlhGQVZOOWJPQkkvSWF6dnBTb3ZDUlFOZS9qeXNKclp0Z0krQWVTblVOL0FU?=
 =?utf-8?B?ajJOYkE5djd0aTVvdFJjdTNycStXa3hPZ1IyVE5teENvY0xDS0lPNXA0Q3Rj?=
 =?utf-8?B?Q3kveElyd1ppZXNhTUY3VE53bHp3bU50QTNwdW9kRTRqb1h3R0VMZEU1dWJ3?=
 =?utf-8?B?K2xUNkJiQ2xyYmJQL2N4WWR1QjhVdFZTcWl3UFhBbk0rOEd2MmVQUEU1aElI?=
 =?utf-8?B?TCtmSEhuc05sbEdrNkVOcFh0QWdHb0R0VkI1ZWV0YVZWN2RJZllxWk1ERlVG?=
 =?utf-8?B?YWdHYTZ1K0Q5OVpXR0xQSkg3bzdTdHVwbU1KRXJrZkpqMlJQUG9lTDlURnpy?=
 =?utf-8?B?d2lFVEF6TGNDZHRvazloTkxhbHFWblRraEFaQ0JwWWtIRWYyMS9qRmYya1g0?=
 =?utf-8?B?UkI0M2ZxTXIwTnI2M3ZUU3NhR095eTd5WlkyQVllUzR1MjRXa2NHTVI5WjZ5?=
 =?utf-8?B?blF2Zkdudlpyais0WmFiZU81UGl2SjlpK2FOTTd6RXNqTHd1U2xJbXI2Rm5m?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c418ec49-a00d-4cc6-2164-08dc5b27181e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 19:31:04.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApB/IWHGac1IAKIJLmZfNw8Jg1Zj7RGCY3CJxUFxgBHRmf2QdYZ9UM7Ps/gqaIiIwqANustGnlStTkOXE7+jVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6862
X-OriginatorOrg: intel.com

Sathya,

Thanks for reviewing this

On 4/12/2024 11:32 AM, Kuppuswamy Sathyanarayanan wrote:
> 
> On 4/12/24 10:23 AM, Jithu Joseph wrote:
>> Based on inputs from hardware architects, only "scan signature failures"
>> should be treated as actual hardware/cpu failure.
> 
> Instead of just saying input from hardware architects, it would be better
> if you mention the rationale behind it.

I can reword the first para as below:

"Scan controller error" means that scan hardware encountered an error
prior to doing an actual test on the target CPU. It does not mean that
there is an actual cpu/core failure. "scan signature failure" indicates
that the test result on the target core did not match the expected value
and should be treated as a cpu failure.

Current driver classifies both these scenarios as failures. Modify ...

> 
>> Current driver, in addition, classifies "scan controller error" scenario
>> too as a hardware/cpu failure. Modify the driver to classify this situation
>> with a more appropriate "untested" status instead of "fail" status.
>>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewe
> 
> Code wise it looks good to me.
> 
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 


Jithu

