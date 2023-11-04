Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825D7E102F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 17:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbjKDP5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjKDP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 11:56:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B44D57;
        Sat,  4 Nov 2023 08:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699113382; x=1699718182; i=w_armin@gmx.de;
        bh=Yxm7YEue2Zb4IoAPxRECzCcwA6ar5goRDg9DhTxupW8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=r+971qWyLPKVKhJuArEptnH8DQjbfthcbisqcJXaN9QCcBgxkW19ZtZ1h+xDmLm2
         VGi+qXjZ6JQJheCqZ+SbDcvueVou/0ln7ZtwzlrMDzqKNyNB86Oc2xKlNBjqRF0yQ
         151mM8/mcsNaYRq4B1tDU7PhT8bwbYHBY2y9bFnwML0lkPSNPRMhGczbCv0zr2lxg
         Vk0e6yqLk0uisjAR3XvLXgEoWaEnnG7RTvGfiZX6Yrn0AFMG6glASOkxFtMaVO16l
         M5eCvtE1a5Vot7DPOqbe10smrKxM0AUYnNjpD63TVNqrgfzpiHbq5qVpwSP7hJf8h
         AqAn74GnmgqoJcIm7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MnJlc-1rgJFq01q8-00jFo7; Sat, 04 Nov 2023 16:56:22 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
Date:   Sat,  4 Nov 2023 16:55:59 +0100
Message-Id: <20231104155559.11842-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231104155559.11842-1-W_Armin@gmx.de>
References: <20231104155559.11842-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fYoOIO40BHEsB3Rh5dXnxI0AYtMbi5P9wRy2Xwq8egeIgFB1WN6
 wzidT2aPjgCL2U5XXzm5+yMQc7GaCkQ0boeHGHdPF/AiqacnSv1u+QCFswGp4AQTIl/meM5
 nIO46XZwjzzOF+pIC8Sh6GpM3q0cQ0mH8yA4JZKAtqFWkx+oecHxpm7Bps8nTLYPpo7qZOi
 JOK2uAxvQGJ5uT1+AN5RQ==
UI-OutboundReport: notjunk:1;M01:P0:TqDVS66/gCo=;Ti/02sBVT753x5goa2Cl39mNSxE
 rNT/sbP1IVk4ipsCJn2pvqPlLBgJQKwixtGgN+UpkBI/ySKP9yIwptwSXiC1JuV8v0l0Oh5tJ
 sPBNDOjjcEBvuPy+dA0FMplth/n8r0pqXVJN3WTNU4XiRtrPOYzezJL/mS7/HY19KR8yt1VGW
 Yb+AmhoBNGvGl+pc4HhW8me7SaM1xB3ZVd10n1xD4dg0g+ST8Yn7Xm7urppeUZu1CTRLF7+Od
 H0RRfLPEPu0UFrKz5Rl6dYdYVBzscwGK9kOtQQ5D2FCeFhMY6dju3FClLBh7M/mgjFXfp+/YR
 FE/C3wFFhmWbYdRC+mPJMljKKFrkc56zEmgK8yiSvlw73D/PDnCo6Lxhr9RJBEeyfTLvwxTEC
 tCVoTCzA5d7sPuAfUm8ZrakUWhEfDWSqc82P2FS08GN/xeU7mYp5ni0veHQrbqtlS45OrrWr3
 na9P2r7JZt8lEGNI6wFE+cskUjW9eMJgODg1IBy4WXQKDBYSZS/N91Grbi/c4ePLP6fKOyN8I
 wi0k7p5L4w13e5ELEXAF9FI3wrdo+OTTaBbgHA6YnaAdFNIjZw2uZg1irboTt6f6jgm5xd+TM
 i+nNy+swjjx9G5VYlyS4uMISj3ic+O8LXW5HnoF7ETGLF5mUqj2u1JISxCsQunlIWGq0a8RYg
 ax0vU7br4K6zgNG6Frt4qL281HrBoNZPtCxITC2reeoIPVGHjoLE18+ga2fHjNHM/WLApqirq
 6IzMBexwanXk1RPss10G0cBG49g8QgDMwK1i2cdOoqk1s668yku9pEA/sxIxICVR/v5awWD1z
 PRZl8SAs3CDn1DcRZ8jsbwh2+1NoTdhNGP62RFCV1f7WilQRA1Q26qrScZHS584cgr5lm7cIN
 Fr68wT6HBBAExSMTDvOnyYC60XtgrfLNcYrR1mTNFxSqipHfHUqQBpiEV/OQmfYguIdeiyk3L
 dWCvft3s+5Yfd99xLXoHhHnX8VI=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user reported that on this machine, disabling BIOS fan control
is necessary in order to change the fan speed.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index 36d41262d579..6aa5a9950dfb 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1474,6 +1474,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
_control[] __initconst =3D {
 		},
 		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
 	},
+	{
+		.ident =3D "Dell Optiplex 7000",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "OptiPlex 7000"),
+		},
+		.driver_data =3D (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
+	},
 	{ }
 };

=2D-
2.39.2

