Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BA378762D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbjHXQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242782AbjHXQ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:56:05 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B9A19B5;
        Thu, 24 Aug 2023 09:56:03 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-64b8e1c739aso397866d6.0;
        Thu, 24 Aug 2023 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692896162; x=1693500962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILOTr0m07dVbSoMKJuKWs453YXtNmB3DAUAXZDSPcEc=;
        b=UT0sQAh7iT0L8B15VIkTBWD0F1T8hZxaELkf67itzzND9HejLoBWHEM0yiurDZXSN6
         N3bGAoXIpDA111csJSNsOFc/7LNCvG5GFf3zQg/ouWLu8dwwn+ioXowoiMKhe5WtN5ea
         lnooNSW7B+prb3n2C00aOYOar9rntDiGPbuKFGlxoB5uW0NifUKpPbHk7XENROi87ctt
         sa/mOU3RCTG0IDGLBxWEJoZtV6F11zFYDQYNWsrrZXstdRDOomaX7533qTudYC+8eJnk
         BJnqXWUZxsLu3naeGLa9nUiInZMKk34AGp4JZnWDdx57g9HotSeH7XDl5/gpqSeelHZJ
         0v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692896162; x=1693500962;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILOTr0m07dVbSoMKJuKWs453YXtNmB3DAUAXZDSPcEc=;
        b=RICcRufhs6M16qyJ8dM/BRgNgA1W92Y/z2Ai3+hOn1CVewzl+RGUcaeGhPF3NrQgRN
         4+Ou8LcyDUv/Epz2meho54CNPBHufuWSXi4qII9/PrC0oz+mc728QzI1hGkTjOPrF0nJ
         SZ/2BgpLFhT4XVdT1R/QtBP+K06QipsvuKKS/ItLwpBZQST5EdQ0Fq1MZP+aP4o5uLY7
         q1kx7v05q06ZKfIV5zrvA8xg3imEuvxrDI9/9bTuol5tpanneEEFsu/S2F++d/g91r2H
         oUNLYO6GUTUWs5KAu+AtmtCkE6/K6ysQmCMwDlI059mCBnueAgD0dJikns7nJF4Py34j
         a/7w==
X-Gm-Message-State: AOJu0YycwAXFPQuBNCAYlFWW5LXgawuVNLIerUNS44g9rk/0uewVwRHp
        lQvECdXmRXleO5fDJKuW7tzihmT2mAlR48WkQc4=
X-Google-Smtp-Source: AGHT+IH7U1di+2HvuusiASnJsaGVkI8xiTGwqjbGdW9iSZqfuqsX3f09HqOt/Zo/4Ggx66bfPdgmSQ==
X-Received: by 2002:a0c:da93:0:b0:64f:36b3:5620 with SMTP id z19-20020a0cda93000000b0064f36b35620mr15067124qvj.46.1692896162617;
        Thu, 24 Aug 2023 09:56:02 -0700 (PDT)
Received: from [192.168.0.16] (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id u18-20020a0cf1d2000000b0064f4f14aecesm2225654qvl.24.2023.08.24.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 09:56:02 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH 0/3] iio: adc: add LTC2309 support
Date:   Thu, 24 Aug 2023 12:55:29 -0400
Message-Id: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIGL52QC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCyNj3ZySZCDLUtfQ0sQ01TDV0sTS2FAJqLqgKDUtswJsUnRsbS0AYaL
 c31kAAAA=
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Liam Beguin <liambeguin@gmail.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692896161; l=852;
 i=liambeguin@gmail.com; s=20230824; h=from:subject:message-id;
 bh=DEp31rET57eI0x9mfaMcLLUtcOwcazMWOJbUx2VdHpM=;
 b=4PmfHzZRTVkOZ45b93vyboxcRg3OtsZdPaMIUcuX5IneTOGRnKBshHpSLhUofqwrf6PPej3KL
 bzF4dn+nysAAdlPk7B+2nspoUvrbCHm3XmGUWcaE8sGdiMZyYusixaQ
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
Liam Beguin (3):
      iio: adc: add ltc2309 support
      iio: adc: ltc2309: switch to new .probe()
      dt-bindings: iio: adc: add lltc,ltc2309 bindings

 .../devicetree/bindings/iio/adc/lltc,ltc2309.yaml  |  52 +++++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ltc2309.c                          | 231 +++++++++++++++++++++
 4 files changed, 294 insertions(+)
---
base-commit: a5e505a99ca748583dbe558b691be1b26f05d678
change-id: 20230823-ltc2309-1945e1e94931

Best regards,
-- 
Liam Beguin <liambeguin@gmail.com>

