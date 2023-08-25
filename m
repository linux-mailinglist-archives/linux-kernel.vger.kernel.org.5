Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC845788F21
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjHYTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjHYTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C067212A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 12:05:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEOfe031083;
        Fri, 25 Aug 2023 19:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PdmwOcXhjYj18bUXSFQSbkfcUgdNSVEPyPGP3ecmcJc=;
 b=JcDyRPVGUZFskL/nrSsBSF+TKgziEeoTD9ExBT20DkdP15qNym8OEoUB5dz+5tdMseIO
 4eYLldh7godXnAuH/0YvNhGxX8sdWCZZtXVVOWe+sSgXrgMeGsFb58qtJOLm0aMMkf3M
 lL7mUtwzgLNYRr39om71T7zSbHrYHNmLe/OyPvPHEMHQee24pN0s6ZZEfP+C9Qd81pX5
 ClkASfXYkg+5R6rC/n2HgZlYhqgzF2tNMCOUNEwoSR0XZjUpJAhPruZ7ev3LqHqL7bCm
 OxocR328SntIBj9TSHA5QXyt2A6MV3Z/54K/6Ak/AhB13jxCMBiFW+WHzPDRB9zBcHWv ag== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq0dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIUF4w002259;
        Fri, 25 Aug 2023 19:05:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yyg8ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 19:05:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FweYzoQTcHTB8cM+kd0fH90FC8SUt5AY/KIlWnYBAQU+BreiEo+6iq+G9BTpgFBXg1MDPrz3ZnBs+gFdmvz0NGQoO/uqxg+i3nND7I8oLLxe8wJa073DpgUyyxD36cLWuHpcT16PGQ1+XN+FKftADhNcLhSkUFhGXuvSsL/6Zv8QEKcSMbMz8NiwZIZ364/bXDRrgNt/V05epfCCvukq51zS35rn5ULCl7I278cIqT/i9DCjK3Wh2ZM10EjHeLpmgJpAYIVQzWomiNvgiK9zvN15DBbVkNuzKQ2tHzDVPBCImhbb4vebFwTyqyxoXVYH+C1rAipInTjYXYtaDao1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdmwOcXhjYj18bUXSFQSbkfcUgdNSVEPyPGP3ecmcJc=;
 b=i52lHRk4dSBj2osfkp7MilIg2/ArAVRDXpbJGa/KttEnVaYnKzpPBhdM3lXlMNL5XU9HrvM/lBQ7+cNB+kz9QiLs97ZGUHBL8b3n5std3V2rjMEzwPoePjLBniePI1FR+TN02AFhCo02LvPL31u9SN+6l7kmdyJYNI4JI+dfP7bIGgSV/TN5lfPMfImvUXqwAz8lX+PK6/HyQaVRG27/Jctp88nqNFCjuSyUl/08DZE0UhcApTIP6mdpTfLQhsyZ3RBzu+Cj/JlRayOF/ee8kIWawtG9/S/hp6g4xx8LON6rZVnskuH5X2tP9Wy7yJ6x3rjZUtIZ9dkXOWwMBMd76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdmwOcXhjYj18bUXSFQSbkfcUgdNSVEPyPGP3ecmcJc=;
 b=KxVyXmUubOsX8Z/6xr8zo00aKswdVs/6KuXmnTK4+Nr92LZwCtjE8DIMg5yO+4ne14G9uTmVMyToCPm4JtfcY8jfUAR0k2uAxTMJ3+ude8WcOAJzgc5FJgOTK8pIfhMPVchw448vc+raFlnQKAi7JyuqllXQobICabkokb3OOa8=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 19:05:03 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::8057:a3e9:cbd1:252a%4]) with mapi id 15.20.6699.022; Fri, 25 Aug 2023
 19:05:03 +0000
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
Subject: [PATCH 05/12] hugetlb: restructure pool allocations
Date:   Fri, 25 Aug 2023 12:04:25 -0700
Message-ID: <20230825190436.55045-6-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825190436.55045-1-mike.kravetz@oracle.com>
References: <20230825190436.55045-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 08201307-93da-437a-b798-08dba59e2fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlXVlevVXQK8HWBR+q/VThjL4jkvUXuSA+Qz49eVpz3fllsAJY3RHgrJioA1lp7BhpTBZVQYyZd1fX1g4iHgW6xhm68Qbn4eVEMZnNkcI+4eg7Boh3nowDqtp0iS/DQB7vMydTaus81UJBMXbfWlefiF9gZXRHx/g84FAE6airfP4MTH5vj/Oey0UaQ0f/lyLdefiFhWJu7ZHbpXc08eic+BkLozjbVXgIwaV33XzQRKFrrLb5Z+6evI+pdmp2RNj5gwHibbXZWnvimlZR91mZwfPUDePCyJliEKGcGdOl4kw17Lpy8v57fHdYyo7FhXQKwXbERE6by2YdgLh3qHYiIVIPgX28KwSYVsZqIr1S7ceXhoOnApP3MlSUvNTvIjCyUf02J6ZirWlTnTzH2HOTdOxTnSzDwAPM24/Nd2ZnCBAu3EK50Cc19NmrDybinZ2EBArUefRytJHx7pBWuaWcvQJNURyeZPvGWw/MHKxwsSUGtQHRsPsQTp6/KS/8iloBVD0tbik7twRCGjd7XVNA3E9V6fwmhzbDxMFt/wSofeUwR7Co4ueyOoQKQj7aAD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(186009)(451199024)(1800799009)(54906003)(66476007)(66556008)(66946007)(316002)(478600001)(26005)(38100700002)(6666004)(41300700001)(6486002)(6506007)(86362001)(6512007)(2906002)(83380400001)(8676002)(8936002)(2616005)(4326008)(107886003)(5660300002)(7416002)(44832011)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FjD5kVpzf1H3W00Xod8M32RXSH7WXsHRVzv2CcbU0z27xWCxX8hXRswQQHUG?=
 =?us-ascii?Q?oBluK5eGWR4lSwa09HgaH2H0V8FNMwHTVUX9tNyjgV9dRDrL97kDPQjtWwvx?=
 =?us-ascii?Q?CNaD4YOxYsZQMMzBFrSgxotjBvanySTwx8C2rjpg9eXmNrEmkitoEFzw882c?=
 =?us-ascii?Q?hlAzpBe5L1mgWDd9x9nOV4/t/1v1y9p/3EUytPWh7vVgI/WlXUT1B8iV/LxX?=
 =?us-ascii?Q?IjcKJN6IqNJUtEBALEhAr1Dh2rNFG29dxUzGWHuqzics8enP5J6NwursverX?=
 =?us-ascii?Q?35EsxVtoMXPkkkHn196vkqjdnB+fYU0CkEh+3xcRk8PqzX9whOZWcaHm2A3F?=
 =?us-ascii?Q?Tsze4loj43x20uTH8D/Sk+aU8aOebepN63ZZNjtvuwRrtmE2i/p8Dj1n+AO2?=
 =?us-ascii?Q?KUYRoZP13OYvFw7Bnm9sG/XT7ZqRxnoHIs2DYaJmD9AETuffupYrT7L08Due?=
 =?us-ascii?Q?+QUNsFeb1PBWmUskhmqngAEju4acTUeEY1VijVNPZmHyFY+7lCyMZCVTsvqM?=
 =?us-ascii?Q?1ZUPvuK2SuveIBdCzG5B5YgJ1/FOyZVXdGSCDb37RxpORfbQtBuYznnc2dCf?=
 =?us-ascii?Q?Yp8XVUcXWpUhnOSzbDkQ0EDqtvEl42P59BzaRkkkUnq1J9Zq/5gTcPR235t9?=
 =?us-ascii?Q?vMxBC/ZsRc+BvsUwVxeSAYRpTxW5ppVTDiEV7+cGijCctgplWD5vhqX+cnqs?=
 =?us-ascii?Q?xd/6UvvO+0A/0dFjZkhPz4nEaWnPXWcjoVmz7aTT9B1WU0kOPzYKSHhCpGA6?=
 =?us-ascii?Q?9j6l/KVd0hZBmdPPxOx7/zhHTBAqTsqral0Vh82xj5qWYpjPk0+WCI1X5Ddg?=
 =?us-ascii?Q?Y0q6+dXOkORFuj7cQT7dF/f1gkJ3jEh46uF+Q1bKvjzmtLWBM+n3OHFFTV0H?=
 =?us-ascii?Q?YLBBM275sQZvmsCy3z9uZAQozTeBfSIpytKSvxj9Q73/8L2sPaT7z57rP89A?=
 =?us-ascii?Q?LXcIo3WSBpjHqd01jBkFvIywsg42IBxlFilwApZuQhggbsC2/2DLCmSLRll6?=
 =?us-ascii?Q?BLU8N/doHN8Mrbc/9LyIFI3nIkXA6p0YL/AOk8xl2DnEbJxke80z1FWzSkbT?=
 =?us-ascii?Q?CJ6fF4zl/pBN6flb/Z604TRXk8OyWeQDFjaaW2r+wISHpHvDGh7rrj37tm46?=
 =?us-ascii?Q?KnatrzbqAV1qat4qyELIC11sU3zJDoq5uoyiXUUbwO5Kjk3b1tLwBz4vaZ4W?=
 =?us-ascii?Q?0Sl3n+yYAowf7aRxx0vrSwYQGaLm4NRvNmLqes7+DUorCyca3c0UW7qLzpq+?=
 =?us-ascii?Q?HYyTmstRZgzMY7j7poCe8x1IoaS9ddAnpeAbF9e+ny+JYLidhtAbwvKiYf7X?=
 =?us-ascii?Q?Y5pW/2kWIkJHBXKD6GEFJJyelIHnpKEkYTCYU5WtoAr4eAH8GXETvgYnTxOg?=
 =?us-ascii?Q?EDlY+SvfiQ7VU+mlng6DzAo7qDEBvbL42LeaFOb3OlNyvtAB33+INPwviNfX?=
 =?us-ascii?Q?BK2CbSsEEiILwBYOtpLkvwKDZ6kYQiftUoicbosN0rU7Sz3QknkHlUttk01q?=
 =?us-ascii?Q?fHUQZuXu5O6bMAF5Nx0ZXy2uYdqH01oMYyn01dizUsrx62KJTHexCR6jr3Ln?=
 =?us-ascii?Q?vFE6Z7nt9R8F/fuMLYYfbLr0nkA085EivhdXxSDXdSMq0lJgB94hcQ+pHv21?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tnGmb3xHPtClVn7B7yO/h0zVXfpXvaD92JMcMwbfVuJiDpsmG6/RcMKvKonf?=
 =?us-ascii?Q?DTmSMj5E21jEE1/jtMntlX7sRNnasY8HkpH0NqrX26YhIlJ5Zl5TtIxxGgEH?=
 =?us-ascii?Q?h/rIeEI+9yl+PheivwGJICbpMkl3jpo2Ucl54HE1+yH65r04yZ2T/drlmFv1?=
 =?us-ascii?Q?o0jx0eHwa0QW+nQbT+Qx7/LMRize21YkSFCKs9ZWZmMGCdJ9Y0s27kJ+aUP8?=
 =?us-ascii?Q?LQEYadwT9c1T5yJjRCRm6hQsGOM8cqIDlSCw+z9hpYuI5Gxuaorhu1Z5/mnJ?=
 =?us-ascii?Q?qi6pVib2k/z6z2qaw2jgEOhmqXB/CY8P4pp8LueVblek2erLVMyE5Z2LIzn3?=
 =?us-ascii?Q?gyGoXTue+64XdtWMxIdwnPdmxrFs29VKRFWC5AcoEO78lCMo6hlMIeLP+HXa?=
 =?us-ascii?Q?iEpLvmKvGxgVwDIRJ2y+nh46TzSfOtMPc98Oy6Va63UMWnCCY/xbo4rPhbb/?=
 =?us-ascii?Q?Ja6fqyYVW/QJIDt2Bg+vU9AuzvP3Pe9+47ScZn9fCMi2bkN3UKByeRSXcxhR?=
 =?us-ascii?Q?wmRKOq2HhK+iWGZ+bKzub9HPvXzz0ore7bnjr59+7AtN/jqUHmFG0jcJsPNx?=
 =?us-ascii?Q?52lsdGtRzc/Vm0aL3LQb1pMN/LnwPrPFI5mNYH9Q4TBoXBok0Fr1DeQhqsfs?=
 =?us-ascii?Q?qJllJKP7rhl1s7uj2glCYT1r30lrG1IvbD97heKMxFzySATmWiE4M/Mn0IXh?=
 =?us-ascii?Q?Q/A58vHS4YXucrdP4RirP5Pj+9+fYWTLYTshM/2kBUT9luNLs/YMkuTIZmzn?=
 =?us-ascii?Q?D2zprLpnP3hidRJyGkdnQEAI9AE4Yx6AMIp8STqOwpDD8+PoxJB9u6XnxFUq?=
 =?us-ascii?Q?OqGLglX7suUOREfvM2h9VD231p4ojc9uPWdyiYPC+Bv2Y/LSZYFdP2JY3b06?=
 =?us-ascii?Q?85tg0Adjfv1f6DLPUhrPRVSr/SRKU6gpY+FAwXZueh1eJ40JodgWr1puo9si?=
 =?us-ascii?Q?cby4/YWcyQXtfvOxbhM7dR3F1lzl8PW3fWTxNZI6hMfpjnjH7/ABaMVczWD4?=
 =?us-ascii?Q?Mm3yJ7YItOwmIAl9Oaz5UmduHgod6CIUEq4FYpFbQFSrZbYXoThr+JTDoPZx?=
 =?us-ascii?Q?fnWSGeu5/2kFcdcpZtRM96czouHSHD0z3svrCHZZZkdG3M2nMWSRPdWBf7qD?=
 =?us-ascii?Q?Cgm2BebBsoAx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08201307-93da-437a-b798-08dba59e2fb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 19:05:02.9823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfwoHS2vp0n6TJd2zHXisUnCQd+G+e1IHJEkDxxq+9EctD9DNN/HVzJEhLDQLNfTcuDPja+Zefzq2QeYXGN8Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_17,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250171
X-Proofpoint-ORIG-GUID: hA9dqyJoFfetm6zs0B3tHWZsYX3wSaHo
X-Proofpoint-GUID: hA9dqyJoFfetm6zs0B3tHWZsYX3wSaHo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

No functional changes, only code restructure.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 155 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 119 insertions(+), 36 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ec10e3804060..452e7ed6dc36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2146,16 +2146,9 @@ static struct folio *alloc_buddy_hugetlb_folio(struct hstate *h,
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
+                gfp_t gfp_mask, int nid, nodemask_t *nmask,
+                nodemask_t *node_alloc_noretry)
 {
 	struct folio *folio;
 	bool retry = false;
@@ -2168,6 +2161,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
 				nid, nmask, node_alloc_noretry);
 	if (!folio)
 		return NULL;
+
 	if (hstate_is_gigantic(h)) {
 		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			/*
@@ -2182,32 +2176,80 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
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
+	return __alloc_fresh_hugetlb_folio(h, gfp_mask, nid, nmask,
+						node_alloc_noretry);
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
+static void prep_and_add_pool_folio(struct hstate *h, struct folio *folio)
+{
+	prep_new_hugetlb_folio(h, folio, folio_nid(folio));
+
+	/* add it to the appropriate hugepage pool */
+	free_huge_folio(folio);
+}
+
+static void prep_and_add_allocated_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	struct folio *folio, *tmp_f;
+
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru)
+		prep_and_add_pool_folio(h, folio);
+
+	INIT_LIST_HEAD(folio_list);
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
@@ -3184,8 +3226,7 @@ static void __init gather_bootmem_prealloc(void)
 		WARN_ON(folio_ref_count(folio) != 1);
 		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
 			WARN_ON(folio_test_reserved(folio));
-			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
-			free_huge_folio(folio); /* add to the hugepage allocator */
+			prep_and_add_pool_folio(h, folio);
 		} else {
 			/* VERY unlikely inflated ref count on a tail page */
 			free_gigantic_folio(folio, huge_page_order(h));
@@ -3231,9 +3272,22 @@ static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
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
 
@@ -3275,14 +3329,25 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 
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
 
@@ -3416,7 +3481,9 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {
-	unsigned long min_count, ret;
+	unsigned long min_count;
+	unsigned long allocated;
+	struct folio *folio;
 	LIST_HEAD(page_list);
 	NODEMASK_ALLOC(nodemask_t, node_alloc_noretry, GFP_KERNEL);
 
@@ -3491,7 +3558,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			break;
 	}
 
-	while (count > persistent_huge_pages(h)) {
+	allocated = 0;
+	while (count > (persistent_huge_pages(h) + allocated)) {
 		/*
 		 * If this allocation races such that we no longer need the
 		 * page, free_huge_folio will handle it by freeing the page
@@ -3502,15 +3570,32 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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
@@ -3536,8 +3621,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
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

