Return-Path: <linux-kernel+bounces-156080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DC68AFDA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E441A1F22BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FE63D0;
	Wed, 24 Apr 2024 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AWf2CDYQ";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QvdesJKB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="sOnXz3dM"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A44C7C;
	Wed, 24 Apr 2024 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921310; cv=fail; b=n+pjoTbYOkZpgGityh6nNYx+xYzljPHPK0XYlK0V6pT+C+IdbCLrq4ssj1dvQRgaL+UqL7+OscDWPVreS7/PMmNT0RtAp//T3X/zRJlryvfMYYgBzmxjP/cqCa+1HaLK3qnaQzblvsVNeAEpXTVi4y00ffHiaLAGudHFoc7sbMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921310; c=relaxed/simple;
	bh=6rtFHeQNu/R7oZaWzdIa+axagaGFScmJFI+alf9Y1p8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IVL3lktn2E/7zB9I/QetRfZSXV4kKU1q0/QOE9I80Ohx5IEjrBsEGefFgUIbdbwY9ckU895UtPoAmCNzYizgkqLkuCxekHJ+ripZm8kcbqscH/1dAxrVaFAFVwDjZ1MMgBGdeH0474ULwJY64tSN6lTyXQfAdAmMqSAZkISmiHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=AWf2CDYQ; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=QvdesJKB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=sOnXz3dM reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0wMY2019660;
	Tue, 23 Apr 2024 18:14:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=6rtFHeQNu/R7oZaWzdIa+axagaGFScmJFI+alf9Y1p8=; b=
	AWf2CDYQfrHBH/J3VUN2Z7Bf3LejFpT+kHUBuBpgllfRhsYEboY02IouF6J2Mqeb
	tMH2p/hMMvWLhDuywTmnksscm0ckDD6dCtg9SmK3Yi5LFSnPjaK3jvE9Rb6Aoe4e
	1te41+oxX8i6HpbSyeosOCqpPKlcCKp0JEFmqlTes44YLbsjuxzsq23a5eEHdIvH
	oLuq28EfApMMMRr7UfeKWsA5IMNo2eMtkZ2EfBskJNObpvFpjczOrwSJ3VORmRON
	5C/eBuy2CSzF1i6ZVlI/iPe9UzoIq+bkxhoSfh5lyfua+5SEWT8UDZAFPKg4D4mv
	EOm7eiOywSsllvxSZiTneQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6xjd99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713921288; bh=6rtFHeQNu/R7oZaWzdIa+axagaGFScmJFI+alf9Y1p8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=QvdesJKBjJtlt3FojmBPdbEBfVyc2dueY9OdbLZY+UgtPd7RvMTR6sD9jbLkyvc5/
	 y2n52YsP63QqXBfG5a+HyqAy2TQJB3R9G8QC1Bl0b3lhy/F6O6CXsRcmOLsORfst/b
	 5LajYcYrijcKw9VLvvIf8hDfrBnDjJRK/hvHCRZwYLH7UVwpLavkkrgTuHH90SEbqV
	 4kUsf70p8JjOnZYhca4QY37pDn72T2k5otOf9aOTV31DHJKFBXNQ6BkyI6RhxRui+z
	 CnOct0DMs12m6xb/o+Q1GmBtbXviLcvANbfBE5aqMH4ExDlzVI0V9/lhQbZIqDLF4i
	 RoJr6/w8QSvoQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 691314034B;
	Wed, 24 Apr 2024 01:14:48 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 02C6FA005C;
	Wed, 24 Apr 2024 01:14:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=sOnXz3dM;
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id BD156400A2;
	Wed, 24 Apr 2024 01:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEZ3r9+L3BD5arC4MHocucuttIDoqpVUK57UemcrG2yWy/kEuP6V135xs4tPfX3ThTHYfE8S1XzN0dZ2CvBuOuEJOfnQt2eED/XJ31NUUG2beLjGOMof3/MN3yF2pSJovMKwrZ5q9TNo+NS1dCmngPw1clfkiNxAAMyraCQpmpTxyQ+pv6qRBAXGBMlvUvJVBlOMo+qqi3IkCa42WyRMSNU+bdCdMmdVomlHidbtyWSSjoZhluZV+DjgLKqj9tAVfWfdvJrfinYBqTL+pWID4MSoXF9KkM4Xh1x91rThobGCELvBGj7IguncXTnbOjetMqGi5BCmrKumAhNkjkQGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rtFHeQNu/R7oZaWzdIa+axagaGFScmJFI+alf9Y1p8=;
 b=KrLjzEnEBVL7kwc76u2H6XkNZtWSVAHsMit2JEA20XEqjvTrOxqbtFjA5wQ1nAPpRKgluqYbzHC6JZdn/49Ipyeq0XDJ/N5bo29DhUESqLSKpS/Y9L0jUMZ/o9v8a1ON7zUdSC9B4Sos/nFA2d6JMxtwGduSPFIYwlJYVMPdr+esgxzroIN9gy9kxdDfHoHwb3bpDPvKFcdQ+6FR9dmYK1CRzR3G+yyRSeTvqgTfsb2EnTYxGrxoKIGO55+A2h1vAwY0zm31PXu70/0m385bSpXKao9ACVgI96s1FYVqQgyPYkICmEcOnr1DvNwHfq7izF0M9zeziToZwEnkuqkPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rtFHeQNu/R7oZaWzdIa+axagaGFScmJFI+alf9Y1p8=;
 b=sOnXz3dM2+3MP6ynsRP/PcPpImUHJwmedEmbWrwtEB6Uv0TWLNLoP1XZA0eQcJehLaGS7t35R7+CyahCs0MxEKL3cKyCv8g1wDboXlJH+SWPHHeiN9HByVUexkDj0zhYz23giIK7u2fvNccZcIOowg6Vr44qhbpYX3GUGjYua9c=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:14:44 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:14:44 +0000
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v21 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Topic: [PATCH v21 6/9] usb: dwc3: qcom: Add helper function to request
 wakeup interrupts
Thread-Index: AQHakt46y+IIcneCOU+ieDugvJyBO7F2o9SA
Date: Wed, 24 Apr 2024 01:14:44 +0000
Message-ID: <20240424011441.iel2ozx7wevqzzji@synopsys.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-7-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-7-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CY8PR12MB7682:EE_
x-ms-office365-filtering-correlation-id: 54aff3ef-47a6-4016-192e-08dc63fbed3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dGZSS1RzSE00cUpOTy9OWUVoYjE0S1M5dVVFK3FKMVJZbHVDM3pzMUFzdFFy?=
 =?utf-8?B?a0FXbWMxZFZNWmcyLzdtSmhDeFZFZHR6WWdnSEc2ZkdYSTJiNlp3ZG5CU1Jq?=
 =?utf-8?B?NVlGK3RubVo1N3diMEt5bU5SUDJWWTJvOHdlcDRmT2NHWGNRbXMzOUUvcFA3?=
 =?utf-8?B?MmtUa0N1cm1TeDBqZ0VXME8vemZXRkJEODd3WG9PNjhDZk12TTNyMHJXS2VS?=
 =?utf-8?B?dTBwWTFUb29TUWMyYnhELy9RUFlzVEpPRWdobEl5TmNzUzE1YnFaTENFSUxC?=
 =?utf-8?B?NktlUmZWZThKTjRUTy81SEUycE04NTNrZ0JleFRXek9mRnZOQjVmRnV4V3I0?=
 =?utf-8?B?MTdXaGxrMUxFQ2dUR3JzeTNESjFQT3UvU3UvNS9GUy9PV0JkenpPb29LVWU4?=
 =?utf-8?B?TUlJU01KNXVKK2pFVTJ2Skcrd3RNTEt4ZFVJd2luMWppRWV5ZHZta2dJdHc4?=
 =?utf-8?B?Z21HcHJVT1k0MHM1S0RMd1JhckRYL0VsRU04dkJ1UVV1MmJBaVY2ZE0vei9U?=
 =?utf-8?B?ZmVHWGxLRVJSNHVIeUZTVUVXcHpqd2lUdFI5bklDZytObU13UDFGMURqSUhB?=
 =?utf-8?B?eDB0NDNvM2Y0R2JkVGxGVWJjWi9ldUtrT3k1MHhRUExDclpJallVN1VHdUJs?=
 =?utf-8?B?VjIyVW13d3NOa25tb0duR21qMjIxV2RSQllsYlEzQ0JhbndtTnljaWFDT3BF?=
 =?utf-8?B?VzRsTGtlRjlGSG1GdXNNS1hFRjBOTXFpSnJNVDNnMDRTUzMrcGE1QzBySHla?=
 =?utf-8?B?MEg0VkRpNytoSS8ydTNBUkdzTnllWDRNUlVlSzIvd0l3VlNVRC9XaXNEbXVz?=
 =?utf-8?B?Mk9DK3hTOTlPaWgvaDg4Q1lWYitsOFVLdkx5T3NlNUNTMTRxM1k3bWZIT3Fh?=
 =?utf-8?B?M1FBOW01WUVjcUxCbnVra1RjRG01eUdFRWVPYnFtZnlZNlNkSURIR2pZQkJE?=
 =?utf-8?B?MmhGNkFDRDlqbC9wQW1HMlFucVIyenFMUU1Va3Y1ZzJlNTVFSE9NekVSVlFj?=
 =?utf-8?B?QnJIZlZtVHorQ2ltdDNxU2dJNjZMZE5qQ2hSRHZTcWVqYlVxV0RBMTNjRnNu?=
 =?utf-8?B?cXpyc0RRcFF4RDNweFpjTmNJYlhqT1ZpT21FU3VBaTBVbWphejJIenkxc0Zl?=
 =?utf-8?B?R2ZHYkxmOFhxdjZJTXpHOVl2SWp4QW5qS1U3TGVVWFN2NTdZL2FtU3ZoNmZn?=
 =?utf-8?B?bVU0blFWOForVXBEbEdCUnRiOFlmU042Nm9RY2dSTGtkem1oWmNyWDBXMVU4?=
 =?utf-8?B?V1dqN1lNKzNPZDBUR0FyNGxXRDdEbHJVWUMwY1V6M1Q4S3lxdFpSYzhPUmZB?=
 =?utf-8?B?V21kV0grZEM1bDdldGVqK0FzWU95OXdKZm5hWERVL2dFSms4SVJ3LzFYWWtZ?=
 =?utf-8?B?Q3JyYzV5WlhBTGI3L3ZiUkY1SVZYdXF0bXB4Q2hObFVpbzBwYWRna1QwT0d6?=
 =?utf-8?B?UGgycEhOZzZ1UlhSdXh3NkdMREdKb3VVZFNGSHlacW9OV3JjWStMLzdML3hZ?=
 =?utf-8?B?TUQrTWtTcThZZHZoUHJuNlhCWmdGZHFSZ3N0S1U4RGoxQlBTM3NkNEJaTVpq?=
 =?utf-8?B?aFhoWndZUXkvb0FJSFQxRnRwUU8xQU5iN1pQaGI0UTJJUitkWXVsdkJkdmVu?=
 =?utf-8?B?RzBnaHMzQno3L09HRExtanJCeHRMaHRnS2pNeU04OUp6N000aXIrbGhaeDUy?=
 =?utf-8?B?dElidkNDN0k4aXhpbGF5UDZKT1dqb3N6bEVGYmxRZmQxK2h6cXNSbUJYNU10?=
 =?utf-8?B?R1NWRWhwbGlUbTFtdnlGQ2lrRjI2TzZrTCtheVVQc3owVDFFVk4yMUxYZHgw?=
 =?utf-8?B?Qy92WjlLZ3FPRFhud2ZzUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VjdxdUcvMk1LVnIwNTI3eHBwM25RTmVjNWNYcWk5Zy91eDFwdGg4ckVNOW9E?=
 =?utf-8?B?dWh5eWVlbDlMQ0MyMUhxMGZ5dkpPSkM5Y0NKZmlDZ0gya1hTaHluWG5GNTlG?=
 =?utf-8?B?b0RveVRQWElzL043NEJ2clErUE9lbCt5Y0U5ZFFjUmNvNFFpUUt1MkRadEF0?=
 =?utf-8?B?ck0vN0grZ1RsRGFkbmpiS3NiUmFSS0I2aDJGTkMwb2o0UGxNU0FPM252dWx4?=
 =?utf-8?B?NzRVMnVNMGNROEVBMytqK1crQkdvUHBLNVkweHRSQUtXTmI1cXRwblZuSmdw?=
 =?utf-8?B?ZkE4MHduZ1M1d090THZlYi9haTR6ckJhUGs5eVR6L0laQjN2dEFFejVjaW9G?=
 =?utf-8?B?M0xzZjZ3NitneE4wM2ExZGhIR0FaZWJ4MnMwS05mT3lDSnpvR3lQZ2xhKzZW?=
 =?utf-8?B?U3B2eXNiZmN1MEJBQmdkK1Y0K2g5ZWh3Uld6Y3VJdkQxU3pHTUV4ME9EVVo4?=
 =?utf-8?B?UndPcVlJVExYU0NiekhGTEM3UkttR3htaWVSRFVoSCtzWUpSeEtQNHF6Rldv?=
 =?utf-8?B?K2hHbEFxOWg0elpzWDhWTW96cW0xZzBUWVRLNnpTekpHdGNjUUtPVGJZVzVR?=
 =?utf-8?B?Qit4N2xKS25aenJDQ0R2Y3ZGUzUrRzc0TUZobEoxQjZCakhXVWV0ZDJiOURo?=
 =?utf-8?B?dUZDTE5ya01KL20xdGFNOU5MWnNSS01UVlprQkZVTzZsb0hzY2VpbEZDUVE1?=
 =?utf-8?B?WVVKVGRBQWpNQmZuWXROall6L2pRVUlsNU9FdnkvQ2ZJZTF1VUR2WTRDdEhp?=
 =?utf-8?B?ay9lZVo4SG5MdWQ0OWFDbmpzamRsekptbW1uOE1EcmhiQmJCUTd5TDlUVlRK?=
 =?utf-8?B?bDJwdGIvUGY3TlpJVHlxaWZNeEdqZW54cy80eWlvWmt5WjQyNXV1N3JqL2pn?=
 =?utf-8?B?eWxwZVNsZUVhTk50V2NZbXAxU3N3WjZYeGZITXpUTW9qRFhrUG1ESmw2Uksx?=
 =?utf-8?B?Qm5ZcXRZVERGTWZOM0czK1Fmb3ZWOVpRZk1SZENtTVZDZ1ArU1JiYzdQSm1l?=
 =?utf-8?B?M3pkaGcyc0gzUnIxQmc0K0NKN3RmbWdKVWVLZ2VhcDR5OS82Q1BGN0lZaG9B?=
 =?utf-8?B?M1lPK3RJQkJNdnl4Zmc5MVAyRFNUbUlCektBRCtKNXdoN2F3U3JMdlJ4RGlq?=
 =?utf-8?B?bFFXODFsTUc3SmlIOWlWM2dIb0IrRlFXVWdLa1ZwUnFVaTF5NkFmeVd3aGxT?=
 =?utf-8?B?eG1pb25QUEFKTi9rTE1VdjVDb0NhY2Y2NmR5N2ptcWFJWWpvZGVGdGh2eTl3?=
 =?utf-8?B?UTFrMXhlaExUa1hsSDk5eVRaTmhmVnJRQXN5eFg3ejhrNnVGY3F6dWdkSzFq?=
 =?utf-8?B?YVFDN0t1d0Z1MGJOUTJBYjcyTHVFTVk2WEhOeEV5QytkQTc0MitRT3lTQ2hn?=
 =?utf-8?B?MWVGQ09VTE9ZaXJWWktGYnFTd2QzRndVZnZiR0kycWZJSVJ6c1d4aXdLN0xD?=
 =?utf-8?B?RlhuZzRmWVZEZmJVajJoVWpzSmZsNm5qekdGZHhMVFE2ejFja0xRc2FxcUFV?=
 =?utf-8?B?RUI0Syt2ZjBpVWRmbTF2NVRaL1lzc0diK1lmS0ppaTVCWC9zSlMxbnByaTc0?=
 =?utf-8?B?QlFUVGtReWxTQzVOWkFHYjYydGVhMFJleDNiUUJvKzFXdzVkMUNTSGdtdTJZ?=
 =?utf-8?B?ODBVL2ZFa3VhS3I0NGFvejVyOFJiRk1JZExzSWJ0K0p2VkhPT3hnMVQ2djB1?=
 =?utf-8?B?Tzh4a2tFMVJjR0FEQTUydjNTRzQ0aUgydm1sZWFOMmk2R3VKalRuamY5ZUhv?=
 =?utf-8?B?S3FaQkNJSEh1aHhKT1pIZTBnYjhCT0JEQ2tLVnVXZWY5NmZucW5XYVkxelJB?=
 =?utf-8?B?UG5oWGhJU1JUVHNkM0UxL1N6RFE3TmJnaCtoKzJsT3lFRUhpT0hMWUo3MDVi?=
 =?utf-8?B?NFF6MDhjRHduMlZORFQ0TnR2NFZXVlB1L1pLZjB4YkthdWVRYjRMemNrR2xv?=
 =?utf-8?B?NlNEbDh6blhvbjRIWGZqNXdUWlpISW14ai9pMFovZGJqL3FZRFhmL1prRmNC?=
 =?utf-8?B?V3BsYUoydjQ4azFLTWQ0bEMvT0dKeFFuNmFGMFZ2eW1mZ2k0R1QvUXBLVlJF?=
 =?utf-8?B?NVlRVzA4aDNaT3RQeGtpSjllaEptaWJnakNMdnBsemh1VkxmVnRnNXVnVzQr?=
 =?utf-8?B?eTlqTHpsT1E5NTg0eml3WGoxQzdJVGtNS1k2T1NzM1BSMHNUdHN6ZXZUUE1P?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F757350F162B6A4F9DEF6DCCD4DD8EF6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0NjjpLBGj1vXmDApZP8ft+ghGqRKtaZoTGGIpgeS4mvLPD/wl8X5IeeNvR4DGYsCTWBpdg7JOksGlXGWjTZnQoRx+juo2gubon9g7Ky/Qj4sYQosocaXn9fIz+HDxxAdVjkTSnjhWKqT/P9Ge2VyqG8kDC53ufkQMPX6hVRkpDUqXApBRJET85/7uDgPXpaIV9TK5cIImXi1oMNujH5nGIauzFyC+i67rfDMEp5Hbe0OijznhoZqzIOa2GswsRgPoyow5r0YEx0Ofqa1S3KArRA5Z/F4a9NZ2yaugDb2EvRqWv0YuxgEgAPd7sUpxXXlGCbA72tCcllIxB0RxYZfzKqkowNjeTIocxCrekyRKS+okZoDw6gG20bBl6o0e+48ys90uTenK4BKgM0bEufCPlp87stqfS9nat6cykHjVdpFF5sRAJgzZ47Z2uYdYZZVAtuBxRoXhSH2rcjgwzBPIow3kMxsv4JfZsWmdfNtYsG88HQhOs0cFN3XzqMDXKHbcQKi7bmxq6DwbNGB8FLCHtF8GOMOknJonumGFfCX5V9nmbTdSusGyeeb42sCKLS0aa+r08BS0Eic7N3fK5RB77MjvRtmnoKrA7ABdyfhbTiTyG60N1pD1GIXIa7WDwg23UC9CHVY+WpslVY3pN9YNw==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54aff3ef-47a6-4016-192e-08dc63fbed3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:14:44.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ms8Jkp6N7Vey7r0tP6W20VgZ9uFxYzLEKwi+r375BpSFRZzbde4cy3FjSdSggdv51BeNfP7c60epenk6e8bH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Proofpoint-GUID: 7SJsbtw4rOI5Xsw95dmH7oUnxMh0bWrZ
X-Proofpoint-ORIG-GUID: 7SJsbtw4rOI5Xsw95dmH7oUnxMh0bWrZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404240005

T24gU2F0LCBBcHIgMjAsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IFRoZSBsb2dp
YyBmb3IgcmVxdWVzdGluZyBpbnRlcnJ1cHRzIGlzIGR1cGxpY2F0ZWQgZm9yIGVhY2ggaW50ZXJy
dXB0LiBJbg0KPiB0aGUgdXBjb21pbmcgcGF0Y2hlcyB0aGF0IGludHJvZHVjZXMgc3VwcG9ydCBm
b3IgbXVsdGlwb3J0LCBpdCB3b3VsZCBiZQ0KPiBiZXR0ZXIgdG8gY2xlYW4gdXAgdGhlIGR1cGxp
Y2F0aW9uIGJlZm9yZSByZWFkaW5nIG11bGl0cG9ydCByZWxhdGVkDQo+IGludGVycnVwdHMuDQo+
IA0KPiBSZWZhY3RvciBpbnRlcnJ1cHQgc2V0dXAgY2FsbCBieSBhZGRpbmcgYSBuZXcgaGVscGVy
IGZ1bmN0aW9uIGZvcg0KPiByZXF1ZXN0aW5nIHRoZSB3YWtldXAgaW50ZXJydXB0cy4gVG8gc2lt
cGxpZnkgaW1wbGVtZW50YXRpb24sIG1ha2UNCj4gdGhlIGRpc3BsYXkgbmFtZSBzYW1lIGFzIHRo
ZSBpbnRlcnJ1cHQgbmFtZSBleHBlY3RlZCBpbiBEZXZpY2UgdHJlZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1cmFAcXVpY2luYy5jb20+DQo+IFJl
dmlld2VkLWJ5OiBCam9ybiBBbmRlcnNzb24gPHF1aWNfYmpvcmFuZGVAcXVpY2luYy5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYyB8IDUzICsrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDI0IGluc2VydGlvbnMo
KyksIDI5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMv
ZHdjMy1xY29tLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jDQo+IGluZGV4IGY2YjJm
YWI0OWQ1ZS4uY2FlNWRhYjhmY2ZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3
YzMtcWNvbS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1xY29tLmMNCj4gQEAgLTUw
MSw2ICs1MDEsMjIgQEAgc3RhdGljIHZvaWQgZHdjM19xY29tX3NlbGVjdF91dG1pX2NsayhzdHJ1
Y3QgZHdjM19xY29tICpxY29tKQ0KPiAgCQkJICBQSVBFX1VUTUlfQ0xLX0RJUyk7DQo+ICB9DQo+
ICANCj4gK3N0YXRpYyBpbnQgZHdjM19xY29tX3JlcXVlc3RfaXJxKHN0cnVjdCBkd2MzX3Fjb20g
KnFjb20sIGludCBpcnEsDQo+ICsJCQkJIGNvbnN0IGNoYXIgKm5hbWUpDQo+ICt7DQo+ICsJaW50
IHJldDsNCj4gKw0KPiArCS8qIEtlZXAgd2FrZXVwIGludGVycnVwdHMgZGlzYWJsZWQgdW50aWwg
c3VzcGVuZCAqLw0KPiArCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNvbS0+ZGV2
LCBpcnEsIE5VTEwsDQo+ICsJCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLA0KPiArCQkJCQlJUlFG
X09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwNCj4gKwkJCQkJbmFtZSwgcWNvbSk7DQo+ICsJaWYg
KHJldCkNCj4gKwkJZGV2X2VycihxY29tLT5kZXYsICJmYWlsZWQgdG8gcmVxdWVzdCBpcnEgJXM6
ICVkXG4iLCBuYW1lLCByZXQpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAg
c3RhdGljIGludCBkd2MzX3Fjb21fc2V0dXBfaXJxKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfcWNvbSAqcWNvbSA9IHBsYXRmb3JtX2dldF9kcnZk
YXRhKHBkZXYpOw0KPiBAQCAtNTA5LDU0ICs1MjUsMzMgQEAgc3RhdGljIGludCBkd2MzX3Fjb21f
c2V0dXBfaXJxKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlpcnEgPSBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZV9vcHRpb25hbChwZGV2LCAicXVzYjJfcGh5Iik7DQo+ICAJ
aWYgKGlycSA+IDApIHsNCj4gLQkJLyogS2VlcCB3YWtldXAgaW50ZXJydXB0cyBkaXNhYmxlZCB1
bnRpbCBzdXNwZW5kICovDQo+IC0JCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEocWNv
bS0+ZGV2LCBpcnEsIE5VTEwsDQo+IC0JCQkJCXFjb21fZHdjM19yZXN1bWVfaXJxLA0KPiAtCQkJ
CQlJUlFGX09ORVNIT1QgfCBJUlFGX05PX0FVVE9FTiwNCj4gLQkJCQkJInFjb21fZHdjMyBRVVNC
MiIsIHFjb20pOw0KPiAtCQlpZiAocmV0KSB7DQo+IC0JCQlkZXZfZXJyKHFjb20tPmRldiwgInF1
c2IyX3BoeV9pcnEgZmFpbGVkOiAlZFxuIiwgcmV0KTsNCj4gKwkJcmV0ID0gZHdjM19xY29tX3Jl
cXVlc3RfaXJxKHFjb20sIGlycSwgInF1c2IyX3BoeSIpOw0KPiArCQlpZiAocmV0KQ0KPiAgCQkJ
cmV0dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29tLT5xdXNiMl9waHlfaXJxID0gaXJxOw0KPiAg
CX0NCj4gIA0KPiAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYs
ICJkcF9oc19waHlfaXJxIik7DQo+ICAJaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0gZGV2bV9y
ZXF1ZXN0X3RocmVhZGVkX2lycShxY29tLT5kZXYsIGlycSwgTlVMTCwNCj4gLQkJCQkJcWNvbV9k
d2MzX3Jlc3VtZV9pcnEsDQo+IC0JCQkJCUlSUUZfT05FU0hPVCB8IElSUUZfTk9fQVVUT0VOLA0K
PiAtCQkJCQkicWNvbV9kd2MzIERQX0hTIiwgcWNvbSk7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJ
CWRldl9lcnIocWNvbS0+ZGV2LCAiZHBfaHNfcGh5X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0K
PiArCQlyZXQgPSBkd2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCAiZHBfaHNfcGh5X2ly
cSIpOw0KPiArCQlpZiAocmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29t
LT5kcF9oc19waHlfaXJxID0gaXJxOw0KPiAgCX0NCj4gIA0KPiAgCWlycSA9IHBsYXRmb3JtX2dl
dF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsICJkbV9oc19waHlfaXJxIik7DQo+ICAJaWYgKGly
cSA+IDApIHsNCj4gLQkJcmV0ID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2lycShxY29tLT5kZXYs
IGlycSwgTlVMTCwNCj4gLQkJCQkJcWNvbV9kd2MzX3Jlc3VtZV9pcnEsDQo+IC0JCQkJCUlSUUZf
T05FU0hPVCB8IElSUUZfTk9fQVVUT0VOLA0KPiAtCQkJCQkicWNvbV9kd2MzIERNX0hTIiwgcWNv
bSk7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIocWNvbS0+ZGV2LCAiZG1faHNfcGh5
X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KPiArCQlyZXQgPSBkd2MzX3Fjb21fcmVxdWVzdF9p
cnEocWNvbSwgaXJxLCAiZG1faHNfcGh5X2lycSIpOw0KPiArCQlpZiAocmV0KQ0KPiAgCQkJcmV0
dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29tLT5kbV9oc19waHlfaXJxID0gaXJxOw0KPiAgCX0N
Cj4gIA0KPiAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lX29wdGlvbmFsKHBkZXYsICJz
c19waHlfaXJxIik7DQo+ICAJaWYgKGlycSA+IDApIHsNCj4gLQkJcmV0ID0gZGV2bV9yZXF1ZXN0
X3RocmVhZGVkX2lycShxY29tLT5kZXYsIGlycSwgTlVMTCwNCj4gLQkJCQkJcWNvbV9kd2MzX3Jl
c3VtZV9pcnEsDQo+IC0JCQkJCUlSUUZfT05FU0hPVCB8IElSUUZfTk9fQVVUT0VOLA0KPiAtCQkJ
CQkicWNvbV9kd2MzIFNTIiwgcWNvbSk7DQo+IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIo
cWNvbS0+ZGV2LCAic3NfcGh5X2lycSBmYWlsZWQ6ICVkXG4iLCByZXQpOw0KPiArCQlyZXQgPSBk
d2MzX3Fjb21fcmVxdWVzdF9pcnEocWNvbSwgaXJxLCAic3NfcGh5X2lycSIpOw0KPiArCQlpZiAo
cmV0KQ0KPiAgCQkJcmV0dXJuIHJldDsNCj4gLQkJfQ0KPiAgCQlxY29tLT5zc19waHlfaXJxID0g
aXJxOw0KPiAgCX0NCj4gIA0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTogVGhpbmgg
Tmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA==

