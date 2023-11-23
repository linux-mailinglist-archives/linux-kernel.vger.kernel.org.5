Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378A67F620D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345907AbjKWOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345812AbjKWOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:52:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBD1BF;
        Thu, 23 Nov 2023 06:52:52 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANEdJfA022504;
        Thu, 23 Nov 2023 14:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=BQ7oBpPzUaU+x7Qr97ucs5wMiD1mkWWZmroh96PYkTw=;
 b=NqvFuhKreqviYXIGIJSdIu03jR05g25UPudyyxC40qb31W6qFrBHTVkKC/DLXfOy/OdU
 q6G6nL/ijj7QKyKPEjwvNc2e+dX8IRGWXQrug7laBeI6ViBoV69YNAHuNgvpt7D5DRyE
 gshl+ux1P7mlb53dFMhxsy3xdxf4DX0aVsBJswdU32fZX3iWt3PXiNCctPacqqMl9D5j
 QHw6QPPJWbNAPk6EAtY+CtCow04u2dGZUvNPcHFXj2f3vnsi7eNVg9s4Ow4OWd7Om9R3
 gEfpH+zOKLku6Yt1R71w/i129DyrJlGOhpv4a/FKdtRCALIFncGEbaXQZeENhRnzWogf zA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uen5bhsb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 14:52:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ANEpsbY036041;
        Thu, 23 Nov 2023 14:52:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekqafsh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Nov 2023 14:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPBlVhMYLExuZZX5LofRR3BpRxooLz3yQdKRC04IRqhinw9plssUd+QhsbtdiDWB9q5tV/oOPONxTu0ZqwHhGpXGIZtJHsTy19NtzCCogJHPWA77pN+DS+xge33trCJCcxNsBREGyxkzwAvW30Lfvxqesb6USuzWdz3K2E1QgsuaEdVt+m1trGozPt7Ryy+rEhQcxeKANrf0UmAwdokaGmGnG7nY58tPMvrUQ+Fa/42FGlWa+FbhsPfhAhzmoCMCUyyy1hx5iiG5/oQuwPBn9NUqsRZjVep7PsRvKZypH4gISi8fANu3NBrN9922JUb1K6n2JgdnNCxVZn1qXxJO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQ7oBpPzUaU+x7Qr97ucs5wMiD1mkWWZmroh96PYkTw=;
 b=b0nR0VUL3lylw+4O79XNCPMexhGmnpFaNS/7JKFnpmVgVjTsxsDmiv6K7Kd5Aky08SS37nORFvyhKge3kRQlqclxh9KrG1QJ1M2lh0Zx6JrqWDoAxZDyfb//PoJHKmh2H3AmCdu3KsP6uqZw0IDN+3kYKm5JFlxnZpekJ4L62Op5dPtD2GPj8ww2NiS9hKpMuZgxZxWWjdb1W9DQSdk68bqLw3odQDKnQ7nfeP5e6z6C+wpjlbmEaj4aaP/ZhZD3WOK54YwpUiFSeS1n16AdFDQ6Z2cGbuaXRWJ5ht1ZHm6DjxHwv9LMbosOAEucN8mDbzTpuy+jhYaZRXYr6CZ4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQ7oBpPzUaU+x7Qr97ucs5wMiD1mkWWZmroh96PYkTw=;
 b=iH6SoMWLUbhIC2D7JRKcjoMzpqLpcN0oRcyiAk4rOsaHm+DLWQksf85lETDVwIt6zFTszHaPjokFyDeejIj/gEjzKEtbhDeQvi4GyF3758UWOy3O8jf8BNY5hRyi/GA22gCtmdJ2FoV39L1BqX3UiNMIm+dXqN1i26sj0cskoZw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB6001.namprd10.prod.outlook.com (2603:10b6:a03:488::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 14:52:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7025.021; Thu, 23 Nov 2023
 14:52:27 +0000
Message-ID: <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
Date:   Thu, 23 Nov 2023 14:52:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
To:     Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231117090001.35840-1-yangxingui@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231117090001.35840-1-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d5794a-c598-4c77-0397-08dbec33cfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LsXiG6m0Qq0BHbqn+touXXgJY4invVWtovgTEw/IMS3T0zwOp6BhsAzInzbUtCAZ1YeH5dLL6xVElQ0VgpvAIgqv1SBHOCMBaAEgEzkULj+7DI/fsW2ORXwJAjMru5UY3gy1mt1INYAnT7juc0nNIszRv+0uPhXLSrUQ+ZO9nfNUeJdd6L7lK4gxLVvFMkNMZCdJCzEY8RTqm8huHKxDfFxLZsljqqsmJr7BLxxnx+ufquSBw5oHjknCapOJeK1JsIe1n4gDqENyxBJ23s0nIwSX8H1FluUY3fbbWBK8LEQaRIHt7p9ZLngjeIOnFr/G17WoaAiZrRqxg7vuamPrg55yj6vyiVVSYdymnGjuNxaQvO8kqH9vEQIFHJBY0qZLe0h7/ie1uTXXuBgpjrbSnofxSeMWzpCR+kTEXIJ3uNegpYIyHtRqDQp1d7ra9JSnND6TbPOBZ0dgAumw57MzCG5e2XIeZymcsnamZPZCecuXFHqhQNpdJ50b1RsYKX6kjeRd644uoRQMCoq8pPoIn9d5k4dJy0qS0KwXPU2ieQXXE1So4rwEGxZcLKpqgKiALzLcEOt6iOKGdBWOGjWvDOv2Mz+q5sM94SMzJldVMC2qWjUsrnKg1RUZvt6n/Py3ZkJybzWOwZczukUM4BP6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(7416002)(2906002)(41300700001)(4326008)(8936002)(8676002)(31686004)(66556008)(66476007)(316002)(86362001)(26005)(36756003)(6486002)(6512007)(66946007)(2616005)(478600001)(36916002)(6666004)(53546011)(83380400001)(6506007)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS9hLzhHQUEveGViVzBWV1dlMmJ1MlNDZmVFbXJXWWZLTlE1UG9FOTFUNXBO?=
 =?utf-8?B?STA5eWtzQ2swSEVCSWFTL2NxZmFoL29Cc2RnQlVxNThkV0ZCaGJwTXRQWkZB?=
 =?utf-8?B?bFVvbEVSSEx2K0s0TDdoWDdReng2czhjK1h3RmZxVGUxRHRkVzZDWnR2c3Zr?=
 =?utf-8?B?b0xyMFBvQm1ySlExU0VGdGZXUi8zZTRPSGZsZmxBbVI2Y0JRaGtQbW9FMmh1?=
 =?utf-8?B?OUxOV0k0Q0tHUDBoVFd4Q3pOenQ4K0FocVgwdyt5VXFhNW5ubDBvU0doem9x?=
 =?utf-8?B?Nk8yNFJJZ2dSN29lYWdEc2gxL0xvbUt0d01vU0ZaTXI3S1ZqSjlvMUZqRS81?=
 =?utf-8?B?enR6cFpJL1kwWXJDVHp4cFdBRXBHWFMwMmFrb1o1RmJyd0ZxUk1vTGRyOUl5?=
 =?utf-8?B?OFg5RXlQOWdhTm5UMWVYMEszbjFUUS8wU1Zhd3hiYzhsWWNYbmZrVmlJdWFD?=
 =?utf-8?B?eDlTQzBhb3U1cUswaWZ6R29zMlhJdXJ2R2dRQStBNGdUOEdGbS9taFJPMXRJ?=
 =?utf-8?B?R2RHa0JDKzRlYVlaaHVYaUJSTGRvVUFONWUvR0lyeDBOeHkvUk5EY0NNR1lO?=
 =?utf-8?B?M04rWkpiQzRrcEZqTU1HME9nWmpyQW0rNysrVWprTktQOXBmN2JJZGU3azd3?=
 =?utf-8?B?LzczOUNNdGxJYnMrZzNxY1VuSFlOSDNXMENwOVhyeEhNWlRUQ1NkYjVZVmow?=
 =?utf-8?B?NUw3c2hXS0QyQUhqdUJyblNjdndZRWVGazQ3YjdCeWY1WlgvTko1U2V3bWpR?=
 =?utf-8?B?ZStqeGd4YVUyMU1WdFFXS3pHTWNuVWc2eXV4M29wenZrejlWYkJQU3hzeHU0?=
 =?utf-8?B?QVJyY2FzVFdrdDd5WXlObERXWmlzVVA3OXkyRTVXa0hqTzh3RVZLSFJQL1pH?=
 =?utf-8?B?c3U1MFArMlhYdGJGSEhHWlB3ZE9zVGVWd3NRQ1VqSHc3WUFmNkplMXFqSkRa?=
 =?utf-8?B?YXBUL3UwMnM2WSswd0FuQlNzb05uZzN1WHUvcDZMMFJ1KzVKRW5hTUJhVUZo?=
 =?utf-8?B?RFJuZE5nbGZ0Y2k1QU1OSWF5UnEwMTZIazlTczRWMkEyQlJCVUlYSzhqUWQw?=
 =?utf-8?B?U3BBWlI1akJQSTVHTE5rZlYrQ2xNcVpJQURrZ09sc2syeElnOHJQSkNLallJ?=
 =?utf-8?B?a3FYSWxNNS9sL3VnNmpoR2xRUURjOU5MR2JjMkJ6UWNscVhlUXFjUjBkWEI5?=
 =?utf-8?B?VW1ncUM3cm5VVzdMSnBBRThRR0hkNmQwSHBkUWV1NFRtRDFGVTBBajhnOHFP?=
 =?utf-8?B?UXB6SnQ3ZGF6UExLWGZ5TlNLR2hQK2gzRnJwNEdkTDFJNmVPWjV4QkQ4c1JC?=
 =?utf-8?B?Tll3bVlHT3lwbmVDbGt5eWRYR0Q4UEtGOW9RYWt5SXA3TUZmeC9acVpHQjNK?=
 =?utf-8?B?WWpCa29Jc2c1dWFHWWJReUdrVFRVUUgyamhmdzlmcFhqNHZVL0RPOGxnTkZn?=
 =?utf-8?B?UUoxa21TaGtCcURhZWNZTFBVdkI5T1NOS2w5cDRHYjgvWlN1M3lZYVZYRGRJ?=
 =?utf-8?B?b0tjR1JhdWFIb1E5M0w4REFib3o5RzdaVVkzbVlsK0JMM0d3bXZrS2p0ZzJu?=
 =?utf-8?B?THlqOGxYUFZTWGpTK2tSN3RYSnRDS21RQVgwamNKVS9PekxLN2pqQm5DTzNv?=
 =?utf-8?B?L3lYK0dFYlc0M0F2Vi9FcFBtWnhnNGFrMlM4OE9RdTdIeWdjR251bjhkMTdP?=
 =?utf-8?B?aTdFVWtNdTFSbHlJd3E4YUpUYjI2NlN1c0Qwb2ZvVmhyeW45S0c1ZWZJV0ZY?=
 =?utf-8?B?Mm1iQWRQSDUwcUdDUXZmTzBzZExKMkFKNkYzejdNN0tsV0tUa0tpU2haYWtn?=
 =?utf-8?B?VlRZUU96U2dSOEIvdllIQjFZR3RqbE9OY2VLNFRjbU00VVVIeHBacjd2dFZR?=
 =?utf-8?B?R0l0Ymo0YnhoWDY3L1gyYkxra1h6QS9SYUc2U3FibmI0ZC9WVEJhOVR6UUY3?=
 =?utf-8?B?dW03dVF6aFV4MjlrbmxSZDBtekFZVTlidTVpUDh0c1pHNDVWbUlpenEyK1kw?=
 =?utf-8?B?UFIwdEZtSHRJYTgyWGpjKzcxWVppRDhxbmJrT3ZjekFMa3FTZW5zeUNtTjhB?=
 =?utf-8?B?WmxxTWUzcFA1R3RJc0hPVUg4UHFxSnhmcUU0MWl1NGNuWi9wMEExQnVocUx5?=
 =?utf-8?Q?0Oyula+BSI+JfSYNdzND4JNbu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IzVd52NdosIYnCmoU4kUt9fbG6cduo6eTB7xOZs645LtINvh31CpIoorfO6PQRR8QmnkGeoxle/nI8Kqe0s3jeeOkHq0NGwrt8ChRg+xE2+Mqpxan/E/o8IyWVsJPxp/t+y0eFIqVsiRfOKRnxAOR5WuK1NCa5YF0b5nLtHrhTjHZ0tqKjAS7i3fRUkAGEoGMrTlaWrMSlQFS2z29awg34bHduc0J/CBTY4sDgsGpRkSDbA4nVjBX8W2tiKeUWfNcdXbgAuYWvuiDyU/wpBCLjxBZo0cGeGbInO0hGtSM98/ej5mxilJ/xHW9qHGmrwf/Ft8kBjfAM4U5T1wXpwGy4CrFFT8BIjtiCMXY95QEu54e28GOiTdJbDl9jNw1Hfvw4KvwfxVsWROAXC3R05dWnXbAEIhIlujKc5WSbGP3RmEexTnB4lNLq/vKAILflKw78FWOnY9H4xHQO2xfTS1uP9C2oz0lftuT4yfCtlxj3Sp6jdslwfr64Jtsnrwzw86r2B3KfQ3bJ7G/cReDtmi+kGWe6QdXALEVHRD1C6SGurXoxekbL+S1skt7yTW8bHvF+StY6uXGQOMw/7pssO5VpY0/p7STWU0atJtrk5x3+0H2A3F70B8TWn/6qo06oOY/cztieoiaYfznjVjcB9flbCS1UUFuyzoPKrfFXzdQWhI4BfvzWU53iItyuzUYof2XoYPlLJLOomekAh3FBwGBueNugkzbVAjnXU5vrecqE9F27NN4ZhsRkoKCer1hl6SMY6wlc/wM4B6FiZFK2zbaebClZQEEJ/70eW/wPBJztiACTIxurxe89/gOIYyaQpOl81zAAGQipi0OakEEWOCUuFsQGM9sEhS3qSI9/yqIO+XKoBduanc19HO5ODRCEayQuOYya+gtpRkSfvgu+CcCPS3PCw/pHrXT2Yl7mkdYwY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d5794a-c598-4c77-0397-08dbec33cfa1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 14:52:27.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQ89w4CF02kUpQpUXHaTUQxFFmhL/BY2shuEto/BK4vQj4tLItGAv0EpRh704BaHCc2wola9Y2MM0tg9HgEzmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6001
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_12,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311230107
X-Proofpoint-GUID: uAohab_02xUmtOtD7Nw7WBVFQlsJVIXE
X-Proofpoint-ORIG-GUID: uAohab_02xUmtOtD7Nw7WBVFQlsJVIXE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 09:00, Xingui Yang wrote:

Sorry for being slow to come back to this. However I still have questions...

> When connecting to the epander device, first disable and then enable the

/s/epander/expander/

And connecting what to the expander? Is it a SATA disk?

Or the SATA disk is already attached to the expander and we are now 
attaching the expander to the host?

It is hard to follow this.

> local phy.

So is the local phy disabled initially? Or is was it initially enabled 
and we disable+re-enable just when attaching, so that there is a race?

> The following BUG() will be triggered with a small probability:
> 
> [562240.051046] sas: phy19 part of wide port with phy16

Where is this print in the code? I see "part of a wide port with 
phy%02d" in sas_discover_dev()

> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)
> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
> <...>
> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port
> [562240.085064] ------------[ cut here ]------------
> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 0x0000000003bcbebf)
> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain [libsas]
> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.479751] sp : ffff0000300cfa70
> [562240.674822] Call trace:
> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
> [562240.756014]  process_one_work+0x1b4/0x448
> [562240.764548]  worker_thread+0x54/0x468
> [562240.772562]  kthread+0x134/0x138
> [562240.779989]  ret_from_fork+0x10/0x18
> 
> What causes this problem:
> 1. When phy19 was initially added to the parent port, ex_phy->port was not

phy19 is the expander phy attached to the host, right?

> set. As a result, when phy19 was removed from the parent wide port,

You seem to be getting ahead of yourself. It has not been mentioned when 
phy19 is removed from the parent wide port.

> it was
> not deleted from the phy_list of the parent port.
> 
> 2. The rate of the newly connected SATA device to phy0 is less than 1.5G,
> and its sas_address was set to 0. After creating port 7:7:0

is 7:7:0 the port which the SATA device is part of?

> , it attempts to
> add the expander's other zero-addressed phy to this port.
> 
> 3. When adding phy19 to port-7:7:0

Which would be the incorrect thing to do, right? I am basing that on my 
assumption that 7:7:0 is the port which the SATA device is part of.

>, it is prompted that phy19 already
> belongs to another port, which triggers the current problem.
> 
> Fix the problem as follows:
> 1. When ex_phy is added to the parent port, set ex_phy->port to
> ex_dev->parent_port.
> 
> 2. Set ex_dev->parent_port to NULL when the parent port's PHY count is 0.
> 
> 3. When phy->attached_dev_type != NO_DEVICE, do not set the zero address
> for phy->attached_sas_addr.
> 
> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
> v3 -> v4:
> 1. Update patch title and comments based on John's suggestion.
> 
> v2 -> v3:
> 1. Set ex_dev->parent_port to NULL when the number of PHYs of the parent
>     port becomes 0
> 2. Update the comments
> 
> v1 -> v2:
> 1. Set ex_phy->port with parent_port when ex_phy is added to the parent port
> 2. Set ex_phy to NULL when free expander
> 3. Update the comments
> ---
>   drivers/scsi/libsas/sas_discover.c | 4 +++-
>   drivers/scsi/libsas/sas_expander.c | 8 +++++---
>   drivers/scsi/libsas/sas_internal.h | 1 +
>   3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
> index 8fb7c41c0962..8eb3888a9e57 100644
> --- a/drivers/scsi/libsas/sas_discover.c
> +++ b/drivers/scsi/libsas/sas_discover.c
> @@ -296,8 +296,10 @@ void sas_free_device(struct kref *kref)
>   	dev->phy = NULL;
>   
>   	/* remove the phys and ports, everything else should be gone */
> -	if (dev_is_expander(dev->dev_type))
> +	if (dev_is_expander(dev->dev_type)) {
>   		kfree(dev->ex_dev.ex_phy);
> +		dev->ex_dev.ex_phy = NULL;

This is strange, as we free the dev later. Where can dev->ex_dev.ex_phy 
be checked before dev is freed?

> +	}
>   
>   	if (dev_is_sata(dev) && dev->sata_dev.ap) {
>   		ata_sas_tport_delete(dev->sata_dev.ap);
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index a2204674b680..89d44a9dc4e3 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
>   	/* help some expanders that fail to zero sas_address in the 'no
>   	 * device' case
>   	 */
> -	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
> -	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
> +	if (phy->attached_dev_type == SAS_PHY_UNUSED)
>   		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>   	else
>   		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
> @@ -1844,9 +1843,12 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>   	if (phy->port) {
>   		sas_port_delete_phy(phy->port, phy->phy);
>   		sas_device_set_phy(found, phy->port);
> -		if (phy->port->num_phys == 0)
> +		if (phy->port->num_phys == 0) {
>   			list_add_tail(&phy->port->del_list,
>   				&parent->port->sas_port_del_list);
> +			if (ex_dev->parent_port == phy->port)
> +				ex_dev->parent_port = NULL;
> +		}
>   		phy->port = NULL;
>   	}
>   }
> diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
> index 3804aef165ad..e860d5b19880 100644
> --- a/drivers/scsi/libsas/sas_internal.h
> +++ b/drivers/scsi/libsas/sas_internal.h
> @@ -202,6 +202,7 @@ static inline void sas_add_parent_port(struct domain_device *dev, int phy_id)
>   		sas_port_mark_backlink(ex->parent_port);
>   	}
>   	sas_port_add_phy(ex->parent_port, ex_phy->phy);
> +	ex_phy->port = ex->parent_port;

We already do this in sas_ex_join_wide_port(), right?

I am not saying that what we do now does not have a problem - I am just 
trying to understand what currently happens

Thanks,
John

>   }
>   
>   static inline struct domain_device *sas_alloc_device(void)

