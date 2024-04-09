Return-Path: <linux-kernel+bounces-136876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4195689D94D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6489F1C21A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45DB12D20E;
	Tue,  9 Apr 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYp2zc+P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C041A5A2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666291; cv=fail; b=m4+rbbEQkkfzILG9EjNlJSQ35IP7wJhLoF0vy7y+Ho1IAfqzgajbfjgsp2B4w2wCiNELoUMBAH+3g44LXHyrQaXm8XgqdRCq38UmglSaLNBktcVXGQOJ6cwOKOWqAI98QNtly7fFqTZ5oQoojPuZHNzCYZNK9PHHYTEwSrnwjZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666291; c=relaxed/simple;
	bh=Ya4deifoqwFfceEMgyI7cHmiddyFataTz0sMEA4Uzhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MIcgzds7sp5auYMmWzgBTE1bXF0Oyni/HwP1UX4e4oDbEkrPdN3HN1IuF2qJxI88EJmpgeIWPkuchjfTUtyvwzH2tVciRu9azGoW4TEeNs2GXUqsInTjiMY2eV17lU/VaJdhxROvP68mFE75BqpeSKbqbdF2IpfpYEU4I75sjGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYp2zc+P; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712666289; x=1744202289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ya4deifoqwFfceEMgyI7cHmiddyFataTz0sMEA4Uzhk=;
  b=WYp2zc+PJ3eNR6PCxsqCHLYwY0KXGNJwpHXZXXwqMRXjl5pv29sa8KEn
   Hc3tS08++6Mx0mfBqBjA5oPAagXM/YzeE8HcACZ7uiNbsbADwYQd2fPq8
   j09jhlvU5hi4y19NFORmSuPrzHcHMV1rafM89TUj2FbBwgwb9Z1/07URt
   PQYKSjSvjsGLzPjKzG4bOAtIqzvYujYaXT6kydic5DuG7LlGB7Mitcej6
   YQXjZO4yNzw1rTEBkiFVwXH2enTNW4NUFY4/Xid6dOkmsRi88l/BfnmEW
   ktV27hQDiVH6Y6E3a8ZKUlgHCMRKX2Bch1p1VwUk242n1bzzGzwobVWBB
   w==;
X-CSE-ConnectionGUID: D2FQxUL2Q7W/9u/xSyhnkQ==
X-CSE-MsgGUID: rYzJZHE7SL+AIV+VgXq6Ww==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7828883"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="7828883"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:38:07 -0700
X-CSE-ConnectionGUID: N9aC4PwiQFyHYrVv/ofv7w==
X-CSE-MsgGUID: ryXv9WNaTTWDnUWbdtVNRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="24689939"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Apr 2024 05:38:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Apr 2024 05:38:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Apr 2024 05:38:05 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 05:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8nWQwgLAjVYiX3kFfHMmVnDAGgbRhLxdh+YQ2X/9MZlsZ2McuMZxSPexOQlw095KNZMBVVp9r/xs3Cx4LhOxXNNkJ7LJtEKQPsafY7f7p5IdwGZC4qu9PRMWRN3rZAq3acwPJ3sRkqnRcHcY1buhrolDSBqylMEiWduk2v1KWPWcIPDhjKBJEvmhdrTyzXR8LEqS8gLNxMC4S9+7mLyJ13jeFaRaG7elckKGxmwThvn5KocrEWHRwvXiKHwV2FFAi1NY1s/6XSpMhIe825a8Rn1pznCSqMJtdw50tepTzv6L+II+vbqVfAnHHUejs6xEnHSDbHF9W7TwhghEYbrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ya4deifoqwFfceEMgyI7cHmiddyFataTz0sMEA4Uzhk=;
 b=Y4x8doL35fj4IzF3e/i97qmEbgKKu5FZWxsRVqsy07R6vmP7JWm9wBsOgLF3akkc7an49euV2lkzJUnbNWQ+V7a71xWfOQsGYmqP04ZczwDXrLR0QmQlQRIA8rBS/Ytb3kz+65UV1/QoXEX1Sr1EFhcxLHgwKQXFGJsGtwzvyvzgL/bghRM+w+Z3SwXO1PO2yfOT7LEbMwPaConQzeIBjvbP8NfG8KTVZYIMzgCap0Les7bmZe1j/FxZrmfH4M04za8usb5emosWvqQtD8Ort+wx/AJkdFBpxl7d5Ipdifi9YhDAaNqS4kPC5NtP+BoHlgeSM8mu1c2Q8Fl9ne5vZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA3PR11MB8075.namprd11.prod.outlook.com (2603:10b6:806:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 9 Apr
 2024 12:38:04 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7452.019; Tue, 9 Apr 2024
 12:38:04 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
Thread-Topic: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Thread-Index: AQHainFfdJwv0chs/k6asp1NQSWDnbFf4KGA
Date: Tue, 9 Apr 2024 12:38:04 +0000
Message-ID: <2442ecb95175fda88197296624f0e9c8b90d2e95.camel@intel.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
	 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA3PR11MB8075:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ekJVLSiD5t8etX8X1gJAY2vC/DGYgWaa7aCKs7GlHqlBrLS7n5a5ZmNZw3EL0oBUz/AcXJ31z3VoGc7ACY9chcbe0WLKX23g3fp/DfMT4jY377oWKe8S7mQVx0DJ7L7sxdqBtiB7tL989KDUNI03Wq5gEFlxZ2qFsS5pB3h5KT6lsL6XYp//nYA1GAhbQnFiHujTFtag2t9PK0aPMG/l0hPMaDj/1z64bzfJ+OmhrahlvdMMIu3JzD+qpXSOBSsI9/iX6OJgqXuzhF/mWJVgxWv1LM6MUNwWz14p4pcGIJmCMR1jHaHY7awz8M2wjT8TwOxxDUoGz6k0YqCrWfhBD4jkLsj7pKwXdD15zTs3a274Y/CYetFK0pKLoabwoCvXFpZ0auXAOzX+tUNl9sgABQU/eeCLbO5w6B8lJVUG+cUY6bucLdMILNKAycT84u52suDIHVgD/w8K7u0mVNhuERbtAOl6ad7g9tAuQT/og/mBZOjmK3PZINnpHtvnuv9vdRjKrMQFoLGuH7ZkSOvcnM0pOzuWB+x2Q6I/akyH1AeQUntwUXJercwcM1SeAPQMF0xVq/ZfWA7NH4enYrv1k4M4dlp/Rr54SWMz4YWSUfUDimO4xpDfhMzbxw0EOdtGnEaQZIKCprypnCROIhxGJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXNsTDRtUWlQRTRJeFVGU0NnWng1a21MMW1iR3NwaktlM2NVQXZVaGhQM1pG?=
 =?utf-8?B?OHB2dlgyZnBIK2ZzUko5bCsyYzFyclRFc011Z1Y4dUtXTldXNVRPVWFMeGZo?=
 =?utf-8?B?M1VBNmJScEhET3BEUEtUUlRseXJINnVZVlZGeWJINGxUZ0kwbnhZRDdJNS9Z?=
 =?utf-8?B?bnMwak92azZESmp0MUdTMFVEM0Vna0hqb2JIeTBESHVBNVBXMkg4UEdZdFl3?=
 =?utf-8?B?Y1BSVW5HVXN4dk9YYngyWFZKditraTNZVlZSWHpmZElpendmbGR5Mm9QMTRn?=
 =?utf-8?B?ZFBWbzFNbzhhbzlRM0trUDJVYmdhV3NFYnd3WkF4Q2Y1cnV5YkViN012K1lI?=
 =?utf-8?B?ZEYrNncvMzZxRGVVNUorSGJidWk2M0h6d2hOYVc1UkhId2VpR3dlNVpmK3hy?=
 =?utf-8?B?akI3TGpRV3hZYUpPa1BUdmlvT2hVUTVCeEVCa3dqMmp6ZE5nS2l0WWh1QXFj?=
 =?utf-8?B?RWs4UGRVbDNwZ2MvUTdabGJqVm82cXFZZ2ZvYmw5YWhaZnZWVXRxMzNnRytw?=
 =?utf-8?B?NWxTRFRwVk00NXl2ZnBRTWhRS081SEltZ055RDJmTFZNaW15aHZjQ0VJcm9D?=
 =?utf-8?B?WSs3aU9ZM25TczM4bk5vWnN1YlZSY0VxamlERk9QV2RqelFlZjFtR1FXV0hv?=
 =?utf-8?B?Nm9Qd3pPc0NxNUxBUjYyNk8xa043OExEN2JUdktBK3oyYkc0QW9yTWZHOUxC?=
 =?utf-8?B?YWN1TFBFRDNZUXBPMGJGc3dVK05uaktla3VpdE1YajFmWng4U1BEcHRTQ1NT?=
 =?utf-8?B?K1drTWV6dmZRVDFRYUlGaDlNZ3g2M095RzVjeXM3R0MzNkFRR1JFVFluOTV1?=
 =?utf-8?B?UTJuM1F0VFcvMng3SjJoazIvdmRjN3hyT0E5YnFveWhVMVV2UDJuMGRCck1H?=
 =?utf-8?B?UFpvc3FQYXZ4U2FtbEh3SERwcUtqWEJCYXNZY0xjUUJQcVN3eXpxamMzem5K?=
 =?utf-8?B?ME9aSFk2ODducThEK1Z2N0dCN0xueUNldUFiQUJwQWpLOEdiVytTL2tsalJn?=
 =?utf-8?B?MHNWdFh4clR0Q2k4dk1GanhkY0VJVFFGK3ozVFpWLzhxSHdDVG1ETTA0UEtZ?=
 =?utf-8?B?MmFGb2hqZG8zY2VrQ0RJQzFXMy9kQTJGUDc3dGtNcEJqWlRLTDdDRjBvOXFu?=
 =?utf-8?B?UnJCSys0QlgzbCtSTlpWcGdiNDNyVmpaYUJsMmZaSjhnajV6cExFMTZ6a1dZ?=
 =?utf-8?B?YjlwVUdONG9RNVdZdDMxRG0rUTM5amdWSGIzUldiSGhuZGRjT0EvaGZPK2Fi?=
 =?utf-8?B?VHdRZExMU3d6SzkxQVR6aG1ENjNzdTFNQkJaL3l2S1BVTnhMdUxSeEhTL1o1?=
 =?utf-8?B?empBbHVWUDFHSHVrZU5ZczVydERHR0NnMEM3Kzg3WGFUS3ZxUXpkS1VOdTNp?=
 =?utf-8?B?T3Bvbmw1SUJJV0k4aFlDZmxydk5EQmlTTEhQOVFMaDhGZ1NVNnZvVXN4cWVa?=
 =?utf-8?B?dVB5UXhCdUxMWThaOGdaSzBNSkFQVFJ1a29PQUovTlgvV3BPMys2a3ZKdkJt?=
 =?utf-8?B?dmpjaDd6VDRUbGp3SStjQWtHcC9SR1JoclhiK2F4cTgwcUdtUHN2WG1iY2lS?=
 =?utf-8?B?TVFCaXFEb1c3c01icTZ2VzdvNUQwTmdKSE5oWWpKTWVFditBWmUxNkQvRmx2?=
 =?utf-8?B?WTVZYXN5L2hDNCtNTlk5VG9ZNlFRYlJZYWh5cWpHVS83WEExcVROSHRhS0Q2?=
 =?utf-8?B?WTE3RDJseTBZMnkxdTNWYk5lWmtaR1JQVXlvaWNSWXJ2UFVVaWlEbnRTMEMx?=
 =?utf-8?B?eWV4QmRLc3RJcGl1dGV3aytlaGJYNmhhQ3Mxb2FUeldxbjdab2lKa08yNTVz?=
 =?utf-8?B?UHdXdnhOWHlnbFdLNzdWbzZTNWFGbGg5MXRBa2VjV1JUeWdkZ2plbDlhM3Fo?=
 =?utf-8?B?bVlpam5ETEhNYU5YenAydUdPU1dJQlFOdHRYaW56dDRXclRCZGhXMFh3d0ZJ?=
 =?utf-8?B?a0RZOGdONTE0SjFuTmpVMEtxQ0hoaUw1c0ozeTROTFlxUnZuTnZpWXdTZ1U2?=
 =?utf-8?B?dlFEc1BWZmxTRENMVGUvUjE0NEhOcUlUS3BHWGVmU1JXcy9oc0VyWnUzSkc3?=
 =?utf-8?B?dXlMdnZCUkNSbFE0Zm42a25jRGhtb0Uxd3NWQ0ZITjRjV0FjRTF5UmxUaXBv?=
 =?utf-8?B?cXM4ZVh4YkdnRzlYcWNOZ0FTd2FObWV3ZGFzK0h3UGpzSTNzUForVTUxZXJT?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A885E4DCFC20854F9768202E44D1AA7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73514a87-1066-477d-6215-08dc5891e68e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 12:38:04.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W20xIYIoYLjXnZPtv0e7lMXxcA9CHwoUUdVQ4/Vl1/9pKnGqRffhuhNJQDE8PiqDhJqqtvXV6ctuw5S4XkUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8075
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTA0LTA5IGF0IDE0OjI5ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IERlcGVuZGluZyBvbiBzZXR1cCwgVERYIGd1ZXN0cyBtaWdodCBiZSBhbGxvd2VkIHRv
IGNsZWFyIENSNC5NQ0UuDQo+IEF0dGVtcHQgdG8gY2xlYXIgaXQgbGVhZHMgdG8gI1ZFLg0KPiAN
Cj4gVXNlIGFsdGVybmF0aXZlcyB0byBrZWVwIHRoZSBmbGFnIGR1cmluZyBrZXhlYyBmb3IgVERY
IGd1ZXN0cy4NCj4gDQo+IFRoZSBjaGFuZ2UgZG9lc24ndCBhZmZlY3Qgbm9uLVREWC1ndWVzdCBl
bnZpcm9ubWVudHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtp
cmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcg
PGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCg==

