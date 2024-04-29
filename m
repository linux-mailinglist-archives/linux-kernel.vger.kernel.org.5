Return-Path: <linux-kernel+bounces-161788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4A8B514A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A33C1F2215A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FA610A28;
	Mon, 29 Apr 2024 06:22:41 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2112.outbound.protection.partner.outlook.cn [139.219.146.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD0D53C;
	Mon, 29 Apr 2024 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371760; cv=fail; b=VOKBYUV0jNuJ5Wphrq/BoMtTccZcqVn4G4cM6O3JfF0kmbJWf0upE4mG023Z9XazFyxCH6o1tqmbLAQfGlXo9xU4Y8v2Ro4dysGbFngY6wyQUDdSUwWnjXfiAcIs66UC5XtcISZYvnB/GRPpZE3wDwOLZDndb0J39cG4Jq1IIcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371760; c=relaxed/simple;
	bh=aGgeXITSF7fT5WEyez+BL6jbet8bjpeMXN/UNoCn5/o=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XI8h4aUYQLnzpX46NtOTSqkOuZxQV8RxUhA3j/4cHKdl235ghUtT7y+GZYzSOOzdscPAfVRgXGzlcFIkgcqU8H1TkyjS8GwkYg+2pFJCvrB4akJwJ8TSjdUnu9DjBe61IYMjTfPHPc0ULcpN9X/eOy2dSkpqVqSmNvJAO1vmWXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Vm0Gd4DlZb5LwHRqzWT8sl/Z3YvHKh3HNNQJkdmLz46Gg2OwwPDY0wGIESbX+D++SurOPOR+8IsVWP2JppX6TocUbguecmNYbSgMMQ8JVgYGKDHCk6BcuAMC5D1FqxQ0DEm4TmVhwfp8nxO9LyGF78xAEuOFn0gA7S9AlbXfrBwWSMawqSgmSxbPAGdaGuVW7mxzS0Lt/sCtXKfRzEsjwfpRBmUNB2s2bgVHRVsh/+kgerXsDCM+kOeLQAYbwGH58F/l1mWruorOuHEUgxnaNS6BQwThTjnWZsq112tqvfEkr2cbh2IZRxdcHzu7UrsmCOtupmx/epS7TVnLpIRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z02FCXp8/LNJAmf/mUoUsFL9rVtPgyhNGXzOg7Zh7fY=;
 b=VTJKuZDrLPDruSVxlfvnLImMfYiPwez/qhsev0SdOh369anWqDwKf/J9atE255Lto7bwMwa92XHkON/pO1ScIW+f06xUPjtHOvD8fzHPX4n7dt3aD0g7eUhthDBg2nPePGQX3IUXnTALgEbZx1ihm+3amDUCUqRAneI4oxRPpdcBUZ+kFhrL7YwfNfGnmJS3pPOV0saLZgCwKi50VzJjYzwbx9Li5k1L8Y7U5lClHmpWePo0deY31Nf6rEmjcfu9bwTvgIYaKvgtave4Ujr7yyzT6GgEcuiU/QnTPv1YO9MbrlbZ7bjemsKRp3rMuHlZ27Qr1iY8a3OeA0MXOylchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 29 Apr
 2024 06:07:54 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::3dc9:e0c9:9a09:3bb7]) by
 NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn ([fe80::3dc9:e0c9:9a09:3bb7%4])
 with mapi id 15.20.7472.044; Mon, 29 Apr 2024 06:07:54 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -next 0/4] crypto: starfive - Minor fixes for AES and RSA
Date: Mon, 29 Apr 2024 14:06:36 +0800
Message-Id: <20240429060640.2451685-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::12) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1278:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c00973-de8c-4f40-f45f-08dc6812b57d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ADWj31n9+Z/bq2VPZiOQ+pKqyV9vy+WTNyBjGaQQ4FgKidtS51OEQvziLipuChQhoHGxlluCLScEX0EkCeuMoHOALoDCZ3Ut6ghR4n1KKzWmW9SLvgoFifiHGuZmFJgdWJz8zoyNVernOG3vR7mEokwcVq5plW4G9b/AbOF5eQSHu+WL+EPYbFkk138rTl0KYuE8vvzfoxy2rzDSCTj5fg/fM84CU3qf8mehS7KViJZQieKGj8M2e/qCu5/FQ83Ql64RsKmb/DokPVYQhucyYkp0jn0PAeJDvrR6Tx40ECS6UYm4LfWb/O+MMzEahuLDutHywXTaa6kPNmkKqXvu9C7aVY2CiFcEOm1z30Myq7rFHeb9vRqM2DuHVOgsJHZjMF1TZaMZLGOcuQ5uCSL8sA/2mNd7XFDQiGd+L6tZggFCpM+VnT/8HxUEmN5ejaNB+RwU95lRA+y7skKdKzhzvAolBPr6IfPDshwMhp/Fz5W//2iWh+aVAu9MNg7S6nLQ1JKfQMSnpyFKwSDVXkY95ucNSmj00tImITZDWE8Va8Fylgq//ITbjI2MkYZoiJ2ahJaCv4CxRrwe8SAFHVDZ7TjkhpPbxtFKy2Mm9P+7nfJYJZxx5vjozoXiMqTpDHL4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJCUtVqbrWmhR/MY9rXulSfzmMlC6i2YvI3vWdAIwuOT25DTEU6FAuTD73h1?=
 =?us-ascii?Q?d0Ihh6+LSMkerv8fkfHw0SedV+5P3r6CH2k1QoLXx1aNeBOwXt2tpmGnetEK?=
 =?us-ascii?Q?hLtZfmYYCIwGkxyEbmB7RAe/3Sb0EsIjncEO8XRPV8qrXpqAMj+t3be/uSTQ?=
 =?us-ascii?Q?RiU0SedEF7RHUnbDTDgHYPuZhlEWfCir0u8r8IOTI5ZKdzC9MQQ5ZlvO0pYA?=
 =?us-ascii?Q?m3Abt1ywDzuebm4zalI3FvZkNf7Di3B6zanwoAql3LaZPp61fzhUh0LXxORv?=
 =?us-ascii?Q?ILUdqmjgJk/u9VU45N/CDAly+3UCjDVchnzv/WKR6hYSAa4jHQ7bvhz+Vedx?=
 =?us-ascii?Q?IKGgh+pc5SbSdRJ3UOjrzieJdOmSB1uOkMSMKwDWJo32RARccI5PdI7sBKQy?=
 =?us-ascii?Q?IpaYtgi8BM17ZPerbNLKg/ZhTFHG3I0C0kKDUkemCDIoBNvDVJbAFG51CIBg?=
 =?us-ascii?Q?fmDgHlM9/AeR663/3AnXrTBu+fdtOqoba5N0hAuqSxoStmsXeNAi4v8AIqiw?=
 =?us-ascii?Q?1Yvaxd6nR2aFdDnUNh4Xf/ar7bY5J6ruFuEmmkKCbr//OAm++jVqPpc/JUh7?=
 =?us-ascii?Q?c58Z0ttzQKnHhtry2YDpRhnnN7FO8MwDuskkwWruqj2I5Y+NEVxFoT58RlkG?=
 =?us-ascii?Q?oUOliLn0khqHdvtCVT1pnhGx9LkzFrL2KTKZSAwzqgf9OeLb6yuGARdZ9cWj?=
 =?us-ascii?Q?LPaAtb3448Eoi2ju0G0c8IYWCzS7r5r9yS3BOO1xw9kvTlndSP0jcLEiv/zz?=
 =?us-ascii?Q?fZwV4Tt3Uu4IAqytG/yx4jz6AIpxJ3CI1Q8j6ugV7xrYFRl7jiXPs9PEgxkK?=
 =?us-ascii?Q?k5WQEvEltPm5ej2ab8A2YsvmmZH2d9yU8+t5pKEBW4dL+oLB8lU6xIjetOWw?=
 =?us-ascii?Q?tSEv23XOYYnpDb9M1RGoW9jVesUl/QFUnPtoUtCSiIGyToE/B0FWoCIMk9eY?=
 =?us-ascii?Q?AcEm2Z1FHlBlgqLb/kjbfgdNEbEWZpWLEBTfeaOPrM1sEJNegmppUQKqqAry?=
 =?us-ascii?Q?eGSsmoORvurEgV6co0wR5Ac0TW0DX4D0HxDhy2wC+omK1fWIMGP8SorVSSFs?=
 =?us-ascii?Q?NlxlnTluBeFj3qD+BTv6gtzGNOLXhG48FoP0lfYzmAW1ZtBBVqbw+poNssm0?=
 =?us-ascii?Q?AxUFXZ22P32Xt2a9odKimiE2kC9RGCdWrhsy936jFlLmkRw55Yv9O2dknLux?=
 =?us-ascii?Q?zG8UhKySD8pRk8T+uZj0pcBh02GJ1Mmop0RW9H1RXagZHIKelUzGCTOYtiKH?=
 =?us-ascii?Q?ExlzW+nNWuB0WW5gMONPn66a/C0cjKvvRf1OAVH61m5T3/CffZqd9hsVI94T?=
 =?us-ascii?Q?tafd7C6CLSQvgj6a+mgS9q3bCkSyD26QXnY5TjDjzOy6K+A+lgEz1DBsKnUz?=
 =?us-ascii?Q?S/qiqiV2+MnNO9pQtOQ5k55rhKPJTOaE93yYS7KHF4rLKqqGXZszAiFLjvNT?=
 =?us-ascii?Q?BdSfnCBD4nT4V1/Fa6NgCLIVvHdhVlAEikPv/PRd9KlUfa0j1+l8kYGNyHtn?=
 =?us-ascii?Q?emVVSXcrXBRG2IVNLDRVO5Qvc9eZY4b+k2knVd5o/nat3PeXgsKsLHdKABDC?=
 =?us-ascii?Q?WZwqR0leO9LelyIPgVdRYfuLxjIuu6KhsBnvJoEgaUBNV825vk1yWYwFCxr9?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c00973-de8c-4f40-f45f-08dc6812b57d
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:07:54.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX2kB7L3uufcq1r5H/muhTkW8IC/D1lLLZXKFNQ3tTNyZ9AtoBtsI+13PeooY8Ygw+e7TJfL+2AMRx0VPMkPoKL+6uU1qQ+jxHsNVfZV+d8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1278

This patch series fix a bug caused by freeing a stack buffer in RSA
module and skip some unneeded steps in StarFive crypto driver.

Jia Jie Ho (4):
  crypto: starfive - Skip dma setup for zeroed message
  crypto: starfive: Skip unneeded fallback allocation
  crypto: starfive: Do not free stack buffer
  crypto: starfive: Use fallback for unaligned dma access

 drivers/crypto/starfive/jh7110-aes.c | 16 +++++++++++-----
 drivers/crypto/starfive/jh7110-rsa.c | 11 ++++-------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.40.1


