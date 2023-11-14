Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7C7EB77E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjKNUKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKNUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:10:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D211172A;
        Tue, 14 Nov 2023 12:09:31 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEJnfEB006540;
        Tue, 14 Nov 2023 20:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G3PZxKmrLghLGSFx6l41PcTw5xVh1nClqyAiD18piVg=;
 b=P93V4kXtKryAdISWs2JZqYpBNC+NO3J+Jrk48yoq6KR/Xz1quvfC9lvIR0hWFe4wQfep
 t7aRrURpmWEuP/09mWPJf++gZSWBeVwoDyLhuvFQMO/rGb4ju1h5YRSaIlZllY6L+yS6
 Zyh7KVlieF2OAGz7mh7eMqX/fEr9XcNH+QnDZeHH/T/sakU7Bt2KujbYvb8xMpsNxAZO
 jhE6mza6kCuoHsM+XTH583hITudVi8bD7pxUsnZkxjd5f2KLpftG+poB1rcMZSuPYqJd
 I0Xwl14JUOEufjyNom6Gcy8RorIXLbBUSVoElEpisZkGi+9MRVEdyAyRLLLF7Cu6j9Pm oA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3eg2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 20:09:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIkC8E003921;
        Tue, 14 Nov 2023 20:09:23 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj2mawc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 20:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+onZ3ytkjzSf7O8tGfekbJiHrFEdZ3e+zT+ofGJqHMYaAen6M5JN4/0Rchh3ax3mpRfIzW5zpBEJ8WLHfxZ5VUCcM5iyVm4X2CS4ALODQGnYwj1m51qc0ZkWGVRQ//iphRZ5qh5gHkDAdWBjO2D+Kt8vWGnfZ+LeWopc6QSI38ZVnNr70uot79ZGzxfqaAIjPrJ+Ru/v5Fuz75gxMHA/q/B5jWORQbeEblnRK4GypJ9ykHg8/UgdGb9kwNt79FUduQu2PZ8DqVDjou9GgLE45Os4aywpfg9lK8oFt1z1gRHYlmS+RFg75B2eDVhGbqSqJ0OhaOTAVwtWxZFMIK+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3PZxKmrLghLGSFx6l41PcTw5xVh1nClqyAiD18piVg=;
 b=ZLirTBP28uBCKXCq3ajPZ9g6be2egUF08Jfeo0NzoJGiUmWH2F4iqAEkqHLs45GueHLY+fFXHogy5mt1PmIHMlteIVE9ac9Fb3YYFxD27o6zFgXQxjj3AH7+zICytHD9rLLc+X9Qna4rihbhWREMVXGj0r02RN/0IGMp/deye14ace4oQ5Cw5wLpu3XnxrcAIvAIpuQZ7L2fa1UBKuCc3FtWq/VfveO/X1nX4Q1ZaJ56gKEgyfziQj5+rJkGdCso4KW9wCL9ThFJ48TqH6GCRG+MNTUBcurDTg3nGjj+TJT44TOJQ9Jh8mwwPl2PXyOD/ANUtgcxHmEvhBgBMFgtBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3PZxKmrLghLGSFx6l41PcTw5xVh1nClqyAiD18piVg=;
 b=G5Otg8XwhqjmFy8jVAf3lBHC1cdvh1De5+U+pb5yhPuqFcWbBwS/dPdFT+C9ZnxzvjGKVqAZPuRXBSZ3I+lRY5GYee3vW7oR5Sv8lYlf8QgxE+JsZb0a15A8BbMv2SN/55DdwGlsfxy2gfAOEhPyWN3qjQzsMI/eiBXgWzaZ3GU=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by LV8PR10MB7990.namprd10.prod.outlook.com (2603:10b6:408:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 20:09:22 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::baa:8a05:4673:738%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 20:09:21 +0000
Message-ID: <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
Date:   Tue, 14 Nov 2023 12:09:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
 <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
From:   junxiao.bi@oracle.com
In-Reply-To: <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0002.prod.exchangelabs.com (2603:10b6:a02:80::15)
 To SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|LV8PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da39f1f-bdc4-4829-44ae-08dbe54d9756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXJwfs3v2G3Kw1jgbeOKgbslBc43Djeu4/n6XcUk6QNURRUUXW1/xzghm2Lr7HI/qmasv7fNp4+84/H/pm2RQwbAWUlUQolCq/b1tLs9v0nB/PeBzfCNWPjM03lTW3sWEDc6eBfoAjrc4rB9o+j+tYvb7j5TVGhQeFi02Yds4ExUo+gPUPlngiQO2jH8CCG84bPy8M8nXLYE5rOa4XDsG3D4iA7/qQlMHo3Ymr26fqd2UMW9ai4IrBZyImLsazjihrmf97Ln0FAEO6JJIgozCCbGxK9vteeSi7XGSaz0TENpgwF1jN+aK0U6t6383d9q0XuTKzAIM8I5L2LhJosrd9y3fGXvGMNl5Ptpps7usly1RCHb9kBw5hE/M/H3novwue8BNmPnCXMI3n+lF+6t222Quo4gXtpgbzXgDUxNcYOZf+kH/kr2xJK07OGmidvWaOupyq+9lxCeA8oES0SqGjzooOsjlzFQCsvn+7w+XrPJwmUSgJq/448jND1p7yJDHvA4Y5VqN0jOw0m3Nya6/yvIHWFb1fVZqu+bhGrMotPrSRhDQ1PrM7d4V82I0JDfwALJmnAL6rRfsGfAo8i+Oyc+icmV/NpGba/Iq5IF8uaYtCRUutGEzGYONfXIqdl+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(41300700001)(6486002)(6916009)(31696002)(86362001)(36756003)(316002)(66946007)(66476007)(66556008)(478600001)(2616005)(5660300002)(2906002)(26005)(6512007)(9686003)(6506007)(53546011)(8936002)(4326008)(8676002)(83380400001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODVBRTFrV2Zrejk3UjdEQzJ0NWRodVZ0ek9zSW0wU0tVK2lad3p6QktmNHBK?=
 =?utf-8?B?ZHB2ejBFcVp0QWIzMkk3NERvRWVWS3RQbXlES3dMQW1XYWFCUTJWTGhBV2w3?=
 =?utf-8?B?ZFV2VEFrRnM2RXpBQkVtWnZWLytydHAxcEhRUUo2d0VKaE05M2RhZDhJVTIr?=
 =?utf-8?B?VzRJRmNraW5JMVB1TkdKdHptVE1MSkczYm1sOGtMaDFyMWwvZjJkVUJzQTEx?=
 =?utf-8?B?STJuNzJORkxrOXdialNxKzcxSXVEbElISlJ1MGJxdVdtWjdkQXBiWG5YRjNo?=
 =?utf-8?B?TnpodXoxWngrbEhIR0hyQ09pU1hITVJzUVY1KzlJcEIzcnJsVHpaT1I1d0pL?=
 =?utf-8?B?czFPYnRGU1k2bXpXSVB6ZHhnQjFpNWZyVDhlWGw4SkUrbG1uUktoZERheG5T?=
 =?utf-8?B?ZzhVdmM5OUJGOW1CaVBaT2VSMStTV2FySUNSSVNvOElNUUNWeWhVVVY2bVJL?=
 =?utf-8?B?UG82aks5OUQ4UDNjOGZhcy9seWhNb3liSU85eHl1dlpLQ0ZNV1ZhNE5MY3VR?=
 =?utf-8?B?dko4bFBXblYrbUJxMWJabGhQWkFHL1dJZUswS05veG1uZ29POFAyYi9iSC9v?=
 =?utf-8?B?OWJyQUN2OHArM2VvVE5OMk9rT3Q1eC9jcDl6dnBhMGdUQkZWNVA3ZEI3cFpu?=
 =?utf-8?B?VjgyRDEwM0dtY1IvaXFpNjB0L2R0aHI1QzUyYVN6VkZ5UUtIVU5aeU53TW5p?=
 =?utf-8?B?V0EzUWIvNlRIREQ1NnV1L1JGbUpKRHZDMmE3bk5uNHVkT2RzM0xjcXNPbEV0?=
 =?utf-8?B?YnBRenhNa0JGR0hLUTlnSitpYklIZ0JLTndHN01VVDdxUTRIVlM4dWV1bjBX?=
 =?utf-8?B?L0tWaElTd2YrWEp3cnFLc2RWRGJ0NG1LUVM3emNSN1FFMW9tU01pbjFQMDBz?=
 =?utf-8?B?VGxxRVpDTlBQanJSMndlVGFhakFwOW4xc0JjZzlRN3lsY1NwS0J4RGI3U013?=
 =?utf-8?B?M0twVmRHbHVkbThYaUc2NWt5UXF2WUdjMHg3WG9RUjgyY29kOVh2dVRUckhp?=
 =?utf-8?B?TVJDYW5UbTQxZW0rcGgwNTVjSDRSMFV6OG96dXY1TVlHaGd2TUJyL1JtSURQ?=
 =?utf-8?B?bUZYQ2hGZ2Z2UkpLbGhldlg0b2IySlZkRmNWK0g3c3B5V3ljemtTWnZFMjBi?=
 =?utf-8?B?TmQxS3BhaHhxOEg5cDJEMG0yWlN6Mkt5VzRZcW0yYWk5OEN3a0R3TEFTSDlw?=
 =?utf-8?B?RTF5NmNDZEhvOU1seE81MDFXdXRLbkczNU5YQ2trVTlwVEJMODJuN01ielNu?=
 =?utf-8?B?NDkyTjVrbG5ma1NtN3FKV05aWW5SeDFxTnBPRTR5U1VWeWUvcWNlSUFvMC9Z?=
 =?utf-8?B?OWZzS1ZXZS9lM1MxektxbWM2R1NKdlBuUS9USXVLc09wZXhzTzRjcHJBUXJj?=
 =?utf-8?B?Q3RicEx1T2dNSHpUa2x1RWNLa2dXNEJEL2JacjNQRDR3VDRKVkRHamtHZCtG?=
 =?utf-8?B?M3R6ck53c0tKcEhuRXBIRVRZbUtLdUdwU1RvaWwvdEllSXd3TUJuMVdaVjlz?=
 =?utf-8?B?aFJ4cXBza3JXZDc3Zy9oS0themRUdjlWY1krU01xZkdrV3pYT1VVbGdiSkpQ?=
 =?utf-8?B?emZCQ3VFSnJwUkR3aW50RURyYWlXQWYzdjkxOVBnZlNkRi9IYVg2TmhobGgr?=
 =?utf-8?B?K1pGaExIeTg2eGlEUGZzZG5MajlvbExCWFRxWjlYSE8wWGhveGpwV2RycEZw?=
 =?utf-8?B?WmdSNE1jTFg4R2lhbStQUVdENTN4RkJHaXg5Ni9kSzFWZXFScDArTGFKNTFr?=
 =?utf-8?B?OUJiTDhCR29mbzZrQXVGNnQwc2ViVThQL0VIV0psN1Q3RlFYdzFWNm9MMEFr?=
 =?utf-8?B?Y2RiTnpDTnF0c0s0ZjViQ04xU21LbzM3K2FXY0FwYWRuUFhyL1lCSVRjN2Uw?=
 =?utf-8?B?TVVKd25YR3V2MU94NWw1TitvdzU5ZmFrL0V3SGtTNHBlNGEzbzhJY1paaC9J?=
 =?utf-8?B?YVA0K05rdlpmZ1B3MlJ5MDVnNVV4YklqTXZFdGZHK2Nub0lNRkh1NlhTK2Fi?=
 =?utf-8?B?a0pNU0orZE9ZTUJiMDVYNkdLYUlabXByb3JEL1ovS29QUzRkSHJmajQwVXNk?=
 =?utf-8?B?MzREUkg1SVVlWUVSVnZ2d3cwdFdkWjhNOVZ4NXo0QWlDK250dXppVHgwY2Nj?=
 =?utf-8?Q?dHD9ilBfIFzOPmrCq93UuhmX4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8XLjNXaiNpYzWUKjsgShgcbQl0iVHCAc92KV99tHE7CfLVfU5hqu0ZH47gEu6/OWr/vKc0sQN0zA5hTh7z/SmI+O0HDAXTb/NhFBc5RRCmFxSQYdcw5IyRIBizclnFO/kqlL2RZSvC/8r8Sl7ceSefLXyT9zfljJsbPs3SBiRVmoDfKaGw83P6bwI38CdVvws0tK6u/OaHg4+0i6u6O/yiSvpeFwXAZY1l9WrANwIxO3wuacGbmO2liximA5YvU4KnDHZnK8WCvLfxECyf245Y2WG4Rm9siJze8eIoshjnJ2V7uSjE4y3R+l95srZ81pobhKqwjTwsJFVWfLlv5akpdl8zjpD1HD2FwhBrwL4DxaJvWudCC2px3s+beNPyTVYAbsbyDHWYYEkoPmOdGYk7Ma/LxyvBVecOIeENE9VroBHpnA8wppDXo3T1i/05fC/jTRPbU+g2qRB6CmXM9+1mU3pCt7K3yT1av4onOGwkOc8XjD956407LRDTTysG1VHpQNIAVhutn5ArHjLhU42mX43sQ+u7SrDFOgbXH08lBw9qhmxSOEiIy6ghVxBbmCZMk18NJOIC0BAhrppXKL6kNmvmxJd3CDlIvstB3IUer5PrwzX4VojdQk8AEgnVIUnEunTcwPCPztHv6OmYvTW9Hps8cbcIp6ADcqRkg+IFpMqnUgtdCZZNWP/zTtm7TVvNY4roe5Y8cuGtIxuccHSFbbHtpvJzSnc2pgiBi77g8b/lglZRsnkJMPVhaBvbKdE7yCOiGc4IePVwobZcxQDjL4bIUbnyo6Z4TnhXgO3z4OjiI8f9B0eo3BRM0+G6/rtCgGZT4dAHXxYOfM3XyhJTUHHD9vGNlKjiYyCZnZ88c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da39f1f-bdc4-4829-44ae-08dbe54d9756
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:09:21.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/nK+P8+7xRpJJZ8bkhZp9wQ+GdHEFTAPBtBHgI6Y9q1yGv5FVh3eH5rTswkLuCL0VDVXUf+xGoffKUaw2tDPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_20,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140152
X-Proofpoint-GUID: Gta_sXMj6rjJCh30n6eXUlhC9Wcke4eu
X-Proofpoint-ORIG-GUID: Gta_sXMj6rjJCh30n6eXUlhC9Wcke4eu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 11:06 AM, Tejun Heo wrote:

> Hello,
>
> On Tue, Nov 14, 2023 at 10:59:47AM -0800, Junxiao Bi wrote:
>> kernfs notify is used in write path of md (md_write_start) to wake up
>> userspace daemon, like "mdmon" for updating md superblock of imsm raid,
>> md write will wait for that update done before issuing the write, if this
> How is forward progress guarnateed for that userspace daemon? This sounds
> like a really fragile setup.

For imsm raid, userspace daemon "mdmon" is responsible for updating raid 
metadata, kernel will use kernfs_notify to wake up the daemon anywhere 
metadata update is required. If the daemon can't move forward, write may 
hung, but that will be a bug in the daemon?

>
>> write is used for memory reclaim, the system may hung due to kernel notify
>> can't be executed, that's because kernel notify is executed by "system_wq"
>> which doesn't have a rescuer thread and kworker thread may not be created
>> due to memory pressure, then userspace daemon can't be woke up and md write
>> will hung.
>>
>> According Tejun, this can't be fixed by add RECLAIM to "system_wq" because
>> that workqueue is shared and someone else might occupy that rescuer thread,
>> to fix this from md side, have to replace kernfs notify with other way to
>> communite with userspace daemon, that will break userspace interface,
>> so use a separated workqueue for kernefs notify to allow it be used in
>> memory reclaim context.
> I'm not necessarily against the change but please go into a bit more details
> on how and why it's structured this way and add a comment explaining
> explaining who's depending on kernfs notify for reclaim forward progress.

"kthreadd" was doing memory reclaim and stuck by md flush work, md flush 
work was stuck by md_write_start, where it was waiting 
"MD_SB_CHANGE_PENDING" flag to be cleared, before waiting, it invoked 
kernefs_notify to wake up userspace daemon which should update the 
meatadata and clear the flag.



PID: 2        TASK: ffff8df829539e40  CPU: 103  COMMAND: "kthreadd"
  #0 [ffffaf14800f3220] __schedule at ffffffff9488cbac
  #1 [ffffaf14800f32c0] schedule at ffffffff9488d1c6
  #2 [ffffaf14800f32d8] schedule_timeout at ffffffff948916e6
  #3 [ffffaf14800f3360] wait_for_completion at ffffffff9488ddeb
  #4 [ffffaf14800f33c8] flush_work at ffffffff940b5103
  #5 [ffffaf14800f3448] xlog_cil_force_lsn at ffffffffc0571791 [xfs]
  #6 [ffffaf14800f34e8] _xfs_log_force_lsn at ffffffffc056f79f [xfs]
  #7 [ffffaf14800f3570] xfs_log_force_lsn at ffffffffc056fa8c [xfs]
  #8 [ffffaf14800f35a8] __dta___xfs_iunpin_wait_3444 at ffffffffc05595c4 
[xfs]
  #9 [ffffaf14800f3620] xfs_iunpin_wait at ffffffffc055c229 [xfs]
#10 [ffffaf14800f3630] __dta_xfs_reclaim_inode_3358 at ffffffffc054f8cc 
[xfs]
#11 [ffffaf14800f3680] xfs_reclaim_inodes_ag at ffffffffc054fd56 [xfs]
#12 [ffffaf14800f3818] xfs_reclaim_inodes_nr at ffffffffc0551013 [xfs]
#13 [ffffaf14800f3838] xfs_fs_free_cached_objects at ffffffffc0565469 [xfs]
#14 [ffffaf14800f3848] super_cache_scan at ffffffff942959a7
#15 [ffffaf14800f38a0] shrink_slab at ffffffff941fa935
#16 [ffffaf14800f3988] shrink_node at ffffffff942005d8
#17 [ffffaf14800f3a10] do_try_to_free_pages at ffffffff94200ae2
#18 [ffffaf14800f3a78] try_to_free_pages at ffffffff94200e89
#19 [ffffaf14800f3b00] __alloc_pages_slowpath at ffffffff941ed82c
#20 [ffffaf14800f3c20] __alloc_pages_nodemask at ffffffff941ee191
#21 [ffffaf14800f3c90] __vmalloc_node_range at ffffffff9423a8e7
#22 [ffffaf14800f3d00] copy_process at ffffffff94096670
#23 [ffffaf14800f3de8] _do_fork at ffffffff94097f30
#24 [ffffaf14800f3e68] kernel_thread at ffffffff94098219
#25 [ffffaf14800f3e78] kthreadd at ffffffff940bd4e5
#26 [ffffaf14800f3f50] ret_from_fork at ffffffff94a00354


PID: 852      TASK: ffff8e351fc51e40  CPU: 77   COMMAND: "md"
  #0 [ffffaf148e983c68] __schedule at ffffffff9488cbac
  #1 [ffffaf148e983d08] schedule at ffffffff9488d1c6
  #2 [ffffaf148e983d20] md_write_start at ffffffff9469fc75
  #3 [ffffaf148e983d80] raid1_make_request at ffffffffc038d8bd [raid1]
  #4 [ffffaf148e983da8] md_handle_request at ffffffff9469cc24
  #5 [ffffaf148e983e18] md_submit_flush_data at ffffffff9469cce1
  #6 [ffffaf148e983e38] process_one_work at ffffffff940b5bd9
  #7 [ffffaf148e983e80] rescuer_thread at ffffffff940b6334
  #8 [ffffaf148e983f08] kthread at ffffffff940bc245
  #9 [ffffaf148e983f50] ret_from_fork at ffffffff94a00354


bool md_write_start(struct mddev *mddev, struct bio *bi)
{
     ...

    >>> process 852 go into the "if" and set "MD_SB_CHANGE_PENDING"

     if (mddev->in_sync || mddev->sync_checkers) {
         spin_lock(&mddev->lock);
         if (mddev->in_sync) {
             mddev->in_sync = 0;
             set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
             set_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
             md_wakeup_thread(mddev->thread);
             did_change = 1;
         }
         spin_unlock(&mddev->lock);
     }
     rcu_read_unlock();

     >>> invoke kernfs_notify to wake up userspace daemon

     if (did_change)
         sysfs_notify_dirent_safe(mddev->sysfs_state);
     if (!mddev->has_superblocks)
         return true;

    >>>> hung here waiting userspace daemon clear that flag.

     wait_event(mddev->sb_wait,
            !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags) ||
            is_md_suspended(mddev));
     if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags)) {
         percpu_ref_put(&mddev->writes_pending);
         return false;
     }
     return true;
}

Thanks,

Junxiao.

>
> Thanks.
>
