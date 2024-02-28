Return-Path: <linux-kernel+bounces-84861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2804686ACC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B4C284828
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F82C12CD91;
	Wed, 28 Feb 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="TXw3svXs";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="TXw3svXs";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="TXw3svXs"
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2124.outbound.protection.outlook.com [40.107.23.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103F144C6E;
	Wed, 28 Feb 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.23.124
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709118824; cv=fail; b=X5sM6FhPe1zc1W0VzLkAXluhD8upSQd+ziXcrcitKxkEtl90WODHO30fkaCrXOngE2TC4GfT1Fwdt6U67qxcSC2vYnASxyZYMyQecbkGwLmTGR2w1lVChWnRhNv8pNFulWgl1YeqWs1CUdODkHxhw0bQ6XR3/F4xhiGvqT4pdbs=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709118824; c=relaxed/simple;
	bh=3h/3GSGk11B5NwXW9Th0Db5pDGWDLFvEHGHP84VJKuU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JcXvl0TSO6u4hjNKS3tZCDKa69WhAs182kXtqX2OdPR/m0e3luT2oZ0Jj+zsLpvFsp6+NVcz+iBQ0Q+XgvseI4tUOSQqmJSSeEdnAiyL4w2mMNq3SC7wYDQV4pJPP/zZe0IQjpQ5Vcz+PhILf7xSaRbglz3418JrMzE4aXXcvFw=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=TXw3svXs; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=TXw3svXs; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=TXw3svXs; arc=fail smtp.client-ip=40.107.23.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=knvdzOjEN2qpqokKZO7sVTEQ7nyrzhHUfVXciCHrZkTgl1TTba1GcBudBKVOVzA153eBEff/gjxjcyxksFPC2ieFyv9JZrYduL/vkfBsQ0DXaWwAiZ/PS54aOQ3XdS/Fiq7twXGXJ9XnslTjEbKiPlEOyNxennIJ56MAljJMWAlIQaiiPxHeOd9Qu0779vKPZ9i3oGlDbFTeqWnSLoX2Q8DKEjFMo7w1Hgk1RBUKkvUxKjfbNIwz7ufnvPUduAUL0iRSDRrePKgUnrqiy5i5b0OR7zG2gcdhJo1keeStGBxxPi5GticXfuAYGA9T+0/CJtRCmtq3b1oIQKgg+h9Cdw==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=YZA16g7Qn2gSYVHzuuzOeLw96lC4JBvdWR0n/QlJzGAt738ij+UR37N3DXebJ3c27Ojz9itzY/71nmTx0rx4TeetPj+usxLk0FcELhHnNfhSxKPhaMJ0OtCzOlI5Y2w4y3aUcbVlg1MRDOqaJxrC2mlvy0AtzxjFmCqIz/qMF/x0PV3jtHNkOuvLIxchbUN3DWZ8gKgL9/jxsuylNjUtWl75AgN+AYUuMqvWhyU28y7iBb+sbx1NpK+4rKJWSgw6UqoRHWbKlLcIfggPQC2OEOgVIOigH5IMhwf0n0vy/JhSk+f0EMWe43zA1m9gdJy1fY16KRcwodgONo1WYONIWg==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; dkim=pass (signature
 was verified) header.d=duagon.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,2,smtp.mailfrom=duagon.com] dkim=[1,2,header.d=duagon.com]
 dmarc=[1,2,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=TXw3svXsA5TRxcH+OGrzQYzQ4Edg08Jv59IJPpvsgHtUUpHCRMR9en8MocFaA5HrWf/07I0oP/wokaL3DgAjtLdqRnqXf1UwRuujn62Kv7dKjXB8q9QSjui4lpTl5oiKGwDqOdRnDa9z/kPqbO+8WspH1VtaNbLWz0XUpaV7qwE=
Received: from DUZPR01CA0340.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::13) by ZRAP278MB0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:11::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.40; Wed, 28 Feb
 2024 11:13:36 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::f7) by DUZPR01CA0340.outlook.office365.com
 (2603:10a6:10:4b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 11:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:13:35 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4TlBYV65YvzxpB;
	Wed, 28 Feb 2024 12:13:34 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Wed, 28 Feb 2024 12:13:34 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=M5qWTvdgBO8V/DiCLki4LV5uhoUL0Y6p6ME6+7iOpjXVi15zrJeNCPucI2QjtugVSJbEs9oKDXzl1I2sgbwfwk45XqXdhlNRY/4pAm4Y1cn/qQwbSYbiHJ9WX6kVm21bqQ8vv5SccdSLzsO6maFi/y6Rl37vMtVRR+YShvR7xWUlVhjvH6Fu14tdKbDkd3ugCU49Eypi4S5M/b6q6V42rS27XXVwQSUrcWlg+aNjAQJy7drXQxBW6ma15UldhEA/IlOWFnhzGCyQTUYhyKcNyVQIQpPfZ8srlWGAZbd47KZmaK5u1s3b1mYOptWfbCTvDE8tWthk5enirolXkwBsZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=IHggVi4YHSQCL57v0Nr+FQK8oVvEsE/uKtYegpsWGfMW3hg/Ic9ZY0FNRsWNxt8Gl+rdoIvfJ/oDWtcK9IpGAhKxBNFyvBb1MHWBmmRsnFnCOzh9F+MQL8uVF3cAzA/cPx7BuGSfcGJv8ETD13yjH2EKzsgY5YsRqnkXKBrKsv+5Tseu04t4dY5PeE1eVrE7GhWOuKFn6Mq1zsz4nwW3dVMOFEZuXxDvJcYqK5HjTe+oV+bNRkLfIGHXgN2qjYO22bhDsVaRbD2SmgSiRbjvd0ZTDfCQhNaf1aAVT3OLBwvvUf0yFwTOHgFp7Cu8HHgtMxMNPAGCV/BfrKVyWHsa4Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=TXw3svXsA5TRxcH+OGrzQYzQ4Edg08Jv59IJPpvsgHtUUpHCRMR9en8MocFaA5HrWf/07I0oP/wokaL3DgAjtLdqRnqXf1UwRuujn62Kv7dKjXB8q9QSjui4lpTl5oiKGwDqOdRnDa9z/kPqbO+8WspH1VtaNbLWz0XUpaV7qwE=
Received: from DU2P251CA0026.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::28)
 by GVAP278MB0053.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:22::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 11:13:32 +0000
Received: from DB1PEPF000509FA.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::e7) by DU2P251CA0026.outlook.office365.com
 (2603:10a6:10:230::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.27 via Frontend
 Transport; Wed, 28 Feb 2024 11:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB1PEPF000509FA.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 11:13:31 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 28 Feb 2024 11:13:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HO7JCaSik/f76lIvnzv/YvkI1ZSrueyWoL77+kTKxt+0GpLpKiuieU6uu9NJKP+7DetDfm0T3dXkx5GrIfJ2J84Lzrmk1FzZPEB1aPGAbqLU4w8/fFXBs3tLItRFQHO1Nv1cFI+Y7nU/8jiSEPGZGn/fr0tBQyuKoJGH78evX5brrzwrs9IONKe/GLu7V/KM/sLkxnDGsN5ZDd6UfAozERggcmFprXmWIWEn5D1Bq43V2L00Hn8s5Zq5X3PtqCLDLPQ9Mi7XmPISpDEW96mnG0rEWRYP5uCbaJSD2lwGLnSvaHBwbPrhjjUAAjwYXDqrhSxllZyPTF+qSN76cqp0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=FrxIEXl4cX0ERser/0BSdr9IRo5tqWXBhPFIg2Q1WZc1K4uUb2TwqFAMZOZPlH0W6w6C42nPTD6JLMs/xilj9pCa8q9vtLm6ELutKijBfdCOem6W52r6HjcK/A76gaBJY+eX1nCFDtVEdtuu5Oi2gIyBaRmOExIMKeZGGTGkaUVEbjwBLyB5LroQn58HYr+8ehyxFJt00S9Ig0pm0eYoggsJPueMX98JrU6MCWfXV6TZ9Oj9yLNzC3f9Zku+uMHtk8tsjnkb/UFal45bBjHX8loX5MS/Ly8dwKj+Q2anduwmTf/XPmu8F5JKGnkTkv21inZgi037cggMXucoEEmvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im6Cr+mwv3kcHtr4ITSbustqRkCBq88rUdAlzhwNKWo=;
 b=TXw3svXsA5TRxcH+OGrzQYzQ4Edg08Jv59IJPpvsgHtUUpHCRMR9en8MocFaA5HrWf/07I0oP/wokaL3DgAjtLdqRnqXf1UwRuujn62Kv7dKjXB8q9QSjui4lpTl5oiKGwDqOdRnDa9z/kPqbO+8WspH1VtaNbLWz0XUpaV7qwE=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by GV0P278MB1188.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:5a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:13:24 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::54f6:efd5:f77b:1f58]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::54f6:efd5:f77b:1f58%6]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 11:13:24 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "s-vadapalli@ti.com"
	<s-vadapalli@ti.com>, "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
	"rogerq@kernel.org" <rogerq@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= <Jorge.SanjuanGarcia@duagon.com>
Subject: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add IFF_UNICAST_FLT
 flag to port device
Thread-Topic: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Thread-Index: AQHaajclGd8wDFepREKIl/wW2KxXVg==
Date: Wed, 28 Feb 2024 11:13:23 +0000
Message-ID: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|GV0P278MB1188:EE_|DB1PEPF000509FA:EE_|GVAP278MB0053:EE_|DB1PEPF00039231:EE_|ZRAP278MB0047:EE_
X-MS-Office365-Filtering-Correlation-Id: 662b561e-d0c2-4b7b-c1ae-08dc384e4e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 ZIXQc7Z63QAmTAQ8OfE0hcZt720D06oi0uuCAJjCZM0POTY+915/kp6G6LYz4H33AaDWGE0yoimRFm2sY+hvFCfcK3F+QqwUBTvMefi8IQAZVr7OnhzwZgpcI1hol2FXTQTL7yz6q/pb43a2Ud/sWq+gj7F8C2Z4lBBtvwcu5PCsrXtb9q0l0XITrr71P/z0s6xissPlfhgmh4WdgalcClT5KYg8ianrml//aENFZ9wTp0uxzLaLAdkRIz8cP0t5lebdUsmUaMrEhEL7RDR3z3IK8eRKDC0rI/1eC1yQBdiiNBKnEl5c+Rleoad9tyXj17mAMl2LyyEEa9sL2fBRv9nOEwO1QiBK3CvhNSm+iGXdswrG4WYtD0uYuzBwpYQ6xNpzmmGiOIhjOX4bD5DvPuamh0WUkp4M448HzY9ExcGH4Dya59vx3LwfSvIAII8kTyYKTY8tm6VjPxwp+XuQsnQYhUefNbpWZNTLgOHdl5nODmq4UNx9okBDQ9eQjBNtXaH1pvklLtiFTkiKpYrVdu7u6mrklKNuQgC4pmpeAWVWGf9SRad6+5sxQhz/q512YhGsO8oLOt/yx7ut9kHoLHnjHqQwN+fUikJX72OgysVlMs5uPYKt8zCG4oUtMUaFRCa5JLFk9CXpcugtWQLy5zY9aZ70a9bG0UZhwYo9gsXE7FTW+NKzMqie7L3xnmXH1qd4n5WAqXuOnKGPNg/bTyxdaGWG6n5DYhpup/JjNLc=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1188
X-CodeTwo-MessageID: 457a28c9-e515-4005-9cfc-0921110914b9.20240228111327@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509FA.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 7aa60960-4aa3-4cd4-732d-08dc384e4790
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 H5Nho7fHeGRbWsi8jTq+bSym1Ezgo1Es8xW/XbIPIzIVCuUqdrYVFvVpjbD/64BTu3cX/DQQIOEWf+mM4hVYjWaOzrI1lFSbITJ8g0pGMmEflm7XYRY9nkdR1R5c3lhZaEhB1ISX0WZHQtuJ7NVS88ei+z5eNdbiGwTHJw+vLyTq6Kccmevw8De5cT5t7G4jzuwqdiJZjzwChIWVvgLPac+ls4hIOu2UzmHPLvfEOWt5qpvyjPuYtv6/R990pM+r9JEnbQyXTKkjvoaUGJhh7EKb65Jctb0LZviVhEy2856gdUhdPCrYVQA3W5jILrv4y6VtKAngmCJ8Eq1MXD7PDTxuYdDM2ZimYWLUMwXBIUDXiHigBbxvAfGM/N92zkNn51zhMAgmdFhVu9kAo7M4VCqsRYCF88pq8aHgYtBgeW2v+9QBY9n9n8LISHGKiWU40SziF7Vskd9rSaPH4q+Ed11lsfwlbEscoZRjuJYyMTSnu+m5vLmT4hqhYuSQMm2ItoVpz3gIgiu5gfatTz51jPNgNX5ZpIoFj0suIAlim4+KDK+b5uR0+qApotjd2uOhJejJtVz4HtVM8Ek5ViNjDS3ak5+OEkfGWEEWvsaXe4G03bsH2p55f4r4iKG4AQv6uoSuS5ToaLHyFe0SCJfAYvrOHwKYy5/dqLTtBxJjZP/9ic53CCZwUfDCNhXPnPj7qKW6G8Hn1/fRtYZLxdKbSc1cdvTqEod5RPzEIyFcqRvvHQx+PbpxCKYS7JRJo0VV
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0053
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b5ecc03c-e815-4d37-d8d4-08dc384e4c38
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5t31VYwZSg2K8A897joh7nbv87m+XV31fTWEt6wEdkHtRmjmJfdhDFp4uk8WMTk8D6BRRhpx/IBOn2oETWLecLZXw98pq0ycOkWpyqzabJSWUfC/NqG0aQxRf6zHR3ucFNMrqhQbd9lRx6PuZU9vJdk05IQVgdVuAzWw/vZPcryc+j6Bg/Qci+Q06WqLLN2R/Whtr29wR4sxRGYXUKoGdgMGuMY91hYupig+cceTscvn8n6oqcGIMrFgYHayrh5rGeG9123qb2Oe9fJaFQqs6xeTqxgPNw2045aWdIcHkiV/05xNRPXktYdf3XwAxQFq/qpKZ8VEYAC97OyXnLMLSDpI4dludXxpoQwkUw05pzVDBh5F0WFNVysODEEJyBHaftYA6KNK/sSt2wQctsAnplec8TmB3ngbwkfrO5ctxpqr6yOZIb8fZfJu6CbNqpOEtey4R6xxmni2ZdawIcnFsy69gDLk9DrxBQRON60Zds0ubuNyUApybMi+RseyYmwfbWkE0aQ9YAkmFFstsNczkIQw80k+Qos4OqtUxAKDTyg5V2oc71KkpKjoXAL1tmomOAD0NIb3qscxTbNZDgpfG56G0pGwFRjSkEOo3Pm6lg0GVffT5x22izmeUdgpYfIDDcimxNRoADsX3oCR5l7ntN9yNXZLzALU1M1AYfP7yVovM4GmkowlFmsIJmCRfjbvJRLzUrJXnFtiggUGrZrVFWDTToL+HPfhv7wD3Cc3U/dUWyFt3f3YzHamUdFyZjQd
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:13:35.2792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 662b561e-d0c2-4b7b-c1ae-08dc384e4e85
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0047

Since commit 8940e6b669ca ("net: dsa: avoid call to __dev_set_promiscuity()
while rtnl_mutex isn't held") when conecting one of this switch's port
to a DSA switch as the conduit interface, the network interface is set to
promiscuous mode by default and cannot be set to not promiscuous mode again
from userspace. The reason for this is that the cpsw ports net devices
do not have the flag IFF_UNICAST_FLT set in their private flags.

The cpsw switch should be able to set not promiscuous mode as otherwise
a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
get an additional VLAN tag when entering the port connected to the DSA
switch. Setting the IFF_UNICAST_FLT flag to all ports allows us to have
the conduit interface on the DSA subsystem set as not promiscuous.

Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index 3c7854537cb5..a3c5360d27c2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2207,6 +2207,7 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common=
 *common, u32 port_idx)
 	port->ndev->vlan_features |=3D  NETIF_F_SG;
 	port->ndev->netdev_ops =3D &am65_cpsw_nuss_netdev_ops;
 	port->ndev->ethtool_ops =3D &am65_cpsw_ethtool_ops_slave;
+	port->ndev->priv_flags |=3D IFF_UNICAST_FLT;
=20
 	/* Configuring Phylink */
 	port->slave.phylink_config.dev =3D &port->ndev->dev;
--=20
2.34.1

