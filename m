Return-Path: <linux-kernel+bounces-85372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D396B86B50A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C1A1C255C9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A10145FF7;
	Wed, 28 Feb 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iejjMwD6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mAj8NGgT"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798073FBA9;
	Wed, 28 Feb 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137926; cv=fail; b=IxEB6TDZVtYEpu+T6u4oBjmpMIHbsvO96Ne0efIQMQEacFTUCuVKAlHE1rEdKvaNQPtimHxYa6XfTak3f2Yz/k+61/PvqMG4gRTCDEKhAO6bG6SrbyJImOSXOC/u1/fV5IlA833pWxdBmEbKmgzRNUSwKovHwv9wT/0si3o/gbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137926; c=relaxed/simple;
	bh=zXFy1YWDlUYp8u6qtz5ZEK0ulx/cqZvfaPfwU+K+VHM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uYLspCW2xddM49KKTl2meeJIbFu7st6DXXHJ3XGuv7HpKBolQVbPryEx98LkQAuyaWqOnXBWnrIBK7KWPN/LQ0I6viuL8YHXhahYCDAmr0xejusIQV6nkjLCxV4yaI9vuSfle1gShtWAeqGFjh6PaGsk2wb2meJN5iTEcAXFW20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iejjMwD6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mAj8NGgT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEG28t017707;
	Wed, 28 Feb 2024 16:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=iN5dFnYhW268G8zScvSYFjRs/Z0kwcZsm7x6g6GY3Dw=;
 b=iejjMwD6DIaPXEj9AtOBpkK8vKbWD4PMwYHi1uE/bFkznC3vw+dFWCswhWXTBG60QrRH
 F5SGZBpIorrtOz8BiiQLoQ02Dbd+WxnpI5V2L4WrCM2kzeWJM08qOTcLsFGsI+xw68jS
 pusPNPnm3ELy+C6Jf0pV7vcOf3YcD58MCZORv7At2fkvEaGWgCzK0FKP7bjG3sa5Weue
 YQPQIVh1gB4XwRIG/3Sx+Y8HL+6dAWR3+xJOXct00rnhUHTNSlebGlY16FMrfaD+lawg
 DKFbxzC3Wq8ilH4PZj9lIpc3c9/2UHjruuEZuZxdKf3q1SzBXyAHXqJCXM9kjfAGLG+k sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gdk16t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:26:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SGCj7O001674;
	Wed, 28 Feb 2024 16:26:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w958dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI+NEa6KRW5WuW+6MC3DVQrScNok7zN4Dx9VPCXv0xl/8ZxonXTAMCzBDFZoOb9N9ZJHRZS8zPF8H2itpvUfa8gEflXtrJZQiPm65G9QNiSuwsWU9pJQN6zmUND6+d+4ZxMXxhP/TmICh4/Q7cHUeVMOrp+gnyjT5WcbxhFQ2M8gLEhHNGlXk43q4fgz/TOht9DrP50mwqDa96EJl+HRR7IM21VxKZZplhuKYoLzhG5E4qMrDuIB1tAtIx34gmuz5X9l+AiuFLcmp6AeaVHt7z3h5X/fmt7M0zAiL7X7U7/WLTsPH7ojOdRVvsl/9P+a8rfI/Kpxbs5jG9t5tsHhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN5dFnYhW268G8zScvSYFjRs/Z0kwcZsm7x6g6GY3Dw=;
 b=jG14I7p1vXun9MosWdeRA1d7AmyvN/BBpJyC8MNVE7uBaAUJ0inz1xrAZTIHGG+vPKEmFRDzrWgyfS0lMcXheJzC45ROybNoTkhWbbyYE2Rm3NYyUWiI1wW9P31ULQJtPfAAibmL9r1yvYHRj/K2rfGWFr0rPUSsUxD5HQRRswsiCYtQYb3vioWNq2cdK0gOE8wCWJLAiXLe4xNm15fUqkLwtYhW9foP8lhfFw8kYzIIS1YpnklDvaRJYDUIaTOuGKsA5JMeRp5YwodT4WvhEzuGj9sB5FgnyLYg1mJFPLIUGa7qCHTTvYFqgeidda2B15r2Tv4+N+nDuGMj7eFUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN5dFnYhW268G8zScvSYFjRs/Z0kwcZsm7x6g6GY3Dw=;
 b=mAj8NGgTh7dDNsEwMgupdmnucCdahBqWH8RkUlmoaexjGOoLlZTdZVLJF10+d8BknFJ5Cfz1j8eE5FR8zg4uQcCNnQN8qaFI0Vy7iv+umhH7QbwdI4uOjvWrCjiSnmCUxvHUuGwp6KIifmkbnVbxPhAAJst2inJxuhL0+i9OvPo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7239.namprd10.prod.outlook.com (2603:10b6:208:3f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 16:26:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 16:26:42 +0000
Message-ID: <0786d006-9ccf-4ba2-8a1f-452711797a81@oracle.com>
Date: Wed, 28 Feb 2024 16:26:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix disk not being scanned in after being
 removed
To: yangxingui <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20240221073159.29408-1-yangxingui@huawei.com>
 <d765d2c5-3451-4519-a5e1-9e8f28dcd6b3@oracle.com>
 <693dec74-1750-191e-cbc3-37f993d165ac@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <693dec74-1750-191e-cbc3-37f993d165ac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 488ba142-814e-4229-2db5-08dc387a0c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XTEUhdUq2ImjMXYrSM+E4DiPHC58LI5Ch1eMrbhv2YWxKBEdaO0EDoks5zuXoiXL9k0ob/Bl8PUPpsE2Xy4Bz6fRtKgufw+8ZPzPZP8WmtCbhtJiwG2GJSQp1CY7VdFCUFWb6Xcy2D9eJv5ZA1ABLVIO6TCvL9EeUcriUxX2E1Yx9X9BG6RUZsLGzIT31iKf7nypuFGGrOkP9U7mulxfVWofK/Bz+OMWM71g/kEmHnyoM7GvDi1iiupU5q+ncTT9weTiRzxyoOmSSNt9KJ7byNNKUfaJTHdEFs452bL+vkzYtfPRJSVzQfBBLEYznHKJqzsDA0l0hcwgNULs50dvwplUy5x3QCDoSvXMqhHeyBNse1ajml65hTaVYlVLLiNRmaatiU5Smz1JImXKUOZk3vySAbBEoCq4VaTKNCmOOv7ajNZYVYe7c/4Po4tU45D6hPos8vZVWodnCo3mGet+kr/0WjPvk3TT1btEtq7BxB6PBCgttMiclTMsYZ+NGWhDjh0ptIZFiAFGEJmzK83DcJ0o13/IomkDigGFNen+cYBz1GEaaWNYJQmgZaCvVqhR8jsb6doc6nYv38RFyqz2+icCAg1v6R5FSwuq2siyj9S1/ebtyc9vadrXrQOCHQykJTAqFXsXizDhs9BkTngh5w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWlRTldjbmE0cEdFSGQwK1ByUTNnUnlsU25MOGF0YlRoUWJVTnorSGl6a1pQ?=
 =?utf-8?B?cU1wbDQ5T1lrZitkVEpmY1kwM3BhMzdzTDM5QUsyQlFYd3MvREt5VENFQnVK?=
 =?utf-8?B?Y1FuYlZXSlBiMXFjWDAycmVXWjNRMUhLOTNPTkVaTkIySDBpUU1jU1NueUZH?=
 =?utf-8?B?bk40MFY2aFAwemJnMXp4a3FzTE5IZTkvZ1ZiM3IvQTZWejg5RWdsbDZCN0tK?=
 =?utf-8?B?WEJTbnFVdjlYMHEycmpUU3NWck1pb0JFTmpkZnFYMU1RcWxEeGh0L0lCZDly?=
 =?utf-8?B?azhEWG9INUNPbFlVbEdGa2J2TTgvUnd1dCs0WTRSQjhuUzBTWUZ1RENvSTZr?=
 =?utf-8?B?UWVTZk55UzQ2ck5MaVpiay9EVWE1UWtYeTZUWVIyZmlyem82MVRFREoySUcy?=
 =?utf-8?B?ZkhlYUpsUU10ZkVBY1lsNTN3MlBleHVrNG5RQjlmelA4T2xqcXBFbmRuRGdC?=
 =?utf-8?B?aUh2T29Ja3NLd0xBSGU2NHo1RkRxbmorbElZd3EwbzcvbXlhT3BsTERnV0FC?=
 =?utf-8?B?dnluUTZTR1k2c21pWHF4TW0zUkZsVk85dWRxYVEvVzZqMGRJY1JMR0JESWp4?=
 =?utf-8?B?R2ZLNFFxSWxhVHVad2cwenRkRkltaFlETzZSdjFLQ0lrcjBPWTFiQkp6Q1Z5?=
 =?utf-8?B?c1hLSm5pUlpvODBkOFYzRFBwdElBaEsvb3lEbjFpSHUzdnBmaGhWa1RlY0tP?=
 =?utf-8?B?aTA4ZU1NSktPa25zSDlHdWRlbkRnVmhIcFhnRm0xRjVPV2c4c0k3RWhsZEx5?=
 =?utf-8?B?NEpLVFUvZkFMMGRPUTdZYlJCK3dJN2o3dS80ZGxpQUJlaXA0cDZrQTF2TTEz?=
 =?utf-8?B?TVJLUXZJUmxDK1Y0d1VPeUpaOVRhY2xNTjYwMUdSVFZ0MmNhQ29oZ2FoYldD?=
 =?utf-8?B?SGIzWS9FTlJoVlozaXFyZUhPNWU4amQ3THhGbVJrWm4wdGhjeVpoczRrbmJR?=
 =?utf-8?B?eW5zbzFQQlduMUJNaGlka2xQdjZvVFFrZjhXTTF4TnBOd3htbnA2alFPc1V6?=
 =?utf-8?B?L2EySXoyRVFVd2FHTDVhRGI1dC92SG9Jbi9QZ1dXVGJYVHlQQWxtRlNyOXF4?=
 =?utf-8?B?WkhIWTNSYm5DeHYyeVBHRTdnMXdwdTlRZ1drVU54MTg4NTlDWUJ2RGttTitK?=
 =?utf-8?B?TEJoNktERTlINDlka0gxRUtvZEZFYjg4WGVLcTh5QkVVY01id3NpV0ZGcEwv?=
 =?utf-8?B?SlZ3RUlXOWxOcHJsWUZvRlBsYXE4OEhWK01sOXVqd1h1c1FHajFvR3l6TzRP?=
 =?utf-8?B?d2JGWjI1eEFjSUJTTk0wOFZpZFlBYlhVQlVSOWNhcExjeHZZa0l6OFRHZ210?=
 =?utf-8?B?clRXd3lkN0NLQm5Pc0Vwb29jY0cweitaa01aL0F5L0lLRFJqeCtBVzJnOWNx?=
 =?utf-8?B?U2N3VzNpYUJabjZxNCtIWWtUY1ZOUUpJWWI3QU5hcy9JNDJIMU1ST2dwOG1l?=
 =?utf-8?B?bzhoaStNckRlRDFBbnpuK2NDU2E1YUFBU0dMUTZTK1UrWTVZekFNUEVOOERi?=
 =?utf-8?B?cVNTZDA0SFBVUW94L1Z4eHQ2WVY0bWluMDd3MUdzcUFGTmZiQ2hPRzcrVll2?=
 =?utf-8?B?dXJXeXlocnJRMzVWRUxxRmRPdS83TG9uRGFzcXVlNGFCbTFDMTZQdGdsNVF3?=
 =?utf-8?B?alFScVNUSVZWclJsdHhpY3IwVjZPVngvU3FiNUpoc2N3N3hDUFc2ak9LZUJG?=
 =?utf-8?B?UkZmWjBYMzNmc240WjVhcXFGdFRvcVd6eEhETElWbEpSR08xdVMvNTI4M1cw?=
 =?utf-8?B?MHB5dno5VnpKN3M1T05sQVhRTmE2cUdIak1sc0JhZlBSRmwxOGl4alUxdVRi?=
 =?utf-8?B?RGswRW5DWTBpUnVUZFgzZjZYTVcvSWhUWkFMMGxMLzNza0lockpzRlRTUGJm?=
 =?utf-8?B?RXI2RXNEeGJEYjBBNzlZdFZybkdsZVY1VG0wRTRZcnJqRWpJNmpqWWZBSE8r?=
 =?utf-8?B?bUlXbGE0SnhQL0pjZzR6Mk9jZ3Z5aDA3anpYTzEzbEppbEVBOCs4ZUdoQmwx?=
 =?utf-8?B?bXpPUlZEQ3M4YTQ2S21VdGloSnFhR2k2a0pQZXFHeC91cjFaVGo4RmFkUmRQ?=
 =?utf-8?B?NWJGdGMwQVhMWVZ5U0NSOG82d1dIZHFiemMxRGVFUDlWTUhNOGM5SnRsdzRn?=
 =?utf-8?Q?OgCAc2PbrTA7pPp5REStv/Phb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+OxcIdc2Q7djjr6g3Hm7V7QlB1C9Ov5DZC3w106L5rRx3E8t2L1huGXEDKIW3waWgGeBOZ8I/p6stRTWq6d9ZomkWhOoF6AQE1h5S282SVb0O+jwE1jlNDechnN9RkMvamjA2vWUi/9alkulmO8t/KJBkbP/VkXVXKFqG3Xfp9RoVQboFsoRVjgP6arciyoP7wzIt7OiwwJ79D9Vg0smWhJSshaYbqLr+yfgQHVEp+7p7jG4SFp81OTsdHDz5XlpccDpiG3hoVoPYoMLH7N58P81C07Gl5w6/83JhmaChM7WqpxJOf+WvUX4VqIN4cZet1iocYjtHIEuPoSPFsjit+EADltO8D56ttk9EvF9estuIdd99KjMzeu9WV5BPKB5x2O6QuLc5GFFVdnzoab35WjddT85QtFiGQe+99ma1iwCFW+4ugcVhsMTO5M+yDnvCxMaGGaWmAy8voERn/mT4pknl6Dbo5grqQZ69+vp7KlTltfKjmOGnxrCTvwqTAhEDVdDD2skl8UOBWrH6ikkgH+NOAPaqy4cr6WpYfC7KcliTHvEwVmd6rxRRAuer7O1ElYochtkGZ5UvEz+Pm762ZU9wtMVVVh46WTfWvGBJ6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488ba142-814e-4229-2db5-08dc387a0c6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:26:42.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhJCT7TheivQG5OJrsQMBVocyqgZJqaPfBOnYa1y/lmcX0tiDJe4vnoyGZ/awE2lJOtsQ3aDzVpfrgn1WYImQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280128
X-Proofpoint-ORIG-GUID: ioRJiDoGpZXPAttj9-VpbrEOP_Dpm3od
X-Proofpoint-GUID: ioRJiDoGpZXPAttj9-VpbrEOP_Dpm3od

On 28/02/2024 13:13, yangxingui wrote:
> Hi John,
> 
> On 2024/2/22 20:41, John Garry wrote:
>> On 21/02/2024 07:31, Xingui Yang wrote:
>>> As of commit d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to
>>> update PHY info"), do discovery will send a new SMP_DISCOVER and update
>>> phy->phy_change_count. We found that if the disk is reconnected and phy
>>> change_count changes at this time, the disk scanning process will not be
>>> triggered.
>>>
>>> So update the PHY info with the last query results.
>>>
>>> Fixes: d8649fc1c5e4 ("scsi: libsas: Do discovery on empty PHY to 
>>> update PHY info")
>>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
>>> ---
>>>   drivers/scsi/libsas/sas_expander.c | 9 ++++-----
>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/scsi/libsas/sas_expander.c 
>>> b/drivers/scsi/libsas/sas_expander.c
>>> index a2204674b680..9563f5589948 100644
>>> --- a/drivers/scsi/libsas/sas_expander.c
>>> +++ b/drivers/scsi/libsas/sas_expander.c
>>> @@ -1681,6 +1681,10 @@ int sas_get_phy_attached_dev(struct 
>>> domain_device *dev, int phy_id,
>>>           if (*type == 0)
>>>               memset(sas_addr, 0, SAS_ADDR_SIZE);
>>>       }
>>> +
>>> +    if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM))
>>> +        sas_set_ex_phy(dev, phy_id, disc_resp);
>>> +
>>>       kfree(disc_resp);
>>>       return res;
>>>   }
>>> @@ -1972,11 +1976,6 @@ static int sas_rediscover_dev(struct 
>>> domain_device *dev, int phy_id,
>>>       if ((SAS_ADDR(sas_addr) == 0) || (res == -ECOMM)) {
>>>           phy->phy_state = PHY_EMPTY;
>>>           sas_unregister_devs_sas_addr(dev, phy_id, last);
>>> -        /*
>>> -         * Even though the PHY is empty, for convenience we discover
>>> -         * the PHY to update the PHY info, like negotiated linkrate.
>>> -         */
>>> -        sas_ex_phy_discover(dev, phy_id);
>>
>> It would be nice to be able to call sas_set_ex_phy() here (instead of 
>> sas_get_phy_attached_dev()), but I assume that you can't do that as 
>> the disc_resp memory is not available.
>>
> By the way, I have updated a version and call sas_set_ex_phy() here, 
> please check it again.
> 

Then maybe the first patch is a better approach. Let me check it again. 
Sorry for the delay.

John


