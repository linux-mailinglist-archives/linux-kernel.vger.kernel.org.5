Return-Path: <linux-kernel+bounces-48181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62DB84584F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4166AB22164
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFDC3A1AA;
	Thu,  1 Feb 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LjinAYzN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jjaBDijV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9D8662C;
	Thu,  1 Feb 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792275; cv=fail; b=e1nw1bw6n1aDc9Iy9C+o+blRRptPCE0I0yUoXPZUqfAaQgPMgSS3zWU/HuK4vX5RfXAWRbF4BjJAcx3XcGb7fwAjal8tAAfKB/C6B1odnKi89OW/0iUdQtPZw9lpxN7U8Bs5KYG/X0rNFwOFC187F9aruJw9/dY5iVJcavOXGRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792275; c=relaxed/simple;
	bh=1M6+zDbq3yiqiuzEKBIKzmXk1FOZBmBaV8DKVZ3NxCw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhbSAVXirI11RnmR2tiCzGL7/rwkgJ4iwSkbq36BxYLOE8fyOjXHNCIMfAraCsORvbAiCTgpjzDcUVRqjoD59L3WC7+oEAqzDxHHnVMPYN0hxuY3eZOFhakCNZW+gwwuRtCDdZ8AeoA32tzCv4Xn6dUMYF/VJ3X6PeV9n/l6J80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LjinAYzN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jjaBDijV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411BNxkJ008951;
	Thu, 1 Feb 2024 12:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=hyz1TsMj9QgrlqN377mzETXVOCMt5X4jGDOAJNyAnwA=;
 b=LjinAYzNaSqi9qstl2HCUSWKQaNQDn+6tN7BlnmGvzt9zTrMRuTpOyLCMw4TBuOLEbGF
 GlHV6BurC2uMp0+bdaHfSGj2zw1NcTDgYre2ycPFo+L60Zbv4P+8jE3ySDsjdcmMO+y5
 dQ2JtUZOEaP82kqqFFJJPeu5nxVzS+pDU+J1Gvdx0ZO/SzNCjnEKVa5WnRPyQSyiGgCG
 Oec6TekYY8ST6uMgvWc8/4ISieTdG+WKVfw6atHo0/Ab7a+NSw+vQbnCJ0J0coSbCtQh
 IcpfHSgEjZNLdRFuvFqjLnRZzIGUFa3WAmzgV5A5g4b253V7BtxBMRPNbkZWCutotEdO ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseumfrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 12:57:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 411CMU0Y016357;
	Thu, 1 Feb 2024 12:57:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9gkft7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Feb 2024 12:57:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4QxevnSJ8s32lOdhJBrX4BNNsBxw0Bik0yDi3lLk5cP7oFEqtkzPqgV+EY05EIMs7rnTY2qiDnpmI5ZDFuuotgPLFDBCQhR2WZJ+XklVYqrO8MhDR5ga7m7yev94N7SKMOwGGV8AKF02hLb6IWDtGd6MrMYCakc24gRXWEU8SJEn3egcf2xxyEfNatDa4nYWcxAtPf1R4qfzGoXf+uMgcmTovqbC7WwGNsi7k8rX6KyUEC2NF3p2KfxzEE6zPMnZcGzPeKfrGiu+2LbigCWtfWp9M2XzIjCE5jBB5Rp7u2LrHMvVClJmlrGOit4Z9fuFxwGb4NJV/5+e0ZoTwvfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyz1TsMj9QgrlqN377mzETXVOCMt5X4jGDOAJNyAnwA=;
 b=QVxXiMmyloFq2sQNEy4YoE5M911Ouj7B29Fp5yZKdyq3xqW2B5MV4jsN15tqFMoGUrlr0f146dLUaFtFV5RCpXnL6DNA0PbhkjRDCXEF1N4ESMpOh1+bFmsyZGe2xyuab9GtOATiPRhXxVSYe212h8anwgjwWnxtEGbn50xh++UgP+ZI+P/qWnn0VZGJf/hn3yKo5I81duU4rH9Nfw94QMF8Ir2yaB+4Wod8gmsmHmn9MFwylDvHvCA/NuTfg2g75kt42Mm62UQKw2PMhRnJszS8+1Q5O6zJY8EVLxwIGibqYOg/br3US+CdolbUckj8rUZUWKfbKgxqjhFVzs0/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyz1TsMj9QgrlqN377mzETXVOCMt5X4jGDOAJNyAnwA=;
 b=jjaBDijV1f4DWaCHG/yS+hVhNvkmPG2g8vWSSTohfWVoexfI22Fify/am1XgLoOluwkegFcbeY1bm/aRTo1z3YQqk+ph2zobS1hFxpVB8qfib3EOfQ0+8ggNNn+Dbuzj5Ib6/ccmckZlR75YSHkRkuruHh2yCtWi9rhyHhoJf3A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6407.namprd10.prod.outlook.com (2603:10b6:806:269::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 12:57:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 12:57:21 +0000
Message-ID: <fa2636b8-de7c-494a-bb9c-d1a8cc97f6c8@oracle.com>
Date: Thu, 1 Feb 2024 12:57:16 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH RFC 3/4] net: ethtool: Use uts_release
To: Jakub Kicinski <kuba@kernel.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, keescook@chromium.org,
        masahiroy@kernel.org, nathan@kernel.org, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <20240131104851.2311358-4-john.g.garry@oracle.com>
 <20240131112432.5133bcaa@kernel.org>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20240131112432.5133bcaa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0081.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: c4e35f3f-222d-493a-c149-08dc232553ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Q0FWj9X1V5eN8w3DKYprhEhtQml0PSAgl3no4SB+XGcSX6QOXQzLBpMVDBsDNgAGxuaY7Rikm3LKgv/lfJ4f551oAkgV6n1FAAuuGapTwllYmBIsUfxbuEmDajF6lzCnkcKbxihBnSZ5dPJDxLXogiIBcZ24/jpkKjzjo7+hQuLr6Z5fEdRFWZUF54+tO5GAFyGd+uPUxSGZTY3snFkUdtkD08d1tKFGcBgsboJCI9n6wo/HYeT+8jQKUeawEIPr6RsN72+2QYrKM36n6fzbRJN/mOm6YMsh2VvwKcLKsCEipdrOpnULr21aGLBEwxd8sza/pxfUByeEKkrf/i8v2QWQoUEipqQIHd5FXSGZ8bpCnXJ+41Bi7THI72cfzrhlPLl35njz4R3OoReGOrbWonMzVD/bMJD/Utteh2p5FE1VLTsinfffveXzDx6418pymRvw6Qp1L9+NyqD7N6bsQElby72oc9i9ooBWCJe2SL1TLqsiYsSBAOg09M9Zy7ig5GTkQLKIW/+l178XaHS5HYBcFXpP62sOo3ejQ2qCm0jdzKYI17/Bhw5rdhSth9H08AaOQGUhKIB5XlofI0bCV+ufXemxYoODYWDr9YZ5AGFIq+3hWtOPpiBUiwSle/IKATzk7/B8RQLzkGaPrb/hWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(8676002)(66946007)(6486002)(66476007)(31686004)(66556008)(6916009)(6512007)(478600001)(316002)(53546011)(36916002)(8936002)(6666004)(6506007)(4326008)(2616005)(7416002)(2906002)(5660300002)(38100700002)(26005)(36756003)(41300700001)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzY4R0dnWTdlTjhtalJWa0w2amVxZVdnN0FsOUR5TTJWN3Y4em12djdVUmFP?=
 =?utf-8?B?UE1oK0hzOFRaaS85aHYzalhyK0JDNjlEUUdkbDhySVVtTndQUHB2SjV4TXdn?=
 =?utf-8?B?ZllaS09uYXAwWkh2eHV1UElwNkxvT0R5TVhleTJSTkQ3S3JGcHZZTE9oS20r?=
 =?utf-8?B?OG9RQWhaUURDSFlsOGlsSm1iWkdkUGI5ZU83ZGludlJvc1Z6eTdwL3ZLNjE4?=
 =?utf-8?B?U2g4N2E4YkVYbytWeVBHUVBGdjg3VXBjRFBIdEZFTU1KUHZvRWVDUzJWMjZN?=
 =?utf-8?B?cUx6V3BMZ0Z1NmNVTnM3M05KZ3kvendyL2QzcmNBZ0FTYWZJRjErU2JWdWhO?=
 =?utf-8?B?dnhWVEJab2tia3N5bjE4ZWxzVkp0bzZPWWFNdkRBamF0L3JYcHNWaGNNNm9R?=
 =?utf-8?B?dkliVEtzQ3NTa0V6MzltcTVGYVY5elN2Y1hSV3BCcVAyYjdpZ3hRelVZMDZR?=
 =?utf-8?B?VURCTEZucml1UVppYTM5THhCc1NlUlNMN2pROStRQ2RyTldtMFU0K3RZaUda?=
 =?utf-8?B?WkRpMVY2bGFpR3Zwb25SZnRsY1VBcldSMTFqa0kybktpeXVlYXhlODd1V1FG?=
 =?utf-8?B?dzVkMFZ1TlhXdnBCekFGMmgrdldBT2RHZlNpcGRiQ1RWcVZPa0NiQzZSV2E3?=
 =?utf-8?B?SG5mbmZmc3NZSzZKYUpTYW5oa1dOeDcxK3hVeUtvUkRpWUltNmtWL3NMTXRB?=
 =?utf-8?B?bXVkOG5uUVJMRHJPVDF3TnVZVG9HK2F2Nk1wM0pWWVFhN1dhamhXRVNtRnh3?=
 =?utf-8?B?c2VRSEtWL1ViN1FYZkFjdnFXZFpHa2ZmM1NKV1dwSVhsMTgwSkJmMTFoaUFV?=
 =?utf-8?B?SWFmUjNHUEFuSjhGWm90a3hLcHo2dUtsM2VrRHZuY1dtYVBuTjBYeDNleHRa?=
 =?utf-8?B?Mk0zcEJpNG53NDM4N3FhWUpNc0s0bW1IWndKeC9UbG9jS1NLTVMrNUtwWE5o?=
 =?utf-8?B?R3NsMGgrQjFnL1p1VURtaXFtbjRsTUxEQndNb1NVZE9Sc1N1Z0FGQS9iQWUx?=
 =?utf-8?B?MS9ra2dsT2FGS1JrcFJpTjl2S1Zmc29SS215RWtkVVh6Q3hIQVE0dC9YUG1q?=
 =?utf-8?B?c3lGSC9mWXpZNVkvNTU0WkRnTm9MWWI2UnBlb25OQkNya0FESDBPcWthUDRR?=
 =?utf-8?B?ZlYvaVBmUTd5SHlxUDBaeUQya0dnN0VKTkVNVHhxN1BxcTVYaTRabW1ZL0Uy?=
 =?utf-8?B?TzhYUWpPYlZFVk9sb0NDdjhMS0l3YWJ5TWt2K0xjTmwxdnhoTDVUUFNtV1dU?=
 =?utf-8?B?SGhJallTRm84Qkw0YTEzQS9VNGNzWUQ3OXhtbVB2YUZ0bnFvSFRKcUIwK1ZX?=
 =?utf-8?B?eVY5L2dRZUZ4ZnVXQXo5b0ZMVEJ6bGVSQTlEeFluZlRVZnRvSWZhb3M1ZHVS?=
 =?utf-8?B?aUdxWkNWS2VmZUZpNXdLRXJXb1Z4S3BiMGVrMXZGVmpab25MYVM0NXFkSVJo?=
 =?utf-8?B?SlU1U1Mxc1VvUGc1dTJ5MlhGY1d1TWJCQi9TQ2hBUEdOdjRCS2FLaVVRSGlO?=
 =?utf-8?B?c29COE10b3BnOTJHU1YrdW5RQW1FYnlRdG9wWnN0aWVaQ05BMVIxUDdPallx?=
 =?utf-8?B?ZlpoYVFiL2d2TSt6dU1JNStWK2ZKbHI1Q3ZzcnZXaWZmR0ltUCtML1FrOElE?=
 =?utf-8?B?bmc5aXEwNHI5UkVyaDlDOGhKOFFFUno3Z1ZxNUxWQVUxYjhFQjMrSTZsdU1Q?=
 =?utf-8?B?OE0wU3hmZC9NOXhDelFDRUFpNkZnQjRpODBmU0VLb0w5NExDSzJITG0xaTg3?=
 =?utf-8?B?VVMzL2ZTZFJUNUE2Rmh1cE1kSnM1RldBd3E5QWtyNHc1cTlKOWJacWM2QWRx?=
 =?utf-8?B?b0IyNC9ON1NDemd2Wmh4dFhsK212K3drakh0TEhHZlA2QWZ5ditrL0wwajlK?=
 =?utf-8?B?aVdRUGdoVy93ZmJMcmpkZHVMUTV3dFdqMEc1OEdyRkNzTlBieHpVaDAyRzkr?=
 =?utf-8?B?VFFoRVo2MVhOVUdmVEFRWXdySVBjVGl2cUpMQ05pc2RBV3dGSy91UUFTNGxB?=
 =?utf-8?B?VUsxRjlSTEJSelJhMUxVeGlZMUxaSmlQVnd2dlQ2Wk5CWGdkTGpFMXNaRGUv?=
 =?utf-8?B?V1lkZFVCYW5pVGt5V1JCOGwxNW9TcjA3Uno1Ym9yT3BJTVBLL3l4bEhVN28x?=
 =?utf-8?Q?sUuzEn+79Xurh/LOq4GKjRJIN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XhVBMEI3nuNAlQHWtUbFHPCr8ANXyr2t/ZFP5vHvntlusNF6oK2srPymPJM0BPOLWNqQjF4aJNIXWxeYzk0WDqPoUCf+zGV6aoO+H4hLCXNWx4poFKQ8/G7dQLdkAcMjprGEtNef/vjPM9GFVqyAR9N0rGU7YMatk4tO6bb9tXRbHN9JQSbGK9nWuV/tPKs1xpmlRSiFx6s17B7X0L4jWQAkYTikNdKbEKL8EdmS3rsLuwmlZHD53xT+aeW0qHYr06dmpE5rkTXHjMdqV0E17GQGszFOuRnu1qHpcNiF1mXpYuWO+C1SJA2ky6yRo7RmPajB5ACOrSTnznIvl1LQd7ARXIGNcOEOsaYNpxuSBbFFNfp+i/DyuXxmqk1K6YxYDditl4kjo33OADg5XvLFXI4h2G+FYeQ5UUEtgeDqpn3Z9Vh4nzSGVsCy8vJG+jpOvVZURZP5Pr4HPWgk0lTuEIj8O3dUThRC3PCpzk/ykJTHvtNSE8G9gNFKGZEsgr1L5oTKgBTgRIwxOOvmF/UbJpGArLKeldi8OI8T45kwm+slry5P0Xpp7iWgsqkerxLXKge5WPn57K35CAH/MkAhhsRhenjCT8/zM0uOdpX7eCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e35f3f-222d-493a-c149-08dc232553ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:57:21.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61s3hOn1Dd5DUhlmrDTm0bie2Fh0o/Ey+xwlOIxOp4lFrat5jsw4owmbVCoa6igF4nOAWs9DFzB+1G26j6vZPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010102
X-Proofpoint-ORIG-GUID: 07GHyVhXbwjjeDkVqGgjhdwdBZBmCt4V
X-Proofpoint-GUID: 07GHyVhXbwjjeDkVqGgjhdwdBZBmCt4V

On 31/01/2024 19:24, Jakub Kicinski wrote:
> On Wed, 31 Jan 2024 10:48:50 +0000 John Garry wrote:
>> Instead of using UTS_RELEASE, use uts_release, which means that we don't
>> need to rebuild the code just for the git head commit changing.
>>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
> Yes, please!
> 
> Acked-by: Jakub Kicinski<kuba@kernel.org>

Cheers

BTW, I assume that changes like this are also ok:

--------8<---------

    net: team: Don't bother filling in ethtool driver version

    The version is same as the default, as don't bother.

    Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f575f225d417..0a44bbdcfb7b 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -25,7 +25,6 @@
#include <net/genetlink.h>
#include <net/netlink.h>
#include <net/sch_generic.h>
-#include <generated/utsrelease.h>
#include <linux/if_team.h>

#define DRV_NAME "team"
@@ -2074,7 +2073,6 @@ static void team_ethtool_get_drvinfo(struct
net_device *dev,
                                     struct ethtool_drvinfo *drvinfo)
{
        strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
-       strscpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
}

-------->8---------

right?

John





