Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FEC7E4B9D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjKGWVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjKGWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:21:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979223ABA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:01:30 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJVlY000503;
        Tue, 7 Nov 2023 22:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=NbIG2FDSqQQltjMT80C3mAvHEiZLiM5q+kfnA5OMsx8=;
 b=ois6llJH2raTDmSBZ+CXcWgGeVmWk44EUp3VYxxxAG/W5zUQ8aNccWOwlmb9LcxOky84
 uIxA7MdbqDuBlIV8mDnKYhbGrYlGpcJq368g8Qq05q2kLk8r5lXluXzZ50+8FTlF7ZgE
 WgkDZ1eN/bgekCNp3AyGFLnRJlGLuE05AbjAz/3BJV0sNnEtpYHjFSgxOgMEfSCFGCl8
 b1rR1/3t67C8osHfQeCFhieBAch616DXZx3MTnjIhVYtbLxKu1krwrG35pJww604vMTJ
 zFYCx+7uuukGft+Z5jxX3iP1omFP9etMoZdZGp//oIUifoUughdak1aex3wh9pjLbWCv JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIhBF011123;
        Tue, 7 Nov 2023 22:00:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsm6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 22:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWGC6s7S3AY8ml3RAjoQFRBhFRm2UDsrMFdFg2Fc/jnjwiy6WNE1Lwt3jBKCiA8qCpHt6yxkrVb/oETjRh9xFVw+Y+PVoCwOHymlXXy1H1+oXzyq7KZS2SGHlUefexCOf2g3RM92ozLmubmTGqpllzw0GOf51VDls2ra312/poJEnP32kaotrTmoNxDsTrF6LvFmUI0jB0c7f3HBxB/ivvun21IWpYmZzbr5xiBak4DKqmAifJ+M/SeTEkInHIuZHPcX/6nR7/9ZGkBoAX2Zb3PdcM2yD+S/t60n3kpCqIgffARCO7ieRMvlwQ9OUb1EtC6EQGXjiEwlLq9DSAhQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbIG2FDSqQQltjMT80C3mAvHEiZLiM5q+kfnA5OMsx8=;
 b=ICcbzu8N+H8AWr0daTK/uAl3vRwiMdxAqyGwJwhV3Wf+r4mmY0XH5iqQtvPrQWEhxu+dr/1xulS9YaK8a0wIGWDNmEeAoTDo4cy7KEgXE38AuC0Ae9s3UpNnewCvvEFpAbOkDU09dJ//cLgdf3+FDdSLNbDuplttfm6n40/CRoO2uucgIgPm39fHLaNXrGh8lRRJlQUIXuBIFio3WH+VKN9lVXi+vk8byfhCd2cpy0QGMFGBrRvrJRw9SQ5MXNtifQDxxBTkYQeFlco7UCAk9gITkHYLLJDjJqkEnofs7VFZvpPbIULOXGbx22CIVEaa8QxSul4M+JYvrrxjnh2pLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbIG2FDSqQQltjMT80C3mAvHEiZLiM5q+kfnA5OMsx8=;
 b=S9psN0J2esji4FTbxR20sX3/LmQwI7ZacrH9sfvL7g9SsI8vd3tIq6BWufQ0PNsOMTJfvi/F67+zyl7kjReQ0o13BbrKW2uRcG0newxmA+nj4hjYeBAHlfc5uQNN1r4rTBBa1HpeuKzD1jutBfzcTZknSTybh0KtiHQuZXRNK4Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5318.namprd10.prod.outlook.com (2603:10b6:408:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 22:00:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:00:22 +0000
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
Subject: [RFC PATCH 52/86] sched: remove CONFIG_PREEMPTION from *_needbreak()
Date:   Tue,  7 Nov 2023 13:57:38 -0800
Message-Id: <20231107215742.363031-53-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0240.namprd04.prod.outlook.com
 (2603:10b6:303:87::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: 4974a968-bfbd-49a4-968c-08dbdfdcf055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzgB4nH0iWb1s6QN47JLynQ7vleQBxDwGKRE7IeJNBppH+UJbaih1nOMnYTETkasv+CUOw69383QD7MqD9iIS5FFcWgWn0gcoataeOwL3F8uif/6nVngC2FNu5zPkIh3p0+b3irhItUmRWsM3AbydHHjCXdkqB2unUQWlEsu/U8drPbhZRHgPIlKePOluSVJVPw5t4q02lBBK6WrgXXNOf5mabBXMJjcMrT7Gq6KCTOsQ/fe8bhE7ggdqLdENw07X4KTwjCunjBoFOCbQGLMOe1WjeoCxypagUey0k/qJEbRpKQDzxLzGadyFdXADS/AyC/r9ys8tJJnJKabra6zo7nj2/cx0BLpMHp1RoRMUoyuxtazjrE9iryRW6FlPy9tnUy3JBO+7x2pkE93IJpiFwXk8HAmWJ9pop2c/NRo9SeGMH7y7t8VDfzm6DA8iAcNdQmTvrYFMN38chxP3gvxDoqNUpePmZ1baS74zqXbuPvHQRXV/VRsT9/tdhHj19viuGG6cPMVTmE3lVlUm7kik0CKxAXELbAZTtzWxYUaf8oU8SjtldP/p3mdvLs95Ko3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(26005)(38100700002)(83380400001)(5660300002)(107886003)(2616005)(6486002)(6506007)(478600001)(6666004)(6512007)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(7416002)(86362001)(7406005)(2906002)(103116003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RFycjcMrMVMxyHwej6DT6at8GK4O3tZAGDUd8Ug2IfYM04iXC/FS9krK8Tsz?=
 =?us-ascii?Q?71bF1cnIVNc2fInSL0CaXwxDZ5zMwKJCGZbZXe+IuAB3PxINdmyMH4Gx89T/?=
 =?us-ascii?Q?cur5FG9KqqYoa/Cs3D5i14BQIVUICzc9M/dLBfyq/LfA7iJt0obOU+i6qaou?=
 =?us-ascii?Q?aBb7qkgmsrXe9PuFhQHRVKWLuprgdl6hywF5nG1Rgjl3syTORIT/4MD8Y+H4?=
 =?us-ascii?Q?+ocV6NAsaHAav8DyTrdl/HOktTHwxF2+Pcm4eGikOe2k9rpfoFd8g41RK+A/?=
 =?us-ascii?Q?EaQtWJH9MadGb2rweLgqu9ffjOTIjydkBfw0TsvTY14gdYRyqp8QTiX/3QXb?=
 =?us-ascii?Q?eHPI5yyvp/Gspj5z9vxo89lGNQOHusWb330uwRp4m50tHyNWm1JNFZJcu/aG?=
 =?us-ascii?Q?SaT24Fu+Uf7mHzzguiuI/ynlUca5prIu3olYNSqXyJz2f+R91Qw+m2j+BeFp?=
 =?us-ascii?Q?Wro/4dA6yE9xRp2XmuVxcE6Q1hUpuX/73Bihjj0nWrq5Y9deQAnkIqk5sbDJ?=
 =?us-ascii?Q?OM0UtUdv/CxE47iZIlxsz3oWvCmuInMEoDo4vNBruWK1Zya8Klm0iG38ixVq?=
 =?us-ascii?Q?ycWWSogIWnIm7QIiDNb0VVhrgNxzLMPRUAm1+/SpnuIuC2mnrs4bagGHS2Jy?=
 =?us-ascii?Q?VnrIwQ/U6G9UxXQdzKG4Vb1KgAM9IaVQwfSANXQaYlMVbV5aIFFQzC+LuzhP?=
 =?us-ascii?Q?MgU34kywpRIXRe0AVDfKRRf1r5KEsEUNmIECs/qUq1cMV2ndJIPPCQTZruZy?=
 =?us-ascii?Q?E1touhGaOB6/Y/qJpRr8vLuHD1kNsmGQ0xrtHhB5SgoBI/nIIyEeOfVFcLjg?=
 =?us-ascii?Q?OFU61E7EnD3b3gsiSnLZWT+Y9XEi65WY8770TjdPtqdMMDcC7AuS+XtAmide?=
 =?us-ascii?Q?ngM5EyBl8zC9GjxnsodxyBSaTLH6QLZyqXiukJY7J7s09kBjs4h1GuHMMsBK?=
 =?us-ascii?Q?3YQzMt1veYwwlmlLfomUCswI1Qd8RCw0e2mJv3FuVGtL0BMSXPHy78jM1rDd?=
 =?us-ascii?Q?fzarjOpadL3cMVP5QJd0kyXoLG3eTudx7xmG+RlKyUFwtgYbUFx0hND9k9XI?=
 =?us-ascii?Q?3G/EXPuICKmeP7RUHVPftJYM7SMUWWlisBslX3j7686R9YJLJ9NR30u6ZJEB?=
 =?us-ascii?Q?V53FyQoEEWrbj90znEI0x2yzlDj/JuxMZ02mPtGOrCSoOKSzA/+UNDGw7xkk?=
 =?us-ascii?Q?cFFfoyDs5rUs4u1l/S93e4r9Bqzvyff3wY21kTfgb9cOVFvzOJZm1b+pKgWh?=
 =?us-ascii?Q?xSkxE2Cr24PbkD4vgJ0qALzDH+hz8eYj8ICLVaRqtGt8+GDeuc42vKOaE2np?=
 =?us-ascii?Q?YLG8qITQsjasXd9PuUKnXb1vC3xP0ek/opFOfjgeQIY1O+zha+b7CXUp7l5f?=
 =?us-ascii?Q?Ymu8zhNoAQqOwHYvKq6BE0Elb4TSxFw3QkK5JXeajy2yixM8/bJnhp1n//ai?=
 =?us-ascii?Q?9/e0OLprndvdjuy+Xy0ttpig2tT7znR1ELJNzW+Crk5x3w8ihIlsFqhaoDeP?=
 =?us-ascii?Q?vsNhBD/MdLRZ0fI7rQIrI26bsJTXudaqmpOERTNaZwwY4oNll/POtT8l5Xqi?=
 =?us-ascii?Q?8p5pUBC7o78UXQIMduEaaaBrZga+ogYf1kr6839jNDlPqtE3CS2VtUPcqduW?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?bVju3AXdagyLbdtFsKdQs0D7yTD52Y9F8UprWw48cqgwwQXVpwiJB0Do6WNE?=
 =?us-ascii?Q?kb1Wb5pg4UFQRExav708E0YLOGb8gP2u989ZcwOEGiZDwrczgFNRCPk8lTED?=
 =?us-ascii?Q?EJFQ1GPwjkPSKr87wEmzu61wmknTfKCCSLadZ5O8QkWtA6GqmZLJX8jJxFgK?=
 =?us-ascii?Q?KnzsBmHJQtQNQdeiPaRLjP66yzm0CLajLw9sWEeYls5N5fHBhz1tRLhuYIUn?=
 =?us-ascii?Q?l3YM+ZiqnCIykDgPSNJmIaK1YtVRB+tflX0Pl7BvgHvwzF/o73w8z74xbFD0?=
 =?us-ascii?Q?o3KQDrFsgSgEDMFLFSL8T9+WQLat4BcVTQtwDPGEanZDFZCXtsf7W/+C0XBs?=
 =?us-ascii?Q?TD4Thri1AR9Ow5HKhWdYpm6LKhlA4vcgU8D15MO5F9/smVlVcV5lFbSgRnXr?=
 =?us-ascii?Q?RehaMMEbEo5E1MPwWBYiDz+y02R1Czmmydz4/Y3ARCWS1VtXwax6bykrIjLe?=
 =?us-ascii?Q?0q+Oj2YebVaDT+9ys0j7yjvO+LdBE8GcT4ofk3YDZl0FpjD6aQ5K/ZLCoQ3L?=
 =?us-ascii?Q?/p1FjdNX7d5YsODi3bqXPK/gb0VypqzCKHtWJqJTqUjSLPMdrF0YcgUgYSw1?=
 =?us-ascii?Q?KStfCwyD6GIlgLbnW8qyM8P3f4Rf0sDvVSJ6AdmaKy5FjV0d4QmKT6mL+v58?=
 =?us-ascii?Q?/re6kGU1kLKYvV4SrxLzJ2PLWet38lPkEELoePD1sGi2z+xWR+vfytPBtAqB?=
 =?us-ascii?Q?SqeH9d/wLakzL0Qc3Rsw2Gwt9R7baTZVSR6ZWiLgaXyUKg7vRRS/8uiXDmwT?=
 =?us-ascii?Q?KquhqPgI1vY6erAIRkW+oEAPZeDw/qoy5PZ3qJBnEMNWtLA90Zalsl0fXwDF?=
 =?us-ascii?Q?tXkaBKbOaqNKkaNABvk3dUo7yHynqzjAf83vpnfzeJ4r3tedac6wWBZSvItC?=
 =?us-ascii?Q?FxU1PApkUvbb6lm8TugNRM6B4Dl5daQ2vD3mi0foLmVg6qRTTYvR8gALwRvN?=
 =?us-ascii?Q?1hZY9j3DPVq7OaO4TnR89G7ju/I5XqYSefkkPrj1hfrDwYX7IAMB830WehX3?=
 =?us-ascii?Q?BLS4GbLE07JhaK/pmYNtsexaRd4DQloMR4zNimUsE79hXtUdVIt0JwHNcZI+?=
 =?us-ascii?Q?3C9j8sbBTHQ2c5dgHlFFUAeX93FbixIHLEs4iG/6GuiYb2B/ohxwuV83sJnF?=
 =?us-ascii?Q?ivD+Lf66ymbXwzLJgbwmGwe84wp3i1dNNeVKeKH1GhHnAKPkfUHExc/FxTZ4?=
 =?us-ascii?Q?79+77gSIIo4ZBjxIM3Z5elPe5zeMwPiOScif6xbTYC9lW+XHxAaM5D0PJqpt?=
 =?us-ascii?Q?a/UCfKy27ga9FOGgZGN8X0sTLwbkKsa/x7UDoy3W82qV9+qIWELd8m0rEgCH?=
 =?us-ascii?Q?nBo0MAeBfZCjeVJPAa7oZ69F0tGXy6MINujihW7t/tNiHtfE7UwAV0tawjLW?=
 =?us-ascii?Q?Y3wKLQRVj5MC7n07E5BTqRWgEC+VLDiSv/eiupA8NaiJKQoz2OFsQ/AJmfdb?=
 =?us-ascii?Q?qgpOmZ4NThXsnRE0cvOBnaDVkGnUWHwlVr7e71epI7secjCyXuWGGrZbHCWF?=
 =?us-ascii?Q?tK46VSxQg9qnB8RV1TSAEQ2AOlC7eA2CiQ5IWopyj+OFbgPc5tTnxYtqeA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4974a968-bfbd-49a4-968c-08dbdfdcf055
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:00:22.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qBAAwMYT1BORwdD6D7sjQwS6eSvr25TGAhMD+YBfoSSuyXptVwfnxZuOEXE2vLQmgRqNtQu9OV+tpgdMz2bObt6q9a04MITevUWGPVGXP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: ds60vZVvfcv1MgKZCwKyfE2fnKfnZbJ-
X-Proofpoint-GUID: ds60vZVvfcv1MgKZCwKyfE2fnKfnZbJ-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since CONFIG_PREEMPTION is always enabled we can remove the clutter.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4dabd9530f98..6ba4371761c4 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2146,16 +2146,13 @@ static inline void cond_resched_rcu(void)
 
 /*
  * Does a critical section need to be broken due to another
- * task waiting?: (technically does not depend on CONFIG_PREEMPTION,
- * but a general need for low latency)
+ * task waiting?: this should really depend on whether we have
+ * sched_feat(FORCE_PREEMPT) or not but that is not visible
+ * outside the scheduler.
  */
 static inline int spin_needbreak(spinlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
 	return spin_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 /*
@@ -2163,16 +2160,10 @@ static inline int spin_needbreak(spinlock_t *lock)
  * Returns non-zero if there is another task waiting on the rwlock.
  * Returns zero if the lock is not contended or the system / underlying
  * rwlock implementation does not support contention detection.
- * Technically does not depend on CONFIG_PREEMPTION, but a general need
- * for low latency.
  */
 static inline int rwlock_needbreak(rwlock_t *lock)
 {
-#ifdef CONFIG_PREEMPTION
 	return rwlock_is_contended(lock);
-#else
-	return 0;
-#endif
 }
 
 static __always_inline bool need_resched(void)
-- 
2.31.1

