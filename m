Return-Path: <linux-kernel+bounces-36720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EE83A595
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8722AB272FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F617C69;
	Wed, 24 Jan 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QJGl4zgM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kDvnSAkI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2799017BC4;
	Wed, 24 Jan 2024 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088726; cv=fail; b=gQqz5PLehOmRMTLnKVDLXiVvR3yQ1cJcGPQEv/6nB8SriJW0LKmJcLjwP3xgCcfvqDfdst8T+AWmwZVcJnTxO/zvb03p6laJ4V/XKTY+JtMtlmehBxuMiOeACUcqYVYyuqKMxz88W2khgIz4B84qqSn6BwcdgNszwrNfE2fwu64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088726; c=relaxed/simple;
	bh=b36RmLpvlvgfxIkSlzqC6ALqrashcRYEx0f1TLVpGUk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gzha0vN9MhWtZ3gJZL+QzNNXlmibs2s+38Q6AfntsqJXG33tPPdJdVMb1lXf+DRQNKiTbftZWYQ4tHpJI2kh1e55BCv/lPJtcmGeXtC/wtgXbrXACOHWthdAjrC68MhuNyru9v/wL3amEYkdba7Z7Ne7zmQUdKz5F5BS4862Rmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QJGl4zgM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kDvnSAkI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O2xOpv019915;
	Wed, 24 Jan 2024 09:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ouGVqnG+DhWoGEiSVGjqLypIpNUD6Oq0hSFa2paNtBs=;
 b=QJGl4zgM7/DypjS9QBuPwKHRoscaunGHYuWCjM5nioUpCgfGGQE9GNSoa48eqeLmLo5D
 i4FfM6k1+x8mQgEAwcFHixj3kSvCFBKHRoCHx4UQulKWxTU76jobsG5MvCNRaK4b2DO+
 3UEgTADQeouYFJ2QJzJT4DHGAOxQlyUZp7Ia4k5PacczPN9REaPIup+SIOF6Cunog8jM
 xj8MGdGhjF/SY1vjZThepIE2hYWtLCZKxtcrbInFjd9xr9/GCjPutlTTCb8n4spwvf0T
 KInvYwsvymmNO4B6Zhw4i482GU/WWKpJXPzewi7MfN1wx5EqqGBjkjCmv3zC6gJN6GCv KQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ac0rvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:31:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O9G74d006176;
	Wed, 24 Jan 2024 09:31:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32s795g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:31:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im8kfFC572GlyIcGGEAhnoUI/RcduRaRNg6BlI/EWk3MdwzlcE5M1bd53ZQ2zDa2mxw7yTKBvMVNSa/HQGSiXJuRp84wfEeS9Z4rObcLfm2/lXx4UjZYmuMMrjn2kKrQw7FuSnYPID8asp0fWVqYSizE1XUjRG2kMikbf+trboPang6yGI4/HCF6WsWzMheQ5068x0/Wu+DUJSuet9x9p5hx1iCkaRJP1VsRDtpR+F3RykFIG1q6ynLPd2EWyTGhCOXvWtI0Yzrjy/9dVGaiYjLPC25VueYCgQPZwkIEBsYR/At3KfNod6WS1SIeKFiprMZ7k2M9xKNI9697VqUojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouGVqnG+DhWoGEiSVGjqLypIpNUD6Oq0hSFa2paNtBs=;
 b=JT5a1OL4+cqOzROZZegDcPWYdWklCY/GoifuM+NXBXy56yt2n8jbxtYU35w3KxNq8L4+nr47oMIi0WCXpCBuLj3cDH/n0R+wxs+6R7RCPm107BrhPYL8ErKzdGIwT0U7aVqAkREK+E1G2nV0m722ydnBmcQd0XuDJh6+TnwpyV3dG6yRQq5GAZ4TCLPDWf5QWKNnvernzAwJRB7uifpp3dbND4iWIQt9FLp9LD+U8ZxnR59djagsc79orJEtxhqTmAhk+KQ9kHkbFzADneFUlnlJrX6lVVHGePzsifkTAyaGask+zEQeUtg6bEr9ccb2RTi/VZ8eEQdLQ4RSFe6S5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouGVqnG+DhWoGEiSVGjqLypIpNUD6Oq0hSFa2paNtBs=;
 b=kDvnSAkI2CxJj8pmGPF7VlLwF9aEeWsytN1Q85QTLtzVXVIGQWX3P+YdF5Q7+GOauGSqOtzXnrLvIANLgyO8SyPbvu+4dmAql5Ccu7S7eW2GUVLpax66C9szfFoP2f1PrLV/IFA8+hhlP2kFfpxiKZV+C5KyPkSOHhiIPpKTml0=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:31:34 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:31:34 +0000
Message-ID: <28345775-c0b4-414e-80a4-b81f3385e6e4@oracle.com>
Date: Wed, 24 Jan 2024 15:01:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/148] 4.19.306-rc1 review
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
References: <20240122235712.442097787@linuxfoundation.org>
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
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
X-MS-Office365-Filtering-Correlation-Id: e4ebd13f-f4d8-4acb-6f1a-08dc1cbf412d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rs8eiW/F/pH1pC44w8UYZUOW9UPQ0UhwzrFJbnUMQ7O81SQb8OPr+XFOGciCVGK/1okubhJ/Q/3Qqki8H/e6mhFxkksxxzeRET1NO0njuhrkCuInayGdQgLq44NmopD2WsJgiJQKrx2TNVnmE1HWznbQncdXzA9xFspP22lBGLDnGI4V0OoxYesDFeHLnGast6iv20q9WdwrYBQ+PBmP5z06w9OaEpCQL093SW8gA3ysZki5gKrmftxqUb06qR4O5xc29v9PtOaauzQR+a3Umg7RMgwMTeElMKwvEwSxkyrMlxO5rgttLfXOeVwTgfCxXyaKHeUuszUk/m2s755cqF5gGIAjkJXhsdjmVVcXk3NiD9HPfxPG0l3ObYjvBu3qkOR8jk9Sj6Hg4zPprS/uCmOcJ3v716hKu28SUKKnsVOjicMOcUEVAcs+UufcGh69BVdM1bQJrw/geVrB6PnDGreVa4cEsTdoVPVidoPNFzJX/h0VW6vB+EZ/8iuj4GFAYpEheBbdKSC5VFFSWeml5SRAoRuB2uPSJ2r9bTjW0wtGl5mUCO11rk2+o91PQsxPhxgnrb+df/Ab21EvdAUyS0IQiZ7n+8vTl6UV6zFgkO8KjvaHOiYh9wPPDy8vSrECHoDqpjxL+RqzmhrH6WGcrQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4744005)(2906002)(31696002)(6512007)(26005)(86362001)(2616005)(4326008)(8936002)(478600001)(8676002)(41300700001)(107886003)(38100700002)(36756003)(31686004)(66946007)(316002)(5660300002)(54906003)(66556008)(66476007)(6506007)(6666004)(966005)(53546011)(7416002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VTRlcVI0UzcwTHpEUDNWODdUQU1kZnBkb0M3UWlIUWx3bWs5d0UzRm5SVWEw?=
 =?utf-8?B?WHRDZWtFeW5ydEc2ZG5jakZEbVM4Mnk5ZWJBbktlMVJxUStYc2l1VU9ScnpE?=
 =?utf-8?B?SExURFJYSjFybGR3QkNleVplZGNHM0NvSEoya3prdFUwb1BPUlZnbFkrR2Vy?=
 =?utf-8?B?b3U2RHlVdWNRUnpWdlBGZ1daaStNTkFndldSNzFFU3RzdTVUQ21MZ3N6N3k2?=
 =?utf-8?B?cUJBYjd4LzVMQ2U5NUkrekJEcWVXNS9MSE94VkRsTDZza05NMElTUTFSeVJC?=
 =?utf-8?B?UG41VUIvUzhIUUswR1Bua1JORDhjNlZtb2ZhOFQxdHEwWXdIcUkyeTlsYVhu?=
 =?utf-8?B?c2pOYndnY3B2MW1CYkpMeGQvVHdhdDZrYXZNYmtOSU5jV2x2OHNRcDJTTVM4?=
 =?utf-8?B?VUJoT0NBT3M4aElhSUJZQXdvbmtOeUt5S011YXY2MGdxSHpJZ3F2VlpwN2xT?=
 =?utf-8?B?OHlUTHN0aUI4cGl5cEt3Qm1HdnAvd0tGbThmMUNGRFErZnFSY1F0YmRJU1p5?=
 =?utf-8?B?QWN0WGRGd2h0RXMrdTF0SEE1ZEdGQlU0S3BFYktLVlh1Z0JiMHBPanFWeUp3?=
 =?utf-8?B?K3dGZFFKZTBKZDFGdEtpSFRJdFdpRmFxNmxvckp0anhvbFpLK0x1Qmt1U3o5?=
 =?utf-8?B?ejRHQ0g2NFhpMngwTTZ6L0lvZEM3UENReUV3b2hhelAzQUhIbEdTbTAvbXBL?=
 =?utf-8?B?VzY5djNjLzRPWGlaWXVNZlpSampPaWc5R1VWUHVKQ0RMMStJMmU3R3NkNzFs?=
 =?utf-8?B?Y0VZNUFxWkYzZVRCdEl3TUd6RUx2VEphb1lNcDBTcUlBNGFlZDBlWU1GaUdv?=
 =?utf-8?B?WGlIUTA4ZjIyc3QveUlmbCs5NnEzcUlPdWlFamhRT2RYSzlIb0tHNFB1TSsw?=
 =?utf-8?B?Z1VGSzJ4V3ptRDFtRDlPUEIxNzJSSC9mMGo2M0oxakNJZlpzaWdmem4rMkZF?=
 =?utf-8?B?aTNIN1hoQ0F6MGVuU1RyeVdjRGFwWHpsbE9QYkd0V0JlVDlnZHlPQlJxRklR?=
 =?utf-8?B?bDQxTnNxRTNaT3VyRWx5eWREYmI3T3VtQ0Y1UUNzR0wreEN4S0VsVW9wZUFB?=
 =?utf-8?B?SU14U2NLejFxTm5FVkNScEY1WXk1UGxmUXFTdGFuR0RRL1pEMVBaSUVDM0lT?=
 =?utf-8?B?VDY3MkR1NXNtOXBjWVVpMTJNSk93RE5uV2E0TW80OXNGVkdCNnF5UUx3TG9W?=
 =?utf-8?B?M2ZrcXdsTXZzNUhHT3hwdjV4VmZHMVEzNzRxWXYyOFZOMjgraW1nZDVnY2ZD?=
 =?utf-8?B?ck1DMGhBeWI5V2J6R2xqMmEwRld2aDU0UDN5V1NFQ1hFeFFvTWhWWHJVMkJ1?=
 =?utf-8?B?d0Y2eldhc01XdjZKT28xZXA5R3pnNDhLRE9kVFN0aWp3eFRvT0dQRVlxWHVh?=
 =?utf-8?B?ek9LYVlkMVU0bnJlTlhTYnA3eDMyUlgxZUsxdmxnRjdiRFQ4aEdkZHcyZWNn?=
 =?utf-8?B?aGczRkt3TW1lSUgzd3cxTHd0YkRDN3dIaGVINldCRzJxejRseXhXSDc2cmVP?=
 =?utf-8?B?U1Npa2YySm5vZW94VzhzUnc0UCtONEZBdUJCdGtWOHhjRE9uZWw1MGxSWkxi?=
 =?utf-8?B?eVpFNC9TL3M0WWxCeU1qMERDaDIzQURkTjM0TUFQWW9lTjhLNnJVbzdWUmtl?=
 =?utf-8?B?cEhSRlM4bUIrWjRMOXp1dEt3bVZydUNoWTVkTmdFRHNSRDduekQ1VUdSNXFQ?=
 =?utf-8?B?MzZ1Q1ozZjdGMkVsdzhMZ3VPaS90Q2RCdURteGp2MkphcVNsZGhwd00vWVJw?=
 =?utf-8?B?M0g2TlV1bGRpZjdjeXJseUVoSmZ4VVNramRscnd5TTZUWkovSC9oM0RhNmlK?=
 =?utf-8?B?ZW1tUDJwSld5d2Z5SUNqZjFUR1VXU2JnSC9wUWRrWHZIVGl5ODZ1RGkrRXNR?=
 =?utf-8?B?bGtrSk5RMnUvSGlSLzlYczZVWlZjdk5NSDJ3YnNUcmJFMndXN0xKbVFEQXQ2?=
 =?utf-8?B?c0pvK1VVTVIxREVielNhT05MdFJtZEtMSmxvOWVwM2EzaVJGVjdtR1FvSXBo?=
 =?utf-8?B?OGR4bE4xd0tLb3hDRkQ4V1FoTlBFUi9jcGhLRjRBVHVKMTFuZWVJRFFLTHcz?=
 =?utf-8?B?MllqbUZ1bUlUNmF5ZmNRMW9qNFlPalk0b1ZaOXMzQW5mVHpnT2JLNDQza2Ra?=
 =?utf-8?B?QmxONUU3dEppZUh5UkoyazY5Y2NsaXdzNURBQ1pHSGZpVlc1V1drb094VVJu?=
 =?utf-8?Q?vkDXfZT8dHWCgt1C2kRofMU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kfXATYC6gFBBDGRVKqWPvDvBjaUPmaDckxIYvjvx4LehM6tgV5SzmiFSDEEs+s1nP2J1WDao08R6UuMjniHl8bKDsQ7wTUXcxcuFXLSzFZFcQQ3H+C/LVlE1QIdc3vo9LiU+fmV3KZoUSizX0J49nMKsbmSMQddDtCZyP4yhbgR7Kpocs35j+GzhEK7TJiStrEM4gSccYKgD3mSem5DRkegzJ5AAYDFpvdwnEnM4vYtyXRruds5nfrhTgCgqkD3Zhyd9bpWgW8UmV5bY8AmTUn6Svq4Tg83BfwZlmeFNKQEz1diufePoxl8UepVop9+tFvcMsfAj8ObVdkRU7TGMQpsxag4BHiBOAJMaBKwyvG2Z2I9fVNFV6UIJT7a6Tc5ntCXjKI91k3hJsiG66Cma6pAAnHHTbkx4OCZHJHy6inecAc3uoiB/nK/WN/K63ru3o8bxC0M8PH3H7wPcjpzVAIiaG5/dxhKioFA9KE0ou2p+eXs4Gt3+uqobVYx7WXt3u/T0AZC6zzgcdKNUHsqzBj8xto35UqBxY9GXOOHrPfe46LBBT0nQ4OADo9Lm79Mu+y5tH4P/09yrzZa1vC8AunTxcEuOxxosH5YfgO1u6QE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ebd13f-f4d8-4acb-6f1a-08dc1cbf412d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:31:34.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfkeBu8jtyxjvMC5oB/CvE42uf/45T/QtduHywpJtkp2hkobUXuQ1vM7Gu9wzI0vgY7u1GyGlEM6VUZHgolDg5bn2PYvlGvs0LlpORL8l3aolHNuQLh5EVTft7V7BQKF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240067
X-Proofpoint-GUID: dKZLwVooVTlCZBkn5pX7DXWaTLoC6tbj
X-Proofpoint-ORIG-GUID: dKZLwVooVTlCZBkn5pX7DXWaTLoC6tbj

Hi Greg,

On 23/01/24 5:25 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.306 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
> 

Built and boot tested on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.306-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

