Return-Path: <linux-kernel+bounces-60909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28785850ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB201C20D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E585D484;
	Sun, 11 Feb 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="iAkIRPou"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F9B43AA0;
	Sun, 11 Feb 2024 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707677237; cv=fail; b=i/HDfMDqR1YVDqnDI5bbK37ZsWT+L+2C+Zd6v8CdH1+6fRbTKeeUrR5sSYvm3+a99TuP2oA3rV7ZkgSjTpuxBoxEnEbGgBPWBC5P2akVMbgtUeOS1EecP67tlP8nwb1f3E5pzXRqJeti7qA4tL/keThPYxxr1pQZ+snwMPGChMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707677237; c=relaxed/simple;
	bh=535F77+XaVU2WxuxUgkpIUxr/9i3e8g63L9+TPPeg0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvj7vq+Sjj7/pcSMYi9ma9BT5jpHH4H50TdcWVEbFuJYUMPMlvRpqB/N86eeRBF6VcMvquM56hKr7hGW7qwH574LkiizzetGuHTX4oqPoDlFhNhg+++zJIVUumvboJ0BHmvmGjyg2JxymI2IrQ9Mx1cH1tXyjAryB9vei0K6Rvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=iAkIRPou; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41BIhiM3011425;
	Sun, 11 Feb 2024 10:46:49 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkaepq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Feb 2024 10:46:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZHMgFWdohsZWoHf6W+32WksKUhRNOXhHahugD3O/+7OgC6IEm2GY4q/Ydso5xZGlkQNnCGCCoZTK14EySZIk0z/Tkn4/NdmK8BSbGOtqKsyQGQ8t7grcJ3IxU1NFH6nLBwBFproIxQv715p3axCekeyzP7/hqiBXMzqvnZ71gsqSpzraUP+5mHXMXdBN7MIFfzdSjORGyRXqjMeOswbhbsB+1mNr/yDanX5JaSVH4jd2ZvuTXtjl0thfNBItZSZ9fhDMbws80a2OrcS5zoZ0qO+Lz4UNId5rlQBTuFGFr+afr0Tl2kkgckNrIwWzUqQQXiiH0MwFdgerxAkrYAvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLRj7LPusVL/uX95zwD40uk8GRHd9Bfg5pwGAXhbvRo=;
 b=gYxpE92+HRB4hkRd2yUdG6mwNhfZ49mXhecu4KOuzDxYeNDOeRc50r8M54bPztH3ILD4Me26QCVCdlIDeLvHdZLryQPcC5AqJ8XDXkwESklFRAS8XqPkY+qQKnpEj0bzZ8RFcdkPgdUjC/QfwlwNQ5RTRDgT5gD4gKPiKLgKW9xhdMUeqeIOWkvfeyhO5q5T23IPKbOmbmBd3B3w2AmOATfHGeIctqHVv15MZ9RlXnYqrcxEU05G5oaSB3Vnn1HIipOq6Q8gSpnRBcS9p5d1sFIIobLfBLfNlYLAZZB+drYdk9quI5Epx3UsgmGa3STQrNlcFVnFVcoZcetRm6NzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLRj7LPusVL/uX95zwD40uk8GRHd9Bfg5pwGAXhbvRo=;
 b=iAkIRPouj6WhHjxYu3YRglgURjMrBPhD+lAZT25JHQaxW9PmKrRTyvYvgeE5NwRz4ENuA2thvklx6iryv7gnPO5pxN6QxdIB0HOv+r3KpR0HS84Otzg1a+5ULnniKpqLxNZrs6ev+dT55jfntkNw+U1FNGYNRqF43cBa3XPjulw=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by BN9PR18MB4249.namprd18.prod.outlook.com (2603:10b6:408:11a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sun, 11 Feb
 2024 18:46:41 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00%4]) with mapi id 15.20.7270.033; Sun, 11 Feb 2024
 18:46:41 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Naveen
 Mamindlapalli <naveenm@marvell.com>,
        "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation for NPC
 transmit rules
Thread-Topic: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation for NPC
 transmit rules
Thread-Index: AQHaXRlApo3qAicmJUy+rFKKud0sSrEFerrg
Date: Sun, 11 Feb 2024 18:46:40 +0000
Message-ID: 
 <CO1PR18MB466623157B4EE9B2C04119E4A1492@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <1707676587-12711-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1707676587-12711-1-git-send-email-sbhatta@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2JoYXR0YVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWUyZGMzYjI1LWM5MGQtMTFlZS05Yzc0LWJjZjE3?=
 =?us-ascii?Q?MTIxOGI3YVxhbWUtdGVzdFxlMmRjM2IyNy1jOTBkLTExZWUtOWM3NC1iY2Yx?=
 =?us-ascii?Q?NzEyMThiN2Fib2R5LnR4dCIgc3o9IjcwNDYiIHQ9IjEzMzUyMTUwNzk4MzA3?=
 =?us-ascii?Q?NjM4NyIgaD0iMnNMcHVUNWtrQnFkcmJjNE1TMXZycVZpRzNvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFB?=
 =?us-ascii?Q?anJEU2xHbDNhQVRzQnNmZGIyeXFzT3dHeDkxdmJLcXdaQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBM2c4QUFEb0dBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUE5UmVuTHdDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFEd0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBVUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQU9nWUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUFBQUFhQmdBQUdRQUFBQmdB?=
x-dg-reffive: 
 =?us-ascii?Q?QUFBQUFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFBQUFBQVl3QjFB?=
 =?us-ascii?Q?SE1BZEFCdkFHMEFYd0J3QUdVQWNnQnpBRzhBYmdBQUFDNEFBQUFBQUFBQVl3?=
 =?us-ascii?Q?QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VBYmdCMUFHMEFZZ0JsQUhJ?=
 =?us-ascii?Q?QUFBQXdBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0Jr?=
 =?us-ascii?Q?QUdFQWN3Qm9BRjhBZGdBd0FESUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFi?=
 =?us-ascii?Q?d0J0QUY4QWN3QnpBRzRBWHdCckFHVUFlUUIzQUc4QWNnQmtBSE1BQUFBK0FB?=
 =?us-ascii?Q?QUFBQUFBQUdNQWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnVBRzhBWkFC?=
 =?us-ascii?Q?bEFHd0FhUUJ0QUdrQWRBQmxBSElBWHdCMkFEQUFNZ0FBQURJQUFBQUFBQUFB?=
 =?us-ascii?Q?WXdCMUFITUFkQUJ2QUcwQVh3QnpBSE1BYmdCZkFITUFjQUJoQUdNQVpRQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFQZ0FBQUFBQUFBQmtBR3dBY0FCZkFITUFhd0I1QUhBQVpR?=
 =?us-ascii?Q?QmZBR01BYUFCaEFIUUFYd0J0QUdVQWN3QnpBR0VBWndCbEFGOEFkZ0F3QURJ?=
 =?us-ascii?Q?QUFBQTJBQUFBQUFBQUFHUUFiQUJ3QUY4QWN3QnNBR0VBWXdCckFGOEFZd0Jv?=
 =?us-ascii?Q?QUdFQWRBQmZBRzBBWlFCekFITUFZUUJuQUdVQUFBQTRBQUFBQUFBQUFHUUFi?=
 =?us-ascii?Q?QUJ3QUY4QWRBQmxBR0VBYlFCekFGOEFid0J1QUdVQVpBQnlBR2tBZGdCbEFG?=
 =?us-ascii?Q?OEFaZ0JwQUd3QVpRQUFBQ1FBQUFBUEFBQUFaUUJ0QUdFQWFRQnNBRjhBWVFC?=
 =?us-ascii?Q?a0FHUUFjZ0JsQUhNQWN3QUFBRmdBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dB?=
 =?us-ascii?Q?WHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QVl3QnZB?=
 =?us-ascii?Q?RzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dBWHdCaEFHd0Fid0J1QUdVQUFB?=
 =?us-ascii?Q?QlVBQUFBQUFBQUFHMEFZUUJ5QUhZQVpRQnNBRjhBY0FCeUFHOEFhZ0JsQUdN?=
 =?us-ascii?Q?QWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpBSFFBY2dCcEFHTUFkQUJs?=
 =?us-ascii?Q?QUdRQVh3QmhBR3dBYndCdUFHVUFBQUJhQUFBQUFBQUFBRzBBWVFCeUFIWUFa?=
 =?us-ascii?Q?UUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFI?=
 =?us-ascii?Q?SUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0JvQUdVQWVBQmpBRzhBWkFC?=
 =?us-ascii?Q?bEFITUFBQUFnQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QmhBSElB?=
 =?us-ascii?Q?YlFBQUFDWUFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUdjQWJ3QnZB?=
 =?us-ascii?Q?R2NBYkFCbEFBQUFOQUFBQUFBQUFBQnRBR0VB?=
x-dg-refsix: 
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUdNQWJ3QmtB?=
 =?us-ascii?Q?R1VBY3dBQUFENEFBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNn?=
 =?us-ascii?Q?QnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FHa0FZd0IwQUFB?=
 =?us-ascii?Q?QVhnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFHOEFhZ0Js?=
 =?us-ascii?Q?QUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFCa0FHVUFi?=
 =?us-ascii?Q?Z0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBR3dBQUFBQUFB?=
 =?us-ascii?Q?QUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdC?=
 =?us-ascii?Q?dUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0QWRBQnBBR0VB?=
 =?us-ascii?Q?YkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0JoQUhJQWJRQUFB?=
 =?us-ascii?Q?SElBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2QUdvQVpR?=
 =?us-ascii?Q?QmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QmpBRzhBYmdCbUFHa0FaQUJsQUc0?=
 =?us-ascii?Q?QWRBQnBBR0VBYkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFYd0Ju?=
 =?us-ascii?Q?QUc4QWJ3Qm5BR3dBWlFBQUFGb0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFH?=
 =?us-ascii?Q?VUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFB?=
 =?us-ascii?Q?QUFHZ0FBQUFBQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29B?=
 =?us-ascii?Q?WlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCeUFHVUFjd0IwQUhJQWFRQmpB?=
 =?us-ascii?Q?SFFBWlFCa0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHOEFjZ0JmQUdFQWNn?=
 =?us-ascii?Q?QnRBQUFBS2dBQUFBQUFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFkQUJsQUhJ?=
 =?us-ascii?Q?QWJRQnBBRzRBZFFCekFBQUFJZ0FBQUFVQUFBQnRBR0VBY2dCMkFHVUFiQUJz?=
 =?us-ascii?Q?QUY4QWR3QnZBSElBWkFBQUFBPT0iLz48L21ldGE+?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|BN9PR18MB4249:EE_
x-ms-office365-filtering-correlation-id: d3f81fe9-35e5-48c6-cf16-08dc2b31c950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8b3G7VLr4jlZ4Ja0fXk7cnwF8txI+pj1FpYEpM/ExXqGMrOW8vP01p1e5dVWAhwwabYo6/tLFDtA3B274XXFeCXgExRPQVvYgw4C0U8Ogg2QOu11/Im+kVfM7JM4qg1RHnE5aWHpxmgIVaZ0BLlJMpUDpMzUs9ebcJANbQQblRpNZ7Nkwcbg0sG/U+Jm9ChrbMncMSNdww3GpifXx6+V49et8uNMQquKgYDPwModBemLLMi16WWk//pqbKPBq/3QohSnteWrmDqrbukXYbLpfZWIQiz76AMkRERhdeNJIE/kXR2OvfXOBBR+gfXnhCrhtVf7urKi0a4gDDm3AtRHe3CP63SRkhi+of8Km2kLLYs6eGvj/yFvcHqdiGUKhGJuL5F+iYk7Qnr4ZGc7/8kQcq/I9zGjq3yjX4ypk41sxDPfaGcC8abppdOXWcVVH82AfIiIwDIrY+NyoENSnWokipZsAK5/ZUcEI7XSojWVdR+nBVbo1ue8i+q/xhrBh/ezQTzsFc0w7kNOOt2zB4TERM51bpcAscg8a/7l8gL+0cY5jmJykp8depcpXn+D3hOTMlynffwJLdYraFbDe0+xkoUXBBPhw5ai4yt0weWaSNA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(38070700009)(6506007)(9686003)(7696005)(33656002)(2906002)(86362001)(66946007)(76116006)(5660300002)(122000001)(38100700002)(66556008)(478600001)(71200400001)(54906003)(55236004)(110136005)(316002)(83380400001)(64756008)(66446008)(66476007)(4326008)(52536014)(26005)(8676002)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KOwnhDJcXIK4k3Wt5JxYg68OISMRWiWm6660Eqz+oi6GQq/EwQ3IVqV+ARbs?=
 =?us-ascii?Q?Am+ugGu17hBUrUFofrT9jwI1h2SpwoscVr3+q1gT1iAZjO08xHSCXXxtVixk?=
 =?us-ascii?Q?3qoVw1Q2iJMjdpxtrRxpZHeXqwtgdTH7V5KCFpph3niMZCelZIn5LBdFZfeC?=
 =?us-ascii?Q?azBl4SbqFwTvx+pAlCnu3hsSa9uA/FureZWGZd9BI04nyn9Bagw95eeV8i0v?=
 =?us-ascii?Q?HqoMtJ5S7daOzT0Wx7TofFCYXunbJZQ+R8MNb+RUlShWhGidpTKcRJ3AuL2Z?=
 =?us-ascii?Q?GuoK6q8wukuKt0Um6ZCAPc2NCvNYJybrKsZzaLubdaXYHJeLo8f9uirzgXnW?=
 =?us-ascii?Q?UkgmFXtsYZA8LC/OgVWjmbZ8h4FIix/LMQJZ/t7TJUp1kbD8wgtinSuTuZLd?=
 =?us-ascii?Q?I6UdRLCw36dibG0t5+VOBoi2GS4dw7EhMHcaVDES8Y2Ow1CeeEqBgCoz+zis?=
 =?us-ascii?Q?nCljfpearC1+D6ulZEJuB5bG9/yForhaxeVvsIvcutJqsCFp6Sqvv1tHhds+?=
 =?us-ascii?Q?Satmurfl/U8Il0JGSQn+58qlUKBq8gG+HacpEugktzlS+fz71GcRFnHNAZHe?=
 =?us-ascii?Q?HTpSPqTUZKhn+0HlQscTM1AmthQo4OGvCIuaIn/HYINUNl0SdkfmnCrWuFEW?=
 =?us-ascii?Q?GNbZYs/q2pb3Lex8xMTd66d44CFD5bh6+j0WdAEKBseAEmAaT87GhvGGX1MN?=
 =?us-ascii?Q?vg44pfLzuv7it03LwvORuizuO9FqbhqcGardzmNdeRWNaOjpiJE2oTMTJ6H9?=
 =?us-ascii?Q?vLaPiNuezAuaFYc1X0Bln09/FoP7dbJRWdu3kvGsXCpiadHdBL6KFOEIhmUB?=
 =?us-ascii?Q?DyCY/jMR5i99+BEM+oJ1527i+NodRcdNxlHa9o8KiuNmiaODctxqYFbxrxNa?=
 =?us-ascii?Q?H+ZRM4ogHSFDFIMR/4Bw22c/sULJaGwO6BKJE8DhBXIydLETvnWUdDMokArM?=
 =?us-ascii?Q?XhqVgKn3nT0/KD00nKSR7+KiJcE9HlPtvL7L8TkHpZ2lMhcJ1zaU9dOYzSrn?=
 =?us-ascii?Q?ECLs+NZBtgnCDF32m2jtPWpX++D4cX7pwEhadNMPB9J562A00obTojBxOKd5?=
 =?us-ascii?Q?XnEBhXcW2mQ9QQvDdYzBIXridCqqE1bbOts4QpzoZP3Mx/pUZy1UA7LgVdEN?=
 =?us-ascii?Q?lR3iXdp6iekOaQ3GghUk1UmWZu5jEARsVWibetgUXlGr/N+zxOhW/uhBIkzQ?=
 =?us-ascii?Q?iLcAocf4PoidOYgpViEVEDb3PUxIt0e23tio9x/ugRQzW3TMznLyIqxXa5hU?=
 =?us-ascii?Q?uSP5y5YGmvedHYg3dn+XT860CdGES+pjS+5uIiSe7j69LHgDc3me3/CqB2mL?=
 =?us-ascii?Q?Y8RuEg0qyguiEKawtNP0XkLxw1u5w+vzIJ7dmwH9tM/dNCohFqu/iCUO6g2i?=
 =?us-ascii?Q?fZ4vtFhU8iTUEeZPHEtvmD7ZLk1Dmn83BSz1j5FsbbOzj0asJI4/1GuI+a4E?=
 =?us-ascii?Q?0qC5P3QIzZSMBq0U6A7KFzT+jMY96IrqUf4dSFmTO3BcXtddNlrkza4XpNVB?=
 =?us-ascii?Q?DOSaM79s3f+EsmG06UzBpbAnnNAvGSCndDC+nnuCUW+0VrJETlIM7M28hOoK?=
 =?us-ascii?Q?J58TzzAJgAE3RTV9hB8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4666.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f81fe9-35e5-48c6-cf16-08dc2b31c950
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2024 18:46:41.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+kNo7DeU09d3jUx5TWhrqQbxyM75nV8EUj+B9i2705U4A1r720d891zkeMbFq8xU06mGD/KXo0OrW3GIZTuNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4249
X-Proofpoint-ORIG-GUID: 6bTZN9s99v44a1sAQItQoU-wvBxYFLnj
X-Proofpoint-GUID: 6bTZN9s99v44a1sAQItQoU-wvBxYFLnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-11_17,2024-02-08_01,2023-05-22_02

Hi,

Please ignore this patch. My bad this is single patch but sent as 1/2.

Thanks,
Sundeep

>-----Original Message-----
>From: Subbaraya Sundeep <sbhatta@marvell.com>
>Sent: Monday, February 12, 2024 12:06 AM
>To: netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>pabeni@redhat.com; Sunil Kovvuri Goutham <sgoutham@marvell.com>; Linu
>Cherian <lcherian@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; Naveen Mamindlapalli
><naveenm@marvell.com>; horms@kernel.org; Subbaraya Sundeep Bhatta
><sbhatta@marvell.com>
>Subject: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation for NPC
>transmit rules
>
>NPC transmit side mcam rules can use the pcifunc of transmitting
>device for mcam lookup. The commit 18603683d766 ("octeontx2-af: Remove
>channel verification while installing MCAM rules") removed the receive
>side channel verification to save hardware MCAM filters while switching
>packets across interfaces but missed removing transmit side checks.
>This patch removes transmit side rules validation.
>
>Fixes: 18603683d766 ("octeontx2-af: Remove channel verification while inst=
alling
>MCAM rules")
>Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
>---
> .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    | 32 -----------------=
-----
> 1 file changed, 32 deletions(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>index 8cfd74a..e5d6156 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
>@@ -61,28 +61,6 @@ int rvu_npc_get_tx_nibble_cfg(struct rvu *rvu, u64
>nibble_ena)
> 	return 0;
> }
>
>-static int npc_mcam_verify_pf_func(struct rvu *rvu,
>-				   struct mcam_entry *entry_data, u8 intf,
>-				   u16 pcifunc)
>-{
>-	u16 pf_func, pf_func_mask;
>-
>-	if (is_npc_intf_rx(intf))
>-		return 0;
>-
>-	pf_func_mask =3D (entry_data->kw_mask[0] >> 32) &
>-		NPC_KEX_PF_FUNC_MASK;
>-	pf_func =3D (entry_data->kw[0] >> 32) & NPC_KEX_PF_FUNC_MASK;
>-
>-	pf_func =3D be16_to_cpu((__force __be16)pf_func);
>-	if (pf_func_mask !=3D NPC_KEX_PF_FUNC_MASK ||
>-	    ((pf_func & ~RVU_PFVF_FUNC_MASK) !=3D
>-	     (pcifunc & ~RVU_PFVF_FUNC_MASK)))
>-		return -EINVAL;
>-
>-	return 0;
>-}
>-
> void rvu_npc_set_pkind(struct rvu *rvu, int pkind, struct rvu_pfvf *pfvf)
> {
> 	int blkaddr;
>@@ -2851,12 +2829,6 @@ int rvu_mbox_handler_npc_mcam_write_entry(struct
>rvu *rvu,
> 	else
> 		nix_intf =3D pfvf->nix_rx_intf;
>
>-	if (!is_pffunc_af(pcifunc) &&
>-	    npc_mcam_verify_pf_func(rvu, &req->entry_data, req->intf, pcifunc)) =
{
>-		rc =3D NPC_MCAM_INVALID_REQ;
>-		goto exit;
>-	}
>-
> 	/* For AF installed rules, the nix_intf should be set to target NIX */
> 	if (is_pffunc_af(req->hdr.pcifunc))
> 		nix_intf =3D req->intf;
>@@ -3208,10 +3180,6 @@ int
>rvu_mbox_handler_npc_mcam_alloc_and_write_entry(struct rvu *rvu,
> 	if (!is_npc_interface_valid(rvu, req->intf))
> 		return NPC_MCAM_INVALID_REQ;
>
>-	if (npc_mcam_verify_pf_func(rvu, &req->entry_data, req->intf,
>-				    req->hdr.pcifunc))
>-		return NPC_MCAM_INVALID_REQ;
>-
> 	/* Try to allocate a MCAM entry */
> 	entry_req.hdr.pcifunc =3D req->hdr.pcifunc;
> 	entry_req.contig =3D true;
>--
>2.7.4


