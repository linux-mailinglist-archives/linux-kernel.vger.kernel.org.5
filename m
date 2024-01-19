Return-Path: <linux-kernel+bounces-30751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AF78323EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887BA1C226A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F61440C;
	Fri, 19 Jan 2024 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="EunUjEtP"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B8186F;
	Fri, 19 Jan 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636714; cv=fail; b=YwWXg/XmkhMRjiFGJG/qua5jcd3JfYc0/R3bXr4ZOdmxNJhqUOtxoBmVdT1igGTAzGuEQXbRj8U3FOEYK3uYDOz7r5bWk3pemWgq7FUCpZDdoGAuDkfi0tUnbgFxRYCXQzY0uUgRTfW2o+VQbMnBGOXFAyD0brURnpL4MJR/Loo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636714; c=relaxed/simple;
	bh=snu06oh451WgdyiQ/wsAjkoOHcMMSxu/dKegOnwJ4J4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mO9RPT+/kdBb/IrGCqhMkMHqItqdZMV5QX5JyPg8w8169x23UsVywvsdhQp6euKiBzw19SttacsuMitwLTR7bAustriiGk2MatexITaIhpdv/5DaF7qDcaw8YT1+ujT+0AzGrTWPaS5zURYwwUTXDxKOUlT66j4oV/kuPiSG82o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=EunUjEtP; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J1lcBL023246;
	Thu, 18 Jan 2024 19:58:07 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vpvex4yt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 19:58:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJte6GNMbC+ht2mQDsBlv3pXj2+PJ+12kafgKdXVrM5xw/Vd8kkO6N56+1DUnjownEQbwLq8AAmV/HBXia+2tBpjL3kwK8V1lHFLPmWPPf/DASQwSCMP8AueYkkij81+fvrhw8qdSDaRTe467nzb0iMkzeuBS2z8dSDDBYnQYJqUDaMSuOK+hcaE9lYj4xemiAb9diY/a3aek+iuUZ7GOzD/xmMvyqWX1YiLLl7Z9f4REsMse9WxwLrnYCihv7cfJ72SUOiNs2eQdJO0BvY3dK8ogvTQc54QhmnBQgXjrF/l0gkRttMgDtDaifph1etPmZ3zsWjxD9sq9ToZQd8vWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWiaoCPb/Gc0mTnWSaXagVXFV1oWjTTD6JigeKrSGKA=;
 b=XcI6jWW7OYdOxLaNcGCauqWZ+5qiSHBx8+NsncKIp1V2rlOrSoVmMb0Y8zFIv3kqq5mXNKzCYN88er11F2OvfsvYxO6oDthurytqCgw9bmhOM+ffGSttbO+5zX9N4r924k72KvVwsmA8jYBAF2EGJfvC1/raLi0tazrtYJN1gJiDIo0EZ6jRX2y2pHHaUHUaKTsrXO3q2Zc+NeXtNKd2GnTXvD4vOjoccVKTSBtOgd4vFDIMbg+BzDTSDqbezdgeRX6hgBhbpNYfnpSVbYJVTlreOd91be59ztZTdEyPGQflX89HBHbD5JT7RF2Hbz1aDHOMVZuz97uJiOxDkwmfaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWiaoCPb/Gc0mTnWSaXagVXFV1oWjTTD6JigeKrSGKA=;
 b=EunUjEtPg1ui3xkiT659ibrMF3bf5AsxBLznetCC+5bzfyxf+fy3tY9ppwKeuU0TwTMT7QNnFCGwhZeiGybAdbkhnKYsDchR/C1CRruONcTq0PtmPUGnc935u17LNkbqyGBpfdsRbxwqHcAfsa/iACZFkBDjMgjt/3XuZgVjlUk=
Received: from PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22)
 by LV8PR18MB5957.namprd18.prod.outlook.com (2603:10b6:408:222::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 03:58:03 +0000
Received: from PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9]) by PH0PR18MB4543.namprd18.prod.outlook.com
 ([fe80::f8e5:bce7:49c8:f0f9%4]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 03:58:03 +0000
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
Subject: RE: [EXT] Re: [net v3 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Topic: [EXT] Re: [net v3 PATCH 1/1] net: mvpp2: clear BM pool before
 initialization
Thread-Index: AQHaSeZrnoahQU656ESI3DHaf/KkdLDfp6uAgADZAKA=
Date: Fri, 19 Jan 2024 03:58:02 +0000
Message-ID: 
 <PH0PR18MB4543D6C769977D513CA3335EEC702@PH0PR18MB4543.namprd18.prod.outlook.com>
References: <20240118081447.3884278-1-jpatel2@marvell.com>
 <20240118155053.6c1bc52a@device-28.home>
In-Reply-To: <20240118155053.6c1bc52a@device-28.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcanBhdGVsMlxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWViNzUxNGNiLWI2N2UtMTFlZS1iYTdmLTAwMjI0?=
 =?us-ascii?Q?ODZiYmYwOFxhbWUtdGVzdFxlYjc1MTRjYy1iNjdlLTExZWUtYmE3Zi0wMDIy?=
 =?us-ascii?Q?NDg2YmJmMDhib2R5LnR4dCIgc3o9IjMyNjkiIHQ9IjEzMzUwMTEwMjc1MTQ0?=
 =?us-ascii?Q?NTUzOSIgaD0idmVaTXRPOFJIWkJ3RWhjVWU0bVBSemNSRkdFPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBQVFPQUFB?=
 =?us-ascii?Q?amNwK3VpMHJhQVVueE5TcDBvakQ3U2ZFMUtuU2lNUHNXQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQ1VEUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFBQkFBQUF2REJPdWdBQUFBQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFEQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
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
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
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
 QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0J5QUdVQWN3QjBBSElBYVFCakFIUUFaUUJrQUY4QWJRQmhBSElBZGdCbEFHd0FiQUJmQUc4QWNnQmZBR0VBY2dCdEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUEiLz48L21ldGE+
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4543:EE_|LV8PR18MB5957:EE_
x-ms-office365-filtering-correlation-id: 7123943a-c83d-47c2-9f8d-08dc18a2d5ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 KzBKrtb0nVqrppM/uJUCX8h7eC0ANgAiC+AzHVNJ928zKwZFmXsgpE90k+OSTT6e6Jac5i9S68zvp7ivMI0f69KAMZWYpANmmR+Vq3RtInCBhYGNPR/avEoQYHUkfWuJhcGJJ+P7b5nbu/tpvAI4vLu27MaEv2d40mpWIVNjBBTDjAKE4Jt1lyiWQiiQZ+vEs33ZEmTkUKuFV4wJqog43f5v+7WvxB5ZcYQCY6zf5Skar8beVU8FJnttx0P3gTZeL6AlhHa6Oo2vPTvOkbM4h3js00vRsheBfrgE2FISWDY/AhMSmr++tQS/RIJlHMrcu33pXbLDb7BvI2+48FuJUsCqS6RzM5pHPvIT/obqrtPsRcl7FBRYFsr6zH7bgy0AeSuXu42wE08vLs/HYre2adlXI2kvJlawBBzOCpjz8MH76cm9Ls8pjg18SBSsmuo6B0+Y41C+4kN8c9FcNE/5mned8nwlH4x63fx9pd32Hvnf0poNwj8hfbfH/szMzyUgGAtgAqEkpCZba5KjxpsmTCyjsgt4NXiPjdnn8jr0CL7rCI8jJEvdI8k1x1+HK/5rJwrAigZPKpyjzu+visRMze1k7krhd38E4UxYIIJ9nrTdpkTZeyJLdNWUXwhajWhhfIIn64Qnf4lNIctBNKHnOjl6lYtPG2Sjd6jBc7kJoAA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4543.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(8676002)(64756008)(122000001)(66899024)(33656002)(8936002)(6916009)(86362001)(2906002)(71200400001)(53546011)(9686003)(7696005)(83380400001)(6506007)(26005)(316002)(66946007)(66556008)(52536014)(66476007)(66446008)(54906003)(4326008)(7416002)(478600001)(5660300002)(76116006)(41300700001)(55016003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?cw6sxoyL19EfpPmXjp6yzc4+C52808+QK5hRhjHTA/EScysiDmIQywEueEHp?=
 =?us-ascii?Q?hFVymHpiFZQAtIsKky8cWus/tehHMlkrbXSV/x0mkjpPZ8KV1lyqMA7pwKQM?=
 =?us-ascii?Q?gKlRa2dztw1PW+sPY2Xs9pdv9aWVKXRvr6B4B1C7UMLH82hhyLV8G5qkDjL1?=
 =?us-ascii?Q?/2xH2S88xn4z02BIt6yJ88sWY9W1SZ4hs+2omVcCwalB5Qhn0HdyjmaW0q9s?=
 =?us-ascii?Q?4G4CmUFUqjJl7KGD40pCDabRz8BxJrntV8ftWm66NfGtwsAPVtm1NAxErU6l?=
 =?us-ascii?Q?sH60hnnykB1vVzxa6bqp550ct2jDG2FCxIXLsqzNs3wyt25xt4Nu56oacffa?=
 =?us-ascii?Q?M1/J+eYzqQQiXMPEElFHWZN2J4mhmlTVDjDklwBMkGL0RzG+VFq022I+ZkVc?=
 =?us-ascii?Q?XmRql0pAXqFQ4yynNbQsOyWyeOgp+bvoY46etT+3pavvx2V/qWL3S0SxrO3G?=
 =?us-ascii?Q?gmWA0MvqyPbbj2aEiCZ+HFympJWIYw91TJd3NQXf/OZ8/bpbnBrKSz8pct74?=
 =?us-ascii?Q?zxGs7dig8cpr3r3+YDA3l1wwVetb8NfK1+uQ4LCnVWRB4VZYXavDAZluQJhm?=
 =?us-ascii?Q?cP44/L3jrh3yruj5gE7eXNWCM0eEcRjcVfvdWQgrizo2XMrgXwDHzms00mtp?=
 =?us-ascii?Q?m7of4XV37XrHJYhXYAZmG8MZ20FBGLEAyvu537F2FfNwjZYMrbFMIswoXIK4?=
 =?us-ascii?Q?tXabvOBBXW86lgfJAg9PT7ukHfMkUnKbKGup1UEUFOQB2S3av2PHJcOwMwQY?=
 =?us-ascii?Q?uh0EBMUTE6xegZakUBjsH8pWbWaRbe6nsknyWUBzue8YpAlcxBitg71iF7vB?=
 =?us-ascii?Q?7gfVxAsvevYFLas2m0U85sIcuVVWgLu3EBFgPbShuHKL9tHxkba04oR6+6cH?=
 =?us-ascii?Q?UuaE/f641dOHeMPtmRaGRCBGnDWAm8qWtirBqIAhos6D4Ed6B+BEf6dTsb55?=
 =?us-ascii?Q?XveZRO4fhtzFU7OlWDuEuoTQA+Utt31n692hQismoNUeHcaR0qiOi6r2urnU?=
 =?us-ascii?Q?bzU29UQ7yaoszYpOgAKv2UwK/xf4cjyMO2jNG8s82OA6StRe0OVu5r3BiAro?=
 =?us-ascii?Q?VpE69FNaFLetKQbbLV3Ije3eRtCEpu3EBzNuo9zUykOLqIMJRp/DkIW0V+wi?=
 =?us-ascii?Q?JQ5NT4PyJBl+M1v+9XUftLexrI9pXrvf8jLmczpBrfEZUEsguZ/QKL6ydAO8?=
 =?us-ascii?Q?2fMVT58PmumxgaXF8wywDZl3CI9FCsfSCgqiiLHCIGUJr0AQ5WFctyoPHvdS?=
 =?us-ascii?Q?ApBHs/B779EVZdzogjFgj6Upfdn+aOA+vYmH7LUBB/v6+5MezdBw3LtdR5bo?=
 =?us-ascii?Q?JHc3PmFSCNjm/2VFGdBjOtoELnHgjI8Z2mb1VeAk38dNnKja2YT5sfTmBsCb?=
 =?us-ascii?Q?QaQY83o/jS+LPSyOxTbX4URzxITNdLJwIbueg+fHTpOG+Szcx5CFPYH8H3CF?=
 =?us-ascii?Q?xH5C7em4rhZd/fa7JikVuQWb4w8LnWt7sviDSOLeGuz3hJP45ndrBqRrJZS9?=
 =?us-ascii?Q?hTufnz2eD64FJw4u6lR2yAoIzxwjnT7FW2XciG+X1/blFvwOWproz9f7K930?=
 =?us-ascii?Q?OFqkmVUS9BZXld3nhsg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7123943a-c83d-47c2-9f8d-08dc18a2d5ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 03:58:03.0171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BrQhdv9Y30i9jRoCRdUoETTFLxo+0gwlVQMs4FLtGphWaEVaf9AVo2zg/nVZLL50FQiOuj93ZGM6kT/HogufIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5957
X-Proofpoint-ORIG-GUID: E7QAq3OPhnsc22E6u_-0WPA04SbVzaqu
X-Proofpoint-GUID: E7QAq3OPhnsc22E6u_-0WPA04SbVzaqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_12,2024-01-17_01,2023-05-22_02



-----Original Message-----
From: Maxime Chevallier <maxime.chevallier@bootlin.com>=20
Sent: Thursday, January 18, 2024 8:21 PM
To: Jenishkumar Patel [C] <jpatel2@marvell.com>
Cc: marcin.s.wojtas@gmail.com; linux@armlinux.org.uk; davem@davemloft.net; =
edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel=
org; linux-kernel@vger.kernel.org; Antoine Tenart <atenart@kernel.org>
Subject: [EXT] Re: [net v3 PATCH 1/1] net: mvpp2: clear BM pool before init=
ialization

External Email

----------------------------------------------------------------------
Hello,

On Thu, 18 Jan 2024 00:14:47 -0800
Jenishkumar Maheshbhai Patel <jpatel2@marvell.com> wrote:

> Register value persist after booting the kernel using kexec which=20
> results in kernel panic. Thus clear the BM pool registers before=20
> initialisation to fix the issue.

[...]

> +/* Cleanup pool before actual initialization in the OS */ static void=20
> +mvpp2_bm_pool_cleanup(struct mvpp2 *priv, int pool_id) {
> +	u32 val;
> +	int i;
> +	unsigned int thread =3D mvpp2_cpu_to_thread(priv, get_cpu());

Please sort these lines with the longest line at the top, following the rev=
erse christmas-tree style.
Thank you for the input will make the changes in v4
> +
> +	/* Drain the BM from all possible residues left by firmware */
> +	for (i =3D 0; i < MVPP2_BM_POOL_SIZE_MAX; i++)
> +		mvpp2_thread_read(priv, thread, MVPP2_BM_PHY_ALLOC_REG(pool_id));

Since you don't need to use the thread-based accessors after this, you can =
call put_cpu() right now to avoid keeping preemption disabled unnecessarily=
 for too long.
Thank you for the input will make the changes in v4
> +	/* Stop the BM pool */
> +	val =3D mvpp2_read(priv, MVPP2_BM_POOL_CTRL_REG(pool_id));
> +	val |=3D MVPP2_BM_STOP_MASK;
> +	mvpp2_write(priv, MVPP2_BM_POOL_CTRL_REG(pool_id), val);
> +
> +	/* Mask BM all interrupts */
> +	mvpp2_write(priv, MVPP2_BM_INTR_MASK_REG(pool_id), 0);
> +
> +	/* Clear BM cause register */
> +	mvpp2_write(priv, MVPP2_BM_INTR_CAUSE_REG(pool_id), 0);

These two registers dealing with interrupt masking and cause are already cl=
eared in mvpp2_bm_init(), not shown in the diff context, so either you can =
remove these or the ones in mvpp2_bm_init().
Thank you for the input will make the changes in v4
> +	put_cpu();
> +}
> +
>  static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)  {
>  	enum dma_data_direction dma_dir =3D DMA_FROM_DEVICE;
>  	int i, err, poolnum =3D MVPP2_BM_POOLS_NUM;
>  	struct mvpp2_port *port;
> =20
> +	if (priv->percpu_pools)
> +		poolnum =3D mvpp2_get_nrxqs(priv) * 2;
> +
> +	/* Clean up the pool state in case it contains stale state */
> +	for (i =3D 0; i < poolnum; i++)
> +		mvpp2_bm_pool_cleanup(priv, i);
> +
>  	if (priv->percpu_pools) {
>  		for (i =3D 0; i < priv->port_count; i++) {
>  			port =3D priv->port_list[i];
> @@ -629,7 +661,6 @@ static int mvpp2_bm_init(struct device *dev, struct m=
vpp2 *priv)
>  			}
>  		}
> =20
> -		poolnum =3D mvpp2_get_nrxqs(priv) * 2;
>  		for (i =3D 0; i < poolnum; i++) {
>  			/* the pool in use */
>  			int pn =3D i / (poolnum / 2);

Thanks,

Maxime

