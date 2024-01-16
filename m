Return-Path: <linux-kernel+bounces-27435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160E82EFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9F2B22DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5331BDDF;
	Tue, 16 Jan 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GBENHy+9"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EACE7483;
	Tue, 16 Jan 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMlI0AY/eQatCyDmjnaY9b2frI9h6EMxOgwHtXccU9e345xNWdSRbUJDGJqEB/PTikD6HGsMk4SE5V8gP+c6wNSW67+3eNQKo4xl/uWItk5BUo7o1omTvn1fIqwp9WpE42ob0pFw5j+8STjartTuKEuzk6UruCbVqHM5wuP011OHJJvP7WVLUJLfD3XbpWZFh5x18uot3zC3A67nTbSC6d8BVNpB6GuN2N+49DPnI5Jdvvl/pMUgDLeity1RXCi4NC2SZBAJQbQix92CDPwqXElPjxtwVKNP0Z+R1yt54aCoox5Jse3VRo8vwijgWQMcM4m79cDTgIvyJqNyhRhWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iblCv9MzUfitWDaZ0dHUpp9hmowRAJs9+F6L7u5Jic=;
 b=EVP3RyIvVRg9gteOlc+0msxDpSWn9DCS6C+uiky54cDL/nMKyKC96hhzXx4q41RWJjZBD6fdkKBpwhyxP8JdDcRyVaUf8cIyM4KvrKs4oPoIdGf9Pe7ZhOPpW2Te9HDa9DfxvlZWvWHR6pwUiKQpSWX9xDAvTFP02ug6klAzzpRFww+bZTRTfnCdO7Wfnzfabu9zYmhQOrX82FgTG5ufitLrdTXGIujmwrCGUkJr7uD1FZLeaFxLkZOojeuUz0qwDGT0Os4ZJffIt7Q7WCz2WEMx66p7utmneSp3NWnE4Z24mbd44HfqRtFZtwlQOAoHZFjADrL7NlKId3pK8NTrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iblCv9MzUfitWDaZ0dHUpp9hmowRAJs9+F6L7u5Jic=;
 b=GBENHy+9qEZM8Hd2I6RmPmLyAR3uPSA2hMwatD23hKTNE+asaq8XMvZYp5VUFG0FW871G9Y8+M9g6DcpThUqcbsO1ZcUf9BBFLgcWfOP0ItV+uMIT1IQrfvIht4PL6qRkud+3I5HT1ZcYTnRu5jIVZch6KVHwDMGZ7Tk8b76Alk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AM9PR04MB8082.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 13:51:52 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::901f:7d8d:f07c:e976%3]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 13:51:52 +0000
Date: Tue, 16 Jan 2024 15:51:48 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [RFC net-next v3 3/3] net: dsa: microchip: implement PHY
 loopback configuration for KSZ8794 and KSZ8873
Message-ID: <20240116135148.hleo3v5lztg4k6nd@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112140716.2715664-4-o.rempel@pengutronix.de>
 <20240112140716.2715664-4-o.rempel@pengutronix.de>
X-ClientProxiedBy: VI1PR07CA0146.eurprd07.prod.outlook.com
 (2603:10a6:802:16::33) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AM9PR04MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 87053bc1-f04b-49b5-e2ce-08dc169a4b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uesyfGBPeHFyiWbqBkqbBg2EqSL+z7e+0eFSPI8RRrHA2Ck65T5RTerRfbeet9P77MmMBX2g1cyNavAD/WHmbAPVLreqOpsNVAtakcL7mz/ObyA2+dm1wrts21X3M66xNbb9nmSVi8ZsW0sjN/GTDH6jQxDMNuHoGUEYSqJvGDc0VKfAqF6/YEnSvMmBstAfFNnaod9qdDnGZLxcukPY1V3pfBVn27UaeIwwGU13Qd8HK1Lq2H/msPHUGVtYWsahBnPawhQaYJmmkjA5AjtGZvZ34sdrZ0f+Ir7qe93ouko8jL3YbewozPiHkTMruI0B9R8LRt3t55OqVPwsH6wtDFLWf+EUoHg5JnKfigsBCivDwablFGSI6+yRutdT9gqz4LNCi5bJjGVz1J40SvictDzX4ote3/l/Bhijaz7FYJVo0w4vIHUssNkUG9t6wgHuFHpWs5XB5WaXR3eLM8H1eGPTCgtfAmsmAtCV+6X06dyGbhaIvZ0A2XkhT6CcQxaCqVfWfL9XxcsNQFzUlJ+IWB2dQPdydfedfhOpvki0TP70OEgXGOR6jGlCJvuJxmR2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(33716001)(86362001)(6486002)(316002)(66946007)(66556008)(66476007)(54906003)(6916009)(478600001)(6512007)(9686003)(44832011)(6666004)(6506007)(2906002)(5660300002)(7416002)(4744005)(8936002)(8676002)(4326008)(41300700001)(1076003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JMEB8tsrivXJseuqbzpgKI6xOoK9QUBSK6qQ/Gsp23Gr6S7m7PGeYBHcc5Qp?=
 =?us-ascii?Q?5n3HNeO/E2GE5gJnvdLQRNhSt70XZKgUVevc41LraNG/9qnDb8uiwsTnNUad?=
 =?us-ascii?Q?bGzUCOKVSLcae9CHI8+Cy4Al/1yUdlwBD1jTs2JUu6AbDQ6UU+68vWGwqb8C?=
 =?us-ascii?Q?giRJhk0ieDPRuQ5+bqwmjkY6eAhGJxtANhxdY3ZYsTExYrz4p2gw4aRclIF5?=
 =?us-ascii?Q?XVTLDnftTDGQ+3wzTDm3SxBE+Xzf7yFfApDnfJUlbBhZOi9/bEnEXFIFzWYs?=
 =?us-ascii?Q?fKEZXBeHdJWbZiynOqLL2N9ZbcW80wc4thFL7BhiiY/IZLVDnlJTxRC4GpYK?=
 =?us-ascii?Q?vLmVPSyG9ZaC1usvAzR9YyVhkAY9nOslOEdDgq1rAQWJPSElSSPXpgVsYg8/?=
 =?us-ascii?Q?Bqm+Rx4e8EOGcoFlJVcROsu2AV11E9ydoDH4ztWNuEq+nNp5O49dmUUqiYJw?=
 =?us-ascii?Q?NhZQZuYBzZ0cKoxVt3BOHrAEtnMU89pcFCthu4/YAV3rhX4wOFy0kXEgMUvT?=
 =?us-ascii?Q?/PBVyFvMZyHahV1xVe0NfQIZz4Jus1hwoAjo1oe5O6Rf628GscAt/ANwKR8r?=
 =?us-ascii?Q?Fc6UDbTi0Vz2p+AWVRTtY6biaaMelxPvA/sPX56N5w/7eYZhlDpnI7aV+M0J?=
 =?us-ascii?Q?HYXD+t+ZxUKAGhvEGqvU+A0lrkK2+bwIPIFpkSzfSdLDFEiYwHlvWkjtFM7N?=
 =?us-ascii?Q?rgkRnB1lxTIfrbYvpt0YQ0PJYu5DqI/VXPScHRcWEq5ufVcruxOOZYtRBbcH?=
 =?us-ascii?Q?ZCnWwofsgxd7Nv3NwHfehEV3lQOoVsWbT+c1SkY76UmfH2Ty4ViD+OvqgIJG?=
 =?us-ascii?Q?hM35UCDXNvlvYdO/Q7HqUnFnXLwniDHfkGPog8f4zvlFuV9afPdaH4ciSeOa?=
 =?us-ascii?Q?VvxaDWrMa8Kah3x4qlDbytTyCBa0UtVijo+V6nJHKSUop9GcvlqzMI6Gnrfg?=
 =?us-ascii?Q?+ZLVMHdiWGpsOcp+8mJAFL/UHKdsqYAB2UOuCUdfcNNtmhZMTHjcu3820UbK?=
 =?us-ascii?Q?30UHlLmhGPDn79lSmV+6MgGBcjHtfq3rhhUU7NuZ6kz5xmpd1VYMbsMPGckh?=
 =?us-ascii?Q?JHfVnmH8c2w+Zv/yfk+AHB69JjGkb+bcmWgEYUCXAGcOptI2yvCrNPpTrghc?=
 =?us-ascii?Q?7h1vmR4eCG7EkdsKn1vUcMcLpkeyey4ebDTiAe60KFxYSHyFAnrH2F25Lpnn?=
 =?us-ascii?Q?K0ySpCj6xHXXTkMTGsJqj7QRi580sRKShRqzsmAeYLySrEOLgMBYn/N51N6w?=
 =?us-ascii?Q?82KT0PDTT7jwwrySyCclqjfuIyEhO9pLi8h5BaB3za7maQLfSBgRXDkBpQjg?=
 =?us-ascii?Q?jUphH8gDMjiKJuMRZU+UGUCgCIk4sMEE01Km8dw7VfQoCjD3PoeGvoHzlRov?=
 =?us-ascii?Q?YKbUMwlcGGbF4LD1gKRTwRCJNKBPN0zBK14mTX0VCJOISTptQ32iH+OUwd+4?=
 =?us-ascii?Q?NQOI3gUY/sA0FNuZPzReUMQw3uO/FIqekm9uGqlt6ZoROx9v3g1Ar6zKzg0E?=
 =?us-ascii?Q?a7kovv6uqonL4gRNNGannhooIkPoTFDoNI4A8RKCZt5pC8WS+kYKsmLPKj4B?=
 =?us-ascii?Q?vZ4HarWlEZfbaJxIGtAOvx0bmxZ3Jas+NvDk/afwpPvt1XqSUR9Cgu8+BQ2D?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87053bc1-f04b-49b5-e2ce-08dc169a4b00
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:51:52.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uapgrm9Pd7Pof3bw24CgxsrC9IFPaF66W0FjX57sonm5VAkDBIm0ZLWzFUKV850/kCxF251Ft+wrtgF1aHpo3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8082

On Fri, Jan 12, 2024 at 03:07:16PM +0100, Oleksij Rempel wrote:
> Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> driver. Previously, the code erroneously used Bit 7 of port register 0xD
> for both chip variants, which is actually for LED configuration. This
> update ensures the correct registers and bits are used for the PHY
> loopback feature:
> 
> - For KSZ8794: Use 0xF / Bit 7.
> - For KSZ8873: Use 0xD / Bit 0.
> 
> The lack of loopback support was seen on KSZ8873 system by using
> "ethtool -t lanX". After this patch, the ethtool selftest will work,
> but only if port is not part of a bridge.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

