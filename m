Return-Path: <linux-kernel+bounces-155835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AABFE8AF7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FFF1F235EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911D81422D8;
	Tue, 23 Apr 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThaVFPhX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC92213D522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902727; cv=fail; b=Ur9ye0bDQTgSIXvC9LCu6afdvRNHcuOGD95L5HqWgtNYOMh+ccHbKxxy/p4qwvjEhJ8t3QKHCUFbvvPehfFt+URANP0VeDA4QJexboeGkonHpicGdqLsrO7wGqPJOapv+l9fkZQ2/v1xixpabK4GPl1NH29/2PBFMM0rwDO+XYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902727; c=relaxed/simple;
	bh=b3+rWShAyv1dFml4DyVOCw3minSSi6L9FhBLo8vq+gg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9JefXYLvThybMGmAMU7UWOjRNgp4blgOrWzMMEr5qphn89WIDduj7BLiZWn4hPZ6A5buEfK4H15YofxaWZc2K/QU1q4TLg3Yw+lGzoK0ef+c8+tjD92a6j1u3Rb2JIrYe6XWetcj0qumNvrkZgp3hevv3816sddBHQ7FU3vz7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThaVFPhX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713902726; x=1745438726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b3+rWShAyv1dFml4DyVOCw3minSSi6L9FhBLo8vq+gg=;
  b=ThaVFPhXS08mnzMZF3Ioh71PuNMzZCwPiJ5w1IGeZXy+u6aINwLhnts3
   FuE56hvX/pyHJEUlL+kqypoB+sYoWj1FeHYkZPb2kYHryyPNooc00kugk
   PlGV3bc+U8gKMcpRxU1zCQUdmPQan02IfpdLgX7w4FSJh133ltxoihLSG
   QX6+yVhcYFkw+lIF/FEOQhvjGf1RJ87g1O1JXlOQcLW52QNrPY8yMk9uf
   sRP+jZ8uiZuRlWgvcUbvQucFW6EB3XhLKbBdju1iYQyi+rUXDwFNpbNQg
   R5UEn6GsdUWihOTvBBZj3YBdOEkDcA9aWVf80QM+IlWHu8HfHq1qBhFXD
   w==;
X-CSE-ConnectionGUID: abSdBDE7QH6u5R/aj6KtbA==
X-CSE-MsgGUID: rD2vDtQTSdiRPKvWQ7SWUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20121581"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20121581"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 13:05:25 -0700
X-CSE-ConnectionGUID: /9Gmv9PCR+a+tG3b/xGxAg==
X-CSE-MsgGUID: Sv88p5/eTgqsmUfsPmvxlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24506300"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Apr 2024 13:05:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 13:05:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 13:05:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Apr 2024 13:05:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 13:05:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S114GloDq/3iJUsUBX6Nj+UCzD4KC8v7/A1zhvpukBxOIiB8dwKx30miFGt76YkAV1s26ErwPuqTQG9lyC3UEETQhFXvwC5aBfa/GrOfUpHLMiWMDc/M899ccn0b9vJs5JpveEVY/L5mf2wSNSIpeohMfvnq05PKVgEUJ9caaqoU4r2WX+UaPq6EJfEQHsPDIuhp8mO1Kh+yhLMG33HxJqudwMveiMlPcoJFoEw62+BMuSHpvPnY401DeUmiaqajt7c/0dZ83EnJZJfu8nyzSojaYA0D9+GA2LQJ5TcFa9l6Lu7OkpZbgvsAYMLftN1hzTi2LgwIBg3sfxS55qumLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3+rWShAyv1dFml4DyVOCw3minSSi6L9FhBLo8vq+gg=;
 b=mMSmF4b8BtjoUC/lfySMvb70Bsl3sindVvKJGUFvs763iBdBMFAPMYnhb6qPooPVkoE/BzVI2TiJce89TM5tCQZp12QpfMQA6xtDq8wuE7EyCg3reL3pk/YDpQlol5Sda+v9Xr4fgw0d84N2mHmYr5PQbmPfPot+BrMjEaaANIlu7DAFZzKzxJfuHelVeGHyTJ9ALcDsMOKQUFTFIZwCETCZunRDkoNOrWUNBLfeRiGKlIOaMMRyVp5HKytP7yup/l+ykNucf8OwxUuYvfB02x84HKJFEpxJRVT9XViCCsMN07KvyO14zsUCbMGLvX4/vIkT+fTbN7O7Fg+DWz0yAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CH3PR11MB8495.namprd11.prod.outlook.com (2603:10b6:610:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.21; Tue, 23 Apr
 2024 20:05:22 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::d720:25db:67bb:6f50%7]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 20:05:22 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: Kunwu Chan <chentao@kylinos.cn>, "arnd@arndb.de" <arnd@arndb.de>,
	"kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Thread-Topic: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
Thread-Index: AQHalSiMY12PPI1KcEW/2xbBxOJ0FbF2QxYAgAADaQCAAAIWAA==
Date: Tue, 23 Apr 2024 20:05:22 +0000
Message-ID: <PH7PR11MB7605AF4AE2845AF0AD7A7C17E5112@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240423024133.1890455-1-chentao@kylinos.cn>
 <PH7PR11MB76051D97AC76E8FCDE464F2FE5112@PH7PR11MB7605.namprd11.prod.outlook.com>
 <2024042350-lend-unsettled-957f@gregkh>
In-Reply-To: <2024042350-lend-unsettled-957f@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CH3PR11MB8495:EE_
x-ms-office365-filtering-correlation-id: 63760698-b79f-4254-90f8-08dc63d0b52f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+LxvGkaK7tOMyHnbjmRFyl6yCpxOTRLokG1Y1LmTYX9EbgLx8hLA1d74P4lQ?=
 =?us-ascii?Q?kJA8T0vNl+zziRB9RrA9j1HG2DuRrgUXF5itThIxzMPIRmPRLtlALipNdtZA?=
 =?us-ascii?Q?1yyk6GiLjiJLmtKG4+v5NeJ+847MuTa4M8Ba44qgNLPhYArC437nVGblo4+W?=
 =?us-ascii?Q?IyC6e0w7OU+m+FxW+KjYDQwf7nbLQj5Jk9FW67slb72I11Zrg7I+vY8O/SGX?=
 =?us-ascii?Q?BIrmsWPyq9s6f5hSg2ZqE45QqzCzROMdhYehU6wPyjmSUUpdYY5R4LzWBzK+?=
 =?us-ascii?Q?gxsObXg9IH0K/jfAitchnqfCqYTtJn6eVdtIv3LnZ+WNFASXQlvEUOJERiIz?=
 =?us-ascii?Q?9YDfTOQ7vMa8DGO07KNx2unoHOl1UEcXlJPYTfSgn80037n1Gf81DNr2WoJz?=
 =?us-ascii?Q?Fu2cPG9iix5NK3drO1S9w6BnWxoy5Bvwd/ROGh31BK2XMPy+T0nD3k9p5Crm?=
 =?us-ascii?Q?IK4ApZJmumyjpa8Vm2hgKZwDMeb14RCWUI/CumDd2KQ8hmxsEOZXCVyoy0wj?=
 =?us-ascii?Q?gJpdodd3XM3CwHmKZuQC8yhNYvalWq2aMftxZH339AECUyO67MIYkeip9EnB?=
 =?us-ascii?Q?WF0f35QsDK38++bZiN3x60unv5dlHf0c/wcc+vp3BNyUitiHyHBzRl0NE4qm?=
 =?us-ascii?Q?cNRyOVpysar7kXBSkGQB1AuY2KWutwtCISBERBl9RrBYby213VV3sxGphPIG?=
 =?us-ascii?Q?FDZvqYC74ax41VIiaAWiZr27q2cTOTTv6zIDK0WYFUl/903vYflWJjyx5O1v?=
 =?us-ascii?Q?ZMKHrMuCCu4uSPCnczvwg+DMvIJKIsWY820ccZmHy+TEP/CR8CI/pnrMuY4t?=
 =?us-ascii?Q?t/6xx7Vo/554743C3+8Wmzum75+bQeChZ7GQ6scYMJlddFVvELDzNk5BztOA?=
 =?us-ascii?Q?bV3zff0o8q3pCGHU6JmnnLy4tyQmFKcjsZiZRQGPiKkHqVrAwPrzeZSjA51g?=
 =?us-ascii?Q?/FD5vDEmC7Q7Io4Y1irSjESloB67Xf33Nj4P3Y9lLcNKN+EE0gOi34RaOl+A?=
 =?us-ascii?Q?WCNsT6ie9M+qlC40M/joBKUWPLiu6ELjQCr56XFZRDQDGGWPnlEbHF2olvwH?=
 =?us-ascii?Q?NzUK+wMxKLjCPCCxuGE+GgFEikYRUjZwWORY8eFMweOR1n8O1EKJZCecLm41?=
 =?us-ascii?Q?jJsGIhVmMM7T2hCCAxTuxyJCdYJLwTOSHLDDGmHWIx9nnxbrPQ9p9SvfiqfX?=
 =?us-ascii?Q?75mlSUkr9I7J4OmpkkDHncpNMpm4DW93p2ZHvypUj5g2QE5yNuFbzMWOf+Xy?=
 =?us-ascii?Q?l14JTlgBDLt3ET9bjq6LnTBo9pYiJtyMnwUW7btaFJkOk6wMGMzJ3OstsXUN?=
 =?us-ascii?Q?ikvc41DfLXjKqkud4syVJjuLgrNVcikuhw2EPiGPZnuXaA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XbVpx7dKunl6S65EGkWvdoFHWEAI87rEo+PAZ900wFrLyknWt/xpz4Dhlvkj?=
 =?us-ascii?Q?Zwb9V9J+JnLev00Q5r6xqYDINFrUHO8PwJQfMfvdwa67WDnPptua5cNxBUAl?=
 =?us-ascii?Q?oL0J+SRI7FhimPOx8MpPaUeWxzK7ggHjVxkmU4pCgnCeQ5BCi7HWdNlES8sP?=
 =?us-ascii?Q?vO6uhfmT+fhPOWjC55O9Pq+U+hc0GK/x2b+R/FzGwWVXf4oQyyC33bh/cOfV?=
 =?us-ascii?Q?ViTARxQDL0DvqxELXDNd9h2s6Hjh3pv9MSdzROzzqbrzLWoctbfFGmLEdmU0?=
 =?us-ascii?Q?Dl4KnkEZatci+HRg//V0W/dYvmi+UYxv7L8X9Db7Z6AtdUi3e5BZN1BzX4CH?=
 =?us-ascii?Q?xPkoCQyhNlZrtBLSMWs5ePj+9flUjFnJ5MheW6v7/XC8RIj+QeLSHPOuPW1x?=
 =?us-ascii?Q?tKrg9EecR5A5VV0AsUVU8e0PetSVdftxUHAFvfUdlqRUAAnXzi9qpg1DFQ07?=
 =?us-ascii?Q?K/VKnHzbZScyaTy/DH1zBy1fr605JrU0JJF88QOMsr8xcbJux/qrXOPTDfCx?=
 =?us-ascii?Q?RoEpbJm2ggEy21aWE+TZ/6GxFQ6n1euCFP+d/Tr5mDmXUzNaqazq/v1pHqKi?=
 =?us-ascii?Q?PIg6PWYpToqtUZrXgEu1FBsDV8kurF7ZPoK3ja3dIlPsEvQf1bcLy5oM/r/h?=
 =?us-ascii?Q?thfBL3/T+yksp1AMxFkiO54mFdRVpCCeI3KoAPQZsjouhlBhwicWlTRVet3W?=
 =?us-ascii?Q?PNe+FxwiUndQCkzovDT0fUBzpdU1VrBHgUEzzvbOiQWSoMi/O0x3K3e/vvuM?=
 =?us-ascii?Q?5CqT35OJdIqdOjqTXJUcJsUCRfPWge28D8tY4amHld9vBSsoIXDC9mXWzNi6?=
 =?us-ascii?Q?jWxRUb8qqQ6Hi7sKyCEF2QtMpBMh21khrYxR0tJKvwao8il41FlR5P6VybUV?=
 =?us-ascii?Q?IUJFpHy53BcLiiQHT2VJ0ij8ZyHaHZsi3mKGS7q5f0sCHiziyZcD71lS+BAM?=
 =?us-ascii?Q?qYNgeComM7f11hXx8RjUZj57n5jtDDMa66CrKCJ+JhIGqfVpE+6lmwEX2iTU?=
 =?us-ascii?Q?W7Gs1LD5fBoxgbDdLZs7o9owpv3W2siFts+Mg3QSbiCWKlvJRZuGkfTyhV6T?=
 =?us-ascii?Q?LR6sspHT+m6l4yJae8db0BCfggd0KcAVi3ELUd2xuAmo5LUbXs2HOH/khTiH?=
 =?us-ascii?Q?nq3Xkfetj5yOD3w3hgcD1lQkpJKFZ45+G++Mv9QeNfeMTOOrPkFDQhub6DwJ?=
 =?us-ascii?Q?R39VEEf/c75mE1ln0sDXamp5ksZwWrvlakaRfP/3uHEyjTZfZ69QLssmefQn?=
 =?us-ascii?Q?5UDRzdLGIXIM51KGWCziJWAD+FjQhSIGMUhUl5jvNvdlrpfmjcMAsVWf2R4z?=
 =?us-ascii?Q?VfgiUAWP/+bYrWUGF0E+St/kSPij4DZ61Tikp0aaQdglt6yN4iK3xTasxEUN?=
 =?us-ascii?Q?isEDwI91e1R06uvqv5j+X32jIG1YbRSWwJJlwlxgCtI1+SRS/DLq0Ldw+KAd?=
 =?us-ascii?Q?w4LqB0PWhjoY3hMtM+XFEKJIqrLYnRfYoWUp4t2xwHIOjFMCES0a0XDB857z?=
 =?us-ascii?Q?R78d6LenRSSmUe1rVwLKMEoXla/XC2slQLnT5AE/OWIwMseA+t33nvu0E1RD?=
 =?us-ascii?Q?sJD4fpfG7fiawfEXKofB10J+56e4AlaBTfmMZqjm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63760698-b79f-4254-90f8-08dc63d0b52f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 20:05:22.3654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpHXAkzctD582cNGpBTtVKymJHcAbfV1O/wm68LzmJQIXCQ3zuAit2Ga/OtFsZ/lujuopBJFvEGzN1SQdMWSQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8495
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Tuesday, April 23, 2024 10:57 PM
> To: Winkler, Tomas <tomas.winkler@intel.com>
> Cc: Kunwu Chan <chentao@kylinos.cn>; arnd@arndb.de;
> kunwu.chan@hotmail.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mei: bus: constify the struct mei_cl_bus_type usage
>=20
> On Tue, Apr 23, 2024 at 07:45:08PM +0000, Winkler, Tomas wrote:
> >
> > >
> > > Now that the driver core can properly handle constant struct
> > > bus_type, move the mei_cl_bus_type variable to be a constant
> > > structure as well, placing it into read-only memory which can not be
> modified at runtime.
> > >
> > > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> > LGTM
> Can you provide a "Acked-by:"?

