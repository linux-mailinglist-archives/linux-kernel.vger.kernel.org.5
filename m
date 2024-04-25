Return-Path: <linux-kernel+bounces-157894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254248B183E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D801C21907
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59846AC0;
	Thu, 25 Apr 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cdu05n/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gEy52Zyk"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DC3C0B;
	Thu, 25 Apr 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006837; cv=fail; b=Y+9oijA5jWd6ojT78SXxqJwBt65yz9or/tPesmzcB9waokUdxFw7J2d3/eAAejDBw56OKnWGlvQY6gcNCw/HZzFrYqfqXAsX7EonMckLYsOr7IlhUo9o7u/uSiyPzC9QHg2Vgi/Yv8yL5YhvlJnYIFxheQrh2kn9RVH3f/6NlYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006837; c=relaxed/simple;
	bh=MpvxC/A6FdOpLOhQOTdAplPDu0rfA9d7h7TwhWDa98s=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=cTV1UG8FVmfU4Y2bSJCZnx/HtE6K0/knIHOn1Ajvyuxn8LQFspcZFVtB6smyNO+t74Ywu8VUardXfced18UvpfzYSTfbkOri4poCAHzCvhOYzoKrE/GmojHsU0A20jvXs5mvAaVSoW1Ij0fQwPaxJK+BB/Zy2a0lZqYD1//i4Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cdu05n/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gEy52Zyk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0iOPu006356;
	Thu, 25 Apr 2024 01:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XbZMfw3b6XoG4BF1Xobq8rHgZencuAxt3duyDeuoBpY=;
 b=cdu05n/4JrHQRImbGtWIexIT/tKGKz8MWqbQIfyP5/xkP7za0jZn9JhFHcHcbZWoeLBI
 PZI415cyEs5pMSruU2q3RiYsRrje/broRgMvo3/xDO4LjBlIHBUi1eHuBX5FVAXP0+pR
 eLadMvKz9M9YCiWB4G4EzNWxuXT31FyoIHbqUx3AUfkaqmwbv5AS+TvuvAw6vRA8MrX/
 Q9vejr4WQrKlR1uOq6ayB+g6VqX+dNjcI2QdAYYvpsG9b5P4sltAkn1wf3iOTdYmfZy1
 Ue24eba+eWJ4vC3MX0em5ENvCv1FBPWcj108AW0cWG6f48D2sD/9XIZdV6nP6mCNudGf SA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2j686-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 01:00:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ONXRXg006185;
	Thu, 25 Apr 2024 00:59:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm459ne53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 00:59:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ1j9Mg8raT7GaxZYCgx4ZodOrNJ782WRBSCWbX8UmdsTadBEs5V3270emY/zcrlDgGqp9HX0IXoXAQEfqrh1vvwEnzUMSfixWuXZOZR17V7i9ekD+8ZxjPRc99UZQwzrxu9XVwVUV3Xpp2/4Rl5tRL+Z4KOOZUrEF+ibAD0RSZ30qhLOB4xJDXwLHESNQz7VIeUolE0J98MBdbR7lgXIF3bf23CQsRz79Yc6fVnMdOYJ2Efs05cg0RLixGSzkKnjLx8q2TyoQ8pDJ7yzTvkmPKdcr0KHDdOFEkxZIpGUoqRXavH80smUjE6HWv+BwfeieLQ3h+8ji+wVbPsp9i6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbZMfw3b6XoG4BF1Xobq8rHgZencuAxt3duyDeuoBpY=;
 b=JmUMXYixoEc1lUIcotqfWzAz7upoDRmE+zEEDkqb1levU8rqSUVDiiNuHjqMTYqKpyYdvfz0YgF8ewQO7xZobOa1DxC02Bi0S+xwJ8WScFh7mcfnn6Dl+HrET+rX/1po5W/YWy0FqF+5xdQGXNLSqZBRYsvu5aHnKUcZnHiKLzZpNBhsS6FkU5ko+eCE3BJBZaS4cPK+g8asEzfog6QgQdQUZeEwUOarSC5m9X2H9jo9+iiQecXlQiQat3yZLyeC36RmL+vKe79q8WSIITv3pRfo6vOTFKsufoXgGPhtXjKURMWr48yywoACGbhbwTZpS0iu4vJ53W8ARa2o9mGH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbZMfw3b6XoG4BF1Xobq8rHgZencuAxt3duyDeuoBpY=;
 b=gEy52ZykctQWql8hC2Vslq9xrCe97werTNseEsIAETy1u538oyS3Qe7I2n4m7oz7KAeiDBRHqtOPs142qvCrduaMyWMs9AYzvALeKvU4edQA3822z7BXCqmZaNHV/4jE6SJ25zp8eKGdwXYFjwI80pXIyK7efl3xJVWdG75IhWk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by LV3PR10MB7795.namprd10.prod.outlook.com (2603:10b6:408:1b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 00:59:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7472.045; Thu, 25 Apr 2024
 00:59:22 +0000
To: John Meneghini <jmeneghi@redhat.com>
Cc: skashyap@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
        martin.petersen@oracle.com, guazhang@redhat.com, njavali@marvell.com
Subject: Re: [PATCH] scsi: qedf: make qedf_execute_tmf non-preemptible
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240403150155.412954-1-jmeneghi@redhat.com> (John Meneghini's
	message of "Wed, 3 Apr 2024 11:01:55 -0400")
Organization: Oracle Corporation
Message-ID: <yq1y1928dgg.fsf@ca-mkp.ca.oracle.com>
References: <20240403150155.412954-1-jmeneghi@redhat.com>
Date: Wed, 24 Apr 2024 20:59:17 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0392.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|LV3PR10MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2582b1bf-e2e1-41e9-d1db-08dc64c2f1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6SzbOtnVaqdEetsNk00Rq0Uxh4VdVudRUkiwhA4KFkbmHj3JvKdRmTmXFdQQ?=
 =?us-ascii?Q?mDMk1Da0vGCTkW3YxD/iULAprfXfAt+G4r+lEBFuiiu+oDnhaKGQ1qkVdGlT?=
 =?us-ascii?Q?liTbGUe7ersy1lQWh1PC1CFDDDX83Him33KI2ltLhxP9KjeqBSZXc21zm3J9?=
 =?us-ascii?Q?C1D4pOzhxqTa4IFkKHS0UosWRIQxLE0my8Cvpcbynik3p8woMeAQlRHPmh3w?=
 =?us-ascii?Q?PJ6BPfpm0XmngmCgAv5LXADQgm4qHUcniWxkBwpRoau2nkPpcxTZX0OPq1xL?=
 =?us-ascii?Q?OMOvQErZd9d9MaJODCA7G8+RGRHt12BgsRNAIQswLGdeMPrAM+l31wZh1qoK?=
 =?us-ascii?Q?l5rdIW+m2sENVQxM1PvgeKcwEprIGcQ+46PupTfHqUH8ek09nfobY/gez3zI?=
 =?us-ascii?Q?mMFxskeyn+zw7F8MwmvSd9HRuD83hISYXNsKo7Gr4Yll9GWzpVM59YXXZ+RY?=
 =?us-ascii?Q?D+2MFHCblshPWaqifTIFAt9JLgf7WEGfwAfC7in3jxq+dnv6Ivthyp8Aqn0W?=
 =?us-ascii?Q?52kAGQQIXEhnxE5WwqiVzQaoGVgyKWymTH9Pv1WWoybmKvukOSHZIzhkUSfJ?=
 =?us-ascii?Q?EvUuHn/s5t8Bd8aeo8dfBc6bnH0PIewj5hLJviPn8EclquhVkQF5o4FL+NIK?=
 =?us-ascii?Q?fst4n7UXbIEYd6lU95clXIIQZMkZr2aaKw6ste70W+vHnVaQ4IrmPS7g0O8d?=
 =?us-ascii?Q?mFwj/+3eK7B5QxN+gMon3UNxmuJoiAccYN7IhHrVymyoUEm6CK3pmXOFlnbO?=
 =?us-ascii?Q?23Pt2oXhZNPSkj5Mugahj9zUTs4FvQaGtio3kQviofQFrH2rFG42nwMrWg48?=
 =?us-ascii?Q?p7+/FRlZl3S0LHoanenpiUGLEI1x5/H8zqVufCoIMjAEzJGUjD2AxiJLByS4?=
 =?us-ascii?Q?lPTmLWHsGs8lDqi7oKAjlpaRlf1vb9AKWpRI0Oho89SwQKHfIUjeEqgGo0mG?=
 =?us-ascii?Q?boAAjZpSD7VuWFQvIkLYpV3dXMA/MT0f0fRrpeeXBAllN+qSwjT7qlnfZhxL?=
 =?us-ascii?Q?vpFR0iYuY6i/6UtS7/FEvSLEx+ez0JCSe/v5HhnrF5+OW7OsNAUKrSev2827?=
 =?us-ascii?Q?3tGGG+S/r5VhZ1Sfo/S1FID9jnstfJMcq2s30mOQ+NbS4o/jrXNItEQVEFoP?=
 =?us-ascii?Q?GT5PZWO9ZpDxvVb6KBa2wOtiKNYnk3LqtN38EO2sGj25IJuevTC3YZ6e+QA/?=
 =?us-ascii?Q?6B56pywBh+oKt0rnKQvxe0RuSWYVVLIeNphmrSRlYt+YKp3F2U8mLkeYgB4P?=
 =?us-ascii?Q?beTdKxQeXT1BYyqz8hhn4zWRjVLtUsn+zEPTd5jMVg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FJjjjTHhw5TJoZQTbwP22Hm6S+w3VG+qoZGjb3aaUuTRAOZsWGtSNHZYAdg9?=
 =?us-ascii?Q?Gi4l16o+m2KQBngXovUaeDNMhGIjIlm3Yv1nHO2vSDBLkYO5IlUmV1s5cryu?=
 =?us-ascii?Q?THUiACtzhzLKD8mRz6WUY2VqEMAhOB+ygaiXMACieRRCKCOGNcCAySRgOqmr?=
 =?us-ascii?Q?0tF0RkY7huWgNg+7dAt7cEtB6JIiQErFAUyXtDNv0ako2MzckbG1X0sk73Gw?=
 =?us-ascii?Q?1kM1gweY8l0ybm2YBtTwPfirHsSyeM5HTWXdGS2QgbxQHa2mB+ZuF+f7iR96?=
 =?us-ascii?Q?cHlwPEbl/KLWgDZh0XrsfQI3wqcA4HmAVkJPzKdMWBT5FOElwUKBW6Vd6ylm?=
 =?us-ascii?Q?S1P1KT7bUXaek4N8GrqMZUoFgaFYZHciDEm1m+57OxQibmzvSEiMJh0H3GEd?=
 =?us-ascii?Q?nsgqeUJSkpNhiL91x4iyHNLqUKBQJkuhYmVgTmEIFUR0NvYDUjUhzOS1cGWg?=
 =?us-ascii?Q?YTJb9K0lYty+RW29S/bHZjV3cdasN7dXlxMOMmv4UE7WV658+s+WA9wDrwOY?=
 =?us-ascii?Q?mzUp1t56rBQNl5RscPwun8OaIUaxuFhtqJXWjVujFjBNi44AFPcOzACwJIYm?=
 =?us-ascii?Q?SISfth15rewOd3cJ/H1xKjOGogqlpxEH4xymkc6UHgK2ZU/0KQxQB3sB7LlI?=
 =?us-ascii?Q?fSiiivQUjt1fp/rcANAgvs6CbURDX5Flntz1dfkA0N+4jwAmscTPYdPG4dRm?=
 =?us-ascii?Q?acNSxFOYZSITtdTKwoXWEqFoGKRPmIKV0SOr9JNyYpta3vgKrNZZu0PNevGh?=
 =?us-ascii?Q?LVFP2u7TLcLsMNk6bxH9tLy+6KfVFlJ3iGIEqylgff1qjqCkZRK4KynqV9GE?=
 =?us-ascii?Q?XfeVQxvxftynXROfPaV39bkNm8MIbxQ1UcUxnccilF8qg+BH62COwWYX3xA0?=
 =?us-ascii?Q?vzeoahqfUygClFBmIMdJDFlQUbRnSMLCah+6Hj0eE01cu8HrVF0lI0gb3gfB?=
 =?us-ascii?Q?iHfxriObqz/kXY98XcN/VKudd/3mfGGHhkb+u4q8u3BJb8bGo+UWtuxzXoNw?=
 =?us-ascii?Q?eTmzX8CMzz4y3wNzHEbZ/dP1z5BHz+UdWXpNiPUutd4A70btR5xrHgTxqYDH?=
 =?us-ascii?Q?mVYt5NH0+YrF8tDynTNiV82rEpe4c2E8iMfzUunXCpQ3xjKI0KGMUaGLGtSY?=
 =?us-ascii?Q?zFXkcR4xQ5GFmxOh3ZVK8UPwPsVYRrz2U9XjNE08l83BZ1iwltDogtu0Scwm?=
 =?us-ascii?Q?xxn/sLIx/MndCUfjNfASzEdfGGdasoXmjb27k8sPRwWEpcY5OoaG9qqgHzPy?=
 =?us-ascii?Q?VgNA+/DsivlDyH0aAlGVyZYG9LL3I8g0ir/R1lOKqeC7manC0MNA0FNYI3iC?=
 =?us-ascii?Q?aNWwap9GDYJkwDg1s5vMWE/JSAEA4LUl0V+Kg+VpbQl6IL3Fo90ZIizPiiAv?=
 =?us-ascii?Q?v+JxJrXehPQIPE8alkqBQqH2UmJG8eSMjCnnDX6sZB7sNsNNwCSTc4JqvYNh?=
 =?us-ascii?Q?ZQlS6osPgBQWhqaHOJun5bAZv0e5rvuHDTvHUqad/ULzqqLrn8+benniFdZp?=
 =?us-ascii?Q?RGw4OElNGtEDCtMkWhptFCY6Y4kgMUHFRrnM0FuoRyu8TA9stShz1qtsk0Ft?=
 =?us-ascii?Q?XFjp5sBfJtML4dTWTNPeKD78Yy2Zo1Xnb8mdSmDo6YU0FukvqeFWKumd8nQ8?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SSpSfE5EVtDT1WdxYHI+uCB5qx8oDOjc5eXI+7Y936bGKnHiV0yxEzX/v1qKeFeFeNr0iI2o6lCsaeryCQ1FUJxsR2Lz2n/KfIHz1w7jxKaEnv49taq8PGdIV0/XwJqhZAEzo+zDv66/vCdGKyyx+uA6Oini3mZScH3Wjijr2lyqgaBcdgpK5/9ivLTIHFX0NWDbyfu1EcBv5MEFma/WRlUoAlaKixqr7KnHN7Y0vKII5t/N0XsgHVxBHhyDOcmIMawYaZQWwJd9OBgm6v0FXbsd/fc2Wlz7WWvtmRSCEWV2hr49bpC5qtHHIdKRV11v3KpxrCdSvvgQShHyzUnLl03Wt8z1ZmxdoGGzE8PicRPCyemEWitaVX3QyGeLIqjz4u/sVonZS1u4AO2hoGMFjlhodzcLcIcHdPIkiCtecqqykfwExEpMxVbp/WuK7hX6AR062j9xvDFagfyYDCMOyrPvuXz90Yw2l1z6PnzoD5tL3F/2OQyqAimHLaqhDuLwO1BuEEUWLQBvJhXcn02jsVdqnStWHNjbtlih/W+p9OuxNWw+pe4G+Ev/44cr58G3QfvOsDYg3rT2XkaPYOjif2TqbTJXuz4njMiM5cppf/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2582b1bf-e2e1-41e9-d1db-08dc64c2f1c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 00:59:22.3485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwAvT64t3HLtW4r0PyZT8k1WJkVPL6NipB6RiV33it8FHOI/3GJlRmhKSg0KSZcA9wGM+u/FtkkIP4KJ+F/o9DxgXkpV8d4iZK1YxQB8K/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7795
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_21,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=647 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250005
X-Proofpoint-GUID: GqRyXgTgoegp6naAUrVMFWyYSmpP6hFv
X-Proofpoint-ORIG-GUID: GqRyXgTgoegp6naAUrVMFWyYSmpP6hFv


John,

> Stop calling smp_processor_id from preemptible code in
> qedf_execute_tmf. This results in BUGON when running an RT kernel.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

