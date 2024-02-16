Return-Path: <linux-kernel+bounces-67911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72A8572E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C1D2820F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788F5D299;
	Fri, 16 Feb 2024 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dprU1v1/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xzIbAmox"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C18A50
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044716; cv=fail; b=rgnAvR6uLilSZrz4WGStsq9/DTBvy1HjYhHKVmuif2kVDyRBro43+H/VqY9NPu1cJI7nkeXHsI/QyhBiCB/p7jMmjZPRSypMwPgLWtIXMBoToy79Z7DfuwKXfHtgo9Wpmjqs7xaYinGLNoF0urXx4gEcOKjJ7RFAJ0ODCazRZUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044716; c=relaxed/simple;
	bh=wgE4aGtCguzTCgpprG10QKxkC3WUf8ZMfydzA4WEgwg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sTtMSFWWr9ebGRsF+R4I8iUwaP12+LDBwMNhf1Rb9Q5gEb+BWiGwpoEGfdIFN+WCzdL5bjYvETVn7nYeTAgfkkSa9ILQ3L/7qX6PgulCuympuvF8p4Qxn4o5kwnI3fwUNgO3465ZKKKvOpcp6ujbJVg35CzxGGzMSCy9rLlmW6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dprU1v1/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xzIbAmox; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSMnW001613;
	Fri, 16 Feb 2024 00:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=e0hH5Kg91nZVdX48KXIAaDB6PCyCAM06EFMjzKgi9ZA=;
 b=dprU1v1/it7R5Blk18S+rbBRpdCJ37xO3IRH2Jk+6TLZjg+Z3Zdl65Ig6N5/k/luPczP
 PXfJ0qVmWabUJZzUob7fGAlt6SDeAT8lIE0W0oTwXb1IraCP0z4T9q6xpBtH+xatJm0i
 gGDfc95YrE/EqLF+5Jh2Bj2sCKx8xzc1rm3YGnBhYJnKUYdWbhHIqQrLgEvTgpFRAdN6
 9gzTth4ayHy3veLrDXN3TGbENFr+EEEoiBeSOQsHxJgA9zhoI8F5ny7ogNbAx7JcK6vw
 rmnXtmdqyWY64zmEGMZyh2lS2R0ZxNWVSNjBwfudyxJlL+1l3uCvthmNSaHw43UXf5Ei rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f040gx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:51:47 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G0Wafe000606;
	Fri, 16 Feb 2024 00:51:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykbdh1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:51:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgc12Z2gsAfjw1sV6sfVB4oIalKED1woVNcDHUKwOwF554+40UNieObah8VsQSrT5qVkFKwtYAgI6pHtdfBAOi9xGeJepZyaEUJH20h8uV87SdWlLNJ9ZeuB4LQRDDNlSMWWLfBrAnY5+XhRIyFiW+Z7Lnfg5n/5FkxmXq/mYHBO2JdPM6lziJwyjKchMkVE1WEWXaqblyAAhwoBxp913WXQeNTzDsUbtoGje0v1vbOMfAg4uVk06hExUvK7fPOfM+GD3M2MpQMewG/wtG7VJDix20kDSji6nz2E6pIkLcn9ksCS/aQ3bevYxxCBMEs9kig83KDA0hQmD245fUOknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0hH5Kg91nZVdX48KXIAaDB6PCyCAM06EFMjzKgi9ZA=;
 b=Ir1CKu2VLyrZQeEYwW6Cot+NJy8vRi56qEd3UQHowgbuYKr5CV4E3EbF6pSOZNIvbt+c4g0LvCMXVuNcdifuvChHp5nS2VjSzHgBG5fMx4i08YjvOh/7XFXHIwUPbdxHOxvrBesJ3Gb1tc9cfH5coSgXDjCa3IU3eK16wjSf1te+S2oarecZhWJHXP96DztKNfiC7/X57nXQABLaMrQFOOLlIAC4PXeKsOFVoPp8I9oJPo4zbyS1Lxmb2V9Nqf/y6z4vLuTtwpah9sKM7cW0XsCRfZK4pTu6FiwXhedKqGasbb4YIU4DGXWuLydv5zy0VhTfGkwhh4zSaZ89W/zQPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0hH5Kg91nZVdX48KXIAaDB6PCyCAM06EFMjzKgi9ZA=;
 b=xzIbAmoxgGu4YOaW8Wp6D5MJoa75XTzptH4DjJRWkKO21O3NUA0v/6MpyaSnJxrN+a9eJpFa4l5yuiWQ11y0+fT/LGfQ29/Wzq2oK0hZzGJfzkhrYj9VaR6USKOOqqaHwixjcB3Nfp63PnlDr7Zm3Mct1vhMFhKu19xRaM2dXxY=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by CY8PR10MB6905.namprd10.prod.outlook.com (2603:10b6:930:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 00:51:29 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::212c:c0ad:d364:3883]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::212c:c0ad:d364:3883%4]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 00:51:29 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [PATCH] printk: save loglevel before console_verbose()
Date: Thu, 15 Feb 2024 16:51:28 -0800
Message-Id: <20240216005128.1045812-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|CY8PR10MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: da5b571e-f39a-43a2-ce71-08dc2e896919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Pc2P0KrduSg19xnvyQjTX35uMgKC/tpsgH/czksHOpL2V4e5eL/ucEMDAMkZj2i8USBxkEX0nqF3QxKw5yieZnD88hwUBo+qLHEKOmLo9o1NserbciHgVZIfW/eSsHxTJtIq4pPP4Q/T3Qa3mGwb+lxUhUH4kEzkzZik/NFS6e9JuAA9smYu1UmQMaBRGIdfFUmz78iQ+TSAb6d1wARmUBDFE+YZ5dnPVXjQNZ3xpFCpOHsLSthtqqFpB7pfLzeTkSW+kHKRaW4hod4nGtYLRnQ1WUBU5J4K2gGlT5Tq/QiijHM6CjRwHIPwUiGvjR7AcnUUN9Q5aAuM9Yx6KFN2bL/7MYtiYCiMqllEYV+Lo50rEcUk36+xrU8U40AV8fa5qc/GZmzri8Vu3bgA84thfEoG/1+sGgpz9ooVul6UBI85y9h4uVxQByH945nHz/5kCSOJ7+wG3I1V8LfJNI41E/9S+U7EC1WoTkUntggZnN7DZaSS8ByPUWvPupAu3r0NV/aS3ilzy86KQ0kEMotH7AEz14nlQ7pHHQl4jUKLh6DtYKRj6IXDsEYaZW6NLhzu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(4326008)(8936002)(2906002)(8676002)(5660300002)(83380400001)(2616005)(36756003)(38100700002)(103116003)(107886003)(1076003)(86362001)(6506007)(54906003)(6916009)(66946007)(66556008)(316002)(66476007)(6512007)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5bTanKj88XHNudLN7rZI5WZn3ErjK78qVgtcWkLdUvaGKPWY+tL4g/D/pwaI?=
 =?us-ascii?Q?5fTObyBRpEDsXqMgTV57l4FBEvjaPORVSucnnh0FDT5rOzrPnfhRU1UJm6ey?=
 =?us-ascii?Q?DrmmJGuVHXJWHb74F8Hp9jtgIS46GvvdWYw5sbW4NBBClJbF+Ayoq301efl7?=
 =?us-ascii?Q?83wFIuUyMLN439MZyM5ledlx2+TswjllHveVc+WyAJ5D75u/KELesEdrr6WV?=
 =?us-ascii?Q?5zDZYq1YshyDS03G4+bjy+q38zbYBD+ZWSYGTDJ7DyS2pTQAb1fQmJ5x/aY+?=
 =?us-ascii?Q?oksXvLC207BcAzJwWd35yYMMweiC/hv50dFwtrjPq0NpVknL/9e4+m1CsFpP?=
 =?us-ascii?Q?pBfmeMBn14AtOmyc6Cyg92JeeHKlO96LWuWWw6eLQKyYOyVaIC6eX19HEyil?=
 =?us-ascii?Q?0PChK2EVtiF6iBIH/Y+/CFsFTUd+brpd0mJsp9mMAaK0MTCbJhOOv10ODm08?=
 =?us-ascii?Q?v9cjWVyMu4wSc0m8Rv9n+Mw2vykaFPDYwSrm1OM0kipgfcD0/jqFumajxqUk?=
 =?us-ascii?Q?Nd77Xd2x/1ulp7BLYnEbnt56cVSYOIIkiND9bm5ca48WeFIX9xYdeML5+NvP?=
 =?us-ascii?Q?ZciVvjiVhjm69EvpZb4Ch2tMwgKDZRuvvK8mZXKXguDNshDN31YHWImJSur8?=
 =?us-ascii?Q?jLztfSJCz2vm6dnqcc/hPzJkL+AGhXWvdkQRXruCuUacBEak166k5sqAvsY3?=
 =?us-ascii?Q?j3U0ZKGk+VUX7G+lh+bfwoeyoXzlXE/xLB38UeETjNu6k4xkrZkiMZRaSoyi?=
 =?us-ascii?Q?8ZPgUNT7/I5M+Nq4/winTgtFWyO5nbsJ6GcbRHXOQmuoe2e4xcOFFeSRqFVl?=
 =?us-ascii?Q?Wg8QKUp8AhhC4UJe3SlaPM2pZmEQ06PD1lEqRQoi7WXJ42fqYAIHWMptT5lT?=
 =?us-ascii?Q?Ak0BxIDuRleAg1YYL7VpH1r4vzp3y7osp5JS04Fk7nCtJ00AipVqBKzH6Gha?=
 =?us-ascii?Q?JkpgUeRRs0fE7mkq0KNu+DRV13s/+TXLtENAdlFnJL1aZjytVHgekgCsuOr/?=
 =?us-ascii?Q?izwG2StB+DIQg8pQgsbEkGgQLT7Q4pAgi//stj6Tcr3uUvZebzN4+nRYW9V2?=
 =?us-ascii?Q?BTOPckfq+Yef8i+UezQehxoRrJ8rbfOllGn9mbxyVsJl6TRTVKiSuMcD/tnw?=
 =?us-ascii?Q?Fs7t/D+IY0+aLnlt/elKNraqCECRv07fYYKgQRObFFH7b78jxfl0c7/lls0/?=
 =?us-ascii?Q?QtBdvfoT/7S50a5xP41FGS1iR2DOTwyOW0/4VomeccyPo2Os82S8Tjx3vGTl?=
 =?us-ascii?Q?OdgHYzBM9z2aWitBAo+whaj3H/RjEfEwWeWgfJMaf+o90Caz2e+0xP2VlNAY?=
 =?us-ascii?Q?J+OeVCmPdVOgEohQ6R/gsJucp5pJxImOC03dHn981IOFHLjrAu4JEmN5ftQs?=
 =?us-ascii?Q?w22xlMwVnzWkQFllV7R4hJ0oApP204bRMjC1nGztqfZg2F4FKTo91q1HbUyA?=
 =?us-ascii?Q?I0u173hYJHsIuaG1XfVixI0ES/Ah8DRBWSGa2NbyfgCtKoarHE/ZbDroNSMg?=
 =?us-ascii?Q?wYPIToyJN9uWraemeUSCWpkABj1TyOAc4vdZ/HO2yeZ2T6QXwP0L/ijikJU4?=
 =?us-ascii?Q?gYpfdIh1jnqKriGPpJuEn8GkoUyNEL48FcrvMI1UD9OYkpilaszqmaBzcwhn?=
 =?us-ascii?Q?/yMuNFjjO4OdK1YskEdleac=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xgvEXo3UO4jP4TK9S6sPF6/lGPiKiCVnaG/fx2B4ynvqJ2xUMl+C9FFIwoPTIsjvHBPZ1JWRVC2lOwL6LNcqIdACQRRD9hzXZOIlfhWRrjVSvTkrLF0yd6KEJELXo/5TvdtquSKigVjYGI8XSz6FM3ILjNEedQWhab1BtCl3kw9DzBcb4v4IqJBvJVEbdweUZFJ5Jum5PxCrHA5BAEfguq2urm/qDYr3qsNgCxAG1+i0yQA7/A8IiNh/p9ZIPlGPrxCBW9WWaZ74BxQBGpnQbi/uYPI8Kc6FKud/2dmViW5X/GnBBlruPr+dNiPlIham/sJBmrdMgaSjFE4xsa3RfWmQIJOOY00eDZCRWtvkvW2Yla17/OWmY89R3hpxyPwXOdowQSvkBALSwIEBZS+zVZpuREVZVi5cdfwDeT1+/6+SBORKNu6xAPFWJMOYoRPUvrupAi15ORRS6stFJUeYhM7dRlIn1KMRkikkEFnLXsUJZqs5Fm2sFP6GWR3/IKPH5GW0hgYdv6eig+KDQAQfAEWAb6l/mNFsZzr2oxutlUuSh+xVkucEz/fS9ge+H7AqRGS7wUU98YK5xhuGN0JvUknFRA7fbytZ8K7013tb/Ik=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5b571e-f39a-43a2-ce71-08dc2e896919
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:51:29.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cQpAcx2ap9+lqPO0M60Ymuvjb5ddO6+v4+sza3pCf1vwqNARBDWaTUvNP8i01TbHrykKFjw5F7z6ZY6Oa9EuIc6PnfSSZy0F14spxbenFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_24,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402160005
X-Proofpoint-ORIG-GUID: t5ShvSU3ErPIYz0XwPinNdQpBHlMvK2A
X-Proofpoint-GUID: t5ShvSU3ErPIYz0XwPinNdQpBHlMvK2A

In panic() cases, console_verbose() is called, clobbering the
console_loglevel value. If the bug which led to the panic related to
printk, it can be useful to know the log level prior to the
console_verbose() call. Save it to allow debugging these cases.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 kernel/printk/printk.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f2444b581e16..97bd9427f118 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2521,11 +2521,19 @@ MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
 	" and hibernate operations");
 
 static bool printk_console_no_auto_verbose;
+int saved_console_loglevel;
 
 void console_verbose(void)
 {
-	if (console_loglevel && !printk_console_no_auto_verbose)
+	if (console_loglevel && !printk_console_no_auto_verbose) {
+		/*
+		 * Save the prior log level for later debugging. Avoid
+		 * clobbering in case of multiple console_verbose() calls.
+		 */
+		if (console_loglevel != CONSOLE_LOGLEVEL_MOTORMOUTH)
+			saved_console_loglevel = console_loglevel;
 		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	}
 }
 EXPORT_SYMBOL_GPL(console_verbose);
 
-- 
2.39.3


