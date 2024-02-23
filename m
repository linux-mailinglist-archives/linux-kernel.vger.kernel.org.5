Return-Path: <linux-kernel+bounces-79259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE76861FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B093B22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13982153BD5;
	Fri, 23 Feb 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IwY6eK0A";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NcwsRupE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nvkJSDS7"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168414DFC3;
	Fri, 23 Feb 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727142; cv=fail; b=CY07Nm6FD1kyVMIvtehWtSskmpn5uQ1Y+tkwvV8WZcH+N25herIby0a+gYvGfeAPgm8It74zH1Pravo7K9vgb0upMWW+x9wWz9yVz+XPQGYBVMJnUTI16nzDN8azQk6K1RlR66X8UQBCGH6jADMKyKgY6kARCi8yOKHZKOSfVig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727142; c=relaxed/simple;
	bh=Sbz/2cXrZbSTPwx8RvXVdqQxVFDZlpUQXSgRTz/WBrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eh9IVNlU3jYlGnsABAfUT3c5NYUN8vro+j46Mt8vmYOm4TF0+yFU3tJF6cLn5Ru3wm04pPw2tbJhFdB+M59DhkCoJGd2adaEgXJ0xrAmE/pEYZYH8Vhp1FQ8wgG6P20d9eggRDQKhE93fgd8WNYaV0SBbR5H9mRns+NUhl/epqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=IwY6eK0A; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=NcwsRupE; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nvkJSDS7 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NGjYh4028444;
	Fri, 23 Feb 2024 14:25:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Sbz/2cXrZbSTPwx8RvXVdqQxVFDZlpUQXSgRTz/WBrk=; b=
	IwY6eK0AvPsAk/Xi+uF4LTJ23QihG/dQVoBQi7m3LHjZlE1aDt2KgCos2XIjZGX/
	0325V5dS5U6YEz0+kCP3RWstLUzBz5XbJNng3V1f13x1TSv4utqOO/rgPD+Bp9mm
	8G3OJ6oM+667fvCtL460tjNOqbYxt89Zo/Sco2YemuZ9PuS9gGf+so0rczaVQuPZ
	ijknHX+oItKccnQOqQlYW8gNXlUAqH3MJSVEeowZ3WxhJfo9hgGCV52BZH4Cn1AW
	wwJ3m/LW9Myoim9j1RLDQ9nwdrTjN+4xaORlTvy1F9gEhiv//vMb37L4BxL7h6mu
	AL7adg1HSy2bSejpDd0SDw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wd2241254-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708727127; bh=Sbz/2cXrZbSTPwx8RvXVdqQxVFDZlpUQXSgRTz/WBrk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NcwsRupEDcM98lRE69xJXaxYPUH31CmJLABJDjc6Pfwv6tkAEjG2TOb7lrM7H4lw3
	 6uvDIp52MhlmMiQcOjVqcburA69CgoqD1EobCfGseJx82eVdejp6bmG+KimFvqI7r7
	 PBlEg9IwC+B2A4ASfOt4qhF9i0Pxb5jTZpQf0FUJj7Y2shoIMMEDhU/V8Z3iEXNwmR
	 SDv7qo4OKg4iwQ3mW9vPf640dbWtHvcri511uCiRrs9V5FMWJD/DOuHkPQZ+iNd5cj
	 Zm9+LeNE2s63ZLfnai4RqioaZtKpb7eegIf5lHZizB6jRy+triYsXyQV2qn+OvIuOR
	 LaYFN88XKu+Ow==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7A73540453;
	Fri, 23 Feb 2024 22:25:27 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 11F2AA008A;
	Fri, 23 Feb 2024 22:25:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nvkJSDS7;
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 891B240132;
	Fri, 23 Feb 2024 22:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhBmSzhhv6At8RglPg7L2DCnu6woyqEofxiazreLJ2XgD6nVxdQw3eREsa8gKGV/zig563KRbRsLyNEHI6+ttpA6zZS95c8hHv7reFIIjbJmdJ9jOauD4+DRo6OJyd0ky7m6K5U4KH58LImkR8P/ZDd6orZvS4EyF8qB/BjhnJFU9JcqRo5EGM89l9Er2ER9BWCzeRCY9/jtTJSM8+vXBmwIAshNpgtZCozfUs7bnnwWJhqZ+lPQMvkZkCZPHqhoipGDG8xUwhrl834VvnWegnzd9ibVitoBRFKhUGS/zLgYXzZBqWsOrWrNvGo1jev4xK0kbOGsqm2+OatC9glYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sbz/2cXrZbSTPwx8RvXVdqQxVFDZlpUQXSgRTz/WBrk=;
 b=aCScGZ1RhjioKYR8cUwx7+CKHFCr+3Yfz9y15MaY2uUiTqYoKEtvTvLfqtYZD05uHCwMsVDRXzWzjaB4lcl5bvv0rMq4PPMqn2+Qf/YTF3an1ptXpT/3aZXz9oCf+KTg63rBCcbLq20m8hSj05g7XwZrFMpuUSUXlJveuuIlC+tYpbSmOg3LBipFiQv+1T5NBeFUScty5ybd+81eJd0l4lqDB42Ty8i3XMg4uoDOxxAP4EK4MH9PrQEPpuPrT/x3xkprPpPsfLQX21hpHuK8HkgBqso3YyyVmT5Xy71FuZCrGsnzsMXtQHwZN+pcJcg8YkDmLGv24UsMw473+dECTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sbz/2cXrZbSTPwx8RvXVdqQxVFDZlpUQXSgRTz/WBrk=;
 b=nvkJSDS7qBej/U1YXdlqhbyTBsL3nviQG7IoSqYaF+w9AHdenxlt5EgPlSQxU9NDUC4YTkjb1Y5gDG2CBKeO3YVA4lXE0ei8XEBRG5d4syxVRFQdaQX9lR8r1HV2+JAQ2Z4eaXiPigc313omu3ADClArYr2QL60HXsGCF/6lFSs=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 22:25:20 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 22:25:20 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "afd@ti.com" <afd@ti.com>, "b-liu@ti.com" <b-liu@ti.com>,
        "srk@ti.com" <srk@ti.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] usb: dwc3-am62: module removal and errata fixes
Thread-Topic: [PATCH v3 0/5] usb: dwc3-am62: module removal and errata fixes
Thread-Index: AQHaXyr63orOBWnmSUqv7m0Qa+M7vLEX9wsAgACY+wA=
Date: Fri, 23 Feb 2024 22:25:20 +0000
Message-ID: <20240223222518.si6rznhhrbptpyjq@synopsys.com>
References: 
 <20240214-for-v6-9-am62-usb-errata-3-0-v3-0-147ec5eae18c@kernel.org>
 <48e63867-616e-4a37-ab17-a6977c600ec1@kernel.org>
In-Reply-To: <48e63867-616e-4a37-ab17-a6977c600ec1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB5733:EE_
x-ms-office365-filtering-correlation-id: 31f74ce4-2f94-4c8d-eeaf-08dc34be51d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 lautOsRXw4iMOJhv/PgJJvjsTPKbeHuIaiXwWY8hXx44UfkQ48KspNyTMkADLfhJK+CrPscdbcmJpUUDkHbYrjTLZIyxCDN6aHVgNReMLJyWjPQCITS6cqNggDXPKp9NxyLM7SCPbFpl3oUOeRu+sUYguE9XbuGmZIXUAWH+LvVYs5mT0u0Byzn2bj5mXTZNeE925n30mDXkgqCQvrlZDMhjDN47e/EqxO4+j2d/lUV/7s2Ig75Neiy/fvUJAjAvmO7ugH7u0bilC+6w9tv5MBKYMGiHt9DONLBS00ZPB62HWWi3H8TWMQ68fV0Z2zi+oWmPo4vxxIVr4OBrT8f8TuYcbVLx7B0mHpYizvLLn1eUNHJ2T2Aq3l2mGX2J8GeYoah8zn3wJT/O7TZ5lk5LKFUIa/6v6YhYLKnsph5rd1OsQPXY+yYdr5h4TBBw6isLk46iLUAavUH8a0ScearHkLKyJkOIZSThpwRJR3+RjrUu3TYI3jrm+pQBf9hsytiZ3tMZs+Fy9IACFHCQQ7mUvqFD9n/Ig19jMHUC9gPa/oLkEB7KCtJfP8OeQXSVrLGYnjZ/C56j97mDGk5gqprSi9H6gv9ULlMTml9crWxvlXA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R1ZLT05hakZWMFNSZ25zYU9ZOVVUQ2kzL085RU5hcjlIVDFiQlgvTlRxYU4x?=
 =?utf-8?B?M2RjWE5ja1ByMHJIMHhiZ0UwSFBGK0lnQlRWMzl0S25RR1pQN3UxOEM0SVFC?=
 =?utf-8?B?cWVwb0FjMVpqZ21XTnRFZkhPdmExVndHWCtVeEs4RUtTamxtejJuWWtzU25m?=
 =?utf-8?B?bzc3cDRYSFdtQWZGdTNyTnltb3ptQ2x2Smp6cEE3OWZRRVQ5d1hBMzlRejZX?=
 =?utf-8?B?dXhvaDI1ckxOMFBEaEE4Znk4Z1RJRE0yMk55Z0VybXFlTUE0N2hySmFFeVJ1?=
 =?utf-8?B?UzRvMW51L3ZLcERlWUNOOW5PdHo1bC8rOEEvQ2xIN09ZVi92YXoyd3lQRHFw?=
 =?utf-8?B?RG5SdmxNSDB4Qk9KMjlaamo4RVF2SWthZUtiN08rYVBUQlNrNEVDVk8vMUNq?=
 =?utf-8?B?cGROSWZrUWtXUVZUMWphNk8xbzhnK0VaUjlxbHJocUVQT3JMY2M1VWV3YmlV?=
 =?utf-8?B?MkVrYnJPRmcwMko0bFE2cjRrbGo4ZkwxUmszeXRGUG9weWRZUUphVW1nWEUr?=
 =?utf-8?B?dUsvWVBYSHRVeVVnbk5kbUNMNFhMMFIwejJ0RmlSQ0x3eC8wS0VmQm1DNlF6?=
 =?utf-8?B?dEVFSEkvaXhWMUhmWUJJSWVmYlRGWjZmYjdOZXU1NHhXdENPSHFpaEZBeGNJ?=
 =?utf-8?B?cldYcitHaERXUFlvU1FoaEh2Z1hGWm8vYTUvdmo4TVlGYU4xM1pkZ2FIUC91?=
 =?utf-8?B?ZGtxck00V1hFWGRuc3pITVpOb2J2RFk1TGtWellpWnR4eGhzcHQyQVlRRFFS?=
 =?utf-8?B?TFk4VGxWSUtjZHZkZk82VHVOdlAzTGhyakc3SlVtMlRmRnlIdGhPK3dtNmVo?=
 =?utf-8?B?Zy9QR2RwdEFuUzF3M3MvandKZmFKK0FqaXppeDU3SVdOcmZUZmV3RmI5VnBt?=
 =?utf-8?B?bHNJaTVWOXltYkh3M1I5NjlCN01wd1Q4NmVtOUNjWHdVRjJQeXRtNWl0Ykkz?=
 =?utf-8?B?RldjenYveDVLOFM4cVZObHdGU1ZyaVZCYVVjN21PeDRnWldsVW9PaUx2clFS?=
 =?utf-8?B?Znh3WDRoT1ZZZjFzZVZTUmZIL0pZYWJOUEt5eEltcXlzUFNWRHBxWTVCVFZZ?=
 =?utf-8?B?NHNyVmRwVmxEcDd6cHl1ajBjZlNHalNFZXR5S0g3ME1MMzJRRG83T3ZuQUsw?=
 =?utf-8?B?MG43Vm9DejlKNFhxS1VjOWk0N0J1RUozOTJnb0F4b2RLcDEzTy90Qnc2Mzlo?=
 =?utf-8?B?SFFONWlyS2dWVVZ4UzJXaUZKS052OUxIS3BWSCtIYitFWCtXcTFZcjV3VHBq?=
 =?utf-8?B?RFRnZ0xQbzRmSkRRMUtwR2M3Y2Uvdmk2SmNUeEpBVElTd29jQWNlMmVFVlBr?=
 =?utf-8?B?NjArWlhiS2crM09Sakh5QXl4c0ZPTnMxUkJydWpSUlNoWm1IMElFWXhkQXVo?=
 =?utf-8?B?UXAraHVJUDBjMWlpQTh3Z1ZkeExGZG1PbFZ4L0VKb1Q2cXdtamZGdXdYcGJ3?=
 =?utf-8?B?ZXRFWFVMREgvYUNRVXFEOTdxVkFmSlQzMGlNc1NNdWlpRlhaSzZ1ZG1VN2xO?=
 =?utf-8?B?K29XSkJMbDNIeXl1QVRhajZRYUlYdjdFQndrNkRtN2tCek8yMFRldUhGcXlh?=
 =?utf-8?B?Um5LTGMwSUpTdXd5MldlVXJjZU9iWm5sQmR5N2RRV2VpUWJkdnBGYXF6ZjlX?=
 =?utf-8?B?aE5nR3ZiVmtadHlydVpLVjBtNnUxVm9jeXVxNE1GcTJHODBBbU5RQ2ZBQVlJ?=
 =?utf-8?B?NTZoM2k0SFJrM0NaV1pWZVVYMkh6U2ZyNE5ZUTNVK2s1ZkZNRjk4bkpQVStQ?=
 =?utf-8?B?dFliOEo5UWU2OVFWTTI2RHNUV0F3Nyt6VUIyVG10Qk5MdHFsak5SYWNOdEVm?=
 =?utf-8?B?R0I3bmhnbTVGQ2NTbnlRU2F2Ny94WklWeFFSSFJaYlFpbUdvRktrSDRpNVg1?=
 =?utf-8?B?THRmaHVIcy9xVTZaMG52Zi9US0hkNm05WnBFVDh4d0lWTm8yc1UxdkFiSFJq?=
 =?utf-8?B?QkN2djlUSFJHR1FXeVQzY0RrOENLZnVweW1HYlpTSHFnSVN5Ymd2c0dhM2Fy?=
 =?utf-8?B?bllkQm5oNDJqZ1I3d1NUQjFaRnQ5RTRYUFp0T244YjQwbWRQSlpyWGQwcCtK?=
 =?utf-8?B?UEJEL2RqK1VZcldFTDVJSzB3ODh6MGtRL1JVVnJpbm9xam9ma09OZUpjcUJw?=
 =?utf-8?Q?9UWXc8a4yfYZ5LiDTOjH5GeKS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1700C8AF39B0A49A95E6CFDE2C5AC46@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ueJ1cd+2Q1LVD6oEkGcwPb6fesOoSMqFdorBoKFrwaOM0IXcsKBzKk8oBjlxoSboB91tDjKpaJ9Jt9zbvkVHmGgxYebTI7Ji9yGGTmnbl5QukbUP4FCcCxC7rD6STU5LS9wB9UQDEWreFrpDOYdZWhPJTtNUxa7TlgIhhvLI0uWi/jx1wbTeW4BHRTqPN+gIOGVHxc9Siv//ZseBD7UQIQ7pl0EfLqbnJCMECXQEhWdTyr4Z6W8MkgnAq0tCq3JDXaJkUgTDwI4mpITafDRpr6oep+4vmEJgAcpoGACSsqxBCqal2COJQ4uiATkBSBOkE/VXbmF75L73UIGGZ5bDbrRwKJIvkMneljuRHp5msCLsDb5xLGnqc9bxwRip71rpv5gFONbtqBZzJRGMNUhQG4NaeaPe3sF13pXpQgzE1JEKAyVMGgLl1nspCiM2cVhrF59cs4n7wsczalZHCZk18C41ohIGoDT7biOTMxGtx8wNFePKjt8/McXnnzduLMJf2copsxLZZO28KIherJD/5cPNC+hcwSDKNaO1lAChoi6/LzpJ5HCoI9RKCpIA6QG7JapV7MF9vHiOP1G+s+O3FR1W6JBgLi9bOWUA+mIMnlkOLB69OK9MFYk3wGdZyQaxrDKR1ikyRXN3p/5XRtiwtw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f74ce4-2f94-4c8d-eeaf-08dc34be51d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 22:25:20.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJpPesCBGirsVXAotoWqV0rGLenXKZqzDu1yDDu782mOZ68jXtn+m3EfoWIPnjgfyVLFhTNRH15bMCH5rf8fzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Proofpoint-GUID: RnLtPydhpYanXi3TCKpKx3OtNhtCHiu4
X-Proofpoint-ORIG-GUID: RnLtPydhpYanXi3TCKpKx3OtNhtCHiu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 mlxlogscore=966 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230160

T24gRnJpLCBGZWIgMjMsIDIwMjQsIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhpIFRoaW5oLA0K
PiANCj4gT24gMTQvMDIvMjAyNCAxMTo0NiwgUm9nZXIgUXVhZHJvcyB3cm90ZToNCj4gPiBIaSwN
Cj4gPiANCj4gPiBUaGlzIHNlcmllcyBmaXhlcyBlcnJvcnMgZHVyaW5nIG1vZHVsZSByZW1vdmFs
LiBJdCBhbHNvDQo+ID4gaW1wbGVtZW50cyBQSFkgY29yZSB2b2x0YWdlIHNlbGVjdGlvbiBhcyBw
ZXIgVEkgcmVjb21tZW5kYXRpb24NCj4gPiBhbmQgd29ya2Fyb3VuZCBmb3IgRXJyYXRhIGkyNDA5
IFsxXS4NCj4gPiANCj4gPiBUaGUgd29ya2Fyb3VuZCBuZWVkcyBQSFkyIHJlZ2lvbiB0byBiZSBw
cmVzZW50IGluIGRldmljZSBub2RlLg0KPiA+IFRoZSBkZXZpY2UgdHJlZSBwYXRjaCB3aWxsIGJl
IHNlbnQgbGF0ZXIgYWZ0ZXIgdGhlIERUIGJpbmRpbmcgZG9jDQo+ID4gaXMgbWVyZ2VkLg0KPiA+
IA0KPiA+IFsxXSAtIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3d3dy50aS5j
b20vbGl0L2VyL3Nwcno0ODdkL3Nwcno0ODdkLnBkZl9fOyEhQTRGMlI5R19wZyFaQlhINE9lYkIy
c0ZHczRZMDRYNmUzVXlyM0FLY3Bwc1hDTFk5WEcyRVQzUkZSZ1NfaS14cTdKd3BzLXVGLTc0Z1BP
b2xmWm85Z3RaNFRqRENUcDUkIA0KPiA+IA0KPiA+IENoYW5nZWxvZyBpbiBlYWNoIGZpbGUNCj4g
PiANCj4gPiB2MjogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI0MDIwNTE0MTIyMS41NjA3Ni0xLXJvZ2VycUBrZXJuZWwub3JnL19fOyEh
QTRGMlI5R19wZyFaQlhINE9lYkIyc0ZHczRZMDRYNmUzVXlyM0FLY3Bwc1hDTFk5WEcyRVQzUkZS
Z1NfaS14cTdKd3BzLXVGLTc0Z1BPb2xmWm85Z3RaNGQtY1NlaFAkIA0KPiA+IHYxOiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjAx
MTIxMjIwLjU1MjMtMS1yb2dlcnFAa2VybmVsLm9yZy9fXzshIUE0RjJSOUdfcGchWkJYSDRPZWJC
MnNGR3M0WTA0WDZlM1V5cjNBS2NwcHNYQ0xZOVhHMkVUM1JGUmdTX2kteHE3Sndwcy11Ri03NGdQ
T29sZlpvOWd0WjRZbllCVE1nJCANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFk
cm9zIDxyb2dlcnFAa2VybmVsLm9yZz4NCj4gPiAtLS0NCj4gPiBSb2dlciBRdWFkcm9zICg1KToN
Cj4gPiAgICAgICB1c2I6IGR3YzMtYW02MjogY2FsbCBvZl9wbGF0Zm9ybV9kZXBvcHVsYXRlIGlu
IC5yZW1vdmUoKQ0KPiA+ICAgICAgIHVzYjogZHdjMy1hbTYyOiBmaXggZXJyb3Igb24gbW9kdWxl
IHJlbW92YWwNCj4gPiAgICAgICB1c2I6IGR3YzMtYW02MjogRml4IFBIWSBjb3JlIHZvbHRhZ2Ug
c2VsZWN0aW9uDQo+ID4gICAgICAgZHQtYmluZGluZ3M6IHVzYi90aSxhbTYyLXVzYi55YW1sOiBB
ZGQgUEhZMiByZWdpc3RlciBzcGFjZQ0KPiA+ICAgICAgIHVzYjogZHdjMy1hbTYyOiBhZGQgd29y
a2Fyb3VuZCBmb3IgRXJyYXRhIGkyNDA5DQo+IA0KPiBBbnkgZmVlZGJhY2sgb24gdGhpcyBzZXJp
ZXM/IFRoYW5rcyENCj4gDQoNClRoZXkgbG9vayBnb29kIHRvIG1lLg0KDQpCUiwNClRoaW5o

