Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81F770BF7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHDWdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHDWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:33:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D8170D;
        Fri,  4 Aug 2023 15:33:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374JCask019548;
        Fri, 4 Aug 2023 21:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=HbIgzU//lmaS2pdv9E9LsMM2eFU3GsqUKNWEgAWLGEq31wVN7n3d6/x3wTAuVnwgzIwt
 NdOSFuh3xW/9lumim2apr+pbVyxFXhJSZbe3egQw79y5wzyKxK7wBFDfOrumMwuqjqYa
 Gub3kmkEMrfFwG201uqE1CnvxgPOeF+IVq6h/McEOr8eF2Inp0t0QIVWOoocQNZZFBDU
 DN6VPi9MoYQQI5r35eDa9gCOk0YOCs75kcJmwHV/Q7xaAi2G5QAGxaiZhDTDRUGVSvgC
 4GRNbiOl5R68OSAcNZkU8wSsTTjP0nj+0glFvic1gb4SEqcv5D2Y6s0k7xGilmMqZXAb rQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s79vbxr1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374L0f7t035025;
        Fri, 4 Aug 2023 21:04:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m09x0uu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 21:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHXVipYslLFjbjV89o6jSjTpB3H9LsEaUa9/WdbopJ74e+xI+hcx2sVDslA5efxB5AaEMHtEcNK5strLOk7dsylx31Hb3xgiXHcZkJeNxK0Pg2AI7ppHkMaNNvTeRqAINHNiv6gCT4YNXmvjyIK1xSzvtqleQCF89zWViy9x0myxvbtTX8BkYPfoK13VMhXNflTgW5xZV4ZMPHevxkZWHPjSKq/sB9+r85cATJN7O9oR8EUB6480h8jhNbZpkX+Orjm2U+l9Mvpba9TbAG5mhPOTd5Z2GTqLkUjiJdc4S+6rl+0OG790go19f5XmyhV5smNkvEhTBeNqLChoP5rINw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=HHWJJHZTnUINyoxDg8SLUOX44p7gXJyaBqyces0VVZa5EKJ1TmlIgEQwUkt4vh9yuow3ApP4zAw8OWT1qSwuTWUWuZcDUbxwYU657I8XE3lrsl3mGBR9v1LLcoov92B8Hzp3i0qjCVLKCGNIQfRVOtCgpNmmsglzo/R5W6YRmKsZv8cWZESb5UXNwY7zYdA9PQHfciEGbPVzzAcWFC/FI0meKBLpMy5m0A8hYQcJfFUwCMn+lwHCbFWhxZIeqMuU3vSvHgiEppX4bxfxxULZXtjJYF2PnHndR/BcgpeKDEEcyUXWmrl000zXNo1qKyQWC0PJtY6xUpPQV+bW9z5Lwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqZzUcUI7g9GrNNQb568EFpHtig8R3NmjYR2Lpu3gEg=;
 b=him0vZtv8PyA4cUSInkfOCTMyvP5ccfNeZu/oqz332srw2CUklstB27Oyxoc+B8CXjBL4wvmsfxdQ21kPVYXoLsjTKO7MaPivpJF933U9DyPT5UJq2fYMLAQgnCbQ/20oYKEgPoxUIFnAJYaMoYr+YoTibwhgIboJRIc+in1YCs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB5330.namprd10.prod.outlook.com (2603:10b6:208:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.22; Fri, 4 Aug
 2023 21:04:27 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:04:27 +0000
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
Subject: [PATCH v26 7/8] crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()
Date:   Fri,  4 Aug 2023 17:03:58 -0400
Message-Id: <20230804210359.8321-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230804210359.8321-1-eric.devolder@oracle.com>
References: <20230804210359.8321-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:5:74::30) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a3adb53-a01e-4218-70d6-08db952e6338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4arDRL8Kc8lhVaQqj3NJwEl5MGN22HEffgt2Vd4pROkU3MTvFyHgWCPmozeeJJJ3HX6zLVQwZgAsZSHHzCWvZsId4ymVwJ7lsyOFdFkWt1C08Q+qhKkNJa1I7RgZYDPat4TSRdSKNON//usAY9h29v+HpdQnzzaXXu2mRrG8VgoXmbcCMDFchMqOUQBiwvF8PS+VE3ZQMQvub+gRefHmToqSweHX52KnV/XDLWbhp6McpuSQZMgpBpW1Tg4aYi2U1Avq8YBfMNtsKUxvdx4w0k3wej5qFOd5rAOrMxvKQoctddXbS2J/hdjIF0h7sQa73UlrEa+VVuq1ri21ajEuO7VqV+ZX0heRyQO1QYbb/1qZSVfCEqOJEhkwX43fuUnp92LQvTI7TWOXFE3hd3d6+qbn3fx8IF/7WygWmoZQjCYV6PeCIc8wn1nQ0FEg739TRCXb9UOHksPOx6WcTRDnGC98M0bsWFAxCGBuz++G1mNpQ66q5zKYccLta2srAKFXWSe9auXT9+3S3SQ22LPwy4HeohY5RbG0TZNkUx8BWCcI0hcgQBkDXkYOKDpBCJDzedEXOeyP8BxjhE55Exu3t13SmapsAgrR+Rdi1O641I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199021)(186006)(1800799003)(6486002)(6666004)(6512007)(86362001)(921005)(26005)(1076003)(6506007)(107886003)(2616005)(36756003)(83380400001)(38100700002)(66556008)(66476007)(66946007)(4326008)(2906002)(316002)(5660300002)(7406005)(7416002)(8936002)(8676002)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fMb3Ts7UIMyubCTNq5XUKvs8wuwGcFyPZBYF14GxF/X+JAfcZ2lXJWY+s2XL?=
 =?us-ascii?Q?GNQbhSNmuc87JD4xSys4YzvxqHDfY3F93RkB1/k/i4cCLQlWAhDZEI5acl+I?=
 =?us-ascii?Q?F0OhVddo45Eu3nOGjVecCXaqtfMtrHWro9k0kOvpV3VgcT/37zI7n27ftGX3?=
 =?us-ascii?Q?rHq1+90nfiZmJt7oTdu2qWuyoNfU01c+7EIKBIGQfFXVlQjPf2FvM9lfjG6d?=
 =?us-ascii?Q?49j5agjsr/EY1ASbrPTS7ZdBYChth6oko7RAPGJnl4JxJ96i6blNuxURgI4h?=
 =?us-ascii?Q?hPqeK1QBW/bEKgJVk4DRSzocyIux9yMjsPury1Yobc9FvZUZHNycAo+DXCfC?=
 =?us-ascii?Q?cWBwV3T3VWL9tym1dQaWo+0oWvcKf6g8U8OaOXHn3Bo6FodR2dMeL84EhM58?=
 =?us-ascii?Q?Kxn54O7jWWFM+muC1a11dBQUZzZSL5AdVha6sKiwhiwfpkwKncF5Q7R5bJBR?=
 =?us-ascii?Q?5UhJ4SigXBljJQ5zlXi1OAQnnDeaoTSKWJN6uGCnldjJJDh6S4eLqUtCUlRZ?=
 =?us-ascii?Q?Pg8Zf514Mqym2fKyyKiOWXtyF5mvmQR2VLNoKAdlwXKNkd0ivzH54/hoCTO8?=
 =?us-ascii?Q?KGxQR6QXx06YKVPhiMgN1xxD41BDmAz2ABgcaoTuE0QhLTFskRRFyWyDd8K7?=
 =?us-ascii?Q?XiJwrzJbRsdzo4fi7o1n3n3m3BUinlUPNDZuV7smHibuXLhHqOyVqEWkntID?=
 =?us-ascii?Q?N9AKTywMe7HSzRbqeV8WZRXUcx7h/9fTJgUsNMb6FoIOt4115uVcIsgN12PF?=
 =?us-ascii?Q?dZzIiRyrXX7LMEQvjqfgLcl6jhddd7/cUUNuCHevaxq4jQM7eek9f1YqzFbv?=
 =?us-ascii?Q?XM8561CUAr6c/fJbCEzv5SYUN3WqN7v2X/K9VMI2PLC3MHuu+qe3qXt1AW54?=
 =?us-ascii?Q?cml5CjcyG0ZxpkJ6v9CQbYmpUiZV3J9vNFCrk/C57YONHwYr871Scsle+as7?=
 =?us-ascii?Q?cpfAW6LoopHQfB6QUJfL3xUy2t5hnI1TWqAlnVTbbv3r8hDTkKbOlZKqpQ0u?=
 =?us-ascii?Q?Zytm3I6jrLyT2qC+scRajSu2bA9QfMupALzaYpO2c7F25e/UBFVZPI47BdCH?=
 =?us-ascii?Q?e54bfu2uLYJy2kHrBtWxxi99is3c9pKrhe9IeupHjEGtkqN9kT3/JmisyPfG?=
 =?us-ascii?Q?mkytOrfHwi27866G4KgJlbQmXewqG+ZpdVrsqLGOi7kE9k1oUQn6Oj/WK9eW?=
 =?us-ascii?Q?7CqCXjP6AWlTrKmrSwS2uN4mmYcP9RU/4vnIq2NzquKMk/0t9sTVER/flUPo?=
 =?us-ascii?Q?lBmIXEzC9VrMDCXNm1zN3pl/JINd+W0D1KolPFiVkBt9/I1OoUFP7w9iW7dI?=
 =?us-ascii?Q?8smzU7R2262hzck5oJTLeKrHNHK16hpqyGJcmEhpZyrY9Z2LvBtMul7DfVUb?=
 =?us-ascii?Q?D0t8War1+dL2QzWCa9adWAJO9uL2QZuLkFo3rpqv2lf/SNCBCAHgbMcAscaJ?=
 =?us-ascii?Q?Rv3bXz3mB7D53a8TtpUVjlgne6EUL9ZP1dAMTEK516TlfYzKUo7uZpCMH5uS?=
 =?us-ascii?Q?oFZzXuUnNYQm74wE4yNkQdrC62CHEr9t/cNHAG22P5Orf3VklYpgHMPm4mQq?=
 =?us-ascii?Q?AB1zZKhONO1t6DsPbeH213iGB+MiZTNw0vFjJX2SztA8C1kdYceZmRHXhDT1?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5T860SovuECNvhPDw/NZ3GLckAtcMhtZfzesZmetqO5agVdb/dOhH+OuMJC6?=
 =?us-ascii?Q?Y5aoNKZkZdiIlcPqMMbje7T/n6Z/hBTwAqw+6oVrx9bQjAwQrnz/gzP6TQQ8?=
 =?us-ascii?Q?BD43iohHwA2A69tx84xgWGEbEO/L4KHg+e83G6qoKwT0O7xVJYXEt1crc5vg?=
 =?us-ascii?Q?QrAc14/pSFa8Y9d4+oKPMWhQcB/67miO6+F7R+MG/ORDMZP69zO0nmczwaLW?=
 =?us-ascii?Q?EOWen4J+BEPLIq6cR+KkYRSmNAdrb2Qs+MyK0J65lIlEFgJuB4e1rNyEqP0b?=
 =?us-ascii?Q?VQ92oJFx4mnVbtteZh4ACQbf/uWtCV1xUeO7FDVRNnEvxmaM/wuPP7ohKl8q?=
 =?us-ascii?Q?z/+mJkmZowriw46+52M6ZCSSWBsOer+/Kr2yRunxcK7Mt9yccqs7jtMYfUsT?=
 =?us-ascii?Q?1paGYnzE/3ynmPq75QmDi1a+ak88ReJBENX0w05A2Ixk1Wx9g0tW5bx0zJW/?=
 =?us-ascii?Q?X6mqBbcF2o5eCXF6vDpcsIyLHy+cMfXV1ypimnXR8d5LZl1RG5lLRy4RYoHG?=
 =?us-ascii?Q?c1Ud698mN6RB0VityPwP7gjQOZkJKkX+mq4Aou1/JjFw6UfPXMLIxEt0377u?=
 =?us-ascii?Q?viWCw05//1iveo4L9er8Jq62MpxLisGdwlPOak1c+kuNxW7UjNIx2DFSNZl+?=
 =?us-ascii?Q?YFGQlhR1lCJ/nbJjb5yNTT0weHnip/pKgHg3W6Mo6XOFR9LI/W63270AGtgc?=
 =?us-ascii?Q?s5FvJiIj+hd//f7/F9fNAwIde0UR+vxJ2Ge5LGuYMDkzJsbfYC+PT5ntGcVd?=
 =?us-ascii?Q?5wSKqVoDLk27HBzv5MwpA1Gen+tDshCrd6OEIN73YENH35IxzPBKkua/b6xS?=
 =?us-ascii?Q?jTk4sI+KevDD4fm+bcuLYlrXBGIT4anSZwltg+LSvXvJ48ovSkR7Ia8wPw1I?=
 =?us-ascii?Q?UtQwvFjRgHpeakMkdIn19RD3gm4LgGJkUS6cBcXaFCAgIWtrw5E/6YKad85p?=
 =?us-ascii?Q?WoCLoLW+XxnLyREMIN+fl/ZiMtkuSjp+lTQ4ZwwtsbL0g6a9h28XViJkrWSP?=
 =?us-ascii?Q?ZVcAZgLib1vxDtO402jNdNYM7Sax3JN6xegYBmua9Vt7GdTKVEbJc+Nc3iKw?=
 =?us-ascii?Q?gYPxCwAARwsKYP1Wa9HAEIOk//RwT3hYD1mSfYOM4CFO2Z3zolrYjmFMQk6p?=
 =?us-ascii?Q?emfBMhxpLnW+cgVJvpi9gbYa02Agvbof93XflMSUSSNjakSrETVcceABGTcn?=
 =?us-ascii?Q?xhIgk5ntqY/rqxbgi8GSOMgH9VhRhrLBQ90Cpz8Mi/JzLTv+kxZA0zXorwPr?=
 =?us-ascii?Q?IDomjtttD55sc/OXYAQ/byz/xLRIKsfpThMtezUw8awGdOgd8GC7f6aaARlo?=
 =?us-ascii?Q?cnUEziEFUXmwIaaSRV/54wiTE4JcBzGNx+81n7Uw1p4dWdVkteg480ZkmRCE?=
 =?us-ascii?Q?rJ2x+dY0p42wq1ObG2n0Yu2duwItP3o9IH0EVj5B0voYGoRpJyn5t2whceEQ?=
 =?us-ascii?Q?ofbhNiZmBE0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a3adb53-a01e-4218-70d6-08db952e6338
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 21:04:27.1132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1T9Vwa2fbTqWHOlYeOtUDGnlLxsYBPygLSIWSyv47JONol+ugOURVk5/0lB/2vtawi8Z65HHIFUhPNGphjbYmOdhtF7ZMByaxFK/uOnCug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5330
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_21,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040190
X-Proofpoint-GUID: G46q33Rz9DbrPTqOwKfUX7Ic2PWFg7f1
X-Proofpoint-ORIG-GUID: G46q33Rz9DbrPTqOwKfUX7Ic2PWFg7f1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function crash_prepare_elf64_headers() generates the elfcorehdr
which describes the CPUs and memory in the system for the crash kernel.
In particular, it writes out ELF PT_NOTEs for memory regions and the
CPUs in the system.

With respect to the CPUs, the current implementation utilizes
for_each_present_cpu() which means that as CPUs are added and removed,
the elfcorehdr must again be updated to reflect the new set of CPUs.

The reasoning behind the move to use for_each_possible_cpu(), is:

- At kernel boot time, all percpu crash_notes are allocated for all
  possible CPUs; that is, crash_notes are not allocated dynamically
  when CPUs are plugged/unplugged. Thus the crash_notes for each
  possible CPU are always available.

- The crash_prepare_elf64_headers() creates an ELF PT_NOTE per CPU.
  Changing to for_each_possible_cpu() is valid as the crash_notes
  pointed to by each CPU PT_NOTE are present and always valid.

Furthermore, examining a common crash processing path of:

 kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
           elfcorehdr      /proc/vmcore     vmcore

reveals how the ELF CPU PT_NOTEs are utilized:

- Upon panic, each CPU is sent an IPI and shuts itself down, recording
 its state in its crash_notes. When all CPUs are shutdown, the
 crash kernel is launched with a pointer to the elfcorehdr.

- The crash kernel via linux/fs/proc/vmcore.c does not examine or
 use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.

- The makedumpfile utility uses /proc/vmcore and reads the CPU
 PT_NOTEs to craft a nr_cpus variable, which is reported in a
 header but otherwise generally unused. Makedumpfile creates the
 vmcore.

- The 'crash' dump analyzer does not appear to reference the CPU
 PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
 symbols and directly examines those structure contents from vmcore
 memory. From that information it is able to determine which CPUs
 are present and online, and locate the corresponding crash_notes.
 Said differently, it appears that 'crash' analyzer does not rely
 on the ELF PT_NOTEs for CPUs; rather it obtains the information
 directly via kernel symbols and the memory within the vmcore.

(There maybe other vmcore generating and analysis tools that do use
these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
common solution.)

This results in the benefit of having all CPUs described in the
elfcorehdr, and therefore reducing the need to re-generate the
elfcorehdr on CPU changes, at the small expense of an additional
56 bytes per PT_NOTE for not-present-but-possible CPUs.

On systems where kexec_file_load() syscall is utilized, all the above
is valid. On systems where kexec_load() syscall is utilized, there
may be the need for the elfcorehdr to be regenerated once. The reason
being that some archs only populate the 'present' CPUs from the
/sys/devices/system/cpus entries, which the userspace 'kexec' utility
uses to generate the userspace-supplied elfcorehdr. In this situation,
one memory or CPU change will rewrite the elfcorehdr via the
crash_prepare_elf64_headers() function and now all possible CPUs will
be described, just as with kexec_file_load() syscall.

Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index fa918176d46d..7378b501fada 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -364,8 +364,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
 	ehdr->e_phentsize = sizeof(Elf64_Phdr);
 
-	/* Prepare one phdr of type PT_NOTE for each present CPU */
-	for_each_present_cpu(cpu) {
+	/* Prepare one phdr of type PT_NOTE for each possible CPU */
+	for_each_possible_cpu(cpu) {
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
-- 
2.31.1

