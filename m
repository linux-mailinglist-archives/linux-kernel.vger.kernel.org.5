Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1367A2A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbjIOWRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237824AbjIOWQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F02130
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLwmhf016392;
        Fri, 15 Sep 2023 22:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PvDEfXofWnbA/mu8Nfn0j1Qjeexj3L00jJmMYHtlJvg=;
 b=R239j1iHA+WD06NMRyUJZpZ1I0Gy876CQxjJ1Bv4lzQI+mOezvDOPudzXsSv3qO6DYAN
 9IEFnwSXCRgXX7Z8Azd1/VR/OcOQLBHe8NsDYfSetbll36+8vPUIbehgjRgEW3XHH6eW
 1J9uJA9LIiITQGhIwx+M4/AgtT5vtbTFqceZF2tKE9emFHIDUmnkeJDgOCr0uSK2vm76
 fYqF6kKkJfYrM6DqdK7DI36Xgh/G2x8n0DQphIFcNpoLtwhTVd4IZQyB45jDIBC1fygT
 //shbY1eCWqeHvyQv6619OYAMjJa1EP4QPpiVjPv8mYtvj2YI9MOJV0wb/ktBgAzJf3A XQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rgxc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:15 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLb0xG008807;
        Fri, 15 Sep 2023 22:16:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5awd0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 22:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQMlrGTMv3BBC4FCDlXSdY1CQnpYwu5Wadozso6PKkDemZpZFNO/uh6YwdS2LiZ/0A/v4YPhNcRjmc4DCTHbCqmfFTM2uws8fCn41tDl4syq9tpsJcYrKK/Sl9H5ZGl+zpffth31oORbX793WLFDIzyGr30nQq4ZO2BjFeDrSS55L3EJBWftUoGy8OhqOKD8HqrlaHqKr/y9rAX9FjlCNf+WIHTrHbITqeT0myGZQ4A0qxzXC0l9tSijWQBAUwKGC8rJkz9nWoyP/QBmisZvmxsjfWrh6b4LxFE8x1rrq2x2ZDO3fOzGtkIr0uSKlq97tW0VpbFsyUO36FGSPz1bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvDEfXofWnbA/mu8Nfn0j1Qjeexj3L00jJmMYHtlJvg=;
 b=MM26kZ2a5m9l6Fo6xlt90FU5G815ioyqBQYJvg8FXgWKC4OEuwe1803INqUWzv9f87qciMeOhFoUun7R1/aqsjLZwWg2C1+vDz8HktjhEU7c1adqG6qXxHXMcWPRz/47BG06G0R2EISjnaA47Qx/0nGOhAqQXjFMTshLjs//K8QOmzEx/NcvMsK2I1gRkXsBnerlJblE69k2jbSTkCpFQ1tD8I1uM5oAT5mUaF5Ydsr31JHB8pGlebWjIPDZbgMmMfQbhiEp2zI7WnYNzEydyRv3hPzg7FnO22hGTdE3UhpXRdkg8/rLUHiO5DRe/GOweWMLXo1k+e0QvaCaDGHQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvDEfXofWnbA/mu8Nfn0j1Qjeexj3L00jJmMYHtlJvg=;
 b=gGDRmG+yrWn7fm3Bvtlc4CiezTdxDjOVZZxxSPcdWW42c0omncNGkIu7v6ajDz1JRaA/LgTtbX4tbdgz8oiUwK0Q5J7koVC3GXW7nrloDvl5+uVbWt1qYl79DdTremUtEScqf/HdlOes9iL7J3ugyabVKEcyIgTc03Ef2wALS34=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW4PR10MB5861.namprd10.prod.outlook.com (2603:10b6:303:180::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Fri, 15 Sep
 2023 22:16:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 22:16:12 +0000
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
Subject: [PATCH v3 07/12] hugetlb: perform vmemmap optimization on a list of pages
Date:   Fri, 15 Sep 2023 15:15:40 -0700
Message-ID: <20230915221548.552084-8-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915221548.552084-1-mike.kravetz@oracle.com>
References: <20230915221548.552084-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW4PR10MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 25efbe30-169c-4b56-1ab4-08dbb6395e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYssCvivKBqfP6m8oKvo1tPAGYquavbkRDYt0iPkxbQ3OQT1gMd8HHjKzKTbRo5avo2pyK6NMGdpvOPq5HLn6bCHGD10TuYBou5prb3Clk5ISzId+UR06ZwkoAfTRlPjiOmbzi4qn2u46DOvgiXRT6q5sfplMyt4QRcZo0PH6CH+whvdpvKPFevs0BwQA9OEExi0zJnTThhpI2JEzLMYmdEftxEcp9VslZXWqrQqiromDkBXGhBQsh4c5wqh9O0h8FcjnwgrMgkFkvo44TtSWECzMeZTVw3iSz43krUzEfZpGTUXpr5xYx9mynkk6JMERACAURHcQcD5gF+VF+WcrhEZ4+T7eYIr/obf2k4ZeSqUN7DWuQ1PtQ4AuTC708l5zCRvTrRALjE4oaHpUa8wggWKC5YeNqJHEJpFbWeR32S5230kwjVcGW6fyx/zIyNwpeVczyZgbW2CLDGtpv+eGi7fkl3xyBrwUORFZS7fsCJvNswtaxfJGm1LZScnkZZuFkUHc/GKUB4OLqQMwJqy+hwXhNRR9IdykzW/BtnyaLvCjXya/tsHruoaMoVqRVsN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199024)(186009)(1800799009)(44832011)(86362001)(36756003)(83380400001)(2906002)(38100700002)(478600001)(1076003)(2616005)(26005)(107886003)(4326008)(6512007)(41300700001)(5660300002)(6506007)(6486002)(8676002)(6666004)(66556008)(316002)(66946007)(8936002)(7416002)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwEqCjTIvRg+vOBcMjMtCfh3HLe3aomuU2yTAhJXnrLWWbXAeJmOzf+il7Pg?=
 =?us-ascii?Q?b+cUM4uLkNXRc4/mVrRaDvm+MAOD32YARDCjA9aXX6G8Tyl+30FOe3yTmRyM?=
 =?us-ascii?Q?2t3mmDbtJbLWsh2sWnsgrToyIHflaeHVg8+jJsenyCf1wxXTSRbJtfpd5nGg?=
 =?us-ascii?Q?KtIVNFW5l4BF/Q6rYkNQ7qdKNCyx2b3IX0fqSv8taaIjVRjbxCsfRyk67PJX?=
 =?us-ascii?Q?lwK1NHcgUH9UW/CtfVhzqacsCBPuKSYHdIRD2XC01UlDN02HnZpEtJBNpExT?=
 =?us-ascii?Q?rqJQyKt7fTQgeVcUA6qIoW2q84+8ww8rk0WbE/Mn8LKubuozzXenzTV9+0JW?=
 =?us-ascii?Q?wz6PUjnlGC2k1agygF5vKinBbhWLk6wms6kKNwPf7UzBrqtmS3Ljn0G9FC1q?=
 =?us-ascii?Q?5Wf2pNTmqnHNIFygXXmhF+iR1yzYENc2bJ87vzC3YSGb9xCdT16W7xJ3UKbH?=
 =?us-ascii?Q?2dJDLaB7iI22q41DUqMHshjj7xVlUIIeXNv5PJDSh7mvujjBhe0K6kSfeJVX?=
 =?us-ascii?Q?CWlhCKu03YZz2SZrbGVELqyX5p1S37Dtn8Ld1eNR5u6LBVSxQ92wcyCNm8on?=
 =?us-ascii?Q?B3LYnMGFUNOjQzawdpI25Gr4R/jU5wbQ71I7kUPK8S7HbwGnmKWuUPbfWTqs?=
 =?us-ascii?Q?rSCiUiffxYS0RKiaiIGRTq3v1xHglVCwmrPAFTt6g6TrlBbPnHit6++cU3Sv?=
 =?us-ascii?Q?eZORfMoozHzRy8o0OWKTwlMOxTzMhuEzYNjEfKImtlj4UTH2Q6O60dluJpoV?=
 =?us-ascii?Q?pYdvFlGKHmdYbRm5mMy+vFpdLn7gXHu+afWgStiElUDEGNo4fq58BEsy8QkM?=
 =?us-ascii?Q?lDCUa2IBhcGaBTclV+3eUWv5LY5TyWZtb9Ju7pld2eWokcWmONViJfSI7hsn?=
 =?us-ascii?Q?o+9AW5DtNfSKdP993eNDoGuURdAuKhVr2sDotkIN6fSMMOrS+8SnQoA/gQnQ?=
 =?us-ascii?Q?orYd0qpB/bgIrAskaVcsr4QHaB3qF5X0KV7Y7BFhhphjg47/UmfCqu0FX+v3?=
 =?us-ascii?Q?WEbb78zJX89kPNNosnqiH00C3/i+k2vvG6+MPgxwZ9bWd2xmFxavjAsU01j1?=
 =?us-ascii?Q?MjWLWlTRQLLk3cYH/Q9ITevLsZ0O4OT1utgug2bvDZW9JwAmVbEwqRCqWaoM?=
 =?us-ascii?Q?VmVCb5fpvN7Tc2T00pLfqdB8OQiIEmIAzyzLcecnLBGStLDXG820Cif1XeMB?=
 =?us-ascii?Q?6A9oP+rIzTV9UuZtzDgng2X+13+tu7xSH8e2jHj3aHkspYQfh5PGL3cR12ea?=
 =?us-ascii?Q?YS4cAWZh4XSaKJAo3E4vdrKjA1zTjUDM5mCGiFlerSVpbp4EccbqsG/RpZ3O?=
 =?us-ascii?Q?x6cYAQocZVCvphgpT+1/qaAyRTm26md9BjpBmCjFlVu4Yi8NG14khMPl9yVu?=
 =?us-ascii?Q?gsP5pZjlgBedUc+HTzjzO9h3S+ObPLlZbtKOgIbw/rsMFyeVoO2XS/GtLOtm?=
 =?us-ascii?Q?iliwYkDbQNkkXqStee7Ir2NpzWZMLiBf3/UYpEqfGAxfoYX9n+GhR827ToVW?=
 =?us-ascii?Q?C4jWkrlJQPM8n/SdCnycI/lSnnx2k1c1Qzq2DOsSrSYNellcPXpJjONlvUvk?=
 =?us-ascii?Q?nUr8ELam+bAUCyYB+UMfg/2dyF8m4pEl/U5baryGBjxQE89gO2ZN/WPemlf9?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1CN/tGvphJwXn3dpFfbR1jgD5CF0IOYxPvcvtYSJWfWs+94pqiu+a5g4xaQy?=
 =?us-ascii?Q?cSd5JkauATGKaZJJN/sH2mkzKapE+sOWjglGIaH7KJr1pPomRQ02H3h6poe4?=
 =?us-ascii?Q?gPeZYTiHDKFvBRu9BsDlc+TzaQSDp1evb9CFx30xCRJPhqKezGBcJnRg2n4Y?=
 =?us-ascii?Q?rvUNuYuuMCqzJkOS9TcNqN3v8IrBahpE/mdZtESqL3xb77zxqn50PFBY5dNq?=
 =?us-ascii?Q?61yht4IXwnXfJfuM5sswA+RPU7TZmbUvU36n46HkfA+8kwqTudQSYh/ZrkCZ?=
 =?us-ascii?Q?kN1iDYXcmaxLqN71x3Q3By9InviTS94E5jxxMVKteu5nN63xAORwPeSgkd7s?=
 =?us-ascii?Q?yKHg7N5Lut3UVCYUIM1miFs1PMfkjyHJybn9D/7REJyvCBJcW8jy3vuIvGYn?=
 =?us-ascii?Q?aYm9AkSf0Dmtn3KsiTekayLxvvHV9/MGpXrnnHhttFVwpDcgSnghfNWrDOU3?=
 =?us-ascii?Q?/0NbBWM3z7ofn0hEUEu/LZ+kTfqwWQSoueCT/4apyLZzvhD6pFiISJEm+LSs?=
 =?us-ascii?Q?bdt2Fco0TmhajrwcW1hDRQPx+z4hV35p1wR9rEljRie/iz54YzZJQg2omSwA?=
 =?us-ascii?Q?SCUilcwFnctSaT+go88ABjxiZsdWnG7TEj078TI1gnJ9MG/LDKkC4dmPy/TM?=
 =?us-ascii?Q?gUfLq4ddg/1zff8QdFiqj/b4NHHDbuvQU38yX66MEjl/RvjoHSow4iMcpa5M?=
 =?us-ascii?Q?h5s+E9XI7by41EBcN63f0grsqN1BJO6P1cj+vAkciKqlu1KV5PT1ty0JOc4A?=
 =?us-ascii?Q?NKLL7weFFGQQLursCzQNvte/DZmZThN5EzobBY39HYvDO23EpTcTmUQYr0ew?=
 =?us-ascii?Q?IsdRkBs1VcXs3tGgkUxE3RO4VCTfpe1hmgQFRdZoLh4ij8TJ2VjR6XmsFb1y?=
 =?us-ascii?Q?jWFqM8FhKGQkzq9plQIy7DTSnHRiKqoeqFgeQACc1d6Fh3fmbTTD5l6tAx8b?=
 =?us-ascii?Q?tEjNKC4SoZMdJK2udb8lEOkoriYlj2dIjn9uIxG2xBRdE9mprM9NZ9rsTgYV?=
 =?us-ascii?Q?W3A1S86WaTaEl5DgQYGJDVTgsJaJJLNbhEc4r4bW4/HJLVcrC9APofWYgyX0?=
 =?us-ascii?Q?fm1aF5Zb2//viap82b6yDlthKrFjVTCqf0OI6urN6NW/fEPOebXotuIGgZ/Z?=
 =?us-ascii?Q?YQZLNbepcL4a?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25efbe30-169c-4b56-1ab4-08dbb6395e79
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 22:16:11.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2SGDHWQr9kMEx/0piHnE+V065w8n32w9Sp487NfEmUqkgRuCUu0BdYODL1/7W5fBjoM1ydpoNL1um7vUBHYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150200
X-Proofpoint-ORIG-GUID: 7eoyWQtg0vZ_C6KjTxBNa9nbQIokJEDs
X-Proofpoint-GUID: 7eoyWQtg0vZ_C6KjTxBNa9nbQIokJEDs
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding hugetlb pages to the pool, we first create a list of the
allocated pages before adding to the pool.  Pass this list of pages to a
new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c         |  5 +++++
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 77313c9e0fa8..214603898ad0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2248,6 +2248,11 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 {
 	struct folio *folio, *tmp_f;
 
+	/*
+	 * Send list for bulk vmemmap optimization processing
+	 */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/*
 	 * Add all new pool pages to free lists in one lock cycle
 	 */
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 0bde38626d25..c17784f36dc3 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -483,6 +483,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
 /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
 static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
 {
+	if (HPageVmemmapOptimized((struct page *)head))
+		return false;
+
 	if (!READ_ONCE(vmemmap_optimize_enabled))
 		return false;
 
@@ -572,6 +575,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 		SetHPageVmemmapOptimized(head);
 }
 
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+	struct folio *folio;
+
+	list_for_each_entry(folio, folio_list, lru)
+		hugetlb_vmemmap_optimize(h, &folio->page);
+}
+
 static struct ctl_table hugetlb_vmemmap_sysctls[] = {
 	{
 		.procname	= "hugetlb_optimize_vmemmap",
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index 25bd0e002431..036494e040ca 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,6 +13,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 /*
  * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
@@ -47,6 +48,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
 {
 }
 
+static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
+{
+}
+
 static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
 {
 	return 0;
-- 
2.41.0

