Return-Path: <linux-kernel+bounces-46160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157A843B62
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F521C243EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD6169947;
	Wed, 31 Jan 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1QgxdLz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kJ+wMncq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845E569944;
	Wed, 31 Jan 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694401; cv=fail; b=unl6eP/8Qu2vzS8o2AVGr/Lyn4kVOIvJwdkMGMbOXoWL23Ytdk95K011ZsXP+MAFF2VSiv6PvdRrB4mlWWkOOVvVDZx+ayhan4nz96Y/Pd6h2HEDo/0ykSioULoBc9J77xYSfEjaIE70W72KxZ2yR6MMQK6/4fTkD2ygGUM4hTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694401; c=relaxed/simple;
	bh=lFd7V3AdRUPewQ1wxcD63/8LX7/aE5cMvawMepiQZWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dbjxYwt4sIJT/q9SAFdD5K3yS7VVuhyZNTxmoFhpYz4wiXBK1rPmM0nYoDKeFkSH6Zj8A5yGsllWqJgQoLJKWodUDVZYgNaATeAk6HQKtE1o+dJFYuSbc8QYp09rIFO0Gzlfy//rVgLEuUNQG5zb/91nrraoQjJGZRd0knvTJi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a1QgxdLz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kJ+wMncq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V9iYFj024630;
	Wed, 31 Jan 2024 09:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=oIHn34vEfCRNh74rn02cw4PboQ+xhTVpQDdVuFtw11M=;
 b=a1QgxdLzRGAvA5+1VX8l3zemZR/OAAXcpyfZ/g9yisdxiMzul+ihQ8usj7PjF5Uq1NzU
 j7IdZKPOK6cUbVPPFqyIlGFMjZ1NLLfVxjR+iiJsUigX42fT8PxEwLPpnHT7Troskq2M
 HIBA4//P+OuviVMLVqqptzxZ6o9fZfKWvRAs6jOTwxPdeopgL0NvxMWBOMPWXER4H65E
 UG4h7WI1u8WyCTFJpNzYyqZh5Vas8Tem+LfTcUzRjgNW5XIaI46ruadWYXGHt+RNnvCp
 uQY2VBSe72BsoM8y3JXYnitcRBcrRKsnD1HVTaAV0LehfOAZSzxbHswAumfEwVAlFEKP 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqb1bf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 09:46:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V8ifO3014737;
	Wed, 31 Jan 2024 09:46:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ethx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 09:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSoLw0hZ3n1U27NPYVtWq+zC6S6OmycXrjK2KU8UU6vfvlAfRliSfGLDO2nqJmBLYLQCpU2Q5ZGKBA8xe30JDinWkQr6go1abgW7LbmjafUFhgapGMgTR02oNieXZfbKhmlvEm8V5B+fXh0lu/hnJuK+jrn3nlDAYXTXmIeDbPHWuxnDD7VWySq3y4hYDpR3gXsoEZY4zrRSs9XprVaHGLrTcif0AHfJTUB2vMomdcc+O7WCv9SJm7erqFzDEYfvi7dTmsqDfnsaRVHn4RTqMaRL+OL84kutBOsMvVSW0zgq5cLtlnhXM/mR7QW9wyOZpqr3UUwQvaztRLYwLZvgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIHn34vEfCRNh74rn02cw4PboQ+xhTVpQDdVuFtw11M=;
 b=F47FZK7S3TCGCUrP7YN5wmb3/JnIRoPcSYV2nk1flpZqh83de384SLdU90t9pDlohT6R5TU3I3WLh1eiNzeXg0SSYeSOwVBiAkYZqQ545vjVe9zIQwHdrh56Z1Djs0WffCmnOANwky8K6TNNKEdhXAL5LN/BR0F9xk8PakOD0T1i7mBmQy5OUXw9pnDPjxC9BQLkXTKc/EV7FCh5magpAfQ9WbBUiAVHCT8EgfmcZQuMYyrq+GqIjTeqADAnfx+p9PijgvGtrOxTFRhUjjJuJOVj4G8UpnQ/KRjNTFkFh4Z6qpSI+6QyYbPafGZ4OGUSNJf1mN0l8FCXmBf0AzzMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIHn34vEfCRNh74rn02cw4PboQ+xhTVpQDdVuFtw11M=;
 b=kJ+wMncqQ7vTJpT9PXohgbd7j1Dex+mb3DQF6KmeQd/VkKziEzDOvmNaCGVkByNM40KwblnxI6cAVkTdLDXxj6qyRPKsn3idlBSBP4UhhroZjRmQJjWe3jz5TH203zDo76ZpRtXebqmYQaKzW7Lbz++DChshUPDjNw4ymYtOqtc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6566.namprd10.prod.outlook.com (2603:10b6:806:2bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Wed, 31 Jan
 2024 09:46:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 09:46:10 +0000
Message-ID: <dd69cee0-ac14-4e20-9255-367240b1dbc8@oracle.com>
Date: Wed, 31 Jan 2024 09:46:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] perf vendor events arm64:: Add i.MX95 DDR
 Performane Monitor metrics
To: Xu Yang <xu.yang_2@nxp.com>, Frank.li@nxp.com, will@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
        irogers@google.com
Cc: linux-imx@nxp.com, mike.leach@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        imx@lists.linux.dev
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
 <20240131055811.3035741-6-xu.yang_2@nxp.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240131055811.3035741-6-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6566:EE_
X-MS-Office365-Filtering-Correlation-Id: e389514c-7a09-4267-f2fe-08dc2241744c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CsN139oEuGVT1xVJbxLlEJ2kCD2stu6pY6U4GWlXTke7NHsxDDqMRorHTiqfbQaJRgbUUmkLc978f15nDPctRO3nXIh1zapmiILPwTIFeNnxpOAzelvFGlEAcWOnzJXPCSnNvUb8Ui9UzOEsibjFSjiqOxwydBBby0S1sN1tzUTJLEcevk3sh3MqQ1zI9UaZjLNlfsjjH05J9Fz2Jb4pmcqe3HC7IxbWaThcBwheRC9OFOj60ap9oDOIFGRh5QqNwpLIbDxrDu2HIuyWeWUK9DB0EtQHkCAfdfq/wDGIv3APDQ30TJcUldu06mA+IlEd9ta0bgBhlyTdSZPCLThczaqSx4ZagmNQ16UhU4ogPgD4L515AanErca/MnD81DBTyi8JLhN/OJuJoDGQFdr9AtckGBaHzMwrt/4GYU2QsPIlE8u/qpMj46XIIcFu6brLHyIzVFQtuGD1GFmp1nP7+AMboGCZJQrD8dheIfg9Z1PO8xQ2LRas0nno4jvE7tMWNuzc7czXbx+dken98Hc/qt6oZuCOQY9dloZ4MqyoIG+021z1jvow02rif702yOobeHrqZI1igrgV6TdFdxvCOgjwaQwvALBZCwx7NpiVxXbNi+wGij7tJe7TVyILdOE9XnLpliYLD0GqPKCgqFJxGqGpTYIDLGxZc0tkMfwJB9A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(41300700001)(921011)(36756003)(558084003)(31696002)(86362001)(6512007)(26005)(38100700002)(2616005)(6506007)(6486002)(36916002)(53546011)(478600001)(2906002)(316002)(6666004)(66946007)(66556008)(66476007)(4326008)(8936002)(8676002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VjM0c25MbG1hVWdLaHFFMkZrUml1OWYrK3dMQXpqWmlDeE5DeEJ3Wlh6bGwy?=
 =?utf-8?B?ZG1yUWJETUFlaWNCaS9wajROQ3RQQnNFQUFQbkVmZmU1UXg4eUd6ZTRNbThi?=
 =?utf-8?B?TnJBSG9OMTUvQWlwemhnYTBlaTNMbjUwRWVpLzlsaXZIWXM3dCtaTUE1OEp4?=
 =?utf-8?B?SUFIcWN0U2d2a29oVXRROCt2RHVhY0xGUGh0VCtJWno4V3FqRlM1bnhGQk9Y?=
 =?utf-8?B?cW5HL2xoMEt4TG16d1kzQU1HTG9MOVNhTmdTbmNPY3k1aUZRU1Y1VlVvT2p3?=
 =?utf-8?B?UVVlb0ZoazE3L0dGWVVJVi80eXdBYmhIeExyYXNiTk5yMktJL2l1VmNkRVFC?=
 =?utf-8?B?ZXd2NUpQTVA5NWJGMERkME1sczAyZzRhZEp4WWtsTnBRa3I2eUMxQkxHMXFN?=
 =?utf-8?B?clRQOEU4blJIVmJYVFBiU25KK2Zya2ZVVVBFZXlCZHQ1RXBZTXEycnBxZ0lT?=
 =?utf-8?B?RnNJS0R3YWhoanB4bUt3RkdQYUNGcHpadnJ3Z2V6Wk9LUFM4dnRQTFBYOFZz?=
 =?utf-8?B?aDJ5QUg0SURBajFSdXlPT0VmOTI1YWlyYVlHUUowZ256NUN0ekM5U055ZmtY?=
 =?utf-8?B?ZU1BZDlpUmhSSjg2VVgzS0lhTkZma2c2RnBjbkt6YVpjc1pmeTBNZE5hMGxw?=
 =?utf-8?B?OGlPdk9tUmNLSkEzSkpqNnNrM29veisrTUFubWRMTXA0QURaeDFNOGg0WTFn?=
 =?utf-8?B?K0ZzTjJlTW5Gd2hnRVdCUG9QZHZIQlRjVThtVHBMVlpDSkhaa1RBWWVjVFR6?=
 =?utf-8?B?TEE1bVhXQlludjd3ajlQQjM1UFdaaWQyeGxJSkZualRDOTVxY1B2TkozTjMv?=
 =?utf-8?B?QlVSY0ZnS1BpZzFqdG03QVlZRHV5c2pOOC9CSitRNDJFbnZOS2VuZXJwdDJh?=
 =?utf-8?B?eXJHTUlKWVoyaG1MQTYyV3EwK0ZsV3AxN3BZdW9pTFgyWlozTnpTcXhVc0ta?=
 =?utf-8?B?b3lubFpaREFUWmhCNVNxa0c0NFFsTzVGZWJ5OGlLOXhTekZDYUJBcmpWODFk?=
 =?utf-8?B?b3NyR3BUVnZhZWdFVFNzRmJBOG5OaTVXQ3gvcFNwKzBmK25QcDZtS1FxcUlP?=
 =?utf-8?B?K2I2QUJ5L0ZFVElrTzZ4allPMkdXSG9yNURLek5ienl6UWJUNGxYRXloZ3I5?=
 =?utf-8?B?aFFraEE0RFNBRFF3c25CUHFId3MycHVua0IwRlJxSWhSSjZWM3FraVBZSXFY?=
 =?utf-8?B?RUpINFpMYW1Nei9wWFlTVVd5SzhYZVl3TXlJem5RaUxqYTBKS1c0ay8rSmo5?=
 =?utf-8?B?UkxTUTFRSkpFZnNmTTBNRm9nZGljMmxINE5pdmVRYkhuYzZIaEJCTllMdVlj?=
 =?utf-8?B?VHhiU0Q0T1ZEZmJjMnIrdmV2R29QdTJTbUJWU0FRMW1hcXpmcHZSVFA2RXlW?=
 =?utf-8?B?cVBGV1V0cHZQUDdaSThib0s5Q3dldS9LVGNsNS9KOVVLbVpyVHhMRE44ZlFv?=
 =?utf-8?B?MU1oNW1mQ3hTUm44bVF5T3VrWHZwYjJ0aldWRk9WS1ljOEN0TW16MWtpM0d0?=
 =?utf-8?B?akhJVmp0Q0EyTEVnR2laNlZwTXRyWmlZUGhkbmRWWkMwSTNFM3lQakVtMzBG?=
 =?utf-8?B?OVBmMURRa1pqcWxNejJxdVNkdXRyc0YwdUttc1Q3V2x2bEJIdVl1WjFaL2lH?=
 =?utf-8?B?TEJoWFRrVXFwajRUc1pDOThjREQ3K3kydktOVWJMckY2VTk0c0oxbzNUcUI1?=
 =?utf-8?B?T2FTcktCU0YyT0pXU01qTjVRZzRHdE5KbkZFNktuMXhOWE9YYVcxUGkwWEw1?=
 =?utf-8?B?cDN3c3pXeGJOaW9oTExrYTRsL1gvTmpnU0JVaDRKL3NuVmhHL0x0ZnRJYUND?=
 =?utf-8?B?NmVQNWdHTXpuT0JodEtEKzFFanFXRDhkakREblVQNVFVbk1FQ0ZzTTZvNXhE?=
 =?utf-8?B?V0NVMTF5UzA1TllWUUxLLzBEcHJ5OGtHK1BQVXRwaGxDSGovb0cyRkxYTnVl?=
 =?utf-8?B?YTFvSGRsM1I2aTFxQzdsVHI2bE1KN3k4S2xDSTh3VTNsTGp4NUVHNTV3c0Nq?=
 =?utf-8?B?NlpqQjRHdnVSTWNPTFdhVWNVdHgwWVdwQ0QyZW5oWXJrRWdPM0RBckxKSlU1?=
 =?utf-8?B?Wk1NRUs1ZlI5MWtOZUZhbGx1QXl6U25nYkNlVmlBWnZ4cFZ0SU4vcFJkdmM5?=
 =?utf-8?Q?sD84l8M7nW3Ysu+D8XFW+PKXt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W5m9aLm+2XT1f566Q3vbzyXf7uIdWAA0T6RhlGR2j2K/jgR1x+xnVAcx4c9y4RoNQxXRh6op1Fx/m1zu0NXvbVOq8JLNNTONqNLSu121h51JcWQOhoV4Zr5+AclNaMMX3oiKvZOAs3GnU6yMxUU9bdVXCyECayshq637oOPczEJcKIy092hGRACeAzRZkat4dxwdoJXKKJU2jXpgVFxtmHCe9/cEWsYW+qsOOSBmWc+VUBTkVIRsQMP3HzZ1xUfJj5RReaDqFtRf4lfH4WQ3VtPGMpIlcRQR+HqNo5FHCq6GYIF7lBr4ogS+n9jqw4x4nGPZ/GmmoXvHT9cMlM14mNH4D48kekw4jw/s9j0ldfs3/3yJx5kcm/DB0t7EhVnomr408wPO9d2cPy+q5ABtj5UaJRJKHPrxAJFKjnY15mvlwAQ9LL9jjqN5N4hEaACtxdziiCx3smV+Ie+w2YdN9wGQrR/Aa3Bu4JtQIByt/6niy485qYiuAnJI6BAErbPE0ooyPxdUZaV4TNzoWZtmNO0ml8+i8mhzn0aPoj8sALrgXQNcBVQxgODWewJXzm+xrLngTtLD3OrepPuq/HGa5rz0ea7EaiQaJ9y5qNdJ5ic=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e389514c-7a09-4267-f2fe-08dc2241744c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 09:46:10.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OaLQklqwzEiQGHMNyJ2p56wkhD75IdgDUrrqWKPp1SUZo6Q2HcXr2XpjqRjb4Vz0/PFGUdf0VC0TYgULnqUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_03,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310074
X-Proofpoint-GUID: k6B91oDZaDM3bf31F21kmFA5H6DUgwOi
X-Proofpoint-ORIG-GUID: k6B91oDZaDM3bf31F21kmFA5H6DUgwOi

On 31/01/2024 05:58, Xu Yang wrote:
> Add JSON metrics for i.MX95 DDR Performane Monitor.
> 
> Reviewed-by: Ian Rogers<irogers@google.com>
> Reviewed-by: Frank Li<Frank.Li@nxp.com>
> Signed-off-by: Xu Yang<xu.yang_2@nxp.com>
> 
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>

