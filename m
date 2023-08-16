Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDBF77D707
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240801AbjHPAXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbjHPAXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:23:15 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAAD2100;
        Tue, 15 Aug 2023 17:23:14 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-48a6a1ba95aso96920e0c.3;
        Tue, 15 Aug 2023 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692145393; x=1692750193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ewy3jph8eFUqvJYQ5fxb1cHmB/29YYJLbrq/2HLKfQA=;
        b=Ww5VrMGTE5b4cShvT92MdnBJtMITmqagUiw9vfIN9DzULFolUH1gIo3rophcoSPHod
         Vb4XPwIfsC4n0vQOPEt9QTt+YXRsvr8ADcjB/9tQm9gmoy6iiiCwuvOaYVLBA1MWOVku
         PSArU/eyS33eBsnXSV/cIYff5zPcyX7RtF2oDNXKGNb6zX5q3M43embdBYKhfuppodsK
         vvyfrfm2y4cT6w2EBEUWqoweJqzE/28p+NFrhM8jPVxOJz87T1Zl6umkF4b3RypyH8Kh
         9oYZwcsJLRGiHBSUWq1z1KOd04cRvBQq7cHCQCcRrOaud/sh1H1MZ5KJrpzXex/uMWxc
         PAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692145393; x=1692750193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ewy3jph8eFUqvJYQ5fxb1cHmB/29YYJLbrq/2HLKfQA=;
        b=VPM0+I5tlRz8UQznltQOqLBVuIbjR+PpYE6tuevsVHFlcAALaaNzVK2AllBh1z7sA3
         1/gODNSM0Cf/S889OFxdaz+4TtvauUiHklFIJm6W0Jagw1IxCLaV1sge0s5kZrRJQdFs
         8mody1X0+mYZBcYD5zMm/jaufkTuh+P8ElI7N6BK0DO4gCIKYnPgHFd6gV1rIdXblrj7
         GwUHH8yusQpH8/eR0Cz+yHdDMRfFaVH2e8e/Jf9+frx+FGtjiVn4qpWVhUZ2ps6ceVP0
         SAgpTNG2q1tq9JEnqdAvqJyWSOH7JzIbXqX9DYlnPfoGCtEPYqOe2k+8Br/ABies1IZP
         499A==
X-Gm-Message-State: AOJu0YzaRNjp9X10YAIrPd4kJHw+ow7OgEQpBJi/SjaIvi6hZNvgiEuF
        MmOaFcsS0SK862+yD61OY+BKYfU2Ua8=
X-Google-Smtp-Source: AGHT+IGq81todTuD3tiXItIBzUXOtnc7KjT3G7QDS5QZk/8e9k37abfp/5TDXyqxuIAya3Xb2N915A==
X-Received: by 2002:a1f:e1c2:0:b0:487:17be:114d with SMTP id y185-20020a1fe1c2000000b0048717be114dmr515837vkg.8.1692145393178;
        Tue, 15 Aug 2023 17:23:13 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b0063d5c9de720sm4452436qvk.80.2023.08.15.17.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 17:23:12 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     drew@beagleboard.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pocketbeagle device tree updates
Date:   Tue, 15 Aug 2023 20:23:03 -0400
Message-ID: <20230816002308.36800-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.41.0.327.gaa9166bcc0ba
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

A couple device-tree updates for pocketbeagle:

1) Update the LED information (the LED on the pocketbeagle is blue, so
   correct the information). Also the "label" property is deprecated so
   replace it with "color" and "function" properties.

2) Now that mainline supports the PRUs via remoteproc, update the pin
   information to enable the PRU pins and set their mode appropriately
   as per the silkscreen.

3) Add a missing mode setting for a GPIO pin.

Trevor Woerner (3):
  ARM: dts: am335x-pocketbeagle: update LED information
  ARM: dts: am335x-pocketbeagle: enable pru
  ARM: dts: am335x-pocketbeagle: add missing GPIO mux

 .../boot/dts/ti/omap/am335x-pocketbeagle.dts  | 59 ++++++++++++++++---
 1 file changed, 50 insertions(+), 9 deletions(-)

-- 
2.41.0.327.gaa9166bcc0ba
