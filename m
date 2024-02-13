Return-Path: <linux-kernel+bounces-62937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F0285281C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED60B2525F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0411CBC;
	Tue, 13 Feb 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hAMtbgQh"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FD6256A;
	Tue, 13 Feb 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800734; cv=fail; b=Zt24SkGemgHUQ/Xe/SKlyynPpLSphjXXYwQHcDF+uQ62GcG2109qmt5zq4CQQTuXQTS+w2F1mJjdq8MqrFaMMxs/nOCMcQ6369fvPSP4v+os/OcqEXmTdixURZSDpy2+9XSesCyUY1j55OBbEK4hhwmK4yuF8cJvjOYYPs0610E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800734; c=relaxed/simple;
	bh=6JRRbzAkA7cyEzDJ+l433BUnJVX56fUEzliT1rR9zmA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jo0qctRe9BKN+JYZeDUWrTW/2BKZTTS2omOaSIkQpbvCctuFCllMk/+8mknrS7n99hIYW1eAcQrWYjWGgaoTHPWCbCFbkC0ONXMcF5Ve6U2GSBy9gnwS49H+dEyJxzWDTw1F2YzxRIU4M8BBfNkgiH0HaHnH1aOuvAjD7LQOjaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=hAMtbgQh; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CIf1Ka031621;
	Mon, 12 Feb 2024 21:05:10 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w69hkevvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 21:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZG5ltK9GUWF64qfWYJehPi3IhEziDK2UdLsBeRu6W9ht1gGKQzP5b7nX8ofayL7YV7k7WtaG9anfMX6bqdtlB3UaoRrms/9pd9dXdXnMb95kG9PReZMgcsjSilI55eUyQ8/buODVJ7ALeCMYKBQu6SXhBe5Owh+oQsXg6RG2cw9utWMQvkuTput/Fv+SMOHuHfvztViv3tvMi2eKt3lEr/eFPTbpSzwWndI3HWncRUZw/pGcoUYndX9VpHmbZhYQr19sIvBueqPYAA5RFztGPHix7W36S0wSV3lYSx7e1ft3xSMOgA3V7tMlSKlzUhLIpShUdd6LcTJ3FYpFBdciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JRRbzAkA7cyEzDJ+l433BUnJVX56fUEzliT1rR9zmA=;
 b=XQZcXb1hY+BHFwC/hGagbHBAMO0FIntrUTOD5yWfHJW/lZgqWwA3hsFi24AdjrQC0JRr7bldhLh3SUQhFUVO4jKRAZcddGn4POb7cXFmkDiWYXDWsCx6QGcAnUwGm4i8uOB8B9qy1DCYl9KHEkZHcJ8TDuU9T2dqFhEH9VKmCREqgwxHCdMXaWSFqtQ9kKvv+rb3WCUdGGvUz7+RvDWDWlHssAxdn/b0ZWw+Xpu1zA/jHnbJeAhOL2vLwtLp7FxSVbSy6tJENpx4HtOJg+JOu53H3AEl51acykHJq2lz70qmsyL/+8qt7TG9xCfUvLYMqEqtELHxFXF4N52pcKnVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JRRbzAkA7cyEzDJ+l433BUnJVX56fUEzliT1rR9zmA=;
 b=hAMtbgQhHsqupVaHZvxmg+iGWYCBhiUmGSj4yrzNysuvja6YKT4JLGuVxe2xo5biR6U5WI+3WnN4YO+rLiaGfI4qEyM9Tb0E6aaj3pL1OL6zyO7DnbogGhgFNqxWZg9xMrlHJj9ivP6NHvdvMXPJsKihaFx50NvTGt5YKI8u1Ns=
Received: from CO1PR18MB4666.namprd18.prod.outlook.com (2603:10b6:303:e5::24)
 by PH0PR18MB5091.namprd18.prod.outlook.com (2603:10b6:510:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 05:05:02 +0000
Received: from CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00]) by CO1PR18MB4666.namprd18.prod.outlook.com
 ([fe80::5681:5520:befd:6d00%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:05:01 +0000
From: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Sunil Kovvuri
 Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Hariprasad Kelam
	<hkelam@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "horms@kernel.org" <horms@kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation
 for NPC transmit rules
Thread-Topic: [EXT] Re: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC
 validation for NPC transmit rules
Thread-Index: AQHaXRlApo3qAicmJUy+rFKKud0sSrEFerrggAH3cYCAAEeQQA==
Date: Tue, 13 Feb 2024 05:05:01 +0000
Message-ID: 
 <CO1PR18MB46667A9C5A767A6596F6AFC9A14F2@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <1707676587-12711-1-git-send-email-sbhatta@marvell.com>
	<CO1PR18MB466623157B4EE9B2C04119E4A1492@CO1PR18MB4666.namprd18.prod.outlook.com>
 <20240212164713.1ebd7fef@kernel.org>
In-Reply-To: <20240212164713.1ebd7fef@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4666:EE_|PH0PR18MB5091:EE_
x-ms-office365-filtering-correlation-id: 1c317661-65f4-4498-4e81-08dc2c51557d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Jyh0NodU9VP5pkca0pnB9S2DPe8/I7oNNSdseKjvtScH/JN5bznaaVf3A3wVQk2ALl/vZTapnen3mn8VODnxjbdm/J5vE4CBnyOFim+ThOeN0mGMs/JFj1f8djNmVZGt0J1AjgPEVc/xyjt+x1sGvd/OwDZrKNUzypKh3EdO2AXn3fJNxIl4qrGf6bNmenLt6Ze392+UekJivbRJKjK8IqPyDPTLs52AKdd0ZCIYVoMUPc2M0KUu6hxg0bwtpTKX2VAO8tnzjkwiRyKesyM0b6pBeiz4C7hMvp9UxO5Rqll8pVnbSyrp1yEu9dN/c5WUpuu+8b7A42itOyDPwmo62v8nRBChbvRSz3jUAh5v0ZHBWUzo0qqQYhrdSQ9dXxuvzauaL1EMHVepiSzFrE7W7xg8P+wscZANZ1Va7UyWlQlELrnRn5sYldBULTObheA++ZBG+fnFjdT236/e+jZXsH+e/6nUjfmAqw2LlOWRBFdjM4JKOwJ7kkHlTGFq52L7e6gARYzbQwKbU3YH2hV0zhLa3UhVdrd2G9h0h1IT2hKe1MkOMrghcaWr9w4E8wd62+xt2wS0PpL27VkNwTwEwQ+uYl4S4GxFK67LjRbllp0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4666.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2906002)(8936002)(66476007)(52536014)(66556008)(4326008)(76116006)(64756008)(8676002)(5660300002)(66946007)(66446008)(86362001)(33656002)(38100700002)(122000001)(9686003)(38070700009)(478600001)(6506007)(7696005)(316002)(54906003)(55236004)(83380400001)(41300700001)(26005)(71200400001)(6916009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?nd6p1pS7m8L+P6DBUT+i/8yF7c7rPFBpJCCTfp5lqig0IdVQMjXeSbUkFDq+?=
 =?us-ascii?Q?M8MErzxoSMMKayV8qt+Y361PsGTHiqr9dgUtT4z0tA9kxkB/iMchHGaMUkLV?=
 =?us-ascii?Q?adXlXyTXsW8sWzqzKraX7LOMDFGrIX4qawbwp+xCI7k3oxAhTjqyeMGFFVCv?=
 =?us-ascii?Q?xNANWlHMvCzb8dATFqwLqD/QMbtHwznyt7YlZ31YmhGJTsrzid9jJqBZhOAH?=
 =?us-ascii?Q?FMWMJYUGLiYpfA3PhTDSc00OjAdDebR8gPe0IR5bTJvbGfajzkjElAd2XRga?=
 =?us-ascii?Q?MYbACsudzUiIH/7WH+jri8WrC/YrdNClOY4XIPxpPexqR1wsYJ0zPhinsYNh?=
 =?us-ascii?Q?KUaUia7IX8K4Ib6WO65KRvm7Pb3L0h+0cvkD3pI+itzoqsvfuRcnVAk0XyQZ?=
 =?us-ascii?Q?eOFZYkrMZ54VVhKoroY7EVKMp56oqsLyiXgcaZD5osivU3L1AwhsJ3OVhvGN?=
 =?us-ascii?Q?vRvCVSJLFUFYuPW7EUZeL/JOk23MY+78UapmACTf0O2LgH9zZgzYjkRhjE4x?=
 =?us-ascii?Q?qUuDkqJMLSc6sPPymjh7cSi+H6ZK6Tx4qHZhSo0WbNEQRLyWrVgpZT5wM2Je?=
 =?us-ascii?Q?OGQo2huMlD6lqc8d6RqrVZGbfaCe9uWK0c1lumjnGrHhmXJgy7TUucOC77aN?=
 =?us-ascii?Q?izYnaTqqbOjnE5sejprmEFBr6oBex5Y6ZCiUtUotmxd7mNXTnT6Lb8YMZ5w+?=
 =?us-ascii?Q?M1/r5bEPxZGAkKJxSRd1m+pdZrkwQItzqdtq41nTnFfFR2naeC5WWxrbe8eq?=
 =?us-ascii?Q?8ZSP8xKZFoLFJaGw2247ClKez153u9pmq/vW9fUvGam5Lz8g0UKxvQuW1GTD?=
 =?us-ascii?Q?AObVQXcAvnX7nQryQtosAgY5VTsQ+4cWT7akODRTrI4XldgXmA+QAxuJ6Xv4?=
 =?us-ascii?Q?qSjwqkRQNo3JXkNnkHBUjF3lM2T26LhuQ9CXqQvBOeMY9Ru2udk4FLelCaeS?=
 =?us-ascii?Q?lUq+3JkVNts0nBBJPfCWhCxM2euN/sdOeI+b/gRsp/ngQpsRtxru+9bEpLMp?=
 =?us-ascii?Q?/pw5r8h8eOw8fISZ1rMKkYY20BXqEqOWq/dn90+unfW78RJwIK4D9j2Juj7E?=
 =?us-ascii?Q?Cb6d5zhS3pznBiIr4UNgcouB0G0zaZA67j7Yp7395ge2pJD1cdEZiJk2rhmv?=
 =?us-ascii?Q?5U87ekgz/xF5n2YaqugeKkZbOSIyVxeZSopAukMuAuWojWVCHW6PzL/pBuYN?=
 =?us-ascii?Q?q8vorZeeiVQ/iFO5zMVJ5E7bkNgZE+iXG1AJFRlv+X+lGTvYbti/fQt+ueLx?=
 =?us-ascii?Q?2lL5Jruq5S9Ef245IwXhk8UJp9du0DmL8VnryYbxKUUpFQLFgE3u609tZ2XM?=
 =?us-ascii?Q?nJonK/e7JUGWdhyvbGFiqRuOLvOUn9o7VaQovajdEnjdGJsLfLGtkUCdxM4s?=
 =?us-ascii?Q?oPydA0wiSG/NLcwoMVqfuqxXk1FQBkn6XtPE0Z2UJ7DkxBUTOOdIiE+uBveO?=
 =?us-ascii?Q?5cF9eo+YUKVH58XL4xoxr7vEl2PsdMBydaDue5L8yr8lMDZ6EIhlTeDT9ASO?=
 =?us-ascii?Q?nmRR1cgEHx7BWE4FKoIXIg+Nvn+Ze+3JW3zyjL38L6aN8p9P4kkcft9psDPN?=
 =?us-ascii?Q?yfPhQmhINog71rYFChTHINuLFPff+VDmejkochJl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c317661-65f4-4498-4e81-08dc2c51557d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2024 05:05:01.7454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NzucJZsHdsFmbEWFFkrWcO1D2Y0EoHi3c/MQB1RpmzteRc1++8OFvA0MKXu56MtTG+3HGzPXSpRAs4YIOad5dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB5091
X-Proofpoint-ORIG-GUID: ZTXH2j5B5jD-Lfrb5msZooKbJI8vA7Mn
X-Proofpoint-GUID: ZTXH2j5B5jD-Lfrb5msZooKbJI8vA7Mn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02

Hi,

>-----Original Message-----
>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, February 13, 2024 6:17 AM
>To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
>Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; davem@davemloft.=
net;
>edumazet@google.com; pabeni@redhat.com; Sunil Kovvuri Goutham
><sgoutham@marvell.com>; Linu Cherian <lcherian@marvell.com>;
>Geethasowjanya Akula <gakula@marvell.com>; Hariprasad Kelam
><hkelam@marvell.com>; Naveen Mamindlapalli <naveenm@marvell.com>;
>horms@kernel.org
>Subject: [EXT] Re: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation=
 for
>NPC transmit rules
>
>On Sun, 11 Feb 2024 18:46:40 +0000 Subbaraya Sundeep Bhatta wrote:
>> Please ignore this patch. My bad this is single patch but sent as 1/2.
>
>Thanks for the heads up, but please keep in mind that "obvious mistakes"
>are no excuse to ignore the 24h rule.

Sure noted.

Thanks,
Sundeep

>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__www.kernel.org_doc_html_next_process_maintainer-2Dnetdev.html-23tl-
>2Ddr&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DwYboOaw70DU5hRM5HDwO
>RJx_MfD-
>hXXKii2eobNikgU&m=3DxFW8Pfvppu05waEU4SRwpomQKxwPcvOsIiwULXFg9apf2_8
>xH4Lch066VxedIOTh&s=3DvuSx17RQHZZAXIRBDC8UuNKHgYvt91gLuztiN6SqUKw&e=3D
>--
>pv-bot: 24h

