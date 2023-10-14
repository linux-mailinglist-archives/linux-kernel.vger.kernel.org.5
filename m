Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3913F7C9752
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 01:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjJNXzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 19:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJNXzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 19:55:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F11D6;
        Sat, 14 Oct 2023 16:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697327694; x=1697932494; i=w_armin@gmx.de;
 bh=uY1qGoG8DwXFR3cJbwf2SefSXj8ENFekh4CpHmySjb8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=Ukw1aZ0SfePqoMPzWyxHx54LHOp8AfXe+fTlJXs+Zrx3Ir6hFucjeeyZeNdWy592mOLscE1e3DQ
 pp7/aXsCG4uWgzY0NaU3/Tb710bjOR8FDBgXBmAXLxmQE3n14yoBeCM2a0VdKA8vi9oZvNoHDquOE
 r93llIjrvbUN35yWy4jBJ3r7QN4QfyaLEfGJME86tccVzcklI5PPRjMz4hpDlyLU386zFmD5HnTQr
 kNg75PlsoRxF+Mjt2FPOIfttkmIWzoUW/fZLJeJ0sCqmOdT+nKBljJLRG8GlrM6CgV9ybje346oFY
 rUc90WhdPsIvISBI8CVCd41RfsyBB9UdRKog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Md6Mj-1rQK4b29cx-00aA3U; Sun, 15 Oct 2023 01:54:54 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     luzmaximilian@gmail.com
Cc:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/surface: platform_profile: Propagate error if profile registration fails
Date:   Sun, 15 Oct 2023 01:54:49 +0200
Message-Id: <20231014235449.288702-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fU8eaK1m1iymygKkDa8Hz3tq9Mg7u0521PfqbJU6QT0M+m8K41r
 IcyMMHXhHj00Xbz4+3V2fpt/J7cRwHBQSM2Pf5d/YQR4TgcEtnZwSC+imj33MUWXZ7PzmZq
 N9fE69Rgjbx/DRejbqf6pZp8UMKITJ81lNw+54c9YCU5dmBqnoYqyU1+e1YH3LCeAluULEb
 GvCrZ0QvVJeeBDr5RBbfw==
UI-OutboundReport: notjunk:1;M01:P0:wVRyekn5niE=;jdOiFptFGN+BO4VYEP5/YtL/NZB
 mzurxIHF2ZDPE7g+SwfbXU2+iT5KQq4EP0DqejkwbY1eSmVlRWGGkkSChzqfsQU+p/2veJxtd
 doMxz750tpAD/nlHtDJTfKDj/ZmHTPIn/G72OgVVJc6mtwt9bMQp7thfxMmOiTAt38pPr4bYY
 OF+6Y9s3gLNNtF7OtpuliTAws5whrgM2Zs6oO6E9GYWW454j3LdCFhMfFA7dPiMaMsIlktDML
 G+BPzidwZHPkBAeIH+QOBwVKn8LcOzLfUiumgJFXMiNrPZWKkKdNsQxALjzQvor8KFdXDyLwk
 U77iOSLSSR8bQLeuqjCHIDp44vPIUF/I/F98z3xI8HpQbSQdZ/SqmI3G4T40oE81WswNT9iZq
 vBx1dBLZC4twUdFHDMG26OHZxXepKcCJaIfACv5g+coWTSmUHnXP7wdqdQh1CuVO3nJCZMoL0
 6GuYOnmO8u05fFqTmXEHjNi8Qk2pzDjVAEsRVKm5/8iHGQwDKumcmD+rw8lUF2+gRAzx8UxL0
 f+5biIM4K+Y1mbU5dO9ADNAYHijviAPaUqplZy/4Qg65Rkuh+wHLUI/oe26qFaDyg5Ff+++ce
 M0N5MfMe6wbOPtCQFgEeFk6+txx5n7ZktG6uRcS0HtRVferZ1pFKUj30qD2jb9xEZqZVuoRfH
 yOafC8bfxQ7CYH6panCLNLgaGePWLqoNdgQAT0p8BwWiHM2Jh5bVLZVrDzWUrJThjaK/wpQBT
 K8aPTdmn1sDjgAtKVtHQZVQ8AA2dTf3WkFLEqsv2lBlXLdZ2LwdaElaAb+MOWnvmyoO3vhU3l
 Pu5IJw8QWYS3wfFHBt/FBfliIZTKCFPV53R5yImBA3VP387wsMuCb1+IuSFS/iaOtRm1eCp6r
 NmAzIt9svf+zpKUKGkDmhPw/XyFqJfZ/uoXqb3Zjy45UwARop9D/w1Wf7rsiy5GudxzIKk+ZA
 hT3qYuCKXWhhMMOC5Z0Yh5hfYFs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If platform_profile_register() fails, the driver does not propagate
the error, but instead probes successfully. This means when the driver
unbinds, the a warning might be issued by platform_profile_remove().

Fix this by propagating the error back to the caller of
surface_platform_profile_probe().

Compile-tested only.

Fixes: b78b4982d763 ("platform/surface: Add platform profile driver")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/surface/surface_platform_profile.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers=
/platform/surface/surface_platform_profile.c
index f433a13c3689..a5a3941b3f43 100644
=2D-- a/drivers/platform/surface/surface_platform_profile.c
+++ b/drivers/platform/surface/surface_platform_profile.c
@@ -159,8 +159,7 @@ static int surface_platform_profile_probe(struct ssam_=
device *sdev)
 	set_bit(PLATFORM_PROFILE_BALANCED_PERFORMANCE, tpd->handler.choices);
 	set_bit(PLATFORM_PROFILE_PERFORMANCE, tpd->handler.choices);

-	platform_profile_register(&tpd->handler);
-	return 0;
+	return platform_profile_register(&tpd->handler);
 }

 static void surface_platform_profile_remove(struct ssam_device *sdev)
=2D-
2.39.2

