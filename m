Return-Path: <linux-kernel+bounces-160771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AC88B42A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DDE1C215ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDEF3D0C2;
	Fri, 26 Apr 2024 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="fRo6YmDY"
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8629E3C46B;
	Fri, 26 Apr 2024 23:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173522; cv=fail; b=YSuIBDkFwVtBISdKqA7oq40zQ9GO3VU7bsGzQAM39x/Bp3bSvsYemv7fM5qkZehTzVNxXzujVI1Ef39RKbPQrmGvGN0quDrIJqO98s3J8TwonsDC+mJJ/Ed2b6ZV8ZV8nVO6OUQFNu4pfR9/bvCyBeZUHh5siRavCklxYI+5Vpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173522; c=relaxed/simple;
	bh=itbhcWH9Tp87Ca8LXErp7Y2nQOVNeK43yZrCGYQ0jZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQwzcUv0cxKdyjLnoo9JEHZWksVJA5s50SA6OamYdiOKRCE40EMIKA50ZNDyedAcdyeztHTsPLsb0dH4Em2mTb6uso5J8FYm4cQqnyeRoXSweI5rX8icU/q1t1RsqjHREPxuvmoXZvD1o1U3C0Aenmpf4o9C0FW4X6IkBbreMHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=fRo6YmDY; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QMlQ33010819;
	Fri, 26 Apr 2024 23:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=7XbsT6CcTT1JpmWtU/q3A0R3lxsKKiviJ8s/kaVyQvQ=;
 b=fRo6YmDYl0aRTMG3FQwuYLSxd/Ctg6wcy7MOc9aFHjAymQzS3jS62UqDaPaEumvErNk/
 q4G7/mqrLC2AsLZrlkDp0LxAEyLfCZ4tBKZuxCAfRGWoRyulVo7EVubh5F1moacmvA9s
 0W+8fxvTQiqJk5oa7wbnax5XFwJDnylc+GO0wiimqtH5KmDrv2SfLa6TlfC882jz7dCl
 hQZkuVo0maCgnZqHi4KtckYoibYzhgQPvimk+mUH052jSuB9zG07LbgcNkz+mfM6yyga
 LvtCimhRg8tqEHrkveOXOPwge+/qaxwmdTJxt5ccmfVOq9PqWH/tGbruiPil0So0RTl1 5w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xqwmj1b8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 23:18:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZV+7UTW/wfmR1ZGP8MrUTlKGlRGvHqjcMBysB4u5fGNRdsSvI2MunsbA07OJ0PYzr9zZlSPo7dsRKO7OGIRXeW60qi/+7zeVIZNf3Ea6+7zh2waYz5L6xnkiLuu+zfQ5XdZegyNQM20ZWjmRbbc1iKGs8HTFX4Qtc/n2ZKWNbWkVJdD9vjZFP6biGLbA2bsuaDKmITnRAlIFDPs3zk6KoUTM6Uaa22d9wTzDJXkNite2OVxX+wzbaAW8XB++cra01DcqlBVkdh9rlD6KszE0IjIi9KmEusY/gPBVLacjCtrm9giVBpXfIAtTMHPALjmw/q/zrbcjlDhkmzova6IDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XbsT6CcTT1JpmWtU/q3A0R3lxsKKiviJ8s/kaVyQvQ=;
 b=ICIYbdiISugxNpOpW7wMWyuHcmAKNuKCLQtNd55SEYiPre/h86dO1QhjH4UDtmeu8N/dHEBGJ3RkqFpfJOO12lMQUtaV/OZLQKcnfKqwZZ2ql4MnwmAFclcVo0iNZsjNlxYUo+VDf9RqfqBiQF0os48mCi+T1mAyROxivA98+YAo8D1Az5yjrITiZlnuyw8mr/cVD36YEYAGUSKfo560eqVkJ8JBoRjXd9JU4Kmhlcd8oM2AuJzT8I4/sRO1LP4TMZPUt5rHBngMqHBpD4zPuj+X8dbX7W7wmA3kQB7xe7cyzWRU2n42wqlHf5HbOXQq4FxmHrVud9YE8lIrPugEEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by PH7PR13MB5594.namprd13.prod.outlook.com (2603:10b6:510:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 23:18:15 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 23:18:14 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Greg KroahHartman <gregkh@linuxfoundation.org>,
        Sasha Levin
	<sashal@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Thread-Topic: [PATCH] docs: stable-kernel-rules: fix typo sent->send
Thread-Index: AdqYL9089+sCb2j3Si+txixVqLkj6w==
Date: Fri, 26 Apr 2024 23:18:14 +0000
Message-ID: 
 <SA3PR13MB63726A746C847D7C0919C25BFD162@SA3PR13MB6372.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|PH7PR13MB5594:EE_
x-ms-office365-filtering-correlation-id: f2b70fb1-05f6-4de6-b950-08dc66472634
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0QEgeV7vO6iODve+ZS9QgtlsDxd/fIDLeS3PIqNNrrlAA2isD1PZMPWj18oo?=
 =?us-ascii?Q?cRigobolPggMYtzdLk7m/ekrxNpWDonXOQLyflBsf9HD8LACIeB70ywB7kDz?=
 =?us-ascii?Q?n0FTLD3FIXUFrHpwLHF7GlTiz0merIt5OzCWF48pZPGjJ3AUkMf8ioE6cixz?=
 =?us-ascii?Q?D+G59t7Wz+qSaGuPxrTvtXa8paw82KaHT7LinLgyM8ec6k999SJ6I0KcAvKx?=
 =?us-ascii?Q?bZlficiDnLR919GJ4932Gd/fihrc/hqFbugxGwLMi5BW9rSG5pcP542eu4Ux?=
 =?us-ascii?Q?EdDMEQ8u2iA4Cc6jA1xo+PCBDpTZ+ZGDrVY3NJSqwPKSYbIJaiEvdSQXelQp?=
 =?us-ascii?Q?+WS6pX3VARx4G+7h4tJzGk1+WUf5tDon34/cxCyNDvreDmtHvQMfZxPOBzsv?=
 =?us-ascii?Q?MQDygZ3TaXFRYWs+8ui+gvHvmo5ILsIBTTB7DKbT2HZLHu6YiEjudzr/TYRL?=
 =?us-ascii?Q?0KthSGhbW6EFSaiVqG7beKJom+p4iGL2vSombNEWcDf0XWBtr8Zp8lfp7kKi?=
 =?us-ascii?Q?9XdXq0Flyt3NigHnAKTb8iMVSP0VeRj55hr5koIvSsk5BW2Qz85JF5HfdwnZ?=
 =?us-ascii?Q?0caa2SHjNewbRZNpSQlfVXJdpHo89zWI72YkJM1VzV90egvL++YfwcHl721G?=
 =?us-ascii?Q?qpggOEOJSP4IXrGekL4RJhD/u/9FcjsIgvVxUgfPGC3VHgXNBLTuzw5C+aeD?=
 =?us-ascii?Q?RpOrymd8YojXy/2rim99XHtXX7lo9eyIRjPpZ/8xNM3MfpXjsZ+7ho+iT+61?=
 =?us-ascii?Q?F9Ulu/hqHKhZmvV1ajQXOZ1371Zzajmg0i59A6PBVT7Cmq8G7VR0FvpHdXqv?=
 =?us-ascii?Q?F91Y1vdDeHr6iZiLIJWaA9jHF++ME5fKQlz8e2H3Q1Dq8cpFxM3oh6/GLX/s?=
 =?us-ascii?Q?Q6xzbkJBt7IZo8ca0ykfWG/sTrtwZRGxI9j6FF3CiRj7XSluR7RCuSORG6XB?=
 =?us-ascii?Q?Ry2VBo6Z6ShjivsDSIaLugTImw0KMj84wgwdZplzLkwDqo5Ugk/pyIEzs2UA?=
 =?us-ascii?Q?dX6INaQTh/hQf3W1/1Tfp1dopT5YxKIqUIUn/2rbtyuEpzAGs3nVobnvnrdW?=
 =?us-ascii?Q?qjTDaB0FRG3EXzxDMpLydcW4iW5H5fsToFxB8f0ppJIIwMUN9l3PYqHiH3WZ?=
 =?us-ascii?Q?gO+wtbuYRrRfBmYXgHvxkyGuKp2SriG2COacv9TVy5DEwf+9LaOnbj9Lklgb?=
 =?us-ascii?Q?JDEFQd/Im1nmXocIAtIaqSnjaNSwZJmJHpUEsGjVSkLCx5XBpAkXQEGRTY8h?=
 =?us-ascii?Q?kU/z3xmFv9nHRFQV338yiQTFVf26bT/sZNHUi0vS0K6798mNuqDgP7EHmK3J?=
 =?us-ascii?Q?xjie+TWE4VnKnyz0tl/LXF4fjk52Gmk4Rwh2XNoerzyh9g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?H0+LoZXp9uP0VgWkUw94dE1gvZZkvAT3Ot8XCAjMu4xZ6DM6yp9aLZAmw8u4?=
 =?us-ascii?Q?IcKX8LOtLbA2xzn7rjhDqZzbsxZzQa+qJqSH+pL2gBNSipNFJZu4OmNRdUGM?=
 =?us-ascii?Q?qZ8opyCc0emR9H/WY6w1oXpCR/7A5vGW4vzdhuiYgMFGCJGHRaUBjRzW+4QN?=
 =?us-ascii?Q?+1t5mWmVrLNEzPU0Hv7Tl0/8KCdqJADlLt8FYlPdFndxmL8zALkCwsqThcoB?=
 =?us-ascii?Q?xyMoGWiLGM6dhHGEuLhHIexohKRaqxEKOomutNoCRv3+xu5plku8hqIwZxWm?=
 =?us-ascii?Q?nl/cIJGOHD/z+b/GyUsJb44bVtMfe4kPCG7N+FwPdSKQbonvwMwp5lIunAg4?=
 =?us-ascii?Q?NxOJ3bwl+8TFNWYt7HfxbtkCEAejmbZReybWL1GIhZ7QGewy1W4e77vuIxER?=
 =?us-ascii?Q?rjohv9SzopZntTMBl3C/M8UMapCIgIM3h1gOU3vg5TL5hTOBKv50C+KqMpT+?=
 =?us-ascii?Q?tOPq2oAY+Gk7YbCNdqPb69wIglP4yr64SnRNgoJ+dagGzGJ9mOmK7xXt3+Ck?=
 =?us-ascii?Q?A/lPLpLeYVIy4UYr/k4Sh5BTHzAA2ZcjKrhuUwX/6t9fYmzHMtPKfT+pKpt3?=
 =?us-ascii?Q?yBwMjZP5w809+fF4Uivvcd2MKQ6pL/euqXBWjM0zf0aygEaM6ZoD3W1RNsII?=
 =?us-ascii?Q?ysXIi6P2j18lCjDSXGAoZ3+8HCHjN/x9bIbOKoC1qi+ztxzUHs5A2ENycglK?=
 =?us-ascii?Q?Vc8PlVvk+b6f9F4ZHui6Gn/zMjNIA2UaduW6kERvjAlB4yyYj6juSG/tNVt7?=
 =?us-ascii?Q?Fzq+NtEHAxypBbqTUSKh/3zphJzmnLeDNTndnZxfTISQ4VFXHS/R8hviv1TZ?=
 =?us-ascii?Q?4/Bn9pnVD0mYopsNwDSd0vYwB3b3I+l+OoDVPpNc5kbrBc39FILeUrhpuffk?=
 =?us-ascii?Q?Q/wWk1TMQbKmqVY2yCdWzhQB2MtCerXFxYJXmGI6vkyUBkOViZ5MeO9+Iyuh?=
 =?us-ascii?Q?WTEOMVaPSVt/l+Bj3C1+OVjTFtHZUp1vnyNWd+C9CyaFUGGS25vU8NLNFdA+?=
 =?us-ascii?Q?+RkUPWzkmr34UX+qkKA0/3gX1xvsaQKe5UFgncV3DeWK0kTj0Gbqw9t80wVo?=
 =?us-ascii?Q?G/URDIIkdJwWs8pXVmnPw8D2+Hdb0hdPPhmkWco3UUej3ZKjNUPlf4bu8c9K?=
 =?us-ascii?Q?cZdo0XWvvWJbvszbw04fq1ufhN33WSMCtuKy6zs5qnwZGn81UUNj5j5fLVqG?=
 =?us-ascii?Q?rQJ9IM1C/P9ljJCrVG0ByFsd9xZ+Z+DzrR62UVla2tPZlK5xAIXlksrApoJX?=
 =?us-ascii?Q?sCd930RlrR/LikRsfSjcfc4JUxvtm7j7Q9CyqS/ulZ3F2xPY64cfY6O/rjMa?=
 =?us-ascii?Q?+GjEvgaXk2OBgzH79QxOKroGSadkI9kuQj3fcdVaHLv4mVmV2Hvd9sTdFp1R?=
 =?us-ascii?Q?Y5tZmrNT7WtRHNYq4VV+q6hgSGwGU8XOis5HTAVtRbplrp/qut86FHvfIdP1?=
 =?us-ascii?Q?ha9DQuEU4NYqzZQIhSPSffhcxrPc3httnX4OUi6Hj38rvtiTTP1eQGNU92jZ?=
 =?us-ascii?Q?Pjgd8Fh3dmXvAqCqZPVmF33JAGJ7pyKNu3HkfbAKdpCJh1esG286VLXu6HKG?=
 =?us-ascii?Q?LLCmX9F3X30UFOEXqvA=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CmSQY49FRg9kYijfaU8e1FmMcbxAX2JhNNQjPF396IXGuJZ1Z+9qxBrKNMG15Mrgcw5d5YFApZ9tuCarxSSENfz5k5mIbuHSdCIjcYh3BJM+UcgpqNubVdTo0ah0uwO4uzJQsrZyihNIzXJQZhsxeBGk3c+bfuh33S8C2Jzby+8kNk7szXHnlkTYoUv4X5sWJGmHeJc2OJJgqKv+O9Sjs6vIMMpfwT/xxVEi96RA61AZNam4yYji7BjqZey83hHBgqNY0z3winVf6gRsOFgt+iNlK/IYkFQnX9DdXhhR7FUu/xnz+ws0aHsMCwsRcnFhR5Wj5Vss4Wq0eOV2fq+RZ3gCKO0CiOGAHLMh9nRS2tufo26OeeuTHvW+n7X5mGPkvmaU4T2K9e6lT8zS4sEqApHv4pz62qRZEvClBcL77CakvXw0Nsls65B0bmOmWnhC5l6FxVuDZuXnahETU/vZSk2q96U4bFOMVai1Uol2UsmNQdyLItCEmfRyWH1JC8SSMZGA8QYV7F+VZJo95QHmoVqCNGCFToZf7ZMml+vTQ6kZzJq2tz4p5dY52sllj+WrzXF1Q7CE0HVs2Q/Cp5RafePpwsuhTpAQ36Jv2nsKY0MEGm7x83DCT2+zo3SkkM2e
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b70fb1-05f6-4de6-b950-08dc66472634
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 23:18:14.9425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3v9YDdm8JF97U4DJAyg4DI30Lf5f2lMY0C1I6eZ6AYkPA6MDN20SqhTyJlzEnMkLUbltbr8y0O9t7YPsWm9isw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5594
X-Proofpoint-ORIG-GUID: ohsrkNaTD2Z36_GOXhioY5103Ut9JRwR
X-Proofpoint-GUID: ohsrkNaTD2Z36_GOXhioY5103Ut9JRwR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: ohsrkNaTD2Z36_GOXhioY5103Ut9JRwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_20,2024-04-26_02,2023-05-22_02


Change 'sent' to 'send'

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 Documentation/process/stable-kernel-rules.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/=
process/stable-kernel-rules.rst
index 1704f1c686d0..3178bef6fca3 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -78,7 +78,7 @@ in the sign-off area. Once the patch is mainlined it will=
 be applied to the
 stable tree without anything else needing to be done by the author or
 subsystem maintainer.
=20
-To sent additional instructions to the stable team, use a shell-style inli=
ne
+To send additional instructions to the stable team, use a shell-style inli=
ne
 comment:
=20
  * To specify any additional patch prerequisites for cherry picking use th=
e
--=20
2.25.1


