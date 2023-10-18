Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA127CD5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbjJRIFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjJRIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:05:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF5B6;
        Wed, 18 Oct 2023 01:05:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507bd64814fso2217669e87.1;
        Wed, 18 Oct 2023 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697616308; x=1698221108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMNVGJeJs6tC6fM9RWBX9uPuEFgE2XkieCrcZbldbM4=;
        b=kr6TE3GLsgcpvXPIXYqqoYgo8ImXDuM87j4dBeJDV7muAHuTzMYjt1ysvSQBUsXmHi
         a5v4W4MZZ/LGhQbMCQdent+OHYntclCYHMe17fybygWcxNY+EOCqhHWhrjpmw6y3+aBO
         t68GV+3+lhUX5EsQxqXWlbpya5K8HNoXqXMH+bgyQ3PHuVZQByfS4Scgfxx+OVKvXM67
         QrTjYin8ho+f7K1uEAzCX6U5Jtt8P/Q4nS4bYdpOCqxNC4QHVsPiXV/dNsWFGi2QJOwd
         99KoxGLfDCZcgaA/+nzrcLYiUH0eItVp6GAVZ9aJD107p9NF0pJ6PqR+o0U5NLyF6yu6
         BsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616308; x=1698221108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMNVGJeJs6tC6fM9RWBX9uPuEFgE2XkieCrcZbldbM4=;
        b=HtXjYgN8NG/Su5LScAc3PpejFIzovmX/q6/a4E9xQNsqC6m2m+0sNRgA6bX9qBqAy6
         aVXOcsZJauuzIzS5sSz1LXd7W8FBRZQL2nn+UDApbO7W7+eIV86I+YruRXx6WBLqy492
         RQlA12WBmAakAalDn8PRaJI5nh4sGrzYK4tD0aNP4Ur67LAnzCp0RgyAx6UHlM+30By/
         Sg8Cmh3bbmuguBx4oEGzuodevyMfbf33XfDpQqyCIseeO9mCztBmtsvYGGiz7Q7zTUaP
         rYWhWKFSR2I4aJhPf0BYHwLSGDxtETuF995B/G/lxkRkr4NUJMUsKlAst6Vynmno7dFF
         Zo6w==
X-Gm-Message-State: AOJu0YxvE9LjOCKGpzFfXkuT4OMCfhn70UpJZN416sD1gwWPtG+SNIM2
        Lmaa4Fagu+0LBkKzUiwdagWkOWewiICmnDw=
X-Google-Smtp-Source: AGHT+IEOoxnYTOtBclV4vk36arcwft7QKDtzgJRUNRHK+278x59Pnk7rzDUe855MTH5QEDI9sLxiLA==
X-Received: by 2002:ac2:52a9:0:b0:507:9618:d446 with SMTP id r9-20020ac252a9000000b005079618d446mr2950797lfm.61.1697616308093;
        Wed, 18 Oct 2023 01:05:08 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine.localdomain ([105.163.0.227])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b0032415213a6fsm1484548wrm.87.2023.10.18.01.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:05:07 -0700 (PDT)
From:   Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     anonolitunya@gmail.com, outreachy@lists.linux.dev,
        julia.lawall@inria.fr, dan.carpenter@linaro.org,
        andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: sm750fb: Rename display_control_adjust_sm750LE
Date:   Wed, 18 Oct 2023 11:04:08 +0300
Message-ID: <20231018080416.25931-2-anonolitunya@gmail.com>
X-Mailer: git-send-email 2.42.0.345.gaab89be2eb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function display_control_adjust_sm750LE to
display_control_adjust_sm750le. This further enforces snakecase naming
convention for consistent naming style throughout entire file.

This change was suggested by Andi Shyti <andi.shyti@linux.intel.com>

Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
---

v2: Correctly spells Andi Shyti's name

 drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index f3f354831617..bcdd291d25c9 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -14,7 +14,7 @@
  * in bit 29:27 of Display Control register.
  */
 static unsigned long
-display_control_adjust_SM750LE(struct mode_parameter *mode_param,
+display_control_adjust_sm750le(struct mode_parameter *mode_param,
 			       unsigned long disp_control)
 {
 	unsigned long x, y;
@@ -125,7 +125,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
 			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
 
 		if (sm750_get_chip_type() == SM750LE) {
-			display_control_adjust_SM750LE(mode_param, tmp);
+			display_control_adjust_sm750le(mode_param, tmp);
 		} else {
 			reg = peek32(CRT_DISPLAY_CTRL) &
 				~(DISPLAY_CTRL_VSYNC_PHASE |
-- 
2.42.0.345.gaab89be2eb

