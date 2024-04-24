Return-Path: <linux-kernel+bounces-156078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDA8AFD9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478AC1C224A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B463A5;
	Wed, 24 Apr 2024 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DMZUyFk8";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Jhog0YhC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jXibJ9xe"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66336568A;
	Wed, 24 Apr 2024 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921156; cv=fail; b=VW5Ei7k1DW8Dc3YHjWH+LngEWxyXEZFHuiAFCCiih21LxbGGgNc4iNg6gM+dv6jC+kDBRWr1mVnzqqO/ONVUCcHNKnvfcQ7WW0Ic/8yaAL+RktOtv9o+1f0AYuACGFBlZaiWtkbdFBu1ZaKAsSBz0o1yKMewpA/t5iz4ACGIAPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921156; c=relaxed/simple;
	bh=56XOJhCXe0H+33VH7mQwy0ClK7q5KIgzBeA/puvK7o8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qhdYgiBPna5pjjzbYd0Gv/EM90cna7Z4g3HgYeaUnQI5jyYMsoxuZAZMp8c8ovxmSxbE3UP2ZL/CiiL+GJgW6Q+kQs/A5SZqBUza4d04GSMDRLkg/ewt1g15mjQxfgKMRut7+5u7XWTXc+OjgdjI4QkekLbim1oh0Vwi3OgECw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=DMZUyFk8; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=Jhog0YhC; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jXibJ9xe reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O0mh8O015095;
	Tue, 23 Apr 2024 18:12:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=56XOJhCXe0H+33VH7mQwy0ClK7q5KIgzBeA/puvK7o8=; b=
	DMZUyFk8dXC4RLyhR3UzwZd1sqTcmbk5Kkq5GVU+G0c0tdg0cJ0AWW41Bx9zZqE8
	nN1N3nZ+o99amtt0gdnd3Hq/egYLVeSjXbhocNz5KlngxJudOkXprmfU5Nghzi1E
	eC9YAiVEhHqN/yKZed0jy2DQHj1eeBrwVW2OiaA9D9F1Fyyt+Oei+r1dEj0O0ge1
	5O4gBZJs0wDNvPDUH8od1VccT3QgBTgR3ezzxtlXUADtCox9kk3b6a99Td/+mmz4
	SK5tCXswXsfcYqtHaDjlE6+fEdwjVHRAhVZWxL9qhWjSwCQ5gUG8WwuZfmX3jDwo
	RvAZAfTG3MdV4+P7GdvSuA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xpf6yadpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713921134; bh=56XOJhCXe0H+33VH7mQwy0ClK7q5KIgzBeA/puvK7o8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Jhog0YhCmkOOacArhbySydGF5ZVasLSh+3NxJMzw4lCLSeb2TZf7DXdr4hGrdlSHH
	 2MYLi0V40IiPVfusSludVd5YIcv4w2V08iqAi23PT1FYaHdVYacVP0l6XIZTwcBSw7
	 +DQz5td8zgq8d8pQI2t+e2CcnDdvD6AYvituBxyogMaTDFevbkCfv0F/HjSnuGEZU9
	 xPDjVzgFfRbBGCxPhgss2pokv7XLDC2U4bnYV5vyXoMDggxQZ6EvpOGJaak7n8+L2L
	 qRehMVyILS+1jWm/TiTe4guviSS9Q+ZQbnPTRjZmHbX9bLLH/V6xzszap6UuynHQQ+
	 YJ7qW9+7qgO7w==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3876A40352;
	Wed, 24 Apr 2024 01:12:14 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id D53FFA0096;
	Wed, 24 Apr 2024 01:12:13 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=jXibJ9xe;
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0154E404D0;
	Wed, 24 Apr 2024 01:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gjp3L+mQW4AIe8hSJk7To1YrStyf1FsJoO+Iv1zs6I23/joTC3l7C4FlrUF3J/fhzMfmccofhlRDYTGqfXstsirNq/CDjl2SpBLcOzeUAxlK11C07DddDYTOoVUHaAlzVs5gyg4UrZUOgroFn1EV0ePJXy+FIqRM/IN7kvhJnvm7x6wSluBfNgKeQN1QgDEa2WuVSz5E5S49O6Uo3gd9IRNvHjs1B+6X1PG4aOoSnyegihjjx/Eflx4+khvKiVxU5AZFqN/rc/Xwf2R1o5DEFc9Fq/y090QCMN2zE61eGyxAZOREtztMPI++GGnau7C8MxCCsF8aBdt/Uv957Xbr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56XOJhCXe0H+33VH7mQwy0ClK7q5KIgzBeA/puvK7o8=;
 b=YNL8hKjLyZ/6ecwZsLjWRkP8WvZkrPTCNzrhtyWENdJrJG5ZbhNeZ3y/Y5jFkyylyIGUDNANudDnT0wH2OdojmaWVjKhzyRTkQ+poi6rJo+JAgRYUTS/bq0VWGGtk5InwnQpoE/A1FJfnU5upFQ4+bylE759iP3bs4zbfFMXK7vs2RYigN6PonyowJRQpIcbZRJxRQsrFHo4hL1jWzKq3Azo7029p9RwtaYqCH/xtqUXu6W4+40fF7iHVpjReCigjMGmLOF3imAEgGY7Dman5OnGptwUvfVebJ40tSxwO/Sm6+96KeFCYHMelrRfmrZqE8lAU7dlWANCijAiG4yTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56XOJhCXe0H+33VH7mQwy0ClK7q5KIgzBeA/puvK7o8=;
 b=jXibJ9xezcLXBVadWMyW3ZfcCn8rxR8FG9xUXqphhKOxJSUqM5IEw6YhNtk6nql66oLMgE448FKNUkDlPhMZ06bkRciD2aVLFsLqalUkiF1fZ446aMb7FMJR111yDCA1ZBKVGxqZNUhTEKPS2bjF74kPtIzgGXYxN913xd4FpUk=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 01:12:09 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 01:12:09 +0000
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
Subject: Re: [PATCH v21 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Topic: [PATCH v21 2/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Thread-Index: AQHakt4ySQt40g0db0mKaLVZc7V/W7F2owWA
Date: Wed, 24 Apr 2024 01:11:50 +0000
Message-ID: <20240424011147.4fsd2xh3r7ecnre3@synopsys.com>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240420044901.884098-3-quic_kriskura@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|PH7PR12MB7163:EE_
x-ms-office365-filtering-correlation-id: dcd565bb-3f1d-4755-9524-08dc63fb8549
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?WkN4MkZNemhnNW1tNlNOWWlXQkEzYmVNV0NnU3NMQ1lqVXBWcVVSd0hJZEJ1?=
 =?utf-8?B?N3dtQlU1OTdOVTRrcWdlTElYeU9UYkdqc3MzRXBVNWFaWkM5ZVRsM0p3S2Jm?=
 =?utf-8?B?L2ZnWXE0TkFPTVc0bjBwU0h5R3hPcE5GNnR2MlBUVFVZSE5mODBDTHIzT2E3?=
 =?utf-8?B?dGMvMFFoT2pqQzZqQzdybVRXQjdkRE1MQVlsUUdZV0lkV1RYbWRSdzBYR05B?=
 =?utf-8?B?Z1hnS3oya0kxSnNwZ2U0RHR2L01IckpCSkR6Vlg4L3MyOWgxbTZRcFgybjZW?=
 =?utf-8?B?dXpqRVh2bzZZNnRlR2ZtTXhIQWNkTjdSRnpVaUk5NTJXRUY0b29pazV1NllK?=
 =?utf-8?B?OTBzeHRIS3FJRjhIOEVOUjhUYmJsUWtHdTN5WDBablNUSWNuMEhKdkxZampK?=
 =?utf-8?B?ZjI5VzI0a3hDNVZMcjFiUEpwWTFaRHFHUDBpV1U1UXROVC9BemhVTm1Nb0lM?=
 =?utf-8?B?TmpOQnI3V1dzZzNtSE9ncW1OMXRnejY3MDF4QnJBRXQvaFZvOHY4ZEhUSXFx?=
 =?utf-8?B?ckJRenVPQmErMndRQnhWYzFFcU8wZk9hS2p4dG1rS0lkQ1hCN2l5MTROa1Bi?=
 =?utf-8?B?Y3VGTVdabmRZeVVCTTdzTTh2bUNyTC94NHZNRXdyNXBNbTA3TlFlWUlvZ3Ft?=
 =?utf-8?B?MHY5Nm1ZN1lNUmdsdzFkZ3FSZThUMkNyeVlZNUN4cEtrejQ5RHRha1ZoNlNH?=
 =?utf-8?B?UzFxdGZMSS9yRWQ2OW5jSFowTXN6ZzZHL1VQeDRodzlYS0dOZEllTWpGYU5s?=
 =?utf-8?B?OW5CN3c2YWw5d0hyVEM5OEtkR21TNzRXWVh6Zjc2aGU3TnZmNlNPR1d2TWZ6?=
 =?utf-8?B?QWRxVEhkQ0t4c0hIUnNQZWpWQW1ib2RXUi9XSUJxYWNGODNHRnI3WUxTTFQ2?=
 =?utf-8?B?SjlhcEY2MUQ5S0NEUjFwTVhRTkZ2NTNLMXdFYmg4c3BIQlBONnNqZTNkMWUx?=
 =?utf-8?B?aFFGZWQ3NDBkUUpoM2FEUWFHWHNWQ3dmRHdqd0d4Tnk1eHJFM0JDK2wvaVVj?=
 =?utf-8?B?MFRKL1Riem56UGlIdXl4d2dXUUk3QXZuT0dGSDVGVFo3QnVzT3ZVZ3BLV3pq?=
 =?utf-8?B?R2xnODFsanF4U2RtMVlVVEFtTkkxY3lGOWZpdmlJM1NKMTBEOEpQUGRnbit4?=
 =?utf-8?B?aHBtekNNZFRybFY3dlMrOHpDK3EwYVJHVG5GTzRZUitESDQ5VkczQjZKRGYy?=
 =?utf-8?B?MlM2bDdxNkoxWWNXNTFjZEYyejNUeGE1SFp5YkEwblRrMzgrNVd5YWIrdmdQ?=
 =?utf-8?B?ZUUvbEFYWUVQK1dBUkpaL1RTQXp0eGF6dnRuWEZqSElvMVZvc21aeDQ0UlV0?=
 =?utf-8?B?aWx5UHdwSzlzT2tWNmRGbXZjNnpZbWgxQkRIV1lQRzVFbUVOVlA3TGJjMFE3?=
 =?utf-8?B?VlFxY1ZBYks5STFaVytQaW1ycHl3dVdjS2YwVkNNcWRNWDBZdkRiMkl0TG8z?=
 =?utf-8?B?QnNHZW9nRUVET2FubmIrbW5lQTFLbHVaUGtTSXFYc0hlZXZ0WjR3SDZFdWpa?=
 =?utf-8?B?OVE0eWZMTnNtVGpDeU12RWxvZGYzaXE3ZzM5YVdqeEpINmtTUzVNWG5CUkpS?=
 =?utf-8?B?YUl3TUhuZ1pwbzQvSHppU1ZjQmFJYm5NNkx4THRNMVMzZHBZenEwMFphb2g0?=
 =?utf-8?B?VThGbXlXQjVMR3cvWW9TYWxpNitIbGFkNFdXek5FcWIxTnR2RlZQNDJxd0VG?=
 =?utf-8?B?Y0tJaXN0MytxUXBFVDFXajhYOGdtbVEwNmNqS1UrbW5PL2VrTlBlR2VlZFUv?=
 =?utf-8?B?ejAzQzBRK09wVzBZaS9YbzlMWlpaSDNsNlNTY0FIdDBOUktTeUlCUkVEVGt0?=
 =?utf-8?B?TGgzWTV6T3cxZXZkWXU3Zz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bGtORitDOGV6VmtDdk1iWGltY2oxRDFuKzFkQWhENjBtRDYwVjRSQXgvOWlO?=
 =?utf-8?B?anJrYTZFVlowbE4vdWVxYWc0MDFPMm9yMHc3SDVkVzNHTm50bFlSdkZ2MjAr?=
 =?utf-8?B?Sm02RlBrVmd0cWQrb2RnVG0yTTZ6M3ZwWldQblBsZXlWWDlXVUdUNGFucG5T?=
 =?utf-8?B?R0tLeWduK0NreitSS3crNDVsUXNpOThKeU1UbDE3MkZPMHdaazJIVysyK2pL?=
 =?utf-8?B?QjViblZ6QkJGdXE2Y0taWCtpbEVibWlqeVNKdlBkYkd0azRmU0lyMlN5TWFy?=
 =?utf-8?B?SFhyZXNHMzN1VFRPTStTL1pBaFhQWWY5QnNkTjdDNmdKNC9oWnZwREhvWkJC?=
 =?utf-8?B?YUdSYzBhYjNwWjU5OWNhd2NWY2JuVDFZcHdYY1VRQnRHM1RsMVFhWlVFaFdy?=
 =?utf-8?B?eDJNOHljc1RHbTBsbmxJOHZpZyt0Vm9BQ2dkK0JwNWNyL2hFZnk0RU0wQVM5?=
 =?utf-8?B?U24xamhZeUNrNEtvL1pER3hYc0R1aC8wRHh5cWxHbzAyZkJVTTRURkxJTEw2?=
 =?utf-8?B?d1ovT1ZrRGsxRlZycmcxU0t3QUZudHU3OERHejRLNTNGV3NYRWxQcm5WOTFj?=
 =?utf-8?B?UEl4WUJhaWhTYmFwaC8wK1hSSitSMXpHcGFwUWZtSUZ3QUZvMjZXTDYrK0pz?=
 =?utf-8?B?TGVqeVNvRGk4eUEzTzFDNElOYmNTVU9yeVpBVmk4eHVPSFBpMVlyc2MxNTBF?=
 =?utf-8?B?bFFzOTlMcnRBVTMzellOQkpEYXVaQWszWVZsSnlSVnFtb3hHdjZUTnJxUDV3?=
 =?utf-8?B?TlhQN2FGNDFObTNOSlJPMUJzSUhDMlpia3hucFJFbG9ETVRYaklzVHJTQWNm?=
 =?utf-8?B?RnkzUURCOC9PSVhlb01teDhyUTlKUURDZjNEaTI3RlhXTU0wdVAyRnE2c09L?=
 =?utf-8?B?SkFraDRlVGtBT2pWczZxb25NVm5BWHZxWm5hWkRCOCtjdFgzUGR1ajE5WFc2?=
 =?utf-8?B?S2xZVVhQZmVESFEza0psb1dBUnNGNjVoOFNtUVM0Y2tITXB2S0JSdGZ0RUdP?=
 =?utf-8?B?MVZFVXBrSmVwUkk2QnVSYWVXcTZVSS96eGgwYmc4eWVqTmJBbWlMVVpjMU5F?=
 =?utf-8?B?SW12dzJhM09ZVmFPWjVKT1JZTXlzMFhqV3gvOFErc2lvZURhdkVnaUdLV25u?=
 =?utf-8?B?Q2dQVms1K0ZrUFExazRyMm1iY1paeDc2aTd1UWF2cmltd0VhUkh5MGxlY1pG?=
 =?utf-8?B?SjJMWkUxZTV0ZjVIaHdBR0MycHBCZjJTeXJTVnZqQjRoM1ZiaE1WM0VRb2I1?=
 =?utf-8?B?S0xhMittRUkxejRQQTV2aDlsbzRDbmI2bmlYVHBHUUNXV3I2MUV4WlhBMUhR?=
 =?utf-8?B?aXhvUmVYWnYzWEdLclZvcGJrR3cxNEFocFJiM2NVelZQTnFRZEgvNHF3S0lG?=
 =?utf-8?B?S2xha3dSWS85eDZGTndRKzRnUjJwZHdiNm82WnFsZDBkVTQxcWxNbTBCdTJD?=
 =?utf-8?B?UVNwdjg2L2tMS1hjL3F0QnRCakFIYkp5SklIb1NDRHpuc1gvLzZOcU4rb3BW?=
 =?utf-8?B?ZnBOa01IeFc5WStDbndPYTFIRkZ0OERUL1YwdXhtZFliR2p6SCtNVWN5V1pP?=
 =?utf-8?B?TXVUUWE4TFFEL3hucXNheHd1Nk1EM3BMT29LNFhkems3cmRsYmJiQVRrYzJS?=
 =?utf-8?B?bWJyVEsrVmxQSFIzM0tFY1d3am1iL3h4SFM0WGZIRzVpcWMydnhtMjlFZVFj?=
 =?utf-8?B?Ukh1YXdLaXBFV0tFQXBQUmI1WURZbngwaFVkY1k0UWcybEI4ZFJoQzYyV0FR?=
 =?utf-8?B?LzUxZWxFb2x3TkpQNEJYTkMwZXZEMWlKSExlcERjdUhYektTdk1kU1pZZDAy?=
 =?utf-8?B?MlI4emp2QzJBSjNtQW5ZNDRTZkErWFU4T1h0ME5IZk84TzQ0WlVaeld1TUdC?=
 =?utf-8?B?cnZnMGdWYndqOXdsYzVBSEE2MGxKUDdSTzAzaWxyNkVEWGYraGlSZ2xuK1I2?=
 =?utf-8?B?Rms3M21KbEhRNGdtbDBTdXVRZW9pZzJCSmFIb1B2K1d4dnViMHFReHJISDFL?=
 =?utf-8?B?NEs5Njh4RjVaRzdLV242NjBweVlOdlFYRDFwQ3EyNURKZmFSbkk1UlJuUStm?=
 =?utf-8?B?Ukc0UlFXTXBHcVZUYmZIZXVxdWZodWd1aTl5NzdFNmhVdWdTNXRaRjA5anZw?=
 =?utf-8?B?SEV5NXRmUW90VWtyMlVlQ1U3cDdzUXIzUUhnRnJUUytYZW5qQVZjZmZodnlK?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4310B2B812470429F155C1AFCEDEE54@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PmkLql2rU7+twlwAkCxyaxwxQVBX8YLPNVvDA80T2scyPisvJnVKKbWQqsjlRr5pDsvwE0tI7x5DMgelmQybtza4g/E/xvRyO4bwJbZtXeNdb7Vq8z9RUjiFJWirV6y7my4IkzUhbv7/3ABWddAzekHU8wwdGgV2a3/i/Z79QJ/kRLWytKpAq5vkptmAtc+c8Mk3KX87P8BkpIj7jQOcrkUwberm0/vtp+m3zHGQImaA0TlsxNJai4A/BHB483054h69aHtLrWU8cThLMm91dZ808+6zCRnYnkVEP9hxg57TX7TFS8P3BJ1bq5fEmGrqtXpzI9bIJAsb3Nxmb9a8tl4WzDxE7s0/EA2jJZzVvpBN0ISF83epFrww88VxI/X7Lini7OF9BLtfNSs9HRodFxEcZwl44lpH7806/C4YCNNU03I1eIEDgaKlk1xCQsqLfGuv3C6w4+4qZAUe3YfKGYJ12P1BgR3oH2tN8+2o7X8Hg0Au/sd53jh0ySqfMklqr6vGHZ6kRZSK/mA+PqQc7xsUb/1Epm7iYo72d/RHOw9OnhpVI56IK0AQ3gumd/0afiuKkiuEdUjoVExLlG+7x8LZOXkCR0xiGWi9vuhrmM0oYshsEfM3PGJCEDOfkSPnjEEcN3juTB6PyDyXsUsK9A==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd565bb-3f1d-4755-9524-08dc63fb8549
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 01:11:50.3843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ijSUuEpFrsPkxZpVXWhYjTm7R8jYK4xswwNa35Epl+mt1RlvqNAqEz8CmLz7/UCmwXEA1EXRqJ/vfxuibNZFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
X-Proofpoint-GUID: cQArown5HOSK5jhxW4v_LzEFDtyjwtuj
X-Proofpoint-ORIG-GUID: cQArown5HOSK5jhxW4v_LzEFDtyjwtuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_20,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240005

T24gU2F0LCBBcHIgMjAsIDIwMjQsIEtyaXNobmEgS3VyYXBhdGkgd3JvdGU6DQo+IEFsbCBEV0Mz
IE11bHRpIFBvcnQgY29udHJvbGxlcnMgdGhhdCBleGlzdCB0b2RheSBvbmx5IHN1cHBvcnQgaG9z
dCBtb2RlLg0KPiBUZW1wb3JhcmlseSBtYXAgWEhDSSBhZGRyZXNzIHNwYWNlIGZvciBob3N0LW9u
bHkgY29udHJvbGxlcnMgYW5kIHBhcnNlDQo+IFhIQ0kgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzIHJl
Z2lzdGVycyB0byByZWFkIG51bWJlciBvZiB1c2IyIHBvcnRzIGFuZA0KPiB1c2IzIHBvcnRzIHBy
ZXNlbnQgb24gbXVsdGlwb3J0IGNvbnRyb2xsZXIuIEVhY2ggVVNCIFBvcnQgaXMgYXQgbGVhc3Qg
SFMNCj4gY2FwYWJsZS4NCj4gDQo+IFRoZSBwb3J0IGluZm8gZm9yIHVzYjIgYW5kIHVzYjMgcGh5
IGFyZSBpZGVudGlmaWVkIGFzIG51bV91c2IyX3BvcnRzDQo+IGFuZCBudW1fdXNiM19wb3J0cyBh
bmQgdGhlc2UgYXJlIHVzZWQgYXMgaXRlcmF0b3JzIGZvciBwaHkgb3BlcmF0aW9ucw0KPiBhbmQg
Zm9yIG1vZGlmeWluZyBHVVNCMlBIWUNGRy8gR1VTQjNQSVBFQ1RMIHJlZ2lzdGVycyBhY2NvcmRp
bmdseS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyaXNobmEgS3VyYXBhdGkgPHF1aWNfa3Jpc2t1
cmFAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5OiBCam9ybiBBbmRlcnNzb24gPHF1aWNfYmpv
cmFuZGVAcXVpY2luYy5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy91
c2IvZHdjMy9jb3JlLmggfCAgNSArKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlv
bnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+IGluZGV4IDYzNzE5NGFmNTA2Zi4uMzhmY2Y1MzAzMzJmIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KPiBAQCAtMzksNiArMzksNyBAQA0KPiAgI2luY2x1ZGUgImlvLmgiDQo+
ICANCj4gICNpbmNsdWRlICJkZWJ1Zy5oIg0KPiArI2luY2x1ZGUgIi4uL2hvc3QveGhjaS1leHQt
Y2Fwcy5oIg0KPiAgDQo+ICAjZGVmaW5lIERXQzNfREVGQVVMVF9BVVRPU1VTUEVORF9ERUxBWQk1
MDAwIC8qIG1zICovDQo+ICANCj4gQEAgLTE4ODQsMTAgKzE4ODUsNTYgQEAgc3RhdGljIGludCBk
d2MzX2dldF9jbG9ja3Moc3RydWN0IGR3YzMgKmR3YykNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4g
IA0KPiArc3RhdGljIGludCBkd2MzX2dldF9udW1fcG9ydHMoc3RydWN0IGR3YzMgKmR3YykNCj4g
K3sNCj4gKwl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ICsJdTggbWFqb3JfcmV2aXNpb247DQo+ICsJ
dTMyIG9mZnNldDsNCj4gKwl1MzIgdmFsOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBSZW1hcCB4SENJ
IGFkZHJlc3Mgc3BhY2UgdG8gYWNjZXNzIFhIQ0kgZXh0IGNhcCByZWdzIHNpbmNlIGl0IGlzDQo+
ICsJICogbmVlZGVkIHRvIGdldCBpbmZvcm1hdGlvbiBvbiBudW1iZXIgb2YgcG9ydHMgcHJlc2Vu
dC4NCj4gKwkgKi8NCj4gKwliYXNlID0gaW9yZW1hcChkd2MtPnhoY2lfcmVzb3VyY2VzWzBdLnN0
YXJ0LA0KPiArCQkgICAgICAgcmVzb3VyY2Vfc2l6ZSgmZHdjLT54aGNpX3Jlc291cmNlc1swXSkp
Ow0KPiArCWlmICghYmFzZSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4gKwlvZmZzZXQg
PSAwOw0KPiArCWRvIHsNCj4gKwkJb2Zmc2V0ID0geGhjaV9maW5kX25leHRfZXh0X2NhcChiYXNl
LCBvZmZzZXQsDQo+ICsJCQkJCQlYSENJX0VYVF9DQVBTX1BST1RPQ09MKTsNCj4gKwkJaWYgKCFv
ZmZzZXQpDQo+ICsJCQlicmVhazsNCj4gKw0KPiArCQl2YWwgPSByZWFkbChiYXNlICsgb2Zmc2V0
KTsNCj4gKwkJbWFqb3JfcmV2aXNpb24gPSBYSENJX0VYVF9QT1JUX01BSk9SKHZhbCk7DQo+ICsN
Cj4gKwkJdmFsID0gcmVhZGwoYmFzZSArIG9mZnNldCArIDB4MDgpOw0KPiArCQlpZiAobWFqb3Jf
cmV2aXNpb24gPT0gMHgwMykgew0KPiArCQkJZHdjLT5udW1fdXNiM19wb3J0cyArPSBYSENJX0VY
VF9QT1JUX0NPVU5UKHZhbCk7DQo+ICsJCX0gZWxzZSBpZiAobWFqb3JfcmV2aXNpb24gPD0gMHgw
Mikgew0KPiArCQkJZHdjLT5udW1fdXNiMl9wb3J0cyArPSBYSENJX0VYVF9QT1JUX0NPVU5UKHZh
bCk7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlkZXZfd2Fybihkd2MtPmRldiwgInVucmVjb2duaXpl
ZCBwb3J0IG1ham9yIHJldmlzaW9uICVkXG4iLA0KPiArCQkJCSBtYWpvcl9yZXZpc2lvbik7DQo+
ICsJCX0NCj4gKwl9IHdoaWxlICgxKTsNCj4gKw0KPiArCWRldl9kYmcoZHdjLT5kZXYsICJocy1w
b3J0czogJXUgc3MtcG9ydHM6ICV1XG4iLA0KPiArCQlkd2MtPm51bV91c2IyX3BvcnRzLCBkd2Mt
Pm51bV91c2IzX3BvcnRzKTsNCj4gKw0KPiArCWlvdW5tYXAoYmFzZSk7DQo+ICsNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGRldmljZQkJKmRldiA9ICZwZGV2LT5k
ZXY7DQo+ICAJc3RydWN0IHJlc291cmNlCQkqcmVzLCBkd2NfcmVzOw0KPiArCXVuc2lnbmVkIGlu
dAkJaHdfbW9kZTsNCj4gIAl2b2lkIF9faW9tZW0JCSpyZWdzOw0KPiAgCXN0cnVjdCBkd2MzCQkq
ZHdjOw0KPiAgCWludAkJCXJldDsNCj4gQEAgLTE5NzEsNiArMjAxOCwyMCBAQCBzdGF0aWMgaW50
IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCWdvdG8gZXJy
X2Rpc2FibGVfY2xrczsNCj4gIAl9DQo+ICANCj4gKwkvKg0KPiArCSAqIEN1cnJlbnRseSBvbmx5
IERXQzMgY29udHJvbGxlcnMgdGhhdCBhcmUgaG9zdC1vbmx5IGNhcGFibGUNCj4gKwkgKiBjYW4g
aGF2ZSBtb3JlIHRoYW4gb25lIHBvcnQuDQo+ICsJICovDQo+ICsJaHdfbW9kZSA9IERXQzNfR0hX
UEFSQU1TMF9NT0RFKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMwKTsNCj4gKwlpZiAoaHdfbW9kZSA9
PSBEV0MzX0dIV1BBUkFNUzBfTU9ERV9IT1NUKSB7DQo+ICsJCXJldCA9IGR3YzNfZ2V0X251bV9w
b3J0cyhkd2MpOw0KPiArCQlpZiAocmV0KQ0KPiArCQkJZ290byBlcnJfZGlzYWJsZV9jbGtzOw0K
PiArCX0gZWxzZSB7DQo+ICsJCWR3Yy0+bnVtX3VzYjJfcG9ydHMgPSAxOw0KPiArCQlkd2MtPm51
bV91c2IzX3BvcnRzID0gMTsNCj4gKwl9DQo+ICsNCj4gIAlzcGluX2xvY2tfaW5pdCgmZHdjLT5s
b2NrKTsNCj4gIAltdXRleF9pbml0KCZkd2MtPm11dGV4KTsNCj4gIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRl
eCA3ZTgwZGQzZDQ2NmIuLjM0MWU0YzczY2IyZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTEwMzks
NiArMTAzOSw4IEBAIHN0cnVjdCBkd2MzX3NjcmF0Y2hwYWRfYXJyYXkgew0KPiAgICogQHVzYjNf
cGh5OiBwb2ludGVyIHRvIFVTQjMgUEhZDQo+ICAgKiBAdXNiMl9nZW5lcmljX3BoeTogcG9pbnRl
ciB0byBVU0IyIFBIWQ0KPiAgICogQHVzYjNfZ2VuZXJpY19waHk6IHBvaW50ZXIgdG8gVVNCMyBQ
SFkNCj4gKyAqIEBudW1fdXNiMl9wb3J0czogbnVtYmVyIG9mIFVTQjIgcG9ydHMNCj4gKyAqIEBu
dW1fdXNiM19wb3J0czogbnVtYmVyIG9mIFVTQjMgcG9ydHMNCj4gICAqIEBwaHlzX3JlYWR5OiBm
bGFnIHRvIGluZGljYXRlIHRoYXQgUEhZcyBhcmUgcmVhZHkNCj4gICAqIEB1bHBpOiBwb2ludGVy
IHRvIHVscGkgaW50ZXJmYWNlDQo+ICAgKiBAdWxwaV9yZWFkeTogZmxhZyB0byBpbmRpY2F0ZSB0
aGF0IFVMUEkgaXMgaW5pdGlhbGl6ZWQNCj4gQEAgLTExODcsNiArMTE4OSw5IEBAIHN0cnVjdCBk
d2MzIHsNCj4gIAlzdHJ1Y3QgcGh5CQkqdXNiMl9nZW5lcmljX3BoeTsNCj4gIAlzdHJ1Y3QgcGh5
CQkqdXNiM19nZW5lcmljX3BoeTsNCj4gIA0KPiArCXU4CQkJbnVtX3VzYjJfcG9ydHM7DQo+ICsJ
dTgJCQludW1fdXNiM19wb3J0czsNCj4gKw0KPiAgCWJvb2wJCQlwaHlzX3JlYWR5Ow0KPiAgDQo+
ICAJc3RydWN0IHVscGkJCSp1bHBpOw0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQpBY2tlZC1ieTog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGlu
aA==

