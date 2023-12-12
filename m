Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86CC080F6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjLLTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjLLTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:30:49 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DD94;
        Tue, 12 Dec 2023 11:30:55 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCDitnv020899;
        Tue, 12 Dec 2023 19:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ww2/Pb/oQ0bl8B8/2UJkiBSBy05ZLFRk5/59UtWkePo=;
 b=cE1o6eH01l6Lp1dibP2sMptA5J46YThSlFT/8+nrtLOFAkm7LFVfcGOtFWKkNxrnrzbz
 Ml/sqL9u5Ztnzwv6WPBNKSrDVTDguWSd20lXWtWHmoxLh8VKu4GgU4SEz1p17PD1V7AW
 L650fWoEQ/eoEJLElSpdbMZ80DSXxay3DRfVHZNFuaXrWh/pmPl7Vn1Ew5YhwKEMzWhZ
 e/B7HY5JOY3L9G59W0Yoy+MbiGYL5GMObO9tfEuJOnIVz8Kc0Flc4y4kXhhi0DUUCLa1
 yVV807w1snsiXPlpCp7tUYlA5GBn0O4SiG87mgTE6/R+FutgmaN6CVr4Q+cz9lliM5iR nA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5c6hwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:30:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCIPgu6009868;
        Tue, 12 Dec 2023 19:30:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep734wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 19:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVU9r0niuZ1plrRDVvxq5QMZ0qXYKpYb5sLjmnAtvPB6hO/NK0KSAZapgfrnDJvOMHofqrzmlwXvIJo6SGUcAH/AplAxtIwWAlo6TxRPMht1rkZIvoFjw+IwBLwkbroJlEPhZ0GPPE26dJDurKE9hX540Rpmir0l/3A0mMEgPEMZoYaLtZRvS25L8yt8NOjjQmqPrXk7vWap0AbTQ7r5hQsm1WlJniLk8m1VFZ5cSu/lW3RQCYZKCXxvhlw2iDzNYQN4iqHien/iFotZTosWJFTLxZtAL7u5ka/FYuzK+yhSI7ApboMDgYeW1xowJ9Z/OtGe4z4LiXgPVsw/CeoBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww2/Pb/oQ0bl8B8/2UJkiBSBy05ZLFRk5/59UtWkePo=;
 b=esosBLsFsUUQwxS4/2YLQl4IBME8jF4DgIMw2DJQuAU9Tulw9cPaXiTqQ72LDiiPnOf+XDm6j76YT73v9JE831ZYvsQ6YronPOie1dRs6Apyy2fvZd7zkj4z3NPLU3dDB8D7EFos50Z+uJFV0wDe8imvVIdY/prpehBSO7rvDERT/stZIXhcINJQ4/8ov/4y1sYaXCfxlEztGhmASezjrCrXCEMA3R0dJn7TxZgBcmFEzAQ2+/e50mAm6Xis7b+oQF9jVSfrMncRv0uTbbQW1cH02OaDpxZa/tmcY5nAGWmqPTx5VkSdwKaMzWrI5LvLONAfbZecAW7JUWm5cj9yyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww2/Pb/oQ0bl8B8/2UJkiBSBy05ZLFRk5/59UtWkePo=;
 b=GOP2Lyxaa7zRdjAmsVMW7tM7awFU/x4ZuOY+XEAPjKBHX7ndnUW9L+m5U3o5l060l+1/0SPE/KxsQnZ+Jy/LaotjneV8AT+tX0gOKni3vqVi5BXh2Qn3bMazOEfuxOqoQ6CVNt2bQCxEFomY3RuMT6mZ3pm+JeenD7IWi2ZDjDg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB5679.namprd10.prod.outlook.com (2603:10b6:303:18d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.36; Tue, 12 Dec
 2023 19:30:17 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%4]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 19:30:17 +0000
Message-ID: <4eda1915-983e-4910-a4be-16c1950a3e5a@oracle.com>
Date:   Wed, 13 Dec 2023 01:00:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231212120210.556388977@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 090a0a5c-6d17-4575-466c-08dbfb48c55c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQvTKjAFxurwLAEWrjYZxuSbAqQlA8wVEWCNXl277tQygfH4yyWxu2CwhYPKgPkmShb0WUTGHi/9cvQnSKvYR8mbn/6gLhD1fOHfXHNz+9Ap+CvELoZtEdZKBBcGYEmfEOgnIizQOmF//Vg78/uhBGYJ3uH2rC0YMal+cmcskEVMF/94D8n7DAchtJ+/+SdFzrbC+kR9oX1FjWn7Q7+x/XwnNyFn/ichv+JuOWUtSU+pNkt0bAwtUZAPKhOJ6WqGPwE/2+Jicwequ5UDc7kMxgdNhS2iqw0tb4vJrtFmU5FnHnbM7TVBmuW4aHjnHeEetezxoH4tib0MAGc3hZt6PA7IM28NJt/2AHFQwsbuMEWwtMQGkNgBTtZj3kvYoyJy8iPFfnETHfr8qe9c69/Dqs53X1sgAHSeWtNw98KVDLYf9q3TPxhVNto6ThkNbJkWffO6SYXdOYBLvIBWje9XrXhjuSQUl9miBq6wTvKFsnLvzRhyrc0acSOulJT5hZUNUKWX0btFqcAPnajY1MlEPzyPmGa4mBvKC3s0NNlkQFVboLwXFwqUwoHmBEbniJjXwMC6BTI/4H1BVtvIcna1CEIcG/dsQaHuu5jFQISPDrbgRS5pGI3BGgSrI9EC1515x5Ozz3f1gJhQs9RsTBQAVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(4326008)(8936002)(8676002)(31686004)(4744005)(7416002)(2906002)(316002)(5660300002)(66556008)(66946007)(66476007)(54906003)(478600001)(6486002)(966005)(26005)(36756003)(6506007)(6512007)(6666004)(53546011)(41300700001)(107886003)(2616005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2ExTzVIb2ZUbExoTXcwZmx5dHVnd08zbXc1Z3ZIdjdRYUFYTHY5dUZWbGFC?=
 =?utf-8?B?WW55cW5iS2VCdkxzWjFRQ2hPSGZzNExQK3MybGRmL2tOQkZaREcxcjFxRGk1?=
 =?utf-8?B?aU1OZ1lXM2FHOENJNnQyVmxNMEtqUlBBSnh6ZGRzZGs3VmdrVXhYTTBFTTNH?=
 =?utf-8?B?Y2xKYjRSYThDbWNlZGlkVkRxSUNqbFYweTFGNGl3U3J2Vk5tWnRMRXNabzRE?=
 =?utf-8?B?Um5lTEI2QVF6TU4xUFNLQlZaOFduS3RScW5RQzE5VHlVSTZBNWlMKzA5U2Jh?=
 =?utf-8?B?Vm43RDVCZWlVNGNPTGc3REhFSHlXNUNZWTF0TWQwM2ZTVzNsRGorMUtsdVFF?=
 =?utf-8?B?bzdhcmc2RC9PTHB4L0owMTYyRWcrVlFUdXI5Ynp2Y0plSGo3bHpFOEI4dmZW?=
 =?utf-8?B?RjAzZ2RxYUFuWk05WWIzb0dncnMrVTFiMnd6YU53YXpraXVjdkVZaEczbGox?=
 =?utf-8?B?SW56a2g4ZDJJS2NVdi9vMldpa1BINnpIemNYeXlCUjJvN1pyQThMSVgrZFdG?=
 =?utf-8?B?bU1BaE1CdFF4Y3NFdW55SlowNjZCWUlLbTl3bnZSNGREb2VCVG51NWJueDBY?=
 =?utf-8?B?dy9TRmhtODNvd3ppYWZUTTY4ZGtDY2VLV0hQbTRPbTVBRG1qZmdzT2tuaUNB?=
 =?utf-8?B?cGk0QlNOVTlIVkNNU3YrL2wyOVkwVURsN0lEbmFvZHg1YUoweXZjRzJqTFZh?=
 =?utf-8?B?aDNSQmtld1VFQlNGVFhVNVBvQXNEYmJ3b1MyWG8vZC8xc0VPZjZoUkVvblNh?=
 =?utf-8?B?S2diMit1VDI3bFI5UnpvZDRGVGpSZkZ5UjM1OHVtVU1PSG9mSGJGZ2VDTWZJ?=
 =?utf-8?B?YU14UUZ4ZFVCTTN4R3A4czRlRlRPWHBSK1pNYXk5TEtHcUIyc3FybGZsZWov?=
 =?utf-8?B?dzExNjlQTXJhdkZLdUlmQlFIQ3lJZ1dnektCb0R4VUZsbHlmWGpnL1lBSXRL?=
 =?utf-8?B?OUpZaFhUZUZ3SFRrcTFyeFlyN2tZS0VxeVRHTnVFc29EKzJrMmNGYlU1dkFj?=
 =?utf-8?B?QnJ3NXdYUzhlblNTaVFHMW1jYXdPMDZ4VjA0UFozWjFITTNwSDRnWlVEWW9N?=
 =?utf-8?B?MWkyVGZkcmdlK3Z5cGZWb21SRk9LMlRZMi9rY0llOXNRSW5ZU1ZoRmlCeTkv?=
 =?utf-8?B?YmhDUm96dmw1ZzlqQ0E0Y0JoWWhYUnZCZHNHTG9pSlZrKzlCaFRDbEEzYVVB?=
 =?utf-8?B?enhvSElWYXhjMzh3YlUzUTZnbFQ4WHFyZkZsdk9sUExHK1FNaGdWdHBmUHE5?=
 =?utf-8?B?S3o5MmJ6bk9iVk1oN2R1Mm9rcXhMdmlaMEF4T2NQbkpHU2xOUE9uQmdIbXJh?=
 =?utf-8?B?T05yRk5vNHpORU5FdEIxZjRQK2JTc2tkc1lTUXhJQjZheWNndEtHQU92bmVH?=
 =?utf-8?B?aFEzYjhVZ2lzcndKVndkVXVIM2txeXN6K1JFKytDWWQrVUovaC9qVlA1VHJv?=
 =?utf-8?B?Lzhyb3ppSUZQMVlybUxFRzFRT2Eyb1h0MGk5ZU1LendqbVpuSTRvVitETy8x?=
 =?utf-8?B?ZDBZNXNobVFYc3lPZmlPVXlENGhLcDQ0bkluSGxJYzNDd2xzZEFqdW8wYW1x?=
 =?utf-8?B?QlgzQVEwQkRPR1ZDR0VEeTJUVzF2bFdhSDJJRWhTbkV4YjNCZU4vQzZ0Uk81?=
 =?utf-8?B?MVhmM0ZtaVN6clRERXlHejB2eUFSbElBZ1pwREoxSkRlaDJFdUVHNTY1Zy9Y?=
 =?utf-8?B?Q1FkSlpYblhwRmJ1Qk9VM2x0Y2pTME9JcFVvZDFwL2dZR0lWamIzSXpYTUlH?=
 =?utf-8?B?YmZsUHpWd0ZqTlZONDNhVW90TXU1TmdQNlhuZU5paFE0MXFPaWJiVUVPUmt5?=
 =?utf-8?B?aldhRWVENXpzT1lORG5IMGtGaEFyd1MyNnQ5eXZwMk1ldkNMaVhPOXp5Mi81?=
 =?utf-8?B?NGpTa25zU1BaVEdZRDcybzYwQS9OT0x3OU9jaXM4QncwTzN4VzdIalZReDcv?=
 =?utf-8?B?akRyZm8rZEM4SmZUU09Ub3JKZGhLZ3lqS243SVZvU1l3VmVDMWE1ZUIyR3pQ?=
 =?utf-8?B?M1dHb2dnTW1wTVZzaFpURnZCU0QrcDlVNmdsYWZCU2VjQ2YyK3l1bWgyZHRS?=
 =?utf-8?B?algvaXZ5T1o1VXhxSkU5ZzZ4SUNnVFRFdThnRjJMZkpONTJZNjFVWEYxMmpL?=
 =?utf-8?B?UHBnUHVFN0ZhcHF4TzNVUnN5ZEVVM1dCNDJWdWFMVmdKV3c5Q09mQnp1aEpD?=
 =?utf-8?Q?oyLOHDaD2zAzUM6j5Hwsvrs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?LzhQVUJLUmQxZmUwS0J0cWlsenphY1FlVEJyZWhUc3pvN1dCYnk5Q2NkV21Y?=
 =?utf-8?B?Ly80MUVyM2RuR09uTnp4UFR4VHBMYkRUSTBtS1l3MlI2bTZGdElRMlhrSHNQ?=
 =?utf-8?B?V3FkRXJlT3d2MGc1ZVhGYTFsRlVmRGNma2tQODlGL3FDS3pkRHpyazYzWHRZ?=
 =?utf-8?B?K3M4QWF6T3dEZXNjU0FKeG9yVzJST2p2NkJOVThsSkh5aVVnUWtNdy90M2Zj?=
 =?utf-8?B?MW1yR1JGaTJqbmFCL0dXOVJKYklMd2owcUZKTzluR3cyd1hacnpvMW84azhE?=
 =?utf-8?B?RnB2KzdYa053b2lXNmI4a2t5Nzh1OXJUMUJ5c09zWmpwNk5TTnhXU200ekhy?=
 =?utf-8?B?VzB0WDRuZU9LRXh3cnI0VHBtektMYzZuZVVjN0trNDlvNzJNRXVCQzExS3RR?=
 =?utf-8?B?UTh1SFQvdXBBWERCQTdyc2RBS3V5RnNIbktsK0wwRTBMVGJza3JDWk1xbnZo?=
 =?utf-8?B?WkVlQytZTGdTbWJMWlZmTmFMdlVWWlZmRGUrUlZZMGhRZDNZMGFKUGlVOEVT?=
 =?utf-8?B?QWlYNEdmNUdVVExWU0pnbDlycFZQajZCMU9WME95eHNQdVROMjFVQkpTdVg5?=
 =?utf-8?B?VHo3NGhkR2JCUG5NY2VDVWFWU2dVSjNMbW5EbE1NMk1SZzVUWTQxRWhXaTJS?=
 =?utf-8?B?ZjZwSVVnTk1hMktJUWh4MFFWNUEwdkk5NS9vK0dyM3N1V3AvNExNRmxuYnNG?=
 =?utf-8?B?YytmUmlLdWV3N3UyV2RKWmtVUFIzMXE3VGpXSUlOcmVZZVV1R2ZYSmVTNFZF?=
 =?utf-8?B?aFVLOWZxMk9VU2ZBT2tjY3NOckJTZjRVY2tDYndOVHBxSE5qMFRRcG1XczRl?=
 =?utf-8?B?T25wL0ZwRHZBbTgvZmtHMFg1V1IzU1lXbWx4cGdQR0FjTmJSRXZRdkViWTR0?=
 =?utf-8?B?azNDaURBTlhiK2dONGJRL2pyWWRjaVlKempWMTRwbVFDcnFBN3djVDl3T0Ns?=
 =?utf-8?B?WGE2c2Y5Z0hDb0RrZXNYaS8yeVI1b3c3NnVabnNudzA4REtGRnU0akV0b2lX?=
 =?utf-8?B?blF5aE5rZEsyQitlWjJKNGZzek9BWVRuTmxTa0Nsc2NBUWF6VEpTdEFBYUJ2?=
 =?utf-8?B?ek9RNzExWHpMSzRtMEJGRzNsN1JiVmthSU5rajdhM1pSNFVtVWcvZjlLbFYr?=
 =?utf-8?B?RWRuN29FR3BlMU5XdDcwR1F3ZENWWEZ0ak1GWGhmWVd3dWlBdDcyQ0N6amJC?=
 =?utf-8?B?N1paM3ZTZzlkamxVMnVhd08rcWFKUzhwd0pSKzBlWURrYUxabDVjc2J5SkFL?=
 =?utf-8?B?ZTg1VTNZVFAybkkzbEw0Qk0xeENma3pSNTY1Tzg2MlQ1Z296UEE0RHJ2eGxK?=
 =?utf-8?B?aE5CYVpvc2xScHNnVitTazlCSi9LZ2hxR0tOTjdmUktKakRPUDYxOTV6N3pz?=
 =?utf-8?B?bzNiNFVHSVp5QWxhckRSQnpSWUpqRXRzOVZPQVladzNyL3MybWM5ckJaSTlr?=
 =?utf-8?B?NDRKeGNJK0NOWWxSSEhLd0pBc2xmZnNLZG1kSnJQRytWMU4vZCt0NlJoZE9z?=
 =?utf-8?B?NGJQRVNRckZyZnVCS2s2YlVqR2xDdjhKQnJ0SFRwVTNNVnoydExLQWp5VnZ4?=
 =?utf-8?Q?VG/qzqOg1qPkJ0aOSHldpliBK+0hQ8cVzaOmntACFLMflX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090a0a5c-6d17-4575-466c-08dbfb48c55c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 19:30:17.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3ZfL7/4H95AF3Ui9ntWZAkDlNGw8k20+gs/jk4NaYdsammZQxc0Sj67Y6H8e7HA5GkzyO/rAtvXBP5KkaEBeFo+LBOqv9zieYyBJJboItXAMMnrKCcQJnCbUQh1DMgb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120149
X-Proofpoint-ORIG-GUID: fAhDW-qiqYugl2U60E-CI6_PCtjD9uoP
X-Proofpoint-GUID: fAhDW-qiqYugl2U60E-CI6_PCtjD9uoP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 12/12/23 5:34 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
