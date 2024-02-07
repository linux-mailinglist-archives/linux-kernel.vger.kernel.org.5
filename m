Return-Path: <linux-kernel+bounces-56579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB8384CBE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AB41C21D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CAD77F12;
	Wed,  7 Feb 2024 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="LjHfre/K";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="LjHfre/K";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="LjHfre/K"
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01on2135.outbound.protection.outlook.com [40.107.24.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4741876C77;
	Wed,  7 Feb 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.24.135
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313668; cv=fail; b=rVc1oSKRQI0dDBjjU8lvp2i6go5LDBVOD2b6TCOTxMHzNcd393fjRVBC06Xu7PpHhjBKy0F6nXjHBJJ9/S/uWvnS0uKu0Gyo2ZhHwrwgV7pljZLVOvJC0XmyHA/jR6etuSCybBcSRMwmnUmWZmQ/PFo3xqCpvDjuP7chVbPp3Fo=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313668; c=relaxed/simple;
	bh=7MJDk3mz237J72T1bWRyDwDqRbKi1LXln40XVrX4v4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GlawxWPx6NtuVaL1aGdOSIELXda8+9Qk+bg51iR6sR1g3oYRpyWaW0YiR12Q2cGtM8PplSEUNRzN5JYcVs4rUIVGMKIpQYN3gC/RR8l8WPXO618JUNbAhLscUDH3G+fYLwfzmyYZ/wnSdEvDYZ2bnbT/ki1nUShSHE6gfFw3r4w=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=LjHfre/K; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=LjHfre/K; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=LjHfre/K; arc=fail smtp.client-ip=40.107.24.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DWWkMHjGhSrBO9wqHyl/bjfZxrKY+fKV9O7/G8KhJEHkKiCZboQtmdXxWnfHqS7kd3+t5/mWqzlp2vzSkccDWKaZ8nktR5/CoHr2tr/7g6wlXbgGnLnLDrzpcWnfgSbgR3ngg31gRarHJsY8Gg4p7YOOfVAg0JjEjRHWoVNOHb+GR0uNb41jbSUFeBlQYJQUA14m4dKlEARsqgilX1vj0EmoEFKqQCXqNTw4Jh6rRgZV6+32dZ6PFXcguRNy1ND+YyMWvNvTP63UFzanRP3wjTXzokmcSSiP/BprWvciKzh7W9pVUEHd0TMRbgaKPafk+PstSw9wx3Sl2Nt9HsE68Q==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=fZfRnH759A2sjjrqt0AgkNnsXfvc/xOsn9k5HnyDoD3TRcn0a2jAdSA6oN90kohTzNN6j6di9gl0ey62VcaxgzzMBWv094p6IbQN3/YnDtdMZAW0SWgb5rZSvB+YbYZ8KesdEeIadQfTpgEMrnwFLGxFnw6r4Snc9+3T3E64zoqFmFNdz9CFdQXGF57N/fbR+NbBNHQaDCoMbiegrLZo77qpE4X9gqPsfkfSOXVQLK40V5uNkfJ5aPcf6TCKRXpSS2r2/huBbMdcinOFBvzF6hoUB7sK37Sb0O+xtUEWTSmlHeoPDfJ9vTA8jbV8N2CFYJoxwhjBrO+em0sr5LHpUw==
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
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=LjHfre/KyuQObIC+gqyKuLVFWUNKZn4tiStJDvIQD52zphRh0/3yUXbzEevYTljQgkVoeM6PVjkyBklskW6gvMiXUthVP7VULXZfOn6chLTSXqaxG/U7Trr5a9YfDpToEcSRmYniAh4Fo9kfR+b77vGsG3MqyRdkth0GLdqNzV0=
Received: from DU7PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::24) by ZR2P278MB1129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:60::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 13:47:40 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::38) by DU7PR01CA0002.outlook.office365.com
 (2603:10a6:10:50f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 13:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 13:47:39 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4TVLyy4YRkzxpH;
	Wed,  7 Feb 2024 14:47:38 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Wed,  7 Feb 2024 14:47:38 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=kdCXkYZUYSNoJgaEM41uh7W+0ExIKRtxA1aMMwc/1OBU4b/R/r9nFEwRaG874joqWnNTvYegyjQvAWsoBilfsz6ix96j5nxlOagiToVnkuSGzpz68mFaoPJk0OAJ5Frabb+ely3vbVB+wD2+TxGsRYavLVA853HxifG/aoA9E6NFWopMmXVtMbuv2i/JwTvOrXiS3hRYpeFTduvLuzQpK4YsujRGI4I8HMZUAlGfQcMQogbPMJ3SBg5XZj1He1JVYj+UUt5PPtuDvqi1adfbrnhaIJ6x8Bx3chHkcdc/CayROuN8Klf4CWWQtPXovtFUSNVgLnyjwBeFJPRARBCrnw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=JEJvK6vzia90sZEbUEpN9doWt1MCRBLTGnO92vE/nFE/GeJ6ZSoGiBtVY5ZU6JebNjtLpCqYC2AeNnz0m1rFOYf3rNqJfSTw0XuY9pDmakJ+5XQ7wU9giLmbbwLkL/I9OIGVvf9gQpeEWOnqZEgZ6HOz8oNZvmuMYk/co2UtP0SH4OgT3KI7jVPe0pPBMx5GNufRDMoNuq2Z1og9zDd3GeJX9FgmY/K1GhpH+JbuDtlojTlgxbZZhAEXoA10QiZHuddn/QtyezCsa1t0ANJxQDSJVVCN8inIyeqf7aGyZiXPUIM5qoVsZoRi/BwGyyKD2LuQHgD1iK5ozNc9EgNJMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.220.33) smtp.rcpttodomain=davemloft.net smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=LjHfre/KyuQObIC+gqyKuLVFWUNKZn4tiStJDvIQD52zphRh0/3yUXbzEevYTljQgkVoeM6PVjkyBklskW6gvMiXUthVP7VULXZfOn6chLTSXqaxG/U7Trr5a9YfDpToEcSRmYniAh4Fo9kfR+b77vGsG3MqyRdkth0GLdqNzV0=
Received: from DU6P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::14)
 by ZR0P278MB1154.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:55::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Wed, 7 Feb
 2024 13:47:35 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::ff) by DU6P191CA0024.outlook.office365.com
 (2603:10a6:10:540::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 13:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 13:47:34 +0000
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.41) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 07 Feb 2024 13:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Apujc4tkqsHFrVtWUMseT3t7Hp3C6n1Q773RznnLNUEJsorfRAITAvB94/qirs5GxVYzYohdJYZ31Tghbql5bLfoNCgbZ1R2y2IFY7LeD8b+DUbhOFLyVLmTqAgNwmjE/n7hiTy6N+IXUVvEpUy2jCY0EqqEJo1km8V1vvTmbOINhDeCMHBFlEmktD0aUHCiokIVeExlVepyjZKLN/WYo3lcEk626x75ULLny+fuQyifp1zXSIMGIrYc8CBr9WUj1c4fuv9LcfCmz3u5Kw3Mydf8e2hLORIqzcKPZckPm8NMErWN4sa/Q4QtQz4okBu4ObXijDMIsFdPTF40YJmHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=do8WjAAOVsZE9nT2fAKlLSQxyecCZxiqouuGHRB8f181yEWxJF2BraSvH93swNzikJszSvoZOGHPeHH76yLO+PGFm8jOreyj55LcccLXQEeW9768dw2Rz9TD4tXcaS+eXDWmeiyT/W8WS9IA5HDKe/PvKLHeiA6LzAXhyVOyjryGMZvsWEgJW2nMtvzZFjH0k4z7ekxWwv2KVhNYag0ZN1KENIUX1E0DFcydmaIFJUrc0/1d6x4/jjOUgg3vLmj1y1fx6YziK1IpP0rm6gXITFh0jgWcF3TtKsZjD+XFI5Zp5oLm40dJWGmoGls+43563py0IV0uns85P+K49X5tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQvP/BvyyNtQn3Rn1h2TBp52BiCtNbs/TcTVl22m8lY=;
 b=LjHfre/KyuQObIC+gqyKuLVFWUNKZn4tiStJDvIQD52zphRh0/3yUXbzEevYTljQgkVoeM6PVjkyBklskW6gvMiXUthVP7VULXZfOn6chLTSXqaxG/U7Trr5a9YfDpToEcSRmYniAh4Fo9kfR+b77vGsG3MqyRdkth0GLdqNzV0=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZR1P278MB1086.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 13:47:26 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ad61:ba12:643a:f60c]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ad61:ba12:643a:f60c%3]) with mapi id 15.20.7249.038; Wed, 7 Feb 2024
 13:47:26 +0000
From: =?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
	"r-gunasekaran@ti.com" <r-gunasekaran@ti.com>, "rogerq@kernel.org"
	<rogerq@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?Sanju=E1n_Garc=EDa=2C_Jorge?= <Jorge.SanjuanGarcia@duagon.com>
Subject: [RFC,net] net: ethernet: ti: am65-cpsw: Add IFF_UNICAST_FLT flag to
 port device
Thread-Topic: [RFC,net] net: ethernet: ti: am65-cpsw: Add IFF_UNICAST_FLT flag
 to port device
Thread-Index: AQHaWcwvvVQNI0Oa6U27F34yWYICjg==
Date: Wed, 7 Feb 2024 13:47:26 +0000
Message-ID: <20240207134659.962365-1-jorge.sanjuangarcia@duagon.com>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZR1P278MB1086:EE_|DB1PEPF000509EC:EE_|ZR0P278MB1154:EE_|DB3PEPF0000885A:EE_|ZR2P278MB1129:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb81ac4-ac31-46ad-dce9-08dc27e35987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 vr2kHSzOXcO5l1SEBJNhaRO4vvpM7xfHzS0Dpg3tK1UpxDK0Rr7kV+vyqnGfKOrhijob79Q9w8/gmxAI1acO1M03aOH7UoYR6aKPXrjenajyRDcgKi+48PUDue94+s/KFnYAyH2Wdtjs2l1d7Dj8ZGsC9BEbl2hYQvLPVAHciqfnFuwXN4XsoNA41C63X+umpoFfYwJpLEci5/YcF1k84PauEenY9MPFZMqV3rOZONuOmVaMd9lHnzT+hkfoNXzJcAeNqFsQdAIjHaYbiRNAQzI0Ii5oLmHSNM/EFiftbaKL5ox+n4I/Uglx85774Jzy9vVygaxzeqnOT/a5flJA5OezJooTCCTy9ZazJxreqaUaHR+bRTHXdCsM7yPNU3cla5R9lUMv++YqBeVpZj6w7wPimy3wSNe2DgKHuSUxy64PNomYbKwzSqjjxf2VBAh5Kh5Qmgll+rdi25tdaWCm+TcxuQGrmaYYcNJFuZsmffw1tKxnueo1GJQUxNidF04AAFnJQNRJb1dFk5gwJle0wFow2gGQD+mE+SbfNthSJs/riQa6vhvAaYolpaLFT3QFqiyHilvVCiIFxZWGF86KTcNJnzOzZ5cKzysN2DhYUy54gibtytLCfUyVx+42QnMh
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39850400004)(376002)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(86362001)(41300700001)(38100700002)(5660300002)(7416002)(2906002)(122000001)(38070700009)(107886003)(1076003)(2616005)(6512007)(26005)(6486002)(71200400001)(6506007)(478600001)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(8936002)(316002)(4326008)(8676002);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1086
X-CodeTwo-MessageID: faa2ea54-9b0b-4fb9-85f5-3bb9150b70f8.20240207134729@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 61524a30-28ae-4e0c-700d-08dc27e351c9
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 bRtetQeGvYkfP6djEJ3ox6zb43KjKpe6hN5WRMgGsBpr203MtwgQl1U3heGOxYZ53gyV+leN3VTdALjK/P1g+pYt39uai6uLWpv98TT6b9RA/p8191kEnP4uz0J9PjjyBQdgv5gwsRBCpq0auQ0xBefZm8tmXsj1HGz68ze2q5ZnUVL3SZ1EAcPuGki3s4YRkYyBPtPAv7pJHkhZ7d49qSclMdQoEPNGt5ziX+jE1LOt2EPzFVmBbSn3B7LcCZnv9xTUzwttcJ6Yt/4pHSxjjaacRLuSEA7FpSCeARr7AvyRRunIzS+RZdkyD/SQwLRLMi5X/Dpw8W/nkWWkLdeM3FJ0gYCO5e/lwTIHlZ7Ru0fjuCjdapDsm6HksZVJy1oDRqGIYROY23L2w9s8AyD2dGaFfu2W3CMuRHHbPUYTJJcnc4H9W+u5A0ua5SB7Gbut0jp0+VPILl7U/1pLI5ZcceIaoznT2HL7JQYtMKRXvTUNgQDEAQT3e8pU6Po5ec5n91AnI/njqnLJTGIsf0NVTOyucAxCBagsWB1dDRlMzwccFV0WLWh6qcg2ag4jPtVuNTrogQs1TFbwcOZcBRBlSIxK04SuyogIVq6ook0W9OxJFFzp9ofA40JGUjWB6RhHXC66Bg2ESSG1nVpeReQ8dIpXu4dRq8hjKUjbLeaXVM3P9I170XI5Zpah6uT+t82HWxOM6oJiR8wZjIwAYQIGSw==
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39850400004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(46966006)(36840700001)(47076005)(7636003)(7596003)(356005)(82740400003)(36860700001)(6506007)(40480700001)(86362001)(41300700001)(1076003)(2616005)(26005)(107886003)(8676002)(8936002)(4326008)(36756003)(6512007)(336012)(6486002)(478600001)(2906002)(5660300002)(54906003)(316002)(70586007)(70206006)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1154
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	76bd4c03-a95f-4ed7-4961-08dc27e356a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W+vTNlM3ZkIBNPp2jk9wzWfTPpVksv0ZH/skMJfwveYmzsaSUGSfjGafahw+p03i568WbJQN+RYwKamNs6y6K5peXbNvUSgcjatoqjcOHbABGdmJEuoQtwWCEKEOC7DbyzR5F5ApxeC+yIpKhHhxhJ4Nmi+UeRUIHjTuxdrAzUyjY+2QWZ1eK10kXMXQY4H2rf8vt9NCDuHOHuy/uNfN1sQwz2g7ZcF/EdAuuTo0PwnhlR3KuvX8bWGsaHbDWKWhZya3Ad5ZDNwynjz7maMyBf1KuzileO5pSl0nFTGV1rZcAiaV/s2ByoyWs/pmLF/98kGFlgtawGGNlVL9HYBJ3vOtimkH/ane1UUIyGYV9Dl+OHFO+5Ps8xzj2U8W8dd4FdAmXTOgBSRmWZeGeswLcm8xiL3GvH9Z21BZIhTKpO8IoRJ5G1KUHd3O7kdgU6M1W8kdMNtH7A6B4mvOznLqvnD+M2563Ffv6mdp++Jl7RQet1C9LF877mRmAGxR0r6M06fm3PUfNN89ki2uD3TWEzCRdYXuB6mtvoT+wnT70ktz0wkUu5FSBviJhokvL0DM3CGzdcxLwh4alZc2WbyXdZc+89Xv7gAH6r8b00afmoby8UbhyCxnkjt4jgjM/Bn/uNPxqnp5jVRrMoEdETALuH4NhUsTWc/Wd9zHQZ9Myulw6H0qyc0+bDkWH1/FVHQSzEg0RWTDOUdfCSYpFEk4Em/wi+GFyZnLB7ZBkt3zgldAxuQZO+a3Yyx4lTal6JlWHTONGqMWCwFrTShe/KPsIA==
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(136003)(39850400004)(346002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(2906002)(47076005)(41300700001)(86362001)(36756003)(81166007)(6486002)(36860700001)(8936002)(478600001)(5660300002)(82740400003)(6506007)(4326008)(1076003)(107886003)(6512007)(110136005)(70586007)(336012)(54906003)(316002)(26005)(2616005)(70206006)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 13:47:39.0090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb81ac4-ac31-46ad-dce9-08dc27e35987
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1129

Since commit 8940e6b ("net: dsa: avoid call to __dev_set_promiscuity()
while rtnl_mutex isn't held") when conecting one of this switch's port
to a DSA switch as the conduit interface, the network interface is set to
promiscuous mode by default and cannot be set to not promiscous mode again
from userspace. The reason for this is that the cpsw ports net devices
do not have the flag IFF_UNICAST_FLT set in their private flags.

The cpsw switch should be able to set not promiscuous mode as otherwise
a '1' is written to bit ALE_PORT_MACONLY_CAF which makes ethernet frames
get an aditional VLAN tag when entering the port connected to the DSA
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

