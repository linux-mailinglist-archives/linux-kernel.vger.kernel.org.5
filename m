Return-Path: <linux-kernel+bounces-30852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA5983251C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53B9A1F23D19
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33013241F0;
	Fri, 19 Jan 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="bXMekPVb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2107.outbound.protection.outlook.com [40.107.223.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8823744;
	Fri, 19 Jan 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650148; cv=fail; b=WVnVF0OMI+fh3sIqTXMNoo8BV99nLzZxkTrYLjcU4PWvXB3Nm+CV6ujFaG1dnz5RIlAFelGQvgXoEnXTMqgdx8X66fEw5N5eYGhXUkxwBmsh9s7KAlmT/LPkDb7eh7nn8W3rdBI+HeCZSoH0gphoniXgr9JIFmJcWRHiO7TGdDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650148; c=relaxed/simple;
	bh=8O90lJrmoWkKYxvh6UaV/4D3IUuCp7Q/SfJsNXQVCt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HXQdzz3/POS4KHZ88ocJDMgMPwNJKCw4gRSpqm6jZQTSjBI6CsysV2V2SAr8BHMjnAi+g10sW5VDnEaGsLTDwwQ89k5W7AXN2XVTD9RnXubChmjKpfvlLSB1lniM0ar2NyxIl5wi+zeRRchbWY0T3xV4SATJYHx0MpQM2pvqSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=bXMekPVb reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.223.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7DwmpN7Km7PCYHUNgrD7TCrRxc7507oCfGOD0xTqIJvcBNEQuDgNaBBtbAo9UdUV77m7/PyLTVKrQpwSWeyNlvJTUwJgFtEaqG6hzcxuoFSmWCvp3bFx9VTH+9+mStn6zxy0r41zO39kB1OceH0id7uITnjHkl9bUtopquc4mReezTCirw2bkWyGFgr0KRc5mVDmlXwlHEcDuoJ7ZgmfMnLm3WdfdQp7GqrT68iwp8JBlN3TG2PQn8ju19xtvrtD0oePTPL74TK++dO5gEVa1iuF35WavNkbuq95Xh9poYTJw4x8aDzwVGYSjOlSxPUPpT/icaBwpfSXXU4haFUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjGitqCwTFvgxG5rupwSZQPx81+WwShPcUcfs7dPuC4=;
 b=FFLYgc5bTw9AV5UDy33666I1d+/wfr3fNL/2PRD39myXjvrczYAngiF1vZ/rXBRDWXbOYlGjXK6IQG9W1YZ2yADS7iT2t7//WaH2y/iq6ELl0PUBJf36nKbhXRp+4O86Sv/sQwm01Aro5ufsXYdYG3mn05dysERaTeSpGsotxjEnkIdeBn0rGfTHVMb78I/6lpvmDS1jsY3Ch1Ku0HumjxWyT/O0EhhPn+bcoPCXp2rYXTgxIS6kshbruPfwYa1hcGlqk+bhFBOf+pg43YNR1FcljCAmQ2Kq9STN0ioU1lED+3LGIhJKWgfI1Cjj4uERNQUybxtQ5rAbZqaLVrh2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjGitqCwTFvgxG5rupwSZQPx81+WwShPcUcfs7dPuC4=;
 b=bXMekPVbWiGEgTLEvFvOCMK7Moel7HeRcvzfQlFjn3PpmHjHvMabWZdqEQS0bVQPJSbMQjhV64VTSadORTnMS5Fa7y7yrCRy/8nRHBMBewZXoDl/jgflPP1EOkXPuSoZaQ4Fh7Bf6P38KKDDI/tXK3bLUn07WYAHKvoOSYvpNz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BN0PR01MB7072.prod.exchangelabs.com (2603:10b6:408:16a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Fri, 19 Jan 2024 07:42:23 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a])
 by PH0PR01MB7975.prod.exchangelabs.com ([fe80::91c:92f:45a5:e68a%6]) with
 mapi id 15.20.7202.026; Fri, 19 Jan 2024 07:42:23 +0000
Message-ID: <169d5a71-8204-4773-a13c-940b4190ed37@amperemail.onmicrosoft.com>
Date: Fri, 19 Jan 2024 15:42:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NUMA: Early use of cpu_to_node() returns 0 instead of the
 correct node id
To: Yury Norov <yury.norov@gmail.com>,
 Huang Shijie <shijie@os.amperecomputing.com>
Cc: gregkh@linuxfoundation.org, patches@amperecomputing.com,
 rafael@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, kuba@kernel.org, vschneid@redhat.com,
 mingo@kernel.org, akpm@linux-foundation.org, vbabka@suse.cz,
 rppt@kernel.org, tglx@linutronix.de, jpoimboe@kernel.org,
 ndesaulniers@google.com, mikelley@microsoft.com, mhiramat@kernel.org,
 arnd@arndb.de, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org,
 jiaxun.yang@flygoat.com, linux-mips@vger.kernel.org,
 cl@os.amperecomputing.com
References: <20240119033227.14113-1-shijie@os.amperecomputing.com>
 <Zan9sb0vtSvVvQeA@yury-ThinkPad>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <Zan9sb0vtSvVvQeA@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:610:5a::32) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BN0PR01MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a735ca-7a17-4bc7-d81b-08dc18c22cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PeQBhKhpc3SqDvRRrCTK1NOiW4wZa6N37Pn+bWSoFNJxYblsmPxLaIsGjchCyLXCrrpSZaQtPsV+fDgvA73KtszmWt5pxeYncOFMt5EsgYuYqjSBhnQKxmebNHNkPHtvUr5MhoImruz0HUQFUmADUyM+/A3qPKHGJNI4yHiwu0JKwTns3D0cUwFyRumtZzCbEnQY/vnEKABs/z6F3qhCFws5y3sTeUpzI0Xs5M1wzYEsP/lYH4+ld6/5+74T/G0c4bW9XzleR0LgZ0arUc9fV/eYDj1YL21EuZb8od82/uPWVlZ3s8mI/kZoXeHxqkcocaVMCbkeyegnNjRCBpjVx+9vTmTAlj9ex7KPNaaf7X/3uDULwGq3NiS0Sp142NvcXODs+5v86M1b8z4lgB8jcWUxOiADaOQLOqMXL23pI6N98d1EGAOOKWFE5+ueFYXi98KJK98eb3NyuetBv3RP4hn7coTTuiQHfr4KIyDmArmGnHDuTtN5v5+BzO7ip0KPBXiU32UgBdhBoLwR0l+5mKbThpJur566fDurvd6lB4+bFExPF7074VOkpoDdIT+RSRuPB5P+30pL+U8CTffkpoBhqkQdFnbY/98SG8hG9VhnYTo7EGJ2M1Q9SpXvHtz6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39850400004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66476007)(8936002)(6666004)(8676002)(4744005)(6506007)(42882007)(4326008)(41300700001)(26005)(7416002)(38100700002)(5660300002)(107886003)(2616005)(2906002)(83170400001)(31696002)(6512007)(316002)(6486002)(66556008)(66946007)(110136005)(478600001)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajNZVTdxNm0vem5jSGxsSXNqRmlzd05zc1EyWXI4TkJ5UklSMDJFem9MN1FR?=
 =?utf-8?B?dysrK29PbCtCdkpwVWpIN3N6TzROSWFKRHQ3NC9OY3pwaTVKaXdNemJ6N2Va?=
 =?utf-8?B?QmdyUTlVU0tlZ1FjV2JNUk40ajY4NnVZRDYwdVhZdWJPRnRjZDduempPQTQ0?=
 =?utf-8?B?cUh6amlTN1pIL1pmQUlUM0ZhbU4xVWR0QkpiK010dGxxWCtHQU05VFEzSXBN?=
 =?utf-8?B?ZXg0QmZoYTcvNDJJZGprUldHVVRObmwvcWFvSEdGbDE2R256VjkrVTlIa3Ji?=
 =?utf-8?B?dlZzenVScVRCZmREd1BnM1lGMW5oNGdMeVN2aFJJZUpjT0tMWjZGSHh0UDRM?=
 =?utf-8?B?a09nREhXZG8xSEp2VGg1REdUaU9hbmlnU3FteWxTdmM1bjRVc0x3QkNGSlFC?=
 =?utf-8?B?Q1g0aUpVTEFmR0NlbFYrNCtuaS92M2R2cVRXRmhTUml1WFUzQWUyOHVaTnBq?=
 =?utf-8?B?STdzb2grZkp6eFB2dmZsRG5EeS8rcEo1QkxKYU9OU2xRRzN5aVJVTFg4RlR5?=
 =?utf-8?B?STNPRUFMN1FoTnovQWdUMXR1YktYSUtnWk9IaTVtSG5PTlozVlorL3A1VUFQ?=
 =?utf-8?B?UWxwNUYreDBWSHFZOU84MUNVZXZlVjZSdENsbUcxWmRMbWZuN2YrYTlmdlRJ?=
 =?utf-8?B?Q1VzSGliMGF4RUFCdTR5N2pRdFJaaVNXUGRjQWdKM2cxNVEwSEZRenFjTmZZ?=
 =?utf-8?B?VlhwcE1xMUhkOUhYYUFyNTgrR2wyVUdtYW1rREdyUU9nUmFOQVhDQWR2bXEx?=
 =?utf-8?B?N1hyWmg2eGhxVDJFWjJlL3UrdW1DRFp0Ny9JdnRyTHlRSk8ybkN6dHRnODlu?=
 =?utf-8?B?VWtnMnVoaUdnZm1VVjRwVUs5N1g0Wlp4VGxLSzJjenJCODlCazYyaU1NaDJ5?=
 =?utf-8?B?citUVGtHVTVDTnlwbm52cG1xbWp1TW1qTHFVQ1VtdzI1Nnp2OEhvbEhFYkhp?=
 =?utf-8?B?am0wdVB3czcvenUvVUhzY0ZlSXVHd3BOSmxzVVgvZU9YSzV1NGdVR1JIbnMw?=
 =?utf-8?B?U1Bpbll3NXVUV21RaHFZQVFXZXZmZmhqckpvNE5ML0JNd1dMdFlHdG90N1I5?=
 =?utf-8?B?ZEZuTCt0NXpwQmVSVHFEU3RzRjFzVHJJUDlSWjJtRk1NOG5KcGhUbVRBSGZ0?=
 =?utf-8?B?eGNlemtRenpQZ05KZWlLSHhxaHRndkFmVk5qeUVlNnQybUlBc1M1YzZDYzZp?=
 =?utf-8?B?Qll4YXlqVERralIwTlptY01LQ0czc1RnYlgzZU5ENjFrbDhkcWpWQUM3OXFp?=
 =?utf-8?B?aC9aTFRiVzIyMnRiakRHVDBkeXdMZDJ0STY3cnVhRWpkNXpxb2lnVVBjZy85?=
 =?utf-8?B?c092Y00wZjBMOGRvQVBEZDJiVlJDcEVXU3UvM0RobUYvZURlTysyV2tjR1gz?=
 =?utf-8?B?Y0U1cVBEYmR5MjZwR2ZMR2dqWG9QZTgxQWttdTU1NW5kWDM3SUdaRHk5YjFm?=
 =?utf-8?B?a0toSndZWDN4WDJnbGJIZDY5NHgvTGhRTU5WNkU2MEFNUjJpeUlaN3RjRllB?=
 =?utf-8?B?ZndtazlxZFlKdnBSRm9wdE1zUXpXQzM1T01LNVAvYlpGYWRvN0xiN0g2V3Rq?=
 =?utf-8?B?RldGWFltaUUrRWVXWnZNbHYvNFZ4MGhjdHdsNXBPblozQm1lcFUyQlFETUs5?=
 =?utf-8?B?a3pnYkdWdDNmeHJ5M0dUcWhwOEdNZFgxUHJlK052Z1lFNERyS2I1dDI5MENp?=
 =?utf-8?B?c0hldEZRMDkwUmMwVFErQjFsT0U1emplQW1Od1FMcEloSkdyRkJDN01vUTlp?=
 =?utf-8?B?dlhpaGx3R0o2RTI1U3YzMWg2VTJIeTVOTnpnNjFPRTBOTHBrWGpPUjV3WUl3?=
 =?utf-8?B?Y3IxYXM2MU04WG5vR2dhRW9rMitOV2tDK2crcmxueVR4ckpqTmtXQkdHN0Z6?=
 =?utf-8?B?L0ZmaDUyMUtBK0Z0a1Q1NlBpVzVBOGVaR09uQ3pMeUxOcENHRFNSYUd5VTBR?=
 =?utf-8?B?dnljamRDQlZ4dGtlUXBwUzF3YU96bGdOTG4xeTJMcXVWOXUrMVdVUDhiaGts?=
 =?utf-8?B?UkNsVUI4dHhMTVVSZnR4UDNxblpNNmx5b0tvWW9SYXFkN3ExeDNyRkNHZFFl?=
 =?utf-8?B?M29IVEY1TFNERGg1WU84enNSaGExalNIaDQ5UDNoQzFjeGpYMGVkcHVGeGhv?=
 =?utf-8?B?cVcvUU41NDNOdUdNemVYZU5wWWhsZng3akhtT3pXNG5mRnNHalBKU2l3NzJB?=
 =?utf-8?Q?dTuuqPmPyomlscToe6LyG+Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a735ca-7a17-4bc7-d81b-08dc18c22cab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 07:42:23.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SW+9HThxuhcbDjPCS72fZqCeK1VyHkUczY8SL8uzVy0i5XDWvxW4Mv5tj3oBr+FrF2yuEN1vA70MCM5E8ggR8lYs8gvUHGb2dxUDqZlkgq30ZeR1zvMoItMIcJlp+mhu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7072


在 2024/1/19 12:42, Yury Norov 写道:
> Regardless, I don't think that the approach is correct. As per your
> description, some initialization functions erroneously call
> cpu_to_node() instead of early_cpu_to_node() which exists specifically
> for that case.

I checked the code again.

The sparc, mips and s390 (which support the NUMA) do not support 
early_cpu_to_node().

So we cannot use early_cpu_to_node() for these functions.


Thanks

Huang Shijie


