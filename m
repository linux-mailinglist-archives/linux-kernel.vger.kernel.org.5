Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875DE7795C7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236501AbjHKRIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236452AbjHKRII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:08:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC571FE3;
        Fri, 11 Aug 2023 10:08:06 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDQ57h005218;
        Fri, 11 Aug 2023 17:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=iWBTz9lm7Q5PhCFFrlgp7j1jCEvXGH+qanl/eke+7vo=;
 b=fiPdWr/dxawTp/favVEWjiTH6sjQ7s/teGbgR1setxATv3zBoB8AGVtrSlNhySM+nFs5
 ZKCMo2wieue+RW02XY0sNgDX2pAnp/00aAh0nV9yDonkxWWlxO+SAHSeelA8HFoqrCL2
 l1brReKpFvQIIMWChi25nkv654S4I4fmqoJRNb3gGOo5sPrBcNa9jkBE5uz0vSJjOQqM
 whBS7ot1NtnaDWG1K3Osrd+mMxcKcpvUO5drzOcb/rQhkB+4Bu8VL1ZN4m6mva//trOw
 7pZCX7CYVe4wLdzGS3ooezvWgggVpQIpzooyCb46ZmuW59RETu+GcN3qCaYzo3yIUbMz 8w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y49gu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:06:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BGQOic033533;
        Fri, 11 Aug 2023 17:06:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvakvby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 17:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI/8A1rhey+tVCwfkMwTX8P7V34ygI3HX0rWlK1Xt4m0DnRKrwSwUYHsjthvTr22TGyI7xn2VzvylgZRKkC/s8OWf/LDJ+G4XnvucjNiF0BxtXThR6cLiqqeiW8Mx3DLd6fyaJcIYq4zy08GwMMMOTLmZhKbctd7awXP4BIEzdbyTWgW5qfrPKDm74LM0DW85OWr1JyiVAUefPANUUqHg0y/5wJ+ik6iTRHkxrl+MGkirD+eKvlx3ALQhbZYU4iuBk9iCCv+41+Pkj7iNDeANqqQz2e6lZj+6ezSFvhnRZjHakJSt0tEMUJBENr6ezWG5rL2I/oB0bT8aLg1wBOZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWBTz9lm7Q5PhCFFrlgp7j1jCEvXGH+qanl/eke+7vo=;
 b=Qj4Cj8Tx4mU8r79KXVwsfnPeEIjT+xmZKXBskwqX7c7+3GvPLQ97eyAlRAYQ1bKweZ5fLyqTv++hKZQAU77DZ09pyykUsk2CCIEEOyEAN/aJbtOGIf0u2S+JBuoLRc2K149oqzosZGd1l5FlZ8kWork8OmmMeQOd6DbOl+bqpR+nm+fc3ksCh6pF03MimYPrnYtwDcyF0gu/Ky4kluXl105k8C5tBE9LGk+8l2wFC11MhvO09kJrqwqsiMOecF1ED0IK1LL2NABfj87EzLvzrzLv7O+v/tfaf3kclBb7ds0yFWmAQYFYZm93CzmMRbdMcwgaw8NbfGyD/Y6g2khdoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWBTz9lm7Q5PhCFFrlgp7j1jCEvXGH+qanl/eke+7vo=;
 b=piXDZLdMj2aI91g6uUDAsEJ9J/HFsPCuCdHb4oR4q6hOfPBID8gbrcmA+J84O14bnlyImgXhRPvZnZVzG0/xQIwVfpz37c8dxU6ABry85+Dz4mFuQSVfCauP/QuP5NXexpDk5HVeFTO7QbnsIY5/uRqq8tCYvoAN5/Sf54Qk9iE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:06:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 17:06:51 +0000
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
Subject: [PATCH v27 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri, 11 Aug 2023 13:06:34 -0400
Message-Id: <20230811170642.6696-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0101.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 477fc6aa-56d6-45c6-90ff-08db9a8d5a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wln6YH8/CQwVUS2GmaVwLO9/fesAMt8kmZ5Y/b30qeOv8ikUKYvR25SinNf9wTUCMyI93flnhwEAdHPuX4iGaEJ3WWZPkKBAras3g/vNkkFkM7x2tnEBFWgSfDHIjMqM8yT4YmO/0svHpxWir0EOdPo75U/QVTHbhZuMhZulcfGOgFub4x24uhabDIBh/Ob7x9bpTUaZG0MxJu1OaJIcXN5Ff4O0jtc18fo4zRp7+8Zx7LCGVUcrb+fH2UdIcEYeJt1uopvFjOVUwrBdt561M9xVZm7kY6X8TuMp8anpsTSHx17L1+f1iBVkFmBQFYC3HcpUc+In/wNhZvLoM0ufetZiYmDz0BbvXAOv+XH8AXRDRfvrF3t86AK4Fo7xuju+zBjdQ20VUIlgDx+X5UGMWPRG3XhzW9WNC3T2ugcYGtV48/ta2wdR5CcnJY1Dqb1PkBwkivG2Xl7VqVVEaFYeY9hbAwIT3JESsIT8xTFbdYmoQpe/DSm5ePasNuSChB8TudmwpH7GPaLVnM5Ug98ARhG6zEsTlMxrKHIbkPDZb28tD8Zv4ExgID50iJIMf90BUpB4JOGWW4fevPGvMLPsMDgqwO8wFdyO+8IxQeKWcHhI9FJbb0dM/jT1i9Dsqi0G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(1800799006)(186006)(966005)(6666004)(6486002)(6512007)(478600001)(2616005)(6506007)(26005)(7416002)(107886003)(2906002)(1076003)(30864003)(7406005)(66476007)(4326008)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(38100700002)(86362001)(36756003)(83380400001)(921005)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eY1EPu9ni11fR/l8Ny3GMXqd6f58f97tz/jA2Q2jTXHqAM1AWVM8VCtMygje?=
 =?us-ascii?Q?BShNlXhsUw6h0sPk/3czeBf8Uagm/ytKcFv5XEwYew4TYkjXn3KXcIkgAnC3?=
 =?us-ascii?Q?SAwzdw1kSkryqqTRR5JbviF+yt0oNxli+88Nu07v0MKJI4isqGqrnDLnMhgZ?=
 =?us-ascii?Q?ve13z2MPce4YOf+kR4Es0JaF85UC9FUeiojnIeCVJ1cob82BxWVHzkglNLlf?=
 =?us-ascii?Q?+p/OM1n7m051Exq4vjIYU4Ik/yGezq8Hkr945C1qZfZJmgzn1bsdtXWOLihH?=
 =?us-ascii?Q?3l6eMJhwSZdD7SE6TFbb3RKY/QHkRj0UvqaJ+9tXddaDRxPE9krCoXyYNram?=
 =?us-ascii?Q?qlBz1RLnP0KvP/Rm3JWVIZXPllbn3txGx+ObD2gr0KFi0t33ZetZN3R14Sv8?=
 =?us-ascii?Q?5w4o3aH+aF0u15Iu472orBecoofY37BDVN2nuIn0cn9LiC/z97wuwW6aRKOY?=
 =?us-ascii?Q?U1f767We/IXDqWzIoY/SCyoIy4qThwJQ3I7lLyz+7j2UMs/sxeE94jiBPFGu?=
 =?us-ascii?Q?7gMPo3S5FffsSWPEGy2AiNWYnV8kftu0ut/ofakE0bqjr1RuCAuW2cETdxKU?=
 =?us-ascii?Q?N71wTbG3OdWw5fHg104aZ85a4ncoqpcDJXg66f90pgBLk0/cGc5uXpdZEVE6?=
 =?us-ascii?Q?mWVH1EQZeZUm3bfsASPttYrfljrzlmsBmWTsdQ57pqx8tOscYG/b1TiC4BBg?=
 =?us-ascii?Q?T7NagB0wwilUKGt/I6Z35O21nWb54nZexM8EW9dbdSlF8JVRmv+725agJ33s?=
 =?us-ascii?Q?4T/UCnzVIwesaWqhusojdB5pLE69CtI4ooYrctI0bxlI4ynN0KQhLfnGNi08?=
 =?us-ascii?Q?C9fnXTdPevZFXYt1euB7Ng3QnxlVfFTX/jYV+AAsq3bqnBnRwO2DXMGeTVDo?=
 =?us-ascii?Q?EHhosMlxlPD0VbRlwMVVeC3AXbY90CPNDRdBWuNMpbZ0YJu1uD5ZBY1uGqjC?=
 =?us-ascii?Q?obh5ozXm8avs5ODKN96wMwi+knBfpHx2lof/nEGrrfU+CPkJzkW2Ou1BizsU?=
 =?us-ascii?Q?FWK6yeIZsXFI+yJLIHe95RFVAfjSJ5gEeKuPjXUM4NEBN7Q3LpO1rzc8hszX?=
 =?us-ascii?Q?yAE4taaI4wYUBUF7nu5Jg9YIuUc+v3oUOymF1FBF0spOzDO/c9VBVeuZdynH?=
 =?us-ascii?Q?c2rMOzCr1XyXGJJ05sEc3G/9S4j7Vv4QupM+i1rH6Fhwaj0NTY9N8F0h95pJ?=
 =?us-ascii?Q?seUktkIpBpC2nR+yiuKXlw8Woh5ZrgWnqGn8WP6T191k1Mav3hyJUHAWKTxw?=
 =?us-ascii?Q?NsAXSc9XwCBuQNReTlVfIfo84hjbBqjvuY0PVjTPLG6cvk+QiP7BQrMYjbmq?=
 =?us-ascii?Q?3ky0lfqRRygviHYrsfZlHgEptCJ1D+pC6RkgvpRWusWsMf3/z81/7UJk7LJn?=
 =?us-ascii?Q?b3jpg6vEhEmNwdHGld3rCWUujBPRPzwk7yXqQ1aIZ+rGquRev4p+NAqujOjg?=
 =?us-ascii?Q?irTnNLTjBhdLFlH9z6DGRz+EgLhpYdbRpbJysK/+UPjTxjFX2T+QC4hOgpdA?=
 =?us-ascii?Q?bFKFNKq+9k6yWn41P0EHJGS8qNGoWX+BXivyfBJ3U0sMWTMIbLWWE1yXqjNf?=
 =?us-ascii?Q?CVTvaW4j5Kf/nazFJ2gZXbL5dQ8yoCYYFZwbZ4ezLypTUbib3I1rfzloQSN/?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4gucXWlJkWxOme8twUGrdJaMIcIGxHlENUqHWk+Im/atKBnPl4Z0+o8VJb3E?=
 =?us-ascii?Q?VPh5uRrf3SNJcideYIPyStR5xu1lhZLWXmxJ6WLH0pclO9j97KzOGZxg5Pea?=
 =?us-ascii?Q?cHlktIVI1YqYlller2tXyWbxkv9+a4YxnYlPoHSLc2S0UbwVR3YSVf26M3EQ?=
 =?us-ascii?Q?iy6Jd1yIgYJv63Hqv2EUwakZfWsXQNHrWurB2isOABkqN3ygE4Ohq1r1tzp3?=
 =?us-ascii?Q?bfXZC2emDWT/jC3wk8/U9rWuWy/t5QqdV1dMH4NG3rAgu/lsUJCXjIAkJWaF?=
 =?us-ascii?Q?QBdasz6jsshqu8QywPIHWXEBy5zBpkglZ8BJ8bfJeFiVpQKo1VtdXTOYfuNB?=
 =?us-ascii?Q?rC07LRLmAlkOzOdHdIdQRnG3hw9ZZc9VilbIbT1NI/DBFubvXAb4QWRqK1vV?=
 =?us-ascii?Q?lqxNb1KcbOl4yucwsnveKxMWQIq+czfedkPv8OdkVt2os5E4P0ASL+lLjBo9?=
 =?us-ascii?Q?qn4qJ5SuSVUed+k+xE68zDUdXH9mAh3l66WxezZivW5dK3TFEb4xeOSWB+1K?=
 =?us-ascii?Q?eZiiULQ6K/b6j+1CenOt35ORNNi6zpVZLtznPhKKkTo8AAQwlylwxRFVTgFq?=
 =?us-ascii?Q?9BAFRelKe00zxxC9Oa9QzQfJYmAlGOcFJA2wkvEgJMc2xlYA9GuEv3z7ShUg?=
 =?us-ascii?Q?/wZ+RHF7UJRC5p8jNimSNfdNmPauYws2awTKo/j3sRMww4Yh/PMkt5WXhDq/?=
 =?us-ascii?Q?ozlxJFsKp2gPDYoepyaG7cCBYW7R3wpWaRyaoi1YM07RQBZVHaXs5nfl0nBW?=
 =?us-ascii?Q?kcMu4Xqm1B7RxOHA7f6BaiyIWLQDygAmcL9NzMNJv1AuaeStHI3tm8u+sllz?=
 =?us-ascii?Q?kmVUHisFlQIckT2Lf9xlJ/FvEDWpIIKPMWbZp383hH+SSqC2a3xpdRfFxwy0?=
 =?us-ascii?Q?b8p2uLBcFDpYQ83DodTqwxA6VjU3qPZImaXINqlKETS4ip4gInrUDJot8C5k?=
 =?us-ascii?Q?JJB2qUWriBzZOeseuFYffzcVbJSFGRHfh4gEdzVrM2FAGze6q9Orv+JlDnb0?=
 =?us-ascii?Q?LA3npDC1e8qfEAQPO2SlazutTUm0UQxPUGapVwaErKa3mqOm0kRxqxUOJ7Dy?=
 =?us-ascii?Q?UP9J2lxth82sJRQg5RaLusAmD26RoGFkvvsdFlI0+CCcdKh2R6AbQvCUHrXz?=
 =?us-ascii?Q?xeAgWdFzPhmvwVaDvGoMtENZLfOj6hL+yUn65L96B6V5PTaBP9g9Prto0aE2?=
 =?us-ascii?Q?B7CmL1Zj+aBC4Dhgf/XuHYbUFupTaeVu9wZTjphzAPHroIi0z+IHyFxw1d3y?=
 =?us-ascii?Q?I6z3IXi9aVVm9/Y6s010NA0Hotcxv7V/6kejOC/nLuPntHXZ0iQ36nKFhDAT?=
 =?us-ascii?Q?jCcv4YTwkYuKU2gxY1XT6G6JNxraLzTNLbraQsuezbFwtuf3y9zGnycjtznv?=
 =?us-ascii?Q?AF3YUwnoCS26K7OqsnGYtj4wmKKleGrVweMI3gQe02Gz5ET/sOXo6VpeXxpI?=
 =?us-ascii?Q?eiA+hpXG+pU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 477fc6aa-56d6-45c6-90ff-08db9a8d5a71
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:06:51.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYZg/E4dAiDp6fN00BVunLai3R9uiOC+YTSPx3iBzh2f+q2xGmuDXtPzyC4fzUpozRXbRO7c+TJ0gdefoB1IqVKzVpEzv3irzwSJfA5pEfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110156
X-Proofpoint-GUID: Uar2PqYNdtmEaEbS0w4RdinBpMVC3lWi
X-Proofpoint-ORIG-GUID: Uar2PqYNdtmEaEbS0w4RdinBpMVC3lWi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is dependent upon "refactor Kconfig to consolidate
KEXEC and CRASH options".
 https://lore.kernel.org/lkml/20230712161545.87870-1-eric.devolder@oracle.com/

Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr must also
be updated.

The elfcorehdr describes to kdump the CPUs and memory in the system,
and any inaccuracies can result in a vmcore with missing CPU context
or memory regions.

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (eg. kernel, initrd, boot_params, purgatory and
elfcorehdr) by the userspace kexec utility. In the original post I
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash handler that registers with
the CPU and memory notifiers. Upon CPU or memory changes, from either
hot un/plug or off/onlining, this generic handler is invoked and
performs important housekeeping, for example obtaining the appropriate
lock, and then invokes an architecture specific handler to do the
appropriate elfcorehdr update.

Note the description in patch 'crash: change crash_prepare_elf64_headers()
to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
enables further optimizations related to CPU plug/unplug/online/offline
performance of elfcorehdr updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory; thus no involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the RHEL udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel updates the crash elfcorehdr for CPU and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   With this changeset applied, the two rules evaluate to false for
   CPU and memory change events and thus skip the userspace
   unload-then-reload of kdump.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load() syscall.

This kernel patchset also supports kexec_load() with a modified kexec
userspace utility. A working changeset to the kexec userspace utility
is posted to the kexec-tools mailing list here:

 http://lists.infradead.org/pipermail/kexec/2023-May/027049.html

To use the kexec-tools patch, apply, build and install kexec-tools,
then change the kdumpctl's standard_kexec_args to replace the -s with
--hotplug. The removal of -s reverts to the kexec_load syscall and
the addition of --hotplug invokes the changes put forth in the
kexec-tools patch.

Regards,
eric
---
v27: 11aug2023
 - Rebased onto 6.5.0-rc5
 - The linux-next and akpm test bots found a build error when just
   PROC_KCORE is configured (with no KEXEC or CRASH), which resulted
   in CRASH_CORE enabled by itself. To solve, the struct crash_mem
   moved from include/linux/kexec.h to include/linux/crash_core.h.
   Similarly, the crash_notes also moved from kernel/kexec.c to
   kernel/crash_core.c.
 - Minor adjustment to arch/x86/kernel/crash.c was also needed to
   avoid unused function build errors for just PROC_KCORE.
 - Spot testing of several architectures did not reveal any further
   build problems (PROC_KCORE, KEXEC, CRASH_DUMP, CRASH_HOTPLUG).

v26: 4aug2023
 https://lore.kernel.org/lkml/20230804210359.8321-1-eric.devolder@oracle.com/
 - Rebased onto 6.5.0-rc4
 - Dropped the refactor of files drivers/base/cpu|memory.c as unrelated
   to this series.
 - Minor corrections to documentation, per Randy Dunlap and GregKH.

v25: 29jun2023
 https://lore.kernel.org/lkml/20230629192119.6613-1-eric.devolder@oracle.com/
 - Properly applied IS_ENABLED() to the function bodies of callbacks
   in drivers/base/cpu|memory.c.
 - Re-ran compile and run-time testing of the impacted attributes for
   both enabled and not enabled config settings.

v24: 28jun2023
 https://lore.kernel.org/lkml/20230628185215.40707-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0
 - Included Documentation/ABI/testing entries for the new sysfs
   crash_hotplug attributes, per Greg Kroah-Hartman.
 - Refactored drivers/base/cpu|memory.c to use the .is_visible()
   method for attributes, per Greg Kroah-Hartman.
 - Retained all existing Acks and RBs as the few changes as a result
   of Greg's requests were trivial.

v23: 12jun2023
 https://lore.kernel.org/lkml/20230612210712.683175-1-eric.devolder@oracle.com/
 - Rebased onto 6.4.0-rc6
 - Refactored Kconfig, per Thomas. See series:
   https://lore.kernel.org/lkml/20230612172805.681179-1-eric.devolder@oracle.com/
 - Reworked commit messages to conform to style, per Thomas.
 - Applied Baoquan He Acked-by to kexec_load() patch.
 - Applied Hari Bathini Acked-by for the series.
 - No code changes.

v22: 3may2023
 https://lore.kernel.org/lkml/20230503224145.7405-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0
 - Improved support for kexec_load(), per Hari Bathini. See
   "crash: hotplug support for kexec_load()" which is the only
   change to this series.
 - Applied Baoquan He's Acked-by for all other patches.

v21: 4apr2023
 https://lkml.org/lkml/2023/4/4/1136
 https://lore.kernel.org/lkml/20230404180326.6890-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc5
 - Additional simplification of indentation in crash_handle_hotplug_event(),
   per Baoquan.

v20: 17mar2023
 https://lkml.org/lkml/2023/3/17/1169
 https://lore.kernel.org/lkml/20230317212128.21424-1-eric.devolder@oracle.com/
 - Rebased onto 6.3.0-rc2
 - Defaulting CRASH_HOTPLUG for x86 to Y, per Sourabh.
 - Explicitly initializing image->hp_action, per Baoquan.
 - Simplified kexec_trylock() in crash_handle_hotplug_event(),
   per Baoquan.
 - Applied Sourabh's Reviewed-by to the series.

v19: 6mar2023
 https://lkml.org/lkml/2023/3/6/1358
 https://lore.kernel.org/lkml/20230306162228.8277-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0
 - Did away with offlinecpu, per Thomas Gleixner.
 - Changed to CPUHP_BP_PREPARE_DYN instead of CPUHP_AP_ONLINE_DYN.
 - Did away with elfcorehdr_index_valid, per Sourabh.
 - Convert to for_each_possible_cpu() in crash_prepare_elf64_headers()
   per Sourabh.
 - Small optimization for x86 cpu changes.

v18: 31jan2023
 https://lkml.org/lkml/2023/1/31/1356
 https://lore.kernel.org/lkml/20230131224236.122805-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc6
 - Renamed struct kimage member hotplug_event to hp_action, and
   re-enumerated the KEXEC_CRASH_HP_x items, adding _NONE at 0.
 - Moved to cpuhp state CPUHP_BP_PREPARE_DYN instead of
   CPUHP_AP_ONLINE_DYN in order to minimize window of time CPU
   is not reflected in elfcorehdr.
 - Reworked some of the comments and commit messages to offer
   more of the why, than what, per Thomas Gleixner.

v17: 18jan2023
 https://lkml.org/lkml/2023/1/18/1420
 https://lore.kernel.org/lkml/20230118213544.2128-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc4
 - Moved a bit of code around so that kexec_load()-only builds
   work, per Sourabh.
 - Corrected computation of number of memory region Phdrs needed
   when x86 memory hotplug is not enabled, per Baoquan.

v16: 5jan2023
 https://lkml.org/lkml/2023/1/5/673
 https://lore.kernel.org/lkml/20230105151709.1845-1-eric.devolder@oracle.com/
 - Rebased onto 6.2.0-rc2
 - Corrected error identified by Baoquan.

v15: 9dec2022
 https://lkml.org/lkml/2022/12/9/520
 https://lore.kernel.org/lkml/20221209153656.3284-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc8
 - Replaced arch_un/map_crash_pages() with direct use of
   kun/map_local_pages(), per Boris.
 - Some x86 changes, per Boris.

v14: 16nov2022
 https://lkml.org/lkml/2022/11/16/1645
 https://lore.kernel.org/lkml/20221116214643.6384-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc5
 - Introduced CRASH_HOTPLUG Kconfig item to better fine tune
   compilation of feature components, per Boris.
 - Removed hp_action parameter to arch_crash_handle_hotplug_event()
   as it is unused.

v13: 31oct2022
 https://lkml.org/lkml/2022/10/31/854
 https://lore.kernel.org/lkml/20221031193604.28779-1-eric.devolder@oracle.com/
 - Rebased onto 6.1.0-rc3, which means converting to use the new
   kexec_trylock() away from mutex_lock(kexec_mutex).
 - Moved arch_un/map_crash_pages() into kexec.h and default
   implementation using k/unmap_local_pages().
 - Changed more #ifdef's into IS_ENABLED()
 - Changed CRASH_MAX_MEMORY_RANGES to 8192 from 32768, and it moved
   into x86 crash.c as #define rather Kconfig item, per Boris.
 - Check number of Phdrs against PN_XNUM, max possible.

v12: 9sep2022
 https://lkml.org/lkml/2022/9/9/1358
 https://lore.kernel.org/lkml/20220909210509.6286-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc4
 - Addressed some minor formatting items, per Baoquan

v11: 26aug2022
 https://lkml.org/lkml/2022/8/26/963
 https://lore.kernel.org/lkml/20220826173704.1895-1-eric.devolder@oracle.com/
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 https://lore.kernel.org/lkml/20220721181747.1640-1-eric.devolder@oracle.com/
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 https://lore.kernel.org/lkml/20220613224240.79400-1-eric.devolder@oracle.com/
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
 https://lore.kernel.org/lkml/20220505184603.1548-1-eric.devolder@oracle.com/
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 https://lore.kernel.org/lkml/20220413164237.20845-1-eric.devolder@oracle.com/
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 https://lore.kernel.org/lkml/20220401183040.1624-1-eric.devolder@oracle.com/
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 https://lore.kernel.org/lkml/20220110195727.1682-1-eric.devolder@oracle.com/
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 https://lore.kernel.org/lkml/20211207195204.1582-1-eric.devolder@oracle.com/
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 https://lore.kernel.org/lkml/20211118174948.37435-1-eric.devolder@oracle.com/
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 NOTE: s/vmcoreinfo/elfcorehdr/g
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (8):
  crash: move a few code bits to setup support of crash hotplug
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  crash: memory and CPU hotplug sysfs attributes
  x86/crash: add x86 crash hotplug support
  crash: hotplug support for kexec_load()
  crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
  x86/crash: optimize CPU changes

 .../ABI/testing/sysfs-devices-memory          |   8 +
 .../ABI/testing/sysfs-devices-system-cpu      |   8 +
 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/include/asm/kexec.h                  |  18 +
 arch/x86/kernel/crash.c                       | 140 ++++++-
 drivers/base/cpu.c                            |  13 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   9 +
 include/linux/kexec.h                         |  63 +++-
 include/uapi/linux/kexec.h                    |   1 +
 kernel/Kconfig.kexec                          |  35 ++
 kernel/crash_core.c                           | 355 ++++++++++++++++++
 kernel/kexec.c                                |   5 +
 kernel/kexec_core.c                           |   6 +
 kernel/kexec_file.c                           | 187 +--------
 kernel/ksysfs.c                               |  15 +
 18 files changed, 700 insertions(+), 205 deletions(-)

-- 
2.31.1

