Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E08134C2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573803AbjLNP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573805AbjLNP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:28:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6571B121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cea1522303so5343278b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702567711; x=1703172511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYiJim7EwvZmICmF4sAaIlVhRyzTthGFrkGF3qQRcUU=;
        b=gHa29scq/fcMBvoDgWgvC1pgQ6Kp7ka5QwYQCh84yzHpsKu4CresfdzruV5PIYYvPi
         aSKsEfjPiyYNsV5bAAvSxmM3UaObYvGVCk+pajcTfGsx3cXlr49BrWe2MJjDtwBFDZQx
         6j/3p6s9KrgPekPewi2Z8Rdb3nghmr7cp795s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567711; x=1703172511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYiJim7EwvZmICmF4sAaIlVhRyzTthGFrkGF3qQRcUU=;
        b=ArCV0T6+Ba6drqIUjyTh9pWQbNMBakvsp0ytqam/R++VdfzCZYadu9DQUJkzToWmc3
         nTrvz6RtJM9OULwuiFkdPn6H9FKem5D7gm5OZfoAJbTb050hnACXqcJlB/RKcUd2ktBX
         GEjsGl0Rxq34jTMbCFBPj1TB2W+cexSh6RAdG8V/XLjuQIh8y0WIlRUarKvcbUd5PpvG
         5v9RQRIYoc8V/Qt3bnjAs3DzGep923tjpfS40jbAuzqVxWdYjG+M4tJRf1rtZcdWqrY3
         +HUvbCBle03WUUNLx/zBm1PzERJStMUocy0AsB2J5gAvv/HlJZyEcMXLOCd42xP57G25
         ScUw==
X-Gm-Message-State: AOJu0YxVFxXMcgLi1ct2r8BHZ+bXHm30dP3W3JRPQXwG5cRve2kmU1Tf
        v65XiTCeRWQ0eN5WiH19qYvtNyW0cKPSu7sDoI0=
X-Google-Smtp-Source: AGHT+IGIwxJpdQroIIQ+oxSvIKisGyjF7WjwwR/b/nYQSjzCW2uENfxA6GXHFMi3aShXzI5LmOcVNw==
X-Received: by 2002:a05:6a20:1445:b0:18b:fe45:90cb with SMTP id a5-20020a056a20144500b0018bfe4590cbmr5827576pzi.54.1702567710859;
        Thu, 14 Dec 2023 07:28:30 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:6530:8349:4ba8:984a])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b006ce7bd009c0sm12281179pfi.149.2023.12.14.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:28:30 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH v3 3/3] drm/panel-edp: Add some panels with conservative timings
Date:   Thu, 14 Dec 2023 23:27:52 +0800
Message-ID: <20231214152817.2766280-4-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214152817.2766280-1-treapking@chromium.org>
References: <20231214152817.2766280-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These panels are used by Mediatek MT8173 Chromebooks, and they used to
work with the downstream v4.19 kernel without any specified delay.
Back in the v4.19 kernel, they used the "little white lie" approach,
which is making the devicetree claim a specific panel's compatible
string for many different panels. That was a common solution before the
generic edp-panel driver.

After we uprevved the device to a newer kernel and used the edp-panel
driver, we saw multiple devices reporting warnings of using an unknown
panel and falling back to the conservative timings, which means that
they turn on/off much more slowly than they should. We tried to fill in
the timings for those panels, but we failed to find all the data sheets
for them.

Therefore, instead of having them use the default conservative timings,
update them with less-conservative timings from other panels of the same
vendor. The panels should still work under those timings, and we can
save some delays and suppress the warnings.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v3:
- Update the commit message.
- Collect review tag.

 drivers/gpu/drm/panel/panel-edp.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index b059f5895d3a..e23737284f31 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1955,6 +1955,7 @@ static const struct panel_delay delay_200_500_e50_po2e200 = {
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
@@ -1965,6 +1966,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140HAN04.0"),
 	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0",
 			 &auo_b116xa3_mode),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x435c, &delay_200_500_e50, "Unknown"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY2('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1",
 			 &auo_b116xa3_mode),
@@ -1974,18 +1976,34 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x8594, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0xf390, &delay_200_500_e50, "B140XTN07.7"),
 
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0607, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0608, &delay_200_500_e50, "NT116WHM-N11"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0668, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x068f, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x06e5, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0705, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0715, &delay_200_150_e200, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0717, &delay_200_500_e50_po2e200, "NV133FHM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0731, &delay_200_500_e80, "NT116WHM-N42"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0741, &delay_200_500_e200, "NT116WHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0744, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x074c, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0751, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0754, &delay_200_500_e50_po2e200, "NV116WHM-N45"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0771, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0797, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d3, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07f6, &delay_200_500_e200, "NT140FHM-N44"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07f8, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0813, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0827, &delay_200_500_e50_p2e80, "NT140WHM-N44 V8.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0843, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x08b2, &delay_200_500_e200, "NT140WHM-N49"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0848, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0849, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09c3, &delay_200_500_e50, "NT116WHM-N21,836X2"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x094b, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0951, &delay_200_500_e80, "NV116WHM-N47"),
@@ -1997,6 +2015,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ad, &delay_200_500_e80, "NV116WHM-N47"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09ae, &delay_200_500_e200, "NT140FHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a36, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0ac5, &delay_200_500_e50, "NV116WHM-N4C"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0b43, &delay_200_500_e200, "NV140FHM-T09"),
@@ -2007,11 +2026,14 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1132, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1138, &innolux_n116bca_ea1.delay, "N116BCA-EA1-RC4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1139, &delay_200_500_e80_d50, "N116BGE-EA2"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1141, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1145, &delay_200_500_e80_d50, "N116BCN-EB1"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114a, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_e80_d50, "N116BCN-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1153, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1156, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1157, &delay_200_500_e80_d50, "N116BGE-EA2"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x115b, &delay_200_500_e80_d50, "N116BCN-EB1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
@@ -2023,6 +2045,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 
+	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d51, &delay_200_500_e200, "Unknown"),
+	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5b, &delay_200_500_e200, "Unknown"),
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
 
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x048e, &delay_200_500_e200_d10, "M116NWR6 R5"),
@@ -2031,6 +2055,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
 	EDP_PANEL_ENTRY('I', 'V', 'O', 0x8c4d, &delay_200_150_e200, "R140NWFM R1"),
 
+	EDP_PANEL_ENTRY('K', 'D', 'B', 0x044f, &delay_200_500_e80_d50, "Unknown"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116N29-30NK-A005"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
@@ -2039,9 +2064,15 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "KD116N5-30NV-G7"),
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
 
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0000, &delay_200_500_e200_d200, "Unknown"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x048d, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0497, &delay_200_500_e200_d200, "LP116WH7-SPB1"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x052c, &delay_200_500_e200_d200, "LP133WF2-SPL7"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0537, &delay_200_500_e200_d200, "Unknown"),
 	EDP_PANEL_ENTRY('L', 'G', 'D', 0x054a, &delay_200_500_e200_d200, "LP116WH8-SPC1"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x0567, &delay_200_500_e200_d200, "Unknown"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05af, &delay_200_500_e200_d200, "Unknown"),
+	EDP_PANEL_ENTRY('L', 'G', 'D', 0x05f1, &delay_200_500_e200_d200, "Unknown"),
 
 	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
 
-- 
2.43.0.472.g3155946c3a-goog

