Return-Path: <linux-kernel+bounces-48513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BDF845D26
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BF929182E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7337D5A4E7;
	Thu,  1 Feb 2024 16:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0NZJ70w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PXq3SdFy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17605E225;
	Thu,  1 Feb 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804451; cv=fail; b=aS/P7ROZhfhUBla2yRNVnkhAF11eByTD1jLRxUAetIY3z33pt9GIhzQjt80AF/GdHd7TD53y+WGWPaVYBcJkpbsGsH9kf4Sc0ejShQEDYqjsi/+UExsVqqlbd/GKj+f4OZjX7ar7k4J7ubbqPQufrzIFJ3680xkHE521KPsDCHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804451; c=relaxed/simple;
	bh=5VoLJSvAgUhw9O3Jb3RKd8Qn14Pz1jaGbaKFTI+7TOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uOnluY/m5HjmOl3XGC37Y617S9Ucsz3QNoqAKUpYo+6ivhl9mreehKVAn50jry4weAfEwdHFGs/KY9faMsfCM8eGtxdL7qjio/6bPfmxaWx0f8dySh4Nui500zOPuwNW/3Ma5cP+JDtMvVh2VQRWZVYIBRMFm2xmNwwU8oT+SVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0NZJ70w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PXq3SdFy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411EF9ZC011350;
	Thu, 1 Feb 2024 16:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cAWOhF5zBtR/hwaecjVkO/XN0c9Mb5oqsZpLBsS8/lg=;
 b=W0NZJ70w/svlqHxbpieL5cqmDgN9bbwgVWDNpmNaLYZboSH8tH/Ud7ZUZDuGrJqKo+oy
 xf8i0NjudTESVdWlls+eTL8V7yeU5//oRXjXtIxWCvc8xGjzsN3qm5/uV6c0ApkE43Sc
 8+5nU3zmc+rx1inKU038nnfbGTjcvipssQIkMxYEjVYwRCH7ExF/eC5TxDLHbuAdUv/B
 +h3aFhK7Pp4ULF2aDx7wzWbHz6P2BY41LENgwbsHzGRTClD3x8WyqtJqesqNu5ZXrisL
 b5RlZ2GA8RN6jvqw8GYhsFGB6On7Q0buBVDgH+K/S0sOSyQtieeClfzLT+tLi0jt4eFf sQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2n927-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 16:20:20 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 411FgOrm005452;
	Thu, 1 Feb 2024 16:20:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9gmhcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 16:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUtP58osWQZwUYNLcXvDQj9g9wMT/KqQF8hbVjqDx7O5Z7aFVdzjp+ct4+HR4yorJqnQCwlHrr+4S3pTg65PTi5a/QsB28g31ab43oP7qafKdVXfIvNdR+bJ4XdnTmHGE0Wj/kTGpyWvlYxxulH981gLF/gplKG2qdvoSYl21wVHB9QuXEV8EZXDpm8WCUD/V7TUQ0dNwtgkJHHCKFr2DNF/DHBqaPHwylfUacEbHt9OcEa9Fku2rtrW8di4xkZ1fFhuQvMVhKOS0xH0BzTto9TiMp6FzZPnnhkpLZi7vvGaUT23RwgsgdyFLi1tIbkZXrr/77GIEyY/3nYUVyh3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAWOhF5zBtR/hwaecjVkO/XN0c9Mb5oqsZpLBsS8/lg=;
 b=ncVcdwXgVTEsWTrYbJJA55FLPE2tm0sDm0bMqynTNOtAvLexrvyoyRD3QqNK+qdBwqPfRSdyLBFBDW3q+mw14Byfgwwk9bvALdnY7X6tYz0mdYahFJxXdBZsoNh3ZvsggAYyxmNvGewsvihYsddmL5aRa9U8KxeWBa5TnZReqGMS6qKc9Kus9Bxoz8YRXtWdaJs5K4RLi4IvxvtBP2w3Ol/qUKRpEe+fLEbWTEKOjCMCCGf1X7U0ssbPfAhFWn46Jhd8I1tD5rO9kT/C+hpxttse7FSJOT2i4+RiQR35vrAtH9BjjVXrrGu5bd04MBC7SwR+voo2myGWeLZMm4DtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAWOhF5zBtR/hwaecjVkO/XN0c9Mb5oqsZpLBsS8/lg=;
 b=PXq3SdFyD/RhPnu/hjMz4x/9AD60zumMQwtAY484QTQwDarJeIFHRVQIUlgF2a1hj/lusAWhCkp4CkWJfgyJK16YvaLd+0HejoCDwIM1D2w/QVUPhT8+8DLWELdgpGC4QVLcw9Cxq4w8KL25pgbcUtWn2KFfEPMGIE4VzXYlM7E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7763.namprd10.prod.outlook.com (2603:10b6:610:1bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 16:20:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 16:20:16 +0000
Message-ID: <715c5c81-9b0a-4182-a5a1-f5341ee79040@oracle.com>
Date: Thu, 1 Feb 2024 16:20:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, mcgrof@kernel.org, russ.weight@linux.dev,
        gregkh@linuxfoundation.org, rafael@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        keescook@chromium.org, masahiroy@kernel.org, nathan@kernel.org,
        nicolas@fjasle.eu, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <20240131104851.2311358-4-john.g.garry@oracle.com>
 <20240131112432.5133bcaa@kernel.org>
 <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>
 <Zbual3uIsjXENw0c@nanopsycho> <20240201080932.4f8bb9fc@kernel.org>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240201080932.4f8bb9fc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: c62b8007-fc01-4031-1e14-08dc2341ad2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	X+0/8pNejsr4dTLW5XpDukapYXTo3oYBvn0oSdK2YqPJZELDA90ToPr6Q3duega1dckgcd1wU2aW7XBCubE3ldOlj6KQ9CIgl/BTz6y7eZ1qrJ6fuLZlyxHmx+Q8YJ0N8eJDAgGOzMzr3rmKaXh2hRllqEw+Nj0HsTXTQEefUETUGysHfx7S8phhMFCJ9hYVk0meyCJ5Ta+uVSfLHwQcoRCo+qrQUhfTmO6phq3Y6fJO+JbFRRTJlbrQ9dofyaZjfigf9jP+rfvSCEAGz0DSGW5oo321Sv/nQq4smW6egWmGCqk68JlqEMb5MApodUiJbsnuaNb6xyQAh4BIfMrGaSe5XUK29AxS8Vp+L7DriXOMiYASN09ixCN1uzfsW0Qji5jafJNFtw65N3cs9iS8rbFCKVKGM1M324z9sJ+IKsjySuOyl1kImDEMJi2Gp+Ep9dcDa9an3dTQALkQ1pLttHvV3PQWv8cfK1tJKAhak3CcR6YRgxaA+XB/XXMwAp27OEd7+GdV+4Zqg3cmVb12q8iN3jgGDZi2IwRIEvu2hiQkA4SsIO5Cu2oRwZVTNRCkycBtt2Q6hrxRlZFAHu+3ialRjbbCnZGinbwcZq+pibl9cxdAK7Ab3Oa9zsRCSq2zKXILjkRRKoPQTQyjyYN5Tw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(2616005)(31686004)(41300700001)(66946007)(36756003)(66476007)(66556008)(36916002)(6506007)(53546011)(6512007)(6666004)(6486002)(478600001)(38100700002)(316002)(6916009)(7416002)(5660300002)(86362001)(8936002)(8676002)(4744005)(2906002)(31696002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a3g2U0kzeHpkaC9QWVQ2c1BKMDF4Szk1MUVKUjduczRFV0o4eXVMZUs4TkFq?=
 =?utf-8?B?cS9QZnVvSzFXZC9SNHNGWlZmTncvcHAwTy9VdzdEL1FhSlZMRVEyYjBFV0R4?=
 =?utf-8?B?UEluMVFadzE4akZERGgvM2YzV2FkbllqOStvSjh2WVJIZDV4ekFWVWZ6ajdp?=
 =?utf-8?B?MkthbjhBNGY3Q1VRZDlDeEhic0RPYmdYVUVaclRQRk5SZXVuVHZZb1lvTUlL?=
 =?utf-8?B?VjI2WXhPQTF6bGZ3V3BReWFPT2luTlRhdTB6S1BVN3RWTHlKbTNyM1M5T3Rp?=
 =?utf-8?B?dEFabGxycWcwdmRKdStGK2o0QzFWS2cvSG9oK25Pc1JwQkJzblFTMFRJQm1p?=
 =?utf-8?B?SHVPWkI5czc0RGZLd05tczhVRUhudFJnRHgrV0h1cGZueXZQRVlPaGtJRDZY?=
 =?utf-8?B?SXpyMjRWUTNEaUlCbXdoQ2MvUlRNRC9STjE1Nlcwa2lvaWJaRVV5Q3hvMXdF?=
 =?utf-8?B?NVYwOFhOUUhNV2dJOU16U2IvSCs3MmZFcHJVK282UnMwVmI1a3pMb01LOHhW?=
 =?utf-8?B?aExpVWVBaE1vTHIvZnBiOEF3KzZCMWZBODF6RnF0cjUvaG56a0R3UG94bkFN?=
 =?utf-8?B?OXJUc2E5YzZnOVBPUHpqUzRKVDM2TUFBNUdheVBqblA4Wkp4bVg3OGtMWlR3?=
 =?utf-8?B?U0VxSjdVNjREWTNBa0c4OGtpemMyb01KanBuRVJqZTZwdzc2eThhbnJxMGFt?=
 =?utf-8?B?ODI2T2RHdS9OR1liVU5tTmdidU8ybVJkNDBucDZ5VW1MOUhHb1UxK0F1SXNG?=
 =?utf-8?B?VUJsK3hvK2xXS0FNSkkxb3QwYXJuOVYvbXJPVkRUSzRmOTlISzVRUDF1aGlQ?=
 =?utf-8?B?UnV3MFpXUE1LeXlxVHdPMG9ZRnpUUjcrMGxDcmVOV2VuQ2JyUmdFczBCSFhD?=
 =?utf-8?B?bWVQaGlpMUY3WDdkR3lxVTcwb3hDSjVDR0dJeVFDS3E5cnpVSms0aUZNdmd4?=
 =?utf-8?B?aUlRbVN6RDFjN1Q4dkd6OUUvSlB2YlE0eENsNFJzdmtmNTU0NXExSkZiY3Rm?=
 =?utf-8?B?eElkVUxscjRxQ1BWdjdXSzl1QklMQnlqbUVyUGVsWGx2OXBSdDNkUVd6NE5V?=
 =?utf-8?B?T202ZXlMdTdyY3M2bHhPempQQ3BPV0wwbTF1MG1QNUxZTndGMTNaejZSUFRJ?=
 =?utf-8?B?dmIxWUFhcTBlRVRjcVFOa1dFajE1eFJnbDlBNkdyeVR2RjBXKzN1K1BmT3Qy?=
 =?utf-8?B?MWhBN3krN0p0OGhTcU5PMWpvdUwyNmtnNnVEUlhCODBrN1pPcmpwUGg0S3d4?=
 =?utf-8?B?UTVid0FGbGl2MTlNQ3RuV0xoaUpwUm9wa0VmUFlvdklyZlBremhIL3c1NWxG?=
 =?utf-8?B?cS9ySFg5dG9udmNNZERzWEZkbGdDcXU0dGIyV0NiYWI1NzdVT3VaUUV6Q3ky?=
 =?utf-8?B?TzFMRUNvbHFBSk56SXpwMjh4YkdkN1lFZThYUjNUK2p6cjJ2QzZobXAvbVQ4?=
 =?utf-8?B?MUE1U2pYMVpUV3FmZ0Ura1dzNkI0c1NOZjZuaER3S2xNREw2TTlQLzFVbjFw?=
 =?utf-8?B?d2s2ZWY3UlFkeXZXRk0zU0IzMVdDcjl2WHpoTG02R3FDQmVzemxTK3poVFJi?=
 =?utf-8?B?YXRxL1pMM3Jvdk45NkFnT3ZIQ0VrVVJyRmZvU3l6KzhnQ3pZeDB4M2VrRnRk?=
 =?utf-8?B?c0g1bFJXTGw1MDNqRDkwWlp3SFNBNkh6RGxESFNGa3YzZ3dYYzdNN09PdGdV?=
 =?utf-8?B?VDNSOGJLemw4K0M1RlpQeUJNVWlFZ2F2QWYvanRiZkc4OHZVR0NSOGVsUGRZ?=
 =?utf-8?B?SGNFRTVrSklkNXJtb0pvaVBoWlNIcGF0T1FZYVNnRGNKbVBvNElyWCtmZFpl?=
 =?utf-8?B?VDg0SFNCK0w4WHBQWE9xQ0hDWG0ydk40VTBQTndjTHdkaWVYVHhBNnlPdTlM?=
 =?utf-8?B?dlFCLzdrMDZ3SkRJVlN5Z0VtRkRmNDVMdzNyTFYvMnVIOXBDQlMzWkdLeCtw?=
 =?utf-8?B?RUtXS3VnQXBCWVhNMnRSU1VtUXNHODBGaGZxMFJYTXJ2aDhkRXJxT3JSKzRN?=
 =?utf-8?B?Y1pLOTJCbHJRWHhCTGJEa3BNMEExUmpyRy9DZzFEVm1ySzVWZW5LQU9yUkc0?=
 =?utf-8?B?TkhnZzhEWTRZUm4zRmprMFMyVnpZREVtRUt4Q1FTMXhUTnZlQ3RQR1phcEgr?=
 =?utf-8?Q?yrwB5yNMZkTF6XAhBrYO32I5K?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SwX/bGsl4wDQWVMxoS8DfXJ/wQt35vUBuRU1kHXrez09Qs0RGFnRgs98K1BtzydJOlc0DWttHqYIW17Lenoe0EMC1K/fwhim8I7y45ADYTMeYHrkkMQCFTyLkphulN1HBycrcQwnzWMMgncyGhX3iZJhegQeB/1RQzfvmXbI4KGjt6X2nbBClZitIaanwiW9gtPFpAoCNg/xbvIwZD6NLbPkF67embkWjQ9z0x/gMkTJhaAvJPvf1QMU8tfK2BZjKLMW8bSwfS8i9yg2ae9w4NNNxXd6uiGewt1xvheQ7g8QIW8vQ3AcghCE+FLi/aZOYqxCS0KsoshrMmXYy2x6hyykxo4X8n5JH6Hot/WrZZPQPpBBc3aIucFbE5P0LkhhZGkOxp3199TAo1Mf78PWPdZi+UL1y0S7LTq+Bsu0VuS2OlytJNqAu+Yi5mUJHoGr2ODMvz5xFFzjqAiTGDSHtOvzHdL6LQQ2Iq9YKKJX6QyK7FzAkogykjB6wPh4aP4Cpkv/ZdFFgH4psEK4bpsK6zeSCOdAZfy1fjyytk+YuoNojraNwktnvx1NQqJIG6h7WKn9g+Pw41zOrd04jwA4ki5pDwYE2GJNZnF037nwBo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b8007-fc01-4031-1e14-08dc2341ad2e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:20:16.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv34VQYw6IPXbsJg62WFq8+tTbmzi18ZEAQQk5AZv1WQUwS02sAEdmAVfbbaz5j/fUXHsLKCXJAjAzdS+1eQhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=847 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402010127
X-Proofpoint-GUID: 2m4kcih1BBFqmhw3wzHBnfU6oGkbcjJk
X-Proofpoint-ORIG-GUID: 2m4kcih1BBFqmhw3wzHBnfU6oGkbcjJk

On 01/02/2024 16:09, Jakub Kicinski wrote:
> On Thu, 1 Feb 2024 14:20:23 +0100 Jiri Pirko wrote:
>>> BTW, I assume that changes like this are also ok:
>>>
>>> --------8<---------
>>>
>>>    net: team: Don't bother filling in ethtool driver version
> 
> Yup, just to be clear - you can send this independently from the series,

Sure, and I think rocker and staging/octeon also have this unnecessary 
code also.

> tag is as
> 
>   [PATCH net-next]

ah, yes

> 
> we'll take it via the networking tree.

Thanks. I assume Greg - the staging maintainer - would take the octeon 
patch.

> I'm not sure which tree the other
> patches will go thru..

I think that the best thing to do is get a minimal set in for 6.9 and 
then merge the rest in the next cycle. I've got about 22 patches in 
total now, but I think that there will be more. We'll see who can pick 
up the first set when I send it officially.

Thanks,
John


