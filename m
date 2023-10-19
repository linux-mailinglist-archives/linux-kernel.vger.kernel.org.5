Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D797CEE15
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjJSCcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813A4115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:12 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIn0SC011269;
        Thu, 19 Oct 2023 02:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=4c5IqZK42Vm4yM8Bv7kR1mooPI8YiFYT1J97EnWLS/s=;
 b=EO6vk6+nT+OVnb2cK7NRyIYUEN//yGWZkXom88RGvrSs3wNKw2Ncv7Py0aAF6d97Se7r
 9yhmcD325I6WKslWcglpA8ZPfxyntyJoZS0dxrK6IlzMFScpMfDcT3a333xdT/es1w0R
 EpKpRTWx63jhK7ziglPPAcqQSPCOgSwbcrroWrWDZeN2Pwg9evdUqtOmqkc0TNY1FkAZ
 dc0l7way+yQ+NBCxy6QUJLJkwPjazTMm5rM8ddS5Y9ZP3Z+MSbU/KN4LJifgpUsU6YlM
 Z3jVFjcgyFfiQCkq1PvYcUZRRtT1tvkDT+E7VsMWyWpeKz8qsjFZ482yudfcDkD/dT6q HQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1chapk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1Fj28040559;
        Thu, 19 Oct 2023 02:31:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypjxhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/nhgas79P7pP71Nxgs0aUU1PQkE9YrVvyzTq97LRA1yUa9TNG5nSmpuR9hJmaDLqgIL0oz5e4SslC6Rl3gHNwIuiCDwc/uufwj2Vi5L7eFtBgGKIpbBF5i5Vs4H15CDF9LOnXY4WdIaSk2zqT1s4s94j00LbgcBbHCHPajLv0IxLQAxGygJw0IJwD9kEOcWW1WOa4UYBK0A0vhV35WTkLHQxd47ug3/BhW1ynfVuTUsWHGNNaLCX4bICb8amX0ynSzDhiNuToggSqTqGwCxoriQ+jtNKxI8VIPZb9krUwfGPRMaqDL7cxKGV2WxtZ6YhyXtwfwH/MaB83wxrGpCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4c5IqZK42Vm4yM8Bv7kR1mooPI8YiFYT1J97EnWLS/s=;
 b=UOHHqA2BLD9KMdN3faPB5yOzQtzSByeIqM74Q6jJEZjwXl5/M38y22MAI+zuAFfKKzfRWVyVi7N0rwC+o8rgHDGCe5I37eOKneW41i25ARZE1F0SodS0drrVQfmuWz9ohawG0RjEjsariMzKvG6HydMvX+7pxVd435C3E+wcrTvU9dSpEf8PXwj2pWkEEh5rsLUl34AcD+QNPSZk0La6wIUfFHYHX/mhhIgE68qDnRYrHQuCPzAnpUiN/2nVunnj9ApQqkOLvGTXuFX01MVLU+IEw5Vk8njNAseqYfi1UM3fBr72zuVFw9zqkqyukylLF+CJsYLMqcAL5FIspuviXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4c5IqZK42Vm4yM8Bv7kR1mooPI8YiFYT1J97EnWLS/s=;
 b=dEq+5mg78AiS8N6cx4JtjHRAU5xjt6rEZG5Ca0fOl3hkRip5+XB7dZeerisXy+mk73jV3q3uwVzsjvYvt2TpFiVJL3vKi/D6QbnHjATxrmSeI9BjyM3+ke5a+/SeNqzHPJ15KAXCCGRGQRw5Ld41RVpsSKTTjgZhpUecCRRR52U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:22 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:22 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Usama Arif <usama.arif@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v8 2/8] hugetlb: restructure pool allocations
Date:   Wed, 18 Oct 2023 19:31:04 -0700
Message-ID: <20231019023113.345257-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 6512acbd-ea0c-436c-d4ed-08dbd04b7c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ol85U+C30utmZk6axs3LWe3ZV+1SheXMaAwL/GXzh9Tnx6v3CzwWgcIlJv61w2etIyH5e0mJmVZkPWRSfxyiZ67SmYJwo+uXw2FKqOAzzp8GnpwwbHgX49bHfnm5k2e5RfZAnBGU7p0SKUV0cGYxMmhEfIY9fGEDADzHgvYA93yvTnGhrLNvNbFLKYWYbWYlDZz2hvv8xPF754Nk79CAeEmSr+8TmBvjsnPSsgNNoQs/GydDxT3ZBA+KeSu7WO2GLL4AWPegBz7BsqyGr47z38cn0EO0w4jh8xFvUhsQccnAaSD54spQIvog0SkHPCJT27nSliJnomiYtuwUDt5ruOoNT5UrB2DGrJEv34texTDNP0qa5x5S2RQS5ORy2Yx8tb3WKxddd8cHPYzCYXpEaD9oCfF06TS6J3Pz27WMarHkv8h1bz29kCUgtM0FgwRwFtbGLTh9gklmYScb6n6nHGMRVy5Z8GnMzwWzPy0cLat1ocr6ojfZcnFL+ckcLAK/9LKNBxYQDtYkLdK+H6bGk2nEV8lqHKRJLI3H7IMkJSOoBVmozaeRv4n2dD5VaJsb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(30864003)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zLKhoMdufj/dKhbKKHuCbeaa+NtT89uOFRPNwyTTokAiC9a/QTFDRyLmUVmq?=
 =?us-ascii?Q?wt4djdy+PKweyBU2cbuzZ3AUVPqOZ75DlchxGuPKsWMdfUzbXrthmhd1G4gk?=
 =?us-ascii?Q?6BAvSeitsM2GIm9yxQmZO8VaECw1hKzLgd+yOd9o9IVMRpnxBbgZlM/DJ28w?=
 =?us-ascii?Q?pTDq/PGZnG4lYgTV3al4OHfBXJgCPCBP4A3BOc3Bme/dQbaFsCWS97n/UUK5?=
 =?us-ascii?Q?5WoWe9nqzgzMFPnoAzNlFAtd8LmMO9skAX8+bEyjNtxczgN/Y0G8N4ibfQzL?=
 =?us-ascii?Q?PCnf/K2vykWNbn+nWHKeDuzDbaoSn2ujBQIYH8U7K3Fhx3wT0x+sh0GcrVhS?=
 =?us-ascii?Q?XSjAE8yGeZStUNzrAq92yQEW0RNT7dkp4SZPTuPrzPeQctezDfBjwCHm491/?=
 =?us-ascii?Q?oaNutOj7zRsnTD/gB6vVYh3cVG2cONHPkiMsfUfxgaWGZqYMYILqMG5rueaK?=
 =?us-ascii?Q?0Xu0kYwu/Rh53IM3seXwtWgb0y/nU4cDZc6QbN6XNdxIB5Iz5qkwvkGQ1YKe?=
 =?us-ascii?Q?k5lXBSG42SnYr49mCTHKnxk3e+GjnVHtv31iE3+NLNOEXZO7Ax43N8nxgKtu?=
 =?us-ascii?Q?IciNpIWJGJpLU1UGr/+0rn4TBUstlE5Px4CPz8T76o3NJMZtNCrmurZ3abf9?=
 =?us-ascii?Q?mOs3HQXtWVEOQ1xN5PdsFRzWDWp3XYoduPe6Pm9iO6rONHDqDcak+dBa3Y/H?=
 =?us-ascii?Q?9ocivZ3LpZgxkM/0JITgwpeeMFj14S5V74TkK/d4M6czxHxHRdkwA4FsPG27?=
 =?us-ascii?Q?QZ0v6J+pfnp66lY5UArBcHivSBkdK+CwKhQHqDC7tinLiIeD2x/Jor03Czst?=
 =?us-ascii?Q?Kc+w0EIy+Kb6h5l0hFsnBctawAs8cGs1a3sHJVC5Gjq+RcqUEuV1ajMkLpQe?=
 =?us-ascii?Q?8LYIwb+P4OXGQ2wVSwAOCSsydi/GoOU7JTJAg7Ei4+VAlqP5af665RY1RSqa?=
 =?us-ascii?Q?fztNpt3smGv3cMJ2yc48AqkSDkUM891OEqkzQ9RdLFW9KvOQdFzHdOyaR8du?=
 =?us-ascii?Q?Av2ehItETT/5M4K2GSDAo0S6kYEvn7VRuDgBV1R5lJDEYtaY5JlMRgQ053FB?=
 =?us-ascii?Q?FmtL5CiiOOMarmHBMYVAi+MaYYvXVPHw3GjdGQV0sHcCIBGzEFyVA/MBKy7O?=
 =?us-ascii?Q?MLKzWr2uLSMQqomoMj6r8p3UWao+Qcli78Q5iGngvOGAIps4VZ+XPc4iWAFc?=
 =?us-ascii?Q?/qkg+eVBG/OKwWjjJzQcdDIq1t1/9MUz/T2TGQVdaedKj2Q0zQ4bcZEy/xHC?=
 =?us-ascii?Q?UNduZdc1PmN9rixHAvip6aW759Y+/yBjbUJhqiM0dKKNFYlbnQsQ9QwktiR6?=
 =?us-ascii?Q?GLtj2mQ92kRfzUY9tAyzGMQBJ+55teDnJS4r391FNMJg2GVkLGmGiYGxxHgc?=
 =?us-ascii?Q?83bjIVus9kKnUSQGmU9wyIsXGCNkf39NsrqeA5tfmYcDcx3uRJiqucTiv+yY?=
 =?us-ascii?Q?jJQDgmwaAj9KPNN21iZlYCZq1MZ6vbQNPA4ts3UXhhLdEuB0S5p3cvd32CBd?=
 =?us-ascii?Q?uyne1rzByuGwwEooxw+3ihCZfPzwAI4NUZ7oFIxwgbQhN5vPwXq6sHzKmZ60?=
 =?us-ascii?Q?DTBJL9i7IgzyDnHm/HA6UtyZhNwi978POE0ZOVPJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mnj6MpeR0U9sJzeW6LbJC5hPgflG65vWl9Wo8/cA92riv/0imsI7npI9GH0Q?=
 =?us-ascii?Q?2efrC0B+45XCXMSfAC/6vT0mD0IrCN/8fCkFfWm2O+d7gOb/tDykkgGOAPYW?=
 =?us-ascii?Q?djvd9yrAVnNRSwMLK4W7a9ViHPvVbakKNqxTbRd1UZ05qO/DdH7bklGHhx97?=
 =?us-ascii?Q?txzxzhF3uGm6ygHh86WQ64AD6RUjCjCnAuSjkHVvOEIosTWeaw7Sw5IK8kZd?=
 =?us-ascii?Q?M5AJe6Sgeh4AeOuXVKFp4N/hZAVVMhEuJ6UQKvz0pnME6E5dBuz3Semh1tdi?=
 =?us-ascii?Q?3lrV15lYSf4DUYvuzNRbEm9BxzA72zog0UbsiGiORzgagblBgIKQQNoHHhND?=
 =?us-ascii?Q?YnBhG8dbTtCgG0CFeYW9dNSWTSU8j5D+WCtlh1YRWVdBiwaD2LYUQEP1+mUN?=
 =?us-ascii?Q?SwSuTXfg/QEKITaUEs2f/PpUpsft2w23y1Yr1tq17QboCOgeWdQN/NkrLak8?=
 =?us-ascii?Q?pP3N4LAqpMvxWmBFGOqLbv2wCeBkS9itSHrelJEgr4YSIn1FoyX6rLs77hkm?=
 =?us-ascii?Q?ZyyWayMBskUJBySqpXaFGfeRg0iB2+u6fmi/QP0Ree5qjpgzRBSoKy0e6/5P?=
 =?us-ascii?Q?w417op5umg8SpEuP+OGChgPMtYiGwhoWwyPYmb2Nx5/iE7IxbsFAmqKHjV7c?=
 =?us-ascii?Q?SRR4n0sLltrl+XalUDT9PIrZXwQ8RAXfpXdBteclIdHcXwUjRksEKtz18yS5?=
 =?us-ascii?Q?gGg7qFzPSYNt6Q2vaYUlRT7PpCLqAyFBu10xURcD8ehaaCnZlbToAxSMT1Sr?=
 =?us-ascii?Q?rfMaOVDt/HmzQWEbkCNSYcXmwCQ+53xDdZnsnXnpj2cs906TR10j80pPiWpu?=
 =?us-ascii?Q?TmqhRgwT7C+kcXt0kw/33R9kMq1/flHL/9KCr9qGKpk2szREfhr49vEvXvGZ?=
 =?us-ascii?Q?Tk3SRwqUaQnP49xgYSAK/u5ki0hymzZ3TFzo6E/ioTjNyyExd05OjTVl2UGD?=
 =?us-ascii?Q?SauqIF5Ohu0OekZYLawR6Y9fgHYzJRvvANODG69WKavWOWeTewvYrNiaB0ps?=
 =?us-ascii?Q?F7GCEDM4HAd9xSYCdf12gb4+ktuypyN9UtZviMCM7fsbObFL89+XXgwlTKQl?=
 =?us-ascii?Q?aicGVUAt49KgXxrzpedIq1S3hfwUK+XdKpr4GN58Asm3iT9Ik05/AiAcHBNY?=
 =?us-ascii?Q?qnbbZTsM4c8nJPCmy1eodKOP8pPhqJD7e6X+VMpjJLWQMCtCzk0Uwl1ZKqfJ?=
 =?us-ascii?Q?mCNV4gfqcbuPuucS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6512acbd-ea0c-436c-d4ed-08dbd04b7c0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:22.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk4ynaWvObqcydkrhGU2hFVuKGxNUWM6W2VTurn3eJGusykMsppbQ/fYlbLTTElTQkLAdx4LlvEha29cnIshpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190019
X-Proofpoint-ORIG-GUID: QLupo6s24mFW_aaMYypAYrj67L93WNE2
X-Proofpoint-GUID: QLupo6s24mFW_aaMYypAYrj67L93WNE2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocation of a hugetlb page for the hugetlb pool is done by the routine
alloc_pool_huge_page.  This routine will allocate contiguous pages from
a low level allocator, prep the pages for usage as a hugetlb page and
then add the resulting hugetlb page to the pool.

In the 'prep' stage, optional vmemmap optimization is done.  For
performance reasons we want to perform vmemmap optimization on multiple
hugetlb pages at once.  To do this, restructure the hugetlb pool
allocation code such that vmemmap optimization can be isolated and later
batched.

The code to allocate hugetlb pages from bootmem was also modified to
allow batching.

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 180 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 141 insertions(+), 39 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b839080a2a6b..559f7c71c596 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1996,16 +1996,21 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 	h->nr_huge_pages_node[nid]++;
 }
 
-static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
 	folio_set_hugetlb(folio);
-	hugetlb_vmemmap_optimize(h, &folio->page);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
 	set_hugetlb_cgroup_rsvd(folio, NULL);
 }
 
+static void __prep_new_hugetlb_folio(struct hstate *h, struct folio *folio)
+{
+	init_new_hugetlb_folio(h, folio);
+	hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int nid)
 {
 	__prep_new_hugetlb_folio(h, folio);
@@ -2202,16 +2207,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
 	return page_folio(page);
 }
 
-/*
- * Common helper to allocate a fresh hugetlb page. All specific allocators
- * should use this function to get new hugetlb pages
- *
- * Note that returned page is 'frozen':  ref count of head page and all tail
- * pages is zero.
- */
-static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
-		gfp_t gfp_mask, int nid, nodemask_t *nmask,
-		nodemask_t *node_alloc_noretry)
+static struct folio *__alloc_fresh_hugetlb_folio(struct hstate *h,
+				gfp_t gfp_mask, int nid, nodemask_t *nmask,
+				nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2224,6 +2222,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2238,32 +2237,81 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 			return NULL;
 		}
 	}
-	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
 
 	return folio;
 }
 
+static struct folio *only_alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
+{
+	struct folio *folio;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (folio)
+		init_new_hugetlb_folio(h, folio);
+	return folio;
+}
+
 /*
- * Allocates a fresh page to the hugetlb allocator pool in the node interleaved
- * manner.
+ * Common helper to allocate a fresh hugetlb page. All specific allocators
+ * should use this function to get new hugetlb pages
+ *
+ * Note that returned page is 'frozen':  ref count of head page and all tail
+ * pages is zero.
  */
-static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
-				nodemask_t *node_alloc_noretry)
+static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
+		gfp_t gfp_mask, int nid, nodemask_t *nmask,
+		nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
-	int nr_nodes, node;
+
+	folio = __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
+	if (!folio)
+		return NULL;
+
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+	return folio;
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	unsigned long flags;
+	struct folio *folio, *tmp_f;
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irqsave(&hugetlb_lock, flags);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
+}
+
+/*
+ * Allocates a fresh hugetlb page in a node interleaved manner.  The page
+ * will later be added to the appropriate hugetlb pool.
+ */
+static struct folio *alloc_pool_huge_folio(struct hstate *h,
+					nodemask_t *nodes_allowed,
+					nodemask_t *node_alloc_noretry)
+{
 	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
+	int nr_nodes, node;
 
 	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
-		folio = alloc_fresh_hugetlb_folio(h, gfp_mask, node,
+		struct folio *folio;
+
+		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
 					nodes_allowed, node_alloc_noretry);
-		if (folio) {
-			free_huge_folio(folio); /* free it into the hugepage allocator */
-			return 1;
-		}
+		if (folio)
+			return folio;
 	}
 
-	return 0;
+	return NULL;
 }
 
 /*
@@ -3302,25 +3350,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
  */
 static void __init gather_bootmem_prealloc(void)
 {
+	LIST_HEAD(folio_list);
 	struct huge_bootmem_page *m;
+	struct hstate *h = NULL, *prev_h = NULL;
 
 	list_for_each_entry(m, &huge_boot_pages, list) {
 		struct page *page = virt_to_page(m);
 		struct folio *folio = (void *)page;
-		struct hstate *h = m->hstate;
+
+		h = m->hstate;
+		/*
+		 * It is possible to have multiple huge page sizes (hstates)
+		 * in this list.  If so, process each size separately.
+		 */
+		if (h != prev_h && prev_h != NULL)
+			prep_and_add_allocated_folios(prev_h, &folio_list);
+		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
 		WARN_ON(folio_ref_count(folio) != 1);
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+		__prep_new_hugetlb_folio(h, folio);
 		/* If HVO fails, initialize all tail struct pages */
 		if (!HPageVmemmapOptimized(&folio->page))
 			hugetlb_folio_init_tail_vmemmap(folio,
 						HUGETLB_VMEMMAP_RESERVE_PAGES,
 						pages_per_huge_page(h));
-		free_huge_folio(folio); /* add to the hugepage allocator */
+		list_add(&folio->lru, &folio_list);
 
 		/*
 		 * We need to restore the 'stolen' pages to totalram_pages
@@ -3330,6 +3388,8 @@ static void __init gather_bootmem_prealloc(void)
 		adjust_managed_page_count(page, pages_per_huge_page(h));
 		cond_resched();
 	}
+
+	prep_and_add_allocated_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
@@ -3363,9 +3423,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
 	h->max_huge_pages_node[nid] = i;
 }
 
+/*
+ * NOTE: this routine is called in different contexts for gigantic and
+ * non-gigantic pages.
+ * - For gigantic pages, this is called early in the boot process and
+ *   pages are allocated from memblock allocated or something similar.
+ *   Gigantic pages are actually added to pools later with the routine
+ *   gather_bootmem_prealloc.
+ * - For non-gigantic pages, this is called later in the boot process after
+ *   all of mm is up and functional.  Pages are allocated from buddy and
+ *   then added to hugetlb pools.
+ */
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long i;
+	struct folio *folio;
+	LIST_HEAD(folio_list);
 	nodemask_t *node_alloc_noretry;
 	bool node_specific_alloc = false;
 
@@ -3407,14 +3480,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
 	for (i = 0; i < h->max_huge_pages; ++i) {
 		if (hstate_is_gigantic(h)) {
+			/*
+			 * gigantic pages not added to list as they are not
+			 * added to pools now.
+			 */
 			if (!alloc_bootmem_huge_page(h, NUMA_NO_NODE))
 				break;
-		} else if (!alloc_pool_huge_page(h,
-					 &node_states[N_MEMORY],
-					 node_alloc_noretry))
-			break;
+		} else {
+			folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+							node_alloc_noretry);
+			if (!folio)
+				break;
+			list_add(&folio->lru, &folio_list);
+		}
 		cond_resched();
 	}
+
+	/* list will be empty if hstate_is_gigantic */
+	prep_and_add_allocated_folios(h, &folio_list);
+
 	if (i < h->max_huge_pages) {
 		char buf[32];
 
@@ -3548,7 +3632,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3625,7 +3711,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3636,15 +3723,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 		/* yield cpu to avoid soft lockup */
 		cond_resched();
 
-		ret = alloc_pool_huge_page(h, nodes_allowed,
+		folio = alloc_pool_huge_folio(h, nodes_allowed,
 						node_alloc_noretry);
-		spin_lock_irq(&hugetlb_lock);
-		if (!ret)
+		if (!folio) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		list_add(&folio->lru, &page_list);
+		allocated++;
 
 		/* Bail for signals. Probably ctrl-c from user */
-		if (signal_pending(current))
+		if (signal_pending(current)) {
+			prep_and_add_allocated_folios(h, &page_list);
+			spin_lock_irq(&hugetlb_lock);
 			goto out;
+		}
+
+		spin_lock_irq(&hugetlb_lock);
+	}
+
+	/* Add allocated pages to the pool */
+	if (!list_empty(&page_list)) {
+		spin_unlock_irq(&hugetlb_lock);
+		prep_and_add_allocated_folios(h, &page_list);
+		spin_lock_irq(&hugetlb_lock);
 	}
 
 	/*
@@ -3670,8 +3774,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	 * Collect pages to be removed on list without dropping lock
 	 */
 	while (min_count < persistent_huge_pages(h)) {
-		struct folio *folio;
-
 		folio = remove_pool_hugetlb_folio(h, nodes_allowed, 0);
 		if (!folio)
 			break;
-- 
2.41.0

