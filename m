Return-Path: <linux-kernel+bounces-28452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCD82FEAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CBD2B26731
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E267C70;
	Wed, 17 Jan 2024 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="uF54xBf/";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Yk9spFRl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nQFNqpfI"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0815CC;
	Wed, 17 Jan 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456783; cv=fail; b=HDTU791kOYGaFU4ITV/PZO2SBJAMiF9XnVDM9y3LPwpOeWCnChufe1MhQApsx+/vRaJlq6+j3G5nUEd2JHa8M4p8Bq1KQQegY44Za7R8/1UVQWMTNimD0WTtJe0QcxMJuZ5Z00e0Z1jKTfNiZ1eAbNmXb5b/0eHQFHXX5GEGMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456783; c=relaxed/simple;
	bh=o/SubxtbfzeUOMpR/1FHEzTAs00Ccu5cszyw9eIgZH4=;
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=EWbhK8msfDU2CHU8VClF8Q4blYLuTBWcxtYGo+my5ALFnVJ4tW4lA9Ld1GDXoXs8LVOM/cPdp5hi0u7iLffNj4EC6xo/TBX59wMig5DnAzYrd1/4lUuTimAbhE0m1sW8lgpU2XjQZMC5W/NWAhXcyI8f6nTZg96sKYBNGu63Vso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=uF54xBf/; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Yk9spFRl; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nQFNqpfI reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GJSLa7013982;
	Tue, 16 Jan 2024 17:59:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=o/SubxtbfzeUOMpR/1FHEzTAs00Ccu5cszyw9eIgZH4=; b=
	uF54xBf/NXgzoIXOV5kAdmrFX8oTbjJ9YAvG9x7v7uyMFVSc1+yMTwTPDyKxPyEt
	T6zrfaKqtsX8cOSUxcKVPGWYZFLkyiWFomxfeoXZ8bAtFnuXbMq20PTgZHEDO1IQ
	Gfb7+/eEHJ8MgTHod1n96vzw9a5JlGnUeUWKmkgvt8q6UDi/LKiZxcZo4ySYxFID
	KzBCIEd4tKMTivdRRsvu9tofHwzDFlC4elJEDJyzFRYeR0HTEDuYxxi6kbYVkKEw
	+IbyZbBKrZz9eGOymi7Drr+I0QOkuqG63GPsvrrcSZgJOOMm7JL5877XTRuhdtHK
	mANCIQSlTT2zpJ5DUnk97Q==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktdnfa01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705456772; bh=o/SubxtbfzeUOMpR/1FHEzTAs00Ccu5cszyw9eIgZH4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Yk9spFRlmjkmqvuE90Z1xF84zBXku+VD/xIn1olHZJTHu73qlMQ6zfj+q7wCSaCqY
	 Ppjqjn2KAWRvpfI7V2d7f8eVHle9gSMmcucgGRSGRV8CMB9BHS8RSaVqgAg1mCe9ha
	 Dr/aurbJSH1P9SOGPJt1vU9JQIv+EzT7S13I6naOTHAtY/83Jf756EUppMkcItijlP
	 z/6GO/FjYqi3yXJzi7WCyCvoQQy8lovQZWCtOKEqL67h16TDjUJ1f/YUThxdDrspJD
	 frV91kyuvBXo5Zw8/oxkiGDtd7WDpNN+upgSIuwbDFpHmog0U1M+c1yizCMN0+hOIw
	 Op2TiCT5V/T1w==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D1D6140524;
	Wed, 17 Jan 2024 01:59:31 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8AEA0A008C;
	Wed, 17 Jan 2024 01:59:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=nQFNqpfI;
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id F2EE540408;
	Wed, 17 Jan 2024 01:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/LwEdnhZaIrc34abhnWcRtyUbSGxC3L3hH1bHCu6ywudVp1pk7Wp12w8pDnqZs+/09+bv0nsrsMpaYvtz5fUMr4hCcEhpSrqTgcXDQNDXmZbryxP114OWW0sNo+lkkGeRL2BTVb+fEVzYiZ05/LKPc6Hb3XaIuq+LtMzWTb4a5yDSSqdEyq+PyXSzZOJ7KEB8dRo0Ehb1cZMOx+MfOXhsqhHQFk1ZFaVqdtuMiLbe2rScoxRTQ+4o/pDyPaO+pUA8kpBThRBaYGjfeufcJd8w6MqKVydwFSu+jrFE5/WV0MTpgD2DQcNnDRYvoJon4D/Ea68aO/5oWA/ln1SzMgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/SubxtbfzeUOMpR/1FHEzTAs00Ccu5cszyw9eIgZH4=;
 b=WVR0uBNfEWy5waKubAFL7E5ZYBVVBU5DOX0BBAaOiEI5htsw5ZXU88/bdL7tr5SMA9j7wralRJHiiWRYqoNofkbWRmCF6SwrqR8HQ8W0F1tZ/LY9cQtHugmWd2hNoSs+cihbdsyMn7haAF4GsjvT06ewU2ZAn8MMFkmP3D0gDpjpoDB3L2uRCva8Axd2LS2wNioa64IYXYXQw7WUpQnoEezYO9z/i5V7PpiFacUVcjpIESlmSWflfBvDUC8AZKGM5GaxerqhOGpFH6eqDIJU11oqlZaQp7Qz4dIvi6vvB+C3l4WdipEECacaxPe2CfzltD4r69qzHXYDtgnwviStXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/SubxtbfzeUOMpR/1FHEzTAs00Ccu5cszyw9eIgZH4=;
 b=nQFNqpfIpoqRYlyj4lIf5Dlx236YvNGUHmqVXdYK23XytlZOnsG0f+zuoG62qRdPgNaCMGrScbUHTnYacG/p/6w3SFOlRFx9wy4IdIzClGkSIVwio2TBzNxTD/Azs0+86eqJZz55x+4BWns5P/MbBS+BZer0e+OH3fWS4BQWKw0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 01:59:27 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 01:59:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Manan Aurora <maurora@google.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manugautam@google.com" <manugautam@google.com>,
        "badhri@google.com" <badhri@google.com>
Subject: Re: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Topic: [PATCH] usb: dwc3: Support EBC feature of DWC_usb31
Thread-Index: 
 AQHaDV+hQYu1qIk1pk2bzrpJF26+HrB0OuyAgAhDWACAAVg3gIBf0uIAgAAGNACAAAdDAA==
Date: Wed, 17 Jan 2024 01:59:27 +0000
Message-ID: <20240117015922.5lnqd7tj35j3nm3e@synopsys.com>
References: <20231102073840.1579540-1-maurora@google.com>
 <20231110230837.b5q5dsvsqlxfz5xu@synopsys.com>
 <CAJnM4-wew9b=Ge8QHLRiReNJAqgA0ngOW8WTVk4frta+y+9jYw@mail.gmail.com>
 <20231117015143.nzgqaes256lnz5ht@synopsys.com>
 <20240117011110.6yubmp4ysd2fit2p@synopsys.com>
 <CAJnM4-wqHmvTtkSYbLXfNByPZL4zv-ATwkywK4g7DsAhMtBSZQ@mail.gmail.com>
In-Reply-To: 
 <CAJnM4-wqHmvTtkSYbLXfNByPZL4zv-ATwkywK4g7DsAhMtBSZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN2PR12MB4456:EE_
x-ms-office365-filtering-correlation-id: 2d51b228-8e16-44a8-a87b-08dc16fff002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 STzBH2jnVTRtIzxHbNKkKYaSo6LSG7QfWINncDi6T9M5o1TjeZPYCeMwuQuJUjdPqNyRxRRlYiBjlQSgg+oxQpaMLVrc7ictexz4pLhf381d9lSrsHOXv3agw6rgR4zUntvYIx4IrNuWgIuIaMObbYLu3veBNuN/v5AhnUtK5TMEYhh6jaz/F05I7qoQhz/amTllqD9rzIZmbeBsbhYc06uXJxUwEcrIm1Acov86Ey1yA2NhcijJppW5+5Zw2D+r7kPEr2A6EDR3TVrdn3vpaZagh9j6o+Mrk/eZU7hX/YAJ2BL3HeKRqTJKubcAPDacJ2P1fk/CJTfUBlg5G8h0rYjRsLyHRm6cIKQkiFk2xd9cHHxQ4D/YUDIGEs3e/+9stvMn6zYH2TdLQHUILzPuLFem0ZthMhY9iWVdjC5BRFdks6VUhkGaN2E3fjNIIg+gxxy8pfmNndjwrbTcNnD4m8t6z4XIxIanlKRJscaVdb3al/B6yoFNp1DciE4mXo/l8SXVUAvvjwMZpAkfeIQnvz8cZYZ49RSEugZwFRm4eDVcj7Y9c/7IRMNvq14u+Kl5A30oqPmXUPmyjQl98MVd0j1qrRGrYMbOqNZZmfEOVEHSEC06vwtxm1E52B5qgJCKrs3NECTZ17hWRev3ukH+AGlsfe+6kjtSkOoV6X1CgBE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2906002)(4326008)(8676002)(8936002)(91956017)(66946007)(316002)(76116006)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(478600001)(2616005)(6506007)(6486002)(71200400001)(6512007)(1076003)(53546011)(83380400001)(26005)(66899024)(41300700001)(38070700009)(122000001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Ymp3b3lWc0xEWmJMVkQycTJQU3k1eHJQK0wwZ21kVTBxZi9HMEdBVEF4Z2NS?=
 =?utf-8?B?T1dzcHp2cFd2cE5JaERJWDNKQVo4Mjl5Mmw5aEJYMXRZemhkakRieWl5YzNB?=
 =?utf-8?B?S0J2VklwbU1NS1N0YnFXN01uUElmY0dzeitPUWNKT1JGdVRwVlprcnBRcExt?=
 =?utf-8?B?RWhQTU90WTdhS1F4dTNIUFJ1VWRKa2lTOEJVK1hCbDl2OHZuK0VJRWkxTXpk?=
 =?utf-8?B?WFhOR1c5RzllaVBBVW0rdzlwNHdvUnJLbWhXd3hMVkIxSDJXaW9lVzhNc24z?=
 =?utf-8?B?KzdRZ0xyeW1xWnlKNjdDbTBmb29GdEtqRkpxdFg2K3FHdmRaeXYvcGNCb3M1?=
 =?utf-8?B?dERMdiswWW1FU3E1eCtUTTJmUXo1MTJjTEZCaSs5SjhTMjRFWEpnbkJ3L082?=
 =?utf-8?B?dXE0S1d1aTVQRFlabHZVOTdJUEx5MThodGZTaEZaYVN1bmRkYS9YWTBRMHVr?=
 =?utf-8?B?VmZLaUxOc3VDTTg3d0MwTzgzcUJQZnIzcUtQeHVJMHNQUDZxVzRSZVlwdURq?=
 =?utf-8?B?VVlFZlFCZHc5Y0s1ZzZPNFN0UEZtSTlWc1F5bWxlRGQwak5Da3JPN2Ztelo5?=
 =?utf-8?B?UjNacmRWVWdjS0lwcHRlR0NUamtBRGlrQ3lFRjVjbCtoNkNtLzFUNEErK293?=
 =?utf-8?B?SDQ4cXJzSE02SkI4TVl1emx5SUVvakRQd3lwUTNmQnlhZDRGSjV0akJFbDho?=
 =?utf-8?B?cW01Tk9FQXkzL1IwdmZOVFFPVWVtMklVa2Jjd2pIS2NkTHBLYnFpZTNPb0dO?=
 =?utf-8?B?L3h4TS9BQzBBSU9mL0hVZklvdFlXYUtqME5qajlCNUJucFBOYWhwSE1wcFFI?=
 =?utf-8?B?bndRQVFNeFJGYzlVRnJRNUxoS0IrakFObVZrQmVaRTloT3dEU3U2aGVwNnF5?=
 =?utf-8?B?MDZKNzE0ZjRrRHU1cHBSVlNCZkhNU2R0MWlYWEF0aFJmL1JnTW1maWt2L0hY?=
 =?utf-8?B?RERNQnRRTGZrMUFQNzh5d0NLMUJrb2IxMG9CUVJkZ1AxdG05SzhaTDlDcHNy?=
 =?utf-8?B?THUvV241cVV5M2FHZ3BEUDQ5c2pqMjN2VnBTWUI0dDdieTl2TVF4S0tKcDIw?=
 =?utf-8?B?L3krS1kzbWxuTmg1aXplRERucnc1YTcvTjE4WHovV1Y1WlNndTNFZzkzalBq?=
 =?utf-8?B?dGF4a3ZsaVlYQ0pwb2JyeStzaVUzQ1ZlV2pOMGhtWVZGS2RtOHNkaHlJS0cr?=
 =?utf-8?B?cktxRzBkT3RZbW1ZMVpvNnN4WWE0blpXSHM3bXRrc05kc01LQ0M4dUxPdTM1?=
 =?utf-8?B?U1Z3TVJ1WElnb0YxV3VCMGtPVDdrTTJPcEtmamd1ZzM4c1RLYzhrL2ErZWF4?=
 =?utf-8?B?ekU3Unp2a1ZVekxmdG0rOGlBNjZmY1hNYnNiK3J3NTB1eXVmdEprZ1NEc3dF?=
 =?utf-8?B?RmdjTjF2V0pnK3NDTXBlaXlqTWR3VFk2eWdjNkdjZWd5dVBBblhKRng2cGI3?=
 =?utf-8?B?Rkl3RUhlck1rQTZUQ0h1L09nbXpCdmxyTFExajdnbWdDcVJMTmVmYSsvSlFu?=
 =?utf-8?B?Y2dydXNDbzViL3ZtUlVreE9Pbnh2cVhHU3Nac29RekJnaVJSeDgrUzlDU29W?=
 =?utf-8?B?Uk4rSDFlQ0g4WThCNXJtK3o5MWZuei9uZENkNGlmRytiUGJUWW5BRzF1TEcr?=
 =?utf-8?B?Y2VSdUUrb21uVnZtVVlZd0tDaUpTVXR3dFpDR2kycVNTcmlsOWh6S25yaXNm?=
 =?utf-8?B?MzRnK1hvMlArZzUxUjFTK0JSQllDVG1QN05uR0VzNXI0YkFvQ09UbGhFdEFR?=
 =?utf-8?B?OWxOME9weGwrdlZtdFhPd0hoWGtJbk5uQTdURTNWbGVnWGdWR1E3RnVjY1Z6?=
 =?utf-8?B?TGRNajdWKzZRYTZON25RUWZ0M0hHdFF0dUZjcWlqVElMcnM5MkdrRHNmZENz?=
 =?utf-8?B?STJFSkI2WXZGbTJaVzRkL1Y2WHhUTzdMbllNUTdMRXlyWjFEN1oxZC85eVNa?=
 =?utf-8?B?aW1HdzRSRnMvVE8xbWtNeVd1WFlRT1VVOW4vMEpiWmg3RkNKWjAyZ1k2cmMy?=
 =?utf-8?B?d0F2aUd4MFN0ZGdidU5IR2pneXh2OGdMT0pQNDZCbWhxTTJOMVc2U2Y5dFBo?=
 =?utf-8?B?dmVlS2t6bUhIQnVzR3RnY2U3TTllTTBFUjlEbTJuSHIyNVpkZzFCUTB1VEx0?=
 =?utf-8?Q?Foph1Pnb20Le0y024TsrGa1K9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59D1B5B7C9CD2E4DA1C06CB9AD90BD92@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W+slbbgGaxWwVBi1SwBkomZ/niNfskSr0hiLouSET2/QHm2icjucPbvtpXmVXF9GuCBNK2gDfR84XS0eqUU73MQl89fYeZY/mVEPfkw1KeQfnkAaqrehkhD4Uj6+xygYyCX6yEdi48+IeSGZa5dkty57ZYiJF7o8VzZ07kiUvYEv7aK/abiGefhOoIhMitDT44wxnz2U7nLbqF97ALRpR1GSPcfT6d5ElB21H1MUnMOi6DdQE3Nwp++w8MZkDIj000O2sf3hY6JbNMVHpE0gYIFLeBP5wfAYi6FsPM6UkU8CWBsN/JyaZQ64rxwAWpVZ/BuA4hDBU9jtRPyuW5GHOOBlsw+fuAkqfDkcSpHfeQSYG7h5tT+MsrtOc0PoSXDLLOOjtSIBM7hGg5XB/nFz9xLU84VIHCsu4NtTuwIpKpkUUNmV2bx3Cc6FOKIcn0f3VF3hyHirqDufwRqqIg7nz9xZ8mmM83W2cR+sBDcqRA9Si+CjahJCaIP+boASafEK0iZPKYhw5zwqC2THFc7CxJOOunkVRev/jVemPo3VRK+37MOOidmdrvSP+lgej0/R1K36Y1XsZhfMO/7QzGsDDMs8NMmCrvIT04hT1Pk2A8fQi6wArRTKQuS51T1a+BaXMH70qoRip20NUjACCutxcA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d51b228-8e16-44a8-a87b-08dc16fff002
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 01:59:27.8316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nK8fbW/jFSz02trKduZv7LYTvo2jugwXB6MwgT+CUCoCCaLs/cKd2uBtj9AfjWE+Y+sZzVBsSWT3EgpIcPW8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
X-Proofpoint-GUID: 8AeYEvXITHs3uYcUXm7zbgJh9YpKtG5D
X-Proofpoint-ORIG-GUID: 8AeYEvXITHs3uYcUXm7zbgJh9YpKtG5D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170011

SGkgTWFuYW4sDQoNCk9uIFdlZCwgSmFuIDE3LCAyMDI0LCBNYW5hbiBBdXJvcmEgd3JvdGU6DQo+
IEhpIFRoaW5oLA0KPiANCj4gSSdtIGZpbmUgd2l0aCByZXZlcnRpbmcgdGhlIGNoYW5nZSB1bnRp
bCBpdCBtYXRjaGVzIHdoYXQgdGhlIGludGVuZGVkDQo+IHVzZSBjYXNlIGlzLiBJJ3ZlIGFkZGVk
IHNvbWUgbm90ZXM6DQo+IA0KPiBPbiBXZWQsIEphbiAxNywgMjAyNCBhdCA2OjQx4oCvQU0gVGhp
bmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhp
IEdyZWcvTWFuYW4sDQo+ID4NCj4gPiBPbiBGcmksIE5vdiAxNywgMjAyMywgVGhpbmggTmd1eWVu
IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMTYsIDIwMjMsIE1hbmFuIEF1cm9yYSB3cm90ZToN
Cj4gPiA+ID4gT24gU2F0LCBOb3YgMTEsIDIwMjMgYXQgNDozOeKAr0FNIFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBP
biBUaHUsIE5vdiAwMiwgMjAyMywgTWFuYW4gQXVyb3JhIHdyb3RlOg0KPiA+ID4gPiA+ID4gU3Vw
cG9ydCBjb25maWd1cmF0aW9uIGFuZCB1c2Ugb2YgYnVsayBlbmRwb2ludHMgaW4gdGhlIHNvLWNh
bGxlZCBFQkMNCj4gPiA+ID4gPiA+IG1vZGUgZGVzY3JpYmVkIGluIHRoZSBEQkNfdXNiMzEgZGF0
YWJvb2sgKGFwcGVuZGl4IEUpDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gQWRkZWQgYSBiaXQg
Zmlmb19tb2RlIHRvIHVzYl9lcCB0byBpbmRpY2F0ZSB0byB0aGUgVURDIGRyaXZlciB0aGF0IGEN
Cj4gPiA+ID4gPiA+IHNwZWNpZmljIGVuZHBvaW50IGlzIHRvIG9wZXJhdGUgaW4gdGhlIEVCQyAo
b3IgZXF1aXZhbGVudCkgbW9kZSB3aGVuDQo+ID4gPiA+ID4gPiBlbmFibGVkDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBUaGlzIHNob3VsZCBiZSB1bmlxdWUgdG8gZHdjMywgYW5kIGl0J3Mgb25seSBm
b3IgYnVsay4gSSBkb24ndCB0aGluaw0KPiA+ID4gPiA+IHVzYl9lcCBvciB0aGUgdXNlciBvZiB1
c2JfZXAgc2hvdWxkIGtub3cgdGhpcy4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gb3VyIHVzZSBjYXNl
IHdlIGhhdmUgYSBmdW5jdGlvbiBkcml2ZXIgdGhhdCBjb25maWd1cmVzIGFuIGFsbG9jYXRlZCBi
dWxrDQo+ID4gPiA+IGVuZHBvaW50IHRvIG9wZXJhdGUgYXMgYW4gRUJDIEVQLiBTbyB0aGUgZnVu
Y3Rpb24gZHJpdmVyIGFscmVhZHkgZGVwZW5kcyBvbiB0aGUNCj4gPiA+ID4gZmVhdHVyZS4NCj4g
PiA+DQo+ID4gPiBUaGlzIHNob3VsZCBiZSBhYnN0cmFjdGVkIGZyb20gdGhlIGZ1bmN0aW9uIGRy
aXZlci4gVGhlIGZ1bmN0aW9uIGRyaXZlcg0KPiA+ID4gc2hvdWxkIG5vdCBuZWVkIHRvIGtub3cg
YWJvdXQgdGhpcyBmZWF0dXJlLg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gZHdjM19lcCBzZWVt
cyBsaWtlIHRoZSBjb3JyZWN0IHBsYWNlIHRvIHB1dCB0aGlzIGZpZWxkIGJ1dCBhIGZ1bmN0aW9u
DQo+ID4gPiA+IGRyaXZlciB0aGF0IGFsbG9jYXRlcw0KPiA+ID4gPiBFUHMgYW5kIGNvbmZpZ3Vy
ZXMgdGhlbSBmb3IgdGhpcyB1c2UgY2FzZSB3b3VsZCBuZWVkIHRvIGluY2x1ZGUgZHdjMyBoZWFk
ZXJzLg0KPiA+ID4gPiBJZiBvdGhlciB2ZW5kb3JzIG9mZmVyIGFuIGVxdWl2YWxlbnQgZmVhdHVy
ZSB0aGlzIGRlcGVuZGVuY3kgd291bGQNCj4gPiA+ID4gYmVjb21lIGFuIGlzc3VlLg0KPiA+ID4g
Pg0KPiA+ID4gPiBFeHBvcnRpbmcgYSBzeW1ib2wgZnJvbSBkd2MzIGlzIGFuIGVhc3kgb3B0aW9u
IGJ1dCBkd2MzIGRvZXNuJ3QNCj4gPiA+ID4gY3VycmVudGx5IGV4cG9ydCBzeW1ib2xzDQo+ID4g
PiA+IGhlbmNlIEkgdHJpZWQgdG8gYXZvaWQgdGhhdA0KPiA+ID4gPg0KPiA+ID4gPiA+IEFsc28g
c2luY2UgRFdDM19ERVBDRkdfRUJDX0hXT19OT1dCIG11c3QgYmUgc2V0LCB0aGUgY29udHJvbGxl
ciBkb2VzIG5vdA0KPiA+ID4gPiA+IHdyaXRlIGJhY2sgdG8gdGhlIFRSQi4gRGlkIHlvdSBoYW5k
bGUgaG93IHRoZSBkcml2ZXIgd291bGQgdXBkYXRlIHRoZQ0KPiA+ID4gPiA+IHVzYiByZXF1ZXN0
IG9uIGNvbXBsZXRpb24/IChlLmcuIGhvdyBtdWNoIHdhcyB0cmFuc2ZlcnJlZCkuDQo+ID4gPiA+
DQo+ID4gPiA+IEluIG91ciB1c2UgY2FzZSwgd2UgaW50ZW5kIHRvIGhhdmUgYSBsaW5rIFRSQiBh
bmQgaXNzdWUgYSBzdGFydFhmZXINCj4gPiA+ID4gY29tbWFuZC4gQ29tcGxldGlvbg0KPiA+ID4g
PiBoYW5kbGluZyBhbmQgY29udGludWluZyB0aGUgdHJhbnNmZXIgd2lsbCBiZSBvZmZsb2FkZWQg
dG8gZGVkaWNhdGVkDQo+ID4gPiA+IEZJRk8gaGFyZHdhcmUuDQo+ID4gPiA+IEJ1dCB3ZSBjYW4g
ZGVmaW5pdGVseSByZXdvcmsgdGhpcyB0byBkaXNhYmxlIG5vLXdyaXRlYmFjayBtb2RlIGJ5DQo+
ID4gPiA+IGRlZmF1bHQgYW5kIGFsbG93IHRoaXMgdG8NCj4gPiA+ID4gYmUgc2VwYXJhdGVseSBl
bmFibGVkDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gT2suDQo+ID4gPg0KPiA+DQo+ID4gTG9va3Mg
bGlrZSB0aGlzIGNoYW5nZSB3YXMgYXBwbGllZCB0byBHcmVnJ3MgYnJhbmNoLiBVbmxlc3MgSSdt
IG1pc3NpbmcNCj4gPiBzb21ldGhpbmcsIEkgZG9uJ3QgdGhpbmsgbXkgY29uY2VybnMgYXJlIGFk
ZHJlc3NlZCB5ZXQuIEhlcmUgYXJlIHRoZQ0KPiA+IHJlaXRlcmF0aW9uIG9mIHRoZSBjb25jZXJu
czoNCj4gPg0KPiA+IDEpIFRoZSBnYWRnZXQgZHJpdmVyIHNob3VsZCBub3QgbmVlZCB0byBrbm93
IHRoZSBkd2MzJ3MgRklGTyBtb2RlLiBJdCdzDQo+ID4gc3BlY2lmaWMgdG8gZHdjMyBjYXBhYmls
aXR5IGFuZCBzaG91bGQgYmUgaGFuZGxlZCBpbiBkd2MzIGRyaXZlciBvbmx5Lg0KPiA+IFVzdWFs
bHkgdGhlc2UgcHJvcGVydGllcyBhcmUgc2VsZWN0ZWQgaW4gZGV2aWNlIHRyZWUgYmluZGluZ3Mg
YW5kIG5vdA0KPiA+IHNwZWNpZmllZCB0aHJvdWdoIHRoZSBnYWRnZXQgZHJpdmVyIEFQSS4NCj4g
DQo+IEknbSBub3Qgc3VyZSBob3cgdGhpcyB3aWxsIHdvcmsgd2hlbiB3ZSBoYXZlIG11bHRpcGxl
IGZ1bmN0aW9ucyBhbmQgb25seQ0KPiBzb21lIG9mIHRoZW0gdXNlIEVCQy5UaGUgb3RoZXIgRVBz
IGFyZSB3b3JraW5nIGFzIHVzdWFsLg0KPiBJbiB0ZXJtcyBvZiBEVCBiaW5kaW5nIEkgY2FuIHRo
aW5rIG9mIGZvcmNpbmcgY2VydGFpbiBFUHMgaW50byBFQkMgbW9kZQ0KPiBhbmQgdXNpbmcgdGhl
bSBmb3IgYW55IGdhZGdldCB0aGF0IG5lZWRzIEVCQyBidXQgdGhhdCB3aWxsIHJlbW92ZSB0aG9z
ZQ0KPiBFUHMgZnJvbSBjaXJjdWxhdGlvbiBmb3Igb3RoZXIgZnVuY3Rpb25zLiBJdCB3b3VsZCBi
ZSBncmVhdCBpZiB5b3UgY291bGQNCj4gc3VnZ2VzdCBhIGdvb2QgYWx0ZXJuYXRpdmUgd2UgY2Fu
IHVzZS4NCg0KT2suIElmIHRoZXJlIGFyZSBvbmx5IHNwZWNpZmljIGVuZHBvaW50cyBzaG91bGQg
dXNlIHRoaXMgZmVhdHVyZSwgdGhlbg0Kd2Ugd2lsbCBuZWVkIHRvIHVwZGF0ZSB0aGUgZ2FkZ2V0
IEFQSSB0byBzdXBwb3J0IHRoYXQgYXMgeW91IGhhdmUgaGVyZS4NClBsZWFzZSBkb2N1bWVudCBo
b3cgeW91IGludGVuZCB0byBsZXQgdGhlIGdhZGdldCBkcml2ZXIga25vdyB0aGF0IHRoZSBIVw0K
aXMgY2FwYWJsZSBvZiBleHRlcm5hbCBGSUZPIChpZS4gdXBkYXRlIHVzYl9nYWRnZXQgc3RydWN0
dXJlKSwgYW5kIGZvcg0KaG93IG1hbnkgZW5kcG9pbnQuIEFsc28gdXBkYXRlIGFueSBleHBlY3Rl
ZCBiZWhhdmlvciB3aGVuIHVzaW5nIHRoaXMNCmZlYXR1cmUuDQoNCj4gDQo+ID4NCj4gPiAyKSBU
aGlzIHNwZWNpZmljIG1vZGUgIkVCQyIgZG9lc24ndCB3cml0ZSBiYWNrIHRvIFRSQnMuIEl0J3Mg
bm90IGNsZWFyDQo+ID4gaG93IHRoaXMgaXMgaGFuZGxlZCB3aGVuIHVwZGF0aW5nIHRoZSByZXF1
ZXN0J3Mgc3RhdHVzLiBJdCdzIGFsc28gb25seQ0KPiA+IGFwcGxpY2FibGUgdG8gYnVsayBlbmRw
b2ludC4gSWYgaXQncyB0byBiZSBhcHBsaWVkIHRvIHRoZSB1c2IgZ2FkZ2V0DQo+ID4gQVBJLCBp
dCdzIG5vdCBkb2N1bWVudGVkIGZ1bGx5Lg0KPiANCj4gSSB3aWxsIHB1c2ggYSBwYXRjaCB0byBy
ZW1vdmUgdGhlIG5vLXdyaXRlYmFjayBiaXQgYmFzZWQgb24gdGhlIGRlY2lzaW9uDQo+IGFib3Zl
Lg0KPiANCg0KU3VyZS4gV2UgY2FuIGtlZXAgd2hhdCdzIGFscmVhZHkgaW4gR3JlZydzLiBQbGVh
c2UgdXBkYXRlIHRoZSBjaGFuZ2UgYXMNCmRpc2N1c3NlZC4NCg0KVGhhbmtzLA0KVGhpbmg=

