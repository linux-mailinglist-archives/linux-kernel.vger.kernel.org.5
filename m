Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987138033FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbjLDNJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbjLDNI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:08:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F891AA;
        Mon,  4 Dec 2023 05:08:56 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Ceeni013446;
        Mon, 4 Dec 2023 13:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+zHeXRPXohfE7BNhU/LhosxNsATUd5h+CKnNWfNo80Q=;
 b=FhJyRJ1ATz1/xfot154Q6HRvdDDG8c4BdmtOYzzSamlAtgGtH5KqDQAw7mrF/HY76/sE
 M9jW9jmDxnrYLFuokLcNwF3Xuhz2zIs6EyFYUhbc1GhpQ6NUArWA550604lqf/ggqhYk
 95B+vAmQklKDc8VEmsBwakMMOHj1wTSQAGa4pRENoDLGybWK15K7m+uvDCqcEFI0HkS0
 CsG6ZGUVrzf1mjuVSAINChwGU6iocqfFAnVZ5CjijPOaou7D5hNKxAuiJmzjyp5omTvS
 R6NAlQEsrTtt7reJmxq6/ljf5ewa+3HlaSF+fUIlz382MCoHuG2WDP1sudbIq2TxRlwu mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usdhq09yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:08:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4CsZuh005185;
        Mon, 4 Dec 2023 13:08:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu15hwnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 13:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV1T/qFYfrY6oKChPFzQkWUC4OwXQiuPvyBkZtTU3FKsBEPA+Q8L+t/97mnMMEd6huE9ab33IT++ehrosAZXeIIAXq4pcvoSl9BGHxzw/N1sNEnw4RDJmqz3eEmodpK3SAmShypne33X5IYyaKM8QYqz1IvDHESGIg/7/Kp7RQE0Xal5M4+0JsSH4BVKvkDUtTokqcpejSX8d7bmrXC0AbUviYclKkbg99zOHQRbsRPV8qpLIVkmSHklvll8k6RyUluWQmj6foQOX5siPscDcVW3FmqbGDWlVApZiJ9n7D+LSmtICTqysRgw9ZZeZeVpQglus1kafEjbS/FSoyvm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zHeXRPXohfE7BNhU/LhosxNsATUd5h+CKnNWfNo80Q=;
 b=EI8Zlvo5C92fypIL31NGFjgqShBeZd2g08eENnmAPtmVVJC5ttPTgA0rjBYnswBFOD78oCLqh22HuMznTFrLYdtCef+SaGkpig3rrYEHYMbDgCl5EH3RiQTrf3yJwKkbS6ahD04vhfPzPNDklFDe+EMHJOuCxRvmtVMH6DA1HECZ8o5+RaISwE1eut6dA7vYpBX/SSx9tKuVWzonndbe5GLx8QNrvH5XE1r+zBje9I2dKlEPXfm6fqZOu2YJLldWjqz2xYsmPAR5BHQXHwQusWXrZfrwvm5MQjHpjRgOZSTtDzYup1vdoSzBtw02rfdaxEOwkxH08TVpCzXMzuu8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zHeXRPXohfE7BNhU/LhosxNsATUd5h+CKnNWfNo80Q=;
 b=FhiUXEgK10s1zTZ4pm4YlcKtuszLt+49rqwh+nMiGDq1JSiu6R8ybD98ut/SZHA8BWKac24TNgTolKJbEysEMZJN0YyRbhbCS1P9mxLX6DMzgDEtwHLOlsTfFJEZbuT+Nz5QUR+pT/7/sNbG9e+BR1U/yNFbiuDfeHitDic896A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 13:08:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 13:08:31 +0000
Message-ID: <e04e9a14-e916-4144-b497-c31497e51a5e@oracle.com>
Date:   Mon, 4 Dec 2023 13:08:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] scsi: libsas: Add helper for port add ex_phy
Content-Language: en-US
To:     Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20231204122932.55741-1-yangxingui@huawei.com>
 <20231204122932.55741-2-yangxingui@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204122932.55741-2-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN4PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 42921b8f-bd9c-46f9-1676-08dbf4ca1d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSvv6m37n/zhlBlz72ti6cCyp8Z4Ap9sOVHda9AaUCbEdzJB44ksj1wADwzi1pwVk/S8RbQNccqUd0OQSMupL7teI8ICKsWxADWzOQKcGGWRcVdw933M/WpTT1xXDyWUchoEw9GZ+VDZiyDRHEfVYL+mZRHJ6delPTwXL6p/3xrQCmNkmQ7Ulhqf5tpKKgr27sNShqNoqq64a5QQV6EzNqQOh8nGzXQokMDqdKKezK1eMkluZUBXK7n9Vkid1ijCLmvjd2OrUqLJexjSWgdv1ixZfl4lWWEUlbDkrnwiX789XBWS4OCIOg0fkPY4cx9bxfV5iG64GyXPs0FNuDZzNvQPk/ttVxX8JULrrmEagosVmEQilawx91yAqLCfwvhfKe2ru0PGuDX5LtjvwnorZh2VHVhyt90sSuRMc/E0gjaaSBZNMicreOpGumEsm2RyR9J25lVnP9pdCHXivNl8NOsT3a2U9SeyCPUkwURHBygDAtMAh7aNplmr0eMAI/vj3iy2LgjmEKdo/n+vRENSfVR3AHmwfJVeu6/3WR/yhDH7wreK6oyhc7OuqFFcaBJfo0dhOzxUrVwVmM+j4YahY2TCWWtUDKlPgclgyBgOKa0MrZyWnySAR3Iqr3bcjn9U8rSclkqiiAk6xiJDYsS6cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(36916002)(6486002)(478600001)(6666004)(6506007)(26005)(6512007)(53546011)(2616005)(4326008)(316002)(8936002)(8676002)(66556008)(66946007)(66476007)(38100700002)(31686004)(5660300002)(558084003)(7416002)(2906002)(41300700001)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmpPQzNUaHo0UElkRDMzYnZUUE5jbEFybDVWdk1nZnpFV2hCU2puMkhrdmZR?=
 =?utf-8?B?MlBhSnNZME14NU42TDZjODhGNFdZTXp5OUk3WWtDSDQrUWJGMUhBT0Q4MkRu?=
 =?utf-8?B?aWErRTJRMGdzVkVIZVVLRGlPNkxpR2I2aXdOT2hyOTBIT1l2WUJXcUMrdCtK?=
 =?utf-8?B?NS8zbjNybWhWYmFFdzB3VlBtMXFXcnJZS1ZJQkR6STRoUmU4bzNRZzVhS2xB?=
 =?utf-8?B?V25vSVJjQkVUaHo4WUNVbGJvRFBoUFlHZzYxOGdMNm1nbllaNmFGTndQTG53?=
 =?utf-8?B?RVhwaE1vdHM3YjVNamt3dDZRTnYxbVZmQ1FSZUFoSWtkYnlqTjhRUi8yRzF1?=
 =?utf-8?B?NXdQeHM1TjNtQkhZNTBGSkM4cTNDb0syTENYYURNQmY2dUxmQ3o1UkswSS9M?=
 =?utf-8?B?ZnA4RWh5eDNXaXN1S2lKaFpIY0VDY1YxKzVtWlNEQzR4TUNtTnlEUHhMVjNk?=
 =?utf-8?B?OWh4eDlrKzluMTZIdTUwL25saFgzb0QrWVp2amt2TEs3YXQrT3dvQzI5L1d5?=
 =?utf-8?B?djFZRUtoSzFmWHNNNkloOU9Pc3puT3BzN1FZZnBPcEgyb3V0RTVkOHpvRWV1?=
 =?utf-8?B?Q2xyTWNSMVhvaTlYR0NsSGJwcGJ2Y3dCRXlQMlgrdk4xOTRHSHFEUWF6NzV5?=
 =?utf-8?B?TnkwMjdiNWp1Y2d1RmhXdjlqdjBybUlnQ2J0Q2ZtSEFnZXgzZlRPeDVwbjM4?=
 =?utf-8?B?WDViV2MwYWxPUlJPbUFkekE1RUtGc05mbnk5RGsyTVlJQ0pOdjVSdmErMHVm?=
 =?utf-8?B?eUo5ZXh4RmU5cWNKQjZkYWduTkJHYzN6TS9YZDB5SjV3Wm4rSEJVSm1mMkJR?=
 =?utf-8?B?em9NZXNLZS95ZDVSL1R0R2VFd3hwYlNPOVNKVjZPL2VmN2l4ayttWFZoWmND?=
 =?utf-8?B?YVcrZXNyd2dnNDlIdnQ3ajl4cTI2UisrcGFWcGR2azFqQ21jb0NITEoxVFVD?=
 =?utf-8?B?eU9nbnl6dGQvVXNYNFN1MkxZMTlZVVprbm0wbk51UkY2d1dNVzFYU01BUUpM?=
 =?utf-8?B?UHVWVWU0VmdjZ3kzazVPZ3dVR04zYnZZUDBaNkF3YTc5N0o2V2xUbHkrYklm?=
 =?utf-8?B?VmJMZ282Wld2Z0lHN05qU0xLZDVaY3AwTVhVYm1lcExlTzZxdE9QS05mNFNp?=
 =?utf-8?B?aXo0clRlSWtQZkF5aGxhZ3pPNVVMVGF6amR4ZWVYT0tNU3N6VW5VU3JGT0Va?=
 =?utf-8?B?V1MrSHFTYkU0eTllKzVseDhETW1sZGM5empxSW1yWERmbkRRQzhaVlhZV1Ev?=
 =?utf-8?B?WStPS0VDNDdpVk1NZkV3SjFqRFFPVWtvbDQzVVRtUXY1eXU2Uy9pMUpiTmtI?=
 =?utf-8?B?MVRYWVczVC95V1FER0VpSlVBQThCMkExRGhYQ1g4aWgwRVYvTlA5K3QvRllB?=
 =?utf-8?B?TE9FSXpwczJ4aktmZUZEajNBY3lpOHBSRXV2a1lMSG55QnFmR05sUXBxZ1J2?=
 =?utf-8?B?eHAzZm1UV3JIKzRYYUJWeDhmUWxXQ251NmtTd3hRbWF0a0VpL09SbU5MUUxy?=
 =?utf-8?B?LzRwZVB4Nk14dlY4NTBZNWpyKzV1dEUwT2E4dWxTWi83TFhhTWI1b3RwRHRE?=
 =?utf-8?B?OUtEUTNaM0xCR1hjYm9KYXUxMWVlakxaSUtNV2xEOXlUM09za1V1Skt2STRK?=
 =?utf-8?B?cDBQM1l1YTM3QzFNTXdMdEltQm1SRktoNG9lLzlPdU1CTk1ubXFjV3ZyNHB6?=
 =?utf-8?B?dlRVTFAzcjNXYWd2K2hZTXE0K0lqWjhNOU94czM1c0Z1UHJwZHVVNjc4NUE1?=
 =?utf-8?B?WDRYRHBET0JKWlkwY1k5c1RKaFlWckVmRnd6U0ZaTXVOZWIyVmJXWERFYkNK?=
 =?utf-8?B?aGpNZk1peC80aXhPV1pCNmFGcVpnRi84M05MOHg1ZTZMcE1kR1ZqSVcwU0d4?=
 =?utf-8?B?eERMNTVEdzg4SWNYd3dpaHNwcVNRMEtSbTNGdmpOOHpXaWU0YjUvaHl0STdo?=
 =?utf-8?B?dlpjSU5DV21KOHIzUUFZWk0rQ0VwRFd2ODd2M0hLMWVpM1hMRFBKTGtNUmNW?=
 =?utf-8?B?eURVcG1keWRkYm5yZlBuS1R6dUJ5V1J4UXd1UytEcVlodEFIRGRWT3VISXEw?=
 =?utf-8?B?MDJuUDhFQ2RjYkFNdnZ6QnFwOEIyNHJkTkFqMVRON0hXMlR3L0RPdjVnT3NU?=
 =?utf-8?Q?AvrXg8X+JUYLD/dopmEv/fSQR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6K6lJxB3XsynawGw1Q7W6wTWQpWgxWZYtQhWDyE/Km5Oo/OMDFT0fx1EUy85QM5K/bI1yXgmBy81krhs0HpleKcYXzG/QXqMMGr3LP02xZfTsLi38/NACNDW8sBT4mOvvzseqQ+1ndki+K/H25wU+o1X4LEiYEErqodEstF+BjycnZFAdWLnUpKFRAjLH28PwFRbMKFMaayCOlZbJ1Wh7PMZqWwOFlkMkPIM2HkDyvE48QkOZDsyYXXMxkVUNL1HyAx7iuegy0V+08bkI0y9aI6OrlqJguvrnquYm5xCddiA+p97FXwX2p8AnJXst2eYxrGbsXseGllFyvHodbNHaZxCpCa5/s3yznOG8TMxXGktHyp5E2Ha3dvdbd4XoMbayX1ozYXaEFFeiAVGJwKpIVci3VIqVGbSn0iK9uVCYOiRo0z0h8iuSMcIBVknIFyHCi2EAwJCcD0OLwo10MZsAqE9KU05ZH9KlawxKMBkbm9dtujwN7aDnRoh3J1IwVzZPAcmFjr0gVEuPi3/Wx4v276tIFopcAud+LlE6kQ728THy7TmHcSUffGu8jVpnPGmI1n+3qyGBqYtx6rdqDnFj7K6KK04hMM8D4ks+ZULL7F/oarPLkmqCYNJLxywAvxMNjpe/wovD0w0hO4H3ir0SRIoDgtwhBu2bI0/XLVRAE6Wfx+mHWyoOgDqpEj+6WgUrfsvuS4YrwUhnDCSqC4sNXKCRuClYTm7JdMvYkBA2TWuQtuYt7nW6BEYeKZgtnyEcFkYQveyZTPYtcjJta9qtNzo8bxDGuRYjFSdcETF3oM/GN7Q+ZLlOiUd4zYjlFFLuzVzRRVPyRjPG82hLbiGgrQglWWmoIPhQ+gupId2f29GMhR2C/sxuSjmOH/P3ESSg6O5IG3wpYegz6d1/Jk9z5uszb4DfLl9WjizwMqD1lg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42921b8f-bd9c-46f9-1676-08dbf4ca1d06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 13:08:31.3504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPw119NHHF+OA36Te6xkOy+mJVl0QTtJYdM7Zlo4JlfL8ZwuZEYxoNpvjQBExkXrmcWlET0T2JUOhzkwbUHkyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_11,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=995 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040098
X-Proofpoint-ORIG-GUID: MDq19NmO4ACjKCG-WQNpliNImNa_s0D9
X-Proofpoint-GUID: MDq19NmO4ACjKCG-WQNpliNImNa_s0D9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 12:29, Xingui Yang wrote:
> This moves the process of adding ex_phy to a port into a new helper.
> 
> Signed-off-by: Xingui Yang<yangxingui@huawei.com>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>
