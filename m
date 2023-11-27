Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5F27FAB34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjK0UTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 15:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjK0UTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:19:06 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EA6D4B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-332e40315bdso2909214f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701116351; x=1701721151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVAREFnKuMw3M2hKqZLyWuu/hKV5DRez2l0z/lHMWSA=;
        b=bMxtwACBqGGvrnG4HhSPDPo0ExfZYusbX8nPy+33H1j2w+ZlDi1W4kItGaeKbTtEYV
         EnZwwOc6mjfYArvIg1lOM2DoqXOEvoSRjQ1AZNZNQaQdUAwYj/yiG5d9kyMTbrnrWpT/
         8xNoC56Ry3+riJPOFwHQrKj1W1FUEyole/knS/P8c9T08goHqDZrJUnt62FfVXtLIO3t
         1NpBuwQ//I7oo6t6I1xdybSzagYkd73UCvbgdl31n4PiCGlTX1zJbs8mEn+uZltdEkCX
         kU+8fOHacSopYweGT/b1I0JQNXrBZ3+56DZwoR2H60S8BJW9CYgf/ph+kLwI1ndCJPOq
         nnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701116351; x=1701721151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVAREFnKuMw3M2hKqZLyWuu/hKV5DRez2l0z/lHMWSA=;
        b=Ob2xSCjVO6le8DM5ZoF9UrDzGXc0oab0BgFJFkJ+pfFgIDJX1oQS1/tb7+Z8eQl0sV
         HFI4b2tEpkmAAdaM1JXB4ncYB+mlXyp9Tt5V15a3CDdyL89JVD9P2Al/lcs0vU1W2Wet
         i1o1v12q4a44LrnSwpZ5xBuHDNvQ926U792KIL51uxJQ4BqfGaw7X5U0/tOpyb52HqzH
         d3GusFt9W1/cFuh0aJt5mKye8JYFhyW0CzFLwrzU+9KfgNSbtFPfdE9Nf7WWflexRBbx
         VLGRExju9AUVcelUGxbRX8iVmuKyMoeCfKTJzjq7QGHgD4Cvg3NEQIty0NlpRNdxFrV6
         Atiw==
X-Gm-Message-State: AOJu0YwhaQ28LlDc+WaUB0RXs/eNSUr4Gdxvwc1lRLEQwICxdO0Z1+X/
        Eu2CpugzRqz5MbYI2TyLmq4=
X-Google-Smtp-Source: AGHT+IFhUiXVysnRHYMbw4lsokqP1C3X3uKsVRRPurwl7QiFbqhhKc6r+OAA7fnzOTBIbnkiJg2Ixw==
X-Received: by 2002:adf:fc92:0:b0:332:ea44:897d with SMTP id g18-20020adffc92000000b00332ea44897dmr8590926wrr.17.1701116350920;
        Mon, 27 Nov 2023 12:19:10 -0800 (PST)
Received: from mfe-desktop.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.googlemail.com with ESMTPSA id k32-20020a05600c1ca000b0040839fcb217sm15224619wms.8.2023.11.27.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 12:19:10 -0800 (PST)
From:   marc.ferland@gmail.com
X-Google-Original-From: marc.ferland@sonatest.com
To:     krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add support for the ds28ec20 one-wire eeprom
Date:   Mon, 27 Nov 2023 15:18:51 -0500
Message-Id: <20231127201856.3836178-1-marc.ferland@sonatest.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117192909.98944-1-marc.ferland@sonatest.com>
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Ferland <marc.ferland@sonatest.com>

Hi,

Here is v2 of my ds2433 driver patch series, see [1].

Changes:
v2: Incorporate suggestions from Krzysztof Kozlowski: drop the 'w1:
    ds2433: rename W1_EEPROM_DS2433' and 'w1: ds2433: rename
    w1_f23_data to w1_data' patches.
    Create a separate patch for the validcrc bitmap change (also suggested
    by Krzysztof).
    Fix build error: initializer element is not a compile-time constant.
    Rework the ds2490 patch and remove the ds_write_block changes: I
    have no way of reliably test this change with my current setup,
    and I did not experience any write failures. Let's not try to fix
    what already works.
    Rearrange commit order for a more logical order.
    Tested with the ds2433 eeprom.
    Rebased on v6.7-rc2.

[1] https://lore.kernel.org/lkml/20231117192909.98944-1-marc.ferland@sonatest.com

Marc Ferland (5):
  w1: ds2490: support block sizes larger than 128 bytes in ds_read_block
  w1: ds2433: remove unused definition
  w1: ds2433: introduce a configuration structure
  w1: ds2433: use the kernel bitmap implementation
  w1: ds2433: add support for ds28ec20 eeprom

 drivers/w1/masters/ds2490.c   |  25 +++++-
 drivers/w1/slaves/w1_ds2433.c | 161 ++++++++++++++++++++++++++++------
 2 files changed, 157 insertions(+), 29 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.34.1

