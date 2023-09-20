Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A477A6FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjITAdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:33:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E38CAB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:33:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JNNiTg004635;
        Wed, 20 Sep 2023 00:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=Ebiw6D4fwXZT7d7yIocIPxtDUBvCJrNDyKkcCrukJLg=;
 b=iljAxPSNYNBaq1vosreL/kppgeFG3T0b+/SmIs9ITx/iFKG+CBe7iPEsjDqjFG179Cuy
 orz3zCAs0COd7dND79k0kQnfSLxQNYgwwRhM2cKGhSf13k5bt52ptI8p1I1iKw6Vm7Cp
 RdkOK9JgwAMQAE5veOFZ2m315ZJxL50DqVq1nE7sa6STnAb7f9B2oPlLWWurLFmsu/Wd
 LDWiIDtrLtRpMgzh87UTtUtKr3Y31FzNFDQhDoiqlKKO9jSZm/kNQ3IIal84FSDeo9pV
 23OXhPwvPcGjAobTO/w7XknDaM/5wlfpB7zVPPHReYLHYnOnFoPJpug5CXgNg5gKKuXx Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t5352x6hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 00:32:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38K08tbo030125;
        Wed, 20 Sep 2023 00:32:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6cfnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 00:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuJSc+8ykwWRdCpIBODN41rYbjMftdODD6cQm7y9WUIVZM86W4vP02Au+8D0mhrcdJmWShiGaBpjAPYSf/0XLaV40sKKV7jaMT6gg5KOcq8cpdyWoospilcAXL+L39kj6o17xwhsu8gt/gN6+Mo7jqk4JUFIcxzxYIbWjZitX4VHn+Rdbpi4QWbYKagQVQ9BTuj4C0GZGQ2aoWsL4oa3Ljm7lDR5AgrdmTZpQoChhSvKEjnxdJYUExaeD+/L+21Al8VLRhpP/H2o2an/SqLFGSjNXN6q7x7dBM0v7z6z682ORuSabBFKciTVbkoGyFcz9kuu1uiB/m2unNowN4CpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebiw6D4fwXZT7d7yIocIPxtDUBvCJrNDyKkcCrukJLg=;
 b=YLv5uYuH+QsYMJOd+ZejlZHOxdYuSFPfxHJt9pZ6sVuznGgf3k8PiPcx/Xp/7TaOizlcuBlSXVLphkm7PwaoVgKZ6a3T0o8NDuslSIpyqlRJefgbEL6VRD2SNCliENyg9fDBrT8I8Hf6xgCoQaoWvFmcmeUFToLVuAMOnGT4rdAv6WF91SZXie6Ij9pXZSyWWwwVFj/O16SrtI/EIn0Nb+yK29PDFT1k009KqP0r4VosJnhTVKYEJ7rZpJQMkfHdyttKSbL7LMRF3EHPEZGo2tqiUu72/Kd9MOx6y3uSfB+ftHGqr4orRcLd7FaR8osAlIIGAG4fH1nKmBKqkPcq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebiw6D4fwXZT7d7yIocIPxtDUBvCJrNDyKkcCrukJLg=;
 b=sDrZ2JsgAOqTSDlGjinjG+FhOnp/vDWXq9/Us53FK7vFR+Y2H27ljE8ShE7+oIi7jsNYrRy4sQChIYA403pio/Q/K1GHaXDVMiLiiFEyqvTn64ntemo32xp2VpTEgWuJDzGGo19tqWTz90zk8bpBdb8Fxmur3c5D9YihUJjnifU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 00:32:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 00:32:41 +0000
Date:   Tue, 19 Sep 2023 17:32:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230920003239.GD112714@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey>
 <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org>
 <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org>
 <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
X-ClientProxiedBy: MWH0EPF00056D18.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:19) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f74e055-44fa-4bd0-ddc7-08dbb97119ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yPMTZ2DT21mxBdrbiKS+t6tfJL8W6jDBaRfUg+xQL2ZYK6/GeUcKG0fwdSEdmB2rB1Mxk1MI4q4koD8kinkzvczh/mcVPgsh1ipXpJUXQA27gKX57V1dWnIrE3j3CyBWuIQJ+PMQa8lre63sNqKKKWCArGVoN/I8UTiJIAFgygaR2XINr9zQF0fnDvf0mnnqEBB7UVgdUmqRwLnA30xyNSA4sbYM89t2UyRUD4BMJKwK161KJ44vtHpgO8LHQks87/7G40W0VWQQ2UTRnZLEXhyPweuPBveEpM/+OiUuFGvVuob9ODgQMc+dY6oPyd8t/iwSNCRjWyv/3EUC+VOoPbjZ1/DCsyZJXYhr+P/s1YS2sAWVSkoLA2eE5sSRg3drM3EG2Zhs2BA/M65Xs3RmnfL+6tMU+WeNUf0VwuexVerx9/kkabuBEjzjzlblgIw+gyrFPL5A+E7pqUFHAgjUqZfrlkx8fZrA6epXMwjE4uff+3G8QroRvNtBPlpuFPSvDtetYSKjmnpKQ7ySoedoM7RjahEsDhdnwhH/BwOHIVR67FVlvFkN0LD71T9WBsUW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(83380400001)(6506007)(53546011)(6486002)(9686003)(45080400002)(6512007)(478600001)(8676002)(26005)(1076003)(2906002)(44832011)(54906003)(33716001)(66556008)(66476007)(66946007)(316002)(6916009)(5660300002)(4326008)(8936002)(41300700001)(86362001)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFYD0fIS9ygeZ4kYRXFt0M07Gqx+8oBPqGrWvDE99KCyn7dMzDw8XHdSwgqN?=
 =?us-ascii?Q?8ppCrLaTAf2DS/zmwzJPAh98rbnqxYZwx9idybPw0/QlB9pQgGM+xHIQEYYJ?=
 =?us-ascii?Q?1VhQZuzIgyFk8mqyoB5n7jNiILx3ij/8H1sDHYLOeJevKPW8VUlOoTN4XioV?=
 =?us-ascii?Q?2wEGZa29b5jurehJ+Y3vPwQmBe/gdfQYHwUg98Pj8KrPOmyXV98lHrQrgrWd?=
 =?us-ascii?Q?YPv1ceZWFeTgD7rrOCmVYd1KfQf+1NUiEkN6Yp+d7gemukoIvl+abJ+LqXRY?=
 =?us-ascii?Q?JFm16V5tqfBzom/PVCrE8g84qMJ1qFYQvnE7dvOHbTnkztrhiWkzqUwRbHyN?=
 =?us-ascii?Q?tgTR5Gd0uZnb5v4/G1TkRd0sDvbi3fM9LaBtXzmD6rqy7JvIGXcu1701UzgL?=
 =?us-ascii?Q?k4OFyIag+IsV0solOPQN/3tonGoL+adv1gZucimCqbP4cX24ssMfZ+V7DZ0w?=
 =?us-ascii?Q?+D3aSMaZn7yAgSJs1EVY6mmznWbaulpeWYpRqni64ifZ8p/okgDVHvOmSCV0?=
 =?us-ascii?Q?OYHKe0PnECxo0ZTY8XYG/Ggi6Jko4u4xfoxZ7hwlhhUhqpPclMcN9TfCTwOO?=
 =?us-ascii?Q?7rfHh18XjGlhJr9Q7q1e1K5cZMVdextq2hMQO05IZMzmSsIbZzFSA8SM8BKr?=
 =?us-ascii?Q?EG2py2lpUvXsbQeA0ujA77GkEeU+GOlLVbNU1p2g2C7bmpxzfKFb4fgu72B5?=
 =?us-ascii?Q?IGseBYlw0TAtj+IiFPsrcNkpGxByJjV8DW+BCmMdDlka2nn2T72yzZGFPgeB?=
 =?us-ascii?Q?Mg2opQIe13EBGInoGvnyGMgfaNaaJIL6k0EIeC/7CWOhlpc6P0OhBBtZ4nLY?=
 =?us-ascii?Q?V3WY0BAqlQTZ+8vOs1haDEMoideEbGSD1t/TBt6CvfOeF6HlLHvXlQdj+XAJ?=
 =?us-ascii?Q?0xpGfZ53Qnx7TuYN8J5wmNapIT9gjP8RBX07JscGwutiUPGuo4CEunokxpog?=
 =?us-ascii?Q?Fd4KgooMCzpCUpb29N58208TGoeJivgli2KuU5mGrja6qswpLGBv5W/vj8lo?=
 =?us-ascii?Q?dOta4vyriqSqcaUGe2j9CB7pDaP4ffHtIkupJ6fb5a1oxTT86e1KsVORj2Ct?=
 =?us-ascii?Q?dPnlrLmC486VLMDxej312TkhGL6HBhGaECL++49i9xVsmkyDzl06kK7YJPR3?=
 =?us-ascii?Q?7RiVtIl0DQavg3sn1tNuT6ILAIncVzJW9oskalvYflpw0SIXJxd09lpk/aDY?=
 =?us-ascii?Q?NyiizYPrthCT5DcJw6GEDHG7P/hSviLvw5+usGzi852EW4MzXWtcIlmdSC9N?=
 =?us-ascii?Q?glH9e60KuD9nGQjypph6ep9y5FvTs+Aftnnss/ojzPlmPycMffq0DvMybx3h?=
 =?us-ascii?Q?6KBz9zucIJZHu3g+Q/TQSJHa7L2vz5ET1BOGfpe8CLnqxX39ZaNxIyIfEqUp?=
 =?us-ascii?Q?j8JtNqBeNbpRn4RBU7XvjbR+uYDoUw1o60o0Kgdtvuu4u/HSjgXgoGiBAF4v?=
 =?us-ascii?Q?l0E9iYspBxZFSEpPOTL7s+aXMkh56l/5A/bJWJYrdEuHMSS29DFEN6ktDaaa?=
 =?us-ascii?Q?qNvjhvXuEh5pwhakMMOAaj6AZ4jxGnrdkumdLm+qHXDJPh7xGhUY9BQKL9dm?=
 =?us-ascii?Q?JtsrHstvu4JBbdndy7liiJ9vQLthOO9mSuodQjGS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BCY5uHt3jRAjO7ikGMPHuSDM5Dncx2jORcgbGZFSFJDlLuo4hT9oJEKJD7zc?=
 =?us-ascii?Q?YOiVbk9FQPzp+zsSp59afk4rzREB7+tVn0T6bp8soEDWWEg2VaPC7YlkMfcR?=
 =?us-ascii?Q?GWKpaY63vaSx/wjuBr9ejKud3MUy9LGYiEGzTY1ISsLJ68UXMK/50NSIm0BQ?=
 =?us-ascii?Q?EYeOvt3vBga+IMp7nTVNSq0Dwf7rJYZ0sdnRx7GQNgNC3l1cLEAx8wOjqisI?=
 =?us-ascii?Q?MI84FkIS3xu84mvAVqTCpGTK3X8lR4YUexKqeS/f893Ky8jaJ0FBUTUmxebx?=
 =?us-ascii?Q?15Hl0WtkQ2DdbLx9W3JfCtBSc3TknuqM6x5R0UhGo2qyt6GSleIAUSd042+3?=
 =?us-ascii?Q?pLyHu7yZX4cZNsGPkgT59aEGJM8wuTxqXFBUfjofKS/MQ4rYdKzTROkTXRNu?=
 =?us-ascii?Q?RDjxD+dSbkt648oB7Hw22A0xdbAwhMkgs/bTJ94HiM9n4EJZNVvptNO1Oybs?=
 =?us-ascii?Q?AS2CMzMdg+Ir9xA47EUAN6BXdiARxUfKAk188tvg5lKDIieuG/ESRJRp5P2b?=
 =?us-ascii?Q?QWJk2jb2kYPKi6sCRJSsdFPHm4Q2PzGriukX73p/wgtNxo7xfRQGehhRZ0I/?=
 =?us-ascii?Q?+WMLD7PEsEBMnhkB0Ubtkuub1oBOEZ1HbHbTo9XOVCG02rWwPvs9gvWg6kVK?=
 =?us-ascii?Q?4Kiabpj6fPwe9S9d3SkEWUKZS/0iB5X8XIoMLU+jupTUU7qKdUsUGmELWRMd?=
 =?us-ascii?Q?qOfzB1yTcydGcXVzS5hRZZe4N/h0yAj57rNpHHfuwQNZAteaRWqcy6BBqnbw?=
 =?us-ascii?Q?rKz/eHYT3e5LXYZB8ilLr1kcAKt4TvjjRiKy2Lb+l6+YMzw6C6VkbS8qWKFW?=
 =?us-ascii?Q?ut438lHU38/z90jNvWadSlh6p5IsZR55aQs482pwz13QtJWLiakgJQxD3Ud4?=
 =?us-ascii?Q?y/iUw9Vqj9gM7/zMw9+8i19nh4L+D2FcA8twWNBTMXmeqPfopc6cs/k+d5no?=
 =?us-ascii?Q?oiuvpWg0F030P9N3T4hY0e1TY1UTA+/rZVZI0msu3puG55bVXf0WvdccsAxm?=
 =?us-ascii?Q?kjKd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f74e055-44fa-4bd0-ddc7-08dbb97119ab
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 00:32:41.8416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O35dNEvuhN1YBFpflnFfxSQyPaTnIl5t57xePbJv12FnJQ0mM+8Wk3Y9AHNOZegJq+dq+jGMuwmBs255xn50AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=933 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200002
X-Proofpoint-ORIG-GUID: YZbgSO6yJkbqQxVtJYH4e--ub64Jxo1l
X-Proofpoint-GUID: YZbgSO6yJkbqQxVtJYH4e--ub64Jxo1l
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 16:57, Zi Yan wrote:
> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
> 
> > On 09/19/23 02:49, Johannes Weiner wrote:
> >> On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
> >>> On 09/18/23 10:52, Johannes Weiner wrote:
> >>>> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
> >>>>> On 9/16/23 21:57, Mike Kravetz wrote:
> >>>>>> On 09/15/23 10:16, Johannes Weiner wrote:
> >>>>>>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
> >
> > Sorry for causing the confusion!
> >
> > When I originally saw the warnings pop up, I was running the above script
> > as well as another that only allocated order 9 hugetlb pages:
> >
> > while true; do
> > 	echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > 	echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > done
> >
> > The warnings were actually triggered by allocations in this second script.
> >
> > However, when reporting the warnings I wanted to include the simplest
> > way to recreate.  And, I noticed that that second script running in
> > parallel was not required.  Again, sorry for the confusion!  Here is a
> > warning triggered via the alloc_contig_range path only running the one
> > script.
> >
> > [  107.275821] ------------[ cut here ]------------
> > [  107.277001] page type is 0, passed migratetype is 1 (nr=512)
> > [  107.278379] WARNING: CPU: 1 PID: 886 at mm/page_alloc.c:699 del_page_from_free_list+0x137/0x170
> > [  107.280514] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic joydev 9p snd_hda_intel netfs snd_intel_dspcfg snd_hda_codec snd_hwdep 9pnet_virtio snd_hda_core snd_seq snd_seq_device 9pnet virtio_balloon snd_pcm snd_timer snd soundcore virtio_net net_failover failover virtio_console virtio_blk crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
> > [  107.291033] CPU: 1 PID: 886 Comm: bash Not tainted 6.6.0-rc2-next-20230919-dirty #35
> > [  107.293000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc37 04/01/2014
> > [  107.295187] RIP: 0010:del_page_from_free_list+0x137/0x170
> > [  107.296618] Code: c6 05 20 9b 35 01 01 e8 b7 fb ff ff 44 89 f1 44 89 e2 48 c7 c7 d8 ab 22 82 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 e9 99 df ff <0f> 0b e9 03 ff ff ff 48 c7 c6 10 ac 22 82 48 89 df e8 f3 e0 fc ff
> > [  107.301236] RSP: 0018:ffffc90003ba7a70 EFLAGS: 00010086
> > [  107.302535] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 0000000000000000
> > [  107.304467] RDX: 0000000000000004 RSI: ffffffff8224e9de RDI: 00000000ffffffff
> > [  107.306289] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 00000000ffffdfff
> > [  107.308135] R10: 00000000ffffdfff R11: ffffffff824660e0 R12: 0000000000000001
> > [  107.309956] R13: ffff88827fffcd80 R14: 0000000000000009 R15: 00000000001ffc00
> > [  107.311839] FS:  00007fabb8cba740(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
> > [  107.314695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  107.316159] CR2: 00007f41ba01acf0 CR3: 0000000282ed4006 CR4: 0000000000370ee0
> > [  107.317971] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [  107.319783] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [  107.321575] Call Trace:
> > [  107.322314]  <TASK>
> > [  107.323002]  ? del_page_from_free_list+0x137/0x170
> > [  107.324380]  ? __warn+0x7d/0x130
> > [  107.325341]  ? del_page_from_free_list+0x137/0x170
> > [  107.326627]  ? report_bug+0x18d/0x1c0
> > [  107.327632]  ? prb_read_valid+0x17/0x20
> > [  107.328711]  ? handle_bug+0x41/0x70
> > [  107.329685]  ? exc_invalid_op+0x13/0x60
> > [  107.330787]  ? asm_exc_invalid_op+0x16/0x20
> > [  107.331937]  ? del_page_from_free_list+0x137/0x170
> > [  107.333189]  __free_one_page+0x2ab/0x6f0
> > [  107.334375]  free_pcppages_bulk+0x169/0x210
> > [  107.335575]  drain_pages_zone+0x3f/0x50
> > [  107.336691]  __drain_all_pages+0xe2/0x1e0
> > [  107.337843]  alloc_contig_range+0x143/0x280
> > [  107.339026]  alloc_contig_pages+0x210/0x270
> > [  107.340200]  alloc_fresh_hugetlb_folio+0xa6/0x270
> > [  107.341529]  alloc_pool_huge_page+0x7d/0x100
> > [  107.342745]  set_max_huge_pages+0x162/0x340
> > [  107.345059]  nr_hugepages_store_common+0x91/0xf0
> > [  107.346329]  kernfs_fop_write_iter+0x108/0x1f0
> > [  107.347547]  vfs_write+0x207/0x400
> > [  107.348543]  ksys_write+0x63/0xe0
> > [  107.349511]  do_syscall_64+0x37/0x90
> > [  107.350543]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> > [  107.351940] RIP: 0033:0x7fabb8daee87
> > [  107.352819] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> > [  107.356373] RSP: 002b:00007ffc02737478 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [  107.358103] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fabb8daee87
> > [  107.359695] RDX: 0000000000000002 RSI: 000055fe584a1620 RDI: 0000000000000001
> > [  107.361258] RBP: 000055fe584a1620 R08: 000000000000000a R09: 00007fabb8e460c0
> > [  107.362842] R10: 00007fabb8e45fc0 R11: 0000000000000246 R12: 0000000000000002
> > [  107.364385] R13: 00007fabb8e82520 R14: 0000000000000002 R15: 00007fabb8e82720
> > [  107.365968]  </TASK>
> > [  107.366534] ---[ end trace 0000000000000000 ]---
> > [  121.542474] ------------[ cut here ]------------
> >
> > Perhaps that is another piece of information in that the warning can be
> > triggered via both allocation paths.
> >
> > To be perfectly clear, here is what I did today:
> > - built next-20230919.  It does not contain your series
> >   	I could not recreate the issue.
> > - Added your series and the patch to remove
> >   VM_BUG_ON_PAGE(is_migrate_isolate(mt), page) from free_pcppages_bulk
> > 	I could recreate the issue while running only the one script.
> > 	The warning above is from that run.
> > - Added this suggested patch from Zi
> > 	diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > 	index 1400e674ab86..77a4aea31a7f 100644
> > 	--- a/mm/page_alloc.c
> > 	+++ b/mm/page_alloc.c
> > 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> >  		end = pageblock_end_pfn(pfn) - 1;
> >
> >  		/* Do not cross zone boundaries */
> > 	+#if 0
> >  		if (!zone_spans_pfn(zone, start))
> > 			start = zone->zone_start_pfn;
> > 	+#else
> > 	+	if (!zone_spans_pfn(zone, start))
> > 	+		start = pfn;
> > 	+#endif
> > 	 	if (!zone_spans_pfn(zone, end))
> > 	 		return false;
> > 	I can still trigger warnings.
> 
> OK. One thing to note is that the page type in the warning changed from
> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
> 

Just to be really clear,
- the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
- the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
  path WITHOUT your change.

I am guessing the difference here has more to do with the allocation path?

I went back and reran focusing on the specific migrate type.
Without your patch, and coming from the alloc_contig_range call path,
I got two warnings of 'page type is 0, passed migratetype is 1' as above.
With your patch I got one 'page type is 0, passed migratetype is 1'
warning and one 'page type is 1, passed migratetype is 0' warning.

I could be wrong, but I do not think your patch changes things.

> >
> > One idea about recreating the issue is that it may have to do with size
> > of my VM (16G) and the requested allocation sizes 4G.  However, I tried
> > to really stress the allocations by increasing the number of hugetlb
> > pages requested and that did not help.  I also noticed that I only seem
> > to get two warnings and then they stop, even if I continue to run the
> > script.
> >
> > Zi asked about my config, so it is attached.
> 
> With your config, I still have no luck reproducing the issue. I will keep
> trying. Thanks.
> 

Perhaps try running both scripts in parallel?
Adjust the number of hugetlb pages allocated to equal 25% of memory?
-- 
Mike Kravetz
