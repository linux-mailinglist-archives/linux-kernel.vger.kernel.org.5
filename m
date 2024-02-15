Return-Path: <linux-kernel+bounces-67862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3D8571F7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7231D2823D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017621474D9;
	Thu, 15 Feb 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RZNo9Bev";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QPmPggqb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Y/dP3H9x"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B010E1474B4;
	Thu, 15 Feb 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708041009; cv=fail; b=YGK/WgAGdFduCkwc/kNYYvTwbdNlBublLY0wBCaG+pjZiEU4sblwDrTi+LAOqyrRgn6hp+YQXDrx6tEjVX6f61xLnzg3Ycm+23XQulK0v5eAePCToPk2mrW7ZiNFkw0CBlY8Zx7IkZmL3bTHpgYB7xCVoZS+Ydr2WKn2oCyVk8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708041009; c=relaxed/simple;
	bh=mF58hg5bZLVbsYrzRvCGmOzRXmrfBJ7IXZk7OB7aA5M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gYXxJseKaEer37savRLX2Dyi6aOU+CBwahjSh3zgT6FsbcEy5CCyclO5FffL6WZr7gI8fz6YZpNCId8o3KtPEZYCMcVPeR+hYorrbvbY/2CVYHG9J/R83VvT8DUh9/MMTjRScQ1Ohvkl3Ny39bI1Zd1eXUpZa2L7D7VbfjvO32E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=RZNo9Bev; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QPmPggqb; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Y/dP3H9x reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXh14013154;
	Thu, 15 Feb 2024 15:49:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=mF58hg5bZLVbsYrzRvCGmOzRXmrfBJ7IXZk7OB7aA5M=; b=
	RZNo9BevQ69jjXx9Y+R6JjnBQx45tXNt9Jg59i8suQG0Wxzf9s3r0H4GYM/x4r6s
	YxofSqIDtaDZbfx/Rvtz5WtVfedehb8fX4ud+CiTW3/y6qlnT7Ls7AAl/TEMR3ej
	zsHEzTOAlH+2DAVI6m79xteRSf2+67TLCkXJP5I3GP0zFTsJZv1lpsBUzjNgzBnX
	6IzYvNWNV5ZGKk3JOMo0X3SVBa9uu4rnJyYqgnhlZzmFfcbN9iCd9IAPh+TNpTX5
	7qYcZV1QdRxs3Q223YHHm/k5ReyQwb7DAzHHQis6vZJnJAf9/bVf6Iyo2VniWMco
	41FLDYOpKszcRbYE1olNxw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w68xwe449-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040996; bh=mF58hg5bZLVbsYrzRvCGmOzRXmrfBJ7IXZk7OB7aA5M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QPmPggqbEPazaRhLNRI93rr6ENhvq502Ng7NzRsB9gQBARxhHmXn1fne/s3W/P1d0
	 AF87lZOztZLxtdnpwnGN4PowJQe37lZfKxWo1US+N0Znt2qm+iRhAmCyq4bHK/f3TE
	 veYJgU5d8bbzKHNAbVisv3HvlDdXRvSpQ23naF17i/GGlNlx00daQ4xuo9ka2cpINz
	 oErH8kDY3DhkNNULaFKKOtpIUsMOd6Ra3ZWiam/18n+DTs4du9c7EQdlc9eg3JrgBD
	 EeEFIBKjAg+CEnnuOkquG28U1gtvVq3LXB1ozZZzmxw0sBSMROt0ExwqO9IbQh9Hsl
	 tqa7tjs01UnFw==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9FE1140521;
	Thu, 15 Feb 2024 23:49:56 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 40DCCA0084;
	Thu, 15 Feb 2024 23:49:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=Y/dP3H9x;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BAEC1401C4;
	Thu, 15 Feb 2024 23:49:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp8oc8UZE4pJ/yY9JyPznb4v0I7MM5XBILaB/cZq0BeqsuBfCUDdiEmxLqpJFxLHZRGsg4BNxoBYx+lXlIS+m7i47CGMK0ANSkLNufJoEzegy4+SAdv56yWz5tDOc928k0HcLNErx58afpweqPXQ2BAU8JQvXji6+J+6AvpPhc6+9cI/LPxb73WNpTZyz1itu/B4RElN/QoJ0MDB9XI8j1l4Q4u9YIZnNKBBdw19hDp8QIjikK9I4l6N4gF9kpOvR38f6dvsBnd/sC8MM+PJ1UghcIVkoK2L1eUoo09ogsivK/kS+UCkN8fzyGiYbmy/358u5dLM4pqqttKM/tTqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF58hg5bZLVbsYrzRvCGmOzRXmrfBJ7IXZk7OB7aA5M=;
 b=IxgksTLt66XLBkaGrIf8cZwbhXKfy+2WewiWg4w6d+9ejZ+6bdrrNRhB2a7RchIA3WJOMXaySC3ftTFzL+IDsmRZVTxPQPQVzBz3JBCVk7x4HsLDqkDtwHpp4+w0OYHWQ406cNcvWj0WmhpRxO3FOLxov3p90dcmJUhm8NlyiDRMcDe1sw3L7gkLQqBu+/XcPV+r8vccMAkZdf7qDGOOwKjIJpNehhBCrm2bu62aOuSUcf/u3iqAUtCURPe8Az4r3dx6dFNbd/9E+T7y69a2wNJfWdYSIyFk0Z1jmTz3Kyju5Tt7QUJ/ozgonNDFdPJvJnoB7r2zRTyydIlGJ644Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF58hg5bZLVbsYrzRvCGmOzRXmrfBJ7IXZk7OB7aA5M=;
 b=Y/dP3H9xpS0Rgai9NQfniJNSaAvXbeKT7tKLhyLe/AnqA79AD4ELqWg2mCIPSKZHFJ3UnHv1UCKrBEtmdh3hrEww7vUaXQ8kM3LDTq84XalaM5TaYcOV5PrMMTKA8tehaGOKZ6h5ceL8NrE2ZnMxoymcS4f081X6cIdh96Th89M=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Thu, 15 Feb
 2024 23:49:52 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:49:52 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v14 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Topic: [PATCH v14 9/9] usb: dwc3: qcom: Add multiport suspend/resume
 support for wrapper
Thread-Index: AQHaWLwXQwr/HAwmd0GF0iDN+qAhq7EMIdkA
Date: Thu, 15 Feb 2024 23:49:52 +0000
Message-ID: <20240215234948.vhbxtcli5obor5tt@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-10-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-10-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: f6e6f041-134d-4eb6-a114-08dc2e80cdfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 r6E72tASaZSG6FIMdOa/jicRChCaJ5ENfr0V0J0mE+pIUI9tibtr4f966Hfe0bz43FzYgAJqJh6+pYrUlketbxUdaCIM8eNGqMPJBmDUVTEiZxnva/6AgE/6c/i+FIwMCjzQa7s8mUaREoNXKETuqCV6g3Wt8v6n/nkPJTAdESLrj/9sD8+RTHTfwIVNO7gS0O63TbQf9yU8ILzR0k/pGumDRF9maGYmJXuzVXRjqUtieDtrV9UiENTcJMq0N5LoS2ko0lizM175B9axeTZECEaSpRcylOAtGyvU4iT61SkSrt8TwaIKwuMX9klK2InubTRh2c0PeX0VOcXXJu6tK9Pk49rPWCQTV3rO0h9xLQLt9qv5dsQs+s7uvvCakRermk/uDxY6XsJnjUYzTdYwCK+HTOTwxLJ7ekBanhe6Ja/bF4JuCDPPKeC5jO1WTyfB1Ay9D8xpMRThdCwXCiPMy2Qh2GpVNZuckKlUs1eibdjoRuBoIPXcQ3PcCn6Zw6r4yLUUK+/3Ri3AQ6fkS3lv++1RZ1/UUyMUIny44EWYYkPwi7VbHkS/0N/qWbIhRtPerWQOdV/wLpoBYDmHG7boOx9rb6Ez4EnFWG8VeQjE4k2/bjVL6Mf1buc1mGhtcLR4
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(5660300002)(86362001)(8676002)(2906002)(4326008)(7416002)(2616005)(26005)(83380400001)(66446008)(1076003)(38100700002)(36756003)(122000001)(38070700009)(66946007)(64756008)(316002)(6916009)(6506007)(66476007)(71200400001)(76116006)(66556008)(54906003)(6486002)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?L2tLZnJVWTE5OG00djd4UHVaWlNJaml3Ri9lQzNjem1mbk1MVjVUMVRvdzh5?=
 =?utf-8?B?VCt3dzV4T0hDcGJzeDNCRGJraCswUW9wa2dMSWo1ZDBtT01wemRORC9Pa0FB?=
 =?utf-8?B?RlVGNnhYWVE1RXVTNEkzZGFZbWlzdzk1dk9BN3YyTjYrRXAxcmpGTVAvcFdK?=
 =?utf-8?B?cDJ0VDRseHRTTjF6TmJZNjNDMENIcHhEMnEvVjQwOFJHeHoydmJwUEdVVlR1?=
 =?utf-8?B?VlJoU2RpVmgzWHZJRTFjS3BJd0Q5Y1NVa05iYUxvSmxwL09sTG43OUk4Slpi?=
 =?utf-8?B?dEQ0dlVod2pwVjVqUytiZW9iQm1mbDRBcHRhc3VlK1FqLzVJS0NzckxvRTZ1?=
 =?utf-8?B?Ym9CZEJrcEZwbkVYNjRVbm9MUnM5eVhWS3Z2aktsUlh4Tm9HQi9EeGhscHp2?=
 =?utf-8?B?WGowR0FYTk9IS09vOWhiUU9OOEJCZ1g3Wm5hdFJkeDEvWGtGTlBuYWdnM1U1?=
 =?utf-8?B?WUpUalVUYS9IQngrQkdlY0JUNnVGTm50d01kLzJPT1lCOXVxRTlvd01DZW5k?=
 =?utf-8?B?ZFdWWWhEUmMvdUlTMERMVm1oa1h0MnFXdlR3ZTBxWU0vQlMranlLS2VZUVlU?=
 =?utf-8?B?eTU3b3FFMnB5WCs3M0JRR28vOGVOU1IvbWpXYzRweHZxbHpIdzBnK1d5cjVm?=
 =?utf-8?B?TFpTSUlEeHgrTHJjdVNlMmlSWjZlQ3g3ZzBXelBzakdxWWQzajVOZXlDYnJY?=
 =?utf-8?B?eHBVSm4vdUg0eWlKL2hjY3RiRUhyMkNtR0YzbXkzaWZxZWNNLzd5WGFBckpO?=
 =?utf-8?B?Y1dWMW9QU0hpSEtIK1QrMnpRTmpDL0ZscGhwR01oRWNreWtkQlpZZ3VOYWh1?=
 =?utf-8?B?d25PWXhvaU1na1FxVWtEUUVnM3A5S3NsTXk5R2NNNkJ3T0ZzakhHWENHK205?=
 =?utf-8?B?eTg0UmZqZW1ub2hremdCTHFiT1Q3ZkdRTWFzVGUvREwrVTNvNW4rdW0zN3dF?=
 =?utf-8?B?UWhmbUp4bVdUeFZMMmZaRDB1dmtMR1V3SUN3ZnpPM0czbGxvdVN4RGRSem9h?=
 =?utf-8?B?YlY0SmpvYWR4TmRHTnNCMWxvSWViZjFPajIrUUZYZGFHUTR3QS8xOWVUYTFF?=
 =?utf-8?B?UGZnZE1RY3ZUeDBYR0NxbzMvMEF2clR0SjRQRU50eFpPQzdMMW5rSWRid2s4?=
 =?utf-8?B?dS9ocGRtQ0NES1g4U2Y0R3ZrV1Q1VUtUeEY3bHQzSTBXTGZYdndldTI2OGJI?=
 =?utf-8?B?OSthcGlrSVpyTE0venp4dGI2b29ZVGVYL280bGM0SlZOMWlwR1dLT1d0RGtE?=
 =?utf-8?B?bUFaU2o4YWNGeTNOb1BvUEM0ZHFqQ3NDaTJCaThVcGI0QVg0bHBQRFdoRHFD?=
 =?utf-8?B?WklKNENkS0ZlZG5mVEtZSXBDY2ZGNjBwMUJCb3pZSlZ2K1B0WUtaWUtSN3lS?=
 =?utf-8?B?MWtSMTZEZGxtNnJTWlJ2cldkMXhKSm1LK0hzdzlVclNBWHkraGdPWDBZQklH?=
 =?utf-8?B?QU84d3lvVUFHQmRJS1luM1l6NlhDMlo4b1NSczJEYUhMWlk1RUhxUlhPd0lz?=
 =?utf-8?B?UjRJYmowdzlyQVpRM3pWc1ZWb1pMVHVadFp2SzRDZUc0dThxQ0dLelpUUkVL?=
 =?utf-8?B?TExoWEVsbEJXOUh4SGo4MXRZdFplN2FrQ1k1NG80R2hxRVZpMXJQWjVUczRD?=
 =?utf-8?B?S2wxZEdtb21ycGtBMmM5WDZuZUorbFVFSjJhVG5HZGdaQktuMlJCRkxkSVI0?=
 =?utf-8?B?bmNSK0Y1WjNKbFBmTFVIeE82ZHNlUW1EK2tWSnpCR2VReWVrS2pUVElFMkFW?=
 =?utf-8?B?blZ4MXN1MUFsNWt4S1NMeGV2c1RGU1pyWXNKWHlWY29mU00xVVpyZmFFbjFR?=
 =?utf-8?B?bGNUZEhFOVVhK0dnRkxaYzJYdHBFYnFXQmFTdnhNUFJtVS9lWU1XMllkVDcw?=
 =?utf-8?B?N0lLQ1diOXJERnNlMXVMQnJSOHBqSnh6d003RGRZSWtMOHByRFdoNmdXTjJO?=
 =?utf-8?B?bGViMGlNR2RpVTRiWlVJM0FXa1Vab2FrRURHRHZiaDVMc0tWUUUydldPTTBv?=
 =?utf-8?B?d1A2MGpyR0JiWnZQZlFTVXRDanl5eHlNNnFQcXB0MzJkVHFPNkFUd1U2Mm9Q?=
 =?utf-8?B?Sm10RGVDc1dGUHRRUTNGTk9sOW5HSWtISHpjcFYyZ2NJOVNHSFc1b2duOXlw?=
 =?utf-8?B?ZkhnSjNTV0VTblpWQjN0Q0tFZGxjNEwzWkdvVVA5WmZpRWdJWklWNFUzREZX?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E787EE4502F7A74A95080CAB5F3F4639@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iZw/aW6GqGla3XVytmDeeVNbUGiniBe8I/WeeeS6yizfP9AkpFoIjs42tRFEsnU4uiIFr5bZMhl/pl6hb7oObhJTrzcQdJYjc65Jm1hHys45fwpLiD6sK4f5FQrhlU/2/2qMBd9gBXLL5ZQNgtsDpny70mLXg/xZNB1DqD/mzidZPrA+Cg2o5MQtObfVHohIZuGdVVkDEHUNgwcSfiwjVp34VtY0MOf7RHjphN9dIktKPZ+nAYzPSkI00uTIUu/zTsb4hreN5WMQKyPQMcyACv8+j3Vg0uv6nOTUxyy5RyyZD7cWpDS63ULKEXNOB1sgUq4bw/GX93KR1YUIta111XG+VlkSjOCMSX7nvrfcdRAuOw1LfFEs9A3HXZmzAFue9Vxawatal76np2XcA2X4kvpLolr6KcyZWmf1Ko9YxEqJjCB9cYHksIdFWhv4KWfHt8bsAPWZDju7y3rR1HwnpSvXb1od42zINh6Afxetew9QgkRXZStJbEud586uf+Y6/SMWX44tdIwFxonXIg7ZHs0uzyduVfhf0YXFU3IH5WqHPzFUupqzt7ZCZlPBHbbOvUYe0/eNHO+nkuw2edPlsaDhaq/b/uWh5LFV3c9a/S3bW7r8y5sSY/bqkC9WgChvSDWLx+Kdbur21N3a2I2yBQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e6f041-134d-4eb6-a114-08dc2e80cdfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:49:52.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67SD5suz8mPHgy9SQqJ7Ek2pK5UGKqSQFtDQQg0WhThgHGWFQx1JUqb2H04VARRXxSSfNgydJCfHK1W99kWaXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
X-Proofpoint-ORIG-GUID: 1c0msG1N2dDuitNk-B7faFxcKTfg3ndx
X-Proofpoint-GUID: 1c0msG1N2dDuitNk-B7faFxcKTfg3ndx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402150185

T24gVHVlLCBGZWIgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFBvd2VyIGV2
ZW50IElSUSBzdGF0IHJlZ2lzdGVycyBhcmUgcHJlc2VudCBmb3IgZWFjaCBwb3J0DQo+IGNvbm5l
Y3RlZCB0byBjb250cm9sbGVyLiBBZGQgc3VwcG9ydCBmb3IgbW9kaWZ5aW5nIGFsbCBwb3dlciBl
dmVudA0KPiBpcnEgc3RhdCByZWdpc3RlcnMgcHJlc2VudCBpbiB3cmFwcGVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIHwgMzAgKysrKysrKysrKysr
KysrKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMt
cWNvbS5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBpbmRleCA1NzJkYzNmZGFl
MTIuLmU3ODk3NDVhOTQ2OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFj
b20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBAIC0zNyw3ICsz
NywxMSBAQA0KPiAgI2RlZmluZSBQSVBFM19QSFlTVEFUVVNfU1cJCQlCSVQoMykNCj4gICNkZWZp
bmUgUElQRV9VVE1JX0NMS19ESVMJCQlCSVQoOCkNCj4gIA0KPiAtI2RlZmluZSBQV1JfRVZOVF9J
UlFfU1RBVF9SRUcJCQkweDU4DQo+ICsjZGVmaW5lIFBXUl9FVk5UX0lSUTFfU1RBVF9SRUcJCQkw
eDU4DQo+ICsjZGVmaW5lIFBXUl9FVk5UX0lSUTJfU1RBVF9SRUcJCQkweDFkYw0KPiArI2RlZmlu
ZSBQV1JfRVZOVF9JUlEzX1NUQVRfUkVHCQkJMHgyMjgNCj4gKyNkZWZpbmUgUFdSX0VWTlRfSVJR
NF9TVEFUX1JFRwkJCTB4MjM4DQo+ICsNCj4gICNkZWZpbmUgUFdSX0VWTlRfTFBNX0lOX0wyX01B
U0sJCQlCSVQoNCkNCj4gICNkZWZpbmUgUFdSX0VWTlRfTFBNX09VVF9MMl9NQVNLCQlCSVQoNSkN
Cj4gIA0KPiBAQCAtMTA5LDYgKzExMywxMyBAQCBzdHJ1Y3QgZHdjM19xY29tIHsNCj4gIAl1OAkJ
CW51bV9wb3J0czsNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCB1MzIgcHdyX2V2bnRfaXJx
X3N0YXRfcmVnX29mZnNldFtEV0MzX01BWF9QT1JUU10gPSB7DQo+ICsJUFdSX0VWTlRfSVJRMV9T
VEFUX1JFRywNCj4gKwlQV1JfRVZOVF9JUlEyX1NUQVRfUkVHLA0KPiArCVBXUl9FVk5UX0lSUTNf
U1RBVF9SRUcsDQo+ICsJUFdSX0VWTlRfSVJRNF9TVEFUX1JFRywNCj4gK307DQo+ICsNCj4gIHN0
YXRpYyBpbmxpbmUgdm9pZCBkd2MzX3Fjb21fc2V0Yml0cyh2b2lkIF9faW9tZW0gKmJhc2UsIHUz
MiBvZmZzZXQsIHUzMiB2YWwpDQo+ICB7DQo+ICAJdTMyIHJlZzsNCj4gQEAgLTQ0NCw5ICs0NTUs
MTEgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fc3VzcGVuZChzdHJ1Y3QgZHdjM19xY29tICpxY29t
LCBib29sIHdha2V1cCkNCj4gIAlpZiAocWNvbS0+aXNfc3VzcGVuZGVkKQ0KPiAgCQlyZXR1cm4g
MDsNCj4gIA0KPiAtCXZhbCA9IHJlYWRsKHFjb20tPnFzY3JhdGNoX2Jhc2UgKyBQV1JfRVZOVF9J
UlFfU1RBVF9SRUcpOw0KPiAtCWlmICghKHZhbCAmIFBXUl9FVk5UX0xQTV9JTl9MMl9NQVNLKSkN
Cj4gLQkJZGV2X2VycihxY29tLT5kZXYsICJIUy1QSFkgbm90IGluIEwyXG4iKTsNCj4gKwlmb3Ig
KGkgPSAwOyBpIDwgcWNvbS0+bnVtX3BvcnRzOyBpKyspIHsNCj4gKwkJdmFsID0gcmVhZGwocWNv
bS0+cXNjcmF0Y2hfYmFzZSArIHB3cl9ldm50X2lycV9zdGF0X3JlZ19vZmZzZXRbaV0pOw0KPiAr
CQlpZiAoISh2YWwgJiBQV1JfRVZOVF9MUE1fSU5fTDJfTUFTSykpDQo+ICsJCQlkZXZfZXJyKHFj
b20tPmRldiwgIlBvcnQtJWQgSFMtUEhZIG5vdCBpbiBMMlxuIiwgaSArIDEpOw0KPiArCX0NCj4g
IA0KPiAgCWZvciAoaSA9IHFjb20tPm51bV9jbG9ja3MgLSAxOyBpID49IDA7IGktLSkNCj4gIAkJ
Y2xrX2Rpc2FibGVfdW5wcmVwYXJlKHFjb20tPmNsa3NbaV0pOw0KPiBAQCAtNDkxLDkgKzUwNCwx
MiBAQCBzdGF0aWMgaW50IGR3YzNfcWNvbV9yZXN1bWUoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwg
Ym9vbCB3YWtldXApDQo+ICAJaWYgKHJldCkNCj4gIAkJZGV2X3dhcm4ocWNvbS0+ZGV2LCAiZmFp
bGVkIHRvIGVuYWJsZSBpbnRlcmNvbm5lY3Q6ICVkXG4iLCByZXQpOw0KPiAgDQo+IC0JLyogQ2xl
YXIgZXhpc3RpbmcgZXZlbnRzIGZyb20gUEhZIHJlbGF0ZWQgdG8gTDIgaW4vb3V0ICovDQo+IC0J
ZHdjM19xY29tX3NldGJpdHMocWNvbS0+cXNjcmF0Y2hfYmFzZSwgUFdSX0VWTlRfSVJRX1NUQVRf
UkVHLA0KPiAtCQkJICBQV1JfRVZOVF9MUE1fSU5fTDJfTUFTSyB8IFBXUl9FVk5UX0xQTV9PVVRf
TDJfTUFTSyk7DQo+ICsJZm9yIChpID0gMDsgaSA8IHFjb20tPm51bV9wb3J0czsgaSsrKSB7DQo+
ICsJCS8qIENsZWFyIGV4aXN0aW5nIGV2ZW50cyBmcm9tIFBIWSByZWxhdGVkIHRvIEwyIGluL291
dCAqLw0KPiArCQlkd2MzX3Fjb21fc2V0Yml0cyhxY29tLT5xc2NyYXRjaF9iYXNlLA0KPiArCQkJ
CSAgcHdyX2V2bnRfaXJxX3N0YXRfcmVnX29mZnNldFtpXSwNCj4gKwkJCQkgIFBXUl9FVk5UX0xQ
TV9JTl9MMl9NQVNLIHwgUFdSX0VWTlRfTFBNX09VVF9MMl9NQVNLKTsNCj4gKwl9DQo+ICANCj4g
IAlxY29tLT5pc19zdXNwZW5kZWQgPSBmYWxzZTsNCj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0K
DQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpC
UiwNClRoaW5o

