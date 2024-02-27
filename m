Return-Path: <linux-kernel+bounces-83924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAFA86A024
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15381C211A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D1D51C5D;
	Tue, 27 Feb 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BJZaF09R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rcRD1SbD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047451C33
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061981; cv=fail; b=j06fKAZlz87OR93JRaHmpL7plh9OB6cBY3/FPqlVh4vL7+ZwkBEDX1GdE/f4EY7hw44xF3El7RrULzCrhJlw+xSsdKBuWdsNohg60njIIoUXhlo4gVvUI0mr5Qfa5UPGsTJDU4xyFuY1BOSZ8oOi3vmIW5wWLhYVc6mLk9y7EeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061981; c=relaxed/simple;
	bh=VjmLkoD0Las+SbDUebxDOEDcchoQfywEStmt4yyXWFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzSs2XYvkAijGiWegwyY7k4REbgyrmsc2ysLJkBktnOjWAK6D3S5xz0B4vuODUorRdnu0o0jUYSsJsYrSVguyNbcq1dawggfv/ML+rLisg3f4lCTE778ibS7FHN4JOaGXARStGPGoVupw0wumtIZ9XLJMAOQwv9BgaV+a/ffYRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BJZaF09R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rcRD1SbD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RFYlXw009938;
	Tue, 27 Feb 2024 19:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SGGGqR9Rt1DDMHwU6g8ToH9ZNtc1X6brJuwRYjjKf4Y=;
 b=BJZaF09RRPvG3KbGwJVFkU3HyRPVS76qBJKdzssVuO4xuoNKbneHZCiEsEqY9gsEOBJl
 iPGi7E5KLKafFycVP4ZOu2Owiiw0UNIAFUkTG8sj6tIsckGnb025XHlPvbdrGyTbl/WR
 WK2Xp+feTQa3oPancZ+HMYrD60Fjs5tSwcE15yN1LLuiiG7w3NlVP5YXO/2YBeAX8ObQ
 CqUWHKZIzdoH7Gzt4DdFxZ57tera3foK+igSy+mwfOFs4b/NvzUBS5t1PgFsFEjg/zK+
 lzWdOa0sJx8yND2uritsV3j4bR6meXd9qsgWU41Ns1N2H+3RMVJ0rTpS3djUDdOjBqO3 Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82u815c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 19:26:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RJIPO3015331;
	Tue, 27 Feb 2024 19:26:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w7xyjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 19:26:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMxvjFuVEYgfvtw4uOLWeWT0LDtr+IYz3exsurwLw9C44h8k0ILLo+xq407O/4BSkxKN1A/kONeduOmwcm+SHaiyKLcIkIDGua/08yjXmytOkOSzNBQv0d2NfAhVpI3Qpkv8HXakZIWyhtCpn4ax0iwvriMZWjDiF4TZxYFsZ1MjaNHdIjWvoXMJSDBahNL48G/D1knMaZFaRlTs4Pyw+BVAoPSBlUgz/+JIhKaDo37WM68r3knJIWX/Qa9W6yivoxW+i3rx9l232AI9TBhl1k/EDryvG5i7P4U4RHMbUMqNTDRDuLhQQURcDco3eNA0SSeaRDW8oFxh9EU0oKFUow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGGGqR9Rt1DDMHwU6g8ToH9ZNtc1X6brJuwRYjjKf4Y=;
 b=lEO/JfK2qla4ONRV8shY0XN6Ci2i5/OmQffZcEIg3RjvhxUD1FvQRBE1EiSR2a6a3SkeLRPPOdxM1REbXoR++mm+o4s5cPad3GEErBRqelT1Qsg99xRe+dB+KYPQ6R27z/z48ulpi+nRXMaRCRLSjyU22tOW0JQWpXwwAp+hEeJuqkIrjgIdUfPpnYl/T9v86HH3bVa+2ay0fDINeeUe/6Yj1rK+Prvbej4FedVqwcWx9qxDSBynf6n/zqnVsBaP4n/3iGKz5a3oFFtewOgzBjGK6lCN/QOyZPZN6cE472BB8jnLirtxaV2kMeLhXJbMsckdKi6wS36C2iCiVxP5OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGGGqR9Rt1DDMHwU6g8ToH9ZNtc1X6brJuwRYjjKf4Y=;
 b=rcRD1SbDdGJEg6bVek7uEQRCCcDcvu0mYh9CN1jwIR+x9cbBHI+FWx3i18ccRZpoRGuvZiIn4taDovglclFFGcqvqzTC2nJJ2UBk/xyGNZlG9lTTkzlsr39yJC/ECGoQadcuEs20EiZpEbZ0B8mrJ+cQgXwf/LdDWdN17DbggmM=
Received: from SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20)
 by SA1PR10MB6638.namprd10.prod.outlook.com (2603:10b6:806:2b9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 19:26:05 +0000
Received: from SN7PR10MB6382.namprd10.prod.outlook.com
 ([fe80::f51e:fb9a:150a:a03f]) by SN7PR10MB6382.namprd10.prod.outlook.com
 ([fe80::f51e:fb9a:150a:a03f%7]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 19:26:05 +0000
Message-ID: <cf6c758a-42a9-4d4c-a1f7-71f4fc09e8a0@oracle.com>
Date: Tue, 27 Feb 2024 11:26:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: convert cma_alloc() to return folio
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, sidhartha.kumar@oracle.com
References: <20240227181338.59932-1-jianfeng.w.wang@oracle.com>
 <Zd4xR9sojA-4Mdwm@casper.infradead.org>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <Zd4xR9sojA-4Mdwm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:510:23d::15) To SN7PR10MB6382.namprd10.prod.outlook.com
 (2603:10b6:806:26e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6382:EE_|SA1PR10MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fc6962-9aed-4355-7838-08dc37c9f0f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5qLJdk5LmGP5j0gHZxwJMTqwKtl9cXcQVlj4wOANTDbR5/+5eDDXdnLsTj9tZY5F3p6F0rFiF8+v6ghSrE1Jx6xB+hLUkvb8CAZ26ZpgbqZoRtWIpv/sIgnEkcQxGfUJELqo8B1RcDyc9iSPHe+7it8cZ+GdufNkRajhJCulls7a2ou5JJRQrZoWhoTw5n4aj68mOWIcDrU4SW5TssFws7niZKVpWTxJ7Kjg6knGwkbZRzd+C/tB+XPThgmQiT1RhfCP8BB4VIU/cD9b0IUx5tLKzcxtiMqyhqhvcPdYKoR7NTrUKbjveRS6B68k0zfMn3k73xO03Ve5/+l1ZLaRdUv0TzTgMFA/XlcmKhAzyYPHSEKPcL6xK8I8kBe12mpF5NK+tUIkaGz4FbfOUxRoXEXloJzCCwSVuq9pFOCzymyB9/Jeu4+5g3qqq0vD+A+esg2+V9fPhgfNq0NSU0sjd29LAWeihg1GbhKerr+ujCugnAxP04Ss1oZ1+ZYEqyNkQ12EGRwbHhGR/E51Y/UbxtYGL8tHBy7O2cnBbhOZhMqN++ibeULOU2DZTZu35Aq98apVOCO79KCpeXnC862h7DOcpRUc9sICctP41GQuoErqVmT8EK7xAGvs+g6DJN3L
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YldTeUtiVjZESG5oUFRHRUo0dzFNNWF6c1k4ZGhKL0ZmbWZrbXA4OXphUkxs?=
 =?utf-8?B?WEhBa0dIT1Nsc2xyZWtCTWNuODV3MXNmSHczMStobWtMOHhza1gyWWYrRDZM?=
 =?utf-8?B?YTJkN3ZXbzhOdXBBRGcrRC9hQVV6OHQ0aVk4Z2tOZGZBcjloWHJUb2grQXVW?=
 =?utf-8?B?Q1NHUzBkbU9KdzRPZDQwSlBuQjVsT3Z4R29tMmJoV01TVkJjbGpzTjN4YlRn?=
 =?utf-8?B?ZFJ2Y3lWYVh2ekVoYkkzUDFHWmRueThnaHUzdjVlakVJYzNSSUZrdURGYk9y?=
 =?utf-8?B?MDJSUjZBRGZUajZuYVRKSDlIRjVPdzgyVnRyeFBpSHdibHc4cVVHalFWNWdx?=
 =?utf-8?B?eVd2WXBPY2ZsdmREbXI4Myt5TGxRSEh1clNCaUJWV0E5RzF4Yld2YmliaHJQ?=
 =?utf-8?B?MWszY2tQek4yM3BXOUtEb3BCS3hRNVlHakNHNEV2UW9qWUFTN1pTeitQVzdj?=
 =?utf-8?B?a2UvQWMzc0RGZXUrakF3aVNpWW5qTk5tamdDbzF5QWdmZmo5MFJiY2FRMEoz?=
 =?utf-8?B?T2duQUpSMW1XdFA1VnF2OENxcGRsOUh1enZmRHE5WVFDNnlLV0l6cW1IM0hO?=
 =?utf-8?B?aGxVQldrYTl5WlplSUp1M1dOaENwSGdOSmVEZ2dzb1NISWdidi9HMzUrK01M?=
 =?utf-8?B?eVA3Q1Nwb3M0SUNxZkg0NHcyQVA4QTRNU1ZUK1QwMjVWdjc4SU5lUU1kUEF4?=
 =?utf-8?B?ekZOaVBtVHdQNCt0dlVhSEllTVJzL0dKUW9XN29CZ2FvUTN2S1k3c1JyekFk?=
 =?utf-8?B?T0t4M01mQzhMU0VJcWlodEhJcGtCeHV1MFEzSWlmUHhUa0lmN1dqK1UrbmFm?=
 =?utf-8?B?dGR6SHV5QVh3aGhQbFgzN1l1YmlqazFVcGorZGZZKyt2RTU3K0NxbjZJS0xa?=
 =?utf-8?B?RmJQOXlzMWtVUlRVN2hDcDdsNkR1Q2lrL043TlFwVk9jUXphWkcwTCtnN0xi?=
 =?utf-8?B?UGpvU3BBUVByM2k3R1dFUm56M29hb0l5YmhzVE40blFtYXFYeHp3ZUNoTUVC?=
 =?utf-8?B?QkpCRENUNWFteGRUck1JWGVhUVdrMHVRL1N5M3J4SmZ2YUJ1UVBEUmxyT0d0?=
 =?utf-8?B?b2k5Q1NvcUFjUjFwYnpUYVdNRGNjaFc5M0lXVWUyMEJuN2hWNUdMOXJoWjli?=
 =?utf-8?B?dFpWQVJNUFJhcm5aYlcxc2xwakJNQnk3SmRtSDU2eW9MSm5zZlVNVXRyM0cy?=
 =?utf-8?B?WVFObzhhTjdyaWtTcUsrQlZWVEdWTlRidkFLemcwUHIxZ2J5bXdhckZNcEk5?=
 =?utf-8?B?Q1NQSnJOK0dUQ05KcHRyWHpTaXdQMHFDMDRLTlI3eWZBT3JJNlo0SHdQS2ZX?=
 =?utf-8?B?VzlzRVM5dnBDaGVwaGFnNHVVbDdFTkhibzA3N0c1dFFjaHY3KzZ5cC9Sc3VQ?=
 =?utf-8?B?amNvNzBaY09zQlh5K1RoUFozOTV2djloU3lmdXRYYWg4a0Z2N0pJYlM2MmFT?=
 =?utf-8?B?UjU5QnpPeXhwQVRyVm9nTjdnbEpUb252TUYxM3ZpNDdvQ3JzaUlvemI0eXlO?=
 =?utf-8?B?SFdoT3pxWHBuNEZXcTBSdjdYaDBGQ0JFVVBKU2xSL0V0aUM4V0t3ckwxdXJM?=
 =?utf-8?B?UjI5U3pJTUlTU3l1SEVqWmtOTkdYYkJoakpXZE01QUNIb2hWOENxQWRDVVRs?=
 =?utf-8?B?VzFvellSbDFYTC9pS3BCeHNzVk95U2JzbjdXV2lPRkxXZk02YmhDN2FCK28y?=
 =?utf-8?B?MDdLcXJFclpmUy9DbDhOVU4xUFdNQ3M2ZlUrME4xSlQ4ekQ0U1FrQWdKdWV2?=
 =?utf-8?B?emxyb09ieStrbTl6OHIyMitteHM1MmxmcVB5TytkVXh3SG5iWG5DaEtCTW9K?=
 =?utf-8?B?bFovSDZ5aWtsMmF5UHpiVlZuY1gwakFYQi94TEZ4UE9VWkN6b2FLakVDZWRQ?=
 =?utf-8?B?ZXNLbmFWNVBnbUFMeTJKbGxVY1NOMWpDZ1FIY2VXeDk0dG9sOFlzTkYzb3po?=
 =?utf-8?B?bGdNNmFnWmRhQUVMZ3czM0RrV0UxNzczZ3pWSjV3TXorMklRR1dXWUlGTmdL?=
 =?utf-8?B?Z1g5YmhKYkJKUjhudHYrVDFMQmVMK3M2STZRellyQjhCWEhjTjRBcXpER0JR?=
 =?utf-8?B?Tlg5bEVXcVEvc1p5aTYzNXZqQnhMZTRwaTVNTXl4bWUyZ3phZWl6MGMwQlYz?=
 =?utf-8?B?VTJ2TEdremVYcHlpckdrZU5ZSExsdkFMb1FqVElWZk5PelZZcHNOUi8xOC9Y?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z9PT1zEBHjrP9GX7Kgx1gDa94kyVyvJzUxBAAEEuc3EfktO81CBtnk5a1/mGd3Szat18Rxu2b3Yg4Xg9VTPziMTp12YWwZV4wWQCrYPTVfefpwoIJK3wxFX29A5vumxLQmKVvxFmt/uPfroY5iTd3zgvTeqZrLq3G8uk6g7hgve20z+VG/ap+dxHFlsD/xP/qASajTWY3cQFub99dTPxA+gGddafa9E1JxLTaxFv+rA6surnh2lX85upSb5Ffce2fWpiIarUUK8vWvlH0rq7EjrCF/wtri1PNm7Dl2QWufOHuhMylynAr5+BptBtMYLk5Fpn51HRxlWao/+/nwkWXWiKmm066QY2s4xpquXUwPMKwHD+IcwVmvpqU+ond0HolSn9f069hw6w4IXpfM/58QZ+y/pstvtm6C5GYePOO3AIkbh0ow5+eF/YbTWFRznZ9ooW8xwe+bsZjfvHBNt9rnmm+5LL61++2YJpRnBmBepOGK4T1d2fjfR8etzO/W2Y0l246FTTNaWnAGvj75m3+nWQsoDrGfev74IWS9NPcXuL5C9NPNnw/rLUOlnKv95yerY6bliGFZNfV9KXX94Nn2+lVLOZNkjSXVc1534TIqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fc6962-9aed-4355-7838-08dc37c9f0f3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:26:05.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5pJfz3Xz1INQ8TR9EESV2bKek4IoY6U3CuEh0qM6WDsFGgmncEU+vjMK9HMlvIzyjWjilzL/o0j1FXTQq1hOYvvRT0fIShUYCQpYTiGLxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_06,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270151
X-Proofpoint-GUID: 8Zzp7IBUT1iGHpBmJZJl0ynRlRzlOlB4
X-Proofpoint-ORIG-GUID: 8Zzp7IBUT1iGHpBmJZJl0ynRlRzlOlB4



On 2/27/24 11:00 AM, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 10:13:38AM -0800, Jianfeng Wang wrote:
>> Change cma_alloc() to return struct folio. This further increases the
>> usage of folios in mm/hugetlb.
> 
> I love the idea, but I don't think this works.  The memory returned
> from cma_alloc() isn't set up to be a folio, is it?  That is, it
> doesn't have compound_head initialised so that page_folio() on
> consecutive pages will return the same pointer.
> 

Thanks for review.
cma_alloc() returns an array of order-0 pages. So, this commit makes
cma_alloc() return an array of folios (each an order-0 page) rather
than a compound page. Functions that use cma_alloc() do not expect
a compound page as well.

> Or have I misunderstood?

