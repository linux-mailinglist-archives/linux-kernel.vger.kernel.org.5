Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BEA80953F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444097AbjLGW1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BED53;
        Thu,  7 Dec 2023 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701988001; x=1702592801; i=w_armin@gmx.de;
        bh=bDupiqQnoHP4fbU+fdZXLeAEnhHecT9ssUymdrsFWIY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=cywH9xVzABfLKGfaS7RhH4DEpMCsZqtFqZ0htq0RfnBgsNIL86r3kOEplRMTWJnc
         P79Mfl69kVAJ3ft0C9nkrN9mRO/ja8rw/D9Fpa4JvkNUFke/PR9xAvskXCd4fME6c
         p8RZinB+VonLKeaq540HHFJE1q9fhQ72yC66GT2Y5etCOuvF3jROlOUMuHbl56Qy4
         Gce6Rqhq4TGxKTFtYUVomTYAVumwl1no4Qa9hpmxHE8SgvnvBb+obvg70B7YJClw8
         bd2yPm/xoA24att2WT5OtP5Otj/t9vJONSi8LQQo+Gzck4qumW8PGGX2u5HXoDKhJ
         0aT8X7qpkph8h/4Wwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYeMj-1qgHBK1tlz-00Vdhw; Thu, 07 Dec 2023 23:26:41 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] platform/x86: wmi: Remove debug_dump_wdg module param
Date:   Thu,  7 Dec 2023 23:26:19 +0100
Message-Id: <20231207222623.232074-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207222623.232074-1-W_Armin@gmx.de>
References: <20231207222623.232074-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HgA1KPLs62Do40wpJGBb9R8bKIzYupdTSBSuEbwuBagc/iZ7MQa
 1ZNy6v8ZQHel1udc4tjXe6jV8YqVM7nQzKiO3bCoy9sjwWBL/NDHAo6rAJPAzMAy/cdeLrB
 gWU6HLd8d/WeGyEx3imbYobkuCpK73wMRMTaPCgWheSb77SDIMPq1uWIBjXp5lDKvctL8Sh
 PDbY9wvIqJtNm7XOcelZA==
UI-OutboundReport: notjunk:1;M01:P0:4XzmQh0StuE=;BBrNL1c2rr3JaETdoYQlLtJQuPy
 j80ZoRxF2DZKy6Su3ENoBKS6mLEjJGs6iaub5DThFRiU9uU6TTTGs+03/XZHEcOsjZUH6DVJz
 nf8b6GjH7sT4Tut1AQ8ccZDD4DhpSXdgiOfxjh++hOFNtcfnM/tK7CCXHZqoBWekPZIiz5vZD
 SBR+vJn7t7dR94Jac3L528E/NY5Bql1C7GjoEx1iyyVAkC7sLYa0Di9QUvi/7aguBDmy/xawc
 +CkzdSwAlumnS1UlcVbXp/93sDgfUrxdo3pZjfTf7j6LEUKR593aN8YuPMNIZNqzhX0aoom7b
 Z9PnsU3m3SsCVA8PWF3jaT/WNBvZyVoVLyFnwzH2EipwoHy8d58H99oGAEAlPSOAv7uu0bvdz
 CEgyMzrfTPjjLmycUqB7CLWq8OgZGcaj+3Bmd7i+sMxN6Fgx2awXj8YSsrxDQUh5wtASPQpEp
 ZvvM9z6iqZhSgV4kGl903C2D9Rp2zufayffJuNje8ynJyDgNqL8Pgkx8ilfI6o8S//GtQ//pl
 bJT9M3yPQOLrqNPLWxWgWesHzvEMVxnCR5Mb0I1Uc4qLdfV2hqApiWADpdWsJvjlXPZmhhF+7
 qAK9Nfv5qkY4x70U8nWx9ixXgJ8vdWVtuKCHWDE0osZuYdO3y9r55h6CAjpC7fL68BOrfrFe1
 dxNS0huSDu9WxZx6ciEc4aXkoSV58kqgY+gmMVwRJlTRmGJ6bmt0utWUip8oh2MTvXlSzNAVB
 9d8TgephWJZkJ6aNQ6KhktsJWRxx4EqrSXWFPGn20EDTvl/N4t1IbPU6f7NdzAO5CRPL8DWlU
 vj2ZJy6A6mDNx1Xm3MrAlLZYCs8iT6tsCueoQF2WMYjzNpITCpV5eAzhS8WoTwkwa8K6g7Jf7
 K1fMFPFGBxzZALTpxGrsKOktnlZDTtvpE8cJImAeFHe29ETqD94mYeL3pZn1dcWF2G9Qm4pLJ
 gZ2es4/QRQMuOpFdEprX3X+RFX0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functionality of dumping WDG entries is better provided by
userspace tools like "fwts wmi", which also does not suffer from
garbled printk output caused by pr_cont().

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 4f94e4b117f1..e8019bc19b4f 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -90,11 +90,6 @@ module_param(debug_event, bool, 0444);
 MODULE_PARM_DESC(debug_event,
 		 "Log WMI Events [0/1]");

-static bool debug_dump_wdg;
-module_param(debug_dump_wdg, bool, 0444);
-MODULE_PARM_DESC(debug_dump_wdg,
-		 "Dump available WMI interfaces [0/1]");
-
 static const struct acpi_device_id wmi_device_ids[] =3D {
 	{"PNP0C14", 0},
 	{"pnp0c14", 0},
@@ -597,29 +592,6 @@ acpi_status wmidev_block_set(struct wmi_device *wdev,=
 u8 instance, const struct
 }
 EXPORT_SYMBOL_GPL(wmidev_block_set);

-static void wmi_dump_wdg(const struct guid_block *g)
-{
-	pr_info("%pUL:\n", &g->guid);
-	if (g->flags & ACPI_WMI_EVENT)
-		pr_info("\tnotify_id: 0x%02X\n", g->notify_id);
-	else
-		pr_info("\tobject_id: %2pE\n", g->object_id);
-	pr_info("\tinstance_count: %d\n", g->instance_count);
-	pr_info("\tflags: %#x", g->flags);
-	if (g->flags) {
-		if (g->flags & ACPI_WMI_EXPENSIVE)
-			pr_cont(" ACPI_WMI_EXPENSIVE");
-		if (g->flags & ACPI_WMI_METHOD)
-			pr_cont(" ACPI_WMI_METHOD");
-		if (g->flags & ACPI_WMI_STRING)
-			pr_cont(" ACPI_WMI_STRING");
-		if (g->flags & ACPI_WMI_EVENT)
-			pr_cont(" ACPI_WMI_EVENT");
-	}
-	pr_cont("\n");
-
-}
-
 static void wmi_notify_debug(u32 value, void *context)
 {
 	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
@@ -1343,9 +1315,6 @@ static int parse_wdg(struct device *wmi_bus_dev, str=
uct platform_device *pdev)
 	total =3D obj->buffer.length / sizeof(struct guid_block);

 	for (i =3D 0; i < total; i++) {
-		if (debug_dump_wdg)
-			wmi_dump_wdg(&gblock[i]);
-
 		if (!gblock[i].instance_count) {
 			dev_info(wmi_bus_dev, FW_INFO "%pUL has zero instances\n", &gblock[i].=
guid);
 			continue;
=2D-
2.39.2

