Return-Path: <linux-kernel+bounces-141785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952B68A236C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C727A1C2267C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529AA4C92;
	Fri, 12 Apr 2024 01:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTjsKPq0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEUAe/4H"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE1179BE;
	Fri, 12 Apr 2024 01:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712886658; cv=fail; b=kMa3qwgRsIRhRvJl9jZ1iniQjAmqisKzW21EGYXPGQZ9HRrIVvIwryhBXQrKkjlQhVWmiDMAV6tO8Ma03cs3MrNF8jgwMgpfbN4xQotYFiZif9hreS2fuaJYOKHhigiJ9fUi/t0eETRd4qOt44IwuF/kOJmRgiuw58Z+p//KJtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712886658; c=relaxed/simple;
	bh=e6yTunzxvyH2+MPu5cwp+eg9LCMCEcKXActIBGslpeQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=bHmy89dorNoeHQbkG5pQ7xN1wZ/t5EOdI2EkFgR9K6ZpDuCz+dl+9YxO20kUpJq3Kdm4DRR9I4tAFrDWlGDiA4JEtAmwJIRD0VOJ+eyxQkJ98Emf8z5y2Njy0pvvOfnMp0uYwPLRx5g0DYbDULoqVv1pIP5tCmEbJJ0y2nIeKvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DTjsKPq0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kEUAe/4H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BNYK00008677;
	Fri, 12 Apr 2024 01:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=t/nicHX16iYVR7FAfQ0/9KnevRSOmnlNRtHK66XUuF8=;
 b=DTjsKPq0HbaJ7x07QM54PMFs1Wh+HV1t9pMmHjbkZmk8kc23VbV7RxrgHdLuJZ+YHFcn
 /piKSXN87wGFOxkjWECpNeSZoQM4HZ8fyuwGo3g0Fjropg9qNauBb1Qm4ygh7esrGmOr
 IG2sL3uQGup77z5OvmklEY4meAMr8ooVcyTv7kIHLYozxuZdj9hmHWRAebryB0qoaAGz
 UQgtr2Wo/tdqP1b4tzPuM+ifhx7UFFzATSfF63t1mCSzODfXAx6PlS2zoI2HnC1FHOxZ
 PK9rst/+R0qBcRhw9hh3Sxs7aeMk6trl/6srYCS1lmj5a5kdNi2Jmi+dScky+N+TQo7v vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xawactvbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:50:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BMwxR9032343;
	Fri, 12 Apr 2024 01:50:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuaynq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 01:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuS6WehDFRpstLEzo6H2pJCJ40rCrINCDrJVW8mMKNUEVHYQNK8zDVhI5xdsVLf16wW4m99Sm9TyOqFU0NVKJqj9teKmticegrn77n6d7fXqz3iVlIIIzfBYynog23UvPDmpsKH8I6i4Db+RmeluXr8t13HQd0uCGzvlTyiDFSJWZZunXQm87TvX8x9/ax5Cz5P0DAYMgSzWInOVC+B4Wadp7rfn1vY0Wl8C8I3h5McDpmH5vzxBYGEHJ8JZwO0eZ4EHapF3FqpJs3NSJlpHj7w3CeLeDutq2GbUXDZP88VsPOHn479Riwve4Id1tKI39Cbsii451y5nES4KdxRBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/nicHX16iYVR7FAfQ0/9KnevRSOmnlNRtHK66XUuF8=;
 b=ZJbY7CoeJ8qBCXFYvt3T7CbUlpu2t9pwQ6x78hWU+SH8u3nXNZ8Ikw4c5TK3Acp2X39LLKQHI6kA8h6hz80hpbT8iGeqi4fVU4Pa9m/zP1J/v3UEyUb3TlKmMnNpjQGFau/jD/0Q/sfrwRVj00Bo9MsWsoj7GHvVSMEa1bPEDvEyWTYqyQer41iPAMGLyGZ2s8sORtMoBEdHLvqMaqtwJAQIREpaWmizV7/KV6rXOj/Q4eY/DDxa48nyDfpxB2QbR7e0E/m322lbRswqTvI54/7o3jE0WO+LdtQctWsaDwWy2GeedcByc8wf/off6jPr36FqIm2QKux/HUTlkFmeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/nicHX16iYVR7FAfQ0/9KnevRSOmnlNRtHK66XUuF8=;
 b=kEUAe/4HyhYFxCOiQ39Pigz2R59vPJzZfo/kZjHk+UBozLqA8iMJ3lpLbp2Vn77/Dk6wC21eyrBDKEzhpfx0mP+DjAmgDufoo6eH/febuPx/bQgkzD5Xmdzxmbp2pEbxZBNhqeHKoIHl0lyCacAmRKR7QkDJVw704SDd+TkuHBg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4667.namprd10.prod.outlook.com (2603:10b6:806:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 01:50:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 01:50:34 +0000
To: Avri Altman <avri.altman@wdc.com>
Cc: "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] scsi: ufs: Remove support for old UFSHCI versions
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240410183720.908-2-avri.altman@wdc.com> (Avri Altman's message
	of "Wed, 10 Apr 2024 21:37:19 +0300")
Organization: Oracle Corporation
Message-ID: <yq17ch3l57o.fsf@ca-mkp.ca.oracle.com>
References: <20240410183720.908-1-avri.altman@wdc.com>
	<20240410183720.908-2-avri.altman@wdc.com>
Date: Thu, 11 Apr 2024 21:50:32 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132F3.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::38) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4667:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ab94fb-d13e-492e-0aca-08dc5a92f137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8notSr+A7W8IBcYWba9IZK4G/WjUdT745+7PAeee3jjWJuYFNuSrC8rs19DnMV/mw55D7x4pG0Z46CCHYx1sS8Xd8mDYF12jVWSyap7iWmpBWThbeXHTS0PIpwwqs/IF4f2ba6QntxgIHV2/4Wi80jIegezcnHib1UMdRxercECmnAFUTWoJ4ekyLMsqsmg204+EsGKKg8BWugCn6NUlRoh69+88spTGOY4A6d22O+88VfByBxxOwCDouR109fVM1aiG/hbcIfsq7Gwc1JDQNRA2kI5wfN1xRM7OEUt3H7Qev9Q5GBioUqpoWruvZgt3tP0hZlCsx5qtkmYDelL+3MMz68GVPa5zO7R/EDrtTmoXRQg4LMINI2R6CR7hZNKYcDXil1sOWUwonyx4Acu55byI9xA+k2mOI6X+WeOpUPJScXiSGJrH2WGSTFwAvv6F5J3OC5OUuVwtJ/zcKJ3s7g64TwkACUoFrL+VlDW/pR7jDCTJKXp+Fsu5+sLkLZHR++DV7HhxabqJgfQm24RJAFOrGJnCR+itSSn+JRKE5FQ7tNx4szf6n3PNh65lu7VYxVUymaNaiZ5oUXFn2YJ2kZ/9uBSjo4VuBn5hH8B/j4TGZNARyS8KpFwgauzHuTim2EQGSo6q4YJpt9/14DfltgQ0t1Gwwiroy+Qa3o96lWY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nKx798KbS2OlNI2UPs0LzNuPCk7Lw6Pcic7w3pOXyFRpNtNGF6UzRboL0o7F?=
 =?us-ascii?Q?vxMlm5TKjnFAsFffmXksxxdT1s8zPpBdx/F44DvoVs7kuDuiJokcIeV6jz3a?=
 =?us-ascii?Q?RkUpuEAbQ4rP+dKZToIfPmS1N1PcsQAg8DbmY1uu8G//XEpTOBJnMp3rmIz7?=
 =?us-ascii?Q?quPiyySfoH50t3RfqO9CoCfyvzMU/gka+gjOVS+svjxwtzX1gvh5RNKif+Qx?=
 =?us-ascii?Q?HoT7f2gESEXCkju2nrbcnFk2kAqi5R6Hds5CyYkio8W81CrDEJcJwkmwlIz/?=
 =?us-ascii?Q?fGF15Wd+VDOPDfw8NNanPdxd60IJ2Ynh2RVvaxQTiZKZMs/IjFHaSwkvE7kh?=
 =?us-ascii?Q?Y+fWeeQ8AXVwUW4Ca+uy+1Tp5VG0UKpcXSW5tsyfbq8NNYX7NH3/CjXBCSuq?=
 =?us-ascii?Q?hXaWSmiT+XlCR0F/x+KsDDCbkMBc3PcEQBEidocnsW0610U/s8HrWiQrsBJY?=
 =?us-ascii?Q?3uxShWKvuSuoZ2tzCH1GtZLp5ofRPk3G75xnk5jAL03wVuJ6xpUWafYSehNI?=
 =?us-ascii?Q?lcSvpxzGSVnaNGcU7B0DbyV9uWgPg7x5JqYaKh93oXfGyC7HDV/saPYXbpK7?=
 =?us-ascii?Q?yblJ2csPS9fszRaD/AFD7iQP7D1YVAXEdixwND4StkqpZFLD6WO8ohrRAF6C?=
 =?us-ascii?Q?y0M+CD+aclnv4mcORzPSH1siVDhlXsGBnoE8pURyRhAm7VBMr0tXBBZ0QjX0?=
 =?us-ascii?Q?AQX+FNKJUJa/1BCoZWbkKM4qpKhQqZrx2HeLA3LAQwVncMOkuo/vW/ARIhQd?=
 =?us-ascii?Q?3KwR9dVPyWOcz+eNa0vbr1qRMvbdPxijXrPfAYfl6T+fNc58aweUFE8DMuvX?=
 =?us-ascii?Q?E1J/ub5hQiP3d8hbS7B3/YUs4Gf6eBJ4kpnYxShf6goYUBTWyvmxQ974dras?=
 =?us-ascii?Q?xwYuwP2FjwOxxgo5PhtI9mS6PmPmVxAAWe1TxJsF0sDckqU2GNUoKvQBkiCS?=
 =?us-ascii?Q?atpIglR2Qe2kpL88WdJJCjCB4CUVM32mxRt54LQxKEQzydp0vtv/OhFrWbYU?=
 =?us-ascii?Q?6IGmcTfc9ddd7ogbeKklc/nSQRABuLzUexA8wWo3Mufx5a+rvIcDrp1LBY1H?=
 =?us-ascii?Q?g1SVLITFc0Zs8p/x6yhiKsbaUVzCxgeqYNZ25DV6KhE51vg+arU5hODvsSZM?=
 =?us-ascii?Q?W/ItT+nAiMucnJTpXKH1bt3Xl8hBf+bgr8h1B9QbN1S7EtpLQzODw/MFqhnU?=
 =?us-ascii?Q?DoPl9pNNzq/ITY86TmUjR+eSYfG9bD0tXUsBb5yxxX+qZJjugLHTMkNF+JCM?=
 =?us-ascii?Q?D6UH+o1qWCZzi4l6b4oU4dXRtOkAgcHhOcnxSMsqNlJRrT32fzyCCF0ZtfkA?=
 =?us-ascii?Q?k34sQ1e9/xxvLqeph6RTWLTxcsrIyxw9qYK05B31iwbndUirGtvhGr9dP+Tr?=
 =?us-ascii?Q?F2W6Z9fhZcZorXa9K//r1WxOIiMQ1b3nrjgH6PnBGdeji+KMOzadAJDJWtJT?=
 =?us-ascii?Q?rxC1LD9kobPSR/GwZz8HAZp7/YhQeUJfdBTw87gC4J7+l9M1nYqfg8FUDqq7?=
 =?us-ascii?Q?N/Uy2WKAcFfUKLuBPvxf3TDnWFUFxSERmioQIwmbHqAN1bOU1uBxtNO9VuFC?=
 =?us-ascii?Q?pgt2NOhBJYXi7aRK44wIINGvK+GbweLpcuMoxrZGCVxa/Agu2BLCSzTPGCBY?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	di3P0oO7SWSguEulfZi/r1GBDYQ0hKHBMevY8VcPa8sC/VlF6V63G9W5h7jhRnqmSl4TS4hABbxk4ZmBvckEp/Jw1QOyee72kEyGtpW1OuMk/kGjYMD/tYpUiMWzXjzzjrI5YwIUu2Rvf9ioG3v8yNhTrE6TMen0Oyj+DxLB+6Z3SDol9ADugCW3yVYGlSuh0kTbGqoQQwl2e+ktcevi1D19Laly/CrnUu70g6KAheR5cvQq9uDckY2AC9wq/sT35TOOH1ZFlBfJ8GDaB9ISwVEoHtZxizZaBvR6FCLuFTrajRSp4iY/wAkm87iWuAVPgtEG9QStVvBRhDqj9LMuHvr/vCek9eBkYQAJMGb90KFYuhzdJl/VSKMQ6LnDyqlZPheGwZhWoOlrSrFOlikmlGlKEGwa/6cUSDNkfNoqdTGMArZIiGEqjNYVnYrzD8/XpbIYD9A5MWOi6Dl+NL+ektruPbMcq+PvGo363PzkAwbuoZc5Glo5j1V0NMr3lIn5j8iOuKUziHc6z/wobgYK0kBjxV5RaHtewRtr3EzEmPaWxbYAxYxoKJ/0xuYy4Fk3oryqnqd5wsapYr25fU9zeO+pSDxCWRcCRs1s/lLuIYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ab94fb-d13e-492e-0aca-08dc5a92f137
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 01:50:34.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scZ9cDpYoOcc+96OvIQIvwvw44BlbF547CSyhkWS52HqFuL9YEMKh5/yOc6Ak1uYNNq2sQhClkKGlDswL1NrE4UjBGn0j3GP76TnfBO+GO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120012
X-Proofpoint-GUID: dfJm1ujEJQ0czfL-9MSB80u_gVRHW_y7
X-Proofpoint-ORIG-GUID: dfJm1ujEJQ0czfL-9MSB80u_gVRHW_y7


Avri,

> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.  To be extra cautious, leave out removal of
> UFSHCI 2.0 support from this patch, and just remove support of host
> controllers prior to UFS2.0.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

