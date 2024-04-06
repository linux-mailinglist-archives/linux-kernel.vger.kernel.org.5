Return-Path: <linux-kernel+bounces-133752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A75F89A81C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5093C2845D1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4500AE555;
	Sat,  6 Apr 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g80FSZEZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0MwInzd4"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EBA38;
	Sat,  6 Apr 2024 01:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712365825; cv=fail; b=TQy4Mh6jrcHhRV8+MLRE+KWHEfPjyr/gk/LURdOuhXKhm26K3/keMVwekhdk2vgRDAal4Dn5/ZRz4GYdPiJ1cCPG6ueAUTIU0myVF12jCSxPSzAIvI4pay34fVVGDYTkZO9uS3Fk60m35KERV47zcCrLVez2USzNJ2trvRvmOJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712365825; c=relaxed/simple;
	bh=PlT19WmIu186EpiEYXyAupmGpuKXw7iinfPKoAnSlck=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=gxe6AERiP4oJ0qv4nftxbInG3mR9h439QWzFSgYCJURo9U8IF+ot4PmrYL848PRKcm6us8+2Ozofu0uQQ5Uv5MT/JOB8wCf3W/gytyvm2TeFgNk0rSh7Q8iuhs9r0xkQt26A4HyWUxgwgV4we+G+qb0gukg/l9TCbqrYoT5Gb7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g80FSZEZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0MwInzd4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4360iFeV018643;
	Sat, 6 Apr 2024 01:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=DoAIv4xsK+PU1r9NFc+vIxFmjjseE7hSjLKnG/tfEUA=;
 b=g80FSZEZtA8d08q60VrHth8dLfZpWrr7STFiyn803u1nDSaVJjh/MgNreU/Bh2f3q2SQ
 m8FIZ+/HzFFXwMbzGbDeu32voXEsgcLdPWntZJYYiPgYrKaAItGEJbKQY8bzAQyjyyMt
 B7GMnrSH+YCp6E+3EkDVcFRz+ZouywZAE/pu5DbfqVt2CVFcpmpaMNgH5eaJsKiMejha
 /tahgsfPf4lf4XHk0adYrsffg4A0YtotzEcxv8C2oVLD5zcF9uRe8U6DJ5EhKUzs+3Q9
 hqq8cIUDvSjSLEHKUgFHknFhsew9kaGccW6nca9Qc1bvOb/TWuD5ydF/302fNKDzOgnq /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9evyvm4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:09:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435N1kI3009342;
	Sat, 6 Apr 2024 01:09:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emnruqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 01:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4W+gwKONS/XWjhX4glFwc4NRkIxcCGT2u3Zzx7OyMQpmh5OI3qvGejuCdNfNu0uNVLpoDLGmhPoDrmAyVysMk+SybSf2b371WJLcD06Da9XgenqnQPpiZb6BcncoNebW1tXTpAQYw0pZwxCRplU0/wt9Q4mUG7Z/RB2CdGe8BolaqipHpszjhFnKBJn+uQ9tjAzFQbmEDkH4WzTIscoyC+BMrVGz03L4UYu+h+XWyE/RJbbWjJ068mNhmofZqWkEOGY6cygD+6fzrtno1mJ6saMoPdiB4ofgagek5Uij0tSTjH+NQcOwL8pfvt9PycHR8WhsA+Lee93WmGH0xrmVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoAIv4xsK+PU1r9NFc+vIxFmjjseE7hSjLKnG/tfEUA=;
 b=b0EWaXiCNiDPWiluHh9JYICuPjjYgSAMBL36YrScARSCrX9AEIy/N8HQbkAKKRajxu3JKU9CWhMstcfL+krK2KT5u1iTh8UIN2qfSD932ZGLjXGrPv1glBcA9u6Mkgyibs+yev6p/HnDZFrKm/0WRNDQBCOaXkglEd4/aTPIKJBHukzf3lUyayTKGmiulDELg/fXaEkBOM82jkqquTxEPRhpPPN4wH2K0Mt8mYdPLFrhO1n0E7G7glRzqXuAWJQucuHejcsnj645kYoco+badUSMRInllQ22GuoYhjXQtRWIeX6eI/jBFO7DTuepRO4Dp0jHekro/Dv+ryPG4qC7aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoAIv4xsK+PU1r9NFc+vIxFmjjseE7hSjLKnG/tfEUA=;
 b=0MwInzd4J5xuSo6+cwWCyLQfK3EylHZs6t1YlpRlZzE4Xn68WW++0gxJt6j3ZO5YtY1yIxT21q+VDSmkc/sPmBdZbPDhmxnRJ/ApNFd4HR+MZH+CPK2KRo36cZHrxgKtghCP4rurftBoNQ8ToiciwybB5mEf+EbTR2byFZ3w8Rk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by IA1PR10MB7514.namprd10.prod.outlook.com (2603:10b6:208:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 01:09:08 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 01:09:07 +0000
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam
 <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke
 <hare@suse.de>, Janek Kotas <jank@cadence.com>,
        Alim Akhtar
 <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van
 Assche <bvanassche@acm.org>, Can Guo <quic_cang@quicinc.com>,
        Anjana
 Hari <quic_ahari@quicinc.com>, Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5 00/11] scsi: ufs: Remove overzealous memory barriers
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
	(Andrew Halaney's message of "Fri, 29 Mar 2024 15:46:42 -0500")
Organization: Oracle Corporation
Message-ID: <yq15xwvs3fl.fsf@ca-mkp.ca.oracle.com>
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
Date: Fri, 05 Apr 2024 21:09:06 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:208:134::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|IA1PR10MB7514:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KRW7muDbrPnmWpJvkNRzAxKzYrWMvjrXv1nexAaL7bxqF4a/LUxE1MzVEssUA5XvL3L+AJGx+5DpUH+L7U5ycKeiYQbFdDXDPyhgxYQxMSwrzQ7jhz/VAE61No4aZwL2YDC5AyoLCQhC/r2yNfqVegoJEJ7hfJcGyOLMofSocSBVjY8NlpbvS7HTNGaiGTWIGt3tuqzyPrSP+W6fVBFDiVjOnvGZzDp6GFswkA3fUWV6CakmLRBTXhCAPvB2VJEsN0eS/uLffjY6vKuHugAwFlOLGezX1Z7WMfscSMyxUapLjgVEDjJqhmzyRP+W2nFIjro8PrE0KyABt4bX7X7WVXYK2IgHQmaF/jFceshzyemZ4CXKIesHiz6ukPyqhemFPY61wUUKiRqyxk6jALWzMZ4p4s8/INNN5vyrXNIA+6wjpEg+Zi40EndHVRnyt6HxI06cDP1ybtVMVjB7WmzsXhEXL+mEa+EBgdXULp6MtYaxA1KAEbxBziBtPJDKQ3/jyUNLbn747Ai0WHL9xUVfJNckgqTF/y5nn4e/c27q1dF2vRTgP2MvyC+KXA0Z1u7V6WlsSNHz8Oy5IllW1fbP4ofPKkTeGLFjI+fxA04a+F1MZM1h72Pt9lgAG8VTa3UJcyWMp5HzXM6vd/11JMUtn9ldT2guGBA9O/rDznAFe9w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xIDLKGagk5qwMHM9GRqKhqdYfRaS5xoTSEemitSLHIrZ0OOxQdPf/5ZhVeAt?=
 =?us-ascii?Q?KgnEnc/YKn6HQ9c+k2bFKxKhT1OCCjBZa+ZMz0u2cd3X+NTIcgZqHvRm+wka?=
 =?us-ascii?Q?uxEH7TIEMeLtcm+JASXVMq1J9MWTm1UCRYW/p4wP/LHVOwX/rivNMwiJxPCQ?=
 =?us-ascii?Q?+vK8nVMEJLgcb75bng7Ye2zSZuxENvI1TX5sT4RGecQCPzwBu+dBnb2yr4V6?=
 =?us-ascii?Q?7jG+uOcYFGZl759nHywfVf1OSsNhtaK8hwden6mfwuFODKOLwulaPIVA+/fI?=
 =?us-ascii?Q?3N27Vmq4/U8kjbg+CeZ1m/4Zh7aV48bQ4C3emJgD/5WrYlvGJkcxU6vvMl55?=
 =?us-ascii?Q?GlPv+CDVqb4ILoda7KvsNO5vqwoAkLEezOGIPhyFn1pVK9j4Zcaiptb79mmD?=
 =?us-ascii?Q?jevD3mHP9oO8n2fYBeOlVzGeIwGnFo3A0lO3Nw77/cXwfKPwqWxOffFH6bdz?=
 =?us-ascii?Q?zh8hmPqNMybTysskICzxSK/ABa5VRTizy8KdiEL14qb6DjbMnFl26afqs1DP?=
 =?us-ascii?Q?HvaXRsv6XLK38jq+8L9WHI+7YsNF5acNBtq9uVlg5sAKJWIBcXPbJXGytgaM?=
 =?us-ascii?Q?5xg5RIihxmv7bTOlfvYya87m1F2ig5/OBXRqy1cAMR8I5oIi51LwV8qs+CmZ?=
 =?us-ascii?Q?NbUit35Gggcqj3m0BpXdUVE3HstK3oB76Z1UWe/lSb49VuPNFNxv92A8yh42?=
 =?us-ascii?Q?RCiLwWHN8droSpQPclrrxaAyx6+zh7K+o932NNpAsaugp0HitYkpkateU+XY?=
 =?us-ascii?Q?3dSLZ+IJklWiEV7dot7W+FCM9/upKNda/B+YJIOM6ASAVbT/SXAvOyv2jPnE?=
 =?us-ascii?Q?5VXSssL2oBePfKiAeUNH9RwZwSHG7+vHVgklNlimouiz0gh4jmb4nGUV4O1g?=
 =?us-ascii?Q?hUR7exPv8J7FHh0oISG1eCjpmm7f353ZUKVKlLPj17IjGYHYIsnnYSqLtg2Z?=
 =?us-ascii?Q?x/C7TxmlEeCLm8j8KOFbVmKAaIlhPlquYaNmrM1TQSUglD7CPMX1mOl+yiEG?=
 =?us-ascii?Q?vY4JIgwztKdmf7DW9CR0GvWMsLe1oiq5akH3zP6EU0dPIgR3UX/85e3G54bL?=
 =?us-ascii?Q?a4R+trKxz/uGUC9dEC5jenNk88Lh0aDLRzHd6+UtMvYO8zt35kGj+N5AQ8fo?=
 =?us-ascii?Q?9APwMjDl8NohmuIMvndeYATQgmyBCdLv6aoRRplzrP1+EEWNOC+jeab18OWA?=
 =?us-ascii?Q?uFF27tBpXD3Ab5s1f2A58tNLBecsdp49opi6vZFQ41FmWK7jaH3343wJpgHl?=
 =?us-ascii?Q?ttfAp6iYEOS7ZQKy7aC1Hy1NH8AZqCnw5csMZfhalhndN4PtwCNvY//v4YOa?=
 =?us-ascii?Q?Kjs4VI5Fg+VBjzbszRY8Msx8sCuhOLT/8PpjpThuqupO1VihxM8RoQ9p41uY?=
 =?us-ascii?Q?wztle6MWLLGHGI91R3Ucl1rsJSjJ4MpRs/gu7kTc65Lupc4pbPm1+ijfXOR+?=
 =?us-ascii?Q?6B9cvln6fdNvjUmezYl8j/yu6svNorW9F2IjhZpmYWxDLgA1U1h/iIW06OsE?=
 =?us-ascii?Q?qlCWPf4ROxgultpGR6jxtC9peelnl8l1Z/z792iAJDCXCSEE8i9Gw1iE4jAe?=
 =?us-ascii?Q?j16Bj/q0Flfly8svjLUKgnc6TTa7MwbpzFKSGCwTROCbhShbgq2+3gGrYAje?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VS1dn4PQ8z3ChrQSwKiTGfAk/IaYnPhkJfEgZiVKmvm7pHwkqxSlwV8QvZqEvJWDvfnf1i+BeQwFHztTnRG3x28PgKoBMTlrvNqoD0bf+RmQ32U5IvlZ9hh1/0eOgYBI3625IJSHJrOhG8G6iR3TQmaDeTkC5IV10cnnrgLS94KjPRcozfCT4R6FgHi9QB5gntHruGkGUcpaMpot/ze6V7kpms2lOQ42Re8wBCVj3jofjwxg6KGq9PoV5C6ktlbiSTK+NRSxWMb2HNSLlYGZra9Lpvjf6Ujz4Yq7lABOSyrCcvrGqhQjqFbjQtGf0rj8iizHPcXP7cnZursdzw+6VUoMZ8tSAOaJKRfkUjVBI9TV/o6K1l+JkK2BaaINXTVL38JKAZWrBiVFoCA0Z2+mQ2hjOV6opPXbSpUkWDtZWqIuYcFROebSDRQKq8nM5ZQOiGim0dSB5GsbJ9zbc+8vaKL2wixgIcv8TUAfVNitxEmwy4fSLR/baxrIfI+JNnwawmISc7sf1WIs2zTDvWtNqrrVZc2FhZM8IVcO9UT1OPWhfqgDeK0Kb8DfjserAZ+XPVnmI6C7vQoqW8XimoU0KzlghGW9YzE2u8mzURscRzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f257769e-1c1e-4c44-7ae5-08dc55d628ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 01:09:07.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxVqZ98Cb5hpbigVms1ROIH3379MpfZmkhTYFVkiqm/Euy2nydAtOdyN1HJhKkGNeIIuNJh0DJZkj9YLIgsPrWeao7g2FGsn4q3zkcRDJZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_31,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060007
X-Proofpoint-GUID: -5zjXq93gYw_T9z4nLFUcRA3ShIcanUd
X-Proofpoint-ORIG-GUID: -5zjXq93gYw_T9z4nLFUcRA3ShIcanUd


Andrew,

> Please review with care as I'm not all that confident in this subject.
> UFS has a lot of mb() variants used, most with comments saying "ensure
> this takes effect before continuing". mb()'s aren't really the way to
> guarantee that, a read back is the best method.

Applied to 6.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

