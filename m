Return-Path: <linux-kernel+bounces-36718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DAC83A573
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317CD292940
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862F817C6C;
	Wed, 24 Jan 2024 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBamk/+F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N1tnaEt5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCB1804E;
	Wed, 24 Jan 2024 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088640; cv=fail; b=HPYGi7mkyB0hXLwQN95elPmf14jim6LMvUJhJVYINXWPFZNVw/OB+rASbMlxG4kBOIQI3KMT7NaFdQDMo0lgvnDESg6JULS5rcP7nF4y++udbmK0Z00c/HGVQuP4P123ESG/iinUYvfLQWe1Ft/zlLkomh2YOEdTQwsHJA1JDqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088640; c=relaxed/simple;
	bh=+dDFO1MWlN90jDxdD2g5YM/uldtttAFHD8SSH0V51mE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FU6ptOEPX0OpcJ23UrDnkqvuzog11LwK2n91OvLouchd+hwnOJ6uSb3Fb57v+4Ca2om67qNoxVY2Wz/50zoDbSAarBgMjlbzfc8Knv6PNXzzX1sdWvreySaq8U8D5PyXR535ZBMZt+AYmEYTjZPjhl4cbGgTGwQK5gCcIbva2cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBamk/+F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N1tnaEt5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O2x39r003508;
	Wed, 24 Jan 2024 09:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Vtqb2Ln24g2RnndyQGtyl7xdmwu5ITSXJv9diNVRAA0=;
 b=hBamk/+FBY3YZf3Ia7ER6nSjwdKqLqA55T5GrhbWPAgewU2cXffnnHIS9LIew/xTeC3U
 O6OEfDOLXJrjxYGXe3t1cS7hI7Ml1jbfmoYh0Ha/BzChxN6rzxjWiyCQuOBkpVtorE0M
 GN093LL3IRorffwllXfPT3XXSA/pXFJu/AYAcr8kaWLxak4rCyeRNtUJ6G0K5etrZt/p
 xyHDp+Eu3U/rfI0pmlm8QVQazwxxXUnzZgrdt61F3YAteSkzRGmAaZM2JdvGSelzUIMH
 eL4dmGyb5yNPvkvpDZH5k9NY5LBPzIyNDxVmkOo+h0Yd6am+LAxHhzCW+zAzMD16f09t vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwgnf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:30:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O9QB62001721;
	Wed, 24 Jan 2024 09:30:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs323puxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTFaF0OEfov+nj6GjGtCNR/X/ti4Lvstzg6gPjAf0SjKLtgEdFEqyCHwon7CkSibFFBexh5bq9uMCk4xtH87BYt10EmEunJvXLqLTQ+5vd4wNqUZ/vTyVcJYfVBcDq/fyMykJJCfpArPfqo4FJ91hzeS/o9SWJnrbQj3DO1hA/4kBzOAyFW9vX45hdBByxatKuL/TjSy+VWiwoXo1WCxfEdqBuNL8DzyrVaSUoLoCo3PPPrd1mwDiNsrQ6sNG3wK06QkD0Y+XQr29nzuVyR8btYYz22/RrVCCIBDw8QuaCTS6QGJien/L8XCrs40aDcZ8VxP36+s1UQBapdogMumRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vtqb2Ln24g2RnndyQGtyl7xdmwu5ITSXJv9diNVRAA0=;
 b=R6UjSVW4ciRzBnObpqXc53JBHKFK0H/6yOwv1ZFFLstlj0cfOxi6W6NWm7y7JbxJ+I3CsnJg+kEd5WpUO5YjiwgUS6CKgiUwIb9DBD0UTg8FBte3ddJWyZPejqHIZ7DddSG5/ugFyyHjTKrJD6kwyUQ3s7WU7BZbh/Idl5pqW2s5I1UyG0GblNfm5r1t96Wx6Ev655otXWgZIA6kM5+U0YZod8VLC/ue5BBljUCK2C9oPh1NDvoELQUvaPhzn9EpAu2vtOBcdQGj85DSnomirORtdYmUy/cmn8yl1D4A9joz3uCBQmroHJ2FB6Ct277mSi6DcHt9GY5gjf4S8nPM0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtqb2Ln24g2RnndyQGtyl7xdmwu5ITSXJv9diNVRAA0=;
 b=N1tnaEt5Ldev4IJkaJUzB7Np/hzmmFnClD2qCwFAIaM6Yade63K+vVsEopvaCLnMz3NYqLrXy6gjxjO+ParROcOLkv2blx/tVwy9+pt1r62G/T0gRtDtKlI4Q3YF7W0teTTZEmg6aF9Sg7VgYYXB4WS6AYpEEWoLTljyryokSxw=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:30:01 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:30:01 +0000
Message-ID: <197f75cf-043c-45a6-82d6-00049b71c7b9@oracle.com>
Date: Wed, 24 Jan 2024 14:59:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/194] 5.4.268-rc1 review
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
References: <20240122235719.206965081@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 031c5858-cd7b-4c28-9f44-08dc1cbf0a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	W4DUtHKk87QM3m/8KwYqgYnZxWUxI9KFGUy5aIIvjvzUVvFjKHZRILkPdW20k1sHDPbeDzHsXwvgK0kWmZwQAIepZIM4koFINKlRt2EbxwGFljUlc/WH8lEVw0if/eUnzOXM3zEG+naAYcZqztg+CtU99Hd+RhXNB6QvQc5t4Vqv0U3vkalCJYN7Sr6eYdGHimtt55F4DIo+Gjp54elp9GQgB8vlR5LYjOkWRxQWKY5kqKfj5PNhMujvJYTUMqt1BxCoIO3DvjwVFC1ptULBr17235lXLTCffBylL54XeHA6P3Vz1Lpbk0v9jwLJpoMc1seEIB+h+qsiikwN2Rwk/U9MduunbfQ6al/31V6KGcHazBrZRypaVEg7knJVYepz+DAqdHiGYcPyjisLX3hjhs5v5xufcAygFGevMrwmpL4r4mDsY7BNv1600+e4JhZy6CzADup65BQc1nrQ9i9RPalEWVlddJv3X8WxSDQZljo+1ZUnA9CB3oS0zk+wBmFf86RF+pysqPE9wA62a/aVnKLJoSLY8nf2taizCyjp3v+Qx5PDWsdmujKx79tXDhHu8SGZJ04nB48h2QVgBMrGJX4fs19i1vr+bd+oE3ofYG3Vo/rQ7bJu8/eyzb4EfXKVNDfahS8s6Z1IMgrdF2th8g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(2906002)(31696002)(6512007)(26005)(86362001)(2616005)(4326008)(8936002)(478600001)(8676002)(41300700001)(107886003)(38100700002)(36756003)(31686004)(66946007)(316002)(5660300002)(54906003)(66556008)(66476007)(6506007)(6666004)(966005)(53546011)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXROYi9ZYlFxazczbEpEdi9ZbDBEWUVqVFNsVTZqZTJ5RHNjY1FPeXl1ZUI2?=
 =?utf-8?B?ZDZMZDFFdHlvcjFoN29VRVdWOXJ0SUo1cTFKQXlQeFN2T2NzTVRTaGExSkNW?=
 =?utf-8?B?eStyZlp0T1VQSTQ3ek5hOWRHUU0vK3dpRmhwcDBaYWR5MFFkSGtSZ01RZ0lk?=
 =?utf-8?B?aUVVdmc4WEk5L0ZMZjZyZ1d4ZjQ1aDNvQVhRMS9oWVphQ0IraVBLckxIUnFr?=
 =?utf-8?B?aENwVmYyWUhlMDNmVHc3ZHAycmpuenJ0cUxRam9NTWVRVHlYc2swSE5yK2dY?=
 =?utf-8?B?cmhtVzc0dTRrOTZZVE1WRUtuRWdWcWFGUk90Z25BdkY0VHZYM0haN0pVRWFN?=
 =?utf-8?B?STRvODQyZnhtWEMxdUxNdlRhS0RkQy8xaDArd0lhT0FhQjNlems2Zmg2RUt2?=
 =?utf-8?B?Y2dkeU5Td3gvazQzaFAxalVSeGhxNUp4L3JKNzFUeXpnUW96Sm15c1JzYXhR?=
 =?utf-8?B?bTZZMS83SCsyYml1MU82T05RSmliM0UwRmdobHpoVUlKVTgxRDlVRXNPUFVi?=
 =?utf-8?B?dEtFa1ZDWnlkOU0vS2FNdG4zdjBRZXpYTUQwd1BwN3hZUnRBNkExL2lpVEVv?=
 =?utf-8?B?VWJZbFlhSy9jWmM1RUVzZlR1bGN6aTJzZU1LVjRtU0VhSko2NXg0TkM0aS9T?=
 =?utf-8?B?T3Zud05wWUNRR3R4VC95UHM4U0t6ZTN2QzlHc3VOWG1FYmZiOTNsNUo2Q2JG?=
 =?utf-8?B?VzlOZDZwemdUZzUzWk5jOUFzVmdmaytPbExxSjArSmRnNHFBZkx6d3dJcFZ6?=
 =?utf-8?B?YWFLL1YxdEJrMVo4QlIzMWJoOC9wcUhpQ3ExMGpiSkFaSXQ5QStTZVU1QnRp?=
 =?utf-8?B?enJ1clU3cnVsT1ZLUlFmdmdWcWNiS010MjUybnJUdVJLM0pneVVnRHR6WVVS?=
 =?utf-8?B?cmdSQTFTNUhlSTYyK0FVSXdObVk5SHFlWEl4T1hmNktzVS9lU3RpdGtUdWlY?=
 =?utf-8?B?K1U3SE15MkxPb2RZdDJnY3lQWTBwTUVoV09TVGJaN2xEd05MODJ4WWc5bXlY?=
 =?utf-8?B?bGhpb0ZrQmZPUWJmRlhHRDFVdVNQREZidDIvMGRNRFF2U2d5T2I0UlhJNXI3?=
 =?utf-8?B?WEU5SWpvbHRSY05VODd2cEs4eW9YcWRmYUFFYjZCV0pscUphMlpkRXBPKzlE?=
 =?utf-8?B?UGJCTGh2MGI4UncrdzdLTnFMTS9GZ0FielpqTE90NktNSVNRRE4zTnFhQ3Vq?=
 =?utf-8?B?TWZBeEhrems1aUl2bnVYeEJxM2ljSXRNaVZLR2d4NTRIeGZOWHZKTk5kMjZJ?=
 =?utf-8?B?VDBQM1d5R3JFY1JDZ0FQY2h6NGZkeFNhMDJ3NXRaRWdWZk84Q1ozUU9yYzRZ?=
 =?utf-8?B?STVNMUN4TzdCbnNuakgydUlhZmtwNXRrVTVZb0pkZHhyd2N3YkR6dXN3SDY2?=
 =?utf-8?B?Z1hVMDFGTEsvdkVmcHY0bFdZSm1GUStwU2Q3RkVvQURLNEFTUUNSdVNrYjBx?=
 =?utf-8?B?T0pGTkRpN20zM3ZjaXBLTGJ1VEFSeWw3L3Y1dmlVTHlxSTJBMmI3cE9LRUgv?=
 =?utf-8?B?bHIyZE1wWk9hNjMxblhEU1dxSU5VeWZiWDVMd2dzdU45RXlQYWNmRnJtelpM?=
 =?utf-8?B?RjJwVlM5bEpGVjVza3hZalgrVER6WVJrbGlSYTRGclZZY0tLTUt3T2pYUDV1?=
 =?utf-8?B?aDhEM3kxbHNBMTMvdXlYUlRuMFpVSGgxMmpQY055U01lb2xWN0w0OWozQ2VL?=
 =?utf-8?B?WjI4OEFhVHppYk0wWWdYVVpmNkI1QmpoZHFOb3puY3JaeGJBM3JYemwrczc1?=
 =?utf-8?B?WmFFRGIvcnl2bkZ6aGQ1MTJoVDNxM3BqTCtwSWRMQ2NnUDhUOGdMbHZKSzZD?=
 =?utf-8?B?MzlrenBFR0JwREFFYW9DK01BUEpHWDFkR09kcldPSGpjWEM5RVExQVl1Wldr?=
 =?utf-8?B?SXVnU3JOa2N6anRFSitKUmZtQWNlM1ZTQ1JTdUtOdW9aWE52L1lwZ0tlRUNh?=
 =?utf-8?B?VEVOZXZ5bVFRc3krdVJDRDFkZ0FZNG9VRHhZakp3cGpLNDArSkl6ZnVEdDlU?=
 =?utf-8?B?Ym52SHp6ZUpBMHUxcW9Xd3E1dE41N0NHL2Z5a1pnMFI2cWIzQkk4YWZrU21m?=
 =?utf-8?B?dVpwWGxla3gxb2V4Q0NCRkdxNDlzdVY3UG16VTdDdFN1MGlwS2Y3RTI4dExU?=
 =?utf-8?B?S2hRZ3BTa3BITWZBeUZwWVpxbHJkYWlQZ2N5a2dabHQ0S1Z2ODRLbHJqemxE?=
 =?utf-8?Q?reCCNclef7hazrSQUlqJSNg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4yofsltXSGjC4ffa94cESOpNHzSt+z+hwuwv69pIac5kDA/0ClN60PprtFyOibhb+KhMcjQCIw0WmMTBAOfCSU3bhOc08hqNkydGQZ3w4w66CQnJUeOCyCXlKxuncqdJnh362hRF690VdmlX/jOJKZOgHpfY2StYkk1YOguKBr5v/pHvv4BKJ3AbJBXz62a4X/T3W43lzkmI8z/FKqLEAq7ZNZoPOaKLjICr7AJvyUa0w3KSHM2NlQYAW3gWanMw7wIfbIeeWVbSi3LNoAZ/Kl0LyDR2ey2Ohh6Idfshk5kE+zLpzzoCKBgKcEoPS5y+Vut2+1Tach4F3ANR6fYOBohB0K8Tk7wzk9yadN5X/oAUrWkEWCSkM5qwWkkI96R7Uk6QcTx1vF3K4RfDeUowlvRwRjn7e5b7/MwNJqvkd1nMR/kVuJPAIsjX8eD+MZDJrLIowx5kC4z7KVmIa9xKswyacjbeiSXKsMoN0xUvGTqW6TFwasEnZ4WJgB6tNKUkMKQYUV/Yoh2HLz4lLGGsGZQrROyyxcR8Brz4bE/d2DNZ+WcVBtAjTWd4maHtaPAb2MzYaHwcXuO5lH23wGXOPBBaEN910tR+1L0KQXDrSVE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c5858-cd7b-4c28-9f44-08dc1cbf0a1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:30:01.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sW8p2iRM5KrFrcDm69nXTKpsENlKZIMJ+A6SR3nrhvIj/bXHMdS9uEi9jZS9Ucfw37kl8Wq/zAbz+ml4nCXuDLbQjlPX3Jp8N3kdo6JHCel01qJKfVXY3/DpixnLRz0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240067
X-Proofpoint-ORIG-GUID: _IIKJxaON8SN6_uPuDOEEZ-M-4OXWv9d
X-Proofpoint-GUID: _IIKJxaON8SN6_uPuDOEEZ-M-4OXWv9d

Hi Greg,

On 23/01/24 5:25 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.268 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 


No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.268-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

