Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29707AE1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjIYW0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjIYW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:26:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6EA11F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:26:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLOksi022167;
        Mon, 25 Sep 2023 22:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=8V3oM+xtvqbP92aVNpNxdgova9/jG8Jjaw22ZXyXX5g=;
 b=x62sL/zyZjnwnHlxRNj/BQhNYOCpW5bWefWYkp/cX/QUieIPpv3JRkjMZNc1+rfW/xYP
 sR4InZXq0eFjYXQ24ckBTBOI1LjW7bJa6pvZjotC1y489uDnoGA3SX8Wa41StZ7J4J6y
 2YyCcQ4ssJjPPIA+D0rlvPmDqjrCNjtbgYFoVj3jK3DXrYRm3FK05mYN86qzRfYFFc9G
 l8y62HB+pDQ3Y5B9wZSMl9V3w3maP9dgcjsPU5Nua9GFfbHzdXYRmIvHbStuQy2udw3B
 7aORmldXQSLbxyM1OEUjUxqw4Ef5+ZlXKNr6xeZe/+uy/X50oyEMbV5XUc7tRWtcJtIN yA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjud3t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:25:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PMGOrb017976;
        Mon, 25 Sep 2023 22:25:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfb7h4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:25:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQHSva51Ado+6MXAHRCfnsl/JD9VcLZZEdQ2w/clxLnD5hpBx0ISyz0nBcIuDyJFsLTcL7wiavRVqJxVi7YWAP+Q4kMFxheHPn8nl0FGaRvbY3CVq6YVyKsRGB5m4Hl1OHr1pSeuUR/s2vU8sQImAq30met28JbUnvksoRoxKvuFVIsS/+gLWqlJKl+zN0SrdAqKiiv6X41hyLRCOiz2kCFROIMTUYQwY4hu9U8o80v2Ps3um2b3rydDDbq2tFHb3xnWlbQ5/EAz2h7w3SGGLlF8EAj0EcgwJ+cs0v6U2JjyGEbLayRHOCrlFvICAr6rdfxKhW05cn71p9BleQdnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3oM+xtvqbP92aVNpNxdgova9/jG8Jjaw22ZXyXX5g=;
 b=d9lBHBEqDrkzhxnQ8nLA1a/NoxeojJPwqGpkjsdz39Ax8ejmIPcuhJyZBjyWbDKYx8Kx/EQTlFMlXsGAwO8Sig3+yloGEn2lmx0ln5Tmug9KHEawi1+URDMmTlfOGyojZDDIgLCag2voYppbi176Yvte2zVADonlgUVGEKZQxuG+L9c++vPoZMLBmyN4Ot3ZmOc9dR9UjiA7oMVmGfUSPyCWq/bhgftD3n+497/Am1r6sWlQKeyJyrWKXF4neP9j9I+XemgTPDD7IjX/qt40FBn/0f0XhvoviGocHaEihoFXAJGLgoVhx7Dxq+DrvE1AYOb9wZ6HwXtEzCI97z2hEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3oM+xtvqbP92aVNpNxdgova9/jG8Jjaw22ZXyXX5g=;
 b=llJZFZDeHEID5rP0/cuF2/5yUcvVnfxxKcAk3X3knl+gGbKtUQlHS1FZhIwhw/Lc+JpYc7/mm5pLMeLOeux2M7DHlZEPzrXZ6Ttknpd0rpuNIBjjYW8o2g1AOkF3fZEBcko7dbLC/RTrEFrehln328g4d7TK4HxMmnMXEX8ZE+c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Mon, 25 Sep
 2023 22:25:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 22:25:42 +0000
Date:   Mon, 25 Sep 2023 15:25:39 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com, willy@infradead.org
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and page
 fault
Message-ID: <20230925222539.GC11309@monkey>
References: <20230925203030.703439-1-riel@surriel.com>
 <20230925203030.703439-3-riel@surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925203030.703439-3-riel@surriel.com>
X-ClientProxiedBy: MW4PR03CA0313.namprd03.prod.outlook.com
 (2603:10b6:303:dd::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: b62405aa-eb81-40d0-f47b-08dbbe165af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOeFOA96gl9PB27A0gFp/Cyv+IlQhMe5n8vAj1ryy8up+qNZO7I6dsP8GSlE57P80PdZ4RdiZnoJWYu7pnpdeyS97SxHEWvUcN2POlTYm5FWjkzOOZcZnPpKKY3qYsWqxpbpWYYwTeoI7Egk7KyOV5uftDLTTO0SdWO1jqJXN90j8zfHPLYUMj+euWezzkMSBwCGAytQ14G7xXlzHOqJx+ouWC6kUEIJlepmVbedEBYYhWhEHxNrBSeaRh9UHpCBHB2/oDywhpKjSDHGgqTfYq35F86ZzJUQ0vJ5dJL/LIIQehgA1li/fZJPyiRLvNfiwDqjAmgxIj3zR8L5puJeTlLUTQbuaSmsR2TbVv53baFtMgpwABg/CqAHJdvLbL2yo5sLUURlKmeJcV72UlDYI1jwRB4OBTJlP1aKuxI9mi9f5DwKQ6vM8j/S+AS3XkWGIAG8dJzFPwjdWa9a5QO0zA6ubrih4etTL37eJCsrOO6MBoIcyt4XYbmdubq6FejlQvRLHdhpb5qZmGNgDoWbJxnHVdZQX00zhX/vkbzbfa8HLZekNG6PjQe3AnMJj6Sh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(2906002)(5660300002)(66946007)(66476007)(44832011)(66556008)(478600001)(6666004)(33716001)(6512007)(53546011)(9686003)(1076003)(26005)(6506007)(6486002)(6916009)(316002)(8676002)(4326008)(8936002)(41300700001)(83380400001)(86362001)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pJD/Jvua3GJZ3EzfAMtHF9uvss1RrK7kRM2ia9aSScsxzfhnx404I+2aXUYz?=
 =?us-ascii?Q?zKAolpJTNUB9CwmdAMXNYQicBG1dJJAdm2Jgg4XoVREZoMnz5SEcoxf4tsT5?=
 =?us-ascii?Q?VDd3lK25nO6askK9jgcM2/rM2p8oDb7cLdxbPf9ZDhjnbTBQyVOKDMEhRw6p?=
 =?us-ascii?Q?chQ8eUSnRru1Q8VOBL8RBzBM+PZj5fVa/MmEUYylBis9LJWrV6Bm8umd4uZx?=
 =?us-ascii?Q?9aJfsLvft0GpjBrCozauI1MsE2SoWU6Zsz4pKlfEH+ah9Q3sWK68CT9I/v/J?=
 =?us-ascii?Q?yVDniylm/32b37ERryiAtQ5YjZFJp3oifUwHQTI9XPVft+LFS3WbJjvYoO8a?=
 =?us-ascii?Q?ozFMCY0+hr4nvB017ow5yGmA/NOCClKYq/lEkPCe0acOpLSQkVst2oCqx6BE?=
 =?us-ascii?Q?3Oo9ZcFmCbfnoNGJdzQr6z0e03X6by+kZmbemr/4QfVkKiIjgERz1BzsigBo?=
 =?us-ascii?Q?82r/2y2gPKyx+TK7U//eHZ86OlisdSwl+VIA+J0/1v4iokKV/MO/9k9wsTuW?=
 =?us-ascii?Q?Fl5UulbZlk88j18d/Vg+L5ZRc4SOFZRWv2y5/itGctn9DlAbaw7XBKQSqPyS?=
 =?us-ascii?Q?R9B6N/RtvltjIwcWpb7GLX5gjNePFxSDF+i79Of4HxPki4b9C3dUYGPz3afn?=
 =?us-ascii?Q?NZo/X5J6EmAwGOdZnjV5o/O6jund8GeJhX3Yj0bx1v+NiRc1/sGIXDfDRcE6?=
 =?us-ascii?Q?17QxPWH4CLzY0cx2UvZTERnjd9XImGMzQ4vjnepI0JiOQQP8y5RFix8EK8Pd?=
 =?us-ascii?Q?jU6v6HnjAYXQLz0qJmcTey2Asjq0HzpeIPjfklaBg0WjCWJudPR7fTml4lYI?=
 =?us-ascii?Q?MkqU5/hl5G+ekKyhLff+agcq51N0BucKsTEfNxQ+n/1u0MvQSz/FSjzcMSVK?=
 =?us-ascii?Q?6nOHmMynqUBncQtAG24j2+jTMZL/9B5djMxSnJoU9AsKuP3tHeRqLz44aBgQ?=
 =?us-ascii?Q?I2QLCmvdXPHHxUGx4r9BPGyk3SavNQxQ6AyFXHujRPTuWJZ+WPWiuaD0ltuH?=
 =?us-ascii?Q?eBVHdf8x+Lcw0J6niBOz//hwW9GSvwZhv/xH92CCpKaN0fS0RUwKTtiUs45Q?=
 =?us-ascii?Q?XdNDU4ioQv2vcbn2I+C/SRo9ywB50bKPyGOTqfH9Phm1w/Q/iaoB6put+jDY?=
 =?us-ascii?Q?LCCjnc/jN6YlGBGbr+RKcqJjyNP3vErj3RyajJlmxTXbhZXi54boBVIj7N/2?=
 =?us-ascii?Q?3TJnjvc/KEB0auuMe94BcbSx1kLS0F9qMbCoCdrIvQkaxEw0fJXwau4gsWc4?=
 =?us-ascii?Q?JT9uiwb4w9MxljQwWaS4wOPA+WhFZOiLoSlvpY2+EgeJxpeMadpLKmOiAX2z?=
 =?us-ascii?Q?VoICfTzz7xgZaU76rOP/5zWrsiJZLRYS+fVZv7njzWEYnuEGQ0D6frfuah9Y?=
 =?us-ascii?Q?8TyFjAYvrruKT/5CGyG0CiOueplihrT1ULOdpYmk2yWajTyZ9aNbV6dm9VjX?=
 =?us-ascii?Q?zXIpEhVM/Q7Iwel4muuTjImpxxX2pTFywhqhlFX25a4m0TBRb/F12C4Libx5?=
 =?us-ascii?Q?SGTLOQBL6eSVUpbfzwLaiSGhnQJYdnJggWEv/MSXd+3lPzpQ6aAOSc9CaMl0?=
 =?us-ascii?Q?5GjX/qZlEA1fHgy3RNj2o00dbVxQwGUcLw+Zm6UuQx5ZSyns7M4bXxRkgk6Q?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?cVEX45iaFcrr4BYRu3cLs6mM2+imq/s3G5bnSYhjmgh0rCsUuGMYNxWnqgHO?=
 =?us-ascii?Q?GftnCBfE9FbYQ/YUsWLi3WKLgzqitfzLtzL94TSh/W1hjWFglefTpB4/2z6x?=
 =?us-ascii?Q?DmzewEBmxXAZvG0BOFVR8xBNIqboktwJNSVNS1Wm8K+WlIN7Eniu6hxSF7KI?=
 =?us-ascii?Q?eRP4NkBTUY4IRdyUKt3wiaFvStO0ZciYoMTXwJ9RMzz/8IJGqlsBJi8S5Z2l?=
 =?us-ascii?Q?QOVqQvXVhFViXbhK3QPal24sHauZ1Ls/zPQ4xRyOpXpS/dwbA5EfMgFYOMlJ?=
 =?us-ascii?Q?0KkBWXM9sLnzNPUvnZ8W96BfJlswfdslUgfcYokhNtQw6eiE315RzNMUFxJ7?=
 =?us-ascii?Q?itff93SC6H5+PK58osnYQvPe+jBca6Tb/zXC9UbJr4NOeWhMvMX9WysJ0pUa?=
 =?us-ascii?Q?2t5daYk5EA3DIBRVlqMafrvlMYiUmDSViHU5aQ5dOKPmiwqWC1zWEqsr+CI2?=
 =?us-ascii?Q?WAMZa7yi+N/lADT1NobCb5mGu4Un4/AhA8eh5bBZ0dgAOXpetvMO6oFNja4O?=
 =?us-ascii?Q?mP0Q5QMCT+SpXzT/QGz6WyWHH5FmbtcRPU+XDdUa9F2wPlACJ0m9mbLG21b2?=
 =?us-ascii?Q?6X9mXBUnLvfI2ToGLrbjehWbD80lbJDlT1VdVMs8YSeY679CM4tyBv7CXv+b?=
 =?us-ascii?Q?4ZtdtlJ0fdINFKHNWWsb8odfsgkwyYtNQK06ScqrCFfDUl2rfd4rLkRQhB/g?=
 =?us-ascii?Q?cjr8DCbaHJjE173KarIdvx+Zb5cbbDo78iImLwdS2W1K9Ka0306quLIXrVDY?=
 =?us-ascii?Q?iuR9mVFkK/q1TnovFY6Bc/mn/c4W6ADIt4hojPowTNhf7LsDB9835vmfwWg/?=
 =?us-ascii?Q?a3zNHw1dPHRurofCGpUjkHpnlIBesl8fLIfRizHOeTiqXjDOI0HYlonn+hyf?=
 =?us-ascii?Q?5ww6SZOVs4LJ5hAhpj8k/Kw9+W6MeiEJY8jYGYP9RrLszpdBWQtsb4iJ5JLk?=
 =?us-ascii?Q?7LpWSPcagc0r6Tehdp+Wjw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b62405aa-eb81-40d0-f47b-08dbbe165af9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:25:42.8948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/qHjQVgs40cgabgF7xA8FfTuHLPGQtz7EhOhqnUnGOOZbwcIGKJyxH1+J69angkK7Ny2KoKTLZPhxwO2Ss/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=576 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250172
X-Proofpoint-ORIG-GUID: mGt3tDjxmUyJ_pd6jv_mz4lN_ms9AOWU
X-Proofpoint-GUID: mGt3tDjxmUyJ_pd6jv_mz4lN_ms9AOWU
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 16:28, riel@surriel.com wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Malloc libraries, like jemalloc and tcalloc, take decisions on when
> to call madvise independently from the code in the main application.
> 
> This sometimes results in the application page faulting on an address,
> right after the malloc library has shot down the backing memory with
> MADV_DONTNEED.
> 
> Usually this is harmless, because we always have some 4kB pages
> sitting around to satisfy a page fault. However, with hugetlbfs
> systems often allocate only the exact number of huge pages that
> the application wants.
> 
> Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
> any lock taken on the page fault path, which can open up the following
> race condition:
> 
>        CPU 1                            CPU 2
> 
>        MADV_DONTNEED
>        unmap page
>        shoot down TLB entry
>                                        page fault
>                                        fail to allocate a huge page
>                                        killed with SIGBUS
>        free page
> 
> Fix that race by pulling the locking from __unmap_hugepage_final_range
> into helper functions called from zap_page_range_single. This ensures
> page faults stay locked out of the MADV_DONTNEED VMA until the
> huge pages have actually been freed.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  include/linux/hugetlb.h | 35 +++++++++++++++++++++++++++++++++--
>  mm/hugetlb.c            | 20 +++++++++++---------
>  mm/memory.c             |  7 +++----
>  3 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 694928fa06a3..d9ec500cfef9 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -139,7 +139,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
>  void unmap_hugepage_range(struct vm_area_struct *,
>  			  unsigned long, unsigned long, struct page *,
>  			  zap_flags_t);
> -void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> +void __unmap_hugepage_range(struct mmu_gather *tlb,
>  			  struct vm_area_struct *vma,
>  			  unsigned long start, unsigned long end,
>  			  struct page *ref_page, zap_flags_t zap_flags);
> @@ -246,6 +246,25 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
>  void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
>  				unsigned long *start, unsigned long *end);
>  
> +extern void __hugetlb_zap_begin(struct vm_area_struct *vma,
> +				unsigned long *begin, unsigned long *end);
> +extern void __hugetlb_zap_end(struct vm_area_struct *vma,
> +			      struct zap_details *details);
> +
> +static inline void hugetlb_zap_begin(struct vm_area_struct *vma,
> +				     unsigned long *start, unsigned long *end)
> +{
> +	if (is_vm_hugetlb_page(vma))
> +		__hugetlb_zap_begin(vma, start, end);
> +}
> +
> +static inline void hugetlb_zap_end(struct vm_area_struct *vma,
> +				   struct zap_details *details)
> +{
> +	if (is_vm_hugetlb_page(vma))
> +		__hugetlb_zap_end(vma, details);
> +}
> +
>  void hugetlb_vma_lock_read(struct vm_area_struct *vma);
>  void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
>  void hugetlb_vma_lock_write(struct vm_area_struct *vma);
> @@ -297,6 +316,18 @@ static inline void adjust_range_if_pmd_sharing_possible(
>  {
>  }
>  
> +static inline void hugetlb_zap_begin(
> +				struct vm_area_struct *vma,
> +				unsigned long *start, unsigned long *end)
> +{
> +}
> +
> +static inline void hugetlb_zap_end(
> +				struct vm_area_struct *vma,
> +				struct zap_details *details)
> +{
> +}
> +
>  static inline struct page *hugetlb_follow_page_mask(
>      struct vm_area_struct *vma, unsigned long address, unsigned int flags,
>      unsigned int *page_mask)
> @@ -442,7 +473,7 @@ static inline long hugetlb_change_protection(
>  	return 0;
>  }
>  
> -static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> +static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
>  			struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end, struct page *ref_page,
>  			zap_flags_t zap_flags)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e859fba5bc7d..5f8b82e902a8 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5306,9 +5306,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>  	return len + old_addr - old_end;
>  }
>  
> -static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> -				   unsigned long start, unsigned long end,
> -				   struct page *ref_page, zap_flags_t zap_flags)
> +void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +			    unsigned long start, unsigned long end,
> +			    struct page *ref_page, zap_flags_t zap_flags)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	unsigned long address;
> @@ -5435,16 +5435,18 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
>  		tlb_flush_mmu_tlbonly(tlb);
>  }
>  
> -void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> -			  struct vm_area_struct *vma, unsigned long start,
> -			  unsigned long end, struct page *ref_page,
> -			  zap_flags_t zap_flags)
> +void __hugetlb_zap_begin(struct vm_area_struct *vma,
> +			 unsigned long *start, unsigned long *end)
>  {
> +	adjust_range_if_pmd_sharing_possible(vma, start, end);
>  	hugetlb_vma_lock_write(vma);
>  	i_mmap_lock_write(vma->vm_file->f_mapping);
> +}

__unmap_hugepage_range_final() was called from unmap_single_vma.
unmap_single_vma has two callers, zap_page_range_single and unmap_vmas.

When the locking was moved into hugetlb_zap_begin, it was only added to the
zap_page_range_single call path.  Calls from unmap_vmas are missing the
locking.
-- 
Mike Kravetz



>  
> -	/* mmu notification performed in caller */
> -	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
> +void __hugetlb_zap_end(struct vm_area_struct *vma,
> +		       struct zap_details *details)
> +{
> +	zap_flags_t zap_flags = details ? details->zap_flags : 0;
>  
>  	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
>  		/*
> diff --git a/mm/memory.c b/mm/memory.c
> index 6c264d2f969c..a07ae3b60530 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1683,7 +1683,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  			if (vma->vm_file) {
>  				zap_flags_t zap_flags = details ?
>  				    details->zap_flags : 0;
> -				__unmap_hugepage_range_final(tlb, vma, start, end,
> +				__unmap_hugepage_range(tlb, vma, start, end,
>  							     NULL, zap_flags);
>  			}
>  		} else
> @@ -1753,9 +1753,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>  	lru_add_drain();
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
>  				address, end);
> -	if (is_vm_hugetlb_page(vma))
> -		adjust_range_if_pmd_sharing_possible(vma, &range.start,
> -						     &range.end);
> +	hugetlb_zap_begin(vma, &range.start, &range.end);
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
>  	update_hiwater_rss(vma->vm_mm);
>  	mmu_notifier_invalidate_range_start(&range);
> @@ -1766,6 +1764,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>  	unmap_single_vma(&tlb, vma, address, end, details, false);
>  	mmu_notifier_invalidate_range_end(&range);
>  	tlb_finish_mmu(&tlb);
> +	hugetlb_zap_end(vma, details);
>  }
>  
>  /**
> -- 
> 2.41.0
> 
