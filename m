Return-Path: <linux-kernel+bounces-155646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C58448AF529
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35B4B231BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F4113D8BB;
	Tue, 23 Apr 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPein4aq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B013D508;
	Tue, 23 Apr 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892393; cv=fail; b=AGajTwNAKmjzt5UnG5yVU6OPb6qRCBy3uNbwcrSkvF5FlKviO/5sGTHexh1MPy82QwtgXwELcrrFowwpsDMI4A7jjP5MkkpEy0R+PdS8G+WO6/qS61A8u83t/pz7y2FhyM7p1IQFCV3Y8PgLddRRkH+Au3TYwOXlBvuBNQAyQ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892393; c=relaxed/simple;
	bh=UbRxHaIK828I3n/+Bz6o+UoA5+G+8GglaQECx1llJr8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AIqX2Btu8YOe86KPji66jzonFQ8Zs56cC03dB/VHEXmuWzT1ouC3n2Jk+QzzudtCOiNfns6MJsBEymczB2xx1C+yu6CQdHAPcFsF/HEhV7vlGARQBNt+MkQM2P/G9pSUzPoVBGTXJ+O9MJ1wo6axXXwVm6GJ1Es/UZTOVW3uR4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPein4aq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713892392; x=1745428392;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UbRxHaIK828I3n/+Bz6o+UoA5+G+8GglaQECx1llJr8=;
  b=KPein4aqha5ArwPcp1+PSpWDgIODdoiMcjBWqmwwyT04Qm1mPdDAVwb5
   RpMMJRdAFz+EJ53eKD6aq6WbXP0so7H4mfnLRquktix4ApUSChgxZIgAR
   RFLB0xTBDI1FjTBerLEGxJw9HGPXPm0ze4cBhGY8vMGdm2UhgF1WL+8xf
   XwbXzDuiol6mJ0TRh4V1iXY0tjwQXWQ29x88IuiNih3McB6Fev+0cvMfc
   FQOgFP5rhuTyPu+7EhcptaWUZk6kuXhV29Gj/zPHN28w8zqEMs+rh4yv7
   nHkUr9ovKUlFiHx8ZaMW1cG0BL94IXEmgSlf40RRSWYcHgldH4gMcKN/W
   Q==;
X-CSE-ConnectionGUID: QpHxFdb7Rk2sayb3tz+uug==
X-CSE-MsgGUID: ucNoW7YqQmSh26sUaK8B2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="10034447"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="10034447"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 10:13:10 -0700
X-CSE-ConnectionGUID: ktK+1Aq9Scu3XbsXBV/Kog==
X-CSE-MsgGUID: yhBkWzDOTTChw0Rgi83MWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24950726"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 10:13:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 10:13:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 10:13:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 10:13:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5T9OBFd2xVDeZo3gHaYpuoVAUtiq+e0uWDgDnZSgaHO/4p6bE++wDb/zd4LLEYIK1rtckqlOBG6te/6aCR5q5/HpDef01D4Cuq1lvQozlvTIpH1SkfYlUN0kFJbGyoDMMtudTBtSzCiqikNn079d+Yh31hp6O7mCOZvq8I9vedo0au7EAkQeJ9ekthPtzXsg9XtigqeBqMuZeRV343GYGUlNRfjWPND968CmYqit5eblGxnOs2c5o8i8BoVJozEHEJ9QB0b29XbIMlRLCYlcWJeGA8ntyrJsOc/Rz8OTp1nIiwYvxXDqprMYdwJHRk0wQ4KVww6/hulz/PzLuRNIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wTOnnZAz6H/Fkfe+71qqx+aTGGsIKTUWhe8Gzz2CAM=;
 b=UG5otSj9UiLwTwo0Z4VszBriRfi4b3oEvMQifidDqAudzHox2RTJJaEEd+R/FtaisxsBA78jtyYBy2AoxTxreVSZhXvigAFPK2h5T1XzXNqjpJcrr46qf4ZJVcoqc0/gJq3D87R0+eMZm03Z8Ztt1/BvgzWAcGEzQj9tC2ZdBgYedaEj+lDSyvEyMQXEUH2OIR2sEwpErhAwciPkL7uzAAK1UaINpIPyDvAWNRWywPIL7adKO1+15xhmFI+vOgyu9bzAwEzkHXODC9fxlStOxFnHTO3KulDK0vuXWmnURT24aurcHKhcu7RE/MQztAykd8MWLvo/NrIjhbwTT0Ho/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW5PR11MB5932.namprd11.prod.outlook.com (2603:10b6:303:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 17:13:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 17:13:05 +0000
Date: Tue, 23 Apr 2024 10:13:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 1/2] Documentation: process: Avoid unneeded Cc: tags
Message-ID: <6627ec1f71a4b_a96f294f1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240423132024.2368662-1-andriy.shevchenko@linux.intel.com>
 <20240423132024.2368662-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240423132024.2368662-2-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: MW4P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW5PR11MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: ac914cde-805f-4f54-f73d-08dc63b8a3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uf90zt5xO4xBhYD55GLyEFBTBrxWNhzOS3wGxWfncqB0erIts1iPhVN7kcZQ?=
 =?us-ascii?Q?Ckcul/aiQUZ1Ts4EZ1Y9UeaK5fAywBieCaK8lF060HAcKbxrVMjBgJQwm5Mp?=
 =?us-ascii?Q?uYl10VU+LQwEZnk/htuseO0L9pMcsxxuvTpHkGtS66zIW82Z36psIy4/8220?=
 =?us-ascii?Q?kr938jo1M2dTqTLq4cHQCz+ol7Ci8X63VQpggdOJOCjjfhlME3dS2vyOyJwy?=
 =?us-ascii?Q?YZywC/hiWEy5rv1Gi2F8VE9qxdNH9bTKQPyaU0ji1tGtQFja1SLivSigccy6?=
 =?us-ascii?Q?ZiBvfSpca0uO/tZ13sPtNNRGrOKcVz/JCoSRjf+u4Mfg9holtKOF0cLjayZH?=
 =?us-ascii?Q?5L+MciUbewOsutfh1a/ZdTjzPvtp9csG79qUZpb3Wg0q5xnKTLETE5KwjL2Q?=
 =?us-ascii?Q?viwIME5aEBysAvTywFcxLV/0eE553+x9V9Wv4Eo55omKBZq0pC4EGaYDqY0B?=
 =?us-ascii?Q?JKbJnF3DHiTSRXBowSo1QNOXnTydHXCq12LHPx+AiL8XyL2VhHAkjTKut2Wy?=
 =?us-ascii?Q?00//RcPG1+A8zSbjIGlVAq91rWnZFz2wOMVoi+NTRl4g8Xto7xSCnqx+DWzW?=
 =?us-ascii?Q?iFGywWjnzUnhEGZUdTlYW9dbK4M16tx55AGmaqJ+OFqgLikq5A+/VXzAqbg/?=
 =?us-ascii?Q?y7RK83t8AD0qDnKY0sh2dgj96MSFQrcLZRpVgluCikCvSGMTferyiYFwzKY8?=
 =?us-ascii?Q?NVJYH9ChV6FQ4dQ6JssAeeNtM1N3OMZZmIu/HsOlhd+1O6YulcMGyotsfHnT?=
 =?us-ascii?Q?lLX1Z79YqTA+b5F49yXJWK5AZrRHiz4Dk3/K4U+3FMipfhaU+Pl9wXTkMfTC?=
 =?us-ascii?Q?CP6CLEWTwUNifnvjntTF4aTAx9Uk3I5OowzaddFO6M/J5vpCwuFaEGenGJ18?=
 =?us-ascii?Q?yiD9+2OjJjjWxpWyyzTiUum/5ETD6CrEdc4X03M2okOFVhFbH43JbSADD2h1?=
 =?us-ascii?Q?LiXW7JVU/KqjvGZ0sDl2ltjvesrkn+JxKi5LFpHwj4CEH9JH7qYfSGLLAU32?=
 =?us-ascii?Q?3hKjmY6/sp/d8DYPzW8Ww2b8NAUfR44Jo7ePVIZc1xDzQjXXLrIxXAUOtDFV?=
 =?us-ascii?Q?Mi4tK5OCAh9vppY3ymbK5UhMyDCqAF7pUngcGzDHop1ced4iGcWF9UOcM3Ud?=
 =?us-ascii?Q?5BErpEwYAWTI9NBDJbh8KFAxkwGh6CxtLrUocOXWEQfhVCQMFyxyhlzOYcTy?=
 =?us-ascii?Q?Y0BENa4XrK1rJkcGBRpQ+hxaSd9+Ucqj6hv47doca0j35nE07NQTtHliPu4L?=
 =?us-ascii?Q?al49HDAmYillboBXJkSbGabkB12+uhM0Un0I1v/p6w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PM/Rvq7ESGedqHgSTiMI+W06RJvWZW3irTLY810RkH9WR4aX2p3GKUXDcq3p?=
 =?us-ascii?Q?IrH94Umoocgxi/tS3A1MVjtm8TIkj4472wSHWdtJniiRrNM+PuczX2duzl+l?=
 =?us-ascii?Q?/5YgIfHML+jbO+qjlEBMxG01DwaIY/I9e3uB+xSFB3pEF3gDxJ9YMeXH5PQo?=
 =?us-ascii?Q?OUccgfESPDa4ZJ8V7G41jkSU7w3gMOLIEbkvCQ3TprFbDe6cR1VY684LJVJZ?=
 =?us-ascii?Q?GipTCD6XfGzeKQ+uHbyW9DYZIBBkBWzYpgd71XuEOelYY1we2puX/w+9T0W8?=
 =?us-ascii?Q?ij+SZ2C6jgHhmRoC+VhuDfbQlm3pOxkPqOlfSZArESKh1RirUMUB6X65bFE6?=
 =?us-ascii?Q?Yo4yKLiO1ALrKepKQ2my73DX5bWlIrk4AB45sZjqUWded0wiSldQ/7C5eOjV?=
 =?us-ascii?Q?m9oRYP/cNr/exPiCdz09EoFNGAVz602Mi++nb+dSBC+qJLJUa7o53Yq6PN80?=
 =?us-ascii?Q?f/M7kIjfzjkI5akmXF9brduL7j0vh07wOaIRC1yi3C9bfQCfVUKfBew5IeBG?=
 =?us-ascii?Q?D68oUL7WaaHusjD4B+tWZXrDIfBB66lAEFksPdWTgTywYd/unYSSP6CtaRnE?=
 =?us-ascii?Q?5oqDGnb41+h/+gAFTLM1RyxmZw3ON46EqPIldRvb6XX4MsB1vFp+Lg6dEXOF?=
 =?us-ascii?Q?FDr2Tr8TJ8lDtme/MDcmdpHQVK24zimGhbks0NYRL7Crq27YKbhxCEktgL+n?=
 =?us-ascii?Q?0rw3DqqBcF4krJZ9T0MdByQWMsVhnkVo901GnFuUV16skuPPp7Mh3WR0NMSV?=
 =?us-ascii?Q?Nl5MFlhdWtfLMo8J5xZCPlIDxTdhGj4GHo+KZANWm+nffYIazu3Pc6ETEBVt?=
 =?us-ascii?Q?EZDxvA7KRofggtgilEvMJrrmrq4CNc9yRvo+aNA65THca9kCiQmhMHN2bR77?=
 =?us-ascii?Q?NAvsn9AXnKP5rUV0SKlV71xLrfaY7BWsbV5Q3c1iM3rEfLpN1z5t0crH3Yk0?=
 =?us-ascii?Q?exVE9yKjDKrh3QTtl8WOCEa/04TEH28+OQxReq1L8oUAxF7KGqWqFF9WK6g1?=
 =?us-ascii?Q?4mvF046mHa+lhKFSpJ2dYKY+EUrNJOv9TF4/Hm3bqB/Hf8F4Uhw2hVLYwi98?=
 =?us-ascii?Q?tTTEA5XYYBybbkmFt7yasCfIQWpoD4rAmI/YZlj+YJ6ar5aQbUGISma9PgOo?=
 =?us-ascii?Q?iH4cTMrQkWuXTtT6N0ZCASBpIjTjhId6UdsIOToFqFVtiaADtLoiCZ1HpxwX?=
 =?us-ascii?Q?NTKA+vWvq+qeDw5J163bGKUxBb0iBX5S25VboGsx/+wrxQ4fsS58HfmntPC/?=
 =?us-ascii?Q?Im+MXEAF0cyZJh/EHH6VZV3ZpIQ0xgQqb9VNpX0nNcXqEiB1QJmzwyJ7mkAf?=
 =?us-ascii?Q?xgHgvEAvJKMyE2Aqdd+w1JFMj3LOyFaLb8Zc0qQiEcjnkq/z7aykSKpX93hC?=
 =?us-ascii?Q?ebA55xn2I2TUMTQBXRmxOqxWSTsgbFGf4QnZcfMQwjUfa5OQtw4akXuYiuqt?=
 =?us-ascii?Q?/ql/77ZjQCdLJbnX0QyBB43nDMANiTAb1ET3O0nrBxL7qPpc+LKyYYVXv5gR?=
 =?us-ascii?Q?9c2oxMLczLzG48Ia/DaonAwULJZzTomzKia6SY2MITWwI3ghOlVYUXncSWpQ?=
 =?us-ascii?Q?5kBOsezG6zLyBuyCqw1phR8SPqf3M4cHDvlr97KB36D6Pf6mrgP0xv3I6I9R?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac914cde-805f-4f54-f73d-08dc63b8a3e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:13:05.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GmtZa3jvXMUoBAURjswCI/ApFIoxnc60wpeu9Hb1VkKDejzoMAcOnEYn3vj/vYFsTttEtGweqWt4XZrbvDuB/ebNp5Cn0eXNBetXml+1gaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5932
X-OriginatorOrg: intel.com

Andy Shevchenko wrote:
> Add a note that explains that  Cc: email header is implied by other
> tags, such as Reviewed-by:. In this case an explicit Cc: is _not_
> needed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  Documentation/process/5.Posting.rst          | 4 +++-
>  Documentation/process/submitting-patches.rst | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
[..]
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 66029999b587..6775f0698136 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -486,7 +486,10 @@ provided such comments, you may optionally add a ``Cc:`` tag to the patch.
>  This is the only tag which might be added without an explicit action by the
>  person it names - but it should indicate that this person was copied on the
>  patch.  This tag documents that potentially interested parties
> -have been included in the discussion.
> +have been included in the discussion. Note that other formal tags are
> +automatically converted to the Cc: email header and you do not need to
> +have an explicit ``Cc:`` tag, if the person is already mentioned by another
> +tag.

This just looks like a licsense to needle people that happen to ship a
duplicate tag. It does not feel like a net improvement to community
discourse.

Instead, one positive contribution in this area might be to patch "b4
am" to cleanup redundant tags when a Cc: is repeated by another tag.
For example:

    b4 am 20231018115038.0000433d@Huawei.com

..could have elided the Cc: for Jonathan after applying his
Reviewed-by:.

