Return-Path: <linux-kernel+bounces-137770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B089E6E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3E92B218A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE5438F;
	Wed, 10 Apr 2024 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF/ipS4f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12D719F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709131; cv=fail; b=erJ8DhBizCJE1gaaqk4dASFhKw4fBXyLaZ2112gEAo+5KjDGOO95YZ9elRjROSTJghsBueHUbAU0srHJAxEyVET19GreN3rxG2em1E4PRUEbZ4ainaUcjC75W58aLXi6pnKVo2JuP0D4O9efCHb+N6hS/wINsNSTgIewMVAlftk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709131; c=relaxed/simple;
	bh=ffRsiZf410j4gGokrabDhqA8uTbQgSm6v27tbkHWusI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JXI5G8QnYUpk0adREwcp89GaXZLIHKuln9zdmUBscwHZ2gU4Mf5B2Vdhtmq+Rv0dT/7iwOKppWGlkq/On1nYjGe4MPsYkJKmIJMaCi+eHnVCyoPVV0iTQTj3YJQbIw4d4t8aYv3JuQ5d/CmrLWOb32V2L/4EYB3GjtuYVWc8JZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF/ipS4f; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712709130; x=1744245130;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ffRsiZf410j4gGokrabDhqA8uTbQgSm6v27tbkHWusI=;
  b=nF/ipS4ftEGB77K5h2/DdCj+kO4XGrUvgqQfqHxwtW6Bqj7CwcJ0rIsl
   I6RIiflcvEPOtTXhjVW0ebnv1VvhOc+tMaSWT2RfewS6A3O15Xti3Plkr
   J41GGPkkoAhlvksI5yGf9DfeW7bLElVTfbfV3jHhbwTUKeBhm1/E5+EIi
   Yi/3t+MT/BmgRm9FLV7XbDxkQxbUnoPyh96atIQngzAs9Oe+VA/x5wes7
   IUwQ6aLcspQbr8L6LrTDMwAk95uXDn6yLfHsq4j3jUYgYpjToVSpMNUSl
   c+v6xDrluBFrRvFax4F3YCuBAeHdrgxm22b+Yv0M45J/DQhvfb9JwnbDq
   Q==;
X-CSE-ConnectionGUID: 0dtVqZfuRuiemjgWmtxKyA==
X-CSE-MsgGUID: SWya0OxpSomzbc3vRnH1Mg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11841906"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11841906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:32:09 -0700
X-CSE-ConnectionGUID: s2dTP3L8TfuWYxL3N+CCCQ==
X-CSE-MsgGUID: 0o+oyJlAT/CIhpJVGI4C1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24875648"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 17:32:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 17:32:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 17:32:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 17:32:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaXkCPizYcpc82xotyjxOVK1oxZVKZa/GA4tXH6BRMqiqyNEvXtRiNzwZNtjvpjUFyWyNEa74WlRd8B+QJ6FdFWTwW0Dnb2ZCrax26MsJVycDwMzM0ZI5PWXAN40xP86G5IE+dpZWiJ6/X5MMo2vHcE0HVk9Yyc/Fa/fMBMMeCSLOGwSoJl7Qb7UQTtZDhp/IMvmXEe9/fDc04YjXnMCeUkIZkOXpLwsuwjzb13rl2GKYPrffgUKGPQ2HRtUTmg26/VSaL0gLJFwedfQuiKb++f1e0UrK2EPj+IKPO2hAEQlZBPxOSs5tHsPvP7clrTI/JPTR26tzkNDJlgxcPM5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffRsiZf410j4gGokrabDhqA8uTbQgSm6v27tbkHWusI=;
 b=iyBRBlqvYdbdOm7hzjcb9ExE2Bgjytsi+sebqTtqXQN0jEAlbd41wo/4d3f0yW3eQOubwdw1Jl4tlv1ijbH6qnLsMOoDk9Wg8TMI438yPKsw+nhlRepthGdokEcLYDCGNf4WChplvAvkYUuVHIjnhPUE2k3X3q4/90Ylxx8R9jBO47TogJIxdYtw8Z6/os4Y6g1RDhfOThy/Ryes/OKon/2p7Rcsnwb3ukmQU+py/wfu6i8o6zimzc50SWg5agJZPXCCQ6K0QZTfxotKrEPyiOWUQVdXU76Gf7+Fofe77G1c8EqO80bllTYbtGn2OJmd8W/U4rYxnHJYfDgQAuefbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.21; Wed, 10 Apr 2024 00:32:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 00:32:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Baolu Lu
	<baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Topic: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Thread-Index: AQHaiPoC7RpD2axGS0qZEPwCpJ1HeLFe3nWAgABnDgCAAPAgAIAAdL7w
Date: Wed, 10 Apr 2024 00:32:06 +0000
Message-ID: <BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
 <20240409103146.0d155e45@jacob-builder>
In-Reply-To: <20240409103146.0d155e45@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6400:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GOPstMBOxNKVR2cF+Bk11gS8Ry3C3d5OvzwbaxGe5sB74CLuYPReEQ2XXm1TkMcq8JVU2V8gwhblcUbRU+DuaUNLqK4JbRHn7xUSAeLM+DF/1lBnHUwzSsiEIY653dVcBo6OqiqUos/61QRqJiSLL8WTLxv6pXnaoKz6Bm9aFpo20g00PMRVkJ0PWvuKMzrHwLzvggiJur50b/RL+stSavrFUtI/QXqhEHjF3VLANNcu9RdgeEVNXBjd1NlhPBGqIiL0IT5ReSS4PSmrVuQOJagHfOOZza3M6cshnohYPGaOEEWfxIFmq9GQ06sZKlNSpTEU4Unx26FQxXagCRRgSPsRSq6GL1nnmwwc8A47cTmStMgEf4O8rZgY7f825TvNuAT0L06cyJmIwyEEz5ICFapcoYU0XoQbiMjZy9fuI0xO6EVP0UPcl5j3DgQSxiFjKTiDEgjGB+UeGSK93Rcw9R9Sr7Dklu+qEINizaMUAbGL8GpWzuyEkG2sOQqgbowZVE2IQXkjZjQttfi9RZZ9oqZarye6MLXl/bhubqWOMAi5UJ2nYrMF070KohGRYifAwsMa1ntXnD9oWIPzpJ36VBB8kuScbi10QceKuAHaP9S/So96GViu6DOaDFVrC2M9/x8/SbegEkpXJ1iMu5M2byCtu4kEzSkwOc/eZYy8EM8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ibx+u2dlB07CqQRo1VA1zpzvbdmCSN2bq6x04lca7gKRXcXRVEvbz7rLyls?=
 =?us-ascii?Q?TmTvU6JukJZSLVp/R6x8mG1aMtK9uuwnLzKrc6MmdsEYcfmqnUcu8ODFNVF1?=
 =?us-ascii?Q?QL8wHwbYVtCitD1/jQv1yMOwi4DfaHC9zPQBNm9ppwHuw5toQy+1XQHQ+AyJ?=
 =?us-ascii?Q?ZzdZOpmPjOZZrrEzxV60nUarLJ6ksqCLQwkDC1r6C3wSsMrfm+Cxs5nY6yjq?=
 =?us-ascii?Q?RxxcT/pnPiTf++VLrzg6xmtpRcJ8zCqVENRJs0v04fpj6xM1hWyTKSeBc5j5?=
 =?us-ascii?Q?NFI9XhNDsI7S72z+bOXWp/FjAiAcItmnHn/gCLt492DUcECYxZOCZAkU3NnO?=
 =?us-ascii?Q?o/T3ia2LpLZwm8PnurdWZlzcHUQHDcU9ODS2TEl5+FCOrdKhuzFRq2+d14CB?=
 =?us-ascii?Q?KBipSk2Qvgcv9keVgYDltiIt2N2CbSaFsyXITJiV/N3+psi0k5lNOz72QZwo?=
 =?us-ascii?Q?d2BLnz176O3y1qycZKHfJNDNrBI4FZEgouIamaOYoDj0nnUhvHzoE24uSZrk?=
 =?us-ascii?Q?3epuaKXEoAYtxQqDR9tiVFFGunbVzsvKrjx8B3PqRQ3RA4Cv4X79mTX94HMw?=
 =?us-ascii?Q?EY2zOOP762xIheRjoeNLKIYwMjMwkICJ/enniOf8fwpdLXBzwqp9H7k3rPjM?=
 =?us-ascii?Q?9Sr/Wvez5SLQvB6x9E/H0FMFrcq/sUX2HpXMXpX9nhAvs+m+LAnq0Rsya/Pl?=
 =?us-ascii?Q?h38j6+bY+WQaooew0Ob5XPoSuwBwwwLSmkXAS128n93kkfWV1seeAfRx7Bf2?=
 =?us-ascii?Q?g0HZLY7zrxBmN/j794K+8Vmw2HJYczYZZJGdztSPU26rdFyz8Gn3C7hSvl/r?=
 =?us-ascii?Q?ZD7UblhEUwlk22+X9d68nDc8cusBetrPar/AJYI28VaeeiBIaCDgyvR9Nk43?=
 =?us-ascii?Q?cPZ8O8Te5TipnkI1AmkHtZRMs5pDJxumqjIpABxBEyaBTo6oc8rKF38o8Ovn?=
 =?us-ascii?Q?QefCXAd3T/mNvaOAByVaLcpz36ogzJUwkDf1TBDLXsig+VDXbXMrMNpE8nx3?=
 =?us-ascii?Q?HhNIWlmCjPPjLq2UNkU+ioFFsMNn/w0tyti+TbRMlwbfkWSZxquZnpc8IZHk?=
 =?us-ascii?Q?GGk3D2lzWLJRBfUsqxjiRP3FHj1EUndTAGF9v8V6khDAFB+GpurONz6Yy/dN?=
 =?us-ascii?Q?C3DcZpX6PvgBfvtYu9Z3NQwIxgkTqyR3qCz9GI+fB1AZitTjn/jfooRPukS0?=
 =?us-ascii?Q?l8hk+r6uPLSF7BBXhgT7oaXxdvxWDMgQDt/yXsnJP6IWh4N69erXBsr5/zsg?=
 =?us-ascii?Q?fsHYsmkvyvKNsVcF/4Tb7F4zyeViviJsnaWPVtX90GBzgx4QSqAJo6h0tMSo?=
 =?us-ascii?Q?XAAu1I8tLW16WjPB4oaMj/HFwDxn8c9zaVo6LZnUgxd+bQ5Td7e3m+3qFf7D?=
 =?us-ascii?Q?nD8M/l2xXOtIDD5n2bPmzbco50JUxSlLGH6hZoZJdqtsFJik7wltcoozUQl3?=
 =?us-ascii?Q?5Ur6mZb04Jk6AKkcYdaQzhKQC51h0Ye+secXv/kWPg7cdTuJrznvx2NNyf9b?=
 =?us-ascii?Q?Mt7IvAzN6g1wN4RQ5zIlSI/X7WRwpkA2e/hOwmKJypap/zGVpa9lOKqABh3a?=
 =?us-ascii?Q?sb2L33pCvq2NhqQ/gv7MSRBxWk4eQgJlGt6nAwL5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a9f1a8-3cf3-4477-7f95-08dc58f5a673
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 00:32:06.2244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85Hk1sSQaQ/r2As/vy/dbfdwFgeJUWsRXc4HRqYWUv7wSIubQbFiAC83COKfoikKcc6I6/aSa5uSZNBcj0HYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, April 10, 2024 1:32 AM
>=20
> If the guest uses SL page tables in vIOMMU, we don;t expose ATS to the
> guest. So ATS is not relevant here, does't matter map or unmap.
>=20

ATS is orthogonal to SL vs. FL. Where is this restriction coming from?

