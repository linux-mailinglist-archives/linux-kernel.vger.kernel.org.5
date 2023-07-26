Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C0763EDD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjGZSs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGZSsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:48:23 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2112.outbound.protection.outlook.com [40.107.220.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9130A2709;
        Wed, 26 Jul 2023 11:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbJuWSdE/cMrDhS6vfzjqnDsz4kp3MRYDFDksS9ip0SOti2l0phRNWZMieH77j3T7yGAez2Iv07o3T5/zxpjQbGP38Gk4gKrI+ArgVkL1WeeBVkGR1BD+a3AoWfi2c4xEKanWEMA+c3Z09ggKqIfdupOslwomuk5K+YzekcA3VidrFBH4YFbRxqsAW7E158cVhLfpTS9Ncq1u3IH5ePeArHXAmoUf+opExwTBJsmlnNuBXob9acWtqZeeliaHsTJHguGv/iXZESYo3hgMSmuIOA862Q87FR47tMY51PXB0H7TzSvKbLEiQitjmbAKORCI57jDa4RJfZ5AgnrsAVGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5jCIzropgOEW6BheP4y3XMWqfb768MtvS9fqNVNMa4=;
 b=icof11oMeDtZ+IbvIisoK+gkzV4nMIJV8/tdlp8soWJsykE/wz2G0yockj0y9CJRGMT4yAh9CGGg0PEvFF068w7QFsI1SRIeWwxZ24QVbLR/tyPyTZ7Dve5LZnI427QfHMFm3O6O9eMPw9c+5R2CN/kuAlbo9S236Dl7C7Lw9YAG8dgN4hluMSIM2iuuWXEv9p8GMY0P/t6lWYCgBo05g2nXZDXe+RW65zqi3UvddIFzqKjmuCKegZhoxRwKsFnmoCMoMTF+r/4Wx66iOtKt/wS5aRRHd924vlJ23YSPJG11K2HV8raWrMSgMQ0wSt5/UqNl210B6VyEipZf33WhxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5jCIzropgOEW6BheP4y3XMWqfb768MtvS9fqNVNMa4=;
 b=XS1DRdvR/WaHjqdzvb8vB6W5IAlZmwawLaDw+ISoLoKGGSFqUjiqJG7nQbmrjZfuFDMhRwE2ATWTyfGO338RVbSdXjyNrqJE5QZX6srb1jlNx6nlRMWOuIDjtK8A2JWJNPd/QUsaPhUFtOhoBU4n3xpAITNBEme1ZcQlutMKcUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by BY5PR04MB7042.namprd04.prod.outlook.com (2603:10b6:a03:22f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 18:48:17 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 18:48:17 +0000
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, felipe.balbi@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gratian@gmail.com, Gratian Crisan <gratian.crisan@ni.com>
Subject: [PATCH v2] usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy
Date:   Wed, 26 Jul 2023 13:45:56 -0500
Message-ID: <20230726184555.218091-2-gratian.crisan@ni.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS0PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:8:191::9) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4496:EE_|BY5PR04MB7042:EE_
X-MS-Office365-Filtering-Correlation-Id: db146059-0e39-4dfa-ecc9-08db8e08dfe0
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmKPb/4s0C/BXnwvFP9K0/hpwv0fZkL3FcfJIQrihZ6rFkooUt0FKwKnHUV0dOlkoqTFHr2HucQfxYjRTHzIlXKDr4zNPLHohlzsaWCUbDnduLwEo/C3ZpYD2Opxz704TtwW9V8q6BVTAFaqZVLGySpSi4hgopS3yJuKrwCrauSL1l8XGD5wPefYYTD6yw8DtMM90oR06jIIFzmmvwB16FZmCi6rcnIQVz2ngsbEtaHJ5IpgSH2EQD+d0XvwHERSvi0QzaB6kukZNBl1v70TMV9URPweuyRCX/CxDJwGyBDttUYve6ggoDByZGebQiYlY8aMyHIJw06h+hOG3kGuEaTze69zktdEDCa7X8G207OBvhNuaYsFKjsla+K7YXvdhtgssy+/TpHkK4B76cRB1VADuC8nDfvErn+WsjYEj+2hXjYVGKeMJeoTQJJrpLwUgWy1pe08A7zaYLb/rRuQ5hABLMBaEg8Q3Xq4OQIJyvTjIYFrHJS2aBnGbVt9kIiJPdZKQzCSxuk4sn0W1z0M12n1OwvwM6jeKtYvy9tqyotiFwQbraraEbuGXXrwgTBW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(396003)(346002)(451199021)(83380400001)(478600001)(5660300002)(44832011)(8936002)(8676002)(36756003)(41300700001)(2906002)(2616005)(6506007)(66476007)(38100700002)(86362001)(66556008)(316002)(4326008)(66946007)(186003)(6512007)(6486002)(6666004)(26005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k3F1APok6lwmaTgy7+y+g57QQiBljQONEF/azwIirdH4hJcWnVd53CZZ83Kb?=
 =?us-ascii?Q?iMOeg81GK/jJOTSIkqhNznpP68F7YHYS+tiDF1W6JcuMpcxpOm2KEk6KOa+U?=
 =?us-ascii?Q?Jy2iFwiNFbpHmA0n5LKWHHh9QrW96AW7bzl1L9Udukag5yAeQQRnHIViaIur?=
 =?us-ascii?Q?ZNMjiHdaYiRBHiydVky6A4gMH4a4ERtwLFO+4gXE9lCYyu6EpYNndq9POT11?=
 =?us-ascii?Q?/8OT6Iw5UaDhp0c5rExTq+87NReLOfPoUDH8sZyySb17SjFGJHxU/Etw2brx?=
 =?us-ascii?Q?Vn0uRTvSpEiXEKNXeXMBXgMrDapngtzcOHeGViw0IA6LAwf0OljbEmnjYIvx?=
 =?us-ascii?Q?Ehi7gmM3s65bIMs2rsdHnj9znd/R/94qQ7Zhp3sBg7PXICvcvjz5zQhjlvi6?=
 =?us-ascii?Q?8Lpf5lrysCfFGIBJcDs8pmBwnR4cYUp+9pUDE9/bUeyZi0pDkP2/PY3Sy76+?=
 =?us-ascii?Q?CJVBkKa43luRTFQSG7IAb5a/6mKe7N7KT2btpvuwO67BevEMIBf8X1DlbeDm?=
 =?us-ascii?Q?sXPOeTLYcqGywQDVhoGj7JVPL6SGRtl7Y9n19Wpi8I4uEn8frKcUZrYASTj/?=
 =?us-ascii?Q?/czTjxCFuCfmpbMqzPTChnVXTS7eEfGHSmJmTmAHwFvbVqWBnQKlX/yaF6C8?=
 =?us-ascii?Q?Ai7yk6K9DKqwORTrRCnBASHtqw5NZW0HZiC6olrBDTwNtNaQYr0rwNjiDNMu?=
 =?us-ascii?Q?Afgoji/iVL5dTHMNPnFYYdnpYpYNrRoFKLlt7cRQkfbSeU9Gmuyfb2GA4oor?=
 =?us-ascii?Q?wB3XVQ068HswUvy5NhrDNMFCiCg8dWHFmmMb2eqVnP0/LQoa5gc7n2EbECCq?=
 =?us-ascii?Q?dUciBdp/DXpbJ8336rhFpz5AGHrWaQBi/p2A+EVDqHtP+w3WxDQqXGAX5oSv?=
 =?us-ascii?Q?WGus1Z2isfia4+w/ONV3RDnXM+RAGso9O6jLK5uxC6qCNE/gT85+6+j1QOEt?=
 =?us-ascii?Q?o6k4j6hAD7qTCuEqeJrG1TrYcjTo3AXYxVsjprBa8XyRN0Dw7zKLsbN9gRaW?=
 =?us-ascii?Q?2tXwUpGWJOe7LdZ0DnqXBdgCwZBo+dxd/rwtb5G4iFNPEI6Bca2jHH5XNLLp?=
 =?us-ascii?Q?N1Wfe0hmpuhpUetZdy1yGvyVNayGLzaEQQZIMzDrYXWiteawdeeShIex1CnB?=
 =?us-ascii?Q?xtB2l7OsK0JXmRpV2xMf++PIdwjxZvUGidcX/yMpBPx82LdKod9em4gmWs01?=
 =?us-ascii?Q?1KJ4imMG4KswvvUKjPZhdNIzrMLwOPeZw+EBbwPBml2CulI3WNsHj4B8lxeq?=
 =?us-ascii?Q?hfcrs73uWFICgRkscHNPvdsCqtwd+j94orTDonucJ1wi9qjkMFQzbVBOPpAN?=
 =?us-ascii?Q?JQPI4w1Xpti5CqxHDJjpLdKAmcgU6de0F+SK/HVbkOkYAIPMggeyJat6d5Ln?=
 =?us-ascii?Q?shP88Czx/MKfaKmvEpDl4Np3mFPZZsRAvyM3BPRdsnztDww4IzGIupLY/zcu?=
 =?us-ascii?Q?a9bcOo6UZqH2gPvVyp+4hKmXLwCj0Yeu7WJQOYDRRvTOy1p69Grdx2Dw70td?=
 =?us-ascii?Q?gAhQyOvnrYsFSzZvBNsjeWpO6zEWvqnYK5AEVtJrJP2y4CK58x4WCeitikxe?=
 =?us-ascii?Q?xPjWg6DH2uw3dLuscBrn4FRGh3XwTDgVSewxDIic?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db146059-0e39-4dfa-ecc9-08db8e08dfe0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 18:48:17.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W50u4AuDoTIWFxXA3PEgaNOHIzjs3Ff+mhCuolnyaY6zkdbC/GBVcaZnUL+UGo7Z8kroDXo5M3gkM+hCDwHn7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7042
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware based on the Bay Trail / BYT SoCs require an external ULPI phy for
USB device-mode. The phy chip usually has its 'reset' and 'chip select'
lines connected to GPIOs described by ACPI fwnodes in the DSDT table.

Because of hardware with missing ACPI resources for the 'reset' and 'chip
select' GPIOs commit 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table
on platforms without ACPI GPIO resources") introduced a fallback
gpiod_lookup_table with hard-coded mappings for Bay Trail devices.

However there are existing Bay Trail based devices, like the National
Instruments cRIO-903x series, where the phy chip has its 'reset' and
'chip-select' lines always asserted in hardware via resistor pull-ups. On
this hardware the phy chip is always enabled and the ACPI dsdt table is
missing information not only for the 'chip-select' and 'reset' lines but
also for the BYT GPIO controller itself "INT33FC".

With the introduction of the gpiod_lookup_table initializing the USB
device-mode on these hardware now errors out. The error comes from the
gpiod_get_optional() calls in dwc3_pci_quirks() which will now return an
-ENOENT error due to the missing ACPI entry for the INT33FC gpio controller
used in the aforementioned table.

This hardware used to work before because gpiod_get_optional() will return
NULL instead of -ENOENT if no GPIO has been assigned to the requested
function. The dwc3_pci_quirks() code for setting the 'cs' and 'reset' GPIOs
was then skipped (due to the NULL return). This is the correct behavior in
cases where the phy chip is hardwired and there are no GPIOs to control.

Since the gpiod_lookup_table relies on the presence of INT33FC fwnode
in ACPI tables only add the table if we know the entry for the INT33FC
gpio controller is present. This allows Bay Trail based devices with
hardwired dwc3 ULPI phys to continue working.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources")
Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
---
V1 -> V2: Remove redundant NULL check

 drivers/usb/dwc3/dwc3-pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 44a04c9b2073..6604845c397c 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -233,10 +233,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to
-- 
2.41.0

