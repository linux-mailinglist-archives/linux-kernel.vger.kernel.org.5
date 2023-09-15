Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434E7A2A68
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbjIOWXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjIOWWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:22:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837FD270A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:18:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLuFXh023028;
        Fri, 15 Sep 2023 22:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=E2k0SQT9AAGQbQtl+bCcx+uvnWZgNmigsOuLewx2GeI=;
 b=ly8gISQIduGECkkwZ06y9RXpS2fA+IIhrOqw4lUgKl+J++zsyGNPSHylboQo6MVd7jfS
 JxX4kLgg0UJ4m2Dz1kUgfVDAkJQejPJnmLa83bT4nU3V9xTWBCRRDyrAj14Q3FIKUeIA
 bLvaIrF3VzG4VyN+BgfZYUU+Be7rDtbBGkfgku+pJvdLGDhg6pGCwOJvk2Dk3vlls3nI
 tk0SBlDY5lcV9G/1fxPHbDImYIkIaY1vTS3lv3DyLUbu3k6enERNNjdLRlPmN2p0xTPS
 W6ng9Ku7Y5rh2YheOkpveg+C69lSj9Doaw1ZBpK5WxLogTNAXcn4N7Vnl9i9tv3rpoPX sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7n0k4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKouGE036194;
        Fri, 15 Sep 2023 22:16:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gx8vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSQXZmZt423On9BPQEGFLrZRo6NNTHrdrZFiuBsvLJfzsHYAwY7kWLwqvJFCamIE1I89/jg/t+7IWMrbUhAM3PCCFp6GuSziSlKRUwa7zATka+HdhicXSlZBbSirghcr1IqtubqOE50F6XmXku6PeHr/sxlV88s/XyJ4mnsABydgbEFOAZ2Mq5e/BBqi3TeMGr4cCFKLYv3S7hvVIpmU9GtA9redlW8xsqANcmtF5oYG9upin3rnKqs/WF9S2jz6XH1tAUuqGVxtoH51LZHeGDnewQc1C8g9rgVrxJfMK0oGqu5lxwr76Pn2HgH3/K+dESzHRnaKRIZGoiud7jpNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2k0SQT9AAGQbQtl+bCcx+uvnWZgNmigsOuLewx2GeI=;
 b=OCTxwuXW9SwQlCmVR5PlqvQMOgT5YqkfOq60akXMKYAfD0qRu3FStw75grmYl4GUqqrcbbkJyZOPi9a0rW2mx8isCgtghrrQnVIi+QV9Fv5/kiX3OerSv1qv48N7d5OFCBf7kGA4eEsnTMNmfuIXUFQfaZB7ucm6ddZ6AszsJwfACXIoAuEbeA5k+DQSvxzgwruqJ2pTbJql4gpQVHsOjSS9dzUx2AZ40pg6aJr4J2AaR6J05OcL99HCVMJx9FtQ1IgFw9GDwtoh3KCQcrQVkQ189kmdd/IhP2q7FdBG2M3H4gJEVPsjg2wc/uaBqLtOY6sLBP6Qbr/0HYw6/ci1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2k0SQT9AAGQbQtl+bCcx+uvnWZgNmigsOuLewx2GeI=;
 b=vMj+Us7hWWunwFmjXN1MK9fNTcUM8YBilbhPWn/SpbU9Zd1fCIdr9h0LfyrpfAxFPNH3Ymf38L2ADjeNSapKldE3tMco7seaLF5Y+WZWjUe9qPGWZFCwbII0kQPfAilgmugQ9knfy7zTT53ykJNbzbpTbduORuyKEw5YqPlWKSI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:04 +0000
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
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 04/12] hugetlb: Convert remove_pool_huge_page() to remove_pool_hugetlb_folio()
Date:   Fri, 15 Sep 2023 15:15:37 -0700
Message-ID: <20230915221548.552084-5-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:303:b6::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: f08e84df-54bd-480b-259c-08dbb63959dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2eFw8VLFi0cIAzJau3IJqeB9mLZzIgxYgmle+RLCtK+a1Op/bCUSayXcuheR3BJjnRTE4iHYaIIS/oSkvhZnmaYlHxNXa3rchzNvhx1rwsS+g3ls7OUy9wKJp4JGHXPuquCPS9tC30nKWYETgfDFqSA+6iIKweNj4ATHew+3cd4BDyDbpZo6BE1WE9ccIHQdxVNdZhSx8GoSIxcQSVvSFGUM3b4kvYFg7gs9VpUkaBY7dbPC5BnaviE9Sw3eR3JP3/8WbBSPHcvTEyu7xHypy3T67QUW1dn/L8Pu0O4TqX+5SrqpHirTJW4zRZuWjOuAPlPCuhVcNVAEnsWx9KnoT3PkTx52TTvTJzp78tf57fqwe5Y1M5jPpBZOWbSLMezqNXI5GScimpLGLr/dlAdB+P63x5mgl3APE8R4/+iibcEKxybF5Q9XHzy98EkqrUaMdkGBZ3lxA7Tl3mIR6pT5RCG9ghmOtpRS36Ku14YEbAhmsABdSI2HpL7GbzDDc65Fhdfg/GnSUC4gg+CqImaW90Wfz+zTe0e7h4nyhjTjZXNyEW6SCwbVElG0pYh2VVTZwwMp5ncoecCFFgGAZuvmv5cHhm/IcTIirVV8U2qfl0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRRLcbcqyPn5YYlMAlDzeplPVRPUeP0zX4vvVRqZpdzcpm+fBE84wXbv32PW?=
 =?us-ascii?Q?evFQ8rtBWtlJZgXhKAmpIQtk5VeXnBl0ttOmjN5OQAZGfiBgomw6c4bOQGFT?=
 =?us-ascii?Q?8lzvYwC8EK+re5TVoQp9m15GRz4j/m2Wuf0/j+WXJEMtfHe/QxXv/u/OJTWX?=
 =?us-ascii?Q?fEEZCIef/VlioFAIKW5FLX3gTPrlY7+K0Anwew45NnSeyIlt8Kkm4bKVuBOv?=
 =?us-ascii?Q?tCu6vw3BLUqDHy5aZhZbScpFCNjn9ARuFjB+ZLY133kluOkN8xgWwscUuOKM?=
 =?us-ascii?Q?Gcgr2K17J5t9+Z5pfsQifXuWWC1LwHene69ZAUkP3q7tOUg/auKnV+57Qnvb?=
 =?us-ascii?Q?NpLmk76E1KCgD3ZwSKGODm9/qytx5RsAZqaDbp2XRJ+NBGJnsfHnH+Sdgt5j?=
 =?us-ascii?Q?Lc4ahtRp+efN8c5+Y8xtTZ5xFQVD0g8eSQvE8FKpZZXfNWfCP5IUcage83mF?=
 =?us-ascii?Q?y678/7piyXCKWIEZ5Ha+z7PPFORsNcx4Zo1QXebfXnFW5YX6XD+wAOl91FDR?=
 =?us-ascii?Q?0WC2JtVgUTtYt3OjDf2mtNqzwCe4mwXjWb9QnuvUXfckRuPZHFpvNiTMIZGg?=
 =?us-ascii?Q?czVPZjfvWvXs0ssvOnBRM4mFlzMxkaiRPmIV+ouv99tTT78BI/9EnvaZq385?=
 =?us-ascii?Q?fSUF/Cd8i7v1Gr2kPqhNKpHF2p0tK1pJn6z1riJlWFOz1Op6CEfMhmPYMkuX?=
 =?us-ascii?Q?fwfl4+vtE4LlKUryMguKecdyjN5SCaNXbuwegw2kI+oWz7wYV0u8duH5amA4?=
 =?us-ascii?Q?c73VW8fhLzcoYwLRkeC5zR3QqBE87iCxsWs3ZzoHO/+/2i2JjDsIIyESYNj0?=
 =?us-ascii?Q?p4rGxQgHgwQenJtzaQ0abYGHqOcI21iLjIkYCD5DBwC2vjgPbvWVchdVejPX?=
 =?us-ascii?Q?xN6L2Zwxzeqe8hvKu908HB4V4LgN4IgUQfS3+TSNZD0IUjQdkxI5dOFVonXC?=
 =?us-ascii?Q?CDWIjxTDcZ3TlfvLnwGveQhBjT67g0XkKO5ASwL30kzBfz9nQKQiU0Iw21Uv?=
 =?us-ascii?Q?0Xo0Q5RIxb49K4zCm81OLtLsuZ1EIty/o+9RtKUzNZasYI2nr6GKZU0YYqu1?=
 =?us-ascii?Q?KElKEEecUe9i15kT4kSAd5u4HlyvqIsVtbo/2/ySS03P9Qz1BxqUWS02xreV?=
 =?us-ascii?Q?/5Ep2jDAYaE2DvIZ/SepfZU4Vjr/M8M6xlZTxHT/EQkxZEk0INeHpFNx32YV?=
 =?us-ascii?Q?uSjT9jlBDvlB7h2Ja0qr17k9mb+PjRfBPaCBezEUi8r5tIAkj2EoKSl7vxeN?=
 =?us-ascii?Q?6Qe5f2aKCnjQed/IOmxlk5Q35Z/EnnKdOu+ZOrfLDRvoMEImFLDLjtU+XtUm?=
 =?us-ascii?Q?8cJFO/5J2bWk8V4LFI58d/Y2da24A4C0ZQltFwwNBtF6Z35j663MYlBzpgQ1?=
 =?us-ascii?Q?uxL3KB2hZ785+IWPh0jJtQCGBuuyFMNhfSrPyShvSUoOZTvJ8QbJwk2lNLNT?=
 =?us-ascii?Q?zFaR9C9bcU+Nx2+nMCeJEQ7xtWTqlcWYDocPOfViEMu3G97HAf3v3KTGY55A?=
 =?us-ascii?Q?6uEK1ocrjsmzDb5lcBEFJDNg5RFe6YQn75DkLPUbr26H6M/yp272ZDDQ+nwF?=
 =?us-ascii?Q?XAD2WfrcsIiT6QUAuDBVmwYL6R9v4xhwhEyCy1ff26JgMdIf2a2cfqFZkc2O?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Kxru561f015MUwRRcV5V/q6KhauhseexIv22o2YqKOSyYyBrFPw1eVbzt4Zk?=
 =?us-ascii?Q?V/+qoxiwQeBj/CFa2Ul9ybW2PCJp1hIh34VRvUzKOkgFA2pBQANMbqnIthAW?=
 =?us-ascii?Q?g9YYFYKyecH1BDId88B4tJ8NdyiIvXogmKKk5+UZkigCvRRwhZneSXZeUPR3?=
 =?us-ascii?Q?Mwq9/gAYnkrgCSlscJ/mfjmnyjyTcGGocAM70hhOpiGBcglo+cKusLUKASgz?=
 =?us-ascii?Q?Ieb/DbKTwW1xhvfAt2zgzyJaoiCAFApp7StmdDNL/NREZzYVR2J0NJDZ72X6?=
 =?us-ascii?Q?8o6R2eTLSRZJYVDN8FmuS3uyG6BBguO554DvqfPgGJ4dCthQXepvkDEZJVxM?=
 =?us-ascii?Q?mzGuUfd9YgI/z0dJ1HQ+Xj8EAbxIrOx5vrZW8t9uG7RHLlMTt9u1Iwfa0YKh?=
 =?us-ascii?Q?ILtwFA8QhmILa/2MPZate2fhMHvFiboMlJI6gK5pLS+aoFD512kIjfNLPM34?=
 =?us-ascii?Q?GpkpeTPxejs4CnGAentrmCXk9wEcXrQWzyl1sQ3uvU/rXeoI+QpPS9b/HbJM?=
 =?us-ascii?Q?1FlA3DFGLENxganzdlEJdEe8t+bO3utVXw5Ax1UO1kLug7kcFQomqCnaEeH3?=
 =?us-ascii?Q?2/YVMI5BhY/iF/zDbVDjpf2HFpRN/8Xb3AJ76BA817GPwjnOXorKJ8r2fASn?=
 =?us-ascii?Q?TXVNG8gf5X+d4f8l1S+QZnEQ4bHnNG2aMw/0p0EQgC8sdNz9eZbIYXI8vdNo?=
 =?us-ascii?Q?mZNoZtpT+WRWHnPgjlPLBMbsKZIcaaKQ44LzAKooC45bpPENx2Tdh+hLTZ1j?=
 =?us-ascii?Q?hfRyq4SGC39tA3HWpeEpqny2y4mnvIbLS3KF/GTOJx16Cvj+mDVEvHjwOAK2?=
 =?us-ascii?Q?LNv5hlCAzo7xTAeEustfn4jIMoncZdK2gv+K6HBqbg8fQzEnhY1Qvw/cbx2/?=
 =?us-ascii?Q?G0T6LE7FzF5z2OogsbzC223xO6LXRSUJXKX0My0RT30uoXB0cYImw1rw4tfl?=
 =?us-ascii?Q?4PKt4nxkm2HTq/3D1KcYWpHm9RE3gPiA+ge7Ace7zdY8AZXzKPuNZpmwdcye?=
 =?us-ascii?Q?putyVoAaqgmOsJ17BJcGlN2sJRS5t8DJ/Enln1QbC9f3OjQcd3KPEGrdvUUM?=
 =?us-ascii?Q?KyWhNviimhafha4lTFIbvbH7nmxHB3EzN5+kCfBBTzHhf5XNboq3UEzJAxLY?=
 =?us-ascii?Q?Bbbv8mpNNQgg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08e84df-54bd-480b-259c-08dbb63959dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:04.1538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5wgSyNR6G09XhUHTGGdZ4lUBaziCOffsQYidofdwKijflM0C1DaxD0RpQMvLxTsgv3kNQMrps4R6wql6zIawg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: PipOTme2fxSCDHfAyj52zXp3pQW0KwHa
X-Proofpoint-GUID: PipOTme2fxSCDHfAyj52zXp3pQW0KwHa
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Convert the callers to expect a folio and remove the unnecesary conversion
back to a struct page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 7bbdc71fb34d..744e214c7d9b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1439,7 +1439,7 @@ static int hstate_next_node_to_alloc(struct hstate *h,
 }
 
 /*
- * helper for remove_pool_huge_page() - return the previously saved
+ * helper for remove_pool_hugetlb_folio() - return the previously saved
  * node ["this node"] from which to free a huge page.  Advance the
  * next node id whether or not we find a free huge page to free so
  * that the next attempt to free addresses the next node.
@@ -2201,9 +2201,8 @@ static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
  * an additional call to free the page to low level allocators.
  * Called with hugetlb_lock locked.
  */
-static struct page *remove_pool_huge_page(struct hstate *h,
-						nodemask_t *nodes_allowed,
-						 bool acct_surplus)
+static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
+		nodemask_t *nodes_allowed, bool acct_surplus)
 {
 	int nr_nodes, node;
 	struct folio *folio = NULL;
@@ -2223,7 +2222,7 @@ static struct page *remove_pool_huge_page(struct hstate *h,
 		}
 	}
 
-	return &folio->page;
+	return folio;
 }
 
 /*
@@ -2577,7 +2576,6 @@ static void return_unused_surplus_pages(struct hstate *h,
 					unsigned long unused_resv_pages)
 {
 	unsigned long nr_pages;
-	struct page *page;
 	LIST_HEAD(page_list);
 
 	lockdep_assert_held(&hugetlb_lock);
@@ -2598,15 +2596,17 @@ static void return_unused_surplus_pages(struct hstate *h,
 	 * evenly across all nodes with memory. Iterate across these nodes
 	 * until we can no longer free unreserved surplus pages. This occurs
 	 * when the nodes with surplus pages have no free pages.
-	 * remove_pool_huge_page() will balance the freed pages across the
+	 * remove_pool_hugetlb_folio() will balance the freed pages across the
 	 * on-line nodes with memory and will handle the hstate accounting.
 	 */
 	while (nr_pages--) {
-		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, &node_states[N_MEMORY], 1);
+		if (!folio)
 			goto out;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 
 out:
@@ -3401,7 +3401,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
-	struct page *page;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3523,11 +3522,13 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		page = remove_pool_huge_page(h, nodes_allowed, 0);
-		if (!page)
+		struct folio *folio;
+
+		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
+		if (!folio)
 			break;
 
-		list_add(&page->lru, &page_list);
+		list_add(&folio->lru, &page_list);
 	}
 	/* free the pages after dropping lock */
 	spin_unlock_irq(&hugetlb_lock);
-- 
2.41.0

