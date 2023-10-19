Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3027CEE19
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjJSCcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbjJSCcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCF0AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp68H019566;
        Thu, 19 Oct 2023 02:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=8r2l1Or7Qj9qRoidjA9mZu05EoMF0cTpWPoXgE8Q2W4=;
 b=mNVJ2XFBwfNoTmTbxzmvibG6lEp74QnqfHwO71GmtuPumdaUbCo/arLA28m73DEnbKX5
 E9U2jT1HSmnQM++Ykbk4EMedsyBfWwBJBtkhp0hXF4tx2wVZHxpXDYZSktUonRsUmQsf
 Q6vv1bmYoqXMX+paJmlhbiwN5yWkNjpUAOXpeXl5ku0XMISvjVXxIihF2zjegHSwFDJo
 M8jPQhAjuJkmgYvrbCOIGdPP7+hNkB03nL5ylh0otJVX8RUSo39vKxvTTxu/21ws+6UI
 Yvn+lE4yAedqv6Bsq7l+MrJ/enXUbrqtQm/3qEOnuZG+JaS5IPQQAfNWBxBtRRGDvmfI pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1h57f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1v2ei021568;
        Thu, 19 Oct 2023 02:31:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg539w05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMTVGVYc+lUFA3ppGBDmczb0kuK/MAuJKFFcM/TZw5q6L9KpF865slyDve6xgRvGZ7C2fDP9OzE0o8+Qvv0lkmRYcNl2Isp2/vLdIXQaiQc25s1AgXQRMBxChsKL7X8Ss0STtTsrUL0+4ORaH2xIAdEdtCvM55TPpicC0eQsJl0337c4PMgaoJeZe9kDrdwlBjY+pGbfZueqNFEkbr8/nG4i/had85k0S1mVWFOO1MyjUAcqIAOSnDjhZ9v+l7co+WYYruTEPUbO81ogRPlmTHE0Ds+ylWMuiUGx2IExlDm7533lkYBTzWsBxAzWwue08TB3umzVjyqRbTAcDTzcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r2l1Or7Qj9qRoidjA9mZu05EoMF0cTpWPoXgE8Q2W4=;
 b=ipiWpJc4WWwTyJmV+cNH5JG/EEkq0HhHdMq3s3dNOYX3BojVTd2v5fnxW4XDw9ovAoxEUIylNfOdKgz+/T0sh3F3jzSckFSXR8SZh8u/87n7piNLcxp8NupaXonSW/axRfOvJrCGmphUU57xzqKSUwwfSd4w537uCAgPfdDX7tBSXlzLCLMeWD2g0xxzfXJ3bQvjRHgSLXjkuI/Lu1IJjrp+28sgUsRB2k2TENuZZRwiFW4v6tdO0SYNNqMTSe1yRxG8EHhIpK3xr+iwBVu/nuP7Wgkv4upwH8g36chU933zNVMW4ll5xpTssRQwS8Regxnu258LpRIj/UWJ/305bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r2l1Or7Qj9qRoidjA9mZu05EoMF0cTpWPoXgE8Q2W4=;
 b=aQSKQ9mo8ZEdeNH5nZ1T7zrpw6WNL2c079P2GHNil0hS02qc8y3oTQgpnO2hOtLkW1GClusfoVlrjvXcWM4IkAkoDRqLWjPAb3pm21F3ZDAP8f99dhkxqw84A90OQA7jIGEGK4W5vCCea7GxpxiU+gEWW6XXN5czYz+7kTdCUr8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:25 +0000
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
Subject: [PATCH v8 3/8] hugetlb: perform vmemmap optimization on a list of pages
Date:   Wed, 18 Oct 2023 19:31:05 -0700
Message-ID: <20231019023113.345257-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0322.namprd04.prod.outlook.com
 (2603:10b6:303:82::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 25acd7a6-c705-4aca-d65d-08dbd04b7da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dBZAFNB3bSmlIzfck9KyqlwHScQhvOzLzbSYo4nTk8My5BNBMOgAcufArANNvufEqX9GUDVYlr56vcCKwm8JZuMc8+6d/sq4w4k1relyi1aekFdZYjFLbjvsuHljzWcbPGU0VUFvp7CjtHSmdW1z1NzIjFc+C+2hJUyPV/AqgFt4rONLycNgPfkoJ4Y4T6+aUTY2qB2VuJxwEzOPy0sMOVCAfIMdy8d+1t8m4ITAhnelaWr8UlZljnUzPEXTly5mQbVUaDyrw8lZxCJ/wBrNEB///ghKkKb5r2UVQ7niOOxSyhcYKFxJpCxMCjVaTlK2axpm9A3tmxyIIDmkB1pqYmZYY7AG9TqJ7GTnsnwYlIWuVCYGNxuPDedednSf6MaOMF4x79G3qGW9ewyFTQ/7ZvkxHcQ/oxKvtLV5brvGBAQ3J8hUziQkrDfy3/v8MhykKRyQmk4Tdc/60u793CkS8AS96dm++oCN4upwbgk7awBxsFyiBNs0+EHx2cBhdu8zdg0nWqKIXdn3xyZsf7a1rYh/vPu5Tmf5Q8T5pguis9KHf+KNCY+7IBfk9gU2Oyg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/EG/6gl6/mWFNXw0eiqCmPlHYfNUhG+MLrxZx6JTkM8fzDW4dgfkkB9PNPUv?=
 =?us-ascii?Q?Ptn8xp2vmlK22QlcPyN3xvUqBrMBvBk1y+EFOBxRzCQJRMqW4XYM4lkIy27O?=
 =?us-ascii?Q?SaI1Ss2MFK6XP2uV5ZR35HhBbtfM7y0rU1rQfLvaEcJhrEZvvepa3XCSsH+K?=
 =?us-ascii?Q?4EvhDWj2hWc3fDjGKuAivBwyE9kobjG8WBjlBayRcH/ce0zuU7MuX5NzzmwW?=
 =?us-ascii?Q?/jiRm0hiYcsY2QJFbTEKF7fqy4wIUk198HGhGdy7LFIJSfVMUGaZU0h0yfyW?=
 =?us-ascii?Q?M9mv+xHRFwXptbmmC0YaTfQ5BEcfBq0ZCs3dFOX3iC8vD33Bl966GP4I2Mtc?=
 =?us-ascii?Q?JFGHTIFb5PlzeHrNLtf/MZWwtNJ/ugKI8AOVrxGbLkQCz3VULTG+X1es0GFz?=
 =?us-ascii?Q?OFX+oIF1PPZ9leheIEWuRAL1QqIYgbgM/S5DeKBOG7OkZYc3a4Nu4J8++Ogv?=
 =?us-ascii?Q?c7AhpYXcq9ZKUbPwZ4t4EppfNm2EADPyxD5Hcby/yeW98TLzp12YLj2Q3hZa?=
 =?us-ascii?Q?vP+cTWp4mmtdgSjqz7KtI7Z/++lvjgCGy9pIMQpSkV424pXSznifaNJDfV1T?=
 =?us-ascii?Q?blFNkGbEqdTZsx9OZcbv1DmhkK07izHl7H3JPY+0UQdfQeeqPIHfxSaDV6jR?=
 =?us-ascii?Q?u5c4g2xUwe5U0IxWj4PF6I7GgVa+kaL4rOAjMgTtg3w/fCQIlWq+sHMew5wE?=
 =?us-ascii?Q?fGju4wlYmKwdEzGExPRJ/H0Sh9FV/J//zMlQgnJtbxVEYGSyiYUIAHY8v8Kh?=
 =?us-ascii?Q?6rStjjbFo77fr8GT0RiNhFIZIJOrp79A1Q0hdwY9yu8WsADc2p4ePL/xrj91?=
 =?us-ascii?Q?7I/Zn1jWx+KqLvzpiHyRvGl19S0/jwhDWLBYFax64//GHNZhA/o/jzfRNawr?=
 =?us-ascii?Q?obqGtvr9d0hXcAh1O5yjBVC7h+fkX5Q/JXl2k0jbatutbYgSfppE3ZsCTuDp?=
 =?us-ascii?Q?Q4UHepFpXQCN6vS2QMdmt8AEA+3lA0dMZawf1OtmaiViRGDmPv3eGKiKv6tR?=
 =?us-ascii?Q?nVRywdrTjmGNtNSQP1vwcTuk1eBlMpijyIfkg/DwAyJZnce74dAnMAhX47hA?=
 =?us-ascii?Q?S+OsSMg8N2z8yS67nnLxuciP6sz+5/pnje1/zYX8gQfAGzcINqARHsYOL0of?=
 =?us-ascii?Q?eEmQLAwd3BM3TU2amwVdwUVfGCV8wBojwrBBnsvtkqGjWU6ez1Pk7nZ8odSQ?=
 =?us-ascii?Q?P2kXNP7vZW5eYAnRdYnJIcKB9UKE4d4flzxV8Aa+v2QI3YPcf+nOvkSf/L7J?=
 =?us-ascii?Q?Y9JIlAmwi0fBxNwFyqIabrB1AxPDyIJrfKi91yMdWyCAN6EXS0CCpm84oEe3?=
 =?us-ascii?Q?YVm5o685cWzRQCdS1dSVoxvr3RdCxGYZB7V0/m2nR8k2ac6hxy1aBEi+wPAj?=
 =?us-ascii?Q?Jxouc7iQroQu1Rzoylkf+QdAmP2uo8lhpYKj+Br3gr7hdL/lXLKxe9QJFVDK?=
 =?us-ascii?Q?48PzWX/8gCVROYMYSdBMhT+jQUR68LPKF++/llkFj3Umi/HQ55x5JlY9dIcj?=
 =?us-ascii?Q?LRgXq8esPijCjWxjRo1StE1veIInRZyASt7QCEmd+aij8ZM9e/pPtXJGU7us?=
 =?us-ascii?Q?+foYLSgxTJd7Hr6t0/DkWNWYuBUc7v1ShOSZFxTQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ocGngHMWx+ZJ+sFS0QWrHCgIzIY2gZTM2f0xozHLCBOrkTPo1BuicFmY16QO?=
 =?us-ascii?Q?ge5Njlg8FWgP4KTBXI/AkMOliHs1ILoYfQSfrWhTYAX6g7USWbjDlGiB19GE?=
 =?us-ascii?Q?bxc9iSJPuEDRS50Xmnac0P8B2km4nFqflSltiH8Rb0lFhEM4nNOpI5QpiU4Q?=
 =?us-ascii?Q?7kBY6y26b7zbyYNGmB6ncJEvPgjjJQbVAFiKHESOHnur3fQvqd8c1xseNla7?=
 =?us-ascii?Q?+F2RkJyXm7LJs1Pusgkyd6pUxL0jhUTBVhBOuOhALWEJGbvJxgj2QkGVunYV?=
 =?us-ascii?Q?C8v1TSSHYHzXd5N8ve6lCVyS1IGLU6yNH5xnCsG1iSiF5WepXUCqU7Rqnddu?=
 =?us-ascii?Q?hfxurg/7hnYFcjtE7J0rLhx1SxYbeDGj/iVm8zIuYy24UAXTuqTRsn14k3Dy?=
 =?us-ascii?Q?Et/W2IPbGd51FfcwARSZRu6QHH+aiANGg+nqMOfGq6pd5OuSpLxCauB+XzNP?=
 =?us-ascii?Q?nYsZ4PJX3ycP6jYnS3MMh5HwRnoBU/tmr7TYnLuH9o5IdLT1yWK99+/zwrqR?=
 =?us-ascii?Q?2ORHZ0Dina1usV8gT04HUvaL1iyinlQRFGZ1MqCk1bL6mhZtPM9G2w1mP2qb?=
 =?us-ascii?Q?8Zu6+fT/3rA7h3O3FNXVMPVNZebk/CR4YcnrzLdM+Fw8josU4mzMyc76X3/z?=
 =?us-ascii?Q?bcFnSwaG2qFx/W9KjK5d0oosIUwOlFCiq5Rqi5g6ePSqDVUxq1DReDSv/hrt?=
 =?us-ascii?Q?mzbdOAYWmVVvn2awt5yOrz6mG5etEgOGogh0ytIHglY29qVyHVSJEvHfutOr?=
 =?us-ascii?Q?y47yQVRdmi+Alo5iFsReldOQ79834wmo1wpGHqRswenob1UzP4wjBvmZKqS5?=
 =?us-ascii?Q?SqpvKBHtMWEVbPiKlGFGFwetkW9unCHJ/BjYuqdLc3NY9KyJjeS0uqTNG3LF?=
 =?us-ascii?Q?H5DjN1vgShDu+Lf61zJdn/RgWYVRKHUHnbm0BkIC9mBADo+pRsgTWPvOlpbM?=
 =?us-ascii?Q?Zz/b8bjWvCUKUof2EIAhpMt0XKxUWCUVpMAOPjPF9epmVWh9lfBnqwKYz+7j?=
 =?us-ascii?Q?jQUmgD+/8n3YavRtC7VHBoqR6BU+s/Otnj/69Finq9nYRO05kjoAKbDucWK/?=
 =?us-ascii?Q?PRZfEI09+IxXgiAZRWJ8Xb6+0/0ggbxYyftADgH17Y2mL7iSKUsZSlSiYekg?=
 =?us-ascii?Q?lcpktP07g8WvhLkz+uFOyDvOBqo4CPigzDCjMBLlc/LGUPhgbnWf00+qSCZT?=
 =?us-ascii?Q?FSV5vZ+AfxI5bzDm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25acd7a6-c705-4aca-d65d-08dbd04b7da5
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:25.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 913NOzdLuCmNHf9Cn7zKvVS643QaZsgmNYQPV4aMnT3yI8TZeBFsWBQOC+61rSqhImYtiZtNtbgH9NCB1vl7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: _fw7hiRPovR_TVqvzHA3Wm3k3Mm_F8Ij
X-Proofpoint-ORIG-GUID: _fw7hiRPovR_TVqvzHA3Wm3k3Mm_F8Ij
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

Due to significant differences in vmemmmap initialization for bootmem
allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
is created.

We also modify the routine vmemmap_should_optimize() to check for pages
that are already optimized.  There are code paths that might request
vmemmap optimization twice and we want to make sure this is not
attempted.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c         | 43 +++++++++++++++++++++++++++++++++++--------
 mm/hugetlb_vmemmap.c | 11 +++++++++++
 mm/hugetlb_vmemmap.h |  5 +++++
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 559f7c71c596..8b171f866d0a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2282,6 +2282,9 @@ static void prep_and_add_allocated_folios(struct hstate *h,
 	unsigned long flags;
 	struct folio *folio, *tmp_f;
 
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
 	/* Add all new pool pages to free lists in one lock cycle */
 	spin_lock_irqsave(&hugetlb_lock, flags);
 	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
@@ -3344,6 +3347,35 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
 	prep_compound_head((struct page *)folio, huge_page_order(h));
 }
 
+static void __init prep_and_add_bootmem_folios(struct hstate *h,
+					struct list_head *folio_list)
+{
+	unsigned long flags;
+	struct folio *folio, *tmp_f;
+
+	/* Send list for bulk vmemmap optimization processing */
+	hugetlb_vmemmap_optimize_folios(h, folio_list);
+
+	/* Add all new pool pages to free lists in one lock cycle */
+	spin_lock_irqsave(&hugetlb_lock, flags);
+	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
+		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
+			/*
+			 * If HVO fails, initialize all tail struct pages
+			 * We do not worry about potential long lock hold
+			 * time as this is early in boot and there should
+			 * be no contention.
+			 */
+			hugetlb_folio_init_tail_vmemmap(folio,
+					HUGETLB_VMEMMAP_RESERVE_PAGES,
+					pages_per_huge_page(h));
+		}
+		__prep_account_new_huge_page(h, folio_nid(folio));
+		enqueue_hugetlb_folio(h, folio);
+	}
+	spin_unlock_irqrestore(&hugetlb_lock, flags);
+}
+
 /*
  * Put bootmem huge pages into the standard lists after mem_map is up.
  * Note: This only applies to gigantic (order > MAX_ORDER) pages.
@@ -3364,7 +3396,7 @@ static void __init gather_bootmem_prealloc(void)
 		 * in this list.  If so, process each size separately.
 		 */
 		if (h != prev_h && prev_h != NULL)
-			prep_and_add_allocated_folios(prev_h, &folio_list);
+			prep_and_add_bootmem_folios(prev_h, &folio_list);
 		prev_h = h;
 
 		VM_BUG_ON(!hstate_is_gigantic(h));
@@ -3372,12 +3404,7 @@ static void __init gather_bootmem_prealloc(void)
 
 		hugetlb_folio_init_vmemmap(folio, h,
 					   HUGETLB_VMEMMAP_RESERVE_PAGES);
-		__prep_new_hugetlb_folio(h, folio);
-		/* If HVO fails, initialize all tail struct pages */
-		if (!HPageVmemmapOptimized(&folio->page))
-			hugetlb_folio_init_tail_vmemmap(folio,
-						HUGETLB_VMEMMAP_RESERVE_PAGES,
-						pages_per_huge_page(h));
+		init_new_hugetlb_folio(h, folio);
 		list_add(&folio->lru, &folio_list);
 
 		/*
@@ -3389,7 +3416,7 @@ static void __init gather_bootmem_prealloc(void)
 		cond_resched();
 	}
 
-	prep_and_add_allocated_folios(h, &folio_list);
+	prep_and_add_bootmem_folios(h, &folio_list);
 }
 
 static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 76682d1d79a7..4558b814ffab 100644
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
index 4573899855d7..c512e388dbb4 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -20,6 +20,7 @@
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
 void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
+void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
 
 static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
 {
@@ -48,6 +49,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
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

