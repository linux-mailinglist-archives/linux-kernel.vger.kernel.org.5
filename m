Return-Path: <linux-kernel+bounces-67850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336DC8571CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17FF285DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF610145B32;
	Thu, 15 Feb 2024 23:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jHj1WxO2";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="booTKQ2v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GfZFBJbT"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B567138489;
	Thu, 15 Feb 2024 23:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040865; cv=fail; b=OovPpLFfVCoCzVwtMGhuUr+NqT+JzmxuRf2TTpHkyCb6Y57cduztBYSiUtwc7jAKT2tcGU2pTvQ6sTfPZLn+1N9fWYbWhxzv+NAXFD5zgjfQZTeohKNOAxAQWw172VQoVXrSX9ScqBuX9t3/aFMIzqCQ0Uv/HFFk6qJ//J+YyUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040865; c=relaxed/simple;
	bh=TV5smBESRmxry8IZ4dzQMOtGha7BYECuXjtkETe2S9M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HvW4mTslnGauv1lq72154GuNu6MsKzv5w4VNdqCCeXMXtKLga3zKEHBj5g3tnUGKsZKRvC1HIkDxYndfob+Ac+xDWFNWm+CidOq+7DLYzLLfDUXtBBOvowoPfNsauLHDNPOQWfIcyiuI0R0M8s0FlphScw73vQY7paFi5iYmjZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jHj1WxO2; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=booTKQ2v; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=GfZFBJbT reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXkxC016627;
	Thu, 15 Feb 2024 15:47:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=TV5smBESRmxry8IZ4dzQMOtGha7BYECuXjtkETe2S9M=; b=
	jHj1WxO2gCHiMZlTKjETUgrDeVmich8sb4btDsATniOt4M4wLRMJ0/MQaYJ/ZE2L
	axkAZETwMgf9VIAy1yYhFgRUSt+hB6YKp5VB7/gk2xZUOcCJSVASj17W1PJeqCm7
	AooIua0F4Qh/O1EOgU9wCVEyS8KaoFdDH6UjM/aZh+7BaxTCBj7Spms0obSjX600
	9LxepaCf9UrKRcnSvWZUy/HxIImFz7Cma2LoKPI4oplq2LF+U77lR1VYaADztA8y
	LhBhwph2xfrKC9fuuNOwsz2c4Yk9EjuuVz3As2pU9D+j+Ti1V4dQZYcMmC9eArKb
	d6i4ta0W8gfJNmKibZdInQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3w68ngx4y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040852; bh=TV5smBESRmxry8IZ4dzQMOtGha7BYECuXjtkETe2S9M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=booTKQ2vusDVWSHXCjt83OXeH68um5D0HTx3dAGSiNIqasz0Vljx2nhUihoiHx/22
	 stGaMQ+s7v4zfOGTVY8DFNNZoMQM4wLUuPSoY/Ci9vtY0X7tLnKS59LrmPnGXNxGtw
	 kNB6wH8IZ1mJBN5ko3UE++taCJPLBrh2TEuhHcBhe09QaH+W5i5dLgGGBpkrnA13q1
	 594xYtZiUVNxTW2XO13d/WN6h5pifs5QGtYyZssZQ490jSoboSCKBDUkNNnXXgttht
	 wIdphul8a9DRZuugwq9mc1HT70qUrDtHGJ3OtmxbnvZV2Tc0cZzYtn6e+rMWsPRd0c
	 EfPmfQyC7MmGg==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5E5DC40521;
	Thu, 15 Feb 2024 23:47:32 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E3A29A0068;
	Thu, 15 Feb 2024 23:47:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=GfZFBJbT;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2769F4011F;
	Thu, 15 Feb 2024 23:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHMFeI1CuMMZzIH2O5/K8VnALCwplptSbEP3cJou3lWiGy7XkDfcGCBMvQFFFuOWWcysh4tFOgepk0MKgpyr93wy/eqKWF2x+d7WRT3K7t/AzlCR/rr5JFEDLT7/h4z14IsynrY+fHktXss9bdY2jBMGwN515kChFf2EbFjO3c8g+WE57e3zDNi3Y3Z77CaeazFtTCzrWsUbfUKPCe/i2CzVYDkgXzbdGtwh5Lbi1JRyYL1WQtAqMxDCbQrYmNyRiIFO3xJZ7aUop/k2INsl+yFkBn08gk6wBuPV+wDhEGWFvUh0h9VfJC60VH+yI2B5l4UQcSpikJDfF9lW+IqfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV5smBESRmxry8IZ4dzQMOtGha7BYECuXjtkETe2S9M=;
 b=fvtZ8KYd/sxlQ05CQmTBUzGDmtnabrud23l6fbT04lzajr/Z2mWt2hAN7xM1CmFPILgDR08UUXhRXQ3xAxrnTuKDkYGcOz5RQSyJjlW+5bFF0b9sac0kwrS2OQBhR3GdPeucyC58csKILnXvKJAnrmrDJZcZZJWHzpRjgWvYBhXQQgFOTzoAn/Jpg5xQu2GQJORROraGEG5yRstXItnudq1N2z7IRTc1q8wCBzgWwiiAFHOBV4aBXYh+bKJSjOAAHRjacEJH5bbZQsZUOl4IdrcVjBns8CZ3Swp9kY4i5h0EPCO3f34Kr/uuKkarHYCGnU0Jl/qQLpwArlTgMJi/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV5smBESRmxry8IZ4dzQMOtGha7BYECuXjtkETe2S9M=;
 b=GfZFBJbTLKPZS3pLEP5jPz0sfw0EpylCt/ejKmoMm+GNeHrOAs4xAkdibmdkPrZO8Osf0NsXmxq0kc5AOTcL1GuzPFFduttP+boilBx9psm9CcmDwzUNG8AATTSp6XQmCVFCS+gCMsbynuxmXt4h+yrUH7X0Gw8rEuRd2rQ283Y=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Thu, 15 Feb
 2024 23:47:25 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:47:25 +0000
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
Subject: Re: [PATCH v14 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Topic: [PATCH v14 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Index: AQHaWLwPT07bcTzKBEqHWJ/Z6mxTH7EMISqA
Date: Thu, 15 Feb 2024 23:47:25 +0000
Message-ID: <20240215234721.drcaclxqc4wvad4q@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-7-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-7-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: a80db43f-6ad8-4d99-967f-08dc2e80766a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BwcvBQM606GhYL7/tnMewgZgf2gvcoTWwZfhVMI94gmAofwuZtvVx3bpvtpMafxM6ySHxNfMnalxiPZpUWYShv3hECquFVLX8kQjMZjZp30asA7yB3kmjc9JqigM+JtqRJB+ygeW8CN/A3PFOR8Kav0OzlL4Zoi634uvWn+kAzAEEk+VyIVcnGWwBLoY1Bs0GgyeWv4lJ3sryY4G4OmxpMwJaFycBsCzlLgYp+jp2dZDwx9xBdDfHGmOXFBJULyfDbeJCHOE+ozvCLs7HU4OL3sL0i3qaylEmTEto4Tjp6sC6KqI52pKXfi2Zysq7v3H5ZTMThsSKi+KXjNoQgTNm1vGQ4OGfQskAG5CRUcFHQUyqXN15WdF3ISVc+W6NNOgw6IJD0DzzcgRL4cWwkm1HP+TOi5C01VVRqzgc7w9xV+ZSoT+SH1XTQB/sbo/8nG7kxDPjqasqlbuonGXp4IEeB+8DeYQE34CHD5RDoMj5DvfWAdgV7j0rxiOkh1XzHLpgMsH2KxBZ0PerrlNsub2vOWtEElRGAr3bBO/F+GM3InYiXOeuNqsq9AyL7RVDCqOp0vtfWF4A5zJb9kho5p1ZiVtUBXLjuajoMsmbw9wmWdpQ0OpRySTdgjlNmVI6MvZ
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(5660300002)(86362001)(8676002)(2906002)(4326008)(7416002)(2616005)(26005)(83380400001)(66446008)(1076003)(38100700002)(36756003)(122000001)(38070700009)(66946007)(64756008)(316002)(6916009)(6506007)(66476007)(71200400001)(76116006)(66556008)(54906003)(6486002)(6512007)(478600001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?d09NOVlucE1mOXhOQVRiQ0QzOWNhNmZBYU9sRVJHWVpVTXdHK3RxOHRjMlg0?=
 =?utf-8?B?Nm9qdXFLNDhmWlROMzhPOVRSL2pDejNaaEovSkhPOXYrRDA0UU8rSDBMK1M5?=
 =?utf-8?B?T04zdDFxd3BtK2FmK2V2VG5qaGpIR3pieVV0TG1ES1lpMmZFRTZtbFVGYmlm?=
 =?utf-8?B?NlBRYU5BOUtWT1NrTVIxYlIwOXl5cy9CdTdNZFlpZ25QVGRrejhqYTJPNVFh?=
 =?utf-8?B?TnpEYmpvK011QjNuYjZHTlVYSWFkUTNJeElSOXB1YjdORENmb0pNRVMwd1Ir?=
 =?utf-8?B?MXN5UUpLVkxyVzFNd2piZmR2T0I1ZXRzbmI4UXBvNW1oVURHYXMveHQzb2U2?=
 =?utf-8?B?WmNBNld6SlJrLzAvemloOFdpdmVzV05WYm5MZ3QzVzdraldrUE0rcXZyTHJY?=
 =?utf-8?B?VU5vZUJqT0xWbDZhYmNEYjlrdDRLR25kR2psZ1pkenBmWGE1VHRnaVh4RjVX?=
 =?utf-8?B?R0FvTXhiSFdZU0VXNkFrT1VqUmhyS1dLZDZMbHJhdCtvVVo0ZTczQ0hxN1FM?=
 =?utf-8?B?NEJ2dEdZTGVSODlEQXB2L292ekhJZXRwNnFNOUZMWmF4MFFMdG1Pa3ZRdVR2?=
 =?utf-8?B?VjFCNGpjYnFTNWYwalJaWWNVODIrRUhXU3hzYlJlcEJPK1IzL1k2Zmd3OTVh?=
 =?utf-8?B?Q0J6L1MzUi9tbnF1dGMwY0pqSmJFR2dNUmQ5Z2xEcDJVME5sSVE3YThPTDFj?=
 =?utf-8?B?bXJ2cXJDcnA3eWowOGxjeHEvd2VzOFZFQ3pKMVRzd001bUppb3VReHVEM0pS?=
 =?utf-8?B?cXMyQ1BLQmFsK0dUdXJwa3h6ejAyZ1JpZ0o1dzFTaUtxM0VIdzl5TXd5TnhP?=
 =?utf-8?B?cTRCQWlUQzllTVZ0Ly9pNGtzWmNIc2ErekRCNG1BdG9MYjJKZStaREJqYzBM?=
 =?utf-8?B?T3pUWUVQdkswbXY3dVpJRy8wU2gvOGVxK2JsTU90OVVIaE9TRzU5bmI2bVZ3?=
 =?utf-8?B?NHA1TEoxZHVVU3VFbDZNSXFYQTRZUHFkOGdXdFZiWnZGOUVOcGZDS0VxVXNU?=
 =?utf-8?B?U3d0a0RERDRuWHRhYnJVWnVLbFMwWFNyRkpHWEh6ajhQamwrMUdoUnhMejRC?=
 =?utf-8?B?VnZvUmV4U3d6dEExSUlCNVp3TVpZeGZOOXBuTGl2TVJsTXJFbUJ2OHpERjBj?=
 =?utf-8?B?NVVMR2JWbEtzMnI4SnU1aStmdE5tYTRkSGpQK1JSUDJXcFBHMFV3UExYcmp4?=
 =?utf-8?B?SjNJeXlndk1Bck50ZGNyZllRbDAxb2pkWldwS20xL2lYcHIxZThQeCs1R1lj?=
 =?utf-8?B?OGhsRm9adUV2ZnBkK2Y3OTBWY0kvbHA2Z25VeEpaRkNSYm1EaDl0UENHRDJE?=
 =?utf-8?B?YmoxWEhFOVBDZ0ZKRE50eUNra1U3b1BxY3JnSmtwOUk2OWZrUXJTbUZ1TUlD?=
 =?utf-8?B?ZDNSMHV2b2Y2REd3RVBnU00xRXpRMGs4RmhNdmd6YXdnN3VxblVINi9vdlBz?=
 =?utf-8?B?bXBjQWZ3NkpIdUY4akludUplYUI0ZC92TTA1a2VxaVlpYnZPNHk1dDAwa0Ex?=
 =?utf-8?B?K251cE1NUVhsc2lQOXIrOG1OOXIxelFPbDVkdkNIYi9NTjZQODdSOEdnSExK?=
 =?utf-8?B?NEJ4YWJPMDk4RUJuZ1c5MUJPK1UvYWVSQ3gzcXIwb3VEVUJMb3dDcUlpREY5?=
 =?utf-8?B?SGZ3N0l2djlyNVhJeVUzdTlheHM2QnRTSklBc0dMOWtoSU9DSFZXVWw3SXVr?=
 =?utf-8?B?eDFLeGVXZW5Ed3NVN296Qkl1aldoTXdKclVKdUhjUSs1b3VpSFdxTFRWUFFx?=
 =?utf-8?B?bklYSEppVEdYRS9kSlp3a2pRRm95WTRLQVNNTjR0Sks3SUdvUUJIQkxXQTJD?=
 =?utf-8?B?YzEySUlLNDF0cW1PSXA5OU5CM21zWXVva3ROQjFzcWt5Vklzd1B0eUg2Ykhl?=
 =?utf-8?B?UzRCL0ZKM2FVS2VPVVpvZFpMMHhSN0ljbEExaWJyR0t5Znh3R3BnbW1XYkdo?=
 =?utf-8?B?THFDTDhWRTY0K3lwdHVCZTVBZHUyYTd2U1NuWlBQcThiTnVzaVl6RkpXZUV0?=
 =?utf-8?B?c2JzeGd1SlpTSFJoYkxUSHRzVFpLZGpYTEN5Unh3NjdVQmNCNkdFN3lxbzJN?=
 =?utf-8?B?LzJuS2x0NjA2Z2RJSk5RNjRJbmhXbjdpZDBueFZEZXFrblNFWU5UQmJxenBu?=
 =?utf-8?Q?nKMfGQ/Dh+mFj6cEwgjBO1906?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D0FC8345953E74AB490C44F7AF2735F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ufp/EGD4jGr+oQ4aPXgQNj0IaAWYeEKM/js/b9hg+Y7zwhKo4cGOGtJd7Q0pnWU/CNfgw4F9vguvGskfqZmKQTI/9o44F57zAA1Vys+KZwaCUDUAxNWhNTWlSYlYKlNTjQ98PYC1Ca6UUkloYLkXrZc4/L1ex7su+onaTLmPGXKPgOQ5Ernivd7HekUDew88UQBi1E6m7n2pXOwq+MM7B4DsxqkHqAjXvF8klqSVNImO9D4i/8n0W9qRYjctrLho1lgeY2LTxz3dFl3o22JqUtKHzpBCg7oIqrKHMK1TUFV68HGxHRZIHe+KhFBOTDeQdEnZp7kgS6Os1PUxi39j8W0yoppJu0Bk11bgi4//qU3eN7iA5RPykXyUDopFxOWSztzkb5xhg87qRJOI1ykftha90M/bqBXn1bcOx7w4q7JJauV/AOWWyJd9ID5iSmJPTW+J4SkmtfTCM5b3PJ3aNWmFGI4XX5QpYxUh/5/CNJjDrjqe1wSDBCIA6RTHs4i/vjOV1U7ORY81rIdz+CgV8SIKCKtl/KBcjCHQMv4whxrw+Z8weasAWfWDf/45fqvx9T7WVjcQv4rOFNuA/68QtGiGNMIVo/qVliZOmYGbbEvjWEUXA5BFu/fpXJXZIcFazkLMgWMrxEDOCqkkIStaFg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80db43f-6ad8-4d99-967f-08dc2e80766a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:47:25.6590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWxCtF4F61jeuCf/SpqGh7ilHaPMP7xQHGhACJUBP7CaJE6GTJWQA3SWnX1KtkP+aqo/IBon5hMc+FEvsQqExA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
X-Proofpoint-ORIG-GUID: 7Jf_6Nol7fIqyMLZR8vkU7QhQSzyTXcy
X-Proofpoint-GUID: 7Jf_6Nol7fIqyMLZR8vkU7QhQSzyTXcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxlogscore=926 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402150186

T24gVHVlLCBGZWIgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFRoZSBsb2dp
YyBmb3IgcmVxdWVzdGluZyBpbnRlcnJ1cHRzIGlzIGR1cGxpY2F0ZWQgZm9yIGVhY2ggaW50ZXJy
dXB0LiBJbg0KPiB0aGUgdXBjb21pbmcgcGF0Y2hlcyB0aGF0IGludHJvZHVjZXMgc3VwcG9ydCBm
b3IgbXVsdGlwb3J0LCBpdCB3b3VsZCBiZQ0KPiBiZXR0ZXIgdG8gY2xlYW4gdXAgdGhlIGR1cGxp
Y2F0aW9uIGJlZm9yZSByZWFkaW5nIG11bGl0cG9ydCByZWxhdGVkDQo+IGludGVycnVwdHMuDQo+
IA0KPiBSZWZhY3RvciBpbnRlcnJ1cHQgc2V0dXAgY2FsbCBieSBhZGRpbmcgYSBuZXcgaGVscGVy
IGZ1bmN0aW9uIGZvcg0KPiByZXF1ZXN0aW5nIHRoZSB3YWtldXAgaW50ZXJydXB0cy4gVG8gc2lt
cGxpZnkgaW1wbGVtZW50YXRpb24sIG1ha2UNCj4gdGhlIGRpc3BsYXkgbmFtZSBzYW1lIGFzIHRo
ZSBpbnRlcnJ1cHQgbmFtZSBleHBlY3RlZCBpbiBEVC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEty
aXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyB8IDUzICsrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDI5IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMg
Yi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IGluZGV4IGRiZDZhNWIyYjI4OS4uMDhk
ZjI5NTg0MzY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gQEAgLTUzNSw2ICs1MzUsMjIg
QEAgc3RhdGljIGludCBkd2MzX3Fjb21fZ2V0X2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2LA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19xY29t
X3JlcXVlc3RfaXJxKHN0cnVjdCBkd2MzX3Fjb20gKnFjb20sIGludCBpcnEsDQo+ICsJCQkJIGNv
bnN0IGNoYXIgKm5hbWUpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCS8qIEtlZXAgd2Fr
ZXVwIGludGVycnVwdHMgZGlzYWJsZWQgdW50aWwgc3VzcGVuZCAqLw0KPiArCXJldCA9IGRldm1f
cmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+ZGV2LCBpcnEsIE5VTEwsDQo+ICsJCQkJCXFjb21f
ZHdjM19yZXN1bWVfaXJxLA0KPiArCQkJCQlJUlFGX09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwN
Cj4gKwkJCQkJbmFtZSwgcWNvbSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJZGV2X2VycihxY29tLT5k
ZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBpcnEgJXM6ICVkXG4iLCBuYW1lLCByZXQpOw0KPiArDQo+
ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBf
aXJxKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNf
cWNvbSAqcWNvbSA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiBAQCAtNTQ1LDU3ICs1
NjEsMzYgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBfaXJxKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAJaXJxID0gZHdjM19xY29tX2dldF9pcnEocGRldiwgInF1c2IyX3Bo
eSIsDQo+ICAJCQkJcGRhdGEgPyBwZGF0YS0+cXVzYjJfcGh5X2lycV9pbmRleCA6IC0xKTsNCj4g
IAlpZiAoaXJxID4gMCkgew0KPiAtCQkvKiBLZWVwIHdha2V1cCBpbnRlcnJ1cHRzIGRpc2FibGVk
IHVudGlsIHN1c3BlbmQgKi8NCj4gLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShx
Y29tLT5kZXYsIGlycSwgTlVMTCwNCj4gLQkJCQkJcWNvbV9kd2MzX3Jlc3VtZV9pcnEsDQo+IC0J
CQkJCUlSUUZfT05FU0hPVCB8IElSUUZfTk9fQVVUT0VOLA0KPiAtCQkJCQkicWNvbV9kd2MzIFFV
U0IyIiwgcWNvbSk7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIocWNvbS0+ZGV2LCAi
cXVzYjJfcGh5X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KPiArCQlyZXQgPSBkd2MzX3Fjb21f
cmVxdWVzdF9pcnEocWNvbSwgaXJxLCAiaHNfcGh5X2lycSIpOw0KPiArCQlpZiAocmV0KQ0KPiAg
CQkJcmV0dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29tLT5xdXNiMl9waHlfaXJxID0gaXJxOw0K
PiAgCX0NCj4gIA0KPiAgCWlycSA9IGR3YzNfcWNvbV9nZXRfaXJxKHBkZXYsICJkcF9oc19waHlf
aXJxIiwNCj4gIAkJCQlwZGF0YSA/IHBkYXRhLT5kcF9oc19waHlfaXJxX2luZGV4IDogLTEpOw0K
PiAgCWlmIChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEo
cWNvbS0+ZGV2LCBpcnEsIE5VTEwsDQo+IC0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLA0KPiAt
CQkJCQlJUlFGX09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwNCj4gLQkJCQkJInFjb21fZHdjMyBE
UF9IUyIsIHFjb20pOw0KPiAtCQlpZiAocmV0KSB7DQo+IC0JCQlkZXZfZXJyKHFjb20tPmRldiwg
ImRwX2hzX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0ID0gZHdjM19xY29t
X3JlcXVlc3RfaXJxKHFjb20sIGlycSwgImRwX2hzX3BoeV9pcnEiKTsNCj4gKwkJaWYgKHJldCkN
Cj4gIAkJCXJldHVybiByZXQ7DQo+IC0JCX0NCj4gIAkJcWNvbS0+ZHBfaHNfcGh5X2lycSA9IGly
cTsNCj4gIAl9DQo+ICANCj4gIAlpcnEgPSBkd2MzX3Fjb21fZ2V0X2lycShwZGV2LCAiZG1faHNf
cGh5X2lycSIsDQo+ICAJCQkJcGRhdGEgPyBwZGF0YS0+ZG1faHNfcGh5X2lycV9pbmRleCA6IC0x
KTsNCj4gIAlpZiAoaXJxID4gMCkgew0KPiAtCQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRf
aXJxKHFjb20tPmRldiwgaXJxLCBOVUxMLA0KPiAtCQkJCQlxY29tX2R3YzNfcmVzdW1lX2lycSwN
Cj4gLQkJCQkJSVJRRl9PTkVTSE9UIHwgSVJRRl9OT19BVVRPRU4sDQo+IC0JCQkJCSJxY29tX2R3
YzMgRE1fSFMiLCBxY29tKTsNCj4gLQkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2VycihxY29tLT5k
ZXYsICJkbV9oc19waHlfaXJxIGZhaWxlZDogJWRcbiIsIHJldCk7DQo+ICsJCXJldCA9IGR3YzNf
cWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEsICJkbV9oc19waHlfaXJxIik7DQo+ICsJCWlmIChy
ZXQpDQo+ICAJCQlyZXR1cm4gcmV0Ow0KPiAtCQl9DQo+ICAJCXFjb20tPmRtX2hzX3BoeV9pcnEg
PSBpcnE7DQo+ICAJfQ0KPiAgDQo+ICAJaXJxID0gZHdjM19xY29tX2dldF9pcnEocGRldiwgInNz
X3BoeV9pcnEiLA0KPiAgCQkJCXBkYXRhID8gcGRhdGEtPnNzX3BoeV9pcnFfaW5kZXggOiAtMSk7
DQo+ICAJaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2ly
cShxY29tLT5kZXYsIGlycSwgTlVMTCwNCj4gLQkJCQkJcWNvbV9kd2MzX3Jlc3VtZV9pcnEsDQo+
IC0JCQkJCUlSUUZfT05FU0hPVCB8IElSUUZfTk9fQVVUT0VOLA0KPiAtCQkJCQkicWNvbV9kd2Mz
IFNTIiwgcWNvbSk7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIocWNvbS0+ZGV2LCAi
c3NfcGh5X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KPiArCQlyZXQgPSBkd2MzX3Fjb21fcmVx
dWVzdF9pcnEocWNvbSwgaXJxLCAic3NfcGh5X2lycSIpOw0KPiArCQlpZiAocmV0KQ0KPiAgCQkJ
cmV0dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29tLT5zc19waHlfaXJxID0gaXJxOw0KPiAgCX0N
Cj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmggTmd1eWVuIDxUaGlu
aC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRoaW5o

