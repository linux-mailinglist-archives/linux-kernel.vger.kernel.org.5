Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320CB812061
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442719AbjLMVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjLMVE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:04:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B824139;
        Wed, 13 Dec 2023 13:04:31 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKO3LO029114;
        Wed, 13 Dec 2023 21:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8ehfqSngDzy4gtJac7CjJCj9JYLiA0TOLQsN9Uhm81o=;
 b=ZbNJiR2v62CSKYch7R87b/P782UsqH9f1V9xE0q3VrtXfb/ICyhccnyeYY3QZkkpsAf+
 ZFRN1AicKOAz/j5nWSD7c/eftWHOmxiSR6zwTj94M4QfsUSVrgpR1Qjs6dTi5Hb0wrbI
 MNanzyDwuOIdheifiM6ar6FMg4rESC2pbW2yjlnAk9rMnLskXg2RFFCJT1fmrDLqa3dW
 LdoOwJzLmxeQ89TfSrgjoXieOyAfyXLO1Ut5CZ0f0YwsmI/ohQfOb6+gF59MkmZxR1kD
 WsuKPrmn3xfkte7JQneaeS3XZ1ECY/sAmcGOf5rardboznS642ts+8n8HV6OeoNSbuaF Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuh9d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 21:03:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKAtWj012781;
        Wed, 13 Dec 2023 21:03:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep8yuv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 21:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVfcftAPSx/rPxw0CBYFLbc4bnOtj7A5UJBRKixQwqdRosirHAgBo++sQJifREbsBmaf9s9s36PHziISwY9l0zxa7ZmYlbsDMIAQMuHDkEhCvLF0O7DThoepbCbUsulSNI2vv81FUGgZsWcf6LjabkZsdwdi8HyRsVU7nYbt+cADw3cug31U9r22kk+eI3eH+Lrqw0IK2gvZcN2JVZ+BUbDPHgQm9RIGIc9XpxGQXyd9f7Y06+ysh24owvIfT6qsAUELPvgQECwBE7f90TMotUBEtxsKLWTh6s+w0ZtS/+7d3m5zbKOEZBMZIxFHCMu0OY/FKGbv5xcr44gFANLW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ehfqSngDzy4gtJac7CjJCj9JYLiA0TOLQsN9Uhm81o=;
 b=O251KzS9xSnoL8R2E77VTjuDvbZExbuLQ/JYRaN5Y9o3ihB+OLXoDEOlFKyS1XnzQXvXHHTHeB9y3lDKAiqVm83j9eUb+ZUlMu0uzx3935yE8RgtcROaBYddZJcoAEyYH7r7EHIF+oh1eEOtsozeYbE8K146Z0oKB6Zf02vwUJOMcLU4MJtTg74Vn1dLryHqO/C1m6M2HarREntw2FfQ/dNjyOfsXo+vIEwWMy5huGXLt0t6iaYo3+D0qtOkH/1lIBc7PUruPfO93WsUs+mPLvV0Xy0IkVlwJ4KW2ItWq345147qSA3kOamvuzmmOmsAfZ21h33/MQy6uNGTW2A3fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ehfqSngDzy4gtJac7CjJCj9JYLiA0TOLQsN9Uhm81o=;
 b=iB3GZ5PRcENUcxp3QtR5str+VgZePsKOKWUG9TSuqYVg06p/wKwq3i7LKdoFTWC9MT/4vGJNwqVDwLalmlRPApjC8NMZBZ3m9un5ZOEqMs0vB3e6zRTEYc+mAPxbIWfWUVfzsp4pC2TbITbYOs6YOuMhOc6xJgqkyQrlOKqm09I=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Wed, 13 Dec
 2023 21:03:41 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::7361:23aa:7669:bcce%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 21:03:40 +0000
Message-ID: <31d24c29-5b7c-328c-b830-276acab43203@oracle.com>
Date:   Wed, 13 Dec 2023 13:03:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] maple_tree: do not preallocate nodes for slot stores
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        stable@vger.kernel.org
References: <20231213205058.386589-1-sidhartha.kumar@oracle.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20231213205058.386589-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 95845e24-9721-4524-f18f-08dbfc1efbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlVKPapuOAh+J9Nnq2F/7/gO5Gk/fz87Kl8uuWugc0ir0/h+oOmngKNZjsgxNgxJLQkS5MSx8vLr+lIlCO1TFtX5jP0qz1XXiWEsod5QxIjt/sm4itexqUEN2Y92zHpqrAG/skuYZmhxxRUgktoJ74j2ULek01CQzOFhUhSb4+ubIiY746kRVvP9KLds0ZtBHR3j+nkpq4SuI+wRNqLcWQpk64ZsTpNce/IRuBlQONu7O4UuA3kcrX/lppKRBgUEVOgpd9HdeqBeHkPVa/a/+703xKftse2sar0Fet7NEqGzOrUENI2nU3D1Cc8DqOouzIG2yc/QpWOUoKnNe8Md9xnrluN1niQcrjV6/9NJ75Yc2gzYdWjq9gGj26dCo1GEBxBRnVeyyQ+OSnmG50pfjOORjiE8p5WbztKvHWfezBB3ak8ZpBJ/tCPbc7653pzSpj/VXG/sz9OXX21W7vhainoMaoRPOGeibY+DmfTFs3klqYMuHUOCWg20F/xa+ATf/+38tStkQt3TZ84tGrNqK0zwAqqPo/aWA/sEjIbf/27g8jenyWypCmtHw1eOkPZwrtZlFWnw+xC2pC6Nt7BHzqMHfs4GklDGXD0U4xoTJZR4gKLjIBuvSyLPZeU6qnenT5JfQ8MOffbB4oLOZBVhlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(66946007)(66476007)(66556008)(36756003)(86362001)(31696002)(966005)(2616005)(6512007)(6486002)(6506007)(53546011)(83380400001)(38100700002)(478600001)(2906002)(6666004)(316002)(8936002)(5660300002)(44832011)(8676002)(41300700001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUd1Y0JoQ3JoT25sUGcwNGFnV2FkQ2E2S1RmUHhwOEtRRldPQWg0L3hVdkZj?=
 =?utf-8?B?MForb3krOUp1ekh4cFgzdGZsZGVCTlFIb2JQcWx2d2lOaXRpVUd1L1o3ZmFV?=
 =?utf-8?B?YWRuUU5XS3FsQ3FtV2ZxTDhIdFduZFVCcURRaHJON0FYYkVYeW1sY0UrdWJp?=
 =?utf-8?B?RGdXdS9WSytNSHU5dVErZkY2cm9HVzA0VzBPcy9HTi9tTUJTQkRkV1lHV2Nv?=
 =?utf-8?B?S0gvY1A3eUVBbGR4S2xxQTB5Uzl6aG5QWEFyWTl5QnBzaTdkeThseUNjSzBM?=
 =?utf-8?B?bjl6WkErZGxhUFhFeDFNd3BjZUtSV0t1ZkxicDRzeVJ2d2xCdGd5U3BnT08r?=
 =?utf-8?B?dVFOWi9IRUhiRzlheE4rTzFpdzVOVHFwKzQvVGhvM2dRdmZuYWFYQklpVGVD?=
 =?utf-8?B?YmdTM3JyTFVUT2dsUjZVQmkyRDJiRWYvaUdXUncrN3hZeGo1Y1JleUt5WnZ6?=
 =?utf-8?B?WEt6ZWhJL3VrZGZTUEl3dVZ0THJZQ2tDamhtNGZtVE9HMnk2cU1yQkxKVDU4?=
 =?utf-8?B?K21sL0JoUTJLRDFwMlZRUVg3dkN4YVB0Zk1ONGM4bFFBK1VZV1ZZdWxlSjZa?=
 =?utf-8?B?bWszdkUzb0UxQVowN1Jra2FrZnNSSUZMSEZUc09zWWZXVkE2VGcyU3MwYXZR?=
 =?utf-8?B?UVJaZGtuc0x1UXZKanhGcDJYT0RwMTBnUW9UWTRTdU1RTkU1NjU5UEN3VmVx?=
 =?utf-8?B?RGQwZ2pYVGhreE1HQzBUd2ZuVFVnZENBeW9XTmlHTVJhV1BmOTNOR2k1NWlY?=
 =?utf-8?B?RTB5c1JMbGdHQTJ5WkVUWGVYajVldjAwV1pyVUpIRzdyaHlqRWhEWElIRUFF?=
 =?utf-8?B?WFpmN21kdW90eHNHUnFkaEU3enBOWG5nbkpVL0xYd3hKcmdUQ2JvREhUNFFt?=
 =?utf-8?B?dDc2R1N1eXVMSm9RSXA5ekZReTgvK3RmcVF3WkhKZ2E2L3VnODJzN3N0M3cv?=
 =?utf-8?B?Y1pWdDFEQzQvdWh0bkNoQ2VvOUFSMkRZbjJLZ1RnMmplRm9nL29aMlVYQ2Np?=
 =?utf-8?B?aVBySS9kTEx2L2ZwaEJDOVl0TEdIaWgrK1VEeTZpZnZPQ3UxbVpGUmpIclVp?=
 =?utf-8?B?RWI2WFJRY3haUjNKRmozWmZsbi8xU1dlbDV3S2xSOVpBVnpIalRLYWlrNkJw?=
 =?utf-8?B?UUNyaWNUaW5sZkJnMHNGT0VXSXZFVmRaV0J1Q1NSVTRXVXdWcmxFZWxRWXpj?=
 =?utf-8?B?YUNoMGJWNER5WkFaRzdTaGh4eTBwOG4rNmh2aUxkUTU2Z3JRWEVDWUxBWWhR?=
 =?utf-8?B?WitySVV3YVllZHp0Zkl0NUEzUXhKUXZmWlVocEtaNWQ3SXBGMEl6K2lkOHlN?=
 =?utf-8?B?TUltVGlSQ2oxc082VTh2Y1JoSWFBUlg0cnluampnZG5VbWJDazVxZk1MOWI0?=
 =?utf-8?B?bDVXOGdiZ1lGdVYvbjVsd0s4OUttSEF1N25idm9Pb0UyWjhyOWhYT0VWSWZG?=
 =?utf-8?B?OTk4bytKL1NIZVFPUkVkQklPMDZCbk40ZTIwNXd1dG9XelRPQ3lXa2JEdjcw?=
 =?utf-8?B?RE9CalZZWklQMXlSUURBUC83aFQ2dm94bHhpZElEa1Q5Nnh3V3U2SEZFZldl?=
 =?utf-8?B?NFIzOUZvQnhrS0xpbDN1dTN1ZERqU041UTRpTnJxOHFzSmF1U0ZSWUNEUlFG?=
 =?utf-8?B?RElObkZXbVlPNERLQWlxNDNiL2dJOUZNbmNiY3dsS0phV05PNTY3cytmVlhs?=
 =?utf-8?B?ZTh2YmNBM2g5dXZnYmovb3JhL3M0c3pvT2lMZVBmKzZoT1hkQ0F6c0FXOEZK?=
 =?utf-8?B?WXZZbW1rcVJlU1MwZVRMS0t3eFV6TkpUSDF6Q1BUREJpNHpmMnBHdHZrRkZK?=
 =?utf-8?B?OUN4S0hNWUdmZGExQlA3bzJmRmZSaHlYMU56c3NvUzJVQ2dGUFhEZ2FScy9h?=
 =?utf-8?B?dzliSklYWFpvdU15eHhHTUpHc0ZMak13RG5KUk4xRTVxd3Q1OVk4TGtlTFdp?=
 =?utf-8?B?cWVhdTZjVjh3bSsvVnBSN21HZ1g2alBMYWZaa2lVZnJrMGVlSHhmbHQrY0tM?=
 =?utf-8?B?ekNQRFF0MzJYeGtYRHhmcGtuTHhrL3ZrYnR6bDlHdFFnS3FPQUkxKzhNNGc3?=
 =?utf-8?B?bXBvODQ3UW9NWVI1dU1FZEVMYTJCb3dxNVoydXZqOW1MTHVHKzd4ZkRKTnBF?=
 =?utf-8?B?SzBYWE10bkpNUWRHelM0Z1NVbGptcG5WTVBhUi82dFBweHdRSFVwMUVyU09Q?=
 =?utf-8?Q?REPnZ2qk1AbAcvGWwOuR9qg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2hzY2JPUGM2QnZ3VzZIZVNWcUwzNEJHZTdPcWx4Qm5QVThDVUNhQ2dqZDBY?=
 =?utf-8?B?amhML1BZdjl1RmVaSFk4QmQyTkcrSzBKQTNzWGswc29vQ1J2S3BNSnBuZlB5?=
 =?utf-8?B?WVRvc2N2ZjdQSFVkc002NTFsdDVBQ0xVdEg3SldTTTdhcmp4MTRqd0xtNkFJ?=
 =?utf-8?B?dGFhRDF2UytDQnlRckk3RHRwVjFMM3E1eW1KYkg0YWcvT0J6a0d3N3NTNVBW?=
 =?utf-8?B?U0htbWlFWjREYUVtcExjYVAvMnM3Vjhtam8xaThqWnRtTnc5Z3ZmaWh4RGhT?=
 =?utf-8?B?V3h3UWNjemhXbENiMjVLZGpTOEpnSm8rUHp3NVdxYTFKN0VrV2VWUVUrZXlh?=
 =?utf-8?B?N1M2Q0dHSVdwQ0FWWXhSR2w1MC9jY3NZa1V4TVFjaXVRVDJQeEsrL25ScytO?=
 =?utf-8?B?MmdUZjFva1pydFo1dDlEcWVFSEJ6QlVENVprS0FoK0JEWFRtemZCN25MZUhp?=
 =?utf-8?B?UUNkaW02U0tCV0U2ZjBqQmpOd2Q3RVJIRmRWem1XREh6RVRoMHhVUE84d3E0?=
 =?utf-8?B?ZHI5R1g3L2E1L05qWGROTXhOYkpwRHZockdIM0IwakNsck8xSGNOZE91RjVu?=
 =?utf-8?B?MTdXVGFFREhGeTd1SkZKVStrYUNYeUIrNVlZckJCOEJZZDhVazZIQVBmMFZs?=
 =?utf-8?B?RXJ1bkVRNThHbkpQbmdlendub0NGNTJwYW1hQnJPNVZkbTN3a3VWR0phcS8x?=
 =?utf-8?B?b21Dd3JDZnpVQkJCcFNVb1h0dmJmZWgwTHRGVm5zc3dDSU1JNFBXVEtIOVNO?=
 =?utf-8?B?UkM2K1ZJamFyMTAvNWdoQ2VwZTRZUEk1VW1LUXN3N2NiZWU2TUY5VUZwak9u?=
 =?utf-8?B?cDM0LzJjMnVlSHAxSU9jMjNCajlvZ0lCemdMaFptdGlySm9BVVhONlRpSm1V?=
 =?utf-8?B?RmVVVlltWkpCakhNSFpzNHhPNWlSSi92WEdZbVdETDBJcjloZXdkNlFWZHV3?=
 =?utf-8?B?bWVJWmJHVWNMbEEzU1FFcnd2ZmhqaGgwdFBvVEhaV3VTL2ovTGJOVzFWMyt3?=
 =?utf-8?B?T21pSDJ3VTVKeXIvTGVzak1pbjhZL25CYUVFNGRtWEk4OGlRcTlYL1U1M1pa?=
 =?utf-8?B?eFozU0dOS3FzbDVGK3g1eG5FeUYyMm1lOVQ3ZUZNK2cxOUpIekFuc1AwWE5l?=
 =?utf-8?B?bHd4S1hoSDZoRkVkbFhGdWRxZ1IrczlOcU5HL3RDZ2VnQmZSM2NUcWlJYy84?=
 =?utf-8?B?Zlp4OVFDSTBNL0pqNFhpK2JVV3Z5RlRNaXkrbkdzYlFSeEloQkNkaVhhMEVN?=
 =?utf-8?B?VWFBeFNNOTk2Rmg3T0toUGpQN2tLMElycE41bUE4a2tuckNiYVJMemxpc1BM?=
 =?utf-8?Q?iBRPx84uov+R0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95845e24-9721-4524-f18f-08dbfc1efbcf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 21:03:40.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwtHkmutcUWj3nHoHttMFR3NRj8olLafbaPDgLeqxyswwkzEMMR2XpfzYfyysltgQP00z3fIR6huQr0lioeqflewkIPBLvaBTfb6UYBx/EI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130149
X-Proofpoint-ORIG-GUID: 0fgnIOtxuJUNfu-1gRI4GZEZAgliJyAX
X-Proofpoint-GUID: 0fgnIOtxuJUNfu-1gRI4GZEZAgliJyAX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/23 12:50 PM, Sidhartha Kumar wrote:
> mas_preallocate() defaults to requesting 1 node for preallocation and then
> ,depending on the type of store, will update the request variable. There
> isn't a check for a slot store type, so slot stores are preallocating the
> default 1 node. Slot stores do not require any additional nodes, so add a
> check for the slot store case that will bypass node_count_gfp(). Update
> the tests to reflect that slot stores do not require allocations.
> 
> User visible effects of this bug include increased memory usage from the
> unneeded node that was allocated.
> 
> Fixes: 0b8bb544b1a7 ("maple_tree: update mas_preallocate() testing")
> Cc: <stable@vger.kernel.org> # 6.6+
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
> v1->v2:
> 	fix coding style per Matthew and Andrew
> 	use wr_mas->node_end to fix build error
> 

When this is merged to mm-unstable could the following fixlet be applied to be 
compatible with Liam's series[1]:

[1]: 
https://lore.kernel.org/all/20231101171629.3612299-5-Liam.Howlett@oracle.com/T/#mc0e5000f6de822182bf7579c230030c5ec4ec1a7

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1130803b9d3f7..c9a970ea20dd5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5477,7 +5477,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, 
gfp_t gfp)
         node_size = mas_wr_new_end(&wr_mas);

         /* Slot store, does not require additional nodes */
-       if (node_size == wr_mas.node_end) {
+       if (node_size == mas->end) {
                 /* reuse node */
                 if (!mt_in_rcu(mas->tree))
                         return 0;

> 
>   lib/maple_tree.c                 | 11 +++++++++++
>   tools/testing/radix-tree/maple.c |  2 +-
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922f..684689457d77f 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5501,6 +5501,17 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>   
>   	mas_wr_end_piv(&wr_mas);
>   	node_size = mas_wr_new_end(&wr_mas);
> +
> +	/* Slot store, does not require additional nodes */
> +	if (node_size == wr_mas.node_end) {
> +		/* reuse node */
> +		if (!mt_in_rcu(mas->tree))
> +			return 0;
> +		/* shifting boundary */
> +		if (wr_mas.offset_end - mas->offset == 1)
> +			return 0;
> +	}
> +
>   	if (node_size >= mt_slots[wr_mas.type]) {
>   		/* Split, worst case for now. */
>   		request = 1 + mas_mt_height(mas) * 2;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index e5da1cad70baf..76a8990bb14e8 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -35538,7 +35538,7 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
>   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
>   	allocated = mas_allocated(&mas);
>   	height = mas_mt_height(&mas);
> -	MT_BUG_ON(mt, allocated != 1);
> +	MT_BUG_ON(mt, allocated != 0);
>   	mas_store_prealloc(&mas, ptr);
>   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
>   

