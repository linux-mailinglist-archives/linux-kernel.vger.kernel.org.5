Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F97BFBC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjJJMtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJJMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:49:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52394B0;
        Tue, 10 Oct 2023 05:49:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso10007874a12.0;
        Tue, 10 Oct 2023 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696942176; x=1697546976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=85p1goovMFK4Q84403F1EvH9aZA/eFTcmB+8jlXGSvQ=;
        b=P7OqrD3QWBxrPPVwek3+aWMaXpV5q20uLM7FKR130pyUSOGyO4kfmlk7/RBcRfZZG9
         u3C9+6VlmcBcBZ+Vn5CQ5klWmemT3SjRqO/QbE+GRuu0iPgQCGbcwuqbCsUU+3CVI3jM
         YGhq7eYTywscaoq8qcL0GbZAe6T6OIq7dz1Eb1hdiq71xCS6ZmgOUMCffavBojN8JTJ3
         Qg8+xZ+Q4ZgbjhslfotgZT+9fSkD5zWEHuaNItZqLmYAZkqem5nXgXWEMrqHcZWEz+SO
         SU0mU8Gmrjc7PpzekaoM22nxXhZTym/uUgcUgxDVsmPZxcdg5DYOYAnMO/zZS5o8VJpa
         zC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696942176; x=1697546976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85p1goovMFK4Q84403F1EvH9aZA/eFTcmB+8jlXGSvQ=;
        b=r8p3VbvB9Uwp1fQMK8iNYZA4udlUIiWxxfdFCR5jiOi2CX8QMpVuesfrfdfjfmHZCP
         ScEN/80rE4jDbIHsd0VqaYGuI/4RGw9VeTmXHFyg7tcOLF3TsvLOIMOYteCCE+mlKOkt
         xqUSyI0TcfeVyjmAyy7XlqmLwh9vtA8jcENmgyb167as/lpYfyzoKZsYQgtQBwdXwk+6
         HrfDW63Grh5I+4TkQp5ZU5LdG9L/hw4uWiyTaIdM8xjDxWGerTiHrCSffcWK4o9nsxuk
         qS20pIMuLLbTzRdAw9J1sZi8RczAsIeG1fufD2ZEzglVFmfjOlPhH2n/wZm/GGg6c+n0
         UbfQ==
X-Gm-Message-State: AOJu0YwWQz/pEwqRwGz+tgZWiuSJycZYHvhYNSR4rvMagJAl6nnKRc81
        9vcwKrXZ1LsbjpTmk9AsTUM=
X-Google-Smtp-Source: AGHT+IFArn5+ZRpWjA7jkmRKnfIIyH6vyFuHdsI4m8OzljJjuyRYB/kprazkJ5dApZBPgZLnsVvWRA==
X-Received: by 2002:a05:6402:c4f:b0:53b:b110:1bd4 with SMTP id cs15-20020a0564020c4f00b0053bb1101bd4mr6385951edb.6.1696942175571;
        Tue, 10 Oct 2023 05:49:35 -0700 (PDT)
Received: from spiri.. ([5.14.139.113])
        by smtp.gmail.com with ESMTPSA id f26-20020a056402005a00b00530bc7cf377sm7629476edu.12.2023.10.10.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 05:49:35 -0700 (PDT)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] iio: adc: ad7192: Add improvements and feature
Date:   Tue, 10 Oct 2023 15:49:23 +0300
Message-Id: <20231010124927.143343-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Hello,

Here is the updated patch that adds fast settling support for AD7193. I
also added 2 commits to clean up the driver that should be applied
beforehand.

Please consider applying the patches in order.

Thank you!

v3 -> v4
	- two commits from the previous series were already applied to
	  the tree
	- add two new commits for cleaning up
	- use standard ABI for fast settling feature instead of creating
	  new attributes
	Link: https://lore.kernel.org/all/20230924215148.102491-1-alisadariana@gmail.com/

v2 -> v3
        - move comment line above
        - correct FIELD_PREP to FIELD_GET where needed
        - remove unnecessary !!
        - "rms" -> "RMS"
        Link: https://lore.kernel.org/all/20230920003342.118813-1-alisadariana@gmail.com/

v1 -> v2
        - replace old macros with FIELD_PREP() in commit "Use bitfield
          access macros"
        - update the other commits accordingly
        Link: https://lore.kernel.org/all/20230918214854.252781-1-alisadariana@gmail.com/

Kind regards,

Alisa-Dariana Roman (3):
  iio: adc: ad7192: Organize chip info
  iio: adc: ad7192: Remove unused member
  iio: adc: ad7192: Add fast settling support

 drivers/iio/adc/ad7192.c | 156 +++++++++++++++++++++++++--------------
 1 file changed, 100 insertions(+), 56 deletions(-)

-- 
2.34.1

