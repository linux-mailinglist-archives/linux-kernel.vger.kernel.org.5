Return-Path: <linux-kernel+bounces-97246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC8887677F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D482860A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903641F93E;
	Fri,  8 Mar 2024 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ofbAFmSQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jpemz74p"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE91EEFD
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912590; cv=fail; b=oXCye3A/xHsUaJ6ZM+sB9O7S+useH+wbktlno3s8bxKTjqhBi3sex07RTvFFqI61YM7HF9kuWYTtt2xRVoOR2jzZtidOcIhk3kLnGG3YHoqRPoUpTlKO/zvPb2cw6ED8hxHJhvYwHv71v1SJcHQKOBkP2QnGC/el37hlEbOWpv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912590; c=relaxed/simple;
	bh=uVxbP2o/f4SjFFKXQCQ64cko0MP0ik0UEulfLswS5HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HiH4GdyEMAjZWyChHPl6FRo6H9+VxVBiY47uMDKznIN3QPOesZFW5ZHn/Us79GwTCmr7Gs96w12zsdVWIjyxkb1mFapdKnuRmZOAAo5R40WjCizULkq0+b6a44sWCBFplI4accAaIRLciMRAZ/IF7KRP29C9ur8937JU9GLHmgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ofbAFmSQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jpemz74p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428DTab2013851;
	Fri, 8 Mar 2024 15:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=UYOFwDSQJQW1dph0CClFQarzxJhHV68m52+aXrUkwqU=;
 b=ofbAFmSQtQ0e+cJYSsyU7gK2W6EdeJxa1sfx1KLcF0EPdLSSa6m8GFdZAq6xRoyr/WGB
 84zko74uSFjS7ZMX4stV74CvGrj9Z+L/fm51OoVpsb7IlzURvghPLU9BLObAibyz4LvZ
 Ebvk7eZQHuwfQEfb0wVAz8xfag/Autf2QnQruPu6Ny6M7OsL75zBz373V4Kyk6eycGP+
 zy9Px8aNTWDugnbzcFrPZzma8LWB7UEnLd1EO9cJOVnKL0IPHj5l0cSNOliDktn/UtpA
 JYp/xF/ByNbdYcb8fk1a/5rLYElj0ZvR/auyWt/ihzaqHNCB5EgSYOvWP6yckdzu7/1U FQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv67s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 15:42:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428FQoio016108;
	Fri, 8 Mar 2024 15:42:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjcyyff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 15:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS5iweMQScJArLDLqCjBVNdPqbJ/6qn7/2rbaV8VUe1Tjwl5fDiC6IEzXFOt9F/obYilENrbF1l1ziCpkyTh6mTsiJ6oaoBY2HHpEd1qcKtGBmHTEr1jew6mWiqUvh1yd02lgG63iVaw6uO5nAXf9/kJOKsp9Lgd4faIoksRBdYF6F0N8S8CmeFhyvnEUp1sDku/2hkGNZzyiLBMnfcKpQ4TZ9hiugfKNVSdCVTUXibfe3YMmt7hijXFgSDZqBFdTBzTSRzsgFTkkfFHjietHPJ66fGi25a1QGOYre8hRIDFtGAUppbuxeRN0jXjTO+XGA2bju4OqPc1a/Ap8yFH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYOFwDSQJQW1dph0CClFQarzxJhHV68m52+aXrUkwqU=;
 b=beqs+NB0VyvyhSBFSgm3arfDHdVyAgKUfpsWQcXzSFJEfXqy+yDaY/dVnDzMX2oOyiX86DaFfoBjQhIMzK/61Ow3GqNMGTevmCMykUCPIrT0KKkf5ynt/9ZpbuYrrQ7S6m4UrPODELNTY5qlsSMrzwac9xyp13h+a7pCrc0HZn3sZN6kmHqJHvrZ/WXnrivVu5crTf7nqQmL1waxm8oZbRvPxCkPv/sejfu24iGD9lSOy3/z6omSGpkoFKgGUPeA2dSx8aSKgmcidXvPAR/OJBapw2T91KG18og8fqBsExsHgPdcDo6wXhK2L0UYa44M5dblubb5NHkCSuOpqcCEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYOFwDSQJQW1dph0CClFQarzxJhHV68m52+aXrUkwqU=;
 b=jpemz74pp9GLPPS/gyMyDmRgMW/uOz2qn9GJRR2kvO0dfkJwE/xFoiGQ6fAY5J4uEt+bLPhfU8X5ABrkDD5KGUzi95gxh4oa1QejFzGSHl2V2Z5tp4HqrLV+4h/PIyBNvEqDDsPpF27ynJBuhf60vVRGexnN9+hMkqfDcembmU8=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SA1PR10MB5760.namprd10.prod.outlook.com (2603:10b6:806:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 15:42:32 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::310c:4c5c:d1cc:9443%4]) with mapi id 15.20.7362.030; Fri, 8 Mar 2024
 15:42:32 +0000
Date: Fri, 8 Mar 2024 10:42:29 -0500
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
Message-ID: <yi422qqkfhf23x4wekpycxmsjodbwcw7aw2avjfh37dkapocg7@f7nn3mtdldbq>
References: <20240222140422.393911-1-gang.li@linux.dev>
 <20240222140422.393911-5-gang.li@linux.dev>
 <7g53p42favkoibzg4w3ly3ypdjdy6oymhj74ekwk62bwx4rlaj@seoavjygfadq>
 <9b044d9b-d3b1-4fb3-8b05-2a54c2b45716@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b044d9b-d3b1-4fb3-8b05-2a54c2b45716@linux.dev>
X-ClientProxiedBy: BLAPR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:208:32f::21) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SA1PR10MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 73447de9-12f7-44a7-53b8-08dc3f865e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Pnv1534OCwyiFXR0bzGyJV3tOwmqWDQ0C9dXv6DdJgUGtx5++p+SKaKpyLh/Zu0+aI1YwIBy+LpsCNgk8HIuW46z6w5yMKjQAZ7rma3gBJjYxBt+XsOr7PGzoRwkqQRgTcPhZ5wODvedWieXLn/QgcEjpQc4JoL+dAZ7szTjGuPJaCsjfSmxckvAf6BCmoYyOyFra3GbSwDPHJezGdsfpXgOnc/7a5NVnchbFskio/fKH69ScU6yoD34aGJzIbokXHlJYxrrjuAzrWEfqFLn4K/B8L+zGGJfWrSWxXVRXkPCzwi8cCXZ8VoSv6qVW4p6rZIqhEavM26sqEZEKg9sJwlrO5GVZymkspZlHCwkn7z+pSoA11EOf5FIKZ7cnxq8xOcjIH71Jj6HnCMe+9MK70iVfb2rVT1yFg8lJNvm0raRBoQvBQIEoXe+D0T/DAixn5KN3lldKiIkNhXgMKxSNS7cVLveJuAMqwu9QPbptWpsNmVtAjhRabaoA8EzNQsE0XYKFMfwbFa7bagIMzHLZMvf/0FSxinr+2i28F9Dut/bk/IsGRIUaqewrvpR+aJg1FUKtvLf3CoPtqbDbJ3HGnaw7kcFEbwRr8pd5OSiG7k3yfh5F+OUEEiIscGGBviQpCpkWdljnFvyi1HWLTg7Vp8XAPHQGPNuo2Macl7ndcQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qegA+UsutnxYXMmkmlp1PXJ+VQxteDLy7rjdX/69wPfsEajTI7Xz2u0Cn+BD?=
 =?us-ascii?Q?5582pl1VUciwz66bTV9WFtZH3nSk85pqxdQ++QvPPuas8x782P+a+APJTJlf?=
 =?us-ascii?Q?vfxzdBWPYU411X3rZssEwkHagmS64giv0NBokRTQJLr9lnGCXw0d6SIGgO6R?=
 =?us-ascii?Q?pSM4DjgNZfkfaSqVIyga9AaDivbRbaOBViC+sPp8psfbt6NQAQycD6N68Ge2?=
 =?us-ascii?Q?mN/jWueTn9NRx7zTS7bgwhFTpQFzJMf8JwSMgiV5EnlbU2wX8clTsOUVrgzP?=
 =?us-ascii?Q?2iBYkMLqe+5tA6AUm+SuLhKA8mieR7m5a8pqsq2PlilkCsdCRFS5fGw3cF2x?=
 =?us-ascii?Q?j5VmkSOXnLLAwKzp3QGTpKYbjKqi3kjQM4/qFni1Pq8qPjUz0ymjwOwK47hO?=
 =?us-ascii?Q?X1HX6/F9iyIBEWHDRlLTeh0sP0PjsSLVHKClm4/YgXY/a6Dj4GUl6i2sUoQR?=
 =?us-ascii?Q?fKR0bQktsLkfVYSaqjmZHNfx8B479SkYdZ7DZBJJnu25Ensqe9pERV4a0+eC?=
 =?us-ascii?Q?jgVGGX5Ak3hdV3PrUUVVH8tIoolZqai14V6/zKx5Ad+E9QZEOdhhJFTOzDh+?=
 =?us-ascii?Q?o/0oDtyujthy4ryIDJEmjQdjqTDKiOWks/jBLE9XXdA3NMA7V5HnUWb5Eemv?=
 =?us-ascii?Q?a0cTIzxVHIzunNqkRfA3hUbRGFzMsqA3C5y4WN7FQyswJLhERV3CSFqEI1xJ?=
 =?us-ascii?Q?D9JSJCnBxZ5eNVsutPnV1V6aN/Jry3tMoJXRYluV9AyW1+0rj0y9NcM1Jh4D?=
 =?us-ascii?Q?IecxBUJ6p9W2gu3iAMMIDkCLCFhEeBOoBst6adLVT/8X5zyNITIzRJl1mjz8?=
 =?us-ascii?Q?NjbN6EAsdUNQTUpgaZTv2YB8Sv92ZvH9tUdc82nOshUEyg97lv9V61+JN7yg?=
 =?us-ascii?Q?WYcckhvV6tsi2tUSo/8i2dt/dsqwGDt66+AXXotXIPX0WeAKctO3zLWm/YXc?=
 =?us-ascii?Q?MKJj4WoYjyAgv9YLFRJrG/GRmO0h0fMcJah4MOCBIIHuYFHJkg4Jz6akG3lr?=
 =?us-ascii?Q?HeEX5DC8OT+/RD7yUFXBbOqONBFyQq9vT8ZgSoFU1ZgiWSGWH6qpA5DoZXMm?=
 =?us-ascii?Q?9Zz12WEJngfShlz87gE7NHYaltiK7NdhwOMjImCHa2DH+9hIyAbWMCT29sW9?=
 =?us-ascii?Q?5TF+C0w9f5sqpSF2dtsoWU1BH9OelqPMtCdEzxReSrwAiDJCkRfi9mymkZRu?=
 =?us-ascii?Q?aOHw4oGc4VmT4vGR+I94Z1ZfsQ8co1HEqE6yhHPLsRPnIPX6jyndmC1wn7OE?=
 =?us-ascii?Q?BA01YN+jp+YI19JbOSYUvcTsSJS42c5q/53CrEyRyzxZI3Yb90TxxMSyyUHV?=
 =?us-ascii?Q?Uv2ssE3c6LoRL8Bk36hZwByBJ/RnAMlbF0GP2WXaQwj80n3JYolALVwZR0NJ?=
 =?us-ascii?Q?ZMODxdwQ280Q3pAxjIEWybzAeIxWxLAeAcw1Z8nt1RXWzbtVr4k3Hg8wVYPc?=
 =?us-ascii?Q?sFwjnYauchra71yEiDS71OCqhnzjKd7mQb5lHdkfgsXUwShr35jn5TL+w612?=
 =?us-ascii?Q?wGkac3ZFWs1FObDQMe9JRiS6MXtpAWKevNNrGfwBiA9+5QuA1Bq2RMH7iKqC?=
 =?us-ascii?Q?E2mBYIINSRkMNinUvgTXoNBNZ3ZLFoHeUObaVp9DyI64mnVBio7WUjpjkvvT?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZGYHrpYyTzxWf7q6l1VnTlmSLnJuPDNZDmfTqEPhTgSp/E1e+RqxQg2eLdTslYoCo1jb5uWqH1YRfEa5CrFubdrJ2kWtGXKGZi3lm4vRsOvN/eBmONnUwdLUrqsg+Q9SbdNbDiSJ89+SLc2X/VDZcVqWXeg6ydjicLyv8mZppPHLu1ub8e0mPtMystH/iOqmNhwdt4DM90V69KQo95/d+ZQgixLqU6lkdCU0v2S2Oq7kXWlyNveKLcjdrqXRdMA6XaJCqq206eWWXN2kVajIeJ3NQKdjOn6cPciOmkvRSBRgIqGWTB5MvIFEBu5lMIkW71eBAxftYXggDwkN0l8PMHbZ9NEMmi/Zvaa6lQ6GbZVRxm+31F4LvCO4JKXecXd2/0bCOr4whvWJWwpxrYNnEZZRkSDrY1g8KLoA7y905B7qkJe8thd3iHzqDufyMhalT0m4I1RKnCOUGtpwUnSfVsiuzWjQkWFka4FtlOqvGPnZp1lhrnDvml4ydTHl0pZfn8/aFMFMb1PJ1E/OsZ4MB4ykM0HFoXdiQTAFKPhmeI/WG4oUl6ZrO9tHWz4zAyMWo73dZBMe0X+u/FD2ljdZ4CWe5kX6dyHigf0g06Rts6U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73447de9-12f7-44a7-53b8-08dc3f865e85
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:42:32.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UKYCjUCivldJ+6x5fplupNMgnAiOuVl3GN8nJqRz9FgjC5LNi1GywIUBEhDhYs7h7h1WMQhFVw3XvmNeesqwL1cS1puviNFOhlHhoONaPSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080125
X-Proofpoint-ORIG-GUID: H2nPdYsK4qIaXCLZZAf47UehX2-WQeXN
X-Proofpoint-GUID: H2nPdYsK4qIaXCLZZAf47UehX2-WQeXN

Hello Gang,

On Tue, Mar 05, 2024 at 10:49:47AM +0800, Gang Li wrote:
> On 2024/2/28 05:24, Daniel Jordan wrote:
> > On Thu, Feb 22, 2024 at 10:04:17PM +0800, Gang Li wrote:
> > > @@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
> > >   	ps.chunk_size = roundup(ps.chunk_size, job->align);
> > >   	list_for_each_entry(pw, &works, pw_list)
> > > -		queue_work(system_unbound_wq, &pw->pw_work);
> > > +		if (job->numa_aware) {
> > > +			int old_node = atomic_read(&last_used_nid);
> > > +
> > > +			do {
> > > +				nid = next_node_in(old_node, node_states[N_CPU]);
> > > +			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
> > 
> > There aren't concurrent NUMA-aware _do_multithreaded calls now, so an
> > atomic per work seems like an unnecessary expense for guarding against
> 
> Hi Daniel,
> 
> Yes, this is not necessary. But I think this operation is infrequent, so
> the burden shouldn't be too great?

I can only guess, but I bet you're right.  It's also that people might
wonder what the atomic guards against, so non-atomic would make the code
a bit easier to understand.  Either way, looks fine.

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

