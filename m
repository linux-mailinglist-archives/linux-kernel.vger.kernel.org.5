Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39204798E7E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjIHSzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjIHSzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:55:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B6010CF
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:55:19 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388IKBU8027154;
        Fri, 8 Sep 2023 18:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=IEaXe8TddOMCP5jPNvgw/kwOOY9+00mn2r4acaO0vJI=;
 b=UI3gkwhxFQdBaRTraT1CkHnYKIo6G+TWpL91yTtjjEfYZX2dTNcXaqneOkmwldnlGyBR
 2812WDthHM/xh8TQO+7zK6B77T8tabd+P6fmYtP4DnwYc8EvGvZbocePRXIcHFim/xcf
 EnXsv3QnkzBuUacFyRUEU6uJ0wvgQofvFB9rP8P6unbXBZDsyGytMGVzrY8gaEHurMBT
 xdQ/ynrXmUOFZ8HamVKgBK+Rjvi4CK9YTTCxVrHFMmMD4gVD/XdmeZ4I9ELFs4N+fJQt
 dYqePqK+mm66b6rrANlkHEzcGOfb+ZdWF+Cbb5fpl2+WXkItQDl4111978whzV5pmtLN fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t08syg28s-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 18:53:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388HxUCf017294;
        Fri, 8 Sep 2023 18:29:56 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug9yt7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 18:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZGjSwVj/m/QcYIQuCLdb5HsMmYdQZ6MCaF03BPfETNu4lC1l1H8R8u9+JQoZkKgVJz03zKveDlkXBHHUG0yOZb95L0G9eGXQTUQbtvJlApLGwBYjci1SZd8a/CovZuOzGoD/Gycp7MO3YYubxD9d6zuWj9okBdvO/2bSqHxGOcJLYLpvEcQwOtcw8h4/3ZTh9lCkCBBpVT9RV9NQSdbrQJQnl+qNUM96bMRbUtpABtwIEwL5jMJI49IDkojD8yPJq+UwyDqpC3UljOjxlESSGZajiT1ZNvXfs4TLYHiu46cb48MhvCZNzJv6OK/QBbaIz7RRUliCt8UwvwesVqdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEaXe8TddOMCP5jPNvgw/kwOOY9+00mn2r4acaO0vJI=;
 b=RsYmvzjuv469UPSlJdE/3bsrdVpA/cNKiv/evWB4jHdH1yFtm5QUBVNM9NJgeuZt4kZ1kkBKk0D7xtXojZ/KaAKtUzBhElFAs0nNVD4AizVEYMKTxmuIThXxYF737I9AcfWCPeVScgekClFrv84pI8dmS7w2lOk2UUFTJEEJbhPX3XdMAV6SVjzEtPNp/QIE+8oLIVwyWV9xEhjMwrmHqEGt4XbOKl3fk/w930fKv7n3utqvGfi6ObdydK60cInIlzAj82QDnW0BOWXQ7Qt+m9OH8TeU4yBMZeb5vcweFn2UysOqUbid0AIq7ebrgA1UX2GXg8+MmLcnvZoeUVrYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEaXe8TddOMCP5jPNvgw/kwOOY9+00mn2r4acaO0vJI=;
 b=iBLb1jCyD0gXsFw3Dqbas7Ix4Nr7H0rvxw8ybR8C2FQFN901pz8TG+Turme6toDVxIdmHKsAzcZqyRYh59Aj3h52WgIOokRP8ve+1Z6WLdArUE75N/0GSLyQ/NAqvqS8qiz0ixEr/apQjX2zuSNoaFhhwi4ufQNO2NuuBWwaAkY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 18:29:54 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 18:29:54 +0000
Date:   Fri, 8 Sep 2023 11:29:50 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux-MM <linux-mm@kvack.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [v4 4/4] mm: hugetlb: Skip initialization of gigantic tail
 struct pages if freed by HVO
Message-ID: <20230908182950.GA6564@monkey>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230907183712.GB3640@monkey>
 <C51EF081-ABC9-4770-B329-2CAC2CE979FA@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C51EF081-ABC9-4770-B329-2CAC2CE979FA@linux.dev>
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: a3dff6e9-e6e5-471f-fd98-08dbb0999882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePRIoshiOqmGTvjw7hZzZVFPqp1ZsQ+NH6FGNIcsIMoK7dVCgXmuDG4yQpScqAfSnF7pXf8TTBAyxQzmIhVbhOuxfjK/+769/bCtsueeSvZZy0Jcb3v/oy+0ltrhYoRo2L7PvcEe2EgNfW74sj805+ACB9jAsNI3T/D78JPxxL+3g2oROWjw1y5JBqfVU+YnhbmwPEqeHJ0H+A4l73DOF9uSvVoWDP2J0Cw2qI7oBZQqDS/sY8y1AJ666RaKLAbTVzkV3swNEhFcMw9uls7q9+K70G85JGiKAlCkANrgxmS+PRnqgJXdlanzqzMSpqQkTEhIeCPaYpKUj1bSvS66k97z1kNlrP/NOydVG2sTldcFWii/ePaAoNKN2zks2qqphXSZKC4pYlC4q9fxphMsEAVq8jA8FdmfzC7Pf/zcL+8L+XIG5mudQOT4Hf2SnsCFeR37335Azna6/Q8OyXE3uMenU1nrUVtGYGqV59kDA6X3fhPe8BcH7Zamy4ArQ3nhC4L6RZ7WjuWueT8X/ocUIqdnBnd2TQs3s/pTdobYx/950qV8yXqvnKoIeMjoVMO0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6486002)(53546011)(6506007)(86362001)(38100700002)(33656002)(1076003)(478600001)(2906002)(26005)(9686003)(6512007)(83380400001)(8676002)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(6916009)(316002)(54906003)(66476007)(33716001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjjAAwKWmml5SaacsRdf+I4U8o3DIv7IBKUlyv5Wns3hxskZ1bqPfA46i8Dc?=
 =?us-ascii?Q?8V0Jw39Bl1iB/TGSkafm3kuls7mlCK//RfSYA6vjnyT3IJf2CbCSHZq+ELCE?=
 =?us-ascii?Q?WUzaGMJK0H1y+InRI450BHJne7M7rl7KuOmJatNK54Ic00vXYDEkWPQFwWVN?=
 =?us-ascii?Q?YL1LTy1gHmYlv65qQ1m2Wb29aFp0V5COeMLTEaqPAl0f1KHOdOlPA/MUR0Py?=
 =?us-ascii?Q?yFkLbb/t1g1ZAhP65LMFWZYgk2P3f0uEDgqqKXq+A2UV/DP1GmriQSYn/hg7?=
 =?us-ascii?Q?RuMlrzPry6Bu69CL478cZtPD9lB8awW46uFUiFsvO/oF6Y9OYNWQkiPJtWn7?=
 =?us-ascii?Q?ctJPzu1OVHBx6VsqeOow8kHpStXqCkV0+zaS9U0W2YLUQ9FWHbtUV65CBQwT?=
 =?us-ascii?Q?LxY0EbXnj1o2xzovvtDib7qH6mOczjShA2AMD3EDiEEhvwnAtPBUNGY0jHl+?=
 =?us-ascii?Q?H7qTBAdw86M0yQrF+xP8p30/JH0zHYcHZv2v1FObyvyIdqlYJrFEkR+nEdep?=
 =?us-ascii?Q?Gl/89wAH9TOK1DJvvE0sH+BzX9tNBs6xjcolB5XoIqpBjsDsUd4cGcYy9yuG?=
 =?us-ascii?Q?e2pDQQrm3Du13POjid2qkEN9z+Hc6YN8SdePsi5fRr0eIoTYqsMKyb+zM4dB?=
 =?us-ascii?Q?mCC0sW1DB6xs2WZrqeFTPglVGct3YEWZpR6YIbihunyYyO2rcrg7MP0SN5XK?=
 =?us-ascii?Q?3HQAtXm94XpEpceUqgAxxWGM8b4vZAywV9m/qjruEuynMju4uadrvqtx5gkH?=
 =?us-ascii?Q?YHVQwFurzfC0tqcYJMsIyEqZThviHYk+y4LxKLPNPBv+qUkpUos1VBWD9o8N?=
 =?us-ascii?Q?v5T/CrSgo3tWokGLNUAlbirw7tfs50+GQsjGVTEME+R/9F81KfmOJP7s6HiU?=
 =?us-ascii?Q?xlqS8KvFS6cR4Jqb5lD9KbShUqKsdAqYmxNsL/Eup5fc7EZU3YFZKfcTO+7u?=
 =?us-ascii?Q?ZN3PRo/pT+z8cFOdln7ImPjKrAz/CV4o71p//GzUVdynqF18yRPqsAbfVK1F?=
 =?us-ascii?Q?jLXUnQQRblI8x497YzrLbjmJFh3cK/ODQboGAeQNVzrZOsbckUq6I94BSr+Z?=
 =?us-ascii?Q?hb/hzVWHn1J0m0pY7UCw6trscgLEaQWRX7CbQNr+E8ncRePbafHV+FNFiNEu?=
 =?us-ascii?Q?cx4I0ZaDu5Amm3m1khRUVoqGe4ef1eA0fzqEB0j1sI2a09+FGJUYhN1atxtC?=
 =?us-ascii?Q?SVdAN7AbWjiY2bD6lyxwojRrdulZvlIyY3X8rzv5CxHShlt5q59RMwR40z0H?=
 =?us-ascii?Q?6KABOXPzJVmUb4qSUbIFaKn5iVjFw5cxRATQl2ejNmLyS/6GnxuUCQ9JMDQi?=
 =?us-ascii?Q?MOySDLxT7clecPB6bAq9AaW6msjq1QOD9WYAKOMoMeq64w2Ay/3xVtk1oFaV?=
 =?us-ascii?Q?YCucKv2yGbdnlOAyR2qhK8Qm1tBSje9lGBwhuulnnxHNQyOyEfMBOBCX82Ye?=
 =?us-ascii?Q?0eCjZWkfoSIsF0SOitbTHs1gBUNnB06xN5pj8IALVP5h9N4G3HHJMHLLGwg6?=
 =?us-ascii?Q?Tveju/jGN4VdZxiGPJ8eml1Cpfi3RwFnGEmMx5a0TDG05cS3DQOYpg4AmIq2?=
 =?us-ascii?Q?SxWneuylq5EfxT3ZTJjZrQ4teGrGueFlcbKoB2sD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lhL87+j1pu3xCGHmvsNroG8bdiWkGQTSiIVK5I3pppTaCNwBe2AjnGc+hWHG7rqMQEgyhlhIQN+hyg5O0mEThoGxBuVweaCA8qpaP6YXEUvwSm/lCaCWZLCg1hQV9Ufoy0IPVTiG/mZ2GrLRReGxMrWECjpx7bohi6qmIzb8AuffOkSGzBPlCdwT++mEZBC83czl6eMsmb9EjnZtYiGtHW3SH3wyvhw1SbH2jlU0NxE5Rz7odyathw93nLbjqTPKByftRhOA5SQvZK2aHT1b92F2hDhUMDtoAcxab5oz0PykmibTnLuzRWTvZbdyVtgZBiMnlN6v7agLgXRz1GhsWjwW2ju9Zp5dJ9n+OloQljcr64vE0LimTpesAyRcUY1m+wXyWjOed4pjgMxY9/gctfn4PNOVTRBA7my7JTDdFKX+jegMLA+JOptfFUkfRpzhn1SkEXqBP6oZogiJ18Gl66KVtpKTowPgusYXLjLZbgUbwaewphIte7vBqcQ4apeHxS7+VBx/SuLvyPH3KEsbWGOGLqmIzjKC5t80JfuTM4mDeh/EwoloBorvWEohb9M8/osAx5vZse/hBIVDCzhX6HpPnXrk13O60ON9GaU7zquqQk1izOPa9x3S3/+E7DleOJ462oI9Obsesx802p7ELUIfc0XWzNPZhbxD5BkVkhCySaqMc0M8WwDC9GjypumQ0PZ0wAFmceXa5PI3DWqos7oNT1cnPDn8i1YAJkBJ2jz43tH2Ztr2+rCg+3ISr1MKy4IBK9N018ibN7/h2pHP0DS/Zxc9f2bENG0YVqW6mYQKxIHyX3u+0Vkm0MhCBt6oQfBnyay7W1BOTdiOxwYJJMYStIfiyZpmo45FY4rLnOCBcEn2koHZvbteDa1zBkYoFTN9+XPrLf5joQxNsoQoTmJUwZb2p7ZzjRNh9z5lvFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dff6e9-e6e5-471f-fd98-08dbb0999882
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 18:29:54.0116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP46I/OX2XHY90/WEO+SL2P8S4TgaiXAnW8odIMuRkdEnj7Xt4xaeeG13jTCPlDFsi4kNySx7Sh8Ok9Q6bYv1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_14,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080169
X-Proofpoint-ORIG-GUID: QopQc_dqj3MZfg7yX3i6yR6UVBCagjYo
X-Proofpoint-GUID: QopQc_dqj3MZfg7yX3i6yR6UVBCagjYo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 10:39, Muchun Song wrote:
> 
> 
> > On Sep 8, 2023, at 02:37, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > On 09/06/23 12:26, Usama Arif wrote:
> >> The new boot flow when it comes to initialization of gigantic pages
> >> is as follows:
> >> - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> >> the region after the first struct page is marked as noinit.
> >> - This results in only the first struct page to be
> >> initialized in reserve_bootmem_region. As the tail struct pages are
> >> not initialized at this point, there can be a significant saving
> >> in boot time if HVO succeeds later on.
> >> - Later on in the boot, the head page is prepped and the first
> >> HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> >> are initialized.
> >> - HVO is attempted. If it is not successful, then the rest of the
> >> tail struct pages are initialized. If it is successful, no more
> >> tail struct pages need to be initialized saving significant boot time.
> >> 
> >> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> >> ---
> >> mm/hugetlb.c         | 61 +++++++++++++++++++++++++++++++++++++-------
> >> mm/hugetlb_vmemmap.c |  2 +-
> >> mm/hugetlb_vmemmap.h |  9 ++++---
> >> mm/internal.h        |  3 +++
> >> mm/mm_init.c         |  2 +-
> >> 5 files changed, 62 insertions(+), 15 deletions(-)
> > 
> > As mentioned, in general this looks good.  One small point below.
> > 
> >> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> >> index c32ca241df4b..540e0386514e 100644
> >> --- a/mm/hugetlb.c
> >> +++ b/mm/hugetlb.c
> >> @@ -3169,6 +3169,15 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> >> }
> >> 
> >> found:
> >> +
> >> + 	/*
> >> + 	 * Only initialize the head struct page in memmap_init_reserved_pages,
> >> + 	 * rest of the struct pages will be initialized by the HugeTLB subsystem itself.
> >> + 	 * The head struct page is used to get folio information by the HugeTLB
> >> + 	 * subsystem like zone id and node id.
> >> + 	 */
> >> + 	memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
> >> + 	huge_page_size(h) - PAGE_SIZE);
> >> 	/* Put them into a private list first because mem_map is not up yet */
> >> 	INIT_LIST_HEAD(&m->list);
> >> 	list_add(&m->list, &huge_boot_pages);
> >> @@ -3176,6 +3185,40 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
> >> 	return 1;
> >> }
> >> 
> >> +/* Initialize [start_page:end_page_number] tail struct pages of a hugepage */
> >> +static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
> >> +     		unsigned long start_page_number,
> >> +     		unsigned long end_page_number)
> >> +{
> >> + 	enum zone_type zone = zone_idx(folio_zone(folio));
> >> + 	int nid = folio_nid(folio);
> >> + 	unsigned long head_pfn = folio_pfn(folio);
> >> + 	unsigned long pfn, end_pfn = head_pfn + end_page_number;
> >> +
> >> + 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
> >> + 	struct page *page = pfn_to_page(pfn);
> >> +
> >> + 		__init_single_page(page, pfn, zone, nid);
> >> + 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
> >> + 		set_page_count(page, 0);
> >> + 	}
> >> +}
> >> +
> >> +static void __init hugetlb_folio_init_vmemmap(struct folio *folio, struct hstate *h,
> >> +        unsigned long nr_pages)
> >> +{
> >> + 	int ret;
> >> +
> >> + 	/* Prepare folio head */
> >> +	 __folio_clear_reserved(folio);
> >> + 	__folio_set_head(folio);
> >> + 	ret = page_ref_freeze(&folio->page, 1);
> >> + 	VM_BUG_ON(!ret);
> > 
> > In the current code, we print a warning and free the associated pages to
> > buddy if we ever experience an increased ref count.  The routine
> > hugetlb_folio_init_tail_vmemmap does not check for this.
> > 
> > I do not believe speculative/temporary ref counts this early in the boot
> > process are possible.  It would be great to get input from someone else.
> 
> Yes, it is a very early stage and other tail struct pages haven't been
> initialized yet, anyone should not reference them. It it the same case
> as CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled.
> 
> > 
> > When I wrote the existing code, it was fairly easy to WARN and continue
> > if we encountered an increased ref count.  Things would be bit more
> 
> In your case, I think it is not in the boot process, right?

They were calls in the same routine: gather_bootmem_prealloc().

> > complicated here.  So, it may not be worth the effort.
> 
> Agree. Note that tail struct pages are not initialized here, if we want to
> handle head page, how to handle tail pages? It really cannot resolved.
> We should make the same assumption as CONFIG_DEFERRED_STRUCT_PAGE_INIT
> that anyone should not reference those pages.

Agree that speculative refs should not happen this early.  How about making
the following changes?
- Instead of set_page_count() in hugetlb_folio_init_tail_vmemmap, do a
  page_ref_freeze and VM_BUG_ON if not ref_count != 1.
- In the commit message, mention 'The WARN_ON for increased ref count in
  gather_bootmem_prealloc was changed to a VM_BUG_ON.  This is OK as
  there should be no speculative references this early in boot process.
  The VM_BUG_ON's are there just in case such code is introduced.'
-- 
Mike Kravetz
