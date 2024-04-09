Return-Path: <linux-kernel+bounces-136106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 482F689D012
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CCF1F24D83
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0EC4EB51;
	Tue,  9 Apr 2024 01:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C8LcO7Og";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="knhUvHzJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="B8cBaPvT"
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE414EB23;
	Tue,  9 Apr 2024 01:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712627703; cv=fail; b=TsoIg4TaH/65ykszSyfCwwrT8u3dY98LJC/4RDzl2S9N4iCFR3yYg8oQJ3Zx+jD6LpzZa9kAst1ffUqg9Oi3vQYJBguCR2AZ8A7/DVodpYPJSk0unbq0xIpzdUoIE/IceSJ3OvL+tSh71nGDhU8a6bipUaWAadxY25/9kfI+xbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712627703; c=relaxed/simple;
	bh=vJF0ruO7/ofv+NcVkQLBg5LIxv8TJqDl2svtkVJ9bDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SfPQF2FyleMFJRbdTWB3PcXG/kUQL1HNHXG4vkMKQO3vQ+97mToY048ER+X70FIY3hmrLhdnLK1tJhPUYqWHJWzm2PiCMkPnCocbYDyDvBfdWSE2TDR982SBBj+CxRWgvPYJ85pAx+zFrtO8Xm5SH+hLaJfe6i9v4tIaakyTERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=C8LcO7Og; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=knhUvHzJ; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=B8cBaPvT reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4391Gaad002698;
	Mon, 8 Apr 2024 18:54:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=vJF0ruO7/ofv+NcVkQLBg5LIxv8TJqDl2svtkVJ9bDg=; b=
	C8LcO7Og60c0ys22kXte+WXLTIilZhvW9SpNdJ8Z7UB2FaBeIbeCBqnIeduLK0IS
	qku6UaWCHDy50To7/3OFdxBedAC5nZF5tkQbpLIqDfNmK8BMxeDceVQH/CvBdyj5
	HLPg1HroUUWy4QIfCByqpp+fEyZiJNNUj2mcQ4XeepHYfMh3kplHuC8vbr8E+HtM
	pXD7NYUFyGLS+U/c4fAhgnHHuIaCdlqwXyvxGuSdzokwAU0ixcTsxlxZGcrxlS0T
	eEzfdu0YlDeTLO0W3PtttPmSyGgTZcSqGDLW5IQuT2acp0fevxQ2NXd0JWKr+vQ1
	xJRkHQ/p8Zxf8+uNc4rbzA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3qemk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:54:47 -0700 (PDT)
Received: from m0297266.ppops.net (m0297266.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 4391r35C002595;
	Mon, 8 Apr 2024 18:54:46 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xb5n3qemh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1712627686; bh=vJF0ruO7/ofv+NcVkQLBg5LIxv8TJqDl2svtkVJ9bDg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=knhUvHzJeIDdaDdn4DH4Ic7d2yoMLf7Jxft07CoSpK5aZYhEtFo2rMnMJyqNnvrCY
	 hVvKXFFjelwMHgzXk1jsVIGdD3QInvgpy30KxI5s9OlshK3KEp6K04e10cC1gMK1M7
	 ZOK+UNC1UFUdKTaef9dIntA0JTV6sGhKHyILaaQ5r32dnL/ssqj7vYldBNC3q6pVU7
	 modlrBX/0EGhQ5XiMNmLf6q1liTZvPOdDWKv9d21MVfRFfQLBH4egtu7tq2zu9hvh5
	 AGFlHPIpWYzMFz/d2wr68PEUZN030FDOnIuFCo4a0L2ZZVzfnzVpfKbImbCiPPhVkf
	 39+ySCmD9yGdA==
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D1319401C6;
	Tue,  9 Apr 2024 01:54:44 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 99A51A00B4;
	Tue,  9 Apr 2024 01:54:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=B8cBaPvT;
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 95C274045F;
	Tue,  9 Apr 2024 01:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XV9vHgX0sVsYB4gtNyWxpiLkG8isGx8zgeMcaoypSVTP50CrZmfAPGV2hRuNSsSLm1ITLICMcMOE/CbZq48O9uopcma5ZS5Nc9f8wGSI/WeAHugadlKGURi/CHPEMHQFOeFPtzMWkcQls4SHfFukFj04yoZXfU2u0saMkcLkezrDQnmoSdlW9rmqkip0IceHq3kgiDqSf3EBy3eaWqkkrVG8DfIA8ob637CtZNAAMtY6KSPDHJQoUiFW15X8LGytMR/4ETZ/TK7MLjWbwsRkP/rBVJhSd28q3EJ1pCWJ+I+YiFdJod06mslljyVYJcAwu3LqRSH5TRsLJOnF3wo1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJF0ruO7/ofv+NcVkQLBg5LIxv8TJqDl2svtkVJ9bDg=;
 b=mh5VrO0PDETUuK+XsDrCYVLFTSVPQ2Y0thZfvdiPsZjCs0wo6HgjgBeAJjwjQ3iaXYpyRcw34BE2skYDrj8UuSuWrZkESzCdoC7cLT3FVSmB+em81/qK6+Lp4e9asCBwtL/PsSsm89R7ubkE769/l5UH0e3iz+gmJCATpLpeK2wq/BMkIHP/IITvRPjJSiLNFeufXZxoaw2UFD4pQH1qIihbP+43qwF8+YUiLqUsT3g9YHdHwo5hiZ/oUmGbhNXyzRjf2jXa3b/LOkbxCMS+z7PjyHN//2mqhPalWtenZmaeJpFe/+y6KOzdCkIb2TNNVu0LdbO/zXItkKSNg5g3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJF0ruO7/ofv+NcVkQLBg5LIxv8TJqDl2svtkVJ9bDg=;
 b=B8cBaPvTweLFyv36zttef21PtncA1i/LPR8z4h2tPuFumgLES2LxJN2K9F2mEFhabBogQfvhek8oPC4dzIPY4dozNWlh4BhKQ2RAR4gq8g+UbxzwGMJaC9vWAReCpSjQH7V79udg0vvkvsc67eVSqY9DX8km/VlPBgo+Dv2aTNU=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CYXPR12MB9340.namprd12.prod.outlook.com (2603:10b6:930:e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 01:54:38 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::c87:4fbe:a367:419c%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 01:54:38 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Anand Moon <linux.amoon@gmail.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Topic: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
Thread-Index: AQHahl/kJDrJTmdr+Ua3V0pkAR86KrFfNPmA
Date: Tue, 9 Apr 2024 01:54:37 +0000
Message-ID: <20240409015352.ocpjbgxrx636jmk4@synopsys.com>
References: <20240404071350.4242-1-linux.amoon@gmail.com>
 <20240404071350.4242-7-linux.amoon@gmail.com>
In-Reply-To: <20240404071350.4242-7-linux.amoon@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CYXPR12MB9340:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 a1LihwmuSbD2XSKsfngO98gRLUEJYyHZlDDS9I13qlzkym3mFS2y/OgSsz/ZQvNhR6NX99mjZhoPDoLa5YYQK5n6jwI1N+/QQ8IxuPyCpqvgb3IEFhKuZwK7wM2PzIVzssepuKOyW4MO+t9EYe4dRveG0c8IQYNyPvkJSfRVHh5q0jd70yrZkQRDbM1G9b0FTGI+av0rljtZkm3FbTSQtAYRbrNA9l6qNsJqi6XZu5hsSmF2BoX9CuoDy9AgqinoJJobL/xHdXxeSmQPzUoq5pDuHt3o0tMwiQeNpRqAR3yToAl7ceeWWef9Bz7q0afqhTKIJ6pwxkF8hOjvIL3215DxyHZ+WnhfL24nARb6ejCo9oeOiPpfIbY251F24BmmZIsFnKKGnx7ENB43DzMEcgt9oQqhtXfXW2vLcek7T8/5L7M0dUqt74pKYwqo44z8KYgWc7Sy5FQFa8/BOB9D7TRj6Tg5RJchVjRrPRhZ6qeSQV3Y4aaFirVL+vuD2z0Fg7dFTordTxCC0wrQ8o7TbvTrSfzoRFqMDIDBGuUnwhDAF4gvSSN/xxhWENxuv2fs+Ow/sAjEDZ4oEdo7/ZgkSGurUmspppUDTYDpToE6z+njKkToaDPN3GdXzP9fptBUNuhyq0P4wBxgjkvJHWhJtvbIVuwOSDj4dtUlp9eFmMc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dHBFTmQzay94VkVUTU9YWFpVWWsvV1RhYVRjYTcxUDMydEgvZSt4c2x3emNO?=
 =?utf-8?B?V1RzNlJvY0dkZHBGZFBjQTZvK1AvRWlGb0dUSVc4dWdMclFyc3pTa1BNbFNF?=
 =?utf-8?B?VGMrMWIyUVRLbXdLeGdJRlhsb2s0V3d6ekZIMWVGaDBkZWZkVWgwREYwQUpN?=
 =?utf-8?B?bHFsNmRHMEkyUlN1ZWpIUFZibEoxeExhNzdnd1FwbVlBdDNuajVMemxrb3Y0?=
 =?utf-8?B?aE8zeThRbUF1TklRbDhtdHhaRlRCbjk4cnN1NTcrY0xvWThDQXR3MkpWT3BL?=
 =?utf-8?B?ZnVuN3ExYUJTRUdla0ZJMmE2NjltdWpNN0FNL2wrWENWbVlBQUllcFBxNXAr?=
 =?utf-8?B?Y0J1L1JyTXFoaEJqMFJ3YURQd3NiN2ZHcHdMalBibmVxWFYrZTdwUkptaVBi?=
 =?utf-8?B?OEIxUzF2eHp4MHRWWDRQSm9yZndTZnlyZ2UwdHUyU1ZGVTErYWRYRXJGdWV5?=
 =?utf-8?B?bFZ1M1ExQUdVSjVuR01peTBvU0xibko4cTRUdDgzejJMWllNcEJDRkprWXJ0?=
 =?utf-8?B?eWNjRDFmcUc4ZGNjZE80NVRORUpjRzl2YXpzTDJVczdRVlpJMHd0OXNsNDVJ?=
 =?utf-8?B?OTlrd0FrRjEzUU9MTWFQMXEyLzJYcFpCU2Z0TTJDbnV1MmFpZUlHd2lObFFT?=
 =?utf-8?B?czl2L2JSV1RmS3N1Q0hSU3RoMDA3UFV4QUpVWlU5WGlCTk54WEpCMFNJTzVW?=
 =?utf-8?B?K0VPa1dHeVlBbHF5Mk8zaXJVSVI1dlNVNlcwZ0hvRjlISFpycEhjQ0FSMG9J?=
 =?utf-8?B?WklBYktHSjl0R05xQmpqNFowQVppRHhMczZHSVFuY214ZTI4NHNleURwenJN?=
 =?utf-8?B?WGRqY09qcUhJaWppeHh3UUZEMFhwTEQrRU9oeE5leVBiWEVkZWR3Vmt5SGlM?=
 =?utf-8?B?S3hQTTNrUlZoMkpJZFBKNWlxQkdKYTJ4VEphTmdCZkovOHlPZTRGSVlBQ0dx?=
 =?utf-8?B?NmpneWFuUjhxZlk1UmRvZHNIVVhodE1MbEFtYXFZRGUwME5FT2xGNUdMNk5n?=
 =?utf-8?B?VUxmQWYyMis0MzVBVG81ZU5ocGhjcW0xZUNwOXVtVE53cGlBa01oZjVzSWVU?=
 =?utf-8?B?QjFVMjMzdFZ5YXBvL2F5UDZiVExtL0RHMkhxcFRUZitoUUJJRjh0SFQ4aE9j?=
 =?utf-8?B?TzNGMDlLNzlvMjFLODVGMUVrRjRkdm9YWU9UNldhV1VpMUJJL3htZEJPMTN3?=
 =?utf-8?B?SDNhcGtZZDFISEdFUkN5M2U1d2dTSDk4R2ZUa3o0TTJHWGdsNEhOY2xTVm15?=
 =?utf-8?B?YUxsTHRiem9PZk9aMFV0RU5DbU9ZVGtLQnBsVHMyaWhhTk9tQmVFN0dhTWhJ?=
 =?utf-8?B?ZGhJM24wditLRmpnVkpxdmNwMCttVjdOcUV5SjIrZ0RJK29hL2VvN09EVEFK?=
 =?utf-8?B?d2YzQ2lKTHJkdU1NTGRIYlM2NkYra2tkV2NSNldrVW43aVFXb0YzOVFneGFv?=
 =?utf-8?B?WkQ0YUtBcys2bWN5cUtoR09KeXlHU3lOY2pmYXpSRFgyQ3lZYzRDZzNacS8z?=
 =?utf-8?B?VDNlclcrUjB2eFhFQlhVVVVLQ0hlSEFhVTY0MHB0RkJPWVA3MDM4bnFRRjZt?=
 =?utf-8?B?bWN6OWhYbERvR1daK1NGVHBXeUlQMy81ZHhxTnNLM2llYkFDTW44VWtxcDBU?=
 =?utf-8?B?cVp0VTIzUTJ1OThmOG15K3grT21laGRwNFBQbTZyL0tmcUh0dGxWTU13a054?=
 =?utf-8?B?SENTcXgwMFpCd3lGSEIxQ29GOVZTZitWd2FUQVlhY1JXSmxHQm9tY3AvSUtn?=
 =?utf-8?B?YjJ2WjVGVE8xYXdRcndHYUxxUHNUNEJrYzhCem50US9lWjhSQVlNNkJYNFZU?=
 =?utf-8?B?bTlld2YyT0NSaHM0R1QrTXlCdURhRW5xYURyakQyTXQwM3JwanlhMmxiWXJy?=
 =?utf-8?B?VXk5SEcrSXF6b21sNmNjZ0NDNS81RVJ2a0s4dmJMYnBHNFhHcnBLczhGd01o?=
 =?utf-8?B?ZTg0ckMvZUUwTmZQL2VvY1p2a1JsdXlPMERGdWFMY09CUWRqdHQyRUoyNDli?=
 =?utf-8?B?OXRlMlMvV0gxSlBMeWZkejFYTEZaTS83ekJkUTVXK2Y2RGNETTBzUjlWYUU1?=
 =?utf-8?B?ZVdtYkpHMnVyZzZvUFpYWGQ2VFZ3Z05qYlNPY3NvZVFRS1luaStodHMzSGh3?=
 =?utf-8?B?enF5ZTMvTmdiOVU2UlJOdGtzeFYrNFlYcnRCNDhUd2VCS3hQZDgxeG1FTTFR?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F4044BF54A46B41A6B1380701896214@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VEY7OM8bHqkU7VljNXi1dv2U46pJVWGnnDYm37OvG/oOId+XeOTL71wniNhASBikmetX5wupeI+qtBE4AGbPpAXq711uFaP07SIiOHFhJOZJBrIlPkGFZ8wEpLN9N2T8aNujJ67Yzq56HD7hDkkZmW2YGFrjeIORF2s2gLV/k3wNPmYUQ7BGsv1F/KIPoyF+iY8ceS8PglU5VSbcsbAMyiRKt/gPB04kUfEhJqVqEfrlCxVfkuf51B8Cvn1cNZw86CA8++h0c3MZF+NFJXiDeSn3Ku2nnVfPFkCBTGx/Zg5H1EKCK9apo7PsUyX/X608CVoprjP+xWw9QKDbLmDsjLPYUrB/Q9+7eMb1T1HVhxEgDx0x+7SRKd3X8bbDMJEzRWjsRvXh9RXc4YS/03pbB4scvZ/dMFdH+UaoV9/YJnCWPw3M4vmixasgsYT7lDoQuQcEKOt4AoxL8ZLaxsXApsA4yE7Mr/Dve8Uki+aK/qXSY/QaQihmW4EAQ0k9qdBx13XK2G7d6xn/iFrqWSXj3vCZJ1EaSJl4bwkceiVkBay9qY9g7h40vEZsCHz/HSj83icFyfj5voqG24+Peh2DH2OlyQ7JJc3oZzEYXuF9rfy02iW/qen1C0dX/Jy6U2thzlu6eYJ5lSz+VZWghEMLXQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9aab71-490f-4d17-0333-08dc58380381
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 01:54:37.9741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWcXkxIvhrBFpfGO/zUAgQYmYmKuVuAE9+CA0jtho2frcFkyffgw44bz36J0rIr/kvmo1fgXyYF+eazeys0s6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9340
X-Proofpoint-GUID: pfCWQOOoQDxrsYj5YzEfDayvp-GmVw2h
X-Proofpoint-ORIG-GUID: Y6eVqXpQITJVj1tTZJf07voVaaaMg4an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 mlxscore=0 mlxlogscore=745 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404090009

T24gVGh1LCBBcHIgMDQsIDIwMjQsIEFuYW5kIE1vb24gd3JvdGU6DQo+IFVzZSB0aGUgbmV3IFBN
IG1hY3JvcyBmb3IgdGhlIHN1c3BlbmQgYW5kIHJlc3VtZSBmdW5jdGlvbnMgdG8gYmUNCj4gYXV0
b21hdGljYWxseSBkcm9wcGVkIGJ5IHRoZSBjb21waWxlciB3aGVuIENPTkZJR19QTV9TTEVFUCBh
cmUgZGlzYWJsZWQsDQo+IHdpdGhvdXQgaGF2aW5nIHRvIHVzZSAjaWZkZWYgZ3VhcmRzLiBJZiBD
T05GSUdfUE1fU0xFRVAgdW51c2VkLA0KPiB0aGV5IHdpbGwgc2ltcGx5IGJlIGRpc2NhcmRlZCBi
eSB0aGUgY29tcGlsZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmFuZCBNb29uIDxsaW51eC5h
bW9vbkBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MjogYWRkIF9fbWF5YmVfdW51c2VkIHRvIHN1c3Bl
bmQvcmVzdW1lIGZ1bmN0aW9ucyBpbiBjYXNlIENPTkZJR19QTSBpcw0KPiAgICBkaXNhYmxlZC4N
Cg0KVGhlIGNvbXBpbGVyIGRpc2NhcmRzIHRoZSBjb2RlLCB5ZXQgd2Ugc3RpbGwgbmVlZCBfX21h
eWJlX3VudXNlZD8NCg0KQlIsDQpUaGluaA0KDQo+IC0tLQ0KPiAgZHJpdmVycy91c2IvZHdjMy9k
d2MzLWV4eW5vcy5jIHwgMTIgKysrLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA=

