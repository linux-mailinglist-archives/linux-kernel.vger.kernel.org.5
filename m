Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5A7EBA41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 00:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjKNXjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 18:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjKNXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 18:39:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D98D6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:39:02 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso7641339276.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 15:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700005142; x=1700609942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZSEtY+njRAiu0GYzdRgb+GnODRNCZkyR37gEfuHfGo=;
        b=xlp69Z5aXmOvRzO+F07KwUuHdZtsKa2AJS/iI8wZPY4LeZfdHWLQlhG4JSeRhMyZ9N
         AKIUmdTi5mcM0tWEZYIsgS43zPGw5qMNAwEtflwkyZ9sUPg3RWUK59dpSyOv+9iRR/oh
         YQCP7+ohNfxYylxTtir71YYOKDQevj3N7rFh7KEX0cBGY6qDrQdsoecRXj/79sVPTABu
         9eqGybLI1r6+BPcnPK5O/cd5JAu/UiOQlhOkfreHjEbY+x77l+aJPjtRDdmtFtPjGMh1
         QeKElVSYf3l1jocX9p9z/70vKMdp9pqYRJnMTbaN14LIeciNyFbftM0yVyNqlkx3lRzy
         alXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700005142; x=1700609942;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZSEtY+njRAiu0GYzdRgb+GnODRNCZkyR37gEfuHfGo=;
        b=smYXmE+8UI2MS/QZpBZCCUCOLK9ERiAX5Y3wFLtlB0HW38hJNrD2YxMnWOFN8WkFLh
         neMyOMzgXW4u3BOjsVqR+jsNDdZeaEprsGv++R+7KTULbqUOuHqQdUWZ051nYH88iLlm
         DT8Pj0Gqbs26qVBlysUhnBKIQlvJ7sDaNOLdhHh1pUrrwOnYu3Rj7z3upZD5Ozd1XXSe
         6jPJhYbv8dyKCxlQlUG49erva6J9sMkwIVBsNJpemgB30XXw7M86S5Bt4aA9plaWhxDV
         poTbgijaYNF0pb4thy04Pka+HCxzN7tAEpiPv1AhL89MZuBmuDP6/L/fq8Xk7WcL1y3s
         ZWcg==
X-Gm-Message-State: AOJu0YwA/7kTH4ewUByqL+Pm8FZxmMiKquy0nYUJxILMs7tR2nPOSfOQ
        P4hLIQNsj8egSuAYqkEqg012xS5VoXmNXg==
X-Google-Smtp-Source: AGHT+IF2+J9zUaCqtjZyC2e1XS/WMUREVhz430FgmPyLras+ygUohJOY6dED4RMAaJMqD9lxaWjpVtd5esVw/A==
X-Received: from handlebars.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:34a4])
 (user=brentons job=sendgmr) by 2002:a05:6902:206:b0:d9a:e3d9:99bd with SMTP
 id j6-20020a056902020600b00d9ae3d999bdmr261842ybs.5.1700005141976; Tue, 14
 Nov 2023 15:39:01 -0800 (PST)
Date:   Tue, 14 Nov 2023 23:38:59 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231114233859.274189-1-appsforartists@google.com>
Subject: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
From:   Brenton Simpson <brentons+appsforartists@google.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Brenton Simpson <appsforartists@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Legion Go has a 2560x1600 portrait screen, with the native "up" facing =
the right controller (90=C2=B0 CW from the rest of the device).

Signed-off-by: Brenton Simpson <appsforartists@google.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/d=
rm/drm_panel_orientation_quirks.c
index d5c1529..3d92f66 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -336,6 +336,12 @@ static const struct dmi_system_id orientation_data[] =
=3D {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
 		},
 		.driver_data =3D (void *)&lcd1200x1920_rightside_up,
+	}, {	/* Lenovo Legion Go 8APU1 */
+		.matches =3D {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
+		},
+		.driver_data =3D (void *)&lcd1600x2560_leftside_up,
 	}, {	/* Lenovo Yoga Book X90F / X90L */
 		.matches =3D {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
--=20
2.43.0.rc0.421.g78406f8d94-goog
