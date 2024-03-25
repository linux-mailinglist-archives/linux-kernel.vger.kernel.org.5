Return-Path: <linux-kernel+bounces-116469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C206F889EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FA51C354D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA33F16A1E1;
	Mon, 25 Mar 2024 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PC5ZEPIX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ck4CaIJV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193114AD17;
	Mon, 25 Mar 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345965; cv=fail; b=YCjErYJmGFaswTA/bi9EhdgMWFEm/youKBmns6QtSBAxEd2+VwHMAFHjSXtvbSZQUWax8QEVMLvERgwiXAc9CJScC5RGmJrHoPXKPsiDlxWBiB92H29M/FjWdw5OpjrK2nlpCavk6k0Z2HbMgYNhCbLJl8ibU8g1szfm0Z0kD/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345965; c=relaxed/simple;
	bh=Je4aN3cjml0i5XA54f66fU49Pg/S5qh6btPb7foeroY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOVBLIraBmUIu2PsbEmGFt4Tqg7AYvM6uXtfMwSnb2/+6Nx8svtLdd/eacikhrC/q11FsxmDNSFyAd4olEks+yTmsmcOOj8qhjYLvryEz3w5WmqhEdw+J0ZHpVECuOXKcNdBjBz3zLL1SKyBs0bsFilFL6Y6+SZZJMJxSosKZtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PC5ZEPIX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ck4CaIJV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ONStOj020488;
	Mon, 25 Mar 2024 05:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=zifT4UNT/e3ZhL4es02ayhCfPVrB4c1pOCy0ZgOGvt0=;
 b=PC5ZEPIX5/0/cE8CWQX+Pg01EpqOmDA0H1A0JAYg0BXIY2XlDPDfSDdXXouDC3V0dgs6
 1GV+O8RtYT4TNlAHfITzC+OORccXTW305oZ95lZz6dDVUkf1QbEXya2TONHIRiUlwGsX
 q+XYOG9u4O/AXB+GTdKccCOCz17S8zbPupTRW3gStxe2jR1yM/DOtvi4zun4K03KdhrD
 D1disuQbrLOfrGkSHlYHv/Abfdqwzq+J7BT9Hb5jiwc2Cl980TA/PR+ObJFjX4BL4cyw
 OmmN2VKVGnI9xYhOHupi5E4DGQtU67Vwd0BgUgp95f1AlgsFTzsbf4YaAaWMySBL7l0b zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct16v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:52:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42P5XBRq011219;
	Mon, 25 Mar 2024 05:52:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh522s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 05:52:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckA7liKxXR3GVc5BJ4ugm9OrQ2GyP97qzqj+PdC4RYVmPcydaWL/UOZi0Z4VeAv0EtdIGPMfZIitl7bha/Y2IT8EAa2Jb7kxrnL5L9R8PrNAwtqPRtCXxOHJEey+vjXCI+PzNFSNcQZ9Mbgy8l8BtFNW5AIIS+Q20wL+VCQjWGt+mJ3Ja0d1KV3it5cIpQv9tRzMdx2LonGCpdfdZnX0vWCQyI3JqJplVbZAiarb9WzcM6WEGbi/HZvaLi3YEpJh7H7dc2HoEGNG1o344p9tv7U2DaJlpxOyYCU6B/3ONbttbQO9jVumG6DZoCU6iI2ojz2zoCWHfH3jiDP83AhyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zifT4UNT/e3ZhL4es02ayhCfPVrB4c1pOCy0ZgOGvt0=;
 b=cZi7XiujrGjsB8Fwkc0EdVTcquN9+xuSujAIY+uBAL3mRlrBhPb4pvNAmVwe/Fp2C6KqQnVM7P3ngYSoK51ONCqg4JfkqPJzZ5TweCF6lCDj8zEp8Jo9WheqG5SsZ2ZiLDm/CunNWyLojafcGRqX6odHlOqZgfq7GxpPvQT4C0p2NfOMyU3LDl46Bhex7iAyQrouWKcXkBIN/cZZcRKoh5cABMSkqIK+WeK0Rocp/QxIFrS4Vbh2Fm4Y+FFNZqWmKtdEz9JpLMnvxCeyNqvZPpH0SJkCdUq1RwkNo2Udw5zD0p9MjFqaJC0OGMIsbXrXCiKgAn2piLWTXgu8GMursA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zifT4UNT/e3ZhL4es02ayhCfPVrB4c1pOCy0ZgOGvt0=;
 b=ck4CaIJVPNrJtwh7WV9WqafUem2/FK0IdVcX/nMPx+cEBjEN7GzTlki7XaZIniq/Z0dyP2SZaki/7U5eU43fsQ5cj/1vCoPCEmXnDxhXXmv7QVeYaLZDYHsN7dU5ZBv5VKgLhkXiiS5u9VRp27WYIQ1+VO3OI5bvw/sWcD364zA=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MN6PR10MB7541.namprd10.prod.outlook.com (2603:10b6:208:46e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 05:52:17 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f5ee:d47b:69b8:2e89%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:52:16 +0000
Message-ID: <c3ae9179-704f-4d08-9a74-031ccc464959@oracle.com>
Date: Mon, 25 Mar 2024 11:22:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/317] 5.15.153-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com,
        pavel@denx.de, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240324233458.1352854-1-sashal@kernel.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0098.jpnprd01.prod.outlook.com
 (2603:1096:405:4::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MN6PR10MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 080a323e-3038-44cd-aba9-08dc4c8fba09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XWcg83w3wlzo6pLIM27jcRqS6MCPJ037b/7QvEajDPF17zP3KVTXP9F/O1Dllk526bO7mbwS4IWPMUPdhjjWQQCFTpZ9GnytqzmdG9RIMii6L9XfuTjVInj54miLDPB9Ff8Fm+2oZIt10pass2V55UOTuFD198hTgrJ/ecZD68Qwag2Vf5L4PshEMq0RiQMFOTzcGxBorEz0lblcv+V4B5e2fsPy4l8om/nml+PF4x6quz2/O/x5QItFENwaBt7qNOj7++dDTkVZCFShB2I2eIRzVtEpDPwgSvvqFKEV7XZGZP4xFl/BT90mQ2kaLVhjJi7W93wU1c9SqU5hVAh4ilgp3eQOMIN3SPeg/W0TgNgU4A13JB+wsCZAJJaXzEpLzwpBIA3C+3ibwg0EBtV4Rj8zeu/9OUFpfkZ+EU/kr2Gs5pCWtcBrKJKs2uP7dcFPJ+8HF9ovdN+XlmwSdAoAdJgNQl1E3by0MGNYiXlz++91nMC6uhmtWJU6PDC5W27ezDgBC29WJMz/jfRNVVa32YMBEnLPwc1fX9Lr55dKyZqqUONGnp+JwlUDER46rYJ8R2RyOUb/25BSpoeD8TNur4t9WwgsMKmp/9GVzwWyj4c=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkJYa0w5S2ZCbStpd2FLcmFId05ObGU0RFdhUlprR1VFcmtMMTU5bWg2K3dm?=
 =?utf-8?B?YWFKVVpmSm81U2FBN3A3akgzcUJiWEhHUUZzQTkyQkhvV2lMVGc0Q3FZZG1w?=
 =?utf-8?B?K0szMmVYVU96TmpLNGk4cmhUdy9XKzMwU2x5RmxpRjIvWkhuWTdtUVIzVXNL?=
 =?utf-8?B?SnFVTnNrTXlDVFZ0MC9oeWMxQ0l1SjM5MzRiTDBDbzBiOVU2ZnJOZGc2OFdj?=
 =?utf-8?B?NWYzTU5kTDRFMjlQTHN6Wi9IelhzR1ArQnI4NHJmNE83OHdyNTJYOHE3OVI4?=
 =?utf-8?B?NnJNRG9YVnIwWmtuR3A4OHdXQXBPUVIxZmxrVDdIbkFPRTIvUEx3WHRUZ1Iv?=
 =?utf-8?B?VFFVTEtnN0tiTjJoWFRCUjZRcHBmNDYxWHBTRCtsei94aFRIOWdXcUdNekZD?=
 =?utf-8?B?WTVveUVjOHhVZWtBazh3d2J1eWhvL3J3dGlYc0xCa2ZaUkw4cVp3RzdwckRK?=
 =?utf-8?B?MUFLMGpPRmNGRnkzKy9LbHcrdTI1Z2FZM1YwNHVrczRaN1VScCtNZytSVkVx?=
 =?utf-8?B?LzJ3UEFNQndYbFMwNy8vUHIvbzUyWmw2d1hXLzZXc1IyQzZFVVRNNGR4eGFo?=
 =?utf-8?B?NXF6VGVBTzloYVA0NC91VGZSTldxVHRXRjVaSzc3U3pYUzZiOVp0VHd6dFFI?=
 =?utf-8?B?K2w4eGdJalBkUUduWEcyeDVkMzh5U1ZyTklxRUJmUjVVZnArK2NWbkRUUlBR?=
 =?utf-8?B?MEQvTlJITTYwMTJ2ZEp5QXN2VUk2VnZBTUJpejJxN3lmQ0IwdzBRelpZNWh0?=
 =?utf-8?B?ZnV0d3pVZFF1MU82SVZ5RjgzN3dUL3ZpMlhPWmsyRzY0Z0twaEtYZWhheENr?=
 =?utf-8?B?NVZNR20xbldjSGJnd2t1OWo0U1B6ZnBOSC8ySFdZd0lJcWV0cjRaNFVNc2pV?=
 =?utf-8?B?Z09SaG52dU9ES1RSK2F3cWoyVUtSRkN3blp4UHF1eEtFTEFyWVAyUjRiZDFN?=
 =?utf-8?B?RDNvTkVDd0d6MFZ1K0d6WlQ5dVcwMDNBdi9UNzhtenMxZ0RPMFBhQ2swZjU1?=
 =?utf-8?B?dUtqVFZ0Z2xFelVEZDFKWWFIVXVZNTNYY3RSdWd0K1RjNmdNeFh4RGNHZGRV?=
 =?utf-8?B?OFMzSGdHdWpaVnFKakIrVlo5bE15L1d4Q2tyWTVOSHdiak9GTlhZaldDdUl1?=
 =?utf-8?B?UjNTZXFsYlJzM3E2Tm13ZlBPdFJtdUdqMEJ4TWI5UWg3NTJvV3FoRXUzMWE1?=
 =?utf-8?B?cjJmWHVPVnFaYVNpc3hCTmwrbm9QT3JweENBdGw2NjY2bDlHalNoQkc2dEEr?=
 =?utf-8?B?aUJwT2FwWUIxUEtpWlBJNUl4ekRKRE04bDVqVHhxdWxJOW5rVitiLzlseGpD?=
 =?utf-8?B?dVdidmZRYjZNL3Y0ZlVCc3N1T1g3Y2F0d1A1aWt1SS9vNFB3TXJ1SDRxNHZk?=
 =?utf-8?B?bWJQeE5aa3llQjNmbW1sRVRxWEx4N3ZPK1M2K2E2bjlCd3lheGM3dnFuQTFX?=
 =?utf-8?B?Q1hTOHhXZVNHd1haSFE2emhHWjZuR1F1SXJZOVlWOVFFcTI5WmVaaHlaZ2hp?=
 =?utf-8?B?OWt6Z053Uk52emozNlU3TGF1c25PbC9oMnFoamtmWG03aTllTmxTSm1yMVJR?=
 =?utf-8?B?VHJ1dkQ0bDFnUWExVlBCd1k5cUFDcVQvZHVaYzcwK2hmSTVhMEpXcE4xLyty?=
 =?utf-8?B?cjRNYmw2U0tDWU0xU3h3dGxjdVoramtnVTg3Z0tSOU9KZk5xYXRMVGZVRlpo?=
 =?utf-8?B?TE9iQ1pDamhIQWw2UFdIYUxCeTFjcU1JZ3R0RjFRWkZldjZWd1FQbkxkajJH?=
 =?utf-8?B?ODVIZUM1NElJbXNRL3FlaGtublYxTnJvc1phU1JYTXZzM0ppSUQvU0E3Y3pK?=
 =?utf-8?B?WDdia0ZSVmp6NHRnckdOZHlNdXd5M3pUeVduYnJMVWxleXRtTEhWOWE1Yy9o?=
 =?utf-8?B?TCtkYld0SER2bnRXcWl6OGNPUEpTSmVVc1l4YjhPbk9PS0VrTzVpM1hFWktF?=
 =?utf-8?B?S1FoaTd6VkZuWGMybnNid1F5dVEyTVBFSkxiSDZldjZzakhsbGlaSDdXRHpz?=
 =?utf-8?B?U1VWV3JYcnh0c2oxN0FYcWY5YkN2RVdrL3A5eXMzSURPck5PZWtyVldSUDVw?=
 =?utf-8?B?RlhCTEVieUN3eGNwNG5qQXowcVVGSzlveDlWMTdTQWtoNjVyZXE0OVhLSEdi?=
 =?utf-8?B?ZHQwbGlBQnlXUDBsclU5aVRic0hkWGdMa21Fd2lWSWw0RUM1Z2JGLzNuSVVF?=
 =?utf-8?Q?NpmQj4qRJe3n36V8+sskp7I=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bis/bdGJ2ocaVmrPa16qgr/lZ378si0cBnMGR4Gqu+C8ji3J8R6HdhTYyQzG+hnYvpsvhup6jhMPzG7FOOSTzO2C2A9olcEV0LwgohW8u9m4Nci8Afb3N6uzND5/Xd5fshh91/oXEUwihfUjH67bE/9u/+kquFTJLEoO58lVWgChMs+9P0OqWMMtYD0hC1ortNDd8mxceQjzkWeZ9KZ0Hs51Iz/LXUF3H5DTdIKATCVZOnE4mJmFpvm7f5SX8qi0yh+NKwAu36yWh8eMAfpXSfJp87jSWGCxVMjyyD3ft2UgC7QhnJwHcfYnoap5EHOBRtFRuLbig4mxOfkWlfopHAtx6hKhkXhmVNgNGi5WzzkvJ3Qb3Qk5iuhUuilL0EWR9BCtoAiHsTKFno8/iRoZfMHjahavZy+Pf/zNHqJxZDKYjZSWkzMpNnCgNo8ab7IWsdrCac0qSV3vOV+jJbEmdinh+4WM1eXsB1djJ3gGzvQsNMKB6WPIJPHB+OMjchsxq3W6vPUR9tEEbKTJqKQ6TZkhLj+zKwFE+MKe7xVqX4BU5/0qQDQUuoo9PRu9N9kJBojWN3QTcECQ8/9ObKulnLTuT7TjM7XHP3ZqGccf1/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080a323e-3038-44cd-aba9-08dc4c8fba09
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 05:52:16.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWGQruqG5HjCkLZCW6R3M9p87qJBFrBhMzcleqml5vEMRSBS9wYojQP2C3u5WXcDScbrfLKX+oKbbAXLghRwAwBIO2WohAMXEHAJ7xpKn6W4YLO2+99kZxQYJiiVmAKC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_03,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250030
X-Proofpoint-GUID: mu-AaemDq6U83KvhuByy9GJh6S4_NPR9
X-Proofpoint-ORIG-GUID: mu-AaemDq6U83KvhuByy9GJh6S4_NPR9

Hi Sasha,


On 25/03/24 04:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Mar 26 11:34:43 PM UTC 2024.
> Anything received after that time might be too late.
>

We have a build failure in  5.15.153:
libbpf.c:74:12: error: 'map_set_def_max_entries' used but never defined 
[-Werror]
    74 | static int map_set_def_max_entries(struct bpf_map *map);
       |            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

this function is not defined in 5.15.153



$ git grep "map_set_def_max_entries"
tools/lib/bpf/libbpf.c:static int map_set_def_max_entries(struct bpf_map 
*map);
tools/lib/bpf/libbpf.c:                 err = 
map_set_def_max_entries(map->inner_map);


This is introduced by PATCH: "[PATCH 5.15 067/317] libbpf: Apply 
map_set_def_max_entries() for inner_maps on creation" in this series

This missing function is defined in commit: a4fbfdd7a160 ("libbpf: Fix 
BPF_MAP_TYPE_PERF_EVENT_ARRAY auto-pinning") and pulling this in needs 
some conflict resolution.

So I think for now the best idea is to drop this patch[067/317]


Thanks,
Harshit

> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

