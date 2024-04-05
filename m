Return-Path: <linux-kernel+bounces-132513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A216899617
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865181C226E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1B288D7;
	Fri,  5 Apr 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVyv5ZMK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3424A08;
	Fri,  5 Apr 2024 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300394; cv=fail; b=gqiJyOp5FNymsMJgXL/KUiq+QN5hx0koDfBxbzBSU8xmQ0EQKJjqD5tJhZisRkuqltCBIyLna4ZUR1ew13IouobnI9uScqCqogwzfXhZb/S7V1pKQ0E4LfCIYE4fNNlBEqxWSKRHE7M14M/PcEtKFiWr/M8jXNwm99qJtfLBmK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300394; c=relaxed/simple;
	bh=ATfnf2LUsiCIjCn9H009MGvw+r93/36Y+xmTCr230ZM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uwtHFYw4noG8PF7miRDSPEzklQMC0E/yqyFTwKMs81T1OzKJETWAJ8fbMvm7ImdiPOFJoKGTNo9RpPvyMRVEykKX7Mj9/xxIi3RbDWfFudp3Nkxv3wXZ8VefLaEt/W1ezcqg5juEsla5p1kZaLokBGnZOi3EGsDcL5nqOsDJY/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVyv5ZMK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712300393; x=1743836393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ATfnf2LUsiCIjCn9H009MGvw+r93/36Y+xmTCr230ZM=;
  b=iVyv5ZMK47+sPmoh73JCz1TDqX7Q7i1iuSpbHmbVjDsqBZlRlZgxX2sl
   rqBt2mZ84WMl+XIAzu/hCrvgbHEYplpBNZG66G5XPw9cdbaELEv/6la1X
   J6PhvyBfYDr92J8yxDCeRJ+rAvdtkDKKN7b9Lq7GUeBQGBrMVTdVp6CMV
   3Im3Pu8ofNb/QiFgwgy+U7rx9ap/Cy38qpmkoOKkfZpv31Whb+V+K7e0B
   aMllL8SlQnJf8YoARsMdlZbnXRg1RV6cPuQSvOou8k8N2i9huGYKTBFmq
   s3zPXa1oPK6x6dHFHmykmxuoOYrGnR8L9xWpWh0bN/Ey0CjRMW8Ij1OKo
   g==;
X-CSE-ConnectionGUID: tBrtscsjT8qpjbwG+DBlOg==
X-CSE-MsgGUID: UGNlxj/XSGCj4qviAx1nbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="8198932"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="8198932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 23:59:52 -0700
X-CSE-ConnectionGUID: HKbeutycQFOpOOedCOUQGg==
X-CSE-MsgGUID: G3aACVfITLGJnKdFL+40JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="19018355"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Apr 2024 23:59:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 23:59:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 23:59:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Apr 2024 23:59:50 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Apr 2024 23:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4Ym7NvUo432RQNixlrxrrDpnLkltFOVdjnk0MhfJ5pdaNzHebIrcPzXg6NNHjdmaOPlWlVkMqiEsh8lSfG8oc7QkziwqavVzfnkZGI8oE6ITPlbjqRVP8ihG4jg/RbC9YY2ZKdDhQjwIkw5IwGy0U3fy7sV4i7uD3d2Z/O/3+FyL++TypwGS/i+QevLHZOaKj2D0U8S9tkTEHaBgs4lPemqjL/PtSlGypk4UneycIj20cST2OO3jOt7fBfK0cYXcXltpC4MbK4z5z/uIP7I2v/tcnRMUBWHvw/FJP44444NN8HNhIVWvnhvZBALBORvqKIB6FSFx9J8tpWMYKUo/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h98T7EnEivH/okBjwvEZW69hifjjEEFxEvzULrUHvU=;
 b=YUKP2p9XCiqb23cu2aU0lKErL5JSn+6x+AlBBKUtgWdf6QTCOJ48r60MO+xjlepKVR2/gWl6kq4ZOwW54XqSdvdHQvNviiBfV+5XvodkT+mBYHKM4W1mPB8+ioweN+hr0A81eHGNwQ5TAkHxNvi90KL5qIut+0gPmXpUbAt2G5/nhLDHPNfTmACtheFq5grMUPf5bMzHhljAgzrBKbMM/b229Xy/P9hEyWRMdl1oS+K2qezCQzLnPN0U3ZndjABvoX/3yg5TLsgFr9L8i7zDY7b9X48VZkKF+sAtbbkv19JaXQe0B1A0SuzjaLK3iva6/SieE4q4N10X/BYdnByGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6348.namprd11.prod.outlook.com (2603:10b6:208:3af::16)
 by SA2PR11MB5146.namprd11.prod.outlook.com (2603:10b6:806:116::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 5 Apr
 2024 06:59:48 +0000
Received: from IA1PR11MB6348.namprd11.prod.outlook.com
 ([fe80::e014:f1f0:90ca:359c]) by IA1PR11MB6348.namprd11.prod.outlook.com
 ([fe80::e014:f1f0:90ca:359c%3]) with mapi id 15.20.7452.019; Fri, 5 Apr 2024
 06:59:48 +0000
From: "Golani, Mitulkumar Ajitkumar" <mitulkumar.ajitkumar.golani@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>, "Joonas
 Lahtinen" <joonas.lahtinen@linux.intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>
CC: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, Intel Graphics
	<intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux Next Mailing
 List" <linux-next@vger.kernel.org>
Subject: RE: linux-next: build warnings after merge of the drm-intel tree
Thread-Topic: linux-next: build warnings after merge of the drm-intel tree
Thread-Index: AQHahwe45bdYc5ylk0ixeZyxZgJhOrFZP0CQ
Date: Fri, 5 Apr 2024 06:59:47 +0000
Message-ID: <IA1PR11MB634824E19BC7EECB00178851B2032@IA1PR11MB6348.namprd11.prod.outlook.com>
References: <20240405141640.09b0bdbf@canb.auug.org.au>
In-Reply-To: <20240405141640.09b0bdbf@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: sfr@canb.auug.org.au
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6348:EE_|SA2PR11MB5146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yycIoY16SK8Vkw4z+6AS7jC7DQZh7ppPTqz4Q/peOALr3/AiEVcsgkieeMswtG951bduRwTAwN16+2UnPUHBBmgBqofqiuxBEeZEURZyEJoPN9Z0JqwnjbWjShTwTiJm235zZNtj0/ZBa1FB0vZNQZUn+LtmDTpxaUcyk2ZoPWMBVmhndzMX9Zc5OjATbhizUwTreXuy24vn7wxyT9cf5gL6hFKSPg7k0nuKApb6jXCcQ9CSuJbPz4L9jV56iHWmBCwaN92sivjL56Jf9yiiDGNEIdg/kYfE2c8RGA3KQ+uKTBEBQm5/i0YNQ0i9KsCcfeo20+mrrxyM6+jm15ZsG5Ax4UzRpbppPR2fIcF1TBGp4XPa5irofzMYaiIERtRsrc1lmj5G0lNCko8fyistoM39zRi+pchB3SX1KTDwI/LEs3kcWHQA9u31xecB987cSb1BfTH/KuKhCfgs6UVlke95iCZNi1VIec3diKCpnCz5EUW9jTl+HC28M/zTvbWZlcv02lD24Rjvn3FSaxOOTdjzZ0w4f6tK+UKcu1ucwlV9qIk65e3gECGNbwVVFETYpjJQGuKeJ1oa7CJAT3Ivn9j6RPV/5ma4me5qA/USkvs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1om0FuVohcst4vo0cCkGFejv9tfQ5Db7AVj3k/+7LnL6eVbNTcKeF3OlgjpK?=
 =?us-ascii?Q?XbiGSIKTjL+roqfAsoi6INrEna4j7y+kObm/ZTVRx1fFBW5dY6wNBNniHc5h?=
 =?us-ascii?Q?U8MhcGMXQX139xgi+3wa2clyjHNTV/VICHTK62UsZCmtH9pq6i3aD+POQWEU?=
 =?us-ascii?Q?2vFIeQ0SqISbaVo+zjJzwpBRZ26XMzgbqRPqGolhJPqJ4aJbpquLaZmVlmxe?=
 =?us-ascii?Q?2hMjPzIU4teTp4Jn+I1/efPBHVvWppcZdsb0Kg//KtjFu+a14RdSMsbUO0NO?=
 =?us-ascii?Q?BfgOQ3BtSrfcbl3U5xjBRkig7ykO1ad8nQwTC/TjL8vuZUr40tpuNoqsb1ne?=
 =?us-ascii?Q?R1/J9BgvfkBeaxC1iM8fuJQ5YVJqY7MMQLP7fC7YgYIgq3v0WzgKUbG2asvX?=
 =?us-ascii?Q?FUumnzrXgyFtXYpm79Dk71Ag1taXXj3ZQBnCw1mQNgo3kKCskQwfkrzUOl/l?=
 =?us-ascii?Q?49NPOsXMatLjDKfrxlGGF29zdAxdVWR73Ul6H+B+3Doa8o3dJd1s9DBLwEh2?=
 =?us-ascii?Q?syhGwsjVAFrGCMqy5avwom9l8W2OWnKN22sNmbK1UIkayLQcRyu1FT9jpUTA?=
 =?us-ascii?Q?oMeS9e68EkeAEkL4FTqqZ3aRl1VrOftA1gzrPAm/+e3OZKQ4fkKghA6IRZnr?=
 =?us-ascii?Q?UzGJL3S3itybgf2j+/nuYvV4yZmwjak/iETMg1t3n8dPPeZwHiFwzY9F/5iE?=
 =?us-ascii?Q?cQWTa0QLEAg7rsT6h0jhZcDdUcflSDcpId73va4/MO6AoQPc0gzkhIU0QRHG?=
 =?us-ascii?Q?dSXIcj7n2WLcWE1R6IPDpLlnua2+G6m6eql65ZvUAaHqvjDPBEU4JRF6A1BU?=
 =?us-ascii?Q?/3wzwO2p91kd+cOgFdHGWTfeQ+Ui2LGlIFyKArtOQQ++585POGW5eajFHRMX?=
 =?us-ascii?Q?SJBHmE3Nrx3ugg7/KyOsR6783JzbxiuFbJ5nAhB9x+dOGwIteXxq9EILKdRe?=
 =?us-ascii?Q?YXqh/+/7QrnlI3hl8fBRRFWTmANl+EyxdCQH17APJ0cP7T+NCHP0ICvn25Ip?=
 =?us-ascii?Q?+or3qlJu2xDeJpRf9Q+taJ2oWdw1YzaULzOFFQCluC4lu3dHT9BpWdy5qu2E?=
 =?us-ascii?Q?AViWhHAFIBVusoqn/lW06eAFxu4ouMgNgSbQmkYP1wPGQF3wBc/sbAr3Xhot?=
 =?us-ascii?Q?O6I9Cd2T2CBH9V5AEQ8mkWxwkPfO5vFYYF54nWr3ISI6VSsARq6p26/uIFTz?=
 =?us-ascii?Q?dgbYq3q6Y56u4H6V3HUiPk+AAHEkRyHz9ypMbzcUj9EHHwyF+9PpfEDFeFji?=
 =?us-ascii?Q?9EU86S7U4ZQK1e58kB/yRM/VuFexu28eWb3isUAGW1aHTPYgl1yFEVDSaZMc?=
 =?us-ascii?Q?bRib/AhngMCo+PFVjScKApYn2/mMxz4V/zg1O/QNKWeZ0h0gxSjPcGi+vN+M?=
 =?us-ascii?Q?ONqJPAdUB1U2k12YWR6Q4XhTxzl35UptNs9SRMlzyp8rTCGPYUW9rHuny2ts?=
 =?us-ascii?Q?DC/PaSktkmfIDcGOxvLSNnyBAHI3llmFk0L692OhNfUkVE8/MTjhm4bf2GZX?=
 =?us-ascii?Q?2858/kJFCe4lyXh3rZ2deU+7kNO86lxZypOIvBYiNIBxKzitQ6zWCc+cfEP4?=
 =?us-ascii?Q?++k75zGdX1F9pfAqb5+ThYc2b8lbMGKcjjl59oIbt4M/xdcC6nZM/15u2svs?=
 =?us-ascii?Q?+H+4Di+9u+pgWuHerWLiwz4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2437662b-3a5b-4dbd-f35c-08dc553dfb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 06:59:47.9785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0lexNQ+xXd4b5iQe/902azStU4wWgI9k6PNiiYcUATO+YZ8jYe4ZFqrvDXxTsGyTMBcegi0VZhnMEBfpnLx4XHzvuy9SjWzG1TujA5GdSZ8yKFiKazp8ZHz0Ycorrhl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5146
X-OriginatorOrg: intel.com

Hi,

Thanks @Stephen Rothwell. I corrected the documentation and sent a patch wi=
th fixes.=20

https://patchwork.freedesktop.org/series/132061/

Regards,
Mitul

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Friday, April 5, 2024 8:47 AM
> To: Daniel Vetter <daniel.vetter@ffwll.ch>; Jani Nikula
> <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>
> Cc: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>; Golani, Mitulkumar
> Ajitkumar <mitulkumar.ajitkumar.golani@intel.com>; Intel Graphics <intel-
> gfx@lists.freedesktop.org>; DRI <dri-devel@lists.freedesktop.org>; Linux
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux Next Mailing Li=
st
> <linux-next@vger.kernel.org>
> Subject: linux-next: build warnings after merge of the drm-intel tree
>=20
> Hi all,
>=20
> After merging the drm-intel tree, today's linux-next build (htmldocs) pro=
duced
> these warnings:
>=20
> include/drm/display/drm_dp_helper.h:126: warning: Function parameter or
> struct member 'mode' not described in 'drm_dp_as_sdp'
> include/drm/display/drm_dp_helper.h:126: warning: Excess struct member
> 'operation_mode' description in 'drm_dp_as_sdp'
>=20
> Introduced by commit
>=20
>   0bbb8f594e33 ("drm/dp: Add Adaptive Sync SDP logging")
>=20
> --
> Cheers,
> Stephen Rothwell

