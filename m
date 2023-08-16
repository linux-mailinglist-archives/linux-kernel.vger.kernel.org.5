Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0711B77DEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 12:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243901AbjHPK2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243897AbjHPK2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 06:28:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A9B1BE6;
        Wed, 16 Aug 2023 03:28:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FNPD45023195;
        Wed, 16 Aug 2023 10:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oPikfUwJ7HYgJSf8Byt0LrlXwhbW4WrYlpUEQPPs7EA=;
 b=QQPt5XkQ5U67AOl5Uz08f0o3RQXuTuDEGu60D5eRPckPaqxOYRPKm1cZINLkHM467ero
 hvy5yuBm6A2KJdoav1BlS15/a6xcckRdOw2+szvyaVEaCQg80madJmhR+2CJQAXCdjKa
 OC4IfKH1xzgNdv1Gz/H/m7D6A4pTwrR8X9Y+j22ljdrGOFnKEeomDdxOvAnuutz/z8co
 Cey/XyPao2jfG7G8s1AAxTWmKLKhUbQy3Bzdaa/bMH/d7hUmfZhLzTJoqySv1+sZmhhw
 AUq3E6VcpTtbCpKGNk025L6/rLs/6C1LDTY0J5rgBkJ6N4oOkw/TCA4yykqgas9pIozx 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfpnq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 10:27:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GABRw7000676;
        Wed, 16 Aug 2023 10:27:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0s127a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 10:27:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az1l7f3rcW454T08WhYz2n/7g8reTre07hgvwyLsxe+O6mrw26VSiFARsDHv+ABAi3FuNkCSU/EaWI4B1a394e9BvwyFO6B7/cn2pi2cSZAaFt8wW3wehP5gkQnHn9Y0qsVoObRM8AYUWrayQzwkYGGn6EHWKSQbSgGAOGUZDLfks74E1qqUg4jaxUGGErkDr4Qw+sTv6g70kFPds1OAQX5YdAs2+zuoTAgjRkwmJQvuyJwj/e0lXg9OsoX4FBUnvV4JzAu4IkIEZtmm9KG9IIfUI1XvAonq65sZJmrDEMjU7KRr1AZesBjRzyiiKDZgKxXSpZPRi8fSpXJBJU5DbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPikfUwJ7HYgJSf8Byt0LrlXwhbW4WrYlpUEQPPs7EA=;
 b=IvDD+s9IToy5BI7W+KJwcKbxhLefSIlPl2ZCeQBj7Io5BDbpg1wGY+Tdx+dCKAfU6DwSPuYrAbQOlGqkGy32a1p7kCNLlQttNu84aGLHpldFoLvYRrSdh+Ps/k0Ghfntu7lxNsRCPYJgIV2280W2jTZdeQvBPA89XaeYa+B4o+bUXuVhyiA7DLI5DdJIlGUNSuho2AkkPxbF5eK/nYf9tr0jRNAH7RnG8RpE3ifvos6l8Mvq3vm/2c4M88IMcb2Sfs84JubYdYHomXnJV6BJvWRh9KS9divTWM5mn27rVyVZeMU5TyBosHj+kloDDuRndpdUEjLR+GKYJYPqRSPdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPikfUwJ7HYgJSf8Byt0LrlXwhbW4WrYlpUEQPPs7EA=;
 b=k9h/xq209cI0v/3D59N2X8sZpwybkQn7AIXfmpjIhbxG5fUkH4W7DYRnwhFGc9PGFxMah8rwWHaRsU/724lrmUPJXfTfOOKqd2QAkP/fZX763zT3TuNbPlWu1AjFECSFJVxedQLhVCfVhuT2eYZ6p4u5pwf82VuJbn+3y7v2+dk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 10:27:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 10:27:34 +0000
Message-ID: <ff8f7055-70c6-169c-1242-25e6c56f87db@oracle.com>
Date:   Wed, 16 Aug 2023 11:27:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 3/6] perf test: Add a test for the new Arm CPU ID
 comparison behavior
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230811144017.491628-1-james.clark@arm.com>
 <20230811144017.491628-4-james.clark@arm.com>
 <3c382d80-7666-8207-a534-0b20807d3f6c@oracle.com>
 <fc71f840-8c4e-eeac-580b-5e0065a4cbee@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fc71f840-8c4e-eeac-580b-5e0065a4cbee@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0069.eurprd03.prod.outlook.com (2603:10a6:208::46)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 7233c800-d5ad-4ad6-c959-08db9e4367d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WRw3WYJa6M4iwE5RZpTfRCIZ0rNL/zA3q1p8Vnru6rTFyoIBjtmEedBxcE3dwOu4JEyX2+cIu5fFMGPd07Jpv5Nj81tQVgk8wV6t5Z+fqYR8OQSIMfQRJci7RkEpj0Kl6IdqdJ8jBJOknztUyZTMbpb7fYZ8jHLMA0ZnwAqctdIWoravfpmEqbfwKIqK5Lp/nzNqcqEodCew/8ri8bmM6W5KHuUAdK4YFPd7LIveVkiti6L33Tjqw077Hlyirn2KyHrgdC3qPLe/W6kYF4z6SnhNnHounX2y1j9kXf0IXQY/INsE6YdjQZTV6h1N1Tuf4bfGZYo6/EzUM5Ux3qi9pmcqlGjtGO4H247SUUs+iwtdYmzBXB79X8xX7gGOkl4+uAsZUnB6pFwnXNM7OaQzlmT0+3zBe4qXP+/wiOsr95rDPwZntqHqFu8nq9AgF8tJjpmVKuBVN02kRg46M+ayqSLKr4kpf1fI/HdZBVGR3lMnrjhiYW6I8tlXGYv8g87TuxrXss4tXFKaGIzI2oKD52z1Ip5JvexDQO7tXIZ/ASrpC4ZXJ0kI+ohG3CZMjYJu5gfTFJhrH1lk/G49Pfaa9d/Zm1KJY7qcW5Z098yZ6nXFOtCJai19KKCYjg+5DSgrgKfJdW9Qmh5EyzwVvRPIyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(396003)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(31696002)(6506007)(36756003)(36916002)(6486002)(2616005)(6666004)(6512007)(53546011)(26005)(5660300002)(41300700001)(54906003)(316002)(66946007)(66556008)(66476007)(31686004)(8676002)(8936002)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ladnhyODZLcDRHb3c1NUZsdGllaWxmS1lBSk9xLzl4bnBtODlINGdMSW1X?=
 =?utf-8?B?S1BYMVluQXhVMWlaWndEYzNjMldselpzUGJDbEdlUVpCUDluU1NtQWp6cE5J?=
 =?utf-8?B?SFBWZGhjUExSTXZDSk9ZVEdieUlVTnVGSjZGWEI0OWxqYlFPM0pNZ3g1K0l0?=
 =?utf-8?B?dm1rZ1cwMmJrRC9KYnljdC9ieVVmSVMzN2t0QUNxMkZNK09UMzA3UHNBSHBO?=
 =?utf-8?B?ajdNTWxRbnU2VGlxc1BPbTltMUhqcTFOMWJOeXE1aTk4djk5ZkVxeXJrd3dn?=
 =?utf-8?B?K01QSGRGcVJBd2FQWDFjdThiSHc0NVAwSWFWVzRzMnJZVkpTNUlxbCtFRWNz?=
 =?utf-8?B?Q2U4M0RYaXlIQWh6TFhITHVCY3lZQ1U0WFZTR3dJeHhnRDVXMXBkc0RBOXN4?=
 =?utf-8?B?VXd4YnhidVJYQlROTHNZcDVjenFva2lqTW0ySW52VFcwaDExQzFyNmdmYnpk?=
 =?utf-8?B?Z2RjL2pRVjVBSkJIdlRCRy8yQ3A2Z3puM0Rvd1FGM1lmbXB3dHhkM1hONkd6?=
 =?utf-8?B?L0pITzFObWNZUGFlTmRhUGV1NStRMnNYRWRmNTlwME12enM3c2NNT3pFbVN2?=
 =?utf-8?B?c3VHQUQrNnFlbHlCbEtzdVVvcCtKSkZTdDBwSzkzZzQxVWROSWVwZkFTZllI?=
 =?utf-8?B?QUNFNFc3ejJmNWE4T0g0Y2o1d0xXK3l4TW5XQTAvbkZ5dGZwY3ZhOXg5aFpE?=
 =?utf-8?B?MlMyNXVNTHdZSmRqcnNPQ0MwMy9NZEs1WW5OZld3dmZzNlh2WHMrajVFQXht?=
 =?utf-8?B?NnppNnpPdjhKVmQ5dGZXREU5Q2puRk5abTFxMUJyOHZtQ096dUVMTElpTVNL?=
 =?utf-8?B?dXVzWkoyK2VUTHo2YUkzUlBwOGsvZlA5dHp3c3IyemMrYUxQLzM1dmZrSmNh?=
 =?utf-8?B?UHgxbFRhNU5HNm5JWVpUVFdsN0dhQ1loVHZEYTBObUsrdnpDR2g3bUJzRnFu?=
 =?utf-8?B?dTJjRTV4UGFXa3pBR2RTQy9VV2pFaFFEVGU4bTdrdE52MzQwTnFzUExVSFNi?=
 =?utf-8?B?SnF5NHQzQ2dPM3dnYUVsN3pGZ0FkTG9ZeHVZUG11T2VGeG15c213d1ZpWW8w?=
 =?utf-8?B?Y3VqRTdiKzZQODUrVEdaNzBCZklpZkxvazQ3UGhpUVpzODJLak42bzdxa0NG?=
 =?utf-8?B?SXRhNUtEbFFxZ0Q4aTU5Z1crVmdZRktoN3ludzdVS3dlem1UWHRkS3dXWnZG?=
 =?utf-8?B?ZWRXTCtiUTN5amRjak1PdUZvMmxmLys5TUtmRG5VWk8zbUxkYzkyQ0VXOE9V?=
 =?utf-8?B?Si9oWitVdUxXNGVoR0pxTFlTQkhvVFF2U0NyTGJkb0s5L2NtRnVraHh0U1No?=
 =?utf-8?B?Z3dETjBvQWtPSTkzYmc2bCtkUUxReERUWCtkci9hUEFvYWFScWcyRTVDQlVP?=
 =?utf-8?B?OXZkS050eE1iRlRQNGRVZUxhT2E1eVFuU20raC9LekhCQ3l0SFZKbDVWa0R1?=
 =?utf-8?B?cGVHSmI4RU1rZEp3WjVzVHZWNnI3eXMvM3oydnd3Q0hwL0l0djBKYjBhbkIv?=
 =?utf-8?B?SjVyREVQcGZkYUl5OVIxQ0UwTkpubjk1bnBOOEhTTzROeWF2QTByTDZpSnZ3?=
 =?utf-8?B?UGN2TkwxVk93Q1F5VUdqY0RtMmQ2NitVcG5aOHk0K210R0d6eXdJNmxsaE1V?=
 =?utf-8?B?TnloMHpjMFVZMU5jL3NOZ3oxcW4zYld4UHZFS3FjK1VNRWx1V1lMOVdFK2U3?=
 =?utf-8?B?WDBHS2svYmNLL2hBaWtIdFhJUVdvR01PejQ4WGpCUWtJeXBTaHBSd0RwLzJ3?=
 =?utf-8?B?bEQ1ckZUdnZRNXdFN3kwK3Y0U3JhUGdEL0R5S3VTNmxydFZKUmFobkNqZlRu?=
 =?utf-8?B?MFpLWlFTU0JSaHZCYlY0ZzhsUC8vV0J6UnBUaWwyYWVvaEk4cDlYUDlhQjkz?=
 =?utf-8?B?Uk05MkVncDJ2L2NxTFV4aVY0dVJVc3FjUmV4ZnJueHhMVGl6YjBoTmlzcms4?=
 =?utf-8?B?OFUwVG93UHFWZldQMXVjRkczeTBFancyN1pOelhFcU1tM2Q1am8zSjV5T0gr?=
 =?utf-8?B?RThrS2I2Q3cxcFpxL0U0M1BrZXpFUjk4KzN0OHhuOHFPUXo5bk9USklKWWRS?=
 =?utf-8?B?VWRjVlRXMnFpaXBQaXBiYzZjN0RYZG5BTktWdFlkK0JNQ1ZYME1ZVWhkai9Z?=
 =?utf-8?B?WHJESXZyMlhPV3lwNUJ6NXJUVnpJWXgxTW0xU29USmNOdm5lYmZiQVdSelB6?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZmdQU3JnZkNVVEtFWFFWQjkweGdLL29ScGVhRUxKWDFybzlHM2txWDhwcEN5?=
 =?utf-8?B?WkltaERtZXhCSzQvbFJYZU1KdmJ3SE96YmxRKzVZK2YrN045aGtEWTlVeW9r?=
 =?utf-8?B?ZndmRHpEUzdjQnNmajlqSGhoQmxCNEluWVVMS2pCMnBGKzNYUnJ1enM2SUZZ?=
 =?utf-8?B?NHM4WXFDai9JYlIyL29zeDJhbHY0UDlhaHMzU0JQU2tLMFh0U1R1TTMvcUVO?=
 =?utf-8?B?VWYxSmhuQkFPaGNuRUhzd1NTVGo5Q2NObjBjeVV0TWhpamcxWVdPVmMyUXpu?=
 =?utf-8?B?SStJTU45Qm1JU0dCYWNjQkFVbmVveWZVTlBxTnVXcWlXbDhBSXRpYWUvQVov?=
 =?utf-8?B?djFyaFRnendzV3VRcVRhUU55TzFLd0hacGh6YjNDT1Rzd21JeUFoOHlybXZa?=
 =?utf-8?B?cThJQnY4RjJBaXUwTTlRZnNJVFhORnRLdGRlWkFmODh2cW9tSHJIazduK292?=
 =?utf-8?B?RElDQmNBSFMzcG5WMmczeG5Yc09ZUkgyVDdXdXlEaUx0YnUvdUxJZEVOd1BQ?=
 =?utf-8?B?am5vT2cyQTVwWFF3STZsYWFtYjc4dXdiZG84TWFCTytIRkUrakVuL3ltWG56?=
 =?utf-8?B?bThGSzJrS2s5VGl0Y25uWnRZbm5QcW9xTHNOMk8xWHpsMjZXYXZLaXBRZXNu?=
 =?utf-8?B?aWFRcnBUZWJtRTNMbXpsU2xkNmhqMXE5SjNHcjhpazZIbm1mR2JGcnI2SEhP?=
 =?utf-8?B?U3NjbUQrWGxIZGUyc0hoRm1MRkpxTFpMMVgxbVZMaDgrWlhmbmlRRUhzdkUv?=
 =?utf-8?B?OHFoS0tmYWJva3ZoZDF6ZG1TUnRQOHdHTTRKMnJwam9KdnRBZ2ZJbGNjZlZP?=
 =?utf-8?B?QndvaTJJa2hOZzlzcVpyMjRDTXFSb0Zoc3YyWE9CZXFDMTBWQlVvR09ZV0Ra?=
 =?utf-8?B?VjJUZGVJTitiMzdCaVRRaklUUHRBeHREcnZFRzltamoyR1VPWTl1Y3Ezeno3?=
 =?utf-8?B?RTh2TWNmKzM0dUhkRkpkcWhnblQ2ZWxzMWQ1d0JwWHR2WkpuUjMwdDRoNTJt?=
 =?utf-8?B?NlpBamhFZm5US1ZMOWlGTXJQdTFtOWg0OTQ2bGxWeEtXZG5SRDhhdzBsSFYr?=
 =?utf-8?B?eFRZNVlMeTN5QmovYXpHSkVvOTZmdDNVZEcreXd2bmh6UXA0a3diVTZBWGVX?=
 =?utf-8?B?SmNSZG9OZGNHQTNsOE5qVHFMME05aWVhQTFseGZwL2hlQUY4TUV5Ri9VWFl0?=
 =?utf-8?B?blNnK1JBNDBpZVZkRXFQdW5WdVppV1hPSHdYMnRGbnA5T0doU01xMXRwcm8v?=
 =?utf-8?B?SmcyVGI4dzdEUktZcjcvalBVVzFnakpkanRIQXUwTmRsaXcwUmlPZ01NQnJk?=
 =?utf-8?B?UWZVNVhFSE5aZ3VIeWVBeEpvWnYyYW11N1hpblRjbWwwRGZwdzdHU1ZXOHEr?=
 =?utf-8?B?dGtQOTJ0NSs4OW5sYk8ycVNheUxPTUt1SkhTS0J3QkFqTUlxUlFtbVE0anRs?=
 =?utf-8?B?bm5CN1F0Q2hKTjNsam0wM2ZWQ3l1TWFJTkVqTnlvcTh6ODlISzd0RFUzMXFm?=
 =?utf-8?B?U1IvV1V6akRXM1JaYWNFZFRNdHluSjdXU3BCMEJwRkFzRmEzcUNhS1MwL014?=
 =?utf-8?B?SDd3NzJXU2RYd0FiTGpGNysrSndzWEZjVTVhbzVVZGFBWFJ5c2QwNXY2NFJM?=
 =?utf-8?B?elBQbm56dGVsdHdPdEdVa0RNMUhSUGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7233c800-d5ad-4ad6-c959-08db9e4367d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 10:27:34.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Yi/AG7Crevyww9VWnPUTtVkKj3rPTr1F5A6xRT/oE0JR3cYHQhOYCXsmPyRlsR3jodQP93FvcN2aRbLcTaygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_09,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308160093
X-Proofpoint-ORIG-GUID: bRxYQ380uMocEvu2ef2jkd18LbTwvO6M
X-Proofpoint-GUID: bRxYQ380uMocEvu2ef2jkd18LbTwvO6M
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:14, James Clark wrote:
> 
> 
> On 15/08/2023 10:47, John Garry wrote:
>> On 11/08/2023 15:39, James Clark wrote:
>>> Now that variant and revision fields are taken into account the behavior
>>> is slightly more complicated so add a test to ensure that this behaves
>>> as expected.
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>>    tools/perf/arch/arm64/include/arch-tests.h |  3 ++
>>>    tools/perf/arch/arm64/tests/Build          |  1 +
>>>    tools/perf/arch/arm64/tests/arch-tests.c   |  4 +++
>>>    tools/perf/arch/arm64/tests/cpuid-match.c  | 38 ++++++++++++++++++++++
>>>    4 files changed, 46 insertions(+)
>>>    create mode 100644 tools/perf/arch/arm64/tests/cpuid-match.c
>>>
>>> diff --git a/tools/perf/arch/arm64/include/arch-tests.h
>>> b/tools/perf/arch/arm64/include/arch-tests.h
>>> index 452b3d904521..474d7cf5afbd 100644
>>> --- a/tools/perf/arch/arm64/include/arch-tests.h
>>> +++ b/tools/perf/arch/arm64/include/arch-tests.h
>>> @@ -2,6 +2,9 @@
>>>    #ifndef ARCH_TESTS_H
>>>    #define ARCH_TESTS_H
>>>    +struct test_suite;
>>> +
>>> +int test__cpuid_match(struct test_suite *test, int subtest);
>>>    extern struct test_suite *arch_tests[];
>>>      #endif
>>> diff --git a/tools/perf/arch/arm64/tests/Build
>>> b/tools/perf/arch/arm64/tests/Build
>>> index a61c06bdb757..e337c09e7f56 100644
>>> --- a/tools/perf/arch/arm64/tests/Build
>>> +++ b/tools/perf/arch/arm64/tests/Build
>>> @@ -2,3 +2,4 @@ perf-y += regs_load.o
>>>    perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>>>      perf-y += arch-tests.o
>>> +perf-y += cpuid-match.o
>>> diff --git a/tools/perf/arch/arm64/tests/arch-tests.c
>>> b/tools/perf/arch/arm64/tests/arch-tests.c
>>> index ad16b4f8f63e..74932e72c727 100644
>>> --- a/tools/perf/arch/arm64/tests/arch-tests.c
>>> +++ b/tools/perf/arch/arm64/tests/arch-tests.c
>>> @@ -3,9 +3,13 @@
>>>    #include "tests/tests.h"
>>>    #include "arch-tests.h"
>>>    +
>>> +DEFINE_SUITE("arm64 CPUID matching", cpuid_match);
>>> +
>>>    struct test_suite *arch_tests[] = {
>>>    #ifdef HAVE_DWARF_UNWIND_SUPPORT
>>>        &suite__dwarf_unwind,
>>>    #endif
>>> +    &suite__cpuid_match,
>>>        NULL,
>>>    };
>>> diff --git a/tools/perf/arch/arm64/tests/cpuid-match.c
>>> b/tools/perf/arch/arm64/tests/cpuid-match.c
>>> new file mode 100644
>>> index 000000000000..af0871b54ae7
>>> --- /dev/null
>>> +++ b/tools/perf/arch/arm64/tests/cpuid-match.c
>>> @@ -0,0 +1,38 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <linux/compiler.h>
>>> +
>>> +#include "arch-tests.h"
>>> +#include "tests/tests.h"
>>> +#include "util/header.h"
>>> +
>>> +int test__cpuid_match(struct test_suite *test __maybe_unused,
>>> +                 int subtest __maybe_unused)
>>> +{
>>> +    /* midr with no leading zeros matches */
>>> +    if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410fd0c0"))
>>> +        return -1;
>>> +    /* Upper case matches */
>>> +    if (strcmp_cpuid_str("0x410fd0c0", "0x00000000410FD0C0"))
>>> +        return -1;
>>> +    /* r0p0 = r0p0 matches */
>>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd480"))
>>> +        return -1;
>>> +    /* r0p1 > r0p0 matches */
>>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000410fd481"))
>>> +        return -1;
>>> +    /* r1p0 > r0p0 matches*/
>>> +    if (strcmp_cpuid_str("0x00000000410fd480", "0x00000000411fd480"))
>>> +        return -1;
>>> +    /* r0p0 < r0p1 doesn't match */
>>> +    if (!strcmp_cpuid_str("0x00000000410fd481", "0x00000000410fd480"))
>>> +        return -1;
>>> +    /* r0p0 < r1p0 doesn't match */
>>> +    if (!strcmp_cpuid_str("0x00000000411fd480", "0x00000000410fd480"))
>>> +        return -1;
>>> +    /* Different CPU doesn't match */
>>> +    if (!strcmp_cpuid_str("0x00000000410fd4c0", "0x00000000430f0af0"))
>>> +        return -1;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> Would it be possible to put this in core test code, since x86 also
>> supports strcmp_cpuid_str()?
>>
> 
> That's how I started, but Ian suggested to move it to an arch specific
> folder because that's what it was testing.
> 

Yeah, I see that comment now.

> We could still add test__cpuid_match() in the x86 folder rather than
> adding it with #ifdefs

I was thinking to make cpuid_match_array[] exposed by the arch code and 
have a "weak", i.e. version for other archs.

, but I don't think it needs to be done here
> because I haven't touched the x86 code.

For the moment, I don't feel too strongly about this and it can be done 
as a follow-up

Reviewed-by: John Garry <john.g.garry@oracle.com>

> 
>> Maybe we would have an structure per arch of cpuids and expected
>> results, like
>>
>> struct cpuid_match {
>>      char *cpuid1;
>>      char *cpuid1;
>>      int expected_result;
>> };
>>
>>
>> #ifdef ARM64
>>   cpuid_match_array[] = {
>>      {"0x410fd0c0", "0x00000000410FD0C0", -1},
>>      {"0x00000000410fd480", "0x00000000410fd480", -1},
>>      ...
>>      {} /* sentinel */
>>
>> };
>> #else if defined(X86)
>>   cpuid_match_array[] = {
>>      {....}
>>      ...
>>      {} /* sentinel */
>>
>> };
>> #else
>> /* no support */
>> #endif
>>
>> Thanks,
>> John

