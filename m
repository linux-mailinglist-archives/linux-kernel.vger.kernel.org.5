Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158607E1A6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjKFGox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjKFGok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:44:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DF1B2;
        Sun,  5 Nov 2023 22:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699253049; x=1699857849; i=w_armin@gmx.de;
        bh=MQPUERicBJJRDMF4W/kXlZC+dzTUoedRndJooh1HUbk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=J4HuOsqdHF/vIBRM/3wblGBlL1EAFbmHZ+g+a73lmXweU7RyCMHB/mBLhSAVPP+s
         OCK/o2LZtvrRGYzyOeoQlOIp11kD9zOPJ8PsiZBLENYQyZk11dk2z6lGfwOmlcIQ+
         tpdX08JlnWvRMLmyl/BhyS1LB33UhP4faq/Dz+PKSVuAyGhl3Ql2TO8xLb0McUeX+
         f4JHy7pu9fU3FDgpDYl2v7gVP6Hl6W4a2yYUWo58oIlY7iVNK1M3iIRpSu+P64KK5
         XY/R5FaYLO75LYTPB8Kl5vLdp7HcNftAOYosuJ3S7C8c8+nVO0xW5hxJ0pSdq8kd7
         zCNsORWO2qU7t8pwzw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MFKGZ-1rBCvg0Ua9-00Fmtx; Mon, 06 Nov 2023 07:44:09 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
Date:   Mon,  6 Nov 2023 07:43:51 +0100
Message-Id: <20231106064351.42347-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106064351.42347-1-W_Armin@gmx.de>
References: <20231106064351.42347-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0+stoqEg4cHrsuc3kz9u/+7T39UEgTwIiB8neexhZoByMR4Iikv
 Ex+2vFKgMsbgbvC2B94xzktGQtapi9fmW3SEOhbfC/vewxpEz5R8Z4r8/+IESlLdEL5a6yL
 XXgPJKiu3VtbDP6/WnzPXdwgUJynxr5qgPIdt1yNvQ5weWGX++lUULxJbTIwgItXwjEmP65
 Kd9rGnRQ/9LcHe8XkU0hg==
UI-OutboundReport: notjunk:1;M01:P0:O+MY/XD7LjU=;Sy9o4ocLhD3A0k8rT0wasikLI9e
 Y6QeJYe0fk91VSztEwZqq8bp5vMdElSEefTUvlIFK7GtkjN2ViG9392bzjjL+cNJkJWv2+uYe
 dZfs2Nzi7iDZcqqAoh8+AJSkjTA4W/jpuRQszOT5OA+BrLV+udy8ZmaXJq9oMGRD4RomlK2gg
 gwDXbbm8MZEJTOFw/e4zKRhOjkWn25SegNLaNe+qQut76PUOfaZ1uG5q+8qQ/nvD+BNKLoz/j
 YtFwGobRzO3dT/CyrAZQmGTA8312ltKxhiJPBlpJ34Lb9vq8znzMDe4QRRj5MfYs0mAaxqHtU
 zEEM4YLtZ9lSb2ZdccWmPONjlLUaPYbcM5RoPixaf0GHhGDf3o5RwNSEoDBPsK62YypOlllSI
 ZCzqlocu+fZwbLtrc5KHzbSH32lwIjxEdid1de002DzgZoX/GDOv86lazQz8/7zgyv3B547pt
 v7SE0ZT2STOdSLL8BR89MFwG4wFJyEbR1JlnoO9u3adrXftnsVaYKRRGQ2mulWudgNt3wnWgs
 nEmPeVNMNeVOjhLX+gnGE/iVA5QGcZ441xyc75Sgl21jaJuZ6vU2ShATDExrbLspUWYvv5hbl
 UHYF1BJMNNiTHlTFniEZW1hRJBkX7tnSkguRWOIyS8iV0/xysoW50wnZADU/udJqj0+2cZRO7
 zXv4RtNhjH6sIU7WKN7Sb6ZiXDPu5Y8XCwILXJNAUEZjYsMJ9Uno9P6v2JR7dY7mN+PXHvB5E
 SFvAEMbtkQANa7rnvgEl/1K3UzxwQ62KKNKLf3ChnoW409hfF4GBctjf9c/sK/+6ugigvPvDy
 m4ngzAaplwd2JbgDEdgw5uwaH/Qw/oOQkcWBHvEPnxC98J8stgf/+8rnQCA0ehfeCtoEmsjqR
 Ou8PjKOOUGz+MajF0kCDwfHnla38NPI9iuGs3QjaA95ZZqw1DjeJKYEZtjOtAIQE/e1uDMhSM
 ow+2Dh4AM0XcV6CiaanN4G0XBFE=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A user reported that on this machine, disabling BIOS fan control
is necessary in order to change the fan speed.

Tested-by: <serverror@serverror.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon=
.c
index d1bcfd447bb0..bacd71043a16 100644
=2D-- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -1508,6 +1508,14 @@ static const struct dmi_system_id i8k_whitelist_fan=
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

