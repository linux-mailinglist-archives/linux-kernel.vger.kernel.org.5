Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883627E438B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjKGPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjKGPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:33:14 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5147DDF;
        Tue,  7 Nov 2023 07:33:12 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7EX9tt013545;
        Tue, 7 Nov 2023 15:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SFPUq7f+0NyhzNhfWSab58boA5w85Tdnw8txKqoCglo=;
 b=Xm4ygyF8bqw9QYI+aw5GLl2KjFfo2fymXnpapCDO2YC0PkVwndWJBnPSO+Y4joO8K1uz
 /e5xjVPveWY1tlY0b2ioICA79ltQbR1p3sTOEQPpsAps62Smuo4xOAbfYcgMmlJd3ceu
 A6fQi3WAQBAl+bYcDDOGzzfK9LVXCWuHuDD42DI/y50ou3j+eUzXWLqMFUrzIgWTf3GB
 +/Z9RWdaXC/5J0p3oIUIR6mpZDobbK1XuL4lO90aRVQuvYOVUgjy2ePgY9FAwddUqnOB
 Ddb1MgnM1Ys89cnD/LfrdDudZPrL8SNfXc5EyJ328Zpfg9I+lDQ00fY5RbSp/tf/KwVi 9w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5ccdxbp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:32:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7Ex1l2030484;
        Tue, 7 Nov 2023 15:32:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd6rc73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bit0DLMxlBuyCZJ8z4wW3RAk+GSSvZ5vb7dTM2uBclvRY64vbiydKFPAtzenFSc7n7bQsNMJPoxDAj5RH6Heq/nU7oDaLCf2yYPIeoPcJHkLP0dB7gLyxSE+53XLPYTuwT5djsfDJcgc3zKZgPHsbWmyTS5uIzzdDzITiBzp3LwyBnMFjpBvvLF5T5ybLP1yb/wyvuMjKYnvXCiLZ2X7ChY3j8GAd0ek2ObbzeCugxBaG/f1tha00HVo07QFvMiGUjdDSCZmYRM3XRZzNnr+s4sK1/qi60pnpm1oZE6c9UMSNz+UNn8lql6EDhtlPgb5bS/2T5ZP3wkRAgVp2lui+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFPUq7f+0NyhzNhfWSab58boA5w85Tdnw8txKqoCglo=;
 b=Jzc+PXhEYAjO6XcTJ570ehWVsqgbvhqg6avtNpb//AgBj+hkA+QmxDpjQ9PRrVLaMEeEKdrTeN3IZFz3kuCRYpm7bNnyWUwE+/d06p8wJ19Tl5sFN+vN1OZG6mPOUWQl8sF3k5/UgzDJ6Z58rAeZ71/o5fEEbIGQc+eXVXTezawfxtsGKze3ulQjaPratNSRlTdAtJPDB0YElKKh/Gzc2ESNqSUqz+DwEckbO/UCfZ7AvuDBzrOcQQ6XWgARMUKPbV3hqy8yaaOIulRIK/snSakHIl0gt4nszSf+c8nWL3jQ057uFux6bj82dgvSa6zKu60/DneLMcIgPOMbwSqRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFPUq7f+0NyhzNhfWSab58boA5w85Tdnw8txKqoCglo=;
 b=cH1lqmUdtKd26MQgYCS2jG6onu5ldm0HMCRnygouF8MTy2E5GKte8F1/mVrMd//XRBD5EaOS+y2N4peECuaBHpJSbAJf3pv4NM8fEXItuEhuEw2CXPSS9swFACpNc2eyb7wNZV64WK/cbT5n/N6kVvbllw2bzKywbntCoAXRZOQ=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:32:42 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 15:32:42 +0000
Message-ID: <6df73f60-1ed1-4c53-a924-6828c2386ded@oracle.com>
Date:   Tue, 7 Nov 2023 21:02:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/48] 4.14.329-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231106130257.862199836@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231106130257.862199836@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SJ0PR10MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f45078d-c422-4b70-8ace-08dbdfa6bce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+c6vxFbf1kKyKfcyk8RgV8bFs8fGgGQ5/3nzaS02gG9BJnRcydoj4m3JhnUGzSj2f9AdjTbH0coMqPuo2cq7T498LB17b62YcCKemmLM2hHUiUsWAdZWD36TClIHjez5/lfSJJwkbeelEIRBmHkhtwiT8V95uqC3AcsgEZPdh89ywq6hyyND6Kqq1E1FraqJ+vLGz17fZRNz4rwA4P07IoR2mOP6H6ZVjp6eLfcY2d+Wc1OkqZ0T40d2j+Ir9LWMQ8cAJhdwxfB9KPt9D4bQQGCIqbLk5Kzs7gNNCRZhs3cbIzFGpQ0zLMsaEPon+uVOHtqiJD50cwjd4RQvmLqbH+JnH9bArIScITu3IG6DEBGyuPwkSuI1re8RrLpvOzSTggUb5I7AaUh8/EC2hk1yxoCzjsGWdDOgQVVyI2Ala75pCqg70fCK950ZFZGwYJ4Y6U85JrsOmznnCuy5XSMxU9vRJP+yb7h7wqiASeuQMQoQl6Y3INFJ1ACq1f0nTT8DrFsJk0cD/bUzz+2By2LjfzdY5532zYDDW3QnZGeaeDxyAn68SsR7JdPLiCUZ99FiPaWwZZ5GhOKw3qGY01pRQPKoiOpMFbcOuAKIVvDCSZ7S+MGLxBkOLkSFazrWaIVAMqjz9fmriAtrhdF4KZC7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(2616005)(53546011)(6666004)(6512007)(6506007)(107886003)(26005)(6486002)(478600001)(966005)(31686004)(38100700002)(66556008)(66476007)(54906003)(66946007)(8936002)(316002)(4326008)(31696002)(5660300002)(7416002)(86362001)(2906002)(4744005)(41300700001)(36756003)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmdvQnNXSHRYNis5REtETGlsSDh0ZzBkblNFSFQ5UmRDR1ZLRmYyWk5Pc2pU?=
 =?utf-8?B?UzlIdGpGcVpQZ21Ba1diTHpEN1pmbGpiNGFYcExUb1o1M0xpV3c3UFRSWERh?=
 =?utf-8?B?YmQ1bUhvQnNIRkZiWEhTcWxEMjFsVnpoZmI5OFJxOFg0VnM1RU9TbVlCNGFJ?=
 =?utf-8?B?Qkd3WHJVZmtnQlV1d1pyMFlFcU9ZQzg3VWdEeHFZaDU4Q0tBMUozTy9oWTlh?=
 =?utf-8?B?SHphd21ZWTQ4YklqTjgva0JCQ0kwdk5mOGUzMlZZMEF4S0xBQ21DQ0VJa2Vn?=
 =?utf-8?B?WUdVUUhqQk54WTg3OVFZcEg4UlFydmRRY0JpV2l5NHhHdmVaK0R3SitZZFl4?=
 =?utf-8?B?MjV3MURQaUE4YUV2Tm9Mbk9BM242V0dBREYvb00wSFI4c3Nma0dvR3c2akNp?=
 =?utf-8?B?Yi9JVWQwQk9iQ3d6Sy9yUzdHcTdjbmNIQ2h0bzJYLzdJK3c1aTV3emxOdGxO?=
 =?utf-8?B?elNYQ1pobGhZUmwybVM4M2hiWTdGK1VDL2d2a2RqU3hSRHNucjdBd3dFQjJj?=
 =?utf-8?B?QnRsZWZ2YmdQbzFMNXhPS00wN1BDcFRHM2FsVm9zZmg1ODAxekUrb2xIQTZ3?=
 =?utf-8?B?ZHhYTTZzaUZvai8xdENsakh3WGxoanJJWDhrSFF4bFBpdVJJOEl1ZEhqQkxM?=
 =?utf-8?B?WDlrSjhIMW9tUHZtSkVrQTZhVWlJUTdyQ3VTSXpIR2JoTFUvN1FEUmd6UDht?=
 =?utf-8?B?VXRJQU1XdGxVVEJ3OEtObkZzTlhId3Y3ejBHN3ZJRzZIRWdSUGlDZTV3Q2JM?=
 =?utf-8?B?L25kbU5lUnl6eUF3cXRvODIyaDE4TzU5NFZWV1lQOVlUOWRMU3B5cUNiMWtL?=
 =?utf-8?B?TUhSdytYcDU3ay8rYURLa0dReEhaVVhyL25GN1Q2MG1oQU9yT1JJLzJDWDlR?=
 =?utf-8?B?ZStRNWpORlJwQkNzRXQvdTluY0kzR21Mckd0RGVwZExaZnNrTXZRT3ZkTTA1?=
 =?utf-8?B?aTUweTladzEvWXkvNlZSNXh6R1BNK0xKY2tUeEprOFZtbnp4bzRHRzRLcm5w?=
 =?utf-8?B?aDAxSEVZYXNaOUhGaUMwaWF1SGtPYVZmdWFwdjJjd2llb1d6WTFCaEkySlFN?=
 =?utf-8?B?VW9BVG5wS08yejRhK0E1KzNRMzVZM0kvVVpYM3Jobi9zSUhzT1lOc1l5Zm56?=
 =?utf-8?B?MnNOOWdLVVprQThtR2dFZDNKWlNBKzlmQVk5bkczSEVkREtabFpsTFdTZTg3?=
 =?utf-8?B?TjdOYitqTS9meVl5bVpaakpxSnpCcmhKRXBnNlBRWldVaUpiZDdNQUZ6REtN?=
 =?utf-8?B?Wk4vdEcrWDZYMVJxWWFtWmNNZGRyTTN3OUt5ZHd2bmVnOC9GSGRNUzVPMmdL?=
 =?utf-8?B?a2ZUd3lMU1N2aXhYbTFhUGxCMzQwNlBQVXJ1VjY5cENzb3JMY29RRjVtTzYz?=
 =?utf-8?B?bHRtb3hjSDFZbWJqVDVLaFZQVUxheXkyRVhzOHJ3eFQ2RG10SFgvNVlwZGV4?=
 =?utf-8?B?UGpiUHlVcysvajB5N1A1aEEyb3hJdUo0ZTVHZnkzbHUrS0dzUmVLZ3lEMlBV?=
 =?utf-8?B?UDRvb3NXSWFiLzA5Mm5OcW9qWmhFZlE2akJiNlFKcnZFVU1IUEdVWG5DaUJa?=
 =?utf-8?B?eWVXdlF1d0VUcjkrTHB6ZTNoRXlqNGpkUDhBZkx4dGhmZk5uaTBIbUw5ZWxr?=
 =?utf-8?B?MUNZSDk2aXFOT21weW9oR1lBclRJKytlcGl6Y0ZFcHdxcHNrMU1kLzBBaEpZ?=
 =?utf-8?B?WVhnQm01Unlub2xKY3Y3aXpXSk9aQmo5N1JQajBBaGNZNjVuMXhkcGRPWGV1?=
 =?utf-8?B?ZmR6OE5yeGdVLzIyTW9oRSttc3docm95QjVTSmZWK0RtOEYyWS9VdjY1V05w?=
 =?utf-8?B?RFhNd0dMWjY2M2lFS01NNDZnR2NlTFZsT29UYVJQYWN4WUFUSjhPcmVJRXZi?=
 =?utf-8?B?SS9KVXV0M0lhTXpGYXh6aTNyY1R6cGxOYlVLNk1JRzlLNU5TdlMrZVQ0K1pL?=
 =?utf-8?B?d0h4OHNKbGZxYlRmbVdla0swTUFnZE9NOWJETENlZGxoWm5KbmljaFRYOStn?=
 =?utf-8?B?RFVHUXlXMmJFcHJsUWNZUDdDQ0ZYUjJZYmpyMjcyMlNBcjNxeWRnakRqRnlo?=
 =?utf-8?B?bjBGdW5RRUxiOEJpdncwYXlRcVFjWXR3T1ZGRkJON3VrT0NmcDhaUWZmcTRE?=
 =?utf-8?B?c0w4YlovSFc0dHlrM2szdWYvU2dLUURTamRiKzRUOElqVUQ0ZmxLdG0ycjBo?=
 =?utf-8?Q?/9BRgwVKkKIa/QPOyqCXrZ4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SzRCSndDVVJaVHBBR3AyRlpWRUpjTGxkeDB1UTFuNHFFZzJvTjlTT3JETFFk?=
 =?utf-8?B?OHQyUTJnWDg3bW9OR2sxNTkzdDZ1UGtRWXk0Yk9oNU1EU1JCa0daK2xnbnNk?=
 =?utf-8?B?OFFPcmtsbUN6K2FsOHJCRk92aEwrZmtsTXNOY2hqRUlIQXlkdms4NzFHRzV4?=
 =?utf-8?B?eEtkaWtVdnNKYzMyb2JCaitpWjBFTzBPRlc5L0VvanpMQmNURThocmUrNlFJ?=
 =?utf-8?B?Uk8rMFJaNURSb0Qxak9ZZGhySjJDWnBPMUFva2tjVU1LU1BGelBTVlJTVFhG?=
 =?utf-8?B?OU8ySUluRjdsQUoySTAxbm5wVzR6STU3YWs3M0llUVR2V1RVWVh4YzE5WlBZ?=
 =?utf-8?B?UlY1N0VjdW1lakFwbW5FT2lyOEhzTVp4UkdhUWErV3Voa2hGa0tIanBSSnM0?=
 =?utf-8?B?WFRzK2pGRzFSSVc4WE9KNXBIV1RHdUJlemRFRU1WNGNTMWc0WklYZXArbnlC?=
 =?utf-8?B?Vis3ci81U1pvYlNWYlh3emkwckdIT1dRNERCOUhBcDRnSkU5Z0srazVZQkxP?=
 =?utf-8?B?cGt2NjA3dXpzdm1ndFJQZzFrWVNrWlY5My9JN2tuMjJPZ2d2MDF5OUhITTVV?=
 =?utf-8?B?N3psVVU4b1BKSHZDQ2pVQVVlMHNobW5VajA0dFkvN1pIYVJCd1dRVm1DREh0?=
 =?utf-8?B?dmRuaFdJS1oraDY0b2h6OFBuYjR3c3ZLSmJGRGI4LzFucmpwVG1TdXhtYWpv?=
 =?utf-8?B?cFlObjF5c0hpKzgzcEJyYk53QlNnUi9EK3k3ckFNeWdmemhWZ0RVYytYNGVN?=
 =?utf-8?B?ekMyM3lrOGVObyt5RUpTTWFJYVJ3MHJIN3dObktRbW5MYWF0RFpGVXQrT01n?=
 =?utf-8?B?OGswSlRSSjRLKytQWDV2SEM4VGpzQ1cxMnZ3aUtxYWtLdmsrcnpzUzZGRStx?=
 =?utf-8?B?dWplY0hkaUltbGI4MVRvZlZ3YnRURzViNm0vL3ZPTTU0MEJRSkh3MUR2UlhY?=
 =?utf-8?B?NlB5L3pWaWtEbFNUYmtmN2FOcHh6YjN4cUV6SXJrL1NOeHhySWRJa3M3eWxv?=
 =?utf-8?B?NVd3YitINlpSVFpVOGRXM2JRRmQvamZpRjMrUDF5K04rQTNtNHZmT3ZzcVY5?=
 =?utf-8?B?dHNaR05WM3VKZ0V1bnRoVjA0TCtGOGtHdUZkdkhVT1l0MC9ma3FSSjVoWjNV?=
 =?utf-8?B?WERqLzdlaStlVWVaUGU4blY4VlE1amdCMGxxeFo5ZHpRN2syeFBaajdmUXpp?=
 =?utf-8?B?aVpwc1Mxamdmbk82WFlkV1R3VmVCbTVReGZrLzFvdGtsTlhnZGZNRllaSlpw?=
 =?utf-8?B?WXdDQmVmdkg5aS8rZlFxN2VXWVBPZlI4UnpTeStHTXdKZ2F4empSN0hadUpn?=
 =?utf-8?B?QjQ1UWpTZWxzK0FRaiszUllxbmE5a0FmS0U2WENzWS93SVVHVUh5OWY2SnJR?=
 =?utf-8?B?cTlLcFF5c1JtcU1mOHRGZDJZd01CZ0dxMVdhcVN4VnNvd2pvZnpJZ2xHNjhV?=
 =?utf-8?B?WXdHQnpER1RPR09iYVJPWlN1dmU2d3VaWnhTTWZkZ0xUYnhKbjU5WGxCQjR6?=
 =?utf-8?B?TU1WcUtrL2FQVkhxZWJZQ1B2NDF2TVhVNDZ6TTVLWXVpMmczeW5vUHRxL1Y4?=
 =?utf-8?Q?mTiulg7VrtWq/ooSxI2rdI1u/ZpHSn1P224i9JXkSbwYoH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f45078d-c422-4b70-8ace-08dbdfa6bce5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:32:23.2504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0YEtQN+6j5Do6+PpwizeAtsIQlbywKVPUCOaPHCg3TxacpJIpN6DS+v5yN12dAm/Ok7tYPw/5/DDtPM45/yaD70ylCkyySDLlu9Sb9Iz2BbsuhzDTkWSPqsVYLgkMQK6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_07,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=985 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070128
X-Proofpoint-ORIG-GUID: -mVXBxG4aPiEQhflNzFN4tOW8M765UKI
X-Proofpoint-GUID: -mVXBxG4aPiEQhflNzFN4tOW8M765UKI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.329 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.329-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
