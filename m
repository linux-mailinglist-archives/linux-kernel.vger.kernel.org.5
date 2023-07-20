Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5675A2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGTAAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGTAAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:00:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E55E69
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JFOh5H025946;
        Thu, 20 Jul 2023 00:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/IOSkTR9xZ7xU1zuAWBJVGX5ln2dQM3XXoj7x9McGT0=;
 b=kxNHiWMihYF1yloRt/eeNMTItxtsOYKV0g8FaDnDPbo8d21GQcd6ag+k2Gjl66rSuCwl
 fj8OnVsiJgBW+i/8wo6v3I1v4zsAkDYlGu+V4NfvVjMVoklOkFRu+EX+RcXsVjaSmGf/
 8jh2QJTujpBUfn7Fvz29FrI9Yp2+dQxjkIuKKGFQejW0AHO2DGCGbQRmRrQjtiCK2ZZU
 iO0hSfnMzRjlIkJtmD+8HANkIcNlauT8AZpwRb1dvgSlDalvDFnV7txAyUFOsjR6tA17
 9GqyvK5qmp3agRZ+bsO8WU8OvCKubRyh6kocRqOoxrfY2Wodb2FS+Rut9IbsMichXr7N 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run770p96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 00:00:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JMRcen038244;
        Thu, 20 Jul 2023 00:00:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7q35k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 00:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJWtqZBtG4kl/gHp/J4nZ94wr6Jmzsdd+rnbWH6wu1lCpErCcl+xQ9VKZByv91lHGA3KFSKJTa+j+PUmrTdl0qA1cXbTjN2C8LA+3G5XXpto/GJR++etC/gwmCCMCCOYivrriimGzY1A/WZczm/aIxMAzDGI+QZx9xfnX7UQJ4jdnrw4G8oBsHDUsA4a6fYHGAq9mkwM86yQd4oCoccshZj5rqqYFyX/613hKkGt8G8vX22jPLyAIZMM2peZ07UHz6eObPgLfEchk4RKgefLWiVTWXM5H+C3CYDgSZtrUtvC9N6Z/SFIosTzknaqhWS7Nii0/2Xr97XH4DECH4w3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/IOSkTR9xZ7xU1zuAWBJVGX5ln2dQM3XXoj7x9McGT0=;
 b=hYCMbEAh1XeHaZPuJhdaZj5Sngf1zhjtyReRn2L+e4ju2zUP7qJoxhXh+H8taCm4gljnzABmcbmelhrfy8f1AGBRmJjMW420rN4fHp2YySbs8MwcXzwJeEbx4uZTtI8hkEIuTjePLlsgnD1N4IntavLWzjTSAsZi89Mz2FlrM2br/vzUEDsJDa54T7Ssxez4YSz6avU70UigDy5O1VIiHny0rLtq2qDVeNBQTT4BAIe3b93WgsXfix09gkVvQIU9B71ls9+FwcJh054hXfMAYLcyFB9QBHySKGvNitea5DTsPWVZX41KECvLMzWPYlTUkytjGcBawgyyD3yBHLoHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IOSkTR9xZ7xU1zuAWBJVGX5ln2dQM3XXoj7x9McGT0=;
 b=TY+bJ35VNi1VH6WUQn2hYljVnN8nDYwZHNBkKlY5nAmt6zyrIDa5vDwIUfWtpD8V+bDSzVLjB3MnEybRshwNFmiqBfHGqRWYf64Z6SXoeYPewHcCI6EPr6tddCHh4lh7Ep1Ant9ONbUJj6z7tPa+pug7ZuztG3uv72qr+J5oXpo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB5709.namprd10.prod.outlook.com (2603:10b6:806:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 00:00:14 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Thu, 20 Jul 2023
 00:00:14 +0000
Date:   Wed, 19 Jul 2023 17:00:11 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, willy@infradead.org,
        songmuchun@bytedance.com, david@redhat.com
Subject: Re: [PATCH v2 0/1] change ->index to PAGE_SIZE for hugetlb pages
Message-ID: <20230720000011.GD3240@monkey>
References: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710230450.110064-1-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:303:8f::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 10af67d1-3ed3-4c54-7a1b-08db88b44b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+jAEJxrRapVa9KIxUvY5XEJYZp0nWZZwkUwzOY8+SlJWWGYHiRkBbWQEEt4dZ9RGVlCOP7D2BM2ITsjcPcJzG/U/RuHkM+uBS/x2bO+Q/kq6IrL7/kZWD1p417O3p8y7qALGXe5jkzyX9yU8StVzhJZyOJxQArmlU28McHjYzappAyK/ZSzCyixIr1fKotnoNm+3YRIQfHXsxccGZcvjcWORuPCnNC8smnr+rf0SwvS3o6Lo67I4I0Qt3Skws1S92z30k9m281GZy0iLy1ZWX1WWnH7M38w9NRS3EMti7ZgLeWuyiHoIXqSG9D7EAmSUW1/u1Om1u2dgtZC6XY4S2GptGqOdDFraj7B7VmtSyB6neVt/CIK9F/qSftnPa+jrUVmJmPhyJZ9hTVGN3+TNkTKA06Prb1aCVykcLZG1/PqfXg/TIwTRYZImYToBtLr3jOPDmQzHOKwlP6MlfgKchNWTVmmO1sFV7Io23LTbsSaIBRlaag9UYlpiIYjlJ3QgLY5+svVdbffS4Xe7ruNEmGKgkWfsvJktPS4ILewHsffyX+ZwL7fj7RNQwri/VI4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(53546011)(26005)(6506007)(1076003)(186003)(478600001)(6666004)(6636002)(4326008)(66556008)(66946007)(66476007)(83380400001)(38100700002)(6486002)(9686003)(6512007)(5660300002)(44832011)(316002)(8936002)(8676002)(6862004)(33656002)(33716001)(2906002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VSe0z2q8E2x0zdZ3iJVUbEg5h6UjlCsV7oxUD2DSD8kE6q05bEHa2yDR7uKJ?=
 =?us-ascii?Q?dcHreWfuazf99XRE06bimI86fKyjUMDlGT/4vPwP4XiwPSljriMS6ZTLCDJl?=
 =?us-ascii?Q?q43TR6D1oobHAx4ekeU0ZPSrifTheTwgVLaYA6Dp7feemm6a2wm8/It8wLAk?=
 =?us-ascii?Q?AkQ5bPSacDOneO5Mb7iDSUN/BJWmixfoESO1BGM1xjhT0r7CmRD8r6JyGipz?=
 =?us-ascii?Q?s5IvhI6DMSapOeLJiQRpBPqjgU0isP4QsMcBqwZ3vnMJt49PkCjU5CTnOVYx?=
 =?us-ascii?Q?8J9eWR1j0jiOlLtiQwCyPkSlk2H1n+X91Q+/b0mdCh5xK2IKzko8SJaDi0cq?=
 =?us-ascii?Q?zoj3/fFoHU+lVTkqvR5RIMIxFLfw2W3Sqo7UDeeOEeWjM3uta8pmkMIMLbsZ?=
 =?us-ascii?Q?NJiYxgeaaCoYVBDKgsPh05VWXZAhVCyzT7xvEEb1JL5tcRZdWANnhINWjstj?=
 =?us-ascii?Q?AV3jheDRGbYtaM9qbSwA73C1elIaVUeOPIC93Huh+A+dXA2m2GVn9vYYHk7d?=
 =?us-ascii?Q?vysfyf2VTMiCYTjMlNOLHERmqt/37D/kitCcHhZE1F/IfY7Rl6934+70Wu2o?=
 =?us-ascii?Q?fRiWw84VQg4v3sxV70nc5tqxr7oZJR7PEF9x69OSyRq2QtUJJqJAvGQvm7Xe?=
 =?us-ascii?Q?c5edkse01SstuwE5yt7PciyfVHI3Ttpaw3/oRhjkqg3PHU8xj0BZL7tNTpl3?=
 =?us-ascii?Q?kmgHQ9pYis1b9m+PEbcHYX8PYVf5tr24aeLSNi05vXXBwK5g186sKFfePfi5?=
 =?us-ascii?Q?PSKX3CHKtKkLkp7/ATKEi0Qsc1lgGg+x2shSWZ4VPaz8Yc+bXEbUlL57u62p?=
 =?us-ascii?Q?vvigxGnb+0Utjv7f9FybcD70yl0jprQfPCslgTO1tq9oW2jFcmjew59rA9gG?=
 =?us-ascii?Q?3v5c4VUErElyyhmpJdSyoN7HUaTihWnW9BNKTRawycqIZ3hUucAxSbsGvyvF?=
 =?us-ascii?Q?4tMtKRic1goFoL3y+xYWBDUT4v840qp+QWE8Z+xE6os2H9Xj/WMS0TauzOdc?=
 =?us-ascii?Q?IYdqMhaShXZ//gaqtMyMiWS31O0YbF4K7+oNVG5KuuzYWnQcH/JPD1EZv3zo?=
 =?us-ascii?Q?waNep1EwXJTujIE9z58tAIpe70v6a0SR/qrg624bu+q5uHjyjab4uARWGHkQ?=
 =?us-ascii?Q?CT/00LJg6i9/xNH18oQAR28yyb32hpDAIV3IfO6xRscEKWIxZOhqyMeL/ZKC?=
 =?us-ascii?Q?+HdO2cY2hmqSXTfSIorrtarCtYSUi6AryYTxBdgq3GdjavIY5KY7CFtDMLdT?=
 =?us-ascii?Q?biVKg1zxFFrC62ququdUZV4dvKBOI34hnKVrkOM79mby56AbYVN2sl0PLUua?=
 =?us-ascii?Q?sUYZ34L5+xH7bB7beD8qHvROz/x29/lkvR65ZfDb5w8Agwni4KEXPpG01F/r?=
 =?us-ascii?Q?fJwCOvCwPSczyUhRX1bez1gA1MGhF4D34ZPHx2+nL8ZQJNNemJsrKGY4YwTr?=
 =?us-ascii?Q?wS5QZ5Z4fmN4VpI05UO0n2cEYLOoCSFT24X9E9o+MXs30NMtQXQfBqmps4Me?=
 =?us-ascii?Q?4bjoMpIkRfWPWEpyMGePjVV2nlZ+iZYaduTgL6WXtKFIiKor7vFNThlBMqSG?=
 =?us-ascii?Q?DXArIQEjhVLmd1+ucoSw1MRqj4RM5OdqR7+Y3z45h2c94Dx5LbzUYWXXh1N6?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?rwnCAgjZuNtpP8iyG1cRxGg90KS5qQRIn+aZl/ObdG1O2ExY87y4rrcau1Zi?=
 =?us-ascii?Q?xqlUITbVXGHLmJfifAwaiLgQMGTug0tPFdw6tD7kN5bi+U0J9mEWnq23JZd3?=
 =?us-ascii?Q?bA8jdYwZ6tgybh6FczC2be80lcEaxwsYSzd/NYrK6J8qlkZOwNGnOn8Hgzzp?=
 =?us-ascii?Q?DcAHu9zivJP+3WBMgt5JyIAXy2t5WPjpaVpaSCfEMg22Z3HZtm5GVRMz2q3J?=
 =?us-ascii?Q?869H0Mz5fz5eZ6S7F2ZDz7VlKbzSFedS5gzoGgvrRLyg6p57Vm9hUZW5SpPT?=
 =?us-ascii?Q?6M7hrrSTjC0CkwjGIzXDO3wsHOzAjMLkUTLmaO0lFaGQ11q/l+yF5eM5lacK?=
 =?us-ascii?Q?2yYgH+fZ0+tJy6CzdbsDNkU+KG02wE1hdkyturG6jpyA4q1NaIdxmAuKSxp1?=
 =?us-ascii?Q?4SrYD9TtBiRxzvNQjeoAXpxKDE45dh6s5fagcSX/PmlVSEeyLvbIba8Xbjam?=
 =?us-ascii?Q?0oqVCZVe+j3uydltrp1gjiJTnyLAmXNsTi4seI+WWKu0XpHo87lPJqQ19XTA?=
 =?us-ascii?Q?VuTVE+hZrTpDGC6Fom8PaF/Cp1cfz45+9ova7agCDr8ojqavhGEAJ+9GIz2D?=
 =?us-ascii?Q?oCHfSoOHqtMewvmGXLXooFD75P6ZMOfUuZ9QSnyg49ku0Cmxwzr7tvc8YShc?=
 =?us-ascii?Q?z28Vq3OuP/p/MbVqmJP3mLA+76nOxjVcrKPpGd1RiH3Co1NCzQtODBo2fRuA?=
 =?us-ascii?Q?Le1CnAoj75ZzVmf5ek3UopOIiAkdmn/awre7ODMfKMoqK4Xko0EpJ5pryZ9B?=
 =?us-ascii?Q?QsAYKASJV+SqFLG5cvApavUUEpbSdo49rb/8R/9UqwkDxT00LGhKddeMdjoi?=
 =?us-ascii?Q?OOt0RlOzWYKwoqFwGa2Bw++ubUZTPm6WveFYTMJHH6PykuVsNbd41/Fyokb4?=
 =?us-ascii?Q?P8kvusnVUmpHo0EgoPgAhGF8gYI0082wqxWfHz+9ETyD3FAwsjKcvThGXPNF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10af67d1-3ed3-4c54-7a1b-08db88b44b57
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:00:14.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VspjjjcG8Fi2atkR40sjhHkREjahMK8k9ixfYhz5aFTv9Bj+YLJKWQCLHNZjl+IR9v9778O9EA4cCh9FLTG2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190217
X-Proofpoint-GUID: rMEgED3fVzgrdmGk7Ue7Ae3zuwLCb5S7
X-Proofpoint-ORIG-GUID: rMEgED3fVzgrdmGk7Ue7Ae3zuwLCb5S7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/23 16:04, Sidhartha Kumar wrote:
> ========================== OVERVIEW ========================================
> This patchset attempts to implement a listed filemap TODO which is
> changing hugetlb folios to have ->index in PAGE_SIZE. This simplifies many
> functions within filemap.c as they have to special case hugetlb pages.
> From the RFC v1[1], Mike pointed out that hugetlb will still have to maintain
> a huge page sized index as it is used for the reservation map and the hash
> function for the hugetlb mutex table.
> 
> This patchset adds new wrappers for hugetlb code to to interact with the
> page cache. These wrappers calculate a linear page index as this is now
> what the page cache expects for hugetlb pages.
> 
> From the discussion on HGM for hugetlb[3], there is a want to remove hugetlb
> special casing throughout the core mm code. This series accomplishes
> a part of this by shifting complexity from filemap.c to hugetlb.c. There
> are still checks for hugetlb within the filemap code as cgroup accounting
> and hugetlb accounting are special cased as well. 
> 
> =========================== PERFORMANCE =====================================

Hi Sid,

Sorry for being dense but can you tell me what the below performance
information means.  My concern with such a change would be any noticeable
difference in populating a large (up to TB) hugetlb file.  My guess is
that it is going to take longer unless xarray is optimized for this.

We do have users that create and pre-populate hugetlb files this big.
Just want to make sure there are no surprises for them.
-- 
Mike Kravetz


> 6.4.0-rc5
> @hugetlb_add_to_page_cache:                                                                                                                                                                                                     
> [512, 1K)           7518 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
> [1K, 2K)             158 |@                                                   |                                                                                                                                   
> [2K, 4K)              30 |                                                    |                                                                                                                                   
> [4K, 8K)               6 |                                                    |                                                                                                                                   
> [8K, 16K)              9 |                                                    
> 
> 6.5.0-rc1 + this patch series
> @hugetlb_add_to_page_cache:                                                                                                                                                                                                     
> [512, 1K)           6345 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
> [1K, 2K)            1308 |@@@@@@@@@@                                          |                                                                                                                                   
> [2K, 4K)              39 |                                                    |                                                                                                                                   
> [4K, 8K)              20 |                                                    |                                                                                                                                   
> [8K, 16K)              8 |                                                    |                                                                                                                                   
> [16K, 32K)             1 |                                                    |  
> 
> 6.4.0-rc5
> @__filemap_get_folio:                                                                                                                                                                                                    
> [256, 512)         11292 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|                                                                                                                                   
> [512, 1K)           4615 |@@@@@@@@@@@@@@@@@@@@@                               |                                                                                                                                   
> [1K, 2K)             960 |@@@@                                                |                                                                                                                                   
> [2K, 4K)             188 |                                                    |                                                                                                                                   
> [4K, 8K)              68 |                                                    |                                                                                                                                   
> [8K, 16K)             14 |                                                    |                                                                                                                                   
> [16K, 32K)             4 |                                                    |                                                                                                                                                                                                                                                                
> [2G, 4G)               4 |                                                    |
> 
> 6.5.0-rc1 + this patch series
> @__filemap_get_folio:    
> @get_folio_ns:                                                                                                                                                                                                    
> [128, 256)            13 |                                                    |                                                                                                                                   
> [256, 512)         11131 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [512, 1K)           5544 |@@@@@@@@@@@@@@@@@@@@@@@@@                           |
> [1K, 2K)             996 |@@@@                                                |
> [2K, 4K)             317 |@                                                   |
> [4K, 8K)              76 |                                                    |
> [8K, 16K)             23 |                                                    |
> [16K, 32K)             6 |                                                    |
> [32K, 64K)             1 |                                                    |
> [64K, 128K)            0 |                                                    |
> [128K, 256K)           0 |                                                    |
> [256K, 512K)           0 |                                                    |
> [512K, 1M)             0 |                                                    |
> [1M, 2M)               0 |                                                    |
> [2M, 4M)               0 |                                                    |
> [4M, 8M)               0 |                                                    |
> [8M, 16M)              0 |                                                    |
> [16M, 32M)             0 |                                                    |
> [32M, 64M)             0 |                                                    |
> [64M, 128M)            0 |                                                    |
> [128M, 256M)           0 |                                                    |
> [256M, 512M)           0 |                                                    |
> [512M, 1G)             0 |                                                    |
> [1G, 2G)               0 |                                                    |
> [2G, 4G)               3 |                                                    
> 
> =========================== TESTING ==========================================
> This series passes the LTP hugetlb test cases as well as the libhugetlbfs tests.
> 
> ********** TEST SUMMARY
> *                      2M            
> *                      32-bit 64-bit 
> *     Total testcases:   110    113   
> *             Skipped:     0      0   
> *                PASS:   107    113   
> *                FAIL:     0      0   
> *    Killed by signal:     3      0   
> *   Bad configuration:     0      0   
> *       Expected FAIL:     0      0   
> *     Unexpected PASS:     0      0   
> *    Test not present:     0      0   
> * Strange test result:     0      0   
> **********
> 
> 
> 
> RFC v2[2]-> v1:
>   -cleanup code style
> 
> RFC v1 -> v2
>   -change direction of series to maintain both huge and base page size index
>    rather than try to get rid of all references to a huge page sized index.
> 
> v1 -> v2
>   - squash seperate filemap and hugetlb patches into one to allow for bisection
>     per Matthew
>   - get rid of page_to_index()
>   - fix errors in hugetlb_fallocate() and remove_inode_hugepages()
> 
> 
> rebased on 07/10/2023 mm-unstable
> 
> 
> Sidhartha Kumar (1):
>   mm/filemap: remove hugetlb special casing in filemap.c
> 
>  fs/hugetlbfs/inode.c    | 10 +++++-----
>  include/linux/hugetlb.h | 12 ++++++++++++
>  include/linux/pagemap.h | 26 ++------------------------
>  mm/filemap.c            | 36 +++++++++++-------------------------
>  mm/hugetlb.c            | 11 ++++++-----
>  5 files changed, 36 insertions(+), 59 deletions(-)
> 
> -- 
> 2.41.0
> 
