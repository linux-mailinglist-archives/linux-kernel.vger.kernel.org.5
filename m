Return-Path: <linux-kernel+bounces-142899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586418A31D4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952C11F2141D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE168147C99;
	Fri, 12 Apr 2024 15:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qWR//S1x"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2731474A0;
	Fri, 12 Apr 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934668; cv=fail; b=cV1GQXB8nycPAPWJotCpgflsSBhx/F808/hYF2DeGNAin7L7/Xmtorc5/32LVKUmxHrIfFA4P9t8eYZ+D8H5WJ34SeCZCywe/NlZH0INcXAvIw1Vg8z/6UYQ0smn5rlShvCKJcjWkTBI54fxqcySopn1CVTHMMD9e2PXZL/jeMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934668; c=relaxed/simple;
	bh=Q+jvNGfXsVQNNXF6N2ozM4dIxM+jYQa4DPgxK74tJuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMtYkjwzyYshK02nd/L5zpollgGlr8wLKRi5afRACZ0Ktr4f4T9cLcPIJAC5cJ/hKie/WDi60JkkqxIQRfQsKIqiHbcOEVhCQ80bxLIJHg7iULoeb8X1tPsciftQSiVTYyoyzwhqvtiTuZZNIIGcwCyB+afd9dsARmHFeu4I6xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qWR//S1x; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3LSScExq7MysPW3Ge+jjQUzDVAyZIUN+BF4tRWGO2YAH6A5DlJUMkPDatQkMOub6/HmEwDzlbMz6rgr5F6nhscxGNGp25RsApBIufrubiUWpwxYOL5h/Bb/pP4pDu8PqVznh1JRWUamDwn4T8V1nnbQnkF/rsYn2UPBDvoovsY5wexepdT71CJtNfeLUyVl/bzIdC8naWpm3eX+4GiwNvz3jyc08wlnFmacjbW1dRRq/4qZ5IksY1drHt7LGl8p3MCWJY38DiPjNeCWP7S1U9VWYyKWe7rUozdkbiw6AgzN1CMJ7Bm3b5f1eOWvnM5ZUk5U2Ukq2XZcNnYcNtY2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qi8Md66pLQGbg3L6yLdTIzEUNV5NLSUYjDGuaK9M/D0=;
 b=WvtwKki6rGgXy56EFesK/bUx5zPuW4jGQVY2jKQHXhgmAGCbfJ/kIN5XIHasaEWbPzoNmkbWZcCEdNZDQW0LsWE6mfPBQKY4YY8dThBq8qRLHFM6YJnExE/r715s/SkVJnDI2eFWmC2lCLfMMj+mgJUsgtQ3E7IRRIO8I9OlSVFh9e55kfJdPXY/HwZI3clxF8l8eFx0eWXFmrxHRE1KKEsBvzetdC321mtk2f7vPuA3iq6/KXso0dt9uhNVF4JWHuEEmIBu5584haTKnsJFVtNKEVU3WGB4UTmShdGO2Hc934YernbwK4oqfvb/W91Ws5G3rT8OiJ2cLD/3h7HVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi8Md66pLQGbg3L6yLdTIzEUNV5NLSUYjDGuaK9M/D0=;
 b=qWR//S1xYr3mxsv4Nib9tMU+2X7SAXw1Tv9rQu7nrqGmeoWKMae6sh3WoF/UT8VthTsPhXxTTDnWVvjtnUMN3JYIMRPt5L50rjXiDrMO6q6LG0jSRtpYJtJzeVQogvFl40fvcyFi9h9hzAJW2PiR8gwZl7srTaQnQN4MoVGe6tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7282.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 15:11:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 15:11:04 +0000
Date: Fri, 12 Apr 2024 11:10:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: support i.MX95 SCMI pinctrl
Message-ID: <ZhlO/oT8BXupXyKP@lizhi-Precision-Tower-5810>
References: <20240412-pinctrl-scmi-oem-v1-v1-0-704f242544c1@nxp.com>
 <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412-pinctrl-scmi-oem-v1-v1-1-704f242544c1@nxp.com>
X-ClientProxiedBy: BYAPR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e2cd68-2f73-4dd2-f67b-08dc5b02c570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IuCr/k13OEqH+Dj3wHnbu4sALdWU9oU10j5JdtQwuFr6RdGO74IRkvUfw+R+IwyghbHNlB26ns4gUhiMGnhuLRn7M7wCMaMOYHG+isE5eSxBsw1NdiduEkqXe5OW9Br1CKesvkcKcd4KmWgAeJJnol+hiVAQnoldhLsUCoSHuNBbBh9DAF33RcZuPyDAOTdNmyU4+semoLwIxtvzm1BhIX3jP/EcdsS5qzKEzbjVk8MJaJ2iePUX1F5j0cBEga6MaXVWmhgIKlTwJHJ4hhtUX/h7sNgsLzmGs99ZZTiXBhP8v6YTaJK9bVVZ7W9W5/VMr9JranOlQlf6H1LEDxdGjnG7pP4rkaOTqFCBfLyXMWmZ0ltnGC5U7j1t+/L0jM0vYnSSk5UYqC5o8RZ/+TnGfgJmLzb/QdhOic4nbhL2roU6g157QK3wjCAZLQXhGTf/9COEx1SAJ2phPrtTW2U1Oj4nXzuGcQ9YxIdFa3KkBr7PKQonjP/PNwoIG8igD2OrTf8eXvzuG5tzQRLqN8pwQfF6efiNCgI4coYpx9MIL7TopfGnivZqgA5ALqxN5JKIX2C7hnm07JaC+Uhxr7XkFj+aR0s8HXM/CgD1nqzG89xQzeO77W9BWFlpCJh3bDwbq2Dn67CNnQQOATLGv6O7wMtAiNbvUVx77OO/PpRXQrESnsOZWC87xNBFfUC4s9Vo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBqRWdiOWRzZENvcGhWQ0VJUnQ4cm1lZ0lnRmlBZXU2MlIvMkFYNXBQUFRJ?=
 =?utf-8?B?cmJSRWVFWmtXc3ZXVThkUXg4OS9IY0xyQ2VCOEZ0dXZtS1FYUGE2YXdXSE5C?=
 =?utf-8?B?SDhUeTB2QzJhUFE0MTFxSCtMMVk4QngzRUZwUGZNc2ZkNmFYdnVqQVNHRWVk?=
 =?utf-8?B?WXBZYkxGdXl5YkkrYUZmMEViU0U1NUhSM0oxcCtHcy9lTFVOMnVCaFBjT2dB?=
 =?utf-8?B?ZC9PVkxHbWRKZzNZdHMrYitiUWZHcE1FTkJZOE12TEJoZ2pxT1BIMWdpSWRO?=
 =?utf-8?B?WG44ZCtsMzFUY1J2bWFabE1BRW82SmZVSE1rTkQ5aUg1TDNpbTBGRmpSTmho?=
 =?utf-8?B?KzlpYzIrVDkvai96b2ZXckFicUdFNVl0aElMWlB3M0NkQU0vOFd0TkNhRDRo?=
 =?utf-8?B?U0hKZmpadUVEMDRMREpZNC9aYVIza3dxb0lCOWk3S3BvUDNSemZvOGw2dkZx?=
 =?utf-8?B?ZHVMYm5zeS8rQXhxaVFXd1hlZHROWG11Sk0vMEh1ZlJkK0RKUHd1RDVjWk1H?=
 =?utf-8?B?SlVraFpsN0tpT0xaTVYvVFZ6UlpsdnJrYnF0VlpNZGNrUGhhZ0J1Uk52bDFE?=
 =?utf-8?B?MUNCV3AyZEF4aUNndEloalQrVmlKR2F4c1M1VVl4ZUtSSlMzOU5kZEc0V3lI?=
 =?utf-8?B?VkJKSmVzcENvazVpeWhOSDQ2Y1BicEI0Y2tJLzR0MHNUMldvRTVvaTZFYngw?=
 =?utf-8?B?VnY5UDY3NnNoSElUSS9PQWxmVWxySUdVOWFBRXpnaXZrKzdSbTJjYkFyT0M5?=
 =?utf-8?B?T3ZxeGF6MkNSODdqR0dQY1JrRmdSOG5FbzB5L3FNcEt2U05PZ1k5Ynh4T0lV?=
 =?utf-8?B?ZlcwanNCR3V5aDkwZm83U1loTkFSV1Y1Kzl3TXpvSTJ4L2sweERjY3JhcmVv?=
 =?utf-8?B?UmZoOXFSRzZNRFhHM1lvL3RxRlJ0SjRUaVUveXJxTmUxNm5CVlFNOUNFVEpP?=
 =?utf-8?B?TVFTSGNpdWVjdjA1TWR5alVhMS9Ya3dRUXJVMzZZZDNhZjV3a1d2d0JsS3lK?=
 =?utf-8?B?bXNNazhrSjNKRFBaVkFGWjVhbEVYd2N0SFg5blFqSFFWb0Z5L0Q4N25hMTUy?=
 =?utf-8?B?QjdOQlZFcTlLckIxRnVzQUFJaUs4OGdVMDVoZzdadWd3cXd1MU91b1ZvZVkz?=
 =?utf-8?B?QU9vRkRnUXZJNGxJdlFoemM3UDkxQzRDTURxMng0YjkrWkZYZWVrV29tbFNJ?=
 =?utf-8?B?VUZXdDFkaWVoVWVpS2QwRmY2R1drdGRNUlBwcjFZVDhRcXFLRTdXeUJiUXRp?=
 =?utf-8?B?ZVA0eUFTSlk4TkxKbDVMU3Z3ZHNTSVV1VjRDTVlNZEEwZDRLNUs2Sm4wUVc0?=
 =?utf-8?B?K2RnWHovbW1pMy81Zmh2Ly90aU9PZm16L3hXZlBqb2Jtd2UyUU8rcHFwejh3?=
 =?utf-8?B?OGJid3VkWnRBOW92L2taWlBSazB1UXlPbTJZMlNLQ0VqUFkzODJBSnRCenZt?=
 =?utf-8?B?cGJYYWhPTDZWY3cwK0k1aUVUc0U4NWM5em9VUmJjZWcyc2RBcTI5U0trTFUx?=
 =?utf-8?B?YVIvT0REVldFbDZkK0hSL1ZON1lWenk2b3lvUExGY2lrSHRaUlB6dTRVdlp1?=
 =?utf-8?B?aWFodHdTTTUrUkRaODNRbXlBeDFkVFQyaFFRQlNvVGpidXhETzBTbU1wbWF0?=
 =?utf-8?B?YmRXYzdQRGgrSWo4WUhzYlBGcDB5d1kzR3YzUVZUNzlNcGtYRlY3YTFDRlIy?=
 =?utf-8?B?eTlrN09yUnpjaDdpL0dzTDFqRnVtRHB2ait5NVJIVE1ROXExQjhUVERkS0sv?=
 =?utf-8?B?T29DOGd1dStjZ3lzaVg5dndmejBJbUp6WnpFSTBsbFdFUHQyNmNVbXpscEZE?=
 =?utf-8?B?LzNtYnFnRklTUzJHWW5iTlJ3T3dzdUVvQm1NazErUWlsakRSbGZHYTJuUGNM?=
 =?utf-8?B?dEJRYlE1QVJSaVcrQU9LUU1QS3JHTDE2dlZUclFrVjFlbUdhT2ZZdUYwVmRE?=
 =?utf-8?B?VHdXWjdRL1VsM0dRekdYcEpEdzFySVZaVHkxRkJqUWVGZ1hYTnRJUzNHWita?=
 =?utf-8?B?OGFqVk9IRXJ4eDBYWGl4VDkwcStLOU1kWnJxZ2dkM3VtbzRqUjQvWWgzbGVz?=
 =?utf-8?B?ZGdldlBnOEJRQzIyRTQ1UzBSajg4VEtsR1lnZ0laVjFYaXEwRWNCSnRabkk0?=
 =?utf-8?Q?d23g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e2cd68-2f73-4dd2-f67b-08dc5b02c570
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:11:04.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iNZgvMM8/Pgokeq8dafIpad5Lz8KTwjT0zFYrbGano/6WalonlNV45mOrVzJgXnMtr2l4TP18SOPk0IayLauw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7282

On Fri, Apr 12, 2024 at 08:29:25AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX95 Pinctrl is managed by SCMI firmware using OEM extensions. This
> patch is to add i.MX95 Pinctrl OEM extensions properties.


Describe your changes in imperative mood, e.g. “make xyzzy do frotz” ...

"Add properties for i.MX95 Pinctrl OEM extensions."

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/pinctrl/nxp,imx95-pinctrl.yaml        | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> new file mode 100644
> index 000000000000..4bf7a6192813
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nxp,imx95-pinctrl.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2024 NXP
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nxp,imx95-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: i.MX System Control and Management Interface (SCMI) Pinctrl Protocol
> +
> +maintainers:
> +  - Peng Fan <peng.fan@arm.com>
> +
> +patternProperties:
> +  '-pins$': false
> +  'grp$':
> +    type: object
> +
> +    properties:
> +      $nodename:
> +        pattern: "^[0-9a-f]+$"
> +
> +      pins:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description: name of the pin
> +
> +      nxp,func-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: high impedance mode ("third-state", "floating")
> +
> +      nxp,pin-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: latch weakly
> +
> +      nxp,daisy-id:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: pull up the pin. Takes as optional argument on hardware
> +          supporting it the pull strength in Ohm.
> +
> +      nxp,daisy-conf:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: pull down the pin. Takes as optional argument on hardware
> +          supporting it the pull strength in Ohm.
> +
> +additionalProperties: true
> 
> -- 
> 2.37.1
> 

