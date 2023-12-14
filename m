Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F238134A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573774AbjLNPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:27 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2076.outbound.protection.outlook.com [40.92.45.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B11121;
        Thu, 14 Dec 2023 07:24:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbXGhqgcN+iJ5R9wU91MYvxkLzrX3pkSMxXiJ1v4+y9L9LXFeuWgbFY1UALKWRHQQqRCgbc6D9SPDu/PzcnSV8DHsDmnkUFDcqIj1yPE/YoY4qjwMArmkEL7+/5uExhEoYQEginV3Sxg6RSGzP9tYOjW0Jl+S1e1uW6YyzhR12VE/XEpxIZtWXNJ5lmqFsCACUYJk6em9WcPzqepS1znHPy+U0d1Lpx/I92g+3F4cCpFHUHKJlkFupKxP022qJule9akPlnb0qBdXZKu+gu7ms4LB4U36AeVdHUlKtMPj0st6budDDLbfsdUzc9XNziARoUTGS+XfXtW2wNKi+GJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7yMGmJPf/ciT7u0tPHKNZeyuMXes10fiJ4zu0h/8X8=;
 b=YfzPjE5UeC0XZPKMnAqkftahQHGj8hL+84zm1Iarc23C9KJ2bFbz3DOtm+YmRoL9EDF3Ti2Mcb29l9Vx8Sc8w7CKQLqA9TpUSNWR92BoEi7uXyKIRglepphDMPsmx2Z7FlIz/eUXho24ENW8ZRzRh7XUQu9+x9DJNj5aNRP/QH8Uo+hJUkHRyo1Y38ecuiF/6pqlark0vY+WGp8A+DNF2Z8Ps2nbuZ0WTa2QRVTCjljrad5LLWo9y39ct4Mu8UrkZk4iGP+WIhh46dAZoPLPbq5T2p/rptM2N+4Tj4m6Rx2oDphQBdNB25iSI4LzNOVIXOuUAvqb9U2sfOyw8iKMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7yMGmJPf/ciT7u0tPHKNZeyuMXes10fiJ4zu0h/8X8=;
 b=kkkg3i+H2LEKf6uobYlsd6uO0StgVOO3wxP48dYj8lbDtkEEeg2Ia1DvjoN0vu9Vvz43JiJAIRS5gyA1NRF1TEns1CSz7Jyy+3SbYDUUgPX0p2ihjuu1PuqxCJOqGuJ4iDdYIqVvfUVLt0AXwpEO3YN6i9TxTEo6RLTR2HiRq0c0GaIZzVZXwSq8NrdYxZwWtdz97Fpg3oAHD/0DzBPqUQu54yOfmiIOvw3R3MEwct0CHIgiUizE7cKCyxnpnd0A8j+iJEar1YO3uahy/QR32wJQukFuGYBAvk15jb3WVkBHKi7WsAjfwDpz8V2mMbKQLZLSEHg0z/cmKe/t5BBkjg==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB5702.namprd03.prod.outlook.com (2603:10b6:510:41::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:24:28 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:24:28 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 1/5] ptp: clockmatrix: support 32-bit address space
Date:   Thu, 14 Dec 2023 10:24:11 -0500
Message-ID: <PH7PR03MB706457106BF922439573DF38A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ouWZnYprU4J9ObWtF/5bUysiv0RAf7iJOGbgSxf/Q+8=]
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214152415.14785-1-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e384250-a15b-40d5-812c-08dbfcb8c288
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldwTaC8HETtQbU3YrZ292WXAxLC6uCBBt/LjR7Cw0uYz1PpSCZCPVp7DnWA/UcOCTUKEjzffzdDCGSsVNszH4RQYD33rqS2E5bxjMZb1M5zteeNJ2EeQIUY+TVJaPxi0GzaNYhKSN1HLT5y/K+F/IuMXc2jMu9krkq3Jcpn3xIv9VHQ35Tqi1mht43fBzQLsXxpzbDtsc9d6nkRK0kISUsuDf/KsnHLNU7m+E1xKoauY52TsL42/gN+vqc6SF/gmepde/QRnuitPImv1iZo3Gtyg1muLxsxlD+OfCgA5Ibj7FWtKF9yj50jD1fbJX1Er1m5DiygB2x/82KgarBNB5KcQu9Hmoe9V+w9dQS5aveFUeYGMG0PosdR1rsGIIA8Oa3SlXLL4AF36csDARNHMDiNzacZ/2PeXl7wtMTkUl0QWzpBmvyGLA/tjmdBH0QmaHEXGbUyVFf3F4QBadQbHy6BXzHpl7W/CilnAB/E4kgAk6+KUvMB4kk7ORLCB+jFvaP8Rb2xroTBDntiXmEZ5gbIN5XBtLqCMRdym2ky6yIwKiWkjIXiK1xpxJ+Jsa8ZP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?55wpS38/I40SVmjamrcd1wS/W1X4RZMWiU+EvX4SfhQ6oHTwcZldsxdDOPVv?=
 =?us-ascii?Q?jPGJACyUwQfTM36cqiBsrk2IZa5V6ua3PSifPNyggJR1EqJWGacucarlq7KB?=
 =?us-ascii?Q?vSexVBAgrlBubGGGGRj+Wd3eaQieeaiQjqbIGnTQ1AZpyPiz9i22qe7YfERO?=
 =?us-ascii?Q?QK3cH7ICsd8FHY+7VUQcyd9ElusjSPOusIA3zCRvoBrkTAuD60EG88/8O00E?=
 =?us-ascii?Q?pq+zpNSm3BDopghH3OYzyAjEc/MIDJRImdxoyYC8XFMDi8V6ge1HxpPcXY+R?=
 =?us-ascii?Q?XAaPCvE4uLvEA0y94c/WIA49cwSoOMz09u9HpGf4h9xjd6l4J0lELvsXV/N6?=
 =?us-ascii?Q?Hx+e31q1L9cb/sfZz21DgvmOGdE2MT+uInqgACYsIWYFt3ord8TtyNOKrPMu?=
 =?us-ascii?Q?686zrncXZFeX4JzJ06fQ8BbjW2y1aVi+UbKih4q8OkZbxr0LfePtyLIouy1W?=
 =?us-ascii?Q?1fPH8lxRCd2SupkyG+byJrMdOJOcsqtRQDjoJeV02AjxIUtsV9UepgpP/eii?=
 =?us-ascii?Q?Ytqv4s6wmIVLKFgHqvyh74ejY+fpjqVWv7/TAdi9gUfjlmFPZKRk0415VTtc?=
 =?us-ascii?Q?kcx9psrA1pXb6gG0QbRolfR+o407vzgAUWRSwLSJyZH7k/iiiphAzXQb89nu?=
 =?us-ascii?Q?pzIlm63Iq2074n5bhTIZYCS3GUPbPhJibH+qTFndpTOUJCxcoUAV0W06XP77?=
 =?us-ascii?Q?R0A766ZMam5irlOxDcdd9V80cnZg+zRX0E33iProOUdZFY89kJqA8NIVTMYx?=
 =?us-ascii?Q?jriS7gu3NRCqfLAWNdMDvA0SM53vxdSF+7pk7ffrbFEI5/T7BVgw3tacb3RC?=
 =?us-ascii?Q?jCgFIfDSO5Y3BSwDXAPYOzZcxg4CgxuYsnY7VCJG1tza49nCDo8q23As+cI5?=
 =?us-ascii?Q?AK3rUMNyfLXJ9JnTcS6YqlXsx+03sXi4AgCdU3LNWpav1q9fwmTJJJCAS8tz?=
 =?us-ascii?Q?BW0nkd4q/5FYh8NVMwZ5g4PYpmBFKEurb0WyAvd1SvqZgs95XDFmuntuTzHW?=
 =?us-ascii?Q?8FLOC34mL729LZn/yCYOkrN9lxEJWnxTfZTvcQHr4zvNWw0BXx4cbRhZ5FDb?=
 =?us-ascii?Q?CYUfkvQI5gvKZ7HZZ6lRc/n2lSlA0CoMbg6rxnCpkJK55CW6PJnrW4sL4h1H?=
 =?us-ascii?Q?codCAXQ3HRnSQ2iGSndSOlyqXSIqC1We9tM6NJBXXAiucwZ7TwQcdS+w+0vO?=
 =?us-ascii?Q?nxiPRCKskPitbkqAd6Yj6Sq7pwTuLG7ZD8Gw0w=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e384250-a15b-40d5-812c-08dbfcb8c288
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:24:27.7870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5702
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Li <min.li.xe@renesas.com>

We used to assume 0x2010xxxx address. Now that
we need to access 0x2011xxxx address, we need
to support read/write the whole 32-bit address space.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
- Drop MAX_ABS_WRITE_PHASE_PICOSECONDS advised by Rahul
- Apply SCSR_ADDR to scrach register in idtcm_load_firmware advised by Simon
- Apply u32 to base in idtcm_output_enable advised by Simon
- Correct sync_ctrl0/1 parameter position for idtcm_write advised by Simon
- Restore adjphase function suggested by Rahul
- Separate unrelated stuff to patches suggested by Paolo
- Squash commits and add missing commit msg suggested by Jakub

 drivers/ptp/ptp_clockmatrix.c    |  59 ++--
 drivers/ptp/ptp_clockmatrix.h    |  32 +-
 include/linux/mfd/idt8a340_reg.h | 542 ++++++++++++++++---------------
 3 files changed, 317 insertions(+), 316 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f6f9d4adce04..f8556627befa 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -41,8 +41,8 @@ module_param(firmware, charp, 0);
 static int _idtcm_adjfine(struct idtcm_channel *channel, long scaled_ppm);
 
 static inline int idtcm_read(struct idtcm *idtcm,
-			     u16 module,
-			     u16 regaddr,
+			     u32 module,
+			     u32 regaddr,
 			     u8 *buf,
 			     u16 count)
 {
@@ -50,8 +50,8 @@ static inline int idtcm_read(struct idtcm *idtcm,
 }
 
 static inline int idtcm_write(struct idtcm *idtcm,
-			      u16 module,
-			      u16 regaddr,
+			      u32 module,
+			      u32 regaddr,
 			      u8 *buf,
 			      u16 count)
 {
@@ -62,7 +62,8 @@ static int contains_full_configuration(struct idtcm *idtcm,
 				       const struct firmware *fw)
 {
 	struct idtcm_fwrc *rec = (struct idtcm_fwrc *)fw->data;
-	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
+	u16 scratch = SCSR_ADDR(IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH));
+	u16 gpio_control = SCSR_ADDR(GPIO_USER_CONTROL);
 	s32 full_count;
 	s32 count = 0;
 	u16 regaddr;
@@ -70,8 +71,8 @@ static int contains_full_configuration(struct idtcm *idtcm,
 	s32 len;
 
 	/* 4 bytes skipped every 0x80 */
-	full_count = (scratch - GPIO_USER_CONTROL) -
-		     ((scratch >> 7) - (GPIO_USER_CONTROL >> 7)) * 4;
+	full_count = (scratch - gpio_control) -
+		     ((scratch >> 7) - (gpio_control >> 7)) * 4;
 
 	/* If the firmware contains 'full configuration' SM_RESET can be used
 	 * to ensure proper configuration.
@@ -88,7 +89,7 @@ static int contains_full_configuration(struct idtcm *idtcm,
 		rec++;
 
 		/* Top (status registers) and bottom are read-only */
-		if (regaddr < GPIO_USER_CONTROL || regaddr >= scratch)
+		if (regaddr < gpio_control || regaddr >= scratch)
 			continue;
 
 		/* Page size 128, last 4 bytes of page skipped */
@@ -506,8 +507,8 @@ static int _sync_pll_output(struct idtcm *idtcm,
 {
 	int err;
 	u8 val;
-	u16 sync_ctrl0;
-	u16 sync_ctrl1;
+	u32 sync_ctrl0;
+	u32 sync_ctrl1;
 	u8 temp;
 
 	if (qn == 0 && qn_plus_1 == 0)
@@ -553,11 +554,11 @@ static int _sync_pll_output(struct idtcm *idtcm,
 	val = SYNCTRL1_MASTER_SYNC_RST;
 
 	/* Place master sync in reset */
-	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
+	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
 	if (err)
 		return err;
 
-	err = idtcm_write(idtcm, 0, sync_ctrl0, &sync_src, sizeof(sync_src));
+	err = idtcm_write(idtcm, sync_ctrl0, 0, &sync_src, sizeof(sync_src));
 	if (err)
 		return err;
 
@@ -570,27 +571,27 @@ static int _sync_pll_output(struct idtcm *idtcm,
 	if (qn_plus_1)
 		val |= SYNCTRL1_Q1_DIV_SYNC_TRIG;
 
-	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
+	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
 	if (err)
 		return err;
 
 	/* PLL5 can have OUT8 as second additional output. */
 	if (pll == 5 && qn_plus_1 != 0) {
-		err = idtcm_read(idtcm, 0, HW_Q8_CTRL_SPARE,
+		err = idtcm_read(idtcm, HW_Q8_CTRL_SPARE, 0,
 				 &temp, sizeof(temp));
 		if (err)
 			return err;
 
 		temp &= ~(Q9_TO_Q8_SYNC_TRIG);
 
-		err = idtcm_write(idtcm, 0, HW_Q8_CTRL_SPARE,
+		err = idtcm_write(idtcm, HW_Q8_CTRL_SPARE, 0,
 				  &temp, sizeof(temp));
 		if (err)
 			return err;
 
 		temp |= Q9_TO_Q8_SYNC_TRIG;
 
-		err = idtcm_write(idtcm, 0, HW_Q8_CTRL_SPARE,
+		err = idtcm_write(idtcm, HW_Q8_CTRL_SPARE, 0,
 				  &temp, sizeof(temp));
 		if (err)
 			return err;
@@ -598,21 +599,21 @@ static int _sync_pll_output(struct idtcm *idtcm,
 
 	/* PLL6 can have OUT11 as second additional output. */
 	if (pll == 6 && qn_plus_1 != 0) {
-		err = idtcm_read(idtcm, 0, HW_Q11_CTRL_SPARE,
+		err = idtcm_read(idtcm, HW_Q11_CTRL_SPARE, 0,
 				 &temp, sizeof(temp));
 		if (err)
 			return err;
 
 		temp &= ~(Q10_TO_Q11_SYNC_TRIG);
 
-		err = idtcm_write(idtcm, 0, HW_Q11_CTRL_SPARE,
+		err = idtcm_write(idtcm, HW_Q11_CTRL_SPARE, 0,
 				  &temp, sizeof(temp));
 		if (err)
 			return err;
 
 		temp |= Q10_TO_Q11_SYNC_TRIG;
 
-		err = idtcm_write(idtcm, 0, HW_Q11_CTRL_SPARE,
+		err = idtcm_write(idtcm, HW_Q11_CTRL_SPARE, 0,
 				  &temp, sizeof(temp));
 		if (err)
 			return err;
@@ -620,7 +621,7 @@ static int _sync_pll_output(struct idtcm *idtcm,
 
 	/* Place master sync out of reset */
 	val &= ~(SYNCTRL1_MASTER_SYNC_RST);
-	err = idtcm_write(idtcm, 0, sync_ctrl1, &val, sizeof(val));
+	err = idtcm_write(idtcm, sync_ctrl1, 0, &val, sizeof(val));
 
 	return err;
 }
@@ -637,7 +638,7 @@ static int idtcm_sync_pps_output(struct idtcm_channel *channel)
 	u8 temp;
 	u16 output_mask = channel->output_mask;
 
-	err = idtcm_read(idtcm, 0, HW_Q8_CTRL_SPARE,
+	err = idtcm_read(idtcm, HW_Q8_CTRL_SPARE, 0,
 			 &temp, sizeof(temp));
 	if (err)
 		return err;
@@ -646,7 +647,7 @@ static int idtcm_sync_pps_output(struct idtcm_channel *channel)
 	    Q9_TO_Q8_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK)
 		out8_mux = 1;
 
-	err = idtcm_read(idtcm, 0, HW_Q11_CTRL_SPARE,
+	err = idtcm_read(idtcm, HW_Q11_CTRL_SPARE, 0,
 			 &temp, sizeof(temp));
 	if (err)
 		return err;
@@ -1253,7 +1254,7 @@ static void display_pll_and_masks(struct idtcm *idtcm)
 static int idtcm_load_firmware(struct idtcm *idtcm,
 			       struct device *dev)
 {
-	u16 scratch = IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH);
+	u16 scratch = SCSR_ADDR(IDTCM_FW_REG(idtcm->fw_ver, V520, SCRATCH));
 	char fname[128] = FW_FILENAME;
 	const struct firmware *fw;
 	struct idtcm_fwrc *rec;
@@ -1303,14 +1304,14 @@ static int idtcm_load_firmware(struct idtcm *idtcm,
 			err = 0;
 
 			/* Top (status registers) and bottom are read-only */
-			if (regaddr < GPIO_USER_CONTROL || regaddr >= scratch)
+			if (regaddr < SCSR_ADDR(GPIO_USER_CONTROL) || regaddr >= scratch)
 				continue;
 
 			/* Page size 128, last 4 bytes of page skipped */
 			if ((loaddr > 0x7b && loaddr <= 0x7f) || loaddr > 0xfb)
 				continue;
 
-			err = idtcm_write(idtcm, regaddr, 0, &val, sizeof(val));
+			err = idtcm_write(idtcm, SCSR_BASE, regaddr, &val, sizeof(val));
 		}
 
 		if (err)
@@ -1340,7 +1341,7 @@ static int idtcm_output_enable(struct idtcm_channel *channel,
 		return base;
 	}
 
-	err = idtcm_read(idtcm, (u16)base, OUT_CTRL_1, &val, sizeof(val));
+	err = idtcm_read(idtcm, (u32)base, OUT_CTRL_1, &val, sizeof(val));
 	if (err)
 		return err;
 
@@ -1349,7 +1350,7 @@ static int idtcm_output_enable(struct idtcm_channel *channel,
 	else
 		val &= ~SQUELCH_DISABLE;
 
-	return idtcm_write(idtcm, (u16)base, OUT_CTRL_1, &val, sizeof(val));
+	return idtcm_write(idtcm, (u32)base, OUT_CTRL_1, &val, sizeof(val));
 }
 
 static int idtcm_perout_enable(struct idtcm_channel *channel,
@@ -1713,10 +1714,10 @@ static s32 idtcm_getmaxphase(struct ptp_clock_info *ptp __always_unused)
 static int _idtcm_adjphase(struct idtcm_channel *channel, s32 delta_ns)
 {
 	struct idtcm *idtcm = channel->idtcm;
-	int err;
-	u8 i;
 	u8 buf[4] = {0};
 	s32 phase_50ps;
+	int err;
+	u8 i;
 
 	if (channel->mode != PTP_PLL_MODE_WRITE_PHASE) {
 		err = channel->configure_write_phase(channel);
diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
index 7c17c4f7f573..ad39dc6decdf 100644
--- a/drivers/ptp/ptp_clockmatrix.h
+++ b/drivers/ptp/ptp_clockmatrix.h
@@ -54,21 +54,9 @@
 #define LOCK_TIMEOUT_MS			(2000)
 #define LOCK_POLL_INTERVAL_MS		(10)
 
-#define IDTCM_MAX_WRITE_COUNT		(512)
-
 #define PHASE_PULL_IN_MAX_PPB		(144000)
 #define PHASE_PULL_IN_MIN_THRESHOLD_NS	(2)
 
-/*
- * Return register address based on passed in firmware version
- */
-#define IDTCM_FW_REG(FW, VER, REG)	(((FW) < (VER)) ? (REG) : (REG##_##VER))
-enum fw_version {
-	V_DEFAULT = 0,
-	V487 = 1,
-	V520 = 2,
-};
-
 /* PTP PLL Mode */
 enum ptp_pll_mode {
 	PTP_PLL_MODE_MIN = 0,
@@ -84,16 +72,16 @@ struct idtcm_channel {
 	struct ptp_clock_info	caps;
 	struct ptp_clock	*ptp_clock;
 	struct idtcm		*idtcm;
-	u16			dpll_phase;
-	u16			dpll_freq;
-	u16			dpll_n;
-	u16			dpll_ctrl_n;
-	u16			dpll_phase_pull_in;
-	u16			tod_read_primary;
-	u16			tod_read_secondary;
-	u16			tod_write;
-	u16			tod_n;
-	u16			hw_dpll_n;
+	u32			dpll_phase;
+	u32			dpll_freq;
+	u32			dpll_n;
+	u32			dpll_ctrl_n;
+	u32			dpll_phase_pull_in;
+	u32			tod_read_primary;
+	u32			tod_read_secondary;
+	u32			tod_write;
+	u32			tod_n;
+	u32			hw_dpll_n;
 	u8			sync_src;
 	enum ptp_pll_mode	mode;
 	int			(*configure_write_frequency)(struct idtcm_channel *channel);
diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index 0c706085c205..b680a0eb5f68 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -7,20 +7,20 @@
 #ifndef HAVE_IDT8A340_REG
 #define HAVE_IDT8A340_REG
 
-#define PAGE_ADDR_BASE                    0x0000
-#define PAGE_ADDR                         0x00fc
+#define SCSR_BASE			  0x20100000
+#define SCSR_ADDR(x)			  ((x) & 0xffff)
 
-#define HW_REVISION                       0x8180
+#define HW_REVISION                       0x20108180
 #define REV_ID                            0x007a
 
-#define HW_DPLL_0                         (0x8a00)
-#define HW_DPLL_1                         (0x8b00)
-#define HW_DPLL_2                         (0x8c00)
-#define HW_DPLL_3                         (0x8d00)
-#define HW_DPLL_4                         (0x8e00)
-#define HW_DPLL_5                         (0x8f00)
-#define HW_DPLL_6                         (0x9000)
-#define HW_DPLL_7                         (0x9100)
+#define HW_DPLL_0                         (0x20108a00)
+#define HW_DPLL_1                         (0x20108b00)
+#define HW_DPLL_2                         (0x20108c00)
+#define HW_DPLL_3                         (0x20108d00)
+#define HW_DPLL_4                         (0x20108e00)
+#define HW_DPLL_5                         (0x20108f00)
+#define HW_DPLL_6                         (0x20109000)
+#define HW_DPLL_7                         (0x20109100)
 
 #define HW_DPLL_TOD_SW_TRIG_ADDR__0       (0x080)
 #define HW_DPLL_TOD_CTRL_1                (0x089)
@@ -28,22 +28,22 @@
 #define HW_DPLL_TOD_OVR__0                (0x098)
 #define HW_DPLL_TOD_OUT_0__0              (0x0B0)
 
-#define HW_Q0_Q1_CH_SYNC_CTRL_0           (0xa740)
-#define HW_Q0_Q1_CH_SYNC_CTRL_1           (0xa741)
-#define HW_Q2_Q3_CH_SYNC_CTRL_0           (0xa742)
-#define HW_Q2_Q3_CH_SYNC_CTRL_1           (0xa743)
-#define HW_Q4_Q5_CH_SYNC_CTRL_0           (0xa744)
-#define HW_Q4_Q5_CH_SYNC_CTRL_1           (0xa745)
-#define HW_Q6_Q7_CH_SYNC_CTRL_0           (0xa746)
-#define HW_Q6_Q7_CH_SYNC_CTRL_1           (0xa747)
-#define HW_Q8_CH_SYNC_CTRL_0              (0xa748)
-#define HW_Q8_CH_SYNC_CTRL_1              (0xa749)
-#define HW_Q9_CH_SYNC_CTRL_0              (0xa74a)
-#define HW_Q9_CH_SYNC_CTRL_1              (0xa74b)
-#define HW_Q10_CH_SYNC_CTRL_0             (0xa74c)
-#define HW_Q10_CH_SYNC_CTRL_1             (0xa74d)
-#define HW_Q11_CH_SYNC_CTRL_0             (0xa74e)
-#define HW_Q11_CH_SYNC_CTRL_1             (0xa74f)
+#define HW_Q0_Q1_CH_SYNC_CTRL_0           (0x2010a740)
+#define HW_Q0_Q1_CH_SYNC_CTRL_1           (0x2010a741)
+#define HW_Q2_Q3_CH_SYNC_CTRL_0           (0x2010a742)
+#define HW_Q2_Q3_CH_SYNC_CTRL_1           (0x2010a743)
+#define HW_Q4_Q5_CH_SYNC_CTRL_0           (0x2010a744)
+#define HW_Q4_Q5_CH_SYNC_CTRL_1           (0x2010a745)
+#define HW_Q6_Q7_CH_SYNC_CTRL_0           (0x2010a746)
+#define HW_Q6_Q7_CH_SYNC_CTRL_1           (0x2010a747)
+#define HW_Q8_CH_SYNC_CTRL_0              (0x2010a748)
+#define HW_Q8_CH_SYNC_CTRL_1              (0x2010a749)
+#define HW_Q9_CH_SYNC_CTRL_0              (0x2010a74a)
+#define HW_Q9_CH_SYNC_CTRL_1              (0x2010a74b)
+#define HW_Q10_CH_SYNC_CTRL_0             (0x2010a74c)
+#define HW_Q10_CH_SYNC_CTRL_1             (0x2010a74d)
+#define HW_Q11_CH_SYNC_CTRL_0             (0x2010a74e)
+#define HW_Q11_CH_SYNC_CTRL_1             (0x2010a74f)
 
 #define SYNC_SOURCE_DPLL0_TOD_PPS	0x14
 #define SYNC_SOURCE_DPLL1_TOD_PPS	0x15
@@ -58,8 +58,8 @@
 #define SYNCTRL1_Q1_DIV_SYNC_TRIG	BIT(1)
 #define SYNCTRL1_Q0_DIV_SYNC_TRIG	BIT(0)
 
-#define HW_Q8_CTRL_SPARE  (0xa7d4)
-#define HW_Q11_CTRL_SPARE (0xa7ec)
+#define HW_Q8_CTRL_SPARE  (0x2010a7d4)
+#define HW_Q11_CTRL_SPARE (0x2010a7ec)
 
 /**
  * Select FOD5 as sync_trigger for Q8 divider.
@@ -95,12 +95,12 @@
  */
 #define Q10_TO_Q11_FANOUT_AND_CLOCK_SYNC_ENABLE_MASK  (BIT(0) | BIT(2))
 
-#define RESET_CTRL                        0xc000
+#define RESET_CTRL                        0x2010c000
 #define SM_RESET                          0x0012
 #define SM_RESET_V520                     0x0013
 #define SM_RESET_CMD                      0x5A
 
-#define GENERAL_STATUS                    0xc014
+#define GENERAL_STATUS                    0x2010c014
 #define BOOT_STATUS                       0x0000
 #define HW_REV_ID                         0x000A
 #define BOND_ID                           0x000B
@@ -115,7 +115,7 @@
 #define PRODUCT_ID                        0x001e
 #define OTP_SCSR_CONFIG_SELECT            0x0022
 
-#define STATUS                            0xc03c
+#define STATUS                            0x2010c03c
 #define DPLL0_STATUS			  0x0018
 #define DPLL1_STATUS			  0x0019
 #define DPLL2_STATUS			  0x001a
@@ -138,60 +138,62 @@
 #define USER_GPIO0_TO_7_STATUS            0x008a
 #define USER_GPIO8_TO_15_STATUS           0x008b
 
-#define GPIO_USER_CONTROL                 0xc160
+#define GPIO_USER_CONTROL                 0x2010c160
 #define GPIO0_TO_7_OUT                    0x0000
 #define GPIO8_TO_15_OUT                   0x0001
 #define GPIO0_TO_7_OUT_V520               0x0002
 #define GPIO8_TO_15_OUT_V520              0x0003
 
-#define STICKY_STATUS_CLEAR               0xc164
-
-#define GPIO_TOD_NOTIFICATION_CLEAR       0xc16c
-
-#define ALERT_CFG                         0xc188
-
-#define SYS_DPLL_XO                       0xc194
-
-#define SYS_APLL                          0xc19c
-
-#define INPUT_0                           0xc1b0
-#define INPUT_1                           0xc1c0
-#define INPUT_2                           0xc1d0
-#define INPUT_3                           0xc200
-#define INPUT_4                           0xc210
-#define INPUT_5                           0xc220
-#define INPUT_6                           0xc230
-#define INPUT_7                           0xc240
-#define INPUT_8                           0xc250
-#define INPUT_9                           0xc260
-#define INPUT_10                          0xc280
-#define INPUT_11                          0xc290
-#define INPUT_12                          0xc2a0
-#define INPUT_13                          0xc2b0
-#define INPUT_14                          0xc2c0
-#define INPUT_15                          0xc2d0
-
-#define REF_MON_0                         0xc2e0
-#define REF_MON_1                         0xc2ec
-#define REF_MON_2                         0xc300
-#define REF_MON_3                         0xc30c
-#define REF_MON_4                         0xc318
-#define REF_MON_5                         0xc324
-#define REF_MON_6                         0xc330
-#define REF_MON_7                         0xc33c
-#define REF_MON_8                         0xc348
-#define REF_MON_9                         0xc354
-#define REF_MON_10                        0xc360
-#define REF_MON_11                        0xc36c
-#define REF_MON_12                        0xc380
-#define REF_MON_13                        0xc38c
-#define REF_MON_14                        0xc398
-#define REF_MON_15                        0xc3a4
-
-#define DPLL_0                            0xc3b0
+#define STICKY_STATUS_CLEAR               0x2010c164
+
+#define GPIO_TOD_NOTIFICATION_CLEAR       0x2010c16c
+
+#define ALERT_CFG                         0x2010c188
+
+#define SYS_DPLL_XO                       0x2010c194
+
+#define SYS_APLL                          0x2010c19c
+
+#define INPUT_0                           0x2010c1b0
+#define INPUT_1                           0x2010c1c0
+#define INPUT_2                           0x2010c1d0
+#define INPUT_3                           0x2010c200
+#define INPUT_4                           0x2010c210
+#define INPUT_5                           0x2010c220
+#define INPUT_6                           0x2010c230
+#define INPUT_7                           0x2010c240
+#define INPUT_8                           0x2010c250
+#define INPUT_9                           0x2010c260
+#define INPUT_10                          0x2010c280
+#define INPUT_11                          0x2010c290
+#define INPUT_12                          0x2010c2a0
+#define INPUT_13                          0x2010c2b0
+#define INPUT_14                          0x2010c2c0
+#define INPUT_15                          0x2010c2d0
+
+#define REF_MON_0                         0x2010c2e0
+#define REF_MON_1                         0x2010c2ec
+#define REF_MON_2                         0x2010c300
+#define REF_MON_3                         0x2010c30c
+#define REF_MON_4                         0x2010c318
+#define REF_MON_5                         0x2010c324
+#define REF_MON_6                         0x2010c330
+#define REF_MON_7                         0x2010c33c
+#define REF_MON_8                         0x2010c348
+#define REF_MON_9                         0x2010c354
+#define REF_MON_10                        0x2010c360
+#define REF_MON_11                        0x2010c36c
+#define REF_MON_12                        0x2010c380
+#define REF_MON_13                        0x2010c38c
+#define REF_MON_14                        0x2010c398
+#define REF_MON_15                        0x2010c3a4
+
+#define DPLL_0                            0x2010c3b0
 #define DPLL_CTRL_REG_0                   0x0002
 #define DPLL_CTRL_REG_1                   0x0003
 #define DPLL_CTRL_REG_2                   0x0004
+#define DPLL_WF_TIMER                     0x002c
+#define DPLL_WP_TIMER                     0x002e
 #define DPLL_TOD_SYNC_CFG                 0x0031
 #define DPLL_COMBO_SLAVE_CFG_0            0x0032
 #define DPLL_COMBO_SLAVE_CFG_1            0x0033
@@ -200,69 +202,69 @@
 #define DPLL_PHASE_MEASUREMENT_CFG        0x0036
 #define DPLL_MODE                         0x0037
 #define DPLL_MODE_V520                    0x003B
-#define DPLL_1                            0xc400
-#define DPLL_2                            0xc438
-#define DPLL_2_V520                       0xc43c
-#define DPLL_3                            0xc480
-#define DPLL_4                            0xc4b8
-#define DPLL_4_V520                       0xc4bc
-#define DPLL_5                            0xc500
-#define DPLL_6                            0xc538
-#define DPLL_6_V520                       0xc53c
-#define DPLL_7                            0xc580
-#define SYS_DPLL                          0xc5b8
-#define SYS_DPLL_V520                     0xc5bc
-
-#define DPLL_CTRL_0                       0xc600
+#define DPLL_1                            0x2010c400
+#define DPLL_2                            0x2010c438
+#define DPLL_2_V520                       0x2010c43c
+#define DPLL_3                            0x2010c480
+#define DPLL_4                            0x2010c4b8
+#define DPLL_4_V520                       0x2010c4bc
+#define DPLL_5                            0x2010c500
+#define DPLL_6                            0x2010c538
+#define DPLL_6_V520                       0x2010c53c
+#define DPLL_7                            0x2010c580
+#define SYS_DPLL                          0x2010c5b8
+#define SYS_DPLL_V520                     0x2010c5bc
+
+#define DPLL_CTRL_0                       0x2010c600
 #define DPLL_CTRL_DPLL_MANU_REF_CFG       0x0001
 #define DPLL_CTRL_DPLL_FOD_FREQ           0x001c
 #define DPLL_CTRL_COMBO_MASTER_CFG        0x003a
-#define DPLL_CTRL_1                       0xc63c
-#define DPLL_CTRL_2                       0xc680
-#define DPLL_CTRL_3                       0xc6bc
-#define DPLL_CTRL_4                       0xc700
-#define DPLL_CTRL_5                       0xc73c
-#define DPLL_CTRL_6                       0xc780
-#define DPLL_CTRL_7                       0xc7bc
-#define SYS_DPLL_CTRL                     0xc800
-
-#define DPLL_PHASE_0                      0xc818
+#define DPLL_CTRL_1                       0x2010c63c
+#define DPLL_CTRL_2                       0x2010c680
+#define DPLL_CTRL_3                       0x2010c6bc
+#define DPLL_CTRL_4                       0x2010c700
+#define DPLL_CTRL_5                       0x2010c73c
+#define DPLL_CTRL_6                       0x2010c780
+#define DPLL_CTRL_7                       0x2010c7bc
+#define SYS_DPLL_CTRL                     0x2010c800
+
+#define DPLL_PHASE_0                      0x2010c818
 /* Signed 42-bit FFO in units of 2^(-53) */
 #define DPLL_WR_PHASE                     0x0000
-#define DPLL_PHASE_1                      0xc81c
-#define DPLL_PHASE_2                      0xc820
-#define DPLL_PHASE_3                      0xc824
-#define DPLL_PHASE_4                      0xc828
-#define DPLL_PHASE_5                      0xc82c
-#define DPLL_PHASE_6                      0xc830
-#define DPLL_PHASE_7                      0xc834
-
-#define DPLL_FREQ_0                       0xc838
+#define DPLL_PHASE_1                      0x2010c81c
+#define DPLL_PHASE_2                      0x2010c820
+#define DPLL_PHASE_3                      0x2010c824
+#define DPLL_PHASE_4                      0x2010c828
+#define DPLL_PHASE_5                      0x2010c82c
+#define DPLL_PHASE_6                      0x2010c830
+#define DPLL_PHASE_7                      0x2010c834
+
+#define DPLL_FREQ_0                       0x2010c838
 /* Signed 42-bit FFO in units of 2^(-53) */
 #define DPLL_WR_FREQ                      0x0000
-#define DPLL_FREQ_1                       0xc840
-#define DPLL_FREQ_2                       0xc848
-#define DPLL_FREQ_3                       0xc850
-#define DPLL_FREQ_4                       0xc858
-#define DPLL_FREQ_5                       0xc860
-#define DPLL_FREQ_6                       0xc868
-#define DPLL_FREQ_7                       0xc870
-
-#define DPLL_PHASE_PULL_IN_0              0xc880
+#define DPLL_FREQ_1                       0x2010c840
+#define DPLL_FREQ_2                       0x2010c848
+#define DPLL_FREQ_3                       0x2010c850
+#define DPLL_FREQ_4                       0x2010c858
+#define DPLL_FREQ_5                       0x2010c860
+#define DPLL_FREQ_6                       0x2010c868
+#define DPLL_FREQ_7                       0x2010c870
+
+#define DPLL_PHASE_PULL_IN_0              0x2010c880
 #define PULL_IN_OFFSET                    0x0000 /* Signed 32 bit */
 #define PULL_IN_SLOPE_LIMIT               0x0004 /* Unsigned 24 bit */
 #define PULL_IN_CTRL                      0x0007
-#define DPLL_PHASE_PULL_IN_1              0xc888
-#define DPLL_PHASE_PULL_IN_2              0xc890
-#define DPLL_PHASE_PULL_IN_3              0xc898
-#define DPLL_PHASE_PULL_IN_4              0xc8a0
-#define DPLL_PHASE_PULL_IN_5              0xc8a8
-#define DPLL_PHASE_PULL_IN_6              0xc8b0
-#define DPLL_PHASE_PULL_IN_7              0xc8b8
-
-#define GPIO_CFG                          0xc8c0
+#define DPLL_PHASE_PULL_IN_1              0x2010c888
+#define DPLL_PHASE_PULL_IN_2              0x2010c890
+#define DPLL_PHASE_PULL_IN_3              0x2010c898
+#define DPLL_PHASE_PULL_IN_4              0x2010c8a0
+#define DPLL_PHASE_PULL_IN_5              0x2010c8a8
+#define DPLL_PHASE_PULL_IN_6              0x2010c8b0
+#define DPLL_PHASE_PULL_IN_7              0x2010c8b8
+
+#define GPIO_CFG                          0x2010c8c0
 #define GPIO_CFG_GBL                      0x0000
-#define GPIO_0                            0xc8c2
+#define GPIO_0                            0x2010c8c2
 #define GPIO_DCO_INC_DEC                  0x0000
 #define GPIO_OUT_CTRL_0                   0x0001
 #define GPIO_OUT_CTRL_1                   0x0002
@@ -281,25 +283,25 @@
 #define GPIO_TOD_NOTIFICATION_CFG         0x000f
 #define GPIO_CTRL                         0x0010
 #define GPIO_CTRL_V520                    0x0011
-#define GPIO_1                            0xc8d4
-#define GPIO_2                            0xc8e6
-#define GPIO_3                            0xc900
-#define GPIO_4                            0xc912
-#define GPIO_5                            0xc924
-#define GPIO_6                            0xc936
-#define GPIO_7                            0xc948
-#define GPIO_8                            0xc95a
-#define GPIO_9                            0xc980
-#define GPIO_10                           0xc992
-#define GPIO_11                           0xc9a4
-#define GPIO_12                           0xc9b6
-#define GPIO_13                           0xc9c8
-#define GPIO_14                           0xc9da
-#define GPIO_15                           0xca00
-
-#define OUT_DIV_MUX                       0xca12
-#define OUTPUT_0                          0xca14
-#define OUTPUT_0_V520                     0xca20
+#define GPIO_1                            0x2010c8d4
+#define GPIO_2                            0x2010c8e6
+#define GPIO_3                            0x2010c900
+#define GPIO_4                            0x2010c912
+#define GPIO_5                            0x2010c924
+#define GPIO_6                            0x2010c936
+#define GPIO_7                            0x2010c948
+#define GPIO_8                            0x2010c95a
+#define GPIO_9                            0x2010c980
+#define GPIO_10                           0x2010c992
+#define GPIO_11                           0x2010c9a4
+#define GPIO_12                           0x2010c9b6
+#define GPIO_13                           0x2010c9c8
+#define GPIO_14                           0x2010c9da
+#define GPIO_15                           0x2010ca00
+
+#define OUT_DIV_MUX                       0x2010ca12
+#define OUTPUT_0                          0x2010ca14
+#define OUTPUT_0_V520                     0x2010ca20
 /* FOD frequency output divider value */
 #define OUT_DIV                           0x0000
 #define OUT_DUTY_CYCLE_HIGH               0x0004
@@ -307,88 +309,88 @@
 #define OUT_CTRL_1                        0x0009
 /* Phase adjustment in FOD cycles */
 #define OUT_PHASE_ADJ                     0x000c
-#define OUTPUT_1                          0xca24
-#define OUTPUT_1_V520                     0xca30
-#define OUTPUT_2                          0xca34
-#define OUTPUT_2_V520                     0xca40
-#define OUTPUT_3                          0xca44
-#define OUTPUT_3_V520                     0xca50
-#define OUTPUT_4                          0xca54
-#define OUTPUT_4_V520                     0xca60
-#define OUTPUT_5                          0xca64
-#define OUTPUT_5_V520                     0xca80
-#define OUTPUT_6                          0xca80
-#define OUTPUT_6_V520                     0xca90
-#define OUTPUT_7                          0xca90
-#define OUTPUT_7_V520                     0xcaa0
-#define OUTPUT_8                          0xcaa0
-#define OUTPUT_8_V520                     0xcab0
-#define OUTPUT_9                          0xcab0
-#define OUTPUT_9_V520                     0xcac0
-#define OUTPUT_10                         0xcac0
-#define OUTPUT_10_V520                     0xcad0
-#define OUTPUT_11                         0xcad0
-#define OUTPUT_11_V520                    0xcae0
-
-#define SERIAL                            0xcae0
-#define SERIAL_V520                       0xcaf0
-
-#define PWM_ENCODER_0                     0xcb00
-#define PWM_ENCODER_1                     0xcb08
-#define PWM_ENCODER_2                     0xcb10
-#define PWM_ENCODER_3                     0xcb18
-#define PWM_ENCODER_4                     0xcb20
-#define PWM_ENCODER_5                     0xcb28
-#define PWM_ENCODER_6                     0xcb30
-#define PWM_ENCODER_7                     0xcb38
-#define PWM_DECODER_0                     0xcb40
-#define PWM_DECODER_1                     0xcb48
-#define PWM_DECODER_1_V520                0xcb4a
-#define PWM_DECODER_2                     0xcb50
-#define PWM_DECODER_2_V520                0xcb54
-#define PWM_DECODER_3                     0xcb58
-#define PWM_DECODER_3_V520                0xcb5e
-#define PWM_DECODER_4                     0xcb60
-#define PWM_DECODER_4_V520                0xcb68
-#define PWM_DECODER_5                     0xcb68
-#define PWM_DECODER_5_V520                0xcb80
-#define PWM_DECODER_6                     0xcb70
-#define PWM_DECODER_6_V520                0xcb8a
-#define PWM_DECODER_7                     0xcb80
-#define PWM_DECODER_7_V520                0xcb94
-#define PWM_DECODER_8                     0xcb88
-#define PWM_DECODER_8_V520                0xcb9e
-#define PWM_DECODER_9                     0xcb90
-#define PWM_DECODER_9_V520                0xcba8
-#define PWM_DECODER_10                    0xcb98
-#define PWM_DECODER_10_V520               0xcbb2
-#define PWM_DECODER_11                    0xcba0
-#define PWM_DECODER_11_V520               0xcbbc
-#define PWM_DECODER_12                    0xcba8
-#define PWM_DECODER_12_V520               0xcbc6
-#define PWM_DECODER_13                    0xcbb0
-#define PWM_DECODER_13_V520               0xcbd0
-#define PWM_DECODER_14                    0xcbb8
-#define PWM_DECODER_14_V520               0xcbda
-#define PWM_DECODER_15                    0xcbc0
-#define PWM_DECODER_15_V520               0xcbe4
-#define PWM_USER_DATA                     0xcbc8
-#define PWM_USER_DATA_V520                0xcbf0
-
-#define TOD_0                             0xcbcc
-#define TOD_0_V520                        0xcc00
+#define OUTPUT_1                          0x2010ca24
+#define OUTPUT_1_V520                     0x2010ca30
+#define OUTPUT_2                          0x2010ca34
+#define OUTPUT_2_V520                     0x2010ca40
+#define OUTPUT_3                          0x2010ca44
+#define OUTPUT_3_V520                     0x2010ca50
+#define OUTPUT_4                          0x2010ca54
+#define OUTPUT_4_V520                     0x2010ca60
+#define OUTPUT_5                          0x2010ca64
+#define OUTPUT_5_V520                     0x2010ca80
+#define OUTPUT_6                          0x2010ca80
+#define OUTPUT_6_V520                     0x2010ca90
+#define OUTPUT_7                          0x2010ca90
+#define OUTPUT_7_V520                     0x2010caa0
+#define OUTPUT_8                          0x2010caa0
+#define OUTPUT_8_V520                     0x2010cab0
+#define OUTPUT_9                          0x2010cab0
+#define OUTPUT_9_V520                     0x2010cac0
+#define OUTPUT_10                         0x2010cac0
+#define OUTPUT_10_V520                    0x2010cad0
+#define OUTPUT_11                         0x2010cad0
+#define OUTPUT_11_V520                    0x2010cae0
+
+#define SERIAL                            0x2010cae0
+#define SERIAL_V520                       0x2010caf0
+
+#define PWM_ENCODER_0                     0x2010cb00
+#define PWM_ENCODER_1                     0x2010cb08
+#define PWM_ENCODER_2                     0x2010cb10
+#define PWM_ENCODER_3                     0x2010cb18
+#define PWM_ENCODER_4                     0x2010cb20
+#define PWM_ENCODER_5                     0x2010cb28
+#define PWM_ENCODER_6                     0x2010cb30
+#define PWM_ENCODER_7                     0x2010cb38
+#define PWM_DECODER_0                     0x2010cb40
+#define PWM_DECODER_1                     0x2010cb48
+#define PWM_DECODER_1_V520                0x2010cb4a
+#define PWM_DECODER_2                     0x2010cb50
+#define PWM_DECODER_2_V520                0x2010cb54
+#define PWM_DECODER_3                     0x2010cb58
+#define PWM_DECODER_3_V520                0x2010cb5e
+#define PWM_DECODER_4                     0x2010cb60
+#define PWM_DECODER_4_V520                0x2010cb68
+#define PWM_DECODER_5                     0x2010cb68
+#define PWM_DECODER_5_V520                0x2010cb80
+#define PWM_DECODER_6                     0x2010cb70
+#define PWM_DECODER_6_V520                0x2010cb8a
+#define PWM_DECODER_7                     0x2010cb80
+#define PWM_DECODER_7_V520                0x2010cb94
+#define PWM_DECODER_8                     0x2010cb88
+#define PWM_DECODER_8_V520                0x2010cb9e
+#define PWM_DECODER_9                     0x2010cb90
+#define PWM_DECODER_9_V520                0x2010cba8
+#define PWM_DECODER_10                    0x2010cb98
+#define PWM_DECODER_10_V520               0x2010cbb2
+#define PWM_DECODER_11                    0x2010cba0
+#define PWM_DECODER_11_V520               0x2010cbbc
+#define PWM_DECODER_12                    0x2010cba8
+#define PWM_DECODER_12_V520               0x2010cbc6
+#define PWM_DECODER_13                    0x2010cbb0
+#define PWM_DECODER_13_V520               0x2010cbd0
+#define PWM_DECODER_14                    0x2010cbb8
+#define PWM_DECODER_14_V520               0x2010cbda
+#define PWM_DECODER_15                    0x2010cbc0
+#define PWM_DECODER_15_V520               0x2010cbe4
+#define PWM_USER_DATA                     0x2010cbc8
+#define PWM_USER_DATA_V520                0x2010cbf0
+
+#define TOD_0                             0x2010cbcc
+#define TOD_0_V520                        0x2010cc00
 /* Enable TOD counter, output channel sync and even-PPS mode */
 #define TOD_CFG                           0x0000
 #define TOD_CFG_V520                      0x0001
-#define TOD_1                             0xcbce
-#define TOD_1_V520                        0xcc02
-#define TOD_2                             0xcbd0
-#define TOD_2_V520                        0xcc04
-#define TOD_3                             0xcbd2
-#define TOD_3_V520                        0xcc06
-
-#define TOD_WRITE_0                       0xcc00
-#define TOD_WRITE_0_V520                  0xcc10
+#define TOD_1                             0x2010cbce
+#define TOD_1_V520                        0x2010cc02
+#define TOD_2                             0x2010cbd0
+#define TOD_2_V520                        0x2010cc04
+#define TOD_3                             0x2010cbd2
+#define TOD_3_V520                        0x2010cc06
+
+#define TOD_WRITE_0                       0x2010cc00
+#define TOD_WRITE_0_V520                  0x2010cc10
 /* 8-bit subns, 32-bit ns, 48-bit seconds */
 #define TOD_WRITE                         0x0000
 /* Counter increments after TOD write is completed */
@@ -397,15 +399,15 @@
 #define TOD_WRITE_SELECT_CFG_0            0x000d
 /* TOD write trigger selection */
 #define TOD_WRITE_CMD                     0x000f
-#define TOD_WRITE_1                       0xcc10
-#define TOD_WRITE_1_V520                  0xcc20
-#define TOD_WRITE_2                       0xcc20
-#define TOD_WRITE_2_V520                  0xcc30
-#define TOD_WRITE_3                       0xcc30
-#define TOD_WRITE_3_V520                  0xcc40
-
-#define TOD_READ_PRIMARY_0                0xcc40
-#define TOD_READ_PRIMARY_0_V520           0xcc50
+#define TOD_WRITE_1                       0x2010cc10
+#define TOD_WRITE_1_V520                  0x2010cc20
+#define TOD_WRITE_2                       0x2010cc20
+#define TOD_WRITE_2_V520                  0x2010cc30
+#define TOD_WRITE_3                       0x2010cc30
+#define TOD_WRITE_3_V520                  0x2010cc40
+
+#define TOD_READ_PRIMARY_0                0x2010cc40
+#define TOD_READ_PRIMARY_0_V520           0x2010cc50
 /* 8-bit subns, 32-bit ns, 48-bit seconds */
 #define TOD_READ_PRIMARY_BASE             0x0000
 /* Counter increments after TOD write is completed */
@@ -415,15 +417,15 @@
 /* Read trigger selection */
 #define TOD_READ_PRIMARY_CMD              0x000e
 #define TOD_READ_PRIMARY_CMD_V520         0x000f
-#define TOD_READ_PRIMARY_1                0xcc50
-#define TOD_READ_PRIMARY_1_V520           0xcc60
-#define TOD_READ_PRIMARY_2                0xcc60
-#define TOD_READ_PRIMARY_2_V520           0xcc80
-#define TOD_READ_PRIMARY_3                0xcc80
-#define TOD_READ_PRIMARY_3_V520           0xcc90
-
-#define TOD_READ_SECONDARY_0              0xcc90
-#define TOD_READ_SECONDARY_0_V520         0xcca0
+#define TOD_READ_PRIMARY_1                0x2010cc50
+#define TOD_READ_PRIMARY_1_V520           0x2010cc60
+#define TOD_READ_PRIMARY_2                0x2010cc60
+#define TOD_READ_PRIMARY_2_V520           0x2010cc80
+#define TOD_READ_PRIMARY_3                0x2010cc80
+#define TOD_READ_PRIMARY_3_V520           0x2010cc90
+
+#define TOD_READ_SECONDARY_0              0x2010cc90
+#define TOD_READ_SECONDARY_0_V520         0x2010cca0
 /* 8-bit subns, 32-bit ns, 48-bit seconds */
 #define TOD_READ_SECONDARY_BASE           0x0000
 /* Counter increments after TOD write is completed */
@@ -434,30 +436,30 @@
 #define TOD_READ_SECONDARY_CMD            0x000e
 #define TOD_READ_SECONDARY_CMD_V520       0x000f
 
-#define TOD_READ_SECONDARY_1              0xcca0
-#define TOD_READ_SECONDARY_1_V520         0xccb0
-#define TOD_READ_SECONDARY_2              0xccb0
-#define TOD_READ_SECONDARY_2_V520         0xccc0
-#define TOD_READ_SECONDARY_3              0xccc0
-#define TOD_READ_SECONDARY_3_V520         0xccd0
+#define TOD_READ_SECONDARY_1              0x2010cca0
+#define TOD_READ_SECONDARY_1_V520         0x2010ccb0
+#define TOD_READ_SECONDARY_2              0x2010ccb0
+#define TOD_READ_SECONDARY_2_V520         0x2010ccc0
+#define TOD_READ_SECONDARY_3              0x2010ccc0
+#define TOD_READ_SECONDARY_3_V520         0x2010ccd0
 
-#define OUTPUT_TDC_CFG                    0xccd0
-#define OUTPUT_TDC_CFG_V520               0xcce0
-#define OUTPUT_TDC_0                      0xcd00
-#define OUTPUT_TDC_1                      0xcd08
-#define OUTPUT_TDC_2                      0xcd10
-#define OUTPUT_TDC_3                      0xcd18
-#define INPUT_TDC                         0xcd20
+#define OUTPUT_TDC_CFG                    0x2010ccd0
+#define OUTPUT_TDC_CFG_V520               0x2010cce0
+#define OUTPUT_TDC_0                      0x2010cd00
+#define OUTPUT_TDC_1                      0x2010cd08
+#define OUTPUT_TDC_2                      0x2010cd10
+#define OUTPUT_TDC_3                      0x2010cd18
+#define INPUT_TDC                         0x2010cd20
 
-#define SCRATCH                           0xcf50
-#define SCRATCH_V520                      0xcf4c
+#define SCRATCH                           0x2010cf50
+#define SCRATCH_V520                      0x2010cf4c
 
-#define EEPROM                            0xcf68
-#define EEPROM_V520                       0xcf64
+#define EEPROM                            0x2010cf68
+#define EEPROM_V520                       0x2010cf64
 
-#define OTP                               0xcf70
+#define OTP                               0x2010cf70
 
-#define BYTE                              0xcf80
+#define BYTE                              0x2010cf80
 
 /* Bit definitions for the MAJ_REL register */
 #define MAJOR_SHIFT                       (1)
@@ -665,6 +667,16 @@
 #define DPLL_STATE_MASK                   (0xf)
 #define DPLL_STATE_SHIFT                  (0x0)
 
+/*
+ * Return register address based on passed in firmware version
+ */
+#define IDTCM_FW_REG(FW, VER, REG)	(((FW) < (VER)) ? (REG) : (REG##_##VER))
+enum fw_version {
+	V_DEFAULT = 0,
+	V487 = 1,
+	V520 = 2,
+};
+
 /* Values of DPLL_N.DPLL_MODE.PLL_MODE */
 enum pll_mode {
 	PLL_MODE_MIN = 0,
-- 
2.39.2

