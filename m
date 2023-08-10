Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFF777598
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHJKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjHJKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:17:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6EFC5;
        Thu, 10 Aug 2023 03:17:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A7PhMx004124;
        Thu, 10 Aug 2023 10:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5i1v6YxD9Ba1EPKizvZwyqJ2TcIgMB8Qf3jjf1dvbPc=;
 b=bZ4px62bc8zi7VDNQVKGIbyda+HdvgDo9GI4pnoV54nrQkbdMsgXon1PSuwJQ7cgkmh4
 J3dPdMrfY/fsJqPtAT5cooeQT0gm0G6DUKXVK9fSbBA+MysOW7/Qy3N1pmxEUkxZlPmn
 gnmVHLKK3iWfAK7O2/xI7C1ZY9I4CF5Kv+a+9yw2WsHDh83mHkYzuqd9c7lSl3XMIqC4
 nQR25mY140W/Y33xC489fn7wbmLxSSiFIy11Zf52O5SF+om+RiynEg1YnkGzyDVX3nZM
 bAL14sRGSSnvARqCwguJpOyAo05I0xFn4pAm1R2VV8P9liXvtXubYM113aH/yVZiPZR1 /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1uas1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:16:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37AA1vp1007968;
        Thu, 10 Aug 2023 10:16:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv88gtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 10:16:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JypJ9r19K/f9tPCnpyp5Pb4IsFzF9YZcSGohnmwX0NrkKM7qe2hSclqLxhk3qmE2/zsGHWg+2y/iSj9bZUNYdGakas1jjNDNpdQO6JGvh7+nv/A5z6N8M1ymz6UI6ruqymcv08BEVjeoE3yP4wWgwv4sWmpWExU5R3OQ3QBpF6M+5dFb7Cz7bJQo4KPrA7exT0cZT0dhI5wyubxxhqymhw4PxNCdA6kXwpmulCGsrTymWLzDqxiA9cfxHysfkR2oY5KY0sKwrF/DpAKUEIn6V8YqMQ1LqwZmn3S5ODeraLsewVx2/ofEaPMfaIHzofKcYuOC1RgL+0waNM9oXOR2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5i1v6YxD9Ba1EPKizvZwyqJ2TcIgMB8Qf3jjf1dvbPc=;
 b=ZtvE4fXLAW66dOIEVihy+TyNj25BJ9rofHOWNDHHynAH80LDCNSJ4XVo1rI0wTUnJEwAGLxpNF10IA9VKbBrzQ3E/z83vJkSpBm9OOQy+o159Yvkgf4TUhVJF7zMVfMWoWU+yju8mXylassgoZW5SFgMtz/Od+7gmsbtyZIUiERNjOC4nJ0uq0sExbE0TWERE/e2nMhVyHlYQHulJrM2b1Dob+qGwbsoAxZjzauEMG4nzUN8gCACKsCOB8jxufWCHv8vZ1UZJgy0kAl2pPZveRJoHxLnU663fcfr51l+OqvCKiiseL6Tmc7IXsuB8lKU+QHAyBrJ09g6Lst+MHhwEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5i1v6YxD9Ba1EPKizvZwyqJ2TcIgMB8Qf3jjf1dvbPc=;
 b=Ftmn3/9WL5MnbQKw+JAl4DgSLZmyKMVud+tcN8JXcCkXu9H342qTD8CdDaNApYssShhtUZz/lq3X6MFxKXUYOqvdkfeZK2q7UJiwtSuQYL75wLq47V7W/3Y/7YdhA5xqS6iUMpWKDqypcPQ+bCNvCIVYJV5n9Hjj2esW0ZRAxJk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 10:16:24 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::3ec2:5bfc:fb8e:3ff4%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 10:16:24 +0000
Message-ID: <3474ec1e-eb15-b2a0-003c-327d6fd17708@oracle.com>
Date:   Thu, 10 Aug 2023 15:46:11 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230809103633.485906560@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5a794c-9efd-481f-e9f2-08db998ad980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaVY5UttDHNZOGdLD4SRGNXI/+ouzdVygWVYJ06pUKlMLWVdrENwLr5AZ/Nu58UBUjG4ctRXOhSmc1RYeCI78hMupyXs4xibqSnVanPChzwMu4MXY5CXvYRY6TuPcq+uvIQdtsktA2O5JsESUUC9zhL/8/Q3YJEB7rfLgmwDjq9AYut7i1ZHZfk/B3X+T+axQv6IZgaZMbhZzh/ed/WGKSncX04pmydZWHWkfOOKVOp9UMsuC8gIfNBDf0sEpgLaEqIV/1+III7wRNR2lLX/peqfK/+bG4q8nGWInsDxnWfirfr2kqUtIkcrgSBvk9dGP2kidQRcsTHuvMiVlWBg7sxCjQagOpEXINq3OnOwb1byxKSAOJv/aPS8coChQ/upEIVjZ0a9gjoYX3SVTgqOqWcIYerLvtrS8ojKlOEwckREE9sI3MBDYQqolO6jX0awnxz7wa04XxgxzUAV4yQ005pePDZHdkuYbT5YVotIeKqHo/87crfqnoAXhtz0nC7vkD+6UHd5SCstn++nIyVMo7Gg1ZLNHzMN2Fi3qBB//do3SE/IhM1LQMADiIypgAxf1aJK9rtYOmorZDo983teNZHtvo9NaWMpMS37UDMxCwhm25POmU1PsuHUnsUe+L+SSTRJSW5pvVykWK/F6lsHfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(396003)(136003)(346002)(39860400002)(186006)(1800799006)(451199021)(478600001)(6512007)(31686004)(966005)(4326008)(66556008)(66946007)(66476007)(316002)(6486002)(6666004)(41300700001)(8676002)(8936002)(5660300002)(6506007)(26005)(53546011)(31696002)(86362001)(7416002)(36756003)(107886003)(4744005)(38100700002)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U05jbWxvdGZJcTVobmtKYkczYU5iUjF6ejdXbGMrUHdiSG9zZ09PT2trTmJm?=
 =?utf-8?B?cVhOMTl2MGpoenJMbFRJNC9DdllFclo5Q1pFMjdVZ0VZeFpwbWw3SlpEZkNt?=
 =?utf-8?B?Wmo4NjRIeTdad0hlZ0lKNU9seXY0cFAweXhrUzZCWkRrbHExeGpYT0hpU2pz?=
 =?utf-8?B?YmVpMlJ6eGxlUGk2VXlkWkI3bVRFcWNSVjliUTl5dGhlYkJwdGRaTTdFUTln?=
 =?utf-8?B?NTMzZWsrWG5GNUxsN2hTYzNlU3p6WktESlRaOFZNcHlkSTB0N0FKN3ZiOEJ3?=
 =?utf-8?B?MUsrMG9hWHRjVFRrRHM3d2pFRWhqcHZCcHc2NmxQUEJvbDZPbjdQTlJaSjhJ?=
 =?utf-8?B?VHVUWVBVRy9MSjExa3luTEJrS1dVK2NRbm9SRXZ1SWZEZURKS1QxYlRsa1A3?=
 =?utf-8?B?SWJ0ZG9KMG5QNzA2RUx0NlhwYUtsUnBtenJPMHZuWnZDZStjY1QwZzFrVVpJ?=
 =?utf-8?B?bG1nNzI1U0tQOXNQczByKy9ZNEY4TFp1R3dRRG5zbGZzNCsxMXRwZ29iMlBL?=
 =?utf-8?B?U1JMTlZRRXZFZFVFMzdEeUhFQjdsb2RzQ3JabnMxT0pRSFZUU1V1blBacXhY?=
 =?utf-8?B?cktFTWF2b0hyUGhmMGJCUWpIWk9BZUxDbXFidTg1NHpQbFp3VmcxTlZuS24y?=
 =?utf-8?B?SGFwYytFRTd2ZWJIQ09FMWxqZ2xjdnlOeWhzRkFWRlNzdmJGd2U5RllTaVdN?=
 =?utf-8?B?YzNLaDdVald5TFVzTEprcnA5Ylo4NWJBaXUxVU1GSzJqYUpvRHlHalV1bEZk?=
 =?utf-8?B?eDdrWnJVeldIenFWeXlHRnpNUVhCUmRXS3RFR21MZWwzRzI3R2p3emVpZng1?=
 =?utf-8?B?SVpITzRTSk5sQ0cvS0dnOVllUDNPbEJ4UFR5Ykp3cGlXSFNuOWk1ZHJpZDdZ?=
 =?utf-8?B?R2xRaFN5THJEMzZaZzJsbjFVckR3UXB0b3Q1cWN3Q0JSSGNPM3BobHVSNGF6?=
 =?utf-8?B?Smk2V2dNL0pGN2hHTFlNQXpaeldwdytWVnBmWlZDWkJ4NVNDM04wMGFVWDZi?=
 =?utf-8?B?alFuWTBlTFFVSGtPbS9nYnB2SEhlbTlaZ24yQTlZVlFhazFFK3ptSjZKS28w?=
 =?utf-8?B?K2FEVGpSRldqWC9yVWgzL3Nxc0NnWjlncGl4dmV3UndIN05ZYmJMUnluRDRz?=
 =?utf-8?B?d0haVDM3ejBQQlozbkFmbTM0S2RMaktLZzYyOS91d0NhOXZoeEZ3UHF6STVR?=
 =?utf-8?B?MlRXU0ZnM0FsMG5CZnZabmU5U1J3ampQT0dKSTE3OXA5cFYrOUdoTjNPREVO?=
 =?utf-8?B?UE9icmw5WG5DbVI4Z3FxODZxVWk2ZUF0M05RS0ZzKy9ScGRBZ0UrV3hxdDBW?=
 =?utf-8?B?NHVKRmZyWm9TRkJzbFJnNEpmUUVaaUc4NS9jUmZUOG00aFY2NENYUjgxNHo4?=
 =?utf-8?B?MUhUNXZkZXdoby9iNkthYzE0UURvWnBnVWFrYUlVR0JsRE51M3hZTGpJcXc3?=
 =?utf-8?B?cThSNUNzL0tiSnlnWHg5dDM0Y0k4eHhzMlhWbUpPcC9vSldMVWhPWkppQ25G?=
 =?utf-8?B?ak1lVjZzZjJhbzJRa09odDIyRWk0OVcrajlaYUFsZVQ4ajE4VG1OV2ZpaGVY?=
 =?utf-8?B?SHNBVmRVMVU4UEs1N2F2R2hWbFljcFF5eHFyMG43ZDQ0MEpvUEE2NU03T212?=
 =?utf-8?B?NkV6c1pNWlhqVWlEK3RGWjJnWmswS2RFSmkxYU5DaHV2YlB3elBEWllNakdH?=
 =?utf-8?B?MGJHdThLaERac0pPaUpzUDBsQlFlZGVGekNLUkd6SytkUVdQZGxmdFdGU0pQ?=
 =?utf-8?B?Z2lhbmlTelVjMHZaRG5RVVVXbGh4Mlp2dGcvRTRZMm1icjJsTGdiakNRZjVK?=
 =?utf-8?B?SFVkclEvT09EMWpGSWkyZ0pUa2lHWEpwWG04R3hmK1ptaFpTNWFabHd4dEU4?=
 =?utf-8?B?bHpZUEE0eEVpbHBDN1Y2WW5oYXJWUlFaa2FpNnpsRlArSU51c2g3TE56UlFi?=
 =?utf-8?B?dDA0dlVIQnZreGJyRjdXcmdXbE4wdExhQmwwa05wdXFleUxYY0JET0VreHZL?=
 =?utf-8?B?RGpvUTlnSmJKc0ozeWMrZldqaytQaU1FRlNETmRQWGJDRjdmRXdUS3FETllk?=
 =?utf-8?B?RGJ6cW1IaXdTL3U3eFdKTjRHcHVab2p6Y0Z4Q1FlZTA4eU9JTUkxNXNtenJ0?=
 =?utf-8?B?QStVWFcvd09kM0Q0aDZBMUJTMEpJd2hKSnNxYjcyUk9ES1VRVmVDUG41RHRC?=
 =?utf-8?Q?id1k7/QfCbaYiEWX/OttT1I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bUxtV3Evc0R5OEpSc3VqblBqbW5xcVBDQkFURHpHRlVNdThZNGlacDNsZGI1?=
 =?utf-8?B?T1hqajU5R2c1a0xUYnE3Nkc1bDZlcWNCeTByK3REbUFQSUJEMlR4Z25Zd3VP?=
 =?utf-8?B?TVFpb2tjOHZHN3hqN1Q5R2tiMk1SU2ZpUFBuNnRVT0RHZmc3M2RLbXFDQ28y?=
 =?utf-8?B?SWMzZ3ZidzBWV284b2ZpWXdhdFcvazJwd0FzRDltVllRc28rV1NROGtvRGhu?=
 =?utf-8?B?V3J3YThWWXk3bmsyTTUwT0lMa1A1NjFKMHBEK1ZXb0lkbUhEQS9NWWhZQ3Bw?=
 =?utf-8?B?ZU1qc0dJOENCOVpsbGdEdkJONzZ1T3pXVC9KNGNobFJ4d0pFQ2M4d0pKN01i?=
 =?utf-8?B?MlpNKzZZZGlySlFpKy9HL1UyN2RzVmcxMUJRSUk5TitxbVhrdGV0NTRLbCtD?=
 =?utf-8?B?UGRMcWNRaURnQndHZ244OElnY1ppNUEyRitNRDlPN3k4K1hiZFc0UGVjUGw2?=
 =?utf-8?B?bkVrQi9tK3BlOEdPdXQ0Nnljck5ERDBUc2xKcEhKOGFleUhFb1hpSUJ4MFRZ?=
 =?utf-8?B?U0MvSytuZ2dNQTB3N2M5ZHI1RDFSdFdKTlhwbmRwMjBPSnpMUHRlOEQzRFdn?=
 =?utf-8?B?WmpxUG0vMk5CbitJdGtQbXBXOFplMkhoVmJ5TkpQVEREVml2N0h6d1F3YU5r?=
 =?utf-8?B?U2FjVlBWWE41N1J6WkJJV2l3RzllREZ1YUI5b2EzUnF3RDRZQTBUd2ozNE1D?=
 =?utf-8?B?YnVhTnVvb210UWlmZXFWdjR3RzNrM3RKMkh5ZHFHaURFYmxIMUNXQy9mbk5p?=
 =?utf-8?B?UHJZa0I4aTd5K3hJNlNhdEV3QmJmSHY1VktTUHYxaW5BV2EyZzdvdlREL3dU?=
 =?utf-8?B?WTFtSnRnZXI4RXBXcXV4UTJxQTRNbFA1YmM5SDltblNYZ2VNcmRacnJZVUIv?=
 =?utf-8?B?UkFaZnVFaWJ1d0MyTWtpSm55M3ZFS0RYamtmNkRRcG00a09RNlU3dGZjZ0FR?=
 =?utf-8?B?NTZVYzBwRENiY25PMEIzN0Q1VGhCM2tqMW9Uc1NEd21YcFJ1bHZGV0gxNXZF?=
 =?utf-8?B?UzZ2d1k4Q0FKdXc4bEVjY254QmlqdWIwN042YkExRnZmdU44RlJpQUxMd2xT?=
 =?utf-8?B?U3M4ekxpbWVvV0xtekFLT3dOMkhVaFJNWkFwQkZuMDJjaWVDazBhV082UVNm?=
 =?utf-8?B?cVY5cFlSSWYwbjFSV2NVTk4zWG1tSzdrVEUyZ0toM2NsSlRNSDE2dGpFWW5t?=
 =?utf-8?B?UmVsMk03d1dYZXE3N2xoRTdZb3EzREhDVE40YnRNNnVRVkRuRHhtelFyVG9l?=
 =?utf-8?B?bmhFay8wZ1dLcFUvc0lzV21PWGNQMklUc1dSRno5b0tYYXZMYTd3ZDdCcmJi?=
 =?utf-8?B?NkwyVXVqOG1pNWtYWTN2dk0wQ0dmUHhRYk1NZHljd1BlSHJIcHlvbVlBLzhE?=
 =?utf-8?B?ZUtBb3hRNUpaU1UwQ1NJT0UyRGoybnJFNll3TDhhSEpYY3ZYRlNxZzY5RTE1?=
 =?utf-8?B?VGJ5QWd2dDNsMURiVU53WDVESVZodVg3cjE5dkIyT1EwR1lza05xbzZiRTA1?=
 =?utf-8?B?YkV6cm13QmNjSnhCc09XRUNscWJjRzQ5Wmc2K1FjMDVVOHV6YUZ6OGR3MmdU?=
 =?utf-8?Q?qdwQffnIYIYHAuMHlvfxh4g8cwf+q6hD8iDiiI4UiF7uK4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5a794c-9efd-481f-e9f2-08db998ad980
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 10:16:23.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MNA2BDvGMkWk/KvTUqPXyZWh2EF76ZAJ1Pm2XuwXVqG1DXGVx3NXjYlrPKeijU29nSv+B0UJkeGA54vhxrr4kue0QlxMX7K1V36s3QNipaB6fEktNtpDSpbKaDugvvfr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=975 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100086
X-Proofpoint-GUID: 407RViAVLesl6gCK5yP-wtemC79caakQ
X-Proofpoint-ORIG-GUID: 407RViAVLesl6gCK5yP-wtemC79caakQ
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 09/08/23 4:10 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
