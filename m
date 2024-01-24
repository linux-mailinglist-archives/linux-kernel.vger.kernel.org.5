Return-Path: <linux-kernel+bounces-36313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC47839F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D291F29980
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9A46AA;
	Wed, 24 Jan 2024 02:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JgmGINWz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GZukn71K"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4B4402;
	Wed, 24 Jan 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063698; cv=fail; b=gNQI1whBtcASC5pJ+/bfSfQH51B4AiQxmrhbd8zpXC5GmFpQq3MKqMbU2CAFjmyhpbQ+zckPHR6HIqJVvSAUNI36lKf5YZsCT1jdlT/PAYkvBwLv2xWkoK5ZlnP0gEqGx8pHqMGGt1h+1muOHDmv8STSGo7mMqZJDW8sHpIttwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063698; c=relaxed/simple;
	bh=bbAaNaEqzy/d2ASMnBG5/02TbbZqX8v8Fs/kro5xOdA=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=Qo7xgnpZ0d/dX7ha9MQe5DTonG+NmpNhrDkz+YivNcjwSx57FxBS0ufx6SwfPoRGFkyD+mhUcH5J/yw1pBQpcpFEQw7XZV/dnrlojj4BfQ7KqcYff0+HywQJEMaBKvJf3/Q54kA9bH8FGmWUG1+nlc10eAJmI+OKe4SVl4dpaFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JgmGINWz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GZukn71K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NMwbN1026874;
	Wed, 24 Jan 2024 02:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=+lAM/R1C/ZSgiyfMjFKIPw/zESlhXcK5t8q7zGtT4nw=;
 b=JgmGINWzjVd4UBIxuDckWDK9sK03J1oO0OZ+vEHms53pJj1qbEHN0J6oJQVgpuysX5xf
 PI+4k3YyV03rT7CSive5UsBxVDAnx939JHT/Qp0higxGJXasWezbKOZygjkTP+yAXdIi
 SG5CzcpcLsTdUlDFIanRQKnJhlUSonvH2vcMqlVJsOM211iRgMuHSywMC02YaGUCpPt9
 WenLr1bJkSjzmw+R0r24SDuR5BkTniOOgpBKJG1RW+v+j30iguvIbgYk7B/yt6AspDyr
 QAs9V9QotnqR/ED5B5oEiemEp9vfYMUJz5zxZDG6qGWAcfFL9eQy4GVKAMvDXwQpFInH BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7anqwhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:34:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O0mlTS005426;
	Wed, 24 Jan 2024 02:34:16 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs371re7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1AQqqhbBcvPpLQQHsQ1KA1jQG/mCrWjo2CRMtRsT5RohdEhxDPZEKLxlBiQ2qmJpD+vV3whvaCSsv7pgfajEKVcLu6Tm1QZEGMF4o8aMXu8RSLseDTf0CFqNzLH2pMH6R9jRFMZvL2ozMjR+cHVwS11fHwnUrljBmmowJbHAjG4tCfSzzCaugu2BrtOps44kgQA94OtaN0ESPd51saYPk+ZkUMjCHBsch+Ou2agQQojBvm0Xs9M58z4UCE2Y5SkDD4FkDP6HBhiS9SAzywIjyZAmO3IFPalSCQh2awEVvvDJ4Z8VuHDkXpc5LoPNw45bT3siIHUgspy+tns2WfEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lAM/R1C/ZSgiyfMjFKIPw/zESlhXcK5t8q7zGtT4nw=;
 b=X8Vk2m4nxWMVxHXY95knFmWsk6CWeOZTG4c7w4Bcc4f8p6YVftzGYJxuPxKw2PQTvUOGN4Ou8Ir82YFTr0GJCbc4HFa2HnATWKesmMKQqQY5Jllj1eXnZ/LIl8wf6DwcNG/3StaLSQ8rjHn5IfRPlDF7PuuR1OaSIae4YtQvv3lXTWYjuzi/afdMQ4d0QD10DrcztX2ISb6KiNpxz/tzZjYGxFMNsN4W3uNyeTr+OsA9sGOw5Kxmg3cnPBbjHNENHuzz/Zr4wmf08qUzb8Sh91dn/25GQrcG9EEPz4nQtOsb29VcQ0tKDc23O7xcpkXokZOvSNQG7thK69eU7qfIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lAM/R1C/ZSgiyfMjFKIPw/zESlhXcK5t8q7zGtT4nw=;
 b=GZukn71K3DD8z6rhc91/zGQ+N29B4s+qYClCnO+xhDCk3n6VZsq1yhYMJlm1rceqrgPNbjlhSW3L74UP/5LOg56GR6VWQL3Qc5nT3kG2bcESN+fTJYPf/zrRXsrBMwfMCblFIcdV+6BBMANQG7g/BxTRbla4gdj5Ic3kbcAtKlY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 02:34:13 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:34:13 +0000
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        peter.wang@mediatek.com, chu.stanley@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, stanley.chu@mediatek.com,
        quic_cang@quicinc.com, mani@kernel.org, quic_asutoshd@quicinc.com,
        powen.kao@mediatek.com, quic_nguyenb@quicinc.com,
        yang.lee@linux.alibaba.com, athierry@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, grant.jung@samsung.com,
        jt77.jang@samsung.com, dh0421.hwang@samsung.com, sh043.lee@samsung.com
Subject: Re: [PATCH v3] ufs: mcq: Add definition for REG_UFS_MEM_CFG register
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf2nxxwk.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240102014248epcas1p4d49dcf2cd3f020bed88eebaeba648789@epcas1p4.samsung.com>
	<20240102014222.23351-1-cw9316.lee@samsung.com>
Date: Tue, 23 Jan 2024 21:34:12 -0500
In-Reply-To: <20240102014222.23351-1-cw9316.lee@samsung.com> (Chanwoo Lee's
	message of "Tue, 2 Jan 2024 10:42:22 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: b885bcd5-4e07-40a5-4839-08dc1c84f41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EDcoeEjEeP7yA/x9U5MrdAQoiLjgOH9aCLTsC/K+O9IABe/XtPlW3DlvKzx1As6qaBG/N4JUu1Pa8n1w5KUKmaE6p+ndz/802d09CzYUBQg9t2jNPZh3DiuC3LXBT+1cI0V6/V/T9bKA2lR50OKKjoKl8kjqrMxwk22kSmDXoJR2CQuzGhe0UnOYsXXbXfxLAODxWKNMx45iJTUPJX1fUU+TAUxDn2wytw/kPeB/n6W8+FsOXiflHhStlPBdCkm3BK8u2LMd0qg9bmgCVET7/3pS+L3o/CH9xkLxWwMIwx0qp6A51KTT1rp+XQGRt+3XKsOceOeXaCECzMmDp/vb9ypmz+lu9orfOc285LieIOncOpdtDQlxaaPbYNlivkjA61x2BX4zpBL5MZNfyH5yGx+a0GpFwv5oPfVEa1k62l7WIlBiBu6xq2IHsjUGmCPV2d2xttA/f6YiIWgNL2tBwRUWI1pAQ2oMc55ePjTfl7cjnYwcnI5OYgBG+VQ8q+2SkJSDDN/+cwjgf1lKkmW/Xy+oPYfEkWFFUTTmMBa9g2VraOrdaFp2aGVvFzI2rqVA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(5660300002)(26005)(66556008)(8676002)(8936002)(41300700001)(7416002)(4326008)(2906002)(478600001)(66946007)(6916009)(66476007)(36916002)(6512007)(316002)(6486002)(6506007)(558084003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QhkrGqv9W1CC8zE5ZQPjCaDTboo6DNUSe4jhscCTMGdEZKvJy4F5GfXQJyBM?=
 =?us-ascii?Q?i2RW/c/ucrEBzjSk/7WnThb47uhHVFKVoOB93+tRdstaeqfD/geCKBj5/5uA?=
 =?us-ascii?Q?w6rVWXyQfNXXfMPthPz4W6y5EruPiHlSEOCcfK90oPvflKiC6/zc5448Afki?=
 =?us-ascii?Q?aanybzsO6dUmqx0mgrFwC7sIeiyB1Klda4ebuRetV+wEO2u3xxkKgJrgHyKc?=
 =?us-ascii?Q?SQjHEiJHJHYbvwFmKNt+2XpKUrPJaP8KTHtApnQsaRYotu8Xl1bFPKLvK3yK?=
 =?us-ascii?Q?dhOX1HYS/vZNKMe36eJBd7ojTmqhzM88anLyd807GT5FY1WF4SxJQr2opAR4?=
 =?us-ascii?Q?/HGbvF/CbV4nFWKciarmLTb00bNxJogerhLMoM/xOjZ7UdonRKYidU0iwnuS?=
 =?us-ascii?Q?yd/zz/6RGurWwCFO+FMDb8FertIUVFAblA3OgHlVitPMEjbcZcVOHbyWX4TC?=
 =?us-ascii?Q?XGQQNkrpNwDnJAIIXWVvs9v5LxLs7AOs6315VibupE5L0If7IB0n/tkTNRy0?=
 =?us-ascii?Q?HpDhWREOgjeDuGeWl16g/lpODZZgmbVmBbpm8jBvXkOBbG3pdi21LW67RpRI?=
 =?us-ascii?Q?ITtEF+bnP8G/B8HRNmswgsQEnyWoxzb5tGWPxjeCuLAWN8wbTcKVwR7+ZAzB?=
 =?us-ascii?Q?w/RG6YtdhjYB1UIfVCb213yii2KbGrZDklWBIUtmoIbCYUOQKj7cdF91mdYJ?=
 =?us-ascii?Q?m2c9Q0jGPJ5CVaNQlONGUR0ckukSFl5gmor35zzqO11kZDGxtKLTRzBW7d/5?=
 =?us-ascii?Q?N7BQLjGL/dpdVtVEx0edt1Q7xucgNBmyijvSEknJdpCv7fK1EGH2BdH6zYRY?=
 =?us-ascii?Q?i6JZVB6jTR72ZE+bGdm6qz7/cpimwNHcB0CoCNMxC642hc92ePONBb+eZYx7?=
 =?us-ascii?Q?UBszqM8duokYmREazL0RT/0LRdIN4NbmlwWaCZvoEdN3LyFeUY4Wer0lkHf7?=
 =?us-ascii?Q?alaGrAayWkAgKIOXWwA7qL9ggO+TkNqmMd/wRs11OsbKkxK5bCcqRMu1A4hK?=
 =?us-ascii?Q?gpLGF3vwniWP9laiPD1ITZEb3Bdv6n01FrFowmZwW3UnKWWKxrHZFJGOyeEo?=
 =?us-ascii?Q?nT+XpSsFvzO5YF8HSpYKKfEkEayDE9qk9narsxWnpqadHdagO3IdY7MfvQac?=
 =?us-ascii?Q?DRASgTdUoKOEOgR0bewVUyHAPhpX+uMgTEJ1/LdcrxhUKxgahuACYxJ2ct7/?=
 =?us-ascii?Q?YHBSI/pMgDYSXUtf4NIpKwlYVUfdl6vxebIzKh08tSK8hdA1cACirDDuQrWQ?=
 =?us-ascii?Q?WRRjZ1s43lyfAfL07AqtwEKq5sgYh0M73e70/QB7DO/2wwtJQmgq1edLlCfq?=
 =?us-ascii?Q?pmdwu64AwDVhd2QPkijtUoD2JH9HQTwFIr34Fh4Wi7XT5MvWGNX3TrT21UVK?=
 =?us-ascii?Q?7YaYqfJs/eU7H1bT2f1T8S0Hi+imhBzhAW0DgAvjJ3PBQEeNq8qhuLt15o96?=
 =?us-ascii?Q?WCzkAGkPzdWRsI0ueaYJcGIKmZEchLSbFOUg8d8w6oLwTEiikKLEiWy+u7Wc?=
 =?us-ascii?Q?DHUHvNYc7xrPCnrW+J3HkpejguTbk/tPs/akdnPumdG6uU7znii1nqE54CbJ?=
 =?us-ascii?Q?JmCfQtbuywCanazNIlrZtynSVsY6KvUqhwopslI1aa+IxyOmph+gz+MAo0sz?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1mYf+2DNSaqxz89XWhAAuoqQqH9rV8lY/kykM9zyp683jzdzUu8gJYeeASRG2g84xDnB5tmSUJjHC0a5u0FtzwW3e9BQa8yreSmY15pXXVTW7jPfjK9zhAChbTkH7aDQE4XSSOaEC6zthP/mSTlCgcHD1pr214sMcdWclfamIzdGU2NfQzHdd/RljoJ88CQJpDTqcQucIMHMJnRLiDbhv9XodxqFu3stwm0LBR0r+B66YT5UG4g7RffiiMnu/3juU+M6F9BNUE6y81kdvrtbOt/jjhxUyw/wPwTXGB8aC9sjLsWxHo1tlK+OB9wtUFMeF3x4Z+v1EkOI16Ge8pzPVcfjXNvlPNfxiWJiTR1wRQgNaemgxO0+ExbvbQz0b4IRagywWdRCG3tRnyq9sk7L5v8/LG8iMBRjoz5YzHvNa1rkuJBJLpR8LfVx0yiG79LMdYuh/8RdH98ecSMTsKjc0YCpD61OccfZf+cGJ33LuxagBu5zJPK8uy3DiYzDGjP87FpoEJy235V0Bc8jW65PHfi0jy7/ZxzkGo3zUo+hcrCu0pVCbyg1gFaOvnwcwl31zM0VJgYXoDQ0mF4Rh+9ySJG1iV6+CKS5/nL4AlMYb7Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b885bcd5-4e07-40a5-4839-08dc1c84f41b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:34:13.7342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ebTh02xK+DWk8qLTq/PUSoSU4Y+PRt/04yQy7/ti0h0KrxsFfv/IlL7F+6Fk/JiN6ZeUwtgU7bPJaG58ffVo+FfT3/wU0ykg+XS5bIC2ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=939 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240018
X-Proofpoint-GUID: PEYm4BUmfewRSsn_UFq4dRe59xkMYagY
X-Proofpoint-ORIG-GUID: PEYm4BUmfewRSsn_UFq4dRe59xkMYagY


Chanwoo,

> Instead of hardcoding the register field, add the proper definition.
> While at it, let's also use ufshcd_rmwl() to simplify updating this
> register.

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

