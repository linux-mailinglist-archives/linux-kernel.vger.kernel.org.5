Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EFF7B74E5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjJCX3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjJCX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:29:01 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA7B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:28:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c62d61dc96so10932355ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375737; x=1696980537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mewr2b70zj+E+PpMtuqRQXYpLvw4Y2kPAtz8L71vU0I=;
        b=Gq+gphMwlzljnJCKit7St6eAm1T3gh4oMGIP2fokDe9rOonYZfG2soLJwkTfm8Eo9h
         rfljuBIeizdZtNbUbOXnc9m7VkIleh3hhJG+jcsBmg+ZJbwea4IW5wcRxsTBxncRWQ2L
         7MV7Bwh+SJqxK0Ida1JGynx2Z86cK2sM4Q9zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375737; x=1696980537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mewr2b70zj+E+PpMtuqRQXYpLvw4Y2kPAtz8L71vU0I=;
        b=hxSxAYCtRYwE5CNPbCHC6yL6eqXCOEYcDe38W+f/JmEn27jVOFepS8s9Fcc63SVs34
         AedSVGk8O3GpFKooppc8igNBPblexEEBBo90kx6eIplCu6SBgvZnHR0TwhyHqVBahuFp
         Hg88D7XlXs8+bNnAwviH9tqw173eV+UYau76wjuPbG7YDY8sTz2l2U3EKnPUpYKj0KJ4
         hqhAubkAVnKafYzoeVIt4NmuUhBDguVGN4TWV6SuFZHxpx/WsnVA9ahaNSV1SKQg2XAQ
         9AukmVyjCvAI5u6kq/akaPjWeE8VlIjj6WINnwyd3txohZEFzyDnlSqfgPvC31oxv4eF
         YOsg==
X-Gm-Message-State: AOJu0Yx7/D56pDHw37YXurqqA0UNp4TUBZLRLLkJYIua4PgNZqIgANtQ
        7PE9r8bjATYVu2M1DexRqL/o+g==
X-Google-Smtp-Source: AGHT+IE9+0pmjc2CqAJFQTA1BUgWoTDOaeHCQ2RtQhFPP3SatP2ZRDf6Q59SkUDovbfYKbDPKVBYdQ==
X-Received: by 2002:a17:903:24c:b0:1c7:4f87:3dbe with SMTP id j12-20020a170903024c00b001c74f873dbemr1177087plh.31.1696375736870;
        Tue, 03 Oct 2023 16:28:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902ea1000b001bbd1562e75sm2201487plg.55.2023.10.03.16.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:28:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] ASoC: soc-dapm: Annotate struct snd_soc_dapm_widget_list with __counted_by
Date:   Tue,  3 Oct 2023 16:28:53 -0700
Message-Id: <20231003232852.work.257-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2049; i=keescook@chromium.org;
 h=from:subject:message-id; bh=6X+YStEd0LKlaV0dQ/+jU63am+Tg/LnFddxaxahC+bw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKO1gHu4l9h8ToOMvkOmkto8cSVU/vIIIfRBe
 GeN6y35pSWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyjtQAKCRCJcvTf3G3A
 JgNjD/4q5gV6j+9dUNB2OWkREBYsVc6X++ugjnovyEuKGMIO5OVnXc9jH79Kp+y27z4flA8uzzb
 +/r402rgPMkNPLC5GCQr12BvpEC1X8LALA79ist2DeSe1oktOoVS3aMe+/Xy6TqdcMeDeIZoo/7
 T1Rn6zkPYXU/8vtFSebH5zH51EeajceKubb+yEJ8rmen79X1C7Gyeb7Ijc3HWazoUS0FKasUx5A
 cOnmPn+ui24LfU1Qa7V7TdcR9rfRZ8updCADmqZ6QM5DHxxwuvgir/CGTN4izQGV1OUxMJgJS4l
 +wodJb5c0SRHeF+7+yAT6WO4qsuBQQwFXdnsw2ywzFe2rTOZ22M/mAcK22lbc28oAaVPrL6tWj1
 MT6VpE1AqFevzjlgTxDde83nlltZhG2Vveh6cPfzFBtn53tVWK1kaPFTw5cr4Ku6TnJswmeRLtJ
 sxEuDhD/KSvpRx1PhGEU8jGsnOjuSnT9E79xugfNmv/2wjEIJSha6UeyebKRB3HpoAqL5eXJBDb
 37rBp22xYP5M/W7HQmIFzZ+iR3s7UV+UW+3JYpQusIFADZzQH0yUHk/DoV7EVgBxMtYXwAs0xOn
 vxcomU0K+gw5b+cB6mxXslxsu7jQ5DVxyatycmhvSOz7GUbXtQlraWBOe+LhgFI/Y8J7Mupz2q9
 aPyj3M0 Mg5yrwWA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct snd_soc_dapm_widget_list.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: linux-hardening@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/sound/soc-dapm.h | 2 +-
 sound/soc/soc-dapm.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index d2faec9a323e..51516c93916e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -717,7 +717,7 @@ struct snd_soc_dapm_context {
 /* A list of widgets associated with an object, typically a snd_kcontrol */
 struct snd_soc_dapm_widget_list {
 	int num_widgets;
-	struct snd_soc_dapm_widget *widgets[];
+	struct snd_soc_dapm_widget *widgets[] __counted_by(num_widgets);
 };
 
 #define for_each_dapm_widgets(list, i, widget)				\
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2512aadf95f7..2e3df47c9cf3 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -497,8 +497,8 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
 	if (!new_wlist)
 		return -ENOMEM;
 
-	new_wlist->widgets[n - 1] = widget;
 	new_wlist->num_widgets = n;
+	new_wlist->widgets[n - 1] = widget;
 
 	data->wlist = new_wlist;
 
-- 
2.34.1

