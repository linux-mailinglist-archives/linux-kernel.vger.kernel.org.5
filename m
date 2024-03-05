Return-Path: <linux-kernel+bounces-92610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1818722D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8551C2301D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C35128364;
	Tue,  5 Mar 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QvxHSk/X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LdjTLl8n"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE094127B4C;
	Tue,  5 Mar 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652670; cv=fail; b=Pf7zcjWYOY3koTsAndegGa87ThBW5NkS8BjcyuuP2pTZ1qQmJSFHU/2WzerePd24AEsrnuPpWDsT7zBS2HC+oC3UfvChsRTyD40egJG9KOLcpgPsYV+KxvcMrUJDYVVpq+JMBwVWbpR4kayp/5o2ZlHSdaQAUWoDoj9mbSLXmI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652670; c=relaxed/simple;
	bh=4EAnYLUrWIHN/6kCik9anwwNwMmyudJ+LufRkWpOrnw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFWNDNItCBeIvmeI/INukOJnHOxrXx1L0J+Bfq5wuhrrYDFiKVlBvqeKb7je4oGgq84ux1fQjwpLN37hmNrO3KqSmkBBKbGtYT1K8o8+wcuJXNSJfq1mnKDf5qGtJ6LY10fMzHyRl97ByMfmXcO8h3hR4bDUqIV5ZgSc9j/gobc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QvxHSk/X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LdjTLl8n; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 425DahMH002140;
	Tue, 5 Mar 2024 15:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e5i52ml77zMa3M0XN1A4IwM9PfbETbb6byJ+kWz12e8=;
 b=QvxHSk/X1Vm5Hr0W/fCGO2uFl8kKw7OqIMccg0lnJJkVXVX9zoj2KVG5gke1qGn42ZzK
 o27YiKngQtsg2U7D+7Xti1dzWUS9+RjqEtaTnTqec8iG0c/CVpi9FGBF7aUd6Zn8hTPo
 snIVfhO4ADsFBN+HexZ5o23+5T0ac6ondc4hqHOs0y3jhNTNnz0i7qtUa6axG2l9Ky0z
 knHselLF+P32B0m0pSGjoZwmQ88QttAD1x7uwDV4UwImeQn6HQCLGZCMgU4M05EbKshd
 ZSZhoAU3qZmp4+aiZbJ8WbwqUEi/pqOS9wpI5GtDBeeceBVSTEDrc/cIFYYWgtLrt8Hu ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkuqvednu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 15:27:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 425EQFIh027436;
	Tue, 5 Mar 2024 15:27:03 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj87wve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 15:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSGuZDdSFixCJD14cssbimINq8QoNPGfPMtYUIjEhrCmhBH/aSvNNHT6rjU6TOp/n7ChCoxOMhfCWfUSXsS8jeVguWHrxy7KL4JknnvkEznLBm4RPrjWAZJbBizMLwnrpaCXhBArKcfTqe9QEwB+HoSqNXY/ki7AhWMn6ABrBC6/93ME8za2U460ZclG1PR4F8ZojbFeifRZ2WtuGDolkKA4FLvmgsqJDhpFTdbPFO77Q24tEyE7ES1S6r+7mngZhZQOMNOnXItgzziau1j/lW1o/Ew6Gt9WGZjZfrjdX6JYNeBuMSBMpMT2zjyURa1Q4fgilBKBSD+wBdji3utlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5i52ml77zMa3M0XN1A4IwM9PfbETbb6byJ+kWz12e8=;
 b=OfDc1HTvq8ryVhbjteon8xHuY63F39BfrWdN45zxeyavkh03dfUZUWFsq4AcDHnuvHNCIb0Xybo6KpOW4eszTYAMjZofiIws47U84dwTZuqs1OVEziA2NgNU5ArObTNWwjUY0i6P86WqGLIENosWXv5RqBQdO71sJfU2wdxJVmfyaLR377JJoEagukRwWF0W7wwpZqkljq6jEQZdQ958XnSl6mJAb6CzgKrjBU4F/9u/5XCqoUTtjlX4i7K+DTHLwfRmZkaKCEfqVcWcXcHVyrVGA1/uNEfwKyXo6bhADjGv4Q3u6DwEvBDVtZ/pBRdy2E6DXS6K0LwH7NEfXg679g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5i52ml77zMa3M0XN1A4IwM9PfbETbb6byJ+kWz12e8=;
 b=LdjTLl8nCMB39kCf717wk29baCliX1fULL6Fg5zcLI5+cJZgYDjLtic4v0zLfgxSiXnO02ysm9iWNEl03YMRlGSief/mzeqnNmvnKI9ed9rjfs+lR2hRl99vOGDizaaQz4OvYM5saIkESZ6CHuUBzm+ybDN1chURQl2mOoXtwFY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:27:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 15:27:01 +0000
Message-ID: <afab3c4a-05b1-4da5-9646-34fbf988072c@oracle.com>
Date: Tue, 5 Mar 2024 15:26:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] scsi: mvsas: Use LIBSAS_SHT_BASE
To: Jason Yan <yanaijie@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, chenxiang66@hisilicon.com,
        jinpu.wang@cloud.ionos.com, artur.paszkiewicz@intel.com,
        dlemoal@kernel.org, ipylypiv@google.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305122452.340471-1-john.g.garry@oracle.com>
 <20240305122452.340471-6-john.g.garry@oracle.com>
 <8834df38-413d-855c-433c-653d7023dc8b@huawei.com>
 <f54e9c30-b483-4dae-9b22-24feb4fc289e@oracle.com>
 <deae273c-7789-e8da-1256-777d01a4ab9f@huawei.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <deae273c-7789-e8da-1256-777d01a4ab9f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fe2b5b-c20f-45a0-6434-08dc3d28b418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kQSH1X3WtgYbCx/ZzihvesXpMwweQbl7BuIpyFTvYVaUJNHLLwMlpA7yp5ffD6QJWRVpsufBwzXdn1oPWfNsYSQZIGyneh7mvOvo/2kSUSMcx9cuZelCDVXAJaovrMrgMqWdxt8MKDRprP001Jo9Q2HlEPTgm/zb4S7ERqqBhxRqW26vMJh1rytDZaKkB7ChC/DpECcZeKqCFO//k0VWPPJyNsS0pPsnEVGIOiyn3u9/nhN1Z3DxWB/G8EnJUii3iOIiQLgRrQAfEO2sqOIoXJYC03Z3iuRWDdCTMoa0220LUn1MwuJfHzoLWhoIWM8o3i9rn/Dq1LG20ojj9btC/ixz9Pd/MJtJbm7psFhwnq2w+hloZVfPwvwwzhMf+L4ztBTI7esR2+pz1dcE7l8/L6NHGqyuIw8/VoGN7oCmJ8CnN+7JyGPqsDLhllXGK4uF1TaZLENr9HlipfpR3EKCjz+EKiINaRsPEcCJbFzbWfa4RCyReTx8TK88bsMLaWET2HgzspHRPSgMiDBMbIJPMYLagPmPBMFKdOBpFSQXoxPYfaDB1UtTtguAkVjR6IFhrYMUQQWRpUoqVnxwcOajV1Sv3ZQhIrp+O/eVG9ugZYvXPfM6+JxOhiA2LcoPmpch+oNpxmdYTT+XgoBQBy589B3UFJRGUbAVKnunjinZ25Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ektGS3V0WWNsVlZyNW1QNENSZGQvTUsyLzhnalRzeENDOW9YU0xyL1ArMkFz?=
 =?utf-8?B?Zkhmcm9RL1JROVRiUmcycUhSMExKTG9nUHZVejZZWW5TeE9BTlY4K1U0Z1hu?=
 =?utf-8?B?Qld6UDhwVkVrQ0lEMHk3bmRwRjVFRXZUN09FUGs3ajl6OTZpZnVKTWJCWGds?=
 =?utf-8?B?VWozNGdNUlg3THhEUVlDa2VTSkdSZHloZEVzTVBBbGR5RjdSNHdIYmd4S0h2?=
 =?utf-8?B?WHJjN29DSCszMnB3MmhVRXQwaFBTZnVRUmlFUnZHdVhwNkpBWmU4UytEd01Z?=
 =?utf-8?B?OHduZnRDQ2liZVA1eUNnQkxyOW1DcG56UDN0QVBwb0Fzc3RuZWdHNWR6WXFa?=
 =?utf-8?B?U3g2cFZ0Y3UwdUE0bGp2UVdWVVBRQzE2K3JQdEtaMytTL1VPRWNsNFRSVE82?=
 =?utf-8?B?aHFRUlYrZmk3QUpuMFF1eDhSdFFoOFBuV0tvbmNKMXEyOFhyQ1JsREpBTm1X?=
 =?utf-8?B?bzMrVmdYaHhiM3FVRVc0MVdzOFRqUThYYlBzVzk3U0pJQlhIeHlTanJKU0xl?=
 =?utf-8?B?YVNGOEh3Y0wyMkNvNnUyWWJwK0lDQlpWYW1kaGlqN25naHJra05OaXpuWitM?=
 =?utf-8?B?aFJoVkx5MTZmMzZ1VnRUK2tjSXV2S0t2VVhBZzlja29KbWxxdUFYTG9VTDQ1?=
 =?utf-8?B?MGIzV1FpaTl6cis2Tkd4alBCS1RmekZLVnlEL3Z2UU84T05MYWllb1MwT3NQ?=
 =?utf-8?B?aXdicTdRRk5VNU1PdURzQ2tBUk9FTmo4dzZWU3ZDMFdIV3ZubVJJb2J0SWNF?=
 =?utf-8?B?VXErQWV0ZE9Qd3c3QmVqOEp5U3dOR2R0dWF0TklPNzRpZzUwL2xqbks2a0xH?=
 =?utf-8?B?eG1uOUtzazExeXMxc0FBWUIxdUtqeVhmcHdWOXVZTVpQQ08rK3dqaWdpUlBq?=
 =?utf-8?B?WHllZEpEOFM5cFd6cGg5NmdaNVdCdDk1dlhWVUVGVE5XYkJ6M2JpeG1pVHFK?=
 =?utf-8?B?TE05SnArNTZTZnlwZEliTjNUU2sxaW5JanVMeGVoZG41NFdTSENMamlJN0pt?=
 =?utf-8?B?THBJMkxONWxIVmdWbk1UcEEySmtDWTVET21iTlVrRlcyMU5NYUowVnVkNnBn?=
 =?utf-8?B?aFRVRkpNaSs5RThDY1pBc1Viblc0cVpNTFZIQ2tZSEdWWGdqZ0NOSnd1M2FG?=
 =?utf-8?B?MmhPOTY4VnFqTXJnbHhBUGhYcmVzM2JZM3JnZ1BpSGFhNVBBN1RxUVVzY0pa?=
 =?utf-8?B?RkhqV252WDduVzcwcFg1M004RFpuSndlS0t6T082cGlYUGdsSVgvYTRmN3Uw?=
 =?utf-8?B?MmQ2VmM5QnVFVmx6eFA2Z1FwV2F1RERpOThuRk9BK2FndERVbmpxKy9KTDd6?=
 =?utf-8?B?dmUwUHNsY00vdmhnVkFuUzJwNFlwU2tDUTNYOURvRjVrRWRvc1U5elFIZVM1?=
 =?utf-8?B?YjNpUXNKQXFmYkdkSXk5V0dyb1ZmeTN6U295Z3VFb0lMaXJYQ21RcnlVTjRz?=
 =?utf-8?B?YXA4OTc4M1FOdlNiOXVDYWRhcVFxTU84TExIbDFDMDdmMktPMlRmaDFQVFpi?=
 =?utf-8?B?RWVNUnA5aWxjMzArNnVhM1ZWMGpLblJzSGZTOUNrdFFTWFA1Nk50dGZIaHB5?=
 =?utf-8?B?VGRjZUlRY25acjNZdlovbXYrbGlyam1nLzg5dUdNZDNjYmg4dXg3elRjWTBD?=
 =?utf-8?B?ZEU0MlJJbmkvMG5INEdYaDB2Mk4zRE1EVWxQWW5GZWZlTXJad1dRY1RKRE5W?=
 =?utf-8?B?NUZEUFIxQkh3THRYOG05bmJsamdtNDNNS0NLS3l0KysreWpKcGZEWEk1V1FX?=
 =?utf-8?B?Q0N3eE50SFBTbHVFeWRrNE1GZ3A4Ym5WbGMycXdoaDJ0T3FRb1lqbTVmcm9s?=
 =?utf-8?B?OC92NXFjeGxKaDhlU0hzTTJDRG5XSmU1cGJuZjl3ekxtK2ptQXNTUjF4bmpW?=
 =?utf-8?B?RlZ5amR4cVJEWVMzMjUwZWNQRnBLSlBKUm9lUlNuS2VpeU5mYkpLNmFOVmZn?=
 =?utf-8?B?K1lUYmdCT1J0YldxVVVWbHJydnlqOUJtdjFUSFVaSlh2UXpRU2wzZDQ5ejNR?=
 =?utf-8?B?c0ZMUkpkZDNDUkFHL0N1V0ZsM3BHVmg3Y0tQd2FNTHlBUk9kcnoyNEs3VzJ0?=
 =?utf-8?B?U0V6YXlJTTBXU1VXbXFEZUhwZWtvZmxaMHJzLzFSZThLY3NCdWVZZmgrYitz?=
 =?utf-8?B?UnhrMGw0dEw1ZEVtb2tjbXo4V0ZyR05ieVRRaWRtd3VIRTlBYS9qclVuaTBK?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3gTLscGqBzOToY0G7cSfleeaENIzwLgURulch0EAo/WuhqQakCbd8qOO5MXU7rp02o9jqaMoQC00Anf+SelR/HJYW8tRAy8+6+fJWQezvjMTcYGqnfAZ6pq2uOtqAgW5MZ0PdtNgO30qwexvhjy5RToNjNakux4HdU/l/QYLfOp0V6OioZDcADQ3+Vg0/iprkXsHpT81w4IL9UNcHLs7T51tcIZ6abtHLjVhT/d6ELQbf7VwHkIzNNKqr+dQFiAqyzD1olgTuKtyZotNiMTCwEsCEVLeRXaPhLfvP/1xDQYsWkj2Xe4Kywit80gmr2lpINetbHB9yc6RrH9DLaeXNEZCRSbJzPTSGMlyZ/e8K9VON1rVktaTgtSv+mgmhBXzythnUE6hxYLBJ3Xcb47H5cXLop6VJ+RkzDx/oVdhfmASP4pR53Y32ySKsFg89cbIWW5RpnT2eBgMGMEjKIenxsSvWKLERTngpxO1qJQC3UpGGFIet6U+mQgV9DLbdUtqIUfuTBnhfjVjj/ddwRVrnmy3NOP3MWNbj3A9544RrnfTWQWqey8EVcMu3xXAtV8EPv8EEI02Z2R46Z9qfjn5bZZLcyNhPO3rm4Vxvskmzkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fe2b5b-c20f-45a0-6434-08dc3d28b418
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:27:01.1183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoI8mlm1RqHBcpJRnml8GF748ycdFX5DCxCh/wsW8VnYQAr1eN8yp+orfVQZLAM2v2gslAMKDTgTGXf1XiIdiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=972
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050123
X-Proofpoint-GUID: VsfWMkCyaJJkkwIQ_7MTBA8QgUr9D0Vp
X-Proofpoint-ORIG-GUID: VsfWMkCyaJJkkwIQ_7MTBA8QgUr9D0Vp

On 05/03/2024 13:47, Jason Yan wrote:
>>>
>>> Doesn't hvae ->eh_abort_handler too.
>>
>> Is setting eh_abort_handler actually really ever required for libsas 
>> drivers? We have sas_eh_abort_handler, so I assume so..
> 
> For now among libsas drivers only isci has eh_abort_handler. But 
> LIBSAS_SHT_BASE is setting it by default. I think it's better to keep 
> the same as before for other four drivers.

Sure, but I do wonder why it is required for isci, if at all - I'll check.

The motivation to not require it is a smaller and consistent API used by 
all the libsas drivers.

Thanks,
John



