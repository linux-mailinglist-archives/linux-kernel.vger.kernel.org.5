Return-Path: <linux-kernel+bounces-36315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF40839F44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4151C219EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6B46B4;
	Wed, 24 Jan 2024 02:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xx0OjnE6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="raZ8a8Bq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF4D4402;
	Wed, 24 Jan 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063804; cv=fail; b=Fnzo9eW+pPi/ch9DtlQotV4aiGb7KOy+Sc/dNFvm9ZeJEyGO+NDXtmpsb9UTJ8xRvSRDoYAmnhHaiZzHav1qKoD74iPewRyfg34Lkd0Ec70oiCj1fIjlAoTJ/Ty5Nsx2mRkq1BZO4nRUj9j5FuXvkUUB7kzxIpZ0J3THf6l5cS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063804; c=relaxed/simple;
	bh=aFHNCukyH6fOLBtyiTWd/CZiGdlbG3bEhWpdcXDRShM=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=WWbbWGDK03edXa9aEHJPUhZ0+3wkEiFWN/tpSJVTXzZyeTf7ylcwJLrSRDkhaIkk/XuT0V5IuA0qqClL9nPAcViBLKYJ7o1CvANDP0iLXhcsaIJmDnvjvIZXkD9RPpYzy+fhVGb2W5zKvBxUE5MO8eMUnKxrNKU44BDctSY/LZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xx0OjnE6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=raZ8a8Bq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NMvmCr026865;
	Wed, 24 Jan 2024 02:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qzliIZ+7n1bZUaC8eDMWA0Bl+ZgO8e5Z7k3sx0nfop4=;
 b=Xx0OjnE63cSe4qLiIeB8WbBKDiOAAyTcP7ELW6EWxHJ6muJG98Ta3LD431Uk+1vwwnTm
 YfM5RZUQKzI6oYqMZYlkCWV9p+cb95my6PILl4fktocRUz5vW2P7Vf+syIPJ9GuqMlFS
 gC9iflG1WiW8csHh+0X4crShrtfSr8SkdV7xS752Gxr7bTufOKSThlecmuixP5yo0Ohj
 UsFsyi2QWap/ZFfNu3v8igf8IXeS1EmSLY68mw6ykBvvKVYsq1Gtm6h/a259L51VeBJq
 K59EVgV8PdAD69gEjfB4q0vvKDOtT5o6b+cZ8GkVy23wSt56NiDaqgUSiuJ6jqOoyPzc Uw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anqwk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:35:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O0vgWL006473;
	Wed, 24 Jan 2024 02:35:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32rruab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6Mp30Z/0aDuPWbG9ipNch+TbbljD5s6jJX59r14FkZKpjk4p9JZ0RfjqlK4nwA9ZQIzP1uiukbUyoTaYUHjosYRdBjkcHHxZPoS83GNvVygYONHDAQ5O+XpCxNqVrU6FyTY/ohMmcvsA7iCQEaylovrSsOURN8Vy6PSIi/37uwwhyq8fWuJKjFKHb5uBscHRpNfhBFAEAwtszMB8VYQr2MEcz5bTWsR0rdr1RYT19T6J298OfanExbnMHcCS6QK6OEGrg5NHHnXWP2Tl665Vvhvba0n1ixun5c9/5dAjYh7Yac+5o4ARlQe/bzJg5JDOdU+NYr673uTGtHEkWTnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzliIZ+7n1bZUaC8eDMWA0Bl+ZgO8e5Z7k3sx0nfop4=;
 b=jn/Mzuxi57pExtEiFe69PfQitI7e15gSLYKeZjqckcIs8LxW3ibgwAPsIq0664OkUdHd7hDC8bPUD2yJfx0tsONoonEW3DaFHcTt3mzBIhlv7lNl/g3FIMbS0uG/2BK537ca3TBYSiNRZadmatpHSnH0KP7ONKAb3V2i+9qBQv60G5EMQtB3to/RgXvpnK9LJqbfutJxweoPrqpAGIMpoMcQVg/Iu9kWZ0ITKpwTGgnmbCFWnjnXidY9c3flsfRQUZ2dF/+5JajSEt781lYW0GFRsN2GSQJGCDAwOajEcCbbHejvGfDipjskB/7JNtghWSboj2zaWgxdEPA/uuTLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzliIZ+7n1bZUaC8eDMWA0Bl+ZgO8e5Z7k3sx0nfop4=;
 b=raZ8a8Bq0VsKvlY1NxeYf0zli4u0mwANf/+9sFamC7DB3/Y/kljSp78hiCVfrEXvSKZV3RgzU/O57oecT96ZQk9UCmqaGp+ObpwbGOr7uJEYvlqXhPvctPmYV3/RrDd0HlXu+1k50Xv2h6oMm8kv8Ofv6BxrKVYbhakmEqr1f4U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 02:35:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:35:50 +0000
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        stanley.chu@mediatek.com, quic_cang@quicinc.com, mani@kernel.org,
        quic_asutoshd@quicinc.com, powen.kao@mediatek.com,
        quic_nguyenb@quicinc.com, yang.lee@linux.alibaba.com,
        peter.wang@mediatek.com, athierry@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH 0/2] ufs:mcq:Code cleanups
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mssvxxtv.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240105021130epcas1p2b77331ab0fc865cc3763765b0b5ecadf@epcas1p2.samsung.com>
	<20240105021041.20400-1-cw9316.lee@samsung.com>
Date: Tue, 23 Jan 2024 21:35:48 -0500
In-Reply-To: <20240105021041.20400-1-cw9316.lee@samsung.com> (Chanwoo Lee's
	message of "Fri, 5 Jan 2024 11:10:39 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 27117da9-ec2f-4699-0ced-08dc1c852dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wSNLVyQq74qZtwkfVcAuYhJCR7QgUW9P300mrh2cX3YIW+hZbyQ3njoiLP1WtHXgNNInV6nXJFhzp3OxAtmfI48OcKPuNfGCBcgaT4Tbg/5TiHNPZxhihzvLJc9C5AHJM/jd4TfUHMIASZnk3dm+8JgjN2PgV35fiD5W4kppNGqPuFiOcZLtHVY8JsaaWhGf8CO0M18IHvjeAsY2QNFP7Ev4U81DkkNiqBLsCJfwI6l0JaL/3TB8doQrbeAuUjibpFrOTRVaJUPHY/wA6WP5+XqIdCXoAcSKGiqUmMnVx0sx0VJM356AC4Mv59QoQiMxP66NqZnBJNy+NnitzMTCi1m9TBEQafAIixwwCqalvlAGY51FCIrRtUkiIPXmsN2EBGBr+cSNrze4UlrlH34pBscyGdd4gLoNU790K/nxOwjZ1SRdbFRESZimUxuWSsUseuwI0V3qF9wudCcg8Rj2zuidL7EFuIzXdpseEL3BKu4bY2GSV2qUJZ8h4tUhP32D42x/SIJQW+3E5EO56W4sg3uXkiRwjIh2+lEZCtldSqb8AktdbZ+hnW+VsMBm2zxr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(8936002)(2906002)(7416002)(8676002)(5660300002)(316002)(6916009)(66476007)(66946007)(66556008)(6486002)(478600001)(26005)(6512007)(6506007)(36916002)(4326008)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ECPLDGFOpq/tiBrPcmIvoTLVhR3dn1YJSr8PBD23rZkS/AUJt3D94SjgV9U4?=
 =?us-ascii?Q?nH1wXwCjSiGvgQUrnmygIP3SRbfpRNHHhQRKerzzAH3xBBxZ7yz8AO7Fc9PS?=
 =?us-ascii?Q?KLC1VVtJJ8vFYnfvrY6O9iSDdCLg9uNzdEsTaXZTLEXqlR99TrucodO62ARS?=
 =?us-ascii?Q?4MukvzyUyqAu/3DbkR4DOY4KIdkJj3A8KZBpQnFOP76ee0lfaenw0+tvmvFd?=
 =?us-ascii?Q?fdfJVbGMJJ7P3xVsbFT2yXDvcsdaezzh+PqBCQNv2bWTqYRtJEZGYKK/qbPb?=
 =?us-ascii?Q?qeSuhss6KSfJ3imNW0t+PpRpcvqyPoWFCUyVjzy5lkaxjUy0pJsetnB2N32b?=
 =?us-ascii?Q?hUYoby+k2kP6dli7O0L1MgrHZO+NJcyOG66gJ8ArJ09A21DLFLvaFHSfU13J?=
 =?us-ascii?Q?CQQ90M2Et8uSGbzwXYHw9vfiSHeTeGnwUo1LbN1UZpD+KX68Vb8qDwg9wrNn?=
 =?us-ascii?Q?HzbbCrol2oM72StUU3vIEGXH7vFPNnMjAOTbYNRTWs4gk/WhQR+rAcSguBLP?=
 =?us-ascii?Q?w0isSSIQ+QXS8DPsZwiciN66xT7WGNhqJ+KbeQGV/R+p4zlGDcvdDF9Dpprv?=
 =?us-ascii?Q?MzIsEaByOkLgXZJjnFhmvZAvRjO6rzPOAroVZVbOO+3RQn7dvuLKEYA0G50Q?=
 =?us-ascii?Q?nwCYY9Ctx6q1I1/M0HhgCT5PtLg4hI7bYXaZ8yzXytgI6xLLDTMSR9rp0cQC?=
 =?us-ascii?Q?R1bEm7MaUNJhz+jlxgpc80nOIeb/5rFMdzOyNkI0hFENGxBERKnmHzemNTcu?=
 =?us-ascii?Q?VYJQUKT/zc4J5Nq/J/T5wUMf1AXXg1CIHwXrj755vjnT4kniuwgSJxhT35ei?=
 =?us-ascii?Q?LKUzlDOpXoZsO+rZD5g5v1I1wre+DWZAF2pgUKM+sH3XnQQVourxlkmBzoQK?=
 =?us-ascii?Q?NPfrKfI6eUTyxeoHEGgAJFHUVx3ZCtix/5a4s/TDQw7GWs4aV5iLlxYZ9l7j?=
 =?us-ascii?Q?75YPcxHViCsRfgbVrxeIaqr3XsmLNvT6TgnAm3di3ZryFA7qvxCPT4PqkYPc?=
 =?us-ascii?Q?MjFoJNcD4LwXaEm7ARJQNUGEp1NEsXClHvm8XX8vgc8OJwTcSSl4EVuTAU0P?=
 =?us-ascii?Q?Tv6RgULpFfyMdgEjxxbkvGsfGwjzfvksRhLgQOgW7gsvVXAYfFK2tSbnnm0j?=
 =?us-ascii?Q?5z6A1sk7D1FZhPtMjZvmuMaGWbOtmGCqI7pwMm/YVSGSeHbet4aG7bEjly5J?=
 =?us-ascii?Q?aRcNv7xHkatEhTDNyNsXiW5qthFvdm4NsthAc8Bkp/cGlXNiDa0VGnunCmBp?=
 =?us-ascii?Q?4IO6MC67mTuPY2k+wJby5FngDtqAAcQ3ywqkKNJOBHOdZ0MT9JAoXkNsi1/I?=
 =?us-ascii?Q?haR5v+x2gqMXkS5v9I7PqYZ6X6yviv6t8na0cAaeAOqsLawyAwc+WUIF93vC?=
 =?us-ascii?Q?Bc/O08mCMbcttbpqbe25PcEGh4VTXy8p8bB4LoZjlIn2WiHtgMNwMaTGWP32?=
 =?us-ascii?Q?gfp0wtvfH5YBg3UiH3VDsCfC4zMR1KGyJDbMEzWEHCvTOZbWsg7BrICAFuDT?=
 =?us-ascii?Q?fghGsfyGsmF7edPAx34TRRUuZNqH5UqP5z9NR19mPbYhrkH+bj3SDRbmLuve?=
 =?us-ascii?Q?LpQ99+rgh/ytgRB2pImxdY+cwkwUtIL3LR4yBNFjwRIhYIvyrGlARoBn2dA8?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oD6rqh1q425qkgdi07fFa2IoCCEq7BBeB/xNLYN89TtQtsV53GvaTHd4YJhiic+JMBOpxVnCtRBqCiNj1a2uem8upwQhSWuZXihFBZBbyS19nzsrV3oEPv2E0SzHX2D8jb9bFKL20go94zAimPko/9Rkx4d3TeeUr92R/S6qgSD/4Oe2mlzsQmDb4Cke033ytTPH16iRG41bzZgdTjTEkpffTI2pZ9zo92mvoE4sqmS3TaBThse89ruc5Hw6zebMLh7py/uQxlsa/b5xjQgf4ucBlsOhJN9vClqUPWAgMNWJ99KiVExGsHE3Sf5zabA5n980btuc21vK7pqExczA7UBtXJ6cINkrHhlyfTKOSSEM7xBdITU6WIFK1EY+O0x9YE+z0aH3PMW3LyIWuEX08jkDFmY1cAdSbJlU8SluoTC7SfLHwCf3o/eifPW/rPdYiSqOLv+pmA1IsYTjZNI4nnoUzpbNjomaD97JiZYCvVv690snNNYexpdGJUB9jJeL/KA5btlujDRxTRaJ0C5LpYN0+0Zah/O/uAmvZfH7eCZtcH0p2DQyrk9caLXIhqOmqtdzD+VwtNBNs5tZNeixkqHbwLQokJSfPZwnHpDnGss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27117da9-ec2f-4699-0ced-08dc1c852dbf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:35:50.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyXca3igDRQHXicar/ewSj5eO3JNz0Jl1WEwsaL5hRYP+KLonZW3CGUpSRI1xmjyMIx/CHpQPzg5ZYl9esVUmIa4BvxKTzx0ynymjuFOR5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=752
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240018
X-Proofpoint-GUID: PEY3JP-9lmem0NwE4AxCQ-0F70LWk7H8
X-Proofpoint-ORIG-GUID: PEY3JP-9lmem0NwE4AxCQ-0F70LWk7H8


Chanwoo,

> This series has code some cleanups to the UFS mcq code. No functional
> change.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

