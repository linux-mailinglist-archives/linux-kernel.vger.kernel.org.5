Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6D27932B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 01:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjIEXzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 19:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIEXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 19:55:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A140DFA;
        Tue,  5 Sep 2023 16:55:28 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385NsglY021243;
        Tue, 5 Sep 2023 23:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=PtFl6wihiSEV8UHCz2NRz6iDxj3FFuDBoLAX83Kt7x0=;
 b=rtVoV8E9Vh38j7nNgBNlXFSaOXqfNKKelneoJpR5GZxuUA0xv4Mre17N8dPt7bxIh/wS
 Un9thWw1ipFm8SqjmCNKPIEhvMVqvgsr9+LfwEu5gFMdU3HTWkva8WAPIG83HujNPDUQ
 YHeDiyLCaCBf5OH3GkgeR6o5GtFonSnt0E/qN1Hyd7vCWnUvpQODMLKNrbcn/D+5vFFJ
 GhIeGfchzQhnFnKd2i6COc+2MiEDrQStKJEK5Yj7T1S1K6B/IS7h0Yn0MTvtZpQJdNG/
 spkFViZD6TqU02X7A9jB8LhFfgbZcY249J0gEqhneR3IlEZF0/HovZcJuhT878s/bVG/ Hw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxedsr00r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 23:55:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385MCU6L006561;
        Tue, 5 Sep 2023 23:55:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug5y0qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 23:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4yr0phbWJMQs3fbu7q2HrJ9wl/wo6ApmAESbD/nDeccxmg7b5XZXPox5L50tOcyKKF4tX7m2q5U4lC07mg71jw/x3AxHTdeCyNWD2bAyskLzx1a7S7AvSzUONhy9vil2GRaorLoW593MBdyu3VaYdnnR8iEBzfwbORN/KJ3MWylctP7WkPvjqBnLWCL0Ak04g6Ny+LGde8EKjMNeHuAbPqfDlUOWDbEAl1PzRGeaIIdF4tFAWvw7xEYd7WtWgiJpVtfY+/Zec68wbJ7w13wWZXZJogJux9Yl1tGFhIpT76wT8vvX0y+mHgGxo/85U3DJ+QwV3+yVaDQjBqewVP0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtFl6wihiSEV8UHCz2NRz6iDxj3FFuDBoLAX83Kt7x0=;
 b=erTBcrdsukTBX1SEXooz41G8gMGd+lSEnhiTImIcfulzV3Bi9fUTz9ATL8/eF2HMg3gjtRBevsBt1pIdxDNUJpzKU4beIEhDgSJC/AkEkW0vrq+AgkKhiVwNvTQSg287U38UktJzNDrbiLbd2GQ8mdyjNemfShb8L10/naiS3cmi4/ecx9EmkrNPmd7uFPo9f1AYcKSYmnuYXVdyuZGOzugWI4NW24542qvlqLzZYtrLWsi7PKU1jpqLUIsW/ZI1x4L2yYOBJWfEjm3IHvCHrfVYW8Q3nnGlZTX4i2lBSMOIhsX2OrySWUFCw7BmfjP4M7Fv9ujbVmk2LlYqDKW+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtFl6wihiSEV8UHCz2NRz6iDxj3FFuDBoLAX83Kt7x0=;
 b=LNzouFBCxq9e9/KQpLqYXbryX3/UQARIad7cXqISoTqPcXG4Gzk+gV/SEnVR9BzQvR91tOOvuexPm2cIEpGd1tuKscKs3SclEnhh7GB5yT7p3w9pQy7DL1/Rb6Hk4aKkZ/tyDMbdRSt64QCPl3Sa5u8KHxFC9ETC7L3rsGMr228=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SJ0PR10MB7689.namprd10.prod.outlook.com (2603:10b6:a03:51a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 23:55:12 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 23:55:11 +0000
Message-ID: <daba5c92-2395-4eee-b212-978fbe83b56f@oracle.com>
Date:   Tue, 5 Sep 2023 18:55:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/19] scsi: core: increase/decrease target_busy
 without check can_queue
Content-Language: en-US
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <20230901094127.2010873-10-haowenchao2@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230901094127.2010873-10-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:5:333::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SJ0PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 377645b9-09f2-4a39-966b-08dbae6b8abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu7AGN6hLuqQnQS4IS0qfBFUWFr/ikmEKjsLLCgEp1uq0opN2URS9er1UTm6ZomAh/Zl855iulNFf9uvBtudn3aDV4lQqOFqibaJcvSESDqLFXMco/DuPrmLeEMvH9z25EsQu3xdQZ8HLS3dChH7RRVOQ9k7EjSN/861QO6W8jgL0UWc0xSxOOyAY/X87pwIuZluhulEC4vBxcGXQoWNoU1yq+28wJxr+vA5OjdOc1wKalCW1IhB2c4w8/NgfCSmI+k+JT+O81FxlpNDQCaDcpt7qZw7M7+WyMfPc+nkC3XiJ/JrXgXNZOS6DvyiBgwpfl4SrF3mNf/PkA35bfcMWry5qPizlj/N5alXSEM5733WOEF2rx8SXzmBo0S/aNtaLwwoh5zw5MVS8pij1/bjHEsqDYQ1zk+6QE+poJvumWojEEgQIT31KA5XQrkgd9qd4y8ohtWFMAK7OjMgvUBFHmGuPPE2tbJ4iRJ8FSKyinDavQiv+adf7f6CyR5p9/ysGCHulfYs3qpMkSLnJJ0ceNWR61Tdsdrj6OvKOjZGctVE6iOt3qfBXnM50LBYV6nSd26OrMihw5YAWGyO+byET8wjiNMlRn3vbiPkm2UMA0Ebq+8MbJuLHvuNwzjvbNfi6ER8Z1gv1ubFYANY/0YNcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199024)(186009)(1800799009)(5660300002)(8676002)(31686004)(316002)(66476007)(110136005)(36756003)(4744005)(66556008)(66946007)(2906002)(8936002)(4326008)(41300700001)(6506007)(6486002)(53546011)(26005)(6512007)(38100700002)(478600001)(83380400001)(2616005)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDNweEIyMGZPcHIrbTRYeGk3RzllaTFmcU10RjRlUFk1TmRXV3RvclhIcVcw?=
 =?utf-8?B?YXNCdGtPemZxSTFVZFpkR01YeUZUR1EyMzdoVGV2djNsR0xpRGlNZGlENUJw?=
 =?utf-8?B?Q1hPc3FmSGN3Mk9TVmVXcnJxbHhDaEpOYk1YeFVQcWRTYU9qM0MxNFZ6YUhi?=
 =?utf-8?B?blpWZ3NMVzVvdnJSQVJXbmd2V0tIWmVxWHZoaGhxRHMvNnZnNnBadWpBb1BU?=
 =?utf-8?B?KzQ4a0NoaG9YNHE1ZWpid3FvZ09JOUs2cUdzWW9VcVpyQ2VoS05DNG9BN3Y0?=
 =?utf-8?B?RHh1OTFwWkJhM1dBemZZRzViZzlRb3JLY0F1cGg2cSs4aGFqeE1TYmovSDJV?=
 =?utf-8?B?aTJsU3VNRmxTQ1pvZFluWUZwRnJVZ0N3NWx4RWx1Nlp0dExWWXZEemkwRUtu?=
 =?utf-8?B?dVRNQXp6bVJXbGdsRWxHK1pvMUZwSUNrMGkzQjdEVXkwTTBGdmZHMWRPbzQy?=
 =?utf-8?B?YXEwVTVLTXIzRnNRQXZRV1YyUUpXTmJCQ0VGQnJtQVpjTFlRVGY4OVV1MDNT?=
 =?utf-8?B?NnRoYVhhd0YvWWJNRlJHTU93RW9Cc1A2YTcwZUN1a2ZoNkRxZHZCUUpJOUVP?=
 =?utf-8?B?TmJ0UkRpYmlBK3Q5SFp3OXlQZCtZNUZtbkorME1OY1BrRnl3ZmlZSGhFTVk4?=
 =?utf-8?B?SlZ6R1ZvTFVqZ1JKRXhzM2xyQVQvOE5PeVRRa2J0VjBuSGhaNFBXVGpnUDEv?=
 =?utf-8?B?ZVFJbkR2dWU3WENHR0NGVXFxS05ScnUwUFErdGxzVjNrRFhEY1FJTzVOeGQz?=
 =?utf-8?B?SnQ3RzNSVXRsS1M5MG1vN2NaNFVhaG1nbmMrNWVSZ2VKODIwRFFmbVc0TFR2?=
 =?utf-8?B?Wjg5YlJ5ODZObzFHMXlEY0FidzVYbS91Vjl1R3ZRc2Zpc1B1UjBZR3NhMG5L?=
 =?utf-8?B?QVVhcnZpV1RMM1lob1lDdHVaRkZFLy9DZ0Z2K0Y4eUlkdTEyN09NeWpRbk8v?=
 =?utf-8?B?SGtwL0RZKzB6elRCcElNV25XRXNIeGRmWEdrNXM2Z3U0bmd5V1lYOU9adm8z?=
 =?utf-8?B?L0dLVCt1bVJBd2x2RjhJZS9DanB1aExNTWFBQ0w0UDFEUW80VmpYY3dXV1Nm?=
 =?utf-8?B?c1g0eVJVZnRtOUthVFI5NmVBQUIxZUppVm9pQWFncDdCZng5SnVvc1JTV3ZE?=
 =?utf-8?B?dVZmbCtBUUpPS09WaWw0eGhXT2ZvWlppdTIvK1piUlE4ODIvb2ptWG1yaXdS?=
 =?utf-8?B?aDNnbGRaRmRPV0dNejJHbVp2V0svTUhaVER5U0FSUGlDdUpNUUZ4S2RHUzkx?=
 =?utf-8?B?RVNONGEwcHFnY3dyeEp5V3dKd051dlNpcGt2M0gxaENLVXJSVXlGU0dkVkN0?=
 =?utf-8?B?RmdSTUZDSUlmZks5TWZ5ZENjU1UwZzVtZGJxc21BQVFsZ2Q0QUk0SXZpQld5?=
 =?utf-8?B?b053YWxRWUZhWFgwYm03T25VUVQ4RFFvUnhJWHJDNDJNQkJGak1ZTTZUNkxo?=
 =?utf-8?B?TFBnM0R4bHBnK0k0M2lXdUxGVzA2WWtiQ3gxT1BXUXlWcDhwT1lEMnVvQUY4?=
 =?utf-8?B?MHJRK3A3MGxZaEpXRy9lTW04MS9pMGdSanVuSS9Wb2J4VTdFTG5NYXNpc0Fu?=
 =?utf-8?B?b0EycXVkQUVyZ0JxYkErMjk1V2YwNnd1aG9lbXJlTUhsc3FXSWVBZElLbFNJ?=
 =?utf-8?B?ZXZrenNRT1dBVVZRcHVHMkRKM2dLckNHZWl5eVhmTVhCNmtqTGxVYytWSjkx?=
 =?utf-8?B?L1M1d2piUm5zczNYQ1Zya2htaXNveHdJTE5wcXZFTHhDL21GV0d1bWl6SWtl?=
 =?utf-8?B?WEJQUHR2OXRuRTgxempRK2RZem44US91Z1BYelJlWjZGQzhyUWtMTW5QblE1?=
 =?utf-8?B?bEMvUWJWb3UrcmZybU1PS3NXdndjYWRFZFk3WGtHNWtTTEtpUjFqSkx0d2Q0?=
 =?utf-8?B?eHhHQXVkTXRKNXZ6UVNPT3lYeElJcG9VRnEvaUtZSGtBYzlzR3JRbzNWcGxH?=
 =?utf-8?B?ZGkwOEJlY0pEaElJSnIvdHd4MG1OWVVPNzVxVW1KL0QrVFpUYVBFTmt0OU1r?=
 =?utf-8?B?ajBJeGhxdVBuTjc4YVN5c1lJOHhRcE0vYTI1TmJUSnNFcEZOVk5VZk1xSFN4?=
 =?utf-8?B?NC9jelEzMk1NZTdqOFFocktCWG1GWEVNV1Y1ZE10dlUzMUZoV1N5a2FMbHFo?=
 =?utf-8?B?Q0dGNDFMUStVdkpsZzlkUVljRVcrL2JKMFpzWm9jT0FvSW1BWXY2QkdRSzl1?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vhmjKtK73Gttd9Cys3BY+p8UGzeORRiUV3qa0xqX27W+rMjqJY/rLl8fJ8ytdDq8OINpooqfiS4zr9RisftLhTxRRvn6d2GcGMkIIAbiFcKS779LT0EhbHyN7vAFemBOrVXCCvWyOSdX1f+LntTcDBTwZR4hjAD/NSIYNJQvMNtwlwBzxlFeYCJenu9h0JEHnbBL9D/Ar7Q1O10AI3M/0w2zx4xOW5GfFsr3BQR4d6GGXIsowEvqvgZ2SyxNF9MdHyC+IHfmoBcpEjgARncEyJgTNO06soUIQOqIFwwkORTqunlu8dR8vBCVjFmy9dp0az1zenOuKzaw8xCdcRZKPbrU4gX9oNRHPDB9RiTeXvVOrY+UFDSK4yiKsoLn45xZJG7tA+rpDvW7xDkQMIM6EI1em51LRS36Vb/AYqEt/CtZnvQPyin5k/vSu054G5BYOk+l+3Re/v+jtgj3QTclDk50f6z1Gw+Gk/L9cSh0bpvp8VvXQeAS4SGM7UwDlF3/5poKop7YucL8f5DLXxcapPX8gLaDJWvvn73EDcO+qkl8WMwT3+y2heDFKF0aDU0D5Fn8FYuIfGOLCpBXxd2K/uXxd0gVRGpgTEtWh5wlAmf2qunJKIEM2WHb5KbtUCRxL1f1TifcZTQHWgpEi6zt3N0h6x/T+bPeQhyKcoYRJzwY5tvEcf2DmSo3hLWYcjwfqnWq/vVIglzLyxvUCAiW4hpKjFgfm8J+PE1OkIy/M4cY8YEpoFfXLrH5h1HS/oNWK6EJvgAXTbE0G/CrYnrJ1QhO2MetGN4yjnSxngdM7XJfE1pAg1qCDvf3wzzNHx60mgZC586DCiZXE+GTjwLZUiFYSTwA41FvBtuADmxC3AU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377645b9-09f2-4a39-966b-08dbae6b8abc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 23:55:11.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Si9D6QP8sFcP0jLuNq7S1M/NloxjTDKt976dBecz/oqG3VzCLOfXBU/r3krXodaB8yTY3ot4++Bwq9Gy7o9j4PT5QdwufwOyZ4O2xgDug7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050206
X-Proofpoint-GUID: 0u1x-NyyMM3mDr8PaCz3EI_e07zb2M0K
X-Proofpoint-ORIG-GUID: 0u1x-NyyMM3mDr8PaCz3EI_e07zb2M0K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/23 4:41 AM, Wenchao Hao wrote:
> This is preparation for a genernal target based error handle strategy
> to check if to wake up actual error handler.
> 
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index db0a42fe49c0..4a7fb48aa60f 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -293,8 +293,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
>  
>  	scsi_dec_host_busy(shost, cmd);
>  
> -	if (starget->can_queue > 0)
> -		atomic_dec(&starget->target_busy);
> +	atomic_dec(&starget->target_busy);
>  

Ming had found that removing the atomics improves perf.
Since most drivers didn't care about the target level counters
it was moved to the can_queue check so only drivers using the
feature suffer the perf hit.

Your patch should do the same.

