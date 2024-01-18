Return-Path: <linux-kernel+bounces-29603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264678310AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946461F242BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6821C2F;
	Thu, 18 Jan 2024 00:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ForH7Xfc";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AJRSjt21";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PnHXvHdZ"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69E20FB;
	Thu, 18 Jan 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539419; cv=fail; b=YW/rYrzPYfrzE8SAW1xxRB+tb+iPis38EfMVRUP32wEZpOlV6p6S+uadHvMSbpesPqccyjJ+H0OJoC2Cz4iLl0KJqyUTw4VWLZ16F6G3nxJ6Dun2zkizqbJEIZmPsfLKTa+lteEPS5TCDJOYk3eYnFkaNzytchf5k2VuzOXZfdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539419; c=relaxed/simple;
	bh=3LQiCHQ9+PMsaueVf0QrZSEsDqOcfcJ9m4h7AEaUC/M=;
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
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=mrUTH6NPSmu1cVIweQgZygY2e8ukFIT/nVaFwUNxiXBIogypAh8Dl+FNp6OOJ0gkWBxRXXTOpeYoTwTi96OAnFJUAyQtR6EsKRKs2UMCjnvd9YijPwO35xHJwMQjEMNQDoO2DnPrFwxQY8MU/LUNKEY/SEgXKztna5qPBHmT60I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ForH7Xfc; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AJRSjt21; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=PnHXvHdZ reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40HJ4JsO014745;
	Wed, 17 Jan 2024 16:56:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=3LQiCHQ9+PMsaueVf0QrZSEsDqOcfcJ9m4h7AEaUC/M=; b=
	ForH7Xfc/vBJQOVbd+TRdBPZFxD93JM3sVI7T+GJLMDqwlMuz5LvrxC38OVqmUUM
	fMUf8yrkyKit4ZnzWVz4qFORIAyiDD1hx9w5Pi8djSJOPrg/UmjKDEidOyrWnxWE
	ymHUeJkCNPXhzi/FzTW0BjgdHY4uNfHMEVF3qbGOQw981IA2J/NZkiVO2iUVVRk7
	7MyUzl0G251gerN6kU0VLkT+r51/qGQjeJKoNj6oX4LNRjqKxZNNYD1aywl7TJrE
	QlrZo0hp02jywZOlM2J0sMWoEm89ywvWY2x4nNCSjbiYpjAHZC758vlMi6Lrrp23
	tPYB1Ww0RQyqy90YtD2mhg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktdnmreu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 16:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705539409; bh=3LQiCHQ9+PMsaueVf0QrZSEsDqOcfcJ9m4h7AEaUC/M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=AJRSjt21dZzW0/F2eJakSmDLDTqgcOuTPUHlwQz+Qc4S0ArznXRxJrF6/1SYTsmJ/
	 PR57i9puNlJDK3kuna9BtsdHOnNG+wmq3lIn8Uox8d7sDY0wCLHeW64/1TVqa7ivAr
	 agKOaWsoGICpp2JiysZWJCSor8zOGi5j1yi46XFqe0EaIqlYs0mW5u5N0vD0dhKeYe
	 xuD1KULvA2i7F3WB7fR6hOAi79AtGRxgPv8lj6VIBPrNa9zWscUA1xnhveJ8sQKFqi
	 vDLZs9+z1yuW/3XbVo28ZC7L3kb8VKFZxv/CO4tzDk+CRLl0RqHJQWgfCThS7NX6b1
	 q1q9LpsGbg+uA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C2854035D;
	Thu, 18 Jan 2024 00:56:49 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 09330A00A2;
	Thu, 18 Jan 2024 00:56:49 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=PnHXvHdZ;
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id C71BB40138;
	Thu, 18 Jan 2024 00:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBO0dICO/3Ay4o/IbYXUQ1yNATsAQGB7vwwTsy7gm1xrHQP2IQg7lfgwv8rS/Q+NvBX/xclK4mAjmlB/PWdVdos0R08I3ZSncbD7HZM2GisyjnjTdP+I5BFZPNQdhua1qcWOCgFVj5djk2x4BX8SAgdzZi5XNOvFPZ8bbYqAFB3TpuWzbMyqhvZhu4i00wCc7pGA3hPG6blh6FBxdtwrLl2vb7/eGPEmX603Slhux6vIDyiO+qktRPx20eVKekmPB/l0Y8KsP3+xHInrRGcrj3pJLQKyWLxJ5L53iWfU8keSnjwM5yDLu++pwzOHUFcWwNPhIbwQV65BeRzRjbqRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LQiCHQ9+PMsaueVf0QrZSEsDqOcfcJ9m4h7AEaUC/M=;
 b=GyM6JjvKYlBHyienz/2TR6LNHUkl9rpUzzU2xW6hS2ix2jD8K3rC73Py+f3UIQE7dVDeUDeR21AKsgchMwq6xHacvnIZNNz3w28soGXzmg9KhyO9NDTVzCzWiwFFs9J1s4YTM7fVXdBNBhaCW5fyH015H0dGBuBJX/FhyPu6WTO6Jxx594oJXnxpI32Huzv6rF5qX93qAn5EAgQkqzA4B1upG1wC481xR5lMKT/8QO4kcBPAsJpbUv0/P/48c429tj2zze6bHdYPszqOE6vQOSTcfIs9SKZpi9v1cNXcaTOnM7HnBWDF1EnhO25p3MxzYlb3NERhbw/TMQ7n+QpMVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LQiCHQ9+PMsaueVf0QrZSEsDqOcfcJ9m4h7AEaUC/M=;
 b=PnHXvHdZ+eHsq6k5ykCg7fojrP5agPZU8n+9Rfe9t5sDgtcGfgZQsK+r7Y8qX7W019l9pp0pJM2NW7IdI0kf58YatnuTlzvpjiaYTwqucmznbAmjDQNFrGSyctkqxAMuNtNGD1WARl5hI8xeNoHoV93JkxQSF8mYWiNk+SAkFNc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 00:56:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 00:56:43 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
CC: Kuen-Han Tsai <khtsai@google.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Topic: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Index: AQHaQ6tPP1s5O3H+ik2KO8Fm7lDy17Ddoz2AgAAivACAAAOagIABAXuA
Date: Thu, 18 Jan 2024 00:56:43 +0000
Message-ID: <20240118005641.fpydq2opopbmlnvj@synopsys.com>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
 <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com>
 <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
In-Reply-To: <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|LV8PR12MB9153:EE_
x-ms-office365-filtering-correlation-id: 6aee219c-60bc-4116-2415-08dc17c056bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 V74tGPHZgZ1eJogrOLg8B9YAgETN4O/ZSPIpU+c3pBGsvGX5r0tDiKLhMZXI07h1jqeXJLtIBN/17R3qLqSAYikl65y1sP2a1MSA1IHnvLJ00Ze5BJDDJsDQdGPcl+Dau1D7BlaH9iG+5ZG6Jn18NpUqno1yT+s6L3Siqj4SXzPx7gtggqWR/otRSUXJuOzbOK5uJcTfp8UKLhYgvFOOhdquPYvHyqV1J0lcdADje0j/MmRKQgiaLUpniDDwH6kOa7UjngPBcUQ3ZNk4w+Ax+m+Z7cGo7mSjMv1K+MnnA2eceuYZKJDN+TXYXmPVQ2tN0tfUiitynT0jaD0zUJRJ0m5ChzZs3qOlJ0s9sVYQUZe4TgvgEh7d46qbOdjINO7oGWiSmKB0mpB28YYyWfeDdk3UkdB5uGrHj44OUGC+UGkKwaiK+jG7DZMrvI6fVfuONM/DrqQ9z7cuyXWxWs5a5vVHiSLsLPZynOTTqZRHB3Xpu68jBWQ61XeD2dMzzBQsWUJ4GjvsA6VbjNCb3aNhhdMDUqH2A/QDNQjPIirhrrFebzqsuNsc98OIzxt36ZwPrRBeZTV8YpTnJ0yzAc+DxFOKffzk5MKPXVbl1URCmOqlkDyaqVQKuWtq4vp/Rthr
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(86362001)(36756003)(38070700009)(83380400001)(122000001)(8676002)(4326008)(8936002)(71200400001)(53546011)(1076003)(2616005)(38100700002)(26005)(6512007)(6486002)(6506007)(66556008)(478600001)(66446008)(6916009)(91956017)(66946007)(64756008)(54906003)(66476007)(316002)(76116006)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NGlCRkF0MllxM25RZWd1eWNJdmZxbXRuT1dFSmJXRFo5UEdXVGR3VjloR2pZ?=
 =?utf-8?B?eVhwNlpXeTZ0eFkxd0VtV2RMUjNYWTFWMmZjaG9Lbmx5MkE0L3lCLzhPTU12?=
 =?utf-8?B?Wk9RU3pWUDhvZmo4bktHWWNJU0t2WUc0blZyekxZY2oyUHl1ckNLaFo4cDFZ?=
 =?utf-8?B?cHpCS0RGUk4yS0xVZFRkcW5ucmZ1OUpuRFo5TzZnWFBGNDN1TURVZjZMWTJN?=
 =?utf-8?B?bVRod0RBVVFteEVCQ1JCU25xRkp2VUF3SHBpYnlTSUIxbmdCSklObzlHNWd1?=
 =?utf-8?B?a2k1c3BaWUE2SU8xTEwrY2lBbGZmTFVwYVg0V0ZiWXpnSC94aHcvV2h6emg2?=
 =?utf-8?B?bmJKRzc0dGt3VjFiR0Z1TVRCZzIzU29SaFRpclpVTTZhM1BjK1hXSFZubE1x?=
 =?utf-8?B?ZkI2Q2U0YklJYm40K1pubzRyZDQ0TytVb1N0cGdRWGJpNzQ2S0ZNNW5CMThK?=
 =?utf-8?B?cHpjazBrMjQ1ZGtxdG8yM0FZNjdkRHpHenBvNlZoUDF4RmcvblhWTnVRT3pG?=
 =?utf-8?B?ektTU0UwMmpWVkVZRXRZTVZRS0EvNlBsemdWaDd6QnlGN2J4KzJyUGJHY08y?=
 =?utf-8?B?V2NtK25BNXBaa2pRN2ZWNXVhaUZ5Smp2SHNqcHZJVUkybmVvVDh5bnVUejhC?=
 =?utf-8?B?VDNNSjNwK1FXZ0xNWGwyVWxTcjZXODNqNmtEOFlCNTJ1NmxuL29FejhwU3Nt?=
 =?utf-8?B?OWxrSnpqV0JYZnY4VTY3VENwdG1qNjFCWEVOTGdYdEFzNGZtODRrVWZaTitr?=
 =?utf-8?B?a2NiUFpEWkVLNy9GdHdtR2k1MWtoQlFEcXIyaWFLUDJyQllaTDFhYlBvRllM?=
 =?utf-8?B?cTUrOTlSZ09admYvam9YL3dZdTd5MlNIckZYYmVNWlpkdlVxb0FxejJ4aDRn?=
 =?utf-8?B?cEQzMnE3MjVhYlpMWGNJK1hlTlNBT1JJL0ZFUGJVT3k5dXQvekFndE0xTEcy?=
 =?utf-8?B?eHBMQ1lxOWhHZXBRanpmTk1RMFRPTGpJSXM4MjJZa0xCdGJ2U1psN0xPZk01?=
 =?utf-8?B?VHlXMER1MlpOamxBTjlPYzZqb2pTcVpLZkIxbVlvZURvcjJUV2tQbGtZdkwy?=
 =?utf-8?B?SE9vR1ZzWFNIQ1BCY0dTb1ZJQnJkWFlUdU1qR1hlUmZaemp0YzNRRGtKY3Jz?=
 =?utf-8?B?L0Z1UEdLOE5MMXJNNXIvVDl1SHFlczZ1RjJKaERCa1pMT3NlZW9kTG45b3E4?=
 =?utf-8?B?VVNtWHdzUHlpT3NXN2pPdG52eGJXa2krK3Z0MTZBZlJsNXBnNU9KWFIyem04?=
 =?utf-8?B?Umlrdjk3UU5MQXRGZitVdTN1enNOaU4zcGRJNHJYaXlBSGx6aE1kOXZxK0tr?=
 =?utf-8?B?UTRyTkJ1RXpBdWhWaVRWOW5ZOWJ6MWJxMjd6dFZFbkovT1VtcWFySjBncGFE?=
 =?utf-8?B?SWR5OC9uc0NqTmdySHdNVDVldVoyQmd2MXhncUZpcWp2OExUT2RPeG02OVZu?=
 =?utf-8?B?T0p4MFJmWE9UVlBUcDgySlVaSUw3ekJGOFhzRHgzakczTjV1RHpwUDNRcHV2?=
 =?utf-8?B?SlpwR3ViWVpQb2Vzc1c2SDh2cndsSjR3bFUrYnVYSlpmUlNNNVBvZnVYTEZ3?=
 =?utf-8?B?TGNnZm1LeFpiZjVNK29HK2NOaHp1ZUNHa1dJMFRtcDVWd0JibHRUTmZYbko2?=
 =?utf-8?B?VlYwd3UwM3lSMmtqZXViNzF2VzhqcTRiNS9jRzd5UU5pM3p5cW9pYUpTdjFQ?=
 =?utf-8?B?eUdkYmR3cGZtS3VMMERUNHNDMEFyNloxVjFjMzVhWk4xT21GNC94UTVvWXA2?=
 =?utf-8?B?NmpvdVNPN1UyUVFLQUZFVk9saHFiOTdsNnZMSjRJWVRudENnS0xxNFBCOTdJ?=
 =?utf-8?B?ejNCbDgxOFhkSE90MU1DMVJiN3lIY2FuMlZLTXNWcFZ1UjBoREtNSzVFWHp4?=
 =?utf-8?B?NkxyZnJUemhIZjR5ZlZLY2FxSEhxd01kOEQzbDN3YjQxR1BubmpYMFJrODh6?=
 =?utf-8?B?NndKODhuc3Bncnd3R0k1ZHJwL29MU09Fb3ZrR3FUYVZrNi9iUGtGZEwzUGJp?=
 =?utf-8?B?anFUc0x2YVFITGl4Y0xzVE4xbFpkTmhOdEhGNkJmdE9BcGNjVGF5QWFyUGZP?=
 =?utf-8?B?UFdKRlN5eE1NQmkwMk42QTh0ajRSZUNJaVhCTjQ1OGhZVjhheGZjY2dRMVI1?=
 =?utf-8?Q?woyzzgnKCXQ79jVFQFNJpOhcg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56C2B6B850FA6D419D4836FA566BFCA7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gWoIYNYEtoz0jIXAeuuJi/NFobG0mC1JdSaBcWotNzEPhRyp30tYEuI6eHp/rx6C/bMfAVH5wMAMnsXWyZjGmJbZUOE44879DhcHjh6GuETaWpgxfmeH/IqVS8ApCCdWiLWoNP4SDWrRJTtS9Ryqzo7GWJcpMF9DWHyFbJv1e4pi8dib80wv/Ldq1catzcxUZk7ZKx6XpzFlQmDmZyPy4JN6SmXoHhC0j2UkivuWHSViqRSHuy5LkpixL4qmJjQH4Mv1ioEEH0W5g6Pd7YVLt34zWhbGds3Co3Z5yFLJNh/BjzI1hOdq/iCTcFCDKTH4IFEw+penYW85dveeKWFUluiCua15L84ewtypH+RvzvESJcO/8whjGNG0NY42z5aptl62MAmF3JADfz8nwFny5zfM+rnf5ezLDdflQVk6gZZGOOX2yUc0EE1gwV5Scnbur3hCKVeTdFBgCI3Tf7dhkLm6hx3yA6MGIW//u6NvuQK/ut4ZLEMahXL92NJp4XJymDfJ7sIthnPyn1XUSLfVKRhOShbmqjhdKrDP03UPdPfoowrKNPsAtvoqF1RyIYiqLe5gEA/Fv+ic9BxyTCjYEbsJYmPHm5jKsegbgNMGeze1iWui6fQmiM3ULkjP43iQD/cMoi7FDK5bqsRBVV7YNg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aee219c-60bc-4116-2415-08dc17c056bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 00:56:43.5931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+YR2lILWWxcUdd9b7NbnTdA5cO2ofR2rCadG/nfrZ/EWF848bGD/eu9/pIJFtjfEjs0hIrco+5u0ISXjYQuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
X-Proofpoint-GUID: G10Th3K-jziBWb-8h6bo94agknBrJ4J1
X-Proofpoint-ORIG-GUID: G10Th3K-jziBWb-8h6bo94agknBrJ4J1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_14,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=732 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180005

T24gV2VkLCBKYW4gMTcsIDIwMjQsIFVUVEtBUlNIIEFHR0FSV0FMIHdyb3RlOg0KPiANCj4gT24g
MS8xNy8yMDI0IDI6NTIgUE0sIFVUVEtBUlNIIEFHR0FSV0FMIHdyb3RlOg0KPiA+IA0KPiA+IE9u
IDEvMTcvMjAyNCAxMjo0NyBQTSwgS3Vlbi1IYW4gVHNhaSB3cm90ZToNCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoCByZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gPiA+
ID4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGVycjsNCj4gPiA+IEZvciBpbXByb3ZlZCByZWFkYWJpbGl0eSwg
d2UgY2FuIHJlbW92ZSB0aGUgZ290byBzdGF0ZW1lbnQgYW5kIG1vdmUNCj4gPiA+IHRoZSBlcnJv
ciBoYW5kbGluZyBsb2dpYyBoZXJlLg0KPiA+IA0KPiA+IEhpIEt1ZW4tSGFuLA0KPiA+IA0KPiA+
IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uDQo+ID4gRG9lcyB0aGlzIGxvb2tzIGdvb2QgdG8g
eW91ID8NCj4gPiANCj4gPiDCoMKgIGludCByZXQgPSBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5l
Y3QoZHdjKTtpZiAocmV0KSB7IMKgIMKgIMKgIMKgaWYNCj4gPiAoZHdjLT5zb2Z0Y29ubmVjdCkg
wqAgwqAgwqAgwqAgwqAgwqBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCj4gPiANCj4g
PiDCoCDCoCDCoMKgIHJldHVybiByZXQ7IMKgIMKgfSDCoCDCoHNwaW5fbG9ja19pcnFzYXZlKCZk
d2MtPmxvY2ssIGZsYWdzKTsgwqAgwqBpZg0KPiA+IChkd2MtPmdhZGdldF9kcml2ZXIpIMKgZHdj
M19kaXNjb25uZWN0X2dhZGdldChkd2MpOw0KPiA+IMKgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZHdjLT5sb2NrLCBmbGFncyk7DQo+IA0KPiBTb3JyeSBmb3IgdGhlIG1pc3Rha2UuDQo+IA0KPiBp
bnQgcmV0ID0gZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KGR3Yyk7DQo+IA0KPiBpZiAocmV0
KSB7DQo+IA0KPiDCoMKgwqAgwqAgaWYgKGR3Yy0+c29mdGNvbm5lY3QpDQo+IA0KPiDCoMKgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqDCoCBkd2MzX2dhZGdldF9zb2Z0X2Nvbm5lY3QoZHdjKTsNCj4g
DQo+IMKgwqDCoCDCoCByZXR1cm4gcmV0Ow0KPiANCj4gfQ0KPiANCj4gc3Bpbl9sb2NrX2lycXNh
dmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiANCj4gaWYgKGR3Yy0+Z2FkZ2V0X2RyaXZlcikNCj4g
DQo+IMKgwqDCoMKgwqDCoCBkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0KGR3Yyk7DQo+IA0KPiBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gDQoNClBsZWFzZSBvbmx5
IG1ha2Ugb25lIGxvZ2ljYWwgZml4IHBlciBjaGFuZ2UuIElmIGFueSB1bnJlbGF0ZWQgcmVmYWN0
b3INCm9yIHN0eWxlIGNoYW5nZSBpcyBuZWVkZWQsIGtlZXAgaXQgdG8gYSBzZXBhcmF0ZSBjb21t
aXQuDQoNClRoYW5rcywNClRoaW5o

