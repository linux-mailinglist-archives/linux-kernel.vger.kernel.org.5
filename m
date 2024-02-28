Return-Path: <linux-kernel+bounces-85341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3886B46C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291C1283D3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11CF146015;
	Wed, 28 Feb 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xa1tcPZg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d/5vpuN/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A515DBB5
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136789; cv=fail; b=e6fnpD7UGfZmtDCaIwMR7AiTkK9nY8kaXXlIbhH8RvgJAYZaYiWgFf4jtjJBszlDUthgE5lXuDl0EJKh6JlTeMR6l+h8zLgaSs87QUMr9lBQti2pDZHVZWppMAGrSMrl6X0Qp2thjg6w/KmuewT/dbPI7/kfflOdoak02HW6gsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136789; c=relaxed/simple;
	bh=2Le3d1kS2IfxUlJgZBW0CYlEvORjKHVmQn1DPt7GbNY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iT91Sy6Uy6HkQN5n/WxteFE4B7twzW6WN3jJA9uunRVy/vQ/KE4QiO+QCYik2LB/cy3GFtEfqRVqhGW2uHZSUaDUfCTfd1mjjcmluKmJKB4I/LddJo1NYIxSML9/RVgAkp9S2MSc9AKMt/5xjXKysWtmBLc3VnHfJdNGWPxcuRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xa1tcPZg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d/5vpuN/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SEWFMe016500;
	Wed, 28 Feb 2024 16:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=DhYo5XuQkFvDjrbvlVwgBWPPm9so9yIjq3H7VcTru7E=;
 b=Xa1tcPZghlbs2vXj0A6GsrVQkXgnkRc3PLvIHdbiABSSgre+SzPYFN4kuWsi10bAX9wk
 39u/BxaxH2EuXDRZapP35+s+beocT8SWZFmryLjsoMLbCPOS4wY03C3qn+9JxDEdibZ1
 KzDBab/O+3PRMMqIB6RMLZaMmyt7TgeUk0xg1VWgFtCo87RiCtfB6hdEQUGp4EEJJbPL
 sAWhYGGTKZRg6l2IMG7TSo0MJ4fR5Sgr2goVRoifhhoWnuvqDp0P8PHkbXQ1O+nMfmaa
 s+Cr+N8TA9bmcKRdLBVZoH211XNtQkAeyegrg2JEg8wI9QRjRKLaU4W+MAVf/CsukuYi jA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82uaf6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:12:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SG1u9x001738;
	Wed, 28 Feb 2024 16:12:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w94jmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh61eeht95FQt4H6+sG+T0F9f8FW6J7iQKflucO0LWh8K36YBR0hRoYpuji+y7JD8ahFpDe9nHjP6dM1dgnTyTP0WbEIQfTysLS53J5PM6bIBX6wLOfDfXN2gIkhKmxZ1VTLMWqwo/pNs920XUunUneTA0jpJIGlTjD2PURpVBTIl/LTs9RlFUbSZvCWdAsxYuw6SWAVkKhbKlG3q+4L0XGpb5KsSOmiqcw1tF7g2IZoqb+hDc7O4J6mwXvSWnLcgj9DoA1KtUvEj7PaHkXcB6cS+DqNzCQz6hos3f3DeZRhEC3Cjy+KLqFCwVCryCURQTHTLta5troySPcSYEtqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhYo5XuQkFvDjrbvlVwgBWPPm9so9yIjq3H7VcTru7E=;
 b=Ane9uItXrFXQEXND9v7GPOFVBUwDXcnOVNC5yFI0E4/U8lxW+kIGER+ERRlNW43qEVaR5dRFqBIUw9j+y42LXUmjok2hl9al4lyOTFHDuDz7IlG0tEWinF3tqSi0VfWAk7brKRTg1V+rmGphMlBnSIjNxbRLopyU6qFwsJdCXfwQRr4adycVYLFoWaDCmR5raNaSR2x8kxwXWx4jgNExOYNkpwl6XaRo/wt9gyUG9FcFukMudKFlI7rlxLRkVx0i/lGkP8SfYKKd+uiOGfMmmyJlufLh+QIpc0dWQz+XpJSuE8OGN+g6mUQca1qx72YHlqLjKvqAek67yJ7qP2UWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhYo5XuQkFvDjrbvlVwgBWPPm9so9yIjq3H7VcTru7E=;
 b=d/5vpuN/xhVMv87Vg35AjzQAURIAupsW73tSuS690Wa1NsgJwIC8GBJeUUp6QQG5lWwSzV/TL/flGvmQmJZWt8YrZLDM9PRI41Q+FwETdDgBleOLP+3V3qtoLLIKjIIp61NfqEqNNkgp7IJX9clDSl/qC9+6vyypbvmN4vRlxsg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6022.namprd10.prod.outlook.com (2603:10b6:930:3e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 16:12:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 16:12:49 +0000
Message-ID: <9018b003-55af-4877-9166-d70f6d896b06@oracle.com>
Date: Wed, 28 Feb 2024 16:12:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
 <Zd3cz7yYezir-P7e@bombadil.infradead.org>
 <e88b76c5-1b13-4ad7-a97d-c34722cfde19@oracle.com>
 <Zd3oke0pAL2G05Rj@bombadil.infradead.org>
 <a07db8f8-39f8-44ad-b466-10ac02f3da13@oracle.com>
 <Zd9OyMTgtYcFSEq3@bombadil.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zd9OyMTgtYcFSEq3@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0009.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c069884-3ca0-4c5c-0e00-08dc38781bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+wPSR1A0y2Y+KGhH9H7UuyqcQijqwGlf7Q69/5e/zU/K4kp7Y5G7ElZqcktcaDjxAe89fmEZ2D2cfnH4Rdx2otaHsLInE6LAGslJu8TC4ojLOsHLH/yCLir/Ee5DAQvVTwxGLn8eOWr3cN6FZBF/5sE8N0lhiaA80gI1Y746WOQPmHipusW8QPjaIT4zSemvuIjlpMXHJzgJZeC/SG/xjGBtmVIW0gqrSHpFN/cU5sGytsEbpIMEWeGHsA8hrbnB5teRWyyBldaCmhRL3Sta+jjBk/UabDYJcMHJV2BdsH8thLMOpE4/rHKWW3Ma+kAtIhck0HZu59NLHZiJE6Pzf+31n9T4PGv3g/p4DI7t5e6X+b35D46BhGL3eu3wEU79cYIBWWiyvYav9Yfuj3FjbJ/XxmfD15GwEaj2g+asKkXo1PQ0Iw3xlgUkx9nFMGZEAOVtAreYg7ETg0+ahvzCjBS7+jRACZeDjZUhwu5phbcRZQPTI9XhuwcJsK7wMB46aNAuoHerSOwrpnwSFho/5mE+MzR2rwcYyW82TfK6FS73tKIuAlLjxbmgMDCZ55ZZL3nwYwFkavn9pTZCkEE29HXFsySxD/BEIwB17SzrexlMk3XBjfQ3C+rIlrYmZZM2saFTUuv08tZvyFQJFvUGAQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sm5xeGtncS9nS1VnN2x4VE16K21mcms2dTZoNG5DeUo4eTBydURPYlNzVHZX?=
 =?utf-8?B?OE9iUjdCWW1xajJCZVg1Q0xiUmNiZ09SdXdzTDNUblF2bm5yam9ORExpRmV0?=
 =?utf-8?B?aUtLNjR5ajc3YVg1VVpVeTM0U2FmN3lqdmxOY0JxRmEvZVpnVlNXcGhMWlFW?=
 =?utf-8?B?QnB5L214UkF2SmNpampjYUczWDRXUkl2K0ZUS1lOcUxFelFHWS9EdDBFL2lW?=
 =?utf-8?B?VkRUSm1TeDcrWGp3RGtHMUlkUmJkamhyMXhhTUxHUEYyVHUrVmxjaWFES1g2?=
 =?utf-8?B?RTBLSXdaR3l0YjBQZlZnb3pnR0NrN2VCaTdRdGxVekxpTE9iSGxUNER6SUVI?=
 =?utf-8?B?U2RacXRJaDdmaHNQNWdmcVFNNlRpanFWb2xiRXM2bkJpUFVnOWhKQ0tHVU5m?=
 =?utf-8?B?U0c5YXJqclpNYXhMNDBDVFVjOXdaem1McUw4MTZ3WFlDTktwNC9xdkVvaVBF?=
 =?utf-8?B?RUw0T2RuN1E5Vk1RMWtaRzB0ak1YVnlJRytKVytmQ0RhNWEzNkFmd2o5TTF6?=
 =?utf-8?B?OC9IQVJ6aVJRQ1h1ZHNlVUMwMWZJc3kwcDB5N1VhVHZtbkhORTJBNWN2YVB0?=
 =?utf-8?B?ZjRqM2tUeFpCd1RSczkzS1ByWnF4d1lrUWdPYlQvWWZxSHdianpxVVRFeXg5?=
 =?utf-8?B?aWt6aTFwT0s3SE5LTkdQYjhmcUM4Z1BacVVlS2xXeW85WmRZMWJFczJ2cG9W?=
 =?utf-8?B?Ty85WGtqMHYxTjVrRGVNdUVpZ04rZVQyS2pITkFSVGNqaUNuWHVyelNOY0hV?=
 =?utf-8?B?VU9XWkoyOS9BL0tsR05xNWlEWk9iR3lVM0Q1SmtiR1ozbkI3VHZVZnBFc2Fw?=
 =?utf-8?B?eWFydHJGdC8vdHlpYnZta1hWQXRGckRndzcrWTZsTUVpTmtSS0F1c2pRVy96?=
 =?utf-8?B?b3lqVTB4SkNlSGhxWXJaYXEyY1J6eEIybEYxWjBhWnBHYzNsMzEwYndTTWxX?=
 =?utf-8?B?R3I1aE0xNGtDL2txbm05N28yVjI4WXZpMkVPSmF0WjZoUDhyQ3FhNVZpejV5?=
 =?utf-8?B?Y05FYXg1NHpSUzZ5enp0OENjWmxPTk5QMGdTanU2aFhJYWdDdlNpTERhR0RP?=
 =?utf-8?B?WHBvd1JaUFJWWXJ2eW9XKzBDU2hKa3dvcnkyeE5LL2JQc3JRUWhMdHV5VWtz?=
 =?utf-8?B?Zlc4NHJTZW9ISWwzemZqRXVaNWZvbW9CUTBEZUxvUEJoMFk4d2tsdVVHUXh3?=
 =?utf-8?B?TVJZSFlaTlhjNDV3QUU1Vlp5Umt2RHJiRlpRTlBSUzlzSzluam1Rb25LczRl?=
 =?utf-8?B?WGtQemZaL0dmaVF2SXpwWFNDV3U2UzU2QnN2QXB4OGlTR3B5S1l0VTJ4bjYy?=
 =?utf-8?B?YXdPREdjUUg3bkhzUTdEWDJsbUZEYWZRdlRrWDA0bmQvL1FZN1JkbmJnd1JS?=
 =?utf-8?B?QVNhWmlxa0ZuYlFzVnlrV2xkRkdaOHMwOE9oQ2hMWmt1Z1BwQmpaekp2Wmgr?=
 =?utf-8?B?NzFCZmV6MUVBWGxvcXF2TjEzVFJlaGpNZGNrWUV1UWVVMDN5aER4ZGdWL1Nn?=
 =?utf-8?B?ZDdHZi9WYzlqY2phb3R6WW9vdEMzYVB5aDRpRVRxT3NxNC9jWEdaU0pnLy9P?=
 =?utf-8?B?NGdjMHdHSkNER3FwODNPRDVOazhUMk1KL3hhenN5eUV5S2hOSEx1VENJZjY5?=
 =?utf-8?B?Y3E1enhXY2s1aXlaai9JQnVWanJKRDJidTJLUkpRSHJjQTc0S2NNbERhV083?=
 =?utf-8?B?MzdiRGkveVdkSHMxT1lxNlYwb1F6bGx1OVJUSjgxaSsyUjlxNmszNTlDOGQw?=
 =?utf-8?B?S2NKVDdDSk9UTHBOVkJ2TG5hZXNGVjRzclBXWmUwNjB0YzBrd1pLZ3VObncw?=
 =?utf-8?B?RnJ3dUhEMWovekxIczM5OWt3K0NEby9sVkN4aXZQOG5YTUVaZDNVQ3pmeWVu?=
 =?utf-8?B?ZC9Ga0xjcXBtenI5b2xFV1czRmhyWm1FMkJyb2MxQUtQdUpXRGtqODYrd084?=
 =?utf-8?B?ZHFCd3hQRDJNVjJURlk3amtJcVFJWC9CUzFZenRRUG1QY2dBMVp3dGRyaFhR?=
 =?utf-8?B?YWJWemFXTk9xK09Kc2EyTEJzUndwMFNtaXJXczZ3Q09vWWJJR0xhMFlXYVJn?=
 =?utf-8?B?MlNqWTJDWmx1ejVuK1N5bUxSVXR0Tm1FWkpKbmkxYUx1TEVPMTBCcEhiUmZM?=
 =?utf-8?Q?oAjAfLeeV5Gp9QESn7CXJJ18b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gMc1M7CpCFGxDgkWjGGFlG6TkjmWPrK2niuFsuEaAFm/a8WaDb0mW5zJeYmMdBriGySIpmJ1X+rKrO0QWieMqyA2AgRWgK7rL4GpkNch27DCrIITHNi3tt652m4S9mNSVv+Pf0RN4k/90eqwRFZgAcgGUtJ3OYOYZiucA5tjhfc7lQkBQzVfdTPHTOktkfdTlxb2qn3creQAn7Ehx4sLyEAGyzrfCk+EQ7WabXHy4XhgDRjA9ed7YZr3D89rwSjVaGCyQPFPtzDqQ0d+kLjKZR+HKWUZfKELrbtjaUPXU9bdXVUgVXtJy3olUMBNfIvQVCA6X5+mIf/SLRRRLdumKr1A35fIZiDy2TvbCNVAmCJfsxr0KsBLPUqYruRheXz4/SVZbIp+yn+kLcnnbXXKuX04KaQQ1ZNYogJXP5/ocNGXw2poDm92I9T8pJO5jmUxhRBSENCcEt+y/35NMGtVi5cprDaUJeC5i/AMJxwcJdy3fDJJQfUtC50FKqWJupQQZ+OhNvYCb8fOBdp3SJWEZlBwKfMAMT7tPrmkKTYpjwU/XDWpuIYA9Bs9gnoPygBvB0HJK2tsMed8xxuL6IhTekdmJIAe0dG0kmPa0IOCOrQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c069884-3ca0-4c5c-0e00-08dc38781bcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:12:49.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnVyneuSmtjct11OMLL+pOEgeJLtso1gtfz3lzFgV6ngi7YwTFIAtasOIDoDcu0KP3po4YfW1XUlvtv/Si0Cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6022
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280126
X-Proofpoint-GUID: yn7WwSdAlVzAP-IxFrn8wwKjyCBUEMDN
X-Proofpoint-ORIG-GUID: yn7WwSdAlVzAP-IxFrn8wwKjyCBUEMDN

On 28/02/2024 15:18, Luis Chamberlain wrote:
>>> But these are expected as the selftests tries silly things to ensure
>>> they are not allowed.
>>>
>>> If you can reproduce it there, it would be appreciated if you look underneath
>>> the hood a bit, or share anything glaring and obvious which may help
>>> reproduce this.
>> Update: commenting-out /lib/udev/rules.d/50-firmware.rules seems to make the
>> test reliably pass for v6.8-rc5,
> Great, note that if you had a hung task even with the udev rule that is
> not expected and is indicative of a bug I cannot reproduce.
> 
>> but not with my patch on top - I still get
>> a hang there. I'll investigate that hang with my patch.
> So your hang is with the udev rule on vanilla v6.8-rc5 ?
> Because for the
> life of me, I don't see it.

I think that I spoke too soon. After adding debug to see any difference 
between mainline and my patch, I get this:

[  806.830318] misc test_firmware: Direct firmware load for 
tmp.k5xh5F4xvG failed with error -2
[  806.830322] misc test_firmware: Falling back to sysfs fallback for: 
tmp.k5xh5F4xvG
[ 1006.958148] INFO: task fw_filesystem.s:5565 blocked for more than 120 
seconds.
[ 1007.045111]       Not tainted 6.8.0-rc5-g11c039aebb43 #40
[ 1007.110262] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1007.204462] task:fw_filesystem.s state:D stack:0     pid:5565 
tgid:5565  ppid:1      flags:0x00000002
[ 1007.204470] Call Trace:
[ 1007.204472]  <TASK>
[ 1007.204477]  __schedule+0x3d7/0x1720
[ 1007.204486]  ? ttwu_do_activate+0x7a/0x260
[ 1007.204493]  ? try_to_wake_up+0x81/0x6c0
[ 1007.204495]  schedule+0x39/0x100
[ 1007.204496]  schedule_timeout+0x14f/0x160
[ 1007.204502]  ? __queue_work+0x212/0x500
[ 1007.204507]  ? fw_devm_match+0x29/0x40
[ 1007.204514]  __wait_for_common+0x8f/0x190
[ 1007.204517]  ? __pfx_schedule_timeout+0x10/0x10
[ 1007.204520]  wait_for_completion+0x28/0x30
[ 1007.204522]  trigger_batched_requests_async_store+0x95/0x220
[ 1007.204532]  dev_attr_store+0x18/0x30
[ 1007.204539]  sysfs_kf_write+0x3f/0x50
[ 1007.204547]  kernfs_fop_write_iter+0x140/0x1d0
[ 1007.204550]  vfs_write+0x311/0x430
[ 1007.204557]  ksys_write+0x6b/0xf0
[ 1007.204560]  __x64_sys_write+0x1d/0x30
[ 1007.204562]  do_syscall_64+0x77/0x120
[ 1007.204568]  ? __count_memcg_events+0x6f/0x110
[ 1007.204576]  ? count_memcg_events.constprop.0+0x1e/0x40
[ 1007.204584]  ? handle_mm_fault+0x192/0x2f0
[ 1007.204587]  ? do_user_addr_fault+0x33f/0x6c0
[ 1007.204594]  ? irqentry_exit_to_user_mode+0x6b/0x180
[ 1007.204599]  ? irqentry_exit+0x3f/0x50
[ 1007.204601]  ? exc_page_fault+0x8e/0x190
[ 1007.204604]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[ 1007.204609] RIP: 0033:0x7f8172b14887

This is without the udev rule.

I'll try to now see where this hang really is coming from... but it 
might take a while. Maybe first I should enable some more debug config 
options.

Thanks,
John

