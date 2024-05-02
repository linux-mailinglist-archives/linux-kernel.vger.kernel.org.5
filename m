Return-Path: <linux-kernel+bounces-167035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E18BA3BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9675B23758
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8236B1C2BE;
	Thu,  2 May 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="S9jStY+c"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AE57C8D;
	Thu,  2 May 2024 23:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691326; cv=fail; b=fPTxaEtuBhKLDu1ZR+S5QBMfIiLqEdRW4DzUGi8OQIU3291AXyIjhmQR1Z5HOd/TJlhFeLn70dQg6JSWBCRrh+/sG5PCE0neccLUcDUR4+0LNjUgNqkwjWn0mxOCbHHjm2dxDX3A7PC4/qWvn8E9Z5BmgIbC/XyieIBvSOKg+uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691326; c=relaxed/simple;
	bh=qq5dRT1FdWytudK0MHoTmLPxSmFH7b6Tja67737Vd4U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=El6De/B3Jl6qw3GeO8XK7S5Xz0EykB7FRisA/kaiJqG4/WpT94pSmnbBaQQjpsnecTEfhkfBFBuTTyBR9txcjDmfNdGnhwTp6l3O1t3kxW6bRvUmBrAjm4IN8IH9Tl/7+a+zWuHxBQEou3P9709GdWpKraGHuu8IRbrICdkxI0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=S9jStY+c; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5Y3FLOCRh/7qn9Aa2pTL4ESYAmXVj2/50cvF32IcXzsab07oW8bUGtkiNfgvpl4DucFKpWFDUt6e6F4TsV3DyEnD40EPkQ+HeifaAsOKRJQVEjLaWj1JeYooPtY6Prkdbfi5SkapsbVqpbXEMdN5MCuWlt5G4DMy79H9usCdv9tzKPT1ovF0gYkH2SKHpU2gTDUu7xv+3i8ak2CzD+hpgNMIlQHKgsYeXZJJgMEM0G7ABt/4CeYPJ5O/0N+/Q3V4FR+MemdnCHzvv/dv5vNY763iSkpipbALn7C5Oo6hVlrjf4yd2H8VQDX/rEULmHwztMJ4EhvTGsica0pUjA4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktyZUIK4j27jLWFyJOzXOoEaFQaQEa3R1OrWETqXJZ8=;
 b=kTNRJwQjx5IZ6Idig8GvL7GQnyVVwiXQWZWoWkMo3H+ptCq1Kp890VLmvSYmi2VuCDJCzCXNf8aMvbedNOzglHNlJrE9iD2C7ldVkLMXHKY81d8r9yylRRs8xa4ucQReyuVF1rxFh87Pj1p8ex2e90RXET71f8+oAVoXAetjPympCsuIY87vicXAJwE5Tp3RdzOaCQJ45AFaSGVEZLPeWV1ixCDG7MIViJLeca4aJqibhbs+HUeQyQN/1Ns/MPZ5Lgh4qHM00dc/1KpnLfVV0dLC/oDM5fXv/XvUaAmZWOqMU46knSqP+Tmrs1Gc9RVrHc1f1tGV1Puy0vyOH7YszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktyZUIK4j27jLWFyJOzXOoEaFQaQEa3R1OrWETqXJZ8=;
 b=S9jStY+cOWVB2eXLV/NGeEWoJrj8Pd+xY0seeBnnjz+iGUT//vEirUfdtbX2hr7uGBh8W4TbZaafJkdMROF4zTyXZHij/tUnPDQcpBCItF9URZXmCBZmXK3mg8inLATzE2OyXRmbSb4ZLZMDG7f42aBhfrLsqVw3PiIXquxb7wk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CH4PR22MB5918.namprd22.prod.outlook.com (2603:10b6:610:232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 23:08:40 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:08:39 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 0/4] Add overlays to disable optional hardware in k3-am6xx-phycore-som boards
Date: Thu,  2 May 2024 16:08:25 -0700
Message-Id: <20240502230829.1983678-1-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|CH4PR22MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 397552af-393d-4621-a5d6-08dc6afccdd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqEIWJ5PotclzUyUKsEM8TorMaybQAV+eqnv757HMHR1NBmA/Yi69a5FtTQo?=
 =?us-ascii?Q?l/ByHDNXIXpSmeN+u9ZVFbDfzCheVa3/1vpUvYmFiJySp6JRtHWRXFacnvfS?=
 =?us-ascii?Q?kkfJFCcGpihXkuD5j3JC+LBJKwThyOsYK89ttCbkLVrJr05Iip+QwOsMNxvt?=
 =?us-ascii?Q?C8eLNSVmmp+f7astk4Rs5do8/iRX98eP0ndS6OvmyKVmdOm/Fzl2wtQServB?=
 =?us-ascii?Q?Io8maFuQkrrAKPafRqkc4u5VE9vAS4nlVtmfJ5bA5fNinjnYLqtW98p0sc9y?=
 =?us-ascii?Q?EeKpZm0b8mPXOtVxYLDb2tyUmz4MCikpD9MSF7i96LembcP1/vFWKbnSCbf9?=
 =?us-ascii?Q?oZLhRRG5Wct2N2s5FbCTQB2iEDNAYspNx/0jqxx9IavySEAfjt6G+5GIEKyB?=
 =?us-ascii?Q?zBbQxv9e8vV30JMUtjSa3w6j1TMb2TQkVVXtqonN4fTTKIRfd6ttGxtx+Cxm?=
 =?us-ascii?Q?MCsMKwGqm2zEEds9d5RjQn6Q216Td5IJVuymAiIL/dn54lFOcnv8uRXhwApa?=
 =?us-ascii?Q?he4UZM3Iu20WTgP7DNsXgJ3y9/ATuzx1yeKe8MCdJOovoFxx/QWWGY0Ev+2M?=
 =?us-ascii?Q?BYsjZEY8sc5kfB9tr1yatYlmVtiggEeVJUB/cgbhvmKAERvr4D7L2zM0k/To?=
 =?us-ascii?Q?VvXwWaDm4IqNgOZyPDdoOGzvr/1/OSYeEvoagogONqVUbZwLkb370Geo0klI?=
 =?us-ascii?Q?dOTCRXuxnqW1dlw2K8jmvJMVC5RTh6STR2GtnfYUMbhyZuf1262Rtqo8m0f4?=
 =?us-ascii?Q?mUufdLdwf6ndSgUHtgVzR7nf3aiGrF4pHOBkas39YPE4NLLXw24Fy8BSkyl6?=
 =?us-ascii?Q?8ab+2R+y/63CntMw5at4UaLMcr8yFH4H57ABubQLANXD+OIAu1JrgBTGx3C0?=
 =?us-ascii?Q?BxsLSlCrpI6Q08L4NxWI0vQ7iny7hFm0Zla+riky2SsgNGgxTfDD2Lmq3F0K?=
 =?us-ascii?Q?+sA2/EFpu+LHtK84CMidAzB4dCRKlGsyO8m7HgiS8CKeWlFy5AuU2q9bAIEV?=
 =?us-ascii?Q?5O6Rv2w9HWr2J8aT0r4jes677XuHJMcqpeTuVDXupMr17yKfa6bZuiEMKgm1?=
 =?us-ascii?Q?5LvV6uNat9WDJjwtSktZ8tZwwWV/mRo4TxtVEl6q7VPmw8dpz272ahx5MqbP?=
 =?us-ascii?Q?W5n5gJr56b9fmMWl9Tvg5bP8jDiATmp72i5KKIBeVSj3o7/kzul+kg78RJuG?=
 =?us-ascii?Q?gX5TyjAMoFUzwZ9nvwqFcmooEm9/spv5Q/wfE6idpPalRT1dTwan3cpVsfEJ?=
 =?us-ascii?Q?o98vGigB8EJ7WlCGVpMkmfsJJHbOpGqOH69FCcigrxZQ4xbdUCZD3u4XVriq?=
 =?us-ascii?Q?2rkXm2shjM1yC4EY6HYcpxOXIXvAbpPGtWVuiDoWYMyRTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ybWse4Q0xsOyCBn6BE7XVoFtJ/py6cG6orKuwSIuQmGIvG5QSQc2tDWPSlEx?=
 =?us-ascii?Q?x4Q8Sh98fj0B1sy/mSBaq9CJFXTnn3tqJ7ROCyKYrTyyqYtgoQmauML8OfQU?=
 =?us-ascii?Q?qiXjbstBmPAGh33YADr9H3eJFeFY3ALcsUS1Fa+BjXVihHgKHgfkjQwX7EdK?=
 =?us-ascii?Q?CPpAu9QeHQ5SvqpyqWaQ0k1U6WV+VR41W9noT6r7TFUjTtRVPcZjHBqzMRUN?=
 =?us-ascii?Q?Tirpo2FuyvB9yXi4ZeWDzYteR82IarbHJDpUm0CPdRZPxC5jSe+1tSslirq9?=
 =?us-ascii?Q?9dJ7WSFS+O9gZu3Z72ELbhWxIBCGdG4+avVcTYqMhJoxwNKVjdui8CcxW4vC?=
 =?us-ascii?Q?6LGlHDZsz58ntnXtPNOwaL+OI6MKqIbnCpEuXCl5gH08ChoBn9b00NmLDaLu?=
 =?us-ascii?Q?pNstY0pQPyZ0+SMUFWgdKKKS3m+i2vyNCq+G0nycYPgfIi3u8uiSdgkX0tLN?=
 =?us-ascii?Q?YwBLz3XdbgVropKHsQfAtz3j6fqpo/ceqbn0FGOQVQ3NcV/ONA63RR0KcPGa?=
 =?us-ascii?Q?vWeIAL2db256tY/Gm9BWUyPj4nVuKEHGKNEQwiIhohRePDhtn1B7lBggKLYb?=
 =?us-ascii?Q?HqUhTaSGq+oa5EYi3bbivDozuVHZiqI5r6lZbnayze839S2TMSYheARepSS6?=
 =?us-ascii?Q?z/F0VeBGtZ/iJ/bRPZCsCouAsGOai7a1LKSqAXO8uctTSdhcDPDIuEzEm/h2?=
 =?us-ascii?Q?LucT6cMM4GADesqafg+4epxywIl63IULJftYdgjIno/w5dtuzh+eWf2R3ZqK?=
 =?us-ascii?Q?dH5fO6VOTop+uTtFQXG8Iat1wltIT6F8IzE2T6aY9cygliUZ82KadRwhpTli?=
 =?us-ascii?Q?0qxZRlBioiFwsA+iA3uZMkW78ItTzGXIG4T8I3g4nZIRuPiIcu5qvhv5RiWe?=
 =?us-ascii?Q?dROWenTRbqM6G4KAIyquyDZWh9Dp1IyQic64aNTRqJrfWnguFZTmH5FfwXQz?=
 =?us-ascii?Q?gzjw2uo+R8eHsQ7CRiPcnfY+BVYMDXOwz0PoeV+q5crhg7SQYysyAOlPZTbm?=
 =?us-ascii?Q?pdeaOSWQZK4fI/c/kEUgFKtviIc/0hbxq9iiGeUZLyopf34Qwc/8nYc/5FDL?=
 =?us-ascii?Q?NXdoHT4BsCVUVzwglg0QqYblmNOazjecNjUXkIBs9rUKwThUCLy2LQViJswZ?=
 =?us-ascii?Q?yhz0FHAw2e6KoMXlZvTfz37Oxk/5kAZleruqUcOGzvJ4JbaVXRsnEC2a/ijW?=
 =?us-ascii?Q?bzT0YDaB8y3uzpbmhltH5dzsQOH5J0DFc3fLoVsCTeDi51N2EqAQbLWAjDwh?=
 =?us-ascii?Q?u0xbRLc9ztg4QvlfoY3TR6wztuwLlhKP5V6FWfRjX/xnK0uGwUYhsns0PW6s?=
 =?us-ascii?Q?2EkhrlCdIxEdqyLrryfgDjb/HERbix1N/CK525HdYMHauhxHZCpRUfuh042O?=
 =?us-ascii?Q?R1mO8rDEAp1POOre8+MwR2/DiPB2O5Zt7UW7FnZVeYA+716ksWZ1fQYZrMH5?=
 =?us-ascii?Q?sbbNnYIkpStfYjPM7jb+nySW9vRvJ4yd3RGIzsXLYPBl0IaXbJGrDmoZqYP7?=
 =?us-ascii?Q?okrIZ8C1AUX0jB4DjKYRB+FNPEN25HRYJR+n7SVL1ixlKp879wffrOuyKuNy?=
 =?us-ascii?Q?bntSwOAGOevr8qB2PjvKi7m/t/AwTPX0q2/EYsoB?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397552af-393d-4621-a5d6-08dc6afccdd4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:08:39.8878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH11AMYM950WuZFDkkq6w+y5JCp19SprRQd4Aacx4bFrfq1s8F2ft8J3ltqTkMaB2opOmSsa4HJlMuu1i6gHqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5918

Add three overlays to disable the eth phy, rtc, and spi nor. These
overlays will be used to disable device tree nodes for components
that are optionally not populated.

Nathan Morrisson (4):
  arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
  arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor

 arch/arm64/boot/dts/ti/Makefile               |  5 +++++
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
 .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
 5 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso

-- 
2.25.1


