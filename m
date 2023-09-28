Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34527B238A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjI1RRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjI1RRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:17:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6991A7;
        Thu, 28 Sep 2023 10:17:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SGi5CX027549;
        Thu, 28 Sep 2023 17:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ReaEeKMqxObRXDD9d8gCwYRWB+q/MHS998BcLo0Q20I=;
 b=xZ6QuJf/eOpAeSmg/mxzVkeq4IyUvushF/1POVAoz563JkauPfEFV4HsQTl+K9mTqDIw
 y7ijCrGCm8rn4oxb2ZkzRqg9/LOh2DQKLiScwYALoN/RXOeepZk1tGR7DbTqh8khSYcd
 4u/7GNEbiRDvtCWvYPPX5sICIgwEaUA2MMkvjG2AOTKBDz/H3ONUwDCqpEBgFitbeFEq
 0+tg9S4V57nGBAScUXIrWo8blU/yUOyMfcQ6vpjOpRlLNTaLlmeedzcqGnubDlNgQu4j
 APyn1iY9gOyak4ysiBhWwdnEzkDoEw9LUH4hvsURZzW8cfDuc6wd/dFtQpFyf+ZhBBSz nQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmun283-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38SH1oEA013823;
        Thu, 28 Sep 2023 17:16:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfadq5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 17:16:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGmAXNBxBGO0ZNkUW4TIfsIlvHDghJa4x0jUgaGrv7kUobYlzjqOiYpoViFlYXIGsUL57yknHCIMQzjh9JVhWSd7nQcfdarG6O/CxkjdCpsbjpbtRzHi8pRXoNnGLnBAesOx2n1EDf6w4Ttbgut4iOE+BG4RUc+tYx8MPBIMP9zCutN7Qk5XAe7kDlxK7oNLd8IV7IFnnXJ5DCjjE1Pl4dZajLc+4zBzTi9CfouJpvfYNM5EUt35Pcz8h05kGDp6KRFKciy0+YY1BhkIebSXMCt2XpqsMoyMFM9xjpJ/GekZBjIMqS6aTM0VfxEEryyFi0qYom6iz35DXeMYqhc5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ReaEeKMqxObRXDD9d8gCwYRWB+q/MHS998BcLo0Q20I=;
 b=RC4GWWwWLAGkCtKc8ohgkE3YIIAp6RxkNZutRwy1dLejPCtdBpqKk4EHxUUYm3riMOast5jpeQS5FL6Ism0rcTBZXpveQ7NA7sTEkDKkPdqEwv5PfX9X6zK3AguznfPVWHrz2807jTHMEWDSQOCMwQ0Ild9KiegLIu5WZr9lj1VFc8jFi/aqGYIFtnog3RspWvP7enxulzrjQvrnwbyh6WiYXhIXnevFrFhhC4GdPre2WzJ8gvT3EozvJXHw/H9dntzs5poqKqaXO2QbyETAlArM7rgVW9hlwn/HbrhL4bnei3rdAwhy/Cp00/OWKijQnEsJDvrB7vvDbCyTWTzw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReaEeKMqxObRXDD9d8gCwYRWB+q/MHS998BcLo0Q20I=;
 b=VwAY40M8i3zKBaFH5YnA3cYxu8oGd0wE5Ajwvpbc7EzrSbHNnHKMARkKJpbWpVzTm/o63d16currkKBE/qMBHjHfdHyLBfrmHZpe0HvAhpXGMu/j9hoEQD7f1XNyt9BdkmYvAhTe0UA6QMxJ0VhtTH3QGa8xlpBn1y2oF6T0fPs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5273.namprd10.prod.outlook.com (2603:10b6:610:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 17:16:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 17:16:43 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Date:   Thu, 28 Sep 2023 13:16:32 -0400
Message-Id: <20230928171634.2245042-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
References: <20230928171634.2245042-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a58ee02-0b40-4400-5d04-08dbc046afa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95tFYU9md8I87K93ccqrupxRyLfkJ2bRok0EbJAYQ/fqZhJmL3WJL95AtPaoA0b2wFjcmgO5TUrl+obRR0to1tuNep+acvcOQxEMTGJkuQ2Bp2uvQMrxL1MiQNLcrD0POM8d9W97+tvcE/6DPGcu12hPV2nd5JIEZOtjk8p+3/MmUUPKpy415EL1hBhkSDEiEbYmOcrnGyLvhJUQQ+CT85jERPm7H4juE0Wrei/db/DjO3zxMd/xuXgzMSJneY43qR/xOCm0v1pAIAX7rj8aBtWULLkT37BPaPhYjNYC/f25Nb0z7BSIil4y0RYNGy9n4dtIqlk0Shv7e62SKrgGvw1vcZUEJ2Z0fivEyo7nVmpNjAGLjCAPoYLUIQF0FayqDEGEMsz/Rv6AmI36FF+6I2ibd1uku7mZVuKrzI7O8XKp/q6u3ZXMNev5ZPkc8YurxEqS6cLrMKK6FgBlqbvJyMKlz1YWUcvAMTmQwiImFL2OiYvrbA28oT+EkniyaitHLA7eYbPN8sCR2OBd76AWSH6yHxhj73HmZJ0fYqnxvYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4326008)(5660300002)(107886003)(66556008)(26005)(83380400001)(1076003)(66476007)(8936002)(54906003)(316002)(478600001)(66946007)(2906002)(2616005)(6916009)(966005)(41300700001)(6486002)(6666004)(8676002)(6512007)(7416002)(6506007)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mCR+/hYEbY9gYr27tLfB3+CpQPKTwDCA9PevFZOR7V8NdV/EdXVijYN81il/?=
 =?us-ascii?Q?DhsKcWxxcHKivvTlDZgK4yILlRBg9+r9LOSm9JhO+BH0W8cBLbOrAsL+RaWr?=
 =?us-ascii?Q?RMHbIRDb+zPcz0QN+JeiZyOi3FiQSZMi5vUZMuTQQe2y/4Oy7qYgQfWWdrpn?=
 =?us-ascii?Q?3uy1JtBBuqKGE3/HD0eeMr7ayXSDI/FerosXSqNJs77khYkC/LlmxtUcSyuZ?=
 =?us-ascii?Q?26eTbzm+d0ugp7OHc5UUWpGLz59LM9SGFpbEFjmqyhGKjKrij1CL5mn/ln5f?=
 =?us-ascii?Q?Drx4uuuQFFLVoV8ZUJCeE4cAjJyFBhFiaw/oEJ53HbjHrGRPXv/i+hNgi4+9?=
 =?us-ascii?Q?nB68Yc2M2+fIPmk3KIuAku60nCjDvl7+17M9dHUrzQLY+c7goH8w1K0DjKCn?=
 =?us-ascii?Q?jPYYQbu9FlOR0Vpgab9UTmrboTOtkANJqGdvu5MYOGVeUkcHQusSOPZDpSyq?=
 =?us-ascii?Q?ZomsBCCod7ijvnd2AtSJQ/bunJhp6cAz5xDbtTUmnrHKtipOFYDFGyKxHQRz?=
 =?us-ascii?Q?2w5M6v0lp6VYwcvf2IJYOPffzotOR9i7RX9kSbyFgkgOC3X7ExEyJlSUCZXz?=
 =?us-ascii?Q?C60ysc6kK+YiTLSudum42HltQZyiN2T6FSSelb7xjGNhGrYgiMh89JCNJdwc?=
 =?us-ascii?Q?C4lXBWL7PFV+NySel4P08lIBOeyZdTqr60kttrHrUICMurWhhpPQqT4KHYqo?=
 =?us-ascii?Q?exRKrBqBEpsE0cl4IF+a6EJQRZqgJdYd84VA/fA0fKjWGlm5sBU7oapAHgqu?=
 =?us-ascii?Q?zWmczaMA91AOWr8iopwo7lR6oLHwVltXJ05tUS9w/+Xt4EXc5H32r6mH3PkO?=
 =?us-ascii?Q?++OZzfSC8Wf7PIMXm+QC/uWKRGbJweFaLeBKHF/PqltUi6OyOl14BThLQRMh?=
 =?us-ascii?Q?UZ1SkY7I5v7g6i93zn/oFyHeYiO6E5x9xY/4d/YSPNBDB9PHW6KLybmWJ8NG?=
 =?us-ascii?Q?a8WTGmxeDkTZFD4I9JAAfTDkcvxT50NQqldYDUZ0ZNlLxSsoiAK4Bv5phHx6?=
 =?us-ascii?Q?FtmpR69UeSQ6JWsUCuxILZJWsjl6/OevvWedg1H7PjPLp0tiblImGqPKS9Al?=
 =?us-ascii?Q?b48VhRlAKevxbaSj81czu7GoMKkoQqOdxGhMgq5JdfEnLGAXLjHbOauCsCKo?=
 =?us-ascii?Q?3UXv7pbwMrirh+ud1nwrp51NWzmFtGfo9Lu4hYb6nDz0XgaaTp6biJhb0W9p?=
 =?us-ascii?Q?W+C4D7ewQW3abJDfiqYcVl2jxJXZa6Op8H86hthwQEM7NeldIQF8rwr9x+/m?=
 =?us-ascii?Q?4JH1U6FqQuvfHsETv9uvkOKK1kCF5CW+bbunuFXDkLkQkXtuBWChoMAeoB+g?=
 =?us-ascii?Q?jIa6b4Emkv80uqwsHWAJbinF9Z3x53NAuJnjWrT7A1KBACco8U7UlLcwIzYA?=
 =?us-ascii?Q?YKTaF9AwJx4pDiKg3bdFIa04vrtdE9pHqSzSVEA4C7X5/DNKEtGbR0Y7Y1AF?=
 =?us-ascii?Q?EVtEMe07oGw1HgPnLdF6wsfOiE5YKOWAPFOufv4TrBWFRqP7KbVzp0B2YGvd?=
 =?us-ascii?Q?RjVBkk31dyrAlHLiXAXZcW5wQkic4cHNCKjfiRY2nnAqtP+SWS4Ul8U6sa69?=
 =?us-ascii?Q?amFEOlfCEjQGFoJbkZr9QDhX8e6TGUipMNRd5nPp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nrOP9css4HmjjI38M90+TihWeM1PlfoqM26vi5QvScPH3XOTinThUOSNOQHr?=
 =?us-ascii?Q?AmjPqRrhfJORX4JJha4JCnPs4IeklqBqQ/hwDe6MPtEuOTNgU2DJy+SGL8ae?=
 =?us-ascii?Q?HQ46dZZKAOdqiSSaWl7TQpo8YVsPjgeIxm0sqJsNmcbkcaFCrD5q1qWXQYLL?=
 =?us-ascii?Q?WZm+E+FgGNKj5QZSQ67x3ywEeV2i4ycdx3ME0RylcUFGk48U8RXE1701DHmc?=
 =?us-ascii?Q?INH+tAlBO129d1RH2IHms4XEuq9bFTfQv565mbjKOJh8qPzXQRK5pnPrImtt?=
 =?us-ascii?Q?3IG6a54c1u3/45RYbtRmtivLuc6Qcxk6VkZfU657gj597HCayu/Qu1ULuRmx?=
 =?us-ascii?Q?hovbv/nqH5BCQZLpfQ8pCx0hPqel6W4pCYCJORRkwZdXoweh8aOAganbTrC4?=
 =?us-ascii?Q?alv/OA9ncibTIcJzinv/HVxIlkoPEW+Ym6M8FJxHKcvIooqp2RbsfOg8D3qT?=
 =?us-ascii?Q?s0YqBHnl4fxRPIZJTJCBRXXwEjlJARHwYcNogMQNSr6bofegrqfzhd3YBxpS?=
 =?us-ascii?Q?D9zkXUVVp2xmOtVcL5sU2TZu6e8CcD92YLbN0JpC6gvYV7d3TU14fw1ciFVT?=
 =?us-ascii?Q?QDvlm4lNt4GPpKtdR99a+m6tT2nCt8Mu6OC8g3HCbJo/MnCj4F/P6XiP35gH?=
 =?us-ascii?Q?0aWr60lhIJtOTT3kD+0icDIi+P+IgysQ7B1ehiGPSUPvSUuh3qDR19Y5toXe?=
 =?us-ascii?Q?VLJOhFN092ypIop9vXUL03nHh3Epgn6EgNAgFSuulV1uspy3V+ZT80mmGFf7?=
 =?us-ascii?Q?UzAmTh5gVW4ZK6hgjkS6GEkONR8AlEfT+YbOd2EzelGBTYx5leN6R9vvSz69?=
 =?us-ascii?Q?7WhQ+XQBR1EUgGDcRf+6Pkfoi0f8/KHX1LYCZFKCYbyk2mbabScqmRJPFl+d?=
 =?us-ascii?Q?oZAmiFgmnRnBD19gyQ2/3PaFt9rnZpgYakIja+1ERwqJXlcz04p7q6txzLTR?=
 =?us-ascii?Q?2Q1PVtcOOFFmZ6zlKFyeuQ+JJUNXZcNMKJxo1vPP5Leb7LE+9qtOV4u+i464?=
 =?us-ascii?Q?n6+q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a58ee02-0b40-4400-5d04-08dbc046afa1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 17:16:43.0680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHX7smEAFyAJXyXrJ2zAkthRapqhD06pMMaHKCHYcwN10TnVROJsKQicJdL8MMuQiXL4VNgXNuYSFfNXLFYCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280150
X-Proofpoint-GUID: _dFsmhfqiwfKCdybeskL1k6Sx6TMN1k5
X-Proofpoint-ORIG-GUID: _dFsmhfqiwfKCdybeskL1k6Sx6TMN1k5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When merging of the previous VMA fails after the vma iterator has been
moved to the previous entry, the vma iterator must be advanced to ensure
the caller takes the correct action on the next vma iterator event.  Fix
this by adding a vma_next() call to the error path.

Users would not notice the effects as it would result in an extra
vma_merge() call if the first call ended due to an out-of-memory event.

Link: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Closes: https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/
Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
Cc: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b56a7f0c9f85..a4eb5a5626bb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -975,7 +975,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 
 	/* Error in anon_vma clone. */
 	if (err)
-		return NULL;
+		goto anon_vma_fail;
 
 	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
 		vma_expanded = true;
@@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	}
 
 	if (vma_iter_prealloc(vmi, vma))
-		return NULL;
+		goto prealloc_fail;
 
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
@@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	vma_complete(&vp, vmi, mm);
 	khugepaged_enter_vma(res, vm_flags);
 	return res;
+
+prealloc_fail:
+anon_vma_fail:
+	if (merge_prev)
+		vma_next(vmi);
+	return NULL;
 }
 
 /*
-- 
2.40.1

