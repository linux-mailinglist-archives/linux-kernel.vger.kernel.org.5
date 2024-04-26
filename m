Return-Path: <linux-kernel+bounces-160383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7298B3CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF6BA2898D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA1148842;
	Fri, 26 Apr 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb95xWSX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC74824B3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149219; cv=fail; b=hFpeHrNKZURVIH0qD1fDM80avG5rOWtvZzZ2GyFu87OdxSqsh5vBGYqMVdWVRZ7yONfuWY3ekoUn6Pzug4Z0wnTaJu5VZyhbcwx47iXBq7+yyXUk8sXZt7mTG/3cdz3BU5aaSoDO4gaXW8dEaA+FC1rFy+mtwOBWu18pHhi6HRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149219; c=relaxed/simple;
	bh=aFUulwRMKZ6IU8PPxLJYoP8qM5QH3a/ELEDMmMJvCck=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNHZjQuLGGDn/S010XxFDmorL+0GoNvdXMliQRKkqCzqsOfphrDfSUkINTRvK0cR8dGLLdtPJjdzrO+IsRa5iFQ43VbT8y5CZqUQFKHazRD1QF5MfmootDFZUet2JWzo1NUWZsmLddVM0DYWoQHPff4hIqBzoOvE2VzH3Sp5r3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb95xWSX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714149218; x=1745685218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFUulwRMKZ6IU8PPxLJYoP8qM5QH3a/ELEDMmMJvCck=;
  b=Zb95xWSXPN+Io0gLSNcZwMZbdJb2MzlysXlfiCBjAKDb/9NiEp1HMAVa
   c4y8tDMi5HVZR5xop4DXHDvx+foeSmowYlI87swZfiSJPP21ATT2avAHO
   6tPpM96Bd4j1PKNdHg0XYzWrY1P8TOoH3lGqnH6vwKl6S/bfkZFD4vHUC
   Ug9Z7okK7zIWOIc37lEVBeGOR2NA/DsO01aR2TT/ENJaKqL5cAcxWuT9K
   Pl5gg88U0L4Gj/yXb6kiyIAsa/tJU9EGdGYEQukncQUZdP6f0of2Q/QcQ
   UkIVUWI+B0KM1JopJJLn43vEwcaWZBIRKF5xnPmxmvnha2quvbCBU1+yO
   g==;
X-CSE-ConnectionGUID: GJ2B/oRTSlmi6obW61nmEg==
X-CSE-MsgGUID: jM1Xdz3lT4yQ2zw7/GL7Mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10105802"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="10105802"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 09:33:36 -0700
X-CSE-ConnectionGUID: qzr2ljKsRjeoSTr9/7Ohgg==
X-CSE-MsgGUID: cKFOuEZqQjCfhQI4KJ87aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="29909887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 09:33:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 09:33:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 09:33:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 09:33:34 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 09:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2LvETNlHTwTezzcqcbnYYoSbSFUh6+xCLPjwVpkpdtHAjM/4B7+4TE6MW1iy4hQ6IW97svLLk8bATyD8DPFIpgV9klOV1U3ZdgslE3LlDMrG8iLcQmheYMedyt/VQvFWVHnVK18QoWuC7CX8VgffSHTa238pKNn3j7yOJXSTryQR6+ChbKo3tJLb/T+k1uUYw3EjS+5b9Q39Q/X45TELKuke5aLglUAKCN27ykDb5dRNsupEyNC1RraRMIML4XfOLTBTx7vksLZ+rr9sB1r6GVnmJw/gWkhyVduvzJrZ27YsikC5fHlOwKJpEtgIyAcbfK4L+nT0lNbzlrqsieDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFUulwRMKZ6IU8PPxLJYoP8qM5QH3a/ELEDMmMJvCck=;
 b=iCWHbtDWE4ffJTj9xdtbUUXZDO15EmMryM/NFaXxMf7dXjv7a8IfvSX1t8ZKKc7NF4M2DDoxc7N6MW6Tdwus980DXg38ztLyA+9ZkYslGpu37hQeSXFyZr9ikfdEjUp4+XgveJqwRWCPX4NLdqOOE0oEwI9Mcgndp19rHBl/2BdjF37UEcdnhnwbQeDPV8YR8qXU6d3w5Bl0v0+UgR0DF9k2Ft0gDGdoSJ27zD5NxFJt8bWm1khj3xgm4joUUZafr6hXkLR1a9JmtZ7IKIlfFvHwduVvoSXifm1c8MZ9MT7Si7G4bjQrHbKvefPNfWVNaeKLS7EnqSR1wn79g2EFaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MW4PR11MB6909.namprd11.prod.outlook.com (2603:10b6:303:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 16:33:31 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7519.023; Fri, 26 Apr 2024
 16:33:31 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jeffxu@google.com" <jeffxu@google.com>, "jeffxu@chromium.org"
	<jeffxu@chromium.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "jannh@google.com" <jannh@google.com>,
	"andrew.brownsword@oracle.com" <andrew.brownsword@oracle.com>,
	"matthias.neugschwandtner@oracle.com" <matthias.neugschwandtner@oracle.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "aruna.ramakrishna@oracle.com"
	<aruna.ramakrishna@oracle.com>, "sroettger@google.com"
	<sroettger@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Topic: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0
 before XSAVE
Thread-Index: AQHal/TUQd5E/u2Ay0uO/j7e8hTpKbF6vwcA
Date: Fri, 26 Apr 2024 16:33:31 +0000
Message-ID: <d0162c76c25bc8e1c876aebe8e243ff2e6862359.camel@intel.com>
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
	 <20240425210540.3265342-1-jeffxu@chromium.org>
	 <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
	 <CALmYWFsW5XcM8PYwd=SCthfgjC3TxqVz=DjnCuV8TU7k+_jLaQ@mail.gmail.com>
	 <CABi2SkVvGWa0=Q9AEkTGAr6f_hZ54Ekrxw5CdgvrRKWtNPNkng@mail.gmail.com>
In-Reply-To: <CABi2SkVvGWa0=Q9AEkTGAr6f_hZ54Ekrxw5CdgvrRKWtNPNkng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MW4PR11MB6909:EE_
x-ms-office365-filtering-correlation-id: 1a5d2aaf-4c40-48ba-a3d0-08dc660e9c3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eWdYbERTZ3VLd0daUEF4WHBuc2txaEFEUlhGRTU1Vkx6eHM0L1pQQTh4K2h3?=
 =?utf-8?B?MUpqbFU4U1VGS1Uzb0FieDRXcDRCTGZRY1pIMGVXS29YZVNJRmRPZmpPZ1RM?=
 =?utf-8?B?TUxidkUyOHpkNHIxem5HaFg3TEFPQm0zVHRURkVWQVlOYTJjV3JZRG5LUGMw?=
 =?utf-8?B?NXhmMGZrTFV3VXJkTUZNWHNYNXRLanViNjhlVk9pS0QrMkRnb05UcG0xeUdI?=
 =?utf-8?B?TC9aakpVZUJtSWRXRUp5WTFscVJMVGFPRkZMQkpFZFJPekdTZGlsbHduTzdn?=
 =?utf-8?B?ZGJOdzV1VnpaSTZmdmN3L0pJbGFOdFNLcDBvQlFzM3RXVnVoZytXbWtCT09Q?=
 =?utf-8?B?MHBCODlZbnFFUThxaG1wM213U08rbzhZNXhqRDdiVnNkQ0JCUElPTWFsQXY2?=
 =?utf-8?B?NXpmWWFTMm5BblI0ZEc3bEd6QUZYbUVrQTNnVTBnUmg1VEhPR1YzTU5FWU10?=
 =?utf-8?B?U0lSaFdZLzhkS0JZS2RzZ3NMMkR1WU1TMnh0WmxxRmhsUHIzcmw3S1J2OHgv?=
 =?utf-8?B?RmtEa254bWhpNE5MbG9DdkdQTU9Wd2JGamlkU1h2MTNiZnVza1NUQmdRcjI1?=
 =?utf-8?B?NElkaTFPeVI2OWNsWjNtSjc2UkF3OVkyeGJ3T3U5dlgwQ3ljKzJQZWlQTW9P?=
 =?utf-8?B?VFJaMWJrSlROQ0NQb3FjU29yVU53dnl3d3JIRzk4d1pBa0FqL3lsUGxXcFBD?=
 =?utf-8?B?K0QzbjFoaEsxL0tySllib3Q1bWFSNHkreWMxSmQwamhtaURkNVFLNWxiUERw?=
 =?utf-8?B?anVZZm5KRGRFRzRUdCtDU3NhSnRTZmg4Y2JuRDFkc2ZzT3NHU05RZ2NyUUI4?=
 =?utf-8?B?eDJYeDBCeW5Cbmg4ckdGTk01eUNTMWhGYUZER01nVllhQ2VEcTEvNVFiRGlX?=
 =?utf-8?B?aVpxMGVLNGRXOFNDcStrZXNXWlp1aTU5dFkzZ05HTVd4Z0txUyt1N1JLSzFr?=
 =?utf-8?B?cGpGa203K0xHaWlSblNOZC9QNHNLYXh0ZTRjUXFBbU1FU1dpZWQ2TFhDOHdp?=
 =?utf-8?B?cmt0eDZlbVVsbGk2cWZIKys1czFnSGp3eTRHSTFuQTAxazB2V3pRd1hjWUlM?=
 =?utf-8?B?N1NZNVlkeTMzSnpqNDdaMGZCS0J4K3hjeXRaRGVpQkV6dkovWUVXRS9qK1ZS?=
 =?utf-8?B?UjQwcmVYbE1IQUlVaFhOdDIwY1FqZm1yM3AvSi92V3hQNUJVRFhOazVWVUFu?=
 =?utf-8?B?VkVEbWY0dWtBYmpNTEI5bkFnWEJad3FwRmYrNG4vcmVvci9ZdTU5SHFBdGdo?=
 =?utf-8?B?ejNTbnp6VDN2bElYc09HNTJVbzhhcS8rWnU4WlNaQ2p1TUc1ZXdmNDl4YmM5?=
 =?utf-8?B?Ry9adGpTTlNtR2RiQUVJMS8wdnBKTE9JQnBkcUgrMDgzem1CZ0s4VWJXVzd0?=
 =?utf-8?B?ckR3QWJiczE5SXhOU0ZmUnpjWnk0Zms1djhXcU5IYkk3TXkwbmpZT2tBd1Bt?=
 =?utf-8?B?c1lRcldLeXR4YnlqM3VqUkZHSEh2UGRmRUU3Zm1WMjhEUldUeTJRUkx2UDho?=
 =?utf-8?B?MVhWZCtBRU15MXlHZEI4bnI5SzV2aSt6SE9lcEJOT2psOTdHb3lER0w3eDg1?=
 =?utf-8?B?YmxKbXVQcWNYTitKb0lXNkt4bWVKUUZuVks0b3VJUmZoZm1EZTBZY1llVTNy?=
 =?utf-8?B?UGYxaGZQY0hLeVlZOGtOVWptck1jMUdSRElZaFd0SFIvcnZNNVlORG55RWND?=
 =?utf-8?B?aE5RMlhTMm1WOTFTcGh4cCtscTRFTExjUHg4QmMyZHlBaU5sT0F2c2VheWhY?=
 =?utf-8?B?YWxmMXU3bkZMT3A3VXBxbG52bzZiMERIRTVGWDh0ajkwYjY5STJnbHM1R2FN?=
 =?utf-8?B?K2IxYjJwNTdrRE1ocHJwQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGFUYzIrSTN6NTFJSmxaM1NHcEtGVlRnMlc0UjBwMnpPUHhXY3pqYTN3YlZw?=
 =?utf-8?B?NTFiZk4rRGp2RDFZUnc4dmw4S2xOWGlmdmVsL3NkRXg3QzVHekxLZEs0ZnhW?=
 =?utf-8?B?dVc5SEZnNUNmUFl0SFhQb3VBSTJjcUwxM1hwa0prTkZocGQ1WVFneHVqMWNC?=
 =?utf-8?B?aUw4cVBUVGdIWTJhZGJZY3VSQy9jeTBxc0t6RUlCZm9jaHpsSVNvQjFBd2VN?=
 =?utf-8?B?WVNSWjJqekNXV2NxSU1QVitoS3dsNFV1MURhOEVNNjZVMFZhdjRScUw1NSsv?=
 =?utf-8?B?QWRKQ2ZzTVk4a2tqclJlQlpYTWVEcUdHY0FNYkM5WXBOYUNVYU1XRDVYS016?=
 =?utf-8?B?ZkZyajV3cFNUbzdyWE5ZNytoaFdLY1JFT1pFUFQxMFVCSFBLeXZMcTZyL1k3?=
 =?utf-8?B?dm9YWGxlZDVxVmMzdVRicG9MMDZhRlptWVNFbDFaWlpxb1VBeFczUFlIUTFl?=
 =?utf-8?B?WTQ3T1pyRTllUFptSm1nM0xZQjlDcWVZczRqbGJWWGRuSU5sN0NkSWpmYU5U?=
 =?utf-8?B?NGtjV1lVRS9mTnRCRjkvQ1hIUGdIZkVlZlhJU1I0TjhvNyt5MjllYjRCUkU1?=
 =?utf-8?B?K1VLQ1AxbU5aNDYzQWFxbzVGSHg2SHMydEgzOS9WYWFvdVRFNVQwV21XQkU3?=
 =?utf-8?B?VVJUQ3Vla25LTjNDWS9lWnFsbHFJN08xZ3B4NVdEcVNFZHN0TGxQdHNtSU5h?=
 =?utf-8?B?MjUzRk45M1FjT2d3ZHUzY0hTL2J1eVgydCsyNXEvMFRRQitEblRQUCs4b2Rw?=
 =?utf-8?B?SWFGcG1EUmN1UnVEK3o3eG01V2NtTjFJQUhOODVPYStBWmlhS0NpZDNJU0kz?=
 =?utf-8?B?OHlUWjgvNmNMVVlObVE4UXA1Z045RW9GS1ZpcW1Ea2F5L2RlMVhZcmRRZ2xt?=
 =?utf-8?B?MFhzSHVLSDNIU1JKZzRKUkVPVVJuQTVSVnhWL0VqcUl5M2txVXpLME9XQ09E?=
 =?utf-8?B?Wml1TitJbndGWG1tNlA2OXVDRzkyZE5QU2dKSHZTZU9SUndOV3g3L1Uydmhm?=
 =?utf-8?B?d04zck5SNkdzSE1PS2x5ZkdqUTE1bHRPWDNkd0JFUFRKY1JGQm1rMmdaZ0ZY?=
 =?utf-8?B?ampiYWIyNmZXQ2NtZnpSV2ZuR0tqd1pnNVNZZklMZUEzUk5oK0Y0Zi9ValEy?=
 =?utf-8?B?OG9lYjVLNnlzT3pneFdIdWZhMzBid2lLUGRwWUhac0k0Yy8yTi9ZWlZhNjF1?=
 =?utf-8?B?bEVjSnJtckxkdTYxaVU3UWVaLzhrbys0U2N4R2UwTjdRTDMvdWgrRTZtSmZY?=
 =?utf-8?B?RzNlVkd2VFFETVJibnl5eWliazJ2eE81anBkNENvNUR6blhpck9mU1orLzFH?=
 =?utf-8?B?NkVodUNsYStrSExyeUU3bDcxQWZCUkxGbHRZb1ZoMUtHSWNnZ0kwNEh4d1VL?=
 =?utf-8?B?T1NOQXV0V3BjZU83NkdzdVFXMDZiVkZJam9zaThJSktvZXBxUmJhcVQzU2tu?=
 =?utf-8?B?MWlLVG9CUUNTdncvTlZPRHVDd1FLTmpKTnZVbVR4SGpZdDU3Tlo3NDQrMUJL?=
 =?utf-8?B?VUQzUFNDWEZnV2NaNHBpVG5NQ1l4bkh3c2VPOWlsL0VsSzNnb0xqNmp6MlMr?=
 =?utf-8?B?NWIyT1JqMXFlR01sT2NxSWxJeFVpZy9pZEFnM0hoVnpidjFiNHhHV3YxQzJk?=
 =?utf-8?B?R2N6VkdHd3RSY0hMSklRSTZzeGJhWVVLM3Z1Z213OWRUVU1nZk4rWW5HVmpK?=
 =?utf-8?B?U0kvSWQ2QkRDbE9YbDcrRHF1TUFVVWpvc2ZoUXJzS0NpYnAvYklQOTJNS09L?=
 =?utf-8?B?TldjeEY3RERGTWdHRXBqZEdWY1hEUGkxdFFMSHcvbDdmN21kdFY3V2VRVERY?=
 =?utf-8?B?ZnVHZXRMVFFZcE5QZUJsVndIc2pOZG9ibmM1V2E4ckozR2VlQ0pGcnVMNVFK?=
 =?utf-8?B?d25uM0svaVcxQ3oweG01ZWI5bFZCZzdWU1MzaUlrcC8yMHZkTTFHbmMzMm10?=
 =?utf-8?B?aVFXU2pwYW1mcjQxZm9oQ2xEbkxaL1MwWUF1ZTVQcWhpVTladFJYWWc0TnFW?=
 =?utf-8?B?TXNxeDdET1RhRjViejhlM2NObkEyejRNVzJzb0NHOXRHcFEzQy9BcXMxLzNQ?=
 =?utf-8?B?eWlYOENhRmZYUWI4eWtWR056dkxVcE1oNGNwV2ZyeFd1ZlJjaWZxak53QXJS?=
 =?utf-8?B?Tk1TSVRWdlc2bEZ3bnZSYkZvR2c1VzJFQ1dOL0dZTzVTYUo2T1JFdXN1K254?=
 =?utf-8?Q?Nw7G32I6A9gedQfmjUxSJaI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31923E0F1FD9BD4F9C008DD616304A1D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5d2aaf-4c40-48ba-a3d0-08dc660e9c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 16:33:31.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqacf2LGcS06vUGjYoKatFahPZqIHOqeU68FFT/rH/VDVhXJBenuUU4mUzGeV1qrXmH3pwjiVoWMkQJBGFnDA+sEePEIRh1pNvvj8BZUzJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6909
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA0LTI2IGF0IDA5OjEzIC0wNzAwLCBKZWZmIFh1IHdyb3RlOg0KPiA+ID4g
SeKAmW0gd2FyeSBhYm91dCByZW9yZGVyaW5nIGFueXRoaW5nIGhlcmUuIEFsc28sIHRoaXMgY29k
ZSBpcyBub3QgYXdhcmUgb2YNCj4gPiA+IHRoZSBhbHRzdGFjayBwZXJtaXNzaW9ucy4gSeKAmW0g
d29uZGVyaW5nIGlmIHdycGtydSgwKSBpcyBuZWVkZWQgaGVyZSB0b28uDQo+ID4gPiANCj4gPiBX
ZSBjYW4ndCBjaGFuZ2UgUEtSVSBhZnRlciByZXN0b3JlX3NpZ2NvbnRleHQswqAgdGhlIGNhbGxp
bmcgdGhyZWFkDQo+ID4gd291bGQgaGF2ZSBQS1JVIDAsIG5vdCB0aGUgb3JpZ2luYWwgUEtSVSBm
cm9tIGJlZm9yZSBoYW5kbGluZyB0aGUNCj4gPiBzaWduYWwuDQo+IA0KPiBwcm9iYWJseSBwdXR0
aW5nIHJlc3RvcmVfYWx0c3RhY2sgYWhlYWQgb2YgcmVzdG9yZV9zaWdjb250ZXh0IHdvdWxkIGJl
DQo+IGdvb2QgZW5vdWdoLg0KPiByZXN0b3JlX2FsdHN0YWNrIGRvZXNuJ3Qgc2VlbSB0byBuZWVk
IHRvIGJlIGFmdGVyIHJlc3RvcmVfc2lnY29udGV4LA0KPiBpdCByZWFkcyBkYXRhDQo+IGZyb20g
dGhlIHNpZ2ZyYW1lIGFuZCBjYWxscyBkb19zaWdhbHRzdGFjayB0byB1cGRhdGUgdGhlIGN1cnJl
bnQgc3RydWN0Lg0KDQpKdXN0IHdhcyBDQ2VkLCBhbmQgaGF2ZW4ndCByZXZpZXdlZCB0aGUgd2hv
bGUgdGhyZWFkLg0KDQpCdXQgSSBoaXQgYW4gaXNzdWUgd2l0aCB0aGUgb3JkZXJpbmcgaW4gc2V0
dGluZyB1cCBhIHNpZ25hbCBmcmFtZS4gSSBub3RlZCB0aGF0DQp0aGUgb3JkZXJpbmcgaW4gc2ln
cmV0dXJuIHdhcyBwb3RlbnRpYWxseSB3cm9uZyBpbiB0aGUgc2FtZSB3YXk6DQpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjMxMTA3MTgyMjUxLjkxMjc2LTEtcmljay5wLmVkZ2Vjb21i
ZUBpbnRlbC5jb20vDQoNCkl0IG1pZ2h0IGJlIHVzZWZ1bCBhbmFseXNpcy4NCg==

