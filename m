Return-Path: <linux-kernel+bounces-73803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5685CBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBA71C21D98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698B154C08;
	Tue, 20 Feb 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QCPP0Od2"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A1154457;
	Tue, 20 Feb 2024 23:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470429; cv=fail; b=NU4qB+ab96Q88yiPThgymGkKvW4Es7I53NfyTB+FGIlJ3Oj6sMRbIlZn+T6IP3vkgJYO3krgirWqPeJaKsyQCuOpCVa8rQ+IbEuBU1OGMuI0CNessKPg1/0EKlcREUjHLdJnWfKlfm0WTwomZGgWf3np2MtnW8pnjsOI8CtWzxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470429; c=relaxed/simple;
	bh=OgS8EYvecl+MpyHyrVcxAqw2kBLUqwYfmJ7UiU7uuDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NJ16iuXRyBXb3/oaVW8TC5LFHvqPr6EmgcMvkz6z2ihBDnyBxZTd71Rasv+flbsGZ9FV2OEFqUkB5HAIXYKXL2Vx5ssisWRc0UQCtVeGdw5lnq7uJBKqzwV7WksESLrTTfwsJRqNYaihwwPzoYujPe4G7oWkTtdkvBp81GODmqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QCPP0Od2; arc=fail smtp.client-ip=40.107.7.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml73/zVmwuP3p+nBf2hDq098G5VMaiYY9i+7OyqbGPq2f0q75ybrYY+iZ43vig0tyBVKTV5/je+FWFZx8Q+Pj1F6xqp+ca35jFW/otPZ9eK/qdjhuHuzYBNDieuIp+J9FH8DiIP1IesYjrF/CIcvaWduT5VRvD7yD/bNYe7mVYwS/Jxb39heLwn1hxiTkuXuqjS7Z+R2TVqgwmo5o8VUU/wHhM+zrIjs67+W3x+fPCFmsWxUHYBmYiKduKmN9esPn0qXZs/qVJ1MdTjPfdekmv3HQBH8ZTPTrnRlxTvkOZxtuMyv2HjBuZFcARL0OsEK6+1gtcdZKYuZbNN3TuchNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgS8EYvecl+MpyHyrVcxAqw2kBLUqwYfmJ7UiU7uuDI=;
 b=Klqh9VbNenNTLcRpsuaEeIgCt3IXQ3OCc6dRNtZz6gzcfd616QJfRLIj4EEdSfHDI+SgTTW0Vn912aF6DDSt5ahnb1cf5MKeB/wnzOFFXee8fqfwse4YeaoUn3IRpvN2//CvzxtQFiaer01CxXczrLMoYZdrjGNAHYZnxlfOFiImQACwqqkMPY+39xaMJeJGkuMtsnATpHgtkCJvmraQrJXG61El21m6/mr8ZH+Brpwf0w9zA6S43dfQZuzOerRaF9s78u+ZCfQVwNhnEPGbk3Nmae0nYOvSAovZ6JF+V0Ux8va/s8mPz8OOfs9ilxwMSQASRup73C24OYoSukhzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgS8EYvecl+MpyHyrVcxAqw2kBLUqwYfmJ7UiU7uuDI=;
 b=QCPP0Od2Vcn502oRopDBhnMz5ObrJOULHb9UpG9J3yQNtngGOro8VxGw20EfGlkol7SVsUwOz5oCfBTrtxPPiXRmn4uVIv7sDYUH2d/0UjerCHSwips0KePj7CnN1Bt/T0gWYwcpe8j3Z7Cr4YCNzqELdHMnb8VUVb/HkwyzjeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by PAXPR04MB9491.eurprd04.prod.outlook.com (2603:10a6:102:2c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Tue, 20 Feb
 2024 23:07:00 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%7]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 23:07:00 +0000
Date: Wed, 21 Feb 2024 01:06:56 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: zachary.goldstein@concurrent-rt.com, Shawn Guo <shawnguo@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] arm64: ls1046ardb: Replace XGMII with 10GBASE-R phy mode
Message-ID: <20240220230656.cefvrh6avji2elrd@skbuf>
References: <20240220145037.kf3avnykjif24kkr@skbuf>
 <191b4477-7b4b-47eb-bb3e-0e4d08b3b32e@seco.com>
 <20240220223706.o7wc5r57omkmgtgh@skbuf>
 <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39c811e-ad9d-4e90-8710-629b822944e0@seco.com>
X-ClientProxiedBy: VI1P195CA0093.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::46) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|PAXPR04MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3a9ec8-bee2-4c50-c007-08dc3268a4a9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
 M8SNQBMsFuNWuvRQJmAFZZUew6ugNcP5DSUBxlr6c3n04Fo6KGy4JC3xfUAF0+oMbwyGICTcRMmO2iYVxEsWHSeQwg+fu5jDBDtiZu2MMLjjcKWVv5To6HGieyHn3E1T5G6o3jtMubEWrcSg3lSd6Nh7vxXhzHzMSR0WpNUJA1JhVPDxw+iz4sNxUYo4CgQuECnIbq1q/ygoIuKwN2wgfYRK3eBL7PwavMdvjPE7gxESXJdoxkd900Us7UcJBDLI12lgampdrXCy5G7zQNKA9zX5I4bcGRImzey/A73ftUZh31/tD5GkipnqtYmHSIAIQihVl8LhwcnQ/NUY805rvdqNRitSS6vDTY0w2junN05DHbtPcFEEepAYouqqlaB787Q2lOprBKpRiDVJUawgGbImV0aloynkyj8L3n3+rYcPlTnq+zBMUiKoodjxOSR5Pvn3AcF2AeIyDkLyAcFXMJqokVvzR4AOZR9mm1a0Uo+fM0JW5feioU3Najo/9PnwrLrZ4Lrt25p3tfCDeQRI0HwszFFQ+LcYdccsxS1+8kQ=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?FPBg68x0qdoroLnzZyDOg+D8eUVqYvsTOcK2++Fvz5ZvX9uw55cxWpbaKYej?=
 =?us-ascii?Q?1WOYgSKx1S9ewpwsuh3E04Onj9fhC5qMQVXcCZ+IdfQlwCiuKHByyNvcIj3A?=
 =?us-ascii?Q?uHJ1leXSB6+Efg6YXW73T7BMuVpzoo2FNNtmWhnWr+cZrdXcT/gSqrTPkOyq?=
 =?us-ascii?Q?wWeDKvkrCf8mbUVDKrYK+brJ1bJlTwQxtRTnXAJg0FKp4Qrggxb3vGTA0qvV?=
 =?us-ascii?Q?4eWlEeXnuclQ8mVK5G0CDvGNA2t0cHPsMrdT/e1MtVCSyiRn/7zVE+fxRO0Q?=
 =?us-ascii?Q?je946IIZenXxVrxcpnAfSe2IOmeMRlENfXRPjWwCjkOZIfjLpLrB10CtrnR3?=
 =?us-ascii?Q?o/32qe9sNWAJiAI2tXwubvrz+XLfKX0/wbPr5tA+t3TIQe4rzVWbwqoyQtN6?=
 =?us-ascii?Q?FzfrDHagpvnbMebRs5d39uUmxOBPmJ/bjohW4GlsZHEVoLMoO2DtR0qu2qHZ?=
 =?us-ascii?Q?cqkC8CIDP9melgXntDjpDI82FH1K+IGscwrlC6reXSqM76ixzUN2n6iLRTrp?=
 =?us-ascii?Q?+HK5BhxBZ5eEzAbQ2E5TfCF7gOT3vmFxz9huOmWXdDRyYK7MBZKj+e7Ereio?=
 =?us-ascii?Q?Mm/UT5/HN9O9TZU9RWoL875DiIEALh3RoJD3VSLEopW/RnA9Ln+C54bWzDmc?=
 =?us-ascii?Q?/N72REOYS2MbuV94FTEpi22BcDvP0r+yLJBxF8L394SvRJFFX1OOiJn24Fr3?=
 =?us-ascii?Q?WZKp1AnuQljPZgNXL2LiQQ0wMtSP0+tnui0EifnMowicqYWbbYKqqsWA8Z6q?=
 =?us-ascii?Q?0zeyM8NG30MpCQQI14fRmgv2mxh+PlSCKSV+oenterUIqG9HWtwwfutmLSrp?=
 =?us-ascii?Q?PGOd41gKXJkkUI6gOQl7Cm5/yzd/Fj4/FiLPWTzLcGavN5XIFvow0X9s2Y2M?=
 =?us-ascii?Q?y829m8eKm3IXhvxC9FW0VXohev2dI7SSBgyEuwpSC9CBbvULY9iTvaVfF48T?=
 =?us-ascii?Q?qCUhOCuGaCb+vrsa9Ffdr3IiJb8RfLIkdxD+6z7q13nK2ebYrs+pj10V5amO?=
 =?us-ascii?Q?x9yLaPFQ44T0Lgphbig070u8Ifvvj24Mi+HHFYyUfINnAb/8cD7oby9ebWyk?=
 =?us-ascii?Q?bYrh9BVgmXoj8T9IPlSv8EtaNbgclbWBjoX0xiM8GCF90OkR1SFmQUlSGetg?=
 =?us-ascii?Q?2tZmd9wnh317lbOdjk7ij5Ua1wtMuLX+WNrLw1Q4xrTddciGSUbmrR+l6TvM?=
 =?us-ascii?Q?utml6s6mSIfnCq3iZy0sOJ1zS0H/tmF2wybfpQZe2x5rUHTvARv75nMH9BuN?=
 =?us-ascii?Q?1un4rjA4rGduniTzG0ti1Xod/lmvmVpIYggCoK+Rhx52JQ9NknQRV2PijOml?=
 =?us-ascii?Q?81ccWYAbyI5XWwcBIpFe5Ewkq8uhFcrDFuBVq9/8wf0WGt522e3Yn/p8NdB0?=
 =?us-ascii?Q?WvuvgbLFCvuzNw5aw9hCaNVVNGzXNeTdycO4A8bWpGJNlQvny4++5/ljxCbB?=
 =?us-ascii?Q?4v7DAgs/5nSlBHbXnIYjYQmx+R9VBeVmCn+MdOeFd3reWeFoSgABFSj1d1xp?=
 =?us-ascii?Q?/8tTp0G/MdA9tHucwoIFWFFplm7wKmPWMAzjjhzxPS0CrND/geDZW8c1qjQg?=
 =?us-ascii?Q?jq9cVbpyKs30B8PncQrvm3MyhTvGiH9Hk1qqa1Sm0RH1krdDI/6SvNR4KO2h?=
 =?us-ascii?Q?n7b5hSukA+YDlb4glT1+KIQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3a9ec8-bee2-4c50-c007-08dc3268a4a9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 23:07:00.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WBpNhSUux7URasLo0d82ozPt0Rbcmjul4VASuAh/u51SGkuVYJ/H6SaoJTCJMCKScZavuPeZdn9zxjtwlDIWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9491

On Tue, Feb 20, 2024 at 05:52:36PM -0500, Sean Anderson wrote:
> With SGMII and XFI, the PCS sits on the MAC's MDIO bus. So for SGMII and
> XFI if we don't have any labels we can just assume the PCS handle is for
> the right PCS. But for QSGMII the PCSs sit on another MAC's MDIO bus. So
> we need to tell the MAC where to find the PCS. This means we need to
> supply multiple PCSs to the MAC

So how did the other Layerscape devices with the same SerDes, PCS and
mEMAC manage to get by and support QSGMII without listing all possible
PCSes in pcs-handle-names? :-/ DPAA2 has the exact same situation with
the QSGMII PCS situated on the internal bus of another DPMAC.

It is unnecessary and buggy complexity, and it will only have to become
worse when I add support for C73 backplane autoneg in lynx-pcs and the
fman_memac driver, because I will need yet another PCS handle, this time
not even one that represents a phy-mode in particular, but a PCS handle
for C73 (with C73, the autoneg process determines the dynamic phy-mode).

