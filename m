Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014FC7FAA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjK0T3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjK0T3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:29:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B5D5A;
        Mon, 27 Nov 2023 11:29:15 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARIEuSJ008471;
        Mon, 27 Nov 2023 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=GICNLm2+kZFL8rGE428pEI6fpxk0tYu+3qx6IWfwH3c=;
 b=cxt9X0Zh1jvm/76m7IBa9Avc8CTnlR5it3oeS+LDbNa7lvgSyOWWjO69sehfGVEZ5aac
 w13cmdLahFMHaP8dyZZXfdVSZRnKM4EgT5t07SFOlbsXjwwtzkd2N9Q/mMLLpF6d4sFk
 5MpT/7HduAj+5A+/Leeas6IMyFpZTofg0DdnMjhHrV+HNTmN8SkETMsSk2k6a2+fdGOB
 PgQXyOeaIH1ZGsBM018VBCW+n9sek3biuiOw1UId8XNhEEdaSn3E4ukuw+/03RFxuR3V
 xE505yoO3yq9osfZeu7fyKICUkcrbZsoUtiq30j4xRmh1c27/ItXdGhTS/W4SAfHLuOB dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7uckv69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 19:28:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ARJRGdJ002205;
        Mon, 27 Nov 2023 19:28:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cc09u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 19:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOrVW4kB+5wg4VWl030KQtcwA25rmPrkotvspm0KeM9FnuJBSdEnCN2cDp4Bsr+fQQxfOmQSas8lOjsX5omr9lbfuOr592+AtDqZMPfiKrq8+E3dE58LRIVqdOlL2A1I/k+0Virr4CN/0HCw1X9LS5UIfOMNrT/axdOrVysg48vPMTRsc2HYnE4cxE/inkehJ3a3VSKVPPOYVo70K5VA6IUaRDqduuSkQUT9HvoZXqPnCsLx6vEUiqoPQKeX5uBni+89ZA58eoenEr5pXywRcsIGMpFHui1XQ5gRY4hoco8KcYLsyftloofGiBeVVR6Wu3QXI3C0MBRLSk05CJWxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GICNLm2+kZFL8rGE428pEI6fpxk0tYu+3qx6IWfwH3c=;
 b=lCm04Yc+N+CU1JtiAOEeP6va+y8MI0gtieIJMq2X+OneurzujPqmc+mQYGEduxr6Y1C+dNIvbh2mGkYswQcun/mCv/46v8hMcUTcUS0A4NU1yR7CQAYQUsGnyJZg0JNtZUm+9fnQQXVX1dvNrksE5RT82NzItwdBhj9kKUj90BjG03K8stAPTUVPQvE1R8MT1pfB7uJA7CiEZJQZYcYWcf9uXUS6d79ZUCaIlMEqM3ihdzimjuHvMQcDHqkHHaVK2BLjZmCr43oNLWM24tFM9nxvV4Oqg3nZCazA4ckLk4pX6lp66gmRZwLZtMsodfPnA3pACGr2YSntFplDm37Lbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GICNLm2+kZFL8rGE428pEI6fpxk0tYu+3qx6IWfwH3c=;
 b=FeB3DM++/HFxUeaFmUZUZ9EkmNxVqKyuvvPMu0z1a0CCEsbEidDeGKkqv1iLxJN0ttGaOY6X7FgOn0WpOkSg1S/1N8yI/WcLU6cwMmVGZ2JSJeMmW/NoZ3Lq+ZHEwnbJ8mTr+vRK5DDBOO1L+mb1kgMAn9YD+mc0zxqaGV117xI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4444.namprd10.prod.outlook.com (2603:10b6:806:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 19:28:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 19:28:47 +0000
Message-ID: <a13f0419-c4ef-4b8b-9757-7cf7cea32458@oracle.com>
Date:   Mon, 27 Nov 2023 19:28:43 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
Content-Language: en-US
To:     yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231117090001.35840-1-yangxingui@huawei.com>
 <32c42e1e-0399-4af4-a5ed-6a257e300fe8@oracle.com>
 <307d251f-ff49-5d8f-1f8e-aed314256732@huawei.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <307d251f-ff49-5d8f-1f8e-aed314256732@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0139.eurprd04.prod.outlook.com
 (2603:10a6:208:55::44) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d092d3d-7f00-4416-fee4-08dbef7f1393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0waogCdlUmfKFczLh5IAMR3FkNbcEnY17FuuilQ6XDwq7t/eSUEkeuSwa0tNZlpr12CwIv23ua2lcPeKBx71YQ2ZAhZ4tG/POSKlPMIZfUWHQWgJApkqNU1rzWZYWc+l2A86qCBdn+2gZV3iRh2yiS3AmcED/gGET6MH+MHNtyrBkXcgzHvEvVV9pm07Kpn0Strd7/B66xptqRZo6ZDyKHinL01xUB6IgfcHWnq8qCkgvVp7QHYmBZAI0sIZUQ7pzu/RkZpXwcBM6bCIDEIu4kDBPSXlQzZJl9q+Y3wyeGNjhfT4SIruNExbfCF5QVTGmR1n/v9e7chXryMPGV+X4n1LU6KokbodLgw2nUbguJFJwvr8Z1sDQgWd5IZPS3ARJ7idI9jeaZB8iPQIGFv1LVOOoPNpeGuTFv0eeIiD2eGUGK+NJi0orB8lFkwwu/qRN9WSsxItxwBo0xaEB9DF7+nuZKEMFTXFqUbYdlW+S4e+4HqgmBmglHyO5d7FB+5W3F21iQql4BlbjL8A+JtYid2pSnGZzJMiRJv2pLJR8OA7/x+LvffXx9Ax6FG4sv6ph+NLChuX9hbChYOX4wiP1pHBs15ExC6JnxbRE+Btxegz0lS/l3OOdpyoiCuLXA7GxHMqR7vBnSPPEIPZOEGRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(36756003)(41300700001)(31686004)(2906002)(83380400001)(7416002)(5660300002)(26005)(86362001)(2616005)(6506007)(53546011)(36916002)(8936002)(8676002)(4326008)(6666004)(6512007)(31696002)(6486002)(478600001)(66476007)(66946007)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtEWklJdWJSb3htVEtmMk56R0ZuTDJ6SnZhQjlHSUJtY0QzdlZpM3drQjMv?=
 =?utf-8?B?MDZMNXR3bEFMSU5WZFZUa3RMY3J2cjJUbkEwejdVY0FJZWt1NTlnREpQVnVG?=
 =?utf-8?B?Zk00ZVNVYTRERndQVnFTS2Y0elo1RENLenNxcUZZdjhob095MUJVdkhBOTR5?=
 =?utf-8?B?OEdWVFp6RmszRjVGS2VTamlVY2lEc3RVdlVuVUhNL3NXSmg2UjB5ck5aTVFi?=
 =?utf-8?B?ZitZMFhPd2Uxbmx3OEVpMk9QSDUwZU5yK2gySGFKamN0S3RUTVIveXV3SFdy?=
 =?utf-8?B?ZnlMRkYvMmdXUitnNUNUL1ZYdzI2N0NkTkdPTkxFNTAvQUFtNTYxRUZSNjVr?=
 =?utf-8?B?eWM2TW1NTnFsUXpQMWtwc0xqRkxiYlZ4TEIxdE54S1FsNDI4VTY5NWhNQ25y?=
 =?utf-8?B?YjA5aGdibno1QlFITk9MQTFLdUpXalJmcHgrZm5JQUY0aUJFWGFCdkVlN2k5?=
 =?utf-8?B?TEZGUW5vNTBhRDJ0Y0dFa0hzNGdyYU93d1BuU1h3aWhkQlp4T0RsQzFGaFZi?=
 =?utf-8?B?Q2lpTU1zRWlQTU1TWmhkV2xjbUR4Q2ZCMTAybG9KMksvMThRb0diS05CR3FI?=
 =?utf-8?B?dy9SZzM5bGJNVHVSZ09nTU1OTmQyZ056Qk5PRnpJY1E5Nyt2NHowV2dlOVV4?=
 =?utf-8?B?ZjNSL2VEZytjWndqd09ZWXJFOFVVaC8wZXJCQ1R0Q0k2ekltL2E4bGdhdWhl?=
 =?utf-8?B?cGZiM3Ivbnk0aS82RlZOMXFpMHdTOFJra0JxU2JXbXd3OW5ibmNSL2Q4MmNN?=
 =?utf-8?B?emUvcVdMSkpVbEsrdVZuSFQxaEtOY2RWUTZPVEovVzVsaDZWT3hzdzFYb2RV?=
 =?utf-8?B?eEZrYmRkYUcva2hSaVgzTGdwZDgvMWdRU2IvaEhoeDh0SHdYY0pzMkw0UXhj?=
 =?utf-8?B?b2hRUmNiMUxkUUplSDlDbFdUZ1Bud3NrMTRndGNVb25BT3JiV3N6RE4yT1FT?=
 =?utf-8?B?L05KaXpVT2hqZEtDZExUZFduMzZsUmVyam42c3lXUDBCSmNJbjB6MjZJUWhE?=
 =?utf-8?B?bVlKalNBVW5oTmZLUzh3ekR4Vy9KYjZUd1Nnb0paZ1c2VlIzeDdvaVZ4c0pX?=
 =?utf-8?B?TTVjQ1JuUlBoQk1pZGFRUmZuaWxSaWJ4ck85Q2NjaUhxQnVNa0xQalBCOCtT?=
 =?utf-8?B?TXBYMDdPbm85OU93Z0dHSWZFMDhicmZvdUUxTHRsbmU2RVFHc2phMkc3NHpp?=
 =?utf-8?B?R2tSTmlnYm9raHA0OEt1VldmQXFGT3pmVGlNc0E2UzhUQnMvKzVRVUFyeUtW?=
 =?utf-8?B?NWNtekRRNnd5WTlLb3VBNEQ1djU1VjJjaWtiLzBCVWNaNG9tV1ZmRVpSTWlJ?=
 =?utf-8?B?QUtnUjAxOCtNMHNYdStGQU1ZK1dCa3h6WnBLVHhaUkV6WWc3YW5jUDdHTzBX?=
 =?utf-8?B?eUtCWG9oSS96cWRIdm1IYmRHWjE3ekhkaWN4WC9JblJKdWZJU05hR0pOTm05?=
 =?utf-8?B?ZEJrSjhmR29LRUswTzZudlYreTBMUEJwdXRkM21pMEZzZ3BMdVY2eG52ckJh?=
 =?utf-8?B?Y2UrT3M3aElTSkVWNnhueU52Vmc4VDhZOFUyM3dzRkUzcmVlR2tCd2JXQWwy?=
 =?utf-8?B?RDE0K2FNZWVJdmFsYk9Ic29xRUdEcTNicFd5SGMzRTlFMzdhTlZxS2ltUFVa?=
 =?utf-8?B?S3JSL1k4ZWNzcHBWNGlCM1JEMS9odXdjWk83UjQ0Zm5ZU2YvWnljdUNuZjRN?=
 =?utf-8?B?cm5kbjM5d2EwaUZVNzJjRzREbTYxdWYxdlljVTIxZnlnM2M3UlRPTnA5THls?=
 =?utf-8?B?V29Mc3ZubG9NR3E3NHM5bzhtdnBFdzduajU4Y0Fyc3RMWFZXbzVYK1VRMGVq?=
 =?utf-8?B?QnBCNmFVN3E2TDJTYWlsZnVSTlJsYTIzUTQxQjdKRW9DQ3ZuZnV6RzJqeHUr?=
 =?utf-8?B?OWs3c1Q0ci9yemFxcmZKT3NvdTczRmd4UnZhNkRRWW05NVYwUHhyQXgxN2ZO?=
 =?utf-8?B?RmtzbGNOd0oxTkRjTjdnVjV0cVYzM0N0ekh5OGgxUExRVGZ5N1V4aHBZTlAz?=
 =?utf-8?B?Z214VzJYUmhLZ0xNQkpoRGl3SjQyUnlYS3d4UmVWZ0pIUkNhZ1VVcjVzdStR?=
 =?utf-8?B?Q003U3NWbHlBZ0tTZ0dmN01tbXA0WFh0Q01aTkhOQytLeXh1eUMvOWJOSlcw?=
 =?utf-8?Q?yH6aT/OItzDCbV8VXvMO+w6tv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K0DzBiLFLWTUG5uF/QLux8tj10VF12d7l3fDmpvlvG0wcEJmz31C27XD1GvIo/uMD5EM4Y/rGNUtbHWPbKNP60o8EsNisJ3cXYvoHb2GMyvjaDXCklxwNOsRPX7rxWXhsnm90FYh2IiZvJCE4oNHLMEdeSqoGp4WL2Yr360ZM8p/2PyZWrIVgwSDKwpF1DL+CxvhzH2VrgW0OdNofCFmzU1OpS8F4lV17kQwQ6R3+KkvSRNSapOWfO6v1HvMCtwyt+z1cvu+tjv2ol3gslyQPV2gUaNJrOMYG8puFdnKxS4I+/mzjjibECKEWE8rxwTRO6WZe4vqtFSZSJcQffD1jLwyczeRbjtz7bvV+8Ci+8YFqgTEbDUs861JoT2gA0dCm2xrKSrnr1spMEMss5oHLKZJ8GWi96QlGXTbI4jvYu92Vussrh8mPJE2sJPUAxjgo29Dbjsh0Q6lHMhRtUNdA+bmzc11zWrh+RkA5Y615wIR9FzgAEruCZN78rOZp94A5f4dei6aowFTBS2BEPnoTkLmevdld+1MTsKUBC1DpmQYs/7g0JCxdENPCTT16E+S4Qmh8eWWW5nHNWFSvFBUqUP4xWnO3fPufYwyC4EroWU0SeUITIebdGq7GnyT/vtkvxtHoPJFh/OuDVmRxpl1GyrKIwJWg8gkBGoC2T1enfUfMii8sTb/qqnUi5zpUdcNF9MsT+39mnm9WiQ7BEFyxg1mBV8JW+a8n7T3bfO68PKTEnOTcC3Ixv1lOt+NP2kN153D68UkHRyUC+WSc3SvOxHlQ/LXqN0WnD4owGvuVoEDazfeV0EdFHwC4SWN84g7I1DxbZXhE8h5uFnHZ7R8yNSCFgaLcEYVw5C0WP+hnEOqsL9IjALPon9lWGPabQ07CGMRQapsCSTh4j8QpDRTuU1BQY6uQAsmaikwu3T3pvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d092d3d-7f00-4416-fee4-08dbef7f1393
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 19:28:47.4052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiJTaFGvnuRgDGsdcX/ucZV4v/M1cG/ZNpS9dYL1smANmHntA6AVZYrilb0Lp/gym6j4GQxDHdETCtOAlIrRVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270135
X-Proofpoint-GUID: w7Qlnd6etH1RVdmJfBWNbqTlv0vo60P_
X-Proofpoint-ORIG-GUID: w7Qlnd6etH1RVdmJfBWNbqTlv0vo60P_
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2023 02:27, yangxingui wrote:
>> We already do this in sas_ex_join_wide_port(), right?
> No, If the addr of ex_phy matches dev->parent, sas_ex_join_wide_port() 
> will not be called, but sas_add_parent_port() will be called  as follows:
> static int sas_ex_discover_dev(struct domain_device *dev, int phy_id)
> {
>          struct expander_device *ex = &dev->ex_dev;
>          struct ex_phy *ex_phy = &ex->ex_phy[phy_id];
>          struct domain_device *child = NULL;
>          int res = 0;
> 
>      <...>
>          /* Parent and domain coherency */
>          if (!dev->parent && sas_phy_match_port_addr(dev->port, ex_phy)) {
>                  sas_add_parent_port(dev, phy_id);
>                  return 0;
>          }
>          if (dev->parent && sas_phy_match_dev_addr(dev->parent, ex_phy)) {
>                  sas_add_parent_port(dev, phy_id);
>                  if (ex_phy->routing_attr == TABLE_ROUTING)
>                          sas_configure_phy(dev, phy_id, 
> dev->port->sas_addr, 1);
>                  return 0;
>          }
>      <...>
> }
> 
>>
>> I am not saying that what we do now does not have a problem - I am 
>> just trying to understand what currently happens
> 
> ok, because ex_phy->port is not set when calling sas_add_parent_port(), 
> when deleting phy from the parent wide port, it is not removed from the 
> phy_list of the parent wide port as follows:
> static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>                                           int phy_id, bool last)
> {
>      <...>
>      // Since ex_phy->port is not set, this branch will not be enter

But then how does this ever work? It is because we follow path 
sas_rediscover_dev() -> sas_discover_new() -> sas_ex_discover_devices() 
-> sas_ex_discover_dev() -> sas_add_parent_port(), and not 
sas_rediscover_dev() -> sas_discover_new() -> sas_ex_join_wide_port()? 
If so, is that because ephy->sas_attached_phy == 0 in sas_discover_new() 
-> sas_ex_join_wide_port() and it fails?

BTW, about something mentioned earlier - adding the phy19 with SAS_ADDR 
= 0 ever to a sas_port seems wrong.

>          if (phy->port) {
>                  sas_port_delete_phy(phy->port, phy->phy);
>                  sas_device_set_phy(found, phy->port);
>                  if (phy->port->num_phys == 0) {
>                          list_add_tail(&phy->port->del_list,
>                                  &parent->port->sas_port_del_list);
>                          if (ex_dev->parent_port == phy->port)
>                                  ex_dev->parent_port = NULL;
>                  }
>                  phy->port = NULL;
>          }
> }

Thanks,
John
