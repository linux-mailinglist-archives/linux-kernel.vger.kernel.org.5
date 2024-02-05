Return-Path: <linux-kernel+bounces-52203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF8849552
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B7E1C212AE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B243211731;
	Mon,  5 Feb 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ktWlBMjh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="svmHNUHd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C531119C;
	Mon,  5 Feb 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707121549; cv=fail; b=q7AE0M/RcT0O/eVLS5gTJq/TsWcLO2m+qAONXZ/LbRqFVvhRYbIZ+NVrZRPG+7+8jHXvFBwFLCddKtmvPsbES7WwUHVA8vTWRrDQJjB3VR/iTbNNFlGR4P7/Lom2xzzKfhiCwKDv+uIQue64jpQyQj2FOvr7AghRqOZOmzaH+A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707121549; c=relaxed/simple;
	bh=OeDC9VhmFyqjLy2aXCumDGhmhgGTXk2e5a0R3zt62y4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ayuvXSgAbG8GY/EDF2b/hNVzF6FLtUOCQXE22plWpOie0d5Cr3eKtTr0U6RZmDbYnWQo6bYlorbklB6WES+DHqYa9+62utJOSqc+cX6A/c8Q1ffxvgyhg6nMHyPERQwrIOMjqf/U0/YP/i/DGdPfDf99Ts61y9Yeu3lPZ3hkjy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ktWlBMjh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=svmHNUHd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 414LwXW5032611;
	Mon, 5 Feb 2024 08:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=eGewBmwXtv5C/5uSsIZXt8DBL0mTiseH5Wu/hr+4bHU=;
 b=ktWlBMjhmsxvShyRiOujoaMvBScI0CFQJ7nF84cse+PQxZDONVtz2MA6HxCz5+3VAD7o
 bm/BzG8qxhEEEyBGhgzOmS3frYZ1QUnrG5/SuatI7cNKv3JmDL25ySq823lq7BbD0GTZ
 sDJ/n6vsaYXphF3bQvpbRToZU28B12QrUyr4xLuQExHZ72dm+qgTN9kZunaxeb4whrMF
 zxQLcjodx8t9vpLpgThLWArpo+N6rIARTZP9VYpU3F0s3jgeN8OkSmT2fAhWl3x6iB0T
 Ii0OLkOwcCC26Q9Kmz9kLOs0P9aZJECE7jep3hZ400KTtb4Bu7FfmmWLW6wUaQGR7wok BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdcuaww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 08:25:20 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4156saFg019715;
	Mon, 5 Feb 2024 08:25:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxbmx9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 08:25:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYfiBCv5XkTDivvBry8ZMdpKD1UCcM6kIid0Sd6GucSwb4WBxzPb4zWSWLIerLh+qo2JaIKRwWfJhfgcgEyUaVNDhKBK/mA3MdswIWGfIM2FrCZllTXPHbl/TSGH3KESTFzdUdxp2fxNID7I7zKHrwuinmR0GHM+d/imbXQk5Ez1iK1kDWQS+8zXO3Tyqib3g+OEmeO2RM3BRZy88v4v2SpLfiMmxTH9syYTNqIUsTJW3VGnlZ32yF5UlbRomV7RgNlnyj2sGmWZbHGB64Ts7EroVj3WDB/tmXL4dzIoVldsjq2tB0aJpfIL37H9B0pvKoZT76XvJkSLX2fSBCtpNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGewBmwXtv5C/5uSsIZXt8DBL0mTiseH5Wu/hr+4bHU=;
 b=JSNELr3T0g+bk50Pu2B88groNaxIiUPCqq0blzLGdFWG9x5iL7/WoNp4yLb/76nn5hyv7RRxsveDShJ+UBJ+8cAMN3LanYtplE0QiHR/hXwoOIFVz+/FqyfCPKqXZnLz6LZ46J4KDZ99T4D83mkSC6X2SKPPgprDbdEv+LEunPz7/g6tz3uRjnM1NvHXcbtl6EMILhZ2Mu6iqPMFCTE+KWyfkt94GPQwgKudgg2TH57+SYHf03Iti+wNCdX8F7ZcuUh1p8z+mciyxJPnjsSxrZGiq39tcZZep4YvgY0BYp+y6ouxYsBuT2+/tZHWDAogEuteEi8cDIrsoxXJZqZNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGewBmwXtv5C/5uSsIZXt8DBL0mTiseH5Wu/hr+4bHU=;
 b=svmHNUHdKisypkY0jBtkRJWPduMVC4ffsZlQr/ZJr4lGLwdXwP65FzKGHCZSJf4Ks3+8PYhOfNQyA2wXPekZpigWr7pKiGAvJFSqlon64mPoCCNAHj/uk+mxvcCUB6rO7OZnpuZ2kniDxOzo8Rh7J1r74KmTLrjXe6pP0Vp+qCI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 08:25:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 08:25:15 +0000
Message-ID: <23c67ffc-64a5-4e19-8fbd-ecb9bfe9d3ff@oracle.com>
Date: Mon, 5 Feb 2024 08:25:10 +0000
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        keescook@chromium.org, nathan@kernel.org, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
 <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0296.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO1PR10MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f40e3a-0bf4-4414-6af6-08dc2623faab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B2+JaCl9orfxkS68LwwE0QCOPQ6r0JlI/4DqFxMoB39Z8XG6PRW3EO/KDrlsou8qFtreGE/rseiS7vDWRQYCmlVF0cfnv9RuSWzbm4pDskqJr9j8mkIJZNnHvlr3GMEQ+PL2supgPNUH7YU6so1YybkixPVAEwgILTxPDjawYgiCqCD/pxoquAhB3KRYqiXjUy5NEp69Mckz+av0QqHKhhlE3hkhF9lXPOxvcQdPcnuVTJ5dOvhnHnQdIXgLiGF/wFp+eipIzPLumaAdy4ISNOikMb3VO3rYYlMknJbLPrym9kk8EGU+qgzg1cw+nQcFCoaZ4Q76DzrLYGVhxfmA5sMYRJQ1/kvUl6HrcdHUdOe+7HWgOBl/BzAV0lBND/1QWz6LPO7OXSARGnvjgQ1v+G1OJcrYb7sLL0ExRvnxdM6nVn8sW4zhg8wo68NSnEG/iK5N45R2pWvjvwNl399fbMWCRDfC4d1VxWwcamVy60s6OuDDGeu65yPf0bnwEliPntQoLhiLycXIRqfe1qjpY07iltnA/4Eo1KbquDxPx3s8A+EOgGFnxCBqwrOw58aj8ock8XqKUiOCD78u6Ig4NDppfPXBI/bUnZg9EZqe2j5j/0FiHBhQbJmCMCD0pfYJNAWoi+oho75flfnGweVG9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(2616005)(26005)(86362001)(31696002)(7416002)(6486002)(5660300002)(478600001)(2906002)(6916009)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(36756003)(6512007)(6506007)(36916002)(53546011)(6666004)(38100700002)(31686004)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUcreHRuWkVxVlZqazBQUWFjUHVmTmR0Vy8zQVBML1dtZU9SUC8yTXo1R3J1?=
 =?utf-8?B?ZEhXd1lpdUU5WU9wbWpWeEY4YndIRWl5NlF1ajV3SGpab1F6S0llU0FHK0Rx?=
 =?utf-8?B?YmIzWjg5RGtKY1ZQK0VNaEVNV29aQkNQbmxJWTZqbDkvbmdHY2JFanpIcklQ?=
 =?utf-8?B?SFBuVlVqR1VtUWp6b1VSQzQzZTgxN3k5NC9rV1dTcjk3dWtFalkwcGVmYXlB?=
 =?utf-8?B?anpUVUoxSkJKVkx1bjh0b2wxT0ZlbmtvVXhhSUdvMDNHM1VyOTloYm9vVzFQ?=
 =?utf-8?B?dUdQYWpRdVRJT0JpVUlXbXN4TlZsUTVUdmllVldtbldjWXdqWkppcSswWVRZ?=
 =?utf-8?B?R3JxYjFZY0M1dWEvVkYydDh3UmpORnJiNmdrOTF6RHhmR015bnFiTFNFdGhs?=
 =?utf-8?B?ank5WUtSeUZiSHJXZ0xlZFBZa1RxNVl1RUxFVXpseVk0WG13L2RYUXFFZXFt?=
 =?utf-8?B?NGNCTXc1b2FUaVpnS3diQ2dGb3Fmb3ArZytkS0RtaHYycGp0ZUJMTVlYUUZH?=
 =?utf-8?B?dk5nZ084Qm43ODNHcTZHeWQ3Rm9vSEFGT0dnazFkcUlSM05VL1hsQWtFM2FT?=
 =?utf-8?B?MmNjSjJDWUtSeWRsaXoySWdpN0dVV09OeW1CUWVrTDBPNktzQUtDcUVDS0RV?=
 =?utf-8?B?UDlydlNvU09EaEtpbFZyY1pRQkI1UDZxL0xkVjRzUnJoK2tidDVqZHd4bDIy?=
 =?utf-8?B?bXVPZGVuWDcxQlB1WnVUK3l1L01XU2Mvc3dlN1VzT1VVdG50Uk03UzJJenY2?=
 =?utf-8?B?OVZVT1dDQWs1elFldVAxaUtESWhOdlpEZEU2ZEZTWGtCSTMreTJLNzFnQXd3?=
 =?utf-8?B?OExvWHkwRkpPaVlNdXVMRzhkMHNYajJhTlJGNkxiTUR2YnF3djE1bHN3NUFo?=
 =?utf-8?B?Y3UxcjZZY3JwU0toMVZ0Zis5V05hVVpiazdJelF5b25NTDgwYm9iZk82RnF2?=
 =?utf-8?B?azh2RmdJbGVlbUphRWpCTW1zYysyb1lJU3l5YjgySk40SnpxV0JyNVBZRlpO?=
 =?utf-8?B?Vmtla1dZOEh2ekdLemZ1K0w0YjJab3NXaFFTS1g1K1FzQ0hEb1d1OTNxT2d1?=
 =?utf-8?B?dVV1Znh1Y3huZTB4S1VVKzQ5ZmQyMmcxd1Y5SnJpcUlKdWZYTlZpZlE4M093?=
 =?utf-8?B?a3R6SzJ3WGM0V3NjQ0NRd0NDd082REdvMXNMV3p0K1FXRHZRUWhHVEEyTFNI?=
 =?utf-8?B?UGtkUm14cjlpU2dHbnVEL2NBWTh4SW1lRVl0bjBka2NnemZmZEVFM1l0UXk0?=
 =?utf-8?B?OWo3eUNJWGhSa2pybVB0MjFKWFErQmozWTkveTR5OTdQaitEMkRzUG92L29a?=
 =?utf-8?B?cGQyNC9lZWdBVnVTYk91Nkl3NDlMZTFTelE3NGpjdmZHazAzVFE4VFk5V05U?=
 =?utf-8?B?d1lROEJjZTlxR0pQS2doNlFZYkhRZ3I0ZnNCQy9tNFlVQ2VDN2JvOGsxWHkx?=
 =?utf-8?B?cXo3SGh2ViswMlJvL0xZUlBuaG9OOERMU0krdjJ3S3p1U1hUUGQwR3MwSlVH?=
 =?utf-8?B?MFg0TzlTU1dSV2J2MW1xMFdBdDRSOUtlTGV5UnpRRjRHNXZYZ3hmbXNPaWkw?=
 =?utf-8?B?UEcxdzYvZ3l4dFh2NmRXQ0pVWUVLc2NESmM1T2x3N0RYWE11djdwYzNTRzV3?=
 =?utf-8?B?S0NIejY3MlFDNmUrYVhmakxMTk5VTDlJcEpubkpYUWE1UzZUOStLbkZESklq?=
 =?utf-8?B?Rm0wS2paRmxKeHNOSklsNVZiM1MwWDRSd29ydnhqYWRTT1pvVGEvc2hOL09X?=
 =?utf-8?B?RzF0bUVud0pDWEZSOGRpMmh2am5qZU9QV1RVR3EwOWxmaE1PTEh0YXZkckxY?=
 =?utf-8?B?QkJuMmU3WDdtRmoyQ2JVeXdWL2RLUTJ0Z01seFdhMy9kZTl0ZGIxVEZUSW5Z?=
 =?utf-8?B?YThBMDJIcGwwU2RhOTVKOEVadVNwVmRqVWxqeHVUT3VDaWZXTzErR25EODNY?=
 =?utf-8?B?dS9ZMk9CT2xGd2U5RHJDd1RKWVE0TkJDMXozNGNUcngrUld6Qzc1YzB4ODl0?=
 =?utf-8?B?SEpqblJjS0tha1pPTFh0cjdrS042ZlB5N1lJZzUyQ29BS0c1b1owL1VRckJ6?=
 =?utf-8?B?TDVHZmVocVRBQlg2Y3lyVXZIUHREY25HMHkrckVTVCs5dE5VeUNtL3lic0tU?=
 =?utf-8?B?emFBaURTNzM0aEZyV253aDB2OUtqZm1uMWNqRkdscEttNm94T1lKWGhTdm50?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Rx/p4KEAjAGg1tG8cRCarNmAtkvVN2z3pg5UcEpHubqiriqeCDu7Hebf0/VqWnJBU+UhcLhb51pcF8ehd+o+voU0K0BF8mYtIZ+heTk+QZCw+6wO5uq6tKOV38Ts5Rjqvdrdx984F2dGi9K7G/91+2hcbMrvs5ZOq6Jhvqo32Mvs5svJRZKiizcdsElQ2WZetKt9x5SHndfG9Ysf7UMsrVobJJeJbBBJoVp6ADNGeaeSfUX37obUnci04HooZLrOlgJoeFCIrZZI2RVzbDBPY/Qbo6Kb6tL9wgNOSXlzpPbfa9Fo3OKl/lW4hCgzAMAeWvzETxKYICVfVeLRhLdhTyCf3JKmPiTQ3APk0cF6nysX7Kd6/R2g2UgEGTXhlG2KzPLW+gcK2q2XRFT+GdkZieduvyjBH/pgtog2/WQ0F+yxPUGbsFoQ+QbHyhu2eD9wsgMwhkutMQM36jcjnwk81Qae/drsp+br0SLFTvk4Ev3Emw/Nfl08eNq4AJAfOLtMO0kEv/lQq+SAyU5GzWbjf1+Pu2DqlNCwSk7iV2/XeOlKMUaYG50FML11gDJX5jiir/ypAVhztrabNqbextl2BgQVBnFFSLrSVRsmDbHtYqs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f40e3a-0bf4-4414-6af6-08dc2623faab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 08:25:15.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ri/DOSwksmYxKiDZdsDSUfEbdcekuydPsvQ6y/fd9eNsMKn8if2ZtAKYkK75INrox6FlXTeYaWwg5QYhD2joZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402050063
X-Proofpoint-GUID: PzyJR6lu6d_sLv-xaAzVrQfrYRvEc86h
X-Proofpoint-ORIG-GUID: PzyJR6lu6d_sLv-xaAzVrQfrYRvEc86h

On 02/02/2024 15:01, Masahiro Yamada wrote:
>> --
>> 2.35.3
> 
> As you see, several drivers store UTS_RELEASE in their driver data,
> and even print it in debug print.
> 
> 
> I do not see why it is useful.

I would tend to agree, and mentioned that earlier.

> As you discussed in 3/4, if UTS_RELEASE is unneeded,
> it is better to get rid of it.

Jakub replied about this.

> 
> 
> If such version information is useful for drivers, the intention is
> whether the version of the module, or the version of vmlinux.
> That is a question.
> They differ when CONFIG_MODVERSION.
> 

I think often this information in UTS_RELEASE is shared as informative 
only, so the user can conveniently know the specific kernel git version.

> 
> When module developers intend to printk the git version
> from which the module was compiled from,
> presumably they want to use UTS_RELEASE, which
> was expanded at the compile time of the module.
> 
> If you replace it with uts_release, it is the git version
> of vmlinux.
> 
> 
> Of course, the replacement is safe for always-builtin code.
> 
> 
> 
> Lastly, we can avoid using UTS_RELEASE without relying
> on your patch.
> 
> 
> 
> For example, commit 3a3a11e6e5a2bc0595c7e36ae33c861c9e8c75b1
> replaced  UTS_RELEASE with init_uts_ns.name.release
> 
> 
> So, is your uts_release a shorthand of init_uts_ns.name.release?

Yes - well that both are strings containing UTS_RELEASE. Using a struct 
sub-member is bit ungainly, but I suppose that we should not be making 
life easy for people using this.

However we already have init_utsname in:

static inline struct new_utsname *init_utsname(void)
{
	return &init_uts_ns.name;
}

So could use init_utsname()->release, which is a bit nicer.

> 
> 
> 
> I think what you can contribute are:
> 
>   - Explore the UTS_RELEASE users, and check if you can get rid of it.

Unfortunately I expect resistance for this. I also expect places like FW 
loader it is necessary. And when this is used in sysfs, people will say 
that it is part of the ABI now.

How about I send the patch to update to use init_uts_ns and mention also 
that it would be better to not use at all, if possible? I can cc you.

> 
>   - Where UTS_RELEASE is useful, consider if it is possible
>     to replace it with init_uts_ns.name.release

ok, but, as above, could use init_utsname()->release also

Thanks,
John


