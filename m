Return-Path: <linux-kernel+bounces-21650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8437D82925F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F2FB23442
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59F1870;
	Wed, 10 Jan 2024 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCV5SaO2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="K9YCORHo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E321FA6;
	Wed, 10 Jan 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40A1mcOJ029427;
	Wed, 10 Jan 2024 02:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=rgMcC7AfzFLFrwHKgXp56OyoqoxVcIpfRQniU3mpMQs=;
 b=HCV5SaO2ZLoAmJleiedfuP2XJUKz58BskSV/02WtmJyPkbUiLwwrfoDDsBvGgf70UbUn
 iumJAsZDCQIkinCtqHTmOneskmszUMIS1RHQ6EmzwfFCl1I2nOhx09PRzXTCftym88bl
 qijJQtrdbs+Vjcf4m7PAxHoZw35aK7HipoE7jIf4TGzNe4XjpKJm3Yst7ZCNGY+4qPXz
 fsk7Na1Dj3BYQrbOGCevwfGoOCI7KESbIPOmrnG8uXfXTuxmdON2NladLruwO7DgNXFf
 hHPfqbXz1ykoSBITmPaXdPb+mTBRi5U7xe94yqwcAsWaWCmJx5xvfQ7Lz6YJNdVfQiMS oQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh9r990tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 02:17:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40A2B7n3030110;
	Wed, 10 Jan 2024 02:17:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutmx324-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 02:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoOs7XwcfKBUsygE8F9PEN+BqFwnT5LPE6uDpW4gSNXyEexXdVg0cuzBcK21/c38hflzaoYhH5JPSecle1fpZx5A7Dj2johMRk4gD2YO8y9Pw+VeQBa0BSaYm3JMw8U2L1Mo70o06N1QcWwbHTNru+Arc50JNsbEjrGG5tyZ0XgXboKENuo5BJDLnIjIC0AZR3FahiHAK7iX8xLNEMwLQtsBMQC53wyDl6APqiaS0Zq4BKkCxTKlQ9R+MAyqI5TFHEH477nA6oM7pT5NErH8D7ka37HQhNwizMqn45k8iscPZMHs+c4yT5HY9DqqrVWL3aVwZs4grbNOSpDC2ZmCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgMcC7AfzFLFrwHKgXp56OyoqoxVcIpfRQniU3mpMQs=;
 b=g0mccNZ+CdMHPk1ACEDaWuZhGhVjvPVGUrso3VqnNYyekJSMBj0wHh/9QADMXL2KgY6nJ3UotClIk0kApTgDvAJSrwrmQcdzvpptT58WMxIoMc0/SLsHkKBp8Yef909Xue/EhNbJY1HAAxatGeFgAlD4MR/7h7O9yERLI/BCDrf9+RB4zbFC3iucZ/KJXyCi7LC2JGcszsEt2JYSek2aQrogsANvoxSqWrGtUUh0zWXWYsiX7SmbvZAY8XB9aVaZnYOV8cz//n1MBzFeNaRF0uW8Bb5DX2+IjNxbO0rYWOxL3WhSg+uGRjKIA8DEYElTTll13okVbUAI3bx/P4RQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgMcC7AfzFLFrwHKgXp56OyoqoxVcIpfRQniU3mpMQs=;
 b=K9YCORHoZ8A6B88oMb5uchWpWcYYa0UIEZ+VKFjP5U4lB8AYhwd2vjgm+6saRAKwr16J8fIrduUDRKn/uUqrhDsSylHnbCNTKANl8IU4GaMYvST7Pvr9L7iyILa7c84pIAtsiuZjDUc2+TDijUQkIiOOTvfpMbDleu+8pWaZbNY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CYYPR10MB7570.namprd10.prod.outlook.com (2603:10b6:930:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 02:17:00 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:16:59 +0000
Message-ID: <6945da59-f341-46a5-a6bd-819d488430dd@oracle.com>
Date: Wed, 10 Jan 2024 07:46:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240108150602.976232871@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CYYPR10MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 028d9c8e-fbcf-4fbb-027c-08dc11823975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TrIwv3/4/lFAn8po96yw4EA/YB5ZW113j6VHPqwzzY+I0YD6eVCDiJfMfo9kk+8r+a/RPx2QOsv4hIuFoyqXihhmJlKu6Qo8UPxtMcLZtEZ1yaIhNoi3NudFD6zlNNBcrISzRuZEa6erVKjdx+LzhRt4Em98g6KO/Sstbsbm8noWFPvPzKRoVdEXGECtjkNgSkrbC1d5ds+8U5mJnP1VSdJc/ciIVTCYxaBTCpLalUqh4BaXqTlMaSZrua72pP4lXID2uEfPD/lfcH8M+UWxF4lViqrBLMavWDBPG7URcYvdiv49gnrZfrU/NBwqxYzI6pu66zD+E+iHUVXG/nCoaBwOyHC1+wprVAv6fZziF9PcGsjkPdUQBaapnVuOIOMx6QGXXifnUF7HCvL45lfRUeHv2D5fbO4GhEL9E22TypUBpJv0NvuHWWQMsDxdI3fIifem06BVR+VMbuIEdGBqYPLDfDPKPrWt+7R7POTwbuNbeWq4MFsFGPVFWhbR5uIlP9XObNNzlQb2MKLuYkYEgb0WNCfaRg6U2BZsIbjyVGlG2rV8i7OFIenZhhgh/qfQkSNKh0q4VpRqpDgKi7Lk54kQIBZpCEToh5k+kCIb3sO2XHWg0FTifOpeMPxlewxs5zi2Z+v8sGZLdCDsyepv2Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(7416002)(2906002)(4744005)(5660300002)(8936002)(36756003)(4326008)(66946007)(316002)(54906003)(66476007)(41300700001)(66556008)(6506007)(966005)(31696002)(86362001)(6486002)(107886003)(8676002)(478600001)(6512007)(6666004)(53546011)(26005)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGwwc2gvb09PZis3dUpLZTIrSGUxWkRWM1E4b1V4VEEyWHJQZ1BxRDZTUkJ2?=
 =?utf-8?B?aUxVZVU4U1ZyWWt0VWtSb2xEQUFXVDZDeGZpNDJRR20xZ2NLSEMvL2pKdlAy?=
 =?utf-8?B?dGhvbk5jVk52WnBSeG9ZRVM3NWtFMUtRL0V2Z2lxb0E4RS9sYUdXNzgwQnRT?=
 =?utf-8?B?NUVibzJRV21IYkFTOVlDVU0vdGhYdEdqVnJES0pxNWo1Nld2OHhCSXM3Z29n?=
 =?utf-8?B?LzV6cGtLcGdXYUFET093bmFVZzlwT2VSTngwaXUwYzFIUnd2S2MxTDNYR0FT?=
 =?utf-8?B?K3NkeEg4RTJwMlowOW5HL1VnVGEwTHordnBIYjE5RmRLSTBaSVJ2c3BqVHBj?=
 =?utf-8?B?ZnBmTnBBMTBKclcvTG96RU0xSEhzelFaYWZUa2piS3V6QlN3MXFpVENyWTBD?=
 =?utf-8?B?SU9SR1lHZzVpSU1Rd1JPQXlESGpPZjJxclpVSHpLRGR2a3l0djB0M3NlSVlC?=
 =?utf-8?B?ZlpvbGZKQWplaG8rQ09ESzIrTEtRQUxKTjh2eWtJNlBBM285SUo1dURpQWMr?=
 =?utf-8?B?OW8rYTMzcFhqdE9rUUtTT0EvS0tLSzVVMENzb0IyUUMyZTk1d0tQaWtKR25E?=
 =?utf-8?B?eE9WK0Y5UndvVkJGNXdhTER1WVZ3bURlY3lFaVpNOVgzNUF6ajZiUXV2U2JL?=
 =?utf-8?B?dWd1TXBjdmxHd0IwbFNXRy9XdHZjZEorUGhPYml2L2NPUlBab0dsUWtzcUUr?=
 =?utf-8?B?QTY5OTlVbGc1aFdzL0JFVllFNjNBTWFxSnlFbHhxSFVVQlFUaWtuelNoaGFY?=
 =?utf-8?B?Vmd1Q1ArTHBmVHkvR01XK09yeXZUbHZISTQ3RlZCOGxPaDJFbmtQWkRNT0JI?=
 =?utf-8?B?RHl1NGFWaDczeGRoV0c1cFNsRkMvV09zN1oxV25ZcElJSkVBZWkzbUhaaWRG?=
 =?utf-8?B?WXp4MkFGYk9qWG5xNGlxKzlvaTBmdzBUSDdUVEM3UU53L0hVRlYzMzR5b1p3?=
 =?utf-8?B?UXcya0JkRzkvNGlzRm5qRVpxMW5qOFZScHJzWHZPWUpyMWRmSUlvUURsSDRC?=
 =?utf-8?B?R0IxVTNPczVjbXV2S09NRFNGUHZrQ0VNeHRHc0kzRVFuYWNMekllTURXWEVv?=
 =?utf-8?B?cTZLMVZrcG5QREhTQTlDdzRHY3pBakxRV0w3VzhVTWFlL3M5ZWgxUS9DOTFk?=
 =?utf-8?B?aW9aQ095UEpCOHhLTmxIQlZFRk9IUHRubkFnL0l2Tkx3aDV6dndieXBmWHBy?=
 =?utf-8?B?eUlJcFA1Nml5d1NqeFZQVk8rM1IwUFp3c1YxcXdac3BNOTNOUU9qaGgxd3FT?=
 =?utf-8?B?eGt5NzRnaEhmb2IvczNpRlkwdzgxZUhndmRWU1JJNEptSGhvUlo2VnBRNldE?=
 =?utf-8?B?NkxWSE0xZ1RsY2M2bDFrV2JKNWIwM1piK0RuOHNrUnViUHhzVHVLdWVFa3c3?=
 =?utf-8?B?Z3pycVZOL3Ezb044Z0JiZ0hTY0VMWkcxamxVTkl6MUdDREE0MzFuNHh4Y2Ry?=
 =?utf-8?B?Z1Nzc3E5TU9oRkNUaFg3NUF6UTBXdnluWW5nSy82OWJwdE9sSFR1YzNYd01S?=
 =?utf-8?B?b1hRY2NvcmQxaFhKV2pTNmQ5OGVTaUs1ek5kandyb1VETlhGRTYxNnlQeGt3?=
 =?utf-8?B?OXA2V3psVWtlVXFsOFRFYWhMUExTY1hYZFlLdUVadTl1dEJQelVmN01xVkxZ?=
 =?utf-8?B?MnB3bHVkNElZUEZQM0FrMm9SOHdxTGNta0pkSGRRVnA5Ym1tNC84M0xaN2s0?=
 =?utf-8?B?Z21wZlVVZVp2NmJUMWp2RUdJL1pxeDI0Y2pzS2djVEVYTStCMTBYbHg5VkQ5?=
 =?utf-8?B?UjlmbGNkbUcrZFl6QW9UWFBwTGhRNURmazRlTzZlK3Zqak9NQWtQNzlnMkMy?=
 =?utf-8?B?ckc5cWdueWpKbW0rQ2JmREFHMDhJOW1hNElmeGFUNHU2eW9hRzQ0UEd1UTBh?=
 =?utf-8?B?NEZBVEo0VG5UellzTDJhZGJuSXBRNXFoSVBzdjF2NThkSk1tM0IrdHdzdUkx?=
 =?utf-8?B?dmJwd1FLMGxnRC9xTVRKRStCbk55enFIdGZtdk9zQ1RpQWVKeGlqK0IzUTZB?=
 =?utf-8?B?SmhZbFNQZEZOeTRJdUlIQlJQRThaZ09oMUJMT01jd3FlQWt4c1pNKzAzRGVt?=
 =?utf-8?B?SzA1OEpJTTVWV2lUa25ER2ZaZ2t4K1R6QWhMTWtqVFZBVzBBditQcm1ieXdt?=
 =?utf-8?B?aE85S2YvN2lFS0lSNGpXSU5iM2dFK2NEVzd5NGxWeU96dUVJSXRmNzY2Z2Ez?=
 =?utf-8?Q?fg6Z5B8AgySZkdWxmuXJaPE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Mrodq2bBlmgzs8k5meomRoc7FWMwvzSB6Na5vfYQmSqoj1rac+xRj8pZPEQKHG9UsoYFhch6iECjiIUKE5+q7MTtsIawC2xU+3LkxNRslco2BFH4vw5T6csHLqWJzskNm29N/wOi5Ztzz2cCslWDXw+eiaYdbIs9sE+0RH6QLpib98rhFz6skowyMdSEGKnypjK9q1fqEc1WrO7L8Wc0DZuWgA3kElk0Se2jhtGIyFc3z4B8mCewxOu4YCyl58bdkCoBhr2OOxCGvf7AgCvjRi/r0FamFHpL5+/H9XBOxR44GSAcFJC0Y+cYU/99yQ3w4pOHsAFyjMQk+qCD3D4b1H21XYnxt4H2sHgV2/0USEmjGaCLxKgYOHql3iI53uh4YDDza0jVFnc269nEjzB7zgZZdCD2U4yTBI/TTZXiMDVDQ99yfRbxahdtm488Ri1yOqULHSiytR9GGyw/TORz0NS+5jQVeC3diaO6ojqCuL2OhAKxAed8AVGWo34GeSP8ZEyz9InqZwwlI/W0GvgrPDJPLQq4yek1umQ+Su0Y0Cghzr4iENhaRfe01/3TdjXLtb45ppVBY0DD8bbuZFY/5CumGoTt6LMvPfk8lMbOGZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 028d9c8e-fbcf-4fbb-027c-08dc11823975
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 02:16:59.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8JU0xrRFakBjDh8a6zFak1/9xBKeJ6qD5r5aAgvDP49HG505sYt7HR/R28d/lf+PtaYHjOIOIquK96C+hue+v5F4prFPAoc6izF2BMOJer/VQb+DEfv50yPkGZ0vErf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_13,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100017
X-Proofpoint-ORIG-GUID: 19koq6eXT1DVgNnT62G4SmaJ-tO0NLx6
X-Proofpoint-GUID: 19koq6eXT1DVgNnT62G4SmaJ-tO0NLx6

Hi Greg,

On 08/01/24 8:37 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

