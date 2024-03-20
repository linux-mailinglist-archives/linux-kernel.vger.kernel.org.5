Return-Path: <linux-kernel+bounces-109009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE788134F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D544F284D36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997947A63;
	Wed, 20 Mar 2024 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="POyYsIdJ";
	dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b="POyYsIdJ"
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2116.outbound.protection.outlook.com [40.107.127.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8F446DD;
	Wed, 20 Mar 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.127.116
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944908; cv=fail; b=LYox7r+Sp2NhoZhzeNYssA/ZlgVSe7PPoglWRMwpjRoNraZ/11lRLe+MM2x0nHBuq3r83G4tS4Lh6bmAbWVwvZ5Gg2yiHDBnIOe3DS8/s4ZpiQFU1mNDVL8s0AuKwiF0B2CwBnSJe7pRrtZ+ArVF/pO7oqNUEc1lghCSRvBeo2E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944908; c=relaxed/simple;
	bh=BX1YjiFBJkdJEpd3yDk3mE2c9HbJaAJrBBD8UseV7sU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zjgg6lKogSLAfnlXGnmcAxmNsUMC2CExDITux5zWzOec1PYKhJVsj5luGvfFnrkpadRpmph4wpgg+by2UVsWBxmYzxknr6RKs2hhPR/NPaoSiUZB1y1CO6/t8UNwDQHLurd+MO/20zvzZuoLsv3pVEp5/uJCiuS6FtLNkGEiaPU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com; spf=pass smtp.mailfrom=iesy.com; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=POyYsIdJ; dkim=pass (1024-bit key) header.d=iesy20.onmicrosoft.com header.i=@iesy20.onmicrosoft.com header.b=POyYsIdJ; arc=fail smtp.client-ip=40.107.127.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iesy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iesy.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ed5vs8+RRk4vdLHhhswwU3xZXBOx8IwcrDazop/5Zp5Rf/Esk4eHzO8PkohUUQ3IeVmPgG3gvON9RwayDCsVTMck39wamtn2pIaEYWweIPrlYM8Q/1n3ObqP36L7+cZzdyT5TBjmxdHH7YxSPsG1KYj/atY3hu5DZHVxFaVgC/fDfozhIpLAPV8iMcuUSFrjFAFsDhWP2TOaD7Rzp8W/5OZsXdZRp2T2mKbu3HvXc0YwU7RxDXiSrTpmSZbOVn4hdoDsm0ReCYHMK5PKB1jH0cF+4zegyjnE6LLJtVRxjWfsyqRVGUOQF8FPsa8omJh1JwCdnAJy2Q5Ih6Qh16gHfw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX1YjiFBJkdJEpd3yDk3mE2c9HbJaAJrBBD8UseV7sU=;
 b=kZjYmefywjEwdnsJ9z0SKyIOBxh1CO2dBhRuWk8LUmyNjKh56wYODxt0dYJ3a2vv+YaLvhmRjX5SnyF4oIu8hGcIdYFUJfEkJNcfzTWD0ArFIGTHRvj4WyTmEZU7ghd8nJ9f5gNXPjhi3jPPahxclcUpXIFbOzhiqY/lZRTuwyFCzEme5o4gU6+wMuF5SLekHt9tG7ANryJiw9cDyT63oNfLzDHP78wOuYAs7kwTF3q1iCxvHcYpxljgwbeJxzzmgDgnbfFcPlzSF+p9eBQUtl/9CCs+EA8E+5s/jtuWYqLMxIl6HJYmmCIvG7J5KhEfqHFao/zQrw5S/23Q72Tl6Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 20.79.220.33) smtp.rcpttodomain=linaro.org smtp.mailfrom=iesy.com; dmarc=none
 action=none header.from=iesy.com; dkim=pass (signature was verified)
 header.d=iesy20.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=iesy.com] dkim=[1,1,header.d=iesy.com]
 dmarc=[1,1,header.from=iesy.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX1YjiFBJkdJEpd3yDk3mE2c9HbJaAJrBBD8UseV7sU=;
 b=POyYsIdJ3+j40EkooO5WcMaccGXH4LR36Rz9/COxR4Zh1ByTCGn5pkESu0uey246SN647mD7cBnkyHIOyVXGHeEya17fBPutsj+elzBDD1R6xTeb0A3Ht1od5ppBnf83Wxax2VwlaCAzlu5dTnGlPNq4x4EvU0f5I5ISpeKQgNE=
Received: from FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::10)
 by FR2P281MB2896.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:69::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 14:28:21 +0000
Received: from FR2PEPF000004F0.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a:cafe::5b) by FR3P281CA0047.outlook.office365.com
 (2603:10a6:d10:4a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.14 via Frontend
 Transport; Wed, 20 Mar 2024 14:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 20.79.220.33)
 smtp.mailfrom=iesy.com; dkim=pass (signature was verified)
 header.d=iesy20.onmicrosoft.com;dmarc=none action=none header.from=iesy.com;
Received-SPF: Fail (protection.outlook.com: domain of iesy.com does not
 designate 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com;
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 FR2PEPF000004F0.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 14:28:20 +0000
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (104.47.11.169) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 20 Mar 2024 14:28:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADLjnHHbDVB06awVQeK8jf6RH08u+ADkWEKbhBP0DMOqEh3kY47Nn0jUHg4VveHEIAunxYQAtVZa/jdcS23G+53gBS0vCAHi1mIFDINVhShr911ioukoNPy7/yBtrjeR1kEQF0mAnqVre6tTgRNNREQf7eQJO3JwH7tQj6Hnnh0ggJMMb0GciuMMdcQZLkhiMUCeaiAhc2RcXXS1/WNB6wbbiih6BSq7y8NsV2QJ45PaoGJD7d1K/GIsoP49jn19Sr26GEqKPyV9fPuo2aNW84xQDVUcRGf+XrXni/9qWDmjj79i8+H/TYQJpyFaFHvs7A+ssupIxUyUQGJtM46ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX1YjiFBJkdJEpd3yDk3mE2c9HbJaAJrBBD8UseV7sU=;
 b=MpK/rIq1hH7Ngn+r5GNG23o2mw7ABByQ7YV7nzP0sFoBvY+qb7RIVcgrvkFb7SkNMd8XjoUndVLVk+/mg+TDoDfZcr9VXzMk5gRjsrto02c8Y3CQwNJvPrYdolGgbmy2On8+njQKr/nCM4qqbS6S6D99C5Z9md8TS8AVZMEG42gbkGnqPyeli3T+6BUSxABDzop7jld9b9VrQ9FrLehP80X00MmDLSKHyO6/zdmgw3vX/hbhOnrs0/jU7HzxHykFvZMRXw1VrKIM1+djBGH6vJ/nrUOjbH56ViQzxp3/U5VuDJbmwPPeJpAHF2of/uFeBYbsnEUh7Vow5dbirEz/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iesy.com; dmarc=pass action=none header.from=iesy.com;
 dkim=pass header.d=iesy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iesy20.onmicrosoft.com; s=selector1-iesy20-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BX1YjiFBJkdJEpd3yDk3mE2c9HbJaAJrBBD8UseV7sU=;
 b=POyYsIdJ3+j40EkooO5WcMaccGXH4LR36Rz9/COxR4Zh1ByTCGn5pkESu0uey246SN647mD7cBnkyHIOyVXGHeEya17fBPutsj+elzBDD1R6xTeb0A3Ht1od5ppBnf83Wxax2VwlaCAzlu5dTnGlPNq4x4EvU0f5I5ISpeKQgNE=
Received: from BEVP281MB3754.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:92::9) by
 FR2P281MB2858.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:68::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.30; Wed, 20 Mar 2024 14:28:16 +0000
Received: from BEVP281MB3754.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c182:1530:8120:1726]) by BEVP281MB3754.DEUP281.PROD.OUTLOOK.COM
 ([fe80::c182:1530:8120:1726%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 14:28:16 +0000
From: Dominik Poggel <pog@iesy.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Tianling Shen
	<cnsztl@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, Ondrej Jirman
	<megi@xff.cz>, Andy Yan <andyshrk@163.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
Thread-Topic: [PATCH 1/3] arm64: dts: iesy: add support for iesy PX30 SoM
 OSM-S
Thread-Index: AQHaeeOYXG8qi98U10eTL14h9Oyo/bE/AZoAgAArsQCAADzhAIABR74A
Date: Wed, 20 Mar 2024 14:28:16 +0000
Message-ID: <3c942ee4-40e4-47a3-969c-b1c78e2e74a4@iesy.com>
References: <20240319095411.4112296-1-pog@iesy.com>
 <20240319095411.4112296-2-pog@iesy.com>
 <b4f4f8e3-9832-4789-b4fb-beeeeb5c859e@linaro.org>
 <8ace15e8-0da1-4384-9042-ab89329c352a@iesy.com>
 <ae8e8151-b73f-413e-8535-95fc829654bb@linaro.org>
In-Reply-To: <ae8e8151-b73f-413e-8535-95fc829654bb@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	BEVP281MB3754:EE_|FR2P281MB2858:EE_|FR2PEPF000004F0:EE_|FR2P281MB2896:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 byiX4IWV94EehegTNjq4ylJkzSXPdbjYigRdfkyxSAdvmHh4kSXy0SYqxmf2j5xfdw4auk6iR4aeUM3YBooE+4dKa+XR4WjjfJLnp191hoqnM05U33PvniV++xxlG/qZkSi/w4efCnQ2GYols190s5RSHOpvlg+jvWIG/P4nX9tqCCYD1pIrtRxG1nRv+ZqqRxUPG5VvDqbutqa4wwjW8/oV3EFcuHxk8wZu5mWiNGkp7aFxOj37CKol/eM2irjmoCyzsDzZyGySEiO1ZtPBM+4BuNWoHR8cguEYZReiT8/vN9N+kP2jihN0nTfiVBDr6PD3uBI6cERMJdAEz3ipWI1KGReVSgdu7ejQQGN+qpqH/UWB4e4Mt8ZuCqV8mOH4StO+SSM9K2EyAfH1Y56E7mLMuimSB5FGH7qKA3hT8fZP3NXr1Rfp5vYThC5pJb0z+1UjqVE5DdiIyCq0K6lRHv9W7jcvIDqbRJlpc08SPaikyMMGfOW2iXgNr7TYEMo4XVUEPplf3vpOL8e7LIawl6USvb9MPI+i4cYScVhvnr0E+gTbON0n1beIRDM+5zuJnZP9YFFJ893RBGqFgjZUvIcVv3aBvpA6gjQGZFOE8jk=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEVP281MB3754.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BCE7750B04F1D439CAF95E315DF2CD0@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2858
X-CodeTwo-MessageID: fcb39269-7d33-4daf-abca-1cf5a27c997f.20240320142818@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 FR2PEPF000004F0.DEUP281.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eb42401-ce86-4064-1144-08dc48e9fe67
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	up1rVD8YvM3XA3gn6moOxWHUfe0HqclVWsrdOoM7fQqWa9GOjvktnvhxgMr6vAMgclYNGT5EsryFUaoWLT2CD5pEEmh3grpesLZfqRySeKMv8W8JY39Uyr1h8m0WtezxFcTAYfIpn14IGInsguj5ei6RciaczsakVPkIi1KEG1bQz7unUiOsbhBO9/K9jCgG9tPDhdrIBALf/P/Fpw6z+hU0qVoe/hb2dpZ3LEIsVRhmLFa9OpD+x50aqg9+Kn3egoTlwR2QXPpm5MVNwPr/YZkcCaQA3U2f69mF5LFy6jme2OAsOjoihgAGyW/YORqj+Y41VRoWBEI++fd5Af+t5FW/Gm08c1geFIIO8loeAMWOaVSBzdG4nr3CiMl0MXAKKLa4xU+HMJSgbH2832HnCMNaLk/iP1HNPC2IHq/6zMEk0YtBevgMSJZ6dvukMYRlBUtwvfIiSy82TewX4X8V3viAi/0U9+FAIQ4b44Ie36ukQ9uZcNPZwLsz3dEUjUAssusrp/GCKKRkU6bdylCONUS5cZPPvAIICmSkHv/lpM/S3qLuHiW1dIjEOZVroh+CieBQONR9z9u8pvO7g+EZr2oSyHzarwDZIDYKXkLCTg79ZkwrBWsR+T5CyEDwAiOAcUsnzkaBv09oYta/jiwW4AX2eCSZnQpxK5kGzj9DrIWrI7jFwnAC7EnRNWzRfCDWrbqd5uBB04aASElMtn4ukvsyRe9jdAnrNDg1L3U+jcw=
X-Forefront-Antispam-Report:
	CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(36860700004)(32650700005)(82310400014)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: iesy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:28:20.3608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb42401-ce86-4064-1144-08dc48e9fe67
X-MS-Exchange-CrossTenant-Id: ace663fd-5672-464f-8169-8d373312f6bc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ace663fd-5672-464f-8169-8d373312f6bc;Ip=[20.79.220.33];Helo=[de1-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: FR2PEPF000004F0.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2896

T24gMTkuMDMuMjQgMTk6NTUsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEFjaHR1bmch
IERpZXNlIE1haWwga29tbXQgdm9uIGV4dGVybi4gQml0dGUgYmVzb25kZXJzIHZvcnNpY2h0aWcg
bWl0IGRlbiBJbmhhbHRlbiB1bmQgZGVuIEFuaMOkbmdlbiB1bWdlaGVuLg0KPg0KPiBPbiAxOS8w
My8yMDI0IDE2OjE3LCBEb21pbmlrIFBvZ2dlbCB3cm90ZToNCj4+IFRoYW5rcyBmb3IgeW91ciBp
bnB1dCwgSSB3aWxsIHVzZSBpdCBhbmQgcmVzdWJtaXQgaXQgYWZ0ZXJ3YXJkcy4NCj4+DQo+PiBV
bmZvcnR1bmF0ZWx5ICdtYWtlIGR0YnNfY2hlY2snIGlzbid0IHdvcmtpbmcsIGFzIGl0IGNhbid0
IHJlc29sdmUNCj4+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1s
LiBQcm9iYWJseSBqdXN0IGEgcHJvYmxlbSBvbg0KPj4gbXkgZW5kLA0KPj4gSSB3aWxsIGludmVz
dGlnYXRlIGZ1cnRoZXIuDQo+IFRoZXJlIGlzIG5vdGhpbmcgdG8gcmVzb2x2ZSB0aGVyZS4uLiBk
aWQgeW91IGluc3RhbGwgYWxsIHByZXJlcXVpc2l0ZXMNCj4gYXMgbWVudGlvbmVkIGluIGxpbmtl
ZCB3cml0aW5nIHNjaGVtYSAoZHRzY2hlbWEsIHlhbWxsaW50KT8NCg0KSSBkaWQgdXNlIGR0LXNj
aGVtYSB2aWEgYXB0LiBGb3JjaW5nIHBpcCB0byBpbnN0YWxsIGR0c2NoZW1hIGRpZCB0aGUgdHJp
Y2suDQoNCkJlc3QgcmVnYXJkcw0KRG9taW5paw0KDQo=

