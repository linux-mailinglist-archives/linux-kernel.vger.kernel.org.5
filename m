Return-Path: <linux-kernel+bounces-145853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA38A5BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6F61C21A63
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE133155A59;
	Mon, 15 Apr 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+7W76Xp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="duoXIuiL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0931E4AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713211121; cv=fail; b=GkgRH/jnAxaCIvFyOVf4kPB9TfbaMESvqCXaDetoCJtwtNJsbuSWqh1UrvjhLni7aM/fE5D7ruf1xory89Oeu95mwtjaPK3a+vc1sJOXdHYAAQMeUQfZ4ycz3QKQgFNo/6xG1ftv3D0fJbOQ9Bo7iuNcw+xVbf8yAtbnDZ2Vhk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713211121; c=relaxed/simple;
	bh=gMYBqfKbhXBzTywKK1rQTXMPtf2Egc/sZYNHpf4meIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qdzoi3GNen1DjBe4zdmRRY5pojjZSoxYfdH4APuE8uRvXE+7kavSkvhsaCeHpcU1MJZXPKC4yDxpkTxRjxRQyroRecPUARxxSBQwwGTjStA6Wl6dUih4pebC8NKxmwngsbSzt1IoWwvE0diwu6qUnEBitrdb6G1eRR4IceqrGW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c+7W76Xp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=duoXIuiL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43FIx9Cb025263;
	Mon, 15 Apr 2024 19:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=/z0Mv1UO+WvRJrmsisHbxZoGP8ntQWBqPrQVUDaMXGQ=;
 b=c+7W76Xpx5KSSFXxUpxOPIPy9W5USpo2qVKdvjle0AHUIRpUX52kBE0h8x9HU75SJG5i
 +GiA+2iFyK6UvAj1Vcog7PONNF9PkdmLUy26kdQ57OlsbBDYHXXW0sjy2D5y27nAXBE/
 W7J0bpASbrPOzPLfZ51nRjPpH69Nf0/1gLimUXYr7Cga9ZtLqUkLRRK48aFL8oJfXqmd
 TXgoUUYt4vGDu3t8FozKZdWxmNuxtkY7FqLqZL2Y3dkUYhwxwb8MhfkCFZDueUwRyUO5
 JgESeRGhY94Mqv7nhT6C9sP92A5BnJqN7tsafWmFnay/qTgyK//msGM615CW0qYiP+7Q 7A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfj3e3rnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:58:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43FJvhkn005018;
	Mon, 15 Apr 2024 19:58:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xfggch9bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 19:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6UCOBoeBhYv9XxjhKpfl7dnp1re7AvvQkEIa1VQgL6WcQ6h+rzF7lPIBEDvNvj0OQk+9l7aB2bDoc6Ya2n/pxhb6TWjc5PTklJM9Dd6OfyXFPmWt+SY9cLEoLtWZFNKzq7MZeJ2sDjQ3OsW6P0iZMWehKydgcX/M4tjQT+u23boi8WIPWp4nDK/HtyOOaf/n1dQ0it2ctAH9d8Bvm/TATItdrqPeYfBgxVAbw9WTmCHu/m/zODZYHIP1yIkgyi5yyJBa8oxsqTxs1jcb+q4RlSUt6Z/Gd4Jmb5uJJi7b/LKrzMFtyz6rBvW+gGZW8lsJTZhlZmIXuUiDIpw96Eaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z0Mv1UO+WvRJrmsisHbxZoGP8ntQWBqPrQVUDaMXGQ=;
 b=BKc7IJj6Y2yV2sghtQNIrhA7MtjsIJks2PomJFpeYLERU/jWB1TGPI4m7mcGl/OaWg2+eKSfKPZpqZIAvOE27bB+ABT7Ns+7QbgoMbgFRK/GYPpmrUw3waOFqaVIKStD+rqquaQShboaIx7loQnGh/g5dG4IE91lDng5TMBkjOOpG2VUX4uNdAOu96TVR9PQ94UrbovWz9jh4hNh56yFw5aWYpy0Q9xXhJOuAOTFcY5dnIFmlqg2sfOCePMZpr013Z9Pglr6FFQJtRm5jmI7pfKI5KenQRB7XdPMWzzgyO/pl9ApOh4BGlkgK6/HwV/XSkBR8hwIrFEhKWi7LiLBNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z0Mv1UO+WvRJrmsisHbxZoGP8ntQWBqPrQVUDaMXGQ=;
 b=duoXIuiLH6+5f+w4+lVvdGTb0RjqghApW0NEFc3Dhl2tnXIvL6R5ibkYbraTwzEbltUsSHw5UVJWT/guBZPYoc6reTKpvQir6cTNPRxwmQzyr1ky2Yi4kC8FLbAeoV0zWqiscXFvPDnkCNq+hwYgf5okZJrmmjcea/BjQ7IUVqY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:58:01 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::d359:1b95:6099:3550%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:58:01 +0000
Date: Mon, 15 Apr 2024 15:57:59 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: David Hildenbrand <david@redhat.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, vincentdelor@free.fr,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: Increase Default vm_max_map_count to Improve Compatibility with
 Modern Games
Message-ID: <ht35j3ig4reppggvpcjpjc7gotg6ndrjwvwfiqvxrwrtr4iauh@kw46hnsliy5l>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, David Hildenbrand <david@redhat.com>, 
	Oleksandr Natalenko <oleksandr@natalenko.name>, linux-kernel@vger.kernel.org, vincentdelor@free.fr, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <566168554.272637693.1710968734203.JavaMail.root@zimbra54-e10.priv.proxad.net>
 <13499186.uLZWGnKmhe@natalenko.name>
 <1a91e772-4150-4d28-9c67-cb6d0478af79@redhat.com>
 <ugjnhfiwuoslupkbmrrbbxxdosotzpqjfljebzj4dkuibmf6sr@kuew2qemsen4>
 <8f6e2d69-b4df-45f3-aed4-5190966e2dea@valvesoftware.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6e2d69-b4df-45f3-aed4-5190966e2dea@valvesoftware.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0303.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: f09a9b2d-3ab7-4245-6358-08dc5d865ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QA75gHUrDUGtaICNocUGneRF4r3npew1fz7+fty7rigpsvk3rJN4WeU+KYnMuG9Ewe5SZcKSkRR797QYntHqK7iNDrVCtIN4pZqWYyNVQZya3R8TYnItTzdMgqoZtZi2kHK6CxwpbB2xZ3tBrh7XDX+wEK1ZPvyTk0DOntezBONGCz0azVuRDls9YzDxP5RHqVVG3GHXGpDesdpAE8fctZHy8T+cVVpoIH7HsSI61QrrVCHpHr/CYMSR+d3RAacIoZAFITBdboSCw/xRXApVPgr65AhoHT8pjhvDu631ID7JcjWHUIm9OcCeKxRm/3BIc+Bx5YZNG7KBPW3hG8ofgawlW6A4LX2ca82rqVT65vtE8lblylx7HeNgp5ersS96Xvq3Wi3zP91wxgQtbt36558dTYBVmUwfKmGzyqFLJpVEKLEo0AJkSZTIjpquccmhkiLQB+0LSrULX8ApxTY5K6bNr0OysuiztCURhKbIp7DNS/1bx2LLTwhsGCmaJql8bwRAp4KtkuPQndHujcDSUfk1iozc44ymFZraUw7V2ONUKWhs7XliENZTT2g4RJacXiwtnu4vz9/YrJARWS5MaIRyIQLdTH61zOVRkN9W/MIChlOHYk2vutntSWFauu76O8eosepmYFEgDK+afoC7oTnipA/YxF0WuEUR06cca9RP2IV+MX60trvQgDr6NeawkbQZzpkgYdaWM2vp1uRIml6eMP3SRbx8DqFUkYkgiHM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sp9BmWKeVJ4AAXF+0+mIytBbMLIGAH7fDAc/yVPKINOyBmr5dwv2f0aS+7lh?=
 =?us-ascii?Q?5BhjZ7JLrcyGyCCeu1roB6yx4XvufPw7UuiAkFLNul9cGBzRVgKHUmr5rmgp?=
 =?us-ascii?Q?Gyas8CsT3HEmXYBHMrhUcTsrEuF+JxzxMzvS1uRxiuWBWAao8gQqIK4B85tL?=
 =?us-ascii?Q?cXLPtNKUyjgx31DklhZKFHJh5jlSIRCZBczHHsTfxEz/F7hWM3BL2VP+M2eZ?=
 =?us-ascii?Q?ZqaaLtkagjq0H4HXbkmXcprOjOaATp13yHambUue5YZyWQghiJZ72CIIfvKQ?=
 =?us-ascii?Q?G93MQuXUrphefkHNr660oGGFAlZNlX/1Z56mlU7TDvsO4Cbx6uPd2Wtfq5vV?=
 =?us-ascii?Q?W476YKHD0UdoWyt0zFJB2JTJFU7NKyLpqaP47fW5WfUeJwYrBI7IYOQlxNPe?=
 =?us-ascii?Q?u+y7Y9Dr5Hu5x505taTFJCVVMunMOQK/8i9ZCknNNhPXFam37FSRtTbPGtSx?=
 =?us-ascii?Q?WxHzO6DmbyQ0EvL8Lx+fizQci3gtNVPmnm7pD2MVCMTniO88iDT3TZLrSiR7?=
 =?us-ascii?Q?TBjWYgBlIb5WmxvZWRYArsapLxY54aG3V6jKoQv4id8x5TfzbrPtKikrZa5W?=
 =?us-ascii?Q?7AjELwZcodhSL75g+ZC2Be42qX1QgAt87s2zKxPRhQou5MqfpiHKrcGnvWK8?=
 =?us-ascii?Q?2yCXo/buGl6Afl8kUCwVWuIz98BvT3xmUbPLju8njPoLKWz90eQpvUINGSao?=
 =?us-ascii?Q?JN+is2tKUPkxN5xzQyRSVdTYqeBWwZddxmj4GZjxpYH42MKL7d1ybMTrl7b3?=
 =?us-ascii?Q?gIQk603t6JDcstBJkGoVH/9jSmmjb4R6ckh6MAJ8bLWfB/aZoNkMCBh8Wr7b?=
 =?us-ascii?Q?1u8MVY37L8EtxsyUNSm9tmH8esT4ui2/CpPgqxOH2UTEUMWFWFN5Dxrg7/Tt?=
 =?us-ascii?Q?XiVGLnTyMDm5k134w1YmHew/Vm3m9v99KkRI+Ofuv8hNqSV4YFGSTByjsyYd?=
 =?us-ascii?Q?l44HvMsB0i8xLysiHqZqsHFJ7qC5OPotQJjIv4nEhg4HTrGSLDC1q+unPn15?=
 =?us-ascii?Q?xcCts2jbRv4z7t2WlVrpLq1BkZN9+yMf9xHljMFnLX636eqBTAJX0icSZZAj?=
 =?us-ascii?Q?lmJT1SFouHdT9/B3dzX5Xgnl35RGP0/CPQ3fS2ZZiKLdKt7faDOEEjYR56Gz?=
 =?us-ascii?Q?8kXIl57SYa6n1LERh2JTlZUvLXeYif5vaI+IfoNuaSHuvHjuQRTqmzAV8MT+?=
 =?us-ascii?Q?psPfulL0pPOwL4OPcNh6WIDBkJ+bCWDR4MyiDuzrv838xf+/nu1XLAiIu9aT?=
 =?us-ascii?Q?b+ZFqj6WIpKaWG/93sVcrV7z/8BPyZj99ANF/jamqjtjjfSiRnsaqDGVdivl?=
 =?us-ascii?Q?cqtpxfYvstCS5JU8+0z1nJiK1JeO3vmrhoo6o7BOzAjb8SUaa1jn8wbIFcA4?=
 =?us-ascii?Q?mWDZBhnqRUmuQiIPH99lG1YZBzrLU0/Pks5prH2UzpcyZWzpdaEcI6ZTeMO3?=
 =?us-ascii?Q?M+iF/fQYQUnBarN8noClWljQQb3OrAPFigAoFbzWFL9Lg48lmjiBnlYj2Qqs?=
 =?us-ascii?Q?RmzdTjjzz8YeDlTG/+KRyZWHkemj33w+uEKt/AGZUrZIY04TvYp+Esgkpnc3?=
 =?us-ascii?Q?NjnV6e6Pt18a/o+32Q4echPSCRIc5ZIq3fq6asxy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cCvND5/WZA76mzGCRrOI6K7N42HHe0XPlBySKkc5wxlycCMqDCo2iT27aKqKvVTm2J3D7YFY2Yf/qudUTYcz2o0bcwHB3UjevrO1HslTq1srUGeJ86u402+AxCbh2frD73/maarAaZlHOW25LT+ajI6N2i9a+fwX2x/m0PKZRxUoI5db6W/UgHjx/BroEEfBa8u8A7HbmeszgUFXOHLiMhXu8Ay5lCFu+mZo2aVdu55HBADnlnHAR2OStb1OyspozniYEKhl7WUmgLNR0FWQ51igCK5duNiaTjijsm+M6WtVmM1I/2eSr0WzR4nkJ91arXjzH7of5U/GlD8+GHw3q74mKbLMgVXHEN714v1RdtaBB30ZPzFrct//QHaUnNNUwK4Q9nKDV5qjN6EnmSl1bAQv/8WKAE8CZogueOGp4Y+SdzwZayhFCbk6+IpT0oWp/Mrk/aEcLE2B/BWUaRdTIXxvpvBgiPlqMGuXOSVjdckIF8YzOzBXX2S5Bn5BXvJkXpD3LVSEsQI6Nsz8zciQpfEFq2hYFqdjhzIQgKCswHDOPBOP/rkeFVKELT33Tz8J0tun8I4viqoJ7A+1p0L0o4X7lbPiZ5+bl4xZC8Hb2yg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09a9b2d-3ab7-4245-6358-08dc5d865ac4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:58:01.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zH883UnTXvgQV8KSlLL8v1bKGQgcmGsx5gY1xDfFjlsU2WsF8AYcCCvIwCtWP6toV4n5QOXZjPnR+myamtDBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_17,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150132
X-Proofpoint-GUID: l-hqDgRu-KiNgNV1OB5v2em11MiQQn2X
X-Proofpoint-ORIG-GUID: l-hqDgRu-KiNgNV1OB5v2em11MiQQn2X

* Pierre-Loup A. Griffais <pgriffais@valvesoftware.com> [240414 20:22]:
> 
> 
..

> > 
> > To be clear, what you are doing here is akin to adding more memory to
> > your system when there is a memory leak.  This is not the solution you
> > should be pushing.  Ironically, this is using more memory and performing
> > worse than it should.  At best, the limit increase is a workaround for
> > buggy programs.
> > 
> > At worst, you are enabling bad things to keep happening and normalising
> > poor programming choices.  Please put pressure on the applications that
> > clearly have issues.
> 
> We don't get to prescribe what those applications do. The fact of the matter
> is that there are several high-performance memory allocators in wide use by
> game applications that make heavy internal use of mmap(), and that using
> hundreds of thousands of different memory mappings is well supported on the
> platform those applications were written for. (or mapping regions with
> different permissions, which results in different regions after platform
> translation to Linux happens within Wine)

Thank you for the information on the situation that causes the kernel to
use such a large number of vmas.

The mmap operations will run faster if there are significantly less
vmas.  Having such a large number of objects will cause the faulting of
information into the memory to be slower, and that would hold true for
all platforms.

If this is for high-performance, then it would be unlikely that it was
designed to run with 65,530 objects to search.  It is also odd that
there are several allocators running into the same issue. If I were to
guess, the allocators are trying to bypass the operating systems use of
memory and implement another way of tracking it specific to your usecase
for speed.  It sounds like it is being translated incorrectly and
causing a monster data structure to track it on the kernel side.

If it's a translation layer in wine making a decision on how to
translate a particular set of calls then it could be fixed, or at least
examined for inefficiencies.

Either way, the performance will be sub-optimal on the page fault path
(probably the most common) and any other path that uses such a large
number of vmas.

> 
> Pointing out that there exists one game that doesn't happen to do that is
> not terribly useful for the purpose of this discussion.

I provided the data I could collect reasonably quickly, but the scale of
the difference was the important part of my statement.

> 
> The problem statement seems pretty simple - distributions that want to
> support those usecases out of the box can make that change, like we've done
> for years on SteamOS. On those that don't, users of those applications will
> have to discover and learn to apply the change by hand after having a likely
> sub-par experience trying to get their game up and running.

This number of vmas is indicating an issue with the utilisation of the
virtual memeory areas.  Increasing the limit is allowing the game to
run, but it will not be performant. It is unfortunate that the solution
was to increase the value.

> 
> I've yet to hear a specific downside of making the change other than a real
> concern about DoS of kernel memory in another discussion - it seems to me
> like there is much lower hanging fruit for DoSing a Linux system you have
> shell access to, at the moment.

Poor performance is the downside. The specific downside is the overly
large data structure that the kernel has to navigate on every page fault
or any other vma operation.  This isn't specific to changing the number,
but to the fact that it needed to be changed in the first place.

Is there an upper limit of vmas that you have seen?  Can you provide a
copy of the mappings when you see this for testing?  This works out to a
5 level maple tree.

Thanks,
Liam

