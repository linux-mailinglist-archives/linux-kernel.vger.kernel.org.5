Return-Path: <linux-kernel+bounces-128274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5223789588B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0382D28B19D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01308134431;
	Tue,  2 Apr 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UadonFkg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83F13175D;
	Tue,  2 Apr 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072631; cv=fail; b=aAOSPd7nVxtEn2hlVWF9uevtgz7ry1aVXyHq+orkuYcWGzlL5PE5SC7UiEsXhg1H47KTWJGepo/c4HXQkoy0mn+BNvFpPbPkTQTow6hdnDCCjg8NvBZwMzp4oHrITCitooENofHx3A7IG3XHQEooIwMPzNAqar1VfKqA6UE8HZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072631; c=relaxed/simple;
	bh=msEoo/OdBHJkL9DiqdH1lgm9Ki2V3LVAnnrn5Lo1R+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4MDAgaW6OHlFKOZPDnRRvZfB4WX+2okiJUINBc1U3phUbzxZJTk7Z+Lr5gqsto+eBczMxwT8w1DX+sMirLyl/bXSCKdflbuaz53+/YSMyR/2Vub0TgWp6f6oFUkDDQlE18MNB4z24Biu1T1gcpGQOPvQIx7paP1WgGwxIX0VeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UadonFkg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712072630; x=1743608630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msEoo/OdBHJkL9DiqdH1lgm9Ki2V3LVAnnrn5Lo1R+Q=;
  b=UadonFkgXFozJrGRVNCoN87klkkAuEEXI4qSg229Qi+48ekScb/oeguZ
   N3SWphFxB+U2FYQlmi2koQF31mpFuLOokDAYmd7rlLVBZZw263t8oknU1
   hItMm6QyoECBg9j5xzYyDJoZFINb6WcEmD3QFsT5hL6zQtRg53SkDPzoH
   V4UDQqmMgvxjD8xcbKxQQe/JVqgK7TqJk+cwfZodMIx6Gs83wxoUq/MF8
   hsGfocWkFKYGrPLFIk4Kz1big1N49t3tSnlii4O9RzPHzBpnyb3ZnlgGe
   EkdI1kyyNCX+BaLojhz9c5ck5um6sDDNTqeScUZgBG94beVpCzzvUsaqm
   A==;
X-CSE-ConnectionGUID: 9NJ8xHMWQ32+7KvK0m24rQ==
X-CSE-MsgGUID: P1DVu63iRAmKsxt3KUjNrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7836549"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7836549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 08:43:50 -0700
X-CSE-ConnectionGUID: 4LzGz3g5RumrtfEpo+O7Iw==
X-CSE-MsgGUID: C02X2WLiRWW5ptqaR6BrGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="22840054"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2024 08:43:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:43:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:43:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 08:43:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIANE4BB1jwlc6VaX0Ng0qzG/Vt4pZ6mWeCNFHb+y7qHf+UTRRQPkHZYt1scWIfERbaEofHfv+0LHStuk2o4onSruOstEOOfmhwxdRzuvLxUy728ppWLn7hIUD6xRp3+8gfkKspLoXWBgOniLU9wZQmPbD3tOx/kW/I2IreftH7kZQdkNkQCxZ8RUfe08BtnYZJUsD43R1f0EahSvBBOMYRJx6moE4Wry4m/+Ir1ASO/2GfWIEFe7L+Nvy8NJ3G/iWxBMn5VeI605AnXckBDpeOKd0VVWGzC1E5ngn4+2ontG8jl+n9WayfXZFge1vATfVLMUrt7n93DDcRAq0MBog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msEoo/OdBHJkL9DiqdH1lgm9Ki2V3LVAnnrn5Lo1R+Q=;
 b=UvmyhjBi8IpAnABz35AxOqQQ+7zkuRBMu1iCEjR+15Zn7OBQq3rvvrsz4OOoy6DrQm4zG2n8kJ4nww1kQKCSs+cIMERZIrprBBr90e56Na2y+v+TXDWsqdB7OFhbj/7TxGmGxj/jwzqoXgyPBtVKJcsbkt4gcVoCvJzgMM9jLrh5wH+vFJmdphP8+Z+MnUJpqWhG3n4e9vmQXBQgxOSdWHvKeFh5ioX4965xwQHpUY+czrSUIC+fwjnlJshsHFTTq3YuI7BDz01RbcBaswLvQxnCp/HMna6+w92z+YGyW9wsY0MFlx0e9gJ92AT/hytAF+evYqtKC1bzeBPuG9HTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7258.namprd11.prod.outlook.com (2603:10b6:208:43d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Tue, 2 Apr
 2024 15:43:45 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 15:43:44 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, James Morse
	<james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, Drew Fustini
	<dfustini@baylibre.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
Thread-Topic: [PATCH] Documentation/x86: Document resctrl bandwidth control
 units are MiB
Thread-Index: AQHafIWhuTqTZC6FVEyiTcWcX6VsHLFN8DyAgAEFcK6ABR15gIAAAr0AgAA7cwCAANzqMA==
Date: Tue, 2 Apr 2024 15:43:44 +0000
Message-ID: <SJ1PR11MB6083119607EE3C8ECD939E10FC3E2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240322182016.196544-1-tony.luck@intel.com>
 <56a93ec2-dc01-49be-b917-5134f5794062@intel.com>
 <Zgbe2FFwyHMmmsyM@agluck-desk3>
 <cf59f587-9ca2-4f0d-b412-69b559acbabb@intel.com>
 <d6a649fd-0bd3-4777-acb3-2b9362131796@intel.com>
 <SJ1PR11MB6083D3C5616E60D3D03CCEB5FC3F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <387a313b-9a1f-4997-acc7-932291f69ea7@intel.com>
In-Reply-To: <387a313b-9a1f-4997-acc7-932291f69ea7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7258:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x8+n3MgpRWY4E+FmrJVCd+2c7kUha3Os6YS8DwzOKrce5ex1rodLyqhS+ntTyu2832uNW9vsHgqB99FePWNzhmkbT55CjJFij9q/l/jLTXwMdo3vZu/Ma018+dwzjbqS/3aWF1ogcKE8+PEJLq0AyvVz22MFqzhqZ/vAp5SAJdJflYgkDsRrgXEjbO/XDlLuWSwE4QOKbuJmIXBAyVAtEP8hPs7OlLgvah5NbIFx4HSPwRx6u2/HWAibeVamAM6zwXagxWi5nSh6tK4PhdcqA620LpjuqJuHXAM8Sgr2syfLmAx7lALBQTdTbKX0P4t48FCZIK4Gj9xjEzd1sYfRnhLeU+4oRuQGQgATHAH72hSgy2I26NgouSxy/u35KXTheJhDS13Ji4gGfkeQ1n5CkCOUBAb/9A3BF5F/YOiQEDoLISOO948OrpoEOGfg9cjnJUffYlmDQXPWMA/mz8SRZgKf0jtKZMHJhoK8uYn1rMvCsI4S41vfO612dQSYYuIkwenJHhROSaSu/izlltndIoH5x8h/qTch3O2tblBBwb9uD2YiBwdM1J94uiAnsspYxkUlKDneKNUdeIjN1+zvUDHpaIR7sav7CwcYr8XBmlaT/Y2liK6ZyyeT7tae4GvnG4hBV0Q+vu0hgjspO7ErfAntM3HQAnY4dBZngXKfBrE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpKa3VYT3dWQWpXZWZ6dUpTU2FqcmpHbzhoQVZRSkJlN0xkZFA5b3VQdXQv?=
 =?utf-8?B?dnFjR0ZMOE1IaHUxZmtMQ0RHMHowc25SOXo0Y29YN2I3aXJBS1FmU2xxdDFK?=
 =?utf-8?B?ZXFWMGw0OHpaanlRMTJrWGtCK1o0NlBnTU5nNTVHNXdXSkJZT2NVemxWakli?=
 =?utf-8?B?YTRzOEtnS0N0c09MeGlqWDFRd0JCR3IvTFlDVDlkYndtTktkdE5BV1lUSEYw?=
 =?utf-8?B?ZmcwWmxUWkZvSCtpb3BEQU5xREN5K1pBRzVRNENiek9CL2FCMEpDRlZwVTlq?=
 =?utf-8?B?MXVnbGlEdjZ4Yk5MWURpSW1TYnNJTm0vTzkzMVZ4bWt6TzUzUWVyd3JSbzVH?=
 =?utf-8?B?UVdFU1greXlGd1R5ZDNYalRyWXVGcXV6d3l2S3ljVTl0Rlo4ZDd1NFRXdE5Q?=
 =?utf-8?B?bk5ZTkdXS2lQTHB4WjU2ejRBYTdnMUwvd3FtQUdDdTVsWnFKZ004QTcxUXdx?=
 =?utf-8?B?bEorRTV2K1M3QkoxMVlZbENaZWNFNW5lc0cvaEE2VmdvN2cvdTVWZExBYUF6?=
 =?utf-8?B?YWl6SS9NcDNBajNVMWpZc24waS9TbXIxK3d4S29VQ3pwd1hWWVdiSnlqbzlS?=
 =?utf-8?B?eDdOT2lEQVFzMW8vZjhYTmVZMEhPTnFaNmRqcXdvQjJRViszbnR1MGNIM1lk?=
 =?utf-8?B?ODBEaC9mYzFLTDJJS0NZWERDSzZrTmp0SWJrK1p3dFRreUN0WnRKT3YxazlW?=
 =?utf-8?B?TGYraysxZWMyU3pGWTl4RnZtTTJuTElOWWcxYVQ1U1hJNnhXVlFXdm5pdmw2?=
 =?utf-8?B?V09Ld2p6bC8zUytiV25OSkpSSXg4clJJMnFWRGJYYm5abnlwbFlXcVI2R1Ir?=
 =?utf-8?B?NjJoODN0WEh3eDVCU2s5ZWNDVVF6YmoyVGJreFhjVHFJR2xxTUtZNVVFL0hQ?=
 =?utf-8?B?T2c3TmxNckdrRmpXSmFsSDJxT25xdFNCOGxlUjA2K2h2a056eER2NFJJOFoz?=
 =?utf-8?B?cy81QkNibDhERXVSMjk2Uk8ra3d0RGtTQmZoYWg3cERqeEdjd2VuT09hbkJB?=
 =?utf-8?B?dll6ZldPak5DZ1BMUi9VR3YwcHBTMWdWVlF6RVZPdlprK29LQjkzRFRTbVVK?=
 =?utf-8?B?KysyL1RrSkR6dzBYQVlpUGpRRTVwRGpIdTN6V2JUb1A2MnltUFZrZUxqenY3?=
 =?utf-8?B?L0U5TlZBMVdlVlNGZXhiL2J2eE5HVms3Q25NUHJNYWdpRDVLUG9xb0Y3ZXFq?=
 =?utf-8?B?c1V4RzZ1QXhhOU05bE96VXVFVHVVL1N4bE5jM3FEeTZxY2JzT1BLSmM0OFRN?=
 =?utf-8?B?VWNxQW50djF6d0tyWlgzRldsVDBMSU5qOXpSZXFlMWppK2syRlo1dmFZQS94?=
 =?utf-8?B?L1ZkQm9Kci9YUjlMMWdoRlZ4SURCangyeXl1cmIzVWxOL1BhUjJhV3J4R1Zq?=
 =?utf-8?B?TUtiTjJiSDQzaFB5V3NLTnoybnllbFJ1REVRNmVYNjdjMmdxdCsxU3NoVUxI?=
 =?utf-8?B?Y21TZDFzSUFKbTdXQzFkMWlnS1llVFhIeUs0S1dSTEh4ZmdxSkxPQlJjUTBu?=
 =?utf-8?B?SUNkSlNIOURJNm5nUHF4K3NDNE8yUTZKZTJjNlNaZExZMzRLMFVVbjlrQXg4?=
 =?utf-8?B?ZDRZSUNPWjFweGtsZDVnK1h5YnVwbGtKSXZtU204R2VsQVRveTVMT0NTd0Fs?=
 =?utf-8?B?RUZLUDBRZ1FvTis1K1RzN0l6VWdmdGZ3QzkzRHAwWXhtcXhMdmtqdzlSbzg0?=
 =?utf-8?B?SEtGdjNSVFVhU3FZRXcyNEQ2cTNhY2RSWTZVVlJXL2E1eGxYNWd0SXRoT3Nm?=
 =?utf-8?B?VHNGRGRPZzU5VkVKc0dEU3QvRGJvQ1lneTlyVW5rSFFXREFYQmY0OFpTa2ta?=
 =?utf-8?B?T2tOV2Q4M05HSnJ1TWEwMjZNaHdPM3R6QWUxWVd5UE9oZjhmTTR2T3Y5bUts?=
 =?utf-8?B?VzZDWS9rVnJaYS9UTFhJRVYrYndIZEpGWmRLQ1FXd0dPOGdQVU5hUjBPUkxy?=
 =?utf-8?B?YTlBemV5ZzI0c2d3Ni8rbFJHK0VrUnNxZm9pdU1yOUtXelpaYmpna3Frbzdy?=
 =?utf-8?B?dG1SZ2tnekNTUnArRnBrOW52WXhJam5ITmM4QmRHRFVXVGhCRmpKK0ZkVHZJ?=
 =?utf-8?B?cUcvMkZkWGFNbk5WVHhkR2xKWEtJOUVzSVhYQkhub09ONWNDOE5tMVBtT3hr?=
 =?utf-8?Q?PXLcp5BnT5WzC/Clywm8wIdB0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d979e9a7-5931-4371-8ddc-08dc532badc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:43:44.3331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gJihgyle+qCVbC9OAIm9J62tMddM6Q8UhR2Cv6ZDAB1gVaPeIy94CXJPf1fXDnZ1PJlg4r8287MKX4E9FX6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7258
X-OriginatorOrg: intel.com

PiBDaGFuZ2luZyB0aGUgZG9jdW1lbnRhdGlvbiBkb2VzIHNlZW0gbGlrZSB0aGUgbGVhc3QgY29u
dHJvdmVyc2lhbCBhcHByb2FjaC4NCj4gVGhlIGNvbnNlcXVlbmNlIGlzIHRoYXQgcmVzY3RybCBk
b2N1bWVudGF0aW9uIGl0c2VsZiBub3cgc3dpdGNoZXMgYmFjayBhbmQNCj4gZm9ydGggYmV0d2Vl
biB0aGUgdW5pdHMgLi4uIGl0IHVzZXMgTWlCcHMgZm9yIHRoZSBzb2Z0d2FyZSBjb250cm9sbGVy
IGFuZA0KPiBHQnBzIHdoZW4gcmVmZXJyaW5nIHRvIEFNRCBhbmQgdGFsa2luZyBhYm91dCBtZW1v
cnkgYmFuZHdpZHRoIGluIGdlbmVyYWwNCj4gKHNlZSBzZWN0aW9uIE1lbW9yeSBiYW5kd2lkdGgg
QWxsb2NhdGlvbiBhbmQgbW9uaXRvcmluZykuIEkgaG9wZSB0aGF0IGl0DQo+IGlzIGNsZWFyIGVu
b3VnaCB0aGF0IE1pQnBzIGlzIGp1c3QgcmVsYXRlZCB0byB0aGUgc29mdHdhcmUNCj4gY29udHJv
bGxlci4NCg0KQmFidSwNCg0KSW4gdGhpcyBzZWN0aW9uIHRoYXQgUmVpbmV0dGUgcmVmZXJzIHRv
IGFib3ZlOg0KDQogIFJlYWRpbmcvd3JpdGluZyB0aGUgc2NoZW1hdGEgZmlsZSAob24gQU1EIHN5
c3RlbXMpDQogIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQogIFJlYWRpbmcgdGhlIHNjaGVtYXRhIGZpbGUgd2lsbCBzaG93IHRoZSBjdXJyZW50IGJh
bmR3aWR0aCBsaW1pdCBvbiBhbGwNCiAgZG9tYWlucy4gVGhlIGFsbG9jYXRlZCByZXNvdXJjZXMg
YXJlIGluIG11bHRpcGxlcyBvZiBvbmUgZWlnaHRoIEdCL3MuDQogIFdoZW4gd3JpdGluZyB0byB0
aGUgZmlsZSwgeW91IG5lZWQgdG8gc3BlY2lmeSB3aGF0IGNhY2hlIGlkIHlvdSB3aXNoIHRvDQog
IGNvbmZpZ3VyZSB0aGUgYmFuZHdpZHRoIGxpbWl0LiBSZWFkaW5nIHRoZSBzY2hlbWF0YSBmaWxl
IHdpbGwgc2hvdyB0aGUgY3VycmVudCBiYW5kd2lkdGggbGltaXQgb24gYWxsDQogIGRvbWFpbnMu
IFRoZSBhbGxvY2F0ZWQgcmVzb3VyY2VzIGFyZSBpbiBtdWx0aXBsZXMgb2Ygb25lIGVpZ2h0aCBH
Qi9zLg0KICBXaGVuIHdyaXRpbmcgdG8gdGhlIGZpbGUsIHlvdSBuZWVkIHRvIHNwZWNpZnkgd2hh
dCBjYWNoZSBpZCB5b3Ugd2lzaCB0bw0KICBjb25maWd1cmUgdGhlIGJhbmR3aWR0aCBsaW1pdC4N
Cg0KRG9lcyAib25lIGVpZ2h0aCBHQi9zIiBtZWFuIDEzNDIxNzcyOCBieXRlcy9zIG9yIDEyNTAw
MDAwMCBieXRlcy9zPw0KDQpJLmUuIGlzIHRoZSBkb2N1bWVudGF0aW9uIGFjY3VyYXRlLCBvciBz
bG9wcGlseSB1c2luZyBHQi9zIHdoZW4gaXQgc2hvdWxkDQpoYXZlIHNhaWQgR2lCL3M/DQoNClRo
YW5rcw0KDQotVG9ueQ0K

