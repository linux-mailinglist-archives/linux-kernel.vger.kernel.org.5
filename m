Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB78C78BCF2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbjH2CnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbjH2Cmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:42:38 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AE9CFD;
        Mon, 28 Aug 2023 19:42:08 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64a70194fbeso24754606d6.0;
        Mon, 28 Aug 2023 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276927; x=1693881727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxdVEA8qM411actKiHsw740ThEcbY5HFWhYgKQz6o3w=;
        b=ZeTiN656d7sz913Slk3DTXVrcws1W5D3Jo32gB4khdl+Bk9ULXmw0eRKUgf/FsKzoC
         PwZwDmfWbOv+dUFcbEbLtXrhrV1S+27nvKp4jAhrnjf1oWUxRgnV5oB2JVmYFOEih7/x
         PmG2VsQh87zUWFwRAhHDF7+8PDy00loIT5GxNFywUeg6wmnvpk1IWkxylF3vI5j29BCm
         rCgT07BCwuhn5NNDtREUElJf8O7zGpqzN3UIxr4w+81ULZvI31jb9w4uVQazG/6WdX19
         uhnQpoV0bebYc9WAKmx5DkhqNo98y4YtRQamZuTDl9EzkjerW52ECLBgRoRxJMxsKBIh
         hFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276927; x=1693881727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxdVEA8qM411actKiHsw740ThEcbY5HFWhYgKQz6o3w=;
        b=hWbudW+RnPCSZFxwdFu0f+Q+SZgxoJxNXB/DfbBFXXGWkzmOGOM9eagAYQKQhY20IT
         4md1NlcRgx+ZGW1fWy83b4qg1UNArZKuwlfDBBsHS7/bvkoXuLFtWL4phiD4y5Z11dgy
         9EWpy0u3Rtgn2LESavK+m8xVoQy2Bij0+SJqe/jvYhULX9uPezaz7goVbqIs9cCP1Ox+
         s6I1xpdG8coYcfl3oga/AS+v47+E7qvJukmrWoF22k6ZzppCqvD54VpoMR5Dq4XFEf16
         NtDvZScH1eNYRz5UbHtByVjgdA9ImPL4xRt0LROM339Xu1rifeUmuEL6U4xD974gt4eH
         sJ/g==
X-Gm-Message-State: AOJu0YwE0zXW7yg4VJUr1Vi9sjP5kGR1wP2TXmTodGQ+6dzzzKQBAnfD
        pDD9gmjlhl31MYw4yUT5D5Q=
X-Google-Smtp-Source: AGHT+IFCN2XIRLV2WFVF3Zw4K7NSUcaeFizKJ5JM0aOBPNE9xdzHaOuU/ktElukQsKK5qVnp+FRNeg==
X-Received: by 2002:a0c:ab82:0:b0:651:6bbd:1da3 with SMTP id j2-20020a0cab82000000b006516bbd1da3mr3013534qvb.23.1693276927651;
        Mon, 28 Aug 2023 19:42:07 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce509000000b0063cf4d0d558sm3010037qvm.25.2023.08.28.19.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:42:07 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 0/2] iio: adc: add LTC2309 support
Date:   Mon, 28 Aug 2023 22:41:33 -0400
Message-Id: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN5a7WQC/02MzQ6CMBAGX4X0bE1/hXryPYwHWhbYBKhpSaMhv
 LuFROW2s/lmFhIhIERyLRYSIGFEP2WQp4K4vp46oNhkJoIJySoh6TC7fBnKjdLAwSgjOcnrZ4A
 WX3vp/sjcY5x9eO/hxLfvt6F+jcQpo7YqrQJbMcncrRtrHM7Oj2RrJHH09N8T2bs0pW6Fla3V7
 Oit6/oB7eRD19YAAAA=
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693276926; l=1578;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=rKdEJGevPJUIrSlQaCKmhZaJlTTS20jNOjkx82e/hB0=;
 b=BsdO1GAKx1qC/luowsFQB6Zx7CPfb/sVx+KNez2gV9O8fun9zXVsmw64tSJ62BPXRTse14jRj
 ZpMWzUP7TUjB+wmjV9ZPi9+QYNwAZJ/gJfxh98UHj0o36ZSkjO1wl7p
X-Developer-Key: i=liambeguin@gmail.com; a=ed25519;
 pk=x+XyGOzOACLmUQ7jTEZhMy+lL3K5nhtUH6Oxt+tHkUQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.

This implements support for all single-ended and differential channels,
in unipolar mode only.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
Changes in v3:
- fix comments, kerneldoc, and i2c_device_id
- drop DRIVER_NAME
- drop datasheet_name
- drop unused i2c clientdata
- rework .read_raw() locking, adding utility function
- remove reundant parent assignment
- use dev_err_probe
- update devm_regulator_get_optional() error handling
- Link to v2: https://lore.kernel.org/r/20230825-ltc2309-v2-0-6d75f2b3fb50@gmail.com

Changes in v2:
- reduce critical section scope to i2c accesses only
- fixup .probe() commit
- fix unbalanced regulator
- rename refcomp to vref
- update lltc,2497.yaml instead of duplicating bindings
- commit dt-bindings before driver
- fix checkpatch --strict warnings
- Link to v1: https://lore.kernel.org/r/20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com

---
Liam Beguin (2):
      dt-bindings: iio: adc: add lltc,ltc2309 bindings
      iio: adc: add ltc2309 support

 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml  |  20 +-
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ltc2309.c                          | 249 +++++++++++++++++++++
 4 files changed, 275 insertions(+), 5 deletions(-)
---
base-commit: a5e505a99ca748583dbe558b691be1b26f05d678
change-id: 20230823-ltc2309-1945e1e94931

Best regards,
-- 
Liam Beguin <liambeguin@gmail.com>

