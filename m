Return-Path: <linux-kernel+bounces-28711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BB2830222
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9B528599E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719211DA33;
	Wed, 17 Jan 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTJi09L+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BD1D6B1;
	Wed, 17 Jan 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483181; cv=fail; b=E1/ye4JbtFl6E0POCG3n+EXCM/6pJWHsiWgfHEKTWNeyHirdnVxv/luW6myQxvidQyFD9YHZmGDwi8TArulrxHqreA1a/gLFgaq8yHZeFw/eC0s9v6hB/aJCH+ULZThBTDBQRaEmxPKzrSas3V2QsFZNkkA0lBg1PfoefYs0JQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483181; c=relaxed/simple;
	bh=0VzFOaErNfjBx8Z8iopIGneHGPRm68F4CBSvJhcjTIA=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
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
	b=sukQwWdiy0rYDa0Tkn/rL/R0n7Gp4Ffdog4x4KsIY2ByxAHT6GsmzWzfeNgRQc0HcdFd+alrLF9vga0dJ+Kl2t4V2QkQ8aW6iXzWj9gwIP5XGNbtXuJIb/eR9xBhNUqp/iR2DL9wHlnMfc8sYy2SzR7eheyUaNwbT9xqZX3d6T8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTJi09L+; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483180; x=1737019180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0VzFOaErNfjBx8Z8iopIGneHGPRm68F4CBSvJhcjTIA=;
  b=hTJi09L+bVJBlTpHAbqE0k3uQXcxIrW97jxC5OLsb4Pppv2JTvWQNJNt
   OTzfeUTRcq+zV8DhV+OzQwu27ySPJBswdaJgc25rqEXsSW8tOx/z0/IAi
   Vq5qPMdPmIkSAGNJCFZivzt0ozvHcKVn4Br22jku96bpnuMSa/p7ZSDUH
   xI5Lc5Efmwt5ftB2mIvO8sR3lclA9pnuXxilhIRJDcoPoR8FAZ4aGo5f4
   auAMEPPngjpSVTX0lg9OUuJCFPpn9VP8aBQLRhdtyFSbSEw6KtRHpYlrf
   BeJh766DvOA3ndSUYulMqIyB5FFHA8m7pzlyHzonsoh3adIu1Ed1zJuQV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="18711927"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18711927"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:19:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818459177"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="818459177"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 01:19:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:19:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:19:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 01:19:37 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 01:19:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYERZQMBvdQyifYS+KH+stiHA56v1ShNVBIJW1yTN0BJPap1+ANj6fvyV6U0pm2lP0Yzzgj66c4lhtBtSRKyvwMY4QfV8fmYRJWAYNYLi0xlVn3vm5OzYKBRGNnf7/TZDhQ6HWo5yam1FN2Vs4x1+AaQ2S4xCnqMLJ9w39qHITgxEql5xRTpkDQwMGPq3JMN5AgmTCfVecKjHO7xpibKlNjHmngqlRqYvyAS4dbYpbEqoPwJPJzc5ksmy8h+yxjQ8CLw3uuLghPCBybAeWLEn2fkWz1AlueBPFw0d9NGQGX/iznw1qTKNXxc+gn2NHJb/tZOd7dinxH1yWpekwCkzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fhTV599RIOuIZnfNncHU1OAy04cE/2VXOI4evyWuDU=;
 b=nSY+jpz7Xcq38kyaU624hAsFScIvbx3hR/X3ASsRNGtvTEX9Q+adzc1cHQTPO8qqv2AjsXp02iyGd0VI8hr/hLcBWild1B01/vJ/Y5FVbU3o+Xz7PcDThZMYYTEa+sPr1RMbG5KeFdwISkZsFmskA1csqAfdGdKspKbgwFeBRVJt4fFhYjFlk3yZNcmnEUTblaNjdzvKjfwzxkJDm2/bEqQZrep5szcLAEwZ0b02ibpzBOC3LQJYMuZrkI+vxO3suPFh3G8F29TVZI9JMhrC0XRj71gLxPIKBvcB3xyc/hLEW/+WdzLlpZT/8aLcFH9h+2CNDVoybFP8/wizDFw8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 CH3PR11MB7894.namprd11.prod.outlook.com (2603:10b6:610:12c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.31; Wed, 17 Jan
 2024 09:19:35 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 09:19:35 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>, "Glaza,
 Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v3 2/3] dpll: fix register pin with unregistered
 parent pin
Thread-Topic: [PATCH net v3 2/3] dpll: fix register pin with unregistered
 parent pin
Thread-Index: AQHaR5ClwHLdlm5ZHk+0kNxRBDSVwLDcD+OAgAGtUtA=
Date: Wed, 17 Jan 2024 09:19:35 +0000
Message-ID: <DM6PR11MB4657AD4F70BA302F8DEBEC779B722@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
 <20240115085241.312144-3-arkadiusz.kubalewski@intel.com>
 <ZaYzUXmnS3czrUsG@nanopsycho>
In-Reply-To: <ZaYzUXmnS3czrUsG@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|CH3PR11MB7894:EE_
x-ms-office365-filtering-correlation-id: 9cff50d0-dac2-470c-908a-08dc173d6c2c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ee4lgYFCP8I9jaNPjlvH0XXkbWQZdbdNh5tTif5HSUnTpFDG+AshX8vHDk2F70tUyAS7UW6zTQElR01L7XRmzrCpb54Fry3JEejfdAgjL7Pxb33JjGiaGLkFQFOS4gsgWRyzmjI6UPuU/wCwVm3Ud2zmeHx5S+1u7P3Q+K1r/GncNmccCAjX11JB52CPy0bZ75iWb1hpbEEbGWBEDKuhLw41S8HuW5ZbyXc+iv37lYYtemsBU2Tus2zGlj94JQBifwG6nf9lNBtuw0X9EfNy7t65wZZ/3kDAAv1IjcsBs/V0Ruqs/27IQiLHIPwe/sI3XJTEyJcevgwr4xsLb31pjpbURNT7/VrQguJETSxjm7kQszWuxQJgUuMjhZKLz4330Jll0EY3e9risPb58EWpI7n9lszT+abFwi8oylwH5TCpZcT/CMcKx0tD92ISOIAmfE+245YzJbsK8wXAt6p+FH9pTolJb9kVVhf42vEBO8y3Pmhf8f+vls/8N50+jHAScHzbUbvWTGOsVeNwFYbMC/Kvua7IJNnsCVJxS3HKb6SPHoo3YnG3FOoMRzrTwloN12byU135OU8ziFR1XYA3ZkNBDbjfua8AXJenaIOXXJO1pDht8/E45nrd6cHQU+cK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(122000001)(38100700002)(83380400001)(38070700009)(33656002)(86362001)(82960400001)(52536014)(316002)(6916009)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(54906003)(2906002)(8936002)(4326008)(5660300002)(71200400001)(26005)(107886003)(478600001)(9686003)(6506007)(7696005)(8676002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGvhVMi8O7DdbPJRPZdUAiVGkCXRJ/OIlZfw0xrkLsUG8qphRduBtLniu+Tz?=
 =?us-ascii?Q?+seddm4G+l39HOqHnbaTXtvuNI7cft8eIDQJ6ascGNxVeJp+2VZlxRqt48gu?=
 =?us-ascii?Q?XyV8Trti0tVRcnyY87shGfzRUyi3u/ZOULrQnf2TyzdYXxdr8B3EIGpeFov+?=
 =?us-ascii?Q?9gA0Ze5noguxyYwJRazFHeSkITXs1BmJOcAycRCjVNEPfRfE2DY0fAKSsioA?=
 =?us-ascii?Q?Qkix0Wca7c9S77600+CW0GE6uhy5xxCe5yrpWfGdAtwSXcdlHDMxIiKfAuLF?=
 =?us-ascii?Q?UqpZxkiuKnBsyemu3GIJBo5atg4Ryl4YNA+KGWRD3PUs+D4lR55Pkixv1B1O?=
 =?us-ascii?Q?CSSwH75HQCSyXdPXy+XNjj3xjvqcoUtmUnc0MaG/N2c5ntIaWWXY/6Brbz5t?=
 =?us-ascii?Q?8c0xunNDp/VtO112lEKbn7PzqYrz1kpL/wnmqThw/9lvzkWTZX1Ovcjqb12z?=
 =?us-ascii?Q?oPDah1/6nWsuLzjkEMlHi5WRZK4H6t5c4U8tgCAtxNvMeXvJaRPDNv9EVaUI?=
 =?us-ascii?Q?Z0vL1WoQImJo9tIIyG0sTAQHiyJ28xng2j4waGwlT+2WpeAouVysFXy2087v?=
 =?us-ascii?Q?FbNkgUSWDOJg4VKrWOOs4WB13+Ai3qHv+IyJ3VAwlrbt0Cn4jsPTKK8lT+7U?=
 =?us-ascii?Q?apghe9pDufMtm2ISd1Neb3RbDv2OyT3YwlRs/ygUnidG50Zf0F3PcLFx+Jgn?=
 =?us-ascii?Q?FURFsUJ0jmB8jMhynOaq+YgBgs2RwlqbUf5SvgD4sjcXq2N9OaXe+Q1fPTbn?=
 =?us-ascii?Q?Z4H77T73XypnQ1qJYnHwb/QNWfOZv+kiqYCPEU9Hyz3ZYRJdT+W+XzqNp8ss?=
 =?us-ascii?Q?D8KVOTUk3o/3ihrYZkbN4eP8qeqF3f1d9MaFwjSPQ6wMTWHg9ViTyp/YeWxv?=
 =?us-ascii?Q?0mNaJkWIfrYy1qREoPomYOqjzJy9gekJIfHM5N1pqF6AcVi7rbt72EPCANxZ?=
 =?us-ascii?Q?RiiR0t5QDMsXLAAXWfKgPlL5AXqMnN3xyaNHRG2/E+e6tRszmF8bB35ey3Ss?=
 =?us-ascii?Q?hPjGU6mF9KQFulg9mNOBP5EheWoI+QRgGdFpatAknoYm5C6BljTRicZc1Nj5?=
 =?us-ascii?Q?GzDlMRGG1lRBYOc5A4VaGMT5BFOK7Zp79n4uMdc/qLgb4G+xxDNf4iZfz0lx?=
 =?us-ascii?Q?P1LtzQlnXqEIIYAUZlxC/Vcg/ut5scF4gW03Xvoj5Jy7LNMQv666a6HUGk+L?=
 =?us-ascii?Q?fyulawkeNWRQnIhKifhU96puQVFprzLdLIamRLo11it0A1HpmF9mIBTLNwhJ?=
 =?us-ascii?Q?yGKTk21j27BGvNqBcTbBoGYCYwgmXMhdzMKObIKNyztBlqEhOjKb//ysKdHm?=
 =?us-ascii?Q?3e6XBDEo7uRE6cNQtpj4E6MXv5In3ia6FJNCV/YhQNCt/+0g/qxiXWbQQLVq?=
 =?us-ascii?Q?lpS2bEMRfOGf9gSVLIGuDqEBTni0ItlJB71luFTk0xQpcK2KHXCpVMVdnHRl?=
 =?us-ascii?Q?2LIUv8vPjY9FF96lZxyOiHs1D+H3TJtvk0Kr7ZpRRXru8Bm5Ian+JWX+Gqc/?=
 =?us-ascii?Q?oBKSq4EF+F8viEwOrOy5NHinVhFR2GQghNaozNhSbiSg9FbV3I+V8albqv+V?=
 =?us-ascii?Q?Bo9TnSByEJ4Yje7HG6t5KE+DRmhuJwpu4HtWR75rTwiJxIJ7M+gmrV0I2OBv?=
 =?us-ascii?Q?rw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cff50d0-dac2-470c-908a-08dc173d6c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 09:19:35.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPFOpXD6gXqRLu+1HmxUuQxM74thXKWPKRa13B6dJe/s7cg2BAmz7ffh+bVTwQsaqK8zHKCW2djxuD5sM+3bpsmZqlCnhZ5Wp0HU1x1uzM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7894
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, January 16, 2024 8:42 AM
>
>Mon, Jan 15, 2024 at 09:52:40AM CET, arkadiusz.kubalewski@intel.com wrote:
>>In case of multiple kernel module instances using the same dpll device:
>>if only one registers dpll device, then only that one can register
>>directly connected pins with a dpll device. When unregistered parent is
>>responsible for determining if the muxed pin can be registered with it
>>or not, the drivers need to be loaded in serialized order to work
>>correctly - first the driver instance which registers the direct pins
>>needs to be loaded, then the other instances could register muxed type
>>pins.
>>
>>Allow registration of a pin with a parent even if the parent was not
>>yet registered, thus allow ability for unserialized driver instance
>>load order.
>>Do not WARN_ON notification for unregistered pin, which can be invoked
>>for described case, instead just return error.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>---
>>v3:
>>- allow register with non registered parent dpll device for consistency
>>
>> drivers/dpll/dpll_core.c    | 6 ------
>> drivers/dpll/dpll_netlink.c | 2 +-
>> 2 files changed, 1 insertion(+), 7 deletions(-)
>>
>>diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>>index fbac32af78b7..69005d8489d3 100644
>>--- a/drivers/dpll/dpll_core.c
>>+++ b/drivers/dpll/dpll_core.c
>>@@ -28,8 +28,6 @@ static u32 dpll_xa_id;
>> 	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>> #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>> 	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>>-#define ASSERT_PIN_REGISTERED(p)	\
>>-	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>
>Also, for consistency, this could be called from
>__dpll_pin_unregister(). But that is net-next material.
>
>
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>

Thank you!
Arkadiusz

>
>
>>
>> struct dpll_device_registration {
>> 	struct list_head list;
>>@@ -613,8 +611,6 @@ dpll_pin_register(struct dpll_device *dpll, struct
>dpll_pin *pin,
>> 	    WARN_ON(!ops->state_on_dpll_get) ||
>> 	    WARN_ON(!ops->direction_get))
>> 		return -EINVAL;
>>-	if (ASSERT_DPLL_REGISTERED(dpll))
>>-		return -EINVAL;
>>
>> 	mutex_lock(&dpll_lock);
>> 	if (WARN_ON(!(dpll->module =3D=3D pin->module &&
>>@@ -692,8 +688,6 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent,
>>struct dpll_pin *pin,
>> 	    WARN_ON(!ops->state_on_pin_get) ||
>> 	    WARN_ON(!ops->direction_get))
>> 		return -EINVAL;
>>-	if (ASSERT_PIN_REGISTERED(parent))
>>-		return -EINVAL;
>>
>> 	mutex_lock(&dpll_lock);
>> 	ret =3D dpll_xa_ref_pin_add(&pin->parent_refs, parent, ops, priv);
>>diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
>>index 4c64611d32ac..108c002537e6 100644
>>--- a/drivers/dpll/dpll_netlink.c
>>+++ b/drivers/dpll/dpll_netlink.c
>>@@ -551,7 +551,7 @@ dpll_pin_event_send(enum dpll_cmd event, struct
>>dpll_pin *pin)
>> 	int ret =3D -ENOMEM;
>> 	void *hdr;
>>
>>-	if (WARN_ON(!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED)))
>>+	if (!xa_get_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED))
>> 		return -ENODEV;
>>
>> 	msg =3D genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>--
>>2.38.1
>>

