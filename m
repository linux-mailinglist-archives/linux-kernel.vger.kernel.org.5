Return-Path: <linux-kernel+bounces-132833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76B2899AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFCE2864E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E84415FA6F;
	Fri,  5 Apr 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATlOi2NK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A81D69B;
	Fri,  5 Apr 2024 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313192; cv=fail; b=Da9Xdze2HnMC2HY+gyvhNh8YtpHrisAnlbLyC9KrrKrR0QGwbLECbfGk9XFK+7IS6AhNOJ2UMZfY79GCkUJW7uAL15Cs2sKYeyXuMzBY4PdE1WJgi/5vs+jhh3jhHcj7Yvl5VbXSMt4XoYE0o0Dxlwr9riBEInaG0+NskXErm4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313192; c=relaxed/simple;
	bh=O/XRHVWA1qtz5Clwi8vv1le4Z6w0GyN3nFkNTtp55U4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tEaAvUPA5DZWrL24MbdC6AKc8XxSTGCsYciDLGjEEBJUci4XE0WGU0mQ6/LC+j9zBLjvAQjHwMBZ9mNejDi66glVmw67TaFNPLsHh1Zya/j7lv7FmO73nq+W4wQEiwIrnie5wwaBkyBS6duKoTTgxNkojhmFZ/imf1oSVzB1arc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATlOi2NK; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712313189; x=1743849189;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O/XRHVWA1qtz5Clwi8vv1le4Z6w0GyN3nFkNTtp55U4=;
  b=ATlOi2NKjGneXsFkH8EA04mrDYKV7xwQr7ohae1v/JDwPbwbejvQonH/
   pp2zmbvg4w3o0WeANh8fWBK4yMgqcsXqSZtA77IKalCsnW/u12Cj7+5lb
   UyBuexZVKbX+PHpgtJL/qwsoRhl5h2LIUvX/9t0Qe4qudFkY5pVJGr1KL
   OCYagM8XNFCKaXc1sHxP1XmRevBOFYKJvOITANyrFOqsMNssBSEzoQS2m
   xbx0bg8c/VkDQd+018Gps6hO1LFg0XkFcyBqi/S+w14NxN2OHcbUB5IUA
   DFa28jT2VNKX1Z3g1wLnsNWGOmt046+4Me+JeFgPckOJKPpg/CQJxRBV7
   Q==;
X-CSE-ConnectionGUID: feNIE2B9S+eAJO2KQoJzfA==
X-CSE-MsgGUID: 2GHTTbwoRMGsvbrFTdcoiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7482314"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7482314"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:33:09 -0700
X-CSE-ConnectionGUID: bG3PPeqSSA67GPqmdxnekA==
X-CSE-MsgGUID: vGtquPqWRt2qYLRPiIiByw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="23593634"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Apr 2024 03:33:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 03:33:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 03:33:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Apr 2024 03:33:07 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Apr 2024 03:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzRuSX03pQhqkS3pcGJh/rANX6pUeFv0tWwMfRlEeSkh05mRe6hBsWOaGr9ejkegaG7mJOWD9yS3A1+NUXjkHw5euoTRn1yFeWGomSF913YmiJ5f4tnNdcS8HmqXc7y1UOkc1tW3ctwNdyYAqp3BsD58vn9bUSFyApsyTuea/IIyuDd3wB82dge8el0OsxR2AvzxlbFNfCMUz5MtDF3n8iiRXp46lp6m0vsjZVwLmJc9nvj+7n6CiQ9OMclhRkbXVCJBfObcx7PGgCdJgFYMegaH+NKPVsXrTYUBg01O8/FaqOl7wPc6QCw4OYno09ARaHuJUwx0k5i9CyeHz7x/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHJq7cgFjMXn5d9VlWjFL5c3EDjnZN/xA3r+uAqrJNw=;
 b=NoTEq7KEG8VaBI8SDEhtIbrT8MeQ6UWyEL1BKSHX7fyplUdRWGsIWa4mz0RxPjtUYSW2rwe0zokDAGEUzquj2+3QErK5V/cIVjO7xegL8nrZHN1jer7bAuzUNWC3o0jxR2zLF0RdBsiwzncYK647A1gauyYbq3AG+czS7kPr6EIIR9uEftuQNonTeqcOUMCGV+QheCPLrNvZp9QNrZ2XHq9iE3z8kxUDC3xnqUFF3Wyd3XUcQEX/0dSV7JCRaCfOHmv0oYhIzFNBQzQelHZ6atFsPaAWmf2zRj6Tgzrs50n2ZCMf6xTVEjD1n+BJYVLno6Ua1SHbkSCAIp/CAj7bYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CYXPR11MB8662.namprd11.prod.outlook.com (2603:10b6:930:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 10:33:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 10:33:00 +0000
Message-ID: <45eb2bf1-e7b0-4045-82b3-93b9f81b7988@intel.com>
Date: Fri, 5 Apr 2024 12:32:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 7/9] libeth: add Rx buffer management
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
 <20240404154402.3581254-8-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240404154402.3581254-8-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0313.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CYXPR11MB8662:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAcOweLQl8CNAodVrTIAHOaqxfo4CN11YcvsZIdTR0eorFewHtmnvo/+Boh1dmDovJE1J4EAwRD7RxHVEw5Q6RWVTX0hL0zk2iXYlUCSKMFhaLs8hUp8gHoxSo7iNYyXj9kfz8vzj9UBHdLZhr2VUVd3eSIGrXtSHKYWBzOQ1xXZnQMfHGrjGQaQ5LDpSv+DJG/ZIfcqGQ23Bztw8Uc9KTxPvHoCqlic+SmtXLSzkcatScP6lJCed3Q64qG71UErvRWi1ZDJjkbTxxswn0kD+Bax4AD2BAfz9tPH9RggB3qQx8gr7DGikqi4XodHZr8RwDyjnrqzpU9Tv4WTyhtbJ0XhTrmOPfmS0TjV3Vs8s4L+AgNd6Lik4/TL7+JROkFM4RgLcfjIyikO/4z9d6Op60UTQXtrYstAUz7wp8XzWMvfqB8ZXE3EEVioXA6RdIFoItGoTebjn5zAlPIOCmyO68x8Vo4PwvxG048Y8tQUwyRXUOh23JSN6UbFCi4LqnZ/MvfTUFrLyL89sbXVti9Gm4MFSdtYtHYEc6j0F2ybEQ0PliEdxDWjSbMI5cBkpher49mKcQykIbntnQpj+gnRSN2heBzLvXDwpSJidu460oku2ahE91RGFYSC3f1PdktxXOQUy835K/Z/IGSdYDW7IWZ+0E5oCALpKCLXt9YWzUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFSZ3ZhNHFwb3piaDBhdWtLWkxOdTd4d3BLaWdocjl6Z3VQRlBUUlEzemtR?=
 =?utf-8?B?VWJXVElFd2g2Sndpa1NCU0VrQ1NzbThERmtFZnVPWFFlMG9naHFldzNJOUdC?=
 =?utf-8?B?VHlvb2xQVTBJYms5Skd0RUxLUlVqcjdxNExuYTNnNzBrNzFNKzlRckJ1eThW?=
 =?utf-8?B?Mk9ERzg1QWpuYzhuYnlhcitSZ1pvemkwSjhCUm1uM2tVMzFtWmRPdU5XNVgv?=
 =?utf-8?B?bHJra1VkUVJ1WDk2eGxLVHNySjZ5bVlhS3p2MWVzcllsM0pwdm9Ec2lPNDVU?=
 =?utf-8?B?YjFKcGQxMkwwVlFiVnZQZUxudHBPTzRGSUptejRJOHYvTjl5QllzVXJzdVFl?=
 =?utf-8?B?bU5NbUc4MDBoV1VZTTMrWW9oeW8xR0dnY2J6SU1MTVJUR3lwb2tUT05LUjR6?=
 =?utf-8?B?SXpnOGRZdDgyU28rWENLOTFGTzZreWV1eE9nR0lvK2dVWTVaUE94TkJra3Rl?=
 =?utf-8?B?MFlsQzlUd09vRjRBZUlob3hmZEVlVEIyZVFBOXFRQjAyN1Q5SEpkOUgxa3Js?=
 =?utf-8?B?KzZ4ZmoreGh0V3RvZHhxSGtHU3R2S3Q3dnlBcGhML0NIRFBBNE9jekRlOU1Y?=
 =?utf-8?B?Q1QvUnUrQ3E5alNoVm9RTm9rR2Y0MVJXMTRvbkowTEtRcTV0SUVzTTd1VUM4?=
 =?utf-8?B?KzFzcnI4SEx0VEpJVDRZNXd5RkV3cnphajlqZ2Y1cTh6a3JSeUdmaUVyakxC?=
 =?utf-8?B?RWh6cTNaVkhOeEtLK2R2MEpTQWxGWW01dFJnOWxMYjJyeTZiUFFxYkU1dkJR?=
 =?utf-8?B?WDJXUEtXdWlLOFJGNGExaVJ6Q0xjTXNPU3BZc2R4VjdrUnFHSlp5VGFiNXcw?=
 =?utf-8?B?WkdOTjhGTzZudDIrYjVRUm1mM2NmTnNtLzZlb2pXaTBQME84UmpISGN4N0pq?=
 =?utf-8?B?NnVrU0tBK05yS1ZkQmE3YnRzdUZCQyt5NTFkWTdld0txOCtydTRSWlppWEFL?=
 =?utf-8?B?M1BjKy9aOXVySXlOQlZoT1hhYXNNc09Cb3N4R1VXRjg0bWo2Y0MvZnMzcmFD?=
 =?utf-8?B?SG9TQ3JVT1pET3NEbk00SGQxTnAvWCtmWWxNTndaSzNOcldmdW5BWXl4T3dB?=
 =?utf-8?B?Q1BCVjBvQ3d6aGZKZWQ5OGVTeHVnQi8zWktWK1dwNzlDNHFzaUJTdkltclNa?=
 =?utf-8?B?ZFE5dlZmeWJ1TXJVNktYZFpPK0xEcXh1NEdpL3prK2cwdS9UdDBFUGJvTk04?=
 =?utf-8?B?WWtMVm82NVRxNWhEM3pKYThNUGdtdG44WW1ESTF0cGlUTVd0ODliUHhvNHNu?=
 =?utf-8?B?OFNLcG44V0pUSGJybkN2ZzdUVERvMTBLQ2tjdHdkVmZQSW5CMUFENC9SMjlx?=
 =?utf-8?B?Ynlub2dYMnA3dzVQbGNxYy95RlZqSnFFc051dmRLSTBtWENMN1Q5MjdLZ0tx?=
 =?utf-8?B?UndBR0RWejUxNWl6VTg4ZENCQnRrMXN4SVYvd3UyWURoRFQwdElRQ3dEMDBs?=
 =?utf-8?B?dUVHR3Q5U3RBRlo4K2N4UmlvcGNDQk1udzhGOFFpY0xMQXA5Q01ZNlF2WURJ?=
 =?utf-8?B?V3JvUGRpYUJJWWFZZ25raTkvK1djWEx3UVVoMnBZQXVqN1BXR09FWkRGUXFH?=
 =?utf-8?B?VTc0bkZZYVY5eXJmQ0YzZnVuRTI2QmFtUXhGcnI1Y1V4aFd5a2swYUsvYXVC?=
 =?utf-8?B?b2k1RkVRZzdFMjlFS2F1NnN0RXdPNFR6dVFFNDBpbldPbTVYTE4xVk9BeG5j?=
 =?utf-8?B?V3VzTHBqbUgyajdYMkxkOEo3aXFKU1RqWmJxTG1Cc1lJNktTL2FOVnc5S3pM?=
 =?utf-8?B?RldUdDdpWGpkNkJ4SE53eFhnVTVtYTltdzVXK3d2azNMOWpEajNqMTBOKytC?=
 =?utf-8?B?ME1DL0txRWV0Q0JMV3pOMUZUazRCdHMvb2owaWRDdU5ubHJ4ZlZDVWlaRmJ1?=
 =?utf-8?B?QkZzcWc2SWhyMjNjWExuUWVmeFZPU2ZZR21nYkRhaVk3TkRZNUswZEZSekw0?=
 =?utf-8?B?VjdvZ2czbVVleDRqNVVRYk50M1JIQnh1RGo4SHM1cWYrVjRHdis3WUVSczlq?=
 =?utf-8?B?dnlFWm96WlRZME5sNCtSdHlObHBEcjE2TUpXNlpVT0tPUEhkcGVOdHhlUFEz?=
 =?utf-8?B?VGE2SHA0OS9yVnlEMllXcjkrMjVVVllYY0lXTzYralU5R1RENDZKOStZWk5B?=
 =?utf-8?B?QmFQaFdBbzRtTFlNRFJTR1cvVGxZWERhUEdmQThvTEhMbklGdzdLSDZra0Vk?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af062ad-526f-49e4-c7fb-08dc555bc463
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 10:33:00.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGKESn/lpiroR7xcpBtALyEOnhzU8HHw+gy7Ab5Oi9FPESE+Cu6U7q/uvwlhzMSA/zouKQEJi0BYJQtiBLSnAaNkjnMXRkixTJxkaMWuV40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8662
X-OriginatorOrg: intel.com

On 4/4/24 17:44, Alexander Lobakin wrote:
> Add a couple intuitive helpers to hide Rx buffer implementation details
> in the library and not multiplicate it between drivers. The settings are
> sorta optimized for 100G+ NICs, but nothing really HW-specific here.
> Use the new page_pool_dev_alloc() to dynamically switch between
> split-page and full-page modes depending on MTU, page size, required
> headroom etc. For example, on x86_64 with the default driver settings
> each page is shared between 2 buffers. Turning on XDP (not in this
> series) -> increasing headroom requirement pushes truesize out of 2048
> boundary, leading to that each buffer starts getting a full page.
> The "ceiling" limit is %PAGE_SIZE, as only order-0 pages are used to
> avoid compound overhead. For the above architecture, this means maximum
> linear frame size of 3712 w/o XDP.
> Not that &libeth_buf_queue is not a complete queue/ring structure for
> now, rather a shim, but eventually the libeth-enabled drivers will move
> to it, with iavf being the first one.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   drivers/net/ethernet/intel/libeth/Kconfig |   1 +
>   include/net/libeth/rx.h                   | 117 ++++++++++++++++++++++
>   drivers/net/ethernet/intel/libeth/rx.c    |  98 ++++++++++++++++++
>   3 files changed, 216 insertions(+)
>
[...]

> +/**
> + * struct libeth_fqe - structure representing an Rx buffer
> + * @page: page holding the buffer
> + * @offset: offset from the page start (to the headroom)
> + * @truesize: total space occupied by the buffer (w/ headroom and tailroom)
> + *
> + * Depending on the MTU, API switches between one-page-per-frame and shared
> + * page model (to conserve memory on bigger-page platforms). In case of the
> + * former, @offset is always 0 and @truesize is always ```PAGE_SIZE```.
> + */
> +struct libeth_fqe {
> +	struct page		*page;
> +	u32			offset;
> +	u32			truesize;
> +} __aligned_largest;
> +
> +/**
> + * struct libeth_fq - structure representing a buffer queue
> + * @fp: hotpath part of the structure
> + * @pp: &page_pool for buffer management
> + * @fqes: array of Rx buffers
> + * @truesize: size to allocate per buffer, w/overhead
> + * @count: number of descriptors/buffers the queue has
> + * @buf_len: HW-writeable length per each buffer
> + * @nid: ID of the closest NUMA node with memory
> + */
> +struct libeth_fq {
> +	struct_group_tagged(libeth_fq_fp, fp,
> +		struct page_pool	*pp;
> +		struct libeth_fqe	*fqes;
> +
> +		u32			truesize;
> +		u32			count;
> +	);
> +
> +	/* Cold fields */
> +	u32			buf_len;
> +	int			nid;
> +};

[...]

Could you please unpack the meaning of `fq` and `fqe` acronyms here?

otherwise the whole series is very good for me, thank you very much!


