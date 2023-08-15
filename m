Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ABD77C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbjHOHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbjHOHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:45:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA4F1737;
        Tue, 15 Aug 2023 00:45:18 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOAoV020677;
        Tue, 15 Aug 2023 07:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Irh8Q7qkEGV4nLMwsiFqBGNB8AuzK9j8FDTQJ2CdiRg=;
 b=swYdKyc5zFd8aVjVPHzY1WCgP7bo3yEF4+jgaFlZmEcIP14bWLhNrwagen35m6DcHAk4
 nFGCD2ofAzXV/a33P3NkZZt28XIs5vI17dHCjTmFckwcPyBBnEyEdmwalxIGHny2iys1
 hDwEuY1OucYRYUEJdEGqqF5aCW1h+hBeVL3NfL8GIrBLnZpkhjBiki5UcoxtJsO1wZ4r
 9d+io6uNkrnXt7jUG555s3IQs/T2hxlEghMqeKxBsG9Cv1JAXNvJPtc8zb0BVNG3LuSU
 JyaDzuiapXVwfymASpyxG3cMaqm3Ai1WlsaoQR++YgmrXz5jgG+UcGmzRV+9Kwu2I9Mw rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2y2v84t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 07:44:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F6QpIr006780;
        Tue, 15 Aug 2023 07:44:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2ctndx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 07:44:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV5b9GOknGZSmdw85oJohqTy3qQPfquBa1Ojnotrq7kCch57ELhCbN+vptREhJAlNpIoPIgymPW181WbZpHFPAsS/O1IP/Up3rHcDv0CRIpQtWAlzowR+RusJOGo20EhPlgAI+E9X5U3a65QBiMG+idAQdCs3nI3zHFAO02fq6rC1viHetXF/e99IKLGlLDmbEoQjnGlocSfoyYBCeZvH5vvdqk8U5j5VITQaAOkOk9mnxjHkXelL5Z+CuaC5wXgAmR2dwQ67Qmv+07zQQf1QJzxaPyqdJ5HMoEoQi8RhB9mKfcDNaR1LKzCYrpQ48V0WtJ1yKJXvBm04Em0txQVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Irh8Q7qkEGV4nLMwsiFqBGNB8AuzK9j8FDTQJ2CdiRg=;
 b=SEq4ur6GCbeGoK6bfrfmnBQHA8DOvPIyuAd+cm+jw1DhP02nA7YTTTWp+9ETPfVaIKi9zB6WaCodnI9wLlmOqZT3Iqzys73bNcz+7GWjpK3YgUToV9Akaex7F2mRlpptZzJ+No+yLf2hoPg+xV1QNixGt1A+RKIOXElQR6HLkf+ApQD9vcbnMWzX3wGWmjKHmVzI/gd8tkeX+0nBnY3yaMzCaoYYGza1JfzDzPl7/NlNuIb7Gdn8Tgyu8wRqknhRYYUNdgQcCmgfj3p1Azs5k43uPpuPF3GlOrsDb6agtAfKrb+D/HHm5l/XCUElOJ6u9iihry5lILWCo28WBGNYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Irh8Q7qkEGV4nLMwsiFqBGNB8AuzK9j8FDTQJ2CdiRg=;
 b=ysk8eBrd/0IC8twDkt1hY30OlRpiakVpeV/zL7qVyKOyN33xajXdEAykScQVjr5dcrieeSKK5bAjzj6RMEIU8kwNSl7NVacNUMBqO2qDM5OchyyeFNvNXLcgisw879sdWWynlw/UK3el8NWMYe8IE3B5hP8NFnegcWyha2FqlhU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 07:44:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 07:44:48 +0000
Message-ID: <de5b2ba9-08ca-e81f-5835-25f0559450be@oracle.com>
Date:   Tue, 15 Aug 2023 08:44:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
To:     Damien Le Moal <dlemoal@kernel.org>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        artur.paszkiewicz@intel.com, yanaijie@huawei.com,
        jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230814141022.36875-1-john.g.garry@oracle.com>
 <20230814141022.36875-8-john.g.garry@oracle.com>
 <6a46cf7c-8eb1-15a6-1481-0ad0dcfbebc3@kernel.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6a46cf7c-8eb1-15a6-1481-0ad0dcfbebc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0455.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4477:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aa5b179-a647-419a-103b-08db9d638018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhvdhebLZwaNSr3LWP5jIU/NVJXa2gIIVSfpMI6yOEQZw6O7/tLuOy6s0VwCiG5v1CElV71dm04YdvpO6Mz36k5Ste+5BxvJgZyfmIOtuAygOmoHlqrnmSVSMerr8gycre8GWZIhWbS43JGTvdrl1jMEV9L1O+qCoj1QqLpVL6PJhZ2rtfMa8UTajnQ9Rg/jp714/5Zk/LpxrPPtY5Lzvn1pb9jY1iz/XV5Jct6zIJ/LrfWMy9CGdejN1blfKM8dpS3ac/oRmH/LrsZebrJv6t2C5hx7rYQ4klbElc5pvR3VLQs7jKVUhR0t5pKomeDhWqCEAITUZd5mRPg82wRyR36RkFezKvkGxBtSe5R4++H8GRzPUATByx9zgRHL1G8g5xu6/rgVCzcMDERVsH22EXTHSVUFX9O3xM0plgEwwF3J8k5qWp9Xu+15rOVGjPDQN08O9r7HU1NueJso5dw6JrPOny7+3xY2hGq8t8RCfvkIZ4CsmPz7IgcArMMPO4wNPJ9NFibJ5IPWi5oBIIlXDfdQqrXlyeI9Ma669uoPqER8vOB0RcZAz+CrCd5N/QnWY2jNi6W/S9v/MlmxBE9ZMRcij8XD+qEwvm3hwPs0SPP/rlq4u/lgB2bD6lkuO6QNyE9Wr8+JiRCIc/Iv+zK5OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(186006)(1800799006)(451199021)(2906002)(4744005)(316002)(83380400001)(66946007)(66476007)(66556008)(41300700001)(6506007)(6486002)(6666004)(36916002)(53546011)(478600001)(6512007)(26005)(2616005)(86362001)(31696002)(5660300002)(36756003)(8936002)(8676002)(4326008)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2pNU2J2dC9oRlIxcnZwUVNXOHB0cWZraVR3cTVBeEs2aW9WLzhidlJGRnFt?=
 =?utf-8?B?bW9jY0k5clRqUC9nUFNnZ0NxWlhCbyt1SXhTYXRLUzJQVHRLMWFJc2drYS9V?=
 =?utf-8?B?L1lIZ3E2WHVsR2NpVEI0Q0dEVXJhaUNVZi9WVXpjSWU5WkMvbTc2d1Y3MUpx?=
 =?utf-8?B?dkxTQUExMGlUUnhaMVBzMVBkQU5VM1N1YmdhRGM5SkVPMVNKOVc4Z1RBNUMr?=
 =?utf-8?B?b0ZJekRsUEtiVG83K1VOYXBCd3h4cUVQOWxsck05bVhzUTdybHc3S1VhcHdS?=
 =?utf-8?B?YmlDSDhaOWszZi92NFgzYWlZaGRwTGFtNjduckpkdUJkUGRoSTh5ekQ5UGNF?=
 =?utf-8?B?YmpWRXhCbG9TblhuWmppOVhEVTNzNlczMGRjcEtUQWZWTFhVM1poRXM3MEl5?=
 =?utf-8?B?cE5YeGo4ZXpmdGlJaXovckZ6Uyt1QmhmUUZVd0NPL3dlWDFwSkJpaUp4VVZG?=
 =?utf-8?B?WkRtNlk4RG91MmJSaTBrQ3VwSUFDeWgwK3BiV21yUjBSWlA0aW1wcTNxZ1FI?=
 =?utf-8?B?ckFLSFZKcit0ZlNaa2tUTlRQdWJTSzBrdm1JSUh1UGZiV2I5alB1T21zdndQ?=
 =?utf-8?B?Vzd5clhKM25waEpHTDVDc1lDNUo1RHBHMDZ6UUxiRVQyV2lVS0YwMzRJc3Fh?=
 =?utf-8?B?NTdjTUZUMk95UXhyWXMreE4raFY1b2x6bEtMV2hreGVSaHQ1QU1BRmo3czA0?=
 =?utf-8?B?Vng4UHJhNTZ0R04ySVhaMGNxWjlhRjV0QTZ5ZHptYkxOMHh3bGNRbnFwQm1v?=
 =?utf-8?B?RjJMWUY3V2hoTmM2WWtGSjFGbWlmVXA5Wm9oNnRMbzB6K0FkTXZIT01jWS9h?=
 =?utf-8?B?YnIrVEJzVTd6djVVdnM4Qnk2MzNMQ1JQa0dYZkw2dlZnMWxnbGRJRFFwOENw?=
 =?utf-8?B?bXg1WTFhY0R4c3p0THZNZUo1VHNYNkpiY1BYYXBhQ3Vzbmp3L01nMHVwTEVT?=
 =?utf-8?B?Nml2Y21UYWgvR01GVGtWbWZJUk5PMnVMK0RGMEZMMmF2ZXRObXY2RGdoOGhr?=
 =?utf-8?B?YlJWUzhYUVNHd1ZDMGxjYktrRHFCSXFxWFVUV1NsWXFDc1pmZGlMaERuZGE1?=
 =?utf-8?B?Z0lvaGxLVTc5VFRZVUFvU0J0eGx5THFDMVNZbXhscENFc1ZyZ01YU29SUjVX?=
 =?utf-8?B?L09GTERnbmhMczdEOVhrU3NwRDFENVVpWnRPak9Vakp3MDJtUGRFcHlUekJ1?=
 =?utf-8?B?ZkFYZFBRMnE3OVJSNzlmSytiTEhWdkQwNW00c0xsZzYxNWhhUTRkNmVmbWZL?=
 =?utf-8?B?c1hheEdjVzZISFMrVkc0RFRxR2E2WFJXQkJHaksrWTVTckwxSE1uNzR5TXE3?=
 =?utf-8?B?K01WYjdmZlNibHlmK3YyUjg4ZHNhbTZnTURYT2dibkduTGZVU1J5NTVHWUx4?=
 =?utf-8?B?MS9ZOC9aQjBDSnQrMWxnUmY2dmVIcFQ0QTRHL0xFM3M5VDhoV0xtMUloMVlB?=
 =?utf-8?B?cnZjTUIwZ2NOS1c0SlpGQnlqczgzS1gwMlpPaHlGd09xdmkyYW9GUUpJMi9y?=
 =?utf-8?B?a04vZko0ZmRkbXVPVmVRYmNNU1JxeEYxRm9MWncvdmtTd2dIUHJnMkUxRFIy?=
 =?utf-8?B?TTlQYjNPRm1tTUpBLzdpYnZZK1gzUE9kMlNKVG4vampUd0RoL1Y1NXg5bjlr?=
 =?utf-8?B?ZlZoK21tZ1l6cStQS29pS0hxTUNaMWwrRmxOcUkyYjBSY0EzclRrU3hVQ3BT?=
 =?utf-8?B?M2Qzb1RzMC96SEdvWEp0eFltd2l1VWl5UXRyNE82UFlXdi9rS3UwbGxIRCtx?=
 =?utf-8?B?K053KzFVMjMrMDNXL2xRZWIyeVVPRGZoVFVQSytCK1QzYjhua0UvZU5tcDhq?=
 =?utf-8?B?R2FWdzJSaHZyYVloeEg1UmZkOW5laHc5SmRUTHRNY3FoS0d3MGlkZTFEdkpM?=
 =?utf-8?B?OU1Ma3hMVWFmRTMxRFpRaVpIRFdqL05DQy83VE8wVFk3MXdjYk91RG0yb3ly?=
 =?utf-8?B?clBEeGQ3M0g2cVVsZktWMmt4eGdNTWRmSXhzTjZ2Vk9QOGRKQ215b3lrQ3JD?=
 =?utf-8?B?Vk9SbUNKVVErcjFpTVpOM0o4VHh4RXJkemxtc1FPN1k5b2h6dGE0WlUvemRp?=
 =?utf-8?B?THNsNitKZ3ZaVkRGNGJXSkxLUGdRTVpPdDA4V1dkQ3lvWE5KaGhEMk5CcHZJ?=
 =?utf-8?B?aTBCNHJLc1IyU2Z4YkE2N0c3d2hpWU5HK0QvbzIzbUxmQXpEN3k3dlZtSUM2?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UENodk1wRUZDQjBTajRreGl4TFYrMDg1WElVNkRpL0tLdlFQUTVzc1E5cWVG?=
 =?utf-8?B?MDNqUmM1enR2VHo0SlVhY2NkdTV2V0JGdVAwOUlZemZmL3loZ0djOHRDOFV0?=
 =?utf-8?B?YVRNeHNwSmthTWNjLzFzTjBTOWxYYUliQjVTLzhNZVZXMzBrMXptNUExZWtm?=
 =?utf-8?B?THpuL0dQUmhGVWZ1anJ3ZTVIMmQvblloVjRveW5CZkRmSFliTUFZcVYvajRs?=
 =?utf-8?B?OXlMS0o1WnBwc0JjSzI1Z3VxZkNmejl6Y2JsZmZid2pJS2Fpc0tDdDMvVmNZ?=
 =?utf-8?B?b3M2N0NuSno2ZFk1UFZETlRua3R1L3VMREt0NTlSV1ZXaFhoUEVmR0gxTWpm?=
 =?utf-8?B?V2RnQk02SEtLdUwzenlabGRyZ3pkZWdGNU9aMWRMSzUra2dEbGlVU29LTmdM?=
 =?utf-8?B?cnNSbFh4Nlp4V0pYVkFmYVVQRGloT3Y5TElZK05oWU9ZZkp0MmhuYWlBRGdj?=
 =?utf-8?B?dHZleU9RS1dEU0ZrcmJ1WVE4WGFzMTNoakc2MjhBTkNBb2E1MU9oQ0JHR0RQ?=
 =?utf-8?B?WjE1QmE5OE5DUmpDN0dXdHFhSEdzUUJpb1dhNzlsQ1FYU1A5RFM0bVlHNk15?=
 =?utf-8?B?WFdsWHgvU3kxUUhSMGRhancxUld3eEJoNWdwSzFRVExyZFlmR1ZGWUdlNXBm?=
 =?utf-8?B?VXdmSHMrR3p6bmo5UFc4U2RTbklZdmFJd1A0b01YT3ZIbUFFQ0hLZjEwTDJR?=
 =?utf-8?B?Y2xHK2JyTWdVYXphSHZNY0tRMEU5a3RyS1BsWXhtKzJPOXlZbTJQTHFyTFYv?=
 =?utf-8?B?ck5BMi91R3Byak9UN010NzQ2QWFyeXVDdm96M0dRZUJOSUp3c01xQ09LV0hG?=
 =?utf-8?B?M0h2MlBPU25lQUlDZWhTeHY5SzZhTVNkSzBQNFhnU3NkOHlqSUtQaFZWNTNU?=
 =?utf-8?B?R0I3YVkzUXQ5R0xvcjlUSXlkTE0rZUZYK3puRXNJL0YyTWlpUTFXTWdJTlBL?=
 =?utf-8?B?Y3RoSldnaWpvMHkra2oyVjd2cVExaHJCdCt5KzFLZnNmMVB1QmlORmE1V1di?=
 =?utf-8?B?TnF2d2w4TlRmQ0xIWWdOMytzTlpobWVhQnRjeGwxK0NtbkxSSEZNZ01Sa25p?=
 =?utf-8?B?VENUMVZJWHE0R2dMQUZNUERsSjRsTFc2ZlQxbHJJYWx0OC9xZ3EvRjRYdDdL?=
 =?utf-8?B?dm94bHc5YmY1d1pYY3R3bG5JL3Z4clZoYjNaTE9QWi9QcnQrNGczMEtJbnBO?=
 =?utf-8?B?MUVGaGJmNlpwK0ZyUnB3N1dlMmdJNHkzbUJ4ekdBQ3laenBuVlg3YXdvNlQy?=
 =?utf-8?B?b0lyZXdCZkVTL05VSkEwd1hNTVBKVzlvL1RVL3hCLzFxNlMwZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa5b179-a647-419a-103b-08db9d638018
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 07:44:48.1369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yF9sG3tBJVQ0YyrGNwESSyXlaSWDLPpTlLq8ByCKvzlThCo1Lz7iB7oxlVOadTgStiTeN/QneuNs1wHddUzGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4477
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_07,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308150069
X-Proofpoint-ORIG-GUID: WQ1GB19tp79sHkoR8l6Rg1uyOaTKnqPV
X-Proofpoint-GUID: WQ1GB19tp79sHkoR8l6Rg1uyOaTKnqPV
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 03:17, Damien Le Moal wrote:
>> --- a/drivers/scsi/isci/request.c
>> +++ b/drivers/scsi/isci/request.c
>> @@ -180,7 +180,6 @@ static void sci_io_request_build_ssp_command_iu(struct isci_request *ireq)
>>   	cmd_iu->_r_a = 0;
>>   	cmd_iu->_r_b = 0;
>>   	cmd_iu->en_fburst = 0; /* unsupported */
>> -	cmd_iu->task_prio = task->ssp_task.task_prio;
> Shouldn't this be replaced with:
> 	
> 	cmd_iu->task_prio = 0;
> 
> ? (note sure how cmd_iu is being initialized, but given that the other fields
> around this code are assigned 0, I would guess this one needs that as well...)
> 

Yeah, I think that you are right - I'll fix that up. Thanks for checking 
very carefully.

John


