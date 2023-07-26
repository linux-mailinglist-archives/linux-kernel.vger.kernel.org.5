Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFED763D40
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGZRIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjGZRIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:08:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B0FE;
        Wed, 26 Jul 2023 10:08:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QGA1NR010873;
        Wed, 26 Jul 2023 17:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=O6umqqDMwvQbcG+AAMRQTwCb9C433g9LDtFHfNA8g9M=;
 b=2ih+P9IakQwlgz8wv/XgfwQ2FA47ZX/3tCiMdEvIIDzPQD2UaRfCDCcKzCkV9cCbpN2O
 E/h0ukIeT1eTkTW42XPtiCZxD1ng/XTX3hmlt5uPeHdiQgcGz8ALuUP64sNTD2FBbNse
 hp6dPbkXI/U5t+86XpCu064+4CNLDxkenzTuuJ3XHoML80KpvzUhnGscFeWu8AsaHWIU
 TbU8B8oG3BgSxsP2GKdtbU0YZpRfR1ZOd7TyWsNCTgR8Vir48ersO63FWdMTLMzArNXW
 n9VhunzuREb44OFlNBvVZn9AgUL3rGJR8NNp67F9tK4n3b/aqV7Lr7uSRAC/XjNAI0Ch HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuqxxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 17:07:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QGxWq0033463;
        Wed, 26 Jul 2023 17:07:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jcsfnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 17:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCXizDendHlGajIw+AqvkN6ophRsRsGb+jCcl6LpJ8jyCWzdFSNrdU1kj502Zw7PGA4LF2osWUtjcRqfiinLGeSrnTdjBkWJPjUAHMYKxR+phHuyOEVEXHjB82ZmS50zIQf1Po3SL4DbokX2AJSpg1pyXFP4iCZdYWSq8SbDFRgJTphK3W6RJHUnJymOjk7HkoAlM+2TirV4M0nk1wTenYkLNS/JXoKV4z5qmbXWQPEBj95OlK+Y1QKEsEEYLfm9VAgnta7fRty7NzuCulMdBsHL9uNw3tk6LnL+Xuk/79OIpG9IH/iWRbT8d0DivePiDSh9YHATpBCZ0q1gWugg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6umqqDMwvQbcG+AAMRQTwCb9C433g9LDtFHfNA8g9M=;
 b=VGVNmcuFNK54/YdWXZT1DT6uQajo8Vfz2H8/zj1c4ogxeCSJUhByNL76lPR8ETE5aO4KBfZzzTyUPUu9OiLG9McdkTQhsxXPa+xINrvgBTM3jma2kSDX5f3RR7t19EgiyrhBIDjSuPWGwrY84ztTHdEya+R+1U/uqL/a8Sjsd3r4tZPsC0fLCMJ2p3p9kvdDUfr3eq4IsQo40Hzvli04q5fT4kPlLcUZTmxQN4fzM9FpYofYSzPB7AtH+T+5TxlGwhDoSyrNtHvpRHpPz3d4RHfD5abQjo16XQ9hhf6Zh7RCN9SHojgchc/jmNLFinRLG5a+p9hMZhmuIX/QKm1ROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6umqqDMwvQbcG+AAMRQTwCb9C433g9LDtFHfNA8g9M=;
 b=Lzh2x7YPn160KVQBMyDYhhE9JLHFgaSG+envQNL7aRTZKTx4m0E3UOOLbJzGu3EuOAnCtYhmShlK1Z6PQfM79JpqsqShOhgX2WgYLNO3lh6C3m+aMr6HJz7vw+v47lmpWRoDGL+cOkq/LCIeKN2uZGzv2bwzRSaQT7vObmZQMnM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SN7PR10MB6548.namprd10.prod.outlook.com (2603:10b6:806:2ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 17:07:22 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::6943:17f7:79d0:87ab%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 17:07:21 +0000
Message-ID: <edc1ad53-096f-ebe4-8b49-6ad04bd7a3be@oracle.com>
Date:   Wed, 26 Jul 2023 22:37:10 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.4 000/310] 5.4.251-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230726045247.338066179@linuxfoundation.org>
Content-Language: en-US
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230726045247.338066179@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0028.jpnprd01.prod.outlook.com
 (2603:1096:405:1::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SN7PR10MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 291744f6-c0fd-4095-ebd2-08db8dfac695
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Yvt32vS0apDEFGuJZQp3JOuVre4sEpGGaUN6aFF1EBop9ZZDMUVZCUHbWlr/xZaCA905ocyTxiyph+AzoL1hIdiO9MCO8s8LL3nqYp+XO+wPmYdyvqxzhjoxt6t0UyYiL4XJJLE6Jj3bZ6Xfj47M5dfv8pJLWk50fpsKeDXoZzre3XKSwu31TGg/8cNBjnFu0Qkq2F6ClGBDdPUUvLnPqv0gFGwfim0CPbwpUTN+K15pc4skOZpx4vBPsv3VsCTG56KTVi/IsChka/KUxKBW7WUj16ZdIKpd5HTVgZMFCkfO06ybkJ44Bm1rfY4cLG81HzkAcSdGeOqAirLSa1G4zfAR73Wo3Bs0ZrqowRQTcGLC1mcPITh3UrzfrLH/wAgQnmsjviGJ7D25cZmpysCcYg+bSmW7RdPmtH8nTUqcWynDOO2CPVSA5sKnhxZXZ+ItCCRZxoSTt5359CANW02KbyEAZb+ftqdOt6mMSjhOVT0OqwsMXZoDauEpPI9cC2LG9PCgi283EWOWqoGwB+slF/78rM2zYqAqyI0tk5YTADJaAQwoVzbMc0hRUANuivMtVaKcGycYynBYz647ylwTgdAcEm8xp5p8+wOaCpuljYvutaNreh4CiEzMWIhO8e8JadzrKnsYa8APD33N7vlAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(31686004)(7416002)(8676002)(8936002)(5660300002)(41300700001)(316002)(4326008)(6512007)(2906002)(66556008)(66476007)(66946007)(6666004)(6486002)(53546011)(26005)(4744005)(107886003)(186003)(478600001)(6506007)(966005)(31696002)(86362001)(36756003)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJKUUs5ck9OTEorQlo2RVFoVm9YSHlLN0NhaExqeUxKc2plam9GSndKcVdl?=
 =?utf-8?B?VStSR1FrU1Nqd3BvSmpTVXhMZzFqd1dkZjJ4bFlxME1hWE16VXY0Y0t0Wit2?=
 =?utf-8?B?UDUzMFM3MFpjQ1pkWDR1Nlpud3REZ2U5cEFFQUtJOVovZXVCaWV3ODdCY0Z1?=
 =?utf-8?B?MFNpdVNzZWxDbWllMEdSQ2NHNEZJWkNxT1Awb1hJR21RTXYxcEdKbEVQdCto?=
 =?utf-8?B?QStqaG81NW1JWkNYVWxSbGlIOFM5SFByY2gydW5Qd3FkUllFSTVFM0tLSXBy?=
 =?utf-8?B?ejVmQ0xLZHd1ZDFmWUs5WjR2OTlYYk5vVjRGYVF5QTc4V3lqbjUxR3VmcC8v?=
 =?utf-8?B?TFhjbUFzc1NIeC9aYkdlQ3dzZVErV1pSd1dScmpVeTFNSjJOaDVKWDhrMWY4?=
 =?utf-8?B?OFkxYmhxd0I1QzZGYlNuNjFBUjg5R0toSkFaWGFmYyt2TVZ0TzBmOXUzKzZ6?=
 =?utf-8?B?ZnlKRFFsUFptYjIwUnk4ZTdITDF2MVNicUdHeDVOdzBVN2o0bzBtU0E0OVB3?=
 =?utf-8?B?akZha1BaMm5JcDNSWEdPWjdHTUVZMWpjcUoxTEhQc1o2SFhOMnZKNmxtK1c5?=
 =?utf-8?B?Zk1oZUpXWitPZW1Da0dTTmN3OHNVbm83SmZBeUZwVTM0a3AwcUZZZzFpN1Ft?=
 =?utf-8?B?d0hvOWJvNU8xR25ITEoxTFAveHU1TEZkV3NYYmJ3SGpBQ1lYeW1Jc1p5SFpG?=
 =?utf-8?B?ZmdQd0h5Qlc1dUhQTEpVUEh4c3RIMVQ1S0JjanJBUlUzOEF6d1hOZGtpaVh3?=
 =?utf-8?B?TmNGaG1NZzNxNVUwTm9LRG1hYVR0MHErYS95eXNtTWRuVEJRNmsvTWM3MVgw?=
 =?utf-8?B?VXIzSjI5S3FHemdpVEc5VDdxZmJyOXZTbzZSYnRDQjhPaUFOZ0J6azJGNkJQ?=
 =?utf-8?B?WjNHemhoMDcrZDNNcjlFcGRHZDgyVXZCc1pSZStiUUlkb2JFKytLTktLaDhx?=
 =?utf-8?B?NS9xTVB3OEJpYUgxSVhvc1FTb0NHY3VaTHYvWGwyU0NDaVpnL3R3VUVPSkEz?=
 =?utf-8?B?a3Q1U0xuTENCRXBwOFBVVW12YkI5RzE1TGZYb012bzJqdTdMVExqc3UzbDlw?=
 =?utf-8?B?NVk0aGRocUtGd25zL2EvWFlTcnpycitwcWxDZkthS3JJU0ZhS2puQlZSN0Ft?=
 =?utf-8?B?ZDBRdHZDQzNLU0JVZ0dkUGhaNXBJam5PTkFHK0pBSUZyUnh0TlBBRzdZNEZi?=
 =?utf-8?B?SVozQkl1bmVLdFJuZDdFVGNuak1OTmJZbXJYZzNwcFFCUGlSRDRneGVNRGtV?=
 =?utf-8?B?RXEzaVQ1NktzK1FmVUxZdWUxby9GTVQrSENUVU96Qm1nZUFUOHpyaTVvZGd0?=
 =?utf-8?B?Q1pOWm1ST1FNZVJPaE9DQ1gyRjM2TXNYbGV1OFg1SXBiajl3UHZ1T3A3TFBE?=
 =?utf-8?B?Z2tyMk9UdnVWQWZJRkd1ek1CUkx1U2RxL3FMaUE1LzJIMmVzSTZQcUNxMzdy?=
 =?utf-8?B?eG5CR0hnM0x5SitXRnUzdmpCQ05mWjh3dStHaHpPaXkwL1pxQ0p6WVZjd1E4?=
 =?utf-8?B?LzFsYW9tdTlMUlBRYVViVTU0R3hPS0NZZzFxYUZncVZsUWN3bnFSenI2V3Rn?=
 =?utf-8?B?dm0xYVkyRnNvN09iRkwxUkduQlBxQXUzM2ZlMDBsUStFNyt0bWVjVGM3NkNu?=
 =?utf-8?B?U003RHBVS1pJZzdweXlpamV5ZWJVb0llRmZ5VTNCMW4rWFc3dDdDOFhsZnN0?=
 =?utf-8?B?alFFQWNmc0dOVnZmdUlhd3lXUzhNbnI5QkJzTE56YWlNRS9kNmRjTjNsQ1c0?=
 =?utf-8?B?eTR5MThnSmt5bW1mUCswSEpZMmtuMXZIR1RJZXRsd0ZlamZJNmNieHpqa0Fp?=
 =?utf-8?B?UnJyakE1dFlNUXlwNjhLYk96TWJ2VHpFYWQ3V0lNS2JVd2d2SlhQNUN0QVp2?=
 =?utf-8?B?TE5OdHpLbmhJdzN3Si90aDFuMzZELytHRHoxVXlmOEh2V0pqeWU5L2VRUEZU?=
 =?utf-8?B?cUJsalZMV2haOWlTb2VoSVVBVHF1dEJzQTluM08zSEpSQW5FOXZGWlpuRmJU?=
 =?utf-8?B?NGZxVURnc1RjOVF1bFg5dFp1bDVOQmN6aHZJOENSdFFUN24wMkt1T01JZDlZ?=
 =?utf-8?B?VFBXcnRWYytpbytrOHV6N2pnODZzNEkwM1l2Rjg2c3N3Y1VDaDlpOXVLbVFI?=
 =?utf-8?B?YnZ3cWN5aGNBckY4eW1jKzZSa3RPSU5WamcwczNmWWVpR1B5OFZnaVdUYjVP?=
 =?utf-8?Q?KSGLOwrsk6KbLDeM4M03Vtg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R0VHOStxdmZLMW90TjB4U3hneTkyWTJGM3lpN2pjYkZ0TzlKdld2cUFHYURT?=
 =?utf-8?B?RDJaUnlrUVRYa1hvKzkxU2hMSFA4Z1dQTDN0YkVTT3FTR2Fwc3cxbElIUTZw?=
 =?utf-8?B?a2d6UUNQYUpOSlBZNlRKZU5KZmNUTldkUUNnMmpNb1R2U2FtNnFzcERTRGJv?=
 =?utf-8?B?ZG42K0s3aU83Z3QvMEpVQmdVYUtjQ3NvbHNmZHpUejFjRFBvWXlLY0JHWENG?=
 =?utf-8?B?dEdlQ2ZmSkNOeWVUcWYrcDJ3WUVlYkVMTkltbmczZlRhd0JkWUNsTFpsRGJv?=
 =?utf-8?B?cHBnbHBVczdELzFMRjhNY0htU1gyWlpaT2JyYWEySXo0VDRoRDd2cHpGQU1i?=
 =?utf-8?B?Rno5WHhtM3JBLzd0bEFyNU1ubUNzUnZidGFLdVdSVVpUVGNPNEJtdGVJbDNo?=
 =?utf-8?B?MUJ6RzFvUG9kTHpoOTJkRk8vYll2TC9PY21QOWZRL2tvOGZwbnF4TnlIMktS?=
 =?utf-8?B?OE1uU2NZOEZLeVVZNjFEWWNvSUhjTElOUzFSVzBad09JNkwrb2dKU2VDdVVJ?=
 =?utf-8?B?U1pLdUxtd1ROVkorckNyNGh5eWVvS3hZNlA5WjZ2b0c5K0FScTQ5UFBybVlS?=
 =?utf-8?B?OEU4bGd6M2VPZ1ozNUlFU1RIVElTK2ZJVy9FNlN3eVpHMWhCNjhoUzZYRXRz?=
 =?utf-8?B?NTFRMjl1YjloeHh0cFk5OFBsYmRESnR2NTFuU3hrM2lnVHZNS0o4MXAzSmgw?=
 =?utf-8?B?QWczUHVxZGw3ODF2ZlFIWG9JOFdZSUJTRmQzR0FscDd4NzN0SFVQcEM5R2lD?=
 =?utf-8?B?UE5OOU1WdTRsTCtyVEJBWi9iN0JOOFZ3QlhVVmhkRnBmemNTekRGamMybkw4?=
 =?utf-8?B?QnNlRkV4Y3hJdUpRS1NJS2tQbDJFdEVtTWRDK2R0ek4zaWVkVndMUTYvMVZt?=
 =?utf-8?B?aFBOQkoxUzRUMXZiT2RvcmZybGRsbk5UVXp0QzdQdXJEL3NOUlRFOXM1Tzhl?=
 =?utf-8?B?cFFzbU1YOGMyUzFSNzNZQjFiZUFKRk9xcVhOOHVVY1BKWWR6eDhFZksxTzF6?=
 =?utf-8?B?ekRVRlJ6OER0cWgyTkhXcG05RlRHZzFGL0FIU2MydjZOZkxpWjNUOTV4d2N1?=
 =?utf-8?B?OTNCc213UHBhcGk3OW1oR05BN1AvdFJqQ2UvWFNnSlVwejhubC9lcDE2WUQ0?=
 =?utf-8?B?N1QzbzBsS1lpQVQ1NmZmdmVHUHJkSGlKUm80bUt5ZHkybkw5OGtxc2RHeHY4?=
 =?utf-8?B?YTRHbzNobmp0VWV3QWEyZHN2N2tpaE9WRkhxTldoc1RJUWdYK2VNMUFXQXF0?=
 =?utf-8?B?RXNhemF5dFAwdDQvajdjQjgza0FWWU9HV2lhcWdnM1ZLaHlOZm5hK3h3MjNv?=
 =?utf-8?B?Yjg5VlZVWTJ3bld0UGNqQ0x1QUtOOWxjVGxXbFUzaDc4YVJKZ1dwZkFvYnVt?=
 =?utf-8?B?RnppMkxPSzRlZTY3RTBSSEQ5bmFaY1dnN0xEQ1F2NU44VGdtN3E3TVRaOU5M?=
 =?utf-8?B?cUszaFRmQXNITVY3TkFkb3FDSG5iejZSOGpJNGFlaWgwK3BpYXM3c2VsazV0?=
 =?utf-8?B?OWxQcXhDZTZJbjA5OU9MM1BxeGJNQjdEbEg5S3lwdHYxNDhlMlNqcWpUQ0hX?=
 =?utf-8?Q?E8lLGrmlUNUKNv26K2wf4hwNl5+3ZIhMrxMUxp7R1l01C3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291744f6-c0fd-4095-ebd2-08db8dfac695
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:07:21.8539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOKiFuFRZgzwNm2qpVaZyicGQIwtCyXSdI9A1IosVn0TJAneY3FowR9d2vpg5sWlC9+hMefs2H4WnsjSNf1bPGtCWvqQ41Xk+z4XHMPSbyIZbpsiCtBQyUZKl+lW97BR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=981 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260152
X-Proofpoint-ORIG-GUID: HU5GE-qLUr17QAfRx0H0ub85zUqjkcn1
X-Proofpoint-GUID: HU5GE-qLUr17QAfRx0H0ub85zUqjkcn1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 26/07/23 10:24 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.251 release.
> There are 310 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 28 Jul 2023 04:51:55 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.251-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
