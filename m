Return-Path: <linux-kernel+bounces-156295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501478B00EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C992838CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A69A15539E;
	Wed, 24 Apr 2024 05:13:48 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E115535C;
	Wed, 24 Apr 2024 05:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935627; cv=fail; b=Mmt45DF9Hm6SAqeab2bXVcZalRhjRMdJXa1FxWsHGOQ+wKV+9RpxbGnYy6yVo1HI2XhAkS78GftGfnwy1UGfoI8iUHygzUTqb6VrJ65XQG1a3uUIiLM7f/hJmP3eNgMelsjEAGfiZVkgijMO6McXkIN7Cyxiao2+SAvsO9qYjxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935627; c=relaxed/simple;
	bh=lQfAbTG6iFSA1quimPcTUenPZTEEiZfChKNnH5ZRj/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seacJM20FLm0F/R03oOFRqRcPofmS1i7mLhHTb0k9YafMuyZ57nnJ8h8SI5NtBNE3ZUXdLvaDkQ4Id/zE9v4M+nLiE05CoPw8ML3YKqqwauzr4BmA31bP1nQNo7kcvf5/0XJdqsZh1904uQUjtNX/DlOpBd9XFszl1Aj0XqEN5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZiDmCYOdJ6t1u7F7HTt/rJVPpxqbBDMlUzqPvmNfyJC6MeZ/VUV/VaOmgFOKPGLYkrRCr4FmhA6WYIevoC149yrjmYYIj7meA6pZJqPQgjHYkSBmEj0xsq2PbxINFbzyXjdyrVoswX2njKxhDQ5Em1sBkocNEfNI1iZSwv0JvHaSD0rCjmbeXPb/S5GMNjEmg8PyM7YTkx1C0Enr52hYxqFd7ilMfAly3mOLmMYxVg56JHkQ2z4TfhydWlDh1lN9ADbvdK2kpMjImeEbMrJELbPjCrHyCs+pP/OU/8wOlUHfYZWs4bXspZjNn4Iz4dNSeFQw9UB3YtA3obO5VzMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGPdyD90e52MBqfhMrUfF676Lxr2rIOdEtFVCXI45fc=;
 b=JvYRLaCbO7+XBgPQBYavt4Be27lz/eHd243KLeKzsxSBrtGvx8Tz7sHXYpvPfXUqBd4vJfIsZ1MHJgusMM/VIjphVcI3Tid+KrSTEnlJuZxB7ToX3s9ivWBi6nH8xFTzlpFw4qnIEm5IkC0F8hN/MXrnYW+eophgB6ab9MrPCpQzy3+T7UozeIzD8Ks+8rhv902L3sIjvkBp2cykHzd/gm147cHjL5WQ3QTzrNpi6qHL2iRG8wtNkSStNxvD9t9ikMKeYFD6iDGhtUW0GGeY/Sar+4fGH4RbyZsm0FgoBZ5nY3toN2x6tcUm3hcJvdaBBKCJWCzQH/wHEQRb5MWYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1268.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 05:13:36 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 24 Apr 2024 05:13:36 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: [PATCH v1 2/2] dt-bindings: spi: spi-cadence: Add optional reset control
Date: Wed, 24 Apr 2024 13:13:17 +0800
Message-ID: <20240424051317.2084059-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
References: <20240424051317.2084059-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::8) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1268:EE_
X-MS-Office365-Filtering-Correlation-Id: c960bd96-051d-480b-48bf-08dc641d4bbb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KwIMy1HSNfJavBIoHX/XxkIOf6dLljekf9lYA/6Vt76quU4HRI4gukY24/nQ19SV2XOVjKmJJxMgEwo124U8EqCx6AQDV+lW1IUmBITknxr8E1F1yi76d6im+WIaFaO4TLnkgqCH9zt8aq0bhsvW8j1KFSNk2XbGpWl/z2hPsx9h2ccHwcu8/KE8u1vMPKsQdNB0I+YFnnDdknL8YQ+LAQlmca67a6w+noc+tPJsp5n7ss9vDXH29uJrtBdSuqSqm0VIYuvQz5cAnSNYTgj7pRuQa2FzznLv/TIqm9Ngl7MSaQwyW5lzwiksVuJ9lWc8d8cpj40pYiR3HrpNjFQdMGyToSoazdHTcnm7xZCVhjLoxQtuGIgfqmBv4yLOzCTePHCbjrmyKYrOoJJUlE3JYPfYzU8UnGI89c76o2uYieMTlQU4TmnV1d1Ae7vWpuPoO99ObWoXfC2Rs4CKNmp9MvXLaC3ng7f5iUVyyAShgvZPpLGh/Kc3RMwSB/4etSZdoE+TRTQ3o/6+Xdvoo7DEgx+kw9qSvaYSkI/gq2JA6IOgMxhbXsgtfQad3apMAgdcX3Itf1V5ZGCELQigsK1VPhWMdRixZbzn6hfiDu9e65usDyFeYfyHDg4x/V/umFvU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDOtYAcnfKrMbTR5lDYazlbV0nbHINfcdsRfZuF7QRjnWVNl/H4YREG0bp6v?=
 =?us-ascii?Q?2IJYhWOaf9jmHYfhoMAYkQdf8Ewn7DQNKP3CVSV9860qGCoN5VBtBr65cwdq?=
 =?us-ascii?Q?UfOe50ZISpgoI5u5s+tiDfFrD+RGQEMBac3nPEqnMgiD7kD/0IMPZAX4jPVy?=
 =?us-ascii?Q?1uu6XEER8b57+J3xTDM1uD4vMsVSf7oqTRbe+76IZWAaFjcHRUq7Eujhq664?=
 =?us-ascii?Q?q8Z9mbYuzbTCpDDyIh3Vr0/iXHjQ0ZyaaLDRuv2H6hi+7aoXsdP4UC8vjm9m?=
 =?us-ascii?Q?H9MMQ0rW+74MJE9ZuW4A2tfyTFwOFsXBWt4V6gePb2MZxXTrB5umIEU4tT0d?=
 =?us-ascii?Q?BvsNX8nS4MeJ0VHuze3+GdSbQ8bwnnlnfP2j8T3Gu3PVvb6w9aWYzndVU75J?=
 =?us-ascii?Q?Lz7+KqHJnadPSyz1ZrT/gBg58od48McRpNRz20LHIV11p4phREjtOlH15a5o?=
 =?us-ascii?Q?yWXe3j1B7QfPhIR+bTE8+NEuWXlQ4nF0McgYBM+slj/wNCz0uY3ecvARb/CJ?=
 =?us-ascii?Q?Rq6so5uNhIZCTcUx2wiXdjK3Ho3hB6oXzHtApVLuXfQd6YWFmWtn/VVXAzxD?=
 =?us-ascii?Q?onu9QIsvsJlSFCNW9ar9cXtYs3Zg502aCQBWg3rTXtjhGBfU6Jles8Vmr4Oz?=
 =?us-ascii?Q?Mzw2jJWL3oF8aOCOVU2i8zQOdTLzTQhzuCUdXuIiNC2dvPHgHx1rarwNy2pO?=
 =?us-ascii?Q?SPbGTaIPyImnLG0mdGXiBV9vqjW5vEM2o9wC25VFy1Q4X8DsO4hwfFHmDqba?=
 =?us-ascii?Q?tMeXNLAswhnK9rveklLzMGiIvjeLoGGUX588HdR4k2v7V8kHSghn+YsQ/H28?=
 =?us-ascii?Q?zGQew7lsxIKQ4h1SYiBCNXGRFO4bL/ONpPxCzGpK88oFFCWrIrPCo30Cc8eE?=
 =?us-ascii?Q?+YG7mTJ2zt84tVw2Xl847Xf/Gk6WzZsSPbqNc2ORNMYu1/Th62rjgIT2crj/?=
 =?us-ascii?Q?fLns0DhsAZNu5SSI5sTPVB3QWIKSSB317GTra4NExora8tpGQZMJuqLuxgLG?=
 =?us-ascii?Q?g09nU5d7IwSGfLSvye9DpDQgwop0HAVZAxiIJQYzy7g7PacYHq1v417R7rsa?=
 =?us-ascii?Q?UuNdyxNxSrNH3r9BklPhimmqvm9owu/KpWk9p6IZz+Z3ZvnrkXsxo8yxTCfb?=
 =?us-ascii?Q?wdsQpt+bAMqnAeOMzlhA3Hi98/vR4rSWrzBFyXqdJsyiO3oe6R7K6UUMy/aN?=
 =?us-ascii?Q?TYR9DsIgrDzPTTRItnTo6DpnHcdHbfx5/PEkPgURwwjeJyN8JnAdW4XaWXG8?=
 =?us-ascii?Q?CTLv7RtPww9N6KMbaoift8mWY9QUAmvTx1r5kviC9v7Lb0Qo2cI+oWOUsGB9?=
 =?us-ascii?Q?Y6mUsqWiB3D2hT4Rzit9sVduQ9Q+UwS45UFXALfkpO0lO2qDkm1I+3cMRO88?=
 =?us-ascii?Q?Zkt5tBWzN0PK1FYCJrgfSey5B3PO8faq5xRo2yUYGLQ3LsW721dweaubfd08?=
 =?us-ascii?Q?4xWItlxHOY+uyqwpVc5eEmuSCiEFc44CQ+0ZvRiyQKewWRdnR/+AuLlDV+E0?=
 =?us-ascii?Q?rE/oDiRMGpbrruB14X0C/kdMkp6kOjbejdIib4FGthLij6axBe8cCh+SFwFp?=
 =?us-ascii?Q?dYFbGvs9fp23TcG89HcnCDLjoT0BmEICNvN6ZJoQtTJoYt2/T6YIZZz/K2il?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c960bd96-051d-480b-48bf-08dc641d4bbb
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 05:13:36.8825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5xyM1ccI6dxSEviHYDUL75OvBe6y0nvPG2nsEkY4VCxCZ1LfmumGxtv06gj0PMbrSbGNGnlWrFaE+5PgJq6tuSYS5903Ynf+Tlxt2Q1sl7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1268

Document the optional reset control to SPI.

Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index d4b61b0e8301..2358489be4bc 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -55,6 +55,11 @@ properties:
   label:
     description: Descriptive name of the SPI controller.
 
+  resets:
+    description: |
+      Optional entry to specify the reset controller to the SPI
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.43.2


