Return-Path: <linux-kernel+bounces-153521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778C8ACF18
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD051F21828
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B451509B5;
	Mon, 22 Apr 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ldMoaKmU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FcfJqari"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FB1509AC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795215; cv=fail; b=dFv2H7QuHtwYC7QfL39lfk/R/0IZ8tinUs5E4ofxYer6g2bQRFZDyx/eJIsu5Khy/gKuGIKSfHHVElSkTO67ig1j7sQjLToXCMG2F4ztkgF0y3OPBFFbKO2/48oYwMJr5W8VyppT9D6X0fmSNhoTNnVMrTXof/lHh9DP8KH16Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795215; c=relaxed/simple;
	bh=KeSYt/rVUreMxwWDuUJMHW85nQyrE52mBcmsytcQeWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CUbmNB7av6eg48irg0zY+/F5KapWvSBLK2sfR8DK0MrVYlBKzNZitWE690VAe8tsDJO7vJyhyl4Ig6O7pfBYBNSX42KcUyMmbY9V5FSJn4mlz9HVcxCsq1r3LlB2TvosPo9oQ2QucBRh2zOgpYQsipjz6/WXJbrnxhvZGs+vgow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ldMoaKmU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FcfJqari; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDZDZ7020766;
	Mon, 22 Apr 2024 14:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=+Xq5EDFSdcWa0SlylzGabOjN/InMLpCUpiZsrCGMUMs=;
 b=ldMoaKmUb6cdgDCjFitmhfe6VUNHTI3xYgtiZXJA9K4YRqpJtDI/TdAbj1LlE8cJeWxx
 Y5pwE9XLsauoWx+lJ6IFliSlLEDqMEl3jlKWVUokeCvnni4rHIpMX3sbg9hXLC6Mj/Pm
 HCgoAWSJXCpkqwfJ881OKzDgJowBJDg3bc46iOYvtMm8VXgQvl5MwPP3zlZnepzhlhII
 R0NzrAPRhYn44RrtaEtFrsV8v39f43m+eyrkPO9zCkXXHMrq9jyTtEzoPsg0RpaeK7Vi
 IIEzVDamK4r9Aoo3zgoJN44bGvMBW8vwdojvbhHLSSStVHLBhlUzoZPEDkzyFEGqE533 Mw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4md2tk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:13:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDruZN035076;
	Mon, 22 Apr 2024 14:13:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455pex3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:13:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9MIrNg/Vl2W1M50EoARnPdR5vvlbVKJwKy+k7EV5cLCBsHI9Ekfu8PD3rLXXGbhIf/p1+Oc8apQCexmO2546mJccyWoY2dKGpNlpTckxtN0BhlZyjKWH/nfp/J/niuqRxEpiEJ1EY1ZZHDwdTDZvBjVCAzVuorsGB7Ehzeod0Y7Lg4/ytqvduqz3iogoWVpqpj3sS2a3xtqsMcWbX+mnBdSv8EDAYQdUBCV5wCyCxS6PgqTRc9Zrc2pqsZsr2HhqxeV4/j/2Daj7xzJxqTlDOklUlqNtn4cDkMOc7D6EPIMpPeOfWW5iRWD0eZrIWx4IN1yV8gG+FmLOCw300znCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Xq5EDFSdcWa0SlylzGabOjN/InMLpCUpiZsrCGMUMs=;
 b=KZ7y9V/B4b9WJEowEIVXdNLiVf5EAd5LPLU4nPFmgcuNUEAttJvHC/3Ap2ySFNJZOL4kmb/7az9rbgRFGqNdrT5RxlJFG7JetJIeFyI+Jf9APjjmoZr1eOd6sDJnzm8c8GCYSqiPMgF+Sk/Y/yYOTJHnZGkkgi+o4p4vfAD3yDtDi/mXXFwK2QyHCk8CKTAFt8JTJfmwqSYb2sGFwuDC9bArIgkRiAeLz29HITXwdmpDl2cyDGu8Y93B9uofsZmSOsLTA0STFQRWs5OfCHZrhPX6MU3OdJWLZ86NCAQtwRt2rTn3wn+5UitoG//q9RZTZX7aTSUePJ0ZmMboEUFK6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Xq5EDFSdcWa0SlylzGabOjN/InMLpCUpiZsrCGMUMs=;
 b=FcfJqarieZBX6zFsdOIVqZXY+cXzEEsS51nTIduAsOLMy9JllnA/sOPSTD9kIKqxIWRgfZZU8Sl4wQLv+k4IxbNwQhOSKfwoeNSDPHtJRbHbCH9C4yGMg5f2qtRxtaYXbLRUWAqI4y6e0/QRwC+CrsF8nNBIjhJmfFK2fjEB7QI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7033.namprd10.prod.outlook.com (2603:10b6:510:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:13:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:13:20 +0000
Date: Mon, 22 Apr 2024 10:13:17 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        harrisonmichaelgreen@gmail.com
Subject: Re: general protection fault in mas_empty_area_rev
Message-ID: <uekqafv4wx5axijnnfybnxixui3ruzy3mkxirflv7tb3ovrtbk@ounqurycykuv>
References: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJg=8jyuSxDL6XvqEXY_66M20psRK2J53oBTP+fjV5xpW2-R6w@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0318.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: e81d9a84-9852-4fb4-c3ce-08dc62d65cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yxqz7Vxmvcxt79k4PCIW9mLXroBqGrDkN28USlqX8Qvl4AtPQpflkztvgXpm?=
 =?us-ascii?Q?ik6boL+cVnZmOE4LaAx8vrOaYihZsggjb/KzsFy9o9eNJJrMvquwdLQkc2FN?=
 =?us-ascii?Q?Una53CQ7aZQMx9VwMrRTVEP3y1kuMdobt1PtS+ZFG4+Vvi48ZaXCnvijDmbF?=
 =?us-ascii?Q?rt7w1oybdy37JC8eQrD/NKMHmoe19rbLivE7Fc1XpNyIl3xQD7w3Y5983LTy?=
 =?us-ascii?Q?L3Mub3iOO8BfVkmG3tGpQXgrVhB7rjXSqVL/N1niDQfJ4Wi/kiqoWBuQBXtx?=
 =?us-ascii?Q?TaNJ5jLC5c7/KuYHU21A2IpWP8MQst3IeXoLxKIwm1Wh5t2JtA+oWUzyf7pz?=
 =?us-ascii?Q?6V6M5sbdjiHUUZFX513paYt/FbEaRCQrkJPGl4BBUeKT2SoN/0Y57xj0lTDL?=
 =?us-ascii?Q?YLo39llW42oEZi4BWxO8nMJun07hImGTfxj7HebOulYca4IpyLLA40OU4eF2?=
 =?us-ascii?Q?HGT6XkOiDpzhCs/py5MYd6pGAdNfZjgspd3h4HnJFmlZG01gY92L854J/L+h?=
 =?us-ascii?Q?NF0Tf6MTyomCCb0knlG+u9e8p17t2dm9+kLhgXEDYfI0I7xq6G9FqV42uDF4?=
 =?us-ascii?Q?8Kkwc2+xHRI8TeS8QA84PoQsaQQm39coeT0A8tQYTK/kRS7R3yXV675Lr7U1?=
 =?us-ascii?Q?D2z+rNttaE6nzhiejHukg5jzPEQfq5/+OWRxnB37c/IPknQQAG7RgA9MqvHy?=
 =?us-ascii?Q?C6FfxlVow95JfsJZJWEQi2Mew//hlELhT45yujnq54pH4/3sTcRb90uH8wVD?=
 =?us-ascii?Q?v8tsIH+gCY8ds5RZTzatKnatvfTvuCc5xpJPLaBbo0bUkAMo3ju5LqhZa006?=
 =?us-ascii?Q?nL4/lrDhxJ7NNJ1f7yef8Sl+aIlcPBb9bIOnuqWyY2Y6lV0UjZ55dBfjfrV/?=
 =?us-ascii?Q?uHX3IEaYIYxHGs0+J/r1xxdAQAK206xuEOTFGYp8C3V0AXm7p3Ooczs4p8HS?=
 =?us-ascii?Q?50dddcfjl9RTXjpBC/ypvoCLXGa8j34EozJ5mPFNYK5DJHBlOI5O65sxhLI3?=
 =?us-ascii?Q?kVYL3eywl1mX+zEFtpgZixAyTxr/zatnbpajwSPr1jy6ycZg9+QcsVAZgp5D?=
 =?us-ascii?Q?vQYraqc1J3CyKeJuewiCPmccXNKdcu+WdB3dJcxNqcEd/BNy2QX4HS+ePZ5+?=
 =?us-ascii?Q?uZ+kva9sZn4/Gv8QKzVnf0LvV8pCW8ymAMmPteh9/54WTuwLl6uODwMkgaKY?=
 =?us-ascii?Q?DTFaORLbhuRCq3/xpgpRVWZ/S12sW7ImODPFEgNRlzKjIlVDY+mzZsYEKn5u?=
 =?us-ascii?Q?T2cW1tktsKwTaUNjAIZpSxetSdBcchQJihjqbayUN0RRyQKiiStGNQcfqf3+?=
 =?us-ascii?Q?pfIOfBxOLPcxci/XhVzUaIT5oB6yzkh7IaSYnyKWRNn+Iw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h+TZK9Di5qVhPD2fSO7x37hywsvGi7VAucKr0rrOMjL+HlTtJaXYYE4utCsT?=
 =?us-ascii?Q?LLZeo+TgXMD0P3t56rXino8IxPXfp8zQZvhzZ3f7isD2DK4Tya8iIb9MoIcw?=
 =?us-ascii?Q?51DD3RnpIM1JKpwtybOwZMG+itzOx0UV+IlfbDiZ+IwOKZdlFJv2giVuNBQG?=
 =?us-ascii?Q?p7LUZQhD4ZJs8qs5n0eFDugT2qbZJBFXydVL6RQy0aIH5MRod8r4bCtYugaI?=
 =?us-ascii?Q?7rHSJ8kZ1px96ZHriUtU2razPAFW0FIyOAvdcOxSPBDDOy+B+XHmAjxyCn4c?=
 =?us-ascii?Q?dGtoLSztT7ZTRjOmoJ2VfkmW4ZSbY8ga+1uW/wSeYo6g4BbSIznNzyXV4vxf?=
 =?us-ascii?Q?HFPmMiKbgu9DPDU0c9phh4v+cONX1C8X9iXDEQQkVMfBQYch8QnDFN0qCYir?=
 =?us-ascii?Q?s/ZhaIq3dCUqYxfRy7WoQ3w+qaunZN6clOt5bxjnWWyc5HgX9dvXCcYpsomh?=
 =?us-ascii?Q?lifgLikot8sJgnRFtoZBy3zuheCBU1GJQnonNvWgFx4wXLqC4BC6PyeWHTpp?=
 =?us-ascii?Q?119ZqyKxuA44jMiasOCN13bxfP9oY7GVG3nNV4Zg113ixUMXBrvHINAMfZME?=
 =?us-ascii?Q?2w61ZqCr9cRn3xxblNoLs121QblHEjvcwqmhzByqRyqQnIzX1jRQF95scjpd?=
 =?us-ascii?Q?JZS7yHmFy0TDc69fS5ISsaueu4JudcvQh32821VgNXzckYg+9ZdWydK0ayvk?=
 =?us-ascii?Q?9/njQjsQOvQX+GSjPwo/KBMW2ysVeCJgdYPrMRGyznZFchrleeA0xbE8WOck?=
 =?us-ascii?Q?h2HfDkfBip33gSAF6Uu2BVIYynNVracNRKNWKvaIWk4mkix3zPlBmSepdfjq?=
 =?us-ascii?Q?aLokfqiRA/B08ASCL9XeAAypBgynYG8wYhuXo//voB5Gh6qdWMHYQPiYXV3E?=
 =?us-ascii?Q?Z1PSUokJiAJj2wOrzL1apBylW0xUITqkQPbJTl4WfCVRyZf79hbhnxF/AX9s?=
 =?us-ascii?Q?uSggH5io6g9RKg2F5YdvCeTeNlodCBGd7CRH58odwEOgRT1AJqeyZJsILGAA?=
 =?us-ascii?Q?lA3QMCtTeezYIxUiWmdawG+S6RJi8po8PjEFLkqjAD1FFl0RgfEh96iG4uX5?=
 =?us-ascii?Q?DMDTVdpKNfVPDlJIsR514h8eli1ee86mi6Sx2mpkK20MPRspB73KwYQbcO3H?=
 =?us-ascii?Q?+UY8FVG6htuWcfOmZDMXJoUPQ9wcXyx1AM0HBuyEV0QTaO/tW8MWBEwEprCN?=
 =?us-ascii?Q?RA+HyHvK0ripb+BW6Qnp+3Db0by+Pkr/FHBY7eEvFLaG0mEss+6PP5/52G9Z?=
 =?us-ascii?Q?+PVrd1HowMIdBI5WZuxZus+rQoYgw3FT2Zql1LmJoqhpw8moBMbDKEtKpvH2?=
 =?us-ascii?Q?MghR7ZNm5nU8Jg5yK+cJehA9CLmfEteIjVKTim34xBELwm9w0XXDm3TWuLmT?=
 =?us-ascii?Q?D/ZcM5DFZ+Tbefa+0535c1dJk/UZHgRf36sfO2U+NTeqFlGwqm+fBf05/9K+?=
 =?us-ascii?Q?U/cbyLA6picPXtZCDPR9STbUM4xJFZIZTBJbOSZJ0CBDvkSq3bZstVj3A6y8?=
 =?us-ascii?Q?cTKUNcEQm3pnUzqCDWrx3oBqC0fafYZPPaQE5zN+WOZPBJnTKLMhDrvR/JZF?=
 =?us-ascii?Q?sYbJoBAELWjE8hT1LK/v235Y3vNioFGDsowgASxT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	41Ou40RydcbQo//RvvSsmxpkJTmo6xQU9GLyVPH8AhgQ55RaYef6yzoemWOSeZGVtekmSkdBy0+LWkHOxQHp/kQC4PjzG8Ap1lwayqmRkSU7Vi+VDxpLLca4eYcGP1NlcWKq67GQ1k8t1yWsOCgTx1AZSXRVvYTSQb02nt+WCIVGQFvXb5G/+eu++HAuWEwUDH6UUndU53o8yPBxbrwEXNzEXF2yhu73Qsz+SrcCaKzPRbvU3qBbKrZ7cvsVia/44czi+cVWSPQpPglAlw0/tKwvn0kaWunBi408moImgmWGd2vXRkGGcqzU7F8gN9dHU1LpmBIgtOPqNzWL7w+YXesnM4EWQp2TKBf8KMwnMnoZWzZI1ckJCfNzfzQuoHKgtqLLjuDWa+H3xXUKa1+65k17BKWVd+SVeIJpKxwUSbpTyom467xWuc0NnQDrf5rZtgq9SvOIe447JZboqRrkWjjy8bfrRI2V7q2jpvfT7mtsRQpnjmt56Pp2tUPayczHsn2D8mJetlzuQjfPkeZA8k0Gr574DbuZuJu1cM4cX0r1teiFO2Sv4ZYbsXZgAxe+Igjb3mvZFxXGhsacejkqTFsTgy76MEw/k2ZN4Z3a5Vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81d9a84-9852-4fb4-c3ce-08dc62d65cf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:13:20.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pW9ykJuRG/ys4q+pwmvmNrtoht9hMBnFl/v7cwRwLnKacE4YhgUGe/7mM4KoRETuC8XYhoDpNeD8WYHF8ynCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7033
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=758 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220062
X-Proofpoint-ORIG-GUID: YfFhn-oLbzqsNYlcf4cw4DmStkdC15OG
X-Proofpoint-GUID: YfFhn-oLbzqsNYlcf4cw4DmStkdC15OG

* Marius Fleischer <fleischermarius@gmail.com> [240420 16:08]:
> Hi,
> 
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> 
> description: general protection fault in mas_empty_area_rev
> 
> affected file: lib/maple_tree.c
> 
> kernel version: 6.9-rc4
> 
> kernel commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
> 
> git tree: upstream
> 
> kernel config: attached
> 
> crash reproducer: attached
> 
> ======================================================


Thank you for reporting this issue.  I'm currently looking at what went
wrong.

It does not occur with my configuration against the reported kernel
version.  I'll attempt to recreate it with your kernel config next -
with whatever modifications I need to get it to boot in my test
environment.

> 
> Crash log:
> 
> general protection fault, probably for non-canonical address
> 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
> 
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> 
> CPU: 0 PID: 79545 Comm: syz-executor.0 Not tainted 6.9.0-rc4-dirty #3

This indicates that you built with your own patches.  Could you test an
unmodified 6.9.0-rc4 with your setup?

Thanks,
Liam

> 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> 
> RIP: 0010:ma_dead_node lib/maple_tree.c:560 [inline]
> 
> RIP: 0010:mas_data_end lib/maple_tree.c:1450 [inline]
> 
> RIP: 0010:mas_empty_area_rev+0x15ad/0x2320 lib/maple_tree.c:5114
> 
..

> Call Trace:
> 
>  <TASK>
> 
>  unmapped_area_topdown mm/mmap.c:1643 [inline]
> 
>  vm_unmapped_area+0x2db/0xb30 mm/mmap.c:1682
> 
>  arch_get_unmapped_area_topdown+0x384/0x750 arch/x86/kernel/sys_x86_64.c:212
> 
>  thp_get_unmapped_area mm/huge_memory.c:864 [inline]
> 
>  thp_get_unmapped_area+0x361/0x430 mm/huge_memory.c:854
> 
>  get_unmapped_area+0x1db/0x3e0 mm/mmap.c:1845
> 
>  do_mmap+0x282/0xef0 mm/mmap.c:1261
> 
>  vm_mmap_pgoff+0x1a7/0x3b0 mm/util.c:573
..


