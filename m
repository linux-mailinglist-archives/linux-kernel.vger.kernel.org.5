Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01CF7B35EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbjI2OmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2OmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:42:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3631B7;
        Fri, 29 Sep 2023 07:41:58 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TEb9KX014251;
        Fri, 29 Sep 2023 14:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KIY2KVchi3Z+OLShoLmpv8wJAjAtVN/DKF4f4X1KQD8=;
 b=XAaWnG44w7goaCjLGND5xTzZ+8MNs76ArS+23QQDrwdW2XLzvEmfHPouKOfe6e5UauuJ
 O1pkStQZ7TMvO8m7X/NhNZ63XC289/8iOImANg0gvyJ5T5ekwbsgoYqWtqPBnI0mjSfj
 WbBLGlmQcFLQIWrHVjouyYhgxyzhL1LEZOjAJ2Fo0vMDUT/sG6dciGeLNOuH0FWQHiM+
 ip7bZfWzXar9UWGymUHEMjxfKyztC4ogpHykg5ZXD43xe1mz/Wsq09apY4ahEdtr9qOh
 VYHpkcdJrid2MWViHWmLkHUfO0sUB+xt70oi/CzjkioIZ5AhTkbU1WJJu8JEusK4AnGy Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjupvmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:41:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCuuXB014096;
        Fri, 29 Sep 2023 14:41:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfbxcpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efBxQNkkQnFWWnCfDIz2Y6extuW53hEEjknF4hfN4ybHAEmQ1CW4RtWZ9pl/TxfwpCN89OGvvtqjW/7v7B8FCYpePBytAFFDDFuJ85gMSZsRQh940qxuLjn0xl/8jLbb8Lz3XCZ8WDEiCIv8vS9LzleV3yqJjXdjWPG2sGOxaGDE4mt+7dU7JFhkoz69rtTJByDNSom1cgs/qIiV+M6Km4uOKb9pxJBLlfztYG7c9Z2ML8RAI0A+fYDq2BVTQ+z0pxL/IdjQGwVqte5Liv5gbV3UjIkTw3OvyVLmbEtC1NwrFu/BTXGVf/du+XRVPT9iKBAETtPHhKPac0fhY0+phw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIY2KVchi3Z+OLShoLmpv8wJAjAtVN/DKF4f4X1KQD8=;
 b=Y0Upscd2KPUmHEbQUS8MUByn3X6iZH2U54T1r2Iq3VbC3x4dDvbms2veJxLV9fif6rZofntJKSY4xG9I3qzqLmDTohgdTtyxQAgapQuk/JE7r8FpWojmaviLzWZAbiGUVRfKJdAfUcxjsP2yfkfssr709mCPg3kql13oF03rJ4gtkBYAfhtCQyKF5HrLrCE93vV6SKii1D9WhtJJc3c8AKUtnMa1Li3TcNIh/r0OBF55jYHRjnkLxjb4ywqQtxFeRH8aHX4uqb5LX6BO6kaQQFq5lXJD1HbvT8XclNlUSbyxPE4Ewio6JQvc2iY1gR5evRIMI3RELqOTeHIQYTm4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIY2KVchi3Z+OLShoLmpv8wJAjAtVN/DKF4f4X1KQD8=;
 b=xXRLJBs93OjAdT3lrCdaRDaaWKC7JJWJY3lp1kDKD6UiaQFRNhdSPYm86cfY8heX936g10w95qFuFx8h7NgRcYdNJJHmtPY9zF9vdRBmYb4433NHM8NgLK7DKo9+dPwYJiuhCBFQ+Sg8VMcCIKRSrbXrc5YsePqA7zV5taRitHI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB7766.namprd10.prod.outlook.com (2603:10b6:510:30c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Fri, 29 Sep
 2023 14:41:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Fri, 29 Sep 2023
 14:41:26 +0000
Date:   Fri, 29 Sep 2023 10:41:23 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-ID: <20230929144123.66mkl5thj5ofounk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
 <1c8488e1-1776-f21e-bafd-3892f0894392@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c8488e1-1776-f21e-bafd-3892f0894392@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH7PR10MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e753198-9f20-488d-4dcd-08dbc0fa28dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTW4XjJpzfDES+E9KmepKu8FYRFKe7dGtJBk4qOSfJ5/tlO+XidFdMqU8rcchYXeeXhm4RGCPiJLSE4bi9xicXmtTcXaL7X6IzPhCOcbPL9ihzUYK7kNimWZae9E22ySL2/xsxi5gNQ+LBrdyfZ+PnE4v0f07cJ9B8RZdcl0UXSKt8hre/kAT9TxpaoPdnH2SfJGj2ELMHtSa7ZkaNZB0qR0LJiy3fGhv4OgEIxJhPC/pdtRN2hqO7ijVHMuUH9yWzvRhP4SjEf5h9iFhCtWPkxI4kwsPP2A4gvfUEoBbuNy/uXjdcANsmsR4QA1qMi76nOHk7hy14LB1fKVWTKc8BolmslYFYH0d/CPMiyn7uG0y3Ocm+NZHtprfPPP1wBT1CC2SL0t9R/v82qWleR+8S5kGufYyAIT48utePMzqJctrenGTGa6tQlTirhcpnOhQQ8awl9d0AK+I8Ukm+XSwdh/Pq+lDI2szZMOFUhgtPg4Z/r7YTskN7UyhRY5w7X124x/AkAO/q72sF5+0F1fbx5EOa8UfRr6/2orrWrpzfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(6512007)(6506007)(6486002)(6666004)(53546011)(1076003)(26005)(66476007)(66946007)(54906003)(33716001)(86362001)(966005)(478600001)(38100700002)(83380400001)(2906002)(7416002)(66556008)(4326008)(8936002)(8676002)(6916009)(41300700001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyhoOkuH8IaypO4w50ZPB1pTFvp9aQcPx+QDybgiPEijQ+/oOJW9FimNfcRx?=
 =?us-ascii?Q?699y7F4y9Mp3kSXu0oWWP2XZ2cYKLOPD5J5+2jEH/rJt7cruSUEPZRe+Y3Zw?=
 =?us-ascii?Q?EMN2HeWuu+jkDcSAeDKjcM3yJcZS7zaMadBpTfdTfP0TQza0lu8+EJOt2iGa?=
 =?us-ascii?Q?/9W2bEEU0IC4ZtLpJE6ulcTtjCNwcaY7nmui4HppYYjF8wlk9MumUfK6Dufu?=
 =?us-ascii?Q?GhMYeZfpn4ehXuEolb9U5e//WZWH+Is3b+gdowTMLatKdoCxrnEy8iuzdi5h?=
 =?us-ascii?Q?dtivW9t+7FohO1OmLXnlTQ/xgIvx0S5XQPDJbyN1+lFdKOslI8Q1t37CTM/x?=
 =?us-ascii?Q?dvEsHLJi1ejDI6xV3kJNUzcQbkd9AiDXF86XyP00SdFJ7Z43Pim1auofxT57?=
 =?us-ascii?Q?RfFkiQGuub20pWpiY/QIdCDlPidfCzdVdAyXiMBZRpykO57ILn4gClKDf6hZ?=
 =?us-ascii?Q?eetkbEWyeM9YlDf5FzlvORSBXWUTI7MNzbTmeeC839/qpapHPxi5aGrS3UC7?=
 =?us-ascii?Q?6KQb0OBK5j2Dcnov+WLsh360mq2NoIKACyIYdj2itZ7VZkK31Mqdo+/PLj76?=
 =?us-ascii?Q?daXxEYN3x8VTLw5EG5JawCl49H4AQ4xMttSTv1qSvd6hyZ2FtqeX/FAVbenj?=
 =?us-ascii?Q?HkO9k8C2Ci9pqxt15I1CM+Vx+Os9SytTx7WZLoVkxeGGf0ponHXB6TeNGPdr?=
 =?us-ascii?Q?iAYw/yY6+XyAX1TNi2ci0JUUgvcc8iQRzyigLUrSCZ/eNDtDQRSPXR+2aQag?=
 =?us-ascii?Q?jYtu/vl4rZ6s1Oi2h/oth6IL4SatdESrP773Jaa5YKrpJiK/rrHD7aUzqZfX?=
 =?us-ascii?Q?r5pnc0Pzs0qqDHBdzZGXX3LtTmpTW3fB/ofoARmsbs1E716y19feaF/+4q+U?=
 =?us-ascii?Q?2I+Rd4UNw4OUTgoJ2xA2pp22PViI4FsyWEozMq8MROKHDu5UO0v0i5HSTXVA?=
 =?us-ascii?Q?F0UmoFfimoqTOvE3Uf9OUuAohdFaAWEfe78vFKNo0uPs4HKiIgSozKCPGjfP?=
 =?us-ascii?Q?ScHgKHBrNVjBS5s09tg+TpdfVePItgZrOwfF3xLPOzCVZDY8uJYcTlVXupYE?=
 =?us-ascii?Q?+XHSEymkr0cP8gOeR8ilq61mZCloc0/fcPx7A66jS7BRXwsO1j6YDl59Tu3h?=
 =?us-ascii?Q?aj1D3w50L6H37xPJ+Sz1/sFajyWed+eM9Trb9Gdb2VXM0lc44TdOFZq52WNG?=
 =?us-ascii?Q?YwB8Fb7L1aaD2fmy6pBpHeYu/xhFJYBtTVV2qW/1JQo9EjDedPu7QStq7pgE?=
 =?us-ascii?Q?FG35qSQ//f83n0XGFB3fz/8elh9Vb3DcOlcbzLZWAihowKvCWqVPrQcQr23P?=
 =?us-ascii?Q?nVzZjucJGAJsEs+iLV1S1fYmHs/8f1fIm8STpGr7qXaejlYwKhYMXvvD375D?=
 =?us-ascii?Q?gvW+vNTdRu19d31VWjfJ76W11hpW++ycxVu7thZWcXQnUKdrdigCzPDVTym2?=
 =?us-ascii?Q?pf8t0L4SM53mKXGjbXfA3HkbzwmZLcsV852fspCwU6dcyymL+fMsgR3F+s3L?=
 =?us-ascii?Q?EQspWqD96zFN1dY1fWis53LXR51wdzMXNGgXa4C8DXuoW9gAsFbI16CmUj4q?=
 =?us-ascii?Q?hHAOaQ9s2GS22YpnmJPf77DAJh8rmD4HEwctu0qU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Zj5rWlbu1aqbtWKGjsHe6fKYulLRwQl0GoTu+muZD/NzppIxTCuK9eI8VJgc?=
 =?us-ascii?Q?iOPBZgbkD+2/HlV2u9CYfwN/k/fnyihReQXDah/u+Zeh+fFAY/xmA/dK+DYf?=
 =?us-ascii?Q?hb7PwG4Xid6sNSNqs5g1NaMCG53Lca501WchkWCuS3XQwONB0M1lGnoxvr8i?=
 =?us-ascii?Q?YqvHPwfEGK8q9cJktgovSkJ3L26O5Z9XtlAKzeF7/xW3bsoK5ZJPuYOugSt4?=
 =?us-ascii?Q?CxdN9YxYMlKsjvgHjMzGG8UawYV5D5a+TT3O26O7bGvUOwYKhaUYa4IMs/bn?=
 =?us-ascii?Q?VL+zRM5/LMjcgvE/mQlcnfrFIkoZnckbpKzBZ2bg1CmiKg6QkhDg9u1nXT0u?=
 =?us-ascii?Q?mTGYMMiw84a5z2ziaLBejfMCem7FNpy4iKxTYen1ZtNMzUizxKl1UxxxjMoq?=
 =?us-ascii?Q?ELIeLK3bAv1shxxfsMF/uEskQ9/lYHeIAoSHZQknsy87lfEOPdOSejlR/Kwe?=
 =?us-ascii?Q?kaEpCVss72X2e7Bk28ONe3X6YYMFLvlYBc369eMum1T6pgqwgKTxFab6gH+T?=
 =?us-ascii?Q?PGf+rDuVr8coc2yq26nV5haVxn/1vAyKdlUhh1249rDAvcXvyGLxCRMSPt2F?=
 =?us-ascii?Q?nqz4J8lRpSnozooZgbttUVYnDJbUsdyhlq5tHEdPkiVkdAe072078NXobZgl?=
 =?us-ascii?Q?uSKFtmp4sOWAdIVNIsphFebO8ZGhITeycyvgJif1YIMnTGg08o+eWi+wO+e0?=
 =?us-ascii?Q?dHgKjbIUipd/74osUsfoses0W8z6zsa012kVDDTLvalkZoagFXEohWT8Cumo?=
 =?us-ascii?Q?9nr5aEuMRsf87CWN968fM1dqPOyx3PPQTZtaroUGMXAM8AiHd9vVs16RcVyq?=
 =?us-ascii?Q?py0W8M4zauXfxLC4vqwfzlseuocIvqAW+urUOugp+uRLV4Na+i3OdsuMmtQY?=
 =?us-ascii?Q?JgmPcfwiMPv5A/9Elk6EdFXwyj3E3RuDZuyBhsbxoUVzcaWfG7C0Gtinptm3?=
 =?us-ascii?Q?VyNedQqnZAbSIIXPy1FID2sKD+jxsNvTymiOI+E2aqujOOcVZdaekVn+NNcQ?=
 =?us-ascii?Q?uWci?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e753198-9f20-488d-4dcd-08dbc0fa28dd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 14:41:26.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr6i7pRQxbzHC+TnBRvaDP9siKsI8pY3bx1k+THOmatHtsbclies3sKQ3XUv1001VD1PKG+J7BAepBT3KDLyug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_13,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=655 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290125
X-Proofpoint-ORIG-GUID: f149YFhLJwsQnj2b4_yYVSy7ADRrBIhD
X-Proofpoint-GUID: f149YFhLJwsQnj2b4_yYVSy7ADRrBIhD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vlastimil Babka <vbabka@suse.cz> [230929 05:52]:
> On 9/27/23 18:07, Liam R. Howlett wrote:
> > When merging of the previous VMA fails after the vma iterator has been
> > moved to the previous entry, the vma iterator must be advanced to ensure
> > the caller takes the correct action on the next vma iterator event.  Fix
> > this by adding a vma_next() call to the error path.
> > 
> > Users may experience higher CPU usage, most likely in very low memory
> > situations.
> 
> Maybe we could say explicitly that before this fix, vma_merge will be called
> twice on the same vma, which to the best of our knowledge does not cause
> anything worse than some wasted cycles because vma == prev, but it's fragile?

I will modify this statement again in v3.

> 
> > Link: https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY*Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!LhxAWtA9bZgQkMs8Egf7OLmMSj69FWYmfgxD-UoydFparflJmeHvdvKoQChX_kelOhqCP_SSnB1juSOrAg$ 
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-mm/CAG48ez12VN1JAOtTNMY*Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!LhxAWtA9bZgQkMs8Egf7OLmMSj69FWYmfgxD-UoydFparflJmeHvdvKoQChX_kelOhqCP_SSnB1juSOrAg$ 
> > Fixes: 18b098af2890 ("vma_merge: set vma iterator to correct position.")
> > Cc: stable@vger.kernel.org
> > Cc: Jann Horn <jannh@google.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index b56a7f0c9f85..b5bc4ca9bdc4 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -968,14 +968,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				vma_pgoff = curr->vm_pgoff;
> >  				vma_start_write(curr);
> >  				remove = curr;
> > -				err = dup_anon_vma(next, curr);
> > +				err = dup_anon_vma(next, curr, &anon_dup);
> >  			}
> >  		}
> >  	}
> >  
> >  	/* Error in anon_vma clone. */
> >  	if (err)
> > -		return NULL;
> > +		goto anon_vma_fail;
> >  
> >  	if (vma_start < vma->vm_start || vma_end > vma->vm_end)
> >  		vma_expanded = true;
> 
> The vma_iter_config() actions done in this part are something we don't need
> to undo?

Oh, right.  Thanks.

This made me realise that my prealloc_fail path assumes there is a
'curr' vma that will cause the vma_next() to set the correct range. We
actually may be 1 or 4, which means we are looking to add a VMA to the
gap; in this case, vma_next() would go beyond where it was at the start
of the function, and may cause issue since we do not return an error.

So the current patch fixes the problem Jann discovered (and with any
iterators), but the issue may exist in other error scenarios today or in
the future. There also may be an issue with next merging failing and
skipping a vma...

Looking through the code, there are functions that do not match the
entire vma iterator location due to trimming (mbind_range, mlock_fixup)
so using the start/end that was passed in may not accurately represent
the range passed in though the vma iterator.  Although, those ranges do
point to the correct location in the tree - they just may be smaller.

All the callers have `addr` within the range of the vma iterator, so it
would be safe to do vma_iter_set(vmi, addr); and vma_iter_load(vmi) to
restore the location and range.  Safest would be to save the vma
iterator start and end location and restore those after a re-walk, but
this seems unnecessary and would complicate backporting.

> 
> > @@ -988,7 +988,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	}
> >  
> >  	if (vma_iter_prealloc(vmi, vma))
> > -		return NULL;
> > +		goto prealloc_fail;
> 
> 
> 
> >  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> >  	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
> > @@ -1016,6 +1016,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	vma_complete(&vp, vmi, mm);
> >  	khugepaged_enter_vma(res, vm_flags);
> >  	return res;
> > +
> > +prealloc_fail:
> > +anon_vma_fail:
> > +	if (merge_prev)
> > +		vma_next(vmi);
> > +	return NULL;
> >  }
> >  
> >  /*
> 
