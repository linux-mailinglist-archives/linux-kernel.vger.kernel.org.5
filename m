Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0737ADDAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjIYRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbjIYRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:13:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D04A11F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:13:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PGxXOw009613;
        Mon, 25 Sep 2023 17:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=eQoSFShn7CC6ZqNMWrMDKRR8Mdsqt29BdiPd9ySHA1s=;
 b=qNTJ5Ivkv/BEX1Tsu5Jbp6JAWnNlQpu2xYBzf65kZ2YKzx92e7OOm29dBqecQZ4I560Q
 FT4Z8G5mpqWdfrgucM8AAibyXQ5UfT1uEW5j5DcGLL1mQtZoCUwZTTjJcGpyvDjAoXjI
 7Osk7r9gobThjhTK5gC1n2kywLF6QwjY1SPD3FCJ19UpCdy9X89D1YTv2y/3+buws3E+
 hF6fqNU79UxCxq8jF6/bn1/VvvEOBPIcq2ZDQuOynW9l3Uyz7FdJ8jYEVUFaQ1vTGMga
 RkAd1GHeHv5JHbaOVQkoVETQh/7rfDT7dwoyNBZ3I0sXqcF7NZK7oi6ojKdLnJzNkXmF 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3m8kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 17:12:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PH2l6a039522;
        Mon, 25 Sep 2023 17:12:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfavv11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 17:12:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+AXJ3zIX4K3GBk2Sp1Ipq/QyGFrI1iW28Li9ER0kX1dt3fiAvfvUaKBPUCA6+1oJDJYAxrGC/i9a/1R8euVY/AhogVerBe+QM1aQ25NdKGg9DvEEMkw0dyePtmAy6xrUxfnC40dfq5ty/g8mlvtggZ6eqcFjgBPM6RnV9+Cn+mx5wxlommu9gWW9U8/G4ny62/WZzxXWZMhQHxnesFZDEzTKfUTX1qxERWRYGZZ+joMcI3IN3vtI0wTUdX21v8F91RdrwB/D5/ZCtKbW65gQBgYHVDDuPmiZWf8SBNYPLx0ClxkOjEmmA2BchKGAg0/jgm1CV3OdPVYhdDl3yas3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQoSFShn7CC6ZqNMWrMDKRR8Mdsqt29BdiPd9ySHA1s=;
 b=enASGOS5BBXDMtTiushMCilQ8MYtKGCxHONB1pq996xI5T9HltuSBB2gkZICwxhYSwRg2Itw4NRDC8bC+96fJPMDS3f5SBQVPAENaAL4bBzzPDSd7oVK4oyMBMGrcuFMF5MAcQhpYi74S0And2V2k48aWQ3T5aYLa2VXg6SAT/1ZXDvh8gBHaI00+fsO98eJL3ZngXekYPqOyESaJ4j1xQ+Dp72C9CpQVaQ+06mBbVOq5qJgY0RF+iFDWmRofxPPlBLyhEBlrhCeLvwJT7mQiakcK06qPwaMUJqksBpwQVWcpIchC2u9D60MYz5PnVKS68sQ36SN7wRJ0V4gdRXUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQoSFShn7CC6ZqNMWrMDKRR8Mdsqt29BdiPd9ySHA1s=;
 b=yhg1h1Q8AbHoW9k25Rh8hn0iU0RM4E+JX5VpB6lkWVJ8EwGDSBymo1Ln+8Jfya4iNTM9siKwDMXWaH+lf7WFNvmXjBNLcALKHGbzazT+osGwj5b2JwzW70K3FFdfaBM0kKL7m2ieMBpKsdzR2NFSJapMcr/aiSUuVMy/ZLPcCF8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 17:12:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 17:12:45 +0000
Date:   Mon, 25 Sep 2023 10:12:42 -0700
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
Subject: Re: [PATCH v5 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230925171242.GA11309@monkey>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
 <20230925003953.142620-5-mike.kravetz@oracle.com>
 <b271ec48-cc64-6cf7-d8af-395d0f7fdd1d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b271ec48-cc64-6cf7-d8af-395d0f7fdd1d@linux.dev>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e46ff3-3b0c-41ad-535c-08dbbdeaa298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6iHzJ1ZYY1ch9/8MDxA2WXTCHEPxoDise/qz0cbdBuSaBneQaSqMuvR0Qnvq5qwx9nduPed0CN01OkEHpLAYyR8obEMTw3RnMNnsgcaFDMujJkLSg8n3n2hJ0Znc+ZZuDwzpBz8h4tCQHiyKOpLKXcQe6IIFwxORycfbsFNEHZlflkEyBrrUM09nNGWM+IK01zzRO0k8/JGsd+ELjrbk+vAEP+uEXQ6HkcYHcGPQ0fF65AguLPkRpb3KSyoStvudB3oH8cvf9s3uxWs+Q36wmwDNVWcaQjSDcGpm3S5xgKpPewxoqt5tZSxXmf8WckVCcw2m/wZA0loZtQnEWLkprMQpfUI+OsBkmhiVw4s7xRI0zBRnfp26i4I1CyUrCg/sUgZyHJZEpELV4gBKsZ/Bx82EOZuLLdWzCLorXVglftUDeVkud6mvskzzHNtTbYiwADQwauUnI6tBoBYIPpBZ2e4px5+bWOylxBL1/5Jsi+oyaslZSKCLH4e+wqeiFHc18BassQXlsDtUej/sJ4AhvyBPV74u/3ZiYFgpRLpwXdryUgBdcQyZ8Chp3KzMkdY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(66556008)(33716001)(83380400001)(6506007)(9686003)(66946007)(6512007)(53546011)(2906002)(5660300002)(44832011)(4326008)(7416002)(316002)(8676002)(54906003)(41300700001)(33656002)(6916009)(38100700002)(478600001)(26005)(86362001)(6666004)(8936002)(66476007)(6486002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7jtXBT/PnMbCDlUqzLVOLeFMQIO/FTeEx/HLj1mxjQNNk+o5ytBNXdHM0Je?=
 =?us-ascii?Q?yJoR51zs7BGUhYJMc5Ndo/uWYO4rwdmbG1/52y6NWiyMADAu9+C78uIXzcpq?=
 =?us-ascii?Q?GSXb6lvGt6uhN+1EaMm9wONJ6A1YuhbxzuMsiPLfhauy3jPOu6W3xlQb7Ume?=
 =?us-ascii?Q?VxVEuV5vpErOx4e9zfhJRgYVND48BgMtikhrLksdSIwL5/LlMrpEB5f4x3LV?=
 =?us-ascii?Q?VkwTWj30eezSbA8DXy6JN/clb07qZtrINVqqwl8PfT3EKzWXTaMXRjD05Q+C?=
 =?us-ascii?Q?2gSWAruG7R626H80VwnbGuScdP4JzI3yef2Ewd7lAmjglzOQtQFQ2zR2T8SD?=
 =?us-ascii?Q?N8oVBSPGVA979CgpJQAFqN1S7XdjZdZTp4JzBMQ147T/dW5u/kZzeLeIVkHQ?=
 =?us-ascii?Q?RhEcCP5QHsw4Lw2PsnXtZ0Ia2YmWix7fXit5fWc6/oPfD7rOfRJZFXqGapLb?=
 =?us-ascii?Q?Gb4iBUH/CKamFahfy1Ehrg7G/jPsecb/kYsGwC9VPhVRMZMR4u4MPs+ygSKM?=
 =?us-ascii?Q?8ZH8lJbdHZ3BcbehsadJ5LftYhCOHdt6+QgcYCrqOkiG/S4sQZSPE5zEGBKU?=
 =?us-ascii?Q?wPMWNEQG6Ma+LMhSyISw2cfSreHd0ywvO9y9iRjusa5It7et9jn1NsWEWip2?=
 =?us-ascii?Q?fq+skL+iL6TBrm1TuAjV+aImohTx7VOUcGNMAG/mjwxVB+oDFiYXFeVT5O4z?=
 =?us-ascii?Q?9TFRmezGEXitJZR6BfZ1krhZHpmn171GiDUPJSVGTtxTNeA6mc44tQS+GxXo?=
 =?us-ascii?Q?hA7hb6kmOL0qfj8u8bOWJDd3it5HGcroPxfF9I8uFipon3DVpqpGHv/oQGeW?=
 =?us-ascii?Q?3lZHnFOJojDWjCqQ3ZE/PSc1OPXyRWsRQuotRi7YjpaRsUCf35prq6ulx06N?=
 =?us-ascii?Q?8gnXHqlkKgwY0K1Lrplc8yBcp/K+HBcuGV/xBD66Q3sECQ8wM/xY9ZjM4yq1?=
 =?us-ascii?Q?avz7FajcE0zWBbUvuauDrT8eibWXLX14RH2IvtuhlieKRdZfUn4mwdhdYcdm?=
 =?us-ascii?Q?+8A3q7mToQl+VJXLNJ2Bbl5PlcWft4V3mWKf4YdfN95/BLtbt3QzIzWeQZ0I?=
 =?us-ascii?Q?DVVrch8OIovpqDP0Hj79/yqNV8elKPegWQ1KKKGOiyweOGJyc4amiepbEAK8?=
 =?us-ascii?Q?Oew7OnFywqgcv5BqN1r2t64isl6qL7xY+3FOpvhkYypRr/ZxRtdbzo/zaBsZ?=
 =?us-ascii?Q?ce2pkdOn5LU/yq01UOH6gGlE3+7Pu0+aWKaD9L0P+cac3+GllycR0RdNCX26?=
 =?us-ascii?Q?lPF+Yv9WiCukbDAYr9ZriYLYUxaPEJHImwqLd68ffixyusZqS/jeJuLUpbv0?=
 =?us-ascii?Q?mX9lqjxLdWgr7P+AgQzc8R1149l13O1aHdyNX5XZ8lQsJKgYeyqPCHVSIG6F?=
 =?us-ascii?Q?ytRRtxkChB+gkxnLJmgjGWyLdOAdE1mGyhf9Nvh/CU0WRBrWRsmnC1viRcFv?=
 =?us-ascii?Q?ZvzsP0phN7qbiAC4AAn4I+kxsX9q5oFhR2iUtU8o85Df2qV8KtNFjV6myOop?=
 =?us-ascii?Q?5NM1mnx23ogha8NIAOUPEq6fRE5Kb00G33zm/NHZu+fGJctnswDt03pRkIQI?=
 =?us-ascii?Q?xzgzjEoZnpG2bXm5OZqQpVCczzPuFuCYqpvTV/Bs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BtKjRTTN2wc32Z4/fAHoA+Py9x5wXGxBMVmfx9uoa9ewcBG49WqiC0SVAMuH?=
 =?us-ascii?Q?c/QW9050EfQVeAQ+UECxM5HAMfFBRho6gtGaf32yKm0+D7fRBNWzrIpvlcc4?=
 =?us-ascii?Q?xuXiMUj9EVaV3YV+wYirG5LJmRkihBZUD93o8HHYUUMzQJU6I67jHlOcDXd4?=
 =?us-ascii?Q?Q7S3rOAkXSJdOI75O7uDyjb7pfp3xchXvMWhSlOr3Z70n/+X+LHRsXNq5+yw?=
 =?us-ascii?Q?7J+TVPDYuD1h/5jdP+LY3FqJ6Z11bsODq03V3+Z3aIJUIpPblr9pfwmEo5Ks?=
 =?us-ascii?Q?YaIaXWX3dkzSAZBfoL3laALuocQplmC8Fd5z2qtKKlRWAFh91vvcc3Yx0Jep?=
 =?us-ascii?Q?2mGVIflbRlk/YJR6vM4MO3I69TImcvbFsPH1ra/44WuK+d4INNGHOUK/+F1+?=
 =?us-ascii?Q?8DQKG/2+bEtOnOv3TNkUVjmT88W9pD2k/0mH3aFMAmVk5MKK5VIozPPNxm73?=
 =?us-ascii?Q?2sNNCVPjgRx/btnJOsW/QW+eyjeEtVZO30J7BJ1QNv9kqzDeK0EN9FQwQ+1F?=
 =?us-ascii?Q?lGGhz0TUoeUrGOklkoSS576kG9k8gZ30WCLQY8G4zmXxYYqXyqC+gx1ZhLvI?=
 =?us-ascii?Q?yKRyHZcp8RJpHokN7WcI+pWD3DBBt7aC+P/eVxZk8ryDeO5aHfgWGSrO0vOy?=
 =?us-ascii?Q?dR7+KkSvoEJ4YV4v4v+QEQ3XjcYxLbcmlP+ubtP0IeYY4f3i1VCsot2RGjVt?=
 =?us-ascii?Q?08dqAjOhl6XIBq/fVm0NjZfcz46pB+14oQ5pQZvSL48ZHowAym+2wXUjA5Ls?=
 =?us-ascii?Q?PjMNsJI+QXZoH70NXeUM7lQhQreUm9FJ6T9ad5DMqti+TGumMWmTB2s6G1f/?=
 =?us-ascii?Q?TfWAihMMdwukG8+2sw2PZsCtrRAqSunBH9tMuskMyk40+GMIUOP61qF2aYl1?=
 =?us-ascii?Q?nUy3A5W+4WTh2guWdyG1+SZ00HPbGwi9YhdJilWyoVF0aTXvXozwx9dgoDCv?=
 =?us-ascii?Q?IhrKuu6grQDOmIe+0J/+8Jwpe9sElhaNQtm14zNMlOfhcQJ9fDGe6TGtezPw?=
 =?us-ascii?Q?WLlq14JEzk3RCw5MrLD7BDqnmAv81ZTx2aGh7UEZ0PBR69JBphAYHYiBUObg?=
 =?us-ascii?Q?AEq+wJEZ+xk9LDRA8bm9PNN5ZQ6ekbbKpiaVf3A/19gZlUt3HezIga8AehT1?=
 =?us-ascii?Q?7iiTBuj9Y4RM?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e46ff3-3b0c-41ad-535c-08dbbdeaa298
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 17:12:45.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOmTCOfoGT59aAv7ZahpbAj49KZeB7MdapDgIt+GQKsXX7UoA2mdO798UuzBXXwa4cxRvhfaJyoopSCYS6swSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250134
X-Proofpoint-ORIG-GUID: 1fRdnpnytgx0eYnUS6COT2KAm47_2EpX
X-Proofpoint-GUID: 1fRdnpnytgx0eYnUS6COT2KAm47_2EpX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 21:54, Muchun Song wrote:
> 
> 
> On 2023/9/25 08:39, Mike Kravetz wrote:
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
> > Special care must be taken when encountering an error from
> > hugetlb_vmemmap_restore_folios.  We want to continue making as much
> > forward progress as possible.  A new routine bulk_vmemmap_restore_error
> > handles this specific situation.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >   mm/hugetlb.c         | 98 +++++++++++++++++++++++++++++++-------------
> >   mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
> >   mm/hugetlb_vmemmap.h | 10 +++++
> >   3 files changed, 118 insertions(+), 28 deletions(-)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index da0ebd370b5f..53df35fbc3f2 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1834,50 +1834,92 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> >   		schedule_work(&free_hpage_work);
> >   }
> > -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> > +static void bulk_vmemmap_restore_error(struct hstate *h,
> > +					struct list_head *folio_list,
> > +					struct list_head *non_hvo_folios)
> >   {
> >   	struct folio *folio, *t_folio;
> > -	bool clear_dtor = false;
> > -	/*
> > -	 * First allocate required vmemmmap (if necessary) for all folios on
> > -	 * list.  If vmemmap can not be allocated, we can not free folio to
> > -	 * lower level allocator, so add back as hugetlb surplus page.
> > -	 * add_hugetlb_folio() removes the page from THIS list.
> > -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> > -	 * ANY page on the list.
> > -	 */
> > -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> > -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> > +	if (!list_empty(non_hvo_folios)) {
> > +		/*
> > +		 * Free any restored hugetlb pages so that restore of the
> > +		 * entire list can be retried.
> > +		 * The idea is that in the common case of ENOMEM errors freeing
> > +		 * hugetlb pages with vmemmap we will free up memory so that we
> > +		 * can allocate vmemmap for more hugetlb pages.
> > +		 */
> > +		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
> > +			list_del(&folio->lru);
> > +			spin_lock_irq(&hugetlb_lock);
> > +			__clear_hugetlb_destructor(h, folio);
> > +			spin_unlock_irq(&hugetlb_lock);
> > +			update_and_free_hugetlb_folio(h, folio, false);
> > +			cond_resched();
> > +		}
> > +	} else {
> > +		/*
> > +		 * In the case where there are no folios which can be
> > +		 * immediately freed, we loop through the list trying to restore
> > +		 * vmemmap individually in the hope that someone elsewhere may
> > +		 * have done something to cause success (such as freeing some
> > +		 * memory).  If unable to restore a hugetlb page, the hugetlb
> > +		 * page is made a surplus page and removed from the list.
> > +		 * If are able to restore vmemmap and free one hugetlb page, we
> > +		 * quit processing the list to retry the bulk operation.
> > +		 */
> > +		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
> >   			if (hugetlb_vmemmap_restore(h, &folio->page)) {
> 
> IIUC, the folio should be deleted from the folio list since this
> huge page will be added to the free list (the list is corrupted),
> right?

Good catch!  Yes, we should remove from the list here.

I did exercise this specific code path and there was no list corruption.  In
any case, I will add the list_del().

Thank you!
-- 
Mike Kravetz
