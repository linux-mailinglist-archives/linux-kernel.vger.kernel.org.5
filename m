Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D3F7D5BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjJXTnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjJXTnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:43:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE70310C6;
        Tue, 24 Oct 2023 12:43:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OHd3Ht018325;
        Tue, 24 Oct 2023 19:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=QT24eNJCbaTrWOGCmwFGw2C88q6wb3pKEJJl+uRPW1U=;
 b=UbSF2CVaFaHoLBGhZW92bE4FdNvywB7F4y2rY7SoEGnZu759UCu+g0JWRJ8NPfPO6Hvx
 CV7VXTzHy3PgnPLeYi3rlfN/qMp28lDIerMTyJpMmywBLp82L5DqzGUC7wYfTR33NmD0
 Ies7ntVTzSBlj/AIy6pbdTJMrbngGhaghmvV5BYCGzXMcuPUhRAlgjhGgc9mImW+60jy
 ZuDPKJSfJW7kzor/8XntruzYYilbHaln/Kdk8na/B5hZ1/sxwiflDqsyOZncuml0R44g
 DeQcOc3/wDBDs/YQrgN6rSnROUsGaX/F3zu9SpHRMQAUobofmmjayG1qcJ23BQhRUB65 2A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e368s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:43:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OJH3C7015130;
        Tue, 24 Oct 2023 19:43:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv535qfsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 19:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt/m7BSAq0eEpAVnM5Gd4gRfpJUMPuKwnsGk+Kw1NGx7bJmXAWCwle3yOV1C+jj75mXIIu2XemLsowrsBo05XPElzoJZn950wL2qcumYXYZ8rOA2PCgx98rdxMeQzClwecPGB0v9KFsm7bSDQErHca7IscNZc/XxrjjKYQNN8mx0m2cus7FxX8EhBmZEcjjfdv1FaS+hwQMrRogejKkixEv2EzxYspCD8lHuqHi11DA/480zY9y0QC7Kp7gGAAN8+pPBUSW95Qyl2VEa7a/VlfIWSELrpHZpanciXxxJjMK1hifXsW9/VBP8tVtAOwbRBW3//tfj2H3ivWnrs949uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT24eNJCbaTrWOGCmwFGw2C88q6wb3pKEJJl+uRPW1U=;
 b=hj/KPzz5M0UkfQKLxTdd3/3jckQgg+QFl1Svgi4zb/aKipCHA8qDU6ObonaIrGl6TmuJK7KxKVubCf8IdID3jGw8kZs1FMqrrVj9o8Ybs7A/l/tdiHdUhbWaHOMYlWwVZEgjp2klypb1s67l6rUNcvlqlSqhjzXRsepZx5+wM2lrQuUSJk97ZwFKFI3hyQ8fZh9cuUVjwEUyygcCjUrj3FiQ23ZcZtvgA4KdArVjXbrR5Y2LjgGxKYErE/oNkHl2JpBWbl5e4PEUQvEEHLFU0Qk6hW4EOhkmXbixCAlFRChwYPW6C2nXdgJm2S5ovD7SSIlHeiwO0FOh4GaPy2iheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT24eNJCbaTrWOGCmwFGw2C88q6wb3pKEJJl+uRPW1U=;
 b=SKvKSaxvBj2kfJ2Q+USDLQ7040/tR9JWrEDlgQqAChJebCVPMd2edy5TC2d7xgeAI8LZcs9OMyb89Rbq7u26j7U1mI0Q30KNrAM7GxT3n4UKv8vKni2VmmbmcsSkvBsoXLIVVnz+VA3wntThGBuJcFRI6MbVy+Bj4YJjqk3Qpu0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 19:42:46 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 19:42:46 +0000
Message-ID: <cc3409c1-cf3a-4802-9479-27969d928d6a@oracle.com>
Date:   Wed, 25 Oct 2023 01:12:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/120] 5.4.259-rc2 review
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
References: <20231024083306.700855687@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231024083306.700855687@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: f2358540-d9fa-47b1-0b15-08dbd4c9657e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TX4SSeqcxq8PwNsyo8V8XP/9xaZ7Ae6Dyld1h/nnEfgPBCySJLAnN2QTF0iuoYWJJqDpEFi/Ir6VzVHAxq9uPpeWsMTpvWlba9FrVTSiUuOQWDf2M7MJzhpaDXBuCDEgyhc2xsPlyzFJXJxxD0XS3Uv5ziiPFT2MaXFnsKNZbDsJWahdLFIcS1WYmPv3XLNTEKG/A1vawfpSAiXER1RjIIx4XJfR5ui2EtUMycxL0Wk1cHyMzvTdnN2WGGqsTsOk/kT2F4j4cVFQWZl3yjtLaVN/ff2PxDuE3Na1qk/azoIcoxFuZyHpiHk5UUqJhrzOJRZRTt2lGMp1TzyFFHXm198+mX3JNz7XcHi6fKcuU+Hz+sUGjaWzjso99auuJXdNfSSZQwQsb1Zv8kt51xOoJAGhiiCSHebc/Ca6UDADNlQ5W7CVw/OBBZca2jZi+3AOc1Il0yma+KwyPW1UBhxJspAbpA9FiuOT7i0LbgvMfRKJkGltSnpYzfmITLQjNOp8dUx5kzJWPoyGp9Vpcv7e6yzVnlt5EdFrwbhllgUpK1zgcuNCsFUlNQ0pVr7kJfZb+7SfZ+GJ7Qq7mH+hSaRCRRNSUW07wMzKIyQm/p09E0SrIINVNYUCmz4p3acVigrR6g9/07BRtvnJcZMsnSbgbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(966005)(478600001)(6486002)(316002)(66556008)(66946007)(41300700001)(66476007)(38100700002)(53546011)(6512007)(6506007)(26005)(2616005)(6666004)(107886003)(4744005)(8676002)(4326008)(8936002)(2906002)(31696002)(86362001)(5660300002)(31686004)(7416002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEgyRkt0Z1RRRHRyM0IrV2FwTjhKeWF1NzJiQjZWYUd2R0xtY0RiTHVLTmMz?=
 =?utf-8?B?MHMwY1ZRMElvSlZlTC96Ym1zTnZVSjB2UVhjTDNGdjF1VE1vTmMybDJVd05D?=
 =?utf-8?B?TWRFSVRTbWhRTm9BdUZ5Zml3ODVaNG40bUhtS01uODVjZmxmaFlTRkZiTkMx?=
 =?utf-8?B?OFJzbnJOVjZMMGZsMHd0YWJJVkZqdzVpWTF6M3FPVE0yTTBwOW91eU0wRDFk?=
 =?utf-8?B?RWFMaHI3TktxY0VpTUdZcGlhL2RwRSs4T0x1MEl2NVErUWZuWk9zdEMvUkpE?=
 =?utf-8?B?K2dTMVpLRWFKQ3grWXZHMXZRcWhqM29nZE1HVE04NCt6emJSVStxc0c2TXRz?=
 =?utf-8?B?V3dCaGNCYVhkU1ZQdFQzODRYTThWS1hQcW44VkhkakJGK1l5RTZkcy8xZlNB?=
 =?utf-8?B?cURxY2tudVlySlhaano4d29TK2xleHBRY3ljaHB3QmRxTnh2Y1dUcWp1Y01G?=
 =?utf-8?B?QTJsNkVOMDRGcGsza1Z1U3I0b3NOb0dKd3RVQnZpUEFGR1ZoUHJVNU93TTQz?=
 =?utf-8?B?bzNVV09Oc3dCMHNpQjdtTkNhM2pFd05TTTFPNEFpQ1Irb2FRVTE5MENsQVVj?=
 =?utf-8?B?N3NFZ2h4WGxzRkx0aENlbFVFVTZaZGt0aHV0NG9GUW1oelR6THp2V1R6RW93?=
 =?utf-8?B?U2ZBV1BoSzdLWVhzNGV5dEE5QmhRUU10cGE2WGpvSWp5WUxiTytJSWlJU0ph?=
 =?utf-8?B?T0lIbEJoOEpLMnhhbU9YeHJPdHNCbzJEM1ArdmJSZXc0ajQyRGNxU2c4Q21v?=
 =?utf-8?B?RGQ0NVRDZWN4OURDQ1RQb0tjaktEeVhFSVFZekxNbWw5elRHVFN5bnE3dGIy?=
 =?utf-8?B?dWtUQVNGMlBway95RmFYQkdnM2tmb2FxQTVObThyeTFsWXg1OTFvZW9FZTEy?=
 =?utf-8?B?T29GZGNaUDhUNjZhcVB3MnVYTXNIcUtzMGZ4c2JNMFNNVXFvYnpHSW5yUmt2?=
 =?utf-8?B?djJYTnNaSGpGV0s3ZVdLNVMxbkVXN3BGQ2RpNzBSbmRqMExmeERLRjlhaGxz?=
 =?utf-8?B?VldyWGZSL2prWGRCdkRGSnI3UE15ekJJOTVLUlE3UHJLVXp5Tkw1U3BvUjFt?=
 =?utf-8?B?dEhSK2lGcWUrTzlwck1RZVYzYVJvNTZFV0V3anJ6VUxsUEVLR3djUGQ0QW8r?=
 =?utf-8?B?d1J2M2VFUlhLTHQ3YzVhaGxlMVVGTEJETTN0aVpZdVowbnEzYWd5M24vVW1Z?=
 =?utf-8?B?ZnpFQVVQMjlDRWQyaUFXcmphWXhsbDVBSDJBUHJFUm1nWUJzT3dPL3p4Njhn?=
 =?utf-8?B?TzY3cHRLS2Y0akh0SGd2L3ZPN3ZXRmN3cGNvUHFURmltUmVzdjEwSFRrR1pO?=
 =?utf-8?B?bzN1a0Vjb1d0TlpJdXVUeWdkQnlVODNOd1J6cE5wSFgxWWlVdHhRdGdCUnFM?=
 =?utf-8?B?elVRVG4yQjhSU1NQVXhDQUxKbVBnZGdDdTJQMUVUTVpNZy9sVmQ4dCtKMWgx?=
 =?utf-8?B?YnFuaVdwbGFaTEZDVGpJUk1xcXlkcjNnTVNhL01mZElNOTlDdnlacWRLU01p?=
 =?utf-8?B?dkdyS044YUl2U2o0VmpVZ2dMYUdiQyt6NXFqR3U4cDg1NktNUXk1UmlxNUll?=
 =?utf-8?B?ank2STY5Mks5UzFpNURBRVBLUGpWVllQR2UwYUl2M2tTYU1IZi82UzZaSi9Z?=
 =?utf-8?B?TmI3Y1FJcFk3VjQvSllvakYxMjl5dmp3RzFuM0NKTk0rV0wwbEVSNTZScUFD?=
 =?utf-8?B?Zi9TYlFxSmNjcFh6QWNod1k1YnI5MEw2UEsrbjlGNUdyR2RmWkZGNCtKTjdR?=
 =?utf-8?B?TkFvQU9EcHdiUUdkQTNKSFQ4V0Jkc2tnVU9nbnlpN05QanYwREpTVDJhSEtX?=
 =?utf-8?B?aytQMXJUaVh5VTQ2LzkrWG94cEw5cld6bXp3blMzV2ZDZkFYQzQwbjRZb2pR?=
 =?utf-8?B?Y1JIZGNPV082Zzc1V2xicHowUmZBS1dPQVRXT2doSHViNTU3UEY3cVdQaVN5?=
 =?utf-8?B?cnVNUEdOWWhpYU83MkY3Yjd5WGcwT2ZabzF3a1BFMG9KRG1IWFJjandtUmpp?=
 =?utf-8?B?SWFmeS9Wd2ZQNkEwUzJ2TFE1MW10THBZYW94dXhZa1RzQVBBaEduRXdqeEJh?=
 =?utf-8?B?bUxwVDIwZTRadTVUNS9JLzRiKys3VjBjQXlISEtmMjcvTUIrRGNldC9yRmxZ?=
 =?utf-8?B?Z1dTS1U0d1MwVnVPWGJMMEszNmJpMzNQWGRqMlVuWm9XNndLZFZKclVUek94?=
 =?utf-8?Q?LMyXllPtT0Itj6ytfA1VtYs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UUpzTnZKYmJrVjBvNXBZSUVPdzF0K3J2TWZ2VDN5czZpc1l2aW1qdnZwVGha?=
 =?utf-8?B?Sy9UZjFLems1WHJKRi9LbGczL05YUEc1Nm5DcWViVGlzeFlnZkI5OTBJbXRk?=
 =?utf-8?B?empGQ0w1UXJTN1ZHOEVqL2J1a01tY2VNSmM4QnMvcVN4TkNLRStkT2lFcnMy?=
 =?utf-8?B?b1JrbXMxL2hpN2loeExoUlBjM25BOFhSZmo4WTZzNEplbE5sNkVRbzdnOW9E?=
 =?utf-8?B?WTRkSWZFMk56SzIwa0FsL1RubGtWSnJ0YmFZTWwzNnMzQ281dTZkS2l5bWli?=
 =?utf-8?B?c1R1ZXBVbFY3ZzRaVklaOUM2TUhaWGtBNCtIbFdjR0V1Z0Q5bGNtUXZGRlk4?=
 =?utf-8?B?ek9nRUlYY1J6TnZYWnVIRXZmNm14T1cyUGRJQ1ZPd1gvSGVCbUplZGNJZVNw?=
 =?utf-8?B?UmJvcTBxM1ZpYnNxL001RFlhVWc1UmF5cWQvRzZpR213aDR1NVdSTzcrdUtD?=
 =?utf-8?B?dVljSUZIblh3SzFDdWY4ckJZTGtnZzduR0VuVmNLR3luYkRoekVieHkwTjhz?=
 =?utf-8?B?S0VWaDJDZkc1UlVSd21jTTBZaFM2QXUyTVRFWFhXTWs3WG9SVU1YeldqQVBP?=
 =?utf-8?B?TkFzSk0ycVFvQjFOSlNZNFd2L3VRNWd5eDhXVjZNZFF0QW81RWFqWmQ1L0Nn?=
 =?utf-8?B?N3lpdVdMa0ptNExuamRaamlvTnUzR3d5WkM5cnRmU2UwMHQ2RjBtMklERUpw?=
 =?utf-8?B?VXRYd3hwa2MvZXY4S1JMQmd1bTBjU1c2cGRVMHRkbWVDZnhzZm80MW1TdTFo?=
 =?utf-8?B?Ung5TTRkL0xYL3pldzA0WmU2K0syUXV4Q1c3ak5xaVRDNy8xWkFERldqQzY3?=
 =?utf-8?B?eDliWE9TLy9PT0lnZFBNdlhFTFNlSkZEdzc3Mitld2pDQjdMcFppZzdzWGkw?=
 =?utf-8?B?QjV1RnRqQ2RLVmdBK0NjVk5DbjZINVdoem41MlQxTUdwWjMrdndnNHQvcDRH?=
 =?utf-8?B?eHJ4aUwyTVpTTEhDUHE4WU9sVXdaYWZUM0VqZXZFa1hxQmRYZmVEZExjNEJt?=
 =?utf-8?B?eTh2YS8zR3lTWUFna3NMUjRxSm5oODR3SHpIeDE4RDVZMU84RkZyeCtuaVZj?=
 =?utf-8?B?ZkdLeDdBNjRuSjFHcEwvYTBSSUVhRGRZclJHa1B6OGFBekFoZC9yanNzdWxJ?=
 =?utf-8?B?anJwSmRXWTVCTnBiMWF0dmNoVk45MTFiNmlST3A4R2RSbE52V1RWUVZzQWdZ?=
 =?utf-8?B?R0xRSlJSc1VZMHR0RGV2VnYwQlJjckl6NFgrSWI5eFUrUkFGU1NoUEh0ZXJX?=
 =?utf-8?B?TE1BT25WSUJJQjBPbGVYWTFuRSt3VTk1NjUyMm8wTC9GU2ZtaHg1MTBBemdh?=
 =?utf-8?B?eVNVdUpRb2hPbFBqNnMvM1Q5VmhFOWxjbmFrUXIzV0ZJMTQrZ0xMTnVtdlJy?=
 =?utf-8?B?MGtvREVsTXhJeGdWWitURGVXcWF5K1FKb3ZPODRFM2xtTGZ1NjZES2VFcURa?=
 =?utf-8?B?NWxSTWJXM2dEUDZ3eDhyU1A4bGliamRBaVEwNEVWTGp4RzJiekZVSFJEdERM?=
 =?utf-8?B?U0xkMG5oOTIvMi9hTExZL1dxbjRNTmg4R3FmeTUwaWNwZm4rek92UjhkRGMz?=
 =?utf-8?Q?zjWpNA85qkV4WgtnXT1bxiNgCJkawUBHVrT+pNmvzCC84+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2358540-d9fa-47b1-0b15-08dbd4c9657e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:42:46.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJzWIXLvCef/xDigvLqHij6qBJuwQ8tyX1cDiaxjpDK8CjNpqyNjqDHZeN3xGS7yUZSbEKVYJXcUXocNd1/4/DiQCzTBj17NSr13gRDW2Gt8UtS3lgkVtaBW6aPgXtW0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_19,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=984
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310240168
X-Proofpoint-GUID: NK2a4W9fY1MYCswV18NjbkBSvuloWZaN
X-Proofpoint-ORIG-GUID: NK2a4W9fY1MYCswV18NjbkBSvuloWZaN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 24/10/23 2:06 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:40 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.259-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
