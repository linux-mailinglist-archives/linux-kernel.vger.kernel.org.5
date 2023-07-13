Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDE1751532
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjGMAXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjGMAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:23:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A6E10EC;
        Wed, 12 Jul 2023 17:23:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CLA0Bq005107;
        Thu, 13 Jul 2023 00:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+lzsHAHZOcua7Nkoixl0JRF7+akkEEnH6aryrOvVDkQ=;
 b=Tkmeu4sNMn3HPc4a5HuydXUTpu2As4LYaY5PrSJOwAN7RQYkGy+VHkeW7Fkwxlgt36HF
 iO9GOjuSeZEBV46KZAesKDJOBATrTL1DRgck6cwo4AuVTQHE4hdr2lvSiMPKej8sYee2
 /vDprPFrpp0rTDj4LaKQIwJGLRq5/NVeHgFyrEjmk2i+hW/DRa3kS6xgRYDO2lgCzRCt
 CEblbGoGykuOe69X/6C8p2HZ/Z3gpB7mU8vOCfe8NxG7uWfhFgmuA8iCSBjjHfCUSPft
 GRZKvVo5+jW3kkL+LIaav0Ez5td4Odc+bpLfA8Xj4Iqw1VUMhAyhomi7y4nVwwRoA7gL kQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpyud8knq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 00:22:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CM9nax008322;
        Thu, 13 Jul 2023 00:22:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8dqwrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 00:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbnzfUP9Ym4So5VQ1K8JBK41Lnas9kP6StNBJfDEUHJaTp1kA3oiyCe5f9/uOCS+RWR3G4jUEPNGG0FTsB9hos5j9H+1VbnbNQlxz3qgP2VJSA+T+MftFV+zyNhkGwmqi/6KbVawX3JKhpjLn72Tuc5CwlP/kZkqfDoGMlQ4iYdXPjtUKzHElzvgUm+bVzG2YjYMsGcDDVzZvQ8miuzsXMbyoCwjv70Mw9KgPi4sTubEFjwXCY/xGrBkkuLhvKQwdxE5Tl4PQsbLvA2oSD8e9t0dpDSaIoCj8XG+kCfkONkf8/xcD5p6keln9HmBHpMZAAlid6pnsKevQxG44dpNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lzsHAHZOcua7Nkoixl0JRF7+akkEEnH6aryrOvVDkQ=;
 b=dvQOvbQVxzPAK6Xer+FNVARhundaJldYCnBz8/cxa7kJO1G7NjHuQW5MOG+vXjxpQiNQnfxRAlsmuaMkZzm8dbnTaAPE3CCOno76Kn6zZ+eOZ40v5fD9DhrX4VNYbiLybKRy/x7tS54sFHrTBoyHbfC6PHJ1Tc9YbJuMGerF67XOXPD0udF+nZll2Mp0NvzTdBTpMIgonRIZgBjz6f6HN99tnFaQ6dbD5yobd0bVE5+Bvg+C0B5z+8+u5S+HYWmInRN1MUTi/vQ0Lu8FTqSK0m6LjnJuz4091lEZqTuNOkV0+Ds8PjLtHrfaMIDeEB0z4BRXwsI0ZKW/sL6Wg2DoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lzsHAHZOcua7Nkoixl0JRF7+akkEEnH6aryrOvVDkQ=;
 b=WmCUXkLAPhXiG2a7FJrQn6s9dOaHBnCMFbW/phosFgi4T2+lg2VxDR9IqHJV/koFQF4TUf5OyLZ+Jl3Ey+loU6x1O2zkdgqkzCmhhV6M6GnoxTudUjQZZHFG/lTf93ODSXBHF5VrjhropezuRGm0WUaT+IxYiGV8lWWhjKV+V2M=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6073.namprd10.prod.outlook.com (2603:10b6:208:3af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 00:22:26 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 00:22:25 +0000
Date:   Wed, 12 Jul 2023 17:22:21 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] hugetlb: Do not clear hugetlb dtor until allocating
 vmemmap
Message-ID: <20230713002221.GF6354@monkey>
References: <20230711220942.43706-1-mike.kravetz@oracle.com>
 <20230711220942.43706-2-mike.kravetz@oracle.com>
 <4469DCBD-59B4-41F2-A097-E5F01DD9E967@linux.dev>
 <20230712181445.GD6354@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712181445.GD6354@monkey>
X-ClientProxiedBy: MW4PR04CA0075.namprd04.prod.outlook.com
 (2603:10b6:303:6b::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f7c576-46ed-47ed-7f6a-08db83373bdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YiacvkJqi666ap3kpfv3uIqgRWL689SHnjRau0gySBjSTW9zBAdjQNCjpPW/qXufnr5bvJSEMToZADCACuCuiSSUiZY+hm8uFmu5DkpkbGFEFGSjMcIcr6ylt7ITE+doL6pSiAm85PwdKRaeZ944sOtuZxTCRNiuNvWFwaYjYYPs6HgqQjtbDqxYxTxWrsx4lnBTrl5ODLVUU4hoSPBLW5sxDqu3XuvHsGNKTjnHPlT5sUg6AI5RfJiIfsv5hwgSoGi1RZWgS6YHlT91q3AISHB8YqitzvBzbAq0gFZuK5aQSwCnmXDn+ApARCwFIm0OImNdlRDaxhbNGXyxXqO/6xY3dLLbhWVaxxnqc2yxsYho1DyJ69n3a0Y++r4qeAwX2WV5yyMNc3s1aBrWETZa0TVnCKpB1swEXUYEnxC4endEPYQ6hw0eAxE0fxU0JHdKCINmdgV1lJo0y16iqZ4y646Ul08H3Yas1hFAExyTeWzJ67RDdrCaigOYjjj+koquJAFSpP75glt9h2xi8+W2t1JgyQoRZojK6UG819E2IH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(7416002)(44832011)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(2906002)(41300700001)(478600001)(8676002)(8936002)(54906003)(5660300002)(6666004)(6486002)(6512007)(966005)(33716001)(53546011)(9686003)(6506007)(1076003)(186003)(83380400001)(33656002)(38100700002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tqzebcy0rG26N6RSiLGgGkicKWIB61OkrTqAj0ZbNErbHdbmqTfkcJ8plqr?=
 =?us-ascii?Q?F5fxVhEYrcQ4scpHcqK9LQiRR1RGiRMK7SHWoy4QZQCbv2XoS53EJ/vo68Ip?=
 =?us-ascii?Q?62NjqhQK+DGtZYwuwpXgpJFMa206M3FcB5e5PWa2g33GYByF8wyrgMrtvVn5?=
 =?us-ascii?Q?Vu7GyP1ugEjrDoAkcC7R/K33ypUAaD+CwJW3WbODGhiGeVzWiAXEU653zOSZ?=
 =?us-ascii?Q?sev2zA5eUiq63axVz3zXLp1Ih6LF/SomlS7qVdJCQIxLoBTWUb7H+/WQBOdq?=
 =?us-ascii?Q?zj3u8CQu61rHvZoImTrhBnSoQ8Iaa+oEqPWMCI7VUMd8PVkIsHnTDLjkLTea?=
 =?us-ascii?Q?crRcB0YmKqibxuPKpz1rFjHP5RaXnph4g4t81aA/TolAC/cHyiQBmtDaiKOk?=
 =?us-ascii?Q?l4Ew4qaxMOsEbef0V6TuhjQbZGQCKTpb9q3xjvLjfbw9sDVByBd36iEpWQhA?=
 =?us-ascii?Q?4FZAiC6G2nBqDCOOqrSXo2Kh3pq71UsNwbVI6iKEnoFIB+mbgcOvkfpE3e+C?=
 =?us-ascii?Q?9UMqZoF9ehZ2Oc0wC312cFMoc0YHQ4CDwB3YGorGtMfXARSKxAJy3k9G4Hia?=
 =?us-ascii?Q?AU5YCKh8KLcgFaZ9okPIRyVA7neBXvKU4ib8cFsGXkbZ71a+izVZj7gcDBcG?=
 =?us-ascii?Q?Km3C2aGKJ5H6BvLTZSvf14gNGt79FyG2pTx0NUtE8ZXtaMFvPfG7K/f8Xdd2?=
 =?us-ascii?Q?Oc6lITmU3dwBM+RpbOCB209n8rDHUmDuSKe63gvm7VsV6yV2coSBQ8LWLesn?=
 =?us-ascii?Q?KqaM8qCuB1vjwo1aaZk8teC0DImWz59JvPjF6Qx1dEv/HJNXpfoBVf7MMdpl?=
 =?us-ascii?Q?kRn0q+CFN8/3/ajwYHcqdY1zCWkq4xJiUmxxH3bv2Pg4SJ/7e5WVMJfAmxtv?=
 =?us-ascii?Q?wgXYzitiP+dAhctaZf1Pt6opv3hyOsmBUNXyezltKhVnZPXw5wrr+1p3DvQq?=
 =?us-ascii?Q?/cFfSJXiz9tgUnDD4CQbkJh3FcrlcmEV0sY2p1eHvAZ+qwlF57vjVUTZioDu?=
 =?us-ascii?Q?0+pXWKcT24NViSVXNBb1t5vJ02o1XoR+Z1yVwfnkDvqH9+/nOpWfHr/41/Lj?=
 =?us-ascii?Q?5JE2WgbJcX0yL7g1qiLCpfGPBa27KWZ2uTWDF93+Vzc0Qxno00iQ4FUvtnLq?=
 =?us-ascii?Q?b4hZvsj2NbrC7fgUXWWZ1QO+nd3BqegM3e8Za3Lyy05ZOQ8lWdR9JCCDEEC1?=
 =?us-ascii?Q?cXAAMpQklakTzx5OS/Zw7+2ZNim78mBEbKnLtgnxiBfJ1jnQetI99UbJUlxi?=
 =?us-ascii?Q?LHsE5pso3XHxBCm6GBB5qx8AdMBCIPjSW5TbgrB857okn3L5o+VquW+I+/xQ?=
 =?us-ascii?Q?9YZm0VCGOS22CTOYAuBP4RDyVQgrB8p77/0WiEyhXlUTv/xR1e5nC+FMeW6F?=
 =?us-ascii?Q?0deLYuMZUSC8BLEyrWbiEfMFizKdp6WqD1NwV+SPnGKbW2FxB/JqwyThgk+D?=
 =?us-ascii?Q?AKioGXH2Yzvv6qRcgs9+CsLxRQpo+N1cIlcjlSrokkp6i89NqsfkEfmYai9o?=
 =?us-ascii?Q?VfYHh8AXIoaQDcdWpn9MiByUNjOqdPO6IdC8gq9FysdFFn/99hjAj1rEqpy5?=
 =?us-ascii?Q?h9kW1J9ibtQeLAEHZ/vMyHKzJewuUROatBAEd8JVzqzuOMj1kubaI5nhKhi9?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ena0xZ0F/W9XrCSLCFsEEQL9G3kOytyDcyisvQYAj/jdMNGrkeTKGzfShXVa?=
 =?us-ascii?Q?Oa4OVo+UxyIQgl6RNlvKSKOjnGP3UxH2MvE/03/+bJPoDkWaJu6/q0mv8qH6?=
 =?us-ascii?Q?GuXNfkxv5F6UhLH1TUzph+3rcNf3eLxksnzn2cxjCLEYeM1bcM5uWfqD8aob?=
 =?us-ascii?Q?2Vc3V+W6inWg65/QKjy3cvYxI22yfawLtLQk/zcWNuUeX9fEnbez9LDRtuT5?=
 =?us-ascii?Q?iM3RteUfCnYGb+x3nCSx8NZ/CF75qiGCWwvSjPUoyhpI9CJzHV7Of3Wzoh01?=
 =?us-ascii?Q?crMnO9LPr5e475rkDVaDtmZRBjePr8wJgnxmOiAlIOsic0Tobzac+ZiH9muL?=
 =?us-ascii?Q?BcT9E5D/Y+e4xijRoT+j2IFiToxkD2n8CytIN5zO7NlXVr4n50If5AeaOCvV?=
 =?us-ascii?Q?zY49SwHJJrSpOqrf0qeVYXPu7vUhtJoe9FWUmxRBCE4kWHOj6Pc6MPiEiPsH?=
 =?us-ascii?Q?40XzYOL7nRzosPlbK7E6U27tV4BeLcCZDfJlqXXv7kP9Zd/j4FUvGCA7UpIO?=
 =?us-ascii?Q?OVJTIG8vrSYS4Ob2W1eNp9XSp28mKepBNOv7Q+4fK3yGa8P4SZ+u1nIGyzNn?=
 =?us-ascii?Q?JryGGpyIydQjgKP8a4GkI13LcgNmsAncZbtMVdscU/p7xEu3VO7fx6i01lPk?=
 =?us-ascii?Q?rG6zlq6uHHuzDJMNZXCcWLQ1+58m0xzXgIBjPdvlZPQItgblPflVjJ+HGLyP?=
 =?us-ascii?Q?FbRvyur2W2ctLDH0/jOiBE7ZU3eK7IKk+0bFpnlL5v77A+rdi/qdm4sNeEih?=
 =?us-ascii?Q?VgwM0XSFBTk19JunLKItu+H6PEyQ8c9xmGLt57syz70ICrw4dmBkqwGQq/Ev?=
 =?us-ascii?Q?8pjn7jcpYnkhwO5ckgUy9b5Wpfi1eidwjAThSGkjy9QX92tnk2e1e5Mm4Rxu?=
 =?us-ascii?Q?H6N7HQmgncqH4BZ/ztwBABcy77KgOAx7JB10tBorCC7lgiUITu9yV1VczV55?=
 =?us-ascii?Q?x8DoOtkYo65s6jGDXV08y1eYP/GMNEl27T8FVM9zmaJoEIhMeHKYVYlaWhnq?=
 =?us-ascii?Q?0gxL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f7c576-46ed-47ed-7f6a-08db83373bdf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 00:22:25.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6sVplvIj17FkmCtTEBdtCJuzSe2+121LHPKebGL10zLi+TLVQxVdFOvgYPRj9wR4qdFPsZiTt2bsBxBYT2UxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_17,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307130001
X-Proofpoint-ORIG-GUID: xi2566Xr-uToqPeUAu15UYaLD31xA6og
X-Proofpoint-GUID: xi2566Xr-uToqPeUAu15UYaLD31xA6og
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/23 11:14, Mike Kravetz wrote:
> On 07/12/23 16:03, Muchun Song wrote:
> > > On Jul 12, 2023, at 06:09, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > 
> > > Note that this will leave hugetlb pages in a state where they are marked
> > > free (by hugetlb specific page flag) and have a ref count.  This is not
> > > a normal state.  The only code that would notice is the memory error
> > > code, and it is set up to retry in such a case.
> > > 
> > > A subsequent patch will create a routine to do bulk processing of
> > > vmemmap allocation.  This will eliminate a lock/unlock cycle for each
> > > hugetlb page in the case where we are freeing a large number of pages.
> > > 
> > > Fixes: ad2fa3717b74 ("mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > Hi Mike,
> > 
> > I have seen an issue proposed by Jiaqi Yan in [1]. I didn't see any
> > resolution for it. Am I missing something with this fix?
> > 
> > [1] https://lore.kernel.org/linux-mm/CACw3F53iPiLrJt4pyaX2aaZ5BVg9tj8x_k6-v7=9Xn1nrh=UCw@mail.gmail.com/
> > 
> 
> My mistake!  I sent the old version of the patch.
> 
> The new version was modified to simply check the destructor via
> folio_test_hugetlb() in order to decide if it should be cleared.
> 
> I will send V2.  Sorry!

I was about to send v2 when I noticed that this approach opened another
race window.  :(  Closing the window should be just a matter of
reordering code.  I will take a day or two to make sure I did not miss
something else.
-- 
Mike Kravetz
