Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F77ACD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjIYAlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjIYAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51324FF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OLsBVB012416;
        Mon, 25 Sep 2023 00:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=Yuew2zGAFlLf+GSdB6WUQc0eR1wB367C/h7u89fejbcki5JbIEAzy07125Kla/KcL7Lm
 NDZkc9qIUCEMUKgSCoScCDrBlzVRN1np1gjsnDtGHE9xqLOoa34hmwTlGmET6IY4IP92
 DgWtG4uex2tRPJ+9+pyk/Q4D2Yj4c/0xtnS2xQ8umfAeZUa5ySvnUgJPj4FicYHIyPgJ
 22iOXq9xWY8hhJsY3u5ZivHKgngc9plDcN1aicojg3CHicPnV2wfeer0n7fcuh4T+iGy
 5xfwnwzUpCP1+4FIOPjK/wn1synDUe1v05pI1UQ8f69pkLAqXw9543BvaFrfVxauCbl4 kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pee2er8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38ON16v4030612;
        Mon, 25 Sep 2023 00:40:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf3kx5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4klr3ScJFtCkvuCRgcYgXA+KZ/JPkZlQEHcXJd5Z4NzOSj2ynNEdRmuaKsLgYR7bvVN/ommf73H+30h3o8YKUS4Q/8PAa3dO6vIzM7Gb2lFjRmmuizXmnprilH9Ka/filizGQEj/7A8SraCybvOhhzFbCB7Of4LyB4w2jSOmLvmaOcT+sxxcFJrDxidRKF3aa3NKsSjqrfgh+RZyaxG2nCefk7jMW9AfY/SvwrDKjEmyHTNi8WO5f7DYmsIrhtqeKMAdZLjdyo1H+v6f64AcyVhIvvK4+DEFbDhOP2Uj0/JFTbo2HErMH+8oV9mWXETyrAQMEHX7pEWwlyYvaMYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=GUJpr7eU0RvQGfJvfomQuo6/LcmjFavwwX14V+rd8PzIRLEHgPqFs+3b/DTXpH33Zt0rIglUyzlDkAETpXowYzj6w1m5P2M9/R47hcagMjQfagrovVQXy129S8m59O2gtrGuKuhz80O5ZsOcXHCzLYCsfNgIHbj8ge8Hlgj/4SNPGiECipPnEJmzWIUa6XScp453T3WPuvcglk4DDxhcYOSWFjTc+432jJC7hAM8KsU4/g7miqVXVwIJc5CVqHy0oerWsfaZ2isigH6HWmcdt3zJzrH03hPitYuDCZKGsqgAYXbgpbM7Qd4H1F4m2d9zeJyJy3uVlLcotu0THV6Zrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=zHczSrmxLbuzD11AkyzH94PsVcnCCbxCYtM5ZcYjnORh56lW67tbNIQqMCKZKzZSBbog5450jDJdCI7zAN5dToWvyJO9FS0VmkDO/Thw1LueYJF/2ZEenGvsDz0yqoJ2gXvKaDZntzk2g6mMKL/8Jag0i/nAfmDbnX4RBr8nkLs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:25 +0000
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
Subject: [PATCH v5 5/8] hugetlb: batch freeing of vmemmap pages
Date:   Sun, 24 Sep 2023 17:39:49 -0700
Message-ID: <20230925003953.142620-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: a086f848-ddd3-481e-7a84-08dbbd600244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKbQfrwUOjr0bj6g1H79fiu0qBMOiQDPcHR4aFI2ACHtEcyaMzBZh90IgollvASw1L874Fo+0Qnb36bJdiqWBqqlXOSOV8MoGvVR/tLpByrSj6NwP8DkJ9K+kFRwSiaVeur+Qj2gAnfs+ROWnJWoyW/ToX9vx7RQlHeVDmtestWrDBYfKy/QxGnEWhAeKKjLnCJSqw5CPTxtr37a6kn50FlaNBYr9P3mIleCY3itewZvSbLFRDCyEkW/WV8iKV7ihEWYGw+4U+I1bw8H0CWeGEJnyKs6JUlE2zdp0h90VZyuhIRjaLKBF36q217JB+GaQUEuZUnWS5t7J7lY11EDQKC3zFIu7ivzQCSW4a7BHs6ikPxm8bi6it3gpDCqFAzGqgp6yptGNCncZ8cnfY0sGhAHrfp4no6O0hMbzPMG6Cu8XrHCNl4eCizuJM9Sd2Xz6Pr6QGb6UGdYqijH1g2CGEbv5hvmgrurykQiPOAhQNA6BIUbeSsakdw8nzZjnTDbACgLNTLcWHy+XQdwLU8l4w/tu5mBvzZe0DUXbRB/ZVBnVa/KEZtS843btKHr164f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kdYfMeLYzhY9KOqx1pXc5m7EEfEYHEWPnA0frMueO5fN3iKMvXSFB2t6A23s?=
 =?us-ascii?Q?6GlVxSxuEgcCEclxAqH2k1dRNk5EUxYVZCgnHH8qARfR4ugNIxo+dRDM3P2f?=
 =?us-ascii?Q?eDWATOmsOXoTI4pxS1HttnvWLpYSw/TIP6G/s1dyu3E+filijddF4E0TOcHE?=
 =?us-ascii?Q?H5Uf0jeUvxgRLcXGYjHJ22rJzsZSDYmi518a6zD/t6m9orK++D8wMagtSqgm?=
 =?us-ascii?Q?aN/Ew4Ikgij1JKwXTbwXggwjhhhO5H/Ia/d49Sxxox9h/HyKA5Yb4FmbkamO?=
 =?us-ascii?Q?sBvMGW7FifjYXPut7DkUkuMkWZ8mjstrTvfjtFg92686VBDGHg9aUORBFbe2?=
 =?us-ascii?Q?8KKLKPJ67oOZfNEfNHoSvO7q/UGMIhZSkLSKzZLIl1/aXL8Dixh05UM6ilb9?=
 =?us-ascii?Q?h4NB0JkL4UJhkSbTT/KGZuZuRHm0g64qszQYZwK3m//eaZ08eklM6CPb+zww?=
 =?us-ascii?Q?yreV7drwnOC9D+cvGXDzGE756434SWmDhpbwlf/htWuI11EbzpcHcMH1X/S1?=
 =?us-ascii?Q?o/ZkjJsksD86bIbu1wXp/8Yjz7jgeYaTlzQVj1L3rOlkWF4OBGQeRHgKXdjz?=
 =?us-ascii?Q?RVS1u4qGtb/l5nyTUoTJ3svZkQ5JrZhc+RWSffy7QM+q95Ym0JmtxT30Vx7Q?=
 =?us-ascii?Q?sT3fz8RJL0YznnvN55bZ4qxtlkXkgRr2bscKPiirQzFKmCQmcDVYXLoKA3y3?=
 =?us-ascii?Q?jtJCNzmW43MYe6F5MQMUHyBi0ssL4ewEimPdyyDQ/EDkyfFoj1qiyserG3aM?=
 =?us-ascii?Q?PEIByj2TSuxzbkigjTWohTr0xthswWADqkmNaYfWojKkuRl25y+P9xyRlCtB?=
 =?us-ascii?Q?xwx0TsyGNvtyhApPZA2urDkRn2XVG9ZDNKB6CN4JFDVI+rI/nRoKVJIwBQDn?=
 =?us-ascii?Q?vSnPpbZtjN/Qo1j4CWdKM8Q/DZy0r5izh/8L98z1MC56uJ6AvqFQiHH2lHm5?=
 =?us-ascii?Q?sUfuv25ukN+PxzqUdQoGpIxtmTsYqbcu3qblaAIsGOsOFR2/qsDL8CCoTtXy?=
 =?us-ascii?Q?RFvbRatQsxoqVpBU4lL98V95XxTvCkESYylMPSMTe34lbnQqLb1lUCE0pdhz?=
 =?us-ascii?Q?yMIXC1zJXs1thlzrSCtg4yiOGFGt8/KNmbvswKiJT4agcGZmp6EAFZJ8bmX3?=
 =?us-ascii?Q?O+y66nOnV2pKSptZyjY2dQZgKTXn0S4VwdAqw1nQNGavpPc0EbRAsk7K7qAG?=
 =?us-ascii?Q?/iZrvq3JRuAx7WGX/Rl6pvqTxOxLOuivS+RVdDmd4upLm6/EOq5wogbieBI1?=
 =?us-ascii?Q?26ec4kX/I15HkiBWm4uWg29Rc0RS2mcCfFiCtjq+J8ZEAFFnw5cU1evZErBT?=
 =?us-ascii?Q?JvYfqls52CetV+P4Vnv0JRxXR62ASJQ1hHKg4dUmZZJJslkh74EqxIQJTrNx?=
 =?us-ascii?Q?9Xnu8QfNxG1Jp2sOuVA7Ag40gcmECA/77QkwM6V5l6GfhDBsrC3ljeLNUbSC?=
 =?us-ascii?Q?tp6PwmobaKx+y/DSyM0aByEyrBs4cyyLhV8WdgOanp+GMOR8eF+x+m0aqJKR?=
 =?us-ascii?Q?3sIiUtoiBNvh1Zv4WE+wpFmxLnfHhrMuMcdvFFOYO5Ix14OgbtMxwPhVLd5O?=
 =?us-ascii?Q?ctU6Qb2zuVk/tnBSMsWiDF75aSZ8yHPRzrXaTvYI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VtVkcdYxMg+3hLA/Ll2dGWsOVUmocMKZx3zxl/d8PAirh6Ix31SeyFnTFAu7?=
 =?us-ascii?Q?eCLqpgNdyIof59/EHAtRw9+yio9uFiEGAWCGKjIvPwsVVTDj4aE6z0SE/Lo2?=
 =?us-ascii?Q?Pb4/aEQ34FLE+dzz/+dP644oGJqci0ti5TIp01LgMMa4K/12B8+EJAvt9Llo?=
 =?us-ascii?Q?njoOR5fo8DuZGA0GQI16VNL1hjoKgg9uoNaY4a7s40XOc5BmRDqZSvdgG+9j?=
 =?us-ascii?Q?VjwWf5jsg9k9doLkIO7AkrzbponKpDvjvLevNeutoXiV34QeM/OjTtC9ycos?=
 =?us-ascii?Q?S14pWT++ckUd6o6buB/4+RQNAO1NjLmpzIz2wHtn567U1KCu0yOxXVZ5ECW4?=
 =?us-ascii?Q?MIW3/rqmfINJhnT3Iuf8IEW/NdM78XQ0HgOxjBV8EPPEfwx7kk5uQM7kOEPG?=
 =?us-ascii?Q?3Y8TeojersaU0orpoXpWDV6u+AUC4Qu53t0EE2/+WTwJemKf82vVhzWNn97R?=
 =?us-ascii?Q?aBd5T+riny1CD8/QPuRWZK+O+u0WXQ+gzfS4Ym4kup3ZFI6cdIxve6bS8bsR?=
 =?us-ascii?Q?P8wV+/rni8Nq8kmeYIoKsTvynEvmO+fV4AX41Y4qQFoNa5l3ysSyqLFKiWX1?=
 =?us-ascii?Q?2PYocR9f1LqyxUlgtrcjcvvMko9vh34NEC7xHohq9DEC3aPYfIB/pKgxpUIX?=
 =?us-ascii?Q?nSR8RmZra5PkqiRQ44BRdVQU/XjeZ1djCN35HIbVnZMXXn2pRKnzC+zrNHHt?=
 =?us-ascii?Q?dBkbrxgYapFImI0kvdiyOCiKFCUfccVRKs3feovEmR9SsCeoMFz48qrXX/rF?=
 =?us-ascii?Q?/kO88PsqaP5xECuxGZDKugjZs/8AtHWRonM14p93yqp9/VMQlp10WmteP/Om?=
 =?us-ascii?Q?nQSD9YWfGIz7L7KpyXyWiUd5BO4fY2O32I0Wl9Z0ullyavrDwji/mSqGxMpB?=
 =?us-ascii?Q?qWik/rYDrZxgaOCJIjjnc/M1g+0d6e0JBNqb4bCBUoqaHfam+qGVNdTCNNj1?=
 =?us-ascii?Q?tebf6Z0yKh/xBBu0PyfNTnEjVNuCybD4yz1sgLfQajIjUh6RVVymbe6smL2J?=
 =?us-ascii?Q?30ES30jpB98bfO94dn6szgykf7WVye1JrnnFIyeZL3eOc7BAp6vJBsxEs5Hf?=
 =?us-ascii?Q?gocsGRioHMx3cvpZWilvbz2Fz0EhTxDzuMmaOBzCFu8i0bL+o1piE3gWRcyV?=
 =?us-ascii?Q?SpwcEQafZIMd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a086f848-ddd3-481e-7a84-08dbbd600244
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:25.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQtMswecAE5UcXhpY3XkHarBN8f9JRva9EcwfFFYXTdl74A/RjVnUoEJsrTSpTSalfb9k2M4rmGZi/JIe4A81g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-ORIG-GUID: iqZ_EHcWbixoAeEcHiHuCI4XdJF8jeHx
X-Proofpoint-GUID: iqZ_EHcWbixoAeEcHiHuCI4XdJF8jeHx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that batching of hugetlb vmemmap optimization processing is possible,
batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
hugetlb page, we add them to a list that is freed after the entire batch
has been processed.

This enhances the ability to return contiguous ranges of memory to the
low level allocators.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 82 ++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 77f44b81ff01..4ac521e596db 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -251,7 +251,7 @@ static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
 	}
 
 	entry = mk_pte(walk->reuse_page, pgprot);
-	list_add_tail(&page->lru, walk->vmemmap_pages);
+	list_add(&page->lru, walk->vmemmap_pages);
 	set_pte_at(&init_mm, addr, pte, entry);
 }
 
@@ -306,18 +306,20 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
+ *		responsibility to free pages.
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *vmemmap_pages)
 {
 	int ret;
-	LIST_HEAD(vmemmap_pages);
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
-		.vmemmap_pages	= &vmemmap_pages,
+		.vmemmap_pages	= vmemmap_pages,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -334,7 +336,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	if (walk.reuse_page) {
 		copy_page(page_to_virt(walk.reuse_page),
 			  (void *)walk.reuse_addr);
-		list_add(&walk.reuse_page->lru, &vmemmap_pages);
+		list_add(&walk.reuse_page->lru, vmemmap_pages);
 	}
 
 	/*
@@ -365,15 +367,13 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		walk = (struct vmemmap_remap_walk) {
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
-			.vmemmap_pages	= &vmemmap_pages,
+			.vmemmap_pages	= vmemmap_pages,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
-
 	return ret;
 }
 
@@ -389,7 +389,7 @@ static int alloc_vmemmap_page_list(unsigned long start, unsigned long end,
 		page = alloc_pages_node(nid, gfp_mask, 0);
 		if (!page)
 			goto out;
-		list_add_tail(&page->lru, list);
+		list_add(&page->lru, list);
 	}
 
 	return 0;
@@ -577,24 +577,17 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	return true;
 }
 
-/**
- * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
- * @h:		struct hstate.
- * @head:	the head page whose vmemmap pages will be optimized.
- *
- * This function only tries to optimize @head's vmemmap pages and does not
- * guarantee that the optimization will succeed after it returns. The caller
- * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
- * have been optimized.
- */
-void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+static int __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *vmemmap_pages)
 {
+	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
 
 	VM_WARN_ON_ONCE(!PageHuge(head));
 	if (!vmemmap_should_optimize(h, head))
-		return;
+		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
 
@@ -604,21 +597,58 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 
 	/*
 	 * Remap the vmemmap virtual address range [@vmemmap_start, @vmemmap_end)
-	 * to the page which @vmemmap_reuse is mapped to, then free the pages
-	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
+	 * to the page which @vmemmap_reuse is mapped to.  Add pages previously
+	 * mapping the range to vmemmap_pages list so that they can be freed by
+	 * the caller.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
+	if (ret)
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
+
+	return ret;
+}
+
+/**
+ * hugetlb_vmemmap_optimize - optimize @head page's vmemmap pages.
+ * @h:		struct hstate.
+ * @head:	the head page whose vmemmap pages will be optimized.
+ *
+ * This function only tries to optimize @head's vmemmap pages and does not
+ * guarantee that the optimization will succeed after it returns. The caller
+ * can use HPageVmemmapOptimized(@head) to detect if @head's vmemmap pages
+ * have been optimized.
+ */
+void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
+{
+	LIST_HEAD(vmemmap_pages);
+
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
+
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
+								&vmemmap_pages);
+
+		/*
+		 * Pages to be freed may have been accumulated.  If we
+		 * encounter an ENOMEM,  free what we have and try again.
+		 */
+		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			free_vmemmap_page_list(&vmemmap_pages);
+			INIT_LIST_HEAD(&vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+		}
+	}
 
-	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

