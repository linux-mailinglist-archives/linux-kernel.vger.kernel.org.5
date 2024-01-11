Return-Path: <linux-kernel+bounces-22924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB3582A586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB6F1C230E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53DA3C;
	Thu, 11 Jan 2024 01:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S2zhOJmE";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YE9picLi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B14uADqG"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851E624;
	Thu, 11 Jan 2024 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AMwRAr015340;
	Wed, 10 Jan 2024 17:21:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=9BDYRirUEIlh7uaBpRbdI08JwXvU/AN/PkTR3ATN0SM=; b=
	S2zhOJmEwRK83zWcJzA2QZvkZ6xAqW4Maq5yGCPZh5/dJzXz5ZLtp+r1UoicD/x3
	3fDHJXwmFKuFNL32j+LOtZDmC+oripUfmEwghgImFEjcTsbZgTqXye4pBmMfSKbz
	lkeNWHkTB8+6r9SdVZMIIi1mV7+n3CnOZPL2knQrWsv0iyYrmPkF13k2D3THAfzX
	2UmkUA9lEq/Hqo9OeefqIUiF7/i+5OMi9HRyXt47b6wfAW7Co0eZ3WzNpjW91MAw
	adBSMDgTLDCCxJI0F3W6Fas1TU3ul5wjniyBeVX/CGLOgSd0AooBDYLNtSJadMsa
	IXulNBDvTymYcX6csQrBEg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vj4gcrdxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 17:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1704936086; bh=9BDYRirUEIlh7uaBpRbdI08JwXvU/AN/PkTR3ATN0SM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=YE9picLivK6nwq/lcX9b2r316+W+aer2rQWOw9thR9sLnUxI67+i9Xc6+n7wVBEH7
	 udkZ976oKSQATgs0ncb+8Ya/QajAS5J03nxHaJSz8+S2n6JZh8S/YiAnRdNm2Dyfou
	 3VymZyhnXyYWk10XDPpNjgpQXxFkie0liybSH6km5thxhcJfTQ5JHbjLEZSJSLhDIk
	 vCLnSr72SuFTD4+rkTGRfjshVp4cOnECm0XJTuR3KDVdodOhvSecP8e1G/qg7L4NgJ
	 NrwsSetZy1bWXVZBwsifdnI5zdNjvVqfqNfJB4a2GB6wK0lhxcdUVbTr40AGuzmkzS
	 lYhqJ+ZROo3nQ==
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CAA6540523;
	Thu, 11 Jan 2024 01:21:25 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 46FD3A008C;
	Thu, 11 Jan 2024 01:21:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=B14uADqG;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 75A6E401CA;
	Thu, 11 Jan 2024 01:21:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe8Vvw+LNWc8ZlZJM8UN36nA331nvAo7mktLauqhcQxc2rbDfOy0lDcxA9+yPInvxUrx7G2iJl76ZA9ZKnhGKOvxpqIA5trB1SnWtDQ5zh3GI8w+So0TCBUpAi01nb2S3LQn8b3m2y2UQES9JAQcypfK+bR/z2qc0ftVNU+hUShkk8W0RwKMnyTBr3dwLmYOIuVMNf2QQe20wATibM/YHqH6Lfs18oc7tYDVmm+TcgixYW9wMzNKGlmX6m9mzkiLaIhWxnG0mmUZiyR1FBFI31gJngWU6MEcB9E1W5Kdp9+1aIA+QHfi2E4BQ27tq6PXpFvpIb6rn3KqT87/USj5Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BDYRirUEIlh7uaBpRbdI08JwXvU/AN/PkTR3ATN0SM=;
 b=Otbz2myddhlFm1Deh8X4eiWwnjW4gkTSd5ERHbCgAdo5hwz4LuiaBRpSMSsH535ap/YQwqeLXI6ejqnzs9mzEHD7IbLIxGJ19C96e8HJWgVYIT5RWcb6XwF5AdtFpFcTE0F2C//SvFGu4c/m4tTXbl8axtGjlruzuXRtpZWkw2DaesaRer0cEhbNhrHGH6jS2vW1qK0X5mtsQIoo2gsxD0/bYJtVpFy3slCdqyzHZ5tiU5aGUS1MZ0pjQrzyWie0m8lHQwX4/gqs8YZHQvGSQp5D/pExaN/935CYN9dDV08J3MvdOdknnsEsTDJHrGhSCFDlZEReBiN7KbtjvBvc5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BDYRirUEIlh7uaBpRbdI08JwXvU/AN/PkTR3ATN0SM=;
 b=B14uADqGYfpO6AXtjyzB49DKFr9NS0a2DZonlMgE5cky3gt4loRYHKAJzWkxuFWzMoBcPBis67qxygCjGK2RRpT9H+P2Hl/I+6Jh8i6spZdzxeGAaih+GBY35xhaQpWhydZNlB2qm9Zc+FupARTt/O9X/mQYmgLMrvwgSUS3b/k=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by BY5PR12MB5510.namprd12.prod.outlook.com (2603:10b6:a03:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 01:21:19 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7181.015; Thu, 11 Jan 2024
 01:21:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        Kuen-Han Tsai <khtsai@google.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Mehta, Piyush" <piyush.mehta@amd.com>,
        "Paladugu,  Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Topic: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
Thread-Index: 
 AQHaDVvtK46auOuFqk6xUT0xKW8RPLBm7bwAgAlqnQCADGtvAIABEQcAgAAcwACAVT6ZgIABDhIA
Date: Thu, 11 Jan 2024 01:21:19 +0000
Message-ID: <20240111012116.h3mjhxq5u44npouz@synopsys.com>
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
 <20231108114848.794045-1-khtsai@google.com>
 <d040f84a-b55e-4b1d-85c1-b6cec6554198@ideasonboard.com>
 <20231117014538.ro6bo2ho2jgl7l6s@synopsys.com>
 <20231117032832.6k4msq2vlp56asho@synopsys.com>
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
In-Reply-To: 
 <MN0PR12MB59538FF4FF9C753EB9264E21B7692@MN0PR12MB5953.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|BY5PR12MB5510:EE_
x-ms-office365-filtering-correlation-id: 3c0b623e-8baa-4204-932a-08dc12439d74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1Cwqb7aTHK9ZftrwBH2HYmneBO+AsvbOzgM6rHeYvJ9fy1kiZl7amWZNnFpE7sBYghNWFlB9So7agJdLOPvYYHDGwZq7QNB2IqyyZb+HdGGkEy6kJ4+xTGd2JvUh38wpz02Rm+uVuvUz8iplktARJhbyVvuXhcbeShyU/4mvYM34TKDODPD2IAl586MbYbeQydAZiTocFgjXYjCm6EL/y3YjHTCqZ5y7CPfk8jafbo2drw+EZvHS5KsEVcZG6r7ZiXlhAoVdVjsXNUbM2LwxV9SWAN/ab4ZfeZD16+LBhqCHPw2FVRg0mxp3PRRYkDio7Kclqd0s5yXvmhMq0KCSqbUr8fQDv9VkEGgYXqD1TBwkuCEvbRbL59zZ8uPsgyo9VDS2HJuXxSVn/reUtfMeIVSiZnzV/8GpDEd8fakNcXGTvjwICHKhAEdJL9olYDWAN16otNgbUHHsS7eEf7S/mCCdyUtS0l/BsXVBpiQ12352LaKwlkyz4IVk9Ut7VWLwiic3mkZFp5g6CYnp6xgYO0pZmojb3KoeshPqyaIFhLOF4TV4pEiTMqAlNj/ZYbcMdUML7szdPWgyYxRbd4EkRCHrTfNzkcu+QAPp8V5weon05WSBmy52sSfH/fagJKw4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(366004)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(2616005)(1076003)(26005)(6512007)(6506007)(478600001)(53546011)(83380400001)(5660300002)(4744005)(7416002)(2906002)(41300700001)(91956017)(76116006)(66946007)(8936002)(66446008)(6916009)(64756008)(54906003)(66476007)(316002)(66556008)(6486002)(8676002)(4326008)(86362001)(122000001)(38100700002)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dEhXL1cvVUswNDBMMGFrb2RhV083a2dhZ09WNGluUC9Md2hXaHlnMlNPdGNu?=
 =?utf-8?B?aHAydE54Z0xLNERJZzYvLytzRzhSRFpBRGNCQnloSG50dWE0T2xKSC80ZjZJ?=
 =?utf-8?B?akZNczFxNTU3MGtWMUR6dmFwby94dE5JMS85QlVLMFdCcWhmYm5ZbWE2eWhK?=
 =?utf-8?B?ZnQ1SmtDNnIyOVFSRWNtQ1BCT09nMmthYWJrNGRoRE1JVDNmSVZjK2trajlV?=
 =?utf-8?B?Z29pK3VNcm50a0lMSWd3K1lRaXc4ZlNUQ3ZocStDRHErOVBmVndHZzlwelZl?=
 =?utf-8?B?T3lXM1hyZnBCK1J3ZWdRVTNvZFBSVGtiY3RSSHM2d0d3ZkMrNStZQzZsR1A2?=
 =?utf-8?B?N3dQOTU2ZkxrYThabERmUzQ1Sm0ydGszNEUrRmljanZsYVJ3K2p5LzZKRUJY?=
 =?utf-8?B?bjBFRXJ5ODByNEZ4N1ZvM1BEcEVjdnFEQnpieFRqRlVEaWNOKzNkVmllSGt5?=
 =?utf-8?B?RFJRcm42dHo2RHpaRkFXNkdqUkhGV3dYcUpDUm93Z2pkbndpazVhS2l3S2tG?=
 =?utf-8?B?ZUJ1UklHcW1PdjdLWWdtNngyVWk4LzcwYU5LNURGbVI1UGpZYW52Mkl1dHdL?=
 =?utf-8?B?WS9EUEE1TlZDVEE3MEtpcnpYdVBUZGVFWFJ0eGVsbVlSM0ZKTXdLa1VzUDF6?=
 =?utf-8?B?bXFZOCtjbkpiRUJLak9jemJPNUczMVgrLzR4dFgwZ1QrcGd4ZEpESjQ3OGd6?=
 =?utf-8?B?b1l2Q3F2a1FIVEJCWGhGZTlFNVRrZWk5MzI4NXlLcHlLaGRNbm8yaXU0Ritr?=
 =?utf-8?B?MlQ1UVM1ZnlWMG5WVGNmblovU3lFdXhrM1pUMHBZN2hKS2RiTC83blRpNCtR?=
 =?utf-8?B?OXduWGRwUU5RMlRVV2hLOW5IT3IyY2hkN1ZTbzFPMERlUmd0a2JwRm5pbHd0?=
 =?utf-8?B?WG5SY1dOeVNSK0hETkYyU2ZlemUyaGhnYXdOWkw2OWxPYmFGNHN0eTk2S1hs?=
 =?utf-8?B?VGpwRzU1QldhZko5MEg3bjlwNE5pWDZhNFhWcGpwUGRXNFduTUV3STl2SW5J?=
 =?utf-8?B?aG9CM2NzNnh4MnRyR2t3b3pJeDhRK1JaSnE3YktJSlJ1NVFJR01qTjduOVZR?=
 =?utf-8?B?Rm9Qam81UHJZZHBUKzFidEZSRDg5Zm9jcCtsKzZFeEQ0Um1BWFpkT1k5OU5x?=
 =?utf-8?B?aEJ2SjAraGxtdmNkTXZ4ODhIYlFQUlNwdmcvOTFMSGF2aDUyN3E4cHVER0xa?=
 =?utf-8?B?NGQ5eGh6OHBzcmV0d1YrYU80YUV5NjVqZ3lZbmw3cWQzdm5aZ29KbS9WSUg4?=
 =?utf-8?B?ZXl5TlUzNUlnb2YxT1hVdG9PVWNwRXd0dVdiVWpyTkUwTTlETG9CR2dHRFpi?=
 =?utf-8?B?djVweExjV09MOVpmcTJEMjFRVmQ1MkJpVUwzNE1sRTNLODFSOVNLLzNFbVVN?=
 =?utf-8?B?Yis1ZEZJVUtpNUpZZGw3TjduczZOVmJUMnozUk15Y0hFYzJHZWRmY3NJL1Rh?=
 =?utf-8?B?Q2NicmRWNTBUMVpGbDNqM0xWRnc0MzBnWnNvSmtqVDcwVlpJYXVSUDM4enlh?=
 =?utf-8?B?M3VScXVUb2EweG5CcUpoZnZhcUJYV1ZkalljYlp0blBaNlF2Y093SzJYQ0tT?=
 =?utf-8?B?a1krTWV0NWdqWVhWM3ZaYVlUVUJ6RXdtdjY5ZnRMUUxYMU1FSytsczdGdjhR?=
 =?utf-8?B?MG11cmJyOU0xbkdpQ1NGRDR1a0xubGpud0RwMTY4ZkFLazg1dEIvTDJtclhS?=
 =?utf-8?B?b1hra2tuWG4zZHB0N1pvQ0pvYlh1UmM2MlZqaUdFYzd6aHI3WVVqTmlxQWRG?=
 =?utf-8?B?L0IvNEhyeUR3NW1IZllhS2VxblpybnNrK2tybXVPZ21haUtIV2w0ZjNJdmlW?=
 =?utf-8?B?bWhQSmVqVnJjUUVtcjFzVmllSCs0dHBWblkxK2hJdHVyTmh5aHJRN2dLNjcw?=
 =?utf-8?B?YlhodlZPcDJ6ZkdqWkxQNE1hSE1PQnJUVGJEY0Q0YzltbFgwOVV4K1Y5T3VH?=
 =?utf-8?B?OExtK3NncFF5dklJRVNZSzlDWDUxaVphSVpia3FwT2RoNTlhWHFUNDZkdHlG?=
 =?utf-8?B?cFRpNjRvNVBxNzFUQ2dkOGJtb3pLNHlaem9mYncxYVRxbm4wVlgydmErTmVy?=
 =?utf-8?B?WTRkL3lSbURwYkZ0bmRYbWFjTWxYM3cvQnhlOVE2MmNqSkxScnZCSWhUWWZ0?=
 =?utf-8?Q?4Z5Nok/+oZD7UeLdkKMmsz8/p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7CEC24E85A39A4394DCBC99EF70DC7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z3sJr+fvTWBXbBOskvLQfCad34f+nsF5WDNaSdVReM1h/+p6NgRebSabbY2mXtmPZrW7arjpssIubtAbFYrEyYUJO3CBNTU/K8Z1OdwzmxmjQ0o/W9PjjYxL0Ps5amRuI84HaWiLrPcy15UpDZcsO7nOJe790YTDtnFbgkMSbMLzztwGnPir1TshdkEzVn/dcrV+ALPpgW9jrdpisT9R1gIhNRe8VzIAma9/WGd6I8aQAGWqaoPVYWLX2duIGic/iuijN8zC2p7QHkz++rSRaR/NdNtoOZumyTLBbBE2H862ZRmwI30Pdfhn9PeEn/zhPyifCo9rUpYqOATsuC4pmpguZY2xrTqJFKMggBKbmNWXTNG//vag7649tmiTo5OlT0Zs9iTRA8a6SbtFHx1qk1149mYa7Wmy+piif8ubY/4e4AmDNuc5Clbf1fl7y7kNFGvHJ7n8Sk26uTTYp2ELwuw/SLRL5qflNx+GhJ2Fnh9Stpkz9NR+orpVaP9VzGW4xJPP+aCtvaJ8Ri2HmYc3MGGI1m5CpWQDIakGC6GW2xUUx9Q5yrl4Y6rXz0btAdznEL53VPYJwpU5g9TpT/9uGhubccopugMcZH4MUV74iVEFAefjzEay07P4SjT2+6WehVnaHURhdO+dapcO0zvymA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0b623e-8baa-4204-932a-08dc12439d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 01:21:19.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CZn7cTrcwbhGWVcTwetfZyYADzmJKfQ1Xerm0Sv3SjGiMwd2jufe2D/N2NVSiygRMHAxR69Qg2vp47TJbW/rlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5510
X-Proofpoint-GUID: 4xsydsUoztjGcJ5LOBXQ8xjKawbHEKk_
X-Proofpoint-ORIG-GUID: 4xsydsUoztjGcJ5LOBXQ8xjKawbHEKk_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=493 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 adultscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401110010

T24gV2VkLCBKYW4gMTAsIDIwMjQsIFBhbmRleSwgUmFkaGV5IFNoeWFtIHdyb3RlOg0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGhpbmggTmd1eWVuIDxUaGluaC5O
Z3V5ZW5Ac3lub3BzeXMuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMg
ODo1OSBBTQ0KPiA+IFRvOiBEYW4gU2NhbGx5IDxkYW4uc2NhbGx5QGlkZWFzb25ib2FyZC5jb20+
DQo+ID4gQ2M6IEt1ZW4tSGFuIFRzYWkgPGtodHNhaUBnb29nbGUuY29tPjsgZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc7DQo+ID4gbGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiB1c2JAdmdlci5rZXJuZWwu
b3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47IE1laHRhLA0KPiA+IFBp
eXVzaCA8cGl5dXNoLm1laHRhQGFtZC5jb20+OyBQYW5kZXksIFJhZGhleSBTaHlhbQ0KPiA+IDxy
YWRoZXkuc2h5YW0ucGFuZGV5QGFtZC5jb20+OyBQYWxhZHVndSwgU2l2YSBEdXJnYSBQcmFzYWQN
Cj4gPiA8c2l2YS5kdXJnYS5wcmFzYWQucGFsYWR1Z3VAYW1kLmNvbT4NCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSB1c2I6IGdhZGdldDogdXZjX3ZpZGVvOiB1bmxvY2sgYmVmb3JlIHN1Ym1pdHRp
bmcgYQ0KPiA+IHJlcXVlc3QgdG8gZXANCj4gPiANCj4gPiBPbiBGcmksIE5vdiAxNywgMjAyMywg
VGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPg0KPiANCj4gVGhhbmtzLCBUaGlu
aC4gSSBjYW1lIGFjcm9zcyB0aGlzIHRocmVhZCBhbmQgd2FudGVkIHRvIGNoZWNrIGlmIHlvdSAN
Cj4gaGF2ZSBzb21lIGZpeCByZWFkeT8NCg0KSGkgUGFuZGV5LA0KDQpTb3JyeSwgSSBqdXN0IHJl
Y2VudGx5IGNhbWUgYmFjayBmcm9tIGEgYnJlYWsuIEl0J3Mgb24gbXkgVE9ETyBsaXN0LiBJDQpl
eHBlY3QgdG8gaGF2ZSB0aGUgZml4IHBhdGNoIGFmdGVyIDYuOC1yYzEgcmVsZWFzZS4NCg0KVGhh
bmtzLA0KVGhpbmg=

