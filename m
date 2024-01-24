Return-Path: <linux-kernel+bounces-36716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6783A569
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D0B22DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A117C65;
	Wed, 24 Jan 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hok6C7Oh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DJ/Sp6aR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DD17BAB;
	Wed, 24 Jan 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088481; cv=fail; b=jUwbeoBk7nIkT01GC1xPXiTJaJw+6uHIx1Skwnk5HQJhXe8OwCZCPpvtfdrdfjwWUnx6IdAaaLSeYVqt+W+YNkEiKie2GIzn6psM86+D3lvnsBXNTzZ8ltYsaVuSfAgs8mybw9reMZ8L26K2rWww59rGxpCnNfPViDtDbaNPH7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088481; c=relaxed/simple;
	bh=u48LIOUnnDFWwswJw3VZz5u0Sc+9e4OgmxcQqld35Z0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMl8ctKO89D81uXLd67JMrlth1f3HT0YuHL/gwBqNTF8PDnEKelZZkScwK1ThSD0fjSg4mycU6gnpgUzJW9LyZCo2XDSUBvb1CIpgwlGLGF31FfMcfoP6dOMEb52/d/siGaK2GwKiNzBJql1UnYqPxY9uJ9XYzrtTtUg1MFu9fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hok6C7Oh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DJ/Sp6aR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40O2xAtX017362;
	Wed, 24 Jan 2024 09:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nX6gQqW77JZpox5O3GBZfCNDb9UXpSPcFwspWROWbps=;
 b=hok6C7OhQf2o06bH+eCM8leWFGtuo/onpKMijEONhrzd2FLE7zS0eZvKwK5ykxC0uaNg
 xPX/O6mqU0h07sHNvv2N+d3sq71q4J3ItKWOC5k9TqanzqIJyrOvFdNVYth+7gKNFSID
 E6FGBdrMhrkRP7kxKLBpVijj9smuQQKjwuMCZ0HGJnnE4/lhRPQhKfBe02c7ChQJE0ZK
 UikkbtD1Jo8/YjXc4uyv9b09xAfX7jj3ffoe64n6ZASmyXXIxxFya+MIfc+f6np8vhQ7
 5GibJQ598hcWBmjnretFjndY3mjuZ3DKh8nIvfuxzM13i7hk+qhia0r151JNOjAoACDh BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr79ngqs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:27:27 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O9Hgap005410;
	Wed, 24 Jan 2024 09:27:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3726ra6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 09:27:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEdJ0tUeJ0IMUAeupKLeMMyVzJQJ3ke0tMkD6bd0u9EUhC/xA3MZUbAezr90gja3uuhSFHbBJGk7NGgUC5Bq38qUwDPgjFuDOaTs9fWJpjkTN47iddpog5QF75LjyRTCIXKCBnsi13RFAEiVieUn+BIY2QKEu3TR5s2u6kk/tglL8WyDbaf0RA8daHd2NilfOJXS12mlIF+jK7HDTpV6ie6H2UX1aTlAFgXOUyIa2A19q7UaW7aqHGLdb9DsCHQBVJXZWb2FOCQlNmTZ/A/AHGLRAiH3v7CaPlQMnpmM5jx8xpygYUBQGJA7hEFTA/OTirZhTHFErkERwVbmgkY1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nX6gQqW77JZpox5O3GBZfCNDb9UXpSPcFwspWROWbps=;
 b=f9+hDepP7l7ROt53gXtlvKzUdTSRbwFj30KPN0brL21PVAA+joGi1bHS2SZ9N3veIoFMgwKp6wTuEv/myf98PQsw5hw6pjpAsbIvPL2yaSxFq0dlroMqWDvuTKcZAExNZJmLKmciq+tKQvIUNO47qpMAv6bA6/EqWcELwyn65DxV9Qr4vsXnD1MYLJDJCrXYjjXuv3uyneIkLTrgOr+fWqvO4RbtaPimDCzUisNUMWqBcIhklK00K7sATJYZ+kYW/OFbmrz3Wj+g0KtPQ0b7r2T2xlOvc6c+HPAeg83nTOlG06vAiNhIIG59a2/cVb4M1p8xGfoEBxaeI5NJnpcOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nX6gQqW77JZpox5O3GBZfCNDb9UXpSPcFwspWROWbps=;
 b=DJ/Sp6aR1OPK+aQkCSG++zi9c9tzzmHvPAgr97i8G0Nxy2mtaNpF2+bkp97N7JkNyCKNX4gxetDNC9OPbLM2FaCDz0fd7lR4KdxnGQOg8Y+vibJcBEcYrUaTWZVQS56xBSbb2e1aXBc89dTDSxYxaGl22VXvrxctFOmRrKWxrHI=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by DM4PR10MB6767.namprd10.prod.outlook.com (2603:10b6:8:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 09:27:24 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::f41b:4111:b10e:4fa5%4]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 09:27:24 +0000
Message-ID: <6e844108-0f8c-4b7a-b04d-4f237a3425de@oracle.com>
Date: Wed, 24 Jan 2024 14:57:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/583] 6.6.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20240122235812.238724226@linuxfoundation.org>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|DM4PR10MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e60b8b6-5d94-4b82-80cb-08dc1cbeac33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	50K5wQJtFcKMB3AckIcBYqXzbAdPqkoN8illjgQYrYl1PYRqIMWarjV6uA5TrKFkrEKItFTbUfUQ5h2rYD4LtL/drp8+cAruiOPWJmJ6L/9cXBPkPBRJlyU4fK7jm/T6ZE0IAHmTFQK3Xe7ailMYX1aNWGz7d3n6cVBBhTZNex5WjOY82fS5ydiiUQOpSLu/66q81l4+PmLlNT2+Aue8fmxIXZwVD7UQS3R4qjfo5OFDoKlCDK7YThmVYeaIUoEHBkaRkpGFCnXq2Xl9QlBFcjrlTPdteZlhBQZzMNKFzLI/fbtyv9DER7f9j5zOQ6H384LEVll38+OEjTCCCfvCByEiS1bJt9K24/VVIVwJmxo2MErTUZ1zPONFg/pyFUFMbgost4aXSVoLtkDwWTmMV3EYzfEWuRd/8zotjBwZvK+wZYrNMCH8tN3uPGP7nz3rypIPx+OKTH1XJobzeVA2JV69NhjKF7yyvGf3+s65xo+S2syjxOQ/6/P97Jggzbby0OVUNdxHnicDzZdBlsgKLR+eyLgm9tJuXtMVfjXVOdO43q9jER1rRYpYXmMkGG3Q0+LBcossts9KTHA8GXLpzCDOBMFyOILJ79kTZihQVQ0m0FR3c4ZfG/WXnhCnG4VnvC52Gu1fJhFXULQZD+ja/A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(36756003)(38100700002)(31686004)(107886003)(41300700001)(6506007)(54906003)(5660300002)(66946007)(316002)(66476007)(66556008)(966005)(6486002)(6666004)(53546011)(7416002)(4744005)(2906002)(2616005)(478600001)(8936002)(8676002)(4326008)(6512007)(31696002)(86362001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YW1UbldPOVliZ2Z4aFREN3JoSFFYTW9Sa2RMa1hXK1RBckRRSzdsWVBnWk16?=
 =?utf-8?B?MVhuUzJSd21keCsrTnRhODY5Tnp4RHpVMnNJd3lIdlJpMWV6NE9wTHhPS1JX?=
 =?utf-8?B?RVlnNi9VWHNGSmFEUkc4Z2taaHZUOUI1MEw5aWJOMGFWMXp4TzcrcmtIc2RP?=
 =?utf-8?B?TDNrYmZRa2NqL1Rzc1gxRmpsbGR2NFlNZGhWRGtmVlVRcnljZjk2d2srVDNk?=
 =?utf-8?B?MDdtMDdTR3dnbHkyYk9Nb2VrS3lUL1JtaGk0M2QxcjRpVmxoQnlCNG51L2lh?=
 =?utf-8?B?U2NRaXE0ZXU1QnRHV1RGSmNCODl6cVZta01TOXVWNGg5TklFaDJ1QytoQjBm?=
 =?utf-8?B?T2Uzd3RvTWhhYThqdnVZVGEvcGJQWlNPbVNZaXhjMUZWbzVLRDVpbkY0Q1hl?=
 =?utf-8?B?ek1XTHgxMnRTR2x5NjBKbmJ4MzZQME1oR0Y0TkhycFB6c0pBZUtiQklBbi9U?=
 =?utf-8?B?SjlLWlViVGx2M3lUMUQzZjZPSzBEbllHaXMwNXdSY2Z6Wm9wSFZXR1pKSXJD?=
 =?utf-8?B?T3RRMXpVTmVNNjRkY0hiclF0Y1ZKT2M1ZTZ4c0RmR0VLK0tRc3BReFlVNWY2?=
 =?utf-8?B?ZFNEOVUxektZbXJVZml6ZXFwYU5VUHgzL2gyL2V6b2RidWxCRVUvZ1NVaDRo?=
 =?utf-8?B?S2RuZWo3R08ya3dYUWRuQ0FtR0Q4V0FoTHgyZmJXVVZxL1Nkdk5Na3M5S1F5?=
 =?utf-8?B?cnc2M2pLd2JabnhiRVNLQ1BHYitkVDhEcmpRcDJLeERLSDR0YlJIeHZHN3VK?=
 =?utf-8?B?Ulh5YmhWUW5mdXdkT05JVXN0cmdwV3dYbFUrb2doY0JWM1FiQTFnMmxJR01Z?=
 =?utf-8?B?R3NvMUQ2U3EzOGdRdUN0ZmppVGNXMy9FSDVXU21XWFl2VmZCRUN5a2F4N2hF?=
 =?utf-8?B?eENRQUorNU9CbUpvbmlNemRGb1dDK1Z1V3pwa1BnUE9JQ0NITTNWaGdFSGxZ?=
 =?utf-8?B?cGhwYVpReUxCdUluTFd5QmRtU3l0eW9WS2M1RE5ZUHRZQzJIU3Zid0x5UTl5?=
 =?utf-8?B?R1J0MVdDMS92ZnRhajRiSE1TWnhCNFZLUHJpYWhRb3dFaE1NUkpndnZweG1i?=
 =?utf-8?B?b1JvZ3BZbEt6OE0xT0JvOXZJN3NNdkdMdEZGMzJZaER5Q0xzbm9QMm1BYjgy?=
 =?utf-8?B?Z0YvV0MyZWVnaFM4NEtTd1RoV01wM0k5ZThmRUxoSmoxNjl5WXd1eXhaVVBu?=
 =?utf-8?B?YXJrTUI0eURyNzR6V0paVjUrdDlaN2VTbTJHSzk4Sm5aT3BZeUJPWnJIRFFs?=
 =?utf-8?B?elhSUGdUa3FhOU14ZWlZWW91TENVNnpscFplRzh2bm1yVnczK1ZYN1ZrQ1V6?=
 =?utf-8?B?b0cyTXA3RThoSVRPWXp0TjNMbTRRY3hpWHlRbEk1QTBhUFlYWjlCaEc4ME9X?=
 =?utf-8?B?dDN6UVhxcHlRaVAxWnlraVZHUkNibzIzZldDeGJWaUZIaloyY3BvNkhpZ29N?=
 =?utf-8?B?R3c1cVFlYTcweUQvUHBETEFJc2ttMFNyZkRHcGZiMVJ3cnV3ZmhtL3VZYVRS?=
 =?utf-8?B?bTlOVXNpemRVZ3JCZzVxWGg5ZUR5SWFkTmpDcE5hYjdMeWdVSURCTmtoZnl5?=
 =?utf-8?B?ZEpNZEVEakRvMllJVGJHc1dCWXhzL3hEaXRzbUpKR0V2K0FUMEhoVXhSZk5m?=
 =?utf-8?B?YlZQYy9NSTI3MkxzN0dNSHFDazdFWGo2WVNoM3ZiZXhOcFkybTl6M1NvTEMr?=
 =?utf-8?B?QWViaXFPZGV4S3l1cVF0c0tEY2JqOUFhcXBsUDIwTUhRdHRUQlBBc2FORFlL?=
 =?utf-8?B?dTZ0b1dMT1NyRkZ0eHpLYTJkR05SWkVoazVHeEU5NHJIeTdNakdmbklpZVk0?=
 =?utf-8?B?ZWRDaXRlalZHV1J4WllBTGR5YXVzcGRnbTk4MTI5b0Q0NnJlbkJzWWNzU05U?=
 =?utf-8?B?dnJqckJYTXJoYy9zekRUS0t3eDhncFl1WDFRV245L2J4MFpyWVYzOUd1TUwz?=
 =?utf-8?B?SUN2ZUpxdXpjWjhydzVGTHpsWjFvVHVma0NHZ01WdHJqdFRRc0VxZEFsQjZn?=
 =?utf-8?B?SXU0WU03Z0tLQitXMnRsSFp0UVpnekhObGJEd1Ywc1BYU0dnOGxyM2N5bzhC?=
 =?utf-8?B?YkZhUnplcjlDL09FZHErajROUXovRS9XdENoY2tXa3VtOXJVaWtSM0hRYUhk?=
 =?utf-8?B?NW5jdEhnUWFHVUV0MHVRekNQZzlrSVZoT2VDNHprRUFmUHIvOW5JMk4vSE9v?=
 =?utf-8?Q?g4MYt9SZPlG3BNNyHs0FSNM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oF8NC5JbEHUAU84xC/a/CYrryrqt/scUV3jSxPkAcyqCFUtZsaiCuqNGYSUVDuuvsekejG2oyctIEioYoliQ/FTkJ3F3c0ajFmKPqmylhkY/f8lHFA/fR1ivUo0fCoCqL88Mu9ZRJY/n4K4hm9PCegdxNCGc3VUW20aPnxYA0nt7+Yn14TkmmyRxuHducJsWikj6tLsGQOXiegPwkh1dTV6qQAt4ZrhLndaXiidn87NgnShnlvsDiIpC21gVg+nX8Zq9igknNzZEO93HvUAgEvX752fNNXIzXEVFrYm1aJUf3whB+GpRTREDTWQAT2st2lACjkY016ltF6e53ZVjELDiL9qimzpnuO6sOmV10okIiAwsfUpJViuv5GB+yqOq7FsC4a3032EFGaruo2/88JxrZ0yyjMOAVMYy1EK2jq8q2Z8z9O0EkLKydBOUYh4ovCo3gdVU5qMMfqMi1bTaJo/C6eE7hnYGi0fmtdP1LXL53hMMgnwL4d8quVK/PpsQu0ZGmTqUDg13yBixEXLMnGbzmzyAxqDjY0O7tPP+bWqHHU1HjLrYnS/gLbJ0UVmsvz5b8ifLPJGKSrXNqMFekoAodmUq3bah3mfSi5yccrI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e60b8b6-5d94-4b82-80cb-08dc1cbeac33
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 09:27:24.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7t42S9wNKvGUNLg8gVp0YyRtcaky2zbFt6uSrpZeDFHEpS/XKOpT3BalEkSnAPBOlvv5gRJ9m65NxoEDry0AbKr5Saqz5gfpf0pAUmgXYo8/5PQXc519qx/Ya9uSZ4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240066
X-Proofpoint-GUID: kZkEG7R96hm1WldfTU7JlGRDHU6I0rjf
X-Proofpoint-ORIG-GUID: kZkEG7R96hm1WldfTU7JlGRDHU6I0rjf

Hi Greg,

On 23/01/24 5:20 am, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 583 patches in this series, all will be posted as a response
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
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

