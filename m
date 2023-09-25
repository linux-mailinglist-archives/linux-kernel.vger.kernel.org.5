Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFACD7ACD28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 02:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjIYAlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 20:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYAlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 20:41:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDC2EE
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 17:40:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMkBQE019937;
        Mon, 25 Sep 2023 00:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=bl59Dt8bk7PR84Rbqcv/sdCrimgMbMy3nWo8M72IV6ARW7ipkqtYVxlwjwtWyjzdrAvm
 GvaXAyCcwRnUqA3E2eIipSCwVeGIl1Zw1Swl+KWT6KO6G1ZLrxIMQ3gOT+Az9tU6JLjb
 xeeUhzeixQwSUo9Txkp0Bk6hb7NujkbyYfV0hnccwl6Nolyyct32p/Pa7kO+J0obqa5P
 QUOE0M5dwClVpcwDCZRhVImzMu38jsP6RoPQV9KlIqhC0U5K0qS0L+41mNVqj5V8FL77
 9ebOSmmYffZcEY8Iy6kXSOndOemhGdAVkmCDI+ELj0j4SNMxq4HRJNY+KHJI0MQEAlZG 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qmuae0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38OMIAuk034921;
        Mon, 25 Sep 2023 00:40:13 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4184g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 00:40:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckwdNHi+noSAp654ILw1G5ARO9n35tmokHSNp1GVhBQptzExWMizkuqKNrqfURs9WsdywjZe9cl19x6f72qhCIx/5jS3iKuffRvWWf6v1MNqxwEYEM7fpHzFeeAsg7BTPDrZ4qssp87VsRm73tDBtEAS0lBbOU/FI4m/AZlNC4JFaVyomAPVgn6NK6dJR0l8DYYuDwfaFDAo0w6hzPLAlfu0w6myhXFlHmH+csafdkEt+sCo0tvjjUc4SCimhZ6O9kabX6uwKddoxjBgkvfLOtQCDVIkByQ5/CTqGB0GVPttW4aOBwOP4qyqZzmMpPy7U+CqKRv3z3XVMp+D2uDr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=hjz3em6me0I3VketzZRqYp0veMDMs60f+oUOUdQ4R9kZGeAxLV8yddsf+CeRt+IjmuX21sUx7uh5IR/JeCnv9KO4Ajn1PrxZbP2+zPcYwbpD4vAtCU6uxZxjAS8BrNo+Sld0h6i/T1m1XwSEg8PS/kwTBvE9s+bOaJ0+sNLe9dfPV2Ywhlxir3/iyAoPmC+8WtSn3XS4/yvnuwlbOFopxel/SQb+GueZr1Agf0r8bXTwIrvWdqguKT9L2+TwU3cjkz8hslYkskl4LQ4vNpGu1CmNiqXJMYxeL1UpTI9Ug0k/s/eu/FUoD+R3zB+2nxFAGARjGP7zZfDH1GisWVOszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/x7mTYtq0AK43XWU8sgezCXfY3I6f53AD910fUr/7c=;
 b=cItdVJDbwHnl8rTvGlhc0gMUDjDFHSnIS3OwsAyLq6o+pFeGJ/UN0nZCKrHRqwn5Ok2gJQyjqyrmbltWEHWTiQmcDJtKNrOhSONamEUKOcEWB55Qb3IJwSblUJinzEVATOtYwX7VMLNbRwdFMEmbJ8znMpyg7dCF6sivoVyufPY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by LV3PR10MB7819.namprd10.prod.outlook.com (2603:10b6:408:1b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 00:40:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 00:40:09 +0000
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>
Subject: [PATCH v5 1/8] hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
Date:   Sun, 24 Sep 2023 17:39:45 -0700
Message-ID: <20230925003953.142620-2-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925003953.142620-1-mike.kravetz@oracle.com>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|LV3PR10MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c8fb6c-2fb6-4baf-11b6-08dbbd5ff8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+MNXBIVxP/nIx9rcSF7+uSPNCzZQ9tYpsx5AMsZ9rAoNRGrF88IRuxCOjuLefGRe2td9Fc9Wsovl2XE6uRBKgNLF3MkZo5Eag7O5NiAAvfjOGCxsRU0QlQaDTGL2NQN5rxUFnKqQXKiswf8FmBKGoFH7WmzkHhT8eW79cQTGa59HVYPt+FRmnC0atMQ4lkQ9hGo9DApRZ7DGAsXbklEos6S0euDkhstdiVsUAUMP+bQGVp7hMuLl8L646U9zoMS/kyiGzPHbzlanr2vuPXUyh1nROxrTBMs5mIxSvQzYuPFacBGYviZ90HIvqjC92KmeSmK90I7dyBMpkIX3PIQ4c7rZuZmqI88g1ElcCE73hGEGEU3XqFQsTUeLTos5oBSmY2OPNp+H8Y9YnNjQaaF46ubd0+kRBWdbYhbTp+pR1nYmw/T8wllftxp1AkR8OjabZ7RRDUnmLJ18leLaw71z4I65l+VO3/t372J1p1XhCDSU+oQk6glLAnefgEt7W05tLNMuCQ/scAilbhV+JzapBoEUM6/ht+85E507SfKhGoA5bmk+WfHRscJnOezxxaT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(2906002)(478600001)(6486002)(36756003)(6666004)(26005)(1076003)(38100700002)(83380400001)(6506007)(6512007)(2616005)(86362001)(41300700001)(4326008)(8676002)(8936002)(316002)(44832011)(5660300002)(66946007)(7416002)(15650500001)(66556008)(54906003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uFzmrdAFWSTH0uTAF8xy8XKBkuLa0+QrZf0mcw1PgrtBQ4DQCeKV2cPCDtI?=
 =?us-ascii?Q?MGCNDy2lZcG/3y9OpdPJ3ZRCS+kJ3cSvHwL4GQnZ/uaHOdfCWmRhhtCuT4Vv?=
 =?us-ascii?Q?hn4Idsj5ABgBBS8ciH6gD82xYVxNObAyMSR/BmwtkNVOp8rbh++Nv72BwZb4?=
 =?us-ascii?Q?LPp9Z2ys7qGzr+kJLZafPVlpg3kdf0xUlMzs0jhrbnJBmhaCARCZgddYCB+u?=
 =?us-ascii?Q?0xSmHhzJR0J8gIU0S5S1+e4+/GHGpV8OCLWcrOgtzueIEj9jKAVK8O0O4j8Q?=
 =?us-ascii?Q?8JhctC6F1U4vdnCYJq+1+aV722QY6+aKGE1ZOCKHNkowKDxdZ5aT/ZMrB/CO?=
 =?us-ascii?Q?JykRtWpyutL513gLgo24Z7Ivzk7j7DG6hPCANixTnKPnPXqR0HZ7d7gQnBEw?=
 =?us-ascii?Q?GzHR2QsX1JREe2Gdcn7xBDUXV+47UkTQ34nONa2q5BsppY871u8Ju48dNwf2?=
 =?us-ascii?Q?Ha7u9mPYoaPwkw7qopqnWDvSc4J7EcjZ/U81Z0zjyXr6KgGPYp+o9hqz+v46?=
 =?us-ascii?Q?UglRsSATEHMn5bncy1gwAmOtag2JsP1ORmAmleGu32QVD7kyEqkhQoLvm9RI?=
 =?us-ascii?Q?nx8XUuj39NlKskI34MFeoybMe8fvLILV+GbLsrTcld4pMBca5JCUPX1Bi23z?=
 =?us-ascii?Q?/t/R5Jg3b2F8kWCnZXTp7hfC3MsHUbYICwacpnW47XNZUDio7wlsjx4yHfbP?=
 =?us-ascii?Q?TVyn6T8qmSKe4YR3c/ZVi66HtaTMMR6qSvzUpd2r/dZlKxXT2ujJ4RIYfajd?=
 =?us-ascii?Q?IDYD0zjdw/4cK1dJuVy9RAmX3ZZKF0mY7W4EnV8Oo65iksEa73vT1513Jug3?=
 =?us-ascii?Q?rkx+0KO5uu0arN60FPfnQ8gs4nCHOzsu6udbzEQeD+5HLVqgBpnhEeXHEoej?=
 =?us-ascii?Q?HrtwlrACp+1xRcVfCr9cZptYTDcdaYxVbEOV6tlU+JuXqIXY5zrBFf1zihrm?=
 =?us-ascii?Q?Y6syGIPIoPIfi9S0bLCtVwiVdpId9cNRcBg6VQ/X7x6DWGiMykqiRBZm3/6w?=
 =?us-ascii?Q?jUCwjGdydEjNNQROA0Mm/jP+WGrrGWodSxiG1rAKOV43G5tw8hAapNOhvTFP?=
 =?us-ascii?Q?55XDvu+mAOOMbS6nI4tqzFSk5OFr16bxyG9El6Anaeip7RPM+ZYIi9yg8X1F?=
 =?us-ascii?Q?IugHO46OOAsY6TxQkDYf74THx50V8xGbay/sA9Y5aznRplhqH4lMFWcuRIpz?=
 =?us-ascii?Q?xvj2AImTuEh08Sl3Z2RTgW7hN6fooDh48WLvZF+ZgpuiungOC+NZk4pMd3KH?=
 =?us-ascii?Q?4C8ujqcMEwLsrhEn6R7CYAp43MiqpD3Wccj9rL0MsfLSYz093ivAEuS/Mmqz?=
 =?us-ascii?Q?tG+8lWh9cx92+SdHLe/EEHD8znt5KqxSHO1oK/UZWxZghOdwdM/zVD6cXbsx?=
 =?us-ascii?Q?kJ4hnDQOs+d3OSqm6jfI0RtHJuH9jjS3D9L+9jwYadzgrmFflwktX4wkEJyl?=
 =?us-ascii?Q?B7DZeI7xqapIKNWswV8bBuFm24YQLGOiDoUmBx2bo+1J9QOtPzTSxB6J5LKx?=
 =?us-ascii?Q?yFJoFYbo+heBr1NawXO35pJgJgVwzbT55bch7n1pjXGY6Rg0+8/8I9pSj0dJ?=
 =?us-ascii?Q?lh2PYp1fjjLbCVcFSTGgm8Cp/7gYsWFj6LYoA+EQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?uZlzhsX7mip/PGLvUTALTOQE0lu96aWRyWnWvdgjyZk3uPeXghaeflmJkPHI?=
 =?us-ascii?Q?E9ukX+8tt2Am5NjB8K35jhcduUxkySsg3HJ9whjwaeFABRH1k04yarvRAiWd?=
 =?us-ascii?Q?dqL4qzuJY8SqmO2RJ2wAYFv8iwuyeciFqq4FgGCnruRoNTSouodTkThwNU75?=
 =?us-ascii?Q?S9KL9UxjN5nEaqnv6B++xeaQxulnYyulRtaZTqfcaaa0BcIUvgrko9JVtmmQ?=
 =?us-ascii?Q?L/Keh1fFRZVSvJBdDQ8jKKPi51Y57m0icq0FVSFXF3jGLCzAx4kAD8Db3ypR?=
 =?us-ascii?Q?aqy49Q08bXaLj2YmTXogHbFTBz2MFj32yV1UomKj3bRhF0dm+mDWvxcK8MPs?=
 =?us-ascii?Q?+vtCanWzITfZvFoVvm1eFQCgvx+DHjKyApV/gzVK7mJDnU1ApYviyypGkXqr?=
 =?us-ascii?Q?GVQGSIoh55BpHvT1TI4qKflT6OluJDsblgRkdjWBMKopmavL2eL6h0qSW5nn?=
 =?us-ascii?Q?gharHZ4A0d/gfV4I41bh/AAJW0UcN4RT9qJIXcn1FVH9hSOsAj759eDuys/R?=
 =?us-ascii?Q?wAkb4cYv9rLNlzE1bND4hSISr/zlZB8jJkv0LnKL0987trEXUX43gxFj2fK4?=
 =?us-ascii?Q?pBJPLKMDGyZwpxGavL3kTAqlMjnY0ayVPzOhef08PD6iXGBuuDDAOq3nJY+q?=
 =?us-ascii?Q?sZ2akec1lemMImC70NfuHvkSt2HwJC0wqD3r7K8NBGxdxfgOPi9PpWagCRIu?=
 =?us-ascii?Q?PKxzo1uQnFOdCGkXGQT3Xfirhj170OYJyG/dvoAlWuNYhWFg3a2zEHZHox8U?=
 =?us-ascii?Q?Ngf5y7oU7AZuTAORWGEERCWu5kUR7g6qKT8dKXoQ0d1XjJEW/dJR3sf4jLr/?=
 =?us-ascii?Q?7hjbxMCeRKraP4q55CXhb51T788W9PzzwnGPFKwWhyHirpS34Jer0GlhP7kD?=
 =?us-ascii?Q?KIi4MY9ecADgqKXGBUzqBqMpAVnZefmxrb8xjrxpagsozxGgd2OGs7C+nvpB?=
 =?us-ascii?Q?+O4cxkBhuYZwBkoPckII3lSDWE6nc5GvrMMcONdQWWtW68hxfO+0GSxqJ1H1?=
 =?us-ascii?Q?jopIqtx3enU2tGxLNN1J3SC2LrLIZJqtr4eGLY6mKP+VRRp7oXNGzdqW+Pwc?=
 =?us-ascii?Q?AwEYw+iABbH78kVcIzoGFAw9Mebr8ObxlnWOaHWMK8CfJx8M9OkAMs2GPs+N?=
 =?us-ascii?Q?6ZGW7kvB2IGz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c8fb6c-2fb6-4baf-11b6-08dbbd5ff8a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 00:40:09.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBqM7Env+7t0Rs2aI8D6vJngdq6xQ1CSC/w98u2ruNHXZLjB8YWI+a5r41NfhXkLubV2Hig3S0KqOqfbMz+AQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7819
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250000
X-Proofpoint-GUID: NEeBp3iSSrbJTj79mHiI8-W2S2ERi9_O
X-Proofpoint-ORIG-GUID: NEeBp3iSSrbJTj79mHiI8-W2S2ERi9_O
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_and_free_pages_bulk is designed to free a list of hugetlb pages
back to their associated lower level allocators.  This may require
allocating vmemmmap pages associated with each hugetlb page.  The
hugetlb page destructor must be changed before pages are freed to lower
level allocators.  However, the destructor must be changed under the
hugetlb lock.  This means there is potentially one lock cycle per page.

Minimize the number of lock cycles in update_and_free_pages_bulk by:
1) allocating necessary vmemmap for all hugetlb pages on the list
2) take hugetlb lock and clear destructor for all pages on the list
3) free all pages on list back to low level allocators

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de220e3ff8be..47159b9de633 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1837,7 +1837,46 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
 static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
 {
 	struct folio *folio, *t_folio;
+	bool clear_dtor = false;
 
+	/*
+	 * First allocate required vmemmmap (if necessary) for all folios on
+	 * list.  If vmemmap can not be allocated, we can not free folio to
+	 * lower level allocator, so add back as hugetlb surplus page.
+	 * add_hugetlb_folio() removes the page from THIS list.
+	 * Use clear_dtor to note if vmemmap was successfully allocated for
+	 * ANY page on the list.
+	 */
+	list_for_each_entry_safe(folio, t_folio, list, lru) {
+		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
+			if (hugetlb_vmemmap_restore(h, &folio->page)) {
+				spin_lock_irq(&hugetlb_lock);
+				add_hugetlb_folio(h, folio, true);
+				spin_unlock_irq(&hugetlb_lock);
+			} else
+				clear_dtor = true;
+		}
+	}
+
+	/*
+	 * If vmemmmap allocation was performed on any folio above, take lock
+	 * to clear destructor of all folios on list.  This avoids the need to
+	 * lock/unlock for each individual folio.
+	 * The assumption is vmemmap allocation was performed on all or none
+	 * of the folios on the list.  This is true expect in VERY rare cases.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		list_for_each_entry(folio, list, lru)
+			__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
+	/*
+	 * Free folios back to low level allocators.  vmemmap and destructors
+	 * were taken care of above, so update_and_free_hugetlb_folio will
+	 * not need to take hugetlb lock.
+	 */
 	list_for_each_entry_safe(folio, t_folio, list, lru) {
 		update_and_free_hugetlb_folio(h, folio, false);
 		cond_resched();
-- 
2.41.0

