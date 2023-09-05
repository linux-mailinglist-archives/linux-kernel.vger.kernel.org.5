Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E27931D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbjIEWPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:15:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC765F4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:15:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385M5LUF022229;
        Tue, 5 Sep 2023 22:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=kD+5+6lRS+WmcaTcyYQp1j4mXRbNeQvlqadhytjfCMA=;
 b=dncGjcj65VqnAWCe5rE4q6cDS53YT6xak90zR1ehT2UxUdL+/H4NB8F4vgC+wjQwHPE8
 /juEUDYBjtKhP+QZQcIMYHhukMrTGRZg+UwJI3kSDncBAzDsfFuRLnlre2m+2FAdd4P/
 3m1xumyk0GJ+5MzN19taxtJmBW30e2KLHs/Of2PmQK5ib+BUWsnQ8u88wYXq5rGltt49
 +So7GnNF8YwWU/ukYHrhbCR/aK2ekcnNx0BtT7MEmq+KBcj6sYyQDPmpk3gwUb9Iv5G0
 L/1jorMClF5Kaq2wXp1DntL+dOQ7Kk3oLvwlxSMGXZECYPI72WbFhxcwZi0W3e9wZrzo OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxctfr0rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 22:15:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385LUQ8X007700;
        Tue, 5 Sep 2023 22:15:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5d0sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 22:15:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e62GgQd4mzL8E2LW73eEDiy1AsM2VZQlhcTasA+dT0y1/0GUujc0r2Hg5w9AZqi1ZRnwUimiXF1hbAt4XGbthZ95HX8JRmnHhqT8eoDXf7x2akSjdIobuJcHYtmpPZXmjawMQqD6TFDMdVaXhHOo6GY9df+WU/6STawhFccy11Cp9P3TuL7Q46mYjJtP4SjjfE49SIltuZOFaMjkNZx+U3TSqwlag/iPcoo/zIqXD/TxzFMif5JqdAsLKNyc/DyPZH7nLU+aJBj4dBQxehcmk+tVS40byWZj9bSdRR9e0gs3+zkqdSpbq/LOpScV78vE8HtCQRgCRhKSMe+O383oWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD+5+6lRS+WmcaTcyYQp1j4mXRbNeQvlqadhytjfCMA=;
 b=M3FYlxD7J2D7iyRX2MknXNKPXPQcz60Y+WYwusNdA0wdJ/UIQTbNpz/SsEbrGYcJ9I5jPFyQtjrzqbPjcEgEq2/BtIrV4o6+5tu2fg4SQoV96+s6BgZG4KoTxkpUgsVbi/76cva4INi18TjSyecQgW+EmGdWMVzET3ZJ5ZoFt5cL4BCYA523d83dUYjsEAw+sB5fp1kng1V76LRn8oERB0iHTS7Zpv90+TXzEfFcF7D2AIgTbmTAW7P4Z5I0u7DMVOKb9iQdBKpaNL+2+luHP7vZf1RyjwfB17+DUA7Ky/Hp1YNGDS0R2VTYb/R2/dOTfSiWS2qQZRLoVrSYsyyqQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD+5+6lRS+WmcaTcyYQp1j4mXRbNeQvlqadhytjfCMA=;
 b=Q7Cn5u615GWQR2CNWV6YUVMLI8UgP6jPZch9J9WIOLDuCqSIk+OKqy15tt3qREebSLR9pG/qiGlTNu8Pd5V7DUhmx2Eu5EYd/Y9UAAurEqHp6GG0m35WdZv6TyRKqTf5rDYHcpGH8L47SzSz4EktZUPOPcOrBi0Ee0Xmi59+fSA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 22:15:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::864:27ff:9c9b:fc03%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:15:02 +0000
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230903081404.hmkhnrk243h2nuoa@f>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 0/9] x86/clear_huge_page: multi-page clearing
In-reply-to: <20230903081404.hmkhnrk243h2nuoa@f>
Date:   Tue, 05 Sep 2023 15:14:59 -0700
Message-ID: <8734zsb730.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f89b88-f8a1-4c06-1521-08dbae5d8ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvKw7TjZWsLkjVQxiL7s5kgaEMDX7lj3J9IcZhV3AZPazj8qCmc8Xk0t3ae0cZDz03MtIn9kALqGyjvhSdICNlk3ry/YG7KgFAQS11TCBDzrgx2NfmqlELgiew7bFjWwcjXzekgdGPiT1311p3/ve6NEu+nJxzvtcd/519nWPHPqFt255QoogewZPXha5KMvJYGPe2keWGiDaArmLZVGsX13DKaqNG5kXXLGBj+cWi59yoFXeiRjNqVNLYKTmYbw6b779ls32jp6keTR7zVR3AhflG6xQYpGIHWB4ABPlHMsfxYE4BPwL+SJJmD4gcxgEXfQpjn8bsQzDw2ejSlCgUPkzxaQPR34EO1BYO1DF1Wn8twRRPxSOoAJjOVDTc801bUYVKfKjnO9Fif0gqMfuv+scwjVI2wpX5FP3A792JJGY4FI7zmCcQ3xLhN1XuYNphriq37FiFMQTttmCWnfyGkSvD53j/RyAaRQIHmEgOHLiS0SzzHQg7BL1rVanX3770hXlSetafDng4KID40fs8m1VHGf+iBMDsh6D4i0lxqfkhFZSkXV8ngdEAnVtmHKbudx5SE54oH2Jf71TTZansGUPZUuagDwRTCcpk/k06c3VAqInPfRfRG7xGtMnu1gzXXoKEyCofFudIKtv2hXaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(1800799009)(451199024)(186009)(36756003)(478600001)(6666004)(6506007)(6486002)(2616005)(107886003)(6512007)(6916009)(316002)(41300700001)(66946007)(66476007)(38100700002)(66556008)(966005)(84970400001)(26005)(83380400001)(7416002)(2906002)(86362001)(5660300002)(8676002)(4326008)(8936002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VsCI4FG3W0kJi/1mI8DkVLHag6hEG27uoJw48e6WTmt2wM/EQhPaYp4HOxsL?=
 =?us-ascii?Q?Xhh3ajiIC7cXXMV2XbkIYdwd1LSu2ge242K+LWFokmh7nD571fUGaPJ3w+oE?=
 =?us-ascii?Q?f0KbrKpVnw2hb/shAxlX7EOzqRo2jQny7N2FMfkfVk0frE0WocVNNgDZjaFH?=
 =?us-ascii?Q?2HzreoxjaAtPQhmJC/iXVqL4Mm40fqJ24M5iHo+4+xqTJxqF3eOPZ8Pw7To+?=
 =?us-ascii?Q?M00drzmc1kRsKPIHQZV4pHDOMlaYPG9kRdFiGhZTOCU/IAC0qdJ1kvrG+bbI?=
 =?us-ascii?Q?alBPzY4pd5HHeWK+Gv5n0GRYzSXiibaFmbsVAO3AfPRSXh7wFET90X6inshy?=
 =?us-ascii?Q?xl35olrQ3eZlFT78p7OJ08+iyMkZEKym2aWEdekqL3utxfd8L51g0FRElFhK?=
 =?us-ascii?Q?fr4oN++2od+yfjdK+7izhfPYQnPYjtgVpX1QVbNy7K16hORS/LIT2zZOtEaC?=
 =?us-ascii?Q?wRAQrH1VBK5PgyQOCW2ZGMATAaQaolaNeTE13uj1wRiG3D4zai+8xaBUPrn9?=
 =?us-ascii?Q?ayRuJI2gZCidmkQHWZwTPZDn7VfIzYyv1rtBG5N3AyiuRMHILes6QPBI4OVQ?=
 =?us-ascii?Q?ZKYBIidOxvkDrKrQUGeQTdet/Ohxk5FBWCAtRaRs9fsYuNfvC6qo7XZuIQFz?=
 =?us-ascii?Q?VHL7RyR1c9iD7ctEkxkVrb2PTiA+JQ5c2CGzeHPrjUO9VkraVuPoDbpKjGHx?=
 =?us-ascii?Q?ktxvhbwc2/VFy00Ngzg4P1WsdP9mQTFoHDlRuqRuAj+z0z2iiaJ7FS5ZyeOD?=
 =?us-ascii?Q?f1zFiUEhkOCny8XiYY6+56tKBzbaNf/TiDSElfjUtfazlCa2qjBZ9RVIlpuo?=
 =?us-ascii?Q?nXai/Tu9ftcx1RPcFRd50BKCS22wLhTUtK+z6sRJ7XaoVuvFODUDZazdFSTq?=
 =?us-ascii?Q?PRFjKd+7Rt00e8bAca8dOBYSQ2ia5m7aPKzCWwXQyWndTjFlwpikaXHpN67k?=
 =?us-ascii?Q?/ciKl8m47ZN1m9v5sPhhwHTOB4H01Kkmi54m0zlPxO8xswiBj1A2XXLKNph5?=
 =?us-ascii?Q?wWiuvhYuotc2dlCOlU+FT/RormDdM5T8ziAXoQSupZSShPMEBlBdYt8jPd53?=
 =?us-ascii?Q?KZnK4+kTMVya4Zj9kh7DpkV0m0dK6j9+ieWGKDkU+ae5vs51/PjjfUwzAAuO?=
 =?us-ascii?Q?Y1kaS922QKbt3JprEfqw3v7q79FelRxF51lZsizirjlX7R9ARC2QJH3oFH+N?=
 =?us-ascii?Q?+X8IkhavjBkkwsBuSkZikTFlTaEfA86fupL6Xi0HrdAfY7qSmnmps3iznfVj?=
 =?us-ascii?Q?GPSyLRb2ebaJ79CaMWpLXLxiuPNH3AvagvGVzosLyXruWLDlZhxjcAD4heRF?=
 =?us-ascii?Q?MBwbLaFOIX5ADvlYu977RerqgZl4oXfK+gNZYHr1NlvnuqWyT+q/dXbUZp/8?=
 =?us-ascii?Q?HCgu3eRI88IWS0nffhEzc6cV2POop2AwxKCy+Aw9HVIXW9xcUqUJXw0vvc1K?=
 =?us-ascii?Q?F8u1ubwNHp+LYL3kYF+LDMXHOUaC5bU3beIOb1U7mtb/6jLlNkK+vO59QJoq?=
 =?us-ascii?Q?gAzyryB5f943F64dJFDL9JL1C9hGdLb4Pr6O23UFVM6cEFHvv2Mftpp0iIqX?=
 =?us-ascii?Q?d08M/Xzbb8ay9L31VEiXKrByaSwz9wNdoAMb9S8Won6Vscdwe7Hivni8FWwn?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fIhga3OkI/rT+1yccemdwO6aPt1RLlb7yIBTzn3My6V8pyBUi7mRVMvHXorT?=
 =?us-ascii?Q?pl7ybDNrdTCPAW4Y+lZvSooTU30E319pTO2QOgwYo14+NivHmSPHwFQr62Im?=
 =?us-ascii?Q?7TLkJ9SMjEqMI0WlUx1M9s2AbL71DVTny8CuTKoajxlJwLrC9tqJr7iWjV/h?=
 =?us-ascii?Q?NQc8w+Ps4Z+djdI+Y1pfxBXWTqcvNoH8xJOSA0fZgoHIy0kBnqw88Y55KG+M?=
 =?us-ascii?Q?srew9LHm28ODfQqKo40ygxy0+lIWf8Qp+46hL8VffM5ZVG935dbdaeqxw3k8?=
 =?us-ascii?Q?mGGti/M7RbL6CzJSwrpVkA02DF1GKRIb3aeSuodEVYqLzOWeK3E19hozVFx1?=
 =?us-ascii?Q?uuP0MKizjOeux2HujmQuaaEdtAcgrKjZktTg1n/zU3CNnK7e141mNT0saotc?=
 =?us-ascii?Q?8w+gfmVJpT9iOKEGEAzECGa/KPKjRD05xYAt/XKbP2w5sM3OilEhXuF3xLha?=
 =?us-ascii?Q?th8Qx7ShDd8tsrgkgqtESQt0oakbdsj5BbeQU0HWyP8uxM8dlRxWOAqiZaJ4?=
 =?us-ascii?Q?OOTlBrLnNhT/dWu6rs+9zinL5chW7DCvSgnD8esPN+aoRvqerAeKLBz7GtuB?=
 =?us-ascii?Q?uXO7YM291xNED1R+Vj6852Xo/TwILtljUcVz9CKvpNaeRJGs42/57qCWGBVm?=
 =?us-ascii?Q?WObHjOvoZ3d3PAYyutVM5zQ/gpOPD40XVKOCpfpzfdAJupjz2zzE0UDsdFvO?=
 =?us-ascii?Q?IJrqJA4vhCfoGV5/MrEIhL8JXfdU02mBao3b2dkNI28QXsLY/VzB9KTfy/aP?=
 =?us-ascii?Q?rEEaDeQshw4ruF8K/0UVhykpEgKoD3b3S70tUQ0QLgORbKLKIcBg+g1AkVZq?=
 =?us-ascii?Q?qesBuneTa5FI+LH+AztgJJ73EcF1zbsBdvIvy2aoO3CMx51x6LYqcmZtlbz6?=
 =?us-ascii?Q?AeC8gea2mYK4iW802SIvTq3nUDfa8unYJ4UekCpDdU+MXQE23o4+acbgj6w/?=
 =?us-ascii?Q?7MVXpTEP88B9Efx8J/YDa94axS2ILwjGg9u3DC0STm4vPnPEv2kkMTN5ueUV?=
 =?us-ascii?Q?tkVosvMrOLyhnO7ZmmDw9Ppdz0jRaQlIN6Q8NVWEn+YRU3G+TZuS3nOHl5t/?=
 =?us-ascii?Q?TrZOIOOzhS4nQHIO2tJXlTzDcfCSqvnSxujeBoV5u1ODqxV7FOShgm1KeFub?=
 =?us-ascii?Q?DqTpqMPOER9ch9yU/6U2ogh7HbuQR+BfBxUf/GfVxXDdgnF5QvUZCF4//SGG?=
 =?us-ascii?Q?aiYflJI966K5828a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f89b88-f8a1-4c06-1521-08dbae5d8ca6
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:15:02.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHySPASrkQXxh55X6J/3tie3HIcxbUHbdhfT5TpHl6BKt822+qj1iE2Thu/KcCZsJLS3uMj2pGYUF/DjiwjMGjmUTWG3gASp/br1mz/ub2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050193
X-Proofpoint-GUID: iIE0uN9xfYxjzX48586td8yVhBujYc9_
X-Proofpoint-ORIG-GUID: iIE0uN9xfYxjzX48586td8yVhBujYc9_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mateusz Guzik <mjguzik@gmail.com> writes:

> On Wed, Aug 30, 2023 at 11:49:49AM -0700, Ankur Arora wrote:
>> This series adds a multi-page clearing primitive, clear_pages(),
>> which enables more effective use of x86 string instructions by
>> advertising the real region-size to be cleared.
>>
>> Region-size can be used as a hint by uarchs to optimize the
>> clearing.
>>
>> Also add allow_resched() which marks a code-section as allowing
>> rescheduling in the irqentry_exit path. This allows clear_pages()
>> to get by without having to call cond_sched() periodically.
>> (preempt_model_full() already handles this via
>> irqentry_exit_cond_resched(), so we handle this similarly for
>> preempt_model_none() and preempt_model_voluntary().)
>>
>> Performance
>> ==
>>
>> With this demand fault performance gets a decent increase:
>>
>>   *Milan*     mm/clear_huge_page   x86/clear_huge_page   change
>>                           (GB/s)                (GB/s)
>>
>>   pg-sz=2MB                14.55                 19.29    +32.5%
>>   pg-sz=1GB                19.34                 49.60   +156.4%
>>
>> Milan (and some other AMD Zen uarchs tested) take advantage of the
>> hint to elide cacheline allocation for pg-sz=1GB. The cut-off for
>> this optimization seems to be at around region-size > LLC-size so
>> the pg-sz=2MB load still allocates cachelines.
>>
>
> Have you benchmarked clzero? It is an AMD-specific instruction issuing
> non-temporal stores. It is definitely something to try out for 1G pages.

Thanks for the suggestion. Been a little while, but see the numbers here:
https://lore.kernel.org/linux-mm/20220606203725.1313715-15-ankur.a.arora@oracle.com/

> One would think rep stosq has to be at least not worse since the CPU is
> explicitly told what to do and is free to optimize it however it sees
> fit, but the rep prefix has a long history of underperforming.

I agree that historically REP variants have been all over the place.
But, if you look at the numbers, REP; STOS and CLZERO are pretty close,
at least for current generation of AMD uarchs.

Now, current uarch performance is no guarantee for future uarchs, but
if the kernel uses REP; STOS in performance paths, then hopefully
they'll also shows up in internal CPU regression benchmarks which might
mean that the high performance persists.

That said, I think using CLZERO/MOVNT is a good idea -- though, as a
fallback option or where it is better to send an explicit hint while
say, clearing a 2MB region.


Thanks
Ankur

> I'm not saying it is going to be better, but that this should be tested,
> albeit one can easily argue this can be done at a later date.
>
>
> I would do it myself but my access to AMD CPUs is limited.
>
>>
>>   *Icelakex*  mm/clear_huge_page   x86/clear_huge_page   change
>>                           (GB/s)                (GB/s)
>>
>>   pg-sz=2MB                 9.19                 12.94   +40.8%
>>   pg-sz=1GB                 9.36                 12.97   +38.5%
>>
>> Icelakex sees a decent improvement in performance but for both
>> region-sizes does continue to allocate cachelines.
>>
>>
>> Negative: there is, a downside to clearing in larger chunks: the
>> current approach clears page-at-a-time, narrowing towards
>> the faulting subpage. This has better cache characteristics for
>> some sequential access workloads where subpages near the faulting
>> page have a greater likelihood of access.
>>
>> I'm not sure if there are real cases which care about this workload
>> but one example is the vm-scalability/case-anon-w-seq-hugetlb test.
>> This test starts a process for each online CPU, with each process
>> writing sequentially to its set of hugepages.
>>
>> The bottleneck here is the memory pipe and so the improvement in
>> stime is limited, and because the clearing is less cache-optimal
>> now, utime suffers from worse user cache misses.
>>
>>   *Icelakex*               mm/clear_huge_page  x86/clear_huge_page  change
>>   (tasks=128, mem=4GB/task)
>>
>>   stime                        286.8 +- 3.6%      243.9 +- 4.1%     -14.9%
>>   utime                        497.7 +- 4.1%      553.5 +- 2.0%     +11.2%
>>   wall-clock                     6.9 +- 2.8%        7.0 +- 1.4%     + 1.4%
>>
>>
>>   *Milan*                  mm/clear_huge_page  x86/clear_huge_page  change
>>   (mem=1GB/task, tasks=512)
>>
>>   stime                        501.3 +- 1.4%      498.0 +- 0.9%      -0.5%
>>   utime                        298.7 +- 1.1%      335.0 +- 2.2%     +12.1%
>>   wall-clock                     3.5 +- 2.8%        3.8 +- 2.6%      +8.5%
>>
>> The same test performs better if we have a smaller number of processes,
>> since there is more backend BW available, and thus the improved stime
>> compensates for the worse utime.
>>
>> This could be improved by using more circuitous chunking (somewhat
>> like this:
>> https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/).
>> But I'm not sure if it is worth doing. Opinions?
>>
>> Patches
>> ==
>>
>> Patch 1, 2, 3:
>>   "mm/clear_huge_page: allow arch override for clear_huge_page()",
>>   "mm/huge_page: separate clear_huge_page() and copy_huge_page()",
>>   "mm/huge_page: cleanup clear_/copy_subpage()"
>> are minor. The first one allows clear_huge_page() to have an
>> arch specific version and the other two are mechanical cleanup
>> patches.
>>
>> Patches 3, 4, 5:
>>   "x86/clear_page: extend clear_page*() for multi-page clearing",
>>   "x86/clear_page: add clear_pages()",
>>   "x86/clear_huge_page: multi-page clearing"
>> define the x86 specific clear_pages() and clear_huge_pages().
>>
>> Patches 6, 7, 8:
>>   "sched: define TIF_ALLOW_RESCHED"
>>   "irqentry: define irqentry_exit_allow_resched()"
>> which defines allow_resched() to demarcate preemptible sections.
>>
>> This gets used in patch 9:
>>   "x86/clear_huge_page: make clear_contig_region() preemptible".
>>
>> Changelog:
>>
>> v2:
>>   - Addressed review comments from peterz, tglx.
>>   - Removed clear_user_pages(), and CONFIG_X86_32:clear_pages()
>>   - General code cleanup
>>
>> Also at:
>>   github.com/terminus/linux clear-pages.v2
>>
>> Comments appreciated!
>>
>> Ankur Arora (9):
>>   mm/clear_huge_page: allow arch override for clear_huge_page()
>>   mm/huge_page: separate clear_huge_page() and copy_huge_page()
>>   mm/huge_page: cleanup clear_/copy_subpage()
>>   x86/clear_page: extend clear_page*() for multi-page clearing
>>   x86/clear_page: add clear_pages()
>>   x86/clear_huge_page: multi-page clearing
>>   sched: define TIF_ALLOW_RESCHED
>>   irqentry: define irqentry_exit_allow_resched()
>>   x86/clear_huge_page: make clear_contig_region() preemptible
>>
>>  arch/x86/include/asm/page_64.h     |  27 +++--
>>  arch/x86/include/asm/thread_info.h |   2 +
>>  arch/x86/lib/clear_page_64.S       |  52 ++++++---
>>  arch/x86/mm/hugetlbpage.c          |  59 ++++++++++
>>  include/linux/entry-common.h       |  13 +++
>>  include/linux/sched.h              |  30 +++++
>>  kernel/entry/common.c              |  13 ++-
>>  kernel/sched/core.c                |  32 ++---
>>  mm/memory.c                        | 181 +++++++++++++++++------------
>>  9 files changed, 297 insertions(+), 112 deletions(-)
>>
>> --
>> 2.31.1
>>
>>


--
ankur
