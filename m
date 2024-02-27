Return-Path: <linux-kernel+bounces-84034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061AF86A19B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712C21F2B9DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1040A151CD9;
	Tue, 27 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FD3maSms";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pLVxN9uF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19F14F964
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069106; cv=fail; b=pQbg65H6jdAQ5uyfsaLw+pYWPY9yIlSuo9PO0gbLkJ0/DL7AIMEwDWgdDZNdNYpdve8EmCiOlJk1s1MM13SvoNTvYmFDDeaCz3CD21wlS8cmZSBhiSB4fLn+CJQDcHJgK2k0rvL+5AKl58jxjss+wg377yik4DNkUyy5BgUfWNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069106; c=relaxed/simple;
	bh=/eYwOikrUCDVuKr9KMLdNmoISVh7hMe6jTPH/qKs0h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aA6TPLs6Q50uQmQbVDGCzJ7X0/eDXitOwrToCQX5ndnS9e+zXMy+yxZRw5hibyGtm1ZYepMc5d/Xg64jcLj+1fps34Jlo01XnTwrnpORfX3KlNMxJ3s5vU3IbpLH+ZpsXn17fA3blij3OXxkUve5vntrndcTwr+8V9vgws3yHys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FD3maSms; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pLVxN9uF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKJOAC003486;
	Tue, 27 Feb 2024 21:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=+Q9sVchX2vsSiZA5zu2w/eDlHVNWovlOi3r2QVaqye0=;
 b=FD3maSms3XEt29Ep5clc+SWK84BPP91w0zoMRskUzsrF1LU41Ri5Had+QZCpOtCUWAa1
 cOBKXe1ZFBoMAQZ7Lnahl7WSGeSH/gqktj3bPH6JCG+AWIG1TeRikTp2dBqpe/Vhw3Dl
 xSmpVP6YKGPP0hNa8EEzYlPuSS827LG7PVe/3hgZSDnf1UAPDuKFWwL5vp0/D/Ejez1i
 ess73vNgJrQUBPZQqVb/QIfYLrU344zS4dNR3JZeEebOY3//8RuvdkY181OPsnXCF/JH
 jcPanRIIXFVGlzqDnZ171n9oxo1J40zc8XXl3x+Vi76w2nH6STyDsUazHsaRWF7DcFa6 PQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7ccggc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:24:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RKiPeQ009765;
	Tue, 27 Feb 2024 21:24:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w7ve5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 21:24:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFs1IBFHfCN78F5uR/435ogirIM2T1Q3jSbk0KfHx2ooXrdke91AISotcY1rV8c3vtuzmQ4UcVTGo8LZT1NvDwNnUavASHNuMGOhfGWJXCUEgJsbkxA3YTihneC7pYmvGVdA4+98mjfcNvaTsxkClcVAP/rExB9RNT0lliU2yfJrMjTWLLuCAYJUwmMlUpFzHcocQC7BXPyB+hWvsBF2wQwAOlOmD5nqjHjoccfLQD3kyg8hNWMGVbS84AAeyEvsp4sDkgsMZ9bmxne2zQcHkDKHCEKVFKHg7abd7jx97w0fQ6L1U+6cr1SdMH8lPcUZhHRGUo3E27qHoj9bdnjSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q9sVchX2vsSiZA5zu2w/eDlHVNWovlOi3r2QVaqye0=;
 b=XgLrF5iL74Y4ays4dbGFpPgAwAz+zmGPPWtrWfC/Dbn0PDraP4EFUtTyBJEh1GQkcp7k322TyCnfSdAzT/YSTj/7sq3Ve/RcoQ2X2kvCtN2IlyKO7AYMGY8rSpvI/JXOx2/RQCdJdK37+OlD/FZDKFR9YYtlBciyrEqHHl7quqLanVgj23+tph9/dNOkOP/l3o0l110nlXvcjucb9GVdj18bb+Qs5fedLe+3a/5YVKZ3tqqLOrh2Zi4ABQxHquMklFrI34E7hh1oQypKmgsQLwNj071gle5u8Ozyo1XWtbFYrY6fyk3SkT4fSiwpjtbkWUil0/gZohTmKgQwVSi6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q9sVchX2vsSiZA5zu2w/eDlHVNWovlOi3r2QVaqye0=;
 b=pLVxN9uFGmwIZ4qeK6LrezE2XhdEFKRFgoMy2euKiY3gRkR1apP7bl07n9tlVFZAbH24/v8GULNbf9TxMaOZNmYTIO4E1FoU/9RyUODYO6BLthxcwqsRLXUkR+t8BL88vzWti/XheJ5ssfJqIi0+1x1nZlrSWyh8LEa4D+Ig4U4=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS7PR10MB7154.namprd10.prod.outlook.com (2603:10b6:8:da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.39; Tue, 27 Feb 2024 21:24:23 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::16e6:c4e2:745:a0ec%4]) with mapi id 15.20.7292.036; Tue, 27 Feb 2024
 21:24:23 +0000
Date: Tue, 27 Feb 2024 16:24:20 -0500
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
Subject: Re: [PATCH v6 4/8] padata: dispatch works on different nodes
Message-ID: <7g53p42favkoibzg4w3ly3ypdjdy6oymhj74ekwk62bwx4rlaj@seoavjygfadq>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-5-gang.li@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222140422.393911-5-gang.li@linux.dev>
X-ClientProxiedBy: BLAPR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:208:32a::14) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS7PR10MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f65d76-fe32-491e-30d6-08dc37da77f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4cVT6ByWxicrbikk+8xZSrNdyyz80QWkMhwTAz2UHtjqb08/Oo+Ez95yj6H1jKgQ8YVjAxEtsehAG/rxXwNUnNCoR1xtLxf/4nYnxQF6NKBd1INp+by3KoL3oS4mBLKPTlhuXIfk8HFEQjPvk1RGMompnI3/Jn2n81hUsNNE1puEpyLLiR4HDE1newdfAdL7OflTpJOafkb4eQg9Q5sl9bcgDpDUD6gJIp7sXqSuAznnrvxcxRJt8woir3yaJNlTAP/6NBbY2ZnjA2yeKWDDLMI9zaviMohKSXKZDSwFKEVYgTm8l/DzKtsMaXZqFhnBEa4F8MCHFIOq6T8btFzaNTL9Bap7m3yh4fZkNEv2B9Up3OzEu8sD+o2Ecx3Jb8q1t2rN+noOK7TUchNTrUQRR3NQq+wHkhzQhiUehj+kN6A27q0R5o/wdni//0P2/DXJX5qQjK7Deqm1ms8H6ZcSLtBrsyhvPM5WIxsctgd3ZxricHTT7p6Bp5pjHSPh1hq1BgDPER4Px900oej/bhyga9KRMkvzOvohaVSn3uvX2zm2pz/rJKsGBh1y4Me8201G8pWNyOa8p1GjlzjiTdAkKCK7/ltkxrlVwcmcmL36CWfK0kHY7lQrnuUuePCBQ9uL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0pXcfA5CGZo8qvJV+kRrSQP+dSgnnGH0oJSxevBBPiW7saCmE/ILZOq5JhRX?=
 =?us-ascii?Q?d6uvGMQfoXOvuHVEYI9u8gQIXxSea72DEouux8pI0K+XPPeS/hp6TlMpcgO9?=
 =?us-ascii?Q?QRgebX0E5JeSX2xZ1C8o4Ifv4gGkKNgYgYZsCVUeFY75/zVJdHO90pxPnTtO?=
 =?us-ascii?Q?9BmeQ634Tt4QD5WwqY2q5p3uPoGpSNUGScWx9JHvNBU9LNENkgHT+YLRySVT?=
 =?us-ascii?Q?7TExH68RfFo1bpjDhI2DdLD0p0zUyZZ5OH78AilzS36555hms+81DBmPsBob?=
 =?us-ascii?Q?RZPlZDQ48JWZoCM69Xm7pHotl7FJU3u/I7dYJL4hVdQZdAIG0SP8FkPnzVVn?=
 =?us-ascii?Q?T+2Bz3HGurilBDa1bOyRczZfemVqOmh5WjqJN935FbSVo8dl8WlJFN1l346E?=
 =?us-ascii?Q?tntzYL3zlkwM1vM/R4BOu/Y3BaId1zHer8EMmz3aa0p+XwKOQpRtS/w99f3N?=
 =?us-ascii?Q?+0OLGrsmqEY8DhOTYcr0FK+PqXJml+CnZlPNBA+UKM9aoEnHOVXmJiY2zhrb?=
 =?us-ascii?Q?S/885KYl0P9pXqLkCPr1sfBUq28rx5JHM+rod6fg98nJjhzpmU7duzkfSQfr?=
 =?us-ascii?Q?j+IKU97Ys69wOq4eNQNklmkMQdfdqPBGKyme9+TKGPp6dU2aTazLqZgnoK5v?=
 =?us-ascii?Q?0ccNYifZpsDhOdh4FKm64FkPYaDmfo6usLdRKak9QZa/YgGHaAE4FBKWbqEP?=
 =?us-ascii?Q?q4t+ekj1tSMjilpFv9Wk3H2yL0z87ruSHQcy2djuG9ByqdHXJtcTYuDwIPqj?=
 =?us-ascii?Q?5OuGxqmOgecd6WJ5YdJCpbpkdLSaXT5wT+F2kVJg8q+y47UeAXKVjLToZ1+3?=
 =?us-ascii?Q?DMBYjSTuFGlWB2gYXnmUygfpL7E2gKwBOjd0WsJcFBIoitNza6EONjM8Hsc4?=
 =?us-ascii?Q?pJ4wj1mZYck61eNctqXTDZc1BH+MO9UPVJ7ntsUro+VFslROse0S1S2yWtZj?=
 =?us-ascii?Q?7Z/WtabdMCBllZLYs8I37t21/qEHx+SVNN3bDRgUzlA4tLoLNUapH4KIndrd?=
 =?us-ascii?Q?c9Qb+CZg/n/yR1BRzKIQTCKm6Box+DbmILhLk7+/I+v6CQtRnPCaeVw74Eb+?=
 =?us-ascii?Q?kW0jbCMMQrnbSnr4GPyD92+Z6IEOCjlVYJdaWuL70Ne+UY3QXR1hhe00PwAM?=
 =?us-ascii?Q?1ZHo342gdeOo1wrwyxPEyE/XeGaAQAwCgJCKlPwGCIkJ0yexeH5a35LECDnf?=
 =?us-ascii?Q?SoiuWVk7IpjAVO5orrdbIJcOzFChfKTvPIjXDIAHTQQOvrhCXnaKgxjDpZL+?=
 =?us-ascii?Q?Aon1i5DWx9LrPPWcqBkpj/c0pq6AdJ0u/xF46hK4NedYdBHEmEMHG+kOuuPK?=
 =?us-ascii?Q?YCA5NbUSDpfILh33ue7JPs74nmpBk7HevBjZmue/z+PgAQ0tyxPbRsmMpoWI?=
 =?us-ascii?Q?m+Xhv8493MF0lHrecYyefJ10rO++I8fhdba0KPP+UXARwz/sbS3r/dsGB0RM?=
 =?us-ascii?Q?Q4GeporwXo8p+8HtbV79V1XlalLhYiI90juLFpSuFHAZCb+rEthFAHq3I6Ed?=
 =?us-ascii?Q?XAarnWsnGhaP1PG9V0o1uPiH1LOFqovQAOra/LWMOYoyRhSWjhSZzEicQISZ?=
 =?us-ascii?Q?WzfExt5HErMQcDGYW7i9EZLAs/1V75jMAIBwUwUxfXsb3+UbiXj8SwamRVCB?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vYK6lnrp8CoIYjbmlaWVM5UDNF4lOyFoM2ScZfnfrU8LILfWAq4BY1FM8dtq2RseRVEwmSJbsWC7CK7fURlE0Baixd6zv/3JJkKnri0VWwdbRnwvNrrA+oKb6pO6mv8WfHNZmOhssRMjHhPGRv4Q4n8GdwWHXZTVt4+zDAL3E+f8i6/6wlOkSYQ9lAS76ALG7tTUS92hUwQOOaznHhCUh1o9qhrJ26Q6yR+sosJyQV+81oqUkotvgEkJR1E0Ay7xT4lJnHp4jVBDvbw6/NS3//uFBH1pbT6XafM8yLRPyg9rl84+RguWaA/fOInoxUZOsWaPb6r1JQfmIv/9b3J6nimKJ2x8PecLAQ9sCGHd2u4GFNuvEBvOlelhAjOo3Gww5jb6BG3h0PmW8YIK6KDvGkMCir0io8jq1neMcFvUtcDVQntwHUWfUASUFxIL8XgElGKcPJWGIYpXjVhCP6gpT8fetxQ1/S5R+gg5zLIi7uxsUJ49zhB0lmsYb5M+IKv5ICW1bt7IUhlKxXwYcp+m5WSY53vdJkCH9SZ6M9wA84BXKNpXhDvS+glq1dOmqD3yoWmO2hmmwGDR8XrcdIB5Gejc1N2XAnRy4AKxapPtRZ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f65d76-fe32-491e-30d6-08dc37da77f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 21:24:23.6578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIvWdLyXzhh6BWHRWGGlL2EXMImISA7OU2Fzy8U+Rx8yI63kS93Q514IDKmZMMtS/VUCUmF9cmgnKuQwybv9Rwe2W+07gd/p6f4XQCfMExk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_09,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402270164
X-Proofpoint-ORIG-GUID: E5Ph5OSqncxYLzrjfaPNkF1rHwWDodiL
X-Proofpoint-GUID: E5Ph5OSqncxYLzrjfaPNkF1rHwWDodiL

Hi,

On Thu, Feb 22, 2024 at 10:04:17PM +0800, Gang Li wrote:
> When a group of tasks that access different nodes are scheduled on the
> same node, they may encounter bandwidth bottlenecks and access latency.
> 
> Thus, numa_aware flag is introduced here, allowing tasks to be
> distributed across different nodes to fully utilize the advantage of
> multi-node systems.
> 
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  include/linux/padata.h |  2 ++
>  kernel/padata.c        | 14 ++++++++++++--
>  mm/mm_init.c           |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 495b16b6b4d72..8f418711351bc 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -137,6 +137,7 @@ struct padata_shell {
>   *             appropriate for one worker thread to do at once.
>   * @max_threads: Max threads to use for the job, actual number may be less
>   *               depending on task size and minimum chunk size.
> + * @numa_aware: Distribute jobs to different nodes with CPU in a round robin fashion.

numa_interleave seems more descriptive.

>   */
>  struct padata_mt_job {
>  	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
> @@ -146,6 +147,7 @@ struct padata_mt_job {
>  	unsigned long		align;
>  	unsigned long		min_chunk;
>  	int			max_threads;
> +	bool			numa_aware;
>  };
>  
>  /**
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 179fb1518070c..e3f639ff16707 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>  	struct padata_work my_work, *pw;
>  	struct padata_mt_job_state ps;
>  	LIST_HEAD(works);
> -	int nworks;
> +	int nworks, nid;
> +	static atomic_t last_used_nid __initdata;

nit, move last_used_nid up so it's below load_balance_factor to keep
that nice tree shape

>  
>  	if (job->size == 0)
>  		return;
> @@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>  	ps.chunk_size = roundup(ps.chunk_size, job->align);
>  
>  	list_for_each_entry(pw, &works, pw_list)
> -		queue_work(system_unbound_wq, &pw->pw_work);
> +		if (job->numa_aware) {
> +			int old_node = atomic_read(&last_used_nid);
> +
> +			do {
> +				nid = next_node_in(old_node, node_states[N_CPU]);
> +			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));

There aren't concurrent NUMA-aware _do_multithreaded calls now, so an
atomic per work seems like an unnecessary expense for guarding against
possible uneven thread distribution in the future.  Non-atomic access
instead?

> +			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
> +		} else {
> +			queue_work(system_unbound_wq, &pw->pw_work);
> +		}
>  
>  	/* Use the current thread, which saves starting a workqueue worker. */
>  	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2c19f5515e36c..549e76af8f82a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2231,6 +2231,7 @@ static int __init deferred_init_memmap(void *data)
>  			.align       = PAGES_PER_SECTION,
>  			.min_chunk   = PAGES_PER_SECTION,
>  			.max_threads = max_threads,
> +			.numa_aware  = false,
>  		};
>  
>  		padata_do_multithreaded(&job);
> -- 
> 2.20.1
> 

