Return-Path: <linux-kernel+bounces-155514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9A8AF36B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269D2B22DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B312113CA89;
	Tue, 23 Apr 2024 16:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k3rZEn+o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NJcreLHr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B81BC23;
	Tue, 23 Apr 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888287; cv=fail; b=fra9pcMbRbwrNJ1Ge6YyV+fGcSu3EhaywE0etdxOEhTuPLIMj8UKqNqGpy/qI5dRojp44OWUE77KWIj5yT5Xx22lwdvi4j+mhW9eLmPF5sFVh5iF7ztDj+hgYVIJVhI14E37rrbgWVSKj82imbIkqmQK1/GA4mZWYkrNmU7exD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888287; c=relaxed/simple;
	bh=LqRggzY/nmtmqjpfV+LrAjwVFrAv7mJZhFGIrIJrZh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rG048qEE2fZnoS01Z6jd1xrzYjVO7+gwmdkj78/y+auJsN6Y8yjKUUqrAvfitOszun7nukakFUMFELAAPCYSCRN7C2hlBbk3vTjyXKshvtXzj154b3765hMJ7zyAhR/UqngHYRn+5KpY39OY16WSWaSFhjfP7Sx5vkb8AtFWRQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k3rZEn+o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NJcreLHr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFT06I031599;
	Tue, 23 Apr 2024 16:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=oW3zeCrR7RB0OB/C2DCljWKItiQROthRUK3g0bjvuqo=;
 b=k3rZEn+o38P9PW3Lddttf93N/9FAm55Xy5+WCtv1ndIXAZ+5kxOCM9tCccc3anMhQC+x
 DYES6T1DQdAvKXbgzuvAd2dO1YmU40MnXVgie2/F05PijvO9wyoe5LZMbJdKcYFP5rKt
 LrAiQuFPghChWSLhEGl11RyekU5JlJhSllW394g8j2T6JyGuXEpJ5LaCM208a3D6gGmt
 f2icRR0TygxQbm/w1Wg/LkhIhQFc6LL5SMWdxVPqBKssbFYdQNZbgMtIfG8bjYZSH2dc
 0F5F63dGzdAsn5rHpkUnqRKvO/Z+rVqvJabprjBEzZ0ERJxnPaFVneF9ixiXBWiLag48 ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4ds1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:04:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NF367e030797;
	Tue, 23 Apr 2024 16:04:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm457f25u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 16:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUJPl/EpMxtc9WB60e827/FS1aWgYEPBrWC6hCOWzw1tFNtgWYect/OjMYHf8CPquxiOlReu5QLE2TXX1s7r8mmtNdDsnfF9HIvvYSNOcAZ3KVflAE7mD2Cfa5fmBQa1inHCyYS19+jGBrs7MExdTyBwQgejZenBUQE/E3/ITQb3CNg32KHUJvewih46NTShxaSytSeUbgYjGbZXR5LbOc6LeYoynZWxzxDAW1+mVbqx90li0mdAsDGHmWMTqDWfZT9ZJL0dtwC4zh9LZhwL9T+WfIQTHXw172tw0OX3/NzgPTfKgvzAchC0TEJlaYEmNYN0QLhIdo/EKOozjnCfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW3zeCrR7RB0OB/C2DCljWKItiQROthRUK3g0bjvuqo=;
 b=SVZSA+ysBNZAH9cJ3GJbJk3hceKMViQtxqAhae+1T/iX09Tio1hWx1NE5/K3xE7Nh3bCDPU1zmWJEG1sxw+BYn6pwtmi1K+yDDc5PGvDBlbgbvHwKOhmWwgnSaBQ200fQqw0UbXHt+BG2AA47AkrgLEs6OLKfHiwkplCR6qWpi7eKIDNcxOhxAlV1Hn+i88uI2vbIHTcmaF2PSB3jqYHrICqgw0vV4cPsO9iOOjN/4DjBTfn/Cp8rusL0m8KwYf7QSiLHBiOKy7m9wWf5IYbPipYLE3+99ID1syfy6ncTPb6qecF73UwVJIPrABnIlxgkmrjOKLBI5t+20hAPCGNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW3zeCrR7RB0OB/C2DCljWKItiQROthRUK3g0bjvuqo=;
 b=NJcreLHr445huoxl3KtLmRbNYlHtbJKzqYBbLaKW7l1c5TqukbClZMmNVwbbk6CxPfxHuPf1mIAlqzvJz+AYDbIYnvzrCk7/Y9YpM9oSmSoMFg5k6RgPbq4SrL8+3BwWu4DdUbaSssS7DrOMxoUziMqEsBQgSiPlHLIQg/MdHes=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB6263.namprd10.prod.outlook.com (2603:10b6:930:41::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:04:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:04:17 +0000
Date: Tue, 23 Apr 2024 12:04:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, kernel-team@android.com,
        rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <6apbwt27afeercymrjsulrgyv4c2pj2tzqdllukf4czsbfifqo@6p23uqdjqtu7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, kernel-team@android.com, rdunlap@infradead.org, 
	linux-mm@kvack.org
References: <20240406173649.3210836-1-vdonnefort@google.com>
 <20240406173649.3210836-3-vdonnefort@google.com>
 <20240410134352.66d35fbc@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410134352.66d35fbc@gandalf.local.home>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT3PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::34) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dffd1a2-4a7e-49c9-647e-08dc63af071d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?9XgmBXK9eWMvlnru8/cvIg2wdK7er7C6bpKwRrJbt795eU9UlDfZZR/aFDs2?=
 =?us-ascii?Q?9DDjrV4MNOOewiP2GN4sbXgeF6XE86CnEyuMy/OTxXa90WAmA4HtOhPBep9g?=
 =?us-ascii?Q?1AxYY+c+slnH8quFjMVk9GodMzqympVHBoIk2gel+F/fOuaXADVuMfYNM/Gr?=
 =?us-ascii?Q?ySwcQF7UM919Z/Oqn4dpX86lwHWRKd8a7FoQVmL3rU+J+cLh8aSnrB/tgDeS?=
 =?us-ascii?Q?qNj30pDFdsPcXV6ACTLRSaq6nppkn1okEOijBbYRxev4V/K6KPjM472sjJ2e?=
 =?us-ascii?Q?2E4aO2NnUQVMgXtMuh/wGUAiY3LJEZq0Tl2Haqxf+4BA/3jtJZE3TGewgRHS?=
 =?us-ascii?Q?yAl9iGxdEdQ+PCTmh2xIMZoyqvFVdGjWhdiIV6EhL8ORbyBuLJryoxk/bUHX?=
 =?us-ascii?Q?/5kwPcVvHwPtaMX06iWu22MTGjnh6a7ugcfKpUC2rNRmChCRowS3nUzCiwA9?=
 =?us-ascii?Q?CLsEfYglH3hF4uLMYRXCQe0sXvi/51qFDGH5Ci0eE/pan9sBo9zwNS/vewrj?=
 =?us-ascii?Q?Axt9BhNhyGi83HFWbEFhZOpx7GOA94m9kF9cO5Pk/5hrYjFzMfmniYqe0Gpj?=
 =?us-ascii?Q?6GYLFpPfahR9IVF2CPXBca1q6UR4PJTbwgraN6v1PcpWoVFZGvKQPKyPpLrk?=
 =?us-ascii?Q?/xOuIMpmFWrBmbNZaoEoDuK82NP13E/d5GPmZCfJ/nnLVP73mFd7oEhOEUt5?=
 =?us-ascii?Q?G9N5raYi56OUU9XzPpnZuHmbCZc85zFnYuvtndQSfJW+DMvIM9npZthDNjrH?=
 =?us-ascii?Q?ob7A7WBY4w0/xHYcnzf7qKiVmIiSlD5BzujYk5oAOIlD5GnhfSAZc3f35fR7?=
 =?us-ascii?Q?p09gC1deJgkGgnROySiogSvKwawhZxqjTpW9tdBYIPbuAICWyMJHBmxzAa2M?=
 =?us-ascii?Q?PhGF07TS67cwBTuvX18JNrOPnsrSQpliXWaMM1S1XYiPSJAuwYMuLIzc9Pkx?=
 =?us-ascii?Q?hLgDpp+DhC1OVDHJs/h9nx36aN8S2LF1pq0s3io5jXzr/b0mTS8w51BzVkRd?=
 =?us-ascii?Q?h4TkG0l8NSw5fcf+HHGxC0ZBwcv8TVOh13ar5Su6Qa1cHVQl8N+hVnpDDu4C?=
 =?us-ascii?Q?0la9rKl8NKmgAcwKXxW7W60goFM8/ww2eelbNOae1qeEsSoHtcC7Tkt1FhWJ?=
 =?us-ascii?Q?zJXMi77ncd891jc0dgZtotmvcwozeOiDWZQQZ8TB4wO6IAw+OyfQwFrws7br?=
 =?us-ascii?Q?ycDsVkLTORESntFfG2zXdxz/C1EWShuwlDWR4iqkyJSI26qpy8SJrXR8GbTW?=
 =?us-ascii?Q?hI+jpVV5pSXmJ0+5aPjlffOeLU7vQW0xb+3Uw0WEww=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HfVwcDFGpXLR6jroOobFFiufmp+Vq/Finv7BvHzmI/lvA2EKV3vVaUXi+rcM?=
 =?us-ascii?Q?MLlsIUvquqG2bXVRyIs3+RuCRakM8Hukd08TImnD46I87Ma8nPyLNDnTMSEQ?=
 =?us-ascii?Q?r31H0tQB5N3DWWVsKjO03qO2kf6Ta8mN99dOEhLYM34dJVpGxixq4PGFxaAW?=
 =?us-ascii?Q?6o8Dc/LiHdO8IAcHMKT5uBdDoMeiBwkfepKUf9Ea5Mr8xOxJBR0wTnoiZ52h?=
 =?us-ascii?Q?up03jWD8ERta9ONpwwsCGJTNhpoVZwQ0SGek2DLJJBpUcNTsP2u6Tb8Gq774?=
 =?us-ascii?Q?iAuL71h87PWQUdA2ffZSJAtS3NIhkgj4W4YFD666Ahm+zhHSMIJdp+PbRjEI?=
 =?us-ascii?Q?eEdfQLMbSlKtzTh3ku0p1FTNnjHg7H6kegF3bBMWdBhjYb2uWmgkKZ8G3GSZ?=
 =?us-ascii?Q?lw1IibsVABWrbWzePTrHlwKJV7o73/wYZ1fFZ6ocCgbgWZhVMsayGPePvdZd?=
 =?us-ascii?Q?AivpML+o8K1TuTF1utiyhoVsL8wWdoYwqt8FFdSaRToVQKgc7R1lbMCsf+Wq?=
 =?us-ascii?Q?QkAFK2IfNlsm6Ug6gXYEAtHII18ZGVVjlkaJHyiyLVzjZWTaIeGQXRuyWsQt?=
 =?us-ascii?Q?g2EhvH4k+TMvjic41z1Kn3ke9ak1EMQgifVCh4t29Ts0pkAF6zsfJVeFs9zG?=
 =?us-ascii?Q?qYyJQe7rVtxGTsMh/AdtvDHquzaSpawBx/Gw1tJJD/jy/Djit+L9jw5A3Veb?=
 =?us-ascii?Q?48LWYlr5C1z9i4KjEnaT6XvsNeDp2vLEGUPfZx4EXQmVZ1GIGbx1gURoc9KG?=
 =?us-ascii?Q?tJ9FtWD8z4YigznN4aOLyZY2o7hLNFaO506ilNt8e7ppmRDiDUPfEO586dqK?=
 =?us-ascii?Q?UEeGhnPuS/PTGkSWoBVC7ZmLkjDPfAMl5m8SxpYcWFq1nZ+vuJfNXJ+UUfYn?=
 =?us-ascii?Q?bcEQOFE68phXa81+aPGaM6+gc3Gc2KxI5+kX7/n+HpPN2xqq/LcZVKSr4KBR?=
 =?us-ascii?Q?LDuW4ntu2uYVKGVe25bJbRR2sF4fq/7Ljo0sbM1gOMFh+KUay4nLO+HhjZFb?=
 =?us-ascii?Q?dVCoE6VHWEOhRJMMgI/ZroqzwcETbANO9KOF8XVmh7ZW/tyQ16epMjGaOC1T?=
 =?us-ascii?Q?A+XiZyrliadCqe/pp2182xsE3P/un9IAal9tzAhcSHkkvrRf04zqX8MeNgVZ?=
 =?us-ascii?Q?bhd5YOqputbQhg0E7MSDD8UbluDtzw8kIlPMnQ0X83cgpnGEBry3AJAm6yis?=
 =?us-ascii?Q?KEQU0MUKT0WT9TYcCRPi88eOe5WQri7AxCo9YFvOxqAvF160hZ5nfZ13jDsV?=
 =?us-ascii?Q?BVDxeKhRNocX6vnN5WZhM2J8/QtIs0giECsUSjypsQnx/y2sk5EJPOle/5C0?=
 =?us-ascii?Q?KXI2BaLwBNP0zZimqHvZCiM+V5yQfm9f6jwZ3MgskDmxWjfgi2xkwVDxiMSY?=
 =?us-ascii?Q?nirr4tVk6sb1hnVH4cDtEuLJw2N+1+phi2pDCNIcnPjJs/3IbpXAmN+Gz2qa?=
 =?us-ascii?Q?B/2VsA/+kC42gKxumaymXPdNCBapd3BdCxzSLDUIdvQkbwAr+UbreJMy/jX5?=
 =?us-ascii?Q?2XnX1m17sYBRMKwY1Yu4WjRpV1tNJOLQNLAyH9BfEKSvYTotEcJvKIbUoJFG?=
 =?us-ascii?Q?FgqSMVxauHmXKoBFKQ+JqX7biBzkzww9Gj30qvcB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DpOOemRz+Stl37JzvpNiqLLxwlQfU7D1IoeVJPDHfeGEg8tBxXzw3KwK8OW7NPyDu3cUcTFlZhMJw0vvrLnr53WvPZtxrTmAgJKnv8MYLNPwM/ha6DmHiuia+lEQ3BCbT0jnqTYFbdiE6qnklSKyFHU2uczTWTkPYGGgQgSnWQ9P5C6LlYC6gF8fHZoeN41YhQqhGpN7vGO/ZwJ5Fz5QuRSxqlN/Urc1mt1D8jLbYKdt++Zg9ggvull6Pxxp1gvj/eWzwyhNPxPFDk6meTxiNjXhj2w4MPahVGgplXOsKiP4vLPNVKGonW4biZxR4BYCE0yZVRBOU+BOWkIuPDtgXP/dw5XAaZrVc+buM/I4tNVge3BENUAxtVQhdZ+MvBGf3AHHdxqbAEpFOALyAmdgmltiNrXwKoEmygctHUuPS39hO3rO+0no/kHRYwg+09r1BMPV1ghYw2Q/XxD9t5EhIerlkFX3tg8y75tDhRZY5DTNFVPyVodS8AvJy+CIUDMoZ7GdvjtMv35xNpK/yFCm2JWeNhiDtjFFgm9bqgX1s3VkKVtofnyu8yuM/1+T5H1eAbk48XyPbAhgLbtSd7qHFL4SOAuQkXlgfF8o0LH4azY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dffd1a2-4a7e-49c9-647e-08dc63af071d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 16:04:17.0614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIWPL8wpCyHeJWeBmb4Ow+p9YLq7DsCfed9qIYfdu1V9o8gtF68+c1L/jL2T+RaGZqqrpcc9e5C82eIJMqJ4yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=946 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230037
X-Proofpoint-GUID: enlZ7Klzyz2zqMbWVyfbSd6Pct6a2-5v
X-Proofpoint-ORIG-GUID: enlZ7Klzyz2zqMbWVyfbSd6Pct6a2-5v

* Steven Rostedt <rostedt@goodmis.org> [240410 13:41]:
> On Sat,  6 Apr 2024 18:36:46 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> > +		    struct vm_area_struct *vma)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	unsigned long flags, *subbuf_ids;
> > +	int err = 0;
> > +
> > +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> > +		return -EINVAL;
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +
> > +	mutex_lock(&cpu_buffer->mapping_lock);
> > +
> > +	if (cpu_buffer->mapped) {
> > +		err = __rb_map_vma(cpu_buffer, vma);
> > +		if (!err)
> > +			err = __rb_inc_dec_mapped(cpu_buffer, true);
> > +		mutex_unlock(&cpu_buffer->mapping_lock);
> > +		return err;
> > +	}
> > +
> > +	/* prevent another thread from changing buffer/sub-buffer sizes */
> > +	mutex_lock(&buffer->mutex);
> > +
> > +	err = rb_alloc_meta_page(cpu_buffer);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/* subbuf_ids include the reader while nr_pages does not */
> > +	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
> > +	if (!subbuf_ids) {
> > +		rb_free_meta_page(cpu_buffer);
> > +		err = -ENOMEM;
> > +		goto unlock;
> > +	}
> > +
> > +	atomic_inc(&cpu_buffer->resize_disabled);
> > +
> > +	/*
> > +	 * Lock all readers to block any subbuf swap until the subbuf IDs are
> > +	 * assigned.
> > +	 */
> > +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> > +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > +
> > +	err = __rb_map_vma(cpu_buffer, vma);
> > +	if (!err) {
> > +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> > +		cpu_buffer->mapped = 1;
> > +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> > +	} else {
> > +		kfree(cpu_buffer->subbuf_ids);
> > +		cpu_buffer->subbuf_ids = NULL;
> > +		rb_free_meta_page(cpu_buffer);
> > +	}
> > +unlock:
> 
> Nit: For all labels, please add a space before them. Otherwise, diffs will
> show "unlock" as the function and not "ring_buffer_map", making it harder
> to find where the change is.
> 

Isn't the inclusion of a space before labels outdate since 'git diff'
superseds 'diff' and fixed this issue?

Thanks,
Liam

