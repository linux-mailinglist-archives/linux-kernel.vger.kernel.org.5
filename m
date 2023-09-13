Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030A79E257
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjIMIjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239050AbjIMIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:39:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE3219A9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:39:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-501eec0a373so10697922e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694594352; x=1695199152; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvLDw+ksZq5rBFlvYEdzhLk43B1rOA0RI1tJreD8APc=;
        b=uBZlIe/YY5SMN5xFP0NA0h0jJ5eYlhFmXiLY4Lw7Ah3ZhXmK8o2E1jY6J9wS7y0u/I
         X1B3FjIM063U64anJ3GpeSfJ62vXmtFTiM+pKfUIu1kLfoqzUVWD230wY1Tnxi4/EU0Y
         ZJphuabZTg9l/3korw3HspHZkQd925XI9CpdqM4swRnJuDvO3tcH7pjm6Ynra6BijhRC
         Db98INmBtr733vPlFsl2qdmXC+Z2vsZmjD12Vfq2jCKoCzigUVqealavVwr5hStdUsR0
         c1vrTIU83aCZdrLFLYBrV+Pvz9L+vYH1WigEIY1O4ZiZN0l+LSZBcpYVDiMSENZlE41E
         AcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594352; x=1695199152;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvLDw+ksZq5rBFlvYEdzhLk43B1rOA0RI1tJreD8APc=;
        b=bYKZfRJJ8mKjJbVDsEfxcYtXdsznFTnv+jN2qsbtvZ2VDMjq2VOCkSYcJap7Yp17bV
         Yx6mwfLxtAVEXJCBNBttmDb6bs5pw73bHytbht3dh3nXX1hLA+yixnaJpAyeqyH73XXb
         Jmg2HuAPJ3R1/aMFL+A4GH79AuDadDXo5RGnv6pTM/q/syI9Igs9g8G25rN0aWEytWKd
         cVjIRtJnzj/5Ch5L7IejBZ0wJ5BtUHCz1b4iEkNvcs1okdVB1PmcJPns9CNs7L5NqX0X
         d0Ox8ArZG0iW6p6hOKr8HyUnCQ2XfggEFhmUMByB9rk/0VyWLKv/Vlar+rfjUTSzrdUB
         5ddA==
X-Gm-Message-State: AOJu0Yw1nr0Nu+bWqYmInZSuPiGLa6v/pBtSPJUX/9GA4I210peQ1IZx
        wTtXko7gXylPcbvzmghxdMWFgw==
X-Google-Smtp-Source: AGHT+IEnqYzccHV7NjaZ5GV7Q/W3n1TllGCZhHHJfaxw1ZwznaGRru1QoxEH45p7p6HhLVN0AL2p9A==
X-Received: by 2002:a05:6512:3b2a:b0:500:a396:b2e4 with SMTP id f42-20020a0565123b2a00b00500a396b2e4mr2030412lfv.58.1694594351688;
        Wed, 13 Sep 2023 01:39:11 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id eo30-20020a056512481e00b005009aa86582sm2044604lfb.55.2023.09.13.01.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:39:11 -0700 (PDT)
Date:   Wed, 13 Sep 2023 10:39:09 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix for v6.6
Message-ID: <20230913083909.GA473533@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small fix that removes a few unused function declarations
in the TEE subsystem.

Thanks,
Jens

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-for-for-v6.6

for you to fetch changes up to 069969d6c5264d2348fd6cf0cedc00fd87ff3cee:

  tee: Remove unused declarations (2023-09-13 08:16:24 +0200)

----------------------------------------------------------------
Remove a few unused declarations in TEE subsystem

----------------------------------------------------------------
Yue Haibing (1):
      tee: Remove unused declarations

 drivers/tee/optee/optee_private.h | 2 --
 drivers/tee/tee_private.h         | 2 --
 2 files changed, 4 deletions(-)
