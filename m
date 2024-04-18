Return-Path: <linux-kernel+bounces-150805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D58AA4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C66B21E22
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1A194C96;
	Thu, 18 Apr 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SubY4FPv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32A2F30;
	Thu, 18 Apr 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475865; cv=fail; b=bRPVJLud15gO1dEa1LKgVTD+qOodo9uJa8ghi8ZtG48G+q46sid7U59Frjwrj2fjCa8+NeaqlVhXAgD72jlXARpsukZQp76e1YNB6sa11l4w/OWJuhIzfAZP0vLLwEzumMX7QIHYHPy8lsP841Nsbe0fiFOGblv0AJgVkg9qJRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475865; c=relaxed/simple;
	bh=ShDqt5xPMf6Tx2iu+qm+rpilMMyHFgbSQ6awThTKQOI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jb+9CtUqtpelfv7DXY32yxvKuBkv3nI6mC4KSGOK5S1gLYALPhWShrLK3qDJeCUKkPGkx+FqYArWd+jjlG0pcLE+2z5mGLejT01HtDQK1VJZZZZUihCxxhko1DCneChs0IZYEcOmySKVofR4t4e0W1qu9+mli/RKljH5Hp/1QAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SubY4FPv; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713475864; x=1745011864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ShDqt5xPMf6Tx2iu+qm+rpilMMyHFgbSQ6awThTKQOI=;
  b=SubY4FPv+Xy+ZnFylxR9NfcnIMVXmpkZNClM/KYzlCW6cn8NzoEmjg78
   9s/V8EyMXJd/CKbGdRVaoX2QUBLMCH1PP+xfshkgPWSUErUs1G6GuuKwB
   7UVsr+LV1LoLiYCHpBACeezvxY905NmyIkUTVFJg7PZhPI5jSh/RoCiTa
   LKqJ4c0vJ4GtWbGPQTNBZSwbbXatJQotwimScfZ2fRQ8hQqdgS8NUYMte
   Cn2gaQn7Om6NBiW5flOXTdDDA7olOB9Ocn1STRQaf0J5lsoY+WBLXf+zC
   oGGxm7EMJDXLyZ52mnZUVMG/F8IFjeP7nwUkULIK0f9A+bJfe/bYhb+2M
   Q==;
X-CSE-ConnectionGUID: Yly14rQWRJiKNNOg1J7A3w==
X-CSE-MsgGUID: 2tGAA4FSQsaLRyvTEKn8Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20442529"
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="20442529"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 14:31:03 -0700
X-CSE-ConnectionGUID: A6RSj06cQSSAJuVkSOFifw==
X-CSE-MsgGUID: Q/gfIV10TX6Ax9klRtSQ+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,213,1708416000"; 
   d="scan'208";a="54328244"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Apr 2024 14:30:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Apr 2024 14:30:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Apr 2024 14:30:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Apr 2024 14:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRtQDPLm7ttC5SvFzqFZ0fZlpjnqWeiArHJ0Qn5FuXkt61j8LcQAyoXGU+BfVW5N6+CqNwqiSj+Aa4I31VZrRWURW6Ss8gfw1sZ5BSZ90Kusnsbe6j2G4AxuPyA1k5la9b+ovB6/HqX3xiJTgQPoUeo9nNH78Fb8adlpH0mSKTUa4vkOawziEMtg10pQgiuHAw6G+OR0zFTVQAFMZDVePIQ+HeEgsqHFc3q2cCAXPi+obSKSSxr0Ki1LsLI/XeCsxplGXOnn+BsHvU9aZZg1dOLfnNGH4ONH/7X+BsaFUVagSvQPovZkm200I9grHHb3pI9awHK8uNUGNyt05BVDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShDqt5xPMf6Tx2iu+qm+rpilMMyHFgbSQ6awThTKQOI=;
 b=SXWeE0uZJJCPPvMQBzlzhmUBO3i1HOlTyy4iGzaw3sCWTt03FD5qG9d2Jx5P4lUnswuKNdKVqZXlCdyEP3gBCWG0dfZ/0NJscTdeUrs1sOn7F02msIQeKOVFYIiRvBpPEUF3ZbyPk+G3+g/RC+ElCn/6mGjemZBfoeuPQb7mjTLHjmnW1X2c414VihfzoIj7etQX4udXktrvEAG0Czd6iu4UGcnryY0pqK3XV6ZgFG+q/3NJtXsMlghacds0754Hk5RBax8N1DL2VCoUY88wudcAhQ9+YohaL2BMkjGZLy+sL1BonZc/XKtTv6ejd1lKotOlg7SAA1jjaMDxYpPG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB7590.namprd11.prod.outlook.com (2603:10b6:806:348::13)
 by SJ2PR11MB8500.namprd11.prod.outlook.com (2603:10b6:a03:574::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 21:30:48 +0000
Received: from SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b]) by SN7PR11MB7590.namprd11.prod.outlook.com
 ([fe80::f454:78c6:2602:4a6b%7]) with mapi id 15.20.7472.025; Thu, 18 Apr 2024
 21:30:48 +0000
From: "Colberg, Peter" <peter.colberg@intel.com>
To: "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>
CC: "Xu, Yilun" <yilun.xu@intel.com>, "linux-fpga@vger.kernel.org"
	<linux-fpga@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "Wu,
 Hao" <hao.wu@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "russ.weight@linux.dev"
	<russ.weight@linux.dev>, "Pagani, Marco" <marpagan@redhat.com>, "Rix, Tom"
	<trix@redhat.com>, "matthew.gerlach@linux.intel.com"
	<matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Topic: [PATCH RESEND] fpga: dfl: omit unneeded casts of u64 values for
 dev_dbg()
Thread-Index: AQHakdeskQoReb334EG4W8nSL0W2eA==
Date: Thu, 18 Apr 2024 21:30:48 +0000
Message-ID: <61cf643fda9b983b8a78b9f66c46290becf4f537.camel@intel.com>
References: <20240329000429.7493-1-peter.colberg@intel.com>
	 <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
In-Reply-To: <Zgt7fA/Jfks/iKYi@yilunxu-OptiPlex-7050>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB7590:EE_|SJ2PR11MB8500:EE_
x-ms-office365-filtering-correlation-id: 8efe42d6-ec22-4013-96d0-08dc5feed07c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2b7lGUstNH8LLy0EwmVHF1IxM588NRqkQeQmOvROP/tsEh9MC8dgdt0xa6Qh68Cjd1xuh/6Z8zzBefw0sm/9dOVCHbB1r7vM2WUoRnXK1/0+FIm6rkwXuCVEgAO7wrVVQwEP/Xly7PaK2ELWt1dyRCVf6TPWgYS+5hkyTg20/yJhD3bpBXD4ok+ty86VwWgcYc1SIzaidRx5Hw2WfrKLkd4lD1s5nPpaxZBr0TgFModG27jIA7TRCkIstOn1heU0IndLYTUGLzT+XihOH09pQnJRTd2IXMzTQTaTvAMHUMsgo25z4SHSBtxBsojz6xwNWbO7uVkgmIauriCuBdj2DP9UWkxBGqwL+0Z9P06zL6r7l4NPoVQcc3CDk9yrhyrpxot3cwkGXYKRQsj+v6myRKCugssPDTONcgRIXGiKcdkamxAdb1ZasaYxgAJma6/IPo5Zc8IJYGYudGScdTsObfKM6iKKkVA2E6G3obiLBpFj+uGKY5PUgmql2xT+pC3eQceniDefyLKCoCdulRqBaM/a5yaNNOwtFjluYr92yA1AzOqmQuXPy0uO8fIYOmeb6O7zjlVYBfcQrmUPakyliINYDUHdvXIZnNIedDHairFjxIW7dHez3zzGMwAuOwLTtIx/rMnyZk9mhUvEXa0iDYJd75OOcZ4Zd1nICzyhm7O2yh+ZuCKFzocTBf2y0xRYZesS6T+j/wET74drrhMNNZNIEM2b0MO5cs4AWBwfnI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7590.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVN5UDdJdzFQTVQ0M2ZQT05xZEtoS1hoMjR1L0dkU2Iydnk1Qi9PMWFxRUp0?=
 =?utf-8?B?UWpTcm00QW0rS1VsdFhaZ0pNRkJpWEdzREpBSGZxYXRaVGtFYTNxR0RXemll?=
 =?utf-8?B?NDdBVzR1b0ZDcWExQUhDV0cxQ2F6TmZNN09zQlRzelJRblNNVzZiSXF5S1hV?=
 =?utf-8?B?VXlCM202eWQ2SWkvbWNRZHFJS0JJZEc2VXc4dlBjN2N6dFpuRHIxSzFQVjUx?=
 =?utf-8?B?NFJ2ckpDSFN6TktFaTVwNFZLUE04ald0b2d1MVJqM1A2WksyYmhDWXo4QnRy?=
 =?utf-8?B?N1BRUnBYc29CY09ualVDTDZMUVVuS256aUhOamM5NlFFcHNhNmRNRjdvNTJG?=
 =?utf-8?B?N05XdmRnM1NGR2lFZnVZZ3RFN0dveVE0TUt6bU45QU9Vd3hjd2RBbXlCOFZ3?=
 =?utf-8?B?QTRLdGNqelpwTmthbENMVitzYTgxNkdwaENvMzdTNDJXWG5YbUZNb0dWYzIy?=
 =?utf-8?B?Wlp5a0JYcXJkSFJOOWlVck15YmdmQW4yb2pTaE1JNXZ6V3lNUEg2R0hJVGpZ?=
 =?utf-8?B?VzIwdGh5bDN6NjEwQ2RtbGRmZ04vYUV2OUl1ZHFHOUxNd1o3WG1CQ0MwVXJK?=
 =?utf-8?B?VmNEK3Nsd09BSTVRU0FKR2pDclZGcVo2dk5ySzBBVnRLazVmWXZWWjVTbXpX?=
 =?utf-8?B?S0lZc29vcUIvTXJnUXBqcFZoRDF6bXN0byt2SG5yZTF2RGZWVVAwY0E5T0lh?=
 =?utf-8?B?RjEvVGcwdWZ0a1F5d09QSzI4bGUyc1BwOTVPMlU0eVowU2dkMXEyalhtWlpm?=
 =?utf-8?B?ZVl2akphTmtSMS9CTTFuMEhyYkNET1plLzZxdk5mdHMxaGkwMVlsZUhQY0M3?=
 =?utf-8?B?aEVUTlg3WUcwaFo0QldiR0FOdW5DbldHUFF1Z242L1I5QTllZllUcmc2OElR?=
 =?utf-8?B?U3Z2ODZnNmRnWWU4bmJOMGkwaFh0YlNmbnkwLzBZQVVYZzZFZ2N3TkpRSzBP?=
 =?utf-8?B?VWZneXVDS2lvNXkwYVd3b2ZjZFNiTUFySEYwM3hvOFNtQy9JeUMrSmxxY3l1?=
 =?utf-8?B?NVVrd2RWcmU3TXJpSkU3NWV0VlVjWjczREVDeGF6NmJYSk5PSFRhRERSWUFl?=
 =?utf-8?B?eWl6RXV4MUZoOFF3VndNNGJkV0pOUW94Z1ZHczhDRnliaHR2Ujlmdi9CT0ox?=
 =?utf-8?B?cWF0SGZtNHlGMk1HR3MrWVBkSGZtQ1k4dU9tSFVmenl3cm9CN0pHd0ZLdXgv?=
 =?utf-8?B?VDlma01kbEJ2NXBpaW5XTXB2eHFsUFB6aHVJMHNadC9nTi9QZUJIc2pnM0Fy?=
 =?utf-8?B?OHhDM3JHRG41TE42clVoUDdKMDVFVTZuMEZxbmRGcmg2VHJpZEcwdTgwekIz?=
 =?utf-8?B?dHd5bUNUT3FQUkszK2luNkhDT2I4WjhSQzd0NWdTSm1ETEJqZkp2RjdBaVZR?=
 =?utf-8?B?amxUc0NBZUFDS3FKbVpiSUNNYzlzSkFUaGZEQjlRaTVoRzhCSmFmeG9iYU53?=
 =?utf-8?B?MEM5eVQ1VFMxdTNMY3Z2U3g3MmNCSVVzVEVYa09jYS9aelIzMnpVQllBWFRC?=
 =?utf-8?B?Wis4UUNneEVqbEdFeWxTcGwvSWJ5UmtnUkx1ZlhjR3ZPdC9xQkptK2VNeStJ?=
 =?utf-8?B?WlJtMTJ4bU1Kb2NMYS9IOHhzMlUyK0UrUEhnbXRkbEEyaVFyajdadHNRQ2lk?=
 =?utf-8?B?TS9nVlRHcmJBUTdEcmVOR1M0Rmd0U1hZZi8ydHRrSVRiYVNXdkl0VlFVSllJ?=
 =?utf-8?B?NUVUMXY5bDNNUXhCeEJnKzJSTFVsTWo1VG0vR01nTzNGd2xLNndRZGFVbW1m?=
 =?utf-8?B?RU1NWmU4VnFUMGR3UEVqL2ltNmNpeTlsdUlzZ2U0bnlPL0Q3NjRxRUpsZ3ZK?=
 =?utf-8?B?OEZaM2lQWHYzeWF3T3BtSlF3aWI5N3JyQ0ZOWjdXNjJFWHVnVFc5ZlVhSjJQ?=
 =?utf-8?B?WUhZQU1HQ1ZibEpkeDJxaXZvcG1nOUtnS2dxZU40OFZ6N1h2eVVQaG90OEtx?=
 =?utf-8?B?dW95QllzSm1Bc1NGaU95ZE10bURUK3lEbGZoRjRmc2FBNy9KRWFLUmxMMmJ4?=
 =?utf-8?B?TlN4aEtuWGxYRWI4cjBzd3lrUFd2c2JHelpObG5scmxNUEk1Q01yT3JWcHdp?=
 =?utf-8?B?YVF2VjVnQ09RUjVMc0ExaUZ0RnNDR2VsTzJpSHgrRHRpcGZVQzhGb1duQjA3?=
 =?utf-8?B?Qmd2WDdKNjIraXBuMDN6cGU5eFNPeTREMys5YUg3UXU5ZFZGekpRQTduSEhh?=
 =?utf-8?B?cnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <542B3B3341FF5A488D576BF6AEC0B5D6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7590.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efe42d6-ec22-4013-96d0-08dc5feed07c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 21:30:48.4241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SVhQee5/8mDLLmzzh/AkaQuRsiVH24CaKEHFEsmGFmsMl3g2IITXdNBHFzAJqO0StKu2eG0XNzdtyUlD7CdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8500
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDExOjI5ICswODAwLCBYdSBZaWx1biB3cm90ZToNCj4gT24g
VGh1LCBNYXIgMjgsIDIwMjQgYXQgMDg6MDQ6MjlQTSAtMDQwMCwgUGV0ZXIgQ29sYmVyZyB3cm90
ZToNCj4gPiBPbWl0IHVubmVlZGVkIGNhc3RzIG9mIHU2NCB2YWx1ZXMgdG8gdW5zaWduZWQgbG9u
ZyBsb25nIGZvciB1c2Ugd2l0aA0KPiA+IHByaW50aygpIGZvcm1hdCBzcGVjaWZpZXIgJWxseC4g
VW5saWtlIHVzZXIgc3BhY2UsIHRoZSBrZXJuZWwgZGVmaW5lcw0KPiA+IHU2NCBhcyB1bnNpZ25l
ZCBsb25nIGxvbmcgZm9yIGFsbCBhcmNoaXRlY3R1cmVzOyBzZWUgY29tbWl0IDJhNzkzMGJkNzdm
ZQ0KPiA+ICgiRG9jdW1lbnRhdGlvbi9wcmludGstZm9ybWF0cy50eHQ6IE5vIGNhc3RzIG5lZWRl
ZCBmb3IgdTY0L3M2NCIpLg0KPiANCj4gVGhlIGNoYW5nZSBpcyBPSy4gQnV0IEkgc3VnZ2VzdCBq
dXN0IGRlbGV0ZSB0aGUgdW5uZWNlc3NhcnkgZGV2X2RiZygpDQo+IHNpbmNlIG5vdyBwZW9wbGUg
bm9ybWFsbHkgZG9uJ3Qgd2FudCB0aGVzZSAiSGVsbG8sIEknbSBoZXJlISIgaW5mby4NCg0KSG93
IHdvdWxkIHlvdSBsaWtlIG1lIHRvIHByb2NlZWQ/IFNob3VsZCBJIHJlbW92ZSBkZXZfZGJnKCkg
aW4gYWxsIERGTA0KbW9kdWxlcz8gVGhlcmUgYXJlICJIZWxsbywgSSdtIGhlcmUhIiBpbiBub24t
REZMIEZQR0EgbW9kdWxlcywgdG9vLg0KDQokIHJnIC0tc29ydD1wYXRoIC1jIGRldl9kYmcgZHJp
dmVycy9mcGdhLw0KZHJpdmVycy9mcGdhL2FsdGVyYS1mcmVlemUtYnJpZGdlLmM6Nw0KZHJpdmVy
cy9mcGdhL2FsdGVyYS1wci1pcC1jb3JlLmM6MQ0KZHJpdmVycy9mcGdhL2RmbC1hZnUtZG1hLXJl
Z2lvbi5jOjcNCmRyaXZlcnMvZnBnYS9kZmwtYWZ1LWVycm9yLmM6MQ0KZHJpdmVycy9mcGdhL2Rm
bC1hZnUtbWFpbi5jOjgNCmRyaXZlcnMvZnBnYS9kZmwtZm1lLWVycm9yLmM6MQ0KZHJpdmVycy9m
cGdhL2RmbC1mbWUtbWFpbi5jOjMNCmRyaXZlcnMvZnBnYS9kZmwtZm1lLW1nci5jOjEyDQpkcml2
ZXJzL2ZwZ2EvZGZsLWZtZS1wZXJmLmM6Mg0KZHJpdmVycy9mcGdhL2RmbC1mbWUtcHIuYzoxDQpk
cml2ZXJzL2ZwZ2EvZGZsLWZtZS1yZWdpb24uYzoxDQpkcml2ZXJzL2ZwZ2EvZGZsLW4zMDAwLW5p
b3MuYzoxDQpkcml2ZXJzL2ZwZ2EvZGZsLXBjaS5jOjMNCmRyaXZlcnMvZnBnYS9kZmwuYzo0DQpk
cml2ZXJzL2ZwZ2EvZnBnYS1icmlkZ2UuYzo0DQpkcml2ZXJzL2ZwZ2EvZnBnYS1yZWdpb24uYzoz
DQpkcml2ZXJzL2ZwZ2Evc29jZnBnYS1hMTAuYzoyDQpkcml2ZXJzL2ZwZ2Evc3RyYXRpeDEwLXNv
Yy5jOjQNCg0KVGhhbmtzLA0KUGV0ZXINCg==

