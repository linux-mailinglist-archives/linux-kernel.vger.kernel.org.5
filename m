Return-Path: <linux-kernel+bounces-154423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4418ADBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F212836EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6670017C73;
	Tue, 23 Apr 2024 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoJb0dX+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CF1799D;
	Tue, 23 Apr 2024 02:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839316; cv=fail; b=jAmvHJeAvDCyDj0FufHjoERt2mi+LAt+Ncg3KKCI0AOC6IhyDMUr9nvnPmBM2PuDSOwrR5gWZjLlP1vZMKiIPb+5+3DEekC8jgmbuYTPn9m1AFZnP3ZPV393s9uigWziwlGzqUaAtVJjBawSKg2e1dx22EaLPwxwwvYCUzX09tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839316; c=relaxed/simple;
	bh=pU2zsGBaU0Pt7wvOfYT5xcP+3w/KHcMw21AJz9YYFuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I0dbkG+QbYaVzO6ptr+AuIPq/F/g1AHVOEZI4V64FF4Tnzz+KJV4TX9kJRjt4x24bJqXn4kZcCpwKkfftftpeaX/tn7kyljgitj0nV+MBT62sJ6rXhoSATjlCG4+a92mbPgb+duMfCdRP2798IMJhQ27xxE57+Tm90ZYXP7K+2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoJb0dX+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713839316; x=1745375316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pU2zsGBaU0Pt7wvOfYT5xcP+3w/KHcMw21AJz9YYFuA=;
  b=BoJb0dX+MJrFRpkyHCTM+Qh6YBZvSaEvvWwvuEkYjAy0y+91SvzOja3y
   rc5I3Wcv9arvm716VckB9B0AnBWhGvq9JHEAHmGsS8MlS8knSMnqwt+7R
   RoIhWQ8a9P6qvzrxpd48c4H/1S1PFzA+VX8hzDJnHfkEP0d4YpV8aibz6
   wdGgV+MCAVhuAkVca5NRKeMhojgmsQ25hubPUuxPdRrybfErZaE3YSBuC
   eienXjDDQ5P8BS5c2iAOMQa/K8yv8VDjzsSyZEwf5xLFu1JZXyZdRqM1N
   ZE/G4TdbwKoxTinq93GStpS0ZhFFAX6gojnMiOYLkKu1H7McfHiG28QYq
   A==;
X-CSE-ConnectionGUID: rinU+ELxR7OTjZzybl9jig==
X-CSE-MsgGUID: 2KmhYgtvQYOeL4QhW2dldw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="31895686"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31895686"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:28:35 -0700
X-CSE-ConnectionGUID: eK1WeuK3ScekL1izeOw5dA==
X-CSE-MsgGUID: jcggCNSxSgCZajTcWIcn4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="29024965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 19:28:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 19:28:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 19:28:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 19:28:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WY4kWymtcXghetu/9eoV79wZhQECsTtyjx+l9JDSbAlnUXL+82oSmPNrZhQAgBGh7dUue56Rf9r2PO0WGpRIduCMmiXnl/tv2hDhGO44d0wDu4e628Gf7mjNZnh4RJxIH/eTg1Y3CcdqKH5BxgQNPgo6TeLk4MMdnCGNAVp3R2+Q8YWiYRGoGuft8+XoPuJvt5WrcAF7xxua+JTKfJeMeZQQzGYBud0bddxZ7OVl5HsnsTdU77dRI1f+9JZ21GB2JWc9RB8UFShuvPzTrFCRO8uZgWGOlKmceJoKbtwVrNcm3c6t8qoos1Pucbczsau7j+5YPGJ9aC+/eMcj45XTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuM+paoD3K4MnAywEMAgfyCyK4a0vNBlAR5qAvUeH08=;
 b=SmN/ZV6dHtOmCPAx5gfh/Q+n63tPz9C7zCePE9hX/qjQu+hh6Pr3lwHbjoSd+YmrfKwJtfierXoCfFZEpZwxjMbFYvhtX4c+5m5/J5DH3iSQX5W/xKDbbkcigPjPoVA91xBsnKbE65zj2MnFyxCeS5skEXFLWvTbQL34KXurLhJ7wd04D1dRRifx2ld9sWiE0mxOWnRgd4lwaqdjPbwM/BIPj+FUZcRlJ2z6l2MeocZKf00/addwwzMQr95vlak7gvzn7AVKSCteERsKZPejSZe3dln2uLDX+7zxWL29OF4s9LomJYoX6pi+AopArUAwTc9SIzXW1Cu3K2hYWyaclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 02:28:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Tue, 23 Apr 2024
 02:28:31 +0000
Date: Mon, 22 Apr 2024 19:28:29 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: RE: [PATCH v3 3/5] ACPI/NUMA: Remove architecture dependent
 remainings
Message-ID: <66271ccd13e5c_691029471@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240419140203.1996635-1-rrichter@amd.com>
 <20240419140203.1996635-4-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240419140203.1996635-4-rrichter@amd.com>
X-ClientProxiedBy: MW4PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:303:b6::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e127d0b-95cb-4d8e-8c9b-08dc633d116a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8kYAF5eYYa24MVokd5Fj0hH8sLxf+L5h/VrRjLRWwKonewxldtNuH6wOZd6H?=
 =?us-ascii?Q?1ASJ5SnsuwEyfomIdICGT6SQ9+OJftEYJIW78wAJemkKpZIo2dzwnrwuNa60?=
 =?us-ascii?Q?QaLaCmoiuVJ//jV293fdq9N6azZmaBpvkcL6XwRe1Y2wjAYSzxy+q+trwxob?=
 =?us-ascii?Q?8k7PmBAaoLGzGuc+t88GtlnJjK6hDs5Zh6VVPg/dqXz5sqocdEcrRa7fJ7cj?=
 =?us-ascii?Q?HenQdYxTaqdgfp5IqRdi6aCDVKlEE36GY2n8YKPCKHZYeux50TNTACz/C6bQ?=
 =?us-ascii?Q?BBgoweog24CnzQVoM7pSBPTSrXyAGMVIPHzi16Z6p60x+sWT+Ff52MuIVyuR?=
 =?us-ascii?Q?g9l3HWPQtJD7jgIGPsGm4c43YE4o5bZRgtEeqNkFJlcdK2Vg+CG/nCkh0qJc?=
 =?us-ascii?Q?GdNeRYh/45dlzUa8TNvYS+AaMH1nOgiI6L6kpq1aQqSti/93oJyMrlUexR6c?=
 =?us-ascii?Q?yXhfwurwm/g3Lte8k9DAW58qQRMqvk5qGEcFaJVT3ieJ6z1prKgNaaGfmeZ6?=
 =?us-ascii?Q?J0h9KDLQEUyiX9wMtgXPAOtzlk/J4Mr1XvyLXUACwIzPONcf6MLzuVDgfz/F?=
 =?us-ascii?Q?OpPfOffmbBo3JaCLzJd8BST8FszzhqhlV+Xruw33cqDqsK1bocpfxNmRCj/N?=
 =?us-ascii?Q?K35adwc7Cf8wl0nxxIGalioIZuQC5/SBoFPtyosYi+CkbQ9DB81ZUKvs7QIo?=
 =?us-ascii?Q?9vLxHHB6MsXBn3mjlsrAlczXMIVN1iesR67LptcsrA50ze5jGxNuIsg9T3Ve?=
 =?us-ascii?Q?+p22JvMu+bGQXMCJ4RCJMS9L6W9Xje8nUoBMPIXoDpKCzQlvTRByM/De5M6O?=
 =?us-ascii?Q?JUcAzNsUoKarUxgK1qGFcytmhl8Z4JsVHt0NR/padbcAFa35yf/RZhGnMLrs?=
 =?us-ascii?Q?awuLeiprzfGCchnKPlPfbXA731M27bty3sqz/IdgUgubMB4k5WouFi/8ga4I?=
 =?us-ascii?Q?uTGmxcqqUybIlOqUzk4UFdUa/wvGMlvaT5fSnvRRnjytRn67xUQvHyFkKzhS?=
 =?us-ascii?Q?0hKv2QauHfuMpm0aMKMuamojHVILeRifGK3DQI6dep16wwJhpambX3RtA8f/?=
 =?us-ascii?Q?cPrxmzKIzdLZPUOE8O7O3Idtlu0p3kf4Ol8X6Vrf6Yg1Bola8vPReFxPucj1?=
 =?us-ascii?Q?mYvjU2r20L9OH/jTnNYuidfCOVTEs8b055XNLgrYAIik1FRe7flkM6sgZqxC?=
 =?us-ascii?Q?W6Bp5Uf5HnMktGAadBsp7mCEukpk1DrZ2qZ7a/UDeWuy8TDqtyob/5SVGhwI?=
 =?us-ascii?Q?TYYKRVVL3ZBh5DkbJ/yXN68JCcxuy7L+Zq+4TPFJUA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uhtg3WijH6o44M1KoXwa8aYKZGaotA2BelX4H4EHNRpgCDvH1IRZr53D1//u?=
 =?us-ascii?Q?o26c+2q7wKd/kZOM+GHnr/zVBrJYqELXf9RcvQx4OxutbNlt/T4xFfdqiKG4?=
 =?us-ascii?Q?/m6atzm4e2zR1RewKt/Q1tnt9jrgXxSjQrE1m6ZXGG6At9JRLSAuHzWXfGjs?=
 =?us-ascii?Q?FjDyfoe3qUKXNTUI6o04OJqMNsRqWJ7sLsLR9WpJcpSJ14NggAxqeKh175dG?=
 =?us-ascii?Q?v2wJVvGvjqtETSGJcsa+1on2g8mlxHB2NbPu2Ri9tsvbJm+O9VHyxreA7pdu?=
 =?us-ascii?Q?QVEa4ro2t++vH5TPBCWMuVGEH++fpISE61wrvX0yteWF/1bZn71cKU1dep/b?=
 =?us-ascii?Q?6uU0PO4sB5RJFAWkQkAY1RNBbvvIYzdCMIXminf+5+haf0M6j+DrpxS/4zIZ?=
 =?us-ascii?Q?qUx4HVk3vQlEnKiuR0zg6YrfkffpNLDc0DaF7/zrg5F2JP+htg0Er7oRhXRq?=
 =?us-ascii?Q?hUxpQ8QNii18/2wkXLzdvjLtR5YG/zuIrYNT3Eibzl1q68Qu3xguEimjeFHx?=
 =?us-ascii?Q?cGx+oIzqZfqqR/xo9GaGoXOWk21IoEmuxhVtLhlx0CDTR3qmVc7r2lMyWfkW?=
 =?us-ascii?Q?EEdDgMIB+JCOQLyr5Q1p/ChG5Q0ZuZktUIgzEh6h5ar+UOdQ4RjZcMq5JXRU?=
 =?us-ascii?Q?gMfzQNPYIDlS35PS364wvpS+Svby/GASpvqnfeZgqRq48SZY2VhPi/P93fkj?=
 =?us-ascii?Q?SdayGGObHFtmpyywWKN7EkkblTPTfHZC+5ogukMkMqVnF/q7G+T3rs5a9LRb?=
 =?us-ascii?Q?b4HtuauJsTT1JdcwguM0ZykUsdsJU6oYpAGufFWNe4M8YCpd/7LASsBByeTP?=
 =?us-ascii?Q?rAllNjtsAT9QwVbr8L3SlHPAvRaiKj07tvDKHC6ZIS6g6PQOqYkLsePdNz8c?=
 =?us-ascii?Q?FC64SBAYPGXbAx2h7jSXL/eDo3ptSkwK6phzOMs7yiiyPhQ8FQuqOI2or/G+?=
 =?us-ascii?Q?dULubs/Tc5EbTfOsKHHZF+VMz95tQLrqlDSc/JSQ4YBloJTowHzv7s4/8mH7?=
 =?us-ascii?Q?Q5hHsQS/WOKe79M4UeD2vZqVrHkkFPwBIUyUV5lMnmMdWIWVODYNWz/dPenE?=
 =?us-ascii?Q?p3lNo39enblWVXHLlb0zS06BnVdmoZaBdEDpHovxufU/un3LIP/0vGJbWcgY?=
 =?us-ascii?Q?vQUVyRt2R940UDeJu9nFuumdP2+pHhqhkpETejpY2TbBq0aMlrjd6QgNW8dy?=
 =?us-ascii?Q?4wTdQzpkmF8F5Ieik/pb4EIeaEMzQuluPIAVuz6X8t0DT8qdHCaG9hJvYA1B?=
 =?us-ascii?Q?0wI9FucJ5epm22KGQWVJfVhvKbAuhYy1jg/MkdrYLnN7cFUcWT2e/iQDgcqG?=
 =?us-ascii?Q?b8Oksg4cbiqMPwflYi3PrYZigtqJhovdScHjuX3D3myPn0p+4jTZsvCG6b1c?=
 =?us-ascii?Q?KWh8uF/m01qODZiSzb6Ts1lAN5FteMKa81kprf18JeriwLNFGU0C1L4omekq?=
 =?us-ascii?Q?WNlOhYHGWNrgpH++R4jmTXNZaEM9PmTVYepV8lyy+SXkdgB9LMnXwzZEnV74?=
 =?us-ascii?Q?HqWp2ApzAVJaajeYXXfQuROztXI5ZSwngiKZV2eXpMN5+CsHOxnxSjMBEy49?=
 =?us-ascii?Q?swWFuirDR9yJ2Z130bRU9YwkX521XlqowxjVz2Eme9k5EBhnc4G0MEsJroWt?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e127d0b-95cb-4d8e-8c9b-08dc633d116a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:28:31.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf0kktXpIt6dF2Qmu4TK0/19XY+lNyrMgtQ5Egzyj8Kn/xHrOBLGUbaOq/+QDd5D7egC9VsAq3C2/TDxPNVsPF5eOlmOu/tb6oKtauwG21w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com

Robert Richter wrote:
> With the removal of the Itanium architecture [1] the last architecture
> dependent functions:
> 
>  acpi_numa_slit_init(), acpi_numa_memory_affinity_init()
> 
> were removed. Remove its remainings in the header files too an make
> them static.
> 
> [1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/acpi/numa/srat.c | 17 ++---------------
>  include/linux/acpi.h     |  5 -----
>  2 files changed, 2 insertions(+), 20 deletions(-)

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

