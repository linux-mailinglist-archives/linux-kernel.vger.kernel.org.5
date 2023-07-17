Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A4756CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGQTGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGQTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:06:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10D9186;
        Mon, 17 Jul 2023 12:06:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HEwt00030104;
        Mon, 17 Jul 2023 18:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YpweLP4WI2pLv7YkW5q5LbhZDEq7UMJSXOM6cyTQP1o=;
 b=D+Av4U0D2tHU/NKsgxd6QX9Y1/FRWlmOHxHPNfBEIO4m3SVatkdGknpuiww4aAZl8Hju
 BrtcLw6tZ6JOBOPCM1uvfRMwyZSz9bpmFoaJSRerhro8Dv2jNtnujcQ15844M3My/xWL
 Ln86FEsp/g2ysMvK7ikDSffrx7GMxsMENCtZLxI7QnWFiHKy48C0+BFL915l/fZugRwx
 X41rFvTg2r8fN1FVqB9x9aRDEsI4mS90RY+pP2GvQrEpN/dU1jrsxX+/IQ1miKnz+ahi
 Q+Ln0NjbZZlP5lW+UeVqc4wprR/ZgEt401yZvyLlFxppSrRlVTCaDNtceKaZTTJsXSGS AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run783aqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:25:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HHojBQ019258;
        Mon, 17 Jul 2023 18:25:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4hstb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:25:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HlfCvtlt2IpuvwgnpvARemihsHHhdKmbCBhgrxLXx5MZSrM1BbRU+bLIjQc4HpCPXNqtnyn9mkvIAG82q/V+kQq6AmFoyOWMdEJaQHMye2hcMCqA2pGRkB6l5/DU3phvCfTw71diQzZb9zczhfIF6TkyzSTF0Nn/Xkk1lKS+/JhowpSuOJGJaiTGPXjlR8DhO+qhz+4M/3038qnyLPfxne3Nr5qeB8tGaDKZSfBi0TKFt2y44GnktLAbn8CaR6F0EDOTyWO/LgSlfJOoAlxyNlJ2MqnQ0FzAtvHDUDLndt1X5fkgnMbkIHc3Av8SMs3a0MVIpHTRrW6hkJgX7OKBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpweLP4WI2pLv7YkW5q5LbhZDEq7UMJSXOM6cyTQP1o=;
 b=LVSsdCLB3maaikJZq0bgMlMTN/zRGtSFT+CCx9Zr/LnAnzLt4lBAkOP9tf1Fd5ZLVIsKbeHvnf4IsTkdm6foE+lQsVznocxXBGoonuZAeUzJRI4C/avGRXAoRn6XyIsiZQns4ciZTI8eFlqU+u+XvGzqqNOmGdTgwdiChsGqZNm9INGKd4EU1skjHmzoS+Ihy5E+tnTILzdhfSgU3JfW/+vlUOx0QPpSB9Re5WGvhT3Pcpjt06jWx4VOBINQjK6C8doe2mIJ5n1cT1anXuU3FeuDGK8i12nqz/mKyaN6J11CuQ0tAYaYeMGdvPu0I1OSO1tlhlpbX6KeM/+TZEG2Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpweLP4WI2pLv7YkW5q5LbhZDEq7UMJSXOM6cyTQP1o=;
 b=ViXD1YWw+rqLiux+I0m/q9/nkeFgp9JHoSoEhRWUgTL4/mL7GBCnB8Ru9Xb6ScaI9yKxnLZmj56PrNnqzZ2bAZ12NVXSleQNHLy6qjzZH/rrFpbLQXWssTX0S2cyaBSUWqk7pMyfriSzCJeJpvmJ91l5YIeXAU+ANEE3jB7cfNo=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by SA3PR10MB7021.namprd10.prod.outlook.com (2603:10b6:806:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:25:40 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::f5ac:d576:d989:34fa%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:25:40 +0000
Message-ID: <5bed6236-0db7-37fd-3d0a-4f51874f9c53@oracle.com>
Date:   Mon, 17 Jul 2023 13:25:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] scsi: iscsi: use kfree_sensitive() in
 iscsi_session_free()
To:     Minjie Du <duminjie@vivo.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "open list:ISCSI" <open-iscsi@googlegroups.com>,
        "open list:ISCSI" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     opensource.kernel@vivo.com
References: <20230717092657.9776-1-duminjie@vivo.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230717092657.9776-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:5:3b7::24) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|SA3PR10MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: abb21f5d-1e94-497b-54ee-08db86f33951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5+whm+HJq7v9qbQaa6anxhDxiQ9/Y+60+OiPzex5r1i+HkdVUCuUPhwFcjgeYWqSMpY3ZwwyBCB/ayqveYngg5g2aGy8cLDx3tc2dGkh5lcktec27Qk77jv5hpR4Y4czmgS+hkiMM/6pyirFs76rZLFdIe89HXCHOawRvCh4M1MMyLD0zKusq93soPLGc1n0gTNgAYnvrZDrpJx+nLd4E2xqnbh89BFCI8ihs+u/PBGzwIGix1J+S4oWHs46FJnEfC5NV47mSAQWrRZzA/LHek+ke6AcoWCzfZRmXXchNMfQCGK5V3ChIlWBdvLrneOyDvkiTPLxtLyV525WpQegM3Nt1taqcxBvJBou+c7jRZfNkSlksBf5nzNqq6tfi0CIIfh7435DKcLtOvPML5Oyr5l/1ROSGnO4jFWkd7VaoiHo9wWPH9DEASm1KEjgG1jeVCXU5dMEOAvb2DiSkYLODGBDk+mlqyD130sparKsRXQpgirnMiEemyCQ4+2q77obRIRo8sVIPoIi+j4TsvRq4gonrKKOmbRSlHhhk/+wOrgsyC6C8sC7xCU1C82XQkNcur3fAEV8iL6u/x9h66OQdf181HJKf7ZyNi8b2H/fD4QFXvuBtYEfnNqs7WAo7rZHFW3MHbB7IvoQocmMwsvQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(31686004)(83380400001)(478600001)(4744005)(186003)(2616005)(31696002)(6486002)(86362001)(26005)(6512007)(6506007)(53546011)(66946007)(38100700002)(110136005)(41300700001)(2906002)(36756003)(66556008)(8676002)(316002)(4326008)(8936002)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1dIbloxbzdpRVFVU09LcDZxTVg0VmJUNDVlMlJDL3BUZ0VMYmt3TWhkZXBz?=
 =?utf-8?B?akxJTmhlUlJrTDdmaHNMaDZDUUdRVENGbmJBRi9VNjJzN2VnNzJnWlVFcHVY?=
 =?utf-8?B?RzIvNEIwZ2lZOGlpNGxQdVhLS2ZGbVJFVXZybmtEb0p1UDl6TGxmWElsNkE3?=
 =?utf-8?B?NTNxOXNsSnFscmF3UytJSHZnb1BVemh5akRzakowZ3A5MXBoK0c4ME1XbW8z?=
 =?utf-8?B?bVo2R2hqYitxOXlHN0xrQmdpUFZqYTcya2Yzb0RNNW5QTW9HY2tIRG9BeGVH?=
 =?utf-8?B?T1NNbFd4eUNvVHZienh5eGh1YVRzdGlIRXhpcFd3NjM4RW5TNXZMOVA5bG5Y?=
 =?utf-8?B?RldNc0JiSGlxQnFoeGdHU2FpeVhIVkMwekI5eUljWTRoZGpjaGsrY3lnNVhD?=
 =?utf-8?B?UzJQRm81SGVacVNJSGpmeGpUM3l1d00wM21RckluQk52QUJ0dEdMbDBaSkpw?=
 =?utf-8?B?cVJYUzZjejdyU1FUVnhwZzJoSjErd2tuNG52STNhVDZLM0FuaC9VbW53c1dO?=
 =?utf-8?B?WlkrM0w5RGkrS25OUitlSUkzWU9Hd0RSUzdwcXhVbXF2TVZIVkE3MXlEVUpD?=
 =?utf-8?B?RzFhTlJCcmJKTWlpd0RVSWZ5T1JYcnRvQVJ0dEZ0T0NPSVNzMzZBTUFIWTlP?=
 =?utf-8?B?ZWVYSWF4U1dWaFI3S1FIN1VQWTlmT2lxMTM2UWFKbURPQTZZbU1tZk5NTmxE?=
 =?utf-8?B?V2xnQURWa2JCaVpoa2RhOTVwUXZvZGV4ZEE5VDRuS0Z4Z0FIME53VVo1ODJY?=
 =?utf-8?B?Ujh4N05wekdldHBjUVpXeHUrTmtZeFZFUFEvTTZUclJsT1lsM2tuMG9Tamcr?=
 =?utf-8?B?OFRSVG16Z3pVOWR2Q3Q0T1dpOEErWDVyUG5YUVVqQnkxeEttMzJLdnpSejZI?=
 =?utf-8?B?QWtrOVpTdnEwMkkxeWx4R1FWcTRpekIrTXNVZUtXcDdIbmtnUWdQdGQwUHlY?=
 =?utf-8?B?d2ZkVWEzL0NqbjBGUUdiUGJ2TGxWZXVSdXZZNnZxOEZyalIrUXU2Yit5OWph?=
 =?utf-8?B?bHJHSXpCaWxRMDZPM2p0b1ovOCtOOWdjWEdocEx0dWMxTHY3RUhLalFtc1Fk?=
 =?utf-8?B?c2o3SU1LVmtaRHdkNm1kT29WSDB2NWVSdEpNbys5NlhvSlRXcmVDT1gwVk5X?=
 =?utf-8?B?RmxqVzlIeFBUUlVaT2NONkVUcDlUaGNLOHVRQSt4OUc0WWJYWGxYbi9XMVpm?=
 =?utf-8?B?cjh3ZzNaOHJtSlBCSVpiTG1MNFJHeW04N01UTFkvZ0ZnY3MrYVN0bEwyay8w?=
 =?utf-8?B?WmtjL2RjL2ZIdGZCQzI3cDJreGJpWWd0M2MvU2FqN3dSQ1NQeWhSU3NGdzNp?=
 =?utf-8?B?K253TTZJOGIvd2Y2aUUycUVpSnY1ZnBZVzRSR0d4MzFLcmNQcDNWQ1VxdzlD?=
 =?utf-8?B?bHdtbEQrd2RjV3h2bEY1S3QvNW1ZNHh5ZFFOVDNMb2Ewa241WkJWWVQ4YUIy?=
 =?utf-8?B?bndTa2lNOUhneXMvNmtSWVJvd1VWOGh6ZExaRFoyNHJBTkNCZUdpeFJVM3Ez?=
 =?utf-8?B?aU1PVkxmMnVQMFNUcFRVb0pXZlJXeTRWZ0x1RG10VS9YMk9la09seTdPejZn?=
 =?utf-8?B?OERwR3BtaDk1THIvbVllN3g4MU54dEpJMXNoM2h6VkxPWWRXd2pUK0JaY2Fz?=
 =?utf-8?B?U09iVWRQcEo5d3RzU3NkdUxsMWtoYlBOdXR5QjN5WFR1dEtwVGxzRTZBV0xU?=
 =?utf-8?B?Zk4xSXJEa2JEbkJCenlJSEYrM0xUbFlJTHRqR0FJZzdyalNCQjgvZXZvT2FS?=
 =?utf-8?B?dk5iRlFpUnRWbG44SmNFVkVsOUJhdVdjWXFXQTBJbkxhTEZhK1I1TFJxRkxz?=
 =?utf-8?B?S1dtUTlhd09lZHVoZVZ6aFZ0NmRxRTBXSmVHb0Z6UDhTMGhEMjBQcGRmdGky?=
 =?utf-8?B?RWJCcG5qQ1FySFhNWDNhajhIZkVSUEpINFhDU1JUdUc4cStXSGdiSkc5VTMw?=
 =?utf-8?B?NVh2QllZd28wNmxIY1hVQlMxTzh6VWJqUUtlTS9jZzgwR1FqaUFGZXBONjgy?=
 =?utf-8?B?NThqT091aVpqTyszTjFBZHh2ekZxTUR6RllwWWxIQk9HK012L1JiMnpmWEt4?=
 =?utf-8?B?UXdTQWFwTnlOd1NXdTFkYzNkYUFTNnU0SGNLcWE1Sk1kRUM1ZW1PQjh3RTUv?=
 =?utf-8?B?djBHbVl0UkkxSWtvOVBQY0VQcFc5OEh0Sk1MKzExelBZTEhuVGxCcDhUNEdX?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2zRpEy0o0inQSlmPDKiMqIKRf4CXCONwjUqu0GZNZLrr3TgWgXHRbeMkR2KWnCPdRgNC6KXiRNLvtllLtReku1oaeZDB84gveTGUXWBsN5wH9MBfT/8YdrwZ7LGXqrsRxJn3AZItuG2a/vWUjI/VsBFeMK5dGIIETRCvDKCqUSkVdtDDo2mpNyl+AQ0DkLDcXQrWhC+31bW7K/heD/1lRhAlqKNuPx48DCUdmlO1OXvYxINbrWmHc00Z37XlF3B1ACveD+HW26ajnON0ylacnULuj3xiKYaV5SV0L2DJK+PIwc8xjL6mOXN46kVrm7JvykoMOUh2ycxnudtPoOcCsAAznKYfUjIukEnvBjY+sh0hXeO6sHIpahosHRrWDYTMZe5ZFVXrqnOxX9eMM6Ny3ZNjZXBOKH0s7CnWr0hNlyJptvILr7zxNgT7OUj5IN0oWjhAtmYllNbDtP/R9miDnfFxkGcKxm+yuVWiASIojzUB6RecXY0XBQkDxrZ4pVsV2uR6KFQZM9OiyHrLsshMFKijT4qKhPxL1NLlAngev+AjFJ/sTW2KbiPfkEPgHD4NGqDqeo/uz/2ANcxESxXYSeKnhJM8gROXNxUYYSa3cWvcVYZAxmNJXclbmMBGRv+XYtsGbKbUDtvEs3RgYLgrPgbkjEPGrpj8nuLCmgW9Z4WTZ5f2L/z68BJTqHpopwCPBjDdExABc7zZLbA6KKiti30tQOQQbumJ4B6qRMCGebVb/Zw916KgZjyOuwa4hCvgfePLvOfVUwBBs7dUSSILF5FmE4wXKbinKdV77c0YCHlclABYoR3TMxseSHSLxFYyJKdwNlLb3Jy5j9cO27D/u3Z96wsuw5B2p2vP7zURUVq06/HERU4z1Cdn3fe3eX5tkzxfgHbqGiK6qBzlBx3rHWELBqZllerJHZjympi2duw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb21f5d-1e94-497b-54ee-08db86f33951
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:25:40.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4+u8V8eX0qMP/7lv0Wyn9K0igCst0cbig8J7Nn90LNnsWhA7suUcZFKktMXQlQ8zTB9v+iKPvHLeh3INq/Yp67NO0esg8nk4XtJkA3cM/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170168
X-Proofpoint-ORIG-GUID: HnYPQ9V3sY3m_S9y33ZEgleFV2REChzG
X-Proofpoint-GUID: HnYPQ9V3sY3m_S9y33ZEgleFV2REChzG
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 4:26 AM, Minjie Du wrote:
> session might contain private part of the password, so better use
> kfree_sensitive() to free it.
> In iscsi_session_free() use kfree_sensitive() to free session->password.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/scsi/libiscsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
> index 0fda8905e..2f273229c 100644
> --- a/drivers/scsi/libiscsi.c
> +++ b/drivers/scsi/libiscsi.c
> @@ -3132,7 +3132,7 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
>  	struct module *owner = cls_session->transport->owner;
>  
>  	iscsi_pool_free(&session->cmdpool);
> -	kfree(session->password);
> +	kfree_sensitive(session->password);
>  	kfree(session->password_in);

You then also want kfree_sensitive for password_in.

I would also use it for the usernames then too.

>  	kfree(session->username);
>  	kfree(session->username_in);

