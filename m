Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12377CF13B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344850AbjJSH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:28:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D47112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:28:43 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40790b0a224so22133615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697700522; x=1698305322; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dfpvGhYQuCUgDBCdMtII7TE0gbJjpgbukJNGIRocW0E=;
        b=Kd/mi9WUpAB2s6/IeQbSngDvqV1eqwnojU07OAbzxVtBf9FUFKULqsLOCNZLu0STZn
         ryvn7WZliA9s3VQvIVQl4vZ3aWh6xFKgJbxxAnwIJpIIXLmEfGD/31Egw/YzQc0RqXUl
         TeGBs57PCyBvFZHnsoXRDZxiUEP93P4q0EfccRMM0P9JZ79ZfLDHATnzewEpSoZjET/v
         VQBIXj1xd1MOzq2D/mOGyirCYvc5Pn7x6Nyu+5jNZl6mb6Ke1wNa+ylbLv2/k7d+Cj78
         sc2XprvBIE0VQj9RkqaZ3g+Fqflv1b+uls6OiOeysT8sQOFWn8rJHL82A0ZuTmBP4LZo
         ILbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700522; x=1698305322;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfpvGhYQuCUgDBCdMtII7TE0gbJjpgbukJNGIRocW0E=;
        b=VBYOwUkv5DybqB0aFxRDD4SYWIxmTny55f9HTXlEP4WmcVSZFYWZoe89l8howgErXo
         sXVCFyAPccMXYXwpwOi/GgzFKKPlSd/nSnUZZBH6fIDeYXQs8l0OA04XcezMLsUsxZsQ
         a2hH0IJ4AJL1xLR4lgc+U6BdP06keyQS5zY0YI6KUhgV/T3z21C721DdcxSa9iaAuGJK
         shPbsEVYBmuzSPR8OYT8WoTbU42mpozTCbOBE1wZApiRbjrb7aSIfoJs4qaqVS6F5Tir
         TbQIlwcKbQ/45vvq5JuXuOaILzG6IJ7zBuDTUgDbLbsldk7QnSQHBUHXhCQi9wc6wJxS
         hPYw==
X-Gm-Message-State: AOJu0Yyx/m0C+jxTLxsjP96/4jIxaMU8US4VbIXggo/xeeHkRBi/BhyF
        dtmak/NwzQo0XlpDl/qJ8KV5pC6hboQ5Pg==
X-Google-Smtp-Source: AGHT+IH3+XAG17HLDSZDB9xXIyIIBmyU0RlTB5VpKQAnu9lOhOrJKHCktQ4ZC336u/3uyL4Nzz30jA==
X-Received: by 2002:a05:600c:1c98:b0:402:ff8d:609b with SMTP id k24-20020a05600c1c9800b00402ff8d609bmr1076454wms.33.1697700521873;
        Thu, 19 Oct 2023 00:28:41 -0700 (PDT)
Received: from lab-ubuntu ([41.90.66.104])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0031c6581d55esm3811228wrh.91.2023.10.19.00.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 00:28:41 -0700 (PDT)
Date:   Thu, 19 Oct 2023 10:28:39 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     gustavo@embeddedor.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-audio: remove function snd_bcm2835_new_ctl()
Message-ID: <ZTDap2d5X7eXXPo2@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function snd_bcm2835_new_ctl() is declared but not defined.
Its definition was removed 1 year ago in the
commit 143b67f19ba1 ("staging: bcm2835-audio: remove compat ALSA card")

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index 0a81383c475a..49ec5b496edb 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -84,7 +84,6 @@ struct bcm2835_alsa_stream {
 	int idx;
 };
 
-int snd_bcm2835_new_ctl(struct bcm2835_chip *chip);
 int snd_bcm2835_new_pcm(struct bcm2835_chip *chip, const char *name,
 			int idx, enum snd_bcm2835_route route,
 			u32 numchannels, bool spdif);
-- 
2.34.1

