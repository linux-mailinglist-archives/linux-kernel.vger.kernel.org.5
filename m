Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6021080954A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444114AbjLGW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjLGW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9F1709;
        Thu,  7 Dec 2023 14:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701988003; x=1702592803; i=w_armin@gmx.de;
        bh=hRtnb6b+el/mDmpgSmqBxhwR9jcwXm8JFzOWUYTda+I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=WIVYy705ijLpQ8zAaaIOo9myH7lzIg9YE282lJSok9+uNJLLbVq8TARUFUfHP5GN
         89JUpn3GLSJ238oECqZbqBUp5XyMYMR+NTwstW0+5XvYjOp5EGRNQLwL+yE8lxvpr
         4eE0LG8LqbOKkL2VUW2++6qN+D1kvbzNNf1Ktg6iMSUky0YFzs94hySgHX3pfLuhp
         1PYo1NVLMdRvoGm3wnECoHOXGyhciFOZ80KYolvTJoph8tl8zap6XnmIodeeEBpqT
         tH5/3mrsWPwrwn9gSGBhldRO30R3daUDIPA3C8nDnPa/tzrznKhoGsGqH9yljgQAd
         eIt7hYBcjCnZUqVqRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MGQnF-1r1ne225sb-00GqBo; Thu, 07 Dec 2023 23:26:43 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] platform/x86: wmi: Remove debug_event module param
Date:   Thu,  7 Dec 2023 23:26:20 +0100
Message-Id: <20231207222623.232074-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207222623.232074-1-W_Armin@gmx.de>
References: <20231207222623.232074-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V6ZKGrAqANQVKQEACBz3qEBfIRqwdnS1tGjtPZYPj5EUFpH/MxW
 WBhuycZ/bkrQQXjxakG9BEesEb5gOzVsu0Vv9bBYJ06MKdIZOFCG7vcedztADDBd2ODyrJY
 gcxz2Cn5p8HaaUdi1pR7YT3c6eAkYFmkOQSt8omDpaCfpUVpTXfhBDtBklT6JaU4D73Piku
 r6hn5YEAUcY99Rqh7tDDQ==
UI-OutboundReport: notjunk:1;M01:P0:dybWYjf+9q0=;kipBATeSogBueG9cINoScMMyKpr
 ZJSjRWQwXZ08V2SBv2cd17A4yL8lVbXBWo12RTy2P+uaONdtjWxToyvf+4sysUuyi+yb3PkHN
 rX55RZ/4G8RJu2kwwc/NGBPBL2U+LgopOxSFisZtO9mJOFGFWvxRHYRUaRy8wvYzMHeE3VGxq
 r9xEvmBZ1nH8ZjI/K7FnDY4VrW2mbuEwdjnzbAGGYfk20IYrAV1xbUQr71Ae5LzIUL47sw0k6
 79mds+NiVBZDjHUBDQ+756z7Y5u7z1d1NA50v/l+UaIIUsyDyvlHO9Uw8dsDJpflU270MU/QR
 uETUFjNQCI2Yog9fBCGQAx92lXzP+cG7SD70c7wWJuCZg4XoAi0E4pTvoQH+rVEXNqfC+pOGQ
 gQY85euutJmPcabhkGh14j1O98JQDmR/bfw6jdI+XXsl6Sq3YTTJwPWMhjyRZFFosVUJoD4T/
 aGE9J5lmLs3dnUunUUUegjTAI4olTNCr15xVAevG6t1vhCKuqbKG9uoQw2OkvGYn863rXFEVd
 yLDV1wkkNuWZ5JFEviPXBstnQjA64+ZNa9gCrGkT3yukEFADzKZDptk3HlPDZnDn0BCH6AqCH
 c5s7OKP4kbBikpC4q1WX/RUYghvf60b/jfkOCO+Z1RnK3oxuYn6wtvV/OZP/LXrQPyDUENzsS
 EEruFfeqKSkXIzyZkvvF86kZ6EzkKZalbWYq3iGbaAZGCgbjbDkZH/U+ZLltCvkNOPdK1C/dK
 VKEmt+adIa+sjWLJ3Az8msu6XaNe/5XnpBhNpwao7JgYNpT0kGNsEYlv9/niFvFomzIe4QY1n
 5BYw8k22d4SaJZ4mKnXHlpsK+u6V4kunRVSx5VefbSQvP77Pc16/W36+lKE2zoJ4oN08gbaDv
 7nCEL7vHvtSnSI4ydG9ky9dX0MK6X0adWPIqXYO5NkucAzuoVeCOBtokdMCBivUUvXXN/DAqn
 N76nw38h1Zll5S5vdLQRCyIN3+0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users can already listen to ACPI WMI events through
the ACPI netlink interface. The old wmi_notify_debug()
interface also uses the deprecated GUID-based interface.
Remove it to make the event handling code more readable.

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

