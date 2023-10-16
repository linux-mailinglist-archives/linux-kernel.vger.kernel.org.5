Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45227C9DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjJPDkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJPDjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:39:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2065.outbound.protection.outlook.com [40.107.215.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B7120;
        Sun, 15 Oct 2023 20:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThIxbjOKJ+5QjTM1Q1vsL0KZfIsGIpmt9IlomJQ0TH0NYVMZ3cDzqez1EH/kVwwDk1E4oyZV9JEC756goQ77CY0s8egEGHwmOiVl0HIh86D9YakxXG7tduippiA/1YbrcFZ24rTqegCBj9i60In5h4ypYKffLGHh4hG7MRabJMZMLCo/30c/Mf5gr8tVG6giPERODMBmWKHorDfirVScovlm58qNK7WBjcoIVbIYjJtSoir8TGvPx2vQakC87WU/XJY44UnN1IQe94Un3z/A/+CEpTKXf1S2+tcX5s1rO6dVFp3nIUeId1AeVjwip7hQLbA/hDZnsySqTS/ILmjmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR9UTpJ3xnwtzECatTGjO2kMqAwv1LgOFe7Z4azs6dw=;
 b=L/GdQsppFDof7XPDMgrzWxI7wqlDpcUgHpBWYri17R00NroJ25W6HCj78MkBzH2DJWHNoLZ3WTIo6XGGtGgZifg9uRiJo8mjSLLqYlUik0IqSP19aFW8CXagReyBG6nOI52gceTDmHCu8biXaVdg+EAerklDfa9dpPnhjCU+RjwriJEmsJ/FNWzKmL/HH/JrM2PppYvki4OswH+gNf37WxZRh4P3AJUEPww7R/5XYudcRgJZuWqhv3loc8ZpzGOywD5WlnMpuHrJgm/8ASgqHRAWlHa08liweayAIKU3Tj/R8tLCqDR1vhLAj3So/Hg0xD4WW8zawQsAREWS+aS8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR9UTpJ3xnwtzECatTGjO2kMqAwv1LgOFe7Z4azs6dw=;
 b=f10mk8cDP8i7SYFNN3/zvWN4sLKkDPrZ+HLO2NZP7x1WKlhCLIN3kb86ybGrY91szKZp5mCXnU+IeKfBJiJPfpYS4PAuV2uKSe7J3JBhViWKfeUIndknjIgoTgUVIBRZU4xbAwxtgDatiXfEF3pniApIm0pN7v2ew6Q7aLOXStU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB5156.apcprd01.prod.exchangelabs.com
 (2603:1096:820:d6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 03:39:23 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::3f1:6c0e:dec3:714b%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 03:39:23 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [Patch v2 6/6] tty: serial: 8250: Add support for MOXA PCIe boards to switch interface between RS422/RS485
Date:   Mon, 16 Oct 2023 11:37:05 +0800
Message-Id: <20231016033705.20669-7-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
References: <20231016033705.20669-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR01CA0015.jpnprd01.prod.outlook.com
 (2603:1096:404:a::27) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ea9b08-f5a2-476b-3d4f-08dbcdf97cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAbO4WBplcx2de/jwoOXfLjeFFb9SvlVBJ0dU+yYYpIGr+xrRzYqmYTObrGwFT8gNBk/9cBaRvZ5xH8qAL4xPO0zh6RXiwME8lvOPkjL8LZqpRNHi63KwvsspvsMKHixpHD7w5OjMOBxXSOFfdlK8ZhDiYFkLjc3gh10QLeyK9SJbRZCjwwL1xP1PYp+aj6gihrSqXHUbGar/gidmg6GK5XstkvyEoxSawVarqZ7NPioezE5/TmxsAzqTAmgKkoEBunuMcvVgCk6ZLIfgmiJiaXaO1rbDxIhvLBWGApThmW07EmWB7SdoLKa03sB0EqqXraob8VZsHkxr6OEEBWLSDj30na+5wU2CU7EE6+fBXk+bgNnXFqv8HSrgYDhQgsiFwdTPjIR2bbIB4gcXnnWhR5bGL5Omq66uK89oQPEcl6oanTfSs7s/P9YHqIku7u0AWtaI9cfAO+a3Ng9RSI2sQ4Lv2NSYHxhLhK+OcSR7lsUozs9m0ow/reZKWeoWpvTlFZPEJIvu6HyjDdkfvFOy+5/QnpoWaOjq8F0RNt6mrT71fhV0JXeCPfQvQKX0TDb/3tpCi58XztfXYdatviJgNYJunFyer88LPQnmO6x2k/0CeGXVMgpqKlBllEwJCp0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39850400004)(366004)(376002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(1076003)(26005)(107886003)(2616005)(38100700002)(316002)(52116002)(66946007)(66476007)(66556008)(6486002)(478600001)(6512007)(6666004)(38350700005)(4326008)(8936002)(8676002)(5660300002)(2906002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72lFDRG1boXoKZzAcjnSUAPB4JOEWJqXndMD87jgTS55m2+cbwhtIaObFaHA?=
 =?us-ascii?Q?9OPHFFLvTlhREKDzfuUIvOogFaVeS2dxTG8qxoj/XpjyRx61SpqRd7VypnvP?=
 =?us-ascii?Q?loyqGVWPvk/WOY0x70aE/Zp1lTZ45kechAW9EzdHaaRNGiAXtaikxbXwNoEe?=
 =?us-ascii?Q?vRsrfh92lqRT4Gz2+DX5/tUD3sij/NSpkg5oqhLReW+SQ/WqYhgTSK7AxxyY?=
 =?us-ascii?Q?Z/bkkjFzYGcAJ4wpG0LPdDOgTuT7DgPPrSbWk+Lq99IoBhqUS8HNPz2WSxX7?=
 =?us-ascii?Q?i+JKJi5ozBIcM10pSIuktADnPVEU60j4yf3JM/7IzamqadmylsD44CYrxQQW?=
 =?us-ascii?Q?kISUZiXeBBqCVwYc8eEce4s0lj9EGZMyTQsRyGk/mkd4a2osuN6OluqC6jEo?=
 =?us-ascii?Q?WlYnBYBpQezaJwOglmZni7JxphdYAgY8dpAn4CWjVtmocoOmFnW0nuK1r5JO?=
 =?us-ascii?Q?kNqxsXTtM2E/8EzN60FPvloLXRNenQDA2wL67ZU/noymhH4A1tMHfDdcSTmw?=
 =?us-ascii?Q?aM+g8Hv1mLufzcImD9fg6URkn6034qDNLPXircki576RRvqCBRn5fH5rQYFf?=
 =?us-ascii?Q?K52rjuZvPYbfamQEVyMZbhlWzXfsNM404NgxOcDBCnMtdqg5FiP/surLG2Ue?=
 =?us-ascii?Q?6Wh7hfR7wgJryEsBAiUIfPfTi0pvcP440vwJvcNz8Cark9YzD+lmamyEoIIS?=
 =?us-ascii?Q?N4yxvJXTqzitnYSh003X4kXOxZiylf8BXXANjG0lYtD9jeetnV71r4wdyKl3?=
 =?us-ascii?Q?qzejCEgprf/N/VVNOUckGAow9iqk/rPL8/U0AF/F7UoYvJ/Rv47uNODCnh/l?=
 =?us-ascii?Q?RT9K/ENB/4037eFKKI7B9/YCwDiGFbh0wLftCvznkFfXltmCma4Gka1ZdLrH?=
 =?us-ascii?Q?WlFIiNRMkltOZoyPe+BSn6jABVu6aaFDQ5scT/LdEcQ57TT/fidkEjw1IBcw?=
 =?us-ascii?Q?XO1j29yY2Yb5wvE8Qd06GkwRA0PwP6Bu/l7fF+erICcuhRBaC2rrQOEx3fBT?=
 =?us-ascii?Q?MGk+qT94VYebRvCEsqrSadouLJur2f4cDgoe0j5zRLRC9QJs2E2HuN5bDLWu?=
 =?us-ascii?Q?3czHpJ0o/2dWf8NumHVdSzbmWg6xV6Igy7L7/Ao+YHifi/rmiWhxc2zCoROu?=
 =?us-ascii?Q?EuS5MOwM6FOFnw2rgkqCyg77A2/6oVBB4b/xQ0YeCous1DiyAWdwL73yDTvS?=
 =?us-ascii?Q?UIqUCrbUxxOIm4uSo81ApetH9c2rb8Jri146YKOkYFl/tXNa68Na65qRPmKg?=
 =?us-ascii?Q?wTF8mWCtDzv0TquNpVWGR7Gx9iEu+etXKAAIGrKDtnJ4V6jMxGJZFzRopHXh?=
 =?us-ascii?Q?LfRSfBJfWxkSqwSgVeR4g5vTkxwXEwpJAgQs9C7NQOeUI58cGjeEQ5xqrjRA?=
 =?us-ascii?Q?55LJ50Su8e0v3gs9l9lLSNEb4Zek+wBfRtwWtmdzrxZ5On/Wcb9XVOBRn3dz?=
 =?us-ascii?Q?U7EQzzVEzfbqYhBwqufOtZElk5JMs8XAlYQ8RNa+BZs8uD54Rk2v1x5rrxy7?=
 =?us-ascii?Q?yJuvfV4BUzb09K7L1v9IYkTj97GvVoBFQXnNlpInRJbaeBBhYh+IeAUPfotD?=
 =?us-ascii?Q?b3cd0lyQVf2Y0+PvG+LnLZkccotHqNHS326XGgL+2vlubT+w5i9RKjD2KPUY?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea9b08-f5a2-476b-3d4f-08dbcdf97cf9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 03:39:23.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kpVAxFrCCpnEOGBdbbUb0h9+1QJoJhsowgyYMzoy9AqAVYSHTTkDPkqDuhPy+2sX9sUo71OrYCRZ39UKhf/Mr8Crou1lr30WAXeQTMzDrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5156
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MOXA PCIe boards have 4 serial interfaces and don't require additional
stuff to switch between interfaces:

- RS232
- RS422
- RS485_2W (half-duplex)
- RS485_4W (full-duplex)

By using ioctl command "TIOCRS485", it can switch between default
interface and RS485 if supported.

That means, for RS422/RS485 board, it can switch between RS422 and
RS485 by setting the flags within struct serial_rs485.

However, for the RS232/RS422/RS485 board, it can only switch between
RS232 and RS485, there's no flag for switching interface into RS422.

This patch uses "SER_RS485_TERMINATE_BUS" to represent RS422 as a
workaround solution.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 72dd27141801..e2e8a28242bc 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1976,6 +1976,10 @@ pci_sunix_setup(struct serial_private *priv,
 #define MOXA_RS485_2W	0x0F
 #define MOXA_UIR_OFFSET	0x04
 
+static const struct serial_rs485 pci_moxa_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX | SER_RS485_TERMINATE_BUS,
+};
+
 static bool pci_moxa_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N	||
@@ -1989,6 +1993,11 @@ static bool pci_moxa_is_mini_pcie(unsigned short device)
 	return false;
 }
 
+static bool pci_moxa_match_x1xx(unsigned short device)
+{
+	return (device & 0x0F00) == 0x0100;
+}
+
 static bool pci_moxa_match_x3xx(unsigned short device)
 {
 	return (device & 0x0F00) == 0x0300;
@@ -2016,6 +2025,36 @@ static int pci_moxa_set_interface(const struct pci_dev *dev,
 	return 0;
 }
 
+static int pci_moxa_rs485_config(struct uart_port *port,
+				 struct ktermios *termios,
+				 struct serial_rs485 *rs485)
+{
+	struct pci_dev *dev = to_pci_dev(port->dev);
+	unsigned short device = dev->device;
+	u8 mode = MOXA_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		/* Use SER_RS485_TERMINATE_BUS to represent RS422 as a workaround. */
+		if (rs485->flags & SER_RS485_TERMINATE_BUS) {
+			mode = MOXA_RS422;
+		} else {
+			if (rs485->flags & SER_RS485_RX_DURING_TX)
+				mode = MOXA_RS485_4W;
+			else
+				mode = MOXA_RS485_2W;
+		}
+	} else {
+		/*
+		 * RS232 is not supported for those device IDs of
+		 * MOXA PCIe boards match the pattern 0x*3**.
+		 */
+		if (pci_moxa_match_x3xx(device))
+			return -EINVAL;
+	}
+
+	return pci_moxa_set_interface(dev, port->port_id, mode);
+}
+
 static int pci_moxa_init(struct pci_dev *dev)
 {
 	unsigned short device = dev->device;
@@ -2055,9 +2094,22 @@ pci_moxa_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
 		struct uart_8250_port *port, int idx)
 {
+	struct pci_dev *dev = priv->dev;
+	unsigned short device = dev->device;
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	/*
+	 * For the device IDs of MOXA PCIe boards match the pattern 0x*1** and 0x*3**,
+	 * these boards support switching interface between RS422/RS485 using TIOCSRS485.
+	 */
+	if (pci_moxa_match_x1xx(device) || pci_moxa_match_x3xx(device)) {
+		port->port.rs485_config = pci_moxa_rs485_config;
+		port->port.rs485_supported = pci_moxa_rs485_supported;
+
+		if (pci_moxa_match_x3xx(device))
+			port->port.rs485.flags |= SER_RS485_ENABLED | SER_RS485_TERMINATE_BUS;
+	}
 	if (board->num_ports == 4 && idx == 3)
 		offset = 7 * board->uart_offset;
 	else
-- 
2.34.1

