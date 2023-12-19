Return-Path: <linux-kernel+bounces-4741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7253818170
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9F91F23571
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184479C6;
	Tue, 19 Dec 2023 06:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ffpw1BA4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oLHdNHif"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0028475;
	Tue, 19 Dec 2023 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ0J6cT024788;
	Tue, 19 Dec 2023 06:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=B1xF77KPda3xJlU03CnxUDNoBi443L2RTX/Un/xI6UA=;
 b=Ffpw1BA44Xz+igpCT+NK1nrZm1WKYpw8ACvqSUIItjWp9lGKjhFAE/RJCvOburvWOOeo
 D67koN4/YStkSl3SjTQGYNyV2MRhphHbjR4VEwuRWISNz8VZgMQ8DpBpb9UKLNaxZJ4i
 HWJB6BwAeA8jgpeIr9rt48mWaY69LDWFEcjfNRfe3W1TiJqmXkHGQ6yvAwmRiSRZbeVD
 wrauYqnNsbU7QyItrejPJMkmWYpMEoj65YVQfhkw2wbF4/YyLzJ/DoTxgU6qUBW7Wm7f
 6w8Yr79H7kL3kwhhgO6XsZkckJoSBQfcZ4ZGKXaET2VxdsiNoazsnuagPYJmIbfqlvj5 sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v12g2d2cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:19:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ4PbUM022281;
	Tue, 19 Dec 2023 06:19:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12b6f82n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 06:19:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj7ulTnDsgZpKxT3tAHPX1PKUjCCmgTZZbBqyWO03st/X9tSRTUbXQr+03Hv8UP5wTDP7F0cXsP0UvEllHCz+4O8u3Sfh38guRJTN9q8f7usm3KO3Kiw9lvCdQXhssGxuejhchIjU96SY+MiZfYmmLzfP/TsiH/xX4u7I3qHlzLD/Kr4t2C6C1DYA9nbt8VdXAkFx+F0dKWy9hhalsDte80qC2uyycsgV3vnjTXzt+bUqpUhlZDUC0VrANGubb5KZQQfNvW6joKb4Wo2ozxU4eSwkGZxiXB9zvAPIExrtYTY4XMmjC+iUG0i8C7O1rwc2Zlmq7dNlRpQSO4Mw/RIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1xF77KPda3xJlU03CnxUDNoBi443L2RTX/Un/xI6UA=;
 b=WEnhSAo+hLfmPMUkPWYl3++T9eL+33NvvTdBXAhipCLAE+Y/ZoQQLZl4XhgYqHqXJabTnAnkZ0bst5glBsg+T7srORC3Ypa1oJErHj5UfeZ1HwMt2hY2tJyanhAct6NZ810du4Y1SkpJ+qvF9VRJh/hFrFTttZjWsNU3yt6tr6D78wqegoTHH3KXEAZym7hFesPi2EnmV92ToV032Qt5dWMpomugp1vqVUDD3+cB01kxfb1eXezBXIYuRLfTY0yr1pa7fgXh7Xw3TLV+o5NvJRHApDrSN6eodjp8eec4zriMvH/5QO50oANqux6xWe0Bn8qD6OKoyDysOtHT9WKswA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1xF77KPda3xJlU03CnxUDNoBi443L2RTX/Un/xI6UA=;
 b=oLHdNHifbO7qg2t4Uq6BcgrwsF8+MOvvEtoYDi+3/EM1a1BBw6TeD3skQKHooj5VeFXR43vHmOtvca4j2LZPmcJ2t7WRqt1sV13CXaFGRzUfFDbrG4jVoZgJK4nhs721lwBB9N1ZZ1yaOo38a/eNaByyMKRlly9vWzco3nFHiv4=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA2PR10MB4633.namprd10.prod.outlook.com (2603:10b6:806:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 06:19:12 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::b7a9:b552:a623:84a4%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 06:19:12 +0000
Message-ID: <6c78cf4f-d225-4f93-a895-32e26d9ee562@oracle.com>
Date: Tue, 19 Dec 2023 11:49:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/83] 5.15.144-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231218135049.738602288@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0011.APCP153.PROD.OUTLOOK.COM (2603:1096::21) To
 PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA2PR10MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: fccc2296-606c-4034-8ea2-08dc005a6afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XSZ0IPo8uLYuiMAxVOoBhj8+aK++Jgfm8g1BINXo8Bo/WTVxfmXOlfQ1YasieDeBC8vljMmjyP100N8BQTE3B6tluCZZu1jxqSZpBiXfMCEcUyy7Z36oEkqh/lx6zl6r4yFbdej2ayMNMZTyUCCwYMyTDPyju8/0sTkVCx68LP1sWsxeeOaTwH1ma7YH47EZcmxcJBbY0d07HOVSTzK6Gi2RvQUSeTmOFGNefqSFkDRXK1NeUYXjJuL8SSpDBsOnbPe2KG4P9Yw7k4y1eaTV1u6azj9y+nkMimQn4djoQPGJ9ueXq2/FKWa3fthnsnyJrrJTQ4QuL0inOLDTZwdxH9keK4uDT3ke0FwpioGVmqNpsM6F7pzls1rrURvG5ONrv4tIR9O+p8UdtEyZ5TCyDDavYtbeSPHQzBDu2wVbYr+97jAFgUHCr9PUfKcicu2fMH9ZpeptTi4aHDwJf9cwG8edUcuwVfZeEbIDQlRaJatsnO/9Ix2cUJ7Spcgx1xMRKs0cCnjk6qQ2rxnzm193XFuiogFIaMkKBG4CPXmmdUb/RyPwfSMpVJ+MHhXv/dmVC20A9JBto1FzqO/4SH+lVTdZZ/EZgNJu3em8mRelJesSp/Ty8lWg0hyjK4bpSdVVw/Tw+OhBzpuE99982zUeug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(107886003)(53546011)(478600001)(26005)(38100700002)(8676002)(8936002)(4326008)(7416002)(41300700001)(4744005)(316002)(66946007)(966005)(6486002)(66556008)(6512007)(5660300002)(54906003)(66476007)(6506007)(6666004)(2906002)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnJkaWlvZDl3QjViNXY4MzFMMm5EM1JkKzFHL3hjQnZVVEcreXBvRlhrR2lv?=
 =?utf-8?B?Y1BDN3lVTnc5MytoeHAyWTVvYWhuczBPbU5mdklieEoxVlFGUVpxMmtpb1ow?=
 =?utf-8?B?UlRTbWdsem5nU0JBbFJjZ1l4Ylh2SWxmUkV2L2FoODc4VHE2bEd1NUNaWjkz?=
 =?utf-8?B?cEFkdHYybWZ4c0JpZHF4cWlTY3c0SFJQK0F2L3gvUy9aVWtwL3lmOTc1T3ZD?=
 =?utf-8?B?ZVkyaTVVWHRlQ05iaG1UN3d2YjRZcFZmS1ZtaWhHdCtqNHo2WnowNElNSjJW?=
 =?utf-8?B?U09Ud0FuNlRPQTQ4SnQ2OGcvN2dJdWprVXV2Tit4Yk8wbC9GMGczUk9EVDQy?=
 =?utf-8?B?UE5aN0hGZEQrTEtjQWdhbHIrbXBxTlN4SGpsdWZ2QWY1cDlCbFNRRVUwNHdC?=
 =?utf-8?B?NlhEVmFieHRJcTdXNk41MzUycENYRnF1c2JLb0I1Q1poM1Rna1RacG5UYmhP?=
 =?utf-8?B?UUQzZE1DbjQyeHFtMHRHakZ3WVdCRWNCYTMwbzVhMEFPU2V3MjQ1V1JPTHpn?=
 =?utf-8?B?NGk1VFF4d0k3V1Z4NDlxMUgwWXljM2FGeUFBSURQTVVtQVAvbGNiNDhsVzZ3?=
 =?utf-8?B?cXViVWthR1NFNEx0SWg4VmQ0R0hiWW1DTEtRd2QrRGpaa0J2c2hjN2JNaXlP?=
 =?utf-8?B?V0FuK1FablcvRXBCOU4vMGY4THpVSU5UeHFHTmZ5YUoxbDBxOUVkeE1tdW5s?=
 =?utf-8?B?WUtVUUVCN2FZY3pEUUxWakEyYllucnJMMlMzTVR5d2Y4NUd1MW00UjVmRkpr?=
 =?utf-8?B?MExwN0ZUN3orVWpyMFhTdlBWT1NnOGFUUkEwZCs3Q3NtbnFCaGI3UkpwSHlh?=
 =?utf-8?B?c2xEMVp2djd1OG9XQWZUbHNRVUJaZ2JHc2N6bzUwT3JNd1JqUjIvdHVYYi9t?=
 =?utf-8?B?d05CWWQ4cGxjeFoyL1dVdDJsdGZLNkNLNVJmdEhjaXR1Qm4zSWxrVHFPTmZJ?=
 =?utf-8?B?TDZvdGEzOUFvQWQ4b1dmM2xrd1UyS0JNdndpQm13c1BqWExJWUY1S2Jibjhq?=
 =?utf-8?B?dHZZYmlCT2kvNUo5cC9MYlZPYWJ4cUtNVE53dk5tSzJMQ2tCSlJUamE0NGUw?=
 =?utf-8?B?bjVNYjNoazBZOFR3d01MZHpzKzAvQUFtTGcwTVE2bFZPc213eHM4cjBRWi90?=
 =?utf-8?B?eEFmbWttTXNMWi9YU2R5NjRUV25YUmxiNTFCTS9wR0VvMXd5aWRNVnlZbGVT?=
 =?utf-8?B?L3BlSlZFME14SGZVeHNwT1pvQ3ZBWFBMZkZWdllHc1JydC9KUkMyZVJpVXo1?=
 =?utf-8?B?RGtXVGg2cHdvb0N3a2R5alB6SlpKb0tpTjZhUGY3WElndDg0blFLT05XSXVa?=
 =?utf-8?B?Q2U2djUxU2dQQkcwNVpxeW5YMjg0Z0ZqcEhMNUI2eGV2bHBERUs5VDd1dUQ3?=
 =?utf-8?B?YjlnVXV5TnpIa3daYkxncE0ydU1TaUt2cFM0S0djMi9wcnp4MWpneXVYWnRx?=
 =?utf-8?B?UDdPSFRFTjZoNW5uMUxRQXhPZmc4N1R1dU9TSThySmhDVnNTK0MwaEwrZCtO?=
 =?utf-8?B?ZzJGUVR2RDQ5VEJvenI2Rmx2TiszaUhndzNTcHZWV2FRVWUyajZUclpmTk02?=
 =?utf-8?B?SUkzKzVLRys5ZkIxckNSNEM4SkdTVERxblhGazhiZDljL3ZnM2g5VFc1WkZn?=
 =?utf-8?B?MlR0eXRaS2JxRFNyQjF0Z3BhZ2lvcFBJWW5wMFpEcjliTVc5ZDladlJXUjhQ?=
 =?utf-8?B?NjV3bmtvVGltWEM4RmpnOTFCeEZIS2xRcXVzWDlCWkFBZWZwTndvSVpPTU1s?=
 =?utf-8?B?UXY5aEZFak9nUEV4T215ajl1dy9VTXV5bFR2bmRwTThkaGFlQXJtUllBSWI0?=
 =?utf-8?B?UUExZjY1Wit1SlI1ZTRXUGlwZmdkV3ZqVTR5OHVHRWxJbUt4Tkw2a2JUU2Ru?=
 =?utf-8?B?WCtJRjRmemsvc2pQSXpmRG5tc3RuYlRHb3U4SDFQNkJ5UXN3MVk3U1FpSjdw?=
 =?utf-8?B?M0dIeFlSSEMzQnQrRTJJSmZrUHZEenB6Qy9sUG14R1RTeHV2NnRRNmRDZkpt?=
 =?utf-8?B?L1VjclVtd3pqSEZ1YWtoRWU0ZUlmdzlzOFZmVUFUWGZDSlQrT25rVElKdldu?=
 =?utf-8?B?bUNURkM3bUE2aGhuR3BNaTJDcW9Vb3hJeUtPeWYwYlRYSjlndVNlUnB2STRI?=
 =?utf-8?B?ampUbDQ0a3JQalVVK2daYmdlM0JIZWV5aVlJTHhNOVRKQ011Z0lEUnNqNWVt?=
 =?utf-8?Q?dq+IK/kkH7TeF17qb6hvndY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yzSZmZgJCdpRTGv7y0FEn+G4Pp2F8aSJNZl7Ko8KCiHaOH2eg4/fJkVP/u/SU7nT865lIaNWHRTjAORFgb7M69FKnzGvV+Tc7iK4OW+xR91EHwVaxEOvwcyA2LChXwsYOQXpJmy6Wddvuda/Dd7spJNTi7Ptm47HVUEBbJzU2OWZykSjRvsoXnAM87tjf9R6SGCeU4MHmKZ9mEny12r8nqs3dUa1bjh3o/Vg7282+4ZQMaEQTzZPMs/+wxEgY9CW28xmvAgVcyytrWYT7tLSM4jkbAqwlPBHz2mvLkAJ2ma5H+w7GUPbiigmTTEd8JP9ci0wErk2ikwsBqP63sqthN2Kf0pN+kdJS8I870BFAj96OYhjppYxYTDffyQQJ+7N+FBB/jBHz02+VEE+HxKpUijTGIN7dWkR88vXSR19DPLypWKyhW3ueO3dkPjpP0IdiySqZ8flYxnS/8sdi1xA4AVd0KR4MqIvwn+Hn1mIFb89saxyreEQ+3UxMjRtUhNzfkUOCNXC0RBWt/kllKIrU+zfG7lyn8JRlOs0r94WkHA4OFPn5psvw9/vzlQJvfk1eUEylT87y8JKufXmwiHiSDqS53HfO+hwNijgOllx2jM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccc2296-606c-4034-8ea2-08dc005a6afc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 06:19:12.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0eSvbJjSKNyZJp1lluugpCUAiyKG8rlSTEfOoQyqg/1YNWk+ozN9P195oefnpfzw64yhH4FzAOV1Vc0btzjtBzB8KvomKrKWRmK1zeSiqr/BJqp8ldtI6mvaEV9lM1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_02,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312190045
X-Proofpoint-GUID: cv8fXd34OWtEXoeI-EA3HHPCLOqqlZHf
X-Proofpoint-ORIG-GUID: cv8fXd34OWtEXoeI-EA3HHPCLOqqlZHf

Hi Greg,

On 18/12/23 7:21 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.144 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 20 Dec 2023 13:50:31 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.144-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

