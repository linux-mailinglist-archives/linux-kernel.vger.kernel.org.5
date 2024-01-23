Return-Path: <linux-kernel+bounces-36158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C5839C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C86B27569
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226AF5467D;
	Tue, 23 Jan 2024 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="yCcDZvWK";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="yCcDZvWK"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10451024;
	Tue, 23 Jan 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706050306; cv=fail; b=rEROIVx14b/YnrbEKShqvoQr54ZT1zf6QGTI3M41Zbed2L5d5x/vj73COgWvbNa+6xkptnXhHPjP14Od7Nw1j2TXe4fyQjz3LgeFlsn6FJagF6e4RhRR3kYEn/T8qr3mcZpNL+efVqMlbkhLb3IVCF9YHK4apzQyL2q1iRsDtx8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706050306; c=relaxed/simple;
	bh=DqVXYmeBd7gCC2CH7ZWEPUrId/SfdbuovZ3a+6V/I5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E0HxYY7nn1f6s3NRnCFCuj71MiDw754UfFQylX0YuV97wOFQrTx+sxEJUXMS6G/QHOw4nIdwaK2wMfgIin4HgJ50AOVzf+n9qoOEaZpOmk8XLHl8ONaTn7I1TAeVHXe/S8GoLkH/ntlyJkorHugbE6jBLLEicKcETd1vJmaEe7I=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com; spf=pass smtp.mailfrom=seco.com; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=yCcDZvWK; dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b=yCcDZvWK; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=fMabo6/X9oxY0eS0KTRfijvnvxKFhT77pXQv1Eo4nIf8LgIrnWBuvnKiz5D4GFqVgxdOxyLhcSCWo1CmxrWeS3YRtuylXFjvs9nSqrGHxUamWGNi34AHwXYZMtUxdcuuSaNyMz1VJ8Bz6GTQ+haj6IWaBaYsSKDIBtotPUXLxjrFxQMp98j+vC8cHNpo2OMpWLfuioHTIFDza3zZ0U6OV+nYNflPBAo+koOEZJc1Ktza2BIzS0wF/5JtmIpq6GfUumtl+XuvXoS6gvMT5TEDgcpF2YjBKSIWGk/fl6fftLIM2lGX9TwYUbdN7ads+SjAp7PNhgDmXNmoRARIGQVBOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wozSV54YBQhRxIrVNzvoD9GtY6mFvR5snPwZW/Fj4pk=;
 b=MPbflTu4jicYjqTCzm2mc+MMaf7VZi9Uv5cniBP5HKs0aYy5o9/7vrVB7ZfA7LIa6iesaHNgfF97XUFZJFkd2dafp8ya3GMW/hEKdiJvYt1oUx28eCwHZPxk3+D9T/eCOgumMa45VCVp0yCw9l7RoqP+bc7+w5nXRYeF9+DP07j82gyv0tdkVaP4o2mGZuLZFbuytLSuL4yOgrCmtDW3DyYrWATkFqd152i7iRkD/PWffiCopbz1spsi9Wv6mfVVfKonCzyM0qi2eW+Z8qBYdwApUC9/V2Gd5rmLFajPElTDx1u/CJbnElXF9bwGHST6yGfcBoi0YF8D6kg9NZHBCw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.82) smtp.rcpttodomain=free.fr smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wozSV54YBQhRxIrVNzvoD9GtY6mFvR5snPwZW/Fj4pk=;
 b=yCcDZvWKgKHVFdrWxN+RNcZwaN1RiZqWfzk/w8dTMkQZhqyGsXS+gQIhDJuI7Tfi3+h7+hwTC0d1gmLGgIROPUf89HWK113ab7j596xn17eEcgvcLxIcf3j42uVJ2TcLFhI3ZoYlDxejy/Nq98Gix6xCGLx9ihR5rKJsRrHPJqW+VaoBZhkziuvBtsMFBFHMWlRirzgItnEsgujY6JT6EgPTsfSFw6t4PQ8dnKhO90VstFhojfFUnYZ0vB40azDYukfWteQJ9di4dBuyUJdGqsCoPF6RRj8l8ljR/v2GCIe0IkYu3iGz9pml4NPLjzP7/awStDtvYrtgy7fcqNJqRw==
Received: from FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a3::19)
 by DU2PR03MB7989.eurprd03.prod.outlook.com (2603:10a6:10:2dc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 22:51:39 +0000
Received: from VI1EUR05FT060.eop-eur05.prod.protection.outlook.com
 (2603:10a6:d10:a3:cafe::23) by FR3P281CA0119.outlook.office365.com
 (2603:10a6:d10:a3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.20 via Frontend
 Transport; Tue, 23 Jan 2024 22:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.82)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.82 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.82; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.82) by
 VI1EUR05FT060.mail.protection.outlook.com (10.233.242.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.21 via Frontend Transport; Tue, 23 Jan 2024 22:51:38 +0000
Received: from outmta (unknown [192.168.82.132])
	by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id 55ED320083980;
	Tue, 23 Jan 2024 22:51:38 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.168])
	by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 190AF20080073;
	Tue, 23 Jan 2024 22:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvBo3sxHw8vv1jr1N+iS0i8K3TO721gZciEVYaggNdTjSBJDGtb0uJtn8gtNACgbxcv/JOiic7wGPKg92umR7ecIAKaU7W9uudWWL2fjaRlmDq3G3JsQ2OWgLbp62m+a3YljrZ7RazrzhYE+FrSjLOJeFqbOrtTeHCuqp6HSLTpBbwNHP1lBMDo9cuuZBPRN8BDcHRxNTvjQkmSZh4BjRnQAGc2AFSe9iYJDnjU270yFGQhm6Y+iufJVeG7+sY+9iBbqINN5rmnF2PU5fI/xYLjJi+w70+t5/h6tpM8SrpXLG/KuUzxHM/M1Jp788oPNMsckEo7eyGHsqh/9mTaPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wozSV54YBQhRxIrVNzvoD9GtY6mFvR5snPwZW/Fj4pk=;
 b=Lxf4LYyyonFSzkRReqGd55H5LUo3dEnDyLFl2LUGwlwlUAL9/lssPzWM5dO0bv5km7Krbq83IEGd6JTZhYAI4uij6th+RIvC5fGjM4C56ttbC8erh0je7o4HfvIyGbnkyCOJjgCtesxQcGFHpOG24s01HivKRWNfOVYvbkHmYqxVwFO1C8n+7RfF+5J7P4QkOCtf+PMDalgQcHnKCim8S2Vxhxs7lr+cb/0QNff3qK8ppFPt/UnYBP53xqC38L2NVp7aCD8u27lLrQlkKHV0/bTGHSqYWvwyxl/aav4Tz8vsWflkVimJSBl3kWz3mMWBx4cBSSqDueBNIWea5Nm7fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wozSV54YBQhRxIrVNzvoD9GtY6mFvR5snPwZW/Fj4pk=;
 b=yCcDZvWKgKHVFdrWxN+RNcZwaN1RiZqWfzk/w8dTMkQZhqyGsXS+gQIhDJuI7Tfi3+h7+hwTC0d1gmLGgIROPUf89HWK113ab7j596xn17eEcgvcLxIcf3j42uVJ2TcLFhI3ZoYlDxejy/Nq98Gix6xCGLx9ihR5rKJsRrHPJqW+VaoBZhkziuvBtsMFBFHMWlRirzgItnEsgujY6JT6EgPTsfSFw6t4PQ8dnKhO90VstFhojfFUnYZ0vB40azDYukfWteQJ9di4dBuyUJdGqsCoPF6RRj8l8ljR/v2GCIe0IkYu3iGz9pml4NPLjzP7/awStDtvYrtgy7fcqNJqRw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS2PR03MB9792.eurprd03.prod.outlook.com (2603:10a6:20b:608::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 22:51:35 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::ec0a:c3a4:c8f9:9f84%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 22:51:35 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: Robert Jarzmik <robert.jarzmik@free.fr>,
	Felipe Balbi <balbi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Jules Maselbas <jmaselbas@kalray.eu>,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@seco.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: usb: usb-nop-xceiv: Repurpose vbus-regulator
Date: Tue, 23 Jan 2024 17:51:08 -0500
Message-Id: <20240123225111.1629405-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20240123225111.1629405-1-sean.anderson@seco.com>
References: <20240123225111.1629405-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR03MB8847:EE_|AS2PR03MB9792:EE_|VI1EUR05FT060:EE_|DU2PR03MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 278ee214-9e9e-47fd-1977-08dc1c65dc0c
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 l2uG15JaYd5ijQj/uwu5f1XuSEPtiJE0ieJD5zZyAzkrNtC5080pzeZQWvQFNaGjdgYAwTbap/ynGpgEk3Vp39atS3+w+w1xvijC5hOcBzScfu4efs/EONkcdHpUu9IJhv6iVMKpTdwzuyebcIhs6WSmTZNfekCxoqUMLoikzDP/36+p89S/BQMhx6+TVcmapvid0M6B9OnWQIbXL0vZkj8uclMGqQfSD2ubvsG0+0wzZwnj9JiPcHbCbhs9Qh4km52epgvpNnJDo89YmXPQLgKcICdCgVWDvFuftdsU/c1RrC1i70idgWAOeunzak5Jn9lrYcPFx0Cjo154F8cl030To34VGq+Z86nlGO5Q+MNX+qTdU4lT807FBueIKAgoJOw/zZjloaWDrj4UNRXAvYoRlSXV25yWmBDPtxuaPok5q8N/maZl6wiCH+1JrR8PaccnTkz4LBJGMNeh25fPZW9ce4sE2t9ai/Yte82CJylySoGBuPvuJGLikNXBbc/6WlbC8fJ2U6hZWbhNFNymSkhuLwjed+76IcifRk8jcf++MI958dGdeY0hUR4zFaWikp/tr8S2dY2k9WoAX/zQ/XO+UtsxukthbXCV6R7Kd243NwExNJ4cqCQ80ZOtBaP6//vutfcHEtveeEkzhovqcg==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(38350700005)(66556008)(86362001)(66476007)(54906003)(316002)(36756003)(2616005)(41300700001)(66946007)(6512007)(52116002)(4326008)(8936002)(38100700002)(1076003)(83380400001)(26005)(7416002)(8676002)(2906002)(5660300002)(6506007)(44832011)(478600001)(6486002)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9792
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 VI1EUR05FT060.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	546a3cc3-8fe0-4991-f73c-08dc1c65d9e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gVvgHRkYxtexBkRBJzol8mMKsffdD15ATQoXKZL6Y16yAY4DnRR+D/ssw/SH6AquJI3XgpMSsO1ZoBI4HefgtIq2cUtIY1CqSAxd0rZF7PzpuwXQbH2mxpB+F8MDoBlTuf0fqPzYeT/BKNskNEe/A2QY9f0/mRpvnV2ryjS7NzjomgkhzAYN40BIy4delr+bP3R7k8FX0SA2FZ18V6SyKd+kr0bIjMYA+ZS8o0cgBInpO/eaMED4edA1G7Y2b5xdRYLWWDNedFIH/enPc/78XWScikP0vn7+8J69IPglVuwCVl5cif5D07qHQfTZh7aqz/T/JmvO0DvNk+G3r/kV76A/dPUacOaCWkeJ409LMD4SPZe3koecfjxVW9pQAsSU8E7DmN1T6SM6dCCmT77F0TNS4/6fRxtx0ON3BwjHt6B+6k1g/4Ato0Ehib/52W0oI+PLrKem6yFw3V+UiCVNfu3Z8nI+TIQnCRoiqKm8DOBmLS9yg+QQ9c9meKA3JH4E8kJ2p99K97Q8H4bBz1ALbqNNh4NPgCJWKi3AzBARbwkALS1IxmKJeeB80dwlbvS/Mx75s125UYlhdmf4svSdxzPOCWc9lxvI+qjOvyKFDBmVtpdeA0jBqqERHGaoBaOiflxiA+yGgtFhbkPEyMb3RHP1tFSRukGO06GsuxpeO69dASUhJtYEXAKWgkr+bnYsjIUdxz+abzW71VacVr8u3tbj33S5lI5MEDefeqpnXxz/02XJfiv/CaUsKIa9ONDSjCU3CRu+/geF2GmrpVocwA==
X-Forefront-Antispam-Report:
	CIP:20.160.56.82;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:repost-eu.tmcas.trendmicro.com;PTR:repost-eu.tmcas.trendmicro.com;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39850400004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(46966006)(36840700001)(41300700001)(34070700002)(7596003)(7636003)(356005)(82740400003)(47076005)(36860700001)(36756003)(86362001)(316002)(54906003)(70206006)(70586007)(5660300002)(7416002)(8676002)(2906002)(4326008)(8936002)(44832011)(336012)(1076003)(26005)(2616005)(83380400001)(478600001)(6506007)(6512007)(6666004)(6486002)(40480700001)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 22:51:38.7885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278ee214-9e9e-47fd-1977-08dc1c65dc0c
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733;Ip=[20.160.56.82];Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource:
	VI1EUR05FT060.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7989

The vbus-regulator property was never actually read from the device tree.
Introduce a new property vbus-supply to represent the regulator powering
the VBUS when acting as an A-Device. This supply will be enabled and
disabled as necessary. Note that this is different from vbus-regulator,
which represented the available current available to draw from VBUS in
B-Device mode. Because no one was using vbus-regulator, remove it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes in v3:
- Update description as suggested by Linus

Changes in v2:
- Fix dt_binding_check errors

 .../devicetree/bindings/usb/usb-nop-xceiv.yaml        | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
index 6734f4d3aa78..9b3ea23654af 100644
--- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml
@@ -37,10 +37,11 @@ properties:
     description: Should specify the GPIO detecting a VBus insertion
     maxItems: 1
 
-  vbus-regulator:
-    description: Should specify the regulator supplying current drawn from
-      the VBus line.
-    $ref: /schemas/types.yaml#/definitions/phandle
+  vbus-supply:
+    description: regulator supplying VBUS. It will be enabled and disabled
+                 dynamically in OTG mode. If the regulator is controlled by a
+                 GPIO line, this should be modeled as a regulator-fixed and
+                 referenced by this supply.
 
   wakeup-source:
     description:
@@ -65,7 +66,7 @@ examples:
         vcc-supply = <&hsusb1_vcc_regulator>;
         reset-gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
         vbus-detect-gpio = <&gpio2 13 GPIO_ACTIVE_HIGH>;
-        vbus-regulator = <&vbus_regulator>;
+        vbus-supply = <&vbus_regulator>;
         #phy-cells = <0>;
     };
 
-- 
2.35.1.1320.gc452695387.dirty


