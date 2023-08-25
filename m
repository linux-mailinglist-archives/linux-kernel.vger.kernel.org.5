Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2692F788ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHYSi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjHYSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:38:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054471997;
        Fri, 25 Aug 2023 11:38:36 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEMIo020630;
        Fri, 25 Aug 2023 18:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2sO74K8WAh3DUcBGditkI9d+zJMSb8B/4h9OQP6vhaA=;
 b=KobK0jDrN7I32WJ4CLBRUe0VUdUMRqM2i4JMQdoRneJ9jbslu+rw4ilsbJMGsVAZTPcG
 usioVxh1RqTIxaW+pPACWiqp0vZ3/uECS1AyRvGhFalUst2acESkLUbBiAaO6mFGz52e
 Hc8Kc5PLN0RTJt2weNIffMlsBo72vwj6ggSJwf3+NN5hKo0SaKZXdxVmBHF4EpXUCwZV
 ylna3Hg89WFTmoXThwVGBYMhMe7yyN0P8oqY9kXly9P9zkun0FPee/MPDM3dpDzHR2P9
 BkKDZftQY1bUzv+RcY0+BOaJAjdgtGkQnQeGV943m6xSc3Q1t1tR/fT3RPRgoCRRPkFP yg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu75gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 18:38:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PHNYtd002121;
        Fri, 25 Aug 2023 18:38:05 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yyf9mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 18:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIJ+XG7is383pOCvqGkL6Ocw7P/KjLVnfmt+xL/GBwikLtTppEkw2hndw8B2uJkO9C1FlD6w7hJv/udYLAVDHv7aLAMmrNq2lNyxFB+/OKmStAMqFRz2JlQU3+lwVyT/8ozIjWzVdmqKHE19nKyc7DSWI9HaqVkamBBsMH20vVkmuSeUZXXNFVMlGcjo8XnLiFq/QpKGfEo4t1v/BCSsssku5SgxCLgaxOgqOGYdiYAQH5GYLLeDIiIhzZaADLxUKsi60JcPUVWOfzjISuumSYgq/C+gw+y1QRE3OH55jaaujNLgcLYeSFv36v44qm51lmNGGT5SgKWqW4yb7dGo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sO74K8WAh3DUcBGditkI9d+zJMSb8B/4h9OQP6vhaA=;
 b=AZ5VwQ6kA9pNbrLIeXIVQkZQNu4S01dotzpGhvT0RPNveds8nQ4CubM8glp72UaIrqCpqpCMhuwahrYKjLyr47Pg0As2Y5TCb9W4g/f/JFqBbKW8qJr4wD9SChMnchtFJ+y5LNYDv0Q5YC2y8l0rp8UB/gT9QXe8vy6IhPWuklkLWB/siXWb1nlceqqZIG+EUyulor0lqSCdii7x25vuSi/bCdBs0Kye55CO0W3K57sxwKllxBj+f+N23JVhdchpsZ5ooEUPYXm4AbY34g+CuRSpSQbl3hSmlpj0hDDK4qVZRUmHCmYXd5uPWPh7T/U8g28srV+Lf9etth1rABwwLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sO74K8WAh3DUcBGditkI9d+zJMSb8B/4h9OQP6vhaA=;
 b=Zlg1gsQ63SlFi0SkOV1Uf8F4K6Qe2mvf2bBhg+etL0mbZ3iitSsY86OLZmwINkqCOw/M5/U0ETLqlIIUmYzqUq/n85xlFemREkRM7llat4cTVdL7KJxyEzvhDGVEusl/dNvybKjxGWKIWfDIqVF287YyKCGCatzdgPeWP8WvFwI=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Fri, 25 Aug
 2023 18:38:03 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 18:38:03 +0000
Message-ID: <94e08e69-377e-bda6-8a0a-8c83945fbc38@oracle.com>
Date:   Sat, 26 Aug 2023 00:07:50 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
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
References: <20230824145023.559380953@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::35) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BN0PR10MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 105a7ac0-55c3-4b75-1b4a-08dba59a6a75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjlbm4CgTUn2Wu1GXG3D4FvO3/o84/LMSbF76AMgiubJXbYrImL+vnr8eeM/d21eFqixqF/5iQIi9x9mMSMa0IRmh+YojYbd0oxaQ7fTgarr/RuxH1Ys+xB8CI4ufce8+ui4XJgdIMd38NbBcYIXUB/ca4D1xWeIV3LN0CgF/NXLJPyO8bTYbVXkUzT1eekON/FMTrqg5V635lIlN95Cs7saaHR/iSKydgvdXRVaODtz5BJwiD1Bw4ZHiko9Do7IwUmnZgO9VAAzKpSIZZ+n2LV+ZP4DAnOxAyOi6NxuwfJINw6Wvjmzl1hbpTYUZFMPA3kmAOL+gN1oAzgmrfvq67ufx4odJ+BbHLFN0ItB9ZPJiy9RLUVZP4ClA6jT6S1+CGARZuua1G5Dqpt4rd0f9lguMUOWA+Elqkw2FqSMnpDMZcJKSYnKWOQ7Df5HaJauOvvXvZn5NISCOVCKYNrO0GAG+TKEITAGGHAgP9nR6dW7O/3alRNgvxCnzIqaOe85eckpLYCOp8lMAGCRxwyp2RVi9G2NttEafPyje6fO93wrkB0798/vMlLs0Q1N7TJ+j4LXQePof6Ygdb5AzKApt0me3DSJ7aqKAr5ftkRzv6ahoMmT11Zb955GHxZtKz6dKGffjfg366oU0LUh+Q1kSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(1800799009)(451199024)(186009)(31686004)(478600001)(6512007)(2616005)(6486002)(6666004)(6506007)(966005)(316002)(107886003)(26005)(41300700001)(54906003)(66556008)(66476007)(66946007)(53546011)(8936002)(8676002)(4326008)(38100700002)(7416002)(2906002)(4744005)(5660300002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHRySC9GZWRsMmpaQ2ExMlB5TDNtenFhcHVjNnFmNG9oYWxrMk12Yk1QR3Rm?=
 =?utf-8?B?cHBaUkJDdS9ZTFB6N1ZsSDQ4dXFFbnN5S1Vqa3FsUk5BUUszQUVnb3E5NGtN?=
 =?utf-8?B?OGdIRkVIZWpKMUVUKzBqVjA5Z21FNTdvREhOS1dWeEhUcWFNTWJLUGlTanRq?=
 =?utf-8?B?QnhpbFgvVkZiWmV4WTRVWmliN2VuYW5VWnhQdnJZbjM0RFlzZmhKTVJEZ1RH?=
 =?utf-8?B?cTllVU9hZ0pRZWVKWS8zL01qdDdrSzJxaXpNNnpQRWpuZm9VM0RjNzEvQXdQ?=
 =?utf-8?B?T2hrZGYreDUvRm0xMkFSUkxKUHhDR0xvZ0l3SmlydHB1V0hLajN1VDZXK0Nh?=
 =?utf-8?B?eVBETWlSb252TEE0K3VRZFcyN3Z3VVRPaFRpc29VTUZ2RmYwdEhZOVJ3Wjdz?=
 =?utf-8?B?S1dwMm5BSGRjR3g5bVJISHBIaFoxZUFpdTUwb2gxU1RNWWQweVdnWFd2enhE?=
 =?utf-8?B?bE14YkpsZmY2V2UvdGJXdGJGbmpLaUUxNGF4OW1TNlBpdG5NYk5WR0lud3BM?=
 =?utf-8?B?SnM5UlFLcmc3bnE3cEEzY2JDTmp4YWh5VkloVjRMa2lyU2RiMHBNNmd1TFhJ?=
 =?utf-8?B?Rk0zT0F1U2V1b1VWRUZCSEFwbUo3a05vd0FRclhKdEdmMWZGVi9zS3NZSUxS?=
 =?utf-8?B?ZEJYNGF2STRON2xXa1ZxS0dvQzFoa0NwS0JPV1Zwb3lUbW43RC9LcVQ0SW1Q?=
 =?utf-8?B?NjVzN2hydlFGNHloUCtCdjBtR3BMcG9MUHlYeU5SY3dQSDRtYm8zUVZyVENW?=
 =?utf-8?B?cXZubVZWNmdrd2pNMlpOK213ZC9KUmdIMXFwbWNhWHRkRldINnh3QS81dHlF?=
 =?utf-8?B?N1JRc3p4WmZjbHpPa01sUDVrcmcwTzJ2L3RYaFFOdUg1STc4Q3pyKy9sZnlU?=
 =?utf-8?B?WC9BY211UDEwaTJTV1JOV3NLdTYzbThrYitpdy9jUjhtTTdsdVFjanZ1NFlm?=
 =?utf-8?B?VmFDQmlyMWJkY1dUTWsxQ3Q2S1BET1FobGJ6Um56N3NDc2MxTHc5cFdtYXda?=
 =?utf-8?B?M2pCeUdmZVAvMGhXbVl3NnRHTTBZT3BOQTZRR0ZsOWFYcWZ0SEpPVXA3UlJW?=
 =?utf-8?B?S3puSkJjT3F2TXlKN0dxNzVUMnE0dHdUTlRXeWlNbXZwbExyMmdmNUVPM1hC?=
 =?utf-8?B?R0Z2MlBaS3hETHZkdUNZMDN3Y0hRNGdNQ0hxS1ZzWUx5d2RRam1CY0svdXJR?=
 =?utf-8?B?YllSQzcwK045b0hFRXpld2xhV0c3RUxPVUVrVGdqM3NxRWVsY3hlR3FzbGZs?=
 =?utf-8?B?aFpLMHVNUzQySFVPNXBxdG5WZ2tiVkIxN1IvbEI3d1NjL20xNlpicU1ORytz?=
 =?utf-8?B?OGI5Ym5NcWZJV1BkVU8vSW84M1J4Rlh5U3dKSXFkUHlSMm42K0hWUGRJa055?=
 =?utf-8?B?ZDhjYzZkMFU5d0t6bDdGS2xCVzZpMUlFbnZNK01iMytXMVZadkxjR2NySkxH?=
 =?utf-8?B?ajRGT20ydjBxOUp6VGpkMU9LeXd0ZVFTQnJFL0FiUW5aVWJ1ZUxwQ1VjV0Jv?=
 =?utf-8?B?RU1nMms1OUNhVnBIWXduOGs0SjZQck5CUFZiSlpmZVJWVDhEOXZUd2haaG5T?=
 =?utf-8?B?L29ST0NUSGZILzFMUVNoRFh0NnFxRTBoemNaZ1pFQUMyaUg2NGh6a2tQT0Ez?=
 =?utf-8?B?aEQyODVNaEpDS3V5aDZWYVJ0MXF5THAyZzhvMjFSVHZEanA1SFYyR2NBbi9V?=
 =?utf-8?B?KzNDOGxQcEZoZENSNVJnbHFEOVBiczBpUzdqT3B0T0VGeEZhL3M0RzAwaUJs?=
 =?utf-8?B?UFBrZjJDczZkQ2tYTDBYenZoVDR1dmtTaHQ3ME11WEt3eitncTRBRDh3OWg4?=
 =?utf-8?B?WVlhcm5LUlp0VjVrN1VLc09oV3Z2VVNONndlcDEzTXhsZWw3K1NsTzZhWVRt?=
 =?utf-8?B?b095NmRoWmprcGp1Nzc1d25zbEE1VXlaT09Pb2Q0c3laSGZGNm9mcG1DOHpG?=
 =?utf-8?B?TXNwb1hqanJpQWRFaUdneSs1ZEV3am8rZ0tncXpkT1hlTnhtSUppNlJQK1JB?=
 =?utf-8?B?MG5uS0MxZlhrd1ZWUGg0QTdhaS9hRGtnbDBtZWVDMFVpREpTOUc3Ti9nOXZS?=
 =?utf-8?B?MGtXUW5JVndtREZLUEhVeHZFbk10QzFnTEYrOXdMM1RXMlRlenlDRThjaWFi?=
 =?utf-8?B?Z24vM0Z5RS9pYkZtZXY0ZEd0ekN2Z2k1OGxZcDV4OW9RM1JxcVlrbjVCT2g2?=
 =?utf-8?Q?Aw7QYRtYUe8i3k/BOEAa8Pk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RFBCTUhCQ1NLZTh6WEM5TnEwTmxqUzJvdlBERktEaDJaMzNMMWc1aTBTcnJw?=
 =?utf-8?B?Uy9LeVlKU1lmaEJsS0NQUDlzSTd3RW5OS3NKUHR5SjZmVmtBWHVBT0V5YUVF?=
 =?utf-8?B?N2dVZ2l5ZTNlSlFIem1jUXNVaUJjczdQVkVLdWhhcnYwRlZudEZlUzNzdnFi?=
 =?utf-8?B?TG9KbTBDYWcvSm80SVlkejFoMDdaUlJXMTc2NGJiZnh1Z2Frc2MvY1pUS2w4?=
 =?utf-8?B?V3R6eVFieUJWZFBycGNNM0NLRjdVRjc5cHluS3ZtL1JkaFYrU0ZrRHZYNDRy?=
 =?utf-8?B?TjhNT1BzUGY2dmkzN1ZZd2M5ck92aGovVlQyaGRUTXF5R29KVzUwUCt5czRo?=
 =?utf-8?B?QUx1YnZDWHlDeUdMVy9TRld5L2xEdGk3bERRa0s5ZVh0U2tZRmVpQlk4dTZm?=
 =?utf-8?B?OWpJTmlkeFdPVnJxNU9QNXdQb09DWXhsb2UrYVlRa05QVmFEaG5CdXNiWXpx?=
 =?utf-8?B?VUtkUXhMSnJPZzZTZWxrc3BaelZqN0JnN01IcFhBaGgydjRXQzF0aHhUY1Va?=
 =?utf-8?B?SVpUYjQzRjU2bXVvSkVCeHYveUpQRE12RlU5eVExSTJOWnZSQ25RS0liQlh0?=
 =?utf-8?B?R2dIRzdhNTRrdVp0MXl6VTM1ODV1WTJwWTZLNDFKc1dNQzEveFhPY2RpejRz?=
 =?utf-8?B?UW8vRmhoMHNyclNXOG45WGRlalk4aWFPbVRYNldyeWpNcm80SE1HS3hHNHdo?=
 =?utf-8?B?cGtZcXF6VjhwVFRpOVhscGM3anBpZ1AvZ2VBRjAzdy9yUWRJWTdKaUlEQkdG?=
 =?utf-8?B?V2pac2kyNElmTGhrSHR5Ry90WEJzcDUxeUJGMVdJN2Q1eVFWaGJUYUdDOEE0?=
 =?utf-8?B?MjNRUE9OTllXWVVaV1Z0ekc0UCtMNU8yOFZkRElVZXJVYUZNQVZEd21oMFJ3?=
 =?utf-8?B?SnVKVWJaTnZzRGpoa25IWi9lazNSTTd6czBhaDNOUHNvN252SG9YalZsZzE0?=
 =?utf-8?B?RUNmVWlSYnMreTZYaGJwenFoOVZOSE5XK3dWRDN6ZWxac1didGR4cjdSMmt4?=
 =?utf-8?B?dnVtT0xwQ291RWJJbnFsY0pHbEU0ZU14aDd3cE5ad1g2YW5zNmZ6Ry9Hby83?=
 =?utf-8?B?aEttcy9FN0ZUSjRNUUlhUldqQzM0S1Q2R3BsL0liNitnUzR4MzZsMm1VeTVM?=
 =?utf-8?B?WC9wUkpmL2Yybmg3dlhMUDRDMVNSNE5RRTZ3UHhwNFkzc05NaXJjdW5obGRR?=
 =?utf-8?B?ZlpmVUZZa0p3OHh6TXJ2bThUaFprSXVpM3c5ODhMV0NsVXVtWG9laGZxRFJa?=
 =?utf-8?B?d2dVaWtiK1U3TVpJZlo0UEQwUHhWZmVHR1g0bmNRTlowblk1MlNsa2pQYUo4?=
 =?utf-8?B?V2hFZlZYL3U3S2RWTUROb245bUxOUU1xOWZ1c09jcnRQbmVOR0hnUWlGd3Er?=
 =?utf-8?B?bHU4YWJrWExLK2RqZkQxTTNJQXQvNGFzM214eEZrWnoraEFGRjZZb0lDRC9l?=
 =?utf-8?B?VU5iRXhwSnAyditBNHpRdnpRNTFEUld5eVZ5QTNJWFFRa280cndYSlJuUy9j?=
 =?utf-8?B?N0R2L3RZL1c4Yko0WVEwQ21XVUYzWVJhNnBTL05INnBNL0lNaDVoSmtUOWhW?=
 =?utf-8?Q?BKB8OG9TRfhb39/HjBzbaJMLkteHlfKEUaNJAk1osYxmk+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a7ac0-55c3-4b75-1b4a-08dba59a6a75
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 18:38:03.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DMMOr8NGB3wZPyETuTNPnqOgiSYKl3Phj65CnGG3yhKolGNChZL7aqWEj+h/I7YbtiWj4Bbsh7FBByzxyoFZzNMS/tVsEW4xAYEFR41f0Kr207ogbY1pJqHSNTMVGBIW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=980 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250167
X-Proofpoint-GUID: bhzJaySJzfZWwmDGvIRt1DLs7tT9qx9Z
X-Proofpoint-ORIG-GUID: bhzJaySJzfZWwmDGvIRt1DLs7tT9qx9Z
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/08/23 8:18 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.
> 

No new problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.128-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
