Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92FA785361
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjHWJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjHWI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:57:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A290C198C;
        Wed, 23 Aug 2023 01:54:40 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so34416345e9.2;
        Wed, 23 Aug 2023 01:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780878; x=1693385678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvjzMcJTUxU+MK76vz7j+AFRrvVux4oY0Dj2+641l0Y=;
        b=sERsmZoOkLdDWTnwUP2Kofx4VkusIJAGiuQoHYP50D/0DsKohHTvlO4VSN2VS0Pczn
         gI1S7i/EaQ96eca9cJqsoNip9YQqvxC8szUj/PAOEn6bXa3md8qZ6rTGDmqBEX4qqIRR
         dDaCJrH1w026ctOn+5M/yxS0ibx9j29ej4nHtVg7atsjj2E9Q+fS1kigtf+Z4jjl04G4
         fh/R0RXCbbziKaBdGuhHrXGEZkZT3omKclCnDWeyIWUHTPxBeqlPkgoIl+wT82TLPdQ9
         AkZQ4191uITaHZMGqJCCETJoF0uoN0ow6owW7EygfSIGbc3TlVtTOqtYN0zjIXNlSTfi
         iSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780878; x=1693385678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvjzMcJTUxU+MK76vz7j+AFRrvVux4oY0Dj2+641l0Y=;
        b=ZZNFHEJj2lXBzcyGpeGBem610oxa/TzNPtQXLymBeM9plvzibhxlcxKQZkga/KHrLJ
         kyDvxPskW1pZDgzHKB7mOZLZz1NW9YUHedPqY+FO7pe20Lsl+V4KrGEkvnpVC8jTnfD8
         uCYVZqUqHSWjcicTiX5T8rHHdliFYbmYAcGK6YIjg8/DSoUue+s7WkwH1jWKoDfI131G
         yv+kLhQDyUHZWldG+TAg5bjd7KA9fqw1vw8JBLZbm7/wJpjLcQfUQuRZlTTbgcKzPM4l
         B/6APTvONsEhQD2s/WYT3F2hqtAElOIJkwERTP9J+B1l+37sEIXB4Ivkb9JB2rsOOIOK
         ZRyA==
X-Gm-Message-State: AOJu0YzpKJlZJ3mYmqYMqd4pyBe8tP09ymQGJ22kt0wc4bO6eO7cq17r
        YM4QzDOTwhQjHaULHQGuYixRYWpmsGhjyA==
X-Google-Smtp-Source: AGHT+IGSqHZSd3AMmmQMokCafHKaqaeOt6ivAUAH16LjIYrCBQc0FrUQ77kSDtVWdQGNHPOi0ksgaA==
X-Received: by 2002:a05:600c:286:b0:3ff:150:d898 with SMTP id 6-20020a05600c028600b003ff0150d898mr1118353wmk.21.1692780878201;
        Wed, 23 Aug 2023 01:54:38 -0700 (PDT)
Received: from gba-Precision-5530.kat.ac.za ([196.24.39.242])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fed78b03b4sm16265420wmc.20.2023.08.23.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:54:37 -0700 (PDT)
From:   Grant B Adams <nemith592@gmail.com>
Cc:     linux-omap@vger.kernel.org, tony@atomide.com,
        Grant B Adams <nemith592@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 0/2] Fix tps65217-charger vs vbus irq conflict
Date:   Wed, 23 Aug 2023 10:54:28 +0200
Message-Id: <20230823085430.6610-1-nemith592@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both the tps65217-charger and vbus drivers are trying to allocate the same
TPS65217 device interrupt line (TPS65217 is a TI power management IC) 
which results in the following error and a probe failure:

genirq: Flags mismatch irq 148. 00002000 (vbus) vs. 00000000 
(tps65217-charger)

For the Beaglebone Black's config the tps65217-charger driver is currently
disabled and therefore no conflict. Based on comments from Robert C Nelson
this driver has been disabled for a long time and he is uncertain on the
reasons why it was disabled. With a battery connected to the BBB, I 
re-enabled the tps65217-charger driver which resulted in the 
abovementioned.

The conflict is resolved by changing both driver's threaded interrupt
request function from IRQF_ONESHOT to IRQF_SHARED.

Changes in v2:
   Initial patches where emailed individually and not threaded. V2 patches 
   sent as email thread. Feedback provided by gregkh@linuxfoundation.org

Grant B Adams (2):
  power: supply: Fix tps65217-charger vs vbus irq conflict
  usb: musb: dsps: Fix vbus vs tps65217-charger irq conflict

 drivers/power/supply/tps65217_charger.c | 2 +-
 drivers/usb/musb/musb_dsps.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

