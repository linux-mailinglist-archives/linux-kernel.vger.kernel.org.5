Return-Path: <linux-kernel+bounces-31013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D759383278F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118A01C22B95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6113CF76;
	Fri, 19 Jan 2024 10:22:33 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2061.outbound.protection.partner.outlook.cn [139.219.17.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404B3C6A6;
	Fri, 19 Jan 2024 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659753; cv=fail; b=pJMUhtQ9aRzU6VZDQnkfFHN4lx2r4rwxtyIaTtlStI9J7nmadpj1BwMw+DlpqMYR8gVvLRwK8aCAnCmqHu6jPizNuGLDdDlRle6MTFSP56Qjfr/D3AGjxZOP87ko/ESO8m4FSc44fBj2b7dHcvnmSy3jLddG2WAVekkwtakSqG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659753; c=relaxed/simple;
	bh=50cEe5o1V8ZownQ+IBvROnw5ZoEwHxN7Z+mIztVk7is=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=scy57MEogFaeXkTWpx266+8ekAeLPOUAMJU5dhdL/EP6wehq6trddoZyhK0wAMN1PkSy0EUe8E7BdcbTFQ/c9skM01340f7YLY3pgKZSxULyw8e+Xpfxj57zAGmf8Hx11cGOLwKsipQKkhwANl6toI0hTNl3yaktXXdX4ZCbwRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E00Ukdgeh6R7QHTOKp6sSFBnyTSKV1P33UNBAxIniJNsAe0GGUhevJ0q5cegD4+hXGfgKGzBD6VVCA/FJRLd6gwb2kW+8xy9q5xkk03saXspQq/fLllUBr36m6bdBuQR120ahh7JWCcc1h6b+dnNYrWRcM3JaVYRo2ILAYG3kw5xe6JYcJQULMd89rAaUrp7hAIAWdDr3Vr22KOQrjVpfi8uQmV8jK2h4HvW99PQszLJKkqXiEvQCy75TY+AyisltffQ/Zspiz23cSTimg12zR0BnzDyYwJXr5GtACWEHreSq4kfpLC3tsI10+4WFQ2xprODC+ejkKGktEsKG5ymxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZAABOUtpqf5hjmdODAWTTGy1oQaA9a0ky+v4b3U++I=;
 b=fvlo22zG61+FoZKxa9kRjPQHum/PL+1Q2LPsEXjAg8+6rf1UmqwlR6AJRrl6REZpDqE5NHv8S1Eda8HIwsqaLyzysUzQGC20LSbw1l5DPsTKsRGZOLjjyoX8Xrfds1ROJhA3rwhTSdkq8Ci2lrrKkUlGRVuKI8DorI4IKvm02Hpj5qe37Z8fjOuk58p416aqYeP5/kITkJeg0uesdn9tgNHcgEJL/kT8eSaeE2xstCe9Lrjw28ooZMNP34f2YXq99/hMdq3kspPV2DArdzD5YLzBCpXRCm6P6vGriM22qafPNrhLV8mMD9gVDxGV70NtCjQznbpy6w+GOkut8kU6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0558.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.32; Fri, 19 Jan
 2024 10:06:45 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::148c:e1dd:302a:196b]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::148c:e1dd:302a:196b%6])
 with mapi id 15.20.7135.033; Fri, 19 Jan 2024 10:06:45 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jack Zhu <jack.zhu@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 0/2] Add camera subsystem for StarFive
Date: Fri, 19 Jan 2024 02:06:37 -0800
Message-Id: <20240119100639.84029-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::9) To SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0671:EE_|SHXPR01MB0558:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfd1e6e-d54e-4cb6-9c44-08dc18d657d2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3/An8VFnQu0NOnsLHocTiHE7uokKHDRSSodF6hfDKtBN1N5su6x72IhKc8zdZ9ihiL9dXwDxpANORLHA/U2XVVkRXZMOoz+ZG4NxgX49HZP4p0gG0JTY9BqmEK8PxTFylokjK5BFYSvbheEoYJEVVmuIX4Ad/5TNHVcbDXzUC8PRbrQHGSrBlbNA1h7NpA9T5+Gn6DHqfmLp6xUxdk71/F4LNS0flFh2/F84IgBVNBuXPKVKc35s4OLPXihAhGL2TuF2keFvvV+RNNWxmQoSZsSI7oFsSE6aAyZI27q/UjzBjI6aMscSrWDGjh69ze03IPpHHheuEWu3COWyJBqXWLc3EEJC0BXRUJdh0zvk/vXPBmkWLNpeT6VXRAEFjQtLi2ern9GR+6byvfeuNdrbN7y/joDjZi4lbM1cfuVEpUSfazbb5Y5iiPVsJyTYYOVhG98sBHlETGdejkv5Z+pGxg968SU5LiNr2KWrLUZWrWX8xIWffAr//n1LKd+5D+Y4KGX4ZwkJvMgebQw2HEtNAAQ5JzcDLAg7PrP+8Qdza8uR1FZbfARR73Nn+rXK3eGS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(136003)(366004)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38350700005)(8676002)(6666004)(8936002)(83380400001)(5660300002)(4326008)(508600001)(66946007)(66476007)(110136005)(66556008)(54906003)(2616005)(44832011)(26005)(1076003)(52116002)(38100700002)(41320700001)(4744005)(40160700002)(2906002)(7416002)(41300700001)(36756003)(86362001)(40180700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KUx6h9a7Uz7O7nFjBJ+9zjMWjvafLj+gnjmKPDdAUM2hTeAeN58n7OrvM/3w?=
 =?us-ascii?Q?JM2kA5KlJnY4bWYw+MuLfQynpq8UZsPnd/QmBP54UgPDuv06uaVpxqtBI1nw?=
 =?us-ascii?Q?yQ6wxTeKX8URfj/ivKrvMZ0jha2o1xZ5FDxLTizYySjOf+jETPR5I/Xf9YVy?=
 =?us-ascii?Q?Sqy08YKOqAzm60UZk4TS32t+9AyiOiuv/wn1C4iqQPL1qLB2hwkSdYR+E8wi?=
 =?us-ascii?Q?aLAWH2D70Sr5LxYydZJGVInfniWnh4h85AWzBpYkppwWTRYpOf240uWKc8Ao?=
 =?us-ascii?Q?owcpYV2KB1yhdc8Lc9UZ00BQcdw6iXXmjoXXpGgOK6YAd7w/tMLtls0HCT39?=
 =?us-ascii?Q?6QkfNjMPFExfM2YpAeP1shA9/VsGk2SrqFP8IapHz+YjDdiOXjVN9lEWw0/8?=
 =?us-ascii?Q?1AreH37Hhrqc6Qv4UDqAZZ5hqohgCVYiPGZjM27VNdqPLdGgzZXP5GlpjMjT?=
 =?us-ascii?Q?J99PA4MEvGQ12J6FJ0EHu5Aazch+HHY/U1IiBnH7M9puwtZPH7EvB4JockuL?=
 =?us-ascii?Q?jXmuQ1mXIK8sK911Unw7wfWSLOeMxqeJ0hnBs+Oj5z1Baewzt3HV1J73BbOm?=
 =?us-ascii?Q?5YaVJTNVRrQ/qbjwVKRSUABklldDPEaMwyepVbP+1jsijAO2FTMbdDab6JGZ?=
 =?us-ascii?Q?2EjkEVhVbtYx1YoTusJRWUC5hSSeKCAwqCMqD2tVcVCuwjGjlX9A+1RQd6AJ?=
 =?us-ascii?Q?deSLn6LXqfkN6fjRu+J0vbsLItjmR5oUzyc3ykmBmXwUmPqBGTklYRi+UZMR?=
 =?us-ascii?Q?QDfyAXwANXeD4truDr4mhoT/hgGvCR+d9acSSA/GmZiRzZ9tXXJ484hoKxEu?=
 =?us-ascii?Q?QkgOvIgOsCFpxNZbi+p2uEEdDTOcN7BBC4/tVeNo2J13uceOiPL8Olc79kfY?=
 =?us-ascii?Q?X33EDcKCLkJ75n+DtFnMYCT3K4R8t1Zsk2FgzpK9M8N54y7SnZrds4ZEVPhh?=
 =?us-ascii?Q?Yu3Om4bNcaPFboER7m0YbiOfWeVKpH6CL+65mlQiHmFVr083BSg4U2sYlDIj?=
 =?us-ascii?Q?JPjYOsB8IW8sVDXVZ9+r/4DfGCBaoXAtn+QI6CThEnyZTV3YM0uJeGDIh8XF?=
 =?us-ascii?Q?MvVBuczxNTlcjag1Qq5RIlP/ds5Ltf12da9jNibLkcPm8Qo2qyVIy1bDGUnh?=
 =?us-ascii?Q?oZZtvNC4I7yGwkItf3p5hhwrMPsBDrGx0sIYKStpYvgHtaLDR7zuvaXanu8F?=
 =?us-ascii?Q?dNrlioEvkjUL64EkHf1blMjc2uf3LOQDMMszwEIaYGXpfL+h/XF9W6kBdSdT?=
 =?us-ascii?Q?HmWuEpT8lI3EjI6S/M8C4AJsb79Djc6r3iFg6r9zeVr4vR7lZ79nnvk8gYs4?=
 =?us-ascii?Q?33mVQmtC/4mwby1SsmV4k7qeP0vmeAnXoQe2CKvihXEYkAaYKLXuU52eEn1h?=
 =?us-ascii?Q?0oQ9yQBAhpQmLbl1UoQbW4FULwf2SftLvEz4nQOD7zT0go6bFiG3H7hWW0Dj?=
 =?us-ascii?Q?5c6I2LgZE98iG/1Sh+uCPPoDQ6VDWDdZp3KRLNHcQIrN97CCgDzBzwgFAehp?=
 =?us-ascii?Q?7sNP5Wu8wwzfSjeVkc2qrNCcNS3kEYf2BrBiFIGI7PEDbreTGTSwShCV2N4o?=
 =?us-ascii?Q?R86n1l2oUigCdNV3SlUnYuttDhkn7CN/sV9YnojutlX8gdwh7INtLsttojGP?=
 =?us-ascii?Q?e5w4om59Rydov/MmI3q2Pzg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfd1e6e-d54e-4cb6-9c44-08dc18d657d2
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 10:06:45.6946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhIgC3PhxmUQ2adKGaosrYLmy1dnTT2j2DKjBqYU2wilP3VV+aQUSK/TtJOtnxfMBOxyArMLjo1NW2OBmjaXEiP33AeO0m821iKcenO52qeM+lOFQ488B/uYLe9r7teX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0558

This series add camera subsystem node for StarFive JH7110 SoC. It based
on top of the master branch of media_stage repository.

Changhuang Liang (2):
  dt-bindings: media: starfive: Match driver and yaml property names
  riscv: dts: starfive: jh7110: Add camera subsystem nodes

 .../bindings/media/starfive,jh7110-camss.yaml |  31 ++----
 .../jh7110-starfive-visionfive-2.dtsi         | 103 ++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      |  60 ++++++++++
 3 files changed, 171 insertions(+), 23 deletions(-)

--
2.25.1

