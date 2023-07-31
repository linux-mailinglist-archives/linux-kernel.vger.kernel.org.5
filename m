Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCCF769752
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjGaNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjGaNRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:17:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B161704;
        Mon, 31 Jul 2023 06:16:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VBtdcT003612;
        Mon, 31 Jul 2023 13:16:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BSPDvU5BiHSOUk9phv15ZNyd822Bw9sIM9aRmyTryaE=;
 b=F8Jmtv4I3EtOOgoPpoLsiWAZcNZBKK8ch7n9VjHjimQnl2qRaUp4XGVO6xBcdBzszl2F
 3UPD7vrgmrf0qJHnp6LTSzP3rMovpVA0RL1NToJ350+Vs+jk7Ve6duKAJyyrFXVs1b+z
 IOQKEtvAk1IWEkrhj0LxUw73N9aJ2Zm/nHOIHpvIGd+sOORqdHgzrzWN2HfizqDuaIar
 6j7bmbGY6TabubvdN0QcQeMReyw7S0PUFtyXnw9wmfbMtoizrbUO1YYDEQxhp7MIP6Md
 4bjvytf+XKO6DpzjSj6hg5gDdMiP7E9XIcPOcM1H0n/2xZMDuiK49Lv8Lsa914l9XvxI Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc2jaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:16:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VBK34u013675;
        Mon, 31 Jul 2023 13:16:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74t2xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 13:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAB1p812hbsVT/iSqA7hXEbWB6Ir8N8RQzTQ/9O9fDDo0UhJbpAzNnsq/QFLnZj62YIwti6zqvRVnotgdSAcsd1+PV9oUh5zAdqcg72W5/t9bkmKDCe1XgI2o5eWUQdTFwyWHY7CdnGfblvFwyRcOkMJuqGfpvGckX3Nncjh2O4929dNm5OKR0QbXZFLqpKJz2+mdC37TjVZMvGTjc8aWw8L8uaCvsKlogxNOQZN8q3ga50kKifohlqpVzfJK31dGK+Ktx+e/x2SUu7lbs6lQLw9GzJ2HZy0bk9L/FO21E8638eNSDi+cYQZPuEcDm95xe0iTrcRF3Z8f+Lqx2vIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSPDvU5BiHSOUk9phv15ZNyd822Bw9sIM9aRmyTryaE=;
 b=l5j9wsUiDG8TVRCE8JctvG4ILML0DYH7j23wtOjeGbvDAbwTgvj6YNC+FvzGeu4ZgkiGCU3KH5V3RvOXti/NwbZLw0XU6ickWX6938xNiEHl0V23GSGOgFxGN+IDst8IhNcCWwhc2Vi1mfTzZgjU4fk6iIhGmjLSg9ktnLWfNvHkVZLiejlWoWM6t3NZoViKnSXpNhLsRtEAYRSLLFQ0jYT9O1GABhNn2OfpSJAR8rOXKigHPl3r5xOzmcvn6IVcprTPXZf3ocOSK2rSC0YdaitkK0kg2qCB1nsyK+1K/VYsJgM6By3saktukm6js7zWfI2ZeRXcoAFs9Ts2udj0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSPDvU5BiHSOUk9phv15ZNyd822Bw9sIM9aRmyTryaE=;
 b=H5Um2K01wBSQjH0gMoEtpoHkO2pZQBTwnYhTn89kqabqYicB6lOkHoHveLNLVc9K9HYL+psk4bm0truf6/iOvc8I782ffdUu9beT/R/rGZ8udw0tsFBjP5RyQv3/L8StlEAxWNHJqzbO3dp8KmV8tkGNXMl0NQLN0X8yDOlXAq4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB5915.namprd10.prod.outlook.com (2603:10b6:930:2d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 13:16:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 13:16:39 +0000
Message-ID: <6dbb6b3f-1a7d-f378-ac46-e045b165f33c@oracle.com>
Date:   Mon, 31 Jul 2023 14:16:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] perf metric: Event "Compat" value supports
 matching multiple identifiers
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
 <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
 <0801b73c-6649-8c54-8dca-276efc2a4967@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0801b73c-6649-8c54-8dca-276efc2a4967@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0039.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 8523ba55-0ebd-4e7a-702e-08db91c8602e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8k14Jp/UN6IE/IsmcN+tinyIuGSD/534a6+j2EX8Y7W0SlYZhPcpt2sAfGaAW6MsZJSptpykLtZ3h5mHCEM/WLf0mW5l3Q7irtdVCQY6CG6qH/IKZjCARPwGoCRjNQZPnk+zrTv8KaEhCrJgP9/CsPLfv5KNwCcMoK9VecKKbNiqSxyIILz6SysZ+vTAry2G3X8XS0giZH2sdOEUJpbXGL8W1S/rldpUQw/uJlI+KmKZhPSFGKBdx0Z8+Jjph4sHeOiCvjN//cMLgLIkf0CZl6iQRQu+t550syi6/0hCs89kn14crDVytVTl3ybe5P5wK6YUTQJ40qisZjeQz9XmHAOccXpzwNUfffRQtWFPI8ft6t30UGA3Lq3OwhU8scF44TWRcMZ/YWIBNP08gDABBqGB+LzadvAItOdYi84yhVSkjfQZ1molVoGwWP+bPjiyCH3COMSuEE9MY9bmyCP9m5tTJGZak75hobF6huMmbq5uT5589KmR5veVrBL+yZjw58XfP5juyQksrVC+bMz6TVgf+8oqZj8hIavPwsOECJPEteWOyxZdgS6S7Rzi7yD+qgr5rlHjB36RaehQiVFrBqd6mmNLDsrCUKJyzP1EPQG9piZRz2EmHSnm8xZZZD44WVllZso5+v/8v4L/1gJYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(6666004)(478600001)(36916002)(6486002)(2616005)(186003)(53546011)(26005)(8936002)(6506007)(8676002)(7416002)(5660300002)(66556008)(66476007)(66946007)(54906003)(110136005)(31686004)(2906002)(41300700001)(4326008)(4744005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1piZUtHeHRjRkE4emtTOXN5RVhYOTFOckJUSHYrSmduYTZoYnpiRTdLOG1Y?=
 =?utf-8?B?RWRidUt5UG0xeXcyTnYzSS9aY2FpajlhbkppelV5dEVuWjVIb1AzSnVyV0Ri?=
 =?utf-8?B?U3pSL3d3MXhyclByL29XS1I3ZW4vcjZxcU9TMUVzb0dMZndiV2hpbHE0WEpR?=
 =?utf-8?B?eEM5YzBTdzlpNHRpeUZMNW1WRjN2NkxWdlJiaU85TWhnRyt3eEl0STduMmlC?=
 =?utf-8?B?M1lsZ0pGeTNyd3VWODFJQUNJTzQ2eDAwMllOdFRnbjRQbyt0TXppR0NQUkR0?=
 =?utf-8?B?TzVqV1V0T3J0M0xwRkJIWXBGMTFhRkpqTytESHgxOXJCbHgreGFOcTF2OVFw?=
 =?utf-8?B?V3FMNW1oWEorRW9FQlU0RHVKaFY4eTBDaEE4N2tqNGJoTUlPVnlQMFJHTm5x?=
 =?utf-8?B?SktJYzY4SmltTXdFU1RsdWFORWxUUFVjdDlHeWdHdkxueU1TcmFjWnRMaVB2?=
 =?utf-8?B?VFVLTCtSakpkcEliOFVmSWJIWDJSUCtZdEJpWUVoRjZhL1g2TEpreW44ZG0r?=
 =?utf-8?B?MGpuZDdzanBRTmdNMWR3WkRxdlJrQU16b1hIVkVGRHluMFdkblQ1VDdLVGoz?=
 =?utf-8?B?Z2IzcGFSWFhjUExodGwrZGVUcXQ1eVNmdS9zL2Nvdm5WakJ4Tm4zK0hPOEp3?=
 =?utf-8?B?c0RGT2pXVDdHRlRnVVJKVjkzd0daWURVOU8xQkNOcG5ramg0YlQ4K0RlWFBT?=
 =?utf-8?B?cGZNTzJYTUJMREtGTDJ5ZzduUHdVY1JIblJndFM2VFhLRlVGQWlNc0M5bXVW?=
 =?utf-8?B?QzBzUGZjT2lpK3lOdEhGM3Fyb0IvaHpYS2dGVHltK3FSTlkwOThNY01JcU9i?=
 =?utf-8?B?ZUZmSTNPRFFQTUdHUXFrS0wrNlJkeEZKcGM0NXl6S09pSnRJNzZvMU1ZRHh3?=
 =?utf-8?B?R2dMT2c1UXc1b2Z6TGhGYlVQVTVSRFY0OUNackN6aHB4SHA2RERaSDZQMTAz?=
 =?utf-8?B?UTQrMVhRWmtPMTRSSkdtZlh0Z1dob09yZGZQZVgxTDVsUVAwZ3JINSt3b0R1?=
 =?utf-8?B?NGJkNlNONExMVlZ4eVNFV3N5YlgyMTB5eGI0anA0THNwRU0zalY2cU03TnpB?=
 =?utf-8?B?N1JQWFBpaUIxdEFkcENJeHoyUDNjUEZENkpTb0NZMDdsZ1AxYjNQbUoxRXp4?=
 =?utf-8?B?N2ZCQUtMNmZsN2RLa1o0YmJLN1ZJSkU5Nk5uUHF1V21XOUNxUGFMMXJnR2I1?=
 =?utf-8?B?Q1FDY08rVEJQWnVoOEtVYTZINVdCZndGc1dLOXo5VE0wMENBa0tNVTNwc09q?=
 =?utf-8?B?aXczNnRCQ0lIZHVWTHlSZEx5RXdGZ1NyVXlCV3MwWUtieFdDaEdGd0lDSUdt?=
 =?utf-8?B?M0djdUlTOERmWTN3RzRDVktac3FFalhwV1FwTndMenBHa3cwVWsxUjdMMExM?=
 =?utf-8?B?MHhtWWN5aG1nNmJ6R0ZMdUNVVWkwNjdqUnFLeVhMZFc2YnJUU3Y2dzdLRDZi?=
 =?utf-8?B?K0hUWDA2M3VhL2lvZXRqeEhxbmZxMFNHZHNCZmZjY3NuTWZ6Z0hpZjlPbW5r?=
 =?utf-8?B?ODg0VGZ1Qm9NdDFjN2VpNHJFa2NEM3JQZWpoTlg0YkRpQmN4blFSbVNOR2dp?=
 =?utf-8?B?ZncyQVA4bnNBaVJTQ0FSTWV6bU4vSUdXTFF3UWltaXo0RC9LRWJDOWlCS3NP?=
 =?utf-8?B?VlVoZ2wzVzBrcERoQXl3VlE4UUxuWmhNeUxGNFRXYUtOR1VBaUJqOTM4bEVS?=
 =?utf-8?B?VTBGVWpkeUV6d2FuSThnMlVSZThRbHRpRWxTanF2Qkg2bHNTV0xtSGM4WUJI?=
 =?utf-8?B?YUx2YzhSNUpRbGhwZUJIdnBCbzRTOW1kdE5wdis5K28rOHltdDErd3c1RTk4?=
 =?utf-8?B?a1RWdi9XWExvNmtjbkxQakdwMm5weHBaR2svR3hHMFoydGhGWkJYVGd2amd2?=
 =?utf-8?B?dXE3cEoxK0tLRXhrMWFWRVFkTjdjTC9tLzkxdks5dS95QXBiWGhrbHlwNXNP?=
 =?utf-8?B?ckNjZDhUU3ZnTjF3ZjFsYzUxTkJZLy9OMGlZc3pXWEhVd21iREdPbVZDY2lP?=
 =?utf-8?B?WEJBNWVTdEk5cXp3UlBWZmF4eURULzIzTHhvKzZjYjNvNU5wWnV2OWlpbVRF?=
 =?utf-8?B?T0QvWVVzZTZYcE1jeWY3MStuU0w4UGsvaE8wcHg5SC9RYTBQOGp2c0dQZ2Y4?=
 =?utf-8?Q?P3OBie9V3vts8N+QHBF/aPD83?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MW5za3Jxb3lLVHhweUkydlk5L3N2MDJpTjRUdURPeHRkc1FrTUFFdWxXL3Fy?=
 =?utf-8?B?YW9JK1dBUEdUVitwNzlaSHpDUDBXRllHUHc1dWx2UVhyQkpzaXh3MkhNenNO?=
 =?utf-8?B?K1luUDNydzJTVlUwZVhWNzBnMjVyMlZtK0EvZjdVUkx3TDk1WjJVNmdHQWVs?=
 =?utf-8?B?ZFdlUTJmL1BERnc3cHRjVUk1ZGV3Vkg5Nk5NQWlXeXV0M29BbmZNSE42VlAr?=
 =?utf-8?B?YndEN0MxTUZNTVliKzBFbjJlMGx1c2lIR0VlNmpKd1RKVzJyeUU5TnE3TjRO?=
 =?utf-8?B?eTlyd1Y0NjF3YktoWXZQSlR5RHpOY0RWQmdpVnNkSlhqWU4rRDNnNTVPMzZz?=
 =?utf-8?B?cW9ML01MdUdNYllPbTRQZ21taEN6WVRCY1o1ZVp0U2lJd25vSmlUMVg3ZGE4?=
 =?utf-8?B?YmVXOTYwVEhoMUo5cU5MUzlGODVTMzlJTUJvYkRKM21jTFRhUFRVanlFbDRO?=
 =?utf-8?B?bDdDOWs3U1UrNTBmU0JJbHUyNUNxNStTanFOQU9jSTVha1o2bXd2azloVXVX?=
 =?utf-8?B?cEh5VXFKZ1daSWwwSi9WUTlaaXA2NFlLWFFMdE1vSmlxMnB5UGd5b2U1Rkwx?=
 =?utf-8?B?S3NnSjhOdmIvclB2NVJEM2ZueEc0TnJud1NGdG4wWFNRbGx2ZWRXVHFhYkxU?=
 =?utf-8?B?UnpJSTQrMmV3eEpsZFFrQ25BSFJmMGNOdVhWYitDWDN2RzM0RWtKZ0QwdkJ1?=
 =?utf-8?B?WUQvd09naWUxcWJWTVNRL0orREVxWnhtd1oxc3RTdlVPRkQrY0RJakdmb2NN?=
 =?utf-8?B?MHY1OCswRExhN0dORUsrVCs4MG84RjZrWnM0TGNSM2RabGNoKzRlWlpuODFo?=
 =?utf-8?B?UkI3c0FOdzVuYmFtMmZrZ3h0dC9qRmUrNHhKQXROUDhCbmVlbHFjYzF5RHNF?=
 =?utf-8?B?a1gwaWlMMVg2U05iSGlEZTc4Y0ZhM3NYUG5rR1p5UU95NXdISFFidXErb2tk?=
 =?utf-8?B?NlF0UkgvRTRDYmxkWUxydHczbnVWZTBUbEE0WEZuK3FiVFlrWFVYNG81MXJo?=
 =?utf-8?B?Q0JTRkhiT0RYM0VEd2I2eXY3SjBDZ1lJZ2lVWDFvaVlYZFpBRmRzTFgrVEVi?=
 =?utf-8?B?TzFxVWtraFRreU9RZ0NCWWtCemVUNDlZVHRraGlSM3BDTkh3QmszRThNT05D?=
 =?utf-8?B?RW51Yll0NmdITnR2M3JzVUZROHpFYmtaUit6MGJvN09mK1MwQjFmVWdvcHRm?=
 =?utf-8?B?YU1GT2lsWmY2YXpFSnM5dEljVlJLNC82VFdWVEhRRkhXK2krSEpoM1gvTk4z?=
 =?utf-8?B?dEpzVUJZNEdKUHc4eW9kS3ZtZ2dVSk9IZmxBOGhDcitsdUcwWHN4dkRPK2h3?=
 =?utf-8?Q?D5S8l65q33kO8B6u0t3PmQuBgqRql7Xm3b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8523ba55-0ebd-4e7a-702e-08db91c8602e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 13:16:39.8526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRv1juL+1DFAAl2sWcVimU1GscWDzAWOyLrAGvLZgQjKjAlKKolbqW80YL9A+Q1lUl72yRpZ1iuCfZAsmoXZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5915
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_06,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310119
X-Proofpoint-ORIG-GUID: aQT-zrSPedoAuSimfWDsMhMV-0ec7RBE
X-Proofpoint-GUID: aQT-zrSPedoAuSimfWDsMhMV-0ec7RBE
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/2023 11:59, Jing Zhang wrote:
>> why not use a comma-separated list? that is more common
>>
> Hi John,
> 
> I use a semicolon instead of a comma because I want to distinguish it from the function
> of the comma in "Unit" and avoid confusion between the use of commas in "Unit" and "Compat".
> Because in “Compat”, the semicolon means "or". So I think semicolons are more appropriate,
> what do you think?
> 

I suppose semicolon is ok in this case.

Thanks,
John
