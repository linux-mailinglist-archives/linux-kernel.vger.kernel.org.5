Return-Path: <linux-kernel+bounces-153325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F358ACC9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952B51F20CA1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950351474D8;
	Mon, 22 Apr 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="dwY+CdVD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="hgtTl1Ce"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2127.outbound.protection.outlook.com [40.107.14.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D2145B1D;
	Mon, 22 Apr 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.127
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787979; cv=fail; b=bw/2/0gXGl45FNj2dLqYVAfGv31J9iXjuK+sGJjMFuYxl7coVv6DIYTBcBhYAAZKhMUQANfJo8kmY4k3zkURjSC614/mrj28/4vm0u8bDOmKfOP/tR608AjXVayGnCkMW7mkEtdslVDsyjrLHlyAFw9v5x+gHLFJtgMZcCn3Zj0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787979; c=relaxed/simple;
	bh=17h2vBUOSyd0l8pI/Y6jW39y9YXZYDQ+wB8FiXsiN3g=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4q1JNzoy441qOjhHQyd9omSQ33YiXKOtzhq4evTWCz51m2Lw2PlpK/A9iqI23bRFg0XbCd/I52Z9k3nONLIfIg7iFY2cDDX09Mm9wmEyV4oB8QfeBZgWlP+57TOgP2s9m+t/ikoIGzEr9Sqtpq2ibTcNhAbuB7TQixKtxr3Oic=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=dwY+CdVD; dkim=fail (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=hgtTl1Ce reason="signature verification failed"; arc=fail smtp.client-ip=40.107.14.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=KiFQkzOlgSH4IVj1TPNOy6IOe9Dm/Fo9n/WisxgSp2joZt+hMHX3uObCX80/FhMLqt6AVcTjpJ1NNOfl+Zl4TYvM4mMLdohSgqFRIChbVQlKx2BA6lhX4Gvk1UbuCzFmSMY8b66wMFvCLDNjXo6l2AbQ7U1z65KfPyid8V77c41SwRdedYmnZYcQYzTczTlDyuaVXBhGNnLu49pFNLClvhRP6ZeHhwhOOYjgs2oKncNxyfJxYkTubT/rF6wDX0cMYj+eZc21H/zgXbvTJ7PJnIAbUy9hCayIQ1y+bGxiLCfigSjFSWxekAi1p7TTwGkjZRquJGxOoAXoTEZ7iEV3AA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBaHIkF3EL6QCKFhih2ML4PbuskJI+QowceLHmBggqE=;
 b=ZBt+uLKLwAWdsOk37l8InQong313Jp0P1BvwVxLrViVf4RyFLBc7rlOtEI6T3zyRYe8N4rN2PwnZT/q55bVyjFuyCduoiNVwn3AkX530TNzxFEUvNFUgHFzscEd9Z9ounyemZGDbVgV1jY9BPUCWLHst83zSZ6yioVR3Ncx3sHxsT6s8NOdGg515DwTYbfZWjtOeytR499qoxctG6Tp59cM6PTYqamIG1Lg6gLwFIBDqIMsjMYiglrCTlCX/UW/KhzEmz3QBI29ZAqx3SfWWltWGqKDlA15Nkm33n6oLEV8cSc5JxXkAsS3CDJzKCtfWwiK87ZfwO/rOgylbTpXcqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 40.69.19.60) smtp.rcpttodomain=linaro.org smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=fail
 (signature did not verify) header.d=topic.nl; arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBaHIkF3EL6QCKFhih2ML4PbuskJI+QowceLHmBggqE=;
 b=dwY+CdVDAoatW9wIg2+uxlv6MCyPKKMaXmW/i7oBXrJ/d+NRVMl2DDBf02qVnrSFZh11kvK0vHKF7LC8cUcMlD1ZgpkIzvl2b47ucipu/PGBh9TCwmo3p3xsj2ZcnSN1TLQg19xxAS6mcASjZQaCSJ+5jofwcVTOHGBRD9iJWG970wFFDVAglzvIB0oMwVH9CraMu9oIq4/MG1c4JBC6N6Rj760mA7QVoP4u37jN7kWFS/scUeqeUrImbyrw6z9pme9omIAoMUBwCAiNIM64hPilu+FoTG+rD8AwQJIBtC6o3ZcAlETY3ahsjtQoIMDgi+2NaiLZNQMtvokVaS0mdQ==
Received: from DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) by DB8PR04MB6972.eurprd04.prod.outlook.com
 (2603:10a6:10:11c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 12:12:52 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:3c3:cafe::64) by DUZPR01CA0014.outlook.office365.com
 (2603:10a6:10:3c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 12:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.69.19.60)
 smtp.mailfrom=topic.nl; dkim=fail (signature did not verify)
 header.d=topic.nl;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 40.69.19.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.69.19.60; helo=westeu100-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu100-emailsignatures-cloud.codetwo.com (40.69.19.60) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 22 Apr 2024 12:12:50 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (104.47.12.50) by westeu100-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 22 Apr 2024 12:12:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3QLEIIOggXkFPJ816r1gg/ejGrXEfAv/yoHe5lMME3Be4LdrKfK+8rCMuu0lCdchpEY5XEb1rTVS3DJGAv1hkGZv/OxoUD/Ovfwp183jtf2bnn1MkddbGvYUE4bxVqin6ONcmIKVExuz0KPZ0Hz7u/iMlG4pNkKP0gSdA7M6/hTF/UmhY0gRh6BCiPZ7fEv+EJvrxN2LoHtKGwiKrM16AxXBdyltjyTJHJPhOSTvDIzskchOwbzTyWnqC/Roxi9vLlkofnkFmYEXsnruQ94p/Rhk9rx6emtmqxlctn5rDL4/P2/RfgKcXOquGQZQrAO2drKpZcn3JGnnN7EDUNxdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kprZkQ3D3cG6zK7VVEFH294NPE4/egQ17hyOOEpGmbs=;
 b=PXVVEuPC3NgUZSGZj3bXXmdiTjSZMkzMnG+F+wbkeJ+Dvs9Yh992wpqhJIWtFPFuZvKTqzqtqbtSdWzXYUZyjSz/xSzpk3BRPBptqoUvXrFiRsVKxoLE3JOeT37cgUcc6vJim2iFao0AZ+eZkNIgknvcxFSca0p1jhaE88DXjuilJVhzoAQA2DfDHv3fPuU6ML1UJpEo2me3MlnZz9WtaiULxKGHWbxZ2pHzdQcM3cEFyTNkRMf8sVTloPZGxvRtQymcLOg/e+FL8wg1ZZmidK+RpMR1+qJjqhGdtHYx4QhvdQYbcOocSH3tGGtwRPPWqedA1t/0DY+kAy3XCGougA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topic.nl; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kprZkQ3D3cG6zK7VVEFH294NPE4/egQ17hyOOEpGmbs=;
 b=hgtTl1Ce/D7nqBgxuqAhMaQUis6uY7qjpGt5qY84zorcTxfCe9Tefqk15CeU7J3Ba1sSD6CpzJ3WxkJDRgZvs3ztkc+49XHRDtn9Pf21RWf1f+Su2NHXC++33dlzQqnkmYYCxIAMXecoTsU7oYps83UoOGechiWsXArDSK5qa2wikizs5rjcLasz7UbTny00AxS9qn8F5KJBP3ugCw7I8nVTOKUFYeaQ/fXIApMadny5S/HAgzU4ZY6UtAq/Z2j8c8ppvew7DQIWI2tkGeXNdpdgxeOpIUgmcOLGjovA2/azV2sZhhphRRBxEMp0hZHCij5BuD5ASEcoeSg+rUNx1Q==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AM0PR04MB6804.eurprd04.prod.outlook.com (2603:10a6:208:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 12:12:46 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 12:12:46 +0000
Message-ID: <e910a7cf-a5a3-4272-8695-138b6aeb6137@topic.nl>
Date: Mon, 22 Apr 2024 14:12:45 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v4 1/5] dt-bindings: power: Extend battery chemistry with
 capacitor
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-pm@vger.kernel.org
CC: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.b2a893bc-f00b-47cf-ae07-b37ec1bace22@emailsignatures365.codetwo.com>
 <20240415081305.316107-1-mike.looijmans@topic.nl>
 <1f94ee56-7f8e-453b-ab86-f640b298d81c@linaro.org>
 <16ff3a55-3d04-46e6-b78c-c1964c062329@topic.nl>
 <eab45cdd-a0b5-4766-b62c-00c1a92a3618@linaro.org>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <eab45cdd-a0b5-4766-b62c-00c1a92a3618@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM4PR0302CA0014.eurprd03.prod.outlook.com
 (2603:10a6:205:2::27) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|AM0PR04MB6804:EE_|DB1PEPF000509F1:EE_|DB8PR04MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: 270038f3-c777-4ddf-722c-08dc62c587d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UUdoUUhkYlM5YWNuY2ZFckN2S2hXTzB4QmQ5aGtkWlMyYW5FQmp4cG1XSFV1?=
 =?utf-8?B?TFgvbHAxenVXb25zY3FJQXJjaEZVaDIxcHp0RkpGSkdnc1J3dmJXeGt1Zk1h?=
 =?utf-8?B?czJRNUNNaEVWQkV1Y2RndUhiVmFNeno0UlAxZXN1RG5xS0t2M3J0V0h1YWxq?=
 =?utf-8?B?ei81blR6WGp1c2VDdkxZdjFJaTkzYWxoU0I4VlJHTU40QUNkbW92T01HRUU1?=
 =?utf-8?B?OHhxeVZtbExXbHRuTWJtWlltYjBnd3RIZ3NDcnNTblZXTXd2d2xYb3U5SjNK?=
 =?utf-8?B?NGVXQ1ZXWElMa3JzcTdEU3hNWVVXVmhWQ0c0MGRXRllhZU1IOGE2cDI5MTBn?=
 =?utf-8?B?VGcwT3hWek52WXlEQ1pTcDhBanJSMHdxdFRsbGhPZW9NRS95VWc5cHJuWjVR?=
 =?utf-8?B?NGJhMXR5Szh6VEdmZ3FwaW9KRzNib3hoT3cyamJXK3p1bE0zU0k0cStrUWx5?=
 =?utf-8?B?Unl5TDZaOXF2Qy91NmJEeTBUdUxuV0NVa3lWei9Zb2VGdGZZUGRycVNvM1I4?=
 =?utf-8?B?R1VpR3d1V2hIYlcwdGtCeUJmaW8rUmNKYStYSHk2ZEorbU9jV05ueHU4SFdS?=
 =?utf-8?B?VGpCZTdadlQrd0tGbXNCS3BCU1puWWlzbjRGaXk5ZmJmd2U3amZCTStPbXlm?=
 =?utf-8?B?S29MTUZWUmFDNnNmUlMwWHJpcmFHZnBrejhiMlEwUGlkeExySVA2bFdaYnZI?=
 =?utf-8?B?M3Z0ZEhtcTRkcTVyR1Y0VTZIU1YwMlUwYUhEb2R2bnRRWE1HMVA1YzZhdSsv?=
 =?utf-8?B?RlkzNmFLN21mbnBWak4rUU9XNS9EZzVmL21iYVR6M1h3YzkybGFQSlhCa252?=
 =?utf-8?B?WWpwa0wveW96NzQzZzlyN3NiS0hmejBjSi95VERpUGxXdjhzbEVHRjgrT1NN?=
 =?utf-8?B?dUhuc0Rha2o5UlcyWmE5NURTWUUxdG9pcUQrSkdkbWlMZHh4TkRqZWZGZmxx?=
 =?utf-8?B?aCtKaE9VaUR2bjZ4NERMS2s3cVVERmVQc1piY1VMUnJSWTZiZFdidlpWQ0Z0?=
 =?utf-8?B?TklsMTFtRFNIckF0akVqN3crY3RVQ1prNXBWWXd2WEdic2dwQ3Y2OS9NTXU5?=
 =?utf-8?B?eGFURGFGWG5DUGQ0ZXc4VURFMTZZdDNYb1FOa0tOcjBkSkNJRnZja1dSWkUv?=
 =?utf-8?B?MTMyM0EzWktPb3hyU3lOclVUMmhLb204TkJWNGhEUGRJcGliT24zR2k2Z1FV?=
 =?utf-8?B?ajZMMUpoL1hoOUY3WU5aV0laWk9zUm1nZlJScUMyZlR2S0g0VkJOWTRKMURI?=
 =?utf-8?B?bTgveTVjUnNDVGdlT2NzeGhjRVpScmJkM2U3Z3EyVGFCM2hoME5Cc0lqTEE1?=
 =?utf-8?B?aVpvRzhkdjFMQk9pWkVvUWEzc1RSaUh6bUdHWmdmd3NvWG82djhJZWpFNjdH?=
 =?utf-8?B?RTBMY25kTlhCWDN3YmFEeC9uR1NQaWs3Nml5WnAyWUdYQ3dyeGNHdk9CS0Nq?=
 =?utf-8?B?amRQTTJPOExNYVRTWHBDSW8raXdFd3F0MFZubkFINXp5YlZxd2djZ01sMG45?=
 =?utf-8?B?cnE2YTkzYy9lMDhCR0s2bldCYjNpdGpoQWNHaWt2RUF1THNPL2RadmJFN25C?=
 =?utf-8?B?dmpkUCt2bEZ6czhEa1lBTnFLeGpTYTJlV2FyblBUOWtzUDQrZk81VXh5aGMx?=
 =?utf-8?B?bGdFeXZBenh2eTlkT1BnMHZsUzViMnphN0RSQzY3NGo1UTdCWjJ5ZW1LaEpO?=
 =?utf-8?B?ZXhlcjA2K2NRejZ1YnFUY2tveDhkaWNLWExaeXJDa2xJN1AzTHNBTDNBPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6804
X-CodeTwo-MessageID: 8923e685-922e-431a-a4b6-a49dfaa04aef.20240422121249@westeu100-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d62f6644-d0b9-4542-a412-08dc62c58550
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmwzUGFBK2xpTlN3dmQ5Y1QvY3ZkZEE2eUl5SDJEVGxJNVAwZzdDYXZoMUhw?=
 =?utf-8?B?QWlIdkV2YUE4em9Rait6YjZKVlY0ZTF5d3h6NnNmNzJYL20rR1Ivb29rRW1N?=
 =?utf-8?B?dDZjTFZVeUZFWDVoY0k5RjdrcFJvRG5vNTJLVmY5dDJ4SUZxeE93TUROM3Rv?=
 =?utf-8?B?MnRtZGdwZFpiVE5yaWdEdEtkOUR6MUp3QXFZUkxQYk5Pc2dlZkxVbUNCSHNC?=
 =?utf-8?B?cnlKQWhiOEJ1dVRqSlVLdXRRL2hxS3pONEw2QUE1U0lQUW44ampKeW1TNTZw?=
 =?utf-8?B?M0ZHeGRKZmJUd2ZTUlQ5VHV0OEtWNDVQMWUvMmp2MmplbzM4WHlkZUoxNjVS?=
 =?utf-8?B?TjZFSUYzV1dxVkE2Vjl2Y2haMDBjV2JsWDErS0xsaEliN0pXWVEvVVlUMUJC?=
 =?utf-8?B?SDRrY1VYcE0wdE5uWVJpQ1hvVzAzbUNpLy9IeHhxenBTOG45Znk0K3h6WUlr?=
 =?utf-8?B?cDVkVXUweDJkYk0xeWMzazArdnhER2h2azRmVUtuMTJmWjJJV0dUb1I5TnFq?=
 =?utf-8?B?Tzl6SklJeTlxa1ViOGlhU0llbzdqOWEvdVpXcklQNS90MFdWUElEdnpHTmRP?=
 =?utf-8?B?L1FiZFBVVUhwZmxlOVlXandpejlQbnpnOWVzY3p5Z2t5akdzaXBjZkM2bmtL?=
 =?utf-8?B?aWF4emJSVHBJT1pHcFdhVGdsS2JPNlNiMldaTDN0elJEUGx5TDk4TzdXbVdY?=
 =?utf-8?B?UFhpV253T0c0Qit4VGpGOEZBM0VnenFkNGRMcGxiM1V4T3JkVEhCc3VXYXNO?=
 =?utf-8?B?Z0VTQ0FveUtRZFZ3cnduU2hzaHRBZExhTzk0YU1XbzdvZVpGWktDRk5MR0o1?=
 =?utf-8?B?d295R3oyYVFMQTM2SWF2a1JVQXRzRy84WFBvU2lXdmxRMDJHRnhVVkhvbWhI?=
 =?utf-8?B?SXRueUxQU0xIMjJsYklaTlUzVVJ5Ty9FZFA4SWdSM3ErWFU4aEdUSGVJanNS?=
 =?utf-8?B?bmpYVGJTbGNnbEhFRXdZVGhiTmkwNzMxOFg1QWszMWNLS083ZlpVMVR1Y2c3?=
 =?utf-8?B?RHFGc1RZc2g0YjB5THU1T1ZZQjFlWm1uRG9rSVVqMnpkWDZ5M0M4a2lwUTQ3?=
 =?utf-8?B?VEtNTG90S000U0RTMzd1NUxISVdkc3IrSE9VazFmbjh4MkhJQnlZZkM0YmNO?=
 =?utf-8?B?cjFITittNXdJdmtneHk3MUIyR3c0a2UxWnZ6U2w4N3VyNFBoWVFIRVVhb0ZK?=
 =?utf-8?B?Ni8wclorVHNrbVVrd1hIUDNia05jaytMSDJmdlN2N1crc0U3clp0T1JXaDdH?=
 =?utf-8?B?dFZyMVBGekFCZXdkRHdtdXhMaWgrYVRaS1JScEdLODk1NUxuWEd1ZjloaitK?=
 =?utf-8?B?SFpDWGR5Z1hwWFF0SDlKZjB0eUpoQkNXVFlhQWtZTkRwUHVaVHRFUUtvRVBN?=
 =?utf-8?B?VHZwYkFIb3V1MzJtY2VuVWJZT1p6bnBQcFovN2pWQjAydFlYemJiRFFQR2hW?=
 =?utf-8?B?bmN1VGcveFJIRWpaaFk4QnlDdHNqcGdiTHFxTStLbXAzS3RLenJpTTRkRkVo?=
 =?utf-8?B?aEtZRVhLZWpycjRPVm9yL1pjMURhdjIraGNZRTRwMUJ2SW1qcy9pek14Ry9o?=
 =?utf-8?B?K3gzcmFXQ01TOG5mcjhadWxnS1VaWGU4S0dqdkwvMWhMZjQ2ME5UNVdZL2do?=
 =?utf-8?B?c21oVDl5SmZZM2FXSyt1cGo2eldud2ZhSHZ0OFdZS3dneUc3OFk1Q2dmMmlI?=
 =?utf-8?B?OE05Nko4SW9Cc0ZPL1o0SE5UWFBoZi8rMjZ6TlBaM2U5Umh1MnVGNEQxUU1K?=
 =?utf-8?Q?mtsCwOj99gSuGHqdzoEEpz77DCHNcdLeYHkaJ6F?=
X-Forefront-Antispam-Report:
	CIP:40.69.19.60;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu100-emailsignatures-cloud.codetwo.com;PTR:westeu100-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 12:12:50.6447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270038f3-c777-4ddf-722c-08dc62c587d5
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.69.19.60];Helo=[westeu100-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6972

On 22-04-2024 13:56, Krzysztof Kozlowski wrote:
> On 22/04/2024 09:50, Mike Looijmans wrote:
>> On 15-04-2024 17:24, Krzysztof Kozlowski wrote:
>>> On 15/04/2024 10:13, Mike Looijmans wrote:
>>>> Another technology to store energy is a (super)capacitor.
>>>>
>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>> ---
>>>>
>>>> (no changes since v1)
>>>>
>>>>    Documentation/devicetree/bindings/power/supply/battery.yaml | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/supply/battery.ya=
ml b/Documentation/devicetree/bindings/power/supply/battery.yaml
>>>> index 491488e7b970..a22c97dfad88 100644
>>>> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
>>>> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
>>>> @@ -44,6 +44,7 @@ properties:
>>>>          - const: lithium-ion-polymer
>>>>          - const: lithium-ion-iron-phosphate
>>>>          - const: lithium-ion-manganese-oxide
>>>> +      - const: capacitor
>>> Please keep some sort of order... everyone insists on adding to the end
>>> of the lists...
>> Could make it alphabetical, but that requires re-ordering the existing
>> ones so "lithium" sorts before "nickel".
> So just put it at beginning, less sorting later.

Ok. I'll wait a bit for comments on the other parts, before sending a v6=20
of the series.


>
>> I think the intention here was that the order is the same as the
>> matching defines in power-supply.h
> There is no such binding as power-supply.h. And other headers do not
> matter, they are not bindings.

Clear, thanks.


--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl




