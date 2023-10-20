Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AC7D13A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378028AbjJTQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377968AbjJTQF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:05:28 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2017.outbound.protection.outlook.com [40.92.58.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D5710D5;
        Fri, 20 Oct 2023 09:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ73YnRMLY1AQe9OkB8T1/wL9oLxc4UAWE2UqsYmlR3hCjzufMpadTxsuX1YJONzwrGH236B/byYC7nzIZyoUo9zaoAm7mCBq+wW5AoQGo7xFnTuEFc6AMuyjG6C1aumAhDtRfBNjj82fEoaj7P5Nmc+kDTjDb6UHowG41bcliy/HvhLQK343sJwuj7Jjw5kka5iJoP8i12Wuxx/EX2xcgVWkF6IPNOspo2w7EcwoarHLbHqRZl/hol89eq9qVQMn1Uv8yJWsVAOn8+xoK56u3YcAmUzRbJbpJsyLJrnz5DbX7orh+KF5ROwDyOW4xiW7FbC7PaDWTUZx9/Tb4nKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yIrmjyUcSBYIClJu6oe6+1FIMEFxrOMF3oCrq+Q+ic=;
 b=NIm3WTl+uWD+KntaRn/x7RFErTTj33TVbxlXuqJ5jyvZSgiWMnYg9LVFqnJk2mcFAQVWcbFcTuqGEa4q0dYtH2mWRq/eYeqlsks/hpuzD9GBI3r7/L1fpqDluHv7gmfTyKxMajZcbVfLfUbVmtoqFxH0od5MItJkVzNMuAdoTYy/Y+4nIR2Ve9UkkW+W/6tKdsERV9oh30yVfg5AUsS08xD0XIAo1J/SAKgWRAfjhHElN+URJQ/Afs0oVcUSClW5Yoq+2hf1JV4jIRFrNs5I4PalLHFfhreTc3qEE8/VcOVXoVAX4t2GOInabFRdUeXGjxGdVrvbw7lqFHA56VO+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by AM9PR02MB6930.eurprd02.prod.outlook.com (2603:10a6:20b:26d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:05:00 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::b753:178a:394e:af8e%7]) with mapi id 15.20.6886.034; Fri, 20 Oct 2023
 16:04:59 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Cameron Williams <cang1@live.co.uk>, stable@vger.kernel.org
Subject: [PATCH v4 08/11] tty: 8250: Add note for PX-835
Date:   Fri, 20 Oct 2023 17:03:14 +0100
Message-ID: <DU0PR02MB78998840C2EBED91AABD4494C4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231020160412.118550-1-cang1@live.co.uk>
References: <BBPatchesV4>
 <20231020160412.118550-1-cang1@live.co.uk>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [zgUay7ayPYe+9RlmfvDr3PUTJEkV/ODt]
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20231020160412.118550-9-cang1@live.co.uk>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|AM9PR02MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: f496027a-f207-450a-037a-08dbd1864fba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm/aF4e912ipBnw0v0O0NSL4tDfHWAbk28LvT3g3HfdWiGd3YfxbCoXzKWokHGqHUktmG+G5tc/jQISks7ORhtsbJIl1hmFBGdmXoUPStKVUCs9BriKg1TvlWQhx30/w5KF/VILly2WTvKknT+d0qYK9dZ+7r6dkFLk9iRRTlib21DeBD6i49GQbY8i8FJIffyDPyV6QVzvznt7eRiKmRSoGWi+qO/Tr1pomb+oK1Knf8qF6DSOZpJcRrf+W4Lhtw8nWLRCXS9k+3K+OR4EMITRzxZhRvyKpmIagMX4xVRv2tYLn7DnmaNET+9U9u2sFRMnByT/uWEcYPiwFxOIvJuO+u1WSJm8CoNEldtS9WjGj4siLKDhJ7iVhnzUXfRa0YYQ1NkD5apmKCvXp0jFjQK7O31qwDrw1PnJ/N0jYGhgo4hFNiDW9G+X5Wvq27NwWKFPxDiSogm78IWY+c8zJCfrGRQNuzhLAzdlPyMBddgBLsXkpHzti7G5906xiMvW6zySo3BK0KJAoJHI4cKOfXDZMfbQiSnjKRk4k0l8wGFLI41WDcl6LiNqbwwV82NZ4jTx/jO/B7B89Veqzenww+oSKVhwYl5YB5E9kOvzKMqwWUDBx/lOcBU82biKh+yPwsioI1+9qsOptBjnSkVkFsA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X4Qgm4MjBynjJ6KtmfCm4HNM3cGpGIsXZNj0v7Wxjn+3d7mcM/LAgdkMHM8U?=
 =?us-ascii?Q?PpM0OMFrIHN6NteahVhc/0LBW2aUgSS9xpQm0AB9wW7fhPbvzB/tWYmDiSOi?=
 =?us-ascii?Q?2Cop1X9Z3EIA6bpww54xztolewfN20AoVA1lrk5S3Gda+WNOyPIvcXuicebC?=
 =?us-ascii?Q?7KgzGF14F9YCmPztEW930WBm7/lBjzLt0KAFips714VdSqYA928qUZHtrCzr?=
 =?us-ascii?Q?vDpvkd+O3Ejs3BzODuSQG/QtocLV/O6KFClD14TMqR4xKi3jOyAZqeKucOIZ?=
 =?us-ascii?Q?FlGWuLIVGBnZ0tqNHjwh2mlid1SnImR83SnWA0Ygzv8/7A1k0XZYpWA0D6Tm?=
 =?us-ascii?Q?/PxUJVVbQLCMXecpu19/XmUHPuRtP5rfnc28oMJhjPqJrGzXX/AUeGD/jqOq?=
 =?us-ascii?Q?/QBIDWcmoUPW4DbYD45bX5W4MDDg7sGLthwkmSjt1Vjbo2Xv847k2DwHsK2Y?=
 =?us-ascii?Q?OKPQCk4qECQMt3LlcJ/uX5PB/xhHJrxQOtWnDgAvQbAhZdbumEF1Vumm+dEQ?=
 =?us-ascii?Q?SvPT0CFps16S1T3jXKFVGqwj5znumEBkb8U8mtaKUR2yIVXYYbnRdzz6Xp+g?=
 =?us-ascii?Q?WdXHYL6hYBlHACA4nM5bOd9WdcmjAElZWbLF4Bz/m/1wsr/FsEJGwleD2wnL?=
 =?us-ascii?Q?g0BvAg7fAwgjdGywTcS7s0kn/SRVqaHn50OM64RA+33EhFlecxKZu0r/Vh+z?=
 =?us-ascii?Q?gxhTR7qRHGaOMvvvbh5DTbRB7Ob/3isuYN+Y+98HVR/Y/2qd495lVal4i2iC?=
 =?us-ascii?Q?meAzEj0M39bVGpIGs1BqwbKpDDjD7eEjcdXN5zQulDmBZy3gGvyvtXkb6/kz?=
 =?us-ascii?Q?+WpDB6rPs+vlFR/3HBH5Szj76+Lkt5/Jq71f/Yjo7+XgcAG7EL9bpvN/WEhB?=
 =?us-ascii?Q?Sbm2yfimtoLl4qckut0XUioRc7+7P2kO57obny9d3fD41fvESfGA40SDtzYI?=
 =?us-ascii?Q?I75Wjm7XiQVGBnVIyIxyqRdmG0AEy2xvGZ1YO7U30WE2233LtxfxZUNy/hYb?=
 =?us-ascii?Q?zCULYnzL96CnKxO6lm7/QEAyUVfMaCx/RYJZwo8RoEG2pLwLSC0nj8PGc6Zh?=
 =?us-ascii?Q?0rOI3oLc5IZ8q9qWszfkyBeCqFYaU+uGQBupWdm/3/CXnZERnxXzb2l233/P?=
 =?us-ascii?Q?6vteKkJBFjuuhSvNJ1RycevIv5IbZx55T1Ru6gHWwqHVZL9F6pN15ddvek/6?=
 =?us-ascii?Q?WuCJAIWBniBdwamcFV2mg4BzRJAkXltUdI9PAg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f496027a-f207-450a-037a-08dbd1864fba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:04:59.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PX-835 and PX-846 are variants of each other, clarify that
in the comment for the card.
This patch makes no functional difference.

Fixes: ef5a03a26c87 ("tty: 8250: Add support for Brainboxes PX cards.")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
For stable: This patch is only applicable to 5.15 LTS and up, other LTS
kernels dont have PX card support.

v3 - v4:
Split patch v3 part 5 into multiple Fixes patches and an Additions patch.
Add Fixes: and Cc: tag.

v2 - v3:
Alter commit message a little to make the additions/fixes cleaner
Re-submit patch series using git send-email to make threading work.

v1 - v2:
This is a resubmission series for the patch series below. That series
was lots of changes sent to lots of maintainers, this series is just for
the tty/serial/8250 subsystem.

[1] https://lore.kernel.org/all/DU0PR02MB789950E64D808DB57E9D7312C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[2] https://lore.kernel.org/all/DU0PR02MB7899DE53DFC900EFB50E53F2C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[3] https://lore.kernel.org/all/DU0PR02MB7899033E7E81EAF3694BC20AC4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/
[4] https://lore.kernel.org/all/DU0PR02MB7899EABA8C3DCAC94DCC79D4C4F8A@DU0PR02MB7899.eurprd02.prod.outlook.com/

 drivers/tty/serial/8250/8250_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index a68ae56e5578..f1acf5a4704f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -5246,7 +5246,7 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		0, 0,
 		pbn_oxsemi_2_15625000 },
 	/*
-	 * Brainboxes PX-846
+	 * Brainboxes PX-835/PX-846
 	 */
 	{	PCI_VENDOR_ID_INTASHIELD, 0x4008,
 		PCI_ANY_ID, PCI_ANY_ID,
-- 
2.42.0

