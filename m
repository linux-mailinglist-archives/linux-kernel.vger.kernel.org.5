Return-Path: <linux-kernel+bounces-19217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866F8269E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED45283932
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF9CC2FE;
	Mon,  8 Jan 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="oRikFiFQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2104.outbound.protection.outlook.com [40.107.8.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97972EAD8;
	Mon,  8 Jan 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiNyCWbS54Kxc7UXsumxy6z0ypBvl5cnlyvwQXS/yGAd2eNPf+Dy9TN47Q9BHfcQu6aofC8WtqLOBsJioD22Eg4eEMkETXXAutY4qwGiWOcMK5VTbGiLgXlhHkwqsxujhz4oiiLhMD/GFCkaVW12JTCQa0ea3XU/4zpTDhUhGyKWpksTRstPK0XYqRIz++h86TSE5gB4udDr8NQ3Hc2LLSTMu88chNgql9cF0eneyh/qjAsBHs7Uz2wVjrTzVSwTNKLExHtq6GPiGTJtd7irwbOXzE4Pb0LC99JvQCBy0uiDwDmXuTNvwTtbwUXRFmjdvi+1WRyZUwQve1OKDB5T0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL0hpZUMe6FQBAuxx0d2zUdMcFgo7fH70R7SWy2Y+yQ=;
 b=U3XCO1D16GZWOlNxEoBoDlZBD81WKk3rbQreI429enQevZbTTibH2Z7rJHVyzDGxlGyOMV2BdC+YFMaifKLfbUe68jD0C6KOaY3gTxPLNK9aVli4I3vFO+6IFgOqkRpkYpkUezDSL3pQVPsCbEGWhsMInpKnK2cQjxF6Ahon4J2Drv1Tr+6q5f1kiNFlskIALo8617PPXHxFg7q5AzVTeEj/OzN6Hw4+6B/G1u0SBnF/Hg/DPdTBgMgeSLZHV9ECh21LEjIx6LBoyijUZ9fK77K/AfvqnwNAIyzrZ0ORgXSMJSOrMlnK86aVwtybH6nhCH15KLCdUD/WbLpLp4H0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YL0hpZUMe6FQBAuxx0d2zUdMcFgo7fH70R7SWy2Y+yQ=;
 b=oRikFiFQ1+QjYTyz+SPLqet17lo2e1hSfYbRM1lm75mrRliu6bpdEwZ23/UxFDhgb1iISTmJDgR0c4Wm8jHWeLDpLAN2tih5GKdo7MfA2KTmJmRmORaFi05rsjDG4lR0Fxp54chHWZiggX8WPvdMAQ4uh5/Q/VlWxWKd2uN+8vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 08:54:15 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9ecf:9946:bc16:21e6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9ecf:9946:bc16:21e6%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 08:54:15 +0000
Message-ID: <a618fb58-fdcc-41b3-a3fa-72025477a481@kontron.de>
Date: Mon, 8 Jan 2024 09:54:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] arm64: dts: imx8mm-kontron: DT updates
From: Frieder Schrempf <frieder.schrempf@kontron.de>
To: Shawn Guo <shawnguo@kernel.org>, Frieder Schrempf <frieder@fris.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Fabio Estevam <festevam@gmail.com>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Tim Harvey <tharvey@gateworks.com>
References: <20231206144201.46911-1-frieder@fris.de>
 <20231213093134.GN270430@dragon>
 <5bdfefe3-238a-48d3-b8a4-cee4fb6b0951@kontron.de>
Content-Language: en-US, de-DE
In-Reply-To: <5bdfefe3-238a-48d3-b8a4-cee4fb6b0951@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3498:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b02fb9-1fee-4fb4-0020-08dc10276472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9i9+vndphqrCwOQZDdiIkMEgRmclEQkqVb6yqeLiQfyoJVIHGU4YFHtKEZR08xsr7NHJqUF2FOUV5h2t708cMC5pqxtUvO6n+WLq9X2hkZ6US4f6YTZO5zbges34K4dJWAalK1yQp431g3TbIeUBKWTHZNsqv9cAWr7l/Fi3sNIlcOKJIi75896h2AtGLnuKATDvK+CzOfsBchcfMrmeCGWaTuiaVwcsdrdjMZ/UVGbgSXBh5TLSbEzlqkC7mKjxZ62y8eqhOcNT9f3Q1PYafDY+mT7yjcarr7ppnPXiGajAfBeMfIRoMshZ/xVbeP+G3rntaUErfGOWpU2jr5gIytIhmoe7itLaXCCTkvxPN3YkvDcSppMe5PizUiFGuishDrVsBKsydoZoLdIn/QUTYQJaUY/tqq8WP7n+3kuqU8KB5XJto4wn59aRfPybpRH5GqoJs/eLi2lg4jxo//YzHVfm4DO+HU8MV9DApfOsH28fpJz0zVtoEciHKhbFPzsmnKFcrS22M/pxRM7gCKSeTuXO+5JtjvOvpTnp0MKbxEJI2fnANKflx1U4Pq0lh1bur593GgJgcSZoxyWGIrBMRV0s/44vI2Su+Z1v6rhEY97Ypm9ZzCvJkgzb2rcs5ScOfm9wslVve6c5aZPpd/Z2nikprJ0IuggUUDg1gCFKtLqL5KzLL5ViligpRKFKBCDbC8PF45cs94MaP8ISca4huQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(7416002)(41300700001)(4326008)(31686004)(2906002)(5660300002)(54906003)(110136005)(6486002)(44832011)(53546011)(36756003)(86362001)(6512007)(6506007)(316002)(8676002)(8936002)(66946007)(66476007)(66556008)(31696002)(83380400001)(26005)(478600001)(2616005)(66899024)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkhlVXl1RS9pTmQvSysrRTBIaktmNmw0bUNML3lXYnZHeWQ0TGt0Tm5jeDE0?=
 =?utf-8?B?M1k5bDRzeHQ0Ym9aNTRGUU44OWxKeWxtQ1QxN1pvU2p1S2FvSVA2Zi9aVjBz?=
 =?utf-8?B?THovRWYzNE1VTk5Hb1RjclpHUGFlbGxURFA1b2FlUDh1ejJCQmNTSVlwWDZn?=
 =?utf-8?B?cVgzV0plVWpqZllxczhIYXI4TTNndmV3WlZJeFI2Sm1vVGpIcFVna1F0RVM5?=
 =?utf-8?B?UXRtRlhBSE5vNHZTRlFQbmJKYXl6Z3prZjMwV3hPa0IyNnVmZ1AwV0RkT0U3?=
 =?utf-8?B?d2M1MDgxQ2o0UzlYLzh6TXZvS0hqVWFmMGpPdDA0THBjV3NjTUlxbTVWaVZk?=
 =?utf-8?B?L25mZWVuZXVzUytGVG9FOUliRXZ1blVyMmN3Wkg2aUdSZUc3akppQnQwOGVV?=
 =?utf-8?B?YVJyeUJ5NmZISFR1SFdOdmxxSWRLOUhVYnNQckxOSXIxUmN6Zzd2RzMyVkg5?=
 =?utf-8?B?RWxMZzZUTzFLN2hJc0dJc0twWDFZNUpPNmkrcFIvNW4vZmFWZUxiQ2gwRGtM?=
 =?utf-8?B?VFpSSGR2LzNrR0U3RUFpejdYczk3eFlNLzdFdXJFaWpuVkVqelAyb1F6M0NH?=
 =?utf-8?B?R0IrWjNvUjlRQ2dqNXl3UUxCak1wRUdBV09qR3RKVzZNaGhlWXpJcVJIR3lE?=
 =?utf-8?B?cHZRRklraEY5NElBN3RCd05HNVZ2OXhxZ0x2K0RKNGNmVlpoNlkvQzJuREJr?=
 =?utf-8?B?amxvNis2TFVrV1k2em52SUFIMG5rMVhrSDM1cVdaMUs4Z0tYVUc4U2VLa1pI?=
 =?utf-8?B?UXdac0lDeXhIQmMwOGF3cU5uZWVjOGFjVE5pc2ltdStrZGdWUXhEZXF0bHQ4?=
 =?utf-8?B?alRWdWUzWXZlTC9lbHpsQktodjNkaDlrVHBrZTV5a3NMd0ZhS1FDTU4rcS93?=
 =?utf-8?B?ck1KT2IvUVozTWtFU2d1QU9sL0ZkdmdHTy9sVDlyTUtHc3p5c2w2T3VIQ0Y0?=
 =?utf-8?B?czdHb3Q1dDA0RTZEYy83WWtkZktaaDJQSmtzdFVnYUR3cldwR2lSZzdLWk4v?=
 =?utf-8?B?elRxV21IbURLS0dsNzNnL2N4QkJQbmtMRkZ0Tkoydk5UcjkvUmdvTDNJMTly?=
 =?utf-8?B?ZWpIUnc5VWFDVzlIVzJUZDFhZTBCUmJYUUNla3NuczUwZUY2UkxwTjhlbDBi?=
 =?utf-8?B?RXhlMG03Q2FXQUlvZ2VtKzQ4ZU9ReXVJSkx3U1pTOXBhNTQ4Ukl4anZ6RVpy?=
 =?utf-8?B?VEZCOGZYbUIxTHhEZkNTS0d4OEQrV2lFZ3lIaGF3NkFMekdPZDA4QXNFSHNB?=
 =?utf-8?B?eWwxbkhaUDBmWmdINks0dG1LZXg4SzhtTjlDTTNzTEZnZWRKUURVdTBYL1Qr?=
 =?utf-8?B?RElkWkszdWRBb21ubDd4di9xWG1KQ1VOVEhySmpGeVppMDZsaU8wV1VWVHEz?=
 =?utf-8?B?OFJJZXBTN3pNSmZuY2dXb1R1UjVESlVsWm9ZeHpQSmhFWEVZekZOTHk4YVpC?=
 =?utf-8?B?TTJrV1JmZG55cVdGdXluVUw2a0lnTFgwNGNjMjNUWHg5NlpoNW84bnJSUnVm?=
 =?utf-8?B?Z3ByU05sZWZZTW1VLzB1cmU2dE9SdUd2RGV4c1c4WERTcXFHdXgybjZFeFYr?=
 =?utf-8?B?SmtXbjNzR1g0K3pqMEQxc2s0TktQUUJDZy9ta2xUNFpsbFdFdU9uV1UvbDAz?=
 =?utf-8?B?LzE0YnFQak1FTll3VENURGZ1NklEYno4b1NlSXhkSnZwN1lQMWcvVURQeU1n?=
 =?utf-8?B?dHhHT0xkRTNacmk0QVJENURVRlpmTVN6Q2FwQUNNQWRCNGR3K25tUFVWeGo5?=
 =?utf-8?B?b251UHhLZEtzcWdKVndOQitLSU5mSmFNNXNqR2Zmc2s5bXdNdmlqUDlRQUJj?=
 =?utf-8?B?U0djKzRic1BrTUVhaUZDdndWd3l1bnBGOWNTQ3YvdG5DWkxiSnhDbHJkT2ov?=
 =?utf-8?B?ZWNOUVNIRENQVWM0Nno4emZZMUI2Y1FCUVp1OG1QRjA2RmdkdTNRL1V5QWtw?=
 =?utf-8?B?ZHRna0d6RnZJLzN2R3JxOVZsNVpEbGRXOU9VelJ1eE9aaDhtNEF4QnNjMGNw?=
 =?utf-8?B?WmRpd0tDZzdIaUR4dS9uRlRhYVhQOCtwT0RvTklMSTVSQXNhQnowWGpuMThP?=
 =?utf-8?B?WGRZM3F4V0FDUGpMSnBWdjZIQU9uS1VQVFFpd3JHRzNUZitHajZQWVF1OFJh?=
 =?utf-8?B?ZlZvRFNDMG1XMTliZSsvVnNtS1hVU2ZDWmZyYjYxN3FyY3c5K3lRM2RwQUM3?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b02fb9-1fee-4fb4-0020-08dc10276472
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 08:54:15.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7TH3nwTgedl9ZqXWl+FP23aYpVY87d+//NR6vfPK41snbF2ko0ODev9i8JUji7zq9Dq8XyCTn6+awAP6eIBwWioXC5nHUfsJD9X8aGDnBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3498

On 19.12.23 16:14, Frieder Schrempf wrote:
> On 13.12.23 10:31, Shawn Guo wrote:
>> On Wed, Dec 06, 2023 at 03:41:03PM +0100, Frieder Schrempf wrote:
>>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ...
>>>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>>>  .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 295 +++------
>>>  .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 198 +++++-
>>>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 201 +++++++
>>>  .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 567 +++++++++++++++++-
>>>  .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |   4 +-
>>>  6 files changed, 1035 insertions(+), 234 deletions(-)
>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
>>
>> A couple of things:
>>
>> - I have to use 'git am -3' apply some of the patches.  Could you rebase
>>   the series on imx/dt64 branch?
> 
> Ok, sure!
> 
>>
>> - There are a few DTC warnings that need to be addressed.
>>
>> ../arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts:235.34-238.7: Warning (graph_endpoint): /soc@0/bus@30800000/i2c@30a40000/bridge@2c/ports/port@0/endpoint: graph connection to node '/soc@0/bus@32c00000/dsi@32e10000/ports/port@1/endpoint' is not bidirectional
> 
> I'm not aware of a proper solution for this warning. The thing is that
> there is a DSI switch on the board that is able to route the DSI output
> of the SoC to one of two bridges (HDMI or LVDS).
> 
> On the driver side there is no representation of the switch. Therefore
> the result is a three-way connection for the graph ports which is
> reported by the binding check, but works fine as we only enable one of
> the target port nodes at a time and use GPIO hogs to select the switch path.
> 
> Rob, Krzystztof: Would it be acceptable to ignore this until there is a
> way to represent this in the DT? Are there alternative solutions? Is
> there anything to model a graph link switch?
> 
>> arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtbo: Warning (graph_port): /fragment@3: graph port node name should be 'port'
>> ../arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso:61.17-63.3: Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'
> 
> For these warnings it seems like I could work around them by creating
> two separate port nodes in the board DT and then only enable the proper
> one in the overlay.

Until I find out how to deal with the DTC warnings above, I sent a v4
without the display support patches to unblock the merging of the other
patches.

