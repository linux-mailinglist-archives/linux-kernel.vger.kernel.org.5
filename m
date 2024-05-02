Return-Path: <linux-kernel+bounces-166369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F86A8B99A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177721F23207
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728469D31;
	Thu,  2 May 2024 11:04:05 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2097.outbound.protection.partner.outlook.cn [139.219.17.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB522E633;
	Thu,  2 May 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647844; cv=fail; b=iFSWhtOHnqy4kJOfYErt/jLZ/X8NyTrv1C+M6EBTq920inPyP2nZGXLndh/z/F9aH4FnfiSrAGI3Qk++OhCqcPCYHaudIY2ajO0FSpebH3NgJj+RfFdUzUP63Yzz67jDEDQkYkUTlhdJT4/qyJ5D9kgQs4b27Mb85wuxPNLsebM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647844; c=relaxed/simple;
	bh=2XHWkI9RUhadJdINM4VU2jlIzIjwxbo06GnnwqJAQ94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z58cfMXD8PXqZKb1Ol+KQpM9Ixiyfnt3Gm3FsTcamAigzBn3jD3edKc5Hpt5txOjWj7GP0NESnWOPtD/maF/WixivAR0WdqDNo7bIV+aGYoC7n2lZPl9J5Hfp4ZvyjC4sinBHQSelTYRzGfgNs/AelbYbccZt6tsrQvp618eiBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBU1hqaEVEc2NfSWjYQnWw2wV2Dk1P3aUXuOggaNObpHVPqJztBlbbOrvi4J1LEhF+wbedNKHx1EWlnSOkOTLK/WgDPpNYMTbyPqPh1w+b1zcgp4kKiI9569qCNsy1Urc2hlVhghj0nyq0mfj8p6Gbj+gRWRynYhjhxGO3cHuV4ey/3SayTIiNaLdqgxxHIt84tlLdpksW2/nDmZGaHOeiW9gpEBD01W5Xa1RryK88nfBJ9evJgqz144iBDPkjXOD9Q4KY83vhGttDwfZD0IHVbqEwh9OVBb8wB6FnQQ9kpgl8UODw0GRU1AXdB3+XC2VyLBUk89DKoQuKheOCGxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB8Wzn+SDQEyV8juCswxBGb3eKRXjnBkhfa3q/LYYwY=;
 b=eCFf/Y3W596xBqB3ut9CmvbD7o35PWtTac2OGZumo5DqNn+10PRr3WJPxS+YrA+ZFwBcQ4DDUmsGDwGd/Sf41UtjS0UE3cSVdOy3oXv73tBzWQeD+mjDQalxmPiEbqnEF03fKqI/DMCqOYDvMy+3+lz2Sqeq0v+IWFMIHIgZqAfs6c0YURjEMPV8NTWtN+X+NFBS2ov6n7mAt1OBbKbs7a7k/HgantttJyoOqZ9P0Bst6SgaXmXyc+RNyjDbTU104Lg1lOuzTQjsXLVstmkkwnrR2EA4LaXw2lYWuRCo0pD1IVmU1e0qrn0S/iFkfkwR/IOsjeo/ETe1JQajIk98gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1284.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:14::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 2 May
 2024 10:48:36 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Thu, 2 May 2024 10:48:36 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eng Lee Teh <englee.teh@starfivetech.com>
Subject: [PATCH v2 2/2] dt-bindings: spi: spi-cadence: Add optional reset control
Date: Thu,  2 May 2024 18:48:00 +0800
Message-ID: <20240502104800.3030486-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
References: <20240502104800.3030486-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0005.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::17) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1284:EE_
X-MS-Office365-Filtering-Correlation-Id: b6121a13-db75-4ee5-428e-08dc6a956b81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vwjbcvqmuuEbRy0LVH6+MjxxGlserj4nRZCncTup7X6LFgwboZlY7v6BqlDxemjSxupu2CRMGIbPdaEqw2nrAa81Co+RTjadH73Nf0JAFjt4oHX+/tmA2zQ1RUz3QdBvuJVWv/j7CrbFPgD1OSkkJ8f/fWJqV30iJ93zUd6hdVJ1LCCNmsZYDPA2D70/qK5cVpbKu0XFSIgVDIwV1W0OibnOTIxyEaAWJk3ooz2oZXVpfuyWyShNKvn15PMuYJnoFVLaRvOIQ94jdlc/Zb9bpNu1ET+QVL5WIZavW4dLD6dY2Ug5YVkbh557y9Ik/r5oAGa6xbciEXtzfqzayMV5a51WPwXT1yJoY63x9deem0TqccnzNFkZHufWUIvpXHNUXpk2+HPbUtztUMh1bczAEvOqF16gDI9ZTTwXLwCD7epcCMWdBybRQ70V9VF3lPbL+UmqBifk9akiwACMxTw21Eiqf5Suku15DlF7nHZsCgoz9uLkN582GYlNvJHkNuaFa0JOFfA+faGleh/v7kgO2i2NFUjuuc4/X98hpN7SE3APGOJox2lVkfMldigGwGTI1zlbaQRzt4Xp9nlV0SLGrayLzqf3qNBpdyj4ZVuN+IYhKwQBER0dwhjzga6P2Qru
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(7416005)(41320700004)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/Qvv9D3XJWJBUFmJApyXKspgrAkNGaz7Ej0CdOcgHj+LP9emSzf8xp7P19f?=
 =?us-ascii?Q?SeMtRYoVidBIZgJ8HZvWl4lYVHcccL/capL8WxkXjXVSvDo697zXAhGjFYp/?=
 =?us-ascii?Q?+x8fouuz8+bPZi+oZpTXPJX3/6CW9i4LXzB2/AbClFP1bAg1anUX0Y4D0Rj/?=
 =?us-ascii?Q?agVD4r+DHydzwfnYmkQST6AURDSC2Hc17f/8ry9pnKjfx22D5/GY9b59AaSB?=
 =?us-ascii?Q?nkEP8RCjyK6qBZcyFmMVTRwSbSQ8aVJAP+aMXpEFyM/sCHI7eupFZkXihpAA?=
 =?us-ascii?Q?zMmQRhuH6LqAACMY1CFj1igmpCv3QCnAUkPbxCMFIcU+QCjFDz6/3T3SZnX7?=
 =?us-ascii?Q?/CLfOh13uaF5v03tl2Nwp9+jlYFMFUESBygESZI3UzcxN2lm0bNDUufIqKg1?=
 =?us-ascii?Q?pCwBmwMv4tuICT7v1gBm/nVSkZQR0Vj5Ii2eOZksfdg5L/VrCQcVdT1/i+gc?=
 =?us-ascii?Q?G02mFqon3dkjS8lpUNFmJ8OZ6ospa6onCfvrA5ewOnWt6QDmTPCMT+yRw5zi?=
 =?us-ascii?Q?xX6uElxgW6n2X80ZLNgBLS2zfF41G6zY93vjgRnI2I01/RbPa2b5csEa57f7?=
 =?us-ascii?Q?yH6PVkMICrugjefzf+mtSzBX4nme6imztmtB0XRIEZEn19on+/j6QdOjeaMR?=
 =?us-ascii?Q?6VnGW/46eEy2c20vKq69cFoAYjTHhwhGbzmfOFxgUfUUqLpoe1V/Zptt2xly?=
 =?us-ascii?Q?KQELv4uYgbRm1gkf3HRRpYNMDqIJNnXYZoHC7OnTXadPGTCGESUXLsHrckBe?=
 =?us-ascii?Q?RBkphJgDZknRX87NF8wb3jnRZMknw91OoSw8wFL8zIf+dLKIK0wWGPzvmuvb?=
 =?us-ascii?Q?9Ncca0vJ65GB7LlOxFyHQRJRV7yHhCePNcahx4zEw8UiAwsiUsCT54i/+K09?=
 =?us-ascii?Q?klWURFfb5330Jl+nnTiUFIezv4WxPGTmOE+6iDvw1Sh+90pMMKOxUmVBP3R6?=
 =?us-ascii?Q?T1/pxe4zd65osu08MGtnlS0l6K2u1j1YII5+a0WPIbfrzmcrDbOuN+Nvs2tK?=
 =?us-ascii?Q?K3p8gkEfAhg1ghiQNve5QXwwN5JuiCFyrJSewOcWsE4+k1nFQ+Rn7VFuvR83?=
 =?us-ascii?Q?E0W4i6r20vkdNkj8keVTS+LjU1AeGTorS/IUNW5rB5p4mjnW1wK8GJi/XWd+?=
 =?us-ascii?Q?RScJmhXt6cyggdCilYodfIbpaUiJzNXoi19DzzAm1J9w5qjwauoPLueeJ0oi?=
 =?us-ascii?Q?b0YNWoobBfF9q8Jr+GstHSLXrVOLW8r/7yx4AoqwOJ07+2ot5hS9AZr6dYGw?=
 =?us-ascii?Q?ag3qwVwqwrsvUOl8dwB84eYgzjUA1gA2vUPKQcysfFsG6gvu0VLcRkLfZsaQ?=
 =?us-ascii?Q?9OYerWZSI6JGA8q81kXZv090oux0MunxI4E37pMwXkdeNONHuxcLI+B2L9u/?=
 =?us-ascii?Q?9GxsJFeqm58UfKOUJM6+ZnaEu3GPPFjZA9tppAcgeFWeHzEtZzZhLOJxOxR5?=
 =?us-ascii?Q?AjaVUMbyvnpYIzuiiqKEdRRg7a2+KI6h0hUThCTXvGw9UCl58VrdMf4UfrfD?=
 =?us-ascii?Q?ykBtBdnWdP7cUJ0i8KbN/XXO5opcADZtQgPUpLNimgULnYbPX7GUL6vp2xZ4?=
 =?us-ascii?Q?gBnjztk95AtIKA2YYGE0v+40wicE5FNMQE257bHgatjmWkBR8b0wUeSE0PoP?=
 =?us-ascii?Q?o6EPWMU1t/5ZHDRSZapjiGk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6121a13-db75-4ee5-428e-08dc6a956b81
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 10:48:36.7677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEmWPYWlzflULpswHOcioeJt5Ub300vI12oEITKPgg6WbjKzxPJncIeOVwXL3U7NcQU7wj+eYgo6QMnZswe8fRTXQojKlEJOX06xV+Acmbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1284

Document the optional reset control to SPI.

Signed-off-by: Eng Lee Teh <englee.teh@starfivetech.com>
Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
---
 Documentation/devicetree/bindings/spi/spi-cadence.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index d4b61b0e8301..8de96abe9da1 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -55,6 +55,13 @@ properties:
   label:
     description: Descriptive name of the SPI controller.
 
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: spi
+
 required:
   - compatible
   - reg
-- 
2.43.2


