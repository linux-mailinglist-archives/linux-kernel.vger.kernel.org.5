Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5387177A20C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHLT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLT4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 15:56:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C2C172D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so47662871fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691870207; x=1692475007;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fL1GkCls/lRXUl11jGLVZ3NysdneBSUheg11xD/AOY=;
        b=B+0ak7e0NYxaQA0IFyknC3O07CuBJ0eWe3yOt3pRfk38UguGu+aqbZlTFPJqxy56q5
         q/FWH/4fFc2hsxupFUps36/WNAIyzGznaB23LdJlvgfDK/yuo0EFfXJ+AzCJ9EkP2utT
         Qs9c/nNErtazQ5FfHQxYr/O2+c8eYx8HkFmkOdZAsZ4kXVivGLCE1AK9H2ybPnocHJh3
         l6KflfM66GEqP0Ri7XaKBHrZA0cEeeuPHai4WcElM3Q+rkf1sTGGKclDn5JVIAeWlYH1
         v5qzM5MGwdJv5Sj1cg89U/komYKTMxaYiKqD2tGkbu2QYQ7UAvUWC4xLNQ2+as3r4ASR
         UKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691870207; x=1692475007;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fL1GkCls/lRXUl11jGLVZ3NysdneBSUheg11xD/AOY=;
        b=LTefG8gT47VDC4TU8cg9WNc8nmEOFeipWtQeB+owENplbinwhSFJvJ8EJQPxE5O3Sg
         9wGt84QGpCLYY5Tgb5FgVcml3eFxU5K/vNJaxgkoV3ekpmJj+6WYh4HcYUr6zjz/EcvC
         +HQEzhl4EUo+AxfmaeIoBWrKjYx09yJcA9bbkT27O0rmUX/lLkF6b+BIyXsNH+TPVRT1
         0DjgQnjCjGLErJECEW/2G3lt9wVQMQChtc8yASNUEKkYMCEQDkyJc1rB622Xef9+sD7D
         j36oVKZ/Pmt1L36QWuWn3FMU5X9+M5ZmXuoaQbZt/QP9Fdb4//xzqmmW1wlNwAaWH/wK
         ZLbA==
X-Gm-Message-State: AOJu0YwZYF5ftosFmlsdbflx0WJVRhoXpAtSdFpeXe9UsDOtoKqm+6hA
        pq90SmNbDfSH5gmlMf0sF1Fk4w==
X-Google-Smtp-Source: AGHT+IEjRfyIk6V1H50lmax7c5pwSA33ciPquKzJ5WZQiKGci2UG5OBX+V+me9wsIOwkHtcZauSGmw==
X-Received: by 2002:ac2:435a:0:b0:4fe:ec5:2698 with SMTP id o26-20020ac2435a000000b004fe0ec52698mr3265045lfl.50.1691870207247;
        Sat, 12 Aug 2023 12:56:47 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id n29-20020ac2491d000000b004f87893ce21sm1236182lfi.3.2023.08.12.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 12:56:46 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/14] ASoC: rt: Drop unused GPIO includes
Date:   Sat, 12 Aug 2023 21:56:38 +0200
Message-Id: <20230812-descriptors-asoc-v1-0-eb4dca1f68af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPbj12QC/x2MMQqAMAwAv1IyW2hThOJXxEFq1CxtSUQE8e9W4
 ZYb7m5QEiaFwdwgdLJyyU18ZyDtc97I8tIc0GFw0Xu7kCbhehRRO2tJFtHH0K8fCC2rQitf/3K
 cnucFtD2j62IAAAA=
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers include legacy GPIO headers for no reason
at all, so get rid of the includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (14):
      ASoC: rt1011: Drop GPIO includes
      ASoC: rt1015: Drop GPIO include
      ASoC: rt1015p: Drop legacy GPIO include
      ASoC: rt1016: Drop GPIO include
      ASoC: rt1019: Drop GPIO include
      ASoC: rt1305: Drop GPIO includes
      ASoC: rt1308: Drop GPIO includes
      ASoC: rt5514-spi: Drop GPIO include
      ASoC: rt5514: Drop GPIO include
      ASoC: rt5645: Drop legacy GPIO include
      ASoC: rt5659: Drop legacy GPIO include
      ASoC: rt5660: Drop GPIO includes
      ASoC: rt5682-sdw: Drop GPIO includes
      ASoC: rt715: Drop GPIO includes

 sound/soc/codecs/rt1011.c     | 2 --
 sound/soc/codecs/rt1015.c     | 1 -
 sound/soc/codecs/rt1015p.c    | 1 -
 sound/soc/codecs/rt1016.c     | 1 -
 sound/soc/codecs/rt1019.c     | 1 -
 sound/soc/codecs/rt1305.c     | 2 --
 sound/soc/codecs/rt1308.c     | 2 --
 sound/soc/codecs/rt5514-spi.c | 1 -
 sound/soc/codecs/rt5514.c     | 1 -
 sound/soc/codecs/rt5645.c     | 1 -
 sound/soc/codecs/rt5659.c     | 1 -
 sound/soc/codecs/rt5660.c     | 2 --
 sound/soc/codecs/rt5682-sdw.c | 2 --
 sound/soc/codecs/rt715.c      | 3 ---
 14 files changed, 21 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230811-descriptors-asoc-221835f35f32

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

