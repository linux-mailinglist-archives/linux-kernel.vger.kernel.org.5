Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AEB7A560A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjIRXDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjIRXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:03:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C71A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:03:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IK54so016895;
        Mon, 18 Sep 2023 23:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=BWivTdclf8bs60R4j/VxalnwEUHa8h8JPsQCF9s8r64=;
 b=mNZLYlDzSNdNUymitkNgZIaEXQj0/ENQKa2WPxxXL0Flk7dePnuGw6LB57IJpmKZLwnY
 X53EhVQAbmLsWA9cL++VjNU7C3mxTbFu7l9ADLMxHYOYy3rJji6u7FccrHvVSwKQJLF+
 9v2cXhkOZ3IzO8OAc/lHAW326GjdkMkjgxihiJ9LXDmGDCSEIY9FDXDsGiQYpN8fXVA0
 mX/DOwgRIDIM98GYvO3a6vOtwb/Ljx7NEx7URKSCfhk3VGZ8sHVznvEbnEsUWBZCa+sR
 85XXFOgWegej4Eww3r+Qiu+2fuhZEl8EgQHLnsxVDc0mZowHEHSrTKyS9UIvLAUVPHMr oA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t539ckqdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ILd3Hp002093;
        Mon, 18 Sep 2023 23:02:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t4nvst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 23:02:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApJVODDq9BDEokprNzEYZo6sy+iR4Axlbw0Czqc115d5XRqbo/4by8HnQ1ncJH2yH0GjGNAIliOUIioLxie2jcDaVKGbA0pmZ6VuxLUcjki/WYdnK8NNRTmjvJGLbutAdycgw1Jui/iPaSHFyv6OWXu95IOxTl35rZSPOhIrEiiCh2CPZHYn6NUwf8CsuH+3gFFRz3ItiAmZa8kqrqqkAQucXCSX5P1/EJusCOobjOgGcuBpYJNsxvMrGoqKkSTdgNavmO6LuMmDnWoK5i1Ad1WVhgsC8pbCIuEhbuputiXIKzqad0MBO9fyl/fyzbqnSPSQxJtRikfkQyYFsx8ZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWivTdclf8bs60R4j/VxalnwEUHa8h8JPsQCF9s8r64=;
 b=CfgI0pbtzXVFoj775F88Iz4oc6cgTgBfU1TwRbe/acgHGi6JXps7lQg+//M1f4KcMBRE/1eyimzH2D0tROC6e2hcbQfKOAui5OH/3OvPLySVoIlihDJQTgmxIqicNF9BeU36sjbwVjJI6W+/I/OnfDiTJ3vtA9AYOZMNkIz86STtxiYLUq5dcIKRo7rTR7l4W4i4gtUGz+qie8tK4HDCxe7vg8vGPNI/iAByHjRwksIoCX/bknDjL10vSj8frOdgaTIs0JVQLCrIVJzo6hE37feOReBO5nr1bB9PBFA+ow9ybCXjoFXVf4ywtes2EmabU19tctcwxcUIag5XGckYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWivTdclf8bs60R4j/VxalnwEUHa8h8JPsQCF9s8r64=;
 b=rxY4KSbXLPw8ThuEE8P9mWy1aJCfHDvceCuqa7unZ6RMBv4YwLm7fMQNctIf8/CvEYFNj5+gue9YYdvM0GOguSo/uLRAxDRGnK72MSM6ODiaOen0VJ8dWgKmZmheBbbufItUBox4fXDIfzG/Z/Y1Yr2jO8GH7z28WctOI8l4utU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7494.namprd10.prod.outlook.com (2603:10b6:610:163::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 23:02:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 23:02:18 +0000
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
Subject: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of pages
Date:   Mon, 18 Sep 2023 16:01:56 -0700
Message-ID: <20230918230202.254631-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918230202.254631-1-mike.kravetz@oracle.com>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:303:16d::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6d6849-bf11-4b80-39ea-08dbb89b4e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bI6NVzmRyDzBo/+DxRqI4bUUFGxcIZIG28cZgS/SXLoafxyySJXxUDN3K1xZZbZNPA17Q9r6lXIuEeS3Jtk0Wh9qVFcMVhUJlxMa6mbt/NWQOE+QDKyl5+a0wLTwk/2GoqVRqXMYTssUk7InqEszkf8Fww2YPBlqpapunmeB9vf8//7wjGaqPMouGe9lIzcNRTu4vpcXmLyrgo/qdchxEyzjbA1naMAWbVHT5SjzWpO7AeeVNYWniT2z238xt3KuEXXPZ+g/egL/TOVtOII7xBGxwoiEw9jWSUCeTko75THNxVv+JYGiZkxaqr9qLQnxS1wUIWZj+PWb0jOhB417olX+udSG+/+L8NxP5A7rl00LtnLMHmVacnFDMw5eZgPEB5kn1DXswzg1WPrcTJAsMxIS4A76CVj0byMshvPiiLJVS7wahpFm0nZavsIXjYUxpm6DyYc7ZuID7s0FxzakO9u7i2RvvDQ63OUdAk9+IZ9sy/d9XeWBYhEsTA+b3PEN46dNIZOWWpA90iJhJjxtWUUkgtQ57S9g/+vhEVxx4gZSru/kmYk77DQO+1mk+gv9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(41300700001)(316002)(66476007)(66556008)(54906003)(66946007)(478600001)(6666004)(38100700002)(7416002)(2906002)(86362001)(36756003)(44832011)(5660300002)(8676002)(4326008)(8936002)(83380400001)(107886003)(2616005)(26005)(1076003)(6512007)(6506007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?woXV4yv4uaHRgvkrkBmRJsRElebY1wp3kKfNQy118eckfvGwzIJPVsc92WI8?=
 =?us-ascii?Q?wscCu8oIn5db+VYT1Y12OZl39Ek1boQmEd9W/B5NMRBokPGCgHBCcDpG/HgR?=
 =?us-ascii?Q?UVVezfAwEpW0t1ePy1ERtPzz6+RYpO5gX33bqI+lpn6aONv+ey0noLHDJ6YY?=
 =?us-ascii?Q?i0GMf0OsEGE+LWwc64Jiv81yn2LVzAnn+rmUPx0OR1mwrha3BkMMYj7RvExl?=
 =?us-ascii?Q?kWBr5CuNDOkHxUKWv5mCH34ZZ+jHdkT3W1LEsLFtcPKA00JyBnKzz0s6Tymd?=
 =?us-ascii?Q?g0OTS/Ggu42Fa8CtHkEasIzkEG3JgorB0X6bRlvs9GS0ToAK0wPKSAR1TFxI?=
 =?us-ascii?Q?xZMgaae0PlhnRwfBQF4MDBeO4hLFKOK5CjgxzqOVFftYcdlf3UOnAwsuhF+N?=
 =?us-ascii?Q?9Kp1783LpwVBOxB2RMortv5BWW+scHyqXzKOinCqbsWlYuPpf9/d4pyUejF/?=
 =?us-ascii?Q?CWxBxahiObDiNkHimWZgbtQRTZ7Jede3P3Vap9gUniyoLIrptLabRfKNXl3p?=
 =?us-ascii?Q?kwZKymq4vJgOommICqNeKvxZK4rJI4xXN9BGe0mIR/5SuVH1o1X3YrFUIGsb?=
 =?us-ascii?Q?sSQ7urlFWoteSHt4amGImiafLOEKa50BAXnDals7G8AFcebZuLFV5Hxi1LOG?=
 =?us-ascii?Q?UblJD3G2IT4b+H9L53vYFakjJsmAa0pw+RROuARdFioCSlwSg1BY3v6XAAfO?=
 =?us-ascii?Q?A/3kampe6SpKCPQuXptysS8RuvWa/r1LZJLa2x/4IfDMFsEfs7JtoBLP9asK?=
 =?us-ascii?Q?XTeWXER6YxNHcGWjB+MAkWxj/KYMHxDFufc4gc8O+q/eZ+lBpk216Q215zYd?=
 =?us-ascii?Q?Z+AAN5wiQQR12BVqwGKKHegwzUh/3pxbrAA6q0hUDVxcCbnLwSwoZkDWaAKr?=
 =?us-ascii?Q?9uQdp317M3t4VpaAbLFpF9wR2b6vp62K9KAil5p4jPy9bAlNo/dpIduEiwJ+?=
 =?us-ascii?Q?NAcV+N34yjIxojwen0TKzSFoL7/F0ILXRVOEORKRKqLtT4yDvmuiY2+ixQr2?=
 =?us-ascii?Q?GO79v6wSZx8EhhR0TEaKSAxN4eqyy4Ydh2qDKEVCHCBDOUryXiIYV1J+vYkK?=
 =?us-ascii?Q?RauNr7ozwo8sWB4/Duh+qSI/rsg0g26SnmsfDTIRNpMFjnIKnR+j5CKkV+d2?=
 =?us-ascii?Q?IbFnY4FJjglyDj5CP89XJDLO3ZSHxStKudJTl4OwjhKbPrSzWFYrO61ouqdU?=
 =?us-ascii?Q?fCSFSgtH0hwdNUIbhioRV2Y9sdr2DJ1LOn2lvQ9reubXm43OOezq/0uqQKJN?=
 =?us-ascii?Q?xsJHhyeXlqKNIIlVn79zN86xRYn4OnDMo1kjVQNrCWTo07Upz3ZbTyey3/Fo?=
 =?us-ascii?Q?nMp72bq5SiomiN1T5bg3UqFb9bXrga77h/E1BMUriZKhNCZl5eTY0PsDUYoy?=
 =?us-ascii?Q?M8Y6kI6Qdd7reB+f0lEyciKWXwdvEzo1DRuCnrxWf2GVSex9Eo7mnOLquICY?=
 =?us-ascii?Q?mFwro3iJ85D/+b8n/NzNWGlS4wLS7YJnPwqhfL32ZVDGv14z3cVAuJLLIbhx?=
 =?us-ascii?Q?El/W3Rp42APVtAhbBdn44HMPPwFFoWNC96KbXLbrAy212Ec71JRh/2pz6DM6?=
 =?us-ascii?Q?2RZNvrxH38eAt4gOdkwAZyWhUGJyCBUBb+foNLyH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0urzaT/DJ4Lx5TDjMfxpkIiYwFPE+Y9pZP9BmVIDRcp/iOZp0usNRraK7GXB?=
 =?us-ascii?Q?tylYFua8IXPxWUFgIA/7H1KiER1UDiD7jvfHloqbvqZDsjlp84yaEI7+4QiS?=
 =?us-ascii?Q?jzUNItiOJfdtSbDpZjCWHwxV6xGj0FB6DO8E0+RYJ5ZsGbviaLuqOpN93C2I?=
 =?us-ascii?Q?1++mibabUrDO8giPS3A9QSg1NIA5EssaVDTCxCs9CNVfcJizCCBvONhZMhv8?=
 =?us-ascii?Q?GSyBLJmnzWATJ81I7GKBhhYliEMCWgLWLfm4+K/c11aaIy8nyQzi4+TVBUQ+?=
 =?us-ascii?Q?eGkxPzkw/lN7nQ65mP4GYABjgMZkzHKxWk4VWZThiZxIVRUGJ7j1pMLZeWiC?=
 =?us-ascii?Q?iznJ8oSR3oMdJUg0hRnYFFMOMzjmO+rkbudw4F1Uiugb2ixJr41JK20Ovget?=
 =?us-ascii?Q?i3Us8i6LaDWjTi6Rwq0sjp6uUivva5EuzaycFok0rw/dYHAlE6n3p/18MEZh?=
 =?us-ascii?Q?8sPo77RUYChgqenx7c+67vd/5FBmet1vTv61tfvObsOrbLgHGlP0/lPoaXfX?=
 =?us-ascii?Q?o5n4XJywUafbpzrIZlGIV5R1ixbWjAL6SmzwdywoWodSjFbUJdaIUbiOr0Qh?=
 =?us-ascii?Q?oIWefn9GT9oDwBCatzaip2xXL0uX0VQcL/02TUoAgJTAwIu5eyccnfo7uYxV?=
 =?us-ascii?Q?yhXtTWhmzINPzdd5WwkzABgGzhuWY+xfKOMxytedxB8A7lyFR00MeBRsH83f?=
 =?us-ascii?Q?n+Sxbo5wNBpQJC4RdcolpSJ0btAKNRkt5XyT/qUmO6jhR+d/tNKOTOh9jZj7?=
 =?us-ascii?Q?DWIOnG6XG3wZMrIrosSOku2u6LnQ8F+e5FvkHqJouYvxr9ZE9eAuYUWkzDEA?=
 =?us-ascii?Q?R4L3VIsG/D9NSp9odUl3O7p0g1mCY7MXy+vz91PuzBYDlrt04KzfoPuvhaOp?=
 =?us-ascii?Q?9PDqavlQ2j6w2a1uYJ3JGTViCH6M67yykv9vJBtkO/5WK03P5o8rt29NWkFY?=
 =?us-ascii?Q?8jpvovVQpKK5hA0MZOGrG2hsgWvVPF83KNb9SXJ+E1LwBnF631gM3yjLrhaZ?=
 =?us-ascii?Q?SfJnX/rsMvbdu3rpIg0j4La2l3Dt57q65gNx6BR2E/Q5CoU0yWq8fZenwaYR?=
 =?us-ascii?Q?kKPQQc5vHte43k2szbxwyHDTThRHmrLPm9egxeIwiyfydWUxF67mJuHy5B3R?=
 =?us-ascii?Q?FbvLZoU4845D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6d6849-bf11-4b80-39ea-08dbb89b4e6a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 23:02:17.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IhPQtPXc7uVqajX8pyOLnU+TMYJ+xWKDi4HqaGWbi5m9j/2xYNElt2LKg5fwJXsBr8o5vmpzPjWPL2gW9hhpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_11,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309180199
X-Proofpoint-ORIG-GUID: uHuxZ57rwM1eJSTTK4ZDA4gQneMnvgY6
X-Proofpoint-GUID: uHuxZ57rwM1eJSTTK4ZDA4gQneMnvgY6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 36 ++++++++++++++++++------------------
 mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 11 +++++++++++
 3 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6f3db3c1313..814bb1982274 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1836,36 +1836,36 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
+	int ret;
+	unsigned long restored;
 	struct folio *folio, *t_folio;
-	bool clear_dtor = false;
 
 	/*
-	 * First allocate required vmemmmap (if necessary) for all folios on
-	 * list.  If vmemmap can not be allocated, we can not free folio to
-	 * lower level allocator, so add back as hugetlb surplus page.
-	 * add_hugetlb_folio() removes the page from THIS list.
-	 * Use clear_dtor to note if vmemmap was successfully allocated for
-	 * ANY page on the list.
+	 * First allocate required vmemmmap (if necessary) for all folios.
 	 */
-	list_for_each_entry_safe(folio, t_folio, list, lru) {
-		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
-			if (hugetlb_vmemmap_restore(h, &folio->page)) {
-				spin_lock_irq(&hugetlb_lock);
+	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
+
+	/*
+	 * If there was an error restoring vmemmap for ANY folios on the list,
+	 * add them back as surplus hugetlb pages.  add_hugetlb_folio() removes
+	 * the folio from THIS list.
+	 */
+	if (ret < 0) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry_safe(folio, t_folio, list, lru)
+			if (folio_test_hugetlb_vmemmap_optimized(folio))
 				add_hugetlb_folio(h, folio, true);
-				spin_unlock_irq(&hugetlb_lock);
-			} else
-				clear_dtor = true;
-		}
+		spin_unlock_irq(&hugetlb_lock);
 	}
 
 	/*
-	 * If vmemmmap allocation was performed on any folio above, take lock
-	 * to clear destructor of all folios on list.  This avoids the need to
+	 * If vmemmmap allocation was performed on ANY folio , take lock to
+	 * clear destructor of all folios on list.  This avoids the need to
 	 * lock/unlock for each individual folio.
 	 * The assumption is vmemmap allocation was performed on all or none
 	 * of the folios on the list.  This is true expect in VERY rare cases.
 	 */
-	if (clear_dtor) {
+	if (restored) {
 		spin_lock_irq(&hugetlb_lock);
 		list_for_each_entry(folio, list, lru)
 			__clear_hugetlb_destructor(h, folio);
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4558b814ffab..463a4037ec6e 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -480,6 +480,43 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 	return ret;
 }
 
+/**
+ * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
+ * @h:		struct hstate.
+ * @folio_list:	list of folios.
+ * @restored:	Set to number of folios for which vmemmap was restored
+ *		successfully if caller passes a non-NULL pointer.
+ *
+ * Return: %0 if vmemmap exists for all folios on the list.  If an error is
+ *		encountered restoring vmemmap for ANY folio, an error code
+ *		will be returned to the caller.  It is then the responsibility
+ *		of the caller to check the hugetlb vmemmap optimized flag of
+ *		each folio to determine if vmemmap was actually restored.
+ */
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	unsigned long num_restored;
+	struct folio *folio;
+	int ret = 0, t_ret;
+
+	num_restored = 0;
+	list_for_each_entry(folio, folio_list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
+			if (t_ret)
+				ret = t_ret;
+			else
+				num_restored++;
+		}
+	}
+
+	if (*restored)
+		*restored = num_restored;
+	return ret;
+}
+
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index c512e388dbb4..bb58453c3cc0 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -19,6 +19,8 @@
 
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
+int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+			struct list_head *folio_list, unsigned long *restored);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
@@ -45,6 +47,15 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
 	return 0;
 }
 
+static inline int hugetlb_vmemmap_restore_folios(const struct hstate *h,
+					struct list_head *folio_list,
+					unsigned long *restored)
+{
+	if (restored)
+		*restored = 0;
+	return 0;
+}
+
 static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 }
-- 
2.41.0

