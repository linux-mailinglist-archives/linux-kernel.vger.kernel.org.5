Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37437DFE11
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjKCC3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKCC3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:29:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98879125
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 19:29:06 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2NOfn1021271;
        Fri, 3 Nov 2023 02:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=IZ2DMhPfmmlc/e+S2h5RFWdUYQ87hnuetp0g+VhHTp4=;
 b=3ERAf3IPmmCndc4kYoSEuoJ3kOLATMTd8xwa4q1KB3TSf5LjlYW5xR71wSbrw/W5Wgxx
 CoGlluc9AQRD8vWMKOgiOeylp++/GD4nCMl5e25hIk/d/70mecWC8OjmlyDtpTzuSGAt
 /e/6FT22BzlZcHfV3Z/yNG1YvFNFtLpYH+1lX+1jhKgGUp6ftT2NysmjCLmPFKvHDFKm
 +OraqDg76Mo9bInopu1A0gnqS+9DizT4UJczXSFiaTT99jlLINia6ZBg9zjqDApU5V9i
 SNswR7ltWjTnK3+9/n6IO8NSLARMn8zPsvj0SCZfQFm0Qvep8uuIY2ucb3Kqh1S9Xf5c lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7c34mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:28:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A31hKqC020080;
        Fri, 3 Nov 2023 02:28:24 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr9g4f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Nov 2023 02:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cx8D+vo8o2hP1T4tX2leiuRhdaZR91iOJRn3TMXcuyEqYNogohtZF+CUy6+r8/Gt5om50+X6bwft1m3m7LUqUswPZbYrhvjv0Blh8BNr7rJLjZyiQUJoHYIEPLVJuHJrGtjPm2xpqVGYE0KwOk6Ctq0QEWFT5iykh6KgozzNvJOYKAyir7RgpTvn4Pr9hJN+aaMyIP4MgyRH7dJ2ysHNvFlZuqdvGLTMh2MeAm/CX+ZQu/dQRAGpiZsugk+YB33J1mk9aZxtmKTnga8+TH28W3iA1s+lac4uHuKG7uQEQ7jvTTNhqhagP91rMazOflKYz2GK+/Mihi5RGodikLSxyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZ2DMhPfmmlc/e+S2h5RFWdUYQ87hnuetp0g+VhHTp4=;
 b=cdK13D9F/RUq9sW6UiwWWJ00BJyduu2feXCZW0qIBcOGJPjpvaoSXj2GR7u+wHun+6yZjOCePsOtySdp4NqM99P8N1jXeBwVV/diBUf5KcbyFkVPeJpLmpcIYh+VxC98q3Fge5HLQKFW82UGi6caHMzfkhIXZzoBuUJhSpidOdkZLksAW1gf1PfY6l/yP4ZoE6c+G7XPqXmQxLC/duHWD5EqnGROSh/A5juwfMGSs+vr18a4FMWKTTDKySadpqpFZeJIysyxqxEbIdgKEsLoB2hnviI6iAwHW1tpnrYYgNHuUhyP0wCLgLw1hYBWc0Ojwd49cG+0e3L7UZ0dv5zqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ2DMhPfmmlc/e+S2h5RFWdUYQ87hnuetp0g+VhHTp4=;
 b=wwhx1wEBen7uCd1SZWb2Ipbwiryl1X2aRE22ujlhBN5HdIu4uDXv6LqSzzv+YRz3D3z6zEtgHzKBWOTugtHbcJWl6543C17BkdkmjKjNUK+sAAweDRHm2KNfLBgueZp3YsZLzeq4mrYXVhGkoQ/rF46nWamIdAUz1/lg11JBl7w=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW6PR10MB7590.namprd10.prod.outlook.com (2603:10b6:303:24c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 3 Nov
 2023 02:28:18 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::517b:c692:6b20:19c0%6]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 02:28:18 +0000
Date:   Thu, 2 Nov 2023 19:28:15 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Edward Adam Davis <eadavis@qq.com>, "Yin, Fengwei" <nh26223@qq.com>
Cc:     riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com,
        syzbot+6ada951e7c0f7bc8a71e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Subject: Re: [PATCH] mm/hugetlb: fix null ptr defer in hugetlb_vma_lock_write
Message-ID: <20231103022815.GB3531@monkey>
References: <3382634358afa9b95dc4f6db8a53a136d4b9e9cb.camel@surriel.com>
 <tencent_164A247533766D667C3D873798968236C409@qq.com>
 <20231103022426.GA3531@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103022426.GA3531@monkey>
X-ClientProxiedBy: MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW6PR10MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: e4231af0-1bdc-4505-6ca2-08dbdc148a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EpJLGOqmuv5pNiaEKE29ckLOrQIGkLks0i3C+2V+9bIKSQtggS4sD95K1772I7C9EALPXpcQDcpkUcgUN+RVS8qxp3KPD7EyutErishppd80Jl3JnA9u+ASC5tzBPu/QQfQHLS55+INEYF8W52X15xJD+2pMTTV0xS1NO0Ib4YpaesDBsjANtK8ut+XyWGIr0PsPP8zxqkJT5EqwkYiGTmPROZZ9azMWI0UpVhg0TEeR+unkGiEJpCay03kVBMGYHA44W/P2R7qYp23ql+pL+kQwALsh9z7JopWg4xVulOPSuOUdUe8nOITmwZAUH7pyE2UD+1tvlTNWyxqDH/gBGTPSqbQb6Qta28e+i4y8zeGg4Imw3UObSJ8NSWdHvCvqbmB8HsbkwKOz1sFoSZcekUCqS1IAumWjvaeKNufBRZl95p+qGj8jKHVNwP1bDCPSgloh2bRvIoUVzIgABbCuFWkxs6F0mCFG8vEEwN3TF4zhjO+mih3ipyrbSAXmoMx7DHl1ycWUFMZKDdg+A6xB1CY5oqjnbksUILKh2ZJwLY+rJgA6F3QJsygKXF6oGe3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(478600001)(6486002)(7416002)(86362001)(6506007)(6512007)(9686003)(6666004)(8936002)(33716001)(4326008)(41300700001)(8676002)(44832011)(5660300002)(66946007)(316002)(66476007)(66556008)(110136005)(83380400001)(33656002)(38100700002)(26005)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s8dXEYr0iO5p2/OAY2FrLD1ccXSAramOm8gDxTd1oOKvcsMeAN77QZfOnioP?=
 =?us-ascii?Q?KZovYaUCOOAAGVubdiSgBxyshYBsVsCbMdjITZdLhfRw6dwdJAhwoiQJuj6c?=
 =?us-ascii?Q?RULulHi1zfwbmQ+hGGPhn/KorCumt5gnJQhIZyxUCALJMyp/amjnGvhJC+gL?=
 =?us-ascii?Q?C1nmmDNKIfnhMvU1uIqSyTmHciuZPLrawPVyydy/m7dBVET/ct4potm4PNdQ?=
 =?us-ascii?Q?dIEBy5qBigM4Bs2Su1Zn0tePZvvjUvLbzSUrE6JspQHbnQb9yO46FZyYGCYZ?=
 =?us-ascii?Q?705VjLB/KqPOVVVMoXqjncaS6fDaG8hD3zi6MIIZKbhcZ88x48xyvI7gE7f+?=
 =?us-ascii?Q?NMb98j2hwVFBtu1Ij9ITyjaw3yQ/hgH913WAG2BcxBACAM5GXwP6VQbNCf5z?=
 =?us-ascii?Q?C40NQeVHg9tKbEctzNPp80X7Aok6CURt1W2xuZZpesgst1qbFpEdQkSUuVsd?=
 =?us-ascii?Q?evQi5wMtdVcv/jGgtciWzNYCM89A6s4rPwtmPqBzXTUPobl0RVKdD2f3soFB?=
 =?us-ascii?Q?Z5Vr6jRBNghd7f0lyEaMk0PeWZ4MLqxi3EZQD22kaPdI35+86zRY4f5K0Xcw?=
 =?us-ascii?Q?oQAyLnwoRF/qH8Y2KlVqipdIQaVHp7jkNH9kfehyUt8STSnNwTmdREcaxJOY?=
 =?us-ascii?Q?ySr+oLaq6ED/E3YrD6a4H0lzL1OvNA+IKq7AqxKsbsDVVJRCJH+ZTenJcbkR?=
 =?us-ascii?Q?e6RVmy58Wxp97wYpSsxybUd2yHhjmJQmoH8aNNWRejCwsdjDsRiA8YaFRcwG?=
 =?us-ascii?Q?ZeUWHd9r+divqwt1kXXW0F65uBTEiUxfOjK2BEaPHIJ/52tj0z5OoosW9aCI?=
 =?us-ascii?Q?aKqIg/iInDeUQl5CVaG0mQlKf/cEmhIlzTEcT281C+GgjeiIKSeS11qk4nmt?=
 =?us-ascii?Q?cw0K6m7ukC84qcQiTTTlPMo/Q4YwF/qkq4ccbdEP2N23IeIoc0q9YW14ehQk?=
 =?us-ascii?Q?BUZhFxNYVTpRctQDte3OJG07BDXksrF50QXab6ggrJRlb6ucuOLkXiIx4v4E?=
 =?us-ascii?Q?WErFOvIZlFkyr3GB0pNKcOXLqHX9Az2bywefjjaab/H5nVjoxzuc+PfXpRKw?=
 =?us-ascii?Q?9B4PQoyVoIxtjRDJ6pCvdEtJ9DsdEVFOHdSPSK3YietzulTY1uDBpGmW0fDZ?=
 =?us-ascii?Q?BZpUuCqN/i80y0H2w2Cs5hFOrRyl9Wu+DntqFHnv/1oIxImnj+4+e4wwPBI4?=
 =?us-ascii?Q?NZAmF3l3W1Uy6cwFnE9VZjpS3rXKlDwvaMWhHrOhYffm7WDlWMr9hHMlSd+u?=
 =?us-ascii?Q?5200ML2YZArujlhhnOJhxO867We0YA0WrwWUygFeZWaSEiocASfU7dJi6DEw?=
 =?us-ascii?Q?ryZo4ovOguvQDPnKqcvwOBDKonk+WxdnX6WVgku0szvw7zqOu7rpbqrBnOR7?=
 =?us-ascii?Q?qMdQMq2QDU2o6ux4npoTXW2P/50nYuv5EBZN5uPc5UVbRyJIFPj9nRwdt9Bd?=
 =?us-ascii?Q?SFGSFOxEdt4PNFXcBs93I7Jnmax82zdSzrXH3FuuiSRzrUXV7onIdRQmCmVC?=
 =?us-ascii?Q?p+ynzt5bKjo/6xK0M3EvnXusYG2yvuLCf/Ak32GPMWGgbIRdFSyc23q1KpAu?=
 =?us-ascii?Q?TwFDDsHDXez9k/0L9aocGyX2NZ+gby7Z/8P5qBXX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qsFSX5nc/iplePVumuwSCiC1tAvSjxDw+ROTZdrb9L8jU2LyL7wairaoK/pr?=
 =?us-ascii?Q?yQV8MD1sovqxA+3B4fyk7Su1Gr14OU5dji2/X8l6nDt23GlMsjM4IZV3A0gP?=
 =?us-ascii?Q?bYz6YUq4IGBBsFmTWHuZ806+3+GJLjg3Oea4rWxs0D3ZoRmw9rkLFNZnqz7J?=
 =?us-ascii?Q?cRLMfLAMb6CG++2XoBNiUlR8JGCiPfpfApoJRt7jCMnrVlYnVz4KapY7eIz3?=
 =?us-ascii?Q?e5Sx8mgjmdStn/GUe4gDCXwxvDzTBfVMhrMsX0ult4M5Ebl1CgX/YzGzYPee?=
 =?us-ascii?Q?uJ3f8f1l9S02VeI34wO8hEHga5gn6bY68BrZFqlnsaTO0tPalneujjk3Iip5?=
 =?us-ascii?Q?uEC9bmvKIe2RYetvaudCf8Yy4xQNTmi7X4es+UE9XMVe3yhpwff8Lv8sHHMn?=
 =?us-ascii?Q?s8ARQgvYZtun9uCSziPpNG/6P+CqxD638npi6cQKopdQ/xPPXzM+d5POS7f8?=
 =?us-ascii?Q?sRe+gMDNw25O8VGAPZKNKlYeQSL+3gGe4iJHDqmnFSI87EiuNsP6T/YhF0Ch?=
 =?us-ascii?Q?PAOW9AAoEhpzo7ICvD3YrUhRP9eTTjCWpzseegvtGdq3zxqG005OB9VQf2zu?=
 =?us-ascii?Q?vocTNNuBIhso6COSFNWcrtkbY3rTw0WGxqLjLBT9G9jQHeOvLkC7mVcHb1WT?=
 =?us-ascii?Q?mm+vjNK7g7bJwsfO5GDqtv7T0dSNM4+tR/wdgBlCAHmdvcfld6LADenaXJqU?=
 =?us-ascii?Q?t5lI9uKy6obyK3J3vbSnqBxtMV3Zeb7sCXV0LRbRnoxL+lJ18QfGrKC8iYPm?=
 =?us-ascii?Q?gEw5+Vme7nhMnEy30fcxVIacrZCwdPofv7N4s4UgIhP4UQL265Sc44Ug67k5?=
 =?us-ascii?Q?yYdK9+beEskSnAudp/L5+6ePF4Q9gYefSnUFLlAdg3CFSnYbHikkmhY2AZ1R?=
 =?us-ascii?Q?j/OE8kdsUaNnEvWT1CKPwcXaOC78ZRfhTUUcWERvSaYi0maExJvZzTb77pEs?=
 =?us-ascii?Q?qrbRPy68+o9kpPgCF91ZSY6puljP+6hUYLTVokD4oMR92OY/isdz0nGtBA4B?=
 =?us-ascii?Q?p/7IwfupSlVYSd80Rl6iwP89ao3DD3W2a7jV24AKXUybMa0XEuqpmsYK9ddb?=
 =?us-ascii?Q?SsQelh+9vqO+ebvt2C/1zyWP2RLgx4UejDwjaYYJ3zUdKEyeGkFVQeBbgaef?=
 =?us-ascii?Q?pFWqS/tRviDOR/ls2+p/XFa32QMsMQ7AuqSrBlmytZMuOYYWZWYO1hI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4231af0-1bdc-4505-6ca2-08dbdc148a43
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 02:28:18.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anCgEiUUw1aKllJ870auIGz8kllkZjFDApRfxdMT4KL4nAIsMOFmeb/uRajRuvRkko5G9C0SbNTcMTTE4lcbtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_02,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=647 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311030019
X-Proofpoint-GUID: 7c153biE2RF_UTIW7Fq9UlUh8pdGrpRL
X-Proofpoint-ORIG-GUID: 7c153biE2RF_UTIW7Fq9UlUh8pdGrpRL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/23 19:24, Mike Kravetz wrote:
> On 11/02/23 20:58, Edward Adam Davis wrote:
> > When obtaining resv_map from vma, it is necessary to simultaneously determine
> > the flag HPAGE_RESV_OWNER of vm_private_data.
> > Only when they are met simultaneously, resv_map is valid.
> 
> Thanks for looking into this!
> 
> The check for HPAGE_RESV_OWNER does 'work'.  However, I believe root
> cause is this block of code in __unmap_hugepage_range().
> 
> 		/*
> 		 * If a reference page is supplied, it is because a specific
> 		 * page is being unmapped, not a range. Ensure the page we
> 		 * are about to unmap is the actual page of interest.
> 		 */
> 		if (ref_page) {
> 			if (page != ref_page) {
> 				spin_unlock(ptl);
> 				continue;
> 			}
> 			/*
> 			 * Mark the VMA as having unmapped its page so that
> 			 * future faults in this VMA will fail rather than
> 			 * looking like data was lost
> 			 */
> 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
> 		}
> 
> In the specific case causing the null-ptr-deref, the resv_map pointer
> (vm_private_data) is NULL.  So, set_vma_resv_flags() just sets the lower bit.
> Because of this, __vma_private_lock returns true.

Ah!

I see Yin, Fengwei already discovered this code path.

-- 
Mike Kravetz
