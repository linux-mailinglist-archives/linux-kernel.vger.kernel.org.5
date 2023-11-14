Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9E7EB72F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjKNUGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjKNUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:07 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341ACA7;
        Tue, 14 Nov 2023 12:06:01 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d242846194so889417966b.1;
        Tue, 14 Nov 2023 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699992359; x=1700597159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yEOYqIoJdVSkU55czPwf7r14EQRegDnx+cT+pdey7ME=;
        b=KLDLQY+pfZEOmG86b/6qicCtNLU2yo8gGVovIVcR9D5HYS60stJozyQGM6TSey/Q/3
         liuDNeHoWb5a2ooHVJiPtgoKmTwSbELhMhXCrb/gmnXv+SBmFKpFl1hDOH35nW6nfA5v
         PY2RQpCB0LQz+rA4P1UC1/sZPEoGs2N51+b8EWpZ237XG8yjGDi8Ufb4OIv3tJZr1BtP
         s1XExsahW1Hl2gdiNtCH3/3CeBgmgYbuz2+oMRWNu4ruZbvrZlLF6e37mFSM7SqsfNE0
         DPFZ7eAIfOHv3m6v3j7y2BKNg6y6z+9ZDfGZhg/EblFTF2vex5awy+NlCfJz41ZrvOzq
         M5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699992359; x=1700597159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEOYqIoJdVSkU55czPwf7r14EQRegDnx+cT+pdey7ME=;
        b=geQhgoN3hS4SuJBwsCMUIK5FUCRzAF50oTr0BGI6ZJMX3vAlQtoG8QhbGzpwyCIEVP
         nruB2tg//3a3uOyJK8FG9xRUDIZnhUG/AGqoOY64Bg6X21AwvcgYUvQQv5Cuowv9LVIY
         J+1gzLkMvPiymoQEtuHQ/ytjx6lOXGHzoawhxOvZ/5sqJOzkTEtTlQZrygafBOYvWl7+
         yiG/m3gc7gHxgmc98TRhmNhZuGsgWSwsaSF9iNvEGvtPdy9dj7+6qUuUspmR3FZ/6JxF
         ECquOcu3n2gLy1SHMCN64/Fp/YPNSiMKWR555/FbURiVB1lgRAliMPY/iGPoDXH+hTIW
         rRUQ==
X-Gm-Message-State: AOJu0YxDCy2nQykoqxHvaJ2kEBbJI3EjzHRgy7hQM1epsvRnOFIrkRg+
        Rus/wHhmcPgxRNpy4YGbgj8=
X-Google-Smtp-Source: AGHT+IGO7xk8qyDNVRUJnURRx+A/R/f81R+s7A2poSDsiwOfsrandMhDTXba7YI0/JIGJ99ZPPEpRg==
X-Received: by 2002:a17:906:6009:b0:9c2:2d0a:320c with SMTP id o9-20020a170906600900b009c22d0a320cmr6690935ejj.46.1699992359409;
        Tue, 14 Nov 2023 12:05:59 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id me19-20020a170906aed300b009ae587ce133sm5984429ejb.188.2023.11.14.12.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:05:58 -0800 (PST)
From:   Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] iio: adc: ad7192: Add support for AD7194
Date:   Tue, 14 Nov 2023 22:05:29 +0200
Message-Id: <20231114200533.137995-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainers,

Thank you very much for your feedback!

I am submitting the upgraded series of patches for the ad7192 driver.

Please consider applying the last 3 patches in order.

Thank you!

v1 -> v2
	- new commit with missing documentation for properties
	- add constraint for channels in binding
	- correct pattern for channels
	- correct commit message by adding "()" to functions
	- use in_range
	- use preferred structure in Kconfig

Kind regards,

Alisa-Dariana Roman (4):
  dt-bindings: iio: adc: ad7192: Add properties
  iio: adc: ad7192: Use device api
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  84 +++++++++
 drivers/iio/adc/Kconfig                       |  11 +-
 drivers/iio/adc/ad7192.c                      | 176 ++++++++++++++++--
 3 files changed, 249 insertions(+), 22 deletions(-)

-- 
2.34.1

