Return-Path: <linux-kernel+bounces-28650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FD830157
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20371288748
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA011173A;
	Wed, 17 Jan 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="Vkmi7zWf"
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EEB1118D;
	Wed, 17 Jan 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.221
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480475; cv=fail; b=CTPsOUmfo3gUcigOs9a1BLDWGiJjBSu4a+XUKFV0Lgn3b5iGviUpFsmkjzocSH7TcdQycNZGDIfqcULIlqWvryWChstlbhqFsd6JFfitXtfPN4M/k3hk2qdlzc+FXQECrV6j5nDn6C8EFjYJ0fGdWc4s+aPVmsQIzzqJg87rFWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480475; c=relaxed/simple;
	bh=YG4k7zkcFRmfNoxLcj9nOHLOTtVTiD61pVcsyi0s5sc=;
	h=Received:ARC-Message-Signature:ARC-Authentication-Results:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=CSkzibAdfoYt6M0jHJMgdXvUQ460TxI7bWHtjnPA9qPFTSm1Wgj9WoKNeXDZjkDVlRt+Er8HPoQNPvRtoCxBcJgjlL04NWtSBdwWrfWmyyjocSdn/GpDhyoX3bAjgJD5NAhoP7sIJT8fGqK7BDPVU52Zs4+UB0QOwMQzYjt3X7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=Vkmi7zWf; arc=fail smtp.client-ip=209.222.82.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101]) by mx-outbound45-159.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 08:34:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5ED+W1mnrCmb39bEyG6g3g1TsXb0MJZsJGXR/Q6V3lOwDArsxUlHS6m9MmHIMHznhgsSNAwDnfb4aorULk4i3vO6iX1ZzKpSIQ3EIYrZUN5M3FIrn1PbLZ4o3GRA4M0F+YvZ9XKKaX86dfUwzMhnAmzWCARFqFJOTl2CRCBLVDgn3L0CGdZfW7nrQ9FKY6Kl4VH6O203Jigfy2xuxbUn/gAMXNV6vrpKITA26CQgIQ+DA1XRVnlXWstI7gFcD7ZimiRt7FcTd3EYVQLLjKGrx8yVr7m5JfUEic/qXThbemDIEyRDOPTw7SS0wDZ8FTzPHGBezNgOiOIqhx0rYOJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okOZXOoHZo8YjFuGasb8D9nCUozEYc0Zub0Ha9wY4do=;
 b=cuNnOk6BW2s//IlVEeO4EJW0NYTVbUHCLmUCDbMY0BHMPmqdn/6HT8h625Ds+6W14gfG2c+pvHgym+lRqCjwo7cTPxWv2Hfl2K5BQrqWi+7+KjSU4ExCBJ5uz1Tmjt7o5YkqVQwHBDzBI8DTIiQY5cCk1WTXkQ27lIE+2v0/Tmxl9bLd16lCODdwkAMnnlTo8TewfcavKnz4XVwYxdtEUIPU6/nnTfQCWX5bIjzhl1/lNi5gi82UVkXX4MUis0+qtouYmDIuB2YTM9vNiQDUEW4GBvDbeWvjTsHYSiZXgxaAtB1tg3LEb4NbHBr0X6Nq+wrm9KhkZiq/t6p1dhf4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okOZXOoHZo8YjFuGasb8D9nCUozEYc0Zub0Ha9wY4do=;
 b=Vkmi7zWfjYeaOsWyHSM/dzBIiT85H43XhMfHUtULPPP/D8jlSwXxPiZISC/QftByslIRTdKRxZYQl60YQlFn/35053ogptI0H7FhONMfd6tNxQ8uDHdb45PovK1gQ4CNIjwD36S5y7f2UFH+BmZFCUzkz6zvThgzPR4KiKE7XenGUCMdBtJcHpekJRaq6qYwAUKxvPsza+9aaOAEEsdgzcU1OzYlBA1UWAk4ryVSqZckauFEe74pYOj2YojFpdsWlHmoIfjx7KKxaEmg5owYHbD6KWdNu5If0+1Q7YmdJj7//ajQznkQHY6Oyr4CRuvS46EjeAESEpLsCOrybxi9lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 08:33:44 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 08:33:44 +0000
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
Subject: [PATCH v3 2/3] dt-bindings: gpio: vf610: add optional 'ngpios'
Date: Wed, 17 Jan 2024 09:32:50 +0100
Message-Id: <20240117083251.53868-3-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117083251.53868-1-hector.palacios@digi.com>
References: <20240117083251.53868-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::17) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 6005f001-2f4b-4aae-337f-08dc17370448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MXFpQqpyDf6/nhI3lX+m11n0LRiAiLTUlnFiHrZx0MRURtO5PmcTUgJ4H7qzRSqwlxgrORKdSXA6G42Xv85BA3k4KQsFjAubPJwGoGzJ1At4stgR1ySVKRNbg7d5BM6CWk0ml5Ew4BOqwIMvy23vqzjbZrDC783XsVik66NtUABpMNiVMON1EP15mqu68oeyH5B6gEEIOaUkvqrZ6hFzUzqqaGtqzH33SG1oesDFzlSB+FhJHruTcfb9zbrYlbQOTnWACqBczY+NOgRN3hxACtpTgZ4hfG8herkqEWVV1hVC6J6nc3UmzbHi/5Pt7MSWHO/qSWnNmma9SBzP0ity3ZpebYXEjrV3dmaXPQZ79KrdHdMV0aTzdCDFVMAMIQ0C+FGLmE43iAPGdvDY+b8/zzgd2L/0Ghrh+Zi0lHVfY54rqWBZkINLsmsyhhj7obi708IRxoVgj0z6aWbuaJdL3nvmAyk9/8FP8E5Kiy8jNMutR89ocmGdAnL6PCweaV4XWBt9nFLNG2jAeowRDSkQBFUCDIhLDhpeJ4e2/Uwhk3wCCjOGTZ2+GnhafZhTdMOCCi0PHPoLvYwKAfuq6qDrF6afhOBwT0mibtlws4hWoxnXP19WPCMp75eAqDiR3Y3n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38350700005)(4326008)(66556008)(66946007)(66476007)(5660300002)(7416002)(316002)(86362001)(8936002)(44832011)(8676002)(107886003)(6486002)(36756003)(2906002)(41300700001)(6512007)(38100700002)(4744005)(2616005)(52116002)(26005)(6666004)(478600001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GyHQzrBwJZD0pFBep8kbzY1JVXYM9lQZwGrKZE3L9U+kaejK/ZWJJR9lp5hc?=
 =?us-ascii?Q?U+5gmNMZ0YIWiGi1DUrzGNQgwe+H2snBoWNFQ5A3PQBoyUQ2fxbGCIH035o1?=
 =?us-ascii?Q?jQ847VeVy4Z+F3TjZ9Luq0NZyd9PrgR57Zxpk/LWxmmBPp50K1ouyVZrCFAr?=
 =?us-ascii?Q?PuGQE4oMPIq7fui5R69r111QOvfCBYkimPzXAZYL6TLgtkwg8eKsOnfJmFCL?=
 =?us-ascii?Q?NLoP+kwvqTtq++ji3gGVRxbSIoND3BYOtk23vxKaYhCK1aONBOk2CjEnsQSW?=
 =?us-ascii?Q?O0y0bKjtJ8HpGOU30FsH8hsuMiwP5ybLwfnzq5yQM/T73rLYjdbD0S2l5oti?=
 =?us-ascii?Q?Mo5D55KHHU+4QFFtT4zaIj1BDZcZ3EqFmZfWpANz4Cs0uBdzKRATdgufFXJe?=
 =?us-ascii?Q?bQuHTHYTmqCw9NBZwiEi7Zbmp9AmQIyfjAD4Zq7wyoIz5r91VFLgle04oIb4?=
 =?us-ascii?Q?SeNhdXXb5e7+x1byJ/AIfECgCEDBcknnwq2nwhtaPEoY97Kus5/kxO7z8/OV?=
 =?us-ascii?Q?JH0S0FonNBcLEgL7QCskybmKdbnskwt6cVWS/fE8ncQBPOHfW1GtsWfWT2V8?=
 =?us-ascii?Q?0bF9AQjDShBkQYUnnI4Vwr1YRHZZFffyJ7iuuqGy6zzpEtb6RKhPSH6cOtOq?=
 =?us-ascii?Q?ylTM7aju5m+owGHkcnlrc8drdEcr97M24XLAYJCTqBLXRTjgE3wMp8I1DgZv?=
 =?us-ascii?Q?tq89klz/Qf/Wp3PevmuNb6W4mw2r4R6Dt+w4wbPJFRcql9HIhwUaj5tr5TlV?=
 =?us-ascii?Q?bvtjFDVo0kqxEoMl9BJu60TeBF2Ey8fGQgN2YTmzEjFd2OnW4pJFcSuoqq1s?=
 =?us-ascii?Q?iSjWgxovvN40n8fsAXvplR6m0aJC5mcZcxBDmzc7k4XABG6Rgask3x3yLvlo?=
 =?us-ascii?Q?CGkKcxf+nRspRrevp1jKKTbyrWch+QIL/rv+o2lSTvaj9PzceJ4S1blBeM4F?=
 =?us-ascii?Q?urjlIHjJrzxR0bstb/ErCs/sWUyfpswrmAE4f+6pMg2fVJpdWg72vzxRExs7?=
 =?us-ascii?Q?M2bZOk4VFy3TyExnVVCfFzf5Z2mzv0+R4iEnOYSGOIu8wzbvTszTaWWsLnel?=
 =?us-ascii?Q?qnKaZRwnqZgKhLOc1BeMLBnDzQDbhxWIEmoSpIvz+9MWkVWAE07o16M7bFiB?=
 =?us-ascii?Q?dvIprmu+H9JmOj186zYBnYd7VQ4fyG/tNuztblLciZSlkV2aP0U5usJF5iFy?=
 =?us-ascii?Q?p9I6NwMbEXMCBAkQ2Yd4NobcVPgmtQhkjH/mkcaCImebyJaYM/qY/uJWvwLT?=
 =?us-ascii?Q?knjOvcGQJDkd5ucc8EIqhnWiNllEc+NU1X0+DO+wYUKr8PwWBzbY+tlfxX5z?=
 =?us-ascii?Q?uFIgtC7gRITWwM5JAyLu7utn/Cy840eX+y/InfIMAzZObq0oeYDfMjyi0Ngp?=
 =?us-ascii?Q?pP5xLHsPwO5CjCnmdgc8yz+ruqIeQKapjXP2Wa+MPoq3O8hdxnwNl3kTEhvo?=
 =?us-ascii?Q?MIB6+6Xl/ef16zuaUm8+GAeSbI5Qi5MSN4IMGAuHhf7kZAYGKbubw/TehToU?=
 =?us-ascii?Q?paunk9gZwOzE+09fYepBNZqwhHiZSTzEn/ZT9Km7kfMOiXedNpvsPQskv8V1?=
 =?us-ascii?Q?ZwzOYbe337wNkX3svhP9ceAAy78tdA0LOxvXFEC6?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6005f001-2f4b-4aae-337f-08dc17370448
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:33:44.5244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oz/E6v4cioMj/c1rF+kfr6hID+7fgWC+RW4NqElPqDkWSgICf9m8Qab/H8sqKFcWiTN8qCOjG9lOoSDQLoO3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-BESS-ID: 1705480448-111679-12553-156555-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.70.101
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhaWZkBGBlAs1TzJNMkk0cQkNd
	k8MTUl2dQoNdXcwjDFNC0tMTE1zVSpNhYANa8hlkAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253575 [from 
	cloudscan17-47.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Some SoCs, such as i.MX93, don't have all 32 pins available
per port. Allow optional generic 'ngpios' property to be
specified from the device tree and default to 32 if the
property does not exist.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index a27f92950257..ba4ebdbc5546 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -65,6 +65,12 @@ properties:
     minItems: 1
     maxItems: 4
 
+  ngpios:
+    description: The number of GPIO pins of the port
+    minimum: 1
+    maximum: 32
+    default: 32
+
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
     type: object

