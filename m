Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35767BAF19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjJEXGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJEXE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:04:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91951D43
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:00:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 395IlFk1027970;
        Thu, 5 Oct 2023 22:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=LrUzA1Yotoa1UCfb67RYwXHwy0rSzNNkfextFGYKmto=;
 b=d5woMdEy5ldm0xDRvOAonvs6Ffsq624p3oFfFhJS6uWF2lXSawqrcWber43YeqS66sVr
 HwqHr+ZKJmhSDUd+c+p8Cybt20cA+uFGfxNTKQrew/Ck1au5eYjTK/KuZKfWYEV6+/il
 U0Prz22jeMowLc2qywImXi1FDau2ysNdTEWNqnxT7Q9MDYmW4ndOF+pl7G4qKxoc+P1i
 hXrYOezuO68uCydm40xQ4AUugTh1GqQVJjKmE7kws59c/VaahyL057wUbAjUNJEAVfim
 9viCbCeyF73XVHBSLqjUduTdTqwQTk6wridhOayNfCLivevE2ujP8nCdHEcUQlvY1s/r mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebjc2khm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 22:59:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395M7BGX000361;
        Thu, 5 Oct 2023 22:59:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49q3qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 22:59:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtSQX0lnNpslrLiAVW0L3GvQ/CzCtcH6MQJljKdIhLwwxBSUi3ppS1pTN3WieQ02znNeb/TjmcZO3EAvvwsUXGk5cP42dZUDuMJa83PpTRGGqnU6GC4mg0LDtdBFAIns64BKNYN0zNNpQfMDaNO+SzuhVYvw+oAy3rjsxmcw64kdSJU7auWF/RlpuCyTORx0UEOCSJ4N9l6NEZHIXiFqggyIrHFhtJpTMdkNHhayJtt2UMnSSZeNQjw+iPmDa6jKQVbXULwRy217aS3XJc+SDcM1YfY1dFZtXB0OcAbk1Zdi7TFqH+BBE6uFbisQoRBji1gDGxjTRmfAGHlw7XdEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yy8lgB6HgFWvOWtazS3fk2nXQXX9jqte5oKLrJxktiI=;
 b=ZssHH8z3wQOlA/yzVybECK/xWMQzL3tqq7FWBsLRFwRhLxtzYvBjq14T17wJgDSprbkkRlDljSOdbt5tQEdFKp3uQk5qN0mXvhLrVdJeyRfNXYJsdtg3i6IlUA0GuwS2TmKfDJW/+OO5Kr3hO1VcsXqAQA4dgcVWap1N2tDnD/+IZ2uVPT3oKMaPJBbC4QahGbB3r3m6QrHHh228o2zJ00IUl0jxQTKFYaP3T42l9tbE6lI8pM3cRp7p0doR1UEMB3OcbBfUi3hSR8TUwsILMX3w29b4+bNclmAxgUlNUXgoftqCm8Nzx/azAUPyzE8dHaiSXJlmhiy4rzIsX3CX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yy8lgB6HgFWvOWtazS3fk2nXQXX9jqte5oKLrJxktiI=;
 b=Z5B2jV0FEnW4gUfU20aORoRfkbXWMxgn2rUmMdpVckM2M4soD76m8f8jxAAHI57ervjHzyL6zONs7Z3U92edtLJgLp3UVcgMQORU07edQlWYG8o7s1ssCSilz4W5z9P500tOHQGuMxLLvvNG7Io90b3Ef2cY5Sx5p55aYdzqq50=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 22:59:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 22:59:43 +0000
Date:   Thu, 5 Oct 2023 15:59:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org,
        stable@kernel.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20231005225939.GA86415@monkey>
References: <20231004032814.3108383-1-riel@surriel.com>
 <20231004032814.3108383-3-riel@surriel.com>
 <20231005031959.GA13437@monkey>
 <99b67e2408c260f53958e98226449fd2bb6a58d8.camel@surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b67e2408c260f53958e98226449fd2bb6a58d8.camel@surriel.com>
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: 377900a7-1cec-4090-da92-08dbc5f6c321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5D+wmiw9ptUM5rGaRwdqgW2fLqFI0RxqsIflbkQaeAn6ZYkSXSLo/PjAsbbkXFI/uSEvGmAcTut2WhZ22GzT53opp1pvVBizvxOzJ3egGrKG4xU+Jr64QIusDZuO2QApH/AI0x/YR5+KfSiQ7wGojvXEnkXIHVmnhA3m9NgtqxwXD0tVIdh+LEvhoWBY+J9N++HT4TfP7WlghAVePkeZEUjKuI/uhdtJQRHf3+mrtx0a5Fns26yXHUihInBdXdO0jTev4Qi04mvZwaO7VdeAPqHtkOmDd07gcPr1er+fx7lteYM9w/LH3mFD9UGEpgvHOQwnhE6DOA80WCGMDDF24/f+/dAb107LKHiDvCffJ2vPu1GyEX14hGN1Y5lCekkieop7r65vaqeIJI5Qz73T1H9VXS5+A7dBZ5bDxyQcd2UMnGcEVQC0C4Cr6Z+D0Cn/cPtS95qfD2NGunwxdlAn6bjEp9Q+sfPN6q8EgZ2mSk2ZACfYBz7AF5kgkP6u1KSb+TZ7VVWIn5dnmbBPvn5TC5xhUoUc1bRbzFvPazDQXFr5kSmRVZyUm6r9C1A8id0P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(53546011)(478600001)(6666004)(6486002)(6512007)(83380400001)(26005)(9686003)(1076003)(33716001)(6916009)(66946007)(66556008)(66476007)(44832011)(8936002)(2906002)(4326008)(8676002)(316002)(5660300002)(33656002)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?q3pfzmb/eVTcsmOWKdJxmvsIy/xlh8hFaySTJ7DxEFssa2XHSdRpGtacF8?=
 =?iso-8859-1?Q?YXl5ZIAgUJy2Hj0+ZMaKuEpOPAEcEHAtkzRS69HTig4wkP4awx011B6zQj?=
 =?iso-8859-1?Q?ItvBKaVePl0ODwRMwk0otsDbifl08TcQvH5WJPd97DWSH09GfynEFCLdeQ?=
 =?iso-8859-1?Q?atvRATuAcu2KTNhBlsDh8s5aK54Fr4uWxUqzpv2csXT/mgirOoW9Q/qpeU?=
 =?iso-8859-1?Q?kWKRG5hw3nxnqjUrn9U4/UgieR5F9J8WtnZwtgyb7609m2wB+5DqAwZrjG?=
 =?iso-8859-1?Q?vEAtBm+RopbcO0HiapvS30xEExwlonz/WIvxjG1EK9sGZCBK2t6HLb4of0?=
 =?iso-8859-1?Q?iH3QZXKqLMpmV8UBbVEZoxYasL9u3SGP0geG8xJnrIqMdRe1+plOFfMZZ5?=
 =?iso-8859-1?Q?+6OvzRANUF8d4siFLjGhbeJLgP2aUiS9fsMjPpJxk+wuc4MXhCVVwP9HiI?=
 =?iso-8859-1?Q?9lc617+ipRkYM0h7uyUtqPF6+SChSPpqlYnXFYPOj22fHFiTyYu+f1ykS4?=
 =?iso-8859-1?Q?h/HXPN+s9KAJ5z7nHGxRe5lOH9ZHsEVmEuMhN/3+OuOlslqTS/XiT5/YRA?=
 =?iso-8859-1?Q?m8PzIrLQk6I+SNBtSrJFkhTbcs/UoqkkgWkHvNLlOMYOC62IXgH7aKRgI9?=
 =?iso-8859-1?Q?lfAX9WtxV808nI7+0xo+my+dijkYgQIHXOUsAPcsA6ggNGyINkeXve93ID?=
 =?iso-8859-1?Q?setvs07WbaRvCSgkIgPok21LeKN4HzLW8xppYz2bQp7GqsWs0XEnvXU2JZ?=
 =?iso-8859-1?Q?eSNALCoL3K6Yf3rMK4W4ptz7XTessoTRe5WGHkRVVXH8XtXyR3WeFuIQBo?=
 =?iso-8859-1?Q?1mo7R3bPNe1r7JC0akH3l+eKGP6VJ6VfT7zi26wuQsiKDc3jR937ekl2bY?=
 =?iso-8859-1?Q?EJ6ZMc1Oxjv1N+9tJ8t6iPvpg6il7L4dHrQxGK2x7YkVd8jevcsaV8+gKr?=
 =?iso-8859-1?Q?CLmBtBrLqQf6iN4ohDOzIt7GrVi1M44d4e8VfPzDZcCB47HM8KC0wJd2BF?=
 =?iso-8859-1?Q?oWg0+zHDdROCe2uJ21NsCNxo2k3bMR4clkhuR0nsARvNsoIptN0RmYtWE1?=
 =?iso-8859-1?Q?/YDwC3uHYUSK2tlvk1xtiNXSdT9ArBVywHyIO0paQiof9AC0WipM7DXmiq?=
 =?iso-8859-1?Q?Wvha2Qw/khA2uLQSAWFectcdlNVsraNN4VsuJN3Iix9lcDLyTSZV4Jbfe6?=
 =?iso-8859-1?Q?fkLAi7etol+nTlAU59sds4MuWb2T2SeSSrDSl8bkdobaXS7VIjHyD4yPGp?=
 =?iso-8859-1?Q?Z1YMbePM7ms2+bGRwCFAST3o7hls+OJFpBP+kg2oiWne/1FcU9/tYJikfa?=
 =?iso-8859-1?Q?fYCz+ge9C+jI9nGJ6saatGh+4BhGJ3d8dJ+Nwr+OkijPRMVY0nTDOicdWL?=
 =?iso-8859-1?Q?SQPejPuk40WHs+kGB64ndqXP67f3mSUHR/hfZ6hJfS3IBpg5EfjDuJ0bJT?=
 =?iso-8859-1?Q?l/OZfdyFcFQB6/YSi2tKWHkTvP0fSLqsh5Ci29fQgpDHEQAMSFUzWX03ue?=
 =?iso-8859-1?Q?4m0HX3Vm/nG+ZAz5m4ruCTR78DR8SUVw9/cseBTrz/qlbYQoZ/2q9sxQkU?=
 =?iso-8859-1?Q?PDI1GteiFM3Vilt5V9QGrT8o17pQqCUdbzKn/fqhj0IcSq3+mO+b9BqMFb?=
 =?iso-8859-1?Q?zK00MNMnpYOsngjah91vV2TZ+3bloMDmuG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?Q0rcD33V30H/sX006EO0j5LhNxygGYX0SLo9OtcqPxCqsXX7m8z/V8XMAJ?=
 =?iso-8859-1?Q?ryZU/VIrRq/8T07UcXGwlCGr5n6B9gTQEK2TqQrCjmpVF816NXZohA1vCg?=
 =?iso-8859-1?Q?ZheN/tIljHniJRtO+Kfd4SAPFcBDR/Te/hiMM8mC7oNNEPN4QEv4/khe3p?=
 =?iso-8859-1?Q?cTeEw50L4eQ5zz0yN8ysfwgMWMJ9XCpuWn9+f4cWDZyHC3KYZuk47ljOOZ?=
 =?iso-8859-1?Q?w7rVrkP8GroUSoKVj0CvPHM3/hKY3XxCEVKLjF9Po3pv96c4mvuNKRlVDK?=
 =?iso-8859-1?Q?3SID5DIQvG5b9Sik6fGeSCowxO1RR7uGmZvZwJdUzTvrccaRDQD+/eaANN?=
 =?iso-8859-1?Q?GKa5NjE7R7VDKY0VXHHFb9C2WyfRYIPIAKCTp8mglrMSATEDKnz0zVy3Qp?=
 =?iso-8859-1?Q?vbAUnRwsIKiBCV4GE3z4MSwv8UQ2BZ6wGiKdNuZP5nUClcAMy0BcrTVu5U?=
 =?iso-8859-1?Q?MfqGU2Yl/l0x/CdWF6VcVflZwVe62oR5EzxwCVD+xiqc+5BcWL6rMvtbba?=
 =?iso-8859-1?Q?dfBpHQYvWhXPSBNgQiGpxaH2NvEyi6QAyjnG5HAT0tya9rJ8ZJzTRML7G3?=
 =?iso-8859-1?Q?rmc0xK/WtwFaH/QjFcGpYqpPKV3ObSM9TuVu+wcZZVs1m+Y4xv8uLRvNIT?=
 =?iso-8859-1?Q?JKFDnGlfFPFU0yUUKy/Aa6rSZSROknNh7YAaeeH515x2H1MqNv+nZrAWDk?=
 =?iso-8859-1?Q?rZ1x5cb9Jy4iO8cEmsi2Ge3xXeZ37LZa/tnOPUiQco4sLvg1agHxEJc0DY?=
 =?iso-8859-1?Q?NyIV6AJObIhyfqKRlhPwDmUbAqeNX62SjkjVzhOcLqowz08wqdRS0NttmC?=
 =?iso-8859-1?Q?h/vfF6YGs55bz/Hl6fTmJCYtqe0OUKaBrtx3/4Iyiua31wfe6mGtk6ajdL?=
 =?iso-8859-1?Q?JAtW7AXvzZqLNrsI+5OpPjTwtf8bMmmJHiaMe/Pt2WWRECbBTegtIshvLH?=
 =?iso-8859-1?Q?4kxFxPyJyNNtzoD+6ioLbZzTF3X23F4OwXqVSmpmwkWn5I/2H38sKCypxY?=
 =?iso-8859-1?Q?N4ht/gBi8Y6nQhEqRPJdeUwYuTPhPe+fhoDl6/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377900a7-1cec-4090-da92-08dbc5f6c321
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 22:59:43.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffBd06VssYnk5wk3ngfF4gv9iPpU8dGbOKum4KrkLwnnFswxKduBbns5bs6d/aMkLUWGLPnKbkia2E7jZDCFkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_18,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=561 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310050175
X-Proofpoint-GUID: Gvvf2yWSoW-OQbXmf2XzXbPORZJreCjS
X-Proofpoint-ORIG-GUID: Gvvf2yWSoW-OQbXmf2XzXbPORZJreCjS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/23 09:23, Rik van Riel wrote:
> On Wed, 2023-10-04 at 20:19 -0700, Mike Kravetz wrote:
> > On 10/03/23 23:25, riel@surriel.com wrote:
> > > 
> > > @@ -5457,11 +5460,12 @@ void __unmap_hugepage_range_final(struct
> > > mmu_gather *tlb,
> > >                  * someone else.
> > >                  */
> > >                 __hugetlb_vma_unlock_write_free(vma);
> > > -               i_mmap_unlock_write(vma->vm_file->f_mapping);
> > >         } else {
> > > -               i_mmap_unlock_write(vma->vm_file->f_mapping);
> > >                 hugetlb_vma_unlock_write(vma);
> > >         }
> > > +
> > > +       if (vma->vm_file)
> > > +               i_mmap_unlock_write(vma->vm_file->f_mapping);
> > >  }
> > 
> > In the case of a mmap(hugetlbfs_file_mmap) error, the per-vma hugetlb
> > lock will not be setup.  The hugetlb_vma_lock/unlock routines do not
> > check for this as they were previously always called after the lock
> > was
> > set up.  So, we can now get:
> 
> Wait, the hugetlb_vma_(un)lock_{read,write} functions do
> have checks for the presence of the lock:
> 
> void hugetlb_vma_lock_read(struct vm_area_struct *vma)
> {
>         if (__vma_shareable_lock(vma)) {
>                 struct hugetlb_vma_lock *vma_lock = vma-
> >vm_private_data;
> 
>                 down_read(&vma_lock->rw_sema);
>         } else if (__vma_private_lock(vma)) {
>                 struct resv_map *resv_map = vma_resv_map(vma);
> 
>                 down_read(&resv_map->rw_sema);
>         }
> }
> 
> Both __vma_shareable_lock and __vma_private_lock check that
> vma->vm_private_data points at something.
> 
> Exactly what corner case am I missing here?
> 
> What leaves vma->vm_private_data pointing at something
> invalid?

You are correct.  The checks in hugetlb_vma_(un)lock_{read,write} functions
should be sufficient.

Here is the corner case that needs to be addressed:

mmap
	hugetlbfs_file_mmap
		hugetlb_reserve_pages {
			!VM_MAYSHARE so
			resv_map = resv_map_alloc();
			set_vma_resv_map(vma, resv_map);
			set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
			...
			some error in hugetlb_reserve_pages,
			goto out_err
			out_error:
			if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
				kref_put(&resv_map->refs, resv_map_release);
			return false;

Note that we free resv_map but do not clear vm_private_data.  So, at
unmap time we try to use the lock in the freed resv_map.

Leaving the dangling pointer to a freed structure is BAD.  However, no
code accessed the freed structure until this patch.

I would suggest incorporating this into this patch, or even as a stand
alone patch before this series.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d25db18c9526..a3ae13d0f8fe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1171,8 +1171,7 @@ static void set_vma_resv_map(struct vm_area_struct *vma, struct resv_map *map)
 	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
 	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
 
-	set_vma_private_data(vma, (get_vma_private_data(vma) &
-				HPAGE_RESV_MASK) | (unsigned long)map);
+	set_vma_private_data(vma, (unsigned long)map);
 }
 
 static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
@@ -6910,8 +6909,10 @@ bool hugetlb_reserve_pages(struct inode *inode,
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
+	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
+		set_vma_resv_map(vma, NULL);
+	}
 	return false;
 }

At one time set_vma_resv_map must have wanted to preserve flags.
However, that is no longer the case so we can remove that code.

Of course, feel free to address some other way if you would like.
 

> > +++ b/mm/hugetlb.c
> > @@ -5503,10 +5503,12 @@ void __unmap_hugepage_range(struct mmu_gather
> > *tlb, struct vm_area_struct *vma,
> >  void __hugetlb_zap_begin(struct vm_area_struct *vma,
> >                          unsigned long *start, unsigned long *end)
> >  {
> > +       if (!vma->vm_file)      /* hugetlbfs_file_mmap error */
> > +               return;
> > +
> 
> This does not seem quite correct, because the locking is needed to
> avoid the race between MADV_DONTNEED and the page fault path.
> 
> 

Note that vma->vm_file is always set for hugetlb vmas except in the mmap
error case.  The first line of code in hugetlb_fault is:

	mapping = vma->vm_file->f_mapping;

So, bailing out early like this should not be an issue.


> > Another way to resolve would be to fix up the hugetlb_vma_lock/unlock
> > routines
> > to check for and handle a null lock.
> 
> I thought I had that already. 
> 

You did.  My bad!  I saw the NULL deref and jumped to conclusions.

> Does __vma_shareable_lock need to check for !vma->vm_file ?

I do not think there is a need.  It has the check for vma->vm_private_data
which should be sufficient.  We only got in trouble in the !VM_MAYSHARE
case because of the stale/invalid pointer.

However, I do still think we could have that early return in the case of
!vma->vm_file I suggested earlier.  There is no need to take the locks
in this case we will not be calling the hugetlb unmap code.
-- 
Mike Kravetz
