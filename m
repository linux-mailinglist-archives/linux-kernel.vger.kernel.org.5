Return-Path: <linux-kernel+bounces-103662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1987C289
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B871281A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800D676C8B;
	Thu, 14 Mar 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cYAXZzME";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C2ncwRsK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284C7443A;
	Thu, 14 Mar 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710440446; cv=fail; b=ooj/G26Wviih47SR+YhTlLBVQBhxU/xzgC5pyscBC04NW5/GIbZMbW0zl1rKMjwkIUpex/9Ay548nWXOS7bQM8fCm+6K2c5DgJmC7TowXm02eAaU3Bg1wFomBFe6/2CW+wzcHcmsBvA5nLy+XQj9eFqNV7ucezeUTjllX8bPYCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710440446; c=relaxed/simple;
	bh=6AH5EHd+vtU3e5FQ8iWVHoVahF0hnmMQyilu+Q+Ov3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dk0OgkIa5lXh7XOG+cBO45qT88fPOIqeOhjbUmNkpLALcegVHg0eYQyjb3fKochfcaqw3IrirQSWUO2SXrXlU5HMNKqLqX2eIWJJGMRaoTaQbqm67GY6mIP++ZWf9pAZa23p6B9UI7xmXeuwyjeDLxgwZ4ZH4UixbrnfWXfq1j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cYAXZzME; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C2ncwRsK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECLuOd009377;
	Thu, 14 Mar 2024 18:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=z8BIHzJQnZ+f7V1Q38lE09JbtVIuXk67dSHbBoaLtoI=;
 b=cYAXZzMEBWu5Ls4CN2nyXJp8DMPtnDsU5amAjjjuKAFYluLS1pozgTHFVR7AYuY+RxL4
 hXbe2MuEhLam4Y+8Ldg5BAd1FETcijT7px98FCqz6Lmnm/jOa0KtjKeA/jQNiu4cpTnF
 pJ4Kp8KXRCPpeLCVZadI4YDRx2YeDQoW5k4GMvMlU3kDgC7hIllH10cH3PS8JL4mG19X
 Ww8jvrFvW9WrOmefHsu7yoi8tQmldt4b8Ta7M9u/SIkPa8qi2+kwECCSxGyLP2wsYiFf
 G6g7AVS6XywU7Zgr+pIUz8aJEHEeR6V3EAHkzraLqZqwrnvoqVUwsbgSoitKvthHAAxZ cg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0ac0ycs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 18:20:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EHO4ZM004812;
	Thu, 14 Mar 2024 18:20:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7b5nfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 18:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzBdFtV6gzshiAE8Tee1F+Hj8NVquKX8hmRPTyGueNEG1lv94JADIILmo1LgAiNiU4x66AIKelSvWMjjMYMOL/f8F5yFFqlaglQ0ln+nQaSzGiPFlvvpMuvSKXy3l0YEP6XFTDBl/xS2TV1cPEANW8sMHPzEd2QXAb5ai2mwrYOhVbdRa07d2pnVx6rMwc+VBPGQLQM6T6j4SD87nroE7IUNzs5xx1QU9IphDUbX6uA01Mnl6DBTmC/oXPAnth2sTefpSdN1knlacNTss7nCpBe99UwTmgc94H5F30OjeomwJ/IsM4u8LnKjRzvjRZbUopj55OiCZS6cNGXAO7UEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8BIHzJQnZ+f7V1Q38lE09JbtVIuXk67dSHbBoaLtoI=;
 b=N8MSGTxdiKGPVHRbhLxF4CqORlc61o5osqzy4U56Rq99338+FE0PUfRMNPBQT6+mCD/O8G/qNoRolhZUyHf+33LxOycpAQ20bqbt7L6xAxiGak5O1iuNBhCCJ1THCLBgby4AUZ0tV6D1AE5fAYp40DGcFCKxAeLdtzdZHg6y7sV2bXrZzkKj5KMCpFAauSOjpwaXhWN06G/gEWTvSW+GTXgdvZWHr4vHuTI9sWLfopeCYbbVkrp8avmBvA8RR1ta/bco23yXkwgwJUgDkbuzelf07zDxCzVj49Ec78ot2/w2Le8dhdbauWA0cnXoODzK8t+3r1XTjKB8xVdO7zi/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8BIHzJQnZ+f7V1Q38lE09JbtVIuXk67dSHbBoaLtoI=;
 b=C2ncwRsK/09FzlfCZIXW25kyO3siqpzEGS31oiDEcjD/nr38LbTHh+UgVqZVL9Ri2N0S5kVtcFdBommpOAOh5dZkqLzDe8fJgHLWllR9pjr1Q0Pt4sX4YLv+kkkp9n5DAyjva9tdUv08BKELdO1PgS9lLBKzYOpl87gIDuxwP0E=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 18:20:14 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522%3]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 18:20:14 +0000
Message-ID: <e58155bf-71c1-48c4-94c7-b0d9ecbbef99@oracle.com>
Date: Thu, 14 Mar 2024 11:20:13 -0700
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
 <ba26ac4f-160a-451e-a08b-27f577d8d2ba@oracle.com>
 <fa4beda8-986c-1112-f3f2-159f20674d47@huaweicloud.com>
From: junxiao.bi@oracle.com
In-Reply-To: <fa4beda8-986c-1112-f3f2-159f20674d47@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7d4f72-ad7c-4d7d-550d-08dc445364ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V2BsiM/qugRU/POmQH9CJ0FwhFcm8ti2E354vuSEOD//Bm6CjrEk02t09OXoTen4pt+oUB7HGCgUTBuLwCXu/Ic3Qv6+bd0DrAp51S3oqBsqI5xodSFEAV88k9EGkkyUtDPUhmX+I3BzVKmKmIMd9MWJOM6sKq/vWaUKo/87wIsOKaCHvTbCb1MWFGB4yamG0EnPhewj5+4kfXstCTwjjAQv1VVesJ3LMEJdM/XSsWKVVi0tTtqy4KUPFhhcQjIGHPPqZPy1qIHyj7tcVyaA0cKZNjT5Gax480275mKpqzIB5CQmfk8fuUPgWOdj6GSgy+R/KgvtfmounzSygZZv6ba3KaMr5yhPFy4vMFztDs7Z+5xzlrcHK2XBPxYUaWRPYhFUXLo2W8nfYkomSm9sw89j0MHOg9jg86MRKqAuQ46cXG891nvay3C73bbu8De1/PiBFI9Bm8ASW+ULUEE+WSnICTAwwpSBh1a6+1NB6BKjWqW5ZdhFlufxSkHi6dN0q/hgsl4HJ2SMLTtkD4/QSH7aD/ixSMJSkBFXLyokQ2w6gx5OvyMJUcTzfJVaX2fM1fzlNaAS7uTrKlNxbgfUH9P6rio4L/3MaOFwDUW5mPQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEFxVnhNYVNsSFVLS1NMSlRrSDhlZUFVcnQ1QklEK0VLWmRXdk10cEgzMVI1?=
 =?utf-8?B?VGhIZlFOZ3l0UDh0MVNaK2tJYmV1dHF0UGVsbkF4SDczSTROZEdiaXVST2h2?=
 =?utf-8?B?U2ZGdEhBMmVJMXFGcmVXTjZIVDBSMmRtYWpxYjVqYktwbHZlVzJVLzlRQlZ6?=
 =?utf-8?B?V0FpZm9VeGVkSFBmMFJ2SDhZV2lZd0h3Yy9KQ1JrRFp5RkMvN1BoRnBkSkVl?=
 =?utf-8?B?MUJUMDcxSTZnK3dyVWpmRW5KV05iaXFKYWphTHZuMi9xOUtZeGR2Wk9zQTNU?=
 =?utf-8?B?RzI4bnlSU2w5TVpqU2h3YW5LYkhJQ05VcHJpVU1GVHpEb0x1a2lHYTRrbjNa?=
 =?utf-8?B?c0tEYStrTTVzV1JkdFk1WExJOXFPVFNsT2szcjhNMFpTWUQ0WUFPTHFROFQv?=
 =?utf-8?B?LzltT29oYUJvNlhPcmlGZzlscGNwZGk5NitYd0tWK3puTW40cTIzVGptdUtF?=
 =?utf-8?B?VlMyKzVMNEhpL3hGOEtlc2s0WkZTNmMyaTVWeGhIODdOZDJMclRXOU1uQjNr?=
 =?utf-8?B?QzdoWDhvb2pNMmJCRGFIK3BYQ1Q5b3FDUkdCRVpONU9Hb1FZenlaeXUzZml1?=
 =?utf-8?B?V0p1SlRjMHYwN1lGMDhuTXRzVkFtMWVDM3VqZjlqN1UrVGNrN3R4SmNubWlL?=
 =?utf-8?B?R1JpMGJjb294ZW5RY3NyTmVZUlMzem1BcnBScmdRdHFJQWpGRjNEYzZtYkEx?=
 =?utf-8?B?VlJSQkJHZW0vaHdxNSsxWTM1cmJBZGRoekZ4NGgvT2F1aFdCWXZGYWs2UHk1?=
 =?utf-8?B?ZTFCMnJCdHlPQTBGUGxvaGRNZVVvODR4L1BLNUxsYmt0b0Z2TTd3TXJoZUwx?=
 =?utf-8?B?NGJoUEd5d0RQcGtXeThDdng3WVFJTGZFK3ZFT1lMVWJaaHQrRjBobmRPd2Jk?=
 =?utf-8?B?QnJYTVBkMmdiTUZuYXVPU2FYYnJxZjhuNFJKdDR0N0U1bUhlbnpBT1NzcE8z?=
 =?utf-8?B?U0RTR0xSMkRhdVpkSlhjYmZ1bXFoclN2b3laSmpsZFBvUVV6ZUxZRjE4djlD?=
 =?utf-8?B?aUJzYkJtc3FXazVoalhLaTB1d1RIUFcvS3VZTHoyZFZESW9hQnFHKytSb0xl?=
 =?utf-8?B?ZllMbE9KTThMRVZHRVRxTGhRRXNZZytQTHUzaE1obmQ0RjZ2WWNPVzd5VVp4?=
 =?utf-8?B?T0VGaDRVbTU5QzVSMGZwelRGRjE0eXlGcGZqTHltVDFERndJYUsvZjBsV3V0?=
 =?utf-8?B?b1hvS01mbkV5NndMQTlkeGtjQnNBRDhqbUdoTnFldHF6UndvbWdwKzFDK0Vh?=
 =?utf-8?B?Y1ZjbElNd0ZodTNBUVlhTFlnNHJON1VLaWtNYzVuWU95V3kzbEhkNk1HT3hE?=
 =?utf-8?B?WWx1Qlc5czZLSGVmN24zaEExUHYzZXRYLzRVQU5RU3dxQTA4S2JQQ3FSaUtw?=
 =?utf-8?B?ZFJUdkUxT2JZYnRNNVdCdUNYRkVvMDFRcGRVN3lDbUFQanA4MkJhTTdUNEpi?=
 =?utf-8?B?U1VRNk43Z1RyajJLc3E4bFpMYmxXSk11L2hFTnlsdWtYblZ3UjJXNjBDM0l2?=
 =?utf-8?B?OHhmU2JKUC9oK2N6TjAza0xJZHYxMHpDaDQ5SnpWeDk5VGVJRXVacENYVmcz?=
 =?utf-8?B?L3h1Mzc4SlFyVGxsME5jRDFwV0JZVU51S0lSOWZFL1NaSzZTK1VmZ1FCcEhh?=
 =?utf-8?B?alpaL1IxcE9GNWtCd2FZdFFBN24xU0dyZ3d2NlZ6MWdXdWx5dWs4MEtZSkt6?=
 =?utf-8?B?TG0zSjM1ZGtpSUlMRUNWNU53eVBZbHJTbk1pZVRFQ0MwYm1Sc0M4d3R3M0Ux?=
 =?utf-8?B?eHkwOEtBYkl2M21yQXNnemo4VTkwakRBdUdlTW5teEN1eFYvY3RXYVhjVTBF?=
 =?utf-8?B?eTg1WlFPdzJDRGRTZ21waVkrem16ZFM3emdtY0JzbVppZ3NmY24wcVNXT2hS?=
 =?utf-8?B?WFNSRjVIUzluaW1Yd0g2YjgraXNkSHQxaFJNS0gyeDhlZmJKWkpzTmwzTzQ5?=
 =?utf-8?B?aDhIblQ4ZDhYY3JLYVd4NWlwM2F2NGtQM0pYMlN6YWt1OGpLY2dHeUZmajlT?=
 =?utf-8?B?ZnJsaGxTQkg2cEcrbmR5eXVkRjk1MlpRN1kyWVNTZXR1RTNGblNCOFRid0hR?=
 =?utf-8?B?S2tnOVZyMnB3WVcrVE8rMFQ0UmFVTDRvckVRVEMreTRrdGphd0ExRjlicUF0?=
 =?utf-8?Q?FGMcfn0TatFN4KQ9bRk4KOA52?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+59wCSITh0jozRTs6pkfXAhpheXj/ul43D5Jb7Dc5Xw8bBBjJP0dssxsKfO0ctgFc9gcIqztfgIbndwEKEHkMPGfEWK6uPmAaSZejvV1EkkT4lus3dIboV72Inp2QY3MswBGByL3D/LigQWiGLbu63obxU3KQOi5bfUvP+8ATqpxnQGjokY3gGGZZuXxtuZ3tPN4k0l2goxqZHcdRjtZ2yFZ5hRagf4UfW+EySn3BgJOMGyqsIr9sma1V4S0nI2BySPBGv7WTrBuRhstEDhO/lUcfyR8nOWzXhnz2qg7Vf5/qgSqt5mmswXSVTUtYAjCYKFTXK2y60Fgpp0MXv5gYsLWhsblVF1E+QS0cDBw8qXy9lxItFD1m5F1hPbkkzFn6xjXIMdSBSuL2eiBKw20QPrgSU+dUJzaf091AvvKDi6VY7NXVUV/nDZMCBf+TslyTPRcVXVD8yKkyL9INR4RCUrZEr/ljEt/fafEfjKucA8TQTKlolHLKfHfDUyb3NclK1DX7+FwitVS20oVYRINT8mZhCVfgEfEc53MxuXakk67Ux7I+O/bTMZHF4grQtWGvicAQuevq/797IjBPt9OwC9aK1y7WgLctEWxbuJ7N8Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7d4f72-ad7c-4d7d-550d-08dc445364ad
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 18:20:14.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgDSoLiL39NJRwz+dVjxBQgHRtVW6vX+YCmjPXDXHR1EYJxFvnVnHqjPnCnIBn79yIMlkSedttYiaWdfRteR9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140140
X-Proofpoint-GUID: YY4J3kIAxNL_VD5i_BagE8Q0J-JxzZyZ
X-Proofpoint-ORIG-GUID: YY4J3kIAxNL_VD5i_BagE8Q0J-JxzZyZ

On 3/12/24 6:20 PM, Yu Kuai wrote:

> Hi,
>
> 在 2024/03/13 6:56, junxiao.bi@oracle.com 写道:
>> On 3/10/24 6:50 PM, Yu Kuai wrote:
>>
>>> Hi,
>>>
>>> 在 2024/03/09 7:49, junxiao.bi@oracle.com 写道:
>>>> Here is the root cause for this issue:
>>>>
>>>> Commit 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in 
>>>> raid5d") introduced a regression, it got reverted through commit 
>>>> bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
>>>> raid5d"). To fix the original issue commit 5e2cf333b7bd was fixing, 
>>>> commit d6e035aad6c0 ("md: bypass block throttle for superblock 
>>>> update") was created, it avoids md superblock write getting 
>>>> throttled by block layer which is good, but md superblock write 
>>>> could be stuck in block layer due to block flush as well, and that 
>>>> is what was happening in this regression report.
>>>>
>>>> Process "md0_reclaim" got stuck while waiting IO for md superblock 
>>>> write done, that IO was marked with REQ_PREFLUSH | REQ_FUA flags, 
>>>> these 3 steps ( PREFLUSH, DATA and POSTFLUSH ) will be executed 
>>>> before done, the hung of this process is because the last step 
>>>> "POSTFLUSH" never done. And that was because of  process 
>>>> "md0_raid5" submitted another IO with REQ_FUA flag marked just 
>>>> before that step started. To handle that IO, blk_insert_flush() 
>>>> will be invoked and hit "REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH" case 
>>>> where "fq->flush_data_in_flight" will be increased. When the IO for 
>>>> md superblock write was to issue "POSTFLUSH" step through 
>>>> blk_kick_flush(), it found that "fq->flush_data_in_flight" was not 
>>>> zero, so it will skip that step, that is expected, because flush 
>>>> will be triggered when "fq->flush_data_in_flight" dropped to zero.
>>>>
>>>> Unfortunately here that inflight data IO from "md0_raid5" will 
>>>> never done, because it was added into the blk_plug list of that 
>>>> process, but "md0_raid5" run into infinite loop due to 
>>>> "MD_SB_CHANGE_PENDING" which made it never had a chance to finish 
>>>> the blk plug until "MD_SB_CHANGE_PENDING" was cleared. Process 
>>>> "md0_reclaim" was supposed to clear that flag but it was stuck by 
>>>> "md0_raid5", so this is a deadlock.
>>>>
>>>> Looks like the approach in the RFC patch trying to resolve the 
>>>> regression of commit 5e2cf333b7bd can help this issue. Once 
>>>> "md0_raid5" starts looping due to "MD_SB_CHANGE_PENDING", it should 
>>>> release all its staging IO requests to avoid blocking others. Also 
>>>> a cond_reschedule() will avoid it run into lockup.
>>>
>>> The analysis sounds good, however, it seems to me that the behaviour
>>> raid5d() pings the cpu to wait for 'MD_SB_CHANGE_PENDING' to be cleared
>>> is not reasonable, because md_check_recovery() must hold
>>> 'reconfig_mutex' to clear the flag.
>>
>> That's the behavior before commit 5e2cf333b7bd which was added into 
>> Sep 2022, so this behavior has been with raid5 for many years.
>>
>
> Yes, it exists for a long time doesn't mean it's good. It is really
> weird to hold spinlock to wait for a mutex.
I am confused about this, where is the code that waiting mutex while 
holding spinlock, wouldn't that cause a deadlock?
>>
>>>
>>> Look at raid1/raid10, there are two different behaviour that seems can
>>> avoid this problem as well:
>>>
>>> 1) blk_start_plug() is delayed until all failed IO is handled. This 
>>> look
>>> reasonable because in order to get better performance, IO should be
>>> handled by submitted thread as much as possible, and meanwhile, the
>>> deadlock can be triggered here.
>>> 2) if 'MD_SB_CHANGE_PENDING' is not cleared by md_check_recovery(), 
>>> skip
>>> the handling of failed IO, and when mddev_unlock() is called, daemon
>>> thread will be woken up again to handle failed IO.
>>>
>>> How about the following patch?
>>>
>>> Thanks,
>>> Kuai
>>>
>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>> index 3ad5f3c7f91e..0b2e6060f2c9 100644
>>> --- a/drivers/md/raid5.c
>>> +++ b/drivers/md/raid5.c
>>> @@ -6720,7 +6720,6 @@ static void raid5d(struct md_thread *thread)
>>>
>>>         md_check_recovery(mddev);
>>>
>>> -       blk_start_plug(&plug);
>>>         handled = 0;
>>>         spin_lock_irq(&conf->device_lock);
>>>         while (1) {
>>> @@ -6728,6 +6727,14 @@ static void raid5d(struct md_thread *thread)
>>>                 int batch_size, released;
>>>                 unsigned int offset;
>>>
>>> +               /*
>>> +                * md_check_recovery() can't clear sb_flags, usually 
>>> because of
>>> +                * 'reconfig_mutex' can't be grabbed, wait for 
>>> mddev_unlock() to
>>> +                * wake up raid5d().
>>> +                */
>>> +               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
>>> +                       goto skip;
>>> +
>>>                 released = release_stripe_list(conf, 
>>> conf->temp_inactive_list);
>>>                 if (released)
>>>                         clear_bit(R5_DID_ALLOC, &conf->cache_state);
>>> @@ -6766,8 +6773,8 @@ static void raid5d(struct md_thread *thread)
>>> spin_lock_irq(&conf->device_lock);
>>>                 }
>>>         }
>>> +skip:
>>>         pr_debug("%d stripes handled\n", handled);
>>> -
>>>         spin_unlock_irq(&conf->device_lock);
>>>         if (test_and_clear_bit(R5_ALLOC_MORE, &conf->cache_state) &&
>>>             mutex_trylock(&conf->cache_size_mutex)) {
>>> @@ -6779,6 +6786,7 @@ static void raid5d(struct md_thread *thread)
>>>                 mutex_unlock(&conf->cache_size_mutex);
>>>         }
>>>
>>> +       blk_start_plug(&plug);
>>>         flush_deferred_bios(conf);
>>>
>>>         r5l_flush_stripe_to_raid(conf->log);
>>
>> This patch eliminated the benefit of blk_plug, i think it will not be 
>> good for IO performance perspective?
>
> There is only one daemon thread, so IO should not be handled here as
> much as possible. The IO should be handled by the thread that is
> submitting the IO, and let daemon to hanldle the case that IO failed or
> can't be submitted at that time.

I am not sure how much it will impact regarding drop the blk_plug.

Song, what's your take on this?

Thanks,

Junxiao.

>
> Thanks,
> Kuai
>
>>
>>
>> Thanks,
>>
>> Junxiao.
>>
>>>
>>>>
>>>> https://www.spinics.net/lists/raid/msg75338.html
>>>>
>>>> Dan, can you try the following patch?
>>>>
>>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>>> index de771093b526..474462abfbdc 100644
>>>> --- a/block/blk-core.c
>>>> +++ b/block/blk-core.c
>>>> @@ -1183,6 +1183,7 @@ void __blk_flush_plug(struct blk_plug *plug, 
>>>> bool from_schedule)
>>>>          if (unlikely(!rq_list_empty(plug->cached_rq)))
>>>>                  blk_mq_free_plug_rqs(plug);
>>>>   }
>>>> +EXPORT_SYMBOL(__blk_flush_plug);
>>>>
>>>>   /**
>>>>    * blk_finish_plug - mark the end of a batch of submitted I/O
>>>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>>>> index 8497880135ee..26e09cdf46a3 100644
>>>> --- a/drivers/md/raid5.c
>>>> +++ b/drivers/md/raid5.c
>>>> @@ -6773,6 +6773,11 @@ static void raid5d(struct md_thread *thread)
>>>> spin_unlock_irq(&conf->device_lock);
>>>>                          md_check_recovery(mddev);
>>>> spin_lock_irq(&conf->device_lock);
>>>> +               } else {
>>>> + spin_unlock_irq(&conf->device_lock);
>>>> +                       blk_flush_plug(&plug, false);
>>>> +                       cond_resched();
>>>> + spin_lock_irq(&conf->device_lock);
>>>>                  }
>>>>          }
>>>>          pr_debug("%d stripes handled\n", handled);
>>>>
>>>> Thanks,
>>>>
>>>> Junxiao.
>>>>
>>>> On 3/1/24 12:26 PM, junxiao.bi@oracle.com wrote:
>>>>> Hi Dan & Song,
>>>>>
>>>>> I have not root cause this yet, but would like share some findings 
>>>>> from the vmcore Dan shared. From what i can see, this doesn't look 
>>>>> like a md issue, but something wrong with block layer or below.
>>>>>
>>>>> 1. There were multiple process hung by IO over 15mins.
>>>>>
>>>>> crash> ps -m | grep UN
>>>>> [0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0 CPU: 1 
>>>>> COMMAND: "jbd2/dm-3-8"
>>>>> [0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0 CPU: 2 
>>>>> COMMAND: "dd"
>>>>> [0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00 CPU: 3 
>>>>> COMMAND: "md0_reclaim"
>>>>> [0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740 CPU: 1 
>>>>> COMMAND: "kworker/1:2"
>>>>> [0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80 CPU: 7 
>>>>> COMMAND: "kworker/u21:1"
>>>>>
>>>>> 2. Let pick md0_reclaim to take a look, it is waiting done 
>>>>> super_block update. We can see there were two pending superblock 
>>>>> write and other pending io for the underling physical disk, which 
>>>>> caused these process hung.
>>>>>
>>>>> crash> bt 876
>>>>> PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: 
>>>>> "md0_reclaim"
>>>>>  #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
>>>>>  #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
>>>>>  #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
>>>>>  #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
>>>>>  #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
>>>>>  #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
>>>>>  #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
>>>>>  #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
>>>>>  #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
>>>>>
>>>>> crash> mddev.pending_writes,disks 0xffff888108335800
>>>>>   pending_writes = {
>>>>>     counter = 2  <<<<<<<<<< 2 active super block write
>>>>>   },
>>>>>   disks = {
>>>>>     next = 0xffff88810ce85a00,
>>>>>     prev = 0xffff88810ce84c00
>>>>>   },
>>>>> crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
>>>>> 0xffff88810ce85a00
>>>>> ffff88810ce85a00
>>>>>   kobj.name = 0xffff8881067c1a00 "dev-dm-1",
>>>>>   nr_pending = {
>>>>>     counter = 0
>>>>>   },
>>>>> ffff8881083ace00
>>>>>   kobj.name = 0xffff888100a93280 "dev-sde",
>>>>>   nr_pending = {
>>>>>     counter = 10 <<<<
>>>>>   },
>>>>> ffff8881010ad200
>>>>>   kobj.name = 0xffff8881012721c8 "dev-sdc",
>>>>>   nr_pending = {
>>>>>     counter = 8 <<<<<
>>>>>   },
>>>>> ffff88810ce84c00
>>>>>   kobj.name = 0xffff888100325f08 "dev-sdd",
>>>>>   nr_pending = {
>>>>>     counter = 2 <<<<<
>>>>>   },
>>>>>
>>>>> 3. From block layer, i can find the inflight IO for md superblock 
>>>>> write which has been pending 955s which matches with the hung time 
>>>>> of "md0_reclaim"
>>>>>
>>>>> crash> 
>>>>> request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
>>>>> ffff888103b4c300
>>>>>   q = 0xffff888103a00d80,
>>>>>   mq_hctx = 0xffff888103c5d200,
>>>>>   cmd_flags = 38913,
>>>>>   rq_flags = 139408,
>>>>>   start_time_ns = 1504179024146,
>>>>>   bio = 0x0,
>>>>>   biotail = 0xffff888120758e40,
>>>>>   state = MQ_RQ_COMPLETE,
>>>>>   __data_len = 0,
>>>>>   flush = {
>>>>>     seq = 3, <<<< REQ_FSEQ_PREFLUSH | REQ_FSEQ_DATA
>>>>>     saved_end_io = 0x0
>>>>>   },
>>>>>   end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,
>>>>>
>>>>> crash> p tk_core.timekeeper.tkr_mono.base
>>>>> $1 = 2459916243002
>>>>> crash> eval 2459916243002-1504179024146
>>>>> hexadecimal: de86609f28
>>>>>     decimal: 955737218856  <<<<<<< IO pending time is 955s
>>>>>       octal: 15720630117450
>>>>>      binary: 
>>>>> 0000000000000000000000001101111010000110011000001001111100101000
>>>>>
>>>>> crash> bio.bi_iter,bi_end_io 0xffff888120758e40
>>>>>   bi_iter = {
>>>>>     bi_sector = 8, <<<< super block offset
>>>>>     bi_size = 0,
>>>>>     bi_idx = 0,
>>>>>     bi_bvec_done = 0
>>>>>   },
>>>>>   bi_end_io = 0xffffffff817dca50 <super_written>,
>>>>> crash> dev -d | grep ffff888103a00d80
>>>>>     8 ffff8881003ab000   sdd        ffff888103a00d80 0 0 0
>>>>>
>>>>> 4. Check above request, even its state is "MQ_RQ_COMPLETE", but it 
>>>>> is still pending. That's because each md superblock write was 
>>>>> marked with REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 
>>>>> steps: pre_flush, data, and post_flush. Once each step complete, 
>>>>> it will be marked in "request.flush.seq", here the value is 3, 
>>>>> which is REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA, so the last step 
>>>>> "post_flush" has not be done. Another wired thing is that 
>>>>> blk_flush_queue.flush_data_in_flight is still 1 even "data" step 
>>>>> already done.
>>>>>
>>>>> crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
>>>>>   fq = 0xffff88810332e240,
>>>>> crash> blk_flush_queue 0xffff88810332e240
>>>>> struct blk_flush_queue {
>>>>>   mq_flush_lock = {
>>>>>     {
>>>>>       rlock = {
>>>>>         raw_lock = {
>>>>>           {
>>>>>             val = {
>>>>>               counter = 0
>>>>>             },
>>>>>             {
>>>>>               locked = 0 '\000',
>>>>>               pending = 0 '\000'
>>>>>             },
>>>>>             {
>>>>>               locked_pending = 0,
>>>>>               tail = 0
>>>>>             }
>>>>>           }
>>>>>         }
>>>>>       }
>>>>>     }
>>>>>   },
>>>>>   flush_pending_idx = 1,
>>>>>   flush_running_idx = 1,
>>>>>   rq_status = 0 '\000',
>>>>>   flush_pending_since = 4296171408,
>>>>>   flush_queue = {{
>>>>>       next = 0xffff88810332e250,
>>>>>       prev = 0xffff88810332e250
>>>>>     }, {
>>>>>       next = 0xffff888103b4c348, <<<< the request is in this list
>>>>>       prev = 0xffff888103b4c348
>>>>>     }},
>>>>>   flush_data_in_flight = 1,  >>>>>> still 1
>>>>>   flush_rq = 0xffff888103c2e000
>>>>> }
>>>>>
>>>>> crash> list 0xffff888103b4c348
>>>>> ffff888103b4c348
>>>>> ffff88810332e260
>>>>>
>>>>> crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of 
>>>>> hw queue
>>>>>   tag = -1,
>>>>>   state = MQ_RQ_IDLE,
>>>>>   ref = {
>>>>>     counter = 0
>>>>>   },
>>>>>
>>>>> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may 
>>>>> have some issue which leading to the io request from md layer 
>>>>> stayed in a partial complete statue. I can't see how this can be 
>>>>> related with the commit bed9e27baf52 ("Revert "md/raid5: Wait for 
>>>>> MD_SB_CHANGE_PENDING in raid5d"")
>>>>>
>>>>>
>>>>> Dan,
>>>>>
>>>>> Are you able to reproduce using some regular scsi disk, would like 
>>>>> to rule out whether this is related with virtio-scsi?
>>>>>
>>>>> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
>>>>> official mainline v6.8-rc5 without any other patches?
>>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>> Junxiao.
>>>>>
>>>>> On 2/23/24 6:13 PM, Song Liu wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
>>>>>> Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>> On 21.02.24 00:06, Dan Moulding wrote:
>>>>>>>> Just a friendly reminder that this regression still exists on the
>>>>>>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>>>>>>> development system to 6.8-rc5 today and immediately hit this issue
>>>>>>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>>>>>>> Song Liu, what's the status here? I aware that you fixed with 
>>>>>>> quite a
>>>>>>> few regressions recently, but it seems like resolving this one is
>>>>>>> stalled. Or were you able to reproduce the issue or make some 
>>>>>>> progress
>>>>>>> and I just missed it?
>>>>>> Sorry for the delay with this issue. I have been occupied with some
>>>>>> other stuff this week.
>>>>>>
>>>>>> I haven't got luck to reproduce this issue. I will spend more 
>>>>>> time looking
>>>>>> into it next week.
>>>>>>
>>>>>>> And if not, what's the way forward here wrt to the release of 6.8?
>>>>>>> Revert the culprit and try again later? Or is that not an option 
>>>>>>> for one
>>>>>>> reason or another?
>>>>>> If we don't make progress with it in the next week, we will do 
>>>>>> the revert,
>>>>>> same as we did with stable kernels.
>>>>>>
>>>>>>> Or do we assume that this is not a real issue? That it's caused 
>>>>>>> by some
>>>>>>> oddity (bit-flip in the metadata or something like that?) only 
>>>>>>> to be
>>>>>>> found in Dan's setup?
>>>>>> I don't think this is because of oddities. Hopefully we can get more
>>>>>> information about this soon.
>>>>>>
>>>>>> Thanks,
>>>>>> Song
>>>>>>
>>>>>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression 
>>>>>>> tracker' hat)
>>>>>>> -- 
>>>>>>> Everything you wanna know about Linux kernel regression tracking:
>>>>>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>>>>>> If I did something stupid, please tell me, as explained on that 
>>>>>>> page.
>>>>>>>
>>>>>>> #regzbot poke
>>>>>>>
>>>>
>>>> .
>>>>
>>>
>> .
>>
>

