Return-Path: <linux-kernel+bounces-28706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DE7830218
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AA5287744
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C95814004;
	Wed, 17 Jan 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rn6+bbp/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F513AED;
	Wed, 17 Jan 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483125; cv=fail; b=naBqD/slR/p1o8/jo0lylQv4NY6C3JOBcVY+6mkPDmK+of9rNWRU3x3cBiYvhXfW6AqX4qOvuSJhUmrhypQ1xtxddF70ecq/mEF8p1IkJ6eYgODKTvKlVPhowbNaewpXiZ0oJCAPCaBQgEew45wV+i3FyaJVbH8HLVbzOvcxy1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483125; c=relaxed/simple;
	bh=/velZGJOl5nbX3pAs0+bSAt6AqlegqMDAns/bgzqj1k=;
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
	b=DuipI/jdpsNMtin0iYvDqc3S9udftjZpX/okEw8eBWFsPMJcUjCEZkmQGuLfuraNYsD9kmg/KPgy7UNp8cJpzp1zKmWdfrlKtpBkbITb6llURv9KFVAQexVrv30sszuRYAHCxL+wd0PPNfdlh+NVj9y6THTQlDAwXhldZob9RvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rn6+bbp/; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705483124; x=1737019124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/velZGJOl5nbX3pAs0+bSAt6AqlegqMDAns/bgzqj1k=;
  b=Rn6+bbp/iuDysJqoir6mr8YgGQvQpmkYEY/Qov/0jRH8b6sn5sx9SU5B
   FBtW0WPD+hIoe62P5y2PEwpdjI+vTG2srw7/IacuYNAq0jLGyGqu9ShR5
   eJsFvD6IKMJTBRacmtN31PkkNLls12WkneRbmFyHw/DoMVaTOstiK1I0p
   Miq/5yfpMTDIF6V/yP8HDT+aSehFIWkE8HmfCLHXmTPCBLRfB66ZrCgRY
   7B+EfNm+RTkIbd/Oju/ojBUAmL6zLEGpLkRQ9W4bC4AaOANLyPX3cgCIR
   MVZHeYOFqZ/GTtuLl8IjlZDTLmkCy8OexGprFBr7KHIdSxkrbxArWD3lg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="13474973"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="13474973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 01:18:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="854644711"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="854644711"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2024 01:18:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:18:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 01:18:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 01:18:41 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 01:18:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRvWeitTBMJc1k9jtdTmGjXVSDX3ONhGV0gKWHniGAFfBG9isDgl8na4w+0HmtYUcx71bCn4v0VfU33YqeYuLmeAXzNgN3FPSFnongs4q+U08+OVkMwPACHj2NmB2je6jBtT0onqLXKBJD7TufGLGKYRENia+odDvIAGw/kjslDRmDKnm4BK35NioEnI+3OHN5I9eTgSPixXlEr1lyoJXAGdc/vzI0uFu0nVIV3P9lia39xnWWCAjJIGz8D2l+BYrrehi6xhoZHNkqWQJ4V1bFncnkNMxKaFESNE8wBBNtlwKwp2ibjZeoXcFBhM1qYIF/tCBtLAKEBRm0bTohNc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/velZGJOl5nbX3pAs0+bSAt6AqlegqMDAns/bgzqj1k=;
 b=IOU5DfZmJ0wniwa62R842g5MbvBztcjthmp+JCkXwtLa12ht35dv91bnxUmdWNi3ngbevGdqkpRSCYEN+C4IsZNMFLgivcyIGCplUfYv0by3+T1eBPJTbSK1hh0pXxi4UX+X76JUXZKr/LRFWrxLtI4mVCwk5PjF/kCr0okHdTn/nbuHRosbkf/XS7fJ4nja24scG7Y9eTxX219J6++Yd8O3UQyJ1fh/spIA2C+s/gELAhxLk3ExwVReXa+CdImrSnbwPMXD0uKrvFKq7uK21VQXGIgN85D7CzYqxL6QAYY+Ok+4GHvOAbsm/JPwph8+Vdq6+fSqr5nCtYMPgf7/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) by
 IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.24; Wed, 17 Jan 2024 09:18:39 +0000
Received: from DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a]) by DM6PR11MB4657.namprd11.prod.outlook.com
 ([fe80::89c2:9523:99e2:176a%6]) with mapi id 15.20.7181.029; Wed, 17 Jan 2024
 09:18:39 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "Olech, Milena"
	<milena.olech@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>, mschmidt <mschmidt@redhat.com>, "Glaza,
 Jan" <jan.glaza@intel.com>
Subject: RE: [PATCH net v3 3/3] dpll: fix userspace availability of pins
Thread-Topic: [PATCH net v3 3/3] dpll: fix userspace availability of pins
Thread-Index: AQHaR5CqyRTPZWDjVE2VK0xjcf9LYbDcETUAgAGrz8A=
Date: Wed, 17 Jan 2024 09:18:39 +0000
Message-ID: <DM6PR11MB46577F5303BD5DE2E0022E089B722@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20240115085241.312144-1-arkadiusz.kubalewski@intel.com>
 <20240115085241.312144-4-arkadiusz.kubalewski@intel.com>
 <ZaY0bL73kDYgqh2R@nanopsycho>
In-Reply-To: <ZaY0bL73kDYgqh2R@nanopsycho>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4657:EE_|IA0PR11MB7379:EE_
x-ms-office365-filtering-correlation-id: afec7c9d-c7ba-4af8-6793-08dc173d4aec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rr6DG8gI5pExVmY4ttPYaxm//S97bwj6LocW+HKp9YLpR6ArGMpY8Es7Rc79CB5BKGzY7LRPt2khfMlOoywpMW3ARBvP961kVOTdzhesC1zskfdhCKHq76VUs/7TctVFBjtRyfpak8gGwCv1xsKVBCHnJJR094ma5tcrX6tHEn9E4sDAC32KmI2gFyHJHM+UU1Yqat9sFeV2yOBMJp7ng+2v9v4OgINBXK+32NZgv03pBYxunQNHj4C63Jg395TimJXrNz3da8O5DQdcWkt4z34zhzIf/eKZTl4brBPrMU4ed7meiVbtlea4v+jd2NZFl+5medPq97hD7i6sitZvYEVRP4Q20uKLhmxUUQan0MqZJTPn256IFDgfRzNy+biOJrBlHyjSk4eOCgDI2DmRRqOshBaWdIV4ds6FPcWvLHPMr3Mq5QNLg02YjN8SKrN1uvcBttDY4FAIFy/92PCTIl9N9ihMm5Ncpni9AX9ErAWNndj25JL2q+FxrW7XGTQYKDOJC4iMI4oe9xIaRNM8Gi1D19K89dqbwPI+csPkCI4fN58+vTC5EhTMaOQqu8oClOuQIHEaXLortpwjPPRToeuYV2iYIpN9ytr+x+nEB1KYqPEnIaZMfmuvaq1Qxfx0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(5660300002)(478600001)(8936002)(9686003)(7696005)(6506007)(86362001)(26005)(107886003)(33656002)(66446008)(64756008)(66476007)(82960400001)(66946007)(71200400001)(316002)(66556008)(38100700002)(8676002)(54906003)(122000001)(83380400001)(41300700001)(4326008)(76116006)(38070700009)(6916009)(52536014)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Tyf52PNUv+q7lGlN3e0YkZonsp3pkhoVLy3cjpEa8ORuCN7NrY91LNmTB28?=
 =?us-ascii?Q?PCeeqA2csEGopYQoHXSWXnivAgJNTNxNljV8RnNMA30oxuHzXMNIIZn35GRw?=
 =?us-ascii?Q?zy6TUpdiNdl7ld7vkXgqi0cct7+DOZ/Op43XAlQnRkwJwCBIfuulFEHPH4wh?=
 =?us-ascii?Q?nLB6b+1GgK8pKwJ5EagUXINbsZ25XUtQyyw4Hu0D2GBBBwVNnVX0mRKmv4Py?=
 =?us-ascii?Q?KpY+osUyiUIVLr7wD4jwPuOc+IdET0C7kYXElpML94cvQ2WNeqk9gPWyOXY3?=
 =?us-ascii?Q?BIW0mBYfdGaLzNEd3wouzm39cmOqlbDEUhnPbSD7azg6VdKSyPwlIVWoFNpN?=
 =?us-ascii?Q?/D80qHM2FkW5q3+GAsuzEetWqK3NF/D4AULvWiI4erJo01q6+FGZ18oe87f6?=
 =?us-ascii?Q?3V80J+0ZmSua9W7UAYMIJNIuuu7wz48vuAPYnq3RG7j3ZvdzwcdFsDERFKiI?=
 =?us-ascii?Q?jkUT3Iv092g6DmiokqeBI/XrL3Sww00PwR9tEyare8jnsSWL8U4bq0lCDNOi?=
 =?us-ascii?Q?2Gf9DE8hgx/KizQ6IA4X1q9GIpoatit4wm2XeGw7h2UjOEaKhTwPfxupYaAb?=
 =?us-ascii?Q?8cpA4q9E3RQYm+qomq1O1AA09zlgZ5ZNWsBBtXX3D4U+OIVQJwyBcJ9D8u7m?=
 =?us-ascii?Q?a25/fH9JbFfMBS/z8AHTi0N1xy+hzOTpv3WOMb+5P6ABDi3Hp8VSOf6jNhHf?=
 =?us-ascii?Q?SFuqbM/PSwKkOk5vTSErPBM4CNhgboABivCfAyH/ls68TDGPRGEPJslGPa5r?=
 =?us-ascii?Q?AqV5Hw/oOI4hHPd2zRbHnSS5mEHiGDpYM+Ug5CDf1jOEzDCw614ha4K25gsI?=
 =?us-ascii?Q?jPkjsOYyoULxHXX3gAvAEcNZYT3hSG4YjOEcmC9D97sX+EY7kM8v69gwgRc5?=
 =?us-ascii?Q?6YghF9hGG5v6yi8/zo6WhNk4QkQXqBm7aLPFNGp6Is0sdl0UbNnZFvs8OXuv?=
 =?us-ascii?Q?Wy2esUFqZjAqZ6lisw2Sh1vDYzsaifDyUPYcxHTmyRtpg8gjomTi4AeVelaU?=
 =?us-ascii?Q?XnuUdjT8A9JjLhVWC1x/KwYutMUEFbkCJuMMKg+ycwpYxRVQw2rksh0NZg9T?=
 =?us-ascii?Q?4ItfLFXjBKASVqgarzvTD9NGRCe6jAJmuEOam2ThiHS48EZU6P3zOVfCL2+X?=
 =?us-ascii?Q?8jn7mN6vEAe4uttgFomZP4uLMRPdj/lSeRfflBEL2OuCocBJ4cgrvp/n1/Sb?=
 =?us-ascii?Q?0PINTWJOgx+QUX0MYLR9Se1Ch6YLOcfiVCvIliLIjq3jpgGVA7ZfDop7wRUY?=
 =?us-ascii?Q?i0jjPmgL8840pLX8M+WEtaUqD4Fd4LTuE0HfQAimBwmbfHC5ff1647hFqLPV?=
 =?us-ascii?Q?7Q0mforxVMYxfpiCOtWf3+b9CzrzfTq3e/GVSEeQBeM8tPp9GMtFGrJYChXe?=
 =?us-ascii?Q?bHNaMnk/sgGdCiOttaWWIG2Tq7TX2/16YZXfHRRx6tmgYORsYf4zZN9jM5Uz?=
 =?us-ascii?Q?UJZ5GFjEgUvjwKf4XSQ4HJ/dZCeC1ypcZZx7PcZ6AV9WgwNcf6hDN1EIxq+D?=
 =?us-ascii?Q?9VKuz6BKFyclhwmQeZRk+bcNTFv1FSn53GOCFe1/M1woDsrfRfeJcNAsB4qF?=
 =?us-ascii?Q?lKMsaA9IFLJCGMRgw+YhxZ4c/hCrbqgepKEWQ0S7XXb+B5kBW005g7yCihS2?=
 =?us-ascii?Q?rA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: afec7c9d-c7ba-4af8-6793-08dc173d4aec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 09:18:39.6818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKI8Y1Eqt9U2rP3j/v0hfXvDLsKCis2dbtzWzSaeCeAxmCN7znyrzriWk9IkPQVYDzYVzvuCvzl+O0Ay7uesl3KTHk5OZzVkplRLQeB48I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

>From: Jiri Pirko <jiri@resnulli.us>
>Sent: Tuesday, January 16, 2024 8:47 AM
>
>Mon, Jan 15, 2024 at 09:52:41AM CET, arkadiusz.kubalewski@intel.com wrote:
>>If parent pin was unregistered but child pin was not, the userspace
>>would see the "zombie" pins - the ones that were registered with
>>a parent pin (dpll_pin_on_pin_register(..)).
>>Technically those are not available - as there is no dpll device in the
>>system. Do not dump those pins and prevent userspace from any
>>interaction with them. Provide a unified function to determine if the
>>pin is available and use it before acting/responding for user requests.
>>
>>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>>Fixes: 9d71b54b65b1 ("dpll: netlink: Add DPLL framework base functions")
>>Reviewed-by: Jan Glaza <jan.glaza@intel.com>
>>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>
>The patch looks fine, but it should come before the previous one.
>
>pw-bot: cr
>
>Feel free to attach the review tag to the next version you send:
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Fixed in v4.

Thank you!
Arkadiusz

