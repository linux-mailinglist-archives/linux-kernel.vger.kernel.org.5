Return-Path: <linux-kernel+bounces-38715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28A583C496
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5AFB20F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5B634E0;
	Thu, 25 Jan 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ENHTnLaU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PqbnjiyJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683B634E2;
	Thu, 25 Jan 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706192494; cv=fail; b=QYW5pQ6agVHoVOYfP8x9cSXDiJ1ZzQ55gPe4imd5pTzg26/ruIHtLjxxw5RqW1dB3loBx5B4sXeoxMYsckuH1x3UmyfuLaEDgPgpKBDRlXklXDZJHca3IR7Yb6oPlz9heLne16ZZz3RM3V9a8a38PD5m/kaHSgHUzyXaJEaOU9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706192494; c=relaxed/simple;
	bh=0f9aopYHzUHn1gdlLqWPYz5wy68539/Yy1fISNsamSA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=askUxAwrQnGJxZGQy+k7N/eAzMSjJ1B6sCwyaUFor0W2D379igcrU6q/qGvINDW13kFF7UCh5z3LO/FkIwd21ESBc+z8SusCsV2s/ZH0gjvdOpaGOyQmoKqxHOxqEz91dAym7Lo7mMOKUDRnWrhFhCRJXFHhUWFcMJcX0evl0ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ENHTnLaU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PqbnjiyJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9wwvB004076;
	Thu, 25 Jan 2024 14:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=jd4C78bRJaIgoQ1/oWvA9uFgFaQ2OQJp0zwJDyDiW2w=;
 b=ENHTnLaUsEHIGGrHwLWoZAFDlE6IQULxTDCoHyW+oXYQ80M92FtXKWr39u9RH9dKN1S2
 gP19VdtEzXf7WETvg8fzLpAmbx284TKCcYRhN8ApJWoUSBa4nVXaqe2BDa4xnbbw3dAC
 MKeFjTDu2abEoSqRzFgdAieF2PJbt8mF8LXqll9TZveyEuBW+MUfI/3QDLepSOZTvUnr
 Aq1PZ/2Oow/vpHDGusIvo//2e+NhP5Sb7aLzz9Hl5mm5C2VBPDEFnko10jOtd0Clwfk5
 toe8hIdz40SAhtSCFSH4espd1n157sLu/DShqY7GEZ8kPITTI4Axkc/EksPSCbsd0j+/ vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cwq19r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 14:21:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40PDXPah003979;
	Thu, 25 Jan 2024 14:21:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32ugmwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 14:21:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2PNL97pWcrZ+0zwthTh6/UQUnlIE5sNqbLeJJrSgTxQFeh1HiQV+l2AwfItL4ZQRA1CJPRDXosOYqTg6s/H7090Nw5Rou0deqGAR/BhhkyASGendYz2Zj7pNgbFlIq8qexk0Teuoj9gbsm4TIpq1P/pR7OZET2NwUUoCBQmpES1kiUQ0BDkEbG16g+XmhsfB9EjAezBrEcHTGfoQ8j4NbXxyI8Oc6/edLhlaqODqzLHo4/Pei5vnzCzGQ+j02bt3cUwuKPFBX8rk42X4/Q9YlCOE7C8xCHE4b1oIzYRZnMkvy2ysJs9zASOwmH83TEBw33rOCd+n8nX9h4f3Zcwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd4C78bRJaIgoQ1/oWvA9uFgFaQ2OQJp0zwJDyDiW2w=;
 b=Yy2mVvK2VEFVP/0QTpx9DN1OOrO1663U+vGZr9TXJJiqYPoP7YQlaMtfacNyQ3NaV+eNWjcXFHwpTp8iC3BmDTGZ7T004EozPsqa+/T/kxArNExC5ozmZX84AmwKaHSMD8LGY4x4ZL0a5haJ2bkvFpZqkCYBedF6NIkcYcxPYAGeazxNESpSoFlXjUx8HcgR8f1Q6ougM4dMiV1Afqu+6Aa2DStX+sFqEX5S8UHljDIE4f1mYQSCU/wIGCXnDcA74fE7p9dTO0stN7/gXE8XVIuKepdpN/kM9fXMqzDuwJIdSM6xDWNp6V6QmAk+xJAvHBfeLQFWQKnzDjhganTxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd4C78bRJaIgoQ1/oWvA9uFgFaQ2OQJp0zwJDyDiW2w=;
 b=PqbnjiyJIUBFvfEJ+Qaulp747LKAhN973W5WesTKenV3xYOv6vVdY8IoU25kQ2ZTAP7SfBwRg/IeNXtVxe9ww8acrF9ORMpkSFmWH0PYzUzVuBKTBsCKPFey0DXL5Tu4dII6DAe1lhkRE0lQvw9aZcOdpb9/tAUFZXlxBxew+4c=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BN0PR10MB5176.namprd10.prod.outlook.com (2603:10b6:408:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 14:20:57 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 14:20:57 +0000
Message-ID: <287bfc4e-2de8-47ea-b638-7349143ab4c9@oracle.com>
Date: Thu, 25 Jan 2024 19:50:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/device_sysfs: Fix calling kobject_put() with
 ->state_initialized unset
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter
 <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com, stable@vger.kernel.org
References: <20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com>
 <20240125130936.GYZbJdkFOQds9w0hAp@fat_crate.local>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240125130936.GYZbJdkFOQds9w0hAp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0173.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BN0PR10MB5176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b49f589-2d9d-4c2e-9f83-08dc1db0d908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yMZX68yRbmCecacaLh9wXqQFXcNeyfYZidsPpRvyc9dp3isL9ZPNWztjiiBLuRjRGv2AwlPJpvkliREmUUnXBh+nC9CDVx/oYrgOgqsAFsQSTc53cswZsXjxdB7pNpI33b3vdJ8pMY2wiIv1VIvgvCWbsmE92HqBrV76reMctNQKs8tx92XmJhpaNkYrEvzFeasbRq+BOU6XuI9y03cPSzhI+r8tKeUn2VYFlW40Ej31AEEC/STbzImhm5vEBOodl8G5t9vMAGqcjPfz/n5x/hygrT5mdy0vj7rcUB/Rk1DRvrrvA37Q0h4g3hiTz+krVJkMbA3VGewCN7NCVxZZrxMw3EmEgeI/vzY/JY0BU/DWXgdYajmZ8R6SUA2vB13mC+ofjvrYT90HnpufmxlhD2AbnzibvNW7XVrxkRznhC0zr3VdLklWp5S84l+GM0lqO+8Cj6wsnVn640NLGb0OLA6L+eQS5a59++RVizmt44nngoWWHVDQdaPL3sGWfWBZcEYHcMYnLTKdCDossjIveHXsEyFYiLSUqSykdBtYAdw1K5J2DL5GssaosJ9TC4hhiSmxm6KJUV1xN0dxrcHXhAhB3E3CUo9zmZtU4/lFBPyEY0fRYaDP76OjOmEOGootOe2H3KrUq8OpiEEerLcWvA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(31686004)(6506007)(6666004)(2616005)(6512007)(26005)(478600001)(38100700002)(36756003)(53546011)(31696002)(54906003)(8676002)(316002)(66476007)(66556008)(66946007)(6916009)(86362001)(2906002)(5660300002)(4326008)(7416002)(6486002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Skt6NmVVV0VDdFFBQk50S3BXN3lORTJ3b2VFK3d0d1hpOTBnczhqNFZDYzRx?=
 =?utf-8?B?SUIwTzVDS0NJdkVmRDdPQlUyUEZnL2tNN2RGNmhJd2ZJMENibXlMOGZLV1hH?=
 =?utf-8?B?WHBpakV2ZlFTNnRCaFd4VHMwUHlTL1N6RGczK2RSOVdCTEhCTHUydGY5czMz?=
 =?utf-8?B?eVhGRjM3U01zeC93MlNXcGlIa0UySEM1emdSTFFvZGQxMWF4dVcxOHQrbTU0?=
 =?utf-8?B?NWJnSjR6OWNtekplaWpjcHRUQ3p0cVdmRVljaXZDZEI5cFYzMzFVMThsZUNG?=
 =?utf-8?B?elFFdlYzN1hFTWpBdVBVcmhoYnBzVlJiSTgyYitVK0kzN1lOTjJhcmU3QjZ4?=
 =?utf-8?B?Qkx5aEZ1aDJmYkxBaDhQMXZDSHRzSnBUdTBDVDFwWHU5aDVwSk5tRmNJMDg0?=
 =?utf-8?B?cHluR2hUUm9CSTF0RTYrN3QxUWFRVnNiRHFBY0x4MWNJMW90Tnk2cGtrYXZI?=
 =?utf-8?B?ckZVa2d6aDErcXlWRVJUaFhRODFCanh0VVlwd0NUNXJjMjJGb01hcVBORjFW?=
 =?utf-8?B?TFBkbkt0a292d2VnVDJ1RnhPNVpPekhMckcvT1BuWkFoeHA4bDJWd0FmdFZS?=
 =?utf-8?B?MldwM2trdDVhcEdSYkpHc3h1a3BMa0ZncmY5TDNmR2FXTUZLRTREQjVNV1BU?=
 =?utf-8?B?aFRmNENGbnc2dk9TNGtzTEJzRlc0UTlKUVFxajhDRnFtbzhocnlYTm82UFlu?=
 =?utf-8?B?UEN3Z3pNTmVMOUZscG9mYWJDUHFpWnlRVjJ6U2FjM2pmTnJJRk16ZmFNTjRj?=
 =?utf-8?B?YTloWXBqVndYZHpyVVV4YUtJTU9JcDg1NTZiaDF6RkVISzd1ODJPcVY2NWJN?=
 =?utf-8?B?alZrYklSaG4veG1tdnFGakRkKzI1dVpRTVl3Yk12cEFGQWU1dUVuTi9ObGhL?=
 =?utf-8?B?Z1dOQSt2MmNVMjNLcnBiRDBnZDlWaThuRXl2WWhZMWRMUVVSa2t0V29RNSt2?=
 =?utf-8?B?U1VCSGFBenExOHQyYzZZWUwwdC9lV0piaHlab0o5SFJES2IwSWpCcVdyNDY4?=
 =?utf-8?B?Nnd5K3VUY28vaWJEb0Z5dHBwcGFmSFBhNWdzMW9XeHgzaHZ5d0Z2SzBtbjVv?=
 =?utf-8?B?NmVDZlJtU2hTbWY0THNyaVpCdnNEZGFuRWtZSU1VSnN0RHc5ZHFXaCtwVnVu?=
 =?utf-8?B?SmxkbmxqZE5VRFdWQmY0RTU2dEVaT09QTVZkM2plZ1lSYzhQMW12R3VpUDRa?=
 =?utf-8?B?bnRLK3YrSEI3YWdjaVQ4aGlLOGV3Q0dDOVIrc1NIT3hwS0NRZit1RTYxaXdS?=
 =?utf-8?B?VTB5RTk3T0k2YXhXMEFJMEhPM3VKSEtzaE9ZZ2R5ZXNBYkk1UFA2RE12MlhP?=
 =?utf-8?B?RVNJV012N3VxM0kwcDlOeFM5NTFabUI1UFpsVzRyKythaGFJOHluVENDK0hp?=
 =?utf-8?B?V1lkN0tBa0RiU0NWc0lsQlZKZm5ic0FVRlp6M1E2Z3pETGFSNHdMTWtZU3RL?=
 =?utf-8?B?WTN5S2d6REFUQUs4enF1REY3WmNUKzNlcEZ6RlUyc3JLM3huT0NpMkh2ZFJS?=
 =?utf-8?B?VEpyNFU5ME44cmlQYWJYajNTRW11ZXJ6SW1QQ1U5RWI4c2NrMjNFYXBxbDZX?=
 =?utf-8?B?MDhqK05mSkNjWGpzYThmYnV1MGdsdzF5d09BYkE3S0pPbDltWFovQ0JXQTlt?=
 =?utf-8?B?cUJ4dWszZWxKSUI4eTlFUTBGd0M2d2Q4WmxkTWY3UTBRLzdYaE8yeGRvQmNX?=
 =?utf-8?B?Q3lVYUpSakd5ZFhHMXZvWFRMdW52a1o3UHRYejhidFBzdXFnUGR5SzZaNVRn?=
 =?utf-8?B?c0Q5MmNtakFvcjRsckNENUQwWXgvRFU3VVlWZ1J4RG1lSFNQU0ExLzFMQ1lK?=
 =?utf-8?B?OUZJOG96bEw1NjlZeFZOSTlWeVQ5T0wyNlZ4L3RVbFg0a1kyQkRaSkxLK3BZ?=
 =?utf-8?B?Rm5DR3crbVJIVEg4SnBLTDRCSU9mbTFla1VhOXpVTDVXY0ZUSVk2YmxMdWY5?=
 =?utf-8?B?ei81YUZJeTBqV0ZKc2FJYXpEdmFJWFAyL2YwWTJSc0dzR04zOEFMR1NjQzBF?=
 =?utf-8?B?Wmx2c0JoSmFKR3dyNXNnd2JxWGo5UnFEaDByeklDMStOcnFJbzh2VWh0TmZq?=
 =?utf-8?B?UWlCTVpCT05QMlZpSG9qTno5QkdGYzE1Sm5VK014TjFhMEtkVm0rUUdyUlFa?=
 =?utf-8?B?SjVoaHNGRDR2Q2RNbGh4dVcvdDd5Z1gxcGNwWmxlVU1FcWhDaUswSHcvbG1V?=
 =?utf-8?Q?su1qoFbexuEMEkVBiRcVQY0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	U+g4VNkiyvTO0UVJlMklywID0Bs2Cn1wKmC02ZVYatCl/8CcSfsNLX+E2dg4T3NOtxsGF066x/JfEx7QrCmTWMwb4EO/6DvOK4/tgzk4K1rQ7ioGGO5EJJAzNVJmttLKME9RK97+T0l3iJfqyooKupwW9kDaJvsXyT1IZ1N6xsiOEKK2HZHwe4GqDMb6PvHYCHtIU9rGmB3dfQaj4fSniFi3nGGReE15BjGOtU8KpaqDwCUkBNNzYNQjruHisv/ObPfmmaCQmTi/4wUNsIpRCay/k+l6eJkzQzMttu1lV1mXsSEZu57456JVUuCeu3KaE2Qz4bQ1ZC2/6WDPxLFeOVDkpNFrjKHgVSjl82S75v7Rr///UsoxcS1dm2A7Ab3r411O/+uIBNhahvmVomY8WK46LHLL/BuOA9X9rqe2Ca5shJPGdfV1ZeEw5yj8o/Azr4qLIq9c2W0YehPIcaxHA/fkONMIJZ8npfOvr4DBHmi7xxZXCs69rR4I1LE0zTYVAadGC3rg8jfMD8ZyqnvhHUeuTRvIAk4lKWJIeU9Iscwpv5najcLzs3G/oh028jAqIZNa+RwsGltFYnGvGRN9UaiFiekXjFg8eYqf6u51NDQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b49f589-2d9d-4c2e-9f83-08dc1db0d908
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 14:20:57.4947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oY+yE2TkFxmtlK4EywE/84VTgxrD6oIigtoYbpyFSd+Eu1P+VVVClVfISRvJ68bjjX/hg3swVLaiHnamS9GyXkLgPeL/OW8HAFeuNo3zbsqeBY2XaaV+DfvjPz4bfQsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250100
X-Proofpoint-ORIG-GUID: EJlnrIBWSkiiJCQHwlJnRNEgs8euhojE
X-Proofpoint-GUID: EJlnrIBWSkiiJCQHwlJnRNEgs8euhojE

On 25/01/24 6:39 pm, Borislav Petkov wrote:
> On Tue, Nov 28, 2023 at 10:30:35AM -0800, Harshit Mogalapalli wrote:
>> In edac_device_register_sysfs_main_kobj(), when dev_root is NULL,
> 
Thanks for checking this.

> When is dev_root NULL?
> 
> A real use case or this is just from code staring?
>
This is based on static analysis, not real testing.

>> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
>> index 010c26be5846..4cac14cbdb60 100644
>> --- a/drivers/edac/edac_device_sysfs.c
>> +++ b/drivers/edac/edac_device_sysfs.c
>> @@ -253,11 +253,13 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>>   
>>   	/* register */
>>   	dev_root = bus_get_dev_root(edac_subsys);
>> -	if (dev_root) {
>> -		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
>> -					   &dev_root->kobj, "%s", edac_dev->name);
> 
> What cb4a0bec0bb9 did looks wrong. That if (err) check should be inside
> the if (dev_root).
> 
> IOW, that function's error checking needs balancing. Something like
> this below.
> 
> And looking at the other one, it has the same issue...
> 
> ---
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 237a542e045a..3476ef13e681 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -228,8 +228,8 @@ static struct kobj_type ktype_device_ctrl = {
>    */
>   int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   {
> -	struct device *dev_root;
>   	const struct bus_type *edac_subsys;
> +	struct device *dev_root;
>   	int err = -ENODEV;
>   
>   	edac_dbg(1, "\n");
> @@ -243,26 +243,26 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   	/* Init the devices's kobject */
>   	memset(&edac_dev->kobj, 0, sizeof(struct kobject));
>   
> -	/* Record which module 'owns' this control structure
> -	 * and bump the ref count of the module
> +	/*
> +	 * Record which module 'owns' this control structure and bump
> +	 * the ref count of the module
>   	 */
>   	edac_dev->owner = THIS_MODULE;
>   
>   	if (!try_module_get(edac_dev->owner))
>   		goto err_out;
>   
> -	/* register */
>   	dev_root = bus_get_dev_root(edac_subsys);
> -	if (dev_root) {
> -		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> -					   &dev_root->kobj, "%s", edac_dev->name);
> -		put_device(dev_root);
> -	}
> +	if (!dev_root)
> +		goto err_module;
> +
> +	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> +				   &dev_root->kobj, "%s", edac_dev->name);
>   	if (err) {
> -		edac_dbg(1, "Failed to register '.../edac/%s'\n",
> -			 edac_dev->name);
> +		edac_dbg(1, "Failed to register '.../edac/%s'\n", edac_dev->name);
>   		goto err_kobj_reg;
>   	}
> +
>   	kobject_uevent(&edac_dev->kobj, KOBJ_ADD);
>   
>   	/* At this point, to 'free' the control struct,
> @@ -273,9 +273,11 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   
>   	return 0;
>   
> -	/* Error exit stack */
>   err_kobj_reg:
>   	kobject_put(&edac_dev->kobj);
> +	put_device(dev_root);

In this diff, put_device(dev_root) is not called on the success path. I 
checked couple of other callers of bus_get_dev_root() and they call 
put_device(dev_root) after using dev_root. I think we need to have 
put_device() on the success path as well.

> +
> +err_module:
>   	module_put(edac_dev->owner);
>

An alternate diff could be:

diff --git a/drivers/edac/edac_device_sysfs.c 
b/drivers/edac/edac_device_sysfs.c
index 237a542e045a..0c8e66e40af8 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -275,7 +275,8 @@ int edac_device_register_sysfs_main_kobj(struct 
edac_device_ctl_info *edac_dev)

         /* Error exit stack */
  err_kobj_reg:
-       kobject_put(&edac_dev->kobj);
+       if(dev_root)
+               kobject_put(&edac_dev->kobj);
         module_put(edac_dev->owner);

  err_out:

Thanks,
Harshit


>   err_out:
> 


