Return-Path: <linux-kernel+bounces-28751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB8683029A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048FD28626C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBF81426D;
	Wed, 17 Jan 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="NYSZmRqJ"
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586814003;
	Wed, 17 Jan 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484753; cv=fail; b=WY2RVhnelcETviQg91P/r0vvdyRE/NbD2jKaTWKCdfmHu5cduKMO0m1Swazd1r8+YZ1OeV2FgTIBa483npWSTDYiTS7OZ4wd8ujbvl8XIaEZ8bpo1YTWBeyKKRcabEvvup9eP/9jP9rf19yJkQvTRrVSfahu6iheFiwWRy6tdhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484753; c=relaxed/simple;
	bh=hO2LHTgY2p8XEL6vV+xIomvNTsijifW6spkcKwHq9JQ=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=Q2wPvbTzIcOCBozYR9NwdOHj2JP3+ZrRAtQ394ff8b9VJv92x1E6ZDcuOCUTnwOf3n0TiGOGK92GfXb/aeGfz7Q1oG3NVVsnOwCifqa3a62wVZRsvW1fA4gKlfRgO6rzm2Ar+tBM6naTJAiqjFnWmFzvzXjVmu/+URASAhlLS+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=NYSZmRqJ; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound14-151.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 09:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5zaZZsN8Nh9vZUIYgl3O/CI9dm9UNysnyHx04EHx0UPpEvBfkgeuKz8Sj96sPG8L0t4vcY1GCLiOlnEpvktnRjEYAIW1wlPIuCRPFUnmogFXVpqDGDKnvVVI87RzVNe7FL80H5qgV04MCwOwa5h4kc/1RiVAVAfrdor+ghHMU5yJqNdfYykOqoGkziHtxGrU4ZLZ1jUPEno9kUZlXe41eGfz9bHDQbvASjSPXKxeY8x3nbO9vS8rUWQ5D7VtXHjhTHLMajjtw2aS9Gt2SA7YGJjkcGk7zIliTkPP7HocPNWRLzSPz59aSg9I8tLmzfWyRSc8P7bEK4yJe2VvZ9wjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j8v+CjlRHipSAZsrRzltLyARAIOOD3JMQOwC8pVBCU=;
 b=XbZYNeavP1i9H8F+bxzorhQDC2eOw9DkftqgXieVnl9ShzTVJ7L20n6U/KuUVMbqHwCN7yEo5erU6fRxFnqlocAUBHC8oWzJgadeeQBcAMWDNNUrZzBI+CnZkE5lTH7drySId8nnzaqdkYiNhF5QjOG2EhTKBEAg1rC5SbGU2c3okQWjixiA/QqZk3DH8oiowbNlAiiDafzl9c6+LUl54bhTA2xgDVu2CpQGX3ockZeLg669zZHIGs0/H1J+dalZ2KKMYoGF8EKZAh3CrDTtyb19+ps/fE7E60v+fP8acH98rXPPAVKKq+NspzKPxZeUw22elD1xr+dhQ8m0Vgy0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j8v+CjlRHipSAZsrRzltLyARAIOOD3JMQOwC8pVBCU=;
 b=NYSZmRqJ5+xcuzHBHY2xlxrzQSB2C7wFX0FlPXkQixEqPWpJYqJ1dpPz+nFpl/3LFSIg3LOnq/lo7eccEUXl4GfHOPpl0PUp5MwMj0Ak98Xq73tLXhsSJAqjnYaC46ePRcA0S8/rGXiquVdzKOqT48WKCgLrFnHsR6aq0KNhToF4ORYwdDpZVvRZAD/0icqbuaga0VKPe67W2P6JpHGr/bG5wIlc+yEdi95c1fe3rqYMLQ1CtFF3BtyXoCh1pbVAeGaE2fd9D5T/zM3z4ySi+I0HgDqb41bo1R88UhHJWE+eM5rkg6eUjM/dek2jhMd58rYxApFujvLjqzOx6mQgIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 09:45:28 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 09:45:27 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Cc: andy@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	stefan@agner.ch,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hector.palacios@digi.com
Subject: [PATCH v4 0/3] gpio: support i.MX93 truly available GPIO pins
Date: Wed, 17 Jan 2024 10:44:50 +0100
Message-Id: <20240117094453.100518-1-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0108.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::37) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe4857b-6ff9-406d-0669-08dc17410904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wzK5vVtJKGNE8wyyE3gS78uzvHdv6SNd2kgXRwviTYI4PEAw05sdZX8Vn8EGd8xtKD7/IiDiZr6oZeOZ/o/jqbnWb4MY2TS22c1cR6T15bK7Ax7M2pj50SmbFLQDku1+ZulBC/vu3Kb/m5vWJrrSf7o8YlO/L8jOkooSv0Y3L3V8B7+7zhnSS6O5pr3DlCsMb8qjKnkj3GVuevX+8KUhpUs1jWlIa5LtQw/GS+y0cmUCSVufktPR9EnXA4ZYp8vZ77hojowMmC+THDuKEKb2zeNuWeZcgeo0otYkU6AIkAM/8wzhdkBtwSN+B3SC92M/ZvYESTPaRm5WtmgBKDJ2wBahiaYawtoiilH6UT4dPyoZcqqeciYlL5bWVgrbBpFuLDxJy6qj0pzd0izPkybqdWJ5Y4zJBBwjePvNxMeqWlpIZ9TI+o98U/cWZknFCOb7yNMJiif8LJeu8KCrXLD89ObqAf/ZN8l54GmSVr502C9cItr8np6b9yPm7E0MUILkZRFhiuas7nVNN+QHH8VDgG2nAI1RsFQ2csrgS5EZXrrjPoEj/+qZqQNdTyzSux+pFyU79CqMvoiemgVFgumOyoPne5F/U0M6Dbyb1CeC8wHKJ0tvd1yS1k9+cmiJPc+n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(478600001)(52116002)(6512007)(26005)(1076003)(107886003)(2616005)(38350700005)(38100700002)(36756003)(41300700001)(44832011)(2906002)(4326008)(83380400001)(4744005)(5660300002)(316002)(66556008)(8676002)(7416002)(86362001)(66476007)(66946007)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lVojRE9sf56io6H29Jf84tY/FpVuZd8hcN1VvH+Sty2+g3LeRIe6mpou8NQ?=
 =?us-ascii?Q?kTilIAXs6XXPXwZmGuZ5BuQvHsJg9dq3u8XeU34mvqcAAjeMJkhpmHTBVZrU?=
 =?us-ascii?Q?UHvx71pCpc+h0kao/4lWz0Hq8gWy9Zr7N0uT0+TUEIzDvWXyl6blXwNA8Pn/?=
 =?us-ascii?Q?L5ekG+wFN+3iV/gW5C0bN1U6rc0Z/olPZpZ5+bIgznJVuZRiwQzGC+Ie8N2X?=
 =?us-ascii?Q?9Y2kZF5jgQntx47Kc5JNRIwJUsLBLtMAr84v7i46MYAJSi0FCQm/arOXeG99?=
 =?us-ascii?Q?9opJRHoXsKu5OitgP7JTt5Ty1Ndsya6R1jt5w5kRiQYBKFPbSGEwuAEcrBnj?=
 =?us-ascii?Q?4DeQReD8M2g8j7XV3ObCboYG1Sxz2HHg/rceH6TtLzMUpFfBdhkTKVPxQ4ZF?=
 =?us-ascii?Q?WsMETOQzHjEMCt1gto3WLkhlja2qQfmoeiBBHoVqea+QqaVmcUWwBRN3OOXt?=
 =?us-ascii?Q?BvmHra1lw4iT2LoLkY5UUVNzn/AXcyHu3bN0xF4LGLwocUt3BM9Qvs0wUW3F?=
 =?us-ascii?Q?PdwJLG/JZtEaMUUu3EdAVbQjHtNNjRbbbJ6BYt5n5Bf6o9qdZ/0z7ABcrDSi?=
 =?us-ascii?Q?TrJn1AzAftJQ8fFpd2OX15gsBoNfIkfArqWwlmrUgIjeQh9btMIcqzbI1ZKM?=
 =?us-ascii?Q?Hd7zmrmwSr0zJBGii09KuXhIoOqsi+W3tJda1E4VdThMR+7BLfFzfgsPmDhs?=
 =?us-ascii?Q?ZXoSMJ6wVPPap0DfNOrQ4EFk6iAKNmHvLPQe68uCPP3mKZnLuHmdSH9Z40Eu?=
 =?us-ascii?Q?Q39E5bxxqzLkMQafx67sP8aBeqTFefkMIrttfdFd6C3KSG6z45/ueXyoVsha?=
 =?us-ascii?Q?MvdoUb+aOsmMqS+cZJ16ebvY8d34huAAtgQaTZUCmC3mA5NRiadeIs5OrZAz?=
 =?us-ascii?Q?NsTZKbKlwZ/LQbWkziPxcMfnqMist7GjlG2IX/bDrgXAjp4swPx4DAhzgdLk?=
 =?us-ascii?Q?9TFawTwzX1b/xRBe7MuBb4YrimNQujtK1PDsiefAGeO8y8a28e4xkKaLmIr7?=
 =?us-ascii?Q?LRjmHw+Dy1HdHwymhWY2UFQ9H5zYgx1p1KH0pzsVf5enneHjQOUu6BVvcJm3?=
 =?us-ascii?Q?memA2nbKteZJmSkAU1dtvY6fhVDQa5OiQb0nYB8yGDdL6L1/K45y+wJAE3b4?=
 =?us-ascii?Q?ynrOolLA6yr7zAt7O+rjbtwpjuA1xvcHwfhZkUTeNvohTELYe7kfh/FGeuHf?=
 =?us-ascii?Q?4PPuw9dEA3eSCHBbnLDIbgx66Sq29ZLvOoS/zPPegUCNaxryj1adArFDJEWw?=
 =?us-ascii?Q?8w49y8+lre8YRq4hfBm4dkBNdJ09cgxWmPEXpnMScK/CbWdM9BIagnvSFvwn?=
 =?us-ascii?Q?q0CBtLnwYQzK/inQM4ktC2unRGbvoxzU6CKQBVS+Z/NTXgVo0+u4IaVMPVfk?=
 =?us-ascii?Q?UaAhyuAFPBYMjoTSsSIonRP4cF02syPUBN9kPvBpp5Rhlb6FfPWBLfm29sUz?=
 =?us-ascii?Q?RtR9Fy/WOPMmJUZA5QKzc4TCCcWQnuVNr0ngXw1vlH2ClCGU9AV8zSwNVv5m?=
 =?us-ascii?Q?ATR5X3izrJyS+4xKtfPSha3uSN5EmBXbPHMdDjN5OeDLR2B9qjDg9HgJmesy?=
 =?us-ascii?Q?Nf3W3KqT2DAa3dS65DRCvdebly2qYPbZorEFLDNo?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe4857b-6ff9-406d-0669-08dc17410904
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:45:27.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KSma/+1fRHqG7Ol8hggMHdlKZQP4Fy9/I3FJDxgLmRW7lqlAluTkbEpkcX1cMNf4rs/29fWMvGsrEqPJQ+FWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-BESS-ID: 1705484730-103735-22813-55859-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaWhkBGBlAsydjAzMgkyTjRyM
	TAODnRIM0kxcLYzCTV1NgyLdXCOFmpNhYAoFTaAEAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253576 [from 
	cloudscan11-192.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

All four GPIO ports of i.MX93 SoC show 32 pins available, but
not every port has 32 pins.
Add support on the GPIO driver to 'ngpios' property and set
the truly available pins on the SoC device tree.

v4
* Remove 'description' from 'npgio' field in bindings as it 
  is a generic one.

v3
* Move DT bindings to a patch of its own
* Improve reasoning for adding support in driver

v2
* Add 'ngpios' property to DT binding for proper validation

Hector Palacios (3):
      gpio: vf610: add support to DT 'ngpios' property
      dt-bindings: gpio: vf610: add optional 'ngpios'
      arm64: dts: imx93: specify available 'ngpios' per GPIO port

 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 5 +++++
 arch/arm64/boot/dts/freescale/imx93.dtsi               | 4 ++++
 drivers/gpio/gpio-vf610.c                              | 7 ++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)



