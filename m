Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91CD7A6C98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjISU6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjISU6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:58:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04130D8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:58:40 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JKgZfu023754;
        Tue, 19 Sep 2023 20:58:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=i9HT2DrI4f4j+N18qzb9mQOm0jxoC3ctH7SaCryogIA=;
 b=gQBHbZXGyVoB4HtC2+fM52B0AgKtiSWflaAdcaJYoJe7GPbOtNAgbymofEXMz6Dyw8d6
 ndmxkzHPihsHCzwI9DwmJJGd4GUbxV8Bd1E3VcZnNeYQZku9IRcUGO0xZVfN1/OLJ0W2
 uUxKqyDop4+pfaCjROqKztPd8IG8pIexTaA8lkDghLJx4Lacf+TSokEo51UmBlh9ehxd
 RlAfY6RZYZiEmDRYAxVkUsD2FNt61ulPaV+fC86niVIN3K1Zb28Mabu+ejKf0ipg/D+F
 4BvUlZ5CMjqlX0CKMmH5/UbUeTlZyuHhxdOXtBFz2PoHeG1trHtt7wliJSezfE0/LXO8 4A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54dd5vs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 20:58:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JJoQE5012103;
        Tue, 19 Sep 2023 20:58:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t6fcdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 20:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lq4h7Hn3eE46L9OToh9EUivSbMD0RHY3NyG7/VyglVrCDce2WJd+OetqYRmFjtaYurqnvE8PodvKL+3e3+OBs/17jZTG2W/y3hQl3dJaxBYYeKGIrX6hpCrWIchknGDcYdj7e7qGky3T3Rk2CdIOWBeYpyoQYkvEZ2Ta+8IXPMOc/C6mFcBrJng7F2Q1YbynDTj7X7Z3UXu/u7DyIQoiUjxuTBtq1NDMqz5tqd/OxjQHwqaz1JInUWtfRLivItLax2UmcICacElDkhdrxUSkp6QYPmudW/jlrx6O/g2zNzj7WGsLmPyqOW7Xwr7ArG1GlUWZFqQ89Nc9ohKTVcKFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9HT2DrI4f4j+N18qzb9mQOm0jxoC3ctH7SaCryogIA=;
 b=N0G0ju+jPssdRUY5CrJrIGeQ5jyzXBiYtnv3wmU7d7Qy8INumMYId+bGtHFQOrIhe6+HuBSshYtJ04hTGT1nZLlT5j6MB6ndpfUymlIElaqSnsIYmYwZKPKwmWCwXecaKz/FfFrlSEGPrV6SX9MiFnHL0p3uLZGDBOq5vxrjr7dcK3LE1563IXo8tatU4OULQ2YMPyJn8kbL47trk/OMcmzsJfda1MakkSsAk36fwzFVXlWHKK+Z2lu9y9QYuDOdo+aCn8maAHW0bVJLFH7pjvdsTw5y6/dpQA35t0EUwYBzS+WUkZK5woNfEenKk9IKEZ2DfiUXFinSUabTRJT+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9HT2DrI4f4j+N18qzb9mQOm0jxoC3ctH7SaCryogIA=;
 b=peDSgZZARkpkuFyLbXQzOsRT+1CmwPBgJVnvvsGc+cFzBqTa79sHXUeSkicd/2aqw9pqkzCdn+dSjbVJuXL/b6Oq/S9+4VA3uoWRt33zSLIMlDOTMQnstCku5pwNH87f/QY+YAFQkJpdfc/06YiX1wy70Le9TANQR1MjyUZqCEI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7326.namprd10.prod.outlook.com (2603:10b6:208:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 20:57:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 20:57:58 +0000
Date:   Tue, 19 Sep 2023 13:57:56 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230919205756.GB425719@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-5-mike.kravetz@oracle.com>
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed8c272-429f-4ee2-d5f3-08dbb9531ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGP+mHg7p8pHliLu/Fp3MHOB0MvoVdCvPw1VNkvUkmTm8IDAz2rbxVy9My2ZpGlyn/MsZNuPjww/pt05CTbXDWDWXo4aNhLGXH3FHefgOGDmGn7B6KoC+ki2Nb2SPYrjcrRtCW1Lttp0sgUxaWTJFIg/G9rAvrWeKhPJXfpmJSopx0bCMZ7YT+NLUgNInV5Ysy9MgvFjeeCv4mpwj7RbCv/SWMbxSM1HrvcU/PAosmb6gtFBjxXipVkKrh4qBtP+6Nxv8dj6eMXKWy17N4xu8PHazhTij50ohqVlLr/KF+eQgDr3lIPPb+hPp8MD4TbztbgXC4ylrL5x65rK8THY1p5lUffIMAr5HMPqohss5rUsinaVpllw8nF0pPt2/DaZGfU9BSfP50EimsqrL8ufXGPAUJuhp7NujSpnrgaY6N12AQd8h6whRxw9YcmL2HfBKsNEDxK2bwxp0IfaZ8BkpIyyMD4OeBAcb+HIzg5gZRx1f97bwQXqde3DXC9ofLvcV4KasA+i4pNRqM9EHiefGi1EXMPGm+fXgYKaS7CI0DJuhVbMu849M7dGvvo0yafH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6512007)(9686003)(53546011)(6486002)(6506007)(83380400001)(33656002)(33716001)(86362001)(38100700002)(1076003)(26005)(66556008)(66476007)(66946007)(6916009)(41300700001)(7416002)(316002)(2906002)(4326008)(44832011)(5660300002)(8936002)(8676002)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wvKJdANckqUp5ji3rPBe6p5P/6BZgIdpsyPF75lxYq8gEU8lYC8600eWgNxU?=
 =?us-ascii?Q?H9FWP1x/AzfgYEIiPZJ5H2k19SMfIH3SjYS2lUohTKu+6xorBYaJtXJnmntj?=
 =?us-ascii?Q?dOBHGBxDPrREbcJKjgad8c0VBJn91u/ZjB9Sjv4qeSmmQMnYKBOoJN7IVgQ+?=
 =?us-ascii?Q?0mtlSOu/werkyEZ5VVyM80JaZf4mIVT69I/WZplA6bZg+lHVREKDOZdb3eSU?=
 =?us-ascii?Q?nQOJiSbivaf360HL9/hnr0uN/5NlRFn/PmEELTcusEwId8rqDeTJCs3o3UR/?=
 =?us-ascii?Q?ErQG6zhShZQqzeUvZ1AwBTGH2UUvk23ux5J0Oyzu3JogDuWBYuD0dNo0GNv4?=
 =?us-ascii?Q?M4tHTi7c0rolTs0Mh8BzqOVgx5AXxa1BO3kbGtPNToaw5kRgU25DKZ7PhXsh?=
 =?us-ascii?Q?DS/NdfVaOmxP0AXA2aKP6eC1WYLmFHTBMHf8UKTrPdNWARhnGFgpSsLcpmC7?=
 =?us-ascii?Q?6zBMeWXAzZDHSus9iD4bOIY2LsdVgp9TRsIdYwJ1eImd+kA+Ce7a3TvBt7nc?=
 =?us-ascii?Q?P7L1q6QT4VR5ERUrPbU2D8PCbRWKUcwT0QSWHCAVBT0WMFeyzkHkpCNLsK8S?=
 =?us-ascii?Q?qZyN+oR2U2tI6zlsVummZhZt4ax2RhE/IiUNzY7sj/4m8xszCI8AA+YnANRb?=
 =?us-ascii?Q?4X1aaHZnScQJwAAhLru5xD0MxHAek34sHWdSIhFHrs5j0XGzunbZKUFW3PVz?=
 =?us-ascii?Q?Ezd4JQIwqbgOFaeGzqQUBAU8pNR5qjazQssKqw2IvkrgeJ2D2kQB8GrV6VuG?=
 =?us-ascii?Q?2eo3DoMKm/kHxWZflRSchrw2wqiDS90jH0R+d1VpFmWGQq6r6ZykZpGQN5q4?=
 =?us-ascii?Q?oR1tCPA5AZPJb4VFc+50JIDwrecNBpDROviCqIC9QLAL6wP6osJVY56HXtJQ?=
 =?us-ascii?Q?CVeRmHnyHNHhYNgpdS6jq3H9+ixyll4U+YqmWfzQOGGrQhrMYYY3O+GP4Jmo?=
 =?us-ascii?Q?rAqY+IPNKcjuo0AXILeLX6G2j5angainD3lIPc4N/Ig6Yw4ICBWzwvNEiTbo?=
 =?us-ascii?Q?+VcuEtPLgcsjekXpHog/lapjn+1fcNfM/fud8688fdNpLCpq5SCquOnqRwSK?=
 =?us-ascii?Q?mStiO7RSeo5Cmlcg+Z/5n2q3yCz4dpOlDXiF7bsTrlO/a5La63LgTpvRmYJC?=
 =?us-ascii?Q?grrS7zMhUvqyCVDLa9NDqaZxea7sM+/Ifoo1dDJ5YWexvB0cjSlz4yAlszlg?=
 =?us-ascii?Q?GMST9GMPKExSYw2emrdFmHh11BtFkNjLZuCPdm184YA/6OrXZW/8UjWUyFnb?=
 =?us-ascii?Q?9TMpuvr27qmwfuwnU9n6JRhgNnquvorbKOoKAmIYWqmNHqp25ZFOtdZw7Wx4?=
 =?us-ascii?Q?Gl010JhHCgs9ZANoPbZPFAoCjdnh7WzSRerFaDCYgFtfhxjxtpkXI9P0A7hG?=
 =?us-ascii?Q?yKwqWqFbDxx8+p6ovumumrGkBQmmRGgrcz4ITlB5FlLKTCrhmka9LVMfWksO?=
 =?us-ascii?Q?I8CFExTSVYvAe+5jt/Jfludo98NOOFR8OyGyQRcwcVeI+RvTu8z3V30zQQh7?=
 =?us-ascii?Q?+3Sn+Eu01xOSi5vk+/ANVjhLrCjVuHRj10m+kiPEDox3OHESI/w8X9/0GOVW?=
 =?us-ascii?Q?QITvZS9og2lfvKrr7eIhF9r0akZWTrkKTeOBy99SciTrSjSC4FiPdASlbjsS?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?jwaXe4I0dIFea1kUdHaSXQDhd4IP0xHwpxG3mFrJhrz2X1E1LPezP6Uc0Y9n?=
 =?us-ascii?Q?QwkVDTesu3vcCq1TLMVOJra6LT9/9UoQjAw6PQjNB4V94xrF9Vvzqi8Iy9fY?=
 =?us-ascii?Q?o1JpUf1ndirc1t7w+mxgLMCLJD4kqM/1USuWF25TNkXoIkzk+lnY6bF8uKK1?=
 =?us-ascii?Q?S0J5YYK6MDJrCMo18gUzJuK459UA/HoHlkR0QS4g4Jhgrhgt85KcaioGspNc?=
 =?us-ascii?Q?OKB09S/cIIm78Pj+B+06tZAfyiJqrxnk3mNKbc26KDo2sOjfI0JIhQmPm70e?=
 =?us-ascii?Q?kdAob8WpLMBx/Eb37Uv/pwakWWF65uQj2YdNDs3TjDtLu1Md58ZdpIiI6DK7?=
 =?us-ascii?Q?zIMi5zFg/6tH42sXjh6AmZyMUoNKMRtqzVkuYT08DLfw/JDT9CoWaaCcaC7A?=
 =?us-ascii?Q?OONfrW4iDljwgVd3bb4HqbGt1FaKTR1sOenJDBp6H7QLXrjMm22YtPAlxP6X?=
 =?us-ascii?Q?Yhh4z3Yax2wdBGnMdHov8J3myQ2Y4bU+g/RWpZCyXdiAEj7q/FOx/iPyjAYE?=
 =?us-ascii?Q?nrkG7TH4+qzw6FOWsiu7nMS98Oz54oVpAQKJu6yNc/UEBCdyuL5A0u6PrnTX?=
 =?us-ascii?Q?B/ymegYbXxWhYP/YyBG8+l3Kd45aMptqvVM/ir/jAa/yw4UCzoOYzjiOn89e?=
 =?us-ascii?Q?LrOWt32fOKqAWZss3Pe7ggN+cW4rTd9y2+cs/Jh3tBxBBlmVzZ/oszAr8sP0?=
 =?us-ascii?Q?8VeKZ/mORhdPLZoVsuZw10X6cOJdogXHmCYkGo1J5RXrpxuoOKxBNLugL6t4?=
 =?us-ascii?Q?dCmtNAQLRrwSbXhJnfBcHfY8SvvemdERWvAp+Qojd6eSBOtkGTcLZfWRWsUx?=
 =?us-ascii?Q?kuBW369OEtEJIX9GflsFhsjGVDd/fwlHnzKcod7QDJxz0eE2Wh85W2vi7Mxr?=
 =?us-ascii?Q?mFbEvb/EtVWWOHjMF6eEZrO7GPAIJbyeXdvDT6mozeDsunUyJw/2sYw+oKqM?=
 =?us-ascii?Q?NARP9vjsUDHGId2fUDf5IG8b7ap9VrW5fyXGLAB/pBbl6HdlLYA+7hkHXsHc?=
 =?us-ascii?Q?U762kCBZiwky/mR318MlHLcz5mqUAdgcEtxSq2mkZinVsCJIy+Qi4CwaBwlw?=
 =?us-ascii?Q?Q9GXVaPlAebEux46k4RQlVsyXLhZnqfByEuwulN5SpGuc3GyZjGNZjSqgyhT?=
 =?us-ascii?Q?YT/AJIw9KA0R?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed8c272-429f-4ee2-d5f3-08dbb9531ae2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 20:57:58.9107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2ap1prZTbFU10eFxrwNrGVZ71mJOcM5VRGPIBc1yCW9x67w2pub3U2I+CpeYm62r+BQ0MywyDsoevfUqOT1Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_11,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190179
X-Proofpoint-GUID: 8fusHLk-VkW7kkMJX4sNCkdZjVfCJQFo
X-Proofpoint-ORIG-GUID: 8fusHLk-VkW7kkMJX4sNCkdZjVfCJQFo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 17:52, Muchun Song wrote:
> 
> 
> On 2023/9/19 07:01, Mike Kravetz wrote:
> > The routine update_and_free_pages_bulk already performs vmemmap
> > restoration on the list of hugetlb pages in a separate step.  In
> > preparation for more functionality to be added in this step, create a
> > new routine hugetlb_vmemmap_restore_folios() that will restore
> > vmemmap for a list of folios.
> > 
> > This new routine must provide sufficient feedback about errors and
> > actual restoration performed so that update_and_free_pages_bulk can
> > perform optimally.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         | 36 ++++++++++++++++++------------------
> >   mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++++++++++++++++
> >   mm/hugetlb_vmemmap.h | 11 +++++++++++
> >   3 files changed, 66 insertions(+), 18 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d6f3db3c1313..814bb1982274 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1836,36 +1836,36 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> >   static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> >   {
> > +	int ret;
> > +	unsigned long restored;
> >   	struct folio *folio, *t_folio;
> > -	bool clear_dtor = false;
> >   	/*
> > -	 * First allocate required vmemmmap (if necessary) for all folios on
> > -	 * list.  If vmemmap can not be allocated, we can not free folio to
> > -	 * lower level allocator, so add back as hugetlb surplus page.
> > -	 * add_hugetlb_folio() removes the page from THIS list.
> > -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> > -	 * ANY page on the list.
> > +	 * First allocate required vmemmmap (if necessary) for all folios.
> >   	 */
> > -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> > -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> > -			if (hugetlb_vmemmap_restore(h, &folio->page)) {
> > -				spin_lock_irq(&hugetlb_lock);
> > +	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
> > +
> > +	/*
> > +	 * If there was an error restoring vmemmap for ANY folios on the list,
> > +	 * add them back as surplus hugetlb pages.  add_hugetlb_folio() removes
> > +	 * the folio from THIS list.
> > +	 */
> > +	if (ret < 0) {
> > +		spin_lock_irq(&hugetlb_lock);
> > +		list_for_each_entry_safe(folio, t_folio, list, lru)
> > +			if (folio_test_hugetlb_vmemmap_optimized(folio))
> >   				add_hugetlb_folio(h, folio, true);
> > -				spin_unlock_irq(&hugetlb_lock);
> > -			} else
> > -				clear_dtor = true;
> > -		}
> > +		spin_unlock_irq(&hugetlb_lock);
> >   	}
> >   	/*
> > -	 * If vmemmmap allocation was performed on any folio above, take lock
> > -	 * to clear destructor of all folios on list.  This avoids the need to
> > +	 * If vmemmmap allocation was performed on ANY folio , take lock to
> > +	 * clear destructor of all folios on list.  This avoids the need to
> >   	 * lock/unlock for each individual folio.
> >   	 * The assumption is vmemmap allocation was performed on all or none
> >   	 * of the folios on the list.  This is true expect in VERY rare cases.
> >   	 */
> > -	if (clear_dtor) {
> > +	if (restored) {
> >   		spin_lock_irq(&hugetlb_lock);
> >   		list_for_each_entry(folio, list, lru)
> >   			__clear_hugetlb_destructor(h, folio);
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 4558b814ffab..463a4037ec6e 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -480,6 +480,43 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
> >   	return ret;
> >   }
> > +/**
> > + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> > + * @h:		struct hstate.
> > + * @folio_list:	list of folios.
> > + * @restored:	Set to number of folios for which vmemmap was restored
> > + *		successfully if caller passes a non-NULL pointer.
> > + *
> > + * Return: %0 if vmemmap exists for all folios on the list.  If an error is
> > + *		encountered restoring vmemmap for ANY folio, an error code
> > + *		will be returned to the caller.  It is then the responsibility
> > + *		of the caller to check the hugetlb vmemmap optimized flag of
> > + *		each folio to determine if vmemmap was actually restored.
> > + */
> > +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> > +					struct list_head *folio_list,
> > +					unsigned long *restored)
> > +{
> > +	unsigned long num_restored;
> > +	struct folio *folio;
> > +	int ret = 0, t_ret;
> > +
> > +	num_restored = 0;
> > +	list_for_each_entry(folio, folio_list, lru) {
> > +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> > +			t_ret = hugetlb_vmemmap_restore(h, &folio->page);
> 
> I still think we should free a non-optimized HugeTLB page if we
> encounter an OOM situation instead of continue to restore
> vemmmap pages. Restoring vmemmmap pages will only aggravate
> the OOM situation. The suitable appraoch is to free a non-optimized
> HugeTLB page to satisfy our allocation of vmemmap pages, what's
> your opinion, Mike?

I agree.

As you mentioned previously, this may complicate this code path a bit.
I will rewrite to make this happen.
-- 
Mike Kravetz
