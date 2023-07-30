Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9A768813
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjG3UqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3UqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:46:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8098A10C0;
        Sun, 30 Jul 2023 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749954; x=1691354754; i=w_armin@gmx.de;
 bh=IymVS1AurKF6ATJhoVPi8imybDwrwwHRvHRqUSkvBug=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=cMYZTTYeB1OAcY1O3BDXtihV5qFsKJkeXxHAMW/zEdFkevRchUlmPfnowGu5O7EU2AhfNoS
 zfXbwmaE1JQH48ySzMBw/6EcUkxlxoBq2kYlyKrW4A2ZreU3UzOo71AvpZdlcD8iZ/D8WjrLX
 IJl7cbujxMEtTKNeK/AXZ7NGP4mcudXAu0fjY4s+Glrwfh40AtPg9tv1jtqS1n+c2H7gCfyXU
 nMDPH0Tides8G9DpF0yDkTt5kKC6zbZgTnnkcenyqwWKm9xb/RwWR0lyoHSvHOCHCW8NCv9z2
 Wxc7XPiYLD4WnRh4wxqSzJqt/fnvI+J6dThuuz+PF4P92h5Q0bCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MVvPD-1qGYHU3MCz-00Rrp0; Sun, 30 Jul 2023 22:45:53 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] platform/x86: wmi-bmof: Use device_create_bin_file()
Date:   Sun, 30 Jul 2023 22:45:48 +0200
Message-Id: <20230730204550.3402-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KyCBk9qP1lWDyfRZkE4lsv4P338D6SjdUt0/o+GKUEg7X8IFUKQ
 s7P18aUCMNSmZPm7K5qkCmD9tVPzNgIgQWbTlpqNgh7PnTvcMXmUaFghK0JtPJVxmoGpriG
 MXAKUL6O3phSmDnf5RTabN1xtktiN6IUIxFpUpQlPJ9t5T/41rIExy5Yll6GO3dIPFUYsln
 aFYb0aNq2P7uRy5zrs+7g==
UI-OutboundReport: notjunk:1;M01:P0:bbR+aKQTcFI=;rhVRxHTyK7p54oX9r21r4VlCz0T
 v/oj+R6bMCIuAwOJRWz3y+LURuX3L+NpG4/LATgeulPylnVKkD2QtAMk4aoEEF5DKfClRpGOy
 VXyxb7o+nVh+xN4uoA/m3m3LyIL6u5lKRV00BeZWk0dBzXeWdnpiP5boGaH8yOcWgmPhTzlnD
 naubarGuXMtNUYn98J9VMpjhfAr2Tc8eMenPlnIRAhVTJV3KlXcCYXybrGpRba2LCQ9zosxMm
 iI0csqUr6AwQ9QXEt9/F8up3OizjeprkzNvSB5E66YP1PhV7RmhgH3fcqyFS1fWF+BpWDOwLu
 Q6QOmpR5CqCq1/y/BFnSho/wLKJ3ganwVGjP3r0yUeDNxnaP5RdlUPqUjeRoFR09Y1l9v2N70
 Hae30cj2ICVwaVSyFn61vae3YrP4NLlgsJ4ct8VvxtGE2Zco0MgngF401yU/G4iJwY2i3eZIq
 rD0DfywsibJY0Yqo+QuMVWaO9UJbLOfOyUPk/d9oe3hTWt3l58Jq02BmpsFiulmnoHxCGs/c0
 m3DbwSaJUnYalHVtfC5R9n1FQwx8MrYjv2SPnyezmWmXzQoQRkr17kXXI0x/HXi0EQdlPqMHT
 RelxQyhDoVyV5t7jTFI6NcYcJ4U3S7LICUkDnczNXYfRktSATCAe5jab4c1aMThSe0m/wwU9u
 LacnNbPuKHAOsTRTUzL9uE9Akph7J3wHAPoT+HGcJogGarx8Hy3gMYzX7OBxsrH463ZZ360qq
 CsgBOybgH4b2De+kv0s/5IniigkeDu2I0TccvPdS3JJ+Xa2NRYrGe4yyJIyBGh726HmR6QW9A
 MLHiAW+lknMqWmVv/dPrPg4HY/bPK92JWzkL7T572/0cuG8HQ/CVFARsm25F+zVXn9Mbm+zs0
 Kd15St6pXyDpCIk4QEdB2barW5Od+4pUcX/CLTwK6M6ij8mJTDKbwxIdySsdPiyEuHC8PIdd7
 n6p9gDvDnjw5GnPErgL5U3xzwxw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_create_bin_file() instead of sysfs_create_bin_file()
to avoid having to access the device kobject.

Tested on a ASUS PRIME B650-PLUS.

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add Reviewed-by and Tested-by tags
=2D--
 drivers/platform/x86/wmi-bmof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bm=
of.c
index 80137afb9753..d0516cacfcb5 100644
=2D-- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -75,7 +75,7 @@ static int wmi_bmof_probe(struct wmi_device *wdev, const=
 void *context)
 	priv->bmof_bin_attr.read =3D read_bmof;
 	priv->bmof_bin_attr.size =3D priv->bmofdata->buffer.length;

-	ret =3D sysfs_create_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
+	ret =3D device_create_bin_file(&wdev->dev, &priv->bmof_bin_attr);
 	if (ret)
 		goto err_free;

@@ -90,7 +90,7 @@ static void wmi_bmof_remove(struct wmi_device *wdev)
 {
 	struct bmof_priv *priv =3D dev_get_drvdata(&wdev->dev);

-	sysfs_remove_bin_file(&wdev->dev.kobj, &priv->bmof_bin_attr);
+	device_remove_bin_file(&wdev->dev, &priv->bmof_bin_attr);
 	kfree(priv->bmofdata);
 }

=2D-
2.39.2

