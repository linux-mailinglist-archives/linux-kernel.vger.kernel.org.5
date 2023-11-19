Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821CD7F085F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 19:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKSSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 13:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjKSSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 13:53:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640489F;
        Sun, 19 Nov 2023 10:53:19 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGPmVZ012054;
        Sun, 19 Nov 2023 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=csQ1reiA9k0Xnmxw6GHD+pfqJ8gPwGtkmyQsr85aRe8=;
 b=JdpPB75JKMglrm8hKSwmaLiqQ47bjUG1kFqrFPpGDH2xBUHQ8lOuSmfLPXl9eZLiTOM3
 uaux2dDKKID4wS/lcucTf/CaRAKAMAhVR0m+k9WsBlECmMwBUePghfL21lbPCJklHgte
 UjWWkXUIvq273KMMfjO9Ibqdt35Uq/IYv+kSskOL3JmOCx/NpVULNUruWKBzsbkkPGLH
 uy60/UXR5CFpE62SJ8Oe2eqBFnJjpXZcVxJs0HlmAaidJln9AGsPetKKfUUX8UZCRA+A
 X3vFctwAiZoO4KoO9U3BVSetWnl4uabOiT45vGxX2NSfC1EeLPUjjxoHPhUcfqTpKtcF yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6c9fep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 18:52:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJIZjNt022544;
        Sun, 19 Nov 2023 18:52:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq48gv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 18:52:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8d8hTzuVsDr9KzIjU3Ay14uob5PLh+aBjBY7NCt+T2JTAjMkKW2NCSx6fs5eJuu6AdHo3qlBMo0nbLgwejdiZhGn+Y0xmFH2gIySQY9NitQzyvuzefUap5WIS3GaD813275+jr6rLMnvnggo8grgOdYbpTpTBycd47tFu73HiGDEFcEXJdCiUryDgkMXCTPlAVoZhwNxqPbmNO4n2DrOGrcM/+mSq0gdYukUmiJnHZbhbxjxD+dOLjAi9xaDgTAmA9TLgOhtpUbt+bp0mqbOcV8/Z1jeQ4kxYmEFjUqpZyAzdS5lyTICFunN8lYUG+4IifPXKAwafndLuykuCFppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csQ1reiA9k0Xnmxw6GHD+pfqJ8gPwGtkmyQsr85aRe8=;
 b=hVs0QpBULGTb6NZa4xQFOoQgCQU5TxRb++2V7lE4i1O8gkLsUBxXnX/trU58wWAHQSkNr7nzca5ATPVewVkMmCgpbj0RDwMk8NSYDaTpPc/DufjvMilO0FZLiQHGHENGJ9MMr+ApK6urmfcyb8efmGwTfXhRaVaQLhREIgwoeYUioObyhvbxKZlupKQo4ytRap4cgK8RhQCIbFp1I4Bc9Y0Cq0gD02iOD0CXqYO2b33nEXyTe24PR3W01E2aVMGWw6Egdq+oOLrxVguMDTrqylaN8tl/RlDfAXtSRS6NcE+/nxq7l4Rth10tH9B66LRwXmQAfFPNcolkY4s6FC1jdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csQ1reiA9k0Xnmxw6GHD+pfqJ8gPwGtkmyQsr85aRe8=;
 b=VE0ABNad7YTA34l70NV1eHxM217iOYQXmFSdBdJ3aS+CMjel73d9v4CcQI1vWT3sIBowg+k0n39hPe05QAL4wJkaOsYONsD8DUANxMkZEfLb3PxSRQoaFS9f817V9BUzqiBJ6rP5SAKZnVyC8hYP2DLItSmOrWxhwvqFqVM8I1E=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB6491.namprd10.prod.outlook.com (2603:10b6:930:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Sun, 19 Nov
 2023 18:52:37 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 18:52:36 +0000
Message-ID: <62e2cf6e-57c6-479c-b2ce-16851968f4ac@oracle.com>
Date:   Mon, 20 Nov 2023 00:22:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231115203548.387164783@linuxfoundation.org>
 <77fb5f38-d4d4-4334-aee9-e5af585728f0@oracle.com> <ZVYf1VZ1xKQF23Qr@sashalap>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <ZVYf1VZ1xKQF23Qr@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd16fed-2a59-47ed-9330-08dbe930b276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTD7SgiUs9jlwK7wTCyecRuZtvh8lfFqwVp7U/pZ0eLKXLJTmskeK33Zn4GJ9m9LpYUe+SJMkgRkYm6aIg8KokiwR8ip9D3rwWJtycYejwf1qg111yfV+i7aDp4r9WpkSCtn5Llta2fw7Ec7v3eNUWElrg9ByyGkaUGQbgPUxEZx2ttWYYQTNeq1dmKOovxUz8giMsiNKuh2FKahywAMufBGMQGNFt8pQ8INOeLbmKl7B9WTnITk1et5hqrEQVCh6Plg0F4FnemUSiqV27sXhLa8/2BfiiUugzaSJHZ94QVH+LvsROF7MUKGwQoNb6vAgsQTcrEP6E4y9DpXM3Hmyy1fg1+2+PT/zCMxjBgBrcPup8DCTIY3u3WCUlKcLfglYOpWQyvSIkltSjJng49Nqa/003K/rR1yeMRpgzG6QMXvrhD21x56B7pwNEQC4aLVSJpmxyKmK/ET7p513SFzEX77jtbiNL5z5vnso8zL8+4UHjQGLydi+heImvsnMWluqYNO88twhCCMnslsr9FLcccoY7OFz9stOIKIquhazi8y88cj8Ehf/IGHdcdbNwAvd/kXasHNHdTL3BgkzeAw+QHmoSDTgCgdRzPYnw8Ej+aDsLPyWd6SxBxNpsvlSKfqVcZ6isbmQCTpQk5mVYIgWEDQkB8ObrZTw0o3fGMaH4+KfaHssph83jMoy+aA6uqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(7416002)(5660300002)(2906002)(4326008)(8936002)(8676002)(41300700001)(316002)(66476007)(66556008)(6916009)(54906003)(66946007)(26005)(6666004)(6486002)(478600001)(966005)(107886003)(6506007)(31686004)(6512007)(2616005)(53546011)(36756003)(31696002)(86362001)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emZwZlVhNE9qVnlFakJ0NnB3bUZFdHBGSnNwT3BJQnI1eDk5NE5sKzJZVjJK?=
 =?utf-8?B?SW1MZHZnTy8ydy94SUowSG9SUm1HeE5tSXFSS2h3UFZIcHArYWVvVnQ0c0xD?=
 =?utf-8?B?QnUwMmszcm1sTHpZVXNKa2FTTS9iUzgxTWxpV1pWaC9TclBGZTFFR0thWWJN?=
 =?utf-8?B?WkVxZmxPR3dmQStQUlVNYkl5VHpqTkR6amVxKzNLQ0s3SDF0T1UxUk1tWk1M?=
 =?utf-8?B?cXk0eXMzVVZMd0JHaFI5bXB6MlM5anNiTk9KckhXVmRwd1NwZTM2Z0l0ajRS?=
 =?utf-8?B?QXhUQ3dEc01GV2EydE5jejFWZlNVcHRxR0c1cUlCUUxiNEw3cTdjZ1loZEdI?=
 =?utf-8?B?T1RWY2FjVGt4bVY4U2FZRFVlQnl0ZFJ6R1NLRnhBNHlvM1AyQXhBK2NWS21h?=
 =?utf-8?B?ZGNuL0h3SDNEMTRLWTJwUiszcHZtdnZvRnY3bEVFRVNsS3RIS3RoalQzRVJJ?=
 =?utf-8?B?K0ZYc0ZKYUZPcm9sWkh3cmlBZUNBU1JTOWIxeEE5YjdFbE5yMVZ5M1VRYmZ4?=
 =?utf-8?B?SlE4Ky9yK0gzSlBKUGNTMi9xR3U5NTZ5RVpHZ3lQWjdJM2ZmVk1wUS9OaU5F?=
 =?utf-8?B?WlYwVFFGYWRxVUp4ZmFtTExNanZOamVKdWJsN3gvSE91ZG5zWkVMSS9PT0d5?=
 =?utf-8?B?enBydE1kdzE5R2tUcDY4cjh0UXpvaE9ZUzVnT2w4b3NMZ0I1ZmkzcHBzRG12?=
 =?utf-8?B?M1E2NGdMUDAwcFZwMFRhWWxmNHV6d0x1TE84RGRjbitPTEEwdlgyYUNJVCsw?=
 =?utf-8?B?bWpmeUEvclhPRE9kMlFRMDl3NDBCSngwYnNxUFJ3bTZ6TE1Oc3NlbWZEYTZa?=
 =?utf-8?B?VFpwaFFLc3dvbHVESGNLaytTcVJHak5iQTgzNkRWTkR0elZudGoxQlpBUnpR?=
 =?utf-8?B?cDFRQmJFYnVaZS8rZ0RYUHNIR2lFTTR0MUU5aVJXYk03N0JDYXpXZGhaMnB5?=
 =?utf-8?B?VEwzTlVHTzZJR3NFc0QvSnhhM3dqVEhUZlVWWk54dFQzVThqMk42Y1V0SUtw?=
 =?utf-8?B?NVRXTjlZLzlhQU1xbWp1aktwT3djNEt6VFFMTmRYdk9BV0dlaDAvdUF5NklJ?=
 =?utf-8?B?YyttVDhiTTlsQUM1QityUGdPemxGeExFWXNlV1hIaktJdWxjczR4aGxBRkZ4?=
 =?utf-8?B?Rmt5OEVUb3c3ejNuQXFqaFBCL0dFa1o4U0IxVHVWdU55Tkg2bURBeXR5d0Za?=
 =?utf-8?B?bE56SEZSWlJKZldHTElUeUN5TGw0TU8xaEpYcmZaZjZkL3YwTXFybitmc2NX?=
 =?utf-8?B?QWU1ZkRPU2g4ZmU4dVJRdFJaSVZhMlZyaXdZNCtZQ09lWmIrU3RsUG4wS1hJ?=
 =?utf-8?B?bGEyam9QV1FvQWh3L0lSTkl0NkpCaVFsbXdUUE90QWI4M2VlRzIxN1I3bVpH?=
 =?utf-8?B?SzlUeHZiNk53SStIazFoaG5LYmFoUDBRNTV3aGpHeFFRd3owclF3a2NUeDQ3?=
 =?utf-8?B?YjZ5M3pna1VobjZwbzJ3ZndlQk1oalZHMUU1VE1ic2grSWFnVUs3angvU0t2?=
 =?utf-8?B?K3drVUZoUEh3c2k3WngwelhRVGpnMmFLMVFTQ3Y1VjdRbS9adVM1Ym9GeFdJ?=
 =?utf-8?B?cDNDVXdSb1d6aG9GM1dRVlZ2SnRxN2FOa3lCK3JtZ2dQYjBSa2NVOHh5ZVlt?=
 =?utf-8?B?YVdSWXZhMXpoc21VaFArUXpDVnlBclFWK3FEMU1wdy9FSlBveGpnVlFYNTFE?=
 =?utf-8?B?ZXpmSWtENTFHSzBaT0NyQ2N5TFhFOENLSDZXNXlpYU10bUhQTFBvZTcra2hS?=
 =?utf-8?B?SWNZT2pJZjhOcDlYckJjNkJUSWc5ZWFPak5CNVgrSnRZSlJSNkQ0MFlqek5U?=
 =?utf-8?B?MGR1YndaSEhaUkxEV0lYT0xIVVpzNUN0WWM2SUJrWHVrb0JERy9YaDltZEdW?=
 =?utf-8?B?WldaTHJicWNpdnZJZUdFNDFIcWN3b0gxSml5T2tsQ09MR2dtMmFJY2JpaWpY?=
 =?utf-8?B?SW5ZQm5jSWxXOUVmbndwQ0RvcVB0ZmlqSXI4cytmSmN5aWhqVGNLVC9QOFdQ?=
 =?utf-8?B?dWNkOEhIelZFd0MzQU9GcEdzRkxSSmF3NmNoRG9vT3p5ZFMwa3V2NWVqS0o3?=
 =?utf-8?B?U3NtYmVGQlhPTHNuLzcwUVBLNHRvTE1yMnBWZUxBSzQraEJENHJDbVlhTDYv?=
 =?utf-8?B?K2hXM3pBQlZMUWQvc3dNVXgxOFJnbGtvU0RCTXlCS0Y0UlRmWXFUbHBzMXg3?=
 =?utf-8?Q?gJ/xgrp1o9Ja3TZfysAwl94=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eVZsRFlBTllZSzBPRjlJU3FvM1FIdkdINDlveHZ3eERKSWhHME9oelJPUTZQ?=
 =?utf-8?B?ayt4ank5SC92WjdRRnc0K1dOejJxV0JJdGRRRSt1UWd5OE01c1puZUdUWXpI?=
 =?utf-8?B?eGdiWkFSWWRrVEt5Skxlanp0RC9EcWE0RVJ4ZG9JWE94Z1EyWklxd2RJcUhW?=
 =?utf-8?B?cThSQnhLR2VTTEpaUEJpMW1ZcTc1N1d3R21VTzhBT244a2FCb3BjMCtpTldh?=
 =?utf-8?B?TU9QWDg1TzBUQWJBNHVEU2UraTFPR0RVN2NLMmQ1eXoyN3lzT21iVldVaHhI?=
 =?utf-8?B?VVZUZ3FnS1hXdERDbkhLNmtBRnh6Zk5sNHVqV0U0OUo1SDg3eDhyUEtpOXFz?=
 =?utf-8?B?QVN6clpLYzRQSno4VVpLWEpVeUFoa3Bvek5OZXllcllKc28rYk1uK2VHL1Ri?=
 =?utf-8?B?eGxYOUFsblRLTkJ0S3lUcnJKcXAzSDRSYm1RUFdjdXdNNmg2cjJpZitrMUFN?=
 =?utf-8?B?NFJVNVVKcndBOXZoL3g4VFIrUVo5WTMwQTJSeU9rbW0yVmZFVTNZVEw5S2xt?=
 =?utf-8?B?Q3llUlA5V1M4bDBqL0JtOVRZOUZqSVBERW1LRUVHS1BSUS9VeFpLSElxOElY?=
 =?utf-8?B?THpkZEdvWWxLQ29waUV1ZEVLd3FMWkRzRHZvMjV3L3RhbWU4bmhJdE5Wd1NV?=
 =?utf-8?B?L01pR1RhcDNQZC9jczVTb25MMjNrSTZFTVVMOFdPdm5PSVpTS0NiRThOQi8r?=
 =?utf-8?B?TTNHV3FSaE00QU00WXE3UVRsOHdkay9vNDk1Vk96Z0YrOUs4L05qM0RyN0tK?=
 =?utf-8?B?YXdrNldMY2hOV043WGdlQWtsN3B0dEJzSCs3RHdORVlOUFpITVBGRWdDbmV5?=
 =?utf-8?B?VWxSblVScHdPNkdaVkdvODNrTzNxQUt0eTBTZ3ROZHJ3UGdQM2F0V3dxTjc1?=
 =?utf-8?B?dC9KcDU2VUVqSEt6REZiQ3JOR1QzY3IrR3c4VHVqZ1ZUN1cyZC9uMlhOV0Zv?=
 =?utf-8?B?VlVDbnFIMWN0UVpjVDZQZFo2cGJmOVg3d3EyYkJNTjBFUklsdkhMNGgwNlls?=
 =?utf-8?B?R0hDS2NyWk1WYWVITEJ6QjNXSEdYaFZLWGFrZnNFYjRnSC9Wb01lUGMzUFBx?=
 =?utf-8?B?ZjVmc1pwRHlKclVaNmQ3YkdONXliSDRWQWxiVjBVdVFtcGtDRnVKSkU0eFdW?=
 =?utf-8?B?L3ZmNTlVelhIcmh0T0kxM1BpOXFXVU85dS9MaHVUcnd2VGF2UC9BRHpHa2Fj?=
 =?utf-8?B?VGRPSm9xdk0yb0ZrZnFOVktHNjNteG1NZGFSK0tpNVlXYTVKU2tpMStHN0dv?=
 =?utf-8?B?KzJoSFU5WUpzSXpXVzJoZDB2Q0V0Mk96RmhqQmorVWFFK21zRkxwV1dSRjZh?=
 =?utf-8?B?aWdLOVJoVlJvcnhmcW5LRldzMFpSMTZEcXhrbnVrRmJvajRROTAyQUJFbHBN?=
 =?utf-8?B?eHNobnpVc3ZVUCs2NFQxYmMvWE1CcjZtQUg4NHpBb1Urb3o3TTBtMVpLRkhv?=
 =?utf-8?B?eUV1Uk5Ga3ZWaTQxZlplS0xpTEtWZGtwb2RBUTZDdm5hQTZGVUY5WUJySVhT?=
 =?utf-8?B?ZHF2eHF1MjFHcUV5RXhGYTRCZlEyaVBHLzFyUXZ6UVZTa1NyWlVVbDY0ZDBF?=
 =?utf-8?Q?LGpOBpAX/s47/LCTJY03g7li89y0FU9g+EMN8ktEIAog74?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd16fed-2a59-47ed-9330-08dbe930b276
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 18:52:36.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8eaQ6HqsIU9xopz3xZLzwQCOTN68TIsXA/dmfvEvrVikoqQWslGEVrvqsg6keltKXph8KoTmpMNqx3uKoTyTKUIhHepXMNRYttB62K0QpJ7FW8dg0KyUYkICGMceF64k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_18,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190144
X-Proofpoint-ORIG-GUID: hdyMNyq_EFckxvxeC_StlRtSMTys101H
X-Proofpoint-GUID: hdyMNyq_EFckxvxeC_StlRtSMTys101H
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sasha and Greg,

On 16/11/23 7:27 pm, Sasha Levin wrote:
> On Thu, Nov 16, 2023 at 04:04:10PM +0530, Harshit Mogalapalli wrote:
>> Hi Greg,
>>
>> On 16/11/23 2:03 am, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.139 release.
>>> There are 244 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.139-rc1.gz
>>> or in the git tree and branch at:
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>> and the diffstat can be found below.
>>>
>>
>> As Florian pointed:
>>
>> I am also seeing build failure with perf, which is same as the 
>> previous cycle.
>>
>> BUILDSTDERR: util/evlist.c: In function 'evlist__add_aux_dummy':
>> BUILDSTDERR: util/evlist.c:266:31: error: implicit declaration of 
>> function 'evlist__dummy_event'; did you mean 'evlist__add_sb_event'? 
>> [-Werror=implicit-function-declaration]
>> BUILDSTDERR:   266 |         struct evsel *evsel = 
>> evlist__dummy_event(evlist);
>> BUILDSTDERR:       |                               ^~~~~~~~~~~~~~~~~~~
>> BUILDSTDERR:       |                               evlist__add_sb_event
>> BUILDSTDERR: util/evlist.c:266:31: error: initialization of 'struct 
>> evsel *' from 'int' makes pointer from integer without a cast 
>> [-Werror=int-conversion]
>>
>> I think we should drop:
>> 3dcc2e4843277 perf evlist: Avoid frequency mode for the dummy event
>> 4898cce349953 perf tools: Get rid of evlist__add_on_all_cpus()
>> a6157c9aa899a perf evlist: Add evlist__add_dummy_on_all_cpus()
> 
> Dropped, thanks!

I have reverted these locally and triggered tests on 5.15.139-rc1.

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> 

