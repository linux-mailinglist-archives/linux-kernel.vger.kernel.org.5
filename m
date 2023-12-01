Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE8E800B84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378960AbjLANNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378947AbjLANNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:13:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABD1715
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:13:25 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3332efd75c9so843696f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436404; x=1702041204; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bnGsvicGZc72MghsLvLQ88ck4/4r2jZIgUAyLD1bRfU=;
        b=pGoGf0zLdA7mjGj4T6odWd9/CUoYPUN5GPyb9XlvdTcKvYkVoeE6qHLUa4shxtexEV
         6AVwmONmQnOBk/4n4E53XtwcXmDzNl0NPSF8bmE35o7STXzl9njdnuInGOCGLru4MAFJ
         LNMLvSR3x0qvK+K4/t5GisFQjhDKquqPv4MYCx57a6thk/b8o/HDQUi2F+x7l1oRg4/1
         BkPyXeyNctq8ifPpNnBgBknnIVCjS8dDOqQlcv29rBK/fYazPxfIT5M8o2Z3rofzHuTS
         +Gwn5riDa/iYaJmb+FfjXyVtzSNPLD300VyKaiKtfUZ5PiO7eK7MUpne4NPmZFRo/AM3
         3Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436404; x=1702041204;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnGsvicGZc72MghsLvLQ88ck4/4r2jZIgUAyLD1bRfU=;
        b=KBSClt3P0hrR4t+BBjniDL4Jg5n46OC/pqJHfS1VUQQO3pK/vz7P3whkmF5dCy+6td
         rJfJZqw6VS54TpNu03AmUAHAwsjwZvhCSUj0TwV3K1Dsegj3uPoZ67C/OyBeBGv0Z4GR
         eWeNyVKHfJl1uW0oIB+rg6pOLE/Tb2Ygru1HNkGaxjBw6y51ygNbGqm/0+GLm0b2PiDr
         YPIw8YtoDnb7ZJ/siyYiBPOAqe8Q0u13pMyH6halL1M8eRleRVEprQe2CQXvfytx/L0k
         lvthDXGsChY9ICGppXDXBXBvoGDuHr72CP0brSdOZT9Md84VIhFFiI8DotuYfb9Tp5au
         rnHQ==
X-Gm-Message-State: AOJu0YyLOAYdb8zI1YwK9qsTweLNySK2T+TiB2NGOz4Wf7XWDEK4aM4O
        OlA1JgfBuOCaXK6UGwD1pc4lMQ==
X-Google-Smtp-Source: AGHT+IFgpB/zaa+hPymuzYotAdMvmq7wzEGxAZLM2pkIi4GEXLudxb6GUoWbgsIMqsulIThnbt1BIA==
X-Received: by 2002:adf:fe07:0:b0:32d:ad4a:bced with SMTP id n7-20020adffe07000000b0032dad4abcedmr465248wrr.23.1701436404142;
        Fri, 01 Dec 2023 05:13:24 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0040b3867a297sm5333550wmq.36.2023.12.01.05.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:13:23 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Fri, 01 Dec 2023 15:13:12 +0200
Subject: [PATCH] drm/panel-edp: Add SDC ATNA45AF01
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-x1e80100-drm-panel-edp-v1-1-ef9def711d8a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOjbaWUC/x2NzQrCMBAGX6Xs2YVNVKi+injIz6ddiDEkKIXSd
 3fxOAPDbDTQFYOu00YdXx36rgbuMFFaQn2CNRuTF390XhyvDrM4Ec79xS1UFEZujMsppzz7syC
 SxTEMcOyhpsXy+inFZOt46Pq/3e77/gOuNsj+fQAAAA==
To:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=Fu2shfYoG0HO7jjuIrpFa+x1f8tH/a5L8jGuumIndac=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBladvxfyRIJw8WA17MbH9nTInGECkTMZHdlFr1V
 oyR1lRJGfSJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZWnb8QAKCRAbX0TJAJUV
 VlOnEAC/9TdLPYnWFfzUt4V0p9vmqMMQ/5kdCOqcqhcdjt1YpFlqX1nEtbDvY9h8rC7J2P9TmRv
 KBNXD+9XKvum2sCVn0npc0k7QKalSakoznoC+igCDgV15HMYiHQMuFoUgC/1v9ccIFeONybGlYO
 q0r9Wx/MtnzRux03S8MK7XFXeItqeQy73NFWQOJxGTyYmdFUJ/N/76DvicHOKhh9mVgxKxx8Nu5
 jY7gmg8hfa/inYCEHsSEc3rojkvnW3jjj8UPo1o+xoEZ8k6kuj1pnBVgcC4B701MJnGJzy5o/Rz
 tSnIXl5QznotQDNa3hmai1DcPa779EFYm2gXwYEk+FI9IM7NH0FBhZi6CY/u7cXTWdTHVEEmnqH
 ZKRAq/ouXaP9kHNSn28qzfyGdcmAFEpYaY09pWIj/W+TUuGJ1EXoxy2SflGFEFNZ5ZrPNDXqF+Q
 UEzZKhjYwJlM2bzwAywfT3mtCEl89kQEPUeWXm4HvMfXl7NcgRIqHXB8nTr5AAWDGrUzKcSGxEM
 r4zpOU7TWWYHoqh3PHAHShGy4sp/VLpZNOZQ6nq5DZbpVM5xXxJpfRp6elrcoZ16GyRpOQMLkZC
 kbJQF/eHsdWb54wbF6tawz2j49lkylFAqKGHXNcCq94Rq9b8eiN5Ixggq2JKECPJz7f0JSGVxax
 Q79YHLs+vrPQdGA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SDC ATNA45AF01 panel.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 825fa2a0d8a5..467a42eddbe9 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1988,6 +1988,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0100, &delay_100_500_e200, "2081116HHD028001-51D"),
+	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
 
 	{ /* sentinal */ }
 };

---
base-commit: 5eda217cee887e595ba2265435862d585d399769
change-id: 20231201-x1e80100-drm-panel-edp-e94dcd8250eb

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

