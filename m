Return-Path: <linux-kernel+bounces-73487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CBD85C354
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD951F2313B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF2D77A05;
	Tue, 20 Feb 2024 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ly29yJRl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Kqe2Gf/g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B5E7602B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452393; cv=fail; b=PiOW7SJw6r500vtzVKjzQKgRhU3gAbrp24phS44FiNs7sooW60sVgjdXqMLsqJdhqlwjOV6ODl9O96MCaYr1XYx+DJYVOGCsiw2oG8U8RnMJCbPza01b2yu/kq3SEGtddHTZNdNlpwGat3sSPfWin/vASetM3f5HUyL+RE5PmRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452393; c=relaxed/simple;
	bh=f2H6sO6EB/FeXynuxXjNMjOPEeR00U2Yw50VZ9hnIIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DJvPd5fGeAvKOkk4nxmvsH6/bvAZLnyJ0XSDxX/pJolOoMGjFRxyWI0Nwui3S4dnFLCiHAPlUwwnuUM5eM0LZeeQjIy7k/YxhPD+nfvKAb6rgZ6hoax8w+WZ1WRQqE1NI8LfNWCZ28qfMZ5ozcy0Y2kHb8wzXgtV1X2wHxxfccQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ly29yJRl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Kqe2Gf/g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KEe4L5027620;
	Tue, 20 Feb 2024 18:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=uSECRRNLGTjb5h5qQ8NBtv6pyCvydDecgMsu9RaXP4E=;
 b=Ly29yJRlIVwiaQs1A5PUGfFzXBdqJLkUNPpic3KJF5fbqNVyWP3FWzDfKujYkSpLnimK
 0LWZXiUBz+Oeh1rdFE07VCDuIZPPrU4iFHPOqI9zph2IrMQa8jZakPCHXZXoTWai9F0U
 ybjOlumVxnOEraLuFObi6YUCaeL1iWkNPiw9+0ibN2XY1LcouWGWNtI3E09LAIVmhI4b
 6De9b3jQwIRhNgg0JvLP8PgWY1exqK4q9ecqVfUww4TS4Ewady34O3y0/4OThMTq7Gy0
 a+1mGK2hKx9r/so61BxpCmCaHOXprU6yAky5KWmIKS9f313Otw0LRXAUAdsA/kTZc9oE Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamucyhc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:06:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KHWB27037793;
	Tue, 20 Feb 2024 18:06:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak87n887-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 18:06:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+osKXA1Lbje08wfe99ZOuAlckF2GOgfvBarwmT5ekr85yxWGgEggLR/ZDiSX4SvmnVbXAaRjI/MN3sy9GaYyqX8436S783DBNRRopiwhcE9buxrDKg7FBgVWydIm6CcEpSXkHixUfd+BkRqBwXn0Isi1Qpnrh9xM1r7jOYqYuUHVQZk1mBKYKLeK2dikRWySXK8Z5qMUZHk8X72TyaL4qYbk1mcoPL9i1ilfhBRLXKzvzFnJn+JMsZcHVZXkx7V2gO1LDzmbXiZCb9v/x5OAOq1Euv50wOJbqhtPusAYuxN+78WavuIhRDiAldHPdgParwJUUaFUPJkvQvSBW6wLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSECRRNLGTjb5h5qQ8NBtv6pyCvydDecgMsu9RaXP4E=;
 b=lpGCAGs6LvOm5mVEQODRo4z6NB6lJhFQzTPLTTaEhWWD/Bx4NusXTHtD4X6OGsRRLbiYurA3PTVpGFlmOZAKNaBXfs51/VwPqN0vf3rn6jS76ZR6o5x2B5p5TF0izJos3DDZ9xbGoNuIwvSlBKaWmX+NAUFmEMpg8gbx4QPx6SzkEd0xY7T0+3xAEfywIb+VmPej0sux1dXYZgV+JcbPv0mOrIw3oBvPzU0J8Mgo4HfjenZu+7WKVJfZrnS/ryXOfvAygAuGnR9/Ido0PjCn2QuSJ51qXq/lGrNZkIufCH2mahL6HlV1eWccUVYMieLE6hdWDJt+NAVhHJhq7ZJP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSECRRNLGTjb5h5qQ8NBtv6pyCvydDecgMsu9RaXP4E=;
 b=Kqe2Gf/g8KU+c32RGBP0sJUR/maCpGCKuVEBd7f0ViKRWBA+EK0dcsPxbUaXUOnmBKL2oW1s8zHdnTdQGXzFC1Csn9qxXkKhxhwJORuVIltaPZsov6OPL/a8pW9NhQXBWdq68IuS37akHf2i07QfFfEUpn/vvc6N/QA+I3eyBZg=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS0PR10MB7512.namprd10.prod.outlook.com (2603:10b6:8:165::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 18:06:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 18:06:05 +0000
Date: Tue, 20 Feb 2024 13:06:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, lstoakes@gmail.com,
        surenb@google.com
Subject: Re: [PATCH] mm/mmap: convert all mas except mas_detach to vma
 iterator
Message-ID: <20240220180603.dhnthx2nk5455opm@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Yajun Deng <yajun.deng@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
	lstoakes@gmail.com, surenb@google.com
References: <20240218023155.2684469-1-yajun.deng@linux.dev>
 <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9f76ce23-67b1-ccbe-a722-1db0e8f0a408@linux.dev>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS0PR10MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ff3f0d-e882-431e-9a2a-08dc323e9b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fp5RsZur8g6Ed6o5t+g1QVozV15kLWXOCDyDuYTHtQz6Lx+YKUvST/6nvNdoWRUejictAMxR8oU1TEcSKRAD+IZ8ncFn+AsmhL2tRgGGpT5AVMnMypHVpvDAPaamvz8ftI47sqhdoIN3rSzMkF8e7CrVYq9xbUt1I3YF0vrH87nCqA8irK7I/tATkXEkLUszGcvHq1dul4aCqE5Q2za7Wjmg9+u/n3CI1zW1YQsj9MRGcOZxJ+dUXPoa3cbbhasGCqKCwg5qNfyhittBc4hGujNB/kgOQn8/Co47+6jAqVW2NwOsBHVvBGhTpYdgCft7p+8V/St90G1hqqEBJKl4ojTMyHcJrairK4ti0bdaGWZ6BisKsSlY/2QF0fEaqkWDK6Nl38VDFA9J7P6hcfrBcycSW/zavT+rvm96mphf9m86fqs+L8lWuP4JbMNkckRwKlKPY+Ow3vvYDSf5TivnR/vtw6kzLbH64QAdIaastbgflXyRKYLGN1QFXf096fNC5/9mgKKshRud+xussKvdu412RrmObIhxnDe1MKAcqII=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?iso-8859-1?Q?kSmVcdtdKRtJLeS4LTBB+eq53sQhPD+PF8vcnDLiwI8yvGe71xkXAcgcac?=
 =?iso-8859-1?Q?7VRuEKaAax+BuaWnQYoErIaTni4dMmUlP/VQgo/b7V7qQdJhzDm5VlDzrY?=
 =?iso-8859-1?Q?+0Hw70PuKOht048XLVdbD/92F6GUuUCbPKNPokvfmQmHJ1rvk+Wtnjp1Pz?=
 =?iso-8859-1?Q?OJkqxsqAl/tYJnw+LcB2lRnDTH4QMNm+hvpbvfue92a2/7Yfoi2tCFTrKx?=
 =?iso-8859-1?Q?9H14D3JxqoYvHvI1bUjq/JLhiGd4EIk9A5/vkylH7MRhxjdN8OM7VH1+tt?=
 =?iso-8859-1?Q?qRouC1FWsQsq5lmJYI9qMM0iWS2dTBLVtfSAXt6kSBTVE0LFBB8fkOAG4h?=
 =?iso-8859-1?Q?fvDmjtggV/IaozZtW2NH+V83KpCiZ4L5zgp1vkAzOFYAwkSDtz6uj/Kadf?=
 =?iso-8859-1?Q?cKAVErIbBnLO/7fII+FDo8N7RVJ9qdgtjuIhVcMUguiCvYpcHnISgLFz8N?=
 =?iso-8859-1?Q?xKBO3h4F39I730vxJS3EWtL80OU3nxAQ4yeYx2gkMPXrqZXPHg2THbII0+?=
 =?iso-8859-1?Q?d5OWujD8AaQFLQrK3ToyUS9/LYoBQYyvb8R8fc+jX3EXQTGBYEW5vjdYN1?=
 =?iso-8859-1?Q?BsOTgbPA/isZgcRaE/ffcg9GvGZrgbqZh1g3d5ge2ZKr6rNP885JavSsh+?=
 =?iso-8859-1?Q?F/bCEteF0iAuT9fV8S7dG/cf9X1AHvgj92crBo19+C8jphskp7j0cCdn2W?=
 =?iso-8859-1?Q?XfN638N8aAS/RVnW72jujjpVPK1b7n1V2N69KVBU8wyIn58JlT0M+KBk/U?=
 =?iso-8859-1?Q?02FGlWbO1P2ljWZl5zM3LaSXS1BooQgqxlCFQ9Az9bXCXnBHckQLVp/Nlw?=
 =?iso-8859-1?Q?oVmd9giJpd1JUHPxqumEKkbm6hYjLgwxrCtAfaDmZdxEGUwN7ySh0JoQRr?=
 =?iso-8859-1?Q?Qu0ye638B9Qp9hs/CecP78Nkq0u9ahJcIb99pXt/vvI4hnYV5kheQVOX0W?=
 =?iso-8859-1?Q?yXlyGlhkQVJVWFkzE7mQqRegwO8fg32RfFUQ2v10yagrrX1roZfXZDoatV?=
 =?iso-8859-1?Q?Dfz7Y10pYFxghaQmBBzSAmeGz+YsP6YottncLZ+bE71tzzmEjz46E+Ys6I?=
 =?iso-8859-1?Q?+LmWmIT22r3D+ORoPjNt3T0MioaUaYh9wWzd/6drf5JrbNxpQb8e9eErx9?=
 =?iso-8859-1?Q?CK0tQ8cwzh7KjrpMCdR/A9o+cYJkqB3RB0UEbdgl5ObqUXMStIe3I3Je+l?=
 =?iso-8859-1?Q?KdX7AyF4FXqD1YlHq6j6KI0XI/BtRx1bpTpwP1YysA5aBB/XTFlXdJSSvO?=
 =?iso-8859-1?Q?OnbUQbtFzrNRB6Hmek5dN/B0YL5WxeaMU9JlwzLPUSmtgjDFLwICrwKSEE?=
 =?iso-8859-1?Q?K2qhGmlmSxx9AvJxpsp1qZ0iTgq+mkRGIBjSYk1/6xeIDemEDWTtYnvSjQ?=
 =?iso-8859-1?Q?b/4q6CBw5M/7CjCIdsfZePf/wEWljfWDZjF2zlR3qWHgD5FCCCGCr7N8iC?=
 =?iso-8859-1?Q?FJHHxzQiO6fwHQ2tw7S6YC4HWoa6e4pMiwqLekUGGGePw36I1I+VF8TF1M?=
 =?iso-8859-1?Q?CVLajY5GmaavBoyPLGyx7zXPRrHW1P/8ejFCaDKHaKoz8vRn0BMemeZRo0?=
 =?iso-8859-1?Q?oLkSKuw+RvV7NtjbKxnuiHuh/wlkcRVskOu+UcrtSLGm3TtvUO/VorXI8+?=
 =?iso-8859-1?Q?nf8LgHUNabUPZSyNR+vfnS/0JrtNNJb0MX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V6M9lgJVysHJlF8+DV5TakvKpV/1GhXVNBKXP8Ve+7GzM6H1zfdRbglR4fYXc7Yh2WCEPqiXyxjWZDYtat6v8IWag6fO2YEYYZtuZ2FwNHyHCc7qle9yBbN1MJrJAKIgJzaPhCvrw35jfEEmYORGpISNJRs4KNOypMmASAD+kWB6fx3aPOG+/H6CAsVF73N8SNSUfzvdMkiiZSxHDuRrWkRt4Nj5Z5f80y+hhYxEPit4WWapRsEZJgE2f3T13jlQDsVVxrnlmOlLQpPrJ5qccLIwoombwdnzFuLrc2oK6n0vjZkUE13GGVfrBe2dBjQJS8rbdblNQZjgke7VYoyM3ZYOeXWfbP9gCCn3aHryQyfuCggSPJv/goiRF5zRPJ/0s0ITZTCIpk/B/Sj5L0FknCNrhd0bqF1HRrFh/n9AZH8nO8ON9MaUxy77NwV0rf9+SuMsJkUdj9JbLUS+Spi3hxhYOD3EqbT3/J4of2haQ76F4t48RWbs6X4NqQExQdewfZYF4ssD9cWJs0kur0x7vhUbse7MyI2FVx+oIYGrAqnu48/bkdgHqsxCXthyznzRB25feAjguYp8qjTooDK+2FnBZY0qbrM/XN0nhib4yeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ff3f0d-e882-431e-9a2a-08dc323e9b78
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 18:06:05.8919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gckGDpd0PP/41a4kXXyeSTWI60PIBYeieO6+WjPfXgVmnkhstGiGCyKICvtr+JJYaOXXppcAT+o3ETmFkR9zMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=944 mlxscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200130
X-Proofpoint-GUID: AbwMbWjalo5xIpLcqYgu3fWAYm4GMCff
X-Proofpoint-ORIG-GUID: AbwMbWjalo5xIpLcqYgu3fWAYm4GMCff

* Yajun Deng <yajun.deng@linux.dev> [240218 21:30]:
> Cc:=A0 Vlastimil, Lorenzo,Suren
>=20
> On 2024/2/18 10:31, Yajun Deng wrote:
> > There are two types of iterators mas and vmi in the current code. If th=
e
> > maple tree comes from the mm struct, we can use vma iterator. Avoid usi=
ng
> > mas directly.

Thanks for looking at this.

I had left the maple state exposed in the mmap.c file because it does a
number of operations that no one else does, so the new functions will be
called a very limited number of times (as low as once).

I think this is a worth while change since this may be needed in the
future for dealing with more specialised uses of the tree.  It also
removes the 0/ULONG_MAX limits from certain calls, and the vma iterator
names help explain things.

I don't know why you treat the low/high search differently than the
mas_reset() and mas_*_range(). In any case, the comment is inaccurate
when mas_ functions are called with &vmi.mas in places.


> >=20
> > Leave the mt_detach tree keep using mas, as it doesn't come from the mm
> > struct.

Well, it's still VMAs from the mm struct.  I agree that we should not
change this for now.

> >=20
> > Convert all mas except mas_detach to vma iterator. And introduce
> > vma_iter_area_{lowest, highest} helper functions for use vma interator.

Do you mean mas functions?  You do pass the maple state through to other
areas.  ie: free_pgtables().

> >=20
> > Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> > ---
> >   mm/internal.h |  12 ++++++
> >   mm/mmap.c     | 114 +++++++++++++++++++++++++------------------------=
-
> >   2 files changed, 69 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 1e29c5821a1d..6117e63a7acc 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1147,6 +1147,18 @@ static inline void vma_iter_config(struct vma_it=
erator *vmi,
> >   	__mas_set_range(&vmi->mas, index, last - 1);
> >   }
> > +static inline int vma_iter_area_lowest(struct vma_iterator *vmi, unsig=
ned long min,
> > +				       unsigned long max, unsigned long size)

Is this spacing okay?  It looks off in email and on lore.


> > +{
> > +	return mas_empty_area(&vmi->mas, min, max - 1, size);
> > +}
> > +
> > +static inline int vma_iter_area_highest(struct vma_iterator *vmi, unsi=
gned long min,
> > +					unsigned long max, unsigned long size)

Same spacing question here, could be fine though.

> > +{
> > +	return mas_empty_area_rev(&vmi->mas, min, max - 1, size);
> > +}
> > +
> >   /*
> >    * VMA Iterator functions shared between nommu and mmap
> >    */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 7a9d2895a1bd..2fc38bf0d1aa 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1104,21 +1104,21 @@ static struct anon_vma *reusable_anon_vma(struc=
t vm_area_struct *old, struct vm_
> >    */
> >   struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
> >   {
> > -	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_end, vma->vm_end);
> >   	struct anon_vma *anon_vma =3D NULL;
> >   	struct vm_area_struct *prev, *next;
> > +	VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_end);
> >   	/* Try next first. */
> > -	next =3D mas_walk(&mas);
> > +	next =3D vma_iter_load(&vmi);
> >   	if (next) {
> >   		anon_vma =3D reusable_anon_vma(next, vma, next);
> >   		if (anon_vma)
> >   			return anon_vma;
> >   	}
> > -	prev =3D mas_prev(&mas, 0);
> > +	prev =3D vma_prev(&vmi);
> >   	VM_BUG_ON_VMA(prev !=3D vma, vma);
> > -	prev =3D mas_prev(&mas, 0);
> > +	prev =3D vma_prev(&vmi);
> >   	/* Try prev next. */
> >   	if (prev)
> >   		anon_vma =3D reusable_anon_vma(prev, prev, vma);
> > @@ -1566,8 +1566,7 @@ static unsigned long unmapped_area(struct vm_unma=
pped_area_info *info)
> >   	unsigned long length, gap;
> >   	unsigned long low_limit, high_limit;
> >   	struct vm_area_struct *tmp;
> > -
> > -	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
> > +	VMA_ITERATOR(vmi, current->mm, 0);

Should have a new line here.  In fact, the new line was before this so
checkpatch.pl wouldn't complain - did you run checkpatch.pl against the
patch?

I don't really like that it complains here, but I maintain the new line
if a function had one already.


> >   	/* Adjust search length to account for worst case alignment overhead=
 */
> >   	length =3D info->length + info->align_mask;
> > @@ -1579,23 +1578,23 @@ static unsigned long unmapped_area(struct vm_un=
mapped_area_info *info)
> >   		low_limit =3D mmap_min_addr;
> >   	high_limit =3D info->high_limit;
> >   retry:
> > -	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
> > +	if (vma_iter_area_lowest(&vmi, low_limit, high_limit, length))
> >   		return -ENOMEM;
> > -	gap =3D mas.index;
> > +	gap =3D vma_iter_addr(&vmi);
> >   	gap +=3D (info->align_offset - gap) & info->align_mask;
> > -	tmp =3D mas_next(&mas, ULONG_MAX);
> > +	tmp =3D vma_next(&vmi);
> >   	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev chec=
k if possible */
> >   		if (vm_start_gap(tmp) < gap + length - 1) {
> >   			low_limit =3D tmp->vm_end;
> > -			mas_reset(&mas);
> > +			mas_reset(&vmi.mas);

If you're going to convert the maple state, create a static inline for
this too in the mm/internal.h.  There are four of these mas_reset()
calls by my count.

> >   			goto retry;
> >   		}
> >   	} else {
> > -		tmp =3D mas_prev(&mas, 0);
> > +		tmp =3D vma_prev(&vmi);
> >   		if (tmp && vm_end_gap(tmp) > gap) {
> >   			low_limit =3D vm_end_gap(tmp);
> > -			mas_reset(&mas);
> > +			mas_reset(&vmi.mas);
> >   			goto retry;
> >   		}
> >   	}
> > @@ -1618,8 +1617,8 @@ static unsigned long unmapped_area_topdown(struct=
 vm_unmapped_area_info *info)
> >   	unsigned long length, gap, gap_end;
> >   	unsigned long low_limit, high_limit;
> >   	struct vm_area_struct *tmp;
> > +	VMA_ITERATOR(vmi, current->mm, 0);
> > -	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
> >   	/* Adjust search length to account for worst case alignment overhead=
 */
> >   	length =3D info->length + info->align_mask;
> >   	if (length < info->length)
> > @@ -1630,24 +1629,24 @@ static unsigned long unmapped_area_topdown(stru=
ct vm_unmapped_area_info *info)
> >   		low_limit =3D mmap_min_addr;
> >   	high_limit =3D info->high_limit;
> >   retry:
> > -	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
> > +	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
> >   		return -ENOMEM;
> > -	gap =3D mas.last + 1 - info->length;
> > +	gap =3D vma_iter_end(&vmi) - info->length;
> >   	gap -=3D (gap - info->align_offset) & info->align_mask;
> > -	gap_end =3D mas.last;
> > -	tmp =3D mas_next(&mas, ULONG_MAX);
> > +	gap_end =3D vma_iter_end(&vmi);

vma_iter_end will return vmi->mas.last + 1, is what you have here
correct?

> > +	tmp =3D vma_next(&vmi);
> >   	if (tmp && (tmp->vm_flags & VM_STARTGAP_FLAGS)) { /* Avoid prev chec=
k if possible */
> > -		if (vm_start_gap(tmp) <=3D gap_end) {
> > +		if (vm_start_gap(tmp) < gap_end) {
> >   			high_limit =3D vm_start_gap(tmp);
> > -			mas_reset(&mas);
> > +			mas_reset(&vmi.mas);
> >   			goto retry;
> >   		}
> >   	} else {
> > -		tmp =3D mas_prev(&mas, 0);
> > +		tmp =3D vma_prev(&vmi);
> >   		if (tmp && vm_end_gap(tmp) > gap) {
> >   			high_limit =3D tmp->vm_start;
> > -			mas_reset(&mas);
> > +			mas_reset(&vmi.mas);
> >   			goto retry;
> >   		}
> >   	}
> > @@ -1900,12 +1899,12 @@ find_vma_prev(struct mm_struct *mm, unsigned lo=
ng addr,
> >   			struct vm_area_struct **pprev)
> >   {
> >   	struct vm_area_struct *vma;
> > -	MA_STATE(mas, &mm->mm_mt, addr, addr);
> > +	VMA_ITERATOR(vmi, mm, addr);
> > -	vma =3D mas_walk(&mas);
> > -	*pprev =3D mas_prev(&mas, 0);
> > +	vma =3D vma_iter_load(&vmi);
> > +	*pprev =3D vma_prev(&vmi);
> >   	if (!vma)
> > -		vma =3D mas_next(&mas, ULONG_MAX);
> > +		vma =3D vma_next(&vmi);
> >   	return vma;
> >   }
> > @@ -1959,11 +1958,12 @@ static int expand_upwards(struct vm_area_struct=
 *vma, unsigned long address)
> >   	struct vm_area_struct *next;
> >   	unsigned long gap_addr;
> >   	int error =3D 0;
> > -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, address);
> > +	VMA_ITERATOR(vmi, mm, 0);
> >   	if (!(vma->vm_flags & VM_GROWSUP))
> >   		return -EFAULT;
> > +	vma_iter_config(&vmi, vma->vm_start, address);

This is confusing.  I think you are doing this so that the vma iterator
is set up the same as the maple state, and not what is logically
necessary?


> >   	/* Guard against exceeding limits of the address space. */
> >   	address &=3D PAGE_MASK;
> >   	if (address >=3D (TASK_SIZE & PAGE_MASK))
> > @@ -1985,15 +1985,15 @@ static int expand_upwards(struct vm_area_struct=
 *vma, unsigned long address)
> >   	}
> >   	if (next)
> > -		mas_prev_range(&mas, address);
> > +		mas_prev_range(&vmi.mas, address);

This isn't really hiding the maple state.


> > -	__mas_set_range(&mas, vma->vm_start, address - 1);
> > -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > +	vma_iter_config(&vmi, vma->vm_start, address);

The above maple state changes is to get the maple state to point to the
correct area for the preallocation call below.  This seems unnecessary
to me.

We really should just set it up correctly.  Unfortunately, with the VMA
iterator, that's not really possible on initialization.

What we can do is use the vma->vm_start for the initialization, then use
vma_iter_config() here.  That will not reset any state - but that's fine
because the preallocation is the first call that actually uses it
anyways.

So we can initialize with vma->vm_start, don't call vma_iter_config
until here, and also drop the if (next) part.

This is possible here because it's not optimised like the
expand_upwards() case, which uses the state to check prev and avoids an
extra walk.

Please make sure to test with the ltp tests on the stack combining, etc
on a platform that expands down.

> > +	if (vma_iter_prealloc(&vmi, vma))
> >   		return -ENOMEM;
> >   	/* We must make sure the anon_vma is allocated. */
> >   	if (unlikely(anon_vma_prepare(vma))) {
> > -		mas_destroy(&mas);
> > +		vma_iter_free(&vmi);
> >   		return -ENOMEM;
> >   	}
> > @@ -2033,7 +2033,7 @@ static int expand_upwards(struct vm_area_struct *=
vma, unsigned long address)
> >   				anon_vma_interval_tree_pre_update_vma(vma);
> >   				vma->vm_end =3D address;
> >   				/* Overwrite old entry in mtree. */
> > -				mas_store_prealloc(&mas, vma);
> > +				vma_iter_store(&vmi, vma);
> >   				anon_vma_interval_tree_post_update_vma(vma);
> >   				spin_unlock(&mm->page_table_lock);
> > @@ -2042,7 +2042,7 @@ static int expand_upwards(struct vm_area_struct *=
vma, unsigned long address)
> >   		}
> >   	}
> >   	anon_vma_unlock_write(vma->anon_vma);
> > -	mas_destroy(&mas);
> > +	vma_iter_free(&vmi);
> >   	validate_mm(mm);
> >   	return error;
> >   }
> > @@ -2055,9 +2055,9 @@ static int expand_upwards(struct vm_area_struct *=
vma, unsigned long address)
> >   int expand_downwards(struct vm_area_struct *vma, unsigned long addres=
s)
> >   {
> >   	struct mm_struct *mm =3D vma->vm_mm;
> > -	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
> >   	struct vm_area_struct *prev;
> >   	int error =3D 0;
> > +	VMA_ITERATOR(vmi, mm, vma->vm_start);
> >   	if (!(vma->vm_flags & VM_GROWSDOWN))
> >   		return -EFAULT;
> > @@ -2067,7 +2067,7 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >   		return -EPERM;
> >   	/* Enforce stack_guard_gap */
> > -	prev =3D mas_prev(&mas, 0);
> > +	prev =3D vma_prev(&vmi);
> >   	/* Check that both stack segments have the same anon_vma? */
> >   	if (prev) {
> >   		if (!(prev->vm_flags & VM_GROWSDOWN) &&
> > @@ -2077,15 +2077,15 @@ int expand_downwards(struct vm_area_struct *vma=
, unsigned long address)
> >   	}
> >   	if (prev)
> > -		mas_next_range(&mas, vma->vm_start);
> > +		mas_next_range(&vmi.mas, vma->vm_start);

Not really hiding the maple state or the mas_* functions here.

> > -	__mas_set_range(&mas, address, vma->vm_end - 1);
> > -	if (mas_preallocate(&mas, vma, GFP_KERNEL))
> > +	vma_iter_config(&vmi, address, vma->vm_end);
> > +	if (vma_iter_prealloc(&vmi, vma))
> >   		return -ENOMEM;
> >   	/* We must make sure the anon_vma is allocated. */
> >   	if (unlikely(anon_vma_prepare(vma))) {
> > -		mas_destroy(&mas);
> > +		vma_iter_free(&vmi);
> >   		return -ENOMEM;
> >   	}
> > @@ -2126,7 +2126,7 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >   				vma->vm_start =3D address;
> >   				vma->vm_pgoff -=3D grow;
> >   				/* Overwrite old entry in mtree. */
> > -				mas_store_prealloc(&mas, vma);
> > +				vma_iter_store(&vmi, vma);
> >   				anon_vma_interval_tree_post_update_vma(vma);
> >   				spin_unlock(&mm->page_table_lock);
> > @@ -2135,7 +2135,7 @@ int expand_downwards(struct vm_area_struct *vma, =
unsigned long address)
> >   		}
> >   	}
> >   	anon_vma_unlock_write(vma->anon_vma);
> > -	mas_destroy(&mas);
> > +	vma_iter_free(&vmi);
> >   	validate_mm(mm);
> >   	return error;
> >   }
> > @@ -3233,7 +3233,7 @@ void exit_mmap(struct mm_struct *mm)
> >   	struct mmu_gather tlb;
> >   	struct vm_area_struct *vma;
> >   	unsigned long nr_accounted =3D 0;
> > -	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	VMA_ITERATOR(vmi, mm, 0);
> >   	int count =3D 0;
> >   	/* mm's last user has gone, and its about to be pulled down */
> > @@ -3242,7 +3242,7 @@ void exit_mmap(struct mm_struct *mm)
> >   	mmap_read_lock(mm);
> >   	arch_exit_mmap(mm);
> > -	vma =3D mas_find(&mas, ULONG_MAX);
> > +	vma =3D vma_next(&vmi);
> >   	if (!vma || unlikely(xa_is_zero(vma))) {
> >   		/* Can happen if dup_mmap() received an OOM */
> >   		mmap_read_unlock(mm);
> > @@ -3255,7 +3255,7 @@ void exit_mmap(struct mm_struct *mm)
> >   	tlb_gather_mmu_fullmm(&tlb, mm);
> >   	/* update_hiwater_rss(mm) here? but nobody should be looking */
> >   	/* Use ULONG_MAX here to ensure all VMAs in the mm are unmapped */
> > -	unmap_vmas(&tlb, &mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
> > +	unmap_vmas(&tlb, &vmi.mas, vma, 0, ULONG_MAX, ULONG_MAX, false);
> >   	mmap_read_unlock(mm);
> >   	/*
> > @@ -3265,8 +3265,8 @@ void exit_mmap(struct mm_struct *mm)
> >   	set_bit(MMF_OOM_SKIP, &mm->flags);
> >   	mmap_write_lock(mm);
> >   	mt_clear_in_rcu(&mm->mm_mt);
> > -	mas_set(&mas, vma->vm_end);
> > -	free_pgtables(&tlb, &mas, vma, FIRST_USER_ADDRESS,
> > +	vma_iter_set(&vmi, vma->vm_end);
> > +	free_pgtables(&tlb, &vmi.mas, vma, FIRST_USER_ADDRESS,
> >   		      USER_PGTABLES_CEILING, true);

I guess the page tables still deal with the maple state directly then.

> >   	tlb_finish_mmu(&tlb);
> > @@ -3275,14 +3275,14 @@ void exit_mmap(struct mm_struct *mm)
> >   	 * enabled, without holding any MM locks besides the unreachable
> >   	 * mmap_write_lock.
> >   	 */
> > -	mas_set(&mas, vma->vm_end);
> > +	vma_iter_set(&vmi, vma->vm_end);
> >   	do {
> >   		if (vma->vm_flags & VM_ACCOUNT)
> >   			nr_accounted +=3D vma_pages(vma);
> >   		remove_vma(vma, true);
> >   		count++;
> >   		cond_resched();
> > -		vma =3D mas_find(&mas, ULONG_MAX);
> > +		vma =3D vma_next(&vmi);
> >   	} while (vma && likely(!xa_is_zero(vma)));
> >   	BUG_ON(count !=3D mm->map_count);
> > @@ -3704,7 +3704,7 @@ int mm_take_all_locks(struct mm_struct *mm)
> >   {
> >   	struct vm_area_struct *vma;
> >   	struct anon_vma_chain *avc;
> > -	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	VMA_ITERATOR(vmi, mm, 0);
> >   	mmap_assert_write_locked(mm);
> > @@ -3716,14 +3716,14 @@ int mm_take_all_locks(struct mm_struct *mm)
> >   	 * being written to until mmap_write_unlock() or mmap_write_downgrad=
e()
> >   	 * is reached.
> >   	 */
> > -	mas_for_each(&mas, vma, ULONG_MAX) {
> > +	for_each_vma(vmi, vma) {
> >   		if (signal_pending(current))
> >   			goto out_unlock;
> >   		vma_start_write(vma);
> >   	}
> > -	mas_set(&mas, 0);
> > -	mas_for_each(&mas, vma, ULONG_MAX) {
> > +	vma_iter_init(&vmi, mm, 0);
> > +	for_each_vma(vmi, vma) {
> >   		if (signal_pending(current))
> >   			goto out_unlock;
> >   		if (vma->vm_file && vma->vm_file->f_mapping &&
> > @@ -3731,8 +3731,8 @@ int mm_take_all_locks(struct mm_struct *mm)
> >   			vm_lock_mapping(mm, vma->vm_file->f_mapping);
> >   	}
> > -	mas_set(&mas, 0);
> > -	mas_for_each(&mas, vma, ULONG_MAX) {
> > +	vma_iter_init(&vmi, mm, 0);
> > +	for_each_vma(vmi, vma) {
> >   		if (signal_pending(current))
> >   			goto out_unlock;
> >   		if (vma->vm_file && vma->vm_file->f_mapping &&
> > @@ -3740,8 +3740,8 @@ int mm_take_all_locks(struct mm_struct *mm)
> >   			vm_lock_mapping(mm, vma->vm_file->f_mapping);
> >   	}
> > -	mas_set(&mas, 0);
> > -	mas_for_each(&mas, vma, ULONG_MAX) {
> > +	vma_iter_init(&vmi, mm, 0);
> > +	for_each_vma(vmi, vma) {
> >   		if (signal_pending(current))
> >   			goto out_unlock;
> >   		if (vma->anon_vma)
> > @@ -3800,12 +3800,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >   {
> >   	struct vm_area_struct *vma;
> >   	struct anon_vma_chain *avc;
> > -	MA_STATE(mas, &mm->mm_mt, 0, 0);
> > +	VMA_ITERATOR(vmi, mm, 0);
> >   	mmap_assert_write_locked(mm);
> >   	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
> > -	mas_for_each(&mas, vma, ULONG_MAX) {
> > +	for_each_vma(vmi, vma) {
> >   		if (vma->anon_vma)
> >   			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
> >   				vm_unlock_anon_vma(avc->anon_vma);
>=20

