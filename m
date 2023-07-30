Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63B77686B3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjG3R1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3R1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:27:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C0818F;
        Sun, 30 Jul 2023 10:27:13 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so56029101fa.2;
        Sun, 30 Jul 2023 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690738032; x=1691342832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzf187hUxe2O6hKwbRXnpT5+gDrj5GGc4EGmM8OK0aQ=;
        b=BOkcpZi5YuxUHBYhh+opPkziGZPWZjGNFwUZ+E4NSDOx/MBbKBfqZ8AxLzeslVBvfn
         p6gQ608KilfcOB1sKPyHeQjFkCNnpCur2/WV12nPOyVQMzRBAfUe3AFT7NtzCUp9I+UT
         39bX9VmuzQTHztK8gMVOqHLPNZ0T7aLUgD5s7yl2pXN0qCIdnSSoBqqys+54r3BU4d3f
         pvqY2EUvd2qDeW9SwOxEbbX9oQcx0NCO3bwNNUrLPW7gZy2/ZnTpXtNlOR9cZxrt+xlp
         gu0DJt7q/F7qnMZESELfzQvvvEHVM9bRzjrW+n59RMQYChdWfT2pI5TPWs10dwpj1fa6
         jqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690738032; x=1691342832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzf187hUxe2O6hKwbRXnpT5+gDrj5GGc4EGmM8OK0aQ=;
        b=k2EDTPDIasbBIqzdWUlQ3GawDgaA3GfHnm5J0gL/oTn1STIx12aKIcQYU9SW2S2OCW
         uBP1O5MbvdZUew+EeNT3X3P4dcakgVJmhf98IBZegW9TAnef69xggfZmJj650dk9l+sI
         AbsdI1ugk9qT5uve3oKfWnhKqfg6c5EPDYfjKXPRwBinSgA4tFvId4yduZ5WVcwL9OtT
         oCaIPJnOeGnXYGp3lgSi4TfGOE2c8ADKPwNsg5rfjaXvcJF3PEVfmJjPZI8Ib6GxgQYX
         ya77cxWOmApaNeZjGjTNACRwppybs3n7SY3OhoQDliOTMvYQQYxRs4N4Uinx8mPuXVVP
         +AOQ==
X-Gm-Message-State: ABy/qLZD1sqwSw6VYo1siqUOeJbqWn8bwPMlX8MreRGGven3pa97O59Z
        aV7p0Qkt/wrM2iJGZU98Ssw=
X-Google-Smtp-Source: APBJJlGTgEPphvwuhuIIMtNg5oBo3Lj67hITx94r7B2iCLqe/4Fl+saEaU6jlN2DfDyUPsdb0KPmMQ==
X-Received: by 2002:a19:ca16:0:b0:4fb:89cd:9616 with SMTP id a22-20020a19ca16000000b004fb89cd9616mr4160268lfg.0.1690738031643;
        Sun, 30 Jul 2023 10:27:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id x6-20020ac24886000000b004f8555f7aa1sm1737117lfc.52.2023.07.30.10.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 10:27:11 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Add optional properties to MAX17040
Date:   Sun, 30 Jul 2023 20:26:45 +0300
Message-Id: <20230730172648.71578-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend properties supported by max17040 fuel gauge if it is accompanied
by different devices.

If max17040 is coupled with a charger, pass charger status since it should
match and max17040 has no dedicated status detection ability.

max17040_get_online can be reused for PRESENT property since if it is
online it must be present.

Finally, max17040 may be coupled with a dedicated thermal sensor which
monitors battery temperature so lets add support for iio channel to match
hw setup.

---
Changes from v1:
- documentation dropped monitored-battery and power-supplies (inherited
  from inclusion)
- dropped passing charger health as battery health
- dropped patch for simple battery cell support
- switched iio_read_channel_raw to iio_read_channel_processed_scale
- switched iio_channel_get to devm_iio_channel_get
- re-organized implementation of temp channel (implemented in way 
  *_get_optional functions usually act)
---

Svyatoslav Ryhel (3):
  dt-bindings: power: supply: maxim,max17040: update properties
  power: max17040: pass status property from supplier
  power: max17040: get thermal data from adc if available

 .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
 drivers/power/supply/max17040_battery.c       | 27 ++++++++++++++++
 2 files changed, 58 insertions(+)

-- 
2.39.2

