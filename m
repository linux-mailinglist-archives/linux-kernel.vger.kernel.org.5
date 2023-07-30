Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD97768805
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjG3Uhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjG3Uhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:37:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6BE7B;
        Sun, 30 Jul 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749449; x=1691354249; i=w_armin@gmx.de;
 bh=q7OP8V2DT813Vh5AtHafrOKSFe4UpPHy9Xm2bDdU1kY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=kowpZfu343ZK+RMc8H2L7q/Mzd4NQ0gMBL5b2wfvDfytLI6aaRHBp3ZOKEFXXzYo5Hw+vfw
 6xRFIYba3RqFINQqZ1Wc3qk1mmTYNf49cd/EzSK/uWvnLmA8hkVMuvKQjLWYQVAIs6AFGZa8j
 Kcd/+G2DG6CMimmxKXCnaxepofkWHN7JqnV0FrBqP2xIggv6YHDtpZkBbK6R/8+CoLHypMa9k
 gYekBIXbjlDdw2HsAQRzhNFxLF93bbQLy84zWzv/JdcbMt1I5e9kjNgf31KqyXZPCXyMdubTg
 9kqKIAoWeIxcIpfUfJlIcbe6HBaIA2J7qwfW2hgUogfkURb2V6nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mg6Zq-1pvpxu3Lgs-00hcts; Sun, 30 Jul 2023 22:37:28 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] platform/x86: wmi-bmof: Use device_create_bin_file()
Date:   Sun, 30 Jul 2023 22:37:21 +0200
Message-Id: <20230730203723.8882-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CdbeZQsXtKr9gi1eNdbTGVnk8pvpGaJz1jXBA1gTTkaiEr8xSPK
 8E05q9XA7a2Pq8W7CvwcN9x1uJMbjLYIzea8aCDgfsGnRdoAo4jDMEzzlGsIgacQZjcCO/U
 8pQvelw/F7DBpbfEeBPuClURw2XZrTQFxP9rOz4JQt+ucL+NO0+/LYls1q7aBQattOtEXt+
 pY7oAfh2B8RLTawWdqUEw==
UI-OutboundReport: notjunk:1;M01:P0:WWo3pNYYI5o=;sbV8szpItLDdEUNWWVcud2Sls2y
 VYmyEzUdqwOONARNTHJ5nke28qFWModApFJ4PFUwv3Vfh5edVii6spFasUdn5nAKnZ8vF8oLg
 kBVAdXJoDGuO5clpzzuPgI4EMIJxbypgCjpFWB8TTN6N2Az5HPjqBvut0nJjNGZ5DnhmvKeiT
 2Vj8yzEFrQeLCdXW2Ngt/nKFPuiplnp6zb9+GZ2kF8FiEYdmWZSngfpovqz6CA1CrB9UNZF1Q
 9E2qGVhvH6tcFRRcdnOf22HAa97IWSBe60BaVwojguXHh0RXMycXxvhaboh3uANPfiP65JN+G
 U94hGQT6DAw2mQMUqahA+/RIN41vtHbpdNLvmhPO44Yo05Lsw1BGEzPQ8u08oD6DkVTMwCwYv
 qvumQPE6ZVqgfJYo/v5a2pOB4tnH3XBVEwaShhJcjutDQjR1ZUiPRS2ycKjhzJ2rDk3hADeH0
 MioLiJc074v+q2umhe8KZM0fit3NPQR4gn8lB+2rq1OESOpJ4zaASucHyr8g+l1fhm1FPFV/B
 FeQq3J4OkThcMLf88o84+5k/rccaB7uOxqs1o59WnlpGHH22m/PqEn8Bc4jYcuinhBCFenJXq
 KLXiBUZQHtY6LkGq+dbTkidQ2dOdON0h/CdsaHrulfI8wSM5tlvc1QwUm3eI69M/io5YvQNiI
 jPJmB4NQ4L1WZaI43slwvxKz1iX/p+4vfRqJX9590WiG9B2ghFXn2T9bI7/aTYzDZNhNLjyqi
 EsZxzc8GtZeUE6X7bCOyVIID+heWxZA/banfaLg4uJgNJwiDwT877H/goTi52oJGib53lNVdT
 Fiu4a7t1hRY8Ynx2W7ZAumUSYC1KBkK2F6+yCMQ8tR6AMRaoARVy4Zz/fe14/VbN6Qc4MrELw
 cus0oYKjSkbgntdMNuvYW0mJusmthWzmBY+s3570uRaP67P0M/WjWkY5Z0Uw8dL+0mLYLOOqW
 i4gtmaobG2+7gm8YkvHYly06LQY=
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

Use device_create_bin_file() instead of sysfs_create_bin_file()
to avoid having to access the device kobject.

Tested on a ASUS PRIME B650-PLUS.

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add Revieved-by and Tested-by tags
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

