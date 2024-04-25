Return-Path: <linux-kernel+bounces-159337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B858B2D45
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927671F22735
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67221155A39;
	Thu, 25 Apr 2024 22:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yl5spD5w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EdQkYHmf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A65631
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085389; cv=fail; b=hF9s8rnIjTlpEKpIrr+8K/VdlHwBXPt6GiEwSA4qRJB94nu+JJGZdLglvIgyifdEkMNlqW0xBp7eHoZa2iZxtelOTorTTJEDXLZiDwBL8A4WEZIl1UgfrJqLVZh9zfi0WWRnIa4cWem6u7kqR1BqasRtPgzyWnueexNFWU7buuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085389; c=relaxed/simple;
	bh=6nvjyfabi4bqHOm1bJEyL3dg0Pq1oTOxX0xL7xivHQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fFx5QtnBxPlIf5s7+SeDiABLCrToaqmefOFXcC5eZagjiQRbj8CZ2hRGijItu1WjyzXnWq8J6184oOjk88zhm1ZrzgiVcZ5k/TXUmZ10XNfXxqGGUllWY+BOtHV8Np4ZpoUeu3ko5eQUn+usY1gSuFAwD2ge9EXpCiwnVliv8ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yl5spD5w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EdQkYHmf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PKrwOl028857;
	Thu, 25 Apr 2024 22:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6nvjyfabi4bqHOm1bJEyL3dg0Pq1oTOxX0xL7xivHQk=;
 b=Yl5spD5w5XdYPCwvx75xHzzUEh+CAKE7yCa/q9t3snOR7QQ6ZAWqCxczW9TcsBwDeSuu
 DBHI8UY25UkbFQ/FdoUmDxhTqmjsrH8TOrdE+Lm0wCSxJkeI/gMXNAGLE2YY2gGQay1X
 etYW0ZXx3aepGuLisgIRgUAlH5my4FXkjwykbUL3qRJcrOOlVfiDV+gOJnbCiHB+fRQM
 pJWC4KfkcI1dgjnPs//U4WaYBec0+ALq8X7e1RdPvMr5F6LmCzcTvTpKZ+KbKLJgd0ui
 f+T9WEsY7Ovz/4jz1gmO3+ELkw39A3xPY0SFi3PBHsVSGnJ5/yawqf+fjd2ZvHeXiUCW 7A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2n2hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 22:49:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PL1QQw035551;
	Thu, 25 Apr 2024 22:49:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45b1ruc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 22:49:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8qCufqjHg7TCfsu+16u5kZn254z2jmfRGdfjnfUVRMO98FPYqOh6AmNQwWyWB78wcbqAGiMxVuZ42dL6eCr+abQXj/zUmoPE/BbO5LMISYRKegPFqeWLABftL0ly6VGHNSLSP3mnQO60m05utCEf5SHhFO53fgGT2+3VvEZDihlBIUmCueSxodiDckMtUShPU29h/cqWAyELiKevJjCl7zregyFjvRa7xQO5XMChJnK3jZBcSUM1zxG47F7R9102ARa6/fOgLh9lBlymLaY5Grh+bUyGwZiD4O6j9qfM7fazqxZJMfAMPkJQlwn97Gye9XCOekqIIDRJ8Ih02Fs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nvjyfabi4bqHOm1bJEyL3dg0Pq1oTOxX0xL7xivHQk=;
 b=HvukZLFD5WwH/2njBWGsserBTKwB7An6sptpcLRGnE3mKkbTMAyVFtGfMb+dovb6aB0RScTzD8IroyvHWpHVP+yyIQupojTuDHnIfKd9C3h1J3TNMYVLd3GTDZEKlIuyNpCp5srTUmmqYUgPK6TQWA/1JpwXlRspMoIv5FYrVSj2bXnzNAFg0g1oHdLtN/J7AXRIMJMVFLHhY/iDXBKaWpH2jWDb4TUFuaokwCmy5kZbjiUDwWqnEKdcbDKO86yzPTrtSjFTvjo7ItflZb5GNvoel8YyUweVGsOraCz6+NZYfrPZLcedEfmcayg/E4EmlICHuRANQ5yDFlNrnRbfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nvjyfabi4bqHOm1bJEyL3dg0Pq1oTOxX0xL7xivHQk=;
 b=EdQkYHmfKm27MEIYCGuSymfqdCnOQ+nv1t7v+Str22wVQa1h7Hd7bd8ZACYozOx1kusHBpFmj/Akb1/IYDX+Ao3WXkpaWlZXUxRoW59FeYkPYOYHCdoENlxap3Xh8nz8e1vlu4/jMNY8wjkeQC6rgp5uPiTe1y7guHu1smh7R/o=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by MW4PR10MB6394.namprd10.prod.outlook.com (2603:10b6:303:1eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 22:49:30 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 22:49:29 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "jeffxu@chromium.org" <jeffxu@chromium.org>
CC: Andrew Brownsword <andrew.brownsword@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthias
 Neugschwandtner <matthias.neugschwandtner@oracle.com>,
        "tglx@linutronix.de"
	<tglx@linutronix.de>,
        "jeffxu@google.com" <jeffxu@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "sroettger@google.com"
	<sroettger@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before
 XSAVE
Thread-Topic: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0
 before XSAVE
Thread-Index: AQHal1RTBhVMcTr0lU6QlR+7RegrZLF5lvSA
Date: Thu, 25 Apr 2024 22:49:29 +0000
Message-ID: <7054B528-C603-4EAC-B48D-784480DFE4B6@oracle.com>
References: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
 <20240425210540.3265342-1-jeffxu@chromium.org>
In-Reply-To: <20240425210540.3265342-1-jeffxu@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|MW4PR10MB6394:EE_
x-ms-office365-filtering-correlation-id: bd4c0198-8ee0-4ed2-30c6-08dc6579f792
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OHFWc2d2OHdrNThRQjFSd1hBY1dnUTVqaENobjRXa2xmRkZkQ0JYNmhsUksw?=
 =?utf-8?B?L3NJSy9PNHZTb3VxQWRocjVmOEtvZkc1U0VnZGpZQWMwSEdiMmVVTzl1Q1V5?=
 =?utf-8?B?bE95S3pPSG44WFBsVytJeUs3UWFYcERiTDJsU2EzMmpZdXlOMmc4TUowMWNz?=
 =?utf-8?B?OExsblFwZ2h4aUFodlhjUzdMYlA3cTRFU3l1ekRqamZyZDJscC9mOFRnQVBI?=
 =?utf-8?B?aS8yQS9UU2hYNGxWMWNBQ0tLRWt6Szlwb0VsdGs3enVUOE1ZazN0WXBlSExi?=
 =?utf-8?B?L2tweFB6QjZOK3BsWDhSUXFuLzIvbCtGNE83azVRamdKaUpSbHBLM1FlaXFz?=
 =?utf-8?B?eHJvMGZqV2V2QTRVQU1HSHZETnh0VGxBUjNla1dlMFAveHM5RFFDR1ZPSHdj?=
 =?utf-8?B?aWc1cEI5akR5NmNRbmNXRUhqYitueUZzazBnRzNYVXRSbGhlcVpkbUZkQk5p?=
 =?utf-8?B?WlRxWWh4YTVYZlVEdys3eGtRQmU5SmxMTWJtWlZaamhmZUE2V3ovaXhwYUxo?=
 =?utf-8?B?UFhaSCtvdnkwV0RPV2Zoa2U0YUtCSjRXMmFqZmo0Y0M3eVZTUXpXM1hhdFls?=
 =?utf-8?B?anBybUtsSjAyejdmWEl4SUhoV0xvT0N5cjIyY0NQclVJdEMvLzNLelV5cnlM?=
 =?utf-8?B?SURUdjVmYnJ2dkJwOTlvNUdEYzdKWU9DeVJRREN1bjZaS0V1eG9tdmlvRkRy?=
 =?utf-8?B?R2E5bXl1dVd6NW1jR1o5M200UUpWTTdDYTZvV0tla2NLbFpjS2tnYzBFYWNl?=
 =?utf-8?B?ekk4WTZncVZNWUV1RkVWb1hyT3pNdVFwRkJac0FpUmMwNm9lK1BGQ3ZSTEp2?=
 =?utf-8?B?RU9zRTlSSjB0SUZ3SDd1YitLM0ZrcTB2OVBHSm1IdDYyVWthOUJzN0F4MXNx?=
 =?utf-8?B?MVNQRFBhOWZUN3BnbXFLSDJmY1oxZHJHWmtKZlIvVkRkb3RkNE1zZmdTRWMz?=
 =?utf-8?B?OXVYYkQ0em1WdDFwZmZoNXh6byttellLYUMycUhoVkNjMjdwS3BwT0E1Sldq?=
 =?utf-8?B?UEVQcjNqT0N1c25GOXpXYk4zWHRSNEJmanRaQWo3azcyK2xUL2g1SGlPekxm?=
 =?utf-8?B?NUlzcGw3VGk4SGRibi9tL1k2S0wraHZyTklwMUNPd2Y0ZzQvck8zWFNNZlF0?=
 =?utf-8?B?RUhnNUtBTDhIMThPcUM5YzZUVm16T0YrTHMvUUttSUltZnNYSTNpQTlrcFBZ?=
 =?utf-8?B?WUhuYXZ6L2d3bmNoLzNGOEVWeFlUMHloMHZ2eG1JVGRCU29KazI1V0Zabkxv?=
 =?utf-8?B?TzV0SUlKOWtqMU4xYTJPcUNEdzB4WUF0NkhidkwwWTdGQ2VnN0dZWHVONFVO?=
 =?utf-8?B?ZjBMR0I2cHgvYmN0TTRMSEpmRFJCQldhem02YVR0cnY3U29kQ3RjeGVKRFJM?=
 =?utf-8?B?M0JBVVhZSEZZT09BZW9DLzkrMlIzOExFN1B3OUQ0VlVyMXBZTXFYRzh2dVdl?=
 =?utf-8?B?SnlzOGlpUzZ6NFovZi9mcDNSREk1UVdQYndyeHkralZXTy95QVpuRitjUUwy?=
 =?utf-8?B?RnNDSk5VQ0xKYUl1Ym00SnJEU3FpUFU4K3NXdWE1NDM1V1JXRlBGSW9FbHhw?=
 =?utf-8?B?dklYQmhGRTgvdkJ0Qkt4emNVSXRrdUQvTGh6aCs0R1Q5dGtaTUhnZmNGMDFn?=
 =?utf-8?B?Q2xaTE53MTR3anRlb2tsbHBhMG9acVI1VjRsZG9WbkpKWTV0aHhDa1BuT2Jj?=
 =?utf-8?B?V0poQXl4WEJDSnRRWXl1L3FiV25hSS9WS0p6S0FqeGNscWNFYnVTUW93PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UEo1ZGZnMlJZN1F3UG81Sk5nODVWOVYrSnNYZGtTaGxIaVFBSHg1RzFXd1py?=
 =?utf-8?B?TXU1VFRwT0JBSjZnODlCb1IvMSt3MkFMbnVtSlN3UlMxQzN5dEhIekdxejds?=
 =?utf-8?B?YlZzWWhJemxTdis2aGtqeHR5aG1SWDNRZTB1RDFDbEhDTGlUR2JtVi9WelRK?=
 =?utf-8?B?VWcveiswc1YxekNYbDZxbE80QzM4ZUJ0RWJOWEM4L1Z5TElJZ1V3citoSGVs?=
 =?utf-8?B?Ukx1KzYwdW1xQk5ERVlleGpKQzd2cGxEZVZZZ2djYWx2cWkzWkdMUmhKcFRX?=
 =?utf-8?B?Sy9aUkhtaUpNd1JlR1hUMFJLUHN0a1YrMXYxWTFVR2JUL1hwa01yM1oxeStL?=
 =?utf-8?B?YUJDWXBGcmIrWENqMUhSTVY5emZhZTZWTjJJTzZjdW9WdkxIYlo5NXp2Sklm?=
 =?utf-8?B?b1Z0T3lXTlljMGp4bTRNYTZOcFo3MThtdDd2OHU1TFJsNFdUUnRPbExFNkZZ?=
 =?utf-8?B?VGJyTmQrZVhyeDZFZThGdVlXTmN2VkJSNFI2ZUtlaExKMjJJbTJvekdmT2ZV?=
 =?utf-8?B?NXNGNTRkRElBRWttcWxHMkdjZG9CMEpGYXMvalU5VkI4VXNrcWNQV0V6Sjcr?=
 =?utf-8?B?eW9TNDZOdWZIZ2loTHpIbjJhVHZrd2ZaTVltZW1OblBrZVpVREVtSXNxcHhM?=
 =?utf-8?B?b2NVZXRPWU4za0NFODhKSjZSS3Nnb3U5MSs1OUZEYXh5cEcrT1lFeWV6TFo5?=
 =?utf-8?B?V1RadEhmVHZuSDVNWWE2dElzaUl5RllnckhvT0FJN0gxZFFrTzdiZ01YWHJk?=
 =?utf-8?B?alIvb1ZJbGJuUjA5Uk9PZmo5Z2tHcXJOOHg3SUJJQy8zL3NNbG9XQWVJSkpv?=
 =?utf-8?B?VTE0M0Q5dHJlWUY4MzFWS0Nhc2xocnBqcUFVOHZXWDNMdnRFWi9PMTZOK1V1?=
 =?utf-8?B?aUlNUmkyYUZEYTkxcnE2SlhvVDZIbVdIMWNncUZwUGwyV3JXbU1WZzNaNXYz?=
 =?utf-8?B?YTJRMFp1Y04valJzaTVBL2d0d0RyOWdKVmRLVlc3eGFEcmREWGxGWE1NZlZ4?=
 =?utf-8?B?WjdVZ0h0cXNVbEZuSi9tRmVEdjJjSFkxdXMzQ0pwcVkycjlkYUplREhieWxq?=
 =?utf-8?B?S3NYMnVVRUpFVCtSMjRCVm9DMElKdml2VkhVVExSV1NnSVpiR3cyRFdQbWpa?=
 =?utf-8?B?QUFSZ2FERnQ4aXJQRmtJa2dSOE1JZHFqMGtGQnBpYlducmVsbFNiK2hJY2tD?=
 =?utf-8?B?Vk5Cbk9uUW9Oc2JSVDRUWXNKWWNlMHVpNW9nQldQSXFFQnB6SE9ncWRhSkhP?=
 =?utf-8?B?NGhucmZtOFkrSWRYV2NuSkdLUUZ1aFcrWDJ6V2gxYjdlQm5lcDN3RmFRd3NF?=
 =?utf-8?B?TDNRd2JDSDdycnlPSitZVDl6YUhPYUpEeWxwdmJUZG8xVXMyQlRtaUNVT0or?=
 =?utf-8?B?ZXB6QzVRRWpWTTRZZy9OTUZxQjIzNFRFN3grRmd3eTBYMFczNEZ3S3R1K2Q4?=
 =?utf-8?B?dVozNHlObFZad1B0Q2RYaEM3VnJuV0ZQbXZ4cExBVy9rZGU3SXNQVHFpZXoz?=
 =?utf-8?B?aFR0aCtLY21EVmpoS20wOXpqOXV2SVo3V3VJZTJQb0M5dWJPRXArcmRWNk1H?=
 =?utf-8?B?NzJkL1hJTjY2ODdNMzlXVk9NemFsZkJ3YldQOWxFRDA0b3djeUNpTC9CcXgy?=
 =?utf-8?B?SE1YZ0JWTEZ6bEdlQ251VDl5R3JkTEptbmlzUndUb1QrQ1VhNVYzTlVLNXlS?=
 =?utf-8?B?Tkt5SEUyMVp0d0lEVzdLbXFKUXBRVVdmSWtkcXk5MnZRL0pnWVFyWktYYlVp?=
 =?utf-8?B?Q0hOOVV0d3BvVGpUeC9hUUdIS01UYUVNL3Q1akcxNVZUQW5XVUE4dUJRYW43?=
 =?utf-8?B?OTVrTGUyYVU0OXkraWNyOVBNZ21DaVhBVVF3OGJzaWpqQ3lpQ2srNjEyS0Uv?=
 =?utf-8?B?TWdoL0VrR2QrQVBnNUVXV1AwTTZETEhrZlBZdDlwc1kyaC9zbm00ZDdBK2V4?=
 =?utf-8?B?ZzhFVkw4TlBGY29raHg2bFpmYnJiL2Vxby9oY0tpb1RscE5CRG9jcVFVSHJV?=
 =?utf-8?B?Mm41Sk0wNVdOakxvWFZPZE81cXQwclpXMjBRbk50aDlET2dnaFhlMmNMU2c2?=
 =?utf-8?B?TUljWXhaOGdOMkI0ak9YY3A1Yit0T2VYZjQyLy9VVnJreGJBaExKRlVzMFVS?=
 =?utf-8?B?WkQzOGhCUGpsNUFTN09iZEcvRWZvVUVEK2QybmVsWU43ckhieURqVSs2am9V?=
 =?utf-8?B?THc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C152276CB14ECD4FBFB1D47D2D7DCA61@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FUospzcr2PuTc7vXHf267dWjGd8ypGEsz+m4W5kuZmYlBkltZTsCuMk8YVS3fi+gxeT9tg+CBu3jZi5xnfMjyy6mgvlT44l0i+6bjKqCcdqhCoQErHVVRDWNQ+D61SfVaM61cQ/dL1TvqBDMlbnIMHeldplCvo14LsjL4su2qF2+xh4RrbNimNK0HJSNcB4uagpiI0+kyHXL+sIBlaCd3qz/a2gz9aJJGLX5qDWT6+KLqWXUXnRnSbNXaYQpTtCl6sCR5EVLbJOy4ZO9yczbdzY1kM4Cd9GvnCtHII3f3yQRsaRq5p9Rjc4MWc4I5S2ZtTULVFT2t74eb7ukTJUdaFaXz9sE/H4Ik/tsRb32IVpzq7qR45c0KwM2x+1nHAliznVpXpzTZrjuk8f2/FbmajaYT6PPN9mxzqCDjq4GXv++AsaPST2t/WrDOGkU0SRpjaFDDvKCnJaiTiR6Th1nuziqVt7VM9uoYMpdxdAcb1gelUX6StQOGQF39ztTpUdatiaD7SbNzG3/wNW5+1Ja+lSRRiaLkFOhEXsJEmS9BVUicxe+J2GRAn2lWXDCF3qiVS6cRb9/XMkx19cWaddCMk7Uyy3LIGOf3h5oRaroY0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4c0198-8ee0-4ed2-30c6-08dc6579f792
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 22:49:29.8450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0BneaVx8SqvUVyG9N/9QR9G2hNS0/OYfgFiQcDrrZnrU2RPuElQacxeXoRxah3gbo6RTbwO5LzWCb6eQg05PVWjrMig3uesedOf5AzV1us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250167
X-Proofpoint-GUID: UVnveqKpygN2kPknW2MoWnJfStmJ4mYk
X-Proofpoint-ORIG-GUID: UVnveqKpygN2kPknW2MoWnJfStmJ4mYk

DQoNCj4gT24gQXByIDI1LCAyMDI0LCBhdCAyOjA14oCvUE0sIGplZmZ4dUBjaHJvbWl1bS5vcmcg
d3JvdGU6DQo+IA0KPiBGcm9tOiBKZWZmIFh1IDxqZWZmeHVAY2hyb21pdW0ub3JnPg0KPiANCj4g
T24gMy8yMS8yNCAxNDo1NiwgQXJ1bmEgUmFtYWtyaXNobmEgd3JvdGU6DQo+PiBFbmFibGluZyBi
b3RoIHRoZSBub24temVybyBwa2V5IChmb3IgdGhlIHRocmVhZCkgYW5kIHBrZXkgemVybyAoaW4N
Cj4+IHVzZXJzcGFjZSkgd2lsbCBub3Qgd29yayBmb3IgdXMuIFdlIGNhbm5vdCBoYXZlIHRoZSBh
bHQgc3RhY2sgd3JpdGVhYmxlDQo+PiBieSBhbGwgLSB0aGUgcmF0aW9uYWxlIGhlcmUgaXMgdGhh
dCB0aGUgY29kZSBydW5uaW5nIGluIHRoYXQgdGhyZWFkDQo+PiAodXNpbmcgYSBub24temVybyBw
a2V5KSBpcyB1bnRydXN0ZWQgYW5kIHNob3VsZCBub3QgaGF2ZSBhY2Nlc3MgdG8gdGhlDQo+PiBh
bHRlcm5hdGUgc2lnbmFsIHN0YWNrICh0aGF0IHVzZXMgcGtleSB6ZXJvKSwgdG8gcHJldmVudCB0
aGUgcmV0dXJuDQo+PiBhZGRyZXNzIG9mIGEgZnVuY3Rpb24gZnJvbSBiZWluZyBjaGFuZ2VkLiBU
aGUgZXhwZWN0YXRpb24gaXMgdGhhdCBrZXJuZWwNCj4+IHNob3VsZCBiZSBhYmxlIHRvIHNldCB1
cCB0aGUgYWx0ZXJuYXRlIHNpZ25hbCBzdGFjayBhbmQgZGVsaXZlciB0aGUNCj4+IHNpZ25hbCB0
byB0aGUgYXBwbGljYXRpb24gZXZlbiBpZiBwa2V5IHplcm8gaXMgZXhwbGljaXRseSBkaXNhYmxl
ZCBieQ0KPj4gdGhlIGFwcGxpY2F0aW9uLiBUaGUgc2lnbmFsIGhhbmRsZXIgYWNjZXNzaWJpbGl0
eSBzaG91bGQgbm90IGJlIGRpY3RhdGVkDQo+PiBieSB0aGUgUEtSVSB2YWx1ZSB0aGF0IHRoZSB0
aHJlYWQgc2V0cyB1cC4NCj4+IA0KPiBXZSBoYXZlIGEgc2ltaWxhciB0aHJlYXQgbW9kZWwgdGhh
dCB3ZSBkb24ndCB3YW50ICJ1bnRydXN0ZWQgdGhyZWFkcyIgdG8NCj4gYWNjZXNzIGFsdHN0YWNr
LiBJIHRoaW5rIHRoaXMgcGF0Y2ggbmVlZCBub3QgYmUgcmVzdHJpY3RlZCB0byB0aGUNCj4gdXNl
IGNhc2Ugb2YgemVybyBwa2V5IGZvciBhbHRzdGFjaywgaS5lLiBhcHBsaWNhdGlvbiBjYW4gYWxz
byBzZXQNCj4gbm9uLXplcm8gcGtleSB0byBhbHRzdGFjayBhbmQgZXhwZWN0IHRoZSBzYW1lLg0K
DQpBZ3JlZWQuIEluIHRoZSBsYXRlc3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoc2V0LCB0aGlzIGFz
c3VtcHRpb24gaGFzIGJlZW4gcmVtb3ZlZC4NCg0KTGluayBoZXJlOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC8yMDI0MDQyNTE4MDU0Mi4xMDQyOTMzLTEtYXJ1bmEucmFtYWtyaXNobmFA
b3JhY2xlLmNvbS9ULyN0DQoNCj4gDQo+PiBTb2x1dGlvbjoNCj4+IFRoZSBQS1JVIHJlZ2lzdGVy
IGlzIG1hbmFnZWQgYnkgWFNBVkUsIHdoaWNoIG1lYW5zIHRoZSBzaWdmcmFtZSBjb250ZW50cw0K
Pj4gbXVzdCBtYXRjaCB0aGUgcmVnaXN0ZXIgY29udGVudHMgLSB3aGljaCBpcyBub3QgdGhlIGNh
c2UgaGVyZS4gV2Ugd2FudA0KPj4gdGhlIHNpZ2ZyYW1lIHRvIGNvbnRhaW4gdGhlIHVzZXItZGVm
aW5lZCBQS1JVIHZhbHVlIChzbyB0aGF0IGl0IGlzDQo+PiByZXN0b3JlZCBjb3JyZWN0bHkgZnJv
bSBzaWdjb250ZXh0KSBidXQgdGhlIGFjdHVhbCByZWdpc3RlciBtdXN0IGJlDQo+PiByZXNldCB0
byBpbml0X3BrcnUgc28gdGhhdCB0aGUgYWx0IHN0YWNrIGlzIGFjY2Vzc2libGUgYW5kIHRoZSBz
aWduYWwNCj4+IGNhbiBiZSBkZWxpdmVyZWQgdG8gdGhlIGFwcGxpY2F0aW9uLiBJdCBzZWVtcyB0
aGF0IHRoZSBwcm9wZXIgZml4IGhlcmUNCj4+IHdvdWxkIGJlIHRvIHJlbW92ZSBQS1JVIGZyb20g
dGhlIFhTQVZFIGZyYW1ld29yayBhbmQgbWFuYWdlIGl0DQo+PiBzZXBhcmF0ZWx5LCB3aGljaCBp
cyBxdWl0ZSBjb21wbGljYXRlZC4gQXMgYSB3b3JrYXJvdW5kLCB0aGlzIHBhdGNoIGRvZXMNCj4+
IHNvbWV0aGluZyBsaWtlIHRoaXM6DQo+PiANCj4+ICAgICAgIG9yaWdfcGtydSA9IHJkcGtydSgp
Ow0KPj4gICAgICAgd3Jwa3J1KGluaXRfcGtydSAmIG9yaWdfcGtydSk7DQo+PiAgICAgICB4c2F2
ZV90b191c2VyX3NpZ2ZyYW1lKCk7DQo+PiAgICAgICBwdXRfdXNlcihwa3J1X3NpZ2ZyYW1lX2Fk
ZHIsIG9yaWdfcGtydSkNCj4+IA0KPiBUaGUgZGVmYXVsdCBQS1JVIG9mIHRocmVhZCBbMV0gaXMg
c2V0IGFzIDAxIChkaXNhYmxlIGFjY2VzcykgZm9yIGVhY2ggUEtFWQ0KPiBmcm9tIDEgdG8gMTUs
IGFuZCAwMCAoUlcpIGZvciBQS0VZIDAuDQo+IA0KPiBMZXQncyB1c2UgcGtleSAxIGFzIGFuIGV4
YW1wbGU6DQo+IFRoZSBpbml0X3BrcnUgaXMgMDEsIGlmIHRoZSB0aHJlYWQgaGFzIFBLUlUgKG9y
aWdfcGtydSkgYXMgMTAgKGRpc2FibGUgd3JpdGUNCj4gYnV0IGhhdmUgcmVhZCkgdGhlbiBuZXdf
cGtydSBmcm9tIChpbml0X3BrcnUgJiBvcmlnX3BrcnUpIGlzIDAwLCB3aGljaCBnaXZlcw0KPiBS
VyBhY2Nlc3MgdG8gdGhlIHBrZXkgMS4NCj4gDQo+IFdoZW4gdGhlIHRocmVhZCBoYXMgb3JpZ19w
a3J1IGFzIDAxIChkaXNhYmxlIGFjY2Vzcykgb3IgMDAgKFJXKSwgbmV3X3BrcnUgaXMNCj4gdW5j
aGFuZ2VkIGZyb20gb3JpZ19wa3J1Lg0KPiANCj4gTm93IHRha2UgcGtleSAwOg0KPiB0aGUgaW5p
dF9wa3J1IGlzIDAwLCByZWdhcmRsZXNzIHdoYXQgdGhyZWFkcyBoYXMsIG5ld19wa3J1IHdpbGwg
YWx3YXlzIGJlIDAwLg0KPiANCj4gVGhpcyBzZWVtcyB0byB3b3JrIG91dCB3ZWxsIGZvciBwa2V5
IDEgdG8gMTUsIGkuZS4gc2lnbmFsIGhhbmRpbmcgY29kZSBpbg0KPiBrZXJuZWwgb25seSBnaXZl
IHdyaXRlIGFjY2VzcyB3aGVuIHRoZSB0aHJlYWQgYWxyYWR5IGhhcyByZWFkIGFjY2VzcyB0byB0
aGUNCj4gUEtFWSB0aGF0IGlzIHVzZWQgYnkgdGhlIGFsdHN0YWNrLiBUaGUgdGhyZWF0IG1vZGVs
IGludGVyZXN0aW5nIGhlcmUgaXMgdG8NCj4gcHJldmVudCB1bnRydXN0ZWQgdGhyZWFkcyBmcm9t
IHdyaXRpbmcgdG8gYWx0c3RhY2ssIGFuZCByZWFkIGlzIHByb2JhYmx5IGxlc3MNCj4gb2YgYSBw
cm9ibGVtLg0KPiANCg0KVGhpcyBwaWVjZSBvZiBjb2RlIGFzc3VtZWQgdGhhdCB0aGUgaW5pdCBQ
S1JVIHZhbHVlIGFsbG93cyB3cml0ZXMgdG8gdGhlIGFsdGVybmF0aXZlDQpzaWduYWwgc3RhY2su
IEFzIHlvdSBtZW50aW9uZWQgZWFybGllciwgdGhhdCBtYXkgbm90IGFsd2F5cyBiZSB0cnVlIC0g
YSBub24temVybyBwa2V5DQpjYW4gYmUgdXNlZCBmb3IgdGhlIGFsdHN0YWNrLg0KDQpTbyB0aGUg
bmV3IHZlcnNpb24gc2ltcGx5IGRvZXMgd3JpdGVfcGtydSgwKSAoaS5lLiBlbmFibGVkIGFsbCBw
a2V5cykgYmVmb3JlIFhTQVZFLg0KSXMgdGhpcyBtb3JlIHJlYXNvbmFibGU/IA0KDQo+IA0KPiBE
b2VzIHRoaXMgbWVldCB3aGF0IHlvdSB3YW50PyAoTm90ZSB0aGUgcGtleSAwIGlzIGRpZmZlcmVu
dCB0aGFuIDEtMTUpDQo+IA0KPiBTdXBwb3NlIHNvbWVvbmUgYWxzbyBsaWtlIHRvIGRpc2FibGUg
YWxsIGFjY2VzcyB0byBhbHRzdGFjaywgdGhlbiB0aGVyZSBpcyBvbmUNCj4gbW9yZSBwbGFjZSB0
byBtaW5kOiBpbiBzaWdyZXR1cm4oKSwgaXQgY2FsbHMgcmVzdG9yZV9hbHRzdGFjaygpLCBhbmQg
cmVxdWlyZXMNCj4gcmVhZCBhY2Nlc3MgdG8gYWx0c3RhY2suIEhvd2V2ZXIsIGF0IHRoZSB0aW1l
LCBQS1JVIGlzIGFscmVhZHkgcmVzdG9yZWQgZnJvbQ0KPiBzaWdmcmFtZSwgc28gU0VHViB3aWxs
IHJhaXNlICh0aGUgdmFsdWUgaW4gc2lnZnJhbWUgZG9lc24ndCBoYXZlIHJlYWQgYWNjZXNzDQo+
IHRvIHRoZSBQS0VZKS4NCj4gDQo+IFdpdGhvdXQgY2hhbmdpbmcgc2lncmV0dXJuLCB1c2luZyB3
cnBrcnUoMCkgaGVyZSBtaWdodCBub3QgYmUgbmVjZXNzYXJ5Og0KPiB0aGUgZGlzcGF0Y2ggdG8g
dXNlciBzcGFjZSB3b3JrcyBmaW5lLCBvbmx5IHRvIGNyYXNoIGF0IHNpZ3JldHVybiBzdGVwLg0K
PiANCj4gWzFdIGRlZmluZWQgYnkgaW5pdF9wa3J1X3ZhbHVlIGluIHBrZXlzLmMNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gLUplZmYNCg0KDQpJIHNlZSB3aGF0IHlvdSdyZSBzYXlpbmcuIEluIHJ0
X3NpZ3JldHVybigpOg0KDQogICAgICAgIGlmICghcmVzdG9yZV9zaWdjb250ZXh0KHJlZ3MsICZm
cmFtZS0+dWMudWNfbWNvbnRleHQsIHVjX2ZsYWdzKSkgPOKAlCByZXN0b3JlcyBQS1JVLCBkaXNh
YmxpbmcgYWNjZXNzIHRvIGFsdHN0YWNrDQogICAgICAgICAgICAgICAgZ290byBiYWRmcmFtZTsN
Ci4uLg0KICAgICAgICBpZiAocmVzdG9yZV9hbHRzdGFjaygmZnJhbWUtPnVjLnVjX3N0YWNrKSkg
POKAlCBuZWVkcyByZWFkIGFjY2VzcyB0byBhbHRzdGFjaw0KICAgICAgICAgICAgICAgIGdvdG8g
YmFkZnJhbWU7DQogDQoNCknigJltIHdhcnkgYWJvdXQgcmVvcmRlcmluZyBhbnl0aGluZyBpbiBo
ZXJlLiBBbHNvLCB0aGlzIGNvZGUgaXMgbm90IGF3YXJlIG9mIHRoZSBhbHRzdGFjayBwZXJtaXNz
aW9ucy4gSeKAmW0gd29uZGVyaW5nIGlmIHdycGtydSgwKSBpcyBuZWVkZWQgaGVyZSB0b28uDQoN
ClRoYW5rcywNCkFydW5hDQoNCg0K

