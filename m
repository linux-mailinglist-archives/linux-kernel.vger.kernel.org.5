Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AC778E164
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241234AbjH3V2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241213AbjH3V2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:28:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9695712F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:27:36 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UInqUt018036;
        Wed, 30 Aug 2023 18:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZQUSDAXAq2hTKgg73tSO5DT1RApTyE+5aqfIw3lJuGs=;
 b=0INu6VVv0GEMTTAIEQmj3IRUbaAkWGlnNLkcMfKUsq+nqi0t28qnnoXevRoJJxEtuSyx
 VB2XmzK/k5I0OCTCnA3Me57Cka7WdAJGRutZJnwW/WiR8ep/mJva6fh7AmhPWxxnDeqf
 4R3sdHOYUOmQfS2fiOSmp3gdkO5wi1q231JzTqome0Sa8+Um27rFZS6J3XKjM4TkhAPQ
 ODR/HBUeCS96Px2WcW6kD49BkGHGEaG2IqX2TVjwC/VWWtPW/pFjFO6rDOAZAR3x1EyI
 IM9Mhc5QM9K+c8ptIjOAzUTpIJePzO4Xrko4OPfHPltWvxN7zyvo/SN0t3DAFcm9gLN0 TA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4g76d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UIVmJV002385;
        Wed, 30 Aug 2023 18:50:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ssyw43vmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 18:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeBUntXapP+PwJX3vGI8EfwjVIpabiZp/+hTtWwjj6YvhqCeIOKH9+EDdOFKNPZhvvhPyhLlqX/83URG+rNLJ6pPH5vwpzqmjKBxhNjZOJ9jR5oFDTNNiQqs8du2ar1ir1VXXCWVh/BEdTVTuQzY0wHTuGjDDsSaJS19+m4YtVdtbz4qxs3qhfIIvOnipjvGOncvOA05FP8MVVw6W3pF+wjzlRR/xQIVyWlQrmuePQE7TEWdWCiUHtTeKD3Vv883euo55SAqAcn90+rv6c7idsAr+Zq4Vv/27TxYTfcYJvdcSUBcErBjRg8/xpTkC4v9e3j/JIwVGKbiqvQz+TR40Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQUSDAXAq2hTKgg73tSO5DT1RApTyE+5aqfIw3lJuGs=;
 b=cRU1wsqZKWUw89kkygDeCjAGloekB2TNxhYLexHSZ6+pReZGESmYXg8ZWZjAHsO2ne13cwWou3m72JKs/lgANEgemT5FtdbasxS6PGIbUO/XPQIppBfMKv/Kr6U8EItri41/ITJnUBVjJcI2Do/EnWen3OWIru/ErE18F2RYWF5EAaw67afC1OVOr+SmIFATYVcv3INTEDY78T8RDPCP77BG8cUNy9+VZRnVuB8OHSo0SgubPRMNl5crYJg6LqGMC2G7pPPVlLthDR0oxIeV2xP8f0uTHowt8CqTq2nfPMpvmPMjcEZ73WfA2f8z4rdGYDsBVcg7BLxqpcN+dAEy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQUSDAXAq2hTKgg73tSO5DT1RApTyE+5aqfIw3lJuGs=;
 b=pxcH0wXleHNC7zGYlqE6t5mRFwY6E+knl73bCte126V/QJptfWaico93rZR+/RNQy46X9ATAqCTvFFDRWFxxzydA3I7amqfiJRu7JIJ1lck9V+TO3wPD7ySx2F9blSsuCJzFZSRCMouLGRLVrWyhB2nCh24AvAfBULeThhkHs14=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYXPR10MB7897.namprd10.prod.outlook.com (2603:10b6:930:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 18:50:26 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::238e:5e86:cbd0:7415%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 18:50:26 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 8/9] irqentry: define irqentry_exit_allow_resched()
Date:   Wed, 30 Aug 2023 11:49:57 -0700
Message-Id: <20230830184958.2333078-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:303:b9::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYXPR10MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 859026f9-65e8-452f-5177-08dba989f916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9vhy3ZQGGhzt8VqtEpcbh/jak9MnZ6SaC9nzjmiZ8LO4Y/bzDt4Uq1mdXYePczh4yeAEQbE6MvOVSo7R2vVvOF/yqtkjp2hsM1dD94+KiDZoKQKmUDlfvcI2jDjBUdFobZ+V8ekRcCbLArx7D6R74j/YhkDHzfOKg1gUZheiQ4j65IFTceCsxvJ00JppKo5S6IkYEMARGBLYLcE4mLSJnYcRlW2/w7Cfh8oHmt3LCyoC9JBfogXSc2d/klZ9b7Xh/LanPXTw16wtt7brYpgT0nG2Pqu+aKMpqeUVeF3fZFCG9SCB9RLnmi6B1Zbj21jB6j+1hXatG7zV+4ETst9NDSN+oNmE3LpihSsKvyUKdaB5a4WiSJobxHiqC9y6HA5t8SGsvfQ6Mb+5mlrhD9uBJfyvwyIOcENh59AFdYSU/vx/YHwVpnEgYxxLOrXdyq+HfJaD24ecM6ya88oAFFxZkhtOKY4RruQZky4UQHwR0KM+Ny21yizEe8pK2yCU6xOJxvoAtimOOo2gJDG3Tq1i8oVQU55rBANbeQoAtJQFFmRg29ge9XL43BirwMGK71Qy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(478600001)(38100700002)(26005)(1076003)(36756003)(66946007)(41300700001)(6512007)(83380400001)(2616005)(107886003)(66476007)(66556008)(6486002)(6506007)(316002)(6666004)(7416002)(5660300002)(4326008)(8676002)(103116003)(8936002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yUHmZYk5hcuhGYVVWykHTIFUSr0HeoGfE3wZnab1E5X64dXBkPaWmnO08hC4?=
 =?us-ascii?Q?neSNrivKQ4W8WeGsa3VHAxKCXc68ht0iwP9qg/t7RDAMWIqGBTJpTCYFeWqX?=
 =?us-ascii?Q?8is1G4G//4GqvRd7Xz4Rni5q3cBfRSceeJndISpHelO8GKQchjpbhFViLEQL?=
 =?us-ascii?Q?mUCdNnKXznsHrYl3/2OuJ4s2y0tWpqUlBG9BPH9SkwyGokPIpnwATJx1wc6o?=
 =?us-ascii?Q?IGtMnh4xyCNltQOZkAnXZJKLRcTQHrYQDF73WPwJcBQ2dpQ/h9+I+Qxd20Un?=
 =?us-ascii?Q?yDnMefhtREoMk2egWjDIqGUIQfPdk5jPcUuGzD9pMXoZ0ijnAC0wPvyBl67x?=
 =?us-ascii?Q?q7tVpYLl58r4tGb0VFShNuWNwLyTJYwkVdXRGbpdsThlkNkz66l1/uuOF6/W?=
 =?us-ascii?Q?TwMbPMFl2gpxrm0X3pbIvb/PBmaIpUNwkdXA59R/Jml2QsQnQTiaoZB2F6se?=
 =?us-ascii?Q?QjXXbGfR4KpbqFF/q82M8Z0ysyQ/cs3xKnh/Ym4nIpvHfFJDVIYRJs2nxVeN?=
 =?us-ascii?Q?KZCIw0My4OhZh0qm2AnDZT8AewENwT/nMxbguxBeqSAgP5Ruxjl6lNiIRtzQ?=
 =?us-ascii?Q?w+EQuPAKxtenwYLqFnWmkwwqQ6Aw9X/1dfRf7VP7PiyaXQs3a1OGGbxQi0vv?=
 =?us-ascii?Q?C5quS9qOWuavNrjET/UTlbGgnQNCuvQ+quBMm0voIrSUSElwPLAmdIa5Pnzq?=
 =?us-ascii?Q?BcqQH6/3oUzrnk0FA1idBfJ4S1wSRJqBBMk9nZhFbTQHLuiOU94pjWqbeiZZ?=
 =?us-ascii?Q?+xhK5X61OEIUFPRgIxCiSHa+0pyzbvYSOlTDgVgm92c3ZE1yAc324byPhEhx?=
 =?us-ascii?Q?/PyPDPbbRX4EaMgaQxdOk/MZbH6UKsjYwh/XgUGQ16p2MdPHIgdCNv02zdWn?=
 =?us-ascii?Q?WJeoxrNcZgRgvfKNUxIawl26n6q6Fl/l7HbCpRGYzwVo4DNR7Cok5RHncGO0?=
 =?us-ascii?Q?uu4LjbUeExE2pyLGSPA44r7tCV2uHVkkdVqp/DWUjONtHVBsX1knANcWjoug?=
 =?us-ascii?Q?HaP0FwWlOV3UHuPhXIa9kHMUq4KbG8uHaVf7JBJy0VsrRg6Ha7d45oEFj0cq?=
 =?us-ascii?Q?MLAKrDZkQPqLjBQZpaSbuXaz/crV3RY1a4Lm7h8NlY3ePlffBy+BIS2YDS2S?=
 =?us-ascii?Q?YUYOj699ljQfcx8CYJEwAJ2Ho9IjkMmIe1K1Uda1+eWk3rza1yEl1m8ZNztj?=
 =?us-ascii?Q?fkcrt8n7+TsWs4cYfzDZh98k1yq3PXXmqFPTZplAEedfqUCU6ExYUyf9Dut8?=
 =?us-ascii?Q?fa2pRrp0JQiqDXTXcG+6BOr1ORh92dHudFo6dM34utb6hEpS8W9DzDMz75Co?=
 =?us-ascii?Q?dRno4vW1FoUMz2TZ6lVHspxmMmH/FVop3HNYLwzmAb/rGm/vOFmBiKSUdRpc?=
 =?us-ascii?Q?Z/Rf6pyhftZ+h4LnYoBuNvvZzTh8G/aSFqNckpDlSSPdljuNj5qGNq/DOXC9?=
 =?us-ascii?Q?37Tx6lU4V5V04ti+eqEpqaycz1i4Ov2B+9lP1znkRqXW5dzKHhnHQSQOPOB3?=
 =?us-ascii?Q?R+XjVtbo/v+fUem49sqAFPcx8IszQeQ13o0twcF2lnG5F6X4W04c0JKtElWP?=
 =?us-ascii?Q?E05pvx3F+k3VBUrYbj1IpmC0RDH17ap4ASqHrWPRGVD2mNO6rD4k29a4Zcja?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?8S6aWMRaoiIqqx9xSb0a1wWIkKniSJiQeezEmMiZIutrGvTnZZiFP2wd2lno?=
 =?us-ascii?Q?HFJ1J47GjIORk2Wun9IRz0hbxOgazpsdJtKGCnq6obxwcAAQs0h4Qut/tPla?=
 =?us-ascii?Q?tr0Y9An2w8TF1mfNLaIMmzk3RfyqqqpHnYALET90lK21PD9qABUXmjxT5Ioo?=
 =?us-ascii?Q?5QGx626Eo7xAWtmr7mo1ziQOBNcm1vc72xIOWyZ1fSd5CfJko+K6v4ngakf7?=
 =?us-ascii?Q?i6dcbBPvBmkKgdS1CSk3//aqYd5f0iECo2vRQ8ZSAMNHJD/SKt1/Oek15Er1?=
 =?us-ascii?Q?oWlCnXMfaEVEh0ABxclbw1Jjm7Lmx4pJMW1EN2QYxvluWrFdwf7kiVrlgk7F?=
 =?us-ascii?Q?DJuckh+y+PcmUiR4g299RZ65xMeBOsPuvwcDfQ+oAPPxs0IOBR7JVJK32L2e?=
 =?us-ascii?Q?JAP54YjgLGhDw9H21+d1djLSk3rlI5f83fxT7wfcvYCwQwhFdYxEpVZ2gN9k?=
 =?us-ascii?Q?8RVXXx0N8IRd0ANNgXJL5ioHFgDy6RbdMQQAVabm5GG3iT/CaAHGhvWj3b0/?=
 =?us-ascii?Q?sSu/ic2+lYgKKrGYJUdboLkdQ2+9836dGz4u/heVY6e6zRbb8ZRpwwrKZZQ6?=
 =?us-ascii?Q?X1zEZfVoghrBsNwpFLN2k5UPnHn8WpPPFMBC4up59RAI+4hKtEf+zIe/KwcK?=
 =?us-ascii?Q?KKfBrZonJxZgPaIvsJ0eDZbHCef9lfospmFBhs59zYYH+MsNkQcNvVuV4ntx?=
 =?us-ascii?Q?B5XCZS6UNguOQA6fRlL+NFWOrBwUBNL396QqUp1jj0ySgpEwHwYlFaXPP7gh?=
 =?us-ascii?Q?QECDPdKPTosY5JhRjWyat1ydk0F26MqWNFQLYmCpWbguwUwDLhJ6UMoS41a2?=
 =?us-ascii?Q?dN0Owiy9uRD6lSllSh8n8RcvmChJ0l4UUvym43WUvcZ7xfH2Nn5tsjWDBylX?=
 =?us-ascii?Q?aEUhk6x+Vt92/2eZjOzD07jwzbYJjLhxHDcn4loy3F8wwS8hAQWX8mk0cswP?=
 =?us-ascii?Q?YAEgr2W6fyFeUJtLFHoNDneAQVMhPO3unfZoP6zfWc9uZRO0f23d7yN2Fi33?=
 =?us-ascii?Q?Vnmy7vbNYQIAw+nS+JaMIkMqaiLJhP7MUeXshVdxKF6AKKzgUkth0rNFaIPP?=
 =?us-ascii?Q?QnAARVDQricMk+ucCLnSjIMx3Z0VKz/FZBk5IhjLrAU/FA1f3yVm8pLCJsgL?=
 =?us-ascii?Q?eX22jwmo8U8sWOugbC04S+1OS+s/nh4xF6+ToZYZMsS6XMt1r7eOgCY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859026f9-65e8-452f-5177-08dba989f916
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 18:50:26.0338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlIgP7oBt4bn9kBHfx27nH4m1QBsyiqqPqvzxlkyXxrPgJo/M3YfWLTMudWUdNpf7TFhgOYfWbNjs8ZpJFvc8jUNklM2kIClMyGBnmFqRF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=482
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300170
X-Proofpoint-GUID: mb-hkt9pfv4cL6pGQ4HITQCjtSzH_TkP
X-Proofpoint-ORIG-GUID: mb-hkt9pfv4cL6pGQ4HITQCjtSzH_TkP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Threads marked with TIF_ALLOW_RESCHED are preemptible, but do
not have explicit preemption points.

Handle them as we do preempt_model_full(), by rescheduling in the
irqentry_exit path by calling irqentry_exit_code_resched().

Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h | 13 +++++++++++++
 kernel/entry/common.c        | 13 ++++++++++++-
 kernel/sched/core.c          | 32 +++++++++++++++++---------------
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..3716c223a703 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -415,10 +415,23 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
+/**
+ * irqentry_exit_allow_resched - Conditionally reschedule on return from interrupt
+ * for tasks that are explicitly marked TIF_ALLOW_RESCHED.
+ *
+ * Enabled for both preempt_model_none() and preempt_model_voluntary().
+ */
+void irqentry_exit_allow_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched
+#ifdef TIF_RESCHED_ALLOW
+#define irqentry_exit_cond_resched_dynamic_disabled	irqentry_exit_allow_resched
+#else
 #define irqentry_exit_cond_resched_dynamic_disabled	NULL
+#endif
 DECLARE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 #define irqentry_exit_cond_resched()	static_call(irqentry_exit_cond_resched)()
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..b4cee897d6f6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -389,6 +389,13 @@ void raw_irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+
+void irqentry_exit_allow_resched(void)
+{
+	if (resched_allowed())
+		raw_irqentry_exit_cond_resched();
+}
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
@@ -396,8 +403,10 @@ DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
 DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
 void dynamic_irqentry_exit_cond_resched(void)
 {
-	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+	if (!static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched)) {
+		irqentry_exit_allow_resched();
 		return;
+	}
 	raw_irqentry_exit_cond_resched();
 }
 #endif
@@ -430,6 +439,8 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
+		else
+			irqentry_exit_allow_resched();
 
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2299a5cfbfb9..3c1b1b0cd575 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6570,6 +6570,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  *          - explicit schedule() call
  *          - return from syscall or exception to user-space
  *          - return from interrupt-handler to user-space
+ *          - return from interrupt-handler for a task marked
+ *            with allow_resched()
  *
  * WARNING: must be called with preemption disabled!
  */
@@ -8692,25 +8694,25 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *
  *
  * NONE:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- RET0
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                <- __cond_resched
+ *   might_resched               <- RET0
+ *   preempt_schedule            <- NOP
+ *   preempt_schedule_notrace    <- NOP
+ *   irqentry_exit_cond_resched  <- irqentry_exit_allow_resched
  *
  * VOLUNTARY:
- *   cond_resched               <- __cond_resched
- *   might_resched              <- __cond_resched
- *   preempt_schedule           <- NOP
- *   preempt_schedule_notrace   <- NOP
- *   irqentry_exit_cond_resched <- NOP
+ *   cond_resched                <- __cond_resched
+ *   might_resched               <- __cond_resched
+ *   preempt_schedule            <- NOP
+ *   preempt_schedule_notrace    <- NOP
+ *   irqentry_exit_cond_resched  <- irqentry_exit_allow_resched
  *
  * FULL:
- *   cond_resched               <- RET0
- *   might_resched              <- RET0
- *   preempt_schedule           <- preempt_schedule
- *   preempt_schedule_notrace   <- preempt_schedule_notrace
- *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ *   cond_resched                <- RET0
+ *   might_resched               <- RET0
+ *   preempt_schedule            <- preempt_schedule
+ *   preempt_schedule_notrace    <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched  <- irqentry_exit_cond_resched
  */
 
 enum {
-- 
2.31.1

