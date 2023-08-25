Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556A2788F24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjHYTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjHYTGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:06:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606B2133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEPRi031105;
        Fri, 25 Aug 2023 19:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=JDqlank9XT0iTHl7uJPws1K8LVzypgRE+WIqntsMg+Y=;
 b=IhTUKsod5lykf5PsPX8PHVHBhgVkcRSXqe2IOxauGL1eW0e8iSLRsAMbWAmgk0pAYx7r
 P4DcvlpS1Um9Q5m31XR6xL9roKH0blg4Ul30NanmL2hKbA/Uem9pHJUULDR/OCuBsJmN
 HTwLRWLuR50eJc6K7+iu+Py/KvNfLfVfb9ookm38g5dMJDOIk51OSebsxG0EuH3djnmE
 3+RC8zVwzU6o2hBYb5Cm09QEWD2atrSXcK4PZK9KI3uHyMLVHnKDhSKmaIJaTffeXcMH
 q1trYqQGGa+pBP+3rzUVg+ayRfmIAky3DmTEnVmjYmDN4ofb5l1vseYJ1KYkYVblIYLL Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PINm49036073;
        Fri, 25 Aug 2023 19:05:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yxqsmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwPgDGm+y4wgSJF6v1OViwtjzGfy0sZG9nhPBOZ2sSo1Vq0BCa1w8Q7tCBurLdXNdIJZQB9yCoIJdgT719z/82coz3hjW0mx1mru/Pr1cUw7RQsKA5bGpZIBNqsbzP2gdg/DP0SCUyJxsxeDdOPzwTa5e+pE1pgXLzYXJJAgzyhwBEUiZmNX0HPP4tgLIi4WfaPJzw9MtxyYlGlsE7Fl+ShuWR6bMVGcwi22McLbud3afMvZY5YZg81Rfsd/zX7dqoKV97rZ7v91iRA9uTgNjTAdqLnMNrg4Fa4Uiy5d1qhe0w8fSzqiTnkR4bc/548MOzGy+Ho97U28XqrCNmOdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDqlank9XT0iTHl7uJPws1K8LVzypgRE+WIqntsMg+Y=;
 b=E87cFLV7YQF957Afw5VM7jXbV+xKZD4a60FnVUZrYXWDLeH9AcQbrzkqxaroARh0wJT3yZQ2PZpxK9VQ13VIB+QgKn8Ng5KFTen1aRnw0TmEN53pL0k4/qNvS+gOwH+chCB9ptVG3dwpd+X7f+sYUIzX2VFnpw4O7SOIcuHSQvhZ55HdtWKlP05KZGApNFC3Ug6yAHKLQbjsCgMHshJ5swQQEH2qTFDWVsgZhXdgIDV38EXNJMnU11wYX1GRkqx+THwXK6+RqSwd/lXo/+WvBs/juv+Trhz5TnHiilYlKWA48BMbkoOVatoPGGwwzLjtyQAn2b5sbXoks8vKm3IGvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDqlank9XT0iTHl7uJPws1K8LVzypgRE+WIqntsMg+Y=;
 b=odZEN5/LwlJEIqxrW8QHKwNdm9YxXZKCR10GiklbtNjI1LEbAx+cJ0Txr32B3JUqnsuUmo6yceLD7dSuElqKCTOi6jMGwEHxoLt0/vTpdLvbrrS6AW+xotN0zpuLoKIa+yK6LFdF3QGQ57agnOm0iwNO0go/thg15JHedfl1gIA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by PH7PR10MB6580.namprd10.prod.outlook.com (2603:10b6:510:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:13 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:12 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 08/12] hugetlb: batch freeing of vmemmap pages
Date:   Fri, 25 Aug 2023 12:04:28 -0700
Message-ID: <20230825190436.55045-9-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:303:b7::18) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|PH7PR10MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: faa1ee75-cf92-461f-6b21-08dba59e3582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1G07+/q13KIfsIP4PVmRWyQ/Blx7hgWZDi4K0J8+tpF56E3KB3oLL0A13Znha3YDvnL9FqPNL91GtSxm/i95g22jfnawDeSwx4wDzoXP3SMpxnPerEN7IWh6545wXA0nCK1fTYTGnzELhjWYooacVKh3ldjbn3WbKoKKWMaPGyPpMW22+er79BosrZ7j0UG+AzBUjSj9xrtZQj26L049ekJjIBHAseqlf/8RgHFsabelj/+YZSkAmPW99qlQnbGLAECXnd3c8/ZXq/QkAJdK53MWmnb0XwEjZRd5tGT7Lyp/3LN0VUYN8rp4nfAXsY7HF/T9qF7HXIeni73y0QhcZQKyEJtI4wCEUOwoTCi2FiwTiknMfcEx1TsUuMbSsb+dOjIj1rf4eyL0PL4AfZxicZz3b5Deaot4EhOJjOKANFeakhBxuyg0AQlu4R9L5+j0mEMDdS8oYD1pP1e/JBRYf1XdnaTu5JPZHz/BmNpA3RAGzWcFvgoFDulNLLfmqqRdQDlWMJ/Ue7VmZEYNHmAxuplGjtXdTwTL25Rg7PhbqrWd1h0iGaxJrmrGN/Q9pOnQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(451199024)(186009)(1800799009)(66946007)(54906003)(66556008)(66476007)(316002)(478600001)(26005)(44832011)(6666004)(38100700002)(41300700001)(86362001)(6486002)(6512007)(6506007)(2906002)(4326008)(8676002)(8936002)(1076003)(2616005)(107886003)(5660300002)(7416002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ew38Yk2Fh01yvjBlSgvmdHu6QAmLurm7gQXxTBKvYoLxUoObZx2Xgo9ReNtr?=
 =?us-ascii?Q?/XVAfH+YZMDXRyOMaSFH8Y8VaI64x35cBMu33HVrGNKtViE0gieDHYrs9N9y?=
 =?us-ascii?Q?1tv2ORfnOP8r0j0Rz6BroxDWU+BKLusiFA55gTlQTHDdmH8ZCKgg4udyBY2T?=
 =?us-ascii?Q?cQySMNpV4NvzkFm0wCEQ2iUGUi+n/2VnLYtQsrZ2JPkjrz9IntHVpUtknvov?=
 =?us-ascii?Q?iIa6QGLxCUgRtwMB3kmPQMBJhPa7wLuOIkEgOafm6A/l2GwzJVSljedCna1j?=
 =?us-ascii?Q?pB5vVHz81VCEdYsReC5zfWmSopyI40TevfJIOWqdQcieMIGjnq4dvrx7QHuL?=
 =?us-ascii?Q?icEX7lS9t7AH0z0GkjyqxjbXHgaimxL0JOBJ5/NAr3YW72Mt6agU+NKPUhl/?=
 =?us-ascii?Q?HMbIDEQX53jlnJ/EzrzH5pn3dSqOmXZlfiydS+pDjsCUvxa6HVRzf5zy7/8p?=
 =?us-ascii?Q?Fia/52PSJ689rGZyM70yX4beg3YB+Mc0+lO8eJcosJw5+kJT62nl4/6dVDwi?=
 =?us-ascii?Q?3KuorjZZYt2NNPGf9RVL7rO0BCMx4fDZaX/zmbc6C1rJwfloAIuJYUo5EK3u?=
 =?us-ascii?Q?BzCVAyVxAL7ypzNEhmUfqUGbtLksHbu6hi6bu05x0kObpoVUF09tKvpF1BaR?=
 =?us-ascii?Q?RbkfCB1qemALGzbyASUhYSFwskZoH5clKCCMqvjbAdbtE5S1PKY7NT/ucPih?=
 =?us-ascii?Q?SOkpI07ZTAg4OBw0zH5fRCncMVqbagMM+k49kyaxwpIvWje70urCQzh1b6hq?=
 =?us-ascii?Q?QWvcHf1VLEHj5IWzaRZ/d4LK0+0z5sXO7LtxPlHHcwvleM23SXnQTtshI2GZ?=
 =?us-ascii?Q?MuawA1G1JB/ECyT+XHM4n1zEwJ2vqJI8p407mchr9ztx6/GslXFpLzRFSMB+?=
 =?us-ascii?Q?m+P7MwXa2gU/wUQSMVouPssE2TlTAYZ49f685sqOm/l5Xx1ZKaiAfUd0+kLO?=
 =?us-ascii?Q?Wr9A8d1aTXEll4HlfNLMmXWB74trGgeWWNNtniwJ8EKBMEkk1voXwC94mweE?=
 =?us-ascii?Q?hYhjiyWKOUEdWF3bLb5w3N9xcyoH9m2uT20Y8gEyqsce38E/MBzpPy+xmaab?=
 =?us-ascii?Q?I5Qmg502bPwP2dSyqOZjxqVBORAwyAMMvTxQBi4SbL+fXNADJzZVQgv80PT/?=
 =?us-ascii?Q?TyNKstYLTl1p+rbhgZEthmoHcRj6TqRyiWlnkE+OqOmaTzPDI2XGHqWoSQ6r?=
 =?us-ascii?Q?N4CHRaKUiduJKzsst0+UeVbGwNoRR8bN6i9NL7murJU16BmhllKbdS16HHgk?=
 =?us-ascii?Q?m7Le2WOhkmv6uGtoaQ6ZzQOhDdyI1IEw6i+Lxd9hqQ3cbdceapdqqjEKwsOI?=
 =?us-ascii?Q?wTzoKCCrrjXskgQzMhz263Kqprc584yGRL0CH+v3s8Qs7S1hOr7VBAkAw/Ou?=
 =?us-ascii?Q?6RD/qtI3OJg4yffCM8y4oM2V00IdhYp9uVKdOW5NHk7TF+g4WKBM3nmO0OgA?=
 =?us-ascii?Q?PdQOEueVaBywQvcnoYg8zNJQ0JdLPrZi5dCbpdP/cbYhHhuUnBu5nC5Pq5JR?=
 =?us-ascii?Q?wchTF+0nGJ5OvZQFXHkRLBP67w5VXQTgSiUvITUsuHUnHO8qNxZwMWqcZMh5?=
 =?us-ascii?Q?BJEJOrW8sl8qvHuWe6WI5kWHEeGDMgILPyn93kN+NT6GaRTunrs2fPS5V2tB?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?u37lmZ0ynFClxHAdrhqbcrbYcI7Yg+/TTocAIB8ZgyRFwGg/yWXsMEEh5lqr?=
 =?us-ascii?Q?l0Njbjxa/trFX6ehFhlgB4Z1UeEPgCX4rFtN3gR9uB1GCQEJ0mu3C0s8c0j6?=
 =?us-ascii?Q?ETzs42IqHWOpyOnsbAxHWv+YOB3aD2/CmPDf25h7IEvSKv/ul2TrUZ3JPm7J?=
 =?us-ascii?Q?YPBmG+Zfjz2PdTA/frwFuFmqRe8kRiKYr1UwUPUaWcai/v2dC6YGrDijWsyW?=
 =?us-ascii?Q?q+59o4KkLPqcSnQdDhotTJ5i+7jIGZ2NeytMv3LA5V4JOw725tSReMIO8J3X?=
 =?us-ascii?Q?+rm/+nk5dSycLBzZlyw8BASoZP0uXZ8NPzXrBxAXKhP+3BJnA0VnRBv5NuvA?=
 =?us-ascii?Q?gr3ktSbePplFxDaEKjpbK7x7ZFNvIvgFE0/cH2Fwq+h3X0JMxjB/7PrOUhAD?=
 =?us-ascii?Q?gtYN2US7s0Pjno4+qMbZrKHcM+M8tEV4a/IOefUo570n6xYKzUTuvysAu50T?=
 =?us-ascii?Q?NRyefBdrjZ07wGs8k2KDwCKs52I70j5qQI+NooNqMIuYn3GkphBR+FHIhSjo?=
 =?us-ascii?Q?ZFD1fngU92LaKT+fC1wdAf78tJJszEhpdd3RJ8FKwDiV1UaoLSz4a260nkvA?=
 =?us-ascii?Q?JQcSP4zZ4ERqThbSU03z5pIq/SLESarsOC/7EEv97sXlQZYgy65X9QQK9OGw?=
 =?us-ascii?Q?z7uBEZqMzX32ttw4eJkoSWsC/fjamMfT3PEwZWh60rN/rdTK9v9of56RycGZ?=
 =?us-ascii?Q?KRZHwpjeMCYm5ulJzFu8zpJBqZSBwk8/ZlXO6uK3pIQNH+rA7vNpLcdoqXQN?=
 =?us-ascii?Q?486/O7f+aWlthiYCRlw60s3chQ09hdqVcolLjWmoYA8q/5ifbL2sB/l2Guow?=
 =?us-ascii?Q?qSspEFICT5dKRdta7FU+BljOg6b0xw83KKcOZ9iE/gSGTwJWRwvnNnx/N+sQ?=
 =?us-ascii?Q?bhS36/yxvTLYNCnS+Mj/oNSelHRE/rdq5Puf6lC7aowPixsABuAXl8FIeoJO?=
 =?us-ascii?Q?DwJcINZ/rq/ReUnHd67RXuwnktVkrm1/sA99+ZHBvWPwOXSCbLD6KA/I+Apq?=
 =?us-ascii?Q?9TGOyxcOmJi42Uqar7/ETQcIMr+Crntg/qhN2uqgdvCNADEgrwgL7mb+8XTo?=
 =?us-ascii?Q?VSCdI5COfdR6T5aLXKhS7EdOnO6pUGSjCpKAlzcXKw3iLQCDZ5LusWPhf7AU?=
 =?us-ascii?Q?tV6DaIfYxcRJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa1ee75-cf92-461f-6b21-08dba59e3582
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:12.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n+8AA02CWG5p98oyE4adDLPTmNWr1BYcj6+itQsiN7REg0kxRt62bHIn8YVjDIIfcDTake+T13/OKoAGNgIZSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: Ws-EtQvUChEPHTSo6S-b3jXxBZCOCRNT
X-Proofpoint-GUID: Ws-EtQvUChEPHTSo6S-b3jXxBZCOCRNT
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
---
 mm/hugetlb_vmemmap.c | 56 ++++++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index d5e6b6c76dce..e390170c0887 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -305,11 +305,14 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
  * @end:	end address of the vmemmap virtual address range that we want to
  *		remap.
  * @reuse:	reuse address.
+ * @bulk_pages: list to deposit vmemmap pages to be freed in bulk operations
+ *		or NULL in non-bulk case;
  *
  * Return: %0 on success, negative error code otherwise.
  */
 static int vmemmap_remap_free(unsigned long start, unsigned long end,
-			      unsigned long reuse)
+			      unsigned long reuse,
+			      struct list_head *bulk_pages)
 {
 	int ret;
 	LIST_HEAD(vmemmap_pages);
@@ -372,7 +375,14 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 	}
 	mmap_read_unlock(&init_mm);
 
-	free_vmemmap_page_list(&vmemmap_pages);
+	/*
+	 * if performing bulk operation, do not free pages here.
+	 * rather add them to the bulk list
+	 */
+	if (!bulk_pages)
+		free_vmemmap_page_list(&vmemmap_pages);
+	else
+		list_splice(&vmemmap_pages, bulk_pages);
 
 	return ret;
 }
@@ -546,17 +556,9 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
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
+static void __hugetlb_vmemmap_optimize(const struct hstate *h,
+					struct page *head,
+					struct list_head *bulk_pages)
 {
 	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
 	unsigned long vmemmap_reuse;
@@ -575,18 +577,42 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	 * to the page which @vmemmap_reuse is mapped to, then free the pages
 	 * which the range [@vmemmap_start, @vmemmap_end] is mapped to.
 	 */
-	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse))
+	if (vmemmap_remap_free(vmemmap_start, vmemmap_end, vmemmap_reuse, bulk_pages))
 		static_branch_dec(&hugetlb_optimize_vmemmap_key);
 	else
 		SetHPageVmemmapOptimized(head);
 }
 
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
+	__hugetlb_vmemmap_optimize(h, head, NULL);
+}
+
+void hugetlb_vmemmap_optimize_bulk(const struct hstate *h, struct page *head,
+			struct list_head *bulk_pages)
+{
+	__hugetlb_vmemmap_optimize(h, head, bulk_pages);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
+	LIST_HEAD(vmemmap_pages);
 
 	list_for_each_entry(folio, folio_list, lru)
-		hugetlb_vmemmap_optimize(h, &folio->page);
+		hugetlb_vmemmap_optimize_bulk(h, &folio->page, &vmemmap_pages);
+
+	free_vmemmap_page_list(&vmemmap_pages);
 }
 
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
-- 
2.41.0

