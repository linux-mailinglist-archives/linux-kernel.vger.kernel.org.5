Return-Path: <linux-kernel+bounces-28720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BC383023C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501641F2783E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339E1CF8C;
	Wed, 17 Jan 2024 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EED6ATqb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CA1BF25;
	Wed, 17 Jan 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483367; cv=fail; b=SdYal+X0EumynVnTbfiMYW9/7f8AFFISHZSQxt30SF1gVAjKrRPJOt7dNnQ8nccKvdpPBcCPoPA6zgvN4xnSGgPRfDDHLYMvw45UgEnRZ170o+vXUJIkZzfive2Ca38BZmZuMs0ns6lY5/ov9xzeQsRp3eQ6h45YkN+a1eWF4UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483367; c=relaxed/simple;
	bh=B0vC4NsYxv2cE+ZnPz/XPqmMnx5RHjqVkXY+7PkJysk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:Received:Received:
	 From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ld-processed:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=XOcQ+r2aHlIw89NIabq8FVVVs1ooinKjS6RXuqJ8qW1ueVvNFnczu+mmUyqtWcGbS3w6zbN8T9dXhU4DR/BhrCASUMdbEWdHWsfzZ4EQs+Er0l7tBDW1j2DbSwcHy4uY5NKGNSGM0pjsperleTR+Kog/tQq/PueuJbss7y5t/r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EED6ATqb; arc=fail smtp.client-ip=192.55.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483365; x=1737019365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B0vC4NsYxv2cE+ZnPz/XPqmMnx5RHjqVkXY+7PkJysk=;
  b=EED6ATqbXI77iQfH+NBSV7TMFL8+j/rR8Nqk12hNGS7RhD5TBSVvGMzG
   cjv2qYJDxhv0gSQVFQ7ENFR6AcOfBPv/7El0QxFPfxmGIor/gt275nY/E
   fE1zVHFjRerUWTgTACkBa8bna8BzOtHD/hzSzXPW+aYNLm36VxSvmyBJ7
   Petup1jd05W8A7r/QFmoGhR8q2iyPoc3JDygvyluP1zoFUEUEoxRylDim
   FyxWEpzGhh75s4t3bwfdpn2d5V8v1v7h4CUCCWt2oy7SQegNOwexI/KKh
   zdfzlf0+/C0ZTCSv74Tm868t7JZJpcZUW0buN33HoWMf2ah+bz3hZjHkG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="486276213"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="486276213"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="1031297043"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="1031297043"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 01:22:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:22:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 01:22:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 01:22:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMuP/dTHxiKKZ1TFytVSC89cMlLHV0yzImfExwd3qzaeCL5Sc3mn2SuefM6NUrYYgd7VuddqaSJDHH5rfXLnZPqTI/OqhiaaTS7KxCLoJALdkUCvpKuK9bjFWMawBRRITET6/LkbT3vCsgbzDI7g8+O0Igy+XcUe1Jq0+kPKBZwtXTKru/JIk73VPzHWzKiRp0Bxq92nJANlaq5up0G61C+9NiDbxBhcRfiaLqaqiUwqQhmr5asx5dWg/WX7o9ANm2G49eBpfn0kqn2HMhfoXDnezYU/aytfr7sM6EsxCALUyNjbq0OFUMsfm3RMo4fFvo8n228SJrKUE64168szxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1u42qNdFZ6FP+J3O2wNDPo3nWczydTjpO+tdpEle2hQ=;
 b=aMfABuZM4gQNY2NhPH0jhyN0zdTgQxQGXtAXtCyjOf26muV/THMF06EkqrZX7xTE9bGauBZ2EiVqVgoSynatsfY+Kg0ZIE0JaNSSQd/Qk3KyP35uqMxIdD4AiLimiUW7c2zzSuJOcanT/rwUAToU+0BmCuzMM5pXIU8XcgzbHg9qdCIpJgD2N2WXWylC2Pre+9NAE9t3XidQDVjcbpVJM+jV80Zel7ZR+MqW9VoBy72Pxaebl3HdFBEr2Yn519/I6Xctry+Y5JYUX1T2DkEANUF+MjDdV2DKfMRMLhLZ8IWN7U8FMApM8uiSxR0Btc5QJRj6xZF7qt4irj397rs7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Wed, 17 Jan
 2024 09:22:40 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 09:22:40 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>, "Glaza,
 Jan" <jan.glaza@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH net v3 1/3] dpll: fix pin dump crash for rebound module
Thread-Topic: [PATCH net v3 1/3] dpll: fix pin dump crash for rebound module
Thread-Index: AQHaR5ClEEpG0cXcvUWhcYYw07aC5rDbQYMAgAJ8BdA=
Date: Wed, 17 Jan 2024 09:22:40 +0000
Message-ID: <DM6PR11MB4657B312964E35622709B1619B722@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
 <20240115085241.312144-2-arkadiusz.kubalewski@intel.com>
 <ZaWGMrzj4wNC-wT3@nanopsycho>
In-Reply-To: <ZaWGMrzj4wNC-wT3@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH3PR11MB7894:EE_
x-ms-office365-filtering-correlation-id: 476f2d63-1749-4f2b-cdf7-08dc173dda75
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nLnL6kFmuhLPWW/JuiUWCso+5hCsyXGP/OJkkhcPBea9V+Pj+uLr1dBaTH9zlCDsfLYHFBwBL2fcILn9+bNC3ZLeBbHuaZa6rLOE24sNqdWZntF10Dbvw71e13uUhMlgZucL+F41j2rI5v6ZSRBkoGRh6SiKWPmNwGw6hl4j4A4GdWg/2p3nXox60p0mmvGgwGRtYIbW8J015sZeyX9NCwWIRbp5tUwEnckn2NVjaSGIq/rYsAFYwWYUR4MvkjJPxRctKnsFJ3CNF4uc9gs14sVXyN+BCpbWqBR7lLEMhyST+haddF5Gr/+yjGWYews1f5rFevh8NWMZZjSPbj/cuLIuWuaLHpxoIX+FCYpyjSaF7HYxQ59CkNSomiQXNzJJl4qSgXKK31ZWMJkGITeEWp2vuq5ACcqwDujkoo7/sEoCiQNRfc11MIrHOXpiSpe/pVSsWtAp66Pk0RvWq9P8l/IURuhwOJLz2g/wPOKwZ1oqXp0MqkWhUlQI9Um9s161mDEaTQyepPdG0G8ZCK0SbqxCWN7JLFI7Iy/ngENRwDlr8BJRL1bMuWdIkadG6Msfkuq+tbxLbe4N8dzB+4itUDbNT68ewVnJplG2JODDiOb4laFF8k+dvt2vorqi/XN+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(66899024)(122000001)(38100700002)(83380400001)(38070700009)(33656002)(86362001)(82960400001)(52536014)(316002)(6916009)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(2906002)(8936002)(4326008)(5660300002)(71200400001)(26005)(107886003)(478600001)(9686003)(6506007)(7696005)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?08vcbV12dyp72eId4uDmB0eDunMwunWm+FxLkDhZmwjw9AI4ptNKvfN7b76y?=
 =?us-ascii?Q?JiIA6H0HHVQ7RniOhCoosVDMqNrIlxA9FTcIy2r4254LzLLLPyT/HGwUqDrW?=
 =?us-ascii?Q?a3EZ6LkuRV1xuLxZljomFsuZ5FSR92grb/6G8FHKOMJnueOgbhPIA8cG15z1?=
 =?us-ascii?Q?xHIfq53kaCIyzj6vbR4/ndjRRXK3xzm1b2w9esxnLTQjfF49OsFLCv3tjSRl?=
 =?us-ascii?Q?XXhQZwmy54f/nSWef6RznQDi0mjisPEVLLnfEQjT4KaPuv9oB7sLMuTj96o0?=
 =?us-ascii?Q?vIHbZeSiHqbziMN/5Tjt9GDq2IrVkKwjM/EMQPAOpBJVkA+kCyRXf3vdShfw?=
 =?us-ascii?Q?YLKe9DkvBMe7C0di6WdpgsZPU99wzVxgkRJ/q2gXhMHfH78rK8pZpvgAelD8?=
 =?us-ascii?Q?OHZ/67mcyRz2G3hN3LYGHrMFaJRUE27gr1Xoi5yMwFtgYEgl9gU2yfOFTWLp?=
 =?us-ascii?Q?b349N/5a0ywp1On4lWp/G3g0Ki8Aj7S6Mg0yL1ChT90+n2kcLrlHKPt5Xdr8?=
 =?us-ascii?Q?TFiRx3oPcdRG+ODceGX3ex5rlAZOcNnQA/1/iEIxFO7tDtdSZxFtGx4qvz2c?=
 =?us-ascii?Q?QgJb0p3ABbJfQkPTFH1CGUqPHh10tdJCGWiIs7ms2B/zeU7USVqnTjtz4Yqb?=
 =?us-ascii?Q?iQWlt+3Ztukp185gEvANdWDHZQZCl5sDEN7KO19WYSTIBHFhpueKebZSPqEj?=
 =?us-ascii?Q?t/5E/GtKA5JcceGv41Fg1Befz+AcxQNUifXkcu1b2yMm/3oHCEZZlxJt0ZwL?=
 =?us-ascii?Q?831lCFsYWNZOPaSLCDgG3vKoDRfSeG2HOiBjtIqsCmkqJ4EZg9CNEpI9qjba?=
 =?us-ascii?Q?35quVoTBn0rV4T9SvlJOPqYeh45oeTUUeZ1Qb2/usnOePLW9f0iZVf+Yt7Ce?=
 =?us-ascii?Q?QVKyFJl0zhLnckcJNoWcSZRZ/xOz5N3U/6FuV8yOQvoo4vBaFfMOqO2RwVPe?=
 =?us-ascii?Q?JY5pulO1lmixnB30/NAO+DHVKt8tDS+nHTFhdFvQiUICtkLqhdupVbq8BXhi?=
 =?us-ascii?Q?YA/MI5tHLHnvx+sl8u/7idTWZfM6F2C7SVR2/m7FLBhn69Id//+JDD8Km1mJ?=
 =?us-ascii?Q?erfzs9rlwN+qe0U3vMKM5vnF8fBifTpUsndkFQdYnB2+oyoLE5qPup8mFh1y?=
 =?us-ascii?Q?cqm2/KFWrV1jOTxWN0Q8dAkX0sJjj1IAMRPblRz90JaTqi27yW+cxFG7DJ4K?=
 =?us-ascii?Q?44Obggv4duNHXc4WdMdOqptcFAv9b2TH43BqvwPh1uyfUKWxo2A3zRCUaoMB?=
 =?us-ascii?Q?NRlRh+zTSUpValBzwsBbxwJ0m2y+QIujC3F54y6+FCT27ToG1dfv+A4TUy6I?=
 =?us-ascii?Q?wijlDly87yviaJJYHcSrl1BmEmeME65I+gaNw1zAB9caHHRYGlcFRa26+h/Z?=
 =?us-ascii?Q?s00KYVCuAavoTmb9hhzkW0/tLUafvVWEPZA878anOWPbpewDrW/amGx0uOxC?=
 =?us-ascii?Q?sOQ1Bb5snEaipF+S/xLsT8gvgpKvTg7lRuGC0h0D3BoH35fHitTTwAzGmA1q?=
 =?us-ascii?Q?FWYiEIe+G77eO3pf7oyZD9LSFyJXH9X1ppOJhahseRT6IpBHLVQm5UiEae2b?=
 =?us-ascii?Q?tD0cSkdl7X3c+4+fNe231xPtkehVuNv8v61WlpSmXAjpe5tlAPMVjCNHpFms?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 476f2d63-1749-4f2b-cdf7-08dc173dda75
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 09:22:40.4816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aYxqnC2DSAmKYvuAs5ZVseT/sfX2rfDL4ACSfy1kU/5YckwqAgNTPgCApn0KDoM877HT9iLYtK60qc+cTlltl3x8wo3TE2i9mTneYPyjx+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Monday, January 15, 2024 8:24 PM
>
>Mon, Jan 15, 2024 at 09:52:39AM CET, arkadiusz.kubalewski@intel.com wrote:
>>When a kernel module is unbound but the pin resources were not entirely
>>freed (other kernel module instance of the same PCI device have had kept
>>the reference to that pin), and kernel module is again bound, the pin
>>properties would not be updated (the properties are only assigned when
>>memory for the pin is allocated), prop pointer still points to the
>>kernel module memory of the kernel module which was deallocated on the
>>unbind.
>>
>>If the pin dump is invoked in this state, the result is a kernel crash.
>>Prevent the crash by storing persistent pin properties in dpll subsystem,
>>copy the content from the kernel module when pin is allocated, instead of
>>using memory of the kernel module.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>Looks fine, small issue below.
>

Ok

>
>>---
>>v3:
>>- introduce helper functions for easier pin properties handling
>>- duplicate property labels only if not null, fail if duplicating fails
>>
>> drivers/dpll/dpll_core.c    | 57 +++++++++++++++++++++++++++++++++++--
>> drivers/dpll/dpll_core.h    |  4 +--
>> drivers/dpll/dpll_netlink.c | 28 +++++++++---------
>> 3 files changed, 70 insertions(+), 19 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index 3568149b9562..fbac32af78b7 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -424,6 +424,53 @@ void dpll_device_unregister(struct dpll_device *dpll=
,
>> }
>> EXPORT_SYMBOL_GPL(dpll_device_unregister);
>>
>>+static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
>>+{
>>+	kfree(prop->package_label);
>>+	kfree(prop->panel_label);
>>+	kfree(prop->board_label);
>>+	kfree(prop->freq_supported);
>>+}
>>+
>>+static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
>>+			     struct dpll_pin_properties *dst)
>>+{
>>+	memcpy(dst, src, sizeof(*dst));
>>+	if (src->freq_supported && src->freq_supported_num) {
>>+		size_t freq_size =3D src->freq_supported_num *
>>+				   sizeof(*src->freq_supported);
>>+		dst->freq_supported =3D kmemdup(src->freq_supported,
>>+					      freq_size, GFP_KERNEL);
>>+		if (!src->freq_supported)
>>+			return -ENOMEM;
>>+	}
>>+	if (src->board_label) {
>>+		dst->board_label =3D kstrdup(src->board_label, GFP_KERNEL);
>>+		if (!dst->board_label)
>>+			goto free_freq_supp;
>>+	}
>>+	if (src->panel_label) {
>>+		dst->panel_label =3D kstrdup(src->panel_label, GFP_KERNEL);
>>+		if (!dst->panel_label)
>>+			goto free_board_label;
>>+	}
>>+	if (src->package_label) {
>>+		dst->package_label =3D kstrdup(src->package_label, GFP_KERNEL);
>>+		if (!dst->package_label)
>>+			goto free_panel_label;
>>+	}
>>+
>>+	return 0;
>>+
>>+free_panel_label:
>>+	kfree(dst->panel_label);
>>+free_board_label:
>>+	kfree(dst->board_label);
>>+free_freq_supp:
>>+	kfree(dst->freq_supported);
>>+	return -ENOMEM;
>>+}
>>+
>> static struct dpll_pin *
>> dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
>> 	       const struct dpll_pin_properties *prop)
>>@@ -440,9 +487,11 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
>> 		    prop->type > DPLL_PIN_TYPE_MAX)) {
>> 		ret =3D -EINVAL;
>>-		goto err;
>>+		goto pin_free;
>
>This should be a separate patch, fix is unrelated to the rest of this
>patch.
>
>Also, user err_something consistently as err_pin_free, err_destroy_xa
>etc.
>

Sure, fixed in v4.

Thank you!
Arkadiusz

>pw-bot: cr
>
>> 	}
>>-	pin->prop =3D prop;
>>+	ret =3D dpll_pin_prop_dup(prop, &pin->prop);
>>+	if (ret)
>>+		goto pin_free;
>> 	refcount_set(&pin->refcount, 1);
>> 	xa_init_flags(&pin->dpll_refs, XA_FLAGS_ALLOC);
>> 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>>@@ -453,6 +502,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct
>>module *module,
>> err:
>> 	xa_destroy(&pin->dpll_refs);
>> 	xa_destroy(&pin->parent_refs);
>>+pin_free:
>> 	kfree(pin);
>> 	return ERR_PTR(ret);
>> }
>>@@ -512,6 +562,7 @@ void dpll_pin_put(struct dpll_pin *pin)
>> 		xa_destroy(&pin->dpll_refs);
>> 		xa_destroy(&pin->parent_refs);
>> 		xa_erase(&dpll_pin_xa, pin->id);
>>+		dpll_pin_prop_free(&pin->prop);
>> 		kfree(pin);
>> 	}
>> 	mutex_unlock(&dpll_lock);
>>@@ -634,7 +685,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> 	unsigned long i, stop;
>> 	int ret;
>>
>>-	if (WARN_ON(parent->prop->type !=3D DPLL_PIN_TYPE_MUX))
>>+	if (WARN_ON(parent->prop.type !=3D DPLL_PIN_TYPE_MUX))
>> 		return -EINVAL;
>>
>> 	if (WARN_ON(!ops) ||
>>diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
>>index 5585873c5c1b..717f715015c7 100644
>>--- a/drivers/dpll/dpll_core.h
>>+++ b/drivers/dpll/dpll_core.h
>>@@ -44,7 +44,7 @@ struct dpll_device {
>>  * @module:		module of creator
>>  * @dpll_refs:		hold referencees to dplls pin was registered with
>>  * @parent_refs:	hold references to parent pins pin was registered
>>with
>>- * @prop:		pointer to pin properties given by registerer
>>+ * @prop:		pin properties copied from the registerer
>>  * @rclk_dev_name:	holds name of device when pin can recover clock
>>from it
>>  * @refcount:		refcount
>>  **/
>>@@ -55,7 +55,7 @@ struct dpll_pin {
>> 	struct module *module;
>> 	struct xarray dpll_refs;
>> 	struct xarray parent_refs;
>>-	const struct dpll_pin_properties *prop;
>>+	struct dpll_pin_properties prop;
>> 	refcount_t refcount;
>> };
>>
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index ce7cf736f020..4c64611d32ac 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -278,17 +278,17 @@ dpll_msg_add_pin_freq(struct sk_buff *msg, struct
>>dpll_pin *pin,
>> 	if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY, sizeof(freq), &freq,
>> 			  DPLL_A_PIN_PAD))
>> 		return -EMSGSIZE;
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++) {
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++) {
>> 		nest =3D nla_nest_start(msg, DPLL_A_PIN_FREQUENCY_SUPPORTED);
>> 		if (!nest)
>> 			return -EMSGSIZE;
>>-		freq =3D pin->prop->freq_supported[fs].min;
>>+		freq =3D pin->prop.freq_supported[fs].min;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MIN, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>> 			return -EMSGSIZE;
>> 		}
>>-		freq =3D pin->prop->freq_supported[fs].max;
>>+		freq =3D pin->prop.freq_supported[fs].max;
>> 		if (nla_put_64bit(msg, DPLL_A_PIN_FREQUENCY_MAX, sizeof(freq),
>> 				  &freq, DPLL_A_PIN_PAD)) {
>> 			nla_nest_cancel(msg, nest);
>>@@ -304,9 +304,9 @@ static bool dpll_pin_is_freq_supported(struct dpll_pi=
n
>>*pin, u32 freq)
>> {
>> 	int fs;
>>
>>-	for (fs =3D 0; fs < pin->prop->freq_supported_num; fs++)
>>-		if (freq >=3D pin->prop->freq_supported[fs].min &&
>>-		    freq <=3D pin->prop->freq_supported[fs].max)
>>+	for (fs =3D 0; fs < pin->prop.freq_supported_num; fs++)
>>+		if (freq >=3D pin->prop.freq_supported[fs].min &&
>>+		    freq <=3D pin->prop.freq_supported[fs].max)
>> 			return true;
>> 	return false;
>> }
>>@@ -396,7 +396,7 @@ static int
>> dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
>> 		     struct netlink_ext_ack *extack)
>> {
>>-	const struct dpll_pin_properties *prop =3D pin->prop;
>>+	const struct dpll_pin_properties *prop =3D &pin->prop;
>> 	struct dpll_pin_ref *ref;
>> 	int ret;
>>
>>@@ -689,7 +689,7 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32
>>parent_idx,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -725,7 +725,7 @@ dpll_pin_state_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -752,7 +752,7 @@ dpll_pin_prio_set(struct dpll_device *dpll, struct
>>dpll_pin *pin,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "prio changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -780,7 +780,7 @@ dpll_pin_direction_set(struct dpll_pin *pin, struct
>>dpll_device *dpll,
>> 	int ret;
>>
>> 	if (!(DPLL_PIN_CAPABILITIES_DIRECTION_CAN_CHANGE &
>>-	      pin->prop->capabilities)) {
>>+	      pin->prop.capabilities)) {
>> 		NL_SET_ERR_MSG(extack, "direction changing is not allowed");
>> 		return -EOPNOTSUPP;
>> 	}
>>@@ -810,8 +810,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct
>>nlattr *phase_adj_attr,
>> 	int ret;
>>
>> 	phase_adj =3D nla_get_s32(phase_adj_attr);
>>-	if (phase_adj > pin->prop->phase_range.max ||
>>-	    phase_adj < pin->prop->phase_range.min) {
>>+	if (phase_adj > pin->prop.phase_range.max ||
>>+	    phase_adj < pin->prop.phase_range.min) {
>> 		NL_SET_ERR_MSG_ATTR(extack, phase_adj_attr,
>> 				    "phase adjust value not supported");
>> 		return -EINVAL;
>>@@ -995,7 +995,7 @@ dpll_pin_find(u64 clock_id, struct nlattr
>>*mod_name_attr,
>> 	unsigned long i;
>>
>> 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
>>-		prop =3D pin->prop;
>>+		prop =3D &pin->prop;
>> 		cid_match =3D clock_id ? pin->clock_id =3D=3D clock_id : true;
>> 		mod_match =3D mod_name_attr && module_name(pin->module) ?
>> 			!nla_strcmp(mod_name_attr,
>>--
>>2.38.1
>>


