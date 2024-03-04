Return-Path: <linux-kernel+bounces-90430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A386FF06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFC31F23848
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AA62574D;
	Mon,  4 Mar 2024 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="lpfgqIJl";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="lpfgqIJl";
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="lpfgqIJl"
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (mail-gv0che01on2130.outbound.protection.outlook.com [40.107.23.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1C24A04;
	Mon,  4 Mar 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.23.130
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548051; cv=fail; b=tcZdC/OwKz6pBsHMTtShWp37yjwWJVhncc3xMfhhLQJLdRAIh/VtM4hpn8ar+mgCkOxbPcnV7mNu4Fe28Qa5pd2cWrqj0EjJzIL5Xe+j121BTwW/s76/pyH5lXJ4gyJcf99RN2qLpnZyrGHhpLbCUcx+kg45H/N780r2Zd7PIz8=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548051; c=relaxed/simple;
	bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oaq8VPUcNs8KZO+IQ5H0ncx7w2KKwaIzCDuY8vassOXos6XkvjiSLZ43yR6g2sLn2qarCyqoHTrAQdZXoVi6l8qg+gXn3/ovwh4fhnyVNIaUuxea/P2sZXOIbDwwKmh0aYkM4mF5slTrgqWPkla5+JweG4Ta/HIv2QwZE5VTIqA=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=lpfgqIJl; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=lpfgqIJl; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=lpfgqIJl; arc=fail smtp.client-ip=40.107.23.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=dgr7NsAYcZCt5Xu/YkOwizzbXBllKrXJoj1jABEEB8ODIWkCjMeCGKytFbuzZP3RFJ6HY+aIQn9cWwfplUBWUez0X71iqb5g1l7nhtRSqKsj0SfYqrOLhq9kp2Y/Q6KO1sv9RI17MVz10ihk76D235Wn82Kim8u34vipJEdbj/RfcHeSCheCZdQp9EGOVk09t1OrPhUE9u/QFs1pj5oEE5CDbzXE8BxWrCZEoh1W6ZbVk00vnmBdfYk2IYiw0xmv0WvWOjLApzrS1xj/vtC3dYEbjp1RIMgJq9shWXPNF3I2H7huCWNQzEI6puZMhgz1NIa+LBn7skAkzXkvChCV4w==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=bvLYh9WYE6fTexI7mE6geb10DvzRHSaxBL1QUXdn6JDGTqgdN0qBtUr1FNGQuf1q6Im+E7+Ga6/UxPGDUadFR2ee+VjooFlp+uec3ep56SK5V9dxX3GjCXcj2A44TAO8rt94sRdno9W3IlNlzVxgkgjLLQWUkSEAmxRfrvBerfhOnjaAeWFNMbuFGEwcwyRobAyOLARUmpbpe8uFjeKO0V02kIDXwB7hGl78g3C3gWrBQ15lyiuUaDwj35t6LvaT3SdKMdF1K8ptQoTxUMeWosqTaLr6qJbhma584/L2Bmu8zOX+aLBFdZCSgyYvq7P4Z0kQYodxaD7aRnNc7inRKA==
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
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=lpfgqIJlEOJMTQzFXOYK4Yus4SpSoljLUWpNxg1SneayHFAKwF9cMQyqtg0SYGqZj8a+fhZYmQbJ2Ek79ZYyVJ9QJivqqkpZqjiTtPWEZacF18kOsiQs9EP1mssXb8Stjqaue8LWbhgvR7rSGf3dikHMV8AE1cIBKL4SK9BEDew=
Received: from AS9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:20b:462::21)
 by ZRAP278MB0031.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:12::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:27:23 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:462:cafe::c) by AS9PR06CA0009.outlook.office365.com
 (2603:10a6:20b:462::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 10:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 10:27:22 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4TpFHt47b1zxpB;
	Mon,  4 Mar 2024 11:27:22 +0100 (CET)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Mon,  4 Mar 2024 11:27:22 +0100 (CET)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=YAL+4N+DIyyjR8i6rDdNQq7hjUakI+e7DW6Lt/CmQni26a9RQw2szC3q33PaEldB5hCU0eUWQdM7O3H6gTLoaWj08uZ1yEug5ypwKKW4QcXGWckhkYEIqmNIp9wBdBtVv9aLPTXWvvkIvs2zowmk2U+Cx2PKlaEzujsYK89Vk5Rur74G5QyC7ww4mgEE5i4VfCN7+/KJsq9b5EkZFrDlTGCq26sB2FEeQNwRNwFyAXVI9uixes/U9XLv3AK95H5a1BDtF7dPTfv8W4aPlKTqZRHrFeimYLpPw6iyF5RR6GIHmYS3aPjIHpXEHYbN8DlFR8PXluFm/oYzjq3NjKjMzQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=Cpvw/w2qQ/RBOr+tX1WF8dh2YangMEWZ94lsUmZSlEzEQzmZFMKNJkBaN5t5ZWgX79JH5cFbRP9eBLp2TScMLVjPJP1dWTbpZW7eQYuPxWJwkPUXytxh8eSPSOCIbh5WwfCKLorJAUJh3a/0looDyThEgFvxbVt050KY3H38yvyk9nYQJxUL0Ze7Wo5Y51mj3z5BAby0FwwA7J/rx7tbf/FFHFNgYm0o+9GErjHIGZ9RIrM1+ArCrMIexLwQCPBaEciv2qy+soSMikOgecAdMPQduO3fGk6BLtejGvGS94VPis+Yfio+NBL2NJDHeWVC/v3IUR5E5SQk/pekflN7Tg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.220.33) smtp.rcpttodomain=gmail.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=pass (signature was verified) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dkim=[1,1,header.d=duagon.com]
 dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=lpfgqIJlEOJMTQzFXOYK4Yus4SpSoljLUWpNxg1SneayHFAKwF9cMQyqtg0SYGqZj8a+fhZYmQbJ2Ek79ZYyVJ9QJivqqkpZqjiTtPWEZacF18kOsiQs9EP1mssXb8Stjqaue8LWbhgvR7rSGf3dikHMV8AE1cIBKL4SK9BEDew=
Received: from DUZPR01CA0231.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::12) by ZR1P278MB1280.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.45; Mon, 4 Mar
 2024 10:27:20 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:4b4:cafe::70) by DUZPR01CA0231.outlook.office365.com
 (2603:10a6:10:4b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 10:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=pass (signature was verified)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Mon, 4 Mar 2024 10:27:19 +0000
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.104) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 04 Mar 2024 10:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ4O4N7OJVhyG4U6Fw7/4MPuaMtQfyD3EogEY+ixAzf+J4XsV7zDZOznXxoXnXm+nH/4jHF8AQ2xjSxecTkr8zdBX2QONbj3wGUg3W9DOoWUZzbZwRAPo/gYm6eS77kv3W1ts9A9VraayDqbzzbgfR29xcGtfI4bUZWUAx2V0AH0NHk8i53BpbMvlC6BqOhiNNd6jYwjRCmE0wRDZr3fIKCYrVXV61OAS4US8wfHCVuFJcCqnZbsGjoB+ZOFdidnY06dvmHeoE2VbR4JAkaT+Hd+WNGqqDxzdA0uHJ2N5MUzznZntSFrAglmEmVNvrxv+ms+p2KSccm8lyNgnkw7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=dJr1l3D+oenLtBhoXNE/2BuZ8LQkhW8rXnUcDUcbVE7GbveParFtnem4OR5wwIFx1Imojjmz3CkD3nfi/9Fqo4E7iO42DYRCyBMr/y0dGAEDkVWRBs4TE/G5oveHA0l8dLsjUgYDNEYHtrBuMMZGbADpsdc67fvLnn3akMSPv3ll2D/DLia/nGsbg57qcDSAT47G7ZpblX+Npm9/2Mao4vmu7T7SvdGQSSecbVAEQP3w6ZDr2MndVE/ZxpWFmmunCbyi7ZyNsmX7/DHrypZ59RriYmIgE7GHIsRX5Egc48VfAFLpafun3Le59jUT61DBaB1Yzeuti/eRCG/bqxHPdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=duagon.com; dmarc=pass action=none header.from=duagon.com;
 dkim=pass header.d=duagon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oE1AKiZ+e6bsMPpgFF++Kf3BGRCL75h6niwcjOMh/bU=;
 b=lpfgqIJlEOJMTQzFXOYK4Yus4SpSoljLUWpNxg1SneayHFAKwF9cMQyqtg0SYGqZj8a+fhZYmQbJ2Ek79ZYyVJ9QJivqqkpZqjiTtPWEZacF18kOsiQs9EP1mssXb8Stjqaue8LWbhgvR7rSGf3dikHMV8AE1cIBKL4SK9BEDew=
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::11)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.45; Mon, 4 Mar
 2024 10:27:13 +0000
Received: from GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d4e:bea6:7daf:784f]) by GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7d4e:bea6:7daf:784f%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 10:27:13 +0000
From: =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
To: "olteanv@gmail.com" <olteanv@gmail.com>, "r-gunasekaran@ti.com"
	<r-gunasekaran@ti.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "rogerq@kernel.org"
	<rogerq@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Thread-Topic: [PATCH net RESEND] net: ethernet: ti: am65-cpsw: Add
 IFF_UNICAST_FLT flag to port device
Thread-Index: AQHaajclGd8wDFepREKIl/wW2KxXVrEgtJIAgAII9ACAAE5EgIAEXMoA
Date: Mon, 4 Mar 2024 10:27:13 +0000
Message-ID: <7a39e5266fa3ac781f1eda7ee0b2526bd2f164d0.camel@duagon.com>
References: <20240228111300.2516590-1-jorge.sanjuangarcia@duagon.com>
	 <20240228200516.1166a097@kernel.org>
	 <03bf515c-9f90-487c-ecfa-90d407dc5d86@ti.com>
	 <20240301154957.xex75zuijptswcf3@skbuf>
In-Reply-To: <20240301154957.xex75zuijptswcf3@skbuf>
Accept-Language: es-ES, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
x-ms-traffictypediagnostic:
	GV0P278MB0516:EE_|ZR3P278MB1305:EE_|DB1PEPF000509E6:EE_|ZR1P278MB1280:EE_|AMS0EPF000001AA:EE_|ZRAP278MB0031:EE_
X-MS-Office365-Filtering-Correlation-Id: 821194b7-7b4b-479f-9644-08dc3c35ae21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 VoCpN9nVpP+LI9ltskIWk6/LcyoxhSzKVJTMBZ+HmJaopGKI8U/YDmX0Q075/FwfOF3haikNwZMzUQlpUc0hYjF0JV+uQ6LAOq5kyhg0I3Km18zIlzO8KePmfuLzz6hJtbpOIh3gq7suXFi4+sYvJEJmsJmof510XWFmCVmLXb1WqGfdjfhIIlARNR5i4UpXsgQZbanYKueQqBuDte8HKqaWyHGHXzkXGUFzLKitnxp8e6qj8hcl1Rlj+0MIpJgVoeGwScCKKgBMgPq+GA44zLYxclCKSrhhB9sQjHqpSVHxknk0t3kq3tkMwVydl2J289C8i1PgEv7139egOqwZaP1ufFMfsh1zh4w8+1vrHo5rFPyswkC16u5edbp+I/OmoMMnZ6TqSdyxwLrxIwcAOLTyc1mcy5Nyf/vi/gWd01SLGZmhotutTRFwCIp6hfrBJw6Rq1FpxZKEvYh2NhyRds2DG6NTPLnKAqlfQJwma9X3zE9e8r6qiHlrk+nDKpePMlF6GHDQVnaXteWzQ+HjQATXCRVbeopcgKl409eWqRFduGBPZ6AgVNtVgBH73cLVWbWT1GnRG80ThWgEr4l4/0uX8K+o9bWuXq1tA0wxUSHqA/VUffhFkaaklzmjtm3X7voeCjjZIyOtBO83ZmUpcFnQVHaD0ghh3538uCQcKxBeLl1B2qY7YEmCb3+cDFCAT9qwoDa4S1l+elVtQcmRqGWWQocLZSgBsGd01miD9kU2TX/7iwZA44SBNLZ4IhHe
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0516.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE4AD666AAA7174A9A21AAD25AF3D527@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
X-CodeTwo-MessageID: 861f0f50-0094-4231-8409-413ff648cb17.20240304102715@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 c6a52d3b-7171-4bb2-c677-08dc3c35a84d
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 PF01L6R3IReFgzba5JAQNFzXa/4h8fqJaByiV8M7RqCfrMAsvWGeGV2aTmD42aOYgfxy0Og3OxhUcX6KRqm1Okf3fV70V//nlH245x6sCvdnMWafOQB+XP7y7TI5tXshEv/R4ESmjE1GC4iiHusacUpwaHYQL6EzEO+YuPcd1p5TIYgRK6yOsi5py6lhHyh6Z0kCuQPJZ9TRmNbJfjizjfj4bmL7oylPPGRJPZcZ8SrJyA2HSNnyt/hB9IiOMQxhvOljs6HW2BbD5KqH51JkPpp/XxfEsmgq1rZw5QH6WdrtCkrzcZhLxZcytbluog2rb+9iS63koGc+NQqTHsw0OPqrBcsglgMRd7SY4QtVUP9Z8TaRhKM1dhwigtzRnD4Hd23ihNinzd78EGO6yJU1KalNqqoLKu7Vm5cddn4SBNk/wO/vceoG5FE80PulCYef/K+iygLtZfA08rLqkLafhLan5+HicYa6AoFVXIL7XgVCFa5sdx9H6P08rRsK8S1GhARPeIPQ2WF+NLGxqGjH8qfd7lEd87zVOqJ7st8hRtPx5fp+CZXMpzxSz/5ObDxIVEXhhw7h1eprX4KuM63tHbt9FuZZO4OKlGWfWWDtQI8H4MkcMvtscZaOFdWrVoLb6x9mtL5Yz6WLQSsSF68xR9wMcLYL8DrQNVZemx+UEkOOGfqzNsLIwIVgdsjzdNqGxxPlHLpIy2EpnVT4Gc4OaLB4tot0nyrcqIqWdaZEjXHKwyLnTFExnwHBDzopixEpZ3636fOR+Te/Gpc4siQZ7tFmeLSV9qAtbUx4u2XNIQE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1580799018);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1280
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ee714a99-f6d2-485b-e8d2-08dc3c35ac6a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j+dhKYrWQ3NQ+Rh8Cfpf9ccpV7NglQsa/RvUrcTqz1J1LWCxK83wAPNT1tnuPKF2tQ2TyohdeY+GT/6H1B/rXEJgyH0ULXiyLyk2Rz+PNSZFOqZNhKBoEYPABadLk2pvNpT3pMWwC/qBOk+umhELoyb3ucSLTx6Hck8516uyEYJ3bPIgOThQph9z6RC9BDhDIT2Af41s2ic9vv9CHwByqNKGaBjU5/BTo/LzCXhgoPe3T1NCmXTi+yfttgeC5t2l+Z4V6tatQfSo5nc9rCE8X6WZaaCa4/dxVTU6gBTtR+1qLEiqXKSbpONIGqazL3T+JJYZh4e8z2ICC+KrStmO8pfiRabQq2Tm1WnJalXENRJpXcoMEC/9IyxeDLul/msknTsu4dqznzVQ1ujYlcyCsniHJ2NDf7JNClg+O5uSLZoP3/i1CU4yTcCP/+3at6xZPU3l5fghREl3vsbKFZan0pRsRXsx9zL1tjmkhKiCYjh9PopuVGxF3cI77rZbYxQPD7xmHo/TjL5zvF2AxkO6nckcj9M25AA73xfmCEp6E8PODR85XljrXLKNeSUu3an4kNL7H3OXO1xm2uo78WlMeA/CZtOpaY6ENoZxAK9sWrpu6+EwtM+gmHQGRmIjRbU8ydwBESiv081Q0aYkfV+eZVSCmvALI8oynJ5XrndhSIq2z8Z/yhO9keYb7+7ibIBeNX4X4OXYxrPFvDuuJYaiemHczk5nrrC1pt1qxYChr1kEwAvt1keDtiaBQDKtPBoi4B6no+cto8mr7dLDC7dSysvdcR7UhfDZa+0M5lOqibo=
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1580799018);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:27:22.9637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821194b7-7b4b-479f-9644-08dc3c35ae21
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0031

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDE3OjQ5ICswMjAwLCBWbGFkaW1pciBPbHRlYW4gd3JvdGU6
DQo+IFtObyBzdWVsZSByZWNpYmlyIGNvcnJlbyBlbGVjdHLDs25pY28gZGUgb2x0ZWFudkBnbWFp
bC5jb20uIERlc2N1YnJhDQo+IHBvciBxdcOpIGVzdG8gZXMgaW1wb3J0YW50ZSBlbg0KPiBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27CoF0NCj4gDQo+IE9uIEZy
aSwgTWFyIDAxLCAyMDI0IGF0IDA0OjM5OjUwUE0gKzA1MzAsIFJhdmkgR3VuYXNla2FyYW4gd3Jv
dGU6DQo+ID4gT24gMi8yOS8yNCA5OjM1IEFNLCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiA+
IE9uIFdlZCwgMjggRmViIDIwMjQgMTE6MTM6MjMgKzAwMDAgU2FuanXDoW4gR2FyY8OtYSwgSm9y
Z2Ugd3JvdGU6DQo+ID4gPiA+IFNpbmNlIGNvbW1pdCA4OTQwZTZiNjY5Y2EgKCJuZXQ6IGRzYTog
YXZvaWQgY2FsbCB0bw0KPiA+ID4gPiBfX2Rldl9zZXRfcHJvbWlzY3VpdHkoKQ0KPiA+ID4gPiB3
aGlsZSBydG5sX211dGV4IGlzbid0IGhlbGQiKSB3aGVuIGNvbmVjdGluZyBvbmUgb2YgdGhpcw0K
PiA+ID4gPiBzd2l0Y2gncyBwb3J0DQo+ID4gPiA+IHRvIGEgRFNBIHN3aXRjaCBhcyB0aGUgY29u
ZHVpdCBpbnRlcmZhY2UsIHRoZSBuZXR3b3JrIGludGVyZmFjZQ0KPiA+ID4gPiBpcyBzZXQgdG8N
Cj4gPiA+ID4gcHJvbWlzY3VvdXMgbW9kZSBieSBkZWZhdWx0IGFuZCBjYW5ub3QgYmUgc2V0IHRv
IG5vdA0KPiA+ID4gPiBwcm9taXNjdW91cyBtb2RlIGFnYWluDQo+ID4gPiA+IGZyb20gdXNlcnNw
YWNlLiBUaGUgcmVhc29uIGZvciB0aGlzIGlzIHRoYXQgdGhlIGNwc3cgcG9ydHMgbmV0DQo+ID4g
PiA+IGRldmljZXMNCj4gPiA+ID4gZG8gbm90IGhhdmUgdGhlIGZsYWcgSUZGX1VOSUNBU1RfRkxU
IHNldCBpbiB0aGVpciBwcml2YXRlDQo+ID4gPiA+IGZsYWdzLg0KPiA+ID4gPiANCj4gPiA+ID4g
VGhlIGNwc3cgc3dpdGNoIHNob3VsZCBiZSBhYmxlIHRvIHNldCBub3QgcHJvbWlzY3VvdXMgbW9k
ZSBhcw0KPiA+ID4gPiBvdGhlcndpc2UNCj4gPiA+ID4gYSAnMScgaXMgd3JpdHRlbiB0byBiaXQg
QUxFX1BPUlRfTUFDT05MWV9DQUYgd2hpY2ggbWFrZXMNCj4gPiA+ID4gZXRoZXJuZXQgZnJhbWVz
DQo+ID4gPiA+IGdldCBhbiBhZGRpdGlvbmFsIFZMQU4gdGFnIHdoZW4gZW50ZXJpbmcgdGhlIHBv
cnQgY29ubmVjdGVkIHRvDQo+ID4gPiA+IHRoZSBEU0ENCj4gPiA+ID4gc3dpdGNoLiBTZXR0aW5n
IHRoZSBJRkZfVU5JQ0FTVF9GTFQgZmxhZyB0byBhbGwgcG9ydHMgYWxsb3dzIHVzDQo+ID4gPiA+
IHRvIGhhdmUNCj4gPiA+ID4gdGhlIGNvbmR1aXQgaW50ZXJmYWNlIG9uIHRoZSBEU0Egc3Vic3lz
dGVtIHNldCBhcyBub3QNCj4gPiA+ID4gcHJvbWlzY3VvdXMuDQo+ID4gPiANCj4gPiA+IEl0IGRv
ZXNuJ3QgbG9vayBsaWtlIGFtNjUtY3Bzdy1udXNzIHN1cHBvcnRzIHVuaWNhc3QgZmlsdGVyaW5n
LA0KPiA+ID4gdGhvLCBkb2VzIGl0PyBTbyB3ZSdyZSBseWluZyBhYm91dCBzdXBwb3J0IHRvIHdv
cmsgYXJvdW5kIHNvbWUNCj4gPiA+IENQU1cgd2VpcmRuZXNzIChhZGRpdGlvbmFsIFZMQU4gdGFn
IHRoaW5nKT8NCj4gPiANCj4gPiBDUFNXIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IHVuaWNhc3Qg
ZmlsdGVyaW5nLg0KPiANCj4gVGhlbiB0aGUgZHJpdmVyIGNhbid0IGRlY2xhcmUgSUZGX1VOSUNB
U1RfRkxULg0KPiANCj4gV2h5IGRvZXMgZW5hYmxpbmcgcHJvbWlzY3VvdXMgbW9kZSBjYXVzZSBF
dGhlcm5ldCBmcmFtZXMgdG8gZ2V0IGFuDQo+IGFkZGl0aW9uYWwgVkxBTiB0YWc/IDgwMi4zIGNs
YXVzZSA0LjIuNC4xLjEgQWRkcmVzcyByZWNvZ25pdGlvbiBvbmx5DQo+IHNheXMgIlRoZSBNQUMg
c3VibGF5ZXIgbWF5IGFsc28gcHJvdmlkZSB0aGUgY2FwYWJpbGl0eSBvZiBvcGVyYXRpbmcNCj4g
aW4NCj4gdGhlIHByb21pc2N1b3VzIHJlY2VpdmUgbW9kZS4gSW4gdGhpcyBtb2RlIG9mIG9wZXJh
dGlvbiwgdGhlIE1BQw0KPiBzdWJsYXllciByZWNvZ25pemVzIGFuZCBhY2NlcHRzIGFsbCB2YWxp
ZCBmcmFtZXMsIHJlZ2FyZGxlc3Mgb2YgdGhlaXINCj4gRGVzdGluYXRpb24gQWRkcmVzcyBmaWVs
ZCB2YWx1ZXMuIi4gQWJzb2x1dGVseSBub3RoaW5nIGFib3V0IFZMQU4uDQoNCkhpLA0KDQpUaGFu
ayB5b3UgYWxsIHZlcnkgbXVjaCBmb3IgdGhlIHJldmlld3MuIEl0IGlzIGNsZWFyIG5vdyB3ZSBz
aG91bGQgbm90DQphZGQgdGhpcyBJRkZfVU5JQ0FTVF9GTFQgZmxhZyB0byB0aGlzIGRyaXZlci4N
Cg0KSSBtYXkgZG8gc29tZSBuZXcgaW52ZXN0aWdhdGlvbnMgdG8gZmluZCBvdXQgZXhhY3RseSB3
aHkgdGhpcyBDUFNXDQpkcml2ZXIgaXMgYWRkaW5nIFZMQU4gdGFncyB3aGVuIHNldCB0byBwcm9t
aXNjdW91cyBtb2RlLiBUaGUgQ1BTVyBIVyBpcw0KZGVmaW5ldGx5IGFkZGluZyBWTEFOIHRhZ3Mg
d2hlbmV2ZXIgYml0IEl5X1JFR19QeV9NQUNPTkxZIG9mIHJlZ2lzdGVyDQpDUFNXX0l5X0FMRV9Q
T1JUQ1RMMF95IGdldHMgYSAiMSIuIE1heWJlIHRoZXJlIGlzIHNvbWUgZXh0cmENCmNvbmZpZ3Vy
YXRpb24gbmVlZGVkIGJ1dCBhcyBmYXIgYSB0aGUgY3VycmVudCBhbTY1LWNwc3ctbnVzcy5jDQpp
bXBsZW1lbnRhdGlvbiBnb2VzLCBhbTY1X2Nwc3dfc2xhdmVfc2V0X3Byb21pc2MoKSBvbmx5IHNl
dHMgdGhhdCBiaXQuDQoNCkJlc3QgcmVnYXJkcywNCkpvcmdlDQo=

