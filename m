Return-Path: <linux-kernel+bounces-155506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684C48AF2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77631B21ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C00013C9DA;
	Tue, 23 Apr 2024 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gO83ZDze";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ef3S9lUO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359CE136652
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887765; cv=fail; b=NYtToueU/paypd9/8rzbUH/EPKAgGBcFK21GaTX112i0OKqQd4C6Bom4Zog9OpivDSwdXlSNHKLHJ5V+seF4BNK3a8oz2uawkR17KxrN9EqeMPJuXd3Mz4LMyaLgXcgQ2LmeiBrOnvHEmoz9pzkIA1z0mUW2foZ9wzuS0YSbUfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887765; c=relaxed/simple;
	bh=vl+Cq9PfDI/6LcTFIEjkdFO5Rh7/nuc6qg/ED28MVyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L+Hbu4xXEB7NyQJ6bSTzMS4mqDW1Y5pfT8HHfUXq1B0NBpYCLWrZ7uZxsSSnyYZRIieIFHNHnjTQg9EqusQRdPW8Qb1l5enGCKk8Fx3WSkvow86ODP1HybOFyXCrobNwBHx8V4LBNjAa7DcByj1GvoohbzYXKFWmqkQriJZNVlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gO83ZDze; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ef3S9lUO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NFT6RB002425;
	Tue, 23 Apr 2024 15:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=dFQGfdLWbGp7PA3BpNB2Qk0w+FAqXAA8b7IyJz2kF+A=;
 b=gO83ZDze6T3otxrzqBbRpDX7T/mHIqDR4uEEKVDJhEttoFLLwK1ethwTB3SqjaQa9HXp
 woGt5jTgG0jlkc+UoYqpgWTt4nh+xDuR+/EOfCgwjLJXriLGNyHVBs/v8atSF7jvjYd4
 jwDmTLTokDWBdNgyGcBUldlUNb4Z99b+REmfS8IkMLdX+UMYK3z67Ht/fzuc/uFp6zQC
 d30ljbzV9qU+a6imLCZgdW3K+KGPpIGF69r3cyJGBhe/QD2hZQiOsyX0dqKVgM5X4zXA
 bJWxGogbNFnI3yooUeMnKigIfFc3ZyxrYrfgEg+jJ7iXCaUi/bbiRfz8nBfA6ZCVgJUW 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5rdwrwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 15:55:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NF2g2G025274;
	Tue, 23 Apr 2024 15:55:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45dq4u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 15:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpnYZga2eh3zxykvRKIf3O036VjCrpciw4vU2yJ5Y/1pkXmFggejN19/VQXfQu+UCmgidNbDcbKUIoI0dtH3f3Bqhx5rF54rnrPfUEDuKqQ5GXsePCvzJuzAJH8hAs3fnWqKGP5PiwKjjCMIrdzNRIAzzGIcGF9n8aYq8JpGrX67g0zPQVHrBdnCq87J5JDIJRfynGwj1Xo9pNWED36REc2Q5qMogkpFxCFnsMs+vJaTGoWVtfUxXtSoNbfiNnqcgjgHQjUQsJauZXD4s295qyWL9Al7jRdppa2cDegZGRnrzs++hQHCnNPOvVOMb84u+eBITouOWjl64MATIFrK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFQGfdLWbGp7PA3BpNB2Qk0w+FAqXAA8b7IyJz2kF+A=;
 b=iErk/up1DgAb8c0XPMmzPafwskcxvGsBzUrh7lRsfcQ3IxDwQPpAX+U/F5GwhtkgtTbiweX45m1QE9x714q+7yhCieT6Yf5mt7Im995M/i8iH2C9XK6ONRDicfeBbOUHcnuH/r3M8Y8QYkxMX5Sp2DyVEx8TSy7s9cpMOTd36AiRsjfyU+OSHmQ+FFaeAdxVSEroWTKikW9nqntv5iSy7Iq8sCCOuPMvMyeB26dhq30KccoffPvv7jNoOR1sSyzXPckmt0IID4+9xSWj/kBh3UTt3DwXlN/ieFazpJ78noegcwFIITF699QWKpVPNWMrbpbcvRPEmS4i6jQm9Dg1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQGfdLWbGp7PA3BpNB2Qk0w+FAqXAA8b7IyJz2kF+A=;
 b=Ef3S9lUOzDN4tPnOuFTCnRZYy6WXFjnsvuF8kBYdMhK4Fu0Vi6mgVPE8jJnoBqHkBEUhmuqNdDntXgkmE/alghlFzgNGyVaKoWC2uJHNr5we6K0ba5gcGX0YktxjjtiTrM52LGjeoJZtz4LAbrgtyfMpKITV8+onM1F+vrZWJS4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BN0PR10MB4933.namprd10.prod.outlook.com (2603:10b6:408:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:55:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:55:51 +0000
Date: Tue, 23 Apr 2024 11:55:49 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm: page_alloc: Avoid defining unused function
Message-ID: <f3qr7e7nmith6i4dbffsxvm63wappv4nl4d7nuto4432mpcec3@t74zh4amndir>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240423150622.2526825-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423150622.2526825-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0062.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BN0PR10MB4933:EE_
X-MS-Office365-Filtering-Correlation-Id: e203e79a-05c3-44c4-a22f-08dc63add9ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1hdbF8ucw5IXZ3R/g3kE95FVC3V27Q36M66aogIBlNAxEgAwurL8w8XE1mal?=
 =?us-ascii?Q?aG8vQWsQWwJPaJhEcVNs7W0fWd04LRCTowWetaPyTbRgRhoooQ6KBzaaosEr?=
 =?us-ascii?Q?8ag1BETpk16IpwzOfti28agFuEhVCf8M4N0KpC3Tn6hR9ynz7OpoMOBqRbYP?=
 =?us-ascii?Q?ikKfPrZ+FXVc4sNqAFKBG1FkutLFTtvWDyvwOlq0ixtN1F63lpk/guZJ0Q3A?=
 =?us-ascii?Q?iRxw0cUiIu9e70d1dQr7j+948D7umJuHCn6xE3SJM0FWJUbxon5OKo8gOXUc?=
 =?us-ascii?Q?gdyllo13QgIPn9Co8oBfLyK1dGYlUoWx8GbHmhnSWyVfO5zpIsr8sAdYZE6U?=
 =?us-ascii?Q?ujBf7i0t5gk/83xw2NQ3+MHyEhJyZpL1+cTz4cxGhhXPJoKzS0JGvyUBpc/N?=
 =?us-ascii?Q?OaEjpaKTA7FHo0BDDY8sDqxyT4SG3CQ/tQGIYMYE2ZjGDrTtqIj4kwYB+1WN?=
 =?us-ascii?Q?KJnt9XgOnUZPUuAXNE6bX3jyRYuIjo3trT3aeChcMa2tGwFd486w0ZpmSTH+?=
 =?us-ascii?Q?8PTz0k4iQuQu8yuvbnRSSGkqY1RaqCuuNUikbYznq70Os9HAoXbOuhVyLuV9?=
 =?us-ascii?Q?lsqwWFUqr7WA0sOziA3K2ZIYpjLIz/s42wCUoMUsanc9WG5jn7vZq6trbGI1?=
 =?us-ascii?Q?+11MAT1o1xXCA2DJko6kq/+KHbloL2oU42VwBMWP3zplvbXobo/kqekQkLDM?=
 =?us-ascii?Q?qRkFtdeHZ3xVuynNyqKEy3/YAoWp6i/QZlaDyiQiXRYnif1fbDrerLbVJhVv?=
 =?us-ascii?Q?BBAMixBiSWvh/rbAbLArx6xr0jKMSznosjAiAgbn7+knvq6ozKk2Ttrj7BKV?=
 =?us-ascii?Q?tTf9qxp3/ICcV9vyEhVmbM4w7ft574JDrs91rv4mcEhfVrToZwveCW4STC35?=
 =?us-ascii?Q?IV0jg7ypiG0tGdlKVWsYihpchgYrabdzk9APIuvc9uOPbZmSlZuWoFjPt9fU?=
 =?us-ascii?Q?xkDjaZTkFHPBSl0F7rOo/KNs0FYDRLWvEa6ESVQIxM7nMaGi4p2MKzujJDWY?=
 =?us-ascii?Q?eNBb2Mpy8USRheJGaL980ATDqSJa5RB2Zac9hotBnYypMT7o93eILASn4cYP?=
 =?us-ascii?Q?kd347SIO4IsNbHBIm3XolcAWzOxCEP4KGm2lNkOHl2ylCIhcK0wQezz3CTd5?=
 =?us-ascii?Q?w2/KDtcSshynC+IKQncSjvWIe7DQwbFZYlvShJhcduSaO3aLIqPXnq31iSpW?=
 =?us-ascii?Q?rVGQUugCQ12JsJvohvDC54/X7zR6jMW5eTUNMtCbLz4oP3tqO6ZUD32umSzo?=
 =?us-ascii?Q?Rla6hrrCTRB54LEdBtu/JgqviQQo2EzhQJzLznf9VA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C8ImT3LgKljoGOJJ5Zjgzcco3I0o0wUB/fJINY4QiZFEzPZoAj+IK1gHyM74?=
 =?us-ascii?Q?TCjGgMtpet0l5sf5vgLnXbD4hybv52sjgsLyShZg+7M4di2KTo3nEX8Q9C5M?=
 =?us-ascii?Q?ZXocaY2XzCXgl453WfW4+fVj/wNiZxE4F/eLowoPG7eGMEG0JajEzSjtT+IG?=
 =?us-ascii?Q?FjVXahUXM13tR4j4qDmBk4OMNkjbsEIeUNoy9z9y/OjwxtSGaVyMIcNgg8jw?=
 =?us-ascii?Q?H1obqBQFp5uHyQZMIqfiE7Mqw21axtWnI3OrZgpA4QOl/18CC8xCFAp2qwXr?=
 =?us-ascii?Q?g0SytEkF3jn93EsFVZbw4ABP1fpnxLeR3VEFD3FOwrgx7XwMuJ285371FTtH?=
 =?us-ascii?Q?gVTvo154MbPRIYA53aEZjRObF3XvAt9pF6hZKcBwoW6Wm/r44SOIXqBMbuPD?=
 =?us-ascii?Q?hKBeTMA8U+eu3cS1v1Iwii14vQby8dQT3tcBRPymoAYn6sKjortdMb7uLBNV?=
 =?us-ascii?Q?c2gdYr30K3maYjWHtMm52FS6IGWJVBCDNk+40XpjIRSme3fJVSYAONwJX2+Z?=
 =?us-ascii?Q?0VE3TdL0qXCPle06JUeUce/FV9yVo+QU+FrqL1pbYqT9V/q4TpKNg46vGR7i?=
 =?us-ascii?Q?ursFYZy+nP03/FUYcE1EC8D84Gt5vdl5mVJdwYZl+smcjZqF5I8rnAO7FCGl?=
 =?us-ascii?Q?hLXBWP4+NSxsXTdzQYoda0QjPqQ/dmH2kx2YWBGvJw5iRIy8LwTe2wpOJTu1?=
 =?us-ascii?Q?OvNrrpNAzs4fjw2GGxlt+Ap33QQuOTXb80LJnpbGTHomkd6DWg5IkBTJkQb9?=
 =?us-ascii?Q?D8ygu3QubHfmGnV5ysFiFnVXlzjEM9fYRDsvzu3p9HvWGqIushn3CtG7t2ie?=
 =?us-ascii?Q?rzUx7i28eYgCga3xU2D15XHuZi/mbP1bJ08IYtVtbT4sfMVNYBI1sJI3tbYs?=
 =?us-ascii?Q?gw+HUQRmd/YIl0x81PpS5mm2f3JLFbBgOIGGhs8cQ16KV+AuqKYx9m6C2l1g?=
 =?us-ascii?Q?r1OJ/ZPn25WAo5ywFLl3++lzy6vcvnjj0+2K8mnHF/C3adVLEbY7eLlkQbgn?=
 =?us-ascii?Q?VD6Jga/QtUTNc3ucK55a7QbPncXgvvXkUwR95bfJss74RL+9rWiU/z3yoNg1?=
 =?us-ascii?Q?fOvSqM45tmhmB+lkxBgGtiBcJF27byskeEsFJUj1r1YcCSJUP3K30+EdXDU6?=
 =?us-ascii?Q?tpgmN9qmboSPx6dMB/sbjXpI6/6n2py6uIyVT4e5c67IspTRVaRoB5sOyRV9?=
 =?us-ascii?Q?mug2QosJSLJQEPJd/ZopGgFYsGe+3CJJBpVo8u0nJ+RH2fcZGb+rCtqMS1Iw?=
 =?us-ascii?Q?Bgo7GjJ4s0wvgSopaHjJfGSmWX4MGj8ZgXh4xbz+Pp7mOaOzQt+7im0JNGEG?=
 =?us-ascii?Q?qqzF6Cbb0GoLR1JoZQwp8QmBQjEgAE0EwWp95opuo7pQAyw9OA6ICJrAasQX?=
 =?us-ascii?Q?aqhvqGyDrPjCIKq9U1/NG9jKmFzgNVMYCANiSZk3NqADuOTWF/WtdeLgMOJB?=
 =?us-ascii?Q?D5U500ZYeY/YaIphCCRu56TqkUbLaWDg+fk6U2mYhWCZqVVl9ESoPGtt/ijh?=
 =?us-ascii?Q?3KNLaEogAkEIIoiKyGYoh/bpDRHw5a1+n8/aoSScB34uOXCORuBZThK6nhfU?=
 =?us-ascii?Q?PFKYbDITgyOFna6z/H4kkxWPfjHin78UdLwa8z1z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lt8L4XB8rVPeqAr/LXbG/kLNGNU6qFaQTcqyeKCQHhfzozcTlaAYJHGeu0+h4zj204VP/sE235Mq8qzzND+MVTz0rReGeegh/yABhd5GuZXio1ZSO6g0d/oi+YfGCRkhdesoKxmbfMgo8isAgqGhOUK+rw9dwayw37Mz5MJg8CBkk6yUCqeArA2jIfmefVnsBtdyNmihpy9VVqHWISlRKTPXgECJ/EBEQcOLbf5SOt82BxxsZ4AOl6Sf7GXcUPq32vmH8gcBOQ6nx6XEm8WSHaO6T8/q21X6xTqJ5+blk/D3nXlOlDk2/ltUWQrlaj/uWNWGGxyhLgO0gByQy23NvvDlWhfjOdTGlOo91WEcxbjUjUA3RiT2DnX67szCIYfvs1tEde5F79IuKRz8Ao5j1IE/C4c1hbT9tgRlyF0UH18xeekbSPy+AIWfa1vWcEr3kGCbeRRrHT3ZWERlKyS/yykJ1L6wX5VDed/qDNc7sZvH8Psu/NKUOvwW+ou0JB4d1KXWQosG+0doCDgdYXnN2u4NAyzxWOdaGyCxMgl8ndLzF1UHGCxVq8QDs4ubq211441LgNShfTR9NTDEekzdit9F6netXD2rJrOzH5IKDxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e203e79a-05c3-44c4-a22f-08dc63add9ab
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:55:51.3619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEZsfFIhXF/dSi1h/s2rRRe1acNcwSKKWz1rKOcbQJ7zAnAehss7f8rauXcpMu5JLiiNW2UvSd22LnijWxZtlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4933
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_13,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=724
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230037
X-Proofpoint-ORIG-GUID: Pf4SvBpnLtztKKHKu28yz1ANnjI8vFXF
X-Proofpoint-GUID: Pf4SvBpnLtztKKHKu28yz1ANnjI8vFXF

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240423 11:06]:
> In some configurations I got
> mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> Becuase the only user is guarged with a certain ifdeffery,
> do the same for add_to_free_list().

Why not relocate it within the existing CONFIG_MEMORY_FAILURE block?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  mm/page_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 33d4a1be927b..0fb796b700a4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -653,6 +653,7 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
>  	area->nr_free++;
>  }
>  
> +#ifdef CONFIG_MEMORY_FAILURE
>  static inline void add_to_free_list(struct page *page, struct zone *zone,
>  				    unsigned int order, int migratetype,
>  				    bool tail)
> @@ -660,6 +661,7 @@ static inline void add_to_free_list(struct page *page, struct zone *zone,
>  	__add_to_free_list(page, zone, order, migratetype, tail);
>  	account_freepages(zone, 1 << order, migratetype);
>  }
> +#endif
>  
>  /*
>   * Used for pages which are on another list. Move the pages to the tail
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 
> 

