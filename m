Return-Path: <linux-kernel+bounces-58885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7132C84EE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28298283E6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2416B51C21;
	Thu,  8 Feb 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hxrhew4P";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M1Ba6GVs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qbPS4u3G"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09450A64;
	Thu,  8 Feb 2024 23:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707436582; cv=fail; b=qSCBQlnxyiJLV463FsfMapKbzKaBvrSAa3TppI96rauQKmTBZXJjJ90vATQBKa6oyDewaJFHgmB0M9T8iAWIukC4Exzsr28vuJFFT4YJLS9WtzrQZcJjrTjXDGF3paFClwijO119wjWyriyB5kri2V3xzaopKP/4cu8VvoXqflk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707436582; c=relaxed/simple;
	bh=Du4rPaen5vXxjDRMS2B71nTsEJTtGHyXwFEnwldoNWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L229kQpI/iQUP2U2uS5ZlT2oCiX+0Wp05lo6dU8zaXTEVmut1JtJn6jpzx2uLDKn9R3nMCm2/sWK+b0vf3ZwMC8Or6zlk1QHXu+6aKg27Jx4HLCDY00yGYaHjFD9+iZJtBkzTApBDjSKpcUYrz9evO/08kvBbxXATC/9M8og3vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Hxrhew4P; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=M1Ba6GVs; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qbPS4u3G reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418NBLoQ013115;
	Thu, 8 Feb 2024 15:56:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Du4rPaen5vXxjDRMS2B71nTsEJTtGHyXwFEnwldoNWE=; b=
	Hxrhew4Pvzf05tHtX+/6pxDfOxJVnJDjkZlaZKbBZOHbbsnnetuCOMeZbGw/JiOJ
	VHMF/Wfobib6I0kWY1GaB+vxOgh+IT8WST+bEmxStHotsmLMnn8qC0TQ1Nzt9266
	NNST2EPSRDmCDOfx+Vu/MkpA+GYPOWasuZzEv8gP+Meu6ECagOSquDdPbAdDkXfb
	+kYhkIOlz3WNwtWO77hXstmUzVECtHMHxC+xWXEeATbsuLMEV1d7JjfQczOFpATH
	0ZNMpZM0jIyYh7QdCdgjVai1CIy+aSUKZTWgD6r0Mcmaxz+lLThrUB++KFKF8cZe
	8lmo6X/mWFsxfcWKO+Koxw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3w1n0gs39y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 15:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1707436574; bh=Du4rPaen5vXxjDRMS2B71nTsEJTtGHyXwFEnwldoNWE=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=M1Ba6GVsCLCB/yEVpHnX9WWqaRzn58k/f7yr8KK1yTL/lv/Gd3V6+bYC2NMEe5i57
	 fOs+BIAeSMxcLmr4GjmV7nBeOiON7pujyhVPqFjfLR3S21kzRmxVR8DMcaRBtf5mU7
	 fCF6oU7RupLUJRuzhkJdVT+zuxdIlF22h/pDaY9o6Uwq4lwx7WQc0ab4n//LuOskPd
	 NA4BjeknEXq3ECwgf+7OMLoH1PwtQiuYP3YVAse/JjNtiKi3VMeQnhc4nOH7LD83wv
	 JDc0TSlIk30c4EwqSdL2RE7vTu1jjjLlXfTJZ88xoGKjUITAFAmYMGBpfbYX7gcovU
	 yZClgS6u23qIQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 59C7640362;
	Thu,  8 Feb 2024 23:56:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id C477FA0091;
	Thu,  8 Feb 2024 23:56:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=qbPS4u3G;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 7F8064035E;
	Thu,  8 Feb 2024 23:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVPZ1CKF1D1WZ7X5YD/VboXJPme/JeTzaJP8MVVl7ZhhXXMHJbfUb35VdKlxysmn/BM6gqbm8Kuy956vx0nt/z/ounYFYjvV3BP5xVUiz5hROqKzaDAA7NSM9rMey4bQo4U+f3TBAVYRTeqa6M1pkg8+Y2xHII2zWteq+HvP73fwD4QB8utEVFkK9HeHKXnZIhMnmxExszPd2IXTTay2TlthxV7ZeV+yWymKUEXnTq1iphg7xTaGvIQ7+BD97Egf7JHoGNJz9ouyR0jt90jKLeQ8TKKLOR9lMeTDpyhGahCoQ+dWx4xUfd0Ljr1l6QCbDg/9iEE4AQRhufU8o4+eWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du4rPaen5vXxjDRMS2B71nTsEJTtGHyXwFEnwldoNWE=;
 b=K+7Pg1SwloJWJgYL/R2cuRyMFFgEHAkVz9vdYLGBow6+CBnXaO6/qobcvpBuoh3oBY3MsJNKRd60Wv5OdD0dDx4qL96sd0fGiDxOI404gFm0PJHzwWDpPywkw6HU1YxUCwhM1QwAAWlduOhSBL6A+araWWufdOn4vNrmFvtiAyEgeZscNeMJknM8clTK6kaQrc3ip3NGdIqSR7oi6UH3uB+Kv5mv/LfW7L4FOoou5Fz9MOtkKiFppX8wYwFvUoFWBiJmaEUW7FdpNqo16Sma/vqSXJDk+r4+12zv9wk30F2g82BQ5kJgvKTxKu/tSEGub7GA6GwtEuxL7ignvN8mng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du4rPaen5vXxjDRMS2B71nTsEJTtGHyXwFEnwldoNWE=;
 b=qbPS4u3GQkw8gYUKAT3RB5q+o8Z/OpButR/wbrYETgX68iOvL9qcmR+hf7dzP8JngU+O8rvogZ4rTn2UsuopCgX9pUKTx7EKV/WRhA0K1DSbIUIfyOUfz14AUQeKG+FmOeazawuuoDdXaVggQo+B+OT1tDoP3HlpuMO+ev5W0rg=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Thu, 8 Feb
 2024 23:56:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 8 Feb 2024
 23:56:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Colin Ian King <colin.i.king@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] usb: dwc3: gadget: Remove redundant assignment to
 pointer trb
Thread-Topic: [PATCH][next] usb: dwc3: gadget: Remove redundant assignment to
 pointer trb
Thread-Index: AQHaWb2qJN8biOchBUCcNc4B6ULYq7EBISSA
Date: Thu, 8 Feb 2024 23:56:09 +0000
Message-ID: <20240208235537.7wyyvk6dzim5u6fh@synopsys.com>
References: <20240207120319.2445123-1-colin.i.king@gmail.com>
In-Reply-To: <20240207120319.2445123-1-colin.i.king@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6102:EE_
x-ms-office365-filtering-correlation-id: 8cc2f378-0ec2-45f4-1fe0-08dc290185e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /soMRPv4XuQAIhDDAxbnX6RFIMc3vJUY0gdgzu92jGpX8r8OmwgKTfSzvC2aBOAr4rt8YfJXhWfFBaW5OE2CfdbU+Kh0fmq6fHAV7u0ASc7enShZPJrYDm2i286Ycht/rqco0pqr5NCVLZCtfKNCr26I1/fTQryDyMJuxXJkR6NLBSWWTXw4MW/nEnPt6Ag/OA9zS52SdFGtrMpt/68UyR3hzXgpUbSTVsp1p6+F/5OM3Fdzyj6N4mJj/Dp816VarnDET8W63HRdbZY1r5TPOYJZM0TOFh5gFvpOnQDk9m7EQGo/B+TCUJInPUR2lKQg9khaun6UosTWtO0XkJOB2q5wnScLiwL9SfX2cDCx0z3edprw0Ko6bYg01gx2W1hBYFUyQS4fe4pjxUmURZnWsiOVPWtCUOeowAXBhc+mkXDcjNjNY67ONKZ6OpP2T5/0LhG7w1dZEQDf5Mia7MdxiFJuPSvbGYgfWtq3Z4/PQk2JmRzMweJZ9qfTABS8+aPaLBOYq+GzliiH+zxH8+1hqCR8NU0CKAVRQD4vtp+n0kMu5mvDraztuudCF0viexXgwzhEAgL6UtS3m1FquMJlVvnZRRpmlpWXFzyqBkqBYe2VHfKVUjlNsoEGca1tfxd0
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(76116006)(478600001)(8936002)(6512007)(4326008)(71200400001)(1076003)(26005)(86362001)(83380400001)(64756008)(66476007)(36756003)(54906003)(38100700002)(6916009)(2616005)(122000001)(66446008)(41300700001)(8676002)(38070700009)(66946007)(6486002)(6506007)(66556008)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aTA5dzlSUXpjK0NYdVFrTmdvZ2liSmNNSlA4WnhRQ0thdXhtTE1xTDNvMjh5?=
 =?utf-8?B?bFNCOUpHWnlWeFRQbHFONytYU0wzZ2NmMDJXU2t1WXBYWklUc1kwYnZZNElN?=
 =?utf-8?B?bTZEMUw3UHVYajVGcys5S2hRV2wxMWxQMXJuMnhXNi9HRC9OcC9oTERETktP?=
 =?utf-8?B?SkIrU1BRYmNkN3RwRkpLZkJwV3AzaWdDUmM3MHNSQWcyRGRCRG9VdzhJSU5I?=
 =?utf-8?B?NDlIdXNZNjNpazhUaUxDaFlFbzd0MUdzTWZRZ0RQVFZmd0VQYzdnYVJiTGRU?=
 =?utf-8?B?MU5aYTV4TE1iQ1I2MkhxNkdWbzNGcW1WMmY3WGZicmE3cmt6M2lYeXprT2hk?=
 =?utf-8?B?clBrQzkwSGZIQVRZTkpXOGNuUjYvZzVXempxMnkrUVZvcmVqZ0xIMkdYNXVS?=
 =?utf-8?B?WER6UVVPMWdGQkh6Mi9jbGprOVd6eFZielQ5cHNTczN6ZTlWRVAyNW9Ya2Fa?=
 =?utf-8?B?aUZjbjNSY0RkUmUwU2h1Vmt1L0JBRE9OZ0E5NG54ck40U2pMNmdkSHRYK29S?=
 =?utf-8?B?cTM1MjhwZmhtdkFrN0RqSy9sRDdodU9LcFIvcFl4eUtNamZGOURXcWVvZEFm?=
 =?utf-8?B?cXNhamZSTVFzMWh1UmdDUFEvR0Npei9FekpCazVTODNaRE9lZWlaS00yWFNC?=
 =?utf-8?B?Tm1McUZTZllTZnMwNy85NmlISzlVRkFqU2dnbm1zZU9PK29pdnJRdmhqMGoy?=
 =?utf-8?B?Ny9FSG11Z1FMdytwRXczVVRzMlYvblA3YzkySzRyd1JrNTlRcENJUW45YWlC?=
 =?utf-8?B?T0VzaUU3Q0UvQTViRDhlcWNEQUNQTW4waXFNaFJpczVPeEZmbmZPcmNJM3Vs?=
 =?utf-8?B?b25sdXozMUp5dTREOHlCMitteWo3OWdzVzVYOTFUb1ZmbWE3N2VDSExRNXds?=
 =?utf-8?B?SitvK1g5elJTMkQvTVA2YnJMUGpiYkx3UUVES3JiR3NldCtEKzBTOVlYL2Vp?=
 =?utf-8?B?MVM2L0dlK0g3WFhMTHYvTzFHdlR6OGtvdEYxY005ZHVZN0hTSTAveUp1Z3Zy?=
 =?utf-8?B?NzFuTmo1SzljTWNhL2tWaHBZV2NNTVBRTHJyUWVXeGtpL1YrdUFZRlN0dnB4?=
 =?utf-8?B?ZzBCZElmRmRuakhQQTR4bVhkeFpKNVFJdlNBQ3laUkJQMUlQTWpZNnN6RGxj?=
 =?utf-8?B?bHZqd1JMc2xjTWhXM2VaaDFVNlZPTXVPUEFNMjVCSTlzNUZ2aE5iM2dDNUl0?=
 =?utf-8?B?UCtLYVVJNFovVEJlVk1KK2VINnlwYkNIS0dOU2pQQ0NJRGp3WHN0RGx6ejZv?=
 =?utf-8?B?cHhkc3grS2IvTUZnV1Q2RUZlY3dibXZiMjZ4ZGp3U3ZNbENPd3A3UENKUUFk?=
 =?utf-8?B?a3B0RGZiVDYyL0k0YXpyeUlFUmdoMDlmMDEzSm1aMy9PS1VxRVhqZXM3eVcv?=
 =?utf-8?B?U2lxSkUwMnRTbmw5VEtqbkxLUjByc2tYbDF5LzYzZVljVjQ4RElzc2dtYnVT?=
 =?utf-8?B?OERIdEZ0RUpkMGNTQkxWVFVIaVRRNlBPVGM4UHUralErOVI3QS9hckQ3WnEr?=
 =?utf-8?B?NUpLWjI3WnV5MlA5V2hkY2duaGlZc210TTVLOVlKeVUvSkdmcEwwWERKTGc4?=
 =?utf-8?B?dTcraVZXN2lZU1A4VElRWEp5bDgzdHRLZTh0UmE4S0IvbGlENWVGZ1lxd1JN?=
 =?utf-8?B?L2FQd21UdGpZRmRCbHR5RXNsZFlNdit3WXlQMjZ2UlNRMFNRTlA2L2dMcVd6?=
 =?utf-8?B?bTJXRXJSUWVXWXI4bVd6RTZnUjl4U1pPeTZJWnEwZnlSOGQxY0lONEMyYUtr?=
 =?utf-8?B?TUNzOXNuWjBtMmR2bFNJN04vS1BYRUZTVUhwVmswU0NGWW9aODNjdFVTSXlF?=
 =?utf-8?B?YXcrSlhhKzIwRjlXV1J3WjZ2NW9lQS9JSTJtSDNmdHc2blF5TnpUYTVZaGpU?=
 =?utf-8?B?NFdjOHZuNzB3QzFabEoyZXNOOFo5bHRveFc1eGhDcFlCM3JobW05V0NnQUVj?=
 =?utf-8?B?OE5sNU5SVnVPUjlpZG1nZ0FNSkl5NFhHQWRCNDBVcG5tTDBvaWFyVHpUNHB2?=
 =?utf-8?B?WFhLek1yYnRXY25uYU16bG1qNXN6bmdJcWpJRkF5VzlXQnV1S2ppNjZ2MnA2?=
 =?utf-8?B?S0QyZ1drUm5hUWQrMStTWm8xWnduVVc5SGJ4SE1XY1djL3p3N2RLOU1vNFRF?=
 =?utf-8?Q?UpHV2LLVL8OPP2bY+U2nSBA2j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D023E244D9B24384FE9016363E8442@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jtkLaOMtDwLOnjeLK+LIamAM8mgMCbZVEPcAsX8w7Jjy7iVcEPN/gcv/4Qdf1+naedqJvnYtmtsvK++p8xbaDClM8KJ9VR2Bqhai8N6iH1PJhzQ+obnrGrOe77SXPAZmCTtGk6XKiMT2A/UvI/XINdkEBlyFfqx4iuO2GGV2tUdpI086TzLlWz3SU+XXXpErExbxCqLqrcO3vdJGO63NruZeZWHxp1gSV17xnCOouQhgGDDXV9CUZ7oMj3ANOOSzKMcFMxb8R2OP0Ur9alm0aXVNORxWDfyxtb1FRkpVBfWAXKMdAq2anbMqd1YtZmd5JZ0k3vU689qo4FdFQpcxwNBZTeKb1//h4ZHAHPD/pPaY11ztogU6PM7EJGE2TN8DLHWenOh29BEY1Gp5/MWFPHax0Wo8H6UiTtJ+MaHgWDzsBs1qw3E8bOrG0P1g6J+BbyPKki+Ad+6ssZmT3ehMAE7l0lhKe7LNfjAt+7d29tJTIpuqsZCtzm8hEzy+PurfEepKe3BVuUJmkSizqd9HDGxzVnqwipKNY13kZ7DQ6GUaFQu/0Gawdkg3yddnZx6HmxPTl2smGVextUtuUlXG2Z7X6tP5hH/PelF1t3ZTLLSEiobQXsPY81EP8y/6j5DkjufuLDH71Ee7eOt+0xC8gA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc2f378-0ec2-45f4-1fe0-08dc290185e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 23:56:09.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiYH+qI5neA8P7jWZ5Cbqp8KDfL486fbSNymnNNz6g91LRvbpelvuvqqwgSzmCGDR6H522zu6OL1jnC01JwQsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
X-Proofpoint-ORIG-GUID: TQH_s8Q9wR7QTs7yHlCkUOXKKzz2rels
X-Proofpoint-GUID: TQH_s8Q9wR7QTs7yHlCkUOXKKzz2rels
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_12,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1011 spamscore=0
 bulkscore=0 mlxlogscore=962 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402080137

T24gV2VkLCBGZWIgMDcsIDIwMjQsIENvbGluIElhbiBLaW5nIHdyb3RlOg0KPiBUaGUgcG9pbnRl
ciB0cmIgaXMgYmVpbmcgYXNzaWduZWQgYSB2YWx1ZSB0aGF0IGlzIG5vdCBiZWluZw0KPiByZWFk
IGFmdGVyd2FyZHMsIGl0IGlzIGJlaW5nIHJlLWFzc2lnbmVkIGxhdGVyIGluc2lkZSBhIGZvcl9l
YWNoX3NnDQo+IGxvb3AuIFRoZSBhc3NpZ25tZW50IGlzIHJlZHVuZGFudCBhbmQgY2FuIGJlIHJl
bW92ZWQuDQo+IA0KPiBDbGVhbnMgdXAgY2xhbmcgc2NhbiB3YXJuaW5nOg0KPiBkcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jOjM0MzI6MTk6IHdhcm5pbmc6IFZhbHVlIHN0b3JlZCB0byAndHJiJw0K
PiBkdXJpbmcgaXRzIGluaXRpYWxpemF0aW9uIGlzIG5ldmVyIHJlYWQgW2RlYWRjb2RlLkRlYWRT
dG9yZXNdDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5n
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
Z2FkZ2V0LmMNCj4gaW5kZXggNTY0OTc2YjNlMmI5Li42ZTQ3MjU5ZjJjNGYgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9n
YWRnZXQuYw0KPiBAQCAtMzQyOSw3ICszNDI5LDcgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9l
cF9yZWNsYWltX3RyYl9zZyhzdHJ1Y3QgZHdjM19lcCAqZGVwLA0KPiAgCQlzdHJ1Y3QgZHdjM19y
ZXF1ZXN0ICpyZXEsIGNvbnN0IHN0cnVjdCBkd2MzX2V2ZW50X2RlcGV2dCAqZXZlbnQsDQo+ICAJ
CWludCBzdGF0dXMpDQo+ICB7DQo+IC0Jc3RydWN0IGR3YzNfdHJiICp0cmIgPSAmZGVwLT50cmJf
cG9vbFtkZXAtPnRyYl9kZXF1ZXVlXTsNCj4gKwlzdHJ1Y3QgZHdjM190cmIgKnRyYjsNCj4gIAlz
dHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnID0gcmVxLT5zZzsNCj4gIAlzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KnM7DQo+ICAJdW5zaWduZWQgaW50IG51bV9xdWV1ZWQgPSByZXEtPm51bV9xdWV1ZWRfc2dzOw0K
PiAtLSANCj4gMi4zOS4yDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5
ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGluaA==

