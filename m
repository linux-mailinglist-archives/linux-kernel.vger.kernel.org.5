Return-Path: <linux-kernel+bounces-105697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855C87E2DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75D31F21927
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F120B0E;
	Mon, 18 Mar 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctPmIjx2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lC2bwg5E"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD91DDE9;
	Mon, 18 Mar 2024 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737479; cv=fail; b=fCajZEEQS1EQhTW2XJacFAeTy+1s2PaZFeBlu4WI1KVigFIBkY4/UB/lRSnKmga5Q+Rfvqr1eFFcHJkKMsPU0hFu64HNumB3avOblbCLVpZ2+FMzi3MkAmWGCplB+dK8qd9YHd17NjPl4CS12o0jVRrUDqvxIjK4rNbuej/eB9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737479; c=relaxed/simple;
	bh=UcE4NO/OJ383x81NoEAPOC5aIpxW7s29M2VgLeDFe98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PnL8nd8A61MQh/4VC4wfBc6+Q1CJDjtdtrP6MZABE+WFg0+JKIIDwDOih4Rbp0N7s6CHeGK5m91pWZOVsGSo6OGv/We1qOgforsVcfUgMFounTt4WWMZDJbiZr+OKxgm6m4GlChzPiGM6Pe0eG1CcbXLpPZGHgURDMGEQjN1WC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctPmIjx2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lC2bwg5E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42I1iENO024290;
	Mon, 18 Mar 2024 04:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pleFli8ci26IO1kMaTXfZezXzBTNc859SJuQJTuU5kQ=;
 b=ctPmIjx21V/XQBbBkV1tPRUC13TdFSyYXUjflBt2v5dqtCbhgylGMtrxeUlTKoFkao9Y
 8tLi+gb3mqUodHzjZg3FUAY50rWacVM3FefdBHcQ4CPSBgzaqLWVUcNy8cpWIte7D+di
 z5uEL3hFpmtug7e0aFkZMp6Rniuirkodj54ontBD8Uw0bkIMEivbVIeNeL4GAHceYi1a
 E76NZpbMnWLz2HD3PPHTMoPVgR5qlIxyZlUJ39wd1CXBW5Stq/xTT01I6UvQny3/qQLX
 Fa7RGSPRKnO19DhPaYL7FPqiuFAmN7IWOk2FHvRNY6JXT8dcUEXyS2LxHjNhC9omvgGw lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tj5k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 04:51:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42I4Gsjr007615;
	Mon, 18 Mar 2024 04:51:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v4ccmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Mar 2024 04:51:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNRzERnb8CWDdpdzmwLEmj64ceYiV2g1D/WAfvcMnck5XqUfZ9qm7u079pKPoGLAxuWnl2Q0UO5o0mciBD3TBV9f8z+C0sPeo9k/oy92UQsKUE+hp3G4nozLXh1JmauhzrCq/wlOWY8lR7g9V3i9uW68lz8yeqNOy45jjd3fTfysaU1mqadSGnzvEIryH5IxpjIUQRNe550U+2tDDo5LftuB6K9twLPWVd5nW2GTEqPmwaOzoLGttezXDH2njiyMRnq9YX3W5tC9+MvnRKAIt/CStKnFbSOzSkHG/hmpa4weXJLsCo/SV6ZlyDqs4U2TMP39y1wEMF7sIvpjyCi3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pleFli8ci26IO1kMaTXfZezXzBTNc859SJuQJTuU5kQ=;
 b=JHPGgT/twkx1qlmmk+mgS55pFainrbs9wmtTRZZxmOqMqw2Wy9yfCe8kVzdmd4BMCmYAOIR5U+6Ru0+2f+eh5wZpcFrK6UndDjEN9DdFuMDhL14hwX1fP8KMZ5HG2uW76Dt0blSrUgdirthbhzSa/Fo9+N4wP60uWOaA2LRw+A+WYt9++kwddVQQDQk3VUQ+MbqwKlO9PVd+hyeLv6mPuoNwxcJd3G/NJsz8Aqh32Yf3Ev50wleSgSa1XfnZWbIgcPYs3mA2CHgiSe3G4bdh4nQO8K6kPXOCyHXcoldi6i239St00mNmq+DlWuA/wUTMdOcacMQ/GdW9VReYbuNHPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pleFli8ci26IO1kMaTXfZezXzBTNc859SJuQJTuU5kQ=;
 b=lC2bwg5Exxum/T46X7TYOtUtisuqbbifJoHB0Hvk2FWxMDc58A5hIRrz5Iw86pqD4dvR+KSbag+dYhwQ28NEiRanfJDIHCivjZ/Qtlazqu4pluksfelTYIHf/GhpTTlZlpwKYWW3W/ibD6sPGLXlpT1zhzfvly4aSlp6mDYA3tI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 04:51:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 04:51:02 +0000
Message-ID: <d9d6d334-7d50-4d36-a03e-f2f6811e0ecb@oracle.com>
Date: Mon, 18 Mar 2024 10:20:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the btrfs-fixes tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Sterba <dsterba@suse.cz>
Cc: David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>
References: <20240318091755.1d0f696f@canb.auug.org.au>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20240318091755.1d0f696f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1591b0-d1f0-4939-fd57-08dc47070322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DIg5PADRuy3etMIHjRg3pv2EUIoPTN9ZwBDhSNqxBMX7vJk/AIAzzSiXZqHgK4N/TTEzWnPOQu1y0bCOSd6R6a1rxkVnt82NT3DH1MhZIa0fvc04gFf72ftYb2SvhAW8Ah2YhEHwcW8MFCquy0aEKUSlDE9d8zV5e/SYWAhONC4YY6hsZK1/2mIXa/5eRZx434C6TqjRJMkvcG3Cer9t2/1q2VMtJVlH8pRN9/BjEJ72pKB8XrWyWEMC0U7VpiW2VA/2e6rUyx9RlAtozf3hgecJry69DFWFr3nW38Pesiglsuf7Ey3eOppJ4R968IhSHG0bkxxFM51wEmYgz8hx7oFgd3Zad54m6NlC6U51SBZQhtPMJnxiCGuVvun66/oGNHmKye0Z69/IKg7pnCvOS93PnTjk+T2QT/jFm2VnGJMEbwRD11mZG0gqaXKD6xJpU6apFZzTXUxyR14bRD6U7cZfYwi2QSnKnLrJFJZ1wqMAggR4cn8vffZ/x0kBRAxeduBA/gutG3iKveDkREreF113dIjwsCLK6M2vaDYGhhfnTglrTvjnLD34epkH3b+F0P72JneGUjLlj4reuHHK6tpgP4dWwgMGchkfRTYLi1M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THI3eUVwWWFudkNTdGl2cG5uQkF5R0sxbytqak9PUWZqNkhlTGNqUjF6Ujdh?=
 =?utf-8?B?UnNBRHdaT3krS1ZxRXVWUHQ0allpelByR1NNMmFBZVdzTGlHKzBBUm1qRUps?=
 =?utf-8?B?K2pIZ2dMZzJqdDVXWSt5OXRmRlM4Qk10Q0FtVys4Vks0d3pOc2JUcFVWWjN5?=
 =?utf-8?B?UTVsTUt0WXpKVEFnSjVEVkJoZFUzUHo5S01pN0I4VWYyU0wyM2o2YUFWOVU0?=
 =?utf-8?B?MG1rSVdhSTVaMjFvaUh1ZnZXSU5kZlpVUFh2amQ1WVcxRkxmNC9JbFEzZFZa?=
 =?utf-8?B?c3JTbCs2TmJ0TzJKL0JGYTNnd3prWTZQN2x0TS9BUmgwb0xYcXNlT3BnUmQ5?=
 =?utf-8?B?RDNxUG9oSTI5LzVSYlkxYU5oYThOdDFLM1RJd3d3Nk82R3NRK1VvcHkwcTFE?=
 =?utf-8?B?akc2Y3hRa0ZXVTlHNmNhcTIzOVREdGJxWnhnYmgwY1RLVCtQVGg5bThLbUNq?=
 =?utf-8?B?dWhCditKbW1uazNuVHdicm0vTlVZcDdDTkg4dU1FQnpkMlFTY2FxSFQyeGJn?=
 =?utf-8?B?b20yT2JtazI0ZXl6Sm5vUWxIQ2VJS1JqdFY2QTkyZFBwdXQ3N3RtcXVhTjYz?=
 =?utf-8?B?V2JML3VqZGhHcUFHNk9DTU5tQjB0RHp3b0d1QlJtaWlZM3BZaU5Ra0RyblRs?=
 =?utf-8?B?aTVXQkVjY1ZqZmg5YXllc0xhL1FQdythVnBLd09PbVRFRFRReUdRdU42RVla?=
 =?utf-8?B?MTZWeGhuKzRVb0VXUVgyZlFGaGloVnhZZU1pVysyWHF5eHd0OS9lSU81eDUv?=
 =?utf-8?B?cHY0SzBaTHRaNU1hQXZmZk81VzErNFdML1lLN1ltWjhXZGxQZlpqWWhONi9s?=
 =?utf-8?B?aWo4Y3N4RkJ0QzhhdXdlVXlBS1hsM1dBUlJkUzhZRVh0MWR4UXpkdjY0VGto?=
 =?utf-8?B?N3RzNG5uOWRKVTMvcmRCNXYzUnJGS1hOZktuSUh2Y3N6ZlFmTGVwelA5S1RY?=
 =?utf-8?B?S0gvTHR4a0hyQXh0eTFhd2RQVEZGOERFa3I4K0lSOEZGVW1samhoT1lFYnd2?=
 =?utf-8?B?cWgwdFFRbkI3Z3VGSUF6SjJYWG1yQTMxaXZCVlNya0hiYVlROXptN252aHU2?=
 =?utf-8?B?eWFsUW5wcnY3QmIxMzg2dzhObVJ0QjJIUkY2Z2FXSmJjZ1ZxZEVNcnZEdWdt?=
 =?utf-8?B?blpkWGludjQwWS9tVjlIdlhtS0cxL2VkdXlYN2s4clBxemdhUzFrTXJaZkJZ?=
 =?utf-8?B?QllDSWtzYjBsdkpXcFpCQ2wvUnJocWU5OWhFTDl6TGk4aVF3NmwrRXYwYWRn?=
 =?utf-8?B?N2RseU93OWcvS283T3VvcmxrUWcrUW4vSEJGM0hHV1A2dDdJYXJtdStsdGN4?=
 =?utf-8?B?QnVsTDNVbHFGbnA3aGhUQzhIOUVvQXRxc3VGZ2hTdVBvQnJTaGdLMk5NQTdi?=
 =?utf-8?B?b0Y1R1Q5WDgzcGVXbGFUMVgzbVRFRXIyT3FwWXUwSkJNL3hzbGZBR2hnaVp1?=
 =?utf-8?B?WVVLMkpxYkRuR3ozTmtEcEY5eHJ0aXZmYWVNWjZXTUY0VUdDYlB5WEdneDJ1?=
 =?utf-8?B?Vm9KN3ArOEd2MXRWcjRPdEdhM1Z4NEtKOWpwSSszMEdZM3B4dnhGYjVXTE9v?=
 =?utf-8?B?L0ZsTHBrcWJMdzNUSThzSU4xdERXd1lpNHBubzZNTVJNU2tpbjREWGtmeFlS?=
 =?utf-8?B?ck1WSVcxUGJ3UURqZUM5YndyUW95UFJOT2cvL2o1K3Z3WEFJdGN3YUlPN0hR?=
 =?utf-8?B?OEhMenh0ZTVzVnozemFVVFgvaVF1dEUrSUpMK0t5cmJGSjdROHZRVHNnVG9r?=
 =?utf-8?B?VnBwbTh4djFjWGdSMzd5bElGR0ZSY29HQ0JjS3dCbFkwTzdHQTdPNU9nKzlM?=
 =?utf-8?B?S2gra2xzcGt5ei9zS2ZZaFUvZUsvRkszcG1jV1ZESnIwT29PUlhNSWZJNkxl?=
 =?utf-8?B?bnp6czZvbWdJUTc3Z1ZZS0RRNFFDanNFc3lLeExteFV2Z3pyRFZVbWxOd1N6?=
 =?utf-8?B?aXhrRXFXVG5MbmxReTEyZ0NzRXJ2RHFlK3pBemlWTkZlSU1OVFhIQ3Qvc3Fz?=
 =?utf-8?B?T0JiVzB2MzZ1cGhacE5VMEE5UWNVeW5hQWR2WGhINFI0RXZ4S0hsalhqM2ky?=
 =?utf-8?B?MEFjeTZGNlVFUE5FbFZPVjVWK0s0Z016aTB1blJXMWZGZ25lbWFsMDdreXdm?=
 =?utf-8?Q?VmpDMtRIuix7vY+C5qV8jmo3k?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FfWibi2/QfJvLUkRavKX66Lxam78W7kvUHua0eY3R0FUUW7HHAuc9UUOnqYvkGu8gAKQZiOptUDuiCNdNt7ncXncEyqoJ4aGaudKd5rhhOpxUtQ2mYxAIskK/CcKCzKSkXZ811UX4cD5rfxiBiIj23Nekao6srtNR6Ogg9GKpNRM1FH96SzLZb8SbTEE/PZ4anFbIYcGfrMZx8boH27q8sEJzeUWuNOyFVRmTk5Ccmm0B6pQvWu8FVoCkjPVouyNTo3Ttx85dRp/kzNrCKEe+nL00BLswGIv+QowC/Bsc1KIlH26ttt2wQ2qPJGxxu1lbEQjGCsyXcBWulOdWbtTQ9UQmJsZHXmpZwRXBfzvcOJ/LdHvAAvqHRc7AZyJrRpeQO8wW3UGfb8ax2l5nSPjoTiBvUiZo9oHFa99iJhg/BD2dOZ9TBnjjKwAJoMQf1zpIcV+zzFhaXNc7Q3Z7MMbknXOniDZZ7tAbdp6xS0Aqvil6Kzx6n3csuNbwiMItAA7+NJB1NPdVfTbUwurkDeYu2BA13ple4uAfEtjzhywgbHZ9Nmh/mh4FjQNshdYQVSM9Dl5IHcuiZEi0RQygcXv3STrubJ9gq8Fodj4mI9CW6w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1591b0-d1f0-4939-fd57-08dc47070322
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 04:51:02.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+g0/Ol+WYDJ2ZzJ5RGztBlSRHiYGJZNkXmEWSAptDVvGJhZjBWqotuynKXvqacLSwgHKQpGG99GnMXi0F93gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-17_12,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403140000
 definitions=main-2403180034
X-Proofpoint-ORIG-GUID: CelVlTXGGrtIF8CAilCZP8xyT879l7SK
X-Proofpoint-GUID: CelVlTXGGrtIF8CAilCZP8xyT879l7SK



On 3/18/24 03:47, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the btrfs-fixes tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> fs/btrfs/volumes.c: In function 'btrfs_scan_one_device':
> fs/btrfs/volumes.c:1413:55: error: 'bdev_handle' undeclared (first use in this function)
>   1413 |         if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
>        |                                                       ^~~~~~~~~~~
> fs/btrfs/volumes.c:1413:55: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>    cc019bc0d55b ("btrfs: do not skip re-registration for the mounted device")
> 
> I have used the btrfs-fixes tree from next-20240315 for today.
> 


> This is actually caused by an interaction with commit
> 
>    9ae061cf2a46 ("btrfs: port device access to file")
> 

Ah, unaware of this change. Thanks for the report.
A new fix, built on top of this change, has now been sent out.

As the Linux-next branch no longer has the commit cc019bc0d55b,
I've sent out the entire patch again.

https://lore.kernel.org/linux-btrfs/57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com/


Thanks, Anand

> which has been in Linus' tree since March 12 (and linux-next since Feb 26).

