Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAAD804AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344480AbjLEHRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:17:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C4AA;
        Mon,  4 Dec 2023 23:17:29 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B57Cvso007782;
        Tue, 5 Dec 2023 07:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=RCA+mYXiG2p/+WriW8UELGUgYhMG8z3MtaHTDNi4Ofg=;
 b=GM7MAsExP1wd8VvNNx9h2Uta+5IGYvP0lcHfcuC6mcp+UBCgHCtFwrzPxnmbtPcWXBCZ
 hFv8H2TCK0HWV+AuUYhhot2AqlmlDdENSX5Ov27498VVzX7P8OIwRMtGzOCdYGEsXHoR
 rEdN4gI7Z3WdAIi2vVctgI+2HKZeOV8p328NyWiq+yCIZ2LZE0sfCHMSSdeMoPYamf1L
 qLOm8dF0+5b0bVcujOMt843Zj1ISmiwWkDTCPvnhIRVAS9sbjdPj35M4bBSf71LLoEKS
 U2z4jETjLAvA6bGnoT8oeWTkxM3WCTsXONMag/jJyCQQnF2YtYm7icIKxni4dvqdGJ3O HA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usy93007v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 07:17:00 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B55Xer2018432;
        Tue, 5 Dec 2023 07:16:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1700vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Dec 2023 07:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGTFAZVMjdfT1TyDEhxhNH0mGa0j8VArpcyfAL7JvEcpi2Wy/OXiXxbYY1ngz59nKmSkxxm04Q7HEv715f4tBIsrpr78b8LezVYomzDL3mWGPWtmYVSZOgcoyutW/uFDF3Z2QtQAeuPNX+aFl4+v/YGLQIhQ3AHnURXJnzNhteHerQ3DrJO98mK3uJMALf50qiYRnivLomfxsJgjBEnmLlscx8eVTqa6XIJmt0ePBWEiv09gwJ/GS2/Rach6mtwDKDyXbkSjekPvWgXe/8DLXlvelISxGqz0+0JRW33a4N0PdfkP+YhOaXpQoKkQYZwy/33qgayysWsHkVqql/gcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCA+mYXiG2p/+WriW8UELGUgYhMG8z3MtaHTDNi4Ofg=;
 b=oS0B2UMIhj+Llyewx/tNaVcnwElLnMb2sdSJZdeDKWym6Iy8wAOUM6UUngYZTeVjB1ljJ5PKEEf5rMHOL83GSkW/YXa2sfvmp5emimqmXe391h/nhiRhRWe0akDz6PH2mu+LF6L78kORdcDY/YI+WEbZcHRiuzHN8I3Ol71roNUJcf/Qv/akLCSp/RDHNWhU1+APODn6JD894QMUAsK5Nlbb5jeSHZAd7Ks/iJEj7Bq9L+0DTc9nZudMDn01m+ucAHwl5fsYaILINkTh6fM+BjXkjJbvdm5DrzeCqnoEwYWeDR4VcH3SDwcNs6QMHUU+JEAUWcwRrkQ1VVIj8bZyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCA+mYXiG2p/+WriW8UELGUgYhMG8z3MtaHTDNi4Ofg=;
 b=GAoB+JYSTZhrWIAmWiC7FkMDeLr4GvBnrNZqV4HulMFiEmg9s/qU5naBrOu6gGwzrrjNQf18e8A3y/02U0MFgYN8n3PJRwIhlNkgoHZhMkoQz4+kxW6/3DhYBhRSAqTnkrpi+QGvcBl50zbEjaYbAdi2r9PFx16GaGZR7+wGlbA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA0PR10MB7208.namprd10.prod.outlook.com (2603:10b6:208:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:16:56 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 07:16:55 +0000
Message-ID: <c8ebf598-4d9a-4ce0-bccf-2109150919dc@oracle.com>
Date:   Tue, 5 Dec 2023 12:46:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
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
        Darren Kenny <darren.kenny@oracle.com>, namhyung@kernel.org
References: <20231205031519.853779502@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA0PR10MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: cd681a4c-2710-4166-cec6-08dbf5622976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ti9mjY/x2bqdtuRqHMGkVu6FbxKH4xQi3bSx2dbPXjKA03Vk1Js4uVSweH5TliuZZW9XnVkyC6GQylZB1m1qFzJo0iXn6nALbW5ArdwYdbjmnKCWvyW5sKp+VZk+DzY2ORMCXNxajKWnXYJzjI3UnkCIcYzZYlNB3kxpLJoL/ge4NJn+2heGUtfijIctL5kcWAZ0wJo6uzVg690FXjvli6KlVFDJSQl5KfNs15bY6OttU1kfw3Aq4OIPdR0a2S6P9d7UvUh2UsJVTi7QhMNJERjHO9B4Fenqpj6s6GGHmUgheZkH+jigQHVfzj+JuwmXZeGDUncg33wsWPsB00cvuZykanTjaGqD5tDzUPjUQ83ucyZBGJplFrLp5DtIsAWGSbo/t+bNbOS+HDcodJzzmFmDzRB12tuORtUjRKeu6OizF8XSua5uzMSgefrBgQ68+O4fTYkfo6EKp2JMOPIo7oi38WWWYyQnMjiTBu1UBkpcGR/gQnSiMCsNa8ZdQiiiGvrqF2dCHSDzNRbYpfVOxouEx9WM2C9cd2mYVbFVH4dNTmUaFfXapGbjzxy9xmyC4tWkGKzm/I+iOFRT8TvmIyBvqFJOif0MDMSRsvgnETzofQc9DdwevcvH3KnKtq8W++RZuV173LoQkdQ2yP7V5PnFi7rnfBjRkfMBe2kSnjcIzYhWFpLCJfB4qOo8xgJa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(7416002)(6506007)(6512007)(36756003)(53546011)(26005)(2616005)(41300700001)(38100700002)(86362001)(31696002)(83380400001)(6666004)(966005)(478600001)(2906002)(316002)(66946007)(54906003)(66556008)(66476007)(8676002)(4326008)(8936002)(31686004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGVWWi9lQnR5VndpU0lBQTBQelV3Y3dVc1ZxeUt0TitCaGVaRXJsMDRrekxX?=
 =?utf-8?B?S21SeHRld3F6RkNPZDk3bjh5L0psYnh1a2cwcDZ0WFg1ajRzdHVhYVVxUWJG?=
 =?utf-8?B?OCt0b1p0M1N0b3d3QTRGMjBJUVZ6Sm56L1dNZDlBQ2xINXQ3ODZiRHNCeStF?=
 =?utf-8?B?OHJXdWVHMzJCbGpWYkJWckZ0cVhRVFRkak85bS9XNi9jUjNqZDBiMXczN2VS?=
 =?utf-8?B?cXAxRmVOMk1hMjJhTk1kWEZiMWo0b2szL2VaUW5EcGh0UUsydnNqZkJDbEs3?=
 =?utf-8?B?WklwcjdWZzRwTDNaMlRmZ21aSzdsc3NYaEF5T3ZzYyt2c0NvUXEyRlhKSmlJ?=
 =?utf-8?B?TVZDMUFaeWtYNVJQNDhnRzBoZVhpUW1sc2h2dTM3OTJNS2lWTzhGalhRMGd5?=
 =?utf-8?B?L1ZBSzE1aHM4WkdtVVZoY1gvMCs4Q1hqL2k4TkkzRW5aTDMzRmNUaVBkNG5o?=
 =?utf-8?B?MnRzVVUrc2xnTjM4eWNFMkNmN3pDcXJMejZENHpBMGRuYWRhckJKdndjK2VT?=
 =?utf-8?B?TEF4NTFyVU9KVEs2eEtTWFdUMUhlck4wa3FQb2JoRzYyaWtSUTdsMzRPbXNk?=
 =?utf-8?B?cGlzenhUdzdGM1AwTUhFV0RCK2sxSG8rV1FwNENPZGNBcGtLMnVsK1BUNFF4?=
 =?utf-8?B?aVdtdi8zdVZxVXRhUGJYZURTSmNrM1Z6N2l4YzFoT2RWTmljY21sSmxaaVph?=
 =?utf-8?B?VEVYUUZkeStrWlI1dXhleTFLcDlWTmRZalVjUGEyZFAxTXBvS1JnK3BMbzNY?=
 =?utf-8?B?MFZhSWlhTnlmT21oZTNjNmhGNlJrTmRuSHZWVWZYb3RyOVgyZ0ZYRG81cS9F?=
 =?utf-8?B?RE9VN1BVWVAxKzRlWDQ4cHpxVzZjQjJoUmhSdnZsV25KUTRtUHVnOXFjbndr?=
 =?utf-8?B?RmZWcWc4Rmt4ZlRZbEFIRWllRTh3YU5RZnBuMWVJNHU5bFUvV2xWRVpuK0pi?=
 =?utf-8?B?V1lVQ3g5ckNCQWxqNzZkUStCMDVteVRWTElxVXhETllESGZuQ2FYc3dQMnpq?=
 =?utf-8?B?b2Z1djN4U05Rc2VtOTBGL0tobWpVVElYV0hMZXpBRng2RTlnYUMyakJRQVJp?=
 =?utf-8?B?ckprTjQ1SjF6dnExdkY1a2hkenNMQUFWMEhoeWpvdUFYOVROb1ZMOEhFZDRL?=
 =?utf-8?B?M2hUQ3Z4WkxLdWJmTGhnc2ZOS2EwOUFyYXkzOGsycHlORHJ3bE5lMDNkUXJr?=
 =?utf-8?B?dVV4d05rTlgrdUIvNmpjK3NaRlB1WDdSUVRTbGM4ZXE3a0ZEUk9vVjRpeTdT?=
 =?utf-8?B?SW01c1Q0SHdLNVA1QWtwbWw5aXJxOWUwUnhZSk1qSjgyVTBEWGlSNm9RejEv?=
 =?utf-8?B?cUgyUy94SVpPbmhFdHRscWJDM0R6WStYWVAzM0F1N21UMVE5c3JaNTZRKzJO?=
 =?utf-8?B?Wm1YMFBHcjMxekIvQ1hkL3l6TXYyQk1QVUtTNnFJMzdzMkxZNG12YmJvTXg3?=
 =?utf-8?B?QlhvSGUrcE12cHdLNTRPYXI2NkRDQXFVU0hzMFZYeW5RK2hIVjFwQWtCVDUx?=
 =?utf-8?B?T3p0OWphOFdEa1R4cjJuM0FtWVdvd2NkcEUrVUpLTzRqdXROK3B1NW5uZFpv?=
 =?utf-8?B?cTBoTGJwRGppT3Nic1cvcXE1WVhaNVBWaEcxZjM4U0JuQnhoSnliY2QyWjgx?=
 =?utf-8?B?b3JhT1BweE1Mb0tqbkpvd0M5dlUzSDB3UXdmL3ZvOXJCbmZ4anQ4NUpZWWYy?=
 =?utf-8?B?NTZrL2JJb2taMU5UQzdmTDF2YzBlb0R6QWl2SG1VUS9CdjFia2o5RS84S3NV?=
 =?utf-8?B?Z1ZTMkYvNmp6OG1MTjN4em5HRXpXakVMaXFuWHVUbXRMZ1dUcGNtMkNGQjV0?=
 =?utf-8?B?WmpidHFrYm1BS0EwZmpHQTJYR3l3TmhhOW42SW95RnZrYXFhWGxZUlJIOHk5?=
 =?utf-8?B?Z3ZhN0NLeFdYRjdabk9XbWRlcWR4TkNQdm4xVjBzd05jZ1hLZTREMnE3aWRJ?=
 =?utf-8?B?azNjM2RyK05zNURzenNGTWlmYVRXVi9GOEp3VjI2ZkR3M0QrbGRxUzVSNEIx?=
 =?utf-8?B?eVh1Qk5oVmR6aG5YNHZFdFNWeUJWZkZQbkRCY0ZWWEVMRHZmeVB2ZzVwVy9C?=
 =?utf-8?B?clo0RXFyS0ZucTBqNmNyVWdSOXFvR1VGNk1YVVdxZkljZE5INVBLUTBJSzFN?=
 =?utf-8?B?aHJhdnpzKzZmejBJZWZxU045Y2FmMGFmRndkQ3ZmUXpXVGdtMFRySkpzbWJm?=
 =?utf-8?Q?UHnZQduokSQtzvDTA7szZcs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RkV4dUM0Y2NFaUt1UjBlSkZiVkFWNUxPb0JHdWprcVhEdlV3VG9hSkRWUGRJ?=
 =?utf-8?B?dTUxUVpnSTNBcDFFeVpsK2thSkVKaVArMnlndURZZjBwN0lXeHI4ajRnRG1v?=
 =?utf-8?B?OExWVVZPcmZGOGFGQjJ1cUd3QWlPN252M1NOSWdPdGhSSjBVTFEyc1doYnZC?=
 =?utf-8?B?TDVURWd1SWNScDBSdmtmWms2QlVrTEt5T1BKMmtPL3E4blBuVHR2WTdibGRM?=
 =?utf-8?B?U2o5cWlyTE9QQ1MvcTZwV044UGhBVVVZbU9jZ2E2NCtYNlVzNm4xUW1IYnVZ?=
 =?utf-8?B?R21zbFlpUmQvVE05WlVxN3pyTzNIaDVmTmJZNEhMUUlWTzJvYzNjMERHMDdO?=
 =?utf-8?B?RHNKWXd6S0dScEtGalVsUXIxdmE0dzJRQytsdjJZM0ZhYkNRY3JVdjdrdmV3?=
 =?utf-8?B?MEZkeXZPK2RWb1lNOC9TNEorR2lSUTRJMXBvdFozMHdLVnFRa2dCaUFIbm9W?=
 =?utf-8?B?U2VlVmN3dnN3V01BejkwU0hnQWNOL0pZQU4xTXpkU1gyKzBZMUpNVmhxV2ky?=
 =?utf-8?B?ZEdGSlRGVFZUeUNUdVpjbUhPSDZWREQ2M3dicU9HU1NkQTQ2UTV0MG55Z2FR?=
 =?utf-8?B?SXZYUU8zS0JjWUhCalpERFZLdWpjQkwvOXUydFluWGVmNkZJelQ1UVB4Tmg3?=
 =?utf-8?B?MlNVV3N0TysyL3ZKNFdSd3Jqd2k3VVc2d3o5WUs4VzQrc1MvYWlEV0tXTFRw?=
 =?utf-8?B?WWo2eDE4MmVWMFNrZVJRT3VoeTg1blBpVFp5L3RuK204TmIxcFppbEM3RzY3?=
 =?utf-8?B?NklRVi93V083bmp4NytYeDc4SmR2SU5iUmFIazJwSHBUZGllMm12aC9uSHpt?=
 =?utf-8?B?eUNOQzhsSmVXbWx3cHVyOHRUM1U2OS9BQ2FWanlnMXF0UmphVEszZjBDb1J6?=
 =?utf-8?B?UFVUZDdGVXhGNnBCY3hSZGRVbW15cVBrZWNNcFVjWTZmSnNReFlKeUZrZHJO?=
 =?utf-8?B?cjZ4d21BQjM3NGVOQzRGUUpHeHVEMjQ1QVFUeC82ZWxIaUErK0lkZVhPSWl3?=
 =?utf-8?B?V0ExL05DeWJMQTZha2xLcjJ6YzBHQ0RnRGR4YkJvOHJrdWJveDBUbmxiSEdE?=
 =?utf-8?B?TkdhNTVYMmcxYzhvdjFwb216YTNzRUJ6M20rZ2QvVmpFSEowcXF3Z3ExL0tq?=
 =?utf-8?B?V21Vdk5ZL21xUVBzOFlsYkkyaUNJbko2T0dyajkzTmZyenVtRHJjdm9XbXNF?=
 =?utf-8?B?ZUxqYUZWNXFId1BvbW91L1EyR0lvQk05YjBjcHJVd3dxZlhGUHB4ekJ4UFNK?=
 =?utf-8?B?ekl3UENMVUV6bTZqWDdFSFN6SnZ3Zm1lWGZLNU9TTXd2S2g1Wk11dnNtUnJN?=
 =?utf-8?B?ZzJEZGRBUDZkRk9sUENvWXU1SndRd1NQK3pTNXdOSHR2NS9oSDhoREVIeGNq?=
 =?utf-8?B?a3RRNzJEckZxbytZTnZ2RktJZmtSRElRVWlrT3VWQks1RS9TMmsrRGdHaXFJ?=
 =?utf-8?B?elhRaDBONGxUTEtiNlVmRFZXTUNlTU1PTDdsS1JQMFpzUTZhZ2FqZGh5Z0U4?=
 =?utf-8?B?MVRHcmV2dXBNMUEvVE02VFgwMWVNYU9mRzVQT3BrMEZFTjU5S0NCbU0zb0Ro?=
 =?utf-8?Q?oGVzCMZ3BNtFDS4SrQtORb3DsucRoCpBqz2Ba5NOo3TsIm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd681a4c-2710-4166-cec6-08dbf5622976
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 07:16:55.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYgem1VxQoCwSZEIg2wYptosDjiZfstqF4h0Hfn4Xa5us/sbYfI6CqD+np/mbgHIKlyBJIVQJwqJyfLoTkg1fwmVFwscGSv1XtnJkHVxkMk+MNrH6LK6s67FvAK2Mw8A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_03,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050057
X-Proofpoint-ORIG-GUID: rpJu9vDemjlEbA1Bkctm7AOCfv6iIMTn
X-Proofpoint-GUID: rpJu9vDemjlEbA1Bkctm7AOCfv6iIMTn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 05/12/23 8:46 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> Adrian Hunter <adrian.hunter@intel.com>
>      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> 
> 

^^ This commit is causing the perf/ build failure:

In file included from util/jitdump.c:29:
util/genelf.h:5:10: fatal error: linux/math.h: No such file or directory
     5 | #include <linux/math.h>
       |          ^~~~~~~~~~~~~~
compilation terminated.

This was previously reported on 5.15.136-rc:

Vegard shared his analysis on ways to fix here:

https://lore.kernel.org/stable/fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com/

Thanks,
Harshit

