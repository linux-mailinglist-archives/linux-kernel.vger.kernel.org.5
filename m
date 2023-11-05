Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2B7E160E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjKETcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 14:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjKETcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 14:32:18 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CFDD;
        Sun,  5 Nov 2023 11:32:15 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c2a0725825so549081766b.2;
        Sun, 05 Nov 2023 11:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699212734; x=1699817534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vleltte9bqYNVxoqP70DPmoJepyBKDB/qLui5qjstUc=;
        b=Imx+mV+wr4Jq82FlpBy6iPAkSwDx5ZZQMW8BZK64S7GdGQQUwRBjGSYq/dP0Sh65LH
         Sm5yz3jtkyPq/VVX4+8iejTxxHRNM51oRHZ3urs60guyZj68q/CtY6ziU/EUdTEiam51
         VSkLIlZcC5HMJP0goLjrh4DPb5DIc9R4kvEpK9KhEBRqpiXQsqrpeOG1x6fsrIQvV5Te
         1OiBgyFLEYokhjeTeIhxjWv4iEIYvuZS3zN6cZn68jpCJCmTlVUJngNaG8fJYp5gUyRP
         KmxeT/nTNdjQ+WirKKC6ceajqSQmf/V4hcwuD6O8rCuXkxmH2OI/BIUOYCGfkfJFcmHL
         iSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699212734; x=1699817534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vleltte9bqYNVxoqP70DPmoJepyBKDB/qLui5qjstUc=;
        b=gXDv51NL2eBXBJZOd17LhIF+IXKHE8ME1z/6zOg97SIwhfExuDD0+78f5RPA30k8bF
         fHwpXazKsjtRraqlOqiKWFDz7Ifl4PrM8dSKhEqEPR6PvC0O4NfwtJf2HiG83q9Q+9Jv
         z/uhZvGahUe7PPcHm7fQ+fZNEGvqhC3ndQ81xlY5gY0nIB1C2ieQVFw9lNM/Wpf9feRT
         I1VJN1dmSg31De2PJGq+0yUmtktyGew5rxpf+UykWbTyWgyuHNG3WuxwfSRaCDTQx72X
         hUfOvV/VlID+MOrgmWnCzAUcvRasT/QjUijqLNDX6s9HCjVxNhwTi411YTOLkOKassNi
         tvVQ==
X-Gm-Message-State: AOJu0YxhNPhFn6uF2C+iWtxD86btnH6FkDB+nBVeEySwJqFmEWGTK+BX
        QFfEns4MtNOW+r0dWvJyNx4=
X-Google-Smtp-Source: AGHT+IG5YMre6qZJMtlewbPjPz7g4uPVaNPoH86enWch0Sj16kYSPmGech8CbjnYPAyhSh26dX6DqQ==
X-Received: by 2002:a17:907:25cd:b0:9c7:4d98:981f with SMTP id ae13-20020a17090725cd00b009c74d98981fmr11167835ejc.33.1699212733678;
        Sun, 05 Nov 2023 11:32:13 -0800 (PST)
Received: from spiri.. ([5.14.137.80])
        by smtp.gmail.com with ESMTPSA id d26-20020a1709064c5a00b009b947aacb4bsm3300259ejw.191.2023.11.05.11.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 11:32:13 -0800 (PST)
From:   alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: adc: ad7192: Add support for AD7194
Date:   Sun,  5 Nov 2023 21:31:28 +0200
Message-Id: <20231105193132.47009-1-alisadariana@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alisa-Dariana Roman <alisa.roman@analog.com>

Dear maintainers,

I am submitting a series of patches to improve the ad7192 driver by
adding suport for AD7194 also.

Please consider applying these patches in order.

Thank you for your time and attention.

Kind regards,

Alisa-Dariana Roman (3):
  iio: adc: ad7192: Use device api
  dt-bindings: iio: adc: ad7192: Add AD7194 support
  iio: adc: ad7192: Add AD7194 support

 .../bindings/iio/adc/adi,ad7192.yaml          |  69 +++++++
 drivers/iio/adc/Kconfig                       |   4 +-
 drivers/iio/adc/ad7192.c                      | 176 ++++++++++++++++--
 3 files changed, 228 insertions(+), 21 deletions(-)

-- 
2.34.1

