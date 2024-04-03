Return-Path: <linux-kernel+bounces-129224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C48F489674C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CCB1F25FCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D50C5D73D;
	Wed,  3 Apr 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="K+QhRAdO"
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C29E5BAD7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130846; cv=fail; b=tTxnhxz+LLMd6c+3PkCp5h86eSwtMXZL53/wpQJaRnfOUJ1AAYKe2l0XhF8NzSEoUhcYMbLu8UvZ395E3hMTg4oHvmelP3yWttjyLqH7ytbwHtXQwPdR94m6V4v1Z90WdjzmbOmtxXyTOiQYR4wzyaDBZTk/bh/vm60jaXdt8V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130846; c=relaxed/simple;
	bh=Gn1S5oahvyJ2QudPog+bQfNAFE2uaebZKi26kRxY7GY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GIO4CxWjOaH7k4SU4DkvVhU4Qao4NHJiqLsC8b2/HI0EqFCh0WPVMGMd9FEQoYmNMAySjJztZdL7AzMgApSbNj2jtnGylrNUyDkF8n50cPB4VM8jDbUPyXsLxS9dKTMZKOU9rIeZNieQu9beBQ2w0Fy3uzcHHWwlpEDbML1fkEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=K+QhRAdO; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712130844; x=1743666844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gn1S5oahvyJ2QudPog+bQfNAFE2uaebZKi26kRxY7GY=;
  b=K+QhRAdOSFWlKebsHotzB/eCpq9vNr5dctXYvC21Yspcmnj/QtPeYGO5
   F1ag2GAfh8fpAs9OftyRgsjuu6AvcD4Dzz8/XeDRrcz7i6BvZP2hzZl0D
   4hFdJ/BdV/swmBDy7JFQE9Wfj5VNYtSkypzjxoOfA4tSvIB8eHbY914mZ
   It4kjrOIN+ROh8z+HItWVw2eduNrk669TWc8ekRitkvPCtZYqxlQ8+bdz
   JwHYsymx3v4FogP7FPdJoJboF1/hJFbmVsHoVFcA0yFF7KcghKkE/Cnmt
   zVDJltmrvWFeky0uEOKmQco4CQ6LoEvdDBHHhksaJx9KNCzBJ9eSZRjro
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="115789280"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="115789280"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:52:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKdCBArGP+gUXEkkqOmECg82Pg3NXKRnXYHVww/PtMeDCrcy3Htpfbl+A0KgQ4d4VcYJJmO1Rc1vY8TKNIeCwbWKDtJwOqSb4oQ/FgumjAzIV8q9VYBPHYXDcfvGrgonD3q7MHHBwjiK7QY9Gl3CP2SwWpsl9lVUQD5X62uaNtLxl3ap+IIiSX/uFXuE0UEn6tiiWiMo3YxTpM7k/jRdb6Mb+UULuHLJknqpdyg503v2yT5KpWrDCKPEXvVOC8U4+uFTZapdKLcaJYmyq7GBhiDLtScQ42ANWmmAc9TG3koqjhVcdkdhe4XIf3KaT7DK+qc3ybUw9BCt7SCotZ6unA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/KvAATbTh0NBh0R69dmo1iZG2IvAz8iwqmB3BsrjqY=;
 b=gy954tAigTjLsCLNQ7x/71HZhk4MvQe+uHJmLxrbxEMhTwc9tYDfWxsonbUYQ1z++nc9I1cGMzqfoiPOYs14CbM/fs4djo/+1VOU+zBlVj5MPGS0JWS8WJoLO+UUjjGLvvXojmMGUm5oRahsqu1KzzvgaufPYiBfeeIfdATAzsXv96qylCG5wVMdfRP6W+2Ao8yoPbWefIhlKc9i6Px4OFk2xex48+1XWfHCi8rLJlp7Zfsrt/O0rP/Kwq3+58lD0iKf9kiovXdbqoFNeQWz1tSCND8mXn01cdVENfZqxB0xTABYS+BqPyDi8MTnXx61SKBRnJNXMOtPNIH/WCZ9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB9563.jpnprd01.prod.outlook.com (2603:1096:604:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:52:43 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:52:43 +0000
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
Subject: RE: [PATCH v1 09/31] x86/resctrl: Add a resctrl helper to reset all
 the resources
Thread-Topic: [PATCH v1 09/31] x86/resctrl: Add a resctrl helper to reset all
 the resources
Thread-Index: AQHae7AbTeTDWjxcfEOh+qFIltEZE7FWPYJw
Date: Wed, 3 Apr 2024 07:52:42 +0000
Message-ID:
 <TYAPR01MB63303577D268E2175A61D0968B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-10-james.morse@arm.com>
In-Reply-To: <20240321165106.31602-10-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=e20eff45-3464-402a-b9e1-08eb0704b68e;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-03T07:52:03Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 4652171694e546d5b894aa63a8119ba9
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB9563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6cOs78wUvBWS2Rls2t3MYyM4eSNxhJqc44A4ELVQiB8azqxEq1Hrsl+4GskMdyU7gIzKiLnyHQZrrf9fUTyRWl8jk4s1zcnso1OLhXYQnPUfuHbHLFJIaYOts9V3/EtWGmPgITLLiPJLAMzL+0DkopAElRIfdr2pFC8XbMNWexi38KL0/ryzTiwpAYBNcyaxtusCT5L4VS54YytYjsBEW9+sZ5NtvwEUcJsuu9w28BQrD9DOQvp94IIr7vLZgABa5xur00lS2W2GEZH+UwIxwsKmTPjeQbbKfNO7T5bWu0A96bPGqMrhfTJozkIveOPTPuOfv5o5LPeWpKFyn/K34UN5YORUAWLG6y1Fw6oGS7x9ceksliXr2z85ChzZlFDMao0p+Pt0cv3h7enKI+Fqoq366O9++fCrd01lb739IA6sAv+ArjdxhaqugLxLsbIGb2q33vFkEZKXBx3dUInHw4wK4vF31k6wveek8e8lRW9OdvJ8eTNnnN+MR71eUN9yWrm70L4YgOAaj2zLEm7sc5dE4yLt8WzASHu5BMw37ev3gThrqcaG41pAonSyzGdB/2mJXNq5QECIjvCS8nsrAjBDWwmvPX7ZCap3+8mCP/74MiLWV//xYBP2xJAWIHv+lnDajGjTtCfqgpmNNjgx7Sy+OqPGWAURvQ7H7A/bQyQrbSi2hV/xLgHyxMC/S2wUT4ZYQPmafiaXgb0+Yw+32g==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?M0x3eFBhWDhnbVhISi9VQ3JsUzBIcXNLWVY0L2s0Mkx6bE1tRkJYaGpY?=
 =?iso-2022-jp?B?NWs1WVhBR3pOUEN6ak9WS1VNVFNVY1V6OVAwU1pZckZDQklTSitsT1hm?=
 =?iso-2022-jp?B?Y1liSmN5aVRWS1cyT0JjNWVUWUtNRmRpb0cyd0VJUzdVWVBtVUllVlRZ?=
 =?iso-2022-jp?B?LzNSc1NORk9HVlZuVGU1OGR5N2hkanlvdEs0ZWlJalNlejhJc3pYem15?=
 =?iso-2022-jp?B?Vk1wT1BVWTErekVYbkdodm1XNm15RWp0NnJKd3B5b0lsT1Z5dFAwalY1?=
 =?iso-2022-jp?B?SWhUTVhKRXRLU2xROURNQmFqUTkyS0lkYkEydWtldW9PN3kxYnVteXJh?=
 =?iso-2022-jp?B?MHozZUliQUp1WWJUQmN5VTEwaVM3ZFNoWVRBem9pSC9IeVhHeEdGbFBu?=
 =?iso-2022-jp?B?cFc0WEpVNlVhWkpNcHhnSmJiQ3gvTWh2SWFHUFkyVFpFQnpZMUpWWFBV?=
 =?iso-2022-jp?B?TXBRUE9FT0hRUFZTdURJTlo3OXJlNTl0cUtpR0xITUxvYTl2eUIxcHlH?=
 =?iso-2022-jp?B?MVBIeVRJZEhPUkVUUXc5WU5uUUhHcXBDZ0xKaDFYT3VCeWtSOEM0RU16?=
 =?iso-2022-jp?B?K2wzaGlMajhON3paUTdvWk5WWGJiZjVRL1pMRndFN3lhTlQ5THVZUVlH?=
 =?iso-2022-jp?B?RUdiU211UjQrS0NzaE5leWdEQUhzcS9mTlFQeWoyV2ErK2JhWWltOEdT?=
 =?iso-2022-jp?B?WDV2ejVUZGpSUDhCbWEzYUxWNzF1ajdFSnBIL0RsVnJkdFJEWHcvZHJN?=
 =?iso-2022-jp?B?Vk56dFQzZ2pmMUFSSkZ0d3oyVU9vSVhrZENKWFc2UTRLdXg5TjVqQXFV?=
 =?iso-2022-jp?B?bEFmZWlmd2NMd0szV0pGL0tidmYvVkh3b2JJRklMUnVmTFQrSHB6TndE?=
 =?iso-2022-jp?B?clp0QVJXR0lRNGNWeFltbDRTdXZESnNLelBsN1Vzc2t1SnpwVktNWmM0?=
 =?iso-2022-jp?B?ZWVNdjN4ZTZGdER0N3hBTkt2alByaEVnWHh6ZDdmdkZRN1dyYzdhUHg1?=
 =?iso-2022-jp?B?by9YR3Q5SDhoUmRTUThVVGVCNzIwUDFQVFUwVVpBYzVoQjVXS29rRjdU?=
 =?iso-2022-jp?B?NHMwVXRFM3g1Q2pPT3ZwNXUybXBWVjEzMW1zSk5kUzlpQmJHaVBoZmF3?=
 =?iso-2022-jp?B?elM2d3BRdGtoS3lvdUdwWlpaMHhQZWRVbW1QckFVTFB0THVPN1I2SUIy?=
 =?iso-2022-jp?B?b3l3QjhRckpranNYUUJwUk9hY0M4dmZHR0RMVWVkVEZyWHlvaWFhemw4?=
 =?iso-2022-jp?B?SE1DcmlDV2V5UEE3eWFJRkZra0d4NGhzblBpM2duMWN3SHZkcDdZaUJH?=
 =?iso-2022-jp?B?YW5LRVp6SWxHeGlydjdkL2tPYjFJSittMDhTbDZZT0ZqakR6TlRnZ3hE?=
 =?iso-2022-jp?B?ZHNhYnV6U1ZUZ0FSWVA5UndaU05wdFJxeUExS21RZ3ViSll4VUNPQlQ1?=
 =?iso-2022-jp?B?T0EvQWJROFVBTEh1ckhzVHJkY2wrRDIzSzhCd0hKOThCdVRFc3J0MGZw?=
 =?iso-2022-jp?B?QTlZTXd3aVgxWklIZmhDcUR3eEhLUXYyTTZYN0EvWS9veVErRXBwL1dl?=
 =?iso-2022-jp?B?MHZ0azUxcHBqN0RGK3VMVXJJdkJlY1RITTN0YkVWRWNpM092ekR6QnNt?=
 =?iso-2022-jp?B?ZVlOaEtISkxmb011L1JpQU5yRWp6dGpESmxieWdsK3JvdDhuMTVFSGx1?=
 =?iso-2022-jp?B?SThpRnpicU9PQ0JXd05LYXdZU3lpRjgyc3hHcW9Ud3pmTWVudDhxSlNj?=
 =?iso-2022-jp?B?cTNTRHBhbUVvdi8rbWRiNzBXUWJLdzkzS1pEcW1GazN0UnZmSUYrSXd3?=
 =?iso-2022-jp?B?Q3ZrU3NodHRpY3F1eDlpVm5kOE02a1Z3TXJpUURpWjhaMThKMEFUWVpn?=
 =?iso-2022-jp?B?OFpUT0dQTGVSK1UwelZnWXBKSnVtakkvcWhoSXNPUE9vRGM1M3pLZDAx?=
 =?iso-2022-jp?B?cnhMTnZWZ1FvSDcxQ1FSOVFoNzBGLzZ6L0liVXhvTzJOeWsxWWM1SVRU?=
 =?iso-2022-jp?B?bUJ1endKZmJUUzlSS3JNMG85M2duYkFOTGV6bi9wWW9XbkxWN29VSVV6?=
 =?iso-2022-jp?B?dk1WR2RsaTZwL0RiR25NNm13ejdtU0Njd3p2eXpCUzZaWmtlYjBOOUxK?=
 =?iso-2022-jp?B?d3IrS1pHV0JIRUJqNmwzUmx1VElyeitrQW1OK21SbEpxOGxtVzFYOVQx?=
 =?iso-2022-jp?B?WWhqUVVKMzU5QVduc2J6dDZ2L3NkWmF6NkJrYXl2QzByMXlWMVRIQVhr?=
 =?iso-2022-jp?B?OUw3bW5kYWpDZHJucVpOR1g4SGJLRmp2UTBKaTVvd0RFd2pGUFJzVlFT?=
 =?iso-2022-jp?B?Q0FhR0g4b1F1eWtHbmtFZzFJcWwrVjNUa2c9PQ==?=
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
	O81A8YV3dA7TmpTIZncnkd4gNeP1f/9sZ14dWHwfkAgw86XSX1a3QE8WvGauLqF/j1aHsAsYysYlCo9hjAHWlTj/5+OJYsXTP7Jxvv1++ScoF1ERlrhUFV9v4pPRjylLbTgeVrl9LViAPVtfp3SujHhrwqBEoZwhw7JYSV4Ni1DNBRVzFFuBr//R4wPscWE/SISIMTxnpR2JneCpT9PSoaTakHz89qnfygRX1dgd/nxMvjOtNjOGAtPOaW8+APmejkOuCLoOJADKFmmp8jQH+AqpAdiRp/EqkQzK9OZroC3MvpUzP6snPMMLtlAg1XbugxeXgQ6Co4a8EbEWJgRzqE2zpdsn/pWq4FOPo4XgfQXCSvzSX7asluFgx13imKm6uNnW7aly9ZRmVn1pdn7fJibeaJmI9vWtUa6PssNnuajH50UJcb4BfMg1Bwymu1BYvlquncQ/PXiTw/Vp899TOM9NBqQ0OBna9LWFJELFr88cFf8W4VEvVDQPn/zs+wqGLml+8lFTmOK6FtSYfnSFHAeP7IrIcczl8NZxZjBubTeTNCQn5NZl1oEC58tXFWI1bPC+XF16dqRdMnp0r2l3NETDXvEA3wzhrPugNmKHvMuS0rX/Q5GusOVeKTZpv7O0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f8d29a-dd5d-4b6e-ed22-08dc53b30b20
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:52:43.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xGAcBHtuzdDwR7805+RDKVthzD/+yqN0Hh5YP17fwRWvKcMMmjCK7EJKsLVWnBD46mKfrW8P4KxvPyiEVjJ+nLEgA6e8qiyxZTgN4pFh8Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9563

Hello James,

> On umount(), resctrl resets each resource back to its default configurati=
on. It
> only ever does this for all resources in one go.
>=20
> reset_all_ctrls() is architecture specific as it works with struct
> rdt_hw_resource.
>=20
> Add an architecture helper to reset all resources.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctr=
l.h
> index f61382258743..5f6a5375bb4a 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -15,6 +15,8 @@
>   */
>  #define X86_RESCTRL_EMPTY_CLOSID         ((u32)~0)
>=20
> +void resctrl_arch_reset_resources(void);
> +
>  /**
>   * struct resctrl_pqr_state - State cache for the PQR MSR
>   * @cur_rmid:		The cached Resource Monitoring ID
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 1a49c9918f8d..13c24cb18d76 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2859,6 +2859,14 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	return 0;
>  }
>=20
> +void resctrl_arch_reset_resources(void)
> +{
> +	struct rdt_resource *r;
> +
> +	for_each_capable_rdt_resource(r)
Could you explain why not "for_each_alloc_capable_rdt_resource(r)"?

> +		reset_all_ctrls(r);
> +}
> +
>  /*
>   * Move tasks from one to the other group. If @from is NULL, then all ta=
sks
>   * in the systems are moved unconditionally (used for teardown).
> @@ -2968,16 +2976,14 @@ static void rmdir_all_sub(void)
>=20
>  static void rdt_kill_sb(struct super_block *sb)  {
> -	struct rdt_resource *r;
> -
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>=20
>  	rdt_disable_ctx();
>=20
> -	/*Put everything back to default values. */
> -	for_each_alloc_capable_rdt_resource(r)
This was "for_each_alloc_capable_rdt_resource(r)".

Best regards,=20
Shaopeng TAN

> -		reset_all_ctrls(r);
> +	/* Put everything back to default values. */
> +	resctrl_arch_reset_resources();
> +
>  	rmdir_all_sub();
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode =3D RDT_MODE_SHAREABLE;
> --
> 2.39.2


