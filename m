Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639F80870E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjLGLvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjLGLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:51:11 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB95D54;
        Thu,  7 Dec 2023 03:51:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2Jlig73syQmuHl1fFPe5+lLtPm0y46e6zVfpEY6nLWOrQz6qrJCtsF2ghVPoKnwmHyh0irIBb3qLYbl1+HKOlrhxv6c05n9QZvywiKQwH+eMsGur8ASzCqH1KIGfsYERtF4SJN7wlq/ffVZVKG/xFDneGW0Ai373OSc3mako0O06CT6wB1OeS3GGHyLgdZQWALgVi8ReTgENRi1y+dpENufPAAZ+q69CzXdNFHNtULVMBPZ2jU/Hiu/BpE/LGOool9iIvNpLEwRG6QMxCS/CBfgE2N4cLq7rtxBeGCcKiaUt1kSUoQbbo+RGvrWEwxosztSgeetn6dubZcRxVjhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1EvpbwTcE0dmc5Eff9wwN5OYVx9cnoLMYn49rscy3w=;
 b=mgXnA4bnlu5vzNHfPkWZdHlTcrrFLY7T6vrpTG3oTEv/DfoH7HXYMSHq7KzY3/HKcUsHugFF3AE0zGgeRW+Va0/Plamm9TVxS4csJZ/GkeYvBDo5Lc5Yg31dU4V+UrIF3HRMZcoLNPDx5m6Cha/fQFTLWxF7YGO8W64TjxN6HISfpl7GrCbafJvA/77GFPrfpAn/kSMK7qY6Z8wpxYOH3cDGvDo27laPlPjqXGho6yLjgE1VMhKdpGrfMkIf3BQ0idHfJAFcnuyKOpwuweAHI9VcQ0VD6h1K2lfx+NcW/legX2GM2IF/nqImtaAY+IcjTSU+xpffh8r5/cH3LI0FgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1EvpbwTcE0dmc5Eff9wwN5OYVx9cnoLMYn49rscy3w=;
 b=TIFlxI8U3Acy2Mb0+CFPvx11fTTtwDldqMGCZdtJgFnX/xww/L9I1c47J14Wpam6gAribLY+EG8nLEnFeXH+4RdwUM0NLybZGIfxL9XlhWzy/exDbdmVKi4qvjjppEW/FtvTlw7WaoF+FdcGzVwfdcJqa3uHCcrtnqAphO23RH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB4PR08MB8054.eurprd08.prod.outlook.com (2603:10a6:10:389::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 11:51:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 11:51:12 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/4] usb: typec: tipd: add patch update support for
 tps6598x
Date:   Thu, 07 Dec 2023 12:51:05 +0100
Message-Id: <20231207-tps6598x_update-v1-0-dc21b5301d91@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmxcWUC/x2N0QqDMAwAf0XyvIJG7HS/MsZIbaYB6UqjQxD/f
 cHHOzjuAOUirPCoDij8E5VvMmhuFYwzpYmdRGPAGtsG67tbs/pu6Pf3liOt7HyLTMEPETmCVYG
 UXSiUxtm6tC2LyVz4I/u1eb7O8w+Hs1u5dgAAAA==
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701949872; l=1454;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=xF7pyOOXLNRg0gFMI7b0P8Qq+n3rgDPuNEC0fPw66FE=;
 b=ieBeCd5rrU/ZbQFnJ0vuTs9BB3clUDy51ZvOBah1fkpVZR1c+vo0V7vcYvx9SRq1wiUYadIyD
 F8Yr+QFKI49ABNkVPjG+jA0AufTg4QHwVmKnKmAHL3h1Hui5Uo1zeVg
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR08CA0248.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB4PR08MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 86432559-23df-43a8-8020-08dbf71acf9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsoRDmKbiNslHMJcbPcXy9bFd4V/b6KqZ0+ScYSMflWfsuBB1m2rBEG5oszF+/GLArkCOWdaqzBuZAvC8X6W/6nFzKvlNwPyCegojFRVY56rh1c+RIQ5aTHBnHDz1dzYuyy7JEHaTiJHFexFW/CqHU61P8w9Kb8KcRgOZau5DY0qG8xzjPntX0WhAjKXSKLtxqNWX5e6pbwk4YYj6f08/Bxa++TjrA9UHpcFz0cyu7moezc8Nf4M6R0iUNrHKuRu4tSYWGMR22zLr7rVjuj77k4jWp0RYOEyaHpM0aw+EkyfyoTo+vpcMnVz6cPBcwGDghkMkow0ZsNM3QAu4EkybC1M0LW7PkIYX1tPK63TeuLJXWiZZ9uuVKLvAo5h7ACmqTrKZugXLTdiSXHRobaD3h/oWyU46cB9bwSo44NJh20plI7JdScsDC26/hQ4sMfuuDr7NSP1haHBYhrbWvWNp/Uokwcm25JhfPSJgztNrxeMbT3ykIt6qXq1xlnT3A/XRuULf9RQtabAxRWAOnw+dCfBYlVQ2CsMfmJGZJMBzfTCIyVfW11anPYLCHoIP5tfKvry6B5YDjcyQ014JZuLJw/EHrwet+tPz3nDb6Q/BhLi2JkExVdc3MuO5ZPQm1ix
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(396003)(376002)(366004)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(52116002)(38100700002)(5660300002)(15650500001)(38350700005)(2906002)(2616005)(6512007)(83380400001)(6666004)(6506007)(107886003)(26005)(110136005)(36756003)(6486002)(478600001)(41300700001)(44832011)(66946007)(66556008)(66476007)(86362001)(8936002)(4326008)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtVZHZFdkZUVlEyQ2RMS0FzdFhBeFlnK2xoZTFnTXhDMFB0cFRvYThQbE8x?=
 =?utf-8?B?R2J6SjJJZmVOMEhxNk5Mb2RzWUR6V2VYMVZSa0h2Yzl3MG51aS9jSG5DTnQr?=
 =?utf-8?B?RDFQMzFobHJuM2hxU2lXV2NXc0hkMFBKeW1HVGZxQjZiZGVIZS9tZzJKekYw?=
 =?utf-8?B?STI5NmdTVlc3MU44a0dJRk5EUkVlQ3puU3ZsZWFCSW9OS3NsS0hmUGI1dnpW?=
 =?utf-8?B?WXcyT0F5QmdtVm4vWmhsbklpeisvN1orYXRKKzJWUWFLWnVTRzZMbVR0eWRa?=
 =?utf-8?B?cnNaaStHQUZ5WURxT2l2QXBnQ0pZeW5LOVlHSjlScTJSM1FvTHZNYTBTcXk2?=
 =?utf-8?B?S2dQQTZ4MVltL2lLaE9Hc0xFTDlLdlJsZGlSU0FYYUUwdThESkpKYnZuTVFC?=
 =?utf-8?B?MkZzQWZsWmJsWlAybmwrRDd3MCs3ekR6YXhJY1E2dWE0WGNjN0hMZzMxb25O?=
 =?utf-8?B?a0llVzdvUGoxckp4U29iYjZkbS9XeElpZE1Kb3hsMVNiM040VG5qWDBzYmlt?=
 =?utf-8?B?VGl2MkNjbThHYlV4SFFsMEdZNlFZdTZKTGR2R1Y2U0t2N3Z4bWgxOFVHaWtH?=
 =?utf-8?B?NUdqenliOVp4aVJTL1ljK2Ztb2F5VDFwVjRXUnYrL216My9seVZZaExBNzZa?=
 =?utf-8?B?REVPQkhXSHlRQlB0Y1B0bkVTckFrSHB2S2RYNUpNVGUvRGZJNitnZk5ITHln?=
 =?utf-8?B?K2NLRUt4VjZBMk8vWHcxcjNaMEF3WmFoSTBqTGcvalR5SW9xTUt5L1FBcXFR?=
 =?utf-8?B?OFRabm5TVlpFSVBkMjVWUS9DdTNmdndEc2xNbVMzU3E1c0Y3ZkhKaGZOVGN1?=
 =?utf-8?B?V1dmZGJDZldLZWdTQ0xOcDI5SnlqbkNLWUFQcDVnT1VuSnh4V0tXQ1h1em1N?=
 =?utf-8?B?aVZVdWZra0R1T0wxejJhTGpQcG44Vzc2ZVlNVFJLYWZUYnBnZmU5QlAwWFdG?=
 =?utf-8?B?akdGNWNudlpMV2FkNktyYy9yRFRMUWxSV2JxYS8xRmFyRDh4Y0N3SVY0VFBz?=
 =?utf-8?B?cTk2ZCtVanBzOVp5SHk5Mng3R0h0YzNpMHR1cmJHcDd4Q1JWeVB2YXZUaDVK?=
 =?utf-8?B?QW8zbHZyUW1BNVRVa3hkR1ZTTXptSTllUnRuVXF1dDN1eEQvUE10bVh1RVh4?=
 =?utf-8?B?blA1d1dhVk8vY0pkWTNUc01wMm5iYlpBYVcwVVA2MUpBYnBGUFdTbW9IZ0Zo?=
 =?utf-8?B?Ui9HYWRob2xSS2xwOHBGMEE4MHRPb01ra3dJYnEvdWd1ZkNjM21MTHdmSkl3?=
 =?utf-8?B?S0d2LzFiRXJ6NGhvZFdXcmdBT04wK2lYZmwvTDJDMGJuWXBOa2xrYmF4R2Jv?=
 =?utf-8?B?NjZ5TW9BajZobFVaU3I2bDJMdUV4MC9Jb0U0UWNyZnR3bDNyL0RjcWc5TlVk?=
 =?utf-8?B?UEJNdFhsb1ZTdzNCd0FjVGNyVWJGbHI3ZFhra3FMbXBaeDJBMi9Zd0pucThG?=
 =?utf-8?B?TEs5ZlZGL1lHUFlXR2lIclFDbkFhRHh6QzBFbHVBaEJqeUxIZWtiZDNWWUJo?=
 =?utf-8?B?bjJVdTJUMHJwM3BPQ0FhSS9LL1kyVUdrYUVPRmJXMmxpZzdFL0NIWmU1ZS9k?=
 =?utf-8?B?SzlKOGFFcFYrbUFpdWZvb2JqNXVjaHNneFVOVWJ3Q3J5M0QxUURGYVU2dDFv?=
 =?utf-8?B?NGw5VkM4VlYwM3ZtNkJYL1Vqa3I4YTZJZDUvU1VvVVNmUStnV2gzenIzSHlr?=
 =?utf-8?B?d0hEK2JlbEY0VXpnWFI1U3E4M3dRcm1pNklNQ1NnV3MwQTduZ2k0SHZvcERH?=
 =?utf-8?B?RzNJMmJUL2hUUlpXTVg5MmJpb1Fic0lOS1ZQV3FrRzdCaWF2ZEdZbkFoZ29p?=
 =?utf-8?B?c3VrS2lDT3J2aVErKzVqSS9QTUZKdWFJa004aWFmWlJONS9GRlV1b2tYOUd3?=
 =?utf-8?B?SDdQRUx2b01lNUpVWlNPK0FaeEFONXRwTXljVGYrSjMraGlSRy95c0RYSjRu?=
 =?utf-8?B?enM4RjROaWwvSlFSbC9jckZ3OFpJT0lzUnFpTTZSR0NBUGtiOVkwK0FmK3Vk?=
 =?utf-8?B?bkhJNFhCamVpZHhLUllENnV0Y0hiZW00UjlWeWhkSk01cmRFQmJoTHZlSkQ4?=
 =?utf-8?B?NENhZ25ONnUzMk9ySHlyNGNkMS9WYU80cUFhS0pFNUM4RU5WemhRYWd3RUc5?=
 =?utf-8?B?RndhckRuOVRRRktBd1JPMUtsYUpTZGkwU3R0L2xqaGhUOUN6VlBRVGpRa1B2?=
 =?utf-8?Q?6LjlSgBaQfWU24DbOQtYxhE=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 86432559-23df-43a8-8020-08dbf71acf9c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:51:12.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w33Bmk7MlwVQ9qwfrazJUH109bOuMMB1WRe3s1hyL1BbC0zmcXjXo15YIeEDuiY6h9IuxOdgaSQ5HjqQPeKc5wdY8riwEHFSVeaBaZrjtbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the patch update mechanism to support the tps6598x.

Currently there is only support for the tps25750 part and some
conditional clauses are used to make a special case out of it. Now that
different parts support patch updates, a more general approach is
proposed.

The update mechanism differs from the one required by tps25750 and it is
explained in the commit message as a summary of the application note in
that respect.

Note that the series makes use of the TPS_SETUP_MS introduced in
commit 6a4d4a27f986 ("usb: typec: tps6598x: add reset gpio support"),
which is currently available in usb-next / usb-testing.

A TPS65987D has been used to test this functionality with positive
results.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (4):
      usb: typec: tipd: add init and reset functions to tipd_data
      usb: typec: tipd: add function to request firmware
      usb: typec: tipd: declare in_data in as const in exec_cmd functions
      usb: typec: tipd: add patch update support for tps6598x

 drivers/usb/typec/tipd/core.c     | 151 ++++++++++++++++++++++++++++++++------
 drivers/usb/typec/tipd/tps6598x.h |  18 +++++
 2 files changed, 148 insertions(+), 21 deletions(-)
---
base-commit: 522c35e08b53f157ad3e51848caa861b258001e4
change-id: 20231207-tps6598x_update-632eab69d2ed

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

