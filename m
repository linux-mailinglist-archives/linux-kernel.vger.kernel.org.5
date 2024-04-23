Return-Path: <linux-kernel+bounces-154417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECF8ADBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6626A282DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DA17BB7;
	Tue, 23 Apr 2024 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWkCBaKy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1313E168DE;
	Tue, 23 Apr 2024 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838856; cv=fail; b=qHVmnvYMiLsyVOzaaVOHle1qyC5YurPcY1d+hWBmAyInDjHXJHlGavElUi0BioseKOeMiA3IdUdPWNvYd5ApvAZkTUIOrQRhL9dLNi98yqtIdWvRBT6buAGPph+DpdmagjfNrrgg6Bes7JpiByrpbFY1Yu/bHgTR1LZSwmx/nGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838856; c=relaxed/simple;
	bh=FC1oBOgiFYsEXMVLgaelftW0sZSYGGADFUFpGfxVAlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evCTm9YxXc4osst/p2KB5jXlEytLKpx2DbCm0UT7Sm/dtC0OR24tWprX0brmw6hoo1Tr6VDgsK46iNtYM/dqgoFoCdM1ZRAqUdjSsR+SyohCyArTNgNIhYt6U6RMKuUD5ClyYGxYYYUZYmwXhDJumnf3tyHF+PDDzNy7P4QGb/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HWkCBaKy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713838856; x=1745374856;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FC1oBOgiFYsEXMVLgaelftW0sZSYGGADFUFpGfxVAlk=;
  b=HWkCBaKy/EaTlbzpt+y69gTDdHgmmUiMqYdVEk7lDn+oU3+oYX7+dvLn
   F4YoUZgOjbN9c/vhLU8S8OPjLXrHpqKVrfyj3q7j0RSwduq+5CE6ZPreG
   5bfzRO227V/IcR1EVOuleA5qDYR82J2+EzI3qYedECkFOT4qJqWxqmhu6
   /qwEaDDzD3Ajf+eunPIJKAXmAogV4bGkKPP/VEJdwVNYp22fE0zErFyGb
   v+6LeC+pt7o1DKHnov9x+mg+7GwH0SGjzl+8YEz08X2kqwOeUL+JRi36m
   rUMaNRXJG2gxPjiiTZcybrDBV+lfxYXwBgnHnvfQmCUgNRGb1qa7ofe85
   A==;
X-CSE-ConnectionGUID: NyvlZbXVQkGlTUCga+v4bw==
X-CSE-MsgGUID: AuGHzeIHTvmKTMgYfOJg/Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31894991"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31894991"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:20:55 -0700
X-CSE-ConnectionGUID: zpjDwzrmRdm2RrnbOYy0kQ==
X-CSE-MsgGUID: G7uMkZXQQkeFzsDt/45fWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29023139"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:20:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:20:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:20:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:20:53 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:20:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK9Jab33McDDU+AJ6hFzbxojtIozz5Vj/IgI+im81w6wfhNEmRmQ5Cj8nX8xxOSnlsWrXo53AIr2oAmpPSuvV8BgLsWmcpoDDoojc4Me51CoKYG6mgNjXh/klJ2q+VFkq1fPrIlp4k1WNagPb7V+itUx3aBpYVtCQplkYBSuo0MB3tnuBGKUUfUEN9QKchWSRMMVuHOmCIk8vqj9Z6Ho0HqzuC6zUfHEMXZ6C/69JLv5WKm855KM0+wY9Qo5r03K/Ff8E+Fkth2Ik57JMPPmO+ddUc7VgMyDqRBsWewgQUtQYv53A1fvRkDR4BiiIkxQ0suRq/9+ampaVLi2FrK2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQWCm2LPgH8Rqu+Szzd4Fcv0WIdPzOqGwOI6IlcA7wo=;
 b=oYJtahOY9MtAWy2+BsrRfXQmMACKZg1GLQ+Le0xeNV4t8MS43sNodOiYy/hCNknxmARoRJYDNlIdmcP6HI4oywIPHcRVRjvt9p0C86mLWW7tLnrckzfAjEZYk7KEhKbuPmQCKiuMdSrJMDsKRSMlGawadH+ot/FDjZy+6KvaptP44JeBzH5/3LFnNDzrsbiueJjyl03IZRtxn/GEHn/u4e1DNZJ3UewjWEbyfQ4+dwqsQeE7nn4jRs/dMxTujKwzxNVKka+gw/VUMRy8/ta+A3kt6J1x5iJKeGO5UmevbxQkVwuhfg/U5vR16ZmC6aA7wKOtPi13D3s84htieRyGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 02:20:51 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 02:20:51 +0000
Date: Mon, 22 Apr 2024 19:20:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v3 1/5] x86/numa: Fix SRAT lookup of CFMWS ranges with
 numa_fill_memblks()
Message-ID: <66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-2-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 896390fe-0399-4146-ccb7-08dc633bfed1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zm8D8elwCFU35gua95Uu97lkDUV8ZBFPjzGZIMq7Z51a4AYgFAvwifL/Zr85?=
 =?us-ascii?Q?vM5224zZVrY1Kx3X3jDfZJvL78Yrch4MVdcoWKPGKFOGH8GC4STpzGywse3C?=
 =?us-ascii?Q?rb0LT2HMOJU56A4lUpYRyGrIpAOogAYIwtw+MqmTI70Syd6is0UbYsN1kDKb?=
 =?us-ascii?Q?eIjFRU0KhqPsrAolVsQtiQbE+J/UBO+xVubdqkIibsFXJrx/NfhYK6M14Ut/?=
 =?us-ascii?Q?5f4+2+PhSLWxpv5pauU903Adu2YSLELmjoCcC0UZJ8tZGHDfx31WYrnJUY3K?=
 =?us-ascii?Q?BZRQbS5ESmrMMzfMIurJ9mQfx324fdaSlcDxUDVQruCqJYBDaWX/mQy2wbDK?=
 =?us-ascii?Q?8dGIJYq5CxTmDJTp17uZ9ILqVKdPHdjaJUnIO+uWML1mY/3SLEjBVpiylNFy?=
 =?us-ascii?Q?0zF3Q79dJ96bCnjGSNy8hCKbGagUuTG1cmK2q+dxrrQPQIMflEdKdQOg+xdx?=
 =?us-ascii?Q?T5L8MIqjsxv1JbwEyJO7ESTollvlUDrxOxmRvyiBVTVRv2tKe4hHhh4Yj5m4?=
 =?us-ascii?Q?wyE5FyY78aQVwqyRmKVVfReRlf1rqkd2uOvHUMsrnEEuFIVSUg6KzA6/vu5t?=
 =?us-ascii?Q?zFRakl+wtQ/SIfMCIkyXdA7KGnE+jylXHh/6nlRz4uRElr7HjMyVhbasOkkn?=
 =?us-ascii?Q?Y55bmA+1ZJYH9AM0X1/fYal0fGnfVpao2zUD/fJZtp6vkfjceThAOQlN7QKI?=
 =?us-ascii?Q?BGvRvZiFrt2DZg5CALGGQWtSjIvDMjco86EZwY10Fu1FRRl9ufJcph8yppO8?=
 =?us-ascii?Q?f/81ZASAYm6UW6nzHEddQz6Pq0XkrxJKTgt/3DnMa9eIyqk11A5GFOhJWBOm?=
 =?us-ascii?Q?rXAqYTeLWo4F16P0CUHHkhNdluJNdnEsKG6SCF3RtuxrhTGtraYuTJSsXENy?=
 =?us-ascii?Q?fKOVziQiu+9ldaZYUGJNBI4Fb+EAjz22WgNYTaq1KoGRsaGiBwHMlontZ8ol?=
 =?us-ascii?Q?RdxJJgeXgyeQ6hCSdS1/cNZ6lzrW+nQQPe45g3Wd1HUHiZYBgvNS1rCbz6Fc?=
 =?us-ascii?Q?+XiT0Jl+19q+jQHPAOs9+/CU97ElwWyMYRIc2+zed+IdPgIpVA0HmL5SYga4?=
 =?us-ascii?Q?eYBh7NRfk5LP1qLWwIVdkLO4kTQqBnt5iY/Kl2eo4Mtvm6YZbsuLzZXyBvu5?=
 =?us-ascii?Q?bfzYdDz+K6R5cMxUTcQ9kVV7yG74n8R29myomaaFXk7qjDn87dptqO8VUDyb?=
 =?us-ascii?Q?pcaBiEdbOtuDyRTdzrkOKGnQ02I0HS51IVQGGTLwnW7pft/wlMBkTiGcM+A4?=
 =?us-ascii?Q?a3eyS1zdAvcXWr/leWjkiXbLPZMuNlX92t8oJeGrXCN1zfnh4Yy0U2ug4BwB?=
 =?us-ascii?Q?EptlgTjNicrUmvSpJssjJYPJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CLjTvtUnXiP/QFfMqeQAdu3AmRp6PoEztESfZWiD3FK64y58ZcKNHDJuJmnI?=
 =?us-ascii?Q?og3QL12rolIZK2dualqh9nQFjD7pfYNJ1YPmDxT7A4pcNMq2wdcxVcFjeZCU?=
 =?us-ascii?Q?FAysK1Y34bdupp27TO/sDVHsjI7sXOQTzjc5gCIrBLPYpUhbX+ImeW4VJHWQ?=
 =?us-ascii?Q?avCb0//wQWFCtZbt9ZtQp6krT3qXnt2t49vrZyKXSztwXRB/x17evEW8Q+13?=
 =?us-ascii?Q?LhIUVB9Ug16FmcfGnJA3Lu9I3WgSZEUdgWPcPx16VrSWMqv69BclOzSI/FgR?=
 =?us-ascii?Q?P0zWPmCGGbhAZzPTX8YYiMvDFxYC0lwXcDM0U3D20ZDTv4n7ybdz+m0eVqys?=
 =?us-ascii?Q?EL7uQ+gvHCmaU58o+ni6rQdkm8bIrL5qdfdsoGiShACWilQhrGF2TJzA8l1f?=
 =?us-ascii?Q?+NJf01Z57yvrC9cLG5jmgLWE3OCndmmlzkHHrr0HsWJxs3D9XvMAbIPvB0P1?=
 =?us-ascii?Q?pBMdkU2Htf7F0Fhyme6iM2bzdExDy7R0eFlJFF1RMRmMdSpqfppwmVee4RkS?=
 =?us-ascii?Q?bpu6ULSMQ1qlYWGJ9lwdGxryKA8d8VXyzQZ+Pz5SuJuIdwSijoADstmU3pXE?=
 =?us-ascii?Q?RgyDpzy4uVspeOMHfLQt0k86EGvOww07VT2HEt+K3HcIlUqUpsmmTGDhRhUx?=
 =?us-ascii?Q?LOg5SD/68XpmrFG2RidweQEhQLw9L5Kk1Q6XVxziqV+UmMXO5hqot754GgS+?=
 =?us-ascii?Q?8H+w7mDDhjUwMzEL4c2ShRzNBGXC83NHMUH0BI/KPMxm+/+8hMMYHH+tljBq?=
 =?us-ascii?Q?qI3qstrKRFCy47GRWzwkcd8DjgWCkamfVpC0Z57ldKUhIq0jzvFBGl8goqI+?=
 =?us-ascii?Q?nUB6JTeTCJripm9rJeZgPtWJ8AmYEQ5WtWGPtXNYqt3BjUfD5X8OcogMHS2F?=
 =?us-ascii?Q?ANO3zfh6lG0eZGCHGjTqhl0e4hCAEM5ezeCqDke5GkVLKs73om45VG/VEY6Z?=
 =?us-ascii?Q?aHFU9Kl7Hm/oJ3Y6/Z8DfXhXi53e5pVvGElcXTVPD3SzcVAGTa4Zsz/yF6hX?=
 =?us-ascii?Q?aWHvw16+BfkFOVyB/8cuJH5EwBw3f0UegaOc9r2AnYc7augkUz1pJTn8dz7C?=
 =?us-ascii?Q?GPm+spC5pjoTeszwh4bpnoOJEcTwmfjhdlx3vE5ElOhgMK0ut7VIKeVwFUen?=
 =?us-ascii?Q?1MZ5A+qpK1pvpb66XwQyeYBxbPitixVooeZWU0lUyfCchR7pYB8iCm6QSIfj?=
 =?us-ascii?Q?T1+NmzEnbcNyYuvKR8TElgGPZTcGxvkBDRnIoOMGErKkJysP/i6OA14r2/qN?=
 =?us-ascii?Q?ilM531BzjwFIyrjWEmJaxveyfraNGV5yLxIUc8pIVsyymBsoT3R1rklllboD?=
 =?us-ascii?Q?wMkAU1QColAENk4OZtV7Sx8lHzkrQgti4Nw/TLo56VYbkpipIOgIrmErvCtq?=
 =?us-ascii?Q?tgfV0VsFF684jwngSEPDcn9ohBFSTuq04TAtk0K6D9epARXyKjMqV3UGIpwm?=
 =?us-ascii?Q?VMaUU15RzKvhC5M3bnESrlmwCJQoX5hQLwucTkuXDOUNzhW9oO4geNvjZsVl?=
 =?us-ascii?Q?uwXkV2tf7wR/i76QJMCfI98iJlfjbI+U/pL1cGs0R8FXXxaCfLZ+cf/PO3+4?=
 =?us-ascii?Q?TVRzbcVzKHczh0ar22ziZ9bysdGp5gSeH1Z5bgsaSj8auR5NZJ5/jy5kZDhI?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 896390fe-0399-4146-ccb7-08dc633bfed1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:20:51.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+L4MbkuYkf1NLpMDINCVXpaglaTqBHkwchogjuHEeHpYcNCVBrpmH32LgpZBVfmh3LqwnsPnnHpGzyykHBZVfTZm7hTwiVpkTuaTFrd8RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com

Robert Richter wrote:
> For configurations that have the kconfig option NUMA_KEEP_MEMINFO
> disabled, the SRAT lookup done with numa_fill_memblks() fails
> returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
> found for a CFMWS address range. This causes the addition of a
> duplicate numa_memblk with a different node id and a subsequent page
> fault and kernel crash during boot.
> 
> numa_fill_memblks() is implemented and used in the init section only.
> The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
> be used outside of init. So fix the SRAT lookup by moving
> numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
> always available in the init section.
> 
> Note that the issue was initially introduced with [1]. But since
> phys_to_target_node() was originally used that returned the valid node
> 0, an additional numa_memblk was not added. Though, the node id was
> wrong too.

Wrong node seems worth notifying and we can figure out on the backend
where the backport makes sense.

> 
> [1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
>     CFMWS not in SRAT")
> 
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
> Cc: Derick Marks <derick.w.marks@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  arch/x86/include/asm/sparsemem.h | 2 +-
>  arch/x86/mm/numa.c               | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 1be13b2dfe8b..1aaa447ef24b 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +#endif
>  extern int numa_fill_memblks(u64 start, u64 end);
>  #define numa_fill_memblks numa_fill_memblks

It just feels like numa_fill_memblks() has absolutely no business being
defined in arch/x86/include/asm/sparsemem.h.

The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
applied to memory ranges hot-onlined by the CXL driver.

It belongs right next to numa_add_memblk(), and I suspect
arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
what to do about the fact that linux/numa.h does not include asm/numa.h
and that all implementations either provide numa_add_memblk() or select
the generic implementation.

So I would prefer that this do the proper fix and get
numa_fill_memblks() completely out of the sparsemem.h path.

Something like the following which boots for me:

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index ef2844d69173..12a93a3466c4 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -26,6 +26,7 @@ extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+extern int __init numa_fill_memblks(u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..64df897c0ee3 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-extern int numa_fill_memblks(u64 start, u64 end);
-#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..3b09fd39eeb4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -208,6 +208,11 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+__weak int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 915033a75731..8485d98e554d 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -36,13 +36,6 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
-#endif
-
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
 {

