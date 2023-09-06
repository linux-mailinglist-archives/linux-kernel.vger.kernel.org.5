Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FD3794206
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjIFRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjIFRaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:30:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D2B199B;
        Wed,  6 Sep 2023 10:30:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386HJtR0007294;
        Wed, 6 Sep 2023 17:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4zZcLlTnpq3jmC76v5wS7r6v2pLY8fvrAcHOQ2EqfMY=;
 b=po5/IF6GFQutxRJN8tcYN86GtNi2cw4eJicLRnqy8+HZ4r11wO78x/W2W5Fcm+pRs3eg
 rbfZDsnELeAMsE0+zl5PfNlj3NFk3nJ4LrVUjBsSjYLrc03OsN7YGWhG/cESakeqZpeN
 ZZ4b1fa7ZQWQksNoUGVwaTExRivr2hCHLseUNzqGYufWkTQBd1BsfP3iGXbD2Uv8ZBOd
 +Bi8neszmvIcUMDowhkovSENYkZtZDYEpxMm+kBvZeptK0DcwaC3r3enk+k1KFiPDQDA
 ClpPCAXHgz4+DTTTLa8vPrHkC41/0zB+vbV8ObOk5Z7u3IjrzsXXL6VqZw44z0aeghGv 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxwqug0kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 17:30:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386GECg4010379;
        Wed, 6 Sep 2023 17:30:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugctuph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 17:30:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRfOIFXFhMJA1IPmWTtdwcQA0Sclwt9uVp880CHHyB8f2n2kFCVZwdqXrfnfGzlHBpZnSEvudbtFMpZcE6LijLF6mBxdW8t3MXsURbUKkvE6zpIOu0Kaa9DOAkVLfIxP9EnsR6gMrGH7FhSA+p7zOk4KGakgC/MA4xjJ/dV88QI0aoLO81jKvanSx/SjVRR/6tfl+B6Iqm9bTjZHK/xU41GxNqe6BEDw/kMf36C3c1e6Kl8B9cua9WLRM6WJlHx9kUoSY0ehF5A0gJeTThh0hmYilViPZBwQrReq2qmtNlAFX1bP1BRcAkckZ8oOfeOAZq/j1batLs3xWPMDGEzGQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zZcLlTnpq3jmC76v5wS7r6v2pLY8fvrAcHOQ2EqfMY=;
 b=mae74PiEwHGTUfYWoS2F4yxyyGe6OhYSf5d4jlYRcFt7EhsZB3CjXOlZgbEI77pPMFTByjzAvXdaD3rRH9GJCIwEs2wBSeYKYwPVUKYaff3SsjC0gD/yNg+exNKPbXaAhDoMKeDy2Cksr8cCB7XABCqizLrJcvbWO3ClkWxStzWAlQd1I5JEVoWJB0+GE/riiwbVolW5SHPOdled22K6XW9KblDJykxxz6/Zw39VzeMUPEtQ+YvByS28x8kOTlflHo4L3rpW/XtAtNh8CG6kEIZpoq685YaSZSw6oXI5CufOg/ldhK3MsdDKhrFGzOhqxb2i56D6lrEVGxAUe/D6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zZcLlTnpq3jmC76v5wS7r6v2pLY8fvrAcHOQ2EqfMY=;
 b=e8tXzcuKE6OVmNURZl/mrEqbB+GPtnMf99Xp19fHRwl2yYjTcUB99KYJ5KLaA2LxnHr2SY34BvrdIIg50VjByh9DbrVussizHj2bMszV3ffHZxHVDdRAwVab7oA11asq4AaOyphB8/LCt8b5wu6ZReY+5Ceo/vBlf47iFEIJkFc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 17:29:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 17:29:57 +0000
Date:   Wed, 6 Sep 2023 13:29:54 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230906172954.oq4vogeuco25zam7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: da7df531-e8d6-4193-85f9-08dbaefee3da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r+WW210FMYBcxl5LptJupL8RpMhvtyEboquvPafajWLcl+P+6N/WiGPDRk2q0T8kuV1a5TuCJ/vyUuvZuws9zTe/r2U72o0l4MJFaAst/CdpFHMB6L0R1cnVhwwhOxp4Np+ZXVxleEQnfH9rFa+JOAHbzxuSyrUu/l/ZI/c+M+bBtCaEMhLHY9CgTdk9uLb+nAEvsoNHz+FHBxSD0fEE4mjomfJrSVIKNBkY42tzjCfpP+5Ofv6I8rvO4g8VceuseQvO2x+gsyGTWKBa6JmoxfRJjLLdTZrDbdlVQlfauEYjohZe8xczPY0jgScyLMgeqmNI3XqJapxnIL9rWdoa5fvGTvj1/w5eBUDtxG9St3kbQgtZFKPEMfONw4qJ0svAU6eXlDNiEmrVMtezd2fmPvdKwGu2xyO0SEbuPeE+12gUoqpriLM/fq1K720lB8wQKHIaPX1I0gqBJ48xxmkoWb18FV1ovnfHx1geNPnH658HTrwiVX+bFcwmmIZyhb6cJuvk+r8p0Kd5PSK0KZLYuynvgbhB2H5bSId+BwFm4n9+/HvImzMhxYbmkmsGkfKB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(186009)(1800799009)(451199024)(38100700002)(1076003)(26005)(6486002)(6506007)(6512007)(9686003)(33716001)(83380400001)(86362001)(5660300002)(41300700001)(54906003)(6916009)(316002)(66556008)(66946007)(66476007)(8936002)(4326008)(8676002)(6666004)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cx6WQYv3S9nHZYEUZalkUBRtwjS8l13ZcrKe2Cjp2epbGnLmKz1Vbun074TK?=
 =?us-ascii?Q?/9Ad1i6ohZPy5xqZ5Z46bN9VJRI2ApMDDOG2nCnx14cWZ89v3NP26Ciw6zu5?=
 =?us-ascii?Q?POWfs1KAGY29ngOXPdXnkI3GFXv71d4yLb8abmMqICJo8+h8hT0kv7vZL/wa?=
 =?us-ascii?Q?6xoq6yh1yyp2VZm7Phqoozl2bZVybqFROKW7mnP1isJ2qHRpwPrzUx0iY4Hh?=
 =?us-ascii?Q?3/unmVabVXlr7H/AN2PdmF3RGaFf58ZnuQSxFgTJwO31Do8/Ig40VhYJwpUY?=
 =?us-ascii?Q?kqMGY7w728MyeakDiSmVLH/h0zE49M0aJIX98Y9+4IWeLmXbpG4tLIsi0e51?=
 =?us-ascii?Q?maY9D0DGjkO5Xzu3DDKDODWBWCGegTVBweGhwYxH0JxJwXc0GEEkc3Z8MjYo?=
 =?us-ascii?Q?ihgZ9gIqaP8HaVHCcKNkAuU0X59qu/lIweeL9xQIc2XETJS9PvUuWCZO/VHD?=
 =?us-ascii?Q?2UMQPa+gBrMSzypAJf5Yj60zNoEtBL2MFh5BBTKVTfnewKhW7Lztg7ouBTmf?=
 =?us-ascii?Q?HKqZ0GtCMj5Ohr4wQJcxK4J/oack6jl7drTOCbTcYzhjbC86bnQRUMWVpjG+?=
 =?us-ascii?Q?9z1SBFd2RbQQD5olw8KIsdsNYOH6eBcvIbptc+Ll0XYb/evsVpjFW7+gqQpV?=
 =?us-ascii?Q?DZoWLoYYtnOoDEe6JzsuCaXGcm+bQr8HDOj19wN3lPQns/N/Wh9MIQamC8Wo?=
 =?us-ascii?Q?Az3bqMWRMgT1cVCsMHvL/XzhB3GkusJRfu7Mhuye47HHVexBHyPd2wc0zVyB?=
 =?us-ascii?Q?S4ys2EPJ9vI4JrFLF3Jy7w3U8lnQw/PAKHeKfihkE1vUsv5BxSbSeNiypww0?=
 =?us-ascii?Q?pQN1Ajv6ucN6ObdP5sQn5MkzKPChaFH12C6T+1zVcD76vcxWQRaL1TJ9G9VI?=
 =?us-ascii?Q?6lV+QyejqC7xO4VaV3heU2i/T0zzIszJfZaicJXUlfIUfCbexMGeRt6SAbB+?=
 =?us-ascii?Q?i62ydMQ1mD8jjMvwR5cgqx/N41iiJrzTafYHF7oQ77o+l5MlYObMOPbc/Itx?=
 =?us-ascii?Q?lfnWfsEmo3AvCwn9F8BDy8HIWAK0d7oqfQ0Uqh4bmCofyL8se40KpQg6Dd9z?=
 =?us-ascii?Q?XjgPlxZJYbd/+UFeumXtn9tIm4BgUOHewHPROCReNuKXoQgYFy0emMnJFvfG?=
 =?us-ascii?Q?s9edeaRePt45nKZnzqm9cqpRVMm+Gn/aRACHURDp0rBt9fLDrFK//MBHKKz/?=
 =?us-ascii?Q?j2xuL/wX631Yfpnnhcel9PqMM0v91Q8b2fgApZtiLK34rwQmEVaXSG0j95EI?=
 =?us-ascii?Q?LA0yE0ZaMbT7vJeFX/ZQ+HyPjpRORANysmp2HjLQPBK8qRtwVrLU5fLbS0LC?=
 =?us-ascii?Q?j0Vt27MNVIk89iYgriqAhAjjFU4Guj343hakdWSIwuR+hf7evYwGavC1BMjb?=
 =?us-ascii?Q?TbsJ2OnDaCL+QfZ4RI1nTKuKRx4/s5WqpBpFTVJzkQxf6TtUYvX/wkMBIObv?=
 =?us-ascii?Q?tAfmd1X3aM+EW5UKew7r57nzsBJ+yt0PjpAsfiZ6lnN1dQ2dpn6WpJCUpO9l?=
 =?us-ascii?Q?GIdTXWw3YMePerXt1uXmD6dXI7JOzxd1wA6E6okeqwMnopjBlP/EKMT0IXbh?=
 =?us-ascii?Q?XHnLtoujTmYQD7kZIFaAwlmbP798U5MvjUyuQnP6eZQ3EuARKQXABiy5LOVH?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ccRunuPq+1TB27+fLWmK1hc76O5FzxWQbO6Zi7VGVTtg6tmF29LkXbIIDdBI?=
 =?us-ascii?Q?Jb0Oo+pNXPVnq4y5Z67zle9pa3dAmzMKOtbuCUMkxbVGeDQaUMTDk6DcBcGg?=
 =?us-ascii?Q?fJggPpxgyL0O4RxC8JrF6AezUcI92nLc8mmtmbJVx3QFzsaWvK42vRPE11+G?=
 =?us-ascii?Q?YzdJhS92A6USoVVHhEwY89g1y3KumTRbIEDH1hZqExMHeeI6VCqjtqBQTeu3?=
 =?us-ascii?Q?nXhhZHraKzgh4BT97wj8eoHiOZHrMuM0hkuSadxb1/nDbdvS0JxKdylA8tMk?=
 =?us-ascii?Q?SJznmg7URcYiEh4BbchCXOb1UoQbxAf5nxNpvO613JFrkNKU2Ua9zcq8CDX1?=
 =?us-ascii?Q?GNfhGrT88Od3PSY9xwuCvCUzKS0JhLfraMop7fXI8qr8cJKSXRNoA1osgZCf?=
 =?us-ascii?Q?EfscKXW1ipr475j+yuEoT+hfwgpkadwNiaRV0lpEe37t36xQGImTHJs+YJ9o?=
 =?us-ascii?Q?mEtyAch6H8cae7a0YuCLmzBs393ZINakHwlG7Db8MnXvLTsHIp+Z8rMD1hun?=
 =?us-ascii?Q?gWpmy0DAgq1Mr+9tCBaf7GErmt7ifiozZV/OZYSyOpplG81t51TEgOpysdAa?=
 =?us-ascii?Q?ndPFQN0F/gN1TmFfNJcIJH0EVZEbnn8cb5ERXbquEtHjqTtVaGZz2Bc4ybfZ?=
 =?us-ascii?Q?WzHQAfwSvBw60QzJkU6rdYokb+Qj31drRLhanbC5vFsc88iVI4qHkQFMFqSW?=
 =?us-ascii?Q?mMOGGsM3QjTm3Tguj+vaumxZlluJOzmMakq+VA4B+12cxURbQBGdYp1DMW6W?=
 =?us-ascii?Q?9e+wv0p+bdi9dCiCBTWgckZIfxIhgk0rYkUoUuDDLDwNQx2ywndvZcJiFUsX?=
 =?us-ascii?Q?uCs3wIUSzBhwDVjuYfNKUOkIdyqSM/Iet0I99mj9o7ydEdbaAtH/T50UH6rv?=
 =?us-ascii?Q?3pW9wGaLEbpy0rBx757Ad4CYiDvrbG5Zl3GMkhtEHsKxO0JKgb4Qh8LByfvg?=
 =?us-ascii?Q?qCvcdRByoSIMRDqny1mvmSmp8iyzKiZCSHKrsEcd2tI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7df531-e8d6-4193-85f9-08dbaefee3da
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 17:29:57.1856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8Y4W4Qg9S6ub745QUJ+4SLSzdYjKMyLOWEznrq0/3KtRJyxKwKqSrVTQVXZb3+8dO6vFcHCodoCW1VHJL3ipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=980 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060151
X-Proofpoint-ORIG-GUID: 598Gl4EJb_SpIEOkwG3ysMzWjqUEj8-x
X-Proofpoint-GUID: 598Gl4EJb_SpIEOkwG3ysMzWjqUEj8-x
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > (Adding Paul & Shanker to Cc list.. please see below for why)
> > 
> > Apologies on the late response, I was away and have been struggling to
> > get a working PPC32 test environment.
> > 
> > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > 	Hi Liam,
> > > 
> > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > The current implementation of append may cause duplicate data and/or
> > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > this has not been reported or seen, disable the append write operation
> > > > while the tree is in rcu mode out of an abundance of caution.
> > 
> > ...
> > > > 
> > > > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > 
> > > Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> > > ("maple_tree: disable mas_wr_append() when other readers are
> > > possible") in v6.5, and is being backported to stable.
> > > 
> > > On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> > > following warning:
> > > 
> > >      clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
> > >      sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
> > >      /soc/timer@e803b000: used for clocksource
> > >      /soc/timer@e803c000: used for clock events
> > >     +------------[ cut here ]------------
> > >     +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
> > >     +Interrupts were enabled early
> > 
> > Note that the maple tree is involved in tracking the interrupts, see
> > kernel/irq/irqdesc.c irq_insert_desc(), etc.
> > 
> > >     +CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rza2mevb-10197-g99b80d6b92b5 #237
> > 
> > I cannot find commit id 99b80d6b92b5.
> > 
> > >     +Hardware name: Generic R7S9210 (Flattened Device Tree)
> > >     + unwind_backtrace from show_stack+0x10/0x14
> > >     + show_stack from dump_stack_lvl+0x24/0x3c
> > >     + dump_stack_lvl from __warn+0x74/0xb8
> > >     + __warn from warn_slowpath_fmt+0x78/0xb0
> > >     + warn_slowpath_fmt from start_kernel+0x2f0/0x480
> > >     + start_kernel from 0x0
> > >     +---[ end trace 0000000000000000 ]---
> > >      Console: colour dummy device 80x30
> > >      printk: console [tty0] enabled
> > >      Calibrating delay loop (skipped) preset value.. 1056.00 BogoMIPS (lpj=5280000)
> > > 
> > > Reverting this commit fixes the issue.
> > 
> > I have set up testing with qemu for powerpc 32b, and reverting this
> > patch does not fix it for me.  Did you revert the patch or bisect to the
> > issue?
> > 
> > It also happens on 0e0e9bd5f7b9 (I ran git checkout cfeb6ae8bcb96ccf^ to
> > get the commit immediately before cfeb6ae8bcb96ccf).  My qemu command is
> > as follows:
> > 
> > qemu-system-ppc -L pc-bios -boot c -prom-env "boot-device=hd:,\yaboot"
> > -prom-env "boot-args=conf=hd:,\yaboot.conf" -M mac99,via=pmu -m 2048
> > -hda powerpc32.img -nographic -kernel <file>
> > 
> > 
> > > 
> > > RCU-related configs:
> > > 
> > >     $ grep RCU .config
> > >     # RCU Subsystem
> > >     CONFIG_TINY_RCU=y
> > >     # CONFIG_RCU_EXPERT is not set
> > >     CONFIG_TINY_SRCU=y
> > >     # end of RCU Subsystem
> > >     # RCU Debugging
> > >     # CONFIG_RCU_SCALE_TEST is not set
> > >     # CONFIG_RCU_TORTURE_TEST is not set
> > >     # CONFIG_RCU_REF_SCALE_TEST is not set
> > >     # CONFIG_RCU_TRACE is not set
> > >     # CONFIG_RCU_EQS_DEBUG is not set
> > >     # end of RCU Debugging
> > 
> > I used the configuration from debian 8 and ran 'make oldconfig' to build
> > my kernel.  I have attached the configuration.
> > 
> > > 
> > > CONFIG_MAPLE_RCU_DISABLED is not defined (and should BTW be renamed,
> > > as CONFIG_* is reserved for kernel configuration options).
> > 
> > Thanks, I'll add it to my list of work.
> > 
> > > 
> > > I do not see this issue on any other platform
> > > (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
> > > RCU configuration.
> > > 
> > > Do you have a clue?
> > 
> > It appears to be something to do with struct maple_tree sparse_irqs.  If
> > you drop the rcu flag from that maple tree, then my configuration boots
> > without the warning.
> > 
> > I *think* this is because we will reuse a lot more nodes.  And I *think*
> > the rcu flag is not needed, since there is a comment about reading the
> > tree being protected by the mutex sparse_irq_lock within the
> > kernel/irq/irqdesc.c file.  Shanker, can you comment on that?
> > 
> > I wonder if there is a limit to the number of RCU free events before
> > something is triggered to flush them out which could trigger IRQ
> > enabling? Paul, could this be the case?
> 
> Are you asking if call_rcu() will re-enable interrupts in the following
> use case?
> 
> 	local_irq_disable();
> 	call_rcu(&p->rh, my_cb_func);
> 	local_irq_enable();
> 
> If so, the answer is "no" (and yes, there might be a bug, but then again
> I just double-checked).  However, if interrupts are enabled across a
> call_rcu() invocation, it will do some additional work to encourage
> the grace period.  Even if interrupts are disabled across a call_rcu()
> invocation, it will still do either a raise_softirq() or a wakeup,
> depending on configuration, to encourage the grace period.  And in
> the case of call_rcu() from an interrupt handler, that raise_softirq()
> could result in the RCU_SOFTIRQ handler running upon return from that
> interrupt, and if there are a great many callbacks ready to invoke,
> this RCU_SOFTIRQ handler might take quite some time.  Plus that
> handler could itself be interrupted.
> 
> If long-running RCU_SOFTIRQ handlers are a problem, you can boot with
> rcutree.use_softirq=0, which puts that handler into a kthread, which
> in turn give the scheduler more control.  However, this will also turn
> a lightweight raise_softirq() into a rather heavier weight wakeup.
> Choose wisely!  ;-)
> 
> Or am I missing your point?
> 


This is very early in the boot sequence when interrupts have not been
enabled.  What we are seeing is a WARN_ON() that is triggered by
interrupts being enabled before they should be enabled.

I was wondering if, for example, I called call_rcu() a lot *before*
interrupts were enabled, that something could trigger that would either
enable interrupts or indicate the task needs rescheduling?

Specifically the rescheduling part is suspect.  I tracked down the call
to a mutex_lock() which calls cond_resched(), so could rcu be
'encouraging' the rcu window by a reschedule request?

Thanks,
Liam
