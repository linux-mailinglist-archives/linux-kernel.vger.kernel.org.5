Return-Path: <linux-kernel+bounces-5467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AE818AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182541F2289B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240AA1C6AD;
	Tue, 19 Dec 2023 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="TKkcutKM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2137.outbound.protection.outlook.com [40.107.247.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927FC37D0C;
	Tue, 19 Dec 2023 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNcf9zZoLikaJHqZV6XUn8wy0yaNTRZ1q+RYUQ1bt+u7f75y1D/bTJwb0iOkUcqA2pDgYFpkijKSJWlK8dI3ilcNnad8EmByMf+Uv3GLNeAX92GgjS3zqzWxk8Z9a9poVt7b6+JBKUKVwCjb4aJzpU48GkwuB56UBjHBUBslLfmjRksgvLkfff0I+3rpRN74uSMBK//Ld2uYPZzlsXcr6/GUkTAbK1RoMrtY+Szery36mzvFbjuYo27TxoqSkltYgqcmOvLpHkFhUYvBzyi8DhvUJ7Pt+8yZ++utUdDe4dxTzrbY/8UZWeb8SmG+PbR8PbmFojqngqJhv3upzf7AdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jThFwrbIdbpaFkvkK1Q9m2PBNZRF3YXA5eYF1pYkymE=;
 b=CwNVSt1jnmb+tOl9Ix5HSk1yFTkMQnICZ+vknQDSZzYIYDSAt5yZxqLgcI4FkaNoeSUy1CdDW9MXUcnglu/SqqKdZgmRxhyDrcWNhcSs2CDdurGsQV6HybC704EB9+/wZPwhdO9Jz4ndxsluithpCzzGlFqYyCc5LWlYkOHjYzuerArCAU2faRwBQ5dT0DI2fF4H1e1w2/att67CNaxtULA9vW/6uhNz4So+3aISVQmo+mO5hXpVmNqE4gvZ29YiHX30u2Wjx7asTJDgP37hF7WeNTRrkVowUJokam92AE1rLpMpGRwaVrmfcHl7sMBbWTtFUSNxZKEycPjL1ewbKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jThFwrbIdbpaFkvkK1Q9m2PBNZRF3YXA5eYF1pYkymE=;
 b=TKkcutKMnmXNTeSnvayG58/vr1XRl8ShlnfXmxf1V4ho3tJRrZDkjZ/3i4cFFYcvImFNnoo2eUYWQaSFfXG2L8Gl8kHrIOrb5hMN58jTFZk5j7PX6lNMRSXd7T/cYrCFDXwoe9CL6QIes6ndcNTMIo7A1yDuBkLqzs3ImoT1oFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3643.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:139::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 15:14:18 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::27ba:9922:8d12:7b3d%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 15:14:18 +0000
Message-ID: <5bdfefe3-238a-48d3-b8a4-cee4fb6b0951@kontron.de>
Date: Tue, 19 Dec 2023 16:14:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] arm64: dts: imx8mm-kontron: DT updates
Content-Language: en-US, de-DE
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
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20231213093134.GN270430@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3643:EE_
X-MS-Office365-Filtering-Correlation-Id: 33072cd4-ecec-4007-f37f-08dc00a52b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I9i9affJMIzblF0hRUw9NNFISf/bHkoBp9hg5yoA2cRrwN+Jn+CSnqMeQHzpcRIE2e548XX7+y3IErQcNBVcAg53GU9HxSrB1vegdwpXatSSOeBIen9Irqis4FsUNGEYZ9c5HRlBTiu/jqtiJK/clFCC41YzzMYMUwnPEX6PSuwM/mWdqehSHS4gxczSVSp2KGI+A5FAv/YadLGQly2y4HwCBxAeVXqJpNqkvjv6VuGoWGQbICIdXKf9zhrCP0spHBJuNsMxD30dZ2giU+hZt7jodSOgo4qCpCCvaUI50ryWPAHtPxYo6RsnwBT4wiNLeno09oE9JhLtJi1gPK0JsmgkaHrcbzB93CqfQbv0IVGXy7HHgEs5z2fJXgsiYnQCoQLCpRDQfCq4CqkPxerWd3QxAX4wpex0Uu27S71I3IewdGGW+kG5xJ9ydknGkScUYWu3jT/+v9p3JkPUazAqyvEDfrYL8SCNxu6OAcQeqevB0Krc3MZTc87Mdwdvyf8fneoutJkKXdDpXIvQteVcbs1Bbl64NvJbFrkPSVk/qVtERDEcD5Wdf3HLXS9f5Bd1ODvccjpF8RSxVCprHgOx3Rk4fWhd56sYDKxn9DQgjeQsRIcTN7IocpYfRAp3ovkW729huDO1U22Y9TWJ//CuwEYdax96wVDkMR8/IkvjXgjRfXER72X+/GQrGK/bcbWaxZxkL+tt5dr7JtaxuyiTjw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(44832011)(2906002)(8936002)(8676002)(4326008)(6666004)(6512007)(6506007)(53546011)(83380400001)(316002)(5660300002)(110136005)(66556008)(54906003)(7416002)(66946007)(66476007)(38100700002)(478600001)(31686004)(2616005)(26005)(6486002)(41300700001)(36756003)(86362001)(31696002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVErQ3cwR2hjektiNmExSUk4MDVUWXFkN2FiYnpDZ1RCQTYrTVpNMTlPblc3?=
 =?utf-8?B?U3ptNGlPekx6M0RpZXd5T09XZmdGNHBEQ0puSEIraHB4NnRQUGxidzFUejM3?=
 =?utf-8?B?dmFZV3JyaFZVWlEwRW5QY1dpeDVScEZGMEt0L3NPTG93SnIvR2VBWFgzekNW?=
 =?utf-8?B?emJGakNXS3BKdytTM0hRaGlHa3V3SUtvK0Z4VmpzY3QrcVJFZ2xnTyt3L05J?=
 =?utf-8?B?TmowNGZSQmxvSlZvNEw1ZXg4UTVvQ1hXdkdIUGhIY1Z1bXNYQm5VcloyN3k2?=
 =?utf-8?B?NjgvZG8rUnU3eEFZOE9aSVRUckJaWnd6QXREcGNEaW1yaHo2N0REQVgrVVFv?=
 =?utf-8?B?VGJtcG1zN1BUQUFVZ2NHc3BOOGIyWDdOaWVJbmg0OXNaMVJiNkMxYnZHNFhF?=
 =?utf-8?B?ZU9kMHpFMDhnb1Y5MTNITzRjd2E1TVNoQVJUdjN3VDNVejdxMVNVRzJreGpK?=
 =?utf-8?B?WW1hdnF4ODhXM0VJblEwUEFSdHM0N1J5RXVON1BMZjBJVTIramJteGpHMG5s?=
 =?utf-8?B?bFd2VzZmVldTeVVhZncrV0pGUkhJT1k0YXFCRFA5bUtiei9BOWhhdEMxZGdD?=
 =?utf-8?B?S3VhWStKanc2WCt3TlVINEZoQkx0cldDNnFyZExjTUNvK2R2eDgxNU9KU0x6?=
 =?utf-8?B?T0E3Y2djQ01MTlBSZ0xxclppVk1sQUxraDU5dGVQRzUxR2FxT1dwdlFlbTJC?=
 =?utf-8?B?cTEvYXpDTHU3Qkd4WU5ZaCsvZEpwbGFRUzZ3ZytzZ2ZlMkc3RkY1UkUvZUgy?=
 =?utf-8?B?S0wwU0d0ZWIxMnJqNE5BSXFYaTByNjVhKy9pNzMvVWxXdlVvZkxobmVmcngw?=
 =?utf-8?B?cnhyTVRISlpWMWdmVXBXZDFyM2E1eUlxRXZxcXlLdVJNc1hhTDZaMXJObTVr?=
 =?utf-8?B?enU1eTNPcEJBQWhzYzlKanhvRUlMdFlIQXdJeUgrR1BjeFJjbms1M3kzTWVv?=
 =?utf-8?B?TTJ4R0t6OWsyTW1DNHpDTmdJaEpIM0tmUWJjeEV4bTBRQTlNNkw0NnMxM0NJ?=
 =?utf-8?B?bi9RSWZUbjFTMDNDbVRNdEJ6eWZia3RCTU9OMnlTVEZ6TFpNbDhpNDBBRHhI?=
 =?utf-8?B?OVBzZ1hlRHNXRThURU5QTXhiQjM0RjN3NGFGNzdkcFZUdWJDbGZ0UUxYU3NN?=
 =?utf-8?B?VHlabDA5UFU1SDRsajhCK3lGVS8rTjFiNGFBZVE5NlBZaWR3WXNPZDJnZ29R?=
 =?utf-8?B?YXp0MTFrYmZVVVFsUDU1NFJRQ2dxWjcyMHZ6UzZiVU02YnUxTm1QZnhieTlH?=
 =?utf-8?B?KzNaUGpybXZPbTNrMExUNGJOR3JPZE93b2V1a0xxZWtEMGVqNkFyMHhNUDla?=
 =?utf-8?B?TUt0UFBhL0R6WmJXR3BwbXhJZjExYUxiZ1VCZDROa3YwMDhNN1lDZ1dmM1c0?=
 =?utf-8?B?ZFlVTG5Zai80bWY1aXZPVVdZSjRzUll4bXZ5cURITnhUR3BaS0ZiMVROVGVH?=
 =?utf-8?B?c1E0NFREbDY3TFExcDh3ck1jN0RkUXNwM2ZHWGcwUndsUEI2MWlqRDlyKzBp?=
 =?utf-8?B?VTVkRCtoNzM2SFhNY0w4Y0VWV3J6WWNYQVBlWWlhajBEK1FjRjdpQ09QVnlC?=
 =?utf-8?B?bVc4R3hsc3daSnBlN1hIbFRwcFVrNm94WHlTYWd1SWpDVVk1d0VTaDRHR2c0?=
 =?utf-8?B?ZXhDeEtBM2lDc3Nodk10ZW5Rc0FXV04wMGVXMkdldzhhYnVzSmhnSWRnMndG?=
 =?utf-8?B?c04xVmc1ZlNNZ2JVWlhNNkhXeXNxd0Y1T0h2elE3MXgvU2xWWklpRGZkSDAy?=
 =?utf-8?B?Uk9QMUY5RldsTTVRMFZIcTUra2hFbGRYRmVyNGY4QlErSllaUWtDWXB6Mitv?=
 =?utf-8?B?STY1Z3lCeFVtSWFNcDF2WXJaUU10bWd2TEtKOVZkQXV4dWwxRzZVbzk0THIv?=
 =?utf-8?B?V3A5M1JJK0lZanlFcUF5RjFQREw0THZubldRMUdLV000KzFHYUJhczBhaVVl?=
 =?utf-8?B?SG9nMXBHQzVnb25CQlVwaWxNVkJRMEpDMDRyb2MvL0ZQc2ltSXRSbHdQaWpI?=
 =?utf-8?B?dmlpdnFESTJnd0EwQXpnU1lwMG1LN1YrZjNHU2RRck5PNDBsdnNseklMd3pa?=
 =?utf-8?B?dWQvOHBaa2JROTVycHRmVVY5RlhGWFIxM0w2Z1B5aWlNZkFVVVpBSDM5QXNw?=
 =?utf-8?B?N0NtbHUvWlFzY0NsUjRBdW9HUmgzNXA3N0pBbmZnUklZeFhNQysxaGdUVWwv?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 33072cd4-ecec-4007-f37f-08dc00a52b75
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:14:18.0003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUKQw1MxiVTQe0iKSEYTgE2s44+s2s9nlGHb4C3JQNEEQk9uJkj3zSKdp/wAQIMBwJTbWyhSAeorummJc6eWDXpiQyszbzMEYxdqRLL+Ndo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3643

On 13.12.23 10:31, Shawn Guo wrote:
> On Wed, Dec 06, 2023 at 03:41:03PM +0100, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> ...
>>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>>  .../dts/freescale/imx8mm-kontron-bl-osm-s.dts | 295 +++------
>>  .../boot/dts/freescale/imx8mm-kontron-bl.dts  | 198 +++++-
>>  .../boot/dts/freescale/imx8mm-kontron-dl.dtso | 201 +++++++
>>  .../dts/freescale/imx8mm-kontron-osm-s.dtsi   | 567 +++++++++++++++++-
>>  .../boot/dts/freescale/imx8mm-kontron-sl.dtsi |   4 +-
>>  6 files changed, 1035 insertions(+), 234 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso
> 
> A couple of things:
> 
> - I have to use 'git am -3' apply some of the patches.  Could you rebase
>   the series on imx/dt64 branch?

Ok, sure!

> 
> - There are a few DTC warnings that need to be addressed.
> 
> ../arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts:235.34-238.7: Warning (graph_endpoint): /soc@0/bus@30800000/i2c@30a40000/bridge@2c/ports/port@0/endpoint: graph connection to node '/soc@0/bus@32c00000/dsi@32e10000/ports/port@1/endpoint' is not bidirectional

I'm not aware of a proper solution for this warning. The thing is that
there is a DSI switch on the board that is able to route the DSI output
of the SoC to one of two bridges (HDMI or LVDS).

On the driver side there is no representation of the switch. Therefore
the result is a three-way connection for the graph ports which is
reported by the binding check, but works fine as we only enable one of
the target port nodes at a time and use GPIO hogs to select the switch path.

Rob, Krzystztof: Would it be acceptable to ignore this until there is a
way to represent this in the DT? Are there alternative solutions? Is
there anything to model a graph link switch?

> arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtbo: Warning (graph_port): /fragment@3: graph port node name should be 'port'
> ../arch/arm64/boot/dts/freescale/imx8mm-kontron-dl.dtso:61.17-63.3: Warning (graph_endpoint): /fragment@3/__overlay__: graph endpoint node name should be 'endpoint'

For these warnings it seems like I could work around them by creating
two separate port nodes in the board DT and then only enable the proper
one in the overlay.

