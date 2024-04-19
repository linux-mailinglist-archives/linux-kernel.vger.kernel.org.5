Return-Path: <linux-kernel+bounces-151597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B318AB0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02741C22BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2312EBEF;
	Fri, 19 Apr 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aPXvjmqd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sVCfM7fn"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9038562A;
	Fri, 19 Apr 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537821; cv=fail; b=g9ulRk0wiBtpwygM/tXnNLjDgmW0C28pznNXZdQLPl/xQav1e3aztIoG5vXfGvwHwrwtpQv9jgqYdJ/MUW4CRPqnCxm7j155MRjIlpwe5rDlgnkmhKMZAcF9u8wDgnXwid5A1ksl0oCQ4EnlUhDofCXUJf1FMoYJ92wqg+lkEnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537821; c=relaxed/simple;
	bh=Dx4L/pMo39sCgHazmnFxvuInQAhnVOGP9wA0GjrLKJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GvS3ojkHWA5MA64cfHsFyicci94VTW+bU2pvAMR4JZ4Y8a10sYoQl0D7MZT46tYNrmQ6ZduijbOgRAce7O8ZEbGtJ/8gCopHGp0yG1PR5UPt2+nTDtbJqsoBKyg8B0682yVnZDjOlgnMMXxPxj1ZSmAJJgdjlR/VcivKF6g6o6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aPXvjmqd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sVCfM7fn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JDBhEq030498;
	Fri, 19 Apr 2024 14:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ABjmDzsrsPBQ9HTs6Hwu31XO7zQpRwhwZuORiTKNcGQ=;
 b=aPXvjmqdnhP0VYSenlazNR5y1FdBXgbrs+LZadvSBWKFEzfr+ORWP0Jtw6l6y46gt6hS
 prkraI6pA5JocWLKshuxnDsVOpCJ05iJi7kJ8xmGkVv/G7Ln2brw9DrSQMfc2JaHKrcG
 uRSmLrNk7frA2Wsbk7i59dSp7dqMBscVbYsAzHlc2FtVvK9t6nKlLN/NjIJbjuGFRJ9b
 AF22HqzNh9JOJ1i6U4SA0QX0zAm8jBo97ULIQUDNDlF4EfXNcTMrNZIn7pV0rGVgD2mH
 4Svekm5FXyiuBCH8WS6ib6GRliUbrwdVl0pkZjr9T8CyJOeVCESrUt1DRL/22BXD4+oz QA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfjkvcypq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 14:43:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JDgs25040137;
	Fri, 19 Apr 2024 14:43:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkc5g5qcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 14:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6vI94eDXstUfi4MzT6i44Yo3D+Ko3pXg0zsVJZTwGRJ5RBI6Xwazi7GQ5hEY3T25wz13Tja5xSwuy3G+HWFh3gpae0sLjfLsJqjWt4Nbo7sFhDpjlopRtexwkO0bQA3kVCrWbh8A6q0t5USueam6gs7VbQ664fy4e43MjmuSz4IjhbuM3ow6UfkHZ+pyCfB+qBLtXEHQ8y7yM87sw3EIUxl8SCNP8vUIzsBu5eG8ryWo/kK5/2WraijMi0nunmvoBIKjtTb7q1XPEy7w8/Yk8fZrtYt/kqzYZp3ynjRyxMNp0bSmxiFS6wtNwwCxIPQMbnBQBCoNy4nZTHMBIHs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABjmDzsrsPBQ9HTs6Hwu31XO7zQpRwhwZuORiTKNcGQ=;
 b=jJWQEIe+fzOESrd79F71ks+hnjgYsTn5cNPEQzFi2V0O2UyrImXiDf9DRgFtWQtjwoqwuHE3BjKg7xgCX7adWTAsyEvNgeYYa9j+gjJYGtFfX0gvOoBg277ChnAsdk6YCHz26LL5+0fjXpQ0iZdcTXiCdrDTRIkuJTrxb64Jybxt9XX54my25LxLVE8+O/BP09Cvpn9PgXKsa496M/zW3b7LNUQ8Nfn5WxyC1NpXuYtoogFslRWqAd1KXZT9wl0+fzS9XI6Kv3gTUnjcxDOpyPkj/PUf/F5lnqbMQ2LubjTPdACNFrlMWy0W8u0IPorb77TGuQN1Tt6V/n2zeF3sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABjmDzsrsPBQ9HTs6Hwu31XO7zQpRwhwZuORiTKNcGQ=;
 b=sVCfM7fngTje9orhEwprTfFDoiFKednEUynOa+P+vk9WdssCaO1WPpw72zZPagiD5kybH4eQOBp0KIlBaQa+xszcHu3hf+gYV5Fke4w20eZha2tsMgubWZdfwsM4PqCINL6aO79o+5Xda35TmAMxi2UiomSiU43BuCUO+D/VlxY=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by PH0PR10MB4758.namprd10.prod.outlook.com (2603:10b6:510:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 19 Apr
 2024 14:42:57 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 14:42:57 +0000
Message-ID: <a73f04c3-a423-48a6-87b2-3c5d809c6833@oracle.com>
Date: Fri, 19 Apr 2024 20:12:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
To: Takashi Iwai <tiwai@suse.de>, patrik.r.jakobsson@gmail.com
Cc: Helge Deller <deller@gmx.de>, Nam Cao <namcao@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bigeasy@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
 <20240418160652.68df1a86@namcao> <87ttjywxv5.wl-tiwai@suse.de>
 <a7843657-c3f6-4d2e-8c36-5541d4c52956@gmx.de> <878r19voks.wl-tiwai@suse.de>
 <5febb249-1d4d-4ea7-b031-1df4d14620d2@oracle.com>
 <8734rhvlr2.wl-tiwai@suse.de>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <8734rhvlr2.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0028.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::11) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|PH0PR10MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d3de61-8d5e-4fc6-6081-08dc607f00a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sZMLiP9r7cuICSBFCZZb6iHdqCgY76EPViOfhBxMpmTM+DK1m08DstUpcPA1ZI/ZlpmhHCNdiFoC7qqWqpKiV4mWBHUUopKHyvq1rPDmYcF1USazp0y7Yg5cokFW0dLjbfNzcBbj6yqGA4fxLwTo+eZzms5OJC+aU6UJ2Vm7CxfFWnT+zv8sg4hscEDLkyos4b/0yLd9v9wkML1+UOjowjGXRP5XdEIGdZBE9lLfAYntfAdqkmqzsMc1T4EVjO47sYbrJtLsyW0TQExzxRynpxAloCyryTUNdqGejBJ5f6wdY8LjZ1R165ksJWGjL3/zkcrZrP2Ni26HSPhyhDXj+pRVBHcXd+0QO86N70X5IJkCagS8JWt9USZZ6WXy/it+k8S1ow4GJRse1muzBZY2w+7kCYP8BkY0BMexzLAmWDtus58MAgX6J10Yi7pnYMXuiCnhmB0uZJOoxNlnoNJQa+QXMO+dHDKJ1tI98GVDIlp67e5YQ9g/VPvx/4J9oskRDFXXfe/1+knXOptHN7hD9yS2wB4dRJdMTQE5DuWayIC42eXD6WaeMtfs36h/Vp3BZa8rekvxatgPe4f2LcH4/9GkJCyDGmXGGrjowNQSTdwm7i2438FTxmDlE14lTkRib2HQH4svHgF/CgXh7qEe61izsBkmXo05QXhgtnixwGw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFZDd3hGdXRqZ2pPTzhOa3ZoTVVBT3ZiNUF1RFdLSVdLcUlka0dndzZOVXdH?=
 =?utf-8?B?Zk10SVNGcndTc2Z5aTJRSkJ6cDVXekV6MVhXNWM4aHFqR2RJay9WcmxlQW1l?=
 =?utf-8?B?VlAwQ2Vpa1prUkRQbTYrS1VFeFVyRDR1aFNHeUF4SUowUFNIRG52UkY5NnJS?=
 =?utf-8?B?MzYvdktsUG1zamJtcjNrb3FKcGM0d2Q1RHRrMWNhM3NEVEFHODdndXNrNFgz?=
 =?utf-8?B?eStYdmx1NW83S0VydHNZWWNqcWpOV3RMamZzWXByZi9NZ1oxWUhjeVJiUG8w?=
 =?utf-8?B?RmRWWE9LYzVDeDZHL0RCVmIxU296WlZ1SyszVU5IQS9GMFJQa3lGN2oyT0ZN?=
 =?utf-8?B?cFg0Nk1rSUpvMzRzNnE1Y3F4N3MySzZXQm51S3dKdFA2NHRGbnRsaGQ3ZFBP?=
 =?utf-8?B?U2pseDAyTkx4Tm9Sdm9mUlZ0YnhZZnJzeGRNZVMzVHlqRy9ocUh1d2p2cms2?=
 =?utf-8?B?THpmVklaS2xmNlJKVWZaSFlaenNHMWxWSVNpbkYrbUxOR2FqdEx1NkhBdmY1?=
 =?utf-8?B?a0dsMkpoR3YvOGNUNUJycHRRRUc5cnplM3FrNGZnSmlyRU5ZdXBTWmIxWVF2?=
 =?utf-8?B?ekJFcktuMFIvSm1SQWxWUm0vbjdTZStCdGpIaGQ5ZVFlSWxuSVFDQURjOUlX?=
 =?utf-8?B?czB3L1NSd2ZXMkpMV1hGK2ZLOVVJamI5a0hjeS9iZGYzR2UxQUFJV2htaXBG?=
 =?utf-8?B?L05XZ2hSQWRNeEUwYXBEc0VSYjBBZjA3V1l4STFOTUtZY2krc0RNTkJjMlV1?=
 =?utf-8?B?dmJKeS9Ja0lMbVN1bGlnZm1qazBpR3dCSzB3Z3ZGNUFrUzV6aFE1Um5xRWFF?=
 =?utf-8?B?bmpDbUdkc0prZjh2c1FMdlhzb2VPQ3BLKzByejFiN2ttUFNBQUY2QlNXdzRh?=
 =?utf-8?B?akZxTlhmeSt6SXdOYUlsSmlTNG5tL2MwZDBoNXFWaFlLTDZnY28xL2JEU2l2?=
 =?utf-8?B?ekZ6UmlneDA0NXpQb01ucU9aS1IyamNrSGZheFhPZStUVXgwOTBYY1lPVTdx?=
 =?utf-8?B?YnU2REJ5L1dMVHFRQmdVYzFTSEVZR1p5TUdueUZRSk83SzJVbVlac0h1Ty8v?=
 =?utf-8?B?cStrSDB4T0FCYkxWQ0pOR2hraEtjWDM5OGE4ckZ3UlkwcUZzMHhpQkdBbTZo?=
 =?utf-8?B?c0RtcFNUT2dlY2xUSVJhZGJQZ05NcEQzVEttbm9tOURsdHNsQit5bTVYTi9X?=
 =?utf-8?B?OFpINmdGRnBvNWVGUEs4KzBkUUZkRk9wYlNkc1lhcGlRVjRXUzZHeGIzOWk5?=
 =?utf-8?B?aXhTZ1QyRDB1OFpBdjU2SVpoTmxZdFdZb0F6TlRkUGVFcGVWc1AwWEdIV1Jo?=
 =?utf-8?B?M1pZY1lpRlZaQ1grbmlFSHhhVjVvaGd6QVVGMXMyOUJ6QnZNc3U2YmpJZnpo?=
 =?utf-8?B?N1lnR1cxRnlvdkZBZVJUTHA1dWpKNVNRTHZsZWd0TWZSZ2tqcjdxdVBRY04v?=
 =?utf-8?B?K0UrUEdZbVZXK0FXTEl2dHV0UDVEWWVoQkUyZThlUUYrTlgwaEhxb3dKalF1?=
 =?utf-8?B?SjlNdlMwZExacFF3STF3UTFpenhWTDBrcmQwcVFQWXE1eGEzQkQxaGUveTd6?=
 =?utf-8?B?THN3cnBBcHAwNVVDZWJhb2o5UU1qTVFOVDQrMk9rRGN0a0JaQ0QybmhqaUNV?=
 =?utf-8?B?L0E0ZWFnNHdjeXlndU41eTQweld5NmNTODlUMEd5cjVXYktaNHJNdFExZzdR?=
 =?utf-8?B?ZVc3VTRkd2NGbUZ4ZE5lN2JKeTJVcGdjb2lzaUlLK2dMNm82cWFrSXNVMCtD?=
 =?utf-8?B?NmxoKzk2VmRudGJWdExSdlBsbVdoUXByODNKbkoxRm9xNW5mVzFrSUg2Q0VK?=
 =?utf-8?B?UEdtV2JYU3JWSzFoK0c3RE9kU1VYbzFVOFpMMzJ2V3NKODE2WGxpYzR4QVJL?=
 =?utf-8?B?UFNjQ2k0NUsxbEsweThSWC9uN3N4Zkw4UGdudTVjd1lOb2duVXFrMVZ4YXNO?=
 =?utf-8?B?Wm5HQU5WVTdsN00wRnJaVjRSR0EzQW55WDJZdnFCcUdyTUUyZVRMMGlvZFpn?=
 =?utf-8?B?b2d4dEFqaTErRlNzRC9RUEt4SjFJL2JTeXBvVFZhNGdrSjlva1lQYUlOby9v?=
 =?utf-8?B?bmtYMys1L21YQVhGK2Qza2RxS1YvNjEyTHpQK1A1M3RCaGRscVR4dHZxcEU2?=
 =?utf-8?B?Wm8rQjdpcXlybGhySDRvQk9wMWNRYUNNU3VpeGdOK3laWkpxNnFRNXdCeHZ2?=
 =?utf-8?Q?EZ+VEl7vtZ4HjBaC++3mtv0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hqQo1Bvr1xDlIhj7+hJSgUu1NGvID2HDLwMjunI7xSB4eGbINOykep9lArAfJbMpxNjhen/8WpOcRk+ZOcPSAnYSDfzLgXLC8AwcoABKwSo8Alyvur8x419F862kI6mLuVNbe0HN0PB/86LcQF9ta2T02dho7TQveIvJPMWi8PTu3aiSbcMMP4U91P4o8Yukp683NQx1siCkNT10QI4D0yu1xNTkhfKV6c+fIr3i93lMe+L95bXE75m+aj19YaWInFs3iTAVTr/5pA9An8HhBB4z4MjfyMyKKoirJ6gfrbemXgwQfWLyLAf9SzCJEbBmUt1LCozWJOl2uF6wPB7zW8YDMKt2B07IyefYrmJnmFmdS0Ip1KVoFBqWti+UK4o/NxX6wLMpXIWFrS+0Itmvsq71UVQFxUkw65Pmkfx2HStTy8McfiWEQXLv6E39gWqGj6foEk/QoAjY2aSCwWE+dMruiIEfIWMVaAx1pzWjBZrpzmS2umpBrT/MkiapHQLOGHVoSjQntdBFNGr3JoQnvfmAPdpDwsrlKzSkxvTr8G6Q4FVLRzd/Cf+uvSFty/AdMko/aM2ciwOgPdwalLZpo5oxPTK7WIuyE+sDpXrxlCc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d3de61-8d5e-4fc6-6081-08dc607f00a4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:42:57.0314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8aM61rRlZj6+diCFZrUH/jw4OvC0dSQNjYmo95YX6djBZLIhV8VnJt+II9+m80AhXgncMcxjLUJA6Kbl/PG4xLQ1JkBHzmxnzHhp04NMTdX8XJZAWL84LUAvo5gj6kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_10,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404190111
X-Proofpoint-ORIG-GUID: v3C-phgV42bCFuKn0F9PD0CCdzRCyFgX
X-Proofpoint-GUID: v3C-phgV42bCFuKn0F9PD0CCdzRCyFgX

Hi Takashi,
On 19/04/24 13:15, Takashi Iwai wrote:
> On Fri, 19 Apr 2024 09:39:09 +0200,
>>> Then later on, the commit 33cd6ea9c067 changed cancel_*() to
>>> flush_delayed_work() blindly, and the known problem resurfaced again.
>>>
>>
>> I have reverted that commit, but still could see some other task hung
>> message as shared here on other reply:
>>
>> https://lore.kernel.org/all/d2485cb9-277d-4b8e-9794-02f1efababc9@oracle.com/
> 
> Yes, then it could be a different cause, I suppose.
> The crash with flush_delayed_work() was a real crash, no hanging task,
> IIRC.
> 
> Can you reproduce the issue with the latest Linus upstream, too?
> 

Yes, this was reproduced on 6.9-rc4 kernel[1], also reverting that 
commit 33cd6ea9c067 on upstream still showed another issue[2].


[1]https://lore.kernel.org/all/271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com/
[2] 
https://lore.kernel.org/all/d2485cb9-277d-4b8e-9794-02f1efababc9@oracle.com/


Thanks,
Harshit

> 
> thanks,
> 
> Takashi


