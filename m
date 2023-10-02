Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1448C7B5A25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJBS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238654AbjJBS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:26:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34161AB;
        Mon,  2 Oct 2023 11:26:27 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d8164e661abso52677276.1;
        Mon, 02 Oct 2023 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696271186; x=1696875986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UigAivXAAGoiJrn0MflIK+cO30h4BgtNGjH95iW+1cc=;
        b=b2D3BLwhpiI8BfmhYPYV+6qhJP/KjZOcpUiFNuKkFw/0DOOyUAC+i689LNBOsMwsbw
         URKzFN2x7kGezl24EqzFtqJ46HzFKDGGREd0UtzWI0NzzftWItmavZncUjBbmQHe3Dv0
         E/Qs15V+tRVR2aEfJrgBI209mKuz+wbccLUtRCcPbQNjZDTs95rGh4Tuwj+ABqdESt5a
         xJoZuC9mxJR3x5jF1OVJL8B0trCe1Gh8AlfohQMaBbb++2KyJ1V7Pmt5W6fUurrgn6XN
         w+D85M07kEfkPmwCidKdfYmKVctw7I1hXPQvXIHMOefHlHwr+Whwtmv5H42rlTk61wuQ
         x6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696271186; x=1696875986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UigAivXAAGoiJrn0MflIK+cO30h4BgtNGjH95iW+1cc=;
        b=t74GWL1IFXrXUrXLo7QIPbzARAy5aX+8VPzwY5dm69awxtCMcZicmmatDEXuN2DdkZ
         9L6Ht0g03i5+T4cinF9wWUjzvnq4AnixoFBu/2CznKVKZ9wsH7KMGV4blhTlTJgZzdnA
         ESp63YC99L3pCAW0DYyIM0EXqIuxAES6BtAGz82gxk2FgzeyQamYp++G21qmljt0QsVC
         WOjoV5/RGopUh5F9MLij0b01TdALwLR54cdS+3OrkdfyTqD/zHT5zJNXPRtFLa2k/GdR
         4yy6ymSjPhxTWJeDpeVXZJ7YQjplPfpG/Zbi7+AUBS92FlpHFyZ14kTKcZzrNcU389vL
         mDbQ==
X-Gm-Message-State: AOJu0YwxZV0EI5e44zgzS+LdeKX0IsZ5VuZLkr8HlXQwIkUn7bc41ZRD
        MZJ7J3DYqnrUmnuV1ufwUHI=
X-Google-Smtp-Source: AGHT+IFzbMDwqxVflQ7EiVC/zH+6T85RjWEmQrguJToZK7EIiMNEqgG6bD8x65C6zsrQ6oyEcSV9mg==
X-Received: by 2002:a25:ab81:0:b0:d7b:ac56:493b with SMTP id v1-20020a25ab81000000b00d7bac56493bmr11335305ybi.7.1696271186318;
        Mon, 02 Oct 2023 11:26:26 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id a8-20020a637f08000000b0057d86bb613esm17249584pgd.45.2023.10.02.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:26:25 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v6 0/3] greybus: Add BeaglePlay Greybus Driver
Date:   Mon,  2 Oct 2023 23:54:49 +0530
Message-ID: <20231002182454.211165-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BeagleConnect is both a technology concept and a line of board designs
that implement the technology. Born from Greybus, a mechanism for
dynamically extending a Linux system with embedded peripherals,
BeagleConnect adds two key elements: a 6LoWPAN transport and mikroBUS
manifests. The 6LoWPAN transport provides for arbitrary connections,
including the IEEE802.15.4g long-range wireless transport supported
between BeaglePlay and BeagleConnect Freedom (the first BeagleConnect
board design). The mikroBUS manifests provide for rapid prototyping
and low-node-count production with sensor boards following the
mikroBUS freely-licensable embedded bus standard such that existing
Linux drivers can be loaded upon Greybus discovery of the nodes.

This patch set provides the Linux-side hooks required for the 6LoWPAN
transport for BeagleConnect on BeaglePlay. Also adds required devicetree
additions.

Tested over `next-20230825`.

Link: https://programmershideaway.xyz/tags/gsoc23/ GSoC23 Blog
Link: https://git.beagleboard.org/gsoc/greybus/cc1352-firmware Zephyr App
Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay GitHub Branch
Link: https://docs.beagleboard.org/latest/boards/beagleconnect/index.html BeagleConnect
Link: https://docs.beagleboard.org/latest/boards/beagleplay/index.html BeaglePlay
Link: https://github.com/Ayush1325/linux/tree/gb-beagleplay Github Repo
Link: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/BGNHBVKBO7OUXBKKBZY6BC2CO3EYZCLE/ Patch v5

Changes in Patch v6
v5 -> v6:
- Rename compatible to `ti,cc1352p7`
- Fix formatting
- Use kerneldoc
- Add clocks, power-gpios, reset-gpios to dt bindings

v4 -> v5:
- Move DT Bindings to net
- Rename compatible to `beagle,play-cc1352`
- Expose CC1352 as MCU
- Remove redundant tracing messages
- Fix memory leaks

v3 -> v4:
- Add DT Bindings
- Reorder commits
- Improve commit messages

v2 -> v3:
- Move gb-beagleplay out of staging

v1 -> v2:
- Combine the driver into a single file
- Remove redundant code
- Fix Checkpatch complaints
- Other suggested changes

Ayush Singh (3):
  dt-bindings: Add beaglecc1352
  greybus: Add BeaglePlay Linux Driver
  dts: ti: k3-am625-beagleplay: Add beaglecc1352

 .../devicetree/bindings/net/ti,cc1352p7.yaml  |  48 ++
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   4 +
 drivers/greybus/Kconfig                       |  10 +
 drivers/greybus/Makefile                      |   2 +
 drivers/greybus/gb-beagleplay.c               | 495 ++++++++++++++++++
 6 files changed, 566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
 create mode 100644 drivers/greybus/gb-beagleplay.c


base-commit: 6269320850097903b30be8f07a5c61d9f7592393
-- 
2.41.0

