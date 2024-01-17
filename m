Return-Path: <linux-kernel+bounces-28649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A92830153
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3794228857E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3111C86;
	Wed, 17 Jan 2024 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="fD1xx5qn"
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E1D10A0F;
	Wed, 17 Jan 2024 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.190
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705480447; cv=fail; b=GTD7g0fcZAPltVWxtg0PvmSkdsrC1QR4efIxc1fZkGL+pCUDtVGlYZzRcD56OhmSSTDpL7VuCWx7YQBGqnPaIS7A6gWd6pdvrouqU/LBQpE2Es9K5zpbckq4ASeqlUPuwL6GNDmCg5OxUYpN7KSoUcnWjsJ2Jrqm8hLWxn+4U+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705480447; c=relaxed/simple;
	bh=9QApnDJXZhmt4nq8++Qxgun9gshjmSLjbhmt+lmsMos=;
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
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status; b=itPw2L4tKI2UBx6viJQonz0kFfpkg7tMyLpCwdLsqoBbWTduLRIJ15b4mD/Gi1b1z9rZ7N9JK2ywJPBIM6UOXd5DaZsBjniXXIGBcbaUT6WEU/DKJ78oZ2BUY+j+8fLVkwfgzKynbE5R9vodB9u3EG00TaaFAQ6XilO/a8m9bZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=fD1xx5qn; arc=fail smtp.client-ip=209.222.82.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound22-17.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 17 Jan 2024 08:33:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpDnSpgL8VLhArZvpiNoU2ahVl1yFN8uUdstGldzCSW9M/xRgOBRdW9i2GF+Ujzv0puPLHOWQLsLMwFE3xArVWmkAfpo2zz5gyheydSE94RD46K2RUfk3p1Ax59fLQUz8g9KyS/j3ZN2AggltXlBOxATCt16tOzZ6+njMU5LJgO59CDTgFtZl7mZW5AYoUvOd2q6s40jr0vX6UsEUGMdHZpWuCBMuPjr9R7gmoi4f/T8onlmxHyDzi+YpUECGJUscxxD2PvrDKrSI8bHGiM1aK6Ugob28T5EJy/x5rdAqYn6RHgH14UgOb6+JBW8Idc+PW4yb38uq+cJJbnvx4fPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1R9w9HHFfhvJuzvgknih7CZ4GiqWRrXxLxPhH5JyqM=;
 b=BLUCWrw1TrLq4BJAnnCPR31tp2FzSFZLPmQjLM/oDySmEmiaHXE6XoFft3uhQ6HVSxahYhlziFGYVzPi7xuzjuDQ3CPZyl/Som23LUePjUN3OHkTrpRf8yfo4rLWb+LTS6U03hTmDsgJcIS9NuRN+E+7wX6Dmr90MPQvcb4/SSOMun7xYVSu3cBpXD49MmgZOXg5NeMzvqrbybvTboUsq3XE3QTyZlzGHL680J0yNF1iN5FCzxubmB64oZfEUZwEPagzOV9SJoSSzNiRcKU5OM7cez03UyVGfI6A2rErQBfQT3/CbEXoAk16ACH00sJCjtfEj4Y0d+1qjp8KhVcPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1R9w9HHFfhvJuzvgknih7CZ4GiqWRrXxLxPhH5JyqM=;
 b=fD1xx5qnnxGmOBntFreYAuIqjFgeIhtSx++UrZ5Xg1I9RCWw5SBiL+X9bgvUMIwdd9Dap99qEiTD0L38ItzZYHS/LlA8rAMdq/zIhj5vcYe4cXDlqVJRB1I6PEaIhS5hhylofFhePhzlChdOH7SRb4wK8FaEKMyhq6Ic03bfq57ed8y/pmKzhxG3k9MOm5ejMoBVcdGTMSCVxAMCQqQDqf53olnpxw/shoc8KkMbqDqfZ3gik+HsWrO6VJ8L/l3QMQesXm3LBUeOapJxFirxzyXSVCueyKhcDHOh8V7a3Lagu2v9GBumorn3iECK2pE2Rm4OkGr4iUMY6QAbsV9+sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Wed, 17 Jan
 2024 08:33:34 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 08:33:34 +0000
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
Subject: [PATCH v3 0/3] gpio: support i.MX93 truly available GPIO pins
Date: Wed, 17 Jan 2024 09:32:48 +0100
Message-Id: <20240117083251.53868-1-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 1ac927c8-fce9-43c8-ed0f-08dc1736fe2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mjg2DOsVl26bFI2GPy/OFg4OcQL6/0qAtgMqNUd0lrBNMjVptJPCfgjrg/wNHsh6uC3OSaaw6vbGLSHo6iFMSHnqCUjmdh1H5qtDYEK76+5+C8AjPAj1cz6LFd8YlpuSFlDDcHSG7s3alQXoROOxDk19Ek75ZTzFeTRSom3oPQsFrJv1j54UQzbEv2l7+BXf0BMA+g+IMJ7+vDsOcXSHvFAH1h49cwZMlaKbj6HSepfvZUFNOVIhI6gTHLe1uV0VMh+j44nJrvr8emswiT2LJaa2RoFmSqLvXSheFUDncCpa1/FKh7cL6GFPNfKZY5gasLnA0ncdiDvUk5KbCH86ghQo6tX6YDyJTV+VcZQBHU1ngEIJg6RPcTOLbiolbIjnS6TTgJEjUSyEgSloWikQXaPzViHhvkCIAs/AH93fUoSkfgXLP5khhtnilQsFlhVazkx9hkojzCWrRjSbV7AL4xmwRi/KApmYd8qRyfPTk0naoELQbxiCrModuLath+jR0uFIfC8pGFV962SUB9oZbGXYgqWgATcoy2+5UptdzBzUkGVpc6CPXigJ2kzrgQ30OIUdQJ/SMV+nBI1adDF1s10M6Mw1Q5ODBRod3MWZEtX/DB8FOeMbiAC6Ou4I2hD6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38350700005)(4326008)(66556008)(66946007)(66476007)(5660300002)(7416002)(316002)(86362001)(8936002)(44832011)(8676002)(107886003)(6486002)(36756003)(2906002)(41300700001)(6512007)(38100700002)(4744005)(83380400001)(2616005)(52116002)(26005)(6666004)(478600001)(6506007)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzZS+VhamzGiQaRXdnCZEWSkUfVZOWFUX/t85vY7VtI6GYB7dZ3qSc2T1Cgu?=
 =?us-ascii?Q?BJjhO295uk7UCABB6tbkrIlw0M0L8bG2XVB/9/y1H8k8BMccQpMCLAwnohqq?=
 =?us-ascii?Q?+pH/PK9Ma1aKsnH04KPMHA5lsrTNVpIhFoexZgk5Th/xPOn1wZrP5wOTkfyk?=
 =?us-ascii?Q?fd2IgRIPQkMybXKqMG8WBOt7Vjmxt72n/1nxF0iTPPBJA0CtUVzXqtAK1EA8?=
 =?us-ascii?Q?y+V75YgKAKhY54W/g3Y5BtnA+XWZbbInvbftLQ2fugh2/L2O9fyyfWs8x2HU?=
 =?us-ascii?Q?q1yXM7qayZ/89X3exWpPlW0HjVlTPJluZIhoiclc+r/UHkOnmPAxCSFhl6Rv?=
 =?us-ascii?Q?+Vs6dwWWl4cftVN+zTfQKJJrRgHaGTD4YUrAtqqHJnEn7FCKG7r+03LVsjxQ?=
 =?us-ascii?Q?+nX47/09QnFtWhpXUCK/oIeaVffQ7OSIYVTQJzwxG1VUXou9g9kHSJjlzaAb?=
 =?us-ascii?Q?OaN27aWaPOw51J6HKG5ee4OqhD8tWZPCum3HNwcEodzud3XVjlUl7Mou9Yvn?=
 =?us-ascii?Q?fP0RmTAxdLnMfDAGFYI/aiCBZTBhHIkdGZC1ybjAIunCZSwBe/4Z9+rPYYch?=
 =?us-ascii?Q?PWyVFVqMHsXPzgFA8s7uy/ZqnHpzwbnCppm/m/qUIvScNNvUqhQRvI1B1ARJ?=
 =?us-ascii?Q?te6JblLsbBQPyKhfa3X3cYQieK4bD0IYHBMfCf+QydB7t8hhnUHPkvl2QMI4?=
 =?us-ascii?Q?PmF91hFS/YIghDSCksJCC9Z64/Ab7VHqfIMzqM5vaS+suDyyzZh7Kx74dy9l?=
 =?us-ascii?Q?YtRzzARS+RIL7JYJnBIY6V/2+8OEp5M7L+avxLcnFljZ1kchlN7MyJGaACMA?=
 =?us-ascii?Q?wQ8DuXx6rfqoQLkLnUxqQm1nIzIA/iAcQWTRUs8N3UeL3oGaG8PpL6su/4sx?=
 =?us-ascii?Q?Znr0wtrcAT8LmGlJUKggy0ebNytaEgTQODFaWF/MV7gPZqPoyZ5BbOg7XhcU?=
 =?us-ascii?Q?0fWDMUq2IJEZM9YTgA9wTeezBEZjRPRne0BQAkLcBSHvE0WhsnAvi7Xpmyrh?=
 =?us-ascii?Q?kJkkMlF9bZ3Z8iEsPqLaXr++gDzkoXoT4/7ThU5nymZ7AqDx+6yQJQefzbw/?=
 =?us-ascii?Q?1obqgZ5XhtIiP8rvP2CwJDJCNx//Vn+2kR9eZumu3arY7MXUycMDBJZ6vc/o?=
 =?us-ascii?Q?wwPCBNUaJo/lDwEHBoOAHEelCd/sZll7PT0vHul6kTynY9bE5rVyNEMC5wfa?=
 =?us-ascii?Q?8UeOrhzP64L0GhRkmQgyLycbTOhroQ/snYj2zMdyNV3QHs2HYLrHe3CpltkY?=
 =?us-ascii?Q?rx7bvtZwO5NumDpIaUB3+FrtvtzV0wmIopXWH6vHBhY6K4A2kEFOmlFnLgGL?=
 =?us-ascii?Q?7yHzUPc3D4gOp787XB8x2VD65X6Dee1zi4OPjZSkhKjTrQdSh7E/nksjvWNI?=
 =?us-ascii?Q?koHZ18a58I7cQ/0ICQ5lWrQI1V/TTgc0+bA0p+Pf+21c6HX7/e0BT+MJ7ZaD?=
 =?us-ascii?Q?cB2T0njX48vhrGFnIq8WWaChiaOF/Z5bys+O1LXGtUvAYOYBVxWiM3QbWkaz?=
 =?us-ascii?Q?/u6oKumGFqHwuLZ0e+jqgDtqrPUOV8P2D6o2Upqe1E1cvok3i2ykVoh4RNR6?=
 =?us-ascii?Q?bF9ioZL7SMYCm33ElerHgnXwziJrHj3+HnYT8WTt?=
X-OriginatorOrg: digi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac927c8-fce9-43c8-ed0f-08dc1736fe2e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 08:33:34.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz9EwM/rrUN8tRxSnRnaOasyruqlAVzXCgscALl4gvfxOxaZ40SURl+IuyVK/rb1xs2DdDHuhFW1k2w2t2yfoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-BESS-ID: 1705480417-105649-8511-126604-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVhYGZkBGBlDMxDDFOMXc0MjQND
	HZMMXUzCzJMiXFwMLQ0NjYMjklMVmpNhYA2mZ9dUAAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253575 [from 
	cloudscan16-95.us-east-2b.ess.aws.cudaops.com]
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

v3
* Move DT bindings to a patch of its own
* Improve reasoning for adding support in driver

v2
* Add 'ngpios' property to DT binding for proper validation

Hector Palacios (3):
      gpio: vf610: add support to DT 'ngpios' property
      dt-bindings: gpio: vf610: add optional 'ngpios'
      arm64: dts: imx93: specify available 'ngpios' per GPIO port

 Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 6 ++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi               | 4 ++++
 drivers/gpio/gpio-vf610.c                              | 7 ++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)


