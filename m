Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76077514DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjGLX7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGLX7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:59:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070871BF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:58:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CL9teO008422;
        Wed, 12 Jul 2023 23:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8MXTG2a2xI/2RhL3uYTs9O5tHvAN4el8pNv5lb6cmfM=;
 b=RlKHsjP65ltJ+K1/QZ/zPi+SP7I8KVJrOLtW3TjPSvXFhK7Fx3f0gITWmQHStJX4YeG3
 9YPrOR/L3FM5scuwOuzv7r+Rm/qZnspW9g5QpLpldOzjpnyUVmDUFyF0uL5Iki+jmmjr
 Gp07HmB/omaKzh1GTa+U5LsGzVZpYpt2HcXkfbUQJuSqfIy5/+XBdYUYBQ0RGStcEx/Z
 A3z0oJfMmTnuHotYtxjCh/n3oa3owEdLggHgjxTXs8mUktME/IOPUUFfWHkJYL40NRzX
 +hZ+9gco0+aEWeGyVipB7AL86acpg49qa27EQdm8oiYXwpp846RFTsUGVPK+/Pu8kgiJ lA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydu0d04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 23:58:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CMcwei004344;
        Wed, 12 Jul 2023 23:58:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8dqxhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 23:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcDhFKIicqGdHYHpV+lEDCf04k0Q99aV+ARX0I5wefOX0MA7NkPgFCLCL3IWccvR0nqpA+4c7AwYtQXKPFF8BDele9brUuw+IR/rFPSGtVBL9dfj+llOy8ygOD3gQMTzl3XkIsLydVKgRd8j+I9/dygSh2ZZ6dG4lUxRCrdezrXJVwIjXzVFmjt9GMIYftobVOzExqgK9bzXbssw9g/sPQFM/aRsxqY3bAjW7E1ZtL1KYqqyXz6C8pPfnadhHFFnwVWdLvB+nGvXC6bfCGAy3cOdSxhMHVkJAe6cLn06wOA6/wmwSwk5ssyRAu/S/qkgxCc3v+Hqge3g1nTOoUeN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MXTG2a2xI/2RhL3uYTs9O5tHvAN4el8pNv5lb6cmfM=;
 b=W0xthKaD+85xhdpgH1YJAZWA7IJwOShzTe4qzTa4BhhbfletCbiX/Umd2yhLzVNcYRLcLiwx6KrwWjcFKwbAA34jrPw4E9uvkbLn+bvJODU2YQrrHQelhb43VqslsEiVEa70GR6pW2IcvsJSUCLFSIyaXUNChEBsNZ8O3K+J28ATjjaMVU8jlMPQdUhJKNZsAi2hgVrhFphiQDgAMhz8f//BPAss6rUy3Dr78yrRj23FiTrVLk6/3qN+UHbK5eiMHptFQibapktUDJEGhpeEfivmh26lGB6xLbbC28iarq4yLRvTnQB6Q/9iMO9GFyw40kYciT3agVXSmvtZpYoZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MXTG2a2xI/2RhL3uYTs9O5tHvAN4el8pNv5lb6cmfM=;
 b=znaOeVVB/TUY2oxZVkhGVSNCZr/DvAlBtMXvfe8iMDH1xvsuJ+jADYmhumXYmPEQ3lkrENhBjCJ4VHMcyJRdktpOfzLvveE1CCcJwWBxEfxPp0KR5yiv8Z2m/TL5Lf5FwtqCJQ2RYmxmbG29Rv4k0KgWK96UKzAUiNS9nClhqG0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ2PR10MB7560.namprd10.prod.outlook.com (2603:10b6:a03:537::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 12 Jul
 2023 23:58:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 23:58:16 +0000
Date:   Wed, 12 Jul 2023 16:58:13 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        trix@redhat.com, ndesaulniers@google.com, nathan@kernel.org,
        muchun.song@linux.dev, Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <20230712235813.GE6354@monkey>
References: <tencent_8D245D1A87D17619EA8475E8F005A151000A@qq.com>
 <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65f4c60a-9534-56dc-099f-ee7a96e0ccaf@redhat.com>
X-ClientProxiedBy: MW4PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:303:8e::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SJ2PR10MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8f3293-b436-4a56-b2d9-08db8333dc29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UW9z472S8uAIC848xGxOPlLGWYI21OJGwfDTygzyVSoxR2EuklSKdCkgawk7j/qX57+Jqih+NguVkZug/MKvYlC9iMcBmPTAUpAqv8RhqEfcIWJQS0Cx8AutT/YbBB4BtpXDXN0nI8Y/9OhItg6bYsuGz/h4ljm4w0Vq8f0t9x7uOA4YreLNUmKfkZJavCnRixacDQJdKwFZ5sJqYUigpcPE+4BELkMXKnv1GANIyhZKJAg9Vz7sadlkOx1IClOgntg2/h1D5Gab8JrWzPOczRcTPtmd90/RTInS+JtyEMyUBVLOub5WBvmivM/JTmRLI/jP5rGHS+A3IH9kPxBQnpHRajf0unRL3QIMZq6MXUnlz4KMvsVmu84rD+gSX6zhPU1iTeQ0tN0VTNdnSSC7pjtdvXFMUh/338g9MX7Jsl1Y5Ue7YlmHs5bK9BxCsBq4x8b9p68NrS46F3hzYHsiXFM8p3dLEIGqkuCGbn3vf56PCJcSr0lRe+/bHQ9M/GQYtTuvwUr5W1QBfQVYF3FNEpXsgMqspzRGKW0pIty69gWd04/PoMobFmhaTsDWObG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199021)(54906003)(478600001)(316002)(6486002)(4326008)(6916009)(6666004)(9686003)(8936002)(53546011)(44832011)(1076003)(26005)(6506007)(8676002)(6512007)(186003)(2906002)(83380400001)(41300700001)(66946007)(66476007)(66556008)(38100700002)(5660300002)(7416002)(33716001)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0yThKnLX16E1A4FVZwH/axAeQdH9iEtnfXOAR3WZ7fy97qqLijYKdzt4wYtg?=
 =?us-ascii?Q?pZVyfwtmEnGC37/J9i99ljc7fMDEVwvFjLSRe5bo/zWQaeIh1MDeQJDltPPY?=
 =?us-ascii?Q?nqxNGOZ5rB7WKByH/qOpf68zJ2D+uX/O1xFXPhBv56V3kgPTy5jaI/t6qvkL?=
 =?us-ascii?Q?6gd0rLs33+4aaRX/ut4BSiyRK2OVyaqfFfHo52sfR/9M6DwSVxMkHebodD7H?=
 =?us-ascii?Q?xTj9Aaz62Q5GimvtHxI7LBsknn78lJBH6y4mDyjvhDBCQhlRrvALqnBkqv+r?=
 =?us-ascii?Q?70YX/YjHcKCx0XhBOWaapHmfyI6gq9P3b8F7Z03SxMqmLU405WE2y9ThGsfy?=
 =?us-ascii?Q?Vrtv1TAAP/i+mfjB+iIbQjYPyAUeQ9dhYxLvVS0oA0hh+6NziS1TKjfTyqRM?=
 =?us-ascii?Q?1VF9lnrf+JV1rDnj08Uo19ESPrHPNhKwHYo1AfRLqgMmy4Tmg0WlSE3ZpwX0?=
 =?us-ascii?Q?vJ8qqkNI5TC/aSBEwMC5YiJnxwSU/r49u51L3mW/B0ZA4lN62LvZUqEZmT1H?=
 =?us-ascii?Q?t6OKuPJz/hTaMttg7zadKzAqRSODW+7Pq4Y7xdFSmcLTOkTVqWkP5a7oYygU?=
 =?us-ascii?Q?K6+vwxXcVLIYrXcHrwIxaCeQO8kuOjtdCGzoSl/K1JlOjTLE6k4zv5gK12zI?=
 =?us-ascii?Q?ajZ8jyUNoaNOScWt8AFsQACskW1qUvqMbXATcAIp/ph9kgcywb6juycVhhVl?=
 =?us-ascii?Q?3wF7j0zkO5/Pog6FpfIYQ5sF4fIm/UJkr7i7vQYPVMs/MnYx7OAcHPwhWoEI?=
 =?us-ascii?Q?OVCnKgI265duCsdEbJz5tTyn3zpScg7qynN/sAyxpTU04LB68TJ812QUJ8Xi?=
 =?us-ascii?Q?mrAFW4uIcDHz7G95juWy/3v5aZSin+qE13G4xqE2bWCX8TxMp4gCDAOcon01?=
 =?us-ascii?Q?QLdRgPKEf/KsxTnzr9umbW6sxDJem72rcxrvnYP8iAL8Qv49SQTrWMyDx7wc?=
 =?us-ascii?Q?1tVZYn04NRB3ZmtpgVe1yHfsu1Zzf242mzysaWInZrd7vI/bm4G2Mn3Msbvp?=
 =?us-ascii?Q?jevfP39n1aYRg5rkS4uO+VPmbeC1El2HjLR4dgR8GMr7vu7S/bTuMGeHgXU6?=
 =?us-ascii?Q?O2I0LCOFVWftVN/y9tweXOJcYrFqwfn98HpHE5lQCl8yzMJby7ml4Ak6Ohuf?=
 =?us-ascii?Q?hMkNpBkw/Q9G5dR+f+6AgroPh3ws5EjuaLa4YiOZYeeYKcze7zeQnmYynJlN?=
 =?us-ascii?Q?zu7PQnxFNpeYkPDhUdfI60qBb89uHTJyEEhKuHlrlYKfRwlRfNDNYlYh7t5x?=
 =?us-ascii?Q?trZO6hR6bLlVObnG+k2B4elju/6gf8p9bx84n1TiE7hJLHwzAFaL8AeMWznj?=
 =?us-ascii?Q?3mj+xNJ2jrZi89f+OVJlq2qd5W+pwbMo4JFEP2u5RCfB+MDyU2HJeIfI7b9z?=
 =?us-ascii?Q?4NqmYNDrpXkSMrE6sZHWA0b9EfZG+giGLAN2fiPL7iboflPt/dlB0G9wdUua?=
 =?us-ascii?Q?ZOZiwuKZa1JGqf4QFQWaIp+3daA+JRtEDhOxII0wTCJZNNbBRSFQ3JDm1UOH?=
 =?us-ascii?Q?bDLNXP15hM4HWgU0Dyk7wnI1ia8iR4FzSGktvL3OlPfnLUQnLjJfkK9X2HTy?=
 =?us-ascii?Q?jxFIlkt86bUpcJhyTPxB5CNLJqa6mVAkL3aIApp0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mDjDn2884XhHB8DfvTQ+Zxb9AyIwZSwigG0Y1oumCg33kpEFU6w1yY3fgNCM?=
 =?us-ascii?Q?ts+vuY/y6nt6D3zKga0IDWgxyvOoPXZ8lZjCnAZyLa0GG2exki4wUcQEVuzu?=
 =?us-ascii?Q?zJN16H9Kpi6AyA0asum3/rltJq/Aj52EtbMTjdIsHenkk0nU1lpsJ8On7JHQ?=
 =?us-ascii?Q?pzoW4S9M9af3EXakV0uqUfXxp2iQPkH6Y/gTkp2fzhS1Xh0Z+gGNmL359Ist?=
 =?us-ascii?Q?NfQEVJ/Tzt3ZUh3oLbraKQx9re4NjHTVZQAOITI7zzSA78dh68p6Ljya2xYp?=
 =?us-ascii?Q?Cj3zMCcKzZ5nNeheFZIAyDz7/E+zBlT32XXJD7v4w1/cW0UL+2/9SUC+br7A?=
 =?us-ascii?Q?pU9Ra4T3I/BKUTaVjqo57RN50CwIivMqbBDCfwKTYtagABsRRCinwdeOcOqP?=
 =?us-ascii?Q?e5+uTNoaixinv/n5fhfS3Is+ywOVTDXEqKwENVjkqfZjQsPFMZ77GeVENSST?=
 =?us-ascii?Q?+b133P5P4os4zusxHw2F+NA6SJa+xXBbG8+lCpYkJH/D+8cirGiFJxXRWg5w?=
 =?us-ascii?Q?u+7etLwuwqgUGPECh/ilLqRaSD9bijbti4MUSJaOVcy9VyKEdLNLi2CqxG62?=
 =?us-ascii?Q?HmeMb2JeBBtCkDHhoCGVtGWy9c9AfIRXzjdZHmzYA4KCT2si2okaUGf8AVy8?=
 =?us-ascii?Q?dZC4byAVhe5luXS3csyFLNHd7agFguLbphW3/gN0TrBo1nqIRkt4GhFQdIwP?=
 =?us-ascii?Q?771WgWVUrCeZ4F+XMjUosWXfwk5nlT/UePpCZ1EnnkgzTrP5azr4M2Egr3zr?=
 =?us-ascii?Q?C3tmDdwwksfnQTpZuHsO8R5chDQJdxcNYc2dpteBvowLSl8cLIY2r6noyemh?=
 =?us-ascii?Q?QtVcobUxmsXiC/mlqCtYozt5aFDe1PBDneMB7983efsIlyu6ae5QyYxYZBlN?=
 =?us-ascii?Q?mBGdQxuIyt2VhEmaTJGi+96ChaC6g/6JoLOkJjweG874PETJbgu3znAH/9gH?=
 =?us-ascii?Q?YHZfim00XDG0dujH8cybSaXNaVZ83uRwfpafjjdAMGoPeGXagCuD38rY9cal?=
 =?us-ascii?Q?1VzM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8f3293-b436-4a56-b2d9-08db8333dc29
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 23:58:16.5303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19AlK6QLabO/Vr44qK4WsVS7WjnpxMaF3QCzYJvSL+MMGhJMPeIpXa3YL/dggscqVt8T8e+nNHPC2dGsca0HAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_16,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120213
X-Proofpoint-GUID: ofUrr7Gf9HxVQZg861bXhS8lYIHmqmv3
X-Proofpoint-ORIG-GUID: ofUrr7Gf9HxVQZg861bXhS8lYIHmqmv3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/23 13:49, David Hildenbrand wrote:
> On 10.07.23 10:32, Linke Li wrote:
> > From: Linke Li <lilinke99@gmail.com>
> > 
> > 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> > 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > 	/* check for overflow */
> > 	if (len < vma_len)
> > 		return -EINVAL;
> > 
> > The existing code includes an integer overflow check, which indicates
> > that the variable len has the potential to overflow, leading to undefined
> >   behavior according to the C standard. However, both GCC and Clang
> > compilers may eliminate this overflow check based on the assumption
> > that there will be no undefined behavior. Although the Linux kernel
> > disables these optimizations by using the -fno-strict-overflow option,
> > there is still a risk if the compilers make mistakes in the future.
> 
> So we're adding code to handle eventual future compiler bugs? That sounds
> wrong, but maybe I misunderstood the problem you are trying to solve?

Like David, adding a fix for a potential future compiler bug sounds wrong.

I have no problem with restructuring code to make it more immune to
potential issues.  However, it appears there are several places throughout
the kernel that perform similar checks.  For example:

do_mmap()

	/* offset overflow? */
	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
		return -EOVERFLOW;

expand_upwards()

	/* Enforce stack_guard_gap */
	gap_addr = address + stack_guard_gap;

	/* Guard against overflow */
	if (gap_addr < address || gap_addr > TASK_SIZE)
		gap_addr = TASK_SIZE;

do_madvise()

	end = start + len;
	if (end < start)
		return -EINVAL;

I am not suggesting that these all be changed.  The question of a real
issue still remains.  However, if this is a real issue it would make more
sense to look for and change all such checks rather than one single occurrence.
-- 
Mike Kravetz
