Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4580BCF5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 21:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjLJUZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjLJUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:24:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DEEEB;
        Sun, 10 Dec 2023 12:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702239891; x=1702844691; i=w_armin@gmx.de;
        bh=9X/ndjF0qighzqFD38BDT0oCZveOZxeu5EzMzNvtGSY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=kKncfG8hsHirtke4S1FBYVxunBEoaYhoOLsxAWAJJv/YMBipY+16uKMEMQuRjECo
         80YNKY1uAiv4fhqM33Id0bBzl3lElqVRnyJl2WJa6qCQy2O8NoIAli8GDiCEvpPDK
         Bn1mtNKE/09GxlpnQxVt3fdrNQiRXaExxp8eRaaL7HQGNTdprhfkS/uK9ZRlCUWAF
         m3yyw+bMr7qghUx9+Ky38q4IG7YRFP5b6MMVU5Bo5qN93TshYZrMb1yaL2GR5wLPD
         6paonzgMgcg3CN/czrldEMb7g4M6WxDolHAcJ3RWrwNv0mKmbgwUGnyrdYrCl6zB8
         +na7+EtFf6wdrSy68Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N5mKJ-1rIxiq1mPr-017Ho0; Sun, 10 Dec 2023 21:24:51 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/x86: wmi: Remove debug_event module param
Date:   Sun, 10 Dec 2023 21:24:40 +0100
Message-Id: <20231210202443.646427-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210202443.646427-1-W_Armin@gmx.de>
References: <20231210202443.646427-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gxVqnCyDxUDGQkxB/vb9rTwI2WIj9Lz6rYKGNRn2PQV5PzSCuKe
 RazhoLs+5F1OSGabVdlzXr/H/IcTChsR2CGMgXd6jknrbKnrEo4ocdAj1I4fXwHXqkDx48t
 kO0C2oMu5gel2Pw9B2p6iBoz0lRxDOo7KSeAF0icXSMcMsmgtWxfRnitc4r9yj8ILz5N0Ay
 9e5EI4rRhgwo7RsiIGNrQ==
UI-OutboundReport: notjunk:1;M01:P0:sILp1v5shW8=;Acn5DnIaQxHF1DQgghBbQcgUHhH
 As+bLb/RR+xof6keTYpLFqjD3pyH3gKx1mUoL6uSWlf3EHsmkXimoS1TBTVasja6yn8n3OJUN
 1+BB+VD9V8Z7DxCqGOCOY2DEhlxtlawYAtTpa4RWhBOdkHrpOoGN2rQPtjqZRzMvzZb2arMls
 JOxFFZe9HdMJS9aui4HaG9G68dWKshmKtKPhMotJGBu3E2o2vRrhYMY6df4xwnyxm1JGw9PqZ
 TE++MOl9J+xnGv8whkRlbfmrad6G4ddbRW0jhTbyh/Fhw95J/Mn44tXFPPdV0BiIHjC8CdhrR
 qT8su+wYn4W8lGsAemHujMyy3kNyWBxkuCy07heco8m5oedXDAe77BkhLX3CefxD4aehkGPEy
 V9rG1amxfbNlAHQM84CLH9Pdio7nnTxLIqaOEoWq5UHsDoDIQZc56gG5s3XDHJXFmpd8cDwMr
 Dp4Wps2txBhdxPS6FqgoHH32B8q1vchhkmRQxPc+EHQMLT4aIeNPUaYmOtBFyALP4kU1L63yI
 JlKgj7XKqiWiX5uJvGLS11lyrXeKltVRCJ7YKzbE2G8ObeQbOpuTZDPSDS28ncBitoSRXpRI2
 eUZUQHFGSt4wDBS+VqmvZUdbHs+om7WYxhXF1GQZ2CJ4PPN5nIe5iTXEckwKuBb/I8F/joY1X
 7wXKudVBVI4beQWdV9BB1vp3rdIjLOaticKS8uQQcCHojteumAtoiikdDvsCujRU0DcllOVD7
 K7i6qxTAjXUy+UG2YhbkWabDaGTUoItWel1emFQ6/7sc0ntxZ4TB9ZpUIfHlz5Rk75jGyjd0o
 KKHgmNhcgPJGezKx8vajAMaYXLAAX+G0L9tmXzsFqNWQCVHwvHbSxABS1oeYrYxK4iLl8IpZ2
 Rj+ke4JO339fggMHFmjSnK0YaDDgodPi8467Cf3KmUtcfruSaelBUwCJVlYqCEpYNR4hsVy5A
 x0HdzVc4Mp5f0RvZRrElueaafis=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can already listen to ACPI WMI events through
the ACPI netlink interface. The old wmi_notify_debug()
interface also uses the deprecated GUID-based interface.
Remove it to make the event handling code more readable.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 74 ++++----------------------------------
 1 file changed, 7 insertions(+), 67 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e8019bc19b4f..7df5b5ee7983 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -85,11 +85,6 @@ struct wmi_block {
 #define ACPI_WMI_STRING      BIT(2)	/* GUID takes & returns a string */
 #define ACPI_WMI_EVENT       BIT(3)	/* GUID is an event */

-static bool debug_event;
-module_param(debug_event, bool, 0444);
-MODULE_PARM_DESC(debug_event,
-		 "Log WMI Events [0/1]");
-
 static const struct acpi_device_id wmi_device_ids[] =3D {
 	{"PNP0C14", 0},
 	{"pnp0c14", 0},
@@ -592,42 +587,6 @@ acpi_status wmidev_block_set(struct wmi_device *wdev,=
 u8 instance, const struct
 }
 EXPORT_SYMBOL_GPL(wmidev_block_set);

-static void wmi_notify_debug(u32 value, void *context)
-{
-	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *obj;
-	acpi_status status;
-
-	status =3D wmi_get_event_data(value, &response);
-	if (status !=3D AE_OK) {
-		pr_info("bad event status 0x%x\n", status);
-		return;
-	}
-
-	obj =3D response.pointer;
-	if (!obj)
-		return;
-
-	pr_info("DEBUG: event 0x%02X ", value);
-	switch (obj->type) {
-	case ACPI_TYPE_BUFFER:
-		pr_cont("BUFFER_TYPE - length %u\n", obj->buffer.length);
-		break;
-	case ACPI_TYPE_STRING:
-		pr_cont("STRING_TYPE - %s\n", obj->string.pointer);
-		break;
-	case ACPI_TYPE_INTEGER:
-		pr_cont("INTEGER_TYPE - %llu\n", obj->integer.value);
-		break;
-	case ACPI_TYPE_PACKAGE:
-		pr_cont("PACKAGE_TYPE - %u elements\n", obj->package.count);
-		break;
-	default:
-		pr_cont("object type 0x%X\n", obj->type);
-	}
-	kfree(obj);
-}
-
 /**
  * wmi_install_notify_handler - Register handler for WMI events (deprecat=
ed)
  * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
@@ -656,8 +615,7 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,
 		acpi_status wmi_status;

 		if (guid_equal(&block->gblock.guid, &guid_input)) {
-			if (block->handler &&
-			    block->handler !=3D wmi_notify_debug)
+			if (block->handler)
 				return AE_ALREADY_ACQUIRED;

 			block->handler =3D handler;
@@ -698,22 +656,14 @@ acpi_status wmi_remove_notify_handler(const char *gu=
id)
 		acpi_status wmi_status;

 		if (guid_equal(&block->gblock.guid, &guid_input)) {
-			if (!block->handler ||
-			    block->handler =3D=3D wmi_notify_debug)
+			if (!block->handler)
 				return AE_NULL_ENTRY;

-			if (debug_event) {
-				block->handler =3D wmi_notify_debug;
-				status =3D AE_OK;
-			} else {
-				wmi_status =3D wmi_method_enable(block, false);
-				block->handler =3D NULL;
-				block->handler_data =3D NULL;
-				if ((wmi_status !=3D AE_OK) ||
-				    ((wmi_status =3D=3D AE_OK) &&
-				     (status =3D=3D AE_NOT_EXIST)))
-					status =3D wmi_status;
-			}
+			wmi_status =3D wmi_method_enable(block, false);
+			block->handler =3D NULL;
+			block->handler_data =3D NULL;
+			if (wmi_status !=3D AE_OK || (wmi_status =3D=3D AE_OK && status =3D=3D=
 AE_NOT_EXIST))
+				status =3D wmi_status;
 		}
 	}

@@ -1340,17 +1290,10 @@ static int parse_wdg(struct device *wmi_bus_dev, s=
truct platform_device *pdev)

 		list_add_tail(&wblock->list, &wmi_block_list);

-		if (debug_event) {
-			wblock->handler =3D wmi_notify_debug;
-			wmi_method_enable(wblock, true);
-		}
-
 		retval =3D wmi_add_device(pdev, &wblock->dev);
 		if (retval) {
 			dev_err(wmi_bus_dev, "failed to register %pUL\n",
 				&wblock->gblock.guid);
-			if (debug_event)
-				wmi_method_enable(wblock, false);

 			list_del(&wblock->list);
 			put_device(&wblock->dev.dev);
@@ -1445,9 +1388,6 @@ static void acpi_wmi_notify_handler(acpi_handle hand=
le, u32 event,
 		wblock->handler(event, wblock->handler_data);
 	}

-	if (debug_event)
-		pr_info("DEBUG: GUID %pUL event 0x%02X\n", &wblock->gblock.guid, event)=
;
-
 	acpi_bus_generate_netlink_event(
 		wblock->acpi_device->pnp.device_class,
 		dev_name(&wblock->dev.dev),
=2D-
2.39.2

