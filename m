Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA3A7ACD34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIYAlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjIYAla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5FDCCA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OKqRiP013276;
        Mon, 25 Sep 2023 00:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=RRqnSj9V2V9kQEWWcxwgMfag+uHNl9i5WXsEUMojxeE=;
 b=wtvFBpcP7X+6b76qtOKdZt38nhZV684R5yUlpkX51gjUTJwU7cWTGL53QjaI0XiOSjUK
 +uzUq5YAbISYgIRU14NfKAGQ8mJOkuIP/guJLNZV9PWfs4BlsOC5kR7okVOKm5a/7ahe
 acAVo3WTbjWBnBK4YljZDjNX+og80nvocjbIbLIpaieCLo9Yr2tMVGDt2Yn+YHd0SyMk
 qOTWYtjx9fEA8orUd5qYuvQWbbSORaoENUKKO9UjMEi69oV1s4dy/1HbvYMvlD1vLY7m
 hkyC8YBoSI7c3I9VWjJhkhh7npctcoFkJLkTjnp1JTRUL5AdXY0Xc7V646UL2rJO5RUz bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbadqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ON0wxH030950;
        Mon, 25 Sep 2023 00:40:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf9usgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhKuE1OpGeKbr3tTK7lrTkBEvHzzmVOnp4eb5vF/3QBh9/c0TBKh+W0o5h5hzwS/t+i4NSzi01V8xBm07rxHIBpDgMWbdM3gAQmPPUP/NS/1MoBMb6BF0ybyHcc0ijNGsXVo4bErCz1qLffphl8DSFO7BqwYC4wdgdO1G67oBYCEpjv9Sp1xWX+Zm4B7sk/yGU76Q7RoytS2RSPe1q1f+vNM1aFrKyf7wR9BsTchMuoMUdEmBGwuFkSOtAxzksvf9Bzs6fH1UvaFcLrPj9Zz/Yk74cenmju4jrXiCAEX1KDd5GlEL6Twr+PMCNQ0gof7z2P2ceoH8jzRHGkllagsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRqnSj9V2V9kQEWWcxwgMfag+uHNl9i5WXsEUMojxeE=;
 b=FgbIVfKYBpE+vCxE7lWhwjlsohd1TYXgg3FZYIKdvc7wNvE9vQRoa/TiawOlx/zDXy6Djjtm+cfqAzh3Gt9Uo3bGjdaGkEQeLUx+K1zXZRVUz9h9rgBRu4bCgOkKPfq95rm1cbfoh0wzJVRSOZP/teVNgsJ3AUYnmeIDXOJ/cjR3EKJmOwinDJSk0izmuPr3cirbyaIOWOqepAtbw8Wzo38IYmKcg1Zs94h8ND/Zee5HMclyWUzJ6Vjj2RXj1I8Hh10m13PPehbNL3lA5W1+AJo1w6YmihnYaIxRQ0Za1vovEANmpD9/YdHYct5E0AZQHLxLkVH6ireVjGUmTcnyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRqnSj9V2V9kQEWWcxwgMfag+uHNl9i5WXsEUMojxeE=;
 b=mAc5Gxuns37/uGSbKerPv0LLUqU8v1VGe99JPmcyr7GmKXQ4fvrJzLMWleWgKoNDlv7wOsOzaDFWH4ISA+DKIC5tKnJsOh472gi9b83RWxpkL5moyVU+zW1Xv5vhgqx+kKK+UpFStMKblMogE/bpJOZuEgVJjsrPJK8A+6/s3dg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v5 4/8] hugetlb: perform vmemmap restoration on a list of pages
Date:   Sun, 24 Sep 2023 17:39:48 -0700
Message-ID: <20230925003953.142620-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:303:dc::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f83b1df-a9fb-4670-b7d3-08dbbd600086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nldle0gaFOlSlBMEZtHmUqn8SWuHUezdGLIDMhK1YKcwKKOytRZf/CMIjQ+qKsZ3+EednyA8mvtfko8S+weBfsUthtRXG49o8Vlc7eSMSbZunbPPWa95vBgkG7+i2DiGcjHubR6c6+ZdWk7oKRo3IYtVMBhE/QPQZ5Mr1eM9ltiIii/H1BkXUz5ke6d6ZSY9w4CjShAmZTFTq49JB1fiY97gCeSg2w8IZBdgV2yuGgthk+DDE+jn6h4aN1KDmvzLB0sFS9mPqSEObcTbKaEQx7qpGMbeSjKOpVakRwu4bigHcxMWq/9A9XAdq/P6KInZrybfj8qOanGo3Wt72+L+/chdGWWHCEgBwGuNM3ASDMASzp3HqBwDfydztmlZ4GAKOk0JCBP8OLBzqGNUYS2VyVZN3bgvlIkme5eqirWN4D9Yu8Pzl+WWHpx/rZxbL7OSgsVxGsKuFj5e9zb7x7S14t9c4PtaWA25A7q03gICvjeorLliWs9ymL1epKfjIfNB9mbCLwCJGzZoZIcA/9xi5v2k+oLER+N4z3w2+9dgxFAdWIQTYlEm3/N2dl3wLmgH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uFjQq2jS7U2YH8zJM5Ssw1feLmf5lBhPeM6ySlWLFJNu/akuQPH46bQAPOM+?=
 =?us-ascii?Q?A9xb7cGe+9FKHHIHLA0zLJ9VW2o5Hl26dYsZKbcbf2s1VdneEFuAMf5iyTMB?=
 =?us-ascii?Q?5syROlxYVI51vRJATtpNfRNoEts0FG3tOjH251LR8tTl580hdBybRC2QPuz3?=
 =?us-ascii?Q?BM4RBZXrHjLucAgiyoVYcReD64qU3o0q3tNtOkhUtwBK0mTEQDOnBqwwBD5+?=
 =?us-ascii?Q?7e7IaU7LX/SQGjlI4RUx3iV/iBvYD4XG5V02P5PBW4uB3vDwqpkMawCK0oYF?=
 =?us-ascii?Q?fffct/QIo8gfXEI/TOTyzULOggg6VnOSM3DqE+8ya5KhOC3Qscj5vwsYonkU?=
 =?us-ascii?Q?Kj2M9cVjyrOBx8ZzlxXQ7LpIqHp4puiZTsSDngwD/GHa0Pnf6Fri5PUWd79m?=
 =?us-ascii?Q?UzaSlrikczrYkyb96N+WZKvI4KQsgKe/eOujjITW73Fg3z7Zpq8RFATfLc6K?=
 =?us-ascii?Q?Wi5IP5Wtb2vjlxS2fVAohY7Pp0vQRLj5S6Sn8XczVWLOL09P+lxekL7rGL8z?=
 =?us-ascii?Q?TPcud0I3Vf4vvlQkFpzSQ2yfQAXLgEEXSdpVT7MAdNdJHZ3OtEaTXeCRZDEe?=
 =?us-ascii?Q?+eCVcXK3ZfkE0J3ZfVi1FUfb9iVWk8GbSPyF2cU/ZRD8poRvnI6GfdBDP9vz?=
 =?us-ascii?Q?6bJY1NHePzv9qNYAORKNH99GdSHHCx2bIeEk/i7+2ErUvYzAdLikDcprIkED?=
 =?us-ascii?Q?U+6DUz/U8IjlTlJzsWkxWO6zFCgpsCsUF9CJ0F0x4Sx/ZsQnAZQosSjCvujR?=
 =?us-ascii?Q?H4NryeNOlS4KI+eG0uQwro+elLnUsx+09V0hB6iogr7b+Embm1KVEIk2rCox?=
 =?us-ascii?Q?NnJCyYn1nmAffATmQnxRIJ1XPKTcDLnfZXoLjhF5LZC9Ldh31gXKvFWQh1q4?=
 =?us-ascii?Q?+xKjSjq7dyv03xKuw7S14W6WJQERmmSPy1XgYDS/1xaOGYiL9y7ZO1m1Em24?=
 =?us-ascii?Q?lyv4xN3sAmJcH8sbEjoLIG4dSvj3GhymmQsxy/mDK4pFBtPkMEC4uCkMkITC?=
 =?us-ascii?Q?NR/bQ7eE1Sit/PP9YlmlKy+BW+rRYdoubde5vF0aCGPMzplT5h5gVzYNAfXJ?=
 =?us-ascii?Q?3glGsP9j37Fbw1d74XFCozr4AI1jdv54mFhYRYssXQGyDGhaSYlzT9mjeS3p?=
 =?us-ascii?Q?gz5PTOrg/8ZAsqr7iVVKV3Pjde0liYxXy2TLqgXO9G86yEESg2fZXEWpHnta?=
 =?us-ascii?Q?Ry45t21nv1BhubQ6PGK+3TphLvQrWPzEpgbSFeQDAeOIShg4dJadw+zqijuh?=
 =?us-ascii?Q?JQmoO131WTBmyorKTQLtP/j+ZSwphGTLqTvzcTi4dYjvFd4LNYfag5Jf0QAu?=
 =?us-ascii?Q?RY7ELaihJgfkEkUVvj+Bf8MWpjT6TiHldb4DfRuN7nQrIeFRFn1SpsHgw59H?=
 =?us-ascii?Q?eRjCL/DJDzzEi4+0cCX+02zZS3GYZPHbZoubl6nDQM+6AiHvZaGygl93l/NI?=
 =?us-ascii?Q?CwJ2YMhMBZPhuEv88Ay6q2hK2mJYJ3geOJdPBGrPlGLZleWt9MMWP5vAjSWr?=
 =?us-ascii?Q?JNwSuRh83cgmFhmw0qUz51KYEd54r0RxopgZBtbCc0RkF77Ld1/H4AWFqVQy?=
 =?us-ascii?Q?rP/XR6NLgd868suow0ldfyXeYEpJuFJikVQ1Dk8k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/gnYhUnuXgNiVlt1bj9WPxHb136/wpVHv/5uxoRVdmrqitxGlhgfDkR3K4Sc?=
 =?us-ascii?Q?k0T2SEIqUu8t3TrWT/OzfXk+XfAwVQaLiAwxCNjfJETmItSctw1kYjoxedLE?=
 =?us-ascii?Q?qrEYumJy8rdCQdrQVBOj0axGEiQjsM+oFMx9Th/bnp2ZLUckZefmi6b7pFPI?=
 =?us-ascii?Q?LkYQWp4cNxntGGgUv2LWaeahxGTw8cdl2IAIZ2kgP7uorqmEkmP/U2oQt913?=
 =?us-ascii?Q?m6jM95TzICTeoR2y+yZ8Y6xcow5q01touW7+2ZAAySM64ZR79RCf2sCEujc4?=
 =?us-ascii?Q?Jxl6SU1iGw900OeQqqKpIzDyfxMKyKBhAmyUqXluwKotcQcqNqy4XzCHHDE+?=
 =?us-ascii?Q?vZa7CdUxH3I0HszcWgPzt9dlujY+0WGy+2zAzQvNBz0gf6j6cC+30vMnP8jg?=
 =?us-ascii?Q?rG21V7tZ5H3ZsvGKtBMdiUOGBg0vHIfj18xXXVmbGAtb5z/L/pVMriddRmea?=
 =?us-ascii?Q?BMhRQz21wTcr3c4kBRlMBgsmOyWJXvqqLzpnKFyJXZ/eo27lcBUGWi1RIpAL?=
 =?us-ascii?Q?XB0YjGcBIPLR4oc7bexuAttSjwGFGAKPzeEHBGUEgy3iMgyySo3In8QRaVe+?=
 =?us-ascii?Q?INEKvuSVn+jhIxOcvPvReoXbOCs6zC7Z7JMY0nS55Zz5d6X7S+61RIwsgQ1g?=
 =?us-ascii?Q?6VQ5DecHOQo3PWrwUQNg/6/NEgmbMd6RPZxiGNJw0oQbMESEK8a3WSLKqrBT?=
 =?us-ascii?Q?b+ZtAwNZKYRpeosl6z/1Qq+CU/l+STa30CipBjfZYP6NZOliob4aeN3QaI52?=
 =?us-ascii?Q?gROpNMh7eWihcblAwwFOXcmf2VPP9Ycsxd44jd1Z3kFOKOfCPgztJzYtVnGO?=
 =?us-ascii?Q?Z4B0Pjy5DzUD5Q/7Wg1xyqsYk3LfKSMq5OCHeF7fLZ2fLKguEvomw8dO1xkC?=
 =?us-ascii?Q?hzbJYAesVpFJ4OlKXiVWMjvv9wYyoXs9AOwHMLOEXlL6N1LnJ2JsEzdhB+WQ?=
 =?us-ascii?Q?a2YNTJDxwQhcLNuJjpoHVNJUe+/IizNMfvxem+vp7bRctxL7Qx2sm3jmcSYY?=
 =?us-ascii?Q?Rj29NPvCau7bZhQcmXTPvabdmJtEvVY18zRS8z4r9QdavNLAnx4Il1XVJtqm?=
 =?us-ascii?Q?N1w+LbSWZc2xAEyVLNj1xXBXW0btq7I/E2wRBQECx9JSSSLlWH3hpWSCHw9J?=
 =?us-ascii?Q?b/3BllfWq2zc?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f83b1df-a9fb-4670-b7d3-08dbbd600086
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:22.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqm59EcUGTHSW0AKAIxjrin7LwuGtlEng0r7wmiW7BTQuhdE1cuC/HOLXsTOyKhD3KrfXn+tZWHqJ5PHilaiWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-GUID: Eb5O6Y-A3RZ-PuDzE7UVSIBLQgGwsH7h
X-Proofpoint-ORIG-GUID: Eb5O6Y-A3RZ-PuDzE7UVSIBLQgGwsH7h
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The routine update_and_free_pages_bulk already performs vmemmap
restoration on the list of hugetlb pages in a separate step.  In
preparation for more functionality to be added in this step, create a
new routine hugetlb_vmemmap_restore_folios() that will restore
vmemmap for a list of folios.

This new routine must provide sufficient feedback about errors and
actual restoration performed so that update_and_free_pages_bulk can
perform optimally.

Special care must be taken when encountering an error from
hugetlb_vmemmap_restore_folios.  We want to continue making as much
forward progress as possible.  A new routine bulk_vmemmap_restore_error
handles this specific situation.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 98 +++++++++++++++++++++++++++++++-------------
 mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
 mm/hugetlb_vmemmap.h | 10 +++++
 3 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da0ebd370b5f..53df35fbc3f2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1834,50 +1834,92 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 		schedule_work(&free_hpage_work);
 }
 
-static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
+static void bulk_vmemmap_restore_error(struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
 {
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
-	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+	if (!list_empty(non_hvo_folios)) {
+		/*
+		 * Free any restored hugetlb pages so that restore of the
+		 * entire list can be retried.
+		 * The idea is that in the common case of ENOMEM errors freeing
+		 * hugetlb pages with vmemmap we will free up memory so that we
+		 * can allocate vmemmap for more hugetlb pages.
+		 */
+		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
+			list_del(&folio->lru);
+			spin_lock_irq(&hugetlb_lock);
+			__clear_hugetlb_destructor(h, folio);
+			spin_unlock_irq(&hugetlb_lock);
+			update_and_free_hugetlb_folio(h, folio, false);
+			cond_resched();
+		}
+	} else {
+		/*
+		 * In the case where there are no folios which can be
+		 * immediately freed, we loop through the list trying to restore
+		 * vmemmap individually in the hope that someone elsewhere may
+		 * have done something to cause success (such as freeing some
+		 * memory).  If unable to restore a hugetlb page, the hugetlb
+		 * page is made a surplus page and removed from the list.
+		 * If are able to restore vmemmap and free one hugetlb page, we
+		 * quit processing the list to retry the bulk operation.
+		 */
+		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
 			if (hugetlb_vmemmap_restore(h, &folio->page)) {
 				spin_lock_irq(&hugetlb_lock);
 				add_hugetlb_folio(h, folio, true);
 				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+			} else {
+				list_del(&folio->lru);
+				spin_lock_irq(&hugetlb_lock);
+				__clear_hugetlb_destructor(h, folio);
+				spin_unlock_irq(&hugetlb_lock);
+				update_and_free_hugetlb_folio(h, folio, false);
+				cond_resched();
+				break;
+			}
 	}
+}
+
+static void update_and_free_pages_bulk(struct hstate *h,
+						struct list_head *folio_list)
+{
+	long ret;
+	struct folio *folio, *t_folio;
+	LIST_HEAD(non_hvo_folios);
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
-	 * lock/unlock for each individual folio.
-	 * The assumption is vmemmap allocation was performed on all or none
-	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 * First allocate required vmemmmap (if necessary) for all folios.
+	 * Carefully handle errors and free up any available hugetlb pages
+	 * in an effort to make forward progress.
 	 */
-	if (clear_dtor) {
+retry:
+	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
+	if (ret < 0) {
+		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
+		goto retry;
+	}
+
+	/*
+	 * At this point, list should be empty, ret should be >= 0 and there
+	 * should only be pages on the non_hvo_folios list.
+	 * Do note that the non_hvo_folios list could be empty.
+	 * Without HVO enabled, ret will be 0 and there is no need to call
+	 * __clear_hugetlb_destructor as this was done previously.
+	 */
+	VM_WARN_ON(!list_empty(folio_list));
+	VM_WARN_ON(ret < 0);
+	if (!list_empty(&non_hvo_folios) && ret) {
 		spin_lock_irq(&hugetlb_lock);
-		list_for_each_entry(folio, list, lru)
+		list_for_each_entry(folio, &non_hvo_folios, lru)
 			__clear_hugetlb_destructor(h, folio);
 		spin_unlock_irq(&hugetlb_lock);
 	}
 
-	/*
-	 * Free folios back to low level allocators.  vmemmap and destructors
-	 * were taken care of above, so update_and_free_hugetlb_folio will
-	 * not need to take hugetlb lock.
-	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
+	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
 	}
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..77f44b81ff01 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,44 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:			hstate.
+ * @folio_list:		list of folios.
+ * @non_hvo_folios:	Output list of folios for which vmemmap exists.
+ *
+ * Return: number of folios for which vmemmap was restored, or an error code
+ *		if an error was encountered restoring vmemmap for a folio.
+ *		Folios that have vmemmap are moved to the non_hvo_folios
+ *		list.  Processing of entries stops when the first error is
+ *		encountered. The folio that experienced the error and all
+ *		non-processed folios will remain on folio_list.
+ */
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	struct folio *folio, *t_folio;
+	long restored = 0;
+	long ret = 0;
+
+	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (ret)
+				break;
+			restored++;
+		}
+
+		/* Add non-optimized folios to output list */
+		list_move(&folio->lru, non_hvo_folios);
+	}
+
+	if (!ret)
+		ret = restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..0b7710f90e38 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,9 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					struct list_head *non_hvo_folios)
+{
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

