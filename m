Return-Path: <linux-kernel+bounces-146046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F868A5F61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED181F21E55
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93541C32;
	Tue, 16 Apr 2024 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qLHDxY0h";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EXQR1gGB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ucti/EAx"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D0179C4;
	Tue, 16 Apr 2024 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713228271; cv=fail; b=XSYk/SSZA8Z6itXouQnaw8m5tzYDuekBX1xtgEfUJXQx+GDwVtV9XrsnUyg0h4MnXNS0tpoLdSaHwUDAGs4ZEz+vukFrwxwCdBCgRDJCmG+6lDu3w0rqEka6WEL6ACS9SLaANrjLDBjg8mecrcAKlM1UbA6hJXQJF3KvECPv4zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713228271; c=relaxed/simple;
	bh=oMD2gSE9VI/Um6hnfU10KJlf0N0xW4V1rauqpDvBLmk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DcgyN4TIkJD5Dqjg2SOtA7AunQbI4reAIud3bhBGTx9JASAZcweSIOBVAsf491E7IpzXdkPs9gx21A3+6hBeuw+tZ/t+65nrqfpkmDtRaVHAyp9tuQLbmPudfl8AJjSD2b9/AZ+N5DhsPfoCfqMn/8EhrUkhIn4njoZCA5ZqzwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=qLHDxY0h; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=EXQR1gGB; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ucti/EAx reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43FKXpj8016993;
	Mon, 15 Apr 2024 17:44:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=oMD2gSE9VI/Um6hnfU10KJlf0N0xW4V1rauqpDvBLmk=; b=
	qLHDxY0hyuJecxSqrXxEqF0StciRhT+YPaKzuxFiKDoSGarN+HOjQT2D+6T4Oksg
	8HNoLIOJXKJSyGytAnVwTKHlRLIOjhFwa/XVlpLWCRDW3P4/1tvBoo4QbJpU6hEO
	Se/kXR0uZn1uxcUF1UsQVDgkBe0AhzbS7pq9YdjxgSq3bcypn+qwKQQVgd9YR3u4
	9o3BKlNERSCAoxyvezDJqU67+XSBrm43kv2ISWU6T2IIyjWeLlGGqnJOV2MU6moy
	YmoRSFVa6SH4kbxcI4DWjNwEdswYiLxNJ4Liw9CeP7phDCIFZQQiJ8N0+6mqCoZR
	8zBvdChTfZm+llfVLmOp/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xh7h6swm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 17:44:16 -0700 (PDT)
Received: from m0297265.ppops.net (m0297265.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 43G0g0JS007750;
	Mon, 15 Apr 2024 17:44:16 -0700
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xh7h6swm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 17:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1713228254; bh=oMD2gSE9VI/Um6hnfU10KJlf0N0xW4V1rauqpDvBLmk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=EXQR1gGBlGEuQMHg9hVB5RZBnL/6HAiORVUNTDoGO+NTXGL9rq+imjMeS3fQIOCIt
	 IZobggNqR7VvgqHSLhN7UU7aaqUUswk+T9ein1jSOYa3sgp5CVyQVTpzrZnEX4GH63
	 ywDneiaRG5VaZ7JySvEQqRUMEeHbHXN1uN5WBuXM59A3OFALT4uKA/BS9YEQvesv6F
	 SvFpBkxdakKzUriNg1uo0DuJz5YEQlRxcZAmAPBBKvhtB1sfn6Klk9GAlYjNYZqh2V
	 M5WR14JeOO3z0jy5VF4Y8uzc81+V8vZEJaT2hOFaur4OokzfZ7VMvKtLkrWpeIodeC
	 PPaMqmcIa83xA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DBDBA4048E;
	Tue, 16 Apr 2024 00:44:12 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id A4566A0063;
	Tue, 16 Apr 2024 00:44:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=ucti/EAx;
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 3BF7740349;
	Tue, 16 Apr 2024 00:44:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyMINGXmf0HxSSjeQ9leEdYYIZmu85qLcxTAwrR4CxS3fkbX511RtNXeJbj+7YcrYoxNZxjbjbH113MwqBErvY3WI3ynmDRftjVz11SU2ZVOKpzJvnMuazFr6N9ipNCwoF3+uprh1M/jJ3VVpeOUlI19cDfBvv88hyNb6qqpa9E+yTMaCSDIIyz5253hfEqKHRlOucBAdfwzBUx5XbpePJLBRtTVCalrkVSeURcOLncutWY6RFrqVYBN7SJfV5uXLg1oXSYQb1BmjaTcsU7D3tPKFlNYyiVMHoKOPphQhifC6IQIo4vf46Z61Y7GFYiDxluum+6qZP3v2u/oBCpFTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMD2gSE9VI/Um6hnfU10KJlf0N0xW4V1rauqpDvBLmk=;
 b=j00o8N354YJiE44HmNezic3RemaEWeFnZGzh2YYu62v0+h/RwtH88oMFc4S/Yx3mHmUPZSCZNKA0xKtX/dwR263qll8xWxjLjoxgg21aicBrxmXFSNZ+gJW0HHNHjd/0/DzrUpgiu1M2zcRZYU+FmETdl1i/ZVNSmWadQB4Z+Ko342aQ0mfFZozM/r+DMlCYrJkTAV7MHSj+HD6aJDVBk+u/hRvIEX+P37Jj425ixuE1cKtLvBIaabua9Uu37hJ65JeYybH58f0exdBl3gGJ0XOQzi425EFynFOU8B9Ov+Ap/7/PURSrjI5B/skb7acrvfcC5SdEqK5oHYYCOKzulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMD2gSE9VI/Um6hnfU10KJlf0N0xW4V1rauqpDvBLmk=;
 b=ucti/EAxe1PLwOlGvUPML7bz4mdtvJgz9gUlJV6Y42uzDuw+E5zcdPlnsMWYiInqVrOIyGqMxpFdiNkmiLBv6dg3NLCjQjuRCxgBhCtiJHX0Q3JJJfCsGB7pEeaEPJGRtMlu7VIGirbAkTTQwNsjJSVYX+nKbNgbCtx/mNoW6jc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by MW4PR12MB7015.namprd12.prod.outlook.com (2603:10b6:303:218::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 00:44:05 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 00:44:05 +0000
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
Subject: Re: [PATCH v3 5/5] usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
Thread-Topic: [PATCH v3 5/5] usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
Thread-Index: AQHajOUak6Mi/XXmr0ysc+v21QUeEbFqESGA
Date: Tue, 16 Apr 2024 00:44:05 +0000
Message-ID: <20240416003145.izkwh5kc5sqy4irf@synopsys.com>
References: <20240412142317.5191-1-linux.amoon@gmail.com>
 <20240412142317.5191-6-linux.amoon@gmail.com>
In-Reply-To: <20240412142317.5191-6-linux.amoon@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|MW4PR12MB7015:EE_
x-ms-office365-filtering-correlation-id: f9fd0a72-7b07-432d-a050-08dc5dae519e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mMaAQF3k3i8nf8rBJWWw7HOzPnjL3y5D+0DiNKrXh5UAEU7G0ccjVa9KV7YBz03q/26r5bETVKmlsebRFgLIA4/Vc0rmQbBV41oYnE+yKaek9PYJfzHn8xkRVpSBTc9X/ceXMJmNdYPsEehvjl8nz3o0vj8u2PSuT53oy/hKxIjdujpXkyKPlR+QShMSD9o6SINdOF50YlB7eHAQWs6i0mEXtOQeTSB7cdMQpr8ufbkeNJkyZIKLwMyueuV/+NymPscXHAQ4aCR2jc2glKxyeNKNxKyedTlDJFkqx2025xln7lWiwUCsI6ACZE0vfljTniUOESCDKH/cLEvorL1YW6fiuwpes4X89WVgTMTEUClzQ30zJJfEoUiGH3wxH1AM4aAvaUpNnjwoa6pJ1dOqI5csp+nx9nO834dodr5vL1HoF7hU3qEjPCa5pC1dIqUH9IzrzgJ+XbzV5L05JAvOeLN/xeq8eC/9XBUofY2lNXg0LoLJak7xUY6wfdLkyq2IkQ6yY+V0bMULvJnYIVZHL5NBV+NfdBtTzTezHHGrK/lKTvFxnBbnbnuLGllx1GeSZi9YMPLX7A0hStwwKzZCBrM4Zt5ZJEcNf7M4Q4jGgogWtWql34rxtigDUe+zW+06NKeLlKc0E4m+X8AYcFV6j7nC2fBFAfTsSqxfCPmnyEbTHwBg7Wxixg9CLqdr6/hBRTQ/nhNLtG29TDQ6bpAbfy9h1H0OjYnOJAih+kmsST4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?di8rb2h2TTFzOEV1cTBwV0lxTHkrZFdTeDBYeGU1dUtzbGxPSkFEUEJLRFRt?=
 =?utf-8?B?emUvS285QUlVdFRYQTBKdnpRblBWS3d3Tzk5YnZGdFV1L09xT0hHRVNnQVpP?=
 =?utf-8?B?a0lnLzlCNUV6ODI2dk1sbk9ycDZyUjRaN0F6SGNFaFUzSFhueVU0VVJmSXFv?=
 =?utf-8?B?NTQ2bURmdEhKbGhydEZOb0NFdUdnM2FGQUMzeXhaeXZuNGJwU3c3THBkcmtt?=
 =?utf-8?B?MmZrbld6azlqMU1HN2RNemQ1bnhPeFJ3TlZKOHdESG1VamdwSUF0SU44WE9j?=
 =?utf-8?B?WldiblRtc3BhQXFhajhFNnl6R1R3NlV3Y3VUUWN0YlM1VHBTY3pRSTdWbXVw?=
 =?utf-8?B?K01naEVvWWs5eFdCbXp0NWZNOGVPUmhEVDdqNUJXV1d6MEVURHUwbEtYZjg5?=
 =?utf-8?B?c3BGRGpETGxQZ29mNGRFek5tYkJKVDYrdXRMbkViVUV3dG94czh2QUd6aUMy?=
 =?utf-8?B?SlhMMHFCNE5aaXNMTml3RlkyQ3Q0bkRwWmY1WTRPL3NxR01adGY3SU9kSzlK?=
 =?utf-8?B?QldPSWtEaXd4MmxuYWpTOUc4dWlhK1JhTHg2OVJtR01Md0g2TmNYQnI2Z2F1?=
 =?utf-8?B?cTk1T1ZFdjRoOFlLazR1M1JCLy81L05CYUJ3OVBsQlZaNmJkRytKb25mRGpo?=
 =?utf-8?B?M2V5T1RnZkhKMlZwSytVTzRUWU92SUpDK3hlM1VyeCtlRjVZYXc5TnpCVWdh?=
 =?utf-8?B?ZXZ4M3l4Ris2RDg3dktmbmtBZ3BvTS9UYnRvVFdIdzkxRGkzT2ZTUEVic2lP?=
 =?utf-8?B?dmFzaHlFRXVvUVZ6bWZ1WmttTFdqNERUWGthM0tqbVpvV2hyWTY0YXNPNGdD?=
 =?utf-8?B?cThhTE9qWDFHVkRPVnUxM1ZyWFNUVTZVTEU3UU81K0J1eGNUWU1OWWw5NUZs?=
 =?utf-8?B?aHB6cTh2dHZMZHZMZlZmMWtJS1FXYWQxcUJ6RmZOUEdybmpwdHNaUUlzSVpK?=
 =?utf-8?B?TytFNDJxa3k2clhvbTVrcUNvTFBYWFVjV1dmRHlpZW9XWkZ1R3FsSCszTWhs?=
 =?utf-8?B?a1VpQ0R2L3JiMnQ0dGUwVWN0MTV3YytOL1JPbktWSnphN01EUklwcllHQkQ2?=
 =?utf-8?B?UVN5cll5MUVWejFNRFhHajNYalgwSUdlK09EVTh6ajNlaWkwZVo2M1Q0TWky?=
 =?utf-8?B?STBzVDV1VTFBTnBZYVZNLzdId3RwSFhGemJOaEowZEI3KzlML2ZwWTFIVjl5?=
 =?utf-8?B?UzBMTzZPRGZUVGhsNnBwRWVPcERNNlk4MFZvbDRVcVF5MUFxb2JhKy8yV0JS?=
 =?utf-8?B?RktWTlZTK1QzWmZmQnduVmo4Sm1BMnplNHZtQ3hocWhoOWZMRVFyNUV0ZHRw?=
 =?utf-8?B?cmJLT1dlM1MweFFVL0VrcUhZVkd3OUJPd2hLWGEwbnVnR2VqcFl4WDJlOVZV?=
 =?utf-8?B?dWREbWg0ajJyTU9MTjJwalZvLzdDVk4zZ3dsbTR2ZU5xanJNZVdjOUJXdkRY?=
 =?utf-8?B?VEdVWGZnRXpIZUpuNW0zSjlDTWRvSDdSN2RGVHBXSXBsck5KcHNna2Z6eVQ1?=
 =?utf-8?B?K2pZQ0tLN2tPTUR1dGd2d3h1NTMxVmVZRzNjOWx5cU5jS2dMeSs2ZGJTcGt1?=
 =?utf-8?B?ekNyNEM3dlF4ek50SW5UUU5DeFBzZUhIVUMxaC8vck42Q1FEc2pGY3I0L0tl?=
 =?utf-8?B?bjgvQmJXV014WTJYTFIreG94TmM4MzJMYVFnQWJxMXFxYXM5anNpbXJSRlZ5?=
 =?utf-8?B?WU1hNHhIa1RqOHhxcmdMdUNWaGFLVFJuNmNzNjhJdzJjRkZHZGRyVit1Q1hq?=
 =?utf-8?B?QjIzdkpZMWJEeVVNR3ppZVIvM04xdzEvb3VXb0FBeC9IUHZpbVJSNlI0Qy92?=
 =?utf-8?B?S1dVamdHd3BKbTRqS0hKN0hIWTI1cWJhN25FSjU1dTQ2Y24xMFI0dGZCd3Rz?=
 =?utf-8?B?MDFOcXlVbE9mOVQ2MFRCQjc1NFhSeHcyQjFRWGxLUmFnMzV6S0xCZUxkWjV3?=
 =?utf-8?B?QVZhcWRiRzNWQjhyN0xmczN6YnpIOExOOU50T1EraWtUQllVT0p4Uk9HYWxN?=
 =?utf-8?B?aDVDRW5yR1lGQy83bGxtVU9DTDdONzFrQi9DS3hlWVRTRDlzZHA4R1lLTTVN?=
 =?utf-8?B?VU5vVlVSSXdBcXlOK0ZmZ0xCN0pzS29YNzBaSmNOTUxaa0k4S1U2K2xuRGFr?=
 =?utf-8?B?TTlucEJNN0VvWnlDRk1LeFBIckk1R05hWG44TVlVUm1PTnNuRFAwcGpLUHpG?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F65E8C901041E64091570E3C60CFEF27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EoPRz75ujQSX8PxZ4trpZUF35ITyC2ueS7r0eFwBWH24lQ4Q00Mr0CCvwlwSetfDVIHr/L6jiWY9THF9SFRgSNvAwPe0EcAm0CouJ2bo4Yz+bsvfkodq0Y5+vzg0fTxG1wgKuoxIbKnXH6a8xHReWdCHx4qbRFezb/X2MlMU4wyGt+4AobfDiTeRPVkouRNcWsIMBXymsDh8RFlVN7rDv16mOm+W8H89f2KRUvzqJtum0qmPCRnJIBZ3iAMgf0b6pdrRYCS1zcYYgek1yAL5XkL2SFmUNM9lCKY/rAlzGK3lhIa7aIi28dfRiU/Cqa80Ao7IassURRA22N0QvqRk1J0ReqxsmmJlwaJrFYkvDBLKHnRTMfId8LAXi2pY1imZ1iDbV+sRlfHMHw8myeTB33jWkEIa6BGTyu6ZixEQSAI6YNUWztyjqIetDX+1QIWVsDoJgTefhWj+o9IGyF5307PM/LfRyO+HqU7yYpb576HUotS7z3u8Mgt6p5iHrAopSXtPUpW6ilAoR/pQ82/E8EQqp/Clv8pRf2+ROkfIaGVnoIzjgUuNtqspJjMM4dCXrRS4aIbSJYnhEHWQjcKdHq/ejJqOhQaDy8b0CwqCOtyxm9QRHG5eUxSlQD0nEGNX/ak+wVx0htKkMub558Wy2Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd0a72-7b07-432d-a050-08dc5dae519e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 00:44:05.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4w6ecarxX+dHqY7rCvrYAJv2rn/d0w2jauktoDiKVenDItar9ZTcF+APTcTgZCByMVJSyr0p38P8XomYmWxiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7015
X-Proofpoint-GUID: -xTuJGc_-glL3trm2suUVuZMLBAE5PkU
X-Proofpoint-ORIG-GUID: pohC-tXGK777CW00EZjXDQwFO3vB9g9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_20,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404160001

T24gRnJpLCBBcHIgMTIsIDIwMjQsIEFuYW5kIE1vb24gd3JvdGU6DQo+IFRoaXMgbWFjcm8gaGFz
IHRoZSBhZHZhbnRhZ2Ugb3ZlciBTSU1QTEVfREVWX1BNX09QUyB0aGF0IHdlIGRvbid0IGhhdmUg
dG8NCj4gY2FyZSBhYm91dCB3aGVuIHRoZSBmdW5jdGlvbnMgYXJlIGFjdHVhbGx5IHVzZWQuDQo+
IA0KPiBBbHNvIG1ha2UgdXNlIG9mIHBtX3NsZWVwX3B0cigpIHRvIGRpc2NhcmQgYWxsIFBNX1NM
RUVQIHJlbGF0ZWQNCj4gc3R1ZmYgaWYgQ09ORklHX1BNX1NMRUVQIGlzbid0IGVuYWJsZWQuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmFuZCBNb29uIDxsaW51eC5hbW9vbkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiB2MzogZml4IHVzaW5nIG5ldyBERUZJTkVfU0lNUExFX0RFVl9QTV9PUFMgUE0gbWFj
cm8gaGVuY2UNCj4gICAgIGNoYW5nZSB0aGUgJHN1YmplY3QgYW5kIHRoZSBjb21taXQgbWVzc2Fn
ZQ0KPiANCj4gdjI6IGFkZCBfX21heWJlX3VudXNlZCB0byBzdXNwZW5kL3Jlc3VtZSBmdW5jdGlv
bnMgaW4gY2FzZSBDT05GSUdfUE0NCj4gICAgaXMgZGlzYWJsZWQuDQo+IC0tLQ0KPiAgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLWV4eW5vcy5jIHwgMTMgKysrLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWV4eW5vcy5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWV4eW5vcy5jDQo+IGluZGV4IDVkMzY1Y2E1MTc3MS4uMzQyNzUyMmE3YzZhIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtZXh5bm9zLmMNCj4gKysrIGIvZHJpdmVycy91c2Iv
ZHdjMy9kd2MzLWV4eW5vcy5jDQo+IEBAIC0xODcsNyArMTg3LDYgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBvZl9kZXZpY2VfaWQgZXh5bm9zX2R3YzNfbWF0Y2hbXSA9IHsNCj4gIH07DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBleHlub3NfZHdjM19tYXRjaCk7DQo+ICANCj4gLSNpZmRlZiBD
T05GSUdfUE1fU0xFRVANCj4gIHN0YXRpYyBpbnQgZHdjM19leHlub3Nfc3VzcGVuZChzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzNfZXh5bm9zICpleHlub3MgPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsNCj4gQEAgLTIzMCwxNCArMjI5LDggQEAgc3RhdGljIGludCBkd2Mz
X2V4eW5vc19yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0K
PiAgDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgZHdjM19leHlub3NfZGV2X3Bt
X29wcyA9IHsNCj4gLQlTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhkd2MzX2V4eW5vc19zdXNwZW5k
LCBkd2MzX2V4eW5vc19yZXN1bWUpDQo+IC19Ow0KPiAtDQo+IC0jZGVmaW5lIERFVl9QTV9PUFMJ
KCZkd2MzX2V4eW5vc19kZXZfcG1fb3BzKQ0KPiAtI2Vsc2UNCj4gLSNkZWZpbmUgREVWX1BNX09Q
UwlOVUxMDQo+IC0jZW5kaWYgLyogQ09ORklHX1BNX1NMRUVQICovDQo+ICtzdGF0aWMgREVGSU5F
X1NJTVBMRV9ERVZfUE1fT1BTKGR3YzNfZXh5bm9zX2Rldl9wbV9vcHMsDQo+ICsJCQkJZHdjM19l
eHlub3Nfc3VzcGVuZCwgZHdjM19leHlub3NfcmVzdW1lKTsNCj4gIA0KPiAgc3RhdGljIHN0cnVj
dCBwbGF0Zm9ybV9kcml2ZXIgZHdjM19leHlub3NfZHJpdmVyID0gew0KPiAgCS5wcm9iZQkJPSBk
d2MzX2V4eW5vc19wcm9iZSwNCj4gQEAgLTI0NSw3ICsyMzgsNyBAQCBzdGF0aWMgc3RydWN0IHBs
YXRmb3JtX2RyaXZlciBkd2MzX2V4eW5vc19kcml2ZXIgPSB7DQo+ICAJLmRyaXZlcgkJPSB7DQo+
ICAJCS5uYW1lCT0gImV4eW5vcy1kd2MzIiwNCj4gIAkJLm9mX21hdGNoX3RhYmxlID0gZXh5bm9z
X2R3YzNfbWF0Y2gsDQo+IC0JCS5wbQk9IERFVl9QTV9PUFMsDQo+ICsJCS5wbQk9IHBtX3NsZWVw
X3B0cigmZHdjM19leHlub3NfZGV2X3BtX29wcyksDQo+ICAJfSwNCj4gIH07DQo+ICANCj4gLS0g
DQo+IDIuNDQuMA0KPiANCg0KQWNrZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5
bm9wc3lzLmNvbT4NCg0KVGhhbmtzLA0KVGhpbmg=

