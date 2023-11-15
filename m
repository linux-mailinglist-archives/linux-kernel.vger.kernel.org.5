Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7102D7EC794
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjKOPsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:48:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CE3AD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:48:19 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32d81864e3fso4136405f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700063298; x=1700668098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Atv1fK8QG9IRImkJmICqo13Yh62XKo59L6qcmg7lyPU=;
        b=cSITLFRtrQgr1V/2ADTAyX6WIGOl6wXZXT+tMN1tU2p8NcdgDXpEii/xJlTSzsRwcN
         3hV/wY/jZR1AmuvhyjCqub5wKnMsstx0CTTOCPJbAdDlozhBNUXOfycaMGT5pkCPTdkA
         FwAGk5to3e5AN7YDSI82SxDbfAPJKam+pT0BZMoHpUUsvb6D1DjnTF+4VHbeWwDzqKjg
         ABQx1CQEEbQ8L8Vb29nOX+eBkQGVsQhIMLJQd51YLdbMSaYyZGVftDv/qYQoiNJ+BeKi
         nj1+AwGpEh9YxqbK+SNO6grCZ6CDtKgdKLAFSmlAEd1s+DG79OPGfWK3BkY5mjLYyb6H
         f33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700063298; x=1700668098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Atv1fK8QG9IRImkJmICqo13Yh62XKo59L6qcmg7lyPU=;
        b=UZ+uN3irj7vsDz4MfQU274dCshCr7G0enegIRI/z06NWKeBIYWR+eXwLGEYr2dLxM6
         ysWidEe/I26/fq2arZT1SGdzeiSiNAtnNOwezxnDcGT7jIFkqKuvPd3szAPp1kS06BUt
         dTusrbN5CWr4IdGc+m7WeHJfFYYmfZ4n0AdYlqwIA+9QucHix4Yughwzjvp6YOFU+z0D
         fwEi2yG+JrKI4hnAKKu/Ey2UiZAxYvateSEbIqozqRcG/s5Bdf+m4vvtRPcfLLgPRen5
         S4ACjxh16uhXI48H1agPeMqRq1re9zwgH0eQgVWBku/wyYqFhKMS3C/ISQ4T4/14TPj+
         mSzw==
X-Gm-Message-State: AOJu0Yzf+h3XL1OJ0ryxMhB9mP0gzxvCv2pNkIfUCGoMsnZHH5reqmJY
        xUZL/iEfw9bO4EZfFclvDOs1NEdN+hBMzIDaFvt6uPjW5PcMV/m5x0soe5t4
X-Google-Smtp-Source: AGHT+IF5Klg+NpX9Rtaaff2D9OV1AcH1L/8K+XQh4GojJvYYnqeps6SlV4FJJ/bQKvzi3NGeS2TXTG8FuUUibi30yt8=
X-Received: by 2002:a05:6000:1447:b0:331:393d:aea1 with SMTP id
 v7-20020a056000144700b00331393daea1mr10693336wrx.13.1700063297529; Wed, 15
 Nov 2023 07:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com> <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
In-Reply-To: <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
From:   Brenton Simpson <appsforartists@google.com>
Date:   Wed, 15 Nov 2023 07:48:06 -0800
Message-ID: <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending from the email address linked to my GitHub account.

-- >8 --

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
 =09=09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
 =09=09},
 =09=09.driver_data =3D (void *)&lcd1200x1920_rightside_up,
+=09}, {=09/* Lenovo Legion Go 8APU1 */
+=09=09.matches =3D {
+=09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+=09=09  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Legion Go 8APU1"),
+=09=09},
+=09=09.driver_data =3D (void *)&lcd1600x2560_leftside_up,
 =09}, {=09/* Lenovo Yoga Book X90F / X90L */
 =09=09.matches =3D {
 =09=09  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
--=20
2.43.0.rc0.421.g78406f8d94-goog
