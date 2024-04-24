Return-Path: <linux-kernel+bounces-157117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5BB8B0D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AABF1C24A10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102F15EFCB;
	Wed, 24 Apr 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YDUx8/p/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnUCimJq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366315EFBA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970011; cv=fail; b=V/pX6u4AHMJqLP53CoD0VDYImzA+U/s02RpZhJ4TG4lIuYUOiC/ZIo9ejO1NoRvAWfFTBjFhNM+lJL1rOcLifT5eYIhqCNLX7l8bpFt7ZFtDqcFy2G0zK6LcTfFXg+JKAQ69GDRvLCdoDB9u2KY8fdQNHL3i19WG8mjFGrVkpmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970011; c=relaxed/simple;
	bh=dMHMqEeHvEPWlYM2C/IPaFmfo2u7Pgqpel+4vamnkuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rip1njuHUTJZ3ThX1h0yxCrwPCHwStUZGzY2ip9ty2O6FYCopwtVIuiZBS3U9/UYwIZJoQ6UytyDGWt9De0TrPEetB/q7Aoj9HujSSz4pQ9HygiuEqqOCPYhqVOLnZ1CMfe7wBlcdLAesPHWy6IWIvaExqPselt4gN1WUeOU8eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YDUx8/p/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnUCimJq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43O9R9SH010764;
	Wed, 24 Apr 2024 14:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=ZiIWB8m37Cw36dtFLaKOUt0NDnDi9H00po96SoieB/8=;
 b=YDUx8/p/gYNShA17hHwjFeeHD26sU12XOIBt82s2ZOdjrqJ98LUpSb+av6V43ahfYmnD
 gteP0F9MEuYYD9Ip+c1Ao7bHIEKRNK81N5bhnxR3l+HZQFQIrfPW20nRZxy1TRrHr729
 PzlMPUVInFxgqgs0FLxYrcmBeay6y/vC9T/bbn3YappoyB9TcYz90w8B2RbYfRoQK6IM
 jTLFpHvLT4uFM26TNyxIx018kmlU3ynSijFFH3FzrENbbibHS4fsys5jrd9/S6xzh852
 8iK6raOyk539ItNkX0zsiqBdybPH1QmAHJvnajkuMwaxSzQnRef+9NXmu6KYdBCJbvGg Kw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vgswb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:46:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43ODX7td025225;
	Wed, 24 Apr 2024 14:46:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45f7je1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 14:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvxchYNa5bTscxEf2APtZi271t5f+758568GUBN2om/BHWAyq0SMGk/gfhW7UcoQwdMUFFB8igLfhmB6Ck+ynG0Hm7UGjPDpjaFmbW8W9a09DxdGfPknjTTBVIvflPHbVdNOfjz8/AZqQaIORuZAnD3psIn3hI9aT0+Dd9L3D9p64Bf98BF6Zv34o95UvFbna3vbAGwJlWBToSsno96aX59tY438virQ0B7klJx49BWDI/bJ9YdLpFLqI7LpC7cqrGhZVXXyGlFkdtQMccB4FLVokB2OFSK7zQ9G2wsJCefA8Dv1I3cTkcwMlx3GWYJE71C7RbdTy3jUDeUCD5yNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiIWB8m37Cw36dtFLaKOUt0NDnDi9H00po96SoieB/8=;
 b=BmKfgcoHBp4RYkSG6m8eEKxTGASCOo5S8lqmlj1iv5kCq3SUEMvx+1kry5+mE++nDjJPVhfmUyOoAWPhoBFrmjc+f9ZcgReIpmV1OPVprGgx30xMQeow1ciMS8hchp96wc0La73pxaNUnB+HCRRkZM/FM2Iq3QkzS3KYPpxU9CqRUSFUrGPcLnMn5QlcoOvN5j3zphSihxVax/JI72AlC3N/Py/AF3me01dt5sWxQa0iOndrIbHP6j8wNV0DDIW+Co4Yqn/y/hkU8HbM4o7SH8WZXYdkdnJJJVVTlTK31h5Yv4Wc505g1cQA5f0ttdOgCXQ6mAfOJL5X1XnhWotyVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiIWB8m37Cw36dtFLaKOUt0NDnDi9H00po96SoieB/8=;
 b=mnUCimJq4FyKIs6wBKF68la8aSQOJD7QEBr5z8uu5tJEE5ca/h9I3bM/s+7woyI08EjFnbvSfsrCDkJlWGgfrM+RWhEFi/oPsPKjYvLpgdxDeSrQIvsb0M0TqT5JciMTk0Rw+JsEuG42LmitmhzvNeKAiZxSwjL6IwpdTJ1kpMY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:46:16 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:46:11 +0000
Date: Wed, 24 Apr 2024 10:46:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <sj7yz66gusev4qhpvqxfd7iorxabgodcmhvlvrvgv6djhh2kok@o7zybzah7pbr>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
 <ZigMG8ZsBryO57zz@smile.fi.intel.com>
 <ZigMa2GqF_HN39oz@smile.fi.intel.com>
 <t2n5aj7orslsewknx6vmlf7t4wbnj3u6cabrjjfaptexb64fzn@rbjhcj3uwrkg>
 <ZikU5TWvL7zEfr5B@smile.fi.intel.com>
 <whrf4yfvi5oea2kw7mw6rjmuxh4vg45wi7ucg7j4iowufp2tav@mnqgaq6lpd64>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <whrf4yfvi5oea2kw7mw6rjmuxh4vg45wi7ucg7j4iowufp2tav@mnqgaq6lpd64>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0393.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bb8cc5-2bc7-4ba6-bc88-08dc646d48ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZfyM7vP4NE0JnWYWfDbE8M2x9RAeelYNbt4hcGW+AmuYXtAVb6Q/oMek/Ayy?=
 =?us-ascii?Q?Xx0JsB9jh1HA5kt/LkGakxVva1j9kjh8WjGXHcbiHsdggGWpt2Ap6R2U58qT?=
 =?us-ascii?Q?eyuHJnprCnjnyjZl8ejTitzMbT1NLJwM/GbKj4l9fpjVhOlY82TzypX84UPa?=
 =?us-ascii?Q?huGSekVzvdKV6fyrNwmCBaM5/HnlOHLCygIYTkD6vLZ6AOFWyJ+yeyxqZEgu?=
 =?us-ascii?Q?YPsU4V/27CjzFt9WP4tc/aBP/6dkOd4Ydjs6P425ZOMVtcB6smj214TyMqng?=
 =?us-ascii?Q?NVFbKm8ZR7SOA/XTZVc2S7M23jgIBCS1U6evi8r7Vt0+Miq/QD8jn4bH1Ji8?=
 =?us-ascii?Q?NKwRhTAXJT19Xgsrp9jqMBjyfHd+BPmI/ouTHU+zosKK5BUV0XPrnWrYEwFD?=
 =?us-ascii?Q?AJrWPraEIDnMq5YtLVo9xBvmb6rXZQFjIdEBXIzUhWxIqGAfcuXBJBt3Lnsp?=
 =?us-ascii?Q?04gSYNVG+88dBzWfad2eTyAI41AEKbDE2E7xMILnZZzJuvkxNMayScbQOb19?=
 =?us-ascii?Q?w6iDhUV09+FW+8gXnONXC+KkH324OiHfHy4I8ZxcgAhZ4YEgsVuoKj9bd/fv?=
 =?us-ascii?Q?wY3G/aXsY2tS7MtUg+O0hPe4xXnsRTkENIiJgjoNcY+fbCFipBNmScVF8Pdq?=
 =?us-ascii?Q?qxHWkfJMqfiCha9te8dIW/0gxpbhld3i0OUNswBlFn7eEDNc9CD+PHpKTe/U?=
 =?us-ascii?Q?Nnn2Q7jbz7I2ZQ7FiuCbGiSalpBLZ2hf0FxHw6jtqS05VK4xCZjFUtQIyt5S?=
 =?us-ascii?Q?C8218BVk+dlIh1PaZ6FigWZXw3eKcGee+ROBeuCWoAItj48IfHzhkaQ+sDdW?=
 =?us-ascii?Q?c2R/qA/b6ceERPfE+iC39HvdCG8eHXZfFBDToCGqmCYMXcwlC4jf0jb67cEF?=
 =?us-ascii?Q?TF0+j1HpBIxIF6dl4GLzRSEoMettsp30JxskU33NOhJ/j0Bn43q//yha9xcI?=
 =?us-ascii?Q?UFZiIHrhHOzpTVLbK0nwYTTWX/JhJTceWL6EnLcSOJGIA37TE4QbuwKZJs+m?=
 =?us-ascii?Q?3EPV5Y1TJW6TY0l1SQxW2dOwjbw7pAVSdKzNbHajkcWXrE2fy8gUMAFqPR20?=
 =?us-ascii?Q?FUBxH08R0+wtxxHdqHabUpwWQsrlR+IkE6fBQG76p+FGNhNArJRgIHT4kDia?=
 =?us-ascii?Q?jEA0BKl9Px9A6yKYsq/lbTwV3v83agaemb5mKtpdDuiqnXmAdxiyMwg7L/wP?=
 =?us-ascii?Q?nm4RhX0J+TYzGiTYYhZS5QhxbGL+NDOx08LrWYmY6v9Tt9Vh5EWqcZ1GB9w?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kF4Ndm7uiz+7ZfkP3079R0Zrw8xT/MaLNRgkBkReILDZKOlX+u2jRWIi/7Jw?=
 =?us-ascii?Q?XMF3Z0FYm97iFMP+79baDRc2cDuoAD0XFT1b0x0yp/BShRvmeDMIierKgDBp?=
 =?us-ascii?Q?/mYkdO5sNIUp//44emkFhHyP5Y6jVjuNmFekbJ34mJEtuky+K/F4V3drBQ16?=
 =?us-ascii?Q?+Vp9wA8lUH5HDf5dXOqPVv3jIwsDFfafu8bk62/ZBdIdORSlzPJGo/35Ogyv?=
 =?us-ascii?Q?LIC6NB/LMMymPN0JC7l5O9WbM0WhlWTfvt8IMIbjXj9DUBUvTi4sZ7DAMcmP?=
 =?us-ascii?Q?oO61USDnIDcFuJl+M1Qq0xQ8gpVxFO5RdZOrSK6Z5PPu2d/kVLpFXg3o9IGG?=
 =?us-ascii?Q?+pXr4PdzZZhvrWI+iiYuNKJyQaY5x81YBAYauyfQ/rRzDHacTev0bk6kXobG?=
 =?us-ascii?Q?OypzHtwa0gMqSlKNYZTrcjrCcdl3JzZl5I6l4d531tRa2qAnk0odA9CxeWRd?=
 =?us-ascii?Q?GUxebrvO0sazXPE0+uk6/hXhn1w3zYcZXVrteovbF0QgIsSZ7ajWj6bmfpOw?=
 =?us-ascii?Q?H5O9R0l+5sq3OWvWysGfnC7/E3Bpl8DbzHO75Pn2D1kGGR/Na9UOdv66bKH2?=
 =?us-ascii?Q?ZcaIfLg1r20n129GCAf++L9qIeUmos7e4cG5e0brPATMcvUu/5jm11JyvIgG?=
 =?us-ascii?Q?osivzmdTA3HmXsKsWDz2AYY+IO4DSdCET9xl4YhXg0+j4EIvyZNWSx8y+iA2?=
 =?us-ascii?Q?PkWQCNnGIm6OahWQX+B/hXJdCmaxMfJFsgrO+2iBM1jVZh4M/1Plw4mCJTV2?=
 =?us-ascii?Q?J+bpB9HxQLqcYMjb04EOc/w8ULLrKhNk7zgcNhptVyU3UOtmxGYCFe9HbWco?=
 =?us-ascii?Q?cC16RF+jHTglr5wrxuRrxyMM2OmQkM4XJzPs9A43yJRzeE25efBOdBnTbMCd?=
 =?us-ascii?Q?YxryxcvohyI41zKOaUCTbZ7M1wsUyV8fdO3wF2JyxZHiyJuOTXbFIwpsR3Ps?=
 =?us-ascii?Q?FVqGX7dlddqiLcHd17LnhpjUFvnEpmDTToC1qbkYR3BRbfRtPOubpnFS35ps?=
 =?us-ascii?Q?OJbtXWY+JqDDgSRcAVVxKKPysLxy9zqp1eJzh1JBqHcyom1RUyp4RI/h6fHy?=
 =?us-ascii?Q?dTVjNhDwX08h4I9K/sSezJQgHM3oZ3I2aov5icl5rLoBBQSP4b1pqROVywrQ?=
 =?us-ascii?Q?XnmVcIqEF3qJVtMmDJxzq2v7+yFAFvaFetuMNzUs9qIbHLH9YAphSK3eBAHY?=
 =?us-ascii?Q?csbNjEIZxeQ2CeFXcS1Fd4mtb3TQ0VgqihKgvMzIuuIdC3GR1jaQYJlTv0Zf?=
 =?us-ascii?Q?C6sFS03oorDptIETt4PkdjDh7acCUM4H1GcXOs3bfmV3wUzbqO+JeH0RE6av?=
 =?us-ascii?Q?hyfLgvY7cS7aEP4PVZk0aK9mBpOIaPV998B3QtGpjz/eSzLCOGNLF1nX1k5u?=
 =?us-ascii?Q?4rM7Z4F6mmRCKusIG7u7+jCRcvFNXKZxUNfo7aidsKsAcwZUC51Wh38ZuXKE?=
 =?us-ascii?Q?/Ya30e4zcq2yvepYNP39LOmRwo1vUuAAXm8bVaOqgOY6lDgQl/OSLGn/FSCB?=
 =?us-ascii?Q?xzZFLkz/5/I+VHok2mF+tr791LCp8Vpx5uEWKjRs8x9jjl00Ap2iGGUMv3o5?=
 =?us-ascii?Q?pAztdqNDU38eQYCdEbnmBvxET5oCOiF3zuG4wvW1moIBTsFjqaGNHwUXGUfI?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3TNjCD497fVhWL54Lr9bWqywrv79UbiPqGx7tf5Avp3iVLkjKjpKfftooamKi8WMWKYjfw9MhMUs76ydcD4sZWZ3iN4TpPTkfw/Kg/YTzw4Rqpbh7qza8ZGnd2C2eSS7RFWpmUclM+ttJy4rJZaf9PZZgpRcjjnvLu4WTBLO+nmCPgDPgtO3cEHMMDb4SFdqork+WWPzV/m+PHc+kC8tHnC8IJA0J8LMAeXNn0uDrinyOS0qofQSXJL2IfvRd2ou4ujT0RlhwPEKOLOKU6wu9CHBNgvKaAivI29lpU8LrArubQ1WSuQZCe5Z4Ip6L1aGf0zX+sX2V0+vJbFgx8dYreKTFQFAw03+3IrrNvQc5ryMY4ggQGLAfwOVdwNvIcsrPxOoFqGeelHivi/QWFFbvVzQYkdMs7sz+nXXvsEpesufFOSgWFljuDASAwRaT5PcHb0wv/oJz2EFbhjOOpFm+X7qsvw57CNIzDVSC/8Vk5RZEEC2wDFXlQgUvzVvAjpo/PVcNgNo0x8qEipEm2B0yrWbvZnN2jvqOAIMrwe8zPR4YHVdR/oo9COX5yeEOg8zCwSkXaU8okIBcf2YAKTd268+unDOfhm2NsscNmoY3AY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bb8cc5-2bc7-4ba6-bc88-08dc646d48ec
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:46:11.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZ0WRvncIbgR/EAe45b/18mrheqCDHkIybML+C2c8BYqwpZXbMvus/tdFxuvrLsIuuE74u9UtVzTXRRcljRFXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_11,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=759
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240055
X-Proofpoint-GUID: 4AlZKk9G2WVfOFoz6QR0Tg19zhcJtGWj
X-Proofpoint-ORIG-GUID: 4AlZKk9G2WVfOFoz6QR0Tg19zhcJtGWj

* Liam R. Howlett <Liam.Howlett@oracle.com> [240424 10:40]:
> * Andy Shevchenko <andriy.shevchenko@intel.com> [240424 10:19]:
> ...
> 
> > > > On Tue, Apr 23, 2024 at 10:29:31PM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > > > > > > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > > > > > > where do we copy it. Any pointers?
> > > > > > > 
> > > > > > > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.
> > > 
> > > I was unable to locate this discussion.
> > 
> >   `b4 mbox 20220603183231.15159C385A9@smtp.kernel.org`
> > 
> > works for me
> > 
> > $ b4 mbox 20220603183231.15159C385A9@smtp.kernel.org
> > Grabbing thread from lore.kernel.org/all/20220603183231.15159C385A9@smtp.kernel.org/t.mbox.gz
> > 8 messages in the thread
> > Saved ./20220603183231.15159C385A9@smtp.kernel.org.mbx
> 
> Interesting, I usually use the web search for the id and that failed me
> in this case.  I use b4 for patch fetching and reviewing.

Okay, I see what this is about.  Thanks.

We should probably switch to using the right header in all locations in
our testing directory.

Thanks,
Liam

