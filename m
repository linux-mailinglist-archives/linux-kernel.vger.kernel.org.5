Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3391C75FF70
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGXTAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjGXS7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:59:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA1188
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:59:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFNwGl009786;
        Mon, 24 Jul 2023 18:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ojT+BkALO3jemNU2AXbbVEQvjcOm47X0Bqr0I4x3wcs=;
 b=r2SxuTfajFTXpuRq3ck25+W5qTEGKl+iGc4uWv30tcvEzBC9splTjUYncvlk7rhkOZ1+
 nAXxLamG/jmcR/I0SBNYDwIjt+8drH5VEERsc/1+QCEfRYDxp8v6PCe1uMjxEc9Zb8HC
 90hV74DhkgIbzk0UDDQ+1RGAZQBf09mOaWBq5XjDoGmN/1xR5TcYEym6lPkFUIJkpI/h
 LV3h2HacJerw345kKZv7HJoGdomU75v3WB9kv68IxZVFzAa9dGTNeHJ0v7Ud1JQlENtN
 tGn9YTtRZZzi54UdyuX12+tQ5NuSccJSu0nEy3oteSIJAW60gSFvUI44rPByA/OSuexY uw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtufyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:59:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OIl0Gj003916;
        Mon, 24 Jul 2023 18:59:07 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3tmhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 18:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWTPzJpH243weN8kWp6XQOryQVvEQrSmQJB28HZ14qPDZlq+7CNI3MKDSyChPRu2vr/hRTgN6PbBw21I5NnnzrUGeGyTcjqdfCZHMAO70pbJ1xktYOMaJfIcsfL3NPTe8S2Ci4QnFid2X6bkZfyQHs0OKFao3QxHREwj+icz6L0zNiyO3lzQcAFf1Dagky5rTUeOO30uxbTbrZBBjC7IOhIogRpVWeMFLu6uwrqBzzV2RWl0LPVSLQYPSz0tzNIpSI9WQ5/KaAu/pJz2xqWGfL4e27MGXvdj2oTOiz+zME+E8wQ9bRsghPUKwL0VtSncsdpshHqBRBdx960yivjBrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojT+BkALO3jemNU2AXbbVEQvjcOm47X0Bqr0I4x3wcs=;
 b=RqS++a7T122XNItHAYVLIpnRq6yyeES113FXUlXlaAp+fv2AayqHvx99gKJnrBCGt1iUSTlAbILjseZ2WE0DeDSKVuYQYxMrDz92HoXDjIqZFOL/4H0T+M7nsnBXLRt0lAJG3tmLyP1eQn8p4ISZRawOJAqWd/UCkBsea5rQhLmtQ2Yd5qqoCVTxrSZh50uIGGRTl/+JumC9yH5griYnAyrHHtoB9AexWS7sEPQfv689dKwjA7MMhnjgFWfBTqvGeamOmw9LlXMXhy1mLGgsHy0eIGlD9T07nYcKG05mjSQ3MJjS2jcqXdgG8hNlzXDPLJKhemCvs8EvzxoQcBRU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojT+BkALO3jemNU2AXbbVEQvjcOm47X0Bqr0I4x3wcs=;
 b=DzSYid+xFXOkbm3FhQgNiUO2HdB63fDevCktSRUVutKF32tBJAO4k97FJMRS3uwLaBsEwOdUcA/sQb1FQAEm2woz0rBST3heNYpghg/F4LgAB6sPRWjG3bmilW6XDh+XQmhWziMY78CoWpdh1Is3FrojWOdt9exVcA+8J30UAts=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4200.namprd10.prod.outlook.com (2603:10b6:610:a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 18:59:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dcb0:4077:f404:210c]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dcb0:4077:f404:210c%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 18:59:04 +0000
Date:   Mon, 24 Jul 2023 11:59:00 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linke Li <lilinke99@foxmail.com>, linux-mm@kvack.org,
        muchun.song@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, dan.carpenter@linaro.org,
        Linke Li <lilinke99@gmail.com>
Subject: Re: [PATCH v3] hugetlbfs: Fix integer overflow check in
 hugetlbfs_file_mmap()
Message-ID: <20230724185900.GA3240@monkey>
References: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
 <ZL30Vaj8RYxmsF9o@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL30Vaj8RYxmsF9o@casper.infradead.org>
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb1e1e5-6941-4bec-da2e-08db8c780c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yo73/WWqAfa9AjF/NAnCRTsYrD3VM8J7znbIKXBfQkZYLPrfarfPtonGqn9NgpV7/ThM/guZZuS0JkSBhFzsALJukkV11bvaJcO4WhqwHuCP9efDac8WVUgaa77J+E7iFg1+me9z7zbv86fOmLQCHxVUdzu3+kNM8g673PWdFjhGxM3hAK2QaQ+Jy6F1PCH6yrxnS2EHLtYHlW6oe2/bTFkBJQaH6HbC4HZMC8hBAAKl3DY7DPLHpXDOmzEWcoyFk/kR4GxKLjvgaR5C2jcru4a9HfU0adk+yQWjwgcL8zfaytkr9WaLXq4lfUM95uXtpwGAbjd89DjyLRSh34He1rsNHmw1+W3X9lmpqgH/f0SXVxv47hp7CzmFTMPYS4RR90MkHViz7V8hGqbotkWIf7WDJfZKeoEeZQzd8sYCvJpmQ9lVMQGazul0Hb0w2roxFMHVOxQSK0MB/U4wjP9xf2iEt3T2ghl3MeSpFGWXf5o+L+07ZQWD65vZzjIGOiy7Up/lhJLC8T6873NQMsSUGv1NOipTaKyDdYygULZEy3uaOQDHf4LPhke4LxXhGjo1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(33656002)(33716001)(86362001)(38100700002)(66556008)(4326008)(66476007)(316002)(6916009)(478600001)(54906003)(41300700001)(66946007)(5660300002)(44832011)(7416002)(8936002)(8676002)(6512007)(6486002)(9686003)(6666004)(2906002)(26005)(1076003)(186003)(6506007)(83380400001)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dXcLTlOFRGaapnNEe89BHZbC0B4xZXfoA5XEkNvF0+kZa2X42QvPkSGu3NVa?=
 =?us-ascii?Q?lx9T7PWwt7Q+2GbGdpkg1kBzLwCfCGvjfGSJLvu6ot8Zm5kEdCP3YvKvIQlT?=
 =?us-ascii?Q?I+C4DGrcOoHKf0hCWaV4WPS5LvwKx8R/u7Zb4wJA69eINYXLVfhmY1YXTFbf?=
 =?us-ascii?Q?5e0xhHIJq2YTvd4qJ8IhSWnZuSx7m6jdfJJe4esCCDeqGILpE1SAfBIHPCSb?=
 =?us-ascii?Q?VN18uJ75v3PbuqcfOxdlVlbIcxw1n+BH4xUXMk3iOWr3DcWwPpVMbIZW48MA?=
 =?us-ascii?Q?dOpf0VCEQrAGWpQt5sbiFmcduZojy1LFSefyPgsFTtVfjDcuKRADS0f+sX6/?=
 =?us-ascii?Q?b3gWBbmMavzTtZ+yhhDaJ/qjDNUr1+LNv7b8S8PeDaiuj2jdGvW1bqxANOiE?=
 =?us-ascii?Q?4o6MG9nM85dviu8FvG8OXC5+jIbbeK2P0LFj3AucbopIcndXM2gIKRdB3GtP?=
 =?us-ascii?Q?6Mbb8lc2QJEwehK8BH/BevHHBaCOANkz7SMr80YlSPDVyrYtOsY2D2liTxa9?=
 =?us-ascii?Q?P9fJVt5+U2OwjQbXz0bBAJ5O0QBByZAmJYvjKN3l3wE8zJoLdv/KNb3Bew4/?=
 =?us-ascii?Q?6fY7ECMRoGi0BHczhxgH3Rpt+HxcKBzC/0Z67rZqKB3QTCcSCJlokVLIQPru?=
 =?us-ascii?Q?vMqcFKcRpT9Xz6GMHHVPUkptOq+IgDzhIyNTcvjTnIJsBVMzY8Wp1Zx57TYh?=
 =?us-ascii?Q?HDxABkutb2PdmzdyQT6RDm21I0jPZFBvYDWcC1D95GMpwfn1Chn9pTTAn9+N?=
 =?us-ascii?Q?W96J/XJa0nowVDj5BSSqYMRVKdmU3NfAF730MAnFmQPR0nzTDiI3u4Tx4ljO?=
 =?us-ascii?Q?2OzCR3LoBy7Dk59I4LPm3sIttNHX4dA0lh/DgKElR8u9ABFuKLaT35GkRTpb?=
 =?us-ascii?Q?Yk9wvBdG9QvL/fO00f0YleZmMQpXKYlPhIn0QsIOS8Ze6vh47MCrgE2RsTZq?=
 =?us-ascii?Q?TNwg2lDq9zMuDuRmCdyuqDB9EblHyscLyGcsqsPq6YeKKwi+RDdpUhw5IZDY?=
 =?us-ascii?Q?CeM0EkmP54fmfRyRftG/JkOuiHlOdTsPh5dLfC6FzU8t/zkd92dZi3xuu3rq?=
 =?us-ascii?Q?uzOQfK+yifzhAvlAF9kWs0yWmyga/lR4ReXtLwAmRnaGCpf/fBo1w2hSKKXJ?=
 =?us-ascii?Q?N+ixTozZBvhWCb5z2zpKsk15RGjCrUfbMEP9SpJqQTGuxkdvf3GGYgiGMrGZ?=
 =?us-ascii?Q?FAQo2VJiXiiv+VYWNJHprtlT2xOlH68DxVqukiYRCVYI52vqmrCln3GEGy/e?=
 =?us-ascii?Q?ghQSOJP0gKT0+C+Bqr5XvbYY/xeWwEe2Z5UDxfS1OoTbdzFPd0HfPJxcEN/G?=
 =?us-ascii?Q?JXStNMe3LN9bVqqQ5bQxjFNFnXRZJeP+HrzMQC9z+OJxlZqcHDdWYTiovO0T?=
 =?us-ascii?Q?6012cqMNz/otJJibGBLzQ+cepJx4WwFuCSV4/0yQ7Pffd494as/6/xT9B0HL?=
 =?us-ascii?Q?XXnqhPR5vRqf8CKUobr0uYE89/SGLGiGpc1BYrz7LedKlFXazTfxbQc1xWab?=
 =?us-ascii?Q?zZoaypcWRtJkJ/PBXoLqfVHtQiSZvNysGFwTaWBaBP77xfxSCHVGrgxYxyeC?=
 =?us-ascii?Q?WazwZBvwfapcNgfu9FWYBD7xQp6fxvwf8Dr7lSDL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?0//bf8rMehuV/AnfIt4BRCYeQis6i2VtmstL6SnPKIFo58iV+hnx79OBvLLO?=
 =?us-ascii?Q?1sH/RVRtr5Q7xol0mt0UCbritXgz1ub8Q7YiNC2S5BpXP+ils17UFXl386SJ?=
 =?us-ascii?Q?/6mVgsPpxJunGIwKYf+7gboREO+yecMmUJkDwkVCORLQZj/kSr+n93vCBHqg?=
 =?us-ascii?Q?Hg94hSdrgjpvACzoWCs8NES8it3U/tuNBt1xgM8HHbCg0smYqVig6mzaXdsx?=
 =?us-ascii?Q?llnLPgOOl1moipIOesR0+BN6ztWhR+Ii3vq+TcIbvmFqvfFUHHmKYyd9ulUv?=
 =?us-ascii?Q?fbaSYeWXxn5BQdhr+lUPVscY+98vOE3HdfTWs4uRDlK5vXqdnzAPQBQZVzuJ?=
 =?us-ascii?Q?TXjnmyxBX3Zj4I7ZIV4jEu8HLK8SoyeSR63oBOtL7RfkOFoBeKJMH6DsEajO?=
 =?us-ascii?Q?D7Z3NMlm8xt2HGN3PPJfFP/hLeITN9NGoZ56lUahYoQRj/eBGkd1fN3gwo4n?=
 =?us-ascii?Q?ceghvsTN3ll0KHcdeGWX17zJh6jf/AlLJaL57V9+bxBbUkh8b12Q3YGCjevJ?=
 =?us-ascii?Q?iSkCSGPqwuPOJO/J0mISqtPvtTJRBvKJC34BfJDp+MgrT0QnJ4W4uO/mOBIp?=
 =?us-ascii?Q?PDG/55spaUNsiFiDBV7tf+LH6zjFib9fWO/4M6klHpinDRp/RK3P+R/1Xznk?=
 =?us-ascii?Q?vz+betbPdinIctUvB/ysFu1TGTffgfRGnJFE+dO0byVxcWiDTHBghh3ipIlp?=
 =?us-ascii?Q?i9fw3DKHE36xr7/3fcgUIqAbp+msJzFi2FQaE1SVUamzWLM+JRO6owl3pODk?=
 =?us-ascii?Q?UyhdPn/tWvlv8HGicqJwN7Y+J7KnKPGW/xIFoM6Trm4DoHKEIxZ1s3kEQcPA?=
 =?us-ascii?Q?lcGQ4nKWv0eY/QsTgDvS2JHwNsnSQIcpbkb9gC/5cJs8wUHQ8xtzkHmipMbk?=
 =?us-ascii?Q?eZ6z9irR0V+f6poYeVwQ6fZG4DphasJ6jb94XahZzZRuEuoy9+e5a/qbU8y+?=
 =?us-ascii?Q?5C3qBTAWkBM2hnJvaaWA4SPWe6ZCyHUd4d1cmy8HYQ9S/B+VQh0kIaNYRg0Z?=
 =?us-ascii?Q?mF+omcR4gCSSRqF63G+IwGxW36DXAjaCEqZQurZhCSQZjKLNgTE+KimFAtPW?=
 =?us-ascii?Q?dn7LFdVs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb1e1e5-6941-4bec-da2e-08db8c780c96
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 18:59:03.9519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p0ol5mUgzCa4JLUYdxzUqGJ7uqCTGRnJTHluOnCpLI19DftWJU+rP/ro14tuANYreE1jEADirj3N9uln2+b+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=982
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240167
X-Proofpoint-ORIG-GUID: DGRTeDMskHY401UeWYkIStpPCH9I2-yd
X-Proofpoint-GUID: DGRTeDMskHY401UeWYkIStpPCH9I2-yd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/23 04:47, Matthew Wilcox wrote:
> On Thu, Jul 20, 2023 at 10:49:52PM +0800, Linke Li wrote:
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -154,10 +154,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
> >  		return -EINVAL;
> >  
> > -	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
> > -	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> > -	/* check for overflow */
> > -	if (len < vma_len)
> > +	if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
> >  		return -EINVAL;
> 
> Doesn't this check duplicate that performed by file_mmap_ok()?  Can't we
> just delete the check, or is there a code path that leads here while
> avoiding file_mmap_ok()?

Thanks for pointing that out.
Yes, from my reading/understanding that is a repeat.

It looks like most of the overflow checking in hugetlbfs_file_mmap is a
repeat of checks done previously.  I remember adding this code in
response to a checker or someone pointing out the potential for overflow:

	/*
	 * page based offset in vm_pgoff could be sufficiently large to
	 * overflow a loff_t when converted to byte offset.  This can
	 * only happen on architectures where sizeof(loff_t) ==
	 * sizeof(unsigned long).  So, only check in those instances.
	 */
	if (sizeof(unsigned long) == sizeof(loff_t)) {
		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
			return -EINVAL;
	}

However, file_mmap_ok seems to handle this as well.  The important thing that
needs to be done in hugetlbfs_file_mmap is checking for huge page alignment.

I have added this code cleanup to my list if someone does not do it first.
-- 
Mike Kravetz
