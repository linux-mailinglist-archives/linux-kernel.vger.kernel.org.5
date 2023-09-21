Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF67AA55B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjIUW4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjIUW4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E4132
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 15:55:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsMPN011445;
        Thu, 21 Sep 2023 22:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Akz8/uxZyJgxJDaMlio67BAurWK63nDDi0ad12BvSIU=;
 b=cjwgm2HThHnDzpnVATcyLi3tZjM4G0WJsGIByE8MGwvwIcz8VSkBRvkuPOBCBZ8xHkOI
 NVe15b51g0JRttZAgONQLvH7sI1fOD7GxJdLvSKkTIbKEFLOW9zF1/7SgfA5bVMAU2ma
 xcK6dQ6A/bNh0KH/L6Zv67P2SLVAEDa1DLFcXWEMgWPH6agfaR5y/UdWZ1KXJ9oX3UK7
 ulW8G6CIMud+UYWrrAZ0MZEfan3TRVKdVYrAL3ED2FZQoEaMHtPaVzBogVdyX0WpftOG
 i8wZPywtzTK7E1BPefp2B0u5x60RXx98LD50sqftqII6AqKUGWhN/pmFduBL9a23zkUV Qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvrfma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 22:54:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LKGR08001085;
        Thu, 21 Sep 2023 22:54:49 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u2n0pqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 22:54:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv4ZwPrpmVOkdyCxodlcZvGcFdvW+fWk5QXYhYoOBQFCUrZc/dXd7iDnjxnCBihhtO9Qjx5GIwo6EV7Yjj2zcNyv7qgogRwz4fp4N+R1zkvisa76j/Nv+/bvXhuN1iwb/O0X1IZ52DCoKoeFmjmgDt39Y4lUgnOysUb5cigHLXwlJmuGq3/bBMji2T+pnXB08f7rd99QAkj4FY/V3fzsc7FJf0QocV/FDDUBTITkffT9s8MF6tACZZgbgHIDH0meNr2HvmevFPB7aZe6tKaDS6Dq6FrswmTtz2g2d+dtxymOfkduCpZ0X5YnB7Sjmctcq7BZcwBSdB9v31Ap6CEGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akz8/uxZyJgxJDaMlio67BAurWK63nDDi0ad12BvSIU=;
 b=OUBhbpT+tife3SAg0+c8Hq7gEccV2N6znpqqSfMWIP53RuBRpjY8synXMHnzUZQ0PbefBS6TV/XrZ7tWOqdRXdqbXnYsSuVxf4NZ3+GLgOGgM7ZcfeyEruBSr2tcdZnU8tRhvRlpYbexZQsIyZ5aOp+NsycklJqZUbKh/XQaO9YmN3hTTb+CpH/Eqil8wqIE8MFYVXdDZz6IMq4CFiUDW3MiFkUqG2s/5R9+tpj4fycIAw/qY6AVCPgGixXKuQ59ASSnOzi+6UxW9SQ81NchTcsJ2oMlH1hKnoPRNqszYVrZlwgdSR/EM8n/xPP+FhHVgG6/zdrFAci0ujqnfFhcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akz8/uxZyJgxJDaMlio67BAurWK63nDDi0ad12BvSIU=;
 b=LzUoe/vKBzYxks9Gly/cQuGlYpazV2/Mt3R8mcreCUdmAZq7uf6gqBwb+XYnsKz2RZpWAYg6PFBtpYQxEJ6jigIlw6EKQo5IS1PTq5XORrALSF1TjQ/NE0vvUC9Knxlcz1z9Uo0uwOXRBA5L1mDXyLU7BgdZ/4DPLuxuccrzNZI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 22:54:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 22:54:46 +0000
Date:   Thu, 21 Sep 2023 15:54:43 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Subject: Re: [PATCH 0/2] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20230921225443.GC21193@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920021811.3095089-1-riel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4506:EE_
X-MS-Office365-Filtering-Correlation-Id: 2762671d-a94f-4e9a-50ca-08dbbaf5c0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UQwY9BtPAjx0TcTq0uYekxW5vcMPOIASO7X1AgC5dtLuJUr46vbXUm6lGqd4BeKs9/xKdxF1TocxLqy2unas+UgG+DwG34MYLYx6yCLhVOrugEydPV9+e/fbOrFSa1u3qU9qlUpu2f8kxBbavgnOBzYmOOzNVj5PGn2OtdpA1daCBYKTkBp/3NekmDI/RCtMp7ucD/8jUg6jeIcqbSvEJSbQAfEegVodGFld+OurhWTcP+4wJFxWTJ8pd4PJimCmZPG44DKeE6thzmN8kNLIfpXbF6hDjC2BEHEK0vNMkf301Xyu8mjEwIwGnLiphuz+5TQFQfsK3gWN4GWnRDZSWVHH68UbwIctAXoLdqgPnrhET4JMNvT2h3eqioRZmAGojcJvFjIGK9qv1elADJ4EW66RO/ogALocSMOK3XZ67i5tTLcafvQz4gANRIzaGKiR2rmcZAid1GlR85265haa2Npe5KhU2SzgVGqOsTrRKBjBA6YlBL92PugMpaK2TSqHmbssaFpda8SxEijoOBnFkPZTzqlkLFt4WXdxBS9kiIuqlzlMLGGzZKiH2aakEqK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(1800799009)(186009)(451199024)(83380400001)(6666004)(478600001)(44832011)(86362001)(1076003)(2906002)(9686003)(6512007)(26005)(53546011)(6486002)(316002)(6506007)(66476007)(33656002)(66556008)(6916009)(41300700001)(4326008)(8936002)(66946007)(5660300002)(38100700002)(33716001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u6vgYfw3Y+BiapElvZrY4k18myW7FciFeq6lK6eFDeWEnmwo/9LKjDHK/nRC?=
 =?us-ascii?Q?Ie7K8FdU22QsH1T3js/kOgRpCgUkx+kkTro5GE+Y5rhUlvIASOdHXmqFyNEh?=
 =?us-ascii?Q?WgJ9uDhKNUIh2Cw59gnGBEscrBNaTf8Y/+9kfKEjRQ9Au33R9JNMu8dfJ8j/?=
 =?us-ascii?Q?7dLRpER3rf1AVQaOZRfYOI8Kgurdcl67nxc18Ho4jop8fsBZtZTouYl/QSm/?=
 =?us-ascii?Q?leXenoTSkLhidm7En2Fhbd3hbnvpTE5iZbbF2lrQyT7+0R+Z9eDzcDV5ysu1?=
 =?us-ascii?Q?1ZjSW2I+SJdMJQuWyTwBpVh8kU3/HIPy+YXpdZwD4jtS9+Ct6HJAkBI9miF4?=
 =?us-ascii?Q?OsYGwB5igpbyrImaLYP4lwxPk7zY9Qx1YnUeprO1laOTURKZ9uVxQYjtizvI?=
 =?us-ascii?Q?HaQCSq7bZ2t6lpaDhrBM/lmuQiFEqhPJeXawuZZe4Ngffd9l7n6wOVbXMOfz?=
 =?us-ascii?Q?WJsH9UPetgwUcEi6djL/xA7NrCB+FVim/974JY0sBnWrZn2AWWE2/YiBBLma?=
 =?us-ascii?Q?VRv1ghFYBx03R+YAYyl9m+BF7oTx0Lvh5dyiPVqlUyBrzV3L9/7nNnYYyQJN?=
 =?us-ascii?Q?4yuIhY4Iugwm29ZkTdplX/dRrBQqyJCCv8QzM0yDb+VqYFfOJFzCkI80E4HF?=
 =?us-ascii?Q?ZuKZSiFFWFVwBVAckvlsJj88DvcoqlTmVV4ILjOAx/wnawxLTuXvyv78Op0D?=
 =?us-ascii?Q?fhp+g+UqqblMA9NU83RxY7g2ujTHH7l15ADIBIPjiYG4yIF0fKBjV16YLULN?=
 =?us-ascii?Q?4Nzw3HC1Rtqw6uI2dCJp2Es3RgIUFM02fiakVSI1EKr/nZnQFji2sfKMS0SH?=
 =?us-ascii?Q?rmNl68+LJ8NpIrkgBK+NqQVFw1Aw2T7pGHOMZCqxlEcEZn5qMMURXyY+3o0p?=
 =?us-ascii?Q?PyKSp0qs6sRSlYIZapLkb6aqBXskFKLIPTToLMzi6I+n+5hwWHaZZSgSWONu?=
 =?us-ascii?Q?Rqf6/FPy9vib8VQjhVtjS7mwyo+qmlfZ53B/S94OzjWgXPMa2jDt8IvYWPjf?=
 =?us-ascii?Q?NjpEIwbFBOgNAyztG21s68IDBTzCpUqi20Pv7wAm0g6tEk38PogzFK6vzA4g?=
 =?us-ascii?Q?YKlGfSJQ744gv1j/8MbEUGINX407LcfYVGLh1rSRKB/Q8+/dbBsoniSaKiS+?=
 =?us-ascii?Q?S10u+9lOLoG0+vMghLt4813OPhZ4w0IQP9tBuAVkFGByen2jNeaGBny82Vrh?=
 =?us-ascii?Q?EBvibDwvk+MSBzzUaZXX3RHMPaiiNYXNwJRfJm+RgVQIQsR0sZcYhEdVULa5?=
 =?us-ascii?Q?jG17r39DsdBzCW1eTxK5rr6FkPT+hhE4KZ+AsydrORQ0fLsCy4UpjS/rOQ3S?=
 =?us-ascii?Q?0yZZxrsGxCmYVm4YIu33Jw4dE7wkP59dwjnVHCvHvudQReinZ1h+6O/rtt4K?=
 =?us-ascii?Q?ytOMPOCbBNXvkIcgOvS5ZRrr0x+BfE2iXxnkT9l9fZ8GFib67ZDBAg8ztuIa?=
 =?us-ascii?Q?cT+9JKzsht8rxmRZ/cC6NEKf7UUWB4YmAxYK7N1fZahEqbowbFupk37Ascoz?=
 =?us-ascii?Q?WBGqy0uQpD4LNMFy5qLmaAcdA1Uua9Jb8imAHHgLtbd/oVKw0L6FMSZ+qbCz?=
 =?us-ascii?Q?8YyClKOaxD0sajDSQvaoJaHKP1ukdkjE7dgY/ogcRazGbtfwLLfsg7ANnXQo?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1svX8YJAZNSGDdh7PvUs0bcFYr92bCc2UqXhzBU6PSXqhaTx96d/UQjaZWsW5mF9Ll+rUpsO1g0WRvAEIB6sT7MnB9A0S7lJoHEN9Cc5w1T7tKb1ClzJfBM87kBj/6v2/UFodJNPjiiXtn9fybud7pUagRB71FAx2+KTSG7q4LULRf6R6vz7q04kUaPYeRuDyrX9LkygX50barTZcu+E1GB/G+Twc6FULMR8Mziv9/IffVMxYL+1vLaWAwXIStZP7jwg19DlEjwk7V/wmfLe2ZfwuqeKGt7u0GvX9kc+QEW5uFllmh/thfLlMObeha9zrJCqkFMY9DWt1KKnRuytMnHiWnp4Qts6/R0eYA2KiF1QODJE4OeuWvk+pVFN7aboKoWxIynVghavRfdtPzT6kDZgajG8J0LRxrCZ+5ich/y4ASPoDIHmBtr6qPMO81nCCDTX3mVBDg7AD4cvK4mVTUOL5B8alcDff8FGPyg0gNZu9CsFJe2E5H2sbwKQDAFknpEvOuf9enkewyxJjA+KsTBKeU9m3KNXyAAVCjyGysrAxoqFO1BD9zm5fhF+Q4gbjMoc4jJaveKjYWFYdcFWoqPPj1UrVZp/b2alXpZQsF6LFvyGczYghkgOMBBboRF42INs8sJML7Qg6bu7TKiQRmIE6VnNnfJ5tKp8bdgq53yVFSv/QDj3gCA9c+Xmsx/I5yK246FIFsdg1mJQ/fqzUPV7gK09drZfCvJOG/3X6/hirnG1GpU59N1uE1CrNt8XrNuKr0HktG+6dWJWbasFufCbmN1BhvgX9jaiYeUhGniUgGrFsLsF/H3qQ1GG7eb2ZBm3eEMP1PO1nvE9VApj15oCiTHW0KxIFRW0m05Fq0cW/9v8yovCe2dh/irlq8tKgaS76RTb1vgb1hFTbLtnpa0TiYn5OD636XRORdeACE4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2762671d-a94f-4e9a-50ca-08dbbaf5c0b0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:54:46.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQDPommWgONLfCCln5+RtAOKVAH5bKfnK9G2RH8hRaa8emgHqZ+kg2Y1RuBJVbe6pAyjG6PIObj7tA0LsCTJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=633 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210199
X-Proofpoint-GUID: T4lF5wFqcz9aGWTtGD8kFK70CzSL1Hq2
X-Proofpoint-ORIG-GUID: T4lF5wFqcz9aGWTtGD8kFK70CzSL1Hq2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 22:16, riel@surriel.com wrote:
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page

Hi Rik,

I think we discussed this before.  Even with your changes there is no
guarantee that the free'ed hugetlb page can not be stolen by another
application.  This is true even with hugetlb reservations as the
reservation is consumed by the first fault.  After the MADV_DONTNEED
no reservation will exist, which allows another application to steal
the page.

This is VERY unlikely to actually happen.  However, I do want to point
out that it is possible.  Of course, the way the code is today you will
always fail if there is only one hugetlb page in the above scenario.  So,
your changes will help tremendously and I support them moving forward.

I suspect you are already aware of this, but just want to make sure you
are aware there are no guarantees here.
-- 
Mike Kravetz

> 
> Fix that race by extending the hugetlb_vma_lock locking scheme to also
> cover private hugetlb mappings (with resv_map), and pulling the locking 
> from __unmap_hugepage_final_range into helper functions called from
> zap_page_range_single. This ensures page faults stay locked out of
> the MADV_DONTNEED VMA until the huge pages have actually been freed.
