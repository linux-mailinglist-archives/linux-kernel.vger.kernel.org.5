Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC87EE5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbjKPR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKPR33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:29:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EF11720
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:29:22 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGHMfGF001883;
        Thu, 16 Nov 2023 17:29:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MkNiCCriFtMS3JXX1SXzkVMHDi9Y0nER+1jS6JjvXxc=;
 b=PsiWUrQRkLthmOzgb90xZdL+z1L+95XLN3eC9wnwNxM0lUmTSlnN87arj+M47d0Nusl2
 UGtgZ/Cp/dz3uA35RHRzepyro+f471S4dHYYDklKU/rw0iL7K2LXdOgOtCv+KPBhZtfc
 eX1TV6sf2/g4lLRwfaRdl7wUbtvpgw/4IkOMpZMimsUcmmOGISPgVdE+I2Y6i47Mkd5j
 Ia7wxgS/z2+fn3XBabPmZtAbsCL1/zC4YPz5xkD35jxpoLlWhRR1xrER1RWoni4XhVIY
 fhpb9x74lO8404T3pesz/p0ntJ4X+ozW7CuZvTbgd2YVJ5wT0KFZc4a/KD2PxGVABxz6 PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qdbh4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:29:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGGPwSO020034;
        Thu, 16 Nov 2023 17:29:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj5ys5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 17:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Rov5g+/+V8VJ8Y7uHAB1Qfi4um421qI5+OWzQRaYeHZYQIAIJJ5Y7ovpZUCBjFeSiBRgV/IgRpfyH455tufHsKg3kPNSmrF2EzRL0zgWpdKiOMXprDo6mTscLKwCaMZLOmr4CTO9qv7sCxAAX3r5e86g4iWK8y6CO3p9SBQj2IQeFwZ9TfAAFXy4GQ38nLicBCqs+DGMQJPKR1XLwiMTI+tgiFLXDyKWTGZJiyQpwo128FMF8RACwlTKabsqi7jaa+AZN9gN64Vz9Bc2ctym7qsDF0M6FIxvNkFC0hvXYxsb+4Ep6BrbnN4VSTptgninqdWp16swc5NsQe+o05ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkNiCCriFtMS3JXX1SXzkVMHDi9Y0nER+1jS6JjvXxc=;
 b=YBCbaEhRBCZwHF40CjQwIWKnBGDPEl/X3Deo4w+t/G2g+MnXLaJEFePqDrbMw946IPd4xQOGdKeae6nIbaddbSRPpnVrkWaubFwUXIGOlyogMSb55t6dFKgtijqC5PG6q6/ViqQioueikKxplCgLu5nu76O8iczYf7TNDkgmU2sMKeQTte4vpEw4jj0paZyu3+nY/1UP/v7pEYQFHlq2Rs3rLGFxHG8Uhfav2Y+51/ItbRmloiSy0ZdPThdGclqba8P+SQNublFmu64NYFBPI00GjVXypXtdBASofRWXNBB6vWjq6ro9iDMsBlKQ87SW8xqZ0IRwq/ny0lskosVYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkNiCCriFtMS3JXX1SXzkVMHDi9Y0nER+1jS6JjvXxc=;
 b=oV9Lm+P6CCZWVG5XvLufqGd4LSydrfkiXOd3U1R293SoZmBcGfGnNtWutDTyPJ89oyC0ISb1Mthk/80i+VU9dFTWAZSQTgP54q9ElVDOo0d9Ja769PGA8Tnl0pKnVlBuvkqUKl1QiM/xFYEk3MykUwO+43AN/+WuB4fMwZ0J+as=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by MW4PR10MB6558.namprd10.prod.outlook.com (2603:10b6:303:229::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 17:29:10 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::5262:1e:e9a9:6c46%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 17:29:10 +0000
Message-ID: <72f0e75b-6c91-4c17-beb2-3f198ed05cd0@oracle.com>
Date:   Thu, 16 Nov 2023 17:28:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd/selftest: Fix dirty_bitmap tests
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        jgg@ziepe.ca
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <90e083045243ef407dd592bb1deec89cd1f4ddf2.1700153535.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::12) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|MW4PR10MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d341134-163e-4659-9042-08dbe6c98b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t71k+08pLorpBkhmQsJCl03Y5TrMFq3gTVK/moIDXj5gDnkFQ2NHl5vKhS6NSa06MP6wnKTJlBjhja0DVFYce1uChgZJcfrsEesOdu9fip3pGGT4WGGVatKi7AQ8KUkVkFS9VnMW4eDEd10n2aajJoyyT+p9f394+ParAW3Ce2NlvN4MxKX/i+VbTG4pytDi5UPUDMv3K9eA2fEebrK2xWv2FcmH8Hxni5gf3mw8Rkxrtyr9BWwy5EnuOD547wNuURIdIjYekgSV58d2c6l/7CtK1pgA2Rlpl8df4RFEcKZ8eHpgB0QaaZfRAHldHgQ58SDM7ckJP2p5BXsbA1InxbjYVzjAGb+b45RM/6XtiaCO7Cp7JaxgOR8i6eyLAP5xyQ5Hr3g6MaW3IihkqfHLf4j3S0RIqa/EnQCFNMwdcAR1ynxD3yH+md4iLxgYqOBTU0Y2tSh9hDcWahvWdpxD8fL0HeyuekudKW1A8VlRJs05B0ni56gCFVRsHycbEoI7qBZHq6gFlMeVycRASHet9S6jAF2bruaUut8/Wz+YrhMRLNB7oPFN+qkBskFj2SO/wcBAmF42Hf/bKMYyPc/TcXCcpgmfr+b/64HkMO1GqD6gfG1YLrnFL1FVSHLdTLBayRzIy+TEAvn4RQbYPDGXkNQ/fVIoskvf1eaCj4i9H9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(66556008)(66476007)(66946007)(36756003)(38100700002)(31696002)(83380400001)(6512007)(26005)(6666004)(86362001)(2616005)(53546011)(2906002)(6506007)(316002)(6486002)(478600001)(41300700001)(4326008)(5660300002)(8936002)(8676002)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hRWHloR01NRjU1SFVORHV6R1RRb0pjMGx2RGRCQ0ZHM2I3TFUrUHpLM2lx?=
 =?utf-8?B?cWc2VENUeWI3V0hlUjJqNk5RTGtYVG5jRkFHdHhtbnhHbW90aDEzbnlFZXZ4?=
 =?utf-8?B?WDNodkVkbnpJKzdhTlJCZmlmcjFwTWR2a2JkNUlqOVJQRVc1anpZTXIyU0JJ?=
 =?utf-8?B?NEo0ekV0WDlCOEQyTTk1VnQ5c0RBRWVrNXhvMU5GclFxT24yRitDMzBDVVhy?=
 =?utf-8?B?VDVWTnFnN296NVVUbHBzYUdWUUFUcXZrT0ZOZGphQno4eS9USnBoS1ZJMFRQ?=
 =?utf-8?B?d0IvWlFocmIyM1RWNkxkN3QxZ3VkSVdzUysrTElCeXdiYnBjQWhCRWo0cGVn?=
 =?utf-8?B?WENxRzcwRTF0Vi9SaFlycS9hcmNrUmFnc3Ruamk0Qm5rV3VyaFIxc3c5VER5?=
 =?utf-8?B?TGJydjk2ZjVpMjcySjRaalQvMElyK0VQelpFbkJyNi91Wm5tVFhBTDRHY3JN?=
 =?utf-8?B?UnY2Y0liYVJsVW9zQWE2VzY0bjlGdlliTG1vNDlkY2Y4OFNMVmpTUVpJSlh3?=
 =?utf-8?B?TTQyemZZYmlGcHdQZ25yTFRIK3FPdGIzU2ZZSVl1Q3VMUFY0NmIrVWdvSkNy?=
 =?utf-8?B?L0h6K0pYT0lJUzE4M1ZQN296K01rYUVzelVPYzF0TmVzQWlYRWRnTFl6RHFE?=
 =?utf-8?B?aWxoZks5d3R4dFI3MlhGdEZXeHpMY1hVdDl0WWw1TWJHTnpwazhnTWtHdkVR?=
 =?utf-8?B?VlpyV21nekM1QVVKeVk3TEVMZEJrRjY4eXJLT0Q1SEZ5cFhIVWk5dFdQSVgw?=
 =?utf-8?B?aTEzekk0a0FjY0ZXellMM0RYaTdPNTJCdEw4TEhiU0JKN0d2TmMzVDEyam4x?=
 =?utf-8?B?V3NBdk5NUitVQy83Tzh5SndIL2djMWl1N3ZNSDkrK2VJdlVNd3p5ejI4TDdL?=
 =?utf-8?B?bmhiSHFieVVzczYxTEd1b2QrWm9LSkRaRUI1NFY5eHU1ekRiZXZ5QTVvQThu?=
 =?utf-8?B?ajN3YTM1ZnBPVnRDZWk2c2NpemFOWHdiSmxSU0FFZStaMGFDV2FSazNpemtr?=
 =?utf-8?B?Tm5mREc2UG14bTRJcW9IS09GNkpaVlFiUmR0SzNody9WZEVlVUZOMUZVMEtF?=
 =?utf-8?B?cnJST2V5bkhRRm5mZTBKOGZaMEppNDBRUCt2MHAySm80M2JxSmJsb1M5MHJa?=
 =?utf-8?B?QkgzaEV4M3duQXZROHFtS3dGVU5tV2hlYStQRWNrdHJDMHhhUXNmZm5tRGNZ?=
 =?utf-8?B?cWRVNkdHT2ppdFZOR20wWkNlNkIzQjBmY205Vkd6NmlYOGJ4YXhMWVljd2M4?=
 =?utf-8?B?bi9GMXpYcUYzaTE1RUFhMjBvWjAxY3lYblhrVDJCdUI2SWprR21VWm4vNmww?=
 =?utf-8?B?azNXTGV3Mkx2RVdmL0lub21hUUtKekJlSXk5R1h5MFVzMXQvY0I5WjZYZjVI?=
 =?utf-8?B?MFFGSHVIMFVWSFJRV012bTZ1NzgrM2JNYW9lZ244ajhRaUFld2oyYW1EUUpk?=
 =?utf-8?B?M0NzZ2tHWkpWb2ZpQnB1eVFKUnVjZTBpWER5RVVFenNMenlIVWZGQ2huRWx3?=
 =?utf-8?B?TThKL1Yxbk5UNW5TS0VXYTlIam5FaHcxUnRzNGdsSHk4VWNNd0pnUkJNWGxV?=
 =?utf-8?B?RkhEck9YcStLZFRocUtOTzBwcndTNFVvSk9WNVEzMnQ2ZTI3WS9KWUZjaVp2?=
 =?utf-8?B?OE1TUzZmMURYaVRmSHBDV25mLzhIZlIyb2N5OHhoMjRUT1Y2ajVTUWFySGx2?=
 =?utf-8?B?RDMzZlpjdm43RHE2SFBYdGNaRWNQSk5pUTZFa2F4bGdSM1hrY2lsdWZnZmFC?=
 =?utf-8?B?Y29Vb1Z4YUtDK2JXUXBDMzhwYy84a3ZwdndDaldvc0hxc011bHBxTzdzb3VW?=
 =?utf-8?B?NVRlSml6NEZZZHozenF0bERHdFZwZU1iTzFxUFQwZWpWd2JrcU9HeCtZNVBq?=
 =?utf-8?B?c2x3K2VmRDVucG50S2QxWEJjNDVxR01zMWlXMCtTME1iZVVVRGk5T1JWM1JL?=
 =?utf-8?B?ZGZyWCtmMDBhVXJGTk9jc2RaY29sbUwyY20yR0FvRmxNWWlLK054ZGJzOXh5?=
 =?utf-8?B?aHh5aFNRUUZwcTlyZk4wU0lDMnhUalFoVXgwUktQTndCNG1XTVRrdzUwRWRD?=
 =?utf-8?B?MkFTZUNCcS9TaFdaOVBlR3JvUGFxTHZWTHJyNnRwRzRXM1l0bnZ1Rys5c1Zq?=
 =?utf-8?B?TS9kL04rMDBnL3V6NURQd0VvSjN5MXFVdjIyREtYQ0daSWY3YXB4UURxVVVQ?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kjDtF6afdW29tQkPkyIQfoVsw6YJ03uJ9ZsE/YheVYxI9S1zHCLaS/Cu+RAFRe/QEuWnmHvxqn9B5VnW/wf3KK8vKibN4NtGO2zeP8LfyvdaIQdKLh/mnw61YVBt89/a8p4c6+aktaE+thxN0Tu5FOU7KJRCtdbNCNWi2H36j24iu8QDmSxfChkT2KT+ALmRaIB/2CZuWhYD6WStIQdCRU+RU6ZG9A9rZj6Zw1SZI+29qz85ac23EAt051ynBzMw5hK2e5kiXuXm/9lch0dKT95Q3z+ww7Ozhml9cBqLjgZSxRga5ldzfEOzkJ9eClc4Q+t2kSTCuhAuPObP72fcYM8PlRIZqF61QUv1KhOoq+29EqZdGKe63QmnEPn9ofjrMe00QyGDKTHV3rK1NClBXEyr92fVIWZyp4wMSPu8vY5+HxCSBdI0feKxYA6BJOF6DKNDoD5f5yfMO2tBgXH4bvipP8xgK27D7lUwmbmk7cxm/TNaU+u1C7FyGlO+AShy5IlhD+ICAJNHSWXigOtPmr1RXk6kD/wh2pkZYeeJtxv1TuvQmBCyI0G+I1u6AjGyjEb1/6VjnTS+AYNo7gJh43nJA174NtInB54zh2jJ8US+ZU0hrVnehMHIp9wJkaX++odMkbZ2XnAIYsvnKZsMsnJBXZopLrVhO0w1gthvHVk1ZNhYcYDIDmhATg+Ioov1Qa8M8cDuificaloG9ds5ef2kw6mnz3l5AbF+F541xezb4zU2RtsSIIFUaAOtDPLteSHpLOXecf2VwmWxyVHsTBTDji4OmARZm09uGgA+KD2bbIsejGy57CrPsvbeVvaGGrwxl+uRVf2Ka6CjAfr+KsNtQglEtR85xrsm4mwfWVlSzA6JYsIU8/3vUJ449Gp1
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d341134-163e-4659-9042-08dbe6c98b43
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 17:29:10.3411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6BvfmktkKQWbLmUV0mqbKumNH3BpTm4x86+uskDGFVVcwrvv6M3qYfLpS0hynye/OxH7OVX3by2GX8Cj32+9Y0YfHBYbYNwdUiOOkaSo8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6558
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_18,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160137
X-Proofpoint-ORIG-GUID: TrHYNqkk7EnuIrusEUss8GVu2XFSdSd3
X-Proofpoint-GUID: TrHYNqkk7EnuIrusEUss8GVu2XFSdSd3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 16:52, Robin Murphy wrote:
> The ASSERT_EQ() macro sneakily expands to two statements, so the loop
> here needs braces to ensure it captures both and actually terminates the
> test upon failure. 

Ugh

> Where these tests are currently failing on my arm64
> machine, this reduces the number of logged lines from a rather
> unreasonable ~197,000 down to 10. While we're at it, we can also clean
> up the tautologous "count" calculations whose assertions can never fail
> unless mathematics and/or the C language become fundamentally broken.
> 
> Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

I was going to say that the second assert is useful, but we are already test the
number of bits we set against what the mock domain set after
mock_domain_set_dirty(). So the second is redundantly testing the same, and can
be removed as you are doing. Thanks for fixing this.

I would suggest the subject to:

	iommufd/selftest: Fix _test_mock_dirty_bitmaps()

Because dirty-bitmap tests seems to imply the whole fixture, which covers more
than the bitmaps.

> ---
>  tools/testing/selftests/iommu/iommufd_utils.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 050e9751321c..ad9202335656 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -293,15 +293,13 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
>  				    __u64 bitmap_size, __u32 flags,
>  				    struct __test_metadata *_metadata)
>  {
> -	unsigned long i, count, nbits = bitmap_size * BITS_PER_BYTE;
> +	unsigned long i, nbits = bitmap_size * BITS_PER_BYTE;
>  	unsigned long nr = nbits / 2;
>  	__u64 out_dirty = 0;
>  
>  	/* Mark all even bits as dirty in the mock domain */
> -	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
> -		if (!(i % 2))
> -			set_bit(i, (unsigned long *)bitmap);
> -	ASSERT_EQ(nr, count);
> +	for (i = 0; i < nbits; i += 2)
> +		set_bit(i, (unsigned long *)bitmap);
>  
>  	test_cmd_mock_domain_set_dirty(fd, hwpt_id, length, iova, page_size,
>  				       bitmap, &out_dirty);
> @@ -311,9 +309,10 @@ static int _test_mock_dirty_bitmaps(int fd, __u32 hwpt_id, size_t length,
>  	memset(bitmap, 0, bitmap_size);
>  	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,
>  				  flags);
> -	for (count = 0, i = 0; i < nbits; count += !(i % 2), i++)
> +	/* Beware ASSERT_EQ() is two statements -- braces are not redundant! */
> +	for (i = 0; i < nbits; i++) {
>  		ASSERT_EQ(!(i % 2), test_bit(i, (unsigned long *)bitmap));
> -	ASSERT_EQ(count, out_dirty);
> +	}
>  
>  	memset(bitmap, 0, bitmap_size);
>  	test_cmd_get_dirty_bitmap(fd, hwpt_id, length, iova, page_size, bitmap,

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Tested-by: Joao Martins <joao.m.martins@oracle.com>
