Return-Path: <linux-kernel+bounces-160711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8D8B4171
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34B92825AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C4A3BB38;
	Fri, 26 Apr 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZZnUC/2r";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mUB+FMs3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P56+K7G2"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907B3B297;
	Fri, 26 Apr 2024 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714167594; cv=fail; b=j9ZiE5F3eKwubOKSg4ks8ST2zGRQzmHTgDvDMzwfYaEFil5w8BSZ0MdhipAUTIRsHKhVoEkDd6WAsbGPoJXEusYG1z3XXOA6mOrXY4lspmfeo+WXwZcyg0jbDT33MgdzLS4f+Afnxv5HyqayMTWmt8ZTahlZBOHD1rjjnaVJ9sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714167594; c=relaxed/simple;
	bh=xmNAJ9u+XYbDhnAwiNunWQmfpfW0x38Z+8z3XMgCtGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MKJKoOnKfILGlRr/Jqc1couEYERZzs63VjAqI2AsJYg49pbgUIjlA0m3lDzWTV2WrdQtntMgYr786+gIWzRWFgKbrQQGpZb7BO4RCeuVEpyP5HL1Or3/XSvnJYZ7n2aAiroia9QwjMWxYKoGQHqY2a8FyphGBMrHSUei5cBVb6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=ZZnUC/2r; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=mUB+FMs3; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=P56+K7G2 reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QGO1AU002098;
	Fri, 26 Apr 2024 14:39:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=pfptdkimsnps; bh=xmNAJ9u+XYbDhnAwiNunWQmfpfW0x38Z+8z3XMgCtGg=; b=
	ZZnUC/2r4x1tpMCHQ6YGEqiY2+xJT3GDG7pB9x84p7wyRgA5n+vc76+C2tNDGnwf
	TSTrfAc59Tpql2gdSYul+cndPz1ijQOZz8NEi+3zgIjgLst6Q6Kwzz9d44dF0oHr
	gQhDT+U/rNG1fBV466fcR9fgaX5Z/JfcA6BNiLTx/tFIND3PH5BrJsspUFSQML44
	NSfnp23oOfVhn1JbPNTfFcXTAJ13OvqHJ84j7PQ758q+B/D6LR/ZCyXmMrbN4UnW
	J3V4fPlK1dA099LPK4krNJ8dKyq4saC8KoDGEX8ge4Rbcfov5KFBsV0KL8OdwJJa
	PiP9MYeSYJ3wPHMsYSX5CA==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3xr888th55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 14:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1714167576; bh=xmNAJ9u+XYbDhnAwiNunWQmfpfW0x38Z+8z3XMgCtGg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=mUB+FMs3w9w/ErKOvc8Bmrb1TZOuINbRii5R0bHMOHV+VjkTxBxAZAHJVvFlmw/6T
	 7Fun2AMnNvAIbL7WEJ4Ohyw6lpN6X6B7CscQedBixWOWf7r0axjAKEO6Kunl6hrgdV
	 DfMnIrtjPZKCqylFJmCVFKNmYSmwZB7d/s8eUFazDRXlnClJLS0JHLY+8sDcyzsqLs
	 zvnVmXkVPMpAwZdM0DuWXkcQa0QV2sqt8QNcgIkeGOh3GMVmwzznFG4/PD73akug1Q
	 MbdrGZvU9daxxRyXWTHcIpxOXqv0yE3fYtaWYcv9/HqEgUmvUhhVTcKeVOMTpz6v1k
	 vS6Wle2+SoRxQ==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7220B40351;
	Fri, 26 Apr 2024 21:39:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 19AD2A007A;
	Fri, 26 Apr 2024 21:39:33 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=P56+K7G2;
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id D62C84024D;
	Fri, 26 Apr 2024 21:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7mfo2l2yp1DfqjrMM539e/oPlH6d5F0sdzCFlkrp0d351lOZBu+FDV9OB6RtUpx14adh//6rHk6KqW+igShdPorgR7hF1DraENXSE/jMAOhBK6WDJLsV39GVPZor6W+2TIRZnQWa0ULgY632ov1B2kkibnldv3wlZQoheFkoayQnCze8xgLvJAYWcRi6FdbLjAFe7K2RuFi9z9da9QElswHrEuajTLLaasK3x2OERIaYK5GVo5NttkJeEks/Qmq2CFeLKJDI4yha7RIxnLJFRzTxl5a4B6Q76Tw5MJwoTCSvyEeR2OJfef7Po/IFoZJg1BZZtUZZoxDdOD3dCtbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmNAJ9u+XYbDhnAwiNunWQmfpfW0x38Z+8z3XMgCtGg=;
 b=AUAzglxB3aOVd/V/hFTaL0kG59j6OWQWcbjS6zVKzoyL2kgaDogoRKaI7gBQlGiWafG+dnUrgIH7MO67Ep84u7iVvrBBhjHM01QYduQtIqaO8QsJKGGWQvhIALmqZX9fpqxnR1FVtvc7ogmkrGAS8FjPKPR+5E+LE4RGkc1dCzTD6lURVp3UvpUYx6h/eKT0QT2GxlLnGGFXCX2vPqV40jc2sXdXe7HSb+XJGPZTtueZo4RZfUi/RKfDNlmgU3ETMCrBNdNm7GL0bFbOB7yV8OsxVyO3G1xFShyUH/6MeswmIBu4KiglI9aiTZEiwj5Rgnn74EduTn0qQfYQx9n9rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmNAJ9u+XYbDhnAwiNunWQmfpfW0x38Z+8z3XMgCtGg=;
 b=P56+K7G2j9/SnoD7zbg2a0XY+EiyeY//NEplPc6+Yor0FPx33gVWuHtdAv2oTpUNIX04JKs7U7sDTM/zsHArigm3iOtpHlndqmO7v3XpPoGwbPyrVFuCemDji/VIYqhZbNNF3GBBSNFJfLFWNJtzlCqQc72xM0rUIRRG4udCRsA=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB7546.namprd12.prod.outlook.com (2603:10b6:610:149::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 21:39:28 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::7827:b41a:c9d6:8e1d%7]) with mapi id 15.20.7472.045; Fri, 26 Apr 2024
 21:39:27 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Thread-Topic: linux-next: manual merge of the usb tree with the usb.current
 tree
Thread-Index: AQHal5UP8viJqXYqG02QvdQIwY29+bF7FT2A
Date: Fri, 26 Apr 2024 21:39:27 +0000
Message-ID: <20240426213923.tyeddub4xszypeju@synopsys.com>
References: <20240426144848.42539084@canb.auug.org.au>
In-Reply-To: <20240426144848.42539084@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB7546:EE_
x-ms-office365-filtering-correlation-id: b3a5998a-833f-49dd-f58b-08dc6639594e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TGpSRng4L2tlbHluOWl3Ym9NNEFvWWE4SUdHaG96VHhJaXZIWXZiSU5IUXBi?=
 =?utf-8?B?THF5M0NRTXBIbzNUQ29hL05oNDJYd29CV2UwdllPYWk5YkpndWsrdEoybWNY?=
 =?utf-8?B?N2paV0pRS1hCeUZwOUluN1lNc2w2bFFjRWlDMWJPK2EwRWpGaFliL1NtTG9C?=
 =?utf-8?B?M3VPYVU4cjM1UVdDb2VoeDVtWEgycXZZL3ZPTUFxNGJSTitZa2RHNTdUSGg4?=
 =?utf-8?B?SXR4NHIzN08vTzBOaHhwd3BRL2xRUmpOS0xIUzFLTThWcUNUTm5JZG44QjFG?=
 =?utf-8?B?c290TEIxenFYVGxLS1JZUTd4NlAxbDFqR05kbldnMGR1WTY5UTlhN0NBclg2?=
 =?utf-8?B?MkxZT0dtQWVGdjAxSnJCTC8zeXRSR1NFWHRINTg5TUZ2Zk92WUNoWWNWeWlX?=
 =?utf-8?B?WlZoajRHZU1nbTdGQUFTb2FaM0F2Z25jeUtOcU0wN1hVSXN3ek9Vd1o5bjhQ?=
 =?utf-8?B?MGZ1OHZvSkNraUVVbFEyam0rUm1TUXJWa0YvMVFGdEZKMHJNRTZKd0NWc0Nl?=
 =?utf-8?B?eFR6aEhuV2NjRVZ6N0V1SGtsVVdNSkJKRzI4aUd6bWtMZWJxVm5OUVEya1Zn?=
 =?utf-8?B?enJNTXN3dVhhTUVJUjNIcWgvN0p4WVE4T1ZBWTRRWGNZbXJpeTVMbWw0RU5p?=
 =?utf-8?B?b3NZMGtKNVdqWHNsNngrbDRNY0IrZWNNSVY4UDlURUpBTHRGY0tEZkNtSGNj?=
 =?utf-8?B?VnFuZitVOUtEVXJjTmw5Wkxta1hSZlhVcXhoMVIyLzFUYzNmN3ZVVWowRml5?=
 =?utf-8?B?OEkxQmdlOFhQbmx1R3BkazA1ZTJjTHhRWFhuWXpCYjR4SDlsTGNTVGtWWTZi?=
 =?utf-8?B?YUZYRnZqOFU5bmpzWWhSaFQ4NVlER2lwTGpkZFF6NFBuUElmRy9iWS90cmdn?=
 =?utf-8?B?OWNTc1RWOVJUY0xyRUdKY1plQVNHWk5ubnFSakhieWtFWS8vZ3YxejhPQnNu?=
 =?utf-8?B?QW1MKzVwR2tnc0pKTUwxQUNFdmFCcERCZi9NcEhKa3F1RmxBV3J1emtqV29x?=
 =?utf-8?B?VFc4MUQ2aVJFeTNFTlVTUHplMmxmNFlHRkZac0tXZmhiUGhkVnlUSmEwRlJu?=
 =?utf-8?B?b2dReG5id2Z5RGpCM2g4RkYyYk9WdTJTbXJRTldZYWhTeEFUSjY0VEZoQ3BD?=
 =?utf-8?B?S0l6MDc4ZldaMEZFSkM2SGlERFA1OGY0R1dKcGlnQ0YwcFQ3VWFxdDlTZU9s?=
 =?utf-8?B?dzZnVzBNcXk2YVYvYTBYYWl4bFgrOGZUQ1JWYURSdjNJUU5pRDR0aU5PQytB?=
 =?utf-8?B?R0luUkp4WHoyKzRCNzlTUjM3Rkx6aDFIV2VOYWhvMUFvbkdwNmZMVW9DT3pN?=
 =?utf-8?B?SnhMR3ZiMFdyYlNBcmNUUWpVQTB1VElhT3J4VGxsdlVZZytwcThVVVFtU2tS?=
 =?utf-8?B?dWJSSjF0amhKQkZUVThocmRucnlZSG9lbUFDL094Q2tydEFIMGlYY2dxWXRa?=
 =?utf-8?B?RTVZbGkzb3h2bzYvV2ZTSk00U0w2QzArZGRvT2gzTFNXMGhWN3diWmF2a1ZP?=
 =?utf-8?B?dGs0dHV3bTBWd1pqYVhnNGhqMVZBOWZHWkVLaU1VaE1FYUFRUFZ6cXFRbWU2?=
 =?utf-8?B?NklWWjJpUWlIckFyVXZUYWw2UWUvMEZLWlE5cUJQVm1mYmo5Z3ZGR0FQT1lB?=
 =?utf-8?B?d1dnSzlxYWhRbDkwb295dlVpSkoxM2JUa043L3orL21EZ0NidnZqbXU3RThp?=
 =?utf-8?B?NDgrcXdWUDAwb2tFUThOTnZJNS8vRmxRZWZsazJHekg3SmhsT0lFTDltWTM2?=
 =?utf-8?B?ekYzUld6akkvY2pzdXlYdERSdytIaXZ5dmhMcDlPSEU4U0FwSjNpU05FalBL?=
 =?utf-8?B?dVVZS3ZLSnNtTVBYU09WUT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MWZwODhBRnlpYVY1WEhXWEpDNS9obElZNDhQaS9QQmlWWTJqVDZMM0ZhWUF1?=
 =?utf-8?B?V0hFREt0dVBQOThZUC85T2JwN0lGUHZ1MERFemQrNFloaFo0S3Fuak9GNGNi?=
 =?utf-8?B?V1pXT01TS3pTUlNVc3BZZ1FVQXlzT1BNWDFsMXg1TllnaUhwR2U1ZTkzL1Zz?=
 =?utf-8?B?ZzYxQzJDNlBGdCt5Ky9JcDB3cTdPTjRWZTEwNDBHV055M2RMcXBJdEcrb2ZV?=
 =?utf-8?B?VHVhV21qNTJXcWx3WVZVak9RV3pHNHI2TVNIbGNBZ1BXZ2NwM1k4c3E5MGND?=
 =?utf-8?B?bVFpaFZIaGY2amhEaS9kZWxOZk4wRjUwWDN1QmlJd0NDa3hINkJTcmJSZWFO?=
 =?utf-8?B?S05wWEFTZCtJWW9wTm0yS3M4WDMrNFVXS1YzYTBocnM0ckQrVzZrTER4Ylg2?=
 =?utf-8?B?VjNYR1VwK3FYUjFLV0pJQTRuR0JiTFA4SjhtVUp6Tmtsb3EzL0xtYnNlVndV?=
 =?utf-8?B?UUxjQ2t2Nk1jZDlyVGV0aUJsR2pUWGJSVGtreksrR2duM1JnSUV3cG9oclo1?=
 =?utf-8?B?bzZSNlNYM1lkVkRJVHNIcVBMQTk4MlJUN2JhTkE0RVVGSWR4NUtYRENWNDk4?=
 =?utf-8?B?azVEZS8yclNqWjhQY3pYVHdhYkV6NGE0VjdDSVhZRi83NmZCVDdaQkxWQVNR?=
 =?utf-8?B?bkt6dFR6bnRMdXFlb2Q5ZlNNVkorL0NCTisxRlk4TzF6Sk5ieWttVG9TeFJ0?=
 =?utf-8?B?K2ZhK2IyM1F6WFNMdVR6MHhQUUg2Wm5VQ1YwbjVSMnI4Q1RrMmRlSUNkNUFI?=
 =?utf-8?B?UDRUUmZ2bjl5VFRibGhNaW1COUppQkRPUDlWdFVVaGRFWEZsNWRiajFZckNm?=
 =?utf-8?B?NG56aUpGUVJ3YXdib0VjNjdsalM4S1U1SDVYU1NvQ1dJWTdtc09GY294aWRS?=
 =?utf-8?B?bFRCQlpGNklvQXJ4c25ubkVod3dyamMwZnFnUnl0MkxGUTRXNGhncHo1SkFi?=
 =?utf-8?B?VlRhUUtFTWNUT3YwZ2FDMFBzQWg5Mk9XczF6T28rMWV0MU9XSVhXSk9xeDNj?=
 =?utf-8?B?NjdDeHpqbzF5K1Vmd3pWTlZJYzRZR3h6QTdXM1dITkhHTWpMWllyREVvSVBC?=
 =?utf-8?B?M1ZCOWJacWROTWFPSU5kWDdTVEFUVnB1WUJ4VnZsZDA0M1hHenUrWENYbmN3?=
 =?utf-8?B?bklwVnRhN01oSTFMVlNyZzZ2VDJmTGtOVTU2Vm1Ha0xSNzROeGZOKzUzVlcv?=
 =?utf-8?B?Yk9EMDlSNzM1Yks2RGtFdjltajVpQjgycVJmcWJuTnhQMGlXMDk1VGkvOGQ3?=
 =?utf-8?B?VS93MzUwdGt6cjdXdUlqM0wwbXJoeUNYQTFaRHNxczB5YjVnaExmeXpBS2tq?=
 =?utf-8?B?SDg3OW1lRGU3QWFYTmNHQ2gwSkFYaDVwZFVHSDIxM0YveE9oL0FJZ3dNcERL?=
 =?utf-8?B?WXIrMWtjc0EyWlExV2kvSUIyYlN0dkdiU2s3K2tNSWxMcFFVdjRoTWlsSGtu?=
 =?utf-8?B?MlRQaXdyaEd0WkdIK0orOGQ4Q3Yyb21wUHQxdDB5VmpHQVFGZEl0VlZnTGtN?=
 =?utf-8?B?LzNaRnlxbE1CMFB5WjZlK0FIOCtHalZaTzdLSFdvNC92dFlFcENRT3NydW1r?=
 =?utf-8?B?ZkY5WEV0eGtva2N4aWxyVXZBN29QNkFiN2lDbGJIWTJIUEp1OGdJTkRHVm5L?=
 =?utf-8?B?SElwZzd0MHM1WmJOZzRIRXNWSk4yRWJwZDloaEt2bFZIakdLbHF4dXBuY040?=
 =?utf-8?B?WW84ZmZhd01KZlVMQkQ2UXRUU0VSR0xMK3laZGkxQlQ5UUFyYW83WkhVSlMz?=
 =?utf-8?B?aTdGSEllVURXT3dBTEM1QlFVUmdteUJ0UXNxaC9CVE1oektRbHFrK2tWMzNn?=
 =?utf-8?B?TmRiY0RwSWJOV3NLQUs1aEhDQUlUTUx0djN2L2JzRXpjV1JKUU01Y0RSVTFo?=
 =?utf-8?B?WlA3c1hXMUZGMDRQVjJPZllZazFoM09rQUZRQ09MaTBva1BKQjFMOWIwL1Ra?=
 =?utf-8?B?ZTZUWmxxWHRzU2kvMEtGczh4UFhKVmp2OUFaTTFNUWtSbG9Cdlk5UnpDdkJZ?=
 =?utf-8?B?c0kwVWpDSGJJRmVJZkdEY1hlc2RyWElLQ1YrMHRLTnMwWXZJcjc2Q1cvUlNJ?=
 =?utf-8?B?MytjNnF0OE90RU82VGxSTTRFVFIzKytqbGR0SnEwNnNSOXVJVVhnWFUyN2dN?=
 =?utf-8?Q?ILpy8q9D2AODdyvKAuSQoYH1f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B60F32DEE420764EACE88DE8F3412D63@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7ZVL6i/rOHmo5HDpCF4iOq0/M5MLz/SXaa5NVnODUScYS9Z8VP+NLsVbK8o3n/tVa8GFtYWvmD1AK2jjOJhYEKAqiQSNNtCezqPUvqiN5EOVOu/jEgtD277XhA0A9UCIhi2JO041WTm8ajbHbJFq3w8O1yme4EXHT36fGfHbPPfT+7ezWbJumxZvdONtOPqcNuBPZ/ZpKSeU40AiI+U2H7H+QRj3qyi50pCjg3IvQ/oFj1kEwbOaGcczousppFHsqErz7ExdX5Ek+wEjlrYijR8Wz3Y6Eiu0Z15+11TWd8aBUTq0xO5h2ybveHrnALPrp0RGYQVBxQsrLrwddbF6Xb/+P1z9kpKf6yiaa7SIprNsURKzvim3fHWAe9lkmbsqf/BFdDO/I1rq2/pSmYUmHyyxgvhq/Oc0wyVTggSyItK8lR0LmwjP+DLNEB3hqjB8ovb8zN/dD3CEoGwa8Z1dvb5YcfM4GUUUCnidiaPnB1MDpv776aLmpVVkuTlQk6Ma9vhCS7jAv/U51VIYN9Fwchm9kR2Fc2XcHn+NOzX7l2/Jt+4qIJYN7gZxGkp9RPJ7pYS3quYCgOeeyzJexjknYobZABwj/jFdQR7+pOoMlmnYXkeF4Zu6Lwjs/7q+03ozOUPDlGFS7KXzi3u/F+q4NA==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3a5998a-833f-49dd-f58b-08dc6639594e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 21:39:27.7058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+y+JwoJb9r+Rp6W0D/viCI2n6NZCVYi2oWjSz8dUaRHPKVTuQLUFxisBaBH61o8rOvUvchEsd4hZIb1JPS8bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7546
X-Proofpoint-GUID: qU1XX6SKuTImLVe0jtbkpHMGZOguG_7M
X-Proofpoint-ORIG-GUID: qU1XX6SKuTImLVe0jtbkpHMGZOguG_7M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_18,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260152

SGkgU3RlcGhlbiwNCg0KT24gRnJpLCBBcHIgMjYsIDIwMjQsIFN0ZXBoZW4gUm90aHdlbGwgd3Jv
dGU6DQo+IEhpIGFsbCwNCj4gDQo+IFRvZGF5J3MgbGludXgtbmV4dCBtZXJnZSBvZiB0aGUgdXNi
IHRyZWUgZ290IGEgY29uZmxpY3QgaW46DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+IA0KPiBiZXR3ZWVuIGNvbW1pdDoNCj4gDQo+ICAgNmQ3MzU3MjIwNjNhICgidXNiOiBkd2Mz
OiBjb3JlOiBQcmV2ZW50IHBoeSBzdXNwZW5kIGR1cmluZyBpbml0IikNCj4gDQo+IGZyb20gdGhl
IHVzYi5jdXJyZW50IHRyZWUgYW5kIGNvbW1pdDoNCj4gDQo+ICAgMzBhNDY3NDZjYTVhICgidXNi
OiBkd2MzOiBjb3JlOiBSZWZhY3RvciBQSFkgbG9naWMgdG8gc3VwcG9ydCBNdWx0aXBvcnQgQ29u
dHJvbGxlciIpDQo+IA0KPiBmcm9tIHRoZSB1c2IgdHJlZS4NCj4gDQo+IEkgZml4ZWQgaXQgdXAg
KEkgdGhpbmsgLSBzZWUgYmVsb3cpIGFuZCBjYW4gY2FycnkgdGhlIGZpeCBhcw0KPiBuZWNlc3Nh
cnkuIFRoaXMgaXMgbm93IGZpeGVkIGFzIGZhciBhcyBsaW51eC1uZXh0IGlzIGNvbmNlcm5lZCwg
YnV0IGFueQ0KPiBub24gdHJpdmlhbCBjb25mbGljdHMgc2hvdWxkIGJlIG1lbnRpb25lZCB0byB5
b3VyIHVwc3RyZWFtIG1haW50YWluZXINCj4gd2hlbiB5b3VyIHRyZWUgaXMgc3VibWl0dGVkIGZv
ciBtZXJnaW5nLiAgWW91IG1heSBhbHNvIHdhbnQgdG8gY29uc2lkZXINCj4gY29vcGVyYXRpbmcg
d2l0aCB0aGUgbWFpbnRhaW5lciBvZiB0aGUgY29uZmxpY3RpbmcgdHJlZSB0byBtaW5pbWlzZSBh
bnkNCj4gcGFydGljdWxhcmx5IGNvbXBsZXggY29uZmxpY3RzLg0KPiANCj4gLS0gDQo+IENoZWVy
cywNCj4gU3RlcGhlbiBSb3Rod2VsbA0KPiANCj4gZGlmZiAtLWNjIGRyaXZlcnMvdXNiL2R3YzMv
Y29yZS5jDQo+IGluZGV4IDEwMDA0MTMyMGU4ZCw0ZGM2ZmM3OWM2ZDkuLjAwMDAwMDAwMDAwMA0K
PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2Mz
L2NvcmUuYw0KPiBAQEAgLTEwNCwyNyAtMTA1LDYgKzEwNSwzMCBAQEAgc3RhdGljIGludCBkd2Mz
X2dldF9kcl9tb2RlKHN0cnVjdCBkd2MNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAg
K3ZvaWQgZHdjM19lbmFibGVfc3VzcGh5KHN0cnVjdCBkd2MzICpkd2MsIGJvb2wgZW5hYmxlKQ0K
PiAgK3sNCj4gICsJdTMyIHJlZzsNCj4gKysJaW50IGk7DQo+ICArDQo+IC0gCXJlZyA9IGR3YzNf
cmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IzUElQRUNUTCgwKSk7DQo+IC0gCWlmIChlbmFibGUg
JiYgIWR3Yy0+ZGlzX3UzX3N1c3BoeV9xdWlyaykNCj4gLSAJCXJlZyB8PSBEV0MzX0dVU0IzUElQ
RUNUTF9TVVNQSFk7DQo+IC0gCWVsc2UNCj4gLSAJCXJlZyAmPSB+RFdDM19HVVNCM1BJUEVDVExf
U1VTUEhZOw0KPiArKwlmb3IgKGkgPSAwOyBpIDwgZHdjLT5udW1fdXNiM19wb3J0czsgaSsrKSB7
DQo+ICsrCQlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCM1BJUEVDVEwoaSkp
Ow0KPiArKwkJaWYgKGVuYWJsZSAmJiAhZHdjLT5kaXNfdTNfc3VzcGh5X3F1aXJrKQ0KPiArKwkJ
CXJlZyB8PSBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFk7DQo+ICsrCQllbHNlDQo+ICsrCQkJcmVn
ICY9IH5EV0MzX0dVU0IzUElQRUNUTF9TVVNQSFk7DQo+ICsrCQlkd2MzX3dyaXRlbChkd2MtPnJl
Z3MsIERXQzNfR1VTQjNQSVBFQ1RMKGkpLCByZWcpOw0KPiArKwl9DQo+ICArDQo+IC0gCWR3YzNf
d3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCM1BJUEVDVEwoMCksIHJlZyk7DQo+IC0gDQo+IC0g
CXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZQ0ZHKDApKTsNCj4gLSAJ
aWYgKGVuYWJsZSAmJiAhZHdjLT5kaXNfdTJfc3VzcGh5X3F1aXJrKQ0KPiAtIAkJcmVnIHw9IERX
QzNfR1VTQjJQSFlDRkdfU1VTUEhZOw0KPiAtIAllbHNlDQo+IC0gCQlyZWcgJj0gfkRXQzNfR1VT
QjJQSFlDRkdfU1VTUEhZOw0KPiAtIA0KPiAtIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNf
R1VTQjJQSFlDRkcoMCksIHJlZyk7DQo+ICsrCWZvciAoaSA9IDA7IGkgPCBkd2MtPm51bV91c2Iy
X3BvcnRzOyBpKyspIHsNCj4gKysJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dV
U0IyUEhZQ0ZHKGkpKTsNCj4gKysJCWlmIChlbmFibGUgJiYgIWR3Yy0+ZGlzX3UyX3N1c3BoeV9x
dWlyaykNCj4gKysJCQlyZWcgfD0gRFdDM19HVVNCMlBIWUNGR19TVVNQSFk7DQo+ICsrCQllbHNl
DQo+ICsrCQkJcmVnICY9IH5EV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWTsNCj4gKysJCWR3YzNfd3Jp
dGVsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRyhpKSwgcmVnKTsNCj4gKysJfQ0KPiAgK30N
Cj4gICsNCj4gICB2b2lkIGR3YzNfc2V0X3BydGNhcChzdHJ1Y3QgZHdjMyAqZHdjLCB1MzIgbW9k
ZSkNCj4gICB7DQo+ICAgCXUzMiByZWc7DQo+IEBAQCAtNTk2LDE5IC01OTQsMTQgKzYxOCwxMSBA
QEAgc3RhdGljIGludCBkd2MzX2NvcmVfdWxwaV9pbml0KHN0cnVjdCBkDQo+ICAgCXJldHVybiBy
ZXQ7DQo+ICAgfQ0KPiAgIA0KPiAtIC8qKg0KPiAtICAqIGR3YzNfcGh5X3NldHVwIC0gQ29uZmln
dXJlIFVTQiBQSFkgSW50ZXJmYWNlIG9mIERXQzMgQ29yZQ0KPiAtICAqIEBkd2M6IFBvaW50ZXIg
dG8gb3VyIGNvbnRyb2xsZXIgY29udGV4dCBzdHJ1Y3R1cmUNCj4gLSAgKg0KPiAtICAqIFJldHVy
bnMgMCBvbiBzdWNjZXNzLiBUaGUgVVNCIFBIWSBpbnRlcmZhY2VzIGFyZSBjb25maWd1cmVkIGJ1
dCBub3QNCj4gLSAgKiBpbml0aWFsaXplZC4gVGhlIFBIWSBpbnRlcmZhY2VzIGFuZCB0aGUgUEhZ
cyBnZXQgaW5pdGlhbGl6ZWQgdG9nZXRoZXIgd2l0aA0KPiAtICAqIHRoZSBjb3JlIGluIGR3YzNf
Y29yZV9pbml0Lg0KPiAtICAqLw0KPiAtIHN0YXRpYyBpbnQgZHdjM19waHlfc2V0dXAoc3RydWN0
IGR3YzMgKmR3YykNCj4gKyBzdGF0aWMgaW50IGR3YzNfc3NfcGh5X3NldHVwKHN0cnVjdCBkd2Mz
ICpkd2MsIGludCBpbmRleCkNCj4gICB7DQo+ICAtCXVuc2lnbmVkIGludCBod19tb2RlOw0KPiAg
IAl1MzIgcmVnOw0KPiAgIA0KPiAtIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19H
VVNCM1BJUEVDVEwoMCkpOw0KPiAgLQlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdj
LT5od3BhcmFtcy5od3BhcmFtczApOw0KPiAgLQ0KPiArIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+
cmVncywgRFdDM19HVVNCM1BJUEVDVEwoaW5kZXgpKTsNCj4gICANCj4gICAJLyoNCj4gICAJICog
TWFrZSBzdXJlIFVYX0VYSVRfUFggaXMgY2xlYXJlZCBhcyB0aGF0IGNhdXNlcyBpc3N1ZXMgd2l0
aCBzb21lDQoNCg0KVGhhbmtzIGZvciByZXBvcnRpbmcuIFRoZXJlJ3MgYSBzbGlnaHQgYWRqdXN0
bWVudCB0byByZW1vdmUgaHdfbW9kZSB0aGF0DQp3YXMgbWlzc2VkIGZvciBkd2MzX2hzX3BoeV9z
ZXR1cCgpLiBJdCBzaG91bGQgbG9vayBtb3JlIGxpa2UgdGhpczoNCg0KZGlmZiAtLWNjIGRyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQppbmRleCBlZGIwYTZhYTFmOWYsNGRjNmZjNzljNmQ5Li4wMDAw
MDAwMDAwMDANCi0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQorKysgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2NvcmUuYw0KQEBAIC0xMDUsMjcgLTEwNSw2ICsxMDUsMzIgQEBAIHN0YXRpYyBpbnQg
ZHdjM19nZXRfZHJfbW9kZShzdHJ1Y3QgZHdjDQogIAlyZXR1cm4gMDsNCiAgfQ0KICANCiArdm9p
ZCBkd2MzX2VuYWJsZV9zdXNwaHkoc3RydWN0IGR3YzMgKmR3YywgYm9vbCBlbmFibGUpDQogK3sN
CiArCXUzMiByZWc7DQorKwlpbnQgaTsNCiArDQotIAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVn
cywgRFdDM19HVVNCM1BJUEVDVEwoMCkpOw0KLSAJaWYgKGVuYWJsZSAmJiAhZHdjLT5kaXNfdTNf
c3VzcGh5X3F1aXJrKQ0KLSAJCXJlZyB8PSBEV0MzX0dVU0IzUElQRUNUTF9TVVNQSFk7DQotIAll
bHNlDQotIAkJcmVnICY9IH5EV0MzX0dVU0IzUElQRUNUTF9TVVNQSFk7DQorKwlmb3IgKGkgPSAw
OyBpIDwgZHdjLT5udW1fdXNiM19wb3J0czsgaSsrKSB7DQorKwkJcmVnID0gZHdjM19yZWFkbChk
d2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKGkpKTsNCisrCQlpZiAoZW5hYmxlICYmICFkd2Mt
PmRpc191M19zdXNwaHlfcXVpcmspDQorKwkJCXJlZyB8PSBEV0MzX0dVU0IzUElQRUNUTF9TVVNQ
SFk7DQorKwkJZWxzZQ0KKysJCQlyZWcgJj0gfkRXQzNfR1VTQjNQSVBFQ1RMX1NVU1BIWTsNCiAr
DQotIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKDApLCByZWcpOw0K
KysJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCM1BJUEVDVEwoaSksIHJlZyk7DQor
Kwl9DQogKw0KLSAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjJQSFlDRkco
MCkpOw0KLSAJaWYgKGVuYWJsZSAmJiAhZHdjLT5kaXNfdTJfc3VzcGh5X3F1aXJrKQ0KLSAJCXJl
ZyB8PSBEV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWTsNCi0gCWVsc2UNCi0gCQlyZWcgJj0gfkRXQzNf
R1VTQjJQSFlDRkdfU1VTUEhZOw0KKysJZm9yIChpID0gMDsgaSA8IGR3Yy0+bnVtX3VzYjJfcG9y
dHM7IGkrKykgew0KKysJCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dVU0IyUEhZ
Q0ZHKGkpKTsNCisrCQlpZiAoZW5hYmxlICYmICFkd2MtPmRpc191Ml9zdXNwaHlfcXVpcmspDQor
KwkJCXJlZyB8PSBEV0MzX0dVU0IyUEhZQ0ZHX1NVU1BIWTsNCisrCQllbHNlDQorKwkJCXJlZyAm
PSB+RFdDM19HVVNCMlBIWUNGR19TVVNQSFk7DQogKw0KLSAJZHdjM193cml0ZWwoZHdjLT5yZWdz
LCBEV0MzX0dVU0IyUEhZQ0ZHKDApLCByZWcpOw0KKysJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywg
RFdDM19HVVNCMlBIWUNGRyhpKSwgcmVnKTsNCisrCX0NCiArfQ0KICsNCiAgdm9pZCBkd2MzX3Nl
dF9wcnRjYXAoc3RydWN0IGR3YzMgKmR3YywgdTMyIG1vZGUpDQogIHsNCiAgCXUzMiByZWc7DQpA
QEAgLTYxMCwxOSAtNTk0LDE0ICs2MjAsMTEgQEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX3VscGlf
aW5pdChzdHJ1Y3QgZA0KICAJcmV0dXJuIHJldDsNCiAgfQ0KICANCi0gLyoqDQotICAqIGR3YzNf
cGh5X3NldHVwIC0gQ29uZmlndXJlIFVTQiBQSFkgSW50ZXJmYWNlIG9mIERXQzMgQ29yZQ0KLSAg
KiBAZHdjOiBQb2ludGVyIHRvIG91ciBjb250cm9sbGVyIGNvbnRleHQgc3RydWN0dXJlDQotICAq
DQotICAqIFJldHVybnMgMCBvbiBzdWNjZXNzLiBUaGUgVVNCIFBIWSBpbnRlcmZhY2VzIGFyZSBj
b25maWd1cmVkIGJ1dCBub3QNCi0gICogaW5pdGlhbGl6ZWQuIFRoZSBQSFkgaW50ZXJmYWNlcyBh
bmQgdGhlIFBIWXMgZ2V0IGluaXRpYWxpemVkIHRvZ2V0aGVyIHdpdGgNCi0gICogdGhlIGNvcmUg
aW4gZHdjM19jb3JlX2luaXQuDQotICAqLw0KLSBzdGF0aWMgaW50IGR3YzNfcGh5X3NldHVwKHN0
cnVjdCBkd2MzICpkd2MpDQorIHN0YXRpYyBpbnQgZHdjM19zc19waHlfc2V0dXAoc3RydWN0IGR3
YzMgKmR3YywgaW50IGluZGV4KQ0KICB7DQogLQl1bnNpZ25lZCBpbnQgaHdfbW9kZTsNCiAgCXUz
MiByZWc7DQogIA0KLSAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBF
Q1RMKDApKTsNCiAtCWh3X21vZGUgPSBEV0MzX0dIV1BBUkFNUzBfTU9ERShkd2MtPmh3cGFyYW1z
Lmh3cGFyYW1zMCk7DQogLQ0KKyAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfR1VT
QjNQSVBFQ1RMKGluZGV4KSk7DQogIA0KICAJLyoNCiAgCSAqIE1ha2Ugc3VyZSBVWF9FWElUX1BY
IGlzIGNsZWFyZWQgYXMgdGhhdCBjYXVzZXMgaXNzdWVzIHdpdGggc29tZQ0KQEBAIC02NjksOSAt
NjUzLDIyICs2NzEsMTYgQEBADQogIAlpZiAoZHdjLT5kaXNfZGVsX3BoeV9wb3dlcl9jaGdfcXVp
cmspDQogIAkJcmVnICY9IH5EV0MzX0dVU0IzUElQRUNUTF9ERVBPQ0hBTkdFOw0KICANCi0gCWR3
YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVVNCM1BJUEVDVEwoMCksIHJlZyk7DQorIAlkd2Mz
X3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfR1VTQjNQSVBFQ1RMKGluZGV4KSwgcmVnKTsNCiAgDQot
IAlyZWcgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HVVNCMlBIWUNGRygwKSk7DQorIAly
ZXR1cm4gMDsNCisgfQ0KKyANCisgc3RhdGljIGludCBkd2MzX2hzX3BoeV9zZXR1cChzdHJ1Y3Qg
ZHdjMyAqZHdjLCBpbnQgaW5kZXgpDQorIHsNCiAtCXVuc2lnbmVkIGludCBod19tb2RlOw0KKyAJ
dTMyIHJlZzsNCisgDQogLQlod19tb2RlID0gRFdDM19HSFdQQVJBTVMwX01PREUoZHdjLT5od3Bh
cmFtcy5od3BhcmFtczApOw0KIC0NCisgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0Mz
X0dVU0IyUEhZQ0ZHKGluZGV4KSk7DQogIA0KICAJLyogU2VsZWN0IHRoZSBIUyBQSFkgaW50ZXJm
YWNlICovDQogIAlzd2l0Y2ggKERXQzNfR0hXUEFSQU1TM19IU1BIWV9JRkMoZHdjLT5od3BhcmFt
cy5od3BhcmFtczMpKSB7DQoNCg0KLS0NClRoYW5rcywNClRoaW5o

