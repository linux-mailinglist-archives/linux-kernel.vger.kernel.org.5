Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE72E7A333F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 00:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjIPWgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjIPWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 18:36:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F4BCD0;
        Sat, 16 Sep 2023 15:36:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38GMDbMf007758;
        Sat, 16 Sep 2023 22:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=eu+fgDhJukmDv0rB7hYu7J5Bm16Q9IPzIJKgoqTnpt8=;
 b=BZKI+DgCruDMIUntsw6jZO376vMpXZG++nh2bW5s1E0sEPYv78YxEi7hFnxZM8lUd2Ss
 Bl37HodnThIfG6q9rTtmnlXlcxSZZhlAuKYhA34qjN+7AK3qW3cdyKNWofSsKE8eCepN
 WEJFC9YNTvdQscGby5qSmNtKaAnmsak5dHeQtIoE7oi1mHT+fpnE+hTKOGxxn537yNiO
 zq6PQy43ybl3EkYpDS0Dp214FmMlqf/InvINeDAsYjzPZGzcEjDsO9xQesKnMV0ASfuR
 PR5Qllr0jdnbCVcFGfbrNWaS3CXaduGipj1x3Ay/peT7nr4WhOiDywfs9ue1IHFbRae4 zg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y1rqmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Sep 2023 22:35:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38GJHmEG002078;
        Sat, 16 Sep 2023 22:35:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t2nrt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Sep 2023 22:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwbCukiam2a+WU3v+lOboNLuRjsgikeftrAUHOx/hM8BbYCIBLGU5g1i4bEfPq/ipmfoC+yOnlr2fE4ge83S1sp9dKpfHxO+nPaZwgN/96eGLj9R1OTcsii2W0bb7rjpQyDeFKYrTK1GN6HWNQyHJj5teQmEy94foBHOEz3plddZFvJSjX2g2+dqhXWIIY/MgY155UjvHZDvDpM7gM2dtB1lZjXxdu7DvuOzL7JeJO9Mudqv7jpX7C7KjX9LIHmYFYZu0RKDWKRw9kXEmyTKOf5x6oRHsLDrUtU6YKcpY1QLGDAdBr3RtafijyKIVpj9Do1fKzHx3ffC+7Tl0y1Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu+fgDhJukmDv0rB7hYu7J5Bm16Q9IPzIJKgoqTnpt8=;
 b=SY8fzfXWXPeJ8Jme19U46midA85KT+OnQme7hvbYNI7iJ0QkNA2bPc2DDGg8jA9qHspoTFGS3OiEAaQG1luVpKbJvtamdMULzstexFi0D8xSuUvLP4YbR4KfJH/zIG0j/IvzAL/aKvtMrEevkSH8Kq6gWB5ReIWTERlN0TYE+G1cZls+omWBEPka5vj9eXvl2GPzepfOV7mlfUVmyMANLN8VnpEcQQ1wmLfTJUR3YBU52ZUx60iE6OhmB0J26LUvfI9rRtIvEAAEtjXamoXCVvt9QtrhsmIRAuwx+PVvRDwg+T4HC6JnfxlLPrwzzlRyJ0l8E+eNVDVIuzY1aTEDiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu+fgDhJukmDv0rB7hYu7J5Bm16Q9IPzIJKgoqTnpt8=;
 b=LRtn4mSUbGPYqHAKfFnXKh1wAxl4q/0Bu213zRRPdIltqdVBCrxzwfqGVnFRCucJawF0kjhVfQHy0vOio2Z+9IblqIeYxUjur63/tMe54P0PdZGCou42xghuEqEsPZA0cETAzd3OSfAikZVzqemOGNMMgWJazn9Lo4icEstmBOo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Sat, 16 Sep
 2023 22:35:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.024; Sat, 16 Sep 2023
 22:35:22 +0000
Date:   Sat, 16 Sep 2023 18:35:18 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: Possible 6.5 regression: Huge values for "commited memory"
Message-ID: <20230916223518.h7zv2ysybitemoab@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Labiuk <michael.labiuk@virtuozzo.com>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Linux PARISC <linux-parisc@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <1694366957@msgid.manchmal.in-ulm.de>
 <ZQWUzwiKWLk79qbp@debian.me>
 <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh29JJSVGyJM7ubxOs51-Nxp6YnmU9Bw1gdOk3rrQ_0mg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: fb993b2b-f996-4f74-43e7-08dbb705365e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TEcSPxCJYaT+bGZL6oc9UlRqZxIbC2D6R1UjmSnNsA7gzFODbwiQUyJuj11FNZX1cNYWzaL6J8n1TY0rfGeouC3OCGhJuw/1r3dPlOQFk8JIaNOM3Wj7uGezse48HRfK29zlJlPF5WrrrL7D1Qu2ZeljWuByf1eRqEPkKpEwO/4KsKjD0uzZ8Hcx+Ifm5eseo7M8c4PwRNQiYRxmh8rvOFJAVKcqXxmOCqvihHx8lihOPvzNoauK6bWycPJ2uFPT8soby4NIwuMhs24nuXPVXZfpHqy7DtfBI3Tv/04+fy+VAqyauBwV+yNsvl9W0gonk7egOGAFXjPfsSexLfB3SdQSSMAZgCtj9hvgeAkI66zEgpJq2CbNjHdSKcy9/EdbzYUsVIzvpWVDUkcmSpYpJChSKGYipgYbgndKniUTeoBBj8TatUAJ5p5qke+P6fPzKD7rNb+KncynL1NRzMfgqzS+XtGF4FAUw0DyVBxd561Q5l6z/DCVtYChLtzdD2+RnwV4Xtz7+bqMRlvFUeHNiJwaNoXLv0se8+SEDUM89n5Cr1p7eg2IW7sTDOhdlcQw1PaDad5YfFLwu6uWKZxhO02bcfVUSG7yMHfwJtAjqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(136003)(39860400002)(376002)(186009)(1800799009)(451199024)(6512007)(9686003)(54906003)(2906002)(41300700001)(8936002)(316002)(8676002)(4326008)(6916009)(7416002)(5660300002)(66946007)(66476007)(66556008)(6486002)(478600001)(6506007)(6666004)(38100700002)(1076003)(33716001)(26005)(966005)(83380400001)(86362001)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AU9tYGEbhUTa4gdleOhYg+OHkrTkN9VJUMAvvPWPqiYmsB0b0PX57KkiK+h4?=
 =?us-ascii?Q?T39zyV2wRzRHNXpZvxRNZL0ZnHgCP5Lo6J56c8XPPXSo0pJylkok6vBul/O6?=
 =?us-ascii?Q?lWqQbSR2x+7zqSg8Bu3PD4w9/QBoLxxSx3hgs96PBergDe502MYmnxcFVLz0?=
 =?us-ascii?Q?JFjg2N+Mkj36VChy+xnw2pgHCV1zGigzvqv2YLBZSwOULIYyJlSxgXlOz+AK?=
 =?us-ascii?Q?9FiyZ32VpXzBw2v2gNzR+h1+pwqQ2fEN22m5pcLW83MI/p8m82+EqqmYQrJ/?=
 =?us-ascii?Q?59JouUDFurrcyX0IaAgq1/C3OkcNKDPlI1SsAH0WJE9Edx3u3ovlZRALJEwh?=
 =?us-ascii?Q?3uFNycdKN4EMh3MasI71q4OOTpouoy5djGbwUDcPhv0L6OoQ9af9f75VUJmP?=
 =?us-ascii?Q?VmGIBUsndp9UbNX1oQJpWqK8jqk8C8ltTnnbkLIk9s+kk8jpQypqtoHX8hrs?=
 =?us-ascii?Q?CaFbAeq2F3jsZs7+bwxrZIAEx2loJGRgUJGspTDNDdtfc/z7ew1Fad4+LLxq?=
 =?us-ascii?Q?GUibd8a+e8Ixtn1p1QyNeaoavlc8/lauSV5q1kWu/kGe/fFc5GYf8h9fMitf?=
 =?us-ascii?Q?TZ1D5wOCdSgeuxuU4ZbEUJwxyrsyYbTSxfHiOWZIw8ywokPcsXRuqKXTY2yd?=
 =?us-ascii?Q?FJGgwXsFDuZFBwW683yzKUvS/nhpTxqiSGB2GxDmMCV/NX0YprrvgRuOiZOo?=
 =?us-ascii?Q?9q63UKLg0GO7K97+RCcXzhEU4cpGto8hoA+De/Y0CvokK2s+pIzYFhtB+3Oi?=
 =?us-ascii?Q?wM0FxB4sNI2hy2azgSoV++HXyb4OyS6Q80Nsn3h0l8AYS/pjrtmCCZkbxk5T?=
 =?us-ascii?Q?xHFphS5/wpsIXziKBMEZ3FlQ1hz8wj/9PsZdcI2oBEwuhnhA4Qk5dXxKx9ma?=
 =?us-ascii?Q?P/3NB8FHcGa64nDOQ5FlOTbESeBfkW8u+20YOeS1r1QnEV//nUMkPUPiJnQv?=
 =?us-ascii?Q?1BIKoQYbDHZ1b1c3HFkFjlQWaGYHaaSJmLE86+ygAw1zoiorJxwvhFQ5QlkD?=
 =?us-ascii?Q?KUbKhnii5ghf/RVr6NRVyazkvdpibH71azC9VfYQqd4V+2t80um6MH7WskuG?=
 =?us-ascii?Q?a211+0MG4hjN385MKdIhysxhWW3pmYUtGXqIK+LjIcCAjZxA0oU+25mZXL2n?=
 =?us-ascii?Q?OaHX64trxBvMpMV7kzRVrdahSpSA6HHdu+GtOdgRjzHo2gFakIwxxc5uIZA0?=
 =?us-ascii?Q?uZ2BgtEaYniTAaCw4k87qdS9rFnszI8Y/m2Mi4OG89pVTLjGijRNSFGzekgS?=
 =?us-ascii?Q?zNCsQd13EPnGV3zKR1dh76Ybf919O/4WeELM3nKqAkU/QDH64UPm/83y86g+?=
 =?us-ascii?Q?ck3GVUuguv2XNE3ZpIvZm6RnLRrA3+lHb0Hef1FMl9NTPtQxa4QnWBL7l/uc?=
 =?us-ascii?Q?X6XvhmzT2M3ZL5324W0QS3Lr9HZCkTRzij06oFELbmtRn3KGm0pXr/QvI4S2?=
 =?us-ascii?Q?FWXtsrD+26UPbuw2vK69ownm7ksfn2Yvc66BiIVi9HZU4AVBuz/rNNWDDvtV?=
 =?us-ascii?Q?5YjnB9EMBSG+Tu9q8MNh+ONaKxFS0BK6Dl9qWYnJOqHETmdXvVGQTzm1adGi?=
 =?us-ascii?Q?Qo3jwSIk6nuI3FjaaynpOZp0UjjSgXSTV6tJiWtI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?R9JFucxrqXL329ghR/nBezAn0NuW/OvLpDhCJsTx+wmOVc6tFVQNFznIA/eb?=
 =?us-ascii?Q?rMMIt0iw8a3d5c+eOAQg+6IBTBytArXnfSTwMmGNna17E6shcn2lV1Kh45fl?=
 =?us-ascii?Q?XwE9UH/idW3jxdfg2bwhKwF1UmfJUxayybzkEWMkDJfkmOHQHoMEaFdZAv1y?=
 =?us-ascii?Q?tHz62M3n1Dw5rVgp/80RGlKEIuchjRyZ5yRuY5b1SKafdyzeHpn5GqzS6qjF?=
 =?us-ascii?Q?deqzOeeb1fpI4tgCzX6YZdlVALiYtliO5EeYecRST3vOpUBkw7GpqOafv7GD?=
 =?us-ascii?Q?O1GxK1HhO2RvE5oFoP4EeVaRp3Wlw7XBQKRbrr98341tQVnpeK5kkruh9m3G?=
 =?us-ascii?Q?fEBe0ivgsjSFWmcInA1lKSFItd6t+D4yr52DORsut9SSbm425mqagKFCUQRE?=
 =?us-ascii?Q?CKXAgofPFtwzeOesKGxcaakA9k9dtu637DRWL8I167gNEmqQ3bDLVLAWeGeS?=
 =?us-ascii?Q?T9c3c3zqkSs0/6IY4yi6Sjwhy5qdF40xWj3+zKqPD9eX4oVw+P+uvnBvMFQ8?=
 =?us-ascii?Q?ydnQftjmR1C4VmNF3ZoQcIYDvF5WwLD5gQlw8JW9EmO4qi11csIXTETsrVFO?=
 =?us-ascii?Q?qmRV+J26UpBAKJzL2eOYMl8Wjgb46l7vZmF5WdBxUVV/mlYPU6/YCdQErh6S?=
 =?us-ascii?Q?hzCWaOfDLsXV5ffjJKuCWNUVDFyxoIPsqCNhMjDFI0+BwMBo5U1EywBEkCQc?=
 =?us-ascii?Q?pD6LrOSp+KbsJtY8Kno1ZHbGl75v3MLAf5EHyS+d4IwBFGULNlwrCpJzzvyf?=
 =?us-ascii?Q?bfeKX9qHJJoXA9Fc9o0s24vPB946GWp+ne5SkuagzN3c2rSgDc3A0dA/OVk2?=
 =?us-ascii?Q?/HkIF9jCLPr4mHBklPTY1n4hFFpAutgEcVD1/3NIFrtB+iV+qsQIkrc8WpQt?=
 =?us-ascii?Q?gkEIin+ERm7fs4/jXbDdDOE4JpLF/j7Gc2F8aqvOC4QzNa7cDteVzpinqwuc?=
 =?us-ascii?Q?QLGT8FZoqjBWyJFQFFVF/Objnck7lAaXxiz/PRs/mbdbscxRcaJsXh7kD3Bk?=
 =?us-ascii?Q?TZ1KIZrmwd9ReVFUDmIF9o3MARbmYX3BYtO4Dya+QhAgiZk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb993b2b-f996-4f74-43e7-08dbb705365e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 22:35:21.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1pzDjAL95Rertakz3rziKYc7eLt9Ox0mCT1XfdQD3DRe7PeELoGA/L6ZodMgerJ44lY91lJ8u5qshxZDkxgEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=919
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309160201
X-Proofpoint-GUID: iArYud8SkCSHyc9bhy-nJ7lpVJMwKSIJ
X-Proofpoint-ORIG-GUID: iArYud8SkCSHyc9bhy-nJ7lpVJMwKSIJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [230916 15:32]:
> On Sat, 16 Sept 2023 at 04:43, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> >
> > Thanks for the regression report. Michael had already bisected it [1], so
> > telling regzbot:
> >
> > #regzbot ^introduced: 408579cd627a15
> > #regzbot title: huge committed memory due to returning 0 on do_vmi_align_mmunmap() success
> >
> > [1]: https://lore.kernel.org/linux-parisc/30f16b4f-a2fa-fc42-fe6e-abad01c3f794@virtuozzo.com/
> 
> Funky. That commit isn't actually supposed to change anything, and the
> only locking change was because it incorrectly ended up doing the
> unlock a bit too early (before it did a validate_mm() - fixed in
> commit b5641a5d8b8b ("mm: don't do validate_mm() unnecessarily and
> without mmap locking").
> 
> HOWEVER.
> 
> Now that I look at it again, I note this change in move_vma().
> 
> -       if (do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false) < 0) {
> +       if (!do_vmi_munmap(&vmi, mm, old_addr, old_len, uf_unmap, false)) {
> 
> and I think that is wrong.
> 
> The return value that changed was the old "return 1 if successful
> _and_ lock downgraded".
> 
> Now it does "lock is always released on success if requested". So the
> special "1" return went away, but the failure case didn't change.
> 
> So that change to "move_vma()" seems to be bogus. It used to do "if
> failed". Now it does "if success".
> 
> Does the attached patch fix the problem?
> 
> Liam - or am I just crazy? That return value check change really looks
> bogus to me, but it looks *so* bogus that it makes me think I'm
> missing something.

You are correct.  I should not have changed that check.

I haven't devised a way to check this on parisc (I finally have a qemu
parisc vm booting), but it should happen on any call to move_vma().

It looks like you have a tester though, so I'll return to dinner.

Thanks,
Liam
