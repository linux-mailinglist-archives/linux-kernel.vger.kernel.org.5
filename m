Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAAC7F295D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjKUJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjKUJv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:51:59 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2076.outbound.protection.outlook.com [40.107.215.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C028C1;
        Tue, 21 Nov 2023 01:51:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiKxN+Zwk2S6YfwaFk4ZEZ/ySMC899NKIc8+/NO8U4VW7ZhYr9QEwYN7SVq2hWChzzzB/fmgSsF0YlZugWdttiuWep3d2RtDGMI+ZchuDm6oN4lVDpyTu/4TODbbACsV4p19kGHh80LqGpLgT0EFUcvZChqUdlaTydf1jaw8OIJJLs5n6TvV/uVkbVgLbeB1l+8tQdN9FGwondiukuftceL8Iy6LOvW+LiOOIIsjW1rjEzvdPAJgI4pfsB1v/P+/TgUiwtrkYtcv0va9FyplE35s6LZOJs2fZqYMKnmNyH6NCpbHCX4TigXUpaMhUYXyR3yW/H5ZkTSG1nURiPzKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3s66eWT2SqKIOaifRv3YMVQCZgQNEUywU9IpCcp5VY=;
 b=IVC4IxTUIoBoGNKVVhboQUdZkgMtjBagYCvZfYT8QlB6V99g+UQ8ndSwQUkVMjVteteZdhnnX5HSbAyGeRifRoohIN4PQVyy4FUQuJ8WZq+xt3pEW/UWVd3sc3/UGdAhnh76egruAzSDO3nonkRnmdWo25H7GRRnFDDBmycp03vnCaLG7C83ksL5Q+gwWgQdbS3ddF3HLRrY/57vGALXt3uP6gTjkWaNFstAcq3wTxcRt+drlF/7BzcqP0SZA4dLTpwwAGcAULxtqLoN2OtuasRhoyr99rFrW0HrzyxW2btXXxWFj4RIEUqLlk9sZEuPepfnIvSbM5Z7wUxqB0ZVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3s66eWT2SqKIOaifRv3YMVQCZgQNEUywU9IpCcp5VY=;
 b=L0+AKpYlrAjCm+EIJvSkouHoZNbaWaQxONzq6Bdxg57tRYCpcHh7ilqj7cRtwAtetJIdDyj+QFIjzKRUuu9vSVhCXowJBeRnt9b4aMTAP5IshX0Ixh5V/kwZ7vIJGaneOzUAmeyy5/pzog/YYxWKQtjEP7lkciZpUeTLacSpJgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB5602.apcprd01.prod.exchangelabs.com
 (2603:1096:400:425::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 09:51:50 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::a480:d88f:100:3a92%7]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 09:51:50 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Tue, 21 Nov 2023 17:51:22 +0800
Message-Id: <20231121095122.15948-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: fd9ab74b-3b3a-413c-9721-08dbea777b41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS7an9/eePkiiWT/D6IJUD5IDC362x+/9Kns1oAzRQyJ4jnbweQjnkg0d+TUMAwd6h9+qXnPLqkNsARAUWspYwlaiYy1oyh3WY3SIlwOXn1sCjev+YCghvqxIj29pZQhSHB6uhpbeCtQ9H9g58Vn7OPRB+//PESxf5WinGDVcbYCnYgAeVS1xYIW1sEpRtbpICXgQi1Q1RofVCTpDsVR1Hl1IR6OUg2GbVa7T4J83SxgFvgTr9S+Mo8v3mrONwJF3MPpQLAWJy9JGcVi968GS5HAknf4FQGdGOW/2VarktlvSIaS7C9+uxqZNQcCgVnpEp/hTdYz52nVj8sQ/nE9McWPZajfiunnIvOXQuADiRifFaF41q06zR9xsLmEmb56pn8KOiWyX4e5amZZ/vI6KI8VRmjpAFpjMcA/Ej2xAEV3SgoThZg/zgfjh5z2yBO5a27XVF8wkNWFSl1B8xKc1tX8g26DIisRwIwrj9S3bZ68fgtgHLkWeKotIQ4xM1kxHoEjTjlMTOW85AYsdTVjAV541IiO047jtDN8ogCA8NnTkHQkiF7G4jpL8V9Ijiv2SSQWpc148yvSc28VsvqWR1SwpftkkUEN2I5gT/h5Jec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(366004)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(86362001)(110136005)(6486002)(966005)(6666004)(6506007)(66476007)(66556008)(316002)(66946007)(36756003)(38350700005)(107886003)(1076003)(52116002)(6512007)(26005)(83380400001)(2906002)(478600001)(5660300002)(38100700002)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ad0j/2RzYBrlF5kkEigqQBHmFOXiFwj7QnCHXVi9Isr8pCf2ICVKjCaC89e?=
 =?us-ascii?Q?yUuojezjfEPY2SJASkH70sC+FoCmRRklPn3yu6xU6mvBKNtQPBZamTFebuwu?=
 =?us-ascii?Q?HUOAX0eCV9ZNgvqX/xXtgacMnuv3bBuH1wAB8cRK8pGJT6+jOhQqJq92Aypa?=
 =?us-ascii?Q?bAmwmqjV1S/WqaDKApH5WiNm+q1wDgbRQxZmVMh05Fj1qq6cE0LPnQst8iNl?=
 =?us-ascii?Q?P67D/uO4rF+BMS2B/KkgzZLOtpCNFBEOdgkV+GRCyCpSUalLakDbG1BcjjIs?=
 =?us-ascii?Q?wnUFmPfeOQZPuZP0h5YLj2T5lKLPLQYCtmys0iFR4eMmCuLB+zvf0BOHTWXn?=
 =?us-ascii?Q?PNsoDR2jYY6wkbr/GW944jseJnhSy5WmZKckH+sMzjVZzkqi7Y7hRwl8jEaG?=
 =?us-ascii?Q?cuKQuekfauWXotGTjGiNR36TiRr6j796wxYGwc55PyVhE6YfJ71OzmKBy3l1?=
 =?us-ascii?Q?2HWMhQ81CXk8+bLmEqtBNTNp6qztaGM0qrWACMdt3l7k7RceRF24SRbBsqfp?=
 =?us-ascii?Q?J6+ZWlp3a4pF3Fnx3En2JESamf8ow7jxCxgxRTeuz/3WbABwvJsgx8ocuFgG?=
 =?us-ascii?Q?OUZ1yTJsExTn3n//xAFnBrrCFD9h57Zq4Al650rn9kymkezKGIdXERXZilBG?=
 =?us-ascii?Q?OQQs5VUIA00iRIsd88jp5dn7Tkt8nq0itd3Ij3erAkkZ4Birg75hI9mQ8+7q?=
 =?us-ascii?Q?5cNcx3AhyHIqD6GuIidAyyBRkkKgVy8PbEmWH8xVLm0oxdidim0fk+7JbjJm?=
 =?us-ascii?Q?8vhzXy+4+uw5LHlHtlMoViZibSJJVV2DpS9oUbTW4q+m30tZZLt7b9uH4K8R?=
 =?us-ascii?Q?umbsmakhErO6q9BaVIj3WLsgQyEvdcxLzfvFwYhzBCIkU695zqSZa5egMKMr?=
 =?us-ascii?Q?eP9v99+0E/LjN+r96vQoMeBabKk+EsdaPocZt0Wbj3d2udmSxvg7nu5z12r6?=
 =?us-ascii?Q?Mc+pMuViTg5OCfVvd9bNmyqZlQ2DppO4QBjZJzjNl/G5W4kAYcU2mu6u8slQ?=
 =?us-ascii?Q?v9jNrB3rJBuDmM6DZvXlmq3jXxU0b3AVkBfbfvJ371zkKEN9vFBF7s48WAfT?=
 =?us-ascii?Q?Z7Yo1cCxGnfv1S6wX9mBc4+P4ttIGWHZuZBW3EqPkiyup3uzuJfw++PH+vdt?=
 =?us-ascii?Q?JisfGqf9HWPuVTUFQED7CJydb4AU85Q3rT6gmgG84Z4sURK7yvU1lGDtBu/o?=
 =?us-ascii?Q?oVdontJrA/CYPdMvbnis1FjxR5nuOQkQ0rBRHYMUn+SPP9QmBl1MRn3xpV7O?=
 =?us-ascii?Q?0dvBk1Zi74Jd4PVC7pmCsak0jnu6kjRJj0HNL6qujsWWKI6iDY2rLFd/f/Ml?=
 =?us-ascii?Q?QehFr0kZD32dcGei/ILpSmJEMv9vMl8VcXuLcR7Ai8T+6CcWlvm2IvoARC86?=
 =?us-ascii?Q?I9QYXHDNpWwutMsuxUcBNeNdAwgIOUYZQdrGXppQV34ZKr67aV94CkqyP7Qt?=
 =?us-ascii?Q?IAMqxM87//JHS9C7Cv3skoJbpeW2cCVNHGvJBIsPsVdb26PlAT3v/bPS3eD7?=
 =?us-ascii?Q?WubHZtOmsjlaYvpLKdcn5pl+izbBuIBIPNZe+Y4Ywd/jdh9/BQ6Ijbc7cUuX?=
 =?us-ascii?Q?aCDnPZ9xqUkwpKDQmnug3SUzc+6yog7EBD+Wxn7UOULZ7Nto0+dpl6nIodwm?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9ab74b-3b3a-413c-9721-08dbea777b41
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 09:51:49.6182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3+GR6gf3XR24aCkG7bj4V1LpcK4vNx2ewePqxUBBLACcqesov/y6RiDTUOlLHqEM2wUL8l20qAEzXRQEeOcVBDPe5tQUYK3JfsrM8ffhoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5602
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

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>

---
Changes from v4 to v5:
- Revise commit message.
- Delete RS422 checks within uart_set_rs485_termination().

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

v4: https://lore.kernel.org/all/20231113094136.52003-1-crescentcy.hsieh@moxa.com/
v3: https://lore.kernel.org/all/20231108060719.11775-1-crescentcy.hsieh@moxa.com/
v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/

---
 drivers/tty/serial/serial_core.c |  7 +++++++
 include/uapi/linux/serial.h      | 19 +++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..db1ebed7f 100644
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

