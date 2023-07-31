Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0AC76A1FB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGaUcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGaUcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:32:17 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67C01BD6;
        Mon, 31 Jul 2023 13:31:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b9d68a7abaso3744029a34.3;
        Mon, 31 Jul 2023 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835511; x=1691440311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jPT0ddPruGbkg3FYrX/+sMXt1fqGYVBPjdmYjXOpwng=;
        b=T72sl30lZTgWUIckxBk/IGYjIAUiJ4EGYkG5sgd/0IDTZpcmuEgl1qgk9isgNR5W4r
         3JF9mE87/OMoIuvM1UyrlOdyS5Gvh+gL3m5Q3MfGnE6yGTnShNTQUhz2/dEL+DBVuzIH
         eeeetvQ0L2eJM7fn5Uu/JCKEv4ZnZuuKe6/p1OtxjvDnIs1aALppF3u7OnQ2GWHlAHzO
         +xbrdjopnuah+UMV9mQr86ryH6W+562Z2GM3zlfVy9SuD8QH1rSOsdoV9adwqoKMZlgQ
         rCMuUgdi4ObC8gbPRWsVTt3mumi6Jd3YtIuappRPy1ZP82pMPfEvqWtkv1/JJMq/Dsox
         Iv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835511; x=1691440311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jPT0ddPruGbkg3FYrX/+sMXt1fqGYVBPjdmYjXOpwng=;
        b=Q5tyXe7TRkNhyRv/NHVWMPR3UqMeSR3OXFIwXa5aobRiO+zw7yE5VOnIkwxVUGF5/p
         3upEvGiJwm0JZt2cCrdKM5pliieHDaSChOk7ai99csNaTj+BLjyfcpcV+b0j2oP7jdyc
         wA8IJ6eo/aA/rbz2z1Cl6yv3Myij3/y41UpzhiPofHo3ElDznpYUpzQRCica3ekXUOUE
         NLLGEvNmLQxW3A50783sl52bK2qKV+juhYrUTFuyRs4rMJ1MDs8ksWBNVrNOirLkQV8n
         V+E4nv21UycPL9Dq6bb40TavM4UHpyJmWzR/9sASRWS3UnDgLx4kjmKr6qzoh7uKLxew
         mQ4A==
X-Gm-Message-State: ABy/qLa0I/3wvAkiBXVwhAViNoA9PDAt7hcz4F4GChQqUPQfTMixQAUj
        2TFi1Tx6AvrrmcrPgCTF57HL/6CgM58=
X-Google-Smtp-Source: APBJJlHTO4XtFGrpytumo4uCqourkFjJJJBMBotvl8XdUWgcAJj9LYVYNTjALlKQnXVov9+zdykaNQ==
X-Received: by 2002:a05:6830:1e05:b0:6b7:494b:a503 with SMTP id s5-20020a0568301e0500b006b7494ba503mr10143636otr.18.1690835511237;
        Mon, 31 Jul 2023 13:31:51 -0700 (PDT)
Received: from grumpy-VECTOR.hsd1.tx.comcast.net ([2601:2c3:480:7390:b620:ce9:47eb:26ab])
        by smtp.gmail.com with ESMTPSA id g8-20020a9d6208000000b006b9848f8aa7sm4498841otj.45.2023.07.31.13.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:31:50 -0700 (PDT)
From:   Jorge Lopez <jorgealtxwork@gmail.com>
X-Google-Original-From: Jorge Lopez <jorge.lopez2@hp.com>
To:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: [PATCH 7/8] hp-bioscfg: Change how password encoding size is evaluated
Date:   Mon, 31 Jul 2023 15:31:40 -0500
Message-Id: <20230731203141.30044-8-jorge.lopez2@hp.com>
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

Update steps how password encoding size is evaluated

Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>

---
Based on the latest platform-drivers-x86.git/for-next
---
 drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
index afb5190afc03..03d0188804ba 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
@@ -335,9 +335,12 @@ static int hp_populate_password_elements_from_package(union acpi_object *passwor
 			password_data->max_password_length = int_value;
 			break;
 		case PSWD_SIZE:
-			password_data->encodings_size = int_value;
-			if (int_value > MAX_ENCODINGS_SIZE)
+
+			if (int_value > MAX_ENCODINGS_SIZE) {
 				pr_warn("Password Encoding size value exceeded the maximum number of elements supported or data may be malformed\n");
+				int_value = MAX_ENCODINGS_SIZE;
+			}
+			password_data->encodings_size = int_value;
 
 			/* This step is needed to keep the expected
 			 * element list pointing to the right obj[elem].type
-- 
2.34.1

