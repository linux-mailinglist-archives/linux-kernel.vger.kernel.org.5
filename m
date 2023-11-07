Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986AD7E4C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjKGXOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbjKGXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:13:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B72D79
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:11:19 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJfbZ014961;
        Tue, 7 Nov 2023 23:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NIc4sxhZAhOKoo2VZ88Y6fbqmbPRGrl3S9o4NPWPM9I=;
 b=4T4vUd9IxkPvU94N34Z3y7eAp+4dKg9RrMRxJFgN140I+didke9VvhBbwtsDtiu6Wz8a
 vFtIPyywoikwVV0cmVWH7/b4C8eh+EenjCmP8MmHd4M58ZDuQF8b6pGhXevKqEltWnpC
 Wrkfv+//+E1eKjiidpvIKq69kHk5vp/7iwuj25bzaxrrbYuYQ4jFus4NMH/izBkKSENO
 mCyC8kF68konlv023lNx/LZoRG/CQpTqF88uFQX3DxzweD5Hrf6XJp3lJ0DawXuZ7Ffr
 6as40jf8jYoaWFAAYW3qy45Ko9qUKiR0Bdiza3oMwSHj7WwqC4tOPsnNwWwa5sjUEgd1 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26r63v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N2hOA003851;
        Tue, 7 Nov 2023 23:10:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvcpu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJSiMkehQBhYD9XSGpjyPA6h3kBuiuRPRnmangY1iKXnKxg7DMLgCzrkr9gp4H3rflk8VnA6BJXGof3zK2mBTvKEPZPSnX0a/8ASHphWNf4TnvQL5R0W9LgCFbXb3cOYfhHeLjP3SLcXCNS+rQDrOvnhFkSXc0mXpP4dfob6DaE4i6nv1t9oNKt09/anx4QsYywA38CeLmhdg4AtPt5fowSa6Z2Hm+F3r5C3Vk9F/w3qcjfNn1N9onAuvHI+sOLL5Jcpj3mTeK1tfsYzrNYNMxR2Y5VNPxJuLYpAnq3O+dXycuYKYGfcKD2gCQTayGuD7VhHDvV3ue+0D2RzUeQhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIc4sxhZAhOKoo2VZ88Y6fbqmbPRGrl3S9o4NPWPM9I=;
 b=T8rFaifas9wnSjcuuuTpKzmkjlwiuiovCuba4MQxXrOR1rFt9oxTt30p9KT8XU/cuuOPocw/sOfo0LpGN34RHpjX+eFTHqhBSJzIt1CEvoImTGKAGPiZ5NbmdJqUS+LV9P+innExOTn4BmfStv2n6ryzmQVe7OpryhMtWyj3Ff7YNj6KYWI00RJVs1YIaTgyhAjQULUoDvmx2HoV9qPg/kCNgNrIKAB3xxAPjemjtAv6pMMYth/H91U/thc5vA4R4WrPX9L1STIzuRN7TiJT7pfEZA44KuoMYhwRVnnZCF0Rqf4IupmcpzkWY+zo0wtDSFe61dOwMJ9959W/jdB7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIc4sxhZAhOKoo2VZ88Y6fbqmbPRGrl3S9o4NPWPM9I=;
 b=JBwQTfVZbp/BJ2c20xblXhueNUwPdKvHe0Bk2HlxwDWsb5usYGYWsBt0nirk6n6zdX7QaXp6vu2lLD1MF3ScujGaxvPIxMGMOpqWuOUJxiiYBaR9dmhjFBD5xUajWes8q+PuCyIkoo0uA/PHkiz5OlqHA2cgCF9B0JHCAG92c+w=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BY5PR10MB4369.namprd10.prod.outlook.com (2603:10b6:a03:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 23:10:05 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:10:05 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 86/86] sched: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:22 -0800
Message-Id: <20231107230822.371443-30-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0309.namprd03.prod.outlook.com
 (2603:10b6:303:dd::14) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|BY5PR10MB4369:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab9e4a8-eeea-4599-c2c4-08dbdfe6adb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cisvorvAi0nLDv7P/e1asv3CdYcyDpfyDp52dDRFhi/vIvM9JEG+WbxXygxkaKHbbxfuODJQrsrRPI5qbafXC0HZ5bbMqoQwoHrzWUDSgT2w/N4AtidU3JugMNEQne+vJqnteqi7GPu6HHNWQVEwbHqV1YPxAZGAJhL9Ex5nLeDbvpprHijz6ZlAYMQjtlWQEy2Ehdoggfou1kw02D8OFbomneo+hHZ1UbDdbkqv+/fW1W8DWpO15sJtz87P/sI3lwn41bwbsxs+1TKhY7GFdU8WqKfMKjom7WWv7OqRG6dIIZstfF6IibjWca4rToKPeuHqN7ezZ9xRwAQvT6OLcClox4G/g8jjWjXA4YqBSN69waqc9t28WqZYrrOgv3eJRXtE62Bps1GJR0YYlBSt1HJdNQJqG9MOlG7EUGGiaVqjkp1iedfdOvE2qCS6nWamW3dmjBkxPsmEXNRGDiRGaXuAS+AG3UAg1Ow9JlLLQUT7An+ME1a6p7WQbJdtnD8bvL4pb6kS0CB1ROtIltnKhTP1lzKPBOTw0/i2EdNPXjS8TIjMn8O5kulmrEHg6w14
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66476007)(66946007)(66556008)(38100700002)(36756003)(86362001)(103116003)(83380400001)(26005)(2616005)(107886003)(6666004)(1076003)(6512007)(6506007)(6916009)(7416002)(7406005)(2906002)(316002)(6486002)(478600001)(8936002)(5660300002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+/CeseBlY95e5aiG8p/Ps8YXI61fJlJTldjmPJ7vDyeA054KISJQs6TXOSYG?=
 =?us-ascii?Q?ynlkaMKE7b8X+uVkFhjIzeVnAT2vujsr6GkqfZpnmq6T+ywssaQxBgAjPY6a?=
 =?us-ascii?Q?xhvaVyx1CtHwxv9Jbf1DePra8nvS0SVO4dPwYUTj+RkHWWJ4xGhVC4iTEY3i?=
 =?us-ascii?Q?79Gu1c9QzCEKLQSqXKZe5YeAQl3HW3E1dSeuCu8kR367LC4QUNrInWIOEMHg?=
 =?us-ascii?Q?UHIpXCI+lfFTbBy13RszxyKpRL/4yy+C1I9g9huGpkYdzrcc9rExvuAfmEsT?=
 =?us-ascii?Q?oG+nK4szrPoNn5FD1X1rFvugAScer0CaFFI5CLffFeqfytENd1W1q9JCHGEU?=
 =?us-ascii?Q?80+K/TkUYaDWH4v+rSdvRZRpRtkBN+zjeIFdZRZeExFz/ed1M2s7ou4XWMc5?=
 =?us-ascii?Q?/ywYNnHi+P4UcQk/8pyTE3SroIkwBbVBqeu+AhVBBaqDU9a8Njm4vCY8QUjN?=
 =?us-ascii?Q?X1+KTbzDdKfSLbUab1WYle9MWGeL6qADNJ7dl+VsP/o6HUQpNTM4mvaQc3d+?=
 =?us-ascii?Q?Bv7QhUPka1Giw+upZAbgMK4tvNtG4Zfv0JoOFeTp730Dp7GY5VIQRFT+GCQ7?=
 =?us-ascii?Q?dP7brL5raNCOv13ZDwKegRiLp4P/3bR/CoOsp5d1/0g6F7GHEIv2nRqT/u+t?=
 =?us-ascii?Q?9gQLus5elN3ORJ3n1LSCr3vbRUD0G0+TImIr+iTXX7miIfB3PksmlrHxq49P?=
 =?us-ascii?Q?VHbIoAaOtIdzChiCNBEcLYElvTcN6jXV+DqJDv0QNA/CzvWjt7N1FTVfkuqB?=
 =?us-ascii?Q?2WBmfneejZhslvVdfWaXPZhI746bzSZGTac7bRUPBb0BPHPkyUGUIB46e7ZV?=
 =?us-ascii?Q?TUWnq/JF5u10q2aCZq1kY7+HvaaZz8MCSRPpDUcQgHt7SArKjJn9XuWXLSd9?=
 =?us-ascii?Q?1kKv+Wg9QaRqZk4Ri5Yo9Ttc47+vGyQeoWFRuTrf84S/ZYNyWVCO0agK+Ouc?=
 =?us-ascii?Q?sdogLbcGfSljOKGE3fKiEf2ObsjcHvETdm/hSlloBoi5JKQbCZosbr1jOtWm?=
 =?us-ascii?Q?6G/yT9oGAv9E1ZoJhhX48ZfQYfhQkuWheNyW1xEGxblhuHqpJ37Qx837ShMn?=
 =?us-ascii?Q?fz90elqJOa226sJL9Av5goahSOgGuNrarwDEV9Ab0qBiJpDSoDxuhvE++NBu?=
 =?us-ascii?Q?gownU3BTaZoTzfqtm9klzkhG/I4dbjon2W1LpkuoBXndFYsJsvPsqm90CO38?=
 =?us-ascii?Q?VjOrBE5lsjWfoQqE47W1XOl1EccYg2prgKmsdEZ7uRTAkNAudXPWo43qnCyL?=
 =?us-ascii?Q?TSqSdA4T/BscPOxHBtz3OiAlEvb6EyRvYqfyuYzKDbwcoLN0EdenbrGXRWf6?=
 =?us-ascii?Q?kmA2D8doKJFhWBwz88uziR+1ygriSLdzsMQxW+srwHPl4JF9Pyke6H0wAYZU?=
 =?us-ascii?Q?V5WiMMUBKOYLtchLY7GGNjZ2wqATai9UeRpDtNFL6BsICIDVw175NkKICKuf?=
 =?us-ascii?Q?TP/ARng41U7bmmF9G5PcemVG48pRqonvPUQMhqeQYkCIKtCUKe7zkERvPWZr?=
 =?us-ascii?Q?WIdyLH/hETX+hmb1zJEwHAqBe+JYjTwYwviSNspsx1eWl0KzI3sq7YGd6J4W?=
 =?us-ascii?Q?QvmuOLtZ3pVBbNU0ujvtzVxJISkPPJlN7iVShzC3LFEKklEaxT+/gbTmSB4b?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?LCx+7TTtqCxso/1nKIZiPPUsRlj/oLE88Piyj7ThHtOYcsKluJoNsGiwU0z8?=
 =?us-ascii?Q?5MtU2VXg6pG/Q2lW5mMj4nCi6bBrCvhltLh4VcgeTp2st5x16kTBOtDUHNAm?=
 =?us-ascii?Q?Rq75Oj0fx++8vdY4CEw3sq3W1oN3BqXVyFityECF3a1fA7ACsTP9Vuy+YEDZ?=
 =?us-ascii?Q?mlzZnd4f0vCCLaE0AlCdkZpi99iBFE1X0BHYqG9tQwd7usfqiDnHYlYsx4I6?=
 =?us-ascii?Q?ZAN0Lr/hpo9Ws2eiF+0vqEX4ujfkdaU7lUpzZhO2Xss/fwkg/sZntqK3JfrQ?=
 =?us-ascii?Q?tKoi1hxrZXhqoXksbIkuNASjNt8BITbEOwth22YwOjjIgqT6BYgqvsTVTXpf?=
 =?us-ascii?Q?RVzhSJ0x77M2VyvTGkgommWXJ84yLWtUq2xozvXUi21jTKqUHImvkQU4PX38?=
 =?us-ascii?Q?0Uu5lqY1czOZvecYaK2Rfgq067xpPNoqzL86X2GZYGjQX0McDXPgY7nCFmwz?=
 =?us-ascii?Q?Iqg7Psz3xdBb6lYP9r7z2LJpmCBhbNqqR9lx3L5W6sw+X0lYurf6Cue+TxjX?=
 =?us-ascii?Q?fqy8Vb90qaYtRhB/8FbUlo1w7c3VxOXjDm4DTu+KHmLjcfRXBHOSimvz6Q1K?=
 =?us-ascii?Q?kF377l2GfKpkumzrcFyzbulj+MNGyq4DhQLsLXAn79CAFXV16EJKzbF9EaLO?=
 =?us-ascii?Q?igbdQ08QfwXoWv4UheYwWmOKSOlVoV7/rDhBocoy0xIJlM/63b4uaI0+1ch4?=
 =?us-ascii?Q?Bky4OGxk7eOigy0wY17uAn5J/hjYbwE1rkh627vlllpChNihpUyiQMOth1sG?=
 =?us-ascii?Q?9VTGvfkJZpP9TcjrRozsINMdAzYlq59jfJMQd4B94D8wKkN2PiJUBft9QW84?=
 =?us-ascii?Q?peHa21KVPpGbemzqMTRDxC7DEQS1WY1+q93p4v335o7ICK6rKjrMTnRtHQvP?=
 =?us-ascii?Q?pYsajzLaCzyAwC6EVlCxH5X3/rUD7KWx9Vxy33fkOw51BHa7KjyKySRz3b3Y?=
 =?us-ascii?Q?RZCOUzuhonSD72TsWkMYIhsot7eBHKET6/eZ2JblqFRjzZ5PtZyJw4d6ewfi?=
 =?us-ascii?Q?Y1uNFxJbRnji0oh3ZXqIt3qt+MquTs98KG3SSvF8MMKK1J85tqVBIdNPvq6A?=
 =?us-ascii?Q?t2fgt5RQekHsoL6K8OT8iA41i9oZiGP+e+Yabu3sWZ0GOfktVMeQM1BuKkzC?=
 =?us-ascii?Q?NnfWNNUvDyFXebY5BQX3GKezeBUNvG+DI4rcRifn0bdIhO/4nw8wPDEqjFEk?=
 =?us-ascii?Q?m8lF3Lp7Vj/hXEvMrpnfO9I1N1uDLK18qtWqwTiD91MlJMuoDqRaKfAvn+vL?=
 =?us-ascii?Q?ttjXwWSbq7Ti5Jz4754XQ+FLV3fNnbpu18ufDGYInzmiw0VuUXoNgpsstV0L?=
 =?us-ascii?Q?yahEvszjYJ1UJFywy8ux6pZ+0iJXPvVTiswazqR8xiOm1b4ebHcx4TPU/Kax?=
 =?us-ascii?Q?ZYmDLp2nFFM6Q9AopmH2oaQwESvzfnkdUQbjZw10eou3Lty/mwVgtF2ajIqM?=
 =?us-ascii?Q?K4CNY5X0nAxbx2LaJBBz24Wvr67hQXM8Vz8D1JLS5/0hDnrFIt0FnVBBeVl6?=
 =?us-ascii?Q?IoLKfV7yVwglao0cDEAagMSp8EOl0A1il8iYtzHq15xdxgrDrgeVZtkfVg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab9e4a8-eeea-4599-c2c4-08dbdfe6adb3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:10:05.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLhjYNL0kdzDNHPPsX+neUSOF7lg1wPFI50ovP052Z4JJg27xjVWJeBByRDMDiwG4U17JZoNbtUCB6GoXB6shFnABkwZKFoa7XMpZTru0C0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=977 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-GUID: JorJD4555ZgyZRHWCma8OOr1r2tuLm2r
X-Proofpoint-ORIG-GUID: JorJD4555ZgyZRHWCma8OOr1r2tuLm2r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we don't have any users of cond_resched() in the tree,
we can finally remove it.

Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Juri Lelli <juri.lelli@redhat.com> 
Cc: Vincent Guittot <vincent.guittot@linaro.org> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h | 16 ++++------------
 kernel/sched/core.c   | 13 -------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bae6eed534dd..bbb981c1a142 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2083,19 +2083,11 @@ static inline bool test_tsk_need_resched_any(struct task_struct *tsk)
 }
 
 /*
- * cond_resched() and cond_resched_lock(): latency reduction via
- * explicit rescheduling in places that are safe. The return
- * value indicates whether a reschedule was done in fact.
- * cond_resched_lock() will drop the spinlock before scheduling,
+ * cond_resched_lock(): latency reduction via explicit rescheduling
+ * in places that are safe. The return value indicates whether a
+ * reschedule was done in fact.  cond_resched_lock() will drop the
+ * spinlock before scheduling.
  */
-#ifdef CONFIG_PREEMPTION
-static inline int _cond_resched(void) { return 0; }
-#endif
-
-#define cond_resched() ({			\
-	__might_resched(__FILE__, __LINE__, 0);	\
-	_cond_resched();			\
-})
 
 extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 691b50791e04..6940893e3930 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8580,19 +8580,6 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPTION
-int __sched _cond_resched(void)
-{
-	if (should_resched(0)) {
-		preempt_schedule_common();
-		return 1;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(_cond_resched);
-#endif
-
 /*
  * __cond_resched_lock() - if a reschedule is pending, drop the given lock
  * (implicitly calling schedule), and reacquire the lock.
-- 
2.31.1

