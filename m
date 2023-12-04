Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D1802E30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjLDIyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjLDIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:54:30 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DACC9B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:54:34 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09d0b045so11046595e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701680072; x=1702284872; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IsEvf1UWeFflvqJIT9N20f+Hk4m+lbh6KScDBJtlrds=;
        b=ODEXPiIWNDW9Ht0oIWS15Cffy3PBD8BVJ9o4BsOrc8Mrw0V0i7eFspumqZJCLHCMNt
         bkqJ8fhqdoTSkm0gLRpCgAbULL3LpFeWGoRUPT/umhWZgXIJgi3BUfMakIbJTj/q6ghK
         1yLwG3eT2k16EHx/xzOs6C7LjHJz55Kb4QOhGP2McPZ8LrIb5X/MPz3n7X0b3fVde6E2
         9dO8T0UPQyhwBPsyVBaPl5Wc2O6wBnVXBKWt6pcMbzlBQBTp9AxE+8MRLd6XGSsvVti8
         iuqjmfqUOtpIlNTB0WTgKpFvS40KHqFz08ERbWVmoX4HAU6iCplVyEYHme8Dmq9CS3WV
         8AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701680072; x=1702284872;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsEvf1UWeFflvqJIT9N20f+Hk4m+lbh6KScDBJtlrds=;
        b=tZxiGDmR7+0Ewy7t81Fr8aBaT2OZm7A/wh3zgXn9A/x61X9y9gp5K/m7OrRSo5uZff
         yMiSgAV56zXpxqvbaj0tSXi2LDtxo/Bp+JxAYUejE0lueOX9JdBO+jEMKoIli69Vltsk
         Nj/VckO5g84wLyVNd+CXe2AU/qx2Noqpa0wbHQUDaOKPf50NODLNdDnsSZfz8vhgrBkE
         7U5IG78mqU2kMpK3JEsQxiG3iZymnVGN4tv/rFYg8bUIqK3LA7UWdUvGO3rIykgRBUxz
         xULWQ+eydWDJnndOpmopaaVCBjrZ9BWy7ascTUf6kDLdBQl6YPmJJQmTTuMDDOnNc5TR
         EDrA==
X-Gm-Message-State: AOJu0Yx25frchjSrPWSU0+Yg2N4U8etVdG7ExUSdADR9hHvnbiQkKRDG
        +o1VpVDHOsYBuG6jNSWbyG8br09rrSeIR7pZyHI=
X-Google-Smtp-Source: AGHT+IH0r4KISOv4zNLTHDu5aAObSJfPRuwpaA2b804m+NoRAtFaT8xHRVLh9GA+fEiOEeWqWLvSZw==
X-Received: by 2002:a05:600c:4f04:b0:40b:5e21:c5e9 with SMTP id l4-20020a05600c4f0400b0040b5e21c5e9mr1711141wmq.183.1701680072148;
        Mon, 04 Dec 2023 00:54:32 -0800 (PST)
Received: from [127.0.1.1] ([82.77.85.67])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b0040b400711f5sm17963958wmb.7.2023.12.04.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 00:54:31 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Mon, 04 Dec 2023 10:54:25 +0200
Subject: [PATCH v2] drm/panel-edp: Add SDC ATNA45AF01
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-x1e80100-drm-panel-edp-v2-1-b0173484631a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMCTbWUC/4WNQQ6CMBAAv0L27Jpu1Qie/IfhUOgCTWrbbJVgC
 H+38gGPM8lkVsgsjjPcqhWEZ5ddDAX0oYJ+MmFkdLYwaKVPpBXhQlwrUgqtPDGZwB7ZJuTmbHt
 b64viDkrcmczYiQn9VPLw9r7IJDy4Zb892sKTy68on30+08/+/cyEhDw0locrka3N3btgJB6jj
 NBu2/YFNmlYctIAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=LBmH7u4KmtRScnC6X68jFgBzF0WRRB7mXPFU47y7t2o=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlbZPCJl0hiu7IjYuG+DGLBQfQJ6LEb0gshDxsg
 yGqwiFeC+aJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZW2TwgAKCRAbX0TJAJUV
 VgN1D/wJGfLSpDM4gKqzU66yRFsrXi92I74q6ZJnpPGuNwIil88J5USzuEBJiPoHFFrtwB5nAM7
 C6RQ+HZIOYtsYBN/cQ+Dvd2HWAxuw7JbKNpJ7OgzzVLqN9cC0jYKD9/Fq4z2a2hqqz9SelH8kWz
 PmZL5uP1Tn0Mw3aGHZbD909D5JV+LPs+hCOae/rbuRhoRJGQ5BJ7kx5Bg8KD4wF6UJ7Q4NNUyUg
 dsakX3SmxceFt2zn9LQfOxmQAMOYk91DzyXTcv0BJhBEfkRnwy3R8VvTONR43bNbPFrdKgkGx9k
 p8MBAm6I0/x45Q9VqjHYQLMI/vmce8lut/fU5lLy/aq06P0M4Se3CjT7tW3xZ6yx53tfRLk8Kdx
 RqpfOg7VNm9N3ruSTWAChfasghcQrLqabawVcnDr56FUuDcP/3BSZS3cV/REUrxe9KCTwRJv08q
 7OOccFhSGmcWKRoFIgqS+xNO8ku4lBRxWpSloGlt1fJF96ttX9RpS9Dn6OYigx4lcvcyf8DHPgi
 SvRZQBaK7GTB0nEH98k9iZ/xPur3euzkV1cHE+DeoWAArPBQcv7jpMa406grApJamSTjZixfb4o
 9GZU3l47XVz9OWWQz8KPd4LdF9oZnGA5ujLoK5lMYJWgtRyZFqMjTaBu/uoASI9I6QyF4rSkDpv
 RNLoydugxFcdltw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
Changes in v2:
- moved the panel entry in the proper place, as suggested by Doug
- Link to v1: https://lore.kernel.org/r/20231201-x1e80100-drm-panel-edp-v1-1-ef9def711d8a@linaro.org
---
 drivers/gpu/drm/panel/panel-edp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 825fa2a0d8a5..78565c99b54d 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1983,6 +1983,8 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('K', 'D', 'C', 0x0809, &delay_200_500_e50, "KD116N2930A15"),
 	EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
 
+	EDP_PANEL_ENTRY('S', 'D', 'C', 0x416d, &delay_100_500_e200, "ATNA45AF01"),
+
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1511, &delay_200_500_e50, "LQ140M1JW48"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1523, &sharp_lq140m1jw46.delay, "LQ140M1JW46"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),

---
base-commit: 5eda217cee887e595ba2265435862d585d399769
change-id: 20231201-x1e80100-drm-panel-edp-e94dcd8250eb

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

