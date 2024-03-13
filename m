Return-Path: <linux-kernel+bounces-102471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAC187B28C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC3D1C26617
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D43851016;
	Wed, 13 Mar 2024 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ScF6fRp2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sD4BkO4W"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC94F1FE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710360405; cv=fail; b=It9BGe3VBs+oJKpxzfBtpppA6T+WaLijqEep/ZoCraM628vVKFvfxwoD7G3toKBOSKGCZd1kalb/ORqdLMpxsVo18d+QVkWJGPvq/ku5dcioHujjmtD6MiQ/tNaHN+S11NFTkg8RH5DVH/lgSMBkyvH1xyJ2tWFAzZQfeC+SGFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710360405; c=relaxed/simple;
	bh=Ci24qX7oUjiQn+rulV5OFrgsG2tMG17eJjK059fh25E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LAUvoOgbdk5SsqCz2aFnbB4F4GN4BmVrHgosx41rHdR0qKfbBPyAktXU3opUHgGZ5kU/tr2G+MfAT8qCjNeM6liCuylXUtYJ3ZiGavYy72IV7phvm+dvJlh49NxZm0ssaEblYNQYCFntJx4pXifugx5ZRwvKSlDyF2Qqk7QRQVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ScF6fRp2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sD4BkO4W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJNrYj013504;
	Wed, 13 Mar 2024 20:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LvcOAZWN+xFwLcdZmLubHjJWVUK/fP+fzhEOKbUM8lY=;
 b=ScF6fRp246NZNc8KamT4d/ypRliUc7Z9AWteP9Oo0ZDRNc1nvpAbNEDx1YzdcRvET6Mg
 tm4Tw+y0LnsmG1vfAWHa33a7sQH/mPptulO5K3+bbrgvDDH4Y8t50oPWZ6ebMp2ZrXCS
 lVqrliwGWoqQpeIB3AxXQ0663Mp9LC2gWTy8ED2e2ZGEbGfjWG5leKv3QQ1viE6f57BA
 Cp4QDRaCqMGhbMQdFGyMbqIqT9b75noXWQAJ+1LfyesDWKtn1ZZ1zXWLkZxmCtW5XAuA
 UBSwLXBM2VDl69sItmvXuvjwrw/qqcNKsBUixBD+8jGrEgLXgtl0wWHK8BAi44XM8faS ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrej4205g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:06:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DJ0e10033777;
	Wed, 13 Mar 2024 20:06:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre794bdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 20:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNS9OkVsmgUOtaoXOVEKAt4b/2JyebNDElxAuQtV6KrS5M/HWGABUcZynoJg9mvIxnJO4VZGVPnoX/0TPCaaqHTjKBOftrmHQ3J2kXz0/IvjinQUASLLQlEITkYFYOeSyjhrJUVBhLWD9Bk7po85XF3miXQyFSiEbz08WQYM+YH6r0PwG/WWd4GAmav4LwuwBxVKdw/bUqHNV6e3gSa+D0wjvLLX6JlyIuV1IqrsDBZtsPk/5jNQFpdPXFqPDzEDGlYcrYQ4ZA30/SnWwEaIAmLs/Zd+qnse664I8Godwd0poky4yoH3q9hThlgnMRIntJY9r4TaA6LM1bDTPWpSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LvcOAZWN+xFwLcdZmLubHjJWVUK/fP+fzhEOKbUM8lY=;
 b=hlz1YZqeMKmaiStR1+UXmNGV9EKkuBo08u7JjSVa/HrCDbPBa3hSQAs37dEhRN7glhfj4vWfSJ5OZMX4xUdF0i13kWnz8DoMSKrFVc0nUG9iW9MJaUl1RVK0jaecVJccLKC2hfziA0s/XHg4wbh1MmBS5JHsp+0iq/QDD0/a/3oo3E9gCbcvgN+F5ZZZ+r17VlCUAZSSldzPNU4aS6L1w/DbYdEE4OK+LODP4XjZjWhfwXFs5FIV0chboHA85krzmAEH9kat6d2Nj/hlL8N94Ae0OXocQKmTW1xilMtNtQwMSJvs6xinQ0KGOAOASscEWxxNZtdU4U7MkRzJN8kacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvcOAZWN+xFwLcdZmLubHjJWVUK/fP+fzhEOKbUM8lY=;
 b=sD4BkO4WUHflwqJJ+F+o4Vr7pk9T104nEjL1wUAc8jwV8rwIe1BZ1fJk+O8oxikoIRei4M5O5/WYC+JpoBcqlFrMMDyPtgTwss4o2x/hiiSuEGojqKSdyo185LQOTYPTyWKWYATDoperAsA4NRDajh9VIZ0a7VxH0OmhpnQ+tds=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 20:06:16 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::88ef:4ee:6255:5391%5]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 20:06:16 +0000
Message-ID: <0eab402d-f18f-4831-0be3-2ecaea40a62d@oracle.com>
Date: Wed, 13 Mar 2024 16:06:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] sched: Fix build error in "sched/rt: Remove
 default bandwidth control"
Content-Language: en-US
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        David Vernet <void@manifault.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney"
 <paulmck@kernel.org>,
        joseph.salisbury@canonical.com,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-11-joel@joelfernandes.org>
From: Chris Hyser <chris.hyser@oracle.com>
In-Reply-To: <20240313012451.1693807-11-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: c83410ba-5b69-4034-b6cc-08dc43990a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cZV/FW6Q0SZWtjkCRe44mDKlgzH8ts5a/l/YqalXcl/VB4Xk8r7eKV8dniHyWsQ/+iVc7AbIxUpv459+o7W/M6yvPrtA2xOhgOryYghyHzoKxCbuUQYGBmArFNiTRDLs2laGAlQoqThH7KJNJP5PL/ely+3wqTin6kpR59ewwofqbWAt3FaIb6X6synRCyI9yr1v1xjyBOLkGS+Pe06VWm2n9lOAmP25WiEeZ33thQ6iYmLFaTvwuUkhw5+JcPrOyTE1dutrL7bL48OcUdijPLmjbiPk4N/vlH3KaR2eHNvlNlK9kWRRnyIww3Us/6hmvlgJnzW573LCKvmvH1QdV0TFG26pyB4tCGvauw1u6RNeWs7IlbMsC82f/MKrpcyLGPdHwX1Ea6o9iG3MreamtVLH0r82JHOu8sit1FoC+tH2qrY1ykVWJxJMcoMJqA4gMlAj5oYXaU4zRzArE5pPgs0MR3A4FL/HtlmDYaUQWL5UCBGl6zaJcNEDcfd0H35sww8gwqcUCeN3HmCGkRHN2lofhOhtWff/JlaQYkx231aOSszU2W4DQ1M4Zo6Go1ur0Qoz/qS3faPACkQPy7ccx3a+Ux7P6g1+BOob4r819iVMe5HuzEnndw/e68jU0lAAm8gyKdHePpmZf7RHhac3uaNnfFcaaI7oVvQuwgq7Xwu4g699GpuEvGKPignYIYc8PeorlBP1qwmrsTJWc/FMFQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVVRT0lNSHJhenZmeWhnL0hnemdyQ3Q0Z1NvV0dBVC9vNXU5Tm5qVWVDYUth?=
 =?utf-8?B?SnY0L0d5Y1QxK1lacndCdXRYNlNzUTZkVElraUMyMlZLMWNNemZjT0VzWDk4?=
 =?utf-8?B?Q1gwYk5sVHY0OHpJVW9va1hLZ1IzZ2VyL0ZCLzB5SFlQK1kwV1RrcWs5QXhR?=
 =?utf-8?B?UHJMb3ZFZG92ai9EcjRWNEVxYlRkLzg3WHBMWHNKRjh2dzVBamo2OVJ5bURz?=
 =?utf-8?B?UmlJR0RwT29hak1VQ1VNaTl0TmR2bmNsT1pIeGc0ektXM0hNazFuck5zZ3Az?=
 =?utf-8?B?ZEhMV09QZ29hSTkyQ1RXTkk4ai9WZnJDRzhDNHRyUHpENTdLS0x1d1MzM2RK?=
 =?utf-8?B?V2F1UDVLR0RLSVVaUmVhNjdObHFhN2xNOXB4VnN5eHJpTGZTUytvMmdSUzcr?=
 =?utf-8?B?RGpmdEczSFVxb3ltT2w3dDdIUUJFUDhxa2F3VjJkdm1MaFJFSHY0RXB4RW5u?=
 =?utf-8?B?Z0dWblhydG1Eak1ERDVJZkJLMU1iVEFWbUxoUWxac1k2b1poT1BFbHhGOS9L?=
 =?utf-8?B?WVRuT3ZqVFkxbmpvT2t2bGlIVU5KSTF6bFNqYXF4QmlIK3lZNkJxaXgvMVBK?=
 =?utf-8?B?akYra2RlemwyTlJueDlWVVhjL1ZhS0hrOGNPWEhJUkxzMDgyK0lqcUJqdCtt?=
 =?utf-8?B?c0ZrdlNTRVZGc0ovYnJQa0tESncrNW8xNXhsRk94RjJaNUV1eU5QcVRWSlAv?=
 =?utf-8?B?d2pzNWJpa0pBblpGMmxzQUladFB0a1R1S2dBL0M3Y1RoTlRhRmtRK05peVlT?=
 =?utf-8?B?azQ5bkpmK2hXaGNyejU2VUFTQkR6TFFWWWhlTUtuZ2tLdG1jMWFPbFgrZmdy?=
 =?utf-8?B?YmE0WWg1T3hjKzM5RlA3VFUxQzVJUXRFZXJqSW4weUE2d0Mza0l4SkdzNG5y?=
 =?utf-8?B?RHlTNWRpTUJRbTRZcHUxUzFvRGs1Z2VkanhWeGdkejdjTDlKczF3ZWFRSkxO?=
 =?utf-8?B?c0wvTXIwNUNtY0ZRNFdoNGtFb1RpUW9WTnJic1I1eXVTbE1kaXlnY2RnVlY3?=
 =?utf-8?B?b1ZvMnJYdEhmMUpncnd5TFQwUld1dUVIVG5WYkg0dFZOMHdid0I1NjRaNlYw?=
 =?utf-8?B?SFI5alVDMUNBYUFEd0JrcklFUEtOVTZQK0xQYkhQMncrd1lrdDdVUXBadTcy?=
 =?utf-8?B?K3NjblBDaVowWEdoKzFwZ1pRcjA2YU1xQ2VUam8xdy95RXFTUzRQY2ZES0Vm?=
 =?utf-8?B?V3U5SmJJSDBESVpURHNUSkVkU3dkRmpQR2taMmM3RkVxR04xeStIQTh3YnEw?=
 =?utf-8?B?UDJBeGdlc09jWmRidjBUTzZNRS9sVjEyV0dQZW1KV2NWSlRMdGRMWGRBd3NC?=
 =?utf-8?B?Z2FYR01HQ2R2VWcyZVVqbWFDRVZDd0Y5dnJZWjJWR09LNlVJdjQzbGR5d3hD?=
 =?utf-8?B?V3JYZ2VZNlJYaXZKcDJQMGI3aDNFVFVOeW0vVGdlWGNEYVZ4Qk1EVlJKdGFy?=
 =?utf-8?B?eEF0cytSR21PSXBYNEUzTlJvZ00wREZ1a1Zhd01xRE9mRGF0YXBaRmR6ZFJ6?=
 =?utf-8?B?L2RiSUg0cmh1eGc5Nk5rNTlKb2JWUDlza0d4Q1puSE8rZEIzOVNtY2VCVTBF?=
 =?utf-8?B?elpoeEIyaDBzK2dMNndUVlJpQzVIOGpxTnU4WlFlK2tLY0lLV25NZnA2QTFY?=
 =?utf-8?B?RXp5NkJvandpZE5VWmtCa2dNMDFSVEhFRC9EZGhGbnFVb1Y5ZkpONW1iVWVE?=
 =?utf-8?B?Y2h0MEZLR2hZZlM4Q2VvUUczT2w1U3NPQVljNzJmQXpMa0MrdzFhd3BVWFJC?=
 =?utf-8?B?SCtjTytHUVJQRzJURzRxS004WGlqeWRuNVJPYUgvWmZEajJuaXNvNm9nRTVT?=
 =?utf-8?B?eTRGTlVRYnFRTjUrL0VsZFdtTkdZdWFSQ05EUTY3c2Y2S3B0WFdKclVMelJh?=
 =?utf-8?B?N1ZSbjBJelFLRXU2d2h4ZjRZekhhb09PNXJJM2IzZ3ZlVDJ0M3RIOXFNNEcw?=
 =?utf-8?B?OFg3eDhEVEdMMyt2cjZjaXAxb0RGd2tlQ2JrYU1nWnhsVE9Sc1pheFZ1Sjd6?=
 =?utf-8?B?Tm5EbkNaa3V1TTVaV2NzSCtYMkVVbGJ2RWJjVGZDK0dNdXhGbCt2ejgvQUtP?=
 =?utf-8?B?cHJheW12UTVhamVrMGNvUHBPcjV2YUQ1blZ5Ykc4empheFkwVFhPWVVoNGpk?=
 =?utf-8?B?R25uak1LMWU5OWNUaFhndjB4WE50NDRoQUlVdzJpUEhPUG1DY2thaVVZQTc0?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lFPYVnX2z8NT3ktpGLhNXmSwiB17Ixr/Fv5ldD4p4ZA8QioPwL+vz5ZQ2VI2tP3VmPMp0MkdoTNSd5s/3FQg/D0QDHujItSN+ANRnXKsS7IcN19pXynbkKaVA+veNQZToLXq5pq0UiUazjdqB8IHD/7hKk8gje1neQYbThfXWfVcMsOspb8q+rZvU5pNPe71TvpYALsfWGrkWRyhMNStxbqueWYTt0GITt5Mn4mjBnW18FRo/dtIqznQtREqbhGeGDIQIcAHS8YJSj9QBriW200sXfMRLiP7FlWWvYMNO3rfZ0AqW6ayM3RLgRaWhKDIAljhRl06PPfT45FgQgRI05VF4aCNMAO2WKDYoPeJRVIrm/rzUVWX94I5wEdyx297B5y6SmXaPoYtQnts1MDX5UhUw6/8swtIBU6jawnYCQu7ExETlcIKI909ZS/5W/IS06rMvFjc68Y8VEZUsqtc/fVgdOgIUSa/qcqKabDbLCImDY/eXIqZAV6ARKbc8ICRFWCnQCi3/RblN5+B/yOQ9jwmjxdkA5k8vIPmj+QJlYHc9HcbD/RG6JBuZWVH6GxctKo7m/dm2JUwaAA+8ZP3ZY90smnRvSCGFJw9eYXdU/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83410ba-5b69-4034-b6cc-08dc43990a39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 20:06:16.2251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NdqvUW3e2kY8w4TYH/seqlU7Op6NrcU9tJmDiERaaZMgf0iWpVJeRA0NXZXuqn28rrBcKDG3gl3bZi62yTgnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130155
X-Proofpoint-GUID: P9II9HG4gaxu9PeTXeIAgfBj8znIjDu8
X-Proofpoint-ORIG-GUID: P9II9HG4gaxu9PeTXeIAgfBj8znIjDu8


On 3/12/24 21:24, Joel Fernandes (Google) wrote:
> This fixes a build error introduced by  "sched/rt: Remove default
> bandwidth control". The issue happens because a function is unused
> when !CONFIG_SMP. It could be squashed into the original patch.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


Reviewed-by: Chris Hyser <chris.hyser@oracle.com>


> ---
>   kernel/sched/rt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 37bee56a70f7..d3065fe35c61 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -964,8 +964,10 @@ struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
>   	return &cpu_rq(cpu)->rt;
>   }
>   
> +#ifdef CONFIG_SMP
>   static void __enable_runtime(struct rq *rq) { }
>   static void __disable_runtime(struct rq *rq) { }
> +#endif
>   
>   #endif /* CONFIG_RT_GROUP_SCHED */
>   

