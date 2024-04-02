Return-Path: <linux-kernel+bounces-128833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44EE896036
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D773C1C226CF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C378274;
	Tue,  2 Apr 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qNSwNjUP";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BwSqlPg1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LZjtseKc"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F15026B;
	Tue,  2 Apr 2024 23:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712100761; cv=fail; b=CSDrRqlZNBH5sNaJzCI3uxw+Xw8q3zAZ5pGcJ6jW4GnNe5ANzoLVJiAmPKpjVBTIb6/YZOgj8tV6LZglIU/u4BvTm6olCi7yhtMGeRg6pXAExwG2M/fsWIwjPZCt4flbIHc1VDLfLr9y5/1GZ1Y0NxoE+o0Cjx9zzuSbLnbSBWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712100761; c=relaxed/simple;
	bh=//JVA4v2unD30M5CsdPPC1zao4vHX1pOD4nMYFTkoZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cSe6WlL4OFhukKv1CR75skHil8TsgS7LpfFbzDzCfVW+EJPtQbvmHrPnGyF+9schBsRrDVrXssngj4bSVmA75NT9Kk/K7aqIGhbfOBKTkUZ1YHciDV8IScEzzBIIHrp4p0LpPhAKPOXcl+pMWSAQat5Gup4aB3OUbt7/NVjuQx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qNSwNjUP; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=BwSqlPg1; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=LZjtseKc reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432IO1NU026569;
	Tue, 2 Apr 2024 16:32:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=//JVA4v2unD30M5CsdPPC1zao4vHX1pOD4nMYFTkoZg=; b=
	qNSwNjUPrtNEP1BsOETzOI/ke4+2JTtKyr8m3tYcRlHjSb4oVDSarRa4TdV8sU1k
	9Zly54qdAHhsdkYApc3Pjg/8NkiCq89+nV3ja/fwijiOI7uBJvQr2e1rLqmgod25
	7w9RvaLpUkWE+nGkD5DiDw3dKgRyuacwZfdqNB/WnyBe4G8ZA1hTd02TiCE2HGQI
	7hbXXpARgVwsKEa3RCQO+hV4s88p39PmqDFesNF5Y63s1ZRIOYDLO4NPVyIJAQf1
	UDP4lD0xU17fc87/XvvoxLEk/FJ/2iWyVoHXX4k2EFiYh6G4Q4dPPokIwAZczGNT
	fhHsUxZ4WeLEg2t3cmK8QA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3x8q82h29y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712100750; bh=//JVA4v2unD30M5CsdPPC1zao4vHX1pOD4nMYFTkoZg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BwSqlPg1DRhpasGTfVGKo9ZYa4B+02EFo+yYrnoTvjOXAhpFDtcT2srb6B8lLxoiY
	 jBTJq6VrEXAxIszFQu3HJEoLVwuzOWjbmQCw5selB+hE3Gx5C8XFoAM1+9zAsR2lYO
	 mDBiqYOiixtNUt2rurvsBuYQNZrDYizF4CONsvc2XZ2m3NBkSQokOR/DyZsR2SN4fm
	 z3uZE+lREfdRGGjv7x+qPaz0/rP3DiV1OA6jxMvpd61swkv+GTNg95RqWUIO/tEd8B
	 Hy6/fushAWeVyxZuPksnyfkAF7+72LhoBd46AxLzLfS6t6wpJeILnU35bkz39q9M8p
	 q4q7AkiJUU5Ug==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7A3F3401C6;
	Tue,  2 Apr 2024 23:32:30 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 273AAA006D;
	Tue,  2 Apr 2024 23:32:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=LZjtseKc;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id A187540453;
	Tue,  2 Apr 2024 23:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QihQMne7FwUqMAYr7zHg4fjYTGmTVZAPG2E5nmvbS9o91/dgWsVbgXFjrEioNb7Vl2xwEDlBA3LaCre0rcYLVFhdUFQ6XqOOhmOLq48YVUDPpT/cUtLBnuolcJbEyMtMnZrOV3b1YJdWE1FPx/ZakJJ3SbUgXgu99WeV6iLfB5N9qrZfhCtdmDiF3iaO+GPAlFaIwBq4yX/W/B30ovSwo0xBLlW7eLNomQih6OoZUH1M84855oRVS/p2dYHKu45JJzh9SEh6JDyGrDO/kwRkMm8sUvEHfawPh5j5UzbeTBAVn50MwXSTHHjNNO/4zFeeLhaHCCz2N9cmAHzPQ+ev2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//JVA4v2unD30M5CsdPPC1zao4vHX1pOD4nMYFTkoZg=;
 b=KntadmoxbKwvhVQVeSghL6kHtv6kNEF3xBZiAGzsxpQBGbt1LmqjvLNdscJmLRznL4BWFbhKhsld08u11RFekT5eiSRMYe8IvP9WBUbj5uMuK5RHje3fDQvl5ImrjJHR86HjyqlMJ+sZr3pM0XeiT0nPY2uLZGf47uv4bqZGqwuhy/IpOl/T4lrULBDOkCDFkjsf/u+/Xzye0XQazHHN4rmK+Kcjm6ECbO0ABZ6o/pYIGjf/sWXhmxFVLEaSbSvh8UHMcdT2QG6sIM7qVPqsdXTGPRy9Y41OYaoTarzumDKqdCOMoWuIe3mHCVSC9a+EsqRAvaKrECCyGdVvBuTQIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//JVA4v2unD30M5CsdPPC1zao4vHX1pOD4nMYFTkoZg=;
 b=LZjtseKcJN+82IUHhpXWpjYrOK12zdS6DRSqAyiqN5eJmHAeMZ42Co7x5bvhw6gbby5hhVf41FVVPqqN0GtcVyCV08C1H67UM6gTKv3AjL01q2OajZjl1M05OAlavrRLI7GesX1x3DKtZoQy0zbUFekqdkmXqKP7JCnsPP+o9QI=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 23:32:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 23:32:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>, Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v18 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHaf3Fvfja053ymrUitTNv6hRyEGbFVrR0A
Date: Tue, 2 Apr 2024 23:32:24 +0000
Message-ID: <20240402233218.5kngtj56qellnrmo@synopsys.com>
References: <20240326113253.3010447-1-quic_kriskura@quicinc.com>
 <20240326113253.3010447-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240326113253.3010447-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|SJ0PR12MB6783:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 g5DG4gQzIMQtX0mEil4EIlkTjMkbLg7BWupGIiuN/R3ZnbYI262qGLXqL0xcNBkb99ccMp9Oxtga5e0dbZhVYAYEJ3Z7iyRBlMYHNvscqKG828/mgMsoBa7/AYIpXkAjtuwKRfig/7C4xM7v1cSAZaL6pMXH1hEU9Aa63BhmrJz2kvl4xcOqYmghuy1lf5a6WYNQwSSK3RZu/6SHY1ulB1D0kaRDZHknKuDcgtlNqlDpVRBq+zxHq3RD6BJU8o+YZwWGoQzoPdwAaSit0XtYyJhoCJtPF7mfizmsMLC3Q49tVjbH92p6gSfF1lbU2SdRACt0lh1qgvSejv7iit4CLHdqcn3ifz7138nEhVZcPZuyuiJQ2oLIEn0yq57u48IoteqdBEIxymmIVz4qgZN24U5kmtF0TqA2BUz8c5n4D3t/3/bRdqvXIJIlK9hZTAAAcM3czQk5e/JkePOpSKgxTBerfUlSrHDR3R65mniRhRRheB9td+bT/pXh9VU01XW+4CBGwYQsOa2OSemeU0MAtijtFmqQvu+JYfUsHJMhavXZbqN6lrfgMbEMv0momc7h2sAc0wUxOI8Dvaio+1SWGsF1yu96O3pCatwMFmOxjqE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cDVPNUp6akVtbGUyMlN5TnpjS0gxK2dGb3plMFFaVlNVc1FNdnRvZHFDdVBB?=
 =?utf-8?B?c0M0bEhqVDFaVWsvVzVPZ2xPSlVVYWpTMDF3RGZTcE9sQWtSUi9XNVFDZWx2?=
 =?utf-8?B?MVJkemRXUzRnSUIrWVJzQko3emNmeHVnOFoyUElBbHZxTGh5U3ZTYjBjb3g1?=
 =?utf-8?B?LzNvTGZpVjdWYVdoeWtqOHBlRTlKRlZ3VXB6aFNRdDBUNkVEUkZaMEVQVStO?=
 =?utf-8?B?VVczeFpGOGJLb3ZjNnczU0JrMjhXRVVIZFl5cW1yWTBjclovVU05UDZtVkpy?=
 =?utf-8?B?WG5hUSt2bnBXdkJYWGFEYkV2NFM3ancrWnhBcndkRm9iZk1aaktwNXhZT3E0?=
 =?utf-8?B?b0JhWFJiMEVYRmk5Z3I0Rmg5blZKNmw5Tm5SeDhTOG4zT2V4czZoWCtrR3pq?=
 =?utf-8?B?TVRmNFdPbTNhSHVVejU5WjlBWXNEVHJoUFlCZytYSVNTYzhCL2xwSXJRYjhX?=
 =?utf-8?B?UWcvbzAxbG1YZ1FTK24yTklHQXNOeG5RUGxmSkhPd0tDajVoMDJqNjFPeUxx?=
 =?utf-8?B?bTkxSHpaa2Jyb21KNXh4dWdmbVJFUU5XSFVtakdmamVRdDNkU3c1cjRCb3J5?=
 =?utf-8?B?ZUZJNmNkVVpzNnlsOHpMajhwMGRscHFjVDJNRFpHR0d2bFhWVnpUd0I2d1B2?=
 =?utf-8?B?Z2E3N01qdnNUb2Q3QXNIaDZZdlo0U3o1ZWlmd1luYnd5QVZoejJRWXRkaXlj?=
 =?utf-8?B?dTE1MVM4YWFVdHpzc2VQOVpEdTRxbThNMWlDQS90dEgyQm1YVXlSWU5pTkNU?=
 =?utf-8?B?UlhNY0VkQWdMYnJ0dUJDYXZmanpqalFpYjYyeXlxOCtHWmxYQkpGTWh1TWNE?=
 =?utf-8?B?eTFKdHIwWmU2dW9aWUNTUFRLK2JnUGUweG54NVhXV3lqdkVJbndYT0s2dXFP?=
 =?utf-8?B?YVdZVHRDNC91b3B2U2ZKT1FMc2F5NDI5ZXpTM05acTA5Q0kwSkJJWWVpbkFk?=
 =?utf-8?B?M1B1SlkrK2drQ2JYOHk4Vm1xZjd2a1Vyc0pRZ0JmNVlBVE1KRlhlckIzR2gz?=
 =?utf-8?B?a0puQ3JQVkxyYjJ4SnNzcmNsNzRkN2dIUHp1YjRjU08vVTM4R0t3dWZQYnNI?=
 =?utf-8?B?eTdZQ3RGcXBXbTBDWjg3MU4zdkU0aDgwN1Q1OTc5V2pRMVMwam8vUTlMMkV2?=
 =?utf-8?B?UU8xY2E1WjlvNTc0bVJkaTVKdHl3djNTeEphOFhwNFkrM0ZDZFFSdG04ZUpo?=
 =?utf-8?B?R3V1cXcyczdTYzhUWEtEUkNYOWZhWGU0d0I4SmJnUGhJWUkrVXhjcGJnNUx6?=
 =?utf-8?B?ZGVRUFU2aVNaZHczd2dob0VuUk02TGpCODA5VExOc0tuRzl6RS9rckZDdjV0?=
 =?utf-8?B?MHZTcm1pcVdlZU5tV05jRmk1UmNKZXQ2d1Ivai96OGV0bXZqRTZYSWx3dmxP?=
 =?utf-8?B?Z3dGdzVxNWVGQjZmeEQ1NlQ3OVg5dWQzRENWYjFSTUh4b2dLaVFmU2hOOExW?=
 =?utf-8?B?MTU2NmEwY3JrQXdEaUZGbkRyb3ZqM2pkdGY5N09oZ3BaNTNndGtteDdHb3RO?=
 =?utf-8?B?ckpnK2llcnNoNFRadkpmUHJ5cDhhbW5pYzN2SFl6cmVOU01FYkkrMFVRbWlK?=
 =?utf-8?B?R0Y2Q2ZCMFBuRXlhdlAwWCtielBCMWlmeEZYd29mT2ZxWkVQN3ExanV6bFJP?=
 =?utf-8?B?Z1JRSjc1NzZFdzYzR0dXb3dkcWhCUXNlK25IMUtZcHVaeXkzZkJSYkQ5TmMz?=
 =?utf-8?B?UzQ0eG8wTG1BUEdDZUpEdHBDRksyNCs0d0ZTR0RPNXBRdUcvaHZrYVR0RzNW?=
 =?utf-8?B?RmJiWUwyVG92TzVLUUNpQVp5dmhsdU83TzdMSEhIeGpsOW9lMllWcGkycUpB?=
 =?utf-8?B?MmRrRGpETTQrWnRHTDY4YXZzRG84a1NOd0pFRmF5ZmlIZDZvUVlwaWRPcjhI?=
 =?utf-8?B?bDZZQ2dsQ0lBdDhxcnhLaUo5a2pxQm1PMXBLM0tpb2ZIQ1Z5eGNiQWpIV2ZQ?=
 =?utf-8?B?eHJuQWNWcjNJeUxsVkNVUmRqczBVVzRtNnZJN1lGTG45bW84eWhyMFNzNzgw?=
 =?utf-8?B?dXpuby9RYjFqRjlJZ081KzcxN2VLR2V5TTZycUtyT0hPdmdtMHRSV2lFcjRn?=
 =?utf-8?B?QmJIVTg4OUwyc0g0Z3JtZTVRZWVXRW52YWpBWG9QR1ZFRkg5Z2hkS3N4ZHAy?=
 =?utf-8?B?V25Bc2ViWTRLNkZvbXprR2lya1hJTVhSZTJJNHJ3KzVRdS9SOUZWN3E3bEha?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16BB90E5E656C84F841B70203E9625EC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	foPTuYjhSQ/6A/7y90qx2AbgbbBZX7ftMZpQ1yP/7bShu9TDi9fpcbqI3tBY8GNIGa3FVb+HDe+ZuDoyaIyhbbtsathlhtKvLVO3QWlShw2Vi7AGuE2s0Vc/02RAvfe8eat8e63HSgOEqE03uKvTnX2VwiVI4Lsr5Nfs0qB9zEF0NMwZFjiO3qjRG3E7n0/2UQh7pEgxqvLNW5kw2dk9W3hpmhgYXpIs2mdXLj2OaicOmMdJ+ADYAEoFRPxTfzLxrhSfx6DzbGFqdIcobh5FFeFkMND9V3zZSrgqA00Gp5YF3F9qtJ+Wsr5nRIJ9kDsqhp16U867p8YUiCVTHE2FPA42migY9j9B7VrT+DksW8jJCoSlQffuhqPpxKLUFZV3hTfcSz8rBZEzBdeuui/LKirHdhR1xo5RJtgSfNExVa82JKINz2iwTJ132vmadLTbZqfpjVvxLsYX2cYAuwzxpB8A2V8iXAHQdgU/YKnGz22wRaQjFmtO7SS7YOXTRhd9ppMoGvKm9mqsOJFHCb0B9kOsSfyPrpZHrXt3l1yk1LAbFe42duwgxM7ENvWv6XHxUXbiVYO8i395QJfNG/Iv6cQCtsg8fsEs8P5wiiJAxOQjdyIad5crZDoyi1mMH196z/gJ3nhJt7/fSiGo2VUpTw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7390942-624b-4c55-7b3e-08dc536d2703
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 23:32:24.9847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fia6FfdLooJxm80u5aw+v2IALUdc3T/Pcx9SUXw8vYfXcu8KgKFM5gsJC24EBt/wGa9hLU5A9pIffUeSo2poQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783
X-Proofpoint-GUID: PrmY2yhcC1SMEcxSwltUDsPvehbwFn97
X-Proofpoint-ORIG-GUID: PrmY2yhcC1SMEcxSwltUDsPvehbwFn97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020172

T24gVHVlLCBNYXIgMjYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEFsbCBEV0Mz
IE11bHRpIFBvcnQgY29udHJvbGxlcnMgdGhhdCBleGlzdCB0b2RheSBvbmx5IHN1cHBvcnQgaG9z
dCBtb2RlLg0KPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9u
bHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJl
Z2lzdGVycyB0byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiB1c2IzIHBvcnRzIHBy
ZXNlbnQgb24gbXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3Qg
SFMNCj4gY2FwYWJsZS4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5kIHVzYjMgcGh5
IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBudW1fdXNiM19wb3J0cy4g
VGhlIGludGVudGlvbiBpcyBhcyBmb2xsb3dzOg0KPiANCj4gV2hlcmV2ZXIgd2UgbmVlZCB0byBw
ZXJmb3JtIHBoeSBvcGVyYXRpb25zIGxpa2U6DQo+IA0KPiBMT09QX09WRVJfTlVNQkVSX09GX0FW
QUlMQUJMRV9QT1JUUygpDQo+IHsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19w
aHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gCXBoeV9zZXRfbW9kZShkd2MtPnVzYjNfZ2Vu
ZXJpY19waHlbaV0sIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gfQ0KPiANCj4gSWYgbnVtYmVyIG9m
IHVzYjIgcG9ydHMgaXMgMywgbG9vcCBjYW4gZ28gZnJvbSBpbmRleCAwLTIgZm9yDQo+IHVzYjJf
Z2VuZXJpY19waHkuIElmIG51bWJlciBvZiB1c2IzLXBvcnRzIGlzIDIsIHdlIGRvbid0IGtub3cg
Zm9yIHN1cmUsDQo+IGlmIHRoZSBmaXJzdCAyIHBvcnRzIGFyZSBTUyBjYXBhYmxlIG9yIHNvbWUg
b3RoZXIgcG9ydHMgbGlrZSAoMiBhbmQgMykNCj4gYXJlIFNTIGNhcGFibGUuIFNvIGluc3RlYWQs
IG51bV91c2IyX3BvcnRzIGlzIHVzZWQgdG8gbG9vcCBhcm91bmQgYWxsDQo+IHBoeSdzIChib3Ro
IGhzIGFuZCBzcykgZm9yIHBlcmZvcm1pbmcgcGh5IG9wZXJhdGlvbnMuIElmIGFueQ0KPiB1c2Iz
X2dlbmVyaWNfcGh5IHR1cm5zIG91dCB0byBiZSBOVUxMLCBwaHkgb3BlcmF0aW9uIGp1c3QgYmFp
bHMgb3V0Lg0KPiBudW1fdXNiM19wb3J0cyBpcyB1c2VkIHRvIG1vZGlmeSBHVVNCM1BJUEVDVEwg
cmVnaXN0ZXJzIHdoaWxlIHNldHRpbmcgdXANCj4gcGh5J3MgYXMgd2UgbmVlZCB0byBrbm93IGhv
dyBtYW55IFNTIGNhcGFibGUgcG9ydHMgYXJlIHRoZXJlIGZvciB0aGlzLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogS3Jpc2huYSBLdXJhcGF0aSA8cXVpY19rcmlza3VyYUBxdWljaW5jLmNvbT4NCj4g
UmV2aWV3ZWQtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW4rbGluYXJvQGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmggfCAgNSArKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IGlu
ZGV4IDNlNTU4MzhjMDAwMS4uZmFiNzY2NGMxMmMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiBAQCAtMzks
NiArMzksNyBAQA0KPiAgI2luY2x1ZGUgImlvLmgiDQo+ICANCj4gICNpbmNsdWRlICJkZWJ1Zy5o
Ig0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS1leHQtY2Fwcy5oIg0KPiAgDQo+ICAjZGVmaW5l
IERXQzNfREVGQVVMVF9BVVRPU1VTUEVORF9ERUxBWQk1MDAwIC8qIG1zICovDQo+ICANCj4gQEAg
LTE4NzksMTAgKzE4ODAsNTYgQEAgc3RhdGljIGludCBkd2MzX2dldF9jbG9ja3Moc3RydWN0IGR3
YzMgKmR3YykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIGludCBkd2MzX3Jl
YWRfcG9ydF9pbmZvKHN0cnVjdCBkd2MzICpkd2MpDQo+ICt7DQo+ICsJdm9pZCBfX2lvbWVtICpi
YXNlOw0KPiArCXU4IG1ham9yX3JldmlzaW9uOw0KPiArCXUzMiBvZmZzZXQ7DQo+ICsJdTMyIHZh
bDsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVtYXAgeEhDSSBhZGRyZXNzIHNwYWNlIHRvIGFjY2Vz
cyBYSENJIGV4dCBjYXAgcmVncyBzaW5jZSBpdCBpcw0KPiArCSAqIG5lZWRlZCB0byBnZXQgaW5m
b3JtYXRpb24gb24gbnVtYmVyIG9mIHBvcnRzIHByZXNlbnQuDQo+ICsJICovDQo+ICsJYmFzZSA9
IGlvcmVtYXAoZHdjLT54aGNpX3Jlc291cmNlc1swXS5zdGFydCwNCj4gKwkJICAgICAgIHJlc291
cmNlX3NpemUoJmR3Yy0+eGhjaV9yZXNvdXJjZXNbMF0pKTsNCj4gKwlpZiAoSVNfRVJSKGJhc2Up
KQ0KPiArCQlyZXR1cm4gUFRSX0VSUihiYXNlKTsNCg0KTG9va3MgbGlrZSB5b3UgZm9yZ290IHRv
IGFkZHJlc3Mgc29tZSBvZiB0aGUgY29tbWVudHMgeW91IHNhaWQgeW91J2QNCnVwZGF0ZSBwcmV2
aW91c2x5IGlmIHlvdSBzdWJtaXQgYSBuZXcgdmVyc2lvbiB0byB0aGUgc2VyaWVzLg0KDQpbKl0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiL2FmNzMxMTBkLWUxM2UtNDE4My1hZjEx
LWFlZDg2OWFjMGEzMUBxdWljaW5jLmNvbS8NCg0KQlIsDQpUaGluaA0KDQo+ICsNCj4gKwlvZmZz
ZXQgPSAwOw0KPiArCWRvIHsNCj4gKwkJb2Zmc2V0ID0geGhjaV9maW5kX25leHRfZXh0X2NhcChi
YXNlLCBvZmZzZXQsDQo+ICsJCQkJCQlYSENJX0VYVF9DQVBTX1BST1RPQ09MKTsNCj4gKwkJaWYg
KCFvZmZzZXQpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQl2YWwgPSByZWFkbChiYXNlICsgb2Zm
c2V0KTsNCj4gKwkJbWFqb3JfcmV2aXNpb24gPSBYSENJX0VYVF9QT1JUX01BSk9SKHZhbCk7DQo+
ICsNCj4gKwkJdmFsID0gcmVhZGwoYmFzZSArIG9mZnNldCArIDB4MDgpOw0KPiArCQlpZiAobWFq
b3JfcmV2aXNpb24gPT0gMHgwMykgew0KPiArCQkJZHdjLT5udW1fdXNiM19wb3J0cyArPSBYSENJ
X0VYVF9QT1JUX0NPVU5UKHZhbCk7DQo+ICsJCX0gZWxzZSBpZiAobWFqb3JfcmV2aXNpb24gPD0g
MHgwMikgew0KPiArCQkJZHdjLT5udW1fdXNiMl9wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5U
KHZhbCk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlkZXZfd2Fybihkd2MtPmRldiwgInVucmVjb2du
aXplZCBwb3J0IG1ham9yIHJldmlzaW9uICVkXG4iLA0KPiArCQkJCSBtYWpvcl9yZXZpc2lvbik7
DQo+ICsJCX0NCj4gKwl9IHdoaWxlICgxKTsNCj4gKw0KPiArCWRldl9kYmcoZHdjLT5kZXYsICJo
cy1wb3J0czogJXUgc3MtcG9ydHM6ICV1XG4iLA0KPiArCQlkd2MtPm51bV91c2IyX3BvcnRzLCBk
d2MtPm51bV91c2IzX3BvcnRzKTsNCj4gKw0KPiArCWlvdW5tYXAoYmFzZSk7DQo+ICsNCj4gKwly
ZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9ICZwZGV2
LT5kZXY7DQo+ICAJc3RydWN0IHJlc291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiArCXVuc2lnbmVk
IGludAkJaHdfbW9kZTsNCj4gIAl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiAgCXN0cnVjdCBkd2Mz
CQkqZHdjOw0KPiAgCWludAkJCXJldDsNCj4gQEAgLTE5NjYsNiArMjAxMywyMCBAQCBzdGF0aWMg
aW50IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdvdG8g
ZXJyX2Rpc2FibGVfY2xrczsNCj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqIEN1cnJlbnRseSBv
bmx5IERXQzMgY29udHJvbGxlcnMgdGhhdCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gKwkgKiBj
YW4gaGF2ZSBtb3JlIHRoYW4gb25lIHBvcnQuDQo+ICsJICovDQo+ICsJaHdfbW9kZSA9IERXQzNf
R0hXUEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gKwlpZiAoaHdfbW9k
ZSA9PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9IT1NUKSB7DQo+ICsJCXJldCA9IGR3YzNfcmVhZF9w
b3J0X2luZm8oZHdjKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWdvdG8gZXJyX2Rpc2FibGVfY2xr
czsNCj4gKwl9IGVsc2Ugew0KPiArCQlkd2MtPm51bV91c2IyX3BvcnRzID0gMTsNCj4gKwkJZHdj
LT5udW1fdXNiM19wb3J0cyA9IDE7DQo+ICsJfQ0KPiArDQo+ICAJc3Bpbl9sb2NrX2luaXQoJmR3
Yy0+bG9jayk7DQo+ICAJbXV0ZXhfaW5pdCgmZHdjLT5tdXRleCk7DQo+ICANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4g
aW5kZXggYzA3ZWRmYzk1NGY3Li40MGIwMGE4OTVhMmEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5oDQo+IEBAIC0x
MDM5LDYgKzEwMzksOCBAQCBzdHJ1Y3QgZHdjM19zY3JhdGNocGFkX2FycmF5IHsNCj4gICAqIEB1
c2IzX3BoeTogcG9pbnRlciB0byBVU0IzIFBIWQ0KPiAgICogQHVzYjJfZ2VuZXJpY19waHk6IHBv
aW50ZXIgdG8gVVNCMiBQSFkNCj4gICAqIEB1c2IzX2dlbmVyaWNfcGh5OiBwb2ludGVyIHRvIFVT
QjMgUEhZDQo+ICsgKiBAbnVtX3VzYjJfcG9ydHM6IG51bWJlciBvZiBVU0IyIHBvcnRzDQo+ICsg
KiBAbnVtX3VzYjNfcG9ydHM6IG51bWJlciBvZiBVU0IzIHBvcnRzDQo+ICAgKiBAcGh5c19yZWFk
eTogZmxhZyB0byBpbmRpY2F0ZSB0aGF0IFBIWXMgYXJlIHJlYWR5DQo+ICAgKiBAdWxwaTogcG9p
bnRlciB0byB1bHBpIGludGVyZmFjZQ0KPiAgICogQHVscGlfcmVhZHk6IGZsYWcgdG8gaW5kaWNh
dGUgdGhhdCBVTFBJIGlzIGluaXRpYWxpemVkDQo+IEBAIC0xMTg2LDYgKzExODgsOSBAQCBzdHJ1
Y3QgZHdjMyB7DQo+ICAJc3RydWN0IHBoeQkJKnVzYjJfZ2VuZXJpY19waHk7DQo+ICAJc3RydWN0
IHBoeQkJKnVzYjNfZ2VuZXJpY19waHk7DQo+ICANCj4gKwl1OAkJCW51bV91c2IyX3BvcnRzOw0K
PiArCXU4CQkJbnVtX3VzYjNfcG9ydHM7DQo+ICsNCj4gIAlib29sCQkJcGh5c19yZWFkeTsNCj4g
IA0KPiAgCXN0cnVjdCB1bHBpCQkqdWxwaTsNCj4gLS0gDQo+IDIuMzQuMQ0KPiA=

