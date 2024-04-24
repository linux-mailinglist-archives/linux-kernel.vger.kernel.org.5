Return-Path: <linux-kernel+bounces-157101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBE08B0CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031CE1F2762F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39815ECD9;
	Wed, 24 Apr 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R+nFrtbj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ikjOiEWB"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0415E817
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969682; cv=fail; b=gXOXKH7JPgDCc+bTD0SvSYw1X5gQ3gjaEH0tf3FOvUudm6JPBC+xbqpggASaf/q+gS9E5xEWq6GsvAgclG0KHy736N0KVA7RzhRnizJUepQOL3C2MZYJ637ftObIZTlqW9ta+DB4M6jCu2zPyvNygLnBnu4xQKUJzaiPgfjxbqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969682; c=relaxed/simple;
	bh=7xflu9yRRmjTKhf50sA7ZP7YawINa2ICJafhxxrj9s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kd9PrHPYX1pBajg7QWc9xai4LDf1POU+qFgV9ed/zzU2A0yXF9uXOCZwxb1wcoeed1l9OYGzdHKaHzuwAS6hTfzJBEavyCEj8m/qgkwLVpv7FHw/+JWKBJf8+xzqAedZ2Yp3HHeoh4jOAAP1vsGIgYbQNE1fVAEEq8j36Wymk4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R+nFrtbj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ikjOiEWB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O76KHc009721;
	Wed, 24 Apr 2024 14:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=JOwvQhrEwIi7jrkK5uqQeyxVgMP0rV1VL8Q1/AIXbuE=;
 b=R+nFrtbjKRbrGNnV799C2chp7jpXCsSiVNG4etdkau1sPt5dzIrDaQC0FeVrW7tpUyX2
 ebHb2ipAp9/4csarHIAyEfx6twy3nWhePTgix88tLHFjWQc7c7v+eQE7HkGGOBwD1KD2
 I81lJtnGoQ8X5h++6oe8z2Ik8EOxaYSKdm/9BLeYMbHX7HVSEpW8eAgAmHmRz/akyyjg
 qVFW+gqEuk7frN9RwRlsgJCy18/AIF7K1y63MJquaUwayVtF9CPW8HHvwcLG5rm65Y5f
 AtQ6st/uTvs0MTvosmVL+S30bnhkH4CR3P5KWLxoyNrAzfFNR8psmJL5MvPfLRenyBur HQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbrs4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:40:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODwiTW025280;
	Wed, 24 Apr 2024 14:40:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45f7aay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:40:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UitgHdxkLRQ4EeQbtY1mGj0e2Z/xHv0NC4RJEcsiN9reqWLd5AYWXgQVU9HZYVVefZZrq8ut0OT8V3qBPIvozotLaxYLBR2VOSQGUo1a6VGtgPkwZmUoRqh1Q8Ybqjt1TMXbQ9cfNeXRgWblxev01jMHr/WqQsuEe8pvO0bmmb9gOsUbwQtErL82+miv01KE74TVvys6CDmC+95B1K9T4hWL5B6RI2+4Sw0O88+QLncLfKJWTTj2dhpdqIoxV8ESNZzmBnVxho+zaRgUh1fVVNyyxui0TcyylxC7kZ/KdluwwnYJJy49MVGY2cnu/L0pKFjEuV8Dp+s5/lTG9h36Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOwvQhrEwIi7jrkK5uqQeyxVgMP0rV1VL8Q1/AIXbuE=;
 b=NZjkFTUbHOC7s7vmxpJvIYZioDdCw3W8NGPmGSWslKArf5yuvdVosKS+EdIY4ekbxF5qoTT33fufwh1okGNuvChgTOp/y/AQDiw4RIa5zFYNkEwPSTVD0fAu+qumndzYc5ETEIni7+9g6yVoEd/gsDD6+7yPywYFaP2Cnfp6NvbQ+a65TQrCEn8Nldax3TQFCJxEmv6y8ymZGpGjqUA3b9fi6kl0ntpW7kgcmRrgn8PcZxtFfzOqhgs2nBxk8inmcusRgqiVSNWjgWnEoKk9dpYDkPjrJ6kXfRS6u3CZoiP+0Ep987/MPmEGyYa9sZ3FjUZdnGNu7s7uwGanvarSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOwvQhrEwIi7jrkK5uqQeyxVgMP0rV1VL8Q1/AIXbuE=;
 b=ikjOiEWBuPtBiwqszILECS2d9q/gM5hzR2lfqz+Do/tuTg+3yuIAfciqO6ge53bmYkHCRJWeXxaWvWfpSgTm+jb+iXpFR/mdSkYQwtVeVFJSMWlN52GRObWNOtXNsIKlBnBircdgcPcUaMGbdlH7FcXKsZ+p1QlLmxfXEkLywnI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 14:40:42 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:40:42 +0000
Date: Wed, 24 Apr 2024 10:40:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <whrf4yfvi5oea2kw7mw6rjmuxh4vg45wi7ucg7j4iowufp2tav@mnqgaq6lpd64>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
 <ZigMa2GqF_HN39oz@smile.fi.intel.com>
 <t2n5aj7orslsewknx6vmlf7t4wbnj3u6cabrjjfaptexb64fzn@rbjhcj3uwrkg>
 <ZikU5TWvL7zEfr5B@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZikU5TWvL7zEfr5B@smile.fi.intel.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT2PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: 2604dcf3-4845-4628-cf52-08dc646c847b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V2Y5WXpuUnErTEMrTVI2R0xsaVErVGZOUE5wdzNnb3NEKzdQaGs0TnBKaWZ4?=
 =?utf-8?B?aFFtUDVMWVUwOWhyZUZDeklZaUtrYThRTVEyemVpUFkwYVJua0V5OERUdHZo?=
 =?utf-8?B?S2g0Q01FMmZ6VWtqN056eTU3VGpwQU1GUUErZTVRcC81UkgxdW5MTTNZbDNx?=
 =?utf-8?B?Nzd3OFQrN3c2WWtKeUZYSFF2bDlHSlA3T3J5Wmt2WUpzNkNqVzNGdWkyTkFo?=
 =?utf-8?B?em9jdXRhWUVQTDZnaURwajh6ZlAzZm52WHpTR2xsN2RLampwb0JhSnZ3bWNs?=
 =?utf-8?B?ejdWclpBeGJBT09pZk4xYmROdllBa1RiQUo4VElrVURqZzhuaUdVYVpadmRm?=
 =?utf-8?B?QnRlSVdKZ0cxRUhwS2RGVVgwa0FqZzV2RnJFVFlXK3ZURjB4VTJ0Y0dCNFNF?=
 =?utf-8?B?N3FBRUVYcW5BRDdJOC9xR3g5VWlvYkZwMDQyVGNjdk40TGUvRXlGbDF2SE1T?=
 =?utf-8?B?K1I1ajE4Uy9kK09yK2lsUTByMU1wNkRTQUhUOFk2cmp0c1FYVkIwek1DeGpS?=
 =?utf-8?B?T0VUcFFMVzduU01maDNUZWJHY2Rxa3E2RVdPT1FpVVltQ1VDSk1FQW04NGRl?=
 =?utf-8?B?NXpOeWcvangvNXU4WnowWTZKNE5nV0NxMUFlZmNJK2hKV0pmTlFUczRJY1pS?=
 =?utf-8?B?cjQ3VlYrWTdLNWozUHlvRVJqb3lGQUpDZzA2VmdvSGNoMUNnZ1BqRUVSZ1Ny?=
 =?utf-8?B?bHBsMngyZ1k1TXRQaFlEbUVuNUoycXo3eExWN0lvUnJnaWVnNWJ3U0dRSzNh?=
 =?utf-8?B?d2ZzZlVyYkwxRGwzSFdCT0FJSlk4RHRDWHZWR1ZmUkdGbHRUa2JHaDA5ejBu?=
 =?utf-8?B?SU9FWjIwTUFlQmx5czZsRThPOXYyc3lhYjEydGhOcjMxUXNBK01FOFRCd0J0?=
 =?utf-8?B?OTVKRTVZd0M0d3p6bm83VkluSTJBODV6M3ZsdlR4YzlteDl3dHl1SHArMVJu?=
 =?utf-8?B?Y3ZtSzR6N2ZsMC9BTjZEQUxVRW5kSkJ0bEdXdlhnWjVFMnkxdjBsWDlJUTJI?=
 =?utf-8?B?eWh4Zy92TXBES2Y3eTY5czZ2QVdCdmswb1NoWERhVWNvWkJSQWdpUXZLMjgz?=
 =?utf-8?B?VHZyd3RkdjNGdGNqYU4yT0E3T1p6RUpEUzZURlZUZEF3UmpPN3p3SGs5MGVJ?=
 =?utf-8?B?Ukw0Q1lnL0VHSXN6aWwzRHRQc3ZOOEFYRnQ1SFowNWN3SW9Dd3NMQ2p0dHBk?=
 =?utf-8?B?YUw4NDFsemxML2lXK0ZDVW9mb0M3T1lYb1JxZGlZbDNDeE1LNDVxQk1uclJ0?=
 =?utf-8?B?ckR6OW53WEtDbTFBdCtxTno4Qm9paXpCWm5tUVdxWEFtZHUwS3E5SThKZ0F2?=
 =?utf-8?B?alpseUNwcTg5OG5VMTN1Q1VySmtJUkUxMHN4U2hoZzdsQTJvc1B4MHNyS2Z5?=
 =?utf-8?B?Ry9abHZ4UXlRMmorT1kwcnduV3VrQ25jV24yMkVaVUIwTlZySDh4Rmd0U3Ns?=
 =?utf-8?B?VlZZMzgrSi84VWU1cWVYT0lhQ0xBTzVmUHVUdzJBK2xrYzJQYTV2TzVHRVNk?=
 =?utf-8?B?d203MStMTG5uRUkvODRBbnVnS0JPd1hoOEhrVjhJbFhvUnZGb2dSNzFmcW52?=
 =?utf-8?B?ZHliNFJDc1FjNWxQVmFZSnJkeGdGb25HZzdGNThzQTREZlE3bnp1Tzl3SVd0?=
 =?utf-8?Q?Y50IIvPG/p4DyFERftpvr0dq4tH5qOFMmkfHWhdrSX64=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUl1QWdqT2hSR3R2TC96OEpXUm5LK2ZiUlpoYWN2aEVEWTl1WnJKRGVUOWdE?=
 =?utf-8?B?VXhTNzJNMldzeEFYS2psMUhsSlJxTUFDTEZBWVpzVmxRZ2YxWWFiOW9qaS91?=
 =?utf-8?B?MEpvL3ZUaGNjNUVzOVNoRFRMN0RndTBGN2I3SnQ3dHBxZEo5d29NYkJacDRi?=
 =?utf-8?B?K1dHWTZNUjROTzlKMFY1bzNEWFVBUmM3VVNiT3h5WG9sTHh4R3h2WVlZakpQ?=
 =?utf-8?B?Z2V3djg3RzljeU91TEJteGRnWnVEUXB6bEtmeVUwY1laOTdDL0dyQkl2ZS8v?=
 =?utf-8?B?WUc2UmRjZEZTTHJTSEVJV2l1elNGeGV5d3NJSmQ0cjJqYXZGUFh4d1RXakhQ?=
 =?utf-8?B?ZDM4L05RUU5hcnFyTzhvZjF1OFlrQlFhVWtYNlpVMXZhaEZjUm5pcDIreHhi?=
 =?utf-8?B?VUpXdWU0RTFxR0xBUVRlNUtXV3cwRWpZbFRFWWlwempDdUllYkxnOTRVZVJ5?=
 =?utf-8?B?TWtKK0sxNGhFc0FFalR0Vm1NeEhXcXdFZDI3SUxobUhTVkVrcUNZNTh3RVAw?=
 =?utf-8?B?YzNrV2FCTTY5VW5xenRIVUxlV0RpRm5PSmtGdWVUZlZmN2tKNXdYMXR1SmJO?=
 =?utf-8?B?NTIyRWM1a1NFK2VsU1NnZ0VNcWxiVW42NW95L3pWbnEzVFIvSzZqeDRObzl2?=
 =?utf-8?B?MTdSaXgzeDA5TkZxSFhpQlMzNkxhZm1PMkdad0lxY280QmZ5VjZKTUI2N1ln?=
 =?utf-8?B?TmMrYjdDb2pESUdjSkgwekFuVS9zbThBM3JGMlc1cWF2ZzJYWFdrdm5CUWgw?=
 =?utf-8?B?eTA2NGRqVWNORU14akVXNUNtZTNCdVVMMHpnYVBicEJySkRMVEsxMUFyMHFk?=
 =?utf-8?B?VDFja3FwMzJMd1c4eVpJQWRiell0SU45L0xseGlVZytTOUs1dGRsWFJ3eTcx?=
 =?utf-8?B?RVNLb0doUVNIeUNEYkRYUVJnc0FOa1NENFhNUk9qL2dZVVZGZzl3elVaREFG?=
 =?utf-8?B?ZkswbFRCcGV0Y2UzendWSFFsOTNwSkVRZXlrUmV0aHZVdzdRWUF2UTlZb3dS?=
 =?utf-8?B?YmhVVVplU1NrdlpaOXpPYXZZbmFocTQ1Qy94dVlhVDFvNUVzck91enVsUHdO?=
 =?utf-8?B?bTFEZlhaWkxtQm5iRFRXSENUL2E1OXpOZ29EZWdkbW94NWhvVllUMWxIb2JH?=
 =?utf-8?B?N1AwYTBiN09kR2F6SFdqWWt3S1ZpeVJHMlhCRFJDNWtYUjlvSFRzcFR3VklR?=
 =?utf-8?B?QlZvLzJ1R2sybDV0NitEMXJENHlnNzI2NkJwNy83eUV3VzRRejRQZWhHT1B6?=
 =?utf-8?B?R25wMnIraDBSVnp6Sm9lckhtdWNmQnlxSzNkTTlURGNwbFJOZjkvT1VrUW1w?=
 =?utf-8?B?blNaZG9BNkxaa2VtRHo0aE8zYzRNUGdkQ05KQmxDSWtoZFR5TStaNDNCSk5D?=
 =?utf-8?B?VDQxVlN2WkxDdHlyVjlpVkZaVzlxM3VqQlhhRVR4SFlHMVIrY0gxZWNIcFZV?=
 =?utf-8?B?Nit0SUhocmZUbmV1NFNLTXQ3aWdaMlRyQU1rRktHUXlxdHNldW5LSmxpcUVU?=
 =?utf-8?B?cm5CcXdDcUpMbjNxaTlwSGQ2U2lXTGE0QzFaV2VDQVVEOWJ1Q1ZRZHBwclZo?=
 =?utf-8?B?RXZtVHVwLzhmWElaeFpzSEJKOXZpRXZtMm1wYnczUExxRE95UFo5VDFhQlA3?=
 =?utf-8?B?RTd6elZ0ZUI3ZUYvWGlPRzZyZG1Ycys3cmVlbnJUSzlwdXh0VXNrMEhlTTRz?=
 =?utf-8?B?QTJFUTArUmsxVTVyTTl3TEdjL1lONnAyWWRkWXdENE91MS9jMjFNazQ0ekVr?=
 =?utf-8?B?clpGY1BpQm9QSGtRdVh6UUdYODV6dWxINjZQb05nbTdpSUVWU2o3anRHaUFS?=
 =?utf-8?B?bVh1ZXdQU3EvMWFsMDI1SzdsNk1ScVFGQTFqNzBJSVk1c0JzTGRZYlQ5cndS?=
 =?utf-8?B?R2xUeHp1VWtWKysyQThISEZnbEVvTDdxRHRMODJBZERBUzh6K091TXZtSUN4?=
 =?utf-8?B?VDRyMElORmZtUmdkeE51dkFtdTRuVWl0ZzJUTUYyUXFHZUg4RERCZ2s1dVE1?=
 =?utf-8?B?M2x0bDU3emFiakFoSUhaL3V6a0pIeW5hTEhSOTJDY2U3UVRELzFZRWZyQ2o2?=
 =?utf-8?B?NXZReUc4K3FsL3hGbGZLWHRHZWJ6WWhic0hJaVFSL2dOOTlQZXhyVXVzbWFI?=
 =?utf-8?B?dW14STJXNFByQ1NrRmVmVG5UMmw0SC9VZkNBdnlRMFBGNUJRNWgwUzVTaVNh?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yGyM2nwafJaUXudvJtF07Y1CFl+8oRhFWDQdoYL+CWWvqX/X+bhvuSwWz6JeH2A44vAdRQgaw1QP3vmZN+/N3v6VoQGc5FogwhXrvM1UimV0tZYJYSPO9GEf3ZkogeHy6nBz7dB1ysmyO2G+fbtH7/tlE6nSen4/soHShX/MDSltn2aBlniN6AhAzbI2CeHRdCAOb/WGTrWxkHnLxH8H4k+z04UUcqGjAuDi98Yol+t63756lyzkRpspvEIS/77tQuCO/7j4m2fJpQY1usRYx2eAg+4VN1iXyCvCCVn8bMgttuTmS9Y0CaMWfzZwSDYd973vB4uCpc6nQMI7P0HIgGhvb455YzplGBQqmv9Liu2Q9ftN1hKvY1dPL5RZvbXAidPtbZp4T8OmITq5C3mpwlp6HPfGqfV1GKDd8h94BsxOp9E6Gga140MDDiRdDnHRKkE3vFoeJDimMh1aC4/DPIzpKfH5aKxKc0Oy00LkCApPbsDOpKLZZyyZX5rEPZvLaMoOzLJQnoHlBc06Sl8LLzp070ZjsAAlrHVr3DQrjrdZMuxZ/64/q089iigbhzFDVX53IamC4IPzri2d2ZQ5Vphl/Z4BA0ACC1/CDZQ1VLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2604dcf3-4845-4628-cf52-08dc646c847b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:40:42.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAObFf5cLRnTSDr36ZozPIU8blFTxqa1tvSY+/YxJMLa/2i3q+SnH0MC0BYDx6tkz+c5pd6lC2YX6D7k4EjinQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240054
X-Proofpoint-GUID: fgWsdVPJY1f2ASMYuQNeVuv_TmcxGSgt
X-Proofpoint-ORIG-GUID: fgWsdVPJY1f2ASMYuQNeVuv_TmcxGSgt

* Andy Shevchenko <andriy.shevchenko@intel.com> [240424 10:19]:
..

> > > On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo =
wrote:
> > > > > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > > > > It seems tons of the code in tools include linux/limits.h. But =
I haven't found
> > > > > > where do we copy it. Any pointers?
> > > > > >=20
> > > > > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.=
org.
> >=20
> > I was unable to locate this discussion.
>=20
>   `b4 mbox 20220603183231.15159C385A9@smtp.kernel.org`
>=20
> works for me
>=20
> $ b4 mbox 20220603183231.15159C385A9@smtp.kernel.org
> Grabbing thread from lore.kernel.org/all/20220603183231.15159C385A9@smtp.=
kernel.org/t.mbox.gz
> 8 messages in the thread
> Saved ./20220603183231.15159C385A9@smtp.kernel.org.mbx

Interesting, I usually use the web search for the id and that failed me
in this case.  I use b4 for patch fetching and reviewing.

>=20
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$ diff -u /usr/include/lin=
ux/limits.h include/uapi/linux/limits.h=20
> > > > > --- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -03=
00
> > > > > +++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -03=
00
> > > > > @@ -1,6 +1,6 @@
> > > > >  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > -#ifndef _LINUX_LIMITS_H
> > > > > -#define _LINUX_LIMITS_H
> > > > > +#ifndef _UAPI_LINUX_LIMITS_H
> > > > > +#define _UAPI_LINUX_LIMITS_H
> > > > > =20
> > > > >  #define NR_OPEN	        1024
> > > > > =20
> > > > > =E2=AC=A2[acme@toolbox perf-tools-next]$
> > > > >=20
> > > > > And in the places where I test build perf I saw no problem so far=
, the
> > > > > build failures below are unrelated, but still outstanding, see be=
low.
> > > > >=20
> > > > > But then is for building tools/, not the kernel, right? The discu=
ssion
> > > > > you said this question was based on is about changing
> > > > > include/linux/xarray.h, a kernel file, so should really be includ=
ing
> > > > > just kernel headers, files in the kernel source tree, outside too=
ls/, I
> > > > > don't see where what tools/ uses to build is relevant here? Can y=
ou
> > > > > please elaborate?
> > > >=20
> > > > I believe the tool in question is tools/testing/radix-tree/xarray.c=
.
> >=20
> > I'm not sure what is being asked.  Are you suggesting that the linux
> > kernel xarray.h header is including non-kernel headers?  I don't believ=
e
> > this to be true.
>=20
> No. The problem here that tooling relies basically on the external limits=
h.
> I.o.w. from the current user space.

Indeed this is the case.  I verified with an ifndef, error in main.c and
we seem to be using the non-uapi version.

maple.c also depends on external libraries (userspace rcu) being
installed, so I'm not entirely sure how isolated we need the testing to
be as they are not shipped or built besides by developers (and bots) to
test the functionality in userspace.

As for limits.h, we can probably migrate to the uapi version but I don't
really see a reason.

Thanks,
Liam

