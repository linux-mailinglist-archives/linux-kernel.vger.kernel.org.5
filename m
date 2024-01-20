Return-Path: <linux-kernel+bounces-31655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200B83320A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A981F21DBA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242010FD;
	Sat, 20 Jan 2024 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c3/z8Efa";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="K6mgyEUF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L7iz3faL"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC701EA3;
	Sat, 20 Jan 2024 00:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705712188; cv=fail; b=ncDtr5t1sIWWIMospzSA0BGNRpNBBc73rRpjXwmjCnewGergMSmzckqiAk6qJaxyLHTyDjDVnAdXUzHy2jf8Sif+38oc4AVnoifCVIdDPGoFEYisH8lcWmMmJze5s6lfOzksD1oZdoWgrfKsKY/H0CFAvF9+569rgwTTpSoJd+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705712188; c=relaxed/simple;
	bh=0WVUin8LFQkNm3MYzPd20JyQXTr+5kp/0v6eLnD/jMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dYfudyGpfELlrtZZSQTPFCWYrmq4k8V6XO1gOaybdw0XvoAfiEKWerKAWKScSrA+va7k8ELkcmesp2z4ZbYVFrDf+4iN+F7Zkm/qfEoumeja+6PYAQ82upe+hkT7P4yFxoVhRjT4TPWjzcg2nhDafX0ueMGCpgF/mijodSmO7L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=c3/z8Efa; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=K6mgyEUF; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=L7iz3faL reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JIDr6u025454;
	Fri, 19 Jan 2024 16:56:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=0WVUin8LFQkNm3MYzPd20JyQXTr+5kp/0v6eLnD/jMk=; b=
	c3/z8EfaH11mzR12KF2JUE33FVXcQ4d8sc+h7XWaAtlPJP5j/I8HX/LV9ebcYI8y
	nqFlkKjIWk51/tYdGU6px25XMcXWbqsfhl7B4JLU7m2xAQSFZygHjXlbmODC9HLL
	8BQVHeYHivrTl/gLSmpTtHqZc5dsdXL/pezM5cIuucUSiCWbtacjLXn+u9c6Mg8P
	+7boRD/4X9v25skfbvIHa8DZfv73mgkIrH9X2oaKh1VElq31J9/aslKIQNSBFo4j
	sHikuGFMM9XhBuzr9tZKCyP//m4LQ+FSm1hIa56D8f6L4/4wZWgQZ+TstCbBlc/N
	/4ogNjx5odXmhVh4m2N/uQ==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3vktaw2vsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 16:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1705712160; bh=0WVUin8LFQkNm3MYzPd20JyQXTr+5kp/0v6eLnD/jMk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=K6mgyEUFC3doEgAWhnRUjLdFDzBTWaxz4GVOcZsR4BJyJuXHzoGDiC6TNoHNlU/vg
	 h1sDT+eRGUZbLHW+S5XN2L4HxUGUBrYgu078APd+vmRISur/NcqxH0fiTW0RCRO/L7
	 fD4VDvUndM6OF1qY+3+PUGIe/CXaZQl6mA1toDiW+2tjUituzX47HZbwQnHvNaHetr
	 SYw1wnURtTBU5mum6ksuXKDPGe9AF5Yev+TFRhmOJIDm1FmokjzR+Q+/u0GTVbdAOo
	 eUogIdlm+UtPqr7j9GYDnTzPFMrPnNBRrWEbw8Uuu9/tGvcL1/WGiW10PxLVoIxhxu
	 F9ujhOEj1MfqQ==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 535CC403B9;
	Sat, 20 Jan 2024 00:56:00 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 04727A00A3;
	Sat, 20 Jan 2024 00:56:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=L7iz3faL;
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB42B40363;
	Sat, 20 Jan 2024 00:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbloSPVG4HZFLBgp+LjQ5v3sO2Q+gN/TV0rZy0zy6SJfw2DMvFPMC9JnGJ38i/pfFwM4UhkZSrUtnLBlrtwz/rvAlTCHIGSmAUBnzzhiLWinqF3zeO6vPBwFhyOMaFQNxf0hUrib4YZeddkCAj5ziYx9GXFah3ViXwwlJFEVQ4Sc+MPoDelZC1i39eSiIz3Bs4yRTrJczKibQdqCjOtTZDWijvaUnHHUYqeWROOmOqocFJ1jKsR7UMdI9imcjtbn0HBPIx88rCdm5FO9CkY+lUZ8xzbqPB6aGoZ2cTXRJ6H48zxyrMSgDTgpW7te6uKHDZpCogcFWytqyPNB7o5yiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WVUin8LFQkNm3MYzPd20JyQXTr+5kp/0v6eLnD/jMk=;
 b=en7+zTTGutf1exhjfqEhIa32cO5KoGU7jJmXH9RsCbhLiOenwH7q3iUVXGgm8d892ohFwBMPoY1Ybwb21QvYKFDVzmwDWAddzmK7WXHkmBesPUNEGdU8si5ji6yEauqVN6+6dEpFTcQXwk2L9FtRWABI3NUnIqGu6ObSx/oO8gS5xxaM31Dt+y5b4+FqO1px89mhgg1A2c31SKKNyzb97ZtjdT3bjd29OAqycQL8DeCDVo+oIu37HZTZovgKsQ0OdP/Wivhu4Sl8He60XzjFs0yNOnvR1vkOf0DhpWbTwQBD/sAVmuSuxBLzhz13RHY9fxO4Z7nSjLBhhu0ZmMLGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WVUin8LFQkNm3MYzPd20JyQXTr+5kp/0v6eLnD/jMk=;
 b=L7iz3faL/V31Gy0LIX9WEZH19IdUS6p7HnKonI5+YXEjwWUZXO3Jz0HmbBg1JIXu/AdHmmE8x2K1pyMIHqNw27ZGDzLlfmzPFt89tjQIjI2gZFcgr1wuTc5Pv+68//9aC3gi8wxRmyVmzgzWjEqGbYijeuBJmfqJNMUga9XLRa0=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by IA1PR12MB7542.namprd12.prod.outlook.com (2603:10b6:208:42e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Sat, 20 Jan
 2024 00:55:54 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::a6b8:3d34:4250:8ae3%3]) with mapi id 15.20.7202.026; Sat, 20 Jan 2024
 00:55:54 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Frank Li <Frank.Li@nxp.com>
CC: "ran.wang_1@nxp.com" <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER"
	<linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pku.leo@gmail.com" <pku.leo@gmail.com>,
        "robh+dt@kernel.org"
	<robh+dt@kernel.org>,
        "sergei.shtylyov@cogentembedded.com"
	<sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Topic: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch
 when boot
Thread-Index: AQHaSx7vIkvixdmjvU6Ts0lYv2QFCLDh3zUAgAABYQA=
Date: Sat, 20 Jan 2024 00:55:54 +0000
Message-ID: <20240120005552.pxlofaaoovxjt2oj@synopsys.com>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
 <20240119213130.3147517-2-Frank.Li@nxp.com>
 <20240120005056.o52hqn2sershhm76@synopsys.com>
In-Reply-To: <20240120005056.o52hqn2sershhm76@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|IA1PR12MB7542:EE_
x-ms-office365-filtering-correlation-id: 40d0408e-ce96-449f-a5ad-08dc19528e80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 OLSBxnmG3I8pC+VW53V6kD5ZqlobRIBZXR+y1w79nd5gMGiR8fxVDyvj3KqSGo0VWur/RbB0O1xiCHrkxCshASNOF1CRYm9zOSvBFmVieA4AFwFLF4nIfkzZIh8zjBP2/+vk6WBEMOsrW48awlqZcWYB0Vs+BVObubnbg/osNRdDIr0s9G3cds5H5LKf7eg20XdRjnQVbHTzoGIB7uDV9iUDyapYOuHVagmBzIndAkRAEt4EmQxRPzrUeKo8ddXDmdySjna3ZIC75+RwIHzVh2kLiJY6PTCjONLjHJfYjl6fEoAPdU6rCyR6JLopCnym3TC37lT3vm5Di0cEd4I08iSXU7KADyuTTnU0JpzZw2g9yLp1gMgYY3ss1mDeXXEGrOBTDTWEWGhx4BO+iFWuk/5nPnxKvrU+lvqRYEwPFtm6yrs4FyuW0r+YxbmXohVZ1x+1ktWiTyWmFYBnf6ZplKCB/2PddeeVrR8DjrhWTOjeuxYFEUTbmLvnOmpHFuYMZghUQGBrZqEkQ/OxcATmEClk9O2PsTHFJrFYFQxDgxJ7zfPPXvC0YzifvlaN1WkSQQ2wbS32kRr5Oryy9JEnacBSr9bQDEPI1CzXoIupDRbca17VZEUZUkkuRww7XlTa
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(71200400001)(2616005)(38100700002)(26005)(38070700009)(86362001)(122000001)(36756003)(7416002)(64756008)(83380400001)(2906002)(8676002)(478600001)(6506007)(6512007)(8936002)(4744005)(6916009)(4326008)(6486002)(5660300002)(316002)(1076003)(66556008)(41300700001)(66946007)(66476007)(76116006)(54906003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SHZXQnFTRmpCT1RLN1B1Ty9YWXd2V2g3cG93ZFhvc05SRVp5RzZhNnA3bFZY?=
 =?utf-8?B?N1diNjFOTFNkM2FVTEJmN0tFRFdzeFFTZC91bzVzeVYyT1VoQ3o2VkVKckEy?=
 =?utf-8?B?N2psTFJNZUs0N1ROaUU1Z3FBVndaTFNOaDh1RmR0NC9zbjBVenVEa2liYVZJ?=
 =?utf-8?B?VGdpL2h4LzZDcU5BNkhSR0xobzFiSjBpSHg4YVZPNUs1NUtrTjh2dHR5V2lH?=
 =?utf-8?B?a2lUd0wyUUtDeXlIeGFmS1Z5OVZOMHNTTFdJQ2xOODFxN2ZqRTBTK09NOHcy?=
 =?utf-8?B?N0ZMcVNFL0c5ditIWXpvNUZJMzJUMXp0d0hQZ2dmVG1yTjZVY3VhMWZ3MVRr?=
 =?utf-8?B?VXhmS3BRYjZKbk1YQjFEd2hBbVVRVmpDamlXMFpIK3VJemQ0cWFZWlZTdVRm?=
 =?utf-8?B?Nk93WXhRNGNONk8zTlZuQUdaLzBpTzMzU0pBcjh5cG94Sm4rMEJDdGFCRkp0?=
 =?utf-8?B?U0JxYkZmV01uRElOR0NFVnpGUmw1QVFlcEZwYWpHWHlGSlF6R05CMUZkMHEy?=
 =?utf-8?B?TW1yajQyV1FlVk1EZjlwWjNoZjYxYlJzUWQrNGRDK0I5NGtNRjlFNi8xVmdW?=
 =?utf-8?B?bkxEWkh4djNkd0FmU1ZTaUphOXVOYTc3bjUvVFNDSW9oWE9ERnRVd0habjE5?=
 =?utf-8?B?eTh6Y2FpTkc5UWQrd1prMHVwZ0pzVG83aUhvK2FNVThJME9lek9TaVRZU3pS?=
 =?utf-8?B?Q0l1d0ZuN0NoRldheEJ6SzZaN2xhUnBKUStNR1VtU2NMdnZTTUk5SkF5WkxU?=
 =?utf-8?B?dzY0NHBwaFg2VkY1c2lXMGh1amQ5d2ZyYWRFVStIK0pUd1hvZ2haUC9vdFJi?=
 =?utf-8?B?eHZMemtDckJDUDIvdlZTTlZkZDVtK01zdy9wRTkwekNncnRFV2ZXYk9UWXZX?=
 =?utf-8?B?MzBwMkZXNEo3NTR2dEVoQXRjVXFlZmdyTE5xUVl6aEszMmkzZkh3VmdBWHN4?=
 =?utf-8?B?bFlHUk51Znd3YXhONjR4QmVlM1l6QWpZNmJIMm5VQUVZTlVTNDV0NlErZDky?=
 =?utf-8?B?QUhMcmhWUVU2V2dRSCtVYXJXTUIxMy96eVUzRG5OZitkSStLOW1RNWt4WTVp?=
 =?utf-8?B?R2lpNVd4cTNkenprWFZOZFR1Q2kzaDB4K2Y0VFFseEw2YUdWSjlwUlFMeXl3?=
 =?utf-8?B?aXpnNEZWc3NxQTBjZGRsWHduRXRORmJPRGlrUXAxekE2eVd4MXBBK25PNmw2?=
 =?utf-8?B?NStNN2FTL2tQZ3ZNTEVsdUU0RU5BU1dTT3NDTGc1TW5XTXZlTFJDandDY05s?=
 =?utf-8?B?WDRvUVNiRm45bk9kWDJicllFVVZWalVDOXNjc2lXbVlhU2lsTzRpbU1pQ2hh?=
 =?utf-8?B?c0JTTDJ6ejM4eVZESkJ2YSthUXh2SEduY3ZEVzFGSmlsV3VDMlRQQUJNZUlS?=
 =?utf-8?B?UWovZmRsZys4cFY5eituYzRhQzFZMEROeWNnMVBsd3l6dkdsVWdUV2sxRHp6?=
 =?utf-8?B?cUVNUm1SbmtzT01HY2l0eDcxNUg1Rk1EaTlvTnlMMStma0M2b01QakhHbjUr?=
 =?utf-8?B?MHlNc3FPWnJWVVNvOUo1NHZHdTFJNlVMcFhRcHo2Tnk0UkJWeDhVWDlrNUpG?=
 =?utf-8?B?TkpQS1ZQVDZHVHFZZzVjUVpaYkpYcCtoalI4RWk3SGNCU3ZoRk1lTkxiNnZ5?=
 =?utf-8?B?TEd6dXh4YmszWXdmUXZ0YnJ3TkFqbzhmN0NRMGVSVkhEOG9ObUxZSFVIL0Jq?=
 =?utf-8?B?R1V4Q3FQcXFRVVhyQTF3citYbE9UeGllQkU1cmdTWlc5c0tBT3lkVnNPWkxX?=
 =?utf-8?B?RmxLc2w5UGdOUjdOSmVpR0VVSkZoTVFKQ1B5T0FJYUpRN1ZYQWgyNjh5NnRp?=
 =?utf-8?B?UDRBZURJUXBkd3VSWEFxZllMa3U4RkZENCtBYjNlWldETkJzSWRPYXZISXZQ?=
 =?utf-8?B?ajlTM3ZsSEtPNG9ONUt4MEUwVkhaUCtudWpXSTFqdTZhTVJGR2UwdUhNcXAx?=
 =?utf-8?B?RHJOWDlaQ256TVZzaTlLcjJqZFFWZUVZdlJVVDN4bitaTktwTDY5blJ2TnpW?=
 =?utf-8?B?UUt3REgybVZyNHJ5MGRvOWRDNGExWituanJ3Y2s2WTlEVzhmUUFZR2QyRWF0?=
 =?utf-8?B?Rmc0MEdKeTNpcUp6Rnlwa1RQSlVOVDJONThJSHFpYW5tWGJiSW1CSkJ3SVJ4?=
 =?utf-8?B?MjdkRTYwWDhqKzJNSEZrTm9XYm1GenpXSURLdGk3VFNuQ05VS01MMDdoU2tR?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AEA46958882204D926C77D2F05A4255@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gTtPBCJJc7C4N6FhlgNEeA9+dQNl/das+wWUDgw+QLnhT/iCryBuBOL2VYTKMeEDupp8NVqVGFDP1bb3h6IF5Wx6eWgCDN1FHxkrahDgjkwFBiZPUiNbSFk9lDwbh6b04d3DE8EFkPQO83L5shnR90FI1yxdIdDiXMSjeY8d/HojLXhhGaaP3c+XI5DGdaFQSD4ASZ5Hi6GA1bGVGwKsCrxIadGwyFamNUBAvGnTeBgLoZ4SLq04rcfUIIcsBskjoINnSv4QaRGrUYjaBWCevuErEWLNxz38x8C4IAnfI17sI0HrEkKWgoeqRQuEBLp66i3X6oFXil9HOx2bdLKCwSTO+wgznFbDhOgqIApMu0YLiQNtx6Q/7mJD63Bv8Pe1wOAzvilzBxpM8r+OGbugRt8J0YUD0tXJk4sW77NO4MHO6xaYYgBhHRPYJceT5CS4CJPxRN49VWgXwZJIaB9fTiaFizgvL//u5Lnmcl9PEEc8fiutv/ayu1vEi5KROl062Q6meFH5jFK2uJhDc3GsMvA7L2Za60tb51sQlsdjMvqRNRx/nofdCkfQR+wWgHqazfR9SWemMYaguioFPpKdETORpYfBRy/WP/b+ucZHIJroA+6WZ5C3f//NmnHR4WcGxdWm9x/lcOYV13yURObW1g==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d0408e-ce96-449f-a5ad-08dc19528e80
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2024 00:55:54.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RnvC0YGRV3FXIkAmILfPyGYuCkyko32SP8B0aOp5K44BgRM/tnjkP1zhU1aT6xFxYI6xOSTHoBojnlGLRMdVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7542
X-Proofpoint-GUID: qfiR01qzFm3uyHZ7qLb4RVqRVpPFSZ8d
X-Proofpoint-ORIG-GUID: qfiR01qzFm3uyHZ7qLb4RVqRVpPFSZ8d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 clxscore=1015 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401200005

T24gU2F0LCBKYW4gMjAsIDIwMjQsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiArDQo+ID4gIHN0
YXRpYyBpbnQgZHdjM19ob3N0X2dldF9pcnEoc3RydWN0IGR3YzMgKmR3YykNCj4gPiAgew0KPiA+
ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZQkqZHdjM19wZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNl
KGR3Yy0+ZGV2KTsNCj4gPiBAQCAtNjYsNiArMTA1LDEzIEBAIGludCBkd2MzX2hvc3RfaW5pdChz
dHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ICAJaW50CQkJcmV0LCBpcnE7DQo+ID4gIAlpbnQJCQlwcm9w
X2lkeCA9IDA7DQo+ID4gIA0KPiA+ICsJLyoNCj4gPiArCSAqIFdlIGhhdmUgdG8gcG93ZXIgb2Zm
IGFsbCBSb290IGh1YiBwb3J0cyBpbW1lZGlhdGVseSBhZnRlciBEV0MzIHNldA0KPiA+ICsJICog
dG8gaG9zdCBtb2RlIHRvIGF2b2lkIFZCVVMgZ2xpdGNoIGhhcHBlbiB3aGVuIHhoY2kgZ2V0IHJl
c2V0IGxhdGVyLg0KPiA+ICsJICovDQo+ID4gKwlpZiAoZHdjLT5ob3N0X3ZidXNfZ2xpdGNoZXMp
DQo+ID4gKwkJZHdjM19wb3dlcl9vZmZfYWxsX3Jvb3RodWJfcG9ydHMoZHdjKTsNCj4gPiArDQo+
IA0KPiBJdCdzIHBhcnQgb2YgdGhlIGR3YzNfaG9zdF9pbml0KCksIGJ1dCBkb24ndCBkbyB0aGlz
IGluDQo+IGR3YzNfaG9zdF9nZXRfaXJxKCkuIFBsYWNlIGl0IHdoZXJlIGl0IG1ha2VzIHNlbnNl
Lg0KDQpJZ25vcmUgdGhpcyBjb21tZW50LCBJIHRob3VnaHQgaXQncyBjYWxsZWQgZnJvbSBkd2Mz
X2hvc3RfZ2V0X2lycSgpLCBidXQNCml0J3Mgbm90Lg0KDQpCUiwNClRoaW5oDQoNCj4gDQo+ID4g
IAlpcnEgPSBkd2MzX2hvc3RfZ2V0X2lycShkd2MpOw0KPiA+ICAJaWYgKGlycSA8IDApDQo+ID4g
IAkJcmV0dXJuIGlycTsNCj4gPiAtLSANCj4gPiAyLjM0LjENCj4gPiANCj4g

