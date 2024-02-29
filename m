Return-Path: <linux-kernel+bounces-87608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5686D670
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B400285C18
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20E6D52D;
	Thu, 29 Feb 2024 21:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H1cUfyzo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PpDTUJaQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1546D523;
	Thu, 29 Feb 2024 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243738; cv=fail; b=Wl5Mbrb+tWxvNUGgmssTOQnU0W8b117Vzh3pd8fzaw3GJ+r1ZB+RJJ2B+rJYfFMjhGyVV1hQiC+kyTqAgR85T3eyipJofZ9JUPUyLWd+VR/NUA+kBh3h55iWykHSEWaEjQSao2VKSvB2EUh6RSEPHo6v9legHX80Xc3P1VJ9eUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243738; c=relaxed/simple;
	bh=d/JJjtyFP5pvXgI8Ayq7oA4tbSe3LVS+p1e5T9VhWf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HsChq0zVwprckDIN5CAOORpp3cCgfKn1LLYHEPx2p4STRGjf+vfhHDvCD/PGuXeo1/i9CIu373dF0I/pwzH3PzFINojcYSdhPXKSzsp0lE60+oVe4ZI14bmiFe7uSKSTOKtkSUsHkmpLJxMw6iA+gBz8vkT5tDnYe6/kCqFX+Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H1cUfyzo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PpDTUJaQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41TGEZds004408;
	Thu, 29 Feb 2024 21:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kj7aJRBm2Zwx6r/3yoQivsybjFPA3ZesBpJ3UEZuupY=;
 b=H1cUfyzoIndV58OR5SdWZ0PqiXRyalf0b+pgIGyNheKQNjm4HIjzDNeR9MP8dTRkybvd
 wbbk/rw+5cEL2SLnrFPZUCYJ9/jIUH3Z1tD+555aiOcn3QxBHpZYAnIsO56q0Zat7DT5
 pTAP95otuPPNuZ2WLQAzg2xmzUwP3al44I552aiNI7xxBCZ8wmyLstNGd9zjXYU1tq+c
 7CaGhmDQPMubh+sjDiEMZlyCkBptbvXSjgygvpcV7IZskaeRCKdGPswhQr9AmNrRBcRX
 hVva4FohxuR9UZB3BercNc7IQU5B9rs7klfwnooYwesUydtEQ6c2osIgfxCnPduGWRDg jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vexaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 21:55:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41TKYVaM004669;
	Thu, 29 Feb 2024 21:55:22 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wjrq6uwq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 21:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+EIM2yj+ErAb61SmIPXxgG3X8ZwqgZS4mslVQfY4q+XM9JC0HZ7J3icjtc0R98awIaPqn00Z9AkvUQjqF26aLhVmPMioF7jf3Yqor00nwkljHOnHTadNwyD+1lT4JHOROahWJG1Xtfgfz7E7dzwQGDNKbQvIGKH5NI9c/JglL516me6XqYGmxg/+7rgDI2LImObS6RRoGNCUwC2Eaz0V60nSGByor6N9F7Kd8/YU6JXe7UuQFY/9V9/52Yoh9E29nEOtZ+pznoXeuCiccqChyGCJ0TYjTaX6c/W5nAzvByvgr+yKHc24QVj9Bvg+KeBq1iM5sjcVb+cL7Hr1rjuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj7aJRBm2Zwx6r/3yoQivsybjFPA3ZesBpJ3UEZuupY=;
 b=cS9J/owVlB3+uUXQJrH7iebO6lyYXnNnBXzBbXa8yT4nfZLwNPXecKBbNyEfpah+gdVWp8W3XsMP0/xKCF8oaLfcl7OzRfpkNf6TJsDVkuiGwtT7Cb2zeUlfF8NqB1vB+uiufvZoLuMH+GIAH+e+WlmnPUSlIpuCAdsnjImQIUsSTe3XK595akRDJCAw4NpK0TY/4rakugm9YE6emDPPybQAsyNAPLIRgjS6Ml9JNKqbEMJ2FPxPkH8v39IO8tCgh4eEeUDC/pdSmPRQ6Hh6khg5x4PaRKoAFvV9mlEXNuYkfOZAYiSAv644R8Mo/zMyaXtxBu8b28D0lc07P6BHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj7aJRBm2Zwx6r/3yoQivsybjFPA3ZesBpJ3UEZuupY=;
 b=PpDTUJaQWFpuM5Ft2SO2253fAo9zSnApZTuL91xvljBdUxjr40F1BGSj1pL16xI0A+dEr654jYeb12zV2dL1StlXt7Rb6Czze8pYDsps+VkmCt6C0RwZP0hbQZuSWqtoH7alisEf0SR/zsXt86rrJMu+If5E9X9wAt4P/Hgpwcs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SN7PR10MB6595.namprd10.prod.outlook.com (2603:10b6:806:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 21:55:20 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a4ab:7076:36d:a488%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 21:55:20 +0000
Message-ID: <99b7841b-62d4-404e-815b-5eb5cccd2580@oracle.com>
Date: Thu, 29 Feb 2024 22:55:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: new text on bisecting which also covers bug
 validation
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <bf1d2eba0d291ff583e01b5985a0dec248eaf27a.1708072870.git.linux@leemhuis.info>
 <87edd8m7l0.fsf@meer.lwn.net>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <87edd8m7l0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::7) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SN7PR10MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f809070-e07a-43ee-8062-08dc39711f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ThCFOzpXz/xfQnNDwcBdIJW1mncB7FiMmZDqhnuaZPs6twa/UfQKwOG6p7d1QupPgo3tpDGmLf3++nHsfAzePzlA/kPxvLjqXCvkbdLohtsOwGpJuDVdcYOt5k7S2Nn04QzVvPDZx/iApUAXmfdzps6C6WV+vseDDHHDcoMC/uShKjLiEcPcjHfdhkig6LpM8Aivpmp1Cs/iQ7qYPdJW1ddO/LkPb04y9B+ZPnhQRoNVCp2SlmQsc9NglxoCNSG/qF/8MManaUwj8DY2j2KDriDvJqfJV5/HxLrL966qTf6RBPjYc+BE5TPLr7pvf5ze30Q4vmZBp2zVVt+Yz88EdssSuAJePUsFjjRmVB8jfjT1XK5SWEZ7veHs/HduVuywaEENbP7tyew6WrzkowLi8OgLzia1yjKuKE6i1HJ/CnVE0XNJDkzJmL1oQsBfWP1PETnj1oWOc1xwbcl6P04X//l0a7VYylBfwkYD2bouaSDzseVUR1+3w4CJ9lF5oQqrPhtG1tIC6m3esweOFU5qmvbQmzG14ZIWPbH28lk5eUM3grCxcqbo30bRRsX7Hlei2xKn6o1rKiOxUGVqquR8rqJNeInsmWnIKBrCbnuebDqkIRQsSKQbAG6r/cEoOiFSTCCCAc4BGaP6Isq09Cex0Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bE9KazNzdzBCcXcyc0xZZFpnOGFadzJ0aTM4bjYyRG43WDFLUWNCbDgyblZt?=
 =?utf-8?B?bmVOZFNNSDdieUJzTUhPRmxQV215ODZRZ0RnWGUrYUltR0VuM045d05PSGZ3?=
 =?utf-8?B?RzBHRXZIYitxSE1JUmJqLzM4ZjNMR1JBM3lmOWU4ZWU5MHZwRU16RTI3ZzE4?=
 =?utf-8?B?QzFLTEtNNmt6d09xWC9hNDVFS0k1R003RU42ZnNnd0h4QXpYV1YxcGZmNXFw?=
 =?utf-8?B?UGpyUWEwZTdxRWZ1ZGRmSGdPUE15TWI4SjdjWmRMRU5KSDBUZEZIZjVMVFQx?=
 =?utf-8?B?RVRSck1jUlFWUHFKNndPd2tGLzJOb2E4QXJQK1J2MzhHOVNIVDl4SUR3cW5Z?=
 =?utf-8?B?VGo3bmdqblJLdGVTZzY5SUZDUDY2S1VJdFc0YUtYNW1KNWtSMXhnZlVKbWNY?=
 =?utf-8?B?b3ByQ3B3TGFGSStoMlZ2R3BGZENLdzVCT2QwVmZhdEJYWVRKVGJMako1ZmUx?=
 =?utf-8?B?QitmbGdBMFd2MGR4ZjNOeXRVR1FVUzU3b1JWWmJNNmYraHJYdXZXSUd5Y2Fj?=
 =?utf-8?B?eW5MQ3pPallsRlUrRlc4dUlLMWpJQzdkRHpuMmd5NGdrZHVEOG45OURvVDNm?=
 =?utf-8?B?S2tHbWZHTTlVVXZKcmJhL3VYLzBRZHQxY1daNUcxMW1Ha2VxbnFKOUJyUnZQ?=
 =?utf-8?B?YTZZckJlQmNTNTFMcGQwZWlkWkNlcXNjRVpxdUNNV3BNR09jSXB0dWx2VmVj?=
 =?utf-8?B?ZjRlWkJ1N0x5c21kNFhzZTRncEZ4YkdCYlhiNFhwbmxrcCtUbHNGS00vNDF6?=
 =?utf-8?B?K0RZTnpmMFdGNFIzZExGZEJ1RzFUSHVGQ0lzUEJ0bDh2bWZVNjZDZVVOQWUy?=
 =?utf-8?B?ZGFuZVdLYk05aVllQWNqTURVZzJmcEowamR6R0lXM2duSEZhRy9XN09qaEkw?=
 =?utf-8?B?YnJrdnBDeGRJZ0oyamxSdzJYZUZ6N1l4M0tMZk1qdHJGTGpmTGVIYWhkZXpK?=
 =?utf-8?B?ZEpXVjFRYmZsSGVwQjFOTGY5Mm0vVEpMK2J4YkcxbHlVM3F0V0QzUW95RVA1?=
 =?utf-8?B?TU9rVUswZXZWdUN2UkQvY09vQWk2ckhmcXVXMW9VNnlvSjZFb2xoalczWGZ5?=
 =?utf-8?B?L2t4K24rczNFRE0rUEI1K0M5dndqQ1ppOGQ4SzdsNURkNGo1WDViRzNqdE5E?=
 =?utf-8?B?SXUxa05vWHdMVUVFRlFGYjlXaU5FTENZZzFZVklMUnU2b1d6TUhYZURFZG1s?=
 =?utf-8?B?dVFlTUZUbDNCU2Yyb2FwQ2RjL1pJbmNkMGRLQ1FILzkxaWFHYjh6eW9GLzhm?=
 =?utf-8?B?Z3RtMnNpdVJqUG05WTJQakZJZE1UVnViZ25Ibk4rZWFQdUxxVjJmcTYyM0dE?=
 =?utf-8?B?S0VaMXMvMEtzVVRxb3NPNHdZQkZhNVE4QlcwSUNYYk1VelQwMWdpL0gvMW96?=
 =?utf-8?B?NVdkcVhLUU01b0dGK1gxeXdJVWtQbHprbWhNdHMrOEVxQjFYZ3M5MldDMHFk?=
 =?utf-8?B?UUJRUXEvZWs1a3ZhUHNMUmxtVmk1cU10WUk3TnVnUlFOT01Za1RXUktWbGJo?=
 =?utf-8?B?bTVJcmJXUkdJRXJlY1k5M0N0NStHOWdkbVRNcmlHSU9hc2JZQThZQTF0T1B2?=
 =?utf-8?B?cldBTkxaeXAxdkhHcG5nZFVtRCtqeFh6UThqdHpmR05DRXNkeFc0Ty9iakg2?=
 =?utf-8?B?MzlLbXVNNkVqUUtiYXlMNzlaYm40ZjBhU0puWDhLWkxLUGxFZENsZUV1bVF3?=
 =?utf-8?B?SGE2Ry9WYm1VQXJOM005VEpsYlFGbm1XV1RZeEJKZkYxSkd4cW03d3I1UGtC?=
 =?utf-8?B?Ti83MTZBUVVLU0wrZGhsbHZaTFdlc29sWS9XcFJhaXU3Y2ZWTmtqSHJVUllO?=
 =?utf-8?B?VTlLN3dZd3YvMHNSazg3VmRCaWk3ZWJsRWRuM3lGczVTSWJVUXJwQXFEbkRh?=
 =?utf-8?B?VUEydUwwODJVdUlQSlZjNUdxakhJa0J4Q0xLaUI2bFVHNXBTQWJWWEFDTlZv?=
 =?utf-8?B?WmJ0UzJidlRsOGRMUHpUSHhsTnFYV1pjL0tYYThoQnhSWHduWGFSbTBmUndY?=
 =?utf-8?B?VnJXT0dsTUhQWHM2SHNzWFF4aXBWY1RtZUhSZWNQTlhRbS95RFl5NzVNUml6?=
 =?utf-8?B?ZVNUWXRPTk5ncXdsV3VwZnFJN2Z6SVlMOFZUTWFVZTRpbWd4T2dFSUVreDlq?=
 =?utf-8?B?enlSU2JPLzlJVXFSSEdxYzdlVENXUzVaanJ2OTkzTjhWZlFpejB1d1FYeTh4?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OTWawJb3gfMuyUnPhwuvY0osm+3a732H5ms/0e8eeK/F8VvrskL2JZxF1j8Xz7vs505yLNUdN38x5jjHaI8FvislEz4zpgH/lSuoi58Zj6gnCcKUPQHw9zcbqLyFjByFvtmIrOAphZY6b2rUDINZtJWzktqDZljoQT84fy5RjYoP1GeALb2EeHaOP9o89yIdEindCuCj2gb8CaVhBVvs/Y9HrHEbHKdqV81jAaOaUgvUm2sptCWDAENYYmjEavXxFAh2Hn3Dd2bFPd9tS1z+ksoIAmIxXrOR1huxR1k3z+8gzdWlK5X2ysSxXdudldSvRbjzzX7VkGN8tc8COYzas92oRi6yPeTpoLL0C3d4trGHQMXLm/2mILJIe58nFnXI+KggKJgOC0f9uEUz+5Wn345pJsxq9LkmIetLmuqTOsSjqUkYlLdNxtvdWI90igr3LdZIpeDkweB5b6LaTnA0b989fb5HkQg3u1ikNgEv694Rej1M19bJLCTVEhZ/oYQbPVn1j0uaqtn+4Hh9JkLHsuPXaO5vjY1KOJ7ksQZ+mHWrZwb5bnIrRscnr19LxndzGj5b3Dycgae3Yt2l0cRDZVwjjsb2ELxvSKkRyypGUpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f809070-e07a-43ee-8062-08dc39711f4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 21:55:20.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qB5w0zitjZ1Edfbj3OthY9BiqOlmXGhmis4Ll7anU6oBGpma71/0IcY+7oIHdVaPuRFVoxiy2k1z7/DQ2uyJps1vnfYR01MvYvjMJXyTzsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6595
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_06,2024-02-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290171
X-Proofpoint-GUID: FsWvuKwi2IHK3odVji0t_MCFDY5h0wE1
X-Proofpoint-ORIG-GUID: FsWvuKwi2IHK3odVji0t_MCFDY5h0wE1

On 19/02/2024 23:07, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> Replace the existing brief explanation on bisecting regressions with a
>> text describing the whole process from beginning to end -- while also
>> describing how to validate if a problem is still present in mainline.
>> This "two in one" approach is possible, as checking whenever a bug is in
>> mainline is one of the first steps before performing a bisection anyway
>> and thus described. Due to this approach the text also works quite
>> nicely in conjunction with
>> Documentation/admin-guide/reporting-issues.rst, as it covers all typical
>> cases where users will need to build a kernel in exactly the same order.
> 
> I have scanned over this; don't really have a time to do a detailed
> reading at this point.  My overall impression is: it's useful
> information, but I think we're going to overwhelm people.  I worry that
> we're replacing a one-page file on how to do a bisect with a 1,900-line
> beast.  I suspect there are whole classes of readers who want the new
> stuff, but there are others who would be better served by something much
> more terse.

My vote would be to include the new document "soon" (perhaps after
Petr's extensive comments have been addressed), but keep the existing,
short document around as well.

Yes, the new doc is long and perhaps overwhelming for some, but nobody
is forced to use it and its existence in the kernel documentation does
not in any way detract from the documentation as a whole.

I also think the best feedback is going to come from users attempting
to use these steps for their real regressions. Once merged, we
(Thorsten or anybody) can attempt to incorporate that feedback in
increments.

Perfect is the enemy of good, etc.

> I'll repeat a question I've asked before: should we create a separate
> "tutorials" book for this kind of material?  I honestly think that the
> readers for this kind of documentation will be a different crowd, and
> everybody might be better off if we put the tutorial material in one
> place where they can find it easily.

Something I really like about the current set of books is that they are,
at least in theory, roughly divided by their target audience
(user/admin, userspace dev, kernel dev). I'd worry that "tutorials"
as a top-level book would unintentionally end up as a very mixed bag of
documents that don't have a clearly defined target audience.

So FWIW I don't think "tutorials" should be a new top-level book. Maybe
it could be its own section under admin-guide, but in that case we
should have a clear idea of what other documents we intend to move there
as well.

Also, I'm not sure if this bisection document is really even a tutorial;
I feel like tutorials aim to teach, while this document seems more like
a guide/howto or run-book. Maybe this is splitting hairs, though :-)


Vegard

