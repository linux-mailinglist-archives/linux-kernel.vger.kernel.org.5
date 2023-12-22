Return-Path: <linux-kernel+bounces-10075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C030A81CFB7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1C61F2310B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347582F844;
	Fri, 22 Dec 2023 22:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lI3MI312";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kzAwZbzo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Qnivdgl5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA002EAFD;
	Fri, 22 Dec 2023 22:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BMK4jrD011865;
	Fri, 22 Dec 2023 14:19:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=Z6+Kb6PJUGtkNWMcIy7sSK5bnlNJRpben3O726D7HEY=; b=
	lI3MI312HkGbfC+KkuxJY+ncyvInBFVImQA/IDn/+HDFzWhwU4ZK5iHx4tpxJsze
	0T08UR+C7CmfcRAmEXdtKiJVCt+ZtmnsAkP8ITLoBzHRjUOROZtpFbHR+hBkv55y
	R7r8HwC/sFewNuSIALRRnHSxjPLQZGQVtOez8yMzxMw65Dh81gISxLnO9Wy/Rd7K
	JeUaeP3thOy03/eF8qln82GlEWzuZhQUryZr7LHh5rX2weU259FjkeVlWo1jfwtn
	w56iYngqXWL7Pun1cF/0gbUxtrDpyZZEjuiQV3puWwCjAdji/CKy8jvamEO9n2RT
	xsy7I8mL5i81gZ1QyxfoxQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3v5gpvrdk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 14:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1703283554; bh=Z6+Kb6PJUGtkNWMcIy7sSK5bnlNJRpben3O726D7HEY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=kzAwZbzoRA6W+3HcDtMiQeA5hfCXzbhDoQFu9GpQTmhQABN2f5NVqvTJM2ryhdKMM
	 WpapSYbWGBJVSBhvbB6A6MGG8eR7i0qE6mKf1ux9gkOjWk9rSVVOW/YreQOxJVZrsW
	 uUBDw2CR/9b1Uh56JHpKA0wsXjfETudSPbjbXwapBoEdoaOXFIUZpi0didYmHV6NoC
	 7XVGvjH3sLwBOPySSnq5+F6a4O0Jwcu1tAYJb5zq2ws/7Xb9FJG3gvyGyD32AZz0TN
	 li2f2uFThO041DnxavIxsa7UxHLi7m04DP2cnsGEP/DLis+2g9xZYN9JNFF6P5ySwh
	 KnnhVd6h2sqAQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 51B60401C2;
	Fri, 22 Dec 2023 22:19:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 071D3A007A;
	Fri, 22 Dec 2023 22:19:14 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Qnivdgl5;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C473B40361;
	Fri, 22 Dec 2023 22:19:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5ymtmWW/q31c04e8xIxGQCvFRUvzYk0Fyk1JrOoJ8k9iVMwzjD5yL0ywmJ6gAknVEaubAoDgfXLcu7MA3q6H1U6YM0Jp+4IOCsfJgAkk4rViTPFnhSfbLB56pLBdkZK52XmYhElflo8EXbS0nFv3XvG2fEelby1ZjgaBRtWFijDoh75GddfAAbnJAOXQd2Lbw173/rYolypHxRYa1V7Ct1OZw02Gf55Y2E+RlLhs6OISVDqnV4AYMh8ZaSOo7H4vwfqm1MurvNZxwERnGFyxZWATAcpIeaDcli3trICgxrl5QOlgw974xkMB5Zs2IhsSNjwjAEPbn1IcmKjGkhhIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6+Kb6PJUGtkNWMcIy7sSK5bnlNJRpben3O726D7HEY=;
 b=MXA1Hw/gC+TgjIJyVrE7xZfzUMsZdPaRXIUJsBnYHH+dLKPmaegKMCdv0Bky9CYEHNdfg66u6lEy2+hTqrHJYbt2TJvsc+Y/NGUr6RWi8SlcWzbKydBXHOfYmjyIaaArMhFEPlvywvGukxL/BVA9wZj3ex+iJW7GJpnEoIg4h5vCueSLwIFtkc8Js4/RJVkPI+lXSHHtwK1cHLuHHOfKABG8v+R2UdCiHcYfng/4jk1xHXmKoMFBk9NLlY5Fgcpbl/GzBrbu83hTk2R63r3aBrOOzrvJZqti+i2YFdugRPgctPIhuO8Mun9AMRsIrSa/Xgm6+eMqVFH9xKLk5fUiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6+Kb6PJUGtkNWMcIy7sSK5bnlNJRpben3O726D7HEY=;
 b=Qnivdgl59k9XVrYcXjVD2jjyiFXdxpTgqo1ZJq3f9kp30K4yqXb9eoYJpYIx1A/F3STnFngeftmEnRae1bLiCWWQOHp1z18D1zVxHk2MafPCpllUvbVFEGEkMX9SobyREwxz8J4x/Kgg+/y0MQHcz53RMh8OBxfWccDvrHRpBxo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 22:19:09 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d931:a262:ec3b:3e56%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 22:19:09 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if GEVNTCOUNT
 reads corrupt value
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if
 GEVNTCOUNT reads corrupt value
Thread-Index: AQHaNCC0mm7MoIG+aEynlStsmItJ6bC14YCA
Date: Fri, 22 Dec 2023 22:19:09 +0000
Message-ID: <20231222221907.l7s5olt6uubwfjlh@synopsys.com>
References: <20231221151620.16030-1-quic_kriskura@quicinc.com>
In-Reply-To: <20231221151620.16030-1-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: 93c64919-267c-4f7c-4d39-08dc033c04cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 cu6nrVGIJvpkASHO+teQc9a8gG8ww7dq2YKRRKnkHwfXiT5QS8FEDmGMVDdfEqrM+ndOBcegK5ItGElQMprv7/AsYGPbouBUoGwdbUvfOtY2MxaeST4P4ZkewG3xJgz2SKFYfvsVnmawjBr4tAPZCsAehkbORkYwJuDOVOsQ2FHclk8mzhMjs7pB1BvgblF6Qto5mJyHUoxTuIb4B1h2Q5DWB8g+ZIFJ12JRnqp1AHbRjSpGeqK/yvkY+/inf1bQFZxUJ0BnHTBQ8mFKxRZI/MFJCZGj7htj+it1zzz6/qLX0KLCOB0KupsYoUAv5ILAhgkwH1n377GjXz+sprotPu5Mtkt1GD4UrivM5DGYo+VLC2s7E2q0bQc+Vz8pSfczdO5izJZfD5uGGL7LkTgdDLvalMSY04ZRMFNPbQiqzP6JocYJm8cP4w1u6i4+0tJkpJlz82lJhrNcvLfsTMofB6+Uh+5JKgD+qnGe6KhkqwrI1YOp02Kw/WIDyilKTawsqmRGqpw51aNK1FZgxCqTaY1JmPdNe/hm3bPQqxzu7kn2zBLCYVunj2G7pp573Td3FTSNvoDqQ0f6f6pAMrT9LHbI/DrvNzZqFfJkKM8jESg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(91956017)(478600001)(6486002)(966005)(4326008)(38100700002)(122000001)(5660300002)(6916009)(54906003)(66476007)(66556008)(316002)(66446008)(8676002)(76116006)(64756008)(8936002)(66946007)(83380400001)(26005)(2616005)(1076003)(71200400001)(6512007)(36756003)(86362001)(2906002)(38070700009)(6506007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Mk9rWm1tbkh2YVROZGZhSVB5TjlHR0tNWTN6UUo3bENqOGF3S1IzMUtXVXY3?=
 =?utf-8?B?M1RDQTdYc0dHcEZtKzZGVXo0TjBzN3V0RWhURzN1bnQrcFJaQnJoS0g0Q25D?=
 =?utf-8?B?Szk0R3NYbWZUU3hTL2pIRHJSYmNEaVZtWTRrUlJBMFJHVEZhY3BOOGlaYXBF?=
 =?utf-8?B?WVJSYnBxMHN0MWFsaHpQSXVoT3VNS29aNFduSWd3NUl6MFN5SVpadGlDOW1W?=
 =?utf-8?B?c3UyU2lXVUVUcXVrSDJnLzJNT3lrb2IzejJ5TnFsZkVjRzdaVDZEUkNubGcx?=
 =?utf-8?B?R2FlKzY3VUNWVXRWRHBBVzdzV1V0dW9RZ0ZnVkVGQlZDck42cHR1NjM4dGZu?=
 =?utf-8?B?ZTVlNTh4NllONzhiN2hrVC9XNTY5ckpPYVlLMzRzZmZaRzBoZ0d1QXpBT2dS?=
 =?utf-8?B?TEF1blpzVFJtSVdPcmVvaE54M1RZN1F3aExhT3ZuNHg3QW1SZHlQYlE5Ykxo?=
 =?utf-8?B?QWppS3BHdEh4QXMwUjBVN1RIeGhSRW1aYUgzZ0dRZHUrSzJzWGJvcmRRTDJr?=
 =?utf-8?B?bHJDbVdOb3QxKzVrNWZ2WTVYSVJ2QUZqRStSN1ZhT2pITU5oazJOSHVKbzhC?=
 =?utf-8?B?YWZ4RFdlV0xYNlpTSllOV0J4N0Y1eXdmblBFQlgwRHFYYlhDRjFBczU0OG9I?=
 =?utf-8?B?MitnTy9xUlRBaTA0TmxGWWhsTENWWkRrdGg2NWpCOTl0Ukw3MzA5eVdMU1dK?=
 =?utf-8?B?M2krWlhvZE1CTitaM2dXQ2k4TVU2cEJXV0hsd3RQOFl3VDlMTzA0TUNydFp3?=
 =?utf-8?B?SUhqc2lWUFQxMU93T0p2eTZMU1BCb2RHTXZiVHFJeEh6TXBJOW1kTmY4TkNW?=
 =?utf-8?B?Y2VPWFdRYndWZ3daVHZtVFZ0andZd0VKVUJ3dVNnNXBmMWFuYll6bk9oR1Bv?=
 =?utf-8?B?YVNuTzNXMEk1QkkxeFZROHMySEszRFdOUEgxTWZEYjhwYjdDcnpETm9QT1R4?=
 =?utf-8?B?WGx3Mm9WdVlSTjVUc0tOaC9JQzFZTWJjc3dHV0hXS0RPaU1SOU1QM0ZHUVlC?=
 =?utf-8?B?VUZWSXh4OFFvZkV3c0xPZnpOa1hvbC9SNVdwT2pmMElWYThib1BIU1BKQWtC?=
 =?utf-8?B?UTBEemhJd1J0NGNsbko2azkwVGM0Z2ZweG9LNEJhZGVPeGw4T0RaNTBjTEZ1?=
 =?utf-8?B?VWM2RmxkVDFUZWgrcDZPUm5FRHZzaVNpVUIwcTl1Vk10TFJGR09qR3hDdFIr?=
 =?utf-8?B?eWlQVkVTRkxDTWJSbm5FZ0RISXZxUDF3NDY4TnVkS1JiRy9VUjRXVkl6dWxy?=
 =?utf-8?B?Sk1aOXdJOTR1bWliY2VyL1k3RXNqUEROVWxCQlZWOU5SZkNCVFZOWTZId1V3?=
 =?utf-8?B?S2s5bEx2OWlrZHpDWTh1a2hhbjVMaVc2MTBSTGRWQVFKRmJhdEsvclBkcFQv?=
 =?utf-8?B?Z01lTHExSlRwbTJWazI1YzlibHd4c1c3dEtiNTJ0eGdDN0J4V0R6S0VCeTV2?=
 =?utf-8?B?RiswME1lODlRRWhGdktWVlZuZTRNdjNscVYwcUZXTjRlWkJxbXZGZk8zb0dW?=
 =?utf-8?B?UktYckxlS095ZFhiWGRTWTVpYWE3UmJEcXlPemRwbUQvMENVZFYzbTBrU1kw?=
 =?utf-8?B?UWNSSTg1UndJS0srOGE2cnJ6dUNockpoS2Q5b3NWTHU1Uk4vL2d1SEhDdWpz?=
 =?utf-8?B?VVl1RjdFZ1dudXJ4TWZwVGg2ZmxBYTJGNit2TFpPY0hsMm51b0gyQytjMmtN?=
 =?utf-8?B?Y2tVVks3bVo3S1JMSHIyTVgyZHNVL2h3dnRaN0pKNWxTR1JRQ3VYN2FKbGpn?=
 =?utf-8?B?Rmw0OXBYc2NkZEF2UXdSUWloRjJTNHNQVEl4elI3bnZVWkU4VXdkd0tIS1Zn?=
 =?utf-8?B?QXh6ZHpacWxBdjZkN3VpSmRaVDNHSXVoN21XY2pGeXBzNHdBVG8yQlUwUHcy?=
 =?utf-8?B?QzBKV3lPZVN6QzRqUXFDYTFOTjBONXpJMFVEbnVWWUdDU3gwNWxTUGZJa09Z?=
 =?utf-8?B?TUNmVWRQS2N4aHJIUWpXSU5tOFBtbUJxM1FoM1lYL2M1SUk0aFFFSURiYnJr?=
 =?utf-8?B?a2ZTb2tSWVRrdWkwT3M5ZStDWm5wK0Z4aDZ1c1hRSjh2RzZ5ZGs2SVR2bzdl?=
 =?utf-8?B?bUhvbU1aTzNxd2dCRGxKWkdHdFFlWTNmU3M3UkZNaUp5SFdlT0xneGx4Rmpj?=
 =?utf-8?Q?s3uWSdWPOVx27bxREoRMPr8EJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52F8B694496EC749AB99F47BBB4F0081@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wthmwApYyI1Mhf5pAFCuhniMsSWZtYPQXkjnTVOdqGR2C4I+dgES97vW92BF5AzIN0fkPzTAI6k/vd7huoy2ZwAYnBAly9T/f65gKujXZq3uqxuyEpqBWTatmpU86GCY3O2sXZsTvY+bsgyTGXrwVe4MaCxJWbqJ782WWWtWathYOteXN6Xr3GJG2yWBodfebC/eTxbRukkHQJz5Ewlrv3gbseT4WMHIBTVg1LeWCufqhBaOIMrxDruv66JBushMIVz1iDgJB7emEzHwChg2KPSC878Uq+4HcAOZl1JREao2QAvT/kdmmCyJXeJKxwek7tWvkPj/4rcEfroVT9QIBcBEt98clPT6mbuEJ2JyynqA6it5M3FOfdycy3TmQ42w+G2qasGmHtFygnhZviq9Fi3nEuTIDSv2y98EGBkNe1DKUfuuY8wupj/2rjFZH31SIxPaSJY51HLhNVJb49S5YT/sXKd7seB9oi1wdPJwn768Ft1+q2ofXg0DeLJ8hovG4WqhjtCnRohcERk4rZHzhFjri/kZAEfZUZlLoY4RxCFb9W2a1oweKdT1ztg7ao4BANbTiaK5xL0E/N1G4wSQYb0+3APB7Sx4N1Nj3TfXHdWucz16cPxkX9BWyOP9vLRxJcbyxUx9Thf596enGh4V8Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c64919-267c-4f7c-4d39-08dc033c04cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 22:19:09.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9Y9GgjpOKHiSBU2GDqBRu/a7UOQ+pwia7vEHYOYymKdAT3cpikwcdpGgKoOxUZ9F9T3LnL+40OVJ2TWJobNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
X-Proofpoint-ORIG-GUID: riG7G_M99t-EBWYoWc3hknp1zluoMSs-
X-Proofpoint-GUID: riG7G_M99t-EBWYoWc3hknp1zluoMSs-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 mlxlogscore=805
 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312220164

T24gVGh1LCBEZWMgMjEsIDIwMjMsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEluIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uLCB0aGUgY2hlY2tfZXZlbnRfYnVmIGNhbGwgcmVhZHMgdGhl
DQo+IEdFVk5UQ09VTlQgcmVnaXN0ZXIgdG8gZGV0ZXJtaW5lIHRoZSBhbW91bnQgb2YgZXZlbnQg
ZGF0YSBnZW5lcmF0ZWQNCj4gYW5kIGNvcGllcyBpdCBmcm9tIGV2LT5idWYgdG8gZXYtPmNhY2hl
IGFmdGVyIG1hc2tpbmcgaW50ZXJydXB0Lg0KPiANCj4gRHVyaW5nIGNvcHkgaWYgdGhlIGFtb3Vu
dCBvZiBkYXRhIHRvIGJlIGNvcGllZCBpcyBtb3JlIHRoYW4NCj4gKGxlbmd0aCAtIGxwb3MpLCB3
ZSBmaWxsIHRoZSBldi0+Y2FjaGUgdGlsbCB0aGUgZW5kIG9mIDQwOTYgYnl0ZQ0KPiBidWZmZXIg
YWxsb2NhdGVkIGFuZCB0aGVuIHN0YXJ0IGZpbGxpbmcgZnJvbSB0aGUgdG9wIChscG9zID0gMCku
DQo+IA0KPiBJbiBvbmUgaW5zdGFuY2Ugb2YgU01NVSBjcmFzaCBpdCBpcyBvYnNlcnZlZCB0aGF0
IEdFVk5UQ09VTlQgcmVnaXN0ZXINCj4gcmVhZHMgbW9yZSB0aGFuIDQwOTYgYnl0ZXM6DQo+IA0K
PiBkd2MzX3JlYWRsICAgYmFzZT0weGZmZmZmZmMwMDkxZGMwMDAgIG9mZnNldD01MDE4OCAgdmFs
dWU9NjM0ODgNCj4gDQo+IChvZmZzZXQgPSA1MDE4OCAtPiAweEM0MEMpICAtPiByZWFkcyA2MzQ4
OCBieXRlcw0KPiANCj4gQXMgcGVyIGNyYXNoIGR1bXA6DQo+IGR3Yy0+bHBvcyA9IDIwNTYNCj4g
DQo+IGFuZCBldnQtPmJ1ZiBpcyBhdCAweEZGRkZGRkMwMDkxODUwMDAgYW5kIHRoZSBjcmFzaCBp
cyBhdA0KPiAweEZGRkZGRkMwMDkxODYwMDAuIFRoZSBkaWZmIHdoaWNoIGlzIGV4YWN0bHkgMHgx
MDAwIGJ5dGVzLg0KPiANCj4gV2UgZmlyc3QgbWVtY3B5IDIwNDAgYnl0ZXMgZnJvbSAoYnVmICsg
bHBvcykgdG8gKGJ1ZiArIDB4MTAwMCkuDQo+IA0KPiBBbmQgdGhlbiB3ZSBjb3B5IHRoZSByZXN0
IG9mIHRoZSBkYXRhICg2NDM4OCAtIDIwNDApIGZyb20gYmVnaW5uaW5nDQo+IG9mIGR3Yy0+ZXZf
YnVmLiBXaGlsZSBkb2luZyBzbyB3ZSBnbyBiZXlvbmQgYm91bmRzIGFzIHdlIGFyZSB0cnlpbmcN
Cj4gdG8gbWVtY3B5IDYyMzQ4IGJ5dGVzIGludG8gYSA0SyBidWZmZXIgcmVzdWx0aW5nIGluIGNy
YXNoLg0KPiANCj4gRml4IHRoaXMgYnkgaWdub3JpbmcgdGhlIGludGVycnVwdCB3aGVuIEdFVk5U
Q09VTlQgcmVnaXN0ZXIgcmVhZHMgYQ0KPiB2YWx1ZSBtb3JlIHRoYW4gdGhlIGV2ZW50IHJpbmcg
YWxsb2NhdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19r
cmlza3VyYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IEluc3RlYWQg
b2YgZml4aW5nIGFtb3VudCBvZiBkYXRhIGJlaW5nIGNvcGllZCBmcm9tIHJpbmcsIGlnbm9yZWQN
Cj4gdGhlIGludGVycnVwdCB3aGVuIGNvdW50IGlzIGNvcnJ1cHQgYXMgcGVyIHN1Z2dlc3Rpb24g
ZnJvbSBUaGluaC4NCj4gDQo+IExpbmsgdG8gdjE6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA1MjExMDAzMzAuMjI0NzgtMS1x
dWljX2tyaXNrdXJhQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFld00zdTlQZGs4eUQ5ZVUy
NHNPdVFxbWhtOE0yVnBHWEg4ekFMcVZXR0tmZkdiY0p4cnR5S0tsVVB1aDhTUzJhcnFPMDlEam5D
OWF0QzNiZW1FcHgtZzVVUU1sbGJBJCANCj4gDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
IHwgMTAgKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDg1OGZlNGMyOTliNy4uZTI3OTMz
ZmRjY2UzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTQ0NTEsNiArNDQ1MSw3IEBAIHN0YXRp
YyBpcnFyZXR1cm5fdCBkd2MzX3RocmVhZF9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX2V2dCkN
Cj4gIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1ZihzdHJ1Y3QgZHdjM19l
dmVudF9idWZmZXIgKmV2dCkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMyAqZHdjID0gZXZ0LT5kd2M7
DQo+ICsJaW50IHJldCA9IElSUV9XQUtFX1RIUkVBRDsNCg0KaXJxcmV0dXJuX3QgaW5zdGVhZCBv
ZiBpbnQ/DQoNCj4gIAl1MzIgYW1vdW50Ow0KPiAgCXUzMiBjb3VudDsNCj4gIA0KPiBAQCAtNDQ4
MCw2ICs0NDgxLDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1Zihz
dHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gIAlpZiAoIWNvdW50KQ0KPiAgCQlyZXR1
cm4gSVJRX05PTkU7DQo+ICANCj4gKwlpZiAoY291bnQgPiBldnQtPmxlbmd0aCkgew0KPiArCQlk
ZXZfZXJyKGR3Yy0+ZGV2LCAiR0VWVENPVU5UIGNvcnJ1cHRcbiIpOw0KPiArCQlyZXQgPSBJUlFf
Tk9ORTsNCj4gKwkJZ290byBkb25lOw0KPiArCX0NCj4gKw0KPiAgCWV2dC0+Y291bnQgPSBjb3Vu
dDsNCj4gIAlldnQtPmZsYWdzIHw9IERXQzNfRVZFTlRfUEVORElORzsNCj4gIA0KPiBAQCAtNDQ5
Myw5ICs0NTAwLDEwIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1Zihz
dHJ1Y3QgZHdjM19ldmVudF9idWZmZXIgKmV2dCkNCj4gIAlpZiAoYW1vdW50IDwgY291bnQpDQo+
ICAJCW1lbWNweShldnQtPmNhY2hlLCBldnQtPmJ1ZiwgY291bnQgLSBhbW91bnQpOw0KPiAgDQo+
ICtkb25lOg0KPiAgCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENPVU5UKDApLCBj
b3VudCk7DQoNCkRvbid0IHVwZGF0ZSB0aGUgR0VWTlRDT1VOVCBpZiB0aGUgcmVhZCBpcyBpbnZh
bGlkLiBXZSdyZSBub3QgcHJvY2Vzc2luZw0KYW55IGV2ZW50LCBzbyB3ZSBzaG91bGQgbm90IHdy
aXRlIGJhY2sgdGhlICJjb3VudCIgdGhhdCB3ZSBkaWQgbm90DQpwcm9jZXNzLg0KDQo+ICANCj4g
LQlyZXR1cm4gSVJRX1dBS0VfVEhSRUFEOw0KPiArCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4g
IHN0YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpfZXZ0KQ0K
PiAtLSANCj4gMi40Mi4wDQo+IA0KDQpUaGFua3MsDQpUaGluaA==

