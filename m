Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDABC7EF7DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346175AbjKQTaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbjKQTaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:30:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E84172A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:57 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-407da05f05aso17390125e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249395; x=1700854195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrJGixj4VLO/gb45P3W5wglCyhSe0ySqRzzJiqvkYOU=;
        b=aYyBk9nh+Y1vzXUEohsDH77JD8jUxskEoNbGev2GhEisRA3poXbxIXSoQZGLil0KiC
         3UtNsXZ2kQR7dOcncmnfC5z7LqGhUX8fNnlZIERjfCY5cybaP4JH4jrKgkB0zRRykPR+
         +x6s7ZWgo+TAX3KkQkgJOJ/1ndLx6uvyse3lRM/KYstzQMAMuEhz1UMh7dKOjFXVb268
         Hskm/nAyAgXEpuUFGIaSOTgHr/3MN0X7IJWLTiZXh3RSRPdvl4UsgT9c1N8SlAjo5bqa
         i1XQuNFcJFxa0CMv4e/j6C0Q85/wCiFAYju6VITWLmGxGiY+FY3amWiNi1zbIA51oOHL
         lffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249395; x=1700854195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrJGixj4VLO/gb45P3W5wglCyhSe0ySqRzzJiqvkYOU=;
        b=VgCZyugWB47zsIiwNjY8NuDxM+JZjSh7GI5ruRaYRAUXbj9H5VpDj01cgo5/0tZadD
         LcD0niaHB5ir5vStIgj6mvigI3vmRksq2gMlOLlY3RZVJvuSpPK2/OScxfGrXN34hTl+
         fq2eIbPgg62DU+rhl685O5aZ0wdqUYdFfdQ5AaptKKWDxjVDSRp7KZ9f4tc9ZD0jipJL
         7H6XzdxOv3HOsIylkwfGPXlAk3snne1f8ydo7dt4BA2qot/nj5pIhHKHt5Cnk2sBtBql
         StGzaC6OEMt7EmCeJ56f+ZpAcYhIjfJw7lx/4jMbhqk3xNIcTdRDPGZ1yraJYtHPyw9I
         yhyA==
X-Gm-Message-State: AOJu0YwBOXoFjf4kifKuJy3Vnb9CTJa2cR0l3Tk/MH+2Ndb9UGoHxLmp
        o5ReTcDuP4IEZS5CQiaPCew=
X-Google-Smtp-Source: AGHT+IHvtJoidsF1ZL6icuKOlAh85H5TNlmsVhsVh5DSFSRnTQN7DSzjzZ9sbIDg4m+CUvRMYEX7fw==
X-Received: by 2002:a05:600c:81e:b0:40a:463c:1de0 with SMTP id k30-20020a05600c081e00b0040a463c1de0mr73322wmp.34.1700249395310;
        Fri, 17 Nov 2023 11:29:55 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id 22-20020a05600c021600b0040523bef620sm4440397wmi.0.2023.11.17.11.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 11:29:54 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] w1: ds2433: add support for registering multiple families
Date:   Fri, 17 Nov 2023 14:29:04 -0500
Message-Id: <20231117192909.98944-2-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117192909.98944-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>

This is ground work for supporting both the ds2433 and the
ds28ec20. Inspired by the w1_ds250x driver.

Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/w1/slaves/w1_ds2433.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
index e18523ef8c45..e1e45ea1bfa4 100644
--- a/drivers/w1/slaves/w1_ds2433.c
+++ b/drivers/w1/slaves/w1_ds2433.c
@@ -299,7 +299,25 @@ static struct w1_family w1_family_23 = {
 	.fid = W1_EEPROM_DS2433,
 	.fops = &w1_f23_fops,
 };
-module_w1_family(w1_family_23);
+
+static int __init w1_ds2433_init(void)
+{
+	int err;
+
+	err = w1_register_family(&w1_family_23);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static void __exit w1_ds2433_exit(void)
+{
+	w1_unregister_family(&w1_family_23);
+}
+
+module_init(w1_ds2433_init);
+module_exit(w1_ds2433_exit);
 
 MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
 MODULE_DESCRIPTION("w1 family 23 driver for DS2433, 4kb EEPROM");
-- 
2.34.1

