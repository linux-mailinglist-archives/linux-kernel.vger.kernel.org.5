Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D197E7BD262
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345024AbjJIDai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 23:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjJIDag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 23:30:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1FB6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 20:30:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399007BL016927;
        Mon, 9 Oct 2023 03:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=M0WNysGQcne8PFpMX0QSsnhH7eLCtvLSJubEjkhtX6Q=;
 b=CO1OqTBEH7jDE0P7bMMDVnTFWmqlCZI7ag0lVAVYpqjCpYqRNKgC4LFPww/Uxudn4DH9
 JJXKOqqkGkmk+GiukpyGggV2UPNfQEkHJsrm6gmxb2WhibL5HfWevmlEudFjEKm46+l8
 OQZuhBSUrNxMMN4tiSdFFHkc2Ayv6rX7SPn61QMPkx+xBqFR58Axfd6+4ytmNCIDrcb1
 3NfwyeWTf2qqSxgHpCqtPnayX59rObm2XhQkD4zQ7m6VTPDgmdt4zXgiHA4J8lTgt1MR
 OPaPnPGo+duGm9Ruzh6UhDMrpbQnKl0v/jTmu87bVq7uMoSyEA4brLK5R0cRAWwINF0n Jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdhtsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 03:29:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399347n0015048;
        Mon, 9 Oct 2023 03:29:31 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws4fpjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 03:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wt0sveM5hOoCv7IfmT9Ti5cb/QrxKO4aEKDANMBOatppRztOal4fu/kh+7xUR315k8sNPjLhfU4TebaCHgt37ipVA79tVRkR1I2Iapg5kBFmGOaWozQuRMHsfSNwgcRJi7XV24mVtHSqlr2Kf42faxis0DPdZQRVOnUDnEj1Fw9JPQvT2pbiaYWDyOz/FLYzwxBIxUYk+oxE2n5Qg9VdSGuZU+pS/A/8oXwocC+8iXKHMhPhsFVR6rbVwjSKmpaQ7po9uCgZw5IIcq8P+kQ+VSFJu4guyxrZk/q2jBbvrphUHF6OtiOmRbK+M9wV8D0ufArGAgjBIP+hJL7Furo6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0WNysGQcne8PFpMX0QSsnhH7eLCtvLSJubEjkhtX6Q=;
 b=MQRUiRTuLGMWHNfPuyWRgmLGQwKYdsg0wqqTq21E9FmMhydI1H8+q4Bgj05gNtridp4tQtZHkP++rh0i1K3U+LPW5GrckZAwviGlkX+as3UmhnedmKEGmstmt6SJ+NArOu6+jStQXSP2Hl1MYPI9V1Qwgy0LKRRdfVZnxofWEhnSnDFEb/ZcvmGltkog8+YNhXyYtViC2M4K7UHPVB+xsSkM7GUCx9aktPr1YHldBw2C1ICSi6TPDLyen5IdxlDIkhDzOxeOnAM43GbPAKskE7kTCJX5f+M5mlWY0CRB96luDDN7chghE12D8BOl6Ge0hE9tGTp1IuTgLiKqWVGP0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0WNysGQcne8PFpMX0QSsnhH7eLCtvLSJubEjkhtX6Q=;
 b=HesdP8Q9HEqyUf5ra4ZQpmoHhFBSnvORtriui/BnAbLEc2hSMTmb4TLz8YqGVi/zXYH+xrkP/2UNHsn14U0lZxt8+U+MF6dDnubn8DwvAxpWs2VKhq++HNQFvVX1UjAo8qV34GNbHgIHwan9eCedNW7xhsDI6CSl+OlyqjuRQeU=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by BN0PR10MB5064.namprd10.prod.outlook.com (2603:10b6:408:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 03:29:29 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::f843:6c6e:77e4:20b0%7]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 03:29:29 +0000
Date:   Sun, 8 Oct 2023 20:29:26 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231009032926.GA3376@monkey>
References: <20230925234837.86786-3-mike.kravetz@oracle.com>
 <ddc10c41-515f-48c9-966d-4ae7756d208c@kernel.org>
 <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006223512.GC3861@monkey>
X-ClientProxiedBy: CH2PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:610:20::33) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4201:EE_|BN0PR10MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb55526-ab9a-459b-088e-08dbc877f21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWaHz+L6lWdOT1XhSX7pTymG5dYocKR3T1V96sIDqeSPxtJpdFMb7RZuGi6keLuAXXdPv+gz0KvvYnMo1UrtDXJi9LF6VACXKjJZUyX+g04pqnBiWRws80tJ+62NVew9sdgnmucSZZI8yjvlmJS2y8qNtRGSEtoPWLAl3VygDPYVUVrhuZjNQVqyztnZSje/KdLpbJnWr+mRT1tPKD7QQfNkkOz3yaPgcQxVkKnMxyxU6xAwFYLeAVZnG0cI5TBLqAEDoR3Zj7oUyDjVu3OQ7Dvbahbi5VsGuGjEAtq4H3feQtzi1reqw4LIwoNIQdBRZLxOawdU/a/snuAvixT70NC1/fUaWS2qqYhtq4iqUTw55FklpRNOK+OPZvlxscjEMyB92Xo4jVIusU053gN27KmOKgRi6/FzetOlj/xypdLvsBiAmdqTw8EImaWpcb88PnO35FyyHy6j5Rp4lxLJ/Nr3RkYmE7H6XIIWx2nQtuT+DJgT/GsXwcUOH3YYJM2DYL2I4FjCmlzyfu6/Oi5hABdrLfGbqcN4XKPYSRrmLho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(83380400001)(1076003)(26005)(66946007)(66476007)(66556008)(54906003)(110136005)(316002)(7416002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(6506007)(53546011)(6666004)(6512007)(9686003)(2906002)(966005)(6486002)(478600001)(33656002)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?98Hhps9Znb1njL9DnKeKvlVMuvJQPUdLf5CxJDyZwsWWEL2CqEi+gQKO34tA?=
 =?us-ascii?Q?NRmD6jxIvf9DoGEEGdlomfv2MWtb8hnMA2ZTQr+sqoRl+isrpo3+6kJbF8EE?=
 =?us-ascii?Q?4tf2+RjBJo4/MMRdgE7INSAYLeuk0Y8VmJT2o87c/z1RoS22OEVTVUD2qZxF?=
 =?us-ascii?Q?/xKDPozg9iazLIAp8rBH14+9hgAkMioiIw1HVAZzCFB8rCv1o5gAVM2DluaF?=
 =?us-ascii?Q?+euxh4+xA4HU5mNs2ZIrkHFapn/CjvCWzhvvagkKUYDWYKWAcBUlN1m3wKV/?=
 =?us-ascii?Q?DjPzPlxJQ2D9gWwwM6fV0V5TKz/Q2ruGkVEImNuD40ELy5b7zZA77MeA1g+P?=
 =?us-ascii?Q?j/+gQpWcm941TfefbfZG72OvuwHLflylzfCpGI/Eh2CeVTxlR+pMwVGtDyPK?=
 =?us-ascii?Q?aVdAwp7Wc/Xzs8jlniDHuTa/HLqPIs4qvKaYcVOfb+do0OibUKHQhOM9gmA8?=
 =?us-ascii?Q?mEITPHYYQoz9Sw7SFSXhmnj5RehCOZtRmGDSIgRFzspyJRxWdSqlySOTSvFg?=
 =?us-ascii?Q?9f5LlCWxoe3Fcwc6f8ARx0cgbC+nMKaK61rsKGy5Xp8qYpu6Oi3/36iQPRSI?=
 =?us-ascii?Q?WnF5x1lvsPNmIm2ZsoZm+rDcfNod0Q5T4/tGRmBUo6RuO/RnnAbMK7XgmSNo?=
 =?us-ascii?Q?4w9LoVue9AdSXDhOgBAXUB7cKsk0iYRZIpX1LrkXUTXcWups91qjgE4FcXlH?=
 =?us-ascii?Q?vs7c3gr2e1IYcSQGP4kY8vbSQSX29kW1b//pn4HM5yf13uyM/Zy6LeqZ2V87?=
 =?us-ascii?Q?jRiltWtxKmJFEuqLmgDId8q4qcY7mwJGwFYmYrk8K5g2RGuDON1+AtjIGvp/?=
 =?us-ascii?Q?PKFitZDwE95gS9rnZIJw3VpPfaAVPiwCQo7U12sj63juiB+lvjzI4h/f17tv?=
 =?us-ascii?Q?3QQM+xe+vZUFtT0+phmN9PNiho09GyqpSrBZGZ5rDssa0XS4oYRPefHiwul3?=
 =?us-ascii?Q?Af1RbUKTglqN/h4cC7TZSQ1aZpt9dVjnEqIP6a1J0g0o9Wo/24DriwQ2Shrg?=
 =?us-ascii?Q?0PvDg7uMlZ0mGo01WjWHV0v9gcCf72k3OXdM/LeUL3FWUGkpszZGe456whxh?=
 =?us-ascii?Q?t+5XV8a7m1Wvyijn3sD3fu6R2s0bXtyM1lr9etjeR/nNoReKsw3dqjLC18qy?=
 =?us-ascii?Q?ADtZGstHHMW8WxsJDVqbVqacN+n5erAAngu8pxJ0DKwfAyyGSnXyedDLmPZe?=
 =?us-ascii?Q?KREhgid77aAmMaLgAzuZAMk3Q3duJQu5QZZrI5zM5zlk30roPwOXu1OVzMrA?=
 =?us-ascii?Q?rW/qdcNPp15iMCo1sWIIhwCFqBbJfHNPcZP91E2mvcgDceZLISDU8J0/JoJR?=
 =?us-ascii?Q?KVVdYPItpDV4dOJy//ijsJjTj78L1keYrAOVpOJd9mxiiEonirLL4PPw/aai?=
 =?us-ascii?Q?wQroF065vZoVXrPrP4oU953Fe5DJrgXO7OO3TeQg7akkoCpWrrLLc4FVqsI7?=
 =?us-ascii?Q?Kx3pZ9MqITRcM4HFD9dHxYYXLbsdqweHUlEsDBbjx923PYBf55hyc/ZsoRDK?=
 =?us-ascii?Q?GnAmxPIaFDFsnR9nuJrlY2upf81bUT1TvH9bBcUvMQjR0h2gax3uU2UAcBtZ?=
 =?us-ascii?Q?4wKt0WNfo+e024ou5AP7FaFZdvOeiYvdIcdAdl67VmDLhC/ncdxIRCV9b99G?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZmKzUV/WYP1esIJc+ETKcxgAlq+ySLy5iE4FXT8SajEZVDk1L0juexnly7la?=
 =?us-ascii?Q?kgr5FgGkM8EjaJOijcS9vWAqZW4XzVNX6CS56NT/RjPfQzHmCiXBzPPdrPn0?=
 =?us-ascii?Q?zncmmG0OixX/tNBfEvLugWSVH/sjKORl/PSI3l3mjPjgPVrgmjqxB6aKZjEv?=
 =?us-ascii?Q?v8f8gZyiAdGpiJ6IgdryZzXj+tu2BfL0P30exogbKqSbiwWsdbZ3Qjx47ErU?=
 =?us-ascii?Q?VQD1fMqpN23VUL9p9l4tpQsVlo6vNHBLhqnNkGDsHiFSuTibtnzTJYWKUCWL?=
 =?us-ascii?Q?Hr4bY4dzim2qrPSsRTU1blNC+kbVje+mgPULYFDp9nmMvBwumxPsaE6GVK/X?=
 =?us-ascii?Q?Ep5tKvpeztxfWG1WB2qn1Het8x0JSejM4leqe6aNiaJy+YK3525Ca12nXFWD?=
 =?us-ascii?Q?eToPU0ExvnsqqVn/e7gPmv4jch5eyx5vLsH+sKwDVpfxD0yFMlx8DvS8xbMz?=
 =?us-ascii?Q?qwTBzYNb6VdEwP+Jyp0n0tUsTZrFm394wTYJ+XRODctBqrwnduJfUwOFx3ne?=
 =?us-ascii?Q?gBq9xX3YigG5Sn8xRdCLDc7B6KbW2E3pZ66/fmKXTfch3aKDuK98r746+q87?=
 =?us-ascii?Q?62fgcGTO3hR91xgd9AAJbv0IeQfpYG6kkPs2m8PuO1iQMzbwm/5SE/+qJgjA?=
 =?us-ascii?Q?gxcQkV84zq+xgwpEGyTVbIvAxG5flSZC04iNine4MHrGqK6nbz+/cvbkUx8L?=
 =?us-ascii?Q?sBHikm6MUebBhh+9jiIFAn08z3A6BZ9dzRGq0hRs6urRfs35wOi8ZiNL/RgM?=
 =?us-ascii?Q?4HjxIq5F0UpMcI6k25Mkml48LZVQtu5jopF6ohftcqRUTp+8dlV8CkHqDx2U?=
 =?us-ascii?Q?tagSwfikQGYvWUDE/Ogd6UrBDVjgiYkP9CELBxD1a9a7/fL4pPE7zydZr7Wq?=
 =?us-ascii?Q?qDtnF/uLcDmhf9/Bur4L2ZjGxD9hcDpxUDER+8dfJkgCDDZTEI9IApHbKYyP?=
 =?us-ascii?Q?T0O2mximegdrn/S0M0PEMbJMrBkFI3EfcKTdjjGYZP6GaitfsOXsXyEI6j6k?=
 =?us-ascii?Q?esADQ7j7aE5JK5N1LxTFlzPt95mK2TI9LmJ0nb4j0fie0gVXoCllx/pAODwK?=
 =?us-ascii?Q?tqDHfGSStD3lOHdEL2TajaYFKRBUXYQP4+IG0ZSrsgnDlvjg/Lws76n33tuh?=
 =?us-ascii?Q?/XqtmK1bLYOnEUsvue5pBT2Iy4Jwo3x/6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb55526-ab9a-459b-088e-08dbc877f21b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 03:29:29.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9tkGrJaABoLCUYPS0WQQ36SJEN8IOfTAq5RJ+qhWbToPX5IoFdJutRieZpC2fCv5ZTOe+DbHBNZalIWOtmsmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5064
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_01,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090030
X-Proofpoint-ORIG-GUID: aId96vqKlxbVcY6K-RZV7Y4rOibodSH2
X-Proofpoint-GUID: aId96vqKlxbVcY6K-RZV7Y4rOibodSH2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/23 15:35, Mike Kravetz wrote:
> On 10/06/23 23:39, Konrad Dybcio wrote:
> > On 6.10.2023 05:08, Mike Kravetz wrote:
> > > On 10/02/23 11:57, Konrad Dybcio wrote:
> > >>
> > >>
> > >> On 9/29/23 22:57, Mike Kravetz wrote:
> > >>> On 09/27/23 13:26, Konrad Dybcio wrote:
> > >>>>
> > >>>>
> > >>>> On 26.09.2023 01:48, Mike Kravetz wrote:
> > >>>>> Allocation of a hugetlb page for the hugetlb pool is done by the routine
> > >>>>> alloc_pool_huge_page.  This routine will allocate contiguous pages from
> > >>>>> a low level allocator, prep the pages for usage as a hugetlb page and
> > >>>>> then add the resulting hugetlb page to the pool.
> > >>>>>
> > >>>>> In the 'prep' stage, optional vmemmap optimization is done.  For
> > >>>>> performance reasons we want to perform vmemmap optimization on multiple
> > >>>>> hugetlb pages at once.  To do this, restructure the hugetlb pool
> > >>>>> allocation code such that vmemmap optimization can be isolated and later
> > >>>>> batched.
> > >>>>>
> > >>>>> The code to allocate hugetlb pages from bootmem was also modified to
> > >>>>> allow batching.
> > >>>>>
> > >>>>> No functional changes, only code restructure.
> > >>>>>
> > >>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > >>>>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> > >>>>> ---
> > >>>> Hi, looks like this patch prevents today's next from booting
> > >>>> on at least one Qualcomm ARM64 platform. Reverting it makes
> > >>>> the device boot again.
> > >>>
> > >>> Can you share the config used and any other specific information such as
> > >>> kernel command line.
> > >> Later this week.
> > > 
> > > As mentioned, I have been unable to reproduce on arm64 platforms I can
> > > access.  I have tried various config and boot options.  While doing so,
> > > I came across one issue impacting kernels compiled without
> > > CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP defined.  This is not something
> > > that would prevent booting.
> > > 
> > > I will send out an updated version series in the hope that any other
> > > issues may be discovered.
> > I'm pushing the "later this week" by answering near end of calendar
> > day, Friday, but it seems like this patch in v7 still prevents the
> > device from booting..
> > 
> > You can find my defconfig at the link below.
> > 
> > https://gist.github.com/konradybcio/d865f8dc9b12a98ba3875ec5a9aac42e
> > 
> 
> Thanks!
> 
> I assume there is no further information such as any console output?
> Did any of you other arm64 platforms have this issue?
> 
> Just trying to get as much information as possible to get to root cause.

I have not had success isolating the issue with your config file.

Since the only code changes in this patch deal with allocating hugetlb
pages, I assume this is what you are doing?  Can you let me know how you
are performing the allocations?  I assume it is on the kernel command
line as these would be processed earliest in boot.

If you are not allocating hugetlb pages, then I need to think of what
else may be happening.

Anshuman, any chance you (or someone else with access to arm64 platforms)
could throw this on any platforms you have access to for a quick test?
-- 
Mike Kravetz
