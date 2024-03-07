Return-Path: <linux-kernel+bounces-94840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5868745CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7E287440
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB936112;
	Thu,  7 Mar 2024 01:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="A8UYgEPT";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LtUdAF8A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TzrnRox/"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60CA4689;
	Thu,  7 Mar 2024 01:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776696; cv=fail; b=aj5rI3QfJKypn0dLZHiip6nEukww28L3S6qnbBfxbM4szV+suezbfHwLCq77Pa80Eq3VcyrUKwdQQ6XzQ6wGYYKWSLGmGmb+8zPvtCxoE/VvoCNdnCMaQ6l6sHFQBKYqjM9z7UC6GxA+VZoUT9ZZ4ND+W3vwg745HLg2zQkpOmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776696; c=relaxed/simple;
	bh=Y8BGFrKOyw38IeK+PDsgv5DT0xZgdvMGkS5jwIX9/f4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spFBUrbgyVoVWccGIOB8v1GwfZLH7nSwM11iUqxsO8NKCD/WeDfNNC79J6lz7DyVxtR7WydYYIJXb11WpFaZDpVOb4739f4bynQEoX3QVsMVoE1JHAQOIz+0xElHw9Ajdz2DJfUDaDEc7lk2DG+v0lGBWy0M5FqtDLQnYrQiWzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=A8UYgEPT; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LtUdAF8A; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=TzrnRox/ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426KUjTi017936;
	Wed, 6 Mar 2024 17:57:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Y8BGFrKOyw38IeK+PDsgv5DT0xZgdvMGkS5jwIX9/f4=; b=
	A8UYgEPTz3Ei83DuKjcjbFQsXA3OAOFxsJRNiV3O5DxxRdzVd7M1JAa13xEnzSGY
	zmtIRNU9lRY1ZeNRxS+4fihBVk5acuS/UbWRI+30WHjymjXnYQ+m+CU1MUKmm0ay
	Mx+DbGPeeJ1A2MqhLH2Ktd9TkJ8hbIEnWv/eL2DSg+5gL/1tnUKL0aMLBenc9UlC
	MyvF0VQFgFcHSFVO1eimsGyme2RI/RpqZHJVM7Wvp6GtUamX6zYAibyFCdRmwbuW
	iiRmFRf15zRlZ+glKsLeiaGTaWKRQZKkaEFfv/1AguNivowZ4O7vwqNhkJ/HI4YW
	DqY20ulrUtcvBELFioXMgQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3wm3wx4462-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 17:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1709776671; bh=Y8BGFrKOyw38IeK+PDsgv5DT0xZgdvMGkS5jwIX9/f4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=LtUdAF8AVInJDqTX9Y2OWZK+9YbSwY6eU9jLxB1blkZWXXWMTrO5Xe84kKq4mwEcM
	 sgYolVQA6hnXY8evBQezaK3pWzThp5D1JRl1s7JG/teQMqJq+hptidEfWFAajis1yS
	 dg7mpiPkh4S03rdjpVXr4MGS3Mq8jQr/SBdPMqrDwburc4KCcHhWkElmb8wk4W12Mh
	 ZSHqQEzr9ooEXYZq7RsAwcOZ0igz9Bgx6LJff+AmCGfG0xYWY9Ti/RPYzwt9kQRSxp
	 hLYDP7ZYwWFKjuTU7OdfPsudiDjRz7uBrKCdiMIzQgA+3NVFIgZsskYBnCbgQ5366n
	 gw2gBij8DjwuQ==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D32034029A;
	Thu,  7 Mar 2024 01:57:50 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id DCB7EA0073;
	Thu,  7 Mar 2024 01:57:48 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=TzrnRox/;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E4A3E403EC;
	Thu,  7 Mar 2024 01:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGDhz/QB1P+Y4bqVTL5eG34sF379QQn+ydzop3mSmpocx7cMsUQ/RCo9D2HKN5Gp2hGLhiaTYuyi9JdwPw1IoReITMu0rVGcU37vTqvaREGo0RwQciPYxD1rS+d6R8GNMtZdp0kO+Evwu+JQoUq6lOtDB+oXrTDSWgfJLNb+YJvcjE8QsD9YbGvOCIyih5g9PC+mwKeMaSXYJssLJQwclONlGxfuuMvYcYYFe4b52bSk6UUaihwH2AvsheuE760Kau2GJyf8xHgMTbsacn551yOFf1I9/thOJCwe7tXwhRQ/PYUmdAH3XcFeCNmDnCV3xNOSMdJq4e+1OROwOECA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8BGFrKOyw38IeK+PDsgv5DT0xZgdvMGkS5jwIX9/f4=;
 b=QIPOQY+fylR3f9shFBdlCZdsB8pM1UABxUCcHREImvghBMgo5qpXiUE1/x7Iw56k4yltcuEncIkaDAMuZeCj8y9CSwXFRkR8HbJ4E2lCDMNmEnY0abOUvbUDwpVPjJNi5RuLvjlNTpqKU4snZ+516m0RO7hR9Y5ey7O5hf07ZAkEsbCo1cyQsbLcHKJBdzYSdUpW4xsAEaXR1UPc0guMV24mR+7b8GJStHN+dkD+ZRwyWGSf2BeZbMQa8MAZfQvNVzewJ8y9IDYFGGclZzRp+YM2HYUTEQVBCvnppcP/TB6xy/PTJwL/R6KZPFaFOQSmxHmuWvA4uPAYutz+p5mrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8BGFrKOyw38IeK+PDsgv5DT0xZgdvMGkS5jwIX9/f4=;
 b=TzrnRox/yN9Bab5Igf/7Sm/JbLLdbqDiEE0YqjKRmkKCE7cdGp71Nb18K0GvGkMy2sR4+lU197Rly9YNLsoJVK1qwMxEDAVeUAj7EBgg7LMOJeEsgQNGfcbqcEceL7P9W+fKQqr6cWWGvrpMyiYvg+YVmIsqAeCPqfCheoV3x6s=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Thu, 7 Mar
 2024 01:57:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 01:57:44 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Michael Grzeschik <mgr@pengutronix.de>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Dan Vacura <w36195@motorola.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Thread-Topic: [PATCH v3 2/6] usb: dwc3: gadget: cancel requests instead of
 release after missed isoc
Thread-Index: AQHaZSKBngnJI2fmsEG+RpJSSObqsbEVkDeAgAkluwCADOVwAA==
Date: Thu, 7 Mar 2024 01:57:44 +0000
Message-ID: <20240307015736.4dhcrzsli4dihym5@synopsys.com>
References: <20221017205446.523796-1-w36195@motorola.com>
 <20221017205446.523796-3-w36195@motorola.com>
 <ZdaPLGTbsBo4F4pK@pengutronix.de>
 <20240222011955.7sida4udjlvrlue7@synopsys.com>
 <Zd5Nns91uXvTOAwd@pengutronix.de>
In-Reply-To: <Zd5Nns91uXvTOAwd@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7214:EE_
x-ms-office365-filtering-correlation-id: 4e93ae84-177e-4078-cca8-08dc3e49faf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 yxzyOI963bIHHqtO6i1Jc792Fsi0gsfS/27XEfqdAnNyM2McHUGRaoiTq7/3UEJuIZ63oofEXzIc6CZfpysDFA/NzA/YaMCR57rJ5/+8qdhSvC/p5OpG19QPSg9cZJyYtpUO5eyPeBooMO3bkAoZTR1EgS+XDRpN96p84qgv/3yQ4Pt9bDdLveJWJZw5qq5uO1Butq6CQw3KOVqjyqSCee7j2CpwrVPZIyxTGvkQzfTWPjfw3JzusvJFxhmpuoWuIfhX8rVowE+WmCiKV1DZbuy+exbvZ0Sx5ouHiP9Ag2XNCxUp8QD+QM38H+PQb0twTb3kQ6Uz87ftO3cebTHtIcijgsp2B28TuueySUjkvWbzsLuY8GBIP75wfjE5s+O5hq6uXXgsD3nNYEoUnPOYkO6s5BZrffcnTTCVIxNluEBb3hekoTtm1MD3bSqMZYdbrk2PmNJCabAX6Owo2EnbX0ijDYTYJNy01QxFTNYUXYuwrVzTW8I/W9h0MAlcfoKxYwrTaPowLfpEEd0dqWIQHK+Gslp5Zb+1hTnGEgpOlNscZ+2mlNoNglkIOCNpo5e5St1EcFU6gpAG+E3mMvF9ydjatRDWcjaFhCQ5l2vfuEz972QgTXzlgmhr9ki1sFOU52CXeuKcDAnXynTULo8RSubDdVkkdP8e1pdz4iqhGcO2PmRHczHerYWevLxzYKzNRwYaMs4f+b8ESpxRCmeR70UZjPWLxzrWlpF7GnnH3KA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bmlaNElnamZuRFVaK2xacjQxUi85TVU5eGtCeFhJNGhvdGRVZ3BvVHg1aFV4?=
 =?utf-8?B?TFJiamx0R2VsenExTy8rNE16WUNjSGxiY3JLZE51N25MbWpla1M5aGdpSDlj?=
 =?utf-8?B?cWNES3djYU16VmN6di9NUVhQd2FiK2FWd1h6WFpHenNLQ3VSdFRvSXBiT3RZ?=
 =?utf-8?B?aC9xYzVMbUlYd3IxenlBaVJpUWFYNXhybHJsSk5JMll4M3BkTnl5SHNwL1px?=
 =?utf-8?B?QXJRZzJGdGJ6anordERGSFJXNHROM3NXUUtZdyswWnhuYVk4NG4wSlpJS3pC?=
 =?utf-8?B?d2NzSGpKYXhYNWNTV1MzK0FmUncrbGtOMzRmWVVtcHpXMjI4emRaNnhNcndE?=
 =?utf-8?B?YTFhTW0xT3RZTkdMSDNGdVNzQXpZK2owUTdxWWFBQVdhdy9GNS8rMS9CTjdq?=
 =?utf-8?B?Z0lsa0Nid2NYTGxwWTBqZmVtVklML1c4bmtFSVNPODA2ZWgwS3B6SEMzQVlW?=
 =?utf-8?B?c2ZTWkpuRVBLcTQ5N2p0bUVhTllMUVlXc1pSMFpNK2ZlUkl2YWFJc29MU0h3?=
 =?utf-8?B?NmRGbnd3aVcrcXhkSVlsWHljK1hyLzNWWXYvMEgxZlQ3SkRjeFU1c1hjVXhZ?=
 =?utf-8?B?UW0zdy9Ebit0SjRPNlY3WFpXN1ZNY2lsQjlBOW5FTElUbkdiNWx4VnV4QWNT?=
 =?utf-8?B?TGUxWGxHZGEyWUNCZkZQZnVndDdXMlZhTUxBMDFGblcxRkpUSTVNbFJ6aTIw?=
 =?utf-8?B?RnA5SXNrWmlvS29LNFEzZUlHM3BUZ1k1Z05KTEJOVVpZUXpjTm1NUEF1OWY2?=
 =?utf-8?B?U25HTzNhMUJpSjVYeVM4c1pkcUs3RENybXRra3hqc2l5VUk1NlArQW1aak5K?=
 =?utf-8?B?bjZWc2JTdGlpY2REeG8yVVc5TFJxdmdsT3hNeCtRbWhoK0FuRTl3cUxiQmZw?=
 =?utf-8?B?dTJaWndqVFM5NEJwM2ZqU1Fhd3o1NldwUTdqT0FHdWJhdWVCQjNEeHh3UW5w?=
 =?utf-8?B?VVpMVHhjelgvYi8zR0hDc0NBWDgzemx1N2Vlc0daRFhWSTFGVkYxZHF6MGRL?=
 =?utf-8?B?cUJIZXVrQmliSVFYeVpUQlUvRHNiMVJGM1kwRjF4RnlwQ2hySWpVUXBMVFRn?=
 =?utf-8?B?SVp4NVN5VGJaam1HRlBvaWVGbVV1SmpzMVZGd0k4SmlNaDRuUkx1c3AyandL?=
 =?utf-8?B?OUdkUmVOeWR0THZzUHBwMzNSVjJVY1p1OTh5Yzl4SFdIOTZTWnZRbWdLZUNh?=
 =?utf-8?B?a0ZTQlBGQkxCM3JNVDFySzZoNmpRQmp4YUtzWmtmd0NhT2ttaDBQUEU3bEEy?=
 =?utf-8?B?anBkQlRqTjlDR3dncHpENlRqMmhKMHdGdVJScjNYVHZ3c2ZVVDFSNnpScDE3?=
 =?utf-8?B?bTg5bnVMRFZIb1FBMzB2S3IyWUlPdjJBVi9CMkM1enhmWXJOWUFESWgyVWdS?=
 =?utf-8?B?VE50SG5ZT1VPR1Y5b21tbVhLSkRZcGhvclFnS1Q4Z1kyRERQSkx3QjZBbCsx?=
 =?utf-8?B?eE1pMHVjTVhyLzJHSlE4cDZLTTZsRVViSGJST2ZIRkNpU3VyYXZnQS9pQkJ2?=
 =?utf-8?B?eWVWcjBjeGx6djFxRTFoTmtlMTlManVlUlB5Ulh2bG1GK3BGVHMrd25FOHVQ?=
 =?utf-8?B?di8xMkN2QW91MHQyZWhhTUh2QThjcGpTNTEzc1RaSlNqSVE2STRWNUZGVjlx?=
 =?utf-8?B?VFM4cEgybDNRdDJiRGxCS1VqeDZlcmgwSjVJd25WT05GSDAxandqMnRCNFUy?=
 =?utf-8?B?akdleGl2L25VVEdSeWJtMWlXbWhzcTZWUXdJN3cxZkMxTE55OFNnWmJybUsr?=
 =?utf-8?B?OERHNW9NYnNnTXJKaklubWpvcE9vd3NBRXAyM0F5SzR1Tllpc3k0OVdMajRo?=
 =?utf-8?B?a2hzUkpOMWRYdDI0SXhBeDNYbkxmNVA5TENGNFhEU0dsQ0Zwby9TeG1nM1Uz?=
 =?utf-8?B?N0VyTVltallqOVJFUEpFN2pWWG54K3ZEV1lUYnNTQnNnVTVUck9XNHYyWkFE?=
 =?utf-8?B?dTNJSDlLT3hvQmQzNTBEYzV2UzM1YXllTXRYdHVhc2V2WmJ3L1kzRENVODdQ?=
 =?utf-8?B?SEN1N1E2amtETWd1NUVSMWNNeVMya2c2YzB5RzRCdmptQXRjcGEyZWtEK0pS?=
 =?utf-8?B?OGNSMFArSklzcGxqNGFCVlRNY29TOXh5QkRzWjZ5VDZWdXRzRWlWVDVtVDRv?=
 =?utf-8?Q?DrMhy1/T98l0NiC4jG4BS/0qw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <051F2317017D5D4392A2CCFDED340A21@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ELevF1TaGrtKmSo0p2/R1JqLsfIvHMrdaU8rhqDiPv4Op5CzvKF35eZxxplEDxn+GrlnSj1t1Fb+tZjd6y80CsW3KLb7YoOIsalHqDfuyVYuCPbGuSB68bBuFsNGj0ubOp22pffRjm5rP91urd6Uc1VOQfhbLc+rE3mHdk2xTOfwW+pAmc/mf/yQIuMtmkAmmpzTF6Gxm3ys/ZdSxlTDrNmJ4K1sloNyprHEyFF22fO8R5P2WvAzNyTcn+Ne6XIvgNRhsOflEZuNIalSA+xU61fSa4wPcmhh1aKI/pNxJCtSYNyt/k0U4UMeArTK/WRbV6MzpdjW2CNp0Ni/4DjfEH5gghOb22UGWEPiCSzCDC+J3K19WOZ4ywiDfWN0w1zXLFbEUD45ac2zdFg8oNq7FjJRqj7PaG1M3k7qHPavmwdnEeV82VHpzvADxguEu5jVzZ44dNbqlBdM4cAVQAqWxINpCrU5Je8mxm0GRwjELA73mbFOmB5mBNZaDa7mba+FlpiWtJtNUPKmKT7OvxDkHNsqVi9mzT/7i+MuiskIpKWsk8x9EXQ8eyxO7HDlpl4juOaP7igJALUJ742wjRd5S6BDw+9RQeNU4f6FQOUh5k9s6FHijrebwhiUb/LkyfOTAodP9iWB+amcIsAxklxZxg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e93ae84-177e-4078-cca8-08dc3e49faf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:57:44.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2zmp4C3k2Y4RbRzNZiyfopI2y2DsUAQhmXu3MRzDiwnoDKl+m/DZQKYSyt3JzSAK/406L/zmg1+DhFFCmThxlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214
X-Proofpoint-ORIG-GUID: iNpVZdgcpHmvz0vp6J2JINb9L6SRJR_p
X-Proofpoint-GUID: iNpVZdgcpHmvz0vp6J2JINb9L6SRJR_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_14,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070012

T24gVHVlLCBGZWIgMjcsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiBPbiBUaHUs
IEZlYiAyMiwgMjAyNCBhdCAwMToyMDowNEFNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
ID4gT24gVGh1LCBGZWIgMjIsIDIwMjQsIE1pY2hhZWwgR3J6ZXNjaGlrIHdyb3RlOg0KPiA+ID4g
Rm9yICMyOiBJIGZvdW5kIGFuIGlzc3VlIGluIHRoZSBoYW5kbGluZyBvZiB0aGUgY29tcGxldGlv
biBvZiByZXF1ZXN0cyBpbg0KPiA+ID4gdGhlIHN0YXJ0ZWQgbGlzdC4gV2hlbiB0aGUgaW50ZXJy
dXB0IGhhbmRsZXIgaXMgKmV4cGxpY2l0bHkqIGNhbGxpbmcNCj4gPiA+IHN0b3BfYWN0aXZlX3Ry
YW5zZmVyIGlmIHRoZSBvdmVyYWxsIGV2ZW50IG9mIHRoZSByZXF1ZXN0IHdhcyBhbiBtaXNzZWQN
Cj4gPiA+IGV2ZW50LiBUaGlzIGV2ZW50IHZhbHVlIG9ubHkgcmVwcmVzZW50cyB0aGUgdmFsdWUg
b2YgdGhlIHJlcXVlc3QgdGhhdA0KPiA+ID4gd2FzIGFjdHVhbGx5IHRyaWdnZXJpbmcgdGhlIGlu
dGVycnVwdC4NCj4gPiA+IA0KPiA+ID4gSXQgYWxzbyBjYWxscyBlcF9jbGVhbnVwX2NvbXBsZXRl
ZF9yZXF1ZXN0cyBhbmQgaXMgaXRlcmF0aW5nIG92ZXIgdGhlDQo+ID4gPiBzdGFydGVkIHJlcXVl
c3RzIGFuZCB3aWxsIGNhbGwgZ2l2ZWJhY2svY29tcGxldGUgZnVuY3Rpb25zIG9mIHRoZQ0KPiA+
ID4gcmVxdWVzdHMgd2l0aCB0aGUgcHJvcGVyIHJlcXVlc3Qgc3RhdHVzLg0KPiA+ID4gDQo+ID4g
PiBTbyB0aGlzIHdpbGwgYWxzbyBjYXRjaCBtaXNzZWQgcmVxdWVzdHMgaW4gdGhlIHF1ZXVlLiBI
b3dldmVyLCBzaW5jZQ0KPiA+ID4gdGhlcmUgbWlnaHQgYmUsIGxldHMgc2F5IDUgZ29vZCByZXF1
ZXN0cyBhbmQgb25lIG1pc3NlZCByZXF1ZXN0LCB3aGF0DQo+ID4gPiB3aWxsIGhhcHBlbiBpcywg
dGhhdCBlYWNoIGNvbXBsZXRlIGNhbGwgZm9yIHRoZSBmaXJzdCBnb29kIHJlcXVlc3RzIHdpbGwN
Cj4gPiA+IGVucXVldWUgbmV3IHJlcXVlc3RzIGludG8gdGhlIHN0YXJ0ZWQgbGlzdCBhbmQgd2ls
bCBhbHNvIGNhbGwgdGhlDQo+ID4gPiB1cGRhdGVjbWQgb24gdGhhdCB0cmFuc2ZlciB0aGF0IHdh
cyBhbHJlYWR5IG1pc3NlZCB1bnRpbCB0aGUgbG9vcCB3aWxsDQo+ID4gPiByZWFjaCB0aGUgb25l
IHJlcXVlc3Qgd2l0aCB0aGUgTUlTU0VEIHN0YXR1cyBiaXQgc2V0Lg0KPiA+ID4gDQo+ID4gPiBT
byBpbiBteSBvcGluaW9uIHRoZSBwYXRjaCBmcm9tIEplZmYgbWFrZXMgc2Vuc2Ugd2hlbiBhZGRp
bmcgdGhlDQo+ID4gPiBmb2xsb3dpbmcgY2hhbmdlIGFzd2VsbC4gV2l0aCB0aG9zZSBib3RoIGNo
YW5nZXMgdGhlIHVuZGVycnVucyBhbmQNCj4gPiA+IGJyb2tlbiBmcmFtZXMgZmluYWxseSBkaXNh
cHBlYXIuIEkgYW0gc3RpbGwgdW5zdXJlIGFib3V0IHRoZSBjb21wbGV0ZQ0KPiA+ID4gc29sdXRp
b24gYWJvdXQgdGhhdCwgc2luY2Ugd2l0aCB0aGlzIHRoZSBtZW50aW9uZWQgNSBnb29kIHJlcXVl
c3RzDQo+ID4gPiB3aWxsIGJlIGNhbmNlbGxlZCBhc3dlbGwuIFNvIHRoaXMgaXMgc3RpbGwgYSBX
SVAgc3RhdHVzIGhlcmUuDQo+ID4gPiANCj4gPiANCj4gPiBXaGVuIHRoZSBkd2MzIGRyaXZlciBp
c3N1ZXMgc3RvcF9hY3RpdmVfdHJhbnNmZXIoKSwgdGhhdCBtZWFucyB0aGF0IHRoZQ0KPiA+IHN0
YXJ0ZWRfbGlzdCBpcyBlbXB0eSBhbmQgdGhlcmUgaXMgYW4gdW5kZXJydW4uDQo+IA0KPiBBdCB0
aGlzIG1vbWVudCB0aGlzIGlzIG9ubHkgdGhlIGNhc2Ugd2hlbiBib3RoLCBwZW5kaW5nIGFuZCBz
dGFydGVkIGxpc3QNCj4gYXJlIGVtcHR5LiBPciB0aGUgaW50ZXJydXB0IGV2ZW50IHdhcyBFWERF
Vi4NCj4gDQo+IFRoZSBtYWluIHByb2JsZW0gaXMgdGhhdCB0aGUgZnVuY3Rpb24NCj4gZHdjM19n
YWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMoZGVwLCBldmVudCwgc3RhdHVzKTsg
d2lsbA0KPiBpc3N1ZSBhbiBjb21wbGV0ZSBmb3IgZWFjaCBzdGFydGVkIHJlcXVlc3QsIHdoaWNo
IG9uIHRoZSBvdGhlciBoYW5kIHdpbGwNCj4gcmVmaWxsIHRoZSBwZW5kaW5nIGxpc3QsIGFuZCB0
aGVyZWZvciBhZnRlciB0aGF0IHJlZmlsbCB0aGUNCj4gc3RvcF9hY3RpdmVfdHJhbnNmZXIgaXMg
Y3VycmVudGx5IG5ldmVyIGhpdC4NCj4gDQo+ID4gSXQgdHJlYXRzIHRoZSBpbmNvbWluZyByZXF1
ZXN0cyBhcyBzdGFsZWQuIEhvd2V2ZXIsIGZvciBVVkMsIHRoZXkgYXJlDQo+ID4gc3RpbGwgImdv
b2QiLg0KPiANCj4gUmlnaHQsIHNvIGluIHRoYXQgY2FzZSB3ZSBjYW4gcmVxdWV1ZSB0aGVtIGFu
eXdheS4gQnV0IHRoaXMgd2lsbCBoYXZlIHRvDQo+IGJlIGRvbmUgYWZ0ZXIgdGhlIHN0b3AgdHJh
bnNmZXIgY21kIGhhcyBmaW5pc2hlZC4NCj4gDQo+ID4gSSB0aGluayB5b3UgY2FuIGp1c3QgY2hl
Y2sgaWYgdGhlIHN0YXJ0ZWRfbGlzdCBpcyBlbXB0eSBiZWZvcmUgcXVldWluZw0KPiA+IG5ldyBy
ZXF1ZXN0cy4gSWYgaXQgaXMsIHBlcmZvcm0gc3RvcF9hY3RpdmVfdHJhbnNmZXIoKSB0byByZXNj
aGVkdWxlIHRoZQ0KPiA+IGluY29taW5nIHJlcXVlc3RzLiBOb25lIG9mIHRoZSBuZXdseSBxdWV1
ZSByZXF1ZXN0cyB3aWxsIGJlIHJlbGVhc2VkDQo+ID4geWV0IHNpbmNlIHRoZXkgYXJlIGluIHRo
ZSBwZW5kaW5nX2xpc3QuDQo+IA0KPiBTbyB0aGF0IGlzIGJhc2ljYWxseSBleGFjdGx5IHdoYXQg
bXkgcGF0Y2ggaXMgZG9pbmcuIEhvd2V2ZXIgaW4gdGhlIGNhc2UNCj4gb2YgYW4gdW5kZXJydW4g
aXQgaXMgbm90IHNhZmUgdG8gY2FsbCBkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9y
ZXF1ZXN0cw0KPiBhcyBqZWZmIHN0YXRlZC4gU28gaGlzIHVuZGVybHlpbmcgcGF0Y2ggaXMgcmVh
bGx5IGZpeGluZyBhbiBpc3N1ZSBoZXJlLg0KDQpXaGF0IEkgbWVhbiBpcyB0byBhY3RpdmVseSBj
aGVjayBmb3Igc3RhcnRlZCBsaXN0IG9uIGV2ZXJ5DQp1c2JfZXBfcXVldWUoKSBjYWxsLiBDaGVj
a2luZyBkdXJpbmcNCmR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3RzKCkg
aXMgYWxyZWFkeSB0b28gbGF0ZS4NCg0KPiANCj4gPiBGb3IgVVZDLCBwZXJoYXBzIHlvdSBjYW4g
aW50cm9kdWNlIGEgbmV3IGZsYWcgdG8gdXNiX3JlcXVlc3QgY2FsbGVkDQo+ID4gImlnbm9yZV9x
dWV1ZV9sYXRlbmN5IiBvciBzb21ldGhpbmcgZXF1aXZhbGVudC4gVGhlIGR3YzMgaXMgYWxyZWFk
eQ0KPiA+IHBhcnRpYWxseSBkb2luZyB0aGlzIGZvciBVVkMuIFdpdGggdGhpcyBuZXcgZmxhZywg
d2UgY2FuIHJld29yayBkd2MzIHRvDQo+ID4gY2xlYXJseSBzZXBhcmF0ZSB0aGUgZXhwZWN0ZWQg
YmVoYXZpb3IgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVyLg0KPiANCj4gSSBkb24ndCBrbm93IHdo
eSB0aGlzICJleHRyYSIgZmxhZyBpcyBldmVuIG5lY2Vzc2FyeS4gVGhlIGNvZGUgZXhhbXBsZQ0K
PiBpcyBhbHJlYWR5IHdvcmtpbmcgd2l0aG91dCB0aGF0IGV4dHJhIGZsYWcuDQoNClRoZSBmbGFn
IGlzIGZvciBjb250cm9sbGVyIHRvIGRldGVybWluZSB3aGF0IGtpbmRzIG9mIGJlaGF2aW9yIHRo
ZQ0KZnVuY3Rpb24gZHJpdmVyIGV4cGVjdHMuIE15IGludGVudGlvbiBpcyBpZiB0aGlzIGV4dHJh
IGZsYWcgaXMgbm90IHNldCwNCnRoZSBkd2MzIGRyaXZlciB3aWxsIG5vdCBhdHRlbXB0IHRvIHJl
c2hjZWR1bGUgaXNvYyByZXF1ZXN0IGF0IGFsbCAoaWUuDQpubyBzdG9wX2FjdGl2ZV90cmFuc2Zl
cigpKS4NCg0KPiANCj4gQWN0dWFsbHkgSSBldmVuIGNhbWUgdXAgd2l0aCBhbiBiZXR0ZXIgc29s
dXRpb24uIEFkZGl0aW9uYWxseSBvZiBjaGVja2luZyBpZg0KPiBvbmUgb2YgdGhlIHJlcXVlc3Rz
IGluIHRoZSBzdGFydGVkIGxpc3Qgd2FzIG1pc3NlZCwgd2UgY2FuIGFjdGl2bHkgY2hlY2sgaWYN
Cj4gdGhlIHRyYiByaW5nIGRpZCBydW4gZHJ5IGFuZCBpZiBkd2MzX2dhZGdldF9lbmRwb2ludF90
cmJzX2NvbXBsZXRlIGlzDQo+IGdvaW5nIHRvIGVucXVldWUgaW4gdG8gdGhlIGVtcHR5IHRyYiBy
aW5nLg0KPiANCj4gU28gbXkgd2hvbGUgY2hhbmdlIGxvb2tzIGxpa2UgdGhhdDoNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oDQo+IGluZGV4IGVmZTZjYWY0ZDBlODcuLjJjODA0N2RjZDE2MTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5o
DQo+IEBAIC05NTIsNiArOTUyLDcgQEAgc3RydWN0IGR3YzNfcmVxdWVzdCB7DQo+ICAjZGVmaW5l
IERXQzNfUkVRVUVTVF9TVEFUVVNfREVRVUVVRUQJCTMNCj4gICNkZWZpbmUgRFdDM19SRVFVRVNU
X1NUQVRVU19TVEFMTEVECQk0DQo+ICAjZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFUVVNfQ09NUExF
VEVECQk1DQo+ICsjZGVmaW5lIERXQzNfUkVRVUVTVF9TVEFUVVNfTUlTU0VEX0lTT0MJCTYNCj4g
ICNkZWZpbmUgRFdDM19SRVFVRVNUX1NUQVRVU19VTktOT1dOCQktMQ0KPiAgCXU4CQkJZXBudW07
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2Iv
ZHdjMy9nYWRnZXQuYw0KPiBpbmRleCA4NThmZTRjMjk5YjdhLi5hMzFmNGQzNTAyYmQzIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTIwNTcsNiArMjA1Nyw5IEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXAp
DQo+ICAJCXJlcSA9IG5leHRfcmVxdWVzdCgmZGVwLT5jYW5jZWxsZWRfbGlzdCk7DQo+ICAJCWR3
YzNfZ2FkZ2V0X2VwX3NraXBfdHJicyhkZXAsIHJlcSk7DQo+ICAJCXN3aXRjaCAocmVxLT5zdGF0
dXMpIHsNCj4gKwkJY2FzZSAwOg0KPiArCQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEs
IDApOw0KPiArCQkJYnJlYWs7DQo+ICAJCWNhc2UgRFdDM19SRVFVRVNUX1NUQVRVU19ESVNDT05O
RUNURUQ6DQo+ICAJCQlkd2MzX2dhZGdldF9naXZlYmFjayhkZXAsIHJlcSwgLUVTSFVURE9XTik7
DQo+ICAJCQlicmVhazsNCj4gQEAgLTIwNjYsNiArMjA2OSw5IEBAIHN0YXRpYyB2b2lkIGR3YzNf
Z2FkZ2V0X2VwX2NsZWFudXBfY2FuY2VsbGVkX3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXAp
DQo+ICAJCWNhc2UgRFdDM19SRVFVRVNUX1NUQVRVU19TVEFMTEVEOg0KPiAgCQkJZHdjM19nYWRn
ZXRfZ2l2ZWJhY2soZGVwLCByZXEsIC1FUElQRSk7DQo+ICAJCQlicmVhazsNCj4gKwkJY2FzZSBE
V0MzX1JFUVVFU1RfU1RBVFVTX01JU1NFRF9JU09DOg0KPiArCQkJZHdjM19nYWRnZXRfZ2l2ZWJh
Y2soZGVwLCByZXEsIC1FWERFVik7DQo+ICsJCQlicmVhazsNCj4gIAkJZGVmYXVsdDoNCj4gIAkJ
CWRldl9lcnIoZHdjLT5kZXYsICJyZXF1ZXN0IGNhbmNlbGxlZCB3aXRoIHdyb25nIHJlYXNvbjol
ZFxuIiwgcmVxLT5zdGF0dXMpOw0KPiAgCQkJZHdjM19nYWRnZXRfZ2l2ZWJhY2soZGVwLCByZXEs
IC1FQ09OTlJFU0VUKTsNCj4gQEAgLTM1MDksNiArMzUxNSwzNiBAQCBzdGF0aWMgaW50IGR3YzNf
Z2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVkX3JlcXVlc3Qoc3RydWN0IGR3YzNfZXAgKmRlcCwN
Cj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiArc3RhdGljIGludCBkd2MzX2dhZGdldF9lcF9jaGVj
a19taXNzZWRfcmVxdWVzdHMoc3RydWN0IGR3YzNfZXAgKmRlcCkNCj4gK3sNCj4gKwlzdHJ1Y3Qg
ZHdjM19yZXF1ZXN0CSpyZXE7DQo+ICsJc3RydWN0IGR3YzNfcmVxdWVzdAkqdG1wOw0KPiArCWlu
dCByZXQgPSAwOw0KPiArDQo+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHJlcSwgdG1wLCAm
ZGVwLT5zdGFydGVkX2xpc3QsIGxpc3QpIHsNCj4gKwkJc3RydWN0IGR3YzNfdHJiICp0cmI7DQo+
ICsNCj4gKwkJdHJiID0gcmVxLT50cmI7DQo+ICsJCXN3aXRjaCAoRFdDM19UUkJfU0laRV9UUkJT
VFModHJiLT5zaXplKSkgew0KPiArCQljYXNlIERXQzNfVFJCU1RTX01JU1NFRF9JU09DOg0KPiAr
CQkJLyogSXNvYyBlbmRwb2ludCBvbmx5ICovDQo+ICsJCQlyZXQgPSAtRVhERVY7DQo+ICsJCQli
cmVhazsNCj4gKwkJY2FzZSBEV0MzX1RSQl9TVFNfWEZFUl9JTl9QUk9HOg0KPiArCQkJLyogQXBw
bGljYWJsZSB3aGVuIEVuZCBUcmFuc2ZlciB3aXRoIEZvcmNlUk09MCAqLw0KPiArCQljYXNlIERX
QzNfVFJCU1RTX1NFVFVQX1BFTkRJTkc6DQo+ICsJCQkvKiBDb250cm9sIGVuZHBvaW50IG9ubHkg
Ki8NCj4gKwkJY2FzZSBEV0MzX1RSQlNUU19PSzoNCj4gKwkJZGVmYXVsdDoNCj4gKwkJCXJldCA9
IDA7DQo+ICsJCQlicmVhazsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCXJldHVybiByZXQ7DQo+
ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X2VwX2NsZWFudXBfY29tcGxldGVk
X3JlcXVlc3RzKHN0cnVjdCBkd2MzX2VwICpkZXAsDQo+ICAJCWNvbnN0IHN0cnVjdCBkd2MzX2V2
ZW50X2RlcGV2dCAqZXZlbnQsIGludCBzdGF0dXMpDQo+ICB7DQo+IEBAIC0zNTY1LDIyICszNjAx
LDUxIEBAIHN0YXRpYyBib29sIGR3YzNfZ2FkZ2V0X2VuZHBvaW50X3RyYnNfY29tcGxldGUoc3Ry
dWN0IGR3YzNfZXAgKmRlcCwNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRlcC0+ZHdj
Ow0KPiAgCWJvb2wJCQlub19zdGFydGVkX3RyYiA9IHRydWU7DQo+ICsJdW5zaWduZWQgaW50CQl0
cmFuc2Zlcl9pbl9mbGlnaHQgPSAwOw0KPiArDQo+ICsJLyogSXQgaXMgcG9zc2libGUgdGhhdCB0
aGUgaW50ZXJydXB0IHRocmVhZCB3YXMgZGVsYXllZCBieQ0KPiArCSAqIHNjaGVkdWxpbmcgaW4g
dGhlIHN5c3RlbSwgYW5kIHRoZXJlZm9yIHRoZSBIVyBoYXMgYWxyZWFkeQ0KPiArCSAqIHJ1biBk
cnkuIEluIHRoYXQgY2FzZSB0aGUgbGFzdCB0cmIgaW4gdGhlIHF1ZXVlIGlzIGFscmVhZHkNCj4g
KwkgKiBoYW5kbGVkIGJ5IHRoZSBody4gQnkgY2hlY2tpbmcgdGhlIEhXTyBiaXQgd2Uga25vdyB0
byByZXN0YXJ0DQo+ICsJICogdGhlIHdob2xlIHRyYW5zZmVyLiBUaGUgY29uZGl0aW9uIHRvIGFw
cGVhciBpcyBtb3JlIGxpa2VsZWx5DQo+ICsJICogaWYgbm90IGV2ZXJ5IHRyYiBoYXMgdGhlIElP
QyBiaXQgc2V0IGFuZCB0aGVyZWZvciBkb2VzIG5vdA0KPiArCSAqIHRyaWdnZXIgdGhlIGludGVy
cnVwdCB0aHJlYWQgZmV3ZXIuDQo+ICsJICovDQo+ICsJaWYgKGRlcC0+bnVtYmVyICYmIHVzYl9l
bmRwb2ludF94ZmVyX2lzb2MoZGVwLT5lbmRwb2ludC5kZXNjKSkgew0KPiArCQlzdHJ1Y3QgZHdj
M190cmIgKnRyYjsNCj4gLQlkd2MzX2dhZGdldF9lcF9jbGVhbnVwX2NvbXBsZXRlZF9yZXF1ZXN0
cyhkZXAsIGV2ZW50LCBzdGF0dXMpOw0KPiArCQl0cmIgPSBkd2MzX2VwX3ByZXZfdHJiKGRlcCwg
ZGVwLT50cmJfZW5xdWV1ZSk7DQo+ICsJCXRyYW5zZmVyX2luX2ZsaWdodCA9IHRyYi0+Y3RybCAm
IERXQzNfVFJCX0NUUkxfSFdPOw0KPiArCX0NCj4gLQlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBf
RU5EX1RSQU5TRkVSX1BFTkRJTkcpDQo+IC0JCWdvdG8gb3V0Ow0KPiArCWlmIChzdGF0dXMgPT0g
LUVYREVWIHx8ICF0cmFuc2Zlcl9pbl9mbGlnaHQpIHsNCj4gKwkJc3RydWN0IGR3YzNfcmVxdWVz
dCAqdG1wOw0KPiArCQlzdHJ1Y3QgZHdjM19yZXF1ZXN0ICpyZXE7DQo+IC0JaWYgKCFkZXAtPmVu
ZHBvaW50LmRlc2MpDQo+IC0JCXJldHVybiBub19zdGFydGVkX3RyYjsNCj4gKwkJaWYgKCEoZGVw
LT5mbGFncyAmIERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPiArCQkJZHdjM19zdG9w
X2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUpOw0KPiAtCWlmICh1c2JfZW5kcG9pbnRf
eGZlcl9pc29jKGRlcC0+ZW5kcG9pbnQuZGVzYykgJiYNCj4gLQkJbGlzdF9lbXB0eSgmZGVwLT5z
dGFydGVkX2xpc3QpICYmDQo+IC0JCShsaXN0X2VtcHR5KCZkZXAtPnBlbmRpbmdfbGlzdCkgfHwg
c3RhdHVzID09IC1FWERFVikpDQo+IC0JCWR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoZGVwLCB0
cnVlLCB0cnVlKTsNCj4gLQllbHNlIGlmIChkd2MzX2dhZGdldF9lcF9zaG91bGRfY29udGludWUo
ZGVwKSkNCj4gLQkJaWYgKF9fZHdjM19nYWRnZXRfa2lja190cmFuc2ZlcihkZXApID09IDApDQo+
IC0JCQlub19zdGFydGVkX3RyYiA9IGZhbHNlOw0KPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUocmVxLCB0bXAsICZkZXAtPnN0YXJ0ZWRfbGlzdCwgbGlzdCkgew0KPiArCQkJZHdjM19nYWRn
ZXRfbW92ZV9jYW5jZWxsZWRfcmVxdWVzdChyZXEsDQo+ICsJCQkJCShEV0MzX1RSQl9TSVpFX1RS
QlNUUyhyZXEtPnRyYi0+c2l6ZSkgPT0gRFdDM19UUkJTVFNfTUlTU0VEX0lTT0MpID8NCj4gKwkJ
CQkJRFdDM19SRVFVRVNUX1NUQVRVU19NSVNTRURfSVNPQyA6IDApOw0KPiArCQl9DQo+ICsJfSBl
bHNlIHsNCj4gKwkJZHdjM19nYWRnZXRfZXBfY2xlYW51cF9jb21wbGV0ZWRfcmVxdWVzdHMoZGVw
LCBldmVudCwgc3RhdHVzKTsNCj4gKw0KPiArCQlpZiAoZGVwLT5mbGFncyAmIERXQzNfRVBfRU5E
X1RSQU5TRkVSX1BFTkRJTkcpDQo+ICsJCQlnb3RvIG91dDsNCj4gKw0KPiArCQlpZiAoIWRlcC0+
ZW5kcG9pbnQuZGVzYykNCj4gKwkJCXJldHVybiBub19zdGFydGVkX3RyYjsNCj4gKw0KPiArCQlp
ZiAodXNiX2VuZHBvaW50X3hmZXJfaXNvYyhkZXAtPmVuZHBvaW50LmRlc2MpICYmDQo+ICsJCQls
aXN0X2VtcHR5KCZkZXAtPnN0YXJ0ZWRfbGlzdCkgJiYgbGlzdF9lbXB0eSgmZGVwLT5wZW5kaW5n
X2xpc3QpKQ0KPiArCQkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcihkZXAsIHRydWUsIHRydWUp
Ow0KPiArCQllbHNlIGlmIChkd2MzX2dhZGdldF9lcF9zaG91bGRfY29udGludWUoZGVwKSkNCj4g
KwkJCWlmIChfX2R3YzNfZ2FkZ2V0X2tpY2tfdHJhbnNmZXIoZGVwKSA9PSAwKQ0KPiArCQkJCW5v
X3N0YXJ0ZWRfdHJiID0gZmFsc2U7DQo+ICsJfQ0KPiAgb3V0Og0KPiAgCS8qDQo+IA0KPiBJIHdp
bGwgc2VwZXJhdGUgdGhlIHdob2xlIGh1bmsgaW50byBzbWFsbGVyIGNoYW5nZXMgYW5kIHNlbmQg
YW4gdjENCj4gdGhlIG5leHQgZGF5cyB0byByZXZpZXcuDQo+IA0KDQpObywgd2Ugc2hvdWxkIG5v
dCByZXNjaGVkdWxlIGZvciBldmVyeSBtaXNzZWQtaXNvYy4gV2Ugb25seSB3YW50IHRvDQp0YXJn
ZXQgdW5kZXJydW4gY29uZGl0aW9uLg0KDQpUaGFua3MsDQpUaGluaA==

