Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053CA78B9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjH1VFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjH1VE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:04:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E2CD2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:04:54 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxP4s026667;
        Mon, 28 Aug 2023 21:04:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=doo/l3M4oYF29VNdEMmo/4f9G6MaZNsA/sqdKenhz1c=;
 b=DEEV4WLc9oKzj36klxuvPqKJh/W0ZnZmWaWLAQzT0S0KIgCTaoYgB7yYUsA8EOHokAHK
 pjWqlVtotLnCe1g/v3lWKzSY3VtEtsj6YzVqYhM0LgtoUMgjMnGNJ1Wrs9In9YjNCo1z
 NqUN1+fvKAiOcxeacbWR9VErM02Rn+i6cRaMR5crk/DIwGjTT5CV8bfPl+Yn6QpvLbjc
 v5SMF/KjLQyAklNnZhlyU1V3Sg79A6ClGNmzGAVzPq3tVXJ5cFBhTpaHLRToZlO6ndxy
 2Zqk78b285aIBP8TiB8ZX//5SPtjj+JtVx3SXrQR4WfH0RWitQsOUaxnbCv3a7UNq/zq sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k63n0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 21:04:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SK7Whn023135;
        Mon, 28 Aug 2023 21:04:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hm7pf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 21:04:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGPje1vLqOk6RXK38yNVStfKuSEE/31uZwxANSdeYA2QtCQo55fy68LqUjsS7/KMBMQ93noQu965a5aTg/mrg016K2ZpRJPADpWkCLr04y+QZJj14lVXbFuQ7Y9A4/To5xkmVQuyEab+/d7cCbC6fgRLgTq7Uscgf+Ra1ZkG/KSiJAuYoG+SDFcX9zcoi5pmRoMxgnsSBbd36EKEv0sFJaJBVouVuZFOg7X5QIBXkxRxD34FskdjEN61hCXusGilVvZb2iq4T+nYphBMv75TEFApv17YaN9/fYUBKQg40xBPQK2lnBmVAutrF4dq7yLGgSVkKd0hj689mDvhkIiFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doo/l3M4oYF29VNdEMmo/4f9G6MaZNsA/sqdKenhz1c=;
 b=gOwDCyYlRShV2jC6XW/dmAdFefjhlNA3vKyE16SGweLvRqhsBqM1z08kdt2yYFwglHza9cjunogAtYzEHw9salx5yS6/5SMwxipMr19DBE1wu6hxkP0AjErlwBSDb8VuN/gIk9rlinQpayjLdpRACTo69BnHJXjEUOM+ObdXVhfbz8uEX9KK8eBprbpRcNhgm8mG3C3p7QThZD2jRHn7X+OX++qbBz1gNmXiDeVcwqevvJW51NwwnPhatiY274WTNaKgKGjicSZFdBTstQVqiqF3u+nGK488bsoVdFv0yBNneKPN2RXKiVaIs//1YP7Vk5SH24B8ULI0xznmlikHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doo/l3M4oYF29VNdEMmo/4f9G6MaZNsA/sqdKenhz1c=;
 b=HPKDC3OAUP19eAHoHNLUgWzIQA5q2iRDGYgE/gMTLbPdiWxtEU85ifDNAVmMa6fNzUOO1X2+hlvdfsavLvnW2ZYilCcIyhXfpf4rCOdV7matfkDP2kSzsw9dHdktTrDuC7nbzoRBbGLtRqTkKmtxWvr/j3AvdCHAP4tCtoyN7ls=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 21:04:21 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 21:04:21 +0000
Date:   Mon, 28 Aug 2023 14:04:18 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v3 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230828210418.GD3290@monkey>
References: <20230825111836.1715308-1-usama.arif@bytedance.com>
 <20230825111836.1715308-5-usama.arif@bytedance.com>
 <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486CFF93-3BB1-44CD-B0A0-A47F560F2CAE@linux.dev>
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: e29039e9-8335-4da5-6c3f-08dba80a5992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1cjTV+hxpE6XPt5Rmw9ONNqc5CXQ/wEQoVrt0jbBPBI2AD7lbFd/PxeZFQJ4Vfo6jUj8pIRzbkWOBzcXJNdpa9G3A2jtz71qsf+j0FUwW24DuqTSpcYfcsMduB3emPSiaQ8PVX04spNLiIBiKBaBCBg+70sQl4v13BuigkXamLczztKXuHtGokcXhA04dGZSV6W+z+qrxjqJVyYo5X4wrHW2neidJhTZuC8iaEP5Wm7AouENKoswyVlpBOPvAyy5abD6TRQKmPYTJjE86LlzuvzcIah9QXlIbxkntbxWAEs3NPBMr5jghn2c+S5QrLDzvf8X9OpftONLL6ZjtUsKsghNq0X1kviR6buYsNLZnbslzx3deu/vP7FJeN3XoBIPlVGtJJ7U6o96PEHuaYwCRVs9GazFHODDzaikDmZpYE/WHSW1N0nlfX2zUnu+Ja2iwVp7KoyqEYH3c6t9ykI2u0K5s2Meo4iKTMc0zM0fOqU54XsrImTuEdqIX+3vkhOF9J4TIoTv9V8IyQEYcK9JXwEythTkEwKNGpPiVHzIEdvr/Sb2qUSdJLYofHTr7CtM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(376002)(136003)(346002)(186009)(1800799009)(451199024)(6512007)(6666004)(9686003)(6486002)(6506007)(53546011)(83380400001)(478600001)(1076003)(26005)(2906002)(33716001)(316002)(6916009)(66476007)(66556008)(66946007)(54906003)(41300700001)(44832011)(5660300002)(4326008)(8676002)(8936002)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tEy1IcSp+8Q/8KtrhsuhS3fUHQ+wgzU3aajOQ4oqSF2KNOx/loe+PJgAyZPt?=
 =?us-ascii?Q?y1C8Y3CAzIpeT2eVYoBdlLPW84vzXbW1+wfSIdxInTQf7QwYGzUUy1PjvDao?=
 =?us-ascii?Q?d9k/1y9InOSXg7sSaVZZ6beYRcmxGOwFw1a0iWi/mboBFXWoKcvLgdBoJ8AW?=
 =?us-ascii?Q?Et5AKk4mjq3KGwQ1Vi7lWdVYZUNB+87881nE9kcrqy6+B8kPwjB5mN9Mmeok?=
 =?us-ascii?Q?km8nR0goDYII6+bdFpvzSuMO2UX0CbnWlYCBM9gxRbmEaHufqdJMZPIBuPY1?=
 =?us-ascii?Q?u83AbpzllCSaDQ22z15Wdit7YOno0P4b2Vw+g1SejWTPDEWDtgrHyHLBQYR8?=
 =?us-ascii?Q?HU6giB9/5pXaZiJeAUpvMKSv18+q9KjaGeSgTDQqIlDlp7jo2RkBDBOirChU?=
 =?us-ascii?Q?WxoVGJQEUr+zfOotCfKzOku/ONwg34QzuMQN2EM3p59Rb6iii1bUFqRa8rhm?=
 =?us-ascii?Q?Aj5jK7Oz5HfcbA84h8yqtAtfKwvgeDRO47wfUv5Fic4aWQpncozA9hZ7EEVa?=
 =?us-ascii?Q?CtSFa2qQPR+drl+eKQmtmeJ7EWQK+bSbYpehrkp0qV5cvN+Q0C8P0II9P+FD?=
 =?us-ascii?Q?zyOMlxlicMuQMq4kvOns1rJYsSkfimir7VXBksu+va89V+od66bpRcHTAslx?=
 =?us-ascii?Q?mblp+giVszzaSeipZ8y/9KD5DtplrkgcLV1lXNsnDNs9kmAlRd0RG7iWfgAm?=
 =?us-ascii?Q?LCWxfQJxQBh7xuMRV3Vf/GfTof0TJMksIF2RJ+QFEAzaL/30XNMij/OgDzZ6?=
 =?us-ascii?Q?waR9de4SsSbbZHCgAD8fog7sKUAJ0zx6WM+zGooQQNEgetSdMSSIscuGf9tU?=
 =?us-ascii?Q?8/k4q5x3vOZ41t1hBtKafMGq38Mr3r5AL2DIBmHRUjmwB3gfOJ/IOYc4Wwct?=
 =?us-ascii?Q?kdj+tc62+xGc0wsAEiDCpr1RcOyWR7E+vNbqkIj3/WwQ/t1xf6lTGbbWBLaf?=
 =?us-ascii?Q?tCS/Z6u3LPk5rY/QkWM5+JTGKWeCb1Ij8iggkcTw8Pzeha/6ct7MAwQio+6J?=
 =?us-ascii?Q?f14YibIPzlC55HHAPNgdihum+V0kRxZ2r5ntj4Px+sNaYzy+fJrbhtpvxqK7?=
 =?us-ascii?Q?ZXcZ7onMegIWihcWBjnz+KgNOctWTKTGYooa+srmsag+VQPSjAT3NBDDix5g?=
 =?us-ascii?Q?jlAmZ/fgora1rcO1uwWOdWNj9xeJZZdRMNkAnX0qJRdow7CRU7idrXm63lZc?=
 =?us-ascii?Q?EEgnSvDwIhbAtLirDsL0HbNOuLnQIwiAarV+3Ip1teYCTrYX25t2gua5nNPA?=
 =?us-ascii?Q?8VCDp85VXmkKunorhq05dIZ/C/gmkKGXNVqR2XefqSbpMfBtL3k6davyYgLU?=
 =?us-ascii?Q?jPG3WUzEOhWAdrf2abZ6JBkjnY7IY7fxljtD3v8cAEAIjiP6kk1ajazRAuSi?=
 =?us-ascii?Q?vHfif/jytaewSe0GeMjaOyxt+RZ5VTIESGsXMumYh154SFzHeSFTcH5vqL4j?=
 =?us-ascii?Q?bskbOcsBKo1mf9jpGrMeb3d04h2iDGW0toRS/xqvfgeHcy8DxOfDowSh8TRb?=
 =?us-ascii?Q?CnmWc4PKML6nmKQSIQrGigXUBGhjDYnUOpYaO05BAuVzqLgrrOUI/Pk8qJmR?=
 =?us-ascii?Q?tKVmVfMnddKcFqFCERqLffNtPZZoadNx7hP8iSGM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D+NDba6+YaKKzYMIYKu0RSYdarK/yWAFvAJ876Mjd1aLcBIv8cDW7VWqNVUmwrll9JrwzzOS0Z9VrxMGmhN/cs4BphRmRrpEYZCjaEDYNjmjTFZCoJk+8MAZ+0Ntj6KtWZuyWin8y7X4KVo0YiiZUeYhIf7kCp0EvWfOSKuhj1d3HwrfPfZIEVWBkAYkRKIKv86+xiI3pQ0LcT8EFdKDlWZnqwN6IHEmiNOkLBNxab3c6ruD4NEqW0FgL7P4aZZGITfy7AGe61TQMnbGMZk+rRpbpzS3/V+c1HyW2xprSK2kB1MVFnLJtrpavw/+uWntuUlHkUAmX3Jnf/tjWTKvbG2LJWSLdeqg/jp5J4pW5TKDfSFC2qs0NqB9I+5DbNxwuHydzWXSjEIiTH1ohbgpHQU4MqXNlFu50u2lB5Mlyw1QhQJZgfH7mQju5+mYJNbT1uq3q3l0Pek7gHSBYQeNf84CK4atiIlT7AhvABUbyRkW27+fhVs026KXCqsH5qi6UbLIxT7wqSncA+QJyzEFuCZcLSkJmpmbStmf+91SGu3lKgP9U098JGCjSyGCL7x426zK5KzhXP4eAgoISnwwntm1YncR4tYWgR5eRiW0FJ8lwe2dzswdWFw0/RSmkMsQpACGTPhtROG7jDmP/aBt7cTH31txfyI1MSbZhywRnurKpCxCTxJrSEJ4RRKGSyo9za4VfzvjUO6thLWwrbthjQm6+k9HsABV1lOzheKY7cbSJWSdyekS+Zs3/grRsw1o8pzKYB5AXAhas0ifIAonywL7MuhvGVb7tXph6fKXrJQraf2/wB/GN96odwfjOIQJH7NJaScW36cgdvkoBJi4p8YJ1n5LpgZM/0m85Mza2GdfWg+6tlNEFfqh0Z4ARmFIcJMOQZd9earyq8lAfP2j5PnlvJQvu19JAPdeIpHTW04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29039e9-8335-4da5-6c3f-08dba80a5992
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 21:04:21.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nc3VSb4G/2+3MAcO8yUsJRoqYsz//f89wIb1ccrEiBhL1dGkBZ9IhbOd1POHwg13j2yJf84+zFNPA6akDN76bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280182
X-Proofpoint-GUID: PCK1vN44TMUqIO_cVqH02LGDmljtU0L8
X-Proofpoint-ORIG-GUID: PCK1vN44TMUqIO_cVqH02LGDmljtU0L8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/23 19:33, Muchun Song wrote:
> 
> 
> > On Aug 25, 2023, at 19:18, Usama Arif <usama.arif@bytedance.com> wrote:
> > 
> > The new boot flow when it comes to initialization of gigantic pages
> > is as follows:
> > - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> > the region after the first struct page is marked as noinit.
> > - This results in only the first struct page to be
> > initialized in reserve_bootmem_region. As the tail struct pages are
> > not initialized at this point, there can be a significant saving
> > in boot time if HVO succeeds later on.
> > - Later on in the boot, HVO is attempted. If its successful, only the first
> > HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> > after the head struct page are initialized. If it is not successful,
> > then all of the tail struct pages are initialized.
> > 
> > Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> 
> This edition is simpler than before ever, thanks for your work.
> 
> There is premise that other subsystems do not access vmemmap pages
> before the initialization of vmemmap pages associated withe HugeTLB
> pages allocated from bootmem for your optimization. However, IIUC, the
> compacting path could access arbitrary struct page when memory fails
> to be allocated via buddy allocator. So we should make sure that
> those struct pages are not referenced in this routine. And I know
> if CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, it will encounter
> the same issue, but I don't find any code to prevent this from
> happening. I need more time to confirm this, if someone already knows,
> please let me know, thanks. So I think HugeTLB should adopt the similar
> way to prevent this.

In this patch, the call to hugetlb_vmemmap_optimize() is moved BEFORE
__prep_new_hugetlb_folio or prep_new_hugetlb_folio in all code paths.
The prep_new_hugetlb_folio routine(s) are what set the destructor (soon
to be a flag) that identifies the set of pages as a hugetlb page.  So,
there is now a window where a set of pages not identified as hugetlb
will not have vmemmap pages.

Recently, I closed the same window in the hugetlb freeing code paths with
commit 32c877191e02 'hugetlb: do not clear hugetlb dtor until allocating'.
This patch needs to be reworked so that this window is not opened in the
allocation paths.
-- 
Mike Kravetz
