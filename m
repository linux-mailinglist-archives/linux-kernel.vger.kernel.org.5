Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B057A3DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjIQVMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238963AbjIQVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:11:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC2B12A;
        Sun, 17 Sep 2023 14:11:52 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b962c226ceso63381861fa.3;
        Sun, 17 Sep 2023 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694985110; x=1695589910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbEVMpv7/YnbMGIp0/EmGv+3NIx0ZzAIlj2g9uMKIzw=;
        b=XNZ8gJHYbdi33zKhS2AjOYNEZJQrUqo2Nyv7Q2uduMa95ENAfwX+EB8ZWFNgmFxqEg
         8FE6py2p3Jrx57YPRqA1VqEROYN5BnFhDuAFOUv3vA20btVcnQnyFDWoa/n+PwjPPKqq
         m7nVgyVyNqZalF3qWuM8fBchfH8yov/LWbgwhnpBUA1250G3cd+Au1b52CyqDTr2SShZ
         cSGztab0vtyxY9MH9x/yjttIPej0us9lV56jc02Iv4/oeDBkB61CPAloiZJws+xAKhfK
         NcOGOLK5eAc1wOomnnppY6Tl78nhux84/7MvlVkhGUZmUdIzKUx0086x2eDgWabeAYMQ
         BNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694985110; x=1695589910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbEVMpv7/YnbMGIp0/EmGv+3NIx0ZzAIlj2g9uMKIzw=;
        b=maqbjd9trfmk4U+nwt41+StV9onj9VGVfuIs59CraSg4gWOSVOnmmYf9sdyc1EED/k
         tHFj7WnGCfRPNMJ29Sn3VYkMiaNUpLsj5oeBK1WoF3LvkjwtBKnSLUlf4d4HGpWUeMd6
         aqhQUQYQ2I/gWpje1Sg+8lSqBFdCvdSqbybM6YsV94KyeQZRtFyKjWlh28IYtis492Xe
         mcJ3dgl2AumFKZnPy2urA3+dLVhCnJKw/nKbLyGZos3qhZq58SOrjmI8ipR/FwHx6wFK
         4zWa7cEnpgFZUxNTYLDaspX2GWPAj3cDYRx5RSylGXVBytragIW+BBjLCBeKnCSBEFqM
         TQdQ==
X-Gm-Message-State: AOJu0YxtNiiIvklOBZU+VoLAye96wUCc2+WF5x8jUQ0BneUgZW7s9xFJ
        MGVGn07iid2G1s0LKmeYlR0=
X-Google-Smtp-Source: AGHT+IEf8R6jwvBheysbxOAQCkkhTFsqlPHuR6u5gZrsLlpxQSzA950B3ow020R3Z5PZSBF571ZSgA==
X-Received: by 2002:a2e:be28:0:b0:2c0:cd8:2bdc with SMTP id z40-20020a2ebe28000000b002c00cd82bdcmr1002933ljq.24.1694985110305;
        Sun, 17 Sep 2023 14:11:50 -0700 (PDT)
Received: from fr.lan ([46.31.31.48])
        by smtp.googlemail.com with ESMTPSA id p15-20020a2e740f000000b002bce3123639sm1766309ljc.98.2023.09.17.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 14:11:49 -0700 (PDT)
From:   Ivan Mikhaylov <fr0st61te@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Ivan Mikhaylov <fr0st61te@gmail.com>
Subject: [PATCH 0/2] Add maxim max34408/34409 ADC driver and dts
Date:   Mon, 18 Sep 2023 00:11:41 +0300
Message-ID: <20230917211143.7094-1-fr0st61te@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Add Maxim max34408/34409 ADC driver and dts for it. Until now it
supports only current monitioring function without overcurrent
threshold/delay, shutdown delay configuration, alert interrupt.

Ivan Mikhaylov (2):
  dt-bindings: adc: provide max34408/9 device tree binding document
  iio: adc: Add driver support for MAX34408/9

 .../bindings/iio/adc/maxim,max34408.yaml      |  63 ++++
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max34408.c                    | 334 ++++++++++++++++++
 4 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
 create mode 100644 drivers/iio/adc/max34408.c

-- 
2.42.0

