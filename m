Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFA770A99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjHDVLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjHDVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:11:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB106526D;
        Fri,  4 Aug 2023 14:10:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCaKp019555;
        Fri, 4 Aug 2023 21:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=wi3vl8bM8eBasvGR81O1W2GEtNnCz6QoTxkEkdwLlZ9bJKBvG17IHs6Uqwez5bI7wIhp
 4FQWjVQ0TqccROrF2v6KlQ7JZZvpbFBWCK0TFVvBoLw2JvkPbiHxbyJLHK0R1dBO4hco
 qw3rBeidv+PBRdDsMILtOm+kltpQ5LBKO3zoAJ0NlyN87fCWjZkD9qMKzfWk/8j4zwXx
 c6kCgcVTXh4E7KNGG2UDKY5Evo+2oQWXssrFNSvhpxJoTlPzfuX+rCKJkX4Tv5gC0Ovc
 CaeRY9uGC8YHj8fcvDmLXtvF67vDGk/ZOQH96UEcCJUjhosxuRhDUAaj96O7ot7RgbC1 bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbxr11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374J3nbQ029416;
        Fri, 4 Aug 2023 21:04:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29nqa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeiAWsFDpImDckZwXaqewtveodbQ18j3Pm+mxr5szJz/l/VL1M6Y1J6h5xQkTjrd7peOrHRRdvreqOueHDbZXVal8U4sdRJmnfA7fQY4zlcbewAwW8S+NQLfG7K7zIzHs7W6qMTzlxW1x4h8T8tIjaWrM2cVPwVfcuc2wvr7V9DxLGVI5rMG/r34W/Ew4AN6rIBJInl0PKIHyqr2g6ukVssH/oMwnAEWf1IX4W2ro4zNWJMMNefu4KFP+GY4M0bpO6W4rZa2BCGcpGJCILPDayarXt342HeJxbxTPCPypldu6B87AiQNZdKBoQM+Ad9fwNsdoo3+Eb+EljzPA/3j6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=kOZrWYXVBmESkAL67R8M8WVyeRCzQydYLDAi6z0FLVWHt9Z22luzbAI+KDt3uMdytYSh5Cp+lBw7/eYh0Tsd7hBE+hyiGqa//di9uRdJQnuinoCpIMmB1Z5MzIjZkb8la5nmBz2D8BGLFuuGFWd2Mzi81KTpjnEVesxl9DLklnfP7eBVJxSyPU9Fva+nDzdipv+FnDixXQnxyv5Vea+UaAQ+Sf1kIx23HGyfN1nVZsvIjB1EPgzZdlXE5a88MHBty/swecbEGlMJLsQTveJpKDZOlfCrYNwJCIDfi4wFSS4ynQkwgyYv39nGF2w6TKUTpQRixH0IyS53QpREzalsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpE1wqVtb7MplpG9Vaelj6riR98OXh5MaMtMxiY6bCg=;
 b=VhYLquOCcJMSPrlU2oWJs5PfOOiYn3tIuaYgs9k4GsUpMJgo/AitcGcewhbOVLaT4PVgzOgIWs99ZRRaC4gR2NjRVGfZhBM+SMyRsX5HAoOlcXRucRsHdbxZmSXRxrfdr922VLVKSgs1UfeHpGI8BHLyYON4JI0usv1l9LHI0hI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH7PR10MB7056.namprd10.prod.outlook.com (2603:10b6:510:275::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 21:04:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:16 +0000
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
Subject: [PATCH v26 3/8] kexec: exclude elfcorehdr from the segment digest
Date:   Fri,  4 Aug 2023 17:03:54 -0400
Message-Id: <20230804210359.8321-4-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9)
 To CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH7PR10MB7056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3afe64e1-d745-4c96-9743-08db952e5cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dsEiHiLaxKRP8JTJzuGbg6i/hNa/+iEffD6M1pyvFbYc6llajn3wG18q0t++uLTnjWZ0f4wc9gHP5fIGhHL7PoGXe/G4hZM6tZhNYYbNitKkfybBq8inft1bFK6+f7+dHEKPHD0vIf8++ppGX8dwsgjP97Me/tmC3dAtB4dqJyF9EFQ0xgO9z198HHzBNJH9NkxbXC+hTvc1p6OZSZWYNXcrRqhfqZGpLlITHDImv18Klb/N/x4HnwrmrE1TgZxwtTQc9qjs3/bRTpt7ldLpHiamge64NYEnUkZMRw4Q+bL8gT696I8z1Ut7aShJjcfTl5XeDcHH24RIHKOyadnIwnr/mHRvUO7ykZ8nXQao8K4PRGQeuTdmOUc0pJSYdt9llvvc2+s9zEdJ/6S6qRo6btWByCVQp7ioVHeamCguAPcfA9uWAwopMR/M49FAq8gIbjcJBQEeazsvN75ZY+EAc+WGIL6W5kzdHlo0WNFFMx+QHt/XXSrtO73S2Y9roMerxmDBIA4jCfGYGp8Y/g0ro3zbw5gFI3q57bk+6Iec1imBBCcgA3/ao/S8vi0T4SjU9ryeJFE8PieOrpTmnr8pv+VFBUUJ4fQeIasY/iHCufc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(1076003)(2616005)(107886003)(26005)(83380400001)(6506007)(8936002)(41300700001)(2906002)(5660300002)(66946007)(66556008)(66476007)(4326008)(316002)(8676002)(6486002)(6666004)(6512007)(7416002)(7406005)(478600001)(921005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gsy48CeLKVRo99kJ3vV+kYeq24FEkREoUNNrBgqLnDVEcUY/FNn3uxuTofwb?=
 =?us-ascii?Q?l+4Oe0+WfqF3uiN9Oqq0QE9bJfcg5BBoIeYD3t77ozGJJR0Hc/fvuowtUMab?=
 =?us-ascii?Q?lzgrOpakSBdDdzLuJrs/sILCAJeG40huwIsd3tRb+w7QUSdmKnJFj4bIqgKG?=
 =?us-ascii?Q?blp767ljyMfZgU/CDaeS57uk/QjSnpbCweRxGLPPqU40R9qmx2K7SyNaT93+?=
 =?us-ascii?Q?KerjUE1I/REL8dKGf0OugQelq08HbE2E55iCM3d/DZluRwY9wrZh+h8fNsLC?=
 =?us-ascii?Q?0uDYWYKSlLJs5AiCrM5unbuaIVY8lLbJscPxtdCm34vzBGYrb1jy1V2dtvir?=
 =?us-ascii?Q?Dcrxo5BZ7LfatZ73QR4skoe9ZvbV8bDOhH8mKVig4ulfJrrhSVW/4KQ5Wt7u?=
 =?us-ascii?Q?jfAW8v0+3F3ggG/qwNLF58LuL4tv0LP9PjfFzN3QMkFTAZGmV0951vzfcZgg?=
 =?us-ascii?Q?IigNvj8j8xYdcjpgyvNUE9h/nTdRAE0UVknJXz3L2dHiSvA2N/OfK0vLIHCd?=
 =?us-ascii?Q?zl/qhkw3vjykFqH9pl6vi9dxHRYJL6jPmp45pj6M4eFX4xe93OTHM82hfcJY?=
 =?us-ascii?Q?GEB2lvTc/3KUtuuHFAVvN8K6MeXPChd2rHx+0auyrADugbcD2WwP/u7AKkq2?=
 =?us-ascii?Q?M5xOtxfvETTvWB/4lltrajKVzaexRqE/j9raMQuwvmMAUP4AnLaf1PI8CTul?=
 =?us-ascii?Q?tOuJm1ZZXH0Gkx1XmQEe3M6wDS8IfEiY7EM7r6RF2OfpU4mfFylcqrytCPo4?=
 =?us-ascii?Q?fewt5N41IF8dAq9KEnxDv9cbaevQltTNgFy1CUvxM1nFVlOHUPH0W+DxKLyY?=
 =?us-ascii?Q?pEPsCPU1aJ8PTuab5Yjjwa0fFmwYhqpdPIwRLmIOrWoO4YDLKTdMRofkXg97?=
 =?us-ascii?Q?vSVrL44tZ1yHkiMZ5cJaIihEFnx19OQ4PegCkNS8BKR2Ov6thVLbkxcyPLkV?=
 =?us-ascii?Q?QRVWyU6i1f+4Gxrnf2gVJfekUhR4FgG7HjtsR6cQ192P1XebZHUfb3DJcrcz?=
 =?us-ascii?Q?bhg73bV5B7mD5EIMosC7pFwA5OZgtFX3rYz+wr4l41t3dSfYv4h7UtUe8s9r?=
 =?us-ascii?Q?IR7xQoBt6nKddXNb1RYCTrFSBb6Sf6pc4Y2kNRO7+WMOGyEiPVN3Reuy+1Wa?=
 =?us-ascii?Q?zibTQ72ZfNS14byMg483lLGyXL/pjpryuFR9TDIZDv7pD0qGgvNLonqS6pYx?=
 =?us-ascii?Q?8jC+Utn0wnlbmw+jDv6PiIiMpk9SYMGo7MEWHPflBKqRUUjhzXj91X8RMW4X?=
 =?us-ascii?Q?R17RBmVbVaK9xbTUJNZJmjIsHEct62wtiNJN4ql4+9OeZCY0aMglEnLZ7dAj?=
 =?us-ascii?Q?w7kOgbuVPzXyI2/Fex1/eBKnau2XcSnIWHKmVASwSIlOUsb2nMdSzV6wfurP?=
 =?us-ascii?Q?Jx7SJUmzlPAjEgp8/fL7aZvK4cCXjHDifvAgCZBI17ZBpWgq1purV3KcmXks?=
 =?us-ascii?Q?TKW2rRmq5wDg2gF90jwjZ6m79wPGBwsoa0pHWrPsqTO91QERjzH5RAswsSuL?=
 =?us-ascii?Q?ON6s02tGuRmXAqzSAajB4s4pPgF8unr4bbg5zT5Xp7iFjCLCP5jMjUumuzt9?=
 =?us-ascii?Q?+Wit3jyKKt72aNABnlWcADGhJg/ZZVejpNtYWazExSJoLvYJv+jBDby+hdYX?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WHBQnhTImCRxwhU3szNa1OazLLTYGSeBMqTLoxBUD2Fb5aWe2s15RBozTFWD?=
 =?us-ascii?Q?T2UlIL2SP/7sC47h3rYxB5BSFHPGK1Epb/0OUTjZdA+jAHJuGIjL80B+U0ad?=
 =?us-ascii?Q?PUY7aOLrE1EEJ6WfulknBQQphqnYVVpIV5Faj+39ydwLJuPgLcOHb3+cGxBr?=
 =?us-ascii?Q?4MzdIhcMHaz/6HD6OJdqb3BYfbUfJ/2Ix4Ots46ArFfVWwQfQ0q/7VAIJdzB?=
 =?us-ascii?Q?ykJwYJSJZv6IuxHHxegfXxP45afCpS5q9MhunfsDk9XSVLtxuwQg1/ZzRbQm?=
 =?us-ascii?Q?VmYVc+sO3dOZ27QylnBThQyJmcJtW4KamBmuY6Blg0kUWZyqywE5e/B8IUC6?=
 =?us-ascii?Q?2ZnEpw58KqwTr0/gvbV1V64Vac6iKTueSkgD98n+KepKG3i/qbElubohm9rP?=
 =?us-ascii?Q?2OedItFGqUPtdmBCANSyF0HSSI+O8bM1bLObd5hsy/VkyQ9DfrmgZOorJDzN?=
 =?us-ascii?Q?fphBOrz+anLQrDiM6aahqmv7fDobsnCDke8RYEMhbDp6/KIrJgzIFS5TmWcL?=
 =?us-ascii?Q?DzrPnGhJuuN/x5p71+LJp5k9n5Jv9YESF+d0yik54mqdBl0vBEllyrWJGE4U?=
 =?us-ascii?Q?P6ODeGzW175F4wM7YwZ1HwuTrvTxkL92ygWSzJCSs8Zvvcw87oE+N8sWaEgj?=
 =?us-ascii?Q?WVqFsVronh+qtFR6KrizVwS5sNbO9uRZpAqoirnaygILikFzbKxfs2KQ8qBy?=
 =?us-ascii?Q?uLtBX4/5FLKCl8i9ygBTzmPQvfUJH71WLfIC2H+sa8FE2sg1vm/19iqzY1WD?=
 =?us-ascii?Q?Wdzii1l//eTc01bLb7FwQCUWBii5VYpBwMhBPEh6tJrh5YXj+boMrILsRRYo?=
 =?us-ascii?Q?zcI1H4pNCPIliCOlGmwvj/xxAu19CO8Z/UQ+A2N+QcXbV7A/AMKuzmwdPqAP?=
 =?us-ascii?Q?fP2w9CvXXi7A68fflRlnjaHy2X+9paEhhkesrZDU2PFUjdP3Hnyw5I4tghJY?=
 =?us-ascii?Q?dwl8gD2mAIQCa0kv4llY3mnSxZu6DKsqUV78dpaC5uMhHR7hJXoTx/naHh9c?=
 =?us-ascii?Q?9OS/VMDb7MvhW6aiouVrQCYTlG+1ewCmZylzlcUpItjJSbAOrUaxH9gRycn8?=
 =?us-ascii?Q?f3mN32SNZo8lyU3DTay8DA/rX/R1R8KQxsgDB7PNsLWr22Bs/HmY7V6Z66YI?=
 =?us-ascii?Q?OwDnA4o5fRQ5J0g3Wqcj2Vcxsx0kMXEdEV6W83jllwfNeeZHYw+3wv53oqtz?=
 =?us-ascii?Q?6rK2h72g2gAVvGkqvdneFq+81QOQ8xHPOxY35NCcy/PXX1YapwkXV8SFHUuJ?=
 =?us-ascii?Q?6+JuBwn5QBJnbH5EYwLuDnGC86M/uliI8gh7ghkVtZMfSC2v8y1/jYQ5/7Eq?=
 =?us-ascii?Q?PErPx0YKCaFFftKxpuwDGCKx7Lxk8KjgEPhGfSMm/2CabuvGdpnJTvKRniRS?=
 =?us-ascii?Q?I2k5Ceyp8B043hG0xDYenFQqLcsGJa9bK/6TkqwMWzzosESxcbITlyXr/Fj8?=
 =?us-ascii?Q?tGPZtI5ir74=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afe64e1-d745-4c96-9743-08db952e5cb8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:16.1278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAURMkAUq9LFBMSpWkRq3F9Cbc/UPv5LbaPb3UZ8l6I+IBQ7pHvBbNGpBSJebJs3QthiXPtlw3cg35NIDTNgIY2aubCh8VnP2HiTWColyFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-GUID: JG-J_ZHkgySjrc5OI-bV73qV2ZLg3BhE
X-Proofpoint-ORIG-GUID: JG-J_ZHkgySjrc5OI-bV73qV2ZLg3BhE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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

