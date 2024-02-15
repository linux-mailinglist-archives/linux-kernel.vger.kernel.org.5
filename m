Return-Path: <linux-kernel+bounces-67842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B64058571B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27322B23FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57812145B1D;
	Thu, 15 Feb 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Cb4wqQYe";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="F6khQb5e";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="FJ1DImXw"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F721369AF;
	Thu, 15 Feb 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040403; cv=fail; b=bszPdjopXR0zJlTA4WDr4bOIoAKZM+vN+rLDUO2ayoVO/AvFXcr9fTx957b8VuUmliQ+0adi5J2KscAITD2ll/TQNSNNBhiAyl7HbBXnB+PXYk1jD4IRk3O4KjQUEoWkJJBMR4yDwa8dCrQuxn/QruCioRY9kEImML2AuQ6STDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040403; c=relaxed/simple;
	bh=U1BX2le4qoaShb99UJByAzErhbtdRdLTNX3z84xXtj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RzVb0FqTWW08LzUrwGFwTLK31/9OrBnbZHFV2pFRF1walTUpFeXbr3nUVTJVAEtCdxjRtige68/SOyN2mmdnH12cpXZGNpv9cB7ivY/HPlQQyqmGRnLU9UrM5unXJ5xvBBOcoVUY/gSJLXRQW8UVjdXJeerj3K9Y/LRvzTMQBA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Cb4wqQYe; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=F6khQb5e; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=FJ1DImXw reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXijL032271;
	Thu, 15 Feb 2024 15:39:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=U1BX2le4qoaShb99UJByAzErhbtdRdLTNX3z84xXtj4=; b=
	Cb4wqQYehNNcXE9lyFdhWpDVyM7KaWVP6hz3C5Fzq50VPDcmI6Y7cYdXYONbI5cm
	HV2eVOjyqWJpHZnItscJaLjNYXcts7ICbaDNSFnns63ENzZGL3/14Y10gUuMUNec
	TvBVkISrtGA5w7dNDoJyDikoheic941/giI2aDIGjYXIhebGxenMj7I/0CtP+qoq
	DYM9TEZC+iUzISOgeJ/o0F1MQYy6dmEVd3RV+fI8vDhtAY6Cfe4f0aOvwCBu2Mk+
	CvVJBZWn1hGepnI91gJNfL3Nxz8FhWWrGoC5IGgQfu8XOW9ve+koo3GyfH5rBDmm
	ySDq9VZMfNasI7cbIc6sXw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w6996wvbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040389; bh=U1BX2le4qoaShb99UJByAzErhbtdRdLTNX3z84xXtj4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=F6khQb5eaaZPzwT5rZgYN/K4FIS2hHb/mnwUTJfH6D2Xrbib9ZVM62jVVsv9el0Hb
	 RZbgIibOVilBni7c8nJYSmCAYfrtHq56pTbbdYz6puikRW9/Cm18N/1vy/fporgsTk
	 zFFWljBxEhYG5CtF+IG0qY0Tbpm3hfN0ZAnqi8u7mnVDpS78v8axEFWrKk7hhfUvzK
	 zIaxShoGdZVVPwN82dPYmAPOAmaemr8Ri3X6h+/DtR8f1C0VMaoQ0wumw/fRPCNmnV
	 /+veBdRRfd3VFmyqlCAnwkjwvkvRgdCQpnZkmg94eVxIw6x84gXOktNVfGmlxQ7NBI
	 xnhjf1netgdmg==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0787F4035F;
	Thu, 15 Feb 2024 23:39:47 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id BE06CA0085;
	Thu, 15 Feb 2024 23:39:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=FJ1DImXw;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id E5A00401C6;
	Thu, 15 Feb 2024 23:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSj8bwvj0HXODV3ndusODkQoh9eyU4sQZH2xsY8hS4o7SVk2dnkNBqHqYIoN3NXN4NH7/o5B7ieHelJtg8XJzhcyrdkehoIPzh2Gop94vDdDwyxfF0Gweb88pWlT+n3Lw4DBrJkBfgc0Q+ARV7Q4opImJNFCgW5L5ESoWRZACxOy+npg9D4gBR/SdHI+Yu6zDXTIF2PqHWxA3P8w8T2gwyOMjgj/1LiGqVgSPxuUkED9JAgshTkaDclK3Vn2YzGWVe2PNjfhiyJ/6yeGh2ANxlpzjcyFOylJdPvcYhqtW+X5ubVVEJPVnyiXJofMHsmIAgP9gf1pzHAFDUZej15c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1BX2le4qoaShb99UJByAzErhbtdRdLTNX3z84xXtj4=;
 b=fv68S8cr6LtT5HRkcaAToYyYKgn2HCP13hGbSKQSBhvqVk0UzznjAIcK/qh05Rb1jXEL5EuAZo/cZhB+xZEXCIXYmxzJLGWd7HKqQBbvy2spGLVj4tQnwgBxeCgghU1uKgUtpU6CVNI6BAVWajQJg84zo3U1ayIMiGOmT3AOcBzuV4OPSCaF0sRUQJWsR7s7i64YlYMOu+r+KghypvYvC0IuxAsFUtzfkOiWpb0P0EeLwjGqd4aOB1jk7HsMuw+n9O73cW0C4QJrRMNW4pkq0g4nMfYEZk/whpUNHtVBYjb9sa2XxlC8H7u7I1sjsKOlz1618tdWpJiqIv22Vh9Ddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1BX2le4qoaShb99UJByAzErhbtdRdLTNX3z84xXtj4=;
 b=FJ1DImXwF2dP6farKowG5CkeDvPbOJaSu9IdC0DIyG9PrCg1NmKYuhSbLj9wkwmqci592EZxfNyJdUlCqHg+WkPovTDAbC8W0IkSA0v6YWtm5ImmOj9W9WyH15Ynaz4XqwqNqkbUyZKchND2BCyWoNLrFMIfw+nggTK+D37iUos=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.24; Thu, 15 Feb
 2024 23:39:41 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:39:41 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 2/2] usb: dwc3: apply snps,host-vbus-glitches
 workaround unconditionally
Thread-Topic: [PATCH v2 2/2] usb: dwc3: apply snps,host-vbus-glitches
 workaround unconditionally
Thread-Index: AQHaXc9HuTfYcE1uG0+03IYbvCu3HbEMFNkA
Date: Thu, 15 Feb 2024 23:39:41 +0000
Message-ID: <20240215233936.dcftgmhdomtnsfwl@synopsys.com>
References: <20240212-vbus-glitch-v2-0-d71b73a82de1@nxp.com>
 <20240212-vbus-glitch-v2-2-d71b73a82de1@nxp.com>
In-Reply-To: <20240212-vbus-glitch-v2-2-d71b73a82de1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB5627:EE_
x-ms-office365-filtering-correlation-id: 0eb0d754-63af-4dc2-3549-08dc2e7f6194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ARu7k4tSCAYOYYgsyJeDBJ5L5xT2qqp9t9GzZKsK8u+CKzwpx5qpLyQeYHRvat3GlOtiWBmZy9Uw1irg/JCKGvzBMtc9MQrZo6Qz0qiP6949jzDAhmIYelikcRisioUQQ4LNXLiJe732uZjFl1ltX3dkfwyPIGVUKuD0h6JgplAtQ99NPZuJTzCgzvgfndjDBGRaE4JGsHBSimhpMkATJHVRrPeKRi1m6GO25RRyg+F+55+sXju/P+HZGlpVOlBWroFlRXWyPKzc7mgPhOvGmcxdkiYq4lI/T0QjXL5J3eeCG5hhBFYGvHwpEirylrlP26jVgDSwbesB9irEWq0HVQULo215oAuMpqdkp3SGYkDUFBxr4C6bl4Qyae26WF5ZgnD/00WEFaJEEuxSLGdiFht9aivKGVCCZngbZEvEa96sBctHf7EwVJMpduSc/Plq5n6k6IqBRyi+giRNemNLpiK+I3NNJVzKZ9aERfT6Nm+XE1aJMG3d/fhRqnrhrkg4HqA9nESaHhvh9atl1fxwtBXG/hMI5kBSbS4cwmb3ll451X06lEISvnb15MwWLgeSZAzEZBm8XclF4ze/bctPV37u+96pl928Ywjj+AuEzMhW2m7UczBX6cbsXPf9HXh9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(83380400001)(1076003)(26005)(2616005)(122000001)(38100700002)(478600001)(76116006)(7416002)(4326008)(66446008)(2906002)(66476007)(6512007)(6916009)(64756008)(8936002)(41300700001)(66946007)(6506007)(6486002)(54906003)(316002)(36756003)(38070700009)(71200400001)(8676002)(66556008)(5660300002)(86362001)(3716004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VWplZ3BIV29sTm4zRzVjZFlycGE5VjFVQnhiY29FeS9Yc3l0SUx0Yk1rdkFI?=
 =?utf-8?B?Qm9tOGNMREo0bjlYeXZIQW9sck5HNXF4cW1TNHRPdlVBYWRBU3pjVzJaeDA5?=
 =?utf-8?B?VEd1b1RQNjc0YnozekN0K3N1bGM1VUV3Q05SWmFVcWxhYUl0Ym43RExyMEN4?=
 =?utf-8?B?aXdnYkVtSmpLYmI1WVlQNmN0MVBER3UrY2N6eElWV0hNbVlmUjFlN1dwamgw?=
 =?utf-8?B?dXlGV25aNHZwZ0hXYTU2bVFBTjhWUFZHOFFsM3lhS0lac0Q4QXlLWGVxK28w?=
 =?utf-8?B?dVVDZkdSWERnZEFtZ1hDMVE4WkhVR2IvbytQQkVTajdEdFBaNGFHaXdoRXJs?=
 =?utf-8?B?KzI5bGxKdytnb0tWa29QaW5EZ2hkaklCMWtTNksvd0syUEN3Y2dFWmJTVEpY?=
 =?utf-8?B?aVd5TVlaYTV3MWpvSWpqOHRnOGFSRndIOWI3dk5YREwwaXgyenpoWk1naHVY?=
 =?utf-8?B?NnNVRG50V2F1ZWNDUVIxZm01SGNiaDVMc3RTZlNhQldhZk54Myt0bE4wTGJa?=
 =?utf-8?B?WWtnYjNWZHdLVmNJQjFxNnFNRUtHbWFnd25lT0FUU0wxL0tNRFhzSTFOcVlO?=
 =?utf-8?B?b3M5ZnVrRjB5NVdqMFFCS3YxZ2Jxa1J4S0dDcnBrT2NSVkhNdXkwVEJmRkRB?=
 =?utf-8?B?YlVlRUM5eE9pY1dQM0UzUExDelJrUlYwWTlBdDdRUmUxd2UwcmVzK3hPbTlY?=
 =?utf-8?B?VFZNMDE0LzB0eWw0dWxWSU1XRnFrblRmQlVKd2VOSjh2dWd3bVJtOENvdGZr?=
 =?utf-8?B?ZFAyS2JQUHZPYURYT04wNENFRkllV0xSUEJOUzk3V09aQ1A2MnNsMjM1YUw0?=
 =?utf-8?B?cnZianI2TmgzWUdwTklJUlpnY3hoNFJTS3BKeXcwWlZlQit1aVpmNTE4NU9S?=
 =?utf-8?B?WExDdmRhWURWRHlqTzBUYXVnelpLZ2YvQkQyNHJoTkQ5TG5uT2phc25ZZGly?=
 =?utf-8?B?V3pRMUpPT3BSQThwZExZK1FyRGtnTEY1NU82R2xHc0FpZVE1OFdOcE5jaHMz?=
 =?utf-8?B?Y0hTeWkvZkI3dFhKbXU0VERLVk1lZUwwbURLeUM3VFdFTGxMV1ljTEMxZTZU?=
 =?utf-8?B?MWVQRlVtMElBMlFCS2llMHR4OURSWm1xa0pUbmc0bDJ4RXlLWTRTejEraGV2?=
 =?utf-8?B?ei9OdGIzM3pLdUlJV2ZXNHVLc2FkMTRGSDNIVW5aS2pMdGNBTk9LQUJTMmRo?=
 =?utf-8?B?amswVUpVSEVMNEVVWC83TlZlY1JZSXVuWThQaHZQdjhidUhKcDlnSytRODFC?=
 =?utf-8?B?OFgxcWVoRDJTUE9USUhKUVpCbnFuMzFMV0YydS81aTdjSmxMMXNiMmFQL0Er?=
 =?utf-8?B?UFpuLzU3OTZzdnJZTjhtWTcwdkVzYWh4RXA2cW1WQnlaM2Z2eFgyVHNxZ1pz?=
 =?utf-8?B?OWhMV0RjbUxSb0NDQStod2I5SjlGNEswMGZ5NlRSM2RZY0J2NktxdE1Ja1Fh?=
 =?utf-8?B?MWFpS1hhQ2pQeTJYcm9JSkMzcHViYndFbzVJemI1MzQ4VFd2N2FJa2J5R1NE?=
 =?utf-8?B?QWRYUmo0bXZENVZuK2VkS0Z5SEJvZ3praUZFeGlxWjRIQlN2dWdQOWF0WHZM?=
 =?utf-8?B?TlhrV0I4cHo4RFVKVkY4Z3YyZmQ1djhEMDFzU1dSdGxIb2xnK1ZPb0tML3ha?=
 =?utf-8?B?TzJmU2FPQ2F3U2ZqYU5vMGM4STFvQ1ZjR3RzVTlxYVRGc29YRWt2V1dVQnps?=
 =?utf-8?B?U3dZck1INHorTlJ2b0JPVGZsNkN3bmZFTlVSYlVZeHpKdUFOTjY1Y1BQeS80?=
 =?utf-8?B?anllYlh2a2l3V1VFMnJEMXh0dEtHb3hyOXgva0ZONXZuSjhZL2pkSWhGQ3Jl?=
 =?utf-8?B?MjN4QjRwcDQzTjk2MFNOdjY0U1JBVm95c01LeEp5RkVyYkJSQ0NuWVhtY01X?=
 =?utf-8?B?TTdKQkdwdjdmSVJNdTYzc0xYcGRKTEpBeUpQNFVXbHFubHlxR2tPR2w1dTRZ?=
 =?utf-8?B?ZHorUXdVMld6R0pRM0hDZW5vWVg5QjVZSEdISThnN1dKOGpzM1JLMmlwV3p6?=
 =?utf-8?B?MDVBQjJrRDdid1g2djJkVHhyUG9EYWdzVGp2M1hhc0pLMUtRbnp0QUVuWldY?=
 =?utf-8?B?b1hWd2VBWWRiRndvM0ZIQ3JRZFZKbGJVSGhjMFFIWUNsTkdkN2NZakQvVU5h?=
 =?utf-8?Q?qvGwJzSTukf81Ty6cOCtwy/6z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C68B6C0D3D0649982341ED154FF1F9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aeC6iaC2IMAEn/HsQzB64Fre26gkLGE4h1kW+ij1C4aLJ7iLonz6ct1wtIEsI8VlKczb+AdtPqF9zo07VNj5Mxf6hTAETRCQnTcOGm1xxD499vhfSKGP+9n8636NyeBpcx8ArzHSJuTYxW4xjlHl/MwiNdBFsJ01NiE/FzFlXz4LxD0l+QnHhXnWujwUXs7lR0kXqOGvOvIsLXMY5l+W10LnmkOZKvd+vBSpem39izcQkNNtY8sYREuN8qXOLbZdSp8oMyu+LuZKSdDD4o/HrPM2X/2FXwTksQPuBeD7QJtjh5d334V5Db2AoNC9qR/+W8ddm43pGQHp196Voocg7nULnSwPH4+luuwfZRjrOGnxrJcQw+z1QNLDf1rIoMks6XpvzyCv7fE7iTzY77WDa9+XvEH75jMI/roZpTcCI81svGE+nmkptrep64udB7Zk0+peNkxvGyweEPw/BQsWglbiO4OnclywgM/LkzU19ZvFB/rC3p10XRvtDDLI+/4kZ3GCNA3+PZ8ElzcUOycQQtxpJJYoKY0A1I1nbXCC+Z5lAD6EcUEQ0LxBqrPlNgN8D9UGzoC/Hr5RvVpTr+eGNDqStp+cGR+SLhOBrGvyf5fhNoVCnEZuJuJomG/H4xTmZWVW0n0H+7dgirqDyGqn+A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb0d754-63af-4dc2-3549-08dc2e7f6194
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:39:41.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hhQTcMwO8eXKS4I/c0OWvMHNQ5RAhFbcfydyrEAa/fHH3rGAa9e+83l7Fx5yxJwiVOl+yTXm/81dHrHS53mGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
X-Proofpoint-GUID: InxGhSkQdrCgGkvybkYO1ydB4Wx1vgQA
X-Proofpoint-ORIG-GUID: InxGhSkQdrCgGkvybkYO1ydB4Wx1vgQA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxlogscore=649 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402150184

T24gTW9uLCBGZWIgMTIsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBSZW1vdmUgJ3NucHMsaG9z
dC12YnVzLWdsaXRjaGVzLXF1aXJrJyBhbmQgYXBwbHkgd29ya2Fyb3VuZA0KPiB1bmNvbmRpdGlv
bmFsbHkuDQo+IA0KPiBJdCBpcyBzYWZlciB0byBrZWVwIHZidXMgZGlzYWJsZWQgYmVmb3JlIGhh
bmRpbmcgb3ZlciB0byB4aGNpIGRyaXZlci4gU28NCj4gbmVlZG4ndCAnc25wcyxob3N0LXZidXMt
Z2xpdGNoZXMnIHByb3BlcnR5IHRvIGVuYWJsZSBpdCBhbmQgYXBwbHkgaXQNCj4gdW5jb25kaXRp
b25hbGx5Lg0KPiANCj4gUmVtb3ZlIGFsbCBob3N0X3ZidXNfZ2xpdGNoZXMgdmFyaWFibGUgYW5k
IGNhbGwNCj4gZHdjM19wb3dlcl9vZmZfYWxsX3Jvb3RodWJfcG9ydHMoKSBkaXJlY3RseS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgMyAtLS0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvY29y
ZS5oIHwgMiAtLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9ob3N0LmMgfCAzICstLQ0KPiAgMyBmaWxl
cyBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+
IGluZGV4IDNiNjhlOGU0NWI4YjkuLjNlNTU4MzhjMDAwMTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+IEBA
IC0xNjI2LDkgKzE2MjYsNiBAQCBzdGF0aWMgdm9pZCBkd2MzX2dldF9wcm9wZXJ0aWVzKHN0cnVj
dCBkd2MzICpkd2MpDQo+ICAJZHdjLT5kaXNfc3BsaXRfcXVpcmsgPSBkZXZpY2VfcHJvcGVydHlf
cmVhZF9ib29sKGRldiwNCj4gIAkJCQkic25wcyxkaXMtc3BsaXQtcXVpcmsiKTsNCj4gIA0KPiAt
CWR3Yy0+aG9zdF92YnVzX2dsaXRjaGVzX3F1aXJrID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9v
bChkZXYsDQo+IC0JCQkJInNucHMsaG9zdC12YnVzLWdsaXRjaGVzLXF1aXJrIik7DQo+IC0NCj4g
IAlkd2MtPmxwbV9ueWV0X3RocmVzaG9sZCA9IGxwbV9ueWV0X3RocmVzaG9sZDsNCj4gIAlkd2Mt
PnR4X2RlX2VtcGhhc2lzID0gdHhfZGVfZW1waGFzaXM7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvY29yZS5oIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gaW5kZXgg
ZGY1NDRlYzczMGQyMi4uZTNlZWE5NjVlNTdiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTExMzIs
NyArMTEzMiw2IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICoJMgktIE5v
IGRlLWVtcGhhc2lzDQo+ICAgKgkzCS0gUmVzZXJ2ZWQNCj4gICAqIEBkaXNfbWV0YXN0YWJpbGl0
eV9xdWlyazogc2V0IHRvIGRpc2FibGUgbWV0YXN0YWJpbGl0eSBxdWlyay4NCj4gLSAqIEBob3N0
X3ZidXNfZ2xpdGNoZXNfcXVpcms6IHNldCB0byBhdm9pZCB2YnVzIGdsaXRjaCBkdXJpbmcgeGhj
aSByZXNldC4NCj4gICAqIEBkaXNfc3BsaXRfcXVpcms6IHNldCB0byBkaXNhYmxlIHNwbGl0IGJv
dW5kYXJ5Lg0KPiAgICogQHdha2V1cF9jb25maWd1cmVkOiBzZXQgaWYgdGhlIGRldmljZSBpcyBj
b25maWd1cmVkIGZvciByZW1vdGUgd2FrZXVwLg0KPiAgICogQHN1c3BlbmRlZDogc2V0IHRvIHRy
YWNrIHN1c3BlbmQgZXZlbnQgZHVlIHRvIFUzL0wyLg0KPiBAQCAtMTM1NCw3ICsxMzUzLDYgQEAg
c3RydWN0IGR3YzMgew0KPiAgCXVuc2lnbmVkCQl0eF9kZV9lbXBoYXNpczoyOw0KPiAgDQo+ICAJ
dW5zaWduZWQJCWRpc19tZXRhc3RhYmlsaXR5X3F1aXJrOjE7DQo+IC0JdW5zaWduZWQJCWhvc3Rf
dmJ1c19nbGl0Y2hlc19xdWlyazoxOw0KPiAgDQo+ICAJdW5zaWduZWQJCWRpc19zcGxpdF9xdWly
azoxOw0KPiAgCXVuc2lnbmVkCQlhc3luY19jYWxsYmFja3M6MTsNCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvaG9zdC5jIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gaW5kZXgg
YWUxODliN2E0ZjhiOC4uOTg5NjRlOGRlYTFmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9ob3N0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9ob3N0LmMNCj4gQEAgLTExNCw4
ICsxMTQsNyBAQCBpbnQgZHdjM19ob3N0X2luaXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAkgKiBT
b21lIHBsYXRmb3JtcyBuZWVkIHRvIHBvd2VyIG9mZiBhbGwgUm9vdCBodWIgcG9ydHMgaW1tZWRp
YXRlbHkgYWZ0ZXIgRFdDMyBzZXQgdG8gaG9zdA0KPiAgCSAqIG1vZGUgdG8gYXZvaWQgVkJVUyBn
bGl0Y2ggaGFwcGVuIHdoZW4geGhjaSBnZXQgcmVzZXQgbGF0ZXIuDQo+ICAJICovDQo+IC0JaWYg
KGR3Yy0+aG9zdF92YnVzX2dsaXRjaGVzX3F1aXJrKQ0KPiAtCQlkd2MzX3Bvd2VyX29mZl9hbGxf
cm9vdGh1Yl9wb3J0cyhkd2MpOw0KPiArCWR3YzNfcG93ZXJfb2ZmX2FsbF9yb290aHViX3BvcnRz
KGR3Yyk7DQo+ICANCj4gIAlpcnEgPSBkd2MzX2hvc3RfZ2V0X2lycShkd2MpOw0KPiAgCWlmIChp
cnEgPCAwKQ0KPiANCj4gLS0gDQo+IDIuMzQuMQ0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXll
biA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KcHM6IFdh
cyB0aGVyZSBhIHYxIG9mIHRoaXMgc2VyaWVzIG9yIGRpZCBJIGRyb3AgaXQgZnJvbSBteSBpbmJv
eD8=

