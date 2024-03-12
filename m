Return-Path: <linux-kernel+bounces-100906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEFD879F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1128341F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B046452;
	Tue, 12 Mar 2024 22:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SjfZScju";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qgcMwW8y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD4C139;
	Tue, 12 Mar 2024 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284225; cv=fail; b=ZE3HfBPNL7YeHcG2dvU1f0z/8ozN8R47XxskowHFZi3YeqeE8az5l1TVAFmTZq5eMHhi4/kmpeeq8ZqrJPrGu/DXDal/bkjRkYT7eWDqDTXOQGOcHLhQ+ddhaU0b8oow4zrUK1iJJdZJQAyEwKUH7Q1LcwdJKu7NgesbJ+eTxIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284225; c=relaxed/simple;
	bh=0afM5J1+ZsvvGi//i86BsdR2+0QEJ7KK5xad0W8RGvk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHCzZp6+6gWmygvAsfQt10hPzp/Qsj0vhZw8A6nbmJIjGzGu+9gsqlfNZl04vDAea3BJk/z4Ta+MszMPQO6Ma5YueD8AQkmnBuXR739GMAjn/hcuvKuw2dr8Jks3/IkGI/uA//nFLlO0SuOy+DW7R7fg1u8Qg1Y8QX2g8ybz+jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SjfZScju; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qgcMwW8y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42CKPiLi015679;
	Tue, 12 Mar 2024 22:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6yssSixsuaFp26LRYwRbRLqNyDczKdzHAqaPTA08Dpw=;
 b=SjfZScjuEOZ1uPPQK4p0KDS6IR/oYvNH2i0AjfDTKUVn1gS080nunJSBNQp3Zx9+Mjb8
 rIVmU/Ock0UjFkeQFhykGGCgFypcqaEmIXuiIIVJR+Svk6MdOEKfST8LGUNPHFgYZkJw
 1/60PD0zpAOLTAQFpFvU7wGeJIbk/3lcEMo9HpakNv7v85HG0qFiGOu02nGI82x2R13I
 pPTAAxS8JW5qhzbx5Q0jMDSSq+hyrQeZkgchuR+hhqrwcoUOrSSpMz7njmtZxbTGgDEG
 d5IsXH3hBl+F4nWnRe0mgZWRusGMyh3PN5FxxswVXXj31Dtn2LAA7ahXpsIk7vChsTXY ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgauq4mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 22:56:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42CM0bro009100;
	Tue, 12 Mar 2024 22:56:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7e54ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 22:56:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0Stp0Vn6K8XVmZn0BFGyeOF/3HqG4MHbGALYOi3IdCK7hw0stBAyxBS9tEtFcqvIHWT+4wJb+eo7mEoPjOa7kc8mfNpEjRICAuBXwfQycjlrfpPfomatyKVfpVQsXfSJpOTQIBRZjC+7IHdJi7O9hAvo3XeVqB/mHlXhjzJGjsanpcLgghduw92u2h+k3c5/WHWRIkyFzc+A8K3dVt/k1E37iM7iwYFRxaYOTmlNBBQgxScvS063LRpf0wHOlKIK2CiGTc1ElyA3cFJp44j/8vD3DbwvsQ88bhyBbtrUBMNKtH4Ljl+cBTOEvKaFpBzT1m9zhpmP7+C90FfXshl2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yssSixsuaFp26LRYwRbRLqNyDczKdzHAqaPTA08Dpw=;
 b=QxoZZ/utju3t3/SJpPgdW3U2bo1Y4u6CARb1EwJuhsR1Y2QzVj35i0t0EcWQJDslFrfmp9H6pIVg1Phnf3xclKKWu4gzeuOEtR7kRkIoHVLoFEs0fRWvWk1AatAaaJfi4PLljOD6mfh16oa3afjo6XC+F496sMJqawb4Y6OnZAgYxXPzKhMjXL7UZpuwag+5IoJFGnvbaV8pRHqt2Ipw5xlW6PM4Cb4pkFvArapAU0ftmjWH5I4tXtRMsFCREGszc08+zBR06QBcFn9NxoneLHTvU6CpCE5qXUVXB7MJyJoBYTh64LWWv5BQ4zuEGRpUFjXNMo8YO/frxkjfeaj2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yssSixsuaFp26LRYwRbRLqNyDczKdzHAqaPTA08Dpw=;
 b=qgcMwW8yg1awffGT7nlM6MlD+ySPezFxzqmY7rMHssg82311EiQ8vgNwyT7Nt8MzRzNS3zdO2JYFRq2CrfQ8IodY7bsNj1TP/wY46srfwsyCWMzt74b/ggfo3mFTrrSZl1kJYqC8N6rE1kebg6hISnPdU4V/oIqWPwPwIa8NpQc=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by MW4PR10MB6485.namprd10.prod.outlook.com (2603:10b6:303:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 22:56:37 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522%3]) with mapi id 15.20.7386.017; Tue, 12 Mar 2024
 22:56:37 +0000
Message-ID: <ba26ac4f-160a-451e-a08b-27f577d8d2ba@oracle.com>
Date: Tue, 12 Mar 2024 15:56:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, stable@vger.kernel.org,
        Dan Moulding <dan@danm.net>, "yukuai (C)" <yukuai3@huawei.com>
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
 <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
 <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
 <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
 <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
From: junxiao.bi@oracle.com
In-Reply-To: <ecfce4d7-bcf7-c09a-7f01-5c7de88df107@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|MW4PR10MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 320d520d-7bef-4841-1881-08dc42e7ac65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DJiYdWrj/zeoME6qJFnA6pL+8VVoBIqF1OH/TkDTmbOtKjMliT2Jf+CDXf1h/rA/vA9hQk1sEsKTXUHZnMNVFAGuWFTfKF30f7S5DJnONQGWu6U/kUV6YJQa/4hyjLGPw0UR1tsq3pjlbImrYRRZn6obEa8PDEp9fVuY/2Swe6a6XpoItVjtQ4+9CT0Jh60+7ZGyFNwnTS8j56i2KtWJ785Xb8K29IplJFeEioH9VQ0skKEOWnAUlNb2iSR4hoYJ9jslzeunzQIIw6O97YS4VqDggrmEEF3QylIPqoPRd8YSKBnVEsvkFskEvLm026VSf9yVLHWvya2GPEByM+4MKGp2rCwQOXZehQojW+qjoJa9Cc1NMb2EvZowHbrCpHdHsePEgJMg++c0c/bLmfW79WZ8yK+TQNI21x6CxlisPcfVGkH+YQBQlt1svDflcUu5aWT68rlbNlw9e+raHk098UnAkPPTqeiMtmgD+jHUUqZf19PgBPUjA/7TzpF+lfEgbvxl7hLN2GF9yPekuRo3PxyUWp3SQJYef5Pw3dNw/C8PbBouGpHKrsAZ0fBdo8Vfth/BOpYMJBCOzXj0NfYzKUjrQLchVGuU2j2FS4144wI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDhSQWlJK2VOTUxhWllpK0djMnZaTFRqKzVSMXFNTDJSaHlvZk5UL2dSdmIw?=
 =?utf-8?B?RElSNEpUdW9NYTI2UmRXSGhQT2dXVElqNzNzMHg0U0FCRUZaOWIvSFd4U0d4?=
 =?utf-8?B?dG56K2VqaFQ4bEtoTXRQeGZVSDYzUnpZK3MweUZkMWdvRmNLaFpIZDR0WHJu?=
 =?utf-8?B?aDVtZWFXVktyREVUMkJFZFBsVmpMLzIxQlZLN0NQNVZXaG90Vm44ZTRuQ2Fk?=
 =?utf-8?B?dTlTNzRFblVuMjRPOXNXNkJ6dWtQQjJFdzdMK2UzNXZDemthZEJOWXkwaDhp?=
 =?utf-8?B?alJwSXZ5VXZtN0VIUjVKQTJpbVdkTTBUMGlHTXNRZ2VFRVlLZlRIczJWWVFu?=
 =?utf-8?B?ZVAzOXdJUEdmTWR5WElaS0x0MkNOKzlaRlFlL2U3aTZYZGhkMlNWVjRLbWNB?=
 =?utf-8?B?WkpoZDd2MmtIVGx0QVZZVVNCUzhwVUhacCs5VE8wQXAzNjlyYXVwNGF5WEJF?=
 =?utf-8?B?MXUxVnR1cU1ubGgwY1R3MEZuOS9kdllJOG5IT1NDQ09DeERVNzVYRXhrYTRz?=
 =?utf-8?B?MlpuT29lYW9STjV6R0NkQkk2L2tFS0tFbm42VTJxUVZrZFQ1N0pxSnltWk4v?=
 =?utf-8?B?U1AzeWExdUZJaW9lN2JCeGpUVTNCMkw4cXNhQmJ3Q0RnY2hINmZoM3ZZZ2w3?=
 =?utf-8?B?Z054T3ZNTUI3dTFSbmpRRmtrWGR1M2VEaGw4WnJ5VURBSjFRMTRiSnhjdDF5?=
 =?utf-8?B?dHUxT2p1MXA2ZzE1akpuVGxEU1ZuZ1Nmd2pkSzZ2UVdHM1duRFE2NStYM21N?=
 =?utf-8?B?czVmL0lpWktXUGlDRXYwU3orRy9MbHREV2ZjUitlRFRwdE5zRjhnQXIxd3E3?=
 =?utf-8?B?eDY5dlMwMnhTTWxMM25oMkhENHBOR2o0Y0JQTEU4bDEzZzM5REVBalBNR0ly?=
 =?utf-8?B?L0NsNU9UdXBOc0FBZGUzMEowdjVyY0RySmVBUHd1YzEvTkhWSzdya2JhOVFH?=
 =?utf-8?B?Y1FSRVlPWE52TjYxVmRLNHZScWpia0U0V3R0TzV4T08wSWt6enFpM2labTlB?=
 =?utf-8?B?ZGZybVV5bGFZM3ViL2E1RFZvL1lnWW41M3liVDlCYnhjNnNYV0Q0aUJrSGJD?=
 =?utf-8?B?aXFablRIZzFSZUNiL1drOTNTUnlIL0UrU3ZoK093ZWI3SjZZVEoxTGc0ZmJE?=
 =?utf-8?B?RFB1SWtnbGVPeStacWJ4S29mcnZSODc5M0k4QlU4M3RDNlB4Wm5kcSt4N0FB?=
 =?utf-8?B?OUlzdXRsdWVKdUU0RDBHOVBZUCtsUTZSYkxHazhqT3UyVU4wY1A2MnJ1d2dZ?=
 =?utf-8?B?dFUrSUwzUWgra21RbGNxaVFBQmFMSDdBcWpZV2hieUwzTjRHV2E2cHU1elNw?=
 =?utf-8?B?U0hQZ2thaWh1MFpKVWVkQTZvNCtVaVBxclVyUWxKR0RWWWdlVGk2YlFCNEJr?=
 =?utf-8?B?M1RKU1lRd0NydTBDMnJOVTJmWDRuVi9yMENGQm9zdXFtaGFwSmdFcEpNcjlO?=
 =?utf-8?B?N3dEd2EvbWx5dU83UlIxQ2hvZFE1aDFWeHd1U3FJamN4U0tnTS9JQlZTWERz?=
 =?utf-8?B?OFZXSlM1SmMzUEFnQkJDd2VZeE02SExTZGNQKzl5WDl0aEhPM2QvcFlIa2g4?=
 =?utf-8?B?RklETU82RXJoK1cxaXZGY0FMVlNKanBXTFFIanR5T1dXWnBOM29DZ3k4SERy?=
 =?utf-8?B?WW8vQXFEZXJFZ2lvRktwZDFlMTVXRjB1QWU4UW5CY2MvWkxJZmRzK3BDZmdU?=
 =?utf-8?B?bDlldGE1aitpMUdxYTNXVmVvYUpjaWJXNzhCSnFrUlJzYXNQT1YwQXZJb3g4?=
 =?utf-8?B?bXJHNE1lNkp0cUNKczhSMzcycjhWSG5WclE1QmJ2Vm8raW1xWkJOV0NmbzQr?=
 =?utf-8?B?MktmcHpvYThCd2dSQmZqOFRUQW90TEZremtQSG1mb0JCQXRNejBWNHRhTXpD?=
 =?utf-8?B?U1RCajJzL3BqT0JtS2xKYXVKcEFsemp5RXB6ZFBDMHloaTEyK2ZFZXdXeVEr?=
 =?utf-8?B?ZjRtQXlGV3h5Z2YxandrenFWdVFJMkV2aWphekdDb05helZrbWZiSFBsemVy?=
 =?utf-8?B?V0dDMGpHZStUSTVPTi8zaFkvNk1KS0k0QldhTG5uaDRpZ2FZdDhIdUtxb1J1?=
 =?utf-8?B?Wnh2T2FSNWtpQmtUcXRaODRGUnphWGZQQzJnMk5xQmhvdFBKVUxCUG5XanRy?=
 =?utf-8?Q?8FxPnW/nWBzHqW+XI+bXtBnZW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OcwsKKotNOt2tA5BeKVeMMo8hDVzjZ1VmoNuNGGYlyhrhw8+CqbEMcjdY99wHYFheRLeHny7CLj1akHFwb0GaT58i89U68Hag4vj9HItbHpk14kqCq5Xv0HiAo0Qq93S9SisYoqeAqenTK6c+bFmvY+nwkbRAm5REvIYewi7PRbbGvIn9tm0rwAhwzzwic+sWwML5E44o1981GcqkfwCMz3O0Ls7WwdK8cwrGoUZwdnSvdcFS54NuxY6mrF7zFK1vMOMq+bJw2vkhLQaL7W/vzEj6Mce2+9+IMZYZFwmc89t3iAz4BlJb62bI+qqswA/GQeYAPYiv8HFxLuesj/Lr9khs2m2TpFw1HLHpTylW8/UehjDerMWtoWwG4J+sxWN485Y3ortWmIaIC2wVIt7x8eDs/LyvUgk+9IjT06W3nQ9KhkKq0Ig5tHyIUL+FNnywqfhz6avLD3wK8S+DriEE17ImHxA0lq69SHAwfgXxWrqxLQ2QeQQeCdOUu2ud95/9lKjw5G2q/1CNljV7UlW/kehKykFZrIitYlRGlVIiIymDP6Lq3l2ltt+vOrtUGfjXfb7WA+lZgGT2oSkfFck+nAV0jtPq78Ug4m2u58tRZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320d520d-7bef-4841-1881-08dc42e7ac65
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 22:56:37.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EsDw9BmzQ2Pa4cl2n5Jf7AE1qYnWWf6ANYOjaDMqnsVUybvHn4Axvrdhtebz63zre3osGdm+a0KKzkcBy7545w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_14,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120176
X-Proofpoint-GUID: L-lkmXq6DrnnJM8GvQnCIAS7CjopobO8
X-Proofpoint-ORIG-GUID: L-lkmXq6DrnnJM8GvQnCIAS7CjopobO8

On 3/10/24 6:50 PM, Yu Kuai wrote:

> Hi,
>
> 在 2024/03/09 7:49, junxiao.bi@oracle.com 写道:
>> Here is the root cause for this issue:
>>
>> Commit 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in 
>> raid5d") introduced a regression, it got reverted through commit 
>> bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
>> raid5d"). To fix the original issue commit 5e2cf333b7bd was fixing, 
>> commit d6e035aad6c0 ("md: bypass block throttle for superblock 
>> update") was created, it avoids md superblock write getting throttled 
>> by block layer which is good, but md superblock write could be stuck 
>> in block layer due to block flush as well, and that is what was 
>> happening in this regression report.
>>
>> Process "md0_reclaim" got stuck while waiting IO for md superblock 
>> write done, that IO was marked with REQ_PREFLUSH | REQ_FUA flags, 
>> these 3 steps ( PREFLUSH, DATA and POSTFLUSH ) will be executed 
>> before done, the hung of this process is because the last step 
>> "POSTFLUSH" never done. And that was because of  process "md0_raid5" 
>> submitted another IO with REQ_FUA flag marked just before that step 
>> started. To handle that IO, blk_insert_flush() will be invoked and 
>> hit "REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH" case where 
>> "fq->flush_data_in_flight" will be increased. When the IO for md 
>> superblock write was to issue "POSTFLUSH" step through 
>> blk_kick_flush(), it found that "fq->flush_data_in_flight" was not 
>> zero, so it will skip that step, that is expected, because flush will 
>> be triggered when "fq->flush_data_in_flight" dropped to zero.
>>
>> Unfortunately here that inflight data IO from "md0_raid5" will never 
>> done, because it was added into the blk_plug list of that process, 
>> but "md0_raid5" run into infinite loop due to "MD_SB_CHANGE_PENDING" 
>> which made it never had a chance to finish the blk plug until 
>> "MD_SB_CHANGE_PENDING" was cleared. Process "md0_reclaim" was 
>> supposed to clear that flag but it was stuck by "md0_raid5", so this 
>> is a deadlock.
>>
>> Looks like the approach in the RFC patch trying to resolve the 
>> regression of commit 5e2cf333b7bd can help this issue. Once 
>> "md0_raid5" starts looping due to "MD_SB_CHANGE_PENDING", it should 
>> release all its staging IO requests to avoid blocking others. Also a 
>> cond_reschedule() will avoid it run into lockup.
>
> The analysis sounds good, however, it seems to me that the behaviour
> raid5d() pings the cpu to wait for 'MD_SB_CHANGE_PENDING' to be cleared
> is not reasonable, because md_check_recovery() must hold
> 'reconfig_mutex' to clear the flag.

That's the behavior before commit 5e2cf333b7bd which was added into Sep 
2022, so this behavior has been with raid5 for many years.


>
> Look at raid1/raid10, there are two different behaviour that seems can
> avoid this problem as well:
>
> 1) blk_start_plug() is delayed until all failed IO is handled. This look
> reasonable because in order to get better performance, IO should be
> handled by submitted thread as much as possible, and meanwhile, the
> deadlock can be triggered here.
> 2) if 'MD_SB_CHANGE_PENDING' is not cleared by md_check_recovery(), skip
> the handling of failed IO, and when mddev_unlock() is called, daemon
> thread will be woken up again to handle failed IO.
>
> How about the following patch?
>
> Thanks,
> Kuai
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3ad5f3c7f91e..0b2e6060f2c9 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6720,7 +6720,6 @@ static void raid5d(struct md_thread *thread)
>
>         md_check_recovery(mddev);
>
> -       blk_start_plug(&plug);
>         handled = 0;
>         spin_lock_irq(&conf->device_lock);
>         while (1) {
> @@ -6728,6 +6727,14 @@ static void raid5d(struct md_thread *thread)
>                 int batch_size, released;
>                 unsigned int offset;
>
> +               /*
> +                * md_check_recovery() can't clear sb_flags, usually 
> because of
> +                * 'reconfig_mutex' can't be grabbed, wait for 
> mddev_unlock() to
> +                * wake up raid5d().
> +                */
> +               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
> +                       goto skip;
> +
>                 released = release_stripe_list(conf, 
> conf->temp_inactive_list);
>                 if (released)
>                         clear_bit(R5_DID_ALLOC, &conf->cache_state);
> @@ -6766,8 +6773,8 @@ static void raid5d(struct md_thread *thread)
>                         spin_lock_irq(&conf->device_lock);
>                 }
>         }
> +skip:
>         pr_debug("%d stripes handled\n", handled);
> -
>         spin_unlock_irq(&conf->device_lock);
>         if (test_and_clear_bit(R5_ALLOC_MORE, &conf->cache_state) &&
>             mutex_trylock(&conf->cache_size_mutex)) {
> @@ -6779,6 +6786,7 @@ static void raid5d(struct md_thread *thread)
>                 mutex_unlock(&conf->cache_size_mutex);
>         }
>
> +       blk_start_plug(&plug);
>         flush_deferred_bios(conf);
>
>         r5l_flush_stripe_to_raid(conf->log);

This patch eliminated the benefit of blk_plug, i think it will not be 
good for IO performance perspective?


Thanks,

Junxiao.

>
>>
>> https://www.spinics.net/lists/raid/msg75338.html
>>
>> Dan, can you try the following patch?
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index de771093b526..474462abfbdc 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1183,6 +1183,7 @@ void __blk_flush_plug(struct blk_plug *plug, 
>> bool from_schedule)
>>          if (unlikely(!rq_list_empty(plug->cached_rq)))
>>                  blk_mq_free_plug_rqs(plug);
>>   }
>> +EXPORT_SYMBOL(__blk_flush_plug);
>>
>>   /**
>>    * blk_finish_plug - mark the end of a batch of submitted I/O
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 8497880135ee..26e09cdf46a3 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -6773,6 +6773,11 @@ static void raid5d(struct md_thread *thread)
>> spin_unlock_irq(&conf->device_lock);
>>                          md_check_recovery(mddev);
>> spin_lock_irq(&conf->device_lock);
>> +               } else {
>> + spin_unlock_irq(&conf->device_lock);
>> +                       blk_flush_plug(&plug, false);
>> +                       cond_resched();
>> + spin_lock_irq(&conf->device_lock);
>>                  }
>>          }
>>          pr_debug("%d stripes handled\n", handled);
>>
>> Thanks,
>>
>> Junxiao.
>>
>> On 3/1/24 12:26 PM, junxiao.bi@oracle.com wrote:
>>> Hi Dan & Song,
>>>
>>> I have not root cause this yet, but would like share some findings 
>>> from the vmcore Dan shared. From what i can see, this doesn't look 
>>> like a md issue, but something wrong with block layer or below.
>>>
>>> 1. There were multiple process hung by IO over 15mins.
>>>
>>> crash> ps -m | grep UN
>>> [0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0 CPU: 1 
>>> COMMAND: "jbd2/dm-3-8"
>>> [0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0 CPU: 2 
>>> COMMAND: "dd"
>>> [0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00 CPU: 3 
>>> COMMAND: "md0_reclaim"
>>> [0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740 CPU: 1 
>>> COMMAND: "kworker/1:2"
>>> [0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80 CPU: 7 
>>> COMMAND: "kworker/u21:1"
>>>
>>> 2. Let pick md0_reclaim to take a look, it is waiting done 
>>> super_block update. We can see there were two pending superblock 
>>> write and other pending io for the underling physical disk, which 
>>> caused these process hung.
>>>
>>> crash> bt 876
>>> PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
>>>  #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
>>>  #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
>>>  #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
>>>  #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
>>>  #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
>>>  #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
>>>  #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
>>>  #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
>>>  #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
>>>
>>> crash> mddev.pending_writes,disks 0xffff888108335800
>>>   pending_writes = {
>>>     counter = 2  <<<<<<<<<< 2 active super block write
>>>   },
>>>   disks = {
>>>     next = 0xffff88810ce85a00,
>>>     prev = 0xffff88810ce84c00
>>>   },
>>> crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
>>> 0xffff88810ce85a00
>>> ffff88810ce85a00
>>>   kobj.name = 0xffff8881067c1a00 "dev-dm-1",
>>>   nr_pending = {
>>>     counter = 0
>>>   },
>>> ffff8881083ace00
>>>   kobj.name = 0xffff888100a93280 "dev-sde",
>>>   nr_pending = {
>>>     counter = 10 <<<<
>>>   },
>>> ffff8881010ad200
>>>   kobj.name = 0xffff8881012721c8 "dev-sdc",
>>>   nr_pending = {
>>>     counter = 8 <<<<<
>>>   },
>>> ffff88810ce84c00
>>>   kobj.name = 0xffff888100325f08 "dev-sdd",
>>>   nr_pending = {
>>>     counter = 2 <<<<<
>>>   },
>>>
>>> 3. From block layer, i can find the inflight IO for md superblock 
>>> write which has been pending 955s which matches with the hung time 
>>> of "md0_reclaim"
>>>
>>> crash> 
>>> request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
>>> ffff888103b4c300
>>>   q = 0xffff888103a00d80,
>>>   mq_hctx = 0xffff888103c5d200,
>>>   cmd_flags = 38913,
>>>   rq_flags = 139408,
>>>   start_time_ns = 1504179024146,
>>>   bio = 0x0,
>>>   biotail = 0xffff888120758e40,
>>>   state = MQ_RQ_COMPLETE,
>>>   __data_len = 0,
>>>   flush = {
>>>     seq = 3, <<<< REQ_FSEQ_PREFLUSH | REQ_FSEQ_DATA
>>>     saved_end_io = 0x0
>>>   },
>>>   end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,
>>>
>>> crash> p tk_core.timekeeper.tkr_mono.base
>>> $1 = 2459916243002
>>> crash> eval 2459916243002-1504179024146
>>> hexadecimal: de86609f28
>>>     decimal: 955737218856  <<<<<<< IO pending time is 955s
>>>       octal: 15720630117450
>>>      binary: 
>>> 0000000000000000000000001101111010000110011000001001111100101000
>>>
>>> crash> bio.bi_iter,bi_end_io 0xffff888120758e40
>>>   bi_iter = {
>>>     bi_sector = 8, <<<< super block offset
>>>     bi_size = 0,
>>>     bi_idx = 0,
>>>     bi_bvec_done = 0
>>>   },
>>>   bi_end_io = 0xffffffff817dca50 <super_written>,
>>> crash> dev -d | grep ffff888103a00d80
>>>     8 ffff8881003ab000   sdd        ffff888103a00d80       0 0 0
>>>
>>> 4. Check above request, even its state is "MQ_RQ_COMPLETE", but it 
>>> is still pending. That's because each md superblock write was marked 
>>> with REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 steps: 
>>> pre_flush, data, and post_flush. Once each step complete, it will be 
>>> marked in "request.flush.seq", here the value is 3, which is 
>>> REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA, so the last step "post_flush" 
>>> has not be done. Another wired thing is that 
>>> blk_flush_queue.flush_data_in_flight is still 1 even "data" step 
>>> already done.
>>>
>>> crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
>>>   fq = 0xffff88810332e240,
>>> crash> blk_flush_queue 0xffff88810332e240
>>> struct blk_flush_queue {
>>>   mq_flush_lock = {
>>>     {
>>>       rlock = {
>>>         raw_lock = {
>>>           {
>>>             val = {
>>>               counter = 0
>>>             },
>>>             {
>>>               locked = 0 '\000',
>>>               pending = 0 '\000'
>>>             },
>>>             {
>>>               locked_pending = 0,
>>>               tail = 0
>>>             }
>>>           }
>>>         }
>>>       }
>>>     }
>>>   },
>>>   flush_pending_idx = 1,
>>>   flush_running_idx = 1,
>>>   rq_status = 0 '\000',
>>>   flush_pending_since = 4296171408,
>>>   flush_queue = {{
>>>       next = 0xffff88810332e250,
>>>       prev = 0xffff88810332e250
>>>     }, {
>>>       next = 0xffff888103b4c348, <<<< the request is in this list
>>>       prev = 0xffff888103b4c348
>>>     }},
>>>   flush_data_in_flight = 1,  >>>>>> still 1
>>>   flush_rq = 0xffff888103c2e000
>>> }
>>>
>>> crash> list 0xffff888103b4c348
>>> ffff888103b4c348
>>> ffff88810332e260
>>>
>>> crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of hw 
>>> queue
>>>   tag = -1,
>>>   state = MQ_RQ_IDLE,
>>>   ref = {
>>>     counter = 0
>>>   },
>>>
>>> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may 
>>> have some issue which leading to the io request from md layer stayed 
>>> in a partial complete statue. I can't see how this can be related 
>>> with the commit bed9e27baf52 ("Revert "md/raid5: Wait for 
>>> MD_SB_CHANGE_PENDING in raid5d"")
>>>
>>>
>>> Dan,
>>>
>>> Are you able to reproduce using some regular scsi disk, would like 
>>> to rule out whether this is related with virtio-scsi?
>>>
>>> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
>>> official mainline v6.8-rc5 without any other patches?
>>>
>>>
>>> Thanks,
>>>
>>> Junxiao.
>>>
>>> On 2/23/24 6:13 PM, Song Liu wrote:
>>>> Hi,
>>>>
>>>> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>> On 21.02.24 00:06, Dan Moulding wrote:
>>>>>> Just a friendly reminder that this regression still exists on the
>>>>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>>>>> development system to 6.8-rc5 today and immediately hit this issue
>>>>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>>>>> Song Liu, what's the status here? I aware that you fixed with quite a
>>>>> few regressions recently, but it seems like resolving this one is
>>>>> stalled. Or were you able to reproduce the issue or make some 
>>>>> progress
>>>>> and I just missed it?
>>>> Sorry for the delay with this issue. I have been occupied with some
>>>> other stuff this week.
>>>>
>>>> I haven't got luck to reproduce this issue. I will spend more time 
>>>> looking
>>>> into it next week.
>>>>
>>>>> And if not, what's the way forward here wrt to the release of 6.8?
>>>>> Revert the culprit and try again later? Or is that not an option 
>>>>> for one
>>>>> reason or another?
>>>> If we don't make progress with it in the next week, we will do the 
>>>> revert,
>>>> same as we did with stable kernels.
>>>>
>>>>> Or do we assume that this is not a real issue? That it's caused by 
>>>>> some
>>>>> oddity (bit-flip in the metadata or something like that?) only to be
>>>>> found in Dan's setup?
>>>> I don't think this is because of oddities. Hopefully we can get more
>>>> information about this soon.
>>>>
>>>> Thanks,
>>>> Song
>>>>
>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression 
>>>>> tracker' hat)
>>>>> -- 
>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>> If I did something stupid, please tell me, as explained on that page.
>>>>>
>>>>> #regzbot poke
>>>>>
>>
>> .
>>
>

