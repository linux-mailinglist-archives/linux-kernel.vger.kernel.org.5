Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDA68134A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573759AbjLNPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573729AbjLNPY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:24:27 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2069.outbound.protection.outlook.com [40.92.19.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E3120;
        Thu, 14 Dec 2023 07:24:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVZ5ptb0vgAVW9rH8JCjYPC42QX8Z/huA6galMCzojaVnVGKsiMflfaZbyeMAdsC7vlk+JiIG60e8mNtIdRefy02SCGB9FuKyInSxXT+ZDv4ujdqlCumVPz/uWE4PWiJNJ/Le5zpCtK9xdCFxVE5OXmJsqpCI4TLTmpMzYiv6aVg0G/MYHi4CIeee98a8rQzPSjoCF9TFDRuCVe+cbCh75LhThQlxk3uCOEHOuOOaDlP9RJ2ijVzs/FUvZVikM6uX8E5c2hThRCqm5g0E80DMczMSpme0osJvO93rh6n2mVuvPu0q97930FvtfD1Dt1K+9XFNQGJYBm4v9/ZZ81OZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=d/7OUK6WGIgPHsSPYBfErfQcg3DzYTnHl0r19MJ7bCmKHX41M0bUeK+OGz7H9bOzOjWtf9Ua9QO9dZrg2EDlyf/kCZsjfBg+c1QW1I3l1iP1CqfnvcaG/rFKeAc7fbEe8CbEvVog7jmXcTJAUZFdUn+CBf2e6WEkVyy1itrZArqnhso5MDx/zocuhtEDsedBnJKb9WA2elRl0seecup1LwlhXEX0ShCb/AlbSbeioEF3U3DdUu1QJ9Bx4yecQoYWr5MrbpeX+4vFHUzkpPVNMsk7SKzoBGwBl5yoxTcAgt70qdf0ClEZVX8NolJS4S/XunRjuezmo007X9Hg2V1gFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=dGcFUNhlg2b7lGK1OqAwa3H4l2WuC0PQHP3IwlelOwuJrG/mlARS4JvejfdSpO0vkZschYNdFjxUxvehqZTdSCilDkzyYB2kXWmQVGy5uj81MnDypBo3ZCqNlB99vfJePn7P+tPvRIsP2QlfZE3RFVZSwok9UZsooU7i/ilznZvJ1kVT3Iq6rzqt5bKWiPzb/ue+MvOkJKFhfMbKLx97NbTEruKgeZwjnNyZloSQhY+W2rSSQqnVg53WE8h3U8fXjWDxEaMuePJ8Gi/yL40I5euebZtnNm7n/8CQYre6h4Hfkq02p8p3n906BHZcAeQPnY6ytwHhQR7y0u6PuaDhKQ==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by PH0PR03MB6252.namprd03.prod.outlook.com (2603:10b6:510:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:24:32 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:24:31 +0000
From:   Min Li <lnimi@hotmail.com>
To:     richardcochran@gmail.com, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 2/5] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date:   Thu, 14 Dec 2023 10:24:12 -0500
Message-ID: <PH7PR03MB70644E11443361C6C1D1F388A08CA@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214152415.14785-1-lnimi@hotmail.com>
References: <20231214152415.14785-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [69T+CHlrNl+YEp8KEKym5TOkrPhuoAuo/+kJee/6yJc=]
X-ClientProxiedBy: YQBPR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::26) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20231214152415.14785-2-lnimi@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|PH0PR03MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2c54c6-4d97-42a0-f04a-08dbfcb8c4fd
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnrf5XTkHvzLuPL047Guub836M0TKV9kS/HQspHgRwjaoz8Wvjo7seIKeHa9dAQc1pj3EtirVilnplIAIQGdMYPOrGB8QlTnL1pQ1U4N0Z3GoRzl7D1NJWtMK6GaO0tMEQeDrNl/TaplW/dRLwzlHuwlFCL94OLc9rIUez+2eQ5geZHNeDObwMxAdbFNAPwBRNGSyeana6EIlBPuv18H3vVSw9YtgVBas23lkFBPeDpYub1yH8OTbvhy4+hvFwfUvveqB5udgBcaegSU9PpshDJ58mveVq5zORbOtAR2utQJGRfKBnZouZU0q3l/L3GhA4G6Hw6JM/OiNAHSweygfs3dulXbkymCfbzmIzKqBrMAr5lE4R5bAdm7ZhxA/uA0qwn4yePuclh378gZC9C27JE/PDpsbPOm6QR5N5ZlershfokDm2m5L2CRhAPG6frck7EqbyB26ElJRNaOBl9WnbzJPW6wopgkJMRvMpwiezPShwgorwwlVVZl9P8tZCfgUL2WpKPv5S5C8YnsUJcK2EQ+3TlBzy7rBablmREKMlpY3H8RmTyKCERtGpBsys3yOVtm1TAPdbUyY6/wii263dn8r8/ZPg5Yf3zlNDEkzKAgMClhrBhMtfvP7+uZHHJLf8LuF4fSyrvBmVoAMvsHCqo9c4ikrOMmjghNyY8fFxQ2Ty+2ORain0EUh3HuhKV54kLRaLArn8bamolOxujWTTI21+QHP1g14pB2CRmAo/nf97DNjDDnjYGis3YZZYy9qIc=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6eKG3nh024IINtMtA9542ysBSQZjr8Ye75Se98nut/YjwC4KwXp1TiDXPCr3cUXk65MHz3Rfrvv4Ds9KFIoJt3O/W/kBIQvaDfpQoCG+5OJ7tlom0L3y7VGldEwo+Ad0PyCPV4XTsXxo9T8DFVV90ucuarV4YhTLJvoh65z4KwdKcuIuhJBhT9vS6hhWNFynDFO2oId0UHskEwxeukZml73w+YkWDeeF14MurTlJWMxQA60+1yFl4bjtgBAkeozLkMxlBaZPmdcdcIa/92Y7dg3YR/zvefWS0tAjyP4U9QG7wTVSIEPftbWZ1tB8fZULf8FZy5rIaBYVLp7edem8v53D8v2vtwl8SfUloz1Sbec6k0vyJisawHte9iKCruvC5qEPYR+pb8L1/mzX2fKL3BMHb98IOL+FFgFoCegPKCcx9Ct/gJTx9QsAbibQ8W11q0OIa1luvTEgss7VmLyJGJMTHZwV4L8ngmVUGl8ORypDXp0dD0gnZN+HUQkfSCKfM/89+tp+kMUVFWGQGh2Ft6sBsVp5m9GkI8e07c6nnq8iJ3+jpX/QvRGs3W+iMoR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cQHtbTyTUWhQlvVFHiilPVCEu2x+s9+nLm/iDeDf8q3HuMd613HAQu/4c5oe?=
 =?us-ascii?Q?0nXAWOwxN++3Y5CYTcxJKdOrkV+QNlkFzqbkdjDjFjPfKNAFwwNE7092Y4Fv?=
 =?us-ascii?Q?e6PlYLUttI7TOGlJS+e2vaD+thK0AuKT9hhfv9J9i8WhoIbYFt+HmaNEbVzN?=
 =?us-ascii?Q?y6+MuvBS0b55hkUjcvsiTCZ8wv594G/1DuTMuenhqakRysNeIBWYqnz0V9az?=
 =?us-ascii?Q?/mRz5VNGDjEPe5C6hWZYT5vavuFPi+irSXz6CC2t0lCMjNHt3wOfV26XOFTp?=
 =?us-ascii?Q?sV0a0yMuiDsjY88QmWDNmOY3ph83p4GyZtkxpzqbbWSM0v4BUyrALAUZulfS?=
 =?us-ascii?Q?lTTWqCMJsMhWw2Dg9Pr07eWWUB2UfA/ryWvFRq8WpTAtBGfi9UwNB/Pw/VD6?=
 =?us-ascii?Q?PwtVdgJNf/Glp4UxNDq4AYqhd37fiVd56KJ7/YdUs/PD1l74luvWDAKzYxcH?=
 =?us-ascii?Q?hmh38g8jgAgwG6nuvynlIaAR5l6DDgrK7DJc5cJcHqoccWpwBGroxG9mJOpU?=
 =?us-ascii?Q?Va0h1EiGv9WtC5D2w06V+JmEBbyzmWgt+Z4T5+qcA/7V3HoDEb6uLYUYIYdC?=
 =?us-ascii?Q?znTNXl4d80g9T5RM0dJPx/3qxTCbeqt9fExV7QOl+DzIH7pJp9hJhp2W1xKr?=
 =?us-ascii?Q?kkxtkcnERWFZ4ROlGhGjLkCjE87eXt4GdN6V8udeQ6CnJqZGXyOpPdY9Eppp?=
 =?us-ascii?Q?UOZiRr2rwpYLnDviEt/+5XlPVjUQxl6VtiT61yASoSR3axcrS1KLYQaao+S4?=
 =?us-ascii?Q?obsOx6lsIuSBbUja5t42PQ+9Fvtxch7pNrKdXmRBvlbcWBP9SNFshPhp9PY+?=
 =?us-ascii?Q?Y9rJokEjQACKWajpUCFK03WX1EdYxDXJcvYaHZr4ai4ks9uPf6zN8rJVZ5p8?=
 =?us-ascii?Q?938iuZTD6yqGFrGdaENeqd+KYVklcRhmlFHW/2uztiRyo5OwBxyjeZhCYmnw?=
 =?us-ascii?Q?XzBhadOAD1JEaJi76ktmlxds8fF7FSp1kbPJSedtGWRvd20B0hn1lHoDG4aE?=
 =?us-ascii?Q?LuiJeUKlyj7C2ZvZe2xB0CheZ81wBy7TZpRnm133XztbNlexgcJ0VRLdjsga?=
 =?us-ascii?Q?1cqLl7H/qWlsEKaYDHS9wEf6qsyDNa1aAfFDivZqJu5sraLzQrG5JGj/2I0O?=
 =?us-ascii?Q?mHyjG4q+WOkTeCwidlGPoxX7ADIxOzSl1RJuVmEz36y/6hgeQ6wOEOVhZPJ9?=
 =?us-ascii?Q?mFgwUnk6TqGpUDXuWYW6ajHGRiiHfB91qQYsfg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2c54c6-4d97-42a0-f04a-08dbfcb8c4fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:24:31.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6252
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

In order for phase pull-in to work, write phase timer shall be 0
when not in write phase mode. Also Fix u8 -> u16, DPLL_WF_TIMER
and DPLL_WP_TIMER are 2-byte registers

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f8556627befa..d069b6e451ef 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
+	u8 buf[2] = {0};
+
+	/* Setup WF/WP timer for phase pull-in to work correctly */
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
+
+	if (mode == PLL_MODE_WRITE_PHASE)
+		buf[0] = 160;
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
 
 	err = idtcm_read(idtcm, channel->dpll_n,
 			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),
-- 
2.39.2

