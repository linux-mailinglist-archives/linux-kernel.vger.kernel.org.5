Return-Path: <linux-kernel+bounces-25780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BB082D5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE391C21432
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998CD526;
	Mon, 15 Jan 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="GIKRieCO"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6EC155;
	Mon, 15 Jan 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1wzehwIns/ivSsrpvzR6Fp0h7iTx7GMWk08KuemDoto5C34mdSgzUH/mb1o6hT/PQuVY9dpHFoXWPtFbYddPB3KsEwRhmlkVaodLksbcvGgWJpOKJQPXhWHEuuU8eRPGNgpIvPkW2tiVIM9The0ievNVsPCaOwYYO6+zy56ZfTtp/UlIvrOQmvBYCEHFiUlfG+uHQ8W9ibhxgmIY7/abi4oH8gNezY3MfsSbjWFVFOiPULIE83B2VHAt7xm6uN6tPUQ+S6kmw4svnnuu+V/A6urVflQwcA0sanb84mx6pMn3k8tw3yOTld9LTfzhZ9nriAEDSEE5YSOiogjg9D3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvUrqoy3wsg+8tUY3FLgYGgdf7zD4OHWKf0G02QwwpU=;
 b=AnPymIezsShTuyQh+sp+5n6CnU2vvKcD3aWrC65o4uGMGwIaN85M4KW/SG5HkAOrvC+RbTJ1K+clVB0zCQZQXNSzkV4pKX7jwJDNG2Y4XTxfURgN5ehQPNGlX5Y0yKyZbSP0IgOe+6KWruuB50MtXGT+55swLF/rhj8WcVj1qKrL6q1ikIrJ9nwmvNpiWbT6YK6I2rpuMYuW3SojNGaxK8uv+25TtwB+HBwRbgFMdc+CVA3O3YU/pN1Hm6PC4sQAE9ybrxtXy042FZ9ux+u+jiGEkTML6cxiq3XwuLZvmNnuR6ojVmPiWg0lhXg2s6msOl83Rz+Dy/S3rFi8DxrCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvUrqoy3wsg+8tUY3FLgYGgdf7zD4OHWKf0G02QwwpU=;
 b=GIKRieCO5GiA5EXTokfJMjRmlyRCkAnPiJDmIksvuHq8hxQg613QKkghOU7OSVfEzs0cONVMWDKUOKBRd7bN+cdAx06X0OPidM7JLjo0wus705Dljt7P4pnNL4SXrG0tUhdf62GNG89KDppXlIbHUVRbI2lDy6A2XtfugHC4ebM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6035.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 09:16:37 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 09:16:37 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/3] ALSA: usb: add support for XMOS XVF3500
Date: Mon, 15 Jan 2024 10:16:30 +0100
Message-Id: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO73pGUC/x3MQQqDMBBG4avIrA1koqXqVaQUjX90NiqTNgji3
 Q0uv8V7J0WoIFJXnKRIEmVbM7gsyC/DOsPIlE3OutoyswkYfn+FOVKoXtZ+J5UENb55u6ZqPfM
 IyvGuCHI84/5zXTe6McKlaAAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705310196; l=1753;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=JBsPjBCzo6FTPu3MSdjGFr7gnmUmal2Kzm1FTTD0/3I=;
 b=v2fITQom5/SBKklk6XddFlLyhzgF4K26WyKLNJF26q532RWi4c0wfsQUZcbeDQQdZ6/1WuACq
 /6fP6YvjiubB0LCuKwox4LIu0lZXqq/eVhRemFCRQ+JxdVpksr23vDA
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::18) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM9PR08MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: bf03a166-aa90-43d8-1e3b-08dc15aaad43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/v3m03x1VpdJ6jtcoSKMM7T3TdnU5/YmVRIR2+nyZiCtphswt3CJu7t90nkpaUxxOMTa0tpcdKU00ZZ3fNaJlIBaD8VV7sKJQq24wgtySOPMxaqUnO5/pojwhlXcrNDQgEp0cVKn2d3UAVwHMrU87AUzOPJFOrBxlW04wlAY1m68RlQcHf0zPrGO0KlJ+OU+kmWQPETULXr52vhwNV09Okpqm9wWl4TsLFgNnKZZJE3fjeytm+YisQmpRmhO+qmfHEdnLxexZ+EMzZWuvY3w3QbjdUhkolZ7qjjiOu+QR0XYUU+9jnheONojZmgT6g2UwFEUBBd1qxxQItiW2PXndVxEf5YyWxGx4+ISHHU79/4WLVvFf06atK/60CLS/0EjaSqKX2ih2+E4q9DW+6DPnPhJ6FSaPsd3gZeekSoVpOZuCTMSQ00We++dJxU+wv/5ludLIhGgE1LNz2ND8nmZIM6mk5aWKJW8Bv76otJzt6yLBVBP4/JEBriJpn6t+5nP+Q7yVNA1jNc0X/dacrBkLWaRnNNe6HHVmg6uvYEU2h1+6veBgvMr4jQIJerhtQOrLXMwlxfxeqMfM5wek7iAzEADns2c4DTFSEpG6diyIN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(38350700005)(36756003)(86362001)(66556008)(26005)(107886003)(2616005)(83380400001)(54906003)(66946007)(66476007)(316002)(110136005)(6512007)(6506007)(966005)(478600001)(8936002)(8676002)(6666004)(52116002)(6486002)(41300700001)(44832011)(2906002)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0x1SjZVN1hnNFBWVUhYQTR6cG85ZEtySTk4V2xmaktFRm9jdVVJSVpwWU9n?=
 =?utf-8?B?Z055YkhiTjZ6QzV6cVZ5bENQZ2ZvMGtPMWN2UzYxMVp4VEJYalEwYWFxVklU?=
 =?utf-8?B?R2Z6ZHBYSmR4a1loSlZJTnVXUVk1YVo4a3oxbjdJNDBodFhuUHFtc3UrTTFa?=
 =?utf-8?B?c2hFM2M0UFZhV2wrN3YyRVF6cUlpSXozQTdJTE1GTC9XOXFLMnhublM3d09K?=
 =?utf-8?B?M0JENGUrcWpVVmlzNGZlUGdZMjlPSXdXTEVvMDU0Sm54MWpOZGx2cThXNHJQ?=
 =?utf-8?B?Znl4TFhaUUJFWXhUSmU0QmpVSFdTOHVpZkpJMzlEWTRmK2l2WkpPbzJLNW9x?=
 =?utf-8?B?TEY0bUtLa0Fla0ZYVlZwV2lJUC8xMWw4VlNLc3RlVEhpZy95ME5TUWJWZzY1?=
 =?utf-8?B?R012TWQyMEFNQ3hYR3BQV0w3RzNRclppSlZRZDFwcUhSRkhzU2JPQU95aU4x?=
 =?utf-8?B?ZXBadGkxUlZhRlgrbmUxU3BlOHRremJMQnluQUJZMG5PM1dPWmZ4MU9XMlpo?=
 =?utf-8?B?TXMrMVpzTElUWHUzM1NnQVY3amRzQXVGYnY4TStFcTBnSTlNcHIyK3RxaW5N?=
 =?utf-8?B?NUhvUy9hUTBUZXBYK2Nvd3UwdEtpbXNGVk11aHlUYlIxMzRyaDMxbDhHY3dE?=
 =?utf-8?B?TytOZU1STXVpZGN0UXM4RGFBaWpEQ2xyUDBKYXRXZDEzN2V0Rmd0Wk5CV2FL?=
 =?utf-8?B?ZCtpampRNnNoK3lOZ2NqUGNVL2lpeHl1SGZhcmQxWVJWQ3FIQUtpNEFnaHA5?=
 =?utf-8?B?ZllLTTV6ZWxOWDRZbyt0MHB3d0F5TExsVmM4WkJUdEhVNjZKbUdrQ0JLNkNW?=
 =?utf-8?B?MldPaFlCaDFNUjk5R05zTGE2WWdTQzNHMmlFR29KeG9iNzM5dmt5T2xTUUpF?=
 =?utf-8?B?MGRMMUZqaVlMOUMxMVE1WnZRTjIxOHlJb0JxZTdhcFlJT3FzVTJZZXFTQXN4?=
 =?utf-8?B?eFlXKy9SUE9PZ0RuRHFiaE9sU1F2TTNrVXEvRTY2L3djclIvemZqWlAzWk9D?=
 =?utf-8?B?TDZBSUhJVGdzUENVelBIc0ZuSGsxVkVFYTF2ckFZVXduTzNQeFhhaXc2UEUw?=
 =?utf-8?B?dWsrME14SjdKc3p4VTFXUmZybFZpRFZEZ2R0U2xYS1dGdjA4NWlvN3pXa3NQ?=
 =?utf-8?B?SFJ2eVF6dkFHNnBhNGpYZkNNK0ZqZnh5SDVlNzRML1dZeVhkS3hGK2U5S0Jl?=
 =?utf-8?B?eFN2RDhVVitsMUJuU1JncHNYeHNiNnR6MGdyelY5QlFTU3RSOHQrWmw1VlVk?=
 =?utf-8?B?RXIxeE54a1VGL2c5cGFsV0xJNTFiWlY3MCtFM200aTlRODl1VWpkeUwwR3hm?=
 =?utf-8?B?blp1TjF5Mkp3ZWZQckRDdHN4UFlqRkRBSFJIejUxSGhuU1ZtTGJ5M1VNd0FG?=
 =?utf-8?B?V1ZuUWt4Y2VRZUU5VnlxYkJELzI0Yy80Uytwd3RCU2pITWJFMHdaOGwwNnZv?=
 =?utf-8?B?enFwSE00cE9NdDJZVVFqdVNLQkNWNU90eGRRVEc0NXViUktJZmRCUWI4MEdN?=
 =?utf-8?B?NHdUTU5xZDFHRXhsQlQ5RVByR0VscENkbW8yR1VXQ3MvUGhSVmNQbnJoRnE4?=
 =?utf-8?B?UlUrR2FmMkttZ2lMZXRrc0wrV1VkRTM4WHdteFVpN1IzeHJSaE45MzZXblZk?=
 =?utf-8?B?cnFFeElnZVd4Q0FIcEdqcGU4enluZnh0aWpwRS82by8rTjlaSkZqK3d1RURC?=
 =?utf-8?B?S3B5UU5qdmtiVkJESVhzbXc1MGFBYXptUHNweDJLT0p1R2lnYzdlVmwrV21K?=
 =?utf-8?B?OHFGMHMyMkN5R00rendYNDErT25ra01SbUh6Z3o4RlgvUmZJMGV5MlBySDJh?=
 =?utf-8?B?bHVmQVQ5aHU3ZElQYWc4Q0JldHNaZk9ud0dtU0xOWVBiKzFMQ0FFeDI4LzNl?=
 =?utf-8?B?bUI0MFhoV2l4OXdMMGNkWitVOCtEaFVubGFOTis1S1E4R1ZxbkNqcHo4QlRU?=
 =?utf-8?B?aG5JWXF2cHFGYlFKazJDNzlzeXJ1WkhqbFYxV1NhL05rOVc0WHY5NUNKb2Jv?=
 =?utf-8?B?OERwZHdIWTdkeGIveHc5VXVkZytPYW56aFovTXRZTE1uNWtuV1hTUzRVVStD?=
 =?utf-8?B?NlhRMmNUb01mSzd1K3Nmb2FKbWJnRTZlUW5VS012TDdHWmt5MDZiVjFxNm5w?=
 =?utf-8?B?S0hsVVM1dXVveHV6UEZlTHRCRlZtUUEwall2NzlOeHppU3kwcmFzdVF6ZjlQ?=
 =?utf-8?Q?8sAGYSzUFaFIynrZ4FhTf1c=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bf03a166-aa90-43d8-1e3b-08dc15aaad43
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:16:37.6429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SggZ/uNC1I77FEpztm68hTfc7Ze1jk+DlamY5XGe9c2YA3uYi2Pn0Z2erP18nMlBZ/vdVyC3HYy2TZlEmod/oMaudQ7Ik7Wo5ipbzJRil4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6035

The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
multicore controller for voice processing.

This device requires two power supplies and a specific power sequence to
reach normal operation, where it registers itself as a USB device. These
constraints cannot be cleanly solved without the use of a driver that
guarantees proper initialization during system power-up sequences and
sleep-mode transitions.

Once in normal operation, the device works like a regular USB device
with the obvious limitation that it cannot be unplugged because of its
onboard nature.

This series adds support for the XMOS XVF3500 and includes the device
bindings, which also required a new entry in vendor-prefixes for the
XMOS manufacturer.

[1] https://www.xmos.com/xvf3500/

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (3):
      dt-bindings: vendor-prefixes: add XMOS
      ASoC: dt-bindings: xmos,xvf3500: add bindings for XMOS XVF3500
      ALSA: usb: add support for XMOS XVF3500

 .../devicetree/bindings/sound/xmos,xvf3500.yaml    |  51 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 ++
 sound/usb/Kconfig                                  |   9 ++
 sound/usb/Makefile                                 |   3 +-
 sound/usb/xvf3500/Makefile                         |   4 +
 sound/usb/xvf3500/xvf3500.c                        | 140 +++++++++++++++++++++
 7 files changed, 215 insertions(+), 1 deletion(-)
---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240111-feature-xvf3500_driver-c872839c11be

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


