Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A887812EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379454AbjHRSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379450AbjHRSeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:34:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699F3C06
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:34:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IEkumB013556;
        Fri, 18 Aug 2023 18:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zWibMmm/f77jMNuUj9pZuQyAEz3CRvK+S6Ts3XYvVY8=;
 b=gNxMNQYWVPeYT7IV2SYjInAlsgB5bm339zSNQoYBAFL+f9jszDo8jNLuCaJolw049qPp
 /AupplDGDfT8vOX+D7U6j6tCROZ27bqcMwWgx5Sxz8Opbf75Gr3LEsTRM90SVMG+bliD
 s4v1BtzvKhs2gLc6w5VPk7TS70db8PJW8qqchHp5td5eWrxGO/I4UaXVEnvgunxBcKm2
 5YzL1IBp/X/XM5ZwatAV5cVvHMxb1mQKqS0s/w0MpJc5fLP2tpTdJzgTBP15q0aRHUcq
 gY0ENlWQkFa5RrWkqwtS7AUUYwkfZYZsi9TeCgDmjpoovfkolMtjrFk8bYmNakJqjOHS 9w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se30t4n4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:34:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37IHCDRp005463;
        Fri, 18 Aug 2023 18:34:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2hgh1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 18:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLiszMb5VhZ+rx0MD0yM2svykXa6hWqZUOMl1T8PCJBKNK8Pw/UQ2N6WcmtD18wbibcdFzX9+7gnxgsPVCCGBms75Mrgjne9y7BsYv1LPt+dUkdGaVXJ0PpB00GClFSURDagfmzUqxm1/sit3Q71yAoe2uoGK4/7mUGolPrxhQ76/c2zFcRxuK/D0Wio8VoLgkMOQ9CLMlDXkPZBqq37TQhzZLWUB4Kq4LodxgNUBGjMLsM86ZhnYV/U/mvRHpRoNZ6Rq56ZQgu7n7kzX/981dPYNpXY690zxnkedbTamD/bZ/Ccy4jXZV4Wl7zANJEi4L26QgHFz68Cay6hCZcFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWibMmm/f77jMNuUj9pZuQyAEz3CRvK+S6Ts3XYvVY8=;
 b=I03IpbrvxJbsky5dMmWmTkm+kvY3yHmlCPIW7PJdcU1ypsegtzYD5wrdVhaTARE0roRmhT3WUSO694ECglpJaq69laayxZyoF83XPHDErszdlLEu7n4H52wxf4yqs4qVB+BjmKfmBCGuLaUh2zrtdBSEp22d0rY47EVL97yLZI6DBE3FJ+11iG6fzgO8wlWCWZ+e3iKQ8foCyOFR+9CS58uHh0sv4ofF5JIeeDSaYueWlEryip35Vb/dmMFhlzdpPFCE0DBDu3oZMJvev3KVOxW+v03/SO2iQwPHq78LByRZP91PmLRpopmUrO/raTAvM47PZhwnQtWjO8pR0chgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWibMmm/f77jMNuUj9pZuQyAEz3CRvK+S6Ts3XYvVY8=;
 b=CtJirrXjfLlBTv3Y43OijOR1pFe76IZGH+w7KUOZj91Z/IHa90nM+xcxre3ANvPAXW7V4X68mlF4Ckjoz5Lw03gSdVU8vFRc74IKHj+g1p4PrZYCMU/cs4yv5ePzYYWW6UIUdjbtPmT4U5FuCROK8fkGbkvqlTbn6f6QIOcB2Us=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 18:34:11 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 18:34:11 +0000
Date:   Fri, 18 Aug 2023 11:34:07 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v6] mm/filemap: remove hugetlb special casing in filemap.c
Message-ID: <20230818183407.GA5850@monkey>
References: <20230817181836.103744-1-sidhartha.kumar@oracle.com>
 <20230818110309.e9debd8b988cb8ca4a1019be@linux-foundation.org>
 <ZN+z3Q3hAn/GG+d3@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN+z3Q3hAn/GG+d3@casper.infradead.org>
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad03c7a-7340-4b70-d988-08dba019b72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DEpdScVMbYM7fFZA4EQwR5gyGTktQDxklg3LVSVAQUy4HycidKthENTDAC958qeq78oQwHbEzTqGvVy4AfDXodahYblXE3hK4rPVdCyEZ+s6RSRB8iApqljNSsii98ev2yWEI/JQtugE2IpccWTOfvUtGDzLjup7emLUjx8WqrMmyblFmukRluRIltYeLhFvsX9Av0RUykh3exibyrTeA6blv0wmdfE8R4Pj8HO/WD87FlAQxIm7x521A7LDIxH29WugQfPQAmo8Nl7WkBhF49dgFTK0VkjZxbYzzWH2QjGNz7DBgTAYcTrW0aVCTFnQaJ5pWpexwttVDtVtnWjVHWJPqSBJHpE4GqqWbM60D1w3SNr/Y+jSx52k5AR82/j9cyaVd/e9mFshW9V9x05INGuQDTQL/Og4IhJclq/8ingcV0YUdSAZy3UhjgZSBeHClJ6gEUQqsZjLFgrIw3VQsnKkv5DzrTsoEZiJcgm9GZO1yw2r25AFaNtuFOe31hzaPPqTpSWYPiC96CGBTFM48YbebDhP0LNVAk6xqBhKu+5RZCM3nW7fIbvF9YMe9WxS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799009)(186009)(451199024)(86362001)(33656002)(316002)(66476007)(66946007)(6916009)(54906003)(66556008)(478600001)(41300700001)(38100700002)(6486002)(26005)(6506007)(6666004)(9686003)(6512007)(53546011)(1076003)(8676002)(4326008)(5660300002)(8936002)(4744005)(2906002)(44832011)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHDAnmjznqPifBmEw+4SR7jW7HG0vXbB9Pi9RXLcvUf6m0wgf/WLwmZd8HVK?=
 =?us-ascii?Q?H3y58v5qrdGQJ41npSIkgrYdJ5JMMNls/QJo2Ryaj2Wi/lxIlayiohG73LPA?=
 =?us-ascii?Q?b+0iVS47ZqSD5+KW5m3HXjBUA2vWcUH5NUG2CK9Gdr0I+JKXFPVel6PENL/o?=
 =?us-ascii?Q?hNYI4BsSPEKW0lfso40aZVu40sFpYk1NYkpBNgJylfCE8WVnT3p5KF+QOhTq?=
 =?us-ascii?Q?Fk2P5kDQuUQgbR0jErUEa3ZajB6h9r0yzH9dtvWGYiTLEMw8hrpJwn2tps3c?=
 =?us-ascii?Q?eSk2IS8DNR1TyUX5oyzC87D0Me36FW/Lc9fcNT9VNoFlPh9rQMNFXzqmzwDd?=
 =?us-ascii?Q?caVfRhZwPFcqI6E9Wed+CeaA0JyzM1TJd61v/QYXIMUU4OdkfYPpbJNwRbNE?=
 =?us-ascii?Q?Gl8L6LxbUepY3qvNDXpQKnNge8FdSQES1OH7+KCIFjDSDJWibRyVb+mdISFq?=
 =?us-ascii?Q?cXqQwLzJjpkDoWcl1y6ILiMAAFy4RUzxIt8Ww45f0CmxbxKGkzk0PtYRBqcQ?=
 =?us-ascii?Q?VH9aQOTIf8+5N4TduEqGm8Kkt7wXLMHiclsKo7cvLS/vZ8u8bTvuD3OTjCwx?=
 =?us-ascii?Q?VTbpJB/dw3zWUZ1vdxqZS83ScbPN/52yyG0FegrSgSNqByBb5Zhceir1TEP1?=
 =?us-ascii?Q?3OIHVCULpwhH5yu3XWzEz5k8RutxybbGG3n3KKrXOMYgmdiCVT+EVwiVPubi?=
 =?us-ascii?Q?sEIzADmeA+1Xfvs6IWDHYZd9KcxTxmpZUaIcjUaKA/1jECnQg7hCpEF9HdME?=
 =?us-ascii?Q?e3MZgNKS6K9wqZE2pobDGl8CWqDT/t1DZm/HblF/GxoLjn80iK2RLeQrD6sc?=
 =?us-ascii?Q?R7MsORpzIvKc9IiY4RXwGJQeABtaqbmCs3hFFbBJyXY1aKI1O41bzEhBKVbv?=
 =?us-ascii?Q?gzhEdNjwEioCiHNCkxxD6s7u6ECQzczOet/NR81LtIphs3tvRP/RPFM2FwjX?=
 =?us-ascii?Q?aibEd+qZcFLh41lBH9kEe3QbTkJF9lJiNKwX8SHpdxcLVfnEyScguUbEW5Od?=
 =?us-ascii?Q?yoa1gniDDQmWwre5eOYoT3lcGXtN0ab9FP2Av3TNGKw48oxYbWxpkldg8CKB?=
 =?us-ascii?Q?bU01Ey+bm8m2dUuSmdzMdsMvuoSIEEul3eC7V5NNZtnVMOqp+Lt/v5uz4eBF?=
 =?us-ascii?Q?S92CeUWCUVQMGWHV7sYQ8nvHZIGzLASDFg22MGBXayowfMfeNYMN5QpE0oiE?=
 =?us-ascii?Q?AH2UYV7wPLvk2NHqx8J+EVT7vlkjTOMEAycXltHDdikFhkQpIixrFkwAFZXd?=
 =?us-ascii?Q?R0VivqgBMfr9EGU8TjbtQVZeo1M+82gcVfW6aTAVc1bX0bhiYbbcPVioznwJ?=
 =?us-ascii?Q?DNlSkCgfESB9MFJ2iKDVoxeLXu8JKK7cjNWo5Dr/N7+vjFpT27xuOo7o75KD?=
 =?us-ascii?Q?OJSEmvvSN5uq1SfEcxt9PiRr7IDKl3MuMnf26y+JJqbborUwpnYpDrHh+Hsh?=
 =?us-ascii?Q?ryiR+/KtymVXTaPchRNFDZDpXiD5GPLfgWYVqaJwb1grnfdWJ/l38jB3jXnV?=
 =?us-ascii?Q?B0kKLzFaa63C2Yl0hJnZGzVIEqcz84KahFLSpbo08MWJKnMJGHUTfoFd4uhm?=
 =?us-ascii?Q?XkZKrBhvtr/ESrR7odVPwjA++sV7Vil5eLk62xFvH01aU36ZZqriEDn7V8SE?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SOkAgCllBv7z4DfJjXrLayl93hwHRPVETwhgz6s3Ce5Se8X9GauQAm3gezkPAvKupxNnbhTC3C6buhr/uMi8b3Z8/QYUg02aYrpze03+QIbWYw25GBQRHtAa6UgPeKuFd+malWVcYb6lDbXAKkSubGH4+CjR8f92Ex8qW5yKIF+PfBRS8MWP0nbcCa4AVzp4UrxhxGXywW0oXutsNtr9lgtJD+WV/JIxXPIA3lvtfe3Jqy+lTzeOURj7PYeMSZahBCkfXr4hgChcYOxp5DGQj2ftbB/LnxCIM9gWQns0qCYzuwePUOz02QhseOdUm8+sZFuOapDR6vV/9NhdkmDUw3MS8ijKzPOzNxBQqCVY7N4OUpxS9W8/R5RmpqLxlCkIj/NOKf0qUjsVhreymrIadDqdFdW+DLFbnnW5AiyFxp3fYcaCimuVV9uJO2hIKA9OD9SeiRJIUopVecyPYcvvC0obDc76nppsarmNioPcu8OwBYj9l15OsBV/0R6ttn9G/KENhJpgY++g6y2mnGl+ylECCaioXNe46vSAQfh9qx1Djo0+AquENiUPL/KZE2PWKJfeCFwVekEtcMe9NyzDzMnuL1n/641rJWBaLOLg0EHzzSBdiV3MH6pUpCavHG6eUNKnbK4/jfYJRP4UnkLAC6Ls+14KCvNS8jpjxEf+IL1PmJdJUhfb4WH1e+73PxlDEZjcFvCiXlFZVd6wZP129iXvBK1X6/CuQvVwZK5Edo/RRJq4DySPPK2G2TB40vUE7InKlMtHVZToV9xjBAybadeD5jxEz7m77Kb2zIHeqqwENslrdQAUVAW77J9ooGdOZcnMaLsdbkvluuICGBAJ0rNHwYOc7uR8Xer0LQQD3ahsj/Qb/cAQCCjibrDS+h/KWyQDa36UEet9IEx1LegRcSH9DyGcBY+t0pzmBggrN3k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad03c7a-7340-4b70-d988-08dba019b72e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 18:34:11.3724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i16W6jb/2io+3PwrRd7JTpiqPwiDD6Kj11SQFn5QjJGZ5NOPOfqPFXP7SaLlkHuhRs5DzYUSm81mcknuPanfUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_23,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=935 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180170
X-Proofpoint-GUID: PC7vReKePSqKPEn4Lnh_momYxAYIqU6o
X-Proofpoint-ORIG-GUID: PC7vReKePSqKPEn4Lnh_momYxAYIqU6o
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/18/23 19:09, Matthew Wilcox wrote:
> 
> There's also a conceptual reduction in complexity.  We no longer need to
> think about whether the inode is hugetlb or not before doing the lookup
> and scaling the byte offset differently.

I 'think' this was the primary motivation for this patch.

Recent discussions about HGM always came back to hugetlb special case code
in the core mm.  HGM would add a little more, and most people thought there
was too much already.  Most everyone in those discussions agreed there
should be some effort to unify hugetlb and core mm code as much as possible
to reduce these special cases.  This is one step in that direction.

As a hugetlb maintainer, I don't like any decrease in performance even
if it is not readily observable.  However, as a member of the mm community
I like the fact that there is less special case hugetlb code.  Overall,
I consider this a win.
-- 
Mike Kravetz
