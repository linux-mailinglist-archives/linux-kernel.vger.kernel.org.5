Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36F27ADAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjIYO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjIYO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:59:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18469103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:59:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PECLaR027263;
        Mon, 25 Sep 2023 14:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3GsKUt5ndQlkwZEex0V3wPdDzGrr9hhL6sQ2S5sAPXA=;
 b=sK1WAD7KLdGdwJlUqbXvmsCimk6K1ILR0513mOrXJ4aEmfoH33S2pbty1i4QJj99z6eG
 orSaySAirdKuOq61cbqo/Emfg5jyW9LNxivdj2JLiF82ALJXQt8SNf8j219p1tdx6b5p
 ZV0DqeJZIefrqkHZJeW6n8QSmGwPHYx7Kh1bn0zQv82jG+z2zp0zQydWwOMyzFmXei2Z
 FhvyCerUtRyeZlPricGVOB7uUSEzBCtPbllNFhXATaisDLQN6KlIl599o9Qi988T6Odm
 hoBECVqcl7YLBSEhXH3XajAw5Vtk1pCiWURm5ROSAzJavecI+X+yPoVVHJUsFb5GFKKK Mw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pxbuyvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 14:59:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PE1SdZ003231;
        Mon, 25 Sep 2023 14:59:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf4t09h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 14:59:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euiYSPERIJ7tqr0gnI857/nrVbuDwNanI80iLoMXOlvFk2vH/RjFZgidYjr2+hBEIvVzEwcKqp4mofVi6FGXjgD6YJKjO3uycfZQGdTsoVMqII16mdJDa5ND9yro0Zilnr/DTYGDVqteyF+KLAYkQyh/mpUxBjNXpYift9rj3p5btmWbwIoXt68EYBbMu3ZOXSzeN+2dpxFPf6rO/vtBkbbEydFJ3Z0pdYGqYT6jxwphYvySe8xByGzstFuyyINnRzqB+rpjWfnLLCPWAszPCtmvGviTnNT05cR8WZJw2xUO+NE5mFcP1phSVGZaDSyHhzLcOD8rOJnHr7oB3BvGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GsKUt5ndQlkwZEex0V3wPdDzGrr9hhL6sQ2S5sAPXA=;
 b=QU11xOeEeyu8rl+tlwn0c5ZsoC0Jb52xjCOLtq/VjLtZVN4aAMLvZtRvgYtRpi6DoHVBo9Yg0URO/sdnQURRSDEupWEkxyso5vI4UzaXUjKHTIsQRK24NXpbbPBdithYHZR1xEq13nkwoCMDlJwvdmTpUX1htv9zMLCUVB+m8zWyZGHazNQ57gFihWuP2MIvn+fmjoguD8x9gyW/jHcV1leTEg0jgDAoBAEnn8O7xzs5xa5q0WqkW3ZKXvTJXeuLfQfFOd5ttuqEM3IQ6e1cL/sXFnqgf3a+XJ5cZZMjCDUxTsYJIn15UkgXgsqCV1KgEZLfIKltDfm6/brv2LgXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GsKUt5ndQlkwZEex0V3wPdDzGrr9hhL6sQ2S5sAPXA=;
 b=wy2W5zlzuEIXKyFpfDtBr9VKDbQCRI0qbflaUaEkdDBeHPsGJZKnBtU6uB0W8P6UmX1Tau4OkDxG1QauzPsGxwJnDa2Uajr0Ps0V0iqQREMhOYCxZdmQhjyh0gqKbn5RFtgRuXjvlmW22LBiAs88bwpWPts9FzT6gmSBDgYbi3I=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA0PR10MB7159.namprd10.prod.outlook.com (2603:10b6:208:401::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 14:59:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f083:4d6:5079:bf24%4]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 14:59:16 +0000
Message-ID: <d6bd8083-94e5-9bb3-7b1e-5bf6cc954baa@oracle.com>
Date:   Mon, 25 Sep 2023 09:59:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] Crash: add lock to serialize crash hotplug handling
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, akpm@linux-foundation.org,
        vschneid@redhat.com, dyoung@redhat.com, sourabhjain@linux.ibm.com
References: <20230925030701.338672-1-bhe@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230925030701.338672-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0211.namprd04.prod.outlook.com
 (2603:10b6:806:127::6) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA0PR10MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1968e3ce-3e43-41ec-5f26-08dbbdd7fd3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntYNkicr7DOAjtYADrQFCgoC4bS6WhSvNr1NWRvH8OXwLbFHxEzLW0uk+Ax9xoH7+SsH2+BZYOTXW0oSxu854+3NuUFCKMp2GSnU/TISiukX0k+N0CIJ41YeO0CryEz7Fvij971Eur0D3ibTSkDPU7gVtEytLWgs63Mn8qVHn+eJ8PO45GBTFzvMGS9mhHLJwrFtgOt2G0MvSwGb0fxnefiUpO4kJ8STmMqASX5DbvPKWtg4Jw4en6Gsa7tr9A8L1n16lZS/NEl385iAjdgjhXGGfynLtFfad4i/9BZqwfQDF2RBEAW3Cff5EELR0KZRP1yVwCR/N0DYtB3swayFsO4Lsv5He53U0eUeP/Zmc3iaZmYzG6CKv2TFDUwrYlSL4/fNmAt3CHn+SbIWGB4JgT8Pgdo96dbZc9DGGbB7EBDjON/XIFy9PZwKoDiFvkItTs/nTyejO2yst8ID/k4qfQehA0Q1itpsdWEFOgKlGzP5b4E0aCq/0v3kOhDi7X7sbXUxCCXXqGaGwkVfXX+DFcTR7IHvpUEltLK8ycSJcDTzDDoNrJDc/VFJSCMhhMhWuB0jURXgRWXQe/Z6vPbueRwLdNPCNTYoRiwI7iIVVjybn0YW62H5tOhAoESRU9mO4/N0JuBUBWAMQ8i/ZQ2Exw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(66556008)(66476007)(66946007)(5660300002)(31686004)(41300700001)(8936002)(316002)(8676002)(4326008)(2906002)(38100700002)(83380400001)(478600001)(31696002)(26005)(2616005)(53546011)(86362001)(6506007)(6512007)(6666004)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjEyYmMxbDNTOEJQMndQOVN2ZXNGakJ4MW1QbU1ZNGMyZjlEMFZnN3UwWjhi?=
 =?utf-8?B?OWNSQ0RZL2l5VE1wQUFKNjViTmZWOERLVHRnT3M2OVBxZ1B1NE9CMkl3V1dL?=
 =?utf-8?B?UmN1WkJWNEpkVWN5OUpmb0tTU2I5Uk9IYkVGLzhOMGtMNFRySjNLcTRYL012?=
 =?utf-8?B?TU9Ha0JPSmFNeEJFck9sS0ZTRWE5SGlSeHU5T2xQNlpHckZ4Um5TcXdXUTJY?=
 =?utf-8?B?dU14WDkvZEZYVUR4VlhpMGtkSWlvanNJSlhtV1dOSmZ6NzIxRmhPNkRUVlUy?=
 =?utf-8?B?UVMzb3hzUW9IZVUrT1FMdnVTVHp0VnZIM1RCaS9CL053N3BsL3lpV2JSTFYv?=
 =?utf-8?B?SXNFMjJOTXJ1cVYwa1NWdWM4Mms3bVN5Tmw2dElXTWl6WFRnRFdodEpnOWFK?=
 =?utf-8?B?TXZZVnpYNThhNzdISzhRb2NNZE1MOGU3SXpsSUtPSlFTRVJ3M3ZXVG8wS2tu?=
 =?utf-8?B?aGJ4K055TlZvS2NxTUE0RlBybmpNcHprblFia2c1emxDNjBGVFRHZkFZRytZ?=
 =?utf-8?B?MVRkUS9JSnZxekV2R3BkKzZTeVgxaER6RXdmVlU1bi8xY2lwZEVOUHRYWmNh?=
 =?utf-8?B?K2dyU3JhT1VIR2w2cG9md0VScjZpQkdTS3N1aVA3S2NiaUNPWUxrL2dzZVl0?=
 =?utf-8?B?dTJZQjlGZDhaaFFiSUFhTjlGMU1xeGs2blN4SjBXUFFDdEtvR1ZDMk52MlQv?=
 =?utf-8?B?ZGVtSmVQS0NVYjZvdUQ1UWlhL0txbnlpejFudWpxZDg1RTYwbnd5QnRoWEtu?=
 =?utf-8?B?bHRWVFM1OTIrUXRUK0Y5aXlGVmQ5V1RMQ3R5UHh3QUZ2M1NkY0x2bkZuWVR1?=
 =?utf-8?B?RGNLWVZrNmpEZ3BKRER5MXRvRVJla3BvYmwvTzRQVU9RaUxyYzJtZnNDZlBM?=
 =?utf-8?B?R3d1MHVYOW9RZFYzZitNSGFKdDg2NnNNWnJFbXFPN2pVcCtlUmVGUW9rZThB?=
 =?utf-8?B?N2UrWVJ4T3JicWppVXdDZ1REY0hjU2J4eSs2bzZRaVdKNGUwVTd3NTE0VXNl?=
 =?utf-8?B?RjdXTzI2WWE4eHUvU0lxVXBCVDllMVovS2tSbVYyZTB3ZDlyRjl5UTdpVWxq?=
 =?utf-8?B?VTdIM2lpNGdnSjFLc3lJdXNhcVdXS1RGVHhESVArc3E4bjRqdU9sUk9aVUp4?=
 =?utf-8?B?TEp4RWVodEZDOFVvMXpNNzl1ZzRCTFFVWjJGdCs1NWtBODJwODd4SVRkUytQ?=
 =?utf-8?B?bWtHT1UxdWRXME5sa2NXckl3U1poZXNTQm5WMkVVT1M5S2lIOFZhckhxVWVH?=
 =?utf-8?B?ajJ3MmsrV2lDMndKM0ZySFVUYTRDdlhQQzNTWXQzUGxsLzJuNmhRWFlTNEFB?=
 =?utf-8?B?VjdJaXRmeVFWTG9jNkplS0ZDVFRwNE1KQ2gxZHRvdEgrRUtyY1ZkTnRHdmdD?=
 =?utf-8?B?M3ZITThyNVZEeDZxblpUSGlZMXU2U08zRjl6bVI3WFV2ZUF2WWdsT3BYcUJM?=
 =?utf-8?B?T2owVGplTkltVVBFYStuK2F4b1hvYlJzazhBd3NjT3hPSWN4QkFNRksrSDR6?=
 =?utf-8?B?NUNKU3Q1TkxodVFvdzdVclZsbVVjcU03azR6S3hMb1o1UVVpK3pDOFhTK2hL?=
 =?utf-8?B?d2ZDUFZUSGQ5SGJVRU42SStqSEJMRkR0N1gxbkhDTndtNy9OOVo5NWM1Nmpt?=
 =?utf-8?B?cUswV1dOck94cUh1V1pDYWxKZDVHY3dZUkN0MzZOUzFqVzhpdWdHeW1qZHZZ?=
 =?utf-8?B?ZzJTeG43ZWJDN0RPaVlPOFhXekRkSFE4NFJJSWd6Z0RTUVc5Q0s5dTNIczZi?=
 =?utf-8?B?b1BVVndNeXVNUFFEME5TZmZ5NE1HOFhDdDFFT3ptbzlDeTBtUjQyNjhrT0lI?=
 =?utf-8?B?OW1uOFdwb2gxK1ppekRaWXlTT05jZjlkMjJ1REJIdTB0bFI3ak44Z3kyOUFu?=
 =?utf-8?B?TFViR2ZKSFdwU2Z3TW1KWlU2SlVqWTFKbzhzV3hKWDcrcDdUenhuVWVKN2Ji?=
 =?utf-8?B?WTR4dXNqa2txakxNMGZHVHQ2TlJ5aHMvMVdYK0JlekhpVEVVcnI5cHVWaVZQ?=
 =?utf-8?B?M3IySjM3MXhEdlRhdm1LV2FvbEJoNC92LzBiOEtZVnIyNnpDZ2RJN3pIOVRz?=
 =?utf-8?B?OWovRG1jS2NJdFRGZ091UnRyK0N1aEZpdlRUUjFTTG5LMFF4VWl5WDlyK2hl?=
 =?utf-8?B?NTk0dzlGYkgvbW54MjI4TUJod2dsWFJnOTVRc2ZGcDUxSTF3TEppbWpvWUFJ?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MnlBeXVXUzNhVlFGWXQ1d1ZKcnVUOTc0UTc3SHc1SzVzd1R4ejRPQUNpSDFs?=
 =?utf-8?B?dlQvb1Bwb1Z6T015MEVxOGkyd1prZ0h1V0lGUENSQTVISzI3TkVnZVhhOEpp?=
 =?utf-8?B?eUJlb1lra3k3SjBwMnQyMkZJcFZmRmErS1lkdGJucXdjL2I0YmJ6ZUg1MG1F?=
 =?utf-8?B?UGI5NW51eW9aZnFpa2RmTnA0R0pFSEJVNkZmcWsvUjgrVFBDQWVmOUl6Z2tU?=
 =?utf-8?B?bzBoRU9GMldIWm5jZytSVUxNc3NMQTg5MmMzZ2hxYW9zLytXenpudEcrdnp3?=
 =?utf-8?B?cCs1NldOS21rbmNNVWhaamw2Si9NT2luZXQyR2ZGVVd5eFUrRGFVUCtaenBu?=
 =?utf-8?B?MUZ0ajJIV2UvM0VNVGU0MFh2cVZERVdwR2E0RG5nVnlXS1NqVHFWN0pNMDNj?=
 =?utf-8?B?VWhGTmJEQms1N1V0ZE5YQklnV1VvQ2FReWdCWmJCWkdERFhTTXlnQ0lhY1Ez?=
 =?utf-8?B?TnNSbVJPTWZVUERIQ0x6ZlY2VjVXSUhGVlFjNk5WY3BCbjhvaXF5OExIZDBD?=
 =?utf-8?B?bi9MT3RlS3pHT2lXUEJ3TDNiektPU0Zaa25YVkw0aFJqdjhPN0h6Q0hwYlRG?=
 =?utf-8?B?eVh3aWRmbEx0WUlNTnFLRW85S05sSW03blZ4TmZHK214TFJWVW1lU1piUks1?=
 =?utf-8?B?dURGSis5SldBYlFuTlZVano2anBaTm1pd1JsMXRjaHljbHRMTnBwWnEvNEhp?=
 =?utf-8?B?Qk1kL1VXc1ppL1p1V2R2WVF6MjY3Ly9SMEhqWkpKVVRLK3hoWGE3YXowZ214?=
 =?utf-8?B?NUl4K0VVdk5DZ09weGd2ay8rbUYvRitZRkIzbEZHMnNvcWo3QW1yclZocmxI?=
 =?utf-8?B?QVhMQ2ppSjNvSmlVaUJlVkQyamYzOC84anpVOXYxKzFjUXMvenhlWTcybEgw?=
 =?utf-8?B?bWlHdlUvVlpUVEE2SDN6MVRkVlJkMzdTa3pMNCtTV2kyemtKRjRIaytYWXRv?=
 =?utf-8?B?T3NGVUFHVWVVSlB6WDlDblNuWGMySmk0V2RwMXY4ZEZ3K29xTDd6Vk8xR1By?=
 =?utf-8?B?eWp3dStqS29rRGtqeS9yUXZHUTJrVy93ekVYek41L2tIS285NEZzaCtNWnR5?=
 =?utf-8?B?ZW01b1VXVFhGckJ3dysvYmVKNEkzRGFxcThCbnBWbGEvWkROdVpqMjZoSVIr?=
 =?utf-8?B?TVRTeWtPaFlCM3NQb2YrU2lkK1BHVWJhUERmMTJHczhmZjk2UnJUZ0ZEQ09X?=
 =?utf-8?B?UjRlbzMvcGpyUlVVRW45aXRKNlBPOFE3anVBWWEzZkhWZUFqbi9sc1I5RFUr?=
 =?utf-8?Q?DVZ3k2gmYnI43xo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1968e3ce-3e43-41ec-5f26-08dbbdd7fd3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:59:16.9564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcAuy8AM5WWvcRX5kJR2bLwqWrXMlfLq+T2FXZaSSAak8/EZFWNZ34tx7O9VZ5JU2/rOpY4eMUIQPvlrBVBvW2zWPMi6UlIoHWqdD+sG4eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7159
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_12,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250115
X-Proofpoint-GUID: psTtsJrOr0f_nCYIZM34cRFgy9mwpc04
X-Proofpoint-ORIG-GUID: psTtsJrOr0f_nCYIZM34cRFgy9mwpc04
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/23 22:07, Baoquan He wrote:
> Eric reported that handling corresponding crash hotplug event can be
> failed easily when many memory hotplug event are notified in a short
> period. They failed because failing to take __kexec_lock.
> 
> =======
> [   78.714569] Fallback order for Node 0: 0
> [   78.714575] Built 1 zonelists, mobility grouping on.  Total pages: 1817886
> [   78.717133] Policy zone: Normal
> [   78.724423] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   78.727207] crash hp: kexec_trylock() failed, elfcorehdr may be inaccurate
> [   80.056643] PEFILE: Unsigned PE binary
> =======
> 
> The memory hotplug events are notified very quickly and very many,
> while the handling of crash hotplug is much slower relatively. So the
> atomic variable __kexec_lock and kexec_trylock() can't guarantee the
> serialization of crash hotplug handling.
> 
> Here, add a new mutex lock __crash_hotplug_lock to serialize crash
> hotplug handling specifically. This doesn't impact the usage of
> __kexec_lock.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v2:
>   - Move mutex lock definition into CONFIG_CRASH_HOTPLUG ifdeffery
>     scope in kernel/crash_core.c because the lock is only needed and
>     used in that scope. Suggested by Eric.
> 
>   kernel/crash_core.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 03a7932cde0a..5951d6366b72 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -739,6 +739,17 @@ subsys_initcall(crash_notes_memory_init);
>   #undef pr_fmt
>   #define pr_fmt(fmt) "crash hp: " fmt
>   
> +/*
> + * Different than kexec/kdump loading/unloading/jumping/shrinking which
> + * usually rarely happen, there will be many crash hotplug events notified
> + * during one short period, e.g one memory board is hot added and memory
> + * regions are online. So mutex lock  __crash_hotplug_lock is used to
> + * serialize the crash hotplug handling specifically.
> + */
> +DEFINE_MUTEX(__crash_hotplug_lock);
> +#define crash_hotplug_lock() mutex_lock(&__crash_hotplug_lock)
> +#define crash_hotplug_unlock() mutex_unlock(&__crash_hotplug_lock)
> +
>   /*
>    * This routine utilized when the crash_hotplug sysfs node is read.
>    * It reflects the kernel's ability/permission to update the crash
> @@ -783,9 +794,11 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   {
>   	struct kimage *image;
>   
> +	crash_hotplug_lock();
>   	/* Obtain lock while changing crash information */
>   	if (!kexec_trylock()) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		crash_hotplug_unlock();
>   		return;
>   	}
>   
> @@ -852,6 +865,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>   out:
>   	/* Release lock now that update complete */
>   	kexec_unlock();
> +	crash_hotplug_unlock();
>   }
>   
>   static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)

The crash_check_update_elfcorehdr() also has kexec_trylock() and needs similar treatment.
Userspace (ie udev rule processing) and kernel (crash hotplug infrastrucutre) need to be
protected/serialized from one another.

Eric
