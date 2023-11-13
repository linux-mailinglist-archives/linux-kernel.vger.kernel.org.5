Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD97E9943
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjKMJnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:43:41 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2040.outbound.protection.outlook.com [40.107.215.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4D10DB;
        Mon, 13 Nov 2023 01:43:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMoUgpnPBOThnD6o2I7D/ueFnCyWaCuTtrf6sPNvKZOW5mTlrH52MYoumOAosri66Ck955hzkZ2msLTyybOKvC2trxEQVsZylTRvU8nK++jVBBwzcBVkO8jkez8XybPYJCN4/EK+GX0bUioC04L7WON+EKQnzH/DHytIzuGpIwIQsJzdHMboFVjThIISekPsY2JbfQzVIr2/QY/jS90UnTWrnc/dVZmpY1jzU5vHFhZrtEyc1xjN51CxcIJeENAvobDa8o+f57VRgpR+HDT+un62I39RzeJikkWiJtyhotzEac+pKz5uCFhp/mRLdblu55VY/E2NBYQOg3BekxEf5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSxc8lCKcWkHtvomBdoZNaDSENQQJ+pdFq8JahBwqeQ=;
 b=klVyjdhfrrquF5UKG81tziM99WVgezQ1S3p7fl8oSt24Vh9jbULc5b2dZXi2IbmN7fFO07pi1A8GzKycjxq1lSNPsLE9e/C9+MjuUKV3S5FjGaIsuXlbupB6QokdfDAgl3Ep+i+AurHvp3P0LnqeaUa82UYGKZ3/zXdr1rCl/Ly+PqaLP5nTJZrpG3JlU02wrEEsLXlOaSsdWMQPQu6TECclM5OAgl/fP4JYL1A4JFY1ll1mjsUcnllKMl9twGBizNFlanYBQMqGjxVnu7t5yfjvCemRUi35HoH58ka93+XKWxgSL/C3cYhVvKdIZVjxSBqR7ou3xwPNeD/ATsUu5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSxc8lCKcWkHtvomBdoZNaDSENQQJ+pdFq8JahBwqeQ=;
 b=imPYlojCsjrVeNmZ3RvBWt1zmEGNGbahjvppoFfAyEoAMJ/0tsMKEonDeCNOgNWBo3Bt4kLOauD7CLddcKdZlR3G08VT/fwgD2ijB3RiVyPMHOnH7Amo+/0SyaaHI2/gG3RA9yQ+cuSipmgZv1dSqHDgPEWs0tA0bdebIkcvLY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5585.apcprd01.prod.exchangelabs.com
 (2603:1096:101:130::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:43:25 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::e90e:640c:2742:6339]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::e90e:640c:2742:6339%3]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 09:43:25 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Mon, 13 Nov 2023 17:41:36 +0800
Message-Id: <20231113094136.52003-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0094.jpnprd01.prod.outlook.com
 (2603:1096:405:3::34) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5585:EE_
X-MS-Office365-Filtering-Correlation-Id: f43470a3-6ab7-4271-c549-08dbe42cfb82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJNVv9F/XR8aawq2M2ainHCtjVTSEt3lBKVBa58P3GW0Sjwr3AuOWqjIFhJ4HxWO312ESJ5CSiYPQR2sZoVZn886q12pvbEcluBzBfBAlGABo+DgHo0qZphk7mLM8GIDiFCCH28VAwTqPngJu/tiY1MI6m/ZNxQPCciUrvAuxulavoDiRrDSYsiSqYuCjgwxAr7fE9kLofVvxTOP4SmM7Qt2/n93zp/JOnPE/nVjv8n/lBqz8ffDfkN1SePH/+up57+DvZoqPc96NOqXC9uC9k1n+7667rvXZo5AJMrSgvmiVutgTVk0TGwdVGqmuue3c9x7dPLD2wqDqYTaeKy9KPlfJ9pFIoFaVY/6uDKG1Lo08NC1guiWB/RcSraq0udQndVOPLjqB9sKBOgx/VAK5rIj2CFNkvBGCQKAAfEiz/o2AYb21ubDm9efNst/9LLioJxLsrbpULUUME07PeotDG4rI5NQ8ZYcslm9OSTgaMpeAwrvl/tXzOlWSaKaTFxbLIHnQdNezMWI/ac5BFtIm3zz6mKKtgo40ZG6f7diyDt7CElsNsc0kdoQAQ2oB9ZWLdOi7KnehT4uA3Mql1UhO7YU7LxP1lvhNff/lrG2Q54=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(1076003)(107886003)(5660300002)(2616005)(6506007)(52116002)(6512007)(26005)(6666004)(2906002)(66899024)(83380400001)(66556008)(66476007)(478600001)(316002)(66946007)(36756003)(110136005)(41300700001)(4326008)(8676002)(8936002)(38350700005)(6486002)(966005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ncuU+BA1edMrjJveufDz1A6qM+baBatEMQWHDi44RldAaA7rxhnbNQ/AZKF6?=
 =?us-ascii?Q?eu06CuXhU8qlSb8pPNDkyE38rE1CdocApcRfazqekfM9XcrsEkt23mtBtpIA?=
 =?us-ascii?Q?bS/U7CKLuf/vAPw4rOtILiUb4liOlE2x/l+03STjx0+TioE3SAvgi5DOI+JN?=
 =?us-ascii?Q?9x4Djrxodt+iYAwvennJ5zO4bfAErl1+QRxuIqqdfPfQ2DiQy3xgDs/gkUDu?=
 =?us-ascii?Q?1YWlulnFAHT1nA9Yzo9zFQpsMaqTcS0j5L/yZqd7XdEv+pmY9eghBe/u5LKk?=
 =?us-ascii?Q?J9TCDvyFMK8enBZ2hA/io5fFsFzDmE0pIhL1Tzm6yejXj/AJKW6i22yfaPEk?=
 =?us-ascii?Q?60e+Ubrm/e+jKFV6J13AGpEOBTNgXMmH5vDzS9brLLbVnj5h01G9qlRdwPNG?=
 =?us-ascii?Q?O9uUa0R36k3N6bqZ9NB5QIb+fzlZKLdbkFb1UrkWbbSq7UlcQLa9fS2qkBx5?=
 =?us-ascii?Q?QRGSbZDp4QWCZ1VFGpR9pDJlKKLGsNQwoRLryISqQ8DPEY+y7BovsSFwxl+d?=
 =?us-ascii?Q?FYJ6NZLuLQ/nEc0zMXqi5/K2acu9Y36E5rqsWEov9vIuGO1nAsCT6gLnxFw0?=
 =?us-ascii?Q?5Qrtp7B8az95OWt1I7ie26FK8IBs6YY4wu2FU7kEjBYirx8ZYK3ct/CgLy5v?=
 =?us-ascii?Q?we1XBfbDzoT/MS9p0f7UVmL/oEUQwvMmHy7Bip3n6qw2UkXO8kIpg19MWKaA?=
 =?us-ascii?Q?Uu4g1k4f/CmMmSknFTiUu16kTHnTXNxIC3w4WUBWOL/fgVlgc36JkATV9/++?=
 =?us-ascii?Q?giB7w3hvfumsYsqCU/1nPW2rf85hXG35s0zCQskJRoYXOJDNdxwfGhGJ7zQW?=
 =?us-ascii?Q?liZ8+0wP6CrGs1NtnEJxGt6ZLrsFA5V8x6UMbRxbCMhYLhJs6RU6/9BDCoRy?=
 =?us-ascii?Q?3I77inWWydz+GhMC+Ja2vWSb2xQuhYnsIpdkhA/El1gjhiGUoamPbLTPdWxo?=
 =?us-ascii?Q?VptFIDItchmlMTAcXlMKQgiXmWuJBcdlPew6uQTEUDoIt3QIpkteOuHMwRY+?=
 =?us-ascii?Q?8rB+GbSbwLlMTVzj6xq+NUDRStQajxbwI3jdzS7O+ZgIz0eeWYdMywp4u850?=
 =?us-ascii?Q?Vypvt2+MwNin9eJO3qT4Ez8g5nMPjGyG4lcZovduyt67ue0P3RYZMA2YELBq?=
 =?us-ascii?Q?15IqRBQoB/3o08nSrD0UAY1/7/QmASkUcpGFcJPxjCTSQ1r3TX7x3kkSXkxm?=
 =?us-ascii?Q?k8Fv6cuH52/movKyIL1K8LYaHs0uu6qIUAkFPEYQ9PdWYeZniBrPq6xZL5wd?=
 =?us-ascii?Q?9Y2rmsJS1g0WX5PryrZeE+Od4uXg1Kq40cD9EMLIwp1867OJ7Iw00C1s+8SX?=
 =?us-ascii?Q?m0zelX+3WqGVb1g3GyGI50lNJSwMj55WOvE6bX7ioZjhSeFfH/vIaMcYFOUw?=
 =?us-ascii?Q?1WQCs4SCgDE+Y8Ryv/CZb7EfMAJHWuPBYloD60rdExAD0+ixXn2K8o1fJSCB?=
 =?us-ascii?Q?FBxC1kOQb1F89D44MpzvL2mYHsUHQjALm1C6OUy73BpdikxkSMMh0T/nHEe8?=
 =?us-ascii?Q?MTOQGbfy1HNFeue906YBq7dZwTpFm4uX0Fk+vyr0+WXz+u5MxJ6hqWMhXYrJ?=
 =?us-ascii?Q?s5x9dLHNK0K0t02VP9KN3TpcIEQnmYJZ9M7V83ZxvdUdMGhN9MxzI5bMUjnu?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43470a3-6ab7-4271-c549-08dbe42cfb82
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:43:25.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHfgDvI1nE0mVEdQqWLgXirrAVIVIT3CgJlTDtsDvHgnANxRtEQYK6zXi+xIAfcn0FLRmkJAFFcnNlCPCRqG8WzbPfwO3kyVOYP/p48wmGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5585
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
port can switch interface into RS422 if supported by using ioctl command
"TIOCSRS485".

By treating RS422 as a mode of RS485, which means while enabling RS422
there are two flags need to be set (SER_RS485_ENABLED and
SER_RS485_MODE_RS422), it would make things much easier. For example
some places that checks for "SER_RS485_ENABLED" won't need to be rewritten.

There are only two things need to be noticed:

- While enabling RS422, other RS485 flags should not be set.
- RS422 doesn't need to deal with termination, so while disabling RS485
  or enabling RS422, uart_set_rs485_termination() shall return.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>

---
Changes from v3 to v4:
- Include 'linux/const.h' header in '/include/uapi/linux/serial.h'
- Replace BIT() with _BITUL() which defined in
  '/include/uapi/linux/const.h'

Changes from v2 to v3:
- Remove "SER_RS422_ENABLED" flag from legacy flags.
- Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
- Remove the code which checks the conflicts between SER_RS485_ENABLED
  and SER_RS422_ENABLED.
- Add return check in uart_set_rs485_termination().

Changes from v1 to v2:
- Revise the logic that checks whether RS422/RS485 are enabled
  simultaneously.

v3: https://lore.kernel.org/all/20231108060719.11775-1-crescentcy.hsieh@moxa.com/
v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/

---
 drivers/tty/serial/serial_core.c | 11 ++++++++++-
 include/uapi/linux/serial.h      | 19 +++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..777f091a4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1376,6 +1376,13 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 		return;
 	}
 
+	/* Clear other RS485 flags and return if enabling RS422 */
+	if (rs485->flags & SER_RS485_MODE_RS422) {
+		memset(rs485, 0, sizeof(*rs485));
+		rs485->flags |= (SER_RS485_ENABLED | SER_RS485_MODE_RS422);
+		return;
+	}
+
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
@@ -1400,7 +1407,9 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 static void uart_set_rs485_termination(struct uart_port *port,
 				       const struct serial_rs485 *rs485)
 {
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	/* Return while disabling RS485 or enabling RS422 */
+	if (!(rs485->flags & SER_RS485_ENABLED) ||
+	    (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS485_MODE_RS422))
 		return;
 
 	gpiod_set_value_cansleep(port->rs485_term_gpio,
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67..9086367db 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -11,6 +11,7 @@
 #ifndef _UAPI_LINUX_SERIAL_H
 #define _UAPI_LINUX_SERIAL_H
 
+#include <linux/const.h>
 #include <linux/types.h>
 
 #include <linux/tty_flags.h>
@@ -137,17 +138,19 @@ struct serial_icounter_struct {
  * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
  * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
  */
 struct serial_rs485 {
 	__u32	flags;
-#define SER_RS485_ENABLED		(1 << 0)
-#define SER_RS485_RTS_ON_SEND		(1 << 1)
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
-#define SER_RS485_RX_DURING_TX		(1 << 4)
-#define SER_RS485_TERMINATE_BUS		(1 << 5)
-#define SER_RS485_ADDRB			(1 << 6)
-#define SER_RS485_ADDR_RECV		(1 << 7)
-#define SER_RS485_ADDR_DEST		(1 << 8)
+#define SER_RS485_ENABLED		_BITUL(0)
+#define SER_RS485_RTS_ON_SEND		_BITUL(1)
+#define SER_RS485_RTS_AFTER_SEND	_BITUL(2)
+#define SER_RS485_RX_DURING_TX		_BITUL(3)
+#define SER_RS485_TERMINATE_BUS		_BITUL(4)
+#define SER_RS485_ADDRB			_BITUL(5)
+#define SER_RS485_ADDR_RECV		_BITUL(6)
+#define SER_RS485_ADDR_DEST		_BITUL(7)
+#define SER_RS485_MODE_RS422		_BITUL(8)
 
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
-- 
2.34.1

