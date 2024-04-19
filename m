Return-Path: <linux-kernel+bounces-151757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B1E8AB380
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E00A1C20A61
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C79131BBB;
	Fri, 19 Apr 2024 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eij91GtL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JiWjZON0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671677E783;
	Fri, 19 Apr 2024 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544813; cv=fail; b=a69VD3H0XAkb1jcw62xjlytJuWSrxEuKpN2BB8tXtDeDhtS/1L4t+DCGI5qd4CiGWNt2pzjXx51mgx4fmD0/CSCMbxUdz0BQyBndYS3Jr3CDlqKG7UMlvdEP1jk9T+WaAQ3eGT26lai8nIquvJaYjQ3n3gAavEw55/eUlt4G1g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544813; c=relaxed/simple;
	bh=kHMS33SDd0XM9RGXphKyOFLkJv0fF9EVyFyVRv8Y6PE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgTTvJB02EHkJvn4C6lffTLeNj7js19S77Tx1Fn70Ime49fP8SstHlV+x8O7JwnAatn0/9UKrOLJUKsA2wklglcSHuHcz4iNisR+s7+8jKx/x5mmrOpp3qTlbxnC9omCa/gSBzSIjm4rmtV/s/IYe0RRFTtcIgFmdP9s367OEVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eij91GtL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JiWjZON0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43JFVLhE021771;
	Fri, 19 Apr 2024 16:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nUpzFJ2Cqa24qaiAkYhK6yBEcFI04MmqzS4ez64aXiY=;
 b=Eij91GtLApnYPTTlWAwysxBVPP8spYSbxdCGMVqGOrk7bHFQskSDfynpN0xBfxOHbyyC
 GQZanOSv4gSka2j1ryWf+F6qlkkSAYdz/eZFx8ofdIhubZHX2vxjsqD67NXncmeu8JT+
 hHCwsKYqiRAO6mJZA2W4CNKnZlT1V3zQqLZOVzq0Rz+P5FItSl+zMyg+r/26Y2WfvhDr
 W6l2zb8OoT41Sr4Kq5X3u8cLMqVba1GVg10XCS0IJrQOmLkm+D2ieYVLiDInkP20im5G
 hxrbdSZ+Jq3h4dzJV0xSoBzfWJOi4cXH/CeTMLJg8WvA6cpiUJ0UWMqFa4YjVeJ4AAG+ oA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgn2w9k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 16:39:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43JGT6RY016743;
	Fri, 19 Apr 2024 16:39:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xkbjcc1rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Apr 2024 16:39:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl8/3TnPlmxKbdqBuHgi2Kj07PDvYfljNN2rwxSFLs/TdWwY5XS+o56xVE9Do5fSFt11kHMRvy5fNHF5PfhYyDVNf1bCfN8XSZq7eLwCd112vcLVFf2eGCBCoC2bj5HtJKeUJha8R0WUniggyTEXIg+6tLMsHuf4fZ02JKcQUkPkpDBHabwoRRYae8ZLNiUJmdCyqDsE4hTiw0krSK2d5q0srvOmp9wY1Bbix8W4lAUbzYDQRnnidY6DbKWQQoecmfhuOs7cnk2kbT54jGKd6VrBMPBLUhQc1OZE2VlPJ6M9lU8m92bi2+AOQm7U9Iixrh7nyNUccK8yT6Zcns6Eeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUpzFJ2Cqa24qaiAkYhK6yBEcFI04MmqzS4ez64aXiY=;
 b=NEDx8gXjHp/zTJDGIL28V9Y+wtTokPb/P25m+pS61JCxLwNosNwXo9JypusbEyhXJUCZV9ns93Y3cLFvQOVPU96RBFJc7ibqt0ZAzo7VxG93ZN8LT0Behjk/hmjNSbD4ZEQJfkD33UTZz7n5sE6yFhiSlNALftN/xNHWwcBncdDNWk4BJwinXQZZLyCKtTvmR1miG8SoTOaOoESn8KUN1FIVGAtTtQBlUpf1DPf5uaUKgI1TfzRq3ERrU54d7UhjWyN8ON62TTCOFeTn1LGuIcoIpF3FyXcSPeEnRO9ipNEvXXpvRLGbNkZEsOV5mYNlgf9koEthIdPWVLxPuh69iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUpzFJ2Cqa24qaiAkYhK6yBEcFI04MmqzS4ez64aXiY=;
 b=JiWjZON0EHU8/F4iwIF6gujTpOqyJUY/AsJIUojNXzoVCCK+CFsPiLz5IOgbsXx8quM/QSb5RZwInQv8f9kx40G8levBoc0ipERI20ZJ7B1ODgKcDwgHgRXHGpXIecVOEhmSh3mY8KHKz7iWPKl156oUR7zDPq/x+2GoKUC77Rg=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by SA1PR10MB5866.namprd10.prod.outlook.com (2603:10b6:806:22b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Fri, 19 Apr
 2024 16:39:51 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 16:39:50 +0000
Message-ID: <ee7a1664-dfe2-41c4-b635-47affec03ce6@oracle.com>
Date: Fri, 19 Apr 2024 22:09:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [bug-report] task info hung problem in fb_deferred_io_work()
To: Nam Cao <namcao@linutronix.de>
Cc: jayalk@intworks.biz, Daniel Vetter <daniel@ffwll.ch>, deller@gmx.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tiwai@suse.de, bigeasy@linutronix.de, patrik.r.jakobsson@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        Vegard Nossum
 <vegard.nossum@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>, chuansheng.liu@intel.com,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
References: <271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com>
 <20240419165915.228c76e9@namcao>
 <796eecdb-f574-4eca-8cb7-ff426505435c@oracle.com>
 <20240419182313.3f36ac0b@namcao>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20240419182313.3f36ac0b@namcao>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|SA1PR10MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: e1826f8e-b4f3-4f4b-b7e8-08dc608f5532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l8z6m44UPb0449FNl4bVaQaJVC70Cw4na18tDg9c259ZSZ6ZCuCQBNulY5sYJ5kCcG+xtO2OMNUX0aEMOwXYSPqN5EstJkEfxNz6YDl2UOHiz+BcL2WzUZGVQMLvXV7KkrHZqwcAcBxdIAQkMGHnLOgkyid63wWlj2dITSYzAb7jYAUMmBfkKa18m67fbO4oCdBHdI/A7kGxNEsYj6szEhyOaIhimSkDCxM2cAgJu/1lJp7y5NBYjjdh7Y48ttetpSrOY6PjsQq151I54a6NU/mMakYvRneCctq6TRfUrbaaGkscIYp9eemuhfNZ2DG+2m/V8QIAPXXuOCR6HLD5W5F/3zRSeayk80nMtvX9rcJJn0Vc7YQtWuHJ39rOVZsAjacj9pYrFOYSTzCzLdrkeAIdKpxv4IAkEyb0RTstmCzTRT33Pn2hEaO0IVGe+YYcoUdz2RkswvidDfxquxlMGBeSMCcA0034lAiKd1Q6wInQgPrNuaVPH6a/TvNFCw4AedCh37Ky4Hq2vRc1fr9sWXwhOr3uJW4QI0g7y8gtmbWxnxBsCtzCdcKiJ6t315yWgd1b2H37v+yasQ0QvjM1mF+3ZL14z1iwMF4TfhSpRdeu7M0w2RwcLNZ+vjBnV2jCZj6TXyL4Op5QT1Z9Jst0zfuT+2Xg5nvpJLWnd8/Agck=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OXVkQ0UxSzN3Tjh4Q3E5azdZZG1OQUpNOEY5NW9GN1l3NkFoQVdaWXhvOGFo?=
 =?utf-8?B?T1VWVVg4czRxS1hnd2J6Q0lnZmQ0eGcvUDdHam5BQ0xqamdtUUZKT2FHazBU?=
 =?utf-8?B?RjdEVVh6V0pZYk5SMzhBWW1HT0x4b0ZBVXBqc1UwNnhBSE5NcDV1T1RXZFNH?=
 =?utf-8?B?QkxHNnNmVkpSa3dlc21pZnBVYXVDdlBsMEZMKzBQQVlZZGJQRHVXNHg1UmFC?=
 =?utf-8?B?VTRSdXRGZWIwZ2x5WDJ3SE9WSGYxbXp3aHVWNzNZaHQwK0FrOUZTalJPUnRN?=
 =?utf-8?B?dGs2TmF3RjNGTklQZ3VVNGhiWGtPc2JXZ3BKU0VYMzI2NFNZNGVRSTlldWYx?=
 =?utf-8?B?bUhxTmpsK1BhenFrQUZIeHVmZ0ErdnpOb0Mxbjl4RVBWa2pvQWJkNlhldG14?=
 =?utf-8?B?QndOdVFoOUF6MHRMRmNsRmYwcGRwdm03aTlzUGQweUZkeXphSVFxWWN1OUcy?=
 =?utf-8?B?eUVJUlVJNGJ0ZWZva2lrelNqZFRwOGNqNmFnTitCQUxDU0N5UERYRmtTMTZV?=
 =?utf-8?B?NldLcGIwSG9Ock9HNmUyb0V5cXpPbzg4UFN0djJkTkRnS2hkekhJR3c5TjlO?=
 =?utf-8?B?ak5UZURGVHYycStna1BxYVFUNlVpYkk0Q05WWEw3UGtSaURVTThaQ3lKbUha?=
 =?utf-8?B?encxOXBCT0RiMm1xc0xCL2JLZUJmSFRRMVNibmpoWFNzY2hGT2dyeVRJQ2lt?=
 =?utf-8?B?YWpIYUw5ZEJyN3NGNlVtODRBRTc0TEc4Q1U5bDRyd3BPZTNENmtMV2pUbjln?=
 =?utf-8?B?WDY1Nk5QdFJBRE12VXB1YVA3OWtIazJaTWsrdmkyT0pGVVE2dW5mQmpqNmFp?=
 =?utf-8?B?QlBjUU1rNnByYzRaQnp5ZmI4RTFtNGVmelh6NFVaTVdkcDYwSXlCYVQ3TERP?=
 =?utf-8?B?QTVGYTEzZzBlOUFKQ09sTlV6SUc2UmlpbmR1RXd0T3hwQzJOdEY3aDZDR05v?=
 =?utf-8?B?L0RuYUZaOGgxWWNZclVpSzNwQUtacU9HVWIwNTZhc2F2QVllQ3hTcm5RWFox?=
 =?utf-8?B?ZzhCZjVlbHpHODRIUU15SUphVW5oK1NnZ0IrU0JpYXlHSWVlQytqbmRRUWRV?=
 =?utf-8?B?UDhvRGJrTHN2bUowNUVnbnBKQStIUUlFTk1DN0JPWDlnVjJrdGY1amNkWXAy?=
 =?utf-8?B?bTBVeU9VQ0cwdmk4MzR4Y0paZ1ByZUtqY0FpMWpOd1A1SktmNDIybEU0Wk55?=
 =?utf-8?B?anQrcndvNEw0bU0vQWkxb0RVbjZ2dldPMDh1R3E3VTlwWU9qeW5pMDMwVjdW?=
 =?utf-8?B?R1c1K09EWEtZTlNiZ0RrRG1tYjNieVhqbGZHUVNkMVVjOHFvVzRVSURNQ2Ro?=
 =?utf-8?B?dEduYW5uLzBZN2VSWlhOQzRDMXJTZ2EzRExmdXNBYzFJRys5TFhQRDBHRTBK?=
 =?utf-8?B?akp4UEJiRWFzOHJsc2hmOWpCWEJvUGRWVXlhOUk2YzkrdXlHbm4zRkl2Tzdh?=
 =?utf-8?B?aXQwS1pucG1EU1pkWUNYU09FSW5sVHdzczAvTml5S1ZFUUlsc3QyNmN4RUxE?=
 =?utf-8?B?TnFzYVN4YStRZU1YK0V3THRTMU1FbzIram5xUVNCaDR1bEtiRVErb0IwWm8x?=
 =?utf-8?B?VEduSWpqSXRpWVhLZG1TVHVmMm5kakszL1cwVXl4T01mWjNoVXp3V1pEMFFO?=
 =?utf-8?B?L0EyYW5QMEZ6c2JLOGozdys5OFA5L3VFamNOaXRYaW14c1ZZR3I4S0dXdnhx?=
 =?utf-8?B?WThHYU50UjlDaWRoeTlHWjRFMUh1ZzJOeGhHc2xrTVpENzI1WE5FTmtyMVJ0?=
 =?utf-8?B?RkQ1ZG1HZzZ5U2FqMkhjRFhFclBTWXVaL1VIWWVTaFZObkowM1VGaVJxMlB6?=
 =?utf-8?B?aDM0STJKaWx4TVhMdW53d3hvWE4yRnJQNWlVT2tIM0E1UDZObU50Y2VKaVdy?=
 =?utf-8?B?bjJZV1d1Mjk5Uk43Q1d6V1NKVmsrVWt1TWJjTXV3bUR4bm5nRXFUWEY0RGox?=
 =?utf-8?B?dnJqZ1FkSHBlMlcrd3hyanY2TDdwUlVUSmkzQTFkeUdqWEFzMGRtcHBvdWtx?=
 =?utf-8?B?OVZaZ0xSRm1jV3FlbGFYL0NWUXNYSFJXUXJZdjVaclRCL1l2ejgwUmQ3SXB5?=
 =?utf-8?B?OCtHRkN0Zys2eWxDWm5oMnZUSDQ5NlZWM29XVEdRZXdFcVZ6TWV3blZTbWVy?=
 =?utf-8?B?RndyaDFEVUoxd2wyRURyTUE5UW9DZTJZOWZCK0tCbi9TSWN0L2EyaXk0Z0Y2?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6MghEMypoS3yd6gCs9WnwNxnwEw7zgRcYEkm308jXSfzcxoLsLwcj4M9dq7ogCpNz/P2RaUDUjLNSv6jVG3z6hNZn1maWZJSpvJaj0+2/EhqMV7KhpvGB9F2qhH+8peRXQG2IjH3fkqewXlUj5AFdhpke6gNhbtBUpvYr2VFbmR4o1xZ9DYSugsXu5X2Ra/qcl73IMWwlQ394tU4Yg0P+w9/8QCAohF/b8loa3eGmpFdGTzY9Xb0HJtgBnYdpj6FHv3lHAX0ZeHIMHDzMnoyfVQHupGBVxvPtGQr91VUIqIR3xp3GeP8wLS7rK4njKEMh3gD3TxI9PldMjV7gyLliaKaOV/IPKuZ2NOsKaitZkwKGEt6QpFeGN9I9poClZjk2HKlcFyiM072Mi+1lOJqw63piC5SjbqIJeJmVX5z/7HYzShmme9fdSdugYX1jopuiAYQop9zt1Zlu4RYQg9daT46goc/HDLn0pGi5bZv6Xp394M87oMBEqDN3N+nNHJY+a3OE/dq2C91GK28iTy5bqjz+mO8FJMRRZunXTYeRlgb5wNk5nkF3WrrZkmPMOEPp+w6PvCqwkt4iFY14lFwF8mWFS1ibGc+KZEHbDAQIf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1826f8e-b4f3-4f4b-b7e8-08dc608f5532
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 16:39:50.8736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOQrkq1MGXbRaiTlWmi1ok7Ari8LVLUGDuXf5l8jiLc99cyKz8wGAg6KuZBa7luInnoOJCUBZmZ1Pg6Lcm2oswAVRCwIlvQpZVW6mLaCfNuMzGcsnqigLSanUeo2nuyg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_11,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404190126
X-Proofpoint-ORIG-GUID: dzJWF5wDOoSOLo4Rb8skCwTg3JxtpyK9
X-Proofpoint-GUID: dzJWF5wDOoSOLo4Rb8skCwTg3JxtpyK9

On 19/04/24 21:53, Nam Cao wrote:
> On 2024-04-19 Harshit Mogalapalli wrote:
>> +CC stable( heads up as this is a regression affecting 5.15.y and
>> probably others, Greg: this was reproducible upstream so reported
>> everything w.r.t upstream code but initially found on 5.15.y)
> 
> No worry about this, I will add a "Cc: <stable@vger.kernel.org>" tag
> to the patch, and the stable folks (or their scripts) will pick it up.
> 

Thanks for that!

>> This patch works well against the reproducer, this simplified repro and
>> the longer repro which syzkaller generated couldn't trigger any hang
>> with the below patch applied.
> 
> Great, thanks! Can I add
> 	Reported-and-tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> to the patch?
> 
Sure, that would be good!

Thanks,
Harshit
> Best regards,
> Nam


