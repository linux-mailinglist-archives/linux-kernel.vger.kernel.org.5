Return-Path: <linux-kernel+bounces-159076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC88B2904
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24AFCB22E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C4152504;
	Thu, 25 Apr 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5dU3UvL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84BA38FB6;
	Thu, 25 Apr 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073144; cv=fail; b=Fk6P0wjmDKCiSyfbxLoioOY7tzl+w50DTBpxTA3Pi3Fy34uC4aF6nCQZIeuNqO2Sd4ZTmeAem0XzaHyN0NTusdNl9jZM5zPZg3jYxaFzs1QT6YzXBPlq2ZyusNAw1g7MYGT5mr+k+nsAOmcPZkuQjiOU/9B/RZseYsec94epmL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073144; c=relaxed/simple;
	bh=sSJ1K7F6FvM8ZwkMep15lLdZ5VrhkMUUi3Ft0OIysnE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sz1lYZTlrs6GFKJolIq3sVFkyTlB5QMR5Jap1VT1W+WcCkgzz2AU7ULi2sNz7b/Sn1+WT0zs/Stxr9OpYgkUACOwVoh040/fhXQ2j71XdWcnqq9kGg4vBKlX3kFI/8qWJ+7uoYnkUNrf+IygVsdj8tiObPcAX4K2gOeIHqR9mE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5dU3UvL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714073143; x=1745609143;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sSJ1K7F6FvM8ZwkMep15lLdZ5VrhkMUUi3Ft0OIysnE=;
  b=U5dU3UvLzyOl0mwr0srS3S4PydYdH9V7+EEqwcoK9QkMNyLfv5NGaqGi
   ikKcFRZD2lU8sWsM9s05uMZNH8e6AizTcQxr24wKHgdy0HoTXOvxSuXSh
   NBctmSccXhKW7RRjYoXaLW+B1wRSmYEiDYB6Ba6BiF1FFvQcbqOlGzw/v
   jm/49tLDWPg6cscBECOaRmaghOu6VamKYuh6ciBYsOpbwQtnR4YE0N+i3
   7Avg4MzkCtaumOP2JUlN62nhDXq3maP0paPXb82s4qUp/Sa8e5jIylvTd
   yY34MV+C0tkLAJVfpu4aZukqE6VQuhU8b5Obfa9p5wK8uL2OpXy0C8WFw
   w==;
X-CSE-ConnectionGUID: HIUskRCDRE68ZzjtMVtYYw==
X-CSE-MsgGUID: 1wKhUb5cQse221CeaKY3TQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9638497"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9638497"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 12:25:42 -0700
X-CSE-ConnectionGUID: eoOf+HT9SHuhsb5b4CrCvA==
X-CSE-MsgGUID: i1Nz90TzTxW8dH3QQjF15g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="56350156"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Apr 2024 12:25:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 12:25:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 12:25:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 12:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UW6VzLl82beNqNEYEY5Um6LUyUlngKsAgIfSvlhfrtzmpeGvG1o/JOdRy6T/Dfmc2uIdpHryLt1s7reYeXZ1tjnE/zNT058aJbgI4y1HvThcmkNZc5dVb0NFLJmkyny5LbdK4BOQTac8IhUt6YtjLvi6jSBweySafsD1B6A0nBSEuBrX4CJa+Uf2xl4xw6GiE4bL1Cb/lhXgXNY7Cl/ZhrW8FiR681AzAkS8HYuVuah7uQc249w79hgEZcET2nrWibg71e2cXpoEdCrw0o1Yw7r7pFVVf2mSAdabePCAItazU+MT3/6LPQ/kiAHJNY+puO8qwmlbv4DmmBSMdn/9iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubmyJxBawGLSDngfLHTD9ft7DWOS8k4Lk1y7me4HJtg=;
 b=XKBZBsSa8K2js2i2i8Eq8JWjsBHqfinKpvfsC8BsFnBdOBE3VxgnOYo+JHK/N+cFsH7Wzmf7Yc8FUvSdg5i8JsAzQdyau/oOtilHl14u9HkbPBeGyIkQ9RTtS3qZOPJQQatQ2bmN99fdPKIl3sq9wtLvoM8gz3+O56gnfsTbDseETrugpI13L+GVP3Ux7z83a9ABTKME9G9JKVNU951NZdzh4Xh11MfaJYCSk1F9V4Cda58vY61JGPt/xgjawX6f48yEH1dyX4503SNVEx0L5qUOniUXyf7zyuStk40AvfXrkW6LZOMC70Lyhi7XaiMuSjrEXBBPlq/1fzm34Nw/Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB8228.namprd11.prod.outlook.com (2603:10b6:8:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 19:25:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Thu, 25 Apr 2024
 19:25:39 +0000
Date: Thu, 25 Apr 2024 12:25:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Sreenivas Bagalkote
	<sreenivas.bagalkote@broadcom.com>, Brett Henning
	<brett.henning@broadcom.com>, Harold Johnson <harold.johnson@broadcom.com>,
	Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
	<linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linuxarm@huawei.com>, <linux-api@vger.kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, "Natu, Mahesh" <mahesh.natu@intel.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: RFC: Restricting userspace interfaces for CXL fabric management
Message-ID: <662aae2fe4887_a96f294bf@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240321174423.00007e0d@Huawei.com>
 <66109191f3d6d_2583ad29468@dwillia2-xfh.jf.intel.com.notmuch>
 <20240410124517.000075f2@Huawei.com>
 <66284d5e8ac01_690a29431@dwillia2-xfh.jf.intel.com.notmuch>
 <20240425123344.000001a9@Huawei.com>
 <662a826dbeeff_b6e02943c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240425182605.00005f22@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240425182605.00005f22@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:303:6b::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 223fa650-020a-4836-78ff-08dc655d7d53
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5xXSN6rgtI1a1zBK2OBSbkrkbgNSLh6AYwGHmvTVT8YlvVpEkwm7SOF1PIqT?=
 =?us-ascii?Q?hUFao96mhTkzBwmXGlubNvfyWZM9LRzw+aqe6RuWX1tG+27PjCKPLyg6J5e5?=
 =?us-ascii?Q?2vECpePGI0gmG8VREAxNiOhbHo7vCjzcnF8GwUdgLiIrpKKno+DvoNAw5fzZ?=
 =?us-ascii?Q?haw1ts76e4ud0ipd+5/fre4dhEcAxjcTIe1VnVJsrQ9H2n3Sui6zZ+Uptvu5?=
 =?us-ascii?Q?xO8q4PHjQTOESCi8qf8FD8+sJdDrfhsPpqYDvsC1j+P4BftMKR02sw5iW8Ey?=
 =?us-ascii?Q?QIRP8z0SX4C27Gyf26m45oYpolYfsfcRnG/CVXS2nV7Vwf9uVW/tRjkMFKkt?=
 =?us-ascii?Q?TWTy7yCvUReQdC/PI2xnmN7olfBY/1c/6RcxPuYS/EF8BKRp2ziUGhM2kzUd?=
 =?us-ascii?Q?10unLcnvaOD3vYHqiqSd1WCQt097kk45PeqaDx9stFXtLpQL2sJVKkU0KZGq?=
 =?us-ascii?Q?f6Gh1AK3QjjJy4dSeoQSFtLjVMowWggoOC+JlJO33mnnfJ+OJbAcxxkbJJ41?=
 =?us-ascii?Q?43xwguctHI0OkxwU1heKqt5zuvi2LeSwifH5ATSr6wqv6xniRjXNu3tfNHgQ?=
 =?us-ascii?Q?8p5YvhoqFcf5+rgrv2o9kDVYGm40CWvm/IXqbjR2TWVXUmB5f+KzlOaJC8rB?=
 =?us-ascii?Q?ro5++ncLbYmaqrv2anL18TgK5BG7Ybf1C2xM7rgXu9gyJpelYEypOifoznF+?=
 =?us-ascii?Q?2KyXmB4KuRth47m5DtL/KIfKZStHLSSJxAfa7foGJaNiGCgXVIxPRMS5MI/T?=
 =?us-ascii?Q?o4J5fLghcZZd1Mg54T+MHEKeN0tTB3J3CJ135pkLb8kn1bNAu/odBSzkppSw?=
 =?us-ascii?Q?lUEdsEJXpsdCYCXVVYraXsByLznXTvkR64DFN4kPxi4Og2jNzW2Xyx6KXDPd?=
 =?us-ascii?Q?jwUR3XcZ6eAVEWdSCg794uG82/PFBLxtwdPJWMXq+rPvrS6VPhZoCYsoW34k?=
 =?us-ascii?Q?8JURqRMAf4J7nNhov2rLIDK3A2AV24ArR5RD1BJwV2JtZrvsrb8L32CAdlvb?=
 =?us-ascii?Q?mZddn4Oi9AE2z/aiVoG3c5TBRhvpa69a2Qx9exFseIQVVmPxi8V6+Gj1KfWb?=
 =?us-ascii?Q?xsENTgHd6sXk0MDm3CN6z97J4fJ8agA7bYvBVTuSzPTj/p5KIa5Kl0Sj5QWO?=
 =?us-ascii?Q?SvLEmXpes0fiOvu4gQHwTtMj0qsfR6991bcS9rQFTmzGlGNWVoPUzy9KjH4b?=
 =?us-ascii?Q?+Hgpj1v00WNx/HdSVfSYBxHSI+84/zl8x5D33wn1V/h20T+Y0YRCPx06HeAt?=
 =?us-ascii?Q?bilyt+lRjYUTs2Ywh3gni+8aAhNYZj7+4wgqyvd1/w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kBuZ+2NBu+82GQZkDXbzmNXg0NuKcW3QS7ntLRuPtY1OoJgnCLbPQ0qjq+qu?=
 =?us-ascii?Q?PLkVkc2LvcxTRFQRnaWB9eM+D1sFxzpaXCcp56fAK6vUnQFDpRWFTkqhMgHY?=
 =?us-ascii?Q?yJlCk76o6VdvWGeMHDPJphj/csXjwznbsPIlR7TNIdlLgIX9ck/DJwlJ3gLI?=
 =?us-ascii?Q?+mgTIsVVcitwT4M2cO42mwAAr15VVfLJ3gdCyR8bfAEf8aZaqEFo2RXM4hpo?=
 =?us-ascii?Q?NbZkBZ59I+ly3AtSY7bXB046PDGpQGw/K8DDrdNOkzPzSzOECu7/p3Xsm6yH?=
 =?us-ascii?Q?1H0V4Gl8es5zpsspgjSlSOhRFE4XmjiiMj3kk1P6fiX1EvuiI+tILGmC+eVW?=
 =?us-ascii?Q?MPr6Jhl9NfS2H+TSqHag+vEHune6oRVEXMtozUCC9hNd1OHGhplqqJSfh1mo?=
 =?us-ascii?Q?1AjwOzvEwF/rZc+mWM5SuI6jn8CLywfMuLi2EFe+Dyko3U6ju9r0nA+WW3iL?=
 =?us-ascii?Q?ga7kQuBzzyG3PtghdHWWBxE+uksfMmJF60Vg5cqN98G0BR0Y31nto736sj2K?=
 =?us-ascii?Q?H7sWpv6EtwXoHWJ8adXlcaJ8xo3DXAX1GceevNKp7IUEd/Rizfc4LNpVFUHD?=
 =?us-ascii?Q?09GXRwDenDFaVUEhY5Oo/zOk9tIAYG17dxWOaZkvoW0cU/fw7o9dScAkrsQ+?=
 =?us-ascii?Q?GX2TctoWC2h1KedBlFv9bJQWsc4JjVv/dVKHjta3QNnZM3HUugs61U2Oxg2D?=
 =?us-ascii?Q?/4O4vDeMAZfHP4MMX2HXsx+ihdOZg6815XyRK2+YBwYnxEekDUK5+BKoaXoO?=
 =?us-ascii?Q?HOs4fzUb6cToJRZKpfyBhiSyLYL/G+EJUIfOeb2rZDPFSFuCnf4Jw2VD6FWg?=
 =?us-ascii?Q?4aXNkstgUJA2BBOJJaDQ1wfmtI4qMKFkeEljLTWOr1mkWI2wM3NfP2q8FGEU?=
 =?us-ascii?Q?W6yS2YhKvjgVR2ow61gmCe8C0W1Gv6+WRKECSD1YtoH5WJIji1Z8KnrNMmMC?=
 =?us-ascii?Q?eo9EEaxfw5fT/wrdXuC6L9kuPMKObxo8EXOcoh73hLAWWc0J7sU+UTGcnK1u?=
 =?us-ascii?Q?bp2ILVBOre8s4cuM+v2CscznhWV2Di4e1waYmjYsoaGmw9NVAtVkmNH2EgLt?=
 =?us-ascii?Q?KizJAxp6EN7WwESHc9tEJMdqnOTup2x2eQWClryrXc7NlDgrpCKC3n023Dxe?=
 =?us-ascii?Q?hfbNZojRsRc2jKStKDFkgymPJnJgechzqElHRJiXN2g2HxtNxCHe0bBKuqp4?=
 =?us-ascii?Q?yuW76uftu8x9TZmfpyV7gdVpHzLiwRKqi2Ct9x//MYZ4R+oaCJ+DxVVJXBiH?=
 =?us-ascii?Q?9k9gDDDma6jktH9oMxPIt7vd8/s3mKatJbPoo/enPSjB4T89lBoklyZ5ApTg?=
 =?us-ascii?Q?BwP062ZQwEXL+c75MvU02qRzYiSogf32Hyuav0hIhRtdWc9OH0LSLT/z+24B?=
 =?us-ascii?Q?LWFa5IVxO0AxmLZxdswkFde51X2VDYVYjD/+0jBOhcqVdp1vcKl/2fCl07rJ?=
 =?us-ascii?Q?cAGFCpdXO7OkztSzrybcMn+ondQ14CK3+4V+cKIxPvvVVM0Uj51CMPS94L07?=
 =?us-ascii?Q?0VaZ9Pz+hC8oe4sc2BJXRHvRIfmKj1wy5YKepqtVVgZe9yuu2sqi8p5Fw44L?=
 =?us-ascii?Q?kTo7B4ALZxvs3nbtgdpg8ShbPUyedBJkB5ilcbTdDPaQzO1ZZ2tO9lozheFN?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 223fa650-020a-4836-78ff-08dc655d7d53
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 19:25:39.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuSPI6HdvWCOsYiyJJEaGB/7v0TZvcelqtq54rdeeV6Cy9CpoOxDFC1jLzL3lnwCGy+LsRTqJcM5QHibuq3fCqKHds2z1Jqz3DC2WP2g6lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8228
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> Dan Williams <dan.j.williams@intel.com> wrote:
> > The minimum requirement for justifying an in kernel driver is that
> > something else in the kernel consumes that facility. So, again, I want
> > to get back to specifics what else in the kernel is going to leverage
> > the Switch CCI mailbox?
> 
> Why?  I've never heard of such as a requirement and numerous drivers
> provide fairly direct access to hardware. Sometimes there is a subsystem
> aiding the data formatting etc, but fundamentally that's a convenience.
> 
> Taking this to a silly level, on this basis all networking drivers would
> not be in the kernel.  They are there mainly to provide userspace access to
> a network.

Networking is an odd choice to bring into this discussion because that
subsystem has a long history of wrestling with the "kernel bypass"
concern. It has largely been able to weather the storm of calls to get
out of the way and let vendor drivers have free reign.

The AF_XDP socket family was the result of finding a path to let
userspace networking stacks build functionality without forfeiting the
relevance and ongoing collaboration on the in-kernel stack.

> Any of the hardware access subsystems such hwmon, input, IIO
> etc are primarily about providing a convenient way to get data to/from
> a device.  They are kernel drivers because that is the cleaner path
> for data marshaling, interrupt handling etc.

Those are drivers supporting a subsystem to bring a sane kernel
interface to front potenitally multiple vendor implementations of
similar functionality.

They are not asking for kernel bypass facilities that defeat the purpose
of ever talking to the kernel community again for potentially
system-integrity violating functionality behind disparate vendor
interfaces.

> In kernel users are a perfectly valid reason to have a kernel driver,
> but it's far from the only one.  None of the AI accelerators have in kernel
> users today (maybe they will in future). Sure there are other arguments
> that mean only a few such devices have been upstreamed, but it's not
> that they need in kernel users. If it's really an issue I'll just submit
> it to driver/misc and Greg can take a view on whether it's an acceptable
> device to have driver for... (after he's asked the obvious question of
> why aren't the CXL folk taking it!) +cc Greg to save providing info later.

AI accelerators are heavy consumers of the core-mm you can not
reasonably coordinate with the core-mm from userspace.

If the proposal is to build a new CXL Fabric Management subsystem with
proper ABIs and openly defined command sets that will sit behind thought
out kernel interfaces then I can get on board with that.

Where I am stuck currently is the assertion that step 1 is "build ioctl
passthrough tunnels with 'do anything you want and get away with it'
semantics".

Recall that the current restriction for raw commands was to encourage
vendor collaboration and building sane kernel interfaces, and that
distros would enable it in their "debug" kernels to enable hardware
validation test benches. If the assertion is "that's too restrictive,
enable a vendor ecosystem based on kernel bypass" that goes too far.

> For background this is a PCI function with a mailbox used for switch
> configuration. The mailbox is identical to the one found on CXL type3
> devices. Whole thing defined in the CXL spec. It gets a little complex
> because you can tunnel commands to devices connected to the switch,
> potentially affecting other hosts.  Typical Linux device doing this
> would be a BMC, but there have been repeated questions about providing
> a subset of access to any Linux system (avoiding the foot guns)
> Whole thing fully discoverable - proposal is a standard PCI driver.
> 
> > The generic-Type-3-device mailbox has an in kernel driver because the
> > kernel has need to send mailbox commands internally and it is
> > fundamental to RAS and provisioning flows that the kernel have this
> > coordination. What are the motivations for an in-band Switch CCI command
> > submission path?
> > 
> > It could be the case that you have a self-evident example in mind that I
> > have thus far failed to realize.
> > 
> 
> There are possibilities, but for now it's a transport driver just like
> MCTP etc with a well defined chardev interface, with documented ioctl
> interface etc (which I'd keep inline with one the CXL mailbox uses
> just to avoid reinventing the wheel - I'd prefer to use that directly
> to avoid divergence but I don't care that much).
> 
> As far as I can see, with the security / blast radius concern alleviated
> by disabling this if lockdown is in use + taint for unaudited commands
> (and a nasty sounding config similar to the cxl mailbox one)
> there is little reason not to take such a driver into the kernel.
> It has next to no maintenance impact outside of itself and a bit of
> library code which I've proposed pushing down to the level of MMPT
> (so PCI not CXL) if you think that is necessary. 
> 
> We want interrupt handling and basic access controls / command
> interface to userspace.
> 
> Apologies if I'm grumpy - several long days of battling cpu hotplug code.

Again, can we please get back to the specifics of the commands to be
enabled here? I am open to CXL Fabric Management as a first class
citizen, I am not currently open to CXL Fabric Management gets to live
in the corner of the kernel that is unreviewable because all it does is
take opaque ioctl blobs and marshal them to hardware.

