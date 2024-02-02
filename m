Return-Path: <linux-kernel+bounces-49226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ADB846763
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C64C1C25601
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6592E1754A;
	Fri,  2 Feb 2024 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="RqKRiSSi"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2792117748;
	Fri,  2 Feb 2024 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850099; cv=fail; b=ATCzhACokYpPiyOOi6GAQMIsB/sRzJDYE7sFk5kwPrMlgMQSifaZw2D3ajs7fgYW1+74Xdj7YRY2DpyrSf0HHlrH6HYFGvGeLGNBP380rZCCle0acTwuUAzI0orM262GCpnwLpQgCYJbnxav3yVLxUX/OpIo03bEw6zKr0sBydo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850099; c=relaxed/simple;
	bh=h9f3gfVOecegmB3w/aRpKhrb7cSy1FX/c8xp+NqSywE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L9dfL8iMgW9IpRxD6QCUn6dR4IHpCos7wrtz5MNZlFkxMdfZDA3hjb2zrgMqN0uWOdSXvhST3KUGSmW/FVoEIsXO64dFhzD3SXoN/dcpbYApKdlfvPxiRIFt0gJ3J/q9ezw5usnnfAG2FROdOwRPMpuuDpPbV5EcNQFXyuYj3Ro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=RqKRiSSi; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121WNiq011534;
	Thu, 1 Feb 2024 21:01:26 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w0ptngfw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 21:01:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlhA99GjeGI32xaIsAVPEabN7j3f3WRYmdmeUzGfmq9Q4kcK0E3yIq6+sQx5k+ld7dj7PeHcQRnzQKZkoHPuVzSluhetLvE1B1rXKaLrLr0yK9yhseznYKosgcT+ubppJND51z2pnQZ4JN2pVJSVkDhxBz6NTPVtedXvXX5GtJytSQv6JcUQ7PIRgk1D7d5eISUXy+2PEqC0mIRty8YiCBzV4E9eGBRP+c0onf4B49qssaoEbRi42ExcvMrIwwW0MAvliztHWU6BnAK+IouG9LiYFyNr/t6bXy2v+i3bs3ks+mhxQSrMcLAloK8F7Uubabhnk49LsFCVI7O+6o0YOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbmOPLjUamERy4je+L6z63qL0bi8VO5dJynKIc1bH48=;
 b=niVhnD9k683G4VapvlHI8aywbVM2QpvjVcQc8aOL9GL3kqcUvwUz6NLsgzeWbOhUKs/5qWg2s4P1N18ocoAaTkjF7A/l2rDbvJy6ZTlrB09sH0aY6F5aYrZsfjZW7XKrdvtjpzHcW72V9s20i2du4LZRBee7oBk5Tepr/64nqIMxebrf/zBmD3SvI7hH2RVi2XUJ7N2z8KcOzwkDQ4C0pjYxkPMt2/hg4gv+VVluRPE/ZEC0IFExFAUXdLo5oK/WSxO7henCYNe98M4vSKYxLmoVUoz+3aNTArbkbAouzwrWhDN5EImfyYdW0xDkerRXBv3q9j3VH6XVNeYbkft2hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbmOPLjUamERy4je+L6z63qL0bi8VO5dJynKIc1bH48=;
 b=RqKRiSSi4q5SOmslullweXWAO0XLfpUD4wlSVM2sWYL9oLy6vEg2zmmAwz4w90OTsX6ZxFNhWXzEt9hnZhkuyAiXJXPDj3EgC9HDdVWzabFJlGweZunOiw31rIo1oePwY/odYUglme9e0VpaLRvO6MvRvsfErhpoi1/CuG9uchk=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by BY1PR18MB5924.namprd18.prod.outlook.com (2603:10b6:a03:4b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Fri, 2 Feb
 2024 05:01:20 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00%4]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 05:01:20 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Zhipeng Lu <alexious@zju.edu.cn>
CC: Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesse Brandeburg
	<jesse.brandeburg@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
Thread-Topic: [EXT] [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
Thread-Index: AQHaVQzY6NkC3X8CSUm1KvCfvoOgY7D2f3/A
Date: Fri, 2 Feb 2024 05:01:20 +0000
Message-ID: 
 <CO1PR18MB4666BB2DF72E4E463CEC9F77A1422@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <20240201124714.3053525-1-alexious@zju.edu.cn>
In-Reply-To: <20240201124714.3053525-1-alexious@zju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2JoYXR0YVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTE4NmMxZjU5LWMxODgtMTFlZS05Yzc0LWJjZjE3?=
 =?us-ascii?Q?MTIxOGI3YVxhbWUtdGVzdFwxODZjMWY1Yi1jMTg4LTExZWUtOWM3NC1iY2Yx?=
 =?us-ascii?Q?NzEyMThiN2Fib2R5LnR4dCIgc3o9IjQ2MjgiIHQ9IjEzMzUxMzIzNjc3NDY3?=
 =?us-ascii?Q?NzEwNCIgaD0icmVEaWZMVVFOaGxVNEhYbUJGL1EydTlqYW5NPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQmdXQUFC?=
 =?us-ascii?Q?d2FzVGFsRlhhQVhvQUY3NDI5ZGRsZWdBWHZqYjExMlVaQUFBQUFBQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBd0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFZUUJrQUdRQWNnQmxBSE1BY3dBQUFDUUFBQUFEQUFBQVl3QjFB?=
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
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|BY1PR18MB5924:EE_
x-ms-office365-filtering-correlation-id: 26d2dea9-6183-41d5-a74a-08dc23abff14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LbwteK+guotm+dWu8Smow6okbcHYZMFVzkaLD5GiUS+AtAGkEbU+Ld3clsbkIJFRvlRnL0USj+EFMmK8u1+/sm+aVNONguaynSBEbyW6kX+sJwgHv5f5SNWFL+630FLHYeyxCNBqMm5oofvip7YNsdkgegjxRstVNMfkWnC8NNH5ZeYeTw2u6TvoT6yT6GF8o0C9eMy6A+0cr6Nq+5eWuXl1LloNIe0pRyZ16wIamJDgJQYlfXh0QqBkeW/MbiPeweC3eL/Z/5+d1KsWgKzKYVFHy5C3cHCg1khkobmzzEr/t+RJZYzzWv8HLdADyfdvgaZbsmrlO/n3QUwftnsa/og6FDBQrdiCaR+BjxOru1vbXzlKMUph/k2ijr2g2NYsNyb/ZhT0mzUKEWrKeZnDV3UKTZZsua6H1aE2yAKQbexx9jozu2jVvfpEKtlDogf2fOsAP2L4xX7bdAauloEjFzeT/H446p9OSVEsbAElQpsCDM9xFhpsGI+XxwomPjuyR8If+00R6lpg84EE8mum/x4Bv5I1qZC0yt09XwWjnbQ8wyHxwNRodOMGfLUWGM91UHo3QZ+X2BGQsu6kpfbRWo2T2TzMLzxh4BTcsMtrWiGOF3dlcB7NsBIf1B3srQ4YJz/Bxm3Wg5z0tmUh0+cPqaR3txm4/XOBxIb4BdfbTy0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(86362001)(66946007)(66556008)(33656002)(8676002)(54906003)(8936002)(52536014)(5660300002)(4326008)(2906002)(66476007)(316002)(66446008)(64756008)(76116006)(6916009)(38070700009)(38100700002)(71200400001)(83380400001)(122000001)(55236004)(7696005)(6506007)(9686003)(478600001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Xx8Y1BQX0qFh3gHS0pmiAR4NrurC8cDfkOhUNvIY7gduWhp8komdgdVEd5vE?=
 =?us-ascii?Q?jqlwb+orxV7oOHOpw86uoQGzMRuHrLMAIG+X6SfuBHXyKyvXTcZp8R2pjn1S?=
 =?us-ascii?Q?en1cj2EF0hIR68A9Ve/3K+u6eXO600tN/soqFKbxXYhjo2qy2mOfQpnkKWqf?=
 =?us-ascii?Q?05YqQyn94SnguHU8wrNsUQfpoAKBqdRtafbLhxqM/gnNra3dpLLsBT+Yo47S?=
 =?us-ascii?Q?Np48HqdSiOR++SN9loRHobDl9ceoYDpWiOL7ZVjQTr6YPYr0sVMa019/XUQd?=
 =?us-ascii?Q?AngibchlECCmheYlXYcVqnH3sgtYqoEfqJZm00g4EqsjLaM2U3NiHe9kqcYX?=
 =?us-ascii?Q?/X4SWlDkOZl1RMOYYsxQ/TRNFFo0NnwAytn8W2MEDXPhrrgN6wHsRBDiW7Qx?=
 =?us-ascii?Q?i9B15m4nD602ylk+yinhQiOYOIv6QwuMld2GA980XoC69dGogX4FMakuIq/Y?=
 =?us-ascii?Q?7yZWAQ+0HjLPnrKEyFXViu+TmlQxkE5Jx5J1Ne4T7OlRtbyqkKAI43Jh5rSY?=
 =?us-ascii?Q?M/vpHZhD/vRiOhr+mO3pKu7+v+/d2CnbIbj21IXyH9c6xJL0Dzi5lRJEcRMx?=
 =?us-ascii?Q?m8ge/cas10s1gX/yRyklik43U8SDfPq4QDq4BIEAW9fYsFek3AYTu+vuH8zB?=
 =?us-ascii?Q?XKpoLql9YVm2fWeCU/0RdXDSvBBMbH6Xy4RaMiRV6Z91oJ+I1pr+C07/4F5o?=
 =?us-ascii?Q?tvw+4ihDMlnjLWTHR5W/IRe1b8wcbAxusS/vmGnsGGU6FfkoHw8kTViwyRdf?=
 =?us-ascii?Q?l8gO774/mOm+9+ooibeNmglS9Dn6FBMRoQBXawiQ+9zJTsEvpJCDQOaFhSjL?=
 =?us-ascii?Q?6PyrH/G74FAXApMDlCTggYNmfN8sJy+uV1WaURtFULcyxx4ygOgh0oodPzSl?=
 =?us-ascii?Q?VbQHRfpyqL2oVAWXwqaEcpetZvo4sgX3l6RNZnDdFhwy7h0IQKT3YjpPjLZA?=
 =?us-ascii?Q?DoIB9FjJPb463dbXEJWv+gPlYG+RNAukWGjw3QeNq7xnIk/ffHi3XbGhU6on?=
 =?us-ascii?Q?X3ZTL0kYj4xhIsV+OLwJezwftMGHMmknobvRwwqYFTFr33E8XTyaIy4jpJ+V?=
 =?us-ascii?Q?u7kjvUKnj5U9at0mEIVuPRmmlFDwpIpN74qRIq3WWLkwQcexr3H7RT2dpg/t?=
 =?us-ascii?Q?GJh3VaiCuThvOZeJHRkaWWRGuGpzB3naLcARX+Homa5/rjQqJhWNCnHu2GY4?=
 =?us-ascii?Q?N7mZ+tz3jqruu99GRqifBPJwsCvKNjGmpCaxll+goUwVBVW9taA/6szailUl?=
 =?us-ascii?Q?Xqi/XeKXhAeHzJNufOz9lPmfPe4PZeh+DVl3qhJLyHZyUsXB3M6RsLbtrtJj?=
 =?us-ascii?Q?biNt6RChaSnAXxsZ+mD3/PjQq5OV4YN++oBl/dFj7dJVG+N1YofOEt1Qsg8t?=
 =?us-ascii?Q?Zl94kddOEZGWi9b4s70B3hX/A6u02okgsS4fD41Tbf4WLg3lX66EJjLROOsS?=
 =?us-ascii?Q?aiOq/sEF98qs7JtHgBCKWcsacrO4UdD1FjmmsfL44MWGUXljYAYCuuB5ie6q?=
 =?us-ascii?Q?fzlZZ+/zmsUDmsOa90LGAFHJ+jY5zjBhSytyVuGKgXjLh1+DU58jLEEMbY6p?=
 =?us-ascii?Q?TfdgtAylxKn9vBaCQjfGwUDrHUned76bap9cNwvf?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d2dea9-6183-41d5-a74a-08dc23abff14
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 05:01:20.5658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iybBMR1TdKrPffTqHrxRgDnMlISbdbyORwITsxe7F92hz4/xL3q7NJlgE3sdSLTcmQBC7WNipPBKHZ5zaEUprQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR18MB5924
X-Proofpoint-ORIG-GUID: 5pwnFBbWrl8xYSl_bWiPlMv3dODhnLky
X-Proofpoint-GUID: 5pwnFBbWrl8xYSl_bWiPlMv3dODhnLky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02

Looks good to me.

Thanks,
Sundeep

>-----Original Message-----
>From: Zhipeng Lu <alexious@zju.edu.cn>
>Sent: Thursday, February 1, 2024 6:17 PM
>To: alexious@zju.edu.cn
>Cc: Sunil Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
><gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
>Hariprasad Kelam <hkelam@marvell.com>; David S. Miller
><davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski
><kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Jesse Brandeburg
><jesse.brandeburg@intel.com>; Richard Cochran <richardcochran@gmail.com>;
>netdev@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [EXT] [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
>
>External Email
>
>----------------------------------------------------------------------
>When qmem_alloc and pfvf->hw_ops->sq_aq_init fails, sq->sg should be freed=
 to
>prevent memleak.
>
>Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
>Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
>---
> .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>index 7ca6941ea0b9..02d0b707aea5 100644
>--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
>@@ -951,8 +951,11 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16
>sqb_aura)
> 	if (pfvf->ptp && qidx < pfvf->hw.tx_queues) {
> 		err =3D qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
> 				 sizeof(*sq->timestamps));
>-		if (err)
>+		if (err) {
>+			kfree(sq->sg);
>+			sq->sg =3D NULL;
> 			return err;
>+		}
> 	}
>
> 	sq->head =3D 0;
>@@ -968,7 +971,14 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16
>sqb_aura)
> 	sq->stats.bytes =3D 0;
> 	sq->stats.pkts =3D 0;
>
>-	return pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
>+	err =3D pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
>+	if (err) {
>+		kfree(sq->sg);
>+		sq->sg =3D NULL;
>+		return err;
>+	}
>+
>+	return 0;
>
> }
>
>--
>2.34.1


