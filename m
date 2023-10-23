Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD22B7D3B80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjJWPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjJWPwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:52:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951FCBC;
        Mon, 23 Oct 2023 08:52:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFP20s030705;
        Mon, 23 Oct 2023 15:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=zryqm7gjuMceDSchaUEZjei9kvrlwZ/ZTpzDyB8K4bY=;
 b=Qzm418o1XGHT45GMf/TCE9lcyGSP8b7bLdXYCn0O9QVmdgZlwcrpeRHzz0vR11On+LuI
 T/6citxse/9+DIbe4gpY3H1rEbOYF+Pv5ZcNht3xWwdoNk0pxcla0FqXkRShMse/ffpY
 S+e62+ZH2uolU3lHEgGTk4HpC+QB4qnyiNq8Gz+jTM1/w11uCgP+8XPlI7R82UU17O16
 wa63uJUul2LYIetAMMaJ5cZB/w2HtpOkS9S54r9/OJthWh2F1dsFqLAu3V2aos0z522u
 EGmAO3E74gv0Yk6eHiZy0cQvuHtqcd7HNTU7wGLfXso0G69MRsH1lO8ezAvjN0nvw9xw SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6hakcp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 15:52:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NFTmaN034523;
        Mon, 23 Oct 2023 15:52:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5344vwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 15:52:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTgJTEWvgo+4egrrX1USQAjmdLcvStTKlJa1MJ5FENfeAmKAp0gZhGfeB2nW+lpq8aO5XsHxaa3zPdoS3yp3liiEQ8eIcFi1Gr8+BODNafPPPR3eyXBfaUGITFGCmvcVGfXxsda3C3WsbAZt15+KmDtpX36wJiBTFecn+K+OQbX+SyX5/bSg0x4E6jpmvMSQeBcnAjcrXyheXuei26e2S2G6wq0SyJ/5oBpOFxkrpDeKmepOZZjr8wlFbvYcyZTLIbmbqNLQuxTzsm9ql5lBRqXj+p38ljy/4AfZ8BFJdjyx83MRw+Dh4CsKViWqpzYsIG9KICTKAbH2hcP4uC6IWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zryqm7gjuMceDSchaUEZjei9kvrlwZ/ZTpzDyB8K4bY=;
 b=dvYWDlvxwjMDqeEnKB0/CtGEka+RUR04MO5PUiGkxZWFXJPbDAc7b+CkBbr2bb88ftluo2j1dwBt5OaKxQwxFucqhY3gxzlzd5xvMGMH3aiQh3C5FQDszf943HAzt8kJmM1byBYb8iu3WQaJ0ty6leYcsKBP/5JQDUDt/GWkTd2Zqmbpk3PJD5na+VvmedVVZWzVEtpnNVD4bD/COClU1EQyMvmuyN83CHoU7URHBMcVODDcwVcSzZFgbHNQcFvEV4cJCr2AKj3BrucL3aUaxAGrEOsTaHv/wtWd6/UlgzLWJ3Wj1Ktyirso13j/Rduttvs9PeV1GPSqGpIWAlqGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zryqm7gjuMceDSchaUEZjei9kvrlwZ/ZTpzDyB8K4bY=;
 b=BhHr4GO4MJ99c5aHn8rEW3YbVj9PTiaekIYXYKuZc2LeNC9lqnYURdz/5075D7r1Np3qjyXlhfSkYuJTCkkEk0Li7n/i14aQeCL0Cc8i06Zu7s6Jzw6v3i0687XWegC80qtVLGYsBtGPFxzOxN9ggMlbMAz0sRR+BCbnK9j8AXY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 15:52:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 15:52:00 +0000
Date:   Mon, 23 Oct 2023 11:51:58 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Tom Yang <yangqixiao@inspur.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: maple_tree: fix word spelling error
Message-ID: <20231023155158.lyuu3vthvdrzmlaq@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Tom Yang <yangqixiao@inspur.com>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231023095737.21823-1-yangqixiao@inspur.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023095737.21823-1-yangqixiao@inspur.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: BN8PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:408:70::38) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: bf47c246-043b-4e95-27b4-08dbd3dffe73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8Hox80ExKYkJ19KeEwjc2P2gt8kK6XS6kMYVazOEv9xBJJ6//iccQuGP0Sap+AMwkr5i0g1xev4H2T/ikIlpff+bEsJKTBhKR2McBq8xYBZQxGhWwEnqBJzfD/rQrSY1VxjxZWAcZrpXpmWoGXFo5ZwwACFLROZVDn60p6HEJKPquYLAPnIUBG+rKlYxA76jnq4Hn225W8/0El5tApc15zY3ns4re3KckDF15xu8o6ce83+F4ZJMwjhzrjNIUqoRL9i9t6dc2DXgTS9RUnmn+V68XvvKXp4eDbcdelNXbR6EcTbn11bj2aVqzTcM5nVakjHFJQNo1b8zR/PDYQgSEL2vSgbt/rZC0Hd2jBN57ztvhPKK2D1sXMMqc6EsQaUYYWSMjjMcCocdK6pW3L+vCrOF73FN9ozlqDsFvOX/7zrvFb83alqiVZnf90XvNB4T0qPDS/0JlhOLaZ/b2ExPrnxng3PEzPBKetnI3HQbIJt2oIPQALTt6RoJQBcFrOJ6SU3NS3WbvnR0tHWmDxbS22e2rpVe+WZo6Ov3uR0jPMNIIVCDu4CXehlJ9X+Opcw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(33716001)(4326008)(38100700002)(2906002)(86362001)(6506007)(41300700001)(6512007)(1076003)(83380400001)(9686003)(26005)(5660300002)(478600001)(6486002)(8936002)(66556008)(66946007)(66476007)(316002)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eIQ5Q4S8m5VHG7s5dBB+gA23gShj7YrA1DbmGLXEXkZEjgtRgz8rgDUiWQDo?=
 =?us-ascii?Q?uLoR6YH/q0rC/kD/4fgv7ZEhB72stGJdaLDHN8BiGMykolpIw0LF/yfnAfrQ?=
 =?us-ascii?Q?WnM8uLdaCYcFz4t4PsWjREpZDWlfnzOguTa3Ioq6R0mb4mohcW1oQ5foSZ/8?=
 =?us-ascii?Q?xXv+0DAC63v8PO1PHBOOtkQOuI4hN3aNMGeuq69h3l18qa/iVisuRvHqvbgm?=
 =?us-ascii?Q?RsU1CFT2kkZPEU/CywA5oGIGLparev5W4PNw3ZzDxRzzquYGeuTGznTLDMd/?=
 =?us-ascii?Q?scthste8mjq1h1qznANlyRXYFbOKWmFCdfH14CJtduB0tN6bEhx+X2PZ/N81?=
 =?us-ascii?Q?fk9tn1L8Sn3im5tXbRjYGAWIrVrULZscc+faqc+KXB2BJaa/wjAoLZ4QDkSQ?=
 =?us-ascii?Q?8fAS5VUecV6jz6zfAb0Okn1BInUEJt29zvpo6GGVwnDjvMvJXDUveB4cVdOy?=
 =?us-ascii?Q?Rw8G+mroPC/pK0dPInuoNqXRjVJnqE3aTgZkuYjMpYycbldzwb8ZHRHRgyXZ?=
 =?us-ascii?Q?idC2qIIZ19hvyTf1doZeDgVg7yC3BgtuBeuSS+7dgeoSNfXb5ItXqSSefk1k?=
 =?us-ascii?Q?cSghdDm3JhKaf091rUldARyxzqoPpslNh3nY+E95jRUnEVpRO99Vd9R7qZnw?=
 =?us-ascii?Q?m8u37SBPUfgrm7PBoq7h26dVQyNFjmVxWR3Mhywa9V4Xtem7cefYU71e2Jya?=
 =?us-ascii?Q?wX4CgAHu+Sb4NT3Xu4m7epLmUJ8qvs+jF+ZVUfiEWT4CG2k0mAROmVKYYgJW?=
 =?us-ascii?Q?5avOJ+HLn4fnEYYS+GlZtPhXoM6Z0twfWG1mEsEPodYYyZzBmOFR3Nr6Zq8U?=
 =?us-ascii?Q?Q+slMJOUWzO8FPRv8oEWmHGrHLS405KoEmkEW+yqPp0v594HSc+PvTE3J04h?=
 =?us-ascii?Q?sxYtkYRL0PgNOfJG0+KTdEPAt1n62mZanBVTJJLmaMRT0CMxWp1Ze2jAJB2A?=
 =?us-ascii?Q?2oHCh7sgJewYgfYqZhh+PHrOjZEwXODqkz+Jfv3szSzQLm4ReMihrTCKXHcg?=
 =?us-ascii?Q?fOh2+49/urVjPCXKnooJA/W/9s9MngYIKhZT7lKYlM46LHPHStX2tkWVBmzE?=
 =?us-ascii?Q?6yOhtudficCR8hB38tmfOks44vDaU4NtuXWiaZjkRPM6zUW2jHSEykq9ccrx?=
 =?us-ascii?Q?XXRBgzV3D/sfomCYvN0dX6FfW58rDk0hQj7sYjsL8e6B+9Z0fyHuA+bu1Wrm?=
 =?us-ascii?Q?IAnBd+CbkLuZ9UW3y/aB3Jxc4QaA+ZZgQ1NwM/gotAvR6e5aOiTa11dCZxVy?=
 =?us-ascii?Q?ZJFLAjgYHqqEMLLO1M7C7kCL/4bf7BVdj9bGW1IzjKAKDBRFUIeiTSQ4FYfV?=
 =?us-ascii?Q?ALkX5nsCkMdM31Xfpi1vtGhZnhYf3QNI42bgC2pswdCQL1iQUy8YmgeWdOyB?=
 =?us-ascii?Q?SUVVzwZP6gh50/IzTQytAIVHqpm+ttpbRc+n9e4xDFtJbU44dGZ2leSLmgRU?=
 =?us-ascii?Q?gxBiztXluiX82sf9Nct8PPxOWytkoLfG97aupBGVW4fMXT8TKprncPWgICym?=
 =?us-ascii?Q?gkJEV/e45gs/VnCDl2woASUPWJJod/mIEWea7KLArS9uDQnK662FVGet95K2?=
 =?us-ascii?Q?JrIXmfvAz78gQcGByvGKAONwJybNAX9FnZ/VlD7T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F9B4armLEGcNnqi6Qdvn3jEN/hDS7+QBFY7NEGE/Q6JTAzxaVOD7JuCQv1tVfX3mdPIiZbcAyCCUsjG6zdxFXPUokGrRRLcVdJK5AWChPuLkoJqlGRpJM3KJMOiJ8b27b9xMvjynNWeLiy3GqOJzk6w3MLfr1v/yYK11/BhSE1vndvONxOfO0gPAlAN8E+3lwftcwCQagicS2k1pG4FQexUHyIc3/mmHJj8trBeeDidGaEK8KP2W4ycYy/H6VtGtCEmi9FlqMRhCAq1lUXMotNNY1Wvc9yDjdWU/ZvZczFyJXDimK3xOFKFUZry26Yj0C7qMTUZFwwppuQtafAlQSew5cB66AGiQujqlp5o0cZ9oA/Q48EO5fL6R7lW4dCbakGU64e/P2aAGgZHXfa1VXEoKKNMxc3QQbpkVvS2guqqLixrvSMtkPJYxbNRVxTQIOJmwogAFIKCd3zZOh1dDnSlXD3vDW3mO4lVUVptDnHHBYnNh33D16oXSPkbr7rjyBxOnaDpdIa6Ck+jsEd1WrCNsbDpnLN/IVvRpodSHVoGsFcajo9ljq0pjh59pxiLw0a80lKv/Bpe93vllOUuJbvi5e4qKprLkhVtT4kY7bAcqnmgAkute48GovUHs1vgkxr84r2ixiBcjIgEpHqfVCBWZj1fxs7pn2njhAyav1gwY4dZTcDzAmLJlZWupqNIddByn/+c1O8OgtJ5p73y05JkWNG/mf9ke5mL5D5UdfHbd3R4l0uBNeGs8ycPkVKEvrozb7yU9PtTCgDP1QcFqC1oCHb+Pp2vGYHEkZYbrc8qgTcj3ObLm2Gavvo8HSBmrYhSrgg11i5Huqfy8pL0Nk5zVpKTGDV2EBqV58BGB6Ey1z9FDBxK09vyXFODwYzl9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf47c246-043b-4e95-27b4-08dbd3dffe73
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 15:52:00.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYlTiS3/iqLz7jDYEB+1G6pWDW7w6voW4Jh3L81jNp7nc96V28nJjbz5UTNjpDegKGMY6T/68InOY4EM0zSBNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230138
X-Proofpoint-GUID: CTvmR4pQrb7tIYEXTTJEPEgKVRyEA5dU
X-Proofpoint-ORIG-GUID: CTvmR4pQrb7tIYEXTTJEPEgKVRyEA5dU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Tom Yang <yangqixiao@inspur.com> [231023 05:58]:
> The "first" is spelled "fist".

Thanks.

> 
> Signed-off-by: Tom Yang <yangqixiao@inspur.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  Documentation/core-api/maple_tree.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-api/maple_tree.rst
> index 45defcf15da7..96f3d5f076b5 100644
> --- a/Documentation/core-api/maple_tree.rst
> +++ b/Documentation/core-api/maple_tree.rst
> @@ -175,7 +175,7 @@ will return the previous entry which occurs before the entry at index.
>  mas_find() will find the first entry which exists at or above index on
>  the first call, and the next entry from every subsequent calls.
>  
> -mas_find_rev() will find the fist entry which exists at or below the last on
> +mas_find_rev() will find the first entry which exists at or below the last on
>  the first call, and the previous entry from every subsequent calls.
>  
>  If the user needs to yield the lock during an operation, then the maple state
> -- 
> 2.31.1
> 
> 
