Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511C977CA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbjHOJ3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjHOJ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:27:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF211FEB;
        Tue, 15 Aug 2023 02:27:58 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe3b86cec1so8109165e87.2;
        Tue, 15 Aug 2023 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692091677; x=1692696477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdeVCEOEq3IkqSl8lDhrM4eFNQnZwh1jACSNFV8VQn4=;
        b=M5xbtJPjLw4KCMdi3TdevUmVGy8Z7WVJQt+UoKTL1z77zJxfamamUAsIwGUhud5OvX
         2UcefmbbUu2AjG0VcmvrJ2sC9wCz4PV4Gjjv+3JtWbW57LvEGsDDyywQo/rZlsesgRnv
         AqPkELQpCWPAKhYcS5HTteN3qYSwJxV0x42nCXCeelmw+2Edx3CHOeXZzmDbYR38ayaN
         G9yaAIaC8dqTghp5uMTJHH+tmGgTX0aHh/wWO+fyBdYOFuAZHezYFOyATDEXHRsOQA/4
         JQlXHPHz+MQ5KfWkEI7IbXD9uqBUfAaqASWUvngZXANHDNdaZSJ4xSwc7aG7DBWEXkuB
         TOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692091677; x=1692696477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdeVCEOEq3IkqSl8lDhrM4eFNQnZwh1jACSNFV8VQn4=;
        b=W+98QSS9ITihJWmiwe1g6hYNxrY4pRmwJdatMzx5wGZgNyptvzD7beMlAnjFIVPJ+y
         Lp2gytJpQBNCQjxVuyI69CbJLUIl3Li5jcALBVTeDehYY2AH5uYrY/N9cqQXer+nlfYh
         OqEJ1i4VuKEAX58jtodY5ew3pI/Ro8tK6xHcAnqxV6svKM1CMvDFI7pihWx3P2mc1tV8
         qUa/4XH/DShPb1fLJ7SGuvVwsKZqJzxlNb++6VjOv2n1QxH5MyiJUm4f5uDNXaAFa52Q
         Czkg3ZQfelzkzRauO1s4gME2sIiX5w3ti+22DeX3kBxe+P7WZxUvmSRM64iUb7zHOeur
         4APw==
X-Gm-Message-State: AOJu0YxNytVnSCl6eUS971HYHgrX6I1GYxH4beBGNy7VKdlMrWkaMoxV
        Z6tmZae8gOCEZuciUnU8v0sdpZZMVoY=
X-Google-Smtp-Source: AGHT+IGygiHXlVQiObE/1QBEILsWiJePF+nIYsZEgpCf4YcO1Sf9M14FSD46HJfe1Bnrx2J0GtYGbA==
X-Received: by 2002:a05:6512:b84:b0:4f8:d385:41bd with SMTP id b4-20020a0565120b8400b004f8d38541bdmr10278325lfv.8.1692091676625;
        Tue, 15 Aug 2023 02:27:56 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b003179b3fd837sm17230853wrj.33.2023.08.15.02.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 02:27:55 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 0/3] arm64: dts: amlogic: add more basic audio support
Date:   Tue, 15 Aug 2023 09:27:48 +0000
Message-Id: <20230815092751.1791195-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mini-series adds basic audio support to the P200/P201 (GXBB) and U200 (G12A)
reference boards. Few people likely have the original reference boards which have
extra audio capabilities, but the device-trees are widely [ab]used by users with
Android set-top boxes whose hardware is copy/pasted from the reference designs to
get working installs. Adding basic audio support does no harm to the real boards
and helps the secondary cause.

Christian Hewitt (3):
  arm64: dts: meson: add audio playback to p200
  arm64: dts: meson: add audio playback to p201
  arm64: dts: meson: add audio playback to u200

 .../boot/dts/amlogic/meson-g12a-u200.dts      | 129 ++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-p200.dts      |  60 ++++++++
 .../boot/dts/amlogic/meson-gxbb-p201.dts      |  39 ++++++
 3 files changed, 228 insertions(+)

-- 
2.34.1

