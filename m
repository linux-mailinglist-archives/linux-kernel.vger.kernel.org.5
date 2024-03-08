Return-Path: <linux-kernel+bounces-97697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B40876DFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FF41F23036
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32773FBAA;
	Fri,  8 Mar 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mArcbJKg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xKkpVEqV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D1C3BBEA;
	Fri,  8 Mar 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709941811; cv=fail; b=DchiV4EC5LMXE8HRWn/8mTzZt0sfhxnsEXNv97AezM1Y4UZkSWlZUcJ378OGQ2xuwKOGUPsQArQoPIM2yTm0nAn7V6qZaoMCKCRc6pfY76SMuBr71jKLR14VdxeYPFpxQGJNXfBbrUxedjc0YOVMAX+gIAXAk/MNNUN4psQnaSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709941811; c=relaxed/simple;
	bh=aMUD1av/10iaSbag8NZHOam6c+9Q5ktCFDtCqq/uy0Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+xnni/sZ+vilOWGQg37Rp8N4MshcvCXucj/ykrf4zsp+512w8DV4J4Fw+GSi+q5cmOal5LJiN9YIcOoVsphSAmw+e4hltvmD17w2hQe86lflGO93TFXKx8sklNSDmCsyFuDotq50wBehYr3f+ustOu1mrU3UNk3jSSqotEXzSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mArcbJKg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xKkpVEqV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428LaiIO007932;
	Fri, 8 Mar 2024 23:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=09Rdje+pVK5BEXxA4L146ARoyOTkJ33SxpC8Juuj77Q=;
 b=mArcbJKgNaadn6BrqetlWnwqolW0ceoZaAG8795iR99st6po6PKJsmQ6N33caZFyvmPF
 VLqxshWGdp8RHcnL/ro5kC4WWONOYYeEc+LwhIYTiMRqlpaDGbyFza7/Rv1p/n6quFwv
 6YOzNGx50QjOHqbGCE3FTgQdegoIbhQMUApC7feDax1HhLrzkgrH5tt4ud029bHPivR+
 NuglenzM+THqhjLYZvpvbNNk2pL92ulw400BLs66fKfB4lph9gbyIXGRwQ/iZHzikuGu
 ODZfTB25Jl096d5wGuL7q2PDxbw62qS/iOoQIV9tncnFd8HHclH/vd8LOzUzx0CTe1FN yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkv5dr6m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 23:49:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 428Mwmvc013699;
	Fri, 8 Mar 2024 23:49:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjda023-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Mar 2024 23:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/fdmrSeezoYQpDHvWdBFvKtooQ7txtMzPbowyaTFiztvoqKo2N5u9w7BUaGRpJiUkFhyFlUtuVSNusb4Xl5/lT7TW135xqQCjNqsolsQyP3Lp0uJJ2c8qtti4oIzszhzbGOwDUKo9TdqIfB8Q+AkgR/M5KHTG8LNKwu/K+qI6hiCcoMfieGHhuLOctoZHHTh3MxXmYLEgAwhs9ALoLfCb32xoLKrl2tvGX5bDoqQrQYbHpIZzp1Tleb6F+lkG/luYhiwB1c3iZe3jXL5W+EJRuyQ3mjbsq2h5mpDhQPE1HQnNSjYffpqvqNdegP438F8m/aKc0LGociKWEfdwQrbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09Rdje+pVK5BEXxA4L146ARoyOTkJ33SxpC8Juuj77Q=;
 b=I6C4+g6emV7G0bOougJlmfFhmI/RCb3+LV5wq6B507TkdmL1oR3vYAK0k5S+XYgd3JUsacjOxEZQp7XknQKB2NQDwR0UtcrgKEQ3h4awabA8sdSuyiD/kMGxcwJqE3igeY6Ky3R3R4Rq5l2Mk7th0DRaVhXZZDB1pSSsJSLoDmizjAZGZnDVeeNl29Cc9XSD4Q7iHpj15JlR6g4y2yQE1553hTQj3Mtmbe17KiClPH9KrMEmL61GSoLK6USaxtCckaATuZ0WmAKsnma74/shR+moH/CFsucgHu2ERoltU4TObnES5CkhBOmCKe3JIuBxmO0PlCKfonbABFWaPP5s7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09Rdje+pVK5BEXxA4L146ARoyOTkJ33SxpC8Juuj77Q=;
 b=xKkpVEqVJ72wXIyLotHT3E+uQZLTb1h7nY4Km/E43ILzQ0NabtWgGfZfCYEpWuXDqYiqy6jWWDedEjrOg2dad9SppN4/7AJoeL/e8K+EeOsn6IqcL4JhLhxXrbn9VcenVSPtpzA9YrHoFzR9x9VbHosXsGnz9GFEiyjTgiRula4=
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com (2603:10b6:a03:2d7::19)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 23:49:47 +0000
Received: from SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522]) by SJ0PR10MB4752.namprd10.prod.outlook.com
 ([fe80::bf2:dca5:ea41:1522%3]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 23:49:47 +0000
Message-ID: <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
Date: Fri, 8 Mar 2024 15:49:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system;
 successfully bisected
Content-Language: en-US
From: junxiao.bi@oracle.com
To: Song Liu <song@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, stable@vger.kernel.org,
        Dan Moulding <dan@danm.net>
References: <20240123005700.9302-1-dan@danm.net>
 <20240220230658.11069-1-dan@danm.net>
 <7efac6e0-32df-457e-9d21-4945c69328f8@leemhuis.info>
 <CAPhsuW5QYTjBvjAjf8SdcKmPGO20e5-p57n6af5FaXudSiOCmg@mail.gmail.com>
 <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
In-Reply-To: <739634c3-3e21-44dd-abb1-356cf54e54fd@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To SJ0PR10MB4752.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4752:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e07b1c-5ed3-40d1-4e87-08dc3fca6ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q+qQz0sQ5RypxSuZHsag4mCuDITdsMQ/ooH6/cdI1klzmTY3Ixx5MLCpZWSTZe23II1+xzH64aMfdGcz3/R3QIKsUNBRieLgzElWTRCu3krZZGh84QV8/v1HhnDOCcIySx7ngLLIjiQBV607zXfgIsvsOOJj0oQf64DSl6e1nhjpxuSDieaP/egOsdE9PI7Rpb33xtkQmPZgTQX7Lv+q/27KPKbhz8jQrVbpF7TPXQM9nKBDvC/vs6kR6jNnooQoT3fKcpXqrtCa7Zn2+P9j50QKTmBTr/wXI2Mzgg0llHL3iCrw6AqlqrKDEeMeTlV9O2laZB+7km28fldHyxKbZHDpSlTXeSlQKTEpDbNZ5atruJbGtGz4yKD8h4RanSWehWNNmymN2WelzfAroUBg9ETcUwO3aQXEZPP9WOE5nDhIAzpSen2DB7UhT0WvNwZyjZhJRWfQLF7E4oYmwslSdD0K5JLqwlNH/j1k7kfFApEmY6kOLiL5oarizaQ9F9au8P8INGJvCgqYm8V+Mi/Vi5jwDbAygYM4V6JREK9m8NImFQ6d0X/AUgHRgXFQsO60/c4cVMPMVCoB58fFSzDQ28YsebLKzN5corJvbyXMdpI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4752.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjNaQmUzSVhyOUNHTUJleDk5TmQxeDcxdnNtNGU1ZEVoRHFRanA2aHZWNlhl?=
 =?utf-8?B?am1WZGJKQ3llS05YUm9lMjMrc1pDakE1U2NqODFaV0Z1QzFmRTZGb1NwVjk1?=
 =?utf-8?B?YjFWaEtrSHdMcndUMzhXQS9QWVJOUzRFUlFEejFJYnVzZUJYVFFxUENoVXVG?=
 =?utf-8?B?cUxUZ2pZdDlYNy9Od0pVWUllTk8rejVBZFMvR3Z4OGZ2cTRqOFZtZ1pmTUN5?=
 =?utf-8?B?aVRMSVFSN0cxLzl6Z1hhV3ZBTUtXVFhCc3FFZXV2VFlFb0pBd1ZEbXhHYVh5?=
 =?utf-8?B?a1FDL1BCeWRGQmxLSGZkWXdKNUk0dkl0VXYycWx1V3VlY0NZeElta0FxdVdk?=
 =?utf-8?B?M0VPa2VKSFBkODhaaTZaWC9pTExyT0NQdmlRMzh2TVhNZTBqazNQb0t4Sm5Z?=
 =?utf-8?B?a0w2djlXcGdMYkMrVlFUWFZidGt1cE9wTUE4dmxsM0Zwc1o4Vy9TbWkvTjRQ?=
 =?utf-8?B?LzBSNDJpZVdsMGhsZXAxRzJMdU5adEFsTVlCU2Y2VVo0bHNSYzNGTW84OEVm?=
 =?utf-8?B?a2UvSG00a1ZGaWRGUEhQSFg1SnNwQ2pzYnNkemVHZTk4MjloSWdiM2xVZCtW?=
 =?utf-8?B?WWR0bDREMlg2WnRqOHNVeEl3cFhaU0o0bjV3VDV2d1hEOVpRcXZTVUN2aTVU?=
 =?utf-8?B?citpYlcrQmMvOHUvZU9aOWx6SzkwaXQrMkN1T2ltL3dvaGw2cFlXRmJBb2RN?=
 =?utf-8?B?d2pRNU1EZ0FwaS90SEptUG5CaDJiNTN3OXY4aExJV3NVdEZ3b0pLcjNadW9W?=
 =?utf-8?B?eHhBZWd4VXR4Ym4xVDg2a1lHWWxURkgzRy9wcWIzTFpQdlc4cVpYWFBldDFZ?=
 =?utf-8?B?dzZza2RadFFMZWZia3NHSldPZWwxNHlaOU5JK3psdnlJN0NOUjB2a0ttSktn?=
 =?utf-8?B?V0FxaGVkTmJId3YyQWYvVUtSMXc5SHhrMkpxYlk2SUpuUXVFNnNrd2tUUE00?=
 =?utf-8?B?ejZDZ3d4QzZwSzk2OG5oSUxweEdicFNQb3JscElmNUtFbmsvOGtRcWVva21v?=
 =?utf-8?B?VElIdVMvTVM2TnROWVVBVnRyOXUzejFNR1M4N3hnSkc4djFCVjl3alNYTXd2?=
 =?utf-8?B?RThZakJmQnQ3c2loRkJEUkl3bWhNOGliUUF6VGhkV1FXdWpxNThwOVgyWVRy?=
 =?utf-8?B?ZVZKbFZVNGpXdWFqcnQreDdoSzNNWXErakRMMzBqTzZ0ZDBJRXVoY3VTWFl6?=
 =?utf-8?B?akVwcHEvRldMamJ1TTVCZEVkNUpNcWlKRGpPcFF1dFpFUCtNVUtKMGtPeUtv?=
 =?utf-8?B?ekdiNm1CODNad0gyTkJVMk9Gc3BIVmJ5S2tuN2tmdEIwYklnaFkvN0l1elp6?=
 =?utf-8?B?Q2Uwd0hQQ2V2UUFhK2hsaGw1c0hqNXZZa1pPUjl1bDNrc1Rjd1R0T1RtR2tO?=
 =?utf-8?B?K1kyYi9taVp3OExKdk8xMnluWnRqU2hHaEpvVWhkOG9LeldBWWtUMDVUd3hV?=
 =?utf-8?B?VHhVMi9JSFZwdkdiRDFxNXdGQ285cytKbGg1cmVteXExRGZoMnBmS0Ewb0U1?=
 =?utf-8?B?Uzhpb09uNHo4WGRQck9raWhZZmZXMzBqRVdoSURNbEg3a3lpcjBUWThUUVRJ?=
 =?utf-8?B?WXhFUFh6NU1FQmEwVnBBc2JkM2ZzMVl1czVTVVE2MzJleGppTXQweWlhZjQ5?=
 =?utf-8?B?SGtVWXcyay8xK3ZMNVZscUhvd21ESnduaVNCcXZmTU1Qb3BhSW02MEJiejNt?=
 =?utf-8?B?UEJzSG91ZVdlbkhXQ3hBQXBuUXlhK1JDM1JzcDljNkEzMDl5cDYvMGYrUnBz?=
 =?utf-8?B?blQzMVR2ekd0c0tJY2xZZjV1YWcvSGxGUkJqc2c0d3dxMENKMXBzNEZFUWJq?=
 =?utf-8?B?ZTZDMlVxQTF1RG5QQzh5S0sxU1VrODF5SjlCUlFMeVdtL09mUmVmclBVZnJC?=
 =?utf-8?B?KzZaQ1liemRtTGlIcVcrREpVS2U5RHpGTkhzV3NKQ3RPSHRDYnlVdFhSVm5Y?=
 =?utf-8?B?UXFNVy9BM3FDZFdjVUgrNnZZWEsrb1BsQXhzdUpHL2g2TkpoVWVnbjdXMCtO?=
 =?utf-8?B?K3pMdXg5cWN1aTIwbFE0REIyUDFPZlB5czhFS0pkVlFhSmFocXlwWVI3V0dE?=
 =?utf-8?B?UlZNUWIrcFVZVTdueUFJT1E3WnM3ZzNQS2tZRW1Qam9TNjVkbURFM21MODI4?=
 =?utf-8?Q?1C17iQ0jhBlkmvr/q+U5tAWOo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zzvZzXldQwRyRd1ypgpUsIclaS4SBwzpzwR90wIhDEnOPO+FEe2quYlN/lJ0yr6WmKlq5z4Le8tW1dlrWUkKhok092HEOO4iCo0L/6LA8+AJ/6mSbvlNAHnzjI7gUeIGaGUaExtWhqf6vxLeyienvRVWcoEzmCknZKQxekHgB4Leey54K4NMB+L/UxYMAPVZDMGeXNyjnXo7auxWgtAy0+3p3ItLp0V1c9ED646m434E+CDj20aLgYCkeZ28Yt2ysVdNcmHQPvZO8bzXfOiMGeCa4smbdEQcqBkHOXkR5JYu3YJ4rxYV9G6kc3XbNsuhnwqG4dS1eZMQTAmxDQOSCMmymrAuSE7iksPR8eQMd/QdE3zgTLDDRpgLqVWR9XQ4lnzV+mRSqRSeuh/xV1Kcc0k4v1x8qZCJvpLZt/pSo//IR1vVwNBvYE2JntMNfTEmnZjuU79Vlsso8jxmAMlEpMtoyk3Y+fBO3nJe7iTDduBpKsOQux+Ld7HtBlBBrgkt+fJu1AmyeSvU5Mwx06Q3o4NwfpheVbf/3ItrCKg6diRcLJOxvm4YS88Dbaf/DIb0CWCsSdhDZZry5ADLLOTv20UWQ8zEuMMa4sZyvlZ6YsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e07b1c-5ed3-40d1-4e87-08dc3fca6ff0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4752.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 23:49:47.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N+gx0TQX56Vg0DL6bs0KyN+3NkZeAVxavCvhk2QrRTG5VmG0JTMIiZctByyMkyw/Ckn7DUzWhUPsahykpXx4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403080189
X-Proofpoint-GUID: UEzpABhoGgWt1DRCL55cjN85KNDswNhp
X-Proofpoint-ORIG-GUID: UEzpABhoGgWt1DRCL55cjN85KNDswNhp

Here is the root cause for this issue:

Commit 5e2cf333b7bd ("md/raid5: Wait for MD_SB_CHANGE_PENDING in 
raid5d") introduced a regression, it got reverted through commit 
bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in 
raid5d"). To fix the original issue commit 5e2cf333b7bd was fixing, 
commit d6e035aad6c0 ("md: bypass block throttle for superblock update") 
was created, it avoids md superblock write getting throttled by block 
layer which is good, but md superblock write could be stuck in block 
layer due to block flush as well, and that is what was happening in this 
regression report.

Process "md0_reclaim" got stuck while waiting IO for md superblock write 
done, that IO was marked with REQ_PREFLUSH | REQ_FUA flags, these 3 
steps ( PREFLUSH, DATA and POSTFLUSH ) will be executed before done, the 
hung of this process is because the last step "POSTFLUSH" never done. 
And that was because of  process "md0_raid5" submitted another IO with 
REQ_FUA flag marked just before that step started. To handle that IO, 
blk_insert_flush() will be invoked and hit "REQ_FSEQ_DATA | 
REQ_FSEQ_POSTFLUSH" case where "fq->flush_data_in_flight" will be 
increased. When the IO for md superblock write was to issue "POSTFLUSH" 
step through blk_kick_flush(), it found that "fq->flush_data_in_flight" 
was not zero, so it will skip that step, that is expected, because flush 
will be triggered when "fq->flush_data_in_flight" dropped to zero.

Unfortunately here that inflight data IO from "md0_raid5" will never 
done, because it was added into the blk_plug list of that process, but 
"md0_raid5" run into infinite loop due to "MD_SB_CHANGE_PENDING" which 
made it never had a chance to finish the blk plug until 
"MD_SB_CHANGE_PENDING" was cleared. Process "md0_reclaim" was supposed 
to clear that flag but it was stuck by "md0_raid5", so this is a deadlock.

Looks like the approach in the RFC patch trying to resolve the 
regression of commit 5e2cf333b7bd can help this issue. Once "md0_raid5" 
starts looping due to "MD_SB_CHANGE_PENDING", it should release all its 
staging IO requests to avoid blocking others. Also a cond_reschedule() 
will avoid it run into lockup.

https://www.spinics.net/lists/raid/msg75338.html

Dan, can you try the following patch?

diff --git a/block/blk-core.c b/block/blk-core.c
index de771093b526..474462abfbdc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1183,6 +1183,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool 
from_schedule)
         if (unlikely(!rq_list_empty(plug->cached_rq)))
                 blk_mq_free_plug_rqs(plug);
  }
+EXPORT_SYMBOL(__blk_flush_plug);

  /**
   * blk_finish_plug - mark the end of a batch of submitted I/O
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 8497880135ee..26e09cdf46a3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6773,6 +6773,11 @@ static void raid5d(struct md_thread *thread)
spin_unlock_irq(&conf->device_lock);
                         md_check_recovery(mddev);
                         spin_lock_irq(&conf->device_lock);
+               } else {
+ spin_unlock_irq(&conf->device_lock);
+                       blk_flush_plug(&plug, false);
+                       cond_resched();
+                       spin_lock_irq(&conf->device_lock);
                 }
         }
         pr_debug("%d stripes handled\n", handled);

Thanks,

Junxiao.

On 3/1/24 12:26 PM, junxiao.bi@oracle.com wrote:
> Hi Dan & Song,
>
> I have not root cause this yet, but would like share some findings 
> from the vmcore Dan shared. From what i can see, this doesn't look 
> like a md issue, but something wrong with block layer or below.
>
> 1. There were multiple process hung by IO over 15mins.
>
> crash> ps -m | grep UN
> [0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0  CPU: 1    
> COMMAND: "jbd2/dm-3-8"
> [0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0  CPU: 2    
> COMMAND: "dd"
> [0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3    
> COMMAND: "md0_reclaim"
> [0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740  CPU: 1    
> COMMAND: "kworker/1:2"
> [0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80  CPU: 7    
> COMMAND: "kworker/u21:1"
>
> 2. Let pick md0_reclaim to take a look, it is waiting done super_block 
> update. We can see there were two pending superblock write and other 
> pending io for the underling physical disk, which caused these process 
> hung.
>
> crash> bt 876
> PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
>  #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
>  #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
>  #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
>  #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
>  #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
>  #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
>  #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
>  #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
>  #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
>
> crash> mddev.pending_writes,disks 0xffff888108335800
>   pending_writes = {
>     counter = 2  <<<<<<<<<< 2 active super block write
>   },
>   disks = {
>     next = 0xffff88810ce85a00,
>     prev = 0xffff88810ce84c00
>   },
> crash> list -l md_rdev.same_set -s md_rdev.kobj.name,nr_pending 
> 0xffff88810ce85a00
> ffff88810ce85a00
>   kobj.name = 0xffff8881067c1a00 "dev-dm-1",
>   nr_pending = {
>     counter = 0
>   },
> ffff8881083ace00
>   kobj.name = 0xffff888100a93280 "dev-sde",
>   nr_pending = {
>     counter = 10 <<<<
>   },
> ffff8881010ad200
>   kobj.name = 0xffff8881012721c8 "dev-sdc",
>   nr_pending = {
>     counter = 8 <<<<<
>   },
> ffff88810ce84c00
>   kobj.name = 0xffff888100325f08 "dev-sdd",
>   nr_pending = {
>     counter = 2 <<<<<
>   },
>
> 3. From block layer, i can find the inflight IO for md superblock 
> write which has been pending 955s which matches with the hung time of 
> "md0_reclaim"
>
> crash> 
> request.q,mq_hctx,cmd_flags,rq_flags,start_time_ns,bio,biotail,state,__data_len,flush,end_io 
> ffff888103b4c300
>   q = 0xffff888103a00d80,
>   mq_hctx = 0xffff888103c5d200,
>   cmd_flags = 38913,
>   rq_flags = 139408,
>   start_time_ns = 1504179024146,
>   bio = 0x0,
>   biotail = 0xffff888120758e40,
>   state = MQ_RQ_COMPLETE,
>   __data_len = 0,
>   flush = {
>     seq = 3, <<<< REQ_FSEQ_PREFLUSH |  REQ_FSEQ_DATA
>     saved_end_io = 0x0
>   },
>   end_io = 0xffffffff815186e0 <mq_flush_data_end_io>,
>
> crash> p tk_core.timekeeper.tkr_mono.base
> $1 = 2459916243002
> crash> eval 2459916243002-1504179024146
> hexadecimal: de86609f28
>     decimal: 955737218856  <<<<<<< IO pending time is 955s
>       octal: 15720630117450
>      binary: 
> 0000000000000000000000001101111010000110011000001001111100101000
>
> crash> bio.bi_iter,bi_end_io 0xffff888120758e40
>   bi_iter = {
>     bi_sector = 8, <<<< super block offset
>     bi_size = 0,
>     bi_idx = 0,
>     bi_bvec_done = 0
>   },
>   bi_end_io = 0xffffffff817dca50 <super_written>,
> crash> dev -d | grep ffff888103a00d80
>     8 ffff8881003ab000   sdd        ffff888103a00d80       0 0 0
>
> 4. Check above request, even its state is "MQ_RQ_COMPLETE", but it is 
> still pending. That's because each md superblock write was marked with 
> REQ_PREFLUSH | REQ_FUA, so it will be handled in 3 steps: pre_flush, 
> data, and post_flush. Once each step complete, it will be marked in 
> "request.flush.seq", here the value is 3, which is REQ_FSEQ_PREFLUSH 
> |  REQ_FSEQ_DATA, so the last step "post_flush" has not be done.  
> Another wired thing is that blk_flush_queue.flush_data_in_flight is 
> still 1 even "data" step already done.
>
> crash> blk_mq_hw_ctx.fq 0xffff888103c5d200
>   fq = 0xffff88810332e240,
> crash> blk_flush_queue 0xffff88810332e240
> struct blk_flush_queue {
>   mq_flush_lock = {
>     {
>       rlock = {
>         raw_lock = {
>           {
>             val = {
>               counter = 0
>             },
>             {
>               locked = 0 '\000',
>               pending = 0 '\000'
>             },
>             {
>               locked_pending = 0,
>               tail = 0
>             }
>           }
>         }
>       }
>     }
>   },
>   flush_pending_idx = 1,
>   flush_running_idx = 1,
>   rq_status = 0 '\000',
>   flush_pending_since = 4296171408,
>   flush_queue = {{
>       next = 0xffff88810332e250,
>       prev = 0xffff88810332e250
>     }, {
>       next = 0xffff888103b4c348, <<<< the request is in this list
>       prev = 0xffff888103b4c348
>     }},
>   flush_data_in_flight = 1,  >>>>>> still 1
>   flush_rq = 0xffff888103c2e000
> }
>
> crash> list 0xffff888103b4c348
> ffff888103b4c348
> ffff88810332e260
>
> crash> request.tag,state,ref 0xffff888103c2e000 >>>> flush_rq of hw queue
>   tag = -1,
>   state = MQ_RQ_IDLE,
>   ref = {
>     counter = 0
>   },
>
> 5. Looks like the block layer or underlying(scsi/virtio-scsi) may have 
> some issue which leading to the io request from md layer stayed in a 
> partial complete statue. I can't see how this can be related with the 
> commit bed9e27baf52 ("Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING 
> in raid5d"")
>
>
> Dan,
>
> Are you able to reproduce using some regular scsi disk, would like to 
> rule out whether this is related with virtio-scsi?
>
> And I see the kernel version is 6.8.0-rc5 from vmcore, is this the 
> official mainline v6.8-rc5 without any other patches?
>
>
> Thanks,
>
> Junxiao.
>
> On 2/23/24 6:13 PM, Song Liu wrote:
>> Hi,
>>
>> On Fri, Feb 23, 2024 at 12:07 AM Linux regression tracking (Thorsten
>> Leemhuis) <regressions@leemhuis.info> wrote:
>>> On 21.02.24 00:06, Dan Moulding wrote:
>>>> Just a friendly reminder that this regression still exists on the
>>>> mainline. It has been reverted in 6.7 stable. But I upgraded a
>>>> development system to 6.8-rc5 today and immediately hit this issue
>>>> again. Then I saw that it hasn't yet been reverted in Linus' tree.
>>> Song Liu, what's the status here? I aware that you fixed with quite a
>>> few regressions recently, but it seems like resolving this one is
>>> stalled. Or were you able to reproduce the issue or make some progress
>>> and I just missed it?
>> Sorry for the delay with this issue. I have been occupied with some
>> other stuff this week.
>>
>> I haven't got luck to reproduce this issue. I will spend more time 
>> looking
>> into it next week.
>>
>>> And if not, what's the way forward here wrt to the release of 6.8?
>>> Revert the culprit and try again later? Or is that not an option for 
>>> one
>>> reason or another?
>> If we don't make progress with it in the next week, we will do the 
>> revert,
>> same as we did with stable kernels.
>>
>>> Or do we assume that this is not a real issue? That it's caused by some
>>> oddity (bit-flip in the metadata or something like that?) only to be
>>> found in Dan's setup?
>> I don't think this is because of oddities. Hopefully we can get more
>> information about this soon.
>>
>> Thanks,
>> Song
>>
>>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' 
>>> hat)
>>> -- 
>>> Everything you wanna know about Linux kernel regression tracking:
>>> https://linux-regtracking.leemhuis.info/about/#tldr
>>> If I did something stupid, please tell me, as explained on that page.
>>>
>>> #regzbot poke
>>>

