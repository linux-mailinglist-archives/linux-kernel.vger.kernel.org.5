Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4783E78B58D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjH1Qq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbjH1QqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:46:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A176811D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:46:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SDvAH6009903;
        Mon, 28 Aug 2023 16:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=+RgIFDzcDxhu+4Ad2QwuKmMyIJV7yTnlIgnprjqygYU=;
 b=vSec4rQut2+mST+F9gC/OsRej9iAQ1KHJ3pAcPPqGO/qGXk4cQlcJHrfSHqoffOXysKI
 3UNoJv4Dz1zqsgdPSF4A/nOLUO4bhBSpQMnJLyW0QdfRGOatb2Or41Zwo89Rmrn5XAU7
 15mE34e1oxeQQbXlfltYTrI1YSBxwTtu62cQeoB6H6IA57LO8AirtHs37RG0OotgDW4v
 xdwx4ZQiQs44SzU+jBv2z9iYlcEt7TbzUbUUNRIJIAvWtLx4OM5FiNSUg13ufdk1I2yB
 tZJ9dn2YOU4+AMTI8ovnoC7RJNcI84WD1v0ytFvunAVQ+AJVZVgex8cBqE7zBpa6eVE4 KA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gck3rd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 16:45:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SGe6BT020566;
        Mon, 28 Aug 2023 16:45:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6dkxjt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 16:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJJBjmRLWDyS23uvTbmYn0Ql0yiPd2ia05GDVII4TOmaLtQUAQmSk5t4XdWGoAoewKA3T/bb072SMxMf/Ev/JValmosIgiB01Lrb7WssNQGdwFxJLYWdIUIHeCZbWoq163bEJjfDcaAeZ41PfVlc2DOBaeleVnbz8+SSEliXyTN1GJHqWyUXPcLoMJKM2swGM3UIvF7ZSJvP/QW4m7cpj7+4L5YFSzwGvFuIoOO4b66xs3VEdMmNrKqUGxntXhn3PG3KpyZm/teHr6oKYjeRj4/1YOKQTgyg0phI0mCyaP79bAyRP6Wvokzsr894uavIKFRY8rGqcyTPNzTr2+cd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RgIFDzcDxhu+4Ad2QwuKmMyIJV7yTnlIgnprjqygYU=;
 b=c7zpZc/3cs2CLDVwhUGMo9QfcxuwXEuzcg+2PUQp/AFVXk2bqtXOj29jn3wI6sYwAGhf1bIKANNEbK8qxrBK0169hQuOGyLvn+Q9cLU89giNTaFEOp1B31YWYvmmqaMFLeEwXON31z4tIi2EB7HYG6rR5dSj6kchiFC2OTbHgDGyqceaz0l3iXCqecoaQf81AjyAZAaEGwpfu5J9EO9umJBjBk7Hpn7y55J5E/OW140vgTR0SV3iSLNNJn2qCMxaab5P6xnqrUIoU+oxVfdLsYYmdfYddwDQM2OW3YZEkUQs7d5u5VxHlu+u9+esmOl4nhBSVnVJjLPiTkSjOT8Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RgIFDzcDxhu+4Ad2QwuKmMyIJV7yTnlIgnprjqygYU=;
 b=mik9kf5S9QxurjMY2vFa4sbina0EL1IaTnFni5wvP/+g4ajGGl4KTmJC6Ga2d7IvS32DZo71u4kl59iXpQmi3Yw+0x9eJR2lPKEEg7lUE6Dgwgygr1U9gejmDF+54LX3c2SZ3TapEcIcxTNSSWsRuVnm+6qzEw1xJs00RMMiBGs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH3PR10MB7503.namprd10.prod.outlook.com (2603:10b6:610:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 16:45:03 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 16:45:03 +0000
Date:   Mon, 28 Aug 2023 09:44:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Muchun Song <songmuchun@bytedance.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
Message-ID: <20230828164459.GA3290@monkey>
References: <20230825190436.55045-11-mike.kravetz@oracle.com>
 <202308261325.ipTttZHZ-lkp@intel.com>
 <d0930856-15cb-559c-4205-5d1352b075f7@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0930856-15cb-559c-4205-5d1352b075f7@oracle.com>
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH3PR10MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: d620be4e-4705-42bd-8f3d-08dba7e6207e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIx1thB6jCT3/ftNZ7CrFhPTcqs1BfQCs1Oboo+DrW5S3N0ZwgmxFOGKe3nK0UmhV4yHa1FvbzPR/uUTIo1XjvShD8USeiBYyALELFBoKNAJVqq2jHRSA1pzi/KHMjMn2vljmJHn+TtlPRwVWTzA2APwz4JNXh/kxt41WzuB6iemaVyywWk9P86NIIaiNr3BR8VOGtmc+uN0FNf9+M+frrk69QQL0nbxaDovpvqDMdKNg4yf4EgG0JU9CIYomjiVypQz6H09QzVMYV1TGVyfRTasJcBiXPaR1t1HHY8yymO3GOlrsFTqldwr6M4nB2nKwAHW9BTIWyiyCEFjRRNwD7L44aW4B+d/d7zZNwfOfZ09KpVH2TIvDLJ+MILfRmTT59It/Mg9QxzBZP2TN6DmjPQOnsLcVsg8l8lbLn7r9ghrzc3yGRkdwx3Cln280RGQzPcu58jXsX7EHt5j/Tbxk+oAPSD7x52Rk8PP6pqMB8BCJD4QMN8Spuz6mLUsBMZllZcDYqugPRCMTvn8wGtmOjHNCvXPXasvnEBhW42OE7IQ5lrySAxZ1tsPz7KT5MhCVjwcHb7kUFklkU9D+ZJ1Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(7416002)(33716001)(38100700002)(6666004)(86362001)(966005)(478600001)(83380400001)(26005)(1076003)(9686003)(6512007)(53546011)(6506007)(6486002)(66556008)(6636002)(54906003)(316002)(2906002)(33656002)(66946007)(66476007)(5660300002)(8676002)(8936002)(6862004)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?smZjh9bt+DOUS+ziYn6Vkk8m7KEr4Ho2oiFe+Aeb16bYMVdA9fFKfne229cp?=
 =?us-ascii?Q?nAJhivBnM/x4Y4wC/6BqLdNE1Tq9dVInG+lCSr2ie2XWXSGpponVm5VXPOQW?=
 =?us-ascii?Q?VRJyNFusG/C5vP1uw0EIS5cgSCTEdv3fuxtF2riOqRzYXdhx16muPljTfPsF?=
 =?us-ascii?Q?Rmyqzcc7DMNjUTud1PqJhuon3PPo1BSSilMBA3CZknyw2SZ3IxbTs85AKk5X?=
 =?us-ascii?Q?8FmQsO+OoDMfkAsY61Jwra+Llw4M0GnkJKbKQykKcZdOoOPvzjkxdV67gzMV?=
 =?us-ascii?Q?9NptrDVCVue4umcx84XXlUCPK3hx4jLW1psERO5+Da3fnRgu6NIZiV48Lsf0?=
 =?us-ascii?Q?2HcT90AULZdBNgMRIwzlDrHlJUnaTPKdvCPyJIWibuWY/3caKIeD0XXuaOpo?=
 =?us-ascii?Q?PqXWi/8V8BzZ3fYdDMZ9lM7rFPOSKul5OEtr7b2s/SDmB4dI90ZWNb8hM6ed?=
 =?us-ascii?Q?9PAVRBZjTiaaaYGu5B6RBYaL9HETx/RhTKtgUPprzwKcAQMzw9L3PYALsGLq?=
 =?us-ascii?Q?zvFe/AGU0cwI1iBXNWYz4wG7SAbmDNOzlSsRgWZAq3+eqXXSvwfKP+exTUlG?=
 =?us-ascii?Q?mJ+EkEIwIhcd0awRbCSOu1V3TNNA9bXkTi8nWCls/Rw9suJxvc+wkka3AUC9?=
 =?us-ascii?Q?jHzzCXTJfje95LXOtstTmC+YJW+hau6QarSEZtRr6JUBq482xTm+FijwCSg2?=
 =?us-ascii?Q?v4lGewFMjnVUM7InXXU8zq5+Fn9h5OTXuzFJedVIDtmLhVST/XwNskYGR0b1?=
 =?us-ascii?Q?uU+plsrmQ1k9A2Bcbv7EQJdQ7BNokAmJLXI2OmYYxHyU2PVYMnq9xGMDG5EF?=
 =?us-ascii?Q?PjRne5jNHTBx8mimATbMrY6gz0rQ0jULk56hkbhWHwChr6kRIadifOkse7Jg?=
 =?us-ascii?Q?5k17+uYsdMDitW4pfsDcT2EiaN6yoYBTmd56pVSQzgQz2gyoAmkrBCcyD+gh?=
 =?us-ascii?Q?DI4S+AyjhG6BfO/mpd2SkLjiR0y8uFtn7bL/UUD+aO74ufsuKigvJmSogjfT?=
 =?us-ascii?Q?ZYWszX/zg/glkR2gb6oKDYrBcwnS0dxlaLQTCPYnRV1Agn2MXUZVEaN+XDg7?=
 =?us-ascii?Q?31NN/ncq0bUyQQV67vrbbv6eCYSAgcyiZyANK3QXuBtZS1wp4qSJKTQg8GTn?=
 =?us-ascii?Q?VHSz1JFtfdMQW2CR3JzngXrdzvqlGU5pFIzppXj44PRGKe2NPSU/UBxyuBX+?=
 =?us-ascii?Q?5r+SH/j7v9fuPQoevQyHLL13ZA6zNbOY2u18z1/ROs3mBdHdzxxfZ9qzgMQg?=
 =?us-ascii?Q?TOGsipVsXm+bcG7G4/9yFIBXwVg8g8AbnzYqRWkL3zcJheUiZd3e62PQ9EO8?=
 =?us-ascii?Q?eM7PZZ1MBLvIH31glav4ZEAhuoInNCOVOzONVKindP3y/srfZRr7Ou35cd3P?=
 =?us-ascii?Q?ilW4wvj0kmMCbzAGDTDq0aPJIxSii05xumU1iyo3E7sLmOyjzGS2gQ54ZCp5?=
 =?us-ascii?Q?fu59uboAH7BrYq5ICBIu8LJ+1CFovWoETXa7RWuNFfqklSCJOqbobkLpopa+?=
 =?us-ascii?Q?hLKDjOAOBb31i6p4CUUUxE3vclHQGxgX1EMuciaLjquZ5jSUF27mUU9uUa8J?=
 =?us-ascii?Q?4jhREP3hWihENYprvh2NXwnCEcrR9uFN9bN4VNoN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2snms4N82lWcH92lKyyddLi5cInGTNI12a48GGp4c3u7omw5TCP6QwU0Raxw?=
 =?us-ascii?Q?/sUwxVfioARubD/+EtsoNIsohhKmQFie6g+Xg/8nNz2t8MBtg5grdVGrWNFx?=
 =?us-ascii?Q?Mbu1c8BI7W6qPp1M8iHi4MMmjvPViqNWThK7F3vd186eDlf1/X0tyrFwOjmW?=
 =?us-ascii?Q?0AThWqWXz63JZ8KNHy+zUayiKBK1M7bF8ZmBLhZXNqjgY2jqnwImh+JqY+3L?=
 =?us-ascii?Q?XUZdRN+MbCIniRBTS+DzzFFxhQCBLfXJK9KON74MvKXy+/acTt+kwO3ETsBf?=
 =?us-ascii?Q?WFcTWz/7Bjgp4g2FNE3PhsKyMqaWy5pO91iP6blvNrYXTriA8hNpnIgnYOGA?=
 =?us-ascii?Q?lNytsXySlqh3rluNc8CSQrB/JZCK2KGMe7QKVlnrj6++k0zJN4Oo7ZBqIRvD?=
 =?us-ascii?Q?7mPtQY0CFSrRSBmj/bwxoJxKSxTvGu5QTXLNLxEJXefUCL0/9Lw9c5E0EYP0?=
 =?us-ascii?Q?w9Tm/d6dvCfqeNbml1GJbi9mwDbtHCSMBT7SRIcyAZ0zJ51eTRvxnWuqu7dH?=
 =?us-ascii?Q?BJAkYE8+hJrfwqtASumvL2cvAV4W1bvsx9Z4KWbM3EniTLTtyL/Gd19CnKMP?=
 =?us-ascii?Q?cbbVF65pjl05GnF6X5mwDN4506uZFtaekfhEcmhNZ1Z5L8IeqLIKCmOicttA?=
 =?us-ascii?Q?q5l4C0kmOmq1ltY9rMFyeH6N+ewFSHxG0/ENnv5S73tJbxOjW/L2SXzsYevN?=
 =?us-ascii?Q?f8tYOdhKaDTImoNZD5oe4Xzfc0zA9tE0vsoYov8yoP65Eh/pm/mHlmkecNqP?=
 =?us-ascii?Q?gbiSlggYw86ohrA8xZqCHJ5VphTlmaaf5ov3xss8CGlkKCtRmDEBpy+NTJqZ?=
 =?us-ascii?Q?0I0zOS/k5m1op/hWxaVMtN8+tmLpRzCzfGsxEGJKokK6hymGg14B/RNNRHbc?=
 =?us-ascii?Q?Mkrik9M2blwnB1y1sjNGb62f8B7yc5bOTObtdRFdfrtmE3A5frzmrTFpZNuc?=
 =?us-ascii?Q?VLxtenFQmbo72TUP3gSlVroVLmrIR4r8BRfclDesl4L6EJa+/uocnGzCatjq?=
 =?us-ascii?Q?prwhp1gwx1yAhpsEI844eWj3PrRm6Uidv/DPUFNBojtRbUXbTZ5NXPMSO4SS?=
 =?us-ascii?Q?zEdI7GJE2t8E3MmZYQq2omjsuZr5rUX1SusMUH3/ilYac9pJN8EZE2DgDqTG?=
 =?us-ascii?Q?fGWIbNQ7bOsny3w58MfpLn8/Bzn+smMqVPueiatiQtybEchmdZvf5WHfleNb?=
 =?us-ascii?Q?NFB1xm/V+XK7ZA1IlXzwXeA8/ooW7Ctc8sLRXg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d620be4e-4705-42bd-8f3d-08dba7e6207e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 16:45:03.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZurBEGH7oPawTtvS6SMP+uye8SjftVSdwC/FvIi3UJYJJvmFtO1ddT3lX0iz6vAgrg9V1LLHD5aVIWpqinTew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_14,2023-08-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280148
X-Proofpoint-ORIG-GUID: E5m4fnNQXHfHxxC4j9qmmeMxmPZba1sO
X-Proofpoint-GUID: E5m4fnNQXHfHxxC4j9qmmeMxmPZba1sO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/23 10:42, Joao Martins wrote:
> On 26/08/2023 06:56, kernel test robot wrote:
> > Hi Mike,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [auto build test ERROR on next-20230825]
> > [cannot apply to akpm-mm/mm-everything v6.5-rc7 v6.5-rc6 v6.5-rc5 linus/master v6.5-rc7]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Kravetz/hugetlb-clear-flags-in-tail-pages-that-will-be-freed-individually/20230826-030805
> > base:   next-20230825
> > patch link:    https://lore.kernel.org/r/20230825190436.55045-11-mike.kravetz%40oracle.com
> > patch subject: [PATCH 10/12] hugetlb: batch PMD split for bulk vmemmap dedup
> > config: s390-randconfig-001-20230826 (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230826/202308261325.ipTttZHZ-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308261325.ipTttZHZ-lkp@intel.com/
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> 
> [...]
> 
> >>> mm/hugetlb_vmemmap.c:698:28: error: use of undeclared identifier 'TLB_FLUSH_ALL'
> >      698 |         flush_tlb_kernel_range(0, TLB_FLUSH_ALL);
> >          |                                   ^
> >    2 warnings and 1 error generated.
> > 
> > 
> 
> TLB_FLUSH_ALL is x86 only so what I wrote above is wrong in what should be
> architecture independent. The way I should have written the global TLB flush is
> to use flush_tlb_all(), which is what is implemented by the arch.
> 
> The alternative is to compose a start/end tuple in the top-level optimize-folios
> function as we iterate over folios to remap, and flush via
> flush_tlb_kernel_range(). But this would likely only be relevant on x86 only,
> that is to optimize the flushing of 3 contiguous 2M hugetlb pages (~24 vmemmap
> pages) as that's where the TLB flush ceiling is put (31 pages) for per-page VA
> flush, before falling back to a global TLB flush. Weren't sure of the added
> complexity for dubious benefit thus kept it in global TLB flush.

Thanks Joao.

I added my share of build issues to this RFC as can be seen in the bot
responses to other patches.

My assumption is that these build issues will not prevent people from
looking into and commenting on the bigger performance issue that was the
reason for this series.  The build issues would of course be resolved if
there is some concensus that this is the way to move forward to address
this issue.  If the build issues are a stumbling block for anyone to
look at this bigger issue, let me know and I will fix them all ASAP.
-- 
Mike Kravetz
