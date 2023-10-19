Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73B7CEE17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjJSCcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjJSCcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:32:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952B8119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:32:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IImvgx006156;
        Thu, 19 Oct 2023 02:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=zIzRzaEFJL3VttvyiJzJuePNjkl9xmkcG5Vgx47RGq9Oyk8IO6QiaIr7q1kGbPT3en75
 bZ9FyjtBc/mZE5VLtdQEn6M1G+/TZoLd3x2jo0dRPyf19gk3fM2PybsQQHHSC2SNoKwb
 quMJo4aIsfJ5llP49wCs/8hdaLGwRDk/Zq42uZvYPLIS8VdFJuQRWgrcRolRdNQDsXxj
 9orz8oriyVZZflsCEoFToW45f8CVQkfJv9O09+cjqGK6Q5/mujNaz0hXVfeD9ySdbHGZ
 bAR62paulj5wO2KWSE+AIlFw9tvZ2/Zsj6TX5slEuZoBrUwmatdznTvZtSbe+Ft5u9VI zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjynh6qq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1XXA0028424;
        Thu, 19 Oct 2023 02:31:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy5uuq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwSXRct84p7n3qNmcCpXrgiXVwhWOM9oyE9HzBUyQ62z6IHYipGHSNjXe+Nqt8dX0CRKx0+sF1VXwqKK+SSR0epWi12efiTQdJe+zM2NRvvwszNxta4hlSBOgjmCu/JAARD4hROOsMDT25klxGSnnRN4juhI95w+L8wf2udOOhcf3Iiou23uZ9fj3Y0lMnrC+l8d1jpTp1VQ5tcDQSF3HmL79yO/kXNhxjNVdaWUwgDU6rPGkzDO1qSWJLnmGJ0JPDK771hXOjbYkLk2AnMxUGl1OMWJVZOqFlODeJlA1UIraQYAXhBhbDMwhi3Mo5gUbNu/qJDqF3IXACQog/PNbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=gy8NHHJVKnRJXgT637IGI8p416sOAD7RTVxZu64gp6TWx/I6r6vZRj3C+mnLJdV6Blaw4xB0Yaw5COo5u/1Di3NA0axKJjqbD7v0PnwmnFzvL8G53GyS4PVaV6vdfpt+eqaHC3QhqU5/LS4JEpbVPbhpT4OpLTOKmpbO5s9R2JDMEuVEPVn2FjsdyrC2FAm1pMVKTDmWAu59IGMPSViCP4Jvs4RuHbCSOh6y0EMVfh/VxXKWTOhuh7apK1CPa99pQcKdgapQ8Dqw6iaScQ0qOvHj3z7FQ+Z8N8sc6ecRUJwQ0dwP22RQzv9+lZbDReDRito+R0bkD+KaM9M1sN4KQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vbONjsZvravfMZFWf/jFmc0JqQCVqxQwTo9QP2uYlc=;
 b=Ts6a96pA8vZshVxeWlSNKv9+d4JA1ceBGvSEyy/3yr8QYK2p3AVIqIz0r7Bnjrz7YUjvuT0ZERBAx/05KBJe1rR/44Uou6xSXnG/wGwYExqtFENfXmg+h7A0UEqHduhim1pq1vAEt9S8eDHTjLs1jIA6hUrVOxw0FclRCGkD4rA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7123.namprd10.prod.outlook.com (2603:10b6:930:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 02:31:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:31:34 +0000
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
Subject: [PATCH v8 6/8] hugetlb: batch PMD split for bulk vmemmap dedup
Date:   Wed, 18 Oct 2023 19:31:08 -0700
Message-ID: <20231019023113.345257-7-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019023113.345257-1-mike.kravetz@oracle.com>
References: <20231019023113.345257-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:303:6a::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 80db1915-49de-4ed0-a873-08dbd04b82e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mt4DXdd1O5jyJOJ6NHLOURIEQbLFAB5IWcJi8J+mthnWBPXuPX78mHGGwLOnXm+K9XR8IglLuMmC46idBYyXhiTIlLp/vkQ1fQABltzkVt71/8anIgu1IGzsA4Bgy6zeX+aTGrRaxJhZBQMITdzVDjdtlX9dDhzNUCtNRn6P73af7sgVQuFdHGNdIvOtNzzyc99c6duqc3lPl91uHh+ef4FFKBhBW0QB4z4N6zugK6WTeraAvvlcD7PIjGYEcm6NrWico57N9SnNfcAizDFAmenTy3azfRncyMpJwACM/7nzVAHQC0N3+NGd54s5+nssTbTf+idPpf9vF1ehCpCO8jS7/6dN55+i0zX9DKN4peRZNJ8noonag8LRZBrcclDXI0iasgsb9qd4jW9j5B7Qwf9EvzMPVHWG5m3GPApalL8osBEtX2H/9twuZLMJogTbNRIh9vZuOpYTwfpUo7Wv3hDGEzz2/N1gxBM6H1EANpO4hp+m7z6qyzpfk1ETdXTGsXJmvGgRvmX2ENQ/BBz81K0jl377VPVKvSrOh+gj/lbFoby1mLEuk8/nu66LuP/n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(478600001)(54906003)(316002)(66946007)(66476007)(6486002)(66556008)(6666004)(1076003)(86362001)(2616005)(26005)(6506007)(36756003)(107886003)(6512007)(8936002)(2906002)(4326008)(8676002)(7416002)(44832011)(41300700001)(83380400001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xPVPUeohT/zyE+rEBxPr7t11x/0f2Djjl1Yydnusi6N6moH6jfcM1H+unKZT?=
 =?us-ascii?Q?AoxLTDtH082NcfkQVIf5huaXajnmPiaevsqpRCeAZT4UycGKAvumwVmiy6PP?=
 =?us-ascii?Q?Ny1hVS/6wvLpyMUwcC03OJOWLR9CfBLU4tlGAVH29ygt8N4U7z/vUSpAVLft?=
 =?us-ascii?Q?KeZ0X4JfltrxMDuKnMOYrVAMEsG5+elYWgUjdKMrt/SlGvUGbwjrOj0jeQTg?=
 =?us-ascii?Q?6u8MMd3emxcD3IoN8ojOUKZkT0iTnu3k6ii5gf0BcaHejTu1YzfT+oMzEntS?=
 =?us-ascii?Q?+t+P+WjV802+XgOtLiIiKVjuTDWWpmVnM/BGA1oS8dFPHRQLlTfMlzGsfIrQ?=
 =?us-ascii?Q?kvoy8XJ+PsXZspFri6Bt0KBEMVRkvmbfRvGaXrZ6rvtXbiG2U9x6T0LoCvxU?=
 =?us-ascii?Q?mJ5L/G8sue/8V7r4UPKisIjwEeIVD1b/QZ0lZmh1OUV+E0xZyyLKj2Qy+c5k?=
 =?us-ascii?Q?dwK5EkzCnPQhlHhELU8yDktE2DCakI2PANQKD/gaIG0ysbuvlAEBKwYQTSCl?=
 =?us-ascii?Q?cN2wYxXU390+JI80U/FLD5dF6vpg7vaE1qOKUUcKl5lXp0hj8icftjs4g8uv?=
 =?us-ascii?Q?4tsFPncQmk1TjOt+sMoFsMola+97YMzCxEAuUNGDxEcYORlwFuzprwyUq1Wa?=
 =?us-ascii?Q?xAUVYAXG1k28rhXQPseAzP1jrgtAFxA11XAl/OIu25jJW/JDRV+X/XNxTa5D?=
 =?us-ascii?Q?vQ8jC2hqxMAegw0hE/oGPxkeyyzlGP4mwTl/j7MGT16JrpEx8EpU3V+RhhqB?=
 =?us-ascii?Q?QT1lNOdmoZiobcbRtx6hcCX6ILWFKQG48rbPJ2atTkTo7wqyDtlI/K5vSNIO?=
 =?us-ascii?Q?Jpz7zD0TJuVFnfWnxxyah//aeLS9N+8nw+Qg+uouhbHwvIbAMlDzPkcVt5yv?=
 =?us-ascii?Q?MXDAtFCXQocxPjIOCmaJBV/5FmGlaNMTH8RD5Ou1AF2BhmfCuwOZ95P18i+q?=
 =?us-ascii?Q?fNmO+jR3DMyWLsWCsTq8/nAzBkxn7WJp0BRU2SF6p41uYcaqUMGj7DNBIMJ3?=
 =?us-ascii?Q?T0uXq/Uxq6b3v/gteyTqj6OrgjXP77zpS/cRki2qYjt6Q/030ilhU54fiOWN?=
 =?us-ascii?Q?x3hAYF9TYvnsEyUHvzzT+aiJ/kKN5g/Tz77h/gfDhRnbdCDy/855ZpM0JbKw?=
 =?us-ascii?Q?RTUZQxcWjNeQD5qSApNkZ6V6o4ZdyWw4ssSD4J+vPjyYefjzrKk3CUWNwzpv?=
 =?us-ascii?Q?MuvAPKkH0kZ+XOhQEYzwKwqj13shWohYT7YuqGW8goQyWM51XJjXODTCgNY1?=
 =?us-ascii?Q?WY4OiRwQt5PkZuEuKwQv1AAhZbUqNSH//u+PLDYzhfmh0r7gg/YS1OSOwW6x?=
 =?us-ascii?Q?wwHhdE4ISsM/Y/plb7Z6ym2dUjie3QXs8oI0E5BSWS2EwkwkQn1xOtcfPogb?=
 =?us-ascii?Q?2Jq2h6FVJ5UQ3K6tAubtzyn01o+kYlm4ac48Vqe8AbRRToA698wZ2ZdqLA8H?=
 =?us-ascii?Q?9r0mgCkWF9qX1z1asV7LJcT18ZfSCJcuZRlbANxnsKoguTWFwn3q2rZPwRWM?=
 =?us-ascii?Q?Xc9RlZ43UjZSm1clYicIZtUAyFwFggT9r1LmUtpdj6hXtP+f/3HXa+1JWj8P?=
 =?us-ascii?Q?HWa3UbzkOgsT5UH67XKyzPT5mwe6ZWIG01LglrMbkXKMDjzeyYKSRVlv/4kf?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?zLJfq2rKPQvzbHitlJhapk+YpZkq8f6Jct+qKJbzzrDfQLQUL2EikCHziBZg?=
 =?us-ascii?Q?ejVv/1kppEJI/a/F57xSlGEh2h28DgSqIrLT/fIS+hoWNoeNephamM57NUAN?=
 =?us-ascii?Q?GZWyP2A4PI/awjg8BceAPKnGPhv64CE7UJDxDkux3EazKoHf82HU2AqTzfEx?=
 =?us-ascii?Q?mbd4LRco4AP0vIa5k5eDxpiUzaQuB3gi6yXcjs2in/wI4AStimf657VhkMDa?=
 =?us-ascii?Q?ayVy0Wzit2KW9adQYNEc6hUKLYI5839xhCa9yEq8qApGImmmfH9IhQ3NHND7?=
 =?us-ascii?Q?dQr4yK+LX8DoLIRTTRGFI5gvlmuq1dTs2s8RVa0zSyoNuQv7UnUMPRO1qDiP?=
 =?us-ascii?Q?AiOwYLgCmlybZOxJEAZE3xgtc9Np60m+qWy7IREvjg+gPpUmsB6NObB9iZNo?=
 =?us-ascii?Q?cU1YZSkQkwqacB2FREKjCsl7aEHp5g+7nq4No86Jltpog8y+Q20G1Fm9pXwu?=
 =?us-ascii?Q?4ggF/WZbChEddKTzAf7fMMpNV76gJb0/EwPJ9xPmiPJNPSvpsLWHvaVnLKK6?=
 =?us-ascii?Q?fY3wyDZYLTLnjyrXwKdRXQTbhsxLcwh7OR7dOT5oRLnRJ7sqbVnqPMzanCYk?=
 =?us-ascii?Q?/HdIdC8rR24dO0WRJT0voqj2U1FJtgtiwOMF2UoOdHsfl9v0rsJeSx/R2MKT?=
 =?us-ascii?Q?kDDu5lVvLiKUnb3ixmAdBRCR3wfM7//jVOIretYtzM7Jgm56iYqETAig44+V?=
 =?us-ascii?Q?Uqr4yZnQIUUt0S00HsL/p/uUj44JlL1C2bcf7ivvle4XKcawwC/i1FY6N5qo?=
 =?us-ascii?Q?TPRnGQBkPsURzHnHHXNck2f3WMyb2wFNjYVn/8zRtnD8+a/WKYLHjaxz1n7T?=
 =?us-ascii?Q?7zidOFWkA5pYvadjtmceZaVGuyRnjRnRng44JyBWhZExg9F1ph4fJYsU7h/e?=
 =?us-ascii?Q?2b+pn9YbCyMg9hI5ub0KcfJ9y/2PoXeAfPS+5yP3B1/VGT5N0d0yga4O/q6u?=
 =?us-ascii?Q?lvSZQkDqg0rojV81HoElZL6Y9DwPXpaXRo/7QBbReepem0Fvkp8sknY9P1I8?=
 =?us-ascii?Q?fANksp/6VdNWgXynI0riyChr9jU7tQjDkW2yknZTHL+REYhBUAhKCYtNvr1J?=
 =?us-ascii?Q?rLMpc6uT+6/NSYvLsgsVR3URRQn6y4lnNJaYIOC76GAv5WIs8sLkMBi/2p5k?=
 =?us-ascii?Q?WUDwoaCx/LazBi/HnNVQlEtgtOFKdI+WHaq7QFpPHJovR0xHkQYJYoQz28MR?=
 =?us-ascii?Q?XF3RkDqg85H/4dEW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80db1915-49de-4ed0-a873-08dbd04b82e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:31:34.1443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhIs/Kb3+DgxgGTivRYasvj4bwFrDrkTI3mOa7JV7MY1lbRfiJOUslW4Tw57YWhQA0D9nx+nK22fOAqbyfaZaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310190019
X-Proofpoint-GUID: krOX7uT60MvIF-FgkVyfhW5EeydFm-ud
X-Proofpoint-ORIG-GUID: krOX7uT60MvIF-FgkVyfhW5EeydFm-ud
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Martins <joao.m.martins@oracle.com>

In an effort to minimize amount of TLB flushes, batch all PMD splits
belonging to a range of pages in order to perform only 1 (global) TLB
flush.

Add a flags field to the walker and pass whether it's a bulk allocation
or just a single page to decide to remap. First value
(VMEMMAP_SPLIT_NO_TLB_FLUSH) designates the request to not do the TLB
flush when we split the PMD.

Rebased and updated by Mike Kravetz

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 92 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4ac521e596db..10739e4285d5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -27,6 +27,8 @@
  * @reuse_addr:		the virtual address of the @reuse_page page.
  * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
  *			or is mapped from.
+ * @flags:		used to modify behavior in vmemmap page table walking
+ *			operations.
  */
 struct vmemmap_remap_walk {
 	void			(*remap_pte)(pte_t *pte, unsigned long addr,
@@ -35,9 +37,13 @@ struct vmemmap_remap_walk {
 	struct page		*reuse_page;
 	unsigned long		reuse_addr;
 	struct list_head	*vmemmap_pages;
+
+/* Skip the TLB flush when we split the PMD */
+#define VMEMMAP_SPLIT_NO_TLB_FLUSH	BIT(0)
+	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 {
 	pmd_t __pmd;
 	int i;
@@ -80,7 +86,8 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		if (flush)
+			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
 	}
@@ -127,11 +134,20 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		int ret;
 
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK);
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
+				!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
 		if (ret)
 			return ret;
 
 		next = pmd_addr_end(addr, end);
+
+		/*
+		 * We are only splitting, not remapping the hugetlb vmemmap
+		 * pages.
+		 */
+		if (!walk->remap_pte)
+			continue;
+
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
 
@@ -198,7 +214,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			return ret;
 	} while (pgd++, addr = next, addr != end);
 
-	flush_tlb_kernel_range(start, end);
+	if (walk->remap_pte)
+		flush_tlb_kernel_range(start, end);
 
 	return 0;
 }
@@ -297,6 +314,36 @@ static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
 	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
 }
 
+/**
+ * vmemmap_remap_split - split the vmemmap virtual address range [@start, @end)
+ *                      backing PMDs of the directmap into PTEs
+ * @start:     start address of the vmemmap virtual address range that we want
+ *             to remap.
+ * @end:       end address of the vmemmap virtual address range that we want to
+ *             remap.
+ * @reuse:     reuse address.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+static int vmemmap_remap_split(unsigned long start, unsigned long end,
+				unsigned long reuse)
+{
+	int ret;
+	struct vmemmap_remap_walk walk = {
+		.remap_pte	= NULL,
+		.flags		= VMEMMAP_SPLIT_NO_TLB_FLUSH,
+	};
+
+	/* See the comment in the vmemmap_remap_free(). */
+	BUG_ON(start - reuse != PAGE_SIZE);
+
+	mmap_read_lock(&init_mm);
+	ret = vmemmap_remap_range(reuse, end, &walk);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
+}
+
 /**
  * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
  *			to the page which @reuse is mapped to, then free vmemmap
@@ -320,6 +367,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_remap_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= vmemmap_pages,
+		.flags		= 0,
 	};
 	int nid = page_to_nid((struct page *)reuse);
 	gfp_t gfp_mask = GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN;
@@ -368,6 +416,7 @@ static int vmemmap_remap_free(unsigned long start, unsigned long end,
 			.remap_pte	= vmemmap_restore_pte,
 			.reuse_addr	= reuse,
 			.vmemmap_pages	= vmemmap_pages,
+			.flags		= 0,
 		};
 
 		vmemmap_remap_range(reuse, end, &walk);
@@ -419,6 +468,7 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 		.remap_pte	= vmemmap_restore_pte,
 		.reuse_addr	= reuse,
 		.vmemmap_pages	= &vmemmap_pages,
+		.flags		= 0,
 	};
 
 	/* See the comment in the vmemmap_remap_free(). */
@@ -628,11 +678,45 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
 	free_vmemmap_page_list(&vmemmap_pages);
 }
 
+static int hugetlb_vmemmap_split(const struct hstate *h, struct page *head)
+{
+	unsigned long vmemmap_start = (unsigned long)head, vmemmap_end;
+	unsigned long vmemmap_reuse;
+
+	if (!vmemmap_should_optimize(h, head))
+		return 0;
+
+	vmemmap_end	= vmemmap_start + hugetlb_vmemmap_size(h);
+	vmemmap_reuse	= vmemmap_start;
+	vmemmap_start	+= HUGETLB_VMEMMAP_RESERVE_SIZE;
+
+	/*
+	 * Split PMDs on the vmemmap virtual address range [@vmemmap_start,
+	 * @vmemmap_end]
+	 */
+	return vmemmap_remap_split(vmemmap_start, vmemmap_end, vmemmap_reuse);
+}
+
 void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
 {
 	struct folio *folio;
 	LIST_HEAD(vmemmap_pages);
 
+	list_for_each_entry(folio, folio_list, lru) {
+		int ret = hugetlb_vmemmap_split(h, &folio->page);
+
+		/*
+		 * Spliting the PMD requires allocating a page, thus lets fail
+		 * early once we encounter the first OOM. No point in retrying
+		 * as it can be dynamically done on remap with the memory
+		 * we get back from the vmemmap deduplication.
+		 */
+		if (ret == -ENOMEM)
+			break;
+	}
+
+	flush_tlb_all();
+
 	list_for_each_entry(folio, folio_list, lru) {
 		int ret = __hugetlb_vmemmap_optimize(h, &folio->page,
 								&vmemmap_pages);
-- 
2.41.0

