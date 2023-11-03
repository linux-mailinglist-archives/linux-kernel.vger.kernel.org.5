Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDB97E089D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbjKCS6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345845AbjKCS6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:58:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF4D56;
        Fri,  3 Nov 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1699037859; x=1699642659; i=w_armin@gmx.de;
        bh=LuMCtjACOVYnpDtxsjjahjgFvWMOMwqZbfqxuMaMooY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=idhgt3ERxHLsk7UKryZbVHPWrEdXnBhsLa8Ir23filyiQkVrSdMIE3VBKgRg0Plo
         /dUSMeTVb9jqdhRqGRJxCmq1io2BEwrM+P9p8tuGiW8Fq+FLYYhZ4CjW1twx+ejK2
         /fgqJLl0s/1cMzocY/Q6+On4bXi4J9IsR0gNOhSpWSMAdEnKwXWGdhSxKa7TKX/bj
         bf/xj8R53p64qUKM3vsHFnSjsS2GSs0uPHztM8zVgdYrdl/dImiTk0dpgvjH47jSc
         j+ti6YUKF38Oq3mcOlUgF3tOKEFz7soIULFxn0nOxfz1U525A21KKCG1H+jvKWhOs
         HbMk2ObOygyjsL2Dgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MZktZ-1qtkZw27E7-00Wiqm; Fri, 03 Nov 2023 19:57:39 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     pali@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
Date:   Fri,  3 Nov 2023 19:57:16 +0100
Message-Id: <20231103185716.11007-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103185716.11007-1-W_Armin@gmx.de>
References: <20231103185716.11007-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Gyrw84Hd6EFui4L1Icnd8Z5swXu2LsZafISLwyw97xdDmS4/kpE
 zj5OmmdVbZFzhF+LhUzdus+vleiGtcH3K6WNAjIGcA+y1KLN3sD5vY70yLOk189IcZPTtbQ
 o71TMfUMzh+lW08pJQuE+q6iUw4NldO8nwmwBdoPLz4/eCc3hCP/3fBIbLh0eGpRFEqUkUE
 0sdmDXwl8q4hjYovH/DVg==
UI-OutboundReport: notjunk:1;M01:P0:grDsVlJ6B/U=;/1ypuyIasRQ98sEhi0ZuQlp+R33
 5e6aFkUgErgJ7jkdw3y9gQAxKHGvQZesz1M+FMst+GAwNG7UVhWHJEvu3dHw2pF58OZk0RdOk
 /xaZetljFLhwgD9zfDjp19dA2RQpbpJLRLE20/q9T9SBECLMgt0o9cBoeE3G0fh1EBCLkjqyV
 33domvqI322EINO0k1/PdzPz2Sxr1xAD9lq2BWiwuWi330eN4KNzCkGmg95vqyZTQCzQDGS3I
 asnVf0VzFO6t65mPLs1ngf08AF/5INIyOfUlr478DoXQNJVcyE3IqzWVxAZinxWvLNgre4bMB
 +anZVw7n1fdAhFQGoWSa6RtapwlwC1ltBdx94b6i8gUmvEAMAKjevMgH0MjFPFjrEwrGzrZTx
 1QJBNeBLbfn3MTE4TAR/Eoovv8w3HFH/3ADpuQ7AoXi9wen6g/iSXjH/djo7gXDzqHs6cO1BM
 B6m1xBGTZkSrU+/JBK19QhyarjKHw9eRbEuXH5X4tQaOoeMFRxl2HkhAViVkDCCw86slYy+H1
 SkZiwiRfof04aL03PLdN7Kaq6Kxct2u11Vd3u/utwWqVYY1/U0gSIflpxYAO2ShJ69ZSGmBWp
 LrsHtf9Cq7LRdgYp4Tw4HindfzKZiaiLe/YTnqT0gdZ411otEKfjM1ehGF+DPLCfAz8Ej3flk
 HcGBZZ3bnrtydR4wa+eUCmLVwOg6yaLC+JgqIIlh8dU/Wi+STeIaWydT/ixlEVbQOiCqrfp0B
 MMOZvuY5ROFNg0dPpPpU47T1cLjRWbeHxW550L2TFwIFux3GvIlbTyie9gfN4yv6tZpcsE81x
 q/yDjgJUATvXiPNp9AX95xr1CDRBlhaOQv++sPKGzH2OV5HrHAgwRplQyuVqHyoU5E5gia8kx
 /sboXTmocxKgb+pkJJW5+hQMe0vwspbeYhVVEeByOT0RpB1CYRgtEFUU0mhwCXW1j9wOtxo63
 lUAkaVyencLtQu1WuD+7Z+neDe8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

