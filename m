Return-Path: <linux-kernel+bounces-67858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE788571EB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3259D1C22402
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45B145FF7;
	Thu, 15 Feb 2024 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gId93+K9";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MK44CnpY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="dwEifkEo"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6EB139589;
	Thu, 15 Feb 2024 23:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040946; cv=fail; b=asyhIpFZTfeDn0to386psuOBhgrIQldaL+HECUgvfpGZ1CXY3X9C4U9LX98DRbRB54Zhqparrjf7lsod6KK5xGtXtp2qSq7lBxNvqU92WrunTv/AERcPGBVgMdIr5eJWnRqNpH8Zjs4q7P6IoUozwwoYHhbOR7Q9i9MPWMcslA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040946; c=relaxed/simple;
	bh=/NItrR2Pd3c6BbnctaY2UObrjBiqOhCwayfc1peQu7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jac3rf8rxeY/NSTb1p9ExjQEOGBfbEmgI+apZpZ6P0rkX/O/ohsuluY6Y0vk7B5BSCXBRXS7DzVZ/5rfU/UbLE7nrWIVLbPMEOt/crR2oEOuPL6qUB17rhjhMJBA459FBVYm8p3IKssgsmgMnQqoVyoxF98z1XL/xVtEqGmkCIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gId93+K9; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=MK44CnpY; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=dwEifkEo reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FNXkTq013250;
	Thu, 15 Feb 2024 15:48:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=/NItrR2Pd3c6BbnctaY2UObrjBiqOhCwayfc1peQu7k=; b=
	gId93+K98PU8G1LlFeKRE4941d/5ZjbHtgooVbSAR0/jZJ9L5KDxHqEQ39l3LWtv
	mbKCgygHYXXpnZUMzpo94m/JnSyW6txW3FWC0+WpU+oBqMyt106cLE0Wk3eE/IuK
	JSJnctkhI0jMw5aIdPHA1AkhBILQztIzNeY07BELgjXRAPWueiPY5T8jrv4N6BzC
	OjaxuxsomsJmC3SdO1SVKay2kt7u7ipVQ33GRtreKDV7SnTeINEGr7guvx5fBxV7
	ioxvGGShN2wyQUUFbqFA5/c/dpz9flpC9ShxUWPjZFJrpaD6tM0BfgFJMceBCTVr
	EvTK5vam9jhFwgIXururPA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3w68xwe41k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 15:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1708040931; bh=/NItrR2Pd3c6BbnctaY2UObrjBiqOhCwayfc1peQu7k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=MK44CnpY0iuZBQXzgkGxyw9zF+BHJ5SGJKmHD6lJ0u/EQNwlx36C+CctmVPiT8ESo
	 HGrAdjgb2citfpXqOdc4vaz3uaKcwJw60bMIhWia2GZfKIXXH3jDVPfa/zuTXIU14u
	 V6hO94PkzX4HK4h8PxQdpPmHWiazn7cOEQYaIM7o4UYEYofwcWUSMoVaG3mEzKMsWV
	 /DPi7pyQ7ImvWZlIPZgzzwN0kxtkbVqQff85XVbNitiJaQW+g3zEdqqdrG2oFOckUu
	 QEmMLLhL9JfbQ3txpzViKAo/3i8unamjdw4a2zq8pBFU3UKwA371pEYMns52lzqckw
	 Er8qOq0i0tMYw==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1A0EF40528;
	Thu, 15 Feb 2024 23:48:51 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8292EA005C;
	Thu, 15 Feb 2024 23:48:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=dwEifkEo;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D9DD7401C6;
	Thu, 15 Feb 2024 23:48:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1O0CzbEn8+BsFHVIFmhlnePh8tLiH4+N6OMmE7u+KpzuiaDTTH0tt26StvSvnm02tYVJP0jO71Fnprz/XfH5nyyI69wvR+8f/QMdvPItrP73db/S6SFpo0sEU+moM4ZHBS2/QkIbVyLd0xwEPWTG5vtOer/oASe3Kc0zjGmnAI83wVR+vxJ7TQtUDd8DfSQ3qB0adSpRGtHhcWQOeKiFY+DS4aUqgN0s5lyEcsLpbBONwJb/wCEnsX7X8GVi4fxBF4UtnbF3nm2bpXAPUo99KO1C+SMA+ajALpaiPgagiPlehiSPkNrkrVy6YOylH8wN7s85zJPW+YMzFUKwS+ZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NItrR2Pd3c6BbnctaY2UObrjBiqOhCwayfc1peQu7k=;
 b=ShAMvhG3w2fVxEVi4+DoWZ4nkQn5WUf0GPPQ2KyVh2V25jE/v0Ipi9fGB8Ksc0VIRjoue7eCR6gGkRTvGYFBdCBe6QcT7M8YCwaZOWfjtpHLsLK7+mjYmqi32SBVioa6rfV9AJsxrP8gKBeS82zmNr+oiUxaVPoVXTQgxhr0xWvm9/9/fEsHimzLrgILeV8cYIyLamdqB2Z8sLIgVUSQE+52hNeqBRghoZZlJ0IGd23IQ/ZSjCdHyEaOG8ApEZXOUTu/3WbJpy++CqnQ/9I09zCDmMEZDHljCkbdQekMittSgXLfWVxnjVMyr/P1Da7fEMDEXGgQMPfyf6GLvSz17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NItrR2Pd3c6BbnctaY2UObrjBiqOhCwayfc1peQu7k=;
 b=dwEifkEoJMpQf/0OAD4Hm4lCgBEf9CcNxx2kCAkvIOjocRqqSZFr09AdSMgEzJu8pmY7KFaATQjJcbPueujP/iXNZxujK7+d3x/T+8ujDadHpuHdLlUy/FVptM63rlS0xrBa5WM6BEN0S02QG3Xqo9AwZgseUSULFa9DPhYHIYo=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Thu, 15 Feb
 2024 23:48:46 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 23:48:46 +0000
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
Subject: Re: [PATCH v14 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Topic: [PATCH v14 7/9] usb: dwc3: qcom: Refactor IRQ handling in glue
 driver
Thread-Index: AQHaWLwRciUsQglSOEK/uJHURkWtEbEMIYmA
Date: Thu, 15 Feb 2024 23:48:46 +0000
Message-ID: <20240215234841.z6ai67z7u6ouwz7x@synopsys.com>
References: <20240206051825.1038685-1-quic_kriskura@quicinc.com>
 <20240206051825.1038685-8-quic_kriskura@quicinc.com>
In-Reply-To: <20240206051825.1038685-8-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: 06694cb7-2f39-403e-9221-08dc2e80a66a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fVKQ+4WEUlxziXj7SGM2tVFB1W8VDm6K3D/nPNMlW/LzyEMAUn6QuWAaNZ4WRUUjHoWfcuJGxe8n6S+d2WN0ICdT590IRSEmRz1k9tKhVtgWXuNVd3VEbBNioYqa/He5FP89skdVr8IAJSYmmREiWAFsog88NpiU/EMN2j6zGiu95pMUG9fFfd621LGSGA9i6Rjiz/CS4oIuoisaFrA/Fq5itw8uZsf3DZ662QySvh5vMY9kQftTzNR6CHbNYPnLNN5rSirCDw3VsZ3P8GNdVEUnwlbK3fcvC/vPHso9M8FzzOhzh6jvjwLF5Ncwjg9PkdbX6hDtLlcdtDHB8SYUER25HZgg+c2ghx5Ys3t/v9YyRifE4MXKG1V2PQzpCYzknT+HwsPvwZ076+C+jEXwPOqWqzmat229vUV6K/gkRS7gyxBBZSPchuiZFbKgOwJ7WA9XdkHchT9civzpjEu9LQucu1l0EY/9KSrP2Q8xet3wsuJB8Jy2ukhUqPnWWM7Q9Pv6cOZnmd3QWGBWtx+b7R1K1TDo6B6XQQ62n6210yE/oNfipur74069qJQ2qdPp0F7boTc6TXs4LfXG23bjI132pryEBXcbFBoNWTOMOkJpWTLoYHFLHoXPvxeRnLNl
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8936002)(30864003)(5660300002)(86362001)(8676002)(2906002)(4326008)(7416002)(2616005)(26005)(83380400001)(66446008)(1076003)(38100700002)(36756003)(122000001)(38070700009)(66946007)(64756008)(316002)(6916009)(6506007)(66476007)(71200400001)(76116006)(66556008)(54906003)(6486002)(6512007)(478600001)(41300700001)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXRRaWNkelIyVEo5a1k2YkVLSlpzcHNCOHMrU1Z5ank5WVJOM2FaV1ZWY3Vp?=
 =?utf-8?B?MlNaTm1VYTBFcEdUMmwxVXlYQVpybWlxMlBBUWNldnRPMmZOVFMxZlhaZEpE?=
 =?utf-8?B?NUVxK2pleG5zTHdnU2ZPU3R1VzBwTVhpUlRvVlZrTklleUtNeVJBMEtVdDg3?=
 =?utf-8?B?bjZ0dHJOVEo5bXZhZFkydks1SE1zaU14V1BCUHcvck9FbVRGMjJnMXdzZHRu?=
 =?utf-8?B?Y2lVOTJ5TVJzSW1iV21SSnFnVUdycE9VNm0vRkE0eXRkcTM1VlNXRWNlMm9t?=
 =?utf-8?B?UFYyTWE3bFZBaktuMWpmRnQ5aW1SaUowY1podG14elExRHl0bi95dmREQ0RJ?=
 =?utf-8?B?NUxUcmZsYUg0NXpEWDVlbFlNQ1VOa3llcWJkemtjQlZUbE5hamZjTWVuS054?=
 =?utf-8?B?Nlh4V0V0TjNGVkV0WFdJWHU3OFVQUU9lMEN3aktiMUVtam05Sm0zL1lwY0Ns?=
 =?utf-8?B?dTErSVltZDFkbDlYY1RVSWxwekZXRHlXd1oyYW0yM0FZOXFTZ0VRZXROSzNB?=
 =?utf-8?B?T2ZZU1VTaXYzR0Z0anFhOHpzZUxlaDBDTW9WVmV2ZXNRYmlSOVJSSGZXNUsy?=
 =?utf-8?B?elZZdzVTQkhTU2xGNmlzWjNVbVNZaENYWXBsMWU1UVhnMk5lOU5zNnBmczB3?=
 =?utf-8?B?VXRJa2l5SHR1a2tWN21Zb1VWUm5pWWIrUGplS1hjOG1xeHpHdW9Lbk1BdFFK?=
 =?utf-8?B?aUZ2cVBTL0luakNod21aYTZTVjBNRzhPMDVrUWlIOU9qV1M4Q0xWZmhQWVZt?=
 =?utf-8?B?b0c0MitVM0YwZHVWNHl0SHZLQVlKR1lyWnpTZHQ3M2IyZ0xEa1ljbFNWVkVH?=
 =?utf-8?B?UzNVVEd5WnJoeVEzRXMwdlV0S2ZiakJiSUFVcVB4ZTJqOGVITUZYMmlCZC9t?=
 =?utf-8?B?T1NNVEc3UmhJQzVXTW9zZzI3c1dVVGFaWTFoTFhYVE9zc3AwQSt5WUNyQk1C?=
 =?utf-8?B?ZjIxc2dTQnRRT1FmYXl6WElQbC9NbyszUjZ2NFllSHZybGg4ZURudFUxbkN4?=
 =?utf-8?B?KzlDNzFkeDgvamRWU1hWMlJPVjVPd2VjV2t3Q1dOVTJFcW94eEk5WnFhcGQw?=
 =?utf-8?B?Ymxwb1BJSkY2SUw0NHZjNFNMRVJhQ2hnMTNDK0drdFFRSXVXYVR2eDRycmxk?=
 =?utf-8?B?WTBETUNNeWg5NElJdHhnV1hBUmJ1NlpvcmF1OTJvVDNaZWlhWlFWclcxQzgv?=
 =?utf-8?B?N05QVFJDQ3h1RHl1SkE5eHFRZ2Zhd3pzL0lJNkVFREE1L0hmaFhDK0pRNnQr?=
 =?utf-8?B?RGRiRFBsejYrV2ljb01HdlIyVkMzVElNUGdkek03em5zVmpJN1l5Q0dVeE9t?=
 =?utf-8?B?Y1ZWdmx6WGd1TmRDb01JYjdLZ21oZGl5cXZUZThZZkJEUFBMcCs2dWU2R3BK?=
 =?utf-8?B?ekxSMjJrUlZYQ3FpTFZlNVJWbCthUU5jNVVRc2g1dGN5OUNQRzhTL1pJSnRU?=
 =?utf-8?B?aFYwM1BiR1Y1dm9WeU9uOWVuaE1GUjMwdDQwZng0Wk5vUTFjbkxTYVEyQms2?=
 =?utf-8?B?M1VaRU5pRi9vN3B6VmpJWmo5RjkzNXlHTlA5d09hRDJLdTRyVFZsdkJQbElU?=
 =?utf-8?B?b2pqSzQvNTlwR0Z5V2N0empLMHc0WDFMaDFJSXJuZk9zbUhTdWZNb1J0em82?=
 =?utf-8?B?M2lnRmN5KzZMRmFkT2UwbkdSUWR3aDl5cm5WR1o1QklXNS9qWFZEVlhlVUV5?=
 =?utf-8?B?dHM2S3E2a3pldUkwOURqQjQvMm1GTDlESUV2RXMveGhZMVNLWnBLV0tTRVZH?=
 =?utf-8?B?aVQ3aGNNaFJpS1M5b2pGM2FiMVJyc1IyY1VOQVVkRE5oWmtsa0hDUy9abmlK?=
 =?utf-8?B?UnAwSzJmRW1yYjMxcTZ4MW5tUThKUTZDY0tGN21YZUs3TUtDSFlQWTRvWUl4?=
 =?utf-8?B?WGh5Rm5OMGY0RkVqSldPeVM0MFdCUk5SSE1uTVcwT2Y1TXV5aERKQWJ6dU5U?=
 =?utf-8?B?N214WGsxejVGOE8zTWFnOHNOZFpvYXJpdG1RVzRhbXZMY09Lc1F4WnVPSEIz?=
 =?utf-8?B?dWtpM0ZOd0JoeHp6SlhKVGdVOVpuMVYxSk5ISnlSTjdoR3lSMjNkMVlCWjBC?=
 =?utf-8?B?THplcUFQSXZRVU5SQUN5UHZ2NHJlbms1c1BRQmxoQURxcWNCb0F1YW02Z1V1?=
 =?utf-8?B?MXNIYWpSUHJTYlJld21qbjcwZ0dtK1N1ZHdkNWw1c0MvWmdlRGZLQVdIVTQ1?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29CD059B97D59A4B912CBA78120129EF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SEOJqXnD/WHWfd+vZLGrU1yaZvqLnw5Xk35JZmjbpckDyQUjcaF8adEtDblFHhqOvi85LdrrkBfYOs6Gh16UjZ+LTRm9qRu1qzA/YPvIpDSPEnRfqS2dNvhkoljspXHK3ZG9ka4BIsv46RdxcVAZ/oTpwDF+JoHZA4nFpuR8I97+5RoPPFg4nEzyI/FBRMmctUQZudn2LTz/n786/4wXPRipqEX9z/C7yrWDDoPPqXKHJgmgPHUVimd5goZkU/OOtAB3mlIeuECGYIoZK14xhi2YdkMMHRnqEBTGg8OZpYJZeKl4peeMOkRdYD77A+WLDbx+uFNX7DGXxWXJRKiOBpyy/89Kp/PItTvsXffBNBjpetSng0JtxIuvs2Z/uldd8MSf7zoEd6DlP/Djt/l1/u3rv/KcT4lzTGNO3lnXHCI7HZ1NhyP9ig0VhCQPZcjg9BoBskuamGTgVkKiEdGvRsyRezY1Fw7ly6QVns3QpUmPepabnj0OJj1/saKUzqnmcf+EL81nrYvGBDqSQpI4hM97fvccT7XLJSi51PIr5id8AjOiQvDWXLXTI8pW/KTHWCdAeAanE0+h774p5ceStEKVj2SGaHiEPlKDMO2Vd+MemU24JgalQ+djn0+sIo+1luJYfLET+jBWa7wCCuMDdQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06694cb7-2f39-403e-9221-08dc2e80a66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 23:48:46.1825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4Ohl47+nuobxV2UkyQTdHCywwIO4Q/iy0a2Ju+gGW9HeNJ8tMiGcXfzdjhuIJH2POqR9+uqNl/ujo95UwlBEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
X-Proofpoint-ORIG-GUID: 8y01vukn_VnnajGEMSKN8IdyrHmp7HZs
X-Proofpoint-GUID: 8y01vukn_VnnajGEMSKN8IdyrHmp7HZs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402150185

T24gVHVlLCBGZWIgMDYsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IE9uIG11bHRp
cG9ydCBzdXBwb3J0ZWQgY29udHJvbGxlcnMsIGVhY2ggcG9ydCBoYXMgaXRzIG93biBEUC9ETQ0K
PiBhbmQgU1MgKGlmIHN1cGVyIHNwZWVkIGNhcGFibGUpIGludGVycnVwdHMuIEFzIHBlciB0aGUg
YmluZGluZ3MsDQo+IHRoZWlyIGludGVycnVwdCBuYW1lcyBkaWZmZXIgZnJvbSBzdGFuZGFyZCBv
bmVzIGhhdmluZyAiX3giIGFkZGVkDQo+IGFzIHN1ZmZpeCAoeCBpbmRpY2F0ZXMgcG9ydCBudW1i
ZXIpLiBSZWZhY3RvciBkd2MzX3Fjb21fc2V0dXBfaXJxKCkNCj4gY2FsbCB0byBwYXJzZSBtdWx0
aXBvcnQgaW50ZXJydXB0cyBhbG9uZyB3aXRoIG5vbi1tdWx0aXBvcnQgb25lcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+
DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyB8IDIyMiArKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2MSBpbnNlcnRp
b25zKCspLCA2MSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYw0KPiBpbmRleCAw
OGRmMjk1ODQzNjYuLmEyMGQ2M2E3OTFiZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9kd2MzLXFjb20uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IEBA
IC01MywxNyArNTMsMzMgQEANCj4gICNkZWZpbmUgQVBQU19VU0JfQVZHX0JXIDANCj4gICNkZWZp
bmUgQVBQU19VU0JfUEVBS19CVyBNQnBzX3RvX2ljYyg0MCkNCj4gIA0KPiArI2RlZmluZSBOVU1f
UEhZX0lSUQkJNA0KPiArDQo+ICtlbnVtIGR3YzNfcWNvbV9waHlfaW5kZXggew0KPiArCURQX0hT
X1BIWV9JUlFfSU5ERVgsDQo+ICsJRE1fSFNfUEhZX0lSUV9JTkRFWCwNCj4gKwlTU19QSFlfSVJR
X0lOREVYLA0KPiArCVFVU0IyX1BIWV9JUlFfSU5ERVgsDQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3Qg
ZHdjM19hY3BpX3BkYXRhIHsNCj4gIAl1MzIJCQlxc2NyYXRjaF9iYXNlX29mZnNldDsNCj4gIAl1
MzIJCQlxc2NyYXRjaF9iYXNlX3NpemU7DQo+ICAJdTMyCQkJZHdjM19jb3JlX2Jhc2Vfc2l6ZTsN
Cj4gLQlpbnQJCQlxdXNiMl9waHlfaXJxX2luZGV4Ow0KPiAtCWludAkJCWRwX2hzX3BoeV9pcnFf
aW5kZXg7DQo+IC0JaW50CQkJZG1faHNfcGh5X2lycV9pbmRleDsNCj4gLQlpbnQJCQlzc19waHlf
aXJxX2luZGV4Ow0KPiArCS8qDQo+ICsJICogVGhlIHBoeV9pcnFfaW5kZXggY29ycmVzcG9uZHMg
dG8gQUNQSSBpbmRleGVzIG9mIChpbiBvcmRlcikNCj4gKwkgKiBEUC9ETS9TUy9RVVNCMiBJUlEn
cyByZXNwZWN0aXZlbHkuDQo+ICsJICovDQo+ICsJaW50CQkJcGh5X2lycV9pbmRleFtOVU1fUEhZ
X0lSUV07DQo+ICAJYm9vbAkJCWlzX3VyczsNCj4gIH07DQo+ICANCj4gK3N0cnVjdCBkd2MzX3Fj
b21fcG9ydCB7DQo+ICsJaW50CQkJZHBfaHNfcGh5X2lycTsNCj4gKwlpbnQJCQlkbV9oc19waHlf
aXJxOw0KPiArCWludAkJCXNzX3BoeV9pcnE7DQo+ICt9Ow0KPiArDQo+ICBzdHJ1Y3QgZHdjM19x
Y29tIHsNCj4gIAlzdHJ1Y3QgZGV2aWNlCQkqZGV2Ow0KPiAgCXZvaWQgX19pb21lbQkJKnFzY3Jh
dGNoX2Jhc2U7DQo+IEBAIC03NCw5ICs5MCw3IEBAIHN0cnVjdCBkd2MzX3Fjb20gew0KPiAgCXN0
cnVjdCByZXNldF9jb250cm9sCSpyZXNldHM7DQo+ICANCj4gIAlpbnQJCQlxdXNiMl9waHlfaXJx
Ow0KPiAtCWludAkJCWRwX2hzX3BoeV9pcnE7DQo+IC0JaW50CQkJZG1faHNfcGh5X2lycTsNCj4g
LQlpbnQJCQlzc19waHlfaXJxOw0KPiArCXN0cnVjdCBkd2MzX3Fjb21fcG9ydAlwb3J0X2luZm9b
RFdDM19NQVhfUE9SVFNdOw0KPiAgCWVudW0gdXNiX2RldmljZV9zcGVlZAl1c2IyX3NwZWVkOw0K
PiAgDQo+ICAJc3RydWN0IGV4dGNvbl9kZXYJKmVkZXY7DQo+IEBAIC05MSw2ICsxMDUsNyBAQCBz
dHJ1Y3QgZHdjM19xY29tIHsNCj4gIAlib29sCQkJcG1fc3VzcGVuZGVkOw0KPiAgCXN0cnVjdCBp
Y2NfcGF0aAkJKmljY19wYXRoX2RkcjsNCj4gIAlzdHJ1Y3QgaWNjX3BhdGgJCSppY2NfcGF0aF9h
cHBzOw0KPiArCXU4CQkJbnVtX3BvcnRzOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGlubGluZSB2
b2lkIGR3YzNfcWNvbV9zZXRiaXRzKHZvaWQgX19pb21lbSAqYmFzZSwgdTMyIG9mZnNldCwgdTMy
IHZhbCkNCj4gQEAgLTM3NSwxNiArMzkwLDE2IEBAIHN0YXRpYyB2b2lkIGR3YzNfcWNvbV9kaXNh
YmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSkNCj4gIAlkd2MzX3Fjb21fZGlz
YWJsZV93YWtldXBfaXJxKHFjb20tPnF1c2IyX3BoeV9pcnEpOw0KPiAgDQo+ICAJaWYgKHFjb20t
PnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0KPiAtCQlkd2MzX3Fjb21fZGlzYWJsZV93
YWtldXBfaXJxKHFjb20tPmRtX2hzX3BoeV9pcnEpOw0KPiArCQlkd2MzX3Fjb21fZGlzYWJsZV93
YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5kbV9oc19waHlfaXJxKTsNCj4gIAl9IGVsc2Ug
aWYgKChxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9ISUdIKSB8fA0KPiAgCQkJKHFjb20t
PnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0ZVTEwpKSB7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxl
X3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxl
X3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvWzBdLmRwX2hzX3BoeV9pcnEpOw0KPiAgCX0gZWxz
ZSB7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2ly
cSk7DQo+IC0JCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+ZG1faHNfcGh5X2ly
cSk7DQo+ICsJCWR3YzNfcWNvbV9kaXNhYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvWzBd
LmRwX2hzX3BoeV9pcnEpOw0KPiArCQlkd2MzX3Fjb21fZGlzYWJsZV93YWtldXBfaXJxKHFjb20t
PnBvcnRfaW5mb1swXS5kbV9oc19waHlfaXJxKTsNCj4gIAl9DQo+ICANCj4gLQlkd2MzX3Fjb21f
ZGlzYWJsZV93YWtldXBfaXJxKHFjb20tPnNzX3BoeV9pcnEpOw0KPiArCWR3YzNfcWNvbV9kaXNh
YmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvWzBdLnNzX3BoeV9pcnEpOw0KPiAgfQ0KPiAg
DQo+ICBzdGF0aWMgdm9pZCBkd2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMoc3RydWN0IGR3YzNf
cWNvbSAqcWNvbSkNCj4gQEAgLTQwMSwyMCArNDE2LDIwIEBAIHN0YXRpYyB2b2lkIGR3YzNfcWNv
bV9lbmFibGVfaW50ZXJydXB0cyhzdHJ1Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgCSAqLw0KPiAg
DQo+ICAJaWYgKHFjb20tPnVzYjJfc3BlZWQgPT0gVVNCX1NQRUVEX0xPVykgew0KPiAtCQlkd2Mz
X3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZG1faHNfcGh5X2lycSwNCj4gLQkJCQkJCUlS
UV9UWVBFX0VER0VfRkFMTElORyk7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShx
Y29tLT5wb3J0X2luZm9bMF0uZG1faHNfcGh5X2lycSwNCj4gKwkJCQkJICAgIElSUV9UWVBFX0VE
R0VfRkFMTElORyk7DQo+ICAJfSBlbHNlIGlmICgocWNvbS0+dXNiMl9zcGVlZCA9PSBVU0JfU1BF
RURfSElHSCkgfHwNCj4gIAkJCShxY29tLT51c2IyX3NwZWVkID09IFVTQl9TUEVFRF9GVUxMKSkg
ew0KPiAtCQlkd2MzX3Fjb21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+ZHBfaHNfcGh5X2lycSwN
Cj4gLQkJCQkJCUlSUV9UWVBFX0VER0VfRkFMTElORyk7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVf
d2FrZXVwX2lycShxY29tLT5wb3J0X2luZm9bMF0uZHBfaHNfcGh5X2lycSwNCj4gKwkJCQkJICAg
IElSUV9UWVBFX0VER0VfRkFMTElORyk7DQo+ICAJfSBlbHNlIHsNCj4gLQkJZHdjM19xY29tX2Vu
YWJsZV93YWtldXBfaXJxKHFjb20tPmRwX2hzX3BoeV9pcnEsDQo+IC0JCQkJCQlJUlFfVFlQRV9F
REdFX1JJU0lORyk7DQo+IC0JCWR3YzNfcWNvbV9lbmFibGVfd2FrZXVwX2lycShxY29tLT5kbV9o
c19waHlfaXJxLA0KPiAtCQkJCQkJSVJRX1RZUEVfRURHRV9SSVNJTkcpOw0KPiArCQlkd2MzX3Fj
b21fZW5hYmxlX3dha2V1cF9pcnEocWNvbS0+cG9ydF9pbmZvWzBdLmRwX2hzX3BoeV9pcnEsDQo+
ICsJCQkJCSAgICBJUlFfVFlQRV9FREdFX1JJU0lORyk7DQo+ICsJCWR3YzNfcWNvbV9lbmFibGVf
d2FrZXVwX2lycShxY29tLT5wb3J0X2luZm9bMF0uZG1faHNfcGh5X2lycSwNCj4gKwkJCQkJICAg
IElSUV9UWVBFX0VER0VfUklTSU5HKTsNCj4gIAl9DQo+ICANCj4gLQlkd2MzX3Fjb21fZW5hYmxl
X3dha2V1cF9pcnEocWNvbS0+c3NfcGh5X2lycSwgMCk7DQo+ICsJZHdjM19xY29tX2VuYWJsZV93
YWtldXBfaXJxKHFjb20tPnBvcnRfaW5mb1swXS5zc19waHlfaXJxLCAwKTsNCj4gIH0NCj4gIA0K
PiAgc3RhdGljIGludCBkd2MzX3Fjb21fc3VzcGVuZChzdHJ1Y3QgZHdjM19xY29tICpxY29tLCBi
b29sIHdha2V1cCkNCj4gQEAgLTUzNSw2ICs1NTAsNzQgQEAgc3RhdGljIGludCBkd2MzX3Fjb21f
Z2V0X2lycShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgCXJldHVybiByZXQ7DQo+
ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgZHdjM19xY29tX2dldF9pcnFfaW5kZXgoY29uc3QgY2hh
ciAqaXJxX25hbWUpDQo+ICt7DQo+ICsJLyoNCj4gKwkgKiBQYXJzZSBJUlEgaW5kZXggYmFzZWQg
b24gcHJlZml4ZXMgZnJvbSBpbnRlcnJ1cHQgbmFtZS4NCj4gKwkgKiBSZXR1cm4gLTEgaW5jYXNl
IG9mIGFuIGludmFsaWQgaW50ZXJydXB0IG5hbWUuDQo+ICsJICovDQo+ICsJaW50IGlycV9pbmRl
eCA9IC0xOw0KPiArDQo+ICsJaWYgKHN0cm5jbXAoaXJxX25hbWUsICJkcF9oc19waHkiLCBzdHJs
ZW4oImRwX2hzX3BoeSIpKSA9PSAwKQ0KPiArCQlpcnFfaW5kZXggPSBEUF9IU19QSFlfSVJRX0lO
REVYOw0KPiArCWVsc2UgaWYgKHN0cm5jbXAoaXJxX25hbWUsICJkbV9oc19waHkiLCBzdHJsZW4o
ImRtX2hzX3BoeSIpKSA9PSAwKQ0KPiArCQlpcnFfaW5kZXggPSBETV9IU19QSFlfSVJRX0lOREVY
Ow0KPiArCWVsc2UgaWYgKHN0cm5jbXAoaXJxX25hbWUsICJzc19waHkiLCBzdHJsZW4oInNzX3Bo
eSIpKSA9PSAwKQ0KPiArCQlpcnFfaW5kZXggPSBTU19QSFlfSVJRX0lOREVYOw0KPiArCWVsc2Ug
aWYgKHN0cm5jbXAoaXJxX25hbWUsICJxdXNiMl9waHkiLCBzdHJsZW4oInF1c2IyX3BoeSIpKSA9
PSAwKQ0KPiArCQlpcnFfaW5kZXggPSBRVVNCMl9QSFlfSVJRX0lOREVYOw0KPiArCXJldHVybiBp
cnFfaW5kZXg7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgZHdjM19xY29tX2dldF9wb3J0X2lu
ZGV4KGNvbnN0IGNoYXIgKmlycV9uYW1lLCBpbnQgaXJxX2luZGV4KQ0KPiArew0KPiArCWludCBw
b3J0X2luZGV4ID0gLTE7DQo+ICsNCj4gKwlzd2l0Y2ggKGlycV9pbmRleCkgew0KPiArCWNhc2Ug
RFBfSFNfUEhZX0lSUV9JTkRFWDoNCj4gKwkJaWYgKHN0cmNtcChpcnFfbmFtZSwgImRwX2hzX3Bo
eV9pcnEiKSA9PSAwKQ0KPiArCQkJcG9ydF9pbmRleCA9IDE7DQo+ICsJCWVsc2UNCj4gKwkJCXNz
Y2FuZihpcnFfbmFtZSwgImRwX2hzX3BoeV8lZCIsICZwb3J0X2luZGV4KTsNCj4gKwkJYnJlYWs7
DQo+ICsJY2FzZSBETV9IU19QSFlfSVJRX0lOREVYOg0KPiArCQlpZiAoc3RyY21wKGlycV9uYW1l
LCAiZG1faHNfcGh5X2lycSIpID09IDApDQo+ICsJCQlwb3J0X2luZGV4ID0gMTsNCj4gKwkJZWxz
ZQ0KPiArCQkJc3NjYW5mKGlycV9uYW1lLCAiZG1faHNfcGh5XyVkIiwgJnBvcnRfaW5kZXgpOw0K
PiArCQlicmVhazsNCj4gKwljYXNlIFNTX1BIWV9JUlFfSU5ERVg6DQo+ICsJCWlmIChzdHJjbXAo
aXJxX25hbWUsICJzc19waHlfaXJxIikgPT0gMCkNCj4gKwkJCXBvcnRfaW5kZXggPSAxOw0KPiAr
CQllbHNlDQo+ICsJCQlzc2NhbmYoaXJxX25hbWUsICJzc19waHlfJWQiLCAmcG9ydF9pbmRleCk7
DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgUVVTQjJfUEhZX0lSUV9JTkRFWDoNCj4gKwkJcG9ydF9p
bmRleCA9IDE7DQo+ICsJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCWlmIChwb3J0X2luZGV4IDw9
IDAgfHwgcG9ydF9pbmRleCA+IERXQzNfTUFYX1BPUlRTKQ0KPiArCQlwb3J0X2luZGV4ID0gLTE7
DQo+ICsNCj4gKwlyZXR1cm4gcG9ydF9pbmRleDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBk
d2MzX3Fjb21fZ2V0X2FjcGlfaW5kZXgoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgaW50IGlycV9p
bmRleCwNCj4gKwkJCQkgICAgaW50IHBvcnRfaW5kZXgpDQo+ICt7DQo+ICsJY29uc3Qgc3RydWN0
IGR3YzNfYWNwaV9wZGF0YSAqcGRhdGEgPSBxY29tLT5hY3BpX3BkYXRhOw0KPiArDQo+ICsJLyoN
Cj4gKwkgKiBDdXJyZW50bHkgbXVsdGlwb3J0IHN1cHBvcnRlZCB0YXJnZXRzIGRvbid0IGhhdmUg
YW4gQUNQSSB2YXJpYW50Lg0KPiArCSAqIFNvIHJldHVybiAtMSBpZiB3ZSBhcmUgbm90IGRlYWxp
bmcgd2l0aCBmaXJzdCBwb3J0IG9mIHRoZSBjb250cm9sbGVyLg0KPiArCSAqLw0KPiArCWlmICgh
cGRhdGEgfHwgcG9ydF9pbmRleCAhPSAxKQ0KPiArCQlyZXR1cm4gLTE7DQo+ICsNCj4gKwlyZXR1
cm4gcGRhdGEtPnBoeV9pcnFfaW5kZXhbaXJxX2luZGV4XTsNCj4gK30NCj4gKw0KPiAgc3RhdGlj
IGludCBkd2MzX3Fjb21fcmVxdWVzdF9pcnEoc3RydWN0IGR3YzNfcWNvbSAqcWNvbSwgaW50IGly
cSwNCj4gIAkJCQkgY29uc3QgY2hhciAqbmFtZSkNCj4gIHsNCj4gQEAgLTU1NCw0NCArNjM3LDY3
IEBAIHN0YXRpYyBpbnQgZHdjM19xY29tX3JlcXVlc3RfaXJxKHN0cnVjdCBkd2MzX3Fjb20gKnFj
b20sIGludCBpcnEsDQo+ICBzdGF0aWMgaW50IGR3YzNfcWNvbV9zZXR1cF9pcnEoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjM19xY29tICpxY29tID0g
cGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+IC0JY29uc3Qgc3RydWN0IGR3YzNfYWNwaV9w
ZGF0YSAqcGRhdGEgPSBxY29tLT5hY3BpX3BkYXRhOw0KPiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnAgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCj4gKwljb25zdCBjaGFyICoqaXJxX25hbWVzOw0KPiAr
CWludCBwb3J0X2luZGV4Ow0KPiArCWludCBhY3BpX2luZGV4Ow0KPiArCWludCBpcnFfY291bnQ7
DQo+ICsJaW50IGlycV9pbmRleDsNCj4gIAlpbnQgaXJxOw0KPiAgCWludCByZXQ7DQo+ICsJaW50
IGk7DQo+ICANCj4gLQlpcnEgPSBkd2MzX3Fjb21fZ2V0X2lycShwZGV2LCAicXVzYjJfcGh5IiwN
Cj4gLQkJCQlwZGF0YSA/IHBkYXRhLT5xdXNiMl9waHlfaXJxX2luZGV4IDogLTEpOw0KPiAtCWlm
IChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2lycShxY29tLCBpcnEs
ICJoc19waHlfaXJxIik7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAtCQlx
Y29tLT5xdXNiMl9waHlfaXJxID0gaXJxOw0KPiAtCX0NCj4gKwlpcnFfY291bnQgPSBvZl9wcm9w
ZXJ0eV9jb3VudF9zdHJpbmdzKG5wLCAiaW50ZXJydXB0LW5hbWVzIik7DQo+ICsJaWYgKGlycV9j
b3VudCA8IDApDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiAgDQo+IC0JaXJxID0gZHdjM19xY29t
X2dldF9pcnEocGRldiwgImRwX2hzX3BoeV9pcnEiLA0KPiAtCQkJCXBkYXRhID8gcGRhdGEtPmRw
X2hzX3BoeV9pcnFfaW5kZXggOiAtMSk7DQo+IC0JaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0g
ZHdjM19xY29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwgImRwX2hzX3BoeV9pcnEiKTsNCj4gLQkJ
aWYgKHJldCkNCj4gLQkJCXJldHVybiByZXQ7DQo+IC0JCXFjb20tPmRwX2hzX3BoeV9pcnEgPSBp
cnE7DQo+IC0JfQ0KPiArCWlycV9uYW1lcyA9IGRldm1fa2NhbGxvYygmcGRldi0+ZGV2LCBpcnFf
Y291bnQsIHNpemVvZigqaXJxX25hbWVzKSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFpcnFfbmFt
ZXMpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiAgDQo+IC0JaXJxID0gZHdjM19xY29tX2dldF9p
cnEocGRldiwgImRtX2hzX3BoeV9pcnEiLA0KPiAtCQkJCXBkYXRhID8gcGRhdGEtPmRtX2hzX3Bo
eV9pcnFfaW5kZXggOiAtMSk7DQo+IC0JaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0gZHdjM19x
Y29tX3JlcXVlc3RfaXJxKHFjb20sIGlycSwgImRtX2hzX3BoeV9pcnEiKTsNCj4gLQkJaWYgKHJl
dCkNCj4gLQkJCXJldHVybiByZXQ7DQo+IC0JCXFjb20tPmRtX2hzX3BoeV9pcnEgPSBpcnE7DQo+
IC0JfQ0KPiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nX2FycmF5KG5wLCAiaW50ZXJy
dXB0LW5hbWVzIiwNCj4gKwkJCQkJICAgIGlycV9uYW1lcywgaXJxX2NvdW50KTsNCj4gKwlpZiAo
IXJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiAtCWlycSA9IGR3YzNfcWNvbV9nZXRfaXJx
KHBkZXYsICJzc19waHlfaXJxIiwNCj4gLQkJCQlwZGF0YSA/IHBkYXRhLT5zc19waHlfaXJxX2lu
ZGV4IDogLTEpOw0KPiAtCWlmIChpcnEgPiAwKSB7DQo+IC0JCXJldCA9IGR3YzNfcWNvbV9yZXF1
ZXN0X2lycShxY29tLCBpcnEsICJzc19waHlfaXJxIik7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQly
ZXR1cm4gcmV0Ow0KPiAtCQlxY29tLT5zc19waHlfaXJxID0gaXJxOw0KPiArCWZvciAoaSA9IDA7
IGkgPCBpcnFfY291bnQ7IGkrKykgew0KPiArCQlpcnFfaW5kZXggPSBkd2MzX3Fjb21fZ2V0X2ly
cV9pbmRleChpcnFfbmFtZXNbaV0pOw0KPiArCQlpZiAoaXJxX2luZGV4ID09IC0xKSB7DQo+ICsJ
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJVbmtub3duIGludGVycnVwdC1uYW1lIFwiJXNcIiBmb3Vu
ZFxuIiwgaXJxX25hbWVzW2ldKTsNCj4gKwkJCWNvbnRpbnVlOw0KPiArCQl9DQo+ICsJCXBvcnRf
aW5kZXggPSBkd2MzX3Fjb21fZ2V0X3BvcnRfaW5kZXgoaXJxX25hbWVzW2ldLCBpcnFfaW5kZXgp
Ow0KPiArCQlpZiAocG9ydF9pbmRleCA9PSAtMSkgew0KPiArCQkJZGV2X2VycigmcGRldi0+ZGV2
LCAiSW52YWxpZCBpbnRlcnJ1cHQtbmFtZSBzdWZmaXggXCIlc1wiXG4iLCBpcnFfbmFtZXNbaV0p
Ow0KPiArCQkJY29udGludWU7DQo+ICsJCX0NCj4gKw0KPiArCQlhY3BpX2luZGV4ID0gZHdjM19x
Y29tX2dldF9hY3BpX2luZGV4KHFjb20sIGlycV9pbmRleCwgcG9ydF9pbmRleCk7DQo+ICsNCj4g
KwkJaXJxID0gZHdjM19xY29tX2dldF9pcnEocGRldiwgaXJxX25hbWVzW2ldLCBhY3BpX2luZGV4
KTsNCj4gKwkJaWYgKGlycSA+IDApIHsNCj4gKwkJCXJldCA9IGR3YzNfcWNvbV9yZXF1ZXN0X2ly
cShxY29tLCBpcnEsIGlycV9uYW1lc1tpXSk7DQo+ICsJCQlpZiAocmV0KQ0KPiArCQkJCXJldHVy
biByZXQ7DQo+ICsNCj4gKwkJCXN3aXRjaCAoaXJxX2luZGV4KSB7DQo+ICsJCQljYXNlIERQX0hT
X1BIWV9JUlFfSU5ERVg6DQo+ICsJCQkJcWNvbS0+cG9ydF9pbmZvW3BvcnRfaW5kZXggLSAxXS5k
cF9oc19waHlfaXJxID0gaXJxOw0KPiArCQkJCWJyZWFrOw0KPiArCQkJY2FzZSBETV9IU19QSFlf
SVJRX0lOREVYOg0KPiArCQkJCXFjb20tPnBvcnRfaW5mb1twb3J0X2luZGV4IC0gMV0uZG1faHNf
cGh5X2lycSA9IGlycTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCWNhc2UgU1NfUEhZX0lSUV9JTkRF
WDoNCj4gKwkJCQlxY29tLT5wb3J0X2luZm9bcG9ydF9pbmRleCAtIDFdLnNzX3BoeV9pcnEgPSBp
cnE7DQo+ICsJCQkJYnJlYWs7DQo+ICsJCQljYXNlIFFVU0IyX1BIWV9JUlFfSU5ERVg6DQo+ICsJ
CQkJcWNvbS0+cXVzYjJfcGh5X2lycSA9IGlycTsNCj4gKwkJCQlicmVhazsNCj4gKwkJCX0NCj4g
Kw0KPiArCQkJaWYgKHFjb20tPm51bV9wb3J0cyA8IHBvcnRfaW5kZXgpDQo+ICsJCQkJcWNvbS0+
bnVtX3BvcnRzID0gcG9ydF9pbmRleDsNCj4gKwkJfQ0KPiAgCX0NCj4gIA0KPiAgCXJldHVybiAw
Ow0KPiBAQCAtMTA1MywyMCArMTE1OSwxNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGR3YzNfYWNw
aV9wZGF0YSBzZG04NDVfYWNwaV9wZGF0YSA9IHsNCj4gIAkucXNjcmF0Y2hfYmFzZV9vZmZzZXQg
PSBTRE04NDVfUVNDUkFUQ0hfQkFTRV9PRkZTRVQsDQo+ICAJLnFzY3JhdGNoX2Jhc2Vfc2l6ZSA9
IFNETTg0NV9RU0NSQVRDSF9TSVpFLA0KPiAgCS5kd2MzX2NvcmVfYmFzZV9zaXplID0gU0RNODQ1
X0RXQzNfQ09SRV9TSVpFLA0KPiAtCS5xdXNiMl9waHlfaXJxX2luZGV4ID0gMSwNCj4gLQkuZHBf
aHNfcGh5X2lycV9pbmRleCA9IDQsDQo+IC0JLmRtX2hzX3BoeV9pcnFfaW5kZXggPSAzLA0KPiAt
CS5zc19waHlfaXJxX2luZGV4ID0gMg0KPiArCS5waHlfaXJxX2luZGV4ID0gezQsIDMsIDIsIDF9
LA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkd2MzX2FjcGlfcGRhdGEgc2Rt
ODQ1X2FjcGlfdXJzX3BkYXRhID0gew0KPiAgCS5xc2NyYXRjaF9iYXNlX29mZnNldCA9IFNETTg0
NV9RU0NSQVRDSF9CQVNFX09GRlNFVCwNCj4gIAkucXNjcmF0Y2hfYmFzZV9zaXplID0gU0RNODQ1
X1FTQ1JBVENIX1NJWkUsDQo+ICAJLmR3YzNfY29yZV9iYXNlX3NpemUgPSBTRE04NDVfRFdDM19D
T1JFX1NJWkUsDQo+IC0JLnF1c2IyX3BoeV9pcnFfaW5kZXggPSAxLA0KPiAtCS5kcF9oc19waHlf
aXJxX2luZGV4ID0gNCwNCj4gLQkuZG1faHNfcGh5X2lycV9pbmRleCA9IDMsDQo+IC0JLnNzX3Bo
eV9pcnFfaW5kZXggPSAyLA0KPiArCS5waHlfaXJxX2luZGV4ID0gezQsIDMsIDIsIDF9LA0KPiAg
CS5pc191cnMgPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tl
ZC1ieTogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpCUiwNClRo
aW5o

