Return-Path: <linux-kernel+bounces-131045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4369898255
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4341C1F251BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470C5B208;
	Thu,  4 Apr 2024 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="THBIY3j8"
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CADD1CFBD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216610; cv=fail; b=A+UBFgKfgknVFiLiXqL6D2jnp8K7WG2EyCBYWzQJS+9RikqMnK7sLa7G7PTHf0iMA2DfhOrIKV86QPlPwZbxoai5tBfw3G+HIQmBKujS1NeQxNKeFQBgS1VzTrO4/WIZaCOlcgucAw0uGxOBJpOSnYu1AeajT3vp+el7j6j1ue4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216610; c=relaxed/simple;
	bh=ZOyvxpGNfCjWWGZ3B/WqqL/jYUiGmIfbj3QBqXq3MGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tG63dTKG24n71knBZYRsK7mH7zHeHmuyOwc/T7lSnXMKGDm0X45QZJhglMl4tpxlVf/Q2p+fT5fTvNfyNm3pBJ4z9v2Ie3CjSK7vfis4QHsl51FqUs+n0axgS1y1Kt1fRIt0s4+8Df7QzF+ChWh2aOm46dD3krU8mZqPKiySR4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=THBIY3j8; arc=fail smtp.client-ip=68.232.156.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712216608; x=1743752608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZOyvxpGNfCjWWGZ3B/WqqL/jYUiGmIfbj3QBqXq3MGw=;
  b=THBIY3j8MJ6QldGxRkZq7NlcOILQtTkgsiPeX38SBL500bjuOL7zkNyA
   BjvkVno14y8gQMf+HWEFsC5mRiTy1v4jJeNeyWK2/d6FELFeDBXHhhNL9
   QZh9jM4GvhqOzIkqUXpnuEgDjPOuoS3t9E5EIvNjt/t7GsNTzcrXmY32d
   aVP4g1IN8NLnfqTOyosliK5qFgxV3PSyeDO3ur0lUFM4WwvBgyWdfluem
   w1fYT+0TJR7csiayNWRPgK4pqG/aw85rHiyzLAMQFpxOcStumxnHDT+eK
   j9KJxMeQpeIhSymoqyVYIs+hYFl9nfApDykpM55luBNFjvvCm5429zP3g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="115495151"
X-IronPort-AV: E=Sophos;i="6.07,178,1708354800"; 
   d="scan'208";a="115495151"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 16:43:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgnLSb+hiwpGoqgZ6OCmCPoP9r8mzwD3Dl9LJ6PWW+ZOx5xFi+f8Vu9Khgkbv3l/WmJCtnh/zTOpU2Ldar4DSiCDHA0QqauoQ8HSgPPXsQT75NdovRmhoOVByBrNuTP89BIMTmdak0X255h9DK4C1MY1lcxVaQPNzp+QYmTk4on1v/i2opw5hxl6WWi8k+i4ISagtXKpfdSQILlNovkY+j7tOJwQ0gYG7Lx+GMSzU6KQ2lb1JTmpN7QBKdBnMYZs7cmMX42NqFUOqCzndk/ga8miu7Zv9ndGZGwxhKFmZUYYjlR3CSuOGoFf+Ygai59KLivlWyJ9qwTilNer+uL7yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+IKUTHt2JPEquEVNkqdhtGOOu84jLv2wguyNYsm6gM=;
 b=E1jR0Hi6mXnIYxNuAQPukzCrR/x+o2fmVliFn8JF4n/j0IuPVf7/kSpjPG7xGQC8yDqPBYjGjDZOnL0Z02EhmBHtwNHKm7WlkjYlRIDCN/fVUeZRCPM+b01c1UxRCtUE005yETf3VfAdrv3Y9AP43TrLbcQra8NANOGaagbyfKpqPAgvQPtm0WjEYAY5F+eqbGgmxllhJtZBYfdhnEi83qXfgmuH6ddPhrcmdOqIf84pMUZIXg6T9r6+GMoa75tbeVFkzvVksqMi9NcCOykEdqXKnqCzLdLgS/2NFG3/4Un97pS+tShMkrK762hLhOlMk8axoDraDc5wlh5ekE+W5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TYWPR01MB8461.jpnprd01.prod.outlook.com (2603:1096:400:176::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 07:43:03 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19%7]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 07:43:03 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
Subject: RE: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to headers
 visible to fs/resctrl
Thread-Topic: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to
 headers visible to fs/resctrl
Thread-Index: AQHae7BBA9MyHBJXmkyIPr5KyPpZOLFXzfdQ
Date: Thu, 4 Apr 2024 07:43:03 +0000
Message-ID:
 <TYAPR01MB63304D1AC781C7E293CFEF958B3C2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
In-Reply-To: <20240321165106.31602-31-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=529e0996-9878-4ce4-bda3-bc64bf6179a8;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-04T07:42:34Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: fb450766c6da44ecab9e9de638e648b9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|TYWPR01MB8461:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kWrYmTcsW6CPc4T5LX0mJ5T/8Pm7mavgCPS2zI5fX6BWT+6qz6yeTabzr/pz94hd3OwM/8F87E8dCgzEV5hMr792J+GvpVDZc+4CZZlndPAY0qXqO8Gm1x65p4B4RrsDGhJUwOMohTV+yzM0IKfWgZhNrzH2oHmzNx8NCwI15iLHwBHqN+rMJeSfxc97iRfWEuKNEcr28fBPye7JfSf7ttgonqp1Ne88JeTIqdHy2sbmqYLLndffC73cYdKymQo5PghBLvUTZ2920htRtxp6EoOS244r2LfbzH7OrV9JZCSAxFVZvYVy4tpNUDjAR8NgrurXsagAAwDXIse8yZZWMqYjYS8OzINWpn/b8F4N2FoMFg5yiucS4SauTmH1Mtq6W17uqmNGHY5fT1g8yakn9fWnwfFB5C5qXh+3OlSgrB186px/6n971mz63rqwVJGQEU4p8h49MRzftdVxRempEIgvjUUdQfj8MxZG9MPl8FNGvRFI+XqXBlbd7qCSlbaXfBOkHVT8wtfIDXVFjbGeaH41ZGXFXIZYfmUOCM2Tkxbo30m6uJz0FQce6FvPGpsuU/IN0Y8mX81krhvEN/vfOC2DC9qFin2BH3ACLw5c7shbEWogTmVxnYicqEXA9el9GGoVEHpsVsLfa5bm7vMasR6wr9vf3Txs2fhfJ9PUuQnFUwM2urn7/Cx1m37fLlAyqnA8FJvWWV8ok3lOuTv7gg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aitVaDcvZ1ZHYnlkWStFMWtLS1dvNm5FUDJpbUQxRmkwNEpBVU9DbHZB?=
 =?iso-2022-jp?B?T1crQXhIRkx2Wk8xcHIzMGdGNTBqWXdmVWd3dUQzUmlhUHBNWURwVkIz?=
 =?iso-2022-jp?B?SnhuVVpOdStBU0dmNmNRYW9xSk41TzJldEltVUpmRDc2UkpTcXdndFMz?=
 =?iso-2022-jp?B?NUUvODFnNHJiWGVGekwydmdFSjYzZm5UUGpOV3JmTWhRQTBGV0tvU1ow?=
 =?iso-2022-jp?B?Wm5rRzBBclFKcGxoaXpidE4yNzlYL1dqeGI3Qmo0b0RTMXpWNDlCL1pT?=
 =?iso-2022-jp?B?YWlVdFpNZG1kUFkyUk5xOGlGdkRRelRzZEdpOFl4RUxGTEs2RDQ4a1ZE?=
 =?iso-2022-jp?B?SGxCL0IwcE0yYUt1MFcrY2NQSU9ZVllPelEyeTE5Y3J3VjFLSXVITXZL?=
 =?iso-2022-jp?B?ZUJIM016dms1eGRSS2FVVDlJcjBlZVkzY1dlSnFFays5L0NMckhFQUFx?=
 =?iso-2022-jp?B?ZEsrY3ozZTUvMjFUK1BEa2kxblFyNmI4bStlZ1V2NWVSajhJNlRWc3Fi?=
 =?iso-2022-jp?B?RmtKM0dFdmR4TWV0dmM5dno0WTNMenk5WFRNSmNJRjRIZENYdkQxaWRC?=
 =?iso-2022-jp?B?R1VaOExabjdHK3lHOTg5MTdpNWVMT3F6N1ZKTG5yRDVEanpiSHZaazdu?=
 =?iso-2022-jp?B?UjVjT0ZIVGtrRzZvcTUxRTFHRlp5RW54cWl3b0V4b1NManJZcGhVdmJ3?=
 =?iso-2022-jp?B?Sk9lMGtValZ1dU00QjVrRDd2eERueVRjOVdqVjF4NzE0ZDVoZnBpV2xv?=
 =?iso-2022-jp?B?OXZpUDdrb3Fsa0NhRXllSzJqTG10VlVnWjhwVGpxUnMvenIxLzRTZmRo?=
 =?iso-2022-jp?B?SWxLMHlBTk44OEFlZDZzZHZqSVhsQlVsN1NBdWRQdUp2NmRENVdhRzkv?=
 =?iso-2022-jp?B?RS8wMkUzekRWOTQ1clFsbVFZZGZ3TWw2RHd0THVQTTN3KzgvWmg4QlhX?=
 =?iso-2022-jp?B?L0hCZkh2M0g1cENyRng5aG5aSlBWMkVBa2d1Zi90UmJvWGNneUFGU096?=
 =?iso-2022-jp?B?anYyRC9TWHkxWjkvK1pwTVNURGV2NUdyL2FpRGxhazl5dk1XWE50bmo1?=
 =?iso-2022-jp?B?WGlHWG9uV2s3RU82c3E1UjRpcFJqb2J2NElnQXZHTEJ1RTgxajJBeFU5?=
 =?iso-2022-jp?B?c1FQREU1OHdkMmVjSkZsWVgzRkpzdzZSa3lYdEFVSDcxeHZYZEdSZXRx?=
 =?iso-2022-jp?B?U2NKOFg3NUt3Nm9QcXBUb1RsOXJkRE4rNkFSbUFmWnFmdDQzTWpvTjVH?=
 =?iso-2022-jp?B?RGZGV1hCVTdCeHFHdlpHRi9zZG1WaFZkbW1oUy9nNC84ZFFVUVZaeWJ5?=
 =?iso-2022-jp?B?NHdIWkd4czhNc0d1TjVGN1Zqcmd5QjdUcXpRZkJlcDV3RU9XZ0VBRkZ4?=
 =?iso-2022-jp?B?TEZWSXg0cWI2d1FJaC9PVXZIUW5pU2ZwR3FJSTZRdkpwSVh3aVJsOEJ3?=
 =?iso-2022-jp?B?azJ6cEJ6TGFjQUl5dmFOZVVtb2JMMnRnWm1WWEpvcnUveWdJUGpsaHU4?=
 =?iso-2022-jp?B?YlBveGMxMlF6dUcwdi9BQmEveGZSZGpTd1dTK3N3ejVrR2dHVys3SmhY?=
 =?iso-2022-jp?B?bGRrazM4OEc4dWxBNHo4ZGQ2OEhrVEx6Nndwd0VNcDdrVzJTVnlJY3NS?=
 =?iso-2022-jp?B?SHM4NXBXU3pwa2lHWjI5NVUwcTVDU2NPdUc2d2RaUXU2WnZCeDB0eUdI?=
 =?iso-2022-jp?B?Q010Vyt4Zkxxbm9ZR2pXdnovbUg2RUd0d2hpcnIvQ0tpb0RKUS9hbDZH?=
 =?iso-2022-jp?B?NG1vaExwWEIxblJ4T0JnSW5CRUhFNm5pZUlWeHV3Y3R5RlRFVldLRUEz?=
 =?iso-2022-jp?B?dVJDNFhrb1pwTzdsU0xYVit2ZGIzZ2NZTFZFcXBlZVlMUDBPY2R0czhS?=
 =?iso-2022-jp?B?cjRGY2FHbUgyT1BuLzlFUVgxTkhVOU1hMExYVkRVY0xoeGtvNzRRSTcv?=
 =?iso-2022-jp?B?SVQ3SnVrcnJvTWlGMXBPaGpOWGFsNmVpM0FlU1VlRzBYZ293OEI1Z1JL?=
 =?iso-2022-jp?B?Ym5RTzdieTdkZDRyU1B1d3lXMVN6aFBseWRYNkRyT1BreTFJRHdjOER5?=
 =?iso-2022-jp?B?cTZsbHpWSkdFbk5DUkRIRTk5Y09GREJkNi9SOFVwRVloRjhDNHAzdVpW?=
 =?iso-2022-jp?B?OEczaW1sSTlpTnRMaC9oekFIUHIzTXZqNVpWOHBJaExndDh1QW5uR0cr?=
 =?iso-2022-jp?B?ZElKVWk4V0czUVZHVUhSbGd5MmRCMjZEYnZZRTFBZ1pvV2dRL2YzQ2dD?=
 =?iso-2022-jp?B?SWZGQVFXVmgrcGFxVFRvNUJQNnBtTWMxWWd5WXVkOGNLWXlpcERMVnlX?=
 =?iso-2022-jp?B?UjNQRTZKV2Z4OHJybDNuT3FDdnpyYklnT0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HQSGaafZgVQvJFKOSHaA02wrPo5gdTAlLuIQjWHsG/LSWy6zf6dIpUqVkrqEGL4gj60Cxxr+o8LhkKuidvE/hTdwDjvpXGwQHi/S/RCurhe3O+W6/WmTn8AdJC9fFrKPi7+glBW7sV33DjzJzHvSTwhHr+Ll71m2U6ow7esYI9x8Ery7ICDDAMV2tzmr1atYkOzxhGwZnFb3BrGw2AWOeJnYs5B2azR9xrjztbShkBD2gbO9TC31oRsIUBeInmupxSmOoFQ6gGYQ7ScRpARRVQ6382sgICtifqsRtEsUoHnGic1fo/KpqPtIA0AwGXLv3P0XjmdCdHqBKQ3tc7LbqhLmkNJ1JzNz1Hwbelwbq2htU1WGG34vv8kQkJmcFAhPj3rKv9pBeCVE18/GzGlaUxdPaMFirXF8BKPgff+E081YsLIeUHDIGSE1QDRK0I2t/abTp7ON/uVLlTrNUYl8LhcFyyAzv6OqWbQdhwffdu92bY5+o0of8tNl36Ne47qlz0SADjcC31g5LEzEQpFB5fsRvxibdQnzop/AGvXLD44dK4LgrNckWSnOZiz628N6NPVee/z34nQtU8GSfj44oCCdXETOd4fSqe7Ol7a4IF3Y6WY//3A476oEhyxIVxn6
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb9eba7-7345-4a7b-5045-08dc547adc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 07:43:03.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BKNt5vfSIZTaRTNUQZnlxcTYoZKqp+AJbfOduUUQvoTGwV03/7hvY6aLv1v9Q2dDWGRX5K8tm2V8TEotqRDhTjMYpmnmETgNVgdtgCUW8eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8461

Hello James

> Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely o=
n
> definitions in x86's internal.h.
>=20
> Move definitions in internal.h that need to be shared between the filesys=
tem
> and architecture code to header files that fs/resctrl can include.
>=20
> Doing this separately means the filesystem code only moves between files =
of
> the same name, instead of having these changes mixed in too.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  3 +++
>  arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
>  arch/x86/kernel/cpu/resctrl/internal.h | 36 --------------------------
>  include/linux/resctrl.h                |  3 +++
>  include/linux/resctrl_types.h          | 30
> +++++++++++++++++++++
>  5 files changed, 41 insertions(+), 36 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index 491342f56811..746431c66fc4 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -218,6 +218,9 @@ int resctrl_arch_measure_l2_residency(void *_plr);  i=
nt
> resctrl_arch_measure_l3_residency(void *_plr);  void
> resctrl_cpu_detect(struct cpuinfo_x86 *c);
>=20
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l); int
> +resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
> +
>  #else
>=20
>  static inline void resctrl_arch_sched_in(struct task_struct *tsk) {} dif=
f --git
> a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index f94ad04023c3..c0fb2e22e110 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -306,6 +306,11 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2);
>  }
>=20
> +bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l) {
> +	return rdt_resources_all[l].cdp_enabled; }
> +
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct
> rdt_resource *r)  { diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 56218193a8ba..0f7e3f10941b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -15,12 +15,6 @@
>=20
>  #define L2_QOS_CDP_ENABLE		0x01ULL
>=20
> -#define CQM_LIMBOCHECK_INTERVAL	1000
> -
> -#define MBM_CNTR_WIDTH_BASE		24
> -#define MBM_OVERFLOW_INTERVAL		1000
> -#define MAX_MBA_BW			100u
> -#define MBA_IS_LINEAR			0x4
>  #define MBM_CNTR_WIDTH_OFFSET_AMD	20
>=20
>  #define RMID_VAL_ERROR			BIT_ULL(63)
> @@ -210,29 +204,6 @@ struct rdtgroup {
>  	struct pseudo_lock_region	*plr;
>  };
>=20
> -/* rdtgroup.flags */
> -#define	RDT_DELETED		1
> -
> -/* rftype.flags */
> -#define RFTYPE_FLAGS_CPUS_LIST	1
> -
> -/*
> - * Define the file type flags for base and info directories.
> - */
> -#define RFTYPE_INFO			BIT(0)
> -#define RFTYPE_BASE			BIT(1)
> -#define RFTYPE_CTRL			BIT(4)
> -#define RFTYPE_MON			BIT(5)
> -#define RFTYPE_TOP			BIT(6)
> -#define RFTYPE_RES_CACHE		BIT(8)
> -#define RFTYPE_RES_MB			BIT(9)
> -#define RFTYPE_DEBUG			BIT(10)
> -#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> -#define RFTYPE_MON_INFO			(RFTYPE_INFO |
> RFTYPE_MON)
> -#define RFTYPE_TOP_INFO			(RFTYPE_INFO |
> RFTYPE_TOP)
> -#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> -#define RFTYPE_MON_BASE			(RFTYPE_BASE |
> RFTYPE_MON)
> -
>  /* List of all resource groups */
>  extern struct list_head rdt_all_groups;
>=20
> @@ -370,13 +341,6 @@ static inline struct rdt_resource *resctrl_inc(struc=
t
> rdt_resource *res)
>  	return &hw_res->r_resctrl;
>  }
>=20
> -static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l=
) -{
> -	return rdt_resources_all[l].cdp_enabled;
> -}
> -
> -int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
> -
>  /*
>   * To return the common struct rdt_resource, which is contained in struc=
t
>   * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> f786ffceeda3..00cc0457af50 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -41,6 +41,9 @@ int proc_resctrl_show(struct seq_file *m,
>   */
>  #define RESCTRL_MAX_CBM			32
>=20
> +extern unsigned int resctrl_rmid_realloc_limit; extern unsigned int
> +resctrl_rmid_realloc_threshold;
> +

These two variables has been defined.
 44 extern unsigned int resctrl_rmid_realloc_limit;
 45 extern unsigned int resctrl_rmid_realloc_threshold;
400 extern unsigned int resctrl_rmid_realloc_threshold;
401 extern unsigned int resctrl_rmid_realloc_limit;

Best regards,
Shaopeng TAN

>  /**
>   * struct pseudo_lock_region - pseudo-lock region information
>   * @s:			Resctrl schema for the resource to which this
> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.=
h
> index 4788bd95dac6..fe0b10b589c0 100644
> --- a/include/linux/resctrl_types.h
> +++ b/include/linux/resctrl_types.h
> @@ -7,6 +7,36 @@
>  #ifndef __LINUX_RESCTRL_TYPES_H
>  #define __LINUX_RESCTRL_TYPES_H
>=20
> +#define CQM_LIMBOCHECK_INTERVAL	1000
> +
> +#define MBM_CNTR_WIDTH_BASE		24
> +#define MBM_OVERFLOW_INTERVAL		1000
> +#define MAX_MBA_BW			100u
> +#define MBA_IS_LINEAR			0x4
> +
> +/* rdtgroup.flags */
> +#define	RDT_DELETED		1
> +
> +/* rftype.flags */
> +#define RFTYPE_FLAGS_CPUS_LIST	1
> +
> +/*
> + * Define the file type flags for base and info directories.
> + */
> +#define RFTYPE_INFO			BIT(0)
> +#define RFTYPE_BASE			BIT(1)
> +#define RFTYPE_CTRL			BIT(4)
> +#define RFTYPE_MON			BIT(5)
> +#define RFTYPE_TOP			BIT(6)
> +#define RFTYPE_RES_CACHE		BIT(8)
> +#define RFTYPE_RES_MB			BIT(9)
> +#define RFTYPE_DEBUG			BIT(10)
> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> +#define RFTYPE_MON_INFO			(RFTYPE_INFO |
> RFTYPE_MON)
> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO |
> RFTYPE_TOP)
> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> +#define RFTYPE_MON_BASE			(RFTYPE_BASE |
> RFTYPE_MON)
> +
>  /* Reads to Local DRAM Memory */
>  #define READS_TO_LOCAL_MEM		BIT(0)
>=20
> --
> 2.39.2


