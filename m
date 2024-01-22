Return-Path: <linux-kernel+bounces-32372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F239B835ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750D4283A55
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 06:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A9612B;
	Mon, 22 Jan 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="mhMclLdF"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6656AA1;
	Mon, 22 Jan 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705903352; cv=fail; b=IarCbpDoJsUltOaJBc511rh9WPLnuXqReLHaDK0feOnOUH5oYK20kZZXOMvAQ2uEve60iuOc+dDQTr6nGRR9TtHM0ihv7zOOpfk/2b2A+ofCd3/PlIYqaY5ZRyNeYKKPWKAkNEQqSSDfH0Nbc2XTtuJnauKPSwvICafK0ZrJOGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705903352; c=relaxed/simple;
	bh=tz95/DasosogLa+UZ80GGebLSIBAoWiOuP5BKEiu5Vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6fslSNnawYmLK7ZavWPiFaS8aJMqgDRUAjg5tl70Z8cp2T6+SUkDybAU1ExugvU85Q3xopjj6VurBvti2tNnk6tO7LNS0mDIB9SbeyxFQm1h8883Cj+mltULHRshDpTtNQU0eUyEaSKH1Rg7Dg/2sx0lEGu1NK8y2Or3IhgqQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=mhMclLdF; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M5gKr7007504;
	Sun, 21 Jan 2024 22:02:10 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vsjewr1k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jan 2024 22:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBYh/2qK6y7UxnEFga0vAnXowXQhNqJpE83fuADYPJEW8W0lENilD0omu4pXDKbTVdUcwl/dP/G46CQRBCsusuRVJGudVbUgvaLj6RmDQ1QbHmHDbr6cu4Smxu5r9tWFVMn/kAam+s86DCJBXAyAdCXg+Y+NYAQbX43ng1bexUQGw8m4sRcgsFcKCQbX1V+tjtrqLpVEKWPsNmuIljSJ9UsSKF3BQm7hoBMW8lc6WdcM6MLxQqsLjYY5UqbK15c7Kkn8wZnE0zEZ1X1IW/5Ic1+FieuV6dzmPyuMZPqSl9X3aBX5vN8ncs5QHGwUNiLZe/SnOW1cHxDrXWYhmiimbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHX15nx5er5IX/MrIHnXLimq+7dSJmZzZyebyV7WR3E=;
 b=UwtHTckQD6ZzSI8S0Dp1z/uPLEVUIG8lQIRBkkrXsmanBAB8etNvSeAwLqy5DJQwbK4Q8cdKejipYI8xM2e6S6qmqPOcW0L7JvZjAgzxl/q2op6aN9Bm8OhWINNTq5/R5C3ttGsoSgfw66iwbRTDmrZwAtiWFdZcFxn4M2nsKzqkESMVvnzT2oZPpz/bRcVzEwzwueoQgE/fS+kR7GTMGMmrbkX36flXhnne4UqLSU/B9cE8LEJem1Xnli1nFjAzmDALWtuG6qGIORLDwhXGgb2gk5pAN7KRpT/54vQ3oxsOTF6ni2aMAdPDomzvpHY5YLjcLeH+Lz9sk/SoXF0ZVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHX15nx5er5IX/MrIHnXLimq+7dSJmZzZyebyV7WR3E=;
 b=mhMclLdFEVABmStKg3TtS4IZobNokmQFb+qr6525YbLWr+vQQTM5TYXnTXsoI0cm9yUNMFVtXDOKm9kmwurjI88p9KSvS8Ai6dHKY9ZghBNOSu3AcporXqfBkHs60oK9mUpjTxE72w+F2TREoGsK68kS6j8x9qMpF5YokmgPGbw=
Received: from PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22)
 by LV3PR18MB5706.namprd18.prod.outlook.com (2603:10b6:408:1ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.14; Mon, 22 Jan
 2024 06:02:07 +0000
Received: from PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9]) by PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9%4]) with mapi id 15.20.7228.019; Mon, 22 Jan 2024
 06:02:07 +0000
From: "Jenishkumar Patel [C]" <jpatel2@marvell.com>
To: 'Maxime Chevallier' <maxime.chevallier@bootlin.com>
CC: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antoine Tenart
	<atenart@kernel.org>
Subject: RE: [EXT] Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Topic: [EXT] Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Index: AQHaSoviVtEU90vMIk6A5vQHbYZ71LDhK9iAgAQdgyA=
Date: Mon, 22 Jan 2024 06:02:07 +0000
Message-ID: 
 <PH0PR18MB4543B5E92792ECD5D3683861EC752@PH0PR18MB4543.namprd18.prod.outlook.com>
References: <20240119035914.2595665-1-jpatel2@marvell.com>
 <20240119150451.476d6ba2@device-28.home>
In-Reply-To: <20240119150451.476d6ba2@device-28.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhdGVsMlxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJhMjllMzViXG1zZ3NcbXNnLWMwZGY3NTQyLWI4ZWItMTFlZS1iYTA0LTAwMjI0ODZiYjZhNlxhbWUtdGVzdFxjMGRmNzU0My1iOGViLTExZWUtYmEwNC0wMDIyNDg2YmI2YTZib2R5LnR4dCIgc3o9IjM0NDYiIHQ9IjEzMzUwMzc2OTIxMzQ0MjM0MyIgaD0iVVE2bjlFblFydU1Nems4T0c1Nkp2bUtML29BPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFEUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhB?=
 =?us-ascii?Q?RzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3?=
 =?us-ascii?Q?QnRBR0VBY2dCMkFHVUFiQUJzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1BWHdCakFH?=
 =?us-ascii?Q?OEFiZ0JtQUdrQVpBQmxBRzRBZEFCcEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFC?=
 =?us-ascii?Q?c0FHd0FYd0J2QUhJQVh3QmhBSElBYlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHOEFjZ0Jm?=
 =?us-ascii?Q?QUdjQWJ3QnZBR2NBYkFCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QWNnQmxBSE1BZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dCdEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVlBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4543:EE_|LV3PR18MB5706:EE_
x-ms-office365-filtering-correlation-id: 5081f3fa-aa8d-4d01-2cee-08dc1b0faa38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 4T08cYBVFs60pSSWr2GcoVAAUI85PRMrtrX4FBOY9rwEAgWV4Frx+iQzCSH8BsafNkmqLJjKLWWVfL8spDyFSTE/eYEF7xD4J66o/uqylH0klfQM+8mRlukkrGmtczHMXNKgjQeda2PerEbIzqDvfX48IFJD7UAxw6DbJqx8seeK26v/SN0cDl3blkvadTGwfmDd1izD/ep5drF/Dw2qV1CuApsucwxWM44/KLEAp1mFjOuiwPTItaR5Z3dKKxE3qGYc1yeD6LpG7m6qRaHAbGW2dLiR4endtCNv44pnYkQMXG0Jl5Vsud3hE0ofWTsPJ5zwuKe7jENeYft75ry/8KsRk4apV6Jm8bVmi/BvYTA1ihXSf+3XEIbgJuRuqDrGBtk2RcYa+rKq1nD5rEsnh544T4jLcgI05ajLif4d34x+QZ7dwZIItoFxMtrxEuRYV9hMsAhfK0eQSuZ5zHPgxcg9haeLRmY+9g8YfzrZFZlTA8JHud2fYHXGrTjqV+v0MahScAaOk9svVgCqnJfo6bRpAYYCv3QNN1Mw0BaEpvBIXeco/Gwr/WOal1TlxpW8X5PrFuwNs5c7IKkTSSKobZY0N0oCm1K3r7i1TGvtrB8vsun9vGqEAD7fG/9R7rVfCZnDWOIrkNUlCY4q5tjyLI20P7I6vaTspvtR2QASLUo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4543.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(122000001)(41300700001)(33656002)(86362001)(38100700002)(83380400001)(478600001)(7696005)(6506007)(71200400001)(8676002)(8936002)(4326008)(316002)(6916009)(66556008)(66476007)(76116006)(66946007)(54906003)(64756008)(7416002)(66446008)(2906002)(26005)(9686003)(52536014)(53546011)(5660300002)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jxW/kHsnB4x65JvZtE6HdSxQSLdfcQOotUdQ2nwt6FlGi3uS2OSZCb+UDO8w?=
 =?us-ascii?Q?jsjauFY9a2xSk51yKrlQ+E/sGHOKJYfgGqMaJG9s6gF2x7mMJVeHLJL1rGRm?=
 =?us-ascii?Q?e/9WA6Hlsies6NDBQhpupCdFCYV9j3PS+K/MegqNypVnGVfoHL+0mDdW7wQO?=
 =?us-ascii?Q?z4BcyJl1tAEaWxuXGeq4FHCUUVCag+V55nISBYfGplP8a1Pi69FRq2isFpQt?=
 =?us-ascii?Q?EaKzQ3sHRaCKsD6Q7yfJCklpYb2IJU7N6ht7zAMSquuUTG9wwhy12T51fGlz?=
 =?us-ascii?Q?aRLEKOqIF3JAWry9uR81syv1fkCMgaMd1+Z8a9RlL9HgmQMEMsIW3igUwJPg?=
 =?us-ascii?Q?ScGa9U7MBl5Xaz0qyU/m95ce0Gp2iqmmg1vXq8/k18Eu1zOURZkJ7iPIIP81?=
 =?us-ascii?Q?3kG/ysL5dv8FNfYefkejOXl/GGCER9jeXBxyIge3ZZrd6/1NgN06gT9w7q0H?=
 =?us-ascii?Q?vvxDRsT4mohll81+Nx9p/366ZgoVAPrcL5qNgW/3XxaUG2gw1jojJR84Pa0n?=
 =?us-ascii?Q?5OEtzzFluXQu3Ao7iN+2zH2/6q3Hi77V2ZP5E+EmgJw72MITvcB4i7faQQAd?=
 =?us-ascii?Q?HkHq9usN6cqfEM37w5/19G2uPiwaBrvoHO5C+N60FQFdBGgcZtoHlZj4m/An?=
 =?us-ascii?Q?PZYjLukWQIzeOSHOWv7xW4brdRQC8LvWH4qCcajkn9iZm0YFbX+DgMWo08+m?=
 =?us-ascii?Q?mdTtu+b3s8tVeGBoOtJE1z0jez9O4oDKT2qJdkcOIzSAxyWBSG/JqEuvReRW?=
 =?us-ascii?Q?ETDFd2nc4UWlOy3fkyNLyUizEm8ES3lqDw/tbU4pA+RBl+b7/MQwOfm7J2cF?=
 =?us-ascii?Q?lgy5y20ICfzNgYbDhnAQ2mPeTbFO8Vza2X8uC2ul4CJN6Ebp5+rQZYUicl75?=
 =?us-ascii?Q?klGhdYU9lqJcj71hmaRdCDR/zuSKefpdRWZ20rl8krjlqRexD9GiZ3sK1Dez?=
 =?us-ascii?Q?xKudyBCkuIPkJOZROF7a75hBeaXmFObxiFUG94fXItr6VZL24yp07zRuQDwp?=
 =?us-ascii?Q?EwvfgDrQUiz5I49KaGQmLo+qezfY+vBUQmmNuBW0Yog7a7J4z406ZN20Aa50?=
 =?us-ascii?Q?VAEiXlD/ceqJpVqlBAcqObW/XK7oPPHfwN/WbIOsgMCKz75N8b9XHjSdYyJ9?=
 =?us-ascii?Q?4v80x9Rp0me1T9mt/l/ZK5V+MwzmqYYbQpVRQMuW6IY5visjaFuK9q9qEOQD?=
 =?us-ascii?Q?4vOtb/UPeWaodsYm7/48cVyBQmjmdBal5tlPwb5eXzdcVbJJ+7ct7AnLk7Lp?=
 =?us-ascii?Q?OxB441WjlrzQW/9NPdNSEG+qXRW/BzztSmoqWpD5M9awGrawZrtyLpemUJlo?=
 =?us-ascii?Q?3uvF9mHL0K553vvnOHINzf+Iq63TZsfHnWZ26baPC5eXjj2DZpdNlJ0M8L9Q?=
 =?us-ascii?Q?yVXx8funUu0fu76ypYhYl2BoLSu7w2uOOOGSYd4OzXdTcQjIpz2dQEcmDvct?=
 =?us-ascii?Q?NM4cFYSpstKWjNEOjn6vLzh2dUEci0u9IMbRzPJNPOwa7g3wxHoOCK98cfr9?=
 =?us-ascii?Q?gxUMNfVuHqYyYNiUiAwK/dpT04fTURs/5aok8ykegzhChyjFjdkuKEo6P+hT?=
 =?us-ascii?Q?HfqCGrLKq0d7At8iRMw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4543.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5081f3fa-aa8d-4d01-2cee-08dc1b0faa38
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 06:02:07.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FlamZJvjRVRAXO8w4tXxuusLXVQnuyT9YS3S+nS7vN1Q5GOWm605X9ToAQ9c4x5GC48E6/IrijNS//t3wPh+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB5706
X-Proofpoint-ORIG-GUID: DaEWjW5DGqgNpM16L_6bHMNGiMSYDDUa
X-Proofpoint-GUID: DaEWjW5DGqgNpM16L_6bHMNGiMSYDDUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02



-----Original Message-----
From: Maxime Chevallier <maxime.chevallier@bootlin.com>=20
Sent: Friday, January 19, 2024 7:35 PM
To: Jenishkumar Patel [C] <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com; linux@armlinux.org.uk; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel=
org; linux-kernel@vger.kernel.org; Antoine Tenart <atenart@kernel.org>
Subject: [EXT] Re: [net v4 PATCH 1/1] net: mvpp2: clear BM pool before init=
ialization

External Email

----------------------------------------------------------------------
Hello,

On Thu, 18 Jan 2024 19:59:14 -0800
Jenishkumar Maheshbhai Patel <jpatel2@marvell.com> wrote:

> Register value persist after booting the kernel using kexec which=20
> results in kernel panic. Thus clear the BM pool registers before=20
> initialisation to fix the issue.
>=20
> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375=20
> network unit")
> Signed-off-by: Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
> ---
> v1-v2:
> -Move comments outside the loop
> -remove unrequired brances.
> v2-v3:
> -improve readability
> -correct register read API
> v3-v4:
> -optimize the code
> -improve readability

Thanks for taking the reviews into account, however ...

>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c=20
> b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 820b1fabe297..23adf53c2aa1 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -614,12 +614,38 @@ static void mvpp23_bm_set_8pool_mode(struct mvpp2 *=
priv)
>  	mvpp2_write(priv, MVPP22_BM_POOL_BASE_ADDR_HIGH_REG, val);  }
> =20
> +/* Cleanup pool before actual initialization in the OS */ static void=20
> +mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id) {
> +	unsigned int thread =3D mvpp2_cpu_to_thread(priv, get_cpu());
> +	u32 val;
> +	int i;
> +
> +	/* Drain the BM from all possible residues left by firmware */
> +	for (i =3D 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> +		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));

.. I think you didn't answer Antoine's comment on that loop from the V2, r=
egarding what this does exactly. From the other sites this is used, it seem=
s to perform an allocation from the pool, can you clarify how safe it is to=
 do so here, if for example the BM was never configured by the firmware bef=
orehand and is therefore already in a Stopped state ?

Reading the register provides a pointer to buffer that is already allocated=
 during BM initialization. When multiple reading is done on the register, i=
t will drain all the pointers that are stored by previous firmware. Also re=
ading this register does not perform any allocation as it is only performin=
g register read operation, thus when the BM is not configured earlier then =
it will not lead to any stop state.

And are we not risking any leak if there was something in the pool that we =
don't release ?

The data on the pointer given by register read is written after the read op=
eration is preformed, which means the pointer does not contain any data, th=
us there is no leak.

Thanks,

Maxime


