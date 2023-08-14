Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D14877C2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHNVqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjHNVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A16CE4;
        Mon, 14 Aug 2023 14:46:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOiw0031613;
        Mon, 14 Aug 2023 21:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=HO2RnjDwcRC9EdAS/kU1kKfR+Zs9bhqDJeidWFTdz7FjurdGAQ49iPv28nivq9DUhEqK
 sfTStGnzfOL5RYEQ/1/5fCDFn6augrPaTekrDLvEImVE3A1rQiR4pcHZkS8IYxRqMGxV
 GCYxxhD+G1q3nD6u4o/01ls2etVzOn26xiXmBpEkq5Zurp4fk05WdCxgvi11gW2vjZ/9
 xNHfiggKXgO/xyuZNXG2tGz/z+dGZk2itJ+gxWBc0Rz4YSQFKk7cAOo8//DIcO1XB7m4
 PaPOK3ACNCTuq4Zh4eEwE+BL4NYsLvlibmnWbqwxFHbqYTZNzafrrblRrDD3alMUJQGw Wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3143ngq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKiNB3040317;
        Mon, 14 Aug 2023 21:45:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0q6536-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ddaot82ncsYJfhw7s6ob/RKizl+F6CVmeqk4y+bMHxtG1dQhIVd/xY38UO2l5Y4bjWg15tm6PMOscYebUJO+M9SR9ui7qwh5++/FacgI1NzuP7OgVLVfOtIiaLdv2hS9Kxu/ntXfcBV1rroYx07PfH9hHcI+gMWXKgwtRpEfMKx6lhwEUMyVHK3WbQkuyhFm+K5hKIGHfaS1rmVL+lFrZxgXj6ym5hqqCNEPvqsbvHIQ3G2vM9fCY2czDYeHp9rwEhizdlR2prHpHjZPULAcagbcpB8uqdY3vKEm+rZ7DEHC3tKzpSRxx0oiYpd2KYTGKjNeVBqR6pbvNjlNugONdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=fg2ekF6Sb8qcQ8ZZgkjkC+w5xR4GThM+8C/LX5ZbynOQG4VWfS27o0t/uJ+L0gjUCQApnQ7uzwL6Sm8Le0ygUdkpO9S+ZbEaJDhFT1VwRuP7Zstk5bk4xWKUUVv4F+sv+0CiN5Q8rQLmMSw3tNhxLo4gpOI/e8zjk/6CoZnlARIBT+VOtRP+rC5jkkcUy2QlMjs7z49p4s+wsfCXhPIlKxSysEo95tT6QtvVDd/DrorSXfsjZ4QqS8UwWiNYereM2lOZVAcP8jopadQl2gc0j5TfP2Q9lKlsFrresfNktBUaKMqgAQ/IyguNfP8MWNVNvjIfRld/BF6M29+TOla0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=Da7ShhpJvgoDaLiDUXcGy9aHr572KLyQyn3cq0EKnCpX78EFWm8SPXHR7oUy+ACA0VQw5fiLqeMpmYi2+oa70RdnakmE0iC7V1uLNbGNaKkmNQdb5203yFPr0rLcU6Ager3SxxM37LlB19aYjMVsJJFNHQOEqjLkRBuHbXcbwyc=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:00 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:00 +0000
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
Subject: [PATCH v28 3/8] kexec: exclude elfcorehdr from the segment digest
Date:   Mon, 14 Aug 2023 17:44:41 -0400
Message-Id: <20230814214446.6659-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0145.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: c69eede1-04b5-4f30-3bab-08db9d0fb5f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Ep8AaEm0f8nnBjkstKPubCGvLxdtYVPx3aeBNROtCb+wZdUFB8K7kDpsNwhSfdXNWsyPbbNWYh5N7dlmIq3ewIBc71+F/6pC5a/oWCn19PeIGnHFrhpix0ygGPJfxH4aXe5rN2qtb+sR2ww+nfwOeBnKlC91nIcSRmM/Fx/tV1rLlWvV/kYTeIduoazhScCLaLAJ1G0X3C3tFx4U+iyxnGc786IsOyWo4iFHUJXAWMjDqSZfw1zYGmcTWvu4qalsT9hInrVpkr3vW/xyu24NEeyjQnkiJn71gSFTrswC+0t78Mmpwl84IDb2MxwlicuejE18k3xBvDsdEgVzULgA5IkBWZ3BQ0rpK2IBCBXazLDoFRKsqpBfytzVj14NktXn5JemYAiLYddq9MbFW3Rvn5r3gbvzUqtCrmfcJy3pfaj59JZdak7ySGcV2PsusaQcCwVh+rb1EDXjxpXpzGj38+frQUYrRIw4XExBSsKtdYIVde3JCw7StIuzv2NAICZZdxQlHxHozT7baY1VqWYLRt6e/cHRqBlmNmlf57D1yiAnHvY4TvIN99cY8pcWZ/BqeQ+8FDh0c5rXZsTWAvbjfVcYeSluGb3pTEOQY0RUPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(921005)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(38100700002)(2616005)(1076003)(107886003)(26005)(6486002)(2906002)(6666004)(7416002)(6506007)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5K9dSC3EFByJ4bi0GbvO3WedbdayxhIClNeDk2kP81fHuB73wRzd0hK2Rws?=
 =?us-ascii?Q?gbelfBapMC9XBS6fa6TYj+uvPnAY2eYuT65PmrBbAOC/7n1dWn2BkgDGm3n3?=
 =?us-ascii?Q?CEiEM6Shrum/NUy4KJPlrsX0JDyJw5yJznnLjsZGcRoNul9ic8WZIpgv/5nE?=
 =?us-ascii?Q?LRvEmrcuBIG3N6wki1BFqQbdjWSE5aErhWvR4anKa4ZUhtTKHOw/b//chHnJ?=
 =?us-ascii?Q?ALUpPrK7bxisHbYnkUSyDD0NMjVr9WHHJ4kqSNYsY2/Mgz/IX+0FU2FQvJBW?=
 =?us-ascii?Q?7Tm/qLLMpgK/+Cgzladw7LXnomQMSvM86LY4Ax3w1sq/3k3an5sbsImCfpxo?=
 =?us-ascii?Q?nvOKWa9aYAQIhGMYh2Dqb5TGmrr4LobBfwYgEZ/NNGFsXszyuGXeAs6qSXgT?=
 =?us-ascii?Q?Y7+aLIbitZm8rZN8GWoj6/WR9/TbFTqAKmnRX1oCMGhfry7H2pv2qCRnnBfb?=
 =?us-ascii?Q?7MbXul7/cPkXFa2+4JwS7VKontpOV94HSiGqrMxae6b4W1HzZIPw0YWYowgX?=
 =?us-ascii?Q?JElOQHdKegNctx4lKkMFdovVEPLfiGEJ2BFzr7ZVS9+rDl2xNevM+6P+1WLt?=
 =?us-ascii?Q?fVJBRXB5rAFlX3UWSrOPDZ5Wo4KfSidspeoyL8RniBphvayLe2npvAHhjr42?=
 =?us-ascii?Q?v87T8MSnVFbAewgHHpxlACAVoUbR+Si2MAASmONJgsoLw3zGMdoWmda0f2Ob?=
 =?us-ascii?Q?0iIU1Ra5C2/uq+v5Rw2OvlevdwvbkOGDmlyaxda35jof0+AvxnNS0/SxW1HE?=
 =?us-ascii?Q?VYpWtye8yK4z2cMfO0ALZxR6Kgh35LC43iqEjWzIBbpbzY7cN/RBOKNPs4uy?=
 =?us-ascii?Q?6hscOw+vj5n/u4GYREDZU57zjVQacr/tgNqnoORmn00jK6M7TR50tU2mkDXx?=
 =?us-ascii?Q?RM3GGXlarlNunI3AWYDCHVM8yiKYB8ILcgWrxP1hBnx55Hjk9fIaTlTe+Wnc?=
 =?us-ascii?Q?moVrb02bAlVVQl+qQlnjJXNDwA4fYTv+Ty7Q4ZwFTuNlP4F/QP8dMH84mdfn?=
 =?us-ascii?Q?SdsOAzofY+p5GGmFl5axNIcEwOo/hByLZTtce0YvdA08shNcNdvEG0tb/NJ8?=
 =?us-ascii?Q?fWcOXOzklclxI7wNnrzqU4Emy4zUx4s/LuFFZ56CswSqdE4Q/koAUZYrcOYA?=
 =?us-ascii?Q?UDEkosNdnfHS3lQywITzgnC7HykTVtXYlfqg2PLgC1XaKZjlA79KbdmUVM1S?=
 =?us-ascii?Q?5tWQciOGb+ITehT2eDZFsBzLzq68cr6xA0e36FXkLYzkWoPR/vGBTwczFeg2?=
 =?us-ascii?Q?UOZodr+ZErbjZ+QCrp4wPfm+ocnMQHyKXeYwfVf3a8phLhNmjaoEu+7iusG9?=
 =?us-ascii?Q?Fp//HNPHBYl2V3nFvnADwjMyUPvoh1TfCUJviSqM+xRFAOArYqJidInX6m98?=
 =?us-ascii?Q?rkpTQis+tOnZ3+SAMB6tVlR3mbCFKfDAC5JZEuEOyYvbGVzI90+UmyaEJmEF?=
 =?us-ascii?Q?4cCJg2BBkcC5aPjEbQqlbc7xNud8AGDszn1vzrWXSBU+qW4Kfb2QuThSBGdq?=
 =?us-ascii?Q?mLhtGsPWxE2isgHXitIaUQsvsl5mC6xCsZL8aqBizKfNiR28x4EwXeB3jvup?=
 =?us-ascii?Q?+Ne/tmP8SQ81jUgkRtL+hsULltIGzOqycEtSh/ni8AyfCH/05Cypv5+g0E7q?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/PJgpgYF70evujJHaReFHSRMjqPX0blQrFVu2/uBZ6jb1SGrg0yxzRkehKaR?=
 =?us-ascii?Q?liy9qVHqozSezAQHWFlH5aKQOfMBAr1NNji4BUHxdZWmuJcppuBLQ5qWp8JJ?=
 =?us-ascii?Q?h52ovfDAxSVdQGhW9vkLoOKx+rrC3rUZIXhQ23HVOpixLjkVAxQGi1s3OBxa?=
 =?us-ascii?Q?6WBry7nAMke1wE+R3H/oX/kk5gjNxW5MKxueHimNu5orgWDt4g27IysiZYq6?=
 =?us-ascii?Q?jgidCGCzXLW0t8NcOSkvX8cgvv5bO8+ZOHv1H/AMCXS8AjOLFCIFGY+4n05d?=
 =?us-ascii?Q?lQsgUbm22yZt70rpANW9tTL4SpPJu8YOvq/qXe9MyloQIcirHhtFVxj/Zoq6?=
 =?us-ascii?Q?AUcfgyW2KxGIrl3OjDS3Qz2VxtpEBzDZ32L1lpXk7wztefeSHDt3/dXZ9l4H?=
 =?us-ascii?Q?E9Z+BfaOF9FPNZ923fKaVGyU2eaYxZWaXh6/mUfVuvjnUHr7ZZEi3g24skoZ?=
 =?us-ascii?Q?/o82j7DWV+FMtlx7ZIg09jRcJi4//LzXXB05Eg7Gtu8PgIFsRHcUbiJKIPo+?=
 =?us-ascii?Q?iJG4mbV1t65RIT3OkybDMVr7hm2MJF7vRLbVOo5NZVinWfyChCHZHxSoJOa1?=
 =?us-ascii?Q?7Bj6jGzXtnaUvo8SuxubYrFwP5pR+dDVFoDcgHatnDGzBRB7PrTJ8oEwiTlI?=
 =?us-ascii?Q?QEcl9TtPcwRJkJHyWoEE8Uy9DxXBputIp278GB2qC3f1cg+/mOn0Crf13du5?=
 =?us-ascii?Q?tMjpNv7pJ4D+Y89+AJIZXCJ6e3jz/Yq/cYkU6br1hKt8X4ccsSxM3gA1XvGW?=
 =?us-ascii?Q?aLJTded2zqARiDfwguYdta6C87r6/HM0Ig5YrKptMBG/LJEJn4Muxx76swB4?=
 =?us-ascii?Q?7x9EHhgyOu483IjgI+6LrUKONJ8FUpCOys08elbDA347PouIbeqs7PMA/Kdn?=
 =?us-ascii?Q?iKAYmqydDmBjbHrIbCBh8M0nb+ELey/IUmchNHHY7mOb5scSsH/KB8K2Wi7d?=
 =?us-ascii?Q?WFbWQLQ43XvWLyL90dl6VdVSe7koOuFG5OYSiFb4xvhpNLP8M+tbMSehaExr?=
 =?us-ascii?Q?RUbWqyzTpN0XgJFnA9bpyct4nuemHsU/fJ8yYiqTfn3o/9EmIwQAp0TJ0Ali?=
 =?us-ascii?Q?sXUQ7wCQMR53Joptp1XM3nsmp0SB/sh6jB0E318BV8In4XaPx2ggK4Wm90dV?=
 =?us-ascii?Q?CyyQbvnhb+Bs7XQzMTy/lDUtw2pW8gJPZ/s8iU7Tpbzob0FE4tHxcgvXmvp3?=
 =?us-ascii?Q?mAnnultUyC7a+FoNM8ouc1+5pfTxfY3oWJ0yp8iuXCHRkadvXL4n2h84oziD?=
 =?us-ascii?Q?9JUkmEFZPwGUgYneabRSyN9cD1/2tVMyH6UvqKmSwnc9Kmee7+EzzGCEwNne?=
 =?us-ascii?Q?2TFRpbyLol7HJ8geRcFanebF+ETClV6iIE8uvAkwiQWJZlPsygwnP6OnRQO6?=
 =?us-ascii?Q?iFaH4jJrVN8dxSpMqFNNK6BPOz/NvaeEKA56VPzg/31dA3AePQvQkCrAMPvs?=
 =?us-ascii?Q?yURrwAvRSC8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c69eede1-04b5-4f30-3bab-08db9d0fb5f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:00.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTKtRXIVQOdzP2hG2nhdPrctb/bXeZKPrDaQamzXqhoyWDSZ0pQDidMH71wY2NF8Klf6109flQ9xMiXRXGi4rOTcfp4MD5EkwLptj23T2dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-GUID: lMgr5zqy65Tc4T-BVvkRljFWKao4CnJS
X-Proofpoint-ORIG-GUID: lMgr5zqy65Tc4T-BVvkRljFWKao4CnJS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. The digest is embedded into
the purgatory image prior to placing in memory.

Updates to the elfcorehdr in response to CPU and memory changes
would cause the purgatory integrity checking to fail (at crash time,
and no vmcore created). Therefore, the elfcorehdr segment is
explicitly excluded from the purgatory digest, enabling updates to
the elfcorehdr while also avoiding the need to recompute the hash
digest and reload purgatory.

Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 453b7a513540..e2ec9d7b9a1f 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1

