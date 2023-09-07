Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB148797C15
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344209AbjIGSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235856AbjIGSj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:39:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E685C4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:39:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387IF3W5014152;
        Thu, 7 Sep 2023 18:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ejS1mAkoM4KCZEWFqQfdXK4z8VDZe/OZfJZfVsKb6N4=;
 b=NMvJDLaFXMjB8l6gb7zkP0etM9r5CeWmXSvbtWyKIooZWSb6fuzlh9vxlmU7Cp1fmF/l
 ioTuuSw7vuk3E023E/iNmJ6iZiKB5doR6c+ucFvAVQ+MRXUiukBFGIrjhXnsQCRWKXQm
 I+DOY9LjAt0SYG9C2DV4F8xYDcyTVPT8I6aPSgWdB2zgQS2mm80gEFRR3V3X3mkQbJO0
 8uipbbRzjetaalSxetLt8l3hPRBUIkxFuokLfHQTp9DWik8PzmjtWLda5Vu6VOw87K0b
 xRJly1ucP3Zm9sR1kvrtBspb8zO/OyfmzlOMSOXz20nEG2he0bZtxCCg/iuiKx73dR2i mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sykmn01gs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:38:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387HFvlF031082;
        Thu, 7 Sep 2023 18:25:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug8jec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 18:25:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0h0QdIeMpzgFXOAngpkGNR1RL/+ynDf0IAj1eXnL9462bjbgpm16PS1drlqgio3FdyR2/wj5cRSnI0jwvEXrPSIAygdKE7phFfPg31r4SROBKZ+TWjzBM5ajt+ygTEUZveu7e+shbeAIvIMPbvuYmXCS9od+WJEJd9GNfghYic9ZHPXoNEDQPiF3M2E0dLLPixUhgmv3WWslkX6a7E75W9zUJlXl+AjxpyOT8j1vGZptVrDre+zCH5uka9hNVgqR7c+it2edYtKqrXl9QTcuXXTOo7ctUMbI8ESOfk6E0PZL7ds2vhhjuJzAm74izGHV9UAMX5HGXGPZ6caZXWK7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejS1mAkoM4KCZEWFqQfdXK4z8VDZe/OZfJZfVsKb6N4=;
 b=c6QQmNdtVq5lnuaKwW8DMW6CnmKEBedE23Y37KVBu/hwhmoWF2JsK7xez/PSDgWyfx+bMST4wjDjvFFg/uYuUZz23RFERD6IYbJjf+y3zlIHqHmVRtBR0xKeN4MzyssyaV9A05LAttMmDKxuwLRUm1jnzSx93JWRcFELckaoDo6P3+vtVupNZKqrVcZy3CNCYpcacQuVO+L8O+ClG/vPeF8GVfC8J7+SPudv4GGRqXFNfftIPFdfOPQWUPbZlwR90y79zjiSWjh+FRQIEMO/w/1KtuaDK3zhVQWQFP9cWoxDlBjLBhbL6aeAy4mQ49Bta7+/RQgnAzICxN43FRZiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejS1mAkoM4KCZEWFqQfdXK4z8VDZe/OZfJZfVsKb6N4=;
 b=qPkr0E2IyyXBXep1sfCCjOMjCTnphPtpHOslKhg6gVqz64Z7EHszki0fbCCJ5/fRzTGgpmuHhwgO73dOENf6Jpr06EkuJW5/rM/wkrLR3py46tte80r1snwC8dx70QKjC6ic9cT2K26X4ba9M3sK++A0bZZ0sBgOySaWbjmQuF4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Thu, 7 Sep
 2023 18:24:58 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 18:24:58 +0000
Date:   Thu, 7 Sep 2023 11:24:56 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, rppt@kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [External] Re: [v4 4/4] mm: hugetlb: Skip initialization of
 gigantic tail struct pages if freed by HVO
Message-ID: <20230907182456.GA3640@monkey>
References: <20230906112605.2286994-1-usama.arif@bytedance.com>
 <20230906112605.2286994-5-usama.arif@bytedance.com>
 <20230906181016.GA3612@monkey>
 <57c8dd7f-d1a0-37c4-1d3b-d6374e92ffa1@bytedance.com>
 <20230906215927.GE3612@monkey>
 <92fc88ba-3e3a-2648-4232-1d3f9bed5bb6@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fc88ba-3e3a-2648-4232-1d3f9bed5bb6@bytedance.com>
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 10beb58b-8bb7-429a-df47-08dbafcfbdc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bMgEl2gyOUBWXyG8KDxmLC9k9NhvT1ILCzSSx6wZ1Z/6ZQpwaB21fa/isqE4DueHsbDsldF1wcPvCKtRjyPAOo3v6lpxQNQnFJBJ8BCKFe4RlgE28iZQ9ezctTzjPxhOTqUjSAalGooMTOlLRvVPIQQpCN7UFLgUNEZHbosdGN0ZQJNfzWdjw9s9aCuITITBUuWEaVo5IRA0J0Zyfy/wYD+FfvWLCNcuriTj0TeEqcF58WyjIC7XKsZPekt/KMRMHfE7aD8aoooViBaOgJRgxz+k60t8PbEMlzkcF3wMU8Wn8J4TeQZ+aJ+I4e6s7lyCWbxkCTsh6yC/+0Mdoj1YDm4OB97WRHCQ4EjwKMSg8jdR2TLsX56vIW+ws7Jpvyy4fQUziQv/kcjaaxgXKcdHSTK1JgJYQ2Ff3Zpcqr5A8I6QSWMIsvTaZDbvNrZYUkV02gpR7iGEbfO7KIPN0uzIzDVm4x0zCiQRiay3exHCMPrhZsOtaU55Zo8xqZG2N9ezWAlH9vhFgaUVtakopBPEKy5U3W46lbj6SgJSv7djfULNpHfPU5p+RTH9kVs+djg2Xjg2BN+i+BO1HjGrDHDFmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(376002)(136003)(366004)(39860400002)(396003)(186009)(451199024)(1800799009)(6916009)(316002)(66946007)(66476007)(66556008)(41300700001)(478600001)(966005)(33716001)(38100700002)(2906002)(86362001)(44832011)(5660300002)(4326008)(8676002)(8936002)(33656002)(26005)(6506007)(6486002)(6512007)(53546011)(9686003)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gl4y3vt38NCpPJgvxqFjq9yX7/XvHZ/tcgxtBnuf7izQW674t7Bqt5iWQLn8?=
 =?us-ascii?Q?F+93R6NDWb+l03q9HuAHCDdGsWU/THJqbF/Dnmqwil6QeNkNG24QWEvYRYWu?=
 =?us-ascii?Q?zh3oIaqalL2TobuobUmUMxZqvo6ap3eSl3IYkb+6ataucCOn5qJQJfm1odKM?=
 =?us-ascii?Q?QSKNtcC24V1YxGK/j9L+TbTAeVpedSJrpgi2kOG9ocXKptss+ARTckAPK/xl?=
 =?us-ascii?Q?NVA8rvzqgnhL8sJ6vsz5MgYYPXw1Q7nmlEg7UfGKSmBHXoNDnzbC+r9iaNdy?=
 =?us-ascii?Q?SC4njCErb9XKgvoSdThJxK0MOFUzmTssyi/Glzt1zbTgUDMICq0j0rv+31kb?=
 =?us-ascii?Q?xkyCNskjN9DVvu4IIqDI+F+6sxPyHWo40F+dmwyTKIo+ngqguTsL/1Dhp1zr?=
 =?us-ascii?Q?u6w3R9sp6GaRU+pvDm7t6Ai2SSSgj1+0+lUHqi0W2CW3eiwFk8awKMfLNCIh?=
 =?us-ascii?Q?9bv2nOWLJpuXeDW4D3nUh5e6Qcs9OcR2xPZ1S+Xmme0hHNMpmFT3FBpiVvFW?=
 =?us-ascii?Q?67OwcP113XGru4OEkchrIz9OgY1rOCgk11wyTKskseJQSso6vYfM0bxYLYUq?=
 =?us-ascii?Q?3gf0JkyTxffO15uFzc/3iGbosdezvoTG4A1DhMK3gaY9a6rzBB4LYK0GHnsW?=
 =?us-ascii?Q?zFQ/XZFtgDpY8OvJz/ANQOcPJOHEAjsrkYDh95ROqkaebjQ948VtkjeTSrs2?=
 =?us-ascii?Q?fIJs+5r14XjYaBr0kpBCN+3LxxDzwq5ifpbtV9YzNVqOdjaVtuZMhL7/l5H9?=
 =?us-ascii?Q?M/NPWhFTvccn1rJMulyGmYeBd+hBxVCMKjDI03psWdVdgRljtsjTKqBEJLbb?=
 =?us-ascii?Q?3kXpQmC4zX6ROpFltUBP+Qe9YrH/aNnWYb1HbG0QXFuSyR8r+HS+wIm5eM17?=
 =?us-ascii?Q?94blIMF2/ikUlDsicOvLl32/2l4cu4gNN+oKMNWr2TKrZjPH1o+SJtfVpXAt?=
 =?us-ascii?Q?xyTLhBMsOMaECnS+JH3A+ekLaAQS5cQpy1LqSVVVhf6uEPHbq3XbvWiNeQ2I?=
 =?us-ascii?Q?ldRHleqjs7jW2Miph5DrrLQcXHGE8gHYtrXs6Zu5N5wM2cl5rBWCcZolGZQK?=
 =?us-ascii?Q?PNI4XowgQGj7JN6nimn6hbPFPUKZgef3vzVcWySfcRz+3RYSgBVlKus/GzMn?=
 =?us-ascii?Q?t3vuk2CwVJujiRtePq1Dl7AFC2uz7zwHJfAOu3OupkNDe1bqslkDwDzdZ1Pa?=
 =?us-ascii?Q?GK+Dj57NGCoI2s6JZ45PmxpglxhGaPokYh/g7xRDPL7mIrTrfTJYova8t+LG?=
 =?us-ascii?Q?B+sA4xKoHnmy7bDC7LzsFt/frr41avLFKuObj4TaWhjkOlN/RYeKjLK4w3wP?=
 =?us-ascii?Q?tdnJbZpD07R1+i2VKJcUTpbvetkvTADnedeiwkizCCjyG7WdzHkj7hCqN7oe?=
 =?us-ascii?Q?alWo7Mwa1OkgvVfYJ9UzHmYcW1XB/SPZMpDMPSJyQ/+YovoqXtdw7IKdcc/T?=
 =?us-ascii?Q?fecZ7+h60mmuJidtTUVPgyG+zH1BYy+97OqfORYbg6Cxuxe44nQd16L5o15k?=
 =?us-ascii?Q?tkwqaVX/HrR5WoDFCnQjtVTk+wNUFO9j5XdViu8yzTUYkSWePutaFlWX7W8n?=
 =?us-ascii?Q?rrE9H5qN9hkfybKDnAhLbmeqEHLs9szbic2hSilM2setvAT+Z9Mc3rXt/xDS?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rJI6Mt6h52sGiakaadjQ4MRWroGp45zgTONa8K3bl9C4ygeGbG9A9fg33OV5DQ6SiA1DVQfvH0PzPFa0zKayOLAHhq+wkAdkS243yOiytqLegx71ygPmg5MkQzP4O2G96LhTr9c0EBGp9wS0c0SYhWdt0Z/W6HlIVAZihT6cabKeMqTib3WOJdacbX/kqI4odZxw2kyc0q7VdrUl8Yibq9hACjzkAmOgB1WXpHj7AsZOuuETpsQCuAG/HEtlPECH6ksbLf7Cla5b47vKXq2yMGUZkKg4m36as8BxHTQck++UUimNpi21AQZvIVNJ7htpD2N+Ye9szBa92AL4SLE0R1LQKOWaWllT2263bRjqdzRjpVPz949h38klX2ZLGbEXjXKTlj19NjWjo/zd/5yvfkyUyxIxCynBYK4q9tmdqUNx5RE1+f6a3wuR1ibvUEwsXHdV5FfCVGdG1xseU/Uko9Mcg7P9akApC2fRasT95HessHajU4UVlUvV5ineKBYCf3VfKlPmuriJibjXMhYEVMJrVQoEPH9rso315H9Aew14/h5iT8y8Fr9+Lbc0lOLBUfwCjUUl6QYrwQY/5Nf66Kp1ZiGADiHPq89uXsRWJqJonCds9i6j3rxXg6O20lnINtcMPwpJLlgmSvxtAigKKuP2/LyRmUvBTJnv0bzBBJbRk6YD5zrdN0y7v5SqeT62kwMu6ZY+kBuYdAQQ5JHLscSXJGBNxZ9ibF+Sg3Tevb5lr0hbEzsoXnQ9dCpLAM74r6h3oZtMwT4UkecHGNDNW49jQ0rztwhc29Lk7EtLhDDFg0QmO/3IQXJKNsrDrCgv03KRzr1Jw7KH4VxSloQCASse2sahgUhP3zuKvuT3FZCRs/+oytsbYEdZUWDM2FS7/mfXWa0OaEDrPgvOyfgsymbzdRbY0GZNRwQAuT5cp0c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10beb58b-8bb7-429a-df47-08dbafcfbdc8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 18:24:58.3333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xvEvrAX6KWLqMq0ziz8T2Z3vNt19xmeYUt4ZiGIPwEGYFa+5FjjOYIqkVCXuUkaVmHLnkueTi8IqKRd0i5QWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070162
X-Proofpoint-GUID: HC-caxKN6EK7ZhmkgxnaDUT5QbQ2l4aM
X-Proofpoint-ORIG-GUID: HC-caxKN6EK7ZhmkgxnaDUT5QbQ2l4aM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/23 11:14, Usama Arif wrote:
> 
> 
> On 06/09/2023 22:59, Mike Kravetz wrote:
> > On 09/06/23 22:27, Usama Arif wrote:
> > > 
> > > 
> > > On 06/09/2023 19:10, Mike Kravetz wrote:
> > > > On 09/06/23 12:26, Usama Arif wrote:
> > > > > The new boot flow when it comes to initialization of gigantic pages
> > > > > is as follows:
> > > > > - At boot time, for a gigantic page during __alloc_bootmem_hugepage,
> > > > > the region after the first struct page is marked as noinit.
> > > > > - This results in only the first struct page to be
> > > > > initialized in reserve_bootmem_region. As the tail struct pages are
> > > > > not initialized at this point, there can be a significant saving
> > > > > in boot time if HVO succeeds later on.
> > > > > - Later on in the boot, the head page is prepped and the first
> > > > > HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page) - 1 tail struct pages
> > > > > are initialized.
> > > > > - HVO is attempted. If it is not successful, then the rest of the
> > > > > tail struct pages are initialized. If it is successful, no more
> > > > > tail struct pages need to be initialized saving significant boot time.
> > > > 
> > > > Code looks reasonable.  Quick question.
> > > > 
> > > > On systems where HVO is disabled, we will still go through this new boot
> > > > flow and init hugetlb tail pages later in boot (gather_bootmem_prealloc).
> > > > Correct?
> > > > If yes, will there be a noticeable change in performance from the current
> > > > flow with HVO disabled?  My concern would be allocating a large number of
> > > > gigantic pages at boot (TB or more).
> > > > 
> > > 
> > > Thanks for the review.
> > > 
> > > The patch moves the initialization of struct pages backing hugepage from
> > > reserve_bootmem_region to a bit later on in the boot to
> > > gather_bootmem_prealloc. When HVO is disabled, there will be no difference
> > > in time taken to boot with or without this patch series, as 262144 struct
> > > pages per gigantic page (for x86) are still going to be initialized, just in
> > > a different place.
> > 
> > I seem to recall that 'normal' deferred struct page initialization was
> > done in parallel as the result of these series:
> > https://lore.kernel.org/linux-mm/20171013173214.27300-1-pasha.tatashin@oracle.com/
> > https://lore.kernel.org/linux-mm/20200527173608.2885243-1-daniel.m.jordan@oracle.com/#t
> > and perhaps others.
> > 
> > My thought is that we lose that parallel initialization when it is being
> > done as part of hugetlb fall back initialization.
> > 
> > Does that make sense?  Or am I missing something?  I do not have any proof
> > that things will be slower.  That is just something I was thinking about.
> 
> The patches for deferring struct page initialization did not cover the
> struct pages for gigantic pages.
> 
> With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the function call taken
> during boot without these patches is:
> 
> [A1] mm_core_init-> mem_init-> memblock_free_all->
> free_low_memory_core_early-> memmap_init_reserved_pages->
> reserve_bootmem_region-> initialize *all* struct pages of a gigantic page
> serially (DEFERRED_STRUCT_PAGE_INIT is enabled).
> The pfn of the struct pages > NODE_DATA(nid)->first_deferred_pfn which means
> this cannot be deferred.

Thank you very much!
I am not very familiar with the init process and just wanted to make sure that
no possible performance regression was introduced.

In will make some specific comments on the patch, but as previously stated it
looks pretty good.

-- 
Mike Kravetz

> then later on in the boot:
> 
> [A2] hugetlb_init-> gather_bootmem_prealloc-> prep_compound_gigantic_folio->
> prepare *all* the struct pages to be part of a gigantic page (freezing page
> ref count, setting compound head, etc for all struct pages)
> 
> With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the function call taken
> during boot with these patches is:
> 
> [B1] mm_core_init->...reserve_bootmem_region-> initialize head struct page
> only.
> 
> then later on in the boot:
> 
> [B2] hugetlb_init-> gather_bootmem_prealloc-> [B21] initialize only 64 tail
> struct pages if HVO passes. [B22] If HVO fails initialize all tail struct
> pages.
> 
> 
> Each of A1, A2 and B22 are for loops going over 262144 struct pages per
> hugepage. So without these patches, the work done is 262144*2 (A1+A2) per
> hugepage during boot, even with CONFIG_DEFERRED_STRUCT_PAGE_INIT as its not
> deferred. With these patches, the work done is either 1 + 64 (B1+B21) if HVO
> is enabled or 1 + 262144 (B1+B22) if HVO is disabled.
> 
> With CONFIG_DEFERRED_STRUCT_PAGE_INIT enabled, the times taken to boot till
> init process when allocating 500 1G hugeppages are:
> - with these patches, HVO enabled: 1.32 seconds [B1 + B21]
> - with patches, HVO disabled: 2.15 seconds [B1 + B22]
> - without patches, HVO enabled: 3.90  seconds [A1 + A2 + HVO]
> - without patches, HVO disabled: 3.58 seconds [A1 + A2]
