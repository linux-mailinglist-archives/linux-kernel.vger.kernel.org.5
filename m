Return-Path: <linux-kernel+bounces-155695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CE8AF5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF491F27FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02713DDDC;
	Tue, 23 Apr 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oz9LMlPd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PCv1pZPo"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B013DDA5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713893887; cv=fail; b=FLRmvA2Jh2BJi1WRyipXHBd6+WGALHP0QIjSSOUEFejQJHK3kOHMSaf9UG4ZhG7Bn1WX6EHvO/sjsIoZEJwVL2q4mIr3YvvtCqBhL3tO3H8/C/VdL6JXhxmE+fNh0tqhw5Zgm1GfjKmEqWsNY+qVi2tiP6ERQYne1VBNZB3TRGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713893887; c=relaxed/simple;
	bh=f9v9y4QJuHcazE6+RIRvTtooT/Pn+1feOgTIGxMtq3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ITD3NPsr4ZiznuyGTVxxssN14xoz49ihA61Tf/6aPthkDrm+AadNoDGOHFUXqQcAbQB3DQaHxmjtK2VzPj+rjZsjrRCuNNW/cLCi4dSGO+F2ZC84H0tHVHuU5PyI47Bn25CVYmOgAHf7B2ZuR8HsvBlZtcH6JZ6kQRRix3ESRKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oz9LMlPd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PCv1pZPo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFTCdB004900;
	Tue, 23 Apr 2024 17:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=577u6xwahte9sCpm1BVWUdMjKMDI91lF/rUJupk7Cqo=;
 b=oz9LMlPdHszVIs5av9afxcDYwU3roSHhCQsn9KTzWdEkBvGcpmLDeoSrAb8dkI7GaAZz
 kK1McFsj9WzaNzEbXqRbY/8cRyLpMZMQk4MJOOuVC6qqnJJYLBfv7A7jclbnibMlQGia
 qoWroEp2MB1GSrF+k6jHjG1nvyQFJkE5mv9tE2vWQPhlVWaiFbUXuRbpWfu/6aFzvLjA
 8t79kN10wrVfuitq/6lwlbTJbP6Qh61pBYXE83XR1op+fE3oWo0p0fFN7kPpo/udD6ii
 ij8M1c1fEWtbnoqOt9JgDjGH6IKH+7Dr/xT0zmzjrWOIzvSv7PWOCrjdEQlwBMz9rx+f mQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44ewx1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:38:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NGG9Ad030804;
	Tue, 23 Apr 2024 17:38:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457m6r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 17:38:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mw6mCzaFo9XeGszVSoO4fJf+spJRdLpauMzrcEi01zbYfTKP3cBIuAeur/bgmoo5KSelpG8ksnr8tG8VNqN+aGmYGss4xmopaEOUMF486q632pnIh16gV/mWZsp6YYJ0c0Q1CzmVWBdom1GAbJJISpC7ZkR4IpVeG5Rxld4azhWuXdav2T72bA7OvuZLoyEtZVOA9Jt3ZsLuv7Zs7hhDDesSh1Nkj1FEJgpSu3uwKjXc+r4/EJNnfGdNLuACjYuFIJH4d9glcP/XBZnzkWwCvGlABqPNloFa9k+FvntUaFaD1EjqMU2FGFAXJk7nJ4yiDQt22Xb63vPiVoXUC59eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=577u6xwahte9sCpm1BVWUdMjKMDI91lF/rUJupk7Cqo=;
 b=KqSDRD416TvDze76ArwgHFwa5GhaNt+hxeiwTw7Iv4ZkrPdiU9iP/AA3RldZaTzwrbWnDxmf48fxim2lycClfNCw+MkJkT3m4Oy2jbpVLsaaQj/juw0Bpn1wvDlSaZXVLW0dyHXb0ROtdo/P7HP6bLrKJW0Uz99sii2yvsB9PdbFp8Xx1r7JogGlJ6rRysUvCNtVAfSMuKIP7lOIsGWJ8sIdm0qKHbj8hCgV595+BJYJxVS15ZaKBlNRDLHYKsSYlyxfmS/DbUfKkBD8Be8omKg//gc0Jf2UJIAsJvHub0VqiqlNA8etdnoS8tjyUw+Ufzd2olEq/4dmyVFEDpC5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=577u6xwahte9sCpm1BVWUdMjKMDI91lF/rUJupk7Cqo=;
 b=PCv1pZPo5XxyzevPRzhoZvDo/RnnMgJKVyaAw4tl7I9MftoAGjetjKquDBfBnZ4eDdiN73PuGPahalClVRcy0FLZdG5WcJLuegGvjle82ZlhVoHW2fxg82TnvJxkYL8YJfO/R7mFO2NgB2wpOnx6ZC4HVAQZuUzB/DaarJyPFMc=
Received: from PH7PR10MB6379.namprd10.prod.outlook.com (2603:10b6:510:1a9::15)
 by IA1PR10MB7239.namprd10.prod.outlook.com (2603:10b6:208:3f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 17:38:01 +0000
Received: from PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865]) by PH7PR10MB6379.namprd10.prod.outlook.com
 ([fe80::de1f:84ac:fe86:2865%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 17:38:00 +0000
Message-ID: <ee56b1c9-c783-4adf-8ea1-6601cbfb9535@oracle.com>
Date: Tue, 23 Apr 2024 10:37:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] mm: slub: Fix compilation without
 CONFIG_SLUB_DEBUG
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org
References: <20240423124025.193812-1-spasswolf@web.de>
Content-Language: en-US
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
In-Reply-To: <20240423124025.193812-1-spasswolf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::12) To PH7PR10MB6379.namprd10.prod.outlook.com
 (2603:10b6:510:1a9::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6379:EE_|IA1PR10MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 086bc01a-c930-4880-f7d3-08dc63bc1f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aEdZTHpOQy93dlRzTVdSRG1lS2QrZ0E5dWY2MEI0VnVMSmlNbytvYXdhdG9m?=
 =?utf-8?B?Qmt2NUJKNjY0K0VXOVpMM1ZhSEJuRzhQS3dWSG1lWFRqYWFBTm56aHh1OG9t?=
 =?utf-8?B?bytYOUd1NldGQ3Q1RENvQjIvQmh6bjl5R2locjh0R2lJbVUwUmRXMCs2NHhG?=
 =?utf-8?B?THhMbC9wU2x0bEdBMnBrUEp3UC9SWUdERnNTOCtHQlQvT1NjOTBVOC85K1o2?=
 =?utf-8?B?ZTdYQTZPMkVpUDdlR25WS3hvUHgrc3FWNmpIQ0wzeTV3YTY3ZjJxaXNkUVhU?=
 =?utf-8?B?K2JFL0plZ0hUUkpqTTV6TU4veEoycENvSnNTN0FHdmFwZjB4SDlYdTBVK1BK?=
 =?utf-8?B?VE5xaWkrNERSS0xsbytlL01KR1ZQTGp2b0hqbkhBNzM1ZktxMkNFdzc0cUpn?=
 =?utf-8?B?ckY0TWpKN1F4MU9Tams0MEU5b3A4MTJYRDBmM3pRdTFoL1VrNnp4Nko5TnJ5?=
 =?utf-8?B?RUNIZUpIWWJsTEFmRGc3QjNMM1VTMTl3YU94anVpR29UWEpYWmxYbExUWS9w?=
 =?utf-8?B?NG9DMmF6eDNNQzdSUWhoUTVyUjZsUTloR3VsbXlLRzVqOHo2d0VkZE90Uklw?=
 =?utf-8?B?cnJVU0VtNExTOU9BRXJMNFhtWE5XWGpCWDJKaWVBN0t1S1dMT2tiQUtjM0Rq?=
 =?utf-8?B?OEplTzlxZU1JdnpSM1ZIL1dyOUI0QTY5VEFWaUZnSFd1a3AxWmIyOW05VitJ?=
 =?utf-8?B?UlowVzdJU3RoY2t5MzlzSUtOUUovS2ljejJ6NDkzYXFNZ25iVUwwM0tQNjlX?=
 =?utf-8?B?T2U3clRvQ2MrVk1VdVcyaHdmL1R3LzdlbWlmOFo2c0NkVndNMlcvNE8vT1Zn?=
 =?utf-8?B?MHFoUG5WUDFBa0hiRDZGaFJBUXFkdHQ5U0lKQzhNQis4VnZjdzhxeUdnMXgy?=
 =?utf-8?B?T1ZSV05vYkZab2Y2cDUrdGRqWHpFdHJ0TzBSeWd0KzhxcXJjRkYvaklKVTl1?=
 =?utf-8?B?OEc5a05xRXJmK25QeUdhOEkwaHJhQUhtaUFqRkJ0RGZWczQrNlM0cjl2c2hS?=
 =?utf-8?B?by9QZVF2cmlvdFFyZHdwWGRCdGNtV3ltWkdsTFRDYTdrbllid2l3WFdsOFJF?=
 =?utf-8?B?N2JUTWlWQnU1eE1hTGVFTkt1allxNDRaRkNtTCtLc2pWVDhpdlEvb3dSNmtP?=
 =?utf-8?B?VGNyeHFnS1hYT3ZrbmNKeGFwN3ZIRDl0TCs4M01mZENxeTFocGdmSkh4d1Qz?=
 =?utf-8?B?VytHcWxxUGl4blNSbHBCNDFSRmpMMWRHeW9vQXFFaXFqb0l4SFo2T0tDS2Jh?=
 =?utf-8?B?ZnZDbW90TWZjdVhya0ZxLzBVVkxna3IybzB2RGx1eU1NL1VnalhGbWhOdElx?=
 =?utf-8?B?UjFPNjhTbHlydUxSelIvYmw0alFiRmhsV2VaTE1SRDZoKzAyby9mcUdqQllO?=
 =?utf-8?B?Mlo1MkF2ZGpjblN2SFFhN0hVZVdmMWxNNm9vei9qc2FwcTlZYU50RVZmUHl1?=
 =?utf-8?B?bmdEMG5zYXJSOEVzV2R2MDliUEQ1aEVNajRTOThXR0ZZOW5wdWl2YUdPMEpD?=
 =?utf-8?B?elJzbGppTjBSZEdNMjVOVDVxQnB1Q2Z6THpuQndjanZudkhjTG1ZMmRvUkd0?=
 =?utf-8?B?MGpha00vWE8xTkdoNXE2REJjeW1yNzFqOHR4OFNjRzJSMVh0OVB1VVVtUHJi?=
 =?utf-8?Q?Hu/TPsBhusF/Df4Eol8j1PHQRW2GPcpct3Yn/U4tkiRQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6379.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTFMT2F4Sm9neEUwQTY5MVR2WTRvQkZaTnMrNHpIUU1oS3NtQXl1bElrbW8v?=
 =?utf-8?B?T0JIZ1JhRGhoeDRkRnZXcW5BRVpiL2dFb01Gbmk2d0h0Tkh6YXQyVysweDNF?=
 =?utf-8?B?OGdWWWVqYm9uVC9KQTNHdnV5WCtpK2NyMTM5Y3o3TURLdW14OUVlS1dHUUNl?=
 =?utf-8?B?RHp3Nll6U0FYQjdpclozWWFjTnEzY25SMTZ5TVlsR0xrc1BtM0ZPeHV6VDlv?=
 =?utf-8?B?VFZvUFVVckFJRk5Vcm9GZGp4b2lmUUNkb1FabnFtUDc3VHV2KzN5U3dIbUk4?=
 =?utf-8?B?ZG5SNXoyOHhTMHlDV0FKTEl6SExINjgxL0FxNGlLL3FxQUo0R0YyTjNKT1lI?=
 =?utf-8?B?SUx4blpOd2dyNUZuaE9uNTJtYVQ4VGdmbVRxZVFmOGd3K2hRRERIeE5rMjlr?=
 =?utf-8?B?dTlrcWJIS0w2RVNKOUVMamhpUVhLcktmOUpQeksvUm5UMjZvTWNFK1BPM1hX?=
 =?utf-8?B?amtCRUl6Qy9wTFVZK21NOHlJUUUyVm9LVXlZWlBvV3hUaU5FRm50bXNsczNC?=
 =?utf-8?B?SlVEcHp6MGFPK3V3THkzUFl1Tmc4cTBLdlZaL1lHOHVZeWhBRlFKcVQ3MW50?=
 =?utf-8?B?b09Jb0RHbjRDdHE0ZjJmZzFHL3QwTllRRFI3VVdySlFkK04zZWIwSm0rVmxr?=
 =?utf-8?B?bGFaUjVzK1JsempRMk1CL2ZDNFQ3UURyY0tmc09kM2NCWGNRU3J5ZnR4NENQ?=
 =?utf-8?B?RTBndkt0bnZ1Wng3cHpjb1pPVGdjM0ZUckVkQXNmZm9xclNyRUtFbjByR093?=
 =?utf-8?B?dFBibU5KTFkxNXYyUkI4MldrTU9pQUZBMDN3ZTI0S1JDaFFRaTNxQnBaelk3?=
 =?utf-8?B?OE5iMUd2dWdDZmhCTUZiUm40dlFabzdVS0dnSjFUN3VnRDZJb3NCaCtSU2tU?=
 =?utf-8?B?YnA5SElNczhMZzlzOWdHbEhSMHpsbWN5OWl4aFNabGs0OTgrU0ZpN3h0YmU4?=
 =?utf-8?B?cWVSSjEzU2pDd3M1RXprYjc0bVZwMFZ6QkJkK29yV1NHYkFwYkVnRlJLemlW?=
 =?utf-8?B?MFlvOHMyclZVNktKZ3VzZVc5SjBsVU0zWU8ydjZVd1BuellqRUFtRnlQWGZq?=
 =?utf-8?B?U0JJSGJQK3FUNS9FMER4dldWR05CZ3NtSjlPdmh1VHV5YlFVc2oxb1VTNmZP?=
 =?utf-8?B?N25YaEQxTVBybTYzR1dpSGRCdnlWSkFob0VxVnUwTzJzWmE3QUNIQ2JUK0Ry?=
 =?utf-8?B?dUtwc0QzVldUejdCS0tRdXRxY0Q2dTlJdk0xN00zV2VuRFRUbERJekgxSWpz?=
 =?utf-8?B?QVBCYk5oSjIrWHZxWVZET1ptRmNqVWlPZ1N0OHRsbHR4c2dZai9vL01RZ3FM?=
 =?utf-8?B?NGtONkhNVm9nTWZKQ2JSeHIyaVgwa3dzWFh2aWswbFFqbFJ2QlVtVk9LZCtJ?=
 =?utf-8?B?WGQ3MDQ4QUlmUjZ5eG9HT3B3SGZ0MFlHWXgwaWthMmVDZG5jNCtkSVJyQ1pw?=
 =?utf-8?B?VUlRc0Y0cG1iUnRLMU9rbEhXUitNTjFvQ0YrL0VFa3c5M3pLSFQ0cTNnWG1U?=
 =?utf-8?B?SWJjWnlNbkVjM0laaGNzN2gvTmdFSEhOdEVTbzdGbVNiNGZGQmZGaG94N0tR?=
 =?utf-8?B?WWw2ZktaMnpvSU1YZWczNGdKVXBpbnpVMUR3TXE0TnVuM1BtSW5haEVVMlpG?=
 =?utf-8?B?di9VMnVkSFp3ZzE3T29SbloyeVQyODlURDM5cDJnSjhTRTdqd1daYXVPczZJ?=
 =?utf-8?B?ajlVZW5HQ2QvdG93cWVmWkZaVk1zZGUzYjkxSWtBWWhtbkEzUTQyVmRpVHRM?=
 =?utf-8?B?WFVZZmcyaXBCVmttZVBjSlE5SVVmTGNqcUc1QmJzWnVMVXIrVTQ2MmRMMmcv?=
 =?utf-8?B?RXJlMVlNKzlENFZaSG9halMrSTAwZlNzdyt6L0N1d3dVTUJxakRZOE8vQWNG?=
 =?utf-8?B?TjMxZXZoYmxnYTQ4SC9WY3o3QkF3bzBROFhNTnFoMDhkekFadmZZVGFSM0ZZ?=
 =?utf-8?B?VWIwR2pNRmV2Qm16SFNTbCtvNkxTSjBEd05kWmVxcDd0RUZ6MUNXZStIdFFY?=
 =?utf-8?B?RUVlQlEzUXl3ZW9uTDVDTm5LQlh6MjlpZHU4dWExVmVxN0JOZURqdWJkSlFC?=
 =?utf-8?B?VU82WFlFNE9UKzRTdUxRcnAwblpkSk1kNEFmNHFzazB1bjRJL2ROdmEyblZG?=
 =?utf-8?B?Wk1TemdwK2t5U1ZrTC8xMVVydEJKcUVsVGt1QnJGOTF1YlhLbFl3TUF2Kzd0?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pMR8u/SOEOry69bCmKEZHllWytguQG/YXb+UTyU/6MQdLOOm17ctMDe1LZASK3ttpYieTzOQ7l+FsuNY7ddIRlfU63SXcK0MpUGW4nlNAMdWaIGvdFiILFl/bF0WzjCx5lbdMkgopOv7buOuZilGX7C+i5jVR3JqNmu84J59B4Zlt6RJaNcqNpTD/MBQER9uRzCQdAT57di1V3E4uAgrCwXtxBlH7w0aEOt6gfIucV6eWt50UoO3QnIUpteJogDy2t1AhEqAAsKndmlxddYEpP7ssIJUTIj5/cZAY12pwjSvLHjLI6GYyqjWRoLoN9SJ57mWPUsvC9N/tAtexPla4QI1+13FWIeorlGtanxPvVvfcW0lxuHcdCbWJBIx1hivVbPWd9Xvc/itPldpYLMWFkmHK46WmNjjeN4XCr9TBf0mRYI1FUe9Cg0GMZ5DgEf0lFP5Y/guFFvVr/NuWJrPhcf++Y03MTG+wSqgPYC5VX1P5Zqs4AZDu9I10S49jX7pDXNOJcZS54F0thyrVKKPRxvqbLd/VDybDWa93Dyc0eyftOmVkKELtlb3hwH/nMm9W+XFXB4WshHAEeOPUK+2jCUy7RYisJc9iXyk4a7tmi4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086bc01a-c930-4880-f7d3-08dc63bc1f14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6379.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 17:38:00.8028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bnqwVGx9byoi5sl4wqYs+IrMjnuTdiorzySnSIoqFiR3FITXbNwoinR4hMvmUNY9+WmJ31QyfjavSl34IvWxC9lHOfR5ZskzQrUf+FRBmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_14,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230040
X-Proofpoint-ORIG-GUID: MbkByoc1FXeNPiZckX1PJonWzjnDnUs2
X-Proofpoint-GUID: MbkByoc1FXeNPiZckX1PJonWzjnDnUs2



On 4/23/24 5:40 AM, Bert Karwatzki wrote:
> Since the introduction of count_partial_free_approx the compilation of
> linux fails with an implicit declaration of function ‘node_nr_objs’
> because count_partial_free_approx is compiled when SLAB_SUPPORTS_SYSFS
> is defined even without CONFIG_SLUB_DEBUG. As count_partial_free_approx
> is only used when CONFIG_SLUB_DEBUG is defined it should only be
> compiled in that case.
> 

Hi Bert,

Thanks for noticing this.
The original patch was updated to fix it and was sent to the MM maillist.
It has been applied several hours ago.

Link: https://lore.kernel.org/linux-mm/20240423045554.15045-1-jianfeng.w.wang@oracle.com/T/#m6ec634d0d214bea8807deac8cb15bf27dd47743d

> Fixes: commit 1c5610f451be ("slub: introduce count_partial_free_approx()")
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  mm/slub.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index a3b6f05be2b9..a547ed041bc7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3226,6 +3226,7 @@ static inline int node_match(struct slab *slab, int node)
>  }
> 
>  #ifdef CONFIG_SLUB_DEBUG
> +#define MAX_PARTIAL_TO_SCAN 10000
>  static int count_free(struct slab *slab)
>  {
>  	return slab->objects - slab->inuse;
> @@ -3293,10 +3294,6 @@ static inline bool free_debug_processing(struct kmem_cache *s,
> 
>  	return checks_ok;
>  }
> -#endif /* CONFIG_SLUB_DEBUG */
> -
> -#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
> -#define MAX_PARTIAL_TO_SCAN 10000
> 
>  static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
>  {
> @@ -3332,7 +3329,9 @@ static unsigned long count_partial_free_approx(struct kmem_cache_node *n)
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }
> +#endif /* CONFIG_SLUB_DEBUG */
> 
> +#if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct slab *))
>  {
> --
> 2.43.0
> 

