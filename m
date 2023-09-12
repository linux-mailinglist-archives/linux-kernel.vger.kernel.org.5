Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5379D36A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjILOSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjILOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:18:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65210D;
        Tue, 12 Sep 2023 07:18:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nRwJ025827;
        Tue, 12 Sep 2023 14:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=oLzFSNVsuBalZ1RhYYhnc0OTq1qnaLbEjTRLxk8IuSo=;
 b=CAcsFebX/dl0DmjucRHQy75TmioPAWCHjJhNoBvzAnShItax+8C87WThTiNmhC8gxA1v
 eZ1fDtQbLxgaX4079SNng2c2dGa9rRmxB1YsLp0dWcagDV89BmJUDu829GZU8aBI3Wtx
 2wBfudAsXFNDYRvWvQbRBOANSoJcua1YMJxZHyKPwFsu9opsy0CBkkUlUsL5oe1gF7AI
 cRGWf0UrIGiDLysTp+PSTGi7vZHNbuDnEotWa3Lj4n4qDGPDbkmoEH/3ZOtw1TO+gYCI
 ILsIA6HOPvFDnnuiTXVCXH4Fxz1vo0Nm3h+2z2gfnWucHtxJsGeK7KQBSsaLvAGJBHpy 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jhqc42f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 14:17:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CEBYW4033027;
        Tue, 12 Sep 2023 14:17:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkf2ufm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 14:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRzbZEcyoCxcNqEuGiGI3BeFvN2pKZNK4RfZLwJvuuYpnXyafa1J8E7o5WI6I4Rwmec854xNlhzIUI4V4QJIaAN/SBmJ1Y5LemrjPMJGElas2cavpEYJME7QnPjwedPWlfLFAiDApLfGjCtBJiN+2wPpkWT+HfL4thlPNTn8ngycNQ1fLMguV0uXdVgJTtZ8Z083RlAslcfMTigDAYqPP9NtTuswIsEU5piwEAUEAVLjlj9Dguuuq7OxL5CnNZsZjet/BCYifPeNXXsltt0QM5iwslSUNTPSOajy1oEXmEKaJ4cn0cKIOKa+g6CrlDcwcEQJS31/L22CxX0uXGmyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLzFSNVsuBalZ1RhYYhnc0OTq1qnaLbEjTRLxk8IuSo=;
 b=aWvyb/qIdNzE4URVnMU8PD3JPv6fYvBpk4Ot10jYyBGH7eqtMeDdJuq22BxGPdLAU8yWsIkWsxrQmyYfllbrJzM6ziMHsh+eOho++505vjSll7wsREmaucYn/AMJ3utkZIXBA3IfdrtGdl9N6zuEeLqnL1yEJeKyLeS1Psebnft1EmFlr26yr8BR+xIYEikq+PLMeVBNLdYPSv8OOqUbTMdw98iP0MMY5JErNTgP4346vlFxPm4c7jvvYK+5VY8v2auJzJrUZRnopZsjm+Fs3RsI+RDRXrLHefikRJMK+7uf3SI9hkK0goZo8OMJk1oh6hloOf2DHh104tZZ4Yomhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLzFSNVsuBalZ1RhYYhnc0OTq1qnaLbEjTRLxk8IuSo=;
 b=noD69mBHdCirWKI016CvbdZnDtH+S95OZsdjLfYUzCqSO/DL1uGYKnGa6CvW1/JC5LXHq9OCYtH4UjUbqURrLEG/gieotzr4FJotjD3u5U4lMEaT/2yBkw09VJiVDeNnY4DJwfiw3UIS/qtsk3cr4wiGef3v7F8zu+QeCB9dMQE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 14:17:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 14:17:35 +0000
Date:   Tue, 12 Sep 2023 10:17:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <20230912141732.k5l37d4xeiwssaln@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com>
 <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <ZQBxPmVmBJ7J+b4B@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQBxPmVmBJ7J+b4B@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: 27e62cc5-8be0-4d0e-d249-08dbb39b02b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRoiX2nxYMWAJaNQnnKduh7tTHWh9uPIz05t4gxrFdk5Qdf/7bM0lxXUoX3h7XD37M9gJIiH6LnZzKHpHUJAcmNIOp6Gaudl1LeuEgtCP5rrbnujOsTN1sAyL5YUmRpUilRtoMCT1SX4k0HaFSZqb42TlKUKn0I/HahK8sF1qLB41pPyN8xYKscmAv1Dfr0cSAO4nXDrIRIc/xhkue1mxxBbZDDGlXFD/hEMEhG9Zr+UZrh6eZaj9/Df2vbggRiSlmxnbfWUOtMrVY1LuJvBUSMo6vf0ZKKArx9SySVtIEB0s1JqkSBf5Sxv+PqcC1jgywUlwMzFr3zjRGsx2/1vQYFh3/Emm5T02ahRhxqo+qBt3HRySdt5UToCYot6eujPy8uxmpfcNLAMjEU4wLCLml39uqhQdO1awa/ZuvLyydrIFV33+ATnIHDdPGcESLiu7xowdXoPw0kWuYnC80bOTpHfLlqRdetd01z2Q0W7N4BlIZ9N5hDIBO3laTxQkrEn6sh1H0A5Ci4la9QIUO+gBEQ+ITUm8XIp5mxn+o4OhUquB3/oPcKcnzVtt/L1GnXS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(9686003)(6512007)(6506007)(6486002)(33716001)(38100700002)(83380400001)(6666004)(41300700001)(1076003)(478600001)(26005)(6916009)(54906003)(66556008)(66476007)(66946007)(316002)(7416002)(5660300002)(4326008)(4744005)(8676002)(86362001)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/q1yN1Rdw4Tc8HTF2/hoNByaAHT+3n6FLmHiOcrNzBHuO6GMbq2k2hgrjwNc?=
 =?us-ascii?Q?uPupbldYQ03vFVvwIuBNAopCQYp9P2pQqaxrVjmQFg1usojOia87eb7qlxBG?=
 =?us-ascii?Q?hcZeTXI+SzMkycNv9POQ2vgSwuGMfbnWWW9BuTfvhlMDQ8oPRDX3SfL+Lr88?=
 =?us-ascii?Q?y42m2PMWD7KBrGibKfg0lUgmZ9eQMOC1ojhAT5XqGxkMG3FmgH42AyeE3WXh?=
 =?us-ascii?Q?C4F10lo00V9hakd7ei5V1S3k8pQ3f7hxMAhumfm9grUerPFQQck+d2KCcyln?=
 =?us-ascii?Q?u23zoBvYcNSG9zeMhZllGaVE5UrvKsOKr1436VFNicJxnbYqrLytuqm6ilq0?=
 =?us-ascii?Q?EdDflCX9GNmfIzWZaSId0f3GTVwkompuLaXcN3zNuRA2sJA6T+bvyWWCV3Ub?=
 =?us-ascii?Q?1JDLj3DR37ubwIlTszX4OsoEZbuDum8wflnKUt4aVyrhTC+P2AEjPBKPCLim?=
 =?us-ascii?Q?AXQirzboAlEOproQBF7bJ0CTFf87Fg8XXRnf9L59XaTRUwpp0Qn8q1fS9Gvq?=
 =?us-ascii?Q?BJNSXMvBGy4KwDaMs6ip+WuhOCC966YXqDzDLpwUj/ymbOUMVX2wDzeH7Rge?=
 =?us-ascii?Q?4xeYIpuXReBZjXI7YceHljma30HI4Zjn9wodDBa8kJzzpcHQcQRYtcYVtzaW?=
 =?us-ascii?Q?WlDyZfry9gmiOq+dslsE409a1+JC/3389ScK6M9TbK56jK9/6UurxdEYr93m?=
 =?us-ascii?Q?QCZ252OT/K2LKtEQbVNzdL/uhZF9Bulx+fbyAyK9DhwBr/HFii+950HEXK8e?=
 =?us-ascii?Q?9SS8csECvt+Qz8XZoipJQiyh7rkPm5DYISJRXTGcKqtpS9fb1DIV1zXaebSP?=
 =?us-ascii?Q?DCg+eVdaWBSIr1KE7grPTp9ssEQGpyyCbj7EDZl4H2lTh3j7bBYo6hEOo5qb?=
 =?us-ascii?Q?zhsw2UqGWqhLKPufUqTmDi7H8gW+mvSdwI9q367De3/L5jDIxCpkyngWM0BA?=
 =?us-ascii?Q?sZ0gvXeWIKgYs9G+ycvTPFO0fWGSewSXbZyiBkxobJtICzsDObNC0QzEmAu5?=
 =?us-ascii?Q?8Z1lB6Eh7/tqEXjfvygK+K+FwbXm0vNt9/rxTsbGoBzipguj32H64kXRFxuC?=
 =?us-ascii?Q?pNbgt2MP8RpSbO9N8TospCKLmGOa7TTfPrK0GaA59SgsaxE7umPH7CzSlZlK?=
 =?us-ascii?Q?L5kzdktHYdRMzbpPbmC0kRJzwV0ui2yz6C7TTmVAvyA3SScHp+wDitPRP+Bs?=
 =?us-ascii?Q?90YeLgekz8THl9QFtHfLGgGcDG5EypYobaHoQTBUCVtaeh1PxO7myRmo1A2I?=
 =?us-ascii?Q?Hg0PKmOXM5ygkGAR7PSmzr8/NDzBTbKLsYCyleX9XscQMCbjMFWGtrJ6ku3G?=
 =?us-ascii?Q?EWEuwm9zib7L7SwWPFDp4fqUoUNmAsHgTnuIyZp/Yg6BuDoSiqOQ6T3KaUeG?=
 =?us-ascii?Q?iIxK4KE6KPkNLx4gGM5m+jLtdR8Slcc737pN05vPNUPhBLgsYAC/5FqIBunz?=
 =?us-ascii?Q?Z+NpcMliz+1O+du26CPpHZQKQlw/OcuZt4qEmr60YIvvKMNrqRzsTsc7cMQo?=
 =?us-ascii?Q?jEk/SGHWihltPreuLGOuIl2vqChaO8cH8S1MYQmCBKrcu82+un4H/XVxYhBL?=
 =?us-ascii?Q?XVmmg1nmZkXqonBCQborc2htuhRlxwU1RL0Q9/v41mAGe+63xpMUuZv3aV7z?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UFx7ZvA7U5BgJt+d4+mIsUDNvzI2/sELcLGA8j1YV9PNgyY6QEZ496A//Fcq?=
 =?us-ascii?Q?pPb1ljwWGhEER3wSYnrnF1tmh54inHPXAVxc6MwsXZiQkoPF317HpI3BNgnV?=
 =?us-ascii?Q?wYXMupwU0rZsphcmcwo8NdPHIdGG43hNndgJ3sLQhdK4WTC0mDlHfkpM+Jff?=
 =?us-ascii?Q?RYDBGaBffnCJYy2k1rUMjWCPUx80qLpPV8Rul/MsB5O0QchCQSzJlMoWDtDc?=
 =?us-ascii?Q?/pU9MdI+aPXbpCDnkw5dMqdjt7Joh5p2tC7F0CZpRBptq+1G2+zfjPW58kue?=
 =?us-ascii?Q?Pc5wgrtPcIv8NW2Pm4lTFhrKPuH3XaY9hTkfDxiiXdqsGSaj3BYj2m7R+caz?=
 =?us-ascii?Q?JA/ATWpS883Y04d3QnoBaqZ0OT6oya89CWIvgZ+2SZsbsnGVjl82woUrwcCH?=
 =?us-ascii?Q?tvpvMRfQyjHLdtibBfk+hcRST4sF4jOzM35x3YreOiObNBXcIkhioADxGIOi?=
 =?us-ascii?Q?5hOh87bxPIdwSBAPXr8B3kldm4YU4vUy6x8sP+b3BFYAg6mDmfEkE6uXTcp/?=
 =?us-ascii?Q?4cX2Qdqhk3Xh18ur2NKZ2Q85wNP7YNm3DrNgKRlflSZt6Xyi3Ss1CI6XSdJc?=
 =?us-ascii?Q?+Xr/TL+0DJRFC9XiDy+5inf6Ra1PXvQ5EJUQEBIpj68QEvbDNWXjxj2QaEHU?=
 =?us-ascii?Q?eRltI3N8C4QBtfq/qPzo5NEB0HoQUhEvlI8hgH/lM3//tN52L7OBZfVTy1xa?=
 =?us-ascii?Q?92rw2ndZxOh0PU7xe8hzJMNXZdw7/erke4aptV7ps6Ovfva7Ebm7XsOmFYUs?=
 =?us-ascii?Q?4bi7YjLN4TCn5dPhWpMZuOWd7hJh/K76QOIiUjycCDt94o74vS3wYRGeDZwM?=
 =?us-ascii?Q?GmQn7WE9FyAb6MqwXeI6BIULKJ67Mu2DvMzW28kY57mN8H7edvgZWG4AI0sg?=
 =?us-ascii?Q?LGwwA5Fn3+77KtJ5HmagZp+YsNkIJZ0PQpbMF/YQUaWivItagKLY3GSp1HE9?=
 =?us-ascii?Q?mx0O8tL1k1HdU1rPhjEo0MHII8iqcIAHMMWm0mONqSDsICkJx680/f4ZYpoN?=
 =?us-ascii?Q?V+M+wV+C/bmJUOUacmNmupZwuA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e62cc5-8be0-4d0e-d249-08dbb39b02b8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 14:17:35.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MO6ml/6dSLOtQOOukxBLYI4nnNwMmrZLv8nQZNI/1GS9BAwPW8AMczO6FTO/0keUBh26B8Nv03BfAHyTPC+2Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=669 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120119
X-Proofpoint-ORIG-GUID: zokvGzj_7ESlSOEbobv2uXD6i3zEZAGn
X-Proofpoint-GUID: zokvGzj_7ESlSOEbobv2uXD6i3zEZAGn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [230912 10:10]:
> On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > Taking the mutex lock in kernel/irq/manage.c __setup_irq() is calling a
> > cond_resched().
> > 
> > >From what Michael said [1] in this thread, since something has already
> > set TIF_NEED_RESCHED, it will eventually enable interrupts on us.
> > 
> > I've traced this to running call_rcu() in kernel/rcu/tiny.c and
> > is_idle_task(current) is true, which means rcu runs:
> > 		/* force scheduling for rcu_qs() */                                                                     
> >                 resched_cpu(0);
> > 
> > the task is set idle in sched_init() -> init_idle() and never changed,
> > afaict.
> 
> Should calling init_idle() be deferred until after interrupts are
> all set up?

At this point it is not platform specific code so I don't know what kind
of fallout I'll produce with a change like that, but I was wondering if
the thread running the boot process is really 'idle'?


