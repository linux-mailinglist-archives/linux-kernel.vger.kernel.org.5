Return-Path: <linux-kernel+bounces-97356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809C87695D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDAB1F21C0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F48D2577B;
	Fri,  8 Mar 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddmoqTXA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9+vNG9d"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177D2577D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917942; cv=fail; b=Hftb6jj23RhUcDQWIPkNNkzTMDQfLdlimf1LH4UInNY60KWHf+XgFxxxOBqESAm8wb9L/aUJVuEVK/Ur6eph9JnLxNeulWuICcZ8aad0OGUvtz7RQPx6hjFCRVxs0yOFm9et3dmEXh+7oYyv0zrFRXrceu4wNiYcj2PYqY0yRsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917942; c=relaxed/simple;
	bh=jLIIwFnrLs/ji4HDuD3/KuMHQqaZUsLRYrbeO/8t8/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p8Y8AcpXVFl9+nOxv5/fgo7xSDFUoYTpboUU7AIS/0INoFJ1nv72aEeBs6D4atan4/+p4KG8OZ+WW0yZhgm/jDgaVSyzlPh/KbH0dzAW9fxo79vwHsN9Ty5wAnDkjWbChuQDeJfU45OV5YpEEB+4s8/f8QLjiLw0f+3nAQFDSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ddmoqTXA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9+vNG9d; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DSxfi030247;
	Fri, 8 Mar 2024 17:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VhJGG760dTrY/cAfUPDrrL/ZG9Wl4fWSvA+H/IbPHhY=;
 b=ddmoqTXAJC87E6HSVRDfwGjFytjxxLAcxbUULuBuTAtaoyg5fjkEGdr6FcxwKqifw+bG
 PJcU4HXPec588A2XxHlzHQx3SK+VwR8ylzi9ZOV1jnw4lbJHVbt4PPuznZheOY9gznE0
 shpkcm2cIwinzY1T8cewzWKNg4wY955NGUTk1HnjckSlpH5Lt+xkKKsJw8JPI7SL2t/B
 HteaIaTCbRmDHLcFZv4BcejyOoAG+7tTF/bOJPcmyD4OM0dMpqlJqg8Z15IsmxdZTDiL
 6i+VIVfy6bARayClWOe3W454Ydyxg5nznbv5N8WV+X3mUl78P2U64f5KVJmS7QocGLyv ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dqj1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 17:11:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428GcuLR027542;
	Fri, 8 Mar 2024 17:11:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjdmm8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 17:11:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oa8ySOLWbqEi/BWcQMUCEAnBURP9CYEdFEWMH2+OjkTVxP5SDMvbJQ7P1hq+wuthpcMrBSkSHTgMbUtBqVX9NvK8EkPTxcp4B5RNEOZD+D6wil1O4g0BDJptr4y5HQHl0O33V0OrXJeA7VEO5RMbsA8KW440v/VddHVcbBxGC4Pji2aSa6oKVhzWJ7poLzNOf99We8zoeXI9GjVzfh8KZoI5Cm3hpo9Io65k0+i3eF6PDaUOaKDhlzPdWfNIYk9zQWdHqA+vA3PxpF9+ISDI14maYCJXAkFNYmFQ8e4ohLW4HRMNE0/eC1rfoWcni0yPTor15Ra2NKPk6FvLIRppdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VhJGG760dTrY/cAfUPDrrL/ZG9Wl4fWSvA+H/IbPHhY=;
 b=hj8PF+CePX39mr6bK2OJWtTR3lXYPlGHIKJdyk2aFAq3+73KXfvAQ0GAmoSMCjXVX2DXk4I6dMlhZk89J5ZKgRp73qjncvQZabn3+hpvO7NtOWC3T6Rf33S6Dj0wZHpTwkTuNORgRx+E2Q3QFYm4l6s3IJjzIGklCeigBtnmYFAHz1snO4pshDJc645CKKZBD/y1bFqw7XZVcxNo5QT8ZCW9fRD8pND7F/0mGi3jqBMj/HMLmnVmykiX9hZrWmeHl5+wlMzurUtrw28/Yi8N8JWeBljyYFbRmW0WiCTGN1li4nGXm1qtbYq8364Ouix9CIuB02ccNmJhR7CjtoFNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VhJGG760dTrY/cAfUPDrrL/ZG9Wl4fWSvA+H/IbPHhY=;
 b=k9+vNG9dv1A/+PSpbA46uip/cDvlG/IQkJhb7ATEwmf9PEvA/8ex888IWURIqct9sP2td1yy34rJXBTm2jo6RWnomRXb1zqAy7+ynefa5yNLTo7SuwR0cz6sWZ2o9c4QfCsHWhfQowS1MqqbYyjtHdTzcOopIs1IPM3hFHToAgo=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN7PR10MB6954.namprd10.prod.outlook.com (2603:10b6:806:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 17:11:44 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443%4]) with mapi id 15.20.7362.030; Fri, 8 Mar 2024
 17:11:44 +0000
Date: Fri, 8 Mar 2024 12:11:41 -0500
From: Daniel Jordan <daniel.m.jordan@oracle.com>
To: Gang Li <gang.li@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Jane Chu <jane.chu@oracle.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v6 7/8] hugetlb: parallelize 2M hugetlb allocation and
 initialization
Message-ID: <icrdkacpdksofftv5jwrwcgojsa7qnby4iuvxsdktuxazivhks@ajcy2shag4nz>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-8-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140422.393911-8-gang.li@linux.dev>
X-ClientProxiedBy: MN2PR22CA0026.namprd22.prod.outlook.com
 (2603:10b6:208:238::31) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SN7PR10MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c555f7c-bfcc-4dd6-4f69-08dc3f92d479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	R+pNEvv6ESMqwJjdnzKciP4KKK6ryNN81xc7fl+Vkq1lcfrJG4w+bDXwF2u1KJj+VgJGjy3n3aG67VniuVHHnnNH129KOSGcFmVIILObGm0vp1ztA8dE5FmtH2jgJf/k8CZ7xY7J60Txu+awJrWljn7qYAM8S/WaYhntNIGR4A21H5gLjHcp7nHyOT2TTZ3FICjfaUQUoom2rw+CGZNTXZ2GjrWzN7cVVVSqt0Snix738TfhAwTM2sPpHq1em1+saAlw9BA9ZNFgTgcvvEz2NNEAJOy+6hKmnJ+wWZV/W9nsSBwYsIPpEcDQxsAsHGQE99CNzvFZ4Q41RebKpveAu5h/MmCGBK7hJ4XVyijpcTzDp8+J2qmghCheFM0Ou+EtZ7fF1ZQo6DAGFWzGQCwj9qytB7Zjp59L+tYfMOGdmCQBBWfDyGnfhOX+tzhQoUAf/lAnw6CVq81yMwmNruCLPME4TENGcWPtpV0vjHr8EMoZeKlHFPnqAI7j0T4n/R+Dsn1e7tekcOvJpjAExKnmfVwALjNuReVnEk6agUZuj+4IKJVD3SohNAfHHqXaMVZ6dX+bDZS1dlJxLNO17B35EBgFhKGT2d6N9IVZLKjM2G7+a6tSAFRdphSrN4FtLEIQ1MetAhxc8bR5+j/aU6GnCUCJJ48a02QH+8YAQYfNi1I=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y4s+sBjpgmzKzwbUTKxgzXJOhgpUfMVdcz0+rswinCMSUukSIodqoUi6krIn?=
 =?us-ascii?Q?wFtb3qMa9LZf0cPUn4u1oTA3P5OvanShl9ZcdHpCeTd/EmvI/uEZW7Ley32Z?=
 =?us-ascii?Q?vcvOtCmlK+aKvSxH5/vaQWPv8Mgbcz7zKzkdQSdgeZqeO6JJMlAmvojBNCn3?=
 =?us-ascii?Q?gC6xTbd9swP/cAsedvLpnD+017or1x1w30AWRFNAcDNvZr+hyZYcHrd/YFHj?=
 =?us-ascii?Q?0wtq5eGxgZ1z5ArdviMGxQ1R6XkkjWaO5wneYhn6jkwiOQZjcuS4aB/AzeO6?=
 =?us-ascii?Q?VgQ7qXBl65YxmEyfspuYeuRZ8VutN4XL8XBin/PhnJuOzL4We4wjWs+Q0kmR?=
 =?us-ascii?Q?2hESmTcFiwtTxlJJLD6cOc2skvNH4isCMZAsIBme55rAil9nGpD+jypIYT4F?=
 =?us-ascii?Q?AgmpnqEmjwr4wq4TJ0en4+5/0qf/25cd79xbhcZ2T6FwQwAcfgHq8WD8K4HC?=
 =?us-ascii?Q?nMbbSGvCk2ROYvfpQKrmGOuZx9XnJhlkB+Vsm16ED0bP2e8kaQyiahB/rXek?=
 =?us-ascii?Q?N2PWmIkDR+3KV6uASuCzpUPWgZxnR2HV4DwNhMZZLUgQAvicpX+hT47AGVxN?=
 =?us-ascii?Q?mT5Nt8J7cbaP3bEK7bPeuhpFDUCUV17PW8L7+Veq4DidjA7f0Ec+RnRXMvtx?=
 =?us-ascii?Q?dpY+rKjvDAYHgpxPGOxwldbpjiENFTU8OYxgJYWmxsNruom8f311tlx4rpZ9?=
 =?us-ascii?Q?mfpJueNWx9w5MQTF8Ul1E9FFCo3nYnpGSms83MNbwuQGmicbhIko/L+9j7aW?=
 =?us-ascii?Q?3+U76grMUVV1YfE5LyiBrSboMYliXuFcBeF2YQexH1APoZ/MhfUFBYVqWp4A?=
 =?us-ascii?Q?lAbkFbtu9QuWlulCOionT1q1Jmd8HwTQKr0j8iNKPgelC/BkOksfVli90Fki?=
 =?us-ascii?Q?veqd8JxajA1uWxo1IqbKNOP3QsnZWQJCsK5bz/mEhoVLJodN/zYqr+chdDca?=
 =?us-ascii?Q?pTD0ld6ToKQHv8NKvdsVhoGjcPvT0K5CWAmNbDkRB+Z0ZDLJP0/b0aUudxvC?=
 =?us-ascii?Q?o6Ki55ZL+yBMI9GkuJqry27m4k6uOmxFkntDYo1aaE3NsLRrLLWGerCsdt9y?=
 =?us-ascii?Q?KfzuKf6nYkN4ANEaDdBgBkyXid0g+DZ5W/bJYpdGWAmDs2w6fUb9iXgHrm3v?=
 =?us-ascii?Q?UkoW4HWT+IQUflMBjC7YFdk0fLQS/bET3l+GojIyC0d6ccPSbzvB0og/eYB1?=
 =?us-ascii?Q?wEBv3nxv4zR9zkbpow7ngLIksBX00UKBeyB6aypYAKnLtbvDkW3MOIqH2ANM?=
 =?us-ascii?Q?HEVcNl20Cym01339GK0EAodnsdCMCWON0+HpZJwXoqxLTwRk5M+XSpH/zkSq?=
 =?us-ascii?Q?zlPPnj9bjqFhFs6P/OZmMCaPfccLFvFN6PhUIHmyioZj5qIU92hBmIl7LkgM?=
 =?us-ascii?Q?AO7TPCKygZM0ToMAEXVM4zP8BgW8dOmg7wDWIDCpLTzQpGrCxocMPLwGYmVw?=
 =?us-ascii?Q?nyGUdy7RIrzxAFlxO03itwWVa/BLTdQEVBRwD8tVU8j5DJxOrSJ0ywuOJTxP?=
 =?us-ascii?Q?LHIDk0h+E/fzuiWUKc2DtxDXkyMoDyNGYe1Jqh13kVymbtm8l+04kP7UCpxB?=
 =?us-ascii?Q?Z5j0hxFyYwqrNAVd+3srkjTexIdKJ1m+3ez9bVgxkF1OfxhYR7OMi5/KvTSn?=
 =?us-ascii?Q?bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	P0VCyJ2RKsDP2y3Mv886C6uRIV0yMTmpHfCmDqWaFxsQxpv7jT7qrRFcdATyY7P+rjl4VB+m6Qw2nMXo7XzsY05tGzexSp/3zmTdh5BOj1Ayitjm5U/CnN0TuNYVIB10E1YG3aMCIvulb1nDTQPhkXPhmQwRphj/C9R6o8q9D5wo5RX686ApDGox5DiIQ5KCcvncxQu5xjZ32pEwIcGopKca8bkd2YVnyHXGdgi+ehxK3VNMP/biAIVJn3MtI55GAo7wexWiIszMR6O0rPRj3LCO6euwli21Vw049Bs1a/kY6U0DGmJVJtQS1dvC0trcK8srC4Ia7NwzlcHxBxjPfEAMYINwRnVwP1+9LVYqRkLWb0OMFGChOkama5BHGneeOGACwJlxCAYxoiDGfunKvYSA8igZ44+AszeJ8XXcKcWn30FvSavZ/ep4Izd7fIiOo5L9XH8iOa74UyZk3sYgaqK3OWmLLP6reW3Hoe3C7WA9yxiSHe62pDNy9wpKLDxl2iAFsM1uhbW5rLNvj21tVjQuVVQR+svc3VTFE3hjheobEZK8EFJZloN7ttY8hcgz7Z3ffZDBBKWZc02UUruq3bwpG7cToNF6V4AHkA1iAl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c555f7c-bfcc-4dd6-4f69-08dc3f92d479
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:11:44.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPAel0EW3Gv+Nrflj1JlEWB8ndIa40EAPVAhJ/u/YkRz9bPPdPFPmQes2ubkHmx1o8U5qX4EZ+Kj2g6Nw0qKe74gOYZnkagvwjuDKC8K8Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080136
X-Proofpoint-GUID: ERRER47xv4goKQ7tFJ1YUkyHvgvSjUin
X-Proofpoint-ORIG-GUID: ERRER47xv4goKQ7tFJ1YUkyHvgvSjUin

Hi,

On Thu, Feb 22, 2024 at 10:04:20PM +0800, Gang Li wrote:
> By distributing both the allocation and the initialization tasks across
> multiple threads, the initialization of 2M hugetlb will be faster,
> thereby improving the boot speed.
> 
> Here are some test results:
>       test case        no patch(ms)   patched(ms)   saved
>  ------------------- -------------- ------------- --------
>   256c2T(4 node) 2M           3336          1051   68.52%
>   128c1T(2 node) 2M           1943           716   63.15%

Great improvement, and glad to see the multithreading is useful here.

>  static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
>  {
> -	unsigned long i;
> -	struct folio *folio;
> -	LIST_HEAD(folio_list);
> -	nodemask_t node_alloc_noretry;
> -
> -	/* Bit mask controlling how hard we retry per-node allocations.*/
> -	nodes_clear(node_alloc_noretry);
> +	struct padata_mt_job job = {
> +		.fn_arg		= h,
> +		.align		= 1,
> +		.numa_aware	= true
> +	};
>  
> -	for (i = 0; i < h->max_huge_pages; ++i) {
> -		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
> -						&node_alloc_noretry);
> -		if (!folio)
> -			break;
> -		list_add(&folio->lru, &folio_list);
> -		cond_resched();
> -	}
> +	job.thread_fn	= hugetlb_pages_alloc_boot_node;
> +	job.start	= 0;
> +	job.size	= h->max_huge_pages;
>  
> -	prep_and_add_allocated_folios(h, &folio_list);
> +	/*
> +	 * job.max_threads is twice the num_node_state(N_MEMORY),
> +	 *
> +	 * Tests below indicate that a multiplier of 2 significantly improves
> +	 * performance, and although larger values also provide improvements,
> +	 * the gains are marginal.
> +	 *
> +	 * Therefore, choosing 2 as the multiplier strikes a good balance between
> +	 * enhancing parallel processing capabilities and maintaining efficient
> +	 * resource management.
> +	 *
> +	 * +------------+-------+-------+-------+-------+-------+
> +	 * | multiplier |   1   |   2   |   3   |   4   |   5   |
> +	 * +------------+-------+-------+-------+-------+-------+
> +	 * | 256G 2node | 358ms | 215ms | 157ms | 134ms | 126ms |
> +	 * | 2T   4node | 979ms | 679ms | 543ms | 489ms | 481ms |
> +	 * | 50G  2node | 71ms  | 44ms  | 37ms  | 30ms  | 31ms  |
> +	 * +------------+-------+-------+-------+-------+-------+
> +	 */
> +	job.max_threads	= num_node_state(N_MEMORY) * 2;
> +	job.min_chunk	= h->max_huge_pages / num_node_state(N_MEMORY) / 2;

For a single huge page, we get min_chunk of 0.  padata doesn't
explicitly handle that, but 'align' happens to save us from div by 0
later on.  It's an odd case, something to fix if there were another
version.


Not sure what efficient resource management means here.  Avoiding lock
contention?  The system is waiting on this initialization to start pid
1.  On big systems, most CPUs will be idle, so why not use available
resources to optimize it more?  max_threads could scale with CPU count
rather than a magic multiplier.

With that said, the major gain is already there, so either way,

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com> # padata

