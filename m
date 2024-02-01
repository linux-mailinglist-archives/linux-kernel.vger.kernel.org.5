Return-Path: <linux-kernel+bounces-47500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242CD844EB4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEBEC289868
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE145220;
	Thu,  1 Feb 2024 01:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kZZ/Nafw";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ihRAunXo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UnYSQwKh"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B94403;
	Thu,  1 Feb 2024 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751107; cv=fail; b=er9Ut85SXRYBOx4PwJvKkQIRsNCe/vcgMWcsXDm6aUiV/84hvrZBCqm3W6loXYiXqVzqf5y0sM8MPwsJrGKFtt7hxs9Yv6X6FpAK/EAZRiCl6UmBp6vv+rDE1M/rBsmvn1CvTDTNPzgKgCnHA381VNPBFd6DpXE1ISOyP7b5k/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751107; c=relaxed/simple;
	bh=vzViAykgxECAq2tV2Pfd70uPSD/2bdDV3EnEm60pgcQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S57YsZjVPVZLjtr6B7agaV6mIYQvlZFEzRcyjF5caFxwJozU/ZnO7Uj3DgTIlCk+KUN17gJyZ8VxmdphdXwf91qj/wnj0UnH164CqzUalw4+JYOnalx8Ku+j6M7yJ4MnX81S74moqyN4ZHzS7PXdhE/ELZI6ToYsZc+ACTdqh2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=kZZ/Nafw; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ihRAunXo; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=UnYSQwKh reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40VKLcmE019895;
	Wed, 31 Jan 2024 17:31:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=vzViAykgxECAq2tV2Pfd70uPSD/2bdDV3EnEm60pgcQ=; b=
	kZZ/Nafw0RxpA4SrGoB1A2kpKWdGi3E1o1PWkBX4FfESw8zoluiE1qsIDaoKUijX
	dsp3fgBgASV3O8reFE/7F3ZG+aQ+7kMfwvMDritrC0G4XpJJrxnGvMYWHW8A0pya
	HZAMxvHR03aim3JVt9D952O/pg80uCWEUVKDrCO+jpvrdFxxEUPaXLizx3nYG2sk
	+WxC1CQKG1OS09Ju345HMdrwh3UCZNZ3dSPBeximDYeGcWi2gXHnMV8ZrYJZrI60
	B6Wuyc942tytqpKz7TJ9EV4mas0uJbwdLyiHuPbR6GHaDujAIi6UROJGDedXK2dr
	mDcw4e3IHin4iriYOjEIDw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vw1mwmn7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 17:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1706751087; bh=vzViAykgxECAq2tV2Pfd70uPSD/2bdDV3EnEm60pgcQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ihRAunXojEr8X7+N11JkYGP+B53VCl3OOTbDreL6vhsNaiBBaczGy+v3Fz/rQRSNk
	 +W60fYNoXkewCRSbqAKdvzhcPWky/d5wNpqRKeAO6cmxsU5zRUkDBZPSOS104O6gtq
	 h7Ao8JGdzof1LFhTVxpDo4wBKBxb3V2qpwnEHHBBJ82giOq1dqMvn97ZfZAS86yHv3
	 3kVVJJdAvAVGO9ynpxraJwK5IlGGV8ZYZ2/Hne/ejiAXN7nLN5PLUJ1XMvBGz480mF
	 o2K5kXio8m/RmT0jUdyuOG4I6EitbQc0QX1CIX9QMcitt7DLMDVedMbH4xjgOvsLhX
	 474RgzUnd6ETA==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B0BB44035A;
	Thu,  1 Feb 2024 01:31:26 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id E17C6A007A;
	Thu,  1 Feb 2024 01:31:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=UnYSQwKh;
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id AF917401E1;
	Thu,  1 Feb 2024 01:31:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQsoF4IXxuQCR0c4NkcXWdaoEKl5vB8g407sDXXD2nM4yKfYz+7iGAQRs4h3viawaO8mlgX0Ne63S45YxIAMIkgW7VtQW1PlV4RMahhTEJT+/M30n1Fc46YXlR+xL82osWNIPrbtgUyWVWs7+I06Zud5GwXTGHyWHOSMWupmJSWJ3iYI5/5dwbu49+HyXzP85y4Z2Foq4BAzBYXHt2AHeJb0AD3Y158n0Ht6XSHLe6B58NSS67pXMwG0DUyLK0KJZpPV8llAjcr04mpez34jNAYfpI2o/LbR1rr/KxskVFQ3ZFDhZXcbjYb3wVmjZQdxh2WnvC0biusCr6dxane4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzViAykgxECAq2tV2Pfd70uPSD/2bdDV3EnEm60pgcQ=;
 b=I3I+X7AAfT+5Oti4zdmFjYsYV6GCjqYAlt1EQrswoWCeQ0MX/5exZiCG8ddUcCMErMAmm4fE1+P8reCFl3mORd3SCmHS/6DDgt84g9c5OgDk6i/wmg1xSHcwiKPkNjRf8XzYvqhvZyuxsvRZhS9mEn75eJYTVaOKko7AKddLSD+y9eSPuDE+bCIAzRuQretekvu5DzER9jy9Td/PTc7NkTxo8dV7tURsCMOx9n+6/2VTEf1Pzbd7PIzT2m3BdRFODGRMUUnr2yHvRK+9dN+O6++rGWH+NdZ371STsRIeHVW+yi9+uvk/P2wIcyJTk0m2FjbfqMWMMyXCWkrfxPYDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzViAykgxECAq2tV2Pfd70uPSD/2bdDV3EnEm60pgcQ=;
 b=UnYSQwKhJKKYMaT478Ntb0sr6AFYo4R28O9+gVSEHY4DkuRNmU8ZaB1+Py/zd2vMwloMTcR1LSjAyNBWU1CUr/5+ffFPHq8pGUCuw8yqOXMgGZjdKG14tf4pYBESYnepfmyp27UxBFPpiikdW9LcPAo08TCaLMkRWVnqzBV2dL0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 01:31:19 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 01:31:19 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>,
        "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com"
	<mark.rutland@arm.com>,
        "pku.leo@gmail.com" <pku.leo@gmail.com>,
        "sergei.shtylyov@cogentembedded.com" <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Thread-Topic: [PATCH 1/2] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches
 avoiding vbus glitch
Thread-Index: 
 AQHaSx71MrgOBhNyvEmAO1k3MnME+LDpQYsAgAAC8QCAAANKAIAJcgAAgAAVYYCAAfdLAA==
Date: Thu, 1 Feb 2024 01:31:18 +0000
Message-ID: <20240201013114.pxcplfccnnv4khqq@synopsys.com>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240124-unclothed-dodgy-c78b1fffa752@spud>
 <ZbFNIvEaAJCxC2VB@lizhi-Precision-Tower-5810>
 <20240124-video-lumpiness-178c4e317f5a@spud>
 <20240130181322.GA2079185-robh@kernel.org>
 <ZblOMQLhtD1Y8j5d@lizhi-Precision-Tower-5810>
In-Reply-To: <ZblOMQLhtD1Y8j5d@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|DS0PR12MB8526:EE_
x-ms-office365-filtering-correlation-id: f594679f-b3f9-494c-8449-08dc22c57d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 20/+JaM/04a0xAsKBMkG54EOlM3tRuupitSn6ScYzhHu6RHTxcFGz/egnVPwxjluxHpYGOQ6RHl1xD5pvo4GJTKv1DtUwNDZ8CfHa0g6qxzl4jVpzat46bKrTuALLv9NnjE550AzdklvP6c731pMZ7KNnIfkrykFL3BCABBmtAQRBEjgQs0BSIGWZA9fBBbrTUkpZ140wzrawOLYJsY8P8fv9g3PgoVREZmHXjEgYnbqvKUm/b8ZbvR6wctoR3Tsnz2AVdoJze4/lHv2yBmam8SBZqb3wU22twFbym8U81Juqu2fgQEzZtYtROh/fBKBqmoJiNf/sZiRYyENU2dR5eHLEDUNroiJihJ/NFIqWs00Ab/HliHg4vd1liSnCrkB0yYG7PnQ9w7H+U0g6IaLI8f8XKNFl5CSfqxhDX0VJHoLKutkmAJLocpG1jgmVdSNQixjOZzASWdOl6eRCd1m+QKBP2ad5W72RBRIltE94OyquLjFjSdvFji3CacGrCBSUNRdS9fw+1ggHS1gZwp+RIl2zwY7Whhas4gu5ifc1c4AoZGyPMlsY6QH3kaJTARRCdINzrpjE+TS8a1KSorTDzW8DqwdYrpleETt5rE3pPuR2rZbqrpT/ucjrBiVY5ULOzhzJx6eca/AAG2XMD72UpIGyxfAY0nDS8vP2+e6Up0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(7416002)(5660300002)(2906002)(86362001)(6486002)(38100700002)(478600001)(36756003)(1076003)(26005)(83380400001)(6512007)(6506007)(41300700001)(2616005)(38070700009)(71200400001)(122000001)(316002)(8936002)(8676002)(4326008)(6916009)(66946007)(54906003)(66446008)(66476007)(64756008)(76116006)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MjdqNjNWb2E2SWZyQXB1NGJucTRjVTRNL05FR0tndm5lQUx0Sy9rY3AxN0Rh?=
 =?utf-8?B?NkQ5bkU5cUxYdk1qTk1sa2ZqeXRFT1FvdjJiZmZrTkw2TGpPUEN3QzdqNWZa?=
 =?utf-8?B?NldmbHc4Mm5hWFhSM2REWHJsRnFLYkt4cjBXT09Wa3VTVXN1eDF1Y1NPZ01D?=
 =?utf-8?B?RWpmNnlnaitmdjVpM3RvT1JURG8rNnovS2hBazdoYXJoVlpPNDQrK2Racm1r?=
 =?utf-8?B?ZHdTMTRRNjI2UEhjNThGVlNiRVlhcVdaQVBkb1dMNkw0amo1dlZiT2FHYlB5?=
 =?utf-8?B?SGFtN1lCWURVK3g1L0huYWFUQWtSV0VMQUVvVlBzVFNQVFFpSjFYTmE4TlVu?=
 =?utf-8?B?dDZPQzFmdkh6MGNjVVpBVTFBajdmMG9EV3B0Y3hKY0VZVHVaTzd4Njg2bTZV?=
 =?utf-8?B?RVI1UU52YVg2VFpnUEZnQmFMR1FTc3ZrUUhuNkUydXFTSXVWcFNTY283KzBS?=
 =?utf-8?B?ZFpKenk4YXovZGdUWW9vbXhsZDZRVmFPc2orSU9Gc2ovZk9CODBweG1KTzJM?=
 =?utf-8?B?a1VacmNPa1ZTdEhmRlB5Rzd4bDVISW50dUtsWWdvaTNoOVgrRE9PTzBTZ2N6?=
 =?utf-8?B?S2czV0xDR1hOL0hzR2JUSThIbW00SnRTU2JZam5yblFCQ01xbW4xcVZjUUVl?=
 =?utf-8?B?T0ZqVTFmV0M2dXJrVkEzWlcvVW5nZmRuSDAvOGlFaU9XZy9EOGZiZ3Vsd2JZ?=
 =?utf-8?B?QU1rRHcvZnZHL3lMaUNjNHNvL2VyT2hyanp1dEJ3ZVE5bDdYQ2pJbE5oWmhI?=
 =?utf-8?B?SXdvKzVXbzRRMUh1TjA3cVprWkRGSklZQ3o5Z3VsRjRZcmI4SEhFdmtEQ25R?=
 =?utf-8?B?WlYxZjdaYk9XeTRJdUxMWERSMEticC9USElkVStpQnhJbTEvV1U3R1lRcEN4?=
 =?utf-8?B?Nk1uRklBcDNWc2VDZUpMdU9GRXNtUVI2MUdtb3ZYTC9WcS96UTd5NWVvb1Nm?=
 =?utf-8?B?RSsvektkTFduNXdpZmxqdWJuM2FPNmpWMGllZjVNVUlHR1F5VkROREpmOVZB?=
 =?utf-8?B?QW9JK0ZDdnMxMTZZcjhpMGIzM0treFBxaUpVZEo2b2JUNzdGWm9PR3I2MUF1?=
 =?utf-8?B?dVVMMC93Y0srRkVRL011dE4wbmhJQkJ4L3k3b1dnRW04cUQ0Q1QwdHNRTDU0?=
 =?utf-8?B?SGJkZVE3VkorT0xyYTEzdU5UNEtUc2xJYWRRNWhheWdhMnJpOVdESm9mcTNU?=
 =?utf-8?B?NURZTlVmK3BtcEhzMDdmRjBORFYzNHd1cmUvQW02cllmZVVROENjaVlzMnVV?=
 =?utf-8?B?eUJONW1NcjROa0JFVURRWllzSXZYT3lTenhZTDlUcHJuM1B0bUJOS2daMW4y?=
 =?utf-8?B?OFBnR2hwTXBhdHVLM2lUZFczcmplbHFGUEZmV3o3eXN5VjdGMjcwUE82dm5L?=
 =?utf-8?B?MXlUNzFWcDJTazcwRmRnMGM5Zzc4YnBDbzBjQTV5TlM5VlZGdWMvTG5rRzFa?=
 =?utf-8?B?ZTZhOThGc3Q3dEp0WlpMUlo5aUtGbUpVcmtqMGxINUdObFpwdTBYSnJKZlJ0?=
 =?utf-8?B?SXl1MVY2OTYrZzVZQVFhbzBNeTRGTHJSM3FINHNLaCtsMDAvZDBHWFRXN0hR?=
 =?utf-8?B?TW9kaEFuQ2ZWeWZvS21oQ2Z4UGl0M3hKSVNKRTFWUzI3endTZEg2Z1RvYmNV?=
 =?utf-8?B?bUJJZjh1Q3MyeXRuc09ZUHNTanNPL3cwblh3dEdMQzFzVk5yMFQ2UC84WmNU?=
 =?utf-8?B?V1R1QmNoY2d3cjIwdzRLV0ZUeFVxeUFvTjZNYjJjbmNTdEhZYk9nWnpXNTBo?=
 =?utf-8?B?WlJlejZvTForTm5OMklnME5JK1pTT2tXZ2pZcUpZN3E2SUZ6RTY2L0VFVWdQ?=
 =?utf-8?B?SzZFZEdsVzJwUmpyZXZkSERIR0U1NCs3a3pBZG95YjdrSS9uUWExL0U5WjNu?=
 =?utf-8?B?RSswYXdpWml2MXBFOFZvOUU4STdpQk83K2hDaU9DVldwZnNVR0F0bEV0eHFC?=
 =?utf-8?B?MG4vWldRcE9rUFIycnpaMVR4YlZZTXRBaWJBWUp3QmxwSkxlZUpYd29WREpJ?=
 =?utf-8?B?MXBXV29wS0JHaFZRZmVVVGVINko2dUhpSjFHT05uWlhJRDluMGJMT2M2d1ZG?=
 =?utf-8?B?ZTRFeXRhMG1pbUdybmRLb3BKQytnYWhFcDNXL2pGQWdSOGhUN0pHdkNmM0pS?=
 =?utf-8?B?Y3JxQnJWZjZWaWFybmpOQ2U5L0JHR29pa1VwMUw5NUR3Rk9pS3VPZHA5b1Q5?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <508642CA51434C4FAA3C6538F5A782FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z0fe273SElsgf419PBjmCRVIYvgWLseRCuRi3Wv702T8hnVJyeOCUU8kjKb+DYbdtgMlZBwnPSVdjOtmhLOv1Q68p+j/24tj1KMAYu5o8MY3hROqySK3yMOkWn1mKhT8pcHuvY/LlTGfI0BRnwDiFDvpaCApOS4JZ2IrK0SkERi6Hflvc/PmZRHiT9K7E7enpTLpoM5y5JwSH2KeW0e9P1TCAuqyu34eOf5XPpdVbirIhcquC1VfgzpesRPzTnd3xn4EDCusiJp+8HvkDK9uJvMeHOjCSiB1bmS151HQtkZw08JT7DlA/WZpwqm3+7wWd9NjR92x9XAw9Gegrl7+ijWczyrbbaTsJCg3ciNwCSQ/n6hLJ3BruRwVb9HX3df6pvoN+JtjpvcA6pdXAZjuLy4Jd8v5+l3DGtkaoHvcPwlTohNwRhhj+XJg+p9loZruk9PBbqASh3afYDdvpi0LOqCYb6TfAsRsNQWKn5B/3jqTq3KoxbIfdSR28UbwOcA6SNDIMG8kNzmURys2+2owvZkRybnrcdY2q950he1Wr3dEhwE8xxsi37S5QfkxJLGhq/YRzEP0aB2B+Ojugl++VWX1mL24leVdXdzBhFENZZuWusBWqonCTJgpH1BEDsjGXs93zDideAFmABc2ZKr0nA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f594679f-b3f9-494c-8449-08dc22c57d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 01:31:18.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMCkEprc1t8Q5cQ+dQkW6xO+/fGHqE4XLJzqaSFpYbxevTlTsO1JN9ho+nt2RS9ZYyPTtC6/vN4UYmIxOkY1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
X-Proofpoint-GUID: Brw6z1wsKgZsEv-C2kQNrJXUel3zO0yu
X-Proofpoint-ORIG-GUID: Brw6z1wsKgZsEv-C2kQNrJXUel3zO0yu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2402010010

T24gVHVlLCBKYW4gMzAsIDIwMjQsIEZyYW5rIExpIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAzMCwg
MjAyNCBhdCAxMjoxMzoyMlBNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiBPbiBXZWQs
IEphbiAyNCwgMjAyNCBhdCAwNTo1OTowMFBNICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
ID4gPiBPbiBXZWQsIEphbiAyNCwgMjAyNCBhdCAxMjo0NzoxNFBNIC0wNTAwLCBGcmFuayBMaSB3
cm90ZToNCj4gPiA+ID4gT24gV2VkLCBKYW4gMjQsIDIwMjQgYXQgMDU6MzY6NDJQTSArMDAwMCwg
Q29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZyaSwgSmFuIDE5LCAyMDI0IGF0IDA0
OjMxOjI4UE0gLTA1MDAsIEZyYW5rIExpIHdyb3RlOg0KPiA+ID4gPiA+ID4gRnJvbTogUmFuIFdh
bmcgPHJhbi53YW5nXzFAbnhwLmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gV2hlbiBE
V0MzIGlzIHNldCB0byBob3N0IG1vZGUgYnkgcHJvZ3JhbW1pbmcgcmVnaXN0ZXIgRFdDM19HQ1RM
LCBWQlVTDQo+ID4gPiA+ID4gPiAob3IgaXRzIGNvbnRyb2wgc2lnbmFsKSB3aWxsIHR1cm4gb24g
aW1tZWRpYXRlbHkgb24gcmVsYXRlZCBSb290IEh1Yg0KPiA+ID4gPiA+ID4gcG9ydHMuIFRoZW4g
dGhlIFZCVVMgd2lsbCBiZSBkZS1hc3NlcnRlZCBmb3IgYSBsaXR0bGUgd2hpbGUgZHVyaW5nIHho
Y2kNCj4gPiA+ID4gPiA+IHJlc2V0IChjb25kdWN0ZWQgYnkgeGhjaSBkcml2ZXIpIGZvciBhIGxp
dHRsZSB3aGlsZSBhbmQgYmFjayB0byBub3JtYWwuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IFRoaXMgVkJVUyBnbGl0Y2ggbWlnaHQgY2F1c2Ugc29tZSBVU0IgZGV2aWNlcyBlbXVyYXRpb24g
ZmFpbCBpZiBrZXJuZWwNCj4gPiA+ID4gPiA+IGJvb3Qgd2l0aCB0aGVtIGNvbm5lY3RlZC4gT25l
IFNXIHdvcmthcm91bmQgd2hpY2ggY2FuIGZpeCB0aGlzIGlzIHRvDQo+ID4gPiA+ID4gPiBwcm9n
cmFtIGFsbCBQT1JUU0NbUFBdIHRvIDAgdG8gdHVybiBvZmYgVkJVUyBpbW1lZGlhdGVseSBhZnRl
ciBzZXR0aW5nDQo+ID4gPiA+ID4gPiBob3N0IG1vZGUgaW4gRFdDMyBkcml2ZXIocGVyIHNpZ25h
bCBtZWFzdXJlbWVudCByZXN1bHQsIGl0IHdpbGwgYmUgdG9vDQo+ID4gPiA+ID4gPiBsYXRlIHRv
IGRvIGl0IGluIHhoY2ktcGxhdC5jIG9yIHhoY2kuYykuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFJhbiBXYW5nIDxyYW4ud2FuZ18xQG54cC5jb20+DQo+ID4gPiA+
ID4gPiBSZXZpZXdlZC1ieTogUGV0ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPg0KPiA+ID4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogRnJhbmsgTGkgPEZyYW5rLkxpQG54cC5jb20+DQo+ID4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3NucHMsZHdjMy55YW1sIHwgNyArKysrKysrDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlhbWwNCj4g
PiA+ID4gPiA+IGluZGV4IDIwM2ExZWI2NjY5MWYuLmRiZjI3MmI3NmUwYjUgMTAwNjQ0DQo+ID4g
PiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMs
ZHdjMy55YW1sDQo+ID4gPiA+ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sDQo+ID4gPiA+ID4gPiBAQCAtMjczLDYgKzI3MywxMyBA
QCBwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+ID4gICAgICAgIHdpdGggYW4gZXh0ZXJuYWwgc3VwcGx5
Lg0KPiA+ID4gPiA+ID4gICAgICB0eXBlOiBib29sZWFuDQo+ID4gPiA+ID4gPiAgDQo+ID4gPiA+
ID4gPiArICBzbnBzLGhvc3QtdmJ1cy1nbGl0Y2hlczoNCj4gPiA+ID4gPiA+ICsgICAgZGVzY3Jp
cHRpb246DQo+ID4gPiA+ID4gPiArICAgICAgV2hlbiBzZXQsIHBvd2VyIG9mZiBhbGwgUm9vdCBI
dWIgcG9ydHMgaW1tZWRpYXRlbHkgYWZ0ZXINCj4gPiA+ID4gPiA+ICsgICAgICBzZXR0aW5nIGhv
c3QgbW9kZSB0byBhdm9pZCB2YnVzIChuZWdhdGl2ZSkgZ2xpdGNoIGhhcHBlbiBpbiBsYXRlcg0K
PiA+ID4gPiA+ID4gKyAgICAgIHhoY2kgcmVzZXQuIEFuZCB0aGUgdmJ1cyB3aWxsIGJhY2sgdG8g
NVYgYXV0b21hdGljYWxseSB3aGVuIHJlc2V0IGRvbmUuDQo+ID4gPiANCj4gPiA+IG5pdDogIndp
bGwgcmV0dXJuIHRvIg0KPiA+ID4gDQo+ID4gPiA+ID4gPiArICAgIHR5cGU6IGJvb2xlYW4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBXaHkgZG8gd2Ugd2FudCB0byBoYXZlIGEgcHJvcGVydHkgZm9y
IHRoaXMgYXQgYWxsPyBUaGUgY29tbWl0IG1lc3NhZ2UNCj4gPiA+ID4gPiBzZWVtcyB0byBkZXNj
cmliZSBhIHByb2JsZW0gdGhhdCdzIGxpbWl0ZWQgdG8gc3BlY2lmaWMgY29uZmlndXJhdGlvbnMN
Cj4gPiA+ID4gPiBhbmQgYXBwZWFycyB0byBiZSBzb21ldGhuZyB0aGUgZHJpdmVyIHNob3VsZCBk
byB1bmNvbmRpdGlvbmFsbHkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ291bGQgeW91IGV4cGxh
aW4gd2h5IHRoaXMgY2Fubm90IGJlIGRvbmUgdW5jb25kaXRpb25hbGx5IHBsZWFzZT8NCj4gPiA+
ID4gDQo+ID4gPiA+IEl0IGRlcGVuZHMgb24gYm9hcmQgZGVzaWduLCBub3QgYWxsIHN5c3RlbSB2
YnVzIGNhbiBiZSBjb250cm9sbGVyIGJ5IHJvb3QNCj4gPiA+ID4gaHViIHBvcnQuIElmIGl0IGlz
IGFsd2F5cyBvbiwgaXQgd2lsbCBub3QgdHJpZ2dlciB0aGlzIGlzc3VlLg0KPiA+ID4gDQo+ID4g
PiBPa2F5LCB0aGF0IHNlZW1zIHJlYXNvbmFibGUgdG8gaGF2ZSBhIHByb3BlcnR5IGZvci4gQ2Fu
IHlvdSBhZGQgdGhhdA0KPiA+ID4gaW5mbyB0byB0aGUgY29tbWl0IG1lc3NhZ2UgcGxlYXNlPw0K
PiA+IA0KPiA+IEJ1dCBpZiB2YnVzIGlzIGFsd2F5cyBvbiwgdGhlbiBhcHBseWluZyB0aGUgd29y
ay1hcm91bmQgd291bGQgYmUgYSBOT1AsIA0KPiA+IHJpZ2h0PyBTbyB5b3UgY291bGQganVzdCBh
cHBseSB0aGlzIHVuY29uZGl0aW9uYWxseS4NCj4gDQo+IFN1cHBvc2VkIHllcy4gQnV0IEkgaGF2
ZSBub3QgY29uZmlkZW5jZSB0byBhcHBseSB0aGlzIHVuY29uZGl0aW9uYWx5Lg0KPiBUaGVyZSBh
cmUgdG9vIG11Y2ggZGlmZmVyZW5jZSBTT0MgYW5kIGR3YzMgdmVyc2lvbi4gTm90IHN1cmUgaWYg
aXQgYnJva2VzDQo+IHNvbWV0aGluZy4gSSB0aGluayBpdCBzaG91bGQgYXBwbHkgd29ya3JvdW5k
IGFzIGxlc3MgYXMgcG9zc2libGUuDQo+IA0KDQpJIGNhbid0IGNvbmZpcm0gaWYgdGhlcmUgd2ls
bCBiZSBuZWdhdGl2ZSBlZmZlY3QgdG8gYW55IHBsYXRmb3JtIGluIHRoZQ0KbWFya2V0LiBCdXQg
ZnJvbSByZXZpZXcsIElNSE8gZnVuY3Rpb25hbGx5IGl0IHNob3VsZCBiZSBmaW5lIGFwcGx5aW5n
DQp0aGlzIHVuY29uZGl0aW9uYWxseS4NCg0KQlIsDQpUaGluaA==

