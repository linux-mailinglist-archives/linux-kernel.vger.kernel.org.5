Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FB76A1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjGaUcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGaUcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:18 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911A19BB;
        Mon, 31 Jul 2023 13:31:53 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-56ce936f7c0so278361eaf.3;
        Mon, 31 Jul 2023 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835512; x=1691440312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwFVZbWKnZ7U+byhcxwRklu+51Zv8fYKOqQRjPN+S0Q=;
        b=rHKy5Xfb1d8QWmHrev+LJ1PSeQlNZGbeZN9MC0Z6bjOUqGrc+yctr6q5VeFP9UZktt
         X6G76UXB6Y8axtuMJBmwhtkKepZkKm8EAoupm4G72rQVhV5MI45btyVFpkPWXBEJaZ6L
         NxLWBOR7pDBQntHbJyLy3XCykYT9b0i/9GjrOdgGwJ0oX35ev6w+whrbgUCy0ECQHBES
         +LVXIVWvPtcaYsf0ICwITYlNzacghadoKYRgNeLgC4LEubYjpFlzCVJyEO73QnV6pREh
         hg8VjbNJGcaaG6Gfpatgt3Qn0H7g/ijmfAp8HTNw8A/ql3K2zVw6MCOYG5ENvJLvwGM+
         /9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835512; x=1691440312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwFVZbWKnZ7U+byhcxwRklu+51Zv8fYKOqQRjPN+S0Q=;
        b=hGflPSZG3ExR2YCfmeB4CHL8EvM4OEsO3PWY3/493kZiqPS2CBIsCnoQdo9aPebkou
         Bmfj90h9XgDqWXfaT8DqCyM7S9B9OKeGFxAf99AIUu+CJBYTTfVK94Haeh1mfFn5IzVj
         +99P5P/xxKmWLBodelbXPHsQrTHI4Tzmpd+kLosuooSaQJkxwJFo/+UjB+2On0zeu2fz
         cGikAXpk12S+OF4R3XsK6w9HGcCGmPJN4H4O2tBpP/is1y1mvpyIia3EZXqRU3VTdMIn
         DLYSQKEinx4VqImuSqdkCOOngClBMk1E4Ge738qm+CexGFNNBP4ONbKXeEdsZYEhOImc
         4KBA==
X-Gm-Message-State: ABy/qLb9uK2wxTzIudE8SjIp+9vJ9RQ/usv+lhoPiivkaTmZPzgbnqvH
        bGND1aIaoj6aqehvE5WO/AI=
X-Google-Smtp-Source: APBJJlHyfogy7pdQITs3TEK4hodgymCEiISUtPceL4AQG5kDLkR22xJyaa5B6zuDPP8FMeoL3gMzfw==
X-Received: by 2002:a05:6870:b28e:b0:1bb:951e:3d61 with SMTP id c14-20020a056870b28e00b001bb951e3d61mr14375891oao.36.1690835512414;
        Mon, 31 Jul 2023 13:31:52 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:52 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 8/8] hp-bioscfg: Remove duplicate use of variable in inner loop
Date:   Mon, 31 Jul 2023 15:31:41 -0500
Message-Id: <20230731203141.30044-9-jorge.lopez2@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731203141.30044-1-jorge.lopez2@hp.com>
References: <20230731203141.30044-1-jorge.lopez2@hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace use of same variable in inner loop.

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 .../x86/hp/hp-bioscfg/order-list-attributes.c        | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
index 3b073910b430..cffc1c9ba3e7 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c
@@ -136,6 +136,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 	u32 size;
 	u32 int_value = 0;
 	int elem;
+	int olist_elem;
 	int reqs;
 	int eloc;
 	char *tmpstr = NULL;
@@ -147,10 +148,7 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 	if (!order_obj)
 		return -EINVAL;
 
-	for (elem = 1, eloc = 1; elem < order_obj_count; elem++, eloc++) {
-		/* ONLY look at the first ORDERED_ELEM_CNT elements */
-		if (eloc == ORD_ELEM_CNT)
-			goto exit_list;
+	for (elem = 1, eloc = 1; eloc < ORD_ELEM_CNT; elem++, eloc++) {
 
 		switch (order_obj[elem].type) {
 		case ACPI_TYPE_STRING:
@@ -277,10 +275,10 @@ static int hp_populate_ordered_list_elements_from_package(union acpi_object *ord
 					tmpstr,
 					sizeof(ordered_list_data->elements[0]));
 
-			for (elem = 1; elem < MAX_ELEMENTS_SIZE && part; elem++) {
-				strscpy(ordered_list_data->elements[elem],
+			for (olist_elem = 1; olist_elem < MAX_ELEMENTS_SIZE && part; olist_elem++) {
+				strscpy(ordered_list_data->elements[olist_elem],
 					part,
-					sizeof(ordered_list_data->elements[elem]));
+					sizeof(ordered_list_data->elements[olist_elem]));
 				part = strsep(&part_tmp, SEMICOLON_SEP);
 			}
 
-- 
2.34.1

