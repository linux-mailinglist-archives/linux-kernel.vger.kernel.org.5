Return-Path: <linux-kernel+bounces-79280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5C3861FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAE81C2248E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7E146E71;
	Fri, 23 Feb 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="v526G87L";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SrVtFYe1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="m1+4PqMF"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8853D6C;
	Fri, 23 Feb 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728483; cv=fail; b=Rn0BWVNPfX4jEczJOnngq9EPE5pW2R2ku5Q+Cru26o1WuntOWDfFICtEnyWvz+r7r3yQd4kvnZXkr8qryuXq5KRR9E7m54GQxvj4LhC/Nb2NR69DXu3mvQKWAllhqtbpC/xVKYkyhXyN9ky7DeD56K7psOP0eB+us4OfW2EeZag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728483; c=relaxed/simple;
	bh=isV99hn4MbKHZ3eWuJ0EJBOg+J45Hv0spSnButoehk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lpOE0WeRD6Z71/KFwe+v5AjJIAf++e1KXyoDHOdG8RNfEssXXbBeiRBMFYAHiArye9npd7vt2kGTegZzMej9HVhuJM9f1woZ0F9gr8NIBohh645ak9cQxMlf1F3YBrIwgP1rq+a1zQL9/cA31wKNw1dk+dK2QweUPFnSAZoy/Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=v526G87L; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=SrVtFYe1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=m1+4PqMF reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NMUUdq004360;
	Fri, 23 Feb 2024 14:47:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=isV99hn4MbKHZ3eWuJ0EJBOg+J45Hv0spSnButoehk0=; b=
	v526G87LNbtA+VwtPLToMvSh46PhX5kPTWsGDd4sz2xWpyQik+w+9ZAFZaMlBY0I
	HuGLX3d1N0SYSa/kv0FqSAByJYpOHmkChd5i+VBBW6D5FeeaBDU8Y8XQ34Q+QKva
	ok/juXxPDzdzRQc7LA1uv4zFbIuMRV4DVSuObDCc8QHgPJsNE7PUhNW+Z+XwULeH
	F5nBUAPb7i3QMNxLY8yOP8GCPiJiB2bkGdnU5KKPPEWypHEgqFF1c9e6A40F2zDQ
	Fks+rvrH1DV19f1I49uu7G8BdbV1iE7Bp7j6sfLN9wS6/RbDkP0CfnKFMczD0MVm
	Br9/KlTIOUEX0CfzUr8tqA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3wd22893km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708728474; bh=isV99hn4MbKHZ3eWuJ0EJBOg+J45Hv0spSnButoehk0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=SrVtFYe1QoAKw7BUwSWv96wMsnjWnzhv3Y1pasKGK+m2MgIXe+pPrQvYBkHTJuNnG
	 0zlAKGNigk6QXU8iYSDoZC08hite/W4iOsRZAJt+yhwZA9GGIuOMcDP/CFSqKQllLd
	 4EboZzkQR9nsDZchF2+Fn1ubtSYN4e7Xuv0KykEQhtmTnlyVz45C3doOg9qBa1Yz01
	 TZYdCivBYT76HcIcYC8GJRNW7t1tu82fP8hRojLB3X/rMefqN1nIZ0m8hSudmByByz
	 qUcEr4JhYMdnuxtTm3IODb1w4kCSDsMAOtg4jAV7lV5WBNftfm85AcItufK7JeP+0L
	 zCASOxfZOBUYA==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 608CB40347;
	Fri, 23 Feb 2024 22:47:54 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 9B4A2A008A;
	Fri, 23 Feb 2024 22:47:53 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=m1+4PqMF;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 12BE540235;
	Fri, 23 Feb 2024 22:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQmIjUduNUcbExkfsfVTT00gspWtzHOt/LmX4GO6oHEB77v6RlV9bR3SlJMk/Qg9/PMV/O6MdlXtxANu7UOX6aI9YHfvKTzlIoqGsy+Y47rQMtT3ILqLcsserBRtGRFFiYl8kuOa2Vbgu0acHFFhgUDMjEZUBT60HXuRky3IlUP0VN9ZF+GAvPYOJfXLCXKXev76zXQh1hnnEHCkcdLWD/EzbBqVg7h9nTbtcH7IIzV4TThXiognujVvSx8m/hGvN0/PJfkjYkB5434ymkgF4rQGJr+UPj1WFv3bAdF2u345UtYDHHwo1bFMqPzrobsFX8pQY3b8qc4S506D06z6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isV99hn4MbKHZ3eWuJ0EJBOg+J45Hv0spSnButoehk0=;
 b=cxVjHS8xAbUqnCJbFoTcyGj45wPNuV5SHAK/3qi7SzRKDJNpsaqV4EwV8XIRKrX8LAn5cPKlM+fXr5RzuVVu72ctEwT+v1tuQombcPJOMES0ar/l5mPUaxsbXz9Xdli18wTwfRnbGFuYm2uflp/fl7ErO71kAopZDg9o3PpKXGzKtf/yOXn1rWKI3TCu3ZT43nDB0uiZVF9PxeqmUl3cDylCiyJlmOvXYWCPVCyFJpgnW/viV9/VEG1m4A0f3m4IDQXS56W42QiyQXUNBuiL1/tDaPrQDjeqDZIwOm1zqk6GpU5r96qfnpzAEOC2r9iQH7cXIcX740+4yZ4fn6Ju8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isV99hn4MbKHZ3eWuJ0EJBOg+J45Hv0spSnButoehk0=;
 b=m1+4PqMFgqZ/qO/K+1q8++wriqxFzZBV7Y1ijgoMJjPKsH638l4lpBqSDuKr7iRZnzYU1rJ0OnBbzXN9xoUqbPDDMf1xTqsYfl/LRGsN22tMszwT410QkDLOrc0eNNpxl7t1sGFBiOE8RVCtFX/22HQemqSYV76w+WZUUiYqIjM=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.19; Fri, 23 Feb
 2024 22:47:49 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:47:49 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Mehta, Piyush" <piyush.mehta@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu,  Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        "Pandey, Radhey  Shyam" <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] usb: dwc3: core: enable CCI support
Thread-Topic: [PATCH] usb: dwc3: core: enable CCI support
Thread-Index: AQHZ/ZcFv/K9cjDJNkagq5mdTaNI2bBTW6qAgBoZHgCABY23gIALNHyAgJsidwA=
Date: Fri, 23 Feb 2024 22:47:49 +0000
Message-ID: <20240223224744.vptvfkqzgqv24ptz@synopsys.com>
References: <20231013053448.11056-1-piyush.mehta@amd.com>
 <20231020231615.w5m2w5bknblpkhyt@synopsys.com>
 <MN2PR12MB43336B903F927A7120A7E09F88AAA@MN2PR12MB4333.namprd12.prod.outlook.com>
 <20231110023725.fotx3bkkei5jkzid@synopsys.com>
 <MN2PR12MB4333DDBA74CF27A38FDAFF2388B7A@MN2PR12MB4333.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN2PR12MB4333DDBA74CF27A38FDAFF2388B7A@MN2PR12MB4333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB9062:EE_
x-ms-office365-filtering-correlation-id: b6cd9076-28d2-4b5c-66db-08dc34c175e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rhWzMHjOmY37YjmWDzP7VBiR5cMz2TIVKgTQG0D6a5M/6M+aTMRGvTWfVojTrf3a+E3ZALbKH855+rHpY68Mq7Plft6WIdmueuR2JJdnjxEApMHJ1LsmkRTwHnzzXmUFZMu5IzTHOzPgfNJpff3cpNxt5Dz0o23LCw+5c5ifoML42iU3TZqFax4LSk7VPHuhOu60wl+XfILdB4SYsWHCFTYtGUHXVTP5Jpwn+HiuhaDryUuWZIV0ldR4AISLwXw5OXN3cg44y4wbaVU9fhRi5ghOclNjAdY6RHTLMyQvlRNlL+OjnUy9OV4MapuHZLGRHMmRAIUGiIO0EE9VyArKVFeZTnf0Gdjyokd7qqKBpKQUtuygo2laeV3pDnteo3sy9N+W9jecUcb95fMHhmfydZLhSF3MegfiHEhDXBtLbmbZQbybEQYTwEg8dJkh7591G3uJcmWQp5BoTEarX4dtjPRM39a8eCwcTPQc0NkTH8pNfJoSP84x5Gb5R0qSPXuvRen3e7GZrDVVNZkPiEeUqRbVL8Ym5tl518Kj51Osvg1d8JJdg+zEwkFcAzcc1K4QOCFjUkQMJKsnCOSbUHCwgbeiBPcNHyT+a3CCeHaEEFE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?T1VXKzFveC9wYjZPUVgxYVphOVhTMEE2UW5yeHpOK2FkMC9DSFc1Y3hrRFI2?=
 =?utf-8?B?RFJWUHppaWVJcnhTeXp6M3hzYnhwaWNLclVmamJscmFDMFR0OW5YNjNjT1VS?=
 =?utf-8?B?SDdHOGU4ZjJ6L0YxK2pxVEFnR2xoZ255YXZNTnJVQ1g4cFdmQzhpeDAyTXpt?=
 =?utf-8?B?YUlOZ3pGdzZPc2xOTnpiNFJ2SENIZ3l0NHBIZFBnYi8rWlpBbWkvTHZnTmhS?=
 =?utf-8?B?RDh0aktyN21JdW1FNWdBRllZemhpeDU0TjAyL25xcmtRQTB6Ui95cnpJZ0Zz?=
 =?utf-8?B?Skp1TFBRS1BVVDV4RzM2eEoza1Jvb0M2S2oyNURyMlE3U3JvaDc4bVk5ZkhL?=
 =?utf-8?B?Nk8rbXNoMER1b3dJYzdmdkFBS015M1AveFRLMUdhT09iOHBabGRVMUdzOVA3?=
 =?utf-8?B?emN6elZEOTUwcUJicmIrQkpVeW0xeGhiS25sbkFpWk9FYXJ2enVWQy9RVmh0?=
 =?utf-8?B?WnA2UHZldSt5RnI1MytaTkNQSm9lOTZuVGRMZXNrWG9Xemthd0x1L0NVVjUz?=
 =?utf-8?B?YlJkR0lDdmFZd0NWdVA5ZFVCUGFUN0ZWMU5MNHNreHBaUkJkVlJPbEYzbGdY?=
 =?utf-8?B?dGVjVUk5NlZndTh5NmMwVVRneTkxeEY0clZMYytWUk5mNGs1MWQ3UVdDc1gw?=
 =?utf-8?B?dlYwK1ZIZ0lFNUp0Y0dNS0dyT25JdG1hQ3BnZGxGS2l5Vm5teXV5WnFnVVd4?=
 =?utf-8?B?bnZaeGlFUTdIcWtYcW5IMW5mUkY0TWRqclJVMWxVeWI2am4zZlFyVzd1NElM?=
 =?utf-8?B?Y1gyWWpsWU1nbElodTZXcEFiWW1mb3BmcjVabDlLUWRzcFJJRUkyZ0Y2RU9R?=
 =?utf-8?B?a2FRZFZqeU5qNVRnZU5rQVJiOFBaSnlIS2hzNFRKa2p6cUIwcE5Tc1FOZ2VM?=
 =?utf-8?B?NHJFc3R3czZPNFpGbzVCS2hMN2RqZTRoZFJ6bGxGOEtXQllyZExqZFFMU1lo?=
 =?utf-8?B?c0wrT09KcXN1YzVBOEhqMG1yVjUvNXF0aWJoLzRqbCtKZHB4c1IwNk5RL1ly?=
 =?utf-8?B?bDNqdUd5aHJBcU1OZG9UaXhHY252Y2MrZXh2SHRpaXVYZmVVcTdhdW9ubStl?=
 =?utf-8?B?eUY3dWdqMTBxQm5ScXJPQTRMTHpudnN1UWxWZFN1UG8xMkJ1TkF1WFFNVVA3?=
 =?utf-8?B?TnNuams5aFJmNFVrSDJWVVhRSjl6MlMrZEV2ZVV4Y2sxTVVWR3VrZ3hsMnpC?=
 =?utf-8?B?eFBJNEhCcTNWRVEvaHRzMjArd2tGMDNiSmlueTg4TkcwdUlIY3FoQVJUMlhT?=
 =?utf-8?B?QVovT2pkREQ2bUh2WG1tZ1h5aFgrYVkwYXMwL3Y0L2poa3RZQkxJUGxuMUtj?=
 =?utf-8?B?MmF2dzJIUVBqNi8rQ3lmamkrM1NmOVZIZ2xaSkRiVDRxTm9vNXJKQ0tmeVVG?=
 =?utf-8?B?eEFnL0NwOHFnbXo4R2lINm5Zb0Ftc2tMaUhzWVMvekhya0U3SitKaGlmK1RU?=
 =?utf-8?B?OHhRclNKUVBWREw2VDlMUXFicGplbVRIdVlJRHJNMU9GN0EzRE5xZVNCaDBE?=
 =?utf-8?B?MkRUODJobmpVd2NBUHloY2ZLem4xdUFJVzdjb2t2SmZVSVpZdEgvUmZqRmNW?=
 =?utf-8?B?cEV0WDZPU2NtajRNbkxsQ1Z6UFFhaEd3M3N4aCtxYzRJbXN5WHNYUFVPTjc1?=
 =?utf-8?B?Z0h6cm5HRkVZT2dGQlVFdHdTbjhxV2x2YW1CaFBOTmhBeXZqdHhKS09KYkow?=
 =?utf-8?B?KzdJbkIwT0tvOFZDc1FVVkkwbWNaN0VucFlGc2xSdmhHOE53VWRDdk9KNWdU?=
 =?utf-8?B?eXdYS29qWm02NzhhVzQ4WGxlb1RiMWNmUkhJN2dmT0swKzRpV0FiNTBONVVs?=
 =?utf-8?B?c3J1dVdybkxsL2dFZ2V5REwyemVPQ0FoUHFPdG1DSEZtdTR4ajAvSFdJRk9s?=
 =?utf-8?B?RXF2TEgwSi9GOGIxV3NsbUtIbXc2dUVIR0pEZ0JsVjlCcGkwVlhFSkViVEtm?=
 =?utf-8?B?S3UycHhWc3JjY0N1OW4xMm5nbEl2b1hXeG1VM3RtY20zM3RBenE2NmEzbU85?=
 =?utf-8?B?WVdjMmE5ck1Eei9nUnhaVnF3ei9mYVQxZ2dUUEt5N1J6T2VpaG1PalRyRHVT?=
 =?utf-8?B?UW1HUUhiSDh0bEQzT0tGdnoramJSWTg1c1VJcnl1K1NLaGF1ZDVyNlIwYVow?=
 =?utf-8?Q?Lg7ybSSXV0VL9061p5Tv/rS/3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2725ED14EAE07543A5702D8E3C63B31C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UDiqldaPShcP50wMIkBdsfuk5/iepH00SxGbR9SkBNZipjEiHYRMF304NQeS78jJpp2Usn1chWZqQouxvKbTtI22C6KvuW2ozcWqhU6HtKZ5ZlvywZEY281S8AkbpoqJPqb5GAYP+7MXjbOYcQK3NoiTX62di8/hx5y7/ykhw0+U/tIsTGLZTf7aTrqEBriwsnGnGpd5Bn+QTxamcElmL8xD8XhQxxW0rPbGTmqtEi0BbFGFtWEiUneATa0c5a1Esk+JYAQ4axrsBBBvOa4hwUHiU5tafLgp1kmlh73aBmln8vPt6kn8zHycjMHmtci/qDFRWhBtnbLUiCYaRWDe3pRQVe2KLM1lZGgAX59YRcV4mGlFY7wYrycXn437rFK0wpMW3VjUSuvCGNj7L2MRwj3o9riCqtakHrOC8yQY81r4VkE2c46aLbko8Sil0Cud78Im2c58UiQRmvxSztHRxQJhxZFc90PwdlW6fGkVI758ONr9w/EV5rJDVTWw/J7vInK00zqXG9UKGK7jduliIy+ICcnxOqEGoevpo3hBg7Bj8nrHwe3EDSfShdct1gShuKvu5+7cksKiAjObcJJHxgUJAStdzNznJP4XWJRmQlCbC1NUDupISV2shVRwVrRm5HdsIa7dnDAuIdXN0LsHYQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cd9076-28d2-4b5c-66db-08dc34c175e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:47:49.0662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIEJVdjr/xM11n7SmxRzZfbr31B8u3BPb3jmteymd2DgSdo85YZITdRiSuko6sycpWDs/qTOWTbelCcFcT5P0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
X-Proofpoint-GUID: vH8gfQS24zPVNIUxGfmwxhzaRVEbRChj
X-Proofpoint-ORIG-GUID: vH8gfQS24zPVNIUxGfmwxhzaRVEbRChj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230163

T24gRnJpLCBOb3YgMTcsIDIwMjMsIE1laHRhLCBQaXl1c2ggd3JvdGU6DQo+IEhpLA0KPiANCj4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFRoaW5oIE5ndXllbiA8VGhp
bmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAy
MDIzIDg6MDcgQU0NCj4gPiBUbzogTWVodGEsIFBpeXVzaCA8cGl5dXNoLm1laHRhQGFtZC5jb20+
DQo+ID4gQ2M6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47DQo+ID4g
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0Bh
bWQuY29tPjsgbGludXgtDQo+ID4gdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgUGFsYWR1Z3UsIFNpdmEgRHVyZ2EgUHJhc2FkDQo+ID4gPHNpdmEuZHVy
Z2EucHJhc2FkLnBhbGFkdWd1QGFtZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA+IDxy
YWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNi
OiBkd2MzOiBjb3JlOiBlbmFibGUgQ0NJIHN1cHBvcnQNCj4gPiANCj4gPiBPbiBNb24sIE5vdiAw
NiwgMjAyMywgTWVodGEsIFBpeXVzaCB3cm90ZToNCj4gPiA+IEhpIFRoaW5oLA0KPiA+ID4NCj4g
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+ID4gPiBTZW50OiBTYXR1cmRheSwg
T2N0b2JlciAyMSwgMjAyMyA0OjQ2IEFNDQo+ID4gPiA+IFRvOiBNZWh0YSwgUGl5dXNoIDxwaXl1
c2gubWVodGFAYW1kLmNvbT4NCj4gPiA+ID4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
OyBTaW1laywgTWljaGFsDQo+ID4gPiA+IDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IFRoaW5oIE5n
dXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47DQo+ID4gPiA+IGxpbnV4LXVzYkB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGdpdA0KPiA+ID4gPiAo
QU1ELVhpbGlueCkgPGdpdEBhbWQuY29tPg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSB1
c2I6IGR3YzM6IGNvcmU6IGVuYWJsZSBDQ0kgc3VwcG9ydA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBG
cmksIE9jdCAxMywgMjAyMywgUGl5dXNoIE1laHRhIHdyb3RlOg0KPiA+ID4gPiA+IFRoZSBHU0JV
U0NGRzAgcmVnaXN0ZXIgYml0cyBbMzE6MTZdIGFyZSB1c2VkIHRvIGNvbmZpZ3VyZSB0aGUNCj4g
PiA+ID4gPiBjYWNoZSB0eXBlIHNldHRpbmdzIG9mIHRoZSBkZXNjcmlwdG9yIGFuZCBkYXRhIHdy
aXRlL3JlYWQNCj4gPiA+ID4gPiB0cmFuc2ZlcnMgKENhY2hlYWJsZSwgQnVmZmVyYWJsZS8gUG9z
dGVkKS4gV2hlbiBDQ0kgaXMgZW5hYmxlZCBpbg0KPiA+ID4gPiA+IHRoZSBkZXNpZ24sDQo+ID4g
PiA+ID4gRFdDMyBjb3JlIEdTQlVTQ0ZHMCBjYWNoZSBiaXRzIG11c3QgYmUgdXBkYXRlZCB0byBz
dXBwb3J0IENDSQ0KPiA+ID4gPiA+IGVuYWJsZWQNCj4gPiA+ID4gdHJhbnNmZXJzIGluIFVTQi4N
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFBpeXVzaCBNZWh0YSA8cGl5dXNo
Lm1laHRhQGFtZC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gRFdDMyBSZWdpc3RlciBN
YXAgTGluazoNCj4gPiA+ID4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9k
b2NzLnhpbGlueC5jb20vci9lbi1VUy91ZzEwODcNCj4gPiA+ID4gPiAtenlucS0NCj4gPiA+ID4g
dWx0cmFzY2FsZS1yZWdpc3RlcnMvR1NCVVNDRkcwLVVTQjNfWEhDSS0NCj4gPiA+ID4NCj4gPiBS
ZWdpc3Rlcl9fOyEhQTRGMlI5R19wZyFjYkxiWUxrOXh1NTREWk1raVRRek1oZENhUEE0Z21JVklu
ZXM0WmVOYjI4DQo+ID4gPiA+IEFJMnBnZXNFdkhOWXRqb1pmV3ZFX3Q3d2xVZFp2WW4tUGlvOFdq
QTU1ZWthbCQNCj4gPiA+ID4gPiBSZWdpc3RlciBOYW1lCUdTQlVTQ0ZHMA0KPiA+ID4gPiA+IERl
c2NyaXB0aW9uCUdsb2JhbCBTb0MgQnVzIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXIgMA0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gR1NCVVNDRkcwIChVU0IzX1hIQ0kpIFJlZ2lzdGVyIEJpdC1GaWVsZDoN
Cj4gPiA+ID4gPiBEQVRSRFJFUUlORk8JMzE6MjgNCj4gPiA+ID4gPiBERVNSRFJFUUlORk8JMjc6
MjQNCj4gPiA+ID4gPiBEQVRXUlJFUUlORk8JMjM6MjANCj4gPiA+ID4gPiBERVNXUlJFUUlORk8J
MTk6MTYNCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMg
fCAxNyArKysrKysrKysrKysrKysrKw0KPiA+ID4gPiA+IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5o
IHwgIDUgKysrKysNCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3Jl
LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+ID4gPiA+IGluZGV4IDljNmJmMDU0ZjE1
ZC4uZmM2ODkyYzYzYWJmIDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4g
PiBAQCAtMjMsNiArMjMsNyBAQA0KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4N
Cj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQo+ID4gPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVz
cy5oPg0KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfZ3JhcGguaD4NCj4gPiA+ID4gPiAg
I2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0
cmwvY29uc3VtZXIuaD4gQEAgLTU1OSw2ICs1NjAsMjAgQEAgc3RhdGljDQo+ID4gPiA+ID4gdm9p
ZCBkd2MzX2NhY2hlX2h3cGFyYW1zKHN0cnVjdCBkd2MzDQo+ID4gPiA+ICpkd2MpDQo+ID4gPiA+
ID4gIAkJcGFybXMtPmh3cGFyYW1zOSA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLA0KPiA+ID4gPiBE
V0MzX0dIV1BBUkFNUzkpOyAgfQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIGR3
YzNfY29uZmlnX3NvY19idXMoc3RydWN0IGR3YzMgKmR3Yykgew0KPiA+ID4gPiA+ICsJaWYgKG9m
X2RtYV9pc19jb2hlcmVudChkd2MtPmRldi0+b2Zfbm9kZSkpIHsNCj4gPiA+ID4gPiArCQl1MzIg
cmVnOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVn
cywgRFdDM19HU0JVU0NGRzApOw0KPiA+ID4gPiA+ICsJCXJlZyB8PSBEV0MzX0dTQlVTQ0ZHMF9E
QVRSRFJFUUlORk9fTUFTSyB8DQo+ID4gPiA+ID4gKwkJCURXQzNfR1NCVVNDRkcwX0RFU1JEUkVR
SU5GT19NQVNLIHwNCj4gPiA+ID4gPiArCQkJRFdDM19HU0JVU0NGRzBfREFUV1JSRVFJTkZPX01B
U0sgfA0KPiA+ID4gPiA+ICsJCQlEV0MzX0dTQlVTQ0ZHMF9ERVNXUlJFUUlORk9fTUFTSzsNCj4g
PiA+ID4gPiArCQlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1NCVVNDRkcwLCByZWcpOw0K
PiA+ID4gPiA+ICsJfQ0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gKw0KPiA+ID4gPg0KPiA+ID4g
PiBZb3UncmUgb3ZlcndyaXRpbmcgZGVmYXVsdCB2YWx1ZXMgZm9yIGFsbCBwbGF0Zm9ybXMuIERv
bid0IGRvIHRoYXQuDQo+ID4gPiA+IE5vdCBldmVyeSBwbGF0Zm9ybSBzdXBwb3J0cyB0aGlzIHNl
dHRpbmcuIE9ubHkgYXBwbHkgdGhlc2Ugc3BlY2lmaWMNCj4gPiA+ID4gc2V0dGluZ3MgdG8geW91
ciBwbGF0Zm9ybS4NCj4gPiA+DQo+ID4gPiBUaGlzIERXQzNfR1NCVVNDRkcwIHJlZ2lzdGVyIGlz
IHBhcnQgb2YgdGhlIERXQzMvQ29yZSBzeXN0ZW0uIEluDQo+ID4gPiBnbHVlL3ZlbmRvciBkcml2
ZXJzLCBJIGNvdWxkbid0IGZpbmQgYSB3YXkgdG8gYWNjZXNzIHRoZSBEV0MzL0NvcmUNCj4gPiA+
IGFjY2VzcyByZWdpc3Rlci4gIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSBhIHN1Z2dlc3Rpb24g
Zm9yIHRoZSBYaWxpbnggZ2x1ZQ0KPiA+IGRyaXZlciAoZHdjMy9kd2MzLXhpbGlueC5jKSB0byBh
Y2Nlc3MgZHdjMyByZWdpc3RlcnM/DQo+ID4gDQo+ID4gV2UgbWF5IG5lZWQgdG8gcGFzcyB0aGUg
aGFyZHdhcmUgY29uZmlndXJhdGlvbiBmcm9tIHRoZSBkdCBiaW5kaW5nLg0KPiANCj4gRFdDM19H
U0JVU0NGRzAgcmVnaXN0ZXIgaXMgaW1wbGVtZW50YXRpb24gZGVmaW5lZCBhbmQgcGFydCBvZiBE
V0MzL0NvcmUgKERhdGFib29rIDIuOTApLiBCZWxvdyBpcyBleGFtcGxlIGNvZGUNCj4gdG8gbWFr
ZSB0aGlzIGxvZ2ljIHBsYXRmb3JtIHNwZWNpZmljLiBJdCBjb25kaXRpb25hbGx5IHZhbGlkYXRl
cyB0aGUgZG1hLWNvaGVyZW50IHByb3BlcnR5IGFuZCBvbmx5IHBlcmZvcm1zDQo+IERXQzNfR1NC
VVNDRkcwIGNvbmZpZ3VyYXRpb24gZm9yIEFNRC9YaWxpbnggcGxhdGZvcm0uIChEVCBjb21wYXRp
YmxlICJ4bG54LHp5bnFtcC1kd2MzIikuDQo+IA0KPiBFeGFtcGxlIENvZGU6DQo+ICAgICAgICBp
ZiAob2ZfZG1hX2lzX2NvaGVyZW50KGR3Yy0+ZGV2LT5vZl9ub2RlKSAmJiBvZl9kZXZpY2VfaXNf
Y29tcGF0aWJsZShkd2MtPmRldi0+cGFyZW50LT5vZl9ub2RlLCAieGxueCx6eW5xbXAtZHdjMyIp
KSB7DQo+ICAgICAgICAgICAgICAgIHUzMiByZWc7ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4g
ICAgICAgICAgICAgICAgcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1NCVVNDRkcw
KTsgICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAgIHJlZyB8PSBEV0MzX0dTQlVT
Q0ZHMF9EQVRSRFJFUUlORk8gfCAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgRFdDM19HU0JVU0NGRzBfREVTUkRSRVFJTkZPIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICANCj4gICAgICAgICAgICAgICAgICAgICAgIERXQzNfR1NCVVNDRkcwX0RB
VFdSUkVRSU5GTyB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ICAgICAgICAgICAgICAg
ICAgICAgICBEV0MzX0dTQlVTQ0ZHMF9ERVNXUlJFUUlORk87ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQo+ICAgICAgICAgICAgICAgIGR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HU0JV
U0NGRzAsIHJlZyk7ICAgICAgICAgICAgICAgICAgIA0KPiAgICAgICAgfQ0KDQpJIGp1c3QgcmVh
bGl6ZWQgSSBtaXNzZWQgdGhpcyBpbiB0aGUgaW5ib3ggYWZ0ZXIgeW91ciBsYXRlc3QgcGF0Y2gu
DQpTb3JyeSBmb3IgdGhlIGRlbGF5IHJlc3BvbnNlLg0KDQpTaW5jZSB0aGlzIGlzIHBsYXRmb3Jt
IHNwZWNpZmljLCBjYW4gd2UgZG8gdGhpcyBpbiB5b3VyIGdsdWUgZHJpdmVyPw0KU3BsaXQgYW5k
IHNoYXJlIHNvbWUgb2YgdGhlIGRlZmluZWQgcmVnaXN0ZXIgZGVmaW5pdGlvbnMgZnJvbSBjb3Jl
LmggdG8NCnJlZ3MuaC4gWW91IGNhbiB0ZW1wb3JhcmlseSBtZW1vcnkgbWFwIGFuZCB1cGRhdGUg
dGhpcyByZWdpc3RlciBpbiB5b3VyDQpYaWxpbnggZ2x1ZSBkcml2ZXIuIEl0cyB2YWx1ZSBzaG91
bGQgcmV0YWluIGFmdGVyIHNvZnQgcmVzZXQuDQoNClRoYW5rcywNClRoaW5o

