Return-Path: <linux-kernel+bounces-17060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552B8247BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E441C242E6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEC62C199;
	Thu,  4 Jan 2024 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CBP1u6JR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EEB288CF;
	Thu,  4 Jan 2024 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcoTyH+OJ5tpy6lI5n8A2vdF7xUoEZEiWAacW3xuDE0oOTeR8UQVB3S1RaKI8iwnGUVdeD1TCsSWexYbLIA5Vz1nUrxwypm5fCNEpR1S2LU1PPuBbK55CUBgkf1n3YarHYMx2LZgmfxs3VccbkRBQlVcTE8U1vH56u0DyNNjUnJIQ7ySxokqkulqBgKtlE0cTnqbdG6gGpb3nWeJD5CqKqtvQxzFLcrsDvvtnlvZM0UukKnztOin/z3p88+FkqZakcxPuuYeMWUpmLNWJzzy8hPDFePH0jNa7ci7/oiQkyDLwUxdwvW+6eYuBiE3A1D8zcMyTKkCLfNZp4Ae2ZemlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCBdrFu6wi/4xCggEEL2XHfnXLqWqq1GEdFnn4dbi6g=;
 b=FnBkJ5ZGtVRkiQahxDK0j+fe1qcloGiJhY6rA4i8pBzjjc2V7fHYSiC0HUNMyDJzcculHmWJBYZ9iFb94reUPucpENo9AA8pcWjE2VxNn8dQpqMA9UIETShzFl34FhZwbbCRFEDsEjKoQt4gZCh4f9bhoryv886A+CXYeHxeY06LH7vonru6jtOnNDbDgx48Kg+lCgfsBG5gYBXEFGOy0vZFUJ2LZhiaQs9cSfACf5w3Bq/7LzPm5bGnG/WEf1lvSU16Ka8rGcrYqY7D8NWqC9C+BTCSV0MY4GzYwepsegLsYrpXhth8Fp9J7RwQcEmPMRtn/OCop1EoYLA/JPo4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCBdrFu6wi/4xCggEEL2XHfnXLqWqq1GEdFnn4dbi6g=;
 b=CBP1u6JRu2lCiBDWT2NXqSc89qjUcCygg3cFHE7bUpmgJ7FI7ThmNgLfcbzHTrMNfK7KIBTu3jhGo4M+Zy9mj4dAwvCzW0G/mmIvMZgh4mKzgo8tvNnIqdafKkfuge+IaPBZPwlUoijeZ4vTku2t8nTV7T6h26e3aDa0XMLHJ/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:48:10 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:10 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:06 +0100
Subject: [PATCH v5 05/10] arm: dts: marvell: clearfog: add pro variant
 compatible in legacy dts
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-5-52be60fc54e3@solid-run.com>
References: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
In-Reply-To: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: fddfe264-7ae4-4752-7a04-08dc0d4d4ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fjIT8khVkbWt6lWVjkl9DrcYqxOtHcT/DKNH9juuHxWmhzp+lfQVIesq9vXar/cLGiTxN0AifTqTQp+lKHajo4ywsSgMOaPtg4hz10UJckXFGOOTJJURN44B70NyLGS8eW45DWUjZWn7yiUq2Sk9un3DVfY3GdS6CddnYIKOyXqDc2p+orqwIpjIT5JilPXaTBj+xDvqHZk2knSZw53eCjxQoc5tB6e35IMquTg+ZlStkD1oFSvyuV3ohwdOmRRJsgQnVIj/ibeqfbVtoOAkpow+GGvFoXwxZ2NHzlkm8RmJVP/MmgZ+z2MdikWeetvwGk9G8qNYVX1v/zPKjyAa9BlcVLpTPZmAeXq395TNIADgCSq8+SE/1WxOhbHKiYNi5bxq4FMJE3qeOVrVS9Y+7iF1tmzRFPgX4YTrDp2cZdgwksmBh+T2uReavv0H3l9W9zf747/ggacWCsspA1busXwhVVDLOrUvZ8E2RREAwpKOhye9WzPBpwTx88VVHcGY60uV6WAD9vTLeEBNp1csDhWPnyiVRgGr5QgrJXLAelbJTHKzu7d6DyBp+wTxlEJUTFHmVtnjR8ihTW7NqBxBnotompVaAgt8iPHHDesD3mg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(6666004)(316002)(110136005)(2616005)(83380400001)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?allIT2g3YVZYMUhnY1J5cEEvUmdJdy8za253OHdXdnNMamJEUXV1ZFJVQXd5?=
 =?utf-8?B?d0FKSzBQWWZFZDFDaktyVmlFN3lRcUh1M0lzNnMxREZqbGtpVVArY05PRUd6?=
 =?utf-8?B?SGttZThWWjN0cUszOFp6K25VUUpJUHRKK1ZGaWU0d2ltNVRic0x2WnRsL0I1?=
 =?utf-8?B?WXlnRDVLSXBBUHZtQ3hhcjhuVWNFdWV0SWZWMFU2UEljM3RUK0RnVWM3UEFq?=
 =?utf-8?B?K0VlNWdRY3ZEWTBvNlVsVW16WjNEZWRTK0drNVJQN1BpdTNjSDR1TVRuWVRI?=
 =?utf-8?B?UHZMbExoSW5kcmVSV3dJd2ZKOFhWSW55Ujd2YXpMK3hPaGRWK3g1S1FiSjlX?=
 =?utf-8?B?RzVpendnVVdHeTJZVVZNZnVCUUJQY3VRNkphbGYrNjlvc2NzWXE0Qm1hZFFK?=
 =?utf-8?B?d3ZxaTFPTXJUQjB6ZnlLV0YwYmVZUW9meDFWKzNCRERTbGhXQ1dDTFV2RE1w?=
 =?utf-8?B?R0dCRjAvNGQrTlJCMVRxeTBERHR6MDNpTTlCaEk5UmNIVXNRSzg1Vys4TmlY?=
 =?utf-8?B?Rmpza3dlWDFYa3IvUlU1RzJFbE9MNW9iV2pQN2tWeGxkNEFqY0h2UVJaUmZZ?=
 =?utf-8?B?S1pHOE03YjY4YVV0ZUNvNlU2MnFmMGFMVzQrWkg3N3d5WnRyc2ZCLzBZejFh?=
 =?utf-8?B?b2dCYzJvL3dtWkplL3Y4bmxHVG9xNFQzWVA4VHY1WWNXeVZnbnRSTkg4MTFX?=
 =?utf-8?B?U1VxMWcxMG1zV1VkMWZyV29tYm5taVZxUkZJcjRkT1E3ZmQ5UVNXbk90R2hT?=
 =?utf-8?B?YkhpUUV2amx6cWczeVphS0xxTG9KSWVXUEhkK2dnQkhEL0F5U2dUREN5S1hq?=
 =?utf-8?B?cEpoWjg4b2Z3NFZiajZ1YnRZZS9XQ1BaOTRrNGV5aGtENVE0bm8vY0QzZGs2?=
 =?utf-8?B?Qi9zbUJ4OG9wSjlqaDJqM1RsTWtaZm5aOEtyYVBsUW9keWNjSGFIMjQ0Y3pn?=
 =?utf-8?B?Mi9qWG9Sa2ppYWFpanA1L1U3bWpPVVI3WkMvZ1VPb3I1VW5sR09UeGllZGVn?=
 =?utf-8?B?eVNwS2E0bjczR1lKZncxUEs1Nm9jSTZNOFpFTXhLZ1FyOTJMK0FOUkticUY5?=
 =?utf-8?B?VDdlbmxmV3ltM1dHeWQ0cmUvNUthUFFLU2MxOXFiZjc4akxxUTNxNWo3Kzdp?=
 =?utf-8?B?SzBOMnBGOUtDSFk4VElRaUgzOFlPcVdTc1FlMkRTSEZvVjZ5emFSZGdRdHB0?=
 =?utf-8?B?R3VpL0JrMnkvZkpUWEEyaWx1TmVXNW4xd0k0RDR4d05pMjdvTXFKYmQxb3gr?=
 =?utf-8?B?UG50dWlnQ0VtWndqbUR1Ri9EMzlJN1VBejRycFVEWmtDZ3g3ZGpPNk84SFNw?=
 =?utf-8?B?OGc0NmUwYkJjczROK0hyTG50NGNyclB3VERCK0hoMFMyQVQ3aU91bkFKbzVO?=
 =?utf-8?B?TC9XOVlFQUI2Y1A5R1lkZHFUdG1DUVdHZlRBMS93ZkhOSVJQRW90WkV6eE9I?=
 =?utf-8?B?a0M4cFkyUG9YT1Uzc0tQSVpueFJIUWtMN29IenQrcFJ3anVHdDhLaUlueUNt?=
 =?utf-8?B?dk1nRmxZRTZyUDFQUko5b0FVRHlmbDZQUG1DR25KaElsbGRUdks1M2xLOG9W?=
 =?utf-8?B?YktyYldkUktiYzVlMzV2SGRiSmFQVnNRbnRkclNUaVhZOStsYXlnQ1ZVelZv?=
 =?utf-8?B?MGhFMTA0T1ZJYmc2UXRka29RSDFZLzJqczRLN3VaUmEwWEFCRTdDUFVEVEhm?=
 =?utf-8?B?VnFSRTg3NnhvVW05Y2dkaHpHY2k5RVpXa2RMT3F3RlM5R29DaGRzaUZZYlc1?=
 =?utf-8?B?b21TbWtnc294STFxYlRmc3drVGZLSEJ1MDJmWk4xRUg1ZUgzb3BTMDlOSjVi?=
 =?utf-8?B?NFhuMVBRNGRFR0d0Ulk5clR2WG1OdlhacmhrZzR5UTFFZWlrUVBxYkVqQnZL?=
 =?utf-8?B?ZXl0K1NMYjQvTGhOVFlTYm1XQUtlemRLZmhPM0RWdkFwbzVDZGUzZm1xKzFJ?=
 =?utf-8?B?ODl0SmlDUE0yRW9yNkdlYWo3amRFUDViWlFaZzVVUkhSbFVzQVZMczNmeWtR?=
 =?utf-8?B?cUd1S05rSjdvTFgzSEVwRTI3VE8raFZnUUZ4SkhCNDR6NUdkN1VBV09DZkdv?=
 =?utf-8?B?SXBNd0NyYkJHeXlCS3JIclFiN2hjcitRQXowMGJZWVJBdlFNdGlDUVpxeU5W?=
 =?utf-8?Q?5qQOubacIPK5saY7BKZc4Z+d2?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fddfe264-7ae4-4752-7a04-08dc0d4d4ff4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:08.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5hMI+5d+oTfh3QjeY7CG99wZRLVIDm6AHv8LT16PaC2oa+f5oSy93nndnNgnlNsb3yy/8PLCZIFmqnEPBrbkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Armada 388 Clearfog ("armada-388-clearfog.dts)" is a legacy filename for
the Armada 388 Clearfog Pro ("armada-388-clearfog-pro.dts").
The "Pro" suffix was only used when the smaller version, the "Base" got
released.

The two names refer to exactly the same hardware, therefore they should
share the same compatible strings.

Copy "solidrun,clearfog-pro-a1" compatible from the -pro dts and add it
to this legacy file.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
index 32c569df142f..24e478a3cc99 100644
--- a/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/marvell/armada-388-clearfog.dts
@@ -10,8 +10,9 @@
 
 / {
 	model = "SolidRun Clearfog A1";
-	compatible = "solidrun,clearfog-a1", "marvell,armada388",
-		"marvell,armada385", "marvell,armada380";
+	compatible = "solidrun,clearfog-pro-a1", "solidrun,clearfog-a1",
+		     "marvell,armada388", "marvell,armada385",
+		     "marvell,armada380";
 
 	soc {
 		internal-regs {

-- 
2.35.3


