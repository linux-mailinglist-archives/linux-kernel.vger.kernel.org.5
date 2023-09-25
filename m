Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BE67ACD39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjIYAmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjIYAlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB41112
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:41:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMddcC022306;
        Mon, 25 Sep 2023 00:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=0mwvBOvbVCLPNB+9wmhrfUT9UjP9vzveaNxuSnpXuFoChUGMuCYr//UR9P6zj9vJYvDm
 uz2ToE+4rZFu6I/EaBNjHQ0J7SCl18c0S7CM61QRjeJYWCTU1jV1fwzzYn3jCrzu6VCS
 QMrUVVAumSb/52P5vuHwFLgQOmntswxKyQToiaFuNJlrztLAns3F6nexf9OW4FxUiHsR
 BSZY5cd3J34AsXbL210NyD4SdbfwiDdUZ/pYDTdOMIQ6bAfr09UdLSBVBc/1ALCxoZ6V
 XwPoEe09tQ9MlwyMwSOrYMgZiqupyw31u4Ly60/+ZTND+kbu6XECBqv6eGHzyFBqWZLG 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxbtg3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMXIhI034971;
        Mon, 25 Sep 2023 00:40:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf418dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGJ/Y0fX5Yp8Qde+tG4jxMiC2+8VJVYKF6EPIWOHI7vMfut4AXB5RPFLA5xtFTaD/gNQ+FSOfMBpztrvsqvsIBLWpa8dGzz/7po3JhgHsLFCIQHM+QG22z61sGMcibCE3vJqfMlIUHS2s43nlD1mBwAMRZlAUQgyH48jq1EYNhGmxX3ALCXyshCjERTSAevR5C0FfPuxmru9a1GxavGK56ow36rt/hqHWzW3FzFYB6BSSzrFcQmLuSf5JUA/C17MO2SQmV4MQ9OaRlvWd3yzU2rg9ipQr4SVwcbj195PwUIgRE0LfMpuMaviLKgN6Xd9n309GiRVEoI9tK2Q4jFz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=Qy/kjnYZRh82QdLWPZ//ntOwHBRn/ImHJ1yapP74v+wS1x0cz2FXofNSN1r8YaDGjZOUqkJW/7gGZMRY5qB1AsZzdHLdjF6QNvnEFtNQBX+ncIKJtpdO+AuzF7UbWF0HjhVHibzRuJFJTR0aeJv1dYKVrsNhf+fA/zue2VHmiwzg3io0UspK36Ae+FzkhBedpEZe3mCT7PzCXVPAkrQs7wSOjR/1eCUvtCsTj0bBNWIcBM2NXP7UjNwFbfeADvHrTnGeYxhIiwjenXQBtvvWV4NfXnHUUox5OpLhvMmoGhc6/fP15IVhY3t+kf89C/uw8BcQCm3ir5imfqnBdtvVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tsc70UZvKWYWI+spZQiVZ3u2z8ZAo9dlRTusEOzzs6g=;
 b=o6Kv24iAnTi3QMTS14vyhYxUytbpNvOlMVIexZfNFnXKvHa4yK8EPdLOddABq2iPow+QD2LmcHWUoiHqPiltVrICbCgmPY+4+pK+sQgXuBWNEVUQ7joh6fsgMV/I/sgSme+2ISnOYose2xlGjjEDZiRDKUlciyfac2fyT7N4Qt0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:32 +0000
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
Subject: [PATCH v5 7/8] hugetlb: batch TLB flushes when freeing vmemmap
Date:   Sun, 24 Sep 2023 17:39:51 -0700
Message-ID: <20230925003953.142620-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6548a3-1225-4bee-9c79-08dbbd6005dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxDr31UBLqLJ28uFWeLsQ+mmrnDzDbHFA3guMGa92Tw0ZSWOI1ppmgDTnFDCmcYZsyJ5/jhP2/N25QLSZpI2sM/ErC2mW03hFhAwVkrTQT2QPCMYbzSS+9XxRhKNOl+ymqZ6Imtp63qd4K09rr9+q+LLOGDy5JUoqkkM3giR8uGoEcdkhmMyAiPYFu4iZaOvzYwUpUOp9UhwbJuoun0W2Sdebew7NxBLSBEopcawf4kUifD/pL4PDkP0KdVWDR3WHRMSkivX5i9/rfk9HjmWAvCmrUmSmPmRvDPuJQqyFM2nrxDDDGjmanHmCyqc4LCX3DiLFPuioR7KOoLOU61cBS1K3knw7/X0SYqTxanMp23RT3BtuKs3LEEkk3mJgqMfzRbP6gLvXGALXPalH5qmjfnvxPImjRfm/f0aQQZJac7Sq8DmUWLi5f6jlOUUNVxYGUIIusfJmWT3mPNTnztZ1Qy3TCwyuNeZCTQPZroWUVdYGXaIxNy7e18f5Fl39FBaP3Yo68DvznBKZV7ahz8VJJgUenuhhikpcVEoGZVrWut9+JoO2DQZ5CGW2SSBiNCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(6666004)(478600001)(6486002)(107886003)(2616005)(1076003)(26005)(83380400001)(36756003)(86362001)(38100700002)(5660300002)(6506007)(6512007)(66556008)(66476007)(54906003)(66946007)(316002)(7416002)(2906002)(44832011)(41300700001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+FT0U+rXagdxaBpXvRH6A8viVamXer/15pJdzxBzmHNHxt3QIJlE9Ike35IK?=
 =?us-ascii?Q?XxhoYb95DjTsNFWXF+VR7Tpep1CvO6teZb8+6ubAbIXACXvAaG3WU4Aci5EM?=
 =?us-ascii?Q?Qurccik68pgVGi2basPcr7LoJ27W/sllxfTfknzGfkKNHx5mO/RDzjDB9uQu?=
 =?us-ascii?Q?0w/i2C8+7E29mHKG16qbt9iNobzZYMvj4B8vNyKwbnJNf/VZEE44BxpUn1Eh?=
 =?us-ascii?Q?mnLFLlpGwOGJxmqE5n5OZb1bOkg2SMiCXIcnuo1IVL36/AX4WKe3I/eqVX5K?=
 =?us-ascii?Q?/5jxKxmtFwuCnuUHRHy7f0OCZmrmf9ScgiqIsDMdb9UcM9X/enaVry3o6pKB?=
 =?us-ascii?Q?J7q5u8tJAnPWpzJMQoiwcACWbstlmVES6R35aQEmQqsKu70+qeBSmF7T4AR6?=
 =?us-ascii?Q?u5bNNC6wAvsa63NdFG7PXW3sgOhU4r0azn36czlveh2SkeLXh72H0nNBMYhI?=
 =?us-ascii?Q?wQjQQJCQKHcKZVORBYd0QnTZlkvLA2dAVVqBkgR8enqi5koJQAN2VeHg/Vhq?=
 =?us-ascii?Q?mjWYXOUxxrWUDqOsdoQHwTh9aB1OzkAXpYK+T5xcabVtWCZF91BaOWeg4Nkx?=
 =?us-ascii?Q?qB8tDiBfJNFYqb6nn6Ks41/9u/6jnJjx0YaBh0XaMU4b7EcJQs/SfHq+/+tW?=
 =?us-ascii?Q?X0FCmauPWoDi4dhUrqcn1nvALKxn3BvHkmo5UKCD+CfoeJjw4z6lKmJ79bSr?=
 =?us-ascii?Q?V+hWEV6KpMVyyr39r1AVcPF64F/ku8c+Nid8H1h2CIATPevXLiDGgwm5QDU6?=
 =?us-ascii?Q?xuknUQCQ1XKlomNOAHtxiBqssTvVf+0xU9fWKf7S3U5hOjCC1yI5fMveX0pv?=
 =?us-ascii?Q?6OQ4Ww8zUdAt7wQwn1PsrgTsODsGRtl3tfDCT8anMrFW5EwTTVCSBGTiEjJQ?=
 =?us-ascii?Q?+N5n5N398KBAgijWvg1OonjABaIW8zdOGJ6QWq5zESu3dw757MYa2RWghv3G?=
 =?us-ascii?Q?aL9qUXtmeSp3L1KiZOv1z4ulOhmPuQfrQsI+Gm96JAJUb6E2JkU+h1QaWHiM?=
 =?us-ascii?Q?hH1K7koYsW7Gp/Xy71OxHJXCSsoC6UHs6h4FYf0wIRx/hLVof5eNwdIfZfxA?=
 =?us-ascii?Q?v/skAYYkFiLDzGPTtfR0DmTpAztNRtyNW8JhZfVHLCcHJWnE9pIkKBW7Eecd?=
 =?us-ascii?Q?WtLPgnsdU5OlpwZzLhvYw7pCcInRSClYUvIfoGkREaAPoCLqaQBSGKKB9dsz?=
 =?us-ascii?Q?0BTQvbNXvPu8sW5WJqdGiRNoOY5dFZqS00d7zYqbUqGPYGk5rRAAuJl/I841?=
 =?us-ascii?Q?0k652D08y8eqT6mHQW89aCHjDJxKZl8wkwfjr572YUWz76GxoVOx89KipBk3?=
 =?us-ascii?Q?S3KKlbcDGL9mZA2GFJx/lW/1Htt9E/SehGzl3lGU+xJW4rUjYMFc5K643OUq?=
 =?us-ascii?Q?y9J30Iq/NnOpa8WrAxYSsriQcLQTP3eIKS3HEhJhzYukCZ5o6K2l2gyuPdyQ?=
 =?us-ascii?Q?KE3qRTBkbL5FLdkjuDDqotP/EOONYzFgTPGOa/xYaRRubQN1Au8DhMqzpDcZ?=
 =?us-ascii?Q?bBOlblzfNjhYrE0BsRpU1PJrhILs2BM4479dVYwzPouPRrJzIf4d2E2qvRZr?=
 =?us-ascii?Q?WwAiffsXY/ngzisLTuE+Yk6wdhVxe/87HPEs68TB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gLDkoY78XwDjxK71tkdPLK32EdcLSYlIIpk23bxTEISMenCn5YnQ5nUGOMQT?=
 =?us-ascii?Q?h8henrECRVftCe3fw5Vrljo4LPAI5cK8TveTMe4t+dSHtsl78yqn+XmSyMKM?=
 =?us-ascii?Q?fsuTAVutaLO/tAjQKYw/ubP6yGD0CrnO0UoByOF41Hv4AWvO4fVp96G5Zs/Z?=
 =?us-ascii?Q?QNpwBNDIDgtWtSQit7KL3Dij6fdbYRz1FCm5GyElzvPcphRcDl0b4Zv54Pwq?=
 =?us-ascii?Q?0VZuLLXCKyLyeQ0X6R22xoprNbdMtxTN7/d011rGqinTqK+gmo7S+oSooXIP?=
 =?us-ascii?Q?TaKQ5XtHfS/Z5x9KaSb1g5TxtTpugfYByds/OucB/p9jebf62McczU1f7PKa?=
 =?us-ascii?Q?LACny95UQX7QOar/8jZHPBoaYRrViF+tghXaB0BzWExq9l1t4W0VJxaevFXl?=
 =?us-ascii?Q?4vh4l1fZBhoRhRuFpbBw+BfuMmOw4XGLkknx9URXJeT1JV4BxzKYC6JTwVSW?=
 =?us-ascii?Q?1grdFpdLhMdzQQqIOdO1kDpT0c6oSXkpKKPCnEXcowYBadTKIO8u18YDKZHm?=
 =?us-ascii?Q?Oht5AZOkEZI89LrTo5P7lETJq1HVS2LtUwOYonBZm4c8+26kPRcSNR9XxZrR?=
 =?us-ascii?Q?CltRIZpOpyY8IsJrDPEH/2dKFgN2jLN0qJxfQnMVgiigWgWM/f6AcR6NTz4L?=
 =?us-ascii?Q?QSnh35HoBWTukNoaqnkT+2peEgl3cMbzmto8bZUyx2pcJ8ARm9eAKratwEY9?=
 =?us-ascii?Q?Zg0eOe3j5tR8uYXo2BaeUAet0hvspe0m3ZVQAi1t5XXEHAnG9ja0evDCq31J?=
 =?us-ascii?Q?9qRznKt1MX13P6TsdVvt5FDstp4GAR8TxKrnMiXYHDNucAN+37eR7WKNa9GJ?=
 =?us-ascii?Q?iiaJPSHIj/HzVnekkL9lyx9mmeycXDO4fmGoX/11z1YrjUBY4k0nWLzUKmSx?=
 =?us-ascii?Q?oWCe1RX3TZgeTFGaJbRJHUR9qbCw9qGBsr0rRE0Bcfn0SDo7XFoJNArz6uIQ?=
 =?us-ascii?Q?MeUKKGstMjEPwPslO6nb55/RYm2V6MF5dUj1QWIuGZ/k4GYocOTPPrlotcGK?=
 =?us-ascii?Q?tPQM0YASMq7GmPaRXcqO1tcx4KyQuiUQeEA3gLsZ8MK6FKgKXoe/Rk7MdRNO?=
 =?us-ascii?Q?9M+1Ea+mSthGJq94K6wdg0n4/1WzsCFg0JLX/2GmyIIa51TqhgFRfFe+Vy13?=
 =?us-ascii?Q?1oFqzE8ZN0F9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6548a3-1225-4bee-9c79-08dbbd6005dc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:32.0203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHZO/MVh+La6u6QEaBF0pt3o3Im2W0WynsbBFfThtwqrmDmPuDD00ChygjMO4204N9L+fnT3nyKndrW7HZM8sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-GUID: q1r9Iwf7IgyvQH6_qtZinAH-tKL6oW2F
X-Proofpoint-ORIG-GUID: q1r9Iwf7IgyvQH6_qtZinAH-tKL6oW2F
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

Now that a list of pages is deduplicated at once, the TLB
flush can be batched for all vmemmap pages that got remapped.

Expand the flags field value to pass whether to skip the TLB flush
on remap of the PTE.

The TLB flush is global as we don't have guarantees from caller
that the set of folios is contiguous, or to add complexity in
composing a list of kVAs to flush.

Modified by Mike Kravetz to perform TLB flush on single folio if an
error is encountered.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 49 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 10739e4285d5..9df350372046 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -40,6 +40,8 @@ struct vmemmap_remap_walk {
 
 /* Skip the TLB flush when we split the PMD */
 #define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+/* Skip the TLB flush when we remap the PTE */
+#define VMEMMAP_REMAP_NO_TLB_FLUSH	BIT(1)
 	unsigned long		flags;
 };
 
@@ -214,7 +216,7 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	if (walk->remap_pte)
+	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
 
 	return 0;
@@ -355,19 +357,21 @@ static int vmemmap_remap_split(unsigned long start, unsigned long end,
  * @reuse:	reuse address.
  * @vmemmap_pages: list to deposit vmemmap pages to be freed.  It is callers
  *		responsibility to free pages.
+ * @flags:	modifications to vmemmap_remap_walk flags
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			      unsigned long reuse,
-			      struct list_head *vmemmap_pages)
+			      struct list_head *vmemmap_pages,
+			      unsigned long flags)
 {
 	int ret;
 	struct vmemmap_remap_walk walk = {
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
-		.flags		= 0,
+		.flags		= flags,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -629,7 +633,8 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 
 static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 					struct page *head,
-					struct list_head *vmemmap_pages)
+					struct list_head *vmemmap_pages,
+					unsigned long flags)
 {
 	int ret = 0;
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
@@ -640,6 +645,18 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 		return ret;
 
 	static_branch_inc(&hugetlb_optimize_vmemmap_key);
+	/*
+	 * Very Subtle
+	 * If VMEMMAP_REMAP_NO_TLB_FLUSH is set, TLB flushing is not performed
+	 * immediately after remapping.  As a result, subsequent accesses
+	 * and modifications to struct pages associated with the hugetlb
+	 * page could be to the OLD struct pages.  Set the vmemmap optimized
+	 * flag here so that it is copied to the new head page.  This keeps
+	 * the old and new struct pages in sync.
+	 * If there is an error during optimization, we will immediately FLUSH
+	 * the TLB and clear the flag below.
+	 */
+	SetHPageVmemmapOptimized(head);
 
 	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
 	vmemmap_reuse	= vmemmap_start;
@@ -651,11 +668,12 @@ static int __hugetlb_vmemmap_optimize(const struct hstate *h,
 	 * mapping the range to vmemmap_pages list so that they can be freed by
 	 * the caller.
 	 */
-	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, vmemmap_pages);
-	if (ret)
+	ret = vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse,
+							vmemmap_pages, flags);
+	if (ret) {
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
-	else
-		SetHPageVmemmapOptimized(head);
+		ClearHPageVmemmapOptimized(head);
+	}
 
 	return ret;
 }
@@ -674,7 +692,7 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 {
 	LIST_HEAD(vmemmap_pages);
 
-	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages);
+	__hugetlb_vmemmap_optimize(h, head, &vmemmap_pages, 0);
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
@@ -719,19 +737,28 @@ void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_l
 
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
-								&vmemmap_pages);
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 
 		/*
 		 * Pages to be freed may have been accumulated.  If we
 		 * encounter an ENOMEM,  free what we have and try again.
+		 * This can occur in the case that both spliting fails
+		 * halfway and head page allocation also failed. In this
+		 * case __hugetlb_vmemmap_optimize() would free memory
+		 * allowing more vmemmap remaps to occur.
 		 */
 		if (ret == -ENOMEM && !list_empty(&vmemmap_pages)) {
+			flush_tlb_all();
 			free_vmemmap_page_list(&vmemmap_pages);
 			INIT_LIST_HEAD(&vmemmap_pages);
-			__hugetlb_vmemmap_optimize(h, &folio->page, &vmemmap_pages);
+			__hugetlb_vmemmap_optimize(h, &folio->page,
+						&vmemmap_pages,
+						VMEMMAP_REMAP_NO_TLB_FLUSH);
 		}
 	}
 
+	flush_tlb_all();
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
-- 
2.41.0

