Return-Path: <linux-kernel+bounces-25779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3682D5AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D351B211D1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DDC2CE;
	Mon, 15 Jan 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Gm25FIIY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D8E541;
	Mon, 15 Jan 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJiWOyswmoGHOtqeloF54EEz4gtFlRMVosSyuC6ArdvBpLaJ0CqZFiVm+pmXKxSlcIPCmE4AAPsf3D1f3QfpQvBqv/0dFfDbhhZSUjyQVLK5FKGMI+4lju8bissFUqIZC/keiUmST3J4tJViqff/MLqGy5zcr/rQnPjSnBXrJ19s3Sf69aWkbd1ani5kjzCLo08vrFFB9+GWpqqeDLqqlXRYcC8URyo1ehZfKhlNW8i44xfC2CP/NHkmPM5ipW2mYQB3Bwuw7yLsVODfj6rZP2NQ9UZ1wOH7olGPFhHQ2hQ6F7CLxHVfVw1SsNDqHhBT3hEoADQ7x9cLV7mKSWb6jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i98cjGXxyhurSwFE1PBqy8pId/6WHyrCJ/M6Q8HkBgw=;
 b=hcumoVQ/yj4pCVBdDjhRhMMpCd1IZEn9GFJQ72VHQKojoCslNYIL9oeAnapebRgfTvjtAPnHrZKggPe0hBZV3b2RzJehTpNY7BJ8WeIgRWl9RV8Ez7C3ccV+UU78PPJZK+X5k7ekWm+ZPuVpS5ti2x+hTa1Idmb1D7JzK/LATXZZ5o20CdLfm2UvH2Z+d5RjTLbmrOyPvGSHHwDO4p8uZwIDK16GlbNK2q0A6qxF6FAojWZAkQxLRcj3HF2UIntjP3wkcB58tIao62ZqsV/LAI74QMXKGoJEjGoalELn4jrXIKn25euG0QmpKCab2qwYfeCN8WA+AB4S8lcLb1mLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i98cjGXxyhurSwFE1PBqy8pId/6WHyrCJ/M6Q8HkBgw=;
 b=Gm25FIIYEWTCwTJ/lr8Pk59CtbJXH02K2XCpCxmG9IciwhrWeCRDi8BwRPhs7qJA6GCTwhNvGP5eMm0GA792xkHZh2NMdUp0GVuDHISMiWj2bXrMIqHR8Hln1KI8MFnuRzH2297iyhiDTzj8RxTXOaxhUyRL2P4/TuzDskXC6Qw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM9PR08MB6035.eurprd08.prod.outlook.com (2603:10a6:20b:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 09:16:38 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 09:16:38 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 15 Jan 2024 10:16:31 +0100
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add XMOS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240115-feature-xvf3500_driver-v1-1-ed9cfb48bb85@wolfvision.net>
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
In-Reply-To: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.13-dev-4e032
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705310196; l=819;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=CCIgf7YGs9Hit7BoH96SfU/ZX5S7xYmcc7+JCYHNGx4=;
 b=H3QDib+CJyo0ZXHHHNrHm/z2uuwcPL9IJuH22eruSgzxTYT958oxrgqdXN+HvVhl/nmV4fpTt
 BbbEFbtlkCfCJxXNp+H4mY4Pa5up3bVO9vEdH6CFmSYmVQS9OfKZA+y
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
X-MS-Office365-Filtering-Correlation-Id: 9e73e721-362f-4d6e-f11d-08dc15aaadb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwC252XUnPStCo7dKvopnhMiKzWIQVmIDcdlY+ww7by8Nx24hGgHhgFJxNpTTKwJAxJhxZ6GXay4DtvvMfk2kDgSYtg6MtUeaSHnMUaaqINq7FfBZTQaWs+H/L0btzUCibX0nZaKqVl85p2ufidsBCW2fzaq9yHV0H9wlhg6Tx0Mp2GYKNBsv4pfoZ1YEnZQ7J1qNHe3OiUssoVUHfuvnRzqnMC3rnQ0WFfXEP6D3ER+DgyqiHZR8/+5ZRCGkU+7FTeu9zwsnmfbWw2ip1YNA9PMn8ib09WPwxDSd5hHivQOgv15sryYvhzJGsivSUr1bqIDD3jgAhj7QtrAgnQmCaQtiCmBgSFC/FqboSYuDuIHuPQ7gG7s0Vtaq+4nDDKi6f/IsoWe1jkPCK4F8LhpwLQvBnsh//AgcyDUYRWx8nbHsWfXBVVqcGKKtUeEMFkkt+hnXMdVytU4ZTTRl2PSJXqM2GaazcxuGoAlHkxQWoiZMW3JqFHOtX9PnX3yDSUliFT1gxxVMiQf7iV4jpr1JS7PlWpth/b/iEinep/orwuvYdgdHAnhMclgFJKz/pEbzMLPwp1lgJeEMYvjMf19PIaikxomLXWNC9dbruRvpnd8wbbN5kUQA9VeOQO+PVBa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(38350700005)(36756003)(86362001)(66556008)(26005)(107886003)(2616005)(83380400001)(54906003)(66946007)(66476007)(316002)(110136005)(6512007)(6506007)(478600001)(8936002)(8676002)(6666004)(52116002)(6486002)(41300700001)(44832011)(2906002)(4326008)(5660300002)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MEFpUzFDZ3l3b2VoZDQ2Z3NITVM2OEpSSmdEUUlhdUg5bStEU3VHWitFaHQ5?=
 =?utf-8?B?cHU2OUZUUHlhdTVHMWUwSE5Ed1RIVE1JdnhRWWs3aVZENGlTcGNORUduUGZ5?=
 =?utf-8?B?cDRxVld6VFN1cnlHbWFoa0VuTnFQOGVyd0lXZUp0cFhqeUhOL3BrMmMvZHhk?=
 =?utf-8?B?azVXTDEyaXpGdFlxRmRuTUlmMTJLekxZK0dITjhucHRpb3h1OEhacWVpTG5T?=
 =?utf-8?B?RXVUaUpZc1VZS1BYOC9GQW0wOUpQVUhWa0V6eDN1Z2hzTVFnenBEaUhqZHgv?=
 =?utf-8?B?ZUtXREJYU0pTZVAwV3QxWjcwYXVLRk5oVUlmdlZMZktOdGpDZG1VUDFqU2ta?=
 =?utf-8?B?TDJUcFMyc0plZlpWL01QaW1pbys3bTAzTWl0aFRKbmJ3amdsMlJKMjVxL1VX?=
 =?utf-8?B?dWFSTW9RUnIybmp3R09jM01SSllLMXhXNEs4UCsza2xOclZZekNGajVhWWdx?=
 =?utf-8?B?Q2pYa1RBRmY5VmlQVWR4d2xuZ3RqcFZ4WGpabFhudHVuVitMaGtTeDhuaVJ3?=
 =?utf-8?B?NlVCS0ZWeFM1eStZcHZwdnZsbFJDa3NsanB6QmoxVStUZDl6RFJvTmpzaWdi?=
 =?utf-8?B?MisyTEsvSGlmWnpydURmWHFxZXlFQ3ljOXdReDU4NisyMEszYXp0Q3MybjZp?=
 =?utf-8?B?NWNsNHFWc25lRWpqRUZSQnp1SmR0Y0RteGV1cENtdnpKbFVOWHNzaGlzYmtQ?=
 =?utf-8?B?MDV1T2FiYXB0U3hYMkUvb1lkQ1JTTE5MSGFmcXJPUlhJMnE2US9lNnN1K0ZM?=
 =?utf-8?B?SjVUeXpsWG1Ed2lsM1hnWW0vSDZNcjNSUnBJZWIyUmpTL3hsU3kyK2ZCajhj?=
 =?utf-8?B?dTJ2cjcrcXo0Rk9zNWtxbTlBYjNkdkYrYXJyNnMvS3dkKyt5dXlpdzlpU3hk?=
 =?utf-8?B?VHB5cVZaZllwWTlIcVp5c3JVL043QVErZnhPRy9scXd5SVl2N1YyNldWNnBS?=
 =?utf-8?B?RUswSHAzakEvNjRZSHVFY2dCbkJwSFo2OUVPM0FxOFYrc3o0bmg0bWJNeTA0?=
 =?utf-8?B?VmoydkcvUks3cWJsaHJ5Ymc3QU9hVEJ6VDNkZTQ5YUNweFdWdHkrMG9iV0ZT?=
 =?utf-8?B?R0FvVEp1SzV5dUpUYzlWd3BSdFd5aVNjazFsa3lPZXF5NWVtRWNSSEFpOE1I?=
 =?utf-8?B?dVpMc05wUjU3NXE5anN0SldESUdLK25CK3poM2V3QWl5UExxbkhEZ0ZndnV3?=
 =?utf-8?B?YWJ3emJjejkwNFRHdTEyNWw1MmZ5U2wvejM2bm8vQzVxV0pGdUoxQ1NWbk9R?=
 =?utf-8?B?U1c0U3V5VHd5MUY3d09oZE9oRzhhS1g5dHhURXVzN1MrRU5rVTlEU2d5dUtM?=
 =?utf-8?B?dmM2TVptNG1vVklHejJFT1pJL0hCRUpJS1NnVDJjd1R0UUlTZjhwOW1aT3BH?=
 =?utf-8?B?T0s0QmVzK0M1K2IzdkdWNnAxV05tMHBzRUFSY3g1TTNqM0F3b3U1WEtKN2R5?=
 =?utf-8?B?c1U1c2hUQkZSZ2VnVHF1ZURHZCtaVzJ1dmtMa1R6Vk5mejAyMnZyc1VBcW5h?=
 =?utf-8?B?anlQTnVwSFNyYm41dE9LcTZoZFpzTkFtQVZVRkF1S2pFVWt5cTBGVnBtU2V2?=
 =?utf-8?B?VGlqWU96dGloZTRBWmlFNWFGZzZxMWI0RnRiNVdkNWw3cDFaQ00xUFRUZFll?=
 =?utf-8?B?SzdqazFtMWd4ZjBjUmhjQ3ZDVFlLQVJkMlZER0w2TWM1NFZwSTV3b3MyVTYy?=
 =?utf-8?B?MGd6K0FzM1pqcE5XSndCbysxRElHVmVJbDUzUDBHdXBvSUJnUm11UDVRaGRQ?=
 =?utf-8?B?VnptWVkwR1NTZUlSclNrSzgxUmJHY2lpSkg2NGlzNkNoUjBxa25WV1ZVcmx3?=
 =?utf-8?B?a0Z6UkF6ZlpYdnozdDBOYlo2MitPWlI5cy9lWWMrMDhwcytOdXdNMFF6M1ZW?=
 =?utf-8?B?cUVEMEFuRzQzNHpqT0habE12cVIwbTI0MlJRM1VQOGpDRlJzRWIvK2hONUpI?=
 =?utf-8?B?WXBlUkNvbWFBaEl5UFJ1VGpBdTF6V0tkaW9GcTRFVytpUDhQS05FQUhzV3JC?=
 =?utf-8?B?Um5sSHZXNWpCS3Nla29TcDJPMVFWNTlKemFWOVBsU0w2MndwUzF2bzNzMGdo?=
 =?utf-8?B?OUM1VkpTWSsyQmxMbGxXcTVQb1ZoMmdQTFByblZTeG9HRkpOVVc4YzcvLzV4?=
 =?utf-8?B?Qjh4T0MwQVV1RVkrbGlrZ1NVeTJEazB0MWU4U1ltQk9OaDV4OVNxT05XdjM1?=
 =?utf-8?Q?uKPerBYMfmV6TRTQF8fPJYM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e73e721-362f-4d6e-f11d-08dc15aaadb7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:16:38.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcdDQp/bBExsn8tqJI9qJ0vtCCqCeoj7ST6rRXESiF0jsNIXLFlPK7CqxuoYXoBTHJoORzn7d59d7OtztCXqfvF+hiOQSZeF4Hr9Q+HgO5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6035

Add prefix for XMOS Limited, a fabless semiconductor company that
develops audio products and multicore microcontrollers.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..cb2c8ec1faf8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1578,6 +1578,8 @@ patternProperties:
     description: Xiphera Ltd.
   "^xlnx,.*":
     description: Xilinx
+  "^xmos,.*":
+    description: XMOS
   "^xnano,.*":
     description: Xnano
   "^xunlong,.*":

-- 
2.39.2


