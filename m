Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11EA8770A69
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHDVGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHDVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:05:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0CF5599;
        Fri,  4 Aug 2023 14:05:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCmDC003843;
        Fri, 4 Aug 2023 21:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=ZrzIS4DzgJ+HXwJGvdd8C0VTiGamYO4V/2GbHyblaqtdrrxoYVYfAsEt8u8X6ozRvAlj
 FG8Ny2h2wTz9sGS6vSJhaZE3EXc3RWtn40Hl4rDsL4AsocqRiChVIKy/krCQEuWICHCn
 FE2/+Yx3o6Rd+FDJ+1+2mqukxM9mDYmxv6lRT82slV4z6jMIrSI4thF+qYsu3OQ3XpVQ
 ZAg5hJucKInTyGpmBEEzn+8rDjFS5oM8Kc7NpkfYu5ddakNin8eRGzWZiEW3XDU9JSbU
 4GOw/u+H+MV1C7wSQ3jC749R31c0kq/wiBMszPvdmVbjTIup1jp4t66oK1lsRMmQAOxN pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2mqfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374KOGHY006661;
        Fri, 4 Aug 2023 21:04:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kfhy0sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fn2mCMpRQ1FkfGz4bWap5hhOMfcyLan7nfKlHbDzi25bAJff3UZviJDwCFkQ7jEoLJ8tAbfNpC+OrtTspX+B/pLGly8/fWunZA1MxF8exzQaoDLZaYbo/AWRPmwlwJ3Hr5WISGy4vCESHpb8IsB7HAaNQUM4H2bYkkNyVQfsXYrKlwqBZFIhsb9vOFhCvT58ZMZCI9DgYJM70bFxY/hhJFWe0tYS3U8TTIFEq2qu/Xbt+U0DTnjrdaw1r2OejgISLtw7ttl9EHvlrMYEbkgKtiEu3yI/5v3TqpzOL2dHQeFYbBD4MESHos7tcVvv6Hss1nJj42KGs5LU7oOoLMOLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=FSQVZKnLFgxs1B3uP4Xa4gjEsYOpWsVDKVXQRlR6bcl8HS/RC3xaTL2uZmxzOMnZm0uwFOOq1EsJ+hM8J2zdb8eM8pZ5mxjLGkhE0EgCjDdMKcSyNNAxGvEL0rHbmdUdKJSfyZqkMscDD6rhveDtGM/tKOCR/vb2lIs+0cqWvGUkis46N0oQSpS5c80N6YE1cs26fbRhfoQC6uWK8y0eAkOd778v6RMEdbaEHvprgWcFdeGPfdNFnSsS2TP+4XYH9sT82C6gfnqd49PekCd1LQd1bJ6h4XkbarF7x5ykrogRlYdMvVma87M+oy3OKe47U6q7UCqvMdpNRijOAeiLGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neX4dgrHOHpPdCnxirrY8SJnRS3HP5J4e2JJvTSuYE0=;
 b=ZScOZg1zov56XGeOJgmFGOznxZHjEj0gr7T2vppWUlB/TqLlWSfdikICd2gunhx4lh9obfzyVuWE9JCPw50uMq2RU/GQEnMLdNppj2+x6EfFEitK+U/wYMwtLHcUpa9pWkCzhho8D+mgWqvWB/8CHzbaE3FxcwaDKfJ69x15Prg=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5014.namprd10.prod.outlook.com (2603:10b6:408:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 21:04:13 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:13 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v26 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Fri,  4 Aug 2023 17:03:53 -0400
Message-Id: <20230804210359.8321-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BN0PR10MB5014:EE_
X-MS-Office365-Filtering-Correlation-Id: cda28542-2064-4b68-5dd8-08db952e5b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCCaz4v/jd0q3nA/3sLoKqb86xO7+LwhNxUSfBUrZ+MLA5VGFzbWTA9TgqBRGY+/hBdzDwVWGPYFxwQZvrOM++WWyc5RjUP4uoP8dGNmll8m19diApqLE3KjlTze8ocOHiFC+g3XPJIxgdZqUOeb3tNePEHJW6poDxYEEQZAkcq0HRXqJHdShWfy6RZDVHyFwCMmIqT6uvUq1o5Qa1TCbdQDqvZkXWDICKve1S/bInm3I21d5s1KCLj2P/FJWhsxTDHKBSDP3krqogsYcdgaW5FXhLAgrlyjqxqfftCA/OweD1OS1b/RDpO/BizudYLA5jAU1/vyuylmnbWVO5m+NGgoh8zvQAu+81iTIVA56rYkfgMl/fnT1n7iHFzcg44mYYKi5T7VjRkS/3DrqKMt/FNI9nPpNfQZlwuQp7R0Wwz6WtKBDKuofYnWGGBSSlhaaY09gorMU05J/fZZ7KSnc1344L91UP3wiJGTI3NwY7RKwIuj7+L/Jp4qSDDk0v7BdQ4DUfBMyD0wZE77U9lQAgwyydIhctnMlB4ddo/YHWx+aSzTAReiKSCUCkLIvxgLEUkcSnGxavE+On4YQsy20FYXsCD7zRCqsP6W4ibJrjkRN/Si8zame2VGckeNFT5i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(39860400002)(136003)(186006)(451199021)(1800799003)(5660300002)(7416002)(7406005)(4326008)(2906002)(66946007)(66476007)(66556008)(30864003)(316002)(8936002)(8676002)(41300700001)(478600001)(86362001)(6666004)(6486002)(6512007)(921005)(38100700002)(6506007)(1076003)(26005)(2616005)(36756003)(83380400001)(107886003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gpKWD5eayypUovxEl1EkCwLnomjZvuSr3/RroGTDv05I1uE1NuVIfG189VFO?=
 =?us-ascii?Q?o5eDG10lcX1lINFineRqGKQU0Faq9/29+W+0y4ADXlZ7evuqzDaeM7m8wFdM?=
 =?us-ascii?Q?FWQsVuyxCUQ+12cxmykDddAYMvpxgDoxLgciVQMHPeutjXDMaDPBS2iry0gS?=
 =?us-ascii?Q?QSCT5lgjU6Gea9fjMoNLmAbPCPVmQI8qZjg491JQ2FobFW3vIVXtVDx6fM5O?=
 =?us-ascii?Q?0rvhSFa0JtXvGlbrT3gF6IVCf6MKL5LLHR4HaR8W0+APWdPKmC5g4sdR3TDI?=
 =?us-ascii?Q?O5fQGCqQyNbGJG2UmvPOBcPO6umHMSqL9xYBM4xfetTpHTWpFLxj0oYztl9Q?=
 =?us-ascii?Q?c5IIgsMty0rqVz1kjbKmihts5UKAMUIuu2TXA7/zId3H8HRpNNvQ9BN6886r?=
 =?us-ascii?Q?Aa76HnldgQFiIpLUcgMcIjG1JvFYFLLk9dYOXKMXkznC425u/88CFi2hgi6V?=
 =?us-ascii?Q?wzNjN/TVQoErGjynXyoDxwEbwMWr4G7YxsZGbsLu+ZWFC57txNrxkY3Ul+af?=
 =?us-ascii?Q?deam0WFs4IebzIGw/IDo3hA1CWLxLsLqeqBkKpwIWnHvdx1k76iEKQqE/PF4?=
 =?us-ascii?Q?YyZbs0TBxM8+AvSSmosQR96VdfG8AZ09nH9XYa1YIyUywJ9jH+nr6xSP0qth?=
 =?us-ascii?Q?UyPBLt+JZxasahZ91mnXUQL1kJ0In9xMvP/0H+Rwtw/R5kRqFygakNsK3Iwb?=
 =?us-ascii?Q?bICuWByDgpBndeMUIniVJSvvVNgqV1aMIcfQKlt2T/6S1MjdenjqiS75RBrL?=
 =?us-ascii?Q?DOz+wFfJtBzXTo/6KhYaZtvghdbJdt5Ch8rtzUI+/Os/if0HgvkSnP1+V9Ct?=
 =?us-ascii?Q?OKdyM4SLKjl+r7zs7m9OBsswdRPQrl754hDL5cEWq5o6odR7bS84GR6baJeD?=
 =?us-ascii?Q?jM5/eYK4nKmZbXxdjCWnkIpvusm2lk+fdhrMM5rbe4dGX/RLXvviyhj9ObKY?=
 =?us-ascii?Q?/JWw/VPSCho4YOBSN7Xh1vPk4nxU/OGyh83GefN3NmEWvx2wMH3dd/M6WZi0?=
 =?us-ascii?Q?p9B8mp515IVBQ9qiPm30oniMboGc1xSHm+mK9aXnhl8o+o194hBsC22dOnTD?=
 =?us-ascii?Q?7rj/Zo/Bt9KZox99kDFnh16d10+Txaar5yMagIvk2zUQGutunWWotQFonmA2?=
 =?us-ascii?Q?FBNP1qtQG9UlyBJgaMFV1svBCZ1aa2rjHPP0TXCY/lnh2kiFE9gE7oyV4OtY?=
 =?us-ascii?Q?rPVU10Ac7lh3NNHWx0fr/OR2ohpO1mglt8+Sr0xpIu6HJoOO29WrMQWUGoJP?=
 =?us-ascii?Q?qAzLyMbAX7ENKIBvBnuIE5WdezF9oKdouhUL8FPyqXyAoiAPLOBcwZnzm8ZK?=
 =?us-ascii?Q?s02I/QnSuZSfwa9yu9tFr1jofz3e6V0s4fEOuaFx63jQEUoA1F04aOxemtqE?=
 =?us-ascii?Q?O7KjXeZspc5anU59/CmDdnq4oKn3lAeqtmmfY+nuviZCDykWzQCagxHHkEnL?=
 =?us-ascii?Q?tZJuZo9gR2CfRVgUM9TKdEUHjWkwdI1fN8xucK3K4oQRC8IlJmhr0+2e2/SI?=
 =?us-ascii?Q?4srqSW6dDJDgyg7dHiQwA5610ZwaSZUOshP+xBcFkRT7m9CWcVwBDNY0tWEV?=
 =?us-ascii?Q?at/2hEw3iL8dQubFBp90CJgIAlH04f2RlmkwY8stRtgJKbmICPyFJNzhC6Jl?=
 =?us-ascii?Q?Kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?sX8tY+4JyTU9YYuGDjSAJXyIgW0slUAZRe3QUbWaKbSN8YEwY/lxF0bvcHRC?=
 =?us-ascii?Q?Wh9RPzu/ikZi9N6PmSPiTOKQi4cmQAz4PF4tdGf0Negt07ojnlAM+8sxdJJQ?=
 =?us-ascii?Q?Xop4BAZEqkzq3hdHWaUr/0qYqkxVWrsYX2fMgbbE0O6c+e423o3LXNKPl1Fh?=
 =?us-ascii?Q?UWFy8/jCro7W/EiIZ6IBcwnLP/UriS2fuWvJKqLwczVV66RvZ1MkaPjH9hDU?=
 =?us-ascii?Q?gsXlNBBfv0kgKWzjKDBMJCSwLdLcrd3ZdFYwDtmcVDYego33WxYCBoCCbq5E?=
 =?us-ascii?Q?5QrOsKImNdlJ5FI1qCfaqroU2Ki3Jyn3pW6RSzMb9MgVLHvuOyFxryB93S0J?=
 =?us-ascii?Q?iwfJ1XSIOyumVFIlLKV4n8TC6+RDml3VEsPrE0fdLhCG4ZekMj+CRaDGQP/4?=
 =?us-ascii?Q?Xj0vW81dWzqSVEGSxiCqUjmXjp1TOamrSHaaM5rib9p5dK1YuX8vScd4CMBh?=
 =?us-ascii?Q?4gZ4P3wne1hJO5iBfCwM+xSyRt9o5q6oXXntSlKzt3VV1AXnkhLehJ/5S4ge?=
 =?us-ascii?Q?VvjHGqIEEif82DkH/SqEmTQ5XH1CTzadxedjXwSYyNNZIAbM/ylHHUCABH7j?=
 =?us-ascii?Q?MuEAnEP8U++QIgnDVGVwH8FyBsSMpxSL9bcdzvMyb3JuhKtOH68HEcQBq5ZJ?=
 =?us-ascii?Q?fz6PO1Lc/M7wqMp4lAgrR3Ed1wX7AmrJHxT/caEeQVRMgJR1zfRxOjjtdI1N?=
 =?us-ascii?Q?/CI37s6xXuZ5MsWm8reFVPyuPoyNQehXPkY+3+3X82l2a6A4plK0UgWdfGMB?=
 =?us-ascii?Q?70zGXYnjn6l/J2Xhqd+scovf6ocNsQ28lfFq6nVUcNfKUHMvdyxshH3PVg5b?=
 =?us-ascii?Q?o2u+29IedVw8P0QhWh9zxQhdgw014YtnWGOZl/+RlTLYjVs605J8bq7VeYh1?=
 =?us-ascii?Q?RFh8Y3wG6utwCzgV/Ibaqu9k4hSxJFrifye0FJxUJpLC3h0ILsqxN8BXuyOV?=
 =?us-ascii?Q?9kF3XRPnxbWJ50dUtRoFsTFIwZufXYMsLvMpSwBQdDGWPVO2NjQFtALXkGya?=
 =?us-ascii?Q?SgFwwktkUwcZ5UDtpFPiWTPsm9JYJW9LNAa9TtORWf0CQWvzYVA/31IonO23?=
 =?us-ascii?Q?cLMScNPfFvoBrZWl7oeNP7vNGzp9FKDljuCmw0bHDGtBS7NP0HasD6Uu2RTe?=
 =?us-ascii?Q?Kh+q3WTX9UH0EkQWs01eH1QY2Ug5ERTm5MHlcuZ0vPFEHoCof5TnzEJkrKc5?=
 =?us-ascii?Q?8ayavbwDFg/IVa99dzMafP2yuLDHx1KEU8agEl2wuxPxYvEl0UTjBdtAItw1?=
 =?us-ascii?Q?XNxWBvxRohfrT+OsVV8XOz8ZM+CDBIWUxyh8hv1cXWo4iIlT26Ct0w/EKWd5?=
 =?us-ascii?Q?jgbyw2kM1jNIoh6bRSKLoS8zldHpXRN7BguZzJbpKZidoiVNXv5gTON7/6h5?=
 =?us-ascii?Q?aOBWy+mDhUxWQLCeVIb4ck0XI2SGEK8AX43L3Da72Ai4dZOp4IrIivIkTfgM?=
 =?us-ascii?Q?RbRliv4tKT0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda28542-2064-4b68-5dd8-08db952e5b04
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:13.3426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1D1oPjO+shdVdok5suCgIvBTIap9HhSbkrv/zIkjwiOYEmYijNB3jfNH3JN/G7C5ZyzIHnDvWpXmIxSricYT98h58KJqsuDNBXLc/GBHims=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5014
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040190
X-Proofpoint-ORIG-GUID: 1bBX5gwz8DQOf04qH5gSUqk-ykFMEJGZ
X-Proofpoint-GUID: 1bBX5gwz8DQOf04qH5gSUqk-ykFMEJGZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index ff72e45cfaef..d0a9a5392035 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -113,4 +113,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..53d211c690a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index e2f2574d8b74..5d323255862a 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1

