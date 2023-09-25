Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB4B7AE29F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjIYXuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjIYXuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:50:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F71CD4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:49:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PNDuU1027594;
        Mon, 25 Sep 2023 23:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=L8jVeAs9Oqs/V8o1E7WXzffvQBJTn+5wKbXP85K/fAZF7b9QnUhzNiMyT8M9DGE5VkhT
 a+0anpZuXhcsSDqZI087kOi2AfqOVQ5oiyrse5KtYU7vFumQegqfRLPVI1i0WEzSrzMU
 pJSPseTDI0bGEqRym2TLMj3560Sri2KtFDsWQH7V/PYLlhc2JhQ1Pa5gIZY7oJJYXWj9
 qhw7eGg3rkP2ErdO4uO3LnVX+nVqjKdoTb2f+O3qBIj6BoTL97upex+Y1SNhGH4HgKmB
 KTCbz+k3WuY5zmz4+gaiDkFuMFGRBKgC4CvC4nnlmaS/S+cz+uWdBmcI5hGugujYihrs kQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2595y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMYNr0030858;
        Mon, 25 Sep 2023 23:49:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbawgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 23:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foopS/ycNYn07ONnmdabdzGYWCIJR6nph6XkkL46bg6hMZRMWVAjaAjzCBnD16t5PNHGKcPNwwQ/Lphtwy/cKoN66FrkE2dSUnKU11Y7unB2wnlqtmvR5tkbQojslFBueVkTc/ZTm9NwzjpuJj+vOn1ZtcjnxSiskcuDC00AS+nY7dcXVj13OY6WkucY+E+9076xrVBABVi0GZDPLax+BewZC5Y6xLxcK+gqd+9yG5rk12oZR9S0ZRjP5TSmeK87Wtth+nQE4FuXWYftlt3BRjv0KUYRXOcg9QtZ2B0BtMMQE1JxKWXOBSGIQJDTDShfPAjcxWiC+etSPlHnjPb/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=cxF5KEIesA2Hj4JYdOFvKhSKwrott4yp6HwcyazTtAQig/hnaq5n7GZjBEg8VFRP0nUwYSuPZ4Gd5ged/9Oi4/OQFDf0cgXZOOqspt2cxNTcruC8dQn3cKs+WD3htWO+Egy9auFimeg8EBjCfZqVvH2W5QBdLv6YH2QPri2wJIrHVHyaqv4u9i0ipiER5t5oYWH2ponw4kQzqYzfnA10ykoMsff/BQXlq5sGNyFoG63ScuxxSY4doSJwxzVxkaH9n/b02kYZYbXH4Kn6hVPICSQtYxPValBKtivqR2pvsJKS5vZ0g3FeeQKgsInSVXvRa/IcEgWY7R1zwbwXtTFgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8COXuu6/TtJ5IDPv6UZqVnZDWI+bSmwncS3etnX9L8=;
 b=JdShc/2Zc2AaCspt0hYRkVZXR6gEe81fUZlw/pe10RG4NZXvQ8G51SLazw+3mVQYJKzoq2BYQQ4OSfYVnuSMseQUogdKcDXOGWvfNEEwyzrK9mBCH5WdiXzfv8ALUcgfJJ36hlna/LW5x0VnFEweZDGjGJfnc2it9X+I692gj4Y=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6730.namprd10.prod.outlook.com (2603:10b6:930:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:49:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 23:49:00 +0000
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
Subject: [PATCH v6 5/8] hugetlb: batch freeing of vmemmap pages
Date:   Mon, 25 Sep 2023 16:48:33 -0700
Message-ID: <20230925234837.86786-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925234837.86786-1-mike.kravetz@oracle.com>
References: <20230925234837.86786-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:303:16d::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6730:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ed3d25-09af-483d-c813-08dbbe21fd8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ncVl4pVfYVMeOPvF/g59DG37d2xEv9xvvaDXroJKeItKpqTDcbZVs2Zn31bB/NriRmsB45Qbdzt+Y8Bdgu4yfLh/xYh2+R7/APDuz9EOYManxED+WbZ0nepZpr0g7FHmEX0HwFscwg07brRR8CLRVRZtXxkudnBcxPNxIEtW/fP23fD2KIVqTmHp1yxsPkYXJWU4E25WpqA5BO0I4mRMxZNjyJexzjs+rA8IyKq/fF4nq7sWsr4fY67d9DWTI5mLsQ/GOBICwiCWS2jRNfDayCvLO8bVFaibMigmUy+QysSVwO1TZ4STp6C0aBguZ6uAFL4OEStCW+f/yOeqxRURPYw1WVs1G2N1o+KwT3gDOQPMq+zDevuisyA2bjyhn5ES4X8AxmLhnt+Sn42BYD12RfY7wh66fAyxk0kqCOpuu4Y0SmIcP405q4oKgQtZSayUG9i89MCjj9bzV/SbYR/pEmf9l7y9iYiornPKOnT2Ak1DwTv6wnR+2Sh1OoYANG7+RO8ZjQxrvHu9mwXAg676l9SmIG2XiXbhvHfAB/ue6bhV0KAOAEuBGljVfu6zH6d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(478600001)(6506007)(6666004)(6486002)(1076003)(2906002)(2616005)(5660300002)(6512007)(7416002)(54906003)(316002)(107886003)(66946007)(8936002)(66476007)(8676002)(4326008)(41300700001)(44832011)(66556008)(26005)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VPXIP6mmrrURJYyacryDztT7xHB5654Jhp8+5J7xSVW/AhNjXclAGxIcl6ty?=
 =?us-ascii?Q?Wvjcik+2Jfz+jSQt7lELbLH9Cly1Kggt5H2QNcjA3e3qzuTNpnq1zfWP3m1B?=
 =?us-ascii?Q?FlaYiZHqtSLFlu4n0vE6BuHcdFCaH5NRoUol7KqR1gTD/+u65b7sW1FD6DBz?=
 =?us-ascii?Q?J2mPoe7emEB2J/wzeTd2eyQmJh4tE/jQafyC3DIb9hlIXdgesg9JgnlnDFVL?=
 =?us-ascii?Q?sOVZqsuLf6alRDnuuq+HCN0Rd5WRUcalryRYnH0yUmavdH/vs+c0Z1F7D6S+?=
 =?us-ascii?Q?M03p42clA8xYH64Ll8LeHKZoI2sjTJno3FN+GHjIC+5ioTcaREE/W2pYRBHy?=
 =?us-ascii?Q?A8mNAhNnGSBAmatSMumsLbr0yKKIOSqI3n9Hr0e+QH0DFv5DnoyMq8MHGNQy?=
 =?us-ascii?Q?Jmv0+vzka2X5uqUtBbLr6Dh2DfiHZQKceOeFiD1q7P/ovZbYuN2+IXV1PF56?=
 =?us-ascii?Q?4DPxFInyIqCnOYxNgGFtBNz8qUOBrhbqz6ck2Ss/d8FVhrfZ7Qftkbtrwezh?=
 =?us-ascii?Q?KgadIsPTQ7fWatwtWooXfHKQxPSmt9XBin6DD3DJENEJZUtQDX1F29w4sHPm?=
 =?us-ascii?Q?XKfpuUXdcsy1hyYlgvLeBk6lVN08imQX32g5xu1m2mJx5vJCaDOj7HE4/SvN?=
 =?us-ascii?Q?GWs3lvUhjxbPiBNXDrYoZ1v2IGVDudXsK/yhxi6FYpm/47PehAQM5tiTeUqp?=
 =?us-ascii?Q?pD2Hkew7UQcRQHpaXUMJaQu4KEICeBj6zeNdiGNUujFyURUE8vSJ9wdiQUDF?=
 =?us-ascii?Q?/XolUHGSvvoeFUye1EZ8jEnxkw40G0qu7hdmD5EGX7Ebs6mzRQjJyegvQGJW?=
 =?us-ascii?Q?eWVmxUXvzohq9DPf4XhBKq/58NNLFrBhPRmHEvqTL+zVr/Crsrtyf+aWNrfQ?=
 =?us-ascii?Q?j55+J0AoKvMKMWzSW9oUK+qjow1zWBVp7flxkhCokGBHKI1M4B1+rnj+SowO?=
 =?us-ascii?Q?7t2bX3sVl29sreilsOaBS4r/mxOncbbwcGLfucJ9zSjyBhGlwfPw4MEdv4U6?=
 =?us-ascii?Q?g4f5T0jvV9R0HsmM06UZhtMtvI7NVV80W4ULoJPcUWQA7mg7OkYFavRjQ1mn?=
 =?us-ascii?Q?wSrqwiSk5mGBr4NqkYJgFDFZpgK489cAkOon9yY4AHg4WvMV5R4yPN+DiAQC?=
 =?us-ascii?Q?S/I7JSy7iMYo08UFlwFdQIAL8EkX68K3ttGMJ0CTjY9ZKYPD7MNQhkrxEdlJ?=
 =?us-ascii?Q?NrAgMPEOpWnNfPc39R1UcO1zRTDkB+mc3UjJpkBbrgTnvhKQeiRcPfu3Zy/7?=
 =?us-ascii?Q?osdSm+b0F/u5rW4Vnx6TUUypXJCakMwewOmaQMmjPHnBUH5mdY+kSfeb2806?=
 =?us-ascii?Q?tWu0iFie+zzt1JbzmSIfV8/xt4VtY56F3zJLM0DfVnE6/0qw+pzVE6yHdOhd?=
 =?us-ascii?Q?Bm4bDP18cesrmqtGJ3tWWOmWCLMIBeq0boFdsnvYUHuQ4k1djoiukaG9nK/3?=
 =?us-ascii?Q?gikxzuvs3iSUa6srYwNnL+TLZd72KT3UliKwzRMxepvKlpJ50YnmAqo3ilyS?=
 =?us-ascii?Q?t8gEG3wMsDGEof2dDGmB3DH7ZGagQcqNA02KAHuoGHhacPOnuxZK1glAphSl?=
 =?us-ascii?Q?x0uL167uTYT0Jqz+d5b23UiyUOtQ4scW6efEcvUh0JbnucAiL+ZMWF0fOEq4?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ye1JjnqvYGCdEMQQsW9CJ9Jzjcequq+DDBz4Q8bgOwyfIo4QL2T1WVrf+aRU?=
 =?us-ascii?Q?BjtMHyA6yRnJCf/Jly0Bp7ZOIH/tSiqE4H/fKcpHPxRmdovXYHTxL5PTjSRc?=
 =?us-ascii?Q?G7XntE6ZGQoLq0kDhQ5lqJ24Z1lj42GAhAfAy9H+kk+M96z+VCpDbUCbhPkW?=
 =?us-ascii?Q?kOuwBeRWB8E72mdyHCKbWzAriXo3nGRiYhakiSHXFNcuAXlo3M5349oM1NQO?=
 =?us-ascii?Q?7f3iSZLhq/ZWyIFxoHYVTYYgxbAUbIEw7655j+dLs/0rQVjmXK4MnxAMBVCY?=
 =?us-ascii?Q?xo7WMc54DnUuWlxhYd+uAvZ0KL06kEhsnXqET1bBIyMP83yIwMbECTIq2OhG?=
 =?us-ascii?Q?K0u4WTNzbaBytbbyxpaEfTqRPTIk2vc1RElXQFeBo3OjhuP+uDgzPB0km3Jk?=
 =?us-ascii?Q?1e1A1R9xZCbXKhUdiF7Xittcs9vY0wDaTmc/z0PnHMokTqDc9Nq7q8VoeAGf?=
 =?us-ascii?Q?I0xOC35bYUzX8SJzbFYVnnB8S3IhLXoYZoL8wyJ/p6Qli9srkDPuns74U+n9?=
 =?us-ascii?Q?tWM/aUAd+0AbhKxyHCou+42LWwV3Ps/4/DoNCQMN4VRdEww2mBlqZdcHSuAx?=
 =?us-ascii?Q?En5xlnxeruVfvpLLl0AuTNZhiA04/JOjYjFPjw9r0ArxRx3IF7/660rW6nlB?=
 =?us-ascii?Q?DsQGySkJKAFtva0yV9tDBbnhcvSxrsdhim9junaBaFOC1QbfjIjn+aQBEuQF?=
 =?us-ascii?Q?BInA4yccBKo8viWkm+4D7hPSRYITi/V5enCFd+Haa077IZfCfiSwz1YI2XYP?=
 =?us-ascii?Q?uG5/HSc/r2FPkCMzN/re3+4It1as2zOhJkPfUt90Qv4lDJIqH7XHKFdBJDPZ?=
 =?us-ascii?Q?/29jio8sa9tD3XzAeA14hmBQUmVdjtkVfY2OWoU37SDvMM42n3O8YMlcP7JM?=
 =?us-ascii?Q?3OeVOFDZVI/43xY63osG4KvdUzWBLzFqz4hAbFjwVK0bZWP6X/FR3GPJZRGO?=
 =?us-ascii?Q?fLoUkk4jWxkSHeIEZP7PwhESkZtbF41O6c9Y/17xd/E5N928Ksc4e0XrBHDQ?=
 =?us-ascii?Q?7Qiy+ThCACX9hvH/0Wmky2z4uO+btJDmnKXl4TEDWNI6nf1pyoN/OLWvWtGa?=
 =?us-ascii?Q?mXltXOii38b3CRoM+onzM10dFmEOl71uygr1omnxVEa12MTMsrTxj0Xyk9l3?=
 =?us-ascii?Q?lax1mdX7A36+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ed3d25-09af-483d-c813-08dbbe21fd8e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:49:00.1709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb9ItMCTFJQt8MGzJ/Ppi6Z2vELRWhBZV7gnp1om+K0BtQ4t9FJuATUhjf31bBVKb8ZWCziKCBAJoZ/Dro+oZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250185
X-Proofpoint-ORIG-GUID: q671Qzs-QNK0dNZL3hVuOoxUS69WXdWJ
X-Proofpoint-GUID: q671Qzs-QNK0dNZL3hVuOoxUS69WXdWJ
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

