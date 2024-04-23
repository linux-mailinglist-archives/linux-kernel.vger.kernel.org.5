Return-Path: <linux-kernel+bounces-155724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078118AF637
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896001F28851
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E591420D0;
	Tue, 23 Apr 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="Fys1V/uy";
	dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="q/Ahbnq+"
Received: from mx0a-0068d901.pphosted.com (mx0a-0068d901.pphosted.com [205.220.168.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BCD13E404;
	Tue, 23 Apr 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895365; cv=fail; b=RPxFzlwUkU2CrdSSGmFsKx/gTFcntqrsyD4S6ktnGUomvSVIs8U8wh3Gn1M+lnHZA9Ge+2697JvNe+6r6ZSYgYeOqUk1lkAydw1UFPIP0U5v28eljZ+xxcoFwtOhogwMgsdXVaWFD+lH2cGZT3isGBO1lHwRB48sdM/Fg2P2Kps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895365; c=relaxed/simple;
	bh=7FPMhlh7ZFtKH73DPBsEVSX39vQ1F6251Nt9ooOrfhM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FV2iYIvJ1g0q9FFqNvHGXC1/yOHLMLCwryLVbfHEVY8zYk9rEWO9eiPdSQ8gs4PkoTwbOY7Hr5TDDdCXly6y2yyLHhjDK9SalnBjt7VVmxkDAp2cIRBCzZZL1u9SBZzmOXcIyk6BQVWMERJzdxr0H6R+oVTzUa9H76N5H2y/0mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=Fys1V/uy; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=q/Ahbnq+; arc=fail smtp.client-ip=205.220.168.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278264.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NAgcnm003261;
	Tue, 23 Apr 2024 11:02:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=proofpoint; bh=Q1QsPp
	2T2R827UkuHUM0Hd+fkSaZ7sjMKFRuKioKVzE=; b=Fys1V/uy7oHIBLQlUZzMhi
	nCJaQ1CZ8QZQ36pGa0NGgGC9SFHyCvW0gKfm9wUCpdiCQY05qJ1HIrJvJBgW9x4T
	srodLeAsrqesCye5O346EW4htsqS8Sme5FCy5zADG8fF6S13jUvtTC/VM8GlMMKn
	OwJcNkH0dc6X6jvsg1jKyUKgeMmhPoPoa1jMSW+S3Y569LluJMsvR2OkfiWBbHoh
	lUec4jsDJNjevMQjYh2pLc7som6vP63++Y75z3YrQgQWP730bE7o95MGVe/Du5PI
	9FX08WToRncmX6rXf9ERbPuzuxqyIbus69uG2SDtTHjnQ3HR8QbopcASl6wOMTmg
	==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xmcrg27jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 11:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHFk/Xhsrall4YQl9WQEmAjyjKyCVOPPO2PXnEayxq6su2rDer7Dt6iOodmMx+jkzd5lT229aH5jko9ZR7rlrNJeYuLFsDZGID9oqdxwFnXUymTbz0SPbkIp5HKHvJVgD0hJt+Nh5EflqrE5M/BTsdNdtnAJuV25PCSMeaOhOJB3uKVx4UQeR2V7bqQT10v1JQdoP42wtUdpAIEJJSnWXJibrsYAuX07cxWZnjiGmK3U9IcFnqB/iNTEOiEbIyNrbdE+vbAbIrfZDIdm18lMa9NXEfHeYnAvhyrdsZt+WK8f6daEKIMypL/gxhIZgrZB+o3pBoTNc5KF0Vr1/9/8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1QsPp2T2R827UkuHUM0Hd+fkSaZ7sjMKFRuKioKVzE=;
 b=WutJc23UGcsSZC17mTUbHHG6ubsQd3ET9ekBOb748UlcC5z8v72iSFQTPYurt4MU8GTt5qQpn6aWNEbfhohhtdaEJKHg8tVGCaDKkHPUV4/AGvSzTFrRn4q1W5jCd4E+rEyj/o77PdnonkI2wRqD6zLIl6dYAbjphCJGx353GbmasVPkOL4e9O9DqYhxxRFjnkhxlcMmeDWGl0hqkgZ1OS49blcdUmLVYXeGmozB/QVLt8D1g5vJofGe2wLM2pVQWmkfh9aaJJMhvpKTuOp93R/NTtsYcoJE03eU+J1uQHLuUY9miQ5AQ6GmzFDLFa6R6HXOW3XbsUvRG8n/cy1rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1QsPp2T2R827UkuHUM0Hd+fkSaZ7sjMKFRuKioKVzE=;
 b=q/Ahbnq+2aP8WUMK13CBEvmFX1U+A73gwCsjoKQ95Hp5KiR2vstl+0Or6EeAlmSYG5He/9ryg80CNuQCLkopp7C8A4qNlEiv2+hlL86MzeNCHk1He26qoadvNOKrXcHM/cqj8xGJ8IPd7vY6KAGqf+P88G02hsc+oaJBjY38mtusbfiMhG2alDjHhj7xgEI1WRRopB5RxwGElXgjr15sGVy07qzeHHjyE8P4GIQFsUCj5953ngZSF+VCTGDNxlYDfTxKjJjI3djMvVCec5JJV1W2nkgqTshSbARjY1GFg1O+RaDOYQwOK4PUZW2g8F/XT+uD2PNvOOqKQShMGDcP/Q==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by DS1PR17MB7372.namprd17.prod.outlook.com (2603:10b6:8:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 18:02:15 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 18:02:15 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, Jerry Zhang <zhangjerry@google.com>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton
	<jlayton@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kees Cook
	<keescook@chromium.org>,
        Chris Wulff <Chris.Wulff@biamp.com>,
        Uttkarsh
 Aggarwal <quic_uaggarwa@quicinc.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stable@vger.kernel.org" <linux-stable@vger.kernel.org>
Subject: [PATCH v2] usb: gadget: f_fs: Fix a race condition when processing
 setup packets.
Thread-Topic: [PATCH v2] usb: gadget: f_fs: Fix a race condition when
 processing setup packets.
Thread-Index: AQHalafczYpH7+1HsEStkrnAIKpzKw==
Date: Tue, 23 Apr 2024 18:02:15 +0000
Message-ID: 
 <CO1PR17MB5419BD664264A558B2395E28E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|DS1PR17MB7372:EE_
x-ms-office365-filtering-correlation-id: 73662cce-5214-4495-19b0-08dc63bf824d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?e6vlqzkuwTiBczs1jxzZvxfaJ16ByrIkcgcD1VJ5hOnkR1eglk8wquP2OY?=
 =?iso-8859-1?Q?zwu6c4zqUJSkSKBDB4Hkobg8Pjh5UZlew01a5X03K0toRRth3WcsPu5XD6?=
 =?iso-8859-1?Q?m/61/+ouNQfjG5HnzJKxqsoCzaY4Mhc7tQHbSXvWFYCdwAyZUM6MCtEHw0?=
 =?iso-8859-1?Q?TnMiIW6OvH4SRuUwpyrtsQ58Q6mej3RaTop0Nv8vnuOVr0aq68etDrAGiP?=
 =?iso-8859-1?Q?1uk5/a/F9DXnVqBH5sNlfn0RtYpdhZ8wUbQ7kIhNGkz5D79bAihYbC1l7N?=
 =?iso-8859-1?Q?rrk1OZ5fNccFqyCctGo/pnULJMxXAHZ8XFFjmrP/MMiK75ElwqVQx8IJBr?=
 =?iso-8859-1?Q?ro52y232RNs/UymmwVDaElSI/+gDPy5od9ibnHpNvoPF8ytxgxipg+mclG?=
 =?iso-8859-1?Q?bOCpXVq5r/4BHLIZqVwpSKg1o0dIVKqfLulmeFmzXCr9m2KJbatNVH5z4v?=
 =?iso-8859-1?Q?0/Ry751WcBK5gfFGKWO0DfSF02ULspUIOgGxm0Bnz+7n3bfsqUB8Gh5DmZ?=
 =?iso-8859-1?Q?lym8WX7dVO7erZpTBf+5LX5lA8GEn8P9BYkF5uIqXeYnZhPtcYaJhUAvv+?=
 =?iso-8859-1?Q?a1mnFDWdiuRnjILcPWSzEv2U3FJiv6xmz+wFiqY/4l8fMhZFYf+hI2v4sp?=
 =?iso-8859-1?Q?qGQjB0P7z/lufX/l57oXFsuvj+eRP1tqkrh5iBIax+rXN4E61cOpYu3ys4?=
 =?iso-8859-1?Q?zeQxLbTbHEbzqgWDliZ6DJ8+r83gwoPCV6cSiCR0uLdOCqyRPSvXHv/K4K?=
 =?iso-8859-1?Q?GyYDqlf71zPrT6qld9/2rBGHjyxg9VE22Ta3+IyEIGLQWp3RTSss/+8LQu?=
 =?iso-8859-1?Q?KiWL4/0aARvFD2RQ1IEX7eG4C9G4U7ooESLvBhJ5GJUwV33uQoPDAq2/7b?=
 =?iso-8859-1?Q?afPpFH+l6G+hMx0P4KJPX3ENF6bhjwjlhpdstBmI4/KmUhhAdkBhzGJXBV?=
 =?iso-8859-1?Q?Na1mmMM7D7G7ALcBnCAHAX8z02NJ1sYFZ16cQEfMVZdgaDbQxS9Fhauz/y?=
 =?iso-8859-1?Q?lijApuopFSwRFCMELR4LgyuDcQbcoll0j3Wph3CNX1N3EZk/D6NZG6U0/7?=
 =?iso-8859-1?Q?8bz/T354OMMSeyoXVAAYHfbE59IG6zYPMvkCLatenpXowzZU5tiu90dF4m?=
 =?iso-8859-1?Q?x6rXqbuNTQqQaRSq8KXBrvX3qqwwhKVWCNFTg6O057zohfaOTE7PB8qXMQ?=
 =?iso-8859-1?Q?5neM3hsrPWlBSkC7Cu7Ny68HFzel/kjNJg9u54hzcOaa1TKTqhcZAX8C1w?=
 =?iso-8859-1?Q?oVPcljMEC0TmfDGj+t795IyCP9tUCtTjrxWEOmSaw/WtvzIxa1TZsznDbO?=
 =?iso-8859-1?Q?4e/OmcKmGS1AzrokiSljrZGenbJnxcDaYudNu0eI8sF9grvOo61KDZzsgp?=
 =?iso-8859-1?Q?X3on5gv2OFQFDSK3nvfqHtFNIn1S5KCA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ERL7bP7ciUHxjJP5/dEM40taELAdhZoMpTlZP8jAB1YQ4NRFlO0Bf7okx9?=
 =?iso-8859-1?Q?CpdeoW6UH1YlZ795GduEgIkwrDt4n5A6rTOKpIwSMTOW8wc8bMNUan38Mp?=
 =?iso-8859-1?Q?dDrZYTJ9X+kC+teAuLMq82CC5e8OdKllPGaecE1a4rVrUzdwCxmcMUxzFo?=
 =?iso-8859-1?Q?A4RYkrjK664agyeaj5VHlMcXlPEK/CL+YFgQGWcrofClLv/rcscBn7yWIm?=
 =?iso-8859-1?Q?Cn522iz6ES8nKfwoaKssIUHl+OBR6/sIPJBhBErEYMe3L27eYeRe28rqbK?=
 =?iso-8859-1?Q?ory72RGBb/R4mHmhWJ2MuyFoc+SmA2hkZb3s6WvPNjQUOQk1YySqqFEzSI?=
 =?iso-8859-1?Q?sDVojbTySCSHeKwzQgJlDaNeMSaTXwcLTFUMzRxvufeUb0NliYo7nLQq9x?=
 =?iso-8859-1?Q?YG7FYCQ6KuRUE78ZEy6J1CG8oTfcUlWoRzpxjQBsUoWxevygxUpJpKDeml?=
 =?iso-8859-1?Q?9xNbNo5izL1CLm1OlgFRO8/c1/dzQiySqYZnGqthdC0jUwi55JomRo0ORM?=
 =?iso-8859-1?Q?Wht1Cin2z/KSIQSRkUwg5YQkuByrKjes5vXw20Q6+5/e8xXjIXuNi5gVaF?=
 =?iso-8859-1?Q?teIzBsD/WxOJg0q7bbv1ae/qDJmarwJgfcmceu3Ai1sPylvVqA36jcjlx+?=
 =?iso-8859-1?Q?O0GVqWVgVJJI6VXiX7Zi9AVd7ZMgfNVL41rMc07tKYnlwrCvnXZcEfgB/A?=
 =?iso-8859-1?Q?h4as9o2bNApxdaD7JY1v1wO3JQvvXlvFDrvfyS3RX34xffA3weIW3I0HWH?=
 =?iso-8859-1?Q?b1thBWOqjhSK9Qv37pHLLSl9AoCvOReVlb6kOPOSzWHdE8LPpAnh/fdfr1?=
 =?iso-8859-1?Q?wuOdX0auwxYUHbk+KEGRi7MGsx49xh/aMTK3FUF5HkctSnLj88avGPShl5?=
 =?iso-8859-1?Q?XIJIuIaZJG7Vt/UdfV8zAX9wDVvIsaL/JsxAbZZa1taF0133pBPJf4Ms/8?=
 =?iso-8859-1?Q?XzITQPVYIspNUeGytE6Z0EJ/IS07rbI1c+dEaefjDhLqpP2iT3mMQeH9RL?=
 =?iso-8859-1?Q?tZdHRr2QCqEi1XRMukaesoT/Zqtbe7+mrvXW82hntsBMYMkIYN6MXF8EcV?=
 =?iso-8859-1?Q?jtGqsY6Ay7KbxnW3b0lf0Hp4/s4shEfXk2O8nkCK2Duj8jZZbTQPEpN82X?=
 =?iso-8859-1?Q?+DP6tsbZx+IEK/CN6IOEq8DTSiBHyii2XhtA0Ds5dNvUITsYt9pz2QB6ON?=
 =?iso-8859-1?Q?ri60hG452dRzGT1RFgacGO5QQ5u4vuWZBXJry4F8jGC6WLgZvqkPLe0aBh?=
 =?iso-8859-1?Q?23AKFoQ53r5jjBK/QlLky+x5esv6XiWWVNqYIWpGErChns13d60N43z+ZA?=
 =?iso-8859-1?Q?1dBAyIBjUh1h8IfD97TM2laqdyvSstmNZPyIfIrsjIcVFd5jvhpREJsDw0?=
 =?iso-8859-1?Q?ka6HZWBqNibNWlA8g91WgA8L5aSksuodD7mPO997edppRdWkn1EObdLiB7?=
 =?iso-8859-1?Q?OM6LG0tQ1WVUwm4bCAt2Q8MdfzPxIDYp8CU4YnFgCVkN76QGisJOXN6SIh?=
 =?iso-8859-1?Q?3/+GoDN0z4vfFf5XF0k8wtx6MgxFdtxoyAeJe7WDMPdBW7l9r75jOYGZ7N?=
 =?iso-8859-1?Q?Tmo90DJs4tzrcmYgxDHLS6IVZUBoCLieOhF6V+XLcybYOL4niyjuckg91g?=
 =?iso-8859-1?Q?DBbxQ8EuMrmtsLyzNdNg+2rjBOyeKd2SbF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR17MB5419.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73662cce-5214-4495-19b0-08dc63bf824d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 18:02:15.5599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37IF1sFu5johk6cYpt5+1qEFuv48wwpzTq8ExDBNlAZd34lKPkALkX0RbKWsIlwTqb0h7h67KyrHhL4moCfwzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR17MB7372
X-Proofpoint-ORIG-GUID: 2h1sFWbgM2KGY2qeadG8GfNq8zTC6iwa
X-Proofpoint-GUID: 2h1sFWbgM2KGY2qeadG8GfNq8zTC6iwa

If the USB driver passes a pointer into the TRB buffer for creq, this=0A=
buffer can be overwritten with the status response as soon as the event=0A=
is queued. This can make the final check return USB_GADGET_DELAYED_STATUS=
=0A=
when it shouldn't. Instead use the stored wLength.=0A=
=0A=
Fixes: 4d644abf2569 ("usb: gadget: f_fs: Only return delayed status when le=
n is 0")=0A=
Signed-off-by: Chris Wulff <chris.wulff@biamp.com>=0A=
---=0A=
v2: Added fixes tag=0A=
=0A=
 drivers/usb/gadget/function/f_fs.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/functi=
on/f_fs.c=0A=
index bffbc1dc651f..8d72acf9a760 100644=0A=
--- a/drivers/usb/gadget/function/f_fs.c=0A=
+++ b/drivers/usb/gadget/function/f_fs.c=0A=
@@ -3803,7 +3803,7 @@ static int ffs_func_setup(struct usb_function *f,=0A=
 	__ffs_event_add(ffs, FUNCTIONFS_SETUP);=0A=
 	spin_unlock_irqrestore(&ffs->ev.waitq.lock, flags);=0A=
 =0A=
-	return creq->wLength =3D=3D 0 ? USB_GADGET_DELAYED_STATUS : 0;=0A=
+	return ffs->ev.setup.wLength =3D=3D 0 ? USB_GADGET_DELAYED_STATUS : 0;=0A=
 }=0A=
 =0A=
 static bool ffs_func_req_match(struct usb_function *f,=0A=
-- =0A=
2.34.1=0A=
=0A=

