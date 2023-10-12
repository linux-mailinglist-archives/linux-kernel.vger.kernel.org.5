Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E767C779E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442583AbjJLUHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442334AbjJLUHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:07:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1C5B7;
        Thu, 12 Oct 2023 13:07:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1262414f8f.0;
        Thu, 12 Oct 2023 13:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697141230; x=1697746030; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1xCOduBz/pz5cH3mJwiI6SospsATx+ZFrNIHPNWJgoE=;
        b=W2mlha4WruLckDMV3dJi6+fvltWu+NujxWZ/10ilyt1WjsU2KjmIIfq+8k48g5zfP4
         HOult6+1rTFw098h5u/ZkrpO5WLJqwp4jUn1dOGfqxiYfNX3z1x08nbz6qUaE1fi3ueH
         RGSKucW3TGn0c+LznfRbU/mwZpZrRMKDzrmnu5obSCF2wt1opSicRMPfXs+2h5a8+psf
         tdnBwBPWKnP7xjKpHpdfsUmaQ6queedT0ioCj6oRg0yJERHY32xgMZgU1tS7ZmAPseBK
         EID31HARjWLMJfr5TlUDi5vc6YgEJRLyIFIgV35dD9um1N5/yCXh6YmfePSIqEplqf/d
         CRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141230; x=1697746030;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1xCOduBz/pz5cH3mJwiI6SospsATx+ZFrNIHPNWJgoE=;
        b=LjYjJFmZbi0d6Kl5jeiZIylStdT6lkP8Yr/r0JRyb5iQ97LtherwIa7u/UcfBcQajK
         0Gg2teRBz2yBRKG0mfFddA8tRGvQadWm6p0a66HFw8F1Z/jy4kKlf+0/qvQClmLw3gSS
         /un3UU2OXLSSF3Iy2ZxG3hoF+yCqgZWDTtq3JshzH8UkoL7SwAA9urlteQKP50AgBrUl
         3wc9CRu89QjX5TbE8HEokYy/LIU6v7jRaL3dzAikib7WbIAd0e6CzaaNPsY+zbRKsPhB
         j3wXkZu5OzEBz+6xpcO0OI9UZGwGJ3AUuz5K+Albo2rPH2RclGwRXu8GZHH2SK2Thirn
         EjMA==
X-Gm-Message-State: AOJu0Yzttked5wN3FASQ+jxHmPs+3DiteiCoMZU6F46OmdZ7JsXVBOV/
        KgM7UPS+IlOlCt3ijINQ4pH6d9C+3AcUSw==
X-Google-Smtp-Source: AGHT+IEZe96pcnP4a4k4PRw1PWd2Q4OxEqRFn2Ow585JQckWn4radON9CUrU4pjYlxQagFlEudYDhg==
X-Received: by 2002:a5d:504e:0:b0:320:bbb:5ab1 with SMTP id h14-20020a5d504e000000b003200bbb5ab1mr21901622wrt.14.1697141230316;
        Thu, 12 Oct 2023 13:07:10 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-de42-73c9-6d1f-dd27.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:de42:73c9:6d1f:dd27])
        by smtp.gmail.com with ESMTPSA id p7-20020a056000018700b003217cbab88bsm182093wrx.16.2023.10.12.13.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:07:09 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] iio: Add device tree support for silabs,si7005
Date:   Thu, 12 Oct 2023 22:07:06 +0200
Message-Id: <20231012-topic-si7005_devicetree-v1-0-6c8a6fa7b3ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOpRKGUC/x3N0QrCMAyF4VcZuTbQ1NmJryJD2i66XNiNpIgw9
 u52Xv4cPs4GxipscOs2UP6IyVJa0KmDPMfyYpSpNXjnz+TIY11WyWgyOHd5TE1krsqMoe9ToBQ
 8DVdoOkVjTBpLng//jlZZj2FVfsr3f3kf9/0HUXUh/IIAAAA=
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697141229; l=693;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=m6qssN5Y0InXKNIH3UDlmn4+X06e5NK1jM+4JnsYg0I=;
 b=uEIIm5xWxyJt5mqgpLpD1K4LgBG3iC0jNIAaMYaJ8sEAsVBJzDu/jgCkfljV8+QPEoZ1ShG6z
 Gv+DJcBwG/pA/4/kvfRMMQ0eD/0q4aya2Ow/a42+47cBgXFFZVDlnO5
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds device tree support for the IIO humidity sensor si7005
and extends the trivial-devices binding to document the addition.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      iio: si7005: Add device tree support
      dt-bindings: trivial-devices: add silabs,si7005

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 drivers/iio/humidity/si7005.c                          | 7 +++++++
 2 files changed, 9 insertions(+)
---
base-commit: 401644852d0b2a278811de38081be23f74b5bb04
change-id: 20231012-topic-si7005_devicetree-644b61b62178

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

