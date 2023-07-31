Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1688276A1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGaUci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGaUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:17 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47119B4;
        Mon, 31 Jul 2023 13:31:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9c57c4d12so3757709a34.1;
        Mon, 31 Jul 2023 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835510; x=1691440310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Na7ZXn3NbUlQQiPPzn9VAvAq8FAlzQ7CZv0qwkxXlmo=;
        b=M5ryLPwEvh+tZico/g2DswMCiZKOJqgZUn0VDE/u6wkceQk6IzMM04Pj5fuCedd9NE
         IPSSog8CCvRJ2dhhq8sVjJQBFrct1EsOwzcLyOv7/hRnGSbZDsLOLVSf3GdKk5sO7S+e
         TM4ffThJ3NCje0rljIfHTYpwZzzlLsnb105UDXo7PYM3PXebgO6LCkDcJnwSQNSrwRo4
         Jw6FfpxUX+FgQD2lWqYX5bXiEcQlp8hYKNp3XDVqwlvZ+FRgXJ3BbavmUCPT72qmTjgR
         gT5l5nYPxQMHmtmKK5zW7vbqfwVQ1mdXhDSMMnpm4ObT0JRh96Rz4ML5bHI06YE+vaeE
         1Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835510; x=1691440310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na7ZXn3NbUlQQiPPzn9VAvAq8FAlzQ7CZv0qwkxXlmo=;
        b=fUxfac3znboNfOdaRCkPZ2agKqKh0e7OM3ayf7bi3z1BEGaWhnkN5J0zc7+9MEXusn
         OHqVf5hdHuAMXk2+hmalAyst6E/BBq2NJMTJIqTHaN3kzifbeqAgCYXHjlVvtkaj2Emg
         eM50GxkFu3dkEb/gYsf20biUMH8tSUify1enIMGluE5W4Gjtge6+0VQEY1skJB9CBFFk
         PIhqCVPsXR1Wnk2aZie7GKEuehYbMqZYEt8wPID13XbJwdk5QZfW3OG+Hyvul9VcymwG
         5lDdjLdRKKUaFzrbXaYJO7L0zn0/MDU7cCF+wryAqFhzzVm2YI7IC7uj2Ggyh4cSWzAf
         9URQ==
X-Gm-Message-State: ABy/qLaZd/JkNyWT118NwEOatGxWHo0ifJ6EPFb/di/JBHazCGnhta3O
        AP9T0T/2Rc7TIbGb9jY0HRE=
X-Google-Smtp-Source: APBJJlFnAThtuO3s4qVIVIUJznIanPNQbnQYw1D0yxMPo+qqh52yOZmn4XpA9B3kiS8KMCAE4sBqYw==
X-Received: by 2002:a9d:6b84:0:b0:6b9:da1f:653f with SMTP id b4-20020a9d6b84000000b006b9da1f653fmr11929168otq.21.1690835510242;
        Mon, 31 Jul 2023 13:31:50 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:49 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 6/8] hp-bioscfg: Change how enum possible values size is evaluated
Date:   Mon, 31 Jul 2023 15:31:39 -0500
Message-Id: <20230731203141.30044-7-jorge.lopez2@hp.com>
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

Updates steps how enum possible values size is evaluated

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
index 89bb039a8a3c..a2402d31c146 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c
@@ -240,9 +240,11 @@ static int hp_populate_enumeration_elements_from_package(union acpi_object *enum
 				str_value, sizeof(enum_data->current_value));
 			break;
 		case ENUM_SIZE:
-			enum_data->possible_values_size = int_value;
-			if (int_value > MAX_VALUES_SIZE)
+			if (int_value > MAX_VALUES_SIZE) {
 				pr_warn("Possible number values size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_VALUES_SIZE;
+			}
+			enum_data->possible_values_size = int_value;
 
 			/*
 			 * This step is needed to keep the expected
-- 
2.34.1

