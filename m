Return-Path: <linux-kernel+bounces-67834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84A68571A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7128212E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD03145B1E;
	Thu, 15 Feb 2024 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HQiCUHDA";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="lihA5h/v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fvjbBOkB"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FC8833;
	Thu, 15 Feb 2024 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040181; cv=fail; b=nmo0uxRBQLpJ8sACAp+xLsVDVKK4meOLzNmwDlq6UwSo0mliqRUsVl4yZHJIBHYE5UQVLW1kRRy278FmIKTqzUW63BUO1hgZxlInX3l2wHiBUug1mQQqtQat38FKzUoP594Xh5daB39FKyB7j5mBEaVQmkzjFLs/5PBE3oNdJpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040181; c=relaxed/simple;
	bh=VyvnWYc53hXOGWknknqOV4ldjgi0wb9BiGYMV7G4ULI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AJngmeoX5P+wY0T1JtM/zk2Qh9lUQAHPWUMrL2iTYaKOzTSF7dSLAlzafavyMB5aL9wHO3PfDSMeqXrNZo5ufTQwORMksnnwW74XrIiTBOWhU+k7ukRpkLElOm81s0BEmDRZrFifgyfJ6EkGd3JWk01BZ49JXSLpRuJXZ8Zhx/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=HQiCUHDA; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=lihA5h/v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=fvjbBOkB reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXlKQ032329;
	Thu, 15 Feb 2024 15:35:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=VyvnWYc53hXOGWknknqOV4ldjgi0wb9BiGYMV7G4ULI=; b=
	HQiCUHDABIMJgqDnpJCQ909hbORtGEO6/23xQsGvw2EbP015upJt0UI1V56jut/J
	b+QC5KHUKdvud46f5yjQy/z6y3ycgX+koBLFeAue7gXedEvl1erTkLt3VWIJ8ZyI
	27NdFbFPsV9ZZgRfIstuFwDNrssOTBEbVbPSe2+kezREpbDQwsGpXON6oIKAX4Yu
	PjsSkISbrTdwzLfO3KPHpeEDqOFocjJ4Xw/TFrREHnYUuacNg84N0F0qA0PGscsK
	/Qe2oc5qPGR3DIxJqDmsyFI3Gpok5lLkcMAdo/Tq2uOKZhwV7qrJyVaNzZ6lC/yB
	liJMlPhQ5nO1v/p82jBtIg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w6996wv1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040152; bh=VyvnWYc53hXOGWknknqOV4ldjgi0wb9BiGYMV7G4ULI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=lihA5h/vSFuKIrLhRil4gfmFhyLI+UGvJOE3CTphN1Ngv5uSJn3Jy99QpiElAlmxy
	 cttN59iD9ZvIy/r9cEnVLnhj2rrA0SXLkH+BUdx5vOrjXqDudTPBGr6W3m8c2Z4Hq2
	 MNNa6IKiouP6KepIOFv/1ej6TyawYKN7VD09logA1E58LqoYjdiagRAradXqNUZY2n
	 LB8NWncGGImAjXH4nJkH1glFueimdkugZjP2+zP8ZNJeuc2pBg/NPNnGs4wcgK6+eD
	 gA9QYNN5qb5/uFmZBt+3tghgatftQLgV5bPSkRoYkZMSqzwDu84ot7G2Sr63QsboVE
	 vE5+69McPYf9A==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6877640528;
	Thu, 15 Feb 2024 23:35:52 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id B640CA0068;
	Thu, 15 Feb 2024 23:35:51 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=fvjbBOkB;
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 355D24041D;
	Thu, 15 Feb 2024 23:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkZ6z1D8NKPF17OXbXsDIdbhMbFH/5OKzSj8NU4hOeJHhVKeNo/waWBXKVBQyvRvTLslCoBfitXacVc3bDhqL8/mW1La3U8I/uChXqByVoRFBx562p5TOVhFJ6CMjN/lBW1x8u4zb61BYjLQnlorPsAQME5GPGGTv1Trja4cY6jROVg6KB/20+Q6aGB3eu+atmRPQYTfxbwgP3LAnnbt7J4nxhQ++X4j8zJ6AqmQEtnGiOgvKktfh7C4qluuRo3Olxw23L3WJythBwumxnsCGtWaRTr+MCEBKDByHi0bM9VN7eSNI2JhjdMJNtCcOExLirfoeXYdOVj79S1MPd0huw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyvnWYc53hXOGWknknqOV4ldjgi0wb9BiGYMV7G4ULI=;
 b=OekvG+aabjMYQq0KqLgZTbDcJEgNzjDM7yYTvamO+4XDPa1GLdBhIBzm7pA1TTh6y5phKFRdTQghqGdmqNcwxxlOF5htORZtSrOFU5P5Sx/ju2j7FT0acWBktx1E7lLAIRWEgm74x94DrNABe85evPEhPKTbzqmdGc4o9xOSJmvSG3pvkuuCMpfspKu/3gzTDh38M/V3KKuhYibzqZZs61Fsixy33fZtpX7gfqkT2pX+b7L/82dd23AIrVrs52XVxjxjiG9BKpUbsx1PdPFwakd58VRsLRjpfYpj1kbMX+ofW3wcPmhwm7/nijbJKozV4XGkCJluBVnyC/tg8I/3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyvnWYc53hXOGWknknqOV4ldjgi0wb9BiGYMV7G4ULI=;
 b=fvjbBOkBlfdS0q+Gj3Q8FDPufYP3Hudp2EzaHGHjCXj3kjJhQ+L/k17KnGDLpP8t6MovImcclXxNUpJ03e7RxkNM1JPQVDRBqXE7AaGRp8zerXEnFR6EBSDuCRMz8SzoU6wrzdbw3GuINu7e1EsQvNQjQpxukIGhdPPCKNY+1N4=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 23:35:45 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:35:45 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Topic: [PATCH v3] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Thread-Index: AQHaSry3jkVH2byjC0K3CaHiHYrIybD+5LoAgAJJM4CAALTdgIAKVxYA
Date: Thu, 15 Feb 2024 23:35:45 +0000
Message-ID: <20240215233536.7yejlj3zzkl23vjd@synopsys.com>
References: <20240119094825.26530-1-quic_uaggarwa@quicinc.com>
 <CGME20240207115929eucas1p1dc7c6bb3f9aa2ac983dd95d345661aec@eucas1p1.samsung.com>
 <4b5683cc-8e61-43c5-be0f-b5378639276a@samsung.com>
 <20240208225359.pvnunirbzh32zjop@synopsys.com>
 <2cc401dc-bfeb-402e-967e-bd1653640949@samsung.com>
In-Reply-To: <2cc401dc-bfeb-402e-967e-bd1653640949@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MN0PR12MB6150:EE_
x-ms-office365-filtering-correlation-id: 736d38d8-6847-4344-e7b3-08dc2e7ed4ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ou+Dv/DGYsQorZTnghIeV0IQCprSaLWEwaoVXmcTi4BZDLyqX23fzHRNV1wI+J3J/Op9bF32A2QXHkJqJ6LSXKtGK52j/g9P8sh8Coj+SyQQ40nYdwm4omUsCECu8aSHFCyBM51RLMOLdvn7IPapfQqNuyN7uxLa5clcS7tVmm0LFE9U4WUCI2oWfl90KwZgK147pQiBFFEp6UGMfoWbwqWov6aiSze8VPHWmAO4DdRXg4QIxutSi2QB0P5QTt2nwPeiiEARkw5wjTG5km0JyGFdQSYoD3FL9rpNkqbL8/fquQmttoyJw56CXLmZ8bRIP8YpCyYqQtn83JPfUgdFVqrNFvpCao0nAHsG/jYt3FABO/hoEo5qL22v5NkH2AI7OUl2k62+Klz4S2XU11hs+f148wosuM9gWMwL1E/eY+sJsaMwkhzQxhfKGojvExMGQB5/zQw0tQtpZ3tZ4LYLSqstKgAFkKa6wj4ngkilh545I1PNSrY5iNVyXL1qqbo6QSAK1ef3Uf5hx8LOElw378k9JYmlaCDq+N1Q9DGRS9yIE8z6LyzB771bE27t8oF9f/Ff+Z2gSJm+YHqZ4b+DDzL7tyfMkIi/HTjwjAlmoqbXdImyATNhNPOuupXNSTXn
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230273577357003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(8936002)(4326008)(2906002)(5660300002)(83380400001)(26005)(38100700002)(1076003)(36756003)(2616005)(6916009)(122000001)(86362001)(6506007)(66946007)(64756008)(53546011)(66556008)(66446008)(76116006)(38070700009)(54906003)(66476007)(316002)(6512007)(478600001)(6486002)(71200400001)(45080400002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bkQ3N0lGc1Y4Y0ZiVXEzTUlFSmhkM0w5M09CNFFqR2hSeEJPMWk2N2VFYVgv?=
 =?utf-8?B?OXdlQ3ZkaHRjWVp2NDgra2xyRWY5SlBsdXB3USt2emUwMUdlZ0pLQm5KRDJ5?=
 =?utf-8?B?M0Rza1Q3TGovOUFsUjFUOHdENWRkdVBheDZHbkMxLzR3WDlDVnJOS2NIZXVv?=
 =?utf-8?B?VkZXNjZGWXc0bHpiTXB0K2k3d01pLzltb3phRFJpRVNsMGNMUUF3YlhqM3Nl?=
 =?utf-8?B?dGRsWmxzM2VpSWVuVTZTaElCb1RKOGt6a0M1WS91RUxFaGs5dTJrSTdrOUdW?=
 =?utf-8?B?T0t3c3dmTXFOdjB4cmFvejVVMXhQa2gwNXZxQnJmK1JSK2h2ZTA3Ty94T1dV?=
 =?utf-8?B?Q1FGWDRNcDc3SlAzM1NTMmtTVkZhVnVpU09pbTIxTnZOYVBrTlVNWnE0UGN5?=
 =?utf-8?B?aitRd0orSDkwL2o2NUF3SEdNczFFY1VTditQQWxiZGJ2V2NnbGlTZVc2YXRH?=
 =?utf-8?B?dlZYYjlvMTRRaHpmMmptSHhGa3hkNEMyTXFDOHJYZW5CYURzajgzVHZwdnZJ?=
 =?utf-8?B?TFZDc1J4K1ZlUTJ5NkJQQmhkSnphYXZFMU9OVHZ1clE5dGczYVR6UnNnUVJq?=
 =?utf-8?B?dWc4d1o3YXpnM0pSN3pJRnRBbVo3YkY0TFNod2NoV3ltQjVjSGN1QXdNWDFP?=
 =?utf-8?B?V0F6T280TUJWRUdxZW8yNjE2UzhFTkpjNGRoaE1EWmdIRUVOc3lIMGRKR3ZH?=
 =?utf-8?B?emlNRWpScHhiZUk4SXBXTFRPSmxvQm5ZNC93M2x3ZTNPaVdIbGl1V3JZc2lD?=
 =?utf-8?B?U0U2dVc2Y3BVSGRJa2U3VDdkcmlCcGRpYTBZYmMwd1p3bHVBeTJaZUJIaHJW?=
 =?utf-8?B?VGcweVVZKzJwclUxRndlNUhVMDM2TXRuOHlFNUtQSFhGT0p0akFyR1k5SThG?=
 =?utf-8?B?NmNhR3Y3Njc4TnJyRHpvaUQzV2tFaDRLTlpDQVNjZTU4MzlkMXlYa2dYSXRG?=
 =?utf-8?B?Z0tCc1NrRXZyNUk0RERnVFE1TDVEWk5LWFdYQ2I3QjNHbzU0bjBqRkZUUXRz?=
 =?utf-8?B?SVdVanZ5MUNIdjJCZUhsYnFybFZ2OTRMUFJFRVdGdUNKTkw0NndCcm9xTlBu?=
 =?utf-8?B?KzRWdXVlY2RNNnFKVkNUUWtkRVdUeWlnOGVQdWdidnFCU3JaRjBMaVUrY0JB?=
 =?utf-8?B?VitKVmk3T01rVE5xbjhGT05pcE12TUs4dW15bWYwSjNiUWZHVkpFV3ZXRmZT?=
 =?utf-8?B?bmpad1FuU3BIQzBlbUJPMVB6SlpqdEV3dFVYM2pTOUpUdk5NbmdrdlVPWlNi?=
 =?utf-8?B?RHgyVmxmWHNPSkplVUJ5VTZHamgwaGhra3puY3RZTjRxOXJEN2ZoQWJmSDdV?=
 =?utf-8?B?WkpRektiRjJSZmxtdzR1RE1XK0NmUE1GWjRwdnZYa1lyaTlwQkZvbHVaV2ow?=
 =?utf-8?B?dnpXNTN4QjJzWWtzMlBRZTV2TTIzeFF3RXYwbTNweHRHR1ZoL3dUMEh0Zml2?=
 =?utf-8?B?VExpTkh4TlI5aXdvZ1I4QlBrN0NnaFcySWZrb1Z4ZElTWndMNnl1WUtRb2ov?=
 =?utf-8?B?MmZpMjFXZ1JTenUzQk5hN28wQzZDMGVwSU5lUzF5Nm1DWlhLcVRyRjkvL0Ux?=
 =?utf-8?B?Y0tFdFR3NE5yQmpuZmF3VGZYUlYxcGlxdHdSOTJ0U3dxdTVaVlpRazFwQnFw?=
 =?utf-8?B?WExhT3hsYnZYRmNIakVHenVrNnY2aEJ4dElvNlVEKzJSK1JBZElPWTJxdE1G?=
 =?utf-8?B?YXBVemZXcHZ1anBkZDc3ckNTWHhYYzN5WWF0SVZuekpjNEw0THowOWhXRmNi?=
 =?utf-8?B?VW5XaTVrUTBWdms3K001OHFKdDhzZWJSL25vZUN4UEk5MlBRU3FKRFI5NU81?=
 =?utf-8?B?bHlUT0libW9DZTRuekVlZXNERDNqZXZqQXlPL2IwOXM3dUdFUkNidmdTS2hL?=
 =?utf-8?B?dFVQdVFVSjhmcGFocmRrWXBvZklVMVVPa3VnTllzUElYNnVOZ2VlcldnazRv?=
 =?utf-8?B?d0w1L0dKWGNkMVMrOUxHUE5Vb0FlWklWdklIeExQdERtTDZlWkVZbVNIZ1g4?=
 =?utf-8?B?cTZUVkxUTmN5V1RGN3RNMk8rMWVGUWdwaTRna3l2VEx5RUlUdEU3T2M2dk1J?=
 =?utf-8?B?L0lnd1UzMEUrWjd2ekJxVExqL1F6Sk1PNTNnN3hjbDg5aG9LOVpFYjMxbWxN?=
 =?utf-8?Q?7cNMAW64FVUj7grsG/Tw7AvfS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C45A43D34C56F4982A07D57EE0A82D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iygqv4BgbOfHHaG0OgagZfMsEzX+lBV6lOQYhdIL3lYZ4/kVLPpGRVC4VDIPtlw/i5tupTz1fzOh1PqjUXqyRrvwZfY+xawqARK3YlU5KkRX+bIDI06gyX0x6WBQ/3Z7ZPtiCzpBBjBEok0ufSqzozKRhuYHigvyDqHRY0x6obwcMJ5kRIeZgokc1ep3j+N2JZzi18nHI0sI3KHfevPWdbdrJVcS//iDRcn0i6gAsRCUAwCHTy9/kGhOTW3AQmDfr7R13ButwSf2Eqrt85fY0HhRBL5KH2+zvgEZNj3zb0cl4IDs/vOOSmS7FOYautLJRLT6/WyUW+ikrP1xC2+788AGggaWaxewcRRiG6uD/5PgQLSzT/zWd3MKVh5HlcF0vZzQghTmgeXyAeeTicppawZlfGtDZtOEbw6OLfP4WydifvSSlzdvsLI0D2dgea2VGHw2280l7grWBD6abPFfvSfsdkZRat6RU3zUkpYe1oLBwvYrr8sEpIkYg5uP6j9pj/m+ovFLw4ow1Wmgs/cC7ok0pz+z265dp41FfWGWDCWEaphSOPbxCT1PtRgLAI1k66NcGwpDSmQ7K7EPPEuPsfBsnjTMSdDmc+rvr9RGXhCEOyiTpmImGxi3aQrfbG24NEWgBs+pFXpQGFI8r09iKQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736d38d8-6847-4344-e7b3-08dc2e7ed4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:35:45.0782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whsGvBGN/qqCaRcYs32JMUEn33a2kiH0bfWmEUgZbk+Frtsn2diOTJEeE/9JQ55sTNyJvDdI7sWee0F7A90k9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
X-Proofpoint-GUID: Gmw0GAfMYLWR45uZ8cyYEfD7UCHc4V23
X-Proofpoint-ORIG-GUID: Gmw0GAfMYLWR45uZ8cyYEfD7UCHc4V23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=697 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402150184

U29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5Lg0KDQpPbiBGcmksIEZlYiAwOSwgMjAyNCwgTWFyZWsg
U3p5cHJvd3NraSB3cm90ZToNCj4gT24gMDguMDIuMjAyNCAyMzo1NCwgVGhpbmggTmd1eWVuIHdy
b3RlOg0KPiA+IE9uIFdlZCwgRmViIDA3LCAyMDI0LCBNYXJlayBTenlwcm93c2tpIHdyb3RlOg0K
PiA+PiBPbiAxOS4wMS4yMDI0IDEwOjQ4LCBVdHRrYXJzaCBBZ2dhcndhbCB3cm90ZToNCj4gPj4+
IEluIGN1cnJlbnQgc2NlbmFyaW8gaWYgUGx1Zy1vdXQgYW5kIFBsdWctSW4gcGVyZm9ybWVkIGNv
bnRpbnVvdXNseQ0KPiA+Pj4gdGhlcmUgY291bGQgYmUgYSBjaGFuY2Ugd2hpbGUgY2hlY2tpbmcg
Zm9yIGR3Yy0+Z2FkZ2V0X2RyaXZlciBpbg0KPiA+Pj4gZHdjM19nYWRnZXRfc3VzcGVuZCwgYSBO
VUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgbWF5IG9jY3VyLg0KPiA+Pj4NCj4gPj4+IENhbGwgU3Rh
Y2s6DQo+ID4+Pg0KPiA+Pj4gCUNQVTE6ICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMjoN
Cj4gPj4+IAlnYWRnZXRfdW5iaW5kX2RyaXZlciAgICAgICAgICAgIGR3YzNfc3VzcGVuZF9jb21t
b24NCj4gPj4+IAlkd2MzX2dhZGdldF9zdG9wICAgICAgICAgICAgICAgIGR3YzNfZ2FkZ2V0X3N1
c3BlbmQNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGR3
YzNfZGlzY29ubmVjdF9nYWRnZXQNCj4gPj4+DQo+ID4+PiBDUFUxIGJhc2ljYWxseSBjbGVhcnMg
dGhlIHZhcmlhYmxlIGFuZCBDUFUyIGNoZWNrcyB0aGUgdmFyaWFibGUuDQo+ID4+PiBDb25zaWRl
ciBDUFUxIGlzIHJ1bm5pbmcgYW5kIHJpZ2h0IGJlZm9yZSBnYWRnZXRfZHJpdmVyIGlzIGNsZWFy
ZWQNCj4gPj4+IGFuZCBpbiBwYXJhbGxlbCBDUFUyIGV4ZWN1dGVzIGR3YzNfZ2FkZ2V0X3N1c3Bl
bmQgd2hlcmUgaXQgZmluZHMNCj4gPj4+IGR3Yy0+Z2FkZ2V0X2RyaXZlciB3aGljaCBpcyBub3Qg
TlVMTCBhbmQgcmVzdW1lcyBleGVjdXRpb24gYW5kIHRoZW4NCj4gPj4+IENQVTEgY29tcGxldGVz
IGV4ZWN1dGlvbi4gQ1BVMiBleGVjdXRlcyBkd2MzX2Rpc2Nvbm5lY3RfZ2FkZ2V0IHdoZXJlDQo+
ID4+PiBpdCBjaGVja3MgZHdjLT5nYWRnZXRfZHJpdmVyIGlzIGFscmVhZHkgTlVMTCBiZWNhdXNl
IG9mIHdoaWNoIHRoZQ0KPiA+Pj4gTlVMTCBwb2ludGVyIGRlZmVyZW5jZSBvY2N1ci4NCj4gPj4+
DQo+ID4+PiBDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4+PiBGaXhlczogOTc3MmI0
N2E0YzI5ICgidXNiOiBkd2MzOiBnYWRnZXQ6IEZpeCBzdXNwZW5kL3Jlc3VtZSBkdXJpbmcgZGV2
aWNlIG1vZGUiKQ0KPiA+Pj4gQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFV0dGthcnNoIEFnZ2Fyd2FsIDxxdWlj
X3VhZ2dhcndhQHF1aWNpbmMuY29tPg0KPiA+PiBUaGlzIHBhdGNoIGxhbmRlZCBzb21lIHRpbWUg
YWdvIGluIGxpbnV4LW5leHQgYXMgY29tbWl0IDYxYTM0ODg1N2U4Ng0KPiA+PiAoInVzYjogZHdj
MzogZ2FkZ2V0OiBGaXggTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluDQo+ID4+IGR3YzNfZ2Fk
Z2V0X3N1c3BlbmQiKS4gUmVjZW50bHkgSSBmb3VuZCB0aGF0IGl0IGNhdXNlcyB0aGUgZm9sbG93
aW5nDQo+ID4+IHdhcm5pbmcgd2hlbiBubyBVU0IgZ2FkZ2V0IGlzIGJvdW5kIHRvIHRoZSBEV0Mz
IGRyaXZlciBhbmQgYSBzeXN0ZW0NCj4gPj4gc3VzcGVuZC9yZXN1bWUgY3ljbGUgaXMgcGVyZm9y
bWVkOg0KPiA+Pg0KPiA+PiBkd2MzIDEyNDAwMDAwLnVzYjogd2FpdCBmb3IgU0VUVVAgcGhhc2Ug
dGltZWQgb3V0DQo+ID4+IGR3YzMgMTI0MDAwMDAudXNiOiBmYWlsZWQgdG8gc2V0IFNUQUxMIG9u
IGVwMG91dA0KPiA+PiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gPj4g
V0FSTklORzogQ1BVOiA0IFBJRDogNjA0IGF0IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmM6Mjg5DQo+
ID4+IGR3YzNfZXAwX291dF9zdGFydCsweGM4LzB4Y2MNCj4gPj4gTW9kdWxlcyBsaW5rZWQgaW46
DQo+ID4+IENQVTogNCBQSUQ6IDYwNCBDb21tOiBydGN3YWtlIE5vdCB0YWludGVkIDYuOC4wLXJj
My1uZXh0LTIwMjQwMjA3ICM3OTc5DQo+ID4+IEhhcmR3YXJlIG5hbWU6IFNhbXN1bmcgRXh5bm9z
IChGbGF0dGVuZWQgRGV2aWNlIFRyZWUpDQo+ID4+ICAgwqB1bndpbmRfYmFja3RyYWNlIGZyb20g
c2hvd19zdGFjaysweDEwLzB4MTQNCj4gPj4gICDCoHNob3dfc3RhY2sgZnJvbSBkdW1wX3N0YWNr
X2x2bCsweDU4LzB4NzANCj4gPj4gICDCoGR1bXBfc3RhY2tfbHZsIGZyb20gX193YXJuKzB4N2Mv
MHgxYmMNCj4gPj4gICDCoF9fd2FybiBmcm9tIHdhcm5fc2xvd3BhdGhfZm10KzB4MWEwLzB4MWE4
DQo+ID4+ICAgwqB3YXJuX3Nsb3dwYXRoX2ZtdCBmcm9tIGR3YzNfZXAwX291dF9zdGFydCsweGM4
LzB4Y2MNCj4gPj4gICDCoGR3YzNfZXAwX291dF9zdGFydCBmcm9tIGR3YzNfZ2FkZ2V0X3NvZnRf
ZGlzY29ubmVjdCsweDE2Yy8weDIzMA0KPiA+PiAgIMKgZHdjM19nYWRnZXRfc29mdF9kaXNjb25u
ZWN0IGZyb20gZHdjM19nYWRnZXRfc3VzcGVuZCsweGMvMHg5MA0KPiA+PiAgIMKgZHdjM19nYWRn
ZXRfc3VzcGVuZCBmcm9tIGR3YzNfc3VzcGVuZF9jb21tb24rMHg0NC8weDMwYw0KPiA+PiAgIMKg
ZHdjM19zdXNwZW5kX2NvbW1vbiBmcm9tIGR3YzNfc3VzcGVuZCsweDE0LzB4MmMNCj4gPj4gICDC
oGR3YzNfc3VzcGVuZCBmcm9tIGRwbV9ydW5fY2FsbGJhY2srMHg5NC8weDI4OA0KPiA+PiAgIMKg
ZHBtX3J1bl9jYWxsYmFjayBmcm9tIGRldmljZV9zdXNwZW5kKzB4MTMwLzB4NmQwDQo+ID4+ICAg
wqBkZXZpY2Vfc3VzcGVuZCBmcm9tIGRwbV9zdXNwZW5kKzB4MTI0LzB4MzVjDQo+ID4+ICAgwqBk
cG1fc3VzcGVuZCBmcm9tIGRwbV9zdXNwZW5kX3N0YXJ0KzB4NjQvMHg2Yw0KPiA+PiAgIMKgZHBt
X3N1c3BlbmRfc3RhcnQgZnJvbSBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyKzB4MTM0LzB4YmQ4
DQo+ID4+ICAgwqBzdXNwZW5kX2RldmljZXNfYW5kX2VudGVyIGZyb20gcG1fc3VzcGVuZCsweDJl
Yy8weDM4MA0KPiA+PiAgIMKgcG1fc3VzcGVuZCBmcm9tIHN0YXRlX3N0b3JlKzB4NjgvMHhjOA0K
PiA+PiAgIMKgc3RhdGVfc3RvcmUgZnJvbSBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMTAvMHgx
ZDQNCj4gPj4gICDCoGtlcm5mc19mb3Bfd3JpdGVfaXRlciBmcm9tIHZmc193cml0ZSsweDJlOC8w
eDQzMA0KPiA+PiAgIMKgdmZzX3dyaXRlIGZyb20ga3N5c193cml0ZSsweDVjLzB4ZDQNCj4gPj4g
ICDCoGtzeXNfd3JpdGUgZnJvbSByZXRfZmFzdF9zeXNjYWxsKzB4MC8weDFjDQo+ID4+IEV4Y2Vw
dGlvbiBzdGFjaygweGYxNDIxZmE4IHRvIDB4ZjE0MjFmZjApDQo+ID4+IC4uLg0KPiA+PiBpcnEg
ZXZlbnQgc3RhbXA6IDE0MzA0DQo+ID4+IGhhcmRpcnFzIGxhc3TCoCBlbmFibGVkIGF0ICgxNDMw
Myk6IFs8YzAxYTU5OWM+XSBjb25zb2xlX3VubG9jaysweDEwOC8weDExNA0KPiA+PiBoYXJkaXJx
cyBsYXN0IGRpc2FibGVkIGF0ICgxNDMwNCk6IFs8YzBjMjI5ZDg+XQ0KPiA+PiBfcmF3X3NwaW5f
bG9ja19pcnFzYXZlKzB4NjQvMHg2OA0KPiA+PiBzb2Z0aXJxcyBsYXN0wqAgZW5hYmxlZCBhdCAo
MTMwMzApOiBbPGMwMTAxNjNjPl0gX19kb19zb2Z0aXJxKzB4MzE4LzB4NGY0DQo+ID4+IHNvZnRp
cnFzIGxhc3QgZGlzYWJsZWQgYXQgKDEzMDI1KTogWzxjMDEyZGQ0MD5dIF9faXJxX2V4aXRfcmN1
KzB4MTMwLzB4MTg0DQo+ID4+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0K
PiA+Pg0KPiA+PiBJTUhPIGR3YzNfZ2FkZ2V0X3NvZnRfZGlzY29ubmVjdCgpIHJlcXVpcmVzIHNv
bWUga2luZCBvZiBhIGNoZWNrIGlmDQo+ID4+IGR3Yy0+Z2FkZ2V0X2RyaXZlciBpcyBwcmVzZW50
IG9yIG5vdCwgYXMgaXQgcmVhbGx5IG1ha2VzIG5vIHNlbnNlIHRvIGRvDQo+ID4gSSBkb24ndCB0
aGluayBjaGVja2luZyB0aGF0IGlzIHN1ZmZpY2llbnQsIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQn
cyB0aGUNCj4gPiBjYXNlIGhlcmUuDQo+ID4NCj4gPj4gYW55IGVwMCByZWxhdGVkIG9wZXJhdGlv
bnMgaWYgdGhlcmUgaXMgbm8gZ2FkZ2V0IGRyaXZlciBhdCBhbGwuDQo+ID4+DQo+ID4gSWYgdGhl
cmUncyBpbmRlZWQgbm8gZ2FkZ2V0X2RyaXZlciBwcmVzZW50LCB0aGVuIHdlIHdvdWxkbid0IGdl
dCB0aGlzDQo+ID4gc3RhY2sgdHJhY2UuIChpZS4gZHdjM19lcDBfb3V0X3N0YXJ0IHNob3VsZCBv
Y2N1cnMgd2hlbiBnYWRnZXRfZHJpdmVyIGlzDQo+ID4gcHJlc2VudCkuIFRoaXMgaXMgYSByYWNl
IGhhcHBlbmVkIGJldHdlZW4gYmluZGluZyArIHN1c3BlbmQuDQo+IA0KPiBJIGhhdmUgbm8gZ2Fk
Z2V0IGNvbXBpbGVkIGludG8gdGhlIGtlcm5lbCBhbmQgbm8gc3VjaCBjcmVhdGVkIHZpYSANCj4g
Y29uZmlnZnMsIHNvIGhvdyBjYW4gdGhpcyBiZSBjYXVzZWQgYnkgYSByYWNlPw0KDQpBaC4uLiBJ
biB0aGF0IGNhc2UsIHdlIGdvdCB0aHJvdWdoIHRoZSBpbmNvbXBsZXRlL3dyb25nIGNoZWNrIGZv
cg0KZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KCk6DQoJaWYgKGR3Yy0+ZXAwc3RhdGUgIT0g
RVAwX1NFVFVQX1BIQVNFKQ0KDQpTaW5jZSB0aGVyZSdzIG5vIGdhZGdldCBkcml2ZXIsIHRoZSBj
b250cm9sbGVyIG5ldmVyIHN0YXJ0ZWQgYW5kIHRoZQ0KZXAwc3RhdGUgaXMgZGVmYXVsdGVkIHRv
IEVQMF9VTkNPTk5FQ1RFRCwgd2hpY2ggZXhwbGFpbmVkIHdoeSBpdCBnb3QNCmludG8gdGhlIHRp
bWVvdXQgY29uZGl0aW9uIGFib3ZlIGFuZCBpbmNvcnJlY3RseSBhdHRlbXB0IHRvIHN0YXJ0IHRo
ZQ0KY29udHJvbCB0cmFuc2Zlci4NCg0KPiANCj4gDQo+IA0KPiA+IEkgdGhpbmsgc29tZXRoaW5n
IGxpa2UgdGhpcyBzaG91bGQgYmUgc3VmZmljaWVudC4gV291bGQgeW91IG1pbmQgZ2l2aW5nDQo+
ID4gaXQgYSB0cnk/DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gPiBpbmRleCA1NjQ5NzZiM2UyYjku
LjE5OTBkNjM3MTA2NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5j
DQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IEBAIC0yNjU2LDYgKzI2
NTYsMTEgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3Qoc3RydWN0IGR3
YzMgKmR3YykNCj4gPiAgIAlpbnQgcmV0Ow0KPiA+ICAgDQo+ID4gICAJc3Bpbl9sb2NrX2lycXNh
dmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiA+ICsJaWYgKCFkd2MtPnB1bGx1cHNfY29ubmVjdGVk
KSB7DQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+
ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCWR3Yy0+Y29ubmVjdGVkID0g
ZmFsc2U7DQo+ID4gICANCj4gPiAgIAkvKg0KPiA+DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIHJl
cG9ydGVkIGlzc3VlLiBGZWVsIGZyZWUgdG8gYWRkOg0KPiANCj4gVGVzdGVkLWJ5OiBNYXJlayBT
enlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+IA0KDQpUaGFua3MgZm9yIHRo
ZSByZXBvcnQgYW5kIFRlc3RlZC1ieSEgSSdsbCBzZW5kIGEgZml4IHBhdGNoIHNvb24uDQoNCkJS
LA0KVGhpbmg=

