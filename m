Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1E8805455
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbjLEMgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbjLEMgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:36:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4137182
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:36:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso1791704b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701779809; x=1702384609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UwqFDeGV6eW6XdPYpX2kE/NInLRVcN8eq+ZIooofQY=;
        b=Cw5NUypTTdzKfmGeXuvbkTGC3jZ2Pq6YstxF1FeV/ZHry0jaNXdR1fPIuYf2USlR5/
         RUomzRX48zTssXshfEExTPG9mVrrjVi90/KoRkTPgACguvQCkq8LlFRdrtLIgwjxAxzn
         qIjBDTU+hfalj2FM7VvAt0I8p2Tu94Dlxv50s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701779809; x=1702384609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UwqFDeGV6eW6XdPYpX2kE/NInLRVcN8eq+ZIooofQY=;
        b=wXVDIy7SGO47mJyIm7Qw/vyfVKfuHS5Xnx/IITdMizOQfXuhDcqMdI8cc/3aEylDRs
         +5vtuIhJmzkwF3eIX8ClVVRWrH0g2ECY6CbEOOfJ1GAq0zVlGA14W1LpRaI5jMQr/Vd3
         v179pVIrUboacfrUpBWeYBqvlEO46hN57TT6DK8vC8f5PlaB2lmtYCzwm2zzWoUmH+7X
         bwQm8HR764LG+CvUPbVRDE28eg65w5BEZGDT1QxVSRSVXqlMgyW+17zLF4g2wgUkluPD
         s49IZ2EsG1ian7RJ+YoWw2xik2Rsyxp+EwOxg9iGM5LqMZv/PNiKv0/p+r/i/5oSfl82
         o3rw==
X-Gm-Message-State: AOJu0Yx35Cw02Mu2XS8nKIn4d0miTD40W+9BioDk0zmbq3CDMQbuWevd
        mUbAYvpW9J5YKrNRcFJ9168e/g==
X-Google-Smtp-Source: AGHT+IFHozXEbLedjhGxYPoLzJBDZRAuFZw6UtdjR8BL72A6PhNEbQM53COb7FZCJSMVj2+wWbAoAA==
X-Received: by 2002:a05:6a00:21d3:b0:6cd:e046:f3ec with SMTP id t19-20020a056a0021d300b006cde046f3ecmr1073933pfj.5.1701779809258;
        Tue, 05 Dec 2023 04:36:49 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:433d:45a7:8d2c:be0e])
        by smtp.gmail.com with ESMTPSA id p26-20020aa7861a000000b006ce7abe91dasm285115pfn.195.2023.12.05.04.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:36:49 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH 2/4] drm/edp-panel: Sort the panel entries
Date:   Tue,  5 Dec 2023 20:35:35 +0800
Message-ID: <20231205123630.988663-3-treapking@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231205123630.988663-1-treapking@chromium.org>
References: <20231205123630.988663-1-treapking@chromium.org>
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

Move the order of CMN 0x14e5 to make the list sorted.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/panel/panel-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 819fe8115c08..e0a18e17d3a2 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1987,9 +1987,9 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x142b, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x144f, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x1468, &delay_200_500_e80, "N140HGA-EA1"),
-	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d4, &delay_200_500_e80_d50, "N140HCA-EAC"),
 	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14d6, &delay_200_500_e80_d50, "N140BGA-EA4"),
+	EDP_PANEL_ENTRY('C', 'M', 'N', 0x14e5, &delay_200_500_e80_d50, "N140HGA-EA1"),
 
 	EDP_PANEL_ENTRY('H', 'K', 'C', 0x2d5c, &delay_200_500_e200, "MB116AN01-2"),
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

