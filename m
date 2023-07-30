Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063E97683AE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 06:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjG3Eik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 00:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjG3Eif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 00:38:35 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9C690;
        Sat, 29 Jul 2023 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690691905; x=1691296705; i=w_armin@gmx.de;
 bh=BD8hFlQwsdOyFI9NzhWM+aGWhlWruJtFDzKFX/mPS20=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Aaqs9WgUpFXoFMBasWsFu90ILhzXYU6QwBagSYceGlhk/uandX4wJREBbST9LgLJ3264OT3
 z/OwaAkFHL/LDFEcESo6quO1LoJBMZVj6xEF+EdmhUa1zgqww5E7wg7xKsedJ3l7aFo7ONfFH
 0QAkMd/ufzNMb1kiIuVV/iYDKZ2kbrMCWy2rryFBXzRy/VglqgX7Ehw1aCt4J2ikpfBqkdu3A
 zeMLPvN8r7KtkS9UfoFMdag1k+lpBPnrGXj1YO1Z/jG3oM1DGBhyN48q0Tfw0pOBuYkfYLh/t
 xpfbAANaD7d3nyts1CG6Z3/rqVuR+CgsbRlerxOSXmx2fsUkvu2g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N0X8u-1pcHxc3esu-00wY0N; Sun, 30 Jul 2023 06:38:24 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86: wmi-bmof: Use device_create_bin_file()
Date:   Sun, 30 Jul 2023 06:38:15 +0200
Message-Id: <20230730043817.12888-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T1uTsb7y5VIVnDKiXgPZOzjWPZIpfxC4PGQkNaHPeQsAZyWqW7X
 w/MP9O8ahGpiJZuGUQve7isw0NHtq9m+M5lDtNszJ0Kuh3octY1BBcFZevf2qsJuhPWj/tg
 i0/fYYae5R/TYSTGNkfbMAI4TlGS2C1u3nahRvaGX5fkk9OgL2tJ+UADxwnug1R74ecPAFv
 80tTrhPw8SKy2KqAh9/WA==
UI-OutboundReport: notjunk:1;M01:P0:40wm7Byt9GE=;r23/9AEoafCMS53crVWTWtqEeax
 7DJ/RqqW82A9oGPyemOGUki4uoWDehFSf9QsPeELIJ+CMfMWAcGZ3FwnRbvUHGT6Usl2r3pAv
 9kah7XVKlQCsicDYYJR/F6eggFYt3dldBuWTG4Crmu7AcNoduevAq6ybGzRy9c4p59rGDvpm3
 siCGPDn085Ctif8CqH/X0kkEUvLsJ4uESkjak7XMinI3pAdnGsrMjYWMbqhx86qbGp7zzEh6h
 j4g6FMlP7wS6aOP5UQugvucQQ9s1282lDqLrYAOUwy575gzuMulrZRop8HIPoy0BX4w4z8zql
 E8obJqEngg1Ck0E+TxceGExP2j4ppkHQYrEKlYmXuzh0723l7N+MWYrvvyUk4wY4sVsmNCY19
 bPJaKlvJWKTeqFg9Paon/xnMQ/86vVclpL7qPfta1A+IWB3OVnwEXARu4801qckQ5ZD8HT9Mn
 gHDB6CQuOrDtGRYM3aLh1+caZQ2vKfdRDWC4GHh7zr5nhcGsdNqvNqZEzBVNyUWNawfI3NMsf
 eMAH96ZxQILtphwaZhmWL//W23Dm+ZFAF3kIFI+xxlOKkdjocKi8NbNHEAcs47RM07pGrjCO5
 G8hhEtTRawYn9ybwrnfuyvYyQ4OdqvX5MxpE4UnppDIJD4RLkSwviDhyNpWvMNnADoZv4+JUu
 JAJtyGzOnwPoaMTL1z6Nbcr+6s0CEw/2VB9aHQrvEiNAiINJ4ox3BAVIgOXP4QXUqfhq5n0l/
 j7tVU3mdv7fO2Lp52SItIMRwauq9MsEaXInGNRXJzoxzBtoA48BGyq1mSAgRcr9yaR6cT/v3c
 YdIya9rxkLVSp2+xOYH/W6CrC1ASoT9wE+/Yf7g8G5bNRrKDc+vIbpHLweJxnzgSOVEkSATVr
 3QPOmCqQRNCYJOfcL5k/SgxccwBEIKiv6l3C07/LZ1R3ynwUcAOymY4CR6ksbIHHCBuinaOHm
 GQRgCvFi00Afc1NQRUwSr/1S9IU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_create_bin_file() instead of sysfs_create_bin_file()
to avoid having to access the device kobject.

Tested on a ASUS PRIME B650-PLUS.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

