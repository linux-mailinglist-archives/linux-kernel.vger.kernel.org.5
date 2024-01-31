Return-Path: <linux-kernel+bounces-46912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FA84464A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B528284B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993012DDB5;
	Wed, 31 Jan 2024 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMr6pmQJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eBy26RAI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28F7EF1B;
	Wed, 31 Jan 2024 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722675; cv=fail; b=VMVZNigp8xq/xWDnq9HmcBO6/hnhQe164NrDwl3vh72bTci3qfGFDBGJmL1sAhkLcPimk8qhjL9ew1SnaL27f8Bob1thQQ+elyFD1iVVlI/0r2YWXwmM4PzIosncFyvuY500G+Ae/fZdWQJql41pUnP6Y3Jaw57B1tYs1L0a45g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722675; c=relaxed/simple;
	bh=VgEnbfTpxN9ErJYioYtTbcOWiMyeupRgvg3xiUBz2uU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pqeClHk8XUErn8z5o00ZG4QhdoW2DWOjYVipQaQdTBfpmTFaQJCr8FCJid8a5fvLWN8h+ORIn/ZuilpPttpTBIXa5OYiFquQv0aOODOGKXMaVy8cQpBKM9imKH1WI18OOp8Flvjh7gWObDn5IJfNns70Y4OFydv6NW+VK87/YUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XMr6pmQJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eBy26RAI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHBwIW020212;
	Wed, 31 Jan 2024 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6ABn+Knf41+l/2iu9+Z378Ap2sL3RPuBlzCsa5tXpUM=;
 b=XMr6pmQJEVd6DmlknOCpbzwvq01gxknqSprbYtBDz37eLJWyUorkOljrp5O1bdEGe9Gs
 y1J2pzC9iFCkMvkfcnWi6R9IkI/BhkQ8S6klWMIU9z2F600GeDw++2DBbxWSUkkZVEqm
 DpFN0Kt8LEemLC9BqNgxeerOnkFqvG8swwspVX0cdM2VU/TwguJAi4n8AwsJokEGRWeI
 eD9aLdcaVyG5/9i+FluczXUwhM1ND7mweYDLRWV+Nu+WsM9V6uEgkVluoHJdVqsbeCdh
 ZtZiA6psZcHxpsp9MpxPMYJaPzYathOYr7qOm7ZKuPQZR1UhYUcBxYibZcPPyDrQmS/w 5g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2jp18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:37:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VH0dP5036039;
	Wed, 31 Jan 2024 17:37:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fn648-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 17:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et2DOY85EST2BvIIhjv8wA00QcSExN3KginX+IxijuUHTlxJa4GDrQhMAzipi4QXJ4ew0joQtfUkH8/QtKo3+kJ19KiwNGa8EkFc7q8W9bgUgn9lI7cCfiJ714kgh/OV/sjp/y9Dgx5pqAaEHb7d1kg8hIJy49kUr8JLuzUb+dg+8kS1uUAEZJVOD+32cByCi3ky61GJCLGy/5V4+LU9/PqkosZZI81XbQEtfWjK6oCNM8VZwANAiasD8tQpina92teFhbsPHjAzQ3WaitcE9lIG9Va5izjCul9TJeV+Vrhrrc+yuz+hc7DC525QF71FGuBcKIBSFx0DtSnAqOqI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ABn+Knf41+l/2iu9+Z378Ap2sL3RPuBlzCsa5tXpUM=;
 b=dqI0gxXlLKj01w8hv7xnYrU/74PcZDNk7EE98Tx1JH/4XpXyS15WdauWBXnCte6wU909Xvp18PkR3PDrT1VBqz8heVUhWFaU+Yavyy08rz3eV9dOoo6i+dU2CFxIhpD1GNwSSdEtdl/ePT4/o9SH7Ra5ETrs9TTdFnkJNcdwf35D50yNxWsvTnE4A3jikjPhP1rdzOd+t3XCbpnZbRFmZeE998bv+G8u+YG0mDwlUqm3tBBLYs2orLWy3+jm+5k5CL8mcOLSPwMo0X9diUMbvChkJxnqiAmetgcw4PLfFN8yMD7Tty+de5qA3dKXqJKN11O3k70FSqlIm4RS0QIJBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ABn+Knf41+l/2iu9+Z378Ap2sL3RPuBlzCsa5tXpUM=;
 b=eBy26RAIU4QP0OaPQWXcwkCTi2mrWJJjzHIwV3QxmGtmAwAr+7qJk5chuj10m7kIPcjo9cr/6gjPzHW2geCmg7Neo9Cmi9Hx1FzSFpMT7+fjFEcK3jgByjcY604XRPAsByITeGHGvV+Ev7Xt52QVkIqTKQKj03T2zPZxnpEwRwg=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by IA1PR10MB6897.namprd10.prod.outlook.com (2603:10b6:208:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 17:37:25 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1b4d:a7ed:2ace:8f3]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::1b4d:a7ed:2ace:8f3%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 17:37:25 +0000
Message-ID: <86a8e266-110e-49cb-a156-faa950df3a62@oracle.com>
Date: Wed, 31 Jan 2024 09:37:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
To: Dan Moulding <dan@danm.net>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, regressions@lists.linux.dev,
        song@kernel.org, stable@vger.kernel.org, yukuai1@huaweicloud.com
References: <2ef7d741-3df8-402a-967f-53ec77c73e2c@oracle.com>
 <20240125203130.28187-1-dan@danm.net>
From: junxiao.bi@oracle.com
In-Reply-To: <20240125203130.28187-1-dan@danm.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|IA1PR10MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: c206edf2-0d00-48aa-4db9-08dc228349ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bK6b1A/s4h1bO/aUzf4s85uoWpfmD4PqlMRB9apRTfPqD03ljDZ869lYKlLKpZ9XaMhW2PJIsEU0UsWt1wwdUiutmgKacYQQ9FqUj4+tse4vXJvqJrCC4CGMeCWLNavPFGeNEC/tnkGj2NoLgD81JioNROKHX1LnrIFEamBSNBhULM1Im1iWBg3Rq1LsqjiLPmySPOrHVXLD06CemZH/M3KQ136cLdnwnVMR3TFJIv0RQYTZjnDNMLEGTiMSWsHmTpPLRMVZHAAtePCF5ZJ7kM+3s3d3Z+SvWVXE/EpuEipTrJy1/ImGEuCmGXJO6TQY8plqSj+GFNzLMMj9Q7J3pgbMczBf31bmtEdOzAG4xZAKjNTowWlBexFUNIMaDC1q9UIp9FmgrA26Ks2Utlu0fQBkVgLZ5q95OEa4BawlKpc8097AFgXuEEjWmw5Rea+xjhPHiMrsNBTvBmjNldS0Y5K4zbAWgQIc9BbiKGq1Ufgje+p2oZ8iYSmj34HU1qJahx8/ovniwj6mEjLzGvkF9w3Xr90llFu1uJJhtfs+/havkFjSL0PmQWSB5mx05SnsWrAaJXToNem5BoFhmuG2gz8d5OT1aUzJAGWJOOTYqFy4wInYha+9TGfD95pQ1B1A
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(66946007)(8676002)(4326008)(2906002)(5660300002)(31696002)(8936002)(86362001)(66556008)(6916009)(316002)(478600001)(36756003)(66476007)(38100700002)(6486002)(6506007)(53546011)(6512007)(9686003)(83380400001)(2616005)(26005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXFubWFuUys2SFN0Mzl1LzF2c0w4cFlaUkVqT2VzNTlZeVdVc0gxWi9XaC9h?=
 =?utf-8?B?YUNSVkN4MmdiWEhub0hVbXg4SmRRc0pDSHczRkdXS2xWYUZYcFNYaUk3YnlY?=
 =?utf-8?B?NWZDTC9MVHp2a001ZlJoa1ZFME5QcW1vODRoVXd0ZDl3YW93OWs1RGlhbmNN?=
 =?utf-8?B?SHMzNjlGVkFVMTROaUhmejhUZEtUNFYrd1JmTUpYNExWMzlqYk10cUUvQ2tj?=
 =?utf-8?B?SFIrWXdGcUw4YTR4TlVONWlsU0UyYlg3YlVLZUhwL3E2N0c0TnVMVDJUMUpz?=
 =?utf-8?B?SDRycjI4M1lSc0VCai9kUWoyNjRSRFlqQVRBek1tS2RlczR6cHUyaDBsU092?=
 =?utf-8?B?OGg0NDkydjBneTM1SDRjTmN4VDJiMGJUM09HaWNhU0t5b0tQbURGT1hUSnhZ?=
 =?utf-8?B?VmMvY0J1VUJEL3M4b09sQWNjYTBiS2haUE5GVnRFOUdITDFaeS9zeFpvZTJO?=
 =?utf-8?B?V1VIdlNyVFI3Y3d5bjlBVVFZZUM0MFo3KzlXZWU1T1RkeERnelBEZ09rT3RE?=
 =?utf-8?B?U3B2RjVyc2F0QWQxYVducjY3bFZtNXpJeE5WU1dSUE1DR3FkdGNxZUhRZUI0?=
 =?utf-8?B?YjcyZ1U2eXpSVUxxekhQdDY3bHBKeUplSm4wSDFQa3ZJcnc0WXprY2xMcHBu?=
 =?utf-8?B?V21BY2E1MFVKb21FZ3JuZGJiYnhIMDBhbTF5OHVmekx4aHNhQmdneC8rV3pr?=
 =?utf-8?B?RkNYeTdtR1l4WDN5bjZjZGVlQlc4QmxncTY0OE1CWGRERTE0RHZmUWFpditX?=
 =?utf-8?B?dHkwNEcxU1pIci9UbGg0Q0pWdGZmQmc1UFVjVEZnNmZzUWltUTZma3ZQMEgv?=
 =?utf-8?B?VXp5ckNOQ3FDd2Vta1E1OCtteld5QkNpNnZKWCtXSkpvUmFmRXZKZ3M4T2xU?=
 =?utf-8?B?RDFhazhCR1Z1aTEzNlhiVmt4d1FORG00S0x5NWtPL3BmNEhvZmNWbVh0MXlj?=
 =?utf-8?B?T1BqMmZ2UnIraE0ya3prZXhVNFZrWUx1QXZEc1ZzZk0rNThPZC9yUUkzeTJo?=
 =?utf-8?B?M0dJR214NDUxTUVTcWJQYStpOGpmTTU0cDQyNHJaQ0lzS2pYWnpmZ1I3Z2tz?=
 =?utf-8?B?MFcyeVI5cm91M1d5d0VqZzkvWk5IL0NSRnBNaXdzV2ZiNWEydDJEazJyZit0?=
 =?utf-8?B?Y1IraG1TcmpPd3Azc1MvVCtPZmorbE55a0hmN1BkWTA2Ung0Z1dtdmR0eFZD?=
 =?utf-8?B?WEJKNGtacEZjYk5XVFhOMlo1eFI0T0JvZEtVNnJFRWJsUnpzM2RqQVJILzZM?=
 =?utf-8?B?aitHMW9MK3JQV2gvVGtZUHhMOXh6Z1VuZWdlQ01sRExQZjhuZnRvTUN3TUlE?=
 =?utf-8?B?aXlIaCtNOGhFQVNBaGk0Mm5zYmdPNzdwTFc0S3M2V3ZkZlpNakxPWWRlUUFO?=
 =?utf-8?B?NFpueXhIbGNHanRaUWdrTE1XRE5JY0tXVitoRlFzdCs3bTV5cVJ0ZkF3SitX?=
 =?utf-8?B?Nnc5b0YzcVByYjBvdXlLNGtSU0VRQy9FVitUMWdqUEl1S0NrK3RMVHhSYjhh?=
 =?utf-8?B?NTV0ajBJOU82aCtmOGZUYlQ1ZFFpYUM4bTZnOHdSajRtb205Z2h6a1lhMTht?=
 =?utf-8?B?RDJ3NzFBOFJmMzRDaU9XRzN3SUtkWjg2V1AyUldJVDhFS0QzckkyNVhHMVpD?=
 =?utf-8?B?bzFFTWNzS3l4UXhDc0xwZElIdTBFMUhNODJ1WXBOUU5WVFJOWUF6QmZSU2Q5?=
 =?utf-8?B?Z2JRMEMrcW1rK2FFWXNRMHRXYzZCQWgzQXN5S0dvTEY4cnRyN0JJT3owcDBx?=
 =?utf-8?B?VnZadmZpYWcvOWMzR0JMcDA5NTVpQS8veVlKcEt4UGxxbGY1OWVBVnNoYWdi?=
 =?utf-8?B?dGJnRk5ING13OXJKcHMvd1NqdEEwUUV1Q2NOMCtreVlYbTFkRTY5TTVNS1Ex?=
 =?utf-8?B?NjNVc0cvakt6SlArZ3ptOW9EdDU0ckhOdzhFMUg2VE9NVG1JUHZHRTJyOUlD?=
 =?utf-8?B?ZUdqTTQ0SkMyS2RTZnlnTTlMZkRJeEhyWURXdDZGaFBCZ3p6L3FGbE8xeHB5?=
 =?utf-8?B?bXVTYlpSWVVIa2xyMFZtRFRaRitXSjJwRU5IclpUQ0I5UzNPZ3F0bVNNcXRp?=
 =?utf-8?B?V2lJVFBLSTZseVdiVERGa3ZEakYxbFNQS0UyN0p6b0xjcTNTdlZWbHZ5SE5o?=
 =?utf-8?Q?Q1RiIUoMvl1LHXA0ArQFH7P46?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XAc1W0cgW2lSBrQtwUmM+GhXQwVd9URgwSJFQT3kxi22/kHhry4hZBxspSS1QTT4qqbB10eGtbJNwA+v/SnHQXfWgw+bCDoyZlGrXWRF2x5fjXBTgRkiv3reN4LehKe7rnWLZCmCkn4Ofl+OqDXo0C3uue6zRMwaC+NOvznSYXKBsikWo6RDNKpajZrT6b8vy/kkYt+FrlpmGW9uAPuuZi2bImlgdWDgNHSjB8z4N2OW/ykFthF1LsLXgMI8BDfU4tF/Vn4bcv1UmuhgavrVCnFpnyj3ARLwzh+h403paTthZ6f+B+rxxV6Fyh4sWoiNlYOIqSebJ38csXyvNdQPPN/zPwZ7JG2xuqPnPI2nzCRqVhIIg3d9vVZlsiozExGtufKldwaJxX5MZK+ZOuBnBCxIy67zKS+/Id0vM4yicA7meEk0nWdjIljYmiLdzZ/BujlIzFc4d6R+ZWnqsrvrmRQE7ptPEdbQ6qLw+lBr9c2tZ85ADjfzSlQzZqUuFVdRSFfXz2JV9NaOqsJfUMuXT0mrekCnn3h1HmIE8ytEiPVnUdKiu7Cc0L/Lo37LwicZj6UXfyYgE/J95cy3oqtFonKzCzK9bvHdzDIUsvHs23k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c206edf2-0d00-48aa-4db9-08dc228349ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 17:37:25.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYuvjtwpm9/NK1fqu5hfqppEZ+0civZinVf/022Gmik0+QezIsehCCSmNItAn/OQJtXgQwkEr4Mj7uKGi6+cSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=831 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310136
X-Proofpoint-GUID: RhLseUEWfQXkkDRjTBEcCtvz6t6QWp7R
X-Proofpoint-ORIG-GUID: RhLseUEWfQXkkDRjTBEcCtvz6t6QWp7R

Hi Dan,

On 1/25/24 12:31 PM, Dan Moulding wrote:
> On this Fedora 39 VM, I created a 1GiB LVM volume to use as the RAID-5
> journal from space on the "boot" disk. Then I attached 3 additional
> 100 GiB virtual disks and created the RAID-5 from those 3 disks and
> the write-journal device. I then created a new LVM volume group from
> the md0 array and created one LVM logical volume named "data", using
> all but 64GiB of the available VG space. I then created an ext4 file
> system on the "data" volume, mounted it, and used "dd" to copy 1MiB
> blocks from /dev/urandom to a file on the "data" file system, and just
> let it run. Eventually "dd" hangs and top shows that md0_raid5 is
> using 100% CPU.

I can't reproduce this issue with this test case running over night, dd 
is making progress well. I can see dd is very busy, closing to 100%, 
sometimes it stay in D status, but just for a moment. md5_raid5 is 
staying around 60%, never 100%.

I am wondering your case is a performance issue or a dead hung, if it's 
a hung, i suppose we should see some hung task call trace of dd in dmesg 
if you didn't disable kernel.hung_task_timeout_secs.

Also are you able to configure kdump and trigger a core dump when issue 
reproduced.

Thanks,

Junxiao.

