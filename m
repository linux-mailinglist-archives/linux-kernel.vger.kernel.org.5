Return-Path: <linux-kernel+bounces-161100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682B8B471F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 18:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C5CDB21961
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00321EA6E;
	Sat, 27 Apr 2024 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="Kle22Bzk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b="NwLgmS9l"
Received: from mx0b-0068d901.pphosted.com (mx0b-0068d901.pphosted.com [205.220.180.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36DE566;
	Sat, 27 Apr 2024 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714235259; cv=fail; b=TbOlsAPhee8kRWQoFCxFwK91BZ36BeziUCaQ023tXXPWeeSH65q4v3Tkb2uVy/oDyxmrlbEOllHiSCH6eWeJoeBlEbwsagUpfrFvdC6OY7rt6CxGHcE/4lJtQ87cQ3TFC4KeY39zuIZ7VBHeqtAkMdC0Ae61zNnmUsgrTIyByQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714235259; c=relaxed/simple;
	bh=EUhNUMJ3XBBo/qvFwdIqbe06MoyciVlslK7Hc0yoWzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pz+BUKshUmX7JnlXmyzn1/ND24YV8jwWyZ+KL5mTnHs+cwp9RftboZ2p5o+jSyUXKj2Ov+6GDFK13BrZC0Ci6l5CB8usCl+jrTxsQYG+DlvIy79sFDEKMC+gfcCxRNzCD0YI1GW82bPmhbymBmbL3pMnFGaGAUYxwl/TsMCe/MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com; spf=pass smtp.mailfrom=biamp.com; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=Kle22Bzk; dkim=pass (2048-bit key) header.d=biamp.com header.i=@biamp.com header.b=NwLgmS9l; arc=fail smtp.client-ip=205.220.180.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=biamp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=biamp.com
Received: from pps.filterd (m0278265.ppops.net [127.0.0.1])
	by mx0b-0068d901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RFRaHI011554;
	Sat, 27 Apr 2024 09:27:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint; bh=4e829LfSEjvG/11ElqP3vVjwxib7IdxH4d93aEadYwo=; b=K
	le22BzkDK+tIVh/wTq8zbrHaMXYqqK4O6EfXfiYk4gk7DWjrokxz0L0iydOqABvY
	vfkGgGfsGcGpgZeoOPgRTB0lSzNM1hiHWO0ifAcBMGAfz/5847T6Di6em4NAZwYV
	dtoG25wXGVaSROXgdjK8nN9rpMNmAo2UMDrxPK8yjS9hS8fET51Md3x5NVaxksGj
	20aSHIwaf79TGMO0cmTegoD6FioOmp/DQGEKJZ8EoOscmqrGXI+g4P1mpnLwmIqK
	bX4MgW8en1jchSll+lp9+fHnzJr0KloAKRoeoHh81cQN/ILw81tK6dtJ7jZX7YjJ
	SAeUb3sMzg0dMK3YZfQkw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0b-0068d901.pphosted.com (PPS) with ESMTPS id 3xrx2x05kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 09:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0XjIEykWObh/LekqmI7TVRI+9pjraMqovncxAVXr9/9QJ0AM1ZwDYLBzx77k6tTD+mbJhQMJQ3MyKjjTd71/msq70bNqSsIjNEY8PdfHn5aS0trFLYhAnTDxfGrO6LUovYgtpVpSNbP4O/hk2h1MSFCIgKgyRFVZ6WMkB7rt26Z1wRLbG1QPj4baSIszCe8lkKgLPeo2tYLw87p8Mk/Hq5M9NQkI4V59BmiGIWFYbq6c3g+30gQTJQsQE0yFQWYeMwwAxocYdreNica6Wlmi5sRBCrQURe8hh21kgRWyp/FN6UwC3NJSxA1+/8TP0AN7Td1OgdS/6x5mat81s/HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e829LfSEjvG/11ElqP3vVjwxib7IdxH4d93aEadYwo=;
 b=Q+KvsIQBDQ4S5bN43biQ2xB6pXiQQ/CNZje5t4GzAVX/9/WCUoPk3EBw8c362GwEU1ppWvrJJ0TTin9RNrtvobfqjVzLTIh1BxrmlzxIljQaFnoHUyr6TNEgzrwBEp5djiHCgEQ4XbzLyDvTXF/F71m4HfdxlX+P055URLIZoAs6kwfQArBMnivJLPFQe6+Nwz5MEwQYCILy2ZylsRq1drUyrf71kICJUf9A9k4zi+oRf/MsAGs6t3aKAb+LJMWdZAJL+dfa82bcHxhXeOhKaxlRor8GiGrmOJop9X/NYVc+/MavJzB6/5G0/lfS5eZTQOOpLB25U9uyqlRBLzkNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e829LfSEjvG/11ElqP3vVjwxib7IdxH4d93aEadYwo=;
 b=NwLgmS9ldJKIckUTmCkl1xCmypCDzoVjuU8RgHg0xfYMpIY2e2y4vUzd5Rv90qZzV4nb1SnVAm0ylLPXKRQAw/MYsWgvwYZ4cDHIGQm2tlQLD1er0WMFpcy81bCyS3TJpiOhZufYP0++jwtmQuPE6liuEiBCQoCd1tuW1X1MkYQwUNpzlg9fz5gnpMaVr8DPQtqRcSBaR9mWu7bsZYRXT+ZgZKabK/IfGzR7xckoHdaBNsJ5j9YXFpOnEpQkiuvvkRiirO53Cm3DYu6rVkp4X6CwCZCfTIvDHzuALKu9K46akJ5dG7XNatU8XgUXiemuThwdE1tG8nzqkXmkulTC8Q==
Received: from CO1PR17MB5419.namprd17.prod.outlook.com (2603:10b6:303:ec::17)
 by BL3PR17MB6162.namprd17.prod.outlook.com (2603:10b6:208:3be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Sat, 27 Apr
 2024 16:27:18 +0000
Received: from CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555]) by CO1PR17MB5419.namprd17.prod.outlook.com
 ([fe80::f48:ee61:a81b:d555%4]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 16:27:17 +0000
From: Chris Wulff <Chris.Wulff@biamp.com>
To: Pavel Hofman <pavel.hofman@ivitera.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Gruber
	<jimmyjgruber@gmail.com>, Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Topic: [PATCH v2] usb: gadget: f_uac2: Expose all string descriptors
 through configfs.
Thread-Index: AQHalYdWgtu02BG/fUykcYHBF1kPmLF1/Y0AgAAPjZuAAQFjgIAFQCVi
Date: Sat, 27 Apr 2024 16:27:17 +0000
Message-ID: 
 <CO1PR17MB541942196F9A2F73CF8B5B14E1152@CO1PR17MB5419.namprd17.prod.outlook.com>
References: 
 <CO1PR17MB54195BE778868AFDFE2DCB36E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <c9928edb-8b2d-1948-40b8-c16e34cea3e2@ivitera.com>
 <CO1PR17MB541989646698286B2B13CF23E1112@CO1PR17MB5419.namprd17.prod.outlook.com>
 <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
In-Reply-To: <9b40e148-f3eb-f8f5-bf2d-37a0a0629417@ivitera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR17MB5419:EE_|BL3PR17MB6162:EE_
x-ms-office365-filtering-correlation-id: b7535829-20d8-4409-81b0-08dc66d6e7c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?Y2+z9nqJQo9YkAzJ9hDR4ciXHC1RiHF6WZZTPUh2prtdK3uPC7wAAzS477?=
 =?iso-8859-1?Q?1NWbJgp5KPW2fKy+ZSfy7j4uTe1U/4HF+BpTgUCuK5HqyrMCDy8F9mZNaI?=
 =?iso-8859-1?Q?pU7YNnbc4Q/EQMc4poXVkE+ATylRkt70yuN6sOWjBCnWdVnKCzGdrpgunK?=
 =?iso-8859-1?Q?b4jBbCbq6oY7aeXls1EEMJbX9mO4p0eGJCeMOtOYiy1+A9SxaceT43OS34?=
 =?iso-8859-1?Q?EfrsygSUHZj2vYzxdBR5rqtkKpDoaLJcNWZv45ThjkTyZteXKk/GwwtTnK?=
 =?iso-8859-1?Q?avjKC1NWNLEWBwsKMz5Ec+9qgvNzxgHkLLJuO0z8UucujINnl8hnTS1UzT?=
 =?iso-8859-1?Q?hrv/wCQi0Rr80ZuAApR2ZFyXwaxPzzdqyaM/CDHY9HLdqIclcBmxkDCq5l?=
 =?iso-8859-1?Q?fmx4KXmEdTnJBu3ZtvEdGt/t/LET/Y1zmQQZSFu/eY5HMpbgKYJu8UYXOL?=
 =?iso-8859-1?Q?CDBElXsNYoO54AhdyzmwOn1m0YO/QBgQnFGeVBG+Rdf7gaoCnAYKMtBnti?=
 =?iso-8859-1?Q?ZQ3kGELyvF+9ALfxbh4nfmCwZWZK8Rh5oSKemKteIXTezhi40YhG7v/zBQ?=
 =?iso-8859-1?Q?kTrImFm+ulYWTZL7OHTF6u0KkAhnKqPqHogOkCebTc4aulag1ac6C4Zd3H?=
 =?iso-8859-1?Q?T9gMLC7zg/11KfGtmALZDx+JlEiF0YLAgXQyJiecLHqzb4RQGT2i5r+fdE?=
 =?iso-8859-1?Q?99z7y1Rl2ns8/P5OeLjv/vUyiVV+sXCcZxyKcoDK3JPFflc68h8V0zlR2L?=
 =?iso-8859-1?Q?dTQF2dlmwoLrFiuQyWQk4WisD2psK8M5DHbTkrN7aRkpcCsYXgGkFPxMQu?=
 =?iso-8859-1?Q?hQ/VExy281TyZ2TG62IgKMEv6/T/Piq+NwCYc4KBevxOXmIrxyENHS65yX?=
 =?iso-8859-1?Q?PjYZu0qieZxIpEnXscDkIHong6QR0En+Wwi0JPS2GNG0uhf7dJgGI64ChX?=
 =?iso-8859-1?Q?pqlJOOWqOAsmHOvC5Ncoi3VItKMm8bwg2M+nuCjZSIyHuZSdGzAo86DRvO?=
 =?iso-8859-1?Q?C4fYDhlDU5Z4xgjYIA0PWuWd+QRh2dyK3Ao4LFfvBqU1UsKZ7cPyFxYvZW?=
 =?iso-8859-1?Q?vQVSLm/jBqZ7qgBEcrSomwxnXvEIWv53RAoH5mFwIrcecYBvVmfI4j4wnt?=
 =?iso-8859-1?Q?FlKYNC399Wj0gQynw6s30V+WHBkJi9noA8t7ObdkTvkH6BcnFhvzurKGmc?=
 =?iso-8859-1?Q?r5r2DP55+R6twyxuubQzMfl0VDtKxIG8fn/FLReygX5NfhtAsuqYzSGc6V?=
 =?iso-8859-1?Q?UGQRwP7Q6YhXOcvPBRRZBCvcYoi5zG/Z5+do2oEBTzVbiTcYo7XpIBbIar?=
 =?iso-8859-1?Q?t5N3gZvRfNUu9QFBflx5MkqLZzoLgJz8G0bcd1K1tgyhU31GF1GD5SC0Hq?=
 =?iso-8859-1?Q?S5mQcQzV/EMBXxOlAk9bN+Qs3x/UsG8A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR17MB5419.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?sqbym4QBpY7GfUtwF8iCtWLafL8wJeLu1Q0xVWb/bG9RyYKRSZ6T32ArwA?=
 =?iso-8859-1?Q?j2qeTI/VO/PNK6P5Fgf6hhuXVRysudM5fk6lp5vWHqyyhnfwU374432NE5?=
 =?iso-8859-1?Q?Fb/7Bu5Bh5tgGFMGFhaCz5APh1HMUKVlRCuydkTwT/zoPRut/pNszctkPU?=
 =?iso-8859-1?Q?eKDEJQVKC/Wt9GLN4HTxrtKFpdQJhGMuzhOYeCb+Hf2FH+fNL65eVqzJzm?=
 =?iso-8859-1?Q?2xpFVcwvNWqZ5hnGVixO6YZNoMGzZocyShW68Gp8VTlpjhxi6x7eG3TiC4?=
 =?iso-8859-1?Q?xQJuIfj6buea535QaH7VTicOdCQmpV+eYhkyxO3RSycBVysy/3rk2ea+TI?=
 =?iso-8859-1?Q?1Ld9DkKzcLtGd+hQ8RgJ2CBFq9jPbWcPbRfAszJ2gLoWiySeNzGXYSbNDh?=
 =?iso-8859-1?Q?EYXrn6+HL82RhcKUerYYIfvzA2kgUWWSih6bW574j7EMsL8JkSkDqHkgJI?=
 =?iso-8859-1?Q?T4nE2+gdqDjAcIuxSxxQCMeUTQhmq5QfF+MR61sxB2I4IW3n3vo0u/K9U8?=
 =?iso-8859-1?Q?shDAaYrzGIKJRjya7Yhk86kW8FCcElT4T6aP/tXJZXTJUsFgh3hLaGke/K?=
 =?iso-8859-1?Q?lsfwut50jkOpPHGuDMn2qS7g39FVLYcR/cCMHaz4cOt2Teu6mu8lmT8+l5?=
 =?iso-8859-1?Q?FC5etcC7qIWhVcP2PLzh6csN8rUYlcjzjG9pjnKqeCIwjjLWmqGzSGICVD?=
 =?iso-8859-1?Q?D/dHMt2zr6rIad3Dfq3dftL+CjudQdC9T+Tzq3M5B/swtj1L0HmijCR0Hl?=
 =?iso-8859-1?Q?LuRMv9X/namIrkYrSgw0rBtoE5pZw/xqyhjGfOX8imSSJqaHRfzHtxa3vB?=
 =?iso-8859-1?Q?OKx+MemBUK1SdaWBQ9z8O9j5ldYxpuTFutfLvKFj5PFwkSib7O2d4GtJpe?=
 =?iso-8859-1?Q?p++GCFJTkNMNrRLkfwXtlAZxuFYCPhMxI2ixzMoKKtgNB8ySjFnS+swDq1?=
 =?iso-8859-1?Q?iYS3pistoV+MpNKl1+xmdbSzdUsuKEey5ytY0V19nsMtV8fbrqkLU91n6F?=
 =?iso-8859-1?Q?p5WCdVYJZI/pFYtFVGambHkU8neHYaDKjhTZDDmOWZRzGKQuyFsjg3zfZt?=
 =?iso-8859-1?Q?7xeT589ZrmEVudPwqbUjVjUwOo+vDh7isdBA5eeJYcRD3psNQLXuy/Avv/?=
 =?iso-8859-1?Q?kI3BkAebhBSVtbHQQdsHnzKk0Ca1FKnzVQA5jXsZduYLb3yvzkKcL02/Nc?=
 =?iso-8859-1?Q?k3PDo2FwiJQ3hVdx565B2JTgw/BjZw9PfbYiM9zCxapKn2PKXK3TmBVvZQ?=
 =?iso-8859-1?Q?5oMVKoW4phWL67HYnrsBQnrscdlB4UNcehCvpavYXebnRluOMRGXvQz83S?=
 =?iso-8859-1?Q?ab5iHvHIN7uq72eCBKLtcXhao/8fkGZLof3Ov3mxnUml2j4wesEgoMnj2J?=
 =?iso-8859-1?Q?LRiFAVtcHXrbhunYYio+M9o8aV9l4mfv5ijqhHOZu/V9tKdWow2MmYE2m0?=
 =?iso-8859-1?Q?Gee+BZs1NUR8nC6TU40DNeH6JS3NkBpALJ9arPX4DrNhwTAmlC0BmUK08Z?=
 =?iso-8859-1?Q?xZ7pnSOlc9xTVh6+sfUW16IZqCjjPcSSSipDbjIPibT2vfJ3NAFs4a/Qlz?=
 =?iso-8859-1?Q?s3Rrmd3Lom5KXmjj8txMj0B4Tq/ab+HUETB5T5ycD8HiG1/2qJkSHqBL+p?=
 =?iso-8859-1?Q?h7MQxX9kRcTwkvxhCAnubMfqwR/w0mbq8H?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7535829-20d8-4409-81b0-08dc66d6e7c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2024 16:27:17.7003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNRuO/a3ZnBtNkVr+Ve7tEOdje+mE4juRYF12Oa6DVIIOeQ2hOs9ESNr4C4kA0tK+b0GkeueIvIoWng80Izf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6162
X-Proofpoint-ORIG-GUID: V0NyxM40hZH6-j0frNugHiPLXb5cOO5B
X-Proofpoint-GUID: V0NyxM40hZH6-j0frNugHiPLXb5cOO5B

>From:=A0Pavel Hofman <pavel.hofman@ivitera.com>=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_it_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback input terminal name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_ot_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback output terminal name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_fu_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 playback function unit name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt0_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 0 name=0A=
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p_alt1_name=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 playback alt mode 1 name=0A=
>>>=0A=
>>> Nacked-by: Pavel Hofman <pavel.hofman@ivitera.com>=0A=
..=0A=
>If the params in the upper level were to stand as defaults for the=0A=
>altsettings (and for the existing altsetting 1 if no specific altset=0A=
>subdir configs were given), maybe the naming xxx_alt1_xxx could become a=
=0A=
>bit confusing. E.g. p_altx_name or p_alt_non0_name?=0A=
=0A=
I've been prototyping this a bit to see how it will work. My current config=
fs=0A=
structure looks something like:=0A=
=0A=
(all existing properties)=0A=
c_it_name=0A=
c_it_ch_name=0A=
c_fu_name=0A=
c_ot_name=0A=
p_it_name=0A=
p_it_ch_name=0A=
p_fu_name=0A=
p_ot_name=0A=
num_alt_modes (settable to 2..5 in my prototype)=0A=
=0A=
alt.0=0A=
  c_alt_name=0A=
  p_alt_name=0A=
alt.1 (for alt.1, alt.2, etc.)=0A=
  c_alt_name=0A=
  p_alt_name=0A=
  c_ssize=0A=
  p_ssize=0A=
  (Additional properties here for other things that are settable for each a=
lt mode,=0A=
   but the only one I've implemented in my prototype so far is sample size.=
)=0A=
=0A=
This brings up a few questions:=0A=
=0A=
Is a property for setting the number of alt modes preferred, or being able =
to=0A=
make directories like some other things (eg, "mkdir alt.5" would add alt mo=
de 5)?=0A=
The former is what I started with, but I am leaning towards the latter as i=
t is a bit=0A=
more flexible (you could create alt modes of any index, though I'm not enti=
rely=0A=
sure why you'd want to.) It does involve a bit more dynamic memory allocati=
on,=0A=
but nothing crazy.=0A=
=0A=
And second, should the alt.x directories go back to the defaults if you rem=
ove=0A=
and re-create them? I'm assuming it makes sense to do that, just putting it=
 out=0A=
there since my current prototype doesn't work that way.=0A=
=0A=
I appreciate your thoughts on this.=0A=
=0A=
  -- Chris Wulff=

