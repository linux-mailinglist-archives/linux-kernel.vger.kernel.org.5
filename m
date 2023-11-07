Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F637E4B70
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbjKGWEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjKGWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:03:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D252199B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:00:57 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJcBH005442;
        Tue, 7 Nov 2023 21:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=AgHZ1N5EhoaLrXsY9vyuGAOSm3SPTfgdloTSSlmu3F8=;
 b=0L6ZVOAPUA1CGBIZaRIgMxgX6K7W36eeGNpQAdC8VsmwvVuoVk9XzScRg5r6OX7ndRYs
 UKKe0M/SOetznVjvoLkqWDnk3+LbKTM4dSkbvtqtc25hrqcVfagWETRNK2QbUFybe+ma
 +EaUtaGYTkRc1j20cnUWowfhGDwLVstCmfXYJroXt3FUOk30hPhJ1SVPPdKE6sHH/Tf4
 JuViJdm/MFf67TS8i8zkNvoXal/s4camLXBlve+VVklgwCkfsFJdAN/sgQ2j3WcFCemh
 XAxkOjQKDENg48gdS1r5SsVD8HDyTLoF7hvH0XMv7AMlZhm+EbQMKFJZaW33xqKKW2bF 2w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIhoV011115;
        Tue, 7 Nov 2023 21:59:50 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1tsjqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:59:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPMtOzEH9FlKHAvYi2sYd9jmnVEwIySaMAhiUhoNPqSn7FYDkPWjHzj0hHvdn/iSVoPwWdW2EfVBwxiEtJEsCSQhlv2ZY6aDcBwt7RM3z23nLspk8pbGWvf7hvMcCsT6BMO/EIBoPl+e4nN3O5r2tnItSOzTpT7ziRO0cXt1fgnF6u8KMXE9oo9ip1SNF0cibVjllmqaMG2RgTY2p+MmKy+ENxgN5CCjSi7aDy78PzU+SEXH6Y1/GECb8+v+5zS8zj6nKSQS2MBopogui+myO51LxKsRhCyNmms5aqF7lhSbCFxoYwGPYV9GkUAYM9L7uYRPcwoNGFsTUi4lmGtw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgHZ1N5EhoaLrXsY9vyuGAOSm3SPTfgdloTSSlmu3F8=;
 b=Jz1ajQzbnqj0QN1XSpZSUpAOUWc67RXdxLZsrEFOuhDpaHORrPqlr3L4QuLi45MkUxTw0hfN6z6xou5EQ2XYN1mGZjkUMOkLfCMpKsZa6kUWA+xyishOQtCxdS6g6w99s0IXQcUZfVs3eVx0PQu0y+YhdIO1caeHZqkTEEymhE281WBn5K9ppSzQvVxT3/DmbNBjjzP26iG5fL8Mh21ZF0V06npH1ShC0cMXOmsWAJXX4QWnQJmrKmSrKHic1Z+gLhtuytvZtX/mNTYcqZ9YzHNm1oSxQXjw8fvKDLvU1uwd5NO66CpSxOwk6y3o7oGNkkq2lwGp3X9FaKrvePjkYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgHZ1N5EhoaLrXsY9vyuGAOSm3SPTfgdloTSSlmu3F8=;
 b=pDoPnA3ahKme8JyxjMLRIWJ1UHPhEU/SCZ4heli+SmRgjgR3GhDoOpP97ceO3JpdN4pnDSycPXlq8mMnFCEiGXdDWzun/+PWz4/MJ5IOdLUExNeADHIhKfTOV6eS452GY5p2UsETPfahX+CseySN4BYuWzBOaz/g8zLVGbBQEdU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6275.namprd10.prod.outlook.com (2603:10b6:510:211::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 21:59:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:59:45 +0000
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
Subject: [RFC PATCH 40/86] context_tracking: add ct_state_cpu()
Date:   Tue,  7 Nov 2023 13:57:26 -0800
Message-Id: <20231107215742.363031-41-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:302:1::42) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: fab9a692-4dc4-4d1e-a9b3-08dbdfdcda42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9A2Lt71wnSewrbONGEzXnrH9IBszBCDkaIP+/jDZvqDNXk7Bd6RDt8U3J+ZR0Qcmj0iIDMxMOWFvWVcMiaSvJoPZBwXSrIrqSYyFEQprv3Jwn+KAzFz3ouX69hs7poyQVPlfzSW9HHw8jTB/t0UTx+Y+tgHRb3q+Qtrvy29f03498UuqkaPjtR3FLilcc3mlcX04Nywqg/GE3l2H9P7q3/hwPcpAgbft+i9Rmo+v+6tVswL0wsm0VYUfQY7B4o5e/tmK5P1Y21Il5jlLZ8cLNwyxo3T5zT7gtljCbrMVLHBqojy7QlPunx8n9itALomxNKxM7kbKa21Q/qZP74TQR4OS0Xgw9nY9uOYHJYTrzlyZbVV8Ma993PSYkTkD3ZBfjppKM6iDOQTk1bUrvLVd9adr7XE+ZK7KKzIitePQCiQshWF7kGX9z26TJjfjQcerk17qekzjYI/SV4DYFcptV2d9LSLJiwQv16wSFJyVrf4i8w/tbkpNvyQ/kfDb+RZnAQeVIwnVwEJkegz4Z2lNeZqDYcXFQqQTCN41hrKtr5YmnWjtJ0WOrVaveIvL2ZNh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(6666004)(38100700002)(6916009)(6506007)(316002)(66556008)(36756003)(5660300002)(7416002)(7406005)(41300700001)(66946007)(6512007)(103116003)(1076003)(8936002)(8676002)(4326008)(26005)(6486002)(107886003)(2616005)(2906002)(83380400001)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8QYL0eyIYiJCl3uryXvFYLVnQgnDz5nre3gMZjm4U2nHzQa6oj7lq72cbQ9O?=
 =?us-ascii?Q?cvScIpvXOwZSIIcsqATVSqKPcyhJPnJFRIepQdL7l0DEmY0+/l6p42Pg5bBJ?=
 =?us-ascii?Q?ozGd11xd6sKwUJn5lr+WFQrO0kNv8xFOSyRWE/mwCGC7B9qVaacMqP37uMDM?=
 =?us-ascii?Q?1BYDaFjl0MwrOqZiG7E0JIHbqrXnZurXmhHFkqTeTaZgOEgF726SYRdaxEOg?=
 =?us-ascii?Q?ZKvvKLLWFdAWpc2W/IIxO+92lKLicFw1o/xwv8xNit49MojDV2N7Obf01hYb?=
 =?us-ascii?Q?RWf9voA08MpaWboZtTRI55hp9pgBRFHVxYjNmGQbm+kFIwpfw/gBH8UWz0Oc?=
 =?us-ascii?Q?5P43TZHwMpV/bXkeDZq1y2okAGo+ZqwGRioxE+PwNmlewKRVRfjhR6zKlhLe?=
 =?us-ascii?Q?LKynFxb3kMRT04PN5+FqAMlygLVBXnxQD7uiiYgThzmw6qavHvdl6FV52hs7?=
 =?us-ascii?Q?2EFbdGKyGBpgIu3gcuLC9+u/amN5SbCwGlrNS3YnWiBPy2ONMGeOOBlVcpNg?=
 =?us-ascii?Q?LeGZLJdyLaKuzXiThsowVQHCYfa9Yl4VbC2iFfeshWNwohakeJ7jLBQaZQ9f?=
 =?us-ascii?Q?W7j0CO6W6YkRs5OoN9I0Ofsp94rL7M90P72h09ZC6cvQw/dMHnEEcp5JInI7?=
 =?us-ascii?Q?tsU7ABCou7GsfYy4kYmHWXP6qrrU8kuJk+Voor2sD9/xJtC/Rmjwo9LIuEaS?=
 =?us-ascii?Q?L0ZpTgk7uCx7WAKPap8mDZou0uxPeKom0NB+ue9j372vSdseshe9sLw0bR5R?=
 =?us-ascii?Q?P71/ulN0XHHYxFw1t3Qrqoi8vmoRU3CHLfLGQC4KQwXFPORIiO+aEIrjxb8D?=
 =?us-ascii?Q?DiowDyPjXwrX0n1dYahJrnWDkkDjbLTSmW4VbkqJ4DTMcyEFu2vAiJHwfhIF?=
 =?us-ascii?Q?WhEsOym2WWLvka08/XYPu0dgzck7+ApSMsx8atszh1pRaOKHd6EU0m4kYdtH?=
 =?us-ascii?Q?ynnvic4RWXZ4YYqzK9k/jwxpjCmOFRywskI5aIbGyyPmUBbDFV6jzVZe2wP/?=
 =?us-ascii?Q?qR6KsTe+bRmAQhUjyCNiv6GNetk+vsyWCnOdtuSmvkSPmvDGVKcEA6Tu//1k?=
 =?us-ascii?Q?AM+/BokxcwHrOTRRNcVVQIGXQFyExZxaSNmO/qAdvmqFXUrYWzmp/onHrpep?=
 =?us-ascii?Q?uOW27yZvoLyY3Z+Es1ttlNHhJw/c8ZEqAfglWB8cnSjtd9xWFxcHblUlZpYL?=
 =?us-ascii?Q?4ZVV5X8NfQLB6dg+f6bSWn9pq51RyL7fTGu83Y6KFwPMyO/qc9Kz9kTy8n6K?=
 =?us-ascii?Q?XB6cHROrRsD/pFfZ0Dl8pm9AYISSyr/sehzhKKHe2r33v1qlnu8no+6KzlTh?=
 =?us-ascii?Q?mEgbXmu5YbPv86Vsx4Z6krdxUvGrBM4rTYPJPVYYDvUuI+53Eor7sVSRTffY?=
 =?us-ascii?Q?rjkSP0RYPViy2BgzKhVmyvnhF4dIGd7VOw8GR6M/pXHQIR6zKyr8CA0krUw4?=
 =?us-ascii?Q?VUko3TDx/AEMN2a+U5Z1Y0Jspe3PFLL9P4zm8d1jeDws9r2ZzeG5AOZGaphk?=
 =?us-ascii?Q?z/n9ybmgBgkkgU09WehGK4YFb8n4/LbwBypH8NLkPf4kNt6Py5vIBx394MMm?=
 =?us-ascii?Q?9rv5atrpCuQpZE+jPlScMJndikoy0jcojHyHAEKhqCU8m/rHupH4MeRt3zvs?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WFFxFnHp6Hpw9hBlTmTpaIY7utAxrH0Nx9NiMFcGjweyLL96x0MMdEFVh1VM?=
 =?us-ascii?Q?PZKTbFkQUcgGlvGtxn+1/+cwPNvRhxukWO5ifFLOTNetEx4zArYYUyCk3ISW?=
 =?us-ascii?Q?/Us8NpKYhwYRLjYaEAY/VrKufEgjRje4pS0uuVtQ1y6PrZEB3WiPLnKdO7tF?=
 =?us-ascii?Q?kAJWczB5/Z1n5dw8BbsPydRcHM8siAdjXIxnLSXM+bCw9KHR/v3wRpX3CvVj?=
 =?us-ascii?Q?DkaBlH3oovo/2s0Dmw1J8kFh/bUUI8oQrtZwyYHJFGWOk2/X5VQL6MJsnZnY?=
 =?us-ascii?Q?HRgO/hviOqsGIDHWJ8tKI9emmUhBbsWBh6RGj2DaUnwt93cAkLVbhylXPLqy?=
 =?us-ascii?Q?tHt4L67P3ypmzf8a8KW3LcfHA8WUgmRtwcrDi+WVoMOn68aS+S6RM4qkkxaq?=
 =?us-ascii?Q?XwPC8WWOgjqcQe1kH8s/oQXRXvZvdCvY9ovea3avXhsJueBlWdnej+d7bgRF?=
 =?us-ascii?Q?7tdR6d99aMAfgiEYTzmHEVDwJHiGZMj0slFCVTmEXdvVS66AR3as/KDFAMSS?=
 =?us-ascii?Q?Y7QVZL/o6k2u2TQFnN7jYbQh5msVicYJ/Iaazb7g0lMA6SEgHiToNZd/wzmn?=
 =?us-ascii?Q?VC9/pYMZp8Hk4X2937TB3RxzTUPlR7lET5RkXLElk5/CjTzCebpfFwAxUnkF?=
 =?us-ascii?Q?lytTAHZU9S0G3mFTFKX5Km/kZD+pMg7cRWd4lLlRn+FWW9XA/LJ1YSwVEW7W?=
 =?us-ascii?Q?zGj5oeeuY5a+TYBKhi1x/zTLfMBoZtqlPqIeJO7XysAUAcuvs8YEte028iDW?=
 =?us-ascii?Q?mk5ftY4JZsj3Iq07Yc2ljbI93poqKFb+D6mV7LILzJiSW+0rI8oqFdvdZPB/?=
 =?us-ascii?Q?SJKoDiCtHYrUvw3b1Uze8YiI4vaFQ8P9dGgVPUl5Wl5/I/47KQ412BwFFPy7?=
 =?us-ascii?Q?Rb+V3zdBzwUHFNFnH0LpURFHmyw12WSZVA8X2pYxAXaMDRqWSi5fCmt/zrAJ?=
 =?us-ascii?Q?So1vCjuL3/nOF2KgoYLSQip8Sg7WD5gNKl8uvW0cGG2CKxf/vMxcWPEl9+Z4?=
 =?us-ascii?Q?mY7IxFqjgS+8ZUn9j4C+dS3h4jyme4PCtZa4AcOjgt31zQRfJsrKW/JWuMRt?=
 =?us-ascii?Q?SN0mRE0XrE1xO/q2ys7g1Zu6YxA3nOSUDme7jJGpS6qpDNC/7JETOVqrNLJc?=
 =?us-ascii?Q?jXXvAvQTGxV/3sCn8eRQt3ZgYkOPpny6T+fhjmbAtTr1klG1JghIKT66uDv7?=
 =?us-ascii?Q?D0GPXozz5CZvz/j+hAhlhnmpUk9Zep2PUBM9H12MTrw8/zxR1epl2Rsw14Y+?=
 =?us-ascii?Q?d9h1cUXddSIJqDHJ+jhfO9+THmGE8jLkNKTwrd1f3IwR7ySPc4wALcNB1Cb9?=
 =?us-ascii?Q?x9TUoSOBFremjTteqzn+laC9UcOn7wwpv+NmdEbCCmmkZr2TIvPCxWaDiwyH?=
 =?us-ascii?Q?igPL/NqhGpny684eqW0JpFofS++u5QN8og0NctiJeaK4851M6z3CNZesVCaP?=
 =?us-ascii?Q?kcNL5xmrXZzqJlaEhK8fgs9UU6Oko863HETlT6IJX1FTD1BPi0vAJsMqSH/a?=
 =?us-ascii?Q?CNQSMzNj5w0u1q4dJowzEl5TbMB4mjPd4lYwl5Q8rJlhuB3Fx608aOCOzw?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fab9a692-4dc4-4d1e-a9b3-08dbdfdcda42
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:59:45.2262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRlvqYNHhxZZhopXRsBAK7q1WhyBNhX2/9bQAL8Sf0N2Rs7ettAdm8eDriu5dQaj2yez0YgvnFa6iXfi604XDM6iZnKoAzUErINtiCT5CA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: skFKXPrKzw3I8UaaOrnk6NVYwCSuronb
X-Proofpoint-ORIG-GUID: skFKXPrKzw3I8UaaOrnk6NVYwCSuronb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While making up its mind about whether to reschedule a target
runqueue eagerly or lazily, resched_curr() needs to know if the
target is executing in the kernel or in userspace.

Add ct_state_cpu().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

---
Using context-tracking for this seems like overkill. Is there a better
way to achieve this? One problem with depending on user_enter() is that
it happens much too late for our purposes. From the scheduler's
point-of-view the exit state has effectively transitioned once the
task exits the exit_to_user_loop() so we will see stale state
while the task is done with exit_to_user_loop() but has not yet
executed user_enter().

---
 include/linux/context_tracking_state.h | 21 +++++++++++++++++++++
 kernel/Kconfig.preempt                 |  1 +
 2 files changed, 22 insertions(+)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index bbff5f7f8803..6a8f1c7ba105 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -53,6 +53,13 @@ static __always_inline int __ct_state(void)
 {
 	return raw_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
 }
+
+static __always_inline int __ct_state_cpu(int cpu)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+
+	return atomic_read(&ct->state) & CT_STATE_MASK;
+}
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_IDLE
@@ -139,6 +146,20 @@ static __always_inline int ct_state(void)
 	return ret;
 }
 
+static __always_inline int ct_state_cpu(int cpu)
+{
+	int ret;
+
+	if (!context_tracking_enabled_cpu(cpu))
+		return CONTEXT_DISABLED;
+
+	preempt_disable();
+	ret = __ct_state_cpu(cpu);
+	preempt_enable();
+
+	return ret;
+}
+
 #else
 static __always_inline bool context_tracking_enabled(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 715e7aebb9d8..aa87b5cd3ecc 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -80,6 +80,7 @@ config PREEMPT_COUNT
 config PREEMPTION
        bool
        select PREEMPT_COUNT
+       select CONTEXT_TRACKING_USER
 
 config SCHED_CORE
 	bool "Core Scheduling for SMT"
-- 
2.31.1

