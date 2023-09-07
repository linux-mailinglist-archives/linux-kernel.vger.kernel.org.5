Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B454796DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 02:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243675AbjIGATP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 20:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIGATO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 20:19:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2E61997
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 17:19:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386NsvCw026021;
        Thu, 7 Sep 2023 00:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=MnqenOkSvyw/vpEw+NHFp5l4qDxY2dxnx+cqFPxg7eo=;
 b=XdZbxNxtkVWXeTYf1QmDykjyyaVHkz1M+azpDku3QxHE5j9MvInZbN9wAdL5EJ9EnWFi
 Rx1/BnXhCVOxdRBORrIN7S2ntCC/RUhvh5foikCF1+o2wMWsDcxvFBZVYG+BuABJdkd3
 ZYW8RFDukXDF+7nmQihlQ47WtRT3P8V2G11Vq+zxVp8KuWVAnXXu7BD3VMFqiBZyn7zI
 1aK1/xeRxHhXeAam9ocg/M8MAjvrJjmuqtGhTduS32lfDL/5FSr0VWXEN+km9ahsZlG3
 2vjJacKJqQPtLoP8ARvzPWa8uSeshEJdFVJKIqbuQ3o03MGo5DmZ+yIwA0YxsJUBXY+w Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sy3gqr0p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 00:18:39 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386NFWuP010410;
        Thu, 7 Sep 2023 00:18:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugd83k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 00:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBpJUFABmcTG8Mrf87wmBE5uXOiAnJZNAWTM6cLeQ30Y04NCm2AEYL0J2m8UyLuCfoLxd8//PNdAfUdxCZn70RC5uSWoPVbfgRPeQnigph2ejyJ2UOtjsotDRTX6iX2SFJz1uOrf8Svcq+gZXNAAS9k64jucQWh0RoH1mh5CkAIFVYN1c54UwuwxET6sgvzBdD20BH1wWHhTPYb078mS4ltdGIKHeOYs12i59DvG7YBlVVvp1N08Tqi/L0dJSYGu9KKCFk1O1wcUnxk6wHP626hxckyUJvaCEeaN81gmIQkYNmZvimcoELiJJ9SsjIvS5HD/Rbkuav3AJGZwbdlElQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnqenOkSvyw/vpEw+NHFp5l4qDxY2dxnx+cqFPxg7eo=;
 b=in74W5ee9KduuwiYdOzSFzy9AvNa+cR+ue1yRqiNnBIpz6FN3rGCuyMe0Nipe9f4gU0xJsQmBUQKqs7l2cGTyESggt0XJyaKZzZNR24s3p06P/8VD29yAynRSDzZ9ewMitkfy2HgPuLw6oD8KdAPywAom6Q4OxYkvbL4+E4eGYFfvksnp2QftqAqShne65xQ4oFUE3KyEEXuzGa7SoKvbC5tUGjJ6L9mCdJ4EQeCg4/Da3G2XEnk4OWWSdUoXelca6LZ2vqOT629+cMisPl4/T5FYShnWLVDJ/RcvK1TTHs91dgiRkDGFhziGJv2EiHplq96mKmZ/DBN17PcPzFYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnqenOkSvyw/vpEw+NHFp5l4qDxY2dxnx+cqFPxg7eo=;
 b=HM6KgBsDBfRl7kNQ8UJPULKz2YqdIxtACQr2Lf7gXCJ0mO6CcMx+7c7JSOuBfbdpXvtv+Gkzzx3vVKGg3bLWG/d2GJIDaS3nzgWH6OXHT52sOtQpcL9nUD+jaXzXD/rYXJ/wSaWd8FOS2D6EvIuBmjSpfjWpaYUzJ1pZnD4QQ5o=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MN2PR10MB4399.namprd10.prod.outlook.com (2603:10b6:208:1d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Thu, 7 Sep
 2023 00:18:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 00:18:35 +0000
Date:   Wed, 6 Sep 2023 17:18:32 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Message-ID: <20230907001832.GA63356@monkey>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
 <20230821183351.GA3377@monkey>
 <c2519e75-2354-9dc0-d771-c7ad2bbcf80d@oracle.com>
Content-Type: multipart/mixed; boundary="y269FpMnW8RXr6Z7"
Content-Disposition: inline
In-Reply-To: <c2519e75-2354-9dc0-d771-c7ad2bbcf80d@oracle.com>
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MN2PR10MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: cdda4cf3-31a8-491f-5749-08dbaf37fa00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hV+d9ENRL+5JAt1hyRZcSXTX5YhEvdmjaR66bh0KKlUQ4AXs52SyHx1sm5Anzqg5D+T4WtNmMjyENOSL8CDSTGSJZJVolhPf48I4V1hvteoG3+OSQcbfd2D6pCNSw375+fHaqaqtRqEQ5m4VHd1fkr9q7fBBKaErs+QYUgSPncDHNEI/YuyIEKLPGwNZV7h3RgDU8AkLNaItPrISm0KO1UuvJTDQkJu3xMSBu+OEyJv8HQmnCcgV8KOVhV4AmCcHv5esfoc+sYIDHSxXg376eO2oBQFlNTwAil6J4JnNNUS1KFa7d0/mlANo32nEtaMAz+I2lVWhp+6cO7tVs0nlAlP63R8VdFIkmXmywyF/2cMVNDtCuDoTbuy2NEBC//6c67JvRHsNTp+F1olF2FIfAHbWvY6laWafw6t+1WCqH6DTrvHMDRCoFwYb6e9zeJEv1nsrdMrTbstNoMcDySdoCB9vJ8b22TpTWkdujPL6WKGt5KNKDBn7mnWlO+ST2RNcsLHZiMbIkq2XtuJSV42JChoboWUkSUcbeSmIZb2gyF8FOBiUEbnHQIpILxf02B9Cjr1wVm5sod/OCW3J+n27lcc4AUgwtjeDsJ46HonWw1Xrj7HjB6Isoc7HSfpljZt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(33716001)(6666004)(53546011)(44144004)(6486002)(1076003)(26005)(6506007)(9686003)(6512007)(38100700002)(6636002)(66946007)(66556008)(41300700001)(66476007)(478600001)(83380400001)(316002)(2906002)(86362001)(235185007)(4326008)(44832011)(8936002)(5660300002)(8676002)(33656002)(6862004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DOaaEggjDig6VBlZ6sVuzpyw7ItZaeWzuV0sNw0Xq5HQOxg2NkFw5hw3WUKk?=
 =?us-ascii?Q?EodZWQpbtG/5Ozfd6VUvAQkvBdCMNjCfGsW3e20uDd/1udlv554XlDXngM9f?=
 =?us-ascii?Q?5HulGGqNUk+YUfHgBk6NxeDmfY8doNnpl1nVXG3p0zY/xkNAMF39QSU2l/BI?=
 =?us-ascii?Q?vQl27bNwinntq/vwRuB9o1ofTjC3ZWhqOwkvfWplPHE2b2rWoyp0I9WYNsPo?=
 =?us-ascii?Q?FJbARkSy1wCG1t7jGrrzwVhZByn6o8VQ1ULqZUKk8/NyPTkuqvV1hJcyqUI5?=
 =?us-ascii?Q?eCi/bQ8EKme3f0hOCXVXyVjqipo142PT24nusyqD9neRPk93WMHSB8gfKxXo?=
 =?us-ascii?Q?DJGMEWOgyIK/uAiVprs5ZsHdTMwx13IB0T8WhoorvBYUG/BVsYyAqQT/iiCH?=
 =?us-ascii?Q?n9VCu/JrDU/LSFP7OWYVQyG2kqFpdgSdm8EGbmFA9NjiJYiUDgKITdV4KxAi?=
 =?us-ascii?Q?lij1fU4TRHncXJJaANQ/pXKfRvcOnjrCrRlxejRkjyWedF1n+Pvz4/FZ8eT9?=
 =?us-ascii?Q?LRYrHYkBANOWNlAtawnUOrHzrseigqvL/pChWSh8+45F+124nOdRUZbiROEZ?=
 =?us-ascii?Q?28hX0wwARBuFDBXZinqpEKaUhbMDTZddJV9YgMcYCUzL42f2rTGuS+uPhfDN?=
 =?us-ascii?Q?ZFaSt/LpWTg39wDWRMIKR8I8o9cNe+z/eAdSLPTCY6YsN2J/XYzm7tW6dqaD?=
 =?us-ascii?Q?rkOShLcflGlpi2I5FYNBWcL+g1H0TtBfWdHERMiN7lLx1ldsa+6EqW57Fvu5?=
 =?us-ascii?Q?mgYQLWyeKabU12CX8tgSblKnO2z4UfMmAlIzD/RTvKuokNa0oBCxInW6VJ7h?=
 =?us-ascii?Q?Tf/3cQbPjorjXuRf1qDcQy7iPiCS0swiVm2l9yhoLpp96tvBL5z/Kv7nIzpY?=
 =?us-ascii?Q?Mh1SBA0CBUJHLyRkx9Lbt4LIpqIgDw7egEQsYxoYzuuCcxCxKviWqZ7OWKtW?=
 =?us-ascii?Q?jFhxhN9efiwTIL/nI2vwW/ohMaf0Ms2gx/avXsJPMG4jFs8leXwCiTE4rhlP?=
 =?us-ascii?Q?nECEFjexDxcaTKoBK7KIsNo+lHEQdKQ4GC8BJI1pu7MJhsDc+dKV6KPLlXB1?=
 =?us-ascii?Q?CKpZ+G0S29lrOVVwCFJHiZO1hxUMDCuKFwIzPNKx0t4laAakbfUen+WWJOPT?=
 =?us-ascii?Q?IXWU4A6bDEw3zmpaFxnCThPF2YCUXM/uQrEMBTSt73VvtSBecStBrfkHkpgB?=
 =?us-ascii?Q?fDrgQXdeL4OlO4hQ1NcqoMIC3zY59Ws/k7ft9/TV0GuAPW9nPJVkmqiyi1yp?=
 =?us-ascii?Q?IEN+bo3SZufiL13LJX+o+KSeL8Xh+Kndue9srrGZ00L5uGg2Ln+SWJTnlci7?=
 =?us-ascii?Q?iULeXSE84p6OEa1b0UHSyN704D8USe9Z9WLvx/6HWwtsEp2YuWdrWy/hBQk7?=
 =?us-ascii?Q?UK9+J4E6EwzJV8P4aEkYO7Pf5lHmFq9A0Q6a8hvp5mewmHlGY6IkmQD3irCC?=
 =?us-ascii?Q?671AOquO6gVT/VuMmz/TMw5kg8mPQl58iQ9/QLQzpao2GWj6O9Ms+0Tn2RT9?=
 =?us-ascii?Q?AkCSXLnMefZmV98K7yZt3EEFz+htuQ6JvSyk03bpZBgp6KDaj5FmkCUB2U7Z?=
 =?us-ascii?Q?L8sxnJRpXVceDOjjUPmCRI7nAULG5Ja6bKYjjiGa/nDa7ZGuRNvWoFYOuLQW?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qSyySz2lo53pvS+ZYXnv+ydwsESJC7ERIS8KmIb/0NBrUuN7ee+rYGcXXMaRKWFmGB0q/nXr/n8sSjqF0gCsYtDiGwHMVcpTNE49iXzgRXWuurfmcQVJQdWTm3U8Cf4KXJs2xcMlM72Sj4SK67YeyK4XqxNDf6otKVBhxpsE38m8MSW46iV/CG7BcYxk/obeNG0oaEog0ijyMKwvf7w5K9kTbz6DP1xtY+rDRSf8nSlD1mnRpyGlUJdtBkwFLGfFBWt2mIj8LYgUwvzF+r4B0LrZyUUgxRCQupjn3GbzSlTB3XVcU8iKRDSpFvCply0sJH4PCaaQtpPltrtF4xbdgBCLYEaqt+sacxRL4ZmzeCerzVTu+7nh2Va/btuoHCbai+YyqdWDxyrciTbWOV3VYfBVaTgnjM906MNQ2RDdyAwKGOQD3ArsKnlGpzsbpumM0a0TrKw9kUqFNGG081lNUpDL9W5kFrQcB/4/LAtWiiRaKQxJTpeJbKL+4hnxMzi4aVtxz0kBC00i90klWRLHDyHXK6n90VVBQWYwlPCjs4+Iz5Q4yua8ff55yi11K20m1Qs3BiaRYMrws9i2ivJJsyyaAv/6gglc61uzsILyKRiU8hf8pIMG6lZVru8+v6tNGjLcm4//0PbMdzUHcA0pVKoO2pzDAyYviXwmKPKgRDxz9ImvnIRgfdF5Mj8xaitr+BnCTi5pOFtqbDL1wk7jXwEQ5awDsjUlzK3Ju4fTK+CwyhvrLh2QwTpeSGNva4iOOKjZ2SJTsU14zM2rLlAytRKIfFxzvhyYkd+TvBU3Y0njPv9Riw7LEhTPa0YjCqYgpEn/jzSR02jfy3qJq37Lls89CnD67Bn8M9UtOsIawkMjsLU4glLB/8KG/w85wxhctKLgtoibihp5bOB+DXqr6dl+4b6ISfslt6l1j4bXmAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdda4cf3-31a8-491f-5749-08dbaf37fa00
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 00:18:35.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UflheTKWcQqkLGkzRTiI+s2zASkqjV/V6Tn9V+uGHvxKNH83DkRihjWdtTCQAeG8R6bH6WMtzZS/4wz8QsNPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=725 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070000
X-Proofpoint-ORIG-GUID: 74OY6q-pwaDdbqAqglOft8fRbYF2JGoW
X-Proofpoint-GUID: 74OY6q-pwaDdbqAqglOft8fRbYF2JGoW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--y269FpMnW8RXr6Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 09/04/23 21:05, Sidhartha Kumar wrote:
> On 8/21/23 11:33 AM, Mike Kravetz wrote:
> > On 08/17/23 11:18, Sidhartha Kumar wrote:
> > > Remove special cased hugetlb handling code within the page cache by
> > > changing the granularity of each index to the base page size rather than
> > > the huge page size. Adds new wrappers for hugetlb code to to interact with the
> > > page cache which convert to a linear index.
> > <snip>
> > > @@ -237,7 +234,7 @@ void filemap_free_folio(struct address_space *mapping, struct folio *folio)
> > >   	if (free_folio)
> > >   		free_folio(folio);
> > > -	if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> > > +	if (folio_test_large(folio))
> > >   		refs = folio_nr_pages(folio);
> > >   	folio_put_refs(folio, refs);
> > >   }
> > > @@ -858,14 +855,15 @@ noinline int __filemap_add_folio(struct address_space *mapping,
> > >   	if (!huge) {
> > >   		int error = mem_cgroup_charge(folio, NULL, gfp);
> > > -		VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
> > >   		if (error)
> > >   			return error;
> > >   		charged = true;
> > > -		xas_set_order(&xas, index, folio_order(folio));
> > > -		nr = folio_nr_pages(folio);
> > >   	}
> > 
> > When a hugetlb page is added to the page cache, the ref count will now
> > be increased by folio_nr_pages.  So, the ref count for a 2MB hugetlb page
> > on x86 will be increased by 512.
> > 
> > We will need a corresponding change to migrate_huge_page_move_mapping().
> > For migration, the ref count is checked as follows:
> > 
> > 	xas_lock_irq(&xas);
> > 	expected_count = 2 + folio_has_private(src);
> Hi Mike,
> 
> Thanks for catching this. Changing this line to:
> +	expected_count = folio_expected_refs(mapping, src);
> seems to fix migration from my testing. My test was inserting a sleep() in
> the hugepage-mmap.c selftest and running the migratepages command.
> 
> With this version of the patch:
> migrate_pages(44906, 65, [0x0000000000000001], [0x0000000000000002]) = 75
> which means 75 pages did not migrate and after the change to
> folio_expected_refs():
> migrate_pages(7344, 65, [0x0000000000000001], [0x0000000000000002]) = 0
> 
> Does that change look correct to you?

I just ran the simple attached test program (don't laugh) on the suggested
change.  Command line './move-pages 2 /var/opt/oracle/hugepool/foo'.
Unfortunately, migration is not working as expected.  The source pages of
the migration are not freed.

I have not taken a closer look at the code to get an idea about root cause.
Certainly, it has to do with the ref counts.  I can look closer in a day or
two if you have not resolved the issue.
-- 
Mike Kravetz

--y269FpMnW8RXr6Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="move-pages.c"

/*
 * hugepage-mmap:
 *
 * Example of using huge page memory in a user application using the mmap
 * system call.  Before running this application, make sure that the
 * administrator has mounted the hugetlbfs filesystem (on some directory
 * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
 * example, the app is requesting memory of size 256MB that is backed by
 * huge pages.
 *
 * For the ia64 architecture, the Linux kernel reserves Region number 4 for
 * huge pages.  That means that if one requires a fixed address, a huge page
 * aligned address starting with 0x800000... will be required.  If a fixed
 * address is not required, the kernel will select an address in the proper
 * range.
 * Other architectures, such as ppc64, i386 or x86_64 are not so constrained.
 */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#define __USE_GNU
#include <fcntl.h>
#include <errno.h>
#include <sys/types.h>
#include <time.h>
#include <numa.h>
#include <numaif.h>

#define USAGE "USAGE: %s num_hpages hugepagefile_name"
#define H_PAGESIZE (2 * 1024 * 1024)
#define B_PAGESIZE (4096)

#define ITERATIONS 100000

#define PROTECTION (PROT_READ | PROT_WRITE)
#define ADDR (void *)(0x0UL)
#define FLAGS (MAP_SHARED)

int main(int argc, char ** argv)
{
	char *f_name;
	char *sep;
	char ch;
	int fd;
	long i;
	long long hpages, bpages;
	void *addr;
	char foo;
	long count = 0;
	void **pages;
	int *nodes;
	int *status;
	int flags;
	long m_ret;
	/*
	 * HARD CODED FOR TWO NODES: 0 and 1
	 */
	unsigned long node0_mask = 01L << 0;
	unsigned long node1_mask = 01L << 1;

	if (argc != 3) {
		printf(USAGE, argv[0]);
		exit (1);
	}

	hpages = strtol(argv[1], &sep, 0);
	if (errno || hpages < 0) {
		printf("Invalid number hpages (%s)\n", argv[1]);
		printf(USAGE, argv[0]);
		exit (1);
	}
	bpages = hpages * (H_PAGESIZE / B_PAGESIZE);

	f_name = argv[2];
	fd = open(f_name, O_CREAT | O_RDWR, 0755);
	if (fd < 0) {
		printf("Open of %s failed", argv[2]);
		exit(1);
	}

	addr = mmap(ADDR, hpages * H_PAGESIZE, PROTECTION, FLAGS, fd, 0);
	if (addr == MAP_FAILED) {
		perror("mmap");
		exit (1);
	}
	printf("%ld huge pages mapped at 0x%lx\n", hpages,
		( unsigned long)addr);
	printf("Faulting in all pages\n");
	for (i=0; i < hpages; i++)
		foo = *((char *)(addr + (i * H_PAGESIZE)));

	pages = malloc(bpages * sizeof(void *));
	nodes = malloc(bpages * sizeof(int));
	status = malloc(bpages * sizeof(int));
	if (!pages || !nodes || !status) {
		printf("error allocating memory for arrays\n");
		exit (1);
	}

while (1) {
	printf("Hit any key to move hugetlb pages to node 1\n");
	read(STDIN_FILENO, &ch, 1);

	for (i=0; i < hpages; i++) {
		pages[i] = addr + (i * H_PAGESIZE);
		// pages[i] = addr + (i * H_PAGESIZE) + B_PAGESIZE;
		nodes[i] = 1;
		status[i] = -1;
		flags = MPOL_MF_MOVE_ALL;
	}
	m_ret = numa_move_pages(0, hpages, pages, nodes, status, flags);
	if (m_ret) {
		perror("move_pages");
		if (m_ret > 0)
			printf("%ld pages not migrated\n", m_ret);
	} else {
		printf("Success!\n");
	}
	for (i=0; i < hpages; i++) {
		printf("\tstatus[%d] = %d\n", i, status[i]);
		status[i] = -1;
	}

	printf("Hit any key to move hugetlb pages to node 0\n");
	read(STDIN_FILENO, &ch, 1);
	for (i=0; i < hpages; i++) {
		pages[i] = addr + (i * H_PAGESIZE);
		// pages[i] = addr + (i * H_PAGESIZE) + B_PAGESIZE;
		nodes[i] = 0;
		status[i] = -1;
		flags = MPOL_MF_MOVE_ALL;
	}
	m_ret = numa_move_pages(0, hpages, pages, nodes, status, flags);
	if (m_ret) {
		perror("move_pages");
		if (m_ret > 0)
			printf("%ld pages not migrated\n", m_ret);
	} else {
		printf("Success!\n");
	}
	for (i=0; i < hpages; i++) {
		printf("\tstatus[%d] = %d\n", i, status[i]);
		status[i] = -1;
	}
}

	munmap(addr, hpages * H_PAGESIZE);
	close(fd);

	return 0;
}

--y269FpMnW8RXr6Z7--
