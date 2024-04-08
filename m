Return-Path: <linux-kernel+bounces-135864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7089CC45
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C0C1C224F2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456F145359;
	Mon,  8 Apr 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Imp4gCCb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kWrSlaHu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF510F51B;
	Mon,  8 Apr 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603550; cv=fail; b=UHBdkN8sWhHQMn04zf7ERb2fyGGyG4LWuymkcq+TCMQZqzHl/9vFyiKQJ/DaRMQxZeWC1e9wKp2HVQM0eWpwEEeDFikpy+XcRIT1cvXGyU543R3U9ld03VFMKkMMM9SQJbNgU1PwIKfKVRZJAPhKvyK0xFxkSVm9SHKuoh1aZRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603550; c=relaxed/simple;
	bh=dQ4tKGD4/9JEO2ljrb5PBPH7Sv0ZRPgFu3vp0TJTEa0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=FEhmzGWRSZ8kP7VZoKTCKYA9K8cjAXeGUOGq1z5iEZwsmymUq6uMP1KE4EyqaXt5WTM2y8fELxNPcpXZSFZIZejWuXyKO4kyR3Kw4nIwbxaufMdA/0RaTeYFaM7pvza+MpRY1JeKF9ac0wJGQM/mJRFaFKsZZd8drjp7if1eqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Imp4gCCb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kWrSlaHu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 438ENprN012239;
	Mon, 8 Apr 2024 19:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XQ8rJQFEiWkTQmRdZdq7iUmyDN+8A2IbDTVj7g4VD3U=;
 b=Imp4gCCbFUTpKujngpPVO7fwnwK7oacbu9yzRrdvk3J/dmdEOxOH+GEMYY4pUx5WCvFl
 WRbD5KVRWmFjbkeRPboRbTBdpFtGyCv8hhk2swqmu8odLVrs3yzYPadghlAGTbpaf/Dn
 KaQFDKgU2x02P1YWyzbJCMdfRAy4sBxhPCbi0LOVVPRhDTqHFGfAEF+EuhiE76KG1AmE
 bGWqHz6aczqJxL5ruukfJZwdTUnmJI9Wb2UcDJ4SLtY8S+8uMog4i0wJVkREzIWU0IJl
 vb0K2pj9EQbC8NHZ8kqRXc3nPoz9rhZYFSrbsiNev1yAlret+TajYpVQXsXAks/f2A8T 5g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax0ukg5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 19:12:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 438Ifr8I007875;
	Mon, 8 Apr 2024 19:12:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu5w5s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Apr 2024 19:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gu4VwYdZQRT5m1BG3ej/TprO4KU514Vq8iTfkQ1XXcC0DNYbOwEVf0LyLt5WyWvvIbzdZnWpnju7/IBf6TD5CEEYEi78WxhFl9OfFU2WxhIEzuZ3qQ9N2JTSiyK77bTOJzMs80M+iGVuVKoLOY+rA8z4Gx6tDa2RigI1iD96GpBbFC/QV/06Chc9NlHiThY/RZYUysNTeeXSHWQWsIZGc7N+4+w80gRLMkfOQXovv3rzg0cEEg19zhJWr/5BTuFI9f47jdmqAyJrfwxh6GvKHpJ/5vs5jcGk5/3j07+2rotQQB8VPd6XpS1PmV+nXeYfKWLAlpkpxT5OjEFFbhevPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ8rJQFEiWkTQmRdZdq7iUmyDN+8A2IbDTVj7g4VD3U=;
 b=dvpV8bFhyWphCQKyi1aUybt7+C8T+IOY7orHbJyI9ObbT2JlujLi5BEs7Aqd/ZDFDpQvcNYh+s2/boUYdNJijNVJQY3D0JZvJ56p6a6aCiZzsA8XZk0y3D8tR6iUax+D02G8TJC0/edbQrszyupJegPKh0EZw954tl7VJibsJRPDDZV3wSUIBoij/ckOv0YKzCdzJavnVWQC7zymKDkuhMe/Tk14NgToI93p7E6jqe4LuEKmMwVsFbJC5cTDZzciRO+hmbYBJObtH6bF0UPmkVtJ20YnvMgZ9mUJpe6TgvBmXQVXgDpe+PVwxgCkrs9MVb8LK+ZwYi+SHykQl8CR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ8rJQFEiWkTQmRdZdq7iUmyDN+8A2IbDTVj7g4VD3U=;
 b=kWrSlaHubYXI9foqdJI6wYjRPI9EAz/+qSec4hdt2jqBVOEZqi04UVIIJDjEpLGrmmQE717XyfpzpZ/iElqr/1yqu3VjVDNLW5zDEGsA1oQ/VdZl2D3ImE5s49Pjnk78T5Zb9oNdbjzb1HDTQnyEaLxifhvUpboZ5mip0dnEDWA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB7475.namprd10.prod.outlook.com (2603:10b6:8:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 19:12:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 19:12:18 +0000
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Pundir
 <amit.pundir@linaro.org>
Subject: Re: [PATCH v2 0/2] scsi: ufs: qcom: Add missing interconnect
 bandwidth values for Gear 5
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240406035642.GB2678@thinkpad> (Manivannan Sadhasivam's message
	of "Sat, 6 Apr 2024 09:26:42 +0530")
Organization: Oracle Corporation
Message-ID: <yq1a5m3pt33.fsf@ca-mkp.ca.oracle.com>
References: <20240403-ufs-icc-fix-v2-0-958412a5eb45@linaro.org>
	<yq1o7anqo62.fsf@ca-mkp.ca.oracle.com>
	<20240406035642.GB2678@thinkpad>
Date: Mon, 08 Apr 2024 15:12:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:208:134::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB7475:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9KqxIjqhJ9w3xyxnGsO+HW/bTPymyzwtuGdFYKtj0WdUc5SDQymI72zwPnm2PynAXhrLcWXomX+TNaHX170iAynJeOTGIttWCULBqSmIpmS7X6Kruqt5lUYMBcmTLzow4UutJK56DOksO6c68LAvpJZiDXMF2QvEOARyJJ+mHBV2uR14nmkypxfjGepuJlpCe7chFiYhmOdD1Gwy4sefg8sKmpf8L4A3hY/Ts320Q7j/DDSEsm7QcwUJFSqQEp0labJ4sRN10py/YCKVvL+6D6IxdidHZHbEFZ15koyiRBz4zgtqN6t3YQSJTLcYsHS6f6mBdgTVARkv60np+GsbxxwgVZif8R80O00Hjzm6xSVF5XfPs+lPBiW0JzfxWzQKZ6rYfPZYquDwF3xCWuHmxMLFhH+4SxZBlfN8uCWj40d4dleJE384AxMm4quhy9G+I1/pM5pO8q8M5inMJSpADlZ5gsCsrl33mdXiQIjigGTB4irHeW5IB71/mJsO4Qqi+mqCFZssodl237vKrIVTweDiabNgoGExiSevuyUJW6hEdqHnx1/z/DttEiDDTKK1ZkhPZOC1uXGx48ycY6ZWF/s73HJUarNOCKCvdXOv7th9MoEnjNpSbtRgmFGZJnn1tA7YxTOn7y5BtXYmzLKDN6vxFPf6gCTr5sBZV3reAy4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xdByDDVnidah2oEbVjGmQ1BdvfQZLvk1sfNlKU6wd9fIxqWFX92ey2fwyOd3?=
 =?us-ascii?Q?24ClF/DPzTeXQqadjzFjsxk7q9hEMjKjfjXGa6xGr/4zP8p+4lv5yHX3q+tz?=
 =?us-ascii?Q?3voF9CEwLhlqXJYpq2nunBi4QTeoTJoK+ChZhy/rqI2gvHrLXdVVCuO4kygw?=
 =?us-ascii?Q?GPf2O6HNoTOVr0guyUi1vwUjlz804HVC2ogOZwQqD36bg1YBL01yFByy/85Z?=
 =?us-ascii?Q?R/dT9Jq3tg/q7yr9Fnp2GGpVOCo9btus+D0jsuVrmxa+5wjuCW55CBEEnh4o?=
 =?us-ascii?Q?bsTJ10oEjwQ4izOtuNMhOPqHHyQPXeiLChfQCuulhdb1t32ExL56llXMHD4G?=
 =?us-ascii?Q?3dwrD9Zx66vlpjijLPKGB4xUiWVPA8SLRQQzx//4RcHukEeaJEEzJU6Yer2t?=
 =?us-ascii?Q?RzAS5W1FY54XSyuWUrZfhRH+BWhZrA5Wftd81mjt+5cLClsS5vRCc+2GPsWB?=
 =?us-ascii?Q?uINf2xlNBRLeM87LDeTEWlSt9WRBsjwpktPzTrc3Ck2GdFWEtWrJw8GMFzhB?=
 =?us-ascii?Q?/adE6j2Gg8qDpxceUYH1HOV7HxoUx8a0Jnl7gDGisLMCk5AANGAKoXk6RSXG?=
 =?us-ascii?Q?gtx+eHe7PqIAv/Np2i0sW4RbWxxX/EIsf06tp1ok6Ts71n6/c56GBuIV9Pl5?=
 =?us-ascii?Q?9jMVDYN8f+V31KNL+wOTNR8qYHR4aG04INNGVD6WiGkSN7FeYSyxVWsmdC2j?=
 =?us-ascii?Q?zA8mNBwKtRwPxAzwy3UJHK/K61J/YP6UPsTb7AK1G0jAQ1NhuE8mJaLXjz71?=
 =?us-ascii?Q?rJoQ6Ub5MPvFSpso1dkNYswyOk4N13wHbC6PR7wLqmsqFtWPsdZ5YboGOBTI?=
 =?us-ascii?Q?MYPa8GM+YA7nYq0cmQ16qCuu4lwZK+ba9ZCxal4Go4tVXyYdXzE+Vh+q4I/D?=
 =?us-ascii?Q?M4D80ZoPqJ1TZI8dBDNrwJGvvsxcG6Gi37UPiaZlcmlR5kdCSMnAIqpfqgEO?=
 =?us-ascii?Q?1PXfSo/sUEHH7uXIY1eiTf6hYDklJ0Rv9mvg2U4Bhjr0dTJB+rMV0MB0e+q4?=
 =?us-ascii?Q?MCayVUecwWOfGXJluUdFGDQbjrUFlCE8YAfDDJTEG5uaee/Oj9ij03rYAL29?=
 =?us-ascii?Q?fxAEuhjIAoyqE7ytHGcPOK95OXO/b9JN4hRygnbnmjfLzjZJaFs1EyZB2Ls7?=
 =?us-ascii?Q?NDPCpYzpm8UTYahDWlw7tBtrN9lcXD09M2CNeZ5NCVlHyWqp2YoA14TalC8P?=
 =?us-ascii?Q?tT6MRDbQfldSw3zfv/K6ZGNdfHENE6HmiWK+xXLxQI6RaNM7irVwUxhODftU?=
 =?us-ascii?Q?w9EQ4H/QDwYvnyknvMTQJ+DP8tsFdLP+WTt6vnl9KQb+0JzTrDj4JE4dKmHo?=
 =?us-ascii?Q?6tlS4oi3nNFrGT2YaC9bKdr6HqKvLhkBBkDixN1/PS31K/3+3sIuUj6iajEb?=
 =?us-ascii?Q?+xzc5LkkQw/0YQuid/d7IyJIInzwnnf4c0UjMOfmMElXthBmfHBSZ/qoTfcZ?=
 =?us-ascii?Q?tTg2HVyPPemuvIUbneiM+iNuq8zpU8hFh9uaILaR3imfLbc5YUbPtO2I8mwZ?=
 =?us-ascii?Q?44U+Bb3IGZOjE37GbzdVvr2P4nzX3ZVl2LTR5bz5lA4Pq52XDR6qkGP9XONw?=
 =?us-ascii?Q?B0Rj0MH1YPb4EiJlIfgxvG2nsrYJvci3lzdDHPcWLr/VA3cJzgX7JP4gOmlx?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0nAGGxbYlMV3vtM0s24/131pf63f6CoPA1qbVwH/mSMQwN52yihzKEE7pQSF+CcR+0baFXKNE8te9VV9myjpDpqxTHLdsnVCMQskRowfGAl36/NaerBvLxn1bu9jOqkkBqoGtWN9Vgo9VGrOHj6+MCykthkTZ0I47ne5Qf0UHdyLC6WWT5tJKl6C/3xt8dKMyM7RSHXIGpPCUqbcorFuQYOBjUXl01/M9XDm/Vql0mKWHt3zBO6j+XLJqHOjiwOONxPcZfg1xbQVvmRAqoE05GU1O6fsYyMDHIS7HaWseUkUvI6ir/Gs9mJ2jLe5+EinTD9cVSlsbMXdTzU/QzhJ/foa2JeaO5o2Sazr4/QkIE8RS5TmDsLAEs+9TijUE4P3JdI4ZfNJ7ZhWxQdfR0KF2+/1VFZJBygC1Lby6USc6U+Fyse6TfC3z5Oa/BbsevL4VCInQU2bPV1hoH/xycVbWP8mFnjWtcHmrPDgavha9Y20kvxUZ89AxeEhlmysT3T/CsJ7W+DAgPBL78F6ZEC55b4EYZSmdgSSv3k3sroGVsSvb+kQNGE+i/jRhcw5YVRQkb0S6OBtBhQtIjxqZ78So0f2ZFQ5/w9y94WypdkJJdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa263de-2ab2-4177-caee-08dc57ffcef4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 19:12:18.1354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/fFcauF8dEHq2EGqbPQRd3CxKLNImSneR4utPk2ptK98d2SqUQ2Av+f2lewt0zM1seCzMfKxJP3z9jAqezn59owlszueWy0cBEri7y6sFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7475
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_16,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404080148
X-Proofpoint-GUID: dwET0qQXXLxOrvvrGGtAoO5M139auOVL
X-Proofpoint-ORIG-GUID: dwET0qQXXLxOrvvrGGtAoO5M139auOVL


Manivannan,

> Thanks Martin! But patch 1/2 is actually a fix that needs to be merged
> for 6.9, since starting from 6.9 we are seeing the crash on some Qcom
> boards.
>
> But patch 2/2 is just an improvement, so it can be part of 6.10.

OK, done!

-- 
Martin K. Petersen	Oracle Linux Engineering

