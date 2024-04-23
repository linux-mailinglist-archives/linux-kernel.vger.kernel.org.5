Return-Path: <linux-kernel+bounces-155833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B538B8AF7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3AA28A910
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD60142621;
	Tue, 23 Apr 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQh1IWBy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5113D522;
	Tue, 23 Apr 2024 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902607; cv=fail; b=YHhZj5npwf6B+6uHyt9KYcu8ZagR4FZbJxLCqXcnEvYzgmrXmVUWHpfa4JJBlCCCNh0nhGFn7M1fLIxLj0T3GL+63EwQvF2jtLdOpPbSapTezzZMj++nYPmmjBCAR9XoCcUZAiPOzVsFEqR6dy9u+GkuzIdUBcsgb/buf12cI0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902607; c=relaxed/simple;
	bh=Sc3Hq3d1Cis/FrwDuTVFsUD8rjpmpYXGKFWmMbI1Q8w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lpZMKVYEHlezdZtap7Tr6mil/ideTROI2UzbOkaFwP5RyFhUvu1814rDrYtnqnQfSnOmxqttfmyHAdidqLt6Wjek6lLZxuQ3SmRjsEbGuzcEgMn8TQ+YmSMEYn0aU58FAN3EJwR+FexU74Tusp3jLGXrk5bac8QZDv0dItGqAGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQh1IWBy; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713902606; x=1745438606;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Sc3Hq3d1Cis/FrwDuTVFsUD8rjpmpYXGKFWmMbI1Q8w=;
  b=jQh1IWBy4Fptu6b+2CYZCu8J2vh2FUO7bVsb7kH6+xJZ2JAP8XqfPu1r
   I0aeUnFHJChqR+xdDFzhfexP+B3EW5uCJXkTZP12tHBp4SQmAxWIlGmlm
   ZO03lO/zF7Vj2Ecb7BKSi1UUE/n8M4IyYRMIgbgb0XJ08FkGWV25yYwaY
   W28p75xROJFf1SanEd/HZpVlcjybDFJYhSRgEPwKcuyVerNAmivHDqjAO
   fzF0DKxJRq9TIuH1ceQDeuMXgVt95EDXq7P6JcfCbAOxGMyTJz5S4++w0
   kqlq9JPhZ/AKOJnk5ymGCoh0fF4CdxjOaJ+mCGifOzgW1MjrWT7GHnZw9
   g==;
X-CSE-ConnectionGUID: amCmsTe+SwOthzw2g3DH2w==
X-CSE-MsgGUID: XyQvWaclQ6ySqbEgmPGruA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9360278"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9360278"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:03:25 -0700
X-CSE-ConnectionGUID: IW4L/Y55SGCPqHEn9WGGAw==
X-CSE-MsgGUID: xCOBHWN4QkCuivl9y7BqOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24524763"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 13:03:24 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 13:03:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 13:03:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 13:03:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 13:03:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv9lcWvYJkX/XodFGuaeLJt+P7PBCZHIsOtAs4O3ekzn/cZR4tAHBQnJzlJgM/0M573D3fHYkBN0jcXuU3DBcLzH71N51OkJMAMdmmmnP7qb9udhsd8fqK25vdr9WwgkILORBroqM4hl91Qmb7kF98jlOFZK1eak3WCYS7G3vgigIarqHv2A8GqWzTfJjCk3qsXvdEVZamODNnYPIRnAZJ3DjsP/krTUE7GMqKfGQH0LTHPlOi2nNwL7HeG95VuZyMblcUofwpJROrvqy7t4duJeml2oWsHg5vQdYRZyylRANBNWxWAAMCebXctgKK12lqTF3MuHp0OCd+YkuVqipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1RrWyBRQVY1i5hjiTLtzNJELwFkCXO1+Kq6U/bt2/Y=;
 b=UbXxdyD3cew0LV6cMPizisbaRFdqG0nN7u0oYFojsfXVu+M4UJVKJuNrsniR2U5LHbnKR1MKoRyRkqMA+/GubFB/PJ0NRcz7/fEox/pPfNYHC7L83RjE7F6Zl2kP/MpRJrV5OEJ6KM57SgB58trYM+XojwS8L6iv7FLTd7kyOEBprkWq6wGS/8xOS9uAslw2+wpy+7iVXXoie5l+Aw9/AvBUuBcVUUFm9MrpCorjrYyVH3AeIhe7ZD/bMCmGI1Yfkeei+rHpmUvSqXles8xEh5LhmiAMRbDlPXEEXJX9WulJljd9OK6dmb1JIYZgYK81tdR5bAAL+9ErKGPykmu9IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 20:03:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 20:03:21 +0000
Date: Tue, 23 Apr 2024 13:03:18 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v3 4/5] ACPI/NUMA: Squash acpi_numa_slit_init() into
 acpi_parse_slit()
Message-ID: <66281406bdee1_691029463@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-5-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-5-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:303:8c::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a1890c-fae7-4118-3419-08dc63d06cde
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4fnpx7F3+J2N7A+rKTq683iy6ADy1Fd/GquheiGvgLMDiFWV2h0AXUkvjP/+?=
 =?us-ascii?Q?3V/NJvia9k9EJW/xl4QrUQu3HPfRtTzi+I1XuH9zOvro1cFg1xmhpYFoCyZj?=
 =?us-ascii?Q?seau0QaJ2I4rZMdgbxxRWbYe0lRpZrm1w65aRL2KjFbKpvww4hXmiWmeWpR8?=
 =?us-ascii?Q?uNlXeM7Ym7nMQQwLj7fQaNAIc51QKT3Vbgi9K41N2ZvQWn/9kSK+9tO98t7t?=
 =?us-ascii?Q?/YfAtx8cSWPeEMLdtTyeNy9oeJz/78O1R/KXJm4MBKBBfygislRQEkCmZFyi?=
 =?us-ascii?Q?sdt43MoLrkbQMKdc+q7LRgjqnk+jouI6LcV/2hFxigwgKNshUYlWf4TVD+lq?=
 =?us-ascii?Q?wAg3/KH99wZhxZ+ZLPY10sHF5OiGum+tjrV0NGmBe6axsF/fetiwyYLmmm/B?=
 =?us-ascii?Q?e/PUkpwh0JrUayRb4NiBISoP/havH8xNJKnzrvDhBIR94asHa4kPj6wJZQaL?=
 =?us-ascii?Q?2lQPmq7BnLbB7FU/WAXo5pzGlKv/7TV16gF73DI03mdO4+3bNgetaS2OwQA9?=
 =?us-ascii?Q?oReLeBsS75u7tboZZvG7K6oMEo/gd2jlG5M3MJyHmQhrL4ti/uQe6jT5/GFZ?=
 =?us-ascii?Q?1Al7gse8q8/M9+dOp9zwIXCbvtDlOBH0dZAbgnD4lDLy43+vPkPfhqvYSrgT?=
 =?us-ascii?Q?K/rfPkGBiQBbCvCb4OhstI/vyOxJT7JC1tba1awuI4TbzfPBRl10uc/sWkT1?=
 =?us-ascii?Q?/9EkDVVo4AwXWXuyyBIhe5GgGEp21dFStfBzfLDepPckALfmM/6IIhmyl124?=
 =?us-ascii?Q?1tIZIVHPNIju4NJbm5d8hZI+ev5EwQxmEw1cRTjlx4hgZVpmEIWaHrqvT5Xq?=
 =?us-ascii?Q?EHI5R+/bo8NifRRM/lUL+394yCw0YQm6+mRqnHn2nObt4ban04DWUgKzgGfo?=
 =?us-ascii?Q?cM9YGAt3WZJz1yDPX685DbijkXVniQRfh81GXBLMSxqGRTJaqLgE3IvF9FRp?=
 =?us-ascii?Q?ZymHWTaQ89C74TnEnNrGece7xk9nVRj6LQXT32m2b++GPfdEBzkKHdQVky7X?=
 =?us-ascii?Q?voxdvZvPnOKk18BOa/XHiaGKw0x/KpW5nMTiAYv4PAS4NDKwnAWumdnKkprC?=
 =?us-ascii?Q?1QOwhjXIJJ6ob1nO4eVCW1q7QfLgl/+zTADpCUrjmHsd5MyE4vNlBnwavr1/?=
 =?us-ascii?Q?xRj8nULT4+pdp/Tj/hjd0vgaf8o7SIZVLwOc4UBoIAlLKtfpu2YJZYkAMgny?=
 =?us-ascii?Q?niC+uBKnPmunQlZYYna9RDZoiDwoMv9G37ZVuNzRut41xM9Mg+a7uwe3MXnL?=
 =?us-ascii?Q?PZ5cCc84+4YaeW8Raqzpwoq0ZpwbZTtn6S4GTWrV0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydPj7DJuDUEvs7ML0TWgbzO7L2LUWcJY0LgbPRgwZ3xsm4Z/1bpF+UdO09UB?=
 =?us-ascii?Q?BhY1RjzrgA+Kyg/COEWf6BfMJFCMjHgaru3pY95Ii2MTdD1fGyFxR8jZNsa0?=
 =?us-ascii?Q?sekBG5if9y1Zb+5znVrpsl064mW5fYO1nxVIWoykT2RDdvi61Q+kzl1ghQcg?=
 =?us-ascii?Q?vBmG9sBCSDJY75vTN4MFgoqH9ie88t1D9Dwf+jFFeEZLk9KP93ahUIM702ZK?=
 =?us-ascii?Q?r5Rq2z/Dr9FQHZGET+3CPvaQXNSCl2BKFcvlAl9NoPhbytJBWQklvDys66ux?=
 =?us-ascii?Q?rC2tlNPFND9czx4QgpZ2G4CtMk4gy/okPWst0v+E1RxUrH1Yjy9zLetoR8Rb?=
 =?us-ascii?Q?pLYY2Iv6OmJo9Z9AQAc9aPtwp/pGeRtqairR2NAGe8RLTXx53Zeqdl8ypyqT?=
 =?us-ascii?Q?RW1BYxei/ySNYaidlVk/cA7lcMtPqVbS78/l2Ny8MTgD9f4ivdDIiS5Lyt4n?=
 =?us-ascii?Q?VC1qz0BleKVrZP4dicdTU2n1ThSjqpASPlYdipZrpmWzNbXJ5iF+V3a1GIpQ?=
 =?us-ascii?Q?FFKr1rtatjYHeUPFvMccphnH7RS+8IvGq1jOYqVaewFfZW0d1beVK6EdPR1G?=
 =?us-ascii?Q?DLg0gjh3EmDkZNDoHW7Zdqliz160+A6Tt/5OUgbVk9Lb1I1kC+8DF58Vv7PA?=
 =?us-ascii?Q?Us9OmU4twpsiGEMDzVOTxN3b2FFxCikmGJA4Ekh1//iuqKEf3a5McSkjvhlb?=
 =?us-ascii?Q?3q/IbaAx+sNhwMW3yT1nynE+fS1kvux68jICjDb29y3/KPRCcT0ofkN+D9L5?=
 =?us-ascii?Q?85OebQP5D1Ys9vyA5cxbrV+LBBkZ5HdUTo8JuhHYM3qF5IzLquqhgwN6yTV+?=
 =?us-ascii?Q?WQ5psmcQfA4D+QhmrEwiDFcU9Japc7jq4ELDLJ3HJNnL35//7GkMWF1nmeWZ?=
 =?us-ascii?Q?nC5sBoJ8IHt61XojwMGrp7Q4oX64aOvhgWdDTMhDA/7VdRC85+lE9XPooqjU?=
 =?us-ascii?Q?Frn3hPkbJy71zmCC1leZhWKJG1df5HcxJPcg7XlB8jPNJAto7KAoQVXhLcLy?=
 =?us-ascii?Q?OVLcXCdhs/1JTwXZZ4ugOOhhOq8D6zEmMEuaWP7zpgGNIumQYPijiYV/ZgCI?=
 =?us-ascii?Q?OHs/EnVIgBSXBMGfnKd+OKf9KHfyQKpIx2UI+pfZ+xlC4VVmkNodMPeczGYc?=
 =?us-ascii?Q?jDBxM2PuF2EskPva2E+dr8OlNl3gPVsT1vXEZyacrTynmqi9d18E9L0BSvOY?=
 =?us-ascii?Q?hJEgWRHvxSpTjaHvSnWXCM36M3Ib1h/fdtMQX+y/BcCbVALgUmaRce2SY7Me?=
 =?us-ascii?Q?1RKkauTWj7TCNkbMXYFqYVRsA2Ffplm+YqgpQYJNiCmna1WIFRMca6EQRBmH?=
 =?us-ascii?Q?mgyE3fg2Pe84ZWpUU5WWLpKc8T7FIEwtzmU1DIVN5UoZlDiRmssFjaS0rw6w?=
 =?us-ascii?Q?Rp/qInDI60gdYq95sI+vb7/WN14OYE7X7YEvOqJ8ppM1+URqMVmoF6QF+t1U?=
 =?us-ascii?Q?HUfoqLhdrzpmhHT9uRhF4rF5jV/N4N9L5ox9+5Q2uU1DnCl0vn4jECnu/VuA?=
 =?us-ascii?Q?wd1JCrHFJtESjxMjcSozoyHJe016zLqRFuBCfT2ABMVFAKN9+24HC4NHJZwy?=
 =?us-ascii?Q?mGnEbv9TBEqU6Qt3k8v8tYsRhq8+Iu3OMwUdnbjF+eXFq5L/UJBJQ/+6luXI?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a1890c-fae7-4118-3419-08dc63d06cde
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 20:03:21.2189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmlT0PJ+YEkMtX4xwPTOyxZeIZPYe3biVbD7VLYCu1jWoj5lW9sL8EnxkFaJjg4NsDvcKw1jpl3VKI+SGTkSWOJZ80b+pcLLbgISFJe4/Hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

Robert Richter wrote:
> After removing architectural code the helper function
> acpi_numa_slit_init() is no longer needed. Squash it into
> acpi_parse_slit(). No functional changes intended.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Looks like I fumble fingered and replied to patch 3/5 twice. For this
one as well:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

