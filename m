Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF91A7EE592
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbjKPQzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:55:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B219D;
        Thu, 16 Nov 2023 08:54:58 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGYTe0029924;
        Thu, 16 Nov 2023 16:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cp+O2dekGq764onf+M56iM63w0u35NWi0UkfafLWXLg=;
 b=XVwxqaJWvIJoRxrhzM2Okm/McIeNkso1nyPGG8tMSUdZ8uQ2+AimbAurOjvKTzR0lKDX
 fybe8W6MzGg/IOr8y+6J30JPhhZwSFaom8wZu8cytoPYe4TQwcEc/QpH0cKFOWrBy2b1
 mfnJS2dccP19kfrwFtv4SEyQFKLRN8L0I+mdjQxPu7CQ1Dnj2/uBhzCUjx25wZgK77HI
 e4fMeh6Sa/G/NBeKMglZ+mkTI2IhQXYrNoOZPWyIWexAfrQhMg4kMg4CVCG0kDUoxevC
 ABTMtBnfZn23ZTn0mhfuyCZN9m7xq/OthMTG8gpC0NiDW6goRdQ9y2gdvuLzRjYJ89Jl iA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3kd5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:54:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGFqm3024563;
        Thu, 16 Nov 2023 16:54:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq34vty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 16:54:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6aiokamR3v4CgDo5J/wniCdWV+ZMSPNd9c/xPN0fMozHjsr2oYeIouaVAQx09igbsKILFDvj2aN5ytaIoUZ7r2fOjbgsZ0YUxWW72c4LqhDJw0za86/V5iBRRoGxREhuaP89AYFZ1Y/P/I0kdacfSxDf0ceiAXQnnLC8VYQSZwhUowmctGrXOrkxYen1Hg21pDADdts2g3nVqa/25dAIjPZZ1nwGgOjs+4Dd1X9zaGDJutbrJ2oYetLbHwNhSKZbd3dwM2WgnaA1yZuHFFAhsIs9LW5XHj0TJSKUKUUsuAacPQ6b0yMPs5d9knH4wcvl9cTFnaf/ZFvrvK2bQv/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp+O2dekGq764onf+M56iM63w0u35NWi0UkfafLWXLg=;
 b=SWq1TxrbRDljggbMnXZ8qnU1Fc6PZePsR0xCQ62r5RBZPJutOW8RHSymfjs8+j0KVKnjoW9ItPGfTVApWaeDDtkkPXXcis5yiCeIJm7EN/uR7sXg+fyjEUd0bfnMGPRJJN2mTlaKj24PwiVpEYfO+eX+5VbG10bL50v9bW5dLvfz5MrO2Wro97gUSOYYNtotZgt4XGwuamX7c2J8iMW1jYYLkNDdfSYE9KcHs9Rs9FUoG7Ljj1Bplec/RGPT3ZYzTQpGMFtQZJqWHac1/wSaUgGw8GV9IzkjSEK8QhDqWAdX8SIU+7R44ZZ4TW/lDo5MLHRnbO2zDBDEMYaLv0tnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp+O2dekGq764onf+M56iM63w0u35NWi0UkfafLWXLg=;
 b=sF0DN/49k2C2vH7ZlGRNd2nLwnQx2Zp9mym5uJ+ksgyQ7yMQphjaJWqXqLs4fCyxlXx2wmjDafiFmXcUj96nEzZlaaBeK7I6+PQvFqw3IvkkQC6qvtD05btLV8iA8BP8QCGRS2LMBZ7Z8BxEUikCyb0Quv5oXFvkKaFcyYphC+s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4855.namprd10.prod.outlook.com (2603:10b6:408:122::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 16:54:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:54:38 +0000
Message-ID: <a84f7c4e-5da1-4357-9001-c379734e500d@oracle.com>
Date:   Thu, 16 Nov 2023 16:54:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: libsas: Fix set zero-address when device-type !=
 NO_DEVICE
To:     yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com, chenxiang66@hisilicon.com
References: <20231116035241.13730-1-yangxingui@huawei.com>
 <dea5cabb-7d9a-44b0-85e4-878c13233f6a@oracle.com>
 <9cc196d7-0c4f-ef09-53b8-362d5eb599a6@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <9cc196d7-0c4f-ef09-53b8-362d5eb599a6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0077.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4855:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb2317c-93b1-411c-b4aa-08dbe6c4b860
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RzCHwsXaA2LiwWQ5j57L4eLUvZY9TD4skVjZDnJHkpqQQ1wgk1oLYG5gLwd89QzlojAvKb7YMQ+pxDQJJld68nxpj+BqTwtU+p+0+rUFcro3u7O+GGe023rwIu3DV5RvkjXDObvWLAg41YBN03B86ZM5Yfu+xZwYcHe/ECkHtXNhnetYWF8meIWGxg97OOhQQRHCgVUWEJcwdtvcCS60Gdzzdx3F3rRqqn1VmTOAX7LmG8BViLTCVnVsdg7zu+MAtKPAOw+NfmO+F6JEc4r0giOA4ldB6amNV98sX7wwJJN/8uYrr4LRkuA32iVTJbbm2sE3zvesrY4XH4QfR/FjWlGn1KJTVPNPQr8YcmmEl3/KXEV9azwUj/59SSWCWAzEmiSzPmiAI/ADFtECCMmWHR5BFls3kIat+6GzLF3cCkhSGkJ5EGbDp9SwTF3wx7CE5qEkeRND8qNwIYAh1ad1hlmSfdyqS5Dt1WaL27z3Rah/E81Y5UuBTma/Zt/csXF0LeHsJLO1AehnAS4ZFrn7ROkNDDSeYCKWaEPE+wriiyTOKpY39siiw+pKB3O4Xi+/Xyok9GG6F3SUIbp+JDzxjx2WIN/nwUL5mD9wL5w2LqTL65mmjNB3p/rsOZmrkrYu7gCmlmLSJw3igx8iLyOTSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(36756003)(31686004)(31696002)(86362001)(6486002)(478600001)(66946007)(66556008)(6512007)(6666004)(66476007)(316002)(36916002)(6506007)(53546011)(4326008)(8676002)(8936002)(2616005)(26005)(2906002)(83380400001)(7416002)(5660300002)(41300700001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3pyNGg3K2k4ZTV1K0c0aDg3NklkUVd5SHc0SUlPd1dEd0xYQkh4d21rTDdB?=
 =?utf-8?B?ZnNUcnkvT0pxWndMMW1LR2gvRGFySGdhNmhEMDNCbVVZWEJodkJKdE9yMWFz?=
 =?utf-8?B?SWVCemhVZEJsYlJ3U09udlBMcXBLWHVIdFlwSExtWmdROWNYam00T3F4Nm94?=
 =?utf-8?B?bGI4NlRuck5rOWRFZFlwRE5meHhOTW9MdC9Fc0RoOFl6NDI3enhuayt0Q3Z4?=
 =?utf-8?B?UWNyTU1iWVlvOUYyaC9JcERYM0hMWW0rMGdrVlgwbENWWlFlSDVBamdSczRy?=
 =?utf-8?B?RHE3VUJXVUVONjZHdC90ZHp6VWRGeVlEWWFpUFJmaGdRYXM2MVpsa2hOVXNY?=
 =?utf-8?B?SlhZSm10SXFtRnNObmJIOXNIcGlvcHE4OXJoblVBbUxvcFdDSmt0QUpkL1cz?=
 =?utf-8?B?U3ZGWVVWSVplTnZGUk9xSUlSZDJTSVRmVmJJRVVOTnFkMklYU0pJWkJNRTA5?=
 =?utf-8?B?N0RDdGIwbXk4eEJHZjdmM0E3VDB2UVlmQWZWUE5xVDFuMHZaTmNtS3dwSEI2?=
 =?utf-8?B?bWR1NDc1MEhuSkwweEFBSXZ4ZlpHQTQrVWNINWVXUDhnUlUrZ05sckJKQXEv?=
 =?utf-8?B?ODhwdzlPYW5EandNN3F5N040R01Rb1BNOEhjWDdyZEcxZVhaM0srU0NTK3Ri?=
 =?utf-8?B?UDlDbE44QWV6SXBwOWUxRFRobFpzRjE1czROT2MzZWw4cGpqVWVrcFNBQjU1?=
 =?utf-8?B?bUUyRlUxUVV0dFJxcFo2bU9hNEtyUzdkQ3ltc0dJTFlqbkVidFYrTHljUGNz?=
 =?utf-8?B?YldYKzFrSTVKSWl3aDRXZ3kxaU40c1B6cDdmclBnODgrNW51S1YzOWNNZDU1?=
 =?utf-8?B?OWg1NE5CUHAwR0xrWWwxUFp5NkljNUZvZHpqYWdFSFliVjFxRlpoY3VLd2VS?=
 =?utf-8?B?eUpmb2NjTUZMNmxXei9rNk4yS3MzaGNlRnZ3RHdBQ1p5NVNCdEZXQldKd0dQ?=
 =?utf-8?B?dTk5VTVnREYybVlaVERoeGVCVjdyUDd1Y3VkYjNSRkVjc0FiTFVoTXVCVS9q?=
 =?utf-8?B?dzdCNHBkWEZDZVRKdllFT2lJeU93ZkJXd243VVFURlZLcEVpQUxTYU9WUEhZ?=
 =?utf-8?B?ejc5L2xqNThIWkhUYkJieFZsY1RjK1MxODBZRTV4d2VpZzVWZ1FKUGozOEFj?=
 =?utf-8?B?enp3KysxRzlxQ3ltRmMrNUNiMjUwTW9sRzFpdEp2NUZIcm5GZjUyVE53V1VP?=
 =?utf-8?B?MkZzQkp6ZGUrNG0rbGhBZjRwYlZkM0M3eDd1RHlUbVo1cUdLcHFLNi9GZlRv?=
 =?utf-8?B?cWxrYy9Gb2dGNnUxM0tNSURjVFpjUkVSeTBDajE4aXM3MG9EeXZ6L3Vqall5?=
 =?utf-8?B?VnpHKzZiRGQ4ai9qRzVmdVZrTDg4M1hBLzFHWmhOTVNyZ2pDUnMwT1c5Wllj?=
 =?utf-8?B?S0NRMEVnL3ZLSjBxdmw1THdqNGFSaVFFemU0VmZuU1BDWGhLZWFhN3RwcXRS?=
 =?utf-8?B?bU40YlZzYTBxd29EK3V6UDVUWm0wM2t3enZKVW5SQjVNVm9FMWNaWHFJU2lF?=
 =?utf-8?B?VE9PeGc2b1NLdzYwMk1vZTd5RnA0NlZmMHIxUi9Ub01PWjNVYXlxQkVJblN3?=
 =?utf-8?B?MCsxL2NnNFdaaFkvajM2OFVMWjdJMjJDZlU3MXlLN3lUQzdPWWxQcm13UjNK?=
 =?utf-8?B?VEM2UWZSMnlHMHRCOW5TNWFIMG5aUWFRcWNWbWFYcTFYQTFmVWRrV3IzUVds?=
 =?utf-8?B?Wm90clJXNk43UVNpTHQycWV0V3IrRjNwMVVSdmx4STVCNjQ0Qi9ackpweVBS?=
 =?utf-8?B?eGxRbzRGMzg4YkNaWS9tWmQ4QlhRWURvQmNFZkNLbUphMUNHa3lLOHFUWlVo?=
 =?utf-8?B?R2NvQjJySG9mUmp4VW5nMTRsVm9zcnNyTVlEVXkxRXJiUDBJSnRabVRnUnFL?=
 =?utf-8?B?R1YxbkZ3MHIwcTY5RnZNa05EYk9nMm1LVGFWVEN2TWs0QjUzZVZhbDZCblJZ?=
 =?utf-8?B?Y0dCOE13NEc0YVFaWldnWWhPdlA4RzgxWGFSc1AzeVBFMFpua1VPTmRqcW5I?=
 =?utf-8?B?VjZIRmNUVllNakxudVRocTZVRURhL3ZCMDd5TitjVTFUd0JYczV5bjRFR1d3?=
 =?utf-8?B?alRsTzVKOVVEYUZ0amFkcFpDMjMxWTdNWEhBcmdocUwvZ0ZXdy91TTJ4aXNy?=
 =?utf-8?Q?/elfD00u+zMk1WaasqJxgebg/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5CR9N25UsXkBOEFc/V6SFVbf6X6pi+lFUkUBWutaZ680EuGOFj9sGgtkKKK0IXhAM2M4PnxLg2ZCCqd0fipfVYDqV559VmE0j8mRZ9vIgAG9zxJ7Jex3un0lzyGrAX99N3VdOG6aInpeFGgX3W004WpkicZoxG0BU5D1zySXkMt183u+R9Af/uxY7mne+kxspB7t8qhGlf//p+S/hu7J5WhT84zfT+s2IWKk3qtcGmUMQG66LlgWlatf8MehmcJvtXu0wKAI+nRDArHnem4RhM4Pq9qjYLGXxZfkcY/APYb7qGlqCxMvg/K3zLqdlJZKZajlMo2Vr1frlFmEsFZlQlEnPyR2cfzt75FxQUxmvoYiwNDoWTQ1Uml9OKH7cBMAkE6UxurzkLABTSjJs/8pFDUs/JWKRS4l0xN7iS2idBKm/Wsyri3zaAastmMun37gR9x+PROzca9CLKyVH/GbG/KPUvh/Frxomxij5ePnIrrv7WjUUSnJ5vZ1L3lFaGem6TXeRVYfivXQHyTk58+M1Y7VIJcpQwoB/Ux3t9dhtCl+FVwSqn3jAhgnlhA4ta/O2dq/0O5atsjHsK24+SPfBKja3RwkcWxNh7NNIw8TO5F8YQkyyQuKMv42e52nxLyo368L5YBBiM80Y82qwashThmIBzcnxdLSJWC5/sepp79grYJtghj7RYVQ1iYiuoLyGk8yQPTETqta+rk1jVntcqh9QczJma6l0DHvUF0kd2cdswFc3NPkNXqRyRChSb8vdQGr7ZdxhgXVfToEt+BW5RXPrAK3KdICKKt2YMhvveXoD0xrnYJIEEz/lzJ9qRmCw+O6XpGW5U+nugf18MDNxqS2NCsXQoUofhXYgCGCLA/hj8/t+GB2rknWzRx/56tV7sPmPJl+ob6RgFUOYWJjFAoxa6yg4aHlSlInOB0glOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2317c-93b1-411c-b4aa-08dbe6c4b860
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:54:38.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Umc8235L5RWdC+WZ/3lM/XI0fbczxDplyViuhWYJ2Br+9Z0UIL9OBQ4w3Mw6gdNo6c8ENMTPoQ/mVpvIb3fJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_17,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160132
X-Proofpoint-GUID: waPfHWJrtuFUNSNj7vZJH52ECt9t7Ws3
X-Proofpoint-ORIG-GUID: waPfHWJrtuFUNSNj7vZJH52ECt9t7Ws3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 13:45, yangxingui wrote:
>> I think that patch title can be improved, but I would need to know 
>> more about the problem before suggesting an improvement.
> How about "Fix port add phy failed" ?
>>
>>> Firstly, when ex_phy is added to the parent port, ex_phy->port is not 
>>> set.
>>
>> That seems correct, but why mention this now?
>>
>>> As a result, sas_port_delete_phy() won't be called in
>>> sas_unregister_devs_sas_addr(), and although ex_phy's sas_address is 
>>> zero,
>>> it is not deleted from the parent port's phy_list.
>>
>> I am not sure why you mention this now either. You seem to be 
>> describing how the problem occurs without actually mentioning what the 
>> problem is.
>>ohn
>>>
>>> Secondly, phy->attached_sas_addr will be set to a zero-address when
>>> phy->linkrate < SAS_LINK_RATE_1_5_GBPS and device-type != NO_DEVICE 
>>> during
>>> device registration, such as stp. It will create a new port and all 
>>> other
>>> ex_phys whose addresses are zero will be added to the new port in
>>> sas_ex_get_linkrate(), and it may trigger BUG() as follows:
>>
>> I think that it would be better to first mention this crash, i.e. the 
>> problem, how you recreate it, and then describe how and why it 
>> happens, and then tell us how you will fix it
> How about follows:
> 
> The following processes trigger a BUG(). A new port port-7:7:0 that 
> created by a new zero-address sata device tries to add phy-7:7:19 had 
> the same zero-address, but phy-7:7:19 is already part of another port.

I would like to know how to recreate, which gives a lot more context and 
helps me understand what the problem is.

Thanks,
John
