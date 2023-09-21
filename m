Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB787A9A37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjIUSh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjIUSgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C40DB649
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59eea906b40so18811267b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695321158; x=1695925958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBlJtLtsdI3hK0QdaI1JvF2kBovJQMFIeF0KITJB/xY=;
        b=nOPHjrqBIGpQvEbyjHLhjS5j3oSFzKWpRTNcXv3ZiTZ1QUn6QonySbCQLpW7zhr5cV
         8hSf6ZQZoaw3bkIxeWhJpBzVvtdJ5XIEnqJDx9i6edYps8+9FgYx3cM7ZfwQQV6oo6nN
         +TbOf+P6/LCHwpAwxjbpvAzFFD8e9YFpK4ZkU1zXxLKYg6YToajfXo1DPzS0YeBBZfF/
         +WPpNCcN5zZ96FrI7H8YCktWklcudsIv52xBup4Zs27ucI6cmf1q4QIcx3am0n2RvedR
         X73itWfmcZW8FkDxPgES7hO3rnlBSQLglRatZCLQfoZcfQLZOfX+iOhGArxc9j80PmcC
         q4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321158; x=1695925958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBlJtLtsdI3hK0QdaI1JvF2kBovJQMFIeF0KITJB/xY=;
        b=YrIg83NqjqOWRqFXyhQA767Ruo/nE32HEE7MyMMGTVSKkyM9Rr7p9AEccCPXZ9A4PX
         NGHoauhDkFMCkX68pkjcJhX6R/6XL4mHSw/lRFWUaiV7eZcSfpMfDNnKzW1oD9/2DV/I
         Oo+1rGpizm/MNmI2hYeHxuV/8w3DlOdHa/VFQvx4Adfim861sciKqGJihNgmboC7iw9h
         shfEcPm00OnpsgqJUgA4zSXILCbYY6sM/7/9aVoVXEsA/SCJcR+ba+cr99sbl9wd66YF
         iX124s6bZZKeAIsH3wvx27+5uwcmYQLazr0KTIDdbYmU50uXCEIrasoHcp6kEoUUTlop
         joSg==
X-Gm-Message-State: AOJu0Yx97i+qV5Hz4HlWQV2icnw4YlilKJaWsk1gGx86xRU/bAbsNUBB
        QvdwstRQUnpq2Fttmxmn7HVaY6Pg6P5xWtAqIA==
X-Google-Smtp-Source: AGHT+IHI098EEpqO6htZ6MTc85xWWh3YpKsnqENPUYf7F/xvLGI92lITJbHV0USw1ADPIZbp1s0JkljinpuKkIaDuQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:4082:0:b0:d80:1391:1f1 with SMTP
 id n124-20020a254082000000b00d80139101f1mr63208yba.1.1695272040719; Wed, 20
 Sep 2023 21:54:00 -0700 (PDT)
Date:   Thu, 21 Sep 2023 04:54:00 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGfMC2UC/x2NSwqEMBAFryK9tsEkw4BeRVzk05nphVG6RRTx7
 gZ3VbV47wIlYVIYmguEdlZeShXTNhD/vvwIOVUH21nX9dagblLiemIS3kkUmRf0KdY+O/tSRBN y777+k3MIUJdWoczH+zJO9/0A10IdAXUAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695272040; l=2097;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wxLohCJ8OZyT4ckFvNL/ySlACAagL4RRycYgRdRDcQE=; b=FJozEDATUZfUMAdvAUx5oyW6ZiVUThemIA/jnMSx8yNUj5AxeA4RjStYDSxol7J7+D4rXF5CQ
 KDXN5IlUqusC1qJ5YHBdUIOWRiGU0IIeYHvhB5gxVpdkMBQYmxwb0L3
X-Mailer: b4 0.12.3
Message-ID: <20230921-strncpy-drivers-iio-adc-stm32-adc-c-v1-1-c50eca098597@google.com>
Subject: [PATCH] iio: adc: stm32-adc: replace deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

We expect adc->chan_name[val] to be NUL-terminated based on ch_name's
use within functions that expect NUL-terminated strings like strncmp and
printf-likes:
| 	if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
| 		/* Check internal channel availability */
| 		switch (i) {
| 		case STM32_ADC_INT_CH_VDDCORE:
| 			if (!adc->cfg->regs->or_vddcore.reg)
| 				dev_warn(&indio_dev->dev,
| 					 "%s channel not available\n", ch_name);
...

There is no evidence that NUL-padding is needed either.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding. If, for any reason, NUL-padding _is_
required we should go for `strscpy_pad`.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested
---
 drivers/iio/adc/stm32-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index f7613efb870d..9cdcf396d901 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2209,7 +2209,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 				ret = -EINVAL;
 				goto err;
 			}
-			strncpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
+			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
 			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
 			if (ret == -ENOENT)
 				continue;

---
base-commit: 2cf0f715623872823a72e451243bbf555d10d032
change-id: 20230921-strncpy-drivers-iio-adc-stm32-adc-c-1bf936a4ffbb

Best regards,
--
Justin Stitt <justinstitt@google.com>

