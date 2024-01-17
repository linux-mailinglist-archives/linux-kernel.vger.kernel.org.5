Return-Path: <linux-kernel+bounces-28753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138A8302A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1376D28683B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A372A14273;
	Wed, 17 Jan 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="QxLloSYE"
Received: from outbound-ip8a.ess.barracuda.com (outbound-ip8a.ess.barracuda.com [209.222.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E901E14004;
	Wed, 17 Jan 2024 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484791; cv=fail; b=H+JJYB0H+q948Oq80Du92AvY//TMUczFGGOdqcBbMgTzB78bQQkbV2ES9F9pE0UKaFsYglNaF/VNp8aELM4Mc5NxWff9ti8bNYoJ1dZrRi8fF1zbVf98qYHQ5tW9JSrrjWPz6tXK5Z8tnK8JgV8yDpfIlNCSEkn6pKk/nM0fgEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484791; c=relaxed/simple;
	bh=RVXxxArC9eRrJEsad5t6W6Ei4tBOWla+krm3odpqWtQ=;
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
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=Bii0Q0UMzt7Y9pZGV43ouDx4JQLJD8N0Oy5kGMrwOgfvgn8LxazFJQeHL+U8ebggbcDC63u0CF2H9Y41jdjJ9hrBfF3efiqH7+0Ycm/TctzwDiO3dEseFh3hK1gOF4+R7FiOB76qSSHVhI2L3agKKt13uDwZG6fSTiqdopHvAio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=QxLloSYE; arc=fail smtp.client-ip=209.222.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168]) by mx-outbound14-151.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 09:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9T5NXZol22wsWNrOfoUPsbVGaBSUXfiuS09XisX7W5rR3S+4HExZlWMedCFuB7Iv5Ly2xDHbe7Am1N6M+D+98Ph3LhnabdFCYEZWuoVkMdcNglsPGBKFh/wvpFuBMCbEOawwecrFhQVyGXmvN3eAPj22pNF0VNe43lPqVK8xEbmi4T1I5DFz0NK9vInxT7z3fKROKKOS9fTI9SEtD+Kkrl8fctMVpfPFvIzHfEPQwRY6lf5Ct2u1kkPjvp3cJUf3eBUl5g75z9ZFQi4biNeGPHIRsUWftA4IVTaRip3oP1rGTSIJ5DQwaX/FrI6ufEel0FAmU+OtGsGeJh3jyBsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JC867L+c+Oq+CL58TGFeSo5XhBwdPXesZY5memBqF+A=;
 b=gRla/BnSDkSOaofVUq9DfSxZmBDl3u57fgfhU6wumB8h7OBuxIq++HfkPi9JGWXBctRL1ahHMZZDrOvFlq0fjCNTbE9puLjx3mLvhVR/J2Nc+0GkiKOXrxaPd1u5Ol3DpwRDTRFmf4/lhjo+gq1uXsy2BR2cJZUVCBEnrXYtezLN0A5XXLTBhIQJlS5SEZAnYjh7czxVGfEUsEdrqjJBxkMz9s+bXZnmiZErY8t4+ddssdj9/uqcDxVoiUZNe0eh7tZwf1OSVYJVFfqlYXO9hx44XRr3fkgGwnM85LbnPZwif2er/DOpay9T2jokCPvmyMTUQRggKBup3JeVcWEHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC867L+c+Oq+CL58TGFeSo5XhBwdPXesZY5memBqF+A=;
 b=QxLloSYEis8vbRf+TGnK90HaHoePCL5P7r5AWihh0eK1xohpFcWWLgQWMxOGoAFFtcchQWc5/llVGy2ls225QgP0tDMMtWXUaIZcie+nyv+IBsQCKB3UIJPvx41dRW0ukJ/MyQlUpXgQfKH9g+X/8q0wydTWCtqXdfXLGAUJNiMAdQs+SxOefXTvEKhnuOqzQjj7Fcx4SuVI6J4bQrSyE+TBrO18GlAqU8GXpCrgD2JW3JO717Z3dEP+RKsonMs29ExIqKMcDhVXYVNKlWuXnrOHAjcMd0Ogr9jbfGRrmvKnwBhdjiqqIUDUlewHRI0srnVB+oYCJ1bg4gDRUC4pZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Wed, 17 Jan
 2024 09:45:37 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 09:45:37 +0000
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
Subject: [PATCH v4 2/3] dt-bindings: gpio: vf610: add optional 'ngpios'
Date: Wed, 17 Jan 2024 10:44:52 +0100
Message-Id: <20240117094453.100518-3-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117094453.100518-1-hector.palacios@digi.com>
References: <20240117094453.100518-1-hector.palacios@digi.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8559e260-2104-4fd4-d376-08dc17410efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wJjHt/1tbD8ElC+7kcvfEsQoVxM+Ch5aLMdFDekkXVW4nu/IKvEiENegiqTOo1ARyz0WFOccuSl/h8abZBqoU/5ObAnulLqU1Lfwy1DQXBxGLPZ6GvR1VzzdBkgn9hNQy9awaseTWRdK6RuXdED0ttmn+P8wSBEvp2jzNn6lPNVji+LPKtCQmcyEEYdOd+kCFo82w2XXFzzCVndVwAT9ZMlnhSQq4FDbMZHTAz+f+5NXIz9XmfC3K2kd4EzaOnqVomy27OQgWZ0SX+ZWZKkrB3rpCd9lLr0Kk+j9ITeeq3G0r7nZ4fB3pb1gtXlxiSGvQmdtrkcwGi8Z++w4bGeMYsM2oeob0JdFs392+5IMoW0J89XaqlblSJopaKI5+tmxfqgGjznubci3Vwj3A2Bf91YLg36OaphFgn3pRzQ9qGu7EwvqiCIifgwzGCUg7ZY6zQPYosmnHeYAddPVhw6DdT1h/RLjRB4pv/WhDtpyN+ckOfq4OTPPegBaMEUSc9HeY7c8ppXTgaW5tvLcchw1XjjBq4UIY/tX8tzmXSDU/4zCofStnhOwVvmRJHgUIpfda6xk1epPwrDNOPRPOBiQvX0ui0Y/QM6KVPYpH0llgh08sLLvS0usFbamxXig2xBu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(376002)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(478600001)(52116002)(6512007)(26005)(1076003)(107886003)(2616005)(38350700005)(38100700002)(36756003)(41300700001)(44832011)(2906002)(4326008)(4744005)(5660300002)(316002)(66556008)(8676002)(7416002)(86362001)(66476007)(66946007)(8936002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T3j4vV240ZJEfIaVAOA4Ks3TVHJpI6MFRRGYxM+Yisk+fbzAF2U8z2BMvb5F?=
 =?us-ascii?Q?se7OREdsuTfAKL/kbAs1a5Yl2MlWwOQVreaUEX5n9N8do5aKJwCwWf99VXbS?=
 =?us-ascii?Q?FUCR6RNLYWyqnL2nRrt9pGP+fbYx0a3DBHBip80PcX16U/V0rxusDOLK0Gh3?=
 =?us-ascii?Q?U8598/vU/HzcgIVU8Qzf7Jbsu0LEMoDrHkau9JtpKnrRZynTmxw6Xe7saW5v?=
 =?us-ascii?Q?cyuRgntWa20v3rxV+WLLwhtJOmPJUxWW6ntl2PTPWvuRP3yFG8Lar5hLKT9F?=
 =?us-ascii?Q?pa0SP4sMKeekthRXQF4YMUDOAzHkQlLRciJ3bNgUIX/IqUSrxmSjtlZpvOvs?=
 =?us-ascii?Q?CLqKozfOlVHY/cJa4I77UFdcO0MjM1gK6rYk/wPPH2YtciEvH0jw9T558J3Y?=
 =?us-ascii?Q?8eaypxsxem2Luf2M0S7A9kx1vdsOvpbrTZcB8r7i7mV05WioDGhWZncIeOty?=
 =?us-ascii?Q?dPgwqu0r5I+/+IAldg5aaUba+23DNMM2IQd7zI4v6EyyG+XfbIyPnV07FfhI?=
 =?us-ascii?Q?A2uAcq4wTtZXPiSc1Jhh4cQbb8dYQpUq45O8arjSPMpB1nEIPeCwy7uvx3io?=
 =?us-ascii?Q?x6Yz8SrGf54o4WDjS+f+dt4RYHoG78ai5R+M2Nn7Pv6nQFo7+RfAjqWWXJ/O?=
 =?us-ascii?Q?5htFchWnxL3RXRDuL1/yOK28FO0iQtnos4ikKHhDAQzCJWYkG+HM/lQc4aZd?=
 =?us-ascii?Q?qakDq5CEwu8NOfK1XOvDj69W3wTDH3OUO7lci8sKk2acGgqwAhzb+vrRTquC?=
 =?us-ascii?Q?B/r8YVhQSuM7q8pLmpOgavwaKBzN1qGa8EuIEn1ZasIMz7oRsZB1wkxVQTWy?=
 =?us-ascii?Q?YM5PHAUWsk7ZkI8ZgJbOiEc5zMbM3oypM9rfka7CZxPJUrvgCl3XKt3RaFxw?=
 =?us-ascii?Q?sIybqYKurKwr5/dv3AKeliAUCurY4D1BUs8HiLD9YahzBx+sJGqlU3Wcm3s6?=
 =?us-ascii?Q?VvrDyLM5RfgNAsWc7JdKMWblIcuLjBzcXu4mYYwdlhhxwi4lXGX7/A6j3ghj?=
 =?us-ascii?Q?dDzxhrDhgI6vZsy+eub+A+0Ekq14Bty8WQt5SImAQ0rdcNv4zNAm5faNLLpZ?=
 =?us-ascii?Q?Vim6gnA8K6Y+zI0nDQKMwC9LwLgwPvrvE1/iLA7G9Pbq7ztX9LbUJJes+ooB?=
 =?us-ascii?Q?+n2WLNUskgCXoyySN5iX9fzvnfjmw1d2A52A3yXJ7tew7OMFX7My83SGYdNH?=
 =?us-ascii?Q?Qzz9YLwOp6/nD9u4UWtEZu9/yXPkXYDHknOM7A2Kl6Kw/2Xuj+OINvecmY2b?=
 =?us-ascii?Q?yZkpRfx57LXBXQxXzTLKTWX1wmQyDexy55a81l1mYCjFQ233qIerxmGxZExH?=
 =?us-ascii?Q?btIVuH9lRcwgxVW22tIpuf7tdP5zfXrzEF1Gop1XojKZStaHbqPQY8cagyxH?=
 =?us-ascii?Q?eZzc1NmAK6cMJMVOPOfAJV45pQUFex23/TMKTNv3l9nQWa/21XozgusuIFGR?=
 =?us-ascii?Q?K0TPu2s1jvDHk5RJFRh/Yg0D9MNfhYHhDvV3b0o/HFlTyOJ8n1RhOqU79g/P?=
 =?us-ascii?Q?IirWsAEipbpmsnj8ElX/DzmIDZbvSfULrgM5aXwiLAMS2nBQm7PXxSB1nyxl?=
 =?us-ascii?Q?myrJZZmEDFVFOWjr4MEQNhTwlLmSlm8OEKg63bmk?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8559e260-2104-4fd4-d376-08dc17410efe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 09:45:37.4731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17fvfE+HHMgciNLUs4DSIGbeyn7k6xY7NA26+ZqfTxOAHUxlGIBhIgS7w6qeGd7OHzQh/a+3i3rj5GPL6CTM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-BESS-ID: 1705484730-103735-22813-55859-3
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.58.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYmhkBGBlAsLc3IMNUixcjEwN
	DI0NjMwMIkOS3NIDU1NSnR3DTVKE2pNhYAA+umjUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253576 [from 
	cloudscan9-187.us-east-2a.ess.aws.cudaops.com]
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
 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
index a27f92950257..1702aff5e0e9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
@@ -65,6 +65,11 @@ properties:
     minItems: 1
     maxItems: 4
 
+  ngpios:
+    minimum: 1
+    maximum: 32
+    default: 32
+
 patternProperties:
   "^.+-hog(-[0-9]+)?$":
     type: object

