Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C007CC03D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343577AbjJQKL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjJQKLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:11:25 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8CED;
        Tue, 17 Oct 2023 03:11:23 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5b821d9ba64so18326a12.1;
        Tue, 17 Oct 2023 03:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697537483; x=1698142283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TP+yHaT3MV6NArdvH5yoIRCANwfJASikQilnTxXadnY=;
        b=YAdE2agyN8I3RNeGQnjwd+2KHD413Rqrl4HZptSfGV3TylE80oFcJV+ypBhKYqx00T
         EJyJmBcNBZ3avJaXFeGMC5gohHqHQfBJSiDXPx5sqGikDYwaUxg0TSMGaCEb6ZY5qxKt
         CY3Jee3v8j5Am7U0XvRGIRqi1h3wPi6xFKbDMsPswRSV1gc0mqOvr/vs9n32gLg1Bki/
         +G8DyPhQv8u12zy3acea+3jjVPLnK4y6nSpprblS4kRS/30NUl/QD9tkYVxlsznjFBYe
         WpNZJvquL8IR57NmFngOEGtFlhR/9AOBxToQIIMvUoSNUWHtB359+sIgIC7SdR4BrPaB
         NzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697537483; x=1698142283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TP+yHaT3MV6NArdvH5yoIRCANwfJASikQilnTxXadnY=;
        b=l+Gl//NFJ6b80r+vM7Erekol8H+xdtWUJeLJ2+1IK4Teq4EBhh6LNnhbCWpfT4GEA+
         9KmXixNdXSyC05esCp6tXv+tPBGXpx/3/sHuIU1/xScUJw7ALOD89Otu7uW/5+2tsPXs
         DDOvbuq1cHamjOBPtFjHQLD76TtSC2NdDvNTGD4QCos+QIlXOD2Mi3LtPdWpYFf1Ta0h
         LVpK8AY8y/INbqSqKrd4nl4ptTvcYn7va+QKoEZdPT1Ftuod6F4e7QwHz3cdpfOppjfm
         nnQY9nQE9WXsqCIHuYERljYogZfsyME5s4cuflGP6XecOMRstB4TRMSMTylUgqxylsMJ
         MvlQ==
X-Gm-Message-State: AOJu0YzO82AoDovVVZtRRM13jT6Dy2h8XtY1lGD9+fvrq/Kh4J24/K2x
        3JgufGRzHjZswbmDmrupUIQ=
X-Google-Smtp-Source: AGHT+IFv5Ij+lYOunw/pXkSzHDIoX8M+fWEaXeai9SMXKos/VOq7HPRDaYj9nbQKVbQcXvs0HxdQrg==
X-Received: by 2002:a05:6a21:3b46:b0:171:6b28:75c5 with SMTP id zy6-20020a056a213b4600b001716b2875c5mr1404253pzb.56.1697537482804;
        Tue, 17 Oct 2023 03:11:22 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001bbb8d5166bsm1127634plx.123.2023.10.17.03.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 03:11:22 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v9 0/3] greybus: Add BeaglePlay Greybus Driver
Date:   Tue, 17 Oct 2023 15:41:11 +0530
Message-ID: <20231017101116.178041-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Link: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/5RQV7OG5KI4BQWRN5ZCGZIFRMM6ERKPP/ Patch v8

Changes in Patch v9
v8 -> v9:
- Some capitalization in dt-bindings
- add reset-gpios and vdds-supply to beagleplay device tree

v7 -> v8:
- fix clocks
- fix reset-gpios
- depend on serdev

v6 -> v7:
- Drop speed variable
- Fix commit message
- add clock-names and descriptions
- fix power lines

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
  dt-bindings: net: Add ti,cc1352p7
  greybus: Add BeaglePlay Linux Driver
  dts: ti: k3-am625-beagleplay: Add beaglecc1352

 .../devicetree/bindings/net/ti,cc1352p7.yaml  |  51 ++
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   6 +
 drivers/greybus/Kconfig                       |  10 +
 drivers/greybus/Makefile                      |   2 +
 drivers/greybus/gb-beagleplay.c               | 501 ++++++++++++++++++
 6 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
 create mode 100644 drivers/greybus/gb-beagleplay.c


base-commit: 6269320850097903b30be8f07a5c61d9f7592393
-- 
2.41.0

