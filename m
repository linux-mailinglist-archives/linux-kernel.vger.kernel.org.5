Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFC47AB666
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjIVQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjIVQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:44:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69875A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:44:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MGNjh0002161;
        Fri, 22 Sep 2023 16:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=mhzUT0KN9fF+kbbaEmyTFHf+NNCmOk0tVA/71QgXRYA=;
 b=AI96eiHwGx5Eiw/lqJJ8rzvt1gHhtiQdX3lxVwkv0gV00LDbe+aqqwDmgaA0H40wuVs1
 BA+Qpt1lcQ719qlsr6h1OTWxQciSznCRLCFKIQOo8j2fY1xJLqj1dkhKdj5LFmOWSpPZ
 d3ln57QPiVmt8NvhwzRRkvCI7IiHZnVK3LcMKQOOd+D0e3OD03PJsmIpfgGeebTES1cd
 Mk8jCGlyhQs7HvYBo0dhEEgxwgQ4/D+0zg7oLjPQamVjJtn6yrX4esY5HEdM0ci8E0Od
 Y1+LaURMaGkJh4Wf5sIsDOY44514XviyxXvoIRSLk0H8hQZtnQqM4ej/XNCNU5wBqFMC bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tt029ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:44:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MFScNg010751;
        Fri, 22 Sep 2023 16:44:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u1a9ywc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 16:44:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAAE8BWBJmmTllCsIrMB27ErkQKErdGsm7dM6CNKZHGLHYxsX6sUOcCe3mgpIQWpOAngKhcDbziuuK1Ye5lhmPICcxjzwBSQlKn7FTrH/jBQe48babYWmtw15zFZ9hlI4GNnztWoiU7CgvYMd5CrLIGZ8UKpiWpaw/erInbJode9ejLsR11l9BDuO6lnII+V6ggeoMpic0eW4BZQNWvqGN3+a1QNm/VioyXnnVcR1PTyLmjiIfk2ExY9wtOKH3iCh1EX6h7Vdo1C4BYRHs4wEQgE2dLRbzUeRy/Coau3+0XfkyU8mCAZpjKTzWmeBm9cLk9OgGqvRRekCSm7oqyPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUmlZ4kYRTuC5N+B2zpkmWthT78PfDhO6uPpu/aVWBc=;
 b=E4mlgxpOMEIwNrPKhkxiUZfSxRenXiyviIw4vYud5QnYWz/MrRLK/FQjNVDGFZh9DbCXMEbXp3SKr4jNXiZryDOUXcTxQPqGaJORRKrL3X6ZuP6k764MrQrwa8ezID1e0uO7XaVFGDaGnZhWVxzyQNPrAaHM7+6L+E4HW+VAWpLgXg5Oph6S+vWDsH1GDvGHOjoUg5cVE4VE7GLOhDtLULqHfJNYxeYpV1KcqbGMpkqJh1lWifHcfLP5x63GT8WicjSgoKIpVTrVYiRTW9cXMjw9eQyO+VoxFMCNVhAd0k49LwpKDqrQilzTs9a5NC5cVU4FF5DGrth5menShZDI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUmlZ4kYRTuC5N+B2zpkmWthT78PfDhO6uPpu/aVWBc=;
 b=rOSrvKw3h+Up1z22XwxMNUHHvx0lYbIwMIh6OhdBhzeQDMvfoPhw7UdxspMN+bL5hFCkpvg7NX2mHbJ4plgmUgeszHtXxfD3Itr4EZVFCZA5BeV5CdKd2Er4eP4aPwvpN6o+ElmQTPweOFjvuQLsrkIAjRG/KqAiOu9iMtodE0Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 16:44:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 16:44:11 +0000
Date:   Fri, 22 Sep 2023 09:44:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
Message-ID: <20230922164408.GA224968@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
 <20230920021811.3095089-2-riel@surriel.com>
 <20230921224201.GB21193@monkey>
 <c3309a3486df6ad2901d4d5c23e7bc6f4b8a9a24.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3309a3486df6ad2901d4d5c23e7bc6f4b8a9a24.camel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0290.namprd04.prod.outlook.com
 (2603:10b6:303:89::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: eb064df0-8cc2-42f4-74d4-08dbbb8b25f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czGavDO9y8VqAy13i0yj0fy2Qe1OtxQj4JZ2bQdpdOeOlVlFraPO5Wh6JPkfsQysLUo3Wq4tS6c0OKiwu/qF3otBUG7G4BAZ7TpK6OvIA4VUMKNUAht7IQfIrMXCrxskO5Jls9DqmwOjiGuxYrrocxmcWeNIERwV4+40MviB4Or31piVHndI9ZUKxAg+LqJxNTjgs2WOUbTwkUgSypNphI+RckZl18xpYUGx6bYnan9Si9dO8mIwgBpgwjU844FNVzAuH4uVV9trQV0V6Tm0hMlsbbr7Rr/wQu+YYr4Fdn93X5uNrYb5/rtf4WHzGPh34f5SXrcpY5mFwNFeQgYeOAoeReeK9dtCBt43NBgxe93MEp6EVRXmtZ8sbLtRGEDCnrJM1/mvagjEcfeAw018emZNlxgik7BVmTwYJCL6G/oewul3kN2D1oKHxF307s68nijYZOtCu0n+hvdBMsqqiiW0eWDta/yIozs1g2p2dkv1n1yWZWJSvR5OfF/Xwf/z4WXQMoPYiSRxP1V5LrurIh1P4W07f2X2l1RwUQG7FMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(38100700002)(316002)(44832011)(83380400001)(33656002)(41300700001)(4326008)(8676002)(966005)(6486002)(5660300002)(478600001)(66556008)(66476007)(8936002)(2906002)(66946007)(6916009)(86362001)(6666004)(6506007)(53546011)(1076003)(26005)(33716001)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?xhwv6TFCZPvKmT/IQsGesMHdUkYQsIVCPQze221DfWIOhIOjZh5U4bEB9S?=
 =?iso-8859-1?Q?fNRbVX/dkg9ilbUatKYN8+MLQWs8/grsl4o+dTrOiYj056TMod5CGpWVT4?=
 =?iso-8859-1?Q?VcVMWuGovJgKccbFpokRM6vQ4cg7a/ZU7ECT9sd1GE0DOSI93Vd21c1RcF?=
 =?iso-8859-1?Q?MdvkA/KN5F8wsY/vAGqe/hWPYulAF5dlFNa9ZBEXFACZXYmUI+EY+vKTMT?=
 =?iso-8859-1?Q?Q+LwmwKbmRzLLCRKhmgv1zGm5c//zeTL2u+j1m4oAmOLxJY8AJhVq7Cqi4?=
 =?iso-8859-1?Q?HepVw0UZJ1YDCv7M38fTtpzE4SuyANwk0v4gLQ+NDCwM1XoHr6GsEQzS/k?=
 =?iso-8859-1?Q?hd57nyDjLd1b0E+PwbHOey2DBGW344m7qFCr0NmwM852iv9KQ5sypAW7Zc?=
 =?iso-8859-1?Q?Mf2tvOZlqHZipXHLmyT09fw2qYTNOK4/Y11cme7ppAJacBzQsEI0VHIdSB?=
 =?iso-8859-1?Q?L5Vdx+7RASVTTaITqACrj5PjphWZEpCBvwSzsf1mnSrUwo2my+WecFrEqm?=
 =?iso-8859-1?Q?9DLPE6Oh420SsxV5/B6CoksdwAt1di7MPbmjxehZQjMKtY6bBLHbZxIIq/?=
 =?iso-8859-1?Q?Qb5ZqrrUAkmQ+RBj+T5rc0QA3M4Z2sAWHwwOx3SqR84tGIb7+qHLLYcQRc?=
 =?iso-8859-1?Q?ypeokIbbvBr56h4l7LbaPMV6V6Uebq/1QEpq2QodG927YvzrWyqwhupVG/?=
 =?iso-8859-1?Q?MPkf/gUboOS8KCuPGSyjN1ucyJnNgYAFKhoSB0FlBTWn1ndV2Jy+YoPShh?=
 =?iso-8859-1?Q?1JlNV2pEbOrSRSSYZ59+V2sG7H+xCFG8b4H4Y/Oyhk/K24sSzBIULVUH12?=
 =?iso-8859-1?Q?dmLGE/ayafagHLYuSYf9TPaWN/veyQWPe3WK2GNe0ZMwMdgj3WfBqCsaNv?=
 =?iso-8859-1?Q?BpUZLr+uAYPpohferjnfgCbn/TvjJl3N11bSS5x9+jWdQWjKjdgEZkmtci?=
 =?iso-8859-1?Q?fiIf4XfRWWyrHdAUd2znIo9Ksxw/KArcU5nBezge+6srOUYYXoPBL96tOG?=
 =?iso-8859-1?Q?9PPWFF9zwcsQh47iQmGkeZF7tMIyxGLWAtgGa67C/FRvHmqbdv/DsgQinp?=
 =?iso-8859-1?Q?H57HCW6LprNXHmtFaxINPoJxqsxGk2TUKP9HbC2EDXfprohmLZ+t3BYW1g?=
 =?iso-8859-1?Q?bPvgpYt5HTKNbrbhpOjlFUyQ/LrXj9BEKOyfLBqbqcM/PZJvpEuuEVble9?=
 =?iso-8859-1?Q?Raxf6txXmX80j7JahbcRtu0onRuxZ7k1mfHrme69TManRs4v2qDM4RYxq6?=
 =?iso-8859-1?Q?LI7zdiH2INwv4a9GiKTUIBn6hOjI+WOVqkpz7BVI710uwiQbycEZpp9O1Q?=
 =?iso-8859-1?Q?QBCwqnoV0jiIai622ed71xF29/AKQ8ArlLHeJLy6tTE20xjW0/fSxZFk6R?=
 =?iso-8859-1?Q?Sfiu4g+Ti06YVB1CnAAqLYk6f7k5nxoGQ0XYXsAAFEMUqfRF3PtVOY/tJq?=
 =?iso-8859-1?Q?qRSLDxUQG6IfmXOzWmualrjWbZGSUa7BChRobmv0FeGODSuDDMGnJp8ayS?=
 =?iso-8859-1?Q?bfZby2qbb9wrvPPW/CyxO59O7w6Bqzsw6tSXVYyEH4E0kVQvDkDLY98F0I?=
 =?iso-8859-1?Q?gnkleIpd7fw2+YpMk+itl4OM/OghMpnKNUYBIlprd8c6kOBF+D/Uw6vvtY?=
 =?iso-8859-1?Q?Uk0RNGS8IqbkuYOyG40leCknx4efNK1y2+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MoZXDiUzMDGTwI2Qta82GGcCGkyrNvSp6EGnl3tbNH0klcRC9e0+DVa4b31Ve9bkRSBr9ODRY/x0dZgGVhUwfLtnzJhpEydwBzsjdNf1IWuvGo/AA7Q1Iro2Y9+l1PTSkULnave9LKUUnGduYWWgx0bwimi6JadBVrVuIwg3npNJZyNORCd7bD9ZrCc+r54+JzMh/sxrUoyMd9COJtLDlZrI2zl/a06vXijd9+EBk3WIFrFh/hyZ7tccUTUbtj4DXwQPfiMDsPIUpTFZUyQBFpeKx2SIxsyKo/q5ZzWrAHKfLLRScZ7VhgsUPzJWpPcRf6GbL4ioNiHM2VvYqM42D96BOCPalEAxE9bK2WTAYaTa2QpqAajtl8FiXx2pbDIgkhwQDGQG+/waq0dydralI0iTI5UPbkjtMZTFe2cscn4osOBFvzpaNStf1hYu6JzMhLCez/bKkO5MujUIfUXD4LGJBqNlHPiFUrUp6IonJl7pM6iFgqpPi1wJMDd/5RpSUS08v0GbxA6xw4IGb1C3v/SnAM80i5F0JBjFFX9EnUwU/b6KUxogYq7rmA9FifWFZrsvgbSwB1pGTRejG++DwhCrRFoHNzeuS56pN2MuNybBtc/jYt7F60yMmjwgmFBjnxDZNRmxgUoEJpYfbcllhc5owWN31+Ok+e3pAaQ6R/iaqT6hzh06xABFJJRvcfq//iRM3uTdqhJp5DuZglKBuQDI+e+TTQMB+JDJpdfURwVKYkrrolVIcFj0ds2x4Hox+9OfJ1YhPCSezOG8FoIGf12k76SAFxmZoBJl+j5+IZz4GOg1Wj1X8lbxoXRNNK7vhhOdq4VeurfNVswCfSGlVWm7fTkFD2KezKjyvKG8pbMH0v/mHftUwcUu7l/Ko+Vh+Vqd9m9eddreKt19ar70WfOYrmFe0Xwe63i1tBVBr84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb064df0-8cc2-42f4-74d4-08dbbb8b25f6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 16:44:11.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqBnY9R4kibX7Q3AeQh4+Wyy4RXdMIzWtsd7CBlJgWUUO/J9x934igRsJLpoKMYdQGUY2QwBLOQ+6lrzBtcj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_15,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220144
X-Proofpoint-GUID: hdug_rOdSBwTvQU1HXu-EvV-n5TLPY7c
X-Proofpoint-ORIG-GUID: hdug_rOdSBwTvQU1HXu-EvV-n5TLPY7c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/23 10:37, Rik van Riel wrote:
> On Thu, 2023-09-21 at 15:42 -0700, Mike Kravetz wrote:
> > On 09/19/23 22:16, riel@surriel.com wrote:
> > > From: Rik van Riel <riel@surriel.com>
> > > 
> > > Extend the locking scheme used to protect shared hugetlb mappings
> > > from truncate vs page fault races, in order to protect private
> > > hugetlb mappings (with resv_map) against MADV_DONTNEED.
> > > 
> > > Add a read-write semaphore to the resv_map data structure, and
> > > use that from the hugetlb_vma_(un)lock_* functions, in preparation
> > > for closing the race between MADV_DONTNEED and page faults.
> > > 
> > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > ---
> > >  include/linux/hugetlb.h |  6 ++++++
> > >  mm/hugetlb.c            | 36 ++++++++++++++++++++++++++++++++----
> > >  2 files changed, 38 insertions(+), 4 deletions(-)
> > 
> > This looks straight forward.
> > 
> > However, I ran just this patch through libhugetlbfs test suite and it
> > hung on
> > misaligned_offset (2M: 32).
> > https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/misaligned_offset.c
> 
> 
> Speaking of "looks straightforward", how do I compile the
> libhugetlbfs code?
> 
> The __morecore variable, which is pointed at either the
> THP or hugetlbfs morecore function, does not seem to be
> defined anywhere in the sources.
> 
> Do I need to run some magic script (didn't find it) to
> get a special header file set up before I can build
> libhugetlbfs?

libhugetlbfs is a mess!  Distros have dropped it.  However, I still find
the test cases useful.  I have a special VM with an old glibc just for
running the tests.

Sorry, can't give instructions for using tests on a recent glibc.

But, back to this patch ...
With the hints from the locking debug code, it came to me on my walk this
morning.  We need to also have __hugetlb_vma_unlock_write_free() work
for private vmas as called from __unmap_hugepage_range_final.  This
additional change (or something like it) is required in this patch.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f906c5fa4d09..8f3d5895fffc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -372,6 +372,11 @@ static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
 		__hugetlb_vma_unlock_write_put(vma_lock);
+	} else if (__vma_private_lock(vma)) {
+		struct resv_map *resv_map = vma_resv_map(vma);
+
+		/* no free for anon vmas, but still need to unlock */
+		up_write(&resv_map->rw_sema);
 	}
 }
 

-- 
Mike Kravetz
