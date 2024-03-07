Return-Path: <linux-kernel+bounces-94825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F127D8745A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F295A1C21A1C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925A5227;
	Thu,  7 Mar 2024 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="p4MDP09N";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="W0r9tOxi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="k/MgQPGY"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15414C6C;
	Thu,  7 Mar 2024 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775044; cv=fail; b=AmGjB2blXUuotKhZm8009ohsy9oL0YK6JysVU+Dp+HrojXRk5F/tjUUUX+mLy7MVxRTr04D1Z0/Lv6aJTvgok7vgxyOsz3tbB9+VreTU/pcUIQ0zMRBAWIq8vxcUAolNtnlX3H3N6YI1TIg33COBsArgvGCscts0/Ydh9SKAm3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775044; c=relaxed/simple;
	bh=7DoSI/eaapMc2KH19AsGQP6lJMdTinHT6KRd3cf3FS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hsXnRxJql5JCL3tYDEGE1vVMd8SVSOZTDaO7Ayvn9sXpqguqPIDh5jqLB2BEMpbrg2eZDZVq9UReB/4kOjHooS+5fnyhscdCrWGD9SMOwA2rsdhc0TCONa6UFJ6Mc1HoYil4ddSy7GAy2pOzaLlZ02ZJzdnmGUfpN+heDUBP8WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=p4MDP09N; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=W0r9tOxi; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=k/MgQPGY reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426KULC3012432;
	Wed, 6 Mar 2024 17:30:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=7DoSI/eaapMc2KH19AsGQP6lJMdTinHT6KRd3cf3FS8=; b=
	p4MDP09N4ay3lvH2mWvdiTlIAtL3tMntBJYGJ3LZA1eKVGIjxbnGPsRLCr7Jj/lC
	I8P7pEyK6V6rS0W+BndEDNgODIYQw7wVkfDUjdUos5cMX/SiYd49teXuPvtAz2x/
	mQO1jP0S73uO+ZcXIYLrwiwlxYccTXcPDBkv9MTXACtEm5e7pUGY/QcFA7Xx5RKK
	+AyUCdT5WCn6jZ1fG+6NcBkVeDoPmuXTimIn7LYPuDx06e5oWdTOyCLXXaEWS1Gl
	G5NUnIjL3rO+5X6hg4Xr7D15OBLLKj7ZtbJvNToqssOwzJiTpc3kRLv3rX4o5VOV
	ZeoyEM3urbm6vjTmvtElCQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wm3mhkyxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 17:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709775036; bh=7DoSI/eaapMc2KH19AsGQP6lJMdTinHT6KRd3cf3FS8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=W0r9tOxiRmmODBtGUgiS9ztC3X4oj+lWravxvP+2VlDbMjh6VV8/T0PvJF7QK5M9z
	 M4R3pCYs8vcW+DuErNZw2+QcfUN32t8l4N1MF+J+nvIkfxrXCCIzujCjH0qqHYEOfe
	 XXclFvEV/SYYvV6SjRra93/puly8QJB5AWdOilFYDCteG0Rb/lvufYNpynEWa0tqSW
	 84kwQKEAAnWtgO0IRp6xET3tKeWqiiIi3aojLh0uy4HESQ/SzNUYytehs+aN0+DVCx
	 VQXQ2XY467LnWAUqVsH18XBLDgX68B0aUR+tP2YhH+rG5w/7SOLCyZ38CaXdfVT/bG
	 Ew2fVict/76Kg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6139940357;
	Thu,  7 Mar 2024 01:30:36 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D64DEA00A7;
	Thu,  7 Mar 2024 01:30:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=k/MgQPGY;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 00B6F403EC;
	Thu,  7 Mar 2024 01:30:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGQaRMRXKu3sdDdQJ3DP5hJNaPHXV3hFYl4lMcGnNgvpbouOFkNXP5jE7OaHKJj11DdMU4USdObpdHZyzzMSd5n4QfgUkOvocTI2NR/Dxxtf6ArHvlfI0GTvsIG99ZFYbwEHFybM5mLcs0NHYss6zYCoKul1oz3e+jRFKXiHvcA0nBe4Vzo9KdNfE46NG//Khfcl58KUSFeN5v9JUV7H5Ztj5Jc9kTqR+8gnlOJz17u7LNtZDDmOUwHx8U2cg3o5H4538U/5NC4iyRaN9coAwYuFyTFcevv71g4gGbXqqmK/2wkkXEe/CjMjBet2/u+OpVuU9Od79JQfETb/smiJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DoSI/eaapMc2KH19AsGQP6lJMdTinHT6KRd3cf3FS8=;
 b=cygGgfSj5L6iacNFl8o19/OdbKQ8U2HW2Q0LGotjnhe4kosO94fWDhLSUDTKzcvfBco2WGwTRjOiI4tPsTfw3lu1WoixhkbQAbdS/xQ4BNJUSNjK2jTq2umzLfJWW5ffjMm1MtOvs6dTd428J5XA1qzweo963tpGYQa5Lcg7/+2z/IfVkEV7qR3torq+UiDk/PIhqSXiKK/d7ZEdvaUpjW6M1l51W9Kj/P3t11cWujyyTPE1dYYeZn5vZlkAjrIvY7lmqbNtIp9zYZLCmovtYS4bEvXRYwWE/qkCJgZOoJyG+pGb4ieuzCPxFhuHOtgs07DQEj/sWYdYwHM8IPQrrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DoSI/eaapMc2KH19AsGQP6lJMdTinHT6KRd3cf3FS8=;
 b=k/MgQPGYyrO4gzr8zWu6k6koKg53YhhLYhsIj2nGjOtlN1I4QfkTrw5hNPTMixI8cSoPGezVhzm4tFAIBCOiJdYJjdTdA11Pe0D0FvJf3VYdL7FapMwKi1IWrjxWnzi6OTUnDNLJ2qMhztgd/IrrUu5yPz8IcNk9tMknpbwi+s8=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 01:30:31 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 01:30:31 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" <linux-amarula@amarulasolutions.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Thread-Topic: [PATCH V3] usb: dwc3: gadget: Fix suspend/resume warning when
 no-gadget is connected
Thread-Index: AQHaaJtUAB4+UBk7kkGmrPnXYIiNfbEdN1SAgAAFkwCADk/yAA==
Date: Thu, 7 Mar 2024 01:30:31 +0000
Message-ID: <20240307012847.2tkn7nu3juf2x6w2@synopsys.com>
References: <20240226100502.1845284-1-michael@amarulasolutions.com>
 <20240226223643.pay4tb66j3q44cuk@synopsys.com>
 <CAOf5uwkcFuSRZy3F44pSZFpHk5Hah-r8m01JLt3Gd1ngvg-CPQ@mail.gmail.com>
In-Reply-To: 
 <CAOf5uwkcFuSRZy3F44pSZFpHk5Hah-r8m01JLt3Gd1ngvg-CPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ2PR12MB8717:EE_
x-ms-office365-filtering-correlation-id: 6ba4a30e-c062-4491-0e3f-08dc3e462d98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 XVXpv/BYnU3Y4AisD4eSBKvOoCXJgrMGyXeVBixy8FnchCUF4Vv8jP7irbL6mG543VK9EAT4zlhtotzCQqZSNUqKzrbZbS5rNMPqQu8BQJCe/cEoWJ0ruGLTp9WDjcVw4gC2qsagwLRlljhbcmv5lnxwc6lF2lqY5NQb5ztZH0eS4U49Gu3Tve2u6hupBfwaAk6dOx6qOAsJexlVEy1kcG7axVgMEW8hj3svtqLBtvXXE9m7fryxYa2NccvpM3aufbAtwIiy4J9bU3L7sEFBRcdOc776Gq91GCFAJBRDLd3v/W/hvjK7fmbx7BWRCDuRcfuwe2R1UyTvPpyEHBSlCeEFaLx0yiAHbByIrkdix2I/p21Ez1f8gNnFeNpiBnoKb4PtOTimOsaK0Pig8AFfoogDlmhKXTae9QEaTI7Qjg0fb+b4vWx2oMa7gQDYFRB7cywDVhOw0Gd0qhtUtpzELr4dIwx4fwkF3/LEAnG3KM1wUJ5JAuBbLOsXUV503NUzGvM+Iz3l5fi4NPS6vCB0y+N0CcamYDsECJsfEnwSoy5UvCYnYL29eko+F0FYFtq2FVQkhM/16+0h0PxQK06jtNZdzVyeExA2mf5SyS9RIbur9Uy5LwEuJmKP76CIHDFQS7vpbZEJQLRWGlgZq3jTRceex2UEpfvZkC8VkgKH3hg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c05seThwVm5SZld3MGliY0hySEE4RnE3d0JUNXNoRTFWdnBpVSs2VzNUVW5x?=
 =?utf-8?B?bmV1OEZEU0RWalFzM1dRTDE3cmxuVTlnNkY3cU1IbndHRjRzYWdjOTlZVVgy?=
 =?utf-8?B?RlpNNllxakxJWVZpSXRVdVNoUStOMXE0a1RXNmNuTHQ2dVljU2VoZjFMMkdU?=
 =?utf-8?B?TGhWbHN5d0hkYUlNNzNDY2MrdFFTRzdQK2JrUDFiYzRSeDdiUVNUQXJGZHFM?=
 =?utf-8?B?eGhtc2Z5ZHc3Y016ZGMydXVQbEhzbkVaeGJwTVh3d0pWUTUzVm5hZ1QrWnAx?=
 =?utf-8?B?RUFHcGZETDNja3A0bk5pa0tPdkN3YjVSdGpXbDJ1YndmckZMaG94K1l2eTdE?=
 =?utf-8?B?S3IzaHZnQzBucXZKNU85Z3Iva1hZSW1FaXVDTXN0b0hZa3I0WkxwUzNQanpX?=
 =?utf-8?B?MktCWndmNGZDRWdSVTByZ3cySEZrbFEwSE04Z1VTUlVnVm9QaHVZTExKR3Nt?=
 =?utf-8?B?WXF4UElTaWtCQlV2TkhXMy9iL2NnYlVRWGRTYW83cWRQM2xvOC9BUUs1TkpM?=
 =?utf-8?B?Y2JmV3drRjR4bTVjRHlHbVA5eHRVQk1zMG9kT0UrUVBnd2VTUHZuaGlUd1J0?=
 =?utf-8?B?NmFBYkFjZC9HRDM5aFNmM2gxRDk3d0VlVEs1MjVKZUtlditscFovMGxkMlg3?=
 =?utf-8?B?Qkt1amxlbjROcWN0ZmxXMVFIR0wwenljQ2Z5UXcvWjJkWDh0QUV5SWRwZXVJ?=
 =?utf-8?B?Z1pBZVY0NWt0R0VtZlNDOHRtcjdFdkFZdmJzSlZXMnByK0RVOUdkMHptMkdS?=
 =?utf-8?B?dlZwWXBHNG1EaG91a1RSRU9mM0cwRUF3OCtxTFhRYXpxaXpscU9OOTArbkdT?=
 =?utf-8?B?ZXJxdXlwT2lBd1QyNFNXVnYrSjJRSGt1WGJqREVjUG9WaHN6azJIRHgvdlpQ?=
 =?utf-8?B?RTQvVHNEYXJZOC8wYnI1bm4rQktJWER5SUNBeldXaVI5cXJyZ09MdzdPZ2pt?=
 =?utf-8?B?Si9uTDhHZjViOFp5blR5T0QxeDVvTEl3eC9HSHNYUHdzSis1Y0Jac3RQWU1V?=
 =?utf-8?B?UWRJTzQydUJMaytjZVJrUEhKMEpoa0cwdVM5MjdjYi9aNjBLeFVDWFczMnEr?=
 =?utf-8?B?TzZOYm95cXZ0bWtnRUhnUkQyR0s0TkZJNU1VYWFLNTJ2TTI5d3MyUjdDZmE1?=
 =?utf-8?B?OWJIUWJPSGk1YWthdU1hR2psOFBWM2t3S3NtZjA4N0tJZ3NDdXp2SHRJeU5O?=
 =?utf-8?B?QmV2b3dZNHVCUFgvY0hVSVNTQ2VQMkEydXBOeWx4Q3BlU2hXQXBlRTRXR3Q1?=
 =?utf-8?B?VXhHZkgyUTE2c1VKc1lhQ1ltTnNnWDJCTW0xdzd6K2hkb0ZBS1ZnUmVCSm9L?=
 =?utf-8?B?RlBIaVFtSDdWVDJUdVlaMGwyZFdwMlVmNDlTa1pDcUl4WDBBYjF0SndHOGVh?=
 =?utf-8?B?VzVHbjlkRHF1Y0thTHJvdy9SY21LaVphM1lTUXB1ZkNSbTh5dTU0RjVxY3ly?=
 =?utf-8?B?UENTTEtra2FRRFI3MXJGbzdPZjVtNHRBVCt0K2RwWXVhUCtvbDBMWTcxMEt3?=
 =?utf-8?B?eGYrV3E3ajZSdElDaUk1MmlmbW8rczBKKy9qajE1VjlUTGRxckZQKzJXUjBG?=
 =?utf-8?B?VVFHMGxHYVdYUUVQMnp2cU9TMHlZaGpNS1FzRW5xMXBxV0JlL0UzaHlQWWky?=
 =?utf-8?B?SzJ1Wk9wTnZ5dm9VSXRHNlBMYlNEUlFhdnRSeGd3OGRxUjNuN2dlSVcvUUVR?=
 =?utf-8?B?YkNEalAxbFVmYjJXbTJYR3AxekJHUFlUUnhPUnVxamxiSm83MDA4OGpUeU00?=
 =?utf-8?B?UExsR3c5cTdKSFBROEJUT1RzRGdndjBhY05pdkNDek15S2M4djl2SGk3Q0lw?=
 =?utf-8?B?aCt5c0Zqbno3UTRkMHhjM1dNbHRWVVNRMkR3ZHdoQ3RXL1I5VlVNdWRDUUdB?=
 =?utf-8?B?WngwajNXSWo3cVN3Z1A1YkxMa1FiampIVENSWnJ5a3FEWjBtMDg3OVBHK2VZ?=
 =?utf-8?B?SlJUckZZR2YrMGJtdVc5YkFKVmltZ09OTFRZa2ZWMzlpVWliSGhYc0RIR1hV?=
 =?utf-8?B?Qlhxc0FBU2w5VExjN3F0MkdNVEVtTGVCem5OK3hiSithSmVzSTBBOGxEaWVt?=
 =?utf-8?B?SmVWQmFQVkQ0UWJyZXF3Qnhodzc4OTFMTlJHQlo1Z2pVeDU4WWxHMHZ2bnVn?=
 =?utf-8?Q?hFXljzhzuTApqxlFzFnOivihU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C30DED00FFF2F49A7C0057BBFEA7439@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OkukkylzfLMM/Xwxogq5V/KmIgCjCOGU8oyTBwPVp2ofo8I2jLfkCwdukJlfx1L8aEFyA7+VaA+u1SK2uSJ5PpLIfav+IIpSqwYRm4vCexvV7AfTJFqCLrWn/2g5tDMUEqLIydbfAd8sQ1uoIlXoJgxMR/50mK7cUERYFSfjTzeR/WC6f0OVS3m51UHEaRDH/fS108SPy6/ZsifdAC0a7ZKd+ouRZ5Ef8daS0yFgZmwPbIp0KqnI81nNCg/LEGLjUqHoURhJfv/qjRHWPH9aO9sTIkJrIOWPp52/ARL2JNEbglH97WAtuzi2p+iVyP+xiXjutbMrRu6iSLL6AQPTzVjDy/nt7TG0pSr1ST1Fv10FnfwzLN+3xXL/dArg7VcfmNX2Urmg76DYUVgAJKStkWybUxiQzMDg5/tFDTwTCYhntZ7A41R4/d0oqLFWqoxeoccay9iLR2P75w7CXH+bkOm/fOHwnKxQsP3CcXuA3XMGm7rulQjs/zY/UlWJ0PCHMjFjwbeG5i/IybzWvVJ8girFwtjbiwKHq7u/uhdX1J2o6f/9b1gymV/BmZ8Csob5c6NSBHwjBJk8qDpQKlUr+onWtCTBmg7s5HCxPEum71SmVvbGVML+EY6ijfQsGbbBS4nY6IMMlhJM4JhvOlMIQw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba4a30e-c062-4491-0e3f-08dc3e462d98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:30:31.3218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UtxejT122VFtSxSPjuAehfx2puB+RV0Idxnip86zxvncBcNngf+wmdTS5PkyeEfWpOkmPUYXyNn2dQXlHuIg+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
X-Proofpoint-ORIG-GUID: blYuH6VmAT5JhF-d9Xyn5xBoQ9Bs_SVE
X-Proofpoint-GUID: blYuH6VmAT5JhF-d9Xyn5xBoQ9Bs_SVE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070010

SGksDQoNCk9uIE1vbiwgRmViIDI2LCAyMDI0LCBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkg
d3JvdGU6DQo+IEhpDQo+IA0KPiBPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAxMTozNuKAr1BNIFRo
aW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBI
aSwNCj4gPg0KPiA+IE9uIE1vbiwgRmViIDI2LCAyMDI0LCBNaWNoYWVsIFRyaW1hcmNoaSB3cm90
ZToNCj4gPiA+IFRoaXMgcGF0Y2ggYXZvaWQgdG8gZGlzY29ubmVjdCBhbiBhbHJlYWR5IGdhZGdl
dCBpbiBub3QgY29ubmVjdGVkIHN0YXRlDQo+ID4gPg0KPiA+ID4gWyAgIDQ1LjU5NzI3NF0gZHdj
MyAzMTAwMDAwMC51c2I6IHdhaXQgZm9yIFNFVFVQIHBoYXNlIHRpbWVkIG91dA0KPiA+ID4gWyAg
IDQ1LjU5OTE0MF0gZHdjMyAzMTAwMDAwMC51c2I6IGZhaWxlZCB0byBzZXQgU1RBTEwgb24gZXAw
b3V0DQo+ID4gPiBbICAgNDUuNjAxMDY5XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0NCj4gPiA+IFsgICA0NS42MDEwNzNdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDE1MCBhdCBk
cml2ZXJzL3VzYi9kd2MzL2VwMC5jOjI4OSBkd2MzX2VwMF9vdXRfc3RhcnQrMHhjYy8weGQ0DQo+
ID4gPiBbICAgNDUuNjAxMTAyXSBNb2R1bGVzIGxpbmtlZCBpbjogY2ZnODAyMTEgcmZraWxsIGlw
djYgcnBtc2dfY3RybCBycG1zZ19jaGFyIGNyY3QxMGRpZl9jZSBydGlfd2R0IGszX2o3Mnh4X2Jh
bmRnYXAgcnRjX3RpX2szIG9tYXBfbWFpbGJveCBzYTJ1bCBhdXRoZW5jIFtsYXN0IHVubG9hZGVk
OiB0aV9rM19yNV9yZW1vdGVwcm9jXQ0KPiA+ID4gWyAgIDQ1LjYwMTE1MV0gQ1BVOiAwIFBJRDog
MTUwIENvbW06IHNoIE5vdCB0YWludGVkIDYuOC4wLXJjNSAjMQ0KPiA+ID4gWyAgIDQ1LjYwMTE1
OV0gSGFyZHdhcmUgbmFtZTogQlNIIC0gQ0NNLU0zIChEVCkNCj4gPiA+IFsgICA0NS42MDExNjRd
IHBzdGF0ZTogNjAwMDAwYzUgKG5aQ3YgZGFJRiAtUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTIEJU
WVBFPS0tKQ0KPiA+ID4gWyAgIDQ1LjYwMTE3Ml0gcGMgOiBkd2MzX2VwMF9vdXRfc3RhcnQrMHhj
Yy8weGQ0DQo+ID4gPiBbICAgNDUuNjAxMTc5XSBsciA6IGR3YzNfZXAwX291dF9zdGFydCsweDUw
LzB4ZDQNCj4gPiA+IFsgICA0NS42MDExODZdIHNwIDogZmZmZjgwMDA4MzI3MzllMA0KPiA+ID4g
WyAgIDQ1LjYwMTE4OV0geDI5OiBmZmZmODAwMDgzMjczOWUwIHgyODogZmZmZjgwMDA4MmEyMTAw
MCB4Mjc6IGZmZmY4MDAwODA4ZGM2MzANCj4gPiA+IFsgICA0NS42MDEyMDBdIHgyNjogMDAwMDAw
MDAwMDAwMDAwMiB4MjU6IGZmZmY4MDAwODI1MzBhNDQgeDI0OiAwMDAwMDAwMDAwMDAwMDAwDQo+
ID4gPiBbICAgNDUuNjAxMjEwXSB4MjM6IGZmZmYwMDAwMDBlMDc5YTAgeDIyOiBmZmZmMDAwMDAw
ZTA3YTY4IHgyMTogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+ID4gWyAgIDQ1LjYwMTIxOV0geDIwOiBm
ZmZmMDAwMDAwZTA3ODgwIHgxOTogZmZmZjAwMDAwMGUwNzg4MCB4MTg6IDAwMDAwMDAwMDAwMDAw
NDANCj4gPiA+IFsgICA0NS42MDEyMjldIHgxNzogZmZmZjdmZmY4ZTFjZTAwMCB4MTY6IGZmZmY4
MDAwODAwMDAwMDAgeDE1OiBmZmZmZmZmZmZmZmU1MjYwDQo+ID4gPiBbICAgNDUuNjAxMjM5XSB4
MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAyMDZlNmYyMDRjNGM0MTU0IHgxMjogNTMyMDc0NjU3
MzIwNmY3NA0KPiA+ID4gWyAgIDQ1LjYwMTI0OV0geDExOiAwMDAwMDAwMDAwMDAwMDAxIHgxMDog
MDAwMDAwMDAwMDAwMDAwYSB4OSA6IGZmZmY4MDAwODMyNzM5MzANCj4gPiA+IFsgICA0NS42MDEy
NTldIHg4IDogMDAwMDAwMDAwMDAwMDAwYSB4NyA6IGZmZmZmZmZmZmZmZjNmMGMgeDYgOiBmZmZm
ZmZmZmZmZmYzZjAwDQo+ID4gPiBbICAgNDUuNjAxMjY4XSB4NSA6IGZmZmZmZmZmZmZmZjNmMGMg
eDQgOiAwMDAwMDAwMDAwMDAwMDAwIHgzIDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gWyAgIDQ1
LjYwMTI3OF0geDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogZmZmZjAwMDAwNGU3ZTYwMCB4MCA6
IDAwMDAwMDAwZmZmZmZmOTINCj4gPiA+IFsgICA0NS42MDEyODldIENhbGwgdHJhY2U6DQo+ID4g
PiBbICAgNDUuNjAxMjkzXSAgZHdjM19lcDBfb3V0X3N0YXJ0KzB4Y2MvMHhkNA0KPiA+ID4gWyAg
IDQ1LjYwMTMwMV0gIGR3YzNfZXAwX3N0YWxsX2FuZF9yZXN0YXJ0KzB4OTgvMHhiYw0KPiA+ID4g
WyAgIDQ1LjYwMTMwOV0gIGR3YzNfZXAwX3Jlc2V0X3N0YXRlKzB4NWMvMHg4OA0KPiA+ID4gWyAg
IDQ1LjYwMTMxNV0gIGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCsweDE0NC8weDE2MA0KPiA+
ID4gWyAgIDQ1LjYwMTMyM10gIGR3YzNfZ2FkZ2V0X3N1c3BlbmQrMHgxOC8weGIwDQo+ID4gPiBb
ICAgNDUuNjAxMzI5XSAgZHdjM19zdXNwZW5kX2NvbW1vbisweDVjLzB4MThjDQo+ID4gPiBbICAg
NDUuNjAxMzQxXSAgZHdjM19zdXNwZW5kKzB4MjAvMHg0NA0KPiA+ID4gWyAgIDQ1LjYwMTM1MF0g
IHBsYXRmb3JtX3BtX3N1c3BlbmQrMHgyYy8weDZjDQo+ID4gPiBbICAgNDUuNjAxMzYwXSAgX19k
ZXZpY2Vfc3VzcGVuZCsweDEwYy8weDM0Yw0KPiA+ID4gWyAgIDQ1LjYwMTM3Ml0gIGRwbV9zdXNw
ZW5kKzB4MWE4LzB4MjQwDQo+ID4gPiBbICAgNDUuNjAxMzgyXSAgZHBtX3N1c3BlbmRfc3RhcnQr
MHg4MC8weDljDQo+ID4gPiBbICAgNDUuNjAxMzkxXSAgc3VzcGVuZF9kZXZpY2VzX2FuZF9lbnRl
cisweDFjNC8weDU4NA0KPiA+ID4gWyAgIDQ1LjYwMTQwMl0gIHBtX3N1c3BlbmQrMHgxYjAvMHgy
NjQNCj4gPiA+IFsgICA0NS42MDE0MDhdICBzdGF0ZV9zdG9yZSsweDgwLzB4ZWMNCj4gPiA+IFsg
ICA0NS42MDE0MTVdICBrb2JqX2F0dHJfc3RvcmUrMHgxOC8weDJjDQo+ID4gPiBbICAgNDUuNjAx
NDI2XSAgc3lzZnNfa2Zfd3JpdGUrMHg0NC8weDU0DQo+ID4gPiBbICAgNDUuNjAxNDM0XSAga2Vy
bmZzX2ZvcF93cml0ZV9pdGVyKzB4MTIwLzB4MWVjDQo+ID4gPiBbICAgNDUuNjAxNDQ1XSAgdmZz
X3dyaXRlKzB4MjNjLzB4MzU4DQo+ID4gPiBbICAgNDUuNjAxNDU4XSAga3N5c193cml0ZSsweDcw
LzB4MTA0DQo+ID4gPiBbICAgNDUuNjAxNDY3XSAgX19hcm02NF9zeXNfd3JpdGUrMHgxYy8weDI4
DQo+ID4gPiBbICAgNDUuNjAxNDc3XSAgaW52b2tlX3N5c2NhbGwrMHg0OC8weDExNA0KPiA+ID4g
WyAgIDQ1LjYwMTQ4OF0gIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4NDAvMHhlMA0KPiA+
ID4gWyAgIDQ1LjYwMTQ5OF0gIGRvX2VsMF9zdmMrMHgxYy8weDI4DQo+ID4gPiBbICAgNDUuNjAx
NTA2XSAgZWwwX3N2YysweDM0LzB4YjgNCj4gPiA+IFsgICA0NS42MDE1MTZdICBlbDB0XzY0X3N5
bmNfaGFuZGxlcisweDEwMC8weDEyYw0KPiA+ID4gWyAgIDQ1LjYwMTUyMl0gIGVsMHRfNjRfc3lu
YysweDE5MC8weDE5NA0KPiA+ID4gWyAgIDQ1LjYwMTUzMV0gLS0tWyBlbmQgdHJhY2UgMDAwMDAw
MDAwMDAwMDAwMCBdLS0tDQo+ID4gPiBbICAgNDUuNjA4Nzk0XSBEaXNhYmxpbmcgbm9uLWJvb3Qg
Q1BVcyAuLi4NCj4gPiA+IFsgICA0NS42MTEwMjldIHBzY2k6IENQVTEga2lsbGVkIChwb2xsZWQg
MCBtcykNCj4gPiA+IFsgICA0NS42MTE4MzddIEVuYWJsaW5nIG5vbi1ib290IENQVXMgLi4uDQo+
ID4gPiBbICAgNDUuNjEyMjQ3XSBEZXRlY3RlZCBWSVBUIEktY2FjaGUgb24gQ1BVMQ0KPiA+ID4N
Cj4gPiA+IFRlc3RlZCBvbiBhIGFtNjJ4IGJvYXJkIHdpdGggYSB1c2JuZXQgZ2FkZ2V0DQo+ID4g
Pg0KPiA+ID4gRml4ZXM6IDYxYTM0ODg1N2U4NiAoInVzYjogZHdjMzogZ2FkZ2V0OiBGaXggTlVM
TCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGR3YzNfZ2FkZ2V0X3N1c3BlbmQpDQo+ID4gPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBUcmlt
YXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IFYy
LT5WMzoNCj4gPiA+ICAgICAgIC0gQ2hhbmdlIHRoZSBsb2dpYyBvZiB0aGUgcGF0Y2ggdXNpbmcg
dGhlIGdhZGdldCBjb25uZWN0ZWQgc3RhdGUNCj4gPiA+ICAgICAgIC0gQ2hhbmdlIG9mIHRoZSBj
b21taXQgbWVzc2FnZQ0KPiA+ID4gVjEtPlYyOg0KPiA+ID4gICAgICAgLSBBZGQgc3RhYmxlIGlu
IENDDQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgOSArKysr
KysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9k
d2MzL2dhZGdldC5jDQo+ID4gPiBpbmRleCA0YzhkZDY3MjQ2NzguLmE3MzE2YTE3MDNhZCAxMDA2
NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+ICsrKyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiA+IEBAIC0yNjUwLDYgKzI2NTAsMTUgQEAgc3Rh
dGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3YzMgKmR3YykNCj4g
PiA+ICAgICAgIGludCByZXQ7DQo+ID4gPg0KPiA+ID4gICAgICAgc3Bpbl9sb2NrX2lycXNhdmUo
JmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gKyAgICAgLyoNCj4gPiA+ICsgICAgICAqIEF0dGVt
cHQgdG8gZGlzY29ubmVjdCBhIG5vIGNvbm5lY3RlZCBnYWRnZXQNCj4gPiA+ICsgICAgICAqLw0K
PiA+ID4gKyAgICAgaWYgKCFkd2MtPmNvbm5lY3RlZCkgew0KPiA+ID4gKyAgICAgICAgICAgICBk
ZXZfd2Fybihkd2MtPmRldiwgIk5vIGNvbm5lY3RlZCBkZXZpY2VcbiIpOw0KPiA+ID4gKyAgICAg
ICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiArICAgICB9DQo+ID4gPiArDQo+ID4gPiAg
ICAgICBkd2MtPmNvbm5lY3RlZCA9IGZhbHNlOw0KPiA+ID4NCj4gPiA+ICAgICAgIC8qDQo+ID4g
PiAtLQ0KPiA+ID4gMi40MC4xDQo+ID4gPg0KPiA+DQo+ID4gVGhlcmUncyBhbHJlYWR5IGEgZml4
IGZvciB0aGlzLCBhbmQgaXQncyBhbHJlYWR5IGluIG1haW5saW5lLiBMZXQgbWUNCj4gPiBrbm93
IGlmIHRoaXMgd29ya3MgZm9yIHlvdToNCj4gPg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD1iMTkxYTE4Y2I1YzQ3MTA5Y2E2OTYzNzBhNzRhNTA2
MmE3MGFkZmQwX187ISFBNEYyUjlHX3BnIWRxRi1kR1NIR1I0MUJlcF83WkcybVdmUE5ZV2ZDNFQt
X0ZwT2ZfcEZJdnFhOUwxbjFlNmw2RDNvUDliT2xSUkZvYlc0VXZoMFZBUDhxQmtMTWZOa1VsZmFl
VGMkIA0KPiA+DQo+IA0KPiBDYW4geW91IGV4cGxhaW4gdG8gbWUgdGhlIGxvZ2ljIGhlcmU/IEkg
bWVhbiBwdWxsc3VwX2Nvbm5lY3RlZCBzZWVtcw0KPiBuZXZlciBwcm90ZWN0ZWQgYnkgc3BpbiBs
b2NrIGFuZCBzbyBJIGNhbiBub3QgZmlndXJlDQo+IG91dCBpdCBlYXNpbHkgYW5kIHRoZSBjb21t
aXQgbWVzc2FnZSBkb2VzIG5vdCBleHBsYWluIHNvIG11Y2gNCj4gDQoNClNvcnJ5IGZvciB0aGUg
ZGVsYXkgcmVzcG9uc2UuDQoNCkFoLi4geW91J3JlIHJpZ2h0LCB0aGUgc3Bpbl9sb2NrIGlzbid0
IHVzZWZ1bCB0aGVyZS4gTXkgaW50ZW50aW9uIHdhcyB0bw0KYXZvaWQgc29mdCBkaXNjb25uZWN0
IGZsb3cgdG8gb2NjdXIgZHVyaW5nIHN5c3RlbSBzdXNwZW5kIGFsb25nIHdpdGgNCnB1bGx1cChv
ZmYpLiBJIHNvbWVob3cgZm9yZ290IHRoYXQgaXQgaXNuJ3QgcHJvdGVjdGVkIHdpdGggc3Bpbl9s
b2NrLg0KDQpJdCdzIGEgdmVyeSB1bmxpa2VseSBzY2VuYXJpby4gRXZlbiBpZiBpdCBkaWQgaGFw
cGVuLCBpdCBzaG91bGQgYmUNCmhhcm1sZXNzLiBCdXQgdG8gc29sdmUgdGhhdCBwZXJoYXBzIHdl
IGNhbjoNCjEpIEtlZXAgdGhlIGNvZGUgc2ltcGxlIGFuZCBlbmZvcmNlIG5vIHNsZWVwIGFuZCBo
b2xkIHNwaW5fbG9jayBkdXJpbmcNCiAgIHRoZSBlbnRpcmV0eSBvZiBydW5fc3RvcCgpIHNlcXVl
bmNlDQoyKSBFbmZvcmNlIGEgbXVzdC1sb2NrIGNoZWNrIHRvIHJ1bl9zdG9wKCkgYW5kIHVubG9j
ayBkdXJpbmcgc2xlZXAuIFRoaXMNCiAgIHJlcXVpcmVzIG1vcmUgY29kZSBjaGFuZ2VzIGFuZCBy
ZXZpZXdzLg0KDQpJZiB5b3UgaGF2ZSBzb21lIGlkZWFzLCBwbGVhc2Ugc2hhcmUuIChOb3RlIHRo
YXQgdXNpbmcgZHdjLT5jb25uZWN0ZWQNCmlzbid0IHN1ZmZpY2llbnQpDQoNClRoYW5rcywNClRo
aW5o

