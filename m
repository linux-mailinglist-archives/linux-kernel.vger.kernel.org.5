Return-Path: <linux-kernel+bounces-28420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055082FE4B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92121F28BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 01:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64B21C05;
	Wed, 17 Jan 2024 01:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tR4pQ9tB";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BvdGAlFI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GmZkYK4i"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D614690;
	Wed, 17 Jan 2024 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705453898; cv=fail; b=r8EdAOs+CdOXzqLkbw1MuT0i55y+pBam3Fl+4bRf4TQaCM9GhLsatZVIBi1Wjp8ZCZCT9Em/CCwaUSBj1P4hmTV7jz0fv74CfgLi0T3I9lf70vl8csAIvGJxKfrxrp56lJ87pGVfJUVi64Gnf97/QN/TsTPr7yA8CF05Hhd8sJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705453898; c=relaxed/simple;
	bh=ZG69QjZYz9h1p4RUXK8cVtYR1FqkDM4FNISA7aaZfM0=;
	h=Received:DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:X-SNPS-Relay:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=Gq+6m8ywuQQU/P09OdLdAw4Pn58aEsA6d+Zi1LNfQIRVkRAi6dEPqG6lN+r3KGKWnNDFn01Gnb3pAzL6fFdVnfSt61LK1K3En3fntPHo7t5ALKkVUXEOIRyd1qr/D0eFXBsIYBG4wEw9M+enED2hFoKERaup8hUWqvvP6XH+zJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=tR4pQ9tB; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BvdGAlFI; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GmZkYK4i reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GJSVuR020732;
	Tue, 16 Jan 2024 17:11:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=ZG69QjZYz9h1p4RUXK8cVtYR1FqkDM4FNISA7aaZfM0=; b=
	tR4pQ9tB/ZYOhFAQhygEmGrRukjs11shbddZ3z5Qk4Nqai8tHYrQgFeARnLrxhst
	+XfKczNSgtZ/zxFheIXF8epCAm7fkKK28mpLKUzSw/P/sq34GpIWNies0YaidsoK
	Wmv0WZ2kbWGoeyCdaU7pT7yJ8YQm7Gl817s8bDWUQBvINs3nlLkcX2CzBKe9CInJ
	83Quyt62KtVWBu4CKNX4NX5Pd3MdoiuLrzme6/Q/6/mxHcjBGW+B8wtIOEUyclld
	yh03msYEkXWe/k3jegCctHAKaXf/pAeFhrUK8of5UZ39aJVYgGms+QzL+6QiFES6
	EU/lId0HECsJ8a54kXsMrw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktavfbbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705453889; bh=ZG69QjZYz9h1p4RUXK8cVtYR1FqkDM4FNISA7aaZfM0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BvdGAlFI8TTo8A475QMv4P4o7nUmP0wUoPZM1MvaKthbvaAFpp8BA/p6+toheUfjp
	 y31S5rda4oRx6iiFDvt9wovMPYZhkwaaud/L+4jKtHhEMDlQbsPpW4f0BfVK6zCQmA
	 VkbzT+8YXB7UWwA51yQL3Qvlp4yIJGZZw+PMbFbGEv5CPVkNSBXhnpu+kGKZjgJteK
	 Pvdt3e9cx+teeLczuGsv2/wZIBpN4liN9mNc32eu782+wQJmocM/j6NQP+lG1OmS94
	 od25tZXh1zKnQmhAljnpD2680UVyYKP8WaQMqzLulzrx09bEor8pZnO5nHUBs7eCwO
	 c8QR1wp7HAyvw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 08AFB40062;
	Wed, 17 Jan 2024 01:11:29 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B8CDFA0068;
	Wed, 17 Jan 2024 01:11:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GmZkYK4i;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 802154045F;
	Wed, 17 Jan 2024 01:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9WUNTZoZNk5yc4BVfasn2ViCPZRWmYdZMcP205xbY1faZHRROBiEI9QxMyBARpGrCbxKk4zqmSo5o48ZVtLjOYeu3+p4QVfykVzHRPT8APoT2mMov1xGUXLzQDlYJirbajr4+ZJAjnHBJ39p0+VxkVzpooe8AUH7muK/KiNiLwkQiXGfE+K2k7qVyc24MX6HoI+FKWkiNU4nXuMoy79ywfIn4GnKjqPFXslZJb1lxunXhn8GTzN5KrgcYQu2SRe50lZiX1Fn88tAhlp7ETLHY7egcLxeHWFqdIpaKhFiGphhlrjna7o2m8136HR9YkYN9DUe1JjiNqLdTQPeD0Vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG69QjZYz9h1p4RUXK8cVtYR1FqkDM4FNISA7aaZfM0=;
 b=cWIuXV+9lePMYyf8a+zhCMDYFdy3zk0wIk4wTxev1Z9RorCvmii8jPJ/IRSJmlI/uaWx24TgWXqLGTZGdaH5S3BL63yS7XhfyojQ2aWDSJMT+DDxnAB3dtwAVYa2Om9mH7mC7nGYPeFHEi9x71Z2fwFKJkgLij64Q8rVCYcdJ3CNJMkV1ZcC9Q/UFnTGfXaHbK8D3qi4IHmEL0r+uVVz4kfZTM1tlkbWPinwWpPYQKEPoZxMo1zTFcDOdxGzOa4HomJImbQwB1LA1Cv/bAJ3N9bp7JZ/DsT+YhhcvyRK54YvGaqo3XaVhxTjzWwN6ImtKkTFjBaTdKZ1HzgBC++qhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG69QjZYz9h1p4RUXK8cVtYR1FqkDM4FNISA7aaZfM0=;
 b=GmZkYK4iwESFRD91g1xNJ+lMEHUsjcri7Z6cMXAH5jydk0I7HIGnpzwHcPFOrzUaBqWA+hfK4MEeGm3nHv3UvsTV6QQpjUanw7+hbUR+flqBf0EXejnrGYy0ravBtLu8V+LfaZAkfl/SxQwn+XW5gFZsk9AWSQKZcAga8c80RnQ=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 01:11:24 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 01:11:23 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Manan Aurora <maurora@google.com>, Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com"
	<badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Topic: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Index: AQHaDV+hQYu1qIk1pk2bzrpJF26+HrB0OuyAgAhDWACAAVg3gIBf0uIA
Date: Wed, 17 Jan 2024 01:11:23 +0000
Message-ID: <20240117011110.6yubmp4ysd2fit2p@synopsys.com>
References: <20231102073840.1579540-1-maurora@google.com>
 <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
 <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
 <20231117015143.nzgqaes256lnz5ht@synopsys.com>
In-Reply-To: <20231117015143.nzgqaes256lnz5ht@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB5807:EE_
x-ms-office365-filtering-correlation-id: e9612dab-5dc6-4c7a-282a-08dc16f93908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 B/W/5vIXF9sMR4Oc/tYuVsBriIQB0rMzMGpNc467qioo1Gw7DXQo6qadeMzMr9CcMJlPype9QgphZPBcp4ZeDWGwo4VgM9NfTVvf8PUsIM584Vfn479PVWG3DaSVe2BFtUdqIfT58U3leSl6mr2FS28jfCUvgBlzXqI2Cixs+ZDjmEpRDpH2CKXHmhgL/0yeZwz3xCRqnARaIWE49ARTr19lORZT8kOxqZSNZDUxSoZ++YirYM+DbzIaHeNBFrc0PD+YJ/ixHeNHB+rhj0tYqV2MWjBg1ZNji9CZI/8OmyCqfPYrg5VE763vZFa03ZkprWjLhqs8+qSoxgnmsCqTSKzec5S03rzbe5AL/152whdHLRx5MmBj21NSOsDDWPu7hYDTbNSLaP4LmS3r5DdqlehEAntrq0TOKcFQNjMR/K1jk84qTy9P0B8WT8RChUMIa2j01UDzzCQiWb6HrNfer4jDCtc6StesTACgDvlGi1TEhjG5qVqf9jb9Ju7f2QrgIidmwwCoEmGiXsJb9lCJoFvIwYZJ3zM4iBIuc1WSzuHDIjdT9gda5hivMilYlrJvr65925wPT2erd04Dr2eqCNRazLDXklwx0YBufy2qtrrGJBU7qRs5G9SuJwAbBXWD
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39850400004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66899024)(6506007)(2616005)(53546011)(71200400001)(6512007)(26005)(1076003)(38100700002)(38070700009)(36756003)(86362001)(122000001)(4326008)(66556008)(41300700001)(76116006)(5660300002)(2906002)(83380400001)(478600001)(91956017)(66476007)(64756008)(8936002)(66446008)(6486002)(110136005)(66946007)(316002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Y0hwZjFra1V0YjV2czlmUVJMK0FYR3BnSnpNalphY012OEdvOFlwZUNpSzFP?=
 =?utf-8?B?RU1qcTBnb1F4UEx4U29vNGFNRWlVQTZtWnhwRE9yaHNjMGV2R2UxcVJ2ZllN?=
 =?utf-8?B?V3BFOWhYKzZDek42RWJORUV2TmlXY0svUTlsRENzWTF4ZlNxQ3RJT0NWUXpD?=
 =?utf-8?B?b2JhK1g4S2JXTEJqamh3RjA3bDNJOERqTENRTU1FT3VHaXpVZ0tqNXpNR1RU?=
 =?utf-8?B?NkVsb2tJMnZyZW9McXpJTmtsRHJqMkt0alBRMkRFRmhmWXJoVllTam1Qd0RM?=
 =?utf-8?B?b0Z0WGo1NXltS29iRzlqanNiaUcwUVk0ZEU1bkxwMTdZWG12OW1NYkJBcFlF?=
 =?utf-8?B?VXdYWWI2VE01U1FwU2YrY3RnbVFDZ2RBOWg2cTBEd21ZbS9QNExid05pNkxx?=
 =?utf-8?B?QjVZSTlHNnlhN2RXaHFmTEh6eFVhdDNPMnJWbTJBYW00ZEJMR3dxUG5ZdHo5?=
 =?utf-8?B?ZzVUVE41QytjdkZ2WnRveXF0SXRQTkN1bUVUUzVQKzBlak9aK3NLdWp4ZnhB?=
 =?utf-8?B?dHdFY1VMSklCQzEzY2xxOWVHUkVIYmpSRW5NVTIwZktqZFg4OWxjM05ySjVL?=
 =?utf-8?B?VS9NSzRzejlhQ1VsQUVrMkNwbGFiemFzSExVRTJ5UEY5a3dwYnJUR0hCNk1t?=
 =?utf-8?B?Q2pDYTdvYmtrQ2ZjZHVjWC9rKzUzYTBKVXZOSnRvVUpLOTNJbW9jdkI4Um9R?=
 =?utf-8?B?cDdSNElXQmpQM256K2VYVm8vTmkrZWNkaUs3WklNNUc1cWdaaUlrbElmNnNB?=
 =?utf-8?B?V2ZMT0hrdFhlbVZYV3Y5UkYrY09aK2hOYU1JWnp5Qmowb3ErZFQ2bUZTUER3?=
 =?utf-8?B?Zy9tOE9iYzZHRENocmJvVUMybDhUM0w2UmVuZTFrazBvdys1ZVpyM2YwUG5u?=
 =?utf-8?B?blZ6NmNvc0E4WENDN0hEOWwzNmlqU1FGTDFCZUdlcGg3M3dPdmZIOGdFaG10?=
 =?utf-8?B?dFhmeE9wWkYzQnltaC9oS1ZRNWUrWFV0Q3ROeHVkK2EvVkdNUWtYZmNGWWJM?=
 =?utf-8?B?aVNvemowcFQ3cW5RQ2NNOHlRQ2JTVE9ocC9pOGVBWW9zUmQrdEI0OFg2UEZi?=
 =?utf-8?B?ZU8zSVdaWnZENXU5enNKcTdoN1pHcmYrZisyUWgyZzJjR05Ua2RabWRLdEhY?=
 =?utf-8?B?Zjg4cTNrcGtmZk1ibzNiSk9JL2pManNKRE1yaWFmRTVZb2ZFUy9pYzhwNHI3?=
 =?utf-8?B?U1RkVUgyd3o4VVRWaXk3Z2JlNk5FVzAwRVlsVUQ0cHZGRkRPMjJWY3kzZGpB?=
 =?utf-8?B?bVNOMkZPL2F0YjE5T2k1ZzJhMFZXTkxZM1Zvb283TEltYmIwb3FwdW9aL3gy?=
 =?utf-8?B?TWF3WUFDaVdGQ1BhRXRRdkl1QU01YzBjcDYyTko2SjNnSnBOam5HUGNYeHo5?=
 =?utf-8?B?ZW5oeCt6UmRmUUFOVEVhZE5La2dRUGdVUEdOQmJKUTEvYTR2cFpRRVVnZ2Jw?=
 =?utf-8?B?aVIxZXIwdlhuSVY1V3NnZFVKNFAwZS93cTl3RE81NEh2Zmk4VnBaM05aL2RZ?=
 =?utf-8?B?Y0RqZUhqMmpCbXRyS2FNcy9OTGU3U0F5by9nS2QyRzBCZDhyZGpnVkFndC94?=
 =?utf-8?B?VEFqV3NzZHo1NDRhYkNjbXlMTjl5VDZhNy83bCtSK0JKbUFsQWdYRHVYakRR?=
 =?utf-8?B?ck56M1V2aHlESkJ4TTI0akt0Wm5MbU1UbUFLWTNYRVR4bE5KOURpZG9CTGRB?=
 =?utf-8?B?VU9rRVJBb0xmeGcvd3NoNnZ0QVFtTGxHaWhBWGs0Uzh0US9HN2x0ZjlLMDE1?=
 =?utf-8?B?YkVRWkZxb3lLbnhaM0FvcEl2bVJtckJDOEpGOXNDYlphQVZmejgrdG45Ny9Y?=
 =?utf-8?B?R25CWDlYUjFQZnN5N2l4NVgzWDJwQ2FKSytQQ25kUzN0WDY4TEpxT05yMUJC?=
 =?utf-8?B?RlNIR1d4WWV3a2RLMUtOTjBoUWR4b0VmWkhBbGlnV2wvWXNWTnkxeXcweFBK?=
 =?utf-8?B?a3lkUlM3TG9LQzBFa042OGorSFlDaXIvUVl2eDIvLzhqQXdnZDZuVFR2L25Z?=
 =?utf-8?B?bzZKNEp6MmNiY0J1TFBCaVpEOHc5ME5BVXNtMHVpRkFKaGRhMmRMTDJjRGdW?=
 =?utf-8?B?L1h5M1JINWhIUmFFdU00OXJueCtrejZXcVRQU21Sd0FHYVdtZnpHK1U0NVRY?=
 =?utf-8?Q?5VBXIRqhocq7rEKWTkeGz8TsH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27D551377F0B784B858C43B78670E6F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ezWBMtKfvO+Nx8fZuqLOtUhChxVhczUNGVn9iVEHMemRYBRnJbrAQ9j6bk+HEBvTra32ufsQt9vSATWFYEMrIxNHefSrLUEwyqlD0PZrH/HFzGN3mOyAt7XGYoMbcHb0AiXmYjfiWNkCPNZJSD6hzNJIZmxVgZTj52ix3kLsvM1dC17rQbei7Y35X5l4e7ihFahraKAN9aEnkAtiQomkakH+wdcOlZbCKAYYFMhI3W9EpXOe89i3nymRxRh/ibepomDoZfALIIOce7NjBFpxV8qtlpPJrPEl4byiRpgN7W+MrfdcpKMJDBGcIoqPs/BpESOME4bop/VOOMWV7xx3HRko+a8nRRvfv7uwPrRKULP5d0zt+teCE5UIiBLHYMM+nZS8DJY+d6rPZOQqGQcewvIxYO9vxZdp8ekj+dxa2IrM6ozmdAFW1+1f7ITbp2R9p9CLRoWqFvqkEWOvFiyipbw+AteqebwKUdbRCn2sYg5Mgvp0FcidBsEhGRwGt3Jz0tzf4AWZtllS/tgn4RW07Q5iW4kId4COHZnPiomztO6YjQn7mCHl8ybkd9Fo9k7DNsMYmCgWI1XL6TtVkQdXmRbX81O/x0y/s88fzNP5GskYsUDRh0XTyVz0lebl+m0zPNcQlKuYO7uAWF3i7xTZ5Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9612dab-5dc6-4c7a-282a-08dc16f93908
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 01:11:23.8962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3cudML7pQYUrtVVRXWD+O4KEAkT9a4xSkVGDvMU8eXt3IYzKxd0gtU9/O2YxsDjZLloMQWEIlmX+N5VscaLWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
X-Proofpoint-GUID: vJTFlBshv91jCriV5nexvR5CNUKGllOt
X-Proofpoint-ORIG-GUID: vJTFlBshv91jCriV5nexvR5CNUKGllOt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1011 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170005

SGkgR3JlZy9NYW5hbiwNCg0KT24gRnJpLCBOb3YgMTcsIDIwMjMsIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMTYsIDIwMjMsIE1hbmFuIEF1cm9yYSB3cm90ZToNCj4gPiBPbiBT
YXQsIE5vdiAxMSwgMjAyMyBhdCA0OjM54oCvQU0gVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5A
c3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIE5vdiAwMiwgMjAyMywg
TWFuYW4gQXVyb3JhIHdyb3RlOg0KPiA+ID4gPiBTdXBwb3J0IGNvbmZpZ3VyYXRpb24gYW5kIHVz
ZSBvZiBidWxrIGVuZHBvaW50cyBpbiB0aGUgc28tY2FsbGVkIEVCQw0KPiA+ID4gPiBtb2RlIGRl
c2NyaWJlZCBpbiB0aGUgREJDX3VzYjMxIGRhdGFib29rIChhcHBlbmRpeCBFKQ0KPiA+ID4gPg0K
PiA+ID4gPiBBZGRlZCBhIGJpdCBmaWZvX21vZGUgdG8gdXNiX2VwIHRvIGluZGljYXRlIHRvIHRo
ZSBVREMgZHJpdmVyIHRoYXQgYQ0KPiA+ID4gPiBzcGVjaWZpYyBlbmRwb2ludCBpcyB0byBvcGVy
YXRlIGluIHRoZSBFQkMgKG9yIGVxdWl2YWxlbnQpIG1vZGUgd2hlbg0KPiA+ID4gPiBlbmFibGVk
DQo+ID4gPg0KPiA+ID4gVGhpcyBzaG91bGQgYmUgdW5pcXVlIHRvIGR3YzMsIGFuZCBpdCdzIG9u
bHkgZm9yIGJ1bGsuIEkgZG9uJ3QgdGhpbmsNCj4gPiA+IHVzYl9lcCBvciB0aGUgdXNlciBvZiB1
c2JfZXAgc2hvdWxkIGtub3cgdGhpcy4NCj4gPiANCj4gPiBJbiBvdXIgdXNlIGNhc2Ugd2UgaGF2
ZSBhIGZ1bmN0aW9uIGRyaXZlciB0aGF0IGNvbmZpZ3VyZXMgYW4gYWxsb2NhdGVkIGJ1bGsNCj4g
PiBlbmRwb2ludCB0byBvcGVyYXRlIGFzIGFuIEVCQyBFUC4gU28gdGhlIGZ1bmN0aW9uIGRyaXZl
ciBhbHJlYWR5IGRlcGVuZHMgb24gdGhlDQo+ID4gZmVhdHVyZS4NCj4gDQo+IFRoaXMgc2hvdWxk
IGJlIGFic3RyYWN0ZWQgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVyLiBUaGUgZnVuY3Rpb24gZHJp
dmVyDQo+IHNob3VsZCBub3QgbmVlZCB0byBrbm93IGFib3V0IHRoaXMgZmVhdHVyZS4NCj4gDQo+
ID4gDQo+ID4gZHdjM19lcCBzZWVtcyBsaWtlIHRoZSBjb3JyZWN0IHBsYWNlIHRvIHB1dCB0aGlz
IGZpZWxkIGJ1dCBhIGZ1bmN0aW9uDQo+ID4gZHJpdmVyIHRoYXQgYWxsb2NhdGVzDQo+ID4gRVBz
IGFuZCBjb25maWd1cmVzIHRoZW0gZm9yIHRoaXMgdXNlIGNhc2Ugd291bGQgbmVlZCB0byBpbmNs
dWRlIGR3YzMgaGVhZGVycy4NCj4gPiBJZiBvdGhlciB2ZW5kb3JzIG9mZmVyIGFuIGVxdWl2YWxl
bnQgZmVhdHVyZSB0aGlzIGRlcGVuZGVuY3kgd291bGQNCj4gPiBiZWNvbWUgYW4gaXNzdWUuDQo+
ID4gDQo+ID4gRXhwb3J0aW5nIGEgc3ltYm9sIGZyb20gZHdjMyBpcyBhbiBlYXN5IG9wdGlvbiBi
dXQgZHdjMyBkb2Vzbid0DQo+ID4gY3VycmVudGx5IGV4cG9ydCBzeW1ib2xzDQo+ID4gaGVuY2Ug
SSB0cmllZCB0byBhdm9pZCB0aGF0DQo+ID4gDQo+ID4gPiBBbHNvIHNpbmNlIERXQzNfREVQQ0ZH
X0VCQ19IV09fTk9XQiBtdXN0IGJlIHNldCwgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3QNCj4gPiA+
IHdyaXRlIGJhY2sgdG8gdGhlIFRSQi4gRGlkIHlvdSBoYW5kbGUgaG93IHRoZSBkcml2ZXIgd291
bGQgdXBkYXRlIHRoZQ0KPiA+ID4gdXNiIHJlcXVlc3Qgb24gY29tcGxldGlvbj8gKGUuZy4gaG93
IG11Y2ggd2FzIHRyYW5zZmVycmVkKS4NCj4gPiANCj4gPiBJbiBvdXIgdXNlIGNhc2UsIHdlIGlu
dGVuZCB0byBoYXZlIGEgbGluayBUUkIgYW5kIGlzc3VlIGEgc3RhcnRYZmVyDQo+ID4gY29tbWFu
ZC4gQ29tcGxldGlvbg0KPiA+IGhhbmRsaW5nIGFuZCBjb250aW51aW5nIHRoZSB0cmFuc2ZlciB3
aWxsIGJlIG9mZmxvYWRlZCB0byBkZWRpY2F0ZWQNCj4gPiBGSUZPIGhhcmR3YXJlLg0KPiA+IEJ1
dCB3ZSBjYW4gZGVmaW5pdGVseSByZXdvcmsgdGhpcyB0byBkaXNhYmxlIG5vLXdyaXRlYmFjayBt
b2RlIGJ5DQo+ID4gZGVmYXVsdCBhbmQgYWxsb3cgdGhpcyB0bw0KPiA+IGJlIHNlcGFyYXRlbHkg
ZW5hYmxlZA0KPiA+IA0KPiANCj4gT2suDQo+IA0KDQpMb29rcyBsaWtlIHRoaXMgY2hhbmdlIHdh
cyBhcHBsaWVkIHRvIEdyZWcncyBicmFuY2guIFVubGVzcyBJJ20gbWlzc2luZw0Kc29tZXRoaW5n
LCBJIGRvbid0IHRoaW5rIG15IGNvbmNlcm5zIGFyZSBhZGRyZXNzZWQgeWV0LiBIZXJlIGFyZSB0
aGUNCnJlaXRlcmF0aW9uIG9mIHRoZSBjb25jZXJuczoNCg0KMSkgVGhlIGdhZGdldCBkcml2ZXIg
c2hvdWxkIG5vdCBuZWVkIHRvIGtub3cgdGhlIGR3YzMncyBGSUZPIG1vZGUuIEl0J3MNCnNwZWNp
ZmljIHRvIGR3YzMgY2FwYWJpbGl0eSBhbmQgc2hvdWxkIGJlIGhhbmRsZWQgaW4gZHdjMyBkcml2
ZXIgb25seS4NClVzdWFsbHkgdGhlc2UgcHJvcGVydGllcyBhcmUgc2VsZWN0ZWQgaW4gZGV2aWNl
IHRyZWUgYmluZGluZ3MgYW5kIG5vdA0Kc3BlY2lmaWVkIHRocm91Z2ggdGhlIGdhZGdldCBkcml2
ZXIgQVBJLg0KDQoyKSBUaGlzIHNwZWNpZmljIG1vZGUgIkVCQyIgZG9lc24ndCB3cml0ZSBiYWNr
IHRvIFRSQnMuIEl0J3Mgbm90IGNsZWFyDQpob3cgdGhpcyBpcyBoYW5kbGVkIHdoZW4gdXBkYXRp
bmcgdGhlIHJlcXVlc3QncyBzdGF0dXMuIEl0J3MgYWxzbyBvbmx5DQphcHBsaWNhYmxlIHRvIGJ1
bGsgZW5kcG9pbnQuIElmIGl0J3MgdG8gYmUgYXBwbGllZCB0byB0aGUgdXNiIGdhZGdldA0KQVBJ
LCBpdCdzIG5vdCBkb2N1bWVudGVkIGZ1bGx5Lg0KDQpUaGFua3MsDQpUaGluaA==

